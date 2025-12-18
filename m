Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEB5D68BE4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D921810E660;
	Thu, 18 Dec 2025 13:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UZzWGDI1";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4719010E94C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 09:27:51 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso412287a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 01:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766050071; x=1766654871; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WhON1kBGSnYBcNM0Xm1HRmbA6kvcPy4xVa3dVnU4ZWE=;
 b=UZzWGDI14E+iRrfKUExSZ+LckP5ZXncDy4xbLHOTZhaUxnrW5L29+ydEyKPgRrlPXB
 up9QIpDoV6gyJohIxvzktk/swWnRtl19hzSSlAxa5QFPkNW6hB7awNBtTZgHlhUUkAt2
 aFGEyIZjh//P4r5HdGf5yfcOjjG7D6Qu8kHqwEU1ce+hFrJMVZvqmzLv76EkqNP0YrWl
 BwrmbnNAEJXVJvvp7+Z7sIeibccGAvYMxljGKnelnQe7+N27RafHoh0qmszLRi8rV6vZ
 vxk/J8VO2DHMMcpacRaarPVs96HERlaZ3WSyPHjEH0g+fQ2Qzy75Rxe1rF4gTU6IQ6OM
 A9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766050071; x=1766654871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WhON1kBGSnYBcNM0Xm1HRmbA6kvcPy4xVa3dVnU4ZWE=;
 b=CEYtSeIpBk/0Wg6urMFFsomyegOU08rMMuQGBIGVvfGLxhc8U9GYT0ywsQAyzQ0tdc
 tQptrXj15QeT3CbxbLomjA3Zh/bdTsp6rl99E3qgwFfUqnUEXc1FywhEA8o/U3Ye3gsT
 cyjO1A+O9NEpuypyFhWrOOZDhqTeKkMRH6cbTpx91KdnIocDQ3cTVFTQMQBxEZFTJuEs
 dmkHKxVtz/KL5hYeNyVg3IF57kSbk52mHQ/vg2Tia5Z7gUCK0Ri/K9I8XqdUCPgitReM
 FSxQ3OsXo5zsHcpAlUfoGsujiH31TncDWQVgTeXPfHyk1JhNd1+Sh2mZxQMYoenHepeR
 HBWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR2xfKoPgVhHflhIvHt97NIPAo0WPnXrGQcAM3Bsj1EEiTvOghV0nLS9oH1j7FOFout63OVGIF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmYTHsO/atgoMeVrQ11vNwGy0AyXgU8jjawILLb9mYWKIRhqHO
 4RGT1vWeK4HHtVoQiD3neej7YgG6azdRE9jfknVeNpGb+lqolTKjV3jKzugFk35B93rcQqMtIfE
 H5vXLvXRAumX8hBhNFsgl00BuaMXYFAE=
X-Gm-Gg: AY/fxX6SxPutv7KCk8o8QgG8GryPcAfiLqoNl0dG9R1234abIkjnCHcwACpetEb8GSM
 cp1sLLq9/l39oso45+3xwkUAHTfSOFUcQIaM7co69z94hO8zESR9Frasm1n21adF1c1k1gFQ5W2
 288ku9pVCNDa80tOWlByh+e0w9uY5v9PzuMWd+LeaL4ovWU4afRrMFZnB8792v4vA/x81zUq38H
 B6atGpJY0HeEb2NtxoqaW4EUAgCcm0oF1es++6HPxhzw0xqP+PTOJ4aW+ZPalebUobuKDMR
X-Google-Smtp-Source: AGHT+IHKLs0ErrslcEID2gTn1g4eXLSrpW08hZCMtClKxzLELJybNqXrQz/d+KWezm/XLit/WgseL42v48pJPhCJQdU=
X-Received: by 2002:a17:90b:3911:b0:341:8ac6:2244 with SMTP id
 98e67ed59e1d1-34abd6d35ecmr18544917a91.9.1766050070702; Thu, 18 Dec 2025
 01:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20251217170104.2767939-1-suryasaimadhu369@gmail.com>
 <b767cb12-3023-44cf-9d4f-2fbb40c1431e@amd.com>
In-Reply-To: <b767cb12-3023-44cf-9d4f-2fbb40c1431e@amd.com>
From: Sai Madhu <suryasaimadhu369@gmail.com>
Date: Thu, 18 Dec 2025 14:57:39 +0530
X-Gm-Features: AQt7F2pq82JBBLZ84-QX8ZbE6HiBLVP25-Wdkm6lHhN7IjjL5G6HBQRNeA59IYM
Message-ID: <CAB0uMAfx4uiXZg5HB=--0Hpnx6nD8pu4a=pWmFK2B8HHx4R=VQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dm: Convert IRQ logging to drm_* helpers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 siqueira@igalia.com, mario.limonciello@amd.com, wayne.lin@amd.com, 
 roman.li@amd.com, timur.kristof@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000001eadc70646369316"
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:38:39 +0000
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

--0000000000001eadc70646369316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review!



You=E2=80=99re right =E2=80=94 I=E2=80=99ll switch those remaining cases to=
 pass adev and derive
the drm_device via adev_to_drm(), and I=E2=80=99ll also compact the logging
statements a bit.



I=E2=80=99ll send a v3 shortly.

--0000000000001eadc70646369316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p>Thanks for the review!</p><p>=C2=A0</p=
><p>You=E2=80=99re right =E2=80=94 I=E2=80=99ll switch those remaining case=
s to pass adev and derive<br>
the drm_device via adev_to_drm(), and I=E2=80=99ll also compact the logging=
<br>
statements a bit.</p><p>=C2=A0</p><p>I=E2=80=99ll send a v3 shortly.</p></d=
iv>
</div>

--0000000000001eadc70646369316--
