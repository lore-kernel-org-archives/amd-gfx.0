Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF81C5B56A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558DC10E6A2;
	Mon, 10 Aug 2026 06:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCQp01r4";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E6610E2BB
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 11:44:48 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8f186025973so3649186d6.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786189487; x=1786794287; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vB93jJMP9Hxu14qFTO+Z6eHPakUva4xSZ3v1QtWPB1E=;
 b=KCQp01r4PdFU0XrpGtM8XOdbO0cHvzGA5l4RB0MUGgS7lkR3X5FaB/4njRJ36POiLp
 n6vYH+VEV1QAk4ZWWHA7CHxhXW9qIL4TH3rqQi80LSq/Aie/9+uV/bW4rj3kfrRzoBu4
 Jhyb6nTFomWuHuGgb4XtVt+xtncCKEWDsLBSF3GCBOrT1CalczU0FPNy7QiW+XRSF6JS
 7TyfpJ/u3LVAnzl0T3R2m+81egz5P82tQH1/DnAANtbLlbSvDI/XFB4wTBi8+2Sz1wIj
 vPlAYF0CbMOZtSoSc9wNSF8qLg0zD3473pA3wv8XWBKSwBlH8orVS5NOlJHKb/SdZQTS
 rElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786189487; x=1786794287;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vB93jJMP9Hxu14qFTO+Z6eHPakUva4xSZ3v1QtWPB1E=;
 b=f6Ar4G1KhkEE17T/yUkZiFFYz2SJdK+zxNtreO6oJf0VYKz9voF0+p13e33eP8bRhN
 wg3UllirNnwVcM4/igDeH52jfLXjMyVYqg34JMJjxYnJGbCnQoVIkLei1tkKjLSuH5Z3
 Dqbt2qfHw/oOBAcYUaOd5Iddhw8JU/8FOzXuUKEsSuJfif3g2z9+d/BHgvK1xbkOXdCY
 Z/6EkC91sdbObRcev37N/NNyb0lSPNitaaaolzm5fC6pm94n+cXB3HFMVVe3Pbu8sHgu
 G6dITuh90HIFfAXmlDO8P4AjmAGU2EsreHWe/kS85f9G/6tPo1CgzULHlcpfP1YCVsw7
 sSzA==
X-Gm-Message-State: AOJu0YwRMaRJXT4h64+b+DTiPWDKGFpZY0xKu2K3LWmqBIK6Ld3ie6Nt
 YILNrtJ0cPedKQjhzxRwOUfb/rnNkoyEm7v2yP/+awwsXyoMhwAbvn1x
X-Gm-Gg: AR+sD13UxRdrc3AOIWGxk/EykOfbU58uRTND1izGNwDQzHVRQ3OJyecur0hVwhrufzA
 BxZ1qIQsiLQp0q9F9KFSolpZkuQfpnVupsXlvGfi6D4MxlDP/vEbdJcC6NJi8taA7BuGfG4PD9o
 /dFarRSV2/BjT3eXBFSR1D9shBrDrKbf3kIfGRpSrdOgrqaPXGSvGPrrkhotqEkcgdQ3jFqbLdy
 n1CR7OsLq7ya9EQRWOSn7CIAsYSr/BMv4WK4oJQkfvwK2M+FLwghb7smSGkqIhCEEQdyzRaKZq/
 qsMopNdXG0ZkCVYjLKOm/qS6OEbyhC5nSGvPIyK1877B+LeFkxfh7PRt1y4vNuPvqW5LdDqS12T
 83py7s6PGmmYCBZ5npYWkFYNcXGHxWCQ1s9hVBkj+vKCx3JrKLLU7agStE6GEu2MMg1cS56cnIV
 ZlKhigtJOuUSmCLCZ5lZ/YejjbpPrh1xWlCzJ2klunhQc+oPMyjHB/tA==
X-Received: by 2002:a05:6214:2dc9:b0:8f7:3902:42b2 with SMTP id
 6a1803df08f44-90a3470604emr82954986d6.27.1786189486936; 
 Sat, 08 Aug 2026 04:44:46 -0700 (PDT)
Received: from localhost ([172.216.11.43]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a918ecbesm29449616d6.9.2026.08.08.04.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 04:44:45 -0700 (PDT)
Date: Sat, 8 Aug 2026 14:44:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd: Enable SMU 15_0_0 support
Message-ID: <ancWphnH1Ih23J6U@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

Hello Pratik Vishwakarma,

Commit c7fc0f372374 ("drm/amd: Enable SMU 15_0_0 support") from Dec
5, 2025 (linux-next), leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0.c:135 smu_v15_0_load_microcode()
	error: uninitialized symbol 'mp1_fw_flags'.

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0.c
    109 int smu_v15_0_load_microcode(struct smu_context *smu)
    110 {
    111         struct amdgpu_device *adev = smu->adev;
    112         const uint32_t *src;
    113         const struct smc_firmware_header_v1_0 *hdr;
    114         uint32_t addr_start = MP1_SRAM;
    115         uint32_t i;
    116         uint32_t smc_fw_size;
    117         uint32_t mp1_fw_flags;
    118 
    119         hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
    120         src = (const uint32_t *)(adev->pm.fw->data +
    121                                  le32_to_cpu(hdr->header.ucode_array_offset_bytes));
    122         smc_fw_size = hdr->header.ucode_size_bytes;
    123 
    124         for (i = 1; i < smc_fw_size/4 - 1; i++) {
    125                 WREG32_PCIE(addr_start, src[i]);
    126                 addr_start += 4;
    127         }
    128 
    129 
    130         for (i = 0; i < adev->usec_timeout; i++) {
    131                 if (smu->is_apu)
    132                         mp1_fw_flags = RREG32_PCIE(MP1_Public |
    133                                                    (smnMP1_FIRMWARE_FLAGS & 0xffffffff));

mp1_fw_flags is uninitialized if smu->is_apu is false.

    134 
--> 135                 if ((mp1_fw_flags & MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
    136                     MP1_CRU1_MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
    137                         break;
    138                 udelay(1);
    139         }
    140 
    141         if (i == adev->usec_timeout)
    142                 return -ETIME;
    143 
    144         return 0;
    145 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
