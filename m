Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6B3C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 17:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3436410E592;
	Mon, 20 Jun 2022 17:20:32 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E5B10E592
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 17:20:30 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-31780ad7535so80909927b3.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zI/plDrhqjLDX3BYaJxrzEoQ40Phmro2M/OiEvAEhps=;
 b=PzwJ397vkAJCEkP+ZCf1MulA7pUsszVt+VrNi78NVm5LoACTiniLKE/e8ngxvJUUDn
 WuqQDJ3x5aoHW/ZEuuM+VgCnDhlPjo+ESWWJltrhrcqfwoEEkkFb+BGuYth7NrYo7dPZ
 95dpRjlUj6XqBVroptMCy+aS6TNlwaOkf8S8/tPK8SjgBr+2EVkONHUqDaJ/Z8piz8gO
 XbikkLTRXtywSIUydWDw2wzErL7dnKu5vQjAFyb9IirqUyhOiYOknyv/sPI7iNtu0MLk
 L9TR3wOJPA3tb3jVQfY5/K7U4qpI3Orti3eJPoz8CDQND8CoBxTzOGq9rRBa449PHTh0
 UeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zI/plDrhqjLDX3BYaJxrzEoQ40Phmro2M/OiEvAEhps=;
 b=z9f38W1GHM4YRHB7fVpAhm21YIuhiWcs4IOoRl79PAysBYuY8vDHiLcp/D9tXF1n56
 SwfoKEgYuy4FEg5CtB+PjgTmpslv6NgcYphSz/sTxiVKQDIinNzBh4ptv0+yPEqBKl6N
 gT9mpqcld00lldz8kEuJKIt5ZlFuEiiiAq/ioSjFE1TmBYFBhLk2k8bqdFaOls8lk+8t
 5xFD7a3TinIk8RScmKcjjp+oso5f+aN3+UZySnhAjLLfwWeyQ2N/qzYm6od6R1JwAAVD
 InFEnL3J96DVzuvJ3Tvg/iDnya8bPbmglT63WoV8jcm16VirnlSxetxLJyQjGncY4Ax4
 Gv1w==
X-Gm-Message-State: AJIora8Zl+eMqjFm5umxcuxa/3gk6D8sXNp7WeZrejSN+NwX725KFcc4
 s9ZdVaN6r0gFYv6uPJH8BLd+1JuSSLE1tQv5kvQ=
X-Google-Smtp-Source: AGRyM1u1Ra2Q3Utuw+jNR8m1Bq23BMutz22TZy265+fHxY1KvQHPvHDjMhHgm3/wGPZzB0U13GK2YoYJ3dH+d4XV24k=
X-Received: by 2002:a0d:df8d:0:b0:317:c206:2e7c with SMTP id
 i135-20020a0ddf8d000000b00317c2062e7cmr8530176ywe.97.1655745629529; Mon, 20
 Jun 2022 10:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220620084156.2295093-1-yifan1.zhang@amd.com>
In-Reply-To: <20220620084156.2295093-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jun 2022 13:20:18 -0400
Message-ID: <CADnq5_O4HXF+UYEncUcs0x+p3t4iYMiZqk=w-NSYrduKdLu6zQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: correct sdma queue number of sdma 6.0.1
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Tim Huang <Tim.Huang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 20, 2022 at 4:48 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> sdma 6.0.1 has 8 queues instead of 2.
>
> Fixes: 2f68559102cb (drm/amdkfd: add GC 11.0.1 KFD support)
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bf4200457772..c8fee0dbfdcb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -75,7 +75,6 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
>         case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
>         case IP_VERSION(5, 2, 6):/* GC 10.3.6 */
>         case IP_VERSION(5, 2, 7):/* GC 10.3.7 */
> -       case IP_VERSION(6, 0, 1):
>                 kfd->device_info.num_sdma_queues_per_engine = 2;
>                 break;
>         case IP_VERSION(4, 2, 0):/* VEGA20 */
> @@ -90,6 +89,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
>         case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
>         case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
>         case IP_VERSION(6, 0, 0):
> +       case IP_VERSION(6, 0, 1):
>         case IP_VERSION(6, 0, 2):
>                 kfd->device_info.num_sdma_queues_per_engine = 8;
>                 break;
> --
> 2.35.1
>
