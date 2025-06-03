Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E0EC5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 11:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3838710E5E5;
	Tue,  3 Jun 2025 11:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s537sAHx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812FB10E213
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 11:38:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5781C44B95
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 11:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353C7C4CEF3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748950701;
 bh=4RRD/9bdJrUID2Ofi+LblmYzXf2AW9lr6cAlAj0OTyQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=s537sAHxRAcEDqCrld9XhzMANCFqi+BIRRAMiOrPmEPM+e8uDth/5/GTWeIPnrM9F
 CvY4kv0bEbrjlA4RxDzyhMgG8+o+Gfo7LOLuWvJ9UpoNv4sEC60cXIlnYDGYpvChmk
 1nZpNTN/VDYlqkOzvoOZLN42DfBzo2W8g/RHJVLRdpudeyO7OkCaNowefifnKay2bB
 kvrW9kaH7ZSmgsXxAijNCnR3tjopOIMLRBO4vx6O/nObU07hHmhSxI7TuUBzWmLlgT
 rRrR9R5JMQjyMzuwrOZtIivcdDVTzfE9eE3X4uPxHRmdoebyyXaUU0ZGAJc74jr9rB
 0Ceshtny1QN+A==
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-2e541e0b974so4081556fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 04:38:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVETbGWfRldXDosbWIXti4Zk+/g0gTKA89YFx43OhKLKr6yJ6XMJiukSGyhHQxE8lAoAfTltyHI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAP3/fQXYy6mkLHElE7d8iJlmQjhY0YAexog/u9+2FCxDJjRQY
 jkETu8Q4HF9EE/uJyyq4MdUKG2U9NIbTT7OsaEH5DtAAflGmoahFC1Tgj7o29domHo9gnMEpnqY
 blllNvU/5JEpxWGta+R5HZ4EkfvVyM+I=
X-Google-Smtp-Source: AGHT+IGnbL6Yg0jKhdCGF4THq7aGkIu2aR3cF60fOaQQhvw0n5LcvLT93Hb3IRqonIUkiGMArqewhjYTAxbzV3g47yU=
X-Received: by 2002:a05:6808:2011:b0:406:769e:e7a9 with SMTP id
 5614622812f47-407a66123aamr7405560b6e.35.1748950689878; Tue, 03 Jun 2025
 04:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <3541233.QJadu78ljV@rjwysocki.net> <aD2U3VIhf8vDkl09@debian.local>
 <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org>
 <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
 <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
 <aD7L0RD4HT-mEtBc@debian.local>
 <CAJZ5v0h65Gt1Fw35vp2k8kKu62+goCD8WF8u-tvhfWW6a7xHxQ@mail.gmail.com>
 <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ggPHhYcdNos2o8savvq+-zpPTaQunjOkR36k3VwF3_CA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 13:37:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
X-Gm-Features: AX0GCFtvJRJldgZgV_6J-TAl2xlbUFYP5ivr_jqfkdXJefgmF--kbl4IlROujGc
Message-ID: <CAJZ5v0gF=ewooE0cUrNfe5_inhnzq6bqw8VTjkFwr56_wrptJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending
 children
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Jun 3, 2025 at 12:30=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jun 3, 2025 at 12:29=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Jun 3, 2025 at 12:17=E2=80=AFPM Chris Bainbridge
> > <chris.bainbridge@gmail.com> wrote:
> > >
> > > On Tue, Jun 03, 2025 at 11:38:37AM +0200, Rafael J. Wysocki wrote:
> > > >
> > > > Chris, please check if the attached patch helps.  I'm going to post=
 it
> > > > as a fix anyway later today, but it would be good to verify that it=
 is
> > > > sufficient.
> > >
> > > This did not fix my test case, pstore crash log was:
> >
> > OK, so can you please enable PM debug messages:
> >
> > # echo 1 > /sys/power/pm_debug/messages
>
> This should be
>
> # echo 1 > /sys/power/pm_debug_messages
>
> sorry.
>
> > and enabled dynamic debug in drivers/base/power/main.c:
> >
> > # echo "file drivers/base/power/main.c +p" > /proc/dynamic_debug/contro=
l
> >
> > repeat the test and capture the log?

Actually, no need to do this, there is an obvious bug:
list_splice_init() should be used instead of list_splice() when the
emptied list is going to be used again.  Ugh.

Please check if the attached patch along with the previous one makes
the issue go away entirely.
