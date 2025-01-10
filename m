Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6498E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 09:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3423B10E183;
	Fri, 10 Jan 2025 09:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MUpgoNwH";
	dkim-atps=neutral
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBD110E183
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 09:55:05 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so1075292f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 01:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736502903; x=1737107703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y02XX4NwyG4kx23VEIn+0qNs3fkEPqpMNd88gxpsaFA=;
 b=MUpgoNwHfwhkzPnWJM5RzPoIE8WkWgojKR0yo1jlSHg2CAgHGqR2joq1WDktQLqEQ1
 klvxqiuO4axcIh7ToDtA6OwUG3dK+yn283RvPLJriJJEk5mbm+qbg+b4B3JWZTOTmOoF
 mjokY4xld+XIDWYXoDV2goUlt8Q5PQlKXxoEbUsHcEFsw46VCHCMZYmpMUYVznzEg1ld
 N1JKV+qDC7Huj/svmA+CGJDeSFCJtNwZ/h3TQE5VlP3UMHlXGojosVYmab5deEcSU8tS
 wtWrV5P2QcKwosmnyoagRc491ZpVazMxAI7X0RzJts2Pa52m1KKDehw5oOeOa1axKQZs
 rSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736502903; x=1737107703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y02XX4NwyG4kx23VEIn+0qNs3fkEPqpMNd88gxpsaFA=;
 b=SgYKvsE7Jo6m8fpcIGRqELO6ofDvZm9Rl1B2fJgDnq7YgLg6PMP3vVg/bL3sPp6Wjm
 yBB2U3QrsS17uWVABnRUKGH/y7lm/X+DSpvLZ11Ogf5n13a1CHkIpueRadRcXva9L2Vc
 HU6bWVFeO2YvJppYxfpyS9g2f8/OWFEki8st05YXpQno+5W+ro4/XsRRSj0ij64Al2Bw
 ghRXZnIGm5fvFDNUb7mmbwjBwMoXKZW+2+Omarmk2mvhFXR0PsKR3WiJkiP9USdVUTwL
 sEdNSlsJtOJs73zdNF7dnP26bIB7J+RgJ9/Dj4vOrZmu8+Tak/+VkulKTDzXQVizXeQe
 iUcQ==
X-Gm-Message-State: AOJu0YwSYljctdmxFZu1oI9E36QxEInd4glzmDQ5I6cnWAtp98JsMFsa
 C51kWU6ImPf/NhI8eXxBYXuyVWgtVMLUZjMguZbXJ8dufrHEZZqqezTNWwSZvoD40Qqyuv+9aAS
 Xb55mK+4RihryAljKrxcyM5MkDchljzVF
X-Gm-Gg: ASbGnctPED0pWh/ziS95DKjz+J5UsQW6f9uN+joOwogTFb5PA3yVhL89y5qujaU9tNb
 yyulL41N0I2FSym0mTeHXwGFQBw3lA4SsSAy8Pko=
X-Google-Smtp-Source: AGHT+IG/7GOBK+8MU2G+ErOBKCON0RsiH/S8nBDyBAE3LpGe8/L6eJPjEKrq6bIbh1PWywDku8cRr370K45OzxIh4QI=
X-Received: by 2002:a05:6000:178a:b0:38a:4184:1529 with SMTP id
 ffacd0b85a97d-38a872d2aa5mr3675859f8f.12.1736502903424; Fri, 10 Jan 2025
 01:55:03 -0800 (PST)
MIME-Version: 1.0
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
 <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
 <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
 <CA+b5WFEjG1DE1+_gG0qwmEf4nQZFg=9O+rHDJZmiADL5Hi7fbA@mail.gmail.com>
 <7893ceda-5260-46f2-8a87-ffb7734fa99b@mailbox.org>
In-Reply-To: <7893ceda-5260-46f2-8a87-ffb7734fa99b@mailbox.org>
From: Mischa Baars <mjbaars1977.backup@gmail.com>
Date: Fri, 10 Jan 2025 10:54:52 +0100
X-Gm-Features: AbW1kvZhnTpwStWQL3ts9qDTst5Ggw85xlwC-D_96g-nrZxVG5diNnNm8N2g9-4
Message-ID: <CA+b5WFH8hLGEnfhj14E9cfezcXbXZ=OaSf2pOegm5XFhqNTM3A@mail.gmail.com>
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 platform-driver-x86@vger.kernel.org
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

On Thu, Jan 9, 2025 at 3:57=E2=80=AFPM Michel D=C3=A4nzer <michel.daenzer@m=
ailbox.org> wrote:

> That's much lower level than OpenGL. OpenGL implementations can and do in=
ternally use page flipping under the right circumstances, it cannot be enfo=
rced via OpenGL / GLX / EGL APIs though, it's an implementation detail.

It is indeed low level and somewhat outdated too. The instructions to
read / write these registers are CPL0 nowadays. They weren't back then
:)

> A big point of GL_BACK (and double buffering in general) is that it's not=
 what's currently visible on screen, so there can be no artifacts due to vi=
sible unfinished frame contents.

Great! I suppose it will do.
