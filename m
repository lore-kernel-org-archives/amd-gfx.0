Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23902CA5FF0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 07:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC5910F21B;
	Tue,  6 Oct 2026 07:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="sJf4MhSy";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C443110E5D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 14:00:50 +0000 (UTC)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CZotu504258; Mon, 5 Oct 2026 14:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Qya1ERpNiXHdq8fn9
 j0H/oCBAkqog3LgBruJdiKlgW4=; b=sJf4MhSyNhluA2V7KC38rUh0W2Cw3EB28
 2ctk/t2ZPvNTxkkKl5PfshRMe8IzO9VHJQkoa7DrwCDLqnYVjO0BhUpHP9z3Jr+E
 lGMQ0kfaZX5vS9BJ+7r07uTq/9nNqq6tPk207GeHn263U5F2lbFsmtsk6GwSU9Qb
 Ftb/xPg966G4bVJN46ocfwkYbb0rz1c+YZFk8VEMeQvnL3JGnc8JGOMW69r485z2
 RaC4b6XT08KNF76K8GS+R9cI4fEK4t/V7eDI2tp1dzDQSXm249VmCAS+cGqNTPOi
 ZMVvSrVWen9cuoTKQjdqwF84AdOwVMEQ5kJGQGfYPrzH4FR0epQqg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jj8fk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CHoZh2900848; Mon, 5 Oct 2026 14:00:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pnwbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695E0gOC44564878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 14:00:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19D4820043;
 Mon,  5 Oct 2026 14:00:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D7962004B;
 Mon,  5 Oct 2026 14:00:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.115.22])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 14:00:38 +0000 (GMT)
From: Dhruv B <dhruv.b@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com, dhruv.b@linux.ibm.com
Subject: [PATCH 1/3] drm/amdkfd: Remove unused code in CRAT initialization
Date: Mon,  5 Oct 2026 19:30:21 +0530
Message-ID: <c10cf71b7923704e8f4ebfe97077dd51b9ff1737.1791208447.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791208447.git.dhruv.b@linux.ibm.com>
References: <cover.1791208447.git.dhruv.b@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sLNzqUufTkz-GetboB-YFGPmDben3dM4
X-Proofpoint-GUID: XRg0kr3rCQF0YsXuQtFQc_F4ZrM201G6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX2AH3kLdalP92
 Kekk1ypYNM+UZPiS9OfFh/fBjt41NhCR3ey1Hmv2Ymg9MUhCeXaXbb4oOOUehv+fAUoTYpi+fD+
 3eYExYp6+0ahr+ncz2sltzdwTbO9TNo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX9wqx5lCRASi3
 8dBpXjVnobpj0KUhGDjpJxhBlCfM2CUpyHwTTo0ohzYYDeKss3b8s0MO8WKDS+Quv19QlUpH2pW
 1sYAkf9N7nnvrZUxt3G6O/5Th6aWCQL4LtpNUxAkeIAaZA26JYhm7XAC3gCq1GHvpri2NJBQMzx
 aav3iXt717cGcoFeQ+XKDmC/8oovMIai8NVr8NwhI+TMsSQZIS+XDnnZB/CGGal84Ncw7z6kteD
 o1HZKN6fuOIlxeW0HCaBM19oOu4vpIYoLrYz8Lo5fo8p7ouguuS3f8JTtCGK7c0VmbakqyU0UUg
 uyF+Ao8Qns264Aq0+I3oRtAm/RYj9g310o2N7sQ2MeP1cy0DoNWhMDtzP+UZDweUgkKBxExss/O
 GcFH1Uebi51lMZZWT6nw8caX1f30K+W/Zc9DQKRQlAoY87QRAfavnUIV+jBRDljssvsO9b0OlWX
 plYGgydd69aZPgiJv3Q==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3ad8f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=aW7DMclhPewLEMwWYsYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050053
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:35:16 +0000
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

