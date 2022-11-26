Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A93FC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Nov 2022 08:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B494510E2AD;
	Mon, 28 Nov 2022 08:26:30 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 155E110E7B3;
 Sat, 26 Nov 2022 00:13:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 20D2F61151;
 Sat, 26 Nov 2022 00:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C5AC433C1;
 Sat, 26 Nov 2022 00:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1669421606;
 bh=F2Iz4FmHG/F1E/NZVczN3uc6knKQCTCJz/o482AKOHI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Xc82kQZsd+dQC/numsQShfrRl+O0J8DnCYj1NMIktTDjsGED0IanHoKaOvb7l6l9W
 oyafUj9mcWJNEimTbhve+jbIwR6TknhuIP/fj2WgmMJHG9oI1T07xeHAmMfC/UNu6A
 Uq12fxjx9eR+6SxN34H8xSMxLbYx+XtpzKU+ElTI=
Date: Fri, 25 Nov 2022 16:13:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix a bunch of allmodconfig errors
Message-Id: <20221125161325.bed715211b887d0a298813de@linux-foundation.org>
In-Reply-To: <20221125120750.3537134-1-lee@kernel.org>
References: <20221125120750.3537134-1-lee@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Nov 2022 08:26:27 +0000
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
Cc: llvm@lists.linux.dev, daniel@ffwll.ch, arnd@arndb.de, sunpeng.li@amd.com,
 ndesaulniers@google.com, dri-devel@lists.freedesktop.org, Xinhui.Pan@amd.com,
 maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
 mripard@kernel.org, nathan@kernel.org, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, tzimmermann@suse.de, trix@redhat.com,
 alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 25 Nov 2022 12:07:48 +0000 Lee Jones <lee@kernel.org> wrote:

> Since b339ec9c229aa ("kbuild: Only default to -Werror if COMPILE_TEST") WERROR 
> now defaults to COMPILE_TEST meaning that it's enabled for allmodconfig        
> builds.  This leads to some interesting failures, each resolved in this set.   

I'm not sure who this patchset is aimed at, so I'll take my usual
approach of grabbing it and seeing who complains.

> With this set applied, I am able to obtain a successful allmodconfig Arm build.

b339ec9c229aa is a year old and I've been doing arm allmodconfig for
ever.  What am I missing here?

A broken arm allmodconfig is pretty irritating - I'm thinking that a
fix should be backported into -stable kernels.  But I'm clearly missing
something here.

