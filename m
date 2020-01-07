Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A3EC33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 04:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625602075A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 04:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fripost.org header.i=@fripost.org header.b="DLcB2x7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625602075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fripost.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4697899BC;
	Tue,  7 Jan 2020 04:59:15 +0000 (UTC)
X-Greylist: delayed 449 seconds by postgrey-1.36 at gabe;
 Tue, 07 Jan 2020 04:33:28 UTC
Received: from outgoing.fripost.org (giraff.fripost.org
 [IPv6:2a00:1c20:4089:126c:300f:e2a1:9840:5351])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8226E7D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 04:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by outgoing.fripost.org (Postfix) with ESMTP id 2FE731961A4E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 05:25:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fripost.org; h=
 content-transfer-encoding:content-language:content-type
 :content-type:mime-version:user-agent:date:date:message-id
 :subject:subject:from:from; s=8f00fb94ec6c37aacb48bd43e073f9b7;
 t=1578371155; x=1580185556; bh=l0RFzceXIGLWpvI+D0dxLNkwjOoGktLj
 QIz66gSZasY=; b=DLcB2x7L0EotE6NTJzhKfa3l7fPxw23JwXkFnDmP82eQQwLQ
 fvg9hPN1whSLkRARZCJ/rChrCe0Y8TDNNYK14I3vlKo0u+yQGbDFQCpE8Fwy6i7e
 dNRL6KzHdPQwcugbtWEz5N25gxzBs5zxP66bC5WERqs+OutB9VPLgrYUofiLFZ/I
 aTKZRI3Q/8+/RqvlhpuDMLr/iWe5rtKg4a3jXGqMFdFPNxkxAFUfP8Ov76G8BM0u
 v2RF23IWHB30+ivGyX1U7AvWXyvR9BNQOlDdIzNqC69jEDbIybZ+G/D2/691i4eb
 32qPpypbUAIyYaLNuPJish6g1NKe+UdD9kbrvA==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
 by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
 with LMTP id WdIolVZd2uV7 for <amd-gfx@lists.freedesktop.org>;
 Tue,  7 Jan 2020 05:25:55 +0100 (CET)
Received: from smtp.fripost.org (unknown [172.16.0.6])
 by outgoing.fripost.org (Postfix) with ESMTP id 0B9161961A4A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 05:25:55 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 by smtp.fripost.org (Postfix) with ESMTPSA id EAD545DCF037
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 05:25:43 +0100 (CET)
To: amd-gfx@lists.freedesktop.org
From: Arvid Brodin <arvidb@fripost.org>
Subject: RX 5500 XT hangs kernel on boot
Message-ID: <bc6634bc-a7a6-d71a-8127-31fed3cd3d81@fripost.org>
Date: Tue, 7 Jan 2020 05:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Tue, 07 Jan 2020 04:59:15 +0000
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

So I tried to use my RX 5500 XT for the first time today. Kernel updated to 5.4.8, fresh navi14 firmware files fetched from the linux-firmware repo, and of course power cable connected to the card.

Booting the kernel hangs when the graphics are initialized (on two different OS:es: Ubuntu 18.04 and Gentoo, Ubuntu with linux-5.4.7 and firmware updated today, Gentoo with 5.4.8 and firmware from 2019-12-15). There's nothing on the screen except sometimes a non-blinking cursor - I get no error messages.

So I tried to boot with the iGPU as primary with the RX 5500 XT still in the box. This works, the card is detected by the kernel, firmware loads etc, and it shows up in xrandr. But when enabling the output (something like 'xrandr --output DisplayPort-1-2 --preferred --same-as HDMI-1') the computer "half-freezes", as in, I get a little bit of reaction every 10 seconds or so - caps lock change, a kernel log line is printed, etc. Mouse cursor moves but system does not react to clicks.

Kernel logs at this time looks like this (copied by hand from photo):

kernel: [drm:amdgpu_dm_commit_planes.constprop.0 [amdgpu]] *ERROR* Waiting for fences timed out!
kernel: Asynchronous wait on fence drm_sched:gfx_0.0.0:11 timed out (hint:submit_notify+0x0/0x80 [i915])
kernel: [drm:amdgpu_dm_commit_planes.constprop.0 [amdgpu]] *ERROR* Waiting for fences timed out!
kernel: Asynchronous wait on fence drm_sched:gfx_0.0.0:12 timed out (hint:submit_notify+0x0/0x80 [i915])

etc... (a new pair of lines appear about every 11 seconds).

I also get noise/nonsense output on the RX 5500 XT's DisplayPort at this time.


I'd like to get my graphics card working... :-/ Any ideas?


Regards,
Arvid Brodin
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
