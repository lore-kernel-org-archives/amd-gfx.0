From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/3] drm: fourcc byteorder: drop DRM_FORMAT_BIG_ENDIAN
Date: Wed, 03 May 2017 11:24:41 +0200
Message-ID: <1493803481.8581.163.camel@redhat.com>
References: <20170502133404.15354-1-kraxel@redhat.com>
         <20170502133404.15354-2-kraxel@redhat.com>
         <CACvgo52FeXVixjmRpv3xO=kRFTbmBu5vmyzAs=VF_v+nLAO=ag@mail.gmail.com>
         <20170502172724.31188e2d@eldfell> <1493737591.8581.126.camel@redhat.com>
         <28424bad-95c8-7394-4742-cd258fd71032@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <28424bad-95c8-7394-4742-cd258fd71032@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Pekka Paalanen <ppaalanen@gmail.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Emil Velikov <emil.l.velikov@gmail.com>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

  Hi,

> > R600+ supports bigendian framebuffer formats, so no byteswapping on
> > access is needed.  Not sure whenever that includes 16bpp formats or
> > whenever this is limited to the 8 bit-per-color formats [...]
> 
> It includes 16bpp. Looking at
> drivers/gpu/drm/radeon/atombios_crtc.c:dce4_crtc_do_set_base(), it sets
> up byte-swapping for all multi-byte formats, so it effectively treats
> all those formats as if they had DRM_FORMAT_BIG_ENDIAN set.

> If the radeon (and amdgpu) driver were to be changed to use
> drm_mode_legacy_fb_format_he for >= R600, that must also handle 16 bpp,
> which requires DRM_FORMAT_BIG_ENDIAN. So I still don't see how that can
> be removed or even deprecated.

Ok.

Dropped patch #1.

Updated patch #2 to include all formats returned by
drm_mode_legacy_fb_format, and also renamed them to DRM_FORMAT_HOST_*.

Question is how to go forward with patch #3.  I'd prefer to not add
drm_mode_legacy_fb_format_he if possible.  Is there a chance to adapt
the radeon and nvidia drivers to a fixed drm_mode_legacy_fb_format
function (returning be formats on be) without invasive changes?  Given
they both treat formats as if they had DRM_FORMAT_BIG_ENDIAN set this
could (with the help of the extended patch #2) be a simple
s/DRM_FORMAT_/DRM_FORMAT_HOST/ at the right places ...

Michael?  Ilia?

cheers,
  Gerd
