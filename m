Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD55C7EE29
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 09:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B3510E26A;
	Mon, 29 May 2023 09:45:45 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD6C10E26A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 09:45:42 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202305291145383538; Mon, 29 May 2023 11:45:38 +0200
Message-ID: <70baf20a-dd86-af46-5d4d-d807d537ef68@daenzer.net>
Date: Mon, 29 May 2023 11:45:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
References: <DM4PR12MB515262B810158F1D3C6E8324E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu/gfx9: switch to golden tsc registers for
 raven/raven2
In-Reply-To: <DM4PR12MB515262B810158F1D3C6E8324E39B9@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F17.64747442.0026,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/12/23 03:23, Zhang, Jesse(Jie) wrote:
> 
>   Due to raven/raven2 maybe enable  sclk slow down,
>     they cannot get clock count by the RLC at the auto level of dpm performance.
>     So switch to golden tsc register.

At least on this ThinkPad E595 with Picasso, the issue with this change (and the corresponding fbc24293ca16 "drm/amdgpu: change the reference clock for raven/raven2" & 9d2d1827af29 "drm/amdgpu: Differentiate between Raven2 and Raven/Picasso according to revision id") is that the GPU timestamps reported via the AMDGPU_INFO ioctl are no longer consistent with those reported via asynchronous GPU queries (e.g. via glQuery with GL_TIMESTAMP). The latter are still affected by clock changes, and even when the clock doesn't stop altogether, they still tick at 25 MHz, so the two kinds of GPU timestamps keep diverging further.

This makes it impossible to determine the wall clock time at which a certain GPU job finished. GNOME's mutter uses this for adaptive frame scheduling.

You can see the issue with the piglit test arb_timer_query-timestamp-get or with the Vulkan CTS tests dEQP-VK.pipeline.monolithic.timestamp.calibrated.*. (Note that some of these tests could already fail before with GFXOFF enabled, the symptoms are slightly different though)


An ideal long-term solution for this might be to modify the GPU microcode to use the golden registers for asynchronous timestamp queries as well.

In the meantime though, these changes need to be reverted for 6.4, at least for Picasso.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

