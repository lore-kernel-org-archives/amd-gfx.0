Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447CCC021A6
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B56810E44E;
	Mon, 24 Feb 2025 13:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IOM5tliM";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D6B10E29C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 11:18:18 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z1dWq3hyNz9sp9;
 Mon, 24 Feb 2025 12:18:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740395895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poEXpB9K1y9vdfQWtg9Kt9vHNV/RTZ0L7LaGGPuin2E=;
 b=IOM5tliMYHrHklJCslpc23Y2z9qSc7C4myDYgRpC2yRS4Rx4N0vUSGEVnDFE8k/xRT/NeW
 JCKnIzueuGXXCYIyTeyaebgSwvg0VVfICr3BiHLJA47tS0TG8sQ+fjoncPPV35DpWrp2by
 M4RnY1lOjYRqzZYqP43eyY4QAWlVd7kwWMwPOzdV8Y4aDm7EtC71BsoSq1otL+jsThOTd8
 LM/wMtjOE8UEJKzSGNlXSvDzB4L107H+GWqZcFsEJ27IkAz/l3HPpbhj2i9YGosBxVy0df
 ujbK/n1Wyfef3m2CRBFZ8zFCb1L2di2eHQ1UtutrUQV1sBSSdyfvwdHWdgkXZg==
Message-ID: <055fb477-c369-414b-98e4-d2677213fb9e@mailbox.org>
Date: Mon, 24 Feb 2025 12:18:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Log the creation of a coredump file
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, siqueira@igalia.com
References: <20250219213517.281556-1-andrealmeid@igalia.com>
 <20250219213517.281556-2-andrealmeid@igalia.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: de-CH-frami, en-CA
In-Reply-To: <20250219213517.281556-2-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m4n5jh5nm7i7j4fubmeks4qk69itcojw
X-MBO-RS-ID: f8b276519071cec9aea
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

On 2025-02-19 22:35, André Almeida wrote:
> After a GPU reset happens, the driver creates a coredump file. However,
> the user might not be aware of it. Log the file creation the user can
> find more information about the device and add the file to bug reports.
> This is similar to what the xe driver does.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 824f9da5b6ce..7b50741dc097 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -364,5 +364,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  
>  	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
>  		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +
> +	drm_info(dev, "AMDGPU device coredump file has been created\n");
> +	drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
> +		 dev->primary->index);
>  }
>  #endif

Maybe this should be done in dev_coredumpm instead of in the driver?

Could make it a single line:

	drm_info(dev, "Device core dump created in /sys/class/drm/card%d/device/devcoredump/data\n",
		 dev->primary->index);

(AFAICT drm_info prints the driver name twice already, no need for a third time :)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
