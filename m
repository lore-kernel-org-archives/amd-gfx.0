Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CECC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 07:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A9910E135;
	Wed, 15 Jun 2022 07:47:27 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8905510E135
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 07:47:25 +0000 (UTC)
Date: Wed, 15 Jun 2022 07:47:10 +0000
Authentication-Results: mail-41103.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="gl1fvjat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1655279238; x=1655538438;
 bh=gGEKGgUiPAL9qtGuhamHQaUwb0U/O6lB39uD9tQoBr0=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=gl1fvjatnV2phaR6D+LKN613wHUcfUTSX24PG0wmbrUe+XXVLol8i5zQhUoFMbnkj
 /4TxjuVxurpvYO374mmSsard1gjtczfnYHmeKHa7fR+RXtivpsZ51tdaM4n/5jTqW2
 Hes2vClFuQX3YGd3+5LWZCnwG8h7BrZVDGHiG3RYziDI8+bCJHph6K0snbRLzqNafm
 JY+cU/BxYMqZrkPd9NTJMWnJvkO3PwhFZ3syuGRTD34/3BvakUawac3n2JO42SgK44
 mwdgTG6cKe+d3PbTBBp16Xn/Ls5MYp5Z5EfZhYN4GIsAZYavz8Y1DxOl2APQbsj0Hi
 lqxoAstz0kG2w==
To: Alex Deucher <alexdeucher@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 1/3] Documentation/gpu: Add info table for ASICs
Message-ID: <wXTO8YYCjZe9USXO-9_zGZeVtSuFwgspCcHzjSZk9xdRK3Q1JisYUroSqU4GUwhL4At_N8UZifT5EAQJMBu5ADnetH8zlrOJNrG0NKqv-4E=@emersion.fr>
In-Reply-To: <CADnq5_Pp+xSJO1mR24PQmm5bHhjY1Q-wC8GG97pr6axvrkmZeQ@mail.gmail.com>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-2-Rodrigo.Siqueira@amd.com>
 <pp_VMylAJoi-vp3VAJIjkeIfC89ncoHCCBFR_7ook2cjR9uC7bgBWcsjaFGNPFPgRMJHkwli2RNeXP0L32NQ8-Qvwf1IbTSyG8U5KNhTdJ8=@emersion.fr>
 <CADnq5_Pp+xSJO1mR24PQmm5bHhjY1Q-wC8GG97pr6axvrkmZeQ@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, Mark Yacoub <markyacoub@chromium.org>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>,
 Leo Li <sunpeng.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 =?utf-8?Q?Ma=C3=ADra_Canal?= <maira.canal@usp.br>,
 Sean Paul <seanpaul@chromium.org>, Isabella Basso <isabbasso@riseup.net>,
 andrealmeid@riseup.net, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, June 14th, 2022 at 20:30, Alex Deucher <alexdeucher@gmail.com> =
wrote:

> On Tue, Jun 14, 2022 at 2:16 PM Simon Ser contact@emersion.fr wrote:
>
> > On Monday, June 13th, 2022 at 22:01, Rodrigo Siqueira Rodrigo.Siqueira@=
amd.com wrote:
> >
> > > Amdgpu driver is used in an extensive range of devices, and each ASIC
> > > has some specific configuration. As a result of this variety, sometim=
es
> > > it is hard to identify the correct block that might cause the issue.
> > > This commit expands the amdgpu kernel-doc to alleviate this issue by
> > > introducing one ASIC table that describes dGPU and another one that
> > > shares the APU info.
> >
> > Nice!
> >
> > Are there plans to keep this list up-to-date?
> >
> > FWIW, my go-to reference tables are 1, updated by Alex.
> >
> > Would it make sense to add a "GFX Core" column?
>
> That's what the GC column is for.

Oh! Does this stand for "GFX Core", or for "Graphics and Compute"? The
glossary documents GC as the latter. If there is a name conflict, maybe
we can keep using the long name in the table, or document what "GC"
means in a sentence.
