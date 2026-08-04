Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BD6C5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC1610E943;
	Tue,  4 Aug 2026 09:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="I00lYhW3";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C94F10E943
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:53:50 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748I70D324383; Tue, 4 Aug 2026 09:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SqTvie5KBL8xsEaPV
 ChS7VZ/OUVokJWTTKgai1rx34E=; b=I00lYhW3ByTrrWzcgdSIOB8toT2AyvyD0
 6PoOZGdoi0xauFp3FiGZ2kYACp30xPKID8Txs+GuQ0J/CYsIe66269RlbVSOpC7D
 9CKwI3n/Q1zuvoHiVY7B+0Ab/SjJdq8CegVvkqbWj7tY8Y+qMVv/WIJkipsbJ7ON
 RI3c3ehQ/DRTnHj2XqM/mcp7dFL/045a8/7I61lBo8brKO5vdB185tDoBmBGWvdw
 1v4D/J05k6eE2zg1G9/+QCRyjrv7KQqvSfKI5CnWikfb/YpYOfqSP7C672E6PVDY
 2gwYT/TUdm1p0l6knOUPAUJOKliZrUaXAQEhjv3OKfsjI25Q6LBAg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4w7v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749fFAK001046;
 Tue, 4 Aug 2026 09:53:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qhhy7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:53:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749rfTl34800116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:53:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D3362004B;
 Tue,  4 Aug 2026 09:53:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6574C20040;
 Tue,  4 Aug 2026 09:53:33 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:53:32 +0000 (GMT)
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
Subject: [PATCH 4/7] drm/amdgpu: Parse NUMA affinity entries from VCRAT
Date: Tue,  4 Aug 2026 15:22:33 +0530
Message-ID: <515a19459d4059cadde46e65137aa3ca3961d94c.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
References: <cover.1785833981.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX/9HNabS9h5mY
 o/DnFtme33qW1Rg1ErFzoVMIMsb4tB2lVGx6slq0wSD80qwg9RlfhR/MUGWhI2G5mcvm8gXf/r2
 Bl3tE1/HWA34MraN2gajI/GiJpeFKfw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX4AJhEUW4LEed
 owBc3QCoASork+755APxE9M+9aCCuUnvBPupAaRRZynjF+rp8a91KyKvXELFKZmBTyK1JvHpQYt
 ESW41rJRKFCXsEf/1mY2ckjkA+TtsKOo4tQQoPKtkEKIyxX58gFyT3u+Du2pX9wq29C7oyKmNIX
 2HTYwdKvfMHhNh9wLS5TXEDdbc9qJL19GKzwJh045Eqs+2ue0BJvv06JWtOsHy+zdgEtvcdztvE
 yPXCa0QxdYXU13AXOeJzqmixbJ19CBMMZZmZqBJgDKt+8kWtpLs7yyprHtazmucIZdtxbrrUevz
 KT7YYbGiRTvyAK0gK9MztD5R2jQaAhI1HRsjY3HrrQR88aooqfWj4iMox4r2uzTSC+mN/W3ZTZL
 KbWUnbCpGoh0p9dEefG96wvOApfwLiuEW1R/PGmBdQiZBVgsxnrWBGKkUWwbzKqkGHtSJXRDaFx
 NSs5qnFIOD25VO0l3rA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71b6ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=wAok5BmyS-ghERMTKL0A:9
X-Proofpoint-ORIG-GUID: eLR22Uu0ALOE3mBA6jV8WMiGs9jByzq9
X-Proofpoint-GUID: M2PzCFK4AO9mg5GQF4DXiymZv9EnSXch
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

Parse the NUMA affinity entries from the VCRAT and populate the
corresponding NUMA node information in the topology device.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 5613eb69423d..079bce6d904d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1299,6 +1299,23 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
 	return 0;
 }
 
+static int kfd_parse_subtype_numa(struct crat_subtype_numa *numa,
+				struct list_head *device_list)
+{
+	struct kfd_topology_device *dev;
+
+	pr_debug("Found NUMA entry in CRAT table with proximity_domain=%u numa node=%u\n",
+			numa->proximity_domain, numa->numa_node);
+	list_for_each_entry(dev, device_list, list) {
+		if (numa->proximity_domain == dev->proximity_domain) {
+			dev->numa_node = numa->numa_node;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /* kfd_parse_subtype - parse subtypes and attach it to correct topology device
  * present in the device_list
  *	@sub_type_hdr - subtype section of crat_image
@@ -1311,6 +1328,7 @@ static int kfd_parse_subtype(struct crat_subtype_generic *sub_type_hdr,
 	struct crat_subtype_memory *mem;
 	struct crat_subtype_cache *cache;
 	struct crat_subtype_iolink *iolink;
+	struct crat_subtype_numa *numa;
 	int ret = 0;
 
 	switch (sub_type_hdr->type) {
@@ -1342,6 +1360,10 @@ static int kfd_parse_subtype(struct crat_subtype_generic *sub_type_hdr,
 		iolink = (struct crat_subtype_iolink *)sub_type_hdr;
 		ret = kfd_parse_subtype_iolink(iolink, device_list);
 		break;
+	case CRAT_SUBTYPE_NUMA_AFFINITY:
+		numa = (struct crat_subtype_numa *)sub_type_hdr;
+		ret = kfd_parse_subtype_numa(numa, device_list);
+		break;
 	default:
 		pr_warn("Unknown subtype %d in CRAT\n",
 				sub_type_hdr->type);
@@ -1389,6 +1411,7 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 		if (!top_dev)
 			break;
 		top_dev->proximity_domain = proximity_domain++;
+		top_dev->numa_node = -1;
 	}
 
 	if (!top_dev) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index ad63ba67b577..f5e00f5df922 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -144,6 +144,7 @@ struct kfd_perf_properties {
 struct kfd_topology_device {
 	struct list_head		list;
 	uint32_t			gpu_id;
+	uint32_t			numa_node;
 	uint32_t			proximity_domain;
 	struct kfd_node_properties	node_props;
 	struct list_head		mem_props;
-- 
2.54.0

