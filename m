Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B242C77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 15:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5061810E337;
	Thu, 20 Apr 2023 15:26:30 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E8C10E337
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 15:26:29 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-54506afdf60so504670eaf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682004388; x=1684596388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/KfYaP1TPUyaOgULACpAai/DFofpxEc3gjRhI9Tu9Q=;
 b=nF/eO+nEwtwCrtWtA5tX5YUhOwTENG5CaLuUFbmox3i/ioYaug7iJR1iYF0Vyru568
 69MEa2s9f476ijEz8R6kELWR7yOwxvUa+QFVTX3812y3ykVJQtC1COuEHi00hK0hz8Fj
 fu3UbVrcMqCrEq+IeNih8QgBPdYCl2ACW6PlQeYYB/P7g1M1EOGhE4JniXnk1PiqLZCf
 msWUimM6f+kyJYEpFrDInVhFa4w9E7Nbo8UyeO+TqO6c/PEpHyKL2vRCzLSN2DdB5sMZ
 jd2rBeNxVIitf5kamslGYpIIuiNYgsGMKJWgFe5R00MFug+mIbjoeAhbDldfutUSSqUW
 UmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682004388; x=1684596388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/KfYaP1TPUyaOgULACpAai/DFofpxEc3gjRhI9Tu9Q=;
 b=d7IbAXQEBmWDdCYd66bAAgE6cwY2DCrrvxK8gVy1qakBarlqte6FaCKaukzWkldCqE
 gy1G+SNu4jArUVbr9yGTDcdciaGbMgA0CeK6tGZVDlqjzdbkua4DlwVtemJDs5kt4ry/
 eal4DRJ2GjGotJMCQ5fI5I0Yrshc/SHolV266iVnDIGp1q1iATdFE4lWJ2k9ZaUrZe7E
 PjVyQ+6xscvcUBgPZrd2Um2OjeYYtdJImQx/ZBv65IbQ+Jp3u84XsgcO+nAo6+ewbMOW
 AR8+oNUdeaDctJeLSa619Pp5sSRPuzNbn2nF9yxlsZXSvv0Y+D6D50RG+qKsHq97oQcX
 W5sA==
X-Gm-Message-State: AAQBX9fkKHWrgWMDM/WmUCOnjjLXL9b6DfwGZDDubW7l3QAToObZfKzv
 p+XzYlYTuv6SSjskmsA29VpdR/eX9DhA5+okcvA=
X-Google-Smtp-Source: AKy350YPBnt9ydsfOHOlU6gFcaqvAvv456Qx+ldUaQra1+1Hm/DtZChG2yN9MHErBEBASHO5kVEEq5dyEtgX4fmfrIw=
X-Received: by 2002:a54:4189:0:b0:38e:8377:3102 with SMTP id
 9-20020a544189000000b0038e83773102mr428606oiy.4.1682004388178; Thu, 20 Apr
 2023 08:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230418221522.1287942-1-gpiccoli@igalia.com>
 <BL1PR12MB514405B37FC8691CB24F9DADF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <be4babae-4791-11f3-1f0f-a46480ce3db2@igalia.com>
 <BL1PR12MB51443694A5FEFA899704B3EBF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <9b9a28f5-a71f-bb17-8783-314b1d30c51f@igalia.com> <ZEEzNSEq-15PxS8r@kroah.com>
 <94b63d19-4151-c294-50eb-c325ea9c699f@igalia.com> <ZEFUGSlqQu3v8ryf@kroah.com>
In-Reply-To: <ZEFUGSlqQu3v8ryf@kroah.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Apr 2023 11:26:16 -0400
Message-ID: <CADnq5_N3jFxdNVXbcMK_C0C7mMarNRxCu+F3WvY-WQPkg-L4kg@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh
 broken BIOSes
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 20, 2023 at 11:04=E2=80=AFAM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 20, 2023 at 09:59:17AM -0300, Guilherme G. Piccoli wrote:
> > On 20/04/2023 09:42, gregkh@linuxfoundation.org wrote:
> > > [...]
> > >> @Greg, can you pick this one? Thanks!
> > >
> > > Which "one" are you referring to here?
> > >
> > > confused,
> > >
> > > greg k-h
> >
> > This one, sent in this email thread.
>
> I don't have "this email thread" anymore, remember, some of us get
> thousand+ emails a day...
>
> > The title of the patch is "drm/amdgpu/vcn: Disable indirect SRAM on
> > Vangogh broken BIOSes", target is 6.1.y and (one of the) upstream
> > hash(es) is 542a56e8eb44 heh
>
> But that commit says it fixes a problem in the 6.2 tree, why is this
> relevant for 6.1.y?

It fixes a generic issue with certain sbios versions.

Alex

>
> thanks,
>
> greg k-h
