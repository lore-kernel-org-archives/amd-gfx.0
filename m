Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439E5ECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA1610E9F2;
	Thu, 22 Sep 2022 00:19:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F33710E9E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA3k3rjxb2c7DZ0mZ/57hgzKQGWB+GXXa6H1e1lFZnqMiOmK4F26QXVDnr3nXjzjLpRhVUsablsYhuYR+jca+NSeZkvxz1FzGiJQL5VjTcfVxHY5v9KKirZgpDJKzsxgfE1stP63ESLJ6H278/FBiuR3IzTM1mfxRncvzZCmJ+PqRMG4q4LGPRUzHnKfP9FBw94UTEaQ7xcRukWiy2LaHzZ5K0bWqAlJ0HIuqrn6ufLoT0OkqpRi9fNefmW90gjcsSb/2q9A1tKnbW1duimphrmq+6coZvKgpTx5FdhplRQI5l33DKNxFZxisUnT7YEuNMnF9+tBVYqwjCmcddXvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnf96KBeIpc7D6wZ6Bx973eUaLz9j/VtQFHa5v0fOAA=;
 b=Q2xKzu7OrOStb1q7V7ky6WY2XLhgyrtXfKFkeZgmZRXY93jkQIyIoc4zRmKPzyHbdfAHlzupmMNQGgaE1oGJnJNw0sCGIPKcRyK4Uz4bWn+pUC+GJjj6l+wn6NZz4KB6gU0O+9HZQy4+WImJTCXgGhJqj+bWYtINa76tp51Rb74IoX5ltpAhlry7re2pF0/xxFsN52PusmDMZgCPn1HJnqE8jJm+HvVMr2CkIj4YOFCuCn1BZM7Hl6v7do9NCzlCeFJ/Uds8DLcvIVQKau34LT89deQrgTDGA4eM6i4lDFjry1/ZFAWxQZ9r3lKrA8b0cpvAx80fZuzWE7Bzydu29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnf96KBeIpc7D6wZ6Bx973eUaLz9j/VtQFHa5v0fOAA=;
 b=bpZlxNZvYCEFm1pAwqMZeAwH0VoRd2nVGLXQJCn/aco7YbQIxRIqriUBzehWCTK4JtAdgDEOftyPGk3gCgAFCxHTYnnDCAJBuXI1YhWGqIyw76a6MPRyvs7UxN4pgwxSuXp+FzB7IDlJ4AkpdZ+7D84Lr7Bi3R7iC8jhl/G6RCY=
Received: from BN9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::22)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 00:18:44 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::c5) by BN9P223CA0017.outlook.office365.com
 (2603:10b6:408:10b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17 via Frontend
 Transport; Thu, 22 Sep 2022 00:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:18:44 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:18:41 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/31] drm/amd/display: Update DCN32 to use new SR latencies
Date: Wed, 21 Sep 2022 20:17:52 -0400
Message-ID: <20220922001821.320255-3-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: f1686dee-4ba1-4a8c-5484-08da9c3002e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pxns/feXIpsinkv3qPatJPAI/wR47ztNZmKCyKTvhBdDE6oZ5llmgLYOetGUkyRWh92q07vsR0C4UXN2dLAHdJ08UT61HyeMU63HNK+2wcv3dmm6tSxhnkoSNsKw89rfqb07l5u4mc2aP3duxFHYXTOy7VttKSRxcuUBRyArLNK+UZ2AUb5Oge0t8X140ug82nc6f+rbNemyXL7/RH4uCM6LY1WRO1tkALADrVGmxjxz/KPknodomGNa0r9aEpMIfNiyWC0mK9+JVf/N3R40L6qlovGPszajLTFchB3yUOIyRdJtvwk6SIIWSc5V4lzDyHZyX1cWkfM7ykKyl8LosSya7MYBTTDRQwvm0we5PaaskMSePH0GErQyhiDrBI8VLspr+CuwxxuXRQsD0urC5g398FcamTeKjJRxuCjYeBWYmU1wUmxxRR5GEyA3zRDUrndhNH8FEKmpY5X06sDo8F4CNr/4GFdaQmnUA3FGw6IPutGSdAQiNZATOB4Bp/K1JxkcWgjA8FrzvmTBNvhUpCDNaxkfwyl7cARS2ph/1wKDI1DAYehZpSPokcqLRuMcMYypFLnO/P3bBK8L2KEZ/ZNocD1EAg/sPMAGwrioFvMVM7VmMLiR45RpJff2wlIRIUlAOK7ylZk5QS6EPq5vAUMSUuR7BZzjXUY0qpsrnVOjB4Wv4NGkYidoMElRxtmR5X+8vWP569rDnUs0gbIrTtuveuKfS4WP4QijoMp4XnADyU24yINuhoDlRgRIlgWt3Q9YdC/97S9Z1H6N0u0Yr410wuwMhIH2C3qzRR229u4eeiwekTSK9VIzO4u+jgW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(36860700001)(82310400005)(82740400003)(356005)(70586007)(54906003)(41300700001)(4326008)(8676002)(40460700003)(6916009)(70206006)(426003)(316002)(2906002)(5660300002)(15650500001)(81166007)(8936002)(336012)(16526019)(4744005)(186003)(1076003)(83380400001)(2616005)(478600001)(47076005)(6666004)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:18:44.6708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1686dee-4ba1-4a8c-5484-08da9c3002e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Update to new SR latencies for DCN32

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index fe0770038a90..6687cfed2ca9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -121,8 +121,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 		},
 	},
 	.num_states = 1,
-	.sr_exit_time_us = 20.16,
-	.sr_enter_plus_exit_time_us = 27.13,
+	.sr_exit_time_us = 42.97,
+	.sr_enter_plus_exit_time_us = 49.94,
 	.sr_exit_z8_time_us = 285.0,
 	.sr_enter_plus_exit_z8_time_us = 320,
 	.writeback_latency_us = 12.0,
-- 
2.25.1

