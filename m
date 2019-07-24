From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v19 00/15] arm64: untag user pointers passed to the kernel
Date: Wed, 24 Jul 2019 18:12:20 +0100
Message-ID: <f27f4e55-fcd6-9ae7-d9ca-cac2aea5fe70@arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <CAAeHK+yc0D_nd7nTRsY4=qcSx+eQR0VLut3uXMf4NEiE-VpeCw@mail.gmail.com>
 <20190724140212.qzvbcx5j2gi5lcoj@willie-the-truck>
 <CAAeHK+xXzdQHpVXL7f1T2Ef2P7GwFmDMSaBH4VG8fT3=c_OnjQ@mail.gmail.com>
 <20190724142059.GC21234@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724142059.GC21234@fuggles.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, dri-devel@lists.freedesktop.org, Kostya Serebryany <kcc@google.com>, Khalid Aziz <khalid.aziz@oracle.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@g>
List-Id: amd-gfx.lists.freedesktop.org

Hi Will and Andrey,

On 24/07/2019 15:20, Will Deacon wrote:
> On Wed, Jul 24, 2019 at 04:16:49PM +0200, Andrey Konovalov wrote:
>> On Wed, Jul 24, 2019 at 4:02 PM Will Deacon <will@kernel.org> wrote:
>>> On Tue, Jul 23, 2019 at 08:03:29PM +0200, Andrey Konovalov wrote:
>>>> On Tue, Jul 23, 2019 at 7:59 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>>>>>
>>>>> === Overview
>>>>>
>>>>> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
>>>>> tags into the top byte of each pointer. Userspace programs (such as
>>>>> HWASan, a memory debugging tool [1]) might use this feature and pass
>>>>> tagged user pointers to the kernel through syscalls or other interfaces.
>>>>>
>>>>> Right now the kernel is already able to handle user faults with tagged
>>>>> pointers, due to these patches:
>>>>>
>>>>> 1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
>>>>>              tagged pointer")
>>>>> 2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
>>>>>               pointers")
>>>>> 3. 276e9327 ("arm64: entry: improve data abort handling of tagged
>>>>>               pointers")
>>>>>
>>>>> This patchset extends tagged pointer support to syscall arguments.
>>>
>>> [...]
>>>
>>>> Do you think this is ready to be merged?
>>>>
>>>> Should this go through the mm or the arm tree?
>>>
>>> I would certainly prefer to take at least the arm64 bits via the arm64 tree
>>> (i.e. patches 1, 2 and 15). We also need a Documentation patch describing
>>> the new ABI.
>>
>> Sounds good! Should I post those patches together with the
>> Documentation patches from Vincenzo as a separate patchset?
> 
> Yes, please (although as you say below, we need a new version of those
> patches from Vincenzo to address the feedback on v5). The other thing I
> should say is that I'd be happy to queue the other patches in the series
> too, but some of them are missing acks from the relevant maintainers (e.g.
> the mm/ and fs/ changes).
> 

I am actively working on the document and will share v6 with the requested
changes in the next few days.

> Will
> 

-- 
Regards,
Vincenzo
