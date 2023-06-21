Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40CBEB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 20:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230E410E359;
	Wed, 21 Jun 2023 20:25:25 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B8210E359;
 Wed, 21 Jun 2023 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ernyWPu0+7nqHYc1tAZva92JTMqybFI/9IABV1zvZqA=; b=RcqQB3N8ZCD34LbBIlrRS2Eaky
 kHmzJ/gJ3O14Nk1tl7iSYY4wywTYnMwL64xQRbOJwoPR9AN96p/FaMWOT5jrLwxdx99RammWMI4n4
 RKoSULDeTaHqAw5lp5YqMylV4jnCAA+Cz3DK4ggUMlnCVzmHvtxCoR2MU4USOVDTcfG1jf8rkOf22
 txN6qp2B6aTOhoHdnvlMxM7H8/4mn9rFUv4XJ0wl2FzfiIlIAsQ1x1tazb0J4CCGmYgs+FZETke+J
 Xky3kyUpIotjobK7o9QxrU8mtpWCq20VgAJnW/+uySxv0hEdG2cEzzcgJgkMgkY4HwHfX7puiAisz
 q+DYaUCQ==;
Received: from [179.113.218.86] (helo=steammachine.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1qC4OG-001TKu-7J; Wed, 21 Jun 2023 22:25:20 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] amd/display: only accept async flips for fast updates
Date: Wed, 21 Jun 2023 17:24:58 -0300
Message-ID: <20230621202459.979661-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
 michel.daenzer@mailbox.org, Simon Ser <contact@emersion.fr>,
 kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

This fix was developed with the "Add support for atomic async page-flips"
patchset, it's not dependent on the new feature but it wasn't applied by
the time so I'm resending it now.

Extracted from: https://lore.kernel.org/dri-devel/20220929184307.258331-3-contact@emersion.fr/

Simon Ser (1):
  amd/display: only accept async flips for fast updates

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  8 ++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 ++++++++++
 2 files changed, 18 insertions(+)

-- 
2.41.0

