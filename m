Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A18C02185
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2025 11:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B337510E0E5;
	Sat, 18 Jan 2025 11:26:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="uOoTHB0t";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE34010E0E5
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jan 2025 11:26:18 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:5:fc78:1220:436c:5e3e; 
 helo=[IPv6:2a01:170:118f:5:fc78:1220:436c:5e3e]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1737199456;
 bh=ANmS9tzUiBKaQOTRNN+4G3GdWwf3O2yOXb7AN4h+v+Q=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=uOoTHB0tu+C2gpkEfSE+fNu9nBx0W7h+02FVR0eOr0VgUw1rUpl77HhDdIGs7YH1G
 9183gVo4iksovFkTnW8U6M1A3gSGqeTbT9kY/HIr2w35rJtfGX301YpyWPh+7UmNmR
 zPLeugDvKdcvcZh4h1DDJuzaz749lGBfU10m5GuPBECODDhV9qR3QAc+r/BN8IH8wK
 IRZ6R8k3zMVwWjd9ynF6K8xiI0QTnfTsI6F1zRa5CMNwLrUGyUE1EIyfpi07G8A3Gc
 B81Z5Rk3b2li8wlaFQkoN0Z1KgUv6fiaLejLpzn3SHx1kSxCBqooJZPSuyns22hUYt
 ZkgM9JKoGdZLA==
Received: from zbook ([IPv6:2a01:170:118f:5:fc78:1220:436c:5e3e])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50IBOGMN268735
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jan 2025 12:24:16 +0100
Date: Sat, 18 Jan 2025 12:24:15 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250118122415.7c4d9091@zbook>
In-Reply-To: <20250115211039.09e6e69e@zbook>
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de>
 <20250115211039.09e6e69e@zbook>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am Wed, 15 Jan 2025 21:10:39 +0100
schrieb Marco Moock <mm@dorfdsl.de>:

> Am Wed, 15 Jan 2025 16:08:34 +0100
> schrieb Marco Moock <mm@dorfdsl.de>:
> 
> > I assume it was 6.12.6, but Debian doesn't have the old packages
> > anymore and it has been purged from my system already.  
> 
> I've now tried 6.12.6, same situation.
> 
> Any further ideas what could cause this?

I've now tried 6.12.5, same problem.
I noticed that it often happens when I play videos or do video
conferences in the browser.
