Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F05CE7A89
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 18:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A0D10E931;
	Thu,  5 Sep 2024 18:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqR2QsG/";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC3210E816
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 17:23:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6E422A440FE;
 Wed,  4 Sep 2024 17:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C0DC4CEC2;
 Wed,  4 Sep 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1725470587;
 bh=MKVWiXAJ+7Pq+eolEHDrok3t8EEZ6mlOOGqnV70ub0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fqR2QsG/5A2d7tJRY3kzsPBXJIdIWhE8IMlbxaF6CK0DGsTCsuVHVVX9FM/jtWTEZ
 iIJvDdnnKhemLvI0O0a824vfqnrJUvg6LzfvODA2LMx2nKa4IG90XKTXPe4ymppHvX
 GOAyL73b/IdXjPzRqZgCcb7FODGsKwmHTIzV2Mpw=
Date: Wed, 4 Sep 2024 19:23:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: AMD drm patch workflow is broken for stable trees
Message-ID: <2024090447-boozy-judiciary-849b@gregkh>
References: <2024081247-until-audacious-6383@gregkh>
 <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh>
 <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh>
 <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
X-Mailman-Approved-At: Thu, 05 Sep 2024 18:49:02 +0000
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

On Tue, Aug 27, 2024 at 10:18:27AM -0400, Alex Deucher wrote:
> On Sat, Aug 24, 2024 at 1:23 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 23, 2024 at 05:23:46PM -0400, Alex Deucher wrote:
> > > On Thu, Aug 15, 2024 at 1:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > > > > On Wed, Aug 14, 2024 at 4:55 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> > > > > >
> > > > > > On 2024-08-12 11:00, Greg KH wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > As some of you have noticed, there's a TON of failure messages being
> > > > > > > sent out for AMD gpu driver commits that are tagged for stable
> > > > > > > backports.  In short, you all are doing something really wrong with how
> > > > > > > you are tagging these.
> > > > > > Hi Greg,
> > > > > >
> > > > > > I got notifications about one KFD patch failing to apply on six branches
> > > > > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you
> > > > > > already applied this patch on two branches back in May. The emails had a
> > > > > > suspicious looking date in the header (Sep 17, 2001). I wonder if there
> > > > > > was some date glitch that caused a whole bunch of patches to be re-sent
> > > > > > to stable somehow:
> > > > >
> > > > > I think the crux of the problem is that sometimes patches go into
> > > > > -next with stable tags and they end getting taken into -fixes as well
> > > > > so after the merge window they end up getting picked up for stable
> > > > > again.  Going forward, if they land in -next, I'll cherry-pick -x the
> > > > > changes into -fixes so there is better traceability.
> > > >
> > > > Please do so, and also work to not have duplicate commits like this in
> > > > different branches.  Git can handle merges quite well, please use it.
> > > >
> > > > If this shows up again in the next -rc1 merge window without any
> > > > changes, I'll have to just blackhole all amd drm patches going forward
> > > > until you all tell me you have fixed your development process.
> > >
> > > Just a heads up, you will see some of these when the 6.12 merge window
> > > due to what is currently in -next and the fixes that went into 6.11,
> > > but going forward we have updated our process and it should be better.
> >
> > Can you give me a list of the git ids that I should be ignoring for
> > 6.12-rc1?  Otherwise again, it's a huge waste of time on my side trying
> > to sift through them and figure out if the rejection is real or not...
> 
> 8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on Link
> fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
> ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
> 332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
> math_ceil2
> 295d91cbc700 drm/amd/display: Check for NULL pointer
> 6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
> 93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
> 7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_common_modes

Please resend this after -rc1 is out, so we don't have to hunt for it
again.

thanks,

greg k-h
