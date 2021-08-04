Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AE8C432BE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0609860F14
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0609860F14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4B56EABE;
	Wed,  4 Aug 2021 15:46:54 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 909B16EAC0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 15:46:51 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id c16so2746970wrp.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Aug 2021 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=J49YuwjHy2NOI3/UOq5v3ZkPSTtuAE8eHm0+63f8mt0=;
 b=KKCQHWgX85/6DkpOCs44CvbaGognlL5uAllvJp6ktA0cfVBb2a0VLnwQKQFEPMJSGt
 IjipCXmpd3p/rMnJU3NKfgXJYiI9so2/XFXEJe0cMMXp5zNxiUTtF1sDuts9Tiehmw9Y
 QvzEEfotIqIv3605wLYfTmRJgR2g55rCpxkxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=J49YuwjHy2NOI3/UOq5v3ZkPSTtuAE8eHm0+63f8mt0=;
 b=qZGD9tYk/QHNNgFsunTeJs5jY4UJxTSC0QvdbWZei9Xn+MD16s8+ftvc9bZTrTFz4Z
 upz0wNXlos2uJ1Ls43vfAsDI5FuJ8yoL6rqSMPGUIamvRURTxvAPeZGc58Acar5JpcD9
 O7vieVN3vFSnoZOq/AYFajwxJOveDXYknjiMBPkoxOAEI/iTxU96VfwJifua6t4v/nG6
 CGApcL/M2w/eVUPE8XIl3JQWg249DuLvmVIjtdq0lpjYQcGlzWyl/rOtWGMYpdMsWJuz
 K7xHTN9CzKD53H5jO5tnnPZzdZt9FDvEmTkyGe84yYgLxph55FoWBT5f8sUfQ2hGJAts
 J9Fw==
X-Gm-Message-State: AOAM532zqbWPHAIkcxq8fwnGd0sF8bLINQrN3yf8NrTu6i0jHSCOMjYI
 +sb5CNF3OHYRgr65g1ulh8GNgQ==
X-Google-Smtp-Source: ABdhPJzFNOQREtlSZqHizztAPtbXsy+1Xtqkjpp3JnfkEup7uznIjBJWXvQVSfLGYMfdqxnxjiISOg==
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr30422wrr.238.1628092009803;
 Wed, 04 Aug 2021 08:46:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id p15sm2638112wmi.29.2021.08.04.08.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 08:46:48 -0700 (PDT)
Date: Wed, 4 Aug 2021 17:46:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Zhenneng Li <lizhenneng@kylinos.cn>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/radeon: Update pitch for page flip
Message-ID: <YQq2YAi4w79JNO4H@phenom.ffwll.local>
Mail-Followup-To: Alex Deucher <alexdeucher@gmail.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Zhenneng Li <lizhenneng@kylinos.cn>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20210802074310.1526526-1-lizhenneng@kylinos.cn>
 <e6e77cfb-4e6b-c30e-ae7c-ac84b82c9a75@amd.com>
 <YQetXMaASz/F2EyS@phenom.ffwll.local>
 <CADnq5_PDtEn1y5HJBRHXw8o11LVwSRDKNtQgZtN5u0CW5ZspnQ@mail.gmail.com>
 <6a34fcc3-0aa3-85ff-21c4-86b9b5a48fd5@daenzer.net>
 <CADnq5_MJ=m2_VvzCQ7wJaFx2=OfFfLpoJtc_Ofb+a-v3eujtXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MJ=m2_VvzCQ7wJaFx2=OfFfLpoJtc_Ofb+a-v3eujtXg@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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

On Tue, Aug 03, 2021 at 10:49:39AM -0400, Alex Deucher wrote:
> On Tue, Aug 3, 2021 at 4:34 AM Michel Dänzer <michel@daenzer.net> wrote:
> >
> > On 2021-08-02 4:51 p.m., Alex Deucher wrote:
> > > On Mon, Aug 2, 2021 at 4:31 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >>
> > >> On Mon, Aug 02, 2021 at 10:12:47AM +0200, Christian König wrote:
> > >>> Am 02.08.21 um 09:43 schrieb Zhenneng Li:
> > >>>> When primary bo is updated, crtc's pitch may
> > >>>> have not been updated, this will lead to show
> > >>>> disorder content when user changes display mode,
> > >>>> we update crtc's pitch in page flip to avoid
> > >>>> this bug.
> > >>>> This refers to amdgpu's pageflip.
> > >>>
> > >>> Alex is the expert to ask about that code, but I'm not sure if that is
> > >>> really correct for the old hardware.
> > >>>
> > >>> As far as I know the crtc's pitch should not change during a page flip, but
> > >>> only during a full mode set.
> > >>>
> > >>> So could you elaborate a bit more how you trigger this?
> > >>
> > >> legacy page_flip ioctl only verifies that the fb->format stays the same.
> > >> It doesn't check anything else (afair never has), this is all up to
> > >> drivers to verify.
> > >>
> > >> Personally I'd say add a check to reject this, since testing this and
> > >> making sure it really works everywhere is probably a bit much on this old
> > >> hw.
> > >
> > > If just the pitch changed, that probably wouldn't be much of a
> > > problem, but if the pitch is changing, that probably implies other
> > > stuff has changed as well and we'll just be chasing changes.  I agree
> > > it would be best to just reject anything other than updating the
> > > scanout address.
> >
> > FWIW, that means page flipping cannot be used in some cases which work fine by changing the pitch, which can result in tearing: https://gitlab.freedesktop.org/xorg/xserver/-/issues/839 (which says the i915 driver handles this as well).
> >
> 
> Ok.  In that case, @Zhenneng can you update all of the pitch in all of
> the page_flip functions in radeon rather than just the evergreen one?

atomic drivers handle this fairly ok-ish, since we have a proper
atomic_check there.

For legacy kms I just wouldn't bother, too many corners to validate. But
also if you're bored, just do it :-)
-Daniel

> 
> Thanks,
> 
> Alex
> 
> 
> >
> > --
> > Earthling Michel Dänzer               |               https://redhat.com
> > Libre software enthusiast             |             Mesa and X developer

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
