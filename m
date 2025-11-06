Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A081ECCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 21:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC01210E9DF;
	Thu,  6 Nov 2025 21:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8Bq6TMr";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2110F10E9DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 21:49:07 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26808b24a00so153175ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762465746; x=1763070546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHDhed1xlMuM0l3pm//GeOi7oG2flLtrYbxUibdWkPQ=;
 b=g8Bq6TMrex5wG/sGfB+kUhLV2WOwJ5m93xCYuo0M/G3LoZfRoauyFRxZvbSzSqZgzy
 DQStvPPb/QP07uqkmMXHYOIM866JRWgwIYdkVIP/5BgqirxUVYMu7zA6meG/t/8Y6ZY9
 L8uCcZeBZQl+rj0VInSl0kmI3ptum22Sp/awyWY19bZv0ZU+ILTBnhjMbsV2/vwpKm/T
 xIJVB6WvHEJ1lODcJHNU3P5Md0Am5e+YlCaQGMvExzzQ5369oL7D3bi4JNXGoB2GRZAZ
 P8PJhas1T7/wmKGiE78rOivuUBQUQNmm0vR+BVDqpUbtoJFLGzwnrYu422tA+ONTAZC0
 wg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762465746; x=1763070546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uHDhed1xlMuM0l3pm//GeOi7oG2flLtrYbxUibdWkPQ=;
 b=M5RVnaaJdVznUElRRKt2D9YHctHkXwN8LRbx8mc16kB+SV8LNDUzFT073pzgBXIgxZ
 AoqLfF2Bxnhb6ODeokoVA3fMt5JaDVg+IucKx6yKEyYFcQJGn6+5lQPC5p/aMNy9Yf6O
 MstG9ylB/a7Z5pCZjuKtn7PG+TPVY6VuoHTnfA+2Z6TfKqS96FuRQ6hfHco+OB6OZOCG
 IwoPDDu2xfmVgZjMNO4UGKI5wcvH+r1vyFP0j0npBVce6oYjnVpSqPkskhhIgZToPzaL
 7FHqu5yXIBydal3GVAtf4YNdMTeVsbMlEgsb2sByjREDNjuWdl4mN8v5ShCevIiVxY33
 EMGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv8LqDhfgKw6gZKYTBwVLliq6Pv5FAOIIVSbmUeDwIA5WZxHhJTwO83QmoUoKU/VFNzEqWgtJJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yykpxw6T3zVn+PYbAK+6RtQ2xSL/osOkZq4nQ2AgD9/ZXIoiV6e
 uzovT30L3RagyirkB100PjzOA/sh7sLDTn50kWQ9ityafBVV7srQAO4J4j527FrCHI82B0QVtgy
 FqepHi1O8OB5oRV5rXM7eJnWlIlY0WaI=
X-Gm-Gg: ASbGncvUoHSBaN07NHllTAwTZyuGwbyQt4NlOg3mdO111Bm8SFcwNyUn93gUjnr5moh
 KzTQorFmqBgNr9PXqYQVm9Hb85P7QMCg8YoH/AxdGVqAADkr7pNiaYARFO7CRR4/WQ++AbcOhiq
 qm7ZLLOz6ZSMUZUd2jVxZoyieAzcMIAYQxt8envYWGmhElnU+KsEssxgEPWwD9gIgWIpuqFF+I7
 ch7BOsdbFi6q90J0ykQ2eQ9KFr5CGlE6/GJBBEMrvVMruxq6IgprAJKMyt/a6oBZkSsS98=
X-Google-Smtp-Source: AGHT+IECvWv8KFVYWhULL1havhRJOC/3HGgqkJSC/X+SinrENYwcrIdwHYlfpoCzI3kpR7Yxyqg5o8xR42bvXhkmZjg=
X-Received: by 2002:a17:902:f60d:b0:295:54cd:d2e2 with SMTP id
 d9443c01a7336-297c02c4835mr7390665ad.0.1762465746597; Thu, 06 Nov 2025
 13:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20251020161606.67812-1-siqueira@igalia.com>
 <pr56g6xi5ji7mrcfjr5uh6uwwf4wmbrfi2gnbdwhokowovwsk6@qvump5zll6vl>
In-Reply-To: <pr56g6xi5ji7mrcfjr5uh6uwwf4wmbrfi2gnbdwhokowovwsk6@qvump5zll6vl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 16:48:55 -0500
X-Gm-Features: AWmQ_bliaVFEsNKXwfw7KkyzobTa_i7mmMt5y_zcJ0a9mFKZWRFCdf_LNZnXHEA
Message-ID: <CADnq5_McVM9KknWanUvJejE4F38GXcdbUTOBxkrZOjsCJd-36Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 23, 2025 at 6:50=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 10/20, Rodrigo Siqueira wrote:
> > When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> > set of errors happens and the system gets unstable:
> >
> > [..]
> >  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
> >  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB te=
st failed on gfx_0.0.0 (-110).
> >  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> > [..]
> >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comm=
and: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comm=
and: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> > [..]
> >
> > When the driver initializes the GPU, the PSP validates all the firmware
> > loaded, and after that, it is not possible to load any other firmware
> > unless the device is reset. What is happening in the load/unload
> > situation is that PSP halts the GC engine because it suspects that
> > something is amiss. To address this issue, this commit ensures that the
> > GPU is reset (mode 2 reset) in the unload sequence.
> >
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 0d5585bc3b04..0a7bcb2d5a50 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3649,6 +3649,13 @@ static int amdgpu_device_ip_fini_early(struct am=
dgpu_device *adev)
> >                               "failed to release exclusive mode on fini=
\n");
> >       }
> >
> > +     /* Reset the device before entirely removing it to avoid load iss=
ues
> > +      * caused by firmware validation.
> > +      */
> > +     r =3D amdgpu_asic_reset(adev);
> > +     if (r)
> > +             dev_err(adev->dev, "asic reset on %s failed\n", __func__)=
;
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.51.0
> >
>
> Hi Alex,
> If this change is okay with you, may I send a revert for the change below=
?
>
>  72a98763b473890e6605604bfcaf71fc212b4720 - drm/amd: fix gfx hang on reno=
ir in IGT reload test
>
> The above change adds GPU reset during load time.

Yes, please do.  Thanks!

Alex

>
> Thanks
>
> --
> Rodrigo Siqueira
