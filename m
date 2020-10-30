Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A181BC56201
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 09:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23175206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 09:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PI2jc1on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23175206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D766A6E99A;
	Fri, 30 Oct 2020 09:15:26 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A5D6E99A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 09:15:25 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id d3so2238372wma.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=ajiZKDquHTFSl0096pkCVJGMC7tGtJTQuVLJuoBU2x4=;
 b=PI2jc1onHCGHTFVrOglMW6SqUxii06UoetHncrrfRN7UKVNuoUUMafkCmOCrbDnzS7
 jd4EeQYASCzCZt0DNZ3dlCHo1pb4Mb1DvEHQNrrI6M9J4m95H/fuuYPptNcbR1pHAbFj
 sPRW9/fLFAdAe5xhF5kXN0H02zqfTXGuOmrao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=ajiZKDquHTFSl0096pkCVJGMC7tGtJTQuVLJuoBU2x4=;
 b=Z4WZOG9sNQnbKhI3sX+hNnn8oTiCFk7J93+B+GWKDRElOq8ioVVeVBOkcsbVNUOjUH
 kQMgHI5a2lmEr3QKnsGQFq11i1VtB9egEdReVreJlQBedk6ybsNUYJkf+KBV2suA4Wau
 Ltgt9X14OO3r8+SyUyKtZMXrE2TYKIpXVXKYQIkv/b32fnIiasXv7ns79mdGTwjS+5oi
 MHrwXLB2iH18MhaLNiRzPX0v8Pg2BTHCElfoO8ddadvi0/41ZbkG1SIVjKp8rN11p8M6
 bdSOq2t2OZ5eAEXiNpm50aqxnb5psAQJoSLMda/GAZxaKb9nHpidyjx/c0JkwymuDERu
 5hYQ==
X-Gm-Message-State: AOAM5327Gda2PIe1yd6ZeLM/1GnJhYeaeoohVGxkQKYqpyRI+OfkfTxf
 oA2bVpIbuMESpYp2xc/QmcFh3Q==
X-Google-Smtp-Source: ABdhPJz1w5owVaYO5YAhR8bSJx5mzCGURblvQtjgVDkUzIP6+/UvUQcNl1nNuFPePlumK451ec2/Tg==
X-Received: by 2002:a1c:7dc5:: with SMTP id y188mr1425897wmc.37.1604049324133; 
 Fri, 30 Oct 2020 02:15:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v14sm10240364wrq.46.2020.10.30.02.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 02:15:23 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:15:21 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
Message-ID: <20201030091521.GH401619@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Deepak R Varma <mh12gx2825@gmail.com>,
 outreachy-kernel@googlegroups.com,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 melissa.srw@gmail.com
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com>
 <20201030075716.GA6976@my--box>
 <5a7d8e8d-8db5-ff56-6448-3f1cefc11ef8@amd.com>
 <20201030082518.GB1619669@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030082518.GB1619669@kroah.com>
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
Cc: Deepak R Varma <mh12gx2825@gmail.com>, David Airlie <airlied@linux.ie>,
 daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, melissa.srw@gmail.com,
 outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 30, 2020 at 09:25:18AM +0100, Greg KH wrote:
> On Fri, Oct 30, 2020 at 09:00:04AM +0100, Christian K=F6nig wrote:
> > Am 30.10.20 um 08:57 schrieb Deepak R Varma:
> > > On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
> > > > On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
> > > > > Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_uns=
afe()
> > > > > function in place of the debugfs_create_file() function will make=
 the
> > > > > file operation struct "reset" aware of the file's lifetime. Addit=
ional
> > > > > details here: https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.archive.carbon60.com%2Flinux%2Fkernel%2F2369498&amp;=
data=3D04%7C01%7Cchristian.koenig%40amd.com%7Cddd7a6ac8164415a639708d87ca97=
004%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637396414464384011%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C1000&amp;sdata=3Do6GOHvMxNMuOPlC4nhDyURCHBLqfQZhYQq%2BiIMt3D3s%3=
D&amp;reserved=3D0
> > > > > =

> > > > > Issue reported by Coccinelle script:
> > > > > scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
> > > > > =

> > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > ---
> > > > > Please Note: This is a Outreachy project task patch.
> > > > > =

> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----=
------
> > > > >   1 file changed, 10 insertions(+), 10 deletions(-)
> > > > > =

> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > index 2d125b8b15ee..f076b1ba7319 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *=
data, u64 val)
> > > > >   	return 0;
> > > > >   }
> > > > > -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > -			amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> > > > > +			 amdgpu_debugfs_ib_preempt, "%llu\n");
> > > > Are you sure this is ok?  Do these devices need this additional
> > > > "protection"?  Do they have the problem that these macros were writ=
ten
> > > > for?
> > > > =

> > > > Same for the other patches you just submitted here, I think you nee=
d to
> > > > somehow "prove" that these changes are necessary, checkpatch isn't =
able
> > > > to determine this all the time.
> > > Hi Greg,
> > > Based on my understanding, the current function debugfs_create_file()
> > > adds an overhead of lifetime managing proxy for such fop structs. This
> > > should be applicable to these set of drivers as well. Hence I think t=
his
> > > change will be useful.
> > =

> > Well since this is only created once per device instance I don't really=
 care
> > about this little overhead.
> > =

> > But what exactly is debugfs doing or not doing here?
> =

> It is trying to save drivers from having debugfs files open that point
> to memory that can go away at any time.  For graphics devices, I doubt
> that is the case.

So for anything we add/remove we have two-stage cleanup

1. drm_dev_unregister (or drm_connector_unregisters, those are the only
two hotunpluggable things we have) unregister all the uapi interfaces.
This deletes all the sysfs and debugfs files.

2. Once all the references to the underlying object disappear from the
kernel, we free up the data structure.

Now for chardev and similar uapi, we hold full references for open files.
But for sysfs and debugfs we assume that those uapi layers will make sure
that after we deleted the files in step 1 all access through these
functions are guaranteed to have finished. If that's not the case, then we
need to rework our refcounting and also refcount the underlying drm
structure (drm_device or drm_connector) from sysfs/debugfs files.

Now I tried to look at the patch Deepak references, and I'm not really
clear what changes. Or whether we made a wrong assumption previously about
what debugfs/sysfs guarantee when we delete the files.
-Daniel

> =

> thanks,
> =

> greg k-h

-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
