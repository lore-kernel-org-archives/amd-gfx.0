Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9347BC04A94
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 15:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D429D10E44F;
	Wed,  9 Aug 2023 15:07:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C6910E453
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 15:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+eYLyq5NDpfyzwN23jLfiefC37BAwR+gJirE0ucZgmgp9KXSGfCNlgK9oSPduizUtEQFyR5RwDlABFkgUP4KwsgdltGQU5W2MTUKY/J4gaSlGdImUR44dHV8AwQZnCMN1YxSttH55YOX+qhEAodSWlPHf59UEutBHhoU0nepRnl5vy+lP95mlXcRWtcShLbykEWsrJQtVLyjew1uiDdNXuemqkB+/jfjLDw70V91ib5nnLmQornNZJqmn86gfHyL9zBjc8vXlRq0V1kEPzMFGev39cimT7/EAdDNM6/UdsKWc3t8GB3xOtQD/nzfMVdoMboMiOGfBZgafh4AxxkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5zEpjTWMdUzvza59MQn/n9n8IEUxNnwjKZZ4N2CRdY=;
 b=mznjFUcXa5bD31b9CofPp6hVEBib6zjdqf3qNpaYtDZJcoz9A9vhD/A1M9D73UkzwpJB7Ljdinu/fT50tkJ2kWWZ6VyZSsZNdoGmOTn+dIj/BWknpqzn532lzoVhLBWr8AQxkD1FafActX2Ci/qa5UxpJZxynVjJaAA/Bbvqdmbbsa3SSzKbHq4YP/6xx+dFlFdKaGFrWja2/syefJEkJInd/5Z9GjrvTyImQa/AiKKNbjUU3NROtqFlBX5p9C2EcUuXC/xWub+mGxvsoqvQA+N92z3liRU8DhYDDfrR4J6rJWPMIMsQXjUOCpxDCc6K+AsrlqwxN6Yv9PUlsTcLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5zEpjTWMdUzvza59MQn/n9n8IEUxNnwjKZZ4N2CRdY=;
 b=JBnN8QPSFUeLLPPMNH8qd8rMfWKUWaIA1B6N8EjPQjjF91vPA9VsLiu7l5YZwXil/FXJ5L78LnR9RTLGpvpjD0YeAhRaubrzYMOzvi/LdU/+vt/TIb8SKDqcIJfn0BOIuOgKbdOYaumIfo27JgIV3lQNgnwgMzEZcK8t5xoxMpE=
Received: from CYZPR02CA0018.namprd02.prod.outlook.com (2603:10b6:930:a1::8)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Wed, 9 Aug
 2023 15:07:07 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::19) by CYZPR02CA0018.outlook.office365.com
 (2603:10b6:930:a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 15:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 15:07:06 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 10:07:02 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/15] drm/amd/display: disable clock gating logic reversed
 bug fix
Date: Wed, 9 Aug 2023 23:04:52 +0800
Message-ID: <20230809150620.1071566-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809150620.1071566-1-stylon.wang@amd.com>
References: <20230809150620.1071566-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 755ef415-c6d1-46ea-c56d-08db98ea4c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zvc1upB9fBPCjoVt0BYFa0nm0K43LkUVNByJU2VpvJ0C0heRYMeUO2NUC9WOQQj+1AHPTC+T41qp0OBX9nbV4jL7zsSWvjxhC9mnLmnLUqQN/h1SA2vrNx2T3wr9OmlIzgF5QRFknQflYxxweBOWo9iFPnvZ3dd1s1v5enaJmMVvmMUs+V07A0aVhUSfRwSUC7gvn6Y4ES6OTH5W/AmMrHss5GOpIT1DykovKa0t68LuglHnU+/hHr0OC+uDNwTx8IdU8q3KueEFFzFk6SSjd7nE5jjvQlHCJehF42qPJgE7joQS9pQJa+nikfeF/FGe8V7NFRK3zeDo46SfmyCXhTBecLsVhvT1ipEghcUuGa5XtIKZIP2GUNJWYLvBbw4eVXeE+a0nYYhkS/tlOsLm1kJeyIRg5kf3YjgwS4R3TOSl/YceZs7Jr1ne6uHaGKajdDhduwY+B0yp0pTSFbRad2ZMHQmAUj0ONl+TkmK/0T46EbTxr+MoMQX93H7opGzqjlvKM6vIpXJIYWpSXS3s7xS2epTXargLwOzwQXjapCzJqj849682RWEOW/kulhnrpRV7o85YsKYHX+AZsTfYJLq/uIoSW/UILrI2zAS7TcM70j+75jvjj60kc56dhnSlGQ7BBbv5n6QmDAGZGMi6/KKV/+hb3Kx1xs7dauVNtlsbu+63IUvupQmw9RtYfhd0QmUML1Rc1dEhkk/yQk12Us4LCbnot8pyu6yHhv2SUEmt3eOJJzeMCC26ft/iml1MyrfTUpdcE+dsQRRE1IOGcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(1800799006)(451199021)(82310400008)(186006)(36840700001)(40470700004)(46966006)(40480700001)(2616005)(40460700003)(1076003)(86362001)(7696005)(356005)(82740400003)(81166007)(478600001)(26005)(36756003)(41300700001)(5660300002)(316002)(44832011)(2906002)(4326008)(54906003)(6916009)(70586007)(16526019)(8676002)(336012)(70206006)(8936002)(6666004)(83380400001)(47076005)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:07:06.7638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 755ef415-c6d1-46ea-c56d-08db98ea4c0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[Why]
disable clock gating logic reversed bug fix

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 7445ed27852a..1f4e0b6261ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -1018,8 +1018,8 @@ void hubbub31_init(struct hubbub *hubbub)
 		/*done in hwseq*/
 		/*REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);*/
 		REG_UPDATE_2(DCHUBBUB_CLOCK_CNTL,
-				DISPCLK_R_DCHUBBUB_GATE_DIS, 0,
-				DCFCLK_R_DCHUBBUB_GATE_DIS, 0);
+				DISPCLK_R_DCHUBBUB_GATE_DIS, 1,
+				DCFCLK_R_DCHUBBUB_GATE_DIS, 1);
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index a18b9c0c5709..8bfef6d095b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -955,8 +955,8 @@ void hubbub32_init(struct hubbub *hubbub)
 		/*REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);*/
 
 		REG_UPDATE_2(DCHUBBUB_CLOCK_CNTL,
-			DISPCLK_R_DCHUBBUB_GATE_DIS, 0,
-			DCFCLK_R_DCHUBBUB_GATE_DIS, 0);
+			DISPCLK_R_DCHUBBUB_GATE_DIS, 1,
+			DCFCLK_R_DCHUBBUB_GATE_DIS, 1);
 	}
 	/*
 	ignore the "df_pre_cstate_req" from the SDP port control.
-- 
2.41.0

