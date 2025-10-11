Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114C7CCD183
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Oct 2025 08:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EFE10E2F1;
	Sat, 11 Oct 2025 08:12:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="RD0PBUM/";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B5010E02B
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 06:54:37 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso2713925b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kerneltoast.com; s=google; t=1760165677; x=1760770477;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iDQcnn3pxOhIHS3GpwRTBdoBsGmY53pQuOP5P07pL6A=;
 b=RD0PBUM/KkPEdYOR1NGAeKNlEfEktI/AZEXvQiF2OCkZzZUGSfbO5YmNycnSyj3jNK
 42tLIQY+d/WpTY+w05cFKKyfRe1X44rTlo+RP6FRqfFGeVMLMfCRvdNkZLQLQ9VrcinW
 NL0GjNVf8ESHtUjjPN3YahDghroz+10HX7xEWDxaBy1xN+XzVS0MDfAAUn7sxdcikgOG
 4GXn1YQtCtoaYWkKWBvcfjL62Q2u0ilVNCIO+bHw78IPW8EsRx8VjkZy/Wzybqv8eZKE
 b6HD9bjp6q8P2+LrpA6qdRomnACd20nYQU0Xvf4h2886A/fPENL7y7OfjNP488OG9MUf
 uCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760165677; x=1760770477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDQcnn3pxOhIHS3GpwRTBdoBsGmY53pQuOP5P07pL6A=;
 b=trF5S2cyRh160jWleu/WTMe7qe4pbc22F4CxEIalcyjEgSfb4IcmpkhWyv7g7Tjy55
 klX+0UsrBcVjhNoCgFHGwI31eVZG43CJR8mUS/MkaZXY+i3BNzRopSrXXRsygYCZyJVe
 9CobFic3A09Mi+XBRQxJqALykij4LqLnRD2Tzl+SGkWDjwSOaBAgwAo+hnvWtjJl6Xud
 8hATiFxI0bfSEaGC3OoaOO9R9CXzMrROz4S+hRUq5OfDSoA4dzNZkSx3lXMzvItm9CAS
 wT/s0LWXyw3aZHmIPBmDZtrKszj3ktyQ1oVMMkanBNfdWfLTum3ywTV7hwhm7yb1y15U
 mlXA==
X-Gm-Message-State: AOJu0YySOq2VCjFVYuuVkoj+HlbIg/omdIQ2owcOANW6OEgdNSySRqyu
 ygibNNy97I0XtZmXZ6iA/sl7UFjop1Wg8XglqKzK+XnSCuXHw5WX7E9Zurfy5RdghVLp
X-Gm-Gg: ASbGncuLulr/1VNNmoqOzuELVFRd7h9SZw1dk+ZiR7mMlPK949M/nQfb4S/0CnI0jBT
 DZsgLt+DZwrWfkAj/YDSYulNylZoWNql5IisyisqYbjQb2/uKWzjSOO/VslcoKNMzmEPSs8Swh8
 1QFwjfCax9Hlt7mUbc8f9KWImqxadH9lEsBISKPc+DM055Pngpc3lf5+sxo3dMTlgSiTYyyokAl
 A3pZekgrZxC0G1B34/2Ngcznn9lHxjfpe6pmz5UW/nU1ashdwSwISPU3CZHpiTxyaVdHMb8+fjz
 2eMMN7YD8WM7/SZZMdYztDnWEAVdfOEFsdY8YLBxQ+gyR8Xm69xm7rO0NtzQLaT2D4CJCVaQ5RU
 iWAIa9I+OXdecK1wUx86AEIZ/+Vwqejv/k/oa7uPcDwr2
X-Google-Smtp-Source: AGHT+IHNPizZawjqTWGrfn6IOIpWny2OWD1EGULxdmCnGOIAEo0y9U4RIB7Opozi6Z2DGZG33VMlZw==
X-Received: by 2002:a05:6a00:2ea1:b0:781:2272:b704 with SMTP id
 d2e1a72fcca58-793853260damr18513421b3a.5.1760165676649; 
 Fri, 10 Oct 2025 23:54:36 -0700 (PDT)
Received: from sultan-box ([142.147.89.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bb19a14sm5059080b3a.28.2025.10.10.23.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 23:54:36 -0700 (PDT)
Date: Fri, 10 Oct 2025 23:54:33 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Peyton.Lee@amd.com
Subject: Re: [PATCH v2] drm/amd: Check that VPE has reached DPM0 in idle
 handler
Message-ID: <aOn_KQXm2uPDZkWu@sultan-box>
References: <20251011003723.209074-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011003723.209074-1-mario.limonciello@amd.com>
X-Mailman-Approved-At: Sat, 11 Oct 2025 08:12:46 +0000
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

Hi Mario,

On Fri, Oct 10, 2025 at 07:37:22PM -0500, Mario Limonciello wrote:
> [Why]
> Newer VPE microcode has functionality that will decrease DPM level
> only when a workload has run for 2 or more seconds.  If VPE is turned
> off before this DPM decrease, the SOC can get stuck with a higher
> DPM level.
> 
> This can happen from amdgpu's ring buffer test because it's a short
> quick workload for VPE and VPE is turned off after 1s.
> 
> [How]
> In idle handler besides checking fences are drained check that VPE DPM
> level is really is at DPM0. If not, schedule delayed work again until
> it is.
> 
> Cc: Peyton.Lee@amd.com
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Drop unnecessary spurious dpm_level variable
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 474bfe36c0c2..9065d799c2c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -326,11 +326,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
>  {
>  	struct amdgpu_device *adev =
>  		container_of(work, struct amdgpu_device, vpe.idle_work.work);
> +	struct amdgpu_vpe *vpe = &adev->vpe;
>  	unsigned int fences = 0;
> +	uint32_t dpm_level;
>  
>  	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
>  
> -	if (fences == 0)
> +	dpm_level = adev->pm.dpm_enabled ?
> +		    RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv)) : 0;

This register read can be skipped when fences != 0. Perhaps with a goto label?

> +
> +	if (fences == 0 && dpm_level == 0)
>  		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>  	else
>  		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
> -- 
> 2.51.0
> 

Sultan
