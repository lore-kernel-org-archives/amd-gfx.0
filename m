Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67861C61DB4
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 10:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF48A10E9C0;
	Tue, 25 Aug 2026 10:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="Lw1yX+a1";
	dkim-atps=neutral
Received: from smtpout1.mo2.mail-out.ovh.net (smtpout1.mo2.mail-out.ovh.net
 [79.137.123.219])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD5C10E9C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 10:13:20 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4hTkBP44m3z43q3;
 Tue, 25 Aug 2026 10:13:17 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <Alexander.Deucher@amd.com>; Tue, 25 Aug 2026 10:13:17 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.58.184])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hTkBP1jDmz1xqZ; Tue, 25 Aug 2026 10:13:17 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.9])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id DEBC9941B1B; 
 Tue, 25 Aug 2026 10:13:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00505a4bd57-ea03-40e4-98b5-bb262051814f,
 CCC79C7CF71DB5916E4358223B2344CA4711FD52) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
Message-ID: <16d7dd0f-5622-4524-8522-62b7e6d40a0c@pixelcluster.dev>
Date: Tue, 25 Aug 2026 12:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
 ops to VM ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Six, Lancelot" <Lancelot.Six@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>
References: <20260820070143.3916329-1-srinivasan.shanmugam@amd.com>
 <20260820070143.3916329-2-srinivasan.shanmugam@amd.com>
 <6dcd3e9a-b308-44c6-a9cb-4bca149a2fde@pixelcluster.dev>
 <IA0PR12MB82080BCDF88122DD4E767E1390AF2@IA0PR12MB8208.namprd12.prod.outlook.com>
 <44857ea2-7f39-4088-9209-ce21ddaf8987@amd.com>
Content-Language: en-US
From: Natalie Vock <nat@pixelcluster.dev>
In-Reply-To: <44857ea2-7f39-4088-9209-ce21ddaf8987@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 7691303742743273972
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG0bkBU/IY2sGUUCiW5vd+u9qsykcRcZ5Hy7b5+MiH3KAZIz3+tUziEUjXVhCF8nq+ezA5WpcAPCZ15e6glO9UNxs1iFfARf5NHnc5GQ3THbG04WFqRfMnCyuIBKNJaY/BPFjWYrSl/MJ3dSZwbv6lJWYSDsDD/0iIGuTdP0UOvbVFQqesJtyFR3jdN/sXJl1kIm431eln6z7M7NcqDolpztve9fYKJmrcuqe/55si8gXZauoW2D0+P0ObnjFamsvmalzL/NEphklD7z5U3xOla3pt92PILfgxvr5vqxyn3eSZ/7rnvkf3kHO83/8SalZ424p8eRolo0fSZ4ZqhpQB1bfs9jKKmbOYrCRtVy3yPZ+hpQU3acQdScdUXEB7fhHvOR7aU8xjQSG+6XVReMF/p/YqwYIbWh8TbQYCpllnZUuQCHzUUCtKRGk9gFvirC6NciWL6oDg9IS55O+FNoCH+fS3j7pi6/mhsbSXhP9vfxURopSokIwMHtez4k9EW3LE++lBYBZg4Aq2WKH0JuWd3D7RFtr/KAU0T5JjRlu6ZYVMS+r+YG2oRLjiZSQdK9aVUGF+8btFTMbSqjkUIwQe6ixuSU2dOk+Y3eVQxfyEHEcXPesT5jZnxgqDYV6w1V7puiy3THERAj0hLUJyDpXcopl9a86fIFQtTCrqP+OyJ+g
DKIM-Signature: a=rsa-sha256; bh=C67jBYk+mRhXwb01+YWvl97xkqG8NQESYd2Uh9GiBRI=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1787652797; v=1;
 b=Lw1yX+a1FnHNRwqhAvAwn8zVoUEkWo00qK0iu9b4egOilYX2VKt9Iv2Mz/g7RCLyu4DFddur
 Y7iZB1TP/bYWMHKdU+UGnzos5utouUu3CRUp9qK3ZsIydOt00ozZVUoTLlY6t4Pqla7YBjouuu8
 qTAfT6WAnF8bHZDb2BasKUbpaCy0Sil9QqlqgRcLcIdFNX5SAKgcEhaJpzFXTizu9bUmaLi7MQ+
 XzOUDTvJViIUl/j28SQEqNoud1d1AbW+WeuRHuD+gno59Z6zcERdgj1eY6joAXazKjUGglw5USQ
 MVw8KEny13b1XNalQqUkOq0/i3qL7ZS7lYPtHrSZsXqKQ==
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

On 8/25/26 09:34, Christian König wrote:
> On 8/25/26 07:05, SHANMUGAM, SRINIVASAN wrote:
>> AMD General
>>
>>> -----Original Message-----
>>> From: Natalie Vock <nat@pixelcluster.dev>
>>> Sent: Thursday, August 20, 2026 3:29 PM
>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Kuehling, Felix <Felix.Kuehling@amd.com>;
>>> Zhu, James <James.Zhu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Six,
>>> Lancelot <Lancelot.Six@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-
>>> eric.Pelloux-prayer@amd.com>; Timur Kristóf <timur.kristof@gmail.com>; Samuel
>>> Pitoiset <hakzsam@gmail.com>
>>> Subject: Re: [RFC PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler
>>> ops to VM ioctl
>>>
>>> Hi,
>>>
>>> first of all: Thanks for working on this! It's great seeing trap handler support come
>>> together.
>>>
>>> On 8/20/26 09:01, Srinivasan Shanmugam wrote:
>>>> When a GPU shader hits an exception, memory fault, or debug
>>>> breakpoint, the hardware jumps to the first-level trap handler. The
>>>> first-level handler (managed by the kernel via CWSR) checks the TMA
>>>> buffer for a second-level handler address. If one is installed, it
>>>> forwards the trap to that userspace handler, allowing the runtime or
>>>> debugger to handle shader exceptions without modifying the kernel trap handler.
>>>>
>>>> KFD already supports this for compute workloads. Render-node user
>>>> queues had no equivalent mechanism. Add it.
>>>>
>>>> The second-level handler is a per-VM setting — it applies to all
>>>> shader waves executing under that VMID regardless of queue type. GFX
>>>> and compute queues from the same process share the same VMID, so one
>>>> SET_L2_TRAP call covers all queue types for that process. This
>>>> configuration is not CWSR-specific; CWSR is only the first-level
>>>> handler mechanism. The correct home for this setting is the VM ioctl
>>>> (DRM_AMDGPU_VM), following the same pattern as
>>>> AMDGPU_VM_OP_RESERVE_VMID.
>>>>
>>>> Add two new VM ioctl operations:
>>>>     AMDGPU_VM_OP_SET_L2_TRAP   (op = 3) — install second-level handler
>>>>     AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4) — remove second-level
>>> handler
>>>>
>>>> Extend drm_amdgpu_vm_in with a 32-byte union for op-specific data. The
>>>> l2trap member carries the GPU virtual addresses and sizes of the TBA
>>>> (handler code) and TMA (handler scratch memory).
>>>
>>> This should be a BO handle and offset+size, instead. The BOs associated with the
>>> TBA/TMA must be tracked as used by every submission from the VM that has this
>>> trap handler installed, otherwise you introduce a ton of race conditions. Off the top
>>> of my head, here are a few:
>>> 1. The GEM VA ioctl can spuriously fail to actually update page tables.
>>>      This is okay and intentional, and BOs with outdated page tables will
>>>      be updated on the next submit if they're used by the submission. If
>>>      the TBA/TMA BOs aren't marked in the set of used buffers, the PTs may
>>>      end up never being updated and subsequent accesses will fault.
>>> 2. The TBA/TMA may be evicted/moved around concurrently with executing
>>>      submissions if these submissions didn't add their fences to the
>>>      TBA/TMA resv, which would likely randomly corrupt things or hang.
>>>
>>> A simpler solution could be requiring the TBA/TMA buffers to be
>>> VM_ALWAYS_VALID, in which case synchronization to all submissions in the VM
>>> is taken care of automagically. This prevents exporting the TBA/TMA to an fd, but I
>>> don't expect anyone would want to do this.
>>
>> Hi Natalie,
>>
>> Thanks for the feedback.
>>
>> We will update the UAPI in v2 to pass BO handles alongside
>> the GPU VA for TBA/TMA. This ensures the kernel can properly
>> track and pin the buffers.
> 
> Please don't. It is the responsibility of userspace to make sure that the BOs are either in the used list or valid per VM.

Oh, right, I guess we can do it this way too. That's fine by me, but I
think my point about syncing TBA/TMA binds/unbinds in the same way as
VM map/unmap ops still applies. I suppose for user queues the existing
approach could be fine, but as Timur points out RADV won't be able to
use this unless support for kernel queues is added.

As far as I remember, it's convention that before merging new uAPI, you
also have a userspace-side use of that uAPI lined up. I or someone else
working on RADV can easily write that up, but for that we need an API
that RADV can actually use :)

Best,
Natalie

> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Srini
>>
>>>
>>> Regards,
>>> Natalie
> 

