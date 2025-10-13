Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AE4CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 18:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6454910E4BB;
	Mon, 13 Oct 2025 18:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qtN0njAf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6115010E4BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 18:30:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F57945C50
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 18:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCB7C116D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760380208;
 bh=UweM+L90OGCDu2JgL8AKhNEC7OIFbFzIiTiZKCcYqIE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qtN0njAfBQ0B+t11crFgpb6Hk0VQnAhENFU67Jt+3SU5ItPie2s3PutyQ9gzujDnl
 s91ld3ZcaFl4hniBVcGq5j6ieos8EXRJ55Ttcow+N2bv4V78hYVqZdNBsoNuSTD/ew
 pPgzCGUqCenzrmDb1k6PGYtapzdqTOSLkI6GGBkUt45JzsRv4ZKEoakYcmqtFGLL3k
 oL5sNAMMkquKnLFG0bYtdeC4h6iwME1gAme5j7RXV+YOraBYstr5Waso4bEYLqZaIi
 dRG3DR8a0K4gv7Soc+kdH1nhysmTs9QShOzMj2853xL6EeRdWOC3JJtDVV1NyuCuf9
 3Mn3VpK1xGVsQ==
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-6502a6efe78so689995eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 11:30:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVbBJ1jAprl2XGxtOUeC9ypBeyeWLdcHoc1O38BhBkdec4NzuTElcHoULsblnbAYzwR5Se90XEu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNt9LQjDEm0O35miYtiVOjOkYXarDb5+9NPaPZolc+xw4Illki
 OdgIilEpbI+FkhNwU1DG22NEkuY0Jug+buK9WEUQz3XuZsfx+9CpKPEcHVxND0iew3rr3o3gO+c
 Znx5vi6nJ+bHOjyJ4kFkfH0JGxDHQ4/8=
X-Google-Smtp-Source: AGHT+IEidsorgj7WZjmq240EhlEZc8BnvKKAzSXOoGbRoYt0lU05odHT7I8aBQr229CSF34G8HWT9HQudIxjW0ChoE8=
X-Received: by 2002:a05:6808:1203:b0:43f:29ec:a210 with SMTP id
 5614622812f47-4417b3e9520mr10710947b6e.47.1760380207222; Mon, 13 Oct 2025
 11:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251013174729.1101186-1-superm1@kernel.org>
 <20251013174729.1101186-2-superm1@kernel.org>
 <CAJZ5v0jC9BBniDkODH-RnfvPNP8yYZd2QyYSAOiANfO-jCeyPw@mail.gmail.com>
 <92a24599-efc7-4684-abc0-bcf3fb203744@kernel.org>
In-Reply-To: <92a24599-efc7-4684-abc0-bcf3fb203744@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:29:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gNzfpW=ot9JSYoAbOdpWEzkoxxYx+zKkofCni3EeA-jw@mail.gmail.com>
X-Gm-Features: AS18NWA4p6B2QnnjTVdeSaW5EUz4KzwEi_ifHtYzW-l80mppmBMWYn7Koe0-WnI
Message-ID: <CAJZ5v0gNzfpW=ot9JSYoAbOdpWEzkoxxYx+zKkofCni3EeA-jw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] PM: hibernate: Nominally skip thaw sequence for
 all devices
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com,
 airlied@gmail.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, dakr@kernel.org, 
 gregkh@linuxfoundation.org, lenb@kernel.org, pavel@kernel.org, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
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

On Mon, Oct 13, 2025 at 8:27=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 10/13/25 12:58 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 13, 2025 at 7:48=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> After the hibernation snapshot is created all devices will have
> >> their thaw() callback called before the next stage.  For the most
> >> common scenarios of hibernation this is not necessary because the
> >> device will be powered off anyway.
> >
> > And how exactly is the image going to be saved?
> >
> > It is only in memory when the "thaw" callbacks are invoked.
>
> Ah; right.
>
> I suppose one option would be to thaw "just" the backing device, but
> this could turn into a relatively complex mess because it would have
> relationships (parent/child or device link) to other devices that need
> to thaw too then.

Right and that's exactly why everything is thawed.
