Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1A5C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 15:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DF710E0D6;
	Fri, 10 Jun 2022 15:44:41 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3220E10E0D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 15:44:40 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id y69so22219781oia.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VLLGPdRlJzz+nJLi22WDfEbBtdqOhCFHl5WMBAsz5js=;
 b=TeW6gorf7ZyTA1apwILrT4w5dfohe0o2GKXyn1kgFD/jeLANAY1CdfBHl6ZCzk40BD
 Ql17Yft/jbcTEsMXulU3REJMAZ7t6tBxQz3diChBSjvcg7cN1YPunt/rJqd0Dc88MaiW
 71RN1Mk5hxhLZvZUqJtX16R+hG612mCWnJed3CuK2zQPxgNuIT0pVdJ4mEvkVhb821n4
 oQwAk4Z25Zh/TKgs3RW0GtCgaYB535tGTFamkITfWy+1qP7lq1l2OHeyPqQLLng/M6HU
 63inLcoIZWEbbfOOGrVjH6JuR/dXleZnFP8PLzkUhJA0an3jA4tzitQb/k03HWiWDNhQ
 7NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VLLGPdRlJzz+nJLi22WDfEbBtdqOhCFHl5WMBAsz5js=;
 b=Ycfo4eB85fwJPmOXmmwux4eA/+qPRwflkhCOyETNH8WqQF8P2pJTL6GCJFyvFdqBAt
 ZalIsXBXgo3/C/DNAaTIX8+wbtaV26wTzM/LMdEbVosgO8wouYvldyq7SxTOFXLcQfB9
 dgWMW5MBGqginR+YYRmm+getSXVPeHDkUdku9OBH9D0dmvxkmrMk8J1E03dikkp0JXRS
 lvPcm5IyCxKaP5KW1DzEFtrfb9SxUfV/oOgn7w+Mqjc6k1V7CsDrLQMSsudpUMfn+9QY
 R4QF+5eXK88BrtXdkZhjYsKHSPyQi4X5TyF84EzF5pTJuCoBoKANwQXE5sfxvuWVZ7DN
 C8Mg==
X-Gm-Message-State: AOAM533Tw0FlFrbKMrpO+m3QFoNlehO2g57Q+f22v1VmTrz0t3Ij/Qfq
 uOHHSUoFefai8tjwri4IbwBXhVD5SSmlQH0ux9As0w3z
X-Google-Smtp-Source: ABdhPJyG8oJn4cE6R9CviYcWF5UiTw/4oX/6eS171FhGnvU8sDh0tdDf7T4B4U5CCx/pDwzAiTCbDVBYv9rhSlvI118=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr226290oiu.200.1654875879423; Fri, 10
 Jun 2022 08:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220610154247.338073-1-alexander.deucher@amd.com>
 <20220610154247.338073-2-alexander.deucher@amd.com>
In-Reply-To: <20220610154247.338073-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jun 2022 11:44:28 -0400
Message-ID: <CADnq5_NAmo5kT5mq-FFhosNyBG6JtsYWCAKnykUinsr43m5Lww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix warning when CONFIG_HSA_AMD_P2P is not set
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 10, 2022 at 11:43 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11:
> warning: variable 'i' set but not used [-Wunused-but-set-variable]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 4 ++++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 +++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index aebc384531ac..88a0e3ac0f33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -773,6 +773,10 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>   */
>  uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr)
>  {
> +       dev_info(adev->dev, "amdgpu_gmc_vram_mc2pa: 0x%0llx, 0x%0llx, 0x%0llx\n",
> +                mc_addr,
> +                adev->gmc.vram_start,
> +                adev->vm_manager.vram_base_offset);
>         return mc_addr - adev->gmc.vram_start + adev->vm_manager.vram_base_offset;
>  }

Ignore this hunk.  Didn't mean to commit this.

Alex

>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3e240b22ec91..411447357196 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1539,7 +1539,10 @@ static int kfd_dev_create_p2p_links(void)
>  {
>         struct kfd_topology_device *dev;
>         struct kfd_topology_device *new_dev;
> -       uint32_t i, k;
> +#if defined(CONFIG_HSA_AMD_P2P)
> +       uint32_t i;
> +#endif
> +       uint32_t k;
>         int ret = 0;
>
>         k = 0;
> @@ -1553,7 +1556,6 @@ static int kfd_dev_create_p2p_links(void)
>                 return 0;
>
>         k--;
> -       i = 0;
>
>         /* create in-direct links */
>         ret = kfd_create_indirect_link_prop(new_dev, k);
> @@ -1562,6 +1564,7 @@ static int kfd_dev_create_p2p_links(void)
>
>         /* create p2p links */
>  #if defined(CONFIG_HSA_AMD_P2P)
> +       i = 0;
>         list_for_each_entry(dev, &topology_device_list, list) {
>                 if (dev == new_dev)
>                         break;
> --
> 2.35.3
>
