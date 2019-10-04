From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 03/11] drm/amdgpu: convert amdgpu_vm_it to half closed
 intervals
Date: Fri, 4 Oct 2019 14:39:40 +0200
Message-ID: <232710bd-dc54-9d77-6f0f-24a91a28cbf6@gmail.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-4-dave@stgolabs.net>
 <dc9cc8c4-7275-43be-5bed-91384e3246ae@amd.com>
 <20191004113628.GA260828@google.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004113628.GA260828@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michel Lespinasse <walken@google.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jerome Glisse <jglisse@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hi Michel,

Am 04.10.19 um 13:36 schrieb Michel Lespinasse:
> On Fri, Oct 04, 2019 at 06:54:54AM +0000, Koenig, Christian wrote:
>> Am 03.10.19 um 22:18 schrieb Davidlohr Bueso:
>>> The amdgpu_vm interval tree really wants [a, b) intervals,
>> NAK, we explicitly do need an [a, b[ interval here.
> Hi Christian,
>
> Just wanted to confirm where you stand on this patch, since I think
> you reconsidered your initial position after first looking at 9/11
> from this series.
>
> I do not know the amdgpu code well, but I think the changes should be
> fine - in struct amdgpu_bo_va_mapping, the "end" field will hold what
> was previously stored in the "last" field, plus one. The expectation
> is that overflows should not be an issue there, as "end" is explicitly
> declared as an uint64, and as the code was previously computing
> "last + 1" in many places.
>
> Does that seem workable to you ?

No, we computed last + 1 in a couple of debug places were it doesn't 
hurt us and IIRC we currently cheat a bit because we use pfn instead of 
addresses on some other places.

But that is only a leftover from radeon and we need to fix that sooner 
or later, cause essentially the physical address space of the device is 
really full 64bits, e.g. 0x0-0xffffffffffffffff.

So that only fits into a 64bit int when we use half open/closed 
intervals, but would wrap around to zero if we use a closed interval.

I initially thought that the set was changing the interval tree into 
always using a closed interval, but that seems to have been a 
misunderstanding.

Regards,
Christian.

>
> Thanks,
>
