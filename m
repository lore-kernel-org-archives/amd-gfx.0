Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26352C54EBE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 22:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1D110E950;
	Thu, 12 Jan 2023 22:49:33 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FA010E94D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 22:48:03 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 o8-20020a17090a9f8800b00223de0364beso25128575pjp.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 14:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fzuKIZ8Z+3b4uawi4BGHfQ4wFpj7ytOPE07LAdmBEaE=;
 b=BoXXCDssqYGTs6nz4SH2ZBN4BYe4RMftfjOxtpLwMYY3mJ78EtstYNpyJr9jBx/Vsz
 A8lDlYkQ70cyJ+def1sy513WoZBnQpci2be00fioiWQHjiC2O1HDAIeIs/d8Qf6rewU2
 2J0DhYZwUffvSU4e25o2a3Eum9JaMM06b8Nz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzuKIZ8Z+3b4uawi4BGHfQ4wFpj7ytOPE07LAdmBEaE=;
 b=Mr+Sa97+UuZxwB9pcRkKiiEGePPBUURH9EgY7yf93Noq6Zp4nogktF0ON00/uw6AvF
 6DhcjMMSA7VCt2xhMcVjb5SAS4OqZLH950f1nTAhAgxzMOGf5yAqF//S9sLA4YtGHZv6
 hLhXeFwh5RYYQwXPsedefefPciUN3bSy1wdzleXN4TUCxRTdl4DpracyeQx6Z1ipfGrU
 zzbmE1f1BlW8IrDnK1AqoE52oF4SgNeJnrmFOfcUC/jo3dmQ4YHXCrBjgbK3LiOeTnPl
 j3o4I5dyps+wL65lgY31LQ4qwyYtSxZtumoqAGchllOEjyujm48SjQXf2NyS9YadhWDl
 Sy3A==
X-Gm-Message-State: AFqh2kody8LY3EFx9KBk6L2zO3sEoFTvzhhUD46j6RRZHpGnzh1wQgcr
 yufHz3hDCRYIm7xY+od4uN3Erg==
X-Google-Smtp-Source: AMrXdXuTsFlMNh6MMKdrdsul54cA0E1JL8Ob6na1I2fpfcJyXwI1vOEw8+I7nyo4fHi8aYlTYeASXA==
X-Received: by 2002:a17:902:edc3:b0:191:4389:f8f5 with SMTP id
 q3-20020a170902edc300b001914389f8f5mr68064623plk.34.1673563682817; 
 Thu, 12 Jan 2023 14:48:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a170902a38300b0018997f6fc88sm12692569pla.34.2023.01.12.14.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 14:48:02 -0800 (PST)
Date: Thu, 12 Jan 2023 14:48:01 -0800
From: Kees Cook <keescook@chromium.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] drm/amd: fix some dead code in
 `gfx_v9_0_init_cp_compute_microcode`
Message-ID: <202301121447.580861E8A3@keescook>
References: <20230112223701.29477-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112223701.29477-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Thu, 12 Jan 2023 22:49:31 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 12, 2023 at 04:37:01PM -0600, Mario Limonciello wrote:
> Some dead code was introdcued as part of utilizing the `amdgpu_ucode_*`
> helpers. Adjust the control flow to make sure that firmware is released
> in the appropriate error flows.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1530548 ("Control flow issues")
> Fixes: ec787deb2ddf ("drm/amd: Use `amdgpu_ucode_*` helpers for GFX9")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
