Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0915CD609B4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 15:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5917910E97E;
	Tue, 16 Dec 2025 15:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5Iw8MRF";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BAB10E809
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 15:38:22 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-bda175a2013so331955a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 07:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765899502; cv=none;
 d=google.com; s=arc-20240605;
 b=gzXd3jwLfPZkjjR8CbcvFltkeQVLPKZi/tCNowt4zxeTP3yWUmBFYLrBC6Kiuwszx2
 hb31DjSRjmFSI00qGT5TGWWOsdDYhfl+QGnIDMI7kR7jq/90YQnFS7t9jXhVSW6IKRVF
 2WcFmXgxZYfy1c+0rVa59BgMVaxiuWdBIbifPU34ZKCRwdIUWd9qaWGkLSTighqQnzOW
 VR8JZjzbCFBq15sGv51dREIYG/SIdNbdQFrxNiwbGr/maHkiT0AAweSFpfCyaTv0lCpj
 nzMstMmrSQFHQn0bBEI7YZ589qjh/mPlp/ttEZD7uFzSY+QUW8sjoun+7KebIkvfR01w
 XcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rm7OrcTnLs71zOQFz0RJNAZTC78yB8x0knojFOZrTuc=;
 fh=vaoVWDlanqiCGBEU+fnwr7/QiChIFVakkxHRSZSAwZo=;
 b=SJGC7IgDCiwkcwAKt+3pIKH/Ew6Vd+Xb71VmOj/g2xfGmYTu/uD3iyNM6tdwW156Tq
 3bssT0Jqctkz867nq/RgmYgg+kUJptIrefzDw5AJ5YLAixxLPPeh28uP8lgFO+Jj1V3D
 J64oJKDj/kditsZbDyhG5+KrzbU458X76i9CmcXy3jJOwb4d1bZuSST/PW2AnAPh/w9y
 T7O4nNTpf2cqaje5Zi17n93VFkMC3QSAwdssJ5mVKPWT6fy9ocmoxH7ze+gqAfoYBEe5
 s7IAblOQ0SJYrtnFE5OjumWHBHHYBVuk3V93SNya2jSwdlspwA4Mgl4d15EEYhAzqze6
 I4xg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765899502; x=1766504302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm7OrcTnLs71zOQFz0RJNAZTC78yB8x0knojFOZrTuc=;
 b=D5Iw8MRF9bLGp8lhnM9V9Qp+jFiCuK6Ikp+LZBJF/1+rk6U9b79XRNKPTHkPl2n7aO
 Oz96xRHuOapQoj3SUSiGQWlBtbwhoXiYXgZaCTQlJqNhKiWpksfSKWR9siiSQgLXOdyU
 WM++WQVqJx6Zr0ZgWTVQXYE1KXAhPFtXxlPWLYUlIRGnIzhgT2FgTU5Yz953QF+ILjoE
 2Vbjf9r+OCKv975u/PWDO1fMymFzjR4S5h7L3uctuZ6kF4n35WUb5H8vJSdFW+9+DXzl
 5KtjPFhF3gnWjcCAia4kdjrVYZ/b12lh8+WsdwddqzjMhswwB0xYNOSzfjidEv3aeU3F
 9ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765899502; x=1766504302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rm7OrcTnLs71zOQFz0RJNAZTC78yB8x0knojFOZrTuc=;
 b=JH0QoNFwXIjJJsbmSnG86ga8xuBzwT85n9JhGRr3jv5CXRgX+h20OSsX+ODehFy0E2
 POvHcDWlq5OFtU/cxrEZmT8WRww3rQMUfA6kVkUIZywSZCQxVP9b2kZzXQU0CvxqwTyk
 Vs471887ZzKUUnt6uZJzYg7R5yXpzkhaS1PhvI75Dvj7FvXj7aT0FSxgteGo06YDWXz2
 rcXS41G3LWAWxRX/GrOpmKPO5eFJc4TF6j7Blb+Qmnl3GgRDeQYwABlaEIpWrQ9bMQxq
 0zos+0hysdf+TiEbDz23JsGPNgpNB4eDxYnfgd88f48S8KlCcLSLYNxOFZiTVma+VhMr
 5Xjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDkmwKMs3bFVOWE376l7bX+NUkdhSkT1G9oQsY6A8B2906nT1ZfXxU/dIJreBQ/Cqai6NhTNdx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJdQoFzcqemddOYgVrfCTARgMrzGPgd3TJ2qBJrEFXb/l8BVdT
 ZwYn/lWjHXEHSl4H2fYFCYK6cIATbMzrvUDipvjpO3E3IC4pUfyID4lkUOnugBATT6JemjATu31
 /7A867cBrsAs8YdrJxXHcqbTGUO6LekM=
X-Gm-Gg: AY/fxX5MUnPcYEpxsdzPk7zg08a1DjMnqfElCU82YM+IhwTHbYBuonlN3W6Ygx5m43K
 ueKaZSDQjaMxmWO4KKBbbwMTIxe/5zFsjDAuSQ4RtT0aPwCtQjnr5hT6Q6ozMk02GEZ1dRZaXBw
 8S8xzP6nEsDKhy5B+pRsOptMoBTR1JvWMA/R945ldeh+Yj5+ZyvzexSA47PKWoKE+Cld/3cUMBq
 wLDIFOoCI4LrIxrHhZr5WzMqMIGlWsJSBpaWlbgITM5OB/APxZtGpvxSXPjXIkvCJ7phOSY
X-Google-Smtp-Source: AGHT+IFw562O38mZEGeClFXH2zMvDFvApIAlMxnUt/aJdHfSLFrdgXroskIRI3NdFPMbEMWMy2zIEu3Qz4UcLkQzaEQ=
X-Received: by 2002:a05:701b:2513:b0:11a:43fb:58dd with SMTP id
 a92af1059eb24-11f34c3a335mr4489341c88.5.1765899501988; Tue, 16 Dec 2025
 07:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20251211085923.737742-1-karanja99erick@gmail.com>
In-Reply-To: <20251211085923.737742-1-karanja99erick@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:38:10 -0500
X-Gm-Features: AQt7F2pYMcVO6GY7EKKTm18qf4WJNZ6vpQXfBa2A3A3LiP85et9YQoK2Kt1sz8c
Message-ID: <CADnq5_OryE-DU9tfJAD-cZtUtWtKAHQ_0YZ1tdSencR1c8MXkw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon : Use devm_i2c_add_adapter instead of
 i2c_add_adapter
To: Erick Karanja <karanja99erick@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Thu, Dec 11, 2025 at 3:59=E2=80=AFAM Erick Karanja <karanja99erick@gmail=
.com> wrote:
>
> Replace i2c_add_adapter() with devm_i2c_add_adapter() and remove all
> associated cleanup, as devm_i2c_add_adapter() handles adapter teardown
> automatically.
>
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_i2c.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon=
/radeon_i2c.c
> index 1f16619ed06e..f3ba4187092c 100644
> --- a/drivers/gpu/drm/radeon/radeon_i2c.c
> +++ b/drivers/gpu/drm/radeon/radeon_i2c.c
> @@ -931,7 +931,7 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_=
device *dev,
>                 snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
>                          "Radeon i2c hw bus %s", name);
>                 i2c->adapter.algo =3D &radeon_i2c_algo;
> -               ret =3D i2c_add_adapter(&i2c->adapter);
> +               ret =3D devm_i2c_add_adapter(dev->dev, &i2c->adapter);
>                 if (ret)
>                         goto out_free;
>         } else if (rec->hw_capable &&
> @@ -972,15 +972,6 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm=
_device *dev,
>
>  }
>
> -void radeon_i2c_destroy(struct radeon_i2c_chan *i2c)
> -{
> -       if (!i2c)
> -               return;
> -       WARN_ON(i2c->has_aux);
> -       i2c_del_adapter(&i2c->adapter);
> -       kfree(i2c);
> -}
> -
>  /* Add the default buses */
>  void radeon_i2c_init(struct radeon_device *rdev)
>  {
> @@ -999,10 +990,8 @@ void radeon_i2c_fini(struct radeon_device *rdev)
>         int i;
>
>         for (i =3D 0; i < RADEON_MAX_I2C_BUS; i++) {
> -               if (rdev->i2c_bus[i]) {
> -                       radeon_i2c_destroy(rdev->i2c_bus[i]);
> +               if (rdev->i2c_bus[i])
>                         rdev->i2c_bus[i] =3D NULL;
> -               }
>         }
>  }
>
> --
> 2.43.0
>
