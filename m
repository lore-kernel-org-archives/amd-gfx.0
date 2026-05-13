Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B3ECD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB8A10E4D8;
	Wed, 13 May 2026 14:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="msE136Cw";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB8510E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:50:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488ba840146so62941335e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1778683820; x=1779288620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9aCSbvN8MRClnV4Yg1EbNe+CFjWMezo1Gq6IiKlokcU=;
 b=msE136CwUGpSZH7Ebc30HDbDPX9wNHaQvJPEnCf29BKYBEzCz1zfdCE32s2yIwVB+X
 vOP+wJGW2wcF6hxX4sceUR2RorawqXuBm5cAd7uuvaZLfZ5P98AKbHY1O+2vba/h7zDj
 PVyJR4rg82xzILa2G85xLwpzCEBKHretez1CEyibssMvH9wVOf2NEnyfnqTHAVelUmMV
 Q+bPf1UXdEp9qPxb9e1uJmFOpQdIrm0Xwuhkeq+x7f82vvG9nLlnoBPZJP+0GeXvHq9s
 67VU5yFhRL0EpC6ZiUKtj7KumwEMCWkZVfQZGKhLaKOihzU07S9aR/qw99t90BZNRSGP
 XlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778683820; x=1779288620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9aCSbvN8MRClnV4Yg1EbNe+CFjWMezo1Gq6IiKlokcU=;
 b=o1DWtHpTXtbhft8VgRmyIi4njDWHAsFlMsa+C/KirqONby5cBNzvlj8B29aAGVD3lN
 kbryLq/YltADbzZPD2WqNOJiH2f8KVmCv1FivrHeh5oYtxyMXAQgSJI9WkCnisZLEGEz
 ry+ZV/lTXZVSIDG01JZdn2db9lQAS3lxmIw6jpl2QU6hC3BXHvD2S51xPDpCmMLe1d4r
 6m3JRBLCce9mMnJCbhLDCQTtLHkcqeWP2Y8iaYyk8GS2IaT4h3Lti4NYBotzwcs3w+ty
 lGAGkv/8HCJcPCXwiKvPOBOTGUJzye6aI5saS8WhVYqNCBuRmaDE2BqwyBIXHF4P/v41
 Se2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WdoP5w6NhQs7IACNKciAx64XjRvoJvO1RDZ/D3SgjJ2xU/llLYbNl+d0Nt6POWjN6ZuY54tbz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMR1kK1fIbwi7GPpZeyoHJ7bmCi9LLGzUlmVo96SLnE7HIuNzz
 dBGii/wpzPsTUA0kNirbAmxxcfXHI4Zu824bVxqDkiPWUW3T2Qlr+teR1VIkqj/0zro=
X-Gm-Gg: Acq92OGEqX+fl8fDB2yj3beeKTwA0/3wzh7pjtIPHgO/6emSmJbytcHAxr0WIimT2b6
 bFjEAw+dN32//kzXaI1Si9A5NRv3aZe3tX1rX++bBsF7u3PTNSDEcgsbPlLGBKtKhUEcilB9L0X
 rvDEFMm46dwggZbLjS957TLZj38wOyhQjxh/CgTlLudwMoCzWhn6XyPem2sTb1SrQ9AyjZ0VoID
 8Ho9BC6YwklChnS1Dgt6fsk3vSA3ap+eyheEr31AtiC+K3rOybzGkJlK1sksPmREkOCoKhEaDJ3
 cdFOAfKOIIeNHcGl3FxK46CdgBts1/hdH5INUt38zdpin9S0hLzdrppmXNO0Ol96vCOJnqTNpab
 RjMYIia2KSLA2qxK9Avuwdy3K3eKDnvInKtQ1/Oy3uxq+4ARoT+LlJxSWUU2GJnRcVPRgKmg3Z+
 WvtkUTnxdCwj0hOiL4sioLIesvah3Ws9oe5fpebaUo4MlA2rMo5RyxsVc=
X-Received: by 2002:a05:600c:811b:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-48fc9a2cae7mr52718585e9.16.1778683819197; 
 Wed, 13 May 2026 07:50:19 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f3c65f2sm78154115e9.1.2026.05.13.07.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 07:50:18 -0700 (PDT)
Message-ID: <a059d1e9-e356-41b0-8336-8b25ea24e7e1@ursulin.net>
Date: Wed, 13 May 2026 15:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Support 52-bit PAs in ttm_place
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260513141253.20410-1-felix.kuehling@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260513141253.20410-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 13/05/2026 15:12, Felix Kuehling wrote:
> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
> size this can support up to 44-bit physical addressing. Grow these to
> unsigned long to support larger physical addresses.
> 
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   include/drm/ttm/ttm_placement.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
> index b510a4812609..ab2639e42c54 100644
> --- a/include/drm/ttm/ttm_placement.h
> +++ b/include/drm/ttm/ttm_placement.h
> @@ -81,8 +81,8 @@
>    * Structure indicating a possible place to put an object.
>    */
>   struct ttm_place {
> -	unsigned	fpfn;
> -	unsigned	lpfn;
> +	uint64_t	fpfn;
> +	uint64_t	lpfn;
>   	uint32_t	mem_type;
>   	uint32_t	flags;
>   };

Maybe audit of usage sites is required to make sure no compiler warnings 
on 32-bit builds if nothing else. Things like:

amdgpu_vram_mgr_intersects()
...
		if (place->fpfn < lpfn &&
		    (!place->lpfn || place->lpfn > fpfn))
			return true;

Etc. Probably are all best adjusted to match the new type.

There is also:

struct ttm_resource {
	unsigned long start;

Which also may need aligning. I know no one cares about 32-bit builds 
but some automated systems will probably test it and send reports.

Regards,

Tvrtko

