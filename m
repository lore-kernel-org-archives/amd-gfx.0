Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3D9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 10:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B2F10EFF6;
	Tue, 11 Jan 2022 10:41:10 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050::465:102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1811010FAA3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 10:41:09 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:4:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4JY6g71DvyzQkbH;
 Tue, 11 Jan 2022 11:41:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1641897664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WY4Gp5ZlxSloBF860ih+tTDrXRFIXMfjAtQl0kMYJc=;
 b=YBwj25y8ZE9Surc1oSoYDf85ZHX2k3SE1lECzuxs3Zj7EaGw5ySk4XomqvGQzSGYNNw7gE
 wCHr3Cd1ETuBG6ukObhfrbIVujNq9xgF55PQ2rZMyHUOJR/+4l8LaVpT3T+6WCrotWAG4s
 XE9/KCn6kp6yZXhUj3y59yg02hOR8oLRDJWLHliY2bLIF1Krr0cSSmFIRAiYbp4W+B9BIW
 Ul36OvpWXBGKzLyo2zLpWAQ3FhmYhLZMXo9IlfbHdvGKIdyWNvDtEWUA61jmNW2j6uAnbB
 q/0FBv8R632Xvjpj65ScaDEeqbDHzUay2HgkimeNmBimlj9Iyykv1AEUYgVnCw==
Message-ID: <3bfd4b1f-effb-e16f-8282-628fe2e6089b@mailbox.org>
Date: Tue, 11 Jan 2022 11:41:01 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Treat warning as an error
Content-Language: en-CA
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
References: <20220110233906.1178021-1-Rodrigo.Siqueira@amd.com>
 <20220110233906.1178021-2-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220110233906.1178021-2-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: nicholas.choi@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-11 00:39, Rodrigo Siqueira wrote:
> We have one internal CI that builds our kernel with the -Werror flag; as
> a result, when we try to sync our branch with amd-staging-drm-next we
> get some failures due to warnings. This commit tries to alleviate this
> problem by forcing a warning to be treated as an error.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 7fedbb725e17..158f427c2f2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -27,6 +27,8 @@ FULL_AMD_PATH=$(srctree)/$(src)/..
>  DISPLAY_FOLDER_NAME=display
>  FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>  
> +subdir-ccflags-y += -Werror

The problem with this is that different compilers, or even different versions of the same compiler, can generate different warnings for the same code. So this will definitely result in some people hitting compile failures for no reason other than using a different compiler (version) than the code had been tested with. Or maybe just a different .config.

Unless you secretly hate your users ;) [0], I'd strongly recommend against enabling this unconditionally.

(The proper place for -Werror is in CI which gates merging of all changes. E.g. Mesa's upstream GitLab CI does this with great success)


[0] No, this isn't about RHEL — the RHEL kernel build always enables -Werror, so we need to deal with that anyway.

-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
