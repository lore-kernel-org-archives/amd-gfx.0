Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34355C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 10:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB3F10E430;
	Tue, 10 May 2022 10:53:55 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C24110EA63
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 10:53:54 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aeae3.dynamic.kabel-deutschland.de
 [95.90.234.227])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4569A61E6478B;
 Tue, 10 May 2022 12:53:52 +0200 (CEST)
Message-ID: <fb6598f2-322b-5fa7-d4db-8bee38c33c32@molgen.mpg.de>
Date: Tue, 10 May 2022 12:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: How are the DC patches tested?
Content-Language: en-US
To: Daniel Wheeler <Daniel.Wheeler@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
 <DM6PR12MB352902B7FE179953EBBD474F9CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
 <f284dad0-9a9e-0edb-54df-db97b58451e9@molgen.mpg.de>
 <067c7558-8b07-139a-9eb5-e4fe9ce0cbf0@amd.com>
 <5b4a80eb-a14b-7402-fe96-83af10a64c8b@molgen.mpg.de>
 <DM6PR12MB3529432C69991BA7278574489CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM6PR12MB3529432C69991BA7278574489CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Sun peng Li <Sunpeng.Li@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, Solomon Chiu <Solomon.Chiu@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Agustin Gutierrez <Agustin.Gutierrez@amd.com>,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Daniel,


Am 09.05.22 um 17:21 schrieb Wheeler, Daniel:

> I've made some edits to my cover letter to hopefully make it clearer
> with what is being done.
Thank you.
> 		Hi all,
>   
> 		This week this patchset was tested on the following systems:
>   
> 		HP Envy 360, with Ryzen 5 4500U
> 		Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U
> 		Sapphire Pulse RX5700XT
> 		Reference AMD RX6800
> 		Engineering board with Ryzen 9 5900H
> 
> 		These systems were tested on the following display types:
> 		eDP, (1080p 60hz [4500U, 5650U, 5900H])
> 		VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
> 		DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI adapters])
> 
> 		MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
> 		DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x DP) with 3x 4k60 displays
>   
> 		The testing is a mix of automated and manual tests. Manual testing includes (but is not limited to):
> 		Changing display configurations and settings
> 		Benchmark testing
> 		Feature testing (Freesync, etc.)
> 
> 		Automated testing includes (but is not limited to):
> 		Script testing (scripts to automate some of the manual checks)
> 		IGT testing
> 
> 		The patchset consists of the most recent amd-staging-drm-next branch with a selection of patches added on top of it. This goes for both Ubuntu testing and Chrome 	OS testing.

Please mention the commit hash of the commit at the top of 
amd-staging-drm-next.

> 
> 		Tested on Ubuntu 22.04 and Chrome OS

I still do not see the Chrome OS version and devices listed. I think, 
that information would be valuable.

>   
> 		Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Kind regards,

Paul
