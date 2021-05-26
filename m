Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA555C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909F2613AB
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909F2613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC606E5C6;
	Wed, 26 May 2021 10:13:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D01789B9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va+ww9ro0a1dgsK2ee1q2Nkzi6hf6o4Wz6tdmYfERquOoyo2KLkO3AgsQzofgMdpgPWi6uEfTYJYIoLvacK8fqPaCKRCXv8u7RWzQgNJSs3BafaU05CgvXCg+AHdwFVmr/QqIVeLLWjhytZdR0tILxvxK13K6f5jEDQgNuR6du+Az3/5jjkvwKyIV0Y4WH/yzAPYevwpT/jkQqVnHl2HHdj9iJDdjXcV3hKtmDrPizgHdm4NDuFzsqw71TAKTJnFCioDRR22ubjtEdwgt1zOJLg4JW6/TNc3l2MMqlUGUcXAB9ounm7ZnEUEYh7mYTbbW7bZHn4trH5M6OUw5p1Q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKKGNSDAtb+P4q+REyFdPcZXnar23LZKa14Txppfilk=;
 b=LMdMwSjc1gE6sufUdznCW9GnMQtPxBaqdr+VQL1SyJz4MtjOo0NJLS3efaR/BxpesyRR2xjEvILckhK1BvSuS/Gp29QTBysz98HHXNc7vq5NkMlnjXybtX7ag3PemHcle2URCH+MOlzyU8O0Jz6MrXEJMF8y6Gm5F1OgX6ryTUDr6b6G5rzrOlGTlfai+jy0kbyDyByKUbRoxzstHvYqT3OpIDCGh/dXhjO2fgWghbNS/2nOGHZh9lAjhm8POq+QBEVpu0e9ZmxUys4N/GMJaUGnI1bSD1ky1qyiCVMNNgqPzY5nDT/Q5UNuexhSYUJfgNu0JFQgnx+BmlYiGxjAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKKGNSDAtb+P4q+REyFdPcZXnar23LZKa14Txppfilk=;
 b=W8jl8vWznaxX4UDpfAcrMKmdk2q0fLFtzN4kTi/Qb8e84OyccXZsTXDjOTENe1XYbAUWCWVY+U+osJ9CElGhw1XGKrpCthx6APvnedCWmWW/HLl9+Kt0JCSzadrf5z+0WpmoSvezLyQUpCaEUbANUxdb34I/wQKsaYS7GMJOqWI=
Received: from BN7PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:20::41)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 10:13:16 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::9d) by BN7PR02CA0028.outlook.office365.com
 (2603:10b6:408:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 10:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 10:13:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 26 May
 2021 05:13:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 26 May
 2021 05:13:15 -0500
Received: from sha-l10-xinl-build.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Wed, 26 May 2021 05:13:14 -0500
From: "Li, Xin (Justin)" <xin2.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Date: Wed, 26 May 2021 18:13:10 +0800
Message-ID: <20210526101310.1872892-1-xin2.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b418b29-f170-4f3d-85a8-08d9202ee0dc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44711116CF7B16E5E83070F1BB249@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjKlibYlPCfaglR+GTadBnjARts3bsSj8Wx4YLEdRv9rKLP10vZsWArj342H+sOxCEL0iXXveQiBV1DqPaX2a9Ub0WCea99bipeDZOWUhdwf/83TFjmrg1YgbXTJHWnE/CgfPAAhnZNG8Lt5SFx+IRdhMc4zKx7o+htl9rO/CIShkzL/DfRqyChOtalBtsjXn1EgM5p4Ss0iRYev7mhyskTrY5ZvWILVzwJUaq7TYYthmhVteTZFjLvEq6vynC0yyXgDn2Bh+sorbckEJKqCkKWFB/4Wmn1NCJ8hDJHi7IBUI4TvUOC463Hg5EWFmkUJKm2gtlO66az5Aq2pBQPa4fd4j1P+taumkiWQMgDSrJpPSkc0KQKyCmrvvc7AnVA9VXhsWFwNny6ct7/A2NB5BZA2lSQVtjNt9ODYtai1UXdcOImY4ila6yJAWqzBUGPwV66n6FEOboB5+l4u2V4HnK1lzJXAWscd4PETEfnZY2SI4FW1MYzKv8Q64+Lm+3JLdyzbcQ1ZVE4xFxqi8B5Zuo0OjNWtoY254SaFOWFr5llUnGbeBEUkpjG2O1KDagGx3+t0xd970h7pZ553NTi/7GTrofqsOxJwYNiYnhuT2v2Hjj+0gMcmiBIrMPs6TXP/8ODQ3xqr+lETQ+OCZJYKSVVQI7h8D5VyzYIAgfZRUhcYceVDkQjgzal62EEijvc8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(8936002)(82310400003)(2906002)(82740400003)(7696005)(1076003)(6916009)(5660300002)(4326008)(36756003)(6666004)(81166007)(8676002)(83380400001)(47076005)(70206006)(356005)(70586007)(36860700001)(186003)(26005)(336012)(54906003)(426003)(316002)(2616005)(478600001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:13:16.2329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b418b29-f170-4f3d-85a8-08d9202ee0dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Cc: "Li, Xin \(Justin\)" <xin2.li@amd.com>,
 "Alex . Deucher" <alexander.deucher@amd.com>,
 "Frank . Min" <Frank.Min@amd.com>,
 "Christian . Konig" <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

since vcn decoding ring is not required, so just disable it.

Cc: Alex.Deucher <alexander.deucher@amd.com>
Cc: Christian.Konig <christian.koenig@amd.com>
Signed-off-by: Li.Xin.Justin <xin2.li@amd.com>
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 25 ++++++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 524e4fe5efe8..614e6b06e94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
+			if (adev->vcn.inst[i].ring_dec.sched.ready ||
+				(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev)))
 				++num_rings;
 		}
 		ib_start_alignment = 16;
@@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
 		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
-		if (amdgpu_is_tmz(adev))
-			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
 
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_SIZE;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8af567c546db..dc8a36766c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
-	int i, r;
+	int i, r = -1;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 					     ring->doorbell_index, 0);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		vcn_v2_0_start_sriov(adev);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		goto done;
+		if (adev->asic_type == CHIP_NAVI12)
+			ring->sched.ready = false;
+	} else {
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			goto done;
+	}
 
 	//Disable vcn decode for sriov
 	if (amdgpu_sriov_vf(adev))
@@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)
 
 done:
 	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
+		DRM_INFO("VCN %s encode initialized successfully(under %s).\n",
+			(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev))?"":"decode and",
+			(adev->pg_flags &
+				AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
