Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D79D44144
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F8710E592;
	Fri, 12 Dec 2025 08:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="svIwRERQ";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 640ED10E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:45 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC20Fsd023207;
 Fri, 12 Dec 2025 06:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jNJMzAhjq9TzMsFve
 tpoYzEhnfI9cY7U8D8bxHweKng=; b=svIwRERQeou6/LDyzfVkAJpSaW/Bp+H3Y
 SBk0XhEMXOZQNjMCFdYJ1h0Y7DF3L9NKzwaa0imdsvZs1HHbjBWh9yIYRfugyjRe
 JGg9R/trpr0vqE3paQQzsbH3m0VjH1nooxA6T+45p84s+UeFqG7xod1IeQgb1pfZ
 18E8vV0xxVEm0o+NDJRHHvlA7gYqzNc2YVDktQmV2Jm4sUk6GCPG3Vlu6NOvLsBn
 2+XojndKnJZ1Jzx+yl6GHB2v+UwxiDs29bC2TXz99dm836ra9basIB2dSgBEtGWl
 Q2UqukFCZ2eCqW4KI0KcukYgPLaygnrv3nmvNJS68LVRhayca3XWA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6eBwj029914;
 Fri, 12 Dec 2025 06:40:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7cbvw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC2HWaP008412;
 Fri, 12 Dec 2025 06:40:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytnahud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6ebwh13435158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5407620040;
 Fri, 12 Dec 2025 06:40:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E06B20043;
 Fri, 12 Dec 2025 06:40:35 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:35 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 3/8] amdkfd/kfd_migrate: Fix GART PTE for non-4K
 pagesize in svm_migrate_gart_map()
Date: Fri, 12 Dec 2025 12:10:10 +0530
Message-ID: <12e16278a663e957019ce83b86b11f55d451d90b.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z2krR9tfdnhnb2o5L2LPG_GL4kEbl_Lo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX4+d6FL1op+5k
 lMpA9wfwMMZCp9KvgSEODM7u5iTTKP7/NHZ2wxRUzzHZlyQ5psSfVHA38nS6aXfTePHLr2nCWQ7
 6rCZVoEEbJ94Z/d10QYW6bC8AHSdG7wMJkUJtc4Ooxv5HEpNGfeS0PuEc9fEtUYghDItrhwIEbd
 x9jQ5TT7fDPT6bHqX5p8pa5PVjwSvYsJ1ylyYwxF5k3PqacPVBauYnAzQ7rNHYoG9ixX0k74DUE
 Vp5bKx3wTFP6RoaiyMmxSoEBJjkRu9z/rwgsCBMKi1U3AbCuvi3G6Nbxd1FIAa4wkBv3g4vhOOd
 nwws2Gy76sqT46IvOQ3qw1PvWq/EhGkdnpiglP6S0oC5Y11W/OFeWcVKook4RZB6QYNCqJFMKAi
 nCpaEZz5DFO19abjth1hw9pVn4KdMw==
X-Proofpoint-GUID: uAZ4nmpRAD_JQd97QuihERZCYZSDzOnN
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=693bb8eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=VO154oAPRzwd1e8s0VMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
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

In svm_migrate_gart_map(), while migrating GART mapping, the number of
bytes copied for the GART table only accounts for CPU pages. On non-4K
systems, each CPU page can contain multiple GPU pages, and the GART
requires one 8-byte PTE per GPU page. As a result, an incorrect size was
passed to the DMA, causing only a partial update of the GART table.

Fix this function to work correctly on non-4K page-size systems by
accounting for the number of GPU pages per CPU page when calculating the
number of bytes to be copied.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 59a5a3fea65d..ea8377071c39 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -62,7 +62,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, u64 npages,
 	*gart_addr = adev->gmc.gart_start;
 
 	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
-	num_bytes = npages * 8;
+	num_bytes = npages * 8 * AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
-- 
2.52.0

