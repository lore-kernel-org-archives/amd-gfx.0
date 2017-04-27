From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Thu, 27 Apr 2017 16:02:58 +0900
Message-ID: <668bc373-1614-a095-6085-15c040f322b8@daenzer.net>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <1493185990.23739.7.camel@redhat.com>
 <8f91cc58-16dc-5899-66b6-06d430a18801@daenzer.net>
 <1493208671.23739.19.camel@redhat.com>
 <6bd62182-0de5-a8a7-78c3-029fc73ecc91@daenzer.net>
 <1493275550.31995.31.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493275550.31995.31.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, amd-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On 27/04/17 03:45 PM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> That is done using the RADEON_TILING_SWAP_{16,32}BIT flag mentioned in
>>> another thread?
>>
>> Right.
>>
>>
>>> What about dumb bos?  You've mentioned the swap flag isn't used for
>>> those.  Which implies they are in little endian byte order (both gpu and
>>> cpu view).
>>
>> Right, AFAICT from looking at the code.
> 
> Ok.
> 
> And I also don't see an easy way to make them big endian (cpu view)
> using swapping with the existing drm interfaces, given we apply a format
> when we put the bo into use as framebuffer, not when creating it.  So
> userspace can: (1) create dumb bo, (2) map bo, (3) write something bo,
> (4) create fb + attach to crtc.  And at (3) we don't know the format
> yet, so we can't configure swapping accordingly.
> 
> So just not using the swapping indeed looks like the only sensible
> option.  Which in turn implies there is no BGRA8888 support for dumb
> bos.  Hmm, I can see the problem.  Userspace expectation appears to be
> that ADDFB configures a native endian framebuffer, which the driver
> simply can't do on bigendian.

... with pre-R600 GPUs.


> So, what can/should the driver do here?  Throw errors for ADDFB and
> force userspace to use ADDFB2?  From a design point of view the best
> option, but in the other hand I suspect that could break the xorg radeon
> driver ...

Yes, it would.

One thing we could do is provide a way for userspace to query the
effective format(s) as seen by the GPU and/or CPU.

It might also make sense for the radeon driver to set the
RADEON_TILING_SWAP_{16,32}BIT flags for dumb BOs. I wonder about the
status of apps using dumb BOs directly wrt this discussion.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
