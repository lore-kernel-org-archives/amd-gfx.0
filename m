Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533EBE7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 21:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C9110E630;
	Mon, 16 Dec 2024 21:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iYsURYwW";
	dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF5710E630
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 21:48:58 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21644db9f3cso7130815ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734385737; x=1734990537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up2rgUPVDo82iPua0wshVVTsn6QgLOKcj89yGGoGH6k=;
 b=iYsURYwWlVfO9MyjTZveUpgmC5vmL5juBvhJbT14hnsrwmGVWNwCLCP5LmRMVNiwhk
 aEklIXOJSNdvinMqlUkBUXjH/CH0FU96EZZ9J+Z7d+Gj0ve98SuCMM7U5f0n9IQfCYPD
 Xo6K56HXQP3t07g4wfoLZnnMz/1/DyjYsvtugocgy2YXNwXNNY2sIydhoGkr+69Mu7qu
 W0pD6B8OuZ3E+b79wtRUHFfLOVmo6KX1es20VYWSmcSJ4M4QIph92A/VDJcol/R5LjMW
 s3QjGJ9Br099jHv0NqXOolG+Sog44Vxx3jAUtg+7LLGPEuNe5TdS8oExQpJNxHA7rWD/
 sx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734385737; x=1734990537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=up2rgUPVDo82iPua0wshVVTsn6QgLOKcj89yGGoGH6k=;
 b=i3yFfF+3aBK66y/YZzMBW5T2GXdlys2bl8JYEv2BOW7qkTLw0aZx6RrNG5dQKOBTnO
 RxIBpqMytZHNxQltWuN8kny569MdFbTYkgmJ+icR7jq57aZOhUkzo2ejsCzB4Di2zg5G
 rNwVmGxT4KXYVZJ31XdMOkz0wGTVnqn83XH4EAjEJcDBCuyHaD3ZSu8zWgvIsxug1vRh
 ixBnv5TG55iGpZejQdhcUxl29gkw9DyVgZK123v3i57YpupoxdI38VSF8dqU5gACEZUE
 5NugjiP1q+vdhe0Q2Bj5Ptr8kxeIDkBuh77Or757VX/nMbDDive1oHNwOuoWEzYZtLOr
 le/Q==
X-Gm-Message-State: AOJu0YzeZS5T4l6KGacNmeZ3aqETVCKAkZY6Z0Iaz9y5mXUKlwnRn4ts
 Qiv4G4dLqqQknoesGCbth//YqlKTszPi9O2fSRm7z00Sh0xkmPBlznIaobevi1uzjq8zpIyOSqh
 Gw5WP0nZmDaFg+uvSKTYbFQPn+Mk=
X-Gm-Gg: ASbGncsqNAwGnrwS3YRPj/9VgXJvR1pMwMdumbP/U3+D35YEIYZbT3FZffGLgxx3mHc
 VZg9+XXan60kPVclD+rnsDuGt4zRhWuzEcEZ0vA==
X-Google-Smtp-Source: AGHT+IGgPoLmuFBcab3zF9eD/q5AO1OiR/+lYqb9BXQu0HjtvFt1GwlnFoSZJPINqYDVF994CZL5nYNUpeT/AejkLZU=
X-Received: by 2002:a17:90b:1c8a:b0:2ea:bb3a:8f09 with SMTP id
 98e67ed59e1d1-2f28f860e10mr8014442a91.0.1734385737580; Mon, 16 Dec 2024
 13:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20241216213019.3926329-1-Elena.Sakhnovitch@amd.com>
In-Reply-To: <20241216213019.3926329-1-Elena.Sakhnovitch@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2024 16:48:46 -0500
Message-ID: <CADnq5_OPDbuc2Ty_ug7P=smTn7VsbBcw48McfwB6cVFy7te9uQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: decrease CP queue sleep time
To: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Elena Sakhnovitch <Elena.Sakhovitch@amd.com>
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

On Mon, Dec 16, 2024 at 4:43=E2=80=AFPM Elena Sakhnovitch
<Elena.Sakhnovitch@amd.com> wrote:
>
> From: Elena Sakhnovitch <Elena.Sakhovitch@amd.com>
>
> CP_IQ_WAIT_TIME2.QUE_SLEEP hardware default is 0x40, i.e.
>  64, so we put the queue to sleep for 64,000 clock cycles.
> This is too long, and setting it to 0x1 shoul be enough to
> load date out of memory during queue connect.
> Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
> ---
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h | 2 +-
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h | 2 +-
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h    | 2 +-

These headers correspond to the hw powerup defaults.  If you change
them, that changes the semantic meaning of these headers.  If you want
to change the settings, it would be better to change the driver code
that programs these registers.

Alex

>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h =
b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h
> index 320e1ee5df1a..da6762309c3c 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_default.h
> @@ -2479,7 +2479,7 @@
>  #define mmCP_CONTEXT_CNTL_DEFAULT                                       =
         0x00750075
>  #define mmCP_MAX_CONTEXT_DEFAULT                                        =
         0x00000007
>  #define mmCP_IQ_WAIT_TIME1_DEFAULT                                      =
         0x40404040
> -#define mmCP_IQ_WAIT_TIME2_DEFAULT                                      =
         0x40404040
> +#define mmCP_IQ_WAIT_TIME2_DEFAULT                                      =
         0x10404040
>  #define mmCP_RB0_BASE_HI_DEFAULT                                        =
         0x00000000
>  #define mmCP_RB1_BASE_HI_DEFAULT                                        =
         0x00000000
>  #define mmCP_VMID_RESET_DEFAULT                                         =
         0x00000000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h =
b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
> index 21d2f7d1debc..07b112b11a3f 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_default.h
> @@ -2320,7 +2320,7 @@
>  #define mmCP_CONTEXT_CNTL_DEFAULT                                       =
         0x00750075
>  #define mmCP_MAX_CONTEXT_DEFAULT                                        =
         0x00000007
>  #define mmCP_IQ_WAIT_TIME1_DEFAULT                                      =
         0x40404040
> -#define mmCP_IQ_WAIT_TIME2_DEFAULT                                      =
         0x40404040
> +#define mmCP_IQ_WAIT_TIME2_DEFAULT                                      =
         0x10404040
>  #define mmCP_RB0_BASE_HI_DEFAULT                                        =
         0x00000000
>  #define mmCP_RB1_BASE_HI_DEFAULT                                        =
         0x00000000
>  #define mmCP_VMID_RESET_DEFAULT                                         =
         0x00000000
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h b/d=
rivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h
> index 5bf84c6d0ec3..64183c888fd4 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_default.h
> @@ -1295,7 +1295,7 @@
>  #define mmCP_CONTEXT_CNTL_DEFAULT                                       =
         0x00750075
>  #define mmCP_MAX_CONTEXT_DEFAULT                                        =
         0x00000007
>  #define mmCP_IQ_WAIT_TIME1_DEFAULT                                      =
         0x40404040
> -#define mmCP_IQ_WAIT_TIME2_DEFAULT                                      =
         0x40404040
> +#define mmCP_IQ_WAIT_TIME2_DEFAULT                                      =
         0x10404040
>  #define mmCP_RB0_BASE_HI_DEFAULT                                        =
         0x00000000
>  #define mmCP_RB1_BASE_HI_DEFAULT                                        =
         0x00000000
>  #define mmCP_VMID_RESET_DEFAULT                                         =
         0x00000000
> --
> 2.34.1
>
