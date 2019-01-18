From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: csa_vaddr should not larger than
 AMDGPU_GMC_HOLE_START
Date: Fri, 18 Jan 2019 10:11:47 +0100
Message-ID: <c83cd7ec-03a5-45c0-b497-d5a5ec838880@gmail.com>
References: <1547455236-30130-1-git-send-email-Wentao.Lou@amd.com>
 <37b395b0-8503-238f-8775-66eb8795d23f@gmail.com>
 <CY4PR1201MB0245AB79C8C8319D8DFB3A3884810@CY4PR1201MB0245.namprd12.prod.outlook.com>
 <7f3f7b71-7acc-689a-e1d8-6fb184771f7b@amd.com>
 <BYAPR12MB2742181357E4D7DF7C171EE983820@BYAPR12MB2742.namprd12.prod.outlook.com>
 <574d6ca8-f1c8-8ac0-3dbe-23aed7c0125d@amd.com>
 <BYAPR12MB27427158A5684A31BF96AB4783830@BYAPR12MB2742.namprd12.prod.outlook.com>
 <361544e2-dd33-3b89-1211-4566b060b785@amd.com>
 <CY4PR1201MB0245C5E3F6810C9157C9FDCF84830@CY4PR1201MB0245.namprd12.prod.outlook.com>
 <859dcf48-f4bf-d3ec-0893-369c7fad51ed@amd.com>
 <CY4PR1201MB0245C8076917864AA97A0FFA84830@CY4PR1201MB0245.namprd12.prod.outlook.com>
 <cf3489f5-deb2-85ef-844a-b4c050f71d29@amd.com>
 <CY4PR1201MB02457ECA700E3AE8B321AC90849C0@CY4PR1201MB0245.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0591825009=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR1201MB02457ECA700E3AE8B321AC90849C0-1iTaO6aE1DBfNQakwlCMTGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Lou, Wentao" <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0591825009==
Content-Type: multipart/alternative;
 boundary="------------7FDBBE89CD50818A4EF3FE45"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7FDBBE89CD50818A4EF3FE45
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Monk,

> You see that for UMD, it can use 0 to HOLE_START
Let me say it once more: The UMD nor anybody else CAN'T use 0 to 
HOLE_START, that region is reserved for the ATC hardware!

We unfortunately didn't knew that initially and also didn't used the 
ATC, so we didn't ran into a problem.

But ROCm now uses the ATC on Raven/Picasso and I have a branch where I 
enable it on Vega as well. So when we don't fix that we will run into 
problems here.

The ATC isn't usable in combination with SRIOV and I don't think Windows 
uses it either, so they probably never ran into any issues.

> Do you mean even UMD should  not use virtual address that dropped in 
> range from 0 to HOLE_START ?
Yes, exactly! That in combination with ATC use can have quite a bunch of 
strange and hard to track down effects because two parts of the driver 
are using the same address space.

> That way where should UMD work in ?and I assume our UMD now still 
> using this range, this part make me puzzle 
At least Mesa now uses the high address space from HOLE_END..0xFFFF FFFF 
FFFF FFFF.

Regards,
Christian.

Am 18.01.19 um 02:32 schrieb Liu, Monk:
>
> Thanks Christian,
>
> Questions I have now:
>
>  1. You see that for UMD, it can use 0 to HOLE_START, so why CSA
>     cannot use that range although the range is as you said reserved
>     to ATC h/w ? Be note that for windows KMD, the CSA is allocated by
>     UMD driver so CSA shares the same aperture /space range with other
>     UMD BO, which mean CSA in windows also located in ATC range, if
>     that’s a problem why windows still works well.
>      1. Can you illustrate this limitation with more details ? we need
>         to understand why CSA couldn’t be put in ATC range.
>  2. According to your previous description :” Now on
>     Vega/Raven/Picasso etc.. (everything with a GFX9) the lower range
>     (0x0-0x8000 0000 0000) is reserved for SVA/ATC use. Since we
>     *unfortunately didn't knew that initially we exposed those to
>     older user space as usable* and also put the CSA in there.”
>      1. Do you mean even UMD should not use virtual address that
>         dropped in range from 0 to HOLE_START ?
>
> that way where should UMD work in ?and I assume our UMD now still 
> using this range, this part make me puzzle
>
> /Monk
>
> *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> *On Behalf Of 
> *Koenig, Christian
> *Sent:* Thursday, January 17, 2019 9:26 PM
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Lou, Wentao <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> *Cc:* Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
> *Subject:* Re: [PATCH] drm/amdgpu: csa_vaddr should not larger than 
> AMDGPU_GMC_HOLE_START
>
> Hi Monk,
>
>
>     Regarding with above sentence, do you mean this range
>     (0->HOLE_START) shouldn’t be exposed to user space ? I don’t get
>     your point here …
>
> Yes exactly. As I said the problem is that 0->HOLE_START is reserved 
> for the ATC hardware, we should not touch it at all.
>
>
>     Putting CSA in 0~HOLD_START is the legacy approach we selected for
>     a long time since very early stage, how comes that you think it is
>     a problem now ?
>
> That turned out to be never a good idea in the first place.
>
> What we could do is reduce the max_pfn for SRIOV because the ATC 
> doesn't work in that configuration anyway. But I would only do this as 
> last resort.
>
> Any idea why an address above the hole doesn't work with SRIOV? It 
> seems to work fine in the bare metal case.
>
> Regards,
> Christian.
>
> Am 17.01.19 um 14:19 schrieb Liu, Monk:
>
>     Hi Christian
>
>     Thanks for explaining the HOLD for us,
>
>     My understanding is we still could put CSA to 0~HOLE_START,
>     because we can report UMD the max space is HOLD_START-CSA_SIZE ,
>     thus no colliding will hit.
>
>     > Now on Vega/Raven/Picasso etc.. (everything with a GFX9) the
>     lower range (0x0-0x8000 0000 0000) is reserved for SVA/ATC use.
>     Since we unfortunately didn't knew that initially we exposed those
>     to older userspace as usable and also put the CSA in there.
>
>
>     Regarding with above sentence, do you mean this range
>     (0->HOLE_START) shouldn’t be exposed to user space ? I don’t get
>     your point here …
>
>     Putting CSA in 0~HOLD_START is the legacy approach we selected for
>     a long time since very early stage, how comes that you think it is
>     a problem now ?
>
>     /Monk
>
>     *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> *On Behalf Of
>     *Koenig, Christian
>     *Sent:* Thursday, January 17, 2019 4:30 PM
>     *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Lou,
>     Wentao <Wentao.Lou-5C7GfCeVMHo@public.gmane.org> <mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org>;
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>     <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>     *Cc:* Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org> <mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>     *Subject:* Re: [PATCH] drm/amdgpu: csa_vaddr should not larger
>     than AMDGPU_GMC_HOLE_START
>
>     Hi Monk,
>
>     ok let me explain a bit more how the hardware works.
>
>     The GMC manages a virtual 64bit address space, but only 48bit of
>     that virtual address space are handled by the page table walker.
>
>     The 48bits of address space are sign extended, so bit 47 of that
>     are extended into bits 48-63.
>
>     This gives us the following memory layout:
>     0x0
>     .... virtual address space
>     0x8000 0000 0000
>     .... hole
>     0xFFFF 8000 0000 0000
>     .... virtual address space
>     0xFFFF FFFF FFFF FFFF
>
>     Trying to access the hole results in a range fault interrupt IIRC.
>
>     When doing the VM page table walk the topmost 16bits are ignored,
>     so when programming the page table walker you cut those of and use
>     a linear address again. This is what AMDGPU_GMC_HOLE_MASK is good for.
>
>     Now on Vega/Raven/Picasso etc.. (everything with a GFX9) the lower
>     range (0x0-0x8000 0000 0000) is reserved for SVA/ATC use. Since we
>     unfortunately didn't knew that initially we exposed those to older
>     userspace as usable and also put the CSA in there.
>
>     The most likely cause of this is that we still have a bug
>     somewhere about this, e.g. not correctly using sign extended
>     addresses *OR* using sign extended addresses where we should use
>     linear instead.
>
>     Regards,
>     Christian.
>
>     Am 17.01.19 um 09:04 schrieb Liu, Monk:
>
>         Hi Christian
>
>         I believe Wentao can fix the issue we it by below step:
>
>          1. Return *Virtual_address_max* (UMD use it) to HOLE_START –
>             RESERVED_SIZE
>          2. [optional] Still Keep virtual_address_offset to
>             RESERVED_SIZE (current way, I think it’s because
>             previously we put CSA in 0 à RESERVED_SIZE space)
>          3. Put CSA in HOLE_START – RESERVED_SIZE è HOLE_START (it’s
>             current design)
>
>         I don’t get where above scheme is not correct … can you give
>         more explain for the GMC_HOLE_START ?
>
>         e.g.
>
>          1. why you set GMC_HOLE_START to 0x8’000’0000’0000 (half size
>             of MAX of 48bit address space) ? is it for HSA purpose to
>             make sure GPU address can also be used for CPU address ?
>          2. now MAX_PFN is 1’000’0000’0000, do you need to change
>             GMC_HOLE_START ?
>
>         thanks
>
>         we need some catch up
>
>         /Monk
>
>         *From:*amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> *On Behalf Of
>         *Koenig, Christian
>         *Sent:* Thursday, January 17, 2019 3:39 PM
>         *To:* Lou, Wentao <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>
>         <mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>         <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhu, Rex
>         <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>         *Cc:* Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org> <mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>         *Subject:* Re: [PATCH] drm/amdgpu: csa_vaddr should not larger
>         than AMDGPU_GMC_HOLE_START
>
>         Am 17.01.19 um 04:17 schrieb Lou, Wentao:
>
>             Hi Christian,
>
>             Your solution as:
>
>             addr = (max_pfn - (AMDGPU_VA_RESERVED_SIZE >>
>             AMDGPU_PAGE_SHIFT)) << AMDGPU_PAGE_SHIFT;
>
>             now max_pfn = 0x10 0000 0000, AMDGPU_VA_RESERVED_SIZE =
>             0x10 0000, AMDGPU_PAGE_SHIFT = 12
>
>             Still got addr = 0xFFFF FFF0 0000, which would cause ring
>             gfx timeout.
>
>
>         But 0xFFFF FFF0 0000 is the correct address, if that is
>         causing a problem then there is a bug somewhere else.
>
>         Please try to use
>         AMDGPU_GMC_HOLE_START-AMDGPU_VA_RESERVED_SIZE as well. Does
>         that work?
>
>
>
>
>             Before commit 1bf621c42137926ac249af761c0190a9258aa0db,
>             vm_size was 32GB, and csa_addr was under
>             AMDGPU_GMC_HOLE_START.
>
>
>         Wait a second why was the vm_size 32GB? This is on a Vega10
>         isn't it?
>
>
>
>
>             I didn’t understand why csa_addr need to be above
>             AMDGPU_GMC_HOLE_START now.
>
>
>         On Vega10 the lower range, e.g. everything below
>         AMDGPU_GMC_HOLE_START is reserved for SVA.
>
>         Regards,
>         Christian.
>
>
>
>
>             Thanks.
>
>             BR,
>
>             Wentao
>
>             *From:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>             *Sent:* Wednesday, January 16, 2019 5:48 PM
>             *To:* Lou, Wentao <Wentao.Lou-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhu, Rex
>             <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>             *Cc:* Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>             <mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>             *Subject:* Re: [PATCH] drm/amdgpu: csa_vaddr should not
>             larger than AMDGPU_GMC_HOLE_START
>
>             Hi Wentao,
>
>             well the problem is you don't seem to understand how the
>             hardware works.
>
>             See the engines see an MC address space with a hole in the
>             middle, similar to the how x86 64bit CPU address space
>             works. But the page tables are programmed linearly.
>
>             So the calculation in amdgpu_driver_open_kms() is correct
>             because it takes the MC address and mages a linear page
>             table index from it again.
>
>             The only thing we might need to fix here is shifting
>             max_pfn before the subtraction and I doubt that even that
>             is necessary.
>
>             Regards,
>             Christian.
>
>             Am 16.01.19 um 10:34 schrieb Lou, Wentao:
>
>                 Hi Christian,
>
>                 Now vm_size was set to 0x4 0000 GB by below commit:
>
>                 1bf621c42137926ac249af761c0190a9258aa0db drm/amdgpu:
>                 Remove unnecessary VM size calculations
>
>                 So that max_pfn would be 0x10 0000 0000.
>
>                 amdgpu_csa_vaddr would make max_pfn << 12 to get 0x1
>                 0000 0000 0000, and then minus
>                 AMDGPU_VA_RESERVED_SIZE, to get 0xFFFF FFF0 0000
>
>                 unfortunately this number was between
>                 AMDGPU_GMC_HOLE_START and AMDGPU_GMC_HOLE_END, so that
>                 amdgpu_gmc_sign_extend was called to make it 0xFFFF
>                 FFFF FFF0 0000
>
>                 in amdgpu_driver_open_kms, extended csa_addr cannot be
>                 passed into amdgpu_map_static_csa directly, it would
>                 be above the limit of max_pfn.
>
>                 So that csa_addr was restricted by
>                 AMDGPU_GMC_HOLE_MASK to make it possible for
>                 amdgpu_vm_alloc_pts.
>
>                 But this restriction by AMDGPU_GMC_HOLE_MASK would
>                 make the address fall back into AMDGPU_GMC_HOLE again,
>                  which causing GPU reset.
>
>                 We just put amdgpu_csa_vaddr back to
>                 AMDGPU_GMC_HOLE_START, to avoid the address touching
>                 AMDGPU_GMC_HOLE.
>
>                 By the way, if max_pfn was shift much to the left, it
>                 would always get zero, with or without min(*,*).
>
>                 BR,
>
>                 Wentao
>
>                 -----Original Message-----
>                 From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>                 <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>                 Sent: Tuesday, January 15, 2019 4:02 PM
>                 To: Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>                 <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Lou, Wentao
>                 <Wentao.Lou-5C7GfCeVMHo@public.gmane.org> <mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org>;
>                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhu, Rex
>                 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> <mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>                 Subject: Re: [PATCH] drm/amdgpu: csa_vaddr should not
>                 larger than AMDGPU_GMC_HOLE_START
>
>                 Am 15.01.19 um 07:19 schrieb Liu, Monk:
>
>                 > The max_pfn is now 1'0000'0000'0000'0000 (bytes)
>                 which is above 48 bit now, and it with
>                 AMDGPU_GMC_HOLE_MASK make it to zero ....
>
>                 >
>
>                 > And in code "amdgpu_driver_open_kms()" I saw @Zhu,
>                 Rex write the code as :
>
>                 >
>
>                 > "csa_addr = amdgpu_csa_vadr(adev) &
>                 AMDGPU_GMC_HOLE_MASK", I think this is wrong since you
>                 intentionally place the csa above GMC hole, right ?
>
>                 The fix is just completely incorrect since
>                 min(adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
>                 AMDGPU_GMC_HOLE_START) still gives you 0 when we shift
>                 max_pfn to much to the left.
>
>                 The correct solution is to substract the reserved size
>                 first and then shift. E.g.:
>
>                 addr = (max_pfn - (AMDGPU_VA_RESERVED_SIZE >>
>                 AMDGPU_PAGE_SHIFT)) << AMDGPU_PAGE_SHIFT;
>
>                 Regards,
>
>                 Christian.
>
>                 >
>
>                 > Looks like  we should modify this place
>
>                 >
>
>                 > /Monk
>
>                 >
>
>                 > -----Original Message-----
>
>                 > From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                 <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> On
>                 Behalf Of
>
>                 > Christian K?nig
>
>                 > Sent: Monday, January 14, 2019 9:05 PM
>
>                 > To: Lou, Wentao <Wentao.Lou-5C7GfCeVMHo@public.gmane.org
>                 <mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org>>;
>                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>                 > Subject: Re: [PATCH] drm/amdgpu: csa_vaddr should
>                 not larger than
>
>                 > AMDGPU_GMC_HOLE_START
>
>                 >
>
>                 > Am 14.01.19 um 09:40 schrieb wentalou:
>
>                 >> After removing unnecessary VM size calculations,
>                 vm_manager.max_pfn
>
>                 >> would reach 0x10,0000,0000 max_pfn <<
>                 AMDGPU_GPU_PAGE_SHIFT exceeding
>
>                 >> AMDGPU_GMC_HOLE_START would caused GPU reset.
>
>                 >>
>
>                 >> Change-Id: I47ad0be2b0bd9fb7490c4e1d7bb7bdacf71132cb
>
>                 >> Signed-off-by: wentalou <Wentao.Lou-5C7GfCeVMHo@public.gmane.org
>                 <mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org>>
>
>                 > NAK, that is incorrect. We intentionally place the
>                 csa above the GMC hole.
>
>                 >
>
>                 > Regards,
>
>                 > Christian.
>
>                 >
>
>                 >> ---
>
>                 >> drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 3 ++-
>
>                 >>    1 file changed, 2 insertions(+), 1 deletion(-)
>
>                 >>
>
>                 >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>
>                 >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>
>                 >> index 7e22be7..dd3bd01 100644
>
>                 >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>
>                 >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>
>                 >> @@ -26,7 +26,8 @@
>
>                 >>
>
>                 >>    uint64_t amdgpu_csa_vaddr(struct amdgpu_device
>                 *adev)
>
>                 >>    {
>
>                 >> -        uint64_t addr = adev->vm_manager.max_pfn
>                 << AMDGPU_GPU_PAGE_SHIFT;
>
>                 >> +       uint64_t addr =
>                 min(adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
>
>                 >> + AMDGPU_GMC_HOLE_START);
>
>                 >>
>
>                 >>          addr -= AMDGPU_VA_RESERVED_SIZE;
>
>                 >>          addr = amdgpu_gmc_sign_extend(addr);
>
>                 > _______________________________________________
>
>                 > amd-gfx mailing list
>
>                 > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>                 > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------7FDBBE89CD50818A4EF3FE45
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Monk,<br>
      <br>
      <blockquote type="cite">
        You see that for UMD, it can use 0 to HOLE_START</blockquote>
      Let me say it once more: The UMD nor anybody else CAN'T use 0 to
      HOLE_START, that region is reserved for the ATC hardware!<br>
      <br>
      We unfortunately didn't knew that initially and also didn't used
      the ATC, so we didn't ran into a problem.<br>
      <br>
      But ROCm now uses the ATC on Raven/Picasso and I have a branch
      where I enable it on Vega as well. So when we don't fix that we
      will run into problems here.<br>
      <br>
      The ATC isn't usable in combination with SRIOV and I don't think
      Windows uses it either, so they probably never ran into any
      issues.<br>
      <br>
      <blockquote type="cite"><span style="color:black">Do you mean even
          UMD should  not use virtual address that dropped in range from
          0 to HOLE_START ?</span></blockquote>
      Yes, exactly! That in combination with ATC use can have quite a
      bunch of strange and hard to track down effects because two parts
      of the driver are using the same address space.<br>
      <br>
      <blockquote type="cite">That way where should UMD work in ?and I
        assume our UMD now still using this range, this part make me
        puzzle
        <span style="color:windowtext"></span></blockquote>
      At least Mesa now uses the high address space from
      HOLE_END..0xFFFF FFFF FFFF FFFF.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 18.01.19 um 02:32 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR1201MB02457ECA700E3AE8B321AC90849C0-1iTaO6aE1DBfNQakwlCMTGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:black;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle23
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle24
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:241063413;
	mso-list-type:hybrid;
	mso-list-template-ids:-792188320 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:324823204;
	mso-list-template-ids:1149565438;}
@list l2
	{mso-list-id:405306921;
	mso-list-type:hybrid;
	mso-list-template-ids:-965868980 67698705 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3
	{mso-list-id:1023090613;
	mso-list-template-ids:279854308;}
@list l4
	{mso-list-id:1891189321;
	mso-list-type:hybrid;
	mso-list-template-ids:1902176222 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l4:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:38.5pt;
	text-indent:-.25in;}
@list l4:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:74.5pt;
	text-indent:-.25in;}
@list l4:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:110.5pt;
	text-indent:-9.0pt;}
@list l4:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:146.5pt;
	text-indent:-.25in;}
@list l4:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:182.5pt;
	text-indent:-.25in;}
@list l4:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:218.5pt;
	text-indent:-9.0pt;}
@list l4:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:254.5pt;
	text-indent:-.25in;}
@list l4:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:290.5pt;
	text-indent:-.25in;}
@list l4:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:326.5pt;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="color:windowtext">Thanks
            Christian,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">Questions I
            have now:<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <ol style="margin-top:0in" start="1" type="1">
          <li class="MsoListParagraph"
            style="color:windowtext;margin-left:0in;mso-list:l2 level1
            lfo7">
            You see that for UMD, it can use 0 to HOLE_START, so why CSA
            cannot use that range although the range is as you said
            reserved to ATC h/w ? Be note that for windows KMD, the CSA
            is allocated by UMD driver so CSA shares the same aperture
            /space range with other UMD BO, which mean CSA in windows
            also located in ATC range, if that’s a problem why windows
            still works well.<o:p></o:p>
            <ol style="margin-top:0in" start="1" type="a">
              <li class="MsoListParagraph"
                style="color:windowtext;margin-left:0in;mso-list:l2
                level2 lfo7">
                Can you illustrate this limitation with more details ?
                we need to understand why CSA couldn’t be put in ATC
                range.<o:p></o:p></li>
            </ol>
          </li>
          <li class="MsoListParagraph"
            style="color:windowtext;margin-left:0in;mso-list:l2 level1
            lfo7">
            According to your previous description :” <span
              style="color:black">Now on Vega/Raven/Picasso etc..
              (everything with a GFX9) the lower range (0x0-0x8000 0000
              0000) is reserved for SVA/ATC use. Since we
              <b>unfortunately didn't knew that initially we exposed
                those to older user space as usable</b> and also put the
              CSA in there.”</span><o:p></o:p>
            <ol style="margin-top:0in" start="1" type="a">
              <li class="MsoListParagraph"
                style="color:windowtext;margin-left:0in;mso-list:l2
                level2 lfo7">
                <span style="color:black">Do you mean even UMD should 
                  not use virtual address that dropped in range from 0
                  to HOLE_START ?</span><o:p></o:p></li>
            </ol>
          </li>
        </ol>
        <p class="MsoListParagraph" style="margin-left:1.0in">that way
          where should UMD work in ?and I assume our UMD now still using
          this range, this part make me puzzle
          <span style="color:windowtext"><o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:windowtext">/Monk<o:p></o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                style="color:windowtext"> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                <b>On Behalf Of </b>Koenig, Christian<br>
                <b>Sent:</b> Thursday, January 17, 2019 9:26 PM<br>
                <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; Lou,
                Wentao <a class="moz-txt-link-rfc2396E" href="mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org">&lt;Wentao.Lou-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Zhu, Rex
                <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Cc:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: csa_vaddr should
                not larger than AMDGPU_GMC_HOLE_START<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <p class="MsoNormal">Hi Monk,<br>
            <br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal">Regarding with above sentence, do you
              mean this range (0-&gt;HOLE_START) shouldn’t be exposed to
              user space ? I don’t get your point here …<o:p></o:p></p>
          </blockquote>
          <p class="MsoNormal">Yes exactly. As I said the problem is
            that 0-&gt;HOLE_START is reserved for the ATC hardware, we
            should not touch it at all.<br>
            <br>
            <br>
            <o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"
              style="mso-margin-top-alt:auto;mso-margin-bottom-alt:auto">Putting
              CSA in 0~HOLD_START is the legacy approach we selected for
              a long time since very early stage, how comes that you
              think it is a problem now ?<o:p></o:p></p>
          </blockquote>
          <p class="MsoNormal">That turned out to be never a good idea
            in the first place.<br>
            <br>
            What we could do is reduce the max_pfn for SRIOV because the
            ATC doesn't work in that configuration anyway. But I would
            only do this as last resort.<br>
            <br>
            Any idea why an address above the hole doesn't work with
            SRIOV? It seems to work fine in the bare metal case.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 17.01.19 um 14:19 schrieb Liu, Monk:<o:p></o:p></p>
        </div>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal"><span style="color:windowtext">Hi
              Christian </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">Thanks for
              explaining the HOLD for us,
            </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">My
              understanding is we still could put CSA to 0~HOLE_START,
              because we can report UMD the max space is
              HOLD_START-CSA_SIZE , thus no colliding will hit.</span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">&gt;</span>
            Now on Vega/Raven/Picasso etc.. (everything with a GFX9) the
            lower range (0x0-0x8000 0000 0000) is reserved for SVA/ATC
            use. Since we unfortunately didn't knew that initially we
            exposed those to older userspace as usable and also put the
            CSA in there.<br>
            <br>
            <br>
            <o:p></o:p></p>
          <p class="MsoNormal">Regarding with above sentence, do you
            mean this range (0-&gt;HOLE_START) shouldn’t be exposed to
            user space ? I don’t get your point here …<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">Putting CSA in 0~HOLD_START is the legacy
            approach we selected for a long time since very early stage,
            how comes that you think it is a problem now ?<o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
          <p class="MsoNormal"><span style="color:windowtext">/Monk</span><o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                  style="color:windowtext"> amd-gfx
                  <a href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                  <b>On Behalf Of </b>Koenig, Christian<br>
                  <b>Sent:</b> Thursday, January 17, 2019 4:30 PM<br>
                  <b>To:</b> Liu, Monk <a
                    href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Lou, Wentao
                  <a href="mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Wentao.Lou-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">
                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Zhu, Rex <a
                    href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Cc:</b> Deng, Emily <a
                    href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: csa_vaddr
                  should not larger than AMDGPU_GMC_HOLE_START</span><o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"> <o:p></o:p></p>
          <div>
            <p class="MsoNormal">Hi Monk,<br>
              <br>
              ok let me explain a bit more how the hardware works.<br>
              <br>
              The GMC manages a virtual 64bit address space, but only
              48bit of that virtual address space are handled by the
              page table walker.<br>
              <br>
              The 48bits of address space are sign extended, so bit 47
              of that are extended into bits 48-63.<br>
              <br>
              This gives us the following memory layout:<br>
              0x0<br>
              .... virtual address space<br>
              0x8000 0000 0000<br>
              .... hole<br>
              0xFFFF 8000 0000 0000<br>
              .... virtual address space<br>
              0xFFFF FFFF FFFF FFFF<br>
              <br>
              Trying to access the hole results in a range fault
              interrupt IIRC.<br>
              <br>
              When doing the VM page table walk the topmost 16bits are
              ignored, so when programming the page table walker you cut
              those of and use a linear address again. This is what
              AMDGPU_GMC_HOLE_MASK is good for.<br>
              <br>
              Now on Vega/Raven/Picasso etc.. (everything with a GFX9)
              the lower range (0x0-0x8000 0000 0000) is reserved for
              SVA/ATC use. Since we unfortunately didn't knew that
              initially we exposed those to older userspace as usable
              and also put the CSA in there.<br>
              <br>
              The most likely cause of this is that we still have a bug
              somewhere about this, e.g. not correctly using sign
              extended addresses *OR* using sign extended addresses
              where we should use linear instead.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 17.01.19 um 09:04 schrieb Liu, Monk:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span style="color:windowtext">Hi
                Christian </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">I
                believe Wentao can fix the issue we it by below step:</span><o:p></o:p></p>
            <ol style="margin-top:0in" start="1" type="1">
              <li class="MsoNormal" style="color:windowtext;mso-list:l0
                level1 lfo3">Return <b>
                  Virtual_address_max</b> (UMD use it) to HOLE_START –
                RESERVED_SIZE <o:p></o:p></li>
              <li class="MsoNormal" style="color:windowtext;mso-list:l0
                level1 lfo3">[optional] Still Keep
                virtual_address_offset to RESERVED_SIZE (current way, I
                think it’s because previously we put CSA in 0
                <span style="font-family:Wingdings">à</span>
                RESERVED_SIZE space) <o:p></o:p></li>
              <li class="MsoNormal" style="color:windowtext;mso-list:l0
                level1 lfo3">Put CSA in HOLE_START – RESERVED_SIZE 
                <span style="font-family:Wingdings">è</span> HOLE_START
                (it’s current design) <o:p>
                </o:p></li>
            </ol>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">I don’t
                get where above scheme is not correct … can you give
                more explain for the GMC_HOLE_START ?</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">e.g.</span><o:p></o:p></p>
            <ol style="margin-top:0in" start="1" type="1">
              <li class="MsoNormal"
                style="color:windowtext;margin-left:2.5pt;mso-list:l4
                level1 lfo6">
                why you set GMC_HOLE_START to 0x8’000’0000’0000 (half
                size of MAX of 48bit address space) ? is it for HSA
                purpose to make sure GPU address can also be used for
                CPU address ?
                <o:p></o:p></li>
              <li class="MsoNormal"
                style="color:windowtext;margin-left:2.5pt;mso-list:l4
                level1 lfo6">
                now MAX_PFN is 1’000’0000’0000, do you need to change
                GMC_HOLE_START ? <o:p></o:p></li>
            </ol>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">thanks </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">we need
                some catch up </span>
              <o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext">/Monk</span><o:p></o:p></p>
            <p class="MsoNormal"><span style="color:windowtext"> </span><o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="color:windowtext">From:</span></b><span
                    style="color:windowtext"> amd-gfx
                    <a
                      href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                    <b>On Behalf Of </b>Koenig, Christian<br>
                    <b>Sent:</b> Thursday, January 17, 2019 3:39 PM<br>
                    <b>To:</b> Lou, Wentao <a
                      href="mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Wentao.Lou-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    Liu, Monk
                    <a href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">
                      amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Zhu, Rex <a
                      href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    <b>Cc:</b> Deng, Emily <a
                      href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: csa_vaddr
                    should not larger than AMDGPU_GMC_HOLE_START</span><o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"> <o:p></o:p></p>
            <div>
              <p class="MsoNormal">Am 17.01.19 um 04:17 schrieb Lou,
                Wentao:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">Hi Christian,<o:p></o:p></p>
              <p class="MsoNormal"> <o:p></o:p></p>
              <p class="MsoNormal">Your solution as:<o:p></o:p></p>
              <p class="MsoNormal">addr = (max_pfn -
                (AMDGPU_VA_RESERVED_SIZE &gt;&gt; AMDGPU_PAGE_SHIFT))
                &lt;&lt; AMDGPU_PAGE_SHIFT;<o:p></o:p></p>
              <p class="MsoNormal">now max_pfn = 0x10 0000 0000,
                AMDGPU_VA_RESERVED_SIZE = 0x10 0000, AMDGPU_PAGE_SHIFT =
                12<o:p></o:p></p>
              <p class="MsoNormal">Still got addr = 0xFFFF FFF0 0000,
                which would cause ring gfx timeout.<o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal"><br>
              But 0xFFFF FFF0 0000 is the correct address, if that is
              causing a problem then there is a bug somewhere else.<br>
              <br>
              Please try to use
              AMDGPU_GMC_HOLE_START-AMDGPU_VA_RESERVED_SIZE as well.
              Does that work?<br>
              <br>
              <br>
              <br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal"> <o:p></o:p></p>
              <p class="MsoNormal">Before commit
                1bf621c42137926ac249af761c0190a9258aa0db, vm_size was
                32GB, and csa_addr was under AMDGPU_GMC_HOLE_START.<o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal"><br>
              Wait a second why was the vm_size 32GB? This is on a
              Vega10 isn't it?<br>
              <br>
              <br>
              <br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">I didn’t understand why csa_addr need
                to be above AMDGPU_GMC_HOLE_START now.<o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal"><br>
              On Vega10 the lower range, e.g. everything below
              AMDGPU_GMC_HOLE_START is reserved for SVA.<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              <br>
              <br>
              <br>
              <o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="MsoNormal">Thanks.<o:p></o:p></p>
              <p class="MsoNormal"> <o:p></o:p></p>
              <p class="MsoNormal">BR,<o:p></o:p></p>
              <p class="MsoNormal">Wentao<o:p></o:p></p>
              <p class="MsoNormal"> <o:p></o:p></p>
              <p class="MsoNormal"> <o:p></o:p></p>
              <p class="MsoNormal"> <o:p></o:p></p>
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b>From:</b> Koenig, Christian <a
                      href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">
                      &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> <br>
                    <b>Sent:</b> Wednesday, January 16, 2019 5:48 PM<br>
                    <b>To:</b> Lou, Wentao <a
                      href="mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Wentao.Lou-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    Liu, Monk
                    <a href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">
                      amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Zhu, Rex <a
                      href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    <b>Cc:</b> Deng, Emily <a
                      href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdgpu: csa_vaddr
                    should not larger than AMDGPU_GMC_HOLE_START<o:p></o:p></p>
                </div>
              </div>
              <p class="MsoNormal"> <o:p></o:p></p>
              <div>
                <p class="MsoNormal">Hi Wentao,<br>
                  <br>
                  well the problem is you don't seem to understand how
                  the hardware works.<br>
                  <br>
                  See the engines see an MC address space with a hole in
                  the middle, similar to the how x86 64bit CPU address
                  space works. But the page tables are programmed
                  linearly.<br>
                  <br>
                  So the calculation in amdgpu_driver_open_kms() is
                  correct because it takes the MC address and mages a
                  linear page table index from it again.<br>
                  <br>
                  The only thing we might need to fix here is shifting
                  max_pfn before the subtraction and I doubt that even
                  that is necessary.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  Am 16.01.19 um 10:34 schrieb Lou, Wentao:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="MsoPlainText">Hi Christian,<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">Now vm_size was set to <span
                    style="background:yellow;mso-highlight:yellow">
                    0x4 0000</span> GB by below commit:<o:p></o:p></p>
                <p class="MsoPlainText">1bf621c42137926ac249af761c0190a9258aa0db
                  drm/amdgpu: Remove unnecessary VM size calculations<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">So that max_pfn would be <span
                    style="background:yellow;mso-highlight:yellow">
                    0x10 0000 0000.</span><o:p></o:p></p>
                <p class="MsoPlainText">amdgpu_csa_vaddr would make
                  max_pfn &lt;&lt; 12 to get 0x1 0000 0000 0000, and
                  then minus AMDGPU_VA_RESERVED_SIZE, to get
                  <span style="background:yellow;mso-highlight:yellow">0xFFFF
                    FFF0 0000</span><o:p></o:p></p>
                <p class="MsoPlainText">unfortunately this number was
                  between AMDGPU_GMC_HOLE_START and AMDGPU_GMC_HOLE_END,
                  so that amdgpu_gmc_sign_extend was called to make it
                  <span style="background:yellow;mso-highlight:yellow">0xFFFF
                    FFFF FFF0 0000</span><o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">in amdgpu_driver_open_kms,
                  extended csa_addr cannot be passed into
                  amdgpu_map_static_csa directly, it would be above the
                  limit of max_pfn.<o:p></o:p></p>
                <p class="MsoPlainText">So that csa_addr was restricted
                  by AMDGPU_GMC_HOLE_MASK to make it possible for
                  amdgpu_vm_alloc_pts.<o:p></o:p></p>
                <p class="MsoPlainText">But this restriction by
                  AMDGPU_GMC_HOLE_MASK would make the address fall back
                  into AMDGPU_GMC_HOLE again,  which causing GPU reset.<o:p></o:p></p>
                <p class="MsoPlainText">We just put amdgpu_csa_vaddr
                  back to AMDGPU_GMC_HOLE_START, to avoid the address
                  touching AMDGPU_GMC_HOLE.<o:p></o:p></p>
                <p class="MsoPlainText">By the way, if max_pfn was shift
                  much to the left, it would always get zero, with or
                  without min(*,*).<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">BR,<o:p></o:p></p>
                <p class="MsoPlainText">Wentao<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">-----Original Message-----<br>
                  From: Koenig, Christian <a
                    href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
                  <br>
                  Sent: Tuesday, January 15, 2019 4:02 PM<br>
                  To: Liu, Monk <a href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Lou, Wentao
                  <a href="mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">&lt;Wentao.Lou-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">
                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Zhu, Rex <a
                    href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  Subject: Re: [PATCH] drm/amdgpu: csa_vaddr should not
                  larger than AMDGPU_GMC_HOLE_START<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">Am 15.01.19 um 07:19 schrieb
                  Liu, Monk:<o:p></o:p></p>
                <p class="MsoPlainText">&gt; The max_pfn is now
                  1'0000'0000'0000'0000 (bytes) which is above 48 bit
                  now, and it with AMDGPU_GMC_HOLE_MASK make it to zero
                  ....<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt; And in code
                  "amdgpu_driver_open_kms()" I saw @Zhu, Rex write the
                  code as :<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt; "csa_addr =
                  amdgpu_csa_vadr(adev) &amp; AMDGPU_GMC_HOLE_MASK", I
                  think this is wrong since you intentionally place the
                  csa above GMC hole, right ?<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">The fix is just completely
                  incorrect since min(adev-&gt;vm_manager.max_pfn
                  &lt;&lt; AMDGPU_GPU_PAGE_SHIFT, AMDGPU_GMC_HOLE_START)
                  still gives you 0 when we shift max_pfn to much to the
                  left.<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">The correct solution is to
                  substract the reserved size first and then shift.
                  E.g.:<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">addr = (max_pfn -
                  (AMDGPU_VA_RESERVED_SIZE &gt;&gt; AMDGPU_PAGE_SHIFT))
                  &lt;&lt; AMDGPU_PAGE_SHIFT;<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">Regards,<o:p></o:p></p>
                <p class="MsoPlainText">Christian.<o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt; Looks like  we should
                  modify this place<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt; /Monk<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt; -----Original Message-----<o:p></o:p></p>
                <p class="MsoPlainText">&gt; From: amd-gfx &lt;<a
                    href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true"><span
                      style="text-decoration:none">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</span></a>&gt;
                  On Behalf Of
                  <o:p></o:p></p>
                <p class="MsoPlainText">&gt; Christian K?nig<o:p></o:p></p>
                <p class="MsoPlainText">&gt; Sent: Monday, January 14,
                  2019 9:05 PM<o:p></o:p></p>
                <p class="MsoPlainText">&gt; To: Lou, Wentao &lt;<a
                    href="mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true"><span
                      style="text-decoration:none">Wentao.Lou-5C7GfCeVMHo@public.gmane.org</span></a>&gt;;
                  <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true"><span
                      style="text-decoration:none">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</span></a><o:p></o:p></p>
                <p class="MsoPlainText">&gt; Subject: Re: [PATCH]
                  drm/amdgpu: csa_vaddr should not larger than
                  <o:p></o:p></p>
                <p class="MsoPlainText">&gt; AMDGPU_GMC_HOLE_START<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt; Am 14.01.19 um 09:40
                  schrieb wentalou:<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; After removing
                  unnecessary VM size calculations, vm_manager.max_pfn
                  <o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; would reach
                  0x10,0000,0000 max_pfn &lt;&lt; AMDGPU_GPU_PAGE_SHIFT
                  exceeding
                  <o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; AMDGPU_GMC_HOLE_START
                  would caused GPU reset.<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; Change-Id:
                  I47ad0be2b0bd9fb7490c4e1d7bb7bdacf71132cb<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; Signed-off-by: wentalou
                  &lt;<a href="mailto:Wentao.Lou-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true"><span
                      style="text-decoration:none">Wentao.Lou-5C7GfCeVMHo@public.gmane.org</span></a>&gt;<o:p></o:p></p>
                <p class="MsoPlainText">&gt; NAK, that is incorrect. We
                  intentionally place the csa above the GMC hole.<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt; Regards,<o:p></o:p></p>
                <p class="MsoPlainText">&gt; Christian.<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; ---<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;   
                  drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 3 ++-<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;    1 file changed, 2
                  insertions(+), 1 deletion(-)<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; <o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; index 7e22be7..dd3bd01
                  100644<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; ---
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; +++
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; @@ -26,7 +26,8 @@<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;    <o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;    uint64_t
                  amdgpu_csa_vaddr(struct amdgpu_device *adev)<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;    {<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; -        uint64_t addr
                  = adev-&gt;vm_manager.max_pfn &lt;&lt;
                  AMDGPU_GPU_PAGE_SHIFT;<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt; +       uint64_t addr =
                  min(adev-&gt;vm_manager.max_pfn &lt;&lt;
                  AMDGPU_GPU_PAGE_SHIFT,<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;
                  +                                                   
                  AMDGPU_GMC_HOLE_START);<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;    <o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;          addr -=
                  AMDGPU_VA_RESERVED_SIZE;<o:p></o:p></p>
                <p class="MsoPlainText">&gt;&gt;          addr =
                  amdgpu_gmc_sign_extend(addr);<o:p></o:p></p>
                <p class="MsoPlainText">&gt;
                  _______________________________________________<o:p></o:p></p>
                <p class="MsoPlainText">&gt; amd-gfx mailing list<o:p></o:p></p>
                <p class="MsoPlainText">&gt; <a
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true"><span
                      style="text-decoration:none">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</span></a><o:p></o:p></p>
                <p class="MsoPlainText">&gt; <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    moz-do-not-send="true">
                    <span style="text-decoration:none">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</span></a><o:p></o:p></p>
                <p class="MsoPlainText"> <o:p></o:p></p>
              </blockquote>
              <p class="MsoNormal"> <o:p></o:p></p>
            </blockquote>
            <p class="MsoNormal"> <o:p></o:p></p>
          </blockquote>
          <p class="MsoNormal"> <o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------7FDBBE89CD50818A4EF3FE45--

--===============0591825009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0591825009==--
