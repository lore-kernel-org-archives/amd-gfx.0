From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
Date: Wed, 19 Apr 2017 13:50:36 +0200
Message-ID: <2b43e2a9-0c79-f945-c835-0cfc486304c8@vodafone.de>
References: <1492119298-8526-1-git-send-email-AlexBin.Xie@amd.com>
 <58F0495D.60607@amd.com>
 <MWHPR1201MB0045DE55E81D0FF5CE76671FF2060@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <58F57C14.20403@amd.com>
 <MWHPR1201MB00452889FF2C7FDC55630B4BF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <7807726d-7318-b72f-1a14-2b37a73988bf@vodafone.de>
 <MWHPR1201MB00451DFD2A06BBA3CD6F928EF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <MWHPR1201MB004553768BCAC951D28A347AF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <4509f79a-ffd5-eb40-117c-84ea02cbf5cd@vodafone.de>
 <MWHPR1201MB0045EC51F6CE7C6C4283888CF2180@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0738142098=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0045EC51F6CE7C6C4283888CF2180-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0738142098==
Content-Type: multipart/alternative;
 boundary="------------1904C71AAD85342BB38903B8"

This is a multi-part message in MIME format.
--------------1904C71AAD85342BB38903B8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> Without correctly kunmap, page table is corrupted. Page entries point 
> to wrong memory locations. You might call it completely harmless. But 
> I think this is a severe bug. Leaking memory is better than a 
> corrupted page table. Think security.
We are talking about the page tables for the vmalloc area in the kernel 
here, so no security problem. Leaking memory is much more problematic.

> Would you provide any document and reference by saying" It is 
> impossible to receive a signal during module load/unload"? For 
> example, if the unload stuck in a lock, can CTRL+C stop the unload?
>
No, CTRL+C doesn't abort module load/unload. There have been patches to 
changes this a while ago, but IIRC it broke a whole bunch of driver 
relying on this.

> What about there is some other return error? What about in future 
> somebody improve amdgpu_bo_reserve to return other errors, 
> then function amdgpu_vram_scratch_fini becomes buggy?
>
Yes, that is indeed an issue. For example -EDEADLK is possible as well. 
That's why I said we should use amdgpu_bo_free_kernel() instead.

> While I am thinking whether there is a better way for the current 
> situation, would you give a real world example that my patch really 
> not working? Then we can address it.
>
I don't think there is because the driver can't receive a signal during 
load/unload, but the problem is rather that the patch doesn't improve 
the situation at all.

Regards,
Christian.

Am 19.04.2017 um 13:37 schrieb Xie, AlexBin:
>
> Hi Christian,
>
>
> Without correctly kunmap, page table is corrupted. Page entries point 
> to wrong memory locations. You might call it completely harmless. But 
> I think this is a severe bug. Leaking memory is better than a 
> corrupted page table. Think security.
>
>
> Would you provide any document and reference by saying" It is 
> impossible to receive a signal during module load/unload"? For 
> example, if the unload stuck in a lock, can CTRL+C stop the unload?
>
>
> If "It is impossible to receive a signal during module load/unload", 
> interruptible waiting is fine too, because function amdgpu_bo_reserve 
> will return successfully.
>
>
> What about there is some other return error? What about in future 
> somebody improve amdgpu_bo_reserve to return other errors, 
> then function amdgpu_vram_scratch_fini becomes buggy?
>
>
> While I am thinking whether there is a better way for the current 
> situation, would you give a real world example that my patch really 
> not working? Then we can address it.
>
>
> Thanks,
>
> Alex Bin
>
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Wednesday, April 19, 2017 2:35 AM
> *To:* Xie, AlexBin; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
> Hi AlexBin,
>
> the answer is ttm_bo_kunmap isn't called at all and yes in the case of 
> an iomap we leak the address space reserved.
>
> But that is completely harmless on a 64bit system compared to leaking 
> the memory backing the address space.
>
> Using amdgpu_bo_free_kernel() instead of openly coding it here is 
> probably a good idea.
>
> Additional to that it's probably a good idea to set the no_intr flag 
> when reserving kernel BOs. It is impossible to receive a signal during 
> module load/unload, but it's probably better to document that in the 
> code as well.
>
> Regards,
> Christian.
>
> Am 18.04.2017 um 20:54 schrieb Xie, AlexBin:
>> Hi Christian,
>>
>> Have you found how/where/when? When you said "mapping will just be 
>> released a bit later on", you must know the answer.
>>
>> It is difficult to prove something does not exist. Anyway, I will 
>> give it a try to prove such "later on" does not exist.
>>
>> Function ttm_bo_kunmap is the only function to unmap. To prove this, 
>> search ttm_bo_map_iomap, only ttm_bo_kunmap use this enum to 
>> correctly kunmap.
>>
>> Function ttm_bo_kunmap is not called by ttm itself. This is a hint 
>> that all TTM delay delete mechanism or unref mechanism will NOT 
>> kunmap BO later on.
>>
>> Function ttm_bo_kunmap is called by AMDGPU function amdgpu_bo_kunmap 
>> and amdgpu_gem_prime_vunmap.
>>
>> Search AMDGPU for amdgpu_bo_kunmap. All matches do not kunmap for 
>> scratch VRAM BO. amdgpu_bo_free_kernel is a suspect but the answer is 
>> still NO.
>>
>> So all possibilities are searched. Did I miss anything?
>>
>> Thanks,
>> Alex Bin Xie
>>
>> ------------------------------------------------------------------------
>> *From:* Xie, AlexBin
>> *Sent:* Tuesday, April 18, 2017 2:04:33 PM
>> *To:* Christian König; Zhou, David(ChunMing); 
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>
>> Hi Christian,
>>
>>
>> Would you point out where/when will kunmap happen for this BO when 
>> release? It must be somewhere in some function calls.
>>
>>
>> I checked before I asked for review. But I did not see such obvious 
>> kunmap function call.
>>
>>
>> If so, there should be a comment in function amdgpu_vram_scratch_fini 
>> to avoid future confusion.
>>
>>
>> Thanks,
>> Alex Bin Xie
>> ------------------------------------------------------------------------
>> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>> *Sent:* Tuesday, April 18, 2017 1:46 PM
>> *To:* Xie, AlexBin; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>> Hi AlexBin,
>>
>> No, David is right. This is a very common coding pattern in the 
>> kernel module.
>>
>> Freeing up a BO while there still exists a kernel mapping is 
>> perfectly ok, the mapping will just be released a bit later on.
>>
>> So this code is actually perfectly ok and just an optimization, but 
>> your patch breaks it and creates a memory leak.
>>
>> Regards,
>> Christian.
>>
>> Am 18.04.2017 um 17:17 schrieb Xie, AlexBin:
>>>
>>> Hi David,
>>>
>>>
>>> When amdgpu_bo_reserve return errors, we cannot release the BO. This 
>>> is not a memory leak. General speaking, memory leak is unnoticed and 
>>> unintentional.
>>>
>>>
>>> The caller of function amdgpu_vram_scratch_fini ignores the return 
>>> error value...
>>>
>>>
>>> The "memory leak" is not caused by my patch. It is caused because 
>>> reserving BO fails.
>>>
>>>
>>> This patch only aim to make function amdgpu_vram_scratch_fini behave 
>>> correctly.
>>>
>>>
>>> To follow up, we can add a warning message when amdgpu_bo_reserve 
>>> error happens in a different patch.
>>>
>>>
>>> If function call amdgpu_bo_reserve is changed to uninterruptible, 
>>> this changes driver behaviour. Without a substantial issue, I would 
>>> be cautious for such a change.
>>>
>>>
>>> Thanks,
>>>
>>> Alex Bin Xie
>>>
>>>
>>> ------------------------------------------------------------------------
>>> *From:* Zhou, David(ChunMing)
>>> *Sent:* Monday, April 17, 2017 10:38 PM
>>> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>>
>>>
>>> On 2017年04月17日 22:54, Xie, AlexBin wrote:
>>>>
>>>> Hi David,
>>>>
>>>>
>>>> Thanks for the comments. However, please have look at 
>>>> amdgpu_bo_reserve definition.
>>>>
>>>> static inline int amdgpu_bo_reserve(struct amdgpu_bo *bo, bool no_intr)
>>>>
>>> Ah, this is a wired wrapper for ttm_bo_reserve.
>>>
>>>>
>>>> When we call this function like the following:
>>>>
>>>>          r = amdgpu_bo_reserve(adev->vram_scratch.robj, false);
>>>> The false means interruptible.
>>>>
>>>>
>>>> On the other hand,  when amdgpu_bo_reserve function return error, 
>>>> why do we unref BO without kunmap and unpin the BO? This is wrong 
>>>> implementation when amdgpu_bo_reserve return any error.
>>>>
>>> Yeah, I see your mean, it's in driver un-loading, How about changing 
>>> to no interruptible? Your patch will make a memleak if bo_reserve 
>>> fails, but it seems not matter. I have no strong preference.
>>>
>>> Regards,
>>> David Zhou
>>>>
>>>>
>>>> Thanks,
>>>> Alex Bin Xie
>>>>
>>>> ------------------------------------------------------------------------
>>>> *From:* Zhou, David(ChunMing)
>>>> *Sent:* Friday, April 14, 2017 12:00 AM
>>>> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>>>
>>>>
>>>> On 2017年04月14日 05:34, Alex Xie wrote:
>>>> > According to comment of amdgpu_bo_reserve, amdgpu_bo_reserve
>>>> > can return with -ERESTARTSYS. When this function was interrupted
>>>> > by a signal, BO should not be unref. Otherwise the BO might be
>>>> > released while is kmapped and pinned, or BO MIGHT be deref
>>>> > multiple times, etc.
>>>>          r = amdgpu_bo_reserve(adev->vram_scratch.robj, false);
>>>> we have specified interruptible to false, so -ERESTARTSYS isn't 
>>>> possible
>>>> here.
>>>>
>>>> Thanks,
>>>> David Zhou
>>>> >
>>>> > Change-Id: If76071a768950a0d3ad9d5da7fcae04881807621
>>>> > Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
>>>> > ---
>>>> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>>>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>>>> >
>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> > index 53996e3..1dcc2d1 100644
>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> > @@ -355,8 +355,8 @@ static void amdgpu_vram_scratch_fini(struct 
>>>> amdgpu_device *adev)
>>>> > amdgpu_bo_kunmap(adev->vram_scratch.robj);
>>>> > amdgpu_bo_unpin(adev->vram_scratch.robj);
>>>> > amdgpu_bo_unreserve(adev->vram_scratch.robj);
>>>> > + amdgpu_bo_unref(&adev->vram_scratch.robj);
>>>> >        }
>>>> > - amdgpu_bo_unref(&adev->vram_scratch.robj);
>>>> >   }
>>>> >
>>>> >   /**
>>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------1904C71AAD85342BB38903B8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">Without correctly kunmap, page table
        is corrupted. Page entries point to wrong memory locations. You
        might call it completely harmless. But I think this is a severe
        bug. Leaking memory is better than a corrupted page table. Think
        security.</blockquote>
      We are talking about the page tables for the vmalloc area in the
      kernel here, so no security problem. Leaking memory is much more
      problematic.<br>
      <br>
      <blockquote type="cite">
        <p>Would you provide any document and reference by saying"<span
            style="font-family: Calibri, Arial, Helvetica, sans-serif,
            EmojiFont, 'Apple Color Emoji', 'Segoe UI Emoji',
            NotoColorEmoji, 'Segoe UI Symbol', 'Android Emoji',
            EmojiSymbols; font-size: 16px;"> It is impossible to receive
            a signal during module load/unload"? For example, if the
            unload stuck in a lock, can CTRL+C stop the unload?</span></p>
      </blockquote>
      No, CTRL+C doesn't abort module load/unload. There have been
      patches to changes this a while ago, but IIRC it broke a whole
      bunch of driver relying on this.<br>
      <br>
      <blockquote type="cite">
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;">What about there is some other
            return error? What about in future somebody improve <span
              style="font-family: Calibri, Arial, Helvetica, sans-serif;
              font-size: 16px;">amdgpu_bo_reserve to return other
              errors, then function <span>amdgpu_vram_scratch_fini</span>
              becomes buggy?</span></span></p>
      </blockquote>
      Yes, that is indeed an issue. For example -EDEADLK is possible as
      well. That's why I said we should use amdgpu_bo_free_kernel()
      instead.<br>
      <br>
      <blockquote type="cite">
        <p>While I am thinking whether there is a better way for the
          current situation, would you give a real world example that my
          patch really not working? Then we can address it.</p>
      </blockquote>
      I don't think there is because the driver can't receive a signal
      during load/unload, but the problem is rather that the patch
      doesn't improve the situation at all.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 19.04.2017 um 13:37 schrieb Xie, AlexBin:<br>
    </div>
    <blockquote
cite="mid:MWHPR1201MB0045EC51F6CE7C6C4283888CF2180-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>Hi Christian,</p>
        <p><br>
        </p>
        <p>Without correctly kunmap, page table is corrupted. Page
          entries point to wrong memory locations. You might call it
          completely harmless. But I think this is a severe bug. Leaking
          memory is better than a corrupted page table. Think security.</p>
        <p><br>
        </p>
        <p>Would you provide any document and reference by saying"<span
            style="font-family: Calibri, Arial, Helvetica, sans-serif,
            EmojiFont, 'Apple Color Emoji', 'Segoe UI Emoji',
            NotoColorEmoji, 'Segoe UI Symbol', 'Android Emoji',
            EmojiSymbols; font-size: 16px;"> It is impossible to receive
            a signal during module load/unload"? For example, if the
            unload stuck in a lock, can CTRL+C stop the unload?</span></p>
        <p><span style="font-family: Calibri, Arial, Helvetica,
            sans-serif, EmojiFont, 'Apple Color Emoji', 'Segoe UI
            Emoji', NotoColorEmoji, 'Segoe UI Symbol', 'Android Emoji',
            EmojiSymbols; font-size: 16px;"><br>
          </span></p>
        <p><span style="font-family: Calibri, Arial, Helvetica,
            sans-serif, EmojiFont, 'Apple Color Emoji', 'Segoe UI
            Emoji', NotoColorEmoji, 'Segoe UI Symbol', 'Android Emoji',
            EmojiSymbols; font-size: 16px;">If "<span
              style="font-family: Calibri, Arial, Helvetica, sans-serif,
              EmojiFont, 'Apple Color Emoji', 'Segoe UI Emoji',
              NotoColorEmoji, 'Segoe UI Symbol', 'Android Emoji',
              EmojiSymbols; font-size: 16px;">It is impossible to
              receive a signal during module load/unload", interruptible
              waiting is fine too, because function </span></span><span
            style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;">amdgpu_bo_reserve will return
            successfully.</span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><br>
          </span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;">What about there is some other
            return error? What about in future somebody improve <span
              style="font-family: Calibri, Arial, Helvetica, sans-serif;
              font-size: 16px;">amdgpu_bo_reserve to return other
              errors, then function <span>amdgpu_vram_scratch_fini</span>
              becomes buggy?</span></span></p>
        <p><span style="font-family: Calibri, Arial, Helvetica,
            sans-serif, EmojiFont, 'Apple Color Emoji', 'Segoe UI
            Emoji', NotoColorEmoji, 'Segoe UI Symbol', 'Android Emoji',
            EmojiSymbols; font-size: 16px;"><br>
          </span></p>
        <p>While I am thinking whether there is a better way for the
          current situation, would you give a real world example that my
          patch really not working? Then we can address it.</p>
        <p><br>
        </p>
        <p>Thanks,</p>
        <p>Alex Bin</p>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Wednesday, April 19, 2017 2:35 AM<br>
              <b>To:</b> Xie, AlexBin; Zhou, David(ChunMing);
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix wrongly unref
              of BO</font>
            <div> </div>
          </div>
          <div>
            <div class="moz-cite-prefix">Hi AlexBin,<br>
              <br>
              the answer is ttm_bo_kunmap isn't called at all and yes in
              the case of an iomap we leak the address space reserved.<br>
              <br>
              But that is completely harmless on a 64bit system compared
              to leaking the memory backing the address space.<br>
              <br>
              Using <span style=""><span>amdgpu_bo_free_kernel()
                  instead of openly coding it here is probably a good
                  idea.<br>
                  <br>
                  Additional to that it's probably a good idea to set
                  the no_intr flag when reserving kernel BOs. It is
                  impossible to receive a signal during module
                  load/unload, but it's probably better to document that
                  in the code as well.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                </span></span><br>
              Am 18.04.2017 um 20:54 schrieb Xie, AlexBin:<br>
            </div>
            <blockquote type="cite">
              <style type="text/css" style="display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
              <div id="divtagdefaultwrapper" dir="ltr"
                style="font-size:12pt; color:#000000;
                font-family:Calibri,Arial,Helvetica,sans-serif">
                Hi Christian,
                <div><br>
                </div>
                <div>Have you found how/where/when? When you said "<span
style="font-family:Calibri,Arial,Helvetica,sans-serif; font-size:16px">mapping
                    will just</span><span
                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                    font-size:16px"> be released a bit later on", you
                    must know the answer. </span></div>
                <div><br>
                </div>
                <div>It is difficult to prove something does not exist.
                  Anyway, I will give it a try to prove such "later on"
                  does not exist.</div>
                <div><br>
                </div>
                <div><span>Function ttm_bo_kunmap is the only function
                    to unmap. To prove this, search <span>ttm_bo_map_iomap,
                      only <span style="">ttm_bo_kunmap use this enum to
                        correctly kunmap.</span></span></span><br>
                </div>
                <div><span><span><span style=""><br>
                      </span></span></span></div>
                <div><span><span><span style=""><span>Function ttm_bo_kunmap
                          is not called by ttm itself. This is a hint
                          that all TTM delay delete mechanism or unref
                          mechanism will NOT kunmap BO later on.</span><br>
                      </span></span></span></div>
                <div><span><span><span style=""><span><br>
                        </span></span></span></span></div>
                <div><span><span><span style=""><span><span style="">Function </span><span
                            style="">ttm_bo_kunmap is called by AMDGPU
                            function <span>amdgpu_bo_kunmap and <span>amdgpu_gem_prime_vunmap.</span></span></span><br>
                        </span></span></span></span></div>
                <div><br>
                </div>
                <div>Search AMDGPU for <span style="">amdgpu_bo_kunmap.
                    All matches do not kunmap for scratch VRAM BO.  <span>amdgpu_bo_free_kernel
                      is a suspect but the answer is still NO.</span></span></div>
                <div><span style=""><span><br>
                    </span></span></div>
                <div><span style=""><span>So all possibilities are
                      searched. Did I miss anything?</span></span></div>
                <div><span style=""><span><br>
                    </span></span></div>
                <div>Thanks,</div>
                <div>Alex Bin Xie</div>
                <div><br>
                </div>
              </div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="divRplyFwdMsg" dir="ltr"><font
                  style="font-size:11pt" color="#000000" face="Calibri,
                  sans-serif"><b>From:</b> Xie, AlexBin<br>
                  <b>Sent:</b> Tuesday, April 18, 2017 2:04:33 PM<br>
                  <b>To:</b> Christian König; Zhou, David(ChunMing); <a
                    moz-do-not-send="true"
                    class="moz-txt-link-abbreviated"
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix wrongly
                  unref of BO</font>
                <div> </div>
              </div>
              <div>
                <div id="divtagdefaultwrapper" dir="ltr"
                  style="font-size:12pt; color:#000000;
                  font-family:Calibri,Arial,Helvetica,sans-serif">
                  <p>Hi Christian,</p>
                  <p><br>
                  </p>
                  <p>Would you point out where/when will kunmap happen
                    for this BO when release? <span
                      style="font-size:12pt">It must be somewhere </span><span
                      style="font-size:12pt"></span><span
                      style="font-size:12pt">in some function calls</span><span
                      style="font-size:12pt">.</span></p>
                  <p><span style="font-size:12pt"><br>
                    </span></p>
                  <p><span style="font-size:12pt">I checked before I
                      asked for review. But I did not see such obvious
                      kunmap function call.</span></p>
                  <p><span style="font-size:12pt"><br>
                    </span></p>
                  <p><span style="font-size:12pt">If so, there should
                      be a comment in function <span>amdgpu_vram_scratch_fini </span>to
                      avoid future confusion.</span></p>
                  <br>
                  Thanks,
                  <div>Alex Bin Xie<br>
                    <div style="color:rgb(0,0,0)">
                      <hr tabindex="-1" style="display:inline-block;
                        width:98%">
                      <div id="divRplyFwdMsg" dir="ltr"><font
                          style="font-size:11pt" color="#000000"
                          face="Calibri, sans-serif"><b>From:</b>
                          Christian König
                          <a moz-do-not-send="true"
                            class="moz-txt-link-rfc2396E"
                            href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                          <b>Sent:</b> Tuesday, April 18, 2017 1:46 PM<br>
                          <b>To:</b> Xie, AlexBin; Zhou,
                          David(ChunMing); <a moz-do-not-send="true"
                            class="moz-txt-link-abbreviated"
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                            amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          <b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix
                          wrongly unref of BO</font>
                        <div> </div>
                      </div>
                      <div>
                        <div class="moz-cite-prefix">Hi AlexBin,<br>
                          <br>
                          No, David is right. This is a very common
                          coding pattern in the kernel module.<br>
                          <br>
                          Freeing up a BO while there still exists a
                          kernel mapping is perfectly ok, the mapping
                          will just be released a bit later on.<br>
                          <br>
                          So this code is actually perfectly ok and just
                          an optimization, but your patch breaks it and
                          creates a memory leak.<br>
                          <br>
                          Regards,<br>
                          Christian.<br>
                          <br>
                          Am 18.04.2017 um 17:17 schrieb Xie, AlexBin:<br>
                        </div>
                        <blockquote type="cite">
                          <div id="divtagdefaultwrapper" dir="ltr"
                            style="font-size:12pt; color:#000000;
                            font-family:Calibri,Arial,Helvetica,sans-serif">
                            <p>Hi David,</p>
                            <p><br>
                            </p>
                            <p>When <span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif">amdgpu_bo_reserve
                                return errors, we cannot release the BO.
                                This is not a memory leak. General
                                speaking, memory leak is unnoticed and
                                unintentional.</span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><br>
                              </span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif">The
                                caller of function <span>amdgpu_vram_scratch_fini
                                  ignores the return error value...</span></span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><span><br>
                                </span></span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><span>The
                                  "memory leak" is not caused by my
                                  patch. It is caused because reserving
                                  BO fails.</span></span></p>
                            <p><span
                                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                font-size:12pt"><br>
                              </span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><span></span></span><span
style="font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12pt">This patch
                                only aim to make function </span><span
                                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                font-size:12pt">amdgpu_vram_scratch_fini
                                behave correctly.</span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><span><br>
                                </span></span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><span>To
                                  follow up, we can add a warning
                                  message when
                                  <span
                                    style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                    font-size:16px">amdgpu_bo_reserve</span>
                                  error happens in a different patch.</span></span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><span><br>
                                </span></span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif">If
                                function call </span><span
                                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                                font-size:12pt">amdgpu_bo_reserve is
                                changed to uninterruptible, this
                                changes driver behaviour. Without a
                                substantial issue, I would be cautious
                                for such a change.</span></p>
                            <p><span style="font-size:12pt;
                                font-family:Calibri,Arial,Helvetica,sans-serif"><br>
                              </span></p>
                            <p>Thanks,</p>
                            <p>Alex Bin Xie</p>
                            <br>
                            <div style="color:rgb(0,0,0)">
                              <hr tabindex="-1"
                                style="display:inline-block; width:98%">
                              <div id="divRplyFwdMsg" dir="ltr"><font
                                  style="font-size:11pt" color="#000000"
                                  face="Calibri, sans-serif"><b>From:</b>
                                  Zhou, David(ChunMing)<br>
                                  <b>Sent:</b> Monday, April 17, 2017
                                  10:38 PM<br>
                                  <b>To:</b> Xie, AlexBin; <a
                                    moz-do-not-send="true"
                                    class="moz-txt-link-abbreviated"
                                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                  <b>Subject:</b> Re: [PATCH]
                                  dmr/amdgpu: Fix wrongly unref of BO</font>
                                <div> </div>
                              </div>
                              <div><br>
                                <br>
                                <div class="moz-cite-prefix">On
                                  2017年04月17日 22:54, Xie, AlexBin wrote:<br>
                                </div>
                                <blockquote type="cite">
                                  <div id="divtagdefaultwrapper"
                                    dir="ltr" style="font-size:12pt;
                                    color:#000000;
                                    font-family:Calibri,Arial,Helvetica,sans-serif">
                                    <p>Hi David,</p>
                                    <p><br>
                                    </p>
                                    <p>Thanks for the comments. However,
                                      please have look at <span
                                        style="">amdgpu_bo_reserve</span>
                                      definition.</p>
                                    <p><span>static inline int
                                        amdgpu_bo_reserve(struct
                                        amdgpu_bo *bo, bool no_intr)</span><br>
                                    </p>
                                  </div>
                                </blockquote>
                                Ah, this is a wired wrapper for
                                ttm_bo_reserve.<br>
                                <br>
                                <blockquote type="cite">
                                  <div id="divtagdefaultwrapper"
                                    dir="ltr" style="font-size:12pt;
                                    color:#000000;
                                    font-family:Calibri,Arial,Helvetica,sans-serif">
                                    <p><span><br>
                                      </span></p>
                                    <p><span>When we call this function
                                        like the following:</span></p>
                                    <p><span><span style="">         r =
amdgpu_bo_reserve(adev-&gt;vram_scratch.robj, false);</span><br style="">
                                      </span><span
                                        style="font-size:12pt">The false
                                        means <span>interruptible</span>.</span><span><br>
                                      </span></p>
                                    <p><span style="font-size:12pt"><br>
                                      </span></p>
                                    <p><span style="font-size:12pt">On
                                        the other hand,  when <span
                                          style="">amdgpu_bo_reserve
                                          function return error, why do
                                          we unref BO without kunmap and
                                          unpin the BO? This is wrong
                                          implementation when <span
                                            style="">amdgpu_bo_reserve
                                            return any error.</span></span></span></p>
                                  </div>
                                </blockquote>
                                Yeah, I see your mean, it's in driver
                                un-loading, How about changing to no
                                interruptible? Your patch will make a
                                memleak if bo_reserve fails, but it
                                seems not matter. I have no strong
                                preference.<br>
                                <br>
                                Regards,<br>
                                David Zhou<br>
                                <blockquote type="cite">
                                  <div id="divtagdefaultwrapper"
                                    dir="ltr" style="font-size:12pt;
                                    color:#000000;
                                    font-family:Calibri,Arial,Helvetica,sans-serif">
                                    <p><br>
                                    </p>
                                    Thanks,
                                    <div>Alex Bin Xie<br>
                                      <br>
                                      <div style="color:rgb(0,0,0)">
                                        <div>
                                          <hr tabindex="-1"
                                            style="display:inline-block;
                                            width:98%">
                                          <div id="x_divRplyFwdMsg"
                                            dir="ltr"><font
                                              style="font-size:11pt"
                                              color="#000000"
                                              face="Calibri, sans-serif"><b>From:</b>
                                              Zhou, David(ChunMing)<br>
                                              <b>Sent:</b> Friday, April
                                              14, 2017 12:00 AM<br>
                                              <b>To:</b> Xie, AlexBin; <a
                                                moz-do-not-send="true"
                                                class="moz-txt-link-abbreviated"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                              <b>Subject:</b> Re:
                                              [PATCH] dmr/amdgpu: Fix
                                              wrongly unref of BO</font>
                                            <div> </div>
                                          </div>
                                        </div>
                                        <font size="2"><span
                                            style="font-size:10pt">
                                            <div class="PlainText"><br>
                                              <br>
                                              On 2017年04月14日 05:34, Alex
                                              Xie wrote:<br>
                                              &gt; According to comment
                                              of amdgpu_bo_reserve,
                                              amdgpu_bo_reserve<br>
                                              &gt; can return with
                                              -ERESTARTSYS. When this
                                              function was interrupted<br>
                                              &gt; by a signal, BO
                                              should not be unref.
                                              Otherwise the BO might be<br>
                                              &gt; released while is
                                              kmapped and pinned, or BO
                                              MIGHT be deref<br>
                                              &gt; multiple times, etc.<br>
                                                       r =
                                              amdgpu_bo_reserve(adev-&gt;vram_scratch.robj,
                                              false);<br>
                                              we have specified
                                              interruptible to false, so
                                              -ERESTARTSYS isn't
                                              possible <br>
                                              here.<br>
                                              <br>
                                              Thanks,<br>
                                              David Zhou<br>
                                              &gt;<br>
                                              &gt; Change-Id:
                                              If76071a768950a0d3ad9d5da7fcae04881807621<br>
                                              &gt; Signed-off-by: Alex
                                              Xie <a
                                                moz-do-not-send="true"
                                                class="moz-txt-link-rfc2396E"
href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">
&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                                              &gt; ---<br>
                                              &gt;  
                                              drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                                              | 2 +-<br>
                                              &gt;   1 file changed, 1
                                              insertion(+), 1
                                              deletion(-)<br>
                                              &gt;<br>
                                              &gt; diff --git
                                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                              &gt; index
                                              53996e3..1dcc2d1 100644<br>
                                              &gt; ---
                                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                              &gt; +++
                                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                                              &gt; @@ -355,8 +355,8 @@
                                              static void
                                              amdgpu_vram_scratch_fini(struct
                                              amdgpu_device *adev)<br>
                                              &gt;               
                                              amdgpu_bo_kunmap(adev-&gt;vram_scratch.robj);<br>
                                              &gt;               
                                              amdgpu_bo_unpin(adev-&gt;vram_scratch.robj);<br>
                                              &gt;               
                                              amdgpu_bo_unreserve(adev-&gt;vram_scratch.robj);<br>
                                              &gt; +            
                                              amdgpu_bo_unref(&amp;adev-&gt;vram_scratch.robj);<br>
                                              &gt;        }<br>
                                              &gt; -    
                                              amdgpu_bo_unref(&amp;adev-&gt;vram_scratch.robj);<br>
                                              &gt;   }<br>
                                              &gt;   <br>
                                              &gt;   /**<br>
                                              <br>
                                            </div>
                                          </span></font></div>
                                    </div>
                                  </div>
                                </blockquote>
                                <br>
                              </div>
                            </div>
                          </div>
                          <br>
                          <fieldset class="mimeAttachmentHeader"></fieldset>
                          <br>
                          <pre>_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                        </blockquote>
                        <p><br>
                        </p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <br>
              <fieldset class="mimeAttachmentHeader"></fieldset>
              <br>
              <pre>_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <p><br>
            </p>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------1904C71AAD85342BB38903B8--

--===============0738142098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0738142098==--
