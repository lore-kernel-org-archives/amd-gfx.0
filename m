Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D737FCA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6665910F5A0;
	Wed,  7 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="UrbPL3ta";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E0610E031
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 12:51:45 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BZUrd3595064; Tue, 6 Oct 2026 12:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BU9/EQdf/cPfecTls
 ox10+pap8zx5X1mdjkLzbpBV5M=; b=UrbPL3tajiVTpt3+VZH9Aqzb8+oMglvX/
 z+cP5Sf4eBhUmkyjHD3Et6k38aBYenCZDLHs8AyaS128oSOE9EJ3Z7XQaX64W7yR
 kQ0jA+36KAKrWE7mw7Hs5nEBQi3+VJgKdmShFYRfp+3gO1eTHjZXwofEchXxofR2
 urc6VVwC6L7wzi7RB5r1m+R5ZcUjaQMaoKdWMVElTZ6QyJjMphYJyM+DAwrqY9tc
 iWixwZgGFLE3n/NVi+7QqQgSHqqLPjo6A/eVAgnnCcebf7IXbcpKMbQPkIaazSS6
 XVG5+wM9S72TVsgdCb3hVJPOQDJ31CKHQH4aCtbNS8VPhr1dYH3pQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5fyvs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BlYjb220923; Tue, 6 Oct 2026 12:51:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvt19y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696CpbG947186232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 12:51:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6ADA2004D;
 Tue,  6 Oct 2026 12:51:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C9BF20049;
 Tue,  6 Oct 2026 12:51:34 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.4.213])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 12:51:34 +0000 (GMT)
From: Dhruv B <dhruv.b@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com, dhruv.b@linux.ibm.com,
 Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2 1/3] drm/amdkfd: Remove unused code in CRAT initialization
Date: Tue,  6 Oct 2026 18:21:22 +0530
Message-ID: <711c32a706f474833608a03439518e40cb3c04a9.1791289746.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791289746.git.dhruv.b@linux.ibm.com>
References: <cover.1791289746.git.dhruv.b@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfXwL9EHV6Qenyx
 6CzndWHbPaKb7uYuaux9sNsaqp6kiaIy6IoP8yh2VpPggYtkM7Fv8iUXRqHQd//UzGEACD8Bxkm
 f+opMQZVDfbS9PnE6t0WTLhwzBfotOo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX/kv9x3cl1Ct8
 f3irYCK2CeKhig3jhpljC6N3Cv3okg/EsY3xYc2bbUyy8W/alzg1YbPpz2HHeUTkUPlelnXBCCi
 hYgnkF8WcNAIQsa2U9rqLChTn7WWXNp4pedcJqu9hPRpDcCjTFJZVZiAMw1UO911xFu4rW/0Sx7
 i7BU20vYR6LCCVkV+sLBLiycsPUOiSDr4NA9srS5vtSX+G095Kv+ARau9kOUxttaqYiut4ZkWc+
 mhX3oAHIu6kTeXTr+54YDhVhhs1p83yOk8ondwBLEYaSIhNu0hoxL4i8AxHRKTrhbwe+5ItIo5t
 0vbDQvfeJ6Ln3uAB8sXnZjGcDLOGrudHNx8aEp0r+QP7rvFOxP8mDxjAhCWBo9zwpmI77xVUowg
 Ybzuw7M4NrmbKhUORKL4OoBNNrFnhlZsQNsDo/y2lVbR0T/jaCZjpxrMsGMZ/CNbCEdC0Xmdqk5
 R7HhWW8zMtF1xqESe8Q==
X-Proofpoint-GUID: NVDS0svru1tdTItUjOQS92frQW2Gnm7r
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac4eedf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8
 a=aW7DMclhPewLEMwWYsYA:9
X-Proofpoint-ORIG-GUID: P4END694Xt4hMV6ryZK64Wdm2v1ZluDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060050
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:22:26 +0000
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

The 'size' argument in kfd_create_crat_image_virtual() is not used
by callers to retrieve the allocated CRAT image size. The callers
rely solely on the returned image pointer and inspect the parsed CRAT
table header directly for entry counts and lengths.

Additionally, in kfd_topology_init(), the 'kdev' pointer assignment
via list_first_entry() after parsing the CPU CRAT table is not being
used and can be removed.

Clean up the function signature of kfd_create_crat_image_virtual() by
dropping the unused 'size' parameter, manage the buffer size locally,
and remove the unused variable assignments in kfd_topology_init().

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 10 ++++------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 ++---------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 6e0df685503d..99b0c7f825fe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2411,7 +2411,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
  *
  *	@crat_image: VCRAT image created because ACPI does not have a
  *		     CRAT for this device
- *	@size: [OUT] size of virtual crat_image
  *	@flags:	COMPUTE_UNIT_CPU - Create VCRAT for CPU device
  *		COMPUTE_UNIT_GPU - Create VCRAT for GPU
  *		(COMPUTE_UNIT_CPU | COMPUTE_UNIT_GPU) - Create VCRAT for APU
@@ -2421,7 +2420,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
  *
  *	Return 0 if successful else return -ve value
  */
-int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
+int kfd_create_crat_image_virtual(void **crat_image,
 				  int flags, struct kfd_node *kdev,
 				  uint32_t proximity_domain)
 {
@@ -2449,9 +2448,8 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
 		pcrat_image = kvmalloc(dyn_size, GFP_KERNEL);
 		if (!pcrat_image)
 			return -ENOMEM;
-		*size = dyn_size;
 		pr_debug("CRAT size is %ld", dyn_size);
-		ret = kfd_create_vcrat_image_cpu(pcrat_image, size);
+		ret = kfd_create_vcrat_image_cpu(pcrat_image, &dyn_size);
 		break;
 	case COMPUTE_UNIT_GPU:
 		if (!kdev)
@@ -2459,8 +2457,8 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
 		pcrat_image = kvmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);
 		if (!pcrat_image)
 			return -ENOMEM;
-		*size = VCRAT_SIZE_FOR_GPU;
-		ret = kfd_create_vcrat_image_gpu(pcrat_image, size, kdev,
+		dyn_size = VCRAT_SIZE_FOR_GPU;
+		ret = kfd_create_vcrat_image_gpu(pcrat_image, &dyn_size, kdev,
 						 proximity_domain);
 		break;
 	case (COMPUTE_UNIT_CPU | COMPUTE_UNIT_GPU):
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index a8ca7ecb6d27..418a3939eda3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -313,7 +313,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 void kfd_destroy_crat_image(void *crat_image);
 int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 			 uint32_t proximity_domain);
-int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
+int kfd_create_crat_image_virtual(void **crat_image,
 				  int flags, struct kfd_node *kdev,
 				  uint32_t proximity_domain);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 35b3abe57b80..b38d12f3da84 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -996,7 +996,6 @@ static void kfd_add_non_crat_information(struct kfd_topology_device *kdev)
 int kfd_topology_init(void)
 {
 	void *crat_image = NULL;
-	size_t image_size = 0;
 	int ret;
 	struct list_head temp_topology_device_list;
 	int cpu_only_node = 0;
@@ -1023,8 +1022,7 @@ int kfd_topology_init(void)
 	 */
 	proximity_domain = 0;
 
-	ret = kfd_create_crat_image_virtual(&crat_image, &image_size,
-					    COMPUTE_UNIT_CPU, NULL,
+	ret = kfd_create_crat_image_virtual(&crat_image, COMPUTE_UNIT_CPU, NULL,
 					    proximity_domain);
 	cpu_only_node = 1;
 	if (ret) {
@@ -1040,9 +1038,6 @@ int kfd_topology_init(void)
 		goto err;
 	}
 
-	kdev = list_first_entry(&temp_topology_device_list,
-				struct kfd_topology_device, list);
-
 	down_write(&topology_lock);
 	kfd_topology_update_device_list(&temp_topology_device_list,
 					&topology_device_list);
@@ -1871,11 +1866,9 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu,
 	int proximity_domain = ++topology_crat_proximity_domain;
 	struct list_head temp_topology_device_list;
 	void *crat_image = NULL;
-	size_t image_size = 0;
 	int res;
 
-	res = kfd_create_crat_image_virtual(&crat_image, &image_size,
-					    COMPUTE_UNIT_GPU, gpu,
+	res = kfd_create_crat_image_virtual(&crat_image, COMPUTE_UNIT_GPU, gpu,
 					    proximity_domain);
 	if (res) {
 		dev_err(gpu->adev->dev, "Error creating VCRAT\n");
-- 
2.54.0 (Apple Git-157)

