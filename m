Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AEBE77182
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023FE10EDDE;
	Thu, 12 Dec 2024 14:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lwNMXUqY";
	dkim-atps=neutral
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAE210ED5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 10:55:21 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361ecebc4dso3058935e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734000920; x=1734605720; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bZnf4ZipnpgPUFHUd7Gh4OjDQEIq+meMk9mxYUbMAdE=;
 b=lwNMXUqYOymjKIu9SAy0FBS8ZXBriVHSFAALwDMUeSrNo2ci3KQvVpxWmCLw9ehOzo
 7GQWZTj984K/36QUO+gX0AH7vzp0DtVs1esPxqtjOcqm+BA6Mj0qatdie7mtcOTAPYAB
 ZpoqoC8eH9xY1Kwa8rUTlO0jEnygLIZnvKFfM8PGxYQAVcNND/ypD5XTqep9cLuEyg8D
 JlwIYFdeegr9Nwh8GdZ7QG4aFraFj3UULsfSg6uGptQvsR3ViVfk1QLrInMerKZTcPOn
 nJsydN6egxTJ/VjdtZgKYxNnGEZcMwaJZIjgv6Lh+Dy3iRN0LQOk056IPG6JtsUnYZbb
 nHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734000920; x=1734605720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZnf4ZipnpgPUFHUd7Gh4OjDQEIq+meMk9mxYUbMAdE=;
 b=N7Lqf0BLmGlKCzn9+BCoCmhHVfFGGFvva8b1xP/y2RJN21uv50AHiFMWlCZQg+rUYA
 CwHw9GBnKrTY9OZ9bpwGPgQUHTUc99HQPzSHNFDwMxQkoSvbLLzcsyJZBBX0GcDB2phv
 3cbel2CnsXaGN6/A5n2ZtTehjmhqycE9Tp/4ZRqNSHR/5ONaZPPUK/aGasHoR3Dhbs2b
 e+9lyIQT5ywElbGp3n3tYtNdh9qRH44YYBi59mRXZgoCwyMDh4qnS3fco8fOTZpRE3V5
 xdPrgJYA1YBc+v05P1LcB70V8qzDFsDzZThKLMfDkI9/NoJnJ0hJlRNDld6ZgUZ/BdBO
 WZpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPc7V9Z4qG2MrDaAYFRgBf8qZBDPKiPzgQG5wfjeNUtlbmSKXaw8U75BSHh4eia+XXWDpetL8m@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywbwv/mZM+tBRomsMrD9YcIo0v+6IutsyP7tMHqWLq63oZGveHF
 VREltqvgvV2fUkTwKxuh3bgQelPGXxUQ2rGJ8d9XYEkzZiwErWaowNxV20VjGhk=
X-Gm-Gg: ASbGncu4kVIlzfu/95RxuN4kIHGshgF3RaBA+o7Vo9Z9nWvc20Ui5VCbACP0VCUw/zr
 RZIyaN8HUUni/9o7m0Ft5U4ra8BbAC60SPvIYpGYayPbqw3wqSCU2et6R8NO4l7SJvodKB02KHH
 5jDwSb6ohMlQ6TnRQvXkK01tQpyuE5642ptdaJAeHN/u69rottLcLWrt9ZbElMJCG0WXRBoesNI
 6iNVfpjz522GKCPYpZy+fv7Pzw3kP0pLXqFW6as6gbuaGSdvp/5JraCpauNpw==
X-Google-Smtp-Source: AGHT+IEhp1L7hN1GJCYWH+659nSCBIHDDUD49txpHpiXVuxw4EtnhWkP25MBbsMq3UQQ7msuMGo/zw==
X-Received: by 2002:a05:600c:1e0b:b0:42f:7e87:3438 with SMTP id
 5b1f17b1804b1-4362256dc73mr26327345e9.0.1734000920123; 
 Thu, 12 Dec 2024 02:55:20 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706c5fsm12811415e9.31.2024.12.12.02.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:55:19 -0800 (PST)
Date: Thu, 12 Dec 2024 13:55:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 dmub_tracebuffer_show
Message-ID: <da48e9ef-b0c2-4852-9d13-20f0480d7bd6@stanley.mountain>
References: <20241212093758.916895-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212093758.916895-1-srinivasan.shanmugam@amd.com>
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:04:19 +0000
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

On Thu, Dec 12, 2024 at 03:07:58PM +0530, Srinivasan Shanmugam wrote:
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 11a7ac54f91c..0092d4a1e59d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -902,7 +902,7 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
>  {
>  	struct amdgpu_device *adev = m->private;
>  	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
> -	struct dmub_fw_meta_info *fw_meta_info = &adev->dm.dmub_srv->meta_info;
> +	struct dmub_fw_meta_info *fw_meta_info;

This needs to be initialized to NULL.

	struct dmub_fw_meta_info *fw_meta_info = NULL;

otherwise it's uninitialized later.

>  	struct dmub_debugfs_trace_entry *entries;
>  	uint8_t *tbuf_base;
>  	uint32_t tbuf_size, max_entries, num_entries, first_entry, i;
> @@ -914,6 +914,9 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
>  	if (!tbuf_base)
>  		return 0;
>  
> +	if (adev->dm.dmub_srv)
> +		fw_meta_info = &adev->dm.dmub_srv->meta_info;
> +
>  	tbuf_size = fw_meta_info ? fw_meta_info->trace_buffer_size :
>  				   DMUB_TRACE_BUFFER_SIZE;
>  	max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /

regards,
dan carpenter
