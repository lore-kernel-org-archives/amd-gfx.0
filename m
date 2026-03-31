Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D30F10FCACA
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B8E10EE2D;
	Wed,  1 Apr 2026 18:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="JO+eybzq";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C614010E8B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 10:47:38 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-66aed966c7eso8662103a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 03:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774954057; cv=none;
 d=google.com; s=arc-20240605;
 b=lDqy74/rDOueSjQHMPspBcduA0M2J4XG81H3dMbpoNSTcUfPx/poQFNYVjhtLoGYbA
 ruaLVSG0DgBOIrv8rL1Ifb5XgjhdxLBkSdCuJWd5R4muuWLKfjMnNdWX1TxpmGluychB
 6iiDO9hVRCtMFzYtBloPzYRt6ZUxI1E1HKaLGikdxCQsfEjgg2hqY4pY5+Ow2gTMD6qw
 PtSkijT1jWs5y08YlM01W+tHii0OqK/8kxxIvoWP/CVNuvBzj8jXn6unnwGsOvs5X9Cm
 gswqyvjxxH5ywYQj/YXONjeKW05HkLJx8pAiko+wHR/toADgNZsxpkm8c5wjM1M8PtZF
 4VtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TYDhFW6j8tFzpHRiWa4yYK8e1W306yKzReIYlUqL4Z4=;
 fh=HbHS84HLZ5RtuoXPv/X48ci7E7obO9uNv1oeFMhS3+I=;
 b=iq8tP9Zkgo7b4z0g8j6amoUXHmB/ZTVoiMcLqt3eUbVv6gMmSkWtUM7ZSOAr/xrvHv
 A8yesywmbeMkSYnLIaS7KmxWLZisUjCYn4LOqs9Lhdjp9PLeMgqNn6oz3VEx82lP7uUg
 ddxf4ga9hEIgFfk+A5z8LcIkScEx+jcKnpWUqajIJia/nujc2iVsp7IgzJdev7uvW8Gx
 BKjWN1eMH3GOb1yX8RQT9GTS5XCpYPayyEHzeUXadRGOCKPnXTHlpbSNcpVLh1iEmuKQ
 IzywE+aDxxbJ7RSobl57oj+KID/t1y66Lse6ZSHS0DiWd4qLTg1hL7WyuCQhIc7cCQ4Q
 7tdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774954057; x=1775558857; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYDhFW6j8tFzpHRiWa4yYK8e1W306yKzReIYlUqL4Z4=;
 b=JO+eybzqTjyXWD3rlMPJrCYEcyRajVDDCsizJ7UsNowcQrxwBSAYVbFwHM1e25aljs
 BzFLMe3AS75C/pSYcI/xbfi1EAi2eR48WZnu2ODESXyJf1iGXyg0U5U8GNZxqlqLVCYX
 xkzhfBsAqpg+Ptjt6NSKylPk83giQ2fNqOMUVTJlHHW962I5uNUAxAnA4iCppwZIx61O
 syqpw7dfhUjVLTAougtyJgjQiE3x1YYm6RBFBy1o16D/xjHeUpzZPf1en89gIr/Eu1A/
 idzthcYZa9O7MRuaTMjC/ulCLsm+KaEc7c1wKVxac9wjvUUuWladLqK7xvUPi3ESUAUu
 rmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774954057; x=1775558857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TYDhFW6j8tFzpHRiWa4yYK8e1W306yKzReIYlUqL4Z4=;
 b=phSyH5n2XKMQb8e57HX9QayccYjbUtJaEwZ5gPHyWxerJ9HLmF+FlHeEC6mjCmer5N
 XU/mL2SS4SurZ8mFeDKtqXK69wG8D9bBanYr8aCdyaYWFcRJqJzNJJBmP7OB5x4uBKz7
 lrBLahxROsHRDJZgsBeP1bxbfnSXeu0+o8eb6LzKzijY2cbBKVXUjEdZUV8wSgxCTNuQ
 xRQ1kLNh1HfBPwBIevkmODV6kJcYCSIexp5mwL19mGp00RnwNO/9nWW2EhbUJ1tENk7L
 kO0uXdQ4yEuRLSVa0q7y2GQJf/qLK/VXIhQO0djx/blQSxOm0TZP8sGxfRfIIhtnxonP
 YY2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOqdLD6PwrmylKQSSgHvrk0v4Td9/oHmLVnBqwVn5eQ3gyhDGjc4aWcoqWw863V2o0HNVFrC7Y@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWDnBCFMlJOmOPGSlZF129lZjmxiryj3upY8v33cspSPkV7fRJ
 lZPujdrQEOorurAgV2ADzx/pctb9tjpnmB8MGE58NFszYy8fc6OY0dMoetUdlryTR/WRw8geLd2
 RImdWtUxLpS2Dh7KoJDfkiVJ7v1sGuDeqC2XAKtO7zXQu8WSD+Wst0zQ=
X-Gm-Gg: ATEYQzxdzsv9mPUSxbAaniZO8njwWU3CY7MUcxEUJxTtmouoc/xf0AzeYUdv29c/ux8
 bzN9WgNu67LCY8/6+UIsHfKlFxgCiV7gVzMHsYlsBknZdeXvNdS7QLCoeKB2xxXRrO6YY3Bvmxu
 wEx/aqIWI25KoMy/pQC6STJ+f8zfipHxZSVEMcaW69QsCgomJDIGiB4UyaZNJD+m/UwDPpnCzv/
 bKDoZBjsABkiYboH3keBdJckIYUZti2uJ+Koez4Gd1E/gpURuo7ELS39/e9YLBNWPUytw5MArit
 NAAyBq7etdiTyGVUisp4OloAEVMX09Jn3Y36MNI7KAuOM0RCzHo=
X-Received: by 2002:a17:907:1b21:b0:b98:1062:afdc with SMTP id
 a640c23a62f3a-b9b507a5dcamr961915766b.27.1774954057084; Tue, 31 Mar 2026
 03:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260313144715.252069-1-marco.crivellari@suse.com>
In-Reply-To: <20260313144715.252069-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 12:47:25 +0200
X-Gm-Features: AQROBzC_N22-d4-MiAhm42qh_t4inoxF2-wBiYsXCMKjoQK3Cl2mMw2BuhldXzg
Message-ID: <CAAofZF7bfoL8j-CvFEHBnTcAX-y2hM+TDrPEEHbWh3kxMqnCvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Replace use of system_wq with
 system_percpu_wq
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

Hi,

On Fri, Mar 13, 2026 at 3:47=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer
