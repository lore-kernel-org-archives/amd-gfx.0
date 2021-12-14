Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 08:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 527A710EA19;
	Tue, 14 Dec 2021 08:27:01 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651DA10EB6C;
 Tue, 14 Dec 2021 03:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1639453050; x=1670989050;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=zvW0rVDOsw3A1J3iTHRC/yuQ7RJV1sqF+QY7pKkw/jo=;
 b=VriauR9RvAUm9SZk2GOKuw3ruTP0DF9y8jbPEya5OZVbO42OC5Timc5P
 Dau0cb+pNrqExNhDZbJiSnzp+PvFhIJeYGjWyBxYW/klT5Py66hVn4+eI
 G+izEZntxkfK/ztffYa/dgMgv6xdrQn4KBZ+qsYqOePo+th4YDNGkBy+g
 /EHleGmMhJ269KCvyJ4sLX2M7zC++jC9mCtstEofvIrRRhlBNLpgXwpfF
 qY+Cue8/1xa4G9aoppMVxZTNJl7abxJxMJzjLnXQ7/CoOFkjYie6vW7f9
 aSTRFJGNmbJP+EGDiq/wu+L6Bu0v/gor32f0h61bZWF2GHO0yzW9a7wuu g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236419770"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; d="scan'208";a="236419770"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 19:37:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; d="scan'208";a="505190229"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2021 19:37:26 -0800
Date: Mon, 13 Dec 2021 19:37:25 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 6/7] drm/amdgpu: Ensure kunmap is called on error
Message-ID: <20211214033725.GR3538886@iweiny-DESK2.sc.intel.com>
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20211210232404.4098157-7-ira.weiny@intel.com>
 <5bbd3c48-1388-9469-8b6f-deed64406d7d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bbd3c48-1388-9469-8b6f-deed64406d7d@amd.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Mailman-Approved-At: Tue, 14 Dec 2021 08:27:00 +0000
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
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 13, 2021 at 09:37:32PM +0100, Christian König wrote:
> Am 11.12.21 um 00:24 schrieb ira.weiny@intel.com:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The default case leaves the buffer object mapped in error.
> > 
> > Add amdgpu_bo_kunmap() to that case to ensure the mapping is cleaned up.
> 
> Mhm, good catch. But why do you want to do this in the first place?

I'm not sure I understand the question.

Any mapping of memory should be paired with an unmapping when no longer needed.
And this is supported by the call to amdgpu_bo_kunmap() in the other
non-default cases.

Do you believe the mapping is not needed?

Ira

> 
> Christian.
> 
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > NOTE: It seems like this function could use a fair bit of refactoring
> > but this is the easiest way to fix the actual bug.
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
> >   1 file changed, 1 insertion(+)
> > nice
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > index 6f8de11a17f1..b3ffd0f6b35f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > @@ -889,6 +889,7 @@ static int amdgpu_uvd_cs_msg(struct amdgpu_uvd_cs_ctx *ctx,
> >   		return 0;
> >   	default:
> > +		amdgpu_bo_kunmap(bo);
> >   		DRM_ERROR("Illegal UVD message type (%d)!\n", msg_type);
> >   	}
> 
