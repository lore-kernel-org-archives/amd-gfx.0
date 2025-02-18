Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA29C021AD
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D66E10E3F9;
	Tue, 18 Feb 2025 16:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K9wTHlZV";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE54410E3F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:14:04 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so978517566b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739895243; x=1740500043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4uhajgKuIKNXhznhjeXP+/fqZXJW6Pdme/EXXkFG0+c=;
 b=K9wTHlZVxWSy+8fNQcLDtxn4sYbTfPPpaDOSgimjsQxWK8PMuzbXcTnGBT7oo18ceY
 VK/cwN3+yN9CuCaDohNYOKYBSHTWkgKukylfR3UOnT8g6wD6FxL2YfP0UAulkFrIRwv1
 sRzqetwwKFftffmPF3/dt0qoh/pLA7xv3XbZ/fwjOCwJmI+cIE8nuI1jbSIBI42hynqe
 j8E6mlRKi4Bt57IuXkzEUVy9bwJbjmbcw7k7ZJiaYeBpsuHcuE52Az3L1istsDPQ7S8r
 IpBCpbasSqhP1V6o0zBy44Ip6Iew4HWQ4wROI8ccEAyo3U/njEwVsoxXtfZYjCvl3sLF
 9fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895243; x=1740500043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4uhajgKuIKNXhznhjeXP+/fqZXJW6Pdme/EXXkFG0+c=;
 b=Rer19d2gTY0A29ykaXd3PCsKiq78N4AJ/khWR+wt1uBGbj5klAFXoIpcJ8FIxD3lZf
 lcur1hPOwo0rNeWXAUftVMejkfvr6FsZFjAvuoZFJs6ZCcgO93EEML2qvly+kQGrOX3o
 wXFstvwMJ1aKfKDATLzNyzkgg2tptluL+0Y8uE9bivyCwLRSgLul0rJSGsoNdeGUYhSm
 +XRBOg+1/K50Ov3GLnBoylDa8k1eCbKK7SgiDfiVdTAqwU/qU0BEJ+sUY3ODW7OFbAIt
 +uCuw9+/mWN9/MVmsAIyzF9AF6Hiz4zdDdyQQNUwK1yzC1Vbdfkza/Y1JUWXanzo7C90
 FUew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmzE9M4e6BUgFon8e6g+yE25IXsCMpJnnnQUTjbyKLPHYh5pyW6uEf8+LFR159psmrpI+XQiVh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQKevSkVBv5CnAo8/eygDoaK3J0I5fpwrjNgd28FY2d3QUaWSZ
 kyPCL/2wgGVzfyut3Xs/XQz8llxs73wQnsC5Exl47WshDLD5DIznMR9zjQ==
X-Gm-Gg: ASbGncty5d/noM9hzzPihrG9IUld3rUUvqphumpw14g4sAOjaUXQ9kgqUZy/HYxnQHu
 dzHrJEj1+4Aw0XJPFPpAOdVbRoW8mGycnVjxIP+bx6uPgC0ygYAezM7Ynb/DR6hEFhFGvf94UuI
 aWZ1f90xeztnRnhsT63WqKFnZqdgkxtDyDYwlfm+nJry+Uc5h4gDoD3xtIjACF3WKVavLeKEpKt
 T+MpfK8wyVcu/Yn6+TMeX+u1+QdssSrwhEE3Q3dV6TaoMdCDWBIuE8r1Wt7i9EM1fn4GKu1saNx
 3/UtINH5fH8bhUUhtsZul+7kMivm
X-Google-Smtp-Source: AGHT+IF4h/WUyjjym8d0KwB3qWhUAeASir+5brLzIYc5bBUdHWwV3C8d86PfPPA+oM16Q65igA6E8Q==
X-Received: by 2002:a17:906:adce:b0:abb:b422:a487 with SMTP id
 a640c23a62f3a-abbb422a5a5mr317663366b.19.1739895243049; 
 Tue, 18 Feb 2025 08:14:03 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15cb:ef00:7a4e:6292:55ba:b835])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba7848676sm306762466b.144.2025.02.18.08.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:14:02 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: grab an additional reference on the gang fence
Date: Tue, 18 Feb 2025 17:13:54 +0100
Message-Id: <20250218161401.2155-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

We keep the gang submission fence around in adev, make sure that it
stays alive.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d6b473217c8b..aaa8f9f7b6b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6753,6 +6753,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 {
 	struct dma_fence *old = NULL;
 
+	dma_fence_get(gang);
 	do {
 		dma_fence_put(old);
 		old = amdgpu_device_get_gang(adev);
@@ -6765,6 +6766,7 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 	} while (cmpxchg((struct dma_fence __force **)&adev->gang_submit,
 			 old, gang) != old);
 
+	dma_fence_put(old);
 	dma_fence_put(old);
 	return NULL;
 }
-- 
2.34.1

