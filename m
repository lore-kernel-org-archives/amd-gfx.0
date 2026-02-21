Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98747C61DC4
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 07:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D62F10E164;
	Sat, 21 Feb 2026 07:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="g7Z7HgND";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C9F10E164
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 07:09:59 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61L4tZiM2261658; Sat, 21 Feb 2026 07:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nHuW8BA17L57unX6w
 jDsnsG0Yun2KSjyEBlyfR6DU1c=; b=g7Z7HgND7c9Mxk8kOqZ5RjmdLKj8nfvxa
 wJlY45d2ZBVSKj02yybynEONdJdJyYUvm1lDoX3GvHwTBkk9enJerRAHSPW9yjLA
 6XgU9Pq2FVDvkmZKwldx3ZMjPqZA7ewgLtP856sKmhnX66AAjVPqhWcK0UsSyooK
 AW8qSKiCsUhheK/BQ3Hxajdzj4eJWdcjs8jNRxCyVqF5AZ97X0xXXfI5AA9FxlPO
 qGv3i4dslFKFJlifgQVeCzORljmyWRmpE33HrwmmrvFwiHl35QbZVM8QYI59KeZP
 0etn80w93UyddUFmeaCmIV/mYrd4FxQh5GS+aUiFdP4aPAKr2SHvg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4e30f9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L0aJog015679;
 Sat, 21 Feb 2026 07:09:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45kb11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61L79qnO31261052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Feb 2026 07:09:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 346B220043;
 Sat, 21 Feb 2026 07:09:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 071E120040;
 Sat, 21 Feb 2026 07:09:50 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Feb 2026 07:09:49 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v3 6/6] drm/amdkfd: Fix queue preemption/eviction failures
 by aligning control stack size to GPU page size
Date: Sat, 21 Feb 2026 12:39:24 +0530
Message-ID: <cec6ef1a985431ca3c44ee0dc63729c593919687.1771656655.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771656655.git.donettom@linux.ibm.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XMs9iAhE c=1 sm=1 tr=0 ts=69995a45 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=5xC4zRIfMAlGsE5dwogA:9
X-Proofpoint-GUID: 9ok-0fshKqzN6rS_K6e0Y8_-LQOweCVV
X-Proofpoint-ORIG-GUID: -x2LU1F_9bJD6xsB2uXDI6MgeaiTS5lA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MyBTYWx0ZWRfX4uMotyDkjA9v
 bEiWM9MgbESGQ5E9gJjU+k53LIn+YqmRKFhrmEwoHcnZHqgvgCIy6spIcC60GUgAUrG0N9UDaAg
 p4eZVDOIPJcn2TENt9Kh5exnsyQGSO/CJKcO46drnXd94NPBptY1KScxdp/WGiHSXmNSQbaSwlt
 8PY6ARNYfeXmLosRZABCYQIlrzlxHubJ0WuyTjQ9DRkOuINBS3WuENPtAzHqfys08p4fh3ZGIfU
 uoQNEC9R1MH065kN21+0yNR+V5xa9Xkq/C1X5qKmV5cAFjNCvbuh9voilojm4DHEng5sZfL3neM
 gpYUUHsep5hS9PTbEI9UDapuPSLUi1nOmtH0IbgR2Oa6UailqP3wABunAEAXaFMRc/SUP1uhhYT
 gLYtVjZ2eFa2gUNOURb6eiX+wlprcbgty8sY3sHIFZw4xefcBpGB5uczGmwd025b0l4XCTnrTn0
 vG177BwNhom6tYV/0aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602210073
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

