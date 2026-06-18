Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F44CD98F8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 07:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A856A10F471;
	Fri, 19 Jun 2026 07:14:28 +0000 (UTC)
X-Greylist: delayed 3863 seconds by postgrey-1.36 at gabe;
 Thu, 18 Jun 2026 15:00:31 UTC
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com
 [185.226.149.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3E810E7CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 15:00:31 +0000 (UTC)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1waDDy-006Jqm-5h; Thu, 18 Jun 2026 15:56:06 +0200
Received: from [10.9.9.74] (helo=submission03.runbox)
 by mailtransmit02.runbox with esmtp (Exim 4.86_2)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1waDDx-0004vS-Kz; Thu, 18 Jun 2026 15:56:05 +0200
Received: by submission03.runbox with esmtpsa [Authenticated ID (1057822)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.95) id 1waDDm-004UAW-Uz; Thu, 18 Jun 2026 15:55:55 +0200
Message-ID: <09dbd11f-a793-4224-a6e4-628e7f87bd22@mupuf.org>
Date: Thu, 18 Jun 2026 16:55:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] drm/amdgpu: Rework IP block soft reset on GFX8
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
Content-Language: en-US
From: Martin Roukala <martin.roukala@mupuf.org>
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jun 2026 07:14:26 +0000
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

On 6/17/26 22:14, Timur Kristóf wrote:
[...]
> 
> Tested on the following chips:
> 
> Polaris 10 (Radeon RX 570)

Tested-by: Martin Roukala <martin.roukala@mupuf.org>

It survived a 1000 hangs coming from a 1000 contexts started all at 
once... and even went through suspend/resume right after!

This is a massively-better experience than a loud reset taking 10+ 
seconds (fan spinning at 100%), a corrupted framebuffer, and needing to 
restart my graphical session every time.

Congrats :)

> Polaris 11 (Radeon RX 560)
> Polaris 12 (Radeon RX 550)
> Fiji (Radeon R9 Nano)
> Tonga (Radeon R9 380X)
> Carrizo (A8-9600)

[...]
