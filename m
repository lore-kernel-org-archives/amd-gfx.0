Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B30C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B462072D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 15:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADfHqXFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B462072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA5789B49;
	Mon, 13 Apr 2020 15:02:36 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2732789B49
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 15:02:35 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id e26so9596986wmk.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GtWTfDIjkby++cmhN6zWO+1ZbTBPK0zWnP0RkgK3ur0=;
 b=ADfHqXFs7QpZHgGMX9nEtDv6KvjZij8b2J7EC8CnKslY6mqgbZP3OG7LxNsM/Xvo5K
 twjTHzJX9vWi6+kO2iIq66oCLh0uC2m+9/TMymQ9PlfsSWk6yPVznt/YRVrAgsM9C65P
 cuDtdiQhG5MQyzriAyL7sQK4SE4goZ9dG0fCZ5vDU/X4YBj+issMIRcnob5DZOuKUYjm
 uDcoiZTbqtgexarQp8XJuXpp51uaP2/nPBF9Br/e9vuFbUgBYjTc7HOAJts11hLUJh4C
 BXvqtsOB1w41EbuXqEHi7L1pE+VKkNXENYOCZA5448X/kF/fO6CywpkDKtkihOQeUocc
 6oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GtWTfDIjkby++cmhN6zWO+1ZbTBPK0zWnP0RkgK3ur0=;
 b=MPfsujbq7wZ7S/6/X56u6LCzzBm+jmEN4hIUrkp98h2kCX01/NEM1ZNT1DbBvw4qrc
 F9x43RYMdPT4FwA17hUFa7l1w0JIE2G7YF3eUcGndoTqZci5agvDHtfywEiqfjH/K3VP
 +JyEcjY/rkuLxXhz7Tpf6tC7248+RBwc76kQOsq5kbwB4XwIrFFrIllRtiNPLNuEFihJ
 947fe03mzpLhuLxGpM3WAR7dujkOUP4YtA9pmE3h8zmG9o6s589VBE+eBtNHUS6w4Rb4
 AvD9gUm7TsW9/kwQ9eoBJVJ7UGukGhp5SWYRGRbEODet+2UDi7BO+ByWajU3s3STSaMJ
 7dOQ==
X-Gm-Message-State: AGi0PuYdwIq2C+o5TwUveHPb+dV++lIz3L9YGoRIbyHTPzKdj2GqpWoy
 RVTZ29rluAodei3bb5MPl+EbNL5gOEYwRtvJQEIE8w==
X-Google-Smtp-Source: APiQypKf6SKnynzv5ymmEymzrMqqYFN9zxcOmUszrXTYj/0Ynqq64mEA8xgcCPui/EMzNDQpePpzE/AdE9SB9eJdNZs=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr19388119wmb.56.1586790153423; 
 Mon, 13 Apr 2020 08:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200409154253.77102-1-alexander.deucher@amd.com>
In-Reply-To: <20200409154253.77102-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2020 11:02:22 -0400
Message-ID: <CADnq5_M6JA5vMbSUyweHMJ++hmk3ynWQ2jEvqwUFz8puPhAE9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx9: add gfxoff quirk
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

On Thu, Apr 9, 2020 at 11:43 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Fix screen corruption with firefox.
>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=207171
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1d18447129b1..e14ff65ac735 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1231,6 +1231,8 @@ struct amdgpu_gfxoff_quirk {
>  static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
>         /* https://bugzilla.kernel.org/show_bug.cgi?id=204689 */
>         { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
> +       /* https://bugzilla.kernel.org/show_bug.cgi?id=207171 */
> +       { 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
>         { 0, 0, 0, 0, 0 },
>  };
>
> --
> 2.25.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
