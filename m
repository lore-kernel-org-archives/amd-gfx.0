Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BC606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YO+/Ahq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACABF1123BD;
	Thu, 12 Nov 2026 22:18:07 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB761123DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 22:18:01 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4fba089a273so30060b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794521880; cv=none;
 d=google.com; s=arc-20260327;
 b=rz+QBNsCpgQY39MoIcORD5Dv65ev586MIGwguhzyRZ3xjY/lN9G/r57oVZ3QWgn/Qi
 XAhuMDgC3NjdRW/2n4CLFfYDHL/u6IR0Y8EvKO4oMLqDMtxsmyWFcmlfA/J2DOpfKAo7
 s/Xf1XPBXhMrD2Ez1LIiP/HXV4jLxuTEDdFYPN7DFnuki8DpYMaN8gkQ/A2VwnP5bjDN
 /lpilvekSXRADn34rMtzzv25z7gwDRPZF5p3sXtfbgBNc5Ybywg2aswAHlhUL6DwK0WS
 6xTssOZw978f0X8lcgETj3E3ySNG7JANHRS8GgS2SDjJO6vf5Aom0kA4qUNHUG2nxAgN
 WDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=psdFpjCIYItqoCV3zld+fU2KEcPb1MgRoHlxQPHBj2Y=;
 fh=6odjMuM2A6GvIoOzx6KidjcEBPVHucgnrxKeqBrzpHI=;
 b=C80k4qKbcl4nkzHjRH7fHvsZVi9TntZDioTnTpzD0U4HIM8c6/dEh42i4VSuDbAr3s
 BLzXPaUZqvS33MK90PowXZ8LcQMc7V354MfeB4eIm84CYX7zRnNwOGA0xTBF7fwFap0e
 ajGY5C//Xhpuc+J6oZYRjbE8TUUHN77GUopUJYsnZ8IRvtnehybr/8A3FafXVSnW48wr
 e2ejRrsPomD6zdJUPZS2RVmuANBgghoRbmRgGsL5VpVTb4SLeI2X4yeJzbCexqSDKzmA
 848+l+n2H3TL4gs79JVWfJaLFLYNAmoSDrbjGF+eF7aVjy+S/Q9sRU/CRtdjdxncCwzn
 IwcQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794521880; x=1795126680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=psdFpjCIYItqoCV3zld+fU2KEcPb1MgRoHlxQPHBj2Y=;
 b=0YO+/AhqLT6NlF1QOXML2lkB2bjnok17dQGR15oG9TVcdJLM5YdhE7I18zMzo7l9Sm
 D6LOl9b7Akri4dyIr762P/LkgUmA/zjn1tELolYdhViC4xhCldJmNG3AVoMLnWqnmizn
 ubq/GJlDmZkUYYaXG2HB+zstbENatCAoK5D87PN2TZrdKb5WpsTJLnZ1CBl2XFiw6ToY
 +hvEXFuwqRr5gLw6jN7OSyguSNH2acFlxhJxM5T7LmdPq5stF0u+CzFS0q9Mmv+zzKa2
 50CjdwCmCtct+l/MOWpED/ZAoIhRJjW3IhIllsTJwiFiju5ktLzQ+YKdRHRQUXXuCMTO
 D8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794521880; x=1795126680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=psdFpjCIYItqoCV3zld+fU2KEcPb1MgRoHlxQPHBj2Y=;
 b=v7OsTi+Yw4CYve48+uvDWDgEqsBg37ZMLgm522BC/xBJjR00hbwkM+7P7Szl0aGkXV
 gn1AkTeLiVmyoY+Zl/qAND72W++RNqyt2s7LPOWOaOGve2A1d/UQnUMx5s7aMvxH+vaU
 1KdbqyKlxhrF7aMxrKe2S56iKcsgunqUeIYWMk/v5bVuagMB/32SuVC6sVJjEZYZUPXx
 LTHGB8pBgSt0FH0zyIDzoT8GhfuOS45vBDnS+GCc6hXCG6XuZATan0ZemQoSiLQae5ep
 1Az2Scz9h6m10sN4nUX2SMucthKcXfqzdPEfHwPYfUjaKVXU4wcv0JNa49YV4aOULF9B
 rZbw==
X-Gm-Message-State: APuU4Z/jqpZ1tzRuxC/ve39A8pNo2GCVU5u7/k2a1iXeTAghC4+bBKd1
 1/ntJ9vqNSRXjTXUCxU/YyYN1j8T/QpINJKSuK6HzS9ZNS6WXY03ioP30kgVQiAw9JeThGorMup
 LP1HFLoHLBJLrGng0E+CUUkU7cn7QIA8=
X-Gm-Gg: AYBFou2kiRLRI49P3TMq1q/5umELLhRFIk7CxRbESIJSXH99wcbrF9Y0v/Mug9y6Whl
 RIwH4jF5G6kyLRwe1GUT+XwNkowLFKZI5RluVJ0sZNcHpXv7mDuO+mtKg2sK+7jbld417MUjHp5
 tF2ad629JDFRgiScAj7Ieg8hnnRiX298XFfhMuCf3TWf9r0WR19wYE/68Ug5YJQkoHi96qwB0/r
 B373Tp9GUp80ebKpYguD3gqFsePndlrZ8LrHp67en1vsCl0VH3aUkdcK7MPX2Zb6gVhMr5aNTt1
 1r4shuNpWgWhceAwsHRykEStSwKS4R6c+bSXtzTLXDuETdP4l3PFYYGfBZDXhGrPDJYq+Cs6QXa
 vefvDMvsDsLfsMgBCEfEinItS4bg1Ra0qU8mWiQyII/UxtiNjvcNsxkxw2CKAIVhx83EsEt1psJ
 5kpdrrlMopzmqC1fhr4sWLpNaUI1MUNttE1/3GCRfREGNTr/NvMFJWg/v7RUtt
X-Received: by 2002:a05:6808:2220:b0:55c:866:20de with SMTP id
 5614622812f47-56e61801b33mr711596b6e.2.1794521880319; Thu, 12 Nov 2026
 14:18:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110011256.157652-1-ayush37735@gmail.com>
In-Reply-To: <20261110011256.157652-1-ayush37735@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Nov 2026 17:17:49 -0500
X-Gm-Features: AclHuK-df_vccOaqqVAFUznT-7qkiRVcZLObgYhZxxXeA24pixt6PcSBum-qZPg
Message-ID: <CADnq5_OJSeR4vKDUmYXRZMTzftFuqzPPumMmYAubcDTd99VKVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix kernel-doc in amdgpu_gfx.h
To: Ayush <ayush37735@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked and applied.  Thanks!

On Tue, Nov 10, 2026 at 6:51=E2=80=AFAM Ayush <ayush37735@gmail.com> wrote:
>
> Fix kernel-doc warnings in drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h by
> adding the missing 'struct' keyword to amdgpu_rb_config, properly
> formatting and aligning member documentation comments, and adding
> an explicit Return: block for amdgpu_gfx_create_bitmask().
>
> Validated with ./scripts/kernel-doc -v -none -Wall -Werror.
>
> Signed-off-by: Ayush <ayush37735@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 31 +++++++++++--------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 5939e1fb3..96f4e4ce2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -181,7 +181,7 @@ struct amdgpu_kiq {
>  #define AMDGPU_GFX_MAX_SH_PER_SE 2
>
>  /**
> - * amdgpu_rb_config - Configure a single Render Backend (RB)
> + * struct amdgpu_rb_config - Configure a single Render Backend (RB)
>   *
>   * Bad RBs are fused off and there is a harvest register the driver read=
s to
>   * determine which RB(s) are fused off so that the driver can configure =
the
> @@ -191,34 +191,28 @@ struct amdgpu_kiq {
>   */
>  struct amdgpu_rb_config {
>         /**
> -        * @rb_backend_disable:
> -        *
> -        * The value captured from register RB_BACKEND_DISABLE indicates =
if the
> -        * RB backend is disabled or not.
> +        * @rb_backend_disable: The value captured from register
> +        * RB_BACKEND_DISABLE indicates if the RB backend is disabled or =
not.
>          */
>         uint32_t rb_backend_disable;
>
>         /**
> -        * @user_rb_backend_disable:
> -        *
> -        * The value captured from register USER_RB_BACKEND_DISABLE indic=
ates
> -        * if the User RB backend is disabled or not.
> +        * @user_rb_backend_disable: The value captured from register
> +        * USER_RB_BACKEND_DISABLE indicates if the User RB backend is di=
sabled
> +        * or not.
>          */
>         uint32_t user_rb_backend_disable;
>
>         /**
> -        * @raster_config:
> -        *
> -        * To set up all of the states, it is necessary to have two regis=
ters
> -        * to keep all of the states. This field holds the first register=
.
> +        * @raster_config: To set up all of the states, it is necessary t=
o have
> +        * two registers to keep all of the states. This field holds the =
first
> +        * register.
>          */
>         uint32_t raster_config;
>
>         /**
> -        * @raster_config_1:
> -        *
> -        * To set up all of the states, it is necessary to have two regis=
ters
> -        * to keep all of the states. This field holds the second registe=
r.
> +        * @raster_config_1: This field holds the second register for set=
ting
> +        * up the raster states.
>          */
>         uint32_t raster_config_1;
>  };
> @@ -587,7 +581,8 @@ struct amdgpu_gfx_ras_mem_id_entry {
>   * @bit_width: length of the mask
>   *
>   * create a variable length bit mask.
> - * Returns the bitmask.
> + *
> + * Return: The generated bitmask.
>   */
>  static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
>  {
> --
> 2.53.0
>
