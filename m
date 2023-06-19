Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C772EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 07:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE2AF10E26B;
	Tue, 20 Jun 2023 07:09:57 +0000 (UTC)
Received: from smtp.kvr.at (smtp.kvr.at [83.65.151.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA0C810E06B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=20200417.ckk.user;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IlrSmA/LOGBJmXy5aVzLSVP8j6MkTyK3zdgaviVwT2w=; b=Kjs6lexnFXtTGFPg33Ni8yQ9D+
 EM7KQGj9W96XYxSN7HYvKHPPBP5W5FpTXh9I01qev29b2E7VrH+C5U8Lzt7kBFQWRMqxo+igqLXkE
 /m1BNFObqKuEPRQWeCqPgKIiPSIttoE4Y6cJiIWZEKGHJXGFgiM/+oHCAmpNfGdvdodOBiXIhnbgw
 6hvNgEYXWABrlCtyF0XkTC3ieAB3gU9WzaiI3CilGFkS6sPzqOJHxT9X/K6JFoYJZE5/yt1MXbGsM
 Gvq+AHVbLtbzDgO+662Q5u/a33tAUXptZGOta8ETg/xVZJNptXPAiAw/tUd+esWpIYfotJBdlejsW
 IYz74xxRstAk8r+NE9dtEfuNTn9YuEkdbnbLvbDLnekXWxe5ZstbEFsDW9dtUop7N07dCb4XVyNRP
 mjcBcPspfn+1B6t/GFg9BZ+ZSDqIesE6aXjq3Km89qp2avLkZNLyiCGEjwOmhjMXFgNirE0Rmvgft
 ekyadW6s77If6B/XYiD8GeQ6wSYg/i2l0G+LzkcHo3EV+TXde9zV8yBP8BZv/pItf51wInjHdTQH+
 5f4jZzHj9msPrWamHLfYOCOa2J5lsRF7HHv1ngrryzRSK2I8qPfv3JqA5OuXwofv2bBjn+nWeXWF+
 lubwgJM7q4upRUh3zLJ7jldcCK1u9Djo62T1BwJuo=;
Received: from [192.168.0.7] (port=53252)
 by smtp.kvr.at with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
 (Exim 4.96) (envelope-from <ckk@debian.org>) id 1qBGBZ-001uXk-2X;
 Mon, 19 Jun 2023 16:48:53 +0200
Message-ID: <ae413961-7de2-b5a4-3ecd-ab29a158ee26@debian.org>
Date: Mon, 19 Jun 2023 16:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Warning appeared after c8b5a95 ("drm/amdgpu: Fix desktop freezed
 after gpu-reset")
To: Alex Deucher <alexdeucher@gmail.com>
References: <113ba574-90b4-1a7f-5982-d9de8d12c24b@debian.org>
 <CADnq5_P6h1YQBO3TRWoEPBAzfSzJOCgUyY2xw2WWPmnW48Sq7A@mail.gmail.com>
Content-Language: en-US
From: Christian Kastner <ckk@debian.org>
In-Reply-To: <CADnq5_P6h1YQBO3TRWoEPBAzfSzJOCgUyY2xw2WWPmnW48Sq7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Jun 2023 07:09:56 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-19 16:05, Alex Deucher wrote:
> On Mon, Jun 19, 2023 at 9:05 AM Christian Kastner <ckk@debian.org> wrote:
>> On a Debian 12 ("bookworm") system, I observed a new warning when I
>> upgraded from kernel 6.1.25 to 6.1.27. This is on a system with an RX
>> 6800 XT GPU and 3500X processor.
> 
> The warnings are harmless, but they have been fixed[1] and the fixes
> are making their way back to stable kernels.
> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=08c677cb0b436a96a836792bb35a8ec5de4999c2

That was quick. Thank you for pointing out the resolution.

Best,
Christian
