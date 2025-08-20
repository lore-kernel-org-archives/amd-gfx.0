Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C29FCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 12:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF0210E710;
	Wed, 20 Aug 2025 12:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQ217N/b";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FFA10E710
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 12:01:12 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3b9e418ba08so3497407f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755691271; x=1756296071; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nH/BRwI9Nur+Dl6z4fmwsyoHZY9cW+i3zOI3jfzrHLA=;
 b=VQ217N/bTqeAxKbMjXBE69ro1RgA7e7/oIgaC5jViMGH7+uMBq6V6MH1dpewgAQBls
 841JNUFoKnxpETMXBXEapQtfSMgRJQ9+CNo3h0sG2hcDG3g0vVhcCzcSwASYoeS40YOv
 xcOxfEtQjAu+b8ejdFnMkNjn0bVZq4Q+HORPtmPf2Zwmp93M4IeCck7Vu2eK/fJ2AuMd
 Y1BEkyjpFsgF8mmSm63NWd96G/6NhfTGo7RDG02rQN3drt/XoMoh6SvjHu2jyiWRtuSf
 BeUE7v/KX6E3yBRSjkSKO9vnu1ss2tsGq84g4YF+8ukLRK5wIRpJZROLR4GPHsHBSdO0
 nJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755691271; x=1756296071;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nH/BRwI9Nur+Dl6z4fmwsyoHZY9cW+i3zOI3jfzrHLA=;
 b=HJ355FQHX/ij9CfrovznVHR5zlQa2OsjYAV7CWy8U7Giy44zZpu44J6EFl9sHlWLBF
 wYsif/7JCFUIRTaD4v/t1hc/Tdi3QhRDxwnxmRQbhySkgltRLGwVB/m7oBaD6spsZeDT
 mM30fxO70HiA6g43iQFau+F9jq67NhF/ve0g9qbU4nWC43aiM4NGW5+YCKPV5AoKeZ2j
 CQPl+1N8G9yT4y63lAxlzFR8e5um0BwAPDL2DfoMUwqlP7rQ853Np6VKltHocZjdSeaT
 r9MKRCEPPEzUhzUMjt3jX71sGkorvvpNcH07Ewplk7ZLzEPeDEOk/SthWwG3K8ug8kUX
 UHSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmni6y2LE0m8gpNOQyfzTdCMhSRXzBGkGpKfQWcceqVXYxUz5EVKft/A1bWPQLHAc6vIu4qgCn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkAr1g1qrV98lT9C0wtOGJO85HE47CShtN2/K/yTD0/lrDb6pa
 84nCqNJv14+gcAYPrPyh4piC1qPKfNrrk7x/HIFCPEMA0g3HREJjlpB0
X-Gm-Gg: ASbGncvZ3ZnV0zMIG+hsYvZRovUMht3dfY3547Kmaq+P6w9HevIIv6R3QAnMAFfDE8t
 kCQJzGK1SSGRGcIJLeo9CIvKozvy2PY0HnZPmTljY0oc+GQ3lKS5AbAwRPfaSP/+axQbikzKSCU
 G/g0lz8PkutpRzP2lIAKnTCXQbNc+oVfYZNyAekreAaWYqcOlmei+Gii5mr2Ub9WpdrC4Jghgu9
 VpaUIsqb62xvnssWQ7rxolCxCTWDfX4rD3nVIyBTu1vyxczYo4xd85s/oJvxeVulIyKJPcmDHYZ
 x2+jKcZYmMeEvs93wBt3933SCv9qs78j/auX2gFZna6N9cGLvjufDmrWXrghHfnFsL5MId9AHiY
 ciy7K7zZQzh+a4YHSQGcoxid/o5REtZQ7kJ6JbXFkPu+ZCf+aIYTTonps6VAyGftpjQgLGTMvzp
 8+oSotZpctC+HeonkVPqm5bLv36DsqG3fWYp9sWRhxW3KdU0vzlrj571Pgq4M=
X-Google-Smtp-Source: AGHT+IHkA8bAtbPH5lMGJ3fTraOsjxY7PQ3eknEJ1+FKKvqrQ+v6ohZ0SqH8pcQGm2eTMPwv1EjfmQ==
X-Received: by 2002:a05:6000:2303:b0:3b8:dabe:bd78 with SMTP id
 ffacd0b85a97d-3c32e31f84emr2024964f8f.54.1755691270388; 
 Wed, 20 Aug 2025 05:01:10 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d9:d00:9fb6:4062:d31c:4e1b?
 (20014C4E24D90D009FB64062D31C4E1B.dsl.pool.telekom.hu.
 [2001:4c4e:24d9:d00:9fb6:4062:d31c:4e1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3c85efc57sm1500265f8f.40.2025.08.20.05.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 05:01:09 -0700 (PDT)
Message-ID: <42a1a0c19252420c90c983ccde1c6c85978054da.camel@gmail.com>
Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Wed, 20 Aug 2025 14:01:09 +0200
In-Reply-To: <DS0PR12MB653418F9D051FFB2E37C18B09C2FA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-14-timur.kristof@gmail.com>
 <fd4adcc9-44bd-4f54-b37c-3eb4dc286b03@amd.com>
 <e68d8be2-4687-4a51-a2ac-1ecc73cef355@amd.com>
 <24b4249761d7edb8df8551350475fd6dce274d93.camel@gmail.com>
 <b06f9e54-c99e-4c4c-b310-ad043daa50ec@amd.com>
 <DS0PR12MB653418F9D051FFB2E37C18B09C2FA@DS0PR12MB6534.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
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

On Fri, 2025-08-08 at 14:22 +0000, Wheeler, Daniel wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> The NULL pointer happens right after this error -> "[=C2=A0=C2=A0 10.0465=
42]
> amdgpu 0000:c4:00.0: amdgpu: [drm] *ERROR* KMS: Failed to detect
> connector" and only happens with this error. When bisecting the
> patchset I was getting just the error without the NULL pointer, and
> after removing "drm/amd/display: Add analog link detection" there was
> no NULL pointer or error. Probably just need to solve that error and
> it'd be good to go.
>=20
>=20
> It looks like it's an APU issue as I was able to reproduce this on a
> system with an AMD Radeon 8060S and eDP or DP, and yes, the NULL
> pointer happens at driver load.
>=20
> Thank you,
>=20
> Dan Wheeler
> Sr. Technologist | AMD
> SW Display


Hi Daniel,

I've managed to take a deeper look at this. I think there were actually
two problems in this patch:

1. NULL pointer dereference:

Seems to be caused by the link encoder not being initialized, although
I'm not fully sure how that happens, but I changed the parts that
accessed link_enc, and it no longer crashes now.

2. HPD pin issue:

In link_detect_connection_type() the DC code checks the status of the
HPD pins and returns false when HPD isn't supported. My patch changed
this to take the same code path as if the HPD pins were low. This seems
to have broken something and resulted in a black screen on Rembrandt.

It seems that some other part of the code expects that the link
detection fails when HPD isn't supported. So I fixed this by special
casing VGA connectors to allow link detection just on VGA to succeed
when there are no HPD pins, but left the other code path as-is.

Does that sound reasonable to you?

Thanks & best regards,
Timur



> ---------------------------------------------------------------------
> ---------------------------------------------
> 1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
> amd.com
>=20
>=20
> -----Original Message-----
> From: Wentland, Harry <Harry.Wentland@amd.com>
> Sent: Friday, August 8, 2025 10:03 AM
> To: Timur Krist=C3=B3f <timur.kristof@gmail.com>;
> amd-gfx@lists.freedesktop.org; Wheeler, Daniel
> <Daniel.Wheeler@amd.com>
> Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection
>=20
>=20
>=20
> On 2025-08-07 17:32, Timur Krist=C3=B3f wrote:
> > On Thu, 2025-08-07 at 16:34 -0400, Harry Wentland wrote:
> > >=20
> > >=20
> > > On 2025-08-07 15:12, Harry Wentland wrote:
> > > > On 2025-07-23 11:58, Timur Krist=C3=B3f wrote:
> > > > > Analog displays typically have a DDC connection which can be
> > > > > used
> > > > > by the GPU to read EDID. This commit adds the capability to
> > > > > probe
> > > > > analog displays using DDC, reading the EDID header and
> > > > > deciding
> > > > > whether the analog link is connected based on the data that
> > > > > was
> > > > > read.
> > > > >=20
> > > > > As a reference, I used the following functions:
> > > > > amdgpu_connector_vga_detect
> > > > > amdgpu_display_ddc_probe
> > > > >=20
> > > > > DAC load detection will be implemented in a separate commit.
> > > >=20
> > > > Another regression in our internal testing with this patch,
> > > > unfortunately only on not-yet released HW.
> > > >=20
> > >=20
> > > While this shows on unreleased HW I wouldn't be surprised if it
> > > repros on other (recent-ish) APUs (integrated GPUs). It's just
> > > that this week's test was on currently unreleased HW.
> > >=20
> > > Harry
> > >=20
> > > > I wonder if pipe-ctx->stream could be NULL in some cases.
> > > >=20
> > > > Harry
> > > >=20
> >=20
> > Hi Harry,
> >=20
> > Can you elaborate when / how it is valid for pipe->ctx->stream to
> > be
> > NULL when the code gets here? Maybe that would give me a hint how
> > to
> > resolve it.
> >=20
>=20
> I don't know. It was just a guess.
>=20
> I should've mentioned... the NULL pointer access happens on driver
> load.
>=20
> Dan might have more info.
>=20
> Harry
>=20
> > Thanks,
> > Timur
> >=20
> >=20
> > > > >=20
> > > > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > > ---
> > > > > =C2=A0.../amd/display/dc/link/hwss/link_hwss_dio.c=C2=A0 | 16 ++-=
-
> > > > > =C2=A0.../drm/amd/display/dc/link/link_detection.c=C2=A0 | 80
> > > > > ++++++++++++++++++-
> > > > > =C2=A0.../gpu/drm/amd/display/dc/link/link_dpms.c=C2=A0=C2=A0 |=
=C2=A0 3 +
> > > > > =C2=A0.../drm/amd/display/dc/link/link_factory.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +
> > > > > =C2=A04 files changed, 95 insertions(+), 7 deletions(-)
> > > > >=20
> > > > > diff --git
> > > > > a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > > b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > > index f3470716734d..b9ebb992dc98 100644
> > > > > ---
> > > > > a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > > +++
> > > > > b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
> > > > > @@ -58,8 +58,9 @@ void setup_dio_stream_encoder(struct
> > > > > pipe_ctx
> > > > > *pipe_ctx)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn;
> > > > > =C2=A0=C2=A0 }
> > > > >=20
> > > > > -=C2=A0 link_enc->funcs->connect_dig_be_to_fe(link_enc,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe_ctx->stream_res.stream_enc->id=
,
> > > > > true);
> > > > > +=C2=A0 if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link_enc-=
>funcs->connect_dig_be_to_fe(link_enc,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pipe_ctx->stream_res.stream_enc-
> > > > > > id, true);
> > > > > =C2=A0=C2=A0 if (dc_is_dp_signal(pipe_ctx->stream->signal))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe=
_ctx->stream->ctx->dc->link_srv-
> > > > > > dp_trace_source_sequence(pipe_ctx->stream->link,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DPCD_SOURCE_SEQ_AFTER_CONNECT_DI
> > > > > G_FE_BE);
> > > > > @@ -98,10 +99,13 @@ void reset_dio_stream_encoder(struct
> > > > > pipe_ctx
> > > > > *pipe_ctx)
> > > > > =C2=A0=C2=A0 if (stream_enc->funcs->enable_stream)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stre=
am_enc->funcs->enable_stream(stream_enc,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pipe_ctx->stream->signal,
> > > > > false);
> > > > > -=C2=A0 link_enc->funcs->connect_dig_be_to_fe(
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link_enc,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe_ctx->stream_res.stream_enc->id=
,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false);
> > > > > +
> > > > > +=C2=A0 if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link_enc-=
>funcs->connect_dig_be_to_fe(
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 link_enc,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pipe_ctx->stream_res.stream_enc-
> > > > > > id,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 false);
> > > > > +
> > > > > =C2=A0=C2=A0 if (dc_is_dp_signal(pipe_ctx->stream->signal))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pipe=
_ctx->stream->ctx->dc->link_srv-
> > > > > > dp_trace_source_sequence(
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pipe_ctx->stream->link,
> > > > > diff --git
> > > > > a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > index 827b630daf49..fcabc83464af 100644
> > > > > --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> > > > > @@ -942,6 +942,12 @@ static bool
> > > > > detect_link_and_local_sink(struct dc_link *link,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SIGN=
AL_TYPE_RGB: {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink_caps.transaction_type =3D
> > > > > DDC_TRANSACTION_TYPE_I2C;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink_caps.signal =3D SIGNAL_TYPE_RG=
B;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case=
 SIGNAL_TYPE_LVDS: {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink_caps.transaction_type =
=3D
> > > > > DDC_TRANSACTION_TYPE_I2C;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink_caps.signal =3D SIGNAL_T=
YPE_LVDS;
> > > > > @@ -1133,9 +1139,17 @@ static bool
> > > > > detect_link_and_local_sink(struct dc_link *link,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sink =3D prev_sink;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 prev_sink =3D NULL;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 query_hdcp_capability(sink->sink_si=
gnal,
> > > > > link);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sink->edid_caps.analog)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 query_hdcp_capability(sink-
> > > > > > sink_signal, link);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* DVI-I =
connector connected to analog display.
> > > > > */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((link=
->link_enc->connector.id =3D=3D
> > > > > CONNECTOR_ID_DUAL_LINK_DVII ||
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 link->link_enc->connector.id =3D=3D
> > > > > CONNECTOR_ID_SINGLE_LINK_DVII) &&
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink->edid_caps.analog)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sink->sink_signal =3D SIGNAL_TYPE_R=
GB;
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* H=
DMI-DVI Dongle */
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A
> > > > > &&
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 !sink->edid_caps.edid_hdmi)
> > > > > @@ -1228,6 +1242,64 @@ static bool
> > > > > detect_link_and_local_sink(struct dc_link *link,
> > > > > =C2=A0=C2=A0 return true;
> > > > > =C2=A0}
> > > > >=20
> > > > > +/**
> > > > > + * Evaluates whether an EDID header is acceptable,
> > > > > + * for the purpose of determining a connection with a
> > > > > display.
> > > > > + */
> > > > > +static bool link_detect_evaluate_edid_header(uint8_t
> > > > > edid_header[8])
> > > > > +{
> > > > > +=C2=A0 int edid_header_score =3D 0;
> > > > > +=C2=A0 int i;
> > > > > +
> > > > > +=C2=A0 for (i =3D 0; i < 8; ++i)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 edid_head=
er_score +=3D edid_header[i] =3D=3D ((i =3D=3D 0
> > > > > > > i =3D=3D 7) ? 0x00 : 0xff);
> > > > > +
> > > > > +=C2=A0 return edid_header_score >=3D 6;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * Tries to detect a connected display by probing the DDC
> > > > > + * and reading the EDID header.
> > > > > + * The probing is considered successful if we receive a
> > > > > + * reply from the DDC over I2C and the EDID header matches.
> > > > > + */
> > > > > +static bool link_detect_ddc_probe(struct dc_link *link)
> > > > > +{
> > > > > +=C2=A0 if (!link->ddc)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fa=
lse;
> > > > > +
> > > > > +=C2=A0 uint8_t edid_header[8] =3D {0};
> > > > > +=C2=A0 bool ddc_probed =3D i2c_read(link->ddc, 0x50, edid_header=
,
> > > > > sizeof(edid_header));
> > > > > +
> > > > > +=C2=A0 if (!ddc_probed)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fa=
lse;
> > > > > +
> > > > > +=C2=A0 if (!link_detect_evaluate_edid_header(edid_header))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fa=
lse;
> > > > > +
> > > > > +=C2=A0 return true;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * Determines if there is an analog sink connected.
> > > > > + */
> > > > > +static bool link_detect_analog(struct dc_link *link, enum
> > > > > dc_connection_type *type)
> > > > > +{
> > > > > +=C2=A0 /* Don't care about connectors that don't support an
> > > > > analog signal. */
> > > > > +=C2=A0 if (link->link_enc->connector.id !=3D CONNECTOR_ID_VGA &&
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->lin=
k_enc->connector.id !=3D
> > > > > CONNECTOR_ID_SINGLE_LINK_DVII &&
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->lin=
k_enc->connector.id !=3D
> > > > > CONNECTOR_ID_DUAL_LINK_DVII)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fa=
lse;
> > > > > +
> > > > > +=C2=A0 if (link_detect_ddc_probe(link)) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *type =3D=
 dc_connection_single;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tr=
ue;
> > > > > +=C2=A0 }
> > > > > +
> > > > > +=C2=A0 *type =3D dc_connection_none;
> > > > > +=C2=A0 return true;
> > > > > +}
> > > > > +
> > > > > =C2=A0/*
> > > > > =C2=A0 * link_detect_connection_type() - Determine if there is a
> > > > > sink
> > > > > connected
> > > > > =C2=A0 *
> > > > > @@ -1238,6 +1310,7 @@ static bool
> > > > > detect_link_and_local_sink(struct dc_link *link,
> > > > > =C2=A0bool link_detect_connection_type(struct dc_link *link, enum
> > > > > dc_connection_type *type)
> > > > > =C2=A0{
> > > > > =C2=A0=C2=A0 uint32_t is_hpd_high =3D 0;
> > > > > +=C2=A0 bool supports_hpd =3D link->irq_source_hpd !=3D
> > > > > DC_IRQ_SOURCE_INVALID;
> > > > >=20
> > > > > =C2=A0=C2=A0 if (link->connector_signal =3D=3D SIGNAL_TYPE_LVDS) =
{
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *typ=
e =3D dc_connection_single;
> > > > > @@ -1261,6 +1334,8 @@ bool link_detect_connection_type(struct
> > > > > dc_link *link, enum dc_connection_type *
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn true;
> > > > > =C2=A0=C2=A0 }
> > > > >=20
> > > > > +=C2=A0 if (!supports_hpd)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return li=
nk_detect_analog(link, type);
> > > > >=20
> > > > > =C2=A0=C2=A0 if (!query_hpd_status(link, &is_hpd_high))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 hpd_gpio_failure;
> > > > > @@ -1269,6 +1344,9 @@ bool link_detect_connection_type(struct
> > > > > dc_link *link, enum dc_connection_type *
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *typ=
e =3D dc_connection_single;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* T=
ODO: need to do the actual detection */
> > > > > =C2=A0=C2=A0 } else {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (link_=
detect_analog(link, type))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *typ=
e =3D dc_connection_none;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
link->connector_signal =3D=3D SIGNAL_TYPE_EDP) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* eDP is not connected, powe=
r down it
> > > > > */
> > > > > diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > > > b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > > > index d6b7347c6c11..ac25d89a4148 100644
> > > > > --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> > > > > @@ -2256,6 +2256,9 @@ static enum dc_status enable_link(
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enab=
le_link_lvds(pipe_ctx);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stat=
us =3D DC_OK;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
> > > > > +=C2=A0 case SIGNAL_TYPE_RGB:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =
=3D DC_OK;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > =C2=A0=C2=A0 case SIGNAL_TYPE_VIRTUAL:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stat=
us =3D enable_link_virtual(pipe_ctx);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
> > > > > diff --git
> > > > > a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > > > b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > > > index 71c10a1261b9..c9725fd316f6 100644
> > > > > --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > > > +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
> > > > > @@ -555,6 +555,9 @@ static bool construct_phy(struct dc_link
> > > > > *link,
> > > > > =C2=A0=C2=A0 case CONNECTOR_ID_DUAL_LINK_DVII:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link=
->connector_signal =3D
> > > > > SIGNAL_TYPE_DVI_DUAL_LINK;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
> > > > > +=C2=A0 case CONNECTOR_ID_VGA:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link->con=
nector_signal =3D SIGNAL_TYPE_RGB;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > =C2=A0=C2=A0 case CONNECTOR_ID_DISPLAY_PORT:
> > > > > =C2=A0=C2=A0 case CONNECTOR_ID_MXM:
> > > > > =C2=A0=C2=A0 case CONNECTOR_ID_USBC:
> > > >=20
