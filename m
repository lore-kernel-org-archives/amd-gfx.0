Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A57C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4707060F26
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4707060F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7581E6E1BD;
	Mon, 13 Sep 2021 16:49:41 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F44D6E1BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 16:49:40 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 y47-20020a4a9832000000b00290fb9f6d3fso3630650ooi.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vdYFqw0mtrt94tSkrO4u7McJF8Aj13wOqeIAobdtUUo=;
 b=o9yieN4uS0mWYbyAPi91i+fCAL4wa57R+b9YRhVhfVFPgOfaXFjBZ6tzSvVjsa23/J
 5//bPZj+8HqapjrzLKDhLegnWX/Zw6GHPenyiRxBOHLyR3Pff0iRCzCYZVImY4wv1MKk
 RdSBBgZhdTV0rIWoxvx4+F8E/KWt9BPS099QNDrHJ2wrgpgJQ5Izz+VlohKjArdURycZ
 D2YAnAOrYel+u+jiAbqdmdrUYHZAYx6EIRcyoWemfYAtysfvOUmglwoCXalXben+o1zz
 4WRRrT4U/niqe62DE97K3EBNaQg5ZnrzNN3cpatDDN3naQOdGp78nNfMcI+0aE97lBme
 l+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vdYFqw0mtrt94tSkrO4u7McJF8Aj13wOqeIAobdtUUo=;
 b=DV2pZGoxNcU3vfZce46tT0Ro5MZOTh2i5BODkb6Nte1GmWxvQD7cRIvkgRFMX3qz4S
 f3sYRMnybW8DNKf1tfxOmgkLT83Y+2r7ptHiXk+SSscHvaq+QW44fsGkN4Az2+2n0M5N
 1tPKH8mbq0WIrSzHXpHjkRw4pkHqsM3HcxqyvD8MYjKRz1zLGyWwCQ1ke8ZVN1VhsdBn
 Q5vA3Y1Jf4coPV+K0jWevherK6MJRcItLYb0VHe2yVeIswSv4O3IFCo1D7M1XvmTqus9
 RY1WK+L/+g1LlJGF2bZLdMgid8Qud8ev5tqt/KsoXOiE9TARJEMv0xIKhwwz2nJ/112B
 fvug==
X-Gm-Message-State: AOAM5308eimcpot4JPSKZKDM7LUh8xbhD6gdBzFGahyl7BNJFJwGbcug
 mKknOTgH6ndn/hgSjOOJ511NKa3itie2MJGlI3M=
X-Google-Smtp-Source: ABdhPJw7uV/qQ9siwVUmnhlrr9NeQ3g4yyAlZAC1uv+osjqiu03LkXuYxNmKvU2xcW+4pnlLIOzI+UDe7IIBeNu02kg=
X-Received: by 2002:a4a:d794:: with SMTP id c20mr9964467oou.23.1631551779292; 
 Mon, 13 Sep 2021 09:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210909165628.1927131-1-michel@daenzer.net>
 <9bf1d2d42a1488e3e1253841fd7ead146e1bc42f.camel@redhat.com>
In-Reply-To: <9bf1d2d42a1488e3e1253841fd7ead146e1bc42f.camel@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Sep 2021 12:49:27 -0400
Message-ID: <CADnq5_NUnvX-35bMSZYc16R5BsdLwdwP9ZZjzSJhaqqHa_KtrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Drop inline from
 amdgpu_ras_eeprom_max_record_count
To: Lyude Paul <lyude@redhat.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Guchun Chen <guchun.chen@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

Applied.  Thanks!

Alex

On Thu, Sep 9, 2021 at 2:07 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> On Thu, 2021-09-09 at 18:56 +0200, Michel D=C3=A4nzer wrote:
> > From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > This was unusual; normally, inline functions are declared static as
> > well, and defined in a header file if used by multiple compilation
> > units. The latter would be more involved in this case, so just drop
> > the inline declaration for now.
> >
> > Fixes compile failure building for ppc64le on RHEL 8:
> >
> > In file included from ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h:32,
> >                  from ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:33:
> > ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function
> > =E2=80=98amdgpu_ras_recovery_init=E2=80=99:
> > ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h:90:17: error: inlinin=
g
> > failed in call
> >  to =E2=80=98always_inline=E2=80=99 =E2=80=98amdgpu_ras_eeprom_max_reco=
rd_count=E2=80=99: function body not
> > available
> >    90 | inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1985:34: note: called from h=
ere
> >  1985 |         max_eeprom_records_len =3D
> > amdgpu_ras_eeprom_max_record_count();
> >       |
> > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > # The function is called amdgpu_ras_eeprom_get_record_max_length on
> > # stable branches
> > Fixes: c84d46707ebb "drm/amdgpu: validate bad page threshold in ras(v3)=
"
> > Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > index 194590252bb9..210f30867870 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > @@ -756,7 +756,7 @@ int amdgpu_ras_eeprom_read(struct
> > amdgpu_ras_eeprom_control *control,
> >         return res;
> >  }
> >
> > -inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
> > +uint32_t amdgpu_ras_eeprom_max_record_count(void)
> >  {
> >         return RAS_MAX_RECORD_COUNT;
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > index f95fc61b3021..6bb00578bfbb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> > @@ -120,7 +120,7 @@ int amdgpu_ras_eeprom_read(struct
> > amdgpu_ras_eeprom_control *control,
> >  int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control=
,
> >                              struct eeprom_table_record *records, const=
 u32
> > num);
> >
> > -inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
> > +uint32_t amdgpu_ras_eeprom_max_record_count(void);
> >
> >  void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control
> > *control);
> >
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>
