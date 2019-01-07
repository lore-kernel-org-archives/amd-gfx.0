From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v5 1/2] drm/amd: validate user pitch alignment
Date: Sun, 6 Jan 2019 21:00:38 -0700
Message-ID: <20190107040038.GA180037@google.com>
References: <20181223215239.173339-2-yuzhao@google.com>
 <20181230010021.196990-1-yuzhao@google.com>
 <75d5f1d6-b259-6944-6ee0-8cc68cb1af0e@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <75d5f1d6-b259-6944-6ee0-8cc68cb1af0e@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>, Daniel Stone <daniels@collabora.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Samuel Li <Samuel.Li@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jan 03, 2019 at 05:33:19PM +0100, Michel Dänzer wrote:
> On 2018-12-30 2:00 a.m., Yu Zhao wrote:
> > Userspace may request pitch alignment that is not supported by GPU.
> > Some requests 32, but GPU ignores it and uses default 64 when cpp is
> > 4. If GEM object is allocated based on the smaller alignment, GPU
> > DMA will go out of bound.
> > 
> > Cc: stable@vger.kernel.org # v4.2+
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 15ce7e681d67..16af80ccd0a0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -527,6 +527,22 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
> >  	struct drm_gem_object *obj;
> >  	struct amdgpu_framebuffer *amdgpu_fb;
> >  	int ret;
> > +	struct amdgpu_device *adev = dev->dev_private;
> > +	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
> > +	int pitch = mode_cmd->pitches[0] / cpp;
> > +
> > +	if (pitch < mode_cmd->width) {
> > +		DRM_DEBUG_KMS("Expecting pitch(%d)/cpp(%d) >= width(%d)\n",
> > +			      mode_cmd->pitches[0], cpp, mode_cmd->width);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> 
> This should possibly be tested in drm_internal_framebuffer_create instead.

It seems to me drm_format_info_min_pitch() in framebuffer_check()
already does it. We could just remove the check here?
