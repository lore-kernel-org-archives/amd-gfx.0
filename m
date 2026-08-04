Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B67C55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F7910E986;
	Tue,  4 Aug 2026 09:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="ORu8827f";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F9710E985
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:54:01 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748HfuF236128; Tue, 4 Aug 2026 09:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JB/wAip+CJazapZJN
 7C25cv/YW40xDA10LiJtRh3A4U=; b=ORu8827f+zI5skgwKGTXBwoKeJ62DswYn
 t7d8ne9PkJALHLZBnlx1eizdm4c4qLP2My+1F7MnKRBivwG2KrH24PTEqpdK09pz
 lHMmZ9qD9wcLarak5rsaOYMJIagVRgrkrKzUbvb0g0Ea9KscyU261i/Hvga6gcVr
 s2jG0XeHlczutasMbHVrVNlT5m4nwLnusSpSZpC2pV6Eoi9nCkjm6yJ4y318jKtG
 8olraKme12lIY7nSLQOn2aR8cZFugUvPO5/54KLw4OYk7kn0QUhxtoXnlQOOnfP0
 UY9nLs1aoAXKoxUB2QkUkgMUsq0pgRdXm/fZTv9OC0LQOsocSdyqw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g4yn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749q0BH005646;
 Tue, 4 Aug 2026 09:53:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg96br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749rqRp51970530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:53:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C91920043;
 Tue,  4 Aug 2026 09:53:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06C862004B;
 Tue,  4 Aug 2026 09:53:44 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:53:43 +0000 (GMT)
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
Subject: [PATCH 5/7] drm/amdgpu: Fix VCRAT proximity domain mappings for GPU
 nodes
Date: Tue,  4 Aug 2026 15:22:34 +0530
Message-ID: <93378702b915679811543bf162e9424ee02382a7.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
References: <cover.1785833981.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfXxwlo5srMJ8ez
 b5hl2C2M4jDnnGZN5sbibAAZMaPhwNQ6d5tCDGndW0A8JTk1LUNKYWjHgBCItwdIENO87sZDlqz
 VR29s1ErmLM2PBmP7X6BCvX6ADvFkpvCLi26qCsqWP3UB33tF2T8qsEjy0dv7sRbGKYOUwROrm6
 0TpKiH1BgFHHEFsd+Cx/YM/yl9KZbu6CFMHWUgDTf+1xx97UEV67Dl3aAdO9rwZ69iaQnAA4UVM
 FHmJ6I5d3Uhv2GZCS9D34xJUAzEp+rHxl3pGARBPWLTlkDBf2t3JMadG0EPyR9F8bTIOtcU436U
 c2NuSLyiPL/qwgZtQt4VV5YVw55o/ReOSMivHNw/mC0FVL271tfC89128U9r/xpFGcY7MAQ6AP0
 hzvYOX9pm9olxbg/iDI/JOsiQFuKkf/2dStoLXvUaR3E4391pLlGpRu4saCoxTDozeLntGIWPv6
 3yLuAnM3XWUlBxgtMiQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71b6b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Gfo4HN3cvNHKjVn2SacA:9
X-Proofpoint-GUID: 74QgDOAHJRQq3B9_wIEMJTBu3w5VoLUM
X-Proofpoint-ORIG-GUID: fQSeJrCYb-rqq8pmOqsMsAv3GTHdhRmO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX+Vg0C5d1T4ra
 33tiYFLZc6zeoEv9j6uziu9VIUJFsTW3unnpCO0t7mgdDp9sj78KdXSHVbEtY5UJLj56OHYsoEd
 fDE+sRa8mEUeK/iIQ3LL7vSBQhItgf8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
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

The VCRAT CPU builder, kfd_create_vcrat_image_cpu(), assigns proximity
domains sequentially while iterating over for_each_online_node(). As a
result, the first online node is assigned proximity domain 0, the second
online node is assigned proximity domain 1, and so on.

The GPU VCRAT builder creates GPU proximity domains after the CPU
proximity domains and programs the GPU-to-CPU affinity
(proximity_domain_to) using the NUMA node ID of the node to which the
GPU is attached. This is only correct when NUMA node IDs are contiguous,
because the CPU proximity domains happen to match the NUMA node IDs.

On systems with discontiguous NUMA node IDs, the CPU proximity domains no
longer correspond to the NUMA node IDs. For example:

available: 3 nodes (0,2,4)

Node IDs:           0    2    4
CPU proximity:      0    1    2
GPU proximity:                3

In this example, a GPU attached to NUMA node 4 is assigned GPU proximity
domain 3. However, its proximity_domain_to field is programmed with the
NUMA node ID (4) instead of the corresponding CPU proximity domain (2).

During VCRAT parsing, no CPU proximity domain with value 4 exists, so the
GPU affinity cannot be resolved and topology initialization fails:

amdgpu: Virtual CRAT table created for GPU
amdgpu: Error parsing VCRAT
kfd: amdgpu: Error adding device to topology
kfd: amdgpu: Error initializing KFD node

Fix this by translating the GPU's NUMA node ID to the corresponding CPU
proximity domain assigned during GPU VCRAT creation before programming
proximity_domain_to. This ensures that GPU affinity entries always
reference a valid CPU proximity domain, allowing VCRAT parsing and KFD
topology initialization to succeed on systems with discontiguous NUMA node
IDs.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 10 +++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  2 ++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 079bce6d904d..b38208965fc8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1267,6 +1267,7 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 					iolink->recommended_transfer_size;
 
 			dev->node_props.io_links_count++;
+			dev->numa_node = kfd_proximity_domain_to_numa_node(id_to);
 			list_add_tail(&props->list, &dev->io_link_props);
 			break;
 		}
@@ -1888,8 +1889,10 @@ static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
 		sub_type_hdr->flags = CRAT_SUBTYPE_FLAGS_ENABLED;
 
 		/* Fill in IO link data */
-		sub_type_hdr->proximity_domain_from = numa_node_id;
-		sub_type_hdr->proximity_domain_to = nid;
+		sub_type_hdr->proximity_domain_from =
+			kfd_numa_node_to_proximity_domain(numa_node_id);
+		sub_type_hdr->proximity_domain_to =
+			kfd_numa_node_to_proximity_domain(nid);
 		sub_type_hdr->io_interface_type = link_type;
 
 		(*num_entries)++;
@@ -2237,7 +2240,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 	if (kdev->adev->pdev->dev.numa_node == NUMA_NO_NODE)
 		sub_type_hdr->proximity_domain_to = 0;
 	else
-		sub_type_hdr->proximity_domain_to = kdev->adev->pdev->dev.numa_node;
+		sub_type_hdr->proximity_domain_to =
+		    kfd_numa_node_to_proximity_domain(kdev->adev->pdev->dev.numa_node);
 #else
 	sub_type_hdr->proximity_domain_to = 0;
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f4b7cb44daff..d3269f0ffec3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2463,3 +2463,25 @@ void kfd_update_svm_support_properties(struct amdgpu_device *adev)
 	}
 	up_write(&topology_lock);
 }
+
+int kfd_proximity_domain_to_numa_node(uint32_t proximity_domain)
+{
+	struct kfd_topology_device *dev;
+
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev->proximity_domain == proximity_domain)
+			return dev->numa_node;
+	}
+	return -1;
+}
+
+int kfd_numa_node_to_proximity_domain(int target_node)
+{
+	struct kfd_topology_device *dev;
+
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev->numa_node == target_node)
+			return dev->proximity_domain;
+	}
+	return -1;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index f5e00f5df922..312802754096 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -201,6 +201,8 @@ struct dmi_mem_device {
 struct kfd_topology_device *kfd_create_topology_device(
 		struct list_head *device_list);
 void kfd_release_topology_device_list(struct list_head *device_list);
+int kfd_numa_node_to_proximity_domain(int target_node);
+int kfd_proximity_domain_to_numa_node(uint32_t proximity_domain);
 
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void kfd_update_svm_support_properties(struct amdgpu_device *adev);
-- 
2.54.0

