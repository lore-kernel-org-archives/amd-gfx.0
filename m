Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C63C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 19:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A652C11BE71;
	Wed,  6 Jul 2022 19:41:22 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E83A113583
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 18:09:54 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id s14so19471813ljs.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jul 2022 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=0A598iVSKLysRfv2sRXRDO6tMHET5VOceIuNiuD58/Y=;
 b=RCq4RtcmZ8gfFAM/viGpnHBX7b6YJzB9+TxM8v7brC+iSNmhLCX/k75uH2OP1T7/a8
 bS8oBg/Viter1LXQ7eHV8v2nY5lEBb4Rv3iw0GJ1bZSN0TQm1ffZiqD4NXwPV4veIWVe
 XB1ZUQDinD2dOVWeGYnETXE+m19508Y6Ozq/PcicZqcTgtPcNoKDObAq4iyCDwVYYrq8
 RIkiNu3SHadjcqE0XTgclmFT9xK2C1KbizaIxzPjJEENCITLg1FV+XIOB6MZfdvVcnWl
 4SmvktWXdPoqTf+km4bX9tnC7oUfSZzFD/c6028NywVvCMaAdd7bZ50ArulnCB4I/0vw
 Oqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0A598iVSKLysRfv2sRXRDO6tMHET5VOceIuNiuD58/Y=;
 b=0+Xbw1BJhaCTjITQpwt9AM0rzM8xuvF5Ha2La6YjQnhRw3MIqp3uzkOfNadskAam3B
 2AB/ewVRqYkoK0Tqo7diWwHSIpAEmMcc0btE/xE/Vxdrui08qD+VXoWc/MWQaZuW+qoA
 hRyh0ipdvx7gPX6JKlPS9vif/etPraDW4yPkARyT9BJAs6cxeHsidY7xN55G73+pWGnu
 Dz27HPjCvYyq2sqP8i7DHTnt7LNCZrYiQDAJPt42Mjr5Lq5yO4XHPCezGiXM44nuLJlh
 OrzpQ8MJWlEiE6YyDNqNZojtkXrTv303JlrETgGKBkzlglGHz4g3wSOZkWdBkvSHsDrP
 nYaQ==
X-Gm-Message-State: AJIora/x93dgBcvDi31WAMJsiWy86qkuInLVieZUEU+TOGAy1+TjvXbB
 m2HlJHHv3zoXqlADydSBq/I=
X-Google-Smtp-Source: AGRyM1tVGz9tZcQBzGZVPndJH1FRtpjeuQp7KHQvu/ovYzoH3JzfCWBp9GXAxjZSPbrMCtpzNemUuA==
X-Received: by 2002:a2e:b209:0:b0:25a:705d:c4ba with SMTP id
 l9-20020a2eb209000000b0025a705dc4bamr22643914ljm.468.1657130992430; 
 Wed, 06 Jul 2022 11:09:52 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201]) by smtp.gmail.com with ESMTPSA id
 n24-20020a05651203f800b0047863e5649esm6413063lfq.86.2022.07.06.11.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 11:09:51 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Wed, 6 Jul 2022 20:09:49 +0200
To: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Message-ID: <YsXP7ZwHh/GvWM82@pc638.lan>
References: <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
 <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656443915.mdjoauhqe0.none@localhost> <YrtgeSmwLmpzN/zw@pc638>
 <79c6ad70-47d9-47fe-4bb4-33fcf356dd37@amd.com>
 <YsXK5A0MiVgHd8Je@pc638.lan>
 <20220706175836.GI1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706175836.GI1790663@paulmck-ThinkPad-P17-Gen-1>
X-Mailman-Approved-At: Wed, 06 Jul 2022 19:41:20 +0000
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xinhui.Pan@amd.com,
 Martijn Coenen <maco@android.com>, linux-kernel@vger.kernel.org,
 "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>, rcu@vger.kernel.org,
 Hridya Valsaraju <hridya@google.com>,
 Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
 Uladzislau Rezki <urezki@gmail.com>, Todd Kjos <tkjos@android.com>,
 amd-gfx@lists.freedesktop.org, Christian Brauner <christian@brauner.io>,
 Joel Fernandes <joel@joelfernandes.org>, alexander.deucher@amd.com,
 uladzislau.rezki@sony.com, Suren Baghdasaryan <surenb@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 wireguard@lists.zx2c4.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 06, 2022 at 10:58:36AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 06, 2022 at 07:48:20PM +0200, Uladzislau Rezki wrote:
> > Hello.
> > 
> > On Mon, Jul 04, 2022 at 01:30:50PM +0200, Christian König wrote:
> > > Hi guys,
> > > 
> > > Am 28.06.22 um 22:11 schrieb Uladzislau Rezki:
> > > > > Excerpts from Paul E. McKenney's message of June 28, 2022 2:54 pm:
> > > > > > All you need to do to get the previous behavior is to add something like
> > > > > > this to your defconfig file:
> > > > > > 
> > > > > > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000
> > > > > > 
> > > > > > Any reason why this will not work for you?
> > > 
> > > sorry for jumping in so later, I was on vacation for a week.
> > > 
> > > Well when any RCU period is longer than 20ms and amdgpu in the backtrace my
> > > educated guess is that we messed up some timeout waiting for the hw.
> > > 
> > > We usually do wait a few us, but it can be that somebody is waiting for ms
> > > instead.
> > > 
> > > So there are some todos here as far as I can see and It would be helpful to
> > > get a cleaner backtrace if possible.
> > > 
> > Actually CONFIG_ANDROID looks like is going to be removed, so the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
> > will not have any dependencies on the CONFIG_ANDROID anymore:
> > 
> > https://lkml.org/lkml/2022/6/29/756
> 
> But you can set the RCU_EXP_CPU_STALL_TIMEOUT Kconfig option, if you
> wish.  Setting this option to 20 will get you the behavior previously
> obtained by setting the now-defunct ANDROID Kconfig option.
> 
Right. Or over boot parameter. So for us it is not a big issue :)

--
Uladzislau Rezki
