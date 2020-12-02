Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9088CC64E7C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 17:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0D0221FA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 17:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0D0221FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C8C6EA5E;
	Wed,  2 Dec 2020 17:59:25 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12426EA8C;
 Wed,  2 Dec 2020 17:33:49 +0000 (UTC)
Date: Wed, 2 Dec 2020 18:34:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606930429;
 bh=0L0lBWTpNJYKmS/y536wXr7++nDF5nyAFlhvD7IUwB0=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=GIuZR+OysBpQBUoHS8njNEjN5f4Aq17WkzN1qycTdBFh6K3oymBTI8BbSBQUbXTC2
 FZ9N3kFlsysHMtOBJ340qLEuq3PDSSuOiNpVTzX3TI0s0uOWdp9+IYj+j4StYIUqw+
 2ofnL/0jzgDeEk3J/BgkCTu0T3ViKdDUoiFpYVXU=
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH v2 5/8] drm/amdgpu: Refactor sysfs removal
Message-ID: <X8fQQpYDqsgGJUPt@kroah.com>
References: <20200622164551.GA112181@kroah.com>
 <4787b2a9-e7bf-ea3c-02e9-484a4fcb4742@amd.com>
 <20200623060532.GB3818201@kroah.com>
 <090c5a35-3088-d6d0-dcaf-5ce5542a4298@amd.com>
 <20200624061153.GA933050@kroah.com>
 <c864c559-71f4-08a5-f692-3f067a9a32f8@amd.com>
 <X6rU6lKDCyl6RN+V@kroah.com>
 <9db66134-0690-0972-2312-9d9155a0c5d8@amd.com>
 <X6wEbtSDm69gzFbR@kroah.com>
 <bc6cc476-4f09-1c0f-37b9-522723ecdc85@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc6cc476-4f09-1c0f-37b9-522723ecdc85@amd.com>
X-Mailman-Approved-At: Wed, 02 Dec 2020 17:59:24 +0000
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
Cc: daniel.vetter@ffwll.ch, michel@daenzer.net, dri-devel@lists.freedesktop.org,
 ppaalanen@gmail.com, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, ckoenig.leichtzumerken@gmail.com,
 alexdeucher@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 02, 2020 at 10:48:01AM -0500, Andrey Grodzovsky wrote:
> =

> On 11/11/20 10:34 AM, Greg KH wrote:
> > On Wed, Nov 11, 2020 at 10:13:13AM -0500, Andrey Grodzovsky wrote:
> > > On 11/10/20 12:59 PM, Greg KH wrote:
> > > > On Tue, Nov 10, 2020 at 12:54:21PM -0500, Andrey Grodzovsky wrote:
> > > > > Hi, back to this after a long context switch for some higher prio=
rity stuff.
> > > > > =

> > > > > So here I was able eventually to drop all this code and this chan=
ge here https://nam11.safelinks.protection.outlook.com/?url=3Dhttps:%2F%2Fc=
git.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Damd-staging-drm-n=
ext-device-unplug%26id%3D61852c8a59b4dd89d637693552c73175b9f2ccd6&amp;data=
=3D04%7C01%7CAndrey.Grodzovsky%40amd.com%7C9fbfecac94a340dfb68408d886571609=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637407055896651058%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;sdata=3DYe8HJR1vidppcOBnlOgVu5GwKD2%2Bb5ztHbiI%2BubKKT0%3D=
&amp;reserved=3D0
> > > > > was enough for me. Seems like while device_remove_file can handle=
 the use
> > > > > case where the file and the parent directory already gone,
> > > > > sysfs_remove_group goes down in flames in that case
> > > > > due to kobj->sd being unset on device removal.
> > > > A driver shouldn't ever have to remove individual sysfs groups, the
> > > > driver core/bus logic should do it for them automatically.
> > > > =

> > > > And whenever a driver calls a sysfs_* call, that's a hint that some=
thing
> > > > is not working properly.
> > > =

> > > =

> > > Do you mean that while the driver creates the groups and files explic=
itly
> > > from it's different subsystems it should not explicitly remove each
> > > one of them because all of them should be removed at once (and
> > > recursively) when the device is being removed ?
> > Individual drivers should never add groups/files in sysfs, the driver
> > core should do it properly for you if you have everything set up
> > properly.  And yes, the driver core will automatically remove them as
> > well.
> > =

> > Please use the default groups attribute for your bus/subsystem and this
> > will happen automagically.
> =

> =

> Hi Greg, I tried your suggestion to hang amdgpu's sysfs
> attributes on default attributes in struct device.groups but turns out it=
's
> not usable since by the
> time i have access to struct device from amdgpu code it has already been
> initialized by pci core
> (i.e.=A0 past the point where device_add->device_add_attrs->device_add_gr=
oups
> with dev->groups is called)
> and so i can't really use it.

That's odd, why can't you just set the groups pointer in your pci_driver
structure?  That's what it is there for, right?

> What I can only think of using is creating my own struct attribute_group =
**
> array in amdgpu where I aggregate all
> amdgpu sysfs attributes, call device_add_groups in the end of amgpu pci
> probe with that array and on device remove call
> device_remove_groups with the same array.

Horrid, no, see above :)

thanks,

greg k-h
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
