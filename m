Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A65C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 08:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4487D10E2A7;
	Wed, 11 May 2022 08:05:32 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF3C10E2A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652256331; x=1683792331;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TcVjoXy5vY9Bv0ZyCLBpnY5CFJ5XOVlh4PR/9Hrengw=;
 b=RY3Qz9R8VBI1o+tCD0HSnrsiGLfaucKv4oKISzYj9HMuaL3zqIsHfNZS
 kDyijyjIiYAQ1gcMi0Uy3hKXO4zmTVEP6EWNvR7Zpsbw5dAw842ghWZZ1
 slu7QQU4SA/gBuHRiNtoFM17959aDNxI36vR0RhC+VhnLv3snRoS+9XCc
 s/bwQkrKovpYTd8dlbF2Vs9UqcxQnA7voPMVJXp0YmibCboIK1rkzuI2Z
 MQplr3gXC/TMsbc+YPX+A4EoXfaJHH8ShS2uTaIrZ7UV9zfO93kb9cLWl
 MqjcC8XP2TqR1un5UMCQQi67zk/FrcRT7zjv1mAwoUNfR5Fgnhe6gw3+m Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249523310"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; d="scan'208";a="249523310"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 01:05:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; d="scan'208";a="520416055"
Received: from mmlucey-mobl1.ger.corp.intel.com (HELO [10.213.195.130])
 ([10.213.195.130])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2022 01:05:29 -0700
Message-ID: <1264e910-bb36-25ae-c4d7-c42983e9b5c5@linux.intel.com>
Date: Wed, 11 May 2022 09:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] drm/amdgpu: add drm-client-id to fdinfo
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20220510165550.2048-1-christian.koenig@amd.com>
 <20220510165550.2048-2-christian.koenig@amd.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220510165550.2048-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/05/2022 17:55, Christian König wrote:
> This is enough to get gputop working :)

Super cool! So I guess it's time for me to cleanup that code base a bit.

Regards,

Tvrtko

> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 38cb5eb105ad..4ef23224b617 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -55,17 +55,15 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
>   
>   void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   {
> -	struct amdgpu_fpriv *fpriv;
>   	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
>   	struct drm_file *file = f->private_data;
>   	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
> +	struct amdgpu_fpriv *fpriv = file->driver_priv;
> +	struct amdgpu_vm *vm = &fpriv->vm;
>   	uint32_t bus, dev, fn, domain, hw_ip;
>   	struct amdgpu_bo *root;
>   	int ret;
>   
> -	ret = amdgpu_file_to_fpriv(f, &fpriv);
> -	if (ret)
> -		return;
>   	bus = adev->pdev->bus->number;
>   	domain = pci_domain_nr(adev->pdev->bus);
>   	dev = PCI_SLOT(adev->pdev->devfn);
> @@ -93,6 +91,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
>   	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
>   	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
>   			dev, fn, fpriv->vm.pasid);
> +	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
>   	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
>   	seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
>   	seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);
