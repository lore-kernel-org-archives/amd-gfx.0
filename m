From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH TRIVIAL v2] gpu: Fix Kconfig indentation
Date: Tue, 08 Oct 2019 09:05:49 +0300
Message-ID: <87v9szdb5u.fsf@intel.com>
References: <20191004144549.3567-1-krzk@kernel.org> <87sgo4hjii.fsf@intel.com> <CADnq5_MqGehpWwOAxYg0T2x3qXisqmae2uGG5dijQX+Aa4NsoQ@mail.gmail.com> <CAJKOXPeVFeSDpxPv-rDywCafWbN3mivtcM3UQX_+wZkyPcZwPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPeVFeSDpxPv-rDywCafWbN3mivtcM3UQX_+wZkyPcZwPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Alex Deucher <alexdeucher@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jiri Kosina <trivial@kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, lima@lists.freedesktop.org, nouveau <nouveau@lists.freedesktop.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 07 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, 7 Oct 2019 at 18:09, Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Mon, Oct 7, 2019 at 7:39 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> >
>> > On Fri, 04 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > >  drivers/gpu/drm/i915/Kconfig             |  12 +-
>> > >  drivers/gpu/drm/i915/Kconfig.debug       | 144 +++++++++++------------
>> >
>> > Please split these out to a separate patch. Can't speak for others, but
>> > the patch looks like it'll be conflicts galore and a problem to manage
>> > if merged in one big lump.
>>
>> Yes, it would be nice to have the amd patch separate as well.
>
> I'll split the AMD and i915 although I am not sure if it is sense to
> split such trivial patch per each driver.

Thanks.

See MAINTAINERS, many of the drivers are maintained in the same drm-misc
repo, and it makes no difference to split those.

In general it's, well, trivial to split up patches like this per driver
or repo, but not splitting it up generates extra busywork in managing
conflicts until some common merge/backmerge happens. We just want to
apply the patch and forget about it, instead of dealing with a trivial
whitespace cleanup many times over.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
