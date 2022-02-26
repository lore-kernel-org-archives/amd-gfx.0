Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41D4C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B2210E2C9;
	Sat, 26 Feb 2022 15:42:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D6F10E2C9
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAHFRLKVGzMmvHyqrILQG4Lk6lYzJOy/QKkrRZrjJTl/dH6yxGLcgG6uEv+BWznDVHrA/92RFskIqFk1zZXc72FSvzqQSv+otOQLx1CMW6dbHrEVWJYU7+r7WZMuDJk+haLdo/wHJcOlGRzm2+UTU1qCYMOUApaxjeHkf6wgjJ4hsZ/CmVIGSJhi8JYKUAId7TWHoDOrDQQpO5hT1e9HuFmbIrA21G81hMZncTCtr27a4XnoxOW3CAfICKMoDBEQ2SKcE+501yOxY2AteLNYRyL7hx8zspMGTCEqld0Khf0HvadZGpQHyJeapjyOm76mKhxJz4g/mA6a0qeT9eH17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU0Gb3vU5XibhV1qmrZTX2zs9HW4FegEdBxQd7KzY2o=;
 b=ebd0eu1AxJ+AuJ6V9POMWLAUp5gqbHYp7WCAcL/He9biNpEPTZvakCrug2usgZstWa0ohHSOZ98znQGr9rjaMlHV3jWxJozly+92nDO3CfoNdKwWHzj/iGSHmMrPuKnboDcY9q+aMg/pH1StdJGh0sIdNmfoPtxfwM09jPSX//5O8jBt9wM/YQQHsOO36oJb639P0s4OJzB1u9bxPyBA+T2Se90o4TNtX+TKE1JfijsIKDlges+KwL6S9pcwy1uzXz0OCTWAywQpHlhtfv4cE8qC6kL0JY8Z2PYFAc10YZ7FABoPQVoLDWTRWVxfCTu2kPu7x7DK0vmqhe3ZjIyX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU0Gb3vU5XibhV1qmrZTX2zs9HW4FegEdBxQd7KzY2o=;
 b=HOYaLeC+VtkW3JT3vmgCjSrms47yRjSpi9s5Dqs/FvFOIRvDMZhLZBaRoyjquICplRU0n4rmwyZmRxBVoJowPRM9nUofxwCOu1vsGqpLgsZkUOJVqVpOJltf+u8hOtjjJ2NPYOSo3wkdgx5z5BFE9e3Gv3W6jCVgvbKSVf4TQec=
Received: from BN9PR03CA0785.namprd03.prod.outlook.com (2603:10b6:408:13f::10)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Sat, 26 Feb
 2022 15:42:42 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::bd) by BN9PR03CA0785.outlook.office365.com
 (2603:10b6:408:13f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 07:42:40 -0800
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:37 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: 3.2.175
Date: Sun, 27 Feb 2022 07:41:17 +0800
Message-ID: <20220226234117.3328151-15-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 294552ed-d367-4325-735e-08d9f93ea002
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4365C318E7502C6273C8F145F53F9@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ccXDILVKAM+UHBrWLPPyR3maN3+s3iuZPV8jdubHoGoeImCFvHnjzLFX8b4GfrRkJAsA2827zRhkRk8y7DTYG7tObc4+3g96uncRF3cUjx2Hg3x7UNWm+sgtlGd4kUpRoAHiYnafc+a7wIcwcW/binWRcir9QA2nMpa2xn7zQwhI9j6wDPWY2wEa0I7+H25Huojzkm0mB8k7DD4cHrNnknU5btUj61zTq+O3hlpDbwe6h+hK9BONga59EwJfWjtLwxWPLfXLSGEw9SmM+oRPq/7txo6Zi1rBd9QHqCc5my3VXHWCfC4IrmeSIKa8oD8jhrY1GNEn0hPlhqqQcVfQZahaMet+ftyGMzqcZLBqFEhxDgFaLQ0ga2EKZ//qWvopRYQ73fQ/3xp+yrS+EadmCC2AEah4PxcuTQr+uH7k4XY95REBqFwQa4LxrqzVK7K38sOzF5eBVWuWtOrOnEvBNnhb6f77qMoi/qq16vRLfwmpAdyPvG/gGlIItZWFM3b4TLLiPvzMkNp8HI4Pjr8w4P0+5VswNtGMuG1ypvQ42M9UXXl5U4Yji19szydQzbieu5MEaQNe6UqnpvDf5trpHqE45RhaOe1OU5eGfu/M6Maku57zaBDHFTpyWCeuTMi+Zsbf4AwaY8n5DoussVLHzOqvceDhkHCk07m5tO7hEGkGog6t1mdYvYShj2KFYT0jN+SyWOLmW1wxMAniZryAhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(356005)(426003)(336012)(83380400001)(81166007)(316002)(6916009)(36756003)(508600001)(36860700001)(47076005)(8676002)(82310400004)(2906002)(2616005)(86362001)(4326008)(40460700003)(70206006)(1076003)(70586007)(6666004)(26005)(7696005)(186003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:41.6658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294552ed-d367-4325-735e-08d9f93ea002
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

drm/amd/display: 3.2.175

    This version brings along following fixes:
    - Remove invalid RDPCS Programming in DAL
    - Make functional resource functions non-static
    - Reset VIC if HDMI_VIC is present
    - Add frame alternate 3D & restrict HW packed on dongles
    - Reg to turn on/off PSR Power seq in FSM
    - Modify plane removal sequence to avoid hangs
    - Pass HostVM enable flag into DCN3.1 DML
    - DC Validation failures
    - Program OPP before ODM
    - Refactor fixed VS w/a for PHY tests
    - Pass deep sleep disabled allow info to dmub fw
    - Refine the EDID override
    - [FW Promotion] Release 0.0.106.0
    - Add verify_link_cap back for hdmi

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index febdc5d00a70..333f4a49cacb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.174"
+#define DC_VER "3.2.175"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

