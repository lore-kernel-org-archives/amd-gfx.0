Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA6FD44148
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C783D10E585;
	Fri, 12 Dec 2025 08:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="jDcn+UAq";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B91110E04B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 06:40:29 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC4XCSh025574;
 Fri, 12 Dec 2025 06:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=FSklSfdS0Jxgy1x98ElX0RWWCyGV
 N4zTOb07u3IDm5Q=; b=jDcn+UAqzL07pIFY9ruPmAx8+YAXXdD+S7qrWkq8rWDw
 88vpnQ14Lr2WLMYpjHVndFHjysCbVOA9jYmS01npkqDIaqwQR/DH8NXh2LyVmz5I
 OquVx4NoGuK/r1dTjAMCm/0ywlHeTfm+TScmzgKgaLwnPwryB09vVEdcclJhJ83b
 92vB9pe5VdrjQTx69CT62MwU3bnKbPg7GQSi3G/a9KXzxyKev8pKu6HVUU5s13oG
 WuGGiOlwFNlSlMhf5zObdXwUZgsLBUKdey0MoV89pFFqQrDO+As72k7umwkxP1sl
 /b0WO6zS0rfNcxJrfHvO8O8EZd+fQKcJmWfL18Cdyg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53u1xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BC6WjPT002611;
 Fri, 12 Dec 2025 06:40:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53u1xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BC3OlNx026872;
 Fri, 12 Dec 2025 06:40:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h1j826-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 06:40:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BC6eLtc46727464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 06:40:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95AF72004D;
 Fri, 12 Dec 2025 06:40:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64ECD20040;
 Fri, 12 Dec 2025 06:40:19 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown
 [9.109.215.183])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 06:40:18 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>, donettom@linux.ibm.com
Subject: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page size
 systems
Date: Fri, 12 Dec 2025 12:10:07 +0530
Message-ID: <cover.1765519875.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX3OrMfDIba25Q
 G/NpevwhARG5Pzw/KzDRr+9xsopvv1oa21KjkqRqkSl2zp2idBRQHxF7FnguXnhzgIdEVSfwYtx
 hY5leAtyYusRsmPNmKwZxf3RLe7kEXhXL80sLpk4hHVH4GSEOKvX8IondcTxqsXdgovMyvz1qT2
 YZ5FLxarRtaDxPkT6kcXQ0LH3lPnWgFRHJDv9XiuQoH6Orpm1lOLFYBzQf+kfNjpSYoqOsDB1TH
 uVunAwdsg6rNLNkPs4vyjHajLkMznj1C9ZYXZGcEtOSZ9WPN0EkaAOitnsHATtdZx6ApNp7Yse5
 XjkIH2IXC4KDgTvpgjQpiI9MqAnS9kpvYMIgTrfJid7Ejlj2+dts4aWU6EVvBuKp547PR1xvz5x
 336BLr6Na+7rM6w9Jj8/x5zVDTciDA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=693bb8da cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=4FtDUr6PSXutkdqchy0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3lSXu3aD0kMaEHuXIfrHWcxzDjWqxRjZ
X-Proofpoint-GUID: M3A62TS-OG7pD0o6F9ScssRALcwm-DPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020
X-Mailman-Approved-At: Fri, 12 Dec 2025 08:29:54 +0000
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

4. Adjust AMDGPU_GTT_MAX_TRANSFER_SIZE to respect the SDMA engine's 4MB hardware
   limit regardless of CPU page size. The hardcoded 512 pages worked on 4K
   systems but seems to be exceeding the limit with 64K system page size.

5. In the current driver, MMIO remap is supported only when the system page
   size is 4K. Error messages have been added to indicate that MMIO remap
   is not supported on systems with a non-4K page size.

6. Fix amdgpu page fault handler (for xnack) to pass the corresponding system
   pfn (instead of gpu pfn) for restoring SVM range mapping.

7. Align ctl_stack_size and wg_data_size to GPU page size.

8. On systems where the CPU page size is larger than the GPU’s 4K page size,
   the MQD and control stack are aligned to the CPU PAGE_SIZE, causing
   multiple GPU pages to inherit the UC attribute incorrectly. This results
   in the control-stack area being mis-mapped and leads to queue preemption
   and eviction failures. Aligning both regions to the GPU page size
   ensures the MQD is mapped UC and the control stack NC, restoring correct
   behavior.

9. Apart from these 8 changes, we also needed this change [1]. Without this change
   kernel simply crashes when running rocminfo command itself.
   [1]: https://github.com/greenforce-project/chromeos-kernel-mirror/commit/2b33fad96c3129a2a53a42b9d90fb3b906145b98

Setup details:
============
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
  Name:                    gfx90a
  Marketing Name:          AMD Instinct MI210

Queries:
=======
1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
   these changes. Is there anything else that you would suggest us to run to
   shake out any other page size related issues w.r.t the kernel driver?

2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
   size HW dependent? Should it be made PAGE_SIZE?

3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
   Do we need to lift this restriction and add MMIO remap support for systems with
   non-4K page sizes?

[1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
[2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test


Please note that the changes in this series are on a best effort basis from our
end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
HW & SW stack) to kindly help with the review and provide feedback / comments on
these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
supported with amd gpu kernel driver.

Donet Tom (7):
  drm/amdkfd: Relax size checking during queue buffer get
  amdkfd/kfd_svm: Fix SVM map/unmap address conversion for non-4k page
    sizes
  amdkfd/kfd_migrate: Fix GART PTE for non-4K pagesize in
    svm_migrate_gart_map()
  amdgpu/amdgpu_ttm: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page
    size
  drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
  amdgpu: Align ctl_stack_size and wg_data_size to GPU page size instead
    of CPU page size
  amdgpu: Fix MQD and control stack alignment for non-4K CPU page size
    systems

Ritesh Harjani (IBM) (1):
  amdkfd/kfd_chardev: Add error message for non-4k pagesize failures

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 29 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 16 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 10 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 15 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 17 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 30 ++++++++++++++-----
 10 files changed, 86 insertions(+), 43 deletions(-)

-- 
2.52.0

