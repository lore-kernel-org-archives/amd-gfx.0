Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5FBD4414E
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2492D10E595;
	Fri, 12 Dec 2025 08:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="isVks4gP";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A805010E08C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:55 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC4RkHR022275;
 Fri, 12 Dec 2025 06:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Xn1wT+YpKQAHAPi/w
 OxcEVZ1lQf0s/3BsLafNk2n/AE=; b=isVks4gP0tnqaz5kISmw186JkcrYGyz75
 0lN49+snnXlpbY0oQJXpjKrz76q12Ezpu9bYdmUCOvOmLXIw5xGK8k+BB6XwoYM+
 nMlrG76udCA2/i2CJQPmB7cSRAesI6k2W2bqJ4Dz4jof2OT9vQx4xadxVV+xl9Yl
 ZRw3jFw1/YaZrEXi9+Io0QHxhozzpcXA49r0TeV14edVFShhu4XeZoFBgymv5qaM
 RmOnPB+xPNrT3FZJ5U98vFMo9Tyq1cMnI86Y9FUo4vwmLkvgcpWuxXfEs+lmiQAa
 gN88VAazqpp8zIOYdpe+uyUM+r2/kBZiJA/KC8M5pqlxC7r75M/rQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kbw93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6YhL6008034;
 Fri, 12 Dec 2025 06:40:53 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kbw8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC3AUdw002031;
 Fri, 12 Dec 2025 06:40:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jtc70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6emiS31588716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BC9B20043;
 Fri, 12 Dec 2025 06:40:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A629820040;
 Fri, 12 Dec 2025 06:40:46 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:46 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 7/8] amdgpu: Align ctl_stack_size and wg_data_size to
 GPU page size instead of CPU page size
Date: Fri, 12 Dec 2025 12:10:14 +0530
Message-ID: <f7f8f41d58ab2967cd8d077b4937aaa04d58a066.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693bb8f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=OSzmjUBVLbi-8tICshIA:9
X-Proofpoint-ORIG-GUID: 5sH9vs-DdWL-LEHL503euNsPaRZfjAaM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX2+Lomwa/ljX7
 rpN6uRiqpqKgpoJbfM1OCV07So4YsKQatKWNCoAVzOzISUCBiXGx52O6KOBrA2RI+PC4LI7ZAZN
 +rh7ZPVFrZOiCAIXRgGfd46AppKr8kBNGJWfX4tzo7oK29WqLWDiVbxmwqMshxTtwzpnLa3wQbc
 92cRpH/rVFT7x90CvMsGnUeOlr5VOMcHF+4HPpqlrk2iyav9CCfjQSf7PHf/yZq4/aPhkeo/wLc
 0LLoNcxatI/UVrR8eqpztJ3BO4iHJ7yxdtKqPDAc0Jl9hlhR7ZVhL2Yg88xslCaAzTKT1RdWTWg
 o6pjQ1aKgl72l8gTSaMZvq/VrWX4pOSZ03TF3nRApr+hcZMb3EWmdt6sleZf18eyVK3S+K+WERc
 zBttAh8dlfdsy1RsFMRLD8i6+5BteQ==
X-Proofpoint-GUID: AYjDM8ifl025PpmrsJzNxyL9bKM-tzxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
X-Mailman-Approved-At: Fri, 12 Dec 2025 08:29:54 +0000
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

The ctl_stack_size and wg_data_size values are used to compute the total
context save/restore buffer size and the control stack size. These buffers
are programmed into the GPU and are used to store the queue state during
context save and restore.

Currently, both ctl_stack_size and wg_data_size are aligned to the CPU
PAGE_SIZE. On systems with a non-4K CPU page size, this causes unnecessary
memory waste because the GPU internally calculates and uses buffer sizes
aligned to a fixed 4K GPU page size.

Since the control stack and context save/restore buffers are consumed by
the GPU, their sizes should be aligned to the GPU page size (4K), not the
CPU page size. This patch updates the alignment of ctl_stack_size and
wg_data_size to prevent over-allocation on systems with larger CPU page
sizes.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index dc857450fa16..00ab941c3e86 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -445,10 +445,11 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 		    min(cu_num * 40, props->array_count / props->simd_arrays_per_engine * 512)
 		    : cu_num * 32;
 
-	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props), PAGE_SIZE);
+	wg_data_size = ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv, props),
+				AMDGPU_GPU_PAGE_SIZE);
 	ctl_stack_size = wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8;
 	ctl_stack_size = ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER + ctl_stack_size,
-			       PAGE_SIZE);
+			       AMDGPU_GPU_PAGE_SIZE);
 
 	if ((gfxv / 10000 * 10000) == 100000) {
 		/* HW design limits control stack size to 0x7000.
@@ -460,7 +461,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev)
 
 	props->ctl_stack_size = ctl_stack_size;
 	props->debug_memory_size = ALIGN(wave_num * DEBUGGER_BYTES_PER_WAVE, DEBUGGER_BYTES_ALIGN);
-	props->cwsr_size = ctl_stack_size + wg_data_size;
+	props->cwsr_size = ALIGN(ctl_stack_size + wg_data_size, PAGE_SIZE);
 
 	if (gfxv == 80002)	/* GFX_VERSION_TONGA */
 		props->eop_buffer_size = 0x8000;
-- 
2.52.0

