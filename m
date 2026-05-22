Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F02CD5BB1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 11:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F11F10E1E6;
	Fri, 22 May 2026 11:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="MM7mB5y5";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3C810E1E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 11:29:02 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M5A0if552016; Fri, 22 May 2026 11:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=j0F3UOKf+F1sukXWxtjosOMf4ilwBikpDZkP88l1f
 AU=; b=MM7mB5y5X7YOp/scG+Vcmi55F819e+rqzjSlp+MyeqIAW75Gmi0Y+YfiI
 WP2s9Oqu+jPAOmpiqFWcyzvOpbcd0TTEWxNpMvu8EIXIvjIywfJJUwf+aU9upQoc
 mRcf1eVIGy7pAjW7AfA45TSX0Zh1ROHugXmRsPuLHBfkIcN4L1CC0GffhwMLzpUE
 HkgJkm+4Dx9m1Y+mAJYQ/klKJdHpKALXKPi9qwM84o9QJkFpVoIday0P4u9Q61UJ
 auFTPoU5qnO5JoWPcmjVAkfKzXzgog0/E2YvRclEOjWIdlH7JtduH6uZQEoH8ihj
 L1Obfn+i1SjB/q4KqKIP3D/oUjc3A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9ybsgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 11:28:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MBO5YY022338;
 Fri, 22 May 2026 11:28:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kygc6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 11:28:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MBSrZx34079000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 11:28:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C244B20043;
 Fri, 22 May 2026 11:28:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 806E520040;
 Fri, 22 May 2026 11:28:49 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.124.215.133])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 11:28:49 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Simona Vetter <simona@ffwll.ch>, donettom@linux.ibm.com
Subject: [PATCH] drm/amdgpu: Fix num_pages calculation in
 amdgpu_ttm_map_buffer() for non-4K page sizes
Date: Fri, 22 May 2026 16:58:38 +0530
Message-ID: <20260522112838.1311531-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExMSBTYWx0ZWRfXzuy2OR5RqMw8
 jmjNkp+vX7w2WSBDBi8erEDzpSEE47fp+O+HbUHPS0XA8XCymDEyoweEpa7rxqx0Rvr9sK+Q/6S
 YHhkyJNeEeQDhxESbC4QeloJLc2QLty8Vk0OhEcY27EeF0ItPvnx7ayTZIVyKens5o7r6srK2Jw
 2QUXrcod0RrjUWIcuyMAvF/8MMa05V702Ksf06b/+9GnxHWn44yWiJ1Ulm4fhYoGQE1AJ0piGLm
 GnMew5j7fvl9VO3FP3V+Yj50CV5sOuGhqO+gNstAPxIfru25OHn16xd7pFdRwNn8+ao4BqFBdQ3
 zUOvTG+Y8N/hIv6oiY+ynYwPT1fvuHAUH5w4Xn/7IFXyoJwik0+pmS8Y89JoMuCIIXvIFhh6mIY
 BH7c1H2iYavgZqWN3hHmNg5iC2maMR9MXSNu2lPC/w2RzOw2t+Mal38nfp0zd/4cV9Ah9800nzq
 A83A4XIwIbChRWMb5sQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a103dfa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=a8vC4wPsTAyIL7P2QdwA:9
X-Proofpoint-ORIG-GUID: BhwFp5tigKGL03duB2L8DmCUJP9wLhqf
X-Proofpoint-GUID: swo9z9t92GQO68IWQMeS85dvFIPyzrLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220111
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

amdgpu_gart_map_vram_range() expects the number of pages (num_pages) in
4K page units. However, in amdgpu_ttm_map_buffer(), the number of pages
is calculated based on the system page size. On systems with non-4K page
sizes, this results in an incorrect number of pages being passed to
amdgpu_gart_map_vram_range().

Fix this by calculating the number of pages correctly before passing it
to amdgpu_gart_map_vram_range().

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3d2e00efc741..2904a9400605 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -269,6 +269,7 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
 	} else {
 		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
+		num_pages *= AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 
 		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
 	}
-- 
2.47.3

