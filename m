Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8EDC55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583CF10E66F;
	Tue,  4 Aug 2026 09:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="pVqSaB+S";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B2410E985
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:53:26 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748HhH92640474; Tue, 4 Aug 2026 09:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9CpzT5xcSl8m0iSQF
 pyDldwBKZG45SBFEc7S3Vuy+U8=; b=pVqSaB+SyTw12rZ2AQLoDKhlSjFLj+Km3
 +TdkINdQKoXtZOpr8awGBZ/CQhwZHPV61lB7mN5bCeWQOYfqWX57sduM94GRc5T5
 k79Ekks/TwCOCfHgTIZ9EPPy+Xkpa9FawapZOiuYpvi/O14fOCWjTvE9nq+y9OWl
 UOzUZQKSiiFHxMATZ/eRv9spFnU2tW5V+fYQTqGs9WCjOyayt9Luf8AOgpjrtehg
 0GTVIEs70+CMgOFBbTwuSZDrQCfJriuObo0VtPicH2uoTIL4ERNblA31GIwxfA5W
 gNtACAEAlGC/Sl3ffJcMz3ar3zfwvvVOeo/13at+FkJNwqQT7KasQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqn5uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749fc7x002317;
 Tue, 4 Aug 2026 09:53:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k1d1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749rIXY42664242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:53:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 383AD2004D;
 Tue,  4 Aug 2026 09:53:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA54B20043;
 Tue,  4 Aug 2026 09:53:09 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:53:09 +0000 (GMT)
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
Subject: [PATCH 2/7] drm/amdgpu: Add VCRAT NUMA affinity entry
Date: Tue,  4 Aug 2026 15:22:31 +0530
Message-ID: <1bc2f3dec1e1581c75cf5a3a763501938904e204.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
References: <cover.1785833981.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: pKbTj9WyJhpB8DzL49MALbQt9EypcCpP
X-Proofpoint-ORIG-GUID: D2UV-PUJwDiOrQAvsdLJO-i_Y9nWcxE5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX0NAjWlFQf0oq
 hRqJuQEJCyjYFW4PiNf63am6bCvyj1YcVtV3bDNFLpLulB0J1iuP2P7ifUjOPS0u3MOWWTq7RRa
 X7udhKGE2xndTDagFcbfn2sbicbsiQM=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a71b694 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=0pWw5A29kBFUHFPdO2AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX/vC/RUISy3IX
 oH4bikmokzlER5wLleGRuNWXdJKdtpJW4T99ptqKjB9VH6t+Omb5Oqv0rRa2Bwl5hT8IBn4aFC5
 BNg+TdGnTs8CfKo1L+zoOrQa4wkx1QosKEFXk8sZ4vFM/kjnvz02U0LtMyXY8K2qXUWy+0HIn1z
 RSs9SBHT5ZUE8NbOwRVDljWmpu5PbfPPA/qPwpX+WoRCg/QC1zR/oyfGZ3fZtK/Yxa4aOs07lHc
 CcORbfRJuroH4hBb0dyXzgEQFK996bnf4RouLCAIcG8T7Z7KUqrKWzronyLBiNkWi6+Soqd0ycK
 nX1UKl1LEQE0wZRpMF3VQYcmX2dX95Sz6LSBRZYP4pf6xERv5bV8DziwSD66PGkGus+p6FAeoex
 HGSI6RAFzBoCIsOHhbK6D4lC/fbWbHKgpDW+jAwxgOh8XC/gEW1rT6zNhsnbcg7kzrsX0UlUHMc
 rTbJXYgay0Hb2ttgbbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040077
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

Add a new VCRAT subtype to describe NUMA affinity information.
The new entry stores the NUMA node ID and proximity domain.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index 252fa94aaab9..934cbb54b0ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -75,7 +75,8 @@ struct crat_header {
 #define CRAT_SUBTYPE_TLB_AFFINITY		3
 #define CRAT_SUBTYPE_CCOMPUTE_AFFINITY		4
 #define CRAT_SUBTYPE_IOLINK_AFFINITY		5
-#define CRAT_SUBTYPE_MAX			6
+#define CRAT_SUBTYPE_NUMA_AFFINITY		6
+#define CRAT_SUBTYPE_MAX			7
 
 /*
  * Do not change the value of CRAT_SIBLINGMAP_SIZE from 32
@@ -280,6 +281,18 @@ struct crat_subtype_iolink {
 	uint8_t		weight_xgmi;
 };
 
+/*
+ * HSA NUMA sub-type header
+ */
+struct crat_subtype_numa {
+	uint8_t		type;
+	uint8_t		length;
+	uint16_t	reserved;
+	uint32_t	flags;
+	uint32_t	numa_node;
+	uint32_t	proximity_domain;
+};
+
 /*
  * HSA generic sub-type header
  */
-- 
2.54.0

