Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D04C77B6D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0234610EFE9;
	Thu, 30 Mar 2023 19:32:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5135E10E54A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgCKrwTV0zc0fzp1glYRcgN5gdwPvqLYIqek5HwOyOu3+rPk6XBrQ68FnxvDn82r+bhiMECag1upii7wOW/wIp3Ssxe2KYMN6UPW75+p2NCOg9wOV/UJou2vURex9mZb0WVr9uLW5I786wtx7DGv5jPPh/s6jg0cDMPS7tMsJnDtOZUCiYBUNe50I8vflP7IgeyD4MZUzbG9qGnsYbU1cLtPvPqvcID3c4ed7QOiRYYlHJRKeMkVubAjLB1Jz4XErpmGkYsNTs0+bvBI9VAiNS4c9WvPL6sIuHolNJfqLn2mwJzkORr3UDa/tmNjYiaupb7VDPpxq4lJCnpkuiNnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5Po3girqK91yrrZvanPI+mPBfnohtebSub7T+84lj0=;
 b=UIkknjJLlrurQzH2YsaaoVWBQ7vBHAeOMpfwGwm07AuB3GHqz41CX/caRiSzMHmztYsNlvf6U5C+w0iwAnWYjsOMKxiKqpvC9HcspgOpzVHQjSJYJ9mSgxsJ0kOhzPd1spv0+640puI9Oi8aIucMBdO+zVK8/7FAeuHi4SridPJaKvDlnH+NlvRcPZ107z8wTtJMVVK3yehCeX8aRa2HQBPBdr3k/SjxsS/nDWaEjJUwKG9lAbAEOcCqRuFoI2Y6eDwer46mvNqDe1tvP3NVq3wkLR8Ee0aOOa1YDuWTszIUuBD0EJ9WWrpNznha6rg0dEmFJBf7jD6j6xBcKSrVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5Po3girqK91yrrZvanPI+mPBfnohtebSub7T+84lj0=;
 b=M8faoaHHmf7faXzgqyctPHAtzhcNBGLny2sW/IQMigLdIea57AzBod8fDbMvK4Ks6FAwpWTDPFqa8qVqBFVO+LlF2ElGckngvESkU5voSoqYfzCSSovDP6OfsjfaKxdbWp1+90h4D3XHalUTOcN4wE5n3pYBvQ1NGB0/J74Du6s=
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 19:32:22 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::b) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amdgpu: Add SOC partition funcs for GC v9.4.3
Date: Thu, 30 Mar 2023 15:31:52 -0400
Message-ID: <20230330193158.1134802-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3ee6e9-1ed7-4292-6f11-08db31557bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rned16saa9AhNVWSNGvgXInGZBk8y0M57vqvWYOwXVUhDCrTGIapGuad9bPw/q9uDS4NIFJtgRuSqorLcPdn46NjZb3h+SlfIT/GCbsmhozPJOkl2N4mv1bT+NebOY8ZLEQmH5DoqUnujBOm9zpzmTyK4DDRX2G2bHfpxwaN7vBDqvC68WErg4OOheh0bJnekpe3IMBXzp2N1AJPuZtsp8St/HxC5xep51pGFUIRrX3KltGC3TSIO1JIFRpUfCpVwJuwEvpOn+Vh5+GSyLAaF0kkYMF2t5M08jc/apJprxke0Kp9BzX9jwWam05L3cNt1d9I0COuc0HjeGuc/ixtU0ghyew8gBCU8GIvsJv5rD6tDNhiFmtx7nRT7F9gAPegZCwbZI/uqO0Noo5l3NFcyjb9TJhnbX2lGAMRgBymsCMRaznt5DgstxfQUXNsoCv1iNXNCsdk0AgFxNVw6NecKRXEw4LWhlGQbCczKDQkEgyCicAW8UZB2yV2w34Giprw+GLe0p1Ihb73BGUsnfexBB3KkLvWrns/HcAwKMzLuasIM9vfcnsD2WGEVi15HaNr/PXeSmUBY/1E+RiIWjsE42J2/zIURl0whKaNnj27ne5hKJAU3ODAr5/aib8mtZgof2hyR0u6ifkF7tnTPEatOQ6TOI7jdGBp2VO9V7MuFLyH9qFVP7ip5V/mQOY27RHB5tXMmSiATpnp824DMSHKr+kR/tcc6szkNUsfQaTYH3RGtt6dY2xdOtRp/gr0dPDl6QUd7eEYIC/WFIPWBQQI/aMYhdeygAnx5T17Ay61tP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(81166007)(356005)(36860700001)(2906002)(47076005)(83380400001)(336012)(426003)(82310400005)(2616005)(1076003)(26005)(186003)(86362001)(6666004)(16526019)(40480700001)(8936002)(7696005)(40460700003)(478600001)(8676002)(70206006)(316002)(5660300002)(70586007)(6916009)(4326008)(54906003)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:22.3531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3ee6e9-1ed7-4292-6f11-08db31557bea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Switching the partition mode configuration of ASIC is SOC
level function rather than something at GFX core level. Add
partition mode switch functions as SOC specific callbacks.
Implement the XCP manager callbacks needed for partition
switch for GC 9.4.3 based ASICs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 232 ++++++++++++++++++
 2 files changed, 236 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 77e3c86b7623..3fc4f090ca49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -269,8 +269,12 @@ struct amdgpu_gfx_funcs {
 			(*query_partition_mode)(struct amdgpu_device *adev);
 	enum amdgpu_memory_partition
 			(*query_mem_partition_mode)(struct amdgpu_device *adev);
+
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     enum amdgpu_gfx_partition mode);
+
+	int (*switch_gfx_partition_mode)(struct amdgpu_device *adev,
+				     int num_xccs_per_xcp);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 2616bdb40418..4264fbd267ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -24,6 +24,12 @@
 #include "soc15.h"
 
 #include "soc15_common.h"
+#include "amdgpu_xcp.h"
+
+#define XCP_INST_MASK(num_inst, xcp_id)                                        \
+	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
+
+#define AMDGPU_XCP_OPS_KFD	(1 << 0)
 
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 {
@@ -119,3 +125,229 @@ u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id)
 
 	return ext_offset;
 }
+
+static int aqua_vanjaram_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
+{
+	enum amdgpu_gfx_partition mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
+	struct amdgpu_device *adev = xcp_mgr->adev;
+
+	if (adev->nbio.funcs->get_compute_partition_mode)
+		mode = adev->nbio.funcs->get_compute_partition_mode(adev);
+
+	return mode;
+}
+
+int __aqua_vanjaram_get_xcc_per_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int mode)
+{
+	int num_xcc, num_xcc_per_xcp = 0;
+
+	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc;
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc / 2;
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc / 3;
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_xcc_per_xcp = num_xcc / 4;
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		num_xcc_per_xcp = 1;
+		break;
+	}
+
+	return num_xcc_per_xcp;
+}
+
+int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+				    enum AMDGPU_XCP_IP_BLOCK ip_id,
+				    struct amdgpu_xcp_ip *ip)
+{
+	struct amdgpu_device *adev = xcp_mgr->adev;
+	int num_xcc_xcp, num_sdma_xcp, num_vcn_xcp;
+	int num_sdma, num_vcn;
+
+	num_sdma = adev->sdma.num_instances;
+	num_vcn = adev->vcn.num_vcn_inst;
+
+	switch (xcp_mgr->mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		num_sdma_xcp = num_sdma;
+		num_vcn_xcp = num_vcn;
+		break;
+	case AMDGPU_DPX_PARTITION_MODE:
+		num_sdma_xcp = num_sdma / 2;
+		num_vcn_xcp = num_vcn / 2;
+		break;
+	case AMDGPU_TPX_PARTITION_MODE:
+		num_sdma_xcp = num_sdma / 3;
+		num_vcn_xcp = num_vcn / 3;
+		break;
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_sdma_xcp = num_sdma / 4;
+		num_vcn_xcp = num_vcn / 4;
+		break;
+	case AMDGPU_CPX_PARTITION_MODE:
+		num_sdma_xcp = 2;
+		num_vcn_xcp = num_vcn ? 1 : 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	num_xcc_xcp = adev->gfx.num_xcc_per_xcp;
+
+	switch (ip_id) {
+	case AMDGPU_XCP_GFXHUB:
+		ip->inst_mask = XCP_INST_MASK(num_xcc_xcp, xcp_id);
+		/* TODO : Assign IP funcs */
+		break;
+	case AMDGPU_XCP_GFX:
+		ip->inst_mask = XCP_INST_MASK(num_xcc_xcp, xcp_id);
+		/* TODO : Assign IP funcs */
+		break;
+	case AMDGPU_XCP_SDMA:
+		ip->inst_mask = XCP_INST_MASK(num_sdma_xcp, xcp_id);
+		/* TODO : Assign IP funcs */
+		break;
+	case AMDGPU_XCP_VCN:
+		ip->inst_mask = XCP_INST_MASK(num_vcn_xcp, xcp_id);
+		/* TODO : Assign IP funcs */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ip->ip_id = ip_id;
+
+	return 0;
+}
+
+static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
+					  enum amdgpu_gfx_partition mode)
+{
+	int num_xcc, num_xccs_per_xcp;
+
+	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+	switch (mode) {
+	case AMDGPU_SPX_PARTITION_MODE:
+		return num_xcc > 0;
+	case AMDGPU_DPX_PARTITION_MODE:
+		return (num_xcc % 4) == 0;
+	case AMDGPU_TPX_PARTITION_MODE:
+		return (num_xcc % 3) == 0;
+	case AMDGPU_QPX_PARTITION_MODE:
+		num_xccs_per_xcp = num_xcc / 4;
+		return (num_xccs_per_xcp >= 2);
+	case AMDGPU_CPX_PARTITION_MODE:
+		return (num_xcc > 1);
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static int __aqua_vanjaram_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
+{
+	/* TODO:
+	 * Stop user queues and threads, and make sure GPU is empty of work.
+	 */
+
+	if (flags & AMDGPU_XCP_OPS_KFD)
+		amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
+
+	return 0;
+}
+
+static int __aqua_vanjaram_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
+{
+	int ret = 0;
+
+	if (flags & AMDGPU_XCP_OPS_KFD) {
+		amdgpu_amdkfd_device_probe(xcp_mgr->adev);
+		amdgpu_amdkfd_device_init(xcp_mgr->adev);
+		/* If KFD init failed, return failure */
+		if (!xcp_mgr->adev->kfd.init_complete)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
+					       int mode, int *num_xcps)
+{
+	int num_xcc_per_xcp, num_xcc, ret;
+	struct amdgpu_device *adev;
+	u32 flags = 0;
+
+	adev = xcp_mgr->adev;
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode))
+		return -EINVAL;
+
+	if (adev->kfd.init_complete)
+		flags |= AMDGPU_XCP_OPS_KFD;
+
+	if (flags & AMDGPU_XCP_OPS_KFD) {
+		ret = amdgpu_amdkfd_check_and_lock_kfd(adev);
+		if (ret)
+			goto out;
+	}
+
+	ret = __aqua_vanjaram_pre_partition_switch(xcp_mgr, flags);
+	if (ret)
+		goto unlock;
+
+	num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
+	if (adev->gfx.funcs->switch_gfx_partition_mode)
+		adev->gfx.funcs->switch_gfx_partition_mode(xcp_mgr->adev,
+						       num_xcc_per_xcp);
+
+	if (adev->nbio.funcs->set_compute_partition_mode)
+		adev->nbio.funcs->set_compute_partition_mode(adev, mode);
+
+	ret = __aqua_vanjaram_post_partition_switch(xcp_mgr, flags);
+unlock:
+	if (flags & AMDGPU_XCP_OPS_KFD)
+		amdgpu_amdkfd_unlock_kfd(adev);
+out:
+	return ret;
+}
+
+int aqua_vanjaram_get_xcp_ip_details(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
+				     enum AMDGPU_XCP_IP_BLOCK ip_id,
+				     struct amdgpu_xcp_ip *ip)
+{
+	if (!ip)
+		return -EINVAL;
+
+	return __aqua_vanjaram_get_xcp_ip_info(xcp_mgr, xcp_id, ip_id, ip);
+}
+
+struct amdgpu_xcp_mgr_funcs aqua_vanjaram_xcp_funcs = {
+	.switch_partition_mode = &aqua_vanjaram_switch_partition_mode,
+	.query_partition_mode = &aqua_vanjaram_query_partition_mode,
+	.get_ip_details = &aqua_vanjaram_get_xcp_ip_details
+};
+
+static int aqua_vanjaram_xcp_mgr_init(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = amdgpu_xcp_mgr_init(adev, AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE, 1,
+				  &aqua_vanjaram_xcp_funcs);
+	if (ret)
+		return ret;
+
+	/* TODO: Default memory node affinity init */
+
+	return ret;
+}
-- 
2.39.2

