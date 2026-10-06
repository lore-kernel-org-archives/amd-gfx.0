Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94481CA5FF1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4C610F59F;
	Wed,  7 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="Cghd85Mh";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C151710E031
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 12:51:56 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696Bb1Ql3618027; Tue, 6 Oct 2026 12:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uHcyHADL+PLeijU1b
 u14zBQKTn8qW2ZiHWAFMj2iDkQ=; b=Cghd85MhM0XWIz0VY6jjp/kAmk5kyMfng
 9Usz8uxHvQ+dB0uevmLFxrVZMPcS605vc+6uQbzfIeeTzLDQ+oEaBtCaTLPG/JBK
 G3g4+gSP8A1YUzbRGGRXBmcePLHv8mUjoy/tSD6jbrCDVIhguWcbonguRfulRb3A
 RPPPom8hsSkuWco8CGN/qXoEUKdG/P4WO9z9LmuqlZyGj0y9rCgtb+bhrk5+lNDO
 NZh6T9JImZ1O915Acd+INgsYGIHH9G2HR2qKOajdBw08DWQw6tbo1BlhFjnPkfd0
 dnefQ3jaRCAo4HsUI0EzTmCC0baySSlpwXUR9sr6SIUmt7nG7e+fA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv70vs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BWYPI269943; Tue, 6 Oct 2026 12:51:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgsuqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696Cpm1142729778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 12:51:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BA8D2004B;
 Tue,  6 Oct 2026 12:51:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A2A620040;
 Tue,  6 Oct 2026 12:51:45 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.4.213])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 12:51:44 +0000 (GMT)
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
Subject: [PATCH v2 3/3] drm/amdkfd: Restrict CU and memory entries to resource
 nodes
Date: Tue,  6 Oct 2026 18:21:24 +0530
Message-ID: <c1a0b1c06c7616c225bf1eb22fad4ca4d73eeddf.1791289746.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791289746.git.dhruv.b@linux.ibm.com>
References: <cover.1791289746.git.dhruv.b@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LiD9j2sIVbAiDVdvYqg2s25EMhyGAxqA
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac4eee9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CEoOl4_7Db87k78x3ngA:9
X-Proofpoint-GUID: 8_UHQSqbB9LnpJhwYg1XDZwT_-I7zGlL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfXwdTYmGssEV8m
 91mCHXvImEzqvzmw93cUEcjWx675XMDKjiBE4yK7By0TmxNuNCLe06ievyAseCVzaAbipNo69w1
 /PD0B53SPICLSnXPR7nFMppw3mrkW9X06xt59Y4KnlqRi88vtD+UKwQ3mjjouL4LmTksVF0Ctm7
 +4fGOjP6Cm4w0Fg527+6j33rj802+bQEXUj7l5zPef+UpmLTSjlJFVeWGjYSzjEwUyEDeBHg70F
 8oRgN+IKOkk9jOvMCy6lGeY7MzfvP/jWMSoRc+8JJabvhO4qnntZGgr/OuWrlndhWwDiP54CR4U
 3aCxT0AzwM3FZ1MpQEU4JnZQKX8vVH+Oi735axKQEdoRXzttc6P8G4gHsGiCS/Ki2QCjqQuewIY
 oe8tYNJr2FNTJMUMf2nJ3nOHvjX1Qukl4b1rzrKbLblZDI/PcCvw/FdSsZ3mhEVwP3uu0vwvpfn
 so7OqLzikxPi5t98A7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX8RK+ZAqgarc1
 GcGY8aYRlEosLio15iW+8rsxgoxsxbsqz3kOxt6FUdMHxoFPI+1OesmXXx+RLHkE0dTEFapeWeZ
 eGFJzKDzR+RH/nzyQkEtNkwuCoLchd8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060050
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
index 7dad8f30ff2a..329931b0edc6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1944,28 +1944,32 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 		}
 
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

