Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC805CA0FF6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 06:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666C910E3AD;
	Thu, 28 Aug 2025 06:56:01 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C70210E817
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 13:12:12 +0000 (UTC)
Received: from [192.168.4.18] (unknown [62.77.71.229])
 by mx.gpxsee.org (Postfix) with ESMTPSA id D49165D2A0;
 Wed, 27 Aug 2025 15:12:10 +0200 (CEST)
Message-ID: <b7b11007-b45e-4d06-baad-cf16926e4c6e@gpxsee.org>
Date: Wed, 27 Aug 2025 15:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: radeon module hangs boot on HD 7450 and Linux 6.17-RC1
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <c285c72e-08de-46f9-b30a-a938c722d3ad@gpxsee.org>
 <CADnq5_PBSKT8=9JTpiSF1ygpys6J_L7P8brwn9EyQtovaXD=7A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Martin_T=C5=AFma?= <tumic@gpxsee.org>
In-Reply-To: <CADnq5_PBSKT8=9JTpiSF1ygpys6J_L7P8brwn9EyQtovaXD=7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Aug 2025 06:55:55 +0000
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

On 8/27/25 2:47 PM, Alex Deucher wrote:
> On Wed, Aug 27, 2025 at 3:57 AM Martin Tůma <tumic@gpxsee.org> wrote:
>>
>> Hi,
>> While working on our mgb4 driver with the "next" v4l2 git
>> (https://git.linuxtv.org/media.git/log/) branch my machine with a Radeon
>> HD 7450 hangs during boot and the monitor looses signal. If I disable
>> the radeon module, the machine boots fine (to some kind of VGA
>> fallback), so I suspect the bug is in the radeon module. With the Arch
>> distribution kernel - 6.16.3 - the machine boots fine.
>>
>> The media.git "next" branch identifies as 6.17-RC1, so it may not be the
>> latest radeon code available. If the issue has been fixed since than
>> sorry for my spam, otherwise please provide some info how I can help you
>> to debug the issue.
> 
> Should be fixed in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c0a8e4443d768e5c86ddb52a3a744a151e7b72b0
> 

Ok. Thanks for the info.

M.

> Alex
> 
>>
>> M.

