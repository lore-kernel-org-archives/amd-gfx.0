Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67174C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD9C10E31E;
	Wed,  3 Jan 2024 14:39:38 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12AB410E36C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:39:36 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6dbb8698312so3845381a34.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292776; x=1704897576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFOcwGcc4VrqpomCF+R8kTd6+GvKNqBno1US2CyOSMM=;
 b=DOqmSZ1izVXBLRqDti1Wr1PcMAoA2lB1SpYGEmvoEJUUfLQAkbqfERn1pSENHaHfxx
 TjM5qdeiwgad0gzdnm+uT8h+OEUShK0sFGDwyjgRSaCeUAqqRkBWA/7zfaJizSvEBQb1
 Nu1DSS4G1ShTtQTPIwJzGzTThfRZkpjE/Jeyt1F1GoG8jgy6gL87lTVLx0Hn2QQJzKRU
 4pMZfZ5pAvwfN2ajW7Akn+FaECSX4HiG6BoIWapgBjOHZ4ni6/i3uHlrMz7bWDEP8THF
 e5qnwHYtgszOhGyQEM45Tt2XdUcPBdg31B6qa5yBJyerdKMOwG8YXQeDMltGgwKvXcN5
 z0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292776; x=1704897576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFOcwGcc4VrqpomCF+R8kTd6+GvKNqBno1US2CyOSMM=;
 b=Gq3ujjUod97oVHdk2QHdjL/0fxuA+zt3t4CHRs3uG9r1y4P1ZLUuMQwsDClDOCJQtF
 HOC6l9bYr36hCOHYEGiW1RybyU5SrZNHqtQ8/CU0ZxOW+uEowPJwTBKYqnmktkUk/6XO
 ReM+z2hJ064bL4/sgTfwEljhrvvGksfqAL+zO+FY6tiYD73zDMBvvfAcdhq+gNKKHwrd
 6QhztaB2uyTtm0AkNW0JWcsSUDpBSIMEyxQF4YHTDhl7E7n282tkvIcjfKaHuoMF3YlT
 ujQcOSlPoVYevRrkI6HGYBWBaLyW28g/B3eqfKAX/VsfkMgIiImWGy8J/vlGilK7F7ND
 6/ZQ==
X-Gm-Message-State: AOJu0YwQjVoiYTL4efkMZOFg2IKpQt4/t427xQZjJ9O14VyxiXGuqaON
 jib2r5zfCc4O0nyX0znb4O3eh3EgaYiiJCmdWQqHuEqh
X-Google-Smtp-Source: AGHT+IFe+usCJzxmODaFUatRfGCjGbc+6SdOVQw4R/18zbf1vheE5zfisdb6B5687RGnDhcjZjSZCbggGRPEk5dBdbA=
X-Received: by 2002:a05:6870:d627:b0:204:40c1:6925 with SMTP id
 a39-20020a056870d62700b0020440c16925mr8703575oaq.5.1704292776264; Wed, 03 Jan
 2024 06:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
 <20231229174156.1800-7-marcelomspessoto@gmail.com>
In-Reply-To: <20231229174156.1800-7-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:39:25 -0500
Message-ID: <CADnq5_Ny4eVMCkn9WdATOZKuSUB3w5=rypNHfWPKQL+zopU0ng@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/amd/display: Fix hdcp_log.h codestyle
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied and added the missing semicolon.  Thanks!

Alex

On Fri, Dec 29, 2023 at 1:20=E2=80=AFPM Marcelo Mendes Spessoto Junior
<marcelomspessoto@gmail.com> wrote:
>
> Place HDCP_EVENT_TRACE(hdcp, event) macro content inside do while loop
> to avoid if-else issues in hdcp_log.h file
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h b/driver=
s/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
> index c62df3bcc..55a2c5d4c 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.h
> @@ -86,10 +86,12 @@
>  #define HDCP_CPIRQ_TRACE(hdcp) \
>                 HDCP_LOG_FSM(hdcp, "[Link %d] --> CPIRQ", hdcp->config.in=
dex)
>  #define HDCP_EVENT_TRACE(hdcp, event) \
> -               if (event =3D=3D MOD_HDCP_EVENT_WATCHDOG_TIMEOUT) \
> -                       HDCP_TIMEOUT_TRACE(hdcp); \
> -               else if (event =3D=3D MOD_HDCP_EVENT_CPIRQ) \
> -                       HDCP_CPIRQ_TRACE(hdcp)
> +               do { \
> +                       if (event =3D=3D MOD_HDCP_EVENT_WATCHDOG_TIMEOUT)=
 \
> +                               HDCP_TIMEOUT_TRACE(hdcp); \
> +                       else if (event =3D=3D MOD_HDCP_EVENT_CPIRQ) \
> +                               HDCP_CPIRQ_TRACE(hdcp) \
> +               } while (0)
>  /* TODO: find some way to tell if logging is off to save time */
>  #define HDCP_DDC_READ_TRACE(hdcp, msg_name, msg, msg_size) do { \
>                 mod_hdcp_dump_binary_message(msg, msg_size, hdcp->buf, \
> --
> 2.39.2
>
