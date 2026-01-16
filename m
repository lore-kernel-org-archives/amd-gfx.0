Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CD7D4A5EE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 03:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F1610E209;
	Fri, 16 Jan 2026 03:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BkEqDP5y";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D43B10E209
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 03:14:32 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1233985e56aso82435c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 19:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768533272; cv=none;
 d=google.com; s=arc-20240605;
 b=DBdQX9bD8EcCS/Xy8gd97w3wU+P4PniX3bzWCAgqdjSRWhZxJ64BbrlWbmVygZvJgl
 XklfLFFlCBRdZotfz7WS7lbkAr6z6SylQjJCEdhk3Vj150LJJdsmIAXLj5UjM3WgPlsS
 UWQAOtRiyGi/sia3XfdTFK9kDHPJGg0Tu2GqyZ2dw0UFeMUkJFc6NuRutZdBLVD9j5Rt
 rekem0QoHY56SJRbgDlvZQHhR5FPmElhPOsUYDW62fQJztehQCNVUPwbh4g9XYObB2Gd
 XLX7L2nAXGD+nZIbbhfGKObpbOjmWTbalnGrkOhMovOLns9Y+QgJccDekr6+k9UgnSW0
 7x8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y8uyqOJ2QcHQe+ruRr+rUSDi8IHNCrdMbjlnyzSx4RA=;
 fh=xGLuPbZPutjV0q7QWIjut+3G5ZichydVpfsAlDPyFsc=;
 b=M60Kxj2546UOm4LkH/oT+hvRukGU2IrOeJGcsINGJbH9oAM/762fW8K/iM/ljT65/P
 U/EfR3iEEa48vwFmqeA/aLwYBnZGMXRXEk8T03PuG0kXe+3mVsLDVo9toqVS44AanagQ
 sdP+3CxbDYci57kgu727ZPdEWnj2atU7Q0GTeQ4EAResN6adOZUxHdEf9OrggCXG11tp
 zHk4s8lDUR4nA3eTGKzfTDmesSWBrM+dG2k+ACK0RWrVAuIiDcMOt2Ol4ufAmmu8m3Xs
 ExDRInahuZlmd9CXmuWkJ+C5gayrsJeFWvtdTCH7O20/oWZ7NEB2lbDlu1Fzia/KHUv4
 4i2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768533272; x=1769138072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8uyqOJ2QcHQe+ruRr+rUSDi8IHNCrdMbjlnyzSx4RA=;
 b=BkEqDP5yy6hAHUOEyS/LiFgxFuac4wRsX/g5ZaEAoUpxR4xrZJVyeLpZ8Uw8wqLMYg
 PSh5YYlmMoiqrf1OL3fspozz+9mAu7cvdFu0ZTDywvfdEpOOIDOBSfH8o9Z2V6t9n1Yz
 MY2Y6AqHSiOY4TqILJhmI/lws22PKDcVB93+3uWkrafrktHatqPdT7kqTf7yeS+cELSE
 wjbBXTyMEpVIOuNktfJ+zJOK8SyRPcj+3CD5wK3MWP467ObQrY+p6BRVAKXtJtS3zyGN
 th1RveEyQX81T1l4gyg2zNQ61rdwo3e8za368N03Fk3pYnYKPi693o0WvcFYc2dGAdiT
 RM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768533272; x=1769138072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y8uyqOJ2QcHQe+ruRr+rUSDi8IHNCrdMbjlnyzSx4RA=;
 b=ouCgrrXIoqx+2TLoZBljJtr7FScpvKEpg9CUUjYplmx5PHb1bLeeisADF5srolUKF8
 2WmphF6vwcruZs2Jl5dgH3Z6/ViC2sJBjnmXoRIffAG93TcK++thCinbvRuVhhlc73bJ
 KwYuB27KVdJgmyamj96ThorB7TjG2jWNakrM4D898bsLluVCkb1xzo1bSeD8Ow+sKCZ3
 sIdYe8UZFH5GbumlM+flMXOHP6bkZ/a/Jhw5gW6+wQpnWOjRrQaCX/2cNZ5cjsqnRUaA
 Lbn1knFIJNSHCN0PefOhLfEbh96bvLAzTo2swothsCNm4H4zdhinBq9d0GOYy00Pm/aG
 LUfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULLUBCEHoQrnqhiISNN7OJuEuEpqisDirbc+1dyLYoKyHJke96F5M4Z6WXxwcWME9KGDHhS/1o@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxsy6m34ruHE53dA8dzXCTNXaaYOLfhNIcsv42v6y3bTTJIPaQ8
 3dxDDLcP18Gjr/GUk2x+g7bESrvISWvZyZRfE9M8zUJrAKX1goj0S5WW755kl4px09dxa2xfPqA
 MbDjyLo26Sh/nIcq5D84nX+oA85MXcGQ=
X-Gm-Gg: AY/fxX5ttRiw2oZO9ZofdHKHdtn8CI7nBd6y/OAhsPg1feYdYlOv8H+EdeKv75pWLbz
 WlmEWq1LpaEW03KP7yuJBtsezlAVh23Dp18RyDO3O3saFiyUgAu4xS7kelIVNTHzBJ0oPZI8Uh+
 cbXpvQq7XDmrAPweemO3WliBXoqWsWHW2iFMemk6MxE3ugDNZL1yj/am50sxzthGfy5G0RsHqzF
 Dk9Vyy8176tGR6l6j7ARDMc/qbkgipOvPnIi2e6t6b8e9L2bRDyyBQ6QSye9pjNkCcyZEsJ
X-Received: by 2002:a05:7022:3b83:b0:11e:3e9:3e9c with SMTP id
 a92af1059eb24-1244a817bd4mr782142c88.7.1768533271804; Thu, 15 Jan 2026
 19:14:31 -0800 (PST)
MIME-Version: 1.0
References: <Z678TNhCbTk363Tw@kspp>
 <864c7dd5-0deb-4adb-a1cf-c8a809514d7e@embeddedor.com>
 <217b00f5-d03d-4624-9ba9-d838199ef7b9@embeddedor.com>
 <CADnq5_M5Jv4A5CXAKY2Qd-dhrfmecnauRtVY_ghSsut7i=KNww@mail.gmail.com>
 <d07b4edc-6048-4c10-b8ac-dcccd5a932d3@embeddedor.com>
 <d43dac3e-122d-4c16-9c1e-760eac91b8da@embeddedor.com>
 <CADnq5_Mqa2HWWKrAYTAfjdvEQTMUeB1MBnhtRxJZjXLWcz1nmg@mail.gmail.com>
 <202601151612.79AAC91869@keescook>
In-Reply-To: <202601151612.79AAC91869@keescook>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jan 2026 22:14:20 -0500
X-Gm-Features: AZwV_QhaEijQPE2R1uX7dLX9VVSiTVRCUmrApYg-eiHu8Z06MK5pP2UxHwM2ZZU
Message-ID: <CADnq5_O4SQEmXxod8y+_9zBW1uBRJL7WpyJkcTUo1B7Pa7Yj-g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Kenneth Feng <kenneth.feng@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Thu, Jan 15, 2026 at 7:14=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 08:57:58AM -0400, Alex Deucher wrote:
> > On Wed, Aug 13, 2025 at 1:12=E2=80=AFAM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> > >
> > > Hi!
> > >
> > > On 22/04/25 23:58, Gustavo A. R. Silva wrote:
> > > >
> > > >
> > > > On 16/04/25 09:04, Alex Deucher wrote:
> > > >> Can you resend, I can't seem to find the original emails.
> > > >> Additionally, all of the NISLANDS structures are unused in amdgpu,=
 so
> > > >> those could be removed.
> > >
> > > I'm taking a look at this, and it seems that those NISLANDS structs a=
re actually
> > > needed in amdgpu code. For instance, `struct si_power_info` contains =
a member
> > > of the type of `struct ni_power_info`, and this latter struct contain=
s a
> > > member of the type of `NISLANDS_SMC_STATETABLE`, thus `NISLANDS_SMC_S=
WSTATE`
> > > and `NISLANDS_SMC_HW_PERFORMANCE_LEVEL` are needed, and so on.
> > >
> > > So, it seems that all those structs should stay. What do you think?
> >
> > They are not used for programming the hardware.  They were just
> > inherited from radeon.  All of the NI SMC stuff can be dropped.
>
> (Looking through patchwork...)
>
> It's not obvious for me how to drop that stuff. It seems pretty
> integral? What's wanted here?

All of the NI stuff has been removed.  You can rebase your patch.

Alex
