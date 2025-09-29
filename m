Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D64CCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 07:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA2610E8DA;
	Fri,  3 Oct 2025 07:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2IR/w1Nh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61B1B10E428;
 Mon, 29 Sep 2025 13:50:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 663D462505;
 Mon, 29 Sep 2025 13:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F31BC4CEF7;
 Mon, 29 Sep 2025 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1759153800;
 bh=ZP+96JhjkkrBnIK+mwXVIYMy7g62X4hPExrb6o1Qe/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2IR/w1NhD6rO3VZzjaHsa/G5y5Y6EFTRaRCQoBFOIMmzFRk3gM0W0Mf+I/1sje/zM
 6eTkAuMiRzcWzHrNhmk6po9GpoWWRMGPau/mhN/FLC8qEKMftJ9tX/aLdXfc1Agx/E
 GgRNIXRtdpmNbgceNNbtDpd4ehAmTPd7HqANSrhw=
Date: Mon, 29 Sep 2025 15:49:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: linux@armlinux.org.uk, richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 tony.luck@intel.com, qiuxu.zhuo@intel.com, mchehab@kernel.org,
 james.morse@arm.com, rric@kernel.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 evan.quan@amd.com, james.qian.wang@arm.com, liviu.dudau@arm.com,
 mihail.atanassov@arm.com, brian.starkey@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robdclark@gmail.com, quic_abhinavk@quicinc.com,
 dmitry.baryshkov@linaro.org, sean@poorly.run, jdelvare@suse.com,
 linux@roeck-us.net, linus.walleij@linaro.org,
 dmitry.torokhov@gmail.com, maz@kernel.org, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, agk@redhat.com,
 snitzer@kernel.org, dm-devel@redhat.com, rajur@chelsio.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, krzysztof.kozlowski@linaro.org,
 malattia@linux.it, hdegoede@redhat.com, markgross@kernel.org,
 artur.paszkiewicz@intel.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, sakari.ailus@linux.intel.com,
 fei1.li@intel.com, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, jack@suse.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, dushistov@mail.ru,
 luc.vanoostenryck@gmail.com, rostedt@goodmis.org,
 mhiramat@kernel.org, pmladek@suse.com, senozhatsky@chromium.org,
 andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
 minchan@kernel.org, ngupta@vflare.org, akpm@linux-foundation.org,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, fw@strlen.de, jmaloy@redhat.com,
 ying.xue@windriver.com, andrii@kernel.org, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, keescook@chromium.org,
 wad@chromium.org, willy@infradead.org, sashal@kernel.org,
 ruanjinjie@huawei.com, quic_akhilpo@quicinc.com,
 David.Laight@aculab.com, herve.codina@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-edac@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 platform-driver-x86@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-mm@kvack.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, tipc-discussion@lists.sourceforge.net,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 07/19 v6.1.y] minmax: make generic MIN() and MAX() macros
 available everywhere
Message-ID: <2025092923-stove-rule-a00f@gregkh>
References: <20250924202320.32333-1-farbere@amazon.com>
 <20250924202320.32333-8-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924202320.32333-8-farbere@amazon.com>
X-Mailman-Approved-At: Fri, 03 Oct 2025 07:03:32 +0000
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

On Wed, Sep 24, 2025 at 08:23:08PM +0000, Eliav Farber wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> [ Upstream commit 1a251f52cfdc417c84411a056bc142cbd77baef4 ]

<snip>

As this didn't go into 6.6.y yet, I'll stop here on this series for now.
Please fix up for newer kernels first and then resend these.

thanks,

greg k-h
