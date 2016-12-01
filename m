From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: libdrm amdgpu semaphores questions
Date: Thu, 1 Dec 2016 10:53:42 +0100
Message-ID: <b660e477-5de5-9b78-abbc-0e840720dac3@vodafone.de>
References: <CAPM=9twrphvnNx99H4r3ROaNaKMKj7uwuii_1Ph57Vv7Z-aFSg@mail.gmail.com>
 <420B93AA-EBE2-4DB4-B0D0-AE574AEFA22B@amd.com> <583FB287.5050602@amd.com>
 <CAPM=9tz2Qv0DXp-Tpfb38b81G1Gbs0MyM4KvUcvj5m+sp3dhoQ@mail.gmail.com>
 <583FBF14.8000506@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808509529=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <583FBF14.8000506-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1808509529==
Content-Type: multipart/alternative;
 boundary="------------440E0595BF073A8589DEC539"

This is a multi-part message in MIME format.
--------------440E0595BF073A8589DEC539
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

the problem with that approach is that it duplicates the effort done 
with android fences but moves some of the logic found in there into the 
kernel.

E.g. you could do the same with in/out fences on command submission, 
just not share the handle itself with other process before it is 
signaled (which is actually desirable).

Regards,
Christian.

Am 01.12.2016 um 07:11 schrieb zhoucm1:
> Hi Dave,
>
> As the attached, our Vulkan team is verifying it.
>
> Thanks,
> David Zhou
>
> On 2016年12月01日 13:44, Dave Airlie wrote:
>>
>> On 1 Dec. 2016 15:22, "zhoucm1" <david1.zhou-5C7GfCeVMHo@public.gmane.org 
>> <mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org>> wrote:
>> >
>> > Yes, the old implementation which is already in upstream libdrm is 
>> out of data, there isn't other user, so we want to drop it when new 
>> semaphore is verified OK.
>>
>> Could you post some patches for the new one? Otherwise I'll have to 
>> write one for radv.
>>
>> Dave.
>> >
>> > Thanks,
>> > David Zhou
>> >
>> >
>> > On 2016年12月01日 10:36, Mao, David wrote:
>> >>
>> >> Hi Dave,
>> >> i believe your first attempt is correct.
>> >> The export/import semaphore needs refine of the semaphore 
>> implementation.
>> >> We are working on that.
>> >>
>> >> Thanks.
>> >> Best Regards,
>> >> David
>> >>>
>> >>> On 1 Dec 2016, at 10:12 AM, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
>> <mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>> >>>
>> >>> Hey all,
>> >>>
>> >>> So I've started adding semaphore support to radv but I'm not really
>> >>> sure what the API to the semaphore code is.
>> >>>
>> >>> the Vulkan API is you get a command submission of a number of submit
>> >>> units which have a 0-n wait semaphore, 0-n command buffers and 0-n
>> >>> signal semaphores.
>> >>>
>> >>> Now I'm not sure how I should use the APIs with those.
>> >>>
>> >>> My first attempt is
>> >>>
>> >>> call amdgpu_cs_wait_semaphore on all the wait ones, call the cs 
>> submit
>> >>> API, then call the amdgpu_cs_signal_semaphore on all the signal ones?
>> >>>
>> >>> or should I be up front calling wait/signal then submitting the 
>> command streams?
>> >>>
>> >>> Also upcoming work requires possibly sharing semaphores between
>> >>> processes, is there any indication how this might be made work with
>> >>> the libdrm_amdgpu semaphore implementation?
>> >>>
>> >>> Thanks,
>> >>> Dave.
>> >>> _______________________________________________
>> >>> amd-gfx mailing list
>> >>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> >>
>> >> _______________________________________________
>> >> amd-gfx mailing list
>> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> >
>> >
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------440E0595BF073A8589DEC539
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Dave,<br>
      <br>
      the problem with that approach is that it duplicates the effort
      done with android fences but moves some of the logic found in
      there into the kernel.<br>
      <br>
      E.g. you could do the same with in/out fences on command
      submission, just not share the handle itself with other process
      before it is signaled (which is actually desirable). <br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 01.12.2016 um 07:11 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:583FBF14.8000506-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      Hi Dave,<br>
      <br>
      As the attached, our Vulkan team is verifying it.<br>
      <br>
      Thanks,<br>
      David Zhou<br>
      <br>
      <div class="moz-cite-prefix">On 2016年12月01日 13:44, Dave Airlie
        wrote:<br>
      </div>
      <blockquote
cite="mid:CAPM=9tz2Qv0DXp-Tpfb38b81G1Gbs0MyM4KvUcvj5m+sp3dhoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
        type="cite">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <p dir="ltr">On 1 Dec. 2016 15:22, "zhoucm1" &lt;<a
            moz-do-not-send="true" href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org">david1.zhou-5C7GfCeVMHo@public.gmane.org</a>&gt;
          wrote:<br>
          &gt;<br>
          &gt; Yes, the old implementation which is already in upstream
          libdrm is out of data, there isn't other user, so we want to
          drop it when new semaphore is verified OK.</p>
        <p dir="ltr">Could you post some patches for the new one?
          Otherwise I'll have to write one for radv.</p>
        <p dir="ltr">Dave.<br>
          &gt;<br>
          &gt; Thanks,<br>
          &gt; David Zhou<br>
          &gt;<br>
          &gt;<br>
          &gt; On 2016年12月01日 10:36, Mao, David wrote:<br>
          &gt;&gt;<br>
          &gt;&gt; Hi Dave,<br>
          &gt;&gt; i believe your first attempt is correct.<br>
          &gt;&gt; The export/import semaphore needs refine of the
          semaphore implementation.<br>
          &gt;&gt; We are working on that.<br>
          &gt;&gt;<br>
          &gt;&gt; Thanks.<br>
          &gt;&gt; Best Regards,<br>
          &gt;&gt; David<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; On 1 Dec 2016, at 10:12 AM, Dave Airlie &lt;<a
            moz-do-not-send="true" href="mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
          wrote:<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; Hey all,<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; So I've started adding semaphore support to radv
          but I'm not really<br>
          &gt;&gt;&gt; sure what the API to the semaphore code is.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; the Vulkan API is you get a command submission of
          a number of submit<br>
          &gt;&gt;&gt; units which have a 0-n wait semaphore, 0-n
          command buffers and 0-n<br>
          &gt;&gt;&gt; signal semaphores.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; Now I'm not sure how I should use the APIs with
          those.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; My first attempt is<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; call amdgpu_cs_wait_semaphore on all the wait
          ones, call the cs submit<br>
          &gt;&gt;&gt; API, then call the amdgpu_cs_signal_semaphore on
          all the signal ones?<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; or should I be up front calling wait/signal then
          submitting the command streams?<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; Also upcoming work requires possibly sharing
          semaphores between<br>
          &gt;&gt;&gt; processes, is there any indication how this might
          be made work with<br>
          &gt;&gt;&gt; the libdrm_amdgpu semaphore implementation?<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; Thanks,<br>
          &gt;&gt;&gt; Dave.<br>
          &gt;&gt;&gt; _______________________________________________<br>
          &gt;&gt;&gt; amd-gfx mailing list<br>
          &gt;&gt;&gt; <a moz-do-not-send="true"
            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          &gt;&gt;&gt; <a moz-do-not-send="true"
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          &gt;&gt;<br>
          &gt;&gt; _______________________________________________<br>
          &gt;&gt; amd-gfx mailing list<br>
          &gt;&gt; <a moz-do-not-send="true"
            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          &gt;&gt; <a moz-do-not-send="true"
            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          &gt;<br>
          &gt;</p>
      </blockquote>
      <br>
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

--------------440E0595BF073A8589DEC539--

--===============1808509529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1808509529==--
