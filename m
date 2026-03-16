Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F4AF53D7E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 17:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9254310E240;
	Mon, 16 Mar 2026 17:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BtQEChNF";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F10E10E240
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 17:57:13 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12736a0147cso221112c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 10:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683832; cv=none;
 d=google.com; s=arc-20240605;
 b=I6HNZ2E4IikCd+d826WJd3Ms7ktyzbrzzS6/eEB4aFCGCLvodmw9Z8mSPMqV3j9uss
 +Ebi0f03gjbF+Kto2GEmjsqbmywnk4cWOXC/omWWl74wIswFLAylU43phTI6/ZJRzQ4N
 pNpBGHqArrpPpJHDs6ifiYgQBFvuRLQtRKnj/4Bso2PEhWr1ZUVOo9vUUevYVK0gNJIt
 aSx0KO7TmNKvODjXOcVOYYgCPpFRE7Q/LH7lF3pp+8wP4UFcgDpsWWsSws4sLjS26fpf
 EC/Y5G5ke3bkhkgIOGtAEqMg3BKJhg4Wd3EKN3mcQa1GiIlojCdUZPPkuRJXpxm4LVdf
 RLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CuqLDvBzRiNKggkDsEE/bNfME6n0kMg1ekG1Q6LM7NU=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=b/oCDF047QQmg3lwLkFhAUmcfCn3TFaFNiq1D7Xd7znFbkMADJ3gspuutzNCCGcVJY
 A+MJe9Q8B1CS7WwBp2VnpS4Z0OgZj7Qahge1UeFw4B2RfFv/RPTHvM1yFzCoxU9PXSYl
 OI48KgfNqH1t+iCNHh+DCRsjmZAcE6g9WF4ylTb/S+rYfG1R1zSt7jzkv5JpTUGDgOkj
 vYV82BdmlcgsvDJly39T+mEbiKygKtUbHkitOBO4IGcuF8sT9afQLbn2Wc6EqvEF4KRt
 JIigzbvrEcqwtrgEKJL8xRAGu7wPccFGTOGwwo06rYTWjPkqR8rtlTor7PXt42vIfCzt
 1Y5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773683832; x=1774288632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuqLDvBzRiNKggkDsEE/bNfME6n0kMg1ekG1Q6LM7NU=;
 b=BtQEChNFYqUJ2VO8y1Dt7QK3LvFV07qO77AOSlYx1C7suPYPmk6yRqh4ohou8Q5M1G
 RZqBMi7dnMxAGXDLqAc34t2cQFF12K8hHaTRlUQt4YsY9oi3jGw0rBcYVbXPcegmLehn
 yHlMQeyOTtYiaTvkB6ZcDWuXdCeEsOspPTzv7wJZHmKqzAXV+zfWpoYKbnNp/vfbqiMz
 KI4G/aIQ8L+bkQHOjlo/eyki9QKlW2aTnX1KspbNFPd+ejgux3VctXo2xlrZ6ATalOF3
 qUFTI0J7ychW+cS6rUhbODwzg3DfmlkIayj8zZ/yPwFvHa6yvFt4dkkllKb2iMWp5SuZ
 pcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773683832; x=1774288632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CuqLDvBzRiNKggkDsEE/bNfME6n0kMg1ekG1Q6LM7NU=;
 b=aj8c7obL4DSyxFJ/aopq9zBtLTvU9BNlBhe+uBNW1z1B97v8bb8ONBOeItV8Nrl9EA
 5igVi8TfpV0ia0v7bRy4N3VJYLfO1He28xzIGhcq1AIDajSb4VAwv2uCMpRQalEeBrQK
 nn6Y5rx6RR8D4egtkdhFCbb7gLEFe3elchsy8o2qFBdtSTW7PIeQYxsou0czWp6GV6WD
 PJoqTQRbl72PBRLxrJ3v0F1D40ubV8bnQJjK4fkuB/uErJh6akv1dHktGMLJyb0D5xPC
 aUMDFim2bTzJUs9aS3+p1JzikpPXp/nPO2lMelQoEZfOk+to9hJc+pEb/Bqk90PwquKB
 URgw==
X-Gm-Message-State: AOJu0Yz1ehCKLL0eTdBk9M8T9yFlFqHmtSG6u3C8SrjomoSgrSQa7hjs
 w6kb03Z7aM6DoLq1QFOQqE7MPo3SXfiIUOmk622hYzIoQ8noPusgdBOtPlEMk3uoEjkIkrwnIlU
 aQS7LolBgh6T6xKOjOnSEV+Nmp6gt3EbVdg==
X-Gm-Gg: ATEYQzwf0ost3tsPcAlh6Pq3KEbtwXI6sIxCeUdnm/ybtNOOwFVTRdFoKBb/0o6pVnk
 HGm/xVD7ClL8hHsKN6D7ZFsdySyTQGfCdQx3Ez2uUvranUKeqf2XCAQ6u+trsTE9dqUprft9/p9
 v9j9XfubjzPHTNfrgAZtNslhpDUuUgsxJFVN5JqkuUfz3LPxrurfi378LFPgLVXh6mQFsW2zmn3
 crATthFk4oKeF9ydnv/3ATWVuRSAZ0WSsgzNfKMRuUREdKR7Fcm9uYvuv7N11eNmxo+zcZYy1/Y
 tfwMCqY1t+mAhXylp+IsN30LkR/LU0x9Ht8WZ59u+Uuy9NmdmbwPTociTWONIvk3M23M+fAt9p7
 uKOnM
X-Received: by 2002:a05:701a:c971:b0:128:ccf1:356a with SMTP id
 a92af1059eb24-128f3e3e63bmr3434214c88.7.1773683832202; Mon, 16 Mar 2026
 10:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260219232433.31453-1-alexander.deucher@amd.com>
In-Reply-To: <20260219232433.31453-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 13:56:59 -0400
X-Gm-Features: AaiRm50N2cW5nFUXKTceXFjGxmyzLq8DpztR1gq_R8ATlU_tIxXlfmxBUljls6g
Message-ID: <CADnq5_OhVQ8KqW_Ha=ncTUvvKHJjJRzYz2uQbvdwepDwKQ9-ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx10: look at the right prop for gfx
 queue priority
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

Ping on this series.

Alex

On Thu, Feb 19, 2026 at 7:44=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Look at hqd_queue_priority rather than hqd_pipe_priority.
> In practice, it didn't matter as both were always set for
> kernel queues, but that will change in the future.
>
> Fixes: b07d1d73b09e ("drm/amd/amdgpu: Enable high priority gfx queue")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index afa9cb46ffd21..1a2deff420f4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6755,7 +6755,7 @@ static void gfx_v10_0_gfx_mqd_set_priority(struct a=
mdgpu_device *adev,
>         /* set up default queue priority level
>          * 0x0 =3D low priority, 0x1 =3D high priority
>          */
> -       if (prop->hqd_pipe_priority =3D=3D AMDGPU_GFX_PIPE_PRIO_HIGH)
> +       if (prop->hqd_queue_priority =3D=3D AMDGPU_GFX_QUEUE_PRIORITY_MAX=
IMUM)
>                 priority =3D 1;
>
>         tmp =3D RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY);
> --
> 2.53.0
>
