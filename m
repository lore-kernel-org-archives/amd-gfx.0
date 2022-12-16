Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6211C001B2
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 08:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C96ED10E0C3;
	Fri, 16 Dec 2022 08:26:24 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1390410E033
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 04:37:31 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id 65so997313pfx.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 20:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XLygs21yUm+BsQ9K/jaILqjtoVN7cCv+GmldKd5jCoY=;
 b=atuW7kj1tICjX6XOEoGlMKRElIbgy8WI/deoKifcFx1519QZRpDCOoxmKj7EgE2l4w
 PKzJI7L2ZbVuy2LOhWOolJwT0c6HGC5z3GYIC7j6xM/AunIUu1/hMOhZv9S06C7VFhC1
 4Q2nDbmd0YUF9RndxPqP2p/GdMMZ3K4yhoxZk3FVJ0hYXbi4IN4jZVfHJrGPnQoXbTYJ
 YAB5z7iNwRy7E4EGbWHbVIEyT9ICXQ8iqfiE3z4SLn1NrJW7NLywpAeLKJB/g9wvfmaM
 r5jcdkMrnO+dY5EbBAyyZATVFCQYX6igkBalPuLJ6BkhstYEmOV58RsJNRueXOX7Ax8G
 6CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLygs21yUm+BsQ9K/jaILqjtoVN7cCv+GmldKd5jCoY=;
 b=usV4zW3WFwf4fTDLgN46ApNmgBuNOnwiHDmj/Gaj4Z4C3tLqGvggxEonOZ9WCYvLPX
 DyQN8/XPvMh8VQF1GLj/SNc69FUJyTBAbE1rM0lWzeokJQOiDumIkiOHKBBUPK1J1hki
 gyvQ/krxJUrQAdG+KIkcwwwsw8RiTpgouwroh70ASCTyans0nrWMrMH45jEcR5xpMCHh
 blX0xBLApoY9zR3DX6moqyIoLEe1EntS3DbnFX0gUlhan8PiilLNsR95K2jh6bl0Re6w
 NCfdpWVUvoeKnQTmK893+RaCURo+oigG2xvpE9zlbT5ad8V8jB8WmUfMiqaNjWvRNdOP
 h/YA==
X-Gm-Message-State: AFqh2kqMwdlST7qUjtLcnMFKUH8lG+NQFroPYt4u89ZXFa89U6rnulLM
 VfU/Vjbf4XZn3YRK2ycExNCXanEjIUP0J4ETCeI=
X-Google-Smtp-Source: AMrXdXt5JWumad1PiboheGKsXmVaNjeH8snNXdAqZ+Iojn+pij8j6t8nwEgKCk6P8kauAlDPnokzu+Szv1Dew2bD4rM=
X-Received: by 2002:a63:584c:0:b0:484:2672:2c6a with SMTP id
 i12-20020a63584c000000b0048426722c6amr142358pgm.535.1671165451321; Thu, 15
 Dec 2022 20:37:31 -0800 (PST)
MIME-Version: 1.0
References: <639b23c8.DdUNqMCLdxZ7gLv2%lkp@intel.com>
In-Reply-To: <639b23c8.DdUNqMCLdxZ7gLv2%lkp@intel.com>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Fri, 16 Dec 2022 13:37:20 +0900
Message-ID: <CAMZ6RqJ7-GTPe7tNdhTYCF6OrnagfNL_7EXrhn5HD=YB8dtCGw@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 459c73db4069c27c1d4a0e20d055b837396364b8
To: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 16 Dec 2022 08:26:21 +0000
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
Cc: kvm@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-can@vger.kernel.org, linux-xfs@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>, loongarch@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue. 15 Dec. 2022 at 22:57, kernel test robot <lkp@intel.com> wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 459c73db4069c27c1d4a0e20d055b837396364b8  Add linux-next specific files for 20221215
>
> Error/Warning reports:

(...)

> Documentation/networking/devlink/etas_es58x.rst: WARNING: document isn't included in any toctree

A patch for this warning is on its way:
  https://lore.kernel.org/linux-next/20221213051136.721887-1-mailhol.vincent@wanadoo.fr/T/#u

(...)

Yours sincerely,
Vincent Mailhol
