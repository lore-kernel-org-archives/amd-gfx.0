Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B646C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC9510E3D0;
	Thu, 30 Mar 2023 19:27:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0020D10E057
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHbthAzosiIgGrzaMkxlC0kkrPYv340roSWxBl3vJ4mFPKXsiJnNf7rnuEa38v4eC7hFp5EbjXD1H9Pinc2VVQlpi/VlsI34XwIKdc+DAY1VF3YqzAFWaHoBL9atshet+NQeZ5bdIJklGgwUTtgE3X30GAtD29VG+k5NM+hCpdzW3vywGnFg+4MlpXBxkerdErzaJ6YLSQieVuhG8//xHSaNBLChBVkh4bAysYPseZyZZVUWVLx63sPJbga7S8nPnYsEUB7CczDm12OGuZohRcads9Q4Fh2Wgo7fChlD71GXXhPZ6v/RMZpiyWuYHChXRoiK7Jnl5LFwzaNsLdLjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXCuSXPNrAijOszX8sXC0BjijZ9FjQbTQ6eTw4f1cWE=;
 b=edP1ClgbdulOJnuSeHU+5BJvUUIsEr+xipsdkMXMGIbcSsti+F26YiPWee0ZWGr3vi/ooNem2kk8QNI5H7EbC0623Q8nieyagnencuRYZPKsxFilXZU0TXu03nP1rMEwhQvX6eFLLodQUTkysc9i45jmN/KVyLlzqVCBcOqnLXI0eZwTCalN74cO7phXxwSLtLzG4v7oufjHpdES/TjaI0I5y4LMwHr+dyEYF+2kDekVmKFU9JalxTh893IZ8W9uIeKmanumpcf/OWtUERmvbK7uFAl4QkNd8HmJgBXhcbOJgb+6TzEeiYwSPflLlC8mc0woXUECwhFtnxLMmeI+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXCuSXPNrAijOszX8sXC0BjijZ9FjQbTQ6eTw4f1cWE=;
 b=tNmQm5DFhu4J71IUrM9xNeayiyrGL4NnVqsRK+a/S/wFfKraqYodhG2nsleIzARSuyAH23jA7Rrik2SHZ/OUEx1ri9lz3Pvqqghk8fmW3rVZb0ldLWuyvJjP43ozKTOiTD9mkMawXyFC5QqLxd4Suz3lDbY5s0DawWfTENBVPJU=
Received: from BN8PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:60::17)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:27:10 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::a) by BN8PR12CA0004.outlook.office365.com
 (2603:10b6:408:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amdgpu: detect current GPU memory partition mode
Date: Thu, 30 Mar 2023 15:26:49 -0400
Message-ID: <20230330192657.1134433-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: c98ae6bd-0f07-4691-4a3c-08db3154c1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9O203t0Da0PlFw6EJArSmkeZnaLzG1hPnVz0UYnkirjvzXyqjv69XzV4s7L78tCfEEqprpIhQ30ZTjt3lorOoj3SPnZIveMSijUTneDuM70FSmTRYl7Khpnr8+5dp4bIzvB5572yxWmaJYYa74BniWCkwNnlwGWB2WkifJ/9VSh3whAaf1tFxDM0iLfil7MkeAv2swtHuRPWXHhE8dFiNTBkXwFmlHJA5c8Lpq3pqELsMxRL1Dyl8NSqNFfUXB9ZuwO19c2gZQF/woaflYEQc2V6Od4glrjCZDKyLQNrIP7h2iA/+8sSJqpWGkjfNEpsKPJVXMbrUaVGgQgOojUun8QB152CugOtiEYuqNn1olO/2FEcHf7okoUeILxEvC0H8TtLnVhzUtPBdXHkwmYmXyzQxRPTh8F+b5h74ygtYr61czT3OkeI1UMjiOo8JGret73vy8qOaL/hA/qTVwHTtySrqBW7yaoJydgeTUDYzOHq/K0v0HFJu8HzlXaBAv66/5Ml8/t4tdL8PuIGyS7KJnuvncHY95Ff38pJd2FnhNGEuHM5Mioqy9j9y/MvRvHxCsZ83C0KVXUqAiLisjGRi7lP2yV3YQ1fDrboSEQtY72rPKTFHVlzkaxwvXN2V7By8WOJcvpy+4YfQ7eRSZ5E19fo9HUyN7SP4f2r9jsBw5dy1xw3kbaNZmJ3EhVE/z+PUKpZZOahJ+xhGK8dhuWA60F0AhuuUghq14VK2sL/mCQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(82310400005)(186003)(4326008)(6916009)(16526019)(8676002)(478600001)(40460700003)(54906003)(316002)(36860700001)(6666004)(40480700001)(1076003)(26005)(36756003)(7696005)(8936002)(5660300002)(47076005)(336012)(86362001)(83380400001)(2906002)(426003)(356005)(41300700001)(82740400003)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:10.3090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c98ae6bd-0f07-4691-4a3c-08db3154c1ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
Cc: Alex
 Deucher <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Ori Messinger <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

 - Add helpers to detect the current GPU memory partition.
 - Add current memory partition mode sysfs node.

Tested-by: Ori Messinger <Ori.Messinger@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 25 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 12 ++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c69e4f412963..febdd074bc1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1122,6 +1122,24 @@ static ssize_t amdgpu_gfx_get_current_compute_partition(struct device *dev,
 	return sysfs_emit(buf, "%s\n", partition_mode);
 }
 
+static ssize_t amdgpu_gfx_get_current_memory_partition(struct device *dev,
+						struct device_attribute *addr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_memory_partition mode;
+	static const char *partition_modes[] = {
+		"UNKNOWN", "NPS1", "NPS2", "NPS4", "NPS8"
+	};
+	BUILD_BUG_ON(ARRAY_SIZE(partition_modes) <= AMDGPU_NPS8_PARTITION_MODE);
+
+	mode = min((int)adev->gfx.funcs->query_mem_partition_mode(adev),
+		AMDGPU_NPS8_PARTITION_MODE);
+
+	return sysfs_emit(buf, "%s\n", partition_modes[mode]);
+}
+
 static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 						struct device_attribute *addr,
 						const char *buf, size_t count)
@@ -1229,6 +1247,9 @@ static DEVICE_ATTR(current_compute_partition, S_IRUGO | S_IWUSR,
 static DEVICE_ATTR(available_compute_partition, S_IRUGO,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
+static DEVICE_ATTR(current_memory_partition, S_IRUGO,
+		   amdgpu_gfx_get_current_memory_partition, NULL);
+
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -1241,5 +1262,9 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = device_create_file(adev->dev, &dev_attr_current_memory_partition);
+	if (r)
+		return r;
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 4995d9e16ee0..0b4057753a4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -71,6 +71,14 @@ enum amdgpu_pkg_type {
 	AMDGPU_PKG_TYPE_UNKNOWN,
 };
 
+enum amdgpu_memory_partition {
+	UNKNOWN_MEMORY_PARTITION_MODE = 0,
+	AMDGPU_NPS1_PARTITION_MODE = 1,
+	AMDGPU_NPS2_PARTITION_MODE = 2,
+	AMDGPU_NPS4_PARTITION_MODE = 3,
+	AMDGPU_NPS8_PARTITION_MODE = 4,
+};
+
 struct amdgpu_mec {
 	struct amdgpu_bo	*hpd_eop_obj;
 	u64			hpd_eop_gpu_addr;
@@ -259,6 +267,8 @@ struct amdgpu_gfx_funcs {
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
 	enum amdgpu_gfx_partition
 			(*query_partition_mode)(struct amdgpu_device *adev);
+	enum amdgpu_memory_partition
+			(*query_mem_partition_mode)(struct amdgpu_device *adev);
 	int (*switch_partition_mode)(struct amdgpu_device *adev,
 				     enum amdgpu_gfx_partition mode);
 };
@@ -393,6 +403,7 @@ struct amdgpu_gfx {
 
 	enum amdgpu_gfx_partition	partition_mode;
 	uint16_t 			xcc_mask;
+	enum amdgpu_memory_partition	mem_partition_mode;
 	uint32_t			num_xcc_per_xcp;
 	struct mutex			partition_mutex;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index 8fa3a1f3b181..639b86c4d664 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -97,6 +97,7 @@ struct amdgpu_nbio_funcs {
 	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
 	u32 (*get_rom_offset)(struct amdgpu_device *adev);
 	u32 (*get_compute_partition_mode)(struct amdgpu_device *adev);
+	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev);
 	void (*set_compute_partition_mode)(struct amdgpu_device *adev,
 					   enum amdgpu_gfx_partition mode);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 3ea88a909380..0c153d4e8d4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -611,6 +611,16 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 {
 	soc15_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));
 }
+static enum amdgpu_memory_partition
+gfx_v9_4_3_query_memory_partition(struct amdgpu_device *adev)
+{
+	enum amdgpu_memory_partition mode = UNKNOWN_MEMORY_PARTITION_MODE;
+
+	if (adev->nbio.funcs->get_memory_partition_mode)
+		mode = adev->nbio.funcs->get_memory_partition_mode(adev);
+
+	return mode;
+}
 
 static enum amdgpu_gfx_partition
 gfx_v9_4_3_query_compute_partition(struct amdgpu_device *adev)
@@ -680,6 +690,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
         .select_me_pipe_q = &gfx_v9_4_3_select_me_pipe_q,
         .query_partition_mode = &gfx_v9_4_3_query_compute_partition,
         .switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
+	.query_mem_partition_mode = &gfx_v9_4_3_query_memory_partition,
 };
 
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index a3220dc9a59e..66513f9e07f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -30,6 +30,8 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+#define NPS_MODE_MASK 0x000000FFL
+
 static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -406,6 +408,15 @@ static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
 }
 
+static enum amdgpu_memory_partition nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev)
+{
+	u32 tmp;
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+	tmp = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS, NPS_MODE);
+
+	return ffs(tmp);
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
@@ -428,4 +439,5 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
 	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
 	.get_compute_partition_mode = nbio_v7_9_get_compute_partition_mode,
 	.set_compute_partition_mode = nbio_v7_9_set_compute_partition_mode,
+	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
 };
-- 
2.39.2

