Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0AFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB33D23DB4
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 00:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB33D23DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=moreofthesa.me.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E3246E5C5;
	Fri, 11 Dec 2020 00:55:12 +0000 (UTC)
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk
 [IPv6:2001:8b0:897:1651::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7DE6E5BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 00:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=moreofthesa.me.uk; s=201708; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=szzs9vzu+lntns0aac9bpwGBwdtC4TaMQmn94BF4Lkg=; b=AjZGay8OQ19hA6adsmdzk07e+1
 3ogPQXaUD3u1Ze9boURByt059gIqK5NyBRJBdEGFX1mQl5GPnVRSaWCRcw2QHDYVn+cdl9Qq2s084
 Jf+IbmZVz9WJL5L9aMS0GDCDuX3dYZcHz6GyaI2s8Jd22lGZgwzy3hQcJxtg/7cY/sUVdyfVDv28P
 CgW5gP0+KnphVYcWMC1ZQjt9olci+i+oMhlq5AznefUcYCyww6Rbn7XMRAuR2KaoZueU77isRm+/x
 ZASrNXBh1HeZRNVfmtFH5uL/fH0MtKHzr6oEJ4T8xR+keByRzlwf0FbWO54YymwXYhHCFLoIuVtSe
 4RLf6Qjw==;
Received: from [2001:8b0:897:1650::2] (helo=flibble.moreofthesa.me.uk)
 by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
 (envelope-from <devspam@moreofthesa.me.uk>)
 id 1knWiA-0002lw-M3; Fri, 11 Dec 2020 00:55:06 +0000
From: Darren Salt <devspam@moreofthesa.me.uk>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/7] amdgpu, pci: improved BAR resizing support
Date: Fri, 11 Dec 2020 00:54:59 +0000
Message-Id: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
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
(where the size would be increased). At present, these are coarse; they
apply to all dGPUs driven by amdgpu.

The override is to cope with GPU VBIOSes which don't properly advertise
supported BAR sizes. This should be quirked somehow; I have yet to determine
how this should be arranged.

Darren Salt (7):
  pci: export PCI BAR size-reading functions
  pci: add BAR bytes->size helper & expose size->bytes helper
  amdgpu: resize BAR0 to the maximum available size, even if it doesn't
    cover VRAM (v2)
  amdgpu: module option controlling whether BAR0 resizing is done
  amdgpu: limit maximum FB BAR size when attempting to enlarge
  pci: allow for overriding the list of advertised BAR sizes
  amdgpu: allow overriding of the GPU's list of supported BAR sizes

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 63 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 18 +++++++
 drivers/pci/pci.c                          |  2 +
 drivers/pci/pci.h                          |  6 ---
 drivers/pci/setup-res.c                    |  4 +-
 include/linux/pci.h                        | 15 +++++-
 7 files changed, 91 insertions(+), 19 deletions(-)

-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
