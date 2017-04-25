From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Tue, 25 Apr 2017 12:52:59 +0300
Message-ID: <20170425095259.GK30290@intel.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, amd-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Apr 25, 2017 at 12:18:52PM +0900, Michel Dänzer wrote:
> On 24/04/17 03:25 PM, Gerd Hoffmann wrote:
> > Return correct fourcc codes on bigendian.  Drivers must be adapted to
> > this change.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Just to reiterate, this won't work for the radeon driver, which programs
> the GPU to use (effectively, per the current definition that these are
> little endian GPU formats) DRM_FORMAT_XRGB8888 with pre-R600 and
> DRM_FORMAT_BGRX8888 with >= R600.
> 
> 
> > +#ifdef __BIG_ENDIAN
> > +	switch (bpp) {
> > +	case 8:
> > +		fmt = DRM_FORMAT_C8;
> > +		break;
> > +	case 24:
> > +		fmt = DRM_FORMAT_BGR888;
> > +		break;
> 
> BTW, endianness as a concept cannot apply to 8 or 24 bpp formats.

To 8bpp no, but it can easily apply to 24bpp. Same was as it applies to
16bpp. Neither matches the word size of the CPU or anything like that
but still the bytes have to stored in memory in some order.

-- 
Ville Syrjälä
Intel OTC
