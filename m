Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCEFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 14:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9434010E811;
	Fri,  4 Nov 2022 14:29:16 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096DB10E811
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 14:29:15 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 k59-20020a9d19c1000000b0066c45cdfca5so2737051otk.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Nov 2022 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T3GHkVSAKiVYz8TMq4IG2ubsHInSbtyLmNck4BwsQ7I=;
 b=a29xZEePUJF5jdTxaLyQ10kgVenRzFUB9WTpX8KSfJxxKVe0/LghKC76Ht6wQV0kmv
 1ZXQyCzpcc3l3Ctxyo7dBpF4k9eKde19ozG6aGE0pNjLVQRuwwRDh6zFbCgCgo/c3TM4
 EnF4oJHajHcv1xuyWuylolSCo57yLD7zyD+3LLtPz5x94MdYSOIcDIPpgZHE6jYV0xn6
 r16tEgJ2etVkgNjfPQpA6EjljxSkDOdlKtyiNqyWDYSftJEX3kgAeog9fak++SBBO3CR
 8z5S3jsARkGhNvMphMANsjp4iyep8cjoxfVF2WljAIbWLQKpx8ninUM/K1NNB6NSC+t/
 +Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3GHkVSAKiVYz8TMq4IG2ubsHInSbtyLmNck4BwsQ7I=;
 b=4i5A5C/TmNvax67+k7ARWf+XQmGMTweUcZJoRF5Ht++Ou2Raprr3RoBIVt4TWc4gEe
 druteGZ63mGvixPcAoIa8kyD/bc9ahCYSK5HZU8tgU4kKFDWUjcdsNlrOjlrqQ/BdpO2
 LGvnZTs86jgb8pfiTfWeQCw84SCKfrnJObawUFsMvCQ/+Ra+M6ijHPyQr3213dvpgScv
 /v/406Dxmb8kDVELhe9NSTeUBOe3zu/sfkNMr/gDH6nxjN+16CqvidktWgbp5OrFsbaQ
 LmZJUncMt4J2j/JGLd2OUoCv1zkGOIX328RDO19pshVR1F8WbOtxC6+OZ1aggP+lwSYr
 9Uzg==
X-Gm-Message-State: ACrzQf3X5s8vG1ykqKhYTUaJ00z+WlppZjuIGxHv1OoM9PJfeqqvkT8I
 NTPfMi/1ZfXNX9kIHsg/TIMCRrUBUHpjJgKzTaY=
X-Google-Smtp-Source: AMsMyM5giV6umOQ8lw4KeW0CUnbgP7dUYObe0V5TLgZjDYJ5xZzAW8af5YGYuVtj+hrZORJNqAlp/42B8W1vy0CtMAc=
X-Received: by 2002:a9d:6119:0:b0:66c:92a4:450d with SMTP id
 i25-20020a9d6119000000b0066c92a4450dmr1234529otj.123.1667572154217; Fri, 04
 Nov 2022 07:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221104041634.963830-1-harsh.jain@amd.com>
In-Reply-To: <20221104041634.963830-1-harsh.jain@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Nov 2022 10:29:03 -0400
Message-ID: <CADnq5_OFUbPo4W1KyjK1AdKSjAthLmwVACmO1wmAsYWTb0yyXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: wait till Gfxoff allow signal completes
 during suspend
To: Harsh Jain <harsh.jain@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 4, 2022 at 12:17 AM Harsh Jain <harsh.jain@amd.com> wrote:
>
> change guarantees that gfxoff is allowed before moving further in
> s2idle sequence to add more reliablity about gfxoff in amdgpu IP's
> suspend flow
>
> Signed-off-by: Harsh Jain <harsh.jain@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 222d3d7ea076..5b2afe348c23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -581,11 +581,11 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
>
>                 if (adev->gfx.gfx_off_req_count == 0 &&
>                     !adev->gfx.gfx_off_state) {
> -                       /* If going to s2idle, no need to wait */
> -                       if (adev->in_s0ix)
> -                               delay = GFX_OFF_NO_DELAY;

I think we can leave this hunk.  The 0 delay is still fine even if if flush.

>                         schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
>                                               delay);
> +                       /* If going to s2idle, no need to wait */
> +                       if (adev->in_s0ix)
> +                               flush_delayed_work(&adev->gfx.gfx_off_delay_work);
>                 }
>         } else {
>                 if (adev->gfx.gfx_off_req_count == 0) {
> --
> 2.25.1
>
