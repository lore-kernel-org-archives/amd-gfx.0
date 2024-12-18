Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD3DE7718B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 14:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB26210ED16;
	Thu, 19 Dec 2024 14:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=schwarzvogel.de header.i=@schwarzvogel.de header.b="u4WDCzNx";
	dkim-atps=neutral
X-Greylist: delayed 1358 seconds by postgrey-1.36 at gabe;
 Wed, 18 Dec 2024 16:16:24 UTC
Received: from mail.schwarzvogel.de (mail.schwarzvogel.de
 [IPv6:2a01:4f8:252:1806::25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C4D10EBFE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=schwarzvogel.de; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c9LVfo+PTMXEjOCXwQLiW/jNbCg2tISUpfnhPWb1fxE=; b=u4WDCzNxIAS3N/sg7VLrMEnMD6
 HDBl1ALemaR0LtGjBDeBgDcjaG1m5NL8alVqez13Jsc02xASICVAdoWaW2BJvZfIcruB5d87h3VEj
 VsEXgj2YfMo/sE/9gCZsyBZ5mulbNbWwrfVSVLCT9xpCfT8aHttNMthZsT12+lFJ4Rv5LOFgnV3zW
 77i63LBCBLFsNtBJUjaRcFCxVXP4jETVB/g3tfGpwI5J8XwHNkoE14O35SoTwo1Da7FOCxwelFjj4
 5vbHvYPBoG31Jcwo1inOVS7vECWBUrsPqQOUoWD28V7FT2K2qgGlqs84jCrGOfY48gZEOHwQ9DwOw
 1Xob6lkA==;
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.98)
 (envelope-from <klausman@schwarzvogel.de>)
 id 1tNwMp-000000001KY-1TFB; Wed, 18 Dec 2024 16:53:43 +0100
Date: Wed, 18 Dec 2024 16:53:43 +0100
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: amd-gfx@lists.freedesktop.org
Cc: Jesse Zhang <jesse.zhang@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [Bug report] Regression with kernel v6.13-rc2
Message-ID: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 19 Dec 2024 14:17:44 +0000
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

Hi!

I have been hitting kernel messages from AMDGPU since v6.13-rc2, for
example:

[Wed Dec 18 15:56:24 2024] gmc_v11_0_process_interrupt: 10 callbacks suppressed
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00040B52
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CPC (0x5)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x1
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00000B33
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 client ID: CPC (0x5)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x1
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0x1
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:169 vmid:0 pasid:0)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:153 vmid:0 pasid:0)
[Wed Dec 18 15:56:24 2024] amdgpu 0000:03:00.0: amdgpu:   in page starting at address 0x0000000000000000 from client 10

This happens when loading nontrivial (~6g) models using PyTorch. There
is no immediate crash, but if exercise the model for a few minutes,
evetually, the GPU crashes (sometimes the whole machine).

I bisected this betwee -rc1 (which works fine) and -rc2, and I landed on
this commit:

commit 438b39ac74e2a9dc0a5c9d653b7d8066877e86b1
Author: Jesse.zhang@amd.com <Jesse.zhang@amd.com>
Date:   Thu Dec 5 17:41:26 2024 +0800

    drm/amdkfd: pause autosuspend when creating pdd

    When using MES creating a pdd will require talking to the GPU to
    setup the relevant context. The code here forgot to wake up the GPU
    in case it was in suspend, this causes KVM to EFAULT for passthrough
    GPU for example. This issue can be masked if the GPU was woken up by
    other things (e.g. opening the KMS node) first and have not yet gone to sleep.

    v4: do the allocation of proc_ctx_bo in a lazy fashion
    when the first queue is created in a process (Felix)

    Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
    Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    Cc: stable@vger.kernel.org

 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 15 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           | 23 ++--------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

I am not sure what the causal relation ship between the commit and the
messages I get is, but I thought this report might be useful.

Since I am not subscribed to the list, please CC me on replies. Thank
you!

Best,
Tobias
