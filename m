From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
Date: Tue, 18 Apr 2017 19:46:30 +0200
Message-ID: <7807726d-7318-b72f-1a14-2b37a73988bf@vodafone.de>
References: <1492119298-8526-1-git-send-email-AlexBin.Xie@amd.com>
 <58F0495D.60607@amd.com>
 <MWHPR1201MB0045DE55E81D0FF5CE76671FF2060@MWHPR1201MB0045.namprd12.prod.outlook.com>
 <58F57C14.20403@amd.com>
 <MWHPR1201MB00452889FF2C7FDC55630B4BF2190@MWHPR1201MB0045.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0045821482=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB00452889FF2C7FDC55630B4BF2190-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
--===============0045821482==
Content-Type: multipart/alternative;
 boundary="------------E8298088F81D3945B506DFA4"

This is a multi-part message in MIME format.
--------------E8298088F81D3945B506DFA4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi AlexBin,

No, David is right. This is a very common coding pattern in the kernel 
module.

Freeing up a BO while there still exists a kernel mapping is perfectly 
ok, the mapping will just be released a bit later on.

So this code is actually perfectly ok and just an optimization, but your 
patch breaks it and creates a memory leak.

Regards,
Christian.

Am 18.04.2017 um 17:17 schrieb Xie, AlexBin:
>
> Hi David,
>
>
> When amdgpu_bo_reserve return errors, we cannot release the BO. This 
> is not a memory leak. General speaking, memory leak is unnoticed and 
> unintentional.
>
>
> The caller of function amdgpu_vram_scratch_fini ignores the return 
> error value...
>
>
> The "memory leak" is not caused by my patch. It is caused because 
> reserving BO fails.
>
>
> This patch only aim to make function amdgpu_vram_scratch_fini behave 
> correctly.
>
>
> To follow up, we can add a warning message when amdgpu_bo_reserve 
> error happens in a different patch.
>
>
> If function call amdgpu_bo_reserve is changed to uninterruptible, this 
> changes driver behaviour. Without a substantial issue, I would be 
> cautious for such a change.
>
>
> Thanks,
>
> Alex Bin Xie
>
>
> ------------------------------------------------------------------------
> *From:* Zhou, David(ChunMing)
> *Sent:* Monday, April 17, 2017 10:38 PM
> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>
>
> On 2017年04月17日 22:54, Xie, AlexBin wrote:
>>
>> Hi David,
>>
>>
>> Thanks for the comments. However, please have look at 
>> amdgpu_bo_reserve definition.
>>
>> static inline int amdgpu_bo_reserve(struct amdgpu_bo *bo, bool no_intr)
>>
> Ah, this is a wired wrapper for ttm_bo_reserve.
>
>>
>> When we call this function like the following:
>>
>>          r = amdgpu_bo_reserve(adev->vram_scratch.robj, false);
>> The false means interruptible.
>>
>>
>> On the other hand,  when amdgpu_bo_reserve function return error, why 
>> do we unref BO without kunmap and unpin the BO? This is wrong 
>> implementation when amdgpu_bo_reserve return any error.
>>
> Yeah, I see your mean, it's in driver un-loading, How about changing 
> to no interruptible? Your patch will make a memleak if bo_reserve 
> fails, but it seems not matter. I have no strong preference.
>
> Regards,
> David Zhou
>>
>>
>> Thanks,
>> Alex Bin Xie
>>
>> ------------------------------------------------------------------------
>> *From:* Zhou, David(ChunMing)
>> *Sent:* Friday, April 14, 2017 12:00 AM
>> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Subject:* Re: [PATCH] dmr/amdgpu: Fix wrongly unref of BO
>>
>>
>> On 2017年04月14日 05:34, Alex Xie wrote:
>> > According to comment of amdgpu_bo_reserve, amdgpu_bo_reserve
>> > can return with -ERESTARTSYS. When this function was interrupted
>> > by a signal, BO should not be unref. Otherwise the BO might be
>> > released while is kmapped and pinned, or BO MIGHT be deref
>> > multiple times, etc.
>>          r = amdgpu_bo_reserve(adev->vram_scratch.robj, false);
>> we have specified interruptible to false, so -ERESTARTSYS isn't possible
>> here.
>>
>> Thanks,
>> David Zhou
>> >
>> > Change-Id: If76071a768950a0d3ad9d5da7fcae04881807621
>> > Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
>> > ---
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > index 53996e3..1dcc2d1 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > @@ -355,8 +355,8 @@ static void amdgpu_vram_scratch_fini(struct 
>> amdgpu_device *adev)
>> > amdgpu_bo_kunmap(adev->vram_scratch.robj);
>> > amdgpu_bo_unpin(adev->vram_scratch.robj);
>> > amdgpu_bo_unreserve(adev->vram_scratch.robj);
>> > + amdgpu_bo_unref(&adev->vram_scratch.robj);
>> >        }
>> > - amdgpu_bo_unref(&adev->vram_scratch.robj);
>> >   }
>> >
>> >   /**
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------E8298088F81D3945B506DFA4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi AlexBin,<br>
      <br>
      No, David is right. This is a very common coding pattern in the
      kernel module.<br>
      <br>
      Freeing up a BO while there still exists a kernel mapping is
      perfectly ok, the mapping will just be released a bit later on.<br>
      <br>
      So this code is actually perfectly ok and just an optimization,
      but your patch breaks it and creates a memory leak.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 18.04.2017 um 17:17 schrieb Xie, AlexBin:<br>
    </div>
    <blockquote
cite="mid:MWHPR1201MB00452889FF2C7FDC55630B4BF2190-3iK1xFAIwjq45V35fqe+hGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>Hi David,</p>
        <p><br>
        </p>
        <p>When <span style="font-size: 12pt; font-family: Calibri,
            Arial, Helvetica, sans-serif;">amdgpu_bo_reserve return
            errors, we cannot release the BO. This is not a memory leak.
            General speaking, memory leak is unnoticed and
            unintentional.</span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><br>
          </span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;">The caller of function <span>amdgpu_vram_scratch_fini
              ignores the return error value...</span></span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><span><br>
            </span></span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><span>The "memory leak" is not
              caused by my patch. It is caused because reserving BO
              fails.</span></span></p>
        <p><span style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt;"><br>
          </span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><span></span></span><span
            style="font-family: Calibri, Arial, Helvetica, sans-serif;
            font-size: 12pt;">This patch only aim to make function </span><span
            style="font-family: Calibri, Arial, Helvetica, sans-serif;
            font-size: 12pt;">amdgpu_vram_scratch_fini behave correctly.</span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><span><br>
            </span></span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><span>To follow up, we can add a
              warning message when
              <span style="font-family: Calibri, Arial, Helvetica,
                sans-serif; font-size: 16px;">
                amdgpu_bo_reserve</span> error happens in a different
              patch.</span></span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><span><br>
            </span></span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;">If function call </span><span
            style="font-family: Calibri, Arial, Helvetica, sans-serif;
            font-size: 12pt;">amdgpu_bo_reserve is changed to
            uninterruptible, this changes driver behaviour. Without a
            substantial issue, I would be cautious for such a change.</span></p>
        <p><span style="font-size: 12pt; font-family: Calibri, Arial,
            Helvetica, sans-serif;"><br>
          </span></p>
        <p>Thanks,</p>
        <p>Alex Bin Xie</p>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              Zhou, David(ChunMing)<br>
              <b>Sent:</b> Monday, April 17, 2017 10:38 PM<br>
              <b>To:</b> Xie, AlexBin; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix wrongly unref
              of BO</font>
            <div> </div>
          </div>
          <div><br>
            <br>
            <div class="moz-cite-prefix">On 2017年04月17日 22:54, Xie,
              AlexBin wrote:<br>
            </div>
            <blockquote type="cite">
              <div id="divtagdefaultwrapper" dir="ltr"
                style="font-size:12pt; color:#000000;
                font-family:Calibri,Arial,Helvetica,sans-serif">
                <p>Hi David,</p>
                <p><br>
                </p>
                <p>Thanks for the comments. However, please have look at
                  <span style="">amdgpu_bo_reserve</span> definition.</p>
                <p><span>static inline int amdgpu_bo_reserve(struct
                    amdgpu_bo *bo, bool no_intr)</span><br>
                </p>
              </div>
            </blockquote>
            Ah, this is a wired wrapper for ttm_bo_reserve.<br>
            <br>
            <blockquote type="cite">
              <div id="divtagdefaultwrapper" dir="ltr"
                style="font-size:12pt; color:#000000;
                font-family:Calibri,Arial,Helvetica,sans-serif">
                <p><span><br>
                  </span></p>
                <p><span>When we call this function like the following:</span></p>
                <p><span><span style="">         r =
                      amdgpu_bo_reserve(adev-&gt;vram_scratch.robj,
                      false);</span><br style="">
                  </span><span style="font-size:12pt">The false means <span>interruptible</span>.</span><span><br>
                  </span></p>
                <p><span style="font-size:12pt"><br>
                  </span></p>
                <p><span style="font-size:12pt">On the other hand,
                     when <span style="">amdgpu_bo_reserve function
                      return error, why do we unref BO without kunmap
                      and unpin the BO? This is wrong
                      implementation when <span style="">amdgpu_bo_reserve
                        return any error.</span></span></span></p>
              </div>
            </blockquote>
            Yeah, I see your mean, it's in driver un-loading, How about
            changing to no interruptible? Your patch will make a memleak
            if bo_reserve fails, but it seems not matter. I have no
            strong preference.<br>
            <br>
            Regards,<br>
            David Zhou<br>
            <blockquote type="cite">
              <div id="divtagdefaultwrapper" dir="ltr"
                style="font-size:12pt; color:#000000;
                font-family:Calibri,Arial,Helvetica,sans-serif">
                <p><br>
                </p>
                Thanks,
                <div>Alex Bin Xie<br>
                  <br>
                  <div style="color:rgb(0,0,0)">
                    <div>
                      <hr tabindex="-1" style="display:inline-block;
                        width:98%">
                      <div id="x_divRplyFwdMsg" dir="ltr"><font
                          style="font-size:11pt" color="#000000"
                          face="Calibri, sans-serif"><b>From:</b> Zhou,
                          David(ChunMing)<br>
                          <b>Sent:</b> Friday, April 14, 2017 12:00 AM<br>
                          <b>To:</b> Xie, AlexBin; <a
                            moz-do-not-send="true"
                            class="moz-txt-link-abbreviated"
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                            amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          <b>Subject:</b> Re: [PATCH] dmr/amdgpu: Fix
                          wrongly unref of BO</font>
                        <div> </div>
                      </div>
                    </div>
                    <font size="2"><span style="font-size:10pt">
                        <div class="PlainText"><br>
                          <br>
                          On 2017年04月14日 05:34, Alex Xie wrote:<br>
                          &gt; According to comment of
                          amdgpu_bo_reserve, amdgpu_bo_reserve<br>
                          &gt; can return with -ERESTARTSYS. When this
                          function was interrupted<br>
                          &gt; by a signal, BO should not be unref.
                          Otherwise the BO might be<br>
                          &gt; released while is kmapped and pinned, or
                          BO MIGHT be deref<br>
                          &gt; multiple times, etc.<br>
                                   r =
                          amdgpu_bo_reserve(adev-&gt;vram_scratch.robj,
                          false);<br>
                          we have specified interruptible to false, so
                          -ERESTARTSYS isn't possible <br>
                          here.<br>
                          <br>
                          Thanks,<br>
                          David Zhou<br>
                          &gt;<br>
                          &gt; Change-Id:
                          If76071a768950a0d3ad9d5da7fcae04881807621<br>
                          &gt; Signed-off-by: Alex Xie <a
                            moz-do-not-send="true"
                            class="moz-txt-link-rfc2396E"
                            href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">
                            &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                          &gt; ---<br>
                          &gt;  
                          drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2
                          +-<br>
                          &gt;   1 file changed, 1 insertion(+), 1
                          deletion(-)<br>
                          &gt;<br>
                          &gt; diff --git
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt; index 53996e3..1dcc2d1 100644<br>
                          &gt; ---
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt; +++
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt; @@ -355,8 +355,8 @@ static void
                          amdgpu_vram_scratch_fini(struct amdgpu_device
                          *adev)<br>
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

--------------E8298088F81D3945B506DFA4--

--===============0045821482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0045821482==--
