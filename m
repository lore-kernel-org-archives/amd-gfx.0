Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CFC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 06:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04568613EC
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 06:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04568613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868BF6EC14;
	Wed, 26 May 2021 06:55:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E7A6EC14
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 06:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwH96wCrZNJmRznU3UTRvNnsZYyhjoU8OGZi/NbKCl13uOE7IAcTyF9P9+BqxQ4zSJvtMUKMffbGPjwW7vPWV0b6suCkY9uE+rNqJRfFYil+YuWI4Ifax+RHo1YVS/ctDkJZ7ldq75GzwUYi1FmEK+s95ZDrs4ervmQdDyZCOXSpddkBRsnPLmQcO2TeFBDENG+2PpBMO3Cds0YmKUn0oG+tTLa/HdoMNbaLWqKBoSRU/QJUbFjTKOJElc5eY7UEArnJ319bSuTpQyFuGbU+dK+k2ImFdUS71JsVVw4A87Sqm12Zo7dNxxV8eexskj2okDVdCwj/ePW0W0zXp865Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzi+2TIMiU59Hrs/BaSPz/BrYWcqCU2EpGClcCEesDU=;
 b=jlUL9A2ziHmXS4A43Nw1qH/RtqW2T//rqjXK3X+8mksmUWH5YJP1awI3dyw68qwEude6/MW2FqXa12V7BH/i/rPTfdyDisdbe9cHGCpH26/lQYaUifGGR8gt3wCCahTQ4zwVlbl9iOvxmGi/B4lvMo/7OtZfBM6TEP3HzTiCcGSGHmEQfjgddgrQWZIkjO/UsZ8NijPBla1Je3WfsBS9KapENQD+vtfRzQlgAkp9pbuKjeYXUuQtRt8m85Gs8x+EFP2lms1Kc9bo4nhzT9GlHzc7fUaUQJuLrMWvTVSkzVND01Ka0FkTn9xUtorbfXlQ2fBOuSdpD+PsDm07lrBLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzi+2TIMiU59Hrs/BaSPz/BrYWcqCU2EpGClcCEesDU=;
 b=0jyIlq0pfXyufpDmuVgn37W8y0DcYCrXArXQmkqJ5MbCq004AJfmBiLUBTaowwC7+UT3Tcx9jF+NB47PpWmiEldCgQOetaoMd3f0RLVdRyWnkxDjErkul0d6NJDOkWXnG4EPqDP7RxirUOBWxT9wp1kgi6FgMrIfma7BUrVH/5M=
Received: from BN9PR03CA0551.namprd03.prod.outlook.com (2603:10b6:408:138::16)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Wed, 26 May
 2021 06:55:18 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::76) by BN9PR03CA0551.outlook.office365.com
 (2603:10b6:408:138::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 06:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 06:55:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 26 May
 2021 01:55:17 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 26 May 2021 01:55:16 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack
Date: Wed, 26 May 2021 14:55:00 +0800
Message-ID: <20210526065459.26368-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a74cf2e7-242b-41ad-54db-08d9201338f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4165:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4165896DB1D0BC396EB6DD9EB7249@CH2PR12MB4165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFpcrnc6tr0S5iyhDBmfo63ZEIoQ8gh5A5lPKh/f44p7VPiiIv5Yun7yNBN3F3AssDQ09pzJXkz+8p35vcIV7j+SvFtIWgHeOg3lxqo49dNfCBSUUGYzOXX9NOctTYgr8Tn8lOawEua95NCWRlNks2zUtAWbdZ4LH1gpsu1/L5KjadHydFra+H9qX6OivrXQvNgySR69z8ibGGiDPfy+NrW+9mTxTrmgJMWQAK85HV2J058HLI9ONTBgrq0DUmiZbj1P+EzhwlfggQ2AjV6KvcADtkyXUpJBDeN/vGjB5EbzfPU3El3U89755OuF5ly5iw6a/JJQ5lf+kYxVBVJvBj7EOn9My2qxx+aa5kqvT0NesIXOqoPZCz4VnA7cD7NfkjTt8mZGmPGVSAPIB6R+OrUhUZvvLbLBOtkuUsRSAojlLm4gnwo++bfodsiT+8vJAkBw+ZPvMebsTsZQwYoRV9/HL/9ILohkQgko6f4oXTT4KPlhFXBTVk+gjmOc3SoH1BZWFPMnSOv0lmKAIezaqKqLvW9m7HzCstDwfEAAopvb8j8hYiHdqBl1czh+FzwcW/RtglfNTWnWaQ/v9I+RKcsk8cw7jrh32yUPWmOsmlqB82lwFZThRAStzLjB96JSRD/OEBEXvMbx8UHL1/FmyS3Ho/uzwlqIHfc9I0pbkFII3eTUJ4GfR7hYiNT9NC85
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(83380400001)(54906003)(70206006)(7696005)(336012)(36860700001)(26005)(478600001)(2616005)(2906002)(6666004)(86362001)(82310400003)(8936002)(82740400003)(47076005)(6916009)(356005)(316002)(81166007)(426003)(4326008)(8676002)(186003)(5660300002)(1076003)(36756003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 06:55:18.1241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74cf2e7-242b-41ad-54db-08d9201338f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, Victor Zhao <Victor.Zhao@amd.com>,
 monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Zhao <Victor.Zhao@amd.com>

save psp ring wptr in SRIOV to avoid attack to avoid extra changes to
MP0_SMN_C2PMSG_102 reg

Change-Id: Idee78e8c1c781463048f2f6311fdc70488ef05b2
Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..20e06b3ec686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2701,6 +2701,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	/* Update the write Pointer in DWORDs */
 	psp_write_ptr_reg = (psp_write_ptr_reg + rb_frame_size_dw) % ring_size_dw;
 	psp_ring_set_wptr(psp, psp_write_ptr_reg);
+	ring->ring_wptr = psp_write_ptr_reg;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 46a5328e00e0..60aa99a39a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -76,6 +76,7 @@ struct psp_ring
 	uint64_t			ring_mem_mc_addr;
 	void				*ring_mem_handle;
 	uint32_t			ring_size;
+	uint32_t			ring_wptr;
 };
 
 /* More registers may will be supported */
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1f2e7e35c91e..4a32b0c84ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -474,6 +474,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 			return ret;
 		}
 
+		ring->ring_wptr = 0;
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg);
@@ -733,7 +734,7 @@ static uint32_t psp_v11_0_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f2e725f72d2f..160f78eb6403 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -237,6 +237,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 			return ret;
 		}
 
+		ring->ring_wptr = 0;
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg);
@@ -379,7 +380,7 @@ static uint32_t psp_v3_1_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 	return data;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
