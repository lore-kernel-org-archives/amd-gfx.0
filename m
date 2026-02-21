Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6AFC61DBE
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 07:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C818A10E090;
	Sat, 21 Feb 2026 07:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="K4mmMl6t";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17CA10E090
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 07:09:46 +0000 (UTC)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61L1W0Wh1893929; Sat, 21 Feb 2026 07:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6tlSYwsLIJCldRTAZ
 V8rItxaUUAmIpLiVrOlilIDnYs=; b=K4mmMl6tm0zmEg82Neqsc1/KXWGQIoITe
 VC9IEek9Ry12wbaR+11o7/GG+roaGhDYy0DZuDlrqqDy6hY0G9zJILBJ7mDC4/7Z
 zuMp6BGjHCa2SO4x+hQ6XZYh3hjFtDgXAEcpJ++YPWbuYSP145Oa95NTJKcl6RPU
 pr4Kg1UIevUIFeZMyy4ft9OBCfDss3bf+jrwT9sK229jD89/cmzdEjn8cul7PEKk
 m5j5yqhUMqwfVrUS1p6nuzW3dknjCsRGlmoylneqOcSlbmPktS55W04slIds+SZF
 CgsrSf3kL7En1U97a6d/H6SvKVVierbHVv+cLTCUmHH0NXGSZMHag==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34brk6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L0Xpp2017761;
 Sat, 21 Feb 2026 07:09:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb28ubde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Feb 2026 07:09:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61L79dYj46661910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Feb 2026 07:09:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50FED20043;
 Sat, 21 Feb 2026 07:09:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EFA720040;
 Sat, 21 Feb 2026 07:09:37 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.162])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Feb 2026 07:09:37 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v3 2/6] drm/amdkfd: Align expected_queue_size to PAGE_SIZE
Date: Sat, 21 Feb 2026 12:39:20 +0530
Message-ID: <36c5c400b083bc859795a9a9cd94767588c12753.1771656655.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771656655.git.donettom@linux.ibm.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDA3MyBTYWx0ZWRfX0qSchXfS3xTq
 qxwVqrUf9wnvZbTK6GBnETSUmmEG1Wln6VmuiRhhPvf4rZmvNS2rKmLLITTB0S3meKKKsZTgdmy
 JNyetAcesrf4MMRjYjAiAS0q+rFCH+hixoH3aCrzMSGyRHDv/kSwookfKtGttIX+/LzDqTECd1u
 Yap+qmz0gvH7zKRcV7B1H0oH6aik+BU7ePfy5Xxy4G0BgXoCKATHhuydpHqHLp2+RS0Dn5hk1YB
 IuCxoVL/1m37EoOHUjkfW65Pd/0YCBsFk2Rg/7H51nUwZdOU/CghhDlKXtrbg+uRpGwJFeD1U4U
 QUYjCQhhLrfd3+M0ZFW2wBzSw5tWGirvyNaBQ/3mn9zmO0AUiFanvI0zKbzBs5l1KbLwToXnCnu
 c+2pkFW6/Zwk8ZmilXCfGqz0DEvrOYciPOZEuQvmgZp9bntYKTlCWWL/dif+tUs63/Ev17DNPCY
 z0BRCPKzNbx6yKVWK3g==
X-Proofpoint-ORIG-GUID: 8NVnfcVIRIRHFUE8rJj1Bf22SErd0LM1
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69995a38 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=qkJDUqGYG33CgAXL-3sA:9
X-Proofpoint-GUID: sLBEXTJ9I3rNNcayjZjdirXYWEx-6YBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602210073
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

The AQL queue size can be 4K, but the minimum buffer object (BO)
allocation size is PAGE_SIZE. On systems with a page size larger
than 4K, the expected queue size does not match the allocated BO
size, causing queue creation to fail.

Align the expected queue size to PAGE_SIZE so that it matches the
allocated BO size and allows queue creation to succeed.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index d1978e3f68be..572b21e39e83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -249,10 +249,10 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	    topo_dev->node_props.gfx_target_version < 90000)
 		/* metadata_queue_size not supported on GFX7/GFX8 */
 		expected_queue_size =
-			properties->queue_size / 2;
+			PAGE_ALIGN(properties->queue_size / 2);
 	else
 		expected_queue_size =
-			properties->queue_size + properties->metadata_queue_size;
+			PAGE_ALIGN(properties->queue_size + properties->metadata_queue_size);
 
 	vm = drm_priv_to_vm(pdd->drm_priv);
 	err = amdgpu_bo_reserve(vm->root.bo, false);
-- 
2.52.0

