Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E04C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6255110F8DB;
	Fri, 10 Jul 2026 13:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qDPpAz4N";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC9710F8DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:32:54 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-383fff6e8b6so80173a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783690374; cv=none;
 d=google.com; s=arc-20260327;
 b=C0J3SHHZFoZa98TT6sRwFaXtYq0Z7UTljacvST6Wi3eILibL6Ad0U6/RZWKwlZXDHV
 r9bq1eL1H4S9osKtnDS9nSqPq0l3czlV9YlTgrB9BohcJ1axzPqyacB28AxJP4cIkQIw
 IGNfq4TeUqwA3T8kzK1i66rQrCT+UeAbmhomsWdBV7xd/JSgPxyfnspyz9xBX3lX7HzU
 Oo4EoMbzLx5ydSDBWU4uuNhq3iOgZyUx6ZEdfYpSeil/zQ9b6XKD3GzdpICx2vOrehhX
 LewuA6/L1erlFbGb8KL0uVhd/QmkixIjJpPQhxV9mOdOEGjR2Nr5/UoIygZ7xowcn3fa
 CDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m5SrBdJz51UnTf3Icv1UxkGSbrtyHFHTUabrOwepNZI=;
 fh=tYbzEOBut+TtYwEwlV5qsbDNjRL30b58tMXY7hHTrbQ=;
 b=lKOfaGR/qH0/o42JUIKtA8deDtXv4pxfQq+6hUmt7Q1+78RXvNIgcOqxr7jyAV2nnv
 EJdrvT+NSFGLR5UhNpLAN3oJ5cBs8fEQFGuEbSoPis1PIUBbqzjhv0TsIr/RKOTK7jvj
 8rWLEmEaE8M4MuLYJtuawtJiK/KO6AEJBAW18B4jVsQHuv/w7JWBrsdTi1OPbRgzfgAP
 d9c7lsugdFhGl9SlgjcZg19iGK3yxB2Cd3vDMMGda2ajezdrZs9DFNFaVOPyC8UgXHgf
 lZYIz0UfRmvnBo/vm2gGGQ0RU2dB/Wnwliautql/bKwBUaAZPphbx8CV3Noj/k5b0f/Q
 bCsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783690374; x=1784295174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m5SrBdJz51UnTf3Icv1UxkGSbrtyHFHTUabrOwepNZI=;
 b=qDPpAz4N84GT8hKZdII4ynGS2LKVG7JFncu5O/fsyjj4tYc7Jt5a4xyHvR/0SFKp5s
 9JGJkNF77r43PvkptNKSKMLg7sA+ajXbi2XNHk+8A0LRyiXL0bTuoQoiciouoyOPr2WN
 w0dL5pyhGKs5P0XjFhudRdJkyPJlRowSbfhxd4VjaUiprjZZ35SNppdUXlwzbXKoBGUF
 EK58c5E8kDm61uhgt713xN65k8zweTFz0lIA3ENnEsxJSoi9+POhwIVReCjUAOV+u/Pe
 rphWSwkMBip416rbvIu3KlNDOqcN06lSlmdfcOGp8GG1oVF4smdQB5jHKjJpMyT6J+9/
 wkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690374; x=1784295174;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m5SrBdJz51UnTf3Icv1UxkGSbrtyHFHTUabrOwepNZI=;
 b=m9eo0XLKsWjVxVaZGyIxK3KFxnz4gK/ArSTxARou1XCUull7oirXH/BlbOU6NBZ3xW
 98IdiYMweKALPen0ZsaDZiCBA0itU31jObUQHcY+BSyqfkhzmrumbOHoEeZKNlLIl9h6
 eGmNCpuCCHz7/XYaEbcYlZ5zfaxV+chJAnQt4uCSdw3ybZztiCswwIxZpCUb/dGMze/w
 hegqqZqrzIS8psdZyvJQjzzNfjPNUntLy6h8Uaw90sDJaneMyQVDuaCFs1v5/CDxPK1e
 rO2Z1OIpg0YJK9YcprSsXkhiP1TSHC3EVi4TeosAnDdMGQo1K4Z6TvhKns5ERWSugdBT
 cZOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNw4TJAhLOeC1dorBIoMSE82NbdOLSseXhu9cd49xdcUI+GQ6GdRpQJOzP+GfLl9YBX1tdacIl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZrh7q0MwcIf9yOzA07XUQpnouP34ZZ2imzSVCQySguOSs5YBx
 /FQ1p4l1g1cTyiI2nd4vIlwXsADsoHZ/zPinHK151KPZP82IPIjHI749h16HhsApawv6y6O1oTX
 3bNl7u9DXBGHyUv3Ss2/Gaa6Xel9bxLU=
X-Gm-Gg: AfdE7ckUc+PDdlYcSMhZ/1EYfHls0ZHPEHJSsYpJwM+Pgi222bBCmLGXWqUwwV17YQN
 NbN9egPWH6WcuKCAgvFzc53eDdpoop1Oy6J9nO6+HWnJc/FOJs93lmh3W1TjCgXQIoEwpG0Lk8q
 G9pfRWK2n3oJPaTfkyTlzN+yZGPVs94lunXg8D3Hu8a+zTtPt5x9S0PSCil5ZyZNMSUn9f28r7t
 p9JUHYXwvJ+cyqD9DbiSeI/iGkWQ8Y4Ucx8bkiSu5hBXqBS2x0joQX51wU/yLPZ14vB7JSaUEQw
 e7/6Is81QW9rRAwGXqSocMCpX7AJ0DaYHT3AMFmJekIwaTseYWAMjMkYykot4W2ouxOouA==
X-Received: by 2002:a17:90b:58e6:b0:381:fa5:5217 with SMTP id
 98e67ed59e1d1-38a2170a4acmr7165869a91.7.1783690374160; Fri, 10 Jul 2026
 06:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260710110531.3222353-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260710110531.3222353-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jul 2026 09:32:41 -0400
X-Gm-Features: AVVi8Ce1j1eRPWhVSbzBtnoOoF92DZbkvfedMy6b-GFLFJh38MW1MGHvDMgj6no
Message-ID: <CADnq5_Ny=OdigN_R+PKhnH9n-zzg_513+SYo9aokuorRg-9RNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9.4.3: Fix MEC rollback loop in EOP IRQ
 setup
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Dan Carpenter <error27@gmail.com>, Kent Russell <kent.russell@amd.com>
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

On Fri, Jul 10, 2026 at 7:24=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix the error cleanup path in gfx_v9_4_3_set_userq_eop_interrupts() by
> using the correct loop condition. This ensures all previously enabled
> EOP IRQs are released if setup fails.
>
> Fixes: 832f0aa050ff ("drm/amdgpu/gfx9.4.3: add support for disabling kern=
el queues")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 44d38b76cb4f..9512fef81d84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2331,7 +2331,7 @@ static int gfx_v9_4_3_set_userq_eop_interrupts(stru=
ct amdgpu_device *adev,
>                 }
>         }
>         for (xcc_id--; xcc_id >=3D 0; xcc_id--) {
> -               for (m =3D adev->gfx.mec.num_mec - 1; m <=3D 0; m--) {
> +               for (m =3D adev->gfx.mec.num_mec - 1; m >=3D 0; m--) {
>                         for (p =3D adev->gfx.mec.num_pipe_per_mec - 1; p =
>=3D 0; p--) {
>                                 irq_type =3D AMDGPU_CP_IRQ_COMPUTE_MEC1_P=
IPE0_EOP
>                                         + (m * adev->gfx.mec.num_pipe_per=
_mec) + p;
> --
> 2.34.1
>
