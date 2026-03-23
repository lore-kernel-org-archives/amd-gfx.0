Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A154D58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEB910E2EF;
	Mon, 23 Mar 2026 04:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="s1ZqyXO3";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4996410E2EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:29:03 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MIeNll092005; Mon, 23 Mar 2026 04:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KUvAry7IHrQ5VKYAc
 2YeBDC6Mz4A5HSHay2p0bSB0jc=; b=s1ZqyXO3OXRPyr/qHBqcPlws9i99fi9ce
 vp0+Mkjyh++J2/MZZuTl+y2Wa8G53/aGbtQnEqQUrKa1kbgFWBfzWA8sEIEwkOEy
 AsoAPRy7dVMk1R1yvCUhRP7FygU+iZQuRR5XQQ4pm/F5JMBFBTz1JQICPgmsymjr
 HwQTeAuwznF5QRHvUKTuyhWze1I819a7SBTlG7QK73q/mKIZoA1PSfOMk75PQHJj
 rQemFQiaTzQHI4ExqP7TD4l0XYNumg0jVl1wr9MG9cgVk3IArj4ky/1tbTy++XB2
 mgtQI+fe5jwRD6r5hKqSAMgLTQqL6KO/7yeD0z+NidFl4I7SwmQIA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9nca9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:29:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N1YD5R026864;
 Mon, 23 Mar 2026 04:28:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kkw87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:28:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62N4Ste952166978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 04:28:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DD3E2004D;
 Mon, 23 Mar 2026 04:28:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 811B920049;
 Mon, 23 Mar 2026 04:28:52 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.bl1-in.ibm.com (unknown
 [9.123.6.34]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 04:28:52 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RESEND RFC PATCH v3 3/6] drm/amdgpu: Handle GPU page faults
 correctly on non-4K page systems
Date: Mon, 23 Mar 2026 09:58:36 +0530
Message-ID: <1e6240945c2fcb53b6703ae62d4b36f5958ca8a6.1774239489.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774239489.git.donettom@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: L0WYAQIBd2i93eoeqv0fP5TDqHL6_1Qm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAzMCBTYWx0ZWRfX1+IZqIpDcjhL
 0r7yyd8r+iPGxSmWm9WdznU0gAhjBDKPn4PTXGlEzY3ywsxAZVBw4P3qXJWlTEwKMkL0wmxFjDb
 44e/b25T+5u/7IRuHX/Im3HXQfhszCS7rAlU+pj0XK/iieSsZv+5TIyzWD/+QdF8KvbyXA9VopR
 Kbp/hnqnAr6fOdGxvicX+r5q3GOaLwV46tCKvflMT6uzGuG0BQrSfkgy0D2darPihQsJuLhjgtl
 gSTKzFNayNvKMQWH2ybuyVsEvi6lk+wXiE+8lcVlo3GiMwU+AK/VB988f3R3P5oSL3gGzsFsQAN
 C9iTztkTM4d0XBT5MFn4xOdDime3ae2pTm4HneyQ04z8zK0x5+5wy11uVP7g9m/iWRxNnZOcict
 YQDlqzBZrl/kDFP2H2njkSGSLQY3dnBoo3L1RqCOE0/LRrWMblpQWUr4bmgBKTX6/MxTIJ9TmeN
 Gqe8UnL5lws2DuQNauQ==
X-Proofpoint-GUID: jLNmss5-Iq4VeZzJNycGhzFH8mvUhFeh
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c0c18d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=gKbHINidcilSpodcztQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
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

During a GPU page fault, the driver restores the SVM range and then maps it
into the GPU page tables. The current implementation passes a GPU-page-size
(4K-based) PFN to svm_range_restore_pages() to restore the range.

SVM ranges are tracked using system-page-size PFNs. On systems where the
system page size is larger than 4K, using GPU-page-size PFNs to restore the
range causes two problems:

Range lookup fails:
Because the restore function receives PFNs in GPU (4K) units, the SVM
range lookup does not find the existing range. This will result in a
duplicate SVM range being created.

VMA lookup failure:
The restore function also tries to locate the VMA for the faulting address.
It converts the GPU-page-size PFN into an address using the system page
size, which results in an incorrect address on non-4K page-size systems.
As a result, the VMA lookup fails with the message: "address 0xxxx VMA is
removed".

This patch passes the system-page-size PFN to svm_range_restore_pages() so
that the SVM range is restored correctly on non-4K page systems.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c..7a3cb0057ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2985,14 +2985,14 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	if (!root)
 		return false;
 
-	addr /= AMDGPU_GPU_PAGE_SIZE;
-
 	if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, ts, write_fault)) {
+	    node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
 		amdgpu_bo_unref(&root);
 		return true;
 	}
 
+	addr /= AMDGPU_GPU_PAGE_SIZE;
+
 	r = amdgpu_bo_reserve(root, true);
 	if (r)
 		goto error_unref;
-- 
2.52.0

