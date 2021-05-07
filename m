Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C03C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 08:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE316144A
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 08:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE316144A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C1A6EDF0;
	Fri,  7 May 2021 08:59:43 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6844D6EDF4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 08:59:42 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 l24-20020a7bc4580000b029014ac3b80020so6724565wmi.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 May 2021 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/nh1bbQT5CiK8IqERbTeRh4gKwm6+O6Vg+VARq82rio=;
 b=ddP9vw2/xz6l5rgNknMnioGUpBwslhkhK/Vqn+Kl45rxtCUI1B37VPu4ncHEAzfh5G
 lraIDVUeYC1DCwyViD6+lq/nLpHJ7NVA4UnG4dIh03OPLcXFQHOCKIsy6MTCyG7IvMTN
 ggSkExoADblSOWRHwZ8hPSr4yuGq19xGJhDe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/nh1bbQT5CiK8IqERbTeRh4gKwm6+O6Vg+VARq82rio=;
 b=szInRctCGdNkiuhcryNFm8bKHcJbW1QOaQFpkQY/sUIlWxgWXvxNB/8KoUa4QxKLBe
 Fl9AOkBWDq4tA0ixVpefFr8zk9o6x4d7FPsLCKtQDsZkf0oUf0SdKyuTK4g7mhBEkSCO
 HVOjqAAXCezBZvsBI3aYgUZbMO0tKQZ6Mbn5PAzVktqAo35CW3ege4ulxpYBS5AOd5IK
 HGusdscQc0HEoaBqAifzRXWKoIwhh1Xo/a2U7lySJxLG2bAtnbEFUjjK15mrtGIY/OyK
 hpa4OZtSnQB3XR+1yzEnF38Reh5NoHzOI67CbVwtqJF1iDFcVBWnaqo+/uWNt0xHhXMU
 OjGg==
X-Gm-Message-State: AOAM5329jPJYPFuZj7sFCt6G4yvzS0JW9+gi7NkrPURgbWnVLbCcEmoO
 wawSZEuEheBak5qs+jHpAOgcPw==
X-Google-Smtp-Source: ABdhPJzduMczy9ysbmAMuqtbBG09rD7O4KiM9HF0LInaj4JHW6d0b9TrE4pquQXjf9xl813S56OsKA==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr19619041wmc.91.1620377980995; 
 Fri, 07 May 2021 01:59:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id q10sm7138710wre.92.2021.05.07.01.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 May 2021 01:59:40 -0700 (PDT)
Date: Fri, 7 May 2021 10:59:38 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Kenny Ho <y2kenny@gmail.com>
Subject: Re: [RFC] Add BPF_PROG_TYPE_CGROUP_IOCTL
Message-ID: <YJUBer3wWKSAeXe7@phenom.ffwll.local>
References: <CAOWid-czZphRz6Y-H3OcObKCH=bLLC3=bOZaSB-6YBE56+Qzrg@mail.gmail.com>
 <20201103210418.q7hddyl7rvdplike@ast-mbp.dhcp.thefacebook.com>
 <CAOWid-djQ_NRfCbOTnZQ-A8Pr7jMP7KuZEJDSsvzWkdw7qc=yA@mail.gmail.com>
 <20201103232805.6uq4zg3gdvw2iiki@ast-mbp.dhcp.thefacebook.com>
 <YBgU9Vu0BGV8kCxD@phenom.ffwll.local>
 <CAOWid-eXMqcNpjFxbcuUDU7Y-CCYJRNT_9mzqFYm1jeCPdADGQ@mail.gmail.com>
 <YBqEbHyIjUjgk+es@phenom.ffwll.local>
 <CAOWid-c4Nk717xUah19B=z=2DtztbtU=_4=fQdfhqpfNJYN2gw@mail.gmail.com>
 <CAKMK7uFEhyJChERFQ_DYFU4UCA2Ox4wTkds3+GeyURH5xNMTCA@mail.gmail.com>
 <CAOWid-fL0=OM2XiOH+NFgn_e2L4Yx8sXA-+HicUb9bzhP0t8Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOWid-fL0=OM2XiOH+NFgn_e2L4Yx8sXA-+HicUb9bzhP0t8Bw@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
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
Cc: Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kenny Ho <Kenny.Ho@amd.com>,
 "open list:CONTROL GROUP \(CGROUP\)" <cgroups@vger.kernel.org>,
 Brian Welty <brian.welty@intel.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Martin KaFai Lau <kafai@fb.com>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Daniel Vetter <daniel@ffwll.ch>,
 Network Development <netdev@vger.kernel.org>, KP Singh <kpsingh@chromium.org>,
 Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
 Dave Airlie <airlied@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 06, 2021 at 10:06:32PM -0400, Kenny Ho wrote:
> Sorry for the late reply (I have been working on other stuff.)
> 
> On Fri, Feb 5, 2021 at 8:49 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > So I agree that on one side CU mask can be used for low-level quality
> > of service guarantees (like the CLOS cache stuff on intel cpus as an
> > example), and that's going to be rather hw specific no matter what.
> >
> > But my understanding of AMD's plans here is that CU mask is the only
> > thing you'll have to partition gpu usage in a multi-tenant environment
> > - whether that's cloud or also whether that's containing apps to make
> > sure the compositor can still draw the desktop (except for fullscreen
> > ofc) doesn't really matter I think.
> This is not correct.  Even in the original cgroup proposal, it
> supports both mask and count as a way to define unit(s) of sub-device.
> For AMD, we already have SRIOV that supports GPU partitioning in a
> time-sliced-of-a-whole-GPU fashion.

Hm I missed that. I feel like time-sliced-of-a-whole gpu is the easier gpu
cgroups controler to get started, since it's much closer to other cgroups
that control bandwidth of some kind. Whether it's i/o bandwidth or compute
bandwidht is kinda a wash.

CU mask feels a lot more like an isolation/guaranteed forward progress
kind of thing, and I suspect that's always going to be a lot more gpu hw
specific than anything we can reasonably put into a general cgroups
controller.

Also for the time slice cgroups thing, can you pls give me pointers to
these old patches that had it, and how it's done? I very obviously missed
that part.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
