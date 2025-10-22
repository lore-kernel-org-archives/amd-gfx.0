Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7568DCCF9E7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594EB10E8BA;
	Thu, 23 Oct 2025 07:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w5vKcjWT";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437A610E74E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:03:15 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so6237355f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761130994; x=1761735794; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tqB+ro+8/lqD6zF7EKOR9qw7BYYY9UmENSpSk3oMIu0=;
 b=w5vKcjWT5Z3Um1pAyXIx68+ECi69FTEVNfx8sC/Xd9ogLsTJ0ha36Wea2GZ5e9K4pf
 57baLxmdNiWB0EUNW7FBdf1M6O/HYTVGhsvGNQfHHZflqQwzPMKPrMtmnXN38MFKfEKW
 Z9LRo5tBFdWXpetbQdQs0kSW5DbkgJlncslJnXP4fhD1MipLGSg+IHQ87CRWPChPuE0E
 ZpR94mDb2RhaVCxZPrJseSbFgeeyk4fE20WyhLptR3wwk1c4Yrs7E4dOlj+8R5DxgtXx
 1LJzYmxGG2MNjr34TnZEJkGhGMHt4Nj6vM8Mrmijb9ODbgXnA/TyU0o9NpKW6Gx/XMZE
 r1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761130994; x=1761735794;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tqB+ro+8/lqD6zF7EKOR9qw7BYYY9UmENSpSk3oMIu0=;
 b=gRL4zF7ypT3SvnUxZmpYRnd/7h51+xaCaiOoBOybzT11dvL9yyXjkBWiczzf/ybCxz
 Rs+EgUEUflypokipj+AOisMs37owG8EzDcPebthwMEGJyOGb4hs3bp9SWcDh0/MSiBRg
 CWg01M120ubxKH3kMmKqpJdmouT9eD5Zd2BhzksY3Ij7Y3qbaS9cGFp26d8Ohmkqe6s8
 1v1H3pH8lClwmWuCmOdFuDeXUcUedjzev50VgBJ9gYgHkxtgjAn8zAAcNlpuHG6davc9
 wuZ6LroO28jsxBUSGC+8yvEGsILgLh81m7a6kYNVRaLWrRDsve823TU3wraxtMweACs0
 sIug==
X-Gm-Message-State: AOJu0YyiVvrNEgnm6q9mW8t2x/vJLTkpkkQow11iKnCPCfRpZ987D4yY
 t3ne/Wp3kBMIfXGPpTdEcn7lwcaxXZ/enesaI2mSz2f6dUlXvp0VN1YfwJe3/B/Q6U8=
X-Gm-Gg: ASbGncuXt2Qn+FANqFx/AvMm+9b8m8c8hZNPTAtN3WN8hWElCJ5LYRJzmJM51FuOQ3Q
 ho4HexBuQAUMQADe+hVpFmOebamebgsL0kOw291Z95n17myIAJziUOY9Z0VunulXWLTag/SfbQp
 tm9eaTlr6K5tFDKL/fxKQ7/kZ1Cu6pcajvuWuqYWc27ds/i3V2TJa1/ARWb2HDMLnkYm3xox3jk
 qT6cXbKA51gRKpDDTQQLEc2CkpmDhCa4mqWpMV7wpb653lO2tmyQBtaMiCzrvwTlHw9IWYCKNfb
 4T3HtNPg6HbiFPDSKEeWVY1wRoMb5xzMlpop7gmIjNv4HhMW9B5rTqN6oT2hOEfZ0mPzH/9FOnW
 s0qA7hCnvnFzmwSTN9gw5126G+cLihPvQbLKuGri+Px/db6un8XPxhuyeERegbyWu0ne/zTZ1d+
 2WLm0uyMswrnI/HJYj
X-Google-Smtp-Source: AGHT+IGU5OEln8qIHBwdN7IUf/vsOX21X2X8iS27IEBk5MSCR1APkCMlIh/Fb1FIS/Sq9tRBQ7bscw==
X-Received: by 2002:a05:6000:400e:b0:3e8:b4cb:c3dc with SMTP id
 ffacd0b85a97d-42704d4449amr14252521f8f.3.1761130993621; 
 Wed, 22 Oct 2025 04:03:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-427f00ce3aesm25047379f8f.48.2025.10.22.04.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:03:13 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:03:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ellen Pan <yunru.pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Message-ID: <aPi57bu_-WXwAN99@stanley.mountain>
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

Commit b4a8fcc7826a ("drm/amdgpu: Add logic for VF ipd and VF bios to
init from dynamic crit_region offsets") from Oct 7, 2025
(linux-next), leads to the following Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c:128 amdgpu_read_bios_from_vram() warn: corrupting cast 'size'?
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:312 amdgpu_discovery_read_binary_from_mem() warn: corrupting cast 'adev->discovery.size'?

drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
    271 static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
    272                                                  uint8_t *binary)
    273 {
    274         bool sz_valid = true;
    275         uint64_t vram_size;
    276         int i, ret = 0;
    277         u32 msg;
    278 
    279         if (!amdgpu_sriov_vf(adev)) {
    280                 /* It can take up to two second for IFWI init to complete on some dGPUs,
    281                  * but generally it should be in the 60-100ms range.  Normally this starts
    282                  * as soon as the device gets power so by the time the OS loads this has long
    283                  * completed.  However, when a card is hotplugged via e.g., USB4, we need to
    284                  * wait for this to complete.  Once the C2PMSG is updated, we can
    285                  * continue.
    286                  */
    287 
    288                 for (i = 0; i < 2000; i++) {
    289                         msg = RREG32(mmMP0_SMN_C2PMSG_33);
    290                         if (msg & 0x80000000)
    291                                 break;
    292                         msleep(1);
    293                 }
    294         }
    295 
    296         vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
    297         if (!vram_size || vram_size == U32_MAX)
    298                 sz_valid = false;
    299         else
    300                 vram_size <<= 20;
    301 
    302         /*
    303          * If in VRAM, discovery TMR is marked for reservation. If it is in system mem,
    304          * then it is not required to be reserved.
    305          */
    306         if (sz_valid) {
    307                 if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
    308                         /* For SRIOV VFs with dynamic critical region enabled,
    309                          * we will get the IPD binary via below call.
    310                          * If dynamic critical is disabled, fall through to normal seq.
    311                          */
--> 312                         if (amdgpu_virt_get_dynamic_data_info(adev,
    313                                                 AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
    314                                                 (uint64_t *)&adev->discovery.size)) {

&adev->discovery.size is a u32 but we're writing a 64 bits into it which
will corrupt memory.

In amdgpu_read_bios_from_vram() the issue is similar except that there
size is a resource_size_t so it can be either 32bit or 64bit.  Obviously
no one is really going to run this driver with a 32bit kernel but for
correctness it's better to make the types match.

    315                                 dev_err(adev->dev,
    316                                                 "failed to read discovery info from dynamic critical region.");
    317                                 ret = -EINVAL;
    318                                 goto exit;
    319                         }
    320                 } else {
    321                         uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
    322 
    323                         amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
    324                                         adev->discovery.size, false);
    325                         adev->discovery.reserve_tmr = true;
    326                 }
    327         } else {
    328                 ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
    329         }
    330 
    331         if (ret)
    332                 dev_err(adev->dev,
    333                         "failed to read discovery info from memory, vram size read: %llx",
    334                         vram_size);
    335 exit:
    336         return ret;
    337 }

regards,
dan carpenter
