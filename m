Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EC0D58CBE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA87C10E3B8;
	Mon, 23 Mar 2026 04:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="NS8pTeGh";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EA710E3B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:29:11 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MNIj1Z540492; Mon, 23 Mar 2026 04:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nHuW8BA17L57unX6w
 jDsnsG0Yun2KSjyEBlyfR6DU1c=; b=NS8pTeGhBSKhu0EYOvQccWkGpsrIoC/Hd
 q75ewDPQeC9jH8ZbSdl6VM+EY/qjwVgbW7zLHJok0AaO37vA+Mz7tQAAKjpBulA1
 LS1h3pg+Hl0yKLP8bAok/TC/h4iJ+FmIjtr1GVvqqmyDoY+1QoG+9pA3yIywGRQr
 DP4nBnCdqT1JsHFftwxDlJErIUzXIwLsRHEM3dxAxHgZXeJv3bIYP6A7jQuHziV4
 OZ+HFdH61J+hwFWHqn5vdyKWzqX+zVwiciAp+2SSK0iFduTQy5x4s+PQC+Oyptph
 wW67ENEYPngVyAmiN8LjyZr71hH5uVKIBYzVtnIK0jSJJKx3XZUdA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxyw32a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:29:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N1FZgO005972;
 Mon, 23 Mar 2026 04:29:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yc2v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:29:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62N4T4Ze46465426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 04:29:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CC852004D;
 Mon, 23 Mar 2026 04:29:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9748320049;
 Mon, 23 Mar 2026 04:29:01 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.bl1-in.ibm.com (unknown
 [9.123.6.34]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 04:29:01 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RESEND RFC PATCH v3 6/6] drm/amdkfd: Fix queue preemption/eviction
 failures by aligning control stack size to GPU page size
Date: Mon, 23 Mar 2026 09:58:39 +0530
Message-ID: <9b5d3040f6ce7d99be2c656f68055c8c7529b34a.1774239489.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774239489.git.donettom@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAzMCBTYWx0ZWRfX/e1+TQPSO6G6
 wDhSURU43BibTy3p+3SgRfu0ApQten+R6vBMx4FXYhrCIydvn4Mt/Uh2ZY+A84NaSeoX7IyTlln
 kvEq9hgOViHgknaT/ENhaVVLmK5bbDteYElVqXlATrcvTBary9XCEltCsfEr6PolWWp2J6vhByM
 RCb0OiZAr4I9bSmDelkkP2rPzsPXFZaHpLJOrOILp0DWdE7SmrJEOj0HBtFsLJJBsXHXTEHiMta
 Kp9+OOrj8dojTH3awKGhPibgBxuwOQHrdxj2ZP0VdCNnaOGgcNst0RJySXFqzcmAUMkowQFeMCI
 Kw/4++OoVdZCiooCuqalrtDIpuIsyB6qsi696tHhi8rVzEwgXT9KcfWkyAOG9auRlSs7uk7P//Z
 5uO+irclOm1n9rmNzlLjQ5w+/ldxLg0m33nJJV18qZHpU8n0Rt4U6XeIEoERJBt72+e0FexH1BC
 eHZeBXIGkdPAXmrMrOg==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c0c195 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=5xC4zRIfMAlGsE5dwogA:9
X-Proofpoint-ORIG-GUID: v34hF6afjO6lCtsFi1wFra948ELF7zF7
X-Proofpoint-GUID: ldpJhEKMDhAg7vYAcaLG4DLet57grFxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230030
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

The control stack size is calculated based on the number of CUs and
waves, and is then aligned to PAGE_SIZE. When the resulting control
stack size is aligned to 64 KB, GPU hangs and queue preemption
failures are observed while running RCCL unit tests on systems with
more than two GPUs.

amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for queue with
doorbell_id: 80030008
amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4
amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for queue with
doorbell_id: 80030008
amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues

This issue is observed on both 4 KB and 64 KB system page-size
configurations.

This patch fixes the issue by aligning the control stack size to
AMDGPU_GPU_PAGE_SIZE instead of PAGE_SIZE, so the control stack size
will not be 64 KB on systems with a 64 KB page size and queue
preemption works correctly.

Additionally, In the current code, wg_data_size is aligned to PAGE_SIZE,
which can waste memory if the system page size is large. In this patch,
wg_data_size is aligned to AMDGPU_GPU_PAGE_SIZE. The cwsr_size, calculated
from wg_data_size and the control stack size, is aligned to PAGE_SIZE.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 572b21e39e83..9d4838461168 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -492,10 +492,11 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 	cu_num = props->simd_count / props->simd_per_cu / NUM_XCC(dev->gpu->xcc_mask);
 	wave_num = get_num_waves(props, gfxv, cu_num);
 
-	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
+	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props),
+				AMDGPU_GPU_PAGE_SIZE);
 	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
 	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
-			       PAGE_SIZE);
+			       AMDGPU_GPU_PAGE_SIZE);
 
 	if ((gfxv / 10000 * 10000) == 100000) {
 		/* HW design limits control stack size to 0x7000.
@@ -507,7 +508,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 
 	props->ctl_stack_size = ctl_stack_size;
 	props->debug_memory_size = ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
-	props->cwsr_size = ctl_stack_size + wg_data_size;
+	props->cwsr_size = ALIGN(ctl_stack_size + wg_data_size, PAGE_SIZE);
 
 	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
 		props->eop_buffer_size = 0x8000;
-- 
2.52.0

