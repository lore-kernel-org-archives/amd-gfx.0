Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC15CCD1AB
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 07:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C343310E2D3;
	Tue, 21 Oct 2025 07:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="MCveNcxz";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B3310E536
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 22:42:29 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b6a73db16efso2775319a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 15:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kerneltoast.com; s=google; t=1761000149; x=1761604949;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0WZlH2DqYFCiXY7ctfKICcS4Udl66TWHE3E0JHv0JUQ=;
 b=MCveNcxzM/scwmKGMhlCjZts53d+mw/CZNyM8z4bDBkmUuWokMyEx+pX1CVq0BVlto
 5HLvuniNo7hocolFWVZSX0By6s54F+pX/N35yDP6d4Ic1d2eh1lN3xkmBEoGc7KcSTTB
 SmR17L/owen6RVR9rTGyCSI9Ot7lohjx3E5xKdxuscF4hEQjA6GelifcpPibkOVLVmlM
 v8DtAXexfYnCsxuCGSXhinQra01gAC25of9u4T5bRQovmbbZ1Rwr3525gb3yLAEAR3tj
 8Q7MpILDOk4uICjyjw6hSn2lZr/LRyf/blAOSzSncuYO7484Pouz7vH3hyfI851ObgzP
 w76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761000149; x=1761604949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WZlH2DqYFCiXY7ctfKICcS4Udl66TWHE3E0JHv0JUQ=;
 b=iKSxktkKmgMWypvM5IXLaoGwQsQ788OlKDwsMx26Hgtu+1MOUbYNBOIgqfMvXr1E/R
 y2dgoiWJ2DokfaT/4RoE4BQYHWXhj2Fn/ayp7KSkULEO7shbEzTQphYPa3UYpo+LLM2W
 VD5ZFLMFVsVI9YFWZTBn2rvXEAed+f9GckZDkF9fw0e0ZmMa8QGP4ANsOP4Ier8UPfne
 LP++0wu25bPhKijXJyowWGMkYY5pGXZfTJYxG8YbNh22VucWSR+yzJHqMftw/d5IfFic
 CTpJWlGV7lxcV3mKURzLiS5303AQsONYEK3zsEnwj74/yj401Bl2aLIYSOWy74fRCazC
 veew==
X-Gm-Message-State: AOJu0YxHf4AE75iZDkED3HV+IbUPlG5rYXc6rE/s9F2u+rxAp24MQQaN
 eJBmTheeOTOPYmXRplP/wEce1qBOjNpqKA+NvPUUfffA8T5mcCJh0r/Pu6iJbTxZFH3MiX6EVLS
 FIqElIBtU
X-Gm-Gg: ASbGncsO6HX1v/Vod3OHHFyGKmVc6UNo356rIzs2SFDmGj39E5+PibC6UXc4BBPrsMT
 K/FdzDlvdjIUzAtEFJJR/uJsWDNaCsSSV4E2ehmx3sqkhC2xQYdR3k0u6i3gVScqKe76EJoKWgY
 oGXi+aYzRxwfNwnLsWuaYGTJWBPnLQAFyOddqqyzRzdm2WYCXKAZFZypEMqw3Q4jTQ4u4vEdrwF
 1rDYCPBb0JOjqXYiRlwSOW7CS2cUUoHB7mG1lo8MwyjPJR6o7ltRcMYquXK7jRLRGfJZYsAajBX
 KMwv+n1eaCiCeqjlUY16EuOYlZyZ9L7Qk/WRF6atLWxu2DmQrvKmanfmLMk24VBCB5Mk7bJ4zAe
 pbOh6BF0mOD/39YLnVg/6ypI6BS7OOKXhO3QrX1ulc+1O2L7srnar60YskepjGJstmSEcroVc0y
 DyRg==
X-Google-Smtp-Source: AGHT+IHUEOc3xfI2tI8heWEXh/h72XqkqsVQcuo2Bv6d3BRyZGZMOF0s+ZVb8CgacF2pj4JNoea9QA==
X-Received: by 2002:a17:902:c947:b0:24e:e5c9:ecfd with SMTP id
 d9443c01a7336-290cbb49e26mr225774035ad.42.1761000149306; 
 Mon, 20 Oct 2025 15:42:29 -0700 (PDT)
Received: from sultan-box ([79.127.217.57]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de3295dsm9095139a91.15.2025.10.20.15.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 15:42:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:42:26 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
Message-ID: <aPa60qtBV5iCiY2I@sultan-box>
References: <20251020223434.5977-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020223434.5977-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Tue, 21 Oct 2025 07:12:09 +0000
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

On Mon, Oct 20, 2025 at 05:34:34PM -0500, Mario Limonciello wrote:
> Adjusting the idle handler for DPM0 handling forgot a return statement
> which causes the system to not be able to enter s0i3.
> 
> Add the missing return statement.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/

I just noticed that this link doesn't work; it seems like that email of mine
didn't make it onto the amd-gfx list?

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index f4932339d79d..aa78c2ee9e21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -356,6 +356,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
>  		goto reschedule;
>  
>  	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
> +	return;
>  
>  reschedule:
>  	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> -- 
> 2.49.0
> 

Sultan
