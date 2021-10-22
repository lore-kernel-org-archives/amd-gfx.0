Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37284C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F0660F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5F0660F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173196E536;
	Fri, 22 Oct 2021 04:21:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCE06E536
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 04:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYAT4YGIt0JynKlYMNXTqZNCu1OS8x1+HwboyGWzdn/qXnxTdMsDGYmSiwDKCu6quhEjohW9pNIFohaBq451v++hb1eJzOAGyfr8NKNaloMbv6MEzz7W0kjEcHFBM64w0zBiIUC2q99sgFnXJQcarOH5pBP6TrRGhuoVgAAbBnPtpRC/zlgFASuioqd0sCQPBPgj+eluOyWBPXgB2ttW61jH0cNmAtVes6FtcIIjTD/8ztqSxibng1rFX5+lftVlpPhC1AMucB48b4y8U7+1kVckZvemlmjeB6++nBOvAj8Q3kBKy8Nt3oaQ0112PSs3hc7Cs1yYHn0UmATIeEwzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcf81AAbC/X2lNVJs1vq5e1P4CM7kW0soZyB1qs3240=;
 b=C+j1nsJ4wiQrOu9AMjgzwRNucnYZuNLkE4pIfx2LiwB2dFr6qosKdAgdZCek2OoMiFKf0sR9dnbmNyBq2wDowePYb5ag+BOx1xYUIYWdIGHlYyhfeMf5fomLWq167N8Ou8sR76KfglA+0MSz1lRV4DghCZGbZwB5qoWTyWfc9qHJHxzW9nROwGaVKX1MubeXU+9Novc8o1FFVO3aqbs1YM/jGwNppVnA6IXZUOkMfS3p9CDl1X6NIAt1a3MwBAEvHdRM5KSZEDSAK/CRNvL6SSWTMZf0D+u7wlDHts0ZkLYWOsAxHWEnfPgq22f7zvqsZ3QCD6TUnKxmj0RodmVkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcf81AAbC/X2lNVJs1vq5e1P4CM7kW0soZyB1qs3240=;
 b=pil47LQc+qLfgnxp44EQVYbE3rzohhGoBatVo4B8D9gzaW4zJ0tUbI6UOBVxVkTOjIw/ohSkP/75Z0nJhjfkDFqHxBuhyWj25jsbtiijhDyIu8lB/vU4Zlb67W0mFrOVgADfhLcjAH0i183mm5D56QazUqafGEchJEQ8PLDHYlc=
Received: from CO1PR15CA0067.namprd15.prod.outlook.com (2603:10b6:101:20::11)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:39f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 04:21:01 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::8c) by CO1PR15CA0067.outlook.office365.com
 (2603:10b6:101:20::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Fri, 22 Oct 2021 04:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 04:21:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 23:20:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/nbio7.4: use original HDP_FLUSH bits for navi1x
Date: Fri, 22 Oct 2021 00:20:46 -0400
Message-ID: <20211022042046.959686-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667fb148-624d-48be-0900-08d995135adc
X-MS-TrafficTypeDiagnostic: DM4PR12MB5343:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5343CFF4B4C175661E27DE02F7809@DM4PR12MB5343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tD+ArznjB2K+y6KcKIpop++mFpsTisZHY2U4eMU8TFK59n9g0QcbRlNq7mWKfnBH1U6PmNTVbI4GfkenhM8PLM9dCJy0o1NqGayxxUdlIB+NyNw03cnGxqXwXK4j0eUuP5DxyR9ZLk24Pq7AfFL6B8gEbz7sI1C9eBZxpf869Z97H3t8UJwMrnMcAFpB4WDFkK508DIa3613bsywZBHQN2zCztXLYsPc6Dw5VJ2/On07GGmJZFjRe9utpcghISa9ObOP008VOpd2onbCSSXR0aatequEb/xHQuLo+6QkZOb0TNO7HvzdZwySoxX1a9lwvhgB4VI2rdwQUG6fxOT6chvjHgkO7ru6SiQ6TAIbZNNy5Sgwj8qlf6OE38VSK7Kjh2aPsbNsfhx2kdVfB6+aHFuAbeDA77/n2vF9ghrYXcAzGOIn5rEqtBXAtGQql3/NY/GKra6CTKb8xaMASFZgBVHIt+rbOIDP3ws0AJuATKbNFis4NtffjuEyhSRaQUKhyFKxkbpAViP2VrPBqMNXm+WLjfWYNmbMwH2NoxBGV74ffaZ7fr8ki3wzYsL9dKgn55XlITxUeQipknyd6inCMwgBohSxtJPRFAYi3rtLgTCwlcQWqNF+2S8FzziCfvjEYGeV5QCmO1rbq4gG6N7Ks8lAp3JuKbqhh97wFL1ijxlVz7yiSHURVV9R1xRGHnUCbux+rrNAJUXD5HSZ/OjZUi/jzoqCTccqyMOLHccIGo16uecQp/Ce6dMkDLrOJPT9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(2906002)(8936002)(186003)(70586007)(7696005)(356005)(5660300002)(83380400001)(81166007)(426003)(316002)(6916009)(82310400003)(36756003)(86362001)(36860700001)(336012)(508600001)(4326008)(16526019)(1076003)(8676002)(26005)(6666004)(47076005)(2616005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 04:21:00.9383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667fb148-624d-48be-0900-08d995135adc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The extended bits were not available for use on vega20 and
presumably arcturus as well.

Fixes: a0f9f854666834 ("drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h        |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 814e9620fac5..208a784475bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1125,10 +1125,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(7, 4, 0):
 	case IP_VERSION(7, 4, 1):
-	case IP_VERSION(7, 4, 4):
 		adev->nbio.funcs = &nbio_v7_4_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
 		break;
+	case IP_VERSION(7, 4, 4):
+		adev->nbio.funcs = &nbio_v7_4_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg_ald;
+		break;
 	case IP_VERSION(7, 2, 0):
 	case IP_VERSION(7, 2, 1):
 	case IP_VERSION(7, 5, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 3b7775d74bb2..b8bd03d16dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -325,6 +325,21 @@ static u32 nbio_v7_4_get_pcie_data_offset(struct amdgpu_device *adev)
 }
 
 const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg = {
+	.ref_and_mask_cp0 = GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+};
+
+const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald = {
 	.ref_and_mask_cp0 = GPU_HDP_FLUSH_DONE__CP0_MASK,
 	.ref_and_mask_cp1 = GPU_HDP_FLUSH_DONE__CP1_MASK,
 	.ref_and_mask_cp2 = GPU_HDP_FLUSH_DONE__CP2_MASK,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
index b8216581ec8d..cc5692db6f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h
@@ -27,6 +27,7 @@
 #include "soc15_common.h"
 
 extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg;
+extern const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald;
 extern const struct amdgpu_nbio_funcs nbio_v7_4_funcs;
 extern const struct amdgpu_nbio_ras_funcs nbio_v7_4_ras_funcs;
 
-- 
2.31.1

