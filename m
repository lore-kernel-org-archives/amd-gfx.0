Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB339C5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3770910E982;
	Tue,  4 Aug 2026 09:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="hUM674di";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9064310E982
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:53:15 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748HZur323810; Tue, 4 Aug 2026 09:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ilvfGacKHSyXU104e
 Qj7KUy78ePlQd7DKzytO9jdP7M=; b=hUM674diUPksPodEElIFpmixfydHb3W1q
 qmDOKMaCxE5At7+bEPeuhVi3prOLltDKQH5D7PlczuDopIV1n1haZk7tuS8yrSv+
 VjtI+xgfx3tl1zJC63EhC+Ta/VoVcSjSOcp9hfiaj0zELuIWdmiIUcODrSv8me7j
 9hExrhldRzngp/R/ouToyeao6YylvF40Bl1kaPKZuzC+islY5tiLLmrFBu6vNtgt
 zwqQ5/GaBMoh5OqOhu3n4NDJ1dYlBoKm3hUUJQXMwRrQW332+SvwgrrzQlz5UEpO
 5IxehOYME1K1md1iqKrzWLbD1guT55sS4/tXctfyvJMErIPwaIvrA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4w7tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749fHpQ002172;
 Tue, 4 Aug 2026 09:53:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k1d02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749r63c32506142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:53:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C104D20043;
 Tue,  4 Aug 2026 09:53:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40A852004B;
 Tue,  4 Aug 2026 09:52:58 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:52:57 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 donettom@linux.ibm.com
Subject: [PATCH 1/7] drm/amdgpu: Remove unused argument from
 kfd_create_crat_image_virtual
Date: Tue,  4 Aug 2026 15:22:30 +0530
Message-ID: <52c0aa0990ea384cbbdb2dc447193f8ce04b510c.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
References: <cover.1785833981.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX24e4qkH+IVKN
 NHsU66wu2LFFepWroFA3wKSQkhjcrqSHZiggJZVLI7cnUSnoNc1HYjRQPqRcCrjz/DhSUj5PF+I
 oSD+ojFaDjj94vCsejN78gvSQmsyRKk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX3bGox2xhFfz/
 KvoBObDH/L7wNZILAlo3g/MlAjEgNSko0+Io8cViqwmFk2JhJEm3kJ+3W8NNJZPaMnA2Z53n8X2
 0/d7RU4sFFgS9xvxze6tUCz7hV5dTyB3dybi2uaPm3DdWFbHdz8WGFtfTdBmXDLJ6bABKiXkxkg
 XUJkO+O3S091hY2eUgZMdO2OYkZEOstuCsl5pITAQmosr0MkiSYk3tkeeN4RhnxU8PoUAymkQ8J
 NoY158k3UtPlOLP2owHPiOtWaT/WzCjWln9GvPYZ/o+Yp0dsoPwkpxwZE+d3AXtYZYaX1p+Gopi
 GmgK/PVMS+x9G/SkzfrmlD1PhNkRxnTs5B/Bzy8B+rSKXq4TJ4b4b5tqm9bSIImVKAeDWEKH0Jd
 1dd+fXunxNGGiLfNQZlxwsOb5Rg95BkZ644GKsOGLLSul9ln2KqbDz6Yt3EBGskld34AMLY355F
 m5JRUgMpxLuWnBE2fSw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71b688 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=zVDP6jv2VJWIwASN-G4A:9
X-Proofpoint-ORIG-GUID: ROLSG68NXqcY5SdpcojUx77tb2rZJbhj
X-Proofpoint-GUID: QKTWH_bQHfJRpR83easuE4bi0pLXffkE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040077
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

The size argument is neither passed to nor returned from
kfd_create_crat_image_virtual(). Since it is unused, remove it from the
function and update the callers accordingly.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 11 +++++------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 12 ++++--------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 2a239f45fc24..3190a4d6acc6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2412,8 +2412,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
  *
  *	Return 0 if successful else return -ve value
  */
-int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
-				  int flags, struct kfd_node *kdev,
+int kfd_create_crat_image_virtual(void **crat_image, int flags,
+				  struct kfd_node *kdev,
 				  uint32_t proximity_domain)
 {
 	void *pcrat_image = NULL;
@@ -2440,9 +2440,8 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
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
@@ -2450,8 +2449,8 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
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
index a8ca7ecb6d27..252fa94aaab9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -313,8 +313,8 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 void kfd_destroy_crat_image(void *crat_image);
 int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 			 uint32_t proximity_domain);
-int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
-				  int flags, struct kfd_node *kdev,
+int kfd_create_crat_image_virtual(void **crat_image, int flags,
+				  struct kfd_node *kdev,
 				  uint32_t proximity_domain);
 
 #endif /* KFD_CRAT_H_INCLUDED */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 00517c3d0e6a..f4b7cb44daff 100644
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
@@ -1023,9 +1022,8 @@ int kfd_topology_init(void)
 	 */
 	proximity_domain = 0;
 
-	ret = kfd_create_crat_image_virtual(&crat_image, &image_size,
-					    COMPUTE_UNIT_CPU, NULL,
-					    proximity_domain);
+	ret = kfd_create_crat_image_virtual(&crat_image, COMPUTE_UNIT_CPU,
+					    NULL, proximity_domain);
 	cpu_only_node = 1;
 	if (ret) {
 		pr_err("Error creating VCRAT table for CPU\n");
@@ -1871,12 +1869,10 @@ static int kfd_topology_add_device_locked(struct kfd_node *gpu,
 	int proximity_domain = ++topology_crat_proximity_domain;
 	struct list_head temp_topology_device_list;
 	void *crat_image = NULL;
-	size_t image_size = 0;
 	int res;
 
-	res = kfd_create_crat_image_virtual(&crat_image, &image_size,
-					    COMPUTE_UNIT_GPU, gpu,
-					    proximity_domain);
+	res = kfd_create_crat_image_virtual(&crat_image, COMPUTE_UNIT_GPU,
+					    gpu, proximity_domain);
 	if (res) {
 		dev_err(gpu->adev->dev, "Error creating VCRAT\n");
 		topology_crat_proximity_domain--;
-- 
2.54.0

