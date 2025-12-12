Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9ABD44149
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40ADE10E58A;
	Fri, 12 Dec 2025 08:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="sMdUoaj3";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8958610E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:34 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC163Hr000648;
 Fri, 12 Dec 2025 06:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=c2SKhvuckDjV+LWPP
 8R7EQZTSpUr5bSbsrfoHXhJsfk=; b=sMdUoaj3rC32HaQSWKo3wnP+MVFHrmERI
 WXQhhOYTTod9WVKTo2Rma7Dq4aakgX6dukcYSESlHHW2kB7Q9NprAlJn63kizW0E
 G6JDSm74QuDLKyGiuOiUP/09d1x/uIXolJtXrnkaP/vyYjYKcPwWr6QAopolVj1U
 xAlR43qbJHwrgOy0VNMwcQ80FADdj9PlAxCS51TWGw6HD3s8I1BXZdxxhCgQk/oW
 SqnDomZ6q1kYGPddL2xtnHUQSWlISjiIfIwoDeNsiGO0HkjoQzKns6pJh75VI/q6
 lQDG8+IRlxGSPQwmQWoySsc1zkAZ0R2TtAz4ytdAsB2XRodnsIYIg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww38eu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:32 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6Wh2S019898;
 Fri, 12 Dec 2025 06:40:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9ww38er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC2Z1cr002044;
 Fri, 12 Dec 2025 06:40:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jtc5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6eRiW24445404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A6EB20043;
 Fri, 12 Dec 2025 06:40:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DF1E20040;
 Fri, 12 Dec 2025 06:40:25 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:24 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 1/8] drm/amdkfd: Relax size checking during queue
 buffer get
Date: Fri, 12 Dec 2025 12:10:08 +0530
Message-ID: <afa131799094e31bc6180aaa310cbca38185635e.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0gDLnv7b09r5Y8DpCQm_nH0ddEiW4r_K
X-Proofpoint-ORIG-GUID: OE6UGDxlulOeI4r7xQBy1F6O-BdCTSpS
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=693bb8e0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Yldw2r_RfE3TVAH3efQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfXyKTdkVQPfFGd
 s+K1gS/wC9i5F9aq9YYalBOsu+jdVRBl1lPATcWtXgL3UCXqIrQF2qzuSlvuB9yf4FAo6D3Es1e
 PsmJ42pa71xA578olaijscfv7MkizJMQ501u6zm3MW485Ujk1b4mmZOC8js32FN6B9oy1TzKNT0
 0E+OH3zFz8aj2iTrQ9UtLL81KoWSLAEeInDQM7Tuf2RmbMieZBunWlCpipOqmTdYscnQBZJCnWT
 d/wfRz+GPooMFTdGGiRtTJJmhrgPzI15rEXdbeHEbahOJGS+LS3Ryr1vyKuiOHruBR25VxG9UX/
 9E95dIBn1XsKrjl9s1IYG8CulE8gw8IGVUCSwLyCiYyDmHtZeLGgPdwWO5uJamPVci27nmBhLw+
 m8llrVJPRBp3eZipCqpJmqVKzxD9GQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
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

HW-supported EOP buffer sizes are 4K and 32K. On systems that do not
use 4K pages, the minimum buffer object (BO) allocation size is
PAGE_SIZE (for example, 64K). During queue buffer acquisition, the driver
currently checks the allocated BO size against the supported EOP buffer
size. Since the allocated BO is larger than the expected size, this check
fails, preventing queue creation.

Relax the strict size validation and allow PAGE_SIZE-sized BOs to be used.
Only the required 4K region of the buffer will be used as the EOP buffer
and avoids queue creation failures on non-4K page systems.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index f1e7583650c4..dc857450fa16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -199,6 +199,7 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	struct amdgpu_bo_va_mapping *mapping;
 	u64 user_addr;
 	u64 size;
+	u64 bo_size;
 
 	user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
 	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
@@ -207,11 +208,12 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	if (!mapping)
 		goto out_err;
 
-	if (user_addr != mapping->start ||
-	    (size != 0 && user_addr + size - 1 != mapping->last)) {
-		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
+	bo_size = mapping->last - mapping->start + 1;
+
+	if (user_addr != mapping->start || (size != 0 && bo_size < size)) {
+		pr_debug("expected size 0x%llx grater than mapping addr 0x%llx size 0x%llx\n",
 			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
-			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
+			bo_size <<  AMDGPU_GPU_PAGE_SHIFT);
 		goto out_err;
 	}
 
-- 
2.52.0

