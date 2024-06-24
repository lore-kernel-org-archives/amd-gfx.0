Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A518C3065D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 07:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C10B10E306;
	Tue, 25 Jun 2024 07:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="DJxRIWYL";
	dkim-atps=neutral
X-Greylist: delayed 318 seconds by postgrey-1.36 at gabe;
 Mon, 24 Jun 2024 17:22:16 UTC
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954BD10E088
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1719249734; x=1719854534; i=markus.elfring@web.de;
 bh=GMEQP3jd8WRb2V1nPNUL0HSascCCaN0HsToYXwfFS2k=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DJxRIWYL2kmFx5Bsz+6lcZS+NJ5F/U4BtddRx8S0NFQAm6MV+w64zRta5yRQ42tF
 YFEhI2Tma8hI17kZeYXmY07jPg9L4ju7uSq0PtTlrInTe2oqYVAO1y3t52eWdxCFP
 /kP5qZRl9lSM+9IldbuDXAAyVKzaxKZSldlpRPUHrQ1zfl1dDuXnW9o6DsfcnG5OI
 YEA5lJL793NDx92efgkrrtDGUUSbzXfLTZ8dwALcIYJOAL4N+l+ecJh8kp5BZytwD
 UrtU6oRCP40q1RYHA7oQ0W9nC1ENRn5GZZv19oz56BAEgOcGIg088quoa8z96s5D4
 6/CKKR/iBd9zPP5Vsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1swVhd2Q90-00mAhP; Mon, 24
 Jun 2024 19:16:43 +0200
Message-ID: <8d9791ba-14cf-481f-8964-341880865a0a@web.de>
Date: Mon, 24 Jun 2024 19:16:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dillon Varone <dillon.varone@amd.com>, George Shen <george.shen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Natanel Roizenman <natanel.roizenman@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20240624024835.2278651-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/amd/display: Check pipe_ctx before it is used
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240624024835.2278651-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iYOxbUd/7f3wK5ncEyBEN/Q53syMelXlMbVXqlZkEbL8mvcBZ6k
 ZrOms3leP2hoDMYqxo0dms8w44Dmr/iNZZ7w692BEhxfOZiYi+xgqiYUU6IK2zdnwpbyops
 xRSRpnX319A30gWC1+zvcpJpP+cu0n0yvD4xhJv0mOp98jFlyb8ILsG8sDVsR3Ax31U7R62
 mxwISQHFqPAKYd/Oj/OfQ==
UI-OutboundReport: notjunk:1;M01:P0:TGsZbDtJVfE=;k6WS4SHfr1KjSrRIO2njWeHeNR1
 T2pl72xOB7nkAIBOWwIglmEAtZCKuBVQX9jxayODEZJ9ntCBU5Vew6uDE2nZX4z3cDMYdgwiX
 oK2iDBf3GZkChVQOhgB0EhlCKCZc/FVqRxvqUGIM6skssfonjHDzVcw49npbthQTDqe8Q749F
 gshfXBQEvQGIhL1StRHz6DwTi66HBbDIZXg1E+Yb5aiGYHo/u6FN/YHWI/b8d9WfB/YSpkyiZ
 exXG/Jg/3D6GgUajEnFlXRkd8Y47jD1fb6MtKVjcuJDuY7ot9j/lUzVFmVf8KOYDfWt9Gbb/t
 qcAR4AB4k0v1vhJBjOPFri4tIuFVUIJ2VodK9dp1WJ7q/ahMdN8wBTG+9w4rQbj7CUXjDlMn8
 B040U9jERA1XMttEb6t0tMPbL1uIDvoQFI7v/q0NpHcETUApFAILa+lSpIh72BD95kyHITq2F
 PpjVpSLAeCB7oIQt4YWoJG4Wn8TeZJ3pzpcFcbr+jiTcmihvNl5Jwlj1gszA6tBblbWk4fnHt
 eSDu+FU2lDHPXpzFhJ6iRIFajGUKosfAySevF2aC3L4d/NTAqGdJ1XRygu4bx0v93m+N9OK9t
 IeaEPFWVhgShbFmqcnQ6F1pEr8p40BhQxwUNeXba+D2z5O+L0WbkFMx3HHYfqgT3FLMtpTYM5
 +OwrmNVtG0eOyvZkENxQ6/u7n4hQ5r/PIXVX2Q+AEyZtEb8Dgm6yEj6HPW56WlyCkg+Qr57Ng
 boBtqrx57AL/CLO8sRyZY7ShAFh1i+0jThyXwzZifI1fh6qMSh887d66nFQb5HsC7yBZSSZXQ
 xeA8l4KMWOnR0JsGIDf5fsBFNumRJAPAKAUXKwmUO7+0w=
X-Mailman-Approved-At: Tue, 25 Jun 2024 07:06:21 +0000
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

> resource_get_otg_master_for_stream() could return NULL, we
> should check the return value of 'otg_master' before it is
> used in resource_log_pipe_for_stream().

A similar fix was integrated already according to a contribution
by Natanel Roizenman.
From which Linux version did you take source files for your static code analyses?

Please take another look at the corresponding software update.
[PATCH 16/37] drm/amd/display: Add null check in resource_log_pipe_topology_update
https://lore.kernel.org/amd-gfx/20240422152817.2765349-17-aurabindo.pillai@amd.com/

Regards,
Markus
