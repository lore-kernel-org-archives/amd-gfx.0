Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA574606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NjzAJov0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36C7112467;
	Thu,  5 Nov 2026 13:45:35 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE2E10E8DD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 19:07:51 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiPPe1186416; Wed, 4 Nov 2026 19:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=g9PwnE1BUhDKPeRDH
 zTPg+m34Bd8ISqTGHDwBKjbme4=; b=NjzAJov0MbhYhd6V6B8cfrRsfJsMYntLv
 mTKGMHc+r2xWl/F6uaOxJBjVlueIyGuEyJYp/fEDCCCdUovvsSs5SagnNCxt9pR6
 Q66XtPVqzPJ2VvhtiT9FTbAfyeOwjV5ctfqeViUILzjS2HTJa/EkuWaNXn1IYH7Y
 gQJFuqu39s5QXnwjJRv4k8ONppavvSsnDxe3LoasVFMJWeSfdJwOQKqt7j67IW6i
 AwG3UOfdb2+SwnX5vMZF28x8PwGgna9XOrbcljvRzVotri6/Q2tWfSIxj/lmy0PA
 jiL4js2PH12sU0JVmGnYPqEF4VNOsv8V9Hh8yzPtMJ7UV9xKZ8L8Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3nw7y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 19:07:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4IeAPh091569; Wed, 4 Nov 2026 19:07:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrcfufd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 19:07:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A4J7htg52429212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Nov 2026 19:07:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A53502004D;
 Wed,  4 Nov 2026 19:07:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F10A20049;
 Wed,  4 Nov 2026 19:07:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.118.53])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Nov 2026 19:07:40 +0000 (GMT)
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
 donettom@linux.ibm.com, dhruv.b@linux.ibm.com
Subject: [PATCH v4 2/2] drm/amdkfd: Add support for discontiguous and CPU-less
 NUMA topologies
Date: Thu,  5 Nov 2026 00:37:18 +0530
Message-ID: <20261104190718.68457-3-dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104190718.68457-1-dhruv.b@linux.ibm.com>
References: <20261104190718.68457-1-dhruv.b@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aeb8285 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jEZll7LtN5u0E8P7Dj0A:9
X-Proofpoint-ORIG-GUID: c4TPWZavSlail8PqYvnX_C4E9U6b2YVd
X-Proofpoint-GUID: lMrJKUqHaI6cHyquHE2wcv0oks-tYinD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfX80k3UIe+ZJCj
 bkhNRa++GVa3DtBF6PIx/il3KFaY2BkFC9EMU8AXdV5Qyq9bs7I7ZWHJ2Xe3syiEVJ9fPKih1XL
 Sv+cJar/bo3T4XIyCbDTRs4Gc9qOtf2P6GX7pOgz288XuyyCNQg52EBQTH7zCQq3nNem4BMfwdo
 +BE9oVpsu67y2fIfGYpgr/RWyVvukWW3/jcClQMNAVXppBkZu10YBqZPAdVsNfOi04ihvjpxyvF
 7YjhDuIulUlzyPkJ/zF/jScyY9o+5e968TxMu1DmtAMQd43e3EQxAg1d2rITpBiGzkyqwO6m6Ai
 YI9u46GKBESr4+ZV44dVGytZmVd0DvQ0zLY6JH/LgttelsKAU8U4ShdtZVHvkk6KEi5wUNX/sgU
 MdrYq9wrtJ4ukG87tHLJClNW16dkLTfk1IZec9hVZpk6Hqm+tfrQnk5jPGWpAwAdbPHlKP9oDfA
 Gm/wOYbi5/rbS4rlYQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3NCBTYWx0ZWRfXyF1mVa5xT2DR
 O4gGZIyttcdiJGUnrM5fBA8++hBGPtBBRK4BYhdS0wCEG1hZL7ZJmVb9jmdfIzEPkKxZYFKXxBe
 Zw8/YmqoCgTXDdahjD2dThPlzP22wr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040074
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

On systems with discontiguous NUMA node IDs, the GPU driver fails to
load with the following errors:

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
skipping resource entry creation for offline nodes. This preserves the
NUMA-node-to-proximity-domain mapping and allows the KFD topology and
its sysfs representation to correctly reflect discontiguous NUMA
topologies.

A NUMA node may also be CPU-less, memory-less, or both. Only create a
Compute Unit CRAT entry if the node has CPUs, and only create a Memory
CRAT entry if the node has memory.

Additionally, update kfd_parse_subtype_mem() to use simd_count instead
of cpu_cores_count to distinguish host nodes from GPU nodes. This ensures
that memory on CPU-less host NUMA nodes is correctly classified as
system memory (HSA_MEM_HEAP_TYPE_SYSTEM) rather than private GPU
framebuffer memory.

The placeholder domains created for offline node IDs have no IO links,
so skip offline nodes when building indirect GPU to CPU links. For Large
BAR, reverse CPU-to-GPU indirect links are only created if the node has
CPUs (node_state(i, N_CPU)). Additionally, missing CPU interconnect links
are skipped so they do not abort GPU-to-GPU P2P link creation.

Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  9 ++--
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 99b0c7f825fe..bebbc6715b2f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1103,8 +1103,10 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 			mem->proximity_domain);
 	list_for_each_entry(dev, device_list, list) {
 		if (mem->proximity_domain == dev->proximity_domain) {
-			/* We're on GPU node */
-			if (dev->node_props.cpu_cores_count == 0) {
+			if (dev->node_props.simd_count == 0) {
+				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
+			} else {
+				/* We're on GPU node */
 				/* APU */
 				if (mem->visibility_type == 0)
 					heap_type =
@@ -1112,8 +1114,7 @@ static int kfd_parse_subtype_mem(struct crat_subtype_memory *mem,
 				/* dGPU */
 				else
 					heap_type = mem->visibility_type;
-			} else
-				heap_type = HSA_MEM_HEAP_TYPE_SYSTEM;
+			}
 
 			if (mem->flags & CRAT_MEM_FLAGS_HOT_PLUGGABLE)
 				flags |= HSA_MEM_FLAGS_HOT_PLUGGABLE;
@@ -1899,7 +1900,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	acpi_status status;
 	struct crat_subtype_generic *sub_type_hdr;
 	int avail_size = *size;
-	int numa_node_id;
+	int numa_node_id, last_node;
 #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
 	uint32_t entries = 0;
 #endif
@@ -1935,34 +1936,41 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	crat_table->num_domains = 0;
 
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
+	last_node = find_last_bit(node_online_map.bits, MAX_NUMNODES);
 
-	for_each_online_node(numa_node_id) {
-		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
+	for (numa_node_id = 0; numa_node_id <= last_node; numa_node_id++) {
+		if (!node_online(numa_node_id)) {
+			crat_table->num_domains++;
 			continue;
+		}
 
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
@@ -1982,7 +1990,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 #else
 		pr_info("IO link not available for non x86 platforms\n");
 #endif
-
 		crat_table->num_domains++;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b38d12f3da84..8f908323d74b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 				    struct kfd_iolink_properties, list);
 
 	for (i = 0; i < num_cpu; i++) {
+		if (!node_online(i))
+			continue;
+
 		/* CPU <--> GPU */
 		if (gpu_link->node_to == i)
 			continue;
@@ -1437,7 +1440,7 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 		}
 
 		if (!cpu_link)
-			return -ENOMEM;
+			continue;
 
 		/* CPU <--> CPU <--> GPU, GPU node*/
 		props = kfd_alloc_struct(props);
@@ -1459,8 +1462,8 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 		if (ret < 0)
 			return ret;
 
-		/* for small Bar, no CPU --> GPU in-direct links */
-		if (kfd_dev_is_large_bar(kdev->gpu)) {
+		/* for small Bar or CPU-less NUMA nodes, no CPU --> GPU in-direct links */
+		if (kfd_dev_is_large_bar(kdev->gpu) && node_state(i, N_CPU)) {
 			/* CPU <--> CPU <--> GPU, CPU node*/
 			props2 = kfd_alloc_struct(props2);
 			if (!props2)
-- 
2.56.0

