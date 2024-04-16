Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B52FC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 02:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E39711298D;
	Tue, 16 Apr 2024 02:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BD9FuYlT";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0812011298D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 02:55:11 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so2564745a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713236111; x=1713840911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mk2+YCr05G/v6VebCmphHytzb1s+7gNjyJ6Pl2E/JTQ=;
 b=BD9FuYlT4Yb1E8UhUpAfo/FDK0AKQNhxUaltu/c3X7j9E6khav3mAHR8iJmfqQ86PH
 AHnkXcbsBANU9WjjO6+namIw5CXu34HyrSOWiyZVGWfT27lB26Z5nKRSQgEZULjMEfJC
 ldSof8OlGQqcfz99mdzaZZWG5OUAeadoEqx73Kd3uAUY5jzodW8TrUWd8597osL+h00p
 q4NP6vN/W4tTED6SyDSWKoWh13VClisjo11GdH3cPkBraAmyGtd0yHcHrRLEq8sYNnXm
 8J9kGcAqxVWKhQ0ORXdP6zR1yyMFMto1GCzQgBGd3S8TMmETRRgQj5rWrFt06a4mu9FU
 ogew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713236111; x=1713840911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mk2+YCr05G/v6VebCmphHytzb1s+7gNjyJ6Pl2E/JTQ=;
 b=ILPYu4kLlJd0mgYrjxBzb+dIKSJdb3QGaJaFasm8eKF2ZWEL6iQyDROXCpKxFxh0/j
 35lzcpkxcm+M64gmSab9RqTxq5Dv83ojYI/Xe5uT0/720s/uS1YfwTP7ugJdQfLVr0b8
 vg1kuCS9EilMlFJdN1Z0dMvYt/1vgw+KXgVubWolgfR8yl3n/zdj8FXRvXADwSj11jPQ
 dUvSB/jI+TOuQmwFNNyYHzt0QGA+pALby5pe8zrunb5zgNtvVjL0T2HZ7EaUDW3Nutyt
 ms5qTrjOahLsEiI6KvsZSTDVDDcPtSdu/T+Uv+QHtPsAUmVvcN7jNRD6moGznR3TrZtt
 Fn5A==
X-Gm-Message-State: AOJu0YyItK4p5SJbJ9YGF0fysyj+rw4uHCffts0HipFA3t1f2Jtia9Jv
 VPesMW2CWeynTt8bAUGxkS6Bv2fuLsXNcjGxyQhcZo4+reFwp28MDrFcv535gbBILnHMi4WJaD+
 9pXGwAgN6qmagjhj6eXFf4TVrIqc=
X-Google-Smtp-Source: AGHT+IEZ8g1La/bAqcKIJilhZhhFF89EEvafJ07ymXJaO34/NWp3TKgFRBKAtQnHvElQKdAlk7veDYeY5L0uAOREknE=
X-Received: by 2002:a05:6a21:3d89:b0:1a7:73fe:438c with SMTP id
 bj9-20020a056a213d8900b001a773fe438cmr3014050pzc.21.1713236110898; Mon, 15
 Apr 2024 19:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240415194924.2181989-1-felix.kuehling@amd.com>
In-Reply-To: <20240415194924.2181989-1-felix.kuehling@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Apr 2024 22:54:58 -0400
Message-ID: <CADnq5_PDF4ieU+C9MTFUbuDnRrd4tSMMpSMosZDS_S9oyOppbQ@mail.gmail.com>
Subject: Re: [PATCH] rock-dgb_defconfig: Update for Linux 6.7 with UBSAN
To: Felix Kuehling <felix.kuehling@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Apr 15, 2024 at 4:07=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> make rock-dbg_defconfig
> make savedefconfig
> cp defconfig arch/x86/config/rock-dbg_defconfig
>
> This also enables UBSAN, which can help catch some types of bugs at
> compile time.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>  arch/x86/configs/rock-dbg_defconfig | 46 +++++++++--------------------
>  1 file changed, 14 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/configs/rock-dbg_defconfig b/arch/x86/configs/rock-=
dbg_defconfig
> index 0ad80a8c8eab..80129ca354b4 100644
> --- a/arch/x86/configs/rock-dbg_defconfig
> +++ b/arch/x86/configs/rock-dbg_defconfig
> @@ -34,11 +34,12 @@ CONFIG_CHECKPOINT_RESTORE=3Dy
>  CONFIG_SCHED_AUTOGROUP=3Dy
>  CONFIG_BLK_DEV_INITRD=3Dy
>  CONFIG_EXPERT=3Dy
> -CONFIG_USERFAULTFD=3Dy
> -# CONFIG_COMPAT_BRK is not set
>  CONFIG_PROFILING=3Dy
> +CONFIG_KEXEC=3Dy
> +CONFIG_KEXEC_FILE=3Dy
> +CONFIG_KEXEC_JUMP=3Dy
> +CONFIG_CRASH_DUMP=3Dy
>  CONFIG_SMP=3Dy
> -# CONFIG_RETPOLINE is not set
>  CONFIG_X86_INTEL_LPSS=3Dy
>  CONFIG_IOSF_MBI_DEBUG=3Dy
>  CONFIG_HYPERVISOR_GUEST=3Dy
> @@ -48,9 +49,6 @@ CONFIG_PROCESSOR_SELECT=3Dy
>  CONFIG_GART_IOMMU=3Dy
>  CONFIG_NR_CPUS=3D256
>  CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> -CONFIG_I8K=3Dm
> -CONFIG_MICROCODE_AMD=3Dy
> -CONFIG_MICROCODE_OLD_INTERFACE=3Dy
>  CONFIG_X86_MSR=3Dm
>  CONFIG_X86_CPUID=3Dm
>  # CONFIG_X86_5LEVEL is not set
> @@ -61,12 +59,8 @@ CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
>  CONFIG_EFI=3Dy
>  CONFIG_EFI_STUB=3Dy
>  CONFIG_EFI_MIXED=3Dy
> -CONFIG_KEXEC=3Dy
> -CONFIG_KEXEC_FILE=3Dy
> -CONFIG_CRASH_DUMP=3Dy
> -CONFIG_KEXEC_JUMP=3Dy
>  CONFIG_PHYSICAL_ALIGN=3D0x1000000
> -CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy
> +# CONFIG_RETPOLINE is not set
>  CONFIG_HIBERNATION=3Dy
>  CONFIG_PM_WAKELOCKS=3Dy
>  CONFIG_PM_DEBUG=3Dy
> @@ -74,7 +68,6 @@ CONFIG_PM_ADVANCED_DEBUG=3Dy
>  CONFIG_PM_TRACE_RTC=3Dy
>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=3Dy
>  CONFIG_ACPI_EC_DEBUGFS=3Dm
> -CONFIG_ACPI_VIDEO=3Dm
>  CONFIG_ACPI_DOCK=3Dy
>  CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
>  CONFIG_ACPI_PCI_SLOT=3Dy
> @@ -108,6 +101,8 @@ CONFIG_BLK_DEV_INTEGRITY=3Dy
>  CONFIG_BLK_DEV_THROTTLING=3Dy
>  CONFIG_PARTITION_ADVANCED=3Dy
>  CONFIG_BINFMT_MISC=3Dy
> +CONFIG_ZSWAP=3Dy
> +# CONFIG_COMPAT_BRK is not set
>  CONFIG_MEMORY_HOTPLUG=3Dy
>  CONFIG_MEMORY_HOTREMOVE=3Dy
>  CONFIG_KSM=3Dy
> @@ -115,15 +110,12 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
>  CONFIG_MEMORY_FAILURE=3Dy
>  CONFIG_HWPOISON_INJECT=3Dm
>  CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> -CONFIG_CLEANCACHE=3Dy
> -CONFIG_FRONTSWAP=3Dy
>  CONFIG_CMA=3Dy
>  CONFIG_CMA_AREAS=3D7
>  CONFIG_MEM_SOFT_DIRTY=3Dy
> -CONFIG_ZSWAP=3Dy
> -CONFIG_ZSMALLOC=3Dy
>  CONFIG_ZONE_DEVICE=3Dy
>  CONFIG_DEVICE_PRIVATE=3Dy
> +CONFIG_USERFAULTFD=3Dy
>  CONFIG_NET=3Dy
>  CONFIG_PACKET=3Dy
>  CONFIG_PACKET_DIAG=3Dy
> @@ -167,7 +159,6 @@ CONFIG_BRIDGE_NETFILTER=3Dm
>  CONFIG_NF_CONNTRACK=3Dm
>  CONFIG_NF_CONNTRACK_SECMARK=3Dy
>  CONFIG_NF_CONNTRACK_ZONES=3Dy
> -# CONFIG_NF_CONNTRACK_PROCFS is not set
>  CONFIG_NF_CONNTRACK_EVENTS=3Dy
>  CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
>  CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> @@ -178,7 +169,6 @@ CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
>  CONFIG_NF_TABLES=3Dm
>  CONFIG_NF_TABLES_NETDEV=3Dy
>  CONFIG_NFT_CT=3Dm
> -CONFIG_NFT_COUNTER=3Dm
>  CONFIG_NFT_CONNLIMIT=3Dm
>  CONFIG_NFT_LOG=3Dm
>  CONFIG_NFT_LIMIT=3Dm
> @@ -270,7 +260,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
>  CONFIG_IP_NF_TARGET_NETMAP=3Dm
>  CONFIG_IP_NF_TARGET_REDIRECT=3Dm
>  CONFIG_IP_NF_MANGLE=3Dm
> -CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
>  CONFIG_IP_NF_TARGET_ECN=3Dm
>  CONFIG_IP_NF_TARGET_TTL=3Dm
>  CONFIG_IP_NF_RAW=3Dm
> @@ -312,7 +301,6 @@ CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
>  CONFIG_DEVTMPFS=3Dy
>  CONFIG_DEVTMPFS_MOUNT=3Dy
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> -CONFIG_EFI_VARS=3Dy
>  CONFIG_PARPORT=3Dy
>  CONFIG_PARPORT_PC=3Dy
>  CONFIG_PARPORT_SERIAL=3Dy
> @@ -363,7 +351,6 @@ CONFIG_E1000=3Dy
>  CONFIG_E1000E=3Dy
>  CONFIG_IGB=3Dy
>  CONFIG_IGBVF=3Dy
> -CONFIG_IXGB=3Dy
>  CONFIG_IXGBE=3Dy
>  CONFIG_I40E=3Dy
>  CONFIG_SKY2=3Dy
> @@ -401,14 +388,14 @@ CONFIG_SENSORS_K10TEMP=3Dm
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_RC_CORE=3Dy
>  CONFIG_RC_DECODERS=3Dy
> +CONFIG_IR_JVC_DECODER=3Dy
> +CONFIG_IR_MCE_KBD_DECODER=3Dy
>  CONFIG_IR_NEC_DECODER=3Dy
>  CONFIG_IR_RC5_DECODER=3Dy
>  CONFIG_IR_RC6_DECODER=3Dy
> -CONFIG_IR_JVC_DECODER=3Dy
> -CONFIG_IR_SONY_DECODER=3Dy
>  CONFIG_IR_SANYO_DECODER=3Dy
>  CONFIG_IR_SHARP_DECODER=3Dy
> -CONFIG_IR_MCE_KBD_DECODER=3Dy
> +CONFIG_IR_SONY_DECODER=3Dy
>  CONFIG_IR_XMP_DECODER=3Dy
>  CONFIG_AGP=3Dy
>  CONFIG_AGP_AMD64=3Dy
> @@ -422,7 +409,6 @@ CONFIG_HSA_AMD_P2P=3Dy
>  CONFIG_DRM_AST=3Dm
>  CONFIG_FB=3Dy
>  CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> -CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>  CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
>  CONFIG_HID_BATTERY_STRENGTH=3Dy
>  CONFIG_HIDRAW=3Dy
> @@ -456,7 +442,6 @@ CONFIG_RTC_CLASS=3Dy
>  # CONFIG_RTC_HCTOSYS is not set
>  CONFIG_DMADEVICES=3Dy
>  CONFIG_DMABUF_MOVE_NOTIFY=3Dy
> -# CONFIG_X86_PLATFORM_DEVICES is not set
>  CONFIG_AMD_IOMMU=3Dy
>  CONFIG_INTEL_IOMMU=3Dy
>  # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
> @@ -473,9 +458,7 @@ CONFIG_XFS_WARN=3Dy
>  CONFIG_FANOTIFY=3Dy
>  CONFIG_QUOTA=3Dy
>  CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> -# CONFIG_PRINT_QUOTA_WARNING is not set
>  CONFIG_QFMT_V2=3Dy
> -CONFIG_AUTOFS4_FS=3Dy
>  CONFIG_FUSE_FS=3Dm
>  CONFIG_CUSE=3Dm
>  CONFIG_OVERLAY_FS=3Dy
> @@ -509,22 +492,21 @@ CONFIG_SECURITY=3Dy
>  CONFIG_SECURITY_NETWORK=3Dy
>  CONFIG_SECURITY_SELINUX=3Dy
>  CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> -CONFIG_SECURITY_SELINUX_DISABLE=3Dy
> -CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
>  CONFIG_LSM=3D"yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,appa=
rmor"
>  CONFIG_CRYPTO_AUTHENC=3Dy
> +CONFIG_CRYPTO_DES=3Dy
> +CONFIG_CRYPTO_CBC=3Dy
>  CONFIG_CRYPTO_SEQIV=3Dy
>  CONFIG_CRYPTO_ECHAINIV=3Dy
> -CONFIG_CRYPTO_CBC=3Dy
>  CONFIG_CRYPTO_MD4=3Dy
>  CONFIG_CRYPTO_SHA1=3Dy
> -CONFIG_CRYPTO_DES=3Dy
>  CONFIG_PRINTK_TIME=3Dy
>  CONFIG_DYNAMIC_DEBUG=3Dy
>  CONFIG_KGDB=3Dy
>  CONFIG_KGDB_LOW_LEVEL_TRAP=3Dy
>  CONFIG_KGDB_KDB=3Dy
>  CONFIG_KDB_KEYBOARD=3Dy
> +CONFIG_UBSAN=3Dy
>  CONFIG_DEBUG_RODATA_TEST=3Dy
>  CONFIG_DEBUG_KMEMLEAK=3Dy
>  CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=3Dy
> --
> 2.34.1
>
