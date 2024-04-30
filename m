Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F28BC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9474112D65;
	Tue, 30 Apr 2024 17:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AG2L9BWp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5791F112D65
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qfbKAuYDGPYVFpfsFuZNvya2b8Z2FmKyaS1rhwfB/c4=; b=AG2L9BWpJmZaSFHfL83k3msi5Z
 EnNmRTqCAIoQtDcrnq2azcKQET732op1RYCeU6//vtUzWc9xUdvf9E+XB//G/RKqpM0BLwXXoYiiA
 X3xQdfefrRNZV+7dMH4D1WRsACynp5k9Pj75LdCGsQnQIANOMb/e2ZaJ5vPfMjbYy5GUm8Fitn/SY
 8ktIUrtcZWwA9EisUWV0w0CoPs28HM1t+f4yUpX9Yd7U0KiVw3nn/clK6rHbOsQdHY0NZiwk3FThV
 UI5MjnbQ3NV2qzgrRnBanbJgmO3rMJgwVBuqGFRCGI0FKmyIcrENOtJ6qvlO0LlsR9HE4CAbADLKP
 mPHk6rNw==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1rGi-001sRO-KS; Tue, 30 Apr 2024 19:27:52 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 0/5] Add capacity key to fdinfo
Date: Tue, 30 Apr 2024 18:27:43 +0100
Message-ID: <20240430172748.61576-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

I have noticed AMD GPUs can have more than one "engine" (ring?) of the same type
but amdgpu is not reporting that in fdinfo using the capacity engine tag.

This series is therefore an attempt to improve that, but only an RFC since it is
quite likely I got stuff wrong on the first attempt. Or if not wrong it may not
be very beneficial in AMDs case.

So I tried to figure out how to count and store the number of instances of an
"engine" type and spotted that could perhaps be used in more than one place in
the driver. I was more than a little bit confused by the ip_instance and uapi
rings, then how rings are selected to context entities internally. Anyway..
hopefully it is a simple enough series to easily spot any such large misses.

End result should be that, assuming two "engine" instances, one fully loaded and
one idle will only report client using 50% of that engine type.

Tvrtko Ursulin (5):
  drm/amdgpu: Cache number of rings per hw ip type
  drm/amdgpu: Use cached number of rings from the AMDGPU_INFO_HW_IP_INFO
    ioctl
  drm/amdgpu: Skip not present rings in amdgpu_ctx_mgr_usage
  drm/amdgpu: Show engine capacity in fdinfo
  drm/amdgpu: Only show VRAM in fdinfo if it exists

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 39 +++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 62 +++-------------------
 5 files changed, 49 insertions(+), 70 deletions(-)

-- 
2.44.0
