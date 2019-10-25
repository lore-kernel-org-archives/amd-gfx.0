From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
Date: Fri, 25 Oct 2019 17:18:05 +0100
Message-ID: <20191025161804.GA12335@willie-the-truck>
References: <20191025110450.10474-1-will@kernel.org>
 <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Nicolas Waisman <nico@semmle.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Oct 25, 2019 at 06:06:26PM +0200, Michel Dänzer wrote:
> On 2019-10-25 1:04 p.m., Will Deacon wrote:
> > In the highly unlikely event that we fail to allocate the "radeon-crtc"
> > workqueue, we should bail cleanly rather than blindly march on with a
> > NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
> > structure.
> > 
> > This was reported previously by Nicolas, but I don't think his fix was
> > correct:
> 
> Neither is this one I'm afraid. See my feedback on
> https://patchwork.freedesktop.org/patch/331534/ .

Thanks. Although I agree with you wrt the original patch, I don't think
the workqueue allocation failure is distinguishable from the CRTC allocation
failure with my patch. Are you saying that the error path there is broken
too?

Will
