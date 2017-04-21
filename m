From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Fri, 21 Apr 2017 14:02:37 +0200
Message-ID: <e6857fd8-102f-4d40-2d4d-9e26085a0efb@amd.com>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421092530.GE30290@intel.com> <1492768218.25675.33.camel@redhat.com>
 <20170421110804.GH30290@intel.com> <20170421144018.411861d6@eldfell>
 <20170421114913.GK30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170421114913.GK30290@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Pekka Paalanen <ppaalanen@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: amd-gfx.lists.freedesktop.org

Am 21.04.2017 um 13:49 schrieb Ville Syrjälä:
> On Fri, Apr 21, 2017 at 02:40:18PM +0300, Pekka Paalanen wrote:
>> On Fri, 21 Apr 2017 14:08:04 +0300
>> Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
>>
>>> On Fri, Apr 21, 2017 at 11:50:18AM +0200, Gerd Hoffmann wrote:
>>>> On Fr, 2017-04-21 at 12:25 +0300, Ville Syrjälä wrote:
>>>>> On Fri, Apr 21, 2017 at 09:58:24AM +0200, Gerd Hoffmann wrote:
>>>>>> While working on graphics support for virtual machines on ppc64 (which
>>>>>> exists in both little and big endian variants) I've figured the comments
>>>>>> for various drm fourcc formats in the header file don't match reality.
>>>>>>
>>>>>> Comments says the RGB formats are little endian, but in practice they
>>>>>> are native endian.  Look at the drm_mode_legacy_fb_format() helper.  It
>>>>>> maps -- for example -- bpp/depth 32/24 to DRM_FORMAT_XRGB8888, no matter
>>>>>> whenever the machine is little endian or big endian.  The users of this
>>>>>> function (fbdev emulation, DRM_IOCTL_MODE_ADDFB) expect the framebuffer
>>>>>> is native endian, not little endian.  Most userspace also operates on
>>>>>> native endian only.
>>>>> I'm not a fan of "native". Native to what? "CPU" or "host" is what I'd
>>>>> call it.
>>>> native == whatever the cpu is using.
>>>>
>>>> I personally find "native" more intuitive, but at the end of the day I
>>>> don't mind much.  If people prefer "host" over "native" I'll change it.
>>> "native" to me feels more like "native to the GPU" since these things
>>> really are tied to the GPU not the CPU. That's also why I went with the
>>> explicit endianness originally so that the driver could properly declare
>>> what the GPU supports.
>> Hi,
>>
>> yeah, one should really be explicit on which component's endianess does
>> "native" refer to. I just can't imagine "GPU native" to ever be an
>> option, because then userspace needs a way to discover what the
>> GPU endianess is,
> It has to know that. How else would it know how to write the bytes into
> memory in the right order for the GPU to consume, or read the stuff the
> GPU produced?
>
>> and I believe that would only deepen the swamp, not
>> drain it, because suddenly you need two enums to describe one format.
>>
>> Ville, wording aside, what do think about changing the endianess
>> definition? Is it going in the right direction?
> I don't think so, but I guess I'm in the minority.
I don't think your are in the minority. At least I would clearly say 
those formats should be in a fixed byte order and don't care about the 
CPU in the system.

What I need from the driver side is a consistent description of how the 
bytes in memory map to my hardware. What CPU is in use in the system is 
completely irrelevant for that.

Regards,
Christian.
