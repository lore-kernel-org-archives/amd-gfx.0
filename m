Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A441D58CC5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 04:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2C810E2DF;
	Mon, 23 Mar 2026 04:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="FWc2VjGm";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C59710E2DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 04:28:59 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MJvLtW556595; Mon, 23 Mar 2026 04:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6tlSYwsLIJCldRTAZ
 V8rItxaUUAmIpLiVrOlilIDnYs=; b=FWc2VjGmt25IhlYMkD9w8QNoCn9foohK4
 PrBlfhvmi49nZw3L7uHOvCeFBtPJ3tENhRT4fHQBV4frpGM0bnVUZFEp9PPu9d3w
 o5RaFf784JUX61nhBs2kQFwVYhoKNdpMCbpIQyKwhLm1Wm8t2YzVF1TqvSTCfZco
 9bgUds1qooC9DGNjFFBU6izfuqGyGGG21EK9HL44d4HrwhxK1bqDFDSCw1zjrWJ4
 iFtliGm4y+Hi72wjC0XTfc4e+zweRs739LtdTpkdUYsqRCKF9MmFauxJs+6iwImi
 SIjaiqDJ+8/EEDDirTtmyHsuWWQGHCA7nnbnC6DSA3GHX453gGXcA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq5c7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:28:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N356ji004398;
 Mon, 23 Mar 2026 04:28:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1uq02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 04:28:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62N4SqdP52756984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 04:28:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 135C52004D;
 Mon, 23 Mar 2026 04:28:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AC0320049;
 Mon, 23 Mar 2026 04:28:49 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.bl1-in.ibm.com (unknown
 [9.123.6.34]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 04:28:49 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RESEND RFC PATCH v3 2/6] drm/amdkfd: Align expected_queue_size to
 PAGE_SIZE
Date: Mon, 23 Mar 2026 09:58:35 +0530
Message-ID: <1afca38f9d8b7d8ce16694f37edd006c15c9bd2c.1774239489.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1774239489.git.donettom@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IRebVLKp7L-4xGOTryYGTKMFoFyJlMtM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAzMCBTYWx0ZWRfX0rQKbjZpFBwQ
 6LEjDGxtsso9iiK8gFBeAgM+TzufS+AI94YAfulA4gCS5hsvftEywaRXXVQl+KhDV4sKvJwfV8r
 ikioyrTPtae5Wa0d7D4BxIv8+KClAyYQKO5/CHswh8aKP+sI0uI+8UZetx8oZecEkAoUk0Fxk8b
 dm+9rdp0xxKNWaMm6g/xPh4+gGGL8WRLgUDxvq6oKZBzgYlOxrvXGAYzvkVb0iSxBDcXwpSx1BA
 87L3raB5O43Cv57UpE6lOypAIdIRqD4sx0AP+77M40lO3Hn0g/owCUHZ2m/F2sxETBiariTLEMB
 aydDj8njg/v9PChQfQ05rxtP5Ehr1Nr9x65R6KMYNiWYMsL6ruID2KtdRQxxHoTWbY16h1Mi9sd
 pz+S0KwxBti7wBJSJDIaWZhdzL8nUAZTREatO66rgfvOhbqjpi8BkFTbi2OqTP8Dc/MaIMhnS5I
 wvoQHybUuou6ERFzRqA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c0c189 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=qkJDUqGYG33CgAXL-3sA:9
X-Proofpoint-GUID: 9nqWJzwhLateKqC7eo9Pid5Dd0zz21T1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230030
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

