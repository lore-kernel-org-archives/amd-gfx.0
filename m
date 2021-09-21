Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8652CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5410F60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5410F60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90DB6EA77;
	Tue, 21 Sep 2021 18:08:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4656EABD
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5tNkvmyWVf4QjO/JNhnhlZ+mmlNi5in7jXFotU3vh7w4cz0WP4WxlyJlMJEVLnVRR2mkMK/vQWV8XEDHr94OlbNVGaVpZwMPSCDAu3BmBuIZIlvvCQkebDoE1Hg07Zw2mGI1ihJesJ0g8ZDgP7NTflGiArMSC4dJCF0gdt8uHoWCUb14Lkg8Gh1m6PxSrTrx5eTPPQpYHwmihOMyAyobHyGWwVimpsS3HTx0mDEsksk6rlsMGPtHiLaHsnU7zXwBV4wxwRxK2GrkcyTq6AA2JGuc9D+TRdlU8Dqx04py8k+4Hsxfg3W+sMObM+g6/+s8gN8hL0lzIhhXJwVD+8XPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2dnF7RSfljxtf11eMVGV4vKpojGm48rBLvtcYfgFcGY=;
 b=flyTe/I5wxuQQXfLcvE7gFWuCrOsvTzj6Wt8U9vHFnoGuarK/ow02G+fZjgT4WGsnBkwAbKqHNapB1E682FGNQTjPq1ZU+6f4S/PyLh+gn7VtIKwHBxShHiR3UI21mEgABfUGX0+fV9g46ko7yxDCE62tFPrl/t8OAq90PWtc0M4Qy5dAi6LzQEB3bEjBa8bSl7stbMrsEidXdJDw9yX9PDuwpogMqoov4GVpHZH6PIKrk62cm5hN0qaGgaHk/TlhIOjBGFRVfAfovG310089k+fBOYzIPR0ynZCqCPQs/p4PlLf5bJBVm2buEuKhwyn3+HzX9/lMl4DOruJxysJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dnF7RSfljxtf11eMVGV4vKpojGm48rBLvtcYfgFcGY=;
 b=PBfYGQT1k8rk+zQw1udb0Bxx3KpLvji0IS4Ti0Xh4SxnwzeAAR0fz7LrTz7D9O68ZdfWFYP8ZhRkqjb5tQr+tY6aH3W4gxK/17h378WnEu5q1jmAO09gYTqcPfarZA3HJxICAzFZ37G5XJ2WMUm6uS3MtW+l5Cm/OT/uW/WXWKw=
Received: from DM3PR14CA0140.namprd14.prod.outlook.com (2603:10b6:0:53::24) by
 CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:09 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::7f) by DM3PR14CA0140.outlook.office365.com
 (2603:10b6:0:53::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:08:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 62/66] drm/amdgpu: clean up set IP function
Date: Tue, 21 Sep 2021 14:07:21 -0400
Message-ID: <20210921180725.1985552-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d08d2c47-7369-4f98-2f8d-08d97d2ac4a9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4053:
X-Microsoft-Antispam-PRVS: <CH2PR12MB405364BE98EBACDEC2DEB7BEF7A19@CH2PR12MB4053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8FXPLVCuA1/Dy3KOJ4buAN16e2qD35+CjrLD1OByhpIsWCUStKcbDa8Ss/xBRXgtt8diWVXjDgM1yKX7OJP6iFwPaG6ViJjeiC05N6pJUNR9i6tXhCE6HvR8LR7QK11B0LMTLeXUuzlqYHFOmqe6DGoUaBI11k1TFNGBRk25Y4t2JXCxvEgA2EVvhX/YbWRGtBtIekh+TubPUqaLSxCMQLHKt/E/7yy7wE5fs2IhKEZjYAAkq1ZurePo6clB91SYYFQ5tRS0QGwSgpepi+xcyHt7nl3yw0dYMXFvU7uRUHcmqAaz3cqCkAZKmVSKGUnSC4KE4P+IlxdRvfMPXYTroAzV/gXpYPdsEKW6QN+i4FInVP6P5dqWnQmW3tj+3jWndHyTcrTOI6dHcLCdzAVRqsibfVGTerS+LhYDA4KyH5HTOZh83zZF/eHl1SOSR2N9avm/eEMqMdGmvkwPeX1nnQ2swgFcJF1Lzqn6LshytU43r4wYeSkJLrCawG3rX1hG4TUU58rvUt+Wkc5Ier7VW1h4wXbPyjVWIgn/ghjhTNvTA3hlm6fIAVKu1YqWz4fdVu2UMb0hGNDJsEXPK+M78TNgxo0Wqzmh9DwqPzM+cyimCwvQvtTQpCxgAgrI8AvKkbkEB5zqvZoLVAcxvy+fkzWePR3UXf3NBHwlbLOZf9ewHSTU1FT778hMRtzUJ5anEbmYSs2pFIk48U/KJtHelAkPdNTtbb6FbyzZ/jyV9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(7696005)(30864003)(36756003)(2616005)(81166007)(316002)(426003)(70586007)(186003)(6916009)(8936002)(82310400003)(5660300002)(356005)(70206006)(6666004)(36860700001)(8676002)(4326008)(47076005)(86362001)(16526019)(83380400001)(508600001)(26005)(336012)(1076003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:09.0336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08d2c47-7369-4f98-2f8d-08d97d2ac4a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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

Split into several smaller per IP functions to make it
easier to handle ordering issues for things like
SR-IOV in a follow up patch.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1028 +++++++++--------
 1 file changed, 540 insertions(+), 488 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eff348dee9e9..44ab3d6739e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -517,336 +517,218 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
+static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 {
-	int r;
-
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-		vega10_reg_base_init(adev);
-		adev->sdma.num_instances = 2;
-		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 0);
-		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 0);
-		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 0);
-		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 0);
-		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 1, 0);
-		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 0, 0);
-		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[THM_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 0, 1);
-		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 0, 0);
-		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 0, 0);
-		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 0);
-		break;
-	case CHIP_VEGA12:
-		vega10_reg_base_init(adev);
-		adev->sdma.num_instances = 2;
-		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 3, 0);
-		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 3, 0);
-		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 1);
-		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 1);
-		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 1);
-		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 5, 0);
-		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 2, 0);
-		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 0);
-		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[THM_HWIP][0] = IP_VERSION(9, 0, 0);
-		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(9, 0, 1);
-		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 2, 1);
-		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 0, 0);
-		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 0, 0);
-		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 1);
-		break;
-	case CHIP_RAVEN:
-		vega10_reg_base_init(adev);
-		adev->sdma.num_instances = 1;
-		adev->vcn.num_vcn_inst = 1;
-		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
-			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 2, 0);
-			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 2, 0);
-			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 1, 1);
-			adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 1, 1);
-			adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 1, 1);
-			adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 1);
-			adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 0, 1);
-			adev->ip_versions[UMC_HWIP][0] = IP_VERSION(7, 5, 0);
-			adev->ip_versions[MP0_HWIP][0] = IP_VERSION(10, 0, 1);
-			adev->ip_versions[MP1_HWIP][0] = IP_VERSION(10, 0, 1);
-			adev->ip_versions[THM_HWIP][0] = IP_VERSION(10, 1, 0);
-			adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(10, 0, 1);
-			adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 2, 2);
-			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(1, 0, 1);
-			adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 1);
-		} else {
-			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 1, 0);
-			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 1, 0);
-			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 1, 0);
-			adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 1, 0);
-			adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 1, 0);
-			adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 0);
-			adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 0, 0);
-			adev->ip_versions[UMC_HWIP][0] = IP_VERSION(7, 0, 0);
-			adev->ip_versions[MP0_HWIP][0] = IP_VERSION(10, 0, 0);
-			adev->ip_versions[MP1_HWIP][0] = IP_VERSION(10, 0, 0);
-			adev->ip_versions[THM_HWIP][0] = IP_VERSION(10, 0, 0);
-			adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(10, 0, 0);
-			adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 1, 0);
-			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(1, 0, 0);
-			adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
-		}
-		break;
-	case CHIP_VEGA20:
-		vega20_reg_base_init(adev);
-		adev->sdma.num_instances = 2;
-		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 0);
-		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 0);
-		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 0);
-		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 0);
-		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 0);
-		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 0);
-		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 0);
-		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 1);
-		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(11, 0, 2);
-		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(11, 0, 2);
-		adev->ip_versions[THM_HWIP][0] = IP_VERSION(11, 0, 2);
-		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 2);
-		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 0);
-		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 2, 0);
-		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 1, 0);
-		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
-		break;
-	case CHIP_ARCTURUS:
-		arct_reg_base_init(adev);
-		adev->sdma.num_instances = 8;
-		adev->vcn.num_vcn_inst = 2;
-		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 1);
-		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 1);
-		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 1);
-		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 1);
-		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 2);
-		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 1);
-		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 1);
-		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 2);
-		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(11, 0, 4);
-		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(11, 0, 2);
-		adev->ip_versions[THM_HWIP][0] = IP_VERSION(11, 0, 3);
-		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 3);
-		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 1);
-		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 5, 0);
-		break;
-	case CHIP_ALDEBARAN:
-		aldebaran_reg_base_init(adev);
-		adev->sdma.num_instances = 5;
-		adev->vcn.num_vcn_inst = 2;
-		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 2);
-		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 2);
-		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 4, 0);
-		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 4, 0);
-		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 4, 0);
-		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 2);
-		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 4);
-		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 7, 0);
-		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(13, 0, 2);
-		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(13, 0, 2);
-		adev->ip_versions[THM_HWIP][0] = IP_VERSION(13, 0, 2);
-		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(13, 0, 2);
-		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 2);
-		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 6, 0);
-		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
-		break;
-	default:
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (r)
-			return -EINVAL;
-
-		amdgpu_discovery_harvest_ip(adev);
-
-		if (!adev->mman.discovery_bin) {
-			DRM_ERROR("ip discovery uninitialized\n");
-			return -EINVAL;
-		}
-		break;
-	}
-
+	/* what IP to use for this? */
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
-		adev->family = AMDGPU_FAMILY_AI;
-		break;
-	case IP_VERSION(9, 1, 0):
-	case IP_VERSION(9, 2, 2):
-	case IP_VERSION(9, 3, 0):
-		adev->family = AMDGPU_FAMILY_RV;
+		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
 	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
 	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
-		adev->family = AMDGPU_FAMILY_NV;
-		break;
-	case IP_VERSION(10, 3, 1):
-		adev->family = AMDGPU_FAMILY_VGH;
-		break;
-	case IP_VERSION(10, 3, 3):
-		adev->family = AMDGPU_FAMILY_YC;
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
 	default:
 		return -EINVAL;
 	}
+	return 0;
+}
 
-	if (adev->ip_versions[XGMI_HWIP][0] == IP_VERSION(4, 8, 0))
-		adev->gmc.xgmi.supported = true;
-
-	/* set NBIO version */
-	switch (adev->ip_versions[NBIO_HWIP][0]) {
-	case IP_VERSION(6, 1, 0):
-	case IP_VERSION(6, 2, 0):
-		adev->nbio.funcs = &nbio_v6_1_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
-		break;
-	case IP_VERSION(7, 0, 0):
-	case IP_VERSION(7, 0, 1):
-	case IP_VERSION(2, 5, 0):
-		adev->nbio.funcs = &nbio_v7_0_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
-		break;
-	case IP_VERSION(7, 4, 0):
-	case IP_VERSION(7, 4, 1):
-	case IP_VERSION(7, 4, 4):
-		adev->nbio.funcs = &nbio_v7_4_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
-		break;
-	case IP_VERSION(7, 2, 0):
-	case IP_VERSION(7, 2, 1):
-	case IP_VERSION(7, 5, 0):
-		adev->nbio.funcs = &nbio_v7_2_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v7_2_hdp_flush_reg;
+static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
+{
+	/* use GC or MMHUB IP version */
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
 		break;
-	case IP_VERSION(2, 1, 1):
-	case IP_VERSION(2, 3, 0):
-	case IP_VERSION(2, 3, 1):
-	case IP_VERSION(2, 3, 2):
-	case IP_VERSION(3, 3, 0):
-	case IP_VERSION(3, 3, 1):
-	case IP_VERSION(3, 3, 2):
-	case IP_VERSION(3, 3, 3):
-		adev->nbio.funcs = &nbio_v2_3_funcs;
-		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
+	return 0;
+}
 
-	switch (adev->ip_versions[HDP_HWIP][0]) {
+static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[OSSSYS_HWIP][0]) {
 	case IP_VERSION(4, 0, 0):
 	case IP_VERSION(4, 0, 1):
 	case IP_VERSION(4, 1, 0):
 	case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 3, 0):
+		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+		break;
 	case IP_VERSION(4, 2, 0):
 	case IP_VERSION(4, 2, 1):
 	case IP_VERSION(4, 4, 0):
-		adev->hdp.funcs = &hdp_v4_0_funcs;
+		amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
 		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
 	case IP_VERSION(5, 0, 2):
 	case IP_VERSION(5, 0, 3):
-	case IP_VERSION(5, 0, 4):
 	case IP_VERSION(5, 2, 0):
-		adev->hdp.funcs = &hdp_v5_0_funcs;
-		break;
-	default:
-		break;
-	}
-
-	switch (adev->ip_versions[DF_HWIP][0]) {
-	case IP_VERSION(3, 6, 0):
-	case IP_VERSION(3, 6, 1):
-	case IP_VERSION(3, 6, 2):
-		adev->df.funcs = &df_v3_6_funcs;
-		break;
-	case IP_VERSION(2, 1, 0):
-	case IP_VERSION(2, 1, 1):
-	case IP_VERSION(2, 5, 0):
-	case IP_VERSION(3, 5, 1):
-	case IP_VERSION(3, 5, 2):
-		adev->df.funcs = &df_v1_7_funcs;
+	case IP_VERSION(5, 2, 1):
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
+	return 0;
+}
 
-	switch (adev->ip_versions[SMUIO_HWIP][0]) {
+static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[MP0_HWIP][0]) {
 	case IP_VERSION(9, 0, 0):
-	case IP_VERSION(9, 0, 1):
+		amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
+		break;
 	case IP_VERSION(10, 0, 0):
 	case IP_VERSION(10, 0, 1):
-	case IP_VERSION(10, 0, 2):
-		adev->smuio.funcs = &smuio_v9_0_funcs;
+		amdgpu_device_ip_block_add(adev, &psp_v10_0_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
-	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 0, 5):
+	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 7):
-	case IP_VERSION(11, 0, 8):
-		adev->smuio.funcs = &smuio_v11_0_funcs;
-		break;
-	case IP_VERSION(11, 0, 6):
-	case IP_VERSION(11, 0, 10):
 	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
 	case IP_VERSION(11, 5, 0):
-	case IP_VERSION(13, 0, 1):
-		adev->smuio.funcs = &smuio_v11_0_6_funcs;
+		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
+		break;
+	case IP_VERSION(11, 0, 8):
+		amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
 		break;
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(12, 0, 1):
+		amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
+		break;
+	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
-		adev->smuio.funcs = &smuio_v13_0_funcs;
+	case IP_VERSION(13, 0, 3):
+		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
+	return 0;
+}
 
-	/* what IP to use for this? */
-	switch (adev->ip_versions[GC_HWIP][0]) {
-	case IP_VERSION(9, 0, 1):
-	case IP_VERSION(9, 1, 0):
-	case IP_VERSION(9, 2, 1):
-	case IP_VERSION(9, 2, 2):
-	case IP_VERSION(9, 3, 0):
-	case IP_VERSION(9, 4, 0):
-	case IP_VERSION(9, 4, 1):
-	case IP_VERSION(9, 4, 2):
-		amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
+static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(9, 0, 0):
+	case IP_VERSION(10, 0, 0):
+	case IP_VERSION(10, 0, 1):
+	case IP_VERSION(11, 0, 2):
+		if (adev->asic_type == CHIP_ARCTURUS)
+			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		else
+			amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
 		break;
-	case IP_VERSION(10, 1, 10):
-	case IP_VERSION(10, 1, 1):
-	case IP_VERSION(10, 1, 2):
-	case IP_VERSION(10, 1, 3):
-	case IP_VERSION(10, 3, 0):
-	case IP_VERSION(10, 3, 1):
-	case IP_VERSION(10, 3, 2):
-	case IP_VERSION(10, 3, 3):
-	case IP_VERSION(10, 3, 4):
-	case IP_VERSION(10, 3, 5):
-		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 9):
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 8):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
+	case IP_VERSION(11, 5, 0):
+		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
+		break;
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 3):
+		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
 	}
+	return 0;
+}
+
+static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
+{
+	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
+		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
+#if defined(CONFIG_DRM_AMD_DC)
+	} else if (adev->ip_versions[DCE_HWIP][0]) {
+		switch (adev->ip_versions[DCE_HWIP][0]) {
+		case IP_VERSION(1, 0, 0):
+		case IP_VERSION(1, 0, 1):
+		case IP_VERSION(2, 0, 2):
+		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(2, 1, 0):
+		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 3):
+		case IP_VERSION(3, 0, 1):
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			break;
+		case IP_VERSION(2, 0, 3):
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else if (adev->ip_versions[DCI_HWIP][0]) {
+		switch (adev->ip_versions[DCI_HWIP][0]) {
+		case IP_VERSION(12, 0, 0):
+		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(12, 1, 0):
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			break;
+		default:
+			return -EINVAL;
+		}
+#endif
+	}
+	return 0;
+}
 
-	/* use GC or MMHUB IP version */
+static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
+{
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
 	case IP_VERSION(9, 1, 0):
@@ -856,319 +738,489 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
-		amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
 		break;
 	case IP_VERSION(10, 1, 10):
-	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 1):
 	case IP_VERSION(10, 1, 3):
 	case IP_VERSION(10, 3, 0):
-	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 2):
-	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
-		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+	case IP_VERSION(10, 3, 3):
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
 	}
+	return 0;
+}
 
-	switch (adev->ip_versions[OSSSYS_HWIP][0]) {
+static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[SDMA0_HWIP][0]) {
 	case IP_VERSION(4, 0, 0):
 	case IP_VERSION(4, 0, 1):
 	case IP_VERSION(4, 1, 0):
 	case IP_VERSION(4, 1, 1):
-	case IP_VERSION(4, 3, 0):
-		amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
-		break;
+	case IP_VERSION(4, 1, 2):
 	case IP_VERSION(4, 2, 0):
-	case IP_VERSION(4, 2, 1):
+	case IP_VERSION(4, 2, 2):
 	case IP_VERSION(4, 4, 0):
-		amdgpu_device_ip_block_add(adev, &vega20_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
 	case IP_VERSION(5, 0, 2):
-	case IP_VERSION(5, 0, 3):
+	case IP_VERSION(5, 0, 5):
+		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
+		break;
 	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 3):
 	case IP_VERSION(5, 2, 1):
-		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	default:
 		return -EINVAL;
 	}
+	return 0;
+}
 
-	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-		switch (adev->ip_versions[MP0_HWIP][0]) {
-		case IP_VERSION(9, 0, 0):
-			amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
-			break;
-		case IP_VERSION(10, 0, 0):
-		case IP_VERSION(10, 0, 1):
-			amdgpu_device_ip_block_add(adev, &psp_v10_0_ip_block);
-			break;
-		case IP_VERSION(11, 0, 0):
-		case IP_VERSION(11, 0, 2):
-		case IP_VERSION(11, 0, 4):
-		case IP_VERSION(11, 0, 5):
-		case IP_VERSION(11, 0, 9):
-		case IP_VERSION(11, 0, 7):
-		case IP_VERSION(11, 0, 11):
-		case IP_VERSION(11, 0, 12):
-		case IP_VERSION(11, 0, 13):
-		case IP_VERSION(11, 5, 0):
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			break;
-		case IP_VERSION(11, 0, 8):
-			amdgpu_device_ip_block_add(adev, &psp_v11_0_8_ip_block);
-			break;
-		case IP_VERSION(11, 0, 3):
-		case IP_VERSION(12, 0, 1):
-			amdgpu_device_ip_block_add(adev, &psp_v12_0_ip_block);
-			break;
-		case IP_VERSION(13, 0, 1):
-		case IP_VERSION(13, 0, 2):
-		case IP_VERSION(13, 0, 3):
-			amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
+static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
+{
+	if (adev->ip_versions[VCE_HWIP][0]) {
+		switch (adev->ip_versions[UVD_HWIP][0]) {
+		case IP_VERSION(7, 0, 0):
+		case IP_VERSION(7, 2, 0):
+			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
 			break;
 		default:
 			return -EINVAL;
 		}
-	}
-
-	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-		switch (adev->ip_versions[MP1_HWIP][0]) {
-		case IP_VERSION(9, 0, 0):
-		case IP_VERSION(10, 0, 0):
-		case IP_VERSION(10, 0, 1):
-		case IP_VERSION(11, 0, 2):
-			if (adev->asic_type == CHIP_ARCTURUS)
-				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-			else
-				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-			break;
-		case IP_VERSION(11, 0, 0):
-		case IP_VERSION(11, 0, 9):
-		case IP_VERSION(11, 0, 7):
-		case IP_VERSION(11, 0, 8):
-		case IP_VERSION(11, 0, 11):
-		case IP_VERSION(11, 0, 12):
-		case IP_VERSION(11, 0, 13):
-		case IP_VERSION(11, 5, 0):
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-			break;
-		case IP_VERSION(12, 0, 0):
-		case IP_VERSION(12, 0, 1):
-			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
-			break;
-		case IP_VERSION(13, 0, 1):
-		case IP_VERSION(13, 0, 2):
-		case IP_VERSION(13, 0, 3):
-			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
+		switch (adev->ip_versions[VCE_HWIP][0]) {
+		case IP_VERSION(4, 0, 0):
+		case IP_VERSION(4, 1, 0):
+			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
 			break;
 		default:
 			return -EINVAL;
 		}
-	}
-
-	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
-		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
-#if defined(CONFIG_DRM_AMD_DC)
-	} else if (adev->ip_versions[DCE_HWIP][0]) {
-		switch (adev->ip_versions[DCE_HWIP][0]) {
+	} else {
+		switch (adev->ip_versions[UVD_HWIP][0]) {
 		case IP_VERSION(1, 0, 0):
 		case IP_VERSION(1, 0, 1):
-		case IP_VERSION(2, 0, 2):
+			amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
+			break;
 		case IP_VERSION(2, 0, 0):
-		case IP_VERSION(2, 1, 0):
+		case IP_VERSION(2, 0, 2):
+		case IP_VERSION(2, 2, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
+			break;
+		case IP_VERSION(2, 0, 3):
+			break;
+		case IP_VERSION(2, 5, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
+			break;
+		case IP_VERSION(2, 6, 0):
+			amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
+			break;
 		case IP_VERSION(3, 0, 0):
+		case IP_VERSION(3, 0, 16):
+		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
-		case IP_VERSION(3, 0, 3):
-		case IP_VERSION(3, 0, 1):
-		case IP_VERSION(3, 1, 2):
-		case IP_VERSION(3, 1, 3):
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 			break;
-		case IP_VERSION(2, 0, 3):
+		case IP_VERSION(3, 0, 33):
+			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
 		default:
 			return -EINVAL;
-		}
-	} else if (adev->ip_versions[DCI_HWIP][0]) {
-		switch (adev->ip_versions[DCI_HWIP][0]) {
-		case IP_VERSION(12, 0, 0):
-		case IP_VERSION(12, 0, 1):
-		case IP_VERSION(12, 1, 0):
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
-			break;
-		default:
+		}
+	}
+	return 0;
+}
+
+static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 1, 10):
+	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
+	case IP_VERSION(10, 1, 3):
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 4):
+	case IP_VERSION(10, 3, 5):
+		amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
+		break;
+	default:
+		break;;
+	}
+	return 0;
+}
+
+int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
+{
+	int r;
+
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
+		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 0);
+		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 1, 0);
+		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 0, 0);
+		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[THM_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 0, 1);
+		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 0, 0);
+		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 0);
+		break;
+	case CHIP_VEGA12:
+		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
+		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 3, 0);
+		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 3, 0);
+		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 1);
+		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 1);
+		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 1);
+		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 5, 0);
+		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 2, 0);
+		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 0);
+		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[THM_HWIP][0] = IP_VERSION(9, 0, 0);
+		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(9, 0, 1);
+		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 2, 1);
+		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 0, 0);
+		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 0, 0);
+		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 1);
+		break;
+	case CHIP_RAVEN:
+		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 1;
+		adev->vcn.num_vcn_inst = 1;
+		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
+			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 2, 0);
+			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 2, 0);
+			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 1, 1);
+			adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 1, 1);
+			adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 1, 1);
+			adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 1);
+			adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 0, 1);
+			adev->ip_versions[UMC_HWIP][0] = IP_VERSION(7, 5, 0);
+			adev->ip_versions[MP0_HWIP][0] = IP_VERSION(10, 0, 1);
+			adev->ip_versions[MP1_HWIP][0] = IP_VERSION(10, 0, 1);
+			adev->ip_versions[THM_HWIP][0] = IP_VERSION(10, 1, 0);
+			adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(10, 0, 1);
+			adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 2, 2);
+			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(1, 0, 1);
+			adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 1);
+		} else {
+			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 1, 0);
+			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 1, 0);
+			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 1, 0);
+			adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 1, 0);
+			adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 1, 0);
+			adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 0);
+			adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 0, 0);
+			adev->ip_versions[UMC_HWIP][0] = IP_VERSION(7, 0, 0);
+			adev->ip_versions[MP0_HWIP][0] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[MP1_HWIP][0] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[THM_HWIP][0] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(10, 0, 0);
+			adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 1, 0);
+			adev->ip_versions[UVD_HWIP][0] = IP_VERSION(1, 0, 0);
+			adev->ip_versions[DCE_HWIP][0] = IP_VERSION(1, 0, 0);
+		}
+		break;
+	case CHIP_VEGA20:
+		vega20_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
+		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 0);
+		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 0);
+		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 0);
+		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 0);
+		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 0);
+		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 0);
+		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 0);
+		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 1);
+		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[THM_HWIP][0] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 0);
+		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 2, 0);
+		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 1, 0);
+		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
+		break;
+	case CHIP_ARCTURUS:
+		arct_reg_base_init(adev);
+		adev->sdma.num_instances = 8;
+		adev->vcn.num_vcn_inst = 2;
+		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 1);
+		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 1);
+		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 1);
+		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 1);
+		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 2);
+		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 1);
+		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 1);
+		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 2);
+		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(11, 0, 4);
+		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(11, 0, 2);
+		adev->ip_versions[THM_HWIP][0] = IP_VERSION(11, 0, 3);
+		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 3);
+		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 1);
+		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 5, 0);
+		break;
+	case CHIP_ALDEBARAN:
+		aldebaran_reg_base_init(adev);
+		adev->sdma.num_instances = 5;
+		adev->vcn.num_vcn_inst = 2;
+		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 2);
+		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 2);
+		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 4, 0);
+		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 2);
+		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 4);
+		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 7, 0);
+		adev->ip_versions[MP0_HWIP][0] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[MP1_HWIP][0] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[THM_HWIP][0] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(13, 0, 2);
+		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 2);
+		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 6, 0);
+		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
+		break;
+	default:
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (r)
+			return -EINVAL;
+
+		amdgpu_discovery_harvest_ip(adev);
+
+		if (!adev->mman.discovery_bin) {
+			DRM_ERROR("ip discovery uninitialized\n");
 			return -EINVAL;
 		}
+		break;
 	}
-#endif
+
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
-	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 1):
-	case IP_VERSION(9, 2, 2):
-	case IP_VERSION(9, 3, 0):
 	case IP_VERSION(9, 4, 0):
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
-		amdgpu_device_ip_block_add(adev, &gfx_v9_0_ip_block);
+		adev->family = AMDGPU_FAMILY_AI;
+		break;
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+		adev->family = AMDGPU_FAMILY_RV;
 		break;
 	case IP_VERSION(10, 1, 10):
-	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 1):
+	case IP_VERSION(10, 1, 2):
 	case IP_VERSION(10, 1, 3):
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
-	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+		adev->family = AMDGPU_FAMILY_NV;
+		break;
+	case IP_VERSION(10, 3, 1):
+		adev->family = AMDGPU_FAMILY_VGH;
+		break;
 	case IP_VERSION(10, 3, 3):
-		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		adev->family = AMDGPU_FAMILY_YC;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	switch (adev->ip_versions[SDMA0_HWIP][0]) {
+	if (adev->ip_versions[XGMI_HWIP][0] == IP_VERSION(4, 8, 0))
+		adev->gmc.xgmi.supported = true;
+
+	/* set NBIO version */
+	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	case IP_VERSION(6, 1, 0):
+	case IP_VERSION(6, 2, 0):
+		adev->nbio.funcs = &nbio_v6_1_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
+		break;
+	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 0, 1):
+	case IP_VERSION(2, 5, 0):
+		adev->nbio.funcs = &nbio_v7_0_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_0_hdp_flush_reg;
+		break;
+	case IP_VERSION(7, 4, 0):
+	case IP_VERSION(7, 4, 1):
+	case IP_VERSION(7, 4, 4):
+		adev->nbio.funcs = &nbio_v7_4_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_4_hdp_flush_reg;
+		break;
+	case IP_VERSION(7, 2, 0):
+	case IP_VERSION(7, 2, 1):
+	case IP_VERSION(7, 5, 0):
+		adev->nbio.funcs = &nbio_v7_2_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_2_hdp_flush_reg;
+		break;
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 3, 0):
+	case IP_VERSION(2, 3, 1):
+	case IP_VERSION(2, 3, 2):
+	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
+	case IP_VERSION(3, 3, 2):
+	case IP_VERSION(3, 3, 3):
+		adev->nbio.funcs = &nbio_v2_3_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+		break;
+	default:
+		break;
+	}
+
+	switch (adev->ip_versions[HDP_HWIP][0]) {
 	case IP_VERSION(4, 0, 0):
 	case IP_VERSION(4, 0, 1):
 	case IP_VERSION(4, 1, 0):
 	case IP_VERSION(4, 1, 1):
-	case IP_VERSION(4, 1, 2):
 	case IP_VERSION(4, 2, 0):
-	case IP_VERSION(4, 2, 2):
+	case IP_VERSION(4, 2, 1):
 	case IP_VERSION(4, 4, 0):
-		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
+		adev->hdp.funcs = &hdp_v4_0_funcs;
 		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
 	case IP_VERSION(5, 0, 2):
-	case IP_VERSION(5, 0, 5):
-		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
-		break;
+	case IP_VERSION(5, 0, 3):
+	case IP_VERSION(5, 0, 4):
 	case IP_VERSION(5, 2, 0):
-	case IP_VERSION(5, 2, 2):
-	case IP_VERSION(5, 2, 4):
-	case IP_VERSION(5, 2, 5):
-	case IP_VERSION(5, 2, 3):
-	case IP_VERSION(5, 2, 1):
-		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		adev->hdp.funcs = &hdp_v5_0_funcs;
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		switch (adev->ip_versions[MP1_HWIP][0]) {
-		case IP_VERSION(9, 0, 0):
-		case IP_VERSION(10, 0, 0):
-		case IP_VERSION(10, 0, 1):
-		case IP_VERSION(11, 0, 2):
-			if (adev->asic_type == CHIP_ARCTURUS)
-				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-			else
-				amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-			break;
-		case IP_VERSION(11, 0, 0):
-		case IP_VERSION(11, 0, 9):
-		case IP_VERSION(11, 0, 7):
-		case IP_VERSION(11, 0, 8):
-		case IP_VERSION(11, 0, 11):
-		case IP_VERSION(11, 0, 12):
-		case IP_VERSION(11, 0, 13):
-		case IP_VERSION(11, 5, 0):
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-			break;
-		case IP_VERSION(12, 0, 0):
-		case IP_VERSION(12, 0, 1):
-			amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
-			break;
-		case IP_VERSION(13, 0, 1):
-		case IP_VERSION(13, 0, 2):
-		case IP_VERSION(13, 0, 3):
-			amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
-			break;
-		default:
-			return -EINVAL;
-		}
+	switch (adev->ip_versions[DF_HWIP][0]) {
+	case IP_VERSION(3, 6, 0):
+	case IP_VERSION(3, 6, 1):
+	case IP_VERSION(3, 6, 2):
+		adev->df.funcs = &df_v3_6_funcs;
+		break;
+	case IP_VERSION(2, 1, 0):
+	case IP_VERSION(2, 1, 1):
+	case IP_VERSION(2, 5, 0):
+	case IP_VERSION(3, 5, 1):
+	case IP_VERSION(3, 5, 2):
+		adev->df.funcs = &df_v1_7_funcs;
+		break;
+	default:
+		break;
 	}
 
-	if (adev->ip_versions[VCE_HWIP][0]) {
-		switch (adev->ip_versions[UVD_HWIP][0]) {
-		case IP_VERSION(7, 0, 0):
-		case IP_VERSION(7, 2, 0):
-			amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
-			break;
-		default:
-			return -EINVAL;
-		}
-		switch (adev->ip_versions[VCE_HWIP][0]) {
-		case IP_VERSION(4, 0, 0):
-		case IP_VERSION(4, 1, 0):
-			amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else {
-		switch (adev->ip_versions[UVD_HWIP][0]) {
-		case IP_VERSION(1, 0, 0):
-		case IP_VERSION(1, 0, 1):
-			amdgpu_device_ip_block_add(adev, &vcn_v1_0_ip_block);
-			break;
-		case IP_VERSION(2, 0, 0):
-		case IP_VERSION(2, 0, 2):
-		case IP_VERSION(2, 2, 0):
-			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
-			break;
-		case IP_VERSION(2, 0, 3):
-			break;
-		case IP_VERSION(2, 5, 0):
-			amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
-			break;
-		case IP_VERSION(2, 6, 0):
-			amdgpu_device_ip_block_add(adev, &vcn_v2_6_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v2_6_ip_block);
-			break;
-		case IP_VERSION(3, 0, 0):
-		case IP_VERSION(3, 0, 16):
-		case IP_VERSION(3, 1, 1):
-		case IP_VERSION(3, 0, 2):
-			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
-			break;
-		case IP_VERSION(3, 0, 33):
-			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
-			break;
-		default:
-			return -EINVAL;
-		}
+	switch (adev->ip_versions[SMUIO_HWIP][0]) {
+	case IP_VERSION(9, 0, 0):
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(10, 0, 0):
+	case IP_VERSION(10, 0, 1):
+	case IP_VERSION(10, 0, 2):
+		adev->smuio.funcs = &smuio_v9_0_funcs;
+		break;
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 8):
+		adev->smuio.funcs = &smuio_v11_0_funcs;
+		break;
+	case IP_VERSION(11, 0, 6):
+	case IP_VERSION(11, 0, 10):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(13, 0, 1):
+		adev->smuio.funcs = &smuio_v11_0_6_funcs;
+		break;
+	case IP_VERSION(13, 0, 2):
+		adev->smuio.funcs = &smuio_v13_0_funcs;
+		break;
+	default:
+		break;
+	}
+
+	r = amdgpu_discovery_set_common_ip_blocks(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_discovery_set_gmc_ip_blocks(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_discovery_set_ih_ip_blocks(adev);
+	if (r)
+		return r;
+
+	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+		r = amdgpu_discovery_set_psp_ip_blocks(adev);
+		if (r)
+			return r;
+	}
+
+	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+		r = amdgpu_discovery_set_smu_ip_blocks(adev);
+		if (r)
+			return r;
 	}
 
+	r = amdgpu_discovery_set_display_ip_blocks(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_discovery_set_gc_ip_blocks(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_discovery_set_sdma_ip_blocks(adev);
+	if (r)
+		return r;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		r = amdgpu_discovery_set_smu_ip_blocks(adev);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_discovery_set_mm_ip_blocks(adev);
+	if (r)
+		return r;
+
 	if (adev->enable_mes) {
-		switch (adev->ip_versions[GC_HWIP][0]) {
-		case IP_VERSION(10, 1, 10):
-		case IP_VERSION(10, 1, 1):
-		case IP_VERSION(10, 1, 2):
-		case IP_VERSION(10, 1, 3):
-		case IP_VERSION(10, 3, 0):
-		case IP_VERSION(10, 3, 1):
-		case IP_VERSION(10, 3, 2):
-		case IP_VERSION(10, 3, 3):
-		case IP_VERSION(10, 3, 4):
-		case IP_VERSION(10, 3, 5):
-			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
-			break;
-		default:
-			break;;
-		}
+		r = amdgpu_discovery_set_mes_ip_blocks(adev);
+		if (r)
+			return r;
 	}
 
 	return 0;
-- 
2.31.1

