Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A09C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 08:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85F410E2EE;
	Tue, 24 Oct 2023 08:09:20 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D28710E2EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 08:09:19 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso30786665e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698134958; x=1698739758; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGVzDcAZ5VXmTx1P90/SCX98G2xHvsGao1pwcgkLszU=;
 b=F0hkhSXrIy9mGxU2SeXd0ZIKiytjP2WmJPujl0+0qdLprO7tzYsANVluOeaHtql/hu
 N+W9divaWc3TRkO8L+xG9JDQCacUWV2chhp0PfeHZPa8z1zUBXSlMOudPlCAi4W8pOb5
 brCuH0tY2egOlcfK1ZXSjYdg5ndDHSxtWZx2FVNUwUhx4cY5tTPFBDCjlL7QetLz1IoA
 lvAwj8h8DDP5YauoBagrK1nPhd6Kvyl5GSp0gd1D8SWkA2+hXZnU4PsjUONi4xQSE8f3
 +aajB+vuwNkjUHjij3K67qy923aQkTXJ+Ut+OBL0lAiyzZlHeuvbzM86OYF/DOBfWPhb
 JBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698134958; x=1698739758;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EGVzDcAZ5VXmTx1P90/SCX98G2xHvsGao1pwcgkLszU=;
 b=rxYBZtai6/M+b2HGsaGY0JS4SiOjPzRUqzbwTu3s31JofeAgou4EqnUSn85f4iuPyl
 Zsa1X+dBZOdI3/GUiWt/i+bmshgqly5kPSa9X6RN8eWAFVt5VY5Fde3OfFegFrzMavAO
 /FyfV8dzL25f0clqt1y1dCP4bdlqtnnd4r/Ta1MfAUuJkUzu1hFBL/9v7DWVY9zD7b2J
 JpFQ637KUNi+yjc4LgrO5nV7/arA+FBJzufX8TQznLpmxgXNlbnER22+HM3rGC/XLDYo
 gxbE/+hLNi4MLS+pGa9CshuTmlweWHyNccY3x8g/3zqIyNUXg1+Vu0PwRcer3rLVX89D
 TyTA==
X-Gm-Message-State: AOJu0Yz5x6cPSwwpj2/3H0NAlco1SaII8U5KlFqNVULgNfSHsZ76yaN9
 fby3CSfcu1uu+6qqc9uOZ5g=
X-Google-Smtp-Source: AGHT+IHeIHhQolcRRBRIfM3wTkrWWemtYFajNsaHaF0I2qArgH49e/5YV1ubOl00aN/uSvBifRii2g==
X-Received: by 2002:a05:600c:4e8d:b0:404:7462:1f6f with SMTP id
 f13-20020a05600c4e8d00b0040474621f6fmr8535138wmq.8.1698134957381; 
 Tue, 24 Oct 2023 01:09:17 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 q19-20020a05600c46d300b0040836519dd9sm11341697wmo.25.2023.10.24.01.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 01:09:16 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------kafbGxggMVR1jcPaQdZ3mkAE"
Message-ID: <e4f3ec9f-73e0-4d60-8831-f3d144b94ca4@gmail.com>
Date: Tue, 24 Oct 2023 10:09:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute"
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Daniel Tang <danielzgtg.opensource@gmail.com>, amd-gfx@lists.freedesktop.org
References: <5984374.lOV4Wx5bFT@daniel-desktop2>
 <38742906-869c-4bc6-9cce-ea3ea98873d4@gmail.com>
 <5e2c00e0-5d9c-4583-95ab-a0929e01e877@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <5e2c00e0-5d9c-4583-95ab-a0929e01e877@amd.com>
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
Cc: Xiaogang Chen <xiaogang.chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------kafbGxggMVR1jcPaQdZ3mkAE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.10.23 um 01:41 schrieb Felix Kuehling:
>
> [sorry, I hit send too early]
>
>
> On 2023-10-23 11:15, Christian König wrote:
>> Am 23.10.23 um 15:06 schrieb Daniel Tang:
>>> That commit causes the screen to freeze a few moments after running
>>> clinfo on v6.6-rc7 and ROCm 5.6. Sometimes the rest of the computer
>>> including ssh also freezes. On v6.5-rc1, it only results in a NULL 
>>> pointer
>>> deference message in dmesg and the process to become a zombie whose
>>> unkillableness prevents shutdown without REISUB. Although llama.cpp and
>>> hashcat were working in v6.2 and ROCm 5.6, broke, and are not fixed by
>>> this revert, pytorch-rocm is now working with stability and without
>>> whole-computer freezes caused by any accidental running of clinfo.
>>>
>>> This reverts commit 1d7776cc148b9f2f3ebaf1181662ba695a29f639.
>>
>> That result doesn't make much sense. Felix please correct me, but 
>> AFAIK the ATS stuff was completely removed by now.
>>
>> Are you sure that this is pure v6.6-rc7 and not some other patches 
>> applied? If yes than we must have missed something.
>
> This revert doesn't really affect systems with ATS. It moves the 
> sanity check back out of the ATS-specific code.

Ah! I've read the code wrong, that makes much more sense now.

>
> The Null pointer dereference in the bug report comes from the CPU page 
> table update code:
> [10089.267556] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [10089.267563] #PF: supervisor write access in kernel mode
> [10089.267566] #PF: error_code(0x0002) - not-present page
> [10089.267569] PGD 0 P4D 0
> [10089.267574] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [10089.267578] CPU: 23 PID: 18191 Comm: clinfo Tainted: G           OE      6.5.0-9-generic #9-Ubuntu
> [10089.267582] Hardware name: Micro-Star International Co., Ltd. MS-7C37/X570-A PRO (MS-7C37), BIOS H.I0 08/10/2022
> [10089.267585] RIP: 0010:amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
> [10089.267820] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 48 b8 00 f0 ff ff ff ff 00 00 55 48 21 c1 8d 04 d5 00 00 00 00 4c 09 c1 48 01 c6 48 89 e5 <48> 89 0e 31 c0 5d 31 d2 31 c9 31 f6 45 31 c0 e9 89 7e 27 fb 66 0f
> [10089.267823] RSP: 0018:ffffb49805eeb8b0 EFLAGS: 00010246
> [10089.267827] RAX: 0000000000000000 RBX: 0000000000200000 RCX: 0040000000000480
> [10089.267830] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9890d4380000
> [10089.267832] RBP: ffffb49805eeb8b0 R08: 0040000000000480 R09: 0000000000200000
> [10089.267835] R10: 0000000800100200 R11: 0000000800100200 R12: ffffb49805eeba98
> [10089.267837] R13: 0000000000000001 R14: 0000000000200000 R15: 0000000000000001
> [10089.267840] FS:  00007f8ca9f09740(0000) GS:ffff9897befc0000(0000) knlGS:0000000000000000
> [10089.267843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10089.267846] CR2: 0000000000000000 CR3: 00000002e0746000 CR4: 0000000000750ee0
> [10089.267849] PKRU: 55555554
> [10089.267851] Call Trace:
> [10089.267853]  <TASK>
> [10089.267858]  ? show_regs+0x6d/0x80
> [10089.267865]  ? __die+0x24/0x80
> [10089.267870]  ? page_fault_oops+0x99/0x1b0
> [10089.267876]  ? do_user_addr_fault+0x316/0x6b0
> [10089.267879]  ? srso_alias_return_thunk+0x5/0x7f
> [10089.267884]  ? scsi_dispatch_cmd+0x91/0x240
> [10089.267891]  ? exc_page_fault+0x83/0x1b0
> [10089.267896]  ? asm_exc_page_fault+0x27/0x30
> [10089.267904]  ? amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
> [10089.268140]  amdgpu_vm_cpu_update+0xa9/0x130 [amdgpu]
> ...
> This revert is just a roundabout way of disabling CPU page table 
> updates for compute VMs. But I don't think it really addresses the 
> root cause.

Yeah, completely agree. Looks like some page tables isn't CPU accessible 
for some reason.

Going to take a look when I have time.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Closes: https://github.com/RadeonOpenCompute/ROCm/issues/2596
>>> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------
>>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 82f25996ff5e..602f311ab766 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2243,16 +2243,16 @@ int amdgpu_vm_make_compute(struct 
>>> amdgpu_device *adev, struct amdgpu_vm *vm)
>>>       if (r)
>>>           return r;
>>>   +    /* Sanity checks */
>>> +    if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
>>> +        r = -EINVAL;
>>> +        goto unreserve_bo;
>>> +    }
>>> +
>>>       /* Check if PD needs to be reinitialized and do it before
>>>        * changing any other state, in case it fails.
>>>        */
>>>       if (pte_support_ats != vm->pte_support_ats) {
>>> -        /* Sanity checks */
>>> -        if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
>>> -            r = -EINVAL;
>>> -            goto unreserve_bo;
>>> -        }
>>> -
>>>           vm->pte_support_ats = pte_support_ats;
>>>           r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
>>>                          false);
>>> -- 2.40.1
>>>
>>>
>>>
>>

--------------kafbGxggMVR1jcPaQdZ3mkAE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 24.10.23 um 01:41 schrieb Felix Kuehling:<br>
    <blockquote type="cite"
      cite="mid:5e2c00e0-5d9c-4583-95ab-a0929e01e877@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p>[sorry, I hit send too early]</p>
      <p><br>
      </p>
      On 2023-10-23 11:15, Christian König wrote:<br>
      <blockquote type="cite">Am 23.10.23 um 15:06 schrieb Daniel Tang:<br>
        <blockquote type="cite">That commit causes the screen to freeze
          a few moments after running<br>
          clinfo on v6.6-rc7 and ROCm 5.6. Sometimes the rest of the
          computer<br>
          including ssh also freezes. On v6.5-rc1, it only results in a
          NULL pointer<br>
          deference message in dmesg and the process to become a zombie
          whose<br>
          unkillableness prevents shutdown without REISUB. Although
          llama.cpp and<br>
          hashcat were working in v6.2 and ROCm 5.6, broke, and are not
          fixed by<br>
          this revert, pytorch-rocm is now working with stability and
          without<br>
          whole-computer freezes caused by any accidental running of
          clinfo.<br>
          <br>
          This reverts commit 1d7776cc148b9f2f3ebaf1181662ba695a29f639.<br>
        </blockquote>
        <br>
        That result doesn't make much sense. Felix please correct me,
        but AFAIK the ATS stuff was completely removed by now.<br>
        <br>
        Are you sure that this is pure v6.6-rc7 and not some other
        patches applied? If yes than we must have missed something.<br>
      </blockquote>
      <br>
      This revert doesn't really affect systems with ATS. It moves the
      sanity check back out of the ATS-specific code.<br>
    </blockquote>
    <br>
    Ah! I've read the code wrong, that makes much more sense now.<br>
    <br>
    <blockquote type="cite"
      cite="mid:5e2c00e0-5d9c-4583-95ab-a0929e01e877@amd.com"> <br>
      The Null pointer dereference in the bug report comes from the CPU
      page table update code:<br>
      <pre>[10089.267556] BUG: kernel NULL pointer dereference, address: 0000000000000000
[10089.267563] #PF: supervisor write access in kernel mode
[10089.267566] #PF: error_code(0x0002) - not-present page
[10089.267569] PGD 0 P4D 0 
[10089.267574] Oops: 0002 [#1] PREEMPT SMP NOPTI
[10089.267578] CPU: 23 PID: 18191 Comm: clinfo Tainted: G           OE      6.5.0-9-generic #9-Ubuntu
[10089.267582] Hardware name: Micro-Star International Co., Ltd. MS-7C37/X570-A PRO (MS-7C37), BIOS H.I0 08/10/2022
[10089.267585] RIP: 0010:amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
[10089.267820] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 48 b8 00 f0 ff ff ff ff 00 00 55 48 21 c1 8d 04 d5 00 00 00 00 4c 09 c1 48 01 c6 48 89 e5 &lt;48&gt; 89 0e 31 c0 5d 31 d2 31 c9 31 f6 45 31 c0 e9 89 7e 27 fb 66 0f
[10089.267823] RSP: 0018:ffffb49805eeb8b0 EFLAGS: 00010246
[10089.267827] RAX: 0000000000000000 RBX: 0000000000200000 RCX: 0040000000000480
[10089.267830] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9890d4380000
[10089.267832] RBP: ffffb49805eeb8b0 R08: 0040000000000480 R09: 0000000000200000
[10089.267835] R10: 0000000800100200 R11: 0000000800100200 R12: ffffb49805eeba98
[10089.267837] R13: 0000000000000001 R14: 0000000000200000 R15: 0000000000000001
[10089.267840] FS:  00007f8ca9f09740(0000) GS:ffff9897befc0000(0000) knlGS:0000000000000000
[10089.267843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10089.267846] CR2: 0000000000000000 CR3: 00000002e0746000 CR4: 0000000000750ee0
[10089.267849] PKRU: 55555554
[10089.267851] Call Trace:
[10089.267853]  &lt;TASK&gt;
[10089.267858]  ? show_regs+0x6d/0x80
[10089.267865]  ? __die+0x24/0x80
[10089.267870]  ? page_fault_oops+0x99/0x1b0
[10089.267876]  ? do_user_addr_fault+0x316/0x6b0
[10089.267879]  ? srso_alias_return_thunk+0x5/0x7f
[10089.267884]  ? scsi_dispatch_cmd+0x91/0x240
[10089.267891]  ? exc_page_fault+0x83/0x1b0
[10089.267896]  ? asm_exc_page_fault+0x27/0x30
[10089.267904]  ? amdgpu_gmc_set_pte_pde+0x23/0x40 [amdgpu]
[10089.268140]  amdgpu_vm_cpu_update+0xa9/0x130 [amdgpu]
...
</pre>
      This revert is just a roundabout way of disabling CPU page table
      updates for compute VMs. But I don't think it really addresses the
      root cause.<br>
    </blockquote>
    <br>
    Yeah, completely agree. Looks like some page tables isn't CPU
    accessible for some reason.<br>
    <br>
    Going to take a look when I have time.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:5e2c00e0-5d9c-4583-95ab-a0929e01e877@amd.com"> <br>
      Regards,<br>
        Felix
      <p><br>
      </p>
      <blockquote type="cite"><br>
        Regards,<br>
        Christian.<br>
        <br>
        <blockquote type="cite"><br>
          Closes: <a class="moz-txt-link-freetext"
            href="https://github.com/RadeonOpenCompute/ROCm/issues/2596"
            moz-do-not-send="true">https://github.com/RadeonOpenCompute/ROCm/issues/2596</a><br>
          Signed-off-by: Daniel Tang <a class="moz-txt-link-rfc2396E"
            href="mailto:danielzgtg.opensource@gmail.com"
            moz-do-not-send="true">&lt;danielzgtg.opensource@gmail.com&gt;</a><br>
          ---<br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------<br>
            1 file changed, 6 insertions(+), 6 deletions(-)<br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          index 82f25996ff5e..602f311ab766 100644<br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
          @@ -2243,16 +2243,16 @@ int amdgpu_vm_make_compute(struct
          amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                if (r)<br>
                    return r;<br>
            +    /* Sanity checks */<br>
          +    if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {<br>
          +        r = -EINVAL;<br>
          +        goto unreserve_bo;<br>
          +    }<br>
          +<br>
                /* Check if PD needs to be reinitialized and do it
          before<br>
                 * changing any other state, in case it fails.<br>
                 */<br>
                if (pte_support_ats != vm-&gt;pte_support_ats) {<br>
          -        /* Sanity checks */<br>
          -        if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {<br>
          -            r = -EINVAL;<br>
          -            goto unreserve_bo;<br>
          -        }<br>
          -<br>
                    vm-&gt;pte_support_ats = pte_support_ats;<br>
                    r = amdgpu_vm_pt_clear(adev, vm,
          to_amdgpu_bo_vm(vm-&gt;root.bo),<br>
                                   false);<br>
          -- 2.40.1<br>
          <br>
          <br>
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------kafbGxggMVR1jcPaQdZ3mkAE--
