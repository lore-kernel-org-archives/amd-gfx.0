Return-Path: <SRS0=Gsig=FH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D4AC63777
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 04:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C9620643
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Dec 2020 04:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C9620643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13CF46EB68;
	Thu,  3 Dec 2020 04:48:36 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466B06EB68;
 Thu,  3 Dec 2020 04:48:35 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id r6so563670qtm.3;
 Wed, 02 Dec 2020 20:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ekh9qA1cLZLZ2cwNXCHpKxfXGaJhddBukDVopCSfsRw=;
 b=Fqks2yMjHrCCKi1+QvzURD5pTf6hyMgNsPF47Hrt4UISL5oCpbvYScJ1DFHZ2T819v
 E7na436EQqu4sIOmI5UeqhO2HieLjGp9NlVTIB4CDTibuVTb4XK6oloQ22XZPqyCDO67
 BjnYKokQrciRGdMXXFRie2tOif8E8mpv7rw9/eZwDchHsIVUC0CP5A+wWF97MmQzcsLc
 64+CTC9MrXyVsnAHBxpm1Igpwktk881Pdl7yyOUR9Ev8NKrJNQVwx6dcK6MhKTlrwIfx
 n9eSunEOxEgD8IY4tHIwZyY1LSd3GlL7AZDF23+kWRjbSFBJ1dCyGWLoKzAHoiJFt90e
 gULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ekh9qA1cLZLZ2cwNXCHpKxfXGaJhddBukDVopCSfsRw=;
 b=MLMqcGtQ16QlVhVeb2blHUHij5EBg2fFH6ufIJBTQzte/yevmCP2ZEgCOyPLWvvspQ
 ZcszAimgKj4SpdgFQT3Mx9tfWldrJ4OVoeQ1O7A6rqgoRie5AsdOGk3rsOikZMQKi7BW
 Qbn4ZgSLtnFidmVpfcnT7KuWeF99SxMXrL6ZjUfzXKVRJoZWUdeDRAu0ijP/S+juJ9v1
 Bin7Rh/Ie9sRaYFmjjnakzAEryD6QjfPYOOr1gDB9I2h2utjOYMdhA+VVKLP6mjsRper
 7jIBXhKf7/QOjgk2Dsemf0UWJfBVCDdrglbDMDX2lj7ibfpe67v540KFPcQHJRzE7uPR
 Maxw==
X-Gm-Message-State: AOAM531s+eKRE4brDSfDXjuXEGJbcghPBUNGrkTUMOBBgw76la0S3JDr
 4Kc97mAYj6t+9RhpbLEk9UJAyx7gpG8=
X-Google-Smtp-Source: ABdhPJwRYqYAlQL3fffiSJVqQ9SWKAKOl4L+fi5iLrRCo6foLAHaGRW+3Ay5pTLusRJ7FRdviAvShw==
X-Received: by 2002:ac8:43cd:: with SMTP id w13mr1570707qtn.391.1606970914133; 
 Wed, 02 Dec 2020 20:48:34 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id z133sm377398qka.20.2020.12.02.20.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 20:48:33 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, daniel.vetter@ffwll.ch
Subject: [pull] amdgpu drm-fixes-5.10
Date: Wed,  2 Dec 2020 23:48:15 -0500
Message-Id: <20201203044815.41257-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Dave, Daniel,

Fixes for 5.10.

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://people.freedesktop.org/~agd5f/linux tags/amd-drm-fixes-5.10-2020-12-02

for you to fetch changes up to efd6d85a18102241538dd1cc257948a0dbe6fae6:

  drm/amdgpu/vcn3.0: remove old DPG workaround (2020-12-02 22:55:48 -0500)

----------------------------------------------------------------
amd-drm-fixes-5.10-2020-12-02:

amdgpu:
- SMU11 manual fan fix
- Renoir display clock fix
- VCN3 dynamic powergating fix

----------------------------------------------------------------
Arunpravin (1):
      drm/amdgpu/pm/smu11: Fix fan set speed bug

Boyuan Zhang (2):
      drm/amdgpu/vcn3.0: stall DPG when WPTR/RPTR reset
      drm/amdgpu/vcn3.0: remove old DPG workaround

Brandon Syu (1):
      drm/amd/display: Init clock value by current vbios CLKs

 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              | 25 ++++++++++++++++------
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 13 +++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  7 +++++-
 3 files changed, 36 insertions(+), 9 deletions(-)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
