Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A097BC5474A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 05:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3849510E15B;
	Wed, 28 Aug 2024 05:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghdLui+h";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F0C810E15B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 05:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knpRtk8SFd/TKO34aRjBE0E6BuBZ0z28a8P9Phw7IDiQDeQN1O+U2clGAuriYbbwHTgJeLOuLBpHo2i55qpSrCOjFMofs8HcLDNVusKHm37KhEt4lh3bvROcpzCUlfKPBpdASBZk2MXsGsOZV5tPcbGXIP3CFi1QHZWavCQ5x/FNhhwHcrYWgPyrXim6+HjSq+d/v8XOqreWUnbq2MkzEs/M3cdmdX4ZXGR5q96r3cxr8Vp0f+XHE7sybf0fgrMmnpURpw02YG3LDz/j0FMZVPE3HHrqm+I2FdEtfQiGtGQ2+UCNBDASkE69K4XK7o94KhdZ5ID7CR+auNqBE5pQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmLOzQG0wBWdgPGvNumytvw4gmwcHD3C2uF+obh/arM=;
 b=Y4IWI9u6HB2zyq6OoUZpuNemcrM3/rJMSJzqMVV56TtqW1GlRkrNpGV1GFattGkxGHsWA8PeXFJyaYNNyKwnHtOtQB2yaDhwWBxY6z36Q0Hte2lBSROj+NHxz1HaszMiwaIq4QljunJglUyL0Io/UJPp7kxH5hekVGbSE1gHpYLNwTHKGODMovhg7rTcnge+sF+O/dksQiEdxiW67qRCdWD2wiUfwtzre8kc4YlhiXKtY6OL77G1gIWlfyd0azqPiEvvGyWWYxf1souS2HMwjovslXptvH1tuY8+dUPXuLksUwGsh8yeOMEUILqrZRHXdAcpuEjDSluE130e3RVqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmLOzQG0wBWdgPGvNumytvw4gmwcHD3C2uF+obh/arM=;
 b=ghdLui+hWqXW83dMbe9eDaiJ0+U9wGbcf3M8RAyUokRSnVwKPuXrnONmk2L4XWsZGM5I6AHhPJVmo2JbbdJaxkeJkZzi4eJFppWQtDVFHbnyRB1iP5Sazf+fo80JJPUG6S/dh15v0Q5ZBqnitrYx9cuS1oa3N53hFbuxw04+Hp0=
Received: from MW4PR03CA0318.namprd03.prod.outlook.com (2603:10b6:303:dd::23)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 05:20:16 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::b3) by MW4PR03CA0318.outlook.office365.com
 (2603:10b6:303:dd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 05:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 05:20:15 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 00:20:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Le.Ma@amd.com>, "Prike
 Liang" <Prike.Liang@amd.com>
Subject: [PATCH v4] drm/amdgpu/gfx9.4.3: Implement compute pipe reset
Date: Wed, 28 Aug 2024 13:20:04 +0800
Message-ID: <20240828052004.2889428-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: f038b94c-928d-47cf-e64c-08dcc72119d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aez0fM1jiPGLeRjWJ6abz/2lAh2DKz3IVRFj/+hBCFdq1vv7m65KdH8g9B+I?=
 =?us-ascii?Q?K8LwHfMJqG+I6iLsUNJCwKp6kKMVOQH2u1ACIgqAHoU6fYLWajf+mMRq7iRR?=
 =?us-ascii?Q?rmtk8ZtWDlrkmfop47LaHgUeeirXgF04g1uJYvKpsNzEibEKtODwSTymtj1h?=
 =?us-ascii?Q?CMSIeMh6HexmoFCcLf9FE3lvuHjkQxCZ5XZXM17wM2jT3Vaip8mExpr4XLsk?=
 =?us-ascii?Q?4jH4TsqUB3aJkH2CGpreyiUjNogDQ8w9VMzX71a8vzW2PjFFNm2z2ZT4dMvN?=
 =?us-ascii?Q?U5O3rZQzk5jM0xsJe/9Qo2poRzo86ozn42MbJIEBmeb1AaD0iGbECcO9pVA6?=
 =?us-ascii?Q?5nMrHKLEkEe64JbhDRpMliugzagwg7GzCip8VXrep8m/KYHRcERa9YgSj/rV?=
 =?us-ascii?Q?LnJ79JnoXCzMJOVHqqW2KW10UrlTyz+N4VsXNwYvfhAEhyyIGuDi0Ef+eDKp?=
 =?us-ascii?Q?iyBBxKC0e/r5FX0mkvUuBYOGJ2Wvok8klP6XdnjTjufI1f0Rt0TnE39IMqh9?=
 =?us-ascii?Q?/ypbzBrjxKojBZavR333bvh1JVz1kwbigpyJhrgr9EmIy+RajiAoLLFttatn?=
 =?us-ascii?Q?YMAna24n/ZS9/bOWPwxyh4LZHmtZQ268q9/+reQq0HHMKPXJ0LOPQ2sPV6j6?=
 =?us-ascii?Q?31LyALGoIQVzR0/3z87zaavlM5hfvZSCB5qfm0/cp783Mfs82LcV5volzD3k?=
 =?us-ascii?Q?2Wx4UCjMW3JeuXT6S3z6yog7G/q0JQ9T2ctuvVohl5YUMBQ+j/UR3ynCCOid?=
 =?us-ascii?Q?m4qtvN9wxGiEsuAXinOY3XRyMgPbkkB9qImmn3adLsMCGYgww8VVHjz8RKk7?=
 =?us-ascii?Q?WXssJ3tikSeaK96PlK0M8RJLz9Al9dyYkx8ywQ71pPhvjYLJlEPvfpZWJSAB?=
 =?us-ascii?Q?n7/oQUCo8gG1jsUODpDas2bRP4k7VXFuvBIVi/vtN7HTQnoh69rP/8r1N1WF?=
 =?us-ascii?Q?y054a6T4MoUq1UTYpMx5+vGZUn7c7YOOau6Tf7Z9bocyZA9rDmzLpTfV/LeO?=
 =?us-ascii?Q?5zmA4oi95kcOJM/Erlp7O+4SmfYR0V7xYuzHPYfEt5vdNDskg61a27HZUjzD?=
 =?us-ascii?Q?zM64anGAg1nVq4TEiTns1m0EsZS7k4wDqSFWLx1W1DWjQT0OPQXlj/sv0hzk?=
 =?us-ascii?Q?kE0etiJac0I4yjtkbCSdDdTOEKg4cpJMeZop2AgA1xx4PsTb8RjXvsYZtCPM?=
 =?us-ascii?Q?xW2zihkj8hJAHA/AMMx+FPpLJjk1mEiqCxxrhfOVBfooufKlWDVzgZPe9W8a?=
 =?us-ascii?Q?R7BdCf3mAay4WTT+c5paCyx8xJmtka7J4uIAeJ9XUUm5AA8ndjRI14UHXo41?=
 =?us-ascii?Q?a1s+cABWpgnB+hxTcwUWc2J14UrPv3tmxUo3VyHbP0NVeQU45Tnvcpf1vskF?=
 =?us-ascii?Q?/lBgZJd4uP7sYs1uhmlFoU8ShbMIi/XyJjW6lXBLkuEn2+3HEa8tmmEmkwQS?=
 =?us-ascii?Q?JmpfRH8vBIp8JyVQcieg/B5VVOs5SmKS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:20:15.9386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f038b94c-928d-47cf-e64c-08dcc72119d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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

Implement the compute pipe reset, and the driver will
fallback to pipe reset when queue reset fails.
The pipe reset only deactivates the queue which is
scheduled in the pipe, and meanwhile the MEC engine
will be reset to the firmware _start pointer. So,
it seems pipe reset will cost more cycles than the
queue reset; therefore, the driver tries to recover
by doing queue reset first.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 139 ++++++++++++++++++++----
 2 files changed, 124 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index e28c1ebfa98f..d4d74ba2bc27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -143,6 +143,11 @@ struct kiq_pm4_funcs {
 				   uint32_t queue_type, uint32_t me_id,
 				   uint32_t pipe_id, uint32_t queue_id,
 				   uint32_t xcc_id, uint32_t vmid);
+	int (*kiq_reset_hw_pipe)(struct amdgpu_ring *kiq_ring,
+				   uint32_t queue_type, uint32_t me,
+				   uint32_t pipe, uint32_t queue,
+				   uint32_t xcc_id);
+
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2067f26d3a9d..f47b55d6f673 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -166,6 +166,10 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
+					uint32_t queue_type, uint32_t me,
+					uint32_t pipe, uint32_t queue,
+					uint32_t xcc_id);
 
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -323,6 +327,7 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
 	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
 	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
+	.kiq_reset_hw_pipe = gfx_v9_4_3_kiq_reset_hw_pipe,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
@@ -3466,6 +3471,101 @@ static void gfx_v9_4_3_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 	}
 }
 
+static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
+				uint32_t pipe, uint32_t queue,
+				uint32_t xcc_id)
+{
+	int i, r;
+	/* make sure dequeue is complete*/
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me, pipe, queue, 0, GET_INST(GC, xcc_id));
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	else
+		r = 0;
+	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+
+	return r;
+
+}
+
+static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+			adev->gfx.mec_fw_version >= 0x0000009b)
+		return true;
+	else
+		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
+
+	return false;
+}
+
+static int gfx_v9_4_3_kiq_reset_hw_pipe(struct amdgpu_ring *kiq_ring,
+					uint32_t queue_type, uint32_t me,
+					uint32_t pipe, uint32_t queue,
+					uint32_t xcc_id)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	uint32_t reset_pipe, clean_pipe;
+	int r;
+
+	if (!gfx_v9_4_3_pipe_reset_support(adev))
+		return -EINVAL;
+
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+
+	reset_pipe = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL);
+	clean_pipe = reset_pipe;
+
+	if (me == 1) {
+		switch (pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE0_RESET, 1);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE1_RESET, 1);
+			break;
+		case 2:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE2_RESET, 1);
+			break;
+		case 3:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME1_PIPE3_RESET, 1);
+			break;
+		default:
+			break;
+		}
+	} else {
+		if (pipe)
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE1_RESET, 1);
+		else
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+						   MEC_ME2_PIPE0_RESET, 1);
+	}
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, reset_pipe);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL, clean_pipe);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+
+	r = gfx_v9_4_3_unmap_done(adev, me, pipe, queue, xcc_id);
+	return r;
+}
+
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 				unsigned int vmid)
 {
@@ -3473,7 +3573,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r, i;
+	int r;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -3495,26 +3595,25 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	/* make sure dequeue is complete*/
-	amdgpu_gfx_rlc_enter_safe_mode(adev, ring->xcc_id);
-	mutex_lock(&adev->srbm_mutex);
-	soc15_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0, GET_INST(GC, ring->xcc_id));
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-			break;
-		udelay(1);
-	}
-	if (i >= adev->usec_timeout)
-		r = -ETIMEDOUT;
-	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, ring->xcc_id));
-	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, ring->xcc_id);
 	if (r) {
-		dev_err(adev->dev, "fail to wait on hqd deactive\n");
-		return r;
+		dev_err(adev->dev, "kiq ring test failed after ring: %s queue reset\n",
+				ring->name);
+		goto pipe_reset;
+	}
+
+	r = gfx_v9_4_3_unmap_done(adev, ring->me, ring->pipe, ring->queue, ring->xcc_id);
+	if (r)
+		dev_err(adev->dev, "fail to wait on hqd deactive and will try pipe reset\n");
+
+pipe_reset:
+	if(r) {
+		r = gfx_v9_4_3_kiq_reset_hw_pipe(kiq_ring, ring->funcs->type,
+						ring->me, ring->pipe,
+						ring->queue, ring->xcc_id);
+		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
+				r ? "failed" : "successfully");
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

