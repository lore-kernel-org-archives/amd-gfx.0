Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E9EC55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 13:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFD910EE53;
	Wed,  5 Aug 2026 13:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qW9564sf";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 219A910EE53
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 13:50:20 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38cfcb507a3so138566a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Aug 2026 06:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785937820; cv=none;
 d=google.com; s=arc-20260327;
 b=jbDTNxpilGbYoxBaD8k3putkbytJmICPioO3oRCIuJFN1o9VEVr0nXWxAAu6UZ+UAN
 r6bWqjgYz7u7R6pxAtfpJjnK63STaKeHFjNXdQQCefAllWsZog9R5XA7vX+t0R40gYXI
 7iA+Y3i2c39Md4h2n3+qHNN5QXGkw5zQEJaKeFXsPdQLq6ubkYNABX6tJO6/P0Hz6tQH
 19HQmM1phJyzAxPzjvN5hRo64LNli0OGBIOBolcwHj5iIo6xPCHrGZILUEjGVjZGEDu6
 /LvrekoTgRXNFhoy4SSUoxO0MllXHFyfiSV3iks62qGsFbJhl7mpyqRGvyA9W46+kJrE
 +3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vSQA0BsUj/4ORVqaxITdC6Co23Dtd0EUEyRHY/gNwbQ=;
 fh=4Q3X2rl3ztBeMJTRxXEgQ3SgCMA6A0RZo2JKo3J6hck=;
 b=Or/9RJqhyN+cWRCNHdC2GKH5uyWL2gWhdbZSUryLVYTgBNH60XZsQxIggW/DK1x0Gi
 Ql0OryjEe7H21YVmQ1Ki3K0JbN/8b6pnJSx1rHnObrNvHuWE+RBvIn3wGHyLSx4oZZMw
 pcJxiy3+ZzNv0kin64QpvRWhiUDjmhqdDTAt1FroE6ey2DSTQyy90lSZTWzLmmM7HOgJ
 qDhNi2FHgIB79x2sOFoGh0OmydZXIqQ3A4kL8u7xTdx2E8Q77seNsvfoHRRyaYcymlkl
 64ArDONZoUOh6YK10ignMR3gAJtRUJgXPT014KIAVHIizNU92uGTmbor+gIqpJFsrzA4
 AaHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785937820; x=1786542620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vSQA0BsUj/4ORVqaxITdC6Co23Dtd0EUEyRHY/gNwbQ=;
 b=qW9564sfF8ZyXx84fxe3t8jMrgnsmh26DSHwnwcIJyaPR9ZKFbei3SWAqzCyjbtUar
 g0ULvY0JQEmtn2WaLyeYlanYa+0n/OfkqFMDvDSIWdkFR5rv6uX2bpGWytzMGz3jrW7C
 /gKZq8swPXr3BEqUP+hb7K0FJwZrB1CfHdHfPmaeiSMa91wSkgNd2ginYtTGIyXr9NgN
 eGbjQl7+lnwRvZdGIyTbQHH3kKEbG2AHhvKblmjU9nG4osfvOX0stH7l4Fwnui4QwghK
 6UpW84iFffkJ5NNcEb0DsSwuZaaIA+Ymc30kIVlk/+DqOg/ctSWFKv1jjXNNjTzc8l17
 q5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785937820; x=1786542620;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vSQA0BsUj/4ORVqaxITdC6Co23Dtd0EUEyRHY/gNwbQ=;
 b=TpFXfKn0nYRl7Tq/frMZ0uC0txHFG/pF4/+U+W5noSw2/X8WeD5lbYATFH0Jrn7zLF
 DsPJ8f3fiBbrpiMRYtna6R8LpXbchiIrjr1tDXqc/x6Mu0y12OD+vVgmWc8TcciWQzbD
 6va6w70YMgDlVbhivUO/0KNFS6orW5iRY0FdaGGxgb/zV6ZohPj5Ii5ENi45WUGExkOd
 njpcs4x6yB5ugf5wvwS3nlhCD+8pso9oN39MQsqvbtjcZWZ7twEwbXvlDMzJyS4ygETC
 uB+CUpIJiEiT6qe3whwUW7pOtR3uiwJi7UrctqAXxfCoDiR0PNm+btJDYaX2HroZUQPG
 choA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrxy8xSRWW6gDKGcmSD2JYkIOxDlq7is1Woo/kNHBECDtCLLxXAwGS7JaUgeW9I4E+Ha6u99HG4@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5l69O5ZZ26fV1OlOC0Xr9gFPeFst3NAfQvcPQfcHn1QYkWIsE
 szNFKBSbXjbS3tnnBcfR+TMn8Ayqt1fnuxiz54zNww+B1z3HkEtke2dbE6XZd/TfpMkAE1/AD+k
 eOhVvO+yh6tEDBUk2upPxb3kR2041bn8=
X-Gm-Gg: AR+sD10/f5vlAui36VNRzSqPL3DZu1nthEwMJ75wT+sgGeIZLQiZahX7v/Nl4tkxk+U
 VX87IhLHBVMFHE6wUuDMv9pbSytS/zFTyHT8skdWjONo8cNBRAHMAqPI4NhyohAkhg8UcC7y097
 RqJcVSSU6tQOqIMWaJ3xYmoUMQIA/qqXvjSjXnepxU4xaKaDnA7RxAcbj21XmyKQ2hJop6OLC6t
 KSWrKYQ4lJbCZV32iNVZlywpWprnKV5yw6mavVb8wxijG81SJOpIi8/NeqZPCeGRNGTjiz0r5rx
 IozoABHfMaOo66czxFL8Fagtoxguq4nS9XeyBg9Yb6DbpPVt4vymyE6XXaXUa3BNND1kCaq1vcb
 QKWOTCNfz2PXYO7G36C2H69fmDU47A4U=
X-Received: by 2002:a17:90b:264b:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-3903c64c81cmr4859709a91.3.1785937819475; Wed, 05 Aug 2026
 06:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260803124533.19375-1-timur.kristof@gmail.com>
 <480843ff-5c4d-4e4d-bf20-8675105eb4c7@amd.com>
In-Reply-To: <480843ff-5c4d-4e4d-bf20-8675105eb4c7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Aug 2026 09:50:07 -0400
X-Gm-Features: AUfX_mxI9pnx4ABH-nfsfg0x3xaZDJciavhBrqoQ6Xz_csoxyuz4YSqrL97ua9o
Message-ID: <CADnq5_MUGJDoniYGTZ+Y6c++5wUjUXmCmC0-Fb8HG8-mJZpJMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set native cursor mode for disabled
 CRTCs again
To: Ivan Lipski <ivlipski@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, 
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, 
 Tomasz Siemek <tomasz.siemek@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
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

Applied.  Thanks!

Alex

On Tue, Aug 4, 2026 at 4:43=E2=80=AFPM Ivan Lipski <ivlipski@amd.com> wrote=
:
>
>
> On 8/3/26 08:45, Timur Krist=C3=B3f wrote:
> > It was regressed by a refactor. Let's fix it again.
> >
> > Always set native cursor mode when the CRTC is disabled,
> > to make sure it doesn't cause atomic commits to fail when
> > they are trying to disable the CRTC.
> Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>
> >
> > Fixes: 151164f96a4b ("drm/amd/display: add cursor module")
> > Cc: Alex Hung <alex.hung@amd.com>
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c | 9 +++++++-=
-
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> > index ab50d58896ab..d565433ea06d 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> > @@ -290,15 +290,20 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_=
device *adev,
> >       /* Overlay cursor not supported on HW before DCN
> >        * DCN401/420 does not have the cursor-on-scaled-plane or cursor-=
on-yuv-plane restrictions
> >        * as previous DCN generations, so enable native mode on DCN401/4=
20
> > +      *
> > +      * Always set native cursor mode when the CRTC is disabled,
> > +      * to make sure it doesn't cause atomic commits to fail when
> > +      * they are trying to disable the CRTC.
> >        */
> >       if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, =
1) ||
> >           amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
0) ||
> >   #if defined(CONFIG_DRM_AMD_DC_DCN6_0)
> >           amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
1) ||
> > -         amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(6, 0, =
0)) {
> > +         amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(6, 0, =
0) ||
> >   #else
> > -         amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
1)) {
> > +         amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, =
1) ||
> >   #endif
> > +         !dm_crtc_state->base.enable) {
> >               *cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> >               return 0;
> >       }
>
> --
> Thanks,
> Ivan Lipski
>
