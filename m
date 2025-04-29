Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E860C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 16:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D6410E105;
	Tue, 29 Apr 2025 16:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nCNORQSh";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 571F710E105
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 16:03:20 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff73032ac0so636522a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745942600; x=1746547400; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lncCoXbwir5pNl14C6UQzYTK9c0H5P3LWPQSxxkyTt4=;
 b=nCNORQShz5tVVC/mPb2ziK5HTAPKTJZGvbnnanADE7ocGWHk3bi9mCKcu2saL+68xL
 aSXbDcimn2UM/dQ4ItScUDMyqxMysS48VSFfLGNhAqtElMG/Kdd0rsiJWoEZn5XzYd5R
 7+aJc2Cqngxs7kJj0u8qyWwIjYKy2NEOUEuZy+zLnKiNZ4jyfMOi5/fZKTyJVDh+q/UJ
 cXJTiMPY+epgniAln48kI1gUuBEAXAGSPFEybkCw5wm0M6r8V7DVPilfOO6kFtEUZMbU
 YBcQjdrPS2Gvc/DU51W3DENOwl4ZJZWuyvXXKgDO/K9WO+UuvNb4mZKT+WIJ1PLkYzoC
 8TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745942600; x=1746547400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lncCoXbwir5pNl14C6UQzYTK9c0H5P3LWPQSxxkyTt4=;
 b=F5RFRa/kignE5NjeGQIZpRb0A6ATy3dEF1Kz12v+r+561ac0NXmebC3J2w0FCMmreQ
 N75qC5OMr9O6QqwqCOFVcoa8Jj0t1dj5pTq/7aMzNdbWNkxdPW0VZ26/LV6bAJZnURGt
 LBNI0rkXagZQM7vA5DZrbUst4wGnW2YGTJBPMSs8io2P9bsBDSm43usa8u3Y66fVGKNm
 ulCLulWrzEqWBfvIZq9ZJw67BtyaHWE4sdaejiNfHEedht2NLqGk4E60lf+YymG81cGK
 9LpcwpQuJ6CK07AhfDCY0a+pptC98nSTUu/6yABN8eONBjVpqnf2lSZGX7druELBWV+H
 owNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqIZkOoa4AXT7+gM0av72bPRqenWco8gHU2mxSTLiAjglyj/zBdujGX0PcR8qdolXXjfH79IVQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWMRTsPWdUHqnpJ8K7/Lx1AJCSSPTA5Oqtfp/V0j236qz2ymGu
 DlY1dIwLP9I4tNyPuMAW6DHX9FLTABhTUUC6YRFgnCa/BgFVbGGjVTq4Hv3P/QxqwjLGhAtn1k2
 2jlyVF/KdZWeMEn3tlGogavazCVI=
X-Gm-Gg: ASbGncv2czztHif8qQHBOJQm5GdnH5sylkI3y8P+7ZLHvzhCwx0pPkAZ2dtVQICTL3a
 7h6+6eWV6Cy32lrgiLn7KDjloIdLJ2Bk+ZVt4vL0iaCsLP/GrcXGYOjgKK4+nZ+gQZ//n4zWqJ7
 SJi0huXyZHm+i3MAeOD9CEnA==
X-Google-Smtp-Source: AGHT+IGnQFrfkjN6vFFAEc2UV/wtFmc+2zSEKJspp+71k367oGdou77sSovxUdaOp2OIkH/pZivSsjcx4DWBARZtqqc=
X-Received: by 2002:a17:90b:1644:b0:30a:2173:9f16 with SMTP id
 98e67ed59e1d1-30a22066cc3mr1969275a91.1.1745942599666; Tue, 29 Apr 2025
 09:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250428135514.20775-1-ray.wu@amd.com>
 <20250428135514.20775-19-ray.wu@amd.com>
 <CADnq5_NV3D1txYenNsit-3H6uqJDJ+rgOSHPbOtta24HmXqD+g@mail.gmail.com>
 <7943c1ee-d383-4164-9177-f12338b12741@amd.com>
In-Reply-To: <7943c1ee-d383-4164-9177-f12338b12741@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 12:03:07 -0400
X-Gm-Features: ATxdqUHQuVGrHQdzDcmcXhJQUCYgj6tB08xgxm-YQcFe4ITQaKegY-F5h63m95U
Message-ID: <CADnq5_NqYj+M+gf+bxZ2-UmYF+Hc1r5pZYP07jWzghp2cD9RqQ@mail.gmail.com>
Subject: Re: [PATCH 18/28] drm/amd/display: Remove unnecessary
 DC_FP_START/DC_FP_END
To: Alex Hung <alex.hung@amd.com>
Cc: Ray Wu <ray.wu@amd.com>, amd-gfx@lists.freedesktop.org, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, 
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>
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

On Tue, Apr 29, 2025 at 12:01=E2=80=AFPM Alex Hung <alex.hung@amd.com> wrot=
e:
>
>
>
> On 4/29/25 09:04, Alex Deucher wrote:
> > On Mon, Apr 28, 2025 at 9:57=E2=80=AFAM Ray Wu <ray.wu@amd.com> wrote:
> >>
> >> From: Alex Hung <alex.hung@amd.com>
> >>
> >> [WHY & HOW]
> >> Remove the unnecessary DC_FP_START/DC_FP_END pair to reduce time in
> >> preempt_disable. It also fixes "BUG: sleeping function called from
> >> invalid context" error messages because of calling kzalloc with
> >> GFP_KERNEL which can sleep.
> >
> > Is this safe?  If this function uses FP or calls a function which uses
> > FP, removing these will lead to register corruption.
>
> I checked dcn32_resource_construct again and I did not find any FP or
> functions uses FP, and Aurabindo helped double check.
>
> I also checked other dnc*_resource_construct (like 321, 35, 351, 36) and
> they don't use DC_FP_START/DC_FP_END pair either.
>
> So it should be safe to remove this pair.

Great.  Thanks for verifying.

Alex

>
> >
> > Alex
> >
> >>
> >> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >> Signed-off-by: Alex Hung <alex.hung@amd.com>
> >> Signed-off-by: Ray Wu <ray.wu@amd.com>
> >> ---
> >>   .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 6 ----=
--
> >>   1 file changed, 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resou=
rce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> >> index 2a59cc61ed8c..944650cb13de 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> >> @@ -2114,8 +2114,6 @@ static bool dcn32_resource_construct(
> >>   #define REG_STRUCT dccg_regs
> >>          dccg_regs_init();
> >>
> >> -       DC_FP_START();
> >> -
> >>          ctx->dc_bios->regs =3D &bios_regs;
> >>
> >>          pool->base.res_cap =3D &res_cap_dcn32;
> >> @@ -2501,14 +2499,10 @@ static bool dcn32_resource_construct(
> >>          if (ASICREV_IS_GC_11_0_3(dc->ctx->asic_id.hw_internal_rev) &&=
 (dc->config.sdpif_request_limit_words_per_umc =3D=3D 0))
> >>                  dc->config.sdpif_request_limit_words_per_umc =3D 16;
> >>
> >> -       DC_FP_END();
> >> -
> >>          return true;
> >>
> >>   create_fail:
> >>
> >> -       DC_FP_END();
> >> -
> >>          dcn32_resource_destruct(pool);
> >>
> >>          return false;
> >> --
> >> 2.43.0
> >>
>
