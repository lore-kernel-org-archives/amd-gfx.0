Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111DBC5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 17:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3F810F143;
	Thu, 20 Aug 2026 17:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Wz3UJIGL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71C910F13F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 17:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787245967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
 b=Wz3UJIGLweVhzRZfH1+0yND8tpDt2crwogHvLBLzNR+najZBNOECxUSPElNzr85DTT+ztJ
 guPo8piH4tYPzfQ+ovZnUNkswSsHol9l09LsGDenEYrrANYhCLkkcyYnEZLwOAmFk5tXPR
 rDr4ZmcfNOpyP+WKHTX8Nttfq4YVvaY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-fctFq3rbMJaqSO46BnqSDw-1; Thu, 20 Aug 2026 13:12:43 -0400
X-MC-Unique: fctFq3rbMJaqSO46BnqSDw-1
X-Mimecast-MFC-AGG-ID: fctFq3rbMJaqSO46BnqSDw_1787245962
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so544515e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245962; x=1787850762;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EM5PkmngzWPW5YVaOcE4doFSUi3DdsSPp8p0edYyrwQ=;
 b=qNGhMX6WVNVZVZCGO6T2J7Z/n58ma846vI9/yE6Ue3G8nz3fYXyKhXMOclOOiaHORf
 JVSWpDOnyBVB00dzuuHS0f8A2RtokcrUxIDRElaeOScRT1U9iNC5fEosfZpROkrRcbXH
 fFgCPUGkXDd+Gx+kMY80KhGnhrTQRRBXJLZ/eL5KfM3vAC4j6wJmVGNyrfaZ07+RF4BD
 6ukwbMrVtkXjqqC40Bbqvi9AY+xARq5zkHj6G/JTQfodacWockJK4AiiRsuiCITW07en
 Akerr2LtJ8cpPWr7vLR/2/KGuy+pwpKDknaJiMPQO7eOQ/hrGoItUzV7gInIA4E/PyoB
 3cfg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/hpmTmx/MowK96uHZLAOgbjwGobtIAzGlM9LYN6yfIzyYbiFoQW9UxucCaB0/sFgzwpVG4TvQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNCtSYzpuRFhBVZZyAEIqgfoWSay38zNH3M6iPS07t0iX5dVTl
 WOzCBSbe0HATJyGpyy3wZvacRdaHn/CxTQcHV9urnOORgyXgj8v9MIBwpFhwU1oCpTvqxJVrjxb
 lvfsymbdi7QlYMi0eqr6jX0LelI2XbB8NQU7kj+3TTsCDYS7H7gGXj7vEdCnAhLhMSFI=
X-Gm-Gg: AR+sD101xli0bYDrR7dQIfICtq2TpNptrnJHDPou8SXvihX6O+FFL/f1T2/bgCojIL9
 u0YRzYBR0FJlKkgStIt/c70W7qvvCugJ18qbH5nIq6C1s9qlCKfke6SB13Os5/IApSbT9P4H43b
 ZUTD13O7pOPRj+5qEdvzod3Tnc2ZYMDcrIrUJAVoHzyI3qW4rpO5GN26CdPGf/WSUafoRCkVkMV
 3dv1mWTAfhgFmlTeZcuf0f/9nXyRONaftoxh8eaY2N5m8KPeBcEGltv+KYUf7/GQW+Er7FHk3zd
 u9SU7wM4BRD5IZZV69N+vQ7c5CkO/kgsqU2yUdg9lAbgXnCBYvPckk5FACLegTXHIqZUf46j1Qg
 CBa8stiOvYM2beo0jbhvgVFxYx9pbVZxCV5eoghSRDWoZWA==
X-Received: by 2002:a05:600c:8819:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-499b8301c54mr7853265e9.14.1787245961740; 
 Thu, 20 Aug 2026 10:12:41 -0700 (PDT)
X-Received: by 2002:a05:600c:8819:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-499b8301c54mr7852145e9.14.1787245961316; 
 Thu, 20 Aug 2026 10:12:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb?
 ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17fc80sm168153685e9.14.2026.08.20.10.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 10:12:40 -0700 (PDT)
Message-ID: <b332e4f1-30a8-40b1-bdd5-f0c3f816c229@redhat.com>
Date: Thu, 20 Aug 2026 19:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] drm/panic: Retry in dispatch function if panic
 output fails
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-8-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-8-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GTptawl-3ABlnLguqnBGIsFTc4Ao4VQj8GE1EZnHJAs_1787245962
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 18/08/2026 14:28, Thomas Zimmermann wrote:
> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
> 
> Also pass module parameter drm_panic_type as a parameter to
> drm_panic_dispatch(). This simpifies the implementation. It will later
> allow for moving the function into a helper library.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 12c39217cbcb..0960750bfce2 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -746,9 +746,9 @@ static int drm_panic_get_qr_code(u8 **qr_image, unsigned int qr_version)
>   /*
>    * Draw the panic message at the center of the screen, with a QR Code
>    */
> -static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				      u32 fg_color, u32 bg_color,
> -				      unsigned int qr_version)
> +static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> +				     u32 fg_color, u32 bg_color,
> +				     unsigned int qr_version)
>   {
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
> @@ -816,15 +816,6 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
>   	drm_panic_blit(sb, &r_qr, qr_image, qr_pitch, scale, fg_color);
>   	return 0;
>   }
> -
> -static int draw_panic_screen_qr_code(struct drm_scanout_buffer *sb,
> -				     u32 fg_color, u32 bg_color,
> -				     unsigned int qr_version)
> -{
> -	if (_draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version))
> -		draw_panic_screen_user(sb, fg_color, bg_color);
> -	return 0;
> -}
>   #else
>   static void drm_panic_qr_init(void) {};
>   static void drm_panic_qr_exit(void) {};
> @@ -899,13 +890,22 @@ static int draw_panic_dispatch(struct drm_scanout_buffer *sb, enum drm_panic_typ
>   {
>   	int ret;
>   
> +retry:
>   	switch (panic_type) {
>   	case DRM_PANIC_TYPE_KMSG:
>   		ret = draw_panic_screen_kmsg(sb, fg_color, bg_color);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>   	case DRM_PANIC_TYPE_QR:
>   		ret = draw_panic_screen_qr_code(sb, fg_color, bg_color, qr_version);
> +		if (ret) {
> +			panic_type = DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}
>   		break;
>   #endif
>   	case DRM_PANIC_TYPE_USER:

