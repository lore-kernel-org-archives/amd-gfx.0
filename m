Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E4EC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 15:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C1C10E241;
	Mon,  5 Dec 2022 15:41:36 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CD610E248
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 15:41:31 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-144bd860fdbso734099fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Dec 2022 07:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1xpU1MzFqk0ORUp/TJBm0xqhGVwvaY9vu6yXO3W0Kfw=;
 b=EbqX+5acoW1A+iXyxNTYlayKmhr+JZ9ypIwBwx1T9NMuiqWNM7v5/4Iu+OosuI9fRY
 81Dl6e4ORLwSblwPC5NyBiqixdJgJeUGu2fNjdV6B+AsZN+wGFJGmdCkIFa3IDrVxLem
 n2Xt5o45l2Vv6zqzndKmkVrnUvW8fdeskijkBGIym/eILyqyxrOwO4d3V302PxRvmN/1
 OXjxvijFIKK4HBJlL1kG/Wk0Ack4a2iVos0CQ7V3KheO6ntQYop9fW2WqTc5obCvzn1j
 Xud2ZDq81sYj702OqZEPQOEfUvrasIYjE0oaeKjauGOHYyyLPqt+N4GpmTnY2H1QnFla
 WjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1xpU1MzFqk0ORUp/TJBm0xqhGVwvaY9vu6yXO3W0Kfw=;
 b=D2paB6TcL/II/EAIXq9Wm+bldgPWzTH9GO6BOuARHXg/VkcKV0j0r+9Rwtb+lm8EKY
 SgW6yoOLtpvW7LtbJS/4CTUPFvJSF4mWLRdPfczquHLS2ta4aKLk6tpIznHHxMiPvhqL
 o+NmDkc0lZPHvVJsW7XuOrRguyLXAjvhFpFAF21NS7BtEtBMfSx407gicUPLCgDdQ2Be
 bmr8sfaHYgxEJJOXWPMq+WWFy0j7I1enqsfESDbDKJ/4SNQcM/VCW5pZX/JBbiMEDGEA
 p05PGJWs1LIKZegfcewU2+LQwj4eiIA3GJFB0dMPD+TpfegxymwnkQtzN2jlxbHSAs+F
 hLPg==
X-Gm-Message-State: ANoB5pn47iA+D6As/mEo0uB/+KRH95iMpC/oXLTqaiRyY3hG46o+Z4GN
 Zl9DRwET8W3Lmh8vmODqOhlaIgyxTdUFb6OJpkdOc/Ns
X-Google-Smtp-Source: AA0mqf7KLLnbV5xRO0Tz8TkShAkA8478I3kRcMFxp8koDQjtKjfHSl2UkVxhZsP2WeIpH+/1Mw+x9OKDclL2MKR5Y9s=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr37109448oab.46.1670254891032; Mon, 05
 Dec 2022 07:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20221205094126.2190885-1-tim.huang@amd.com>
 <20221205094126.2190885-4-tim.huang@amd.com>
In-Reply-To: <20221205094126.2190885-4-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Dec 2022 10:41:19 -0500
Message-ID: <CADnq5_NHDPPnyYQqOQuFXbgzxsxb13-g4V0F2yLHHBdjRL_2Lg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: add tmz support for GC IP v11.0.4
To: Tim Huang <tim.huang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 li.ma@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Dec 5, 2022 at 4:43 AM Tim Huang <tim.huang@amd.com> wrote:
>
> Add tmz support for GC 11.0.4.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index e970e3760cec..02a4c93673ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -549,6 +549,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         /* YELLOW_CARP*/
>         case IP_VERSION(10, 3, 3):
>         case IP_VERSION(11, 0, 1):
> +       case IP_VERSION(11, 0, 4):
>                 /* Don't enable it by default yet.
>                  */
>                 if (amdgpu_tmz < 1) {
> --
> 2.25.1
>
