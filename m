Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C529DC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 15:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5CC10E5CD;
	Tue, 22 Apr 2025 15:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BCFXig0B";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E4010E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 15:28:50 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZhmNZ6Hwxz9slY;
 Tue, 22 Apr 2025 17:28:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1745335726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz5+XzHwris4nteGpfO+d6b5ixAZf94+54hxnCwBB5Q=;
 b=BCFXig0BcR0TQgDANh+k5lOQ16Oy2Qe7vasfuWdlFROVMQhIe0FR+umIpcf/ahWWf4SpH1
 p+o0HroA96kScbQsDQCTZyfWPkyxeSUYvaYki+rABLkM/vlOlfpOkPV/InuZsXPxEpMDkZ
 KzTO1nhzfoOfXhBp68932MB9QlkjD8CzKIZuMhLYpdLHmPrhsz0rQrOUy0W06cRwh/cipA
 ZCewxO6v5+ccmZYUnund8IcTU5csGuxa0WnbcX79nw0piIrFoSqFH7+dUyUVuPK6Mqa9fL
 DDYDep2jjhL3YWj/2kOcv29ZFYgAsYslv/Ng711BWWgP4Xu0NfYIlD4VHlwr2A==
Message-ID: <ef362484-b1a1-4175-a519-8335409f1146@mailbox.org>
Date: Tue, 22 Apr 2025 17:28:44 +0200
MIME-Version: 1.0
Subject: Re: possible bug with RDNA4 and AMS
To: =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>
References: <63d93ed2-1ace-430f-980d-27199ffc5b3e@tnxip.de>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <63d93ed2-1ace-430f-980d-27199ffc5b3e@tnxip.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e5bbbdd624af66ca592
X-MBO-RS-META: o4i3zr6mgnrga6pe5iqwaaeskabku87x
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

On 2025-04-20 21:38, Malte Schröder wrote:
> Hi,
> 
> finally found this list, I hope it's the right place for this. I
> recently swapped my trusty RX 6900 XT with a shiny new RX 9070 XT (aka
> RDNA2 to 4). Now, when I start kwin_wayland my desktop is a flickering
> mess. As a workaround I can set KWIN_DRM_NO_AMS, it is working with
> this. Afaik this disables the use of atomic mode setting. So I guess
> there is a bug in either amdgpu kernel side, libdrm or mesa.

FWIW, if it's a user-space issue, it's most likely in kwin. Mesa doesn't use KMS directly in this scenario, and libdrm is just a thin wrapper around KMS ioctls.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
