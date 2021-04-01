Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F6C43462
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 21:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7959F610FB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 21:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7959F610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376B86ED8E;
	Thu,  1 Apr 2021 21:16:54 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7501F6ED8E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 21:16:52 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 m21-20020a9d7ad50000b02901b83efc84a0so3320701otn.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Apr 2021 14:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2O60zOZvvS2MHki6d+UjisoeYpmgLmNDQbLDmrpf1E8=;
 b=SJ2spWx9bx4z6qxeZVrIJun5SWt0JKM2PZkG971Qo58fTHX6ePXJB4UAZIFid29xpQ
 nK81K17l5/ZGlLWGVXE+5xPSGgvi85LrnPFILuAB2xNAU6uCeYhJ9ntLQSmIq7709ygn
 NCbcdjxL3G//vKXMK0ok+2I9R458hMwk99vN2zjRc/5NgRTwOcf8wYJsxLWcPHy1oZc0
 2INEtuixJELIWT4L0JbKqK1WNuGxhE+ocwuz4nVbH8q1hfSRm0+u0IUOmmGkNaG70EXi
 1in4+dqwYnFBT5aze5c+Z+ztYhe4XLrehJVaSTmS3Fmdv+9fewY2k1Tkgq0V5pD2Pkg+
 njNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2O60zOZvvS2MHki6d+UjisoeYpmgLmNDQbLDmrpf1E8=;
 b=E3/Uy3TlUVIzW1ontvtJzYaAjhd8uibXVIX5ML6Et7TcyQJ7VQiPqa5rQzdSY//BZG
 IJmIBPFLwnfB5e1hb6hTKAzuHk51PQlIjo7VtXwc2DqQIAyMxP40AD65ehZSTNGGTgIh
 X7x3JLOncDglvvZSw2MUMnq5gVv7UAh4hgJFTdfdf4qwfvYKu9pL7kVWbNYdhe2rIpRv
 36BRbvfz+lchXMjYh51mdnzBF9KvvxQ+okLlPEczWrYXN+EztnaTTuukaq6v3WroW9Xy
 7rdY/5+7lnGKYZaTizBn589h30ZdFcxphIgLbRyyh1VhiZ07gg6oXZjLszD07SlidBfl
 nM4g==
X-Gm-Message-State: AOAM533XLnIBufrJ7VFC28/g9tpLHPBwjJTRKpMcy5iQS4k03HNnQ2U4
 sqdCLm/nSLPQmY8bjm3vAVqueCZgL8yI1S+Rq7ERMBenjG8=
X-Google-Smtp-Source: ABdhPJweYYuRhQGRqAcB5V5lsCZP/rQgPG1bLNKncEmybiBww5Pc4d5lAMisCowhf41rHSORUAWnTasCUjF/46Rcj9M=
X-Received: by 2002:a9d:7288:: with SMTP id t8mr8976862otj.132.1617311811895; 
 Thu, 01 Apr 2021 14:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210401102737.1007254-1-wanjiabing@vivo.com>
In-Reply-To: <20210401102737.1007254-1-wanjiabing@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Apr 2021 17:16:41 -0400
Message-ID: <CADnq5_Pp_ODRKPFUcr-BXPx44NQb04nm_k728vhPek8JVqgC2w@mail.gmail.com>
Subject: Re: [PATCH] amd: display: modules: Remove repeated struct declaration
To: Wan Jiabing <wanjiabing@vivo.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, kael_w@yeah.net, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Apr 1, 2021 at 11:26 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> struct mod_hdcp is declared twice. One is declared at 33rd line.
> The blew one is not needed. Remove the duplicate.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> index d223ed3be5d3..03fe49c5b7d0 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> @@ -255,8 +255,6 @@ struct mod_hdcp_config {
>         uint8_t index;
>  };
>
> -struct mod_hdcp;
> -
>  /* dm allocates memory of mod_hdcp per dc_link on dm init based on memory size*/
>  size_t mod_hdcp_get_memory_size(void);
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
