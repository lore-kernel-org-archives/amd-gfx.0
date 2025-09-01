Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340DFCA1002
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 21:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C04C010E529;
	Mon,  1 Sep 2025 21:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="M8druNtk";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A3510E529
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 21:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756762360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3swOk4OyatWaOATPp01ulPoGz+0e4u+jNu0dl8fcEFQ=;
 b=M8druNtkSM8/POYROfvIT+3p+uNHhSajgovH+7cwAlZ6R2v14f4go0gMdY+v+Vrh4Yi4IU
 A3Ir6blAXJ5yvUc/ZLHUFlsR/cB2nzceGUoLehsbI0KOPMzdnOTtpP3WbgG5zOhUiHavJq
 ywcGVRkGJoQbLkmXqVME7O2oMbZGKTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-wDN2MO6OO3GrFosOQcQrzw-1; Mon, 01 Sep 2025 17:32:39 -0400
X-MC-Unique: wDN2MO6OO3GrFosOQcQrzw-1
X-Mimecast-MFC-AGG-ID: wDN2MO6OO3GrFosOQcQrzw_1756762358
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b883aa405so14893435e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Sep 2025 14:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756762358; x=1757367158;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3swOk4OyatWaOATPp01ulPoGz+0e4u+jNu0dl8fcEFQ=;
 b=FXkZzbOeJUEFJkhH7U99IM56OXcdbs7lOuI14Q+mMo8VSWrm0JeBSje++nqVaQjfGQ
 TgGY7xxI8N4iwcmsuqvzYg2ZLgFcdcjKEebFsNrrIzCNvPuCCMDmzp8x2y3XKahWAodr
 i4KIfKi/KnLi090gq6IfXI2n8FmE17Eq8IicW9OcyQ1AL/Ht09dPUHPLPiz+Aou4Y6q7
 81b3T9mmcjiMpL49CHhvmjXtyUEEJBf6fz1qJ/ithPzHejXLdKVqcLbDSxrzRjuBmQba
 1oreHs7alg7bViP/EBrQBBILMLW2jR2O9VIvWhbSD+L+foiRqiNlo/E89A5kxL3HGvHx
 BuuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCk7hRAJbAzVQXdVftOa9ANHxD5XYNToSqkcliVzaY9chXYsq6Z/fotiKHhQoCOiNYqBGWeG67@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG3j0ePPMxNWFcsSnJWGgiq5q1fJH76m9JKEELjxiMdeVHSDMy
 dCceXi4iC6RAYcFN3iDDVwWAQURLnEQSYNpt5t+ICd3huNpidbZAGLqPf8Ksj6Vgous/OKT51g7
 cytZxCVVAiTzwHV18Vw42frKWlhQZbGz1S2bAwA5K7RqvvY30Yf0sATdC08WCLD+Oh3c=
X-Gm-Gg: ASbGnctP766CfPn4gewxYC5rshidB9VpzcUkeZsQ22IxNbZTSGw6xfkTGYGBtDvk10Y
 HCWHyiI7F/0QL0gAfNOQ7+c+PxYGW41QBqIgwJKmgRWCDLjRLY6vejXY29YOjUKETy6f640QrmX
 xFqlqHcF3XmGBZoviTtRm84lhxe5jyFEUp120p+QpC3D/MBZ0BQEOuQLIA6d2q9TO8U6GqMFFur
 Q+Yn+aBI1nlr2d6CmjtI9Z+ISccBweA/hWowEsoo5LiEzPedu8A9Xr9wOldT6iNX04ek60Jm8eE
 vpVfQV0WIYoYcGv3vgqiNPCajUSmHaL2Xz/zLQnH+VbvMcrt
X-Received: by 2002:a05:600c:4fcd:b0:459:e025:8c40 with SMTP id
 5b1f17b1804b1-45b85533712mr83405325e9.10.1756762358412; 
 Mon, 01 Sep 2025 14:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAstBMuiwfLE/uHKbIRqh9Y2XLhzDYwDj5rG0gLssaFpudxwux5Z4jYtSxqSlORgb3kp/vVg==
X-Received: by 2002:a05:600c:4fcd:b0:459:e025:8c40 with SMTP id
 5b1f17b1804b1-45b85533712mr83404845e9.10.1756762357904; 
 Mon, 01 Sep 2025 14:32:37 -0700 (PDT)
Received: from localhost ([2001:9e8:8986:4700:668d:1f88:b725:6051])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d729a96912sm4912911f8f.8.2025.09.01.14.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 14:32:37 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 01 Sep 2025 23:32:35 +0200
Message-Id: <DCHSA4THF61K.1EPEN0GWLP4Q9@redhat.com>
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
From: "Sebastian Wick" <sebastian.wick@redhat.com>
To: "Sebastian Wick" <sebastian.wick@redhat.com>, "Daniel Stone"
 <daniel@fooishbar.org>, "Maxime Ripard" <mripard@kernel.org>
Cc: "Shengyu Qu" <wiagn233@outlook.com>, "Marius Vlad"
 <marius.vlad@collabora.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <siqueira@igalia.com>,
 <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
 <contact@rafaelrc.com>, <lijo.lazar@amd.com>, <jesse.zhang@amd.com>,
 <tim.huang@amd.com>, <dark_sylinc@yahoo.com.ar>,
 <mario.limonciello@amd.com>, <alex.hung@amd.com>,
 <aurabindo.pillai@amd.com>, <sunil.khatri@amd.com>,
 <chiahsuan.chung@amd.com>, <mwen@igalia.com>, <Roman.Li@amd.com>,
 <Wayne.Lin@amd.com>, <dominik.kaszewski@amd.com>, <alvin.lee2@amd.com>,
 <Aric.Cyr@amd.com>, <Austin.Zheng@amd.com>, <Sung.Lee@amd.com>,
 <PeiChen.Huang@amd.com>, <dillon.varone@amd.com>, <Richard.Chiang@amd.com>,
 <ryanseto@amd.com>, <linux@treblig.org>, <haoping.liu@amd.com>,
 <Relja.Vojvodic@amd.com>, <Yihan.Zhu@amd.com>, <Samson.Tam@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <wayland-devel@lists.freedesktop.org>
X-Mailer: aerc 0.20.1
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat>
 <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
 <DCD5VIFRKFB9.1KHIZI3ASID2I@redhat.com>
In-Reply-To: <DCD5VIFRKFB9.1KHIZI3ASID2I@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wPOQjyHAm6N1oFNRMvsGRCa2PZjHRi8rW6lcZAd5AXs_1756762358
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

On Wed Aug 27, 2025 at 1:08 PM CEST, Sebastian Wick wrote:
> On Wed Aug 27, 2025 at 12:39 PM CEST, Daniel Stone wrote:
>> Hey,
>>
>> On Wed, 27 Aug 2025 at 10:41, Maxime Ripard <mripard@kernel.org> wrote:
>>> On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
>>> > 1.Can you send patch with only i915/amdgpu first? It's a long-needed =
feature
>>> > to deal with some monitors/TVs with broken EDID.
>>>
>>> If it's to workaround broken monitors, then it's really not something w=
e
>>> should be doing using a property.
>>>
>>> Most likely, those monitors don't support YUV* output and will just nee=
d
>>> to be forced to RGB, so it's not something that the user (or the
>>> compositor, really) has to care about.
>>>
>>> And it would be broken with every driver, not just i915 and amdgpu.
>>>
>>> We already have some quirks infrastructure in place, the only thing we
>>> need to do is create an EDID_QUIRK_NO_$FORMAT, clear
>>> drm_display_info->color_formats based on it, and you're done. No uapi t=
o
>>> agree upon, support, test, and it works with every driver.
>>
>> There are other reasons to have uAPI though ...
>>
>> One is because you really care about the colour properties, and you'd
>> rather have better fidelity than anything else, even if it means some
>> modes are unusable.
>>
>> Another is for situations which static quirks can't handle. If you
>> want to keep headroom on the link (either to free up bandwidth for
>> other uses), or you accidentally bought a super-long cable so have a
>> flaky link, you might well want to force it to use lower fidelity so
>> you can negotiate a lower link rate.
>>
>> I'm all for just dtrt automatically, but there are definitely reasons
>> to expose it to userspace regardless.
>
> Yes!
>
> Broadcast RGB is a property that only works as a workaround for broken
> monitors. If user space sets it to a value other than auto, even after
> first checking the EDID if the sink supports it, we don't know if the
> kernel just changes the values, or also sends the InfoFrame (or the DP
> equivalent).
>
> So even if the new property was just for broken sinks, we already have a
> similar case, and it makes sense: If the EDID fails to read properly, or
> the display has no EDID, the kernel can't really identify the thing, so
> you need something in user space anyway.
>
> Even for quirks where you can identify something, user space is a better
> fit because we can update things faster. This is one of the goals of
> libdisplay-info anyway.
>
> Either way, like Daniel said, this *is* useful for other reasons. We
> want to be able to switch between quality and bandwidth.

Daniel suggested in the other thread that the last part of the transform
should be done via a connector property. I'll take that at face value
beause I really don't really know what hardware does. What's important
then is however to make it absolutely clear what the transform looks
like exactly to user space, to make it possible to program the CRTC
color pipeline to produce the correct values.

>
>> Cheers,
>> Daniel

