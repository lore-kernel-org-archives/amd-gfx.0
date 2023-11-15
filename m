Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA1C2BB3F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 18:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F035610E157;
	Wed, 15 Nov 2023 18:22:30 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4337B10E157
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 18:22:29 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-587af6285c0so881754eaf.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700072548; x=1700677348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32VO735puFbdamdNP00HxmaLTpjFAS4aqR5oTCpG7cg=;
 b=Bkz1vHRIUpbe1V7IU1GDDc84Z9AckQKlrsG6CitYB+aH2AQyBRt7EEFn3obXBqPIXQ
 CIa5n2NXTExl08BYnFL+B6NHaHwPJM0pCw64KxVW0QJKstVVxH1VTNmY8QHkSpfgYQp2
 0mtNn2SUtKOSrRa083gawJxFiL6b7KFs5aB5COSSRrROaq+5wnFEolzJ34dJArohfZHW
 fpTl4XnQsaKRCZqgGFjU2HjWnA0s13Hau6BVKF1rtQrGxKqy21pGwoggAJ+jhtxxXTMH
 HtM4WSowXkL0cqMOW1W/bpJUUI6X/VAmiTjpMqNH4rgVvn4/9dLxiri0EP0MOUoXKIXg
 4ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700072548; x=1700677348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32VO735puFbdamdNP00HxmaLTpjFAS4aqR5oTCpG7cg=;
 b=py1lMUGkUkU0zOy4DhvuEwlV95NCFeXkgs6ADRvQRMFhqtNl+e8EL4wuHCmgEJAPXq
 GOAuBwTYUfoA2Vc9+dwTD0fS95EP/lGIm7BiWVqVAlvufYFMwVbvSrLTaXWS57NlThIE
 hwNlWW3TFF2VH7p4Jh7C/tm8BbsvxtHOnKDuNjsyT8ZTfGavUZjZWdHkZ+spsQdzrvwm
 22rUvcshbvcgJQzhgid9Q4zRtg5HABNGws+kv08H5pBIFHbwcnIorQ8ImAw14g2sK9TC
 nMQ/9jcNRKmD0EdmcWHdkQrKqHxlxvFJuU9fuTtW7clagehIF8+wMNQdyrdcDcJz0Bwu
 ut2Q==
X-Gm-Message-State: AOJu0YyYExsuX6VHeGekysnCc3/N/Y1zkZ2Gn4eZfrQH4th2YJnqW+BK
 JLyrhTASiRvTIP/V53IJW/mP5rx3cbj1UFnVJCU=
X-Google-Smtp-Source: AGHT+IEadcoahNdrfY6ZAPrKfcoQnF6RiRMMs0ykC4N9OaR6O7dANsmWRgJ1bhWI1yPaN7t07COzY6H8qCDEA7GBlPU=
X-Received: by 2002:a05:6820:2817:b0:586:abc4:2c18 with SMTP id
 dm23-20020a056820281700b00586abc42c18mr6151725oob.0.1700072548221; Wed, 15
 Nov 2023 10:22:28 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
In-Reply-To: <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 15 Nov 2023 23:22:17 +0500
Message-ID: <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, daniel.wheeler@amd.com,
 hersenxs.wu@amd.com, alvin.lee2@amd.com, "Deucher,
 Alexander" <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 15, 2023 at 11:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.c=
om> wrote:
>
> What version of DMUB firmware are you on?
> The easiest way to find out would be using the following:
>
> # dmesg | grep DMUB
>

Sapphire AMD Radeon RX 7900 XTX PULSE OC:
=E2=9D=AF dmesg | grep DMUB
[   14.341362] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
[   14.725547] [drm] DMUB hardware initialized: version=3D0x07002100

Reference GIGABYTE Radeon RX 7900 XTX 24G:
=E2=9D=AF dmesg | grep DMUB
[   11.405115] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
[   11.773395] [drm] DMUB hardware initialized: version=3D0x07002100


--=20
Best Regards,
Mike Gavrilov.
