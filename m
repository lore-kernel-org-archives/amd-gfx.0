Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D281CCE8E69
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCED10E9D9;
	Fri, 25 Oct 2024 02:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wulkcREn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855CE10E9DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSBvayod6oOXO7x+C7TpXOVNPZtjoozLvnqvqtLTZr/wXKxNNEgZxWRRzpVr6NIF82Og2qVtJDS3blyguL2yRu7VaAAJ/73lq1QWMUVBRP3LzVrlTZ7Y/scYXv4qzQGEnrGjLUyfT9m34QW7tT1b6VrRkqhFUm08ohq6oCkdPv6i9ajPbqOpV43Z8tAgNjLaFNbmNktZwaAwXIcsyotqblevbYsvC99OVsAgxX2uAbFCF122fdwo5sTM2nxncdUhP3vkccPosVd2QHeW6mJlenzsMyjIqoqqSfDg7D1d5I50lP4xiQM688uZuxLxapZGn2toH8S0Wh2nXJW0ViV3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYXVblmB6rnQKRRcyZ3T09CooFuESacnfxyhdKoCVH4=;
 b=myB0ESxYZB5d9dKIReWNG0dt7mQZS72L3XEUSnru0YPDdudYQlOXQpxuwYKW96rUIuVfPqNm6glmENugRsuA6IiZuZfyxus6TAOZ7cwGi05HKFsuahrUB9HuQxQR/XQGkgmZDwM7A3SorY/2PRkb6eZaMBl63z2fXGR5sIiaHVuj47RhipKJrJbfDuoiGCaZiXulEBQmYgciobVkyWGwlWjdnEdD61lGPWg8ozGRHPnQBdq8+mUPnsTyCFUywUTmbGxlIb89zLq8fn2kBy4d6tcB2G8hlVdYn9gX8iKv833LoRotEyiaGV4Nhi4iNn7x4FAFpDHx4vMMrkHkwwhpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYXVblmB6rnQKRRcyZ3T09CooFuESacnfxyhdKoCVH4=;
 b=wulkcREnQmZq+Ea1VRVkFj4d2YefhG1PtXz+OWKDP28sZX8k6qFIsVgmeRvAS+uCqk6JOt+tc0NF8iTLMiIg/gXEhDln4M8qszutSWaPyg91wQLLfYHEIgxM/kn0IUea/u2dxfF0tloxr/5R+mC0vwwQDXZRuquX7N0F0lcNQU4=
Received: from DM6PR18CA0028.namprd18.prod.outlook.com (2603:10b6:5:15b::41)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 02:36:14 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::52) by DM6PR18CA0028.outlook.office365.com
 (2603:10b6:5:15b::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:11 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 15/29] drm/amdgpu: power vcn 4_0_3 by instance
Date: Thu, 24 Oct 2024 22:35:31 -0400
Message-ID: <20241025023545.465886-16-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 828bdbd9-c23b-4566-3552-08dcf49dcbca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|30052699003|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjdCNVlPYktMbU9iMmQvQ1JEYTFoTFFaZjI2N3FseDJwSDc4QUNEYW1GZlcy?=
 =?utf-8?B?OW94MVZDT2dhTFl0QS9BS2N2VDJtSUwwK2l6VTk3aVBZeVAzYktycDVNVXgx?=
 =?utf-8?B?NDYzcno0WXUvRzQzVGlGV0poSFdkdFdsbHJQOUZhU1hVd0NJWUk1cmZpRGdI?=
 =?utf-8?B?QTlxS1pwOWY4ZWNhOVVGZTZ4U0UxeGxIQ3NHR2E3Zks2QnVwMmFENTU5cy9T?=
 =?utf-8?B?VTNaVFNSL1BBM0F1MGdCVzByaWVQbXJhN3pkRmZCN1RzejVvMkZCelJ0bHpD?=
 =?utf-8?B?T1dteHh5NzJhT0g0S0ZFS0QwRitESkxJZVMwVlgyU21BSm9xbnZMeHZKdjFp?=
 =?utf-8?B?R1lMclk4RmMvWEM3QkJkcmtra3ovdldRb1U5NElzQ3BuWERCclgrYzRzWjdu?=
 =?utf-8?B?ejVjOE8zVTdkNGd5bEU5OWloMXNhazZMbWF0VzgwQXRLdWp3SWhBUWxaalow?=
 =?utf-8?B?cVRoWEFNTENubzVDdnB4anhWVzFKeFFrTFNGekgzUEE3cVpDQUsvQnRqTDd6?=
 =?utf-8?B?WUYvY3kxUjBlOGlxQlorZGd2RDREOHMvVjlHQmRSV09MekVTQnNOeFNqZWNh?=
 =?utf-8?B?TENLUnYwUEREbExuOHVhbmVFVW9PbmlFaFJTdnBrYXQ1ajhWRmxGZiswcnhB?=
 =?utf-8?B?aEViUnVqQ0IxSDE3cEpkWXljSHQ2RlF6SXkzaEFWOXd3V3BxZ0NoeTVqZ09p?=
 =?utf-8?B?eDBNelc2L1d3M0p5aDZPd0QveGYzV3Q1b3VxZENRVnpSMDlOaS8zUHREMWpT?=
 =?utf-8?B?RUJnZ3haNHl6VmRRdTZXbS9MUXZreWZVdFdCUEZtY3ZseCtGekZvTXFBVlE3?=
 =?utf-8?B?UzdmeVBzQ2FOd2VvMkJjSUtLa0ZuL3Z3ZWcwV21RRDdRMHYxWGhQYVNZNkor?=
 =?utf-8?B?VUhHMFYvUjgxZWplUklkZUlJZ2E2RVhySUNMWWhRQnNna2hETlh1cnlLeEJF?=
 =?utf-8?B?M3RNZlY3bGtQZHNUT05XWnBxaGxSaXZVOGlkc3dDS1M2bUowczI4R1oxNGw3?=
 =?utf-8?B?UUpmTkt5UVZxdmNLVlVpNEVvZWZjVnhUWHYveXdyQnhRd2tVWTQ1cnJrTTVS?=
 =?utf-8?B?bTBmWDYrYkZySlc0UGg4QWxLTHE1YVU3eVU1U2tNelBESW04aHprOFdTcnE5?=
 =?utf-8?B?aEF3dEZnb2pwdlJLZDc4QUZ2eHdRQXRYTUN6U1pQa045amxmYTlGSmQ5NlRm?=
 =?utf-8?B?ZUlSNmlXeG1WVmYySk1hMFU0aEhiZDdOUFBuR0d6VHNlRzIyQk0rVUhTcFVt?=
 =?utf-8?B?NjNsa200cW95aW82Uk9RRE5nL0JRQ2RiY0xTUnBPNnJ1R084WUxaRk5uL3cv?=
 =?utf-8?B?NytObGdKeWhsVXQwWkFvdGFjQWdObE5RVHcwd21pbkZlV2p3TFdSaEtUNWMw?=
 =?utf-8?B?Y3J3RDN0bkVST1JpZDdvbTFlK0gzcXEyWkExZG9CUmhBc1h6LzhIZ3dHSHk5?=
 =?utf-8?B?ejYweHhnMWdIT25WMFg4anczNG1IZXFJQ2REdTFwQjRLNS9sM2tJcXBITko2?=
 =?utf-8?B?MWRtQ3VGeUNmTVJlUGtUcEpiYTJTUnpFelpuZVR6RXN2RDlkcVcreGlHbEFp?=
 =?utf-8?B?aVgvZXBiK3hMZkxCM2FmMm5jd0FLcFJTNWNPbEVjSUpaeGUwaXl1QTdoQmpw?=
 =?utf-8?B?YWdCYzBMNE9wN05yTWtQSFI3UVcyK21HaldsWGZSSkh5NmEwb1I3c2tHYUYy?=
 =?utf-8?B?YzRrc01aUGltRkdVNERJNktyTFZtSmNXUWR1bDZxSlc3MEJEbi9rcEFWRjFV?=
 =?utf-8?B?SlZqTzBCR2NwS0M0WnJCc1VpM2NmRnJvY041RE11UHAzMzkxOENqS0p2Z0Rp?=
 =?utf-8?B?M051RHRLYkRERzZ2MEFHWVNZaXJQTzZtZjFuR0k1TEV6ZEkyRlNXbXZNNWYy?=
 =?utf-8?B?OEpkd1FvaUhCWkhjbG52cUprTmdkaVF0cUlwWHJkTE1Ib3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(30052699003)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:14.3806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828bdbd9-c23b-4566-3552-08dcf49dcbca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
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

