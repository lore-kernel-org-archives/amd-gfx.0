Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA88CA5FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 07:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC4710F21F;
	Tue,  6 Oct 2026 07:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="hJOR32P5";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1FC10ED40
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 14:01:03 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CZQjr711304; Mon, 5 Oct 2026 14:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pcxZ97yVQBRhL4mev
 1ZkpPOfJXusTAX+xkIqTE+1vMo=; b=hJOR32P5qAJUKSgoIri1p/GaXK2rBXXHd
 7R+FdxDE4FCaW4zUCk6FekIgK8+FwpsdTY7ne7ghcdm0PrqSgLZbD53JwbyvUjhZ
 xqP/mlGpuO0fGwpYu0XI881cvvYCVt8hDzeLWTVCTWU8dTa8uW84UqRqZaBQlLjH
 xlwNtDI8twFAqhIrz4WAfbqBjGfxjwG9ruKT7Awt0R3WLcJ7LzlrM9fftg8FNPdp
 +1Gx3nWVGMJ1d2TPAzzHG1ku4JA29F+GrtAB4iJc2iYo6ivgrjRG1FWvUaRkfJST
 DKx4mu5Sa6c9yAH64kvSn1enfUO+HB8f3pr/Bf7D3KyEvygc3N7PQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74jp18-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CHoGf2900851; Mon, 5 Oct 2026 14:00:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pnwes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695E0qkg40239500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 14:00:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D533720040;
 Mon,  5 Oct 2026 14:00:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CE2B2004B;
 Mon,  5 Oct 2026 14:00:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.115.22])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 14:00:49 +0000 (GMT)
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
Subject: [PATCH 3/3] drm/amdkfd: Restrict CU and memory entries to resource
 nodes
Date: Mon,  5 Oct 2026 19:30:23 +0530
Message-ID: <82a530038f8eb9ea0cc95bb6bf93420fc74073bb.1791208447.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791208447.git.dhruv.b@linux.ibm.com>
References: <cover.1791208447.git.dhruv.b@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: P0Q8ieMwi7HNcKo9HL9Zrpr84KYMWPaU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX/bc7BSmHY4UU
 sghfe9p6Zsuq+7shvQMnA8hkTbW3U6nUuDGfL84VUqcpu7rGTVUsfPvb1TkjtSXmbnOqxlCyMUK
 B5z2GRUy2QQywXiQU1wVFX1uHjLzV8A=
X-Proofpoint-GUID: iWjB5q3vIahw_rslQksqYi0PUV858O41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfXxrXE0lQwTEyW
 P4S66DOU8X/lkcUB557ZgjBLXPmPIa2thLNu4MkMW//BK9NdvcQDd6UwL10Q6pWtmsDKfe6SA8e
 lVO7v0sHiurh1ta+I2eZlihNN01ndAqjDDnxy98gvVEDvhCN6c6vSId3WpBoJ3uOxD2xZMdW/mg
 c9POi8wcP1rAslOlayF79E+REF5yuQr/F1s+kx3FbeAgH3CRRUUeEuqOwQnpCihdeniXq9Tzh90
 2OSZotgX7H1lpmDgy5m7BaaEvIrNiEpzbpqQAwhkxAZSxJSL1KO3HP4Oal2imiai/6rDqvbQUW5
 yE8wK2McMdRx4JZiQZ1A+Rsx5Lvgm0NE/5wtHPVaH7y7nvet3AObXtMiBtqa8Em/lMndwnzykdM
 yAIZgYL8CWUDF3Oi0D4/Q64F+hix+HMYTIBB0WBiU98rFvVmWjxY3BxE5MZRJv2FTsHpBxKUVyq
 J/eTizXq6DJ1JdBsHGg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac3ad99 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=CEoOl4_7Db87k78x3ngA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
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

In heterogeneous or non-uniform NUMA systems, a NUMA node may be
CPU-less, memory-less, or both CPU-less and memory-less.

Previously, kfd_create_vcrat_image_cpu() assumed that every online NUMA
node contained both compute units and memory, attempting to create both
CU and memory CRAT entries unconditionally for every online node.

Add explicit guards to:
1. Only create Compute Unit CRAT entries if the NUMA node has valid
   CPU cores (kfd_numa_node_to_apic_id() != -1).
2. Only create Memory CRAT entries if the NUMA node actually contains
   memory (node_state(numa_node_id, N_MEMORY)).

This avoids emitting invalid or empty CRAT subtype entries for CPU-less,
memory-less, or both CPU-less and memory-less NUMA nodes in virtual CRAT
generation.

Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 40 +++++++++++++++------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index d4739db1c14c..489ddf68b751 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1944,28 +1944,32 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 			continue;
 
 		/* Fill in Subtype: Compute Unit */
-		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
-			crat_table->num_domains,
-			(struct crat_subtype_computeunit *)sub_type_hdr);
-		if (ret < 0)
-			return ret;
-		crat_table->length += sub_type_hdr->length;
-		crat_table->total_entries++;
+		if (kfd_numa_node_to_apic_id(numa_node_id) != -1) {
+			ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
+						  crat_table->num_domains,
+						  (struct crat_subtype_computeunit *)sub_type_hdr);
+			if (ret < 0)
+				return ret;
+			crat_table->length += sub_type_hdr->length;
+			crat_table->total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr->length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr->length);
+		}
 
 		/* Fill in Subtype: Memory */
-		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
-			crat_table->num_domains,
-			(struct crat_subtype_memory *)sub_type_hdr);
-		if (ret < 0)
-			return ret;
-		crat_table->length += sub_type_hdr->length;
-		crat_table->total_entries++;
+		if (node_state(numa_node_id, N_MEMORY)) {
+			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
+							crat_table->num_domains,
+							(struct crat_subtype_memory *)sub_type_hdr);
+			if (ret < 0)
+				return ret;
+			crat_table->length += sub_type_hdr->length;
+			crat_table->total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr->length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr->length);
+		}
 
 		/* Fill in Subtype: IO Link */
 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
-- 
2.54.0 (Apple Git-157)

