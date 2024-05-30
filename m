Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BB1C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 13:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D503D11A934;
	Thu, 30 May 2024 13:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PM0d1muE";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1273F11A612
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 13:17:09 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2c1b9152848so243689a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 06:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717075029; x=1717679829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lrR0F6NwP1G8Q4TJCXB4TMu40D0ygkOQsh9747J6r0=;
 b=PM0d1muEMiM6tlH6tOvKj1AvOH+v1CoX+FmfSAzw3znGm5uTKVwOAKimZjxIjbYaL+
 vEoZMbFlrgiXVQ7Pgevigmr+0VPqLcAjuUWyH+9Zkv6ucOo/sMk6DkeOXueowSnCvx68
 fxbqXlcOHbdr/9cZSJ+DPAGP3Hng5BIG0yYaGKpVHuo3HE7vrJCfEQFMDLT/4xZGewob
 khQ7sbJk0fBPDWTEumA7xUbmd5DKbfs/HU5RAiUZcTDK/elQ9VRunC22g9VEtYkpeRFu
 fsEdYg/Jj3ulE7+PxjYs/LQS+L72sOe7pYycYxW71hk2E+BYYUYbP9nknSjGRd7qVNB4
 cOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075029; x=1717679829;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lrR0F6NwP1G8Q4TJCXB4TMu40D0ygkOQsh9747J6r0=;
 b=jaBlyEKX+utSNZnthqM+Lx13XRiVYye4EvQaVqOLj1sZgow1OdQBce5VzXLJ7pV9md
 F7xN4UiqGOzBwCLPqubZq7VxXGTZJNB1hOWuI7U03LM6pyNhX/4ghoQNynl0Q1RRh8rb
 TZvq1GHpggMGZwhPrbSAioqBC9ZqD9vbRPSyVTifEbWFmoXqJi/zvBc/Ry4p8jb8UXko
 FSnq10fs9LywydwBd63nCXlvgj/9yLI2+uJUaVbxIcO+6pLFVjwuBrDVLT3QQZKtBKzj
 QQEoAjTrKQ+r2JoEHGecRAdlmzPSTtpHu1l7cUnWDOUZ+Fn2vnCtjbBwvkvK13TIK75A
 uW5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgzwPjwkwtxQBXhFvgYzk2PtNXNskDPZJ7aDZsvwZzLV39+J78ByS2rDnXaKVRFLCWjGACHBXSLvprB82WeL+qiQOQeMGsbAr1yV1Cng==
X-Gm-Message-State: AOJu0YyEtdaSGSrWz/46yvPrST1kKmXNG50EhchVk7T4gTDAslFb3hG4
 jXEf8hyE2ooXrgQvOcKhQviEtDL35wcyPh4+omN6DUNI1cM4e29CdXSJDiV2LYwtNL8WNuD8xWH
 fREy42B0HoO9OhuyIkeeG3k77pR1cEg==
X-Google-Smtp-Source: AGHT+IGBhwoDb58h+jyzsL4b5pGy9KtHG9fEiek/I1hJnatDDoenPgk4Yf322cPBUh+jMRW/pnUVxC7RSty9/AslPAc=
X-Received: by 2002:a17:90a:b38a:b0:2b4:fe80:1b1b with SMTP id
 98e67ed59e1d1-2c1abc7b93dmr2036426a91.43.1717075029164; Thu, 30 May 2024
 06:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240529114621.11795-2-wsa+renesas@sang-engineering.com>
 <BL1PR12MB51449A1977FA06BACE4FF306F7F22@BL1PR12MB5144.namprd12.prod.outlook.com>
 <fhhtkw24ntbf7ahdtmt67stvuevi2sa7gg6sxyxezrrn3p3nn7@2ryodpxsm5ed>
In-Reply-To: <fhhtkw24ntbf7ahdtmt67stvuevi2sa7gg6sxyxezrrn3p3nn7@2ryodpxsm5ed>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 May 2024 09:16:56 -0400
Message-ID: <CADnq5_OTOYLYLE5d_nXiu+b3edBZBc88wha6qs8hDypOUURzag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update email for Evan Quan
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, 
 "Ma, Jun" <Jun.Ma2@amd.com>, Evan Quan <quanliangl@hotmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

I'll send out an update.  Thanks!

Alex

On Thu, May 30, 2024 at 9:12=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Evan no longer maintains the SWSMU code, it should be changed to Kennet=
h and Jun (CCed).
>
> Thanks for the heads up! Kenneth, Jun, will you send a patch or shall I?
> If you send one, please add:
>
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
