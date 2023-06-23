Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0ECC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 16:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E6110E670;
	Fri, 23 Jun 2023 16:33:59 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CEF10E670
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 16:33:56 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1a9ae7cc01dso578100fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687538035; x=1690130035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjw0LYGWKDE8VyzX33IY+PC4B+4FIptKX5X47LfQUsg=;
 b=nBB5mLO6BkoRzufqplTBuNDeDX0+rqwrjNSGL5qGgUJ+DnbVkT9rcsYAtu3i48qUZn
 CiG3hblM0TBrnQ0XT022RR2fgZxMpg4TOmW6ZsngziCW2ZbzK1zObnAv4BOppBX2/Aw0
 XQUO2qacLdjDJ7WFJRVewpahttJyFmjQ/PN1rnVNI5lo3cp+lx8lYVdGZjcD8eOwE+Z7
 VB30oiCzQpsINCm9S10SiwcGUQdooogtfkbpmf6t8toVBhMsjhDRY+1BwAfV7vusuZD0
 soVybYlhhC7yfKu/NUU/sIv8dgKCYeouvtd57dXKqNixQoeH4Ts/6jXAjg2te43qQWVG
 gu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687538035; x=1690130035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjw0LYGWKDE8VyzX33IY+PC4B+4FIptKX5X47LfQUsg=;
 b=SHioFzXAsdg60zSyhXJ+Dgh/BzNfH2ALS1naznc/nZHl6zYsmQdDMhKQ+Ka8Fj4m6z
 jELP4clAIH28oySRNt5YDYB5Z0xUPn1Wwsjfk4h4/+mPhpj3BngPig3BNNKsVJW+1itA
 Hy1gHg0grfh/AEkt1bxRkzrFqVZIfDAT/owyh0cjWpomDGUfDT7QAAJdsPxSLk8Q4khh
 0DhFhvBjJ4ZgFa/flVZQkF7YJfOGrbhe218d22NGZISSSY2lYDAzAmQHbom+TEGGGuWp
 x/rj8bBz0dGHMH5Di5fFoX4tBe/CMKOtqM8OKAoLjK0ED0IrAwN3modsZOUMy/54+9N+
 4ehA==
X-Gm-Message-State: AC+VfDzH7uVsKyPi8bBAdhO30BwLYco/3pUvmy952yWonFs40jXA529e
 tccbLw/ZSoEkyo2oWGvcPYoNQMIVnj9+EffRUV4=
X-Google-Smtp-Source: ACHHUZ7UKmzHJ2GKDZhHE/YgCU8i269Zyohu6NW4DkAvFLAQ5xNGi+kfQdrbnYIMPmpp4Ps/KOwMPVnZSxYwNjow5v4=
X-Received: by 2002:a05:6870:56a8:b0:180:857:d47d with SMTP id
 p40-20020a05687056a800b001800857d47dmr21089266oao.57.1687538035242; Fri, 23
 Jun 2023 09:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <168258140711.32181.12062781302326675605.reportbug@atzlinux-arm64>
 <2e6faab830d01849a8eec6871d66787db455864e.camel@decadent.org.uk>
In-Reply-To: <2e6faab830d01849a8eec6871d66787db455864e.camel@decadent.org.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jun 2023 12:33:44 -0400
Message-ID: <CADnq5_OXO8emTUa8A6SAWpnpbfZCOT3QHaj5J1iQKCi2h1vdew@mail.gmail.com>
Subject: Re: Possible missing firmware
 /lib/firmware/amdgpu/sienna_cichlid_mes.bin
 navi10_mes.bin for module amdgpu
To: Ben Hutchings <ben@decadent.org.uk>
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
Cc: =?UTF-8?B?eGlhbyBzaGVuZyB3ZW4o6IKW55ub5paH77yJ?= <atzlinux@sina.com>,
 1034903@bugs.debian.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 21, 2023 at 11:38=E2=80=AFAM Ben Hutchings <ben@decadent.org.uk=
> wrote:
>
> On Thu, 27 Apr 2023 15:43:28 +0800 xiao sheng wen(=E8=82=96=E7=9B=9B=E6=
=96=87=EF=BC=89
> <atzlinux@sina.com> wrote:
> > Package: firmware-amd-graphics
> > Version: 20230310-1~exp1
> > Severity: normal
> > X-Debbugs-Cc: atzlinux@sina.com
> >
> > Hi,
> >
> >  When I upgrade to kernel 5.10.0-22-arm64, there are following error
> >  infos:
> >
> > W: Possible missing firmware /lib/firmware/amdgpu/sienna_cichlid_mes.bi=
n for module amdgpu
> > W: Possible missing firmware /lib/firmware/amdgpu/navi10_mes.bin for mo=
dule amdgpu
> [...]

Those could be dropped.  They are not really used by the driver.  They
are for a feature which was not ultimately productized on those parts.

>
> I see that the amdgpu driver has had references to these files for
> several years, but they've never been added to linux-firmware.git.
> More recently amdgpu added:
>
> MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
> MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
> MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
>
> and these are also missing from linux-firmware.git.
>
> Is this firmware intended to be available to the public?

Yes, those will be available soon.

Alex
