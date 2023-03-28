Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B164C761AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8352F10E1BC;
	Tue, 28 Mar 2023 15:21:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193AA10E1BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsF3GboaTiKoUgjpywqQBMtIVwxPBSf2eiON2gFGBen0wVV9RZIO5KrxElUOO+7Z8NItCfv9ld+NabhaGRR91HZZUro+mUx6nXMkdl+zrgieChNqltpPEZyZdemI47TBQ91ivli358judUY2Rh0Tv41t7BLv1Q+kmMKSjEr0WQO+IV+RjkfgzlfQJgtAR404IY/9OsWtozrCQtQDDsiT8SfAZ3i/sHya2LYC59aGzgQBdVlEXvP31VHRGe/NG/sF6awicmCwd/E6tBprogK/eyWCf3P/wNk0C5S9v5CfRbV1uhL/kwgLiO8Ex+cb1qx9OrOatQWFCQqC4OSeW92FYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU2rk/KGYVk86TeBcIDSWsdclsXHlAQ5zTdkKX6vl2A=;
 b=alJHm0q9zebt4/nX06gHZgrTv2imaD/OclbEKpZu4yqegkdlryLAy7CPZJO71Dv0+vZ5lcjel9iEx+S19Skfntn0vZJYJaqi8oJ5l6y2QD5baDbsiKg4wesiIoXWV/IJOChhMSNjEwFU0frF0ocVaNbTL/kjj41gbTMCN2Hy4bYNLkZX2S0pxphbGLULFScNsXgZwj0X+/eSkRTBm45SN7W32b6if/QwyvsogRYC8b0Zaq10G2vafEXL13P2zyZBoDQvdEij3N+L5FT7WlOShGLPV8YT937iIvl0lYLmB/ym20RftAZ/FcZrU65bBJj6W1gQW43EKrqEz/nSBG9uDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU2rk/KGYVk86TeBcIDSWsdclsXHlAQ5zTdkKX6vl2A=;
 b=qvcb+jhzGkXZ7+f2Ssip3BTC8AdbuaJIUK7IjIZKARyexh496KtmtJLUIa7ZYmpBZMYgv5ZYdqb2jMVLVGJk7/Sv0m5H2JBV4cMioQT0oeYIvNqTsFA+TsB4eqia4vxX5w3byXBudx5NtO1yDfjAZCcUXpxiIAFsCxDlPKb+V5E=
Received: from DM6PR07CA0120.namprd07.prod.outlook.com (2603:10b6:5:330::10)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:21:00 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::8a) by DM6PR07CA0120.outlook.office365.com
 (2603:10b6:5:330::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.29 via Frontend Transport; Tue, 28 Mar 2023 15:21:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:20:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amdgpu/vcn: use vcn4 irqsrc header for VCN 4.0.3
Date: Tue, 28 Mar 2023 11:20:30 -0400
Message-ID: <20230328152036.1934902-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 387e056d-60c6-4d44-eb00-08db2fa009a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82VRp05nMGmbtDLB4YDxoFXephW6RhJnan0GPWjbEctCaIem655xBXPZ3Ut32HBmLg6C6kWlmznYEOlxar3vCiPvIWu8xq88bAXxu5x1VxkyuMuoZ7yI4U1pENhFHLdX/Jz3xZ72qgMLwLR9wamoCKe8/3d2VgC91yJt3SKnHJ9v84zrLWEGFs15nzFty5AuB9gV6yONjLPia3P+FZGdxoC9dy9jCNzpctZ659olu689YtNJblqbDEh9DSPxpe0bzToHABA6kdiDZqeh66ZqdaXNUf9kpXAAJXTlCitYwUsV1OExF1tfBba2XiCHzlAv3FA2iSnKyLotNCxb7PL/MiiWrv9Y+5Ddg9e44gx28hL8K1XQ60k7G2Mtl1O8h7YXu0Z/HFANLREOxY1itbiFVZm5vy7LOmK/nRIGv79/Y+7qR+EPIjUwk/BZvHeNmiHiPW4JRdAKe02hkNt+P2uHR1yhjaU3pIg/yEVuL2ux+qb8ts1Js6W4zEUuDgxZwM6sXWU+dHJ5Wwrmo7NRur9meR+K8zN+esIrrOduRNdi68LetJRSoK5U+gQmozCbzhkXDTi5Y+b/8+010ydgBqDKarC1W7W7Teq5D1jQud9hrfyR1bBuGe0h2b2yYxZLFs+Jf3sF9cuMiO5N5hmOCzbhdT7ZqsVodluuNarLITQhbvkl+MSGuA1VRJdpr4JIkBS0OCio5WW2Y/jqIkIEw8QOwcHtfCuZ4pSPKitoNZbL00U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(6916009)(356005)(40480700001)(36756003)(40460700003)(86362001)(82310400005)(8676002)(70586007)(70206006)(316002)(336012)(8936002)(5660300002)(2616005)(41300700001)(16526019)(6666004)(186003)(7696005)(478600001)(54906003)(26005)(1076003)(4326008)(36860700001)(81166007)(47076005)(426003)(2906002)(82740400003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:21:00.5351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 387e056d-60c6-4d44-eb00-08db2fa009a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Use vcn4 irqsrc header for VCN 4.0.3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ae2cc47d344a..fafce2beb6cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -35,7 +35,7 @@
 
 #include "vcn/vcn_4_0_3_offset.h"
 #include "vcn/vcn_4_0_3_sh_mask.h"
-#include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
 
 #define mmUVD_DPG_LMA_CTL		regUVD_DPG_LMA_CTL
 #define mmUVD_DPG_LMA_CTL_BASE_IDX	regUVD_DPG_LMA_CTL_BASE_IDX
@@ -104,7 +104,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
-		VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst->irq);
+		VCN_4_0__SRCID__UVD_TRAP, &adev->vcn.inst->irq);
 	if (r)
 		return r;
 
@@ -1380,7 +1380,7 @@ static int vcn_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 	DRM_DEV_DEBUG(adev->dev, "IH: VCN TRAP\n");
 
 	switch (entry->src_id) {
-	case VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT:
+	case VCN_4_0__SRCID__UVD_TRAP:
 		amdgpu_fence_process(&adev->vcn.inst->ring_dec);
 		break;
 	default:
-- 
2.39.2

