Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361FDC9EC8D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3E510E3D5;
	Mon, 12 Jan 2026 14:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="o0Yv3/Lt";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B6110E3D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 14:07:18 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CDqHKD029996;
 Mon, 12 Jan 2026 14:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=8eJiD0/vk8YxNRuVNsBnVQI5Q1dk
 59Ip5Ssi6no/q7A=; b=o0Yv3/LtmXsUpkck4HhI92r18BBOJ3dZ4VBdNUykYOJ5
 7ruyu4f9FRSNJWnSQWuZvjaH5sCHiSOnE+OzNU2bOo55WFVHH4lZlJTc8Scq9w+1
 qYDwLGCl17HgtVfvPBP5GGH8IZIxnycWtIIjfNvXEgznNC1P2b0+0h2H+VldWb4/
 gsFp72XIIK+uROdnEDlQYR+BnPzmK91+/H77tyBRCipYo49OOBdnCV34bhGM/WVL
 4sv9nXof0tMljIR7iupwDVpUSbyN2c0wBJegoNRIK2NOX6oOQfNRTvQzI+fS3kac
 bInt9U5OZxoya7yngadhSTFHkLebLfXKdvxL7ztT1w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsq3f1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60CE38uq019779;
 Mon, 12 Jan 2026 14:07:15 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsq3dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CE36d7030131;
 Mon, 12 Jan 2026 14:07:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3aje459-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 14:07:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CE7AA058720610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 14:07:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD94A20043;
 Mon, 12 Jan 2026 14:07:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F5C120040;
 Mon, 12 Jan 2026 14:07:08 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 14:07:08 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [PATCH v2 0/3] drm/amdkfd: Add support for non-4K page size systems -
 part1
Date: Mon, 12 Jan 2026 19:36:53 +0530
Message-ID: <cover.1768223974.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDExMSBTYWx0ZWRfX5aY49bfbpLBQ
 IdlfCgDYaxMLzbdHjEruPvkTPPQef5SOk/r50A/cHpHpv8bHT5Cos8PFjM1D+3fvjPhh/numK3Y
 he7T11DoAG8mUZ/dc8ZBPuqqekN6fPWmaZhfSwyOmE1C5d0R8U0PUpImkQ1k43UUVbgcwdcoP0V
 ThsveX+3HOQ8hFT4YoafWIzMzi47NM4xIim5yD1XztXqUPFa2Vrp01TDMQOUDuRHMuJzwy9lpbS
 OW6tNwhzvO3O7aBXz9qDgeYR17Wf8TBmV5qSKXDGZmwkcFAeONVCqzrg2YJK3TztY/kDSWJSdq4
 XuLyqmaB/wxzLpYza5K9cqQMJSCGAPo4joDjGvju7l48f77Cu73i2jjw6yYBe0XxxtphpQLgeEd
 YIjhaFJHKbQSsMxACYeiAoDUkXHHyYRh00DQnnKPM5v6wbIhQU1w964JuDQKeTEVkUh24wIXst9
 liGm6lOHYPnIVr8PGTg==
X-Proofpoint-GUID: e0F307Rm6AL2mYkxBTPay7URi5r3N48e
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=69650014 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=SrLHQT4APn2CAhHg2bcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gPZsQwSM4yEaV0c-nhNYuOa-4jkezyol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
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

RFC -> v2
=========

In RFC patch v1 [1], there were 8 patches. From that series, patches 1–3 are
required to enable minimal support for 64K pages in AMDGPU. I have added those
3 pacthes in this series.

With these three patches applied, all RCCL tests and the rocr-debug-agent tests
pass on a ppc64le system with 64K page size on 2GPUs.  However, on systems with
more than 2 GPUs and with XNACK enabled, we require  additional Patches [4-8]
which were posted earlier as part of RFC [1]  Since that require a bit of additional
work and discussion. We will post v2 of them later as Part-2.

1. Patch 1 was updated to only relax the EOP buffer size check, based on Philip Yang’s comment.

2. Philip’s review comments on Patch 2 were addressed, and Reviewed-by tags were added to
   Patch 2 and Patch 3.

[1] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/

If this looks good, could we pull these changes into v6.20?

This patch series addresses few issues which we encountered while running rocr
debug agent and rccl unit tests with AMD GPU on Power10 (ppc64le), using 64k
system pagesize.

Note that we don't observe any of these issues while booting with 4k system
pagesize on Power. So with the 64K system pagesize what we observed so far is,
at few of the places, the conversion between gpu pfn to cpu pfn (or vice versa)
may not be done correctly (due to different page size of AMD GPU (4K)
v/s cpu pagesize (64K)) which causes issues like gpu page faults or gpu hang
while running these tests.

Changes so far in this series:
=============================
1. For now, during kfd queue creation, this patch lifts the restriction on EOP
   buffer size to be same buffer object mapping size.

2. Fix SVM range map/unmap operations to convert CPU page numbers to GPU page
   numbers before calling amdgpu_vm_update_range(), which expects 4K GPU pages.
   Without this the rocr-debug-agent tests and rccl unit  tests were failing.

3. Fix GART PTE allocation in migration code to account for multiple GPU pages
   per CPU page. The current code only allocates PTEs based on number of CPU
   pages, but GART may need one PTE per 4K GPU page.

Setup details:
============
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
  Name:                    gfx90a
  Marketing Name:          AMD Instinct MI210

Donet Tom (3):
  drm/amdkfd: Relax size checking during queue buffer get
  drm/amdkfd: Fix SVM map/unmap address conversion for non-4k page sizes
  drm/amdkfd: Fix GART PTE for non-4K pagesize in svm_migrate_gart_map()

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  6 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 29 +++++++++++++++++-------
 3 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.52.0

