Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBEBC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22FF208C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7hkeUtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22FF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE9B6E845;
	Mon,  2 Mar 2020 21:22:01 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFD76E845
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:22:00 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id j16so1702276wrt.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 13:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NcyiTSOHAW6nQumbb+hhZlZNIfC6ShMKkTiYdAbVzVk=;
 b=L7hkeUtrCB407F/REEKMRZOmRb/y0Dq54Bmc6hjBtyXcbGLHd1GT68WInIDTnSkdVB
 Zc3LIf/VYeGOuqPMLqe3rHLVgdGLOLHT7L8GtoEvhK3EXQITZ6UUZ8/iIhEBtHsRdYcK
 iF+l2iolr3dbW9ueXpzAtR5WgjjeKdnMIndB0009phygwlhm5dY3nxnw4lkB4H/be5qz
 Ks1TqmFCkUJxgQXI5cZaLr7KHiOlT3V0xyFpc1/yO5IwKgDnguY6Lk8WOxpr7GcXxaXw
 ki1swNHuPC29ha6fgqT9Lrewjxr3xJNZ2DZBStZuhJv2L4ZLNiObRq7lMlzW+vbZiqBo
 7xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NcyiTSOHAW6nQumbb+hhZlZNIfC6ShMKkTiYdAbVzVk=;
 b=o8Slh58REmR+v6oyv2zCRk07aFs8GXfClPR1gEQzV7TJSTObrMmfy1szwtZth3hE5h
 TLDI2McgBBJ3peKNoIlFh4mvUNjKBQQtdKZauqlGIj+o0G/Ra1kxAN9kijkxFuvXC0wo
 9xqAtpW+gYXNGYo2Gp+oMoJeYTtwwJC2cJdJ1VXFYxpRndOxlWU1qaWRrxGnP4qU6ROd
 4dEXJsJrEGIpzP2Vdu2QtJvU2vCZ1dJn7M/eZW0aNiwcVmy9FwVdrJT3XkG7a45zZHie
 TlEEJQPPv7lstk8+N9nX5FR5uLph+4ROVFydCOj/0BKrOortbCFVaxgbR4JucC9u75pP
 qKsA==
X-Gm-Message-State: ANhLgQ3dlQZQ8CDMmP0PpPJRjIMrKfeWB/BgWRAqCBoxJ7ic00mA6erH
 WcFen2Xh2wgIEaLK5kM5co762mhUttrM8kGJPkUdMQ==
X-Google-Smtp-Source: ADFU+vtxHJOCYsUhx0I6YDllEQ3Vtuuy17Lo0kynkQIexwZ6ks9I6w3ziqm1jEXAIDQlpMuZoGCQ06qHMFuZRR9s0+w=
X-Received: by 2002:a5d:5745:: with SMTP id q5mr1475559wrw.374.1583184119271; 
 Mon, 02 Mar 2020 13:21:59 -0800 (PST)
MIME-Version: 1.0
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1583177061-3115-2-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2020 16:21:47 -0500
Message-ID: <CADnq5_PUK=Y25wAaStohHH0oj-+jTWmO=6tF2iKHpTucNkfXEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Add USBC PD FW load interface to PSP.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Abramov,
 Slava" <Slava.Abramov@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 2, 2020 at 2:24 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Used to load PD FW to PSP.

Might want to define PD = Power Delivery.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 37fa184..297435c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -114,6 +114,8 @@ struct psp_funcs
>         int (*mem_training)(struct psp_context *psp, uint32_t ops);
>         uint32_t (*ring_get_wptr)(struct psp_context *psp);
>         void (*ring_set_wptr)(struct psp_context *psp, uint32_t value);
> +       int (*load_usbc_pd_fw)(struct psp_context *psp, dma_addr_t dma_addr);
> +       int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>  };
>
>  #define AMDGPU_XGMI_MAX_CONNECTED_NODES                64
> @@ -351,6 +353,14 @@ struct amdgpu_psp_funcs {
>  #define psp_ring_get_wptr(psp) (psp)->funcs->ring_get_wptr((psp))
>  #define psp_ring_set_wptr(psp, value) (psp)->funcs->ring_set_wptr((psp), (value))
>
> +#define psp_load_usbc_pd_fw(psp, dma_addr) \
> +       ((psp)->funcs->load_usbc_pd_fw ? \
> +       (psp)->funcs->load_usbc_pd_fw((psp), (dma_addr)) : -EINVAL)
> +
> +#define psp_read_usbc_pd_fw(psp, fw_ver) \
> +       ((psp)->funcs->read_usbc_pd_fw ? \
> +       (psp)->funcs->read_usbc_pd_fw((psp), fw_ver) : -EINVAL)
> +
>  extern const struct amd_ip_funcs psp_ip_funcs;
>
>  extern const struct amdgpu_ip_block_version psp_v3_1_ip_block;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
