Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376DCC52D6F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 19:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D853010E3F1;
	Tue,  6 Aug 2024 19:45:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mUvgaAN5";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B33C10E3F1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 19:45:00 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-70eb0ae23e4so805552b3a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722973500; x=1723578300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6ELmz19NaEWa5bgLOrZ/vdbnL1rIjZx36DlXJb/eZY=;
 b=mUvgaAN5pFbu3RqHh42ObR8uIWwSSmI4CsRGcp0s8irE3/h/gaZ5eexLdWoYOBy4EB
 nrV3ZbZL1AG1/HcuHYiv0ALQF9juOylqdIlrwGjkiHddUpP6E7mfYVE3p7YqBBuQKSwK
 cvsFv8z2gFv4vLd4QAJ7r7NmkeX9N7mxVbuPfjMcSZn6CllJqpE2nmqG0G73JrstHLXq
 zsPKbdhQZL5RP1oTj6uv3UbWio49cucWE41dEuEM5/BsBvGqSJV3qoAOMbAYIzGsK0QK
 aYOYVFtrzSCx3lo+ySDL0qLTnFHEXcF8qsEyz6G5KJ3dk9wDUiBMn7k9yRK2BRUmzjWO
 ++VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722973500; x=1723578300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6ELmz19NaEWa5bgLOrZ/vdbnL1rIjZx36DlXJb/eZY=;
 b=Qqzs1D6DCLvrprQDE4monViPBFhE9WVVo5o+Luee0A5T6TynEcSzuPTeprS+ku0nfu
 5QOyjRESV1f5S+1LJm6j84i/jUDfgilnVPj20JvDaInIYl14nqk9MO8fn/yTARL+JGz6
 3of+6iownsJxVtYXqcyr6dqvU28ML0m2iafyF9Vro2r/hzOn+6JWgplqFpBKBy/SljH8
 fB0Brrd5CG+egXYsnYNL73n72eB2ViShQODgOAOtpVQspapaFPsXBY5CFvrGvcUkCNMN
 iYqvbK48+bgEveRztgKGe5wc4O6Ho81YRvqpTwF8YekOGLpRwK6ZaXnNVdF+sK9Tsw3T
 MaxA==
X-Gm-Message-State: AOJu0YwIiuhfVNX0Y6f4jv6xuKoV5nBzlgF/MEpEStgeyNiOWI4j9DGb
 L0lk53e7cFrmx0lFmEu0DxXqxFuR4EEAktqvgm/ErVYC9oxYDv6FyN0q8ikM1ktmQ1FMQc/4Rwo
 QTuWL6bwO2wr9sOsPKMex5SnRkSFa4A==
X-Google-Smtp-Source: AGHT+IEL0QWBzG/4xK43vUVSkmzK1F7j8YQEq99Nke+2UQ+WnZBKSUd6FoTChKmK+yQt9CHxA5gy9MTLat9KeDuBTTs=
X-Received: by 2002:a05:6a00:b53:b0:710:5848:8ae1 with SMTP id
 d2e1a72fcca58-7106cf8fd33mr16804864b3a.4.1722973499735; Tue, 06 Aug 2024
 12:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240806193805.200607-1-yinjie.yao@amd.com>
In-Reply-To: <20240806193805.200607-1-yinjie.yao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Aug 2024 15:44:48 -0400
Message-ID: <CADnq5_O7YrofePwd0gSL1o3p_2sd4sgAHxfByCWxbWMerMZbnw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Update kmd_fw_shared for VCN5
To: yinjiyao <yinjie.yao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, ruijing.dong@amd.com
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

On Tue, Aug 6, 2024 at 3:38=E2=80=AFPM yinjiyao <yinjie.yao@amd.com> wrote:
>
> kmd_fw_shared changed in VCN5
>
> Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
> Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

BTW, should these structures be marked as packed?  I suspect they should?

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index f127eccf59d7..2a1f3dbb14d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -464,8 +464,11 @@ struct amdgpu_vcn5_fw_shared {
>         struct amdgpu_fw_shared_unified_queue_struct sq;
>         uint8_t pad1[8];
>         struct amdgpu_fw_shared_fw_logging fw_log;
> +       uint8_t pad2[20];
>         struct amdgpu_fw_shared_rb_setup rb_setup;
> -       uint8_t pad2[4];
> +       struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
> +       struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
> +       uint8_t pad3[9];
>  };
>
>  #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
> --
> 2.34.1
>
