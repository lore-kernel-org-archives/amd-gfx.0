Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCF7C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FAF10E2CF;
	Fri, 21 Aug 2026 16:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b+lWmnMB";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C6D10E2CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:23:38 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so82865a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 09:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787329417; cv=none;
 d=google.com; s=arc-20260327;
 b=HnP3UrKM5MdT0DuHSiY7YrNtYKX/twJEKJIhdI5ZRiUBhMNnbbXtJoso9UrWP6o7V0
 Sh3P/OJZHiQ+mmHKCgGgkymeaYtcI0zEpjdoY8XxH3mk4XrXWq9and7sZFRJaMu1mqNT
 5NBR0o1iWS2gRHtJXeEEYj2FrQ5tdSySpG6FKKlNPipB9W6yDvVB6F+fyMNgQoaS+Kos
 rnbPx4luEv2sPdXwnu+CSwSr26XK0nNEbxvxfAGlHW/rzZFzs6VK5UxpnqAdvbGHNd7B
 3gRbdrFooonynK3vF6QrBzoOfjB6LpYAXFRzswWTuOuvPnc+7YazPU5Z6Dm9dgDG1cj8
 q2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yCDyTKKa5S81qTdIhDV0eEgMQ22CNhqsKKFaWfvCMec=;
 fh=en06d6GCcmKshwCE9tNGdwMiEfMmXa8AbUE8skPYlWA=;
 b=raqlTCJW8lL9ha0neiVL2dVXh/Uc6fjNnT9ZEW9RDy1KdUPHvFTL3824yeobzsGCZS
 ZtfbfDRaAHObPq++ACaObNP8xEbMa4SP72lBScVZGs4CuPCKPyQPYrUkzI1o9VqIbWgK
 rrsVHEOQX7HXxGpEFQ+S/vqOhQo9bE8srdEb/VGQxfXerX7tG6hIZmoQfa0HDwdEXsve
 vndcbC29h7Ab3tdrR57tbJeJjdkSStkXQVj+vX8O1ocD8xdiHNTO307i2RJIM39YDjol
 GBE5LgkidUBLyp7hUrU6IbK3T5xPkkuHaMRWuW9uBCbtyK58BIeZ58KYRZ3FIHrfQFFm
 pyQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787329417; x=1787934217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yCDyTKKa5S81qTdIhDV0eEgMQ22CNhqsKKFaWfvCMec=;
 b=b+lWmnMBYBTzTGy36yOg9FFgD38w7dbPsEVqEBQc+Isna/Bdd20IKv+vhRFYH9FO5X
 TbWIFxOyIfMkbbIOOx6Fczwf51urXrJjeuTRX+PDzAWbuX0ExJMxx1bSZ2a/j2mfChhi
 lC0FHMqOfdfMVKKDcUmXQQjopL0N3iQ/1Z9mHY5r117caeVq3zcP1wXoB1TN1u9G7s/S
 wB66YkuW4u0o8h1FcoQZ0MQoBegHTcfPnigs4Z1+PMlC/4W5UgpZjwbV4LWGlykuXC76
 wvcGQ3YqZtBnAxBLC5sROpe+VJHMG54ZiJ9kiAJpdm3VqdKalBH8sfw0Jf2Rtb9mDNra
 gr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787329417; x=1787934217;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yCDyTKKa5S81qTdIhDV0eEgMQ22CNhqsKKFaWfvCMec=;
 b=jca1XdSFHqBDQfEi3RTPyqhdCPiW0e9KoQ/+C4eUx9M0RiWNlYZfQSu8LZNEVWHAKd
 Q5NBOAGnu8s6htMCpV0CpDZcFzkt5xy2QFq1oU5Jk5H1JaDIJ/tvjRNzEYTi80Xod6mV
 mFqjy17CnL11hdmXb8LBAYoYggRgthQq4fpU3gdWECeq7SwwkVPLG9lHegcNFEpLJR5v
 yboiq+6WM4vI1LQRjl+q1gNowz+fOk1cIk6zxLdC4Jm532U7gDBw8yuqxERUFNPNR0ks
 WTSCHlWAZ13YVc7EbPJtSzv/SCkIm2tN/++03PffnHN48sVh9hlgDa5XPlX29vUZSoBT
 P1Pg==
X-Gm-Message-State: AFuF++l49cjik49m6/cA/6PCtb2c5t+Rnlc6z0233vUKZArNSv/rQaYk
 pgwTx/rX7j3mfkY82dS/oy5B+BQ33hxNxA/zfccgjJrFdR4NmdHfkI2U08g6GPZMGovSjtQI774
 dZvoHYWF4lM7hmcUNl1yNOq0e0UIJlzY=
X-Gm-Gg: AR+sD102uv8OkvJn7IZiDMSxfXhrs6PDSXfyuzimBh1dkyq8MNX9mhxfV/ezLboyUZx
 8DjyrjkfgNtq19rQtaCMh2nxJ2VvAc/g6Ib/UbNFY3Mpz/meZKq5XGJ0ZtW5BYVmRx8BF+wZtWz
 fviwgOck2D4vfmgmPwwS/toLge6LBnAdg00L5wNRAeq0rp8AIMubyeyD+IN9JlszEXDObQI/8vS
 ejDmbOoLQ/YptYc3xpQ4JHY53CjSG6LbXgP6yQTFeZv5qOUk5eVnJU/+Wj+IiXi/p01zch9hLd3
 r9X1ZiCA0+BWPJIrplMNCNriND2u32JIEtuNGitZXaJrN57qM++GsbThckr3pCS8FVgPhBEWEye
 nRK/XuGje0weiyxp35Bik5U2OHtvExLmff8OZpJJfeg==
X-Received: by 2002:a17:90b:1c06:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-395c2f42f15mr6018016a91.0.1787329417365; Fri, 21 Aug 2026
 09:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260821142526.276153-1-david.belanger@amd.com>
 <20260821142526.276153-2-david.belanger@amd.com>
In-Reply-To: <20260821142526.276153-2-david.belanger@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Aug 2026 12:23:25 -0400
X-Gm-Features: AcwNN1WFiQAg8gfwmiDser1x8aHo3OWBg4aNeb0zsTXdN96BmXS6Y81HTEIuLvM
Message-ID: <CADnq5_PtJY0EBG1E9yS+PHDTTQHZdYmYBGvd99vsLZvMGWdrgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: Disable gfxoff for CU occupancy
To: David Belanger <david.belanger@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Aug 21, 2026 at 10:26=E2=80=AFAM David Belanger <david.belanger@amd=
.com> wrote:
>
> Disable gfxoff while collecting CU occupancy data.
>
> Reported-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: David Belanger <david.belanger@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 0a7c1900da959..4316cb73b4115 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -318,8 +318,10 @@ static int kfd_get_cu_occupancy(struct attribute *at=
tr, char *buffer)
>          * XCCs in the partition.
>          * For PM4 queues, there is no cooperative dispatch so wave_cnt s=
tay as it is.
>          */
> +       amdgpu_gfx_off_ctrl(dev->adev, false);
>         dev->kfd2kgd->get_cu_occupancy(dev->adev, cu_occupancy,
>                         &max_waves_per_cu, ffs(dev->xcc_mask) - 1);
> +       amdgpu_gfx_off_ctrl(dev->adev, true);
>
>         for (i =3D 0; i < AMDGPU_MAX_QUEUES; i++) {
>                 if (cu_occupancy[i].wave_cnt !=3D 0 &&
> --
> 2.51.1
>
