Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035A5FEA82F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 08:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947AE10E80A;
	Wed, 25 Mar 2026 08:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="MGTWGVCp";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCA410E80A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 08:02:50 +0000 (UTC)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OGlPvW158937; Wed, 25 Mar 2026 08:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=P3zjQL4Hh1fhRKgwAMNS2hTbgxEO4y
 3F8TMfKnS2Hk0=; b=MGTWGVCpR7hbsSQ5SA5R6B3BNOEADFdiTJoFJnuiHQNPYS
 Onuk36q5/Iyp+BgijyQmPjilOPmNdmdBnquUmUi9+lMjK/PEJ8t+U+g4fpsHgHxD
 rGbnLg0gYL8QmZFHogZqzDrrJWpo+jXnKNa+WS0i/d/dJ5r7NQ0W7IGyMyTLb2zB
 gdzonVYPYaae3I6fRxBpRPutftGMTVGJ2M5KVmfayVJl7VlVxkP+r+UycMnSOn5C
 /NFllBOl1TkYWqfHPngeGFd+8MsPEGBSETM0yW5xA7S+tKiyO005kOBw1gWwRaZl
 Ma8gYzk8cLj4byjhobxm5XFwycQ40DACWDFLH9mQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqfe62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 08:02:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P5FfCn031687;
 Wed, 25 Mar 2026 08:02:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nswr69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2026 08:02:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62P82kYV28639900
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2026 08:02:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAC0758061;
 Wed, 25 Mar 2026 08:02:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1F795805A;
 Wed, 25 Mar 2026 08:02:42 +0000 (GMT)
Received: from [9.39.25.125] (unknown [9.39.25.125])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Mar 2026 08:02:42 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------LQBfJdb60l7qv2USZ0OgPPKx"
Message-ID: <a5cae3db-4b67-4a64-80ea-14bbde51d7f2@linux.ibm.com>
Date: Wed, 25 Mar 2026 13:32:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 0/6] drm/amd: Add support for non-4K page
 size systems
To: "Kuehling, Felix" <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <ff78dfa4-f16b-4313-af73-1e63db67ddca@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ff78dfa4-f16b-4313-af73-1e63db67ddca@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pYHHa45ywzisl9Iws8-41Attarzd9NT6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA1NCBTYWx0ZWRfXy/c8ov4umLq0
 6jMC3tHWx8JOCpvHd1sPQw9t9ZcGqOPQ3FX6goQoMORdyDTQ4FSnaaWgSr171kBfREdEE2pnawy
 EPjsXIc4kHRXFvo2eg5Ce2cn+s9GzPdXoljlbxT26ouo1Gaawr1/2uZYGp7mltp2+djhaEii+dn
 apW1/gAjsb8bb8SgjWgghz8Wdxn1tYRLvkvt4eEv96QvZk7LrZtdP0QDHfbUas7yxFKAVZydgXI
 bi7r1q1TuD88hj6VIfQP5517/2ODqVLgU80DACVCiC6UJEd/DvUkY1Gght6ZB7R/6pAofo5gn6u
 ffwOd7mpP8fiDhs45LJIzkod9G1tAHOb04MvpaO8heDybF5AYdYIXDLgaEVEIazSidZgw6pXmR0
 CwmTNi4k3pv/hSyteeKuCud8gFbpQiRv9wZkDmRlIeNdRbrsVhG6d31fELxyTqGgZMZ9t8Mu/uG
 5bvcqih4TIur2QKu+8g==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c396a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=RpNjiQI2AAAA:8
 a=2SrNnTgdAAAA:20 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=P-IC7800AAAA:8
 a=nAqPwasb9i4ENcvHKq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zd2uoN0lAAAA:8
 a=R71p4V5jaAIWy-Pdtp0A:9 a=tqdMzFhGG8mD8GCBlf4leDhY3gs=:19
 a=sTxRpBpiy98KL1WkT8X2XIWo+SM=:19 a=v9uydWyVGjtYDgFE:21 a=_W_S_7VecoQA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 5y7GsSGO2EaeOQ7n34GuE5RXVvUZRxV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250054
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

This is a multi-part message in MIME format.
--------------LQBfJdb60l7qv2USZ0OgPPKx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 3/25/26 7:57 AM, Kuehling, Felix wrote:
> On 2026-03-23 00:=E2=80=8A28, Donet Tom wrote: This is v3 of the patch se=
ries=20
> enabling 64 KB system page size support in AMDGPU. v2, part 1 of this=20
> series [1] has already been merged upstream and provides the minimal=20
> infrastructure required for 64 KB
>=20
>
>
> On 2026-03-23 00:28, Donet Tom wrote:
>> This is v3 of the patch series enabling 64 KB system page size support
>> in AMDGPU. v2, part 1 of this series [1] has already been merged
>> upstream and provides the minimal infrastructure required for 64 KB
>> page support.
>>
>> This series addresses additional issues uncovered in AMDGPU when
>> running rccl unit tests and rocr-debug-agent tessts on 64KB page-size
>> systems.
>>
>> With this series applied, all RCCL unit tests and rocr-debug-agent
>> tests pass on systems using a 64 KB system page size, across
>> multi-GPU configurations, with XNACK both enabled and disabled.
>>
>> Patch 1 in this series (drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE
>> to 2 * PAGE_SIZE) fixes a kernel crash observed when running rocminfo
>> on systems with a 64 KB page size. This patch is required to enable
>> minimal support for 64 KB system page sizes.
>>
>> Since RFC v2, we observed AQL queue creation failures while running
>> certain workloads on 64K page-size systems due to an expected queue size
>> mismatch. This issue is addressed in patch 2 of this series.
>>
>> The questions we had in this seres are:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> 1 When the control stack size is aligned to 64 KB, we consistently
>>    observe queue preemption or eviction failures on gfx9, on both
>>    4 KB and 64 KB system page-size configurations.
>>
>>    The control stack size is calculated based on the number of CUs and
>>    waves and is then aligned to PAGE_SIZE. On systems with a 64 KB
>>    system page size, this alignment always results in a 64 KB-aligned
>>    control stack size, after which queue preemption fails.
>>
>>    Is there any hardware-imposed limitation on gfx9 that prevents the
>>    control stack size from being 64 KB? For gfx10, I see explicit
>>    hardware limitations on the control stack size in the code [2].
>>    Is there anything similar for gfx9?
>>
>>    What is the correct or recommended control stack size for gfx9?
>>    With a 4 KB system page size, I observe a control stack size of
>>    around 44 KB=E2=80=94can it grow beyond this? If the control stack si=
ze
>>    is fixed for a given gfx version, do you see any issues with
>>    aligning the control stack size to the GPU page size?


Thank you, Felix, for your time and for reviewing this patch


> I think there is a bug in user mode that uses its own calculation of=20
> the ctl_stack_size to calculate the total context save area size. If=20
> kernel mode increases the ctl_stack_size, the context save are=20
> allocated by user mode will be too small.
>
> This is in=20
> https://github.com/ROCm/rocm-systems/blob/3a8bafb6a60f4cfa1047a5516fa7212=
beef4c98f/projects/rocr-runtime/libhsakmt/src/queues.c#L349
>
>                  /* Keep calculating it in case we are using an older ker=
nel, but if we have
>                   * the CtlStackSize and CwsrSize from KFD, use that as t=
he definitive value
>                   */
>                  q->ctx_save_restore_size =3D node.CwsrSize > 0 ? node.Cw=
srSize :
>                                             q->ctl_stack_size + PAGE_ALIG=
N_UP(wg_data_size);
>                  q->ctl_stack_size =3D node.CtlStackSize > 0 ? node.CtlSt=
ackSize : q->ctl_stack_size;
>
> ctx_save_restore_size should be calculated after correcting=20
> ctl_stack_size with the one from the kernel mode driver.
>

Yes, we also need a fix in rocr-runtime. In rocr-runtime, I used the=20
same approach as in the kernel (patch 6/6) to calculate ctl_stack_size=20
and ctx_save_restore_size. Without this library change, I was=20
encountering queue creation failures. With the library change and with=20
this series all rccl tests are passing on both 4K and 64K page sizes.


-Donet


> Regards,
>    Felix
>
>> This series has 5 patches
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> 1. AMDGPU_VA_RESERVED_TRAP_SIZE was hard-coded to 8 KB while
>>     KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE, which matches on
>>     4 KB page-size systems but results in a size mismatch on 64 KB
>>     systems, leading to kernel crashes when running rocminfo or RCCL
>>     unit tests.
>>     This patch updates AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE so
>>     that the reserved trap area matches the allocation size across all
>>     system page sizes. This is a must needed patch to enable minimal
>>     support for 64 KB system page sizes.
>>
>> 2. Aligned expected_queue_size to PAGE_SIZE to fix AQL queue creation
>>     failure.
>>
>> 3. Fix amdgpu page fault handler (for xnack) to pass the corresponding
>>     system pfn (instead of gpu pfn) for restoring SVM range mapping.
>>
>> 4. Updated AMDGPU_GTT_MAX_TRANSFER_SIZE to always match the PMD size
>>     across all page sizes.
>>
>> 5. On systems where the CPU page size is larger than the GPU=E2=80=99s 4=
 KB page
>>     size, the MQD and control stack were aligned to the CPU PAGE_SIZE,
>>     causing multiple GPU pages to incorrectly inherit the UC attribute.
>>     This change aligns both regions to the GPU page size, ensuring that
>>     the MQD is mapped as UC and the control stack as NC, restoring the
>>     correct behavior.
>>
>> 6. Queue preemption fails when the control stack size is aligned to
>>     64 KB. This patch fixes this issue by aligning the control stack
>>     size to gpu page size.
>>
>> Setup details:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> System details: Power10 LPAR using 64K pagesize.
>> AMD GPU:
>> Name:                    gfx90a
>> Marketing Name:          AMD Instinct MI210
>>
>> [1]https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.c=
om/
>> [2]https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c#L457
>>
>> RFC V3 -https://lore.kernel.org/all/cover.1771656655.git.donettom@linux.=
ibm.com/
>> RFC V2 -https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.=
ibm.com/
>> RFC V1 -https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.=
ibm.com/
>>
>>
>> Donet Tom (6):
>>    drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
>>    drm/amdkfd: Align expected_queue_size to PAGE_SIZE
>>    drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
>>    drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
>>    drm/amd: Fix MQD and control stack alignment for non-4K
>>    drm/amdkfd: Fix queue preemption/eviction failures by aligning control
>>      stack size to GPU page size
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 24 ++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  3 +-
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 11 ++---
>>   9 files changed, 82 insertions(+), 35 deletions(-)
>>=

--------------LQBfJdb60l7qv2USZ0OgPPKx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 3/25/26 7:57 AM, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:ff78dfa4-f16b-4313-af73-1e63db67ddca@amd.com">
      <!-- BaNnErBlUrFlE-BoDy-start -->
      <!-- Preheader Text : BEGIN -->
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
      <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;">
        On 2026-03-23 00:=E2=80=8A28, Donet Tom wrote: This is v3 of the pa=
tch
        series enabling 64 KB system page size support in AMDGPU. v2,
        part 1 of this series [1] has already been merged upstream and
        provides the minimal infrastructure required for 64 KB</div>
      <!-- Preheader Text : END -->
      <!-- Email Banner : BEGIN -->
      <div
style=3D"display:none !important;display:none;visibility:hidden;mso-hide:al=
l;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0;over=
flow:hidden;"></div>
      <!-- Email Banner : END -->
      <!-- BaNnErBlUrFlE-BoDy-end -->
      <!-- BaNnErBlUrFlE-HeAdEr-start -->
      <style>#pfptBannerxodrrlp { all: revert !important; display: block !i=
mportant;
    visibility: visible !important; opacity: 1 !important;
    background-color: #d0d8dc !important;
    max-width: none !important; max-height: none !important }.pfptPrimaryBu=
ttonxodrrlp:hover, .pfptPrimaryButtonxodrrlp:focus {
    background-color: #b4c1c7 !important; }.pfptPrimaryButtonxodrrlp:active=
 {
    background-color: #90a4ae !important; }html:root, html:root>body { all:=
 revert !important; display: block !important;
    visibility: visible !important; opacity: 1 !important; }</style>
      <!-- BaNnErBlUrFlE-HeAdEr-end -->
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
      <p><br>
      </p>
      <div class=3D"moz-cite-prefix">On 2026-03-23 00:28, Donet Tom wrote:<=
br>
      </div>
      <blockquote type=3D"cite"
        cite=3D"mid:cover.1774239489.git.donettom@linux.ibm.com">
        <pre wrap=3D"" class=3D"moz-quote-pre">This is v3 of the patch seri=
es enabling 64 KB system page size support
in AMDGPU. v2, part 1 of this series [1] has already been merged
upstream and provides the minimal infrastructure required for 64 KB
page support.

This series addresses additional issues uncovered in AMDGPU when
running rccl unit tests and rocr-debug-agent tessts on 64KB page-size
systems.

With this series applied, all RCCL unit tests and rocr-debug-agent
tests pass on systems using a 64 KB system page size, across
multi-GPU configurations, with XNACK both enabled and disabled.

Patch 1 in this series (drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE
to 2 * PAGE_SIZE) fixes a kernel crash observed when running rocminfo
on systems with a 64 KB page size. This patch is required to enable
minimal support for 64 KB system page sizes.

Since RFC v2, we observed AQL queue creation failures while running
certain workloads on 64K page-size systems due to an expected queue size
mismatch. This issue is addressed in patch 2 of this series.

The questions we had in this seres are:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1 When the control stack size is aligned to 64 KB, we consistently
  observe queue preemption or eviction failures on gfx9, on both
  4 KB and 64 KB system page-size configurations.

  The control stack size is calculated based on the number of CUs and
  waves and is then aligned to PAGE_SIZE. On systems with a 64 KB
  system page size, this alignment always results in a 64 KB-aligned
  control stack size, after which queue preemption fails.

  Is there any hardware-imposed limitation on gfx9 that prevents the
  control stack size from being 64 KB? For gfx10, I see explicit
  hardware limitations on the control stack size in the code [2].
  Is there anything similar for gfx9?

  What is the correct or recommended control stack size for gfx9?
  With a 4 KB system page size, I observe a control stack size of
  around 44 KB=E2=80=94can it grow beyond this? If the control stack size
  is fixed for a given gfx version, do you see any issues with
  aligning the control stack size to the GPU page size?</pre>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
    <p><font face=3D"monospace">Thank you, Felix, for your time and for
        reviewing this patch</font></p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:ff78dfa4-f16b-4313-af73-1e63db67ddca@amd.com">
      <blockquote type=3D"cite"
        cite=3D"mid:cover.1774239489.git.donettom@linux.ibm.com"> </blockqu=
ote>
      <p>I think there is a bug in user mode that uses its own
        calculation of the ctl_stack_size to calculate the total context
        save area size. If kernel mode increases the ctl_stack_size, the
        context save are allocated by user mode will be too small.</p>
      <p>This is in
        <a class=3D"moz-txt-link-freetext"
href=3D"https://github.com/ROCm/rocm-systems/blob/3a8bafb6a60f4cfa1047a5516=
fa7212beef4c98f/projects/rocr-runtime/libhsakmt/src/queues.c#L349"
          moz-do-not-send=3D"true">https://github.com/ROCm/rocm-systems/blo=
b/3a8bafb6a60f4cfa1047a5516fa7212beef4c98f/projects/rocr-runtime/libhsakmt/=
src/queues.c#L349</a></p>
      <pre>                /* Keep calculating it in case we are using an o=
lder kernel, but if we have
                 * the CtlStackSize and CwsrSize from KFD, use that as the =
definitive value
                 */
                q-&gt;ctx_save_restore_size =3D node.CwsrSize &gt; 0 ? node=
.CwsrSize :
                                           q-&gt;ctl_stack_size + PAGE_ALIG=
N_UP(wg_data_size);
                q-&gt;ctl_stack_size =3D node.CtlStackSize &gt; 0 ? node.Ct=
lStackSize : q-&gt;ctl_stack_size;</pre>
      <p>ctx_save_restore_size should be calculated after correcting
        ctl_stack_size with the one from the kernel mode driver.</p>
    </blockquote>
    <p><font face=3D"monospace"><br>
      </font></p>
    <p><font face=3D"monospace">Yes, we also need a fix in rocr-runtime.
        In rocr-runtime, I used the same approach as in the kernel
        (patch 6/6) to calculate ctl_stack_size and
        ctx_save_restore_size. Without this library change, I was
        encountering queue creation failures. With the library change
        and with this series all rccl tests are passing on both 4K and
        64K page sizes.</font></p>
    <p><font face=3D"monospace"><br>
      </font></p>
    <p><font face=3D"monospace">-Donet</font></p>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:ff78dfa4-f16b-4313-af73-1e63db67ddca@amd.com">
      <pre>Regards,
  Felix

</pre>
      <blockquote type=3D"cite"
        cite=3D"mid:cover.1774239489.git.donettom@linux.ibm.com">
        <pre wrap=3D"" class=3D"moz-quote-pre">This series has 5 patches
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. AMDGPU_VA_RESERVED_TRAP_SIZE was hard-coded to 8 KB while
   KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE, which matches on
   4 KB page-size systems but results in a size mismatch on 64 KB
   systems, leading to kernel crashes when running rocminfo or RCCL
   unit tests.
   This patch updates AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE so
   that the reserved trap area matches the allocation size across all
   system page sizes. This is a must needed patch to enable minimal
   support for 64 KB system page sizes.

2. Aligned expected_queue_size to PAGE_SIZE to fix AQL queue creation
   failure.

3. Fix amdgpu page fault handler (for xnack) to pass the corresponding
   system pfn (instead of gpu pfn) for restoring SVM range mapping.

4. Updated AMDGPU_GTT_MAX_TRANSFER_SIZE to always match the PMD size
   across all page sizes.

5. On systems where the CPU page size is larger than the GPU=E2=80=99s 4 KB=
 page
   size, the MQD and control stack were aligned to the CPU PAGE_SIZE,
   causing multiple GPU pages to incorrectly inherit the UC attribute.
   This change aligns both regions to the GPU page size, ensuring that
   the MQD is mapped as UC and the control stack as NC, restoring the
   correct behavior.

6. Queue preemption fails when the control stack size is aligned to
   64 KB. This patch fixes this issue by aligning the control stack
   size to gpu page size.

Setup details:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
Name:                    gfx90a
Marketing Name:          AMD Instinct MI210

[1] <a class=3D"moz-txt-link-freetext"
href=3D"https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm=
.com/"
        moz-do-not-send=3D"true">https://lore.kernel.org/all/cover.17655198=
75.git.donettom@linux.ibm.com/</a>
[2] <a class=3D"moz-txt-link-freetext"
href=3D"https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/a=
md/amdkfd/kfd_queue.c#L457"
        moz-do-not-send=3D"true">https://elixir.bootlin.com/linux/v6.19-rc5=
/source/drivers/gpu/drm/amd/amdkfd/kfd_queue.c#L457</a>

RFC V3 - <a class=3D"moz-txt-link-freetext"
href=3D"https://lore.kernel.org/all/cover.1771656655.git.donettom@linux.ibm=
.com/"
        moz-do-not-send=3D"true">https://lore.kernel.org/all/cover.17716566=
55.git.donettom@linux.ibm.com/</a>
RFC V2 - <a class=3D"moz-txt-link-freetext"
href=3D"https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.ibm=
.com/"
        moz-do-not-send=3D"true">https://lore.kernel.org/all/cover.17696129=
73.git.donettom@linux.ibm.com/</a>
RFC V1 - <a class=3D"moz-txt-link-freetext"
href=3D"https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm=
.com/"
        moz-do-not-send=3D"true">https://lore.kernel.org/all/cover.17655198=
75.git.donettom@linux.ibm.com/</a>


Donet Tom (6):
  drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
  drm/amdkfd: Align expected_queue_size to PAGE_SIZE
  drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
  drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
  drm/amd: Fix MQD and control stack alignment for non-4K
  drm/amdkfd: Fix queue preemption/eviction failures by aligning control
    stack size to GPU page size

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 24 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 11 ++---
 9 files changed, 82 insertions(+), 35 deletions(-)

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------LQBfJdb60l7qv2USZ0OgPPKx--

