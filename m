Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A3C10F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 14:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39B62464B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XR+mWoNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39B62464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2DE6E0BF;
	Tue, 10 Mar 2020 14:07:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401006E0BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 14:07:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds2RRdVBVIApmYGeSqCBn5X4mY7hMzI4KD4oZrC5xidPKEnukiDU4UAXB8GL64Li4OO8AhSZkXQSjB+f6B57Gk0kTdsDtcc+blibbmwFQu11nfthJ/UhQlk8kKAvZQDQAeb8zMGdFZGNLLJG4P/98ngIj00fDRRTdH3cpx8bHWcI0I5RCsTgiIIbA2YvpyjdokhGyb7uQ/D9EBfR8sHbq3CoRgUk7nf4ndfPNa7rz0WD5XTZXWonbv3huoypKskJw/YNGQeNuB8i1yfteRIZOj72jxQV4QQyfSCZAsou/Bu/dZiy5yqkkveKZzJo5AHOP8v2eFfSNzPVWHEZ+HcorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrHHTRaP7NrBzOx1X9nlZzJ+yrT1ADfkExeKOFq2+G4=;
 b=U0TjrLRbHC0e6qMURYhyZ5pHkA5MkDe294ZtyJBozaEsU2eJgZqhVExkyIS7H8op4yScYcjQuM+H7eOFNbSRTz/iB0Jn9aZACCOqnJS+3PwobKMO4Nh0AaGB+9qcpTnZVYkx08kZCpnYL/lhOJWnUyRw65WRL+ND/iIei+fWwjlVoJHkHo39q+W45Hk6it20taQZYR7wlzMYMpT8Q2ki3lL9c3ygjWo3tnQZQt24Zwu6X9wrRUgr3lN2vlsBE+tCzasCBWXIHHLENCYhraJU3quNQQBXzGRjd/VXmJn4mwWHhXbRsUydPFs94KhgNSaFjUNVCZ3vmPKnk8cUMUGENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrHHTRaP7NrBzOx1X9nlZzJ+yrT1ADfkExeKOFq2+G4=;
 b=XR+mWoNTo5FenYT1/x/uhm3UcHvfmc2SqCI5ik7uWNjxJwlQrzVeVXT66XDEftDr4Fsc7yN82Zvibih2Pa4Lc2QgLT3+2ZuUrAq7b42raOCtWt2HMcw8E4aV8m4uLiTpGZToMk9pjhs2y2Oym3kk3uDw0jrE15oNAwiHhDaXJbc=
Received: from MN2PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:c0::30)
 by SN6PR12MB2653.namprd12.prod.outlook.com (2603:10b6:805:6f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 14:07:22 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::8c) by MN2PR05CA0017.outlook.office365.com
 (2603:10b6:208:c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.7 via Frontend
 Transport; Tue, 10 Mar 2020 14:07:22 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 14:07:22 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:07:21 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 10 Mar 2020 09:07:20 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: refactor RLCG access path part 1
Date: Tue, 10 Mar 2020 22:07:16 +0800
Message-ID: <1583849237-28789-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(428003)(189003)(199004)(6666004)(426003)(2616005)(336012)(356004)(316002)(54906003)(5660300002)(30864003)(4326008)(7696005)(2906002)(70206006)(6916009)(86362001)(478600001)(70586007)(81166006)(26005)(81156014)(8676002)(186003)(8936002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2653; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf56ee67-b664-4c97-e44f-08d7c4fc5a47
X-MS-TrafficTypeDiagnostic: SN6PR12MB2653:
X-Microsoft-Antispam-PRVS: <SN6PR12MB265315654757797ADD798DAA84FF0@SN6PR12MB2653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 033857D0BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cev5pa6XcDT/U9wG2IV/dq+0WDWqLeCC7E1ft4P3fYOTQuTQsInpgmzgnI/bgOFDp5G9RZc0RagNmLWmf6W0qI2dn+o4OZAyZtTqb/7d49vXez48kLkQ4fx+qg+Uu0tLk9jcAp8dKcEvEAWLWzjmGC/5hjrT0CgVHlFI6+5Bct6VpBsqM3yS7HhzWLKtKmtCjqVvx3ki3oNvC/V0+dVV4h6PgfK1ba9rM6IZwPyoWWEMq3wUA3nYPmH+HrX3qPf+N5Mw/w4S2RXXj908hJMG5x3FhxICf2fprQhJUC9+7+WZ92K4yZoTxb1JQcOuH2jLaB2VFP5vGtyiKBfZpLUkJ0lTtVPS7tKrdEvqLki0oxAA3NVjVmDiFjIXR/GDLIMjSI/5xatAKiiJZc0Bz03qyWjvI1AGs3nWwrNv960avcRHQZjsi8o4dqIaGYOJWbg+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 14:07:22.1238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf56ee67-b664-4c97-e44f-08d7c4fc5a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
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

what changed:
1)provide new implementation interface for the rlcg access path
2)put SQ_CMD/SQ_IND_INDEX/SQ_IND_DATA to GFX9 RLCG path to align with
SRIOV RLCG logic

background:
we what to clear the code path for WREG32_RLC, to make it only covered
and handled by amdgpu_mm_wreg() routine, this way we can let RLCG
to serve the register access even through UMR (via debugfs interface)
the current implementation cannot achieve that goal because it can only
hardcode everywhere, but UMR only pass "offset" as varable to driver

tested-by: Monk Liu <monk.liu@amd.com>
tested-by: Zhou pengju <pengju.zhou@amd.com>
Signed-off-by: Zhou pengju <pengju.zhou@amd.com>
Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  80 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 177 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/soc15.h      |   7 ++
 4 files changed, 264 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 52509c2..60bb3e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,6 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
+	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v);
+	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
 struct amdgpu_rlc {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 82ef08d..3222cd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -224,6 +224,56 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
 };
 
+static const struct soc15_reg_rlcg rlcg_access_gc_10_0[] = {
+	{SOC15_REG_ENTRY(GC, 0, mmRLC_CSIB_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmRLC_CSIB_ADDR_LO)},
+	{SOC15_REG_ENTRY(GC, 0, mmRLC_CSIB_LENGTH)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_ME_CNTL)},
+};
+
+static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+{
+	static void *scratch_reg0;
+	static void *scratch_reg1;
+	static void *scratch_reg2;
+	static void *scratch_reg3;
+	static void *spare_int;
+	static uint32_t grbm_cntl;
+	static uint32_t grbm_idx;
+	uint32_t i = 0;
+	uint32_t retries = 50000;
+
+	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
+	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
+	scratch_reg2 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
+	scratch_reg3 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+	spare_int = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;
+
+	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
+	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
+
+	if (amdgpu_sriov_runtime(adev)) {
+		pr_err("shoudn't call rlcg write register during runtime\n");
+		return;
+	}
+
+	writel(v, scratch_reg0);
+	writel(offset | 0x80000000, scratch_reg1);
+	writel(1, spare_int);
+	for (i = 0; i < retries; i++) {
+		u32 tmp;
+
+		tmp = readl(scratch_reg1);
+		if (!(tmp & 0x80000000))
+			break;
+
+		udelay(10);
+	}
+
+	if (i >= retries)
+		pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
+}
+
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
 {
 	/* Pending on emulation bring up */
@@ -4247,6 +4297,32 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
+static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev,
+					uint32_t offset,
+					struct soc15_reg_rlcg *entries, int arr_size)
+{
+	int i;
+	uint32_t reg;
+
+	for (i = 0; i < arr_size; i++) {
+		const struct soc15_reg_rlcg *entry;
+
+		entry = &entries[i];
+		reg = adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		if (offset == reg)
+			return true;
+	}
+
+	return false;
+}
+
+static bool gfx_v10_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offset)
+{
+	return gfx_v10_0_check_rlcg_range(adev, offset,
+					(void *)rlcg_access_gc_10_0,
+					ARRAY_SIZE(rlcg_access_gc_10_0));
+}
+
 static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v10_0_set_safe_mode,
@@ -4258,7 +4334,9 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
 	.stop = gfx_v10_0_rlc_stop,
 	.reset = gfx_v10_0_rlc_reset,
 	.start = gfx_v10_0_rlc_start,
-	.update_spm_vmid = gfx_v10_0_update_spm_vmid
+	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
+	.rlcg_wreg = gfx_v10_rlcg_wreg,
+	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
 static int gfx_v10_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 87747b3..1fc430d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -697,6 +697,96 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_1_arct[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_FIFO_SIZES, 0xffffffff, 0x00000f00),
 };
 
+static const struct soc15_reg_rlcg rlcg_access_gc_9_0[] = {
+	{SOC15_REG_ENTRY(GC, 0, mmGRBM_GFX_INDEX)},
+	{SOC15_REG_ENTRY(GC, 0, mmGRBM_GFX_CNTL)},
+	{SOC15_REG_ENTRY(GC, 0, mmSQ_IND_INDEX)},
+	{SOC15_REG_ENTRY(GC, 0, mmSQ_IND_DATA)},
+	{SOC15_REG_ENTRY(GC, 0, mmSQ_CMD)},
+	{SOC15_REG_ENTRY(GC, 0, mmGRBM_CNTL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_ME_CNTL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_MQD_BASE_ADDR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_MQD_BASE_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_MQD_CONTROL)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_AGP_BASE)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_AGP_BOT)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_AGP_TOP)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_FB_LOCATION_BASE)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_FB_LOCATION_TOP)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_MX_L1_TLB_CNTL)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR)},
+	{SOC15_REG_ENTRY(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR)},
+	{SOC15_REG_ENTRY(GC, 0, mmPA_SC_BINNER_EVENT_CNTL_3)},
+	{SOC15_REG_ENTRY(GC, 0, mmPA_SC_ENHANCE)},
+	{SOC15_REG_ENTRY(GC, 0, mmPA_SC_ENHANCE_1)},
+	{SOC15_REG_ENTRY(GC, 0, mmRLC_CP_SCHEDULERS)},
+	{SOC15_REG_ENTRY(GC, 0, mmRLC_CSIB_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmRLC_CSIB_ADDR_LO)},
+	{SOC15_REG_ENTRY(GC, 0, mmRLC_CSIB_LENGTH)},
+	{SOC15_REG_ENTRY(GC, 0, mmSH_MEM_BASES)},
+	{SOC15_REG_ENTRY(GC, 0, mmSH_MEM_CONFIG)},
+	{SOC15_REG_ENTRY(GC, 0, mmVM_L2_CNTL)},
+	{SOC15_REG_ENTRY(GC, 0, mmVM_L2_CNTL2)},
+	{SOC15_REG_ENTRY(GC, 0, mmVM_L2_CNTL3)},
+	{SOC15_REG_ENTRY(GC, 0, mmVM_L2_CNTL4)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_DEQUEUE_REQUEST)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_EOP_BASE_ADDR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_EOP_CONTROL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_EOP_RPTR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_IB_CONTROL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_IQ_TIMER)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PERSISTENT_STATE)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PIPE_PRIORITY)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_BASE)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_BASE_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_CONTROL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_RPTR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_RPTR_REPORT_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_WPTR_LO)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_WPTR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_QUEUE_PRIORITY)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_VMID)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_ACTIVE)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_QUANTUM)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_IB_BASE_ADDR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_IB_RPTR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_IQ_RPTR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_DMA_OFFLOAD)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_OFFLOAD)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_SEMA_CMD)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_MSG_TYPE)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_ATOMIC0_PREOP_LO)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_ATOMIC0_PREOP_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_ATOMIC1_PREOP_LO)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_ATOMIC1_PREOP_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_HQ_SCHEDULER0)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_HQ_STATUS0)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_HQ_CONTROL0)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_HQ_SCHEDULER1)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_HQ_STATUS1)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_HQ_CONTROL1)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_EOP_WPTR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_EOP_EVENTS)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_CNTL_STACK_SIZE)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_WG_STATE_OFFSET)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_CTX_SAVE_SIZE)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_ERROR)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_EOP_WPTR_MEM)},
+	{SOC15_REG_ENTRY(GC, 0, mmCP_HQD_AQL_CONTROL)},
+};
+
 static const u32 GFX_RLC_SRM_INDEX_CNTL_ADDR_OFFSETS[] =
 {
 	mmRLC_SRM_INDEX_CNTL_ADDR_0 - mmRLC_SRM_INDEX_CNTL_ADDR_0,
@@ -721,6 +811,63 @@ static const u32 GFX_RLC_SRM_INDEX_CNTL_DATA_OFFSETS[] =
 	mmRLC_SRM_INDEX_CNTL_DATA_7 - mmRLC_SRM_INDEX_CNTL_DATA_0,
 };
 
+void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
+{
+	static void *scratch_reg0;
+	static void *scratch_reg1;
+	static void *scratch_reg2;
+	static void *scratch_reg3;
+	static void *spare_int;
+	static uint32_t grbm_cntl;
+	static uint32_t grbm_idx;
+	bool shadow;
+
+	scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
+	scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
+	scratch_reg2 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG2)*4;
+	scratch_reg3 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG3)*4;
+	spare_int = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmRLC_SPARE_INT_BASE_IDX] + mmRLC_SPARE_INT)*4;
+
+	grbm_cntl = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_CNTL_BASE_IDX] + mmGRBM_GFX_CNTL;
+	grbm_idx = adev->reg_offset[GC_HWIP][0][mmGRBM_GFX_INDEX_BASE_IDX] + mmGRBM_GFX_INDEX;
+
+	if (amdgpu_sriov_runtime(adev)) {
+		pr_err("shoudn't call rlcg write register during runtime\n");
+		return;
+	}
+
+	if (offset == grbm_cntl || offset == grbm_idx)
+		shadow = true;
+
+	if (shadow) {
+		if (offset  == grbm_cntl)
+			writel(v, scratch_reg2);
+		else if (offset == grbm_idx)
+			writel(v, scratch_reg3);
+
+		writel(v, ((void __iomem *)adev->rmmio) + (offset * 4));
+	} else {
+		uint32_t i = 0;
+		uint32_t retries = 50000;
+
+		writel(v, scratch_reg0);
+		writel(offset | 0x80000000, scratch_reg1);
+		writel(1, spare_int);
+		for (i = 0; i < retries; i++) {
+			u32 tmp;
+
+			tmp = readl(scratch_reg1);
+			if (!(tmp & 0x80000000))
+				break;
+
+			udelay(10);
+		}
+		if (i >= retries)
+			pr_err("timeout: rlcg program reg:0x%05x failed !\n", offset);
+	}
+
+}
+
 #define VEGA10_GB_ADDR_CONFIG_GOLDEN 0x2a114042
 #define VEGA12_GB_ADDR_CONFIG_GOLDEN 0x24104041
 #define RAVEN_GB_ADDR_CONFIG_GOLDEN 0x24000042
@@ -4783,6 +4930,32 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 	WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
 }
 
+static bool gfx_v9_0_check_rlcg_range(struct amdgpu_device *adev,
+					uint32_t offset,
+					struct soc15_reg_rlcg *entries, int arr_size)
+{
+	int i;
+	uint32_t reg;
+
+	for (i = 0; i < arr_size; i++) {
+		const struct soc15_reg_rlcg *entry;
+
+		entry = &entries[i];
+		reg = adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		if (offset == reg)
+			return true;
+	}
+
+	return false;
+}
+
+static bool gfx_v9_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offset)
+{
+	return gfx_v9_0_check_rlcg_range(adev, offset,
+					(void *)rlcg_access_gc_9_0,
+					ARRAY_SIZE(rlcg_access_gc_9_0));
+}
+
 static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.is_rlc_enabled = gfx_v9_0_is_rlc_enabled,
 	.set_safe_mode = gfx_v9_0_set_safe_mode,
@@ -4795,7 +4968,9 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.stop = gfx_v9_0_rlc_stop,
 	.reset = gfx_v9_0_rlc_reset,
 	.start = gfx_v9_0_rlc_start,
-	.update_spm_vmid = gfx_v9_0_update_spm_vmid
+	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
+	.rlcg_wreg = gfx_v9_0_rlcg_wreg,
+	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
 static int gfx_v9_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index d0fb7a6..b03f950 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -42,6 +42,13 @@ struct soc15_reg_golden {
 	u32	or_mask;
 };
 
+struct soc15_reg_rlcg {
+	u32	hwip;
+	u32	instance;
+	u32	segment;
+	u32	reg;
+};
+
 struct soc15_reg_entry {
 	uint32_t hwip;
 	uint32_t inst;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
