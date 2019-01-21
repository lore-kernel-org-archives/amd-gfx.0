From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 19:04:22 +0100
Message-ID: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
> On Mon, 21 Jan 2019 at 18:55, Michel Dänzer <michel@daenzer.net> wrote:
>>
>> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
>>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>>> Until that happens we should just change the driver ifdefs to default
>>>> the hacks to off and only enable them on setups where we 100%
>>>> positively know that they actually work.  And document that fact
>>>> in big fat comments.
>>>
>>> Well, as I mentioned in my commit log as well, if we default to off
>>> unless CONFIG_X86, we may break working setups on MIPS and Power where
>>> the device is in fact non-cache coherent, and relies on this
>>> 'optimization' to get things working.
>>
>> FWIW, the amdgpu driver doesn't rely on non-snooped transfers for
>> correct basic operation (the scenario Christian brought up is a very
>> specialized use-case), so that shouldn't be an issue.
>>
> 
> The point is that this is only true for x86.
> 
> On other architectures, the use of non-cached mappings on the CPU side
> means that you /do/ rely on non-snooped transfers, since if those
> transfers turn out not to snoop inadvertently, the accesses are
> incoherent with the CPU's view of memory.

The driver generally only uses non-cached mappings if
drm_arch/device_can_wc_memory returns true.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
