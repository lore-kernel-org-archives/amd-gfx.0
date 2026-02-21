Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880E9C61DC4
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 07:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7A710E14A;
	Sat, 21 Feb 2026 07:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="AMP02sL/";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498C310E14A
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 07:09:50 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61L6s2UT2499908; Sat, 21 Feb 2026 07:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KUvAry7IHrQ5VKYAc
 2YeBDC6Mz4A5HSHay2p0bSB0jc=; b=AMP02sL/D1iPCihclehojrP4B0B5oRlaz
 O4PGjthxNWG4rGCzabLOO6WilVoPm7LoD8pGK4gbLdRwDIZ9ogMs81Dw9L/Xwnaw
 Xu53cG3JXSHj2pp1VsWupnJnA0bwIIGbB58oXa2tYnAG5GsNWMpH125Y1STvekOE
 Rm2Sj2Ho2Svoyvu4qpSA690520kU5uY213+wKwnLO9mgW3g3h0wanA7YINfSoZfm
 0ZGYofaz8jiJG17OokNI2P3xp+ztCW4Tj6LyUbu9bOBOmvsYs1SVeAV2u0NlPxSZ
 pJny0N/USgTiQr7M01ODJwUl22+d6cO4YlfHTqCm3rLk4zLCZNnyw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24g0qkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L1QW8A015715;
 Sat, 21 Feb 2026 07:09:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45kb0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61L79g9052887918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Feb 2026 07:09:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B845820043;
 Sat, 21 Feb 2026 07:09:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6130D20040;
 Sat, 21 Feb 2026 07:09:40 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Feb 2026 07:09:40 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v3 3/6] drm/amdgpu: Handle GPU page faults correctly on
 non-4K page systems
Date: Sat, 21 Feb 2026 12:39:21 +0530
Message-ID: <3ece0c1c961e4f3e333ccf122eb5285351966ba0.1771656655.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771656655.git.donettom@linux.ibm.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69995a3b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=gKbHINidcilSpodcztQA:9
X-Proofpoint-GUID: oLZpz35Lqwr4cFINyTY6GUmVPpRKpS75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MyBTYWx0ZWRfXy5i+ic5l2wqL
 OlUPR0n0518P63WChv+t/xeWrkqugqd19f062TzmKA95miu2wXAbx8yIOQK0EvIbVW4iwI9K4X5
 D7loaDUcxyt3jmIiR05PUDVK5k1NFjxP9akjSMPKrSPNryQrUBddxwadaoVT7Hp3orH6EroblBu
 f98BEutE601wTpGs4Sw6kt0EI8vd4RwEHUlKZSXB2Y4tb5t5K2spoGpZG9ml5Bx7GLMl+Lddup8
 oijaZKTo5fODdkstl9e7sEgkTA/8K7LhwBKgD/WYa5o1j8f7VON8fd10Vn36CRriDYYPMEgyS8l
 z64kuypSvtnYirDzPHfbC0LvJO1emkPTQEszT3IaqRhsx//fnxfIy/GDdzyUw16tIKIpKBA7nmN
 v9epJdCDeYSHjUftdH77AsA5nEx2vjqs4c0lTh/fflqTqUxDdOsVLba/CtR8U+8O19xKva7s9FF
 znHBFELbDVbWwzLn9uQ==
X-Proofpoint-ORIG-GUID: BHxGYDC_Xq1rZCCPGhttjX1GjuuzJOyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0
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

