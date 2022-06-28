Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 15:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8752710F055;
	Tue, 28 Jun 2022 15:14:18 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C8E112A9D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 15:13:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 23F5460F0D;
 Tue, 28 Jun 2022 15:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE345C3411D;
 Tue, 28 Jun 2022 15:13:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="Mvf/U4H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1656429219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BSloj0brG5bY7mdOHUoBdYMTWYdqdgpOBJQxXJWQhIs=;
 b=Mvf/U4H250uHD//VCHHEFWF4dRnaFg8uUreDF0NEjyU7kploiNMNxYd1qnBixnjkj4vdtJ
 +fftl9mN1dhrW3k3z8d8Fe1canDszKfF/p3MA812sAVw1NTQ+YSeEOH87Ll8MBgIBzTp4E
 mJ/kFO2wa0G2AHHHxGQle358Cf5+Z7M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fdb5660b
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Tue, 28 Jun 2022 15:13:38 +0000 (UTC)
Date: Tue, 28 Jun 2022 17:13:24 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Message-ID: <YrsalGetwIfl8Wkw@zx2c4.com>
References: <1656357116.rhe0mufk6a.none.ref@localhost>
 <1656357116.rhe0mufk6a.none@localhost>
 <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1656421946.ic03168yc3.none@localhost>
X-Mailman-Approved-At: Tue, 28 Jun 2022 15:14:17 +0000
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
Cc: wireguard@lists.zx2c4.com, alexander.deucher@amd.com,
 Todd Kjos <tkjos@android.com>, paulmck@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xinhui.Pan@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, rcu@vger.kernel.org,
 Hridya Valsaraju <hridya@google.com>,
 Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, urezki@gmail.com,
 Christian Brauner <christian@brauner.io>,
 Joel Fernandes <joel@joelfernandes.org>, Theodore Ts'o <tytso@mit.edu>,
 Martijn Coenen <maco@android.com>, Suren Baghdasaryan <surenb@google.com>,
 uladzislau.rezki@sony.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Tue, Jun 28, 2022 at 11:02:40AM -0400, Alex Xu (Hello71) wrote:
> WireGuard and random also use CONFIG_ANDROID in a similar "proxy" way as 
> rcu, there to see if suspends are "frequent". This seems dubious for the 
> same reasons.

I'd be happy to take a patch in WireGuard and random.c to get rid of the
CONFIG_ANDROID usage, if you can conduct an analysis and conclude this
won't break anything inadvertently.

Jason
