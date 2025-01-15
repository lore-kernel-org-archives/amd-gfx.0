Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47144C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 20:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC57310E522;
	Wed, 15 Jan 2025 20:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dorfdsl.de header.i=@dorfdsl.de header.b="K9at+qVN";
	dkim-atps=neutral
Received: from srv1.dorfdsl.de (srv1.dorfdsl.de [82.139.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B194A10E522
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 20:12:42 +0000 (UTC)
Authentication-Results: srv1; none (SPF check N/A for local connections 
 -  client-ip=2a01:170:118f:5:769d:b986:18ec:4188; 
 helo=[IPv6:2a01:170:118f:5:769d:b986:18ec:4188]; 
 envelope-from=mm@dorfdsl.de; receiver=<UNKNOWN>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorfdsl.de;
 s=default; t=1736971840;
 bh=bp6h6ln42NZls9aWesrFf4XmRIQjR6B7P/rpaLtXiCU=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=K9at+qVNzDWFEAOPRlh21Bdn3veX9spcEZLvgdG7fE0U8Xv4XvZ7WBzKYOlT3I+At
 tn+o6Uzl/ivHgS6yJjpbb0rp7089xK8QImY+QA00aNQFc7rS7FV57S0RiVXkIRF0Ct
 0MT+2QFh5J7SvprJOSwsL2C1AniBY0FV74P2HAk4DqU9K+CuzoJ9Im7cF0E+yu2OCa
 sdtKI6OuCPH/SuAQe5NeUMdQF9PKNeKZaicFJ7cwE/RRVp0xTUjTOgWDMf3Jcmg+h/
 JPM1UId8nSLuf/7K5JzBJihyUewVnuH7gfyemrZ0Ng8b2RPGhoMqB8ZfDPEJmCjHU9
 hIPJeyfT6pfJg==
Received: from zbook ([IPv6:2a01:170:118f:5:769d:b986:18ec:4188])
 (authenticated bits=0)
 by srv1.dorfdsl.de (8.18.1/8.18.1/Debian-6~bpo12+1) with ESMTPSA id
 50FKAel3239254
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 21:10:40 +0100
Date: Wed, 15 Jan 2025 21:10:39 +0100
From: Marco Moock <mm@dorfdsl.de>
To: amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
Message-ID: <20250115211039.09e6e69e@zbook>
In-Reply-To: <20250115160834.033e8aad@ryz.dorfdsl.de>
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de>
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

Am Wed, 15 Jan 2025 16:08:34 +0100
schrieb Marco Moock <mm@dorfdsl.de>:

> I assume it was 6.12.6, but Debian doesn't have the old packages
> anymore and it has been purged from my system already.

I've now tried 6.12.6, same situation.

Any further ideas what could cause this?
