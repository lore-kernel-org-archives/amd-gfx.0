Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D8CC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F21310E0E5;
	Wed,  7 Aug 2024 07:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="XewQP6q6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459E910E0C0
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722990869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DagaqO54H1hJQjj4Zorc+QbXn/0BrO+jb5kx84xfhk=;
 b=XewQP6q6L6ZSI7l6P1/1qiBnt26fhDgMwr9rCsS1sPBmjaXZQOh0uXCX7ybKAMHjok09V1
 kQCEUwxkKV6J/kFwfKi17N/WNV3oKBNw9NATQWH/XqOnG+gQprcATOtxamyAxOyW23aav0
 bKo8t2ckZRBNDKrC3GJ/vycODl2Zrzc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-dl43cBNiMPu3cS9pL5lawQ-1; Tue,
 06 Aug 2024 20:34:27 -0400
X-MC-Unique: dl43cBNiMPu3cS9pL5lawQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F327195609E; Wed,  7 Aug 2024 00:34:26 +0000 (UTC)
Received: from localhost (unknown [10.64.240.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A070C1955F3B; Wed,  7 Aug 2024 00:34:24 +0000 (UTC)
Date: Wed, 07 Aug 2024 09:34:22 +0900 (JST)
Message-Id: <20240807.093422.216266980826553532.yamato@redhat.com>
To: michel.daenzer@mailbox.org
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: fix the ioctl direction for
 DRM_IOCTL_AMDGPU_GEM_VA
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <f81c4c1d-e834-4c1a-a2bc-9794f94a7f7a@mailbox.org>
References: <20240806024310.3650332-1-yamato@redhat.com>
 <f81c4c1d-e834-4c1a-a2bc-9794f94a7f7a@mailbox.org>
Organization: Red Hat Japan, K.K.
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 Aug 2024 07:41:18 +0000
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

>=20
> Hi Yamato-san,
>=20
>=20
> On 2024-08-06 04:43, Masatake YAMATO wrote:
>> Though drmCommandWriteRead() is used in libdrm [1],
>> DRM_IOCTL_AMDGPU_GEM_VA uses DRM_IOW for encoding.
>>=20
>> [1] https://gitlab.freedesktop.org/mesa/drm/-/blob/main/amdgpu/amdgpu_bo=
.c?ref_type=3Dheads
>=20
> AFAICT libdrm doesn't read from the struct drm_amdgpu_gem_va it passes to=
 the ioctl after the latter returns though.
>=20
> Also, while amdgpu_gem_va_ioctl (the ioctl implementation in the kernel) =
modifies the struct:
>=20
> =09args->va_address &=3D AMDGPU_GMC_HOLE_MASK;
>=20
> that looks like an implementation detail which could be avoided if necess=
ary, and shouldn't be propagated back to user space.
>=20
>=20
> I'd suggest fixing libdrm to use drmCommandWrite instead.

Thank you.

After reading this mail, I inspected drm_ioctl.c.
I was surprised that drm_ioctl() uses only the offset from DRM_COMMAND_BASE=
 when choosing
the real handler for a cmd. Therefore we can switch from drmCommandWriteRea=
d to drmCommandWrite
without breaking applications using the library.=20

Masatake YAMATO

>=20
> --=20
> Earthling Michel D=E4nzer       \        GNOME / Xwayland / Mesa develope=
r
> https://redhat.com             \               Libre software enthusiast
> 

