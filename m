Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AA606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cyZmGVtm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A57811244E;
	Thu,  5 Nov 2026 13:45:30 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83AEB10FCA5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 19:07:45 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiBTZ959619; Wed, 4 Nov 2026 19:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aRjllXX2fprX0xDrJ
 nrMZu23uHZN+y6R0gI5A2OSaAU=; b=cyZmGVtms7a/Jip3wDlT8s4W2UDXjBV6n
 uX5w4b1oAb+Kvez+CTr8r1KrXUmceWPiZSv2Xw2kjmiD/iqVVh6hRaTgppBPfhXO
 6HXY+Jhv2+aCRVzfKg00pCvA39HH3wucVSEHLHNxsAHcjjZ3nOGuF1tWYIMxeGy3
 FrWrDexz+I0ciSe4pBrz3AGdQwMVAix3T9uLk6D+uuZkjK5fxW/MCAOrKEUfIj2Q
 L9pnGNRpzV/udh12yKNoVOhmEr3WC+ENKf+H1IBZRL99jAZvNiz7o+VDqmT9kC1M
 v5VEUwroz64DvMyZeX9N7H8KBnzl0jtTaF3/jop6ImAgcCG3oQkGw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826wtau-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 19:07:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Ij4DD204440; Wed, 4 Nov 2026 19:07:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqf0gf8xm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 19:07:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A4J7cM349545628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Nov 2026 19:07:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05B3D20040;
 Wed,  4 Nov 2026 19:07:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04A8820049;
 Wed,  4 Nov 2026 19:07:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.118.53])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Nov 2026 19:07:34 +0000 (GMT)
From: Dhruv B <dhruv.b@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com, dhruv.b@linux.ibm.com,
 Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v4 1/2] drm/amdkfd: Remove unused code in CRAT initialization
Date: Thu,  5 Nov 2026 00:37:17 +0530
Message-ID: <20261104190718.68457-2-dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104190718.68457-1-dhruv.b@linux.ibm.com>
References: <20261104190718.68457-1-dhruv.b@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 686Ne_2zCZChvdsqxB6tvHWwjm73jSUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX7Ik76Ha4Vnk0
 5DANTs+H8pqDcCRWtLHTi2OFwQWszchILrfivwYIgvphWfeZTlD7XG4Lz/MXN+acC5AtQnSp+tW
 eej0AGaovVaJNtYTZQWFQt9ZRQVP4JMHS+pMLvHvJDgBah1z+vb+opBxJv8bX+VD+5d9cg0fRCl
 yFhxdC9nRZn9dhDsm6ObeoK1xqYjtm/fpW9MqO49ESMkFTCMJ++bwMVmlVT/2S57lJV4CkVZHxs
 /3krCvx0UyRl5yswynVxFsiOjLOOYyx3gn0snmGhsHTStWReyosmAWXTDwzoCTcrK5lWyMbqGtp
 i4RIdblp5+NT31Q+RjTs1fG9Qq0f9Uyz0o135022Tdw3t9CgRHOfWo89r93dQCbGh+8UK2RpDlI
 mjO6rkWoAULKbUmlNgogXkNN5oL/ovNHp0eBDfqO99Hx2yyH0takiX3ie548t7PL0Mo2wydCCEM
 latQukkVDsj1UExwliQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX8nQDCuKZa0cp
 8wUBAxf0tOh17h07SVzLlez809LeehcWbtpuFptgynR7AbXldz0X3XWJTAvYb5S9MAE7/wgW1fp
 tcY8dHhPhjcb1Dq+yeIFyEkRFgEaOZQ=
X-Proofpoint-GUID: dpBxPaqWWYr6vnGUSBU8zr0dx7sqyX4X
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aeb827f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8
 a=aW7DMclhPewLEMwWYsYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040074
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0

