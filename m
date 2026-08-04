Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1204C5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5E010E985;
	Tue,  4 Aug 2026 09:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="CjjLXg0C";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D08A10E985
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:54:11 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748HwnH383467; Tue, 4 Aug 2026 09:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=CL2XAqeUIyJ5bnRa3
 4fzrMEZBAmlvg6hvYSzIsGIoUY=; b=CjjLXg0CgE1JuU6jHeaqORH9cotwVqGXW
 LzMmFbRCJBY0kQ21vlEYByGs7k9D1NCkE11FjuPwBpWL5pvoNZnMFVDhTSMWCGjM
 NPqAODlEXE2WUeNyjd6yqi2+JXPrPQWqugt4nbfza7mUtygySpxC2N69LsPVfZjD
 uvjfRmvJ6MiTI2H8gSIiSj9XmP8QaoJYpTrcY4LPQPFeaRayeqsHkM0tDQTpJE5E
 D8qNwLXGm16bGIuz88uLrNjkqVnz+L2/3cEECHzL3+ibZXk2JpgQDqf/1PwBIMjl
 LyhWVHNdQLVxwbBmayuvy8HKYqM9XGfXJyNKBIAGAVASwkY9s8lWA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eumt1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:54:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749fKXG017577;
 Tue, 4 Aug 2026 09:54:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh9b5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:54:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749s3dj17629442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:54:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 845AF2004B;
 Tue,  4 Aug 2026 09:54:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7831E20043;
 Tue,  4 Aug 2026 09:53:55 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:53:54 +0000 (GMT)
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
Subject: [PATCH 6/7] drm/amdgpu: Create proximity domains and VCRAT entries
 for CPU-less and memory-less NUMA nodes
Date: Tue,  4 Aug 2026 15:22:35 +0530
Message-ID: <0b31dfae2fb95800d6b58683a4f1ea03a5545653.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
References: <cover.1785833981.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kpGpy4nE1yWb5HgnkGEsNY54zUN4uPXq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfXy/gldWqaNvTe
 iOSxAMkj4QF6qlF/H1Fz3GnnQ7eZhVOyjEE2PtYsnN5qQe4PZnig7EBVVFaTogaTwoRNIWBMPUH
 s3UQfI31CMW0ZYJBpwPrHZuIT+GE5uY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX2MZYLw1ks/MF
 AkMM1nl4k29yk3/2JmD/xCYnktK8IiRb6aa9yjNxvm6D4es5ZfajPODap+k2+1sXSO0R8B9lUFf
 dla4s2RRk9k6mghi0mtQX+rAwpQmS83XUbqo1q6zJ71CqFRfHnBOgy2KhwnW2dKRMn5fPhSEb09
 2BQtyuwPDZmPp7TGIM4pP7lzvjeugqvGibUDr1B1XwmE5pflRqPRgUAfA05o7JwHhX1aYWLnQMY
 jtL7UEE6fXKOs9A36cAy1D189M1Ad3Drs0WBdFNWQ4l24zp4Ifg2LSMEtzu4g9MwjrAQcf0a38K
 FmGULeTlNhxL7UuvAG7u+VQhKgM+wN4JJ0oD89pvcKuOzBnPR0M91KASeLcVpCCFRftJBKBZb74
 cK0zOKL625TjxcWIlIqV5t7YJuaEjvCW0mzJjipmdW6AGBDDdNM8VqLgkT85R9CiAh9C7E7EodE
 GC0+glnURTgjfqq1tXg==
X-Proofpoint-GUID: 8o7wvPAeoQLPGIjt7q2K-__PTfA176mX
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a71b6c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vX1y51MUsMUlb4YkRUsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
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

The current implementation creates proximity domains and the associated
VCRAT entries only for NUMA nodes that contain CPUs. However, Linux
systems can have CPU-less, memory-less, or CPU-less and memory-less
NUMA nodes.

When proximity domains and VCRAT entries are not created for these
NUMA nodes, the generated VCRAT is incomplete and KFD topology
initialization fails while parsing it.

For example:

  available: 3 nodes (0,2-3)

  node 0 cpus: 0-39
  node 0 size: 519305 MB

  node 2 cpus:
  node 2 size: 519305 MB

  node 3 cpus:
  node 3 size:

With the current implementation, only node 0 is assigned a CPU
proximity domain (domain 0). A GPU attached to NUMA node 3 is assigned
GPU proximity domain 1, and its proximity_domain_to field references
the CPU proximity domain corresponding to node 3. Since no CPU
proximity domain exists for node 3, the referenced proximity domain is
missing, causing VCRAT parsing to fail.

Fix this by creating proximity domains and the corresponding VCRAT
entries for all online NUMA nodes, including CPU-less and memory-less
nodes. This ensures that every online NUMA node has a corresponding
proximity domain, allowing GPU affinity information to be resolved
correctly during VCRAT parsing.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 78 ++++++++++++++-------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index b38208965fc8..df698109c17a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1974,51 +1974,55 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
 
 	for_each_online_node(numa_node_id) {
-		if (kfd_numa_node_to_apic_id(numa_node_id) == -1)
-			continue;
-
-		/* Fill in Subtype: Compute Unit */
-		ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
-			crat_table->num_domains,
-			(struct crat_subtype_computeunit *)sub_type_hdr);
-		if (ret < 0)
-			return ret;
-		crat_table->length += sub_type_hdr->length;
-		crat_table->total_entries++;
+		int apic_id = kfd_numa_node_to_apic_id(numa_node_id);
+		int mem = node_state(numa_node_id, N_MEMORY);
+
+		if (apic_id != -1) {
+			/* Fill in Subtype: Compute Unit */
+			ret = kfd_fill_cu_for_cpu(numa_node_id, &avail_size,
+				crat_table->num_domains,
+				(struct crat_subtype_computeunit *)sub_type_hdr);
+			if (ret < 0)
+				return ret;
+			crat_table->length += sub_type_hdr->length;
+			crat_table->total_entries++;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr->length);
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+				sub_type_hdr->length);
 
-		/* Fill in Subtype: Memory */
-		ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
-			crat_table->num_domains,
-			(struct crat_subtype_memory *)sub_type_hdr);
-		if (ret < 0)
-			return ret;
-		crat_table->length += sub_type_hdr->length;
-		crat_table->total_entries++;
+			/* Fill in Subtype: IO Link */
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+			ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
+					&entries,
+					(struct crat_subtype_iolink *)sub_type_hdr);
+			if (ret < 0)
+				return ret;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-			sub_type_hdr->length);
+			if (entries) {
+				crat_table->length += (sub_type_hdr->length * entries);
+				crat_table->total_entries += entries;
 
-		/* Fill in Subtype: IO Link */
-#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
-		ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
-				&entries,
-				(struct crat_subtype_iolink *)sub_type_hdr);
-		if (ret < 0)
-			return ret;
+				sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+						sub_type_hdr->length * entries);
+			}
+#else
+			pr_info("IO link not available for non x86 platforms\n");
+#endif
+		}
 
-		if (entries) {
-			crat_table->length += (sub_type_hdr->length * entries);
-			crat_table->total_entries += entries;
+		if (mem) {
+			/* Fill in Subtype: Memory */
+			ret = kfd_fill_mem_info_for_cpu(numa_node_id, &avail_size,
+				crat_table->num_domains,
+				(struct crat_subtype_memory *)sub_type_hdr);
+			if (ret < 0)
+				return ret;
+			crat_table->length += sub_type_hdr->length;
+			crat_table->total_entries++;
 
 			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-					sub_type_hdr->length * entries);
+				sub_type_hdr->length);
 		}
-#else
-		pr_info("IO link not available for non x86 platforms\n");
-#endif
 
 		ret = kfd_fill_numa_info_for_cpu(&avail_size,
 				(struct crat_subtype_numa *)sub_type_hdr,
-- 
2.54.0

