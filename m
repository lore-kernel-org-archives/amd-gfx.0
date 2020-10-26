Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C9C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 20:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E06C207E8
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ1oyANx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E06C207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D780889DDF;
	Mon, 26 Oct 2020 20:24:24 +0000 (UTC)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0A889DDF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 20:23:56 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id p10so9859844ile.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=AWb/++qPeE7dpPuQ27PKb7BlY5R+TtNWyi4lSJ59xIE=;
 b=bZ1oyANxiJT9KIRSZPiQuN9D6OKuNJQ5+SRSGfe3Vi7EyD3QKyOrREUYusuh1SDzb2
 avp5jn2oaZjkyIfbds8L3DxL17oTPie4omGID0BBkl9E8YUb11bAuVvMTeNoPsccKa1x
 QZKZ7H9kn4oCoMk7fJnEKdS8Evv4lr5KmlXMj4xfN+koM8VesQ5Phqo563YtzI06QC1P
 8voWrgPhUvc0f09EnTcanq0lAnMYfGm4dEVKhvExH8gV31AYzsZ23f6gxZMkHxzEHqyQ
 UclJV71pAUqR18sH2wqlZMhEiM2calhaa/jMz7ztHlJfi+/HjeR2q4vfNS6+Gfzl/mjg
 0MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=AWb/++qPeE7dpPuQ27PKb7BlY5R+TtNWyi4lSJ59xIE=;
 b=H3gRE2UbY5kXKT7CCjalzFbCfnZaaclXzWv7DXRoZ4ydMMpvv7QU/lTnUr6T2ImQwQ
 s/bs7A7eJqB4o1z9cr67EgrKOYtJAtDTiwfRzNya1Sq9jtFUXorxowKYIxxKT7rPfoBO
 jozvov3pMFfRKc18xQ8ggR7e+7Ai497sGyVeX6WWDReAGPc6srE07fxAgwEeFQZc+L0H
 Tjk1SHXRHAGQkjMe5DeAqIve/BbneocN7DUo8PlEET9RdjNBPgMG1Z22Kj4uqErroeIj
 u796yMbBTh0jJN1hj4oBnWRBYh1jgjtEUSIMa9hCDeQoswBr0AZ6n2rjbSYqqv3gc6EO
 PPKw==
X-Gm-Message-State: AOAM530ozGNNZNR4iIUyC6SUsjPllJbMYBlnqqsz+B+/rdLo5kUJUO2/
 fWuKJDATGWiB2Gp5wacy0S6xRAZqjFMmLeY9/6FhGdHgUx0=
X-Google-Smtp-Source: ABdhPJwVHg7B4yC8fW5J3UoN6QqwWGtiZTIrZmS9+3mwzDwCMVmhbmKhgtYAEPuqlS48W5pc8JnNI+yJBWilT+2Nio8=
X-Received: by 2002:a05:6e02:111:: with SMTP id
 t17mr13026823ilm.79.1603743835900; 
 Mon, 26 Oct 2020 13:23:55 -0700 (PDT)
MIME-Version: 1.0
From: Tom Seewald <tseewald@gmail.com>
Date: Mon, 26 Oct 2020 15:23:45 -0500
Message-ID: <CAARYdbjUZEwmbujA5o9HXBvYfF2_L3nBHbMdZX4cnqB22DuiVg@mail.gmail.com>
Subject: [BISECTED] New kernel warning on v5.10-rc1
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Mon, 26 Oct 2020 20:24:23 +0000
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
Cc: tseewald <tseewald@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Upstream commit 6d90a208cfff ("drm/amd/display: Move disable interrupt
into commit tail") has introduced the following kernel warning on my
system with a RX 560 (Polaris 11) GPU. The warning is printed
immediately after I login.

amdgpu 0000:01:00.0: drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
WARNING: CPU: 1 PID: 972 at drivers/gpu/drm/drm_vblank.c:722
drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x31b/0x330 [drm]

I have confirmed that reverting this commit causes the warning to no
longer appear. See the gitlab bug report [1] for the bisect log and
full backtrace. Please cc me in your replies as I am not subscribed to
the amd-gfx mailing list.

[1] https://gitlab.freedesktop.org/drm/amd/-/issues/1349
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
