Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A2EC761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 19:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC3110F2E8;
	Fri, 31 Mar 2023 19:18:54 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6CF10F2DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 19:18:49 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id bx42so1898502oib.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680290329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RZETmSNf3NSJPtBsSKbsAgK0TifJmGPhzSD9VZiYJM=;
 b=qN8CWnD0/btvw7TtqqOOk8R9QWQYfNQplMAWfj4Hh/JPtBN5PN/o49BVg95j7a7Swu
 lew/nfHjV6Ykz/M6j7K0q+OAyHeXLXfGvxzy4Bx+xdapqvBGIGEoEiwN3n7WNuUCobk6
 gd3MRxoJ2f+rYSHF45x8Dc8tffO1/eRuTHP2UQLJFhh+whXGT1jd3ZUjlhrL67syOZX7
 U5iWtpVSSKKCAnKus64dw095nXSG6xn6Uu+42zQgJp7rk6tmtJWlvN2xejdcAVUGoae0
 1wjoJTK3DWdrsNvh60Rf5U5dTE7g9VqiLIbPyhIRSkTmSutL4Yg/C9vLKMCdepFFfLmr
 q0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680290329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RZETmSNf3NSJPtBsSKbsAgK0TifJmGPhzSD9VZiYJM=;
 b=OdthEfBdtOmvK0EPGX1I9grYxkd+1U6YJ5QBSe337G0AtRBaizqZQOq3kx9SmZvG+o
 ix0QREgSyIVwbUViDKLx3WI/s+iPvbOZts0N+DMeWKVUBNWxRGuEuefls2+ukhwnrrY8
 8JuNbkFRw8yk3QaRHAP6hbPwrYLPPLy0rAZTxSanjmcHeC4vwcTfOD76U55WAF3zqMzA
 BlGGUc2sFvwwaQgxDyWlCHjuhlsr7DnGVowO7K6KSYOi48y2bFiNdeSSA7JS0WnKdMxJ
 zPCEvk26YQ5w463Y7WJxX4SzxnAjipzrSsW4TTNQzVtCQJsYwHRkMU8vRpkjusaV2uxI
 4VnA==
X-Gm-Message-State: AAQBX9c5c9sGswUl6ZaOTYQkCESvG0NSa07ucLoGbgIIXgWSVxQaBJpv
 SpR/Nrvp3q57OwKB0iqoNP0ikFUmU9jQMSKR3nY=
X-Google-Smtp-Source: AKy350aBFAOkbO8ODbYokMA2c9WmLeWDtI0/Q25Olz7w6/iNHro83DOuvLJOXRroz6zJRRHiT0ulRJGNzej6dnlPmWY=
X-Received: by 2002:a54:448c:0:b0:389:4e54:79f0 with SMTP id
 v12-20020a54448c000000b003894e5479f0mr2230826oiv.3.1680290327768; Fri, 31 Mar
 2023 12:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
 <20230330191750.1134210-3-alexander.deucher@amd.com>
 <ecf2a379-4b8d-a168-f555-26f66d5d5e9b@amd.com>
In-Reply-To: <ecf2a379-4b8d-a168-f555-26f66d5d5e9b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 Mar 2023 15:18:36 -0400
Message-ID: <CADnq5_N2i63v3Ay9o00RoYMFkzwCdrHzCRPL43vGz0xtqeERcg@mail.gmail.com>
Subject: Re: [PATCH 02/13] drm/amdgpu/gfx11: check the CP FW version CP GFX
 shadow support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 31, 2023 at 2:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 30.03.23 um 21:17 schrieb Alex Deucher:
> > Only set the supported flag if we have new enough CP FW.
> >
> > XXX: don't commit this until the CP FW versions are finalized!
>
> Maybe commit the rest of this series and just hold back this one?
>
> It should still keep everything working.

Yes, that was my plan.

Alex

>
> Regards,
> Christian.
>
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index a0d830dc0d01..4a50d0fbcdcf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -469,6 +469,15 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struc=
t amdgpu_device *adev)
> >       case IP_VERSION(11, 0, 0):
> >       case IP_VERSION(11, 0, 2):
> >       case IP_VERSION(11, 0, 3):
> > +             /* XXX fix me! */
> > +             if ((adev->gfx.me_fw_version >=3D 1498) &&
> > +                 (adev->gfx.me_feature_version >=3D 29) &&
> > +                 (adev->gfx.pfp_fw_version >=3D 1541) &&
> > +                 (adev->gfx.pfp_feature_version >=3D 29) &&
> > +                 (adev->gfx.mec_fw_version >=3D 507) &&
> > +                 (adev->gfx.mec_feature_version >=3D 29))
> > +                     adev->gfx.cp_gfx_shadow =3D true;
> > +             break;
> >       default:
> >               adev->gfx.cp_gfx_shadow =3D false;
> >               break;
>
