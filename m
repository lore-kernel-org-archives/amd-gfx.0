Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A97C5B567
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D550810E69E;
	Mon, 10 Aug 2026 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=kroah.com header.i=@kroah.com header.b="cMJmjHOM";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/Tf6INi";
	dkim-atps=neutral
X-Greylist: delayed 382 seconds by postgrey-1.36 at gabe;
 Fri, 07 Aug 2026 09:26:43 UTC
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F56810F428
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 09:26:43 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CFAA4140012B;
 Fri,  7 Aug 2026 05:20:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 05:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1786094420; x=1786180820; bh=bW0tQnim3i
 wnUXMRe5q5LEz2D7nm1uUXRXSopazV0Dg=; b=cMJmjHOMBA1/w/bb6kPlUW0Vp0
 sCLPb7Bf9iwh77CKnkl8IMUMmW+mL7uRwth+pDX3jvMundH2USsxcdY5CzIvxwGP
 zgqKOSmB1q8WT7D4UAlEj7yHPPjdEhzNiZ9rylZUOU4uD4n//bncZKUhS3jHDJif
 lhtiE6ujc+HyTvxKEPgbvYn9a9Ls609Jspm9L2rB079RIVgbZXXupDGLlQa9BTAB
 424qMYKXNIWUbixdq/5mMkk6evfthVWA1gAG91xnHmDJzvxJ/a0VH7iU9s/e+ncn
 1Z7F3KC9FocWQ72CZgWYhC7BurhWshoi/pduru7SkyOZuXGGfTuFbu5dJieg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786094420; x=1786180820; bh=bW0tQnim3iwnUXMRe5q5LEz2D7nm1uUXRXS
 opazV0Dg=; b=e/Tf6INiUGnCCFkckc6DNF3CVTSWXeM0/mh4WZQQcAwshH8FZBW
 iAcSWlBNfzWu/XmCO9JJaD/VLWpfcXmYzs+DwEi7C0dbyur0dhEI0o3pqwNBJdan
 ssW3/ws+z4Yhi5HVcZuwobbeXql62lAzN6OiiquBds8+kRVoX8YJYSFXqn3u+d1o
 XxOOS1Wgl8uMejSAMamADmR680cM2zy3Ic83+Czwoi1rPHqArY9Hl9ez5akmtugz
 bQ1V+/3ajeOiicBmbLL+vCUGsPMvVe0rQaRX43U5eY9bDwGTqjDOWijgOGVuKn7r
 Kl2uoQbxBa+N8L2EhBIFGevr+9bhtwuzX8w==
X-ME-Sender: <xms:VKN1aoL_eX3Ea-2-tImJHTLBSTkvJvW1K0v0gtlXHX-NdB_C54iM0Q>
 <xme:VKN1augUw6LQs9ECGBCu5HqHmk27OXUekdhiPSOoVGZbmOwu9GOUi254d8W-Tiazl
 BmUBT3eomfiy6lndO6VLfcuArVicaa4FYaaDZsaj9OOKqErkZo>
X-ME-Received: <xmr:VKN1ak94qITO9HjtYAdk-Daq1Z4lIhjFtExj8mzZSKoK4_HmNw1FDLbdlRjJBtZiL_oVPJcvA8Ko_lmDGKiiThV_TH2pLW7etX-sS2LU4Xk>
X-ME-Proxy-Cause: dmFkZTEXz6JgljYsuuywyt2P/TC5kwPqYV+GDeamYu699GvUq0gC2/sHE9b1kBTBG+uA2D
 7P+tWfJQG5dGOpwpCLB06aQveFm5DPrpuYPASWgZsIdddWkjt7wNed462lNBaw8+t1DUFs
 XUqhenpnxxehV7VTumOlm+ISSjVHu8FRmObeDmdVdqy5XHXCZZakAvBxQlPXH+0ixoKHkQ
 79o+UzXozwNuh9iDcKdmJF/TbxgXwFEXDn8+9ostf9iBv1TPE7UHrwAZbYBZVi28i4P4ue
 46Xq7/BWaOWUzORWeqPQEV781YdCwdWxqfykFhd/wm3yEc1DHo0Z5pljfvSY3GwADvFrWx
 EmWeWyNjyKa9eGoEqfkmJzB6p1L4UzZf2tsU5l+kw1hYS/Nt2W46no0IWRLd1BD+4aa7QJ
 WxlLaXVoDX1gjkyupNvysTftMFf27feqcN0hj77yK2O/3j8eZ1Q/1YOVqN6g7TIrW93sgP
 NXm8y69hjv5mfGuBcvkQgBHhZ8wSkFS7M7PUnVDGCjrM3aICDMHTmprUrdLhAcXgkodR3i
 D5M0tjFbwxzHpAj8/LpMabZj11LppJx2WNxWsnQapcIwNIp9doLL9XzcH9jKliPzcl0yFj
 BOaWcmRmnJQxYKcsKU1MSJqR1mkPg6RSD+7bTHh2vTuoTd9jbFWvy67JExuA
X-ME-Proxy: <xmx:VKN1ajPTE6jiziFQc_6XlVwF50_ZaNAqWaaBswQBZKpRZYjEbiazKQ>
 <xmx:VKN1aoDJHuYplZ2FBXG5XFusLmxyWWELMPcPUcRfwCECN-uUBaWAcw>
 <xmx:VKN1anMXz3PXDDeboYgYONsvb1Gamd-NwxJSWElkpyiZ9UFZwLV61A>
 <xmx:VKN1avcwMDBfqaJ1j0gycnNZAwJSr54ERqcKU0DtXXGf1wzb6cG9IQ>
 <xmx:VKN1ahDN7yok5VIxFy182-6lOV6_GJtei8UFqudoMJOedo79fPs8EVGv>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 05:20:20 -0400 (EDT)
Date: Fri, 7 Aug 2026 11:20:03 +0200
From: Greg KH <greg@kroah.com>
To: Leo Li <sunpeng.li@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before
 sending event
Message-ID: <2026080753-urgent-lend-f63d@gregkh>
References: <20260729173742.950965-2-sunpeng.li@amd.com>
 <20260729223316.stable-0010@kernel.org>
 <3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com>
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

On Thu, Jul 30, 2026 at 09:48:36AM -0400, Leo Li wrote:
> 
> 
> On 2026-07-29 22:40, Sasha Levin wrote:
> >> [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before sending event
> > 
> > Thanks for the backports, but I'm going to hold both of these for now.
> > 
> > There are two unmerged Fixes: patches against 48ab86360af1 ("drm/amd/display:
> > check GRPH_FLIP status before sending event") on the list, and I can
> > reproduce a flip_done/login freeze on DCN 3.1.5 with 7.2-rc4, plus there is
> > your own Cc: stable follow-up on top.
> > 
> > Could you confirm which set you want stable to carry before I queue any of
> > it?  Once the follow-ups land in mainline I'm happy to take the whole thing
> > together for 7.1 and 6.18.
> > 
> 
> Hi Sasha,
> 
> There are a few more fixes that merged into 7.2-rc5, with one that is still in flight to mainline.
> Here's the --oneline list of everything:
> 
> In flight to mainline (SHA will change):
>     18e3dd9ef45c6 drm/amd/display: Exit idle optimizations before programming
> 
> In 7.2-rc5 mainline:
>     fbbaca9e20873 drm/amd/display: Fix missing DCE check in dm_gpureset_toggle_interrupts()
>     82730dba0cf9d drm/amd/display: Fix flip-done timeouts on mode1 reset
> 
> In 7.2-rc4:
>     f39283eab44fb Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
>     48ab86360af11 drm/amd/display: check GRPH_FLIP status before sending event
>     8382cd234981a drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock
> 
> Note that the revert target for f39283eab44fb is not in 6.18 but is in 7.1.
> 
> The flip_done/login freeze that you're experiencing is likely fixed by the in-flight fix.
> Link to 7.2-rc5 rebased change: https://gitlab.freedesktop.org/leoli/linux-asdn/-/commit/18e3dd9ef45c6d1813ca1b629e294b151d38149a

So what are we supposed to do here?

totally confused,

greg k-h
