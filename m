From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Support for amdgpu VM update via CPU on large-bar systems
Date: Fri, 12 May 2017 10:43:49 +0200
Message-ID: <b82fc6cd-c19e-85c2-8628-89c2cb10c5c0@vodafone.de>
References: <DM3PR1201MB10382F282D646D630708246D8CEF0@DM3PR1201MB1038.namprd12.prod.outlook.com>
 <5915717A.3000209@amd.com> <21e206ed-8d60-450f-6d23-e01c68c5ad73@vodafone.de>
 <59157453.8010308@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2125191007=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <59157453.8010308-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "Kasiviswanathan, Harish" <Harish.Kasiviswanathan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============2125191007==
Content-Type: multipart/alternative;
 boundary="------------0A731E567473D46C6B723FBD"

This is a multi-part message in MIME format.
--------------0A731E567473D46C6B723FBD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.05.2017 um 10:37 schrieb zhoucm1:
>
>
> On 2017年05月12日 16:33, Christian König wrote:
>> Am 12.05.2017 um 10:25 schrieb zhoucm1:
>>>
>>> On 2017年05月10日 05:47, Kasiviswanathan, Harish wrote:
>>>> Hi,
>>>>
>>>> Please review the patch set that supports amdgpu VM update via CPU. This feature provides improved performance for compute (HSA) where mapping / unmapping is carried out (by Kernel) independent of command submissions (done directly by user space). This version doesn't support shadow copy of VM page tables for CPU based update.
>>> I think your improved performance is from less waiting for cs, 
>>> generally, SDMA engine updating page table is faster than CPU, 
>>> otherwise we don't need sdma for updating PT.
>>> So whether your this improvement proves we have some redundant sync 
>>> when mapping / unmapping, if yes, we should fix that, then not sure 
>>> if CPU method is need or not.
>>
>> The problem is that the KFD is designed synchronously for page table 
>> updates. In other words they need to wait for the update to finish 
>> and that takes time.
>>
>> Apart from that your comment is absolutely correct, we found that the 
>> SDMA is sometimes much faster to do the update than the CPU.
> If the sdma is faster, even they wait for finish, which time is 
> shorter than CPU, isn't it? Of course, the precondition is sdma is 
> exclusive. They can reserve a sdma for PT updating.

No, if I understood Felix numbers correctly the setup and wait time for 
SDMA is a bit (but not much) longer than doing it with the CPU.

What would really help is to fix the KFD design and work with async page 
tables updates there as well.

Regards,
Christian.

>
> Regards,
> David Zhou
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>> David Zhou
>>>> Best Regards,
>>>> Harish
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------0A731E567473D46C6B723FBD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 12.05.2017 um 10:37 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:59157453.8010308-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <br>
      <br>
      <div class="moz-cite-prefix">On 2017年05月12日 16:33, Christian König
        wrote:<br>
      </div>
      <blockquote
        cite="mid:21e206ed-8d60-450f-6d23-e01c68c5ad73-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <div class="moz-cite-prefix">Am 12.05.2017 um 10:25 schrieb
          zhoucm1:<br>
        </div>
        <blockquote cite="mid:5915717A.3000209-5C7GfCeVMHo@public.gmane.org" type="cite"> <br>
          <div class="moz-cite-prefix">On 2017年05月10日 05:47,
            Kasiviswanathan, Harish wrote:<br>
          </div>
          <blockquote
cite="mid:DM3PR1201MB10382F282D646D630708246D8CEF0-BBcFnVpqZhWjUUTFdQAMQmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
            type="cite">
            <pre wrap="">Hi,

Please review the patch set that supports amdgpu VM update via CPU. This feature provides improved performance for compute (HSA) where mapping / unmapping is carried out (by Kernel) independent of command submissions (done directly by user space). This version doesn't support shadow copy of VM page tables for CPU based update.</pre>
          </blockquote>
          I think your improved performance is from less waiting for cs,
          generally, SDMA engine updating page table is faster than CPU,
          otherwise we don't need sdma for updating PT.<br>
          So whether your this improvement proves we have some redundant
          sync when mapping / unmapping, if yes, we should fix that,
          then not sure if CPU method is need or not.<br>
        </blockquote>
        <br>
        The problem is that the KFD is designed synchronously for page
        table updates. In other words they need to wait for the update
        to finish and that takes time.<br>
        <br>
        Apart from that your comment is absolutely correct, we found
        that the SDMA is sometimes much faster to do the update than the
        CPU.<br>
      </blockquote>
      If the sdma is faster, even they wait for finish, which time is
      shorter than CPU, isn't it? Of course, the precondition is sdma is
      exclusive. They can reserve a sdma for PT updating.<br>
    </blockquote>
    <br>
    No, if I understood Felix numbers correctly the setup and wait time
    for SDMA is a bit (but not much) longer than doing it with the CPU.<br>
    <br>
    What would really help is to fix the KFD design and work with async
    page tables updates there as well.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote cite="mid:59157453.8010308-5C7GfCeVMHo@public.gmane.org" type="cite"> <br>
      Regards,<br>
      David Zhou<br>
      <blockquote
        cite="mid:21e206ed-8d60-450f-6d23-e01c68c5ad73-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite"> <br>
        Regards,<br>
        Christian.<br>
        <br>
        <blockquote cite="mid:5915717A.3000209-5C7GfCeVMHo@public.gmane.org" type="cite"> <br>
          Regards,<br>
          David Zhou<br>
          <blockquote
cite="mid:DM3PR1201MB10382F282D646D630708246D8CEF0-BBcFnVpqZhWjUUTFdQAMQmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
            type="cite">
            <pre wrap="">Best Regards,
Harish

</pre>
            <br>
            <fieldset class="mimeAttachmentHeader"></fieldset>
            <br>
            <pre wrap="">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
          <br>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap="">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <p><br>
        </p>
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

--------------0A731E567473D46C6B723FBD--

--===============2125191007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2125191007==--
