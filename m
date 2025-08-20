Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85353CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 19:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E505210E278;
	Wed, 20 Aug 2025 19:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AMBV6FfY";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A094310E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 19:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755718848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNhhKj8XIxu4y9Bto5lKVR6sjGIFrxndrATAmTOdffs=;
 b=AMBV6FfYnMpQi6BqaqOD50do40ZtgK5Hu7hzwNzgAy6GrrTCtKlT/GAmMrE+RNe5Y84/PU
 dhcYbBUok8cZgpWPwDuj4JVNl6JRSvQ5giPA1pLdz0zxH+NR2/ZbihtiDrIpqIObL/JT2M
 Pv2EG4POMirZbWnJ7wtACDgjtWToPVQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-nmxTqiFAMNKisAV6tXKHgA-1; Wed, 20 Aug 2025 15:40:43 -0400
X-MC-Unique: nmxTqiFAMNKisAV6tXKHgA-1
X-Mimecast-MFC-AGG-ID: nmxTqiFAMNKisAV6tXKHgA_1755718843
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b9e418a883so146313f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 12:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755718843; x=1756323643;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SldETWHwn7m3fzEtOzKMZjITNOf1gcsK+qNewxq3ttA=;
 b=pOCC3l6a3Id1/At9kPhqL9A+zsxgUCwW38F5e71u+lpDLWoEkcDa13RGw/zRLV+wWr
 5DkC/u+9FGLR9NoGOgw/+NCk20rAeWOPHiesZFdM1egvT38JS3VYBKRFglLtU45IyIrr
 GQyfYOmxdNp97z1JuYDNBvtQpFaSiGGzxNQDFs7IKcZi1eBb99DoKfDk01zc2puqLh7N
 hhoAngxT4qnvXNgmnE7zMIEScPVdldM11iSmkq1o60I6t6uBKonuK3xGZ/3Q2VViPa3n
 YMPPFMhU5nNrWp9e3ozMgugU2tddL4zzJ2RzyVlnQFIh2/eMGHywHO86oIcYRNR1LwC7
 JZ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWKFW1mQgkmMVmSCX0imU4TRzVsiNBvC+w8A8awKPSMYFOltxIDB5rpqzXCzRGLFTaJKyhdFxz@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywkkX7Fpd2fvK+ni1znMI0k08WhCx+NHcUOgWjrX1xsZZL3kX/
 M9JzKjrtVttQHQ92LNgTEycGrxohkzIC61AykZmlTQU6gnv0TJjnc6aEeKrWr/x7Frhn2dTXWmb
 y1JK/SLVqpTVQ7AX0BNBKSuJEX1IAHhC/wvJ8DmvfwEyJ4aXwpA5zm3dSXGQauKeODx0=
X-Gm-Gg: ASbGncuBiZHtBa9iJLpkfJYmYlWWpflHy/8XvKn/9gJW2CkM75ERu7HKnSHPWdrQuUH
 KHw4jDRfiCN+MNuFWAssCOOf2q26aLBpAeCYePrvHGYecEek5Wzo45/1JvZ6/RSJnmD7bXu5QDY
 XBwY4QjUYEsKyfA07cz8YXBjHApcaaUtqQZmbz1iCdRV5xoJ/suzxM510PA5G6/pX9L5f9jPDTw
 9Fo52dMDaaE0hAEKPnt04kdtDB70L52Gqu9LMAW7U9d8aDZaudIl82xcNfsdqWpKuIDdYjV8ynW
 MW9nhUtLQcGvjkVpvs6weUpa0yokukvcbwD41URbWVVaXA==
X-Received: by 2002:a05:6000:228a:b0:3c4:3d9b:d5a9 with SMTP id
 ffacd0b85a97d-3c497741e82mr18539f8f.61.1755718842605; 
 Wed, 20 Aug 2025 12:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZCKQP/KQ1XqUipshI512eP4eaXPmwe8S1JNsPShIAfnDbMBAM1qN5Hq0PQtSLeWP9szgKEQ==
X-Received: by 2002:a05:6000:228a:b0:3c4:3d9b:d5a9 with SMTP id
 ffacd0b85a97d-3c497741e82mr18526f8f.61.1755718842156; 
 Wed, 20 Aug 2025 12:40:42 -0700 (PDT)
Received: from localhost ([2001:9e8:899d:e200:81f1:3d49:5938:f438])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c9e1a3sm48555645e9.18.2025.08.20.12.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 12:40:41 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 20 Aug 2025 21:40:40 +0200
Message-Id: <DC7IDWLAGEOW.HQVRVJNBTLXI@redhat.com>
To: "Alex Hung" <alex.hung@amd.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
Cc: <wayland-devel@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <leo.liu@amd.com>, <ville.syrjala@linux.intel.com>,
 <pekka.paalanen@collabora.com>, <contact@emersion.fr>, <mwen@igalia.com>,
 <jadahl@redhat.com>, <shashank.sharma@amd.com>, <agoins@nvidia.com>,
 <joshua@froggi.es>, <mdaenzer@redhat.com>, <aleixpol@kde.org>,
 <xaver.hugl@gmail.com>, <victoria@system76.com>, <daniel@ffwll.ch>,
 <uma.shankar@intel.com>, <quic_naseer@quicinc.com>,
 <quic_cbraga@quicinc.com>, <quic_abhinavk@quicinc.com>, <marcan@marcan.st>,
 <Liviu.Dudau@arm.com>, <sashamcintosh@google.com>,
 <chaitanya.kumar.borah@intel.com>, <louis.chauvet@bootlin.com>,
 <mcanal@igalia.com>, <nfraprado@collabora.com>, "Daniel Stone"
 <daniels@collabora.com>
Subject: Re: [PATCH V11 35/47] drm/colorop: Add 1D Curve Custom LUT type
From: "Sebastian Wick" <sebastian.wick@redhat.com>
X-Mailer: aerc 0.20.1
References: <20250815035047.3319284-1-alex.hung@amd.com>
 <20250815035047.3319284-36-alex.hung@amd.com>
 <DC6IG8LQAIF4.6KM7AM5JD3J3@redhat.com>
 <f3061c6f-5a73-4890-92b0-90f153e8dcc0@amd.com>
In-Reply-To: <f3061c6f-5a73-4890-92b0-90f153e8dcc0@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OdnV9h9Ete0m_jYZqvJy_r7AYBCj37lrR9MdwLqD6rg_1755718843
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

On Wed Aug 20, 2025 at 8:16 PM CEST, Alex Hung wrote:
>
>
> On 8/19/25 09:31, Sebastian Wick wrote:
>>> +/**
>>> + * drm_plane_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_L=
UT
>>> + *
>>> + * @dev: DRM device
>>> + * @colorop: The drm_colorop object to initialize
>>> + * @plane: The associated drm_plane
>>> + * @lut_size: LUT size supported by driver
>>> + * @return zero on success, -E value on failure
>>> + */
>>> +int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct=
 drm_colorop *colorop,
>>> +=09=09=09=09=09struct drm_plane *plane, uint32_t lut_size)
>>> +{
>>> +=09struct drm_property *prop;
>>> +=09int ret;
>>> +
>>> +=09ret =3D drm_plane_colorop_init(dev, colorop, plane, DRM_COLOROP_1D_=
LUT);
>>> +=09if (ret)
>>> +=09=09return ret;
>>> +
>>> +=09/* initialize 1D LUT only attribute */
>>> +=09/* LUT size */
>>> +=09prop =3D drm_property_create_range(dev, DRM_MODE_PROP_IMMUTABLE | D=
RM_MODE_PROP_ATOMIC,
>>> +=09=09=09=09=09 "SIZE", 0, UINT_MAX);
>>> +=09if (!prop)
>>> +=09=09return -ENOMEM;
>>> +
>>> +=09colorop->lut_size_property =3D prop;
>> I'm a bit confused here. The property itself is just called "SIZE" which
>> looks very similar to the generic "DATA" property. However, it is
>> assigned to `lut_size_property`.
>>=20
>> Is this meant to be to be a generic property where the exact usage
>> depends on the type of the color op (like "DATA"), or is this meant to
>> be specific to LUTs (in which case the generic name is misleading)?
>>=20
>> I also tried to find the user space documentation for all the properties
>> but could not find them. The only thing I could find was the kernel
>> documentation of
>>=20
>>      struct drm_property *lut_size_property;
>>=20
>> Which says "Size property for custom LUT from userspace."
>
> In earlier version, this lut_size was specific to 1D LUT and 3D LUT has=
=20
> a dedicate lut size field in another struct, and lut_size_property is=20
> now used for both 1D and 3D LUTs.
>
> Do you mean we clarify by making either changes?
> 1) "SIZE" to "LUT_SIZE"
>      -> specific to LUTs
> 2) "lut_size" and "lut_size_property" "size" and "size_property",=20
> respectively
>     -> Can be reused in the future, if any.

Yes! I would prefer "SIZE" as I can see other color op types which use
the "DATA" prop to require this as well.

The documentation should also be adjusted to say that the meaning of the
"SIZE" property depends on the color op type (same as with "DATA").

