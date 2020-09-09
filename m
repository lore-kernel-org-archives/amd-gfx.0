Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3062CC433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F13E2078B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 07:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13E2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4576E29E;
	Thu, 10 Sep 2020 07:29:37 +0000 (UTC)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 800116EDBC
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 09:39:24 +0000 (UTC)
Received: from [10.130.0.80] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn961olhf294TAA--.4061S3;
 Wed, 09 Sep 2020 17:39:02 +0800 (CST)
Subject: Re: [PATCH 1/2] drm/radeon: Don't use WC for VRAM if
 !RADEON_GEM_GTT_WC
To: Huacai Chen <chenhc@lemote.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <maz@kernel.org>
References: <1599625320-17637-1-git-send-email-chenhc@lemote.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9fc515b9-bf6d-fa05-880f-1e0b473d1d19@loongson.cn>
Date: Wed, 9 Sep 2020 17:39:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1599625320-17637-1-git-send-email-chenhc@lemote.com>
X-CM-TRANSID: AQAAf9Dxn961olhf294TAA--.4061S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW3JFy7trW5XFy3tF18Zrb_yoW5XrW5pF
 4fC39xJwsIy3yqya97JF4q9FZ8ua18Ga40qry5Gw1Uury3JF4rW393Kr43KrZrXry8W3yf
 tFs7CFnxZ3WYvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
 4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxeT5DUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Mailman-Approved-At: Thu, 10 Sep 2020 07:29:37 +0000
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
Cc: Huacai Chen <chenhuacai@gmail.com>, michel.daenzer@amd.com,
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 amd-gfx@lists.freedesktop.org, Fuxin Zhang <zhangfx@lemote.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/09/2020 12:21 PM, Huacai Chen wrote:
> Though RADEON_GEM_GTT_WC is initially used for GTT, but this flag is
> bound to drm_arch_can_wc_memory(), and if arch doesn't support WC, then
> VRAM should not use WC.

+cc RADEON and AMDGPU DRM DRIVERS maintainer
Alex Deucher <alexander.deucher@amd.com>
Christian K=F6nig <christian.koenig@amd.com>
amd-gfx@lists.freedesktop.org

Hi all,

In the current code, if CONFIG_CPU_LOONGSON64 is set, =

drm_arch_can_wc_memory()
returns false, and then bo->flags clears the flag RADEON_GEM_GTT_WC, so with
this patch, TTM_PL_FLAG_WC of VRAM is removed on the Loongson platform,
the writecombine issue for Loongson64 can be fixed [1].

I find this is done by commit 221004c66a58 ("drm: Loongson-3 doesn't fully
support wc memory"), but I want to know why drm_arch_can_wc_memory() returns
false for Loongson64, is there some historical reasons?

include/drm/drm_cache.h
static inline bool drm_arch_can_wc_memory(void)
{
#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
     return false;
#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON64)
     return false;
#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
...
}

drivers/gpu/drm/radeon/radeon_object.c
int radeon_bo_create()
{
...
     if (!drm_arch_can_wc_memory())
         bo->flags &=3D ~RADEON_GEM_GTT_WC;
...
}

[1] https://lore.kernel.org/patchwork/patch/1285542/
gpu/drm: Remove TTM_PL_FLAG_WC of VRAM to fix writecombine issue for =

Loongson64
[2] =

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D221004c66a58

Thanks,
Tiezhu

>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   drivers/gpu/drm/radeon/radeon_object.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/rad=
eon/radeon_object.c
> index f3dee01..07b82d9 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -117,10 +117,16 @@ void radeon_ttm_placement_from_domain(struct radeon=
_bo *rbo, u32 domain)
>   						     TTM_PL_FLAG_VRAM;
>   		}
>   =

> -		rbo->placements[c].fpfn =3D 0;
> -		rbo->placements[c++].flags =3D TTM_PL_FLAG_WC |
> -					     TTM_PL_FLAG_UNCACHED |
> -					     TTM_PL_FLAG_VRAM;
> +		if (rbo->flags & RADEON_GEM_GTT_WC) {
> +			rbo->placements[c].fpfn =3D 0;
> +			rbo->placements[c++].flags =3D TTM_PL_FLAG_WC |
> +						     TTM_PL_FLAG_UNCACHED |
> +						     TTM_PL_FLAG_VRAM;
> +		} else {
> +			rbo->placements[c].fpfn =3D 0;
> +			rbo->placements[c++].flags =3D TTM_PL_FLAG_UNCACHED |
> +						     TTM_PL_FLAG_VRAM;
> +		}
>   	}
>   =

>   	if (domain & RADEON_GEM_DOMAIN_GTT) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
