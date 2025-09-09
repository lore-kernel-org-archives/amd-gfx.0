Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D01CCAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 16:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E7410E7B4;
	Tue,  9 Sep 2025 16:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e9vduXtG";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7E910E7B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 16:21:30 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-248e01cd834so12475675ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757434890; x=1758039690; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twavimEyCpt+hWxU7SUvHffE5IVjpLZ+szv1ZgV6xvU=;
 b=e9vduXtG3nYz/9NqZk74cLkPARaTLbHfigEs1dnKJ46dEmFU2Bpa1RdFp2WmLq1poS
 fFnvzz/InFf9JbF3gyVIs6I/WoJovgVWkGfyn9K+doFTj+DT0JV/p1gtqrtExqVYjE2L
 Xv7vcH4epezooY8YA86vHf3GylP+KCZxT39pIkHMfqQ+KyWAu03WzBV7w+8Utggff02Y
 R5c5gv1FneUFveNeZgKvp6ZUDq5uRN4DdrHnJ12u6Gy0zbfCDIcY0vMCgGzJZJFMYJtC
 iZXSsXYcVV+U8Eb2Hg8jnllbtFd4bf9sLHkRRna07bzDE7EI9TP7nmk6ucwfWMn2O8W3
 EHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757434890; x=1758039690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twavimEyCpt+hWxU7SUvHffE5IVjpLZ+szv1ZgV6xvU=;
 b=nQezAvms+ZxwTRgZKHMHHE77F1nJinFw6QJ+MSYJZlB3jNc67Qq8Ajv/Eqb2KtNES4
 vCc32lUf48Z+9mnUv3Xptq/LhwU1yuFbI7dwcZI9Jr8REPpgOi8JFihaaUG8+F7ySbyk
 EL4j/IvRYCjXhUvvSja9KMCBRR27yDO6l4JSEsJYDwR2HQeA7kevKyx/iVI4ajlQP+eK
 mAajppcK/yedzWS+AePrSmce7xdBJHt1sPieqGzMUSvl3hCEcl/0H8yM/4k9do9EE0VZ
 ToHHiByqznxqoJQA5iZN0sm+2NFlI5DVf4jPpVVZdwq1Ox41O7b6AlSS0CpxULAhZL2N
 1LpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWxXPFL318hXHvNFjOvTTyCyDr8UbGqOwb+KAhi8aqLfSY14i/LZkJYlnX+khxaMc67jz8WnIi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJCeXoOB2/iCGMA/tC/ntLRfgquLOoOUMSFWkSa2JNUHAMUWv3
 dPQdwgZXFnEk3l9XZqn4iuHqiZ2Pez/0Qtg+2kijgxL/pc2cUyFKLAj2HYxHNOrmRUJYFz17ns6
 LZ3sYiTPxFAxA+IzIVnECbgowGtyGVpM=
X-Gm-Gg: ASbGnct420+MkfK1bQ9Cb1DBq1K/q9MivXeEkdUYKGxXKsm/iC0A1BFUsGwkToET52u
 /ZICxybwAwMVnUBghGb3nQqlW1UqZP2zocfgyxBFpiXApaE4kn+fbFRJCizfiL2cxpi1dm96tGV
 v2jsGuuHjGkMfzR7gwl8yuWkPtvziBVZw2XzmdoFaKwE1rUH3gNeBVKRcslX22J71fUzTgYi6HJ
 31wa0/Rn7daUGqwfw==
X-Google-Smtp-Source: AGHT+IGFmpLRHs90cmwzuNefLvj/CbyZPVvhGfVJue4Ur8IBfka1symWQMSEOXPEBIHDXCQjV6t6JT3Qe6Q8Gn8JksM=
X-Received: by 2002:a17:903:1207:b0:24d:8d39:d2fb with SMTP id
 d9443c01a7336-2516fdc7599mr92780305ad.3.1757434890411; Tue, 09 Sep 2025
 09:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
 <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
 <51ae551b-6708-4fcd-84f9-fc1400f02427@mailbox.org>
 <20250901101011.GAaLVxA_Ax0R-Wy2IX@fat_crate.local>
 <2764782f-d411-4142-aa56-f1af0968ecd5@mailbox.org>
 <20250908180022.GHaL8Zto-PsVsPa0e0@fat_crate.local>
 <63b7c020-e589-4644-887e-3922af939009@mailbox.org>
 <20250909161648.GAaMBS8ERsvv3NbJoF@fat_crate.local>
In-Reply-To: <20250909161648.GAaMBS8ERsvv3NbJoF@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 12:21:18 -0400
X-Gm-Features: Ac12FXxIrust0s1Y148Coo4wEhKxgxrPfPL0IOB8UqI-yS2cDR-dlyuYhKne0xU
Message-ID: <CADnq5_MOazXJ4tUNa5uMdkWY7ZCu70M49yG00JsNHB-FO7XNvA@mail.gmail.com>
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
To: Borislav Petkov <bp@alien8.de>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 9, 2025 at 12:17=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Sep 09, 2025 at 10:43:47AM +0200, Michel D=C3=A4nzer wrote:
> > Then the developer needs to tell the user how to enable the debugging o=
utput
> > and get it to them. That's pretty standard.
>
> *IF* the user even notices anything. As said earlier, it didn't cause any
> anomalies on my machine besides flooding dmesg. Which I look at for obvio=
us
> reasons but users probably don't.

Right.  I think there needs to be something otherwise no one will notice at=
 all.

Alex

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
