Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6798FC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 12:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3546E206D4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 12:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hNBO+JxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3546E206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E3F6E1D8;
	Mon, 20 Apr 2020 12:36:53 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760089.outbound.protection.outlook.com [40.107.76.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC06089A5E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 12:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsRaZN4NrbxlF6DUR8Sw/RHfVHjObK02kaXOjqNZ1RLeXc2Mt6CjziQ/FuIiiq8amMYMlijyxzmsahdsKDCxnSG1mlfe3R7GB6uu7jza5cYcr1Rli1B895FVohlDXFAzEcQkVXjZnKtKhMnQ1dv+cpt00mlcoZPDg24A5n0lXoy+ITDZA5LaFGIaA7Y6NhUl5P+t9GCpb8ODtkkvv26RmJ+b1Ck3mvp+xI3skLAHheksld7y4ZqKNHBk5fEsTAdoUeBWnjBzPJ8qBipK9CbBITdhBAtU5KNEbNzeAEFOKRKYQghjeSiKeHb6HN90QDiHu9ASwVlpwVxfc57MSgmsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9IbBBzalpRhzUqnb7RdH74MiIEM802diqZBswS8HaU=;
 b=oCdmR2AkOswFyYAwfNka5lAJ10VuHL6pB7rKy/W+zUv1Ca7qfaSrI9aD/YkHS8lW9jwJ2SZQNViqDmv4ipMrsVT4ulit9rWX5C4bnQIqriswdF/Mptw/L5Kg6lXQSiYaDeH7REXodwP1hHw6RVWB08NKkKgk1MHGvevVvSpx518cLERIgS53F+BJ0cRgu6XNQLorEHGJBdP5i5welhj/sAZdHU4S1ayp/iIfOVDv+Icu0UsdJlfNu5TlMSlIeXTiDWcqWgTZGS0Y+Tce/Nh9/MQlmZJ0h0XOaS3Ej57q608HO/Qel2PnDCsRrlMQY6JB26IHCiuSr+ZSHlcvVNzzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=amd.co smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9IbBBzalpRhzUqnb7RdH74MiIEM802diqZBswS8HaU=;
 b=hNBO+JxG32HUKLSPJtthsyZjryvwybhrkritxX7AqddggFy1CEWtStiTJ7dVLZloIvuU12L7Kk8UBg+QuDSvnV/FGLfGGep+EpiE/33QI/jRjQ5qG4yRYmhqaYX8y9aaRjs2h1JHZ6FSwUe69hDzJuR71MUNnJKc+b3LR+O2kik=
Received: from BN6PR19CA0051.namprd19.prod.outlook.com (2603:10b6:404:e3::13)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 12:36:51 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::8a) by BN6PR19CA0051.outlook.office365.com
 (2603:10b6:404:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Mon, 20 Apr 2020 12:36:51 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; amd.co; dkim=none (message not signed)
 header.d=none;amd.co; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 12:36:50 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Apr
 2020 07:36:50 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 20 Apr 2020 07:36:48 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <monk.liu@amd.co>
Subject: [PATCH] drm/amdgpu: update spm register through mmio
Date: Mon, 20 Apr 2020 20:36:46 +0800
Message-ID: <20200420123646.5955-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(428003)(46966005)(316002)(7696005)(478600001)(110136005)(70206006)(15650500001)(2906002)(54906003)(8936002)(70586007)(47076004)(4326008)(2616005)(336012)(81156014)(26005)(5660300002)(356005)(36756003)(1076003)(82740400003)(8676002)(186003)(426003)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfeb99cd-e18e-4e35-2c17-08d7e5277fc8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525B12FEA72EBC0093381EAE5D40@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyuS1DZ4bjnraYQK1C0lLIZVEvy8E/qoTAa0+OcfaVxkp3TsrbmkKONdMFY0dRhoQoRGKeksaIzyuD4msGx85g5rJGTKl2AQk+4yZzXhXIFwaiovTZ677oFHzHg+2SVY/WDZoNlVA2qYpmMJ+BYL7pRE0hQCeKGX+1Hp/yC2q7laS5lKxcM9K9MeHcyinVd7/G6XmVlZRYEvhFyWOBSrWyPETWeQSrIM/lGkB32McvQHTjotXyfqN2GtDI/x4233g0XhLETGozZJfVuY3VtLCZG565IYBkufpdRm8izylVQM3XFg+lXOPICHugjJIOUpy9yu0PqWzsS/tkVEG9bmBGQ/9VLM8P7PCDEPjHk9mHOXFT3UsaaaPDQ+5YJRlfHUn009iv/dhRVRpngbYZ44izt+BfRap+i0weXOaE07T2dHpPtCXNU502RpbyAhC6LBTS0XdPwHA963ddSi5x0Vunvvv4/3ij4+fXX3j8qp3zB7K72lGLrfOJsNTDe7SUtthAO/QpaIMCRJe9KPa680/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 12:36:50.6084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeb99cd-e18e-4e35-2c17-08d7e5277fc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

According to UMD design, only running performance analysis
benchmark just like RGP, GPA and so on need to update spm
register and others will not support this feature.
Therefore, we can directly access spm register through mmio.

Signed-off-by: Yintian Tao <yttao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 3 +++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index accbb34ea670..820f560adc33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1083,7 +1083,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool update_spm_vmid_needed = (job->vm && (job->vm->reserved_vmid[vmhub] != NULL));
 	int r;
 
-	if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+	if ((!amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev) ||
+	     amdgpu_sriov_is_pp_one_vf(adev)) &&
+	    update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
 
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 0a03e2ad5d95..bfb873f023c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7032,12 +7032,12 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 data;
 
-	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+	data = RREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
-	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+	WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
 static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 84fcf842316d..514efc4fe269 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4950,12 +4950,12 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 data;
 
-	data = RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
+	data = RREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL);
 
 	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
 
-	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+	WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
 static bool gfx_v9_0_check_rlcg_range(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index c893c645a4b2..56d02aa690a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -35,6 +35,9 @@
 #define RREG32_SOC15(ip, inst, reg) \
 	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
+#define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
+	RREG32_NO_KIQ(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
 	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset)
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
