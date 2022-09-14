Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DB0ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D53510E851;
	Wed, 14 Sep 2022 05:19:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90C7F10E851
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3973Arv/9GQaxHMXLB9yLMbcuy+0F+As2suOovWh9mqnSsejKBMoyY0Iz4E/QwAoRPkGqPNxuj2eelracLSnDhWums87DAEVlPAOpc6a96y/f8yJIV8JLa6hBcvtizuEhEUSPNjBC5PbjZz9P3yw93edwsZUHXvKIF/czTtTEOPSJop7NLsejlmqVxmQjvLX2i3XWs+V7apGubn49hWuBSqQ/5JzOf39qpBsh45aDphZtwgiIV7Xx/of3Ft/bwaG/4q0twPt795+htL8sBQZVerQcgvW6bZl/2gtq51Ob+h8MPI2VtyvGydmoSi92SPyNGIVq7RoC+fC7IXlpjDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leWVn4US5H5/PRSYb0pja9bAqyM+cJR2Q5GX8S9Zf9g=;
 b=D4znFhBKTI+3QAE8ajllUxGCGlI4Mm/cPFIH3xZBfg05BgOQE2x7m35b8T/Kg8wQTbRqXu2q4Q/HflzCBKA0vVk8fd0SlvQMbe0y5lNHQOu2Nxfh1ECXS3u4o4Lr3wHUKdLWwQgHjdcZNgjRvcW8Xmh7afdjglH4fYsgs++aLpeQmFAAPx6DYFaVxfLDrN85tY7ZcXwddE36gJNxzweyBAaFv5mdJ68/rnoBvb7LUQKEH4VPoII7+B5ve7ROFJVlmduXpBk6V5CJ/tmBSe99a0zefU2Fq2qZatea8ySej5ooxEdT+BQmj0MCZ12XBDEwn5tWAlV4JKn9w1Neb+7d7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leWVn4US5H5/PRSYb0pja9bAqyM+cJR2Q5GX8S9Zf9g=;
 b=ZFZg8zxLsKqUpH3tGAzrDXCZhWBdNYPGzrLktj8oOtB6o5X0354FI1IrkXkLh/zb0xN0gKis1fuxAz7jgmcNRooJgyuNXwmti+a6QUEHyi0TIG3E5T/bO8Vs/uZFn15wjFn6TPlLWGf8nMvSxwXAhPDAATEhZs2bceTcs+Lv9cw=
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Wed, 14 Sep
 2022 05:18:53 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::b7) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:18:50 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:18:46 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 41/47] drm/amd/display: log vertical interrupt 1 for debug
Date: Wed, 14 Sep 2022 13:10:40 +0800
Message-ID: <20220914051046.1131186-42-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 158b75f1-6654-47a2-7cdb-08da96109d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQL8wjeB9U40Fr32xyYGPfNe63lO9c8jWrCh5jC2C3GlPK9woat52xpHPuEMqCcOZW0mbWgp/Uwdsrs8QYlSfO4jXSjheEXvGYcpyFSrPiQSmVcprcG8Wr0j7RdnF1myTwDpYTocGF7YVNDZC9KBQg/rbjVtpSFaRJrONB6Z45M6DJ6oiYT7HBKQWRB0llT/n1gfdHyL631NZS8iNfunCFGQrpBfQ+sPk9b79NzkfmLQMieHqPjMcKsjhIXhnisAAXW6IeYvPSkN4M70oDuLbIAdytNd954slYAlhbof5i66BtdgMmm6UDMky1az9XHyQsAiVzv9YvCeX6cyZrjJjpofxyze8JEsMZj9fHjLrr3E6YuEpBJcnolYB6KDI4rFcZDASF33d7Gk0BDZuR56BH3J3+TMcMSmSgJsyaQnZe5QmBxFV5Y8EsFliyskY2G8duBQvCqyOHwVD2xJwmwMzNEVhpBhxudpcOM5Bq+QQLVbFouWmoy7ZFobO8T5bIu4FvOOCC5TkCqA5m9WWgdcjX9vz77UG6w3yT/A6jQKnIlIWlFa63YFq/cw/2d+qSmKpV1JBUCluwl28kAXNdkNbBXGbkjoxpjPXLxE6Au7IA94I8e3ob+AypkZvAbHuSw1Q205cRSjtsXKH7ZfaW15t//hlAPin/211ZwPJNB6HtqX+WzynE/l8HGbkC1p+0n93VREM6XbFMrbZgjaaNep0KQ7MJzAxVOKBfIKGczdTKFIBQtke3KXoQe6EA/XNteehKqJ0OYenm2GoiZnTy7n60K2Z8FtU+KYD5BnLzDo5pHvEWJm6WZH+/iDsVN537mv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(7696005)(2616005)(26005)(6916009)(82310400005)(2906002)(426003)(1076003)(40460700003)(70586007)(356005)(81166007)(8676002)(47076005)(70206006)(186003)(86362001)(8936002)(6666004)(316002)(5660300002)(40480700001)(54906003)(82740400003)(4326008)(336012)(478600001)(36756003)(36860700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:52.8990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158b75f1-6654-47a2-7cdb-08da96109d55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Extend existing OTG state collection function to include the vertical
interrupt 1 state.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 294827906c69..ea7739255119 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1393,6 +1393,12 @@ void optc1_read_otg_state(struct optc *optc1,
 	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
 			OPTC_UNDERFLOW_OCCURRED_STATUS, &s->underflow_occurred_status);
 
+	REG_GET(OTG_VERTICAL_INTERRUPT1_CONTROL,
+			OTG_VERTICAL_INTERRUPT1_INT_ENABLE, &s->vertical_interrupt1_en);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT1_POSITION,
+				OTG_VERTICAL_INTERRUPT1_LINE_START, &s->vertical_interrupt1_line);
+
 	REG_GET(OTG_VERTICAL_INTERRUPT2_CONTROL,
 			OTG_VERTICAL_INTERRUPT2_INT_ENABLE, &s->vertical_interrupt2_en);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 3fe5882ed018..6323ca6dc3b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -583,6 +583,8 @@ struct dcn_otg_state {
 	uint32_t underflow_occurred_status;
 	uint32_t otg_enabled;
 	uint32_t blank_enabled;
+	uint32_t vertical_interrupt1_en;
+	uint32_t vertical_interrupt1_line;
 	uint32_t vertical_interrupt2_en;
 	uint32_t vertical_interrupt2_line;
 };
-- 
2.37.3

