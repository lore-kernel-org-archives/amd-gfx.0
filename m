From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: Resizable PCI BAR support V9
Date: Wed, 25 Oct 2017 13:27:48 +0200
Message-ID: <6cea55fd-1454-60ef-e3d0-f394b7a1c61f@gmail.com>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
 <20171024194438.GB21840@bhelgaas-glaptop.roam.corp.google.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171024194438.GB21840@bhelgaas-glaptop.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Am 24.10.2017 um 21:44 schrieb Bjorn Helgaas:
> On Wed, Oct 18, 2017 at 03:58:16PM +0200, Christian König wrote:
>> Hi everyone,
>>
>> This is the ninth and hopefully last incarnation of this set of patches. It
>> enables device drivers to resize and most likely also relocate the PCI BAR of
>> devices they manage to allow the CPU to access all of the device local memory
>> at once.
>>
>> This is very useful for GFX device drivers where the default PCI BAR is only
>> about 256MB in size for compatibility reasons, but the device easily have
>> multiple gigabyte of local memory.
>>
>> Some changes since the last version:
>> 1. Rebased on drm-next, so should be ready to be merged for 4.15.
>> 2. The fixup of the 64bit root window on AMD Family 15h CPUs/APUs is only
>>     enabled when we compile a kernel supporting that hw.
>> 3. Some minor error handling improvements for the amdgpu side. We now
>>     gracefully abort driver loading in case of a critical error instead of
>>     calling BUG().
>>
>> Bjorn any more comments or can we finally get this into 4.15? I will remove the
>> version tags from the patches when I send you a pull request if you want this.
>>
>> I only work on this as a background task, so sorry for the ~3 month delay
>> between each version of the patchset.
> I put these (except for the last) on pci/resource for v4.15.  I'd be
> happy to merge the last as well if you like.  My tree does not include
> drm-next, so there would be a minor conflict when merging upstream.

Thanks Bjorn, that is great to hear.

I will sync up with Alex and Dave how to merge the last patch.

Christian.

>
> Bjorn
