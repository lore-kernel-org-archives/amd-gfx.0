Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586CFF531CB
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 20:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F17DC10E52D;
	Mon, 13 Apr 2026 20:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zd0MVNWw";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFB210E530
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 20:22:31 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-127148c2112so850655c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 13:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776111751; cv=none;
 d=google.com; s=arc-20240605;
 b=lghtyr3+xm1FCpjQT/t30DbFWxvLi122RnZjYdkc0Nonqtm3wf6Ck17VJcmQsqRPYe
 Awpx4Fe5rnUg9Mws9aK6yf44XiBeRUrN1lbMZ2WzHL9ZrJ/exC6gdBRpMOQg9XFEg2fb
 wyaj+UNtlIMfKgMyZggnS1kwTLtUW+RejQ+M+EAZTTKZkYxJ3KVMa9PTrfdZAhT2gzY4
 q+ElZKpp+FL1chS4YZRqldI90nAdMQskNIhEVljW+tYTAeRswfktb2hrd5ZxjqVy3EiU
 TqXqaU24Pg2r/rUip5GecMZK0lUw468slimSIuZrdwTLWGmWvaSLEekOCp+Ps5Nu6TSf
 m5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4QJS5+jxIdnEOHweJ3Ja2oNCj1qrKnYtC4PkmiwTLuU=;
 fh=5/FDHmCDSK8XEPPNaPWLb6eKx52Erxl9W0yrYZ/YtLE=;
 b=kvDZnPqxav++5Ur9bm05BcSa6T3W5LnTsZONcBkrIZQRNP/hEzVajlgwnfRIhfVyJ+
 Fk2d3vhbsTCcvl+KDYdZbN7LDb5cZNITdtD9NyCcIG2zRih95alqBpoe6K4jXvBfuRDA
 AbG61m8M8pFwbigclD27+rOaQiVKPE+GW9OiKeHEqpUb/hxxwDMKtpoEivez/qM07OXi
 +gKz5prj6AQu+tK+WUT8eebFE5qv2xwdy2BsKD3EB+40syoA6+FN2B9bKfmmeo334OJW
 XFVCBCknQL8L79byLKjX6cjiV3Up+INxQl7SOJDnVLb5o4Bq5+7TYduNhge4FirmROCI
 CVUw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776111751; x=1776716551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QJS5+jxIdnEOHweJ3Ja2oNCj1qrKnYtC4PkmiwTLuU=;
 b=Zd0MVNWwAhr/UAWmySH0nUQYZ85Y+LsZOBbqs2/2BIK3r8S3q0zlKUFoTtV74danHW
 Rtdqmd6oCk4Vf3EYjJdOMK+gKpcKR9iAkNmmLxa5di3lCKotq01Jbb3kjd8agy8F5Qyj
 rQQFg9uBBOUVTqwHpxeZ9W4lEHV/9PAu+2Y5djOvl67VTZhThiv7tmeDW18n6bsVJHvW
 HFLvbRGHojkhdgnPxqZu/B0ZpQqyBkmDUBPr+Fao1U/MqA5O2zuRmm43TitIF6jQmCMB
 OFYu2o9HSq+YqPLLDygamyrVSZMycjUSbmYOCguMstNH+h0DKiC9m0F4EjRAMYMlUSTU
 La1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776111751; x=1776716551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4QJS5+jxIdnEOHweJ3Ja2oNCj1qrKnYtC4PkmiwTLuU=;
 b=plgDFQltD6nSZ5fUeRqJvqjyI51OVELMSZEIhfAstZaeHRN4aqTrdjXeSyZoUcDo91
 1S6IT7Wtjm8qAPyQHfGCpzENhduC8FqutTG7LIWvuUmIaH1/lahJR3xDc4UHy0yBwF0G
 tYCSOx37DZCZSkPgjxLkBimq4Ur215uZepm2aMVkO5e3cvM8JVw6osnA+9k1oGI2Am1D
 HySXtSw8e62wuDp2j3sSRaRc3RvcKjWquA2x1UWjKn1UpuAPQI+Nc+HlE/Bxm1FqIRgh
 gs54wva/yqJCH/lyIyCaYS1myGgrUjLUSVWORhagiA07uOinKfgpW5mBF/WXx2FaJzer
 u3zg==
X-Gm-Message-State: AOJu0Yy3BB1Nyhr7cqRg6UTCEpebAMC2aoXE6rx9SflRk7VSriusps7H
 Uz4/EXMBRNBOlxDqhahgPPCWCCpCerNW+qXxlCk03M29Q8BSqQMR0vHhPG58eAzSraXHz2v9Z8K
 tjQ47ac/n37X7nnKKmV9jhbzOw/KfYjY0gw==
X-Gm-Gg: AeBDiet+GGBK4RRZDdWzYYwIqGy6eQe+Nq4DbYC+Wn6AtGO/QRKJkbaQ15d0fUibKwU
 4UtJDIHI4cPWq1HCiC+NWzbLOD4YLWLBhiBlmels3fPCCFAQaMCodudYJ0E/lcrUKrMJO9LX4Hi
 +eq0revMY4HOaNBEkZlMiTqQ3e5fy6x0g1AOz/cPBuf7XKfAYBXZ5KE5a9b1NLEL0uXiagupvgT
 Xk+7seB9DtYSAbHqIcDviUmB7EUGkb4XBKrERi4xYed926QSsaupZ9m2SY7YFQUsZklUhHxP6ps
 t+gigAt0biEj3evZEBlrBNw95Pk3r7grBiBQQ8Gn2B/SG5w7+2uEh9j29O9fiuCu7duf1Bx4s92
 wQdXy
X-Received: by 2002:a05:7022:6b8d:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-12c34eda892mr3931843c88.4.1776111751021; Mon, 13 Apr 2026
 13:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260413183421.3191963-1-Amber.Lin@amd.com>
In-Reply-To: <20260413183421.3191963-1-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2026 16:22:19 -0400
X-Gm-Features: AQROBzD6ZGyAtcgfZfJzkbBNAuhsJg6mzPGuGb8VbWpjEgbWbyF8w-QraLKcio4
Message-ID: <CADnq5_NTnya35CZ8MHw5KKLpqWksycP6mWZE4rMSBvdBR_0XhQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] drm/amdgpu: Create hqd info structure
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jonathan Kim <jonathan.kim@amd.com>
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

On Mon, Apr 13, 2026 at 2:34=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> Create hung_queue_hqd_info structure and fill in hung queses information
> passed by MES, including queue type, pipe id, and queue id.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 ++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index f1f8bbfc31e0..ae42fbaba34f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>  {
>         struct mes_detect_and_reset_queue_input input;
>         u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
> -       int r, i;
> +       int hqd_info_offset =3D adev->mes.hung_queue_hqd_info_offset, r, =
i;
>
>         if (!hung_db_num || !hung_db_array)
>                 return -EINVAL;
> @@ -481,18 +481,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct =
amdgpu_device *adev,
>                 }
>         }
>
> -       if (r && !hung_db_num) {
> +       if (r && !(*hung_db_num)) {
>                 dev_err(adev->dev, "Failed to detect and reset hung queue=
s\n");
>                 return r;
>         }
>
> -       /*
> -        * TODO: return HQD info for MES scheduled user compute queue res=
et cases
> -        * stored in hung_db_array hqd info offset to full array size
> -        */
> -
> -       if (r)
> -               dev_err(adev->dev, "failed to reset\n");
> +       for (i =3D hqd_info_offset; i < hqd_info_offset + *hung_db_num; i=
++)
> +               hung_db_array[i] =3D db_array[i];
>
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index f80e3aca9c78..2e6ae9f84db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -170,6 +170,19 @@ struct amdgpu_mes {
>         uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_P=
IPES];
>  };
>
> +struct amdgpu_mes_hung_queue_hqd_info {
> +       union {
> +               struct {
> +                       uint32_t queue_type: 3; // queue type
> +                       uint32_t pipe_index: 4; // pipe index
> +                       uint32_t queue_index: 8; // queue index
> +                       uint32_t reserved: 17;
> +               };
> +
> +               uint32_t bit0_31;
> +       };
> +};
> +
>  struct amdgpu_mes_gang {
>         int                             gang_id;
>         int                             priority;
> --
> 2.43.0
>
