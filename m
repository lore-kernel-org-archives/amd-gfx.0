From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Fri, 21 Apr 2017 13:42:23 +0200
Message-ID: <f1b0ae60-b20e-ad52-7fbf-32f2c045f5fc@amd.com>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421092530.GE30290@intel.com> <1492768218.25675.33.camel@redhat.com>
 <20170421110804.GH30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170421110804.GH30290@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, amd-gfx@lists.freedesktop.org, Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: amd-gfx.lists.freedesktop.org

Am 21.04.2017 um 13:08 schrieb Ville Syrjälä:
> On Fri, Apr 21, 2017 at 11:50:18AM +0200, Gerd Hoffmann wrote:
>> On Fr, 2017-04-21 at 12:25 +0300, Ville Syrjälä wrote:
>>> On Fri, Apr 21, 2017 at 09:58:24AM +0200, Gerd Hoffmann wrote:
>>>> While working on graphics support for virtual machines on ppc64 (which
>>>> exists in both little and big endian variants) I've figured the comments
>>>> for various drm fourcc formats in the header file don't match reality.
>>>>
>>>> Comments says the RGB formats are little endian, but in practice they
>>>> are native endian.  Look at the drm_mode_legacy_fb_format() helper.  It
>>>> maps -- for example -- bpp/depth 32/24 to DRM_FORMAT_XRGB8888, no matter
>>>> whenever the machine is little endian or big endian.  The users of this
>>>> function (fbdev emulation, DRM_IOCTL_MODE_ADDFB) expect the framebuffer
>>>> is native endian, not little endian.  Most userspace also operates on
>>>> native endian only.
>>> I'm not a fan of "native". Native to what? "CPU" or "host" is what I'd
>>> call it.
>> native == whatever the cpu is using.
>>
>> I personally find "native" more intuitive, but at the end of the day I
>> don't mind much.  If people prefer "host" over "native" I'll change it.
> "native" to me feels more like "native to the GPU" since these things
> really are tied to the GPU not the CPU. That's also why I went with the
> explicit endianness originally so that the driver could properly declare
> what the GPU supports.
And to be honest I would really prefer to stick with that approach for 
exactly that reason.

The proposed change would require that drivers have different code path 
for different CPU byte order. Those code path tend to be not tested very 
well and are additional complexity we probably don't want inside the driver.

My personal opinion is that formats in drm_fourcc.h should be 
independent of the CPU byte order and the function 
drm_mode_legacy_fb_format() and drivers depending on that incorrect 
assumption be fixed instead.

Regards,
Christian.
