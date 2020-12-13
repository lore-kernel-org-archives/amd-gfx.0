Return-Path: <SRS0=6PJh=FR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C530C4361B
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051CF2220F
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Dec 2020 22:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051CF2220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1821589E38;
	Sun, 13 Dec 2020 22:53:38 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2374A89DEA
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Dec 2020 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fPEfzuoIeSEW1sIKNgymloS92uHnZvlhZ1LWJzNxEiE=; b=QJ5mO9UtBTMaLL4HX1DdzDDN4w
 5luRDVBsPu00TA23hkZ8SLmQ0eJpLN0WnvDm0FKmw5Z4u0Zm23rbVidOzAsvZs6wiUA6mvgQjyE4o
 BrzwPaIhtAU/NybvjOiaxy1tMhag18Sy/DO5eiAoU2rznZfSsXbFy9Ise2BKGsA03Xe6RIEMZfbCo
 Xql9vAyhugQ38CNLdiCALdpC1MtE/FKL2e8wTT9rhv6Sj2InaUjMiI4Wt7H2mzucml2XMIVUrl7Sg
 WAFAV1PseAa0IwflkItpRv9sUSeg40wM1hKch1XiRBb3QZHXKWgx3lzVofaKQ0UGXJq1lJ7QaNPBP
 WnFtFPFg==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koaF1-0004Qu-P0; Sun, 13 Dec 2020 22:53:23 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/8] amdgpu, pci: improved BAR resizing support
Date: Sun, 13 Dec 2020 22:53:15 +0000
Message-Id: <20201213225323.6752-1-devspam@moreofthesa.me.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk);
 SAEximRunCond expanded to false
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
Cc: Darren Salt <devspam@moreofthesa.me.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch series improves the existing BAR resizing support in amdgpu. By
default, it will attempt to resize BAR0 for each dGPU present to cover the
VRAM, falling back to smaller sizes if necessary, e.g. if there's not enough
address space remaining or support for the size is not advertised.

Basic boot-time (or module load time) options to control this resizing are
implemented: one to control whether resizing is done (and whether the
advertised BAR sizes are ignored) and one to control the maximum BAR size
(where the size would be increased). At present, these are coarse; there is
no support for applying limits to specific GPUs in multi-GPU systems.

The override and the quirks list (which uses it) are to cope with GPU
VBIOSes which don't properly advertise supported BAR sizes. Mine appears to
be one such.

Darren Salt (8):
  pci: export pci_rebar_get_possible_sizes
  pci: add BAR bytes->size helper & expose size->bytes helper
  amdgpu: resize BAR0 to the maximum available size, even if it doesn't
    cover VRAM (v4)
  amdgpu: limit maximum BAR0 size when attempting to enlarge (v2)
  pci: allow for overriding the list of advertised BAR sizes
  amdgpu: allow overriding of the GPU's list of supported BAR sizes (v3)
  amdgpu: implement a BAR size quirks list
  amdgpu: add a BAR size quirk for Sapphire RX 5600 XT Pulse.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 115 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  19 ++++
 drivers/pci/pci.c                          |   1 +
 drivers/pci/pci.h                          |   5 -
 drivers/pci/setup-res.c                    |   4 +-
 include/linux/pci.h                        |  12 ++-
 7 files changed, 140 insertions(+), 18 deletions(-)

-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
