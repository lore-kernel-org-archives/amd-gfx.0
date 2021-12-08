Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF671C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402726E14C;
	Wed,  8 Dec 2021 19:46:37 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860406E14C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:46:34 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 a23-20020a9d4717000000b0056c15d6d0caso3794423otf.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XCzF4SVZhA+iCq3EqvzQXjwTykSlZ3KOpsF8lPaDKME=;
 b=mS+qHPi4QpdetCIGI0TDExkLrHwzoME3CHyLpuisIFyAQIjT9tC/1hDulyF2kZfnUP
 rDQqVQvYv/qzlNjDfwzVJ3qROyNwWfX0xKSJAoOqlrA7hUMXxrL35lZt6AXlbiL3kWsK
 13gcxQaHJMt9ZEJQfLY2oeOO14xR39IoCoVt/J2cw7sHeiaUjHqbGJ3z6B5xcfeNsZLI
 KjwJgYoQEXQfq4Ee84+yN3EeiJjwWfvGZ19xT8J+Pjdrp99t57C5MOsQ50XF81gmPApu
 j4FdhzyStVRiWS4bQWgStgvjHUNbM7+/kH6d492Hr7JUM1iZbhCcGb3tRAmkmfNrcBPT
 BrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XCzF4SVZhA+iCq3EqvzQXjwTykSlZ3KOpsF8lPaDKME=;
 b=K3B4YT3GUKy8uX2M2VHwcZ3GVxDBXnyl8OhodTLqf/hAonlMY9+bcEunbVZMVjl8f3
 5yBRmL4FCIfyPmf3p5L1u2efAS5WUzkLqe/fUUnevnfCQ/MQtUwFeQSq1qG4YRfKiLm1
 7az9MiRB11Aqspw9dtrDUyMKHoRN77Oxpf3nozA/DjpB7+dqs3msGnkjTwqIUzGeC9wJ
 Qb+gqVJ/EaqIH497YYI5JdDQ5SRtrcgHR/dVv2n6MRW2t0/v9vETC3jWt8sO4+i6Fxsz
 GhuAfJ43MUgWxMzxLwBNZQVYfMtK+/gffny0RlRUfH2ZJP2FqzIwE8wu/C+oQ9HLi3Cz
 kVkQ==
X-Gm-Message-State: AOAM530jLQDiqi+i/SwoWWEnio1JmgpP/4f3DbSJ6pc2KaQ4nli71nAQ
 ovCAQhEb+bB6691tE060o2lrR+NsezC+4x8G4uA=
X-Google-Smtp-Source: ABdhPJxWkVxr/EI/h1H8F7fefbZ+FuzstXd4M6HvhXa8jRtalTYDgQirNCfLe3A5t+xLD9g6zesV3mGq++qknHOXAQ4=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr1445937ota.200.1638992793887; 
 Wed, 08 Dec 2021 11:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-6-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-6-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:46:22 -0500
Message-ID: <CADnq5_PU=egCYEoEa_pycg3R2FRsfHsedxAh8K7fAj7X33z-Xw@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/amdkfd: fix function scopes
To: Isabella Basso <isabbasso@riseup.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Dec 7, 2021 at 10:17 PM Isabella Basso <isabbasso@riseup.net> wrote:
>
>  This turns previously global functions into static, thus removing
>  compile-time warnings such as:
>
>  warning: no previous prototype for 'pm_set_resources_vi' [-Wmissing-prototypes]
>  113 | int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,
>      |     ^~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index 08442e7d9944..3c0658e32e93 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -110,8 +110,8 @@ static int pm_runlist_vi(struct packet_manager *pm, uint32_t *buffer,
>         return 0;
>  }
>
> -int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,
> -                               struct scheduling_resources *res)
> +static int pm_set_resources_vi(struct packet_manager *pm, uint32_t *buffer,
> +                              struct scheduling_resources *res)
>  {
>         struct pm4_mes_set_resources *packet;
>
> --
> 2.34.1
>
