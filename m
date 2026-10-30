Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5589606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ihrzxSAx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9D41126B7;
	Fri, 30 Oct 2026 09:13:44 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFF710E85B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 08:33:31 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8EwqP1226931; Fri, 30 Oct 2026 08:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KljO4rVXtwRhRisRB
 nY3CMGzCjmCMoFUg6pPXWPgu9I=; b=ihrzxSAxxkSPrRHAFy3JqaFiAo3nhWs/K
 cR9UWl+x2/pGUE/C7KPUnyb9NEsfHAdgyslndptZ72QHNSXttmJkfjNrmVd07xAF
 vWVocfl6Fr10Faql+YclFep7z5LBweAdp432oFtWkLc5XibASJ1AroemPOPTPiqw
 I3MV3b21UAIY3YCfdt2YTISMnzN4BlPIaaTUB9tDsJIos7AP93eGQLAukNTy+I/S
 v9cHHnuWI0pJw9XJOGf4D7nIHkhdeAVUeGqJQcld8RDw1HYA9btOGc8F6cyMRx/n
 s8yZP9p2MwDRdHlSvbFotQXKw+kwARMR/ELeP7+T7azE5o+5Bcr8A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeayssdq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 08:33:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8K2MY298035; Fri, 30 Oct 2026 08:33:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm6pbbpqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 08:33:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69U8XNTS50070004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 08:33:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 587502004B;
 Fri, 30 Oct 2026 08:33:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDDA420049;
 Fri, 30 Oct 2026 08:33:19 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.4])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2026 08:33:19 +0000 (GMT)
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
Subject: [PATCH v3 2/2] drm/amdkfd: Add support for discontiguous and CPU-less
 NUMA topologies
Date: Fri, 30 Oct 2026 14:03:04 +0530
Message-ID: <20261030083304.9767-3-dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030083304.9767-1-dhruv.b@linux.ibm.com>
References: <20261030083304.9767-1-dhruv.b@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: idc-LxWL7ZfldgJ7DjPs6P2obliQczCC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfX2+bVFV3gL+IV
 qJoMpeBlj+gGVyX/wHcXWaWzZPMRveJQLS34xmYyeahOKZ9IFEIL8j3o0NC/sg3J8eGnZikaZ/v
 DEqMBePlaZsFSfrlRSb+7+FOIoJWTqPtbINb7tV6psAwxAc7Wm5lreotuhN4WxHHPXWwv3Kq25o
 ynUzaUugVef+DRkh02aUPv1k9EokYSE6yIsH2zAF23+gLKkCyhRO6d2NOVhFT1Q2ulOJHlY+Hzu
 khAzQX7FpQluZWXFI+MM9dQRWxptVLKCnrnOPifZL1v5BcddjtI8bhTqujoqFWSv64toA28c2ZL
 tWFYtm7KKekSKl2jo5Lb43myY5l6tcw+1v+jS2lDW1XWij4rC83WHUJxqvdWjKQg22pLi8MfXsh
 vpNboWaSBJmAJl/7MbdnZjV928V+6Oi1PdnyGgDhVO66Pg6VIM4GdO/DJytUhKh3/2VAcTeHD8i
 KCNEF9I6c5OyVBE5GfA==
X-Authority-Analysis: v=2.4 cv=Ms3HeGae c=1 sm=1 tr=0 ts=6ae45658 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=mL0m6J0XWqhrkiyiqMIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzMiBTYWx0ZWRfX0rn55QEjRlv6
 9r8Ril/5fc7SdoycUgf1Xrgc2GSNnPmZaM6KXm64kWP5CXaeQBReDcGgCzmn7bcQ5DbIg0lHrE7
 jYT+5SSMceGw/wh7WX/48fDlj9MFXQ4=
X-Proofpoint-ORIG-GUID: RQQG79V9thcU90i390p_nJrdoe7mllZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300032
X-Mailman-Approved-At: Fri, 30 Oct 2026 09:13:37 +0000
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
so skip offline and CPU-less nodes when building the indirect GPU to CPU
links.

Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Dhruv B <dhruv.b@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 59 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  3 ++
 2 files changed, 36 insertions(+), 26 deletions(-)

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
index b38d12f3da84..d2fbe73e57ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1419,6 +1419,9 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 				    struct kfd_iolink_properties, list);
 
 	for (i = 0; i < num_cpu; i++) {
+		if (!node_online(i) || !node_state(i, N_CPU))
+			continue;
+
 		/* CPU <--> GPU */
 		if (gpu_link->node_to == i)
 			continue;
-- 
2.56.0

