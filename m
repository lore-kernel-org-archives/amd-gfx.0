From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Wed, 23 Jan 2019 08:44:28 -0800
Message-ID: <20190123164428.GA9367@infradead.org>
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Michael Ellerman <mpe@ellerman.id.au>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Junwei Zhang <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

I think we just want a driver-local check for those combinations
where we know this hack actually works, which really just seems
to be x86-64 with PAT. Something like the patch below, but maybe with
even more strong warnings to not do something like this elsewhere:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 728e15e5d68a..5fe657f20232 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -456,33 +456,16 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 
 	bo->flags = bp->flags;
 
-#ifdef CONFIG_X86_32
-	/* XXX: Write-combined CPU mappings of GTT seem broken on 32-bit
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=84627
-	 */
-	bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
-	/* Don't try to enable write-combining when it can't work, or things
-	 * may be slow
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
-	 */
-
-#ifndef CONFIG_COMPILE_TEST
-#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
-	 thanks to write-combining
-#endif
-
-	if (bo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
-		DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
-			      "better performance thanks to write-combining\n");
-	bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-#else
-	/* For architectures that don't support WC memory,
-	 * mask out the WC flag from the BO
+	/*
+	 * Don't try to enable write-combined CPU mappings unless we 100%
+	 * positively know it works, otherwise there may be dragons.
+	 *
+	 * See:
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=88758
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=84627
 	 */
-	if (!drm_arch_can_wc_memory())
+	if (!(IS_ENABLED(CONFIG_X86_64) && IS_ENABLED(CONFIG_X86_PAT)))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-#endif
 
 	bo->tbo.bdev = &adev->mman.bdev;
 	amdgpu_bo_placement_from_domain(bo, bp->domain);
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 833e909706a9..c1fb5ad4ab9a 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -226,32 +226,17 @@ int radeon_bo_create(struct radeon_device *rdev,
 	if (rdev->family >= CHIP_RV610 && rdev->family <= CHIP_RV635)
 		bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
 
-#ifdef CONFIG_X86_32
-	/* XXX: Write-combined CPU mappings of GTT seem broken on 32-bit
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=84627
-	 */
-	bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
-#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
-	/* Don't try to enable write-combining when it can't work, or things
-	 * may be slow
-	 * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
-	 */
-#ifndef CONFIG_COMPILE_TEST
-#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
-	 thanks to write-combining
-#endif
 
-	if (bo->flags & RADEON_GEM_GTT_WC)
-		DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
-			      "better performance thanks to write-combining\n");
-	bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
-#else
-	/* For architectures that don't support WC memory,
-	 * mask out the WC flag from the BO
+	/*
+	 * Don't try to enable write-combined CPU mappings unless we 100%
+	 * positively know it works, otherwise there may be dragons.
+	 *
+	 * See:
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=88758
+	 *  - https://bugs.freedesktop.org/show_bug.cgi?id=84627
 	 */
-	if (!drm_arch_can_wc_memory())
-		bo->flags &= ~RADEON_GEM_GTT_WC;
-#endif
+	if (!(IS_ENABLED(CONFIG_X86_64) && IS_ENABLED(CONFIG_X86_PAT)))
+		bo->flags &= ~(RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC);
 
 	radeon_ttm_placement_from_domain(bo, domain);
 	/* Kernel allocation are uninterruptible */
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index bfe1639df02d..6c3960f4c477 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -40,16 +40,4 @@ void drm_clflush_sg(struct sg_table *st);
 void drm_clflush_virt_range(void *addr, unsigned long length);
 u64 drm_get_max_iomem(void);
 
-
-static inline bool drm_arch_can_wc_memory(void)
-{
-#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
-	return false;
-#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
-	return false;
-#else
-	return true;
-#endif
-}
-
 #endif
