Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776E9CD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 17:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6FB1134DA;
	Fri,  5 Jun 2026 17:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sw8ZLpni";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3735A1134DE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 17:54:25 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-137c0db2638so176636c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 10:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682064; cv=none;
 d=google.com; s=arc-20240605;
 b=XXejii2OEh70JchYIRu/jro0xKdngNwVG8JJh4DMMYLW4ly90hBbgKQ9NDpfnoBq4T
 UfE5VBOD6JyP+cEi7KpZboBENUUtme532GRuNPq5vDO2QJqprFBvaBo4eir5i+2/Le7K
 p7/KagtUo05YM0HSwq7Jtk0UKrNArzDZTRfw3q47TSBV1fPpqh0PB6SquamHXwxGnr3W
 LWvknPKUfh5OuxFPy0AHf16YElFMW2uZRub001aP+cunTA527/0NQBFvBYlgCy31aZxD
 6O9zjgmUh1uiFOY8cRmX2WeooSoxP8TVrgy/544qI8sMSGQDmiFrwxWToMq4hCl7SlEi
 UyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zOo123FoBYPUpj7eJcCqtPhAz2Sywv3HZ22YVglexmM=;
 fh=H/VfgC4cZPyU8hANrSoOA2UIZImS8Otn1ShIpKh6jhI=;
 b=K+XVGn89ZphotFnLbv1vrqzEUwfH4xsnPUsK+/se1OUXHUUnTb7L8v16vUHbP9mLjE
 CJPpM9wOTYTReXF0rfMcO5gVwuaG1amCv/3PUHuJE/n06Igxlp8KdP2hIJkyXfkhco3p
 kuglxzMtW8me3u9o64XqsSXi0gJ5G3SV0tf9Hujx9A2fc+vpchb5FCWSttLC3i2gtH2o
 EOVPtpiu48TTc451EhMpukDuVQr9mbpGhCo9qwuh9/V0nJB9CcQ8cah5RXrfhFOMfM24
 LVXofnQQ2vcgYSkqPcxvbhBUgPDDyvHQwL9FeG0jN2OyQyxV4SDoZ/XpXcWqxsuX0H15
 Q6RA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780682064; x=1781286864; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOo123FoBYPUpj7eJcCqtPhAz2Sywv3HZ22YVglexmM=;
 b=Sw8ZLpni+6Tr/J75/5jioHeWnPPpEvA0nJJsq77b8DTlGTEMMSAUXatY58pzrLW6iA
 bNBYedXoWZEgwfeCAGHKYJeUhA6QvXDWIKAT2b2jakg9eI4tiL3iyYltj1OZ2y+JWfNx
 lAnxXrq6+wkrA5fTbxX42caGRAFK7+PNSPhtnOvulicGlGByhPc8o22f8OWSAAIu8PVl
 aGMvNiWa4/xP+KrN1j2M/9iGY0withcbtmNKUWESeVrmGO71D6UaVgGJl9nwHPgTxzul
 cw5W/6eovkvmMh3mXvV8rVoqUf6LniUIZBdYevL/ygmBsmrQ56NnGdTJG0D99MMotNGi
 cxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780682064; x=1781286864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zOo123FoBYPUpj7eJcCqtPhAz2Sywv3HZ22YVglexmM=;
 b=h9oJ2XBvpxXeFnhm4I4khti73Li/7Pkdkg/ZVUmq/Zup7r64k9JoyGKs7dLCnwgMAm
 qTQZqKRCWG3j0awSPLsZLo8BAc++ZJ27ID0w60ee1gIUN3lSUOb6QtcUXEl8UvAm22kB
 uUoT3mh4mksbWZwRuYYMnF/a6kk//E7iJ+zH/Fi+Hw6C1y0h5+MXLNksSWjNzxHLwVGH
 AfeV/lTVHNkJ469W7JsgAR+bbfzVg7Ly06ZC2AVI+0Sz1K/LlbZmNEaRwHwyHWj1Qltn
 NfBQ4LL0F1IJah3bkIs1bqYsfjP7TkIl4w2RrOfg9Uom/NpDDwZj2dclLx7fN2azCJ/V
 iYWg==
X-Gm-Message-State: AOJu0YwMx3RiARzSX7eizE+f4HS9Hd/a8RE7Ot4f/oI9nK5F3tUyUnmY
 n5DRtzFvsctw1TiZxBRHmIEjhuUmoVhp6SKpg2qgnJl3rXOYi/xouf4AJ5rM+x2r6mH0VEQQPkM
 cycH7Bg9DYF9WEOU+Vr/v0irelL5/xiYcjw==
X-Gm-Gg: Acq92OGTwPgxoo0I9e9fqXIs40d4f70uzmz2fIsgj3Sjec2pk/9QCzFF7zVKrQIbVNz
 xJrBTeMRkDWPsOhdikkl3acf9Ryn7nGY/oZRLY/c4LZt1QbAeglTuRrFlmSVfxWWdHzoGrb0AXN
 Bu0n/E/UTeTLNjl8DSBRH0b9+u/QG6DtQq8EW8xxm/7vPcJD9KiyPkGABvfxpP1e+Go/7u796Zl
 qumJELdJY8tzDgZjKGKKbBlPiKgji3lk9W+jrI9U3dYi3lCZ5L/9wgUmoEbUmxqCFQACSEFV566
 68kwA6YJ33SsoEh0HmrJXuGVKQM/ElVjGQVYRVhktrdMc7wYlXF4Oq7/lhPyjMVqLQmlHiY0VDC
 ofiit
X-Received: by 2002:a05:7022:4199:b0:127:def:dd72 with SMTP id
 a92af1059eb24-13806712d79mr871495c88.2.1780682064054; Fri, 05 Jun 2026
 10:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
 <20260605134400.956791-12-shahyan.soltani@amd.com>
In-Reply-To: <20260605134400.956791-12-shahyan.soltani@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 13:54:12 -0400
X-Gm-Features: AVHnY4Ls8AYc07A0XA3xkZgmNODgKWS7qFxU6STTOA-s78i1Z_874Y0whPUZ79g
Message-ID: <CADnq5_PRWZotnMjeqY6pouCqO_wEHNzs6zpNhtcc=jwH-YTnbA@mail.gmail.com>
Subject: Re: [PATCH 11/11] drm/amdgpu: move struct amdgpu_device and helpers
 into new header
To: Shahyan Soltani <shahyan.soltani@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 5, 2026 at 9:54=E2=80=AFAM Shahyan Soltani <shahyan.soltani@amd=
.com> wrote:
>
> Move struct amdgpu_device, struct amdgpu_mem_scratch, struct amdgpu_mmio_=
remap,
> struct amdgpu_powerplay, struct amdgpu_pcie_reset_ctx, and relevant helpe=
rs
> from the monolithic amdgpu.h file into a new amdgpu_device.h file.
>
> This is part of the ongoing effort to reduce the size of amdgpu.h into th=
eir own respective
> separate headers.
>

I think you can drop patches 10 and 11.  These are sort of the core
structures that amdgpu.h should be used for.

Alex

> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 484 +----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.h | 586 +++++++++++++++++++++
>  2 files changed, 590 insertions(+), 480 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_device.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 812bd0f6ff0d..0ce37fc213cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -120,6 +120,7 @@
>  #include "amdgpu_uid.h"
>  #include "amdgpu_video_codecs.h"
>  #include "amdgpu_asic.h"
> +#include "amdgpu_device.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -429,400 +430,15 @@ int amdgpu_cs_wait_ioctl(struct drm_device *dev, v=
oid *data, struct drm_file *fi
>  int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
>                                 struct drm_file *filp);
>
> -/* VRAM scratch page for HDP bug, default vram page */
> -struct amdgpu_mem_scratch {
> -       struct amdgpu_bo                *robj;
> -       uint32_t                        *ptr;
> -       u64                             gpu_addr;
> -};
> -
>  /*
>   * CGS
>   */
>  struct cgs_device *amdgpu_cgs_create_device(struct amdgpu_device *adev);
>  void amdgpu_cgs_destroy_device(struct cgs_device *cgs_device);
>
> -/*
> - * Core structure, functions and helpers.
> - */
> -struct amdgpu_mmio_remap {
> -       u32 reg_offset;
> -       resource_size_t bus_addr;
> -       struct amdgpu_bo *bo;
> -};
> -
> -struct amd_powerplay {
> -       void *pp_handle;
> -       const struct amd_pm_funcs *pp_funcs;
> -};
> -
> -struct amdgpu_pcie_reset_ctx {
> -       bool in_link_reset;
> -       bool occurs_dpc;
> -       bool audio_suspended;
> -       struct pci_dev *swus;
> -       struct pci_saved_state *swus_pcistate;
> -       struct pci_saved_state *swds_pcistate;
> -};
> -
> -#define AMDGPU_RESET_MAGIC_NUM 64
> -#define AMDGPU_MAX_DF_PERFMONS 4
>  struct amdgpu_reset_domain;
>  struct amdgpu_fru_info;
>
> -enum amdgpu_enforce_isolation_mode {
> -       AMDGPU_ENFORCE_ISOLATION_DISABLE =3D 0,
> -       AMDGPU_ENFORCE_ISOLATION_ENABLE =3D 1,
> -       AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY =3D 2,
> -       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER =3D 3,
> -};
> -
> -struct amdgpu_device {
> -       struct device                   *dev;
> -       struct pci_dev                  *pdev;
> -       struct drm_device               ddev;
> -
> -#ifdef CONFIG_DRM_AMD_ACP
> -       struct amdgpu_acp               acp;
> -#endif
> -       struct amdgpu_hive_info *hive;
> -       struct amdgpu_xcp_mgr *xcp_mgr;
> -       /* ASIC */
> -       enum amd_asic_type              asic_type;
> -       uint32_t                        family;
> -       uint32_t                        rev_id;
> -       uint32_t                        external_rev_id;
> -       unsigned long                   flags;
> -       unsigned long                   apu_flags;
> -       int                             usec_timeout;
> -       const struct amdgpu_asic_funcs  *asic_funcs;
> -       bool                            shutdown;
> -       bool                            need_swiotlb;
> -       bool                            accel_working;
> -       struct notifier_block           acpi_nb;
> -       struct notifier_block           pm_nb;
> -       struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> -       struct debugfs_blob_wrapper debugfs_vbios_blob;
> -       struct mutex                    srbm_mutex;
> -       /* GRBM index mutex. Protects concurrent access to GRBM index */
> -       struct mutex                    grbm_idx_mutex;
> -       struct dev_pm_domain            vga_pm_domain;
> -       bool                            have_disp_power_ref;
> -       bool                            have_atomics_support;
> -
> -       /* BIOS */
> -       bool                            is_atom_fw;
> -       uint8_t                         *bios;
> -       uint32_t                        bios_size;
> -       uint32_t                        bios_scratch_reg_offset;
> -       uint32_t                        bios_scratch[AMDGPU_BIOS_NUM_SCRA=
TCH];
> -
> -       /* Register/doorbell mmio */
> -       resource_size_t                 rmmio_base;
> -       resource_size_t                 rmmio_size;
> -       void __iomem                    *rmmio;
> -       /* protects concurrent MM_INDEX/DATA based register access */
> -       spinlock_t mmio_idx_lock;
> -       struct amdgpu_mmio_remap        rmmio_remap;
> -       /* Indirect register access blocks */
> -       struct amdgpu_reg_access reg;
> -       struct amdgpu_doorbell          doorbell;
> -
> -       /* clock/pll info */
> -       struct amdgpu_clock            clock;
> -
> -       /* MC */
> -       struct amdgpu_gmc               gmc;
> -       struct amdgpu_gart              gart;
> -       dma_addr_t                      dummy_page_addr;
> -       struct amdgpu_vm_manager        vm_manager;
> -       struct amdgpu_vmhub             vmhub[AMDGPU_MAX_VMHUBS];
> -       DECLARE_BITMAP(vmhubs_mask, AMDGPU_MAX_VMHUBS);
> -
> -       /* memory management */
> -       struct amdgpu_mman              mman;
> -       struct amdgpu_mem_scratch       mem_scratch;
> -       struct amdgpu_wb                wb;
> -       atomic64_t                      num_bytes_moved;
> -       atomic64_t                      num_evictions;
> -       atomic64_t                      num_vram_cpu_page_faults;
> -       atomic_t                        gpu_reset_counter;
> -       atomic_t                        vram_lost_counter;
> -
> -       /* data for buffer migration throttling */
> -       struct {
> -               spinlock_t              lock;
> -               s64                     last_update_us;
> -               s64                     accum_us; /* accumulated microsec=
onds */
> -               s64                     accum_us_vis; /* for visible VRAM=
 */
> -               u32                     log2_max_MBps;
> -       } mm_stats;
> -
> -       /* discovery*/
> -       struct amdgpu_discovery_info discovery;
> -
> -       /* display */
> -       bool                            enable_virtual_display;
> -       struct amdgpu_vkms_output       *amdgpu_vkms_output;
> -       struct amdgpu_mode_info         mode_info;
> -       /* For pre-DCE11. DCE11 and later are in "struct amdgpu_device->d=
m" */
> -       struct delayed_work         hotplug_work;
> -       struct amdgpu_irq_src           crtc_irq;
> -       struct amdgpu_irq_src           vline0_irq;
> -       struct amdgpu_irq_src           vupdate_irq;
> -       struct amdgpu_irq_src           pageflip_irq;
> -       struct amdgpu_irq_src           hpd_irq;
> -       struct amdgpu_irq_src           dmub_trace_irq;
> -       struct amdgpu_irq_src           dmub_outbox_irq;
> -
> -       /* rings */
> -       u64                             fence_context;
> -       unsigned                        num_rings;
> -       struct amdgpu_ring              *rings[AMDGPU_MAX_RINGS];
> -       struct dma_fence __rcu          *gang_submit;
> -       bool                            ib_pool_ready;
> -       struct amdgpu_sa_manager        ib_pools[AMDGPU_IB_POOL_MAX];
> -       struct amdgpu_sched             gpu_sched[AMDGPU_HW_IP_NUM][AMDGP=
U_RING_PRIO_MAX];
> -
> -       /* interrupts */
> -       struct amdgpu_irq               irq;
> -
> -       /* powerplay */
> -       struct amd_powerplay            powerplay;
> -       struct amdgpu_pm                pm;
> -       u64                             cg_flags;
> -       u32                             pg_flags;
> -
> -       /* nbio */
> -       struct amdgpu_nbio              nbio;
> -
> -       /* hdp */
> -       struct amdgpu_hdp               hdp;
> -
> -       /* smuio */
> -       struct amdgpu_smuio             smuio;
> -
> -       /* mmhub */
> -       struct amdgpu_mmhub             mmhub;
> -
> -       /* gfxhub */
> -       struct amdgpu_gfxhub            gfxhub;
> -
> -       /* gfx */
> -       struct amdgpu_gfx               gfx;
> -
> -       /* sdma */
> -       struct amdgpu_sdma              sdma;
> -
> -       /* lsdma */
> -       struct amdgpu_lsdma             lsdma;
> -
> -       /* uvd */
> -       struct amdgpu_uvd               uvd;
> -
> -       /* vce */
> -       struct amdgpu_vce               vce;
> -
> -       /* vcn */
> -       struct amdgpu_vcn               vcn;
> -
> -       /* jpeg */
> -       struct amdgpu_jpeg              jpeg;
> -
> -       /* vpe */
> -       struct amdgpu_vpe               vpe;
> -
> -       /* umsch */
> -       struct amdgpu_umsch_mm          umsch_mm;
> -       bool                            enable_umsch_mm;
> -
> -       /* firmwares */
> -       struct amdgpu_firmware          firmware;
> -
> -       /* PSP */
> -       struct psp_context              psp;
> -
> -       /* GDS */
> -       struct amdgpu_gds               gds;
> -
> -       /* for userq and VM fences */
> -       struct amdgpu_seq64             seq64;
> -
> -       /* UMC */
> -       struct amdgpu_umc               umc;
> -
> -       /* display related functionality */
> -       struct amdgpu_display_manager dm;
> -
> -#if defined(CONFIG_DRM_AMD_ISP)
> -       /* isp */
> -       struct amdgpu_isp               isp;
> -#endif
> -
> -       /* mes */
> -       bool                            enable_mes;
> -       bool                            enable_mes_kiq;
> -       bool                            enable_uni_mes;
> -       struct amdgpu_mes               mes;
> -       struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
> -       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
> -
> -       /**
> -        * @userq_doorbell_xa: Global user queue map (doorbell index =E2=
=86=92 queue)
> -        * Key: doorbell_index (unique global identifier for the queue)
> -        * Value: struct amdgpu_usermode_queue
> -        */
> -       struct xarray userq_doorbell_xa;
> -
> -       /* df */
> -       struct amdgpu_df                df;
> -
> -       /* MCA */
> -       struct amdgpu_mca               mca;
> -
> -       /* ACA */
> -       struct amdgpu_aca               aca;
> -
> -       /* CPER */
> -       struct amdgpu_cper              cper;
> -
> -       struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
> -       uint32_t                        harvest_ip_mask;
> -       int                             num_ip_blocks;
> -       struct mutex    mn_lock;
> -       DECLARE_HASHTABLE(mn_hash, 7);
> -
> -       /* tracking pinned memory */
> -       atomic64_t vram_pin_size;
> -       atomic64_t visible_pin_size;
> -       atomic64_t gart_pin_size;
> -
> -       /* soc15 register offset based on ip, instance and  segment */
> -       uint32_t                *reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
> -       struct amdgpu_ip_map_info       ip_map;
> -
> -       /* delayed work_func for deferring clockgating during resume */
> -       struct delayed_work     delayed_init_work;
> -
> -       struct amdgpu_virt      virt;
> -
> -       /* record hw reset is performed */
> -       bool has_hw_reset;
> -       u8                              reset_magic[AMDGPU_RESET_MAGIC_NU=
M];
> -
> -       /* s3/s4 mask */
> -       bool                            in_suspend;
> -       bool                            in_s3;
> -       bool                            in_s4;
> -       bool                            in_s0ix;
> -       suspend_state_t                 last_suspend_state;
> -
> -       enum pp_mp1_state               mp1_state;
> -       struct amdgpu_doorbell_index doorbell_index;
> -
> -       struct mutex                    notifier_lock;
> -
> -       int asic_reset_res;
> -       struct work_struct              xgmi_reset_work;
> -       struct list_head                reset_list;
> -
> -       long                            gfx_timeout;
> -       long                            sdma_timeout;
> -       long                            video_timeout;
> -       long                            compute_timeout;
> -       long                            psp_timeout;
> -
> -       uint64_t                        unique_id;
> -       uint8_t                         unitid;
> -       uint64_t        df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFM=
ONS];
> -
> -       /* enable runtime pm on the device */
> -       bool                            in_runpm;
> -       bool                            has_pr3;
> -
> -       bool                            ucode_sysfs_en;
> -
> -       struct amdgpu_fru_info          *fru_info;
> -       atomic_t                        throttling_logging_enabled;
> -       struct ratelimit_state          throttling_logging_rs;
> -       uint32_t                        ras_hw_enabled;
> -       uint32_t                        ras_enabled;
> -       bool                            ras_default_ecc_enabled;
> -
> -       bool                            no_hw_access;
> -       struct pci_saved_state          *pci_state;
> -       pci_channel_state_t             pci_channel_state;
> -
> -       struct amdgpu_pcie_reset_ctx    pcie_reset_ctx;
> -
> -       /* Track auto wait count on s_barrier settings */
> -       bool                            barrier_has_auto_waitcnt;
> -
> -       struct amdgpu_reset_control     *reset_cntl;
> -       uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_IN=
STANCE];
> -
> -       bool                            ram_is_direct_mapped;
> -
> -       struct list_head                ras_list;
> -
> -       struct amdgpu_reset_domain      *reset_domain;
> -
> -#ifdef CONFIG_DEV_COREDUMP
> -       struct amdgpu_coredump_info     *coredump;
> -       struct work_struct              coredump_work;
> -#endif
> -
> -       struct mutex                    benchmark_mutex;
> -
> -       bool                            scpm_enabled;
> -       uint32_t                        scpm_status;
> -
> -       struct work_struct              reset_work;
> -
> -       bool                            dc_enabled;
> -       /* Mask of active clusters */
> -       uint32_t                        aid_mask;
> -
> -       /* Debug */
> -       bool                            debug_vm;
> -       bool                            debug_largebar;
> -       bool                            debug_disable_soft_recovery;
> -       bool                            debug_use_vram_fw_buf;
> -       bool                            debug_enable_ras_aca;
> -       bool                            debug_exp_resets;
> -       bool                            debug_disable_gpu_ring_reset;
> -       bool                            debug_vm_userptr;
> -       bool                            debug_disable_ce_logs;
> -       bool                            debug_enable_ce_cs;
> -
> -       /* Protection for the following isolation structure */
> -       struct mutex                    enforce_isolation_mutex;
> -       enum amdgpu_enforce_isolation_mode      enforce_isolation[MAX_XCP=
];
> -       struct amdgpu_isolation {
> -               void                    *owner;
> -               struct dma_fence        *spearhead;
> -               struct amdgpu_sync      active;
> -               struct amdgpu_sync      prev;
> -       } isolation[MAX_XCP];
> -
> -       struct amdgpu_init_level *init_lvl;
> -
> -       /* This flag is used to determine how VRAM allocations are handle=
d for APUs
> -        * in KFD: VRAM or GTT.
> -        */
> -       bool                            apu_prefer_gtt;
> -
> -       bool                            userq_halt_for_enforce_isolation;
> -       struct amdgpu_uid *uid_info;
> -
> -       struct amdgpu_uma_carveout_info uma_info;
> -
> -       /* KFD
> -        * Must be last --ends in a flexible-array member.
> -        */
> -       struct amdgpu_kfd_dev           kfd;
> -};
> -
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
>                                          uint8_t ip, uint8_t inst)
>  {
> @@ -859,35 +475,9 @@ static inline bool amdgpu_is_multi_aid(struct amdgpu=
_device *adev)
>         return !!adev->aid_mask;
>  }
>
> -int amdgpu_device_init(struct amdgpu_device *adev,
> -                      uint32_t flags);
> -void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> -void amdgpu_device_fini_sw(struct amdgpu_device *adev);
>
>  int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
>
> -void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
> -                            void *buf, size_t size, bool write);
> -size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
> -                                void *buf, size_t size, bool write);
> -
> -void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> -                              void *buf, size_t size, bool write);
> -u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
> -bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
> -                                      enum amd_asic_type asic_type);
> -bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
> -
> -void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)=
;
> -
> -int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> -                                struct amdgpu_reset_context *reset_conte=
xt);
> -
> -int amdgpu_do_asic_reset(struct list_head *device_list_handle,
> -                        struct amdgpu_reset_context *reset_context);
> -
> -int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_=
context);
> -
>  int emu_soc_asic_init(struct amdgpu_device *adev);
>
>  /*
> @@ -995,54 +585,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  #define for_each_inst(i, inst_mask)        \
>         for (i =3D ffs(inst_mask); i-- !=3D 0; \
>              i =3D ffs(inst_mask & BIT_MASK_UPPER(i + 1)))
> -
> -/* Common functions */
> -bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
> -int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> -                             struct amdgpu_job *job,
> -                             struct amdgpu_reset_context *reset_context)=
;
> -void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
> -int amdgpu_device_pci_reset(struct amdgpu_device *adev);
> -bool amdgpu_device_need_post(struct amdgpu_device *adev);
> -bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev);
> -bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> -
> +/* Common function */
>  void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_by=
tes,
> -                                 u64 num_vis_bytes);
> -int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev);
> -void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
> -                                            const u32 *registers,
> -                                            const u32 array_size);
> -
> -int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
> -int amdgpu_device_link_reset(struct amdgpu_device *adev);
> -bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
> -bool amdgpu_device_supports_px(struct amdgpu_device *adev);
> -bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
> -bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
> -int amdgpu_device_supports_baco(struct amdgpu_device *adev);
> -void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
> -bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> -                                     struct amdgpu_device *peer_adev);
> -int amdgpu_device_baco_enter(struct amdgpu_device *adev);
> -int amdgpu_device_baco_exit(struct amdgpu_device *adev);
> -
> -void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
> -               struct amdgpu_ring *ring);
> -void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
> -               struct amdgpu_ring *ring);
> -
> -void amdgpu_device_halt(struct amdgpu_device *adev);
> -struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
> -struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> -                                           struct dma_fence *gang);
> -struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *=
adev,
> -                                                 struct amdgpu_ring *rin=
g,
> -                                                 struct amdgpu_job *job)=
;
> -bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
> -ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
> -ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
> +               u64 num_vis_bytes);
> +
>  void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
>                                    const struct amdgpu_vm_pte_funcs *vm_p=
te_funcs);
>  void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
> @@ -1076,10 +622,6 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>                                  struct drm_file *file_priv);
>  void amdgpu_driver_release_kms(struct drm_device *dev);
>
> -int amdgpu_device_prepare(struct drm_device *dev);
> -void amdgpu_device_complete(struct drm_device *dev);
> -int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
> -int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>  u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
>  int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
>  void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
> @@ -1108,22 +650,6 @@ struct amdgpu_afmt_acr amdgpu_afmt_acr(uint32_t clo=
ck);
>  void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>
> -pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
> -                                          pci_channel_state_t state);
> -pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> -pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
> -void amdgpu_pci_resume(struct pci_dev *pdev);
> -
> -bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
> -bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
> -
> -bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev);
> -
> -int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
> -                              enum amd_clockgating_state state);
> -int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
> -                              enum amd_powergating_state state);
> -
>  static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_devi=
ce *adev)
>  {
>         return amdgpu_gpu_recovery !=3D 0 &&
> @@ -1140,8 +666,6 @@ static inline bool amdgpu_is_tmz(struct amdgpu_devic=
e *adev)
>         return adev->gmc.tmz_enabled;
>  }
>
> -int amdgpu_in_reset(struct amdgpu_device *adev);
> -
>  extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>  extern const struct attribute_group amdgpu_flash_attr_group;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.h
> new file mode 100644
> index 000000000000..92bc7916ed43
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.h
> @@ -0,0 +1,586 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +#ifndef __AMDGPU_DEVICE_H__
> +#define __AMDGPU_DEVICE_H__
> +
> +#include "kgd_pp_interface.h"
> +#include <linux/ratelimit_types.h>
> +#include <linux/suspend.h>
> +#include <linux/workqueue_types.h>
> +#include <linux/types.h>
> +#include <linux/notifier.h>
> +#include <linux/debugfs.h>
> +#include <drm/drm_device.h>
> +#include <drm/amd_asic_type.h>
> +#include "amdgpu_mode.h"
> +#include <linux/mutex_types.h>
> +#include <linux/pm.h>
> +#include <linux/workqueue.h>
> +
> +#include "amdgpu_sa.h"
> +
> +#include "amdgpu_ras.h"
> +#include "amdgpu_wb.h"
> +#include "amdgpu_reg_access.h"
> +#include "amdgpu_gmc.h"
> +#include "amdgpu_gart.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_ttm.h"
> +#include "amdgpu_discovery.h"
> +#include "amdgpu_irq.h"
> +#include "amdgpu_doorbell.h"
> +#include "amdgpu_sched.h"
> +#include "amdgpu_dpm.h"
> +#include "amdgpu_nbio.h"
> +#include "amdgpu_hdp.h"
> +#include "amdgpu_smuio.h"
> +#include "amdgpu_mmhub.h"
> +#include "amdgpu_gfxhub.h"
> +#include "amdgpu_gfx.h"
> +#include "amdgpu_sdma.h"
> +#include "amdgpu_lsdma.h"
> +#include "amdgpu_uvd.h"
> +#include "amdgpu_vce.h"
> +#include "amdgpu_ucode.h"
> +#include "amdgpu_vcn.h"
> +#include "amdgpu_jpeg.h"
> +#include "amdgpu_vpe.h"
> +#include "amdgpu_umsch_mm.h"
> +#include "amdgpu_psp.h"
> +#include "amdgpu_gds.h"
> +#include "amdgpu_seq64.h"
> +#include "amdgpu_umc.h"
> +#include "amdgpu_dm.h"
> +#include "amdgpu_mes.h"
> +#include "amdgpu_mqd.h"
> +#include <linux/xarray.h>
> +#include "amdgpu_df.h"
> +#include "amdgpu_mca.h"
> +#include "amdgpu_aca.h"
> +#include "amdgpu_cper.h"
> +#include "amdgpu_ip.h"
> +#include "amdgpu_virt.h"
> +#include "amdgpu_sync.h"
> +#include "amdgpu_init_level.h"
> +#include "amdgpu_amdkfd.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu_uid.h"
> +#include "amdgpu_userq.h"
> +#include "amdgpu_vkms.h"
> +
> +#include "amdgpu_asic.h"
> +
> +#if defined(CONFIG_DRM_AMD_ISP)
> +#include "amdgpu_isp.h"
> +#endif
> +
> +#define AMDGPU_BIOS_NUM_SCRATCH                16
> +#define AMDGPU_RESET_MAGIC_NUM         64
> +#define AMDGPU_MAX_DF_PERFMONS         4
> +
> +struct amdgpu_hive_info;
> +struct amdgpu_xcp_mgr;
> +struct amdgpu_asic_funcs;
> +struct dma_fence;
> +struct amdgpu_fru_info;
> +struct amdgpu_reset_domain;
> +struct amdgpu_coredump_info;
> +
> +/* VRAM scratch page for HDP bug, default vram page */
> +struct amdgpu_mem_scratch {
> +       struct amdgpu_bo                *robj;
> +       uint32_t                        *ptr;
> +       u64                             gpu_addr;
> +};
> +
> +/*
> + * Core structure, functions and helpers.
> + */
> +struct amdgpu_mmio_remap {
> +       u32 reg_offset;
> +       resource_size_t bus_addr;
> +       struct amdgpu_bo *bo;
> +};
> +
> +struct amd_powerplay {
> +       void *pp_handle;
> +       const struct amd_pm_funcs *pp_funcs;
> +};
> +
> +struct amdgpu_pcie_reset_ctx {
> +       bool in_link_reset;
> +       bool occurs_dpc;
> +       bool audio_suspended;
> +       struct pci_dev *swus;
> +       struct pci_saved_state *swus_pcistate;
> +       struct pci_saved_state *swds_pcistate;
> +};
> +
> +enum amdgpu_enforce_isolation_mode {
> +       AMDGPU_ENFORCE_ISOLATION_DISABLE =3D 0,
> +       AMDGPU_ENFORCE_ISOLATION_ENABLE =3D 1,
> +       AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY =3D 2,
> +       AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER =3D 3,
> +};
> +
> +struct amdgpu_device {
> +       struct device                   *dev;
> +       struct pci_dev                  *pdev;
> +       struct drm_device               ddev;
> +
> +#ifdef CONFIG_DRM_AMD_ACP
> +       struct amdgpu_acp               acp;
> +#endif
> +       struct amdgpu_hive_info         *hive;
> +       struct amdgpu_xcp_mgr           *xcp_mgr;
> +       /* ASIC */
> +       enum amd_asic_type              asic_type;
> +       uint32_t                        family;
> +       uint32_t                        rev_id;
> +       uint32_t                        external_rev_id;
> +       unsigned long                   flags;
> +       unsigned long                   apu_flags;
> +       int                             usec_timeout;
> +       const struct amdgpu_asic_funcs  *asic_funcs;
> +       bool                            shutdown;
> +       bool                            need_swiotlb;
> +       bool                            accel_working;
> +       struct notifier_block           acpi_nb;
> +       struct notifier_block           pm_nb;
> +       struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> +       struct debugfs_blob_wrapper     debugfs_vbios_blob;
> +       struct mutex                    srbm_mutex;
> +       /* GRBM index mutex. Protects concurrent access to GRBM index */
> +       struct mutex                    grbm_idx_mutex;
> +       struct dev_pm_domain            vga_pm_domain;
> +       bool                            have_disp_power_ref;
> +       bool                            have_atomics_support;
> +
> +       /* BIOS */
> +       bool                            is_atom_fw;
> +       uint8_t                         *bios;
> +       uint32_t                        bios_size;
> +       uint32_t                        bios_scratch_reg_offset;
> +       uint32_t                        bios_scratch[AMDGPU_BIOS_NUM_SCRA=
TCH];
> +
> +       /* Register/doorbell mmio */
> +       resource_size_t                 rmmio_base;
> +       resource_size_t                 rmmio_size;
> +       void __iomem                    *rmmio;
> +       /* protects concurrent MM_INDEX/DATA based register access */
> +       spinlock_t mmio_idx_lock;
> +       struct amdgpu_mmio_remap        rmmio_remap;
> +       /* Indirect register access blocks */
> +       struct amdgpu_reg_access        reg;
> +       struct amdgpu_doorbell          doorbell;
> +
> +       /* clock/pll info */
> +       struct amdgpu_clock             clock;
> +
> +       /* MC */
> +       struct amdgpu_gmc               gmc;
> +       struct amdgpu_gart              gart;
> +       dma_addr_t                      dummy_page_addr;
> +       struct amdgpu_vm_manager        vm_manager;
> +       struct amdgpu_vmhub             vmhub[AMDGPU_MAX_VMHUBS];
> +       DECLARE_BITMAP(vmhubs_mask, AMDGPU_MAX_VMHUBS);
> +
> +       /* memory management */
> +       struct amdgpu_mman              mman;
> +       struct amdgpu_mem_scratch       mem_scratch;
> +       struct amdgpu_wb                wb;
> +       atomic64_t                      num_bytes_moved;
> +       atomic64_t                      num_evictions;
> +       atomic64_t                      num_vram_cpu_page_faults;
> +       atomic_t                        gpu_reset_counter;
> +       atomic_t                        vram_lost_counter;
> +
> +       /* data for buffer migration throttling */
> +       struct {
> +               spinlock_t              lock;
> +               s64                     last_update_us;
> +               s64                     accum_us; /* accumulated microsec=
onds */
> +               s64                     accum_us_vis; /* for visible VRAM=
 */
> +               u32                     log2_max_MBps;
> +       } mm_stats;
> +
> +       /* discovery*/
> +       struct amdgpu_discovery_info discovery;
> +
> +       /* display */
> +       bool                            enable_virtual_display;
> +       struct amdgpu_vkms_output       *amdgpu_vkms_output;
> +       struct amdgpu_mode_info         mode_info;
> +       /* For pre-DCE11. DCE11 and later are in "struct amdgpu_device->d=
m" */
> +       struct delayed_work             hotplug_work;
> +       struct amdgpu_irq_src           crtc_irq;
> +       struct amdgpu_irq_src           vline0_irq;
> +       struct amdgpu_irq_src           vupdate_irq;
> +       struct amdgpu_irq_src           pageflip_irq;
> +       struct amdgpu_irq_src           hpd_irq;
> +       struct amdgpu_irq_src           dmub_trace_irq;
> +       struct amdgpu_irq_src           dmub_outbox_irq;
> +
> +       /* rings */
> +       u64                             fence_context;
> +       unsigned int num_rings;
> +       struct amdgpu_ring              *rings[AMDGPU_MAX_RINGS];
> +       struct dma_fence __rcu          *gang_submit;
> +       bool                            ib_pool_ready;
> +       struct amdgpu_sa_manager        ib_pools[AMDGPU_IB_POOL_MAX];
> +       struct amdgpu_sched             gpu_sched[AMDGPU_HW_IP_NUM][AMDGP=
U_RING_PRIO_MAX];
> +
> +       /* interrupts */
> +       struct amdgpu_irq               irq;
> +
> +       /* powerplay */
> +       struct amd_powerplay            powerplay;
> +       struct amdgpu_pm                pm;
> +       u64                             cg_flags;
> +       u32                             pg_flags;
> +
> +       /* nbio */
> +       struct amdgpu_nbio              nbio;
> +
> +       /* hdp */
> +       struct amdgpu_hdp               hdp;
> +
> +       /* smuio */
> +       struct amdgpu_smuio             smuio;
> +
> +       /* mmhub */
> +       struct amdgpu_mmhub             mmhub;
> +
> +       /* gfxhub */
> +       struct amdgpu_gfxhub            gfxhub;
> +
> +       /* gfx */
> +       struct amdgpu_gfx               gfx;
> +
> +       /* sdma */
> +       struct amdgpu_sdma              sdma;
> +
> +       /* lsdma */
> +       struct amdgpu_lsdma             lsdma;
> +
> +       /* uvd */
> +       struct amdgpu_uvd               uvd;
> +
> +       /* vce */
> +       struct amdgpu_vce               vce;
> +
> +       /* vcn */
> +       struct amdgpu_vcn               vcn;
> +
> +       /* jpeg */
> +       struct amdgpu_jpeg              jpeg;
> +
> +       /* vpe */
> +       struct amdgpu_vpe               vpe;
> +
> +       /* umsch */
> +       struct amdgpu_umsch_mm          umsch_mm;
> +       bool                            enable_umsch_mm;
> +
> +       /* firmwares */
> +       struct amdgpu_firmware          firmware;
> +
> +       /* PSP */
> +       struct psp_context              psp;
> +
> +       /* GDS */
> +       struct amdgpu_gds               gds;
> +
> +       /* for userq and VM fences */
> +       struct amdgpu_seq64             seq64;
> +
> +       /* UMC */
> +       struct amdgpu_umc               umc;
> +
> +       /* display related functionality */
> +       struct amdgpu_display_manager   dm;
> +
> +#if defined(CONFIG_DRM_AMD_ISP)
> +       /* isp */
> +       struct amdgpu_isp               isp;
> +#endif
> +
> +       /* mes */
> +       bool                            enable_mes;
> +       bool                            enable_mes_kiq;
> +       bool                            enable_uni_mes;
> +       struct amdgpu_mes               mes;
> +       struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
> +       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
> +
> +       /**
> +        * @userq_doorbell_xa: Global user queue map (doorbell index =E2=
=86=92 queue) Key: doorbell_index (unique global identifier for the queue)
> +        * Value: struct amdgpu_usermode_queue
> +        */
> +       struct xarray userq_doorbell_xa;
> +
> +       /* df */
> +       struct amdgpu_df                df;
> +
> +       /* MCA */
> +       struct amdgpu_mca               mca;
> +
> +       /* ACA */
> +       struct amdgpu_aca               aca;
> +
> +       /* CPER */
> +       struct amdgpu_cper              cper;
> +
> +       struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
> +       uint32_t                        harvest_ip_mask;
> +       int                             num_ip_blocks;
> +       struct mutex    mn_lock;
> +       DECLARE_HASHTABLE(mn_hash, 7);
> +
> +       /* tracking pinned memory */
> +       atomic64_t vram_pin_size;
> +       atomic64_t visible_pin_size;
> +       atomic64_t gart_pin_size;
> +
> +       /* soc15 register offset based on ip, instance and  segment */
> +       uint32_t                *reg_offset[MAX_HWIP][HWIP_MAX_INSTANCE];
> +       struct amdgpu_ip_map_info       ip_map;
> +
> +       /* delayed work_func for deferring clockgating during resume */
> +       struct delayed_work     delayed_init_work;
> +
> +       struct amdgpu_virt      virt;
> +
> +       /* record hw reset is performed */
> +       bool has_hw_reset;
> +       u8                              reset_magic[AMDGPU_RESET_MAGIC_NU=
M];
> +
> +       /* s3/s4 mask */
> +       bool                            in_suspend;
> +       bool                            in_s3;
> +       bool                            in_s4;
> +       bool                            in_s0ix;
> +       suspend_state_t                 last_suspend_state;
> +
> +       enum pp_mp1_state               mp1_state;
> +       struct amdgpu_doorbell_index    doorbell_index;
> +
> +       struct mutex                    notifier_lock;
> +
> +       int asic_reset_res;
> +       struct work_struct              xgmi_reset_work;
> +       struct list_head                reset_list;
> +
> +       long                            gfx_timeout;
> +       long                            sdma_timeout;
> +       long                            video_timeout;
> +       long                            compute_timeout;
> +       long                            psp_timeout;
> +
> +       uint64_t                        unique_id;
> +       uint8_t                         unitid;
> +       uint64_t        df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFM=
ONS];
> +
> +       /* enable runtime pm on the device */
> +       bool                            in_runpm;
> +       bool                            has_pr3;
> +
> +       bool                            ucode_sysfs_en;
> +
> +       struct amdgpu_fru_info          *fru_info;
> +       atomic_t                        throttling_logging_enabled;
> +       struct ratelimit_state          throttling_logging_rs;
> +       uint32_t                        ras_hw_enabled;
> +       uint32_t                        ras_enabled;
> +       bool                            ras_default_ecc_enabled;
> +
> +       bool                            no_hw_access;
> +       struct pci_saved_state          *pci_state;
> +       pci_channel_state_t             pci_channel_state;
> +
> +       struct amdgpu_pcie_reset_ctx    pcie_reset_ctx;
> +
> +       /* Track auto wait count on s_barrier settings */
> +       bool                            barrier_has_auto_waitcnt;
> +
> +       struct amdgpu_reset_control     *reset_cntl;
> +       uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_IN=
STANCE];
> +
> +       bool                            ram_is_direct_mapped;
> +
> +       struct list_head                ras_list;
> +
> +       struct amdgpu_reset_domain      *reset_domain;
> +
> +#ifdef CONFIG_DEV_COREDUMP
> +       struct amdgpu_coredump_info     *coredump;
> +       struct work_struct              coredump_work;
> +#endif
> +
> +       struct mutex                    benchmark_mutex;
> +
> +       bool                            scpm_enabled;
> +       uint32_t                        scpm_status;
> +
> +       struct work_struct              reset_work;
> +
> +       bool                            dc_enabled;
> +       /* Mask of active clusters */
> +       uint32_t                        aid_mask;
> +
> +       /* Debug */
> +       bool                            debug_vm;
> +       bool                            debug_largebar;
> +       bool                            debug_disable_soft_recovery;
> +       bool                            debug_use_vram_fw_buf;
> +       bool                            debug_enable_ras_aca;
> +       bool                            debug_exp_resets;
> +       bool                            debug_disable_gpu_ring_reset;
> +       bool                            debug_vm_userptr;
> +       bool                            debug_disable_ce_logs;
> +       bool                            debug_enable_ce_cs;
> +
> +       /* Protection for the following isolation structure */
> +       struct mutex                    enforce_isolation_mutex;
> +       enum amdgpu_enforce_isolation_mode      enforce_isolation[MAX_XCP=
];
> +       struct amdgpu_isolation {
> +               void                    *owner;
> +               struct dma_fence        *spearhead;
> +               struct amdgpu_sync      active;
> +               struct amdgpu_sync      prev;
> +       } isolation[MAX_XCP];
> +
> +       struct amdgpu_init_level *init_lvl;
> +
> +       /* This flag is used to determine how VRAM allocations are handle=
d for APUs
> +        * in KFD: VRAM or GTT.
> +        */
> +       bool                            apu_prefer_gtt;
> +
> +       bool                            userq_halt_for_enforce_isolation;
> +       struct amdgpu_uid               *uid_info;
> +
> +       struct amdgpu_uma_carveout_info uma_info;
> +
> +       /* KFD
> +        * Must be last --ends in a flexible-array member.
> +        */
> +       struct amdgpu_kfd_dev           kfd;
> +};
> +int amdgpu_device_init(struct amdgpu_device *adev,
> +               uint32_t flags);
> +void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> +void amdgpu_device_fini_sw(struct amdgpu_device *adev);
> +
> +void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
> +               void *buf, size_t size, bool write);
> +size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
> +               void *buf, size_t size, bool write);
> +
> +void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> +               void *buf, size_t size, bool write);
> +u32 amdgpu_device_get_rev_id(struct amdgpu_device *adev);
> +bool amdgpu_device_asic_has_dc_support(struct pci_dev *pdev,
> +               enum amd_asic_type asic_type);
> +bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
> +
> +void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)=
;
> +
> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> +               struct amdgpu_reset_context *reset_context);
> +
> +int amdgpu_do_asic_reset(struct list_head *device_list_handle,
> +               struct amdgpu_reset_context *reset_context);
> +
> +int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_=
context);
> +
> +#include "amdgpu_reset.h"
> +
> +/* Common functions */
> +bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
> +bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
> +int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
> +               struct amdgpu_job *job,
> +               struct amdgpu_reset_context *reset_context);
> +void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
> +int amdgpu_device_pci_reset(struct amdgpu_device *adev);
> +bool amdgpu_device_need_post(struct amdgpu_device *adev);
> +bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev);
> +bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
> +
> +int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev);
> +void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
> +               const u32 *registers,
> +               const u32 array_size);
> +
> +int amdgpu_device_mode1_reset(struct amdgpu_device *adev);
> +int amdgpu_device_link_reset(struct amdgpu_device *adev);
> +bool amdgpu_device_supports_atpx(struct amdgpu_device *adev);
> +bool amdgpu_device_supports_px(struct amdgpu_device *adev);
> +bool amdgpu_device_supports_boco(struct amdgpu_device *adev);
> +bool amdgpu_device_supports_smart_shift(struct amdgpu_device *adev);
> +int amdgpu_device_supports_baco(struct amdgpu_device *adev);
> +void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
> +bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> +               struct amdgpu_device *peer_adev);
> +int amdgpu_device_baco_enter(struct amdgpu_device *adev);
> +int amdgpu_device_baco_exit(struct amdgpu_device *adev);
> +
> +void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
> +               struct amdgpu_ring *ring);
> +void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
> +               struct amdgpu_ring *ring);
> +
> +void amdgpu_device_halt(struct amdgpu_device *adev);
> +struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
> +struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
> +               struct dma_fence *gang);
> +struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *=
adev,
> +               struct amdgpu_ring *ring,
> +               struct amdgpu_job *job);
> +bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
> +
> +int amdgpu_device_prepare(struct drm_device *dev);
> +void amdgpu_device_complete(struct drm_device *dev);
> +int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
> +int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
> +
> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
> +               pci_channel_state_t state);
> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
> +void amdgpu_pci_resume(struct pci_dev *pdev);
> +
> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
> +
> +bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev);
> +
> +int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
> +               enum amd_clockgating_state state);
> +int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
> +               enum amd_powergating_state state);
> +int amdgpu_in_reset(struct amdgpu_device *adev);
> +#endif
> --
> 2.54.0
>
