Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C8BC87FCF
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Aug 2025 20:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4907D10E226;
	Sat,  9 Aug 2025 20:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GpzqxP9b";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFDE10E21C
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Aug 2025 20:17:32 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so1682390f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 09 Aug 2025 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754770651; x=1755375451; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBs6dKLLHtAFOtidf30pPaMiNCwjYLJbuN/R52lJg8o=;
 b=GpzqxP9bXmK8LWotUF7QEkrNsdPKM/9fWhCIiM0scTLR1y2YaRzLz3fOydN4y5w7Wg
 Q14qMP7/B9SXAfLvbRRw4qfo5FcWOu+fcuZHFGD0wHbnz4+peblJH4HHvNTAeIJJAqps
 McXPyPR0JSClmO5VWBaA1nljX/QgJ1u/AxBcbLs3wcNgY97DWcovynUtLshTmdCUOfzI
 tAeyYO1UV6HsNzP+A4isubmgq22B+VJfD0Gx1HrjBuhCD8XIe0+ouZk8p/nqF5+bs8UY
 YTHr5xEyomIqf3CBg8AEQb3I+9Qs75jQCiOFOYEo9mcT9Rp3tTiRp+UTUuiE4bqVQFeU
 P/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754770651; x=1755375451;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WBs6dKLLHtAFOtidf30pPaMiNCwjYLJbuN/R52lJg8o=;
 b=O5bOv9p4z/yQJn6nEcLIPrPTpKz5J8Q1c9lLNKIjNRDR5wawnvHGnX1nQoSM445ELK
 IzEP2Pa6WwfqGix109zzbIFO5Pgj+6RMAuCAa3iqsn2BMivKo3WVKn/99/A9fYqwBd6F
 2oZiRLTgvBuIEzsAD+3y7uZVHs8K6coc1WEI+IblrLcdQQJQ0XqS0SiZ9V2dZ7BWCNE+
 sX8DlWsQqtY8xu7h01czuBn6YCoLIq9b7M1WnYFJwQpN7xox8H7RsRX8iQNyzeZx3gkz
 8axpUD7KiKsPLdWNLubYwN7qvYJmzq8VNtuTlJasFC9vgaJTQwBH2W+Xhh1/FdSS3KcW
 eXaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjSd15SxhdifDciNke09MX29d13wJihk3lzYqXU8DBMP+TpI7qXC0K506BsvIVy3fyXyIbk3SO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWNnVxEvqf+1wD/bHwHnVUQU6E4Drh7m/44x/yX2IVgxiTeu78
 T9YY+6FDejbDrdkOTLGNCXIYASRIdE2x8AkmvvfWOC1C9p/cUbay7s8v
X-Gm-Gg: ASbGncvkMQ48eGODy+DQT2MSyMxCY8QjRQBnsgOTdM4JqWf2Dz//udQ0dBQDa/LZaXY
 S5OItkGLDo+uEg9Ox6NojbLIZ9Fp1cIT7Ef/GQVEej4MGDrKou6+LOzIPJoB6O1Apth3yZQtsHR
 BfJQ52C9zaVApDuaRaFb6KT9IZ9jD6CgYRzfQ4Jk0e4vQzgS4r0a93EdYbfnbp5EK6vmqOe8G+e
 Zlhc8E9Jbgw8pWtEgjtbxcpfLRweUKf9m8csxuJ6tMltNgamKjFFKqk1fNwjHqqx4zjNthrNomb
 cwia63FF1pnJjEoUMEaIJv1TpxNX9UKnIg7PeaC0J28jjFzkJY9t0tkfr2UzLuCUGDpAEhEZD2x
 c/QvYsTddEei0enLWnI62sH1x4jbxRyjeqfUz4/VkM1yVh1OPPFWrbZ/OVL5jd2HnyF2mwemqrH
 0=
X-Google-Smtp-Source: AGHT+IHRO6TNeCox+u03jF4XUUPRRq16jTLmoWXKu+ReU7fuDniBzTD+0eNlKjjzJ7BN+GWblNmhyA==
X-Received: by 2002:a05:6000:2dc2:b0:3a4:d9fa:f1ed with SMTP id
 ffacd0b85a97d-3b900b2d7a2mr6139273f8f.13.1754770650587; 
 Sat, 09 Aug 2025 13:17:30 -0700 (PDT)
Received: from ?IPv6:2a0a:f640:1601:b924:fc04:eba8:855f:f82?
 ([2a0a:f640:1601:b924:fc04:eba8:855f:f82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ee17535bsm145536505e9.16.2025.08.09.13.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 13:17:30 -0700 (PDT)
Message-ID: <10908a1af52e6e2162e5cc8350836bb3a25174bf.camel@gmail.com>
Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Sat, 09 Aug 2025 22:17:28 +0200
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

Thanks for the reply. I appreciate the testing. I'll investigate this
and try to fix it in the second version of the series. Do you think it
could be reproducible on a Rembrandt APU? Or did you already test that?

Upon looking at the patch again, I find it unlikely that pipe_ctx-
>stream would be NULL, since the same was already accessed by other
branches in the same function. My current best guess is that maybe
link->link_enc would be NULL in the link_detect_analog function.

In the meantime, can I ask you guys to also take a look at my other
series with DCE 6 related fixes?

Thanks,
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
