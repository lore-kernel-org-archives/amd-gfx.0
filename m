Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86E4E8536F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 14:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6109F10F35C;
	Fri,  3 Apr 2026 14:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LWM0EsPV";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6171C10F355
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 14:04:00 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-127337e3870so91681c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 07:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775225040; cv=none;
 d=google.com; s=arc-20240605;
 b=bF2i8JOxc1yvQF/GK3nr7dQIMhjZLPrA17tL0mhx6lzlIN6iAJ/+pxI0wbaKvXta92
 ZjT40KhmnrFGs3IAEwsIOF1uYU3a41LoaffClDCL2QkO8wAAUAJEFnpFAJ3LHpyzTQYz
 kFWmWirV1gmyiv3IDkCk3sZ/b6nlig2dT6ZRqo4F0ktqmcH6APnLNzstDLhqh32NXU1l
 4i7zNsZviZwgGs1w2QRi/2wb0PEXuB14X5Ha2zyvjps7iCNDL5BU7oA9nnbIxmhvxl67
 h/bfbCcWfYqp4zZEGGMcg9Ij3sQTgi4HHnxYMJekmEpNsJ9wQIv0Tbsh0YkjJXy+PRuv
 bvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jb33u+p268RNee0ydgFcG0z/JEHUog8MlN82IkaxodQ=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=NHLOsPRc+g8dlNARI5k2uBRgnIvopkoSbmppDDpgw0i2uB9N2OGZ1p5BhzeqGRTMuB
 zgQAdW0iys7axMnf6ZC81Dl59cKWhGm0ls5q+hTl4Deeq0JxXtJ5F8GaLfYjJrn5g1FL
 uCiJManMyHrKocGawkv14ssAa6ohA1s40zDkiF0diUgOjxj+c1H7fNobZ342IxjTeeAS
 /lMmu5rTRO23EUOIUBLY2EifLEWQU6dh8OZQnd3YS5T6fdTu6HDLBtZWmkL4SrhQCYS8
 QIbGY5hc7aR2sdcYqcGgHlAPXYyVM16PQS9Hgb+RdHA6JeDO6AUp4jX4MiHmK90Nd7W1
 0R3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775225040; x=1775829840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jb33u+p268RNee0ydgFcG0z/JEHUog8MlN82IkaxodQ=;
 b=LWM0EsPVNdn23ze89+PrQfXlNM0VJ3sH5imROZJoSlKkpsQPOanmOgMFE6OaNLrCxN
 rIXTzel33hmMffzWh4pP3oXZM4neW6+vZyUqTtL94RHWy99VuYElRnEmlDK18pX45db6
 g7R7vOW2sVemSLzUVrG18Z1C0of7l+zve41400KlxrUwt3i82iqu7g7PMC0WHMMYSvQg
 CXqOL5Asj0H5hqlETABn2U75DPxlIgimLmakKp1dOFc+i1YkAIDf4XJgO4K2NvbKEjt2
 bEfgeNAeuAJQCwMmgtR3xeFfhEjj0X2lp6YaRkmDlIZAYDkgkbRGSBG3pu09tsfMOOl2
 AT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775225040; x=1775829840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jb33u+p268RNee0ydgFcG0z/JEHUog8MlN82IkaxodQ=;
 b=MUpZCQCKhxTv/VBGxEDYc9b/MkzDx6mg05kRZHcDjsgYkta3sNli2Lt+C1EVDD0KZk
 Z+d4lH+z8HU3nS+uyZZ6LTqI8zpsEEzWxcqz2AzQu+4Lua/t+qXtvjPk0RGT5iCwFnuB
 UiCGmf6xOiaQS6NEJNr9sOGLiIm5TLguUEZkDUkpYFTxFNu1EYpXgitDgV/3MzHjDBXt
 6PQUq0A7LKc03QIkN4a3D12H3L8X9d9PzNawb7mYYU0kz29N2YUySwcDBCHd2B9vMn1F
 Oi2J3xjLpFFZKawGzZy5evXJQ9MmpoKjxNHr27GXOZjzcpotrjoVaRXR5LsNX0aSPy+W
 IuOA==
X-Gm-Message-State: AOJu0YzXvMsAeMKi4vddDUsTUmIBQaTpcDDkt+SUfXbaIcxIUyZYlxQk
 SG7oa1gnOHRenJeJTe/0ejO024Ynhp2up9l2zXJwHZom6BWwV89Tep8pVv70lu+sMiwlH7sAvCe
 sdhxPpJwJyGmTSdhjrGgFkX9AIo4b39+Hkg==
X-Gm-Gg: ATEYQzw5EoOz+BA5ZxzFCMNTKzyKwpsMwGjVtkv76X9jJxef5uyu88F//K2JZ2c/k0a
 6JK8ucRxf2sIO1ZHa2QURXp9fmNlD9peOLgUysMyDv3XBsBTGtHmIdbmRY9Yn0EQvcGp+WL8hKz
 8da7U3arFxIylGam/+xK0bGHG9F3B4LUKZtJbXCfmFioMbxGeQZWtn7Bze173V73mSe40uAVBhr
 3ks6+3CmZ6DtSWnp0ODozhI+reQX/muh/+TTsWxufmGiZ5A4FsiAWNl/AqdECnCoVFeAFzAbteN
 Y9SjfQ/HQBIGvggcUfRe0K1V6w4Py1iBnMB3PpSUcUXL3JFpqESk9wVPS5laO84MDysiiA==
X-Received: by 2002:a05:7022:924:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-12bfb76a38cmr663441c88.6.1775225039049; Fri, 03 Apr 2026
 07:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260318140837.582776-1-alexander.deucher@amd.com>
 <20260318140837.582776-4-alexander.deucher@amd.com>
In-Reply-To: <20260318140837.582776-4-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 10:03:47 -0400
X-Gm-Features: AQROBzBkKggxinLUnmLiD0JeJtXm1gk43gDm5dY99rbEauTAB5SJl5BjuQG-eFE
Message-ID: <CADnq5_Md5RSUKZyAq8edL4hbwc1r2uPA7jiC6zn+MKi9KzDY6w@mail.gmail.com>
Subject: Re: [PATCH 04/16] drm/amdgpu/gfx9.4.3: align mqd settings with KFD
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

ping?

On Wed, Mar 18, 2026 at 10:34=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Make sure to set the quantum bits in the compute MQD
> for better fairness across queues of the same priority.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index ad4d442e7345e..d0b8fb9317201 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1943,7 +1943,11 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_r=
ing *ring, int xcc_id)
>
>         /* set static priority for a queue/ring */
>         gfx_v9_4_3_mqd_set_priority(ring, mqd);
> -       mqd->cp_hqd_quantum =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), re=
gCP_HQD_QUANTUM);
> +       tmp =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_QUANTUM)=
;
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
> +       mqd->cp_hqd_quantum =3D tmp;
>
>         /* map_queues packet doesn't need activate the queue,
>          * so only kiq need set this field.
> --
> 2.53.0
>
