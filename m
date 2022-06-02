Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DBCC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 18:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74B2113592;
	Thu,  2 Jun 2022 18:55:45 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1652211358A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 18:55:44 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id v1so989209ejg.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=oaEhO2FV6xt9uxLW6/eglQvoqwM7Wcz3cScTxNbXGsM=;
 b=P20/vXCnY9cTrhyMD3UKovx+YY8H4ZrxBt3QxB2zZqK/t7emu45VNnnojoMLo4O8wb
 rx7AsY3MP8pniCE30ZCEQGoO4dKWUxNYnyY+lgyPiCwTZlU3+VERLbRZc+E9YhvKy2So
 lK2qiwLwcvEE3Bu3AAOwlKlGU08BjJC3wYP1fchksjZyhfM9LBfdN3cZjdrTMdThAU0a
 WSovAEIxkVWTS4yApv5fCm+/rxIu4qBRluUZ//bDI0b26LsP0s9T38Jrsc6xBdVDjtm/
 dWiDR1DD4ZQqbwX2iaDJ23UZbcIBnsjhEWc0rtwVc0gix9tGwT6XG0mqCa8fP75ZzexR
 2/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=oaEhO2FV6xt9uxLW6/eglQvoqwM7Wcz3cScTxNbXGsM=;
 b=BeIHfYhXoX3hl6LDRNY5QXYybnP6XQV2/Km0KsbEjU3iaZwB2IQjZNOpvcn1exwQdV
 19fHtb1B2ygyQ2BL/34blp01ENdEIf5+RymYnm6F/sNmtm4D3GyqeluLt8nUNjq6vjwR
 t1/gNQZel41IJn96Lwgq4SvYnUSoaJG4e1GCYq4AxN3rHwOXmPhUGIWsLkVSauFgjXZS
 IMoXSmjCdB2F+F10uSXZXQovVwuDA2Phw9Hd2XH1tMijJilx90kXLRR3/kllWRyvPeIF
 h+e+q+K8H5wi8gEWPuLWaO9fVQqKL/7mWiN7CypMNmwZFqlGVtdwBRc7RbGsq3S/mDo/
 t9NA==
X-Gm-Message-State: AOAM532qPTDRy1sLJmdpOxzjscWNsqPAC5W5TN4Do8kPY41KZCDXusVr
 NsYpA8DcoV4qmiu2CrXaxCQ=
X-Google-Smtp-Source: ABdhPJxZhtb6OMjO00E20u1xUGn2iqDaM/fzsKjw6LNFjlB5go03CFTSsLOY0JK6oKpxxHrEaP9i5w==
X-Received: by 2002:a17:907:d27:b0:6ff:d8b:9564 with SMTP id
 gn39-20020a1709070d2700b006ff0d8b9564mr5485968ejc.364.1654196142572; 
 Thu, 02 Jun 2022 11:55:42 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:80:e84d:46c:65f5?
 ([2a02:908:1256:79a0:80:e84d:46c:65f5])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a170906368e00b006fec5cef701sm2001346ejc.197.2022.06.02.11.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jun 2022 11:55:42 -0700 (PDT)
Message-ID: <bc546040-cbc5-0193-07d9-0dfe74592598@gmail.com>
Date: Thu, 2 Jun 2022 20:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/ttm: fix bulk move handling during resource init
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>, Alex Deucher <alexdeucher@gmail.com>
References: <20220602154734.7854-1-christian.koenig@amd.com>
 <CADnq5_MopB5aUpzo_iWz5TXbxAxYXttm8L6L_SwFayUPEyZxhw@mail.gmail.com>
 <CAHbf0-FZJnD7PQNFhVkg64XqKvwbuhN115yVFDd8_XG54nD_Ow@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAHbf0-FZJnD7PQNFhVkg64XqKvwbuhN115yVFDd8_XG54nD_Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That's because drm-misc-next is currently broken and needs a backmerge.

Please try this patch on top of drm-next.

Regards,
Christian.

Am 02.06.22 um 20:08 schrieb Mike Lothian:
> Hi
>
> I'm still seeing Null pointers against Linus's tree and drm-misc with this patch
>
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: BUG: kernel NULL pointer
> dereference, address: 0000000000000008
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: #PF: supervisor write
> access in kernel mode
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: #PF: error_code(0x0002) -
> not-present page
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: PGD 11ee04067 P4D
> 11ee04067 PUD 15eccb067 PMD 0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Oops: 0002 [#1] PREEMPT SMP NOPTI
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CPU: 0 PID: 1021 Comm:
> GravityMark.x64 Tainted: G        W         5.18.0-tip+ #3177
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Hardware name: ASUSTeK
> COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.318
> 03/29/2022
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RIP:
> 0010:ttm_resource_init+0x108/0x210
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Code: 48 8b 74 0a 08 48
> 39 de 0f 84 82 00 00 00 48 8b 7b 38 4c 8b 4b 40 4c 8d 44 0a 08 48 8d
> 56 38 4c 89 4f 08 49 89 39 48 8b 4e 38 <48> 89 41 08 48 89 4b 38 48 89
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RSP:
> 0018:ffff888112e73918 EFLAGS: 00010202
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RAX: ffff888206b715d8
> RBX: ffff888206b715a0 RCX: 0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RDX: ffff888206b71cf8
> RSI: ffff888206b71cc0 RDI: ffff888110605b00
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RBP: ffff88816c848c08
> R08: ffff88812235c790 R09: ffff8881306a4bd8
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R10: 0000000000000000
> R11: ffffffff81851320 R12: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R13: ffff888206b715a0
> R14: ffff88816c848c58 R15: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: FS:
> 00007f4c257c1740(0000) GS:ffff888fde400000(0000)
> knlGS:0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> CR3: 00000001183fc000 CR4: 0000000000350ef0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Call Trace:
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  <TASK>
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_vram_mgr_new+0xbb/0x4b0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? ttm_bo_mem_space+0x89/0x1e0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? ttm_bo_validate+0x80/0x1a0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_bo_validate+0xe9/0x2b0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_syncobj_lookup_and_add_to_sync+0xa0/0xa0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_vm_validate_pt_bos+0xce/0x1c0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_parser_bos+0x522/0x6e0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_ioctl+0x7fe/0xd00
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_cs_report_moved_bytes+0x60/0x60
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? drm_ioctl_kernel+0xcb/0x130
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? drm_ioctl+0x2f5/0x400
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_cs_report_moved_bytes+0x60/0x60
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_drm_ioctl+0x42/0x80
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? __x64_sys_ioctl+0x5e/0xa0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? do_syscall_64+0x6a/0x90
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> exit_to_user_mode_prepare+0x19/0x90
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  </TASK>
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Modules linked in:
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: ---[ end trace
> 0000000000000000 ]---
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RIP:
> 0010:ttm_resource_init+0x108/0x210
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Code: 48 8b 74 0a 08 48
> 39 de 0f 84 82 00 00 00 48 8b 7b 38 4c 8b 4b 40 4c 8d 44 0a 08 48 8d
> 56 38 4c 89 4f 08 49 89 39 48 8b 4e 38 <48> 89 41 08 48 89 4b 38 48 89
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RSP:
> 0018:ffff888112e73918 EFLAGS: 00010202
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RAX: ffff888206b715d8
> RBX: ffff888206b715a0 RCX: 0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RDX: ffff888206b71cf8
> RSI: ffff888206b71cc0 RDI: ffff888110605b00
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RBP: ffff88816c848c08
> R08: ffff88812235c790 R09: ffff8881306a4bd8
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R10: 0000000000000000
> R11: ffffffff81851320 R12: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R13: ffff888206b715a0
> R14: ffff88816c848c58 R15: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: FS:
> 00007f4c257c1740(0000) GS:ffff888fde400000(0000)
> knlGS:0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> CR3: 00000001183fc000 CR4: 0000000000350ef0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: note:
> GravityMark.x64[1021] exited with preempt_count 1
>
> On Thu, 2 Jun 2022 at 17:54, Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Thu, Jun 2, 2022 at 11:47 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> The resource must be on the LRU before ttm_lru_bulk_move_add() is called.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> This should at least fix the null pointer in these bugs:
>>
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1992
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2034
>>
>> Alex
>>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_resource.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
>>> index 65889b3caf50..928b9140f3c5 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_resource.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
>>> @@ -169,15 +169,17 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
>>>          res->bus.is_iomem = false;
>>>          res->bus.caching = ttm_cached;
>>>          res->bo = bo;
>>> -       INIT_LIST_HEAD(&res->lru);
>>>
>>>          man = ttm_manager_type(bo->bdev, place->mem_type);
>>>          spin_lock(&bo->bdev->lru_lock);
>>>          man->usage += res->num_pages << PAGE_SHIFT;
>>> -       if (bo->bulk_move)
>>> +       if (bo->bulk_move) {
>>> +               list_add_tail(&res->lru, &man->lru[bo->priority]);
>>>                  ttm_lru_bulk_move_add(bo->bulk_move, res);
>>> -       else
>>> +       } else {
>>> +               INIT_LIST_HEAD(&res->lru);
>>>                  ttm_resource_move_to_lru_tail(res);
>>> +       }
>>>          spin_unlock(&bo->bdev->lru_lock);
>>>   }
>>>   EXPORT_SYMBOL(ttm_resource_init);
>>> --
>>> 2.25.1
>>>

