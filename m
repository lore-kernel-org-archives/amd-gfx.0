Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88254C6FD1C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 08:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D716710E187;
	Mon,  6 Mar 2023 08:28:16 +0000 (UTC)
X-Greylist: delayed 551 seconds by postgrey-1.36 at gabe;
 Mon, 06 Mar 2023 03:10:25 UTC
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD0810E0A1;
 Mon,  6 Mar 2023 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1678071669; bh=EbH03jrrOzBLsi9CxIDaKXS+8fNPxunUKGjU5HqZpDY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kzYJX/GcEVnsGZdwKdSl7fJ4YVn4LuWDDyRUshDQmD96oNz4EkLA9xG0XECPRtV3j
 qTB2zNYuCgXnOZ9oHHdoZQ4efyBpvSs2hMq9dgPka0CkiMblBQ/XuNoSBCnGuy+2Fg
 zCMgwCQQ2UGz2PoLHOSGfvlKSvheBWQWMdJTbN5c=
Received: from [100.100.57.122] (unknown [58.34.185.106])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D4B89600A6;
 Mon,  6 Mar 2023 11:01:08 +0800 (CST)
Message-ID: <37d1184d-bdbd-f20c-e9c8-285912e44eac@xen0n.name>
Date: Mon, 6 Mar 2023 11:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Use uncached ioremap() for LoongArch
Content-Language: en-US
To: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230305052137.4030323-1-chenhuacai@loongson.cn>
 <8554af4a-5592-2102-7c8c-21f4dec3aff2@amd.com>
 <CAAhV-H45Hpuyqhxr5EMOZRgapp6hWmG8jYDykXDVjbs1bLt-Jw@mail.gmail.com>
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H45Hpuyqhxr5EMOZRgapp6hWmG8jYDykXDVjbs1bLt-Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Mar 2023 08:28:13 +0000
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
Cc: David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Xuefeng Li <lixuefeng@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023/3/6 10:49, Huacai Chen wrote:
> Hi, Christian,
> 
> On Mon, Mar 6, 2023 at 12:40 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Am 05.03.23 um 06:21 schrieb Huacai Chen:
>>> LoongArch maintains cache coherency in hardware, but its WUC attribute
>>> (Weak-ordered UnCached, which is similar to WC) is out of the scope of
>>> cache coherency machanism. This means WUC can only used for write-only
>>> memory regions. So use uncached ioremap() for LoongArch in the amdgpu
>>> driver.
>>
>> Well NAK. This is leaking platform dependencies into the driver code.
> Then is it acceptable to let ioremap() depend on drm_arch_can_wc_memory()?

Note: he's likely meaning "is it acceptable to use 
drm_arch_can_wc_memory() to decide between ioremap() and ioremap_wc()".

Although I doubt it's acceptable to you (driver) folks either, because 
while drm_arch_can_wc_memory() does isolate platform details from driver 
proper, it's still papering over platform PCIe violation in VRAM domain. 
Still better than having platform defines though.

Also making use of drm_arch_can_wc_memory might fix this fdo issue [1] 
on aarch64 too (where I replied earlier). It seems people simply can't 
stop inventing such micro-architectures sadly...

[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/2313

>>
>> When you have a limitation that ioremap_wc() can't guarantee read/write
>> ordering then that's pretty clearly a platform bug and you would need to
>> apply this workaround to all drivers using ioremap_wc() which isn't
>> really feasible.
>>

I agree in this case perhaps all of ioremap_wc() usages would have to 
degrade into ioremap() for correctness on such platforms. In which case 
amdgpu wouldn't have to be individually called out / touched anyway. 
Whether this is easily doable/upstreamable is another question though...

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

