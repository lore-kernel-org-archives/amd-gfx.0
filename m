Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6485FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 16:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D9E11A1ED;
	Thu, 14 Jul 2022 16:37:17 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C750011A1ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 16:37:16 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id sz17so4386700ejc.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xGhBTp6XRPi0txSgTZlfvtDUPgpddOrc4ZKc5VVIM6s=;
 b=e0uLLMIncFBbTwGIjIl1+bMVa6Sd78yc9uhbKc4xWxYJSuOISxjql2JxSbSokgAher
 T21hOslTSYyidI7/bIkAG0mp/9ZNhXTOdWXd7VPHfYtYqWJxa2uusobA0tEJBTCmMlrx
 Gt1RIlt0gFq4FB7TrPXQ4AD0saxWVXBFAR4xmycyhVB7bI0PAqz9UQKuCP8IHETcesBv
 OVbOIGe8vVn4I0AoOPaFlg0L2a+514xo87I2/eA1MwoLL8zm9t/8ryAqyPNhBp2UW/rX
 PlRsV4/4H84qomx2nhKufYlK4sC1UXTFheNIwSM4cpzz1Wpd55TxHMfdfcHWzviQG8s1
 Wi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xGhBTp6XRPi0txSgTZlfvtDUPgpddOrc4ZKc5VVIM6s=;
 b=i2kQv2h0behjngV94Qxs571jwQXx6r3c89KvBPl9WE4VrnmJ5DDxPDdUHwlQz/UdjG
 LbMnepqjfCPsd3IKVtoxTXPdBiS9OskIdwtzP+uamL7Q228XYfdckuS/k0SyysoQPQP4
 qDcpaiU/4jNP9lDpsVlh631G/q7jLnf4AyH8qtB19b7e//pA1l1COR66/Uci2mosxHfC
 PUJJ3f4h1Jn083GqUgn9yWRqA6vPqoE6kO0w7czsSqm/yRporCZswf5d21UXqnDp+HLC
 t6Xxg34XDufBpSYESRbZlSpJJMK2n1qSNS89Y8OmL4RGxlvLXIpTtelskIUlkOqp1ps4
 4b3Q==
X-Gm-Message-State: AJIora9jS6Fj4fsUmW8GhJR/N8GGXD0KQ9xkyDxABCM2BhpTSSiujDJY
 vfsqAd9PnIsb0VFv5JDAWGOvO5K/t4ra0hxe0W+2tx+z
X-Google-Smtp-Source: AGRyM1v967M0anZhzBLm5GeEj5JA0DjTdKE/5DdEQ+hfX+QapVqZpyYibDMwZrZ/ei0QNlQWKcXiTfDn2+2GhjdCExk=
X-Received: by 2002:a17:906:4fc5:b0:72b:9943:6f10 with SMTP id
 i5-20020a1709064fc500b0072b99436f10mr9816539ejw.722.1657816635413; Thu, 14
 Jul 2022 09:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <Ys6tkVXQeJcgeZn0@kili>
In-Reply-To: <Ys6tkVXQeJcgeZn0@kili>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jul 2022 12:37:03 -0400
Message-ID: <CADnq5_OHKTsoXN1Oic+dFovWyWBFkVXDixX7WtERnOTns+1WzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary NULL check in
 commit_planes_for_stream()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Roy Chan <roy.chan@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Alex Hung <alex.hung@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Michael Strauss <michael.strauss@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Martin Leung <martin.leung@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Jul 13, 2022 at 7:34 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Smatch complains that:
>
>     drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3369 commit_planes_for_stream()
>     warn: variable dereferenced before check 'stream' (see line 3114)
>
> The 'stream' pointer cannot be NULL and the check can be removed.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index dc2c59995a19..76f9af2c5e19 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3366,7 +3366,7 @@ static void commit_planes_for_stream(struct dc *dc,
>                                         top_pipe_to_program->stream_res.tg,
>                                         CRTC_STATE_VACTIVE);
>
> -                       if (stream && should_use_dmub_lock(stream->link)) {
> +                       if (should_use_dmub_lock(stream->link)) {
>                                 union dmub_hw_lock_flags hw_locks = { 0 };
>                                 struct dmub_hw_lock_inst_flags inst_flags = { 0 };
>
> --
> 2.35.1
>
