Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA50C55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3AD10E67B;
	Tue,  4 Aug 2026 09:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="l3ZSVugf";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 541CA10E67B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:53:38 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748HZus323810; Tue, 4 Aug 2026 09:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ijTBwXmTwJGDKLgFe
 V1u7AIhm4sb10+5R1omtFPNkTI=; b=l3ZSVugf63hS3IwoOxbdRBIsSJlsuSU8S
 7yJBeD91vx4j3NoKN/VwdJAi5eK7QkPsdpd6p9o73zZP2ffToReypcnF4kXMIN4p
 O/vAX2CJiXcX/3iYb8XF1+bzTeC2XmXUk09voHTBTNl/u2pni7pBkjZuifoBgk9M
 /Q6oc0ZkpX8fGwIZ4dDMVHbwyv9wMfzskKbIPH8Hn6dJMxeXIQuYZ6TRCrXvCEns
 mC8HbVagd2ec4WM/s4YbWaTA58YRB0pRYfGELke0obbkheXz0aN7ZR1CBX84a1BT
 i5SvXZmOwDvqNaKG8sdvkmOyyS9uIayVwedzFmdipl3p5iGpgBjzQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4w7uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749pwoa005638;
 Tue, 4 Aug 2026 09:53:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg96a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749rTAT32833808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:53:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66D7F2004B;
 Tue,  4 Aug 2026 09:53:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0120220043;
 Tue,  4 Aug 2026 09:53:21 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:53:20 +0000 (GMT)
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
Subject: [PATCH 3/7] drm/amdgpu: Populate NUMA affinity entries in VCRAT
Date: Tue,  4 Aug 2026 15:22:32 +0530
Message-ID: <bec09fed7585ec07276f6bdc3ee536ece8c24879.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
References: <cover.1785833981.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX9bxkNbpVOXdZ
 DXEC8UO0DFQiXSJH6qKTLKg7xznIutVXr7suSAFxWC6nLo+iTqbrctojDBgwOyeAioo6wu+fOFg
 FVdQeV1a9By0TPy0+LZ2yJXjZrpqIA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfXxBt0msqQI3Ck
 pSpusSvbCs0NKs7lwtzDg6cMtdbUMbMLV13SiR19cDFuNJFCiN/SIW8zWbqN2GE7kSSKHAD+Mb/
 mCxmPPcLFNvYkgxStrjrmpXSHWu/IO3hHqjRb0+kv/6WoffAZCV3AOFF6VOpofik1ewhDZDYSR/
 fh0vw1ZSwMQjeYDTN53+qJQAM27v0E8Y71FhIt4GXmQozF/5WgW979SqRr0iGEFrUeWft1OnTqc
 LcpTD1Io3lB8AvBiPhOhg4MP1zAG+3ZnK48ddOn7U6uyfrvg/O7Z6LAAJuhWQ8s5w8iTyJwlOL5
 atT5tRp4aOblc3bSfvhG/X6jfSUnOzWCxb8CwAzcjg8mMqrGoKX1xZ3J02+HRGobbDjsXw3xGku
 PKHcyyT8VXp8Ao2j5gkVr0p9QdliMS9vXw5NmNRHaltK82mxht7Ikpi1tPJTokPJbKflO5bjvOS
 dUO6H0vXB6zoC0k56Fw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71b69e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8BfPWO-Ly2JlPZ2tXaMA:9
X-Proofpoint-ORIG-GUID: Ei45slLY97xtDV3c7LSxgjHhl5G92BjC
X-Proofpoint-GUID: H1hT9r2livqnr67uIUjNQ8oN75-vROeH
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

Populate the new VCRAT NUMA affinity subtype with the NUMA node ID and
the corresponding proximity domain of each NUMA node.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3190a4d6acc6..5613eb69423d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1877,6 +1877,26 @@ static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
 }
 #endif
 
+static int kfd_fill_numa_info_for_cpu(int *avail_size,
+			struct crat_subtype_numa *sub_type_hdr,
+			int numa_node, int proximity_domain)
+{
+	*avail_size -= sizeof(struct crat_subtype_numa);
+	if (*avail_size < 0)
+		return -ENOMEM;
+
+	memset(sub_type_hdr, 0, sizeof(struct crat_subtype_numa));
+
+	/* Fill in subtype header data */
+	sub_type_hdr->type = CRAT_SUBTYPE_NUMA_AFFINITY;
+	sub_type_hdr->length = sizeof(struct crat_subtype_numa);
+	sub_type_hdr->flags = CRAT_SUBTYPE_FLAGS_ENABLED;
+	sub_type_hdr->numa_node = numa_node;
+	sub_type_hdr->proximity_domain = proximity_domain;
+
+	return 0;
+}
+
 /* kfd_create_vcrat_image_cpu - Create Virtual CRAT for CPU
  *
  *	@pcrat_image: Fill in VCRAT for CPU
@@ -1974,6 +1994,17 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 		pr_info("IO link not available for non x86 platforms\n");
 #endif
 
+		ret = kfd_fill_numa_info_for_cpu(&avail_size,
+				(struct crat_subtype_numa *)sub_type_hdr,
+				numa_node_id, crat_table->num_domains);
+		if (ret < 0)
+			return ret;
+		crat_table->length += sub_type_hdr->length;
+		crat_table->total_entries++;
+
+		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr->length);
+
 		crat_table->num_domains++;
 	}
 
@@ -2436,6 +2467,7 @@ int kfd_create_crat_image_virtual(void **crat_image, int flags,
 		dyn_size = sizeof(struct crat_header) +
 			num_nodes * (sizeof(struct crat_subtype_computeunit) +
 			sizeof(struct crat_subtype_memory) +
+			sizeof(struct crat_subtype_numa) +
 			(num_nodes - 1) * sizeof(struct crat_subtype_iolink));
 		pcrat_image = kvmalloc(dyn_size, GFP_KERNEL);
 		if (!pcrat_image)
-- 
2.54.0

