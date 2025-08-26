Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B56DCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 13:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C4F10E2FE;
	Tue, 26 Aug 2025 13:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2qLRjMk";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB3810E2FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 13:35:05 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b4741e1cde5so798458a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756215305; x=1756820105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEjtluUQL/abJ/IM4Dcj3r5TCZSsSci3j3zYLVcWOco=;
 b=A2qLRjMk6Sz/YAS5NKe1cbCJXgMsfCMvmbixo7XmlXLdmb9xWkC/Ywpufq5/TVtb8+
 rWpDA0w5yK4tzEUqyto81O+vMVAw7n38d6bPWZ2+wBsvgwJrtH6EO8kZBfMI/SHDmaQ6
 iZwkp24AiYAMC67VLUj5xqqynLhDPQeoxaoQdIh6zMq9si1YtTVy5n6T4AH55Rx10EVH
 QzjJL9TvJrkWRN91G0/tpRRJiV2rJwzZI5CK4SOQ0qdvhU6bhN3E125fy5Y7xLV8T6yb
 ckOzw03TXuMRkgbba9nKScpjtvic5OZPTmeSCKA8vxbY7F1t4QV3oL4/7upz/UB4xONI
 IwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756215305; x=1756820105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEjtluUQL/abJ/IM4Dcj3r5TCZSsSci3j3zYLVcWOco=;
 b=Nvilo8ZHrVnwwtunAOyCF1VyeOLpcUfhcQqOH5weRYkNS670rnItd1oF1pZb2LzlNv
 cQ8rni+I+l7iV4Ew/8suQIZM+2SbtG/AaiDqnblOZiD9+TFx7A9ho+PuyBO/sb4wr7bP
 1gdBFhBRBv6HGwGmaz5foScaeMg46UQeGz84LEcJzwS3R7Sq4Kcu2ykaQsKgl5cIhVy2
 fg90mZIbzG+Lc6XDgysJVGpmsbcZYEPehgDnprEkdkD8H/Oizt/6vbwqKaqnABAR8knd
 XVfOwarGPpxtjsFkuINmVTtf/OQBxZxP7jb7cZH7dqLDiZCAc+/1wFrBQEId9aVfydia
 XGdg==
X-Gm-Message-State: AOJu0YzhZMx0YyHP3qw5QoyxtyJgBCEXeEZ6NCMZnw4e7n07msY+KhZM
 6wCgra8wpZtrSO8pDBjEdb6bJx281oE2UOXF3LzOWlRqBmFzrvqXOk+3hw7CDFhAripEMiHtpnQ
 3i5KTTqIsvWaGfq/r/kXI3Jh879HW9Z09Kw==
X-Gm-Gg: ASbGncsUvKteVSi7i0Ir26yzQeXKIMJuRXWJbAqouvQUlMR8i9ixrOtPh9cQPsNg7PV
 eZtAa9He/zrbfn7TL59Rgev5WEz6E1cjBXfjs88FEP0+k4ez2rhpgRPsTCGStoopE80rwY8VeUj
 f6OKin/5UektdPzTJOej2eqc8Jooh6y33l1qwOC9J7BSKcXl635jMznuYeKJ6hx4gQlk/VoXq0z
 Cco/oo=
X-Google-Smtp-Source: AGHT+IF07KYFd12tIYDVSlqJdTIyYCTYOjcA3OMxVf3Z15b23muf7uHU4YOBbXGuBJnWoKq4nx5BLRVayvzHMHefV18=
X-Received: by 2002:a17:902:e78f:b0:240:4d65:508f with SMTP id
 d9443c01a7336-2462ef99564mr95743415ad.6.1756215304960; Tue, 26 Aug 2025
 06:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250826060245.334880-1-kevinyang.wang@amd.com>
In-Reply-To: <20250826060245.334880-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 09:34:53 -0400
X-Gm-Features: Ac12FXxOP3esorZ8rUqZU3-HjH9skjOuUIBmdUHgyXcsIIs1EolcWkaG6JqRx1w
Message-ID: <CADnq5_ORhU02JJuM_WFi4FF4kXioWRzOJ+F7KtAWoE-a-m5RMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: disable hwmon power1_cap* for gfx 11.0.3
 on vf mode
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Asad Kamal <asad.kamal@amd.com>
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

On Tue, Aug 26, 2025 at 6:18=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> the PPSMC_MSG_GetPptLimit msg is not valid for gfx 11.0.3 on vf mode,
> so skiped to create power1_cap* hwmon sysfs node.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index d5cc4d7f84e2..c9a986cf3aef 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3593,14 +3593,16 @@ static umode_t hwmon_attributes_visible(struct ko=
bject *kobj,
>                 effective_mode &=3D ~S_IWUSR;
>
>         /* not implemented yet for APUs other than GC 10.3.1 (vangogh) an=
d 9.4.3 */
> -       if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
> -            ((adev->flags & AMD_IS_APU) && (gc_ver !=3D IP_VERSION(10, 3=
, 1)) &&
> -             (gc_ver !=3D IP_VERSION(9, 4, 3) && gc_ver !=3D IP_VERSION(=
9, 4, 4)))) &&
> -           (attr =3D=3D &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
> -            attr =3D=3D &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
> -            attr =3D=3D &sensor_dev_attr_power1_cap.dev_attr.attr ||
> -            attr =3D=3D &sensor_dev_attr_power1_cap_default.dev_attr.att=
r))
> -               return 0;
> +       if (attr =3D=3D &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
> +           attr =3D=3D &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
> +           attr =3D=3D &sensor_dev_attr_power1_cap.dev_attr.attr ||
> +           attr =3D=3D &sensor_dev_attr_power1_cap_default.dev_attr.attr=
) {
> +               if ((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
> +                   ((adev->flags & AMD_IS_APU) && (gc_ver !=3D IP_VERSIO=
N(10, 3, 1)) &&
> +                    (gc_ver !=3D IP_VERSION(9, 4, 3) && gc_ver !=3D IP_V=
ERSION(9, 4, 4))) ||
> +                   (amdgpu_sriov_vf(adev) && gc_ver =3D=3D IP_VERSION(11=
, 0, 3)))
> +                       return 0;
> +       }
>
>         /* not implemented yet for APUs having < GC 9.3.0 (Renoir) */
>         if (((adev->family =3D=3D AMDGPU_FAMILY_SI) ||
> --
> 2.34.1
>
