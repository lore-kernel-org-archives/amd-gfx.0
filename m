Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCF2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 16:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B1110E8A7;
	Thu, 10 Feb 2022 16:10:39 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC48C10E8A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 16:10:37 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id ay7so6376589oib.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 08:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eoiLVlDGwmbCvi6g1rljLcGyTm2NELytas7GDY9Zrxs=;
 b=oLTVckRNnf6W4q5NVf5as+5C1znQTmQWu6f2tSvIJWEedIpFga4Sn2iR7Xo3ek1WHz
 BaZwhlmnrqJNvlQlqsV6o9iDQt46rQ4dNVoakDxNFYWgIIcY9ePoEGAzYeRhTEKWLJ8T
 H+9t6u3Hw3lFpMc5iI2KsC/E2PutPkK1vMFATJuE7jjQq62M9k+ZnhPUfsFNZS0MKlXv
 HisBxiqpC2RrhuueKY7E6q8rQcPoBP4GRtvD23tTHPK/vP00UyTt8FRt3zwNElamW/qE
 3J77asy4Gb8G/scPDy9rt5MquCW0bbcz/R/qT1qZC1jWUcIID2MPzA7r23V0c/x76oBm
 jRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eoiLVlDGwmbCvi6g1rljLcGyTm2NELytas7GDY9Zrxs=;
 b=YzTqpTMtrnd3iY4QgdjgeREj19uHHtQ8KgXAZMqdKKwuR/GADQ5MyJkwvc+B8HZPmI
 lIR6eY7xMx5b+HjEyOT2C2684daycrRr2/8sijS5UcJEvfMXedXRbqR/PSxQDwsflNvX
 tID+IFdLFTcPOYWruKUFXjiRoYmkHNyCbXkKn7nIY2Y+Sogo7b9qsCbb6+ocE+Vhf6R1
 L2bJoAAuDbrZAnwQtEx6fVPsgV/zdqXDU2WMMuDw36d7gayLZzyI6c5CkMmtBsTYtV9w
 O0NQGNllFZevSLms0vOaMNB6gb7RbMw/1BRMZ/BvmYGvK6qZDgVMNbMyriAh6F+xaTnY
 IHYQ==
X-Gm-Message-State: AOAM531iePfjg6Ohpd2jqVoJQFSs7ktwc3ILKu/Ps/PiVwO1MEBvdct4
 bXBs5jIPBXUDvhOxZrlO71W2/GCVRz855bZZhnXV+cks
X-Google-Smtp-Source: ABdhPJwq9Fn5iolbBx67m0NUKlwdI2uEOzRiFESX8F/611KhdDH49x0gPbAk7Nqa6kjGiy/3m4xAl4hbLjbxCqk0mc4=
X-Received: by 2002:a05:6808:2011:: with SMTP id
 q17mr1357268oiw.199.1644509437168; 
 Thu, 10 Feb 2022 08:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20220210133507.5954-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5157740FA3CFB17B93165A19E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_NQDUyQYKGu3==HhzVN-tjriKjxH4mGgEuKqiX4ffo8ng@mail.gmail.com>
 <BL1PR12MB51574E5BD540B48C975D7502E22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_N3fpN=HammdsurdACixsDEbFZ_3P0SD-UEKZ_4gQBSYg@mail.gmail.com>
 <BL1PR12MB51578A1CD77547A902BFA03BE22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51578A1CD77547A902BFA03BE22F9@BL1PR12MB5157.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Feb 2022 11:10:26 -0500
Message-ID: <CADnq5_N83dyPDSyvS9vbwSRiDdiVq8at4=Do-_=xzinrVDVQ6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: skipping SDMA hw_init and hw_fini for S0ix.
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mahapatra,
 Rajib" <Rajib.Mahapatra@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 10, 2022 at 11:08 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
> > > VG doesn't do s0i3 right?
> >
> > Right.
> >
> > > No, YC should not take a similar fix.    YC had an architectural change and to
> > > avoid a "similar" problem takes
> > 26db706a6d77b9e184feb11725e97e53b7a89519.
> >
> > Isn't that likely just a workaround for the same issue?  This seems cleaner.
> >
>
> The SMU doesn't handle the restore of the SDMA registers for YC though, this
> explicitly changed.  So I don't believe we can do an identical fix there.
>
> @Liang, Prike comments?

Ah, ok, in that case, it's probably correct as is.  I assumed the smu
would probably behave the same.

Alex
