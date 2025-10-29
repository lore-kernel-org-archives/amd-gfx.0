Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57634CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:48:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B1A10E790;
	Wed, 29 Oct 2025 10:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FBJajNBa";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2835710E790
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:48:44 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso1677899866b.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761734923; x=1762339723; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQ1iUsCuDn1lt7whBExzRGFwabZ4hHWfLLe5ml9YZRk=;
 b=FBJajNBa23ADIhAd99nihQPp4WgESvpG9OEZaq2UP6mjWgFxwuyFrU+DbTonWcanc8
 xnJnKCSKbXs2zacBTbNFUpavGP+XkLu9RWLtcFRCB6aCjmp3rH8rWG0UQjeKO/nwdG7e
 OFl5n6P4rZKy0DdTrEDq4HC4ZQB09yE8Z3dMmRaFZdxCvts1FE/KQGNnlzUau6VABogF
 u7k8Ue+o6XOHN/kcN5U67nkj2Qb5lORB7vucaO+tzv+DV48/epqTCK3OEMYfmqmCkMYp
 uzh+yNHmR4IjC1ve0eSMvn3QGmFu3cG3Jq5mUmFCdN01WFSyJ7PWeMXI9j2l9wsaJ8N1
 zn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761734923; x=1762339723;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQ1iUsCuDn1lt7whBExzRGFwabZ4hHWfLLe5ml9YZRk=;
 b=LlCVqO3uyVMr2J1TGPq+pAsuSfau30n2V9Cb3B7mBt6s1yOXtJkRCv8Gi7/qZvvXia
 klJkoQD4zooK795/UufdOI54aXbrRDf4eid0yNosDorkEbcH446Sy06nBHqNKsoKG9Ir
 riqesFCL2FV8XFSACxyMZUbBlKZf8GRnqsqgdBM3qGbVI4Bp99feftr+1DUDSUOZRqov
 zgchR0m+CwGF0h/4IL6lvQUqHkbR9JMHlS00Dt+sffon8emQcPgiH5Q87xJZs+XUct5H
 8nq8+5XZWbuiSc4Q1fYk3gY2Cv9P/QLX+J0R9ZO6mV9Q/jvpRCj5DPd/V7gq7q3cDUxM
 iUyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf7ASRU6CEHhA32PCfXTEJxBHRrDbG/3TghlL/2Q9KLGBvWSUSP1vdeaJJ8HjwCTivDiqOnBMY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxi7W0fAjVPhf8RZziF9q7Uuy6De6PC4QZHIYovTML96lOBRSu8
 foSZyXboDgVZiF5BsVokK3WeEC+/gIBnL5OiRJRzG2FQlCm3WZrMQd+J
X-Gm-Gg: ASbGncszQjD4KWBjrrG84CAHbtTZZFigfFPymYvO5fwqC4Yw+dq5l/FL22ZAy0+q24k
 XvraAG3QEAQgVNJMA6oQ5p15UcORB3GVviiS9N8pmi8kx3O8s277f97nKx1daCSrTON1r8lkm7R
 BE9roUs1qJTqIgrPaDIVgPLWt+/sSlib+WzLtWikJ75qObIRpwxnEZg1NzeAib0+GxuECjpz/mc
 hSCAvfrMe8qlfxdtEsOuCy5/afUGzS+C96/xqv75sYb+Hz61aiHf6cXWa/0N83u+/Xg7u1HrnwL
 IF7QIWPA/s5rT2H8DvG0rY7FkjaO4xvLTs6NLmQhOc4SdTo4sFSrDq4gEsEl6Hcy2ZTRVPfi+24
 K3XzA6j4s4PZxzSif7lmDkGwWrs1H1b4W5bv6Kclbo17zcHMJEfBZv4D+awHFo6lQOMj3lIN09a
 9dir0+NKxHYXrRiXsDfU5Fq7B98szXGPqh+qqfN6TKaVku6tpFXU8niJoXzC5u6jyu97pglHyaJ
 FpxvuiePLhnMOfFK7KR8VqHpn+IKLCYT//2ZBvGf32G
X-Google-Smtp-Source: AGHT+IEn6KNbH5Zu5pmWuG5+klUzp50xzDKAwMogD5KvCxFPlpCsoZ5YuZUp0uVoMTTOqtJ9kTGFDQ==
X-Received: by 2002:a17:907:d8e:b0:b54:8670:7c2d with SMTP id
 a640c23a62f3a-b703d55d49fmr234823566b.55.1761734922354; 
 Wed, 29 Oct 2025 03:48:42 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8541fb5bsm1382534366b.56.2025.10.29.03.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 03:48:41 -0700 (PDT)
Message-ID: <2f0591f9dc2dadac72e8def5977afdc0a1e876b1.camel@gmail.com>
Subject: Re: [PATCH 05/14] drm/amdgpu/vce: Clear VCPU BO before copying
 firmware to it
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Wed, 29 Oct 2025 11:48:41 +0100
In-Reply-To: <baa0105d-3b37-4e63-8232-4f45976a3e7c@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-6-timur.kristof@gmail.com>
 <baa0105d-3b37-4e63-8232-4f45976a3e7c@amd.com>
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

On Wed, 2025-10-29 at 11:19 +0100, Christian K=C3=B6nig wrote:
> On 10/28/25 23:06, Timur Krist=C3=B3f wrote:
> > The VCPU BO doesn't only contain the VCE firmware but also other
> > ranges that the VCE uses for its stack and data. Let's initialize
> > this to zero to avoid having garbage in the VCPU BO.
>=20
> Absolutely clear NAK.
>=20
> This is intentionally not initialized on resume to avoid breaking
> encode sessions which existed before suspend.

How can there be encode sessions from before suspend?
I think that there can't be.

As far as I see, before suspend we wait for the VCE to go idle, meaning
that we wait for all pending work to finish.
amdgpu_vce_suspend has a comment which says:
suspending running encoding sessions isn't supported

> Why exactly is that an issue?

We need to clear at least some of the BO for the VCE1 firmware
validation mechanism. This is done in a memset in vce_v1_0_load_fw in
the old radeon driver.

Also I think it's a good idea to avoid having garbage in the VCPU BO.

> The VCE FW BO should be cleared to zero after initial allocation?

To clarify, are you suggesting that I move the memset to after the BO
creation, and then never clear it again? Or are you saying that
amdgpu_bo_create_reserved already clears the BO?

>=20
> Regards,
> Christian.
>=20
> >=20
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > index b9060bcd4806..eaa06dbef5c4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > @@ -310,6 +310,7 @@ int amdgpu_vce_resume(struct amdgpu_device
> > *adev)
> > =C2=A0	offset =3D le32_to_cpu(hdr->ucode_array_offset_bytes);
> > =C2=A0
> > =C2=A0	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> > +		memset32(cpu_addr, 0, amdgpu_bo_size(adev-
> > >vce.vcpu_bo) / 4);
> > =C2=A0		memcpy_toio(cpu_addr, adev->vce.fw->data + offset,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 adev->vce.fw->size - offset);
> > =C2=A0		drm_dev_exit(idx);
