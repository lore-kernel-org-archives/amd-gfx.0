Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA55C5DF86
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 17:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1DE10F11F;
	Thu, 20 Aug 2026 17:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EdygiMYi";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C7D10F12C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787245506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
 b=EdygiMYilnj6D5hZKnPUW714eGnTFO3yG5CuLlMBX8A39srrEBOFMpFoW849G8GCOBGq57
 YxPVVvOKbLQgtVbjaJBCPiEVTvrdHE8P7hSYHMfFcJPeHv4mv8Skrb/Iq2DSsibWOGhD+g
 JRFAWW3ZBlzY35b5bNZ90PfSEQKM5Xo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-jnW8dBJrM2WjpuRO2-ouEQ-1; Thu, 20 Aug 2026 13:05:00 -0400
X-MC-Unique: jnW8dBJrM2WjpuRO2-ouEQ-1
X-Mimecast-MFC-AGG-ID: jnW8dBJrM2WjpuRO2-ouEQ_1787245499
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-496b6f97676so349025e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245499; x=1787850299;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TF+roY3oCVB3u96D2m+Kn+7JYFil1XkjxfPcXPVAxaA=;
 b=bF0iTLWjRo4GNBN9HWTJb5d9nN322ZlnSwwelSfFHgYjeWXaz3olatHhQFUZA7B6mL
 ClOCrWXQFwOMiti6Rf+xek7oNECRbIpiyTDC/f9PJDo3A64uqevcxM9JxabDBX504mx0
 Z0TR/Augx8cMarAW32QINq/hEoLfnUfyw8Wf1A2pTYLuD02TBopHYSUV/b22gpC2FyAM
 aZxHiqvrHNVUGQHvNkukMnWw8eQN/MFi0qj+Hnd8DcGT2tRsYshu9rd0q+Mw+X5ojYNj
 nsxu/sxAn5C4vKAYcrArjNyc5UnpTLgkYZWFoqXvso5ttlT1PvpxDU3W2RRZ0K4SRpAi
 1jZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqRjWMjgF7pgHeja+xPy3zZ5skNd1b0sN068ll0RWYoUf/ID1t3vnztFa76/06jpeZ8cvam9Fy@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzaj/rxiL6HTbJxlhGPgZ1fNt3Jb7lA48NjYmw6/ggOJNooDSxb
 UzPQwdlIRq/e3xCu58dK79sfj3Gz/ETu7UhpUsig7M0sOLJ3PSwXfV3rDOeZtN/R+tNsm9zN0aL
 U3KDiiT66LXLcTHK6DbGC0SzSOkAOVO9DfHEYkQmC4jQaaJLH+IQnLRr1+CjJdpjYJog=
X-Gm-Gg: AR+sD10uB4QcNeAd1OofklqgNyPb2boKFi6fDo/VoRNkeYdfUflHJCOgByA2AKpKLrZ
 F9mrF/d2MWLvR3dpKyEonZuf2dB1Py+uu20yWMwisAaa2FYAmecOnZs2jXWd4U1DBaD2aGF+0Fg
 ZJqJUMjdIhS3gRqaeEQNkJuMKuvFvG+5o1lSD4FdcVaNpKpxWxX1UqqJ+jO5zQKg7poGRtD8127
 V8rHvR4CO2jXmbJkoM+6SWk7jutXAqw/9Twc3B7sKZxt9I7QSR7CXDDWqOLwjT6clzfkUa3l62g
 0fedxHyMXfpc4WvzvqFK3lrrIbB6dj2qXqGk/K1j1y+yOw6Z2gRx4IkKVrYXNp0cqEoWUKPGZE9
 e9bwyyXKWeXgCLnYy3F6/8lAKo6jlFeVYHt9hua09Q5sjrg==
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr5017085e9.10.1787245499105; 
 Thu, 20 Aug 2026 10:04:59 -0700 (PDT)
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr5015695e9.10.1787245498659; 
 Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:935:4f8e:b423:64eb?
 ([2a01:e0a:11aa:87f0:935:4f8e:b423:64eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13157002f8f.27.2026.08.20.10.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 10:04:58 -0700 (PDT)
Message-ID: <cb784cf6-f3d8-41aa-9f71-c197a5eba7f2@redhat.com>
Date: Thu, 20 Aug 2026 19:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] drm/panic: Return -EINVAL if font is not available
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
 <20260818125012.468092-4-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260818125012.468092-4-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rKXH-8FqRQs8mDiDEVALQQ0-95gC6Wi9ASo_4uzJVHY_1787245499
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
> Font lookup does not allocate memory. Hence reporting ENOMEM on
> failed lookups is misleading. Report EINVAL instead.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 705b72bf0d83..96d238bfceee 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -757,8 +757,10 @@ static int _draw_panic_screen_qr_code(struct drm_scanout_buffer *sb)
>   	int qr_width, qr_canvas_width, qr_pitch, v_margin;
>   	u8 *qr_image;
>   
> -	if (!font || !stream.workspace)
> +	if (!stream.workspace)
>   		return -ENOMEM;
> +	if (!font)
> +		return -EINVAL;
>   
>   	r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   

