Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9793AE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 16:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4062E10E1C5;
	Tue,  7 Jan 2025 16:01:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="aEyKgtVT";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9777810E1C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 16:01:07 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so11330924f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2025 08:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1736265606; x=1736870406; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gcKT0I3SsLedH2TQveBeJBFIRBqbzWijWm5hO+Gmv2Y=;
 b=aEyKgtVTsO4N3urocv3trm7cITc1eqvwWFa/tHimkaDLxfspRtor6n9gYQ9POFGj2T
 65JEwY2c4jwwTZ8MZdVtPRMvRdZ/S0VO1H1tX8NPldDsSSWq+hg6rBSEaYL9jxS3OjGJ
 mI9EEdc77oP3oKdBsx8ajytXhPKsk2iUDXYBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736265606; x=1736870406;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gcKT0I3SsLedH2TQveBeJBFIRBqbzWijWm5hO+Gmv2Y=;
 b=kLMbnfGaFfZdwvvDi08u6eFL+wJDYb4wFauQHEF+5tFlSgDDRfqpHfh1ow9Y2PfPZu
 d2FaUXdVSzKGNWj/ulpw8Ir5MUAoTOufy2e+blj1gTR3EKK81BrLx/wMfxBsqtoFiB6e
 IcQv4xehWf6Za6Dp2xlnqalDJtXQC7KR4Iq+th773NNN2IyM/5HpL4XbWS3zLuGknA2F
 YegIGgwTToRKfeV7NOw3+hVFezpS8pkskgh0MKb760CCmqLzJbTqjag7VFjGIuZyU6Bt
 khQCiujttwXYeO9jpoGWJGfJao3Dd/5EUuApgPAYpnV6lNE8i0hwQEonR/j86CXvqQhR
 KD4w==
X-Gm-Message-State: AOJu0YzizMkY1neKBF3rowJQbU9pw0aI6UbXt3FRMcDSaQLUaOjDinFW
 ofUYb6vhV7gEdkc9qF3ZTr5qMFoLYdsLMqzqal6cobGZWh30iPvDJ37eTRTqOpFvquRQ+kal2D/
 kOTA=
X-Gm-Gg: ASbGncuhHyGifwvb6R/g/NoVkEWKCDZ4TSgGks7Tk6ZHxXgz9qphrGrWQtCdRjKOvq8
 sK70Hgb0LJtHrrRfsVFmG0q/WguM6GibhRok/ZgA/I4wed9T+zcqksJVq/jI+HJvEt0mXKjIjga
 GIVwU+i7Tm6iA/skfoMMFG/dhWx5XgLwr5nMmHSOwI48oQ+ZaIdG8kLWMTJVgJgXOGAXZY9+xis
 GusB61/m5UhebJWJ5YG4TCI4Yw1iPTyHdcorq3qPIfvEdsAkMNldCEybkPvEv8wiQVY
X-Google-Smtp-Source: AGHT+IHw7U5bwEb+PQTF6+p7uboI+4w+j8uiTOK7Dp0r/5Q9NFHpqsveVMy6jTYyW7nKvgqot6ci0A==
X-Received: by 2002:a5d:584f:0:b0:386:399a:7f17 with SMTP id
 ffacd0b85a97d-38a221f2ed2mr41855508f8f.24.1736265605951; 
 Tue, 07 Jan 2025 08:00:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b2afsm648717595e9.35.2025.01.07.08.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 08:00:05 -0800 (PST)
Date: Tue, 7 Jan 2025 17:00:02 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, sima@ffwll.ch
Subject: Re: [PATCH] drm/amdgpu: mark a bunch of module parameters unsafe
Message-ID: <Z31PgleArdPbhGAw@phenom.ffwll.local>
References: <20250107145308.53467-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107145308.53467-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 6.12.3-amd64 
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

On Tue, Jan 07, 2025 at 03:53:08PM +0100, Christian König wrote:
> We sometimes have people trying to use debugging options in production
> environments.
> 
> Mark options only meant to be used for debugging as unsafe so that the
> kernel is tainted when they are used.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index acb9dc3705ac..9ddfdb02a6a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -401,7 +401,7 @@ module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
>   * the kernel log for the list of IPs on the asic. The default is 0xffffffff (enable all blocks on a device).
>   */
>  MODULE_PARM_DESC(ip_block_mask, "IP Block Mask (all blocks enabled (default))");
> -module_param_named(ip_block_mask, amdgpu_ip_block_mask, uint, 0444);
> +module_param_named_unsafe(ip_block_mask, amdgpu_ip_block_mask, uint, 0444);
>  
>  /**
>   * DOC: bapm (int)
> @@ -459,7 +459,7 @@ module_param_named(vm_update_mode, amdgpu_vm_update_mode, int, 0444);
>   * Enable experimental hw support (1 = enable). The default is 0 (disabled).
>   */
>  MODULE_PARM_DESC(exp_hw_support, "experimental hw support (1 = enable, 0 = disable (default))");
> -module_param_named(exp_hw_support, amdgpu_exp_hw_support, int, 0444);
> +module_param_named_unsafe(exp_hw_support, amdgpu_exp_hw_support, int, 0444);
>  
>  /**
>   * DOC: dc (int)
> @@ -570,14 +570,14 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
>   * Set to enable GPU recovery mechanism (1 = enable, 0 = disable). The default is -1 (auto, disabled except SRIOV).
>   */
>  MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
> -module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
> +module_param_named_unsafe(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
>  
>  /**
>   * DOC: emu_mode (int)
>   * Set value 1 to enable emulation mode. This is only needed when running on an emulator. The default is 0 (disabled).
>   */
>  MODULE_PARM_DESC(emu_mode, "Emulation mode, (1 = enable, 0 = disable)");
> -module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);
> +module_param_named_unsafe(emu_mode, amdgpu_emu_mode, int, 0444);
>  
>  /**
>   * DOC: ras_enable (int)
> @@ -732,7 +732,7 @@ module_param_named(noretry, amdgpu_noretry, int, 0644);
>   */
>  MODULE_PARM_DESC(force_asic_type,
>  	"A non negative value used to specify the asic type for all supported GPUs");
> -module_param_named(force_asic_type, amdgpu_force_asic_type, int, 0444);
> +module_param_named_unsafe(force_asic_type, amdgpu_force_asic_type, int, 0444);
>  
>  /**
>   * DOC: use_xgmi_p2p (int)
> @@ -955,7 +955,7 @@ module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444);
>   * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
>   */
>  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
> -module_param_named(reset_method, amdgpu_reset_method, int, 0644);
> +module_param_named_unsafe(reset_method, amdgpu_reset_method, int, 0644);
>  
>  /**
>   * DOC: bad_page_threshold (int) Bad page threshold is specifies the
> @@ -1051,7 +1051,7 @@ module_param_named(seamless, amdgpu_seamless, int, 0444);
>   * - 0x4: Disable GPU soft recovery, always do a full reset
>   */
>  MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");
> -module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
> +module_param_named_unsafe(debug_mask, amdgpu_debug_mask, uint, 0444);
>  
>  /**
>   * DOC: agp (int)
> -- 
> 2.34.1
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
