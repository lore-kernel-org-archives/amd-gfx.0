Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5BFC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 18:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAA310E0A2;
	Wed, 29 Jan 2025 18:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="cZ+KPgmY";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A91410E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 18:57:15 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:2:abc0:2524:932c:126c; 
 helo=[IPv6:2a01:170:118f:2:abc0:2524:932c:126c]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1738177033;
 bh=ap4X4VFDghIjOrLcgtJJvWfbwPXsARjnsIvT7qdY9EA=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=cZ+KPgmYV/R45mYvXG4fl5N5KWIAno27qVjIVDF67Noy1RQRNOaB+qK14mWKZMqfV
 VcjVDUIxqeKWefoEBIPeo5PgEi8bG8uV9IzEBt8WdokM9n0r/F/tWefFdggZGueMdd
 BQEXZPUPYwlYfwiv7AOH8z1u0n9rm5ebCM+L8pWUOmK7pzVEpg8uiCW2pLaB/RdN7b
 YQ5omhsX9LoQRls8upE0ogVocPQ1Wtl5Be0lOR07LVX/cuXpzyypb/LNJIArt2Gb8x
 33Fop5smkBfQY5Om3kGkajHQdGgezdWcTOk3hEvX28UUZ7NSlkCJTsDiMTqsib1Yw2
 Gv7O79qxulXKw==
Received: from ryz.dorfdsl.de ([IPv6:2a01:170:118f:2:abc0:2524:932c:126c])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50TIvCEm069828
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 19:57:13 +0100
Date: Wed, 29 Jan 2025 19:57:11 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250129195711.0d013ea4@ryz.dorfdsl.de>
In-Reply-To: <CADnq5_Pg2JMuJ13ow0AcVgMqUvin6Oj41hmWYqP6+Vrjq3cMWQ@mail.gmail.com>
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de>
 <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
 <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
 <20250116172916.0dba9ff6@ryz.dorfdsl.de>
 <CADnq5_NU-stpay1uFHXD9fVemg4snyE-eZZ4rfyg2Mc3x2OLyg@mail.gmail.com>
 <20250116173734.256704ca@ryz.dorfdsl.de>
 <CADnq5_O_WcZJ7yoDKEJpktSqffbP8RENhChmkD8Es7NHRYhCAg@mail.gmail.com>
 <20250124110225.6a0a87ad@ryz.dorfdsl.de>
 <CADnq5_PwhCK0DfUrEgmdpoFmcBcS-FobGf8p20fSDHOrPTFrNg@mail.gmail.com>
 <20250125193837.373438f7@ryz.dorfdsl.de>
 <CADnq5_ODfJtaRpQpkSbkSuCQobHyz3QZ-CO2KkPuaqHBuupKvw@mail.gmail.com>
 <CADnq5_Pg2JMuJ13ow0AcVgMqUvin6Oj41hmWYqP6+Vrjq3cMWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Am 28.01.2025 um 12:06:11 Uhr schrieb Alex Deucher:

> Another potential better patch to try.

Still freezes without=20
amdgpu.ppfeaturemask=3D0xfff73fff

--=20
Gru=C3=9F
Marco
