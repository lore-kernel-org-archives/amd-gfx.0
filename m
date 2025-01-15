Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A978C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 15:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C0510E502;
	Wed, 15 Jan 2025 15:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="hxWiE1mg";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABEF010E06B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 15:10:39 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:2:993:abe1:9e14:e7bd; 
 helo=[IPv6:2a01:170:118f:2:993:abe1:9e14:e7bd]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1736953718;
 bh=Z/ZYMWM6sKchAhjRZp5XZoneEFyfTpW9HB5W3YfIOww=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=hxWiE1mge3LWg7zS+xFCXHsXRFJbOf93zrS8gTV9rvlHgGmC/bBIHE3vb+r+SoG8A
 xVWh1u1kKqM+JtSpXXbux6RWT9Tn8zq3tntaYgHeObFs/wVRBlETH3/lYK/W4Wcasp
 E7eMQAB91w7lYlmd6HsoN5RgEd+aE9r8ZfL9dcWXXruYgYBNp5fMxGT2SNo0BUIY+a
 9vUTJNUe/UDcofC4jP4iWKY1nHsHglNUGGYhDWjmN0v1WyHjbsGbC+aoZv7XBQ9/ZW
 Yno2fOb585QhGmNmxc7ZwwzqL6ZKLDN5c7FCsnmdEt295UK0EWVkTSsHYQTpvJYeT0
 tbxf4mIgZ67kg==
Received: from ryz.dorfdsl.de ([IPv6:2a01:170:118f:2:993:abe1:9e14:e7bd])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50FF8Z1o236195
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 16:08:37 +0100
Date: Wed, 15 Jan 2025 16:08:34 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250115160834.033e8aad@ryz.dorfdsl.de>
In-Reply-To: <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
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

Am 14.01.2025 um 17:25:46 Uhr schrieb Alex Deucher:

> What kernel version(s) is it working properly with?  Can you bisect?

I assume it was 6.12.6, but Debian doesn't have the old packages
anymore and it has been purged from my system already.

I am trying to find a way to get the old kernel for testing.

--=20
Gru=C3=9F
Marco
