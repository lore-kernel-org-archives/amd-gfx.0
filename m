Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E384C2BA2B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 21:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBDB20644
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 21:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt6u/J4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBDB20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6E76E0CA;
	Mon, 13 Apr 2020 21:53:33 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB9E6E0CA;
 Mon, 13 Apr 2020 21:53:33 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id 20so3153776qkl.10;
 Mon, 13 Apr 2020 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kr/9d9Xct1hX07rDbEYx8wUsf1dJ+pFlOXTM040jufY=;
 b=gt6u/J4rlzknBml16vacwiBKZilSvdoYDgWZrDknJ+/046sco+2EB80oMUdV/xHBPs
 JXsoYf9KaaFkZbzeDRtByuMlHipVMlzej9/sgWSKPxw3Y2bbq19joPpCqEeVpFGZN/kW
 LGzexbW2TXKA87eDlyeQPbwbYK//L1/PGzT+32hn9sEykCWesA9Z4Z+XJ6qgnQblAwke
 zxLDzq78qEG9KKKCo/BbyLfOgUYD3uVPXzDtQOaEHP2kvWOMG1rr9rTw2Hse/IGwcYsD
 8Xg55dDgYHJ90FzihCUobI7Sv7LeHFHd7CqDtHUuB7DdwAEPvH+OY+6IqE3xGXs/m7+0
 7kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=kr/9d9Xct1hX07rDbEYx8wUsf1dJ+pFlOXTM040jufY=;
 b=WVx3JHWCRIaTBzMwMuhCF6gx4m1vzqMt96EQ75oDZAfgmaipfEEfqEi6U0RChOH44S
 EXfdyPv/goVk7y+b/Z3nd7Cfv+QcVMiYE11lfwLT1OJzNeBd/Hv9XedMMRlwN2bhZli6
 n/5bQEXPn9Ukei/DESgBlU2Kbp6za3hW727Lh8OIFOq8vZKo/igQZenx6uU/20NrUPXh
 Js9Dm6cYQewkMwD6EnJp12moUleK4E4TpR7a1KH3wdsPDTGDBn7pQvyhLSkgsELTaZg8
 W6CrfQ+AOxYBHDHpEiD3/ggmhoxaekDVonmkV9TaSnpRQrwGADmchWHSaYlAAfwgZVIK
 cr0w==
X-Gm-Message-State: AGi0PuYlmcwObTrwTWu6WvnrFnedZjUwPDPLQiqEy/PdsoedxjlWL4zr
 0EI6EnH0Qma8/hSNRHeJHAA=
X-Google-Smtp-Source: APiQypKYvGVAUQdJvUhUcfpVugeCgnmzh+M4+j8oxN9vOsaUt+g4IHvXRJi0IouPshrZh4OlXSZCIA==
X-Received: by 2002:a37:a0c7:: with SMTP id j190mr9233931qke.461.1586814812277; 
 Mon, 13 Apr 2020 14:53:32 -0700 (PDT)
Received: from localhost ([199.96.181.106])
 by smtp.gmail.com with ESMTPSA id y127sm9339458qkb.76.2020.04.13.14.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 14:53:31 -0700 (PDT)
Date: Mon, 13 Apr 2020 17:53:30 -0400
From: Tejun Heo <tj@kernel.org>
To: Kenny Ho <y2kenny@gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
Message-ID: <20200413215330.GN60335@mtj.duckdns.org>
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
 <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org>
 <CAOWid-dM=38faGOF9=-Pq=sxssaL+gm2umctyGVQWVx2etShyQ@mail.gmail.com>
 <20200413205436.GM60335@mtj.duckdns.org>
 <CAOWid-fvmxSXtGUtQSZ4Ow1fK+wR8hbnUe5PcsM56EZMOMwb6g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOWid-fvmxSXtGUtQSZ4Ow1fK+wR8hbnUe5PcsM56EZMOMwb6g@mail.gmail.com>
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
Cc: Kenny Ho <Kenny.Ho@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 jsparks@cray.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 lkaplan@cray.com, dri-devel <dri-devel@lists.freedesktop.org>, "Greathouse,
 Joseph" <joseph.greathouse@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 cgroups@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

On Mon, Apr 13, 2020 at 05:40:32PM -0400, Kenny Ho wrote:
> By lack of consense, do you mean Intel's assertion that a standard is
> not a standard until Intel implements it? (That was in the context of
> OpenCL language standard with the concept of SubDevice.)  I thought
> the discussion so far has established that the concept of a compute
> unit, while named differently (AMD's CUs, ARM's SCs, Intel's EUs,
> Nvidia's SMs, Qualcomm's SPs), is cross vendor.  While an AMD CU is
> not the same as an Intel EU or Nvidia SM, the same can be said for CPU
> cores.  If cpuset is acceptable for a diversity of CPU core designs
> and arrangements, I don't understand why an interface derived from GPU
> SubDevice is considered premature.

CPUs are a lot more uniform across vendors than GPUs and have way higher user
observability and awareness. And, even then, it's something which has limited
usefulness because the configuration is inherently more complex involving
topology details and the end result is not work-conserving.

cpuset is there partly due to historical reasons and its features can often be
trivially replicated with some scripting around taskset. If that's all you're
trying to add, I don't see why it needs to be in cgroup at all. Just implement
a tool similar to taskset and build sufficient tooling around it. Given how
hardware specific it can become, that is likely the better direction anyway.

Thanks.

-- 
tejun
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
