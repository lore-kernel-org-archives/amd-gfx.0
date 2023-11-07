Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697A9C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 17:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E0810E0AA;
	Tue,  7 Nov 2023 17:14:58 +0000 (UTC)
X-Greylist: delayed 395 seconds by postgrey-1.36 at gabe;
 Tue, 07 Nov 2023 17:13:53 UTC
Received: from 10.mo584.mail-out.ovh.net (10.mo584.mail-out.ovh.net
 [188.165.33.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22A610E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 17:13:53 +0000 (UTC)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.146.76])
 by mo584.mail-out.ovh.net (Postfix) with ESMTP id ABD5C28B7E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 17:07:16 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-2xd47 (unknown [10.110.171.144])
 by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 97EB71FE72;
 Tue,  7 Nov 2023 17:07:15 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
 by ghost-submission-6684bf9d7b-2xd47 with ESMTPSA
 id XCnmJMNuSmUKdgAAOnoGkA
 (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 07 Nov 2023 17:07:15 +0000
MIME-Version: 1.0
Date: Tue, 07 Nov 2023 19:07:15 +0200
From: =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up redundant conversions to bool
In-Reply-To: <CADnq5_NpMmo5SdXdStcRMGfcz0v6Nu-ZTORsSHo4_m_piAB77Q@mail.gmail.com>
References: <20231107082839.92061-1-jose.pekkarinen@foxhound.fi>
 <CADnq5_NpMmo5SdXdStcRMGfcz0v6Nu-ZTORsSHo4_m_piAB77Q@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <682272a58c1ddd564271d5828a06947c@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 23.137.251.61
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7981504442826991297
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddujedgtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpvdefrddufeejrddvhedurdeiuddpudehuddrkedtrddvledrvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdpoffvtefjohhsthepmhhoheekgedpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Tue, 07 Nov 2023 17:14:58 +0000
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
Cc: sunpeng.li@amd.com, Bhawanpreet.Lakha@amd.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 skhan@linuxfoundation.org, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com, linux-kernel-mentees@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-07 17:39, Alex Deucher wrote:
> On Tue, Nov 7, 2023 at 4:44 AM José Pekkarinen
> <jose.pekkarinen@foxhound.fi> wrote:
>> 
>> This patch will address the following couple of warnings retrieved by
>> using coccinelle, where there is an explicit conversion to bool that
>> are redundant.
>> 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:94:102-107: 
>> WARNING: conversion to bool not needed here
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:102:72-77: 
>> WARNING: conversion to bool not needed here
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> 
> Thanks for the patch, but this was already fixed by Srinivasan a while 
> ago.

     My bad for not noticing, sorry!

     Thanks though!

     José.
