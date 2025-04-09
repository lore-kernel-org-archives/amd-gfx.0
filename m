Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A1C369A1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 17:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B82010E22A;
	Wed,  9 Apr 2025 17:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnXvOOyj";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E18810E22A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 17:08:21 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-301317939a0so794747a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744218501; x=1744823301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdTbhT9XF8xcZ3FBuJz0YeAGc1qcybewYRJLBrEeEIk=;
 b=bnXvOOyj+Wb7FGeFDUlh608fecZ8TrHPjL9RZ+xJuoMW3mVnl1mk9KpM7ghJNoIUJ5
 XbX1ww9XIc9oUsNs7fH3TuaKgAJ98iHaOW/u3c/HmWqF8K/9kWDc96dK/elw7H1TZerD
 s2QKoqBaTX34njdWThjHTcVum86gj8G8aT1/i5QWen2i/hqKPL+gL1a9KAGXpoGfZ4or
 EZjcaYox//pf8Se6twcUH8nFZBfTkWJY+LyhxDSxgO8dTwQHHe3VEh/usg+8JzT4Hv61
 Y4y9ItTnjFVI+CPg35+r3VCoBVR8cC5QPugMdAZpWYdDJfWnf0okCjLIh0T3ktNhmmtQ
 /6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744218501; x=1744823301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdTbhT9XF8xcZ3FBuJz0YeAGc1qcybewYRJLBrEeEIk=;
 b=fTCkWIBRHH2bk8pvxTTqQKS4wgmbcC6tlzTtuD5YM2fwxUIP8/erDAfwZEwlgc8zBs
 COo6vrtaY+311FPPHjTlEEAEXemDGuVzvpddc2fp35fYqYc42jYCNj4vvn69RjdXMo2j
 dhD6/S+9d8Z9goXI9jf/MsRPd0GzftCurAk6CarowFYbc3LpFAV7lfSSidmug+/ni/3A
 GPoMg3iIO+7lpHbT+kakeG7OqEZ1cmtalGl44ZSGRvIpQto3YafsJy2EF4dbvneSO7e7
 QMZ7scehxlkCv3O1vtk/BqtmyiaVkYi6/0ySCIG4dCaxxxOwLL2oek9Nho0Whb8Uh46j
 Xc3A==
X-Gm-Message-State: AOJu0YxVkiREcYfYtzxF6i7q5xeY54jHj4dqfx//jeWgmjtWWAlx1CrA
 AXUAKVAQxSp47Vbh3MQzHQuMEOYIjoPASQBLd5fughJ0pYFzLBGo+GvoHi1Rz5/3Fx4S4TTIwFe
 q+4jnTc9mukVKfP0yHoAccEVNIH4=
X-Gm-Gg: ASbGncsAQa892GIM8o0JEEyTuz0UKu5PFg1BQscxSpta3IfkccCxXmwrmlSiI1NqfhD
 2l5gGHTTm4IUSk/l5WHSRAvfMjJitotT1oVX/guV9uzwbfjd30NvvJAS4dmqVriOpUCpfrs0/We
 CrqE1J7qGo2po9IXuX6Y1xfA==
X-Google-Smtp-Source: AGHT+IEtZDstQIM+pxZUYbHfeZWO1WrOzHD6XZQjuA9l29N7T6ki/fNlx63Pe5ujX6EPiANE1mkUJDbY4keClMpAi+I=
X-Received: by 2002:a17:90b:314d:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-306dbb70f3dmr1977630a91.2.1744218501132; Wed, 09 Apr 2025
 10:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250409170545.658494-1-Roman.Li@amd.com>
In-Reply-To: <20250409170545.658494-1-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Apr 2025 13:08:09 -0400
X-Gm-Features: ATxdqUHdkzw9Rv07v-yqitokpGSi0_04XYsL98KbrFZW1A5TMOyaZAiyNhdUVpQ
Message-ID: <CADnq5_MMGJFebpbjEZ_cX_sL8XFtGyt8mM+dYj9Y87zkCxvFrg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add htmldocs description for fused_io
 interface
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Dominik.Kaszewski@amd.com, Stephen Rothwell <sfr@canb.auug.org.au>,
 Harry.Wentland@amd.com, 
 Zaeem.Mohamed@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Apr 9, 2025 at 1:06=E2=80=AFPM <Roman.Li@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> [Why]
> htmldocs build warning: "Function parameter or struct member 'fused_io'
> not described in 'amdgpu_display_manager'".
>
> [How]
> Add missing description.
>
> Fixes: af632d3f59e6 ("drm/amd/display: HDCP Locality check using DMUB Fus=
ed IO")
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index f84d6cd4f733..bf2839bb80db 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -639,6 +639,11 @@ struct amdgpu_display_manager {
>          */
>         struct amdgpu_i2c_adapter *oem_i2c;
>
> +       /**
> +        * @fused_io:
> +        *
> +        * dmub fused io interface
> +        */
>         struct fused_io_sync {
>                 struct completion replied;
>                 char reply_data[0x40];  // Cannot include dmub_cmd here
> --
> 2.34.1
>
