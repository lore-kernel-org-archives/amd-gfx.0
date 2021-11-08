Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5481EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 10:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D9B61207
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 10:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19D9B61207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B596EDA2;
	Mon,  8 Nov 2021 10:14:19 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676D56EDA2
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 10:14:18 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id w29so14315387wra.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Nov 2021 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=BcBBzUQOqRnY7W5VmQfL8mqzrVkhaxzw0Boa2z9Ti7I=;
 b=fk/jY2nkr7fahORwY5Jf0BTHyIrEtZ77LcR0S/skDU1+vXW5IX3DY78Nqo7Yzy1QbL
 9FrCiiVK24vD76j0MuRgdQPuxv2dlKJrbbfHcgs/TQZSIpr55aHTbhcl6pY6P6ASf6KA
 K/I5X/ikkwAaQDjDaDw9EwUYYrvkQaMQv4hSwzlOg9TeCcQE8jQnwetWmoEBr0kzWoob
 V5JOcJRQNXMMhM5nma+WcpnWo0zzRDfSsKX4/x9QpjrVDQ8fdm6YhMKcOAOpxXE0oUXw
 rzqR9kXBcl2R5/tRfGjxDYr6pXjTxnoB6bm1a/VW1zPMMbXsqLKz4QytoNl2xMf60HSL
 15Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BcBBzUQOqRnY7W5VmQfL8mqzrVkhaxzw0Boa2z9Ti7I=;
 b=bs2YKkxEaVla+m8BcMlTH7+jizd2/qcZlR4cZ4DRUzPETFneg3N53p72tjhfcSV+oq
 msaW3+X940ud10GRgq9NCwHAJX/tHXgsy5AJHfNGuHuv/4/rOrbeHRPX41TOtkQeB8KY
 tVwbdMzcM59NNIabdQTP0t1M5Tb9N7DJmzFArl2tAAukz+SyCUWtXowh6nhcSPvTzdx/
 U4t3LZl3anOH7a13MqaqKwrWlvy2Ot0LceIj3iTzehlu1ErSxgCda1LN/rf3EO6O4TGS
 /72LmKI36iRKl/a0c/5D+V9Jqv/iNod0CAnW8KoWAZWAyzv6iGLT+YJnTRdzB/a5Fn8d
 HPMQ==
X-Gm-Message-State: AOAM533mYTKbBEch3JVne3R3boTCwYJPmoBKUT3DHUQS8ufy2rGUHADP
 1wSwCi1wdDh9IQXlvz1EniwvLuFNZJw=
X-Google-Smtp-Source: ABdhPJzjny+MUmLo4sJAg1mHYo+BJuWhoXrs8AQYqD/7XG5ol4nZpOMzUSlD/SyFjuIYa9MaHwFHeQ==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr88020697wrd.373.1636366456922; 
 Mon, 08 Nov 2021 02:14:16 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:308a:d18e:268b:408f?
 ([2a02:908:1252:fb60:308a:d18e:268b:408f])
 by smtp.gmail.com with ESMTPSA id l5sm19050564wms.16.2021.11.08.02.14.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Nov 2021 02:14:16 -0800 (PST)
Subject: Re: Kernel WARNING at
To: Zzy Wysm <zzy@zzywysm.com>, amd-gfx@lists.freedesktop.org
References: <3253FEEC-4FF1-48A5-B14B-9005052111BE@zzywysm.com>
 <8A927DC6-6EF9-4A73-BC2D-CC45BAEB3F4A@zzywysm.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b542de25-3d71-9860-92ec-28cb5b62cb42@gmail.com>
Date: Mon, 8 Nov 2021 11:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8A927DC6-6EF9-4A73-BC2D-CC45BAEB3F4A@zzywysm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Mhm, good question. Looks like a refcount leak somewhere.

Is that reproducible? If yes could you bisect?

In general I suggest to try to reproduce it on the latest bleeding edge 
code first.

Thanks for the notice,
Christian.

Am 05.11.21 um 04:13 schrieb Zzy Wysm:
> Another use-after-free on the same computer that looks like it’s in amdgpu:
>
> [ 2101.168138] ------------[ cut here ]------------
> [ 2101.168144] refcount_t: underflow; use-after-free.
> [ 2101.168162] WARNING: CPU: 4 PID: 965 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
> [ 2101.168167] CPU: 4 PID: 965 Comm: Xorg Tainted: G                T 5.10.77 #1
> [ 2101.168169] Hardware name: Supermicro Super Server/H11SSL-NC, BIOS 2.1 02/21/2020
> [ 2101.168174] RIP: 0010:refcount_warn_saturate+0xa6/0xf0
> [ 2101.168177] Code: 05 9f 6b f3 01 01 e8 4a 0d 9d 00 0f 0b c3 80 3d 8d 6b f3 01 00 75 95 48 c7 c7 e0 ee fc ad c6 05 7d 6b f3 01 01 e8 2b 0d 9d 00 <0f> 0b c3 80 3d 6c 6b f3 01 00 0f 85 72 ff ff ff 48 c7 c7 38 ef fc
> [ 2101.168180] RSP: 0018:ffffb3778216fdc0 EFLAGS: 00010282
> [ 2101.168183] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
> [ 2101.168186] RDX: 0000000000000027 RSI: 00000000fffeffff RDI: ffff8ddb4e212ec8
> [ 2101.168187] RBP: ffff8dbdf149f680 R08: ffff8ddb4e212ec0 R09: ffffb3778216fbe8
> [ 2101.168189] R10: 0000000000000001 R11: 0000000000000001 R12: 00000000ffffffff
> [ 2101.168191] R13: ffff8dbca0b50c00 R14: ffff8dbca0b50c58 R15: 0000000000000000
> [ 2101.168194] FS:  000071af94f3fa40(0000) GS:ffff8ddb4e200000(0000) knlGS:0000000000000000
> [ 2101.168196] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2101.168198] CR2: 000071af0c7a9000 CR3: 00000015680a2000 CR4: 0000000000350ee0
> [ 2101.168199] Call Trace:
> [ 2101.168206]  dma_resv_list_free.part.0+0x66/0x70
> [ 2101.168212]  drm_gem_object_release+0x28/0x50
> [ 2101.168218]  amdgpu_bo_destroy+0x60/0x100
> [ 2101.168223]  ttm_bo_release+0x1de/0x310
> [ 2101.168226]  amdgpu_bo_unref+0x15/0x20
> [ 2101.168230]  amdgpu_gem_object_free+0x2b/0x50
> [ 2101.168236]  drm_gem_dmabuf_release+0x31/0x50
> [ 2101.168239]  dma_buf_release+0x35/0x70
> [ 2101.168244]  __dentry_kill+0xe5/0x150
> [ 2101.168249]  __fput+0xe1/0x250
> [ 2101.168254]  task_work_run+0x5a/0x90
> [ 2101.168260]  exit_to_user_mode_prepare+0xbe/0xc0
> [ 2101.168266]  syscall_exit_to_user_mode+0x22/0xf0
> [ 2101.168271]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 2101.168274] RIP: 0033:0x71af953aacc7
> [ 2101.168278] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
> [ 2101.168280] RSP: 002b:00007ffd1fbd3628 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 2101.168284] RAX: 0000000000000000 RBX: 00007ffd1fbd3660 RCX: 000071af953aacc7
> [ 2101.168286] RDX: 00007ffd1fbd3660 RSI: 0000000040086409 RDI: 0000000000000010
> [ 2101.168288] RBP: 0000000040086409 R08: 0000000000000007 R09: 000000000000000e
> [ 2101.168290] R10: 000000000000001b R11: 0000000000000246 R12: 0000561c5b999b98
> [ 2101.168292] R13: 0000000000000010 R14: 0000561c5ba2b72c R15: 00007ffd1fbd36a0
> [ 2101.168295] ---[ end trace 921c49c63d8e1053 ]—
>
> zzy
>
>
>> On Nov 4, 2021, at 9:34 PM, Zzy Wysm <zzy@zzywysm.com> wrote:
>>
>> I found the following warning in my log this evening.  I don’t know if or how it can be reproduced.
>>
>> Linux 5.10.77 amd64.  Kernel config attached.  (The kernel taint is merely because of the struct randomization plugin.)
>>
>> zzy
>>
>> ..
>>
>> kernel: ------------[ cut here ]------------
>> kernel: refcount_t: addition on 0; use-after-free.
>> kernel: WARNING: CPU: 3 PID: 957 at lib/refcount.c:25 refcount_warn_saturate+0x68/0xf0
>> kernel: CPU: 3 PID: 957 Comm: Xorg Tainted: G        W       T 5.10.77 #1
>> kernel: Hardware name: Supermicro Super Server/H11SSL-NC, BIOS 2.1 02/21/2020
>> kernel: RIP: 0010:refcount_warn_saturate+0x68/0xf0
>> kernel: Code: 05 2c 9f f5 01 01 e8 83 82 9e 00 0f 0b c3 80 3d 1c 9f f5 01 00 75 d3 48 c7 c7 f0 2e 1d 96 c6 05 0c 9f f5 01 01 e8 64 82 9e 00 <0f> 0b c3 80 3d ff 9e f5 01 00 75 d3 48 c7 c7 f0 2e 1d 96 c6 05 0c 9f f5 01 01 e8 64 82 9e 00 <0f> 0b c3 80 3d ff 9e f5 01 00 75 b4 48 c7 c7 c8 2e 1d 96 c6 05 ef
>> kernel: RSP: 0018:ffffb4f201cc3c00 EFLAGS: 00010286
>> kernel: RAX: 0000000000000000 RBX: ffff8a0c00ede458 RCX: 0000000000000027
>> kernel: RDX: 0000000000000027 RSI: 00000000fffeffff RDI: ffff8a2ace192e88
>> kernel: RBP: ffffb4f201cc3d38 R08: ffff8a2ace192e80 R09: ffffb4f201cc3a28
>> kernel: R10: 0000000000000001 R11: 0000000000000001 R12: ffff8a0c911e5000
>> kernel: R13: ffff8a0cba1fc580 R14: ffffb4f201cc3cc8 R15: ffff8a0c1a440000
>> kernel: FS:  0000000000000000(0000) GS:ffff8a2ace180000(0000) knlGS:0000000000000000
>> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> kernel: CR2: 0000736ef80ab660 CR3: 00000011da80c000 CR4: 0000000000350ee0
>> kernel: Call Trace:
>> kernel:  dma_resv_add_shared_fence+0x122/0x180
>> kernel:  amdgpu_gem_object_close+0x1c3/0x250
>> kernel:  drm_gem_object_release_handle+0x2b/0x90
>> kernel:  ? drm_gem_object_handle_put_unlocked+0xc0/0xc0
>> kernel:  idr_for_each+0x70/0xe0
>> kernel:  drm_gem_release+0x17/0x20
>> kernel:  drm_file_free.part.0+0x273/0x280
>> kernel:  drm_release+0x60/0xe0
>> kernel:  __fput+0x96/0x240
>> kernel:  task_work_run+0x5a/0x90
>> kernel:  do_exit+0x34e/0xaf0
>> kernel:  do_group_exit+0x34/0xb0
>> kernel:  __x64_sys_exit_group+0xf/0x10
>> kernel:  do_syscall_64+0x33/0x40
>> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> kernel: RIP: 0033:0x736f1c33a699
>> kernel: Code: Unable to access opcode bytes at RIP 0x736f1c33a66f.
>> kernel: RSP: 002b:00007ffce40b21e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>> kernel: RAX: ffffffffffffffda RBX: 0000736f1c42f610 RCX: 0000736f1c33a699
>> kernel: RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
>> kernel: RBP: 0000000000000000 R08: fffffffffffffc80 R09: 0000000000000000
>> kernel: R10: 0000736f1cdbaa40 R11: 0000000000000246 R12: 0000736f1c42f610
>> kernel: R13: 0000000000000b14 R14: 0000736f1c42fae8 R15: 0000000000000000
>> kernel: ---[ end trace 52a8b244b766437f ]—
>>
>> ..
>>
>> <kernel-warning-config>
>>

