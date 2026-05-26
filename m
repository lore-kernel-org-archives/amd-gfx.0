Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290BACD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC57510E47A;
	Tue, 26 May 2026 14:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZ+e/czo";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5E2210E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:05:36 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-13246a5110bso345004c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804336; cv=none;
 d=google.com; s=arc-20240605;
 b=KTLXbPJ+VqiD5/kBLDuOWZ31qDfZ3XrgZw4uae+ckUwaPgjZYWfhWqFx7iP9MM91xz
 rMZYHB7jbShQiAfeDUAaJox+XO62kdhc7g8j2SDRr78wKEZulTpR9001LTfK7si3tOMP
 TGfYuiShIUY2d+hOmsXFhV3YAAri5ehqP7uFAdjByzpKDd7KPzXSwytBUhl/GEDs4JGG
 h6LtsS/pjlc9jVlshLJELFshXvBmwmYmoKRvyAsSLyleu18yGLfLf3XwanCUYlMOsmEk
 dPp9RGe1hDhP3Q5AiHpHInmcPO+F/OciC73cAotlIB7Dey30Hzzt4eCyAF2A1PHf/4v3
 C36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EXNaEMtPRkR//gjDxwlvSQ0RnP5SLmqGI4SNcEOeI3k=;
 fh=avgB/rxnL4aqU71KSbsGuKKcuxa8timNAEUyMelhKoQ=;
 b=c3+SqgIK2tLKBD7O54sKwuPUIV3aHXMv2bei+x3N4F4ZPa72n/8gT44joqmAx3wVl6
 z2GudkJKM5kqNJ58QoFsigyZBLgmoaPn61LZ1T4csvEYJ7URzN1qupFuO1gMFqYogze2
 MtF4uyLCGHl/cKYRimAhkO1a3utXhhyTqV6jNXJhKJZl/9zApYo43TOjRfeBMUEIbjBT
 w+ebht4zBLH3mx7dMGB2/TD+sdRiYglQCLNH+uLHFE/H0+9AgZNc6fJ/fcAah9EIjjhD
 ioyzmv2Fp5oduckbQqwx1x9SxRFOxIG3xXlkaL2HDao7OQc5B2ljJDaHaZGEteZFQLgH
 eZmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779804336; x=1780409136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXNaEMtPRkR//gjDxwlvSQ0RnP5SLmqGI4SNcEOeI3k=;
 b=jZ+e/czoQRJRjD97eyGyEIx5rfZ5+i3VB8zrzxpTojKGrkfWsple7h1TxcruB2c77n
 7lTgXYtSYy5RDyx7yRTriWwESlLrXvLZJCfwOXZ3+RZmAgmhxrQyU6FqOhEPgsuZwWJQ
 dw/5VgH7xphVaksDWwsbwjicgP40Bx3VVf59DcjtwjUFhy4+lFgxuZkEwOfxO5etNIaq
 HO2dM1aYYEEa5jr2pv5hVBmwqlj61qrfZ/Rw+FcDfcf9HtlMWUvXPRZYL2gIQ1sa8psh
 NzoQBIM65tfUWO/6ec/G/VqngJmnDU8zU/KGAhotkVI2Nr95AD+mPPaX874zE8F0ZqOe
 hocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804336; x=1780409136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EXNaEMtPRkR//gjDxwlvSQ0RnP5SLmqGI4SNcEOeI3k=;
 b=IK0SMtbEaOpAEhgHmGmamCOB8IpT3iYMMm0zfYzHoZy2IfbUw+45crJ93CKyYJ+2ua
 N7ensE64kkl46lo4DmL5IGtVIJWMvDIedHddkFs6R9ToWKBbHbpkDSqvezhFsdrlsq0r
 VlhEgFolrLf44NAIhSEAn06ciLgoUJE0ZI9qoUkzwl/hA6GAqmOxzWJveD4tGGm1de45
 4sjmhn1fMP7kaJvTZn33DApA09XuIi1xZVj4f7s8enol85IalAtwJogr9MDERk0Y3KhO
 SzT/VyZ87iVs3mXAcDZb4j4O80FJsLXPgd1mZsOnJvgoCkoB++dlnAzDivcwUKZvanBT
 Rgcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kflVMUVfBkBBGRhxtnhlIRCiVzItLh3mmDxRoJa36acLRFwoDlWSQ3c62NsV0frY01tlPs0LJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWlpe1paRrbVJkfeuol2bFB6V+YLqn1s0W8O7vkd1AcvvoLw7q
 YLZuqcOU6GYUrv9JJho9ptkQokCD5l96pCpLvb1OtLki3fjcdQ9/2p0vu3nwHjQ4UK7u1LPf3ZX
 lxVRfHVJ6d0B/cdOU0EYxIQKmLQ3q7QY=
X-Gm-Gg: Acq92OHFcoXZaCb42SNwKViHZCA5f9o9HSxLrHDfJ1+fR4ay1NU6oHZpHmqfSnyv7/6
 HPtMPRoEmzmCmmxK0zS5ufrCy1UcdGFsmF0RlOytyNRE0DnGGKjzf7HB/ppHrXqRrP6b4B1DdpQ
 owjP1GVAmGbFkwmuX82YBzBHhvQ3U0yzAgZiUfFM9RbYOMY31cjodY4DmEStl+qh7OwvgjzKrqw
 Qkfui3tNx3p1t+qb80qx89CSummFUkEjkmuu7cpy5MGcPhHIIjPGzRFyDXNdiD9Dwks7mw9FLUa
 tYsTVLPmt/ySAmsMPWXIYkeAAHnux6P1gKeoSnkofu30U5hYiZL3j164TFXOPhAwp2aJ2+iDb6c
 8GmhD
X-Received: by 2002:a05:7022:68a3:b0:135:1b09:db43 with SMTP id
 a92af1059eb24-1365fb651b4mr3167459c88.6.1779804335095; Tue, 26 May 2026
 07:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260525153156.1258211-1-jmuthyal@amd.com>
 <20260525153156.1258211-2-jmuthyal@amd.com>
In-Reply-To: <20260525153156.1258211-2-jmuthyal@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:05:23 -0400
X-Gm-Features: AVHnY4J6gjGcZTMfUTH2rsVBYcrds2CduNdGYtMW-pMelzbRA7xl0jRjo8S3vF4
Message-ID: <CADnq5_N7EO8GBxff9H-nGGzU_3jDgt6KFo40-HSmYuoG8vkO9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/vcn4.0.5: enable secure submission on
 unified ring
To: Jeevana Muthyala <jmuthyal@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, May 25, 2026 at 11:49=E2=80=AFAM Jeevana Muthyala <jmuthyal@amd.com=
> wrote:
>
> Set secure_submission_supported =3D true for the VCN unified ring funcs i=
n
> vcn_v4_0_5.c so secure IBs are allowed on the unifiedring.
> Without this, protected decode submissions are blocked by the
> common IB gate and can fail playback for secure content.
>
> For vcn_v4_0_5.c (fixed STX VCN version), secure submission is
> enabled directly in the ring funcs definition.
>
> This change only advertises existing hardware/firmware capability;
> non-secure decode paths are unaffected.
>
> Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 1571cc5a148c..c8879a6e5297 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1479,10 +1479,11 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ri=
ng *ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);
>  }
>
> -static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs =3D {
> +static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs =
=3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .secure_submission_supported =3D true,
>         .no_user_fence =3D true,
>         .get_rptr =3D vcn_v4_0_5_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v4_0_5_unified_ring_get_wptr,
> @@ -1525,9 +1526,6 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struc=
t amdgpu_device *adev)
>                 if (adev->vcn.harvest_config & (1 << i))
>                         continue;
>
> -               if (amdgpu_ip_version(adev, VCN_HWIP, 0) =3D=3D IP_VERSIO=
N(4, 0, 5))
> -                       vcn_v4_0_5_unified_ring_vm_funcs.secure_submissio=
n_supported =3D true;
> -
>                 adev->vcn.inst[i].ring_enc[0].funcs =3D &vcn_v4_0_5_unifi=
ed_ring_vm_funcs;
>                 adev->vcn.inst[i].ring_enc[0].me =3D i;
>         }
> --
> 2.43.0
>
