Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EF3D58CCA
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 12:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75CE10E697;
	Tue, 24 Mar 2026 12:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQ8V7WCo";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EF010E697
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 12:48:18 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2bd5658b901so224846eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 05:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774356498; cv=none;
 d=google.com; s=arc-20240605;
 b=aUPCheMv+5VU0t6L8T+rvEpDdWZ3S+H2gUu0DapFEYjz+Z6fQkayT/kdzeOAcbUpre
 GFoNayUDSCQTOzfYjuHcofN/ZgSvyDhZ0rEEOxF5VYcYiVrLhsGtDe2nefUAlHochZvm
 flVbzzVz42MOmGSzQc32mIYdy1Hnw2aYHA3iTxrTXNfMUr7HtV0K0Nr2GCeTQxxlsX9K
 jSWLW9j/UzFT+gw52ZLxzciHNFhMTE+MBYJI2ZkylRpUYsonpVwmeBQ1oddC5o76AXL8
 zvTS3KUgnq6LjSbpA2QIj1/dAPfd+USAVwKuxtUrEQZq+KcQ/Q605vD6nHFCSQuA11bz
 X8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rN+Ma/alD/i3axX3Pwge2T5p+YNVmRQr2aGFzDsZMEA=;
 fh=BHpf378ldUg+QnadswhkoyRg41k/2fcscBej1M4Elj0=;
 b=Tc4Aujy5eQ5dwdE9jlZ/yyRXk+dY2lmPtTzvzIeDAa++hghMnqZDc8Kqqt5tT5haJl
 rYrAD6powzDrU/gxC6s9aacd8LiThnPjgrSa2dBFP2UD68dUPt9cC34AByL3hKVa5jFV
 vzxpvK+f9UvSKZfUxZZlOYE2+JOzRqGYfQmlj80d5iVkqrmuTnD+2EqQtyALLudL90Wm
 b9hKnb9aFa2Tpk+4/8SbHuJS1DXuBADmfYVqjG+9C7DPbWiJCc8oVXU6TCkideTIzL2c
 cZpr3g2k5zvet5WWTOGihoyQUMeFsMIbGJh28DTlemRjcnNkddZz7uUUfUkxfnTAZ+MP
 ST3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774356498; x=1774961298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rN+Ma/alD/i3axX3Pwge2T5p+YNVmRQr2aGFzDsZMEA=;
 b=PQ8V7WCoTFPdETi/Tw+IIHObV2LJo+7elIsCxMM6EBxc1OFPRLiFtlWrkDnrtqRmyN
 AIM/ox0huVgFl6lBVuocn3AgmTIEqJ4Ssy16/1iIh3HvceI8CRx1DiRtejktdurijx9Z
 HsEbzweXM+h6c4ME5BQDwcKTlOSTVkJT8YPGSrLSXqkBpeo6V8rQkxbL2JMgqKHD62Dm
 RwbAar0MM34pZh+eckf5wcbKPRz3/wMt6XMkATEiIZ/eWr5x7wTRRK4s0F/J1E+/F+2d
 hvoazuHNo5me0ng7j5uzZqSBpBKVeS+OR9aMDZt+X4TyRzWzBn5XOzrLKHhWuOAmvet9
 U/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774356498; x=1774961298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rN+Ma/alD/i3axX3Pwge2T5p+YNVmRQr2aGFzDsZMEA=;
 b=IWfU7N68JRPShSVglT6O3FlipAesvr2tcr9LUqQFE43Fb3jMtZTcDCUnWp4oyBIqDs
 oTu8Qph6nKxvFZhDTHkJGadiKzyZbWsHusWXSKNl8fOI4Jr9unG8Xn1gFqqX3SPG/bOF
 HfYcUFdC5G/0dRF7SSi9IhB3rre4+vm8W3Z2kPDLOznZ86NsSx4jOndnh7PqEPhtCTSx
 NcFbA+1k6u3arHsJd9Qg8gtUPlXrR7otUpcBmmHkG5VvocBYxcDgTVM4irT3rsFNpGSz
 jKd6eTkpq766SZhnaPRF+w/MY7FQLXn5cNju3somAcFUJzVQ1JelGGWZaujjAecnITEN
 htTA==
X-Gm-Message-State: AOJu0YxmHJxU8+js/p+UEj6EzZvr1RHqCJnm+/5f359ejVdIaht9TqCD
 nLKzUDF2tESSvvHwCso+dvCcT+cnA6V3OtAb7i8F8Rij6ia4dXovOzZX4KUztTjnFRxLZwpfnO5
 OfKfU6zaomRI6Qt7L9xPtOXNqiAVZY9k=
X-Gm-Gg: ATEYQzwvmXhUJNBqgSzrS5Y3pueVaxzgqC2jEvLQFZAwZ3gE1UW3nx+smwRf7F/JsHj
 J+Oa4FLSd7tH4J1XBJRJn46P27KWumxC7e/qEJpQzmzZhS1efO03yk6H+k/JB48x0t/rQjE0Bip
 6+wwi9BdqjxippqGXJ5SDJ1VndP2pi2Dn/muIbP67Sydv+d7A0IpewF3TKb2DqA8ERxCGeYKEdt
 mRwuY8lFfPD6wBAmAostfCgRl9qHkVGGDtFo7HsA1nW8Pj+RdzgNU3W1xaIzmZbQAxxQOKLHSZO
 ogjCpvgNjmf95vaxi5JK0eeATMvSC0YgbL0gFRffiFID4V3Tr93/W1ozffRoXF4KM3KiF3LXnjW
 ewrLE
X-Received: by 2002:a05:7022:419b:b0:12a:6cff:2e7e with SMTP id
 a92af1059eb24-12a726e44b4mr3332285c88.7.1774356497467; Tue, 24 Mar 2026
 05:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260323153923.1055788-1-alexander.deucher@amd.com>
 <20260323153923.1055788-2-alexander.deucher@amd.com>
In-Reply-To: <20260323153923.1055788-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 08:48:05 -0400
X-Gm-Features: AaiRm53Nm7QzCHn2fXemrudvRsynfb7HzqIFD_n7xt6AFv41FjsJpwUPuy8MmeA
Message-ID: <CADnq5_NaEEH1-Kcpmbze96g6GucAanpZF6AgFmhMcDHu90uSRg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/display: Fix DCE LVDS handling
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Roman Li <roman.li@amd.com>
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

Ping?  This fixes a regression on LVDS systems.

Alex

On Mon, Mar 23, 2026 at 11:41=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> LVDS does not use an HPD pin so it may be invalid.  Handle
> this case correctly in link encoder creation.
>
> Fixes: 7c8fb3b8e9ba ("drm/amd/display: Add hpd_source index check for DCE=
60/80/100/110/112/120 link encoders")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5012
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../display/dc/resource/dce100/dce100_resource.c   |  6 ++----
>  .../display/dc/resource/dce110/dce110_resource.c   |  5 +++--
>  .../display/dc/resource/dce112/dce112_resource.c   |  5 +++--
>  .../display/dc/resource/dce120/dce120_resource.c   |  5 +++--
>  .../amd/display/dc/resource/dce60/dce60_resource.c | 14 ++++++--------
>  .../amd/display/dc/resource/dce80/dce80_resource.c |  6 ++----
>  6 files changed, 19 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> index 05f7ff60f8f5a..2b884e28727ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
> @@ -651,9 +651,6 @@ static struct link_encoder *dce100_link_encoder_creat=
e(
>                 return &enc110->base;
>         }
>
> -       if (enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc_hpd_regs))
> -               return NULL;
> -
>         link_regs_id =3D
>                 map_transmitter_id_to_phy_instance(enc_init_data->transmi=
tter);
>
> @@ -662,7 +659,8 @@ static struct link_encoder *dce100_link_encoder_creat=
e(
>                                       &link_enc_feature,
>                                       &link_enc_regs[link_regs_id],
>                                       &link_enc_aux_regs[enc_init_data->c=
hannel - 1],
> -                                     &link_enc_hpd_regs[enc_init_data->h=
pd_source]);
> +                                     enc_init_data->hpd_source >=3D ARRA=
Y_SIZE(link_enc_hpd_regs) ?
> +                                     NULL : &link_enc_hpd_regs[enc_init_=
data->hpd_source]);
>         return &enc110->base;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> index 7c09825cd9bd3..d957598911cbc 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce110/dce110_resource.c
> @@ -672,7 +672,7 @@ static struct link_encoder *dce110_link_encoder_creat=
e(
>                 kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
>         int link_regs_id;
>
> -       if (!enc110 || enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc=
_hpd_regs))
> +       if (!enc110)
>                 return NULL;
>
>         link_regs_id =3D
> @@ -683,7 +683,8 @@ static struct link_encoder *dce110_link_encoder_creat=
e(
>                                       &link_enc_feature,
>                                       &link_enc_regs[link_regs_id],
>                                       &link_enc_aux_regs[enc_init_data->c=
hannel - 1],
> -                                     &link_enc_hpd_regs[enc_init_data->h=
pd_source]);
> +                                     enc_init_data->hpd_source >=3D ARRA=
Y_SIZE(link_enc_hpd_regs) ?
> +                                     NULL : &link_enc_hpd_regs[enc_init_=
data->hpd_source]);
>         return &enc110->base;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
> index 3f0a6bc4dcc23..1cce903d477aa 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
> @@ -633,7 +633,7 @@ static struct link_encoder *dce112_link_encoder_creat=
e(
>                 kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
>         int link_regs_id;
>
> -       if (!enc110 || enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc=
_hpd_regs))
> +       if (!enc110)
>                 return NULL;
>
>         link_regs_id =3D
> @@ -644,7 +644,8 @@ static struct link_encoder *dce112_link_encoder_creat=
e(
>                                       &link_enc_feature,
>                                       &link_enc_regs[link_regs_id],
>                                       &link_enc_aux_regs[enc_init_data->c=
hannel - 1],
> -                                     &link_enc_hpd_regs[enc_init_data->h=
pd_source]);
> +                                     enc_init_data->hpd_source >=3D ARRA=
Y_SIZE(link_enc_hpd_regs) ?
> +                                     NULL : &link_enc_hpd_regs[enc_init_=
data->hpd_source]);
>         return &enc110->base;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> index 92890784caa6e..8b568be20a77b 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> @@ -717,7 +717,7 @@ static struct link_encoder *dce120_link_encoder_creat=
e(
>                 kzalloc(sizeof(struct dce110_link_encoder), GFP_KERNEL);
>         int link_regs_id;
>
> -       if (!enc110 || enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc=
_hpd_regs))
> +       if (!enc110)
>                 return NULL;
>
>         link_regs_id =3D
> @@ -728,7 +728,8 @@ static struct link_encoder *dce120_link_encoder_creat=
e(
>                                       &link_enc_feature,
>                                       &link_enc_regs[link_regs_id],
>                                       &link_enc_aux_regs[enc_init_data->c=
hannel - 1],
> -                                     &link_enc_hpd_regs[enc_init_data->h=
pd_source]);
> +                                     enc_init_data->hpd_source >=3D ARRA=
Y_SIZE(link_enc_hpd_regs) ?
> +                                     NULL : &link_enc_hpd_regs[enc_init_=
data->hpd_source]);
>
>         return &enc110->base;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index d41d24b76c11f..2f5ee9d8536af 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -747,18 +747,16 @@ static struct link_encoder *dce60_link_encoder_crea=
te(
>                 return &enc110->base;
>         }
>
> -       if (enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc_hpd_regs))
> -               return NULL;
> -
>         link_regs_id =3D
>                 map_transmitter_id_to_phy_instance(enc_init_data->transmi=
tter);
>
>         dce60_link_encoder_construct(enc110,
> -                                     enc_init_data,
> -                                     &link_enc_feature,
> -                                     &link_enc_regs[link_regs_id],
> -                                     &link_enc_aux_regs[enc_init_data->c=
hannel - 1],
> -                                     &link_enc_hpd_regs[enc_init_data->h=
pd_source]);
> +                                    enc_init_data,
> +                                    &link_enc_feature,
> +                                    &link_enc_regs[link_regs_id],
> +                                    &link_enc_aux_regs[enc_init_data->ch=
annel - 1],
> +                                    enc_init_data->hpd_source >=3D ARRAY=
_SIZE(link_enc_hpd_regs) ?
> +                                    NULL : &link_enc_hpd_regs[enc_init_d=
ata->hpd_source]);
>         return &enc110->base;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> index a68e799d58854..406705fac7d64 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> @@ -753,9 +753,6 @@ static struct link_encoder *dce80_link_encoder_create=
(
>                 return &enc110->base;
>         }
>
> -       if (enc_init_data->hpd_source >=3D ARRAY_SIZE(link_enc_hpd_regs))
> -               return NULL;
> -
>         link_regs_id =3D
>                 map_transmitter_id_to_phy_instance(enc_init_data->transmi=
tter);
>
> @@ -764,7 +761,8 @@ static struct link_encoder *dce80_link_encoder_create=
(
>                                       &link_enc_feature,
>                                       &link_enc_regs[link_regs_id],
>                                       &link_enc_aux_regs[enc_init_data->c=
hannel - 1],
> -                                     &link_enc_hpd_regs[enc_init_data->h=
pd_source]);
> +                                     enc_init_data->hpd_source >=3D ARRA=
Y_SIZE(link_enc_hpd_regs) ?
> +                                     NULL : &link_enc_hpd_regs[enc_init_=
data->hpd_source]);
>         return &enc110->base;
>  }
>
> --
> 2.53.0
>
