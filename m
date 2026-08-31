Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D889C624D1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE7810EBCC;
	Tue,  1 Sep 2026 07:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvDtza9u";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669D110E1C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 22:01:22 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso317505a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788213682; x=1788818482; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KlAZtR3bxWbXU1u47EK486WJOcGonf0Fz4yohZ71G40=;
 b=IvDtza9umQB7ANifAdiM6fTD1WKnkVI6LEuy1SM1/M1hFj7epD7o84tD3UBOWxa0Ux
 AJrmLrJdT1B9nmMNlYCzp1/njhoqzXPOW3+dAL4jTTPPa3UwJW8mEYL3KrShOQBQKuPV
 4MVj+I3PiLLhLl5PvpMQx3JZD6vUovsPh7PjBAhXQ/Q6EQZq5j1pymv7Q5Sc817nhv1x
 5l/s+AB6TC39ewGWjirPODCTmz/k6i/6Ol6UwKxPog8PkPZdi+FF0Wc7NYvHADivM5vU
 vyxd1kOkUozSFkZZf3erq1ILx3hApjK5QjgjME6UAY7xfk94Ix1I4cG6kclYFBORMJ0r
 t3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788213682; x=1788818482;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KlAZtR3bxWbXU1u47EK486WJOcGonf0Fz4yohZ71G40=;
 b=PQ0NdBG8iZdbbdfh/audllPiy9YYVdHQqb/KeWOgDtajKlsT7uB6kC4tde/I9q0vRx
 WNyfppVh37/pEs6WrtbX5bi0Oq/Qk1xB87jJc3NIHd2wGxFNfuPf64Z+Xylo28dk21Ti
 t+oNXeofutXqbuqhyC+4CkAahvdQr+59M2yYoKQpg6hyBcQL1yVYpp5TGPkqYM4UOyUt
 ErQTa3iswCN0rwhiR4eNuGEX7qJTysyEHEBwXnJ0goZtFp9mgAOvFvmHhQtQIAUKmpgR
 uImlJKOr74edYqSdkaTCIs/xXUhJJyugW0GldaCSMS2j/aAfEXLLRfpVRXd7e/POuwSJ
 sMNA==
X-Gm-Message-State: AFuF++nRbs0/9hPSNaI3p/T9lTnG2slmIQEXYK1N5LMWJpNqj9oikvwd
 9OgrdtiRZb4KS2Xo+CgJxb1Jz2KCBhclpF00YCthJYK+6IVIvS3/Jwpg
X-Gm-Gg: AYBFou1OuCoojEyU63Cbl66dBMZQ8ikbA5s+tANZPooW/JPjVDrJ1SSsDjORikQwtpk
 VTzJAVpJL+2aTzlyo+4TT/L0IBxSe0+qPbErfk4e/p4fVWS6KFiP+UDowQ3CJO3AjE2bjlkv4s+
 fvIA2/n4NoHa0hc0zqAFz4GhAH4lHZJ/CO6KmayAajuebD6Rg4C91RMoPfE9wp037YN7CnJg/k2
 b/wiegXKizrhDokHCaYeWFzul9ATB3+02/g5aiG18LtBJV3+up7z26wfcDcW9qVbnFuB26F39dc
 4hGXS1qdFPg0sV1GAtYMLfMt73prAbIJTDTiwoikBEaJjGQoN+52WU04fV3vw+741DZIyGE7iVM
 keDFZA+eKOJz37EQaTWMgzLiFql6CtGsiO1eQH+w2uq9zChG0PVgU+2NdYa0qSnRKqx0v5nxOx1
 SNvNvoQNC/QTR4P1H5k4YUvZwbjO1KF1vKP2Z46TVibM40ERVqYt5ppNdYgRBKms2LIGUUZqCgL
 NxDp1/zSWkhg/J++ibpluZ8DRwdMP/zisylsDw8x0v6HmWBSkjVq74E/VSigkf7Sw==
X-Received: by 2002:a17:90a:114f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-3989be5b50emr19697772a91.25.1788213681696; 
 Mon, 31 Aug 2026 15:01:21 -0700 (PDT)
Received: from [192.168.0.158]
 (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32874498f9esm29322712eec.20.2026.08.31.15.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 15:01:20 -0700 (PDT)
Message-ID: <8d6ae98b-945f-402a-a7eb-c35c0efae46a@gmail.com>
Date: Mon, 31 Aug 2026 15:01:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] IOMMU Performance Optimization support
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>
Cc: amd-gfx@lists.freedesktop.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
 Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>
References: <20260831055108.1893285-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
In-Reply-To: <20260831055108.1893285-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:59:19 +0000
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


On 8/30/26 22:51, Mario Limonciello wrote:
> Add support for the AMD IOMMU Performance Optimization (PerfOpt)
> feature as defined in the AMD I/O Virtualization Technology (IOMMU)
> Specification, Section 3.4.9 (MMIO Offset 016Ch).
>
> This feature allows privileged integrated I/O devices (GPUs) to bypass
> the IOMMU when directly accessing system memory.  The IOMMU only
> enforces the IR/IW permission bits without GPA->SPA translations.
>
> Drivers will opt into this behavior, and enable amdgpu to turn this
> feature on when an integrated GPU is already in identity mode.
> If a user prefers to keep it always off (even with identity mode)
> there is also a module parameter to force it off.
>
> Mario Limonciello (2):
>    iommu/amd: Add PerfOpt IOMMU performance optimization support
>    drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in
>      identity domain
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  41 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 ++
>   drivers/iommu/amd/amd_iommu.h              |   3 +
>   drivers/iommu/amd/amd_iommu_types.h        |   7 +
>   drivers/iommu/amd/init.c                   |  43 +++++
>   drivers/iommu/amd/iommu.c                  | 214 +++++++++++++++++++++
>   include/linux/amd-iommu.h                  |  11 ++
>   8 files changed, 332 insertions(+)

Hi Mario,


The Legion Go 2 has a significant performance degradation when IOMMU is 
ON and VRAM is set to auto in the BIOS. I applied these to linux-next 
and compared to 7.2 neptune on the Legion Go 2 and got the following 
results:
Game: Avowed
With patches:

Go 2| Vram: 2GB, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: 2GB, IOMMU: On, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: On, FPS: 35-40, Frame Time: consistent

Without Patches:

Go 2| Vram: 2GB, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: 2GB, IOMMU: On, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: Off, FPS: 35-40, Frame Time: consistent
Go 2| Vram: Auto, IOMMU: On, FPS: 20, Frame Time: inconsistent

Overall, this seems to fix the performance issue with IOMMU when BIOS is 
in the factory default setting.

Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>

