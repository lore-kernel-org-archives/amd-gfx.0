Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5E0C7619A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 07:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916DC10E725;
	Wed, 12 Apr 2023 07:58:32 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A6510E725
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 07:58:29 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f080fc6994so3119165e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1681286308;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8A/SdeLvzFiYWycVM7MmZyG7MQLHn+W0oQ+tEHhex8=;
 b=T/Wb7YjU5aBuJVC5H/Le0QeASrsAM5Y+Yz4YbR8hkU8w/0XnLd0rasqnJ7hGRdVC8P
 oppzMr8zvT/CfGiKFIVFq2l7bHIxgr06UTo06lCuME6VIF+ci/4/PwuUXDdiLOuq58Q3
 HG7bqLqHDcPnvUUTZ2CBWqpJTK4+5dCWOUOHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681286308;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8A/SdeLvzFiYWycVM7MmZyG7MQLHn+W0oQ+tEHhex8=;
 b=jws/hXXYXVvMHWW8WfcXl8Ut/+OG9YfVt1HA8ze5MyLdJFOQA3uj2TaneVhtP2zjpA
 B1UsktinfnJD7gqAdqtEJUPojeASApXDxUxRTNgWy1n/hJepeneIufY2gZoGaflqdbgV
 TC7FEdLpVN6AcIDX7zqP51ktPhuIRTW7SS0VusxkFtVGJHK9XbL7pSWluGIIZqXbaLe9
 6F2FbLr7j8p2k8/lLTOiZWRXrWV8B9MsvRxWasVjBl9VY2qb4QtGpRs1EcGsvc5NQ1aw
 tvxKc0gGEMFniLupO+sef2GS0QLo62awp0hWSXs8M2+mSiS1hdXmbtR8GulUNQJ3dLfJ
 Wf1w==
X-Gm-Message-State: AAQBX9eS60naeMc6n7fbc1VFKMkBx5q03N3VBQm1AeWujYYsmi6NcNgs
 nD+S0E1WdowuU8HTk9QVu4ChXw==
X-Google-Smtp-Source: AKy350ZsIHrp1fkw9kWTIB5j/yWw6Pd5Y3Xkw3e/8LffjM8p8HeHcKd/6YPLn/zhuKWDt5SRtcMz6A==
X-Received: by 2002:a05:600c:c0e:b0:3f0:7652:dbb8 with SMTP id
 fm14-20020a05600c0c0e00b003f07652dbb8mr1328269wmb.2.1681286308313; 
 Wed, 12 Apr 2023 00:58:28 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c028600b003ee0d191539sm1457785wmk.10.2023.04.12.00.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Apr 2023 00:58:27 -0700 (PDT)
Date: Wed, 12 Apr 2023 09:58:25 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v3 3/7] drm/amdgpu: Switch to fdinfo helper
Message-ID: <ZDZkocmppPAGdkdv@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Christopher Healy <healych@amazon.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Rob Clark <robdclark@chromium.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Guchun Chen <guchun.chen@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20230411225725.2032862-1-robdclark@gmail.com>
 <20230411225725.2032862-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411225725.2032862-4-robdclark@gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
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
Cc: dri-devel@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <mdaenzer@redhat.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Rob Clark <robdclark@chromium.org>,
 Guchun Chen <guchun.chen@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 linux-arm-msm@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@intel.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Christopher Healy <healych@amazon.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 freedreno@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 11, 2023 at 03:56:08PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 16 ++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |  2 +-
>  3 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index f5ffca24def4..3611cfd5f076 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2752,7 +2752,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>  	.compat_ioctl = amdgpu_kms_compat_ioctl,
>  #endif
>  #ifdef CONFIG_PROC_FS
> -	.show_fdinfo = amdgpu_show_fdinfo
> +	.show_fdinfo = drm_fop_show_fdinfo,
>  #endif
>  };
>  
> @@ -2807,6 +2807,7 @@ static const struct drm_driver amdgpu_kms_driver = {
>  	.dumb_map_offset = amdgpu_mode_dumb_mmap,
>  	.fops = &amdgpu_driver_kms_fops,
>  	.release = &amdgpu_driver_release_kms,
> +	.show_fdinfo = amdgpu_show_fdinfo,
>  
>  	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 99a7855ab1bc..c2fdd5e448d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -53,9 +53,8 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>  	[AMDGPU_HW_IP_VCN_JPEG]	=	"jpeg",
>  };
>  
> -void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
> +void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>  {
> -	struct drm_file *file = f->private_data;
>  	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
>  	struct amdgpu_fpriv *fpriv = file->driver_priv;
>  	struct amdgpu_vm *vm = &fpriv->vm;
> @@ -86,18 +85,15 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>  	 * ******************************************************************
>  	 */
>  
> -	seq_printf(m, "pasid:\t%u\n", fpriv->vm.pasid);
> -	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
> -	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
> -	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
> -	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
> -	seq_printf(m, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
> -	seq_printf(m, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
> +	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> +	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
> +	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
> +	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);

random aside, but we're not super consistent here, some of these have an
additional ' ' space.

I guess a next step would be a drm_fdinfo_printf(drm_printer *p, const
char *name, const char *printf, ...) and maybe some specialized ones that
dtrt for specific parameters, like drm_fdinfo_llu().

But that's for next one I guess :-)
-Daniel


>  	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>  		if (!usage[hw_ip])
>  			continue;
>  
> -		seq_printf(m, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
> +		drm_printf(p, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
>  			   ktime_to_ns(usage[hw_ip]));
>  	}
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> index e86834bfea1d..0398f5a159ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
> @@ -37,6 +37,6 @@
>  #include "amdgpu_ids.h"
>  
>  uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id);
> -void amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
> +void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file);
>  
>  #endif
> -- 
> 2.39.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
