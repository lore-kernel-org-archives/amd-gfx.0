Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5D6CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 07:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8297F10F21D;
	Tue,  6 Oct 2026 07:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="lR65LCFK";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A3810ED16
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 14:00:57 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CZdh3632496; Mon, 5 Oct 2026 14:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=q+MIkM9dy5ckzKOei
 kniWWdPVTZyP9W0hxeV9E9Mph4=; b=lR65LCFK3FlnaDDclk5Anpw/v4mZffg09
 HNpViy+I/E8wpIVcYyrzlFz3FblLL2GPPtqMamjMyFNyaRH4VVb+vwDFlBDpklfi
 eFweka8qI3kbXL34qs0LhGMzS59mc7aCG7YOpV8jk/hRM+D2DLrQzyXcv+h0uUQ1
 CXrY1PG3L4fgQ0GhSggnWRFyxLPbwj6lmUbKpoR/qvFtAjQZ7Chnp7lAp6dG2Ol9
 sNXwoR+kAvUHwnWpRrF8HPSxJPYyJdt/QqAtlnC6vmWEB3BSCerFx0BPhtOuMD+/
 hBVqMiDlLRjWLhys3GuqwOt8sm1tsCAoTzvf/GMugfz3rOqKZF4Mg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5aka3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695CHr9p1637701; Mon, 5 Oct 2026 14:00:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g5j3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 14:00:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695E0lRF52888026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 14:00:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18F972004B;
 Mon,  5 Oct 2026 14:00:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 332E320040;
 Mon,  5 Oct 2026 14:00:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.115.22])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 14:00:43 +0000 (GMT)
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
Subject: [PATCH 2/3] drm/amdkfd: Add support for discontiguous NUMA node
 topology
Date: Mon,  5 Oct 2026 19:30:22 +0530
Message-ID: <b167aff82d52fde5bf1568ac886bc80b042a10a1.1791208447.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791208447.git.dhruv.b@linux.ibm.com>
References: <cover.1791208447.git.dhruv.b@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX5n4UtNxXMPjt
 iUQ+x59wJEziMIk9gZ62O0ao/mubt3nEcuwmMDD4BcfAcfNETd81knY3slmZb1Q/5BoYueGGth1
 hYqiNDstc2aphe/OWi39CP933OLJp3Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MyBTYWx0ZWRfX9/HzqVSStxt1
 Hy1NjyrHmKq7Q1heuu6zlTeifdU0aMIYzASrHosds4vA39xT1uHOHWPYFsY0H8aLEne+5EA47Wb
 lMGtU/OD+HBY9GVAufFQQp1QMvExyhpJmsTv55GtaEc6qnnYelMVBmnpejBUafc6Rioe326KfDa
 UiqRkZdKcw5WCeJBgbZ8Mm7o2zMFTPUY3n/QgWvRgjmQMBUtJgrRotLro1RlnUI/6FBFv2JoUBb
 rmQRMxFYAM5TBs5twVhPtKgMn+Re8Cmpz4Y21Coe3HnVb/yMnAlkloQSz30szLmeJ0zz2Z5B9hC
 cJxdKnSsnvsrTiht2sRoLJ/QezuYRxLw6C9MlpFg/NIEwx+j3HIt2InxvL2WuZron7HL62FYGU/
 K/GgYinIbJm0m/tLYDoOZixodZtJh6be7q8bS9dCJh4e6/6VjGfb9C2qKZacHjDeE0FyG2E3Irz
 UA0k94ue92Qqu/a+/IA==
X-Proofpoint-GUID: e5icjtGQCTRvEo3AHcz6Ds92DTA38BCH
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac3ad94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jwdwDK1sR99dI3WYk7cA:9
X-Proofpoint-ORIG-GUID: aMqznmLJWdq0HjfPH34uuZG6tl0CNBRe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
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

On systems with discontiguous NUMA nodes, the GPU driver fails to load
with the following errors:

[    5.609767] amdgpu 0038:12:00.0: Error parsing VCRAT
[    5.609781] kfd kfd: Error adding device to topology
[    5.609848] kfd kfd: Error initializing KFD node

In the current KFD code, proximity domains are created contiguously
when generating the VCRAT. With discontiguous NUMA node IDs, this
creates a mismatch between the proximity domain ID and the NUMA node ID.
For example, if NUMA nodes 0, 2 and 3 are online, the current code
assigns proximity domains 0, 1 and 2 to these nodes respectively,
instead of domains 0, 2 and 3.

The KFD topology uses the NUMA node and proximity domain information to
create topology devices representing the CPU and memory resources
associated with each NUMA node. This topology is exposed to userspace
through sysfs, where the NUMA node and proximity domain information are
used to identify the topology devices. The mismatch between the NUMA
node ID and proximity domain therefore results in an inconsistent KFD
topology and causes topology parsing to fail.

Make the proximity domain ID correspond directly to the NUMA node ID by
iterating through the complete NUMA node ID range up to the last online
node. Account for every node ID when assigning proximity domains, while
skipping resource entry creation for offline or unpopulated nodes.
This preserves the NUMA-node-to-proximity-domain mapping and allows the
KFD topology and its sysfs representation to correctly reflect
discontiguous NUMA topologies.

Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 99b0c7f825fe..d4739db1c14c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1899,7 +1899,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	acpi_status status;
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size = *size;
-	int numa_node_id;
+	int numa_node_id, last_node;
 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	uint32_t entries = 0;
 #endif
@@ -1935,9 +1935,12 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	crat_table->num_domains = 0;
 
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
+	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
 
-	for_each_online_node(numa_node_id) {
-		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
+	for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
+		crat_table->num_domains++;
+
+		if (!node_online(numa_node_id))
 			continue;
 
 		/* Fill in Subtype: Compute Unit */
@@ -1982,8 +1985,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 #else
 		pr_info("IO link not available for non x86 platforms\n");
 #endif
-
-		crat_table->num_domains++;
 	}
 
 	/* TODO: Add cache Subtype for CPU.
-- 
2.54.0 (Apple Git-157)

