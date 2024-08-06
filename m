Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7EFC3DA64
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 09:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFD610E327;
	Tue,  6 Aug 2024 09:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e3a+14YT";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F61810E327
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 09:42:10 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WdSy737j3z9sGX;
 Tue,  6 Aug 2024 11:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1722937327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WU9JJwRVj1ZJ4sJcS5QKu1uJdQVVyttlCXtCd82OR8I=;
 b=e3a+14YTU9ir9a4YP/PXRFwS3/HqAkNavIv/9ApHKsk0z66uYWU0Eag0ctC3IRxlhKWDK5
 2O0hzXlJki6iKMopomiABW8PeB3TjsVrS8l95Qk1Q8KPcO0e1IeNpQ5dfAztUGYhZwtrYd
 LOap+hQFbcvSTdiV1ll+Yp3XeX+o1GOBFmRX4Q6+smx07/Exh9J+l2pvN0ibLzUNkGfwzm
 gD+o7a3NkCvavUMnX2C9Wz2GWmWAsshM9Vs3auNQUzIED/WegqdgJBRJ1JnLOL4N0o8Mw9
 2Y5Pxroz9H3r3FHdhLC5G7TtpibC+mSjRm66gbrldtfWpIxBPLPT9CcY9GEkoQ==
Message-ID: <f81c4c1d-e834-4c1a-a2bc-9794f94a7f7a@mailbox.org>
Date: Tue, 6 Aug 2024 11:42:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: fix the ioctl direction for
 DRM_IOCTL_AMDGPU_GEM_VA
To: Masatake YAMATO <yamato@redhat.com>
References: <20240806024310.3650332-1-yamato@redhat.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: de-CH-frami, en-CA
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20240806024310.3650332-1-yamato@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3a759bd93d36decd4df
X-MBO-RS-META: uuwk9ex8hfj9u4birks1iuhsu9yt1m4h
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


Hi Yamato-san,


On 2024-08-06 04:43, Masatake YAMATO wrote:
> Though drmCommandWriteRead() is used in libdrm [1],
> DRM_IOCTL_AMDGPU_GEM_VA uses DRM_IOW for encoding.
> 
> [1] https://gitlab.freedesktop.org/mesa/drm/-/blob/main/amdgpu/amdgpu_bo.c?ref_type=heads

AFAICT libdrm doesn't read from the struct drm_amdgpu_gem_va it passes to the ioctl after the latter returns though.

Also, while amdgpu_gem_va_ioctl (the ioctl implementation in the kernel) modifies the struct:

	args->va_address &= AMDGPU_GMC_HOLE_MASK;

that looks like an implementation detail which could be avoided if necessary, and shouldn't be propagated back to user space.


I'd suggest fixing libdrm to use drmCommandWrite instead.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
