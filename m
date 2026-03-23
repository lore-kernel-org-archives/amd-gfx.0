Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C157EC01D4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 11:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1226310E0F1;
	Mon, 23 Mar 2026 11:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="EpT4gf7L";
	dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA6E10E0F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 11:50:36 +0000 (UTC)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NAiFJ63518795; Mon, 23 Mar 2026 11:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=O/PeZGmmFvDEzVlFP5VzB5DAQE+AEM
 8YH8v8ciT0NjE=; b=EpT4gf7L/FhItgNSY5KW3H7FhEWkFTHAV+1LY0U46HCc8S
 Tr2fudAKty+i9mweRf8UotAncISZV385Lq7Ndd0lkPmeW4d1SkvJsISZq8HHb3yd
 j1u15rEaYE0hXPJInW5v79rDYiaAVZ0NyhTsF1xer1A+qbeNtEOdpcLI4V59MNyA
 7QYjlzZ5de286A1ipk7jYV1eiTb8+pI3RMCM7B6amUSI6glTehUL70cgNfaI3+Kw
 yNSlOBkgRFsd23yPeeq+CKA9Y0eVYUlsxCUtDDQeJEoL0QVsknzH8lAmBLUmrjP9
 VU9W8iIFIUkrKne5YA150wpnEi9VZwxvZ1kqTMRQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumec3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 11:50:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBjr87005996;
 Mon, 23 Mar 2026 11:50:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261yd9s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 11:50:33 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NBoXGm31654484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 11:50:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7E4658054;
 Mon, 23 Mar 2026 11:50:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97D1C5804E;
 Mon, 23 Mar 2026 11:50:28 +0000 (GMT)
Received: from [9.39.25.231] (unknown [9.39.25.231])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 11:50:28 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------7dSUoX0KL4FIjWZhbRxgZu8U"
Message-ID: <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
Date: Mon, 23 Mar 2026 17:20:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
 <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: FFjllMvN1YKPqjhT9ysiAw4ywWuqkC1s
X-Proofpoint-ORIG-GUID: 0OWlkIudeqycOMJ7ezaHAFfqfLQEfBQr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5MiBTYWx0ZWRfX5FNNMMj9zGei
 3UblE5m9xh7CK8y2EMYStkNKcq5yYP1Elg/DKp1f45avVr+2CVA7hPaJUrBVWW2DhDbPFm81jZK
 gCqaVtj3V1b+ksc3ySklDemChYHUn/+HpkmAQyXOEEFOIj50hSki8t5c3fKuD0cfm4qPpo0dVXv
 DpOSN3C07FNx6j+ryIPvkYpJlEZG8yXY6G6lwFtli2v2xycyBPyJIhgQTKQ0GBWNt/6hbeeDyRn
 wLBlTvmJo5a3s7wcETY6yzLDrVuPxWw3Mk5XPHOSsKHiDvhDMnqYcasZx82GBjdNrAYo+KTrBmn
 4lixK0b0MadxloKOAL+dwMYWjycJeSHF5d0lmDCkICcQLUnraEiPLSOOXOvn4RwaF1R3Ym8pFGG
 lnQdRaPJ5hXAi57G7BBrngNhv4S0GIDAvjd5zMJmCWTBBOoxPxSmSz6uaOL+zEY87TQISfqHyE4
 4onPmBXHjzaKxGEPsfg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c1290a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=JzUKQMvRPXc2KW-Ok0wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zd2uoN0lAAAA:8 a=1rW4lpAPEabOD9I0l00A:9
 a=QlwrxM4P8-rm9iwE:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230092
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
--------------7dSUoX0KL4FIjWZhbRxgZu8U
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/23/26 3:41 PM, Christian König wrote:

Hi Christian

> On 3/23/26 05:28, Donet Tom wrote:
>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>> 4K pages, both values match (8KB), so allocation and reserved space
>> are consistent.
>>
>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
>> while the reserved trap area remains 8KB. This mismatch causes the
>> kernel to crash when running rocminfo or rccl unit tests.
>>
>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>> Faulting instruction address: 0xc0000000002c8a64
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>> Tainted: [E]=UNSIGNED_MODULE
>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>> XER: 00000036
>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>> IRQMASK: 1
>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>> c00000013d814540
>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>> 0000000000000000
>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>> 0000000084002268
>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>> 0000000000020000
>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>> 0000000000000000
>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>> c00000013d814500
>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>> c0000001e0957878
>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>> c0000001e0957888
>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>> Call Trace:
>> 0xc0000001e0957890 (unreliable)
>> __mutex_lock.constprop.0+0x58/0xd00
>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>> kfd_ioctl+0x514/0x670 [amdgpu]
>> sys_ioctl+0x134/0x180
>> system_call_exception+0x114/0x300
>> system_call_vectored_common+0x15c/0x2ec
>>
>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
>> ensuring that the reserved trap area matches the allocation size
>> across all page sizes.
>>
>> cc:stable@vger.kernel.org
>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
>> Reviewed-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
>> Signed-off-by: Donet Tom<donettom@linux.ibm.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 139642eacdd0..a5eae49f9471 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>>   #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>>   						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)
> Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.
>
> That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.
>
> Where is KFD_CWSR_TBA_TMA_SIZE defined?
>

Thanks Christian for reviewing this patch.

It is defined in kfd_priv.h.

/* * Size of the per-process TBA+TMA buffer: 2 pages * * The first chunk 
is the TBA used for the CWSR ISA code. The second * chunk is used as TMA 
for user-mode trap handler setup in daisy-chain mode. */ #define 
KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)


Could you please suggest the correct way to fix this issue? -Donet

> Regards,
> Christian.
>
>>   #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>   						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>   #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
--------------7dSUoX0KL4FIjWZhbRxgZu8U
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/23/26 3:41 PM, Christian König
      wrote:</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix"><font face="monospace">Hi Christian</font></div>
    <div class="moz-cite-prefix"><br>
    </div>
    <blockquote type="cite"
      cite="mid:65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com">
      <pre wrap="" class="moz-quote-pre">On 3/23/26 05:28, Donet Tom wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
4K pages, both values match (8KB), so allocation and reserved space
are consistent.

However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
while the reserved trap area remains 8KB. This mismatch causes the
kernel to crash when running rocminfo or rccl unit tests.

Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
BUG: Kernel NULL pointer dereference on read at 0x00000002
Faulting instruction address: 0xc0000000002c8a64
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
Tainted: [E]=UNSIGNED_MODULE
Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
MSR:  8000000000009033 &lt;SF,EE,ME,IR,DR,RI,LE&gt; CR: 24008268
XER: 00000036
CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
IRQMASK: 1
GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
c00000013d814540
GPR04: 0000000000000002 c00000013d814550 0000000000000045
0000000000000000
GPR08: c00000013444d000 c00000013d814538 c00000013d814538
0000000084002268
GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
0000000000020000
GPR16: 0000000000000000 0000000000000002 c00000015f653000
0000000000000000
GPR20: c000000138662400 c00000013d814540 0000000000000000
c00000013d814500
GPR24: 0000000000000000 0000000000000002 c0000001e0957888
c0000001e0957878
GPR28: c00000013d814548 0000000000000000 c00000013d814540
c0000001e0957888
NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
Call Trace:
0xc0000001e0957890 (unreliable)
__mutex_lock.constprop.0+0x58/0xd00
amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
kfd_ioctl+0x514/0x670 [amdgpu]
sys_ioctl+0x134/0x180
system_call_exception+0x114/0x300
system_call_vectored_common+0x15c/0x2ec

This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
ensuring that the reserved trap area matches the allocation size
across all page sizes.

cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
Reviewed-by: Ritesh Harjani (IBM) <a class="moz-txt-link-rfc2396E" href="mailto:ritesh.list@gmail.com">&lt;ritesh.list@gmail.com&gt;</a>
Signed-off-by: Donet Tom <a class="moz-txt-link-rfc2396E" href="mailto:donettom@linux.ibm.com">&lt;donettom@linux.ibm.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..a5eae49f9471 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL &lt;&lt; 20)
 #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
 						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
-#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL &lt;&lt; 12)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL &lt;&lt; PAGE_SHIFT)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.

That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.

Where is KFD_CWSR_TBA_TMA_SIZE defined?

</pre>
    </blockquote>
    <br>
    <p><font face="monospace">Thanks Christian for reviewing this patch.</font></p>
    <p><font face="monospace">It is defined in kfd_priv.h.<br>
      </font><br>
    </p>
    <pre
style="box-sizing: inherit; font-family: &quot;Ubuntu Mono&quot;, monospace; font-size: 0.9em; line-height: 1.2; padding: 1em 0px 4em; color: rgb(0, 0, 0); margin: 0px; min-height: 100%; tab-size: 8; white-space: pre; word-spacing: 0px; word-break: normal; overflow-wrap: normal; hyphens: none; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><font
    face="monospace">/*
 * Size of the per-process TBA+TMA buffer: 2 pages
 *
 * The first chunk is the TBA used for the CWSR ISA code. The second
 * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
 */
#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)</font>


<font face="monospace">
Could you please suggest the correct way to fix this issue?

-Donet</font></pre>
    <blockquote type="cite"
      cite="mid:65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com">
      <pre wrap="" class="moz-quote-pre">Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL &lt;&lt; 16)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------7dSUoX0KL4FIjWZhbRxgZu8U--

