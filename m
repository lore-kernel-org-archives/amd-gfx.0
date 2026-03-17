Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DB110854D0
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 08:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFC910E767;
	Wed, 18 Mar 2026 08:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZunXHt+Q";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0EA10E638
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 13:20:44 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-35a1f549e7eso2805440a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773753644; x=1774358444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TjpfVxjcr+NMQLZx4OdK5lf1pCwYZzZGvbDIy4rSp4w=;
 b=ZunXHt+QOz25YAckt7IDU7V5nZYMEns5b6q0Srmxf23w3sV6skiLlQAFqz2ijGPBzf
 jwHtnKlDZJILgTRY21JzcA/SjIoMAz3D7OUy5OPyU0XYmN+9dlzP1Vpf+BwV1FlbIh+P
 pevzNJ5rkmNwSd2oXsr3f7skWbLrfxjXJc+eyzhQlml8jpHFegwgi+KzMzGztiWllxvW
 UHBzRKivWd0OBgqynnxy9QmpLaCddSB/Cq1aLgIB7sODmZqlTS77yEkb2ExYDkRm6eyI
 lGnPxPIfFfNmYcxtNIlTUadB2tksmkj+DHeZRdS3gJJy8sXqdYd26clEO3b5RWbb6jfp
 8WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773753644; x=1774358444;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TjpfVxjcr+NMQLZx4OdK5lf1pCwYZzZGvbDIy4rSp4w=;
 b=W8k1HBTyQt11vBhxBLQEtf2dmtpravY+qclLR07MIWZiyp4iSDHhCwu6ZSDJFbEKmb
 l7Oj9Y/pE4f+/YYTyJ7tgSKpGU5zfBf5VwgAdxHOEJsxdPLPxevCcpwqh53+xu3TjscA
 P3iuZaKtK5rHM2xJFbtv5bvEPVDGfwMnAe2iPvHw6/dTKR/nW4x4fSR6mJGYBEilz3vU
 uwKQTSQd4VDJVh1J0lawf7FT9ZoCyQp6tj2AVCMYWjbfN5A/RPuLQ6KOtidii1dYB9Fu
 cxndDTY1XuutTChBiH2CmmCjoioHdwKvGvJu/MDdkB0KQf2DaQ3AAkR2NQqupVxGVeWp
 /w6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzOJOBuq0bcc87sKImC+Nm86h53XeaMnm/TdPl0BkaxaeHqllQbN3MBKroPKPIFC7igLv8Np27@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyhzw7LoC74StqYLbDhSjGsD0xXH7T0zopwVran+3eIl4XMEcb2
 NqHPeq0Syuj2E9pPDfIDILbqdF2lSCEEtaT4AkU2r+qw9xUTy/yjzDwO
X-Gm-Gg: ATEYQzzzNyvDjYqm7efpftoRyPZ6ZSayHy+QqS24lLz7teafGtZsZk99k6s2WpR4qMG
 vo7scDuMq9YE+vb/4EdnzjajN9thWPIdNr1Mnoq3DQdxA6t31voqZzacNn/gq3di18IfM+9r9TS
 6ZM9/ocs/wKA34Rr3aLSXYdR4bpE2o/uK4CZrYAzyAbdjH4DJZaSxdsSygaz3l1BVIrcaEl7MLZ
 NgDqFL4Iu+UB3QyS0uNLQu46OYHbtXwRcqQ8ZS+aZ1sC0S3ZlkPIelvEeMw/KhDCfTawZSLQRyX
 puVJAImXHk69tRf3xSarUHkWMprPJKZGF0hhCuAMvJugl7NwXuIZM6HRsDoZxOxfdI4vVWwBfyd
 Uxn/r3pqhDSYLzFgVP6gTXtCggHXm8nf6XZE74DnLWPWDkW+fJIhkVarGZq/wUfhv88dSh2r3PW
 huqdLEsWC+hJecehD2UajUiQ==
X-Received: by 2002:a17:90b:2496:b0:35b:952c:43b9 with SMTP id
 98e67ed59e1d1-35b952c450amr5243491a91.10.1773753643761; 
 Tue, 17 Mar 2026 06:20:43 -0700 (PDT)
Received: from pve-server ([49.205.216.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bada5d18fsm2970098a91.7.2026.03.17.06.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:20:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, Gaurav Batra <gbatra@linux.ibm.com>,
 amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
Date: Tue, 17 Mar 2026 17:13:31 +0530
Message-ID: <ms06y93w.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:34:37 +0000
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

Dan Horák <dan@danny.cz> writes:

> Hi Ritesh,
>
> On Sun, 15 Mar 2026 09:55:11 +0530
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>
>> Dan Horák <dan@danny.cz> writes:
>> 
>> +cc Gaurav,
>> 
>> > Hi,
>> >
>> > starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
>> > initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
>> > with the following in the log
>> >
>> > ...
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
>> 
>>                   ^^^^
>> So looks like this is a PowerNV (Power9) machine.
>
> correct :-)
>  
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
>> > ...
>> >
>> > After some hints from Alex and bisecting and other investigation I have
>> > found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
>> > is the culprit and reverting it makes amdgpu load (and work) again.
>> 
>> Thanks for confirming this. Yes, this was recently added [1]
>> 
>> [1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/ 
>> 
>> 
>> @Gaurav,
>> 
>> I am not too familiar with the area, however looking at the logs shared
>> by Dan, it looks like we might be always going for dma direct allocation
>> path and maybe the device doesn't support this address limit. 
>> 
>>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
>
> a complete kernel log is at
> https://gitlab.freedesktop.org/-/project/4522/uploads/c4935bca6f37bbd06bb4045c07d00b5b/kernel.log
>
> Please let me know if you need more info.

Hi Dan,

Thanks for sharing the kernel log. Is it also possible to kindly share
your full kernel config with which you saw this issue.

I think Gaurav, is still looking into reported issue. However I was
interested in this kernel log output..

bře 05 08:35:34 talos.danny.cz kernel: radix-mmu: Mapped 0x00002007fad00000-0x00002007fcd00000 with 64.0 KiB pages

This shows that the system is using 64K pagesize. So I was interested in
knowing the kernel configs you have enabled. Donet has recently posted
64K pagesize support with amdgpu [1][2] on Power. However, I think, we
can still use it w/o Donet's changes if we have CONFIG_HSA_AMD_SVM
disabled.

So, can you kindly share the kernel configs and the AMD GPU HW details
attached to your Power9 baremetal system, if it's possible?

[1]: https://lore.kernel.org/amd-gfx/cover.1768223974.git.donettom@linux.ibm.com/#t     #merged
[2]: https://lore.kernel.org/amd-gfx/cover.1771656655.git.donettom@linux.ibm.com/       #in-review

-ritesh
