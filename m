Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B2DC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Nov 2022 08:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5358F10E2B1;
	Mon, 28 Nov 2022 08:26:31 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B68510E7BD;
 Sat, 26 Nov 2022 00:18:02 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3D57CB82BD7;
 Sat, 26 Nov 2022 00:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381A8C433C1;
 Sat, 26 Nov 2022 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1669421878;
 bh=N0BkCIonzZFjorKsjBaLOWHmBGWXxgq4vQOHZYYI+QM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=u0dmufMBeU/Hge17mRXBmPGXWvfk84ictiDbNzdkhYWzCJka/K8Y897LxUKz7Vj3z
 U1yJUtWHtoZFdoY4wBcpYuMB3DmBgMpNNHUtIQgiLA4Nb1IDJvLIqamUoTUitgl9U8
 USOEXxWnBItN7/5B+3liMkAy2ysF02xGzrkMnRvk=
Date: Fri, 25 Nov 2022 16:17:57 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix a bunch of allmodconfig errors
Message-Id: <20221125161757.73f96b3b90f4884509097352@linux-foundation.org>
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

Oh, I get it.  Clang.  I'll tweak the above para to make that clearer.

cc:stable question still applies?  How much trouble will these build
errors be causing people for the next N years?

> With this set applied, I am able to obtain a successful allmodconfig Arm build.
