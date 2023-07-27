Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D552C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 09:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6AB10E55C;
	Thu, 27 Jul 2023 09:49:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E1110E55C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 09:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDrXJLIg4bcMXB0w/b13gehSiDXVju6IPbe4lNvb67YAYWQ4g1wb37DfTxO5W/oBbI0qQ11ZWnCgng8obvATp4g16QY6m6p3slxo5+sBt3ZTunlgwILfLP1vUnOarl89IBHcLtHOfV0YGqiUa3mQr0h5W84mFYWTZZ7nSyX36xgvzENkN3sR5w8WRwBf1b8mr4ae4P/Iu0qw7CIS4c4I0jJRIGEkEkCWhQyBj6wOceCWxpFfCr2PJ8jj6O7c0U16EQT9QvDrC2L4LxeJ+fBSUqsKWKt4D2mADYAmqNQYtBDfOKGU/JE1RIM6CUDjErVAoyJwqFpOhOa5+E3HP4ZGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SgLlrBs/VoVa4XmeIfGxnNEtmPR9fPzKF5olQiOZio=;
 b=KNCEXrqK/I/bT+l6wb6Ams6UMBeK/FfK7p5dGl4x8OlhJ7LZJ9md7qOPwPdLcHC4izSY2sYDNIar3icpY3KnZVU+DBfTBn9jFZui/xs4VkYlF3zveOmOqBPCd7RbDCTxo/RG3tNnD6pK3JB8u7Lai5nkQbsGJGWbeinFYEHEkcnWpPnPtwmQsH/EWvD8GVoIGbC2wO4V50olA9vbBWSLs9hkrqGvPxR61vp0kHb7PXh9n3ggjdopDOEZ58C1w3PXUZWSdr8JLArmviskUTgyHlCvWZOtH2nOFP5Hm0ZWu8fTEH3qkFFGFdXw8cEwXvNv+vh8vW0DYU1e8BZ2BZ3lCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SgLlrBs/VoVa4XmeIfGxnNEtmPR9fPzKF5olQiOZio=;
 b=iofbp8OVfXBBuWcqdNCGZ2j9TAJF712dgh0/LQ5qi2LSwYF3Gv7WGzMtdENlH+lYYmC+2H/6ZtAs1UbIhmV568LCgRiolmAJsS5KXnCl9vhc6l1O7uZ0fquwWc5icostOKYGmdenrM14W5iwDbPER1Up02PCHWFbrxCy1W5iXTk=
Received: from BN0PR04CA0051.namprd04.prod.outlook.com (2603:10b6:408:e8::26)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:49:40 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8::4) by BN0PR04CA0051.outlook.office365.com
 (2603:10b6:408:e8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 09:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 09:49:40 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 04:49:37 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable SDMA MGCG for SDMA 5.2.x
Date: Thu, 27 Jul 2023 17:49:22 +0800
Message-ID: <20230727094922.1958587-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca05c97-8a07-4f91-31e7-08db8e86cc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMGSZCTmNcJNtSq7JsmMHrofJwx0/jBSBb29w90hgYR1K/MjYZ5j4nBqElLr9sdjO9JI7vHjBxrY6Ne2kx3WxAtGiquxCixTaFIkpbh7qLns/DZXzyTiY6Z0qpR2EX/urc5wKH9dllABPQgkgJgY5dhhDY1HHuLFkkv0J/ZXt6KvZepo3HWo16V/vBV4lUQ0fG++ZEADmpt6dZLzRc8fQ2ceXH1UbQHp0GKDY1j5yojKfaE82wyDS0+rOyB2+OdgHMQ0IAKo3SQNXtNBEv8iMxAeMa9F6BllTbVSrc0lZyTa3CPF6G+Qbp72Gw4MUYMjtgo8FeauPqEs/lBgo+cQvjPjliL71mbP/AmUibEtntR7NzJafA++AZb9fkzCB1E76JBdCA6hSnaXdZGH2qhjngnnW9n63KLSQSrk5vBx/bwsIIVXkRdaiNFf95OT7C1lCfs7N8xWbDxUFGFZzxMFWSweV75SCl58CiPjZ4lI2CmgNp8Uvq5bExjFAogOdtDyFFZiz9jDDO1hakGwVhQU9y54OE3i5nb4UMYvcNKNUuHppAfrjH3rW3FHGTZ3uEVzqPQio3MjFD+S0tGNC/ydz1dOcZHYntNLx1e/tseOl+RrsFXXfgcGxJYG9Z6y2680nyE03zSuSoDl7mS2NrZSZOHiREmC7dX+Dc1SesMe5ufhbtEKVdBcbQgXktiQa8Bt4G3WJoUpcBDSrx7qtnvHkmA/2daALjIL40KRNmvUyB7R1u/tqIc2m1P4l+6HTkVlrpfy09GexDKpRwoBKGqL6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(316002)(8936002)(8676002)(5660300002)(41300700001)(40460700003)(36756003)(40480700001)(86362001)(336012)(7696005)(6666004)(426003)(81166007)(54906003)(82740400003)(478600001)(356005)(1076003)(26005)(16526019)(186003)(2616005)(70206006)(83380400001)(70586007)(36860700001)(47076005)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 09:49:40.3946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca05c97-8a07-4f91-31e7-08db8e86cc1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
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
Cc: Alexander.Deucher@amd.com, shikaguo@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now the SDMA firmware support SDMA MGCG properly,
so let's enable it from the driver side.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 27 +++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 877989278290..e768ea34a2da 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -902,7 +902,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
@@ -963,7 +964,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_ATHUB_LS |
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_VCN_MGCG |
-			AMD_CG_SUPPORT_JPEG_MGCG;
+			AMD_CG_SUPPORT_JPEG_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 809eca54fc61..9779e146d37e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1571,6 +1571,30 @@ static int sdma_v5_2_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool sdma_v5_2_firmware_mgcg_support(struct amdgpu_device *adev,
+						     int i)
+{
+	switch (adev->ip_versions[SDMA0_HWIP][0]) {
+	case IP_VERSION(5, 2, 1):
+		if (adev->sdma.instance[i].fw_version < 70)
+			return false;
+		break;
+	case IP_VERSION(5, 2, 3):
+		if (adev->sdma.instance[i].fw_version < 47)
+			return false;
+		break;
+	case IP_VERSION(5, 2, 7):
+		if (adev->sdma.instance[i].fw_version < 9)
+			return false;
+		break;
+	default:
+		return true;
+	}
+
+	return true;
+
+}
+
 static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *adev,
 						       bool enable)
 {
@@ -1579,7 +1603,7 @@ static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *ade
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 
-		if (adev->sdma.instance[i].fw_version < 70 && adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(5, 2, 1))
+		if (!sdma_v5_2_firmware_mgcg_support(adev, i))
 			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
 
 		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
@@ -1653,6 +1677,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	case IP_VERSION(5, 2, 5):
 	case IP_VERSION(5, 2, 6):
 	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 7):
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.34.1

