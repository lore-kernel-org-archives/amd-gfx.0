Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA9BD44144
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A12110E5A1;
	Fri, 12 Dec 2025 08:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="KdYauSzQ";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362DC10E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:50 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BBJ3Dqd019682;
 Fri, 12 Dec 2025 06:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=p8Qx1cX1xshUKtT7y
 b/sdmINeR+cAornK4LPFNex2nU=; b=KdYauSzQfe6NIZ9PHdiWk+LwEwArPh+qJ
 022S6ZAIornJ0/OwMv8oOL8YzJmxK+Bfj4w4Hbb+ohtuQiORU0FFONoD1ut9Xt9/
 ihiZCO03nWOZgJmbYvgsTYj8jCdc3ulYUjSGAqvpA7W1+Uar2cuSyKTyB4xeAkMB
 60YgJGd14R8DB6xj7ZUIVOm5UBbQulW3cX+sGIxbN2I48LLT1bdRrUiSjj/MLr8l
 ZoYkBKNJPMHhLZK6vT//SitS37HxRWsM4LRwz5KuIOar0NY9rcGc1ZNOPlIP8oGB
 evVljtxPlYBOuFdlsBNHc3kel0p6WD5HpWe5sLHt1+nSKp/Oduc1g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kbw8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6emTl019052;
 Fri, 12 Dec 2025 06:40:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kbw8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC6PGaD009044;
 Fri, 12 Dec 2025 06:40:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytnahur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6ehNO51642744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A65A20043;
 Fri, 12 Dec 2025 06:40:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2739020040;
 Fri, 12 Dec 2025 06:40:41 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:40 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 5/8] amdkfd/kfd_chardev: Add error message for non-4k
 pagesize failures
Date: Fri, 12 Dec 2025 12:10:12 +0530
Message-ID: <e2acded2b3d3595ae11a855af496c5699d486732.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693bb8f0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=mI4_J10A3sktJIvxlQQA:9
X-Proofpoint-ORIG-GUID: ahg-Slb4PYa8QaBAeOse5l14dAl-Z5yP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX5jwLrYqWzOJt
 YJJzoTkktcRh3tUlTXYIS6xsXrmaLPvdk+c680P5vJTA9ctQRHP/YKwnFpq5WKVyE3/JVdY0a/Q
 9c0Kj7Yx1ka5LuZATwBsh41ph4NWBMxgTP6UmRHmbSSSaivHHVAHeXYAHxij+u2g5gTzof8Vj3Z
 4z5InDDE+ZZutO9YFrjINRi7ur+4an/o9uRTkFbmIaGLjM2zre1r3MqkNcko6Z6Bh57k60+PwMU
 gw/U843xgPuHJ8YYIH03pqxZUunaoSazGAX3pY7my5SrDTs9PWwWYe57e7RDgC9Uw9C3g9apGXQ
 VX+FpgPrEOUpzoM1/50YhTS4DL6VyQam+CWg9LeND4g5InSvrj/qnZBlKdp7sFkjHBapI4LHbbw
 aZbTu1xv+WMxiepKwwiXdilpwdXq5w==
X-Proofpoint-GUID: lZUT3wHCXbnfa29zpUmDbUvp5tbtmxxX
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

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

In the current driver, MMIO remap is supported only when the system page
size is 4K. Error messages have been added to indicate that MMIO remap
is not supported on systems with a non-4K page size.

Do we need to lift this restriction and add MMIO remap support for systems
with non-4K page sizes?

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 0f0719528bcc..19632795c389 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1134,6 +1134,8 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		offset = dev->adev->rmmio_remap.bus_addr;
 		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
+			pr_err("%s: Failed MMIO remap off:0x%llx PAGE_SIZE:%lu (requires 4K)\n",
+				__func__, offset, PAGE_SIZE);
 			goto err_unlock;
 		}
 	}
@@ -2317,7 +2319,8 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 		}
 		offset = pdd->dev->adev->rmmio_remap.bus_addr;
 		if (!offset || (PAGE_SIZE > 4096)) {
-			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
+			pr_err("%s: amdgpu_amdkfd_get_mmio_remap_phys_addr failed off:0x%llx, page_size:%lu\n",
+				__func__, offset, PAGE_SIZE);
 			return -ENOMEM;
 		}
 	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
@@ -3367,8 +3370,11 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
-	if (PAGE_SIZE > 4096)
+	if (PAGE_SIZE > 4096) {
+		pr_err("%s: MMIO mmap not supported with PAGE_SIZE=%lu (requires 4K)\n",
+			__func__, PAGE_SIZE);
 		return -EINVAL;
+	}
 
 	address = dev->adev->rmmio_remap.bus_addr;
 
-- 
2.52.0

