Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B257EB597C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 08:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B057010E205;
	Wed, 11 Feb 2026 08:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WW3VRSvu";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA99010E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 18:44:29 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b8ea0a386cdso73403466b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770749068; x=1771353868; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/vjg7jBZyNSnOMcxeJ/7tKwSwZwzjChFHxfqJ1Ig5Ic=;
 b=WW3VRSvuEw8CY1Feip3vVxQOcN/Ccy5cbT3ie++CGnMoQiig4DbD0lkSPbDaR3KY62
 OxkmJKDLJzkS9X1c7ptLgi9t66FnF46GcDC9r/N8xDjUElebEClffaVJ/gDNdQsBJxVe
 69hVvznri4HLXYwMXr+m6L22E9GjJDNAUOEpuoHj4Z4VFI7rjKrEP/Z5y/R5Axe0n44t
 1Wa4ow6svu2wzva9kesy91gOmJr+CPE7pDoqrOJvVREFJF9I4UQl6CbdboXkzLlR/oMI
 ElEy9HzuYX2Gqiauqc5A9RGLg3hKVfk+7tI3hrBXY/3uCevY1vA7K/R2BrJfMVWNwfKl
 niGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770749068; x=1771353868;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/vjg7jBZyNSnOMcxeJ/7tKwSwZwzjChFHxfqJ1Ig5Ic=;
 b=IEyOUljx/pvmx4WxJBxkniwWx7+PDN3tRyPUEhXjaDXEfdHw3PZReUs474QobWjgK9
 TFbMRuvCwWfz4/UqPXEjkGLRJovtV5aFWL32Wl/EPt/39/wlID0hGY1WWUz1qeEE5WC3
 DQslVdxPqiW0wzGq5wR52cCCFcdXG7905hAx+4hPxYOdwurcmCql0zev4oCAdgRolKkz
 MuF9qrl19ONCj659Nkkc/WURH5swjU86Xo3mcaH8YrZrqT9OqN8t7Bxa+0zi21CwgkZ9
 oYj4zeMYFdhVxt2uKgYun5oVtF5rpQLR3UVoeHRypXWBcL4aYI3F7U0DcgQkoSetw9wq
 /YJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9h5zJSiie2/t4SCjO/ZvWfuaq6/lM8+qPVzdNOjJ6f99VYTle9tTgOH4S/S/zyOenHdH7++U9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOAfrNZwsduWPS5DaMDezHKdHIhb2JOcLlbgF50U/M7bKdi+VO
 Ox9avgtvxgMJ4O6cbaeKSKOq9uFIGZPozQMdMl42KBg0h6qIRGe4m2kn
X-Gm-Gg: AZuq6aL41PBUOmPsVACMKYTUaRWsxY6ErBzbxxgOCKNxYG7/jro6pWL21k9jkl45Ylo
 ymTrZBuOGv5PPCYLYD9ggK9bqqmPYRqx5JyAn4L4vQbzyd93+zuhC8+BjlAfMcCdTRP4gvZh7nb
 ie7N8E9sbLI4NyZ+mHzY+fLsdUxW3iCR0w7gOft5H/5p/+PN25JMCnoj0dKjRbvLUyXklHhzPTh
 Roslzit1zh+9Hvw4aPsLQFj/6Ib7jtTmCsiIObmzBTCvzNgzhIxNluidqUjpoO/q/2rz8RiYeOw
 jAUB7sRm/ufALNkMFoNCsKgDsEadB8gDgiVZWpwL0Omk6CyMDVKlrD2qap+ekrYQN8SovVCCuUH
 CF8oYAIMjfFwpqQPlATBA66j0oeK6oUtq3RZ8zbJSlflwhKc6izPAqZYnBnCwCMIawVe9akZFWX
 B0ri/LrWrz04WjVE/rqdveiBvKWkDKiykvYmzHW9sbvEJKY+fU7FdOEmt32TNWC5/r8FeZ4+d2V
 M89HQUpo8g=
X-Received: by 2002:a17:907:9709:b0:b8d:e665:d653 with SMTP id
 a640c23a62f3a-b8f54cd45e4mr106196766b.7.1770749068016; 
 Tue, 10 Feb 2026 10:44:28 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edae3bab5sm537503066b.61.2026.02.10.10.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:44:27 -0800 (PST)
Message-ID: <1002281ca27d58a47a47fb655a88637e49776706.camel@gmail.com>
Subject: Re: [PATCH v3 16/19] drm/amd/display: Add parameter to control ALLM
 behavior
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Harry Wentland <harry.wentland@amd.com>, alexander.deucher@amd.com, 
 sunpeng.li@amd.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com, 	michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Date: Tue, 10 Feb 2026 19:44:25 +0100
In-Reply-To: <CADnq5_PhcNPU=4s1P30OqbWY7qPD3dHmjEtoz4_Md41u=xaxFw@mail.gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
 <20260203185626.55428-17-tomasz.pakula.oficjalny@gmail.com>
 <f19af3c6-f865-4758-8c50-aba40ec1cf68@amd.com>
 <79264ab170e48e1372b3b847d75f4635dcc57aa6.camel@gmail.com>
 <CADnq5_PhcNPU=4s1P30OqbWY7qPD3dHmjEtoz4_Md41u=xaxFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Feb 2026 08:09:45 +0000
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

On Fri, 2026-02-06 at 17:04 -0500, Alex Deucher wrote:
>=20
> Also, maybe a per connector kms property would be preferable.  Then
> you could change it per display.
>=20
> Alex

I've dealt with all Harry's comments but wanted to make sure I
understand properly. Do you mean, that the two settings should be a
connector property like VRR_ENABLED? I understand the intent and I think
in some time, it would be best to have these exposed in compositor
settings but how would a user control this until then?

Would it suffice to fire IOCTLs from a third-party tool like LACT where
support for this could be added in a short time?

I made it a module property in the first place, because I thought such
settings are pretty set-and-forget and module properties are just easy
to set :)

Still, I think the defaults are sane. If I have to spend some more time
to get the connector properties working, I could send the patches with
the module properties ripped out for now.

Tomasz
> > >=20
