Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD3CCA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 11:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5750310E7B1;
	Wed, 27 Aug 2025 11:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hMOKcIoj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EAD10E7B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756292910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3PjxlAWf7veWGNv8WxmuluBCo2cmlQimJC4dQF/7vCU=;
 b=hMOKcIojpMtY6qdr3F+RLu97ElOIpF3xX4RjfiwLk1kSOyhRB2zyP6e12RgK1fitsbdnbQ
 R5uOj+QkoX+NqzagYMZzngnu8micYiyTvj7+1ykN3ZbdAX2Wc23AYZLemXm0oqUAHaAoen
 LNeSMyOkKQtqUifu6EtknHGrwD1QOOY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-A5y4AQReMp2dn1fh_aUBgA-1; Wed, 27 Aug 2025 07:08:29 -0400
X-MC-Unique: A5y4AQReMp2dn1fh_aUBgA-1
X-Mimecast-MFC-AGG-ID: A5y4AQReMp2dn1fh_aUBgA_1756292908
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3cd34034c02so251988f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 04:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756292908; x=1756897708;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3PjxlAWf7veWGNv8WxmuluBCo2cmlQimJC4dQF/7vCU=;
 b=DDz8OvVAvA9qExtfC61l0nSSfMfN8Ayfs19XCxMbNGYHAIqXMrjzmaXUC0EkOsh3Ba
 7x7fHijooS+sOANb3tDMOYEXAaHfdosA1LnSLfcvquPoGBdc8/0CvyX0tXWclSsTlj5Y
 pKhQpqSgo5pLQYpalWWVeRdt4LRZWANRGAkfp/fr+Q/LSoj14FuamVroKX2c1Q6Wq4xV
 y7GEY6n5RYU7APd0ric+nFjKa7A8xxpcaCoEWtAPzfG+8Nz0KhI10vE4PpFG8rRPdhbC
 T2mBSUDggmldyUpqYCLRl26GfDIWNhxIgHVyAij6Goc3zTZqQX8GycbM5h+cfy5c7wCF
 jjVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs7gPu4OHXHUj9JEZ7OagJUzq0X1Tq76nEfxz0xZIHyvcwylgCsh3J0XJ9vvSjMXK0vyr/Yz6J@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpBjdPy6ATy+d244FCMaCNuOgK8WdCoE38SF9O7XY9kCQzeXvm
 Ayv0IK9MB9l2V9AIRfQmIGSyaj6thXCEX/14NWLlcVbpQp1KIoGZG2D3Lk1TW3aloxY27nMHRJv
 59h1i6a3eLS7jP45YJ7+l+ptbnd4htnbLlXZp/5g8CKRem6m180hapooLG8Qzqjm3B2A=
X-Gm-Gg: ASbGncv06hMo8oYh2YGHc8mP72emyPuowfMDrQBGqB9yjrTCedAEuKNFAbA3nxWXSrX
 qhTMgnqVqbHOCEuSOb1IvqS+Zr+8elY2zeX9XLd1v3EpONIvnprUg+MP+gVgac8EdbsvX616iG3
 ASYuw9BEwsIsfWmZ71ETbVcjcklPfeeOzheC+qNZ+y6dGHlJAxZCMWXuri0A9bGKhk8/gbziqI4
 eQmJTCE9XB3XPGXUGHBBBDlhHh+x8KNCMarNIiLP+d67z72YDUUMBQ++2UxyMzlXmR+6mxHIgmg
 vbsjNdKk76VrmILxCoKJDWZpk7zZDlU2MEdQBgECofergQ==
X-Received: by 2002:a5d:5f46:0:b0:3c5:c344:ffb8 with SMTP id
 ffacd0b85a97d-3cbb15ca309mr4023094f8f.12.1756292907961; 
 Wed, 27 Aug 2025 04:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnbaAqjIreMNe/bzEU3jkon+3zC2R03YKoR/bFzRlaIY/38ozGFFh2vpp9cdD5NjXCSRmsZQ==
X-Received: by 2002:a5d:5f46:0:b0:3c5:c344:ffb8 with SMTP id
 ffacd0b85a97d-3cbb15ca309mr4023053f8f.12.1756292907494; 
 Wed, 27 Aug 2025 04:08:27 -0700 (PDT)
Received: from localhost ([2001:9e8:898f:9300:ff23:be77:f1bc:ffc8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70ef566dcsm19986409f8f.24.2025.08.27.04.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 04:08:26 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 27 Aug 2025 13:08:25 +0200
Message-Id: <DCD5VIFRKFB9.1KHIZI3ASID2I@redhat.com>
From: "Sebastian Wick" <sebastian.wick@redhat.com>
To: "Daniel Stone" <daniel@fooishbar.org>, "Maxime Ripard" <mripard@kernel.org>
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
Subject: Re: [PATCH v2 0/2] Add "pixel_encoding" to switch between RGB & YUV
 color modes
X-Mailer: aerc 0.20.1
References: <TY4PR01MB14432B688209B2AA416A95228983EA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <aK1hPoCmLziaPPOd@xpredator>
 <TY4PR01MB1443219A9870877AF120FE63B9839A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <20250827-imperial-mongrel-of-dignity-712fab@houat>
 <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
In-Reply-To: <CAPj87rPhK+E2FP62fnNxFySDOkqqKxo_oa94i7DR3_6a1j1o1A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vN4kONIy4mxQ3VIPL2sl9N9MAG1KaaBtwkqf3qNTmlk_1756292908
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

On Wed Aug 27, 2025 at 12:39 PM CEST, Daniel Stone wrote:
> Hey,
>
> On Wed, 27 Aug 2025 at 10:41, Maxime Ripard <mripard@kernel.org> wrote:
>> On Wed, Aug 27, 2025 at 12:26:56AM +0800, Shengyu Qu wrote:
>> > 1.Can you send patch with only i915/amdgpu first? It's a long-needed f=
eature
>> > to deal with some monitors/TVs with broken EDID.
>>
>> If it's to workaround broken monitors, then it's really not something we
>> should be doing using a property.
>>
>> Most likely, those monitors don't support YUV* output and will just need
>> to be forced to RGB, so it's not something that the user (or the
>> compositor, really) has to care about.
>>
>> And it would be broken with every driver, not just i915 and amdgpu.
>>
>> We already have some quirks infrastructure in place, the only thing we
>> need to do is create an EDID_QUIRK_NO_$FORMAT, clear
>> drm_display_info->color_formats based on it, and you're done. No uapi to
>> agree upon, support, test, and it works with every driver.
>
> There are other reasons to have uAPI though ...
>
> One is because you really care about the colour properties, and you'd
> rather have better fidelity than anything else, even if it means some
> modes are unusable.
>
> Another is for situations which static quirks can't handle. If you
> want to keep headroom on the link (either to free up bandwidth for
> other uses), or you accidentally bought a super-long cable so have a
> flaky link, you might well want to force it to use lower fidelity so
> you can negotiate a lower link rate.
>
> I'm all for just dtrt automatically, but there are definitely reasons
> to expose it to userspace regardless.

Yes!

Broadcast RGB is a property that only works as a workaround for broken
monitors. If user space sets it to a value other than auto, even after
first checking the EDID if the sink supports it, we don't know if the
kernel just changes the values, or also sends the InfoFrame (or the DP
equivalent).

So even if the new property was just for broken sinks, we already have a
similar case, and it makes sense: If the EDID fails to read properly, or
the display has no EDID, the kernel can't really identify the thing, so
you need something in user space anyway.

Even for quirks where you can identify something, user space is a better
fit because we can update things faster. This is one of the goals of
libdisplay-info anyway.

Either way, like Daniel said, this *is* useful for other reasons. We
want to be able to switch between quality and bandwidth.

> Cheers,
> Daniel

