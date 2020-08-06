Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F620C433E4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8148422D07
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OOqCZy1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8148422D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98FC6E878;
	Thu,  6 Aug 2020 07:40:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA216E878
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 07:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHKb7vNYFbbfbLIRaLLzkpJBEzZ73p6wi8rbHyRHK/lirFiK7hj63+sAhRZh5tOza/nI3otowykfCAqMCNRufVqftHCrtHLGxClHMzIBbL0O5DxyqAeTZ4ABTx2Fd22Ji8JdIKAwR8HrhM8K1HwtBslXV3HdQHjKwgSQJy+JTTHiXYPlF8Rk3Pbjp2kMHbE+X9lqPnuhrmliBzm7KEtWqWSrlcrK1Q/N9tBan7O68c22IypU7R657jYPDRKQ564iXbA2QYQf/J1zIaDRPhqqJsj3QGm82E4pH/VTycYS4ebOv68Z51M50dssYFqRwzoS4awO7/CU+qdB4Rvw9qxi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN2OGA/jqAUYnI+AVGgEiNu1c4ybncj72DQgnihRzBI=;
 b=d/UiMtdTrvxbZMPRfSRW01ynol4A+LSjJ5eRsRjGYsx0K82xnIAdAy9VC+LDPEO2CCRg4+GJl1hGEsw9eZPdrkUezuWf4oFn2pmHUV01bCrk33WtZmJAevQsBODkYTbL1ButPXRrqKPWFludl2efs13/2RDQlAIBsVN2TsFgppxBM/Naq2NEK6ApIW9j6uAF3MIIwWc2bGSLdoTBszqWmB5InymwFI2NoImJ60CZszSJhjbHoHUag8Nurj02j0xART6fFpKXA6sl7blIFt7lAGuYt2Zf+4wKVQbiAKV7uJH+OJKUhvKjj/Rx26s83N0kkkdBQdy19vVZUEJDqS+muA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SN2OGA/jqAUYnI+AVGgEiNu1c4ybncj72DQgnihRzBI=;
 b=OOqCZy1kDnZq0MUn5opnoluGirpeNAXovIPsGyhncPlRYRWVfM2fa+3uyoMlUczZzcQ2ozhU+/T85zUTmn193nuJNwp1xXDw42PGzv4hYUmFUvw59fjbeDAP9V8RgdQ7HR+0al01vLoysrXRSv2ZbGU6pdIrKryEawP6ZHFa40Q=
Received: from BN6PR22CA0050.namprd22.prod.outlook.com (2603:10b6:404:ca::12)
 by MWHPR12MB1664.namprd12.prod.outlook.com (2603:10b6:301:b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Thu, 6 Aug
 2020 07:40:45 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::b2) by BN6PR22CA0050.outlook.office365.com
 (2603:10b6:404:ca::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Thu, 6 Aug 2020 07:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Thu, 6 Aug 2020 07:40:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Aug 2020
 02:40:42 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Aug 2020
 02:40:42 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 6 Aug 2020 02:40:39 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip some registers config for SRIOV
Date: Thu, 6 Aug 2020 15:40:36 +0800
Message-ID: <20200806074036.404227-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adb649b-1f87-4e22-c9a0-08d839dc05fa
X-MS-TrafficTypeDiagnostic: MWHPR12MB1664:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16643DF58FC77AC62EF13F0193480@MWHPR12MB1664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSjOp4ihDAH7qtHaAf1dwqy2V5LH8Q/l87lGD1ISNG5iwCd2Ko7hC6GMsvZmxB+MqlhuV0HGqt+LSWb4mCzup1FUZLRaDIapjdozgN6/oCFy6DPNth1wieKu4nBkU63aRsPzAGizv1n/uV8gfCneHtRtK0uaRQgjaaXQZhpp3WZDQW524gAxGQ9qw+E4n115OndRDX/KrncKLH06W4IyEZ7Jmrfblc0t2yInCBGYPizC+9YDDvrF0WZze+E1A+NAeZThYHcc9GlYdAYNcrP87HKOj/PjmJ2U8t94iNKeFwmths4JTckaaEFKWUn7YOq0SuhqNb95e7Gt9glpyNC3kVbtRaqOuoCTj6Fo52glwPhKqKQsO06VscQBuakMvkhDHSaUjiSD5Zc4skEZ4gutbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966005)(6916009)(316002)(54906003)(336012)(2616005)(26005)(4326008)(186003)(6666004)(426003)(2906002)(478600001)(8676002)(70206006)(36756003)(86362001)(8936002)(82740400003)(356005)(1076003)(7696005)(5660300002)(47076004)(70586007)(81166007)(82310400002)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 07:40:42.8405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adb649b-1f87-4e22-c9a0-08d839dc05fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1664
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For VF, registers L2_CNTL, L2_CONTEXT1_IDENTITY_APERTURE
L2_PROTECTION_FAULT_CNTL are not accesible, skip the
configuration for them in SRIOV mode.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 12 ++++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 1f6112b7fa49..6b96f45fde2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -330,10 +330,13 @@ int gfxhub_v2_1_gart_enable(struct amdgpu_device *adev)
 	gfxhub_v2_1_init_gart_aperture_regs(adev);
 	gfxhub_v2_1_init_system_aperture_regs(adev);
 	gfxhub_v2_1_init_tlb_regs(adev);
-	gfxhub_v2_1_init_cache_regs(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v2_1_init_cache_regs(adev);
 
 	gfxhub_v2_1_enable_system_domain(adev);
-	gfxhub_v2_1_disable_identity_aperture(adev);
+	if (!amdgpu_sriov_vf(adev))
+		gfxhub_v2_1_disable_identity_aperture(adev);
+
 	gfxhub_v2_1_setup_vmid_config(adev);
 	gfxhub_v2_1_program_invalidation(adev);
 
@@ -372,7 +375,12 @@ void gfxhub_v2_1_gart_disable(struct amdgpu_device *adev)
 void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
 					  bool value)
 {
+	/*These regs are not accessible for VF, PF will program in SRIOV */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	u32 tmp;
+
 	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index d83912901f73..9cfde9b81600 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -321,10 +321,13 @@ int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
 	mmhub_v2_0_init_gart_aperture_regs(adev);
 	mmhub_v2_0_init_system_aperture_regs(adev);
 	mmhub_v2_0_init_tlb_regs(adev);
-	mmhub_v2_0_init_cache_regs(adev);
+	if (!amdgpu_sriov_vf(adev))
+		mmhub_v2_0_init_cache_regs(adev);
 
 	mmhub_v2_0_enable_system_domain(adev);
-	mmhub_v2_0_disable_identity_aperture(adev);
+	if (!amdgpu_sriov_vf(adev))
+		mmhub_v2_0_disable_identity_aperture(adev);
+
 	mmhub_v2_0_setup_vmid_config(adev);
 	mmhub_v2_0_program_invalidation(adev);
 
@@ -364,7 +367,12 @@ void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
  */
 void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 {
+	/*These regs are not accessible for VF, PF will program in SRIOV */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	u32 tmp;
+
 	tmp = RREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL);
 	tmp = REG_SET_FIELD(tmp, MMVM_L2_PROTECTION_FAULT_CNTL,
 			    RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
