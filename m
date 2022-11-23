Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C248C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 15:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1974F10E583;
	Wed, 23 Nov 2022 15:41:23 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA0710E583
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 15:41:19 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-14263779059so20400305fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBFRSqlYOwtaIVBS8uOA18h5aNWy4YZuN2S8A9cVBqw=;
 b=EyXCVCJFBthJUrLuLPlBR9d0VYPOdqX5QI0px6XWRb0xwLjeSYpVzWCExWM0Xno67P
 mluETmNlAlZlZkY9q4kj/obZ0dAewGCG+Gvkz7NVN2MsPpNS4+XPPFSuN/MGddzR/6FZ
 GSiHEeD7LT8UI+swwzsBd+8CVdw+vg56YQREWTGxkibvitfO0FOzvJEn46e+fnKjMqO8
 GSLH83ArmSP91R/mKTXH0NHhGWMIGbLuKKUBynrwKr1GrK7Zb0621VpsDYGyfw5gXTO2
 Fz+79WIUvfCnQr/MhmCrhnTvsf2+2EnIcOuKDZOqNsPN9yAPhVbVAxoV/54mb0EoKF+6
 xyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBFRSqlYOwtaIVBS8uOA18h5aNWy4YZuN2S8A9cVBqw=;
 b=Xc0vRoW8re0tKj8UBhLZJhG99q0CED6I/g9Vp4znH9UBvkGAfl1vIK2A5JWQK0am8o
 aUfstmK4X3P0ghFsIikiIauCulFO41EiBJUCJOur1DoXP+1CUhub8R1DyvuGJC/MJ6ee
 7BO9WBU4KWzuU7AkzUAmr/noru5LZdrFvdBDIhWlYQ4Jsc+CmfXrkIZJr7VoDY7K7RcK
 M0FTgZkzJKXoDAFeIhagPdUaWTUevIG6kmy0iYltCzFOl0oxSYpP5tNkF3T4v7P2+471
 XzsXNioDhGXIjxpfRcpQv/xNHInjHBjBDxrZO8PBxXDARTrsyhtPE29x8WB9E0eOmvjC
 YlzQ==
X-Gm-Message-State: ANoB5plfiF5HF0nvGnOzCD/imE6mcI3qdLOtjbBv/PNThKypnXlKqlwq
 oiYczZOwFP4+ofCzjrbN+JGxzdNmhE73ZrixDw8=
X-Google-Smtp-Source: AA0mqf7seOqnf+0ewBefyfGjqAY8USomx6Kbl+zjZhh8jMYUpJG4KOMzKhQWeW+EfAQHZur56dFW5ntKrUzsMZtlLVg=
X-Received: by 2002:a05:6870:b07:b0:13b:d07f:f29d with SMTP id
 lh7-20020a0568700b0700b0013bd07ff29dmr5122345oab.96.1669218079295; Wed, 23
 Nov 2022 07:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20221123014408.263645-1-guchun.chen@amd.com>
 <24eb1835-d49f-f938-c0cc-ac8cfedaba4b@amd.com>
 <DM5PR12MB2469BEB165320703CC12E1B5F10C9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <8827a1e7-c3a1-9a7d-d774-918bf373c07e@mailbox.org>
In-Reply-To: <8827a1e7-c3a1-9a7d-d774-918bf373c07e@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Nov 2022 10:41:07 -0500
Message-ID: <CADnq5_N75ScVgvnOQ=QRF8PsW0MHUXkWFTLuke5N2RQxhbULxQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: add printing to indicate rpm completeness
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 23, 2022 at 8:58 AM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 11/23/22 07:09, Chen, Guchun wrote:
> > Hi Lijo,
> >
> > Thanks for your review. The cause for this change is, so far, except on=
e line printing like "amdgpu: free PSP TMR buffer", there are no other prin=
tings once system completes rpm suspend. And moreover, "free PSP TMR buffer=
" sometimes confuses audiences.
>
> How about making those messages not printed by default then, instead of a=
dding more?

Yeah, I agree.  No need to add more.  Runtime PM can happen pretty frequent=
ly.

Alex


>
>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
>
