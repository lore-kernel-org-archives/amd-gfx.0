Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCC9C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 12:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B080E11267D;
	Wed, 13 Jul 2022 12:44:13 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C6D11A7BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 12:43:56 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id va17so19704143ejb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IkGHyR6gHlpyja2iyPCoZnp/vlJRUt5XaOJA2dcswh8=;
 b=mdwrbDu4tvrbCrVz26JtQunv7aw7vrJgsauK1KyRqF+6+EOr6tRDJ4aUrPKgQHb22A
 AmiKArTx41vcmozot/ik2tyRbf8P83JCHQSuW3Y5BvnxXHATS+d8m9tC4qxgl4C2b6oq
 SGzz+SZ6ce/7yytYX6EWUqD7iWtwY1PDJUh+ZZQS1/9rWS2oJzVzVu45a+PXnL8Blw64
 GaYidQK+KynS9jZcBKUXShW9rTNJfxUnoi05yEqR9QPqCjldOAPKJllFVQK7seO5IVGs
 52wqQ1Fowp6iQNEONPdh2aVackVfgh9NACv3TXsPh1SzHSeKPTmLRyPPVP/FWNDUNA3h
 yhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IkGHyR6gHlpyja2iyPCoZnp/vlJRUt5XaOJA2dcswh8=;
 b=GcBFiQBwxwHe+bm9kF+NEqXEI+fi600Kh1gmQ0zugOX+ko6ujerTFkcLz1FKOckADo
 BCu2gS+5yLw6t0FfZs6xFgM9yG7D4Cl13BujYl5e84FLCU7T3vj72R9iH8KHIvF923Ah
 Hg8ODldyCqfwZoZj8b7quItXpNgWW7LVn1WWAFqHtzK7Oh0u7EtzVul/o98Kk9WjU8V+
 ehdvNWtB4nKrIwvONW+hJM0mZGsYtu7DcYHzKnW1cFlMYOwmqnzJsSSTzW3RmeLLpNXZ
 67tiX7nV+FpRMDoB2H7HycNbm2U6XTOadE9YAaa3S8AUHBc2Kt/uhbqHjEUf32xxkJxe
 fG4Q==
X-Gm-Message-State: AJIora9WVRFPfKO/EL+yjgQl+CDXY/VTXwemov9QIx3x/UHHKXctgKNM
 nC8Lq2J6WqD51LmyMDif89+4vFtoWlxYCyC+i1DxhkrV
X-Google-Smtp-Source: AGRyM1tD5baJ0MnlSCzDJFSJ19lkzdw9i397dbTTOmo5HmUVT4gtjaSZ+OC787Oe4LFYt1dSIa80T2ZrkXXByTZOmKQ=
X-Received: by 2002:a17:906:5d0b:b0:726:a043:fcb4 with SMTP id
 g11-20020a1709065d0b00b00726a043fcb4mr3239550ejt.508.1657716234816; Wed, 13
 Jul 2022 05:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220713091426.938701-1-shikai.guo@amd.com>
In-Reply-To: <20220713091426.938701-1-shikai.guo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Jul 2022 08:43:43 -0400
Message-ID: <CADnq5_P2v_=Uh2bwQ2BoTSFAehV+rvwa2hdjTOWrhRv6uWRD9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on APU
 ASIC
To: shikai guo <shikai.guo@amd.com>
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, "Ji, Ruili" <ruili.ji@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 5:14 AM shikai guo <shikai.guo@amd.com> wrote:
>
> From: Shikai Guo <Shikai.Guo@amd.com>
>
> While executing KFDMemoryTest.MMBench, test case will allocate 4KB size memory 1000 times.
> Every time, user space will get 2M memory.APU VRAM is 512M, there is not enough memory to be allocated.
> So the 2M aligned feature is not suitable for APU.

Wouldn't it be better to decide based on vram size rather than APU vs
dGPU?  some APUs have large carve outs.

Alex

>
> guoshikai@guoshikai-MayanKD-RMB:~/linth/libhsakmt/tests/kfdtest/build$ ./kfdtest --gtest_filter=KFDMemoryTest.MMBench
> [          ] Profile: Full Test
> [          ] HW capabilities: 0x9
> Note: Google Test filter = KFDMemoryTest.MMBench
> [==========] Running 1 test from 1 test case.
> [----------] Global test environment set-up.
> [----------] 1 test from KFDMemoryTest
> [ RUN      ] KFDMemoryTest.MMBench
> [          ] Found VRAM of 512MB.
> [          ] Available VRAM 328MB.
> [          ] Test (avg. ns)         alloc   mapOne  umapOne   mapAll  umapAll     free
> [          ] --------------------------------------------------------------------------
> [          ]   4K-SysMem-noSDMA     26561    10350     5212     3787     3981    12372
> [          ]  64K-SysMem-noSDMA     42864     6648     3973     5223     3843    15100
> [          ]   2M-SysMem-noSDMA    312906    12614     4390     6254     4790    70260
> [          ]  32M-SysMem-noSDMA   4417812   130437    21625    97687    18500   929562
> [          ]   1G-SysMem-noSDMA 132161000  2738000   583000  2181000   499000 39091000
> [          ] --------------------------------------------------------------------------
> /home/guoshikai/linth/libhsakmt/tests/kfdtest/src/KFDMemoryTest.cpp:922: Failure
> Value of: (hsaKmtAllocMemory(allocNode, bufSize, memFlags, &bufs[i]))
>   Actual: 6
> Expected: HSAKMT_STATUS_SUCCESS
> Which is: 0
> [  FAILED  ] KFDMemoryTest.MMBench (749 ms)
>
> fix this issue by adding different treatments for apu and dgpu
>
> Signed-off-by: ruili ji <ruili.ji@amd.com>
> Signed-off-by: shikai guo <shikai.guo@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d1657de5f875..2ad2cd5e3e8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -115,7 +115,9 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>   * compromise that should work in most cases without reserving too
>   * much memory for page tables unnecessarily (factor 16K, >> 14).
>   */
> -#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
> +
> +#define ESTIMATE_PT_SIZE(adev, mem_size)   (adev->flags & AMD_IS_APU) ? \
> +                (mem_size >> 14) : max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
>
>  static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>  {
> @@ -142,7 +144,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>                 uint64_t size, u32 alloc_flag)
>  {
>         uint64_t reserved_for_pt =
> -               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +               ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
>         size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
>         int ret = 0;
>
> @@ -156,12 +158,15 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>                 system_mem_needed = acc_size;
>                 ttm_mem_needed = acc_size;
>
> +               if (adev->flags & AMD_IS_APU)
> +                       vram_needed = size;
> +               else
>                 /*
>                  * Conservatively round up the allocation requirement to 2 MB
>                  * to avoid fragmentation caused by 4K allocations in the tail
>                  * 2M BO chunk.
>                  */
> -               vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +                       vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
>         } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                 system_mem_needed = acc_size + size;
>                 ttm_mem_needed = acc_size;
> @@ -220,7 +225,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>         } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>                 kfd_mem_limit.system_mem_used -= acc_size;
>                 kfd_mem_limit.ttm_mem_used -= acc_size;
> -               adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +               if (adev->flags & AMD_IS_APU)
> +                       adev->kfd.vram_used -= size;
> +               else
> +                       adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>         } else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>                 kfd_mem_limit.system_mem_used -= (acc_size + size);
>                 kfd_mem_limit.ttm_mem_used -= acc_size;
> @@ -1666,7 +1674,7 @@ int amdgpu_amdkfd_criu_resume(void *p)
>  size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>  {
>         uint64_t reserved_for_pt =
> -               ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +               ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
>         size_t available;
>
>         spin_lock(&kfd_mem_limit.mem_limit_lock);
> --
> 2.25.1
>
