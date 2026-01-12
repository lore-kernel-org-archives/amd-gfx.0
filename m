Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C76C9EC8D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CF210E3D8;
	Mon, 12 Jan 2026 14:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="Pc94+NxM";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B75E10E3D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 14:07:30 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7QRjT020512;
 Mon, 12 Jan 2026 14:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3waRdgdNTpssEUUcE
 hK0BFeDDSZlbLjz32CmP1wrkHs=; b=Pc94+NxMJ3uwkQCUy5W4cr11n9DL2V+p5
 1DbrYhByhnv2AXKIY20f2kBwNGhBqwMLfv5P6ctPCLXgNJ0v2wN8f+8I+aAbsQ0y
 fJPJbRgNyFilo4u9griMXkYpJM2ri4I4RK4ybDr95JDdB1EPvDMwezMqgACt5AFR
 z+tChkfY+/08cqo7M9NqD+dWvyODteiT/oGP+Q9mxGvcNrowwKEYwQhk5tsZV+CY
 4TgQ9yrCkCffDzHW1tK033lTIgSxW9Dt1t3rRdJeQRqfacVQG6tAqK7ig12q7Wu1
 visjOt0v4t1L1t0o92XcHwjcaOpva2H0EAxHQJJoF8vEvMcDW5a7Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepqbbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CE5DSa002592;
 Mon, 12 Jan 2026 14:07:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeepqbbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CDbEqE025799;
 Mon, 12 Jan 2026 14:07:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kk682h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CE7MLv20578736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 14:07:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A215C20040;
 Mon, 12 Jan 2026 14:07:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31F1420043;
 Mon, 12 Jan 2026 14:07:20 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 14:07:19 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [PATCH v2 1/3] drm/amdkfd: Relax size checking during queue buffer get
Date: Mon, 12 Jan 2026 19:36:54 +0530
Message-ID: <4a6123f2cdc7423d9048b6a2216e6375e7113d8b.1768223974.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768223974.git.donettom@linux.ibm.com>
References: <cover.1768223974.git.donettom@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=69650020 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=zd2uoN0lAAAA:8 a=VnNF1IyMAAAA:8
 a=xbgER6cwBhrV0Gp48C0A:9
X-Proofpoint-GUID: FlQbh9UnQChsbZpBn3K79lOyBuvzEEcy
X-Proofpoint-ORIG-GUID: o4h1_y7r5BPwamlNkXGVohA-Jn_r0Met
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDExMSBTYWx0ZWRfX7u2B/EQsYS0N
 3huXDnzOO7vsb/B5YDN5qHmwMhl6cFh50ePWCczYg3ErCbLdC3wSzu68YiEKOwPZhCTzzeq3LoW
 AbZwTecDXdHA/QBbPSrvmnye3Mdq1fTHnSPQh+Bqa28gTIeOYisZwYAMk+dEz7vzP2b7NXR8tLe
 zSbKoXh/2rQAYd0//3BF2ro7vYrUDaunprSUZCHr47KNc5zFwpUjdKORoOo6GTPnbliD17RD1PB
 rgAIewDdFnOaGxj7yM8pp0MONsw/G0kIX4tj87VRmVsnGaWjN3EsfLvYUdOb1wFIZI9P5Rnle0x
 T009tLx5B7r7TBRPv26kZEwlyPRlPeO1HB2eUVz3oi3JL8jSnuMBFOBLi/c5mtNoDtpa7RXiuzb
 H4/VrLI6mawtecXi+9v5/G4zO21nTVSMvyIHYp/Wjd3v1v3ulUFwol777WK5ehltiWfOiqbopsA
 TkF+1G7WpBEJ1N7GJYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120111
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

HW-supported EOP buffer sizes are 4K and 32K. On systems that do not
use 4K pages, the minimum buffer object (BO) allocation size is
PAGE_SIZE (for example, 64K). During queue buffer acquisition, the driver
currently checks the allocated BO size against the supported EOP buffer
size. Since the allocated BO is larger than the expected size, this check
fails, preventing queue creation.

Relax the strict size validation and allow PAGE_SIZE-sized BOs to be used.
Only the required 4K region of the buffer will be used as the EOP buffer
and avoids queue creation failures on non-4K page systems.

Suggested-by: Philip Yang <yangp@amd.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 80c4fa2b0975..2822c90bd7be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -275,8 +275,8 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	/* EOP buffer is not required for all ASICs */
 	if (properties->eop_ring_buffer_address) {
-		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
-			pr_debug("queue eop bo size 0x%x not equal to node eop buf size 0x%x\n",
+		if (properties->eop_ring_buffer_size < topo_dev->node_props.eop_buffer_size) {
+			pr_debug("queue eop bo size 0x%x is less than node eop buf size 0x%x\n",
 				properties->eop_ring_buffer_size,
 				topo_dev->node_props.eop_buffer_size);
 			err = -EINVAL;
@@ -284,7 +284,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		}
 		err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
 					   &properties->eop_buf_bo,
-					   properties->eop_ring_buffer_size);
+					   ALIGN(properties->eop_ring_buffer_size, PAGE_SIZE));
 		if (err)
 			goto out_err_unreserve;
 	}
-- 
2.52.0

