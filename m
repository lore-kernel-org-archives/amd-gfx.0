Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CACEC3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 14:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE4310E41E;
	Mon, 12 May 2025 14:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A0ZO+HPJ";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A6410E41E
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 14:46:33 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-22de5af5e14so4138635ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747061193; x=1747665993; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLqVwA910Oz+N1ZjLYrP/5SUcf9+/wqVkZckGAFbHSU=;
 b=A0ZO+HPJAbh1mF1TQuNolFQ9TBriLTycklzxViI0CRSUQTEAY1YRbsdA922vnGuWno
 pIX7pKcp3IwEiwsAyLIwmpCplLf2bXqintArl+8IK7onUufj1B1lN2+0IK+BMz9nxG65
 Xigvu7ypY6FdqNkuBV4D99I100NFqxWotpq0iJXq2VhxL6xRjmAkAdg7dEXAu/QJkRq+
 0ukGEeFUIvGz7/kC/qSopryEMElt7FECagbcb/uqUtkGt8QI+yg7+CwXDakB1c0GfP2F
 UVWH58vgnIcik/K9Rvg+g8yphHnieBtDzmhpha3xfNJ2Bt0rRkoOFvijCMRFZ4fJlXkG
 T6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747061193; x=1747665993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WLqVwA910Oz+N1ZjLYrP/5SUcf9+/wqVkZckGAFbHSU=;
 b=ljPD9PCkFJnI6j33gnHWNGmxaQWLOUaj5qjrpy71oQ9aH4eMqaTvqcJrE323UJX27X
 Cp7UbkRb9z9TOOcYBegfInIfytW0j149NIxLf4dak+rsj8jeOYysDFS3gLjYp+Fo7i5c
 m8x5LQOkQYUC52oCt2jRl04+sOIRZkTrV4hpBLYFlFmzx94Mb0q8tAGfXybeDc9YtjpR
 bck5kQweF6XR8OrLnuueMdJl+V9xtQuwNHpyMy639Nj2C+TEnzkdywEFFYb3ekQAsBQb
 mv8r1ZuczxGXmKcRoL+8vW4jg+T0koH90a4yCLLz/h3QGWtrsI1xWDpK31JPEQJDEvag
 ilRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWieFKFMrXVJn5dFnbokuiVcV73MOPXWlTszTx0jJ97GEtmNKgypmX44BcI915ti37KYWEBGCmY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yywg9f5wXylcBlGUYhcPjrWI9AI5GGhdVd8KFOZV6XvOdtcAJzg
 DJ+0U1q75ibUkzoDJttyxXvhp5I5dRZTCEvWwOY6Js2lNkJd0lQlk442fESluoS9rX5SVlUsLir
 KjN4zTbSeZb2Yril6SS4qqPgtcts=
X-Gm-Gg: ASbGncuTKZ2AHHr77ISDK9k6REXqPzW0EhGOS/s9U2VRDXrfWGJIny2LJFiOeLG0XM/
 DTFFJ6bdaMLYTNfkaJaUV8S8ZqR16hp67c2mVrugPMLtfyLLqvV7WY/9Bi+f0IklbvI9N50ThQO
 WbAIQngynM93bxvKpQ5yTa1SlSwye8gt7W
X-Google-Smtp-Source: AGHT+IENnH5CiJy9w5b5F05MU7kzwPLR9EX+eFQG19NegOYS/HTngrIDNEadQ1CCfn3YeLQ6h+DmTNX0hQmZJfYU7KQ=
X-Received: by 2002:a17:902:d2c7:b0:223:f903:aa86 with SMTP id
 d9443c01a7336-22fc8b106d0mr76317645ad.1.1747061193179; Mon, 12 May 2025
 07:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
 <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
 <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
 <D9DAIUZXIWH3.1L7CV6GEX4C9M@linaro.org>
 <CADnq5_NE2M19JdrULtJH-OXwycDpu0hrFHy42YiJA3nMYoP=+w@mail.gmail.com>
 <D9H0K4EW3XTV.1XO4KO44J1YRE@linaro.org>
 <CADnq5_PuXu-9MAhr3d7HLGnOqHR7Uo+nJPzrpdJEusvRCE8wbw@mail.gmail.com>
 <CANgGJDqZptyPK2nn5NR+OCcGHX1H=YF1vUGsqoLz-vYZjf5Htg@mail.gmail.com>
In-Reply-To: <CANgGJDqZptyPK2nn5NR+OCcGHX1H=YF1vUGsqoLz-vYZjf5Htg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 May 2025 10:46:21 -0400
X-Gm-Features: AX0GCFssUsUak1AQ1yrAFKDGy4jdp1x4SO9rABfJG55FF56FGyGeO0hrLajcuUk
Message-ID: <CADnq5_O77xrMBKX+j-b-ULQi7GJ6=nqfKhU82E7L1oUANXwcuw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
 =?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Fugang Duan <fugang.duan@cixtech.com>, 
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>, 
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 Peter Chen <peter.chen@cixtech.com>, 
 cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Sun, May 11, 2025 at 7:25=E2=80=AFPM Alexey Klimov <alexey.klimov@linaro=
.org> wrote:
>
> On Wed, 30 Apr 2025 at 17:55, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > I think I have a better solution.  Please try these patches instead.  T=
hanks!
> >
> > For the RX6600, you only need patch 0003.  The rest of the series
> > fixes up other chips.
>
> Sorry for the delay.
> Finally managed to find some time to test it.
> It seems that patches are merged in the current -rc tree so I just
> re-tested -rc5.
> All works. Thank you.

Thanks.

>
> A bit annoying thing is repeating:
> [drm] Unknown EDID CEA parser results
> and I also didn't observe such messages before on -rc2 or -rc3:
> amdgpu 0000:c3:00.0: amdgpu: [drm] amdgpu: DP AUX transfer fail:4
>
> dmesg is in attachment. But I don't think that these are related to
> hdp_v5_0_flush_hdp() issue.

Correct.  There was a DP AUX fix that also landed that was a bit too
chatty in some cases.  There will be a patch to quiet that down.

Alex

>
> Best regards,
> Alexey
