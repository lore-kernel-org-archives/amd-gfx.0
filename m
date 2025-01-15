Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B76C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 08:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E44710E560;
	Wed, 15 Jan 2025 08:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qls2/d4r";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3520510E4DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 06:54:33 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so1001590966b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 22:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736924012; x=1737528812; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EA7HdHRqUXuUUEtaW6EKO6Gp/g4PXTHpnEsneGiTxxQ=;
 b=Qls2/d4rY/3ggCdkqIplPhT4/tWh03bqlew6bv59A8dUBho3GHMb9R3owk5amBHLly
 j1M4LR42dlU1uj9IJYI5ntFAXeA6ODKL4wA75luzeRCxMNS3qz2LZr7opT056ofCIvD2
 EGU47tDaGm/BE0L/bb0/tOr7cSW0QDvzFMEteOkrHMlYsipY65y1TeWIhrD1Z5JjSnUV
 nPOGDY7Tj5PBB5inRc1gPfW6t6N6vRxC/TGubwnSpUOSN3BV68TrIOGKkthzg76+mrWR
 4fNVJVb3rvkKjfwH/dLqlnR4p54dXwuwlQ7LiXl6nfoGH7esh45T1IsqOf1AKavpGrNl
 9CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736924012; x=1737528812;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EA7HdHRqUXuUUEtaW6EKO6Gp/g4PXTHpnEsneGiTxxQ=;
 b=BVmEBFPjd/qq4S6unfAhGucrY86pI5MSAH5TXn1WZDLOAdH4/mNK0J5T1DKJ01catV
 hkTNdiM9sRXyxNULHPcJrb8xNM+qjBbBJ686UAli8RLHb/A612Byzh61GVLVFEHNa6Md
 GoCbfQcb43i1wyXR8ExbGaMC7QKTKcJ36n9hAbA+cnzivlrxXQh+cwErF4jG8wrQ8ILq
 qwIAwoSZUtlJ/Nlf2j4GIKuE7lGoWYHMPNXseyw+MTYpPe5fPI3EBez7SXSjw+WaJ78h
 p0oFVpB3Z9FgIiIYlOUAL3a/DmWNux7iVSB+ljx+lirmw4svsC3zO+8G+Dtr0reAKLa7
 RzLQ==
X-Gm-Message-State: AOJu0YyRBr5lmdrsUtJCJJet/UVnSy1ebJlZix9p/UClwusaR54Mq2yw
 iuk193gpucgu+ucKerkNgLxYPyjumdb3pBnWUE57omT5xdcht0vkRHGqeR2elY0=
X-Gm-Gg: ASbGncuhuHdDKKOSmUGyzjAtkqRo5C7BSaeQIXfO2sYKtCkt3+9PrahMgWHD071KtRQ
 nf1fAN7fgUk/JuJr+WCC8+0HXEGMEhYoapn3rfhRZEFtAjzQXxlbG73hh3rhdnsY0Ycz4TezoFu
 7Pi24+IOtPMszc6N2mywKCNUwFQSINTdV0spNbqegSyLiOP5Lcgj6Nes4AQc5avuLQuzRKZtGLy
 BWirvRiJeK+cWhJKFWnXA6dBbr+OiKlf3a8r+Pyj/fnsxPg1OO6Y6LnSlVW5A==
X-Google-Smtp-Source: AGHT+IE1V+t2WuS0JApm7aNjVsXtvbfQ/Rfao5YG2bf/nZrp8pEhXMFYjYeepBBXWDQDtnwYeg2Xxg==
X-Received: by 2002:a17:907:3f95:b0:aa6:9b02:7fd0 with SMTP id
 a640c23a62f3a-ab2aad3f4a6mr2745950966b.0.1736924011641; 
 Tue, 14 Jan 2025 22:53:31 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c913605csm712635066b.82.2025.01.14.22.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 22:53:31 -0800 (PST)
Date: Wed, 15 Jan 2025 09:53:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Do not elevate mem_type change to full
 update
Message-ID: <609cd410-3bff-42a6-ba4e-a4366059bfbf@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Wed, 15 Jan 2025 08:17:02 +0000
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

Hello Leo Li,

Commit 4caacd1671b7 ("drm/amd/display: Do not elevate mem_type change
to full update") from Dec 11, 2024 (linux-next), leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:11486 amdgpu_dm_crtc_mem_type_changed()
	error: 'new_plane_state' dereferencing possible ERR_PTR()

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    11475 static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
    11476                                             struct drm_atomic_state *state,
    11477                                             struct drm_crtc_state *crtc_state)
    11478 {
    11479         struct drm_plane *plane;
    11480         struct drm_plane_state *new_plane_state, *old_plane_state;
    11481 
    11482         drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
    11483                 new_plane_state = drm_atomic_get_plane_state(state, plane);
    11484                 old_plane_state = drm_atomic_get_plane_state(state, plane);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
These functions can fail.

    11485 
--> 11486                 if (old_plane_state->fb && new_plane_state->fb &&
    11487                     get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
    11488                         return true;
    11489         }
    11490 
    11491         return false;
    11492 }

regards,
dan carpenter
