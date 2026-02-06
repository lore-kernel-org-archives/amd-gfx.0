Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ACDEE20AA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2080A10E7D8;
	Fri,  6 Feb 2026 14:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sXVV1ncZ";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3DF10E742
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 13:38:51 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso22723245e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 05:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770385130; x=1770989930; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dGXuZ2bOJzj6fDAM/WtbEOtc9kf3G9+rpIVm4yXWvd4=;
 b=sXVV1ncZ6S1/JwvA9J4gSlzBcuqV0LaSyysETA5FwgRfDvq4Ufu6JZlAmVRIg3L7qb
 TPvqe8KLVkHCTmqJKatCYAQv089i+EPFmCfrIJFjm8mikNgDUfAHcnl2GetFcn47NVHQ
 opfydiW3f5qwMvJEW3Y1EC1FjY+26r1MoGcgeagpXpZJDV8U/iJtlL3JXX4VZFqetMSe
 NjzfaerVikNR4PlSCwIBsusDn/bvGCaOtnjDD5uK17dRkqfc8m5IIkYV3WCavAzMJUj+
 0DFH6cwB1yIoFnW1gQTLwhHKV7oEKIWBA9VKJUuRIpb6MlwQdJ9kFUYltSxJOmND19fW
 cntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385130; x=1770989930;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dGXuZ2bOJzj6fDAM/WtbEOtc9kf3G9+rpIVm4yXWvd4=;
 b=NLbtHhz5noJCnx7JTs2r104VSUIzjp3GfmK4hO241uvHi2AeLEetY/WN28i6qsBWzv
 /B38COr/woSZwW9i372gxnPbrSPPllcRP9TLLEGbfb1kyAV/CM7r7KYCyH9z9D8wGpjm
 nxtj910yd3h/1CvKjaPSLlmM8Z7uZzgruGDbuDBi2leAPCAzAtjNtG0DsLXb178oUM3h
 DD/yI70G8aLNzbVOAMg+/8V0xX2thufHVvsGxyOb2LRh5fGvC81Vo7roPtbTyA2fW2Z1
 tZfkMB7bCPwIPDLQXme7ZlaVdEI+77KuKW8tfW8y9D2S+URd4dm/9zzj74roB6vLygYW
 RUvg==
X-Gm-Message-State: AOJu0YzbAMINAVDFnU+hJ4KMb4LJFMbL6NhEo7ejPqG+8XjO4NYbgqD+
 jIJgQ4QqTKTzI3qUJuUY65qcVY9Edn1mH9P/TT7MZAN27lJTKCVfUACal23tHpXoHxc=
X-Gm-Gg: AZuq6aLnedOd7pIbHTyqI7kDHhnjJxYBPvWtRoEWE1Hj+XoyQ50PVREAP/7dIx4KPEG
 xzXdOs0fJNkOLDAU2ru4UaFbYfvR3PYbKINtnQVGWxhBsVTqYHjZUYsBunxp2+UakdNo2q0q5Rh
 RoH1+CMgK2SS64lq8K/q1PxgWvD1I6apL5favPPB0CY0Kec4yRR1CkqC7y/Eq8Uu9DXoIJeYnlw
 I07cjn8MbhNgHmGL6EsYFCgYzdYfghXTbTPWXoVhvIUc9Qm4O4pRP7rTecvgK8CFl0QYUeF6n1L
 UC8fSya2PA5okiYEZ7q0hh+HitEk2Fy8IT3shGOBvba4RHtYIpqHosAgsz8CXXeiNMALKtNySmZ
 nviNdDxCHDoYM5uXw+JpxUDKMSs23Ziqic6g1ROilXQZ97YHfol9UeyMzJLs/II8YsnmfKo3FL1
 dkRFNAIyi/uUYzQ2p6
X-Received: by 2002:a05:600c:548e:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-48320983bf7mr29532005e9.29.1770385129893; 
 Fri, 06 Feb 2026 05:38:49 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fb16sm6077760f8f.25.2026.02.06.05.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 05:38:49 -0800 (PST)
Date: Fri, 6 Feb 2026 16:38:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] drm/amdkfd: add debug set and clear address watch
 points operation
Message-ID: <aYXu5vG4UBu9Xyq2@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
X-Mailman-Approved-At: Fri, 06 Feb 2026 14:22:59 +0000
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

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Jonathan Kim,

Commit e0f85f4690d0 ("drm/amdkfd: add debug set and clear address
watch points operation") from May 6, 2022 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c:448 kfd_dbg_trap_clear_dev_address_watch()
	error: buffer overflow 'pdd->watch_points' 4 <= u32max user_rl='0-3,2147483648-u32max' uncapped

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_debug.c
    433 int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
    434                                         uint32_t watch_id)
    435 {
    436         int r;
    437 
    438         if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))

kfd_dbg_owns_dev_watch_id() doesn't check for negative values so
if watch_id is larger than INT_MAX it leads to a buffer overflow.
(Negative shifts are undefined).

    439                 return -EINVAL;
    440 
    441         if (!pdd->dev->kfd->shared_resources.enable_mes) {
    442                 r = debug_lock_and_unmap(pdd->dev->dqm);
    443                 if (r)
    444                         return r;
    445         }
    446 
    447         amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
--> 448         pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
    449                                                         pdd->dev->adev,
    450                                                         watch_id);
    451         amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
    452 
    453         if (!pdd->dev->kfd->shared_resources.enable_mes)
    454                 r = debug_map_and_unlock(pdd->dev->dqm);
    455         else
    456                 r = kfd_dbg_set_mes_debug_mode(pdd, true);
    457 
    458         kfd_dbg_clear_dev_watch_id(pdd, watch_id);
    459 
    460         return r;
    461 }

regards,
dan carpenter
