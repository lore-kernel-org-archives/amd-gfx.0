From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: update golden setting of VI
Date: Wed, 3 Aug 2016 14:21:58 +0200
Message-ID: <9647b795-489e-9a57-518f-7580f045bf09@vodafone.de>
References: <1470115414-23733-1-git-send-email-ray.huang@amd.com>
 <57d13336-f5ae-99f5-5b2d-0c65b8acacd1@folklore1984.net>
 <a47a4a95-147b-5e3b-aadd-57545102ce25@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1276235217=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a47a4a95-147b-5e3b-aadd-57545102ce25-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1276235217==
Content-Type: multipart/alternative;
 boundary="------------180FEC8CA25E3FD6CA10C5F5"

This is a multi-part message in MIME format.
--------------180FEC8CA25E3FD6CA10C5F5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Well, usually they are just the recommended settings from the hardware 
team which try to fix or improve things by changing the default values 
for the registers.

I work for AMD and sometimes it isn't clear to me either what those 
changes are good for. E.g. I would need to dig though a whole bunch of 
register documentation and hardware specs to figure that out.

Alternatively I can try to steal some free time from the hardware guy 
who initiated the change and try to figure out the background.

Both tasks are rather time consuming and most likely not necessary at 
all as long as you don't run into a regression.

Regards,
Christian.

Am 03.08.2016 um 14:09 schrieb Edward O'Callaghan:
> I forgot to say, if this is clear to everyone else but me you can just
> ignore my noise here :p
>
> On 08/03/2016 10:06 PM, Edward O'Callaghan wrote:
>> Hi,
>>
>> I think it would be helpful for at least one liner explaining actually
>> what is even getting "fixed" here? Obviously we assume, given that you
>> work for AMD, these magics are correct however it does help in case of
>> issue.
>>
>> Just for a motivating example, suppose a magic is technically correct as
>> per hw documentation but there is a bug in the ASIC itself that this
>> changed caused a regression with then we would know where/how it occurs.
>>
>> Kind Regards,
>> Edward.
>>
>> On 08/02/2016 03:23 PM, Huang Rui wrote:
>>> Hi all,
>>>
>>> This patch set are all changes of golden setting, mgcg_cgcg setting,
>>> tiling mode array and rev id of VI series of cards.
>>>
>>> Changes from V1 -> V2:
>>> - Polaris10 changes are in tonga and polaris11 patches. And fix it.
>>>
>>> Thanks,
>>> Rui
>>>
>>> Huang Rui (3):
>>>    drm/amdgpu: update golden setting of tonga
>>>    drm/amdgpu: update golden setting of polaris11
>>>    drm/amdgpu: update golden setting of polaris10
>>>
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------180FEC8CA25E3FD6CA10C5F5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Well, usually they are just the
      recommended settings from the hardware team which try to fix or
      improve things by changing the default values for the registers.<br>
      <br>
      I work for AMD and sometimes it isn't clear to me either what
      those changes are good for. E.g. I would need to dig though a
      whole bunch of register documentation and hardware specs to figure
      that out.<br>
      <br>
      Alternatively I can try to steal some free time from the hardware
      guy who initiated the change and try to figure out the background.<br>
      <br>
      Both tasks are rather time consuming and most likely not necessary
      at all as long as you don't run into a regression.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 03.08.2016 um 14:09 schrieb Edward O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:a47a4a95-147b-5e3b-aadd-57545102ce25-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">I forgot to say, if this is clear to everyone else but me you can just
ignore my noise here :p

On 08/03/2016 10:06 PM, Edward O'Callaghan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hi,

I think it would be helpful for at least one liner explaining actually
what is even getting "fixed" here? Obviously we assume, given that you
work for AMD, these magics are correct however it does help in case of
issue.

Just for a motivating example, suppose a magic is technically correct as
per hw documentation but there is a bug in the ASIC itself that this
changed caused a regression with then we would know where/how it occurs.

Kind Regards,
Edward.

On 08/02/2016 03:23 PM, Huang Rui wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Hi all,

This patch set are all changes of golden setting, mgcg_cgcg setting,
tiling mode array and rev id of VI series of cards.

Changes from V1 -&gt; V2:
- Polaris10 changes are in tonga and polaris11 patches. And fix it.

Thanks,
Rui

Huang Rui (3):
  drm/amdgpu: update golden setting of tonga
  drm/amdgpu: update golden setting of polaris11
  drm/amdgpu: update golden setting of polaris10

 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

</pre>
        </blockquote>
        <pre wrap="">


_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>

</pre>
      </blockquote>
      <pre wrap="">
</pre>
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

--------------180FEC8CA25E3FD6CA10C5F5--

--===============1276235217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1276235217==--
