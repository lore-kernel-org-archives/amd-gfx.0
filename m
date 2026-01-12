Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674E8C9EC90
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64E010E3DA;
	Mon, 12 Jan 2026 14:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="kYoloAIh";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB8F10E3DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 14:07:48 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C3a2lo009533;
 Mon, 12 Jan 2026 14:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RXr4yXuDWeq77LKR1
 oi440ztCfC+6sPoPTU25dlQV7c=; b=kYoloAIhhoAeHHutw3ehBF6dTMmadp7Nj
 JrBaKQg8E1ZVECLxen8R9HYGM7JkPr5+ez8W1wU1vZd3FTaQE/pSI0+MQrQxadcO
 iaYJNqi4GfxS/jGGKkxpg8mrS+3nKwheNmG1rpvq5P1p9i01USFXsnYNUDGOi0CA
 +IMy7MfeeUhaqZd+GiVMz/tOCR73dMtL7ICQrLRfDoOoRRfLlp8u/TjvU9DT57NH
 7jqFPY1uTcZh1DMMPv54mVVmYc4MKu9wZ+d+bji3fsnGYBXNWr+OIt+hcjj6YAS8
 /fN/TZOLrxzzmOMrVC2odghAc8mzmUjRoqz+MH7/90z/ZUJ9Iq1gg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg47b7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CDuKsM016289;
 Mon, 12 Jan 2026 14:07:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg47b7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CD39O6014278;
 Mon, 12 Jan 2026 14:07:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fxxdfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CE7eK556492316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 14:07:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E13E20043;
 Mon, 12 Jan 2026 14:07:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADE6D20040;
 Mon, 12 Jan 2026 14:07:37 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 14:07:37 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
 donettom@linux.ibm.com, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v2 3/3] drm/amdkfd: Fix GART PTE for non-4K pagesize in
 svm_migrate_gart_map()
Date: Mon, 12 Jan 2026 19:36:56 +0530
Message-ID: <25f33ef289e8d5f5290082010ccb22a22b6323e8.1768223974.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768223974.git.donettom@linux.ibm.com>
References: <cover.1768223974.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDExMSBTYWx0ZWRfX1EajK2zVODQD
 ogkS7prFtstcN1nQxS2dhrG6wSEbmM6xQiVQYkyhPwFBxzfd8qCrSA6RhbzPW3LsVFiK1JQ13Gu
 jmOvufTKy3VAEb+ydErwWk/kOfeLt7xlDfrSzOUxmVjGmC8Yrxjm3ghrvBmr7rSxsElGe1a9pp5
 vxIE2rBc/YO0rDtfz44x6zjyMj7H8WPJdWyv9t+kEDCKlyCACLRVoJivbd9DR99STC5FGVjUnrH
 BfztIsTAA0/DLLvfqkZ3fLzAqTl9RZFIIuOyxVsmQqCMVfDs+VMzfEAb3GX4HohSpbEhYqNFy+2
 nKJuyfHqSzI3fL/76APm+OPC2B7VBfU2YjxX+qNSu2W/XoyTpqyLafIFWa9/sRGsh1vmm2rh+C5
 /JvyJopPEwIvDATEH8IjJJ5Lm+GWnVKGIzyz8cbbNBG8jig5Yof2xfzh86OxnokGAtNTLVpTe7S
 1v1DdFpLt4jNPEZFUpA==
X-Proofpoint-ORIG-GUID: ySbXYsfkCKaU-_CNVO_UlC3QXzQ4hMtf
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=69650032 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=8H52i5D8jjzlX-VSk4YA:9
X-Proofpoint-GUID: bLHB7WKS93jw_rtH_94dtmbm0doTRcDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120111
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

In svm_migrate_gart_map(), while migrating GART mapping, the number of
bytes copied for the GART table only accounts for CPU pages. On non-4K
systems, each CPU page can contain multiple GPU pages, and the GART
requires one 8-byte PTE per GPU page. As a result, an incorrect size was
passed to the DMA, causing only a partial update of the GART table.

Fix this function to work correctly on non-4K page-size systems by
accounting for the number of GPU pages per CPU page when calculating the
number of bytes to be copied.

Reviewed-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index af53e796ea1b..fd7721e3333a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -61,7 +61,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, u64 npages,
 	*gart_addr = adev->gmc.gart_start;
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
-	num_bytes = npages * 8;
+	num_bytes = npages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
-- 
2.52.0

