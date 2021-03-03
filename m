Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542B7C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 02:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AFE64E89
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 02:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AFE64E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535F66E34B;
	Wed,  3 Mar 2021 02:23:14 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4936E6E34B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 02:23:13 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id u3so3907066otg.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Mar 2021 18:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1sYdz079VfZrgcHdJeqSEQWsJkXnmuC/6uEJVvFX4uE=;
 b=N6dNxr6573+GgfQWDOBO2v3+QsOVV55jzmFfAv+MroZMxK/64++F05r8QxDv+X7W+g
 6+5G5KwTir/nf2LXmTDq5/RMjrlxelLwVW3J7ZBHhRi8fLdOHiZ23DQYEI5GLUOs6afU
 x49c3cTUoO5yfVq7JaWLHRz8Ymy0DpLgQoL7P2HQGICUlvU8jiezBZIBF2J7SZGy5/5I
 ZCg+oAXE5BZLB86oM6VAyA5VPVXlmoj00tEvNm3ezBqCbVTsKqBBjRls122S0hLPKWI5
 qB8AdHiKBH3HnusDRjyj8Et8Hxrqqz9I/cVu2t2xrX2no6PRmjyvXJXc5mUs2KhvxU54
 E+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1sYdz079VfZrgcHdJeqSEQWsJkXnmuC/6uEJVvFX4uE=;
 b=OCD3CtDw88mVVz0LkrA15f0Co9z/Mlp56ulzaJ24q9NbFyj7dSEOen+89x9Do4X47x
 RDn8SgyWoRNPZvi9jPJFzbBK/a5ce/AzBZnhti1GKdS165A9TvJRtBqdV0SNL1ehgfrM
 JVRX5zZ8oa/uFWXWY8rrR3NhaeegvEC1Ucrjcj7g4NAYwnsuqOvMXk2M894kNQDNwH7p
 89Xuc9tvyvNXlJVmGXQXqeTgLQ8hzPPaiixD7sRZo8F+8M4erm1J3XEDd56VgUynHHkP
 rzFWRXGHV40OiTJaHRHIg1gyNg8tQbcgpY3/g4FSDLi6970vXXs7QO+ffabzxbh2m8ed
 4sDA==
X-Gm-Message-State: AOAM530J4wv+OuQEzi7+valDq9qKzHyWFFgsgz6trpORxMrI5vza6CZh
 VgWlGYufjWbVkedskbyUhA5c0yOq4BEcmFPeYHE=
X-Google-Smtp-Source: ABdhPJyylH2ikc9Oalf2+xNzuAxDqCXGvrUa+bpLT9q+jf9udMGh2PzUQhKrRC81w9+gUHjKSjPP1b2g2nmep3bhrmE=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr2380636ott.132.1614738192504; 
 Tue, 02 Mar 2021 18:23:12 -0800 (PST)
MIME-Version: 1.0
References: <87tuptt2jk.wl-chenli@uniontech.com>
 <87r1kxt2fg.wl-chenli@uniontech.com>
In-Reply-To: <87r1kxt2fg.wl-chenli@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Mar 2021 21:23:01 -0500
Message-ID: <CADnq5_PhQ-dtpDM6XDNc+kJt8+8zX7_GscWi7sg5iri-ZqWMRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Use kvmalloc for CS chunks
To: Chen Li <chenli@uniontech.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 2, 2021 at 9:16 PM Chen Li <chenli@uniontech.com> wrote:
>
>
> The number of chunks/chunks_array may be passed in
> by userspace and can be large.
>

We also need to kvfree these.

Alex

> Signed-off-by: Chen Li <chenli@uniontech.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 3e240b952e79..aefb7e68977d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -117,7 +117,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>         if (cs->in.num_chunks == 0)
>                 return 0;
>
> -       chunk_array = kmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
> +       chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
>         if (!chunk_array)
>                 return -ENOMEM;
>
> @@ -144,7 +144,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>         }
>
>         p->nchunks = cs->in.num_chunks;
> -       p->chunks = kmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
> +       p->chunks = kvmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
>                             GFP_KERNEL);
>         if (!p->chunks) {
>                 ret = -ENOMEM;
> --
> 2.30.0
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
