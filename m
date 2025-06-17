Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761C6C7115A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 13:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A0C10E690;
	Tue, 17 Jun 2025 13:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="BBArIcmN";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9CF10E58F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 09:42:05 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7B0E425F98;
 Tue, 17 Jun 2025 11:42:04 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLfz8DzFOpKU; Tue, 17 Jun 2025 11:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1750153323; bh=kEVr5LRDJXI5+NMKIDFQUd9VmCGFm55tC/Y7nPANTt8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BBArIcmNxHIoKXxCgCBxozEjIHCMN0lxBNp8rZFkzi4cfUkTmHUYZA+btASY+rxE0
 Zk42MC5u/x40Y32dkU6MEq9405EV1UR2DhNI8mtSCelB1EOtsnKjYkm+qNFPmtjFup
 Xnb5iAjftrdy6AcGBVVFQaBW0EP1mU4N9lYhMgc7iOxlUrgDgbvXY2D1MUOe5jtyfo
 2L7b475uhTOlyAtprlcIMMw06ieRPzrRUOxzGS+MqMwcs3KmWSW4fyv+GhBaLcMd1e
 JOaJEZDqCoT9jxAsG2/W76gPiEMQZcfwYF6W+0HLBSMiUJSVT084pZYKoMKAD6hHlg
 aqi5zH64yEj4Q==
MIME-Version: 1.0
Date: Tue, 17 Jun 2025 11:42:03 +0200
From: machion@disroot.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Subject: Re: Unplayable framerates in game but specific kernel versions work, 
 maybe amdgpu problem
In-Reply-To: <CADnq5_PkOuAHuDjMNXABEcenaZFZgU044G=9pTu=EgMr_grXbw@mail.gmail.com>
References: <c415d9e0b08bcba068b01700225bf560@disroot.org>
 <CADnq5_PX1dYF2Jd3q7ghaBjpPhNLq9EmFJtN1w6YOSfVo++7sA@mail.gmail.com>
 <69b5ebaa719355994a383fa026dc3fba@disroot.org>
 <CADnq5_PkOuAHuDjMNXABEcenaZFZgU044G=9pTu=EgMr_grXbw@mail.gmail.com>
Message-ID: <fadf714ecdc2e3bd5bed0c3ee69177a1@disroot.org>
X-Sender: machion@disroot.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Jun 2025 13:02:39 +0000
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

I feared that.

It seems a crazy problem, when many people are affected and in opposite 
ways.
This ReBAR/UEFI thing is also new to me, but I don't have this on my 
system either (using BIOS/MBR).

I hope, it can be fixed for all scenarios.

Marion

Am 2025-06-16 15:29, schrieb Alex Deucher:
> On Fri, Jun 13, 2025 at 3:38 PM <machion@disroot.org> wrote:
>> 
>> Hi,
>> sorry for the delay.
>> Besides less time, I had to make myself familiar with bisecting and
>> again kernel compiling. Last time I compiled the kernel myself was
>> around 2010 I think.
>> 
>> Anyway it seems I found the bad commit. The result after bisecting 10
>> commits is:
>> 
>> a53d959fe660341788cb8dbc3ac3330d90a09ecf is the first bad commit
>> commit a53d959fe660341788cb8dbc3ac3330d90a09ecf
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Thu Mar 20 14:46:18 2025 +0100
>> 
>>      drm/amdgpu: immediately use GTT for new allocations
>> 
>>      commit a755906fb2b8370c43e91ba437ae1b3e228e8b02 upstream.
>> 
>>      Only use GTT as a fallback if we already have a backing store. 
>> This
>>      prevents evictions when an application constantly allocates and
>> frees new
>>      memory.
>> 
>>      Partially fixes
>>      
>> https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2833985.
>> 
>>      Signed-off-by: Christian König <christian.koenig@amd.com>
>>      Fixes: 216c1282dde3 ("drm/amdgpu: use GTT only as fallback for
>> VRAM|GTT")
>>      Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>      Cc: stable@vger.kernel.org
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> 
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Unfortunately reverting that commit will reintroduce a similar
> performance issue for lots of other uses.  See:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3844#note_2827990
> for a description of the fundemental problem.
> 
> Alex
> 
>> 
>> Marion
>> 
>> 
>> Am 2025-05-08 15:18, schrieb Alex Deucher:
>> > On Thu, May 8, 2025 at 9:13 AM <machion@disroot.org> wrote:
>> >>
>> >> Hello kernel/driver developers,
>> >>
>> >> I hope, with my information it's possible to find a bug/problem in the
>> >> kernel. Otherwise I am sorry, that I disturbed you.
>> >> I only use LTS kernels, but I can narrow it down to a hand full of
>> >> them,
>> >> where it works.
>> >>
>> >> The PC: Manjaro Stable/Cinnamon/X11/AMD Ryzen 5 2600/Radeon HD
>> >> 7790/8GB
>> >> RAM
>> >> I already asked the Manjaro community, but with no luck.
>> >>
>> >> The game: Hellpoint (GOG Linux latest version, Unity3D-Engine v2021),
>> >> uses vulkan
>> >>
>> >> ---
>> >>
>> >> I came a long road of kernels. I had many versions of 5.4, 5.10, 5.15,
>> >> 6.1 and 6.6 and and the game was always unplayable, because the frames
>> >> where around 1fps (performance of PC is not the problem).
>> >> I asked the mesa and cinnamon team for help in the past, but also with
>> >> no luck.
>> >> It never worked, till on 2025-03-29 when I installed 6.12.19 for the
>> >> first time and it worked!
>> >>
>> >> But it only worked with 6.12.19, 6.12.20 and 6.12.21
>> >> When I updated to 6.12.25, it was back to unplayable.
>> >
>> > Can you bisect to see what fixed it in 6.12.19 or what broke it in
>> > 6.12.25?  For example if it was working in 6.12.21 and not working in
>> > 6.12.25, you can bisect between 6.12.21 and .25.
>> >
>> > Alex
>> >
>> >>
>> >> For testing I installed 6.14.4 with the same result. It doesn't work.
>> >>
>> >> I also compared file /proc/config.gz of both kernels (6.12.21 <>
>> >> 6.14.4), but can't seem to see drastic changes to the graphical part.
>> >>
>> >> I presume it has something to do with amdgpu.
>> >>
>> >> If you need more information, I would be happy to help.
>> >>
>> >> Kind regards,
>> >> Marion
