Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B00C52D7F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 21:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB9B10E0D3;
	Wed, 14 Aug 2024 21:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEMqeoeX";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA72610E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 21:30:20 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so2713485ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723671020; x=1724275820; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NsHo05PbFGthvrcP1w5YnBAGWCrQpMiSVu6yHBZxoE=;
 b=MEMqeoeXB+cBzY68fzeu7IKmG4NCrXGRHXQL9OM/HMYMOKtTbruLv92PCtuzJWi5VB
 OYV9D10iNKPDKCj1qKAQczb9K/1x2p2dUVjBcs+C+OUk/Gg5BRmiEvGa2u/Y0GGax5a+
 SciJxhPkTvWgw8kvG2uDL8AwI6sPbs3FOtMU/wfuTrMLNoCgyn1HpgunCTJKJeUXyEs2
 LT+8sAoM/bQy5CXTOIKh+JMP0J3/ElMEwIokzkhbZONmonrcnuLXpSWKNpsF4TXTppp+
 eHbHkCHzjxLkpvCXAHsjUk6hESLGIaLrCF+uSQtv+Anxzhr9Abw5qZ+mL9WnrImF57Gv
 OlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723671020; x=1724275820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NsHo05PbFGthvrcP1w5YnBAGWCrQpMiSVu6yHBZxoE=;
 b=FZA91Wg3XDDtAWyjPIfELQioOhty7jTxB1IyAwt6EjdckfyZTi4uZupN113ZXj8QiP
 1g6xnGESIQaEEpI2vLt0AcY3vv4hRcxLHZKkZCzOWIvHSmGrHkKC6hgGBVDk0FZJCor8
 v2C0N7SPoe/O4MKQdebJTScdYG+9jaWHD08bVIhucQsxU0vGhq69vz5LnUmsBCbSIUcb
 md0BYRD8KlB1SmSYQxixZTNq9l2IZAD0GnP4mP3W77jBpKRHrjgNbT9IDoUnPVBud1Ko
 9VTTYHC+XMlN+Xm/kuBP9GiJShdQMRTWH9/5Drd2mC/E5mL9VvytdxhA/YZaMqFPW0su
 Djhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQjnyG+Nlvzgj/Oh5rfsNciK0tlqXYYZEpaUJEMZdgp4pjzC9VXlVgHPJjVTpyfHoNZqMN6THqEdRGY8XPpKGzwmhI6LtPGxXxWRj8hQ==
X-Gm-Message-State: AOJu0YygpT9pDA4PbdZgS2cRiw6sVBhySH19PUfH8nyL3AZ88HBbP+cz
 ahVzwJbNHLsbEZIdKUjdymi3yAxH0WsP6PIx4Rq122f9Y1vEuGpoudAdmgI7BUKv0L6Yt2mCp4v
 uO9cIKGnpGIdpMCikZzBNkdxyyik=
X-Google-Smtp-Source: AGHT+IGO/6VFtbWnQmfGb+Soi+oj2GvKapSaNMUWtUjMTaIk9DGw3xSWQGUT3mrpqp6wi8a+/6CwpbhvPC7P1WDaC5U=
X-Received: by 2002:a17:902:e544:b0:1fc:6a13:a394 with SMTP id
 d9443c01a7336-201d63bacdfmr62422645ad.23.1723671020124; Wed, 14 Aug 2024
 14:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
In-Reply-To: <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Aug 2024 17:30:08 -0400
Message-ID: <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, amd-gfx@lists.freedesktop.org, 
 stable@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> On 2024-08-12 11:00, Greg KH wrote:
> > Hi all,
> >
> > As some of you have noticed, there's a TON of failure messages being
> > sent out for AMD gpu driver commits that are tagged for stable
> > backports.  In short, you all are doing something really wrong with how
> > you are tagging these.
> Hi Greg,
>
> I got notifications about one KFD patch failing to apply on six branches
> (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> already applied this patch on two branches back in May. The emails had a
> suspicious looking date in the header (Sep 17, 2001). I wonder if there
> was some date glitch that caused a whole bunch of patches to be re-sent
> to stable somehow:

I think the crux of the problem is that sometimes patches go into
-next with stable tags and they end getting taken into -fixes as well
so after the merge window they end up getting picked up for stable
again.  Going forward, if they land in -next, I'll cherry-pick -x the
changes into -fixes so there is better traceability.

Alex

>
>     ------------------ original commit in Linus's tree
>     ------------------ From 24e82654e98e96cece5d8b919c522054456eeec6 Mon
>     Sep 17 00:00:00 2001 From: Alex Deucher
>     <alexander.deucher@amd.com>Date: Sun, 14 Apr 2024 13:06:39 -0400
>     Subject: [PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page
>     with large pages ...
>
> On 6.1 and 6.6, the patch was already applied by you in May:
>
>     $ git log --pretty=3Dfuller stable/linux-6.6.y --grep "drm/amdkfd: do=
n't allow mapping the MMIO HDP page with large pages"
>     commit 4b4cff994a27ebf7bd3fb9a798a1cdfa8d01b724
>     Author:     Alex Deucher <alexander.deucher@amd.com>
>     AuthorDate: Sun Apr 14 13:06:39 2024 -0400
>     Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     CommitDate: Fri May 17 12:02:34 2024 +0200
>
>          drm/amdkfd: don't allow mapping the MMIO HDP page with large pag=
es
>     ...
>
> On 6.10 it was already upstream.
>
> On 5.4-5.15 it doesn't apply because of conflicts. I can resolve those
> and send the fixed patches out for you.
>
> Regards,
>    Felix
>
>
> >
> > Please fix it up to NOT have duplicates in multiple branches that end u=
p
> > in Linus's tree at different times.  Or if you MUST do that, then give
> > us a chance to figure out that it IS a duplicate.  As-is, it's not
> > working at all, and I think I need to just drop all patches for this
> > driver that are tagged for stable going forward and rely on you all to
> > provide a proper set of backported fixes when you say they are needed.
> >
> > Again, what you are doing today is NOT ok and is broken.  Please fix.
> >
> > greg k-h
