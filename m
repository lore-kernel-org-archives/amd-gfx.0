Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B676CCA6007
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21C910F5A7;
	Wed,  7 Oct 2026 13:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="FN68/5WH";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A34B810E031
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 12:51:50 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BZr033680885; Tue, 6 Oct 2026 12:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CPpMGvDrpTWZ87YZB
 mTA/Kb7zd7kGaKslttXZ01I0mI=; b=FN68/5WH642Mw+MajMgssXdkjOOudy8Jx
 vVN90mkF8On/BpFX8d2rn+Mw1XQAa7PCVx5sOQ4uJa92g68pI/ba7JipQi/YuttW
 aZrSwEgL7UYatkVn7qORSOTBjeUJcr0OSnaJ5qbw2hMjb7vFhPd2mv2LcebZhHiM
 OcIm/33Q16QSiyDAWFsa5Z7Se2osV5WKmcHc/n9m8OzSc/8TobGNY3SQgwaic52W
 sY+Tdd7XOQBbwPsvTW/xa41kJqb0KyKCeB6imRd7EvFLYhLXVMayMLxjY63eaV9R
 upDNyHu8x21z+f0bZkZIiL3tsMLzGdjqQL9yzi8uq0ooTr/e1iikQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74r32g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BWgr5270322; Tue, 6 Oct 2026 12:51:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgsuqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 696CphVS16515374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 12:51:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2BE420040;
 Tue,  6 Oct 2026 12:51:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE8F020049;
 Tue,  6 Oct 2026 12:51:39 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.4.213])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 12:51:39 +0000 (GMT)
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
Subject: [PATCH v2 2/3] drm/amdkfd: Add support for discontiguous NUMA node
 topology
Date: Tue,  6 Oct 2026 18:21:23 +0530
Message-ID: <599c59ef1123656404f0b856aa0fe9c0233c50f6.1791289746.git.dhruv.b@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791289746.git.dhruv.b@linux.ibm.com>
References: <cover.1791289746.git.dhruv.b@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: geyPtOe8WPSnfJjciaSgULHwFPszOuaH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX422M2HU+lPu6
 YnDLhPnstx8Pv4rCxBLTdFbEvtG4UYVFV6lqzoB1hIrFZgf37RbltN00RnM0jxH+TvCjYfHc0sS
 sQ0Txadd0KPDACSK4gxqpFxYBvzAZtg=
X-Proofpoint-GUID: UADkywduIwidoISEUQVEFjts56E-fPBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MCBTYWx0ZWRfX94e/8tQ+Vbeh
 NqQNDRJSBvulqHmNuyKprhqv9rWHpLxJ9OdVqhsDUK0VVscQeYlgdyWR82fOPOYFJuJ3+M7lvMz
 vkoX9BRQWTDi1cb5o0XGMODcte6tyirFU9XJ6DYV7V6vRnBOSEF9bJj1rf87MerK66EG4Igl4rM
 R7EXX/wAqfQ+O4JBz3KCyBOLFe5OAoDn+wIVmuX9qlzN3UdiDgOi+aqgFNhfHeqHhIG+Y8asm/v
 Pzk9LXvfU5h/SCW7wQ0fCjNRQmquU/6s9zVcgBeO8MsWFDMWL+v8mUSJthSNv6LANHqa0OtQERi
 hzrL5VJ5DbuyRVt5pifpTxFW9o1xV6VT2XHt5sj3NqUb8MKM3jiamjeJ0d9AMontJ5X8xR32Gq4
 rFC2FMLpgKbPXPati0xDF1pOIv9CoO+UpS/U2+ynAOsbPOR0PMg29SFoH0JnHyyeKIhQPaCBajQ
 8G8JHRx/7v7R92/hfXA==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac4eee4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=nAu57eY-cG-sW7GSqM4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060050
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
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 99b0c7f825fe..7dad8f30ff2a 100644
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
@@ -1935,10 +1935,13 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
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
 		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
@@ -1982,7 +1985,6 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 #else
 		pr_info("IO link not available for non x86 platforms\n");
 #endif
-
 		crat_table->num_domains++;
 	}
 
-- 
2.54.0 (Apple Git-157)

