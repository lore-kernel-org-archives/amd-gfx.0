Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1479C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 18:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A644520CC7
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 18:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JosPT36V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A644520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF306E139;
	Mon, 13 Jan 2020 18:42:33 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D706E139
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 18:42:31 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id u2so10846526wmc.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2qfbSgSsG1+/BzW158rjhqFd/BgtRfkxMg+ozMHeIYE=;
 b=JosPT36V66KvjDA6NEZ3Uxd77RLNykIXESQLAuhM1n0sTerlUm/Njdxbfi5/NE6Z4h
 7hv4LtxSlhulm5WFTKqFIKSUgoN7QmlpdHhbtj8CtNBUPUbB0esuV6zZz7ngAGCav6md
 Ro6caeUhiexnfA35ytGpJsfUZRgMa0q2AOIUMaODxq27iD2vQxPvFUYXjgzMmi945FWq
 Mf2TdkX+mA4hbFJUun9oyfozGbgIPL94Uxa0NzwsZ87Ap4WAaTnms04in3g9N9FFSpjS
 MWExGWoWJtABSB7zacR5j87lPLkrNCiVN049nZM/5APewQICia+WDJHBeNvqsn3Qn4z0
 1X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2qfbSgSsG1+/BzW158rjhqFd/BgtRfkxMg+ozMHeIYE=;
 b=YrqX/RBhSKBV9G999x3xM/nBjop1eOJk4DJ6FEpviMfyBdg+Itvt2U3FqTqtYgTPaV
 0lJ3+6jNjPczOQdaDU7vK8MCfvv8vRvwN6hLyJjWyQSeMnlceKXeGFYh3sE6Znh6LiVD
 Vi7GKT+ms7cxOjKbAydquSKGh6UyyfxU1cY/7e0Ee+oernzH3wwlNcfHozT3t8lkMS+e
 APemE52l5woMbQRpV3YuICxzuWyfptlAlmbE1x7XuNU+OBBYZe2RtwAIWQiiJEUdN6zB
 gYpTEwlwdKwpfXg9gLbTgRpGA/2FQGKxXxPgaTQJ+icLPA4k3L+HizxHV6cdHgRpDywH
 fOSw==
X-Gm-Message-State: APjAAAV5bixEKshWTvw8lD9IFwUCL+01ZUMoTJiP/rFj7+/vaGnxvv2J
 JTqjExVaDmc0hyRXh4CFoukZRgECh2pKW7G/2IS3hg==
X-Google-Smtp-Source: APXvYqwqfKrrrWlE0jieXyW4dWZs+koPvmMU0IkUrc8vXUvgLEFeE/SlFaJAeIYZhYNBWPBp8ninbY2p9CXonT376VA=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr21927248wmq.65.1578940950315; 
 Mon, 13 Jan 2020 10:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20200111002232.247789-1-alexander.deucher@amd.com>
In-Reply-To: <20200111002232.247789-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jan 2020 13:42:17 -0500
Message-ID: <CADnq5_MgDc7xuDADRGY+Gqm1jsMpdy3tLCpwaio0tt8+3-0pqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/df3.6: remove unused variable
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Fri, Jan 10, 2020 at 7:22 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Unused so drop it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 3761c8cc1156..f51326598a8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -264,7 +264,7 @@ static DEVICE_ATTR(df_cntr_avail, S_IRUGO, df_v3_6_get_df_cntr_avail, NULL);
>
>  static void df_v3_6_query_hashes(struct amdgpu_device *adev)
>  {
> -       u32 chan_cfg, tmp;
> +       u32 tmp;
>
>         adev->df.hash_status.hash_64k = false;
>         adev->df.hash_status.hash_2m = false;
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
