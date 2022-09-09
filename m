Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925CEECAAD5
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 21:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E79110EE71;
	Fri,  9 Sep 2022 21:00:15 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 199B910EE71;
 Fri,  9 Sep 2022 21:00:12 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 c22-20020a4a4f16000000b00474a44441c8so435411oob.7; 
 Fri, 09 Sep 2022 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=M8jtTpYkUx+qSYcYHZXqXNBn3kSBt02rTRB42krXs0U=;
 b=DGxSDy6/vnJ7Vxfcnjv/652ZQXFAWTJedpkyZOzrTsy4EbOpewz+869pECqTS7qHE0
 qGLroHGf69JxCQIONFiIXgHilvV4kT7Qf/YdIQwyP+5/DJac7n1s0m5Qtw6iW3h9JwCC
 vxTNvGXsdhr1IZFM+fwybuc5nU2NT1BmiWFb2oqpbSkg0sS6TxH5jvqi59XxHaK7cil3
 V7svw1Z5nTnwoK6SJUc8KUepZtMMLSBU4FdK7EstV8gE8VcNv2YelwbZGPCCAK9UygGe
 gyhtkLiFsUaHOsOmELyE6Wsdqvx9ud+UThupRtDWXiUkXAttH4N3SAoXHW5Qtmh+Oe7o
 niqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=M8jtTpYkUx+qSYcYHZXqXNBn3kSBt02rTRB42krXs0U=;
 b=4DrGRJFfyW9F/3Cwa8M/dM5xizIi3a9s++Xxsy3jHRoNxEhuYT1NIIyWrPjD8ZpQN6
 ZMfpgfzjX0487WLwmwQGqdg8xp5Hzk9HRbETqAiQlFvq2f5A8iJjnVAyfw6Vp2NH15i8
 uHdIng9vSvQ2peIa9gFYJuO0H8ytQCimja7UxceNq/pUgN99SuVve3D/WQJ1g6wt1M+R
 /KV2Z2re4F+UtUbBns+NsCprSoVB3r4rFpHtInozr6hNjKcWh2tPaGOhQP1zFtAU8POg
 E+b+mizw4gnVIjEZckaQFDhxtDHl4dfTIZmqSDAXk/MWcrYAtpgOGmlsllTb7GYRqLx4
 F2CQ==
X-Gm-Message-State: ACgBeo3kN9JAc0ftigFOQLpODZvCROlghm2sWdvxHxo9KATPDMbT57Dg
 yjFuHUx5lZH5XYwv95c8nA8CbUg8L0zYtglveSo=
X-Google-Smtp-Source: AA6agR7AsYoshYD5atldZXlBSSJ41Zk/4yGDqCjPj1t9rAIRz3Qx2hwr1VJnV3pmI9mX62MVcKkVNhQGZ/UjSJ6CBiw=
X-Received: by 2002:a4a:a78a:0:b0:472:a078:98d6 with SMTP id
 l10-20020a4aa78a000000b00472a07898d6mr2334077oom.97.1662757211174; Fri, 09
 Sep 2022 14:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220907041058.935-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220907041058.935-1-yuanjilin@cdjrlc.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Sep 2022 17:00:00 -0400
Message-ID: <CADnq5_N3uLVZOCMbrq6yq_GdyFFUo1CVUXckHYAxdfHRecBx3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix repeated words in comments
To: Jilin Yuan <yuanjilin@cdjrlc.com>
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
Cc: Charlene.Liu@amd.com, airlied@linux.ie, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Wed, Sep 7, 2022 at 12:11 AM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
> Delete the redundant word 'in'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> index bdb6bac8dd97..c94a966c6612 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> @@ -300,7 +300,7 @@ static void set_high_bit_rate_capable(
>         AZ_REG_WRITE(AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_HBR, value);
>  }
>
> -/* set video latency in in ms/2+1 */
> +/* set video latency in ms/2+1 */
>  static void set_video_latency(
>         struct audio *audio,
>         int latency_in_ms)
> --
> 2.36.1
>
