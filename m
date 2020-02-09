Return-Path: <SRS0=qiLQ=35=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989ECC35250
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Feb 2020 08:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E6E20733
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Feb 2020 08:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsarnbHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E6E20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79E96E560;
	Sun,  9 Feb 2020 08:31:36 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9D76E560
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Feb 2020 08:31:35 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m16so3733880wrx.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Feb 2020 00:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=AeXlOZCWtdPWzjS0tCcvFzWnRtaOrzWuOKqbR+JJwwM=;
 b=dsarnbHW86i8xK/09PORE6EPfgMGjo9QuHWr5GFozUM6Rc5dxAztFk3wwD4xf8+ohe
 FfU3uDB9Sm1BPrjIRACVe13JvBmbuC8pXLGdljL4UWdvnZaTWJlHYAzMJ5Pj6JBj9R0M
 v130On7uQujFlNe1EagUyB2MlRkOussqWDxom+xBsT1ZqV9N+CFUYv3SRpsfb/nOb8yT
 BFQvkCZOYqyDF+URD5m5g34PVg4W84Uq/U9g68SWKrhsVfqBdKJb2osRgyPfPmMZCYm1
 tYax2MfySg036f+TDVgoGVXkAwHVcgCg0QoJY3de1wkR0KLA0yRmDTeL90wfFzE5uRNJ
 xUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=AeXlOZCWtdPWzjS0tCcvFzWnRtaOrzWuOKqbR+JJwwM=;
 b=KY34j7AOOh4wTf96IDgmxnJpLa6LGR99GMsgnq++kQxuXq6z92/hGlkBYfTDGWkIIB
 rh/NjPYGT8aNs+7Ougruq4Yo+F+hbfUhym7U4Udxk5WP2Eo70bkayKVQr7fUavZVRx++
 gIUr6aSYJ8F5WsT3Zt4zyuDuMStSHisSEC5ZvceWUi3R/FGOiXYBYx+D7VojGMwL1Fos
 ZSP6MGrsijA/jgVgbWNCj9Kuo9nmq8qDSX2KXRuC9taZXmglM/EFdxi5VgukYzCoJntp
 2d1WesRJePVS+h3nwRCo6r0Nf1Y1yXNh1r0sOeH/8l+k9SYC+Ufpu8v3CZJyuBA4965u
 0zCw==
X-Gm-Message-State: APjAAAWuCmEI02VaFC5Lxw/8kan73imPuAFIb0pc8nxCPq23lPD4dy8G
 YTrA+Y3oDR3OC7Er6phItJoYiHHx
X-Google-Smtp-Source: APXvYqzfMMwD8pkDVa8vh2taLVLpk9va/B9MgGHx7SI6gAET9ES1nFNr/owXRyXuu0nasjKLFNGhig==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr9950573wro.368.1581236474708; 
 Sun, 09 Feb 2020 00:21:14 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t81sm10479105wmg.6.2020.02.09.00.21.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Feb 2020 00:21:14 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <SN6PR12MB2800EB2C9B3EE8BC3DC6B664871E0@SN6PR12MB2800.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cb22f498-f1c5-fa7b-ffb7-643ef9a584ff@gmail.com>
Date: Sun, 9 Feb 2020 09:21:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <SN6PR12MB2800EB2C9B3EE8BC3DC6B664871E0@SN6PR12MB2800.namprd12.prod.outlook.com>
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
Reply-To: christian.koenig@amd.com
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.02.20 um 03:52 schrieb Pan, Xinhui:
> hit panic when we update the page tables.
>
> <1>[  122.103290] BUG: kernel NULL pointer dereference, address: 0000000000000008
> <1>[  122.103348] #PF: supervisor read access in kernel mode
> <1>[  122.103376] #PF: error_code(0x0000) - not-present page
> <6>[  122.103403] PGD 0 P4D 0
> <4>[  122.103421] Oops: 0000 [#1] SMP PTI
> <4>[  122.103442] CPU: 13 PID: 2133 Comm: kfdtest Tainted: G           OE     5.4.0-rc7+ #7
> <4>[  122.103480] Hardware name: Supermicro SYS-7048GR-TR/X10DRG-Q, BIOS 3.0b 03/09/2018
> <4>[  122.103657] RIP: 0010:amdgpu_vm_update_pdes+0x140/0x330 [amdgpu]
> <4>[  122.103689] Code: 03 4c 89 73 08 49 89 9d c8 00 00 00 48 8b 7b f0 c6 43 10 00 45 31 c0 48 8b 87 28 04 00 00 48 85 c0 74 07 4c 8b 80 20 04 00 00 <4d> 8b 70 08 31 f6 49 8b 86 28 04 00 00 48 85 c0 74 0f 48 8b 80 28
> <4>[  122.103769] RSP: 0018:ffffb49a0a6a3a98 EFLAGS: 00010246
> <4>[  122.103797] RAX: 0000000000000000 RBX: ffff9020f823c148 RCX: dead000000000122
> <4>[  122.103831] RDX: ffff9020ece70018 RSI: ffff9020f823c0c8 RDI: ffff9010ca31c800
> <4>[  122.103865] RBP: ffffb49a0a6a3b38 R08: 0000000000000000 R09: 0000000000000001
> <4>[  122.103899] R10: 000000006044f994 R11: 00000000df57fb58 R12: ffff9020f823c000
> <4>[  122.103933] R13: ffff9020f823c000 R14: ffff9020f823c0c8 R15: ffff9010d5d20000
> <4>[  122.103968] FS:  00007f32c83dc780(0000) GS:ffff9020ff380000(0000) knlGS:0000000000000000
> <4>[  122.104006] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  122.104035] CR2: 0000000000000008 CR3: 0000002036bba005 CR4: 00000000003606e0
> <4>[  122.104069] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4>[  122.104103] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> <4>[  122.104137] Call Trace:
> <4>[  122.104241]  vm_update_pds+0x31/0x50 [amdgpu]
> <4>[  122.104347]  amdgpu_amdkfd_gpuvm_map_memory_to_gpu+0x2ef/0x690 [amdgpu]
> <4>[  122.104466]  kfd_process_alloc_gpuvm+0x98/0x190 [amdgpu]
> <4>[  122.104576]  kfd_process_device_init_vm.part.8+0xf3/0x1f0 [amdgpu]
> <4>[  122.104688]  kfd_process_device_init_vm+0x24/0x30 [amdgpu]
> <4>[  122.104794]  kfd_ioctl_acquire_vm+0xa4/0xc0 [amdgpu]
> <4>[  122.104900]  kfd_ioctl+0x277/0x500 [amdgpu]
> <4>[  122.105001]  ? kfd_ioctl_free_memory_of_gpu+0xc0/0xc0 [amdgpu]
> <4>[  122.105039]  ? rcu_read_lock_sched_held+0x4f/0x80
> <4>[  122.105068]  ? kmem_cache_free+0x2ba/0x300
> <4>[  122.105093]  ? vm_area_free+0x18/0x20
> <4>[  122.105117]  ? find_held_lock+0x35/0xa0
> <4>[  122.105143]  do_vfs_ioctl+0xa9/0x6f0
> <4>[  122.106001]  ksys_ioctl+0x75/0x80
> <4>[  122.106802]  ? do_syscall_64+0x17/0x230
> <4>[  122.107605]  __x64_sys_ioctl+0x1a/0x20
> <4>[  122.108378]  do_syscall_64+0x5f/0x230
> <4>[  122.109118]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> <4>[  122.109842] RIP: 0033:0x7f32c6b495d7
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3195bc90985a..3c388fdf335c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2619,7 +2619,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>   			continue;
>   		bo_base->moved = true;
>   
> -		if (bo->tbo.type == ttm_bo_type_kernel)
> +		if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)

Good catch, but that would mean that we move the root PD to the moved 
state which in turn is illegal as well.

Maybe better adjust amdgpu_vm_bo_relocated() to move the root PD to the 
idle state instead.

Christian.


>   			amdgpu_vm_bo_relocated(bo_base);
>   		else if (bo->tbo.base.resv == vm->root.base.bo->tbo.base.resv)
>   			amdgpu_vm_bo_moved(bo_base);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
