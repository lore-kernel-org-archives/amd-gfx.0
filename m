Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DABD3A679
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9859810E6C9;
	Tue, 29 Oct 2024 17:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e032aajV";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E6610E3A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb4iJuhCkmX6mEcJ7XkzIzM0l7emlr01XqxjG4TMlrX+apo5/MjUgmMcs6Ld9iaQVpDxAqkrgmB7isIIDi8v+quSXRuidlzbEpshjrGXR0Jis8ONoMSlC4M8ThjVqYx7HEb/hBJiHfO0bmVco+yQkffLh6UoDf1GcGQHMwaHQOpX4tRWCr3cm6C3VznmMdrorFcJw2K8xg+W5uEuGHtddft4wEBZ2hBKM/iO7RbYCCiehND9dCcmCNFrVjlOyLyfDzPUware0D21p6k/f0+ixu0Ht61nXT9kgtgG/V4MkbfLLiOJgy7KhwbtVfiD37XLwZ0y95hiLuvpf6kpxPEdOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szsWM7Mn3110OPWQS6j8hYahiirsiQ+R0LHq8OIixNk=;
 b=azyzZ/YGkb0wmFyN8hq30C3eMLIVsJh0s30P8ThRgq4Jw/p6dg2TDgqr5YSfUrrQSgUMVLFY7oESX5BRFO6SdQfmPtmrEx53EGrAh99HKLHwlSaxpttH/Wy7XoTZHYtLxiQx0QOWxtDKG7i6irZ2LRhOA0t5zOKM+du58tA2z+m4vH+qof54k/wrTB7iBc/z9/+xkImQPU5NBkhzZAMNWF+emOCliH+AfuEvqiT6hEr0UvIdeoDTcPEEKsmVZm0ojwAKjLZkSrpqgrkndHOroLXr8I3nu8Fh6+Xn+Vnl0lHevYrxdnrbSi1rTT0sOBM478NogQHN0IUZkdTHTy+7xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szsWM7Mn3110OPWQS6j8hYahiirsiQ+R0LHq8OIixNk=;
 b=e032aajVqwtIUJYPHel0gPOowZBQONvPHcjFPfpwbgP5BZ/o3LvUDzfIMLVZvfFBg8Mtkn/VziauDJI0DrB1U8M0btac2nX8LeCILeKhfwqD8SjIxbQxahnPTyF0dLXiFragrVbbJn/XRv0fBI1uTAU26Qaf6gqJjlt4Ytfggvg=
Received: from SN6PR16CA0053.namprd16.prod.outlook.com (2603:10b6:805:ca::30)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:43:06 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::f0) by SN6PR16CA0053.outlook.office365.com
 (2603:10b6:805:ca::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:05 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:58 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 15/29] drm/amdgpu: power vcn 4_0_3 by instance
Date: Tue, 29 Oct 2024 13:42:26 -0400
Message-ID: <20241029174240.682928-16-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 411b4455-6fb6-4a2a-36bd-08dcf8412535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGhvZ0EvY3h6bkdUdFJhS3g2VUhjeERaWU1YYmF5VENBTjRBZjYzeWxrOW02?=
 =?utf-8?B?WFlJc3Z4WUpRSzlWR3RzU0V3eUh0ZEtLWHZyUmUwYzJSdHNZVWsrQ3gvZCt2?=
 =?utf-8?B?dURQUzRSeXdUa0NnSk5lTkg4bFQzUVdacHFZS2J6RWpic0Vqb1JaWVp0Y1VQ?=
 =?utf-8?B?djBHK3VHNDFmUkdEd2lJYldxZVRYVXhsRmlvV0RLaHJSUTgySStLNWZGQUZM?=
 =?utf-8?B?VldtemtOaXpQUkRabVpISmpMeXhJdWVHQWUzL3hhWHU5OFpNTGlCS1VZSDBS?=
 =?utf-8?B?WWxGcXZHZSt3TmVPZ1ZOaDFwWEdPWmtlbXFWMmg3azY2bUtGNHJBU0ZNWm50?=
 =?utf-8?B?US9QNlhLZ1hBaXlndEZvZlFud3pxSldoemVDVW4vS2JuSnEwak1yUklyZHlV?=
 =?utf-8?B?LzVTVGFacUd0U0RienVSam0yNU1YSEZTeG81T0JMUFUyRUtNOWlXOHhPbktu?=
 =?utf-8?B?b1UrL3lOZ0FLUElub2IzdS9hSnljK1p6MVcyU1N0eURWOUJJRlJKZXRtSVR2?=
 =?utf-8?B?Ui8yRVpQd3hQbTJYbHV0ek40Qkt2bCsyVUQzZENhczFhTnpneXB4MFNWWFJ3?=
 =?utf-8?B?L0l6WXBtMFQxYVBZOUxSSXNVOVY2Zll3S1o0UTlpR3doenpsdk8rZldpWFBR?=
 =?utf-8?B?M2tMTmxzNWhHQlN4eXc4MGdpRUFMQjJYYkZlc0dLbTZLWTZFR25MbzQ5dVZM?=
 =?utf-8?B?Q3VFenoya1ozRzlQVHExT3hoU1hyR256WGdkSUxvM3Q0YkpQYjhWa0pUamhE?=
 =?utf-8?B?TUpDNDFrcTRPQW92Y29CZThMS2E4R2NwYjlrRkRXSjV1NzlFamJ0cFVUcFoy?=
 =?utf-8?B?VnlENDRrakc4dUdHeTBlTzZrZ0ZMeHg5NkwxQ1J3VkxianRFc0dIb3cvMHkz?=
 =?utf-8?B?QXJpSXlCQ2ZwTkh4MEw4QXhGazlJRDRhYTBCT1JwUHU0MU1DV25RanFtWFkz?=
 =?utf-8?B?WjA0N1UvWkFPYmFJbVMvL3dpcUNpK0ZpOGtjbWFZcTFxRWNvU0t1S2ZyTmMw?=
 =?utf-8?B?a0Y5YU5KTWVHZ29ISDVDaUFtb25ISWZoUXZVeS82ZG1tSHkvUHRjR1MrMldI?=
 =?utf-8?B?dXVIRlJGLzBDYWZWQzBHbFF6ZHg5MEF6VlJwamZiU1VTdDdiS3V4TkxxbFYv?=
 =?utf-8?B?RXh6M3pyVnJtSEJtVjR5bWY0em1wdkgwMVpHQjk0SGZjblBnTXVyQyt4UVJy?=
 =?utf-8?B?RWhqbWhtUGFDSThOcGhyeTRQenQ1MWVreERLTnB3UjlBTG95OFROZ0NuSkVW?=
 =?utf-8?B?aUhqUDFlUVhzNTQ4VVpRKzhScFdpVTJBdnhMNG9GY211emNzaVgwZXc5MXJV?=
 =?utf-8?B?YkxtdjlaeHMydjVqMHljZDlJd2FUQlFPaVpneVNDWEMwWlVNSlVCclVxbXl6?=
 =?utf-8?B?QUhzOUZ1UG5QVmRkSkd2V2FyOFlvYmxSeEJmSjJDWU9XYkYyNFJxbDV2a3JJ?=
 =?utf-8?B?MDBZRTY0b1RhSW56WUlVbENodnYxVmZUeTFtVWYxcm1CNFpkTHFFQTRraE5R?=
 =?utf-8?B?RHdrTHZldUJ3ajloVXNLVlJxVWlCczJEeTFJK2NEUWtadjVPanpDNkF6eHpB?=
 =?utf-8?B?ZDQybWpQTVYxcnNualNxdERxdGpPaEE0eG9ic1hYQTNRZ1pOZ1FDbDJVYmIy?=
 =?utf-8?B?Q21KM3A0bThBSkdIQk1Pd0FsOU5YODl5NnU4ajRRNXgzQWVIR2JTNVhvc3kz?=
 =?utf-8?B?SWlQU1pXZ1NySFdlSFZ5QnFNR1E5QWRvaG5zZUQ4NC9qay9YRDVKRk91QS9W?=
 =?utf-8?B?SjFXeGJoU3VQK0Y0Mm4zWFdSQUpVVnJKUWZxWFJ5cVdzV0o2c3BqMDI5KzJx?=
 =?utf-8?B?bU8wS3hRUkg5SVF1MDdLR3Z6dldaRkE2T0R1VGFiOE1uME90bEhtd0dsVWVL?=
 =?utf-8?B?SmYwa0RlcGZXVXdBRFZDUEVSajYxSi90SzhRVE05MGgrMHc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:05.9793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411b4455-6fb6-4a2a-36bd-08dcf8412535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

For vcn 4_0_3, add ip_block for each vcn instance during discovery stage.

And only powering on/off one of the vcn instance using the
instance value stored in ip_block, instead of powering on/off all
vcn instances. Modify the existing functions to use the instance value
in ip_block, and remove the original for loop for all vcn instances.

v2: rename "i"/"j" to "inst" for instance value.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 462 +++++++++---------
 2 files changed, 228 insertions(+), 237 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index aaa759765dba..ee10a9218df7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2352,7 +2352,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
 			break;
 		case IP_VERSION(4, 0, 3):
-			amdgpu_device_ip_block_add(adev, &vcn_v4_0_3_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add(adev, &vcn_v4_0_3_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_3_ip_block);
 			break;
 		case IP_VERSION(4, 0, 5):
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8e7d7318cf58..db6f8d424777 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -127,7 +127,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ring *ring;
-	int i, r, vcn_inst;
+	int inst = ip_block->instance, r, vcn_inst;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
 	uint32_t *ptr;
 
@@ -147,38 +147,36 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, inst);
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		ring->use_doorbell = true;
-
-		if (!amdgpu_sriov_vf(adev))
-			ring->doorbell_index =
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				9 * vcn_inst;
-		else
-			ring->doorbell_index =
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				32 * vcn_inst;
-
-		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
-		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT,
-				     &adev->vcn.inst[i].sched_score);
-		if (r)
-			return r;
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	ring->use_doorbell = true;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = true;
+	if (!amdgpu_sriov_vf(adev))
+		ring->doorbell_index =
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+			9 * vcn_inst;
+	else
+		ring->doorbell_index =
+			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+			32 * vcn_inst;
+
+	ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
+	sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+				 AMDGPU_RING_PRIO_DEFAULT,
+				 &adev->vcn.inst[inst].sched_score);
+	if (r)
+		return r;
 
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
-	}
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = true;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
 
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
@@ -1085,174 +1083,170 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
  *
  * Start VCN block
  */
-static int vcn_v4_0_3_start(struct amdgpu_device *adev)
+static int vcn_v4_0_3_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
-	int i, j, k, r, vcn_inst;
+	int j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, inst);
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v4_0_3_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	vcn_inst = GET_INST(VCN, inst);
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
+		  UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
 
-		vcn_inst = GET_INST(VCN, i);
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
-		      UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_3_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			 UVD_VCPU_CNTL__CLK_EN_MASK,
-			 ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
-			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
-			 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
-			     tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
-			     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
-			     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
-			     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_3_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
-			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/*SW clock gating */
+	vcn_v4_0_3_disable_clock_gating(adev, inst);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK,
+		 ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, vcn_inst,
-						      regUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-			}
-			r = 0;
-			if (status & 2)
-				break;
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-			DRM_DEV_ERROR(adev->dev,
-				"VCN decode not responding, trying to reset the VCPU!!!\n");
-			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
-						  regUVD_VCPU_CNTL),
-				 UVD_VCPU_CNTL__BLK_RST_MASK,
-				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
-						  regUVD_VCPU_CNTL),
-				 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
+			 tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+				 UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+				 UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+				 UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
+			 ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+			  (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+			  (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+			  (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
+			 ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+			  (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+			  (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+			  (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
+			 ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+			  (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+			  (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_3_mc_resume(adev, inst);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
+			 adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
+			 adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, vcn_inst,
+						  regUVD_STATUS);
+			if (status & 2)
+				break;
 			mdelay(10);
-			r = -1;
 		}
+		r = 0;
+		if (status & 2)
+			break;
 
-		if (r) {
-			DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
-			return r;
-		}
+		DRM_DEV_ERROR(adev->dev,
+			"VCN decode not responding, trying to reset the VCPU!!!\n");
+		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
+					  regUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
+					  regUVD_VCPU_CNTL),
+			 0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
-			 UVD_MASTINT_EN__VCPU_EN_MASK,
-			 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+		mdelay(10);
+		r = -1;
+	}
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
-			 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	if (r) {
+		DRM_DEV_ERROR(adev->dev, "VCN decode not responding, giving up!!!\n");
+		return r;
+	}
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* program the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
-			     lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
-			     upper_32_bits(ring->gpu_addr));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
-			     ring->ring_size / sizeof(uint32_t));
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
 
-		/* resetting ring, fw should not check RB ring */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* program the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
+			 lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
+			 upper_32_bits(ring->gpu_addr));
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
+			 ring->ring_size / sizeof(uint32_t));
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB_EN_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* resetting ring, fw should not check RB ring */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 
-		ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
-		fw_shared->sq.queue_mode &=
-			cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+
+	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+	fw_shared->sq.queue_mode &=
+		cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
 
-	}
 	return 0;
 }
 
@@ -1295,83 +1289,79 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  *
  * Stop VCN block
  */
-static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_3_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
-	int i, r = 0, vcn_inst;
+	int r = 0, vcn_inst;
 	uint32_t tmp;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		vcn_inst = GET_INST(VCN, i);
+	vcn_inst = GET_INST(VCN, inst);
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_3_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_3_stop_dpg_mode(adev, inst);
+		goto Done;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
-				       UVD_STATUS__IDLE, 0x7);
-		if (r)
-			goto Done;
-
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
-				       tmp);
-		if (r)
-			goto Done;
-
-		/* stall UMC channel */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
-				       tmp);
-		if (r)
-			goto Done;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
+				   UVD_STATUS__IDLE, 0x7);
+	if (r)
+		goto Done;
+
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
+				   tmp);
+	if (r)
+		goto Done;
+
+	/* stall UMC channel */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
+				   tmp);
+	if (r)
+		goto Done;
 
-		/* Unblock VCPU Register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
-			 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* Unblock VCPU Register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
-			 UVD_VCPU_CNTL__BLK_RST_MASK,
-			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
-			 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* reset LMI UMC/LMI/VCPU */
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	/* reset LMI UMC/LMI/VCPU */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
 
-		tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
 
-		/* clear VCN status */
-		WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
+	/* clear VCN status */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
-		/* apply HW clock gating */
-		vcn_v4_0_3_enable_clock_gating(adev, i);
-	}
+	/* apply HW clock gating */
+	vcn_v4_0_3_enable_clock_gating(adev, inst);
 Done:
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, inst);
 
 	return 0;
 }
@@ -1644,9 +1634,9 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_3_stop(adev);
+		ret = vcn_v4_0_3_stop(adev, inst);
 	else
-		ret = vcn_v4_0_3_start(adev);
+		ret = vcn_v4_0_3_start(adev, inst);
 
 	if (!ret)
 		adev->vcn.inst[inst].cur_state = state;
-- 
2.34.1

