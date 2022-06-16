Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99966C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DD310EBEE;
	Thu, 16 Jun 2022 21:55:18 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6464610EBEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:55:16 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-3177e60d980so4657087b3.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Vq9XexQp1WsKZ12PaDqoDLsu2QZpN2u5hAaGMvjyz9M=;
 b=O7LqHxa4C7iderEecTp2xuGTQLn+7mZxnQyuIvg7Wfw5pYxoNxR/9EoFLvBZw0qEYn
 IaHAPELVMc05PHkiuNPwZjA/zm8EHlmYD4hplUgRR+QkuU+jQbW3QXWTPjOYCZfnKfuw
 YiuT1ePMIqv3IX8UyIk4D9vKENmuRhBQlP/T6fNAgB5wUToL20MvdKQm+BNn2SY+AQ9j
 KueTJ1kMUq4Wg3Ak1cqg7pFttEz/Vv8irDJ4lVpxURItUVbKsRU4orWhW2mqIhoHkaQi
 tWbucmpGcE8ipeIJJH97tIcWUmZo/DV85KBoK30AGewJEfDoWNqm3yewkod/em9BM2eU
 n9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vq9XexQp1WsKZ12PaDqoDLsu2QZpN2u5hAaGMvjyz9M=;
 b=6+YMjDyk81Yp0G1EO+QXkJju1rWlQb1tJjOkC9IW7r1w9eegxFvNLzaMODHA8KqEw6
 Eny2ScSXBRiJIEy/9YbwEe8lnAZh09kWDQ5IvysJGbMYBe2MoYK9uT3IVNtSlKSvGWO9
 TsVHkrJwwKUj3oU+rwxVgNpamDIWO1zRJj7OnK6E2mY8tjHBHkCIALLgEkVbgR1nz3LE
 t/6T1e/bmYZzqpM8PfkxnWExkLuWQQGQTPhNetCKuy21xpb8cZPX9dQqzilPsDsqE/Y7
 kBEEmLu3tKLWNzhaGlFtP88g7hKadJzqCrVr6YAhz0e/zcQq8OKsuoO0AaNuc4dTblyq
 TSLQ==
X-Gm-Message-State: AJIora+6R6sEqfQvTy0eAXWjOajQu1FTBLZDchBojjcTEvoKGh1+HWAN
 6n9TYe5E63vWmy4hwuSKyro25d2wMXrkLlZbgtw=
X-Google-Smtp-Source: AGRyM1vLC+yRhP52TlHpDk7Su9kiAYbPps5ThPbQVrv6K8hCdtAhdw9ZWK8P4q1Rz7zc9VuWPfg9Z93wY6PYr0W7mzk=
X-Received: by 2002:a0d:ed83:0:b0:317:50bb:5463 with SMTP id
 w125-20020a0ded83000000b0031750bb5463mr8161813ywe.149.1655416515537; Thu, 16
 Jun 2022 14:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <629ce27f-2e51-0ef5-8965-06655bd1cacc@amd.com>
 <1600846598.614955318.1655416110530.JavaMail.root@zimbra39-e7>
In-Reply-To: <1600846598.614955318.1655416110530.JavaMail.root@zimbra39-e7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jun 2022 17:55:04 -0400
Message-ID: <CADnq5_M8eq0SGM9D7zLRFDpWJfcuXgDBHj2Vv7SYt-VHxR3zpQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
To: Yann Dirson <ydirson@free.fr>
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 tales aparecida <tales.aparecida@gmail.com>,
 Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, maira canal <maira.canal@usp.br>,
 Melissa Wen <mwen@igalia.com>, Leo Li <sunpeng.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Simon Ser <contact@emersion.fr>,
 Sean Paul <seanpaul@chromium.org>, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 16, 2022 at 5:48 PM Yann Dirson <ydirson@free.fr> wrote:
>
>
> >
> > On 2022-06-15 10:34, Yann Dirson wrote:
> > > Nice!
> > >
> > >> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> > >> b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> > > ...
> > >> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega
> > >> Gfx,
> > >> RAVEN/PICASSO, DCN 1.0, 9.1.0, VCN 1.0, 4.1.0
> > > ...
> > >> +Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega
> > >> Gfx,
> > >> RAVEN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1
> > >
> > > Those similar-but-not-quite lines tend to confuse me :)
> >
> > I guess it will be easier to visualize this data after build the
> > kernel doc since the csv file will became an html table.
>
> Possibly, though my surprise is rather that 2 different lines in the
> table have the same label in their first cell.  Do RAVEN/PICASSO and
> RAVEN2 really share the same product name despite different hardware
> blocks ?

Sort of, the first column is marketing names.  Various Ryzen 3000
variants are Raven or Picasso or Raven2.  There are tons of parts in
that series: Ryzen 3 3100, Ryzen 5 3500, Ryzen 7 3700X, etc.  Same
with the embedded parts: AMD Ryzen Embedded V1202B, AMD Ryzen Embedded
V1807B, etc.  I'm not sure how feasible it is to put every SKU in the
table.

Alex
