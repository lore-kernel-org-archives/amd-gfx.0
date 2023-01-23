Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DB1C25B50
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jan 2023 10:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87432882D0;
	Mon, 23 Jan 2023 10:11:01 +0000 (UTC)
X-Greylist: delayed 535 seconds by postgrey-1.36 at gabe;
 Mon, 23 Jan 2023 10:11:00 UTC
Received: from c3po.tilda.center (c3po.tilda.center [108.61.164.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BD7882D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 10:11:00 +0000 (UTC)
Received: from [192.168.111.186] (meka.rs [109.93.255.137])
 by c3po.tilda.center (Postfix) with ESMTPSA id 635A934B31
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jan 2023 11:01:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tilda.center;
 s=c3po; t=1674468082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BPAEP+8GE6iWE5dI+t9FW/l682YNNj6Sxm0TVPNusDY=;
 b=N9nEwIE3MkSisfDFsQXb6b8YxE/AJpzILN1rvtuPSuRY/LmB8gJPoxUEY/VTYsM8dx7H9r
 6pCUQuSOGmZ8b5kklHM/L2STXbkfAGchpzMS+X2t7SGlsC8ER/IvLkP3WMGCKaZFIoVFQV
 AkBH2VyP1vA7kj4UxmgBG7lEz6JqOSM=
Message-ID: <6cd6acdb-06f9-d0b1-642e-e93b17ba37ca@tilda.center>
Date: Mon, 23 Jan 2023 11:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
From: =?UTF-8?Q?Goran_Meki=c4=87?= <meka@tilda.center>
Subject: Minimal kernel version for 7900XT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello,

I'm trying to figure out what's the minimal kernel version that supports 
the 7900XT. I found that the driver supports SLES 15:
https://www.amd.com/en/support/graphics/amd-radeon-rx-7000-series/amd-radeon-rx-7900-series/amd-radeon-rx-7900xt

I also found that SLES 15 SP 4 runs on 5.14:
https://www.suse.com/support/kb/doc/?id=000019587#SLE15SP4

The problem I have is that I can't find PCI ID (for my card it's 744c) 
in the list:
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L1654

Can you help me understand how this card works with Linux without PCI ID 
anywhere mentioned in the code, please? Thank you!

Regards,
meka
