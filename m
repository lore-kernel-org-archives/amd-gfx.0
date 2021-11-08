Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B99C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 10:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B0661181
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 10:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8B0661181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578336ED18;
	Mon,  8 Nov 2021 10:22:22 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58FCA6ED18
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 10:22:21 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id d24so25946679wra.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Nov 2021 02:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=O/090yBsnXppxT1LuMTD9zyHzQsJdrkJEAJxnX1ovbI=;
 b=TClQMyCYnngfEU/CxH2+5Jv95I3Pqerzj2TKfwwJ+94YPE6JYt/3oCHWlUU0h9mDrq
 EgHcCy/G8iBLik+M6SLflf+6paISTFjAp7PpuUphiVhc1iwwVCgoPKHnDwxArnJ3Ld+v
 kuPIluVYDvFeNHireXfuNXoxHU/q3Po2kiM4AWAUO3qzPzRkYh6ODniHVVguuuZB1s9r
 xLJMVstJqHx0vxNuu8kQMTCK+M1U+J4wOZYK4dTdKlzIAK2qoLDHgrRw7QW4KQb0pM6Z
 t6VM6Y00zG4JoJu4nKP358Bt/qE67bAJ3uiV6gg4E7ZYw1RaYpfxjliB4gdlOLRRO+2I
 1Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=O/090yBsnXppxT1LuMTD9zyHzQsJdrkJEAJxnX1ovbI=;
 b=nRGh544GZx6lOaXFXx/83n6cj88gaYz6CMzqdcayjcHqk3ZBMctG70ged9RhNRTAhA
 VEwqZE7MGBJSJm5wphbt9Xf53GTlhZ7s8fdfLUjQG7o4k0+75yrstz3l1nuRP7WWHAiF
 EZIwNrgaUvKy3DX0SRKr0SenW4jm3xGHAnuZwuD3lNUD3hzGA+CM33WlcJVWKqd4BPbh
 26D4U7jbKENxBdIjZnVFNU1MwheaIQFY1ZGEHhdQLDu6x9jY1XPvJim9dQ+xWzYXP0Nq
 tABNYz3VTg5TMtFGQggQ3gmarrtDfXoAGGfEsYYtCpafnjb4ejTYkrsLDnIY5Dbd2dJj
 GjBw==
X-Gm-Message-State: AOAM530jSbC1GMK8OgTSHJPpMX9GMe2oGLmWs8VZuwFFt6sbn00+Zs7s
 HHkc73k3wj0F4ndkq95AiOPabw93X30=
X-Google-Smtp-Source: ABdhPJz/4UlKvsuOlP/fJVk9xt/z7NwyfjHDKKytb/6tpxYvLdMlxUxCRwMmfRgo45JBW0gV99yY2A==
X-Received: by 2002:a5d:452b:: with SMTP id j11mr72174617wra.432.1636366940000; 
 Mon, 08 Nov 2021 02:22:20 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:308a:d18e:268b:408f?
 ([2a02:908:1252:fb60:308a:d18e:268b:408f])
 by smtp.gmail.com with ESMTPSA id 9sm20895556wry.0.2021.11.08.02.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Nov 2021 02:22:19 -0800 (PST)
Subject: Re: [PATCH] drm/amdkfd: lower the VAs base offset to 8KB
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211105192540.16241-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7b2d01fc-1058-e92b-e30f-98a72701f274@gmail.com>
Date: Mon, 8 Nov 2021 11:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211105192540.16241-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 05.11.21 um 20:25 schrieb Alex Sierra:
> The low 16MB of virtual address space are currently reserved for kernel
> mode allocations mapped into user virtual address space. This causes
> conflicts with HMM/SVM mappings at low virtual addresses. We tried to
> move those kernel mode allocations to the upper half of the 64-bit
> virtual address space for GFX9, which is naturally reserved for kernel
> use. However, TBA (trap handler code) has problems to access addresses
> in the high virtual space. We have decided to set this to 8KB of the
> lower address space as a temporary fix, while investigate TBA address
> problem. It is very unlikely for user space to map memory at this low
> region.

Unfortunately that is not correct. IIRC every program run inside wine 
maps something at the 16-64KiB addresses.

Don't ask me what that stuff is good for, but we already ran into 
problems because of exactly that.

Regards,
Christian.

>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> index 2e86692def19..d1388896f9c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -308,7 +308,7 @@
>    * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
>    * for now).
>    */
> -#define SVM_USER_BASE 0x1000000ull
> +#define SVM_USER_BASE (u64)(KFD_CWSR_TBA_TMA_SIZE + 2*PAGE_SIZE)
>   #define SVM_CWSR_BASE (SVM_USER_BASE - KFD_CWSR_TBA_TMA_SIZE)
>   #define SVM_IB_BASE   (SVM_CWSR_BASE - PAGE_SIZE)
>   

