From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Date: Wed, 6 Feb 2019 19:38:34 +0100
Message-ID: <f6bdd647-722b-8145-92d4-3f6c52f8a74c@gmail.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
 <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
 <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Koenig, Christian" <christian.koenig@amd.com>
Cc: Will Deacon <will.deacon@arm.com>, Carsten Haitzler <Carsten.Haitzler@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Ellerman <mpe@ellerman.id.au>, David Airlie <airlied@linux.ie>, "Daenzer, Michel" <Michel.Daenzer@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: amd-gfx.lists.freedesktop.org

Am 06.02.19 um 18:23 schrieb Ard Biesheuvel:
> On Fri, 25 Jan 2019 at 11:35, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On Fri, 25 Jan 2019 at 12:30, Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
>>>> On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
>>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
>>>>>> <Christian.Koenig@amd.com> wrote:
>>>>>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
>>>>>>>> The DRM driver stack is designed to work with cache coherent devices
>>>>>>>> only, but permits an optimization to be enabled in some cases, where
>>>>>>>> for some buffers, both the CPU and the GPU use uncached mappings,
>>>>>>>> removing the need for DMA snooping and allocation in the CPU caches.
>>>>>>>>
>>>>>>>> The use of uncached GPU mappings relies on the correct implementation
>>>>>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
>>>>>>>> will use cached mappings nonetheless. On x86 platforms, this does not
>>>>>>>> seem to matter, as uncached CPU mappings will snoop the caches in any
>>>>>>>> case. However, on ARM and arm64, enabling this optimization on a
>>>>>>>> platform where NoSnoop is ignored results in loss of coherency, which
>>>>>>>> breaks correct operation of the device. Since we have no way of
>>>>>>>> detecting whether NoSnoop works or not, just disable this
>>>>>>>> optimization entirely for ARM and arm64.
>>>>>>>>
>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> Cc: David Zhou <David1.Zhou@amd.com>
>>>>>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>>>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
>>>>>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
>>>>>>>> Cc: David Airlie <airlied@linux.ie>
>>>>>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
>>>>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>>>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
>>>>>>>> Cc: Sean Paul <sean@poorly.run>
>>>>>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>>>> Cc: Christoph Hellwig <hch@infradead.org>
>>>>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>>>>>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
>>>>>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
>>>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>>> The subject line should probably read "disable uncached...".
>>>>>>>
>>>>>> Ugh, of course ...
>>>>>>
>>>>>>> With that fixed the patch is Reviewed-by: Christian König
>>>>>>> <christian.koenig@amd.com>.
>>>>>>>
>>>>> Same:
>>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>> Thanks all
>>>>
>>>> Should I resend the patch with the subject corrected?
>>> I will update the subject line and push it upstream through
>>> drm-misc-next if nobody objects.
>>>
>> Wonderful, thanks.
> Hi Christian,
>
> Are you still planning to merge this for v5.1?

My bad, only pushed this to our internal branch, but forgot out 
drm-misc-next.

Fixed now, thanks for the reminder.

Christian.

>
> Thanks,
> Ard.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
