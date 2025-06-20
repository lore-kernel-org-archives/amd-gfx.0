Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B469C71157
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Jun 2025 14:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8F610E2BE;
	Sat, 21 Jun 2025 14:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H03gqolO";
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F8F10E057
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 14:41:45 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso1153442fac.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1750430504; x=1751035304;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KT4DQcewRXgTOMNaBYIe1ub0iebCscNnZe8/5h5B18=;
 b=H03gqolO/xCfVU4mwWYlbRKtc96lgV+cp/5Dr8OevlgX1RZGGQ7DX62pQEzXxmkkNV
 8zQZNUpjPfLswkpWYnSXBHyxm4zLZZvEqAtP3lhGxOWy4lLsFbTV3erl0seFnxRRuc1X
 Z+GWP7us5DJFapav+4D64rb4Nlbt7q9hfJ//A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750430504; x=1751035304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KT4DQcewRXgTOMNaBYIe1ub0iebCscNnZe8/5h5B18=;
 b=DC/CoP2MnCEaCHbGXVi1F3D5vHaxT13RSe+uvtJfQiQ194e9X2BO0Oe5vCQKDtDVD1
 Ah1+Mp1zFLQjonOfcM0pWr2EiLzdN1MiZlifgvRiEzQ3qtbJvwZRud1nrWaa2DtjBf7Z
 9qTkbO/Ba1/4X5saaycIWGa7vUwxToiSFbXgyDVRK9npzgDJcOqDFpHcnOjYiU6eMjcE
 R5VaYBKhpQxlafv6HPYrYrFiQKxolk2WxnZNfM5X4Ch5xbbtsufSQygi6Kjx16GxpA9O
 h9VJVPRHpcMeEaVgMfCs2QagCVBwZamrO/HS1pRVwq2AtOWhZxmb9Mtr6NaawJhS3zsD
 myFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc97P+8h9H6Nvkv1N1+H1/HA84vL5htHFIDU/Fm9dUeE0fG7kc7obT4in7QCG5FV+LO/isPL1z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymO6otcN04iC51bnx+AwI9A8zqWurHc79Sjrd0KFV+j7y3eysP
 Rg5871EnD306ZtmlFg2UTCuHscqG5XhHejuWT4myF4jNFPez+TzWFrRP4L9UN82hD6amf3lZtPP
 9QYagipYZ
X-Gm-Gg: ASbGncv7NKdfGspRnDVPup+57Dml4BHCnRH8BKNDQPNWOlZL379SW7LEER3/P/zwbtq
 55K+Kxsr7YQyG9QRm/JK/zzyBSJ3YY3JJ9PHAmNVvrGp/gwlb3yh57+m9R0Um0YLj0bpiFaZW5I
 BPYkG0e9A53IygG3Q3v9hchGnQHKJ9blUjtPkcPTqJv3JBB5lmShOd5Sb+NAa5cmy3fgMT35YnY
 zkCLk+MsmPP9y9eFyglsC6sA0rSwzQomLwHxFbJOraqHysK1GEqCcWynvApLhQ88tL/IGg07gjc
 VLgvzu3iUsgxOAnhswQFCsZUYXVgXzFhBJgjkYVq5T0uDaDX9ylnJ9rh3BTtmjG7v2Io0ihi/Ai
 iAosecW7ebBHoxQIVfJ0CCGbhC0uxHZzXYE3c
X-Google-Smtp-Source: AGHT+IEL3AvlkBP9Hv86DMsjjpvvZO0d+RtYcLgG4WofNkAkYrRr8Snk6zH9hOuvqCBaEctMObYFoQ==
X-Received: by 2002:a05:6870:6b90:b0:29e:27b6:bea5 with SMTP id
 586e51a60fabf-2eeee628a79mr2217425fac.25.1750430503764; 
 Fri, 20 Jun 2025 07:41:43 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b7c9036sm255394eaf.28.2025.06.20.07.41.41
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 07:41:43 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-735a6faec9eso1338333a34.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 07:41:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUh/z9oHrpyU649BDGagmQmXTipr47/fwQIp4h9ALfV7QB/6ANVpMmJ/DFT5J0q+rumg2N4V39N@lists.freedesktop.org
X-Received: by 2002:a05:6871:4195:b0:2e9:9e9:d94b with SMTP id
 586e51a60fabf-2ef0094c0cbmr2001638fac.39.1750430501165; Fri, 20 Jun 2025
 07:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250402174156.1246171-1-jim.cromie@gmail.com>
 <20250402174156.1246171-29-jim.cromie@gmail.com>
In-Reply-To: <20250402174156.1246171-29-jim.cromie@gmail.com>
From: Sean Paul <seanpaul@chromium.org>
Date: Fri, 20 Jun 2025 10:41:03 -0400
X-Gmail-Original-Message-ID: <CAOw6vbJwbvcVARNmx3O7mTbOr+A_Vo_DaUXFfN8HFFLqdG-VPQ@mail.gmail.com>
X-Gm-Features: Ac12FXysVBlI9m3EGLlNcwPGQBWhWDrHdfE7f5KsOCiBBCH_bJGVrs_uGmTAM7k
Message-ID: <CAOw6vbJwbvcVARNmx3O7mTbOr+A_Vo_DaUXFfN8HFFLqdG-VPQ@mail.gmail.com>
Subject: Re: [PATCH v3 28/54] dyndbg: restore classmap protection when theres
 a controlling_param
To: Jim Cromie <jim.cromie@gmail.com>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
 louis.chauvet@bootlin.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 21 Jun 2025 14:13:35 +0000
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

On Thu, Apr 3, 2025 at 9:48=E2=80=AFAM Jim Cromie <jim.cromie@gmail.com> wr=
ote:
>

\snip

>
> -static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> -                                     const struct _ddebug_class_map *map=
,
> -                                     const char *mod_name)
> +static struct _ddebug_class_param *
> +ddebug_get_classmap_kparam(const struct kernel_param *kp,
> +                          const struct _ddebug_class_map *map)
>  {
>         struct _ddebug_class_param *dcp;
>
>         if (kp->ops !=3D &param_ops_dyndbg_classes)
> -               return;
> +               return false;

Return type is struct _ddebug_class_param *, should this be NULL?

>
>         dcp =3D (struct _ddebug_class_param *)kp->arg;
>
> -       if (map =3D=3D dcp->map) {
> +       return (map =3D=3D dcp->map)
> +               ? dcp : (struct _ddebug_class_param *)NULL;
> +}
> +
> +static void ddebug_match_apply_kparam(const struct kernel_param *kp,
> +                                     struct _ddebug_class_map *map,
> +                                     const char *mod_name)
> +{
> +       struct _ddebug_class_param *dcp =3D ddebug_get_classmap_kparam(kp=
, map);
> +
> +       if (dcp) {
> +               map->controlling_param =3D dcp;
>                 v2pr_info(" kp:%s.%s =3D0x%lx", mod_name, kp->name, *dcp-=
>bits);
>                 vpr_cm_info(map, " %s mapped to: ", mod_name);
>                 ddebug_sync_classbits(kp, mod_name);
>         }
>  }
>
> -static void ddebug_apply_params(const struct _ddebug_class_map *cm, cons=
t char *mod_name)
> +static void ddebug_apply_params(struct _ddebug_class_map *cm, const char=
 *mod_name)
>  {
>         const struct kernel_param *kp;
>  #if IS_ENABLED(CONFIG_MODULES)
> @@ -1266,6 +1288,13 @@ static void ddebug_apply_params(const struct _ddeb=
ug_class_map *cm, const char *
>         }
>  }
>
> +/*
> + * called from add_module, ie early. it can find controlling kparams,
> + * which can/does? enable protection of this classmap from class-less
> + * queries, on the grounds that the user created the kparam, means to
> + * use it, and expects it to reflect reality.  We should oblige him,
> + * and protect those classmaps from classless "-p" changes.
> + */
>  static void ddebug_apply_class_maps(const struct _ddebug_info *di)
>  {
>         struct _ddebug_class_map *cm;
> --
> 2.49.0
>
