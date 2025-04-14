Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2108AC369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 10:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC45010E562;
	Mon, 14 Apr 2025 10:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZYfkSV3d";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2646810E562
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 10:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSmBk0P7thpXaeUgvNy1meyUHhB0FszLGAEOWb23Gh46cTFWp/aljJNt9q/bM5fr4L3CMXmDDmo/GBQQxJwGiE2gGasBuCxPUm4HqgnEEsa39i5kw6PfsyE+nBIO0uaZm5xW5c3oq1v4LDm9nSifbJw36ccm3hy4HbhiO/F6nB7Qq8+Ms0H8xdV36PMosgHfyyR+OyuPS9C0SztM+yjUcoeYXffFoG67YqI3bxqor0qXYl+jPLaR+TQu/W/mqKuwZ0T1MjTd9qe0NJ+x+jb642CIXsHg6dTnQHJRPtF6mTOlliyE5HtKFjR+f0O8v4cOG3X4hFY1JgF51j4nODbiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhyUtbPlIP6bpl1yIdo+Es/vvTj5o5x+Lb3uvd1JorI=;
 b=ub1sZMClt4UwAbwlf0gyM0dlfSoJKwLrjmd5s3RZs5gynAO6zH97G2hUinPZTJ4uc/8P2PCjZBmUgrBF4HbBGf/mHZO5gfw1iJQR3JjU/HbMOciNjTdgs4ioRyj9FljyAce46ZfRSm80QtwnK5DL6TZzf/6sPpwcYqhVZou3zDvEVMHpteaG+e/lSjrtBfp0gqA+y3jBw8BeRxHafQFk7eO1u8TJ9PxL7S5doMLGe7/K9Zqna2i4VKUhMDZAR6MuAEzEzUAuVxKrVmb/vXQ6mJEtZ70/qkGbL6Q9+irWLoZaCZW4rk9B39gLepAum6W7NmlllHkZDUEirRnPJymdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhyUtbPlIP6bpl1yIdo+Es/vvTj5o5x+Lb3uvd1JorI=;
 b=ZYfkSV3dJ3evt4WIvMPmSZq3TfLBZFrXrh1YgkCNItkY+SbDU86pTBTRKbHdi9soEQOf8lxDOWsSn0fKI4XjZz8ossmcz0FaUeVWLinzzFAuvN8Wk8uAa3hrauroixtQBGzV8aBSeK5RrqQAANAyl0mv9eYbK6TrvA400oy8pLk=
Received: from SN7PR04CA0106.namprd04.prod.outlook.com (2603:10b6:806:122::21)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 10:48:28 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::42) by SN7PR04CA0106.outlook.office365.com
 (2603:10b6:806:122::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 10:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 10:48:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 05:48:26 -0500
Received: from hjbog17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 14 Apr 2025 05:48:24 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <emily.deng@amd.com>,
 <guoqing.zhang@amd.com>, Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 2/6] drm/amdgpu: update cached GPU addresses for PSP and ucode
Date: Mon, 14 Apr 2025 18:46:51 +0800
Message-ID: <20250414104655.336497-3-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414104655.336497-1-guoqing.zhang@amd.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 629b2ffa-0e5d-4438-f270-08dd7b41e323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rdv16gPGB7lD3SLCqxkVneKZM4NvXec1FqkQoqUvLfdZ7U4/KKtY+PEvVIyw?=
 =?us-ascii?Q?m8+RTcncITH67Boj33wh46hHF/jtNvj47Ng1EckaXP1dRmzDzla2qEAWcAN4?=
 =?us-ascii?Q?tj5fS/Siz2gd8Px4ieZt8REylL22TClP/gXrtK4qj4B2oFo9AmfINd7rsf6m?=
 =?us-ascii?Q?7fZM8pqnI3rkRnQEI01e3mD4e5uWq0+f+JbHb9F15/SwaLBpS9QaNpP1NwLN?=
 =?us-ascii?Q?yXe/Fsx+lC1VtqsK6IL+ZZxLauMo+9l+srhhmMPooyYE5uNGsBBmyszLsRaq?=
 =?us-ascii?Q?Ls4zjR/y6H9MeRcoSCka2tsBXX1VTmfvBabN1qDTEKlglMV9fvnLtoaGnZDg?=
 =?us-ascii?Q?X4Q9ONmRrsk63MCHhY4EyDckq3hQ/iG0IKnv0567rLY1khNgSfxcQzRc3+IN?=
 =?us-ascii?Q?iG/DS3fU7MWEiBvJFNOC18xOJoHRMurVooK6lkvfEa9nAOvoxyIw8yZZUwVS?=
 =?us-ascii?Q?j5/qvJxMjEDwyQITRLH/acyn5zLuFGho/Fk1r2+RvL7WoGXzmQAtZUXW/iKK?=
 =?us-ascii?Q?hLwKgYXNHvC9eXu2MmMQ1owUmiQLhvZRx3AUUCQuwkHVgv/nhxEI7LCvWEpF?=
 =?us-ascii?Q?KD94JQXKzoQkSBrPAs8CfxOGC9GMMgo26ycjKh9BmrNFnSvKwUX2sRED5SQU?=
 =?us-ascii?Q?65IqtH/56ye+CqCxtchzGTO2XlnrdQaiH8YfEgNIiFNeN575ATcAvZwD6C7p?=
 =?us-ascii?Q?YwOjz+w0aEeRASf62wGWpc26ROC2DNUnlwHPQ1x1p7X4AcrnbxwrJazFvRA8?=
 =?us-ascii?Q?cH1zKQmNHMICNukBhDddd28R7Ehp1DmAHCV5WsJp6oqS57k0Q4kc2i/k19eW?=
 =?us-ascii?Q?5j+C7TVQFG/kA9IVlYG01tUyuME7W7l5O32VpLtT5ymACK5qFeTg0y5SEibe?=
 =?us-ascii?Q?Cyh1/TxNCTY7C2LZ4pW4M9T4n7w8wEBkhvrSdgGD5ppEdpix2DTLBn317vu0?=
 =?us-ascii?Q?kh6n9D4D1rC2kHc3JFk95+GA78jwpBQAM+2gjjXLTjlYWa/qGn3hFRTMHmFn?=
 =?us-ascii?Q?b4SR5F3HXwWUzz4E9l/uDjgD2VO70NAsumsdvwDHSVSfyUfRPBtUcL2Tm+gk?=
 =?us-ascii?Q?TQQGirnCcSJFAtdP7bsC2k0bm7WigqhNwJsRNfm0T0BTThhSW+OhnLC5lgtT?=
 =?us-ascii?Q?cwEHaEW1gb1vPcMswHhMvcwb440dXInybdyUM0ZuGxw8bHUzUWNxhMcFpfMt?=
 =?us-ascii?Q?QoAVbu/y7PPmXHSSJkg22vPTUUOBz0nVPIRhB9iPKDnPfvFv8bKosFJ6Yovr?=
 =?us-ascii?Q?QyKW9mxsUm/yNCImITi1hzFtKnpFUFbExAfln2MunQHQzNrvgfguSKlAFQNI?=
 =?us-ascii?Q?UKufY5DFZ7yyHQFT3UMFOjzADdvprrjKL+WCWMc8culwZWiBUEpvt3vvXJoR?=
 =?us-ascii?Q?VLef4cy/mbKufXxkiYUCzqm5rt9+gaQGPMrhI385tb526IjmsjnCPoVESkTX?=
 =?us-ascii?Q?9M935xLNbawYM7Zzjv4ECZ3RGSD52QZGbRiI1sFi5Nu6/NJqH/lba9UiXYSn?=
 =?us-ascii?Q?CTzUh7z+FPJQlZdZAQROd9FO0GMPw+ncjm/h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 10:48:26.9571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629b2ffa-0e5d-4438-f270-08dd7b41e323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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

2 reasons for this change:
1. when pdb0 is enabled, gpu addr from amdgpu_bo_create_kernel() is based
on pdb0, it is not compatible with PSP and ucode, it need to updated
to use original gpu address.
2. Since original address will change after switching to new GPU
index after hibernation, it need to be updated after resume.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
Change-Id: I5d146f486fee4f225f10f8d551c6666720d7d21b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 24 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dbc3313fc141..5d607057619b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -871,6 +871,8 @@ static int psp_tmr_init(struct psp_context *psp)
 					      &psp->tmr_bo, &psp->tmr_mc_addr,
 					      pptr);
 	}
+	if (psp->tmr_bo)
+		psp->tmr_mc_addr = amdgpu_bo_gpu_offset(psp->tmr_bo);
 
 	return ret;
 }
@@ -1210,6 +1212,9 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 	cmd->cmd.cmd_load_ta.app_phy_addr_hi	= upper_32_bits(ta_bin_mc);
 	cmd->cmd.cmd_load_ta.app_len		= context->bin_desc.size_bytes;
 
+	if (context->mem_context.shared_bo)
+		context->mem_context.shared_mc_addr = amdgpu_bo_gpu_offset(context->mem_context.shared_bo);
+
 	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_lo =
 		lower_32_bits(context->mem_context.shared_mc_addr);
 	cmd->cmd.cmd_load_ta.cmd_buf_phy_addr_hi =
@@ -2336,11 +2341,28 @@ bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev)
 	return false;
 }
 
+static void psp_bo_resume(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+
+	if (psp->cmd_buf_bo && psp->cmd_buf_mem) {
+		psp->fw_pri_mc_addr = amdgpu_bo_gpu_offset(psp->fw_pri_bo);
+		psp->fence_buf_mc_addr = amdgpu_bo_gpu_offset(psp->fence_buf_bo);
+		psp->cmd_buf_mc_addr = amdgpu_bo_gpu_offset(psp->cmd_buf_bo);
+	}
+	if (adev->firmware.rbuf && psp->km_ring.ring_mem)
+		psp->km_ring.ring_mem_mc_addr = amdgpu_bo_gpu_offset(adev->firmware.rbuf);
+	memset(psp->fence_buf, 0, PSP_FENCE_BUFFER_SIZE);
+}
+
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
+	psp_bo_resume(adev);
+
 	if (!amdgpu_sriov_vf(adev)) {
 		if ((is_psp_fw_valid(psp->kdb)) &&
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
@@ -3980,6 +4002,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
 
 	mutex_lock(&adev->psp.mutex);
+	fw_pri_mc_addr = amdgpu_bo_gpu_offset(fw_buf_bo);
 	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
 	mutex_unlock(&adev->psp.mutex);
 
@@ -4089,6 +4112,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	memcpy_toio(fw_pri_cpu_addr, adev->psp.vbflash_tmp_buf, adev->psp.vbflash_image_size);
 
 	mutex_lock(&adev->psp.mutex);
+	fw_pri_mc_addr = amdgpu_bo_gpu_offset(fw_buf_bo);
 	ret = psp_update_spirom(&adev->psp, fw_pri_mc_addr);
 	mutex_unlock(&adev->psp.mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 3d9e9fdc10b4..8e4d60aa1c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1152,6 +1152,9 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 		adev->firmware.max_ucodes = AMDGPU_UCODE_ID_MAXIMUM;
 	}
 
+	if (adev->firmware.fw_buf)
+		adev->firmware.fw_buf_mc = amdgpu_bo_gpu_offset(adev->firmware.fw_buf);
+
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
 		if (ucode->fw) {
-- 
2.43.5

