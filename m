Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA1CE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 15:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8999A10EFED;
	Fri, 20 Dec 2024 15:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="a9UT4Y0Q";
	dkim-atps=neutral
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8545810E4DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 15:24:46 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1228274f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 07:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1734708285; x=1735313085; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wkAvDgDciEvC+xZ+jSk8aQQ0//liLUg2T4crIemtaeQ=;
 b=a9UT4Y0QmusKEJnoU+IizoJ3kjTipNHk8S/UDUhWi88StsFyvJNgS3RisszMyJtGy6
 P+jxDAa/0FRXDAdwfYq1JH0OpJb1Q3urRqZ95hEbIDtXgrpv2OPwLXV+CFOav2gO9v8K
 tdbFXkWRRjA32JTPlcaAhFWaIh5CvWDt+MUK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734708285; x=1735313085;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wkAvDgDciEvC+xZ+jSk8aQQ0//liLUg2T4crIemtaeQ=;
 b=UdqSPG+CQ/xroweHczou8LLYfuJabX6wYhsoSNWVObtIo51unWD1dYfSVeJAxL6q1R
 XVePpgpBB0kbOkq/4AVZLwNfiRyOUgRUg0V6itVOOnelfKwfo/Ksdug6GBGqzg4GLEW8
 u2s7+occlmnXg72PeA7q8+LPVccvcoG1q+LncOceq37eXbye60NOXrrSnmIDXbbj4lc7
 WJ0nii5jDoodMNzRcg4b8JtfSmq+3QE4VsaEbd2eDpxW0S+Q9FGN/BoKtWSjSxMWcTWy
 FGEi/P2JiiGfJrHXhlZfJKxlBA5I+hQJMORedRJOh2imVbMGdgHRrkIJApsuR5V9DPYb
 VFew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNvT387CvhQnGl3MwoKaD5r4N28hSLKvK+JSEKxPNcSZisVMZv6SRYsNsdbYDIUvtmLYX9+cuN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzVEFH3/ElNgT1TKw7wYLVwuwRL5Ufg9pdmEcR6UXQ1NaVh1Qp
 YUwi+7GAx3pbGwDcWPForqYIzl6nucwRj/plcVksjcK9kraIj2fKq5HgSnPOHVM=
X-Gm-Gg: ASbGncvPJa8Yiq4AZmGVcocgpZKHFYtv1ywYB7SIoKc/EkpxyWUSUCpprLrgFMW8RTN
 7TkBOTF86DoKAhgkXEjND8iorm07dk4Xi+FF3jZ46oQ4ihDSL77YNV9tvrptYhTbNOcnq/1fatW
 Zh/Us3Sdq6gXppG3gDbFIMV/E5xR8uIkFXFJZmtRp/Q6JRW4mt43zWikXQb8QdBatLnCs4Ve/lD
 Juvv2IXXZ/v/3+qQzyFyL/0xTzu6d53vEKWZgclE8mrsrJG0XWeCb3vKbwsu6kqeu5K
X-Google-Smtp-Source: AGHT+IEGfHgFo11olpo8hGr1wp+wToYVIUekn8l0A7B0qIcvxSYXFPdt7rKBuVQqrXYMcGOcT66poQ==
X-Received: by 2002:a05:6000:4029:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-38a224083afmr3120496f8f.50.1734708284754; 
 Fri, 20 Dec 2024 07:24:44 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474b6sm4292325f8f.51.2024.12.20.07.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 07:24:44 -0800 (PST)
Date: Fri, 20 Dec 2024 16:24:42 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc: Daniel Stone <daniel@fooishbar.org>, Brian Starkey <brian.starkey@arm.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Marek =?utf-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 ML Mesa-dev <mesa-dev@lists.freedesktop.org>, nd@arm.com
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
Message-ID: <Z2WMOmPCYajdtAeN@phenom.ffwll.local>
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <uffsfaps6a75zmkyshkwfxgybcslqrnfqqtjzekegdptvwpugc@2ndpcuxyfp3f>
 <c64cb9d8-5ea7-4644-93c8-04a97b758fa0@mailbox.org>
 <h26quuebhpxwkc3fl4vtfteoqyvingnddgxbnzptfnxfg6xgkd@kkkmeqwplomv>
 <8dae97c9-9286-451a-8122-b309eb21b2f4@mailbox.org>
 <Z2Ki-lQH4Fbch6RO@phenom.ffwll.local>
 <q45c43j5kwwvemec7mcs4kqzt54pa3nz3jlhkcky2v63s2vfie@him4q253uw4p>
 <CAPj87rMFJ0JRvsKqZUsw_EGrFWr1VLO4Ne2w_bZ5cH+gs_d=og@mail.gmail.com>
 <688f69c5-a7b7-46eb-89ef-379c3f5c7632@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <688f69c5-a7b7-46eb-89ef-379c3f5c7632@mailbox.org>
X-Operating-System: Linux phenom 6.12.3-amd64 
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

On Thu, Dec 19, 2024 at 05:09:33PM +0100, Michel Dänzer wrote:
> On 2024-12-19 10:02, Daniel Stone wrote:
> > 
> > How this would be used in practice is also way too underdocumented. We
> > need to document that exact-round-up 64b is more restrictive than
> > any-multiple-of 64b is more restrictive than 'classic' linear. We need
> > to document what people should advertise - if we were starting from
> > scratch, the clear answer would be that anything which doesn't care
> > should advertise all three, anything advertising any-multiple-of
> > should also advertise exact-round-up, etc.
> > 
> > But we're not starting from scratch, and since linear is 'special',
> > userspace already has explicit knowledge of it. So AMD is going to
> > have to advertise LINEAR forever, because media frameworks know about
> > DRM_FORMAT_MOD_LINEAR and pass that around explicitly when they know
> > that the buffer is linear. That and not breaking older userspace
> > running in containers or as part of a bisect or whatever.
> > 
> > There's also the question of what e.g. gbm_bo_get_modifier() should
> > return. Again, if we were starting from scratch, most restrictive
> > would make sense. But we're not, so I think it has to return LINEAR
> > for maximum compatibility (because modifiers can't be morphed into
> > other ones for fun), which further cements that we're not removing
> > LINEAR.
> > 
> > And how should allocators determine what to go for? Given that, I
> > think the only sensible semantics are, when only LINEAR has been
> > passed, to pick the most restrictive set possible; when LINEAR
> > variants have been passed as well as LINEAR, to act as if LINEAR were
> > not passed at all.
> 
> These are all very good points, which call for stricter-than-usual
> application of the "new UAPI requires corresponding user-space patches"
> rule:
> 
> * Patches adding support for the new modifiers in Mesa (and kernel)
> drivers for at least two separate vendors

I think this is too strict? At least I could come up with other scenarios
where we'd need a new linear variant:
- one driver, but two different devices that happen to have incompatible
  linear requirements which break and get fixed with the new linear mode.
- one driver, one device, but non-driver userspace allocates the linear
  buffer somewhere else (e.g. from dma-buf heaps) and gets pitch
  constraints wrong

> * Patches adding support in at least one non-Mesa user-space component,
> e.g. a Wayland compositor which has code using the existing linear
> modifier (e.g. mutter)

This also feels a bit too strict, since I think what Daniel proposed is
that drivers do the special LINEAR handling when there are variants
present in the list of compatible modifiers for an alloation. Hence I
don't think compositor patches are necessarily required, but we definitely
need to test to make sure it actually works and there's not surprises.

The exception is of course when non-mesa userspace allocates/sizes the
buffer itself (maybe for an soc where the display is separate and the gpu
has stricter stride constraints than the display).

> Ideally also describe a specific multi-vendor scenario which can't work
> with the existing linear modifier, and validate that it works with the
> new ones.

I think that's really the crucial part, because adding modifiers without
an actual use-case that they fix is just asking for more future trouble I
think.
-Sima

> 
> 
> -- 
> Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
> https://redhat.com             \               Libre software enthusiast

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
