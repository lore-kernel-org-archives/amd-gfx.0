From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: deprecated register issues
Date: Fri, 9 Mar 2018 08:43:39 +0100
Message-ID: <cddf2c25-0ea6-5a0f-f642-14a17a81c7b4@amd.com>
References: <BLUPR12MB04496DB9A508E4AEE114AF2484D80@BLUPR12MB0449.namprd12.prod.outlook.com>
 <58B0701E-D93F-417B-816C-0616F364789A@amd.com>
 <8ccdd2af-4520-866b-9b55-fa41b05c1fa1@amd.com>
 <DM5PR12MB1660D5E735D17FEEC2E5E51CF7D80@DM5PR12MB1660.namprd12.prod.outlook.com>
 <BLUPR12MB04499E74336A32888737C2B584DF0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BN6PR12MB165241AC2937FA73FE9E95C6F7DF0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BLUPR12MB044941CA8B586506C47EF57184DF0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <7e01679a-81fe-3e1d-9eb1-c7668145a87a@gmail.com>
 <BLUPR12MB0449B325C1C6FA562915C4EA84DF0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BLUPR12MB044982457323EEB3BFC1E39E84DF0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <3cebe4c6-3230-855d-abf2-df7c7bc2f861@amd.com>
 <BLUPR12MB04496FDB34DF802EE66BF08684DE0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BN6PR12MB16521216A47BC1FFC0414658F7DE0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0654271808=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16521216A47BC1FFC0414658F7DE0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Cc: "Jin, Jian-Rong" <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0654271808==
Content-Type: multipart/alternative;
 boundary="------------EEA43B6149A3AB3923D2E9DF"
Content-Language: en-US

--------------EEA43B6149A3AB3923D2E9DF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

That would be a possibility, but I don't think reading the register once 
during driver startup is a real issue.

See you need to hammer on the problematic registers to trigger the 
misbehavior, e.g. not read it once or twice but thousands of times.

Additional to that as I said before, VM flushes are not really the 
problem. While investigating this I've worked around the VM flush issue 
by just writing the register value multiple times.

That works around the problem pretty reliable as well and would be 
trivial to implement, but it just doesn't fix the real issue that the 
hardware is dropping register writes.

And dropping register writes can have all kind of problematic effects, 
from performance problems because of not acknowledged interrupts, over 
incorrect calculation results to complete hangs.

Regards,
Christian.

Am 09.03.2018 um 04:29 schrieb Deucher, Alexander:
>
> Can GIM read the value and pass it to the VF's via the vbios or the 
> shared area?
>
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Liu, Monk
> *Sent:* Thursday, March 8, 2018 9:59:34 PM
> *To:* Koenig, Christian; Deucher, Alexander; Mao, David
> *Cc:* Jin, Jian-Rong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* RE: deprecated register issues
>
> >Although KMD now use a cache way to give libdrm the 
> CC_RB_BACKEND_DISABLE value, but KMD still need to read it at least 
> one shot during loading driver right ?
>
> Correct, but we do this while having exclusive access.
>
> The problem is although for VF0 it is reading this register in 
> exclusive mode, but meanwhile another VF may doing the VM flush, thus
>
> The issue is still there as long as any VF is allowed to read this 
> register,
>
> It’s not related if in exclusive or not
>
> /Monk
>
> *From:*Koenig, Christian
> *Sent:* 2018年3月8日18:51
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander 
> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Mao, David <David.Mao-5C7GfCeVMHo@public.gmane.org>
> *Cc:* Jin, Jian-Rong <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>; 
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: deprecated register issues
>
>     Although KMD now use a cache way to give libdrm the
>     CC_RB_BACKEND_DISABLE value, but KMD still need to read it at
>     least one shot during loading driver right ?
>
> Correct, but we do this while having exclusive access.
>
>
>     Not only tlb flush, other ring’s vm flush of VF2 can all be ruined
>     by this register’s reading from VF1, right ?
>
> Not sure about that. But as I said that problem is not limited to VM 
> flushes, e.g. when you access this register any other register write 
> or read can be affected.
>
> May theory is that accessing those registers sometimes times out when 
> the MC is to busy or something like this and this timeout in turn 
> results in a register bus reset which affects all other ongoing 
> operations as well.
>
>
>     How you solve that ?
>
> Stop accessing the affected registers as much as possible, there is no 
> really any other known workaround.
>
> The risk by accessing it when the driver loads is minimal, we just 
> need to make sure that we don't touch them during world switch.
>
> Regards,
> Christian.
>
> Am 08.03.2018 um 11:11 schrieb Liu, Monk:
>
>     To be more specific let me give you an example we face with now:
>
>     Although KMD now use a cache way to give libdrm the
>     CC_RB_BACKEND_DISABLE value, but KMD still need to read it at
>     least one shot during loading driver right ?
>
>     For SR-IOV there is still chance that VF2 is doing CPU based tlb
>     flush while VF1 is doing driver loading, so there are chance that
>     tlb flush of VF2 was ruined by
>
>     The driver loading (one shot CC_RB_BACKEND_DISABLE reading).
>
>     Not only tlb flush, other ring’s vm flush of VF2 can all be ruined
>     by this register’s reading from VF1, right ?
>
>     How you solve that ?
>
>     /Monk
>
>     *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On
>     Behalf Of *Liu, Monk
>     *Sent:* 2018年3月8日18:03
>     *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>     <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander
>     <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>;
>     Mao, David <David.Mao-5C7GfCeVMHo@public.gmane.org> <mailto:David.Mao-5C7GfCeVMHo@public.gmane.org>
>     *Cc:* Jin, Jian-Rong <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>
>     <mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     *Subject:* RE: deprecated register issues
>
>     Yeah, I agree with you we’d better find all those registers
>
>     Stitch together the REQ and ACK part only avoid this issue for vm
>     flush only, and we may still hit the issue in other place, I knew it.
>
>     The frustrating job is how can we find all those registers ?
>
>     And more is since this CC_RB_BACKEND_DISABLE register is not
>     deprecated (confirmed with David M), and driver indeed nee to read it
>
>     How could we avoid this reading cause vm hub broken ?
>
>     I believe like you said there are a bunch of registers (not really
>     deprecated ) reading would cause vm hub broken, how could we still
>     read
>
>     Them when we want but also not to trigger the world switch issue ?
>
>     looks to me there is no way to do that, even if you already find
>     out all of those registers, we still need to access them, so the
>     world switch (or other issues)
>
>     are still going to fail, and that’s why I think the plan B at
>     least have its reason to stand there.
>
>     any thought ?
>
>     /Monk
>
>     *From:*Christian König [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>     *Sent:* 2018年3月8日17:41
>     *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>;
>     Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
>     <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>; Koenig, Christian
>     <Christian.Koenig-5C7GfCeVMHo@public.gmane.org <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>>; Mao,
>     David <David.Mao-5C7GfCeVMHo@public.gmane.org <mailto:David.Mao-5C7GfCeVMHo@public.gmane.org>>
>     *Cc:* Jin, Jian-Rong <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org
>     <mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     *Subject:* Re: deprecated register issues
>
>     Hi Monk,
>
>
>         While we can avoid such vm flush failure by stitch together of
>         the sending REQ and reading ACK part, at least for compute
>         ring this is confirmed.
>
>     Well there are two misunderstanding here.
>
>     First of all this solution doesn't really work, it just hides the
>     problem because we don't do a world switch in between those two
>     packets any more. And while we could change the SDMA, UVD and VCE
>     firmware do to something similar you can't apply this solution to
>     CPU based flushes.
>
>     The second issue is that this isn't related to VMHUB flushing at
>     all, it's just that VMHUB flushing is the first thing where you
>     notice that something is wrong.
>
>     The real problem is that when you access CC_RB_BACKEND_DISABLE and
>     a bunch of other registers the bus on Vega10 sometimes gets a
>     hickup and drops other reads and writes.
>
>     So we need to identify those registers and removes all accesses to
>     them, otherwise working with the hardware will just be horrible
>     unreliable in general.
>
>     Regards,
>     Christian.
>
>     Am 08.03.2018 um 04:05 schrieb Liu, Monk:
>
>         Hi Alex
>
>         While we can avoid such vm flush failure by stitch together of
>         the sending REQ and reading ACK part, at least for compute
>         ring this is confirmed.
>
>         And I believe for SDMA ring (even UVD/VCE ring) it could also
>         be achieved.
>
>         But @Koenig, Christian <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>         insist stitching together the REQ AND ACK part is not a formal
>         way to fix the issue, instead just a walkaround and I cannot
>         debate that
>
>         What make me worry more is what if there are more registers
>         like Alex said that behaves like this CC_RB_BACKEND_DISABLE,
>
>         since we don’t know their names(too hard to filter them out!)
>         so we couldn’t remove them all from SR list,
>
>         So I still think we need plan B to handle above case,  A.K.A
>         use one package for the REQ and ACK job
>
>         /Monk
>
>         *From:*Deucher, Alexander
>         *Sent:* 2018年3月8日10:53
>         *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>;
>         Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>         <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Mao, David
>         <David.Mao-5C7GfCeVMHo@public.gmane.org> <mailto:David.Mao-5C7GfCeVMHo@public.gmane.org>
>         *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jin, Jian-Rong
>         <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org> <mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>
>         *Subject:* Re: deprecated register issues
>
>         I think there are more than just CC_RB_BACKEND_DISABLE that
>         could cause this problem.  IIRC, some entire class of gfx
>         registers could cause it, it just happened that this was one
>         of the only ones we readback via mmio.  Also for the save and
>         restore list, I think the RLC uses a different interface to
>         read back the registers so it may not be affected the same way.
>
>         Alex
>
>         ------------------------------------------------------------------------
>
>         *From:*Liu, Monk
>         *Sent:* Wednesday, March 7, 2018 9:42:41 PM
>         *To:* Deucher, Alexander; Koenig, Christian; Mao, David
>         *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jin, Jian-Rong
>         *Subject:* RE: deprecated register issues
>
>         Hi guys
>
>         According to Christian’s found, reading this register would
>         make vm hub failed to finish the vm flush request , e.g.: sdma
>         is doing vm flush which first write data to vm_invalidat_req
>         and read result from vm_invalidate_ack, but found driver will
>         forever failed to get the correct value from vm_invalidate_ack
>         if the meantime BIF is reading this CC_RB_BACKEND_DISABLE
>         register.
>
>         Now SR-IOV world switch also may get such similar trouble, see
>         below save_restore_list ( during world_switch, RLCV will save
>         current VF’s register according to this list and restore all
>         those registers when loading back this VF)
>
>         uint32 register_restore[] = {
>
>         (uint32)((0x3000 << 18) | mmPA_SC_FIFO_SIZE),   /* SC   */
>
>                0x00000001,
>
>         *       (uint32)((0x3000 << 18) | mmCC_RB_BACKEND_DISABLE),  
>         /* SC SC PER_SE  */*
>
>         *       0x00000000,*
>
>         *       (uint32)((0x3400 << 18) | mmCC_RB_BACKEND_DISABLE),  
>         /* SC SC PER_SE  */*
>
>         *       0x00000000,*
>
>         *       (uint32)((0x3800 << 18) | mmCC_RB_BACKEND_DISABLE),  
>         /* SC SC PER_SE  */*
>
>         *       0x00000000,*
>
>         *       (uint32)((0x3c00 << 18) | mmCC_RB_BACKEND_DISABLE),  
>         /* SC SC PER_SE  */*
>
>         *       0x00000000,*
>
>         (uint32)((0x3000 << 18) | mmVGT_VTX_VECT_EJECT_REG),
>
>                0x00000001,
>
>         (uint32)((0x3000 << 18) | mmVGT_DMA_DATA_FIFO_DEPTH),   /* IA
>         WD  */
>
>                0x00000001,
>
>         (uint32)((0x3000 << 18) | mmVGT_DMA_REQ_FIFO_DEPTH),   /* WD   */
>
>                0x00000001,
>
>         (uint32)((0x3000 << 18) | mmVGT_DRAW_INIT_FIFO_DEPTH),   /*
>         WD   */
>
>                0x00000001,
>
>         (uint32)((0x3000 << 18) | mmVGT_CACHE_INVALIDATION),   /*  IA  */
>
>                0x00000001,
>
>         (uint32)((0x3000 << 18) | mmVGT_RESET_DEBUG),   /*  WD  */
>
>                0x00000001,
>
>         (uint32)((0x3000 << 18) | mmVGT_FIFO_DEPTHS),
>
>         I will do some test against this CC_RB_BACKEND_DISABLE
>         register, see if vm flush failure issue could be avoided by
>         removing those four register from SR list
>
>         Thanks
>
>         /Monk
>
>         *From:*Deucher, Alexander
>         *Sent:* 2018年3月7日23:13
>         *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org
>         <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>>; Mao, David
>         <David.Mao-5C7GfCeVMHo@public.gmane.org <mailto:David.Mao-5C7GfCeVMHo@public.gmane.org>>; Liu, Monk
>         <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>
>         *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jin, Jian-Rong
>         <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org <mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>>
>         *Subject:* Re: deprecated register issues
>
>         Right.  We ran into issues with reading back that register at
>         runtime when UMDs queried it when other stuff was in flight,
>         so we just read it once at startup and cache the results. Now
>         when UMDs request it, we return the cached value.
>
>         Alex
>
>         ------------------------------------------------------------------------
>
>         *From:*Koenig, Christian
>         *Sent:* Wednesday, March 7, 2018 9:31:13 AM
>         *To:* Mao, David; Liu, Monk
>         *Cc:* Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jin, Jian-Rong
>         *Subject:* Re: deprecated register issues
>
>         Hi David,
>
>         well I just figured that this is a misunderstanding.
>
>         Accessing this register and some other deprecated registers
>         can cause problem when invalidating VMHUBs.
>
>         This register itself isn't deprecated, the wording in a patch
>         fixing things is just a bit unclear.
>
>         Question is is that register still accessed regularly or is it
>         value cached after startup?
>
>         Regards,
>         Christian.
>
>         Am 07.03.2018 um 15:25 schrieb Mao, David:
>
>             We requires base driver to provide the mask of disabled RB.
>
>             This is why kernel read the CC_RB_BACKEND_DISABLE to
>             collect the harvest configuration.
>
>             Where did you get to know that the register is deprecated?
>
>             I think it should still be there.
>
>             Best Regards,
>
>             David
>
>                 On Mar 7, 2018, at 9:49 PM, Liu, Monk
>                 <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>                 + UMD guys
>
>                 Hi David
>
>                 Do you know if*GC_USER_RB_BACKEND_DISABLE is still
>                 exist for gfx9/vega10 ?*
>
>                 **
>
>                 *We found*CC_RB_BACKEND_DISABLE was deprecated but
>                 looks it is still in use in kmd, so
>
>                 I want to check with you both of above registers
>
>                 Thanks
>
>                 /Monk
>
>                 *From:*amd-gfx
>                 [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]*On
>                 Behalf Of*Christian K?nig
>                 *Sent:*2018年3月7日20:26
>                 *To:*Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org
>                 <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>; Deucher, Alexander
>                 <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
>                 <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
>                 *Cc:*amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>                 *Subject:*Re: deprecated register issues
>
>                 Hi Monk,
>
>                 I honestly don't have the slightest idea why we are
>                 still accessing CC_RB_BACKEND_DISABLE. Maybe it still
>                 contains some useful values?
>
>                 Key point was that we needed to stop accessing it all
>                 the time to avoid triggering problems.
>
>                 Regards,
>                 Christian.
>
>                 Am 07.03.2018 um 13:11 schrieb Liu, Monk:
>
>                     Hi Christian
>
>                     I remember you and AlexD mentioned that a handful
>                     registers are deprecated for greenland (gfx9)
>
>                     e.g. CC_RB_BACKEND_DISABLE
>
>                     do you know why we still have this routine ?
>
>                     staticu32
>
>                     gfx_v9_0_get_rb_active_bitmap(structamdgpu_device
>                     *adev)
>
>                     {
>
>                         u32 data, mask;
>
>                         data =RREG32_SOC15(GC,
>
>                     0, mmCC_RB_BACKEND_DISABLE);
>
>                         data |=RREG32_SOC15(GC,
>
>                     0, mmGC_USER_RB_BACKEND_DISABLE);
>
>                         data &=
>                     CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
>
>                         data >>=
>                     GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
>
>                         mask
>                     =amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se/
>
>                     adev->gfx.config.max_sh_per_se);
>
>                         return(~data) & mask;
>
>                     }
>
>                     see that it still read CC_RB_BACKEND_DISABLE
>
>                     thanks
>
>                     /Monk
>
>
>
>
>         _______________________________________________
>
>         amd-gfx mailing list
>
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------EEA43B6149A3AB3923D2E9DF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That would be a possibility, but I
      don't think reading the register once during driver startup is a
      real issue.<br>
      <br>
      See you need to hammer on the problematic registers to trigger the
      misbehavior, e.g. not read it once or twice but thousands of
      times.<br>
      <br>
      Additional to that as I said before, VM flushes are not really the
      problem. While investigating this I've worked around the VM flush
      issue by just writing the register value multiple times.<br>
      <br>
      That works around the problem pretty reliable as well and would be
      trivial to implement, but it just doesn't fix the real issue that
      the hardware is dropping register writes.<br>
      <br>
      And dropping register writes can have all kind of problematic
      effects, from performance problems because of not acknowledged
      interrupts, over incorrect calculation results to complete hangs.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.03.2018 um 04:29 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB16521216A47BC1FFC0414658F7DE0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Can GIM read the value
          and pass it to the VF's via the vbios or the shared area?</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Alex<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b> Liu,
          Monk<br>
          <b>Sent:</b> Thursday, March 8, 2018 9:59:34 PM<br>
          <b>To:</b> Koenig, Christian; Deucher, Alexander; Mao, David<br>
          <b>Cc:</b> Jin, Jian-Rong; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> RE: deprecated register issues</font>
        <div> </div>
      </div>
      <style>
<!--
@font-face
	{font-family:宋体}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:等线}
@font-face
	{font-family:Calibri}
@font-face
	{}
@font-face
	{}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;
	color:black}
a:x_link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:x_visited, span.x_MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
pre
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;
	color:black}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;
	color:black}
span.x_HTMLPreformattedChar
	{font-family:"Courier New",serif;
	color:black}
p.x_xmsonormal, li.x_xmsonormal, div.x_xmsonormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;
	color:black}
p.x_xmsonormal0, li.x_xmsonormal0, div.x_xmsonormal0
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;
	color:black}
p.x_xmsochpdefault, li.x_xmsochpdefault, div.x_xmsochpdefault
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:宋体;
	color:black}
span.x_xemailstyle21
	{font-family:等线;
	color:windowtext}
span.x_xxapple-converted-space
	{}
span.x_EmailStyle25
	{font-family:等线;
	color:windowtext}
span.x_EmailStyle26
	{font-family:等线;
	color:windowtext}
span.x_EmailStyle27
	{font-family:等线;
	color:windowtext}
span.x_EmailStyle30
	{font-family:等线;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 90.0pt 72.0pt 90.0pt}
div.x_WordSection1
	{}
-->
</style>
      <div link="blue" vlink="purple" style="background-color:white"
        lang="ZH-CN">
        <div class="x_WordSection1">
          <p class="x_MsoNormal"><span style="font-size:10.5pt;
              font-family:等线; color:windowtext" lang="EN-US">&gt;</span><span
              style="font-size:10.5pt; font-family:等线; color:windowtext"
              lang="EN-US"> Although KMD now use a cache way to give
              libdrm the CC_RB_BACKEND_DISABLE value, but KMD still need
              to read it at least one shot during loading driver right ?</span><span
              lang="EN-US"></span></p>
          <p class="x_MsoNormal"><span lang="EN-US">Correct, but we do
              this while having exclusive access.</span></p>
          <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
          <p class="x_MsoNormal"><span lang="EN-US">The problem is
              although for VF0 it is reading this register in exclusive
              mode, but meanwhile another VF may doing the VM flush,
              thus</span></p>
          <p class="x_MsoNormal"><span lang="EN-US">The issue is still
              there as long as any VF is allowed to read this register,</span></p>
          <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
          <p class="x_MsoNormal"><span lang="EN-US">It’s not related if
              in exclusive or not</span></p>
          <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
          <p class="x_MsoNormal"><span lang="EN-US">/Monk</span><span
              style="font-size:10.5pt; font-family:等线; color:windowtext"
              lang="EN-US"></span></p>
          <p class="x_MsoNormal"><span style="font-size:10.5pt;
              font-family:等线; color:windowtext" lang="EN-US"> </span></p>
          <div>
            <div style="border:none; border-top:solid #E1E1E1 1.0pt;
              padding:3.0pt 0cm 0cm 0cm">
              <p class="x_MsoNormal"><b><span style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US">From:</span></b><span
                  style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,sans-serif;
                  color:windowtext" lang="EN-US"> Koenig, Christian
                  <br>
                  <b>Sent:</b> 2018</span><span style="font-size:11.0pt;
                  color:windowtext">年</span><span
                  style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,sans-serif;
                  color:windowtext" lang="EN-US">3</span><span
                  style="font-size:11.0pt; color:windowtext">月</span><span
                  style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,sans-serif;
                  color:windowtext" lang="EN-US">8</span><span
                  style="font-size:11.0pt; color:windowtext">日</span><span
                  style="font-size:11.0pt;
                  font-family:&quot;Calibri&quot;,sans-serif;
                  color:windowtext" lang="EN-US"> 18:51<br>
                  <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Mao, David <a class="moz-txt-link-rfc2396E" href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org">&lt;David.Mao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Cc:</b> Jin, Jian-Rong
                  <a class="moz-txt-link-rfc2396E" href="mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org">&lt;Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: deprecated register issues</span></p>
            </div>
          </div>
          <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
          <div>
            <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线; color:windowtext" lang="EN-US">Although
                  KMD now use a cache way to give libdrm the
                  CC_RB_BACKEND_DISABLE value, but KMD still need to
                  read it at least one shot during loading driver right
                  ?</span><span lang="EN-US"></span></p>
            </blockquote>
            <p class="x_MsoNormal"><span lang="EN-US">Correct, but we do
                this while having exclusive access.<br>
                <br>
                <br>
              </span></p>
            <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线; color:windowtext" lang="EN-US">Not
                  only tlb flush, other ring</span><span
                  style="font-size:10.5pt; font-family:等线;
                  color:windowtext">’<span lang="EN-US">s vm flush of
                    VF2 can all be ruined by this register</span>’<span
                    lang="EN-US">s reading from VF1, right ?</span></span><span
                  lang="EN-US"></span></p>
            </blockquote>
            <p class="x_MsoNormal"><span lang="EN-US">Not sure about
                that. But as I said that problem is not limited to VM
                flushes, e.g. when you access this register any other
                register write or read can be affected.<br>
                <br>
                May theory is that accessing those registers sometimes
                times out when the MC is to busy or something like this
                and this timeout in turn results in a register bus reset
                which affects all other ongoing operations as well.<br>
                <br>
                <br>
              </span></p>
            <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
              <p class="x_MsoNormal" style=""><span
                  style="font-size:10.5pt; font-family:等线;
                  color:windowtext" lang="EN-US">How you solve that ?</span><span
                  lang="EN-US"></span></p>
            </blockquote>
            <p class="x_MsoNormal"><span lang="EN-US">Stop accessing the
                affected registers as much as possible, there is no
                really any other known workaround.<br>
                <br>
                The risk by accessing it when the driver loads is
                minimal, we just need to make sure that we don't touch
                them during world switch.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                Am 08.03.2018 um 11:11 schrieb Liu, Monk:</span></p>
          </div>
          <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">To be
                more specific let me give you an example we face with
                now:</span><span lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">Although
                KMD now use a cache way to give libdrm the
                CC_RB_BACKEND_DISABLE value, but KMD still need to read
                it at least one shot during loading driver right ?</span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">For
                SR-IOV there is still chance that VF2 is doing CPU based
                tlb flush while VF1 is doing driver loading, so there
                are chance that tlb flush of VF2 was ruined by </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">The
                driver loading (one shot CC_RB_BACKEND_DISABLE reading).</span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">Not only
                tlb flush, other ring</span><span
                style="font-size:10.5pt; font-family:等线;
                color:windowtext">’<span lang="EN-US">s vm flush of VF2
                  can all be ruined by this register</span>’<span
                  lang="EN-US">s reading from VF1, right ?</span></span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">How you
                solve that ?</span><span lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">/Monk</span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <div>
              <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                padding:3.0pt 0cm 0cm 0cm">
                <p class="x_MsoNormal"><b><span style="font-size:11.0pt;
                      font-family:&quot;Calibri&quot;,sans-serif;
                      color:windowtext" lang="EN-US">From:</span></b><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US"> amd-gfx [<a
                      href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                    <b>On Behalf Of </b>Liu, Monk<br>
                    <b>Sent:</b> 2018</span><span
                    style="font-size:11.0pt; color:windowtext">年</span><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US">3</span><span
                    style="font-size:11.0pt; color:windowtext">月</span><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US">8</span><span
                    style="font-size:11.0pt; color:windowtext">日</span><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US"> 18:03<br>
                    <b>To:</b> Koenig, Christian <a
                      href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    Deucher, Alexander
                    <a href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    Mao, David
                    <a href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;David.Mao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    <b>Cc:</b> Jin, Jian-Rong <a
                      href="mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                    <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    <b>Subject:</b> RE: deprecated register issues</span><span
                    lang="EN-US"></span></p>
              </div>
            </div>
            <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">Yeah, I
                agree with you we</span><span style="font-size:10.5pt;
                font-family:等线; color:windowtext">’<span lang="EN-US">d
                  better find all those registers</span></span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">Stitch
                together the REQ and ACK part only avoid this issue for
                vm flush only, and we may still hit the issue in other
                place, I knew it.</span><span lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">The
                frustrating job is how can we find all those registers ?</span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">And more
                is since this CC_RB_BACKEND_DISABLE register is not
                deprecated (confirmed with David M), and driver indeed
                nee to read it</span><span lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">How could
                we avoid this reading cause vm hub broken ?</span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">I believe
                like you said there are a bunch of registers (not really
                deprecated ) reading would cause vm hub broken, how
                could we still read</span><span lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">Them when
                we want but also not to trigger the world switch issue ?
              </span><span lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">looks to
                me there is no way to do that, even if you already find
                out all of those registers, we still need to access
                them, so the world switch (or other issues)</span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">are still
                going to fail, and that</span><span
                style="font-size:10.5pt; font-family:等线;
                color:windowtext">’<span lang="EN-US">s why I think the
                  plan B at least have its reason to stand there.</span></span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">any
                thought ?</span><span lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US">/Monk</span><span
                lang="EN-US"></span></p>
            <p class="x_MsoNormal"><span style="font-size:10.5pt;
                font-family:等线; color:windowtext" lang="EN-US"> </span><span
                lang="EN-US"></span></p>
            <div>
              <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                padding:3.0pt 0cm 0cm 0cm">
                <p class="x_MsoNormal"><b><span style="font-size:11.0pt;
                      font-family:&quot;Calibri&quot;,sans-serif;
                      color:windowtext" lang="EN-US">From:</span></b><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US"> Christian König [<a
                      href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                      moz-do-not-send="true">mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
                    <br>
                    <b>Sent:</b> 2018</span><span
                    style="font-size:11.0pt; color:windowtext">年</span><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US">3</span><span
                    style="font-size:11.0pt; color:windowtext">月</span><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US">8</span><span
                    style="font-size:11.0pt; color:windowtext">日</span><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif;
                    color:windowtext" lang="EN-US"> 17:41<br>
                    <b>To:</b> Liu, Monk &lt;<a
                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    Deucher, Alexander &lt;<a
                      href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    Koenig, Christian &lt;<a
                      href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    Mao, David &lt;<a href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">David.Mao-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <b>Cc:</b> Jin, Jian-Rong &lt;<a
                      href="mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    <b>Subject:</b> Re: deprecated register issues</span><span
                    lang="EN-US"></span></p>
              </div>
            </div>
            <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
            <div>
              <p class="x_MsoNormal" style="margin-bottom:12.0pt"><span
                  lang="EN-US">Hi Monk,<br>
                  <br>
                  <br>
                </span></p>
              <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
                <p class="x_MsoNormal"><span style="font-size:10.5pt;
                    font-family:等线" lang="EN-US">While we can avoid such
                    vm flush failure by stitch together of the sending
                    REQ and reading ACK part, at least for compute ring
                    this is confirmed.</span><span lang="EN-US"></span></p>
              </blockquote>
              <p class="x_MsoNormal"><span lang="EN-US">Well there are
                  two misunderstanding here.
                  <br>
                  <br>
                  First of all this solution doesn't really work, it
                  just hides the problem because we don't do a world
                  switch in between those two packets any more. And
                  while we could change the SDMA, UVD and VCE firmware
                  do to something similar you can't apply this solution
                  to CPU based flushes.<br>
                  <br>
                  The second issue is that this isn't related to VMHUB
                  flushing at all, it's just that VMHUB flushing is the
                  first thing where you notice that something is wrong.<br>
                  <br>
                  The real problem is that when you access </span><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">CC_RB_BACKEND_DISABLE and a bunch of
                  other registers the bus on Vega10 sometimes gets a
                  hickup and drops other reads and writes.<br>
                  <br>
                  So we need to identify those registers and removes all
                  accesses to them, otherwise working with the hardware
                  will just be horrible unreliable in general.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                </span><span lang="EN-US"><br>
                  Am 08.03.2018 um 04:05 schrieb Liu, Monk:</span></p>
            </div>
            <blockquote style="margin-top:5.0pt; margin-bottom:5.0pt">
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">Hi Alex</span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US"> </span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">While we can avoid such
                  vm flush failure by stitch together of the sending REQ
                  and reading ACK part, at least for compute ring this
                  is confirmed.</span><span lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">And I believe for SDMA
                  ring (even UVD/VCE ring) it could also be achieved.</span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US"> </span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">But
                  <a id="OWAAM88494E83DC8949F581E2AEBF1FC603DA"
                    href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                    moz-do-not-send="true">
                    <span style="font-family:等线; text-decoration:none">@Koenig,
                      Christian</span></a> insist stitching together the
                  REQ AND ACK part is not a formal way to fix the issue,
                  instead just a walkaround and I cannot debate that</span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US"> </span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">What make me worry more
                  is what if there are more registers like Alex said
                  that behaves like this CC_RB_BACKEND_DISABLE,
                </span><span lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">since we don</span><span
                  style="font-size:10.5pt; font-family:等线">’<span
                    lang="EN-US">t know their names(too hard to filter
                    them out!) so we couldn</span>’<span lang="EN-US">t
                    remove them all from SR list, </span></span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">So I still think we need
                  plan B to handle above case,  A.K.A use one package
                  for the REQ and ACK job</span><span lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US"> </span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US">/Monk</span><span
                  lang="EN-US"></span></p>
              <p class="x_MsoNormal"><span style="font-size:10.5pt;
                  font-family:等线" lang="EN-US"> </span><span
                  lang="EN-US"></span></p>
              <div>
                <div style="border:none; border-top:solid #E1E1E1 1.0pt;
                  padding:3.0pt 0cm 0cm 0cm">
                  <p class="x_MsoNormal"><b><span
                        style="font-size:11.0pt;
                        font-family:&quot;Calibri&quot;,sans-serif"
                        lang="EN-US">From:</span></b><span
                      style="font-size:11.0pt;
                      font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> Deucher, Alexander
                      <br>
                      <b>Sent:</b> 2018</span><span
                      style="font-size:11.0pt">年</span><span
                      style="font-size:11.0pt;
                      font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">3</span><span
                      style="font-size:11.0pt">月</span><span
                      style="font-size:11.0pt;
                      font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">8</span><span
                      style="font-size:11.0pt">日</span><span
                      style="font-size:11.0pt;
                      font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US"> 10:53<br>
                      <b>To:</b> Liu, Monk <a
                        href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                      Koenig, Christian
                      <a href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                      Mao, David
                      <a href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;David.Mao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                      <b>Cc:</b> <a
                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                      Jin, Jian-Rong
                      <a href="mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                      <b>Subject:</b> Re: deprecated register issues</span><span
                      lang="EN-US"></span></p>
                </div>
              </div>
              <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
              <div id="x_divtagdefaultwrapper">
                <p><span
                    style="font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US">I think there are more than just
                    CC_RB_BACKEND_DISABLE that could cause this
                    problem.  IIRC, some entire class of gfx registers
                    could cause it, it just happened that this was one
                    of the only ones we readback via mmio.  Also for the
                    save and restore list, I think the RLC uses a
                    different interface to read back the registers so it
                    may not be affected the same way.</span><span
                    lang="EN-US"></span></p>
                <p><span
                    style="font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US"> </span><span lang="EN-US"></span></p>
                <p><span
                    style="font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US">Alex</span><span lang="EN-US"></span></p>
              </div>
              <div class="x_MsoNormal" style="text-align:center"
                align="center"><span lang="EN-US">
                  <hr align="center" size="3" width="98%">
                </span></div>
              <div id="x_divRplyFwdMsg">
                <p class="x_MsoNormal"><b><span style="font-size:11.0pt;
                      font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">From:</span></b><span
                    style="font-size:11.0pt;
                    font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US"> Liu, Monk<br>
                    <b>Sent:</b> Wednesday, March 7, 2018 9:42:41 PM<br>
                    <b>To:</b> Deucher, Alexander; Koenig, Christian;
                    Mao, David<br>
                    <b>Cc:</b> <a
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                    Jin, Jian-Rong<br>
                    <b>Subject:</b> RE: deprecated register issues</span><span
                    lang="EN-US"> </span></p>
                <div>
                  <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
                </div>
              </div>
              <div>
                <div>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">Hi guys
                    </span><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US"> </span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">According to
                      Christian</span><span style="font-size:10.5pt;
                      font-family:等线">’<span lang="EN-US">s found,
                        reading this register would make vm hub failed
                        to finish the vm flush request , e.g.: sdma is
                        doing vm flush which first write data to
                        vm_invalidat_req and read result from
                        vm_invalidate_ack, but found driver will forever
                        failed to get the correct value from
                        vm_invalidate_ack if the meantime BIF is reading
                        this CC_RB_BACKEND_DISABLE register.</span></span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US"> </span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">Now SR-IOV world
                      switch also may get such similar trouble, see
                      below save_restore_list ( during world_switch,
                      RLCV will save current VF</span><span
                      style="font-size:10.5pt; font-family:等线">’<span
                        lang="EN-US">s register according to this list
                        and restore all those registers when loading
                        back this VF)</span></span><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US"> </span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">uint32
                      register_restore[] = {</span><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmPA_SC_FIFO_SIZE),   /* SC   */</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">       0x00000001,</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       (uint32)((0x3000 &lt;&lt;
                        18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC
                        PER_SE  */</span></b><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       0x00000000,</span></b><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       (uint32)((0x3400 &lt;&lt;
                        18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC
                        PER_SE  */</span></b><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       0x00000000,</span></b><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       (uint32)((0x3800 &lt;&lt;
                        18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC
                        PER_SE  */</span></b><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       0x00000000,</span></b><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       (uint32)((0x3c00 &lt;&lt;
                        18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC
                        PER_SE  */</span></b><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><b><span
                        style="font-size:10.5pt; font-family:等线"
                        lang="EN-US">       0x00000000,</span></b><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmVGT_VTX_VECT_EJECT_REG),      
                    </span><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">       0x00000001,</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmVGT_DMA_DATA_FIFO_DEPTH),   /* IA WD  */</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">       0x00000001,</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmVGT_DMA_REQ_FIFO_DEPTH),   /* WD   */</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">       0x00000001,</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmVGT_DRAW_INIT_FIFO_DEPTH),   /* WD   */</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">       0x00000001,</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmVGT_CACHE_INVALIDATION),   /*  IA  */</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">       0x00000001,</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmVGT_RESET_DEBUG),   /*  WD  */</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">       0x00000001,</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">      
                      (uint32)((0x3000 &lt;&lt; 18) |
                      mmVGT_FIFO_DEPTHS),      
                    </span><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US"> </span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">I will do some test
                      against this CC_RB_BACKEND_DISABLE register, see
                      if vm flush failure issue could be avoided by
                      removing those four register from SR list
                    </span><span lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US"> </span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">Thanks</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US"> </span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US">/Monk</span><span
                      lang="EN-US"></span></p>
                  <p class="x_xmsonormal"><span style="font-size:10.5pt;
                      font-family:等线" lang="EN-US"> </span><span
                      lang="EN-US"></span></p>
                  <div>
                    <div style="border:none; border-top:solid #E1E1E1
                      1.0pt; padding:3.0pt 0cm 0cm 0cm">
                      <p class="x_xmsonormal"><b><span
                            style="font-size:11.0pt;
                            font-family:&quot;Calibri&quot;,sans-serif"
                            lang="EN-US">From:</span></b><span
                          style="font-size:11.0pt;
                          font-family:&quot;Calibri&quot;,sans-serif"
                          lang="EN-US"> Deucher, Alexander
                          <br>
                          <b>Sent:</b> 2018</span><span
                          style="font-size:11.0pt">年</span><span
                          style="font-size:11.0pt;
                          font-family:&quot;Calibri&quot;,sans-serif"
                          lang="EN-US">3</span><span
                          style="font-size:11.0pt">月</span><span
                          style="font-size:11.0pt;
                          font-family:&quot;Calibri&quot;,sans-serif"
                          lang="EN-US">7</span><span
                          style="font-size:11.0pt">日</span><span
                          style="font-size:11.0pt;
                          font-family:&quot;Calibri&quot;,sans-serif"
                          lang="EN-US"> 23:13<br>
                          <b>To:</b> Koenig, Christian &lt;<a
                            href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                          Mao, David &lt;<a
                            href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">David.Mao-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                          Liu, Monk &lt;<a
                            href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                          <b>Cc:</b> <a
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                          Jin, Jian-Rong &lt;<a
                            href="mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                          <b>Subject:</b> Re: deprecated register issues</span><span
                          lang="EN-US"></span></p>
                    </div>
                  </div>
                  <p class="x_xmsonormal"><span lang="EN-US"> </span></p>
                  <div id="x_x_divtagdefaultwrapper">
                    <p><span
                        style="font-family:&quot;Calibri&quot;,sans-serif"
                        lang="EN-US">Right.  We ran into issues with
                        reading back that register at runtime when UMDs
                        queried it when other stuff was in flight, so we
                        just read it once at startup and cache the
                        results. Now when UMDs request it, we return the
                        cached value.</span><span lang="EN-US"></span></p>
                    <p><span
                        style="font-family:&quot;Calibri&quot;,sans-serif"
                        lang="EN-US"> </span><span lang="EN-US"></span></p>
                    <p><span
                        style="font-family:&quot;Calibri&quot;,sans-serif"
                        lang="EN-US">Alex</span><span lang="EN-US"></span></p>
                  </div>
                  <div class="x_MsoNormal" style="text-align:center"
                    align="center"><span lang="EN-US">
                      <hr align="center" size="3" width="98%">
                    </span></div>
                  <div id="x_x_divRplyFwdMsg">
                    <p class="x_xmsonormal"><b><span
                          style="font-size:11.0pt;
                          font-family:&quot;Calibri&quot;,sans-serif"
                          lang="EN-US">From:</span></b><span
                        style="font-size:11.0pt;
                        font-family:&quot;Calibri&quot;,sans-serif"
                        lang="EN-US"> Koenig, Christian<br>
                        <b>Sent:</b> Wednesday, March 7, 2018 9:31:13 AM<br>
                        <b>To:</b> Mao, David; Liu, Monk<br>
                        <b>Cc:</b> Deucher, Alexander; <a
                          href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                          moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                        Jin, Jian-Rong<br>
                        <b>Subject:</b> Re: deprecated register issues</span><span
                        lang="EN-US"> </span></p>
                    <div>
                      <p class="x_xmsonormal"><span lang="EN-US"> </span></p>
                    </div>
                  </div>
                  <div>
                    <div>
                      <p class="x_xmsonormal" style="background:white"><span
                          lang="EN-US">Hi David,<br>
                          <br>
                          well I just figured that this is a
                          misunderstanding.<br>
                          <br>
                          Accessing this register and some other
                          deprecated registers can cause problem when
                          invalidating VMHUBs.<br>
                          <br>
                          This register itself isn't deprecated, the
                          wording in a patch fixing things is just a bit
                          unclear.<br>
                          <br>
                          Question is is that register still accessed
                          regularly or is it value cached after startup?
                          <br>
                          <br>
                          Regards,<br>
                          Christian.<br>
                          <br>
                          Am 07.03.2018 um 15:25 schrieb Mao, David:</span></p>
                    </div>
                    <blockquote style="margin-top:5.0pt;
                      margin-bottom:5.0pt">
                      <p class="x_xmsonormal" style="background:white"><span
                          lang="EN-US">We requires base driver to
                          provide the mask of disabled RB.
                        </span></p>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            lang="EN-US">This is why kernel read the
                            CC_RB_BACKEND_DISABLE to collect the harvest
                            configuration.</span></p>
                      </div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            lang="EN-US">Where did you get to know that
                            the register is deprecated?</span></p>
                      </div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            lang="EN-US">I think it should still be
                            there.</span></p>
                      </div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            lang="EN-US"> </span></p>
                      </div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            lang="EN-US">Best Regards,</span></p>
                      </div>
                      <div>
                        <p class="x_xmsonormal" style="background:white"><span
                            lang="EN-US">David</span></p>
                        <div>
                          <p class="x_xmsonormal"
                            style="margin-bottom:12.0pt;
                            background:white"><span lang="EN-US"> </span></p>
                          <blockquote style="margin-top:5.0pt;
                            margin-bottom:5.0pt">
                            <div>
                              <p class="x_xmsonormal"
                                style="background:white"><span
                                  lang="EN-US">On Mar 7, 2018, at 9:49
                                  PM, Liu, Monk &lt;<a
                                    href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                                    moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;
                                  wrote:</span></p>
                            </div>
                            <p class="x_xmsonormal"
                              style="background:white"><span
                                lang="EN-US"> </span></p>
                            <div>
                              <div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      style="font-size:10.5pt;
                                      font-family:等线" lang="EN-US">+ UMD
                                      guys</span><span lang="EN-US"></span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      style="font-size:10.5pt;
                                      font-family:等线" lang="EN-US"> </span><span
                                      lang="EN-US"></span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      style="font-size:10.5pt;
                                      font-family:等线" lang="EN-US">Hi
                                      David</span><span lang="EN-US"></span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      style="font-size:10.5pt;
                                      font-family:等线" lang="EN-US"> </span><span
                                      lang="EN-US"></span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      style="font-size:10.5pt;
                                      font-family:等线" lang="EN-US">Do
                                      you know if<span
                                        class="x_xxapple-converted-space"> </span></span><b><span
                                        style="font-size:10.5pt;
                                        font-family:&quot;Courier
                                        New&quot;,serif" lang="EN-US">GC_USER_RB_BACKEND_DISABLE
                                        is still exist for gfx9/vega10 ?</span></b><span
                                      lang="EN-US"></span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><b><span
                                        style="font-size:10.5pt;
                                        font-family:&quot;Courier New
                                        ,serif&quot;,serif" lang="EN-US"> </span></b><span
                                      lang="EN-US"></span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><b><span
                                        style="font-size:10.5pt;
                                        font-family:&quot;Courier New
                                        ,serif&quot;,serif" lang="EN-US">We
                                        found<span
                                          class="x_xxapple-converted-space"> </span></span></b><span
                                      lang="EN-US">CC_RB_BACKEND_DISABLE
                                      was deprecated but looks it is
                                      still in use in kmd, so</span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      lang="EN-US">I want to check with
                                      you both of above registers</span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      lang="EN-US"> </span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      lang="EN-US">Thanks<span
                                        class="x_xxapple-converted-space"> </span></span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      lang="EN-US">/Monk</span></p>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      style="font-size:10.5pt;
                                      font-family:等线" lang="EN-US"> </span><span
                                      lang="EN-US"></span></p>
                                </div>
                                <div>
                                  <div style="border:none;
                                    border-top:solid #E1E1E1 1.0pt;
                                    padding:3.0pt 0cm 0cm 0cm">
                                    <div>
                                      <p class="x_xmsonormal"
                                        style="background:white"><b><span
                                            style="font-size:11.0pt;
                                            font-family:&quot;Calibri&quot;,sans-serif"
                                            lang="EN-US">From:</span></b><span
class="x_xxapple-converted-space"><span style="font-size:11.0pt;
                                            font-family:&quot;Calibri&quot;,sans-serif"
                                            lang="EN-US"> </span></span><span
                                          style="font-size:11.0pt;
                                          font-family:&quot;Calibri&quot;,sans-serif"
                                          lang="EN-US">amd-gfx [<a
                                            href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                            moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]<span
class="x_xxapple-converted-space"> </span><b>On Behalf Of<span
                                              class="x_xxapple-converted-space"> </span></b>Christian
                                          K?nig<br>
                                          <b>Sent:</b><span
                                            class="x_xxapple-converted-space"> </span>2018</span><span
                                          style="font-size:11.0pt">年</span><span
                                          style="font-size:11.0pt;
                                          font-family:&quot;Calibri&quot;,sans-serif"
                                          lang="EN-US">3</span><span
                                          style="font-size:11.0pt">月</span><span
                                          style="font-size:11.0pt;
                                          font-family:&quot;Calibri&quot;,sans-serif"
                                          lang="EN-US">7</span><span
                                          style="font-size:11.0pt">日</span><span
class="x_xxapple-converted-space"><span style="font-size:11.0pt;
                                            font-family:&quot;Calibri&quot;,sans-serif"
                                            lang="EN-US"> </span></span><span
                                          style="font-size:11.0pt;
                                          font-family:&quot;Calibri&quot;,sans-serif"
                                          lang="EN-US">20:26<br>
                                          <b>To:</b><span
                                            class="x_xxapple-converted-space"> </span>Liu,
                                          Monk &lt;<a
                                            href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                                            moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                                          Deucher, Alexander &lt;<a
                                            href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                                            moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                                          <b>Cc:</b><span
                                            class="x_xxapple-converted-space"> </span><a
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                          <b>Subject:</b><span
                                            class="x_xxapple-converted-space"> </span>Re:
                                          deprecated register issues</span><span
                                          lang="EN-US"></span></p>
                                    </div>
                                  </div>
                                </div>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      lang="EN-US"> </span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        lang="EN-US">Hi Monk,<br>
                                        <br>
                                        I honestly don't have the
                                        slightest idea why we are still
                                        accessing CC_RB_BACKEND_DISABLE.
                                        Maybe it still contains some
                                        useful values?<br>
                                        <br>
                                        Key point was that we needed to
                                        stop accessing it all the time
                                        to avoid triggering problems.<br>
                                        <br>
                                        Regards,<br>
                                        Christian.<br>
                                        <br>
                                        Am 07.03.2018 um 13:11 schrieb
                                        Liu, Monk:</span></p>
                                  </div>
                                </div>
                                <blockquote style="margin-top:5.0pt;
                                  margin-bottom:5.0pt">
                                  <div>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US">Hi Christian</span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US"> </span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US">I remember you and
                                        AlexD mentioned that a handful
                                        registers are deprecated for
                                        greenland (gfx9)</span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US">e.g.
                                        CC_RB_BACKEND_DISABLE</span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US"> </span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US">do you know why we
                                        still have this routine ?</span><span
                                        lang="EN-US"></span></p>
                                    <div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">static<span
                                                class="x_xxapple-converted-space"> </span>u32</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">gfx_v9_0_get_rb_active_bitmap(struct<span
class="x_xxapple-converted-space"> </span>amdgpu_device *adev)</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">{</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">    u32 data,
                                              mask;</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">    data =<span
class="x_xxapple-converted-space"> </span>RREG32_SOC15(GC,</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">0,
                                              mmCC_RB_BACKEND_DISABLE);</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">    data |=<span
class="x_xxapple-converted-space"> </span>RREG32_SOC15(GC,</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">0,
                                              mmGC_USER_RB_BACKEND_DISABLE);</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">    data
                                              &amp;=
                                              CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">    data
                                              &gt;&gt;=
                                              GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">    mask =<span
class="x_xxapple-converted-space"> </span>amdgpu_gfx_create_bitmask(adev-&gt;gfx.config.max_backends_per_se<span
class="x_xxapple-converted-space"> </span>/</span><span lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">                    
                                              adev-&gt;</span><span
                                              lang="EN-US">gfx</span><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">.config.max_sh_per_se);</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">    return<span
class="x_xxapple-converted-space"> </span>(~data) &amp; mask;</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                      <div>
                                        <div>
                                          <p class="x_xmsonormal"
                                            style="line-height:14.25pt;
                                            background:#1E1E1E"><span
                                              style="font-size:10.5pt;
                                              font-family:&quot;Courier
                                              New&quot;,serif"
                                              lang="EN-US">}</span><span
                                              lang="EN-US"></span></p>
                                        </div>
                                      </div>
                                      <div>
                                        <p class="x_xmsonormal"
                                          style="line-height:14.25pt;
                                          background:#1E1E1E"><span
                                            style="font-size:10.5pt;
                                            font-family:&quot;Courier
                                            New&quot;,serif"
                                            lang="EN-US"> </span><span
                                            lang="EN-US"></span></p>
                                      </div>
                                    </div>
                                    <div>
                                      <p class="x_xmsonormal"
                                        style="background:white"><span
                                          style="font-family:&quot;Calibri&quot;,sans-serif"
                                          lang="EN-US"> </span><span
                                          lang="EN-US"></span></p>
                                    </div>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US">see that it still
                                        read CC_RB_BACKEND_DISABLE</span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US"> </span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US">thanks</span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US"> </span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US">/Monk</span><span
                                        lang="EN-US"></span></p>
                                    <p class="x_xmsonormal"
                                      style="background:white"><span
                                        style="font-size:9.0pt;
                                        font-family:&quot;Calibri&quot;,sans-serif"
                                        lang="EN-US"> </span><span
                                        lang="EN-US"></span></p>
                                  </div>
                                </blockquote>
                                <div>
                                  <p class="x_xmsonormal"
                                    style="background:white"><span
                                      lang="EN-US"> </span></p>
                                </div>
                              </div>
                            </div>
                          </blockquote>
                        </div>
                        <p class="x_xmsonormal" style="background:white"><span
                            lang="EN-US"> </span></p>
                      </div>
                    </blockquote>
                    <p class="x_xmsonormal" style="background:white"><span
                        lang="EN-US"> </span></p>
                  </div>
                </div>
              </div>
              <p class="x_MsoNormal" style="margin-bottom:12.0pt"><span
                  lang="EN-US"><br>
                  <br>
                  <br>
                </span></p>
              <pre><span lang="EN-US">_______________________________________________</span></pre>
              <pre><span lang="EN-US">amd-gfx mailing list</span></pre>
              <pre><span lang="EN-US"><a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></span></pre>
              <pre><span lang="EN-US"><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></span></pre>
            </blockquote>
            <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
          </blockquote>
          <p class="x_MsoNormal"><span lang="EN-US"> </span></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------EEA43B6149A3AB3923D2E9DF--

--===============0654271808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0654271808==--
