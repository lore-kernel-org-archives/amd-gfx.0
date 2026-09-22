Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053E1C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AAB10E375;
	Tue, 22 Sep 2026 08:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="BPbP2wCY";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [185.244.194.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D712210E477
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:20:51 +0000 (UTC)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hptLF231Rz98sZ;
 Tue, 22 Sep 2026 10:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1790065173;
 bh=o+72YWQvPnMyVfj14Ks97oOHbWB67rkCtT351XOG2+k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BPbP2wCYqFaPudqq6ZrqieU45jfpX7OIG1xK5SnQe+9OptdMp0zlfTRvdFuhowiTW
 Gpo/cGN8rJVNUjX7CEbsqAfJaDhDps4GlSJlSvoOFNqNcxUTrJDslTBRxys1l7aNNa
 bsngLdQhR7FR3HVUNxVFxqK7BZV3/9JYFPj2SZTZlx4dhj+5HuDzJ75KLwrnt/ZMP6
 NbTqMr231pD1mQjj9X3zux/rsOETcXYP8YUyk21T5g0Dy6RQBld2I+wSh7PuyJ0/MA
 V9207NSfd21wFR2t54J123+eEGeHc7x4QmbCSbc45sc4xywMIVSfxADBkjmtRzRlKY
 F0YbxbW3+I1DA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hptLF1K3Hz7wgc;
 Tue, 22 Sep 2026 10:19:33 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hptLD4zKKz8tHB;
 Tue, 22 Sep 2026 10:19:31 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 1ED645FAE9;
 Tue, 22 Sep 2026 10:19:27 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <95c7b907-b238-442f-ac2e-78edda7fdd36@leemhuis.info>
Date: Tue, 22 Sep 2026 10:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/ttm: NULL dereference in
 ttm_resource_add_bulk_move after OOM on Navi32
To: =?UTF-8?B?6LWk5bKh5oKg?= <c0a25004a6@edu.teu.ac.jp>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CA+Y9VQPNWWGFqErKbbM+S2PcEXbJ30O71sA6h8s-+YVRMC51TQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CA+Y9VQPNWWGFqErKbbM+S2PcEXbJ30O71sA6h8s-+YVRMC51TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179006516742.266935.14180532826607751970@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 1ED645FAE9
X-NC-CID: GRzHa4zDgXgF+KZ7C1DDbD9bQU8zSgPphq6RYtPGo7CnV+6M8mg=
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:41:04 +0000
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

On 9/19/26 19:17, 赤岡悠 wrote:
> CachyOS package issue: https://github.com/CachyOS/linux-cachyos/issues/1058
> 
> I hit a kernel Oops in the AMDGPU/TTM swapout path on a Radeon RX 7800 XT. The
> failure happened immediately after a global OOM condition and was followed by an
> RCU stall and a host reset.
> [...]
> This looks related to the recent TTM fixes:
> 
> - [3db7d7d](https://github.com/torvalds/linux/commit/3db7d7d583419f7b1f2e141e36418802dbb25cf8)
>   fixes swapped-out resources remaining in a `bulk_move` range.
> - [fcfe647](https://github.com/torvalds/linux/commit/fcfe64715b425262af1b36f498f9197f3537ceed)
>   changes the cleanup condition after `ttm_tt_swapout()` from `if (!ret)` to
>   `if (ret > 0)`.
> [...]> Does this match the stale `bulk_move` endpoint issue fixed by
> `3db7d7d`/`fcfe647`,
> and should those fixes be backported to kernels based on 7.2.4?

They are marked for backporting; feel free to test them and report your
results -- if they fix your problem we can ask the stable team to
shortlist them.

Ciao, Thorsten
