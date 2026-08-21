Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8C5C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 22:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBD310F3D6;
	Fri, 21 Aug 2026 22:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aiaHmWrv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB9510F3D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 22:35:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D564600E2;
 Fri, 21 Aug 2026 22:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3191F000E9;
 Fri, 21 Aug 2026 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787351707;
 bh=pVznWLiEejWbZ4E/WtvEVtorSw6KAAOOJTbDf1aCfE0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aiaHmWrvtmIcXjOBrfqgxH/JSTGCY7WMzQFsm7rPRLi5ZkpJFE44VZuaG0ZNM4+Qo
 Zje0W8FA12ibQL04s2Ns73Po49wSPol7lPWeB6Km0i3QK7ZGizADGQ6oaFI4mrNC7d
 btnJcq6wzXegil6Zf3/BJtbVNJUj9M7qDNxeMY9yms2qmNJuS7zUwRA+LcBVJfims4
 8t3zHrdxiGanLd8Iks99IHjLTWECoib3ny6R8TudV/6+QLS15acXsfn9DExyTF7UOr
 V/ntw4WYR+JHirGke+RKVSsvq6MnRSKCfrN8rsKpBufh7dv3q+J3WmyqgNw9LE4Rxm
 9Ri1ohKlWF8bQ==
Message-ID: <d30ea1a8-36d1-4d1b-b13c-06e36d7523f0@kernel.org>
Date: Fri, 21 Aug 2026 17:35:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Bump frame warning limit for clang
 builds of dml
Content-Language: en-US
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20260821223251.692196-1-IVAN.LIPSKI@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260821223251.692196-1-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/21/26 17:32, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> When building the DML files with clang without any sanitizer or LTO,
> the following -Wframe-larger-than errors break the build under
> CONFIG_WERROR:
> 
>    display_mode_vba_30.c: error: stack frame size (2512) exceeds limit
>      (2048) in 'dml30_ModeSupportAndSystemConfigurationFull'
>    display_mode_vba_31.c: error: stack frame size (2416) exceeds limit
>      (2048) in 'dml31_ModeSupportAndSystemConfigurationFull'
>    display_mode_vba_314.c: error: stack frame size (2392) exceeds limit
>      (2048) in 'dml314_ModeSupportAndSystemConfigurationFull'
> 
> Clang consistently spills more than gcc, pushing the frame past the 2048
> byte limit.
> 
> Apply an existing approach of increasing the warn stack size to the
> non-sanitizer path so plain clang builds use a 3072 byte limit.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5642
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dml/Makefile | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 10d4ace04d4f1..99da9dbd62b75 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -36,7 +36,11 @@ ifneq ($(CONFIG_FRAME_WARN),0)
>               frame_warn_limit := 3072
>           endif
>       else
> -        frame_warn_limit := 2048
> +        ifeq ($(CONFIG_CC_IS_CLANG),y)
> +            frame_warn_limit := 3072
> +        else
> +            frame_warn_limit := 2048
> +        endif
>       endif
>   
>       ifeq ($(call test-lt, $(CONFIG_FRAME_WARN), $(frame_warn_limit)),y)

