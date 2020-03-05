Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A30C3F2DA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F03C208C3
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wkF4p0qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F03C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056896EBC1;
	Thu,  5 Mar 2020 13:33:30 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3295E6E326
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzc9uPZhXuhRx1KlXV4Fu+M+PqjlWXIUOGwplL4DQaYVytZmYf83eq/TUepuII0egv6lkYj47KV8xCbWRoUXZUZiYRQ7HfHVDCKUc0CCL5nXYFvEoFObtOl9rgtDrhnUVChUEs3gELrqj0/KygRwuQzGOqiPqxP03Di+rWn24WiIkIrnUQfBuwxSlZbH8mIaglzJ+mcqAkEpIhzrUdEe9ceN25HEXDr7fpAy6UbGrIR9OUfKeA0ap1WjueqgtYLDF4IN/616Rut4Wr91dKuJbDvwhmmCKczwElxFXmk6mJWJHzdmZMkdV7ABWCR2U+fHt9yxU3Hst2tvbcztrawvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNS419j38VcF63o9zrpvunVWu8kswrT2VN/GHN/wFN0=;
 b=h+yHsfliBn+64ttNXNl4E3pIg5bqKk0stKlXRcFEWOGfyEO1sjEG1+Ug5rf3X4ypSmHfatSUTjdV7pnw8RyMtaiX41XYi/RieVdZvYiSGiRr1ASk6dTpJa8la5kCoUvmXFUFa/3r/qzejSaNP+YWSYmXA3feVnFSqE0SCjo8vkmCWKZgEikf/BWHhe76iHOdJlNBK+ph/dPDbB4KeDUpeotL/kxxx8kY2JXWHcfk8wbs46wW72U7jidwp64mMGzomlEQF/hloUtIsUInAmG9r64U6bmFKiiE64iEvPwlhr7MTIhAU+43P2cjIaGbMW/ClTH5ncDY0yS6m0Ua+nQUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNS419j38VcF63o9zrpvunVWu8kswrT2VN/GHN/wFN0=;
 b=wkF4p0qm+V1UgbAjI/1YS1YifTlTy0/ESKTMCaWiT9Hy/xxFwoDJc449wod5VkswyqeFSNkFcdNW4gYCiZlt+baNovfctygS0+eiWRMVkDA/WgPC1Gbb3baSYxHiGHZEHUpVDXXdGjgRP9zmroMpitmb5Qqh/RRbph/Prp5QxYg=
Received: from MWHPR14CA0058.namprd14.prod.outlook.com (2603:10b6:300:81::20)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 13:33:24 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::32) by MWHPR14CA0058.outlook.office365.com
 (2603:10b6:300:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19 via Frontend
 Transport; Thu, 5 Mar 2020 13:33:24 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 13:33:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:23 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:23 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Mar 2020 07:33:22 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [enable VCN2.0 for NV12 SRIOV 4/6] drm/amdgpu: cleanup ring/ib test
 for SRIOV vcn2.0
Date: Thu, 5 Mar 2020 21:33:05 +0800
Message-ID: <1583415187-16594-4-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(428003)(199004)(189003)(336012)(6666004)(356004)(6916009)(2616005)(70206006)(316002)(70586007)(478600001)(2906002)(7696005)(86362001)(81166006)(8676002)(426003)(36756003)(5660300002)(26005)(186003)(4326008)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2555; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f5cf98-0b1a-4652-e481-08d7c109c786
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555642E358E0B09058CAD4484E20@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TpXhvLUahVdsEtWbyKpPBn0x8GMFCcdwWWKAis5qpyt2DAAOVreEZOfFsAygpgH8wYss9h4cRxQt5f42ypYY2I+PCo6WOAYKZKk90jeRNCPE4Q5RFkDy3FeYxu1bwkBM52IKfX2V0MJaOfBDPI3Y9ciEfCsXztkSINK1uisuwF8hXbRTYOJ7v32jX1DFamxTVg6+32f5+URkwGx+FVIMTyBFihyG8xfwEv37dzC6W7X/VcU2MHkLAv505xkXmU7x3raUGP7PTdlLoLLHV4YR9Kj0BOxhFGxxWVMUyrNm8E5xCNieVqPvsgHOM/zsv5r6nc8zfp6kd/RtADtjSS7bBm7UXcOV7/otL1fQLUiN1xW8EuwYp0War3ATeUZ2TqXbYF9GZYx+V53QSEyCJadwpZahkTOgKpWZ8Ev10lzxZolNSnzvChqw9R4pnnepn5Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 13:33:24.0998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f5cf98-0b1a-4652-e481-08d7c109c786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support IB test on dec/enc ring
disable ring test on dec/enc ring (MMSCH limitation)

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 11 +++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  3 +++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f96464e..ae9754f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -497,10 +497,6 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *fence;
 	long r;
 
-	/* temporarily disable ib test for sriov */
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL);
 	if (r)
 		goto error;
@@ -527,6 +523,9 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	r = amdgpu_ring_alloc(ring, 16);
 	if (r)
 		return r;
@@ -661,10 +660,6 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_bo *bo = NULL;
 	long r;
 
-	/* temporarily disable ib test for sriov */
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &bo, NULL, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 421e5bf..dd500d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1647,6 +1647,9 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
