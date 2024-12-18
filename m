Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F5DE7718A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 14:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BA010ED18;
	Thu, 19 Dec 2024 14:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=schwarzvogel.de header.i=@schwarzvogel.de header.b="EOAc+v3m";
	dkim-atps=neutral
Received: from mail.schwarzvogel.de (mail.schwarzvogel.de
 [IPv6:2a01:4f8:252:1806::25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8206B10E13B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=schwarzvogel.de; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gyIhqh1SrsX21ROWLpSDotRkQRhlx0A4r8bzBPY+hX8=; b=EOAc+v3mJojXyLya+YSOQiouQv
 yIMv/y4A81nZJxSLIAHSFNOBiEMWoqtCKs3xXu1F+VYo6QyK+LlikFx2r70o8yL4COOy4keUbgZai
 CMq4bpHalfLD/UzMc4d/3snBeU6929QPej17Yao/a5UrNTXge/4BNdSIaeaqSa8UUuiP/M8TzBUgo
 SvuY3aT0UJ9Tcnvo/cW71C+F45dq5jz5FHNDoMK9dbnZiVXvbnj5LbzgID321jt5HmqrkfKxEqRE8
 gtKr6WPDwWWQsr7f1n5ShqDIyIPYFlUZgN/DrqCPPJp7amTmSG5xYDrV8tKK7QTpKSIABqckv9nYz
 FYFCgsXw==;
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.98)
 (envelope-from <klausman@schwarzvogel.de>)
 id 1tNwlj-000000001Vl-49PM; Wed, 18 Dec 2024 17:19:28 +0100
Date: Wed, 18 Dec 2024 17:19:27 +0100
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: amd-gfx@lists.freedesktop.org
Cc: Jesse Zhang <jesse.zhang@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: Re: [Bug report] Regression with kernel v6.13-rc2
Message-ID: <376def7c-5cd4-49c0-a822-ae980ee72402@skade.local>
References: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d61f927-9beb-4ce1-b627-1740ac948c41@skade.local>
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

On Wed, 18 Dec 2024, Tobias Klausmann wrote:
> I have been hitting kernel messages from AMDGPU since v6.13-rc2, for
> example:

Additional data:

- v6.13-rc3 has the same issue
- reverting the commit patch from -rc3 makes the problem go away
- hardware is:
  03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 31 [Radeon RX 7900 XT/7900 XTX/7900 GRE/7900M] (rev c8) (prog-if 00 [VGA controller])
        Subsystem: Sapphire Technology Limited PULSE RX 7900 XTX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 42
        IOMMU group: 14
        Region 0: Memory at f000000000 (64-bit, prefetchable) [size=32G]
        Region 2: Memory at f800000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at f000 [size=256]
        Region 5: Memory at f6b00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at f6c00000 [disabled] [size=128K]
        Capabilities: <access denied>
        Kernel driver in use: amdgpu

Best,
Tobias
