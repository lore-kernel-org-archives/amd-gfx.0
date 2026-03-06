Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408FDFCC048
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14E210E2C8;
	Fri,  6 Mar 2026 17:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="JdI7ateT";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A64A10E2C8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:54:42 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62680stG2069251; Fri, 6 Mar 2026 17:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Q+QazG
 roXq52bV9zrSAq9OVzyHhJtO5ltiVTmgA+XqU=; b=JdI7ateTfKYAkPmyTKe0K0
 hdntQMeh5uoW+KkUA+pYtm758BQAc+NuT7vz1vWaE32VaucHjSG2MdTsu2+nfsqy
 S6jXlrF6a+Yd4IYJhKX5ADgSQTZVbJwvakOmOjG/j3Q5ri4AzO8i49On6pHtc0wZ
 z8i28Izf8JhlYQr+gYlOG5BmBV38ZSXX3w8Swe0NP80Udr5bJ5d6Hb1GtAQI9BWA
 YlxSRy4LV6YztNOZiuatvhlWnaBDV+IClo1CbzwtdYxqDvxl8Z2uA/P4yL7dX5Ks
 fYVUbUmGETbXKT07642wpA8Z553G2+9Bni3NdvZZp7jmSe5caIHptGpqiOicizag
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssn19ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 17:54:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626HGSOW029112;
 Fri, 6 Mar 2026 17:54:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsh3er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 17:54:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626Hsckj31982100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 17:54:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE00658059;
 Fri,  6 Mar 2026 17:54:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9405A58066;
 Fri,  6 Mar 2026 17:54:34 +0000 (GMT)
Received: from [9.39.17.192] (unknown [9.39.17.192])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 17:54:34 +0000 (GMT)
Message-ID: <3c9564d0-b9f1-44a1-bddc-e8548c96af32@linux.ibm.com>
Date: Fri, 6 Mar 2026 23:24:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] drm/amd: Add support for non-4K page size
 systems
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1771656655.git.donettom@linux.ibm.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <cover.1771656655.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE2NyBTYWx0ZWRfX7shO1s6EjZmB
 kNvJkfTdU24/tX/8cUUtY/giH4hi5cmTIVvIJ+UX6QCMhckSlUAQlAZ4yyrEBbP5XF60bT2N1ih
 Zg/PRmHDtYQggwGjS/lh4KzxYgSscHyuYi1ATaGzu3tFPtN8dKocxsl/DGDEVILPfQczjWX6r5P
 xkKitU7BMBoCnTN6C4slmiPXj4b3Rj2GTWJPugzsAVT7/eghx1+cc5ASAFtSsTtTaWomcuswTYm
 KEZD53GrdtjnUnIGKmfEXWWlddeWuCzRj/aLpTBy2C+n89uQdiGn05H8MMsTm5A5oqoZk3aRi6m
 wDuCD6j5uK18DzILcAEZC2IyDcxW+fgZcWywPPTjXBsWy5LWwgGU7phmnsgJLYvMj9vUbNmwRRT
 8+TPWQwQ/vqLp0lv6/eDxkbCmUkUFmJKTgtGd0u+qs/v1H7owscmR+I9RIebHz9HjYCiblPr0Gj
 yg7qPi/tH5eUAxXiy+g==
X-Proofpoint-ORIG-GUID: OyIBGNgJDlC0-3J5F2BtXNG4Q1Gsd9eB
X-Proofpoint-GUID: kb5mDJCc7YQ41NUgW1noIJzMqNkN9orF
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69ab14e0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=P-IC7800AAAA:8 a=TBJuidF-hLD_KTCGJwAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060167
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


On 2/21/26 12:39 PM, Donet Tom wrote:
> This is v3 of the patch series enabling 64 KB system page size support
> in AMDGPU. v2, part 1 of this series [1] has already been merged
> upstream and provides the minimal infrastructure required for 64 KB
> page support.
>
> This series addresses additional issues uncovered in AMDGPU when
> running rccl unit tests and rocr-debug-agent tessts on 64KB page-size
> systems.
>
> With this series applied, all RCCL unit tests and rocr-debug-agent
> tests pass on systems using a 64 KB system page size, across
> multi-GPU configurations, with XNACK both enabled and disabled.
>
> Patch 1 in this series (drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE
> to 2 * PAGE_SIZE) fixes a kernel crash observed when running rocminfo
> on systems with a 64 KB page size. This patch is required to enable
> minimal support for 64 KB system page sizes.
>
> Since RFC v2, we observed AQL queue creation failures while running
> certain workloads on 64K page-size systems due to an expected queue size
> mismatch. This issue is addressed in patch 2 of this series.
>
> The questions we had in this seres are:
> =======================================
> 1 When the control stack size is aligned to 64 KB, we consistently
>    observe queue preemption or eviction failures on gfx9, on both
>    4 KB and 64 KB system page-size configurations.
>
>    The control stack size is calculated based on the number of CUs and
>    waves and is then aligned to PAGE_SIZE. On systems with a 64 KB
>    system page size, this alignment always results in a 64 KB-aligned
>    control stack size, after which queue preemption fails.
>
>    Is there any hardware-imposed limitation on gfx9 that prevents the
>    control stack size from being 64 KB? For gfx10, I see explicit
>    hardware limitations on the control stack size in the code [2].
>    Is there anything similar for gfx9?
>
>    What is the correct or recommended control stack size for gfx9?
>    With a 4 KB system page size, I observe a control stack size of
>    around 44 KB—can it grow beyond this? If the control stack size
>    is fixed for a given gfx version, do you see any issues with
>    aligning the control stack size to the GPU page size?
>
> This series has 5 patches
> =========================
> 1. AMDGPU_VA_RESERVED_TRAP_SIZE was hard-coded to 8 KB while
>     KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE, which matches on
>     4 KB page-size systems but results in a size mismatch on 64 KB
>     systems, leading to kernel crashes when running rocminfo or RCCL
>     unit tests.
>     This patch updates AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE so
>     that the reserved trap area matches the allocation size across all
>     system page sizes. This is a must needed patch to enable minimal
>     support for 64 KB system page sizes.
>
> 2. Aligned expected_queue_size to PAGE_SIZE to fix AQL queue creation
>     failure.
>
> 3. Fix amdgpu page fault handler (for xnack) to pass the corresponding
>     system pfn (instead of gpu pfn) for restoring SVM range mapping.
>
> 4. Updated AMDGPU_GTT_MAX_TRANSFER_SIZE to always match the PMD size
>     across all page sizes.
>
> 5. On systems where the CPU page size is larger than the GPU’s 4 KB page
>     size, the MQD and control stack were aligned to the CPU PAGE_SIZE,
>     causing multiple GPU pages to incorrectly inherit the UC attribute.
>     This change aligns both regions to the GPU page size, ensuring that
>     the MQD is mapped as UC and the control stack as NC, restoring the
>     correct behavior.
>
> 6. Queue preemption fails when the control stack size is aligned to
>     64 KB. This patch fixes this issue by aligning the control stack
>     size to gpu page size.
>
> Setup details:
> ============
> System details: Power10 LPAR using 64K pagesize.
> AMD GPU:
> Name:                    gfx90a
> Marketing Name:          AMD Instinct MI210
>
> [1] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
> [2] https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_queue.c#L457
>
> RFC V2 - https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.ibm.com/
> RFC V1 - https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
>
>
> Donet Tom (6):
>    drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
>    drm/amdkfd: Align expected_queue_size to PAGE_SIZE
>    drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
>    drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
>    drm/amd: Fix MQD and control stack alignment for non-4K
>    drm/amdkfd: Fix queue preemption/eviction failures by aligning control
>      stack size to GPU page size


Hi All,

Gentle ping.

Could you please review this patch series and share your feedback?

We have tested this series on both 4K and 64K page-size kernels, and all 
RCCL tests and ROCR debug agent tests are passing. If everything looks 
good, could we get this merged in the next kernel release (7.1)?

Thanks for your review.

-Donet


>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 24 ++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  3 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 11 ++---
>   9 files changed, 82 insertions(+), 35 deletions(-)
>
