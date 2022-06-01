Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75527C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A7110EFA5;
	Wed,  1 Jun 2022 17:47:09 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D601A10EF7B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:47:08 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id e184so4200737ybf.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oZOV1X9Y8nD45AOZn+KbXcGeeLac6tgBg3vJm43X4SI=;
 b=QiyCxsQgNeDugU6mxZ5FJE/s7ZNFpc172DHKi9vC23Hu/NTXeMxmcdVgKm3esPciHt
 HUcjoFRpCzc0Txu+DHaZjkGRuocOWUKqM59M/OHQlOBjdjP4ZU1AT5Dtq8Hz+e+l7PIL
 v6YNFiCMX5qlmsQOglU0mwl36JAISfFWD8IDRdXkXnlB99CIxzrTW9yPIP1otQb4ZA/r
 9lC1ZZqYbdkpukOIF7MY14ePlZSrLQvo+llqn9KFopDuloM9dlgx21bHsB2eksbWqUxt
 58WQoDaXSI4z6t568Yumierwz58jVdYlRIEWJFUJIZDgnjEGMfA+CI2WvAYIrzvStjYu
 2ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oZOV1X9Y8nD45AOZn+KbXcGeeLac6tgBg3vJm43X4SI=;
 b=jb8HFI918+y39TaA2qQA9w1x7CvHxx0zREaGT76c7QqqJ6GQ+bpIMj43UrqLYRcMLx
 NAi/V3/gAp9VGQTbehXmmJBFDy1T+NdpqcLpr/vRZW1u7XTJzD0GQKCcF7YzMVle5xga
 oS18HHzwbVOuxZGeSfyHoDUbY2jv/8X0rA+rpWFQdMFcaBVueIj4nYv9HG0xEcjLucxq
 vrOYWPt6r6gej9WYAXyV6/x6aEBziwWK0H0mMPn1ZP+dGYcMuuBAyAt3Smqi+8GT6ULi
 5vOUwNCLxYWR/JdcMJOyEhqZh4iPuKDDEtGb1XMLFNipvyrb9x9IAfXuvAFY/j0oSo4M
 aS3Q==
X-Gm-Message-State: AOAM5315xuPm1VZCEZwII+QNElJ3VwzFalrbFHBChBrDpetP4NDxUSZR
 0zlxNw4GWIOS95hWH6GCCRbxvbwhwUQ8Gmd3RpcPsw==
X-Google-Smtp-Source: ABdhPJz/FEmgxsvcgElcspR9jnBMfKX+yyWGDnJDc1sN4yXyZaCe1K4G9PuNew7t7Q2dXxdIRVH3EaguznO8YTSLZY4=
X-Received: by 2002:a05:6902:1546:b0:65d:a1f9:23e6 with SMTP id
 r6-20020a056902154600b0065da1f923e6mr1057964ybu.6.1654105627056; Wed, 01 Jun
 2022 10:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
In-Reply-To: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 1 Jun 2022 19:47:19 +0200
Message-ID: <CAP+8YyEMH8YVctCNC4jcTFhSksGqrb0ku6Em7fdKBCqKJLf3+w@mail.gmail.com>
Subject: Re: Explicit VM updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Olsak, Marek" <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 1, 2022 at 2:40 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Hey guys,
>
> so today Bas came up with a new requirement regarding the explicit
> synchronization to VM updates and a bunch of prototype patches.
>
> I've been thinking about that stuff for quite some time before, but to
> be honest it's one of the most trickiest parts of the driver.
>
> So my current thinking is that we could potentially handle those
> requirements like this:
>
> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. This
> way we either get the new behavior for the whole CS+VM or the old one,
> but never both mixed.

Any VM wide flag would be a concern because libdrm_amdgpu merges
things into a single drm fd for potentially multiple driver (i.e. radv
+ amdvlk + radeonsi). I'm also not sure what you'd need a VM flag for?

>
> 2. When memory is unmapped we keep around the last unmap operation
> inside the bo_va.
>
> 3. When memory is freed we add all the CS fences which could access that
> memory + the last unmap operation as BOOKKEEP fences to the BO and as
> mandatory sync fence to the VM.
>
> Memory freed either because of an eviction or because of userspace
> closing the handle will be seen as a combination of unmap+free.
>
>
> The result is the following semantic for userspace to avoid implicit
> synchronization as much as possible:
>
> 1. When you allocate and map memory it is mandatory to either wait for
> the mapping operation to complete or to add it as dependency for your CS.
>      If this isn't followed the application will run into CS faults
> (that's what we pretty much already implemented).
>
> 2. When memory is freed you must unmap that memory first and then wait
> for this unmap operation to complete before freeing the memory.
>      If this isn't followed the kernel will add a forcefully wait to the
> next CS to block until the unmap is completed.
>
> 3. All VM operations requested by userspace will still be executed in
> order, e.g. we can't run unmap + map in parallel or something like this.
>
> Is that something you guys can live with? As far as I can see it should
> give you the maximum freedom possible, but is still doable.
>
> Regards,
> Christian.
