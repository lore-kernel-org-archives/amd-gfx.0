Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF9BC2BB40
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F5D2074B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 01:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F5D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EC36E0D5;
	Tue, 15 Dec 2020 01:09:07 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B5C6E150
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7eDH+Fc+/bxqyb9yXeGUuu3pQ8Ejm9h4VjS6r6pn3HM=; b=AzynfzEkNhRCb8d7udGybYttEY
 eI4pYF40zLyKdIJzaH0JAVqNgZno4psTo0bu8Vx7wDBi2rW/5eo5iSd+P+ZTLSYajzXocRQxB1qg6
 Z2kpPEnAbsx0yigiXov7iHXDsMA4k7y45ynN/nvShVQ0WqeRRidNcjFU9TSfU0i9XLgTMH1BwIXct
 XHttJ4HYZbkYsbYow3Bpm5H8WpGHoI6jx5zWR6UTNzT7nUdOOX3vFSsyfj51sAjZz3vX4h8GeQg6d
 i6Y1j/4hRiG6aAMHOTGirBpAWWGQoLxrhR67ST/8rOvjBQUqw0a9ZjadMmjja/8HKcUvX3s6TAAve
 2Exg6wqA==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1koypr-000334-1C; Tue, 15 Dec 2020 01:09:03 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/8] amdgpu, pci: improved BAR resizing support
Date: Tue, 15 Dec 2020 01:08:54 +0000
Message-Id: <20201215010902.18945-1-devspam@moreofthesa.me.uk>
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

This patch series improves the existing BAR resizing support in amdgpu.  By
default, it will attempt to resize BAR0 for each supported dGPU present to
cover the VRAM.

Basic boot-time (or module load time) options to control this resizing are
implemented: one to control the maximum BAR size (may extend, may shrink)
and one to control whether the sizes advertised as supported by the VBIOS
are ignored. At present, these are coarse; there is no support for applying
limits to specific GPUs in multi-GPU systems.

The override and the quirks list (which uses it) are to cope with GPU
VBIOSes which don't properly advertise supported BAR sizes. Mine appears to
be one such.

Darren Salt (8):
  pci: export pci_rebar_get_possible_sizes
  pci: add BAR bytes->size helper & expose size->bytes helper
  amdgpu: resize BAR0 to the maximum available size, even if it doesn't
    cover VRAM (v5)
  amdgpu: limit maximum BAR0 size when attempting to enlarge (v3)
  pci: allow for overriding the list of advertised BAR sizes
  amdgpu: allow overriding of the GPU's list of supported BAR sizes (v3)
  amdgpu: implement a BAR size quirks list
  amdgpu: add a BAR size quirk for Sapphire RX 5600 XT Pulse.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  19 ++++
 drivers/pci/pci.c                          |   1 +
 drivers/pci/pci.h                          |   5 -
 drivers/pci/setup-res.c                    |   4 +-
 include/linux/pci.h                        |  12 ++-
 7 files changed, 127 insertions(+), 18 deletions(-)

-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
