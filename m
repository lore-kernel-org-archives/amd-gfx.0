Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D29CCF9E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CDC10E8B2;
	Thu, 23 Oct 2025 07:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vfzibwym";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A247C10E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 09:22:29 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-428564f8d16so188277f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761124948; x=1761729748; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z7+WPa6fzkzIkb/WM7fYUJAZP3WTURYIOOoTI2A/B20=;
 b=VfzibwymMzTkicDamVAQgY+2nDrm/m4rMC3oqahpD/QmEQ37a6MwpyiUbgVfm3YDmU
 jyZa/yu9WAvN44VvukRg6uhGqpqRagWLYR7LHfLK3J+Wnr9/ZESFKsaRS3hjAWE78FYa
 y3nsQRwy1EGzaQLv2gciMl/vNGswlj11EaiRVz+jwAF7ps2tBLApluyTi0WC8SCw5wVW
 /ipdlyOBwvzic//r7979cKUoBIp/wMN8heAG+zKzRa19VNuPz35mBQuMc90z8pdKsIE0
 Jffkvr/mSi4cjl9lZgEGkxgrDhlk0A+7HG8jPUPi5BI5+9wK4gUj1pVbBm6wmDBn1E/h
 nn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761124948; x=1761729748;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7+WPa6fzkzIkb/WM7fYUJAZP3WTURYIOOoTI2A/B20=;
 b=PLfybSM0f4/p1wMY1rQljN5t4tC+uaLMyRAd3cxtmSQNrlzOKbfkh7DruqFhuXB3U5
 B7xDDMysx+joRfTHwJU8TLvzDLcco7UAiQKFhDAQxYzdpfpuAgGEdbGRgEJHHtegTy4s
 kUoLgtHQW/okRgNMUYK1M3r2t6xUOoSlgzaJOJp9g1QGNWEjL4HDfp/L4mNReGr43Jov
 XsYLQJ/pCRVAFgSSLVoDQ0YRx8ZZBGCtnABZl5ElJ/WZ3eJajFFBkkbFM7SPhrV5SsAZ
 5hMaMypCzk6NkpNfzZIJ9vfga8A2zJ8URYaLXEj67uRcXKDu/cewNvs0+IFyE0UoL7hR
 uviA==
X-Gm-Message-State: AOJu0YzVXh1vFZQYLml40IHQMb8O5psUD9/nP3cwsTUOwFHWB0FdGoJJ
 /z7Euv0JfGrO3sjCtSW6mUBxfoPgZ5YSfobdvrGx5oN73rNO7EEKMG/myiZ8Dj6E1R0=
X-Gm-Gg: ASbGnctds+jpE0tESYQX5NKgKhHQremMA7Dd3wpCEJpJD5Kl4rs9qBjhtR4CU1z02Ni
 utWV7dnwB39vDprN3lqy19OlHTd/hUiNL6Iwrqf6vmITUP4QRLSMZT27q9OcsbLi1tnZv9i32GI
 6T5YvXRRtRiQm8Xy2QRdQV5c6DhX/UvJVmFdPcKP1hz1tnTv7Bth/23LzSs4RKuHUXZq8ylCeM1
 z56BHmf4v5pd1oR65kgS4koj2Qv+tr2Ke/rZPfRuDi5qYletL5RdrVODMjbp78Q9xZ+OWgI5V64
 e+M058SK6ES0fHUlS/avYsF8LzkpWKTts2GedKRF8Iw8X2Kev8tYLOPr9JSG1zrBssHBumklIt/
 8aZHviGteM3wejlw8XpwaaLUgSG+0iVW4TJ5tGUFWgQhAFz0zYO1pZNrNohKBtDYqzfrNyL1WBc
 mHXQ/TJg==
X-Google-Smtp-Source: AGHT+IE/+JkAy3x0Euv5ZMU/5Z9wLNiLKtrBsG+0gIPOWd+6NlnmnvFC9TXedSVDhLlMgRN2O9Lcjg==
X-Received: by 2002:a05:6000:2585:b0:426:fc52:cca6 with SMTP id
 ffacd0b85a97d-428532557femr2044051f8f.7.1761124948043; 
 Wed, 22 Oct 2025 02:22:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-427f009a7dasm26554232f8f.25.2025.10.22.02.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 02:22:27 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:22:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: Introduce SRIOV critical regions v2 during
 VF init
Message-ID: <aPiiUG_y0k1iLFJd@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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

Hello Ellen Pan,

Commit 07009df6494d ("drm/amdgpu: Introduce SRIOV critical regions v2
during VF init") from Oct 7, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:950 amdgpu_virt_init_critical_region()
	warn: unsigned 'init_hdr_offset' is never less than zero.

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
    937 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
    938 {
    939         struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
    940         uint32_t init_hdr_offset = adev->virt.init_data_header.offset;
    941         uint32_t init_hdr_size = adev->virt.init_data_header.size_kb << 10;
    942         uint64_t vram_size;
    943         int r = 0;
    944         uint8_t checksum = 0;
    945 
    946         /* Skip below init if critical region version != v2 */
    947         if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
    948                 return 0;
    949 
--> 950         if (init_hdr_offset < 0) {
                    ^^^^^^^^^^^^^^^
unsigned so it can't be less than zero.

    951                 dev_err(adev->dev, "Invalid init header offset\n");
    952                 return -EINVAL;
    953         }
    954 
    955         vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
    956         if (!vram_size || vram_size == U32_MAX)
    957                 return -EINVAL;
    958         vram_size <<= 20;
    959 
    960         if ((init_hdr_offset + init_hdr_size) > vram_size) {
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Would we be concerned about integer overflows here?  Should it be:

	if (size_add(init_hdr_offset, init_hdr_size) > vram_size) {

    961                 dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
    962                 return -EINVAL;
    963         }
    964 

regards,
dan carpenter
