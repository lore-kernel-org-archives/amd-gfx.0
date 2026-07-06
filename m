Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2461C43602
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 14:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EA910E3CC;
	Mon,  6 Jul 2026 14:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RwdRF42E";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00D910E3CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 14:57:20 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ccae46de39so628295ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 07:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783349840; cv=none;
 d=google.com; s=arc-20260327;
 b=AsAqE0og6Gz0UOw2dWqnCM2Xaj0Tp2w/vRTxLw6HmagcTKjYoMQZd1qkR3eOAtYyzO
 rJqGGXXgSwfvPhioKwvth0XoPR7BxzSgOufPbJZVXxAS6EWiUAwok0VbMSxwNdBs3NgZ
 +jbdnTgo7VU0le8ptS5XA6BHbGoWh2D/TD8W2rKK8CUXMBY6brLUJl/Z4k0UgFzekULT
 lluQToLe6uI5naOU+qyKjIzdfAZfSb5pV2gqkhp9HP7OEtGF4ZZRVP6OzX0b+8ydcd30
 ig4rB9I7moApiHcQr9NEiFAFegQrXy8+UsjjfzlByG+HRU9T23LO2WvRKQzP+UhfFmRx
 I0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6gdmsALjGhuVm2HIUz1waHIl2f80jv6dfKKVTOlc79w=;
 fh=Lf5j6xmFXo6aMZ2gycuqcJNssxucyH+1AIBHCDa/iEA=;
 b=eYHe5/SczfJ+1BJLlLnus7BRg18c1XaRJx6rpJuKD72AyskJWsGb4weXxhRCR+0iYS
 nOrBqCDhuPtXEkQZnDQSdHXmWm6clKUEtAVHbFtRiheb9q87qzRiRU+OPqKwbL2370l6
 +g+KY8j3U/ZHdtVNftFc5jjW4iaq+oUBLvzgNpe1Gaoltp2IlJfroaq4LRSPK5KsddeO
 XF+2aKYfwOtDMciqA1wzv2d5KPQYYIHg6xls4hvPFEiaxVS75VNzwM3NnBz+srZocJ3H
 68bQaX/zrET/pvkQ165SmsJ4NqWyyAX/MI7s3o38YYu9yCOB1Ci3rX+hsN2CYCZ+wUYd
 KCqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783349840; x=1783954640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6gdmsALjGhuVm2HIUz1waHIl2f80jv6dfKKVTOlc79w=;
 b=RwdRF42EPO6vmoVTwoACoHZQ2fPeu1f0XpjIXvj8PH3qRv7ipmlK9wdkCp2KVNHAiG
 J7hEmicWX2AnuuBUkDQ6b86X6m1Ybr65mg0cgrN4+q6nIp9ZEO633YcLpQKi6uldqwJT
 2CpVnJJr2R2e2QrxYgZO2A+6YFEYBwRuEKF7j//eUqN9bRKARfFwAr9WCu78K0q0EqAb
 Ybj0IpuQf7uYvQnIeUSvP/kub9wYZ4H8O+rw1+Jff4rd3FOngBKoZYenWbRJZhkFRJfh
 d4126T1RcDjZ6aw0GEPBmpySgpuk0ec5rsJYxFNpxesF4hxgBcAQYHLoEgAqLZyNe4CT
 NgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783349840; x=1783954640;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6gdmsALjGhuVm2HIUz1waHIl2f80jv6dfKKVTOlc79w=;
 b=KoyLrWZN2Lx9hR95wqJ0KAab4K4sayoYGjuuL+Cf6461moNpR/a3y4X+PsGLClVPRo
 l79UgbjtF6pL1WxTi4f+GeitbhH9Lc07P/vBQnUCkZENSueFWjiVzFnqxEyY+u3FOAw9
 wCGfrJuRkfrtdQ3dJgnhrmiXt+Ai1MDgv3qS6le5g4jrBhg4mgHJi22A4J71S2++7pml
 TVXv/IuKN1SJUIPhcCKSOsJoU2K+VLsHh8x47iYY0boJOi6elyJwaqafWHUNvhtuSMam
 MdWZ82Nh+r+o3msOkD5rUw/BISHBze3DGN//dfWHWQ5MRNOEHi8vw//0Qa86mF6jjLym
 YK5A==
X-Gm-Message-State: AOJu0YzgOrMO/lMV5+fC61ytqGwywVg2GaiLOgPhmiOJFVE7jC9obva+
 cGV1znroHOWLYEIKxa0lY1al3jyUpCfXR3OgAAcCiGWneut1AgJ+7MYmRSLY3qylcDFAubkN4Fe
 1PEPFAUdxNyPH1EpysHRoSvneNJqLh38=
X-Gm-Gg: AfdE7cnk9T5EAsyIA5nkOvldbCBtC1gJVrH4oUpbmKDiMu4zE3uJ0jZq+LcwWJ8YJrm
 Gyk/NM9HN/2f7W4iTRvXVIuHbRY7t5uwMX3/MVc+Tzr2CKuq+j7w6kQvscGwgnyM1mbOiL3o+ZI
 fzVb38BKFjo8kSMA03AslSUfZ+a402evgyDKPPv41uTAZ8ZHHkQeZRjJ0isJxfU9ZmgH34ZqEtX
 vOTTAwP6K+eFZWHmbYFQUaDTImao3p5DOGohC3u1wBu0aB/sRaVG6AdFa6564gS0gMs1ggyaVnV
 PX1KDOPkFmpCUxGHYcDC3vqitvO/ltg/6zoFEp5m8tMQNZixmO+aCiN7SEs=
X-Received: by 2002:a17:903:b10:b0:2ca:dc3:5aa with SMTP id
 d9443c01a7336-2cb97e56acfmr66877625ad.2.1783349840304; Mon, 06 Jul 2026
 07:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260706143544.133714-1-William.Palacek@amd.com>
In-Reply-To: <20260706143544.133714-1-William.Palacek@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 10:57:06 -0400
X-Gm-Features: AVVi8Cdq2ImfAZdKJjX1HDOF9YBAfWlJIFrNrzmHn6hE-zOH7kXmvUUIfki5GTA
Message-ID: <CADnq5_OCPO5gTOXDQJmoh5_bZiJ4xJUATq0iPbAjj+SViwteGQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Add bounds check for CRAT subtype length
To: William Palacek <William.Palacek@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harish.Kasiviswanathan@amd.com, 
 Alysa.Liu@amd.com
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

On Mon, Jul 6, 2026 at 10:44=E2=80=AFAM William Palacek <William.Palacek@am=
d.com> wrote:
>
> The CRAT parser validates that the subtype header fits within the image,
> but does not verify that the advertised subtype length fits. A malformed
> CRAT table with an oversized length field causes out-of-bounds reads when
> kfd_parse_subtype() casts the header to specific subtype structures.
>
> Add validation that sub_type_hdr + length does not exceed the image
> boundary before parsing the subtype contents.
>
> Signed-off-by: William Palacek <William.Palacek@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_crat.c
> index 2a239f45fc24..6e0df685503d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1412,6 +1412,15 @@ int kfd_parse_crat_table(void *crat_image, struct =
list_head *device_list,
>                         break;
>                 }
>
> +               /* Validate subtype fits within remaining image */
> +               if ((char *)sub_type_hdr + sub_type_hdr->length >
> +                   (char *)crat_image + image_len) {
> +                       pr_warn("CRAT subtype length %u exceeds image bou=
nds\n",
> +                               sub_type_hdr->length);
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +
>                 if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
>                         ret =3D kfd_parse_subtype(sub_type_hdr, device_li=
st);
>                         if (ret)
> --
> 2.34.1
>
