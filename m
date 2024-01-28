Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F3CC47422
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 09:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63052112727;
	Mon, 29 Jan 2024 09:10:40 +0000 (UTC)
X-Greylist: delayed 1270 seconds by postgrey-1.36 at gabe;
 Sun, 28 Jan 2024 11:06:25 UTC
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473AB10E701
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jan 2024 11:06:25 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1rU2eq-0004bW-4H; Sun, 28 Jan 2024 11:45:00 +0100
Message-ID: <acf203a8-b612-437c-a464-228f45e1c694@leemhuis.info>
Date: Sun, 28 Jan 2024 11:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1061449: linux-image-6.7-amd64: a boot message from amdgpu
Content-Language: en-US, de-DE
To: Salvatore Bonaccorso <carnil@debian.org>,
 Patrice Duroux <patrice.duroux@gmail.com>, 1061449@bugs.debian.org,
 Lewis Huang <lewis.huang@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Phil Hsieh <phil.hsieh@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <170612149675.7169.757906919183146487.reportbug@kos-moceratops.home>
 <ZbUB0YWxEET3Y0xA@eldamar.lan>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <ZbUB0YWxEET3Y0xA@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1706439985;
 a3ebfa66; 
X-HE-SMSGID: 1rU2eq-0004bW-4H
X-Mailman-Approved-At: Mon, 29 Jan 2024 09:10:23 +0000
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 27.01.24 14:14, Salvatore Bonaccorso wrote:
>
> In Debian (https://bugs.debian.org/1061449) we got the following
> quotred report:
> 
> On Wed, Jan 24, 2024 at 07:38:16PM +0100, Patrice Duroux wrote:
>>
>> Giving a try to 6.7, here is a message extracted from dmesg:
>> [    4.177226] ------------[ cut here ]------------
>> [    4.177227] WARNING: CPU: 6 PID: 248 at
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:387
>> construct_phy+0xb26/0xd60 [amdgpu]
> [...]

Not my area of expertise, but looks a lot like a duplicate of
https://gitlab.freedesktop.org/drm/amd/-/issues/3122#note_2252835

Mario (now CCed) already prepared a patch for that issue that seems to work.

HTH, Ciao, Thorsten
