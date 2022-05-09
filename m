Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE5EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C698810EA1A;
	Mon,  9 May 2022 14:28:20 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D2010EA15
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:28:20 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6077D61E6478B;
 Mon,  9 May 2022 16:28:18 +0200 (CEST)
Message-ID: <5b4a80eb-a14b-7402-fe96-83af10a64c8b@molgen.mpg.de>
Date: Mon, 9 May 2022 16:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: How are the DC patches tested?
Content-Language: en-US
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
 <DM6PR12MB352902B7FE179953EBBD474F9CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
 <f284dad0-9a9e-0edb-54df-db97b58451e9@molgen.mpg.de>
 <067c7558-8b07-139a-9eb5-e4fe9ce0cbf0@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <067c7558-8b07-139a-9eb5-e4fe9ce0cbf0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Sun Peng Li <Sunpeng.Li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, Solomon Chiu <Solomon.Chiu@amd.com>,
 Daniel Wheeler <Daniel.Wheeler@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>,
 Agustin Gutierrez <Agustin.Gutierrez@amd.com>,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Rodrigo,


Thank you for the quick response.

Am 09.05.22 um 16:15 schrieb Rodrigo Siqueira Jordao:

> On 2022-05-09 10:00, Paul Menzel wrote:

>> Am 09.05.22 um 15:14 schrieb Wheeler, Daniel:
>>
>> […]
>>
>>> This week this patchset was tested on the following systems:
>>>
>>> Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following
>>> display types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p
>>> 144hz (via USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and
>>> then DP to DVI/VGA)
>>>
>>> Sapphire Pulse RX5700XT with the following display types: 4k 60hz
>>> (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP to
>>> DVI/VGA)
>>>
>>> Reference AMD RX6800 with the following display types: 4k 60hz  (via
>>> DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI and
>>> USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
>>>
>>> Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz and
>>> DSC via USB-C to DP DSC Hub with 3x 4k 60hz.
>>>
>>> Tested on Ubuntu 22.04 with Kernel Version 5.16, and ChromeOS
>>
>> I am curious, what this means exactly? You clone the Ubuntu Linux 5.16 
>> kernel source, and then apply your patches on top? (Do they even apply?)
> 
> All of these "promotion" patches are tested by using 
> amd-staging-drm-next. In a few words:
> 
> 1. We get the latest code from amd-staging-drm-next;
> 2. We apply these weekly promotion patches on top of it;
> 3. We compile, run unit tests, and run many manual tests (Daniel does 
> that).
> 
> If everything is alright with Daniel's tests, we feel confident to merge 
> these series on top amd-staging-drm-next (we are basically trying to 
> avoid regressions here).
> 
> Anyway, maybe we can rephrase:
> 
>   Tested on Ubuntu 22.04 with Kernel Version 5.16, and ChromeOS
> 
> to
> 
>   Tested on Ubuntu 22.04 and ChromeOS with amd-staging-drm-next + 
> promotion patches.

Yes, that’d be great. Maybe even reference the commit hash from the 
commit on top of *amd-staging-drm-next*.

(Nit: ChromeOS → Chrome OS)

>> The same for Chrome OS. Do you use Chrome OS Flex [1] with the systems 
>> you listed? If not, what Google Chromebooks/-boxes did you test with? 
>> The Linux kernel version is also tied for a device and Chrome OS 
>> release. Please mention those too.

As written, the used Chrome OS version (and devices) would be helpful too.

>> Is it documented somewhere, what tests you run exactly?
> 
> We run IGT tests, some scripts that validate some specific areas, and 
> Daniel has an extensive set of manual tests.


Kind regards,

Paul
