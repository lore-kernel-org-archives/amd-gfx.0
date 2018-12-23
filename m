From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH 2/3] drm/amd: validate user pitch alignment
Date: Sun, 23 Dec 2018 14:44:39 -0700
Message-ID: <20181223214439.GA157289@google.com>
References: <20181221031053.240161-1-yuzhao@google.com>
 <20181221031053.240161-2-yuzhao@google.com>
 <90677da7-d74d-c725-f669-88fe18789d5b@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <90677da7-d74d-c725-f669-88fe18789d5b@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>, Daniel Stone <daniels@collabora.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Samuel Li <Samuel.Li@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Harry Wentland <harry.wentland@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Dec 21, 2018 at 10:07:26AM +0100, Michel Dänzer wrote:
> On 2018-12-21 4:10 a.m., Yu Zhao wrote:
> > Userspace may request pitch alignment that is not supported by GPU.
> > Some requests 32, but GPU ignores it and uses default 64 when cpp is
> > 4. If GEM object is allocated based on the smaller alignment, GPU
> > DMA will go out of bound.
> > 
> > For GPU that does frame buffer compression, DMA writing out of bound
> > memory will cause memory corruption.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index e309d26170db..755daa332f8a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -527,6 +527,15 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
> >  	struct drm_gem_object *obj;
> >  	struct amdgpu_framebuffer *amdgpu_fb;
> >  	int ret;
> > +	struct amdgpu_device *adev = dev->dev_private;
> > +	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
> > +	int pitch = amdgpu_align_pitch(adev, mode_cmd->width, cpp, false);
> 
> Also, this needs to use mode_cmd->pitches[0] instead of mode_cmd->width,
> otherwise it'll spuriously fail for larger but well-aligned pitches.

Actually mode_cmd->pitches[0] is aligned mode_cmd->width multiplied
by cpp. So we can't just use mode_cmd->pitches[0]. And I'm not sure
if the hardware works with larger alignment (it certainly ignores
smaller alignment).
