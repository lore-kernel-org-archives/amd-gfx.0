Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393F8C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 12:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B28910E3E9;
	Thu,  7 Aug 2025 12:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="qlkbqE6G";
	dkim-atps=neutral
X-Greylist: delayed 435 seconds by postgrey-1.36 at gabe;
 Thu, 07 Aug 2025 10:27:31 UTC
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9359210E0B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 10:27:31 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4byNT80Tb0z9tTp;
 Thu,  7 Aug 2025 12:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1754562012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=UFyYIWgRqYCmYm9Ep7pOLVzBVrcsVZnsS04fQutnh44=;
 b=qlkbqE6GDVfYCuL/6V5rpVR1tQtmXRQ/kJA3ssJSY3JIGlxAZoHBSXwqj+7Vc6Y86M/6PW
 b63z9nxStojrdWV0WsX6w1EjUi7GuyYtNK7DeiePNpC//CgHH5qk6NxO+a3Rwn4qH7nocl
 i1woULMHg5+vH5dr2bDbphCCXdg8M8LjkdiCh+ykzqgB8k9ENBJd+7Bp3u5tAPgTgN4I2L
 dhnntdcvrhw/vsHqIaeUpj+YGpXadmXOw7/LK/T5/O8QqAYuiVRia3YSupj9F4cIa7ePp8
 5d+6UlO0KnqOJx3B8SD2PqOyWYwrlthzm8y2NQemQyf6uDEXxXKpvrw2ULIB0Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=listout@listout.xyz
Date: Thu, 7 Aug 2025 15:50:01 +0530
From: Brahmajit Das <listout@listout.xyz>
To: alexander.deucher@amd.com, christian.koenig@amd.com, sean@poorly.run
Cc: amd-gfx@lists.freedesktop.org
Subject: Is amdgpu open to converting logging to drm_* functions
Message-ID: <hzobspwqosrmrdmzicwabpsr4lcisuwck5nfsh5qwkoek562to@ybja5yzucsbh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 4byNT80Tb0z9tTp
X-Mailman-Approved-At: Thu, 07 Aug 2025 12:57:25 +0000
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

Hello Alex, Christian,

I'm a mentee at Linux kernel Bug Fixing Summer 2025. I came across the
TODO list on the kernel doc, and specifically this section[0]. Would
amdgpu be open to this conversion. I saw that before starting it is
recommended to talk with Sean and the relevant maintainer. Hence I'm
emailing you folks.

I guess you can also refer to this,
https://patchwork.freedesktop.org/patch/msgid/20191219161722.2779994-1-daniel.vetter@ffwll.ch

[0]:
https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter

-- 
Regards,
listout
