Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EFBD3A678
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB2D10E6BA;
	Tue, 29 Oct 2024 17:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rUDgki+p";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123B310E6B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgTnEIAQImgxBQhiKsp8JklTrQ1R1P8kpxxHF71qZYSBLs3WF7F3NFb0jwWFwoX1WDAzqi0S5AteZz4iYsXcRncsK9v2E2j/ijSDH4m5serqb/rPjNIbQsAMgVLaid771ti/h9ht5SaIhU78DlJg9DSZWLb6Jcn+4Oc8ybicocwVdTfRjRD6qb8+Ux9895Vc+aeygn4upfc0OVcM+zmeqdphoauvuh2lZueje/4YqdCN0Dd4LwfTvrQdhRcxnTF/RjACS9rr0YIFfc2IwXQYkBZX0dNKsK4uWH2RbiRuY6JFfl6WSGoIDbocmMZSt4868RLloIVwZxs8RxXpXR+NOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbYmmHzX1cDDyUVlcBHC6G6Rp2hID3RDktt+azmQlNA=;
 b=l4liwRJ6JOLb1z/1fjq8xFbAuWGAJm4+g1zAkwCpmO/69tDCdDUDfyQr2vHStSnxU0wtRUnERL8v0mAc3mDkx2r9iCbqfOAJuRSPXr/hmNEv0AQuWanodVWudEBiCaiUzxXsYflUyPq4umsMp9MLO3AIe91h/Nipk4yNPCXSpaYULbCdMGHj0Q1gFwsZk7bRKYP6StO5geyKLwlMDGuqzsTO2+i7e3BfN1z6RIwAkyvcV8ivLBHwTl+KOZlOzDaFb3SftOTVD5m2dZAlBCxsE019ov7YjxWV+n/CcMUnMBf67NeAEENv62wCzYrXDlc8iQvXUHnDwESVBkGs7y1lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbYmmHzX1cDDyUVlcBHC6G6Rp2hID3RDktt+azmQlNA=;
 b=rUDgki+pmImECUvknXDjLjcLPtK1UEHybUNZ7JoSnNJrTgGCk9gQOIxoqHJbFeUZTe7xidEMiY4SgO7T5HJKTRBptRvoVyCy8EIgxOnJUEZ1evLwvEXUydLBCHZtiT0WzcD80nJ9GCZ29ajhhRMwfDmRg4ExN09REJ1tKugVPF8=
Received: from SN6PR16CA0060.namprd16.prod.outlook.com (2603:10b6:805:ca::37)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 17:43:05 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::d6) by SN6PR16CA0060.outlook.office365.com
 (2603:10b6:805:ca::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:05 +0000
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
Subject: [PATCH 14/29] drm/amdgpu: power vcn 4_0 by instance
Date: Tue, 29 Oct 2024 13:42:25 -0400
Message-ID: <20241029174240.682928-15-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 15fa25e7-b44d-44c6-1391-08dcf84124d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|30052699003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHl0M1VZQW03THh4aW1paitxM0xhZHN6aXJVYU0yVTdQRmE0ajlzb1BLM0dH?=
 =?utf-8?B?UHRQSnlORjBMQWQrMmd2N1FWTC9qOE96QWtWWWxUWVdXQXpHbVByVTQ1TWs0?=
 =?utf-8?B?Z21lV2h6K1RnT1F4OEhaNWVrVmpjK01CWDdFWUsyWkZnSkJJYU0vQ05PbW5C?=
 =?utf-8?B?R09PL1Nod01BOUV6QVRnaU5CWXljTlIxdmdZelVEdHIwV0JraUx2Ym5NQWta?=
 =?utf-8?B?SG5KR3ZqcFlvRzR5YWJJWSt1SDJtNjFESHBIRUwybkFoc2RET2trWGtIVHFL?=
 =?utf-8?B?cmsrVnhwWVVFbG8yNWZRNEpVSjBsQlFpNGFCanZwVGhUWXdsQXdLdXQ3NERa?=
 =?utf-8?B?VUhKTlR2YmtYUDlBMEZlMkVvOXpmTkJPZnBuSXZXQ1B6OE5NYnZscG14V3VW?=
 =?utf-8?B?SGFubVdYR2dtYnVtRXpOSlhvVzZ1OXo4MzRiRmN4QWYvTG5nc0lHTnJTUWZo?=
 =?utf-8?B?MmNDazZUbmdnU0s5MzFFTjFLM3MySjhGcHk3SUJUNW1KUTBDWnNVRyt6UDdB?=
 =?utf-8?B?aDNMYXVyNkxNZWxscHBHL2lGZm9iUXFFaExxYlppMlBJY1JOdTZ6NmNWbEUz?=
 =?utf-8?B?SXBUVmNqM09TSEdUb0t5NWs5VW9GMFYyM29YMzRZSGx3ZVloMkhHTXpEejMw?=
 =?utf-8?B?UVB4bEJKOGNKdnFqazljN0hNMFhPcE80d0dHNkptdG9TSk84d1d6U241OVg3?=
 =?utf-8?B?OTJHSTVaSFdkT25tM0NENmlweGxWeXpjTmR4V2pWU2lKMTJLNmMzUmZMQTJT?=
 =?utf-8?B?ay9Sb2grTGRCQ2pJK0pkcHFSbHNpNGhBWW1YV1lFejRBUEtPYlJ1ZW9rOVVI?=
 =?utf-8?B?Skx1THZUWXF6bFlDVEcvbmRZaFlEUVpwb2RPbWgrbk42Q0VINEM5d3ByMGhJ?=
 =?utf-8?B?RUdrK3JXWlRvOWNZOUkwcDVlWUJVSDFXbEplaTFRbHluRG5VRU5rVmdkakc2?=
 =?utf-8?B?Z0NJTVB3aVFXaU1hdXFQamVPaWhqY0hTajNiUTBYS3A5SlA2VnprOEFBQmJa?=
 =?utf-8?B?a3NFYUhjK2ZEZW5sZ1hoNzNxYVdjdmp4OUhTUExIU0JJeDl4RGpQSEFjb1Zu?=
 =?utf-8?B?Z1RpbUpVeS9HVXpUMEQ2cWRqZjRtdFB6cVRTQkZ3aFdOQTJYS2sza3QyNEZR?=
 =?utf-8?B?eWl0Sk9zdWw2cE5rdmd0dzBMbnJ1SmV1NUlPN0pneFQrUnZCOVRoTVpNaWZR?=
 =?utf-8?B?d2ZZT1JmOE44MkRva21idTlVeVZUT3hDRVA0ZGQzS2VkMjVmMUxGTGZPR00x?=
 =?utf-8?B?OVdLQVpJaWRsdDUxak9uaEZHdU9mZ0lSVU5MMU5BbGRrZzRVM0Zwb3Rja3Bz?=
 =?utf-8?B?OUxub1FUNzlyODVPUkpBWC81Vzk0MXFkK2FMSEI1MkhhT3BsdU1IWmg2S25q?=
 =?utf-8?B?QjgwMXlhcTRJdUlKRGdrUFdrWE1ZUGxQUmtHTTdTeXRHeU1mOVM5cHZEYUg4?=
 =?utf-8?B?V0NPdEM0UWhOUUY0NUNsREk1a216LytFS1VOa0FKMnk5dndmMk00RzNuWXdm?=
 =?utf-8?B?c2FOSGRNdDVtNXJLd3g5dHl0dTQ4cTY4ME9qZHNuZGFyTEYwbWlLZCs0cTNh?=
 =?utf-8?B?V2Y4Q3ZBNU1HTnV4cTZVaEdDZnN1L2ZDdnR0T3ZTSnJ4OE1NM3UwTFFXZE9N?=
 =?utf-8?B?L251dy9sbWN4QVFRZGpBV2dzOFQwUFMvNC9zQXJkL1oxSHhpWThkbTF3TXVT?=
 =?utf-8?B?WlZKeXlWdGF5Q1dMeWREVXlYdlE5N3pHUUVqKzlWZ0Z1RmE1Y2YvdC9mV3NI?=
 =?utf-8?B?WnhTMkFoOGFlWUR6WWpDSUhuVkdGOVJIQ3l4Q0xubklQeEgrczlEQU12TmhW?=
 =?utf-8?B?c3ZvVUpCQnZ5YUZvdS8rMjgzSmMrOHBhL3BHSXBSK2I2L1FZNmZUSGJsVUJ3?=
 =?utf-8?B?eTREQ09SUlJML3psQXBtZzl5U242a0gzMDhoeXBlbUJZUnc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:05.3074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fa25e7-b44d-44c6-1391-08dcf84124d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
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

For vcn 4_0, add ip_block for each vcn instance during discovery stage.

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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 495 +++++++++---------
 2 files changed, 245 insertions(+), 253 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2a606e8c6930..aaa759765dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2347,7 +2347,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 0):
 		case IP_VERSION(4, 0, 2):
 		case IP_VERSION(4, 0, 4):
-			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
 			break;
 		case IP_VERSION(4, 0, 3):
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 87c8f1c084a5..0cc0eb52b54f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -172,7 +172,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_device *adev = ip_block->adev;
-	int i, r;
+	int inst = ip_block->instance, r;
+
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0);
 	uint32_t *ptr;
 
@@ -186,45 +187,43 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
-		if (i == 0)
-			atomic_set(&adev->vcn.inst[i].sched_score, 1);
-		else
-			atomic_set(&adev->vcn.inst[i].sched_score, 0);
+	/* Init instance 0 sched_score to 1, so it's scheduled after other instances */
+	if (inst == 0)
+		atomic_set(&adev->vcn.inst[inst].sched_score, 1);
+	else
+		atomic_set(&adev->vcn.inst[inst].sched_score, 0);
 
-		/* VCN UNIFIED TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
-		if (r)
-			return r;
+	/* VCN UNIFIED TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
 
-		/* VCN POISON TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].ras_poison_irq);
-		if (r)
-			return r;
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].ras_poison_irq);
+	if (r)
+		return r;
 
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		ring->use_doorbell = true;
-		if (amdgpu_sriov_vf(adev))
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
-		else
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * i;
-		ring->vm_hub = AMDGPU_MMHUB0(0);
-		sprintf(ring->name, "vcn_unified_%d", i);
-
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-						AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
-		if (r)
-			return r;
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	ring->use_doorbell = true;
+	if (amdgpu_sriov_vf(adev))
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + inst * (adev->vcn.num_enc_rings + 1) + 1;
+	else
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + 8 * inst;
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	sprintf(ring->name, "vcn_unified_%d", inst);
 
-		vcn_v4_0_fw_shared_init(adev, i);
-	}
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
+					AMDGPU_RING_PRIO_0, &adev->vcn.inst[inst].sched_score);
+	if (r)
+		return r;
 
+	vcn_v4_0_fw_shared_init(adev, inst);
+done:
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1081,180 +1080,176 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
  *
  * Start VCN block
  */
-static int vcn_v4_0_start(struct amdgpu_device *adev)
+static int vcn_v4_0_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, inst);
+
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v4_0_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	/* disable VCN power gating */
+	vcn_v4_0_disable_static_power_gating(adev, inst);
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
+	/*SW clock gating */
+	vcn_v4_0_disable_clock_gating(adev, inst);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
+			~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
+			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
+			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup regUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, inst, regUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXA0,
+			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+			 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+			 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXB0,
+			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+			 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+			 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUX,
+			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+			 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+			 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v4_0_mc_resume(adev, inst);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
+			adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, inst, regUVD_STATUS);
+			if (status & 2)
+				break;
+			mdelay(10);
+			if (amdgpu_emu_mode == 1)
+				msleep(1);
 		}
 
-		/* disable VCN power gating */
-		vcn_v4_0_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v4_0_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
-				~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
-				UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-				UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-				UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-				UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup regUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
-				((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-				 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-				 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
-				((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-				 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-				 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
-				((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-				 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-				 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v4_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
-				adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-				if (amdgpu_emu_mode == 1)
-					msleep(1);
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status & 2) {
+				r = 0;
+				break;
 			}
+		} else {
+			r = 0;
+			if (status & 2)
+				break;
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status & 2) {
-					r = 0;
-					break;
-				}
-			} else {
-				r = 0;
-				if (status & 2)
-					break;
-
-				dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+			dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", inst);
+			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+						UVD_VCPU_CNTL__BLK_RST_MASK,
 						~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+					~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-				mdelay(10);
-				r = -1;
-			}
-		}
-
-		if (r) {
-			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
-			return r;
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
-				~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
-
-		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
-				ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-				VCN_RB1_DB_CTRL__EN_MASK);
-
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
-		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+	if (r) {
+		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", inst);
+		return r;
 	}
 
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
+			UVD_MASTINT_EN__VCPU_EN_MASK,
+			~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
+			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+
+	ring = &adev->vcn.inst[inst].ring_enc[0];
+	WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
+			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+			VCN_RB1_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, regUVD_RB_SIZE, ring->ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, inst, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
 	return 0;
 }
 
@@ -1543,83 +1538,79 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  *
  * Stop VCN block
  */
-static int vcn_v4_0_stop(struct amdgpu_device *adev)
+static int vcn_v4_0_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	int r = 0;
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v4_0_stop_dpg_mode(adev, i);
-			continue;
-		}
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v4_0_stop_dpg_mode(adev, inst);
+		goto done;
+	}
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
-				UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-				~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
+			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-				~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
+			~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
 
-		/* apply HW clock gating */
-		vcn_v4_0_enable_clock_gating(adev, i);
+	/* clear status */
+	WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
 
-		/* enable VCN power gating */
-		vcn_v4_0_enable_static_power_gating(adev, i);
-	}
+	/* apply HW clock gating */
+	vcn_v4_0_enable_clock_gating(adev, inst);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	/* enable VCN power gating */
+	vcn_v4_0_enable_static_power_gating(adev, inst);
+done:
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, inst);
 
 	return 0;
 }
@@ -2058,9 +2049,9 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_stop(adev);
+		ret = vcn_v4_0_stop(adev, inst);
 	else
-		ret = vcn_v4_0_start(adev);
+		ret = vcn_v4_0_start(adev, inst);
 
 	if (!ret)
 		adev->vcn.inst[inst].cur_state = state;
-- 
2.34.1

