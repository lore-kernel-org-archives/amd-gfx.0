Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B20DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B319622D2A
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B319622D2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB386E17E;
	Tue, 12 Jan 2021 09:16:06 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1696E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:16:05 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id y17so1629964wrr.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=cvReRwy9emQXXnNKJ1WV85zP9TH2TW7Rwxm8NFJ4R1o=;
 b=RaR+/wkU4qcISp0cCGr/mb5nv0cFZE+Fgo9Z7NPkfZIzyihDBBzysQTaEh1dajesCN
 nIewTC3wPuZuI1X/MdST7nRqsJCfYftnR8hpr4i9SjbsoANFDYUWGLPUhgJjl5JoPCwo
 e2T47RafY6tAEpOkx4LNz6WYh83RU+uaT00Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cvReRwy9emQXXnNKJ1WV85zP9TH2TW7Rwxm8NFJ4R1o=;
 b=jdQeAM/uu7/kRQLMlp1bplneG2840spUuhJ9+HTnQ1pf+49FFpGa1qfl4mEONNKF84
 Cx6tJP/L/h2As004poD9QnfoCY48damI8UNwt3VXgYoFZey8d6UPavNPVML6Cq/WHHMJ
 3+kWPjccO+o+Rki7p7CJwpMWlFhC2BnwOVWGUxLvMF9OwQFi5iL99wKWDxRsnpSgtGHt
 GQuHcXDPgJVeFK/ANYWIfRnhxfR6fCsrlRisbRDSlqIoFjcl77V40p1IHNUEntScqXVU
 lleVLLUy/PlvkTz/mFqLrSWECBBOX6R2sHIpHSzyfwXKhFlRl+TEv8SzH05U+cktpvCt
 E8QA==
X-Gm-Message-State: AOAM530VX5UtwT8kR4lsNWxim3gPpC8u+UOvylyMQnsoEkJb8z0eBxN/
 pCDR4A+aN58aeGH0W1B/VieyTA==
X-Google-Smtp-Source: ABdhPJzXaM6utKjCus690qaEmvs0MavRCx3bgdQHxU7t0bIWU1r9Li7FHYU3GYXhrcARhrKXAwOtHQ==
X-Received: by 2002:a5d:67c1:: with SMTP id n1mr3179328wrw.205.1610442964117; 
 Tue, 12 Jan 2021 01:16:04 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id e15sm3229876wrg.72.2021.01.12.01.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 01:16:03 -0800 (PST)
Date: Tue, 12 Jan 2021 10:16:01 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/radeon: stop re-init the TTM page pool
Message-ID: <X/1o0STyJjU+wDC7@phenom.ffwll.local>
References: <20210105182309.1362-1-christian.koenig@amd.com>
 <X/dN/YFtnVAIllds@phenom.ffwll.local>
 <ffa9d7f2-fe68-fb6a-8422-82b8949dbe1e@gmail.com>
 <X/hs1Rvm57zGPU8y@phenom.ffwll.local>
 <d066b08c-756c-bbef-0f30-d8c68ef92dbf@amd.com>
 <CAKMK7uGcRM8E0hYZeJCUuON7+uZnyEVtwU0HrNwhoWcw9V2uNA@mail.gmail.com>
 <42d82248-0bec-ea1c-8d6e-d032a2e53c43@gmail.com>
 <X/x6EP1HE/sjQla0@phenom.ffwll.local>
 <0da70aa5-d943-687c-6d54-c825f229bf40@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0da70aa5-d943-687c-6d54-c825f229bf40@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Borislav Petkov <bp@alien8.de>, dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 12, 2021 at 08:53:03AM +0100, Christian K=F6nig wrote:
> Am 11.01.21 um 17:17 schrieb Daniel Vetter:
> > On Mon, Jan 11, 2021 at 11:16:13AM +0100, Christian K=F6nig wrote:
> > > Am 08.01.21 um 16:53 schrieb Daniel Vetter:
> > > > On Fri, Jan 8, 2021 at 3:36 PM Christian K=F6nig <christian.koenig@=
amd.com> wrote:
> > > > > Am 08.01.21 um 15:31 schrieb Daniel Vetter:
> > > > > > On Thu, Jan 07, 2021 at 09:08:29PM +0100, Christian K=F6nig wro=
te:
> > > > > > > Am 07.01.21 um 19:07 schrieb Daniel Vetter:
> > > > > > > > On Tue, Jan 05, 2021 at 07:23:08PM +0100, Christian K=F6nig=
 wrote:
> > > > > > > > > Drivers are not supposed to init the page pool directly a=
ny more.
> > > > > > > > > =

> > > > > > > > > Signed-off-by: Christian K=F6nig <christian.koenig@amd.co=
m>
> > > > > > > > Please include reported-by credits and link to the bug repo=
rts on
> > > > > > > > lore.kernel.org when merging this. Also I guess this should=
 have a Fixes:
> > > > > > > > line?
> > > > > > > I'm not aware of a bug report, but the reported-by/Fixes line=
s are indeed
> > > > > > > missing.
> > > > > > This one here:
> > > > > > =

> > > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flore.kernel.org%2Fdri-devel%2F20201231104020.GA4504%40zn.tnic%2F&amp;d=
ata=3D04%7C01%7Cchristian.koenig%40amd.com%7Cff77249040634cf2750308d8b64c61=
6d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637459786459556204%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;sdata=3Dm8tjDXFtsEwtcv9byq5r1sbUuqb8q%2BAn63r4aKMpcaM%3D=
&amp;reserved=3D0
> > > > > > =

> > > > > > Or did I get confused, and the above is yet another bug?
> > > > > Yeah, but that was just reported by mail. The bug tracker I've sa=
w was
> > > > > opened after the patch was already pushed.
> > > > Still good to give reported-by credits for mailing list reports and
> > > > link to lore.kernel.org for the report, that's not just useful for
> > > > bugzilla reports.
> > > That's indeed true, but I was distracted by the fact that drm-misc-fi=
xes
> > > wasn't up to date :)
> > > =

> > > Going to add that earlier next time.
> > > =

> > > > > > > BTW: Any idea why dim add-link doesn't work?
> > > > > > Hm we occasionally have fun with email parsing (it's hard) and =
especially
> > > > > > python changes in how encodings are handled differently between=
 python2
> > > > > > and python3. If you have a specific example I can try and take =
a look why
> > > > > > it doesn't work.
> > > > > It just looks up and doesn't seem to do anything. I'm not familia=
r with
> > > > > python so I can just describe the symptoms.
> > > > I meant tell me which mail (patchwork or lore) and I'll try to
> > > > reproduce and see what's maybe up.
> > > It doesn't seem to work in general. E.g. any patch I try I just don't=
 get
> > > any progress in over 10 Minutes.
> > > =

> > > Maybe some server is not responding?
> > Uh dim add-link pretty similar to dim apply-patch, it takes the mbox on
> > stdin and does only local git stuff with it.
> =

> AH! Since it was getting a branch parameter I was assuming that it looks =
at
> patches on that branch!

Yeah the branch parameter is just so it knows where it should add the
Link: Since the link is presumably not there yet we can't fish out the
original mbox from archives anyway.
-Daniel

> =

> Thanks for the explanation,
> Christian.
> =

> > -Daniel
> > =

> > > Christian.
> > > =

> > > > -Daniel
> > > > =

> > > > > Christian.
> > > > > =

> > > > > > -Daniel
> > > > > > =

> > > > > > > > And maybe some words on how/why stuff blows up.
> > > > > > > Just a typo. I've forgot to remove two lines in radeon while =
rebasing and
> > > > > > > still had the symbols exported so never noticed this.
> > > > > > > =

> > > > > > > Christian.
> > > > > > > =

> > > > > > > > -Daniel
> > > > > > > > =

> > > > > > > > > ---
> > > > > > > > >      drivers/gpu/drm/radeon/radeon_ttm.c | 3 ---
> > > > > > > > >      1 file changed, 3 deletions(-)
> > > > > > > > > =

> > > > > > > > > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/driver=
s/gpu/drm/radeon/radeon_ttm.c
> > > > > > > > > index d4328ff57757..35b715f82ed8 100644
> > > > > > > > > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > > > > > > > > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > > > > > > > > @@ -729,9 +729,6 @@ int radeon_ttm_init(struct radeon_dev=
ice *rdev)
> > > > > > > > >              }
> > > > > > > > >              rdev->mman.initialized =3D true;
> > > > > > > > > -  ttm_pool_init(&rdev->mman.bdev.pool, rdev->dev, rdev->=
need_swiotlb,
> > > > > > > > > -                dma_addressing_limited(&rdev->pdev->dev)=
);
> > > > > > > > > -
> > > > > > > > >              r =3D radeon_ttm_init_vram(rdev);
> > > > > > > > >              if (r) {
> > > > > > > > >                      DRM_ERROR("Failed initializing VRAM =
heap.\n");
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > > > =

> > > > > > > > > _______________________________________________
> > > > > > > > > dri-devel mailing list
> > > > > > > > > dri-devel@lists.freedesktop.org
> > > > > > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhtt=
ps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=
=3D04%7C01%7Cchristian.koenig%40amd.com%7Cff77249040634cf2750308d8b64c616d%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637459786459556204%7CUnknown%7=
CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn=
0%3D%7C1000&amp;sdata=3DnBl4CRoSoA3t%2Bd4sZ4My4L27GiCiJwRenoILGU9LbO4%3D&am=
p;reserved=3D0
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
