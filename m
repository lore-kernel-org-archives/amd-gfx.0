From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Mon, 24 Apr 2017 15:33:07 +0900
Message-ID: <bab292a6-f33a-3fe5-be7e-a9750e3ab789@daenzer.net>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <CAKb7Uvgx2_O8y+HWGv8TEv0BqpXrLL5SdAt2d3gh6g69U6F=Sw@mail.gmail.com>
 <20170421165907.GQ30290@intel.com>
 <CAKb7Uvj4stAYmZ-BOVBXugAiyfPOmEnT3i1w+Ywu2BhyBpS-1w@mail.gmail.com>
 <20170422095056.GR30290@intel.com>
 <CAKb7UviirFVnut-6k6nO2-dspyzdu0AdZQ1CV8sAKAJkqAc3oA@mail.gmail.com>
 <CAKb7Uvig0J2rg=yJT4g8OuqR9RW4x2TzK-DA_zs_Qc_up4dACQ@mail.gmail.com>
 <CAKb7UviwPFPW3sa1hfaiOg+uE4UUUkFO045CqKhiE-CdM-mB8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKb7UviwPFPW3sa1hfaiOg+uE4UUUkFO045CqKhiE-CdM-mB8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Mirkin <imirkin@alum.mit.edu>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: amd-gfx.lists.freedesktop.org

On 23/04/17 04:24 AM, Ilia Mirkin wrote:
> 
> fbdev also creates fb's that expect cpu endianness, as disabling the
> byteswap logic caused a green fbcon terminal to show up. (So at least
> something somewhere in the fbcon -> nouveau's fbdev emulation pipeline
> is expecting cpu endianness. This happens both with nouveau's fbdev
> accel logic and without.)

In theory, there's FB_FOREIGN_ENDIAN for that. But in practice it's
probably useless because little if any userspace even checks for it, let
alone handles it correctly.


> So I think the current situation, at least wrt pre-nv50 nouveau, is
> that XRGB/ARGB8888 are "special", since they are the only things
> exposed by drm_crtc_init. I believe those definitions should be
> updated to note that they're cpu-endian-specific (or another way of
> phrasing it more diplomatically is that they're array formats rather
> than packed formats).

That would be incorrect. :) The memory layout of 8-bit-per-component
array formats doesn't depend on endianness, that of packed formats does.
(DRM_FORMAT_*8 as currently defined are thus effectively array formats)


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
