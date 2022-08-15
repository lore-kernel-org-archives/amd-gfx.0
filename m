Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEF6C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 19:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560D0C38CC;
	Mon, 15 Aug 2022 19:10:18 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB69D298A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 19:10:01 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-10ea30a098bso9159603fac.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=f731vXyj9kE2PS2td0VZE/8R3zNjbSQbrlI/oLIGPrw=;
 b=DqBcpU3CCjC5XydMyiRv1wpkXHBLOs3N36r5scxGdN8vzBEdZBBi6Ajc6VKxPfLsRq
 Vy07SvUMEdrBT4DFd8yxCm+WIdigo/s0yAmNAJruoBR40UgCtG2GRIyqZQ4Eojy78r6T
 m2ZsD5CiH/QFNF/39xB5SHHCqLmf8DPpAoLa6kTvcjmzxWwGg2uNTso685WXAo1UXTjI
 Vl3ltFH67gkEY3fcYTbLLoOyhKTlyjrEnZZSMOrKDrjqFhrBZKZv/43RPx+gXophArHQ
 JxSChn6rzNLqlr9raE03jhXm6uzDdEcap2tkUvQKiPVkc9pOGLNtrwGsb2F4vq2Bd0tc
 +Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=f731vXyj9kE2PS2td0VZE/8R3zNjbSQbrlI/oLIGPrw=;
 b=gVPLQcDObtxBx8cIGoO+9I2FhiGXj8wLfc7DXFEbiTsQI6vyE0eOMJ7jL4s6SImWPO
 36zBCP+H5BkeGdf2yzCSqFFUNCqRQxiPujSCoilf3wz/ELsquXxEtNKKqVOQbMRrxAs3
 fYj1F7Uoe9WMVW3IK4sx4f+euPl2qBuLaOaAVMap/h0MwQKBDq/hraxAcypbdIVTVWna
 YbODIoBx+vHBsivKM5R9C1fcY5WA/Q4uU3sLCyWx/z3jfmlHiiZFJhuDLxVHGb8iBkk9
 dxFP0lbR7mh6GKroYfmDDrS5WS1YBXYPUxsWEyXG4KlUa2GoYA6iQgGKId9fgR3jkOtt
 g7eA==
X-Gm-Message-State: ACgBeo1bqbmsG25Ir30L2lqd43VKuFaFYSXKT7LbKcLPqAPRXrEXIpki
 BWR5PIiNn+JYKVmANXLdJuGQbuQzzyEs/KOtidI=
X-Google-Smtp-Source: AA6agR71Ke7aqFbjCQCxpYJ3DqQlMHobrL3rgfT3KnukoQAHA8nNHv5n+N+UwD1HocX8mjlcUEVJBn763/iwbqDxrvY=
X-Received: by 2002:a05:6870:e98b:b0:10d:fe5c:f818 with SMTP id
 r11-20020a056870e98b00b0010dfe5cf818mr7521951oao.106.1660590600264; Mon, 15
 Aug 2022 12:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220815181716.918439-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20220815181716.918439-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Aug 2022 15:09:48 -0400
Message-ID: <CADnq5_Of=MUk8U2RGA65zwGaVN6GhNZGKaqxETB98-=xaPE3HA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add decode_iv_ts helper for ih_v6 block
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 15, 2022 at 2:18 PM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Please add a basic commit message.  With that:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 92dc60a9d209..085e613f3646 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -727,6 +727,7 @@ static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
>  static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
>         .get_wptr = ih_v6_0_get_wptr,
>         .decode_iv = amdgpu_ih_decode_iv_helper,
> +       .decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
>         .set_rptr = ih_v6_0_set_rptr
>  };
>
> --
> 2.25.1
>
