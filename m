From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Support for amdgpu VM update via CPU on large-bar systems
Date: Fri, 12 May 2017 10:33:23 +0200
Message-ID: <21e206ed-8d60-450f-6d23-e01c68c5ad73@vodafone.de>
References: <DM3PR1201MB10382F282D646D630708246D8CEF0@DM3PR1201MB1038.namprd12.prod.outlook.com>
 <5915717A.3000209@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0193098486=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5915717A.3000209-5C7GfCeVMHo@public.gmane.org>
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
--===============0193098486==
Content-Type: multipart/alternative;
 boundary="------------9BFD58E4976EA57BC426C137"

This is a multi-part message in MIME format.
--------------9BFD58E4976EA57BC426C137
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.05.2017 um 10:25 schrieb zhoucm1:
>
> On 2017年05月10日 05:47, Kasiviswanathan, Harish wrote:
>> Hi,
>>
>> Please review the patch set that supports amdgpu VM update via CPU. This feature provides improved performance for compute (HSA) where mapping / unmapping is carried out (by Kernel) independent of command submissions (done directly by user space). This version doesn't support shadow copy of VM page tables for CPU based update.
> I think your improved performance is from less waiting for cs, 
> generally, SDMA engine updating page table is faster than CPU, 
> otherwise we don't need sdma for updating PT.
> So whether your this improvement proves we have some redundant sync 
> when mapping / unmapping, if yes, we should fix that, then not sure if 
> CPU method is need or not.

The problem is that the KFD is designed synchronously for page table 
updates. In other words they need to wait for the update to finish and 
that takes time.

Apart from that your comment is absolutely correct, we found that the 
SDMA is sometimes much faster to do the update than the CPU.

Regards,
Christian.

>
> Regards,
> David Zhou
>> Best Regards,
>> Harish
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
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------9BFD58E4976EA57BC426C137
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 12.05.2017 um 10:25 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:5915717A.3000209-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <br>
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
      sync when mapping / unmapping, if yes, we should fix that, then
      not sure if CPU method is need or not.<br>
    </blockquote>
    <br>
    The problem is that the KFD is designed synchronously for page table
    updates. In other words they need to wait for the update to finish
    and that takes time.<br>
    <br>
    Apart from that your comment is absolutely correct, we found that
    the SDMA is sometimes much faster to do the update than the CPU.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote cite="mid:5915717A.3000209-5C7GfCeVMHo@public.gmane.org" type="cite"> <br>
      Regards,<br>
      David Zhou<br>
      <blockquote
cite="mid:DM3PR1201MB10382F282D646D630708246D8CEF0-BBcFnVpqZhWjUUTFdQAMQmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
        type="cite">
        <pre wrap="">
Best Regards,
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
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------9BFD58E4976EA57BC426C137--

--===============0193098486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0193098486==--
