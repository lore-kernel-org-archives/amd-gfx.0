Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46998C55172
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 09:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB1B10E988;
	Tue,  4 Aug 2026 09:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="fMjragWm";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA04B10E988
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 09:54:22 +0000 (UTC)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748HTEL323353; Tue, 4 Aug 2026 09:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jRUOwKFn/nUxdKwgw
 AaHwv0IpuvTRhdPe8nOoe4b9zA=; b=fMjragWmHad9MV1YdgXk2z9Tjz1HPIssR
 +mS+TMoalARZ92+ACjh1wStyxvOMeO2Zoe9YF28brflDDbFNFrwRH2UQVVx8S7tO
 AS6yZLPZRhRppRINzKVl+mDuu3E+Q15Ye66fzcK1GpvSFbMakX2A11aX1lDbFHtP
 TV7Veq31XwhU/36i1Uh0IlqGMTLwmuYe5bnmf/rJZye4eSTyvLzrM/X6xni7ri7P
 zKaHW1TcsKkGtiqSKwfBWhMv1664TMY/NzN56wKQlAh2fIcRxMIP8mfpWxk73WH9
 eLSfklRhvK3t5t+yzKRvLg1qhSQNkf8Q0rgt/Ho/WdNVNafe97O5w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4w7wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:54:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6749fPle013329;
 Tue, 4 Aug 2026 09:54:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw1gbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 09:54:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6749sE9K41550180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 09:54:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9485A20040;
 Tue,  4 Aug 2026 09:54:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D57B2004D;
 Tue,  4 Aug 2026 09:54:06 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown
 [9.39.27.148]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 09:54:05 +0000 (GMT)
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
Subject: [PATCH 7/7] drm/amdgpu: Add numa_node in cpu/gpu topology device
 sysfs entry
Date: Tue,  4 Aug 2026 15:22:36 +0530
Message-ID: <ae22ce48e0067ce29b7b3ffa49b91c9b68cd759f.1785833981.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785833981.git.donettom@linux.ibm.com>
References: <cover.1785833981.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfXxhRdf3MUDCsS
 RNKS2xAaac/vnTWmgM7Hq8ayjbHO34dBt64GOJu1DuNHKdhgRiiTljnbPdfq5jRxOGqA76dEC6o
 hUshmjDftw78A5VKGsmpSMuCxwoxu9c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA3NyBTYWx0ZWRfX21Zm2cnLv5nr
 lqofmED2KvQHHrY0u9YR2hj1MnFSbc3p89KtZzaA3mIYQq6Ym6c+1Se9FM98xUareGDuvJxv5Nk
 jEjO3+dR5P6sADRhukjSrx+eCmhKH42I/+CWEM7hdS2okpOanqK44zGdl9tVkgh5J5Ojrsado0p
 qQIceQprgFOJBSLpdlTnV06wIPrQf5sMxAUz27+RrZzJLMdbxLg6obAHH9YmLEumQbpO1I6JTJT
 aZg67+a/9bTt33H4uLU29++g6pvpd/snBChWcR/wmMx+oggETZBUtBVSrb03On3ES0n5zdrhPla
 Bpsnxl4lb8Dd2B3xWD+iRZnpj0/B2uyk6X0vsUDiK2CaFuWpsqrZIgVT1CNsfIfV3IJzaOtxt1m
 //U0T3uaLkfQ5Lp0eSlLo0O/7GMzQ6lQMFXFE323pD++w43BtyxTHWYCA196pA/jVe3S+WYqZFo
 q5lHwhHYabfpTotM7DA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71b6cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=hYRG7ZBUrRAeTAvm9XIA:9
X-Proofpoint-ORIG-GUID: 00IFw4AZq-THsXAuWeV86WBjHukVPvnu
X-Proofpoint-GUID: fGl71fqhRlE7CKxhAGWFg-lm4nzNRIf0
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

Added a numa_node sysfs attribute for CPU and GPU topology devices.
This attribute exposed the NUMA node associated with the corresponding
topology device through the topology sysfs interface.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index d3269f0ffec3..51780bc8aabc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -418,6 +418,14 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		return sysfs_show_32bit_val(buffer, offs, dev->gpu_id);
 	}
 
+	if (strcmp(attr->name, "numa_node") == 0) {
+		dev = container_of(attr, struct kfd_topology_device,
+				attr_numa_node);
+		if (dev->gpu && kfd_devcgroup_check_permission(dev->gpu))
+			return -EPERM;
+		return sysfs_show_32bit_val(buffer, offs, dev->numa_node);
+	}
+
 	if (strcmp(attr->name, "name") == 0) {
 		dev = container_of(attr, struct kfd_topology_device,
 				attr_name);
@@ -630,6 +638,7 @@ static void kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)
 
 	if (dev->kobj_node) {
 		sysfs_remove_file(dev->kobj_node, &dev->attr_gpuid);
+		sysfs_remove_file(dev->kobj_node, &dev->attr_numa_node);
 		sysfs_remove_file(dev->kobj_node, &dev->attr_name);
 		sysfs_remove_file(dev->kobj_node, &dev->attr_props);
 		kobject_del(dev->kobj_node);
@@ -693,6 +702,9 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 	dev->attr_gpuid.name = "gpu_id";
 	dev->attr_gpuid.mode = KFD_SYSFS_FILE_MODE;
 	sysfs_attr_init(&dev->attr_gpuid);
+	dev->attr_numa_node.name = "numa_node";
+	dev->attr_numa_node.mode = KFD_SYSFS_FILE_MODE;
+	sysfs_attr_init(&dev->attr_numa_node);
 	dev->attr_name.name = "name";
 	dev->attr_name.mode = KFD_SYSFS_FILE_MODE;
 	sysfs_attr_init(&dev->attr_name);
@@ -700,6 +712,9 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
 	dev->attr_props.mode = KFD_SYSFS_FILE_MODE;
 	sysfs_attr_init(&dev->attr_props);
 	ret = sysfs_create_file(dev->kobj_node, &dev->attr_gpuid);
+	if (ret < 0)
+		return ret;
+	ret = sysfs_create_file(dev->kobj_node, &dev->attr_numa_node);
 	if (ret < 0)
 		return ret;
 	ret = sysfs_create_file(dev->kobj_node, &dev->attr_name);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index 312802754096..90777af8e665 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -160,6 +160,7 @@ struct kfd_topology_device {
 	struct kobject			*kobj_p2plink;
 	struct kobject			*kobj_perf;
 	struct attribute		attr_gpuid;
+	struct attribute		attr_numa_node;
 	struct attribute		attr_name;
 	struct attribute		attr_props;
 	union {
-- 
2.54.0

