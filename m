Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFA9CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 13:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA7010E988;
	Thu, 30 Oct 2025 13:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mC7Bb42W";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0DE10E980
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 13:47:53 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-64071184811so682707a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761832072; x=1762436872; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ0E/b7XoIhdTt6GVNDbn8+xoi+VoFR+HjbxIUa5HgE=;
 b=mC7Bb42WXzbjR3GKOqGC+1c6T9FYEZpKHetB/KTURG6iTSgG1Y1lN7ndCe9Dk7cqtB
 Fw+cEiaSkbPpW9njRf60Vn7Bvxf6yShdX0n4dAzCx81u/yH+MJhrZ75A15weirN3P1Ba
 IYt8n/ILiB7X2cdxlqbzuxXUwLGSI3h84xN5/l/439jacgmOJC9vFV/hxbeu+kb1/4NC
 oN9BhOIfFX8m/twmwoLJr9RIAH1Bm8flFuPIM6o5xxiz/UG+jik53PXrazQVr27WUXnk
 zt8Wu/JpUv2LAdxtPdY1bqZYBmVJUouJwpwBXU5qif4t4zXQ1qw15H508fC3MG4Hmb3w
 lZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761832072; x=1762436872;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jJ0E/b7XoIhdTt6GVNDbn8+xoi+VoFR+HjbxIUa5HgE=;
 b=iwTl4tAEvjtOOUki7f9d/LDPnjzBahKwTLWANxNZdsSKsasCSgeHTlyK0RC9Gndawq
 mQF2tzinpYQpJakut7ARMvVLkoPsLAL4M63LMzTHbNOnas+PCY/EAN5dAjHehJjVZiEr
 7GzxCPAlmD3JhRNOL+R3H3vCyzdUN99u8y9tgZkGuXoi7VTPSHagFsy/p9dSGEMFQ3A2
 kXa/mWxXnJ2PSanaVGxX4lOjSSwrNCLSew/uWBHRhDlVN3vLZQqAA2w5jMinPQx5sHct
 96UXbCw2QXsBZvIbmKfkud8AxuX42U8H+6z1dpCP77UjxWDi+OnjCVEXytYVuZbf0d7F
 oFwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1mtmuf3ghwp3EithGI4Ad5gZqYDf6VAZl7StSWO9/aJNyrs8MVBDoL+TIInDIWd73akRHRsUn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA4LnbdQDxeJ9F9Ksv9cxjnDWGZlKtPNWu/znf5tHawVU6Udul
 OR/ol5grueaEOrVvwhhh7Y0hqu0Yc+XOlzePW73TTe65iwJ5QcJ9qtI7
X-Gm-Gg: ASbGnctrFamu4zsOG+e/D2DoSDywTW3XXvBARIGEkOa8CGZAQi2Y07Oc91RYgCZo0Pq
 haVzpi7792ngeN9zthuHUrXiWToH6EQWEkJd1tmVrsgRFagypW5MDnqLUo900+cgcr+epN4MDAe
 20JxWdWyAVvMumuRPrkQzfd80ocBEl/oihZIeap9kB05pAD6sgfMouOGIlDBtGTTDutS78+frA1
 oC+lwgxsl+sdNcpyLOBeWcEdgGfdIH38voookQU8Oh4QFi8rliOVe8ntTEbZC1WZM7e3em1yZJE
 6FRIja6gaWB03DaaU2YXZM8mx48hX+FYkZPF+57adc0apYuU6WCfpN0cL83BC6i6labr1h59dK0
 t3bdremfNuei4mjI30V0wrQ332tcZ8K9THi9e4TOPb51NmPdDz+gPKld4wykk51ZwmwFN+qXcHt
 fwI6g1ArXf0bx3NBng0qAvJFW+YytW5EWHpJUkeVJ/KD1slqawEObeN2Q=
X-Google-Smtp-Source: AGHT+IHOp6ZzstP/RLGRYSF/9J1gRSpyQPA9mqc+OSVPf4gc0QaK1QrRphTGmChaPuEZQx0f2mvRdg==
X-Received: by 2002:a05:6402:448c:b0:63c:13b9:6d32 with SMTP id
 4fb4d7f45d1cf-6404439aa56mr5093435a12.38.1761832071281; 
 Thu, 30 Oct 2025 06:47:51 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 ([2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e86c6d7d3sm15121528a12.27.2025.10.30.06.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 06:47:50 -0700 (PDT)
Message-ID: <846c7fb4e4bc53cba45f089ead9c44b3e00a59b5.camel@gmail.com>
Subject: Re: [PATCH 10/14] drm/amdgpu/vce1: Implement VCE1 IP block
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Thu, 30 Oct 2025 14:47:48 +0100
In-Reply-To: <3c44c0eb-b60d-44af-987d-c29edd3991b7@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-11-timur.kristof@gmail.com>
 <9da7f3f0-58d8-4a7d-bbf9-1223e458e710@amd.com>
 <18151c2a64164be39f257a407752a5f5dab1eb82.camel@gmail.com>
 <3c44c0eb-b60d-44af-987d-c29edd3991b7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Thu, 2025-10-30 at 12:12 +0100, Christian K=C3=B6nig wrote:
> On 10/29/25 23:48, Timur Krist=C3=B3f wrote:
> > > > +	ASSERT(adev->vce.vcpu_bo);
> > >=20
> > > Please drop that.
> >=20
> > Sure, but can you say why?
>=20
> ASSERT either uses BUG_ON() or WARN_ON().
>=20
> BUG_ON() will crash the kernel immediately and WARN_ON will warn,
> continue and then crash.
>=20
> The justification for a BUG_ON() is to prevent further data
> corruption and that is not the case here.

Thanks for explaining that. Technically the vcpu_bo should never be
NULL, so I think I'll just go with your original suggestion and remove
the assertion.

>=20
> What you can do is to use something like "if (WARN_ON(...)) return -
> EINVAL;".
>=20
> > >=20
> > > > +
> > > > +	r =3D amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
> > > > +	if (r) {
> > > > +		dev_err(adev->dev, "%s (%d) failed to reserve
> > > > VCE
> > > > bo\n", __func__, r);
> > > > +		return r;
> > > > +	}
> > > > +
> > > > +	r =3D amdgpu_bo_kmap(adev->vce.vcpu_bo, (void
> > > > **)&cpu_addr);
> > > > +	if (r) {
> > > > +		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> > > > +		dev_err(adev->dev, "%s (%d) VCE map failed\n",
> > > > __func__, r);
> > > > +		return r;
> > > > +	}
> > >=20
> > > That part is actually pretty pointless the cpu addr is already
> > > available as adev->vce.cpu_addr.
> >=20
> > I don't think so. amdgpu_vce_resume actually unmaps and unreserves
> > the
> > VCE BO, so I think we need to map and reserve it again if we want
> > to
> > access it again. Am I misunderstanding something?
>=20
> Yeah, I see. But that is a totally pointless leftover from radeon as
> well which we should probably be removed.
>=20
> The VCE BO needs to stay at the same location before and after resume
> since the FW code is not relocateable once started.
>=20
> So we need to keep it pinned all the time and so can keep it CPU
> mapped all the time as well.

Right, that makes a lot of sense. I can do it, but I'd like to be
careful about it because it sounds like this would affect all VCE
versions and not just VCE1.

Do you prefer that I add a patch to this series to deal with that, or
would it be better to do that after this series lands?

Thanks & best regards,
Timur

