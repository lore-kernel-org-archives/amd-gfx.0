Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105DDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 18:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895EA10E218;
	Thu,  9 Dec 2021 18:00:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437E410E217;
 Thu,  9 Dec 2021 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
 :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Du1ulIl0nJfgyvVBjJv/Ni5rMz9pM/5JhDhCLOiqtLI=; b=f5ccjmB3z3Zsg2zp2C8KIiTaiG
 tahGEqJAgk3bk+K6yWDfuLwt/tvjKrhO1YMODbN6TCytk2eORd1BC9+cWTxGJTO7rQTSWoue7nkI2
 VcTT1bf1bG0L8QDTZUsmuykcluNaxRhqPPoUEQBqNJ84NB4cMX34ZxurAV9R5iA/EZJsS3MGi14ba
 agwm4gNpMR0pdaoRzsI9RQUo12pkECE3pBX/XPpuQVouGHr5DA68VtRiegqmfxnVg0GGTQ+eWjWod
 E2HJ2Nv2Nre8M1b/JYa6wKSlp8Be1AWvTV5CETadnDwF8arM/0Ka8hG/l+s8kKKDKs5YOG/PILlV+
 jBVbIt0Q==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1mvNiD-000C0Z-09; Thu, 09 Dec 2021 19:00:09 +0100
Subject: Re: Reuse framebuffer after a kexec (amdgpu / efifb)
To: Alex Deucher <alexdeucher@gmail.com>
References: <62aab616-53cb-ff9f-c5f3-169c547bd1ee@igalia.com>
 <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <a1f4d263-b3d2-4ceb-8a89-948c8129500f@igalia.com>
Date: Thu, 9 Dec 2021 14:59:52 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_O8x3_8f7GZ=tme55-QW+nqMJ2YoqvROjDPg2YZP2catQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Dec 2021 18:00:35 +0000
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
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 xinhui pan <Xinhui.Pan@amd.com>, kasong@redhat.com,
 Baoquan He <bhe@redhat.com>,
 =?UTF-8?Q?Samuel_Iglesias_Gons=c3=a1lvez?= <siglesias@igalia.com>,
 kernel@gpiccoli.net, kexec@lists.infradead.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, pjones@redhat.com,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Dave Young <dyoung@redhat.com>,
 Christian Koenig <christian.koenig@amd.com>, Vivek Goyal <vgoyal@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 09/12/2021 14:31, Alex Deucher wrote:
> [...] 
> Once the driver takes over, none of the pre-driver state is retained.
> You'll need to load the driver in the new kernel to initialize the
> displays.  Note the efifb doesn't actually have the ability to program
> any hardware, it just takes over the memory region that was used for
> the pre-OS framebuffer and whatever display timing was set up by the
> GOP driver prior to the OS loading.  Once that OS driver has loaded
> the area is gone and the display configuration may have changed.
> 

Hi Christian and Alex, thanks for the clarifications!

Is there any way to save/retain this state before amdgpu takes over?
Would simpledrm be able to program the device again, to a working state?

Finally, do you have any example of such a GOP driver (open source) so I
can take a look? I tried to find something like that in Tianocore
project, but didn't find anything that seemed useful for my issue.

Thanks again!
