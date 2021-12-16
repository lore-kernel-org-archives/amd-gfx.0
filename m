Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E6DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 17:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217AC10EE2F;
	Thu, 16 Dec 2021 17:16:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F30610ED5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639674864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQgAhoiOjcEvvq4zHc3KhGoH9+9ZU/GHjebXeJBKCA8=;
 b=g5ajQYKmb42bqgA4dqKIkSkDIZaqv5CqKL8hTD7BfxG6gP/pmUP/r6K5zbC7q1GnrMEK0X
 1x37AWuhnEsjxS3LhlniFc2C0wJ11aSyRn7pqlMyqDrrWDQXw6wDVD2bVkY2WTQLuTox4k
 w3tsQsuwTThiAbrlzU3nap+XMagUv38=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-Yj6GXfo2No-ISbPQtM7xjA-1; Thu, 16 Dec 2021 12:14:21 -0500
X-MC-Unique: Yj6GXfo2No-ISbPQtM7xjA-1
Received: by mail-vk1-f200.google.com with SMTP id
 k127-20020a1fa185000000b002fef61a92f3so12326383vke.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 09:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oQgAhoiOjcEvvq4zHc3KhGoH9+9ZU/GHjebXeJBKCA8=;
 b=JHpXNQ/brNqnH8VGSLXgyR9S+lz3koyDNKp9pLkmqRNQHnFNfJ2idjveAvh1jHnUim
 GP16DdB6IDeLDPJppGzEMkV0HdVhJGnc5eDFQX5P1na1jo7yuG22IG1qqMLjGCLjS/Ec
 t+yRjV4b6nhrVFbE+dKlGlUOTlZ0QiG1TX3GgIpeUOiOdvOQYaOXlJRIgCZphH9s7IaD
 4U2u6wjiu6yHId1moY/egKkuiGcOMMmY8ZtwA3iLo7sQqtoTirNyaAJAGvY7EdfsGNTz
 XQfwurmwOPoxJQp3iX9kyYnF0tpEjx1eNKh7CBWBg8QlEV4eQCdpnfeUvp0hiwhPdyu1
 xxtg==
X-Gm-Message-State: AOAM532Bx1IUmDMsPXcZDb08fbkTSFoPjTw7yRCgqBk1U8ofHGOGvRem
 WwgmwmyvpyOTmJKwObrWlwdSr4TMrABs5efcZkWiRsVQsovMidxxS+IGsDjfWxyvknm8PzyqA9W
 AwEmeEbVJhSJaDMDnySHiR7UWNpQytYsoBkX7OJMFNw==
X-Received: by 2002:a67:fc91:: with SMTP id x17mr5816413vsp.23.1639674860903; 
 Thu, 16 Dec 2021 09:14:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZeE766WsJKtZAbhMyLrZU8A8/n/meEH7AyiHVqY8cf022RAtLRCFB9/m7y0IvBS9qdJ8zxCDFkGaW5OvF0IU=
X-Received: by 2002:a67:fc91:: with SMTP id x17mr5816396vsp.23.1639674860652; 
 Thu, 16 Dec 2021 09:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
From: Richard Fontana <rfontana@redhat.com>
Date: Thu, 16 Dec 2021 12:14:09 -0500
Message-ID: <CAC1cPGyg_wNqusQX+OzPNtTc8GSpQKwxfFSKzLfENYoXihQYww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: make SPDX License expression more sound
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rfontana@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 16 Dec 2021 17:16:23 +0000
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
Cc: Jonathan Kim <jonathan.kim@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 16, 2021 at 4:45 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit b5f57384805a ("drm/amdkfd: Add sysfs bitfields and enums to uAPI")
> adds include/uapi/linux/kfd_sysfs.h with the "GPL-2.0 OR MIT WITH
> Linux-syscall-note" SPDX-License expression.
>
> The command ./scripts/spdxcheck.py warns:
>
>   include/uapi/linux/kfd_sysfs.h: 1:48 Exception not valid for license MIT: Linux-syscall-note
>
> For a uapi header, the file under GPLv2 License must be combined with the
> Linux-syscall-note, but combining the MIT License with the
> Linux-syscall-note makes no sense, as the note provides an exception for
> GPL-licensed code, not for permissively licensed code.
>
> So, reorganize the SPDX expression to only combine the note with the GPL
> License condition. This makes spdxcheck happy again.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> I am not a lawyer and I do not intend to modify the actual licensing of
> this header file. So, I really would like to have an Ack from some AMD
> developer here.
>
> Maybe also a lawyer on the linux-spdx list can check my reasoning on the
> licensing with the exception note?

I believe "MIT WITH Linux-syscall-note" is a syntactically correct
SPDX expression but is otherwise sort of non-meaningful.
"(GPL-2.0 WITH Linux-syscall-note) OR MIT" is presumably what is
intended here. But yes would be good to get confirmation from someone
associated with AMD.

Richard

