Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BADEC282EC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 15:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA4A10E221;
	Thu,  6 Mar 2025 15:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NQs1qKq5";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4C110E221
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 15:27:56 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so98856a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 07:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741274876; x=1741879676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nlIWBy8LBcgXV3EhuSDM5h8oNqJcSmM/zgHjUdELxo=;
 b=NQs1qKq5CpvhDRGxaLz0QF9XEcHBO/nHaUQsWyei7Wzy1YLLhwFfa21zm+3rVUVlmm
 3NSxdZff3d42YK3jVWGQgHvQyg8cw85lRUvJdEESAMCMQy9H9Y+bxPLX3tbdB8FnAqm9
 nkuL7v85ycB8x1cXHP+YojzN+ZckBZOoQX0ihq1na3K87vvGVeHJa+GmlwarlYpB/ph/
 BdpPUECDZ8yOkCP+j2s4EhH+8nFmtniMRu73M5RxxsMQ9EgbcGnNW5/2Nas8iFMP8D/m
 HnOM2jWvnESVRUWQTP7JYnX4cc+h2Hz7ijtkfNwTLM1u/RgPsqv7uLTj0e+bw1J1EJlY
 pqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741274876; x=1741879676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nlIWBy8LBcgXV3EhuSDM5h8oNqJcSmM/zgHjUdELxo=;
 b=laIrvZxS15PgpbeyAYpz2OxU56Zd9FVG56mEEHPLFW/F8i2UmzaaMGZ0aMcKaCa57f
 rkPc795TXlGJbf+S/LvM2d3nJ/5FFytRajEgopML8D8i2Vz89I4f3575MOCDvhnvve35
 cL0E31x6UAg8ed8IlWbUGdHJKx5/5RS7Ie60eXsP46H9SNANTcrowa7F/fA+eUqBqWAm
 p84t/DoNJnhfc4FYIFE3jgP48sTeTDtp8hfNaTyRYdl2Fz3Hru8ruuLfIJmxx+awG1S3
 sJkCJH/qnu64QAlBYoXI5EykIidFZomgv2HZM2Q8lGC/BDL1dCghKP/eq0Ccn+yNNGmc
 1fUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn8yHSTZJTVF+lx0Gln/9BoM2IP4OSDohjFhC6I7NN87kVOoEKkOU2LQeCds3+YnSEzvaKJoMI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcbF+GEw5d1/7lbtVEDiA8azi1t0x3r9j49e9u+jp0V1OimTSN
 632rN31nohTR7L1XzPc7Jqt4aD1ZLqOLAaa1c2blj5yYKSBGQI9xobRaiyQMMebuFT5jy+c30W/
 0tZvCPmptnVgtlksnCYo9hz4OnlM=
X-Gm-Gg: ASbGncs/hodzmTbYPOJjA/ctMgTI24EH0WsWUWOzdSXf/M8XNqQCbJ15gzIZE3SfYD3
 bDqGS56GMbA9zSVsh2QdUF2hz1BhIZiVHSxD2+z5LYOo4DYwYqciCspp3aygVywHQmWAJIkLQvk
 1J8bGNewsBNO5qtegXlWAJsnby/g==
X-Google-Smtp-Source: AGHT+IHo/H8wQkXAPAvJtpv5iqO21LohKYuthyKS4AES1xcNl+lLHZinwDHk6EKRfp8QCztBMwKhBnLouyHWp9oqUsA=
X-Received: by 2002:a17:90b:3802:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-2ff5540bc8amr3427106a91.8.1741274876142; Thu, 06 Mar 2025
 07:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20250305163241.2551925-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250305163241.2551925-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 10:27:44 -0500
X-Gm-Features: AQ5f1JqkquKYiHh7orueGRVzReoTMKfePZ6HJ_QJQsFbNFO73MS0xM_g-y4lvf8
Message-ID: <CADnq5_M=m8EGrcnNSFVoTBMKy9VN0AVJNTv6CNoVQuS83GfDXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix annotation for dce_v6_0_line_buffer_adjust
 function
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Ken Wang <Qingqing.Wang@amd.com>
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

On Wed, Mar 5, 2025 at 11:45=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Updated description for the 'other_mode' parameter. This parameter is
> used to determine the display mode of another display controller that
> may be sharing the line buffer.
>
> Cc: Ken Wang <Qingqing.Wang@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 315c098271af..ac51b7a6e8d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1041,6 +1041,8 @@ static void dce_v6_0_program_watermarks(struct amdg=
pu_device *adev,
>   * @amdgpu_crtc: the selected display controller
>   * @mode: the current display mode on the selected display
>   * controller
> + * @other_mode: the display mode of another display controller
> + *              that may be sharing the line buffer
>   *
>   * Setup up the line buffer allocation for
>   * the selected display controller (CIK).
> --
> 2.34.1
>
