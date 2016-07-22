From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENI?=
 =?UTF-8?Q?]_drm/amdgpu:_adjust_gtt_memory_size?=
Date: Fri, 22 Jul 2016 15:02:56 +0200
Message-ID: <eda1830b-45a8-084c-2db6-a0ab4a23f499@vodafone.de>
References: <1469087199-20802-1-git-send-email-Qingqing.Wang@amd.com>
 <fe341676-48d3-a847-89b4-224f2ba4620e@vodafone.de>
 <SN1PR12MB0511612A271156A2EFC7B449EC090@SN1PR12MB0511.namprd12.prod.outlook.com>
 <cb3c1f87-f14f-dd6b-df69-26c12672c51f@vodafone.de>
 <SN1PR12MB051120166EEFC6A65C7BB795EC090@SN1PR12MB0511.namprd12.prod.outlook.com>
 <324ba8e3-c296-2d74-0cb5-5d212a6f2d54@vodafone.de>
 <SN1PR12MB0511DD6F60EAFDB326320B46EC090@SN1PR12MB0511.namprd12.prod.outlook.com>
 <3839ef42-6275-99d8-9aee-54143a971f0b@vodafone.de>
 <458f751a-6f4a-1dd9-45d0-ad1ad5f7154f@amd.com>
 <CY1PR12MB0508280B4E4E1408F5ECAD24EC0A0@CY1PR12MB0508.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0529173878=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY1PR12MB0508280B4E4E1408F5ECAD24EC0A0-1s8aH8ViOEfJai4n+QWBiQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Ken" <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0529173878==
Content-Type: multipart/alternative;
 boundary="------------16FD5342321CF5B5F3691A06"

This is a multi-part message in MIME format.
--------------16FD5342321CF5B5F3691A06
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Yeah sounds good to me.

Could we make a global ttm function returning how much system memory can=20
be used at the same time?

This way we could make those values depend on each other, e.g. when=20
somebody modifies the TTM value we automatically change the GART size as=20
well.

Regards,
Christian.

Am 22.07.2016 um 08:06 schrieb Wang, Ken:
>
> thanks Felix,
>
>    I see that logci in TTM as well, so choose 1/2 of system memory as=20
> up limit seems good enough here? if no object I will fix the overflow=20
> issue and send the review again.
>
> -----------------------------------------------------------------------=
-
> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* amd-gfx <amd-gfx-bounces-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org> =E4=BB=A3=E8=A1=A8 Felix=20
> Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8822=E6=97=
=A5 3:19:38
> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *=E4=B8=BB=E9=A2=98:* Re: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=A4=8D: =E7=AD=
=94=E5=A4=8D: [PATCH] drm/amdgpu: adjust gtt memory size
>
> TTM limits system memory allocations to 1/2 system memory for regular=20
> processes, or 3/4 for privileged processes.
>
>
> For compute we opted to make the GART bigger than system memory to=20
> allow for fragmentation. However, we argued that you don't really need=20
> GART for most buffers anyways, since they are never accessed in VMID=20
> 0. They need to be mapped in some VM page table, but never in the GART=20
> table. So I think the long-term goal should be to remove the need to=20
> allocate GART addresses for system memory BOs. Then you could get away=20
> with a quite small GART size.
>
>
> Regards,
>
>   Felix
>
>
> On 16-07-21 08:04 AM, Christian K=C3=B6nig wrote:
>>>
>>> we can add people in if necessary here. so the initial though of=20
>>> this change is with latest big memory GPU released, the remote=20
>>> memory goes very large, like Polaris10.
>>>
>>> According to the windows WDDM, remote memory size is half of the=20
>>> system memory, I don't know what was discussed before, Please let me=20
>>> know if there're use case indeed need that big of remote memory.
>>>
>> Well that is at least something that makes sense.
>>
>> Previous discussions where always settled around making GART bigger=20
>> than VRAM and not the other way around.
>>
>> Anyway I think a prerequisite to this is actually allowing half of=20
>> system memory to be allocated for GART and I'm not sure if that is=20
>> currently the case. TTM has a limitation for that as well, but I off=20
>> hand don't remember how high much it was.
>>
>> I think we should use the same value which TTM uses for the upper=20
>> limit here.
>>
>> Regards,
>> Christian.
>>
>> Am 21.07.2016 um 13:56 schrieb Wang, Qingqing:
>>>
>>> alright, I didn't realize you're not in that thread.
>>>
>>> we can add people in if necessary here. so the initial though of=20
>>> this change is with latest big memory GPU released, the remote=20
>>> memory goes very large, like Polaris10.
>>>
>>> According to the windows WDDM, remote memory size is half of the=20
>>> system memory, I don't know what was discussed before, Please let me=20
>>> know if there're use case indeed need that big of remote memory.
>>>
>>> ---------------------------------------------------------------------=
---
>>> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* Christian K=C3=B6nig <deathsimple@voda=
fone.de>
>>> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8821=E6=97=
=A5 19:48:17
>>> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Wang, Qingqing; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org
>>> *=E4=B8=BB=E9=A2=98:* Re: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=A4=8D: [PA=
TCH] drm/amdgpu: adjust gtt memory size
>>> Am 21.07.2016 um 13:15 schrieb Wang, Qingqing:
>>>>
>>>> Actually that discussion was held long ago internally but we never=20
>>>> got a conclusion on this IIRC. So we should probably continue the=20
>>>> discussion on this thread now.
>>>>
>>>> -there is a thread for this topic yesterday, some people are not in=20
>>>> amd-gfx mail list, we'd better discuss in the internal thread.
>>>>
>>> No, exactly for this reason we have the public mailing list. I for=20
>>> example wasn't part of the internal thread either.
>>>
>>> Christian.
>>>
>>>> --------------------------------------------------------------------=
----
>>>> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* Christian K=C3=B6nig <deathsimple@vod=
afone.de>
>>>> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8821=E6=
=97=A5 17:48:41
>>>> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Wang, Qingqing; amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org
>>>> *=E4=B8=BB=E9=A2=98:* Re: =E7=AD=94=E5=A4=8D: [PATCH] drm/amdgpu: ad=
just gtt memory size
>>>> Am 21.07.2016 um 11:16 schrieb Wang, Qingqing:
>>>>>
>>>>> This doesn't work on 32bit systems since totalram is a long (IIRC)=20
>>>>> and
>>>>> so this will certainly overflow.
>>>>>
>>>>> -- can you be more specific, how could the overflow happen?
>>>>>
>>>>
>>>> Both values are 32bit on a 32bit system, so as soon as you have=20
>>>> more than 4GB installed this will overflow.
>>>>
>>>> You need to cast the long to a 64bit value to avoid that.
>>>>
>>>>>
>>>>> Additional if I remember correctly we didn't ended the discussion o=
n
>>>>> what to do here with a conclusion.
>>>>>
>>>>> -- ok, since it happens in anther mail list, we should stop=20
>>>>> talking about it here, you can send out your ideas there.
>>>>>
>>>>
>>>> Actually that discussion was held long ago internally but we never=20
>>>> got a conclusion on this IIRC. So we should probably continue the=20
>>>> discussion on this thread now.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> -------------------------------------------------------------------=
-----
>>>>> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* amd-gfx <amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org> =E4=BB=A3=E8=A1=A8=20
>>>>> Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>>>>> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8821=E6=
=97=A5 16:53:05
>>>>> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Wang, Qingqing; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org
>>>>> *=E4=B8=BB=E9=A2=98:* Re: [PATCH] drm/amdgpu: adjust gtt memory siz=
e
>>>>> Am 21.07.2016 um 09:46 schrieb Ken Wang:
>>>>> > Change-Id: If00d5b97ba9e30f9b7f68fdfc134a0f8b3ad2add
>>>>> > Signed-off-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>
>>>>> > ---
>>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 7 ++++++-
>>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 7 ++++++-
>>>>> >   2 files changed, 12 insertions(+), 2 deletions(-)
>>>>> >
>>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c=20
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> > index a3b6048..0b095d5 100644
>>>>> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> > @@ -336,6 +336,11 @@ static int gmc_v7_0_mc_init(struct=20
>>>>> amdgpu_device *adev)
>>>>> >   {
>>>>> >        u32 tmp;
>>>>> >        int chansize, numchan;
>>>>> > +     u64 sysmem_size;
>>>>> > +     struct sysinfo si;
>>>>> > +
>>>>> > +     si_meminfo(&si);
>>>>> > +     sysmem_size =3D si.totalram * si.mem_unit;
>>>>>
>>>>> This doesn't work on 32bit systems since totalram is a long (IIRC)=20
>>>>> and
>>>>> so this will certainly overflow.
>>>>>
>>>>> Additional if I remember correctly we didn't ended the discussion o=
n
>>>>> what to do here with a conclusion.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> >
>>>>> >        /* Get VRAM informations */
>>>>> >        tmp =3D RREG32(mmMC_ARB_RAMCFG);
>>>>> > @@ -392,7 +397,7 @@ static int gmc_v7_0_mc_init(struct=20
>>>>> amdgpu_device *adev)
>>>>> >         * size equal to the 1024 or vram, whichever is larger.
>>>>> >         */
>>>>> >        if (amdgpu_gart_size =3D=3D -1)
>>>>> > -             adev->mc.gtt_size =3D max((1024ULL << 20),=20
>>>>> adev->mc.mc_vram_size);
>>>>> > +             adev->mc.gtt_size =3D max((1024ULL << 20),=20
>>>>> min(adev->mc.mc_vram_size, sysmem_size/2));
>>>>> >        else
>>>>> >                adev->mc.gtt_size =3D (uint64_t)amdgpu_gart_size <=
< 20;
>>>>> >
>>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c=20
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> > index 02b6872..790bf7a 100644
>>>>> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> > @@ -413,6 +413,11 @@ static int gmc_v8_0_mc_init(struct=20
>>>>> amdgpu_device *adev)
>>>>> >   {
>>>>> >        u32 tmp;
>>>>> >        int chansize, numchan;
>>>>> > +     u64 sysmem_size;
>>>>> > +     struct sysinfo si;
>>>>> > +
>>>>> > +     si_meminfo(&si);
>>>>> > +     sysmem_size =3D si.totalram * si.mem_unit;
>>>>> >
>>>>> >        /* Get VRAM informations */
>>>>> >        tmp =3D RREG32(mmMC_ARB_RAMCFG);
>>>>> > @@ -469,7 +474,7 @@ static int gmc_v8_0_mc_init(struct=20
>>>>> amdgpu_device *adev)
>>>>> >         * size equal to the 1024 or vram, whichever is larger.
>>>>> >         */
>>>>> >        if (amdgpu_gart_size =3D=3D -1)
>>>>> > -             adev->mc.gtt_size =3D max((1024ULL << 20),=20
>>>>> adev->mc.mc_vram_size);
>>>>> > +             adev->mc.gtt_size =3D max((1024ULL << 20),=20
>>>>> min(adev->mc.mc_vram_size, sysmem_size/2));
>>>>> >        else
>>>>> >                adev->mc.gtt_size =3D (uint64_t)amdgpu_gart_size <=
< 20;
>>>>> >
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>
>>>>
>>>
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



--------------16FD5342321CF5B5F3691A06
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Yeah sounds good to me.<br>
      <br>
      Could we make a global ttm function returning how much system
      memory can be used at the same time?<br>
      <br>
      This way we could make those values depend on each other, e.g.
      when somebody modifies the TTM value we automatically change the
      GART size as well.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 22.07.2016 um 08:06 schrieb Wang, Ken:<br>
    </div>
    <blockquote
cite=3D"mid:CY1PR12MB0508280B4E4E1408F5ECAD24EC0A0-1s8aH8ViOEfJai4n+QWBib2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Du=
tf-8">
      <style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top=
:0;margin-bottom:0;} --></style>
      <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
        <p>thanks Felix,</p>
        <p>=C2=A0=C2=A0 I see that logci in TTM as well, so choose 1/2 of=
 system
          memory as up limit seems good enough here? if no object I will
          fix the overflow issue and send the review again.<br>
        </p>
      </div>
      <hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
      <div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt=
"
          color=3D"#000000" face=3D"Calibri, sans-serif"><b>=E5=8F=91=E4=BB=
=B6=E4=BA=BA:</b> amd-gfx
          <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</=
a> =E4=BB=A3=E8=A1=A8 Felix
          Kuehling <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:feli=
x.kuehling-5C7GfCeVMHo@public.gmane.org">&lt;felix.kuehling-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2016=E5=B9=B47=E6=9C=
=8822=E6=97=A5 3:19:38<br>
          <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> <a class=3D"moz-txt-link-ab=
breviated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org</a><br>
          <b>=E4=B8=BB=E9=A2=98:</b> Re: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=
=A4=8D: =E7=AD=94=E5=A4=8D: [PATCH] drm/amdgpu: adjust gtt
          memory size</font>
        <div>=C2=A0</div>
      </div>
      <div>
        <p>TTM limits system memory allocations to 1/2 system memory for
          regular processes, or 3/4 for privileged processes.</p>
        <p><br>
        </p>
        <p>For compute we opted to make the GART bigger than system
          memory to allow for fragmentation. However, we argued that you
          don't really need GART for most buffers anyways, since they
          are never accessed in VMID 0. They need to be mapped in some
          VM page table, but never in the GART table. So I think the
          long-term goal should be to remove the need to allocate GART
          addresses for system memory BOs. Then you could get away with
          a quite small GART size.<br>
        </p>
        <p><br>
        </p>
        <p>Regards,</p>
        <p>=C2=A0 Felix<br>
        </p>
        <br>
        <div class=3D"moz-cite-prefix">On 16-07-21 08:04 AM, Christian
          K=C3=B6nig wrote:<br>
        </div>
        <blockquote
          cite=3D"mid:3839ef42-6275-99d8-9aee-54143a971f0b-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
          type=3D"cite">
          <div class=3D"moz-cite-prefix">
            <blockquote type=3D"cite">
              <p>we can add people in if necessary here. so the initial
                though of this change is with latest big memory GPU
                released, the remote memory goes very large, like
                Polaris10.</p>
              <p>According to the windows WDDM, remote memory size
                is=C2=A0half of the system memory, I don't know what was
                discussed before, Please let me know if there're use
                case indeed need that big of remote memory.</p>
            </blockquote>
            Well that is at least something that makes sense.<br>
            <br>
            Previous discussions where always settled around making GART
            bigger than VRAM and not the other way around.<br>
            <br>
            Anyway I think a prerequisite to this is actually allowing
            half of system memory to be allocated for GART and I'm not
            sure if that is currently the case. TTM has a limitation for
            that as well, but I off hand don't remember how high much it
            was.<br>
            <br>
            I think we should use the same value which TTM uses for the
            upper limit here.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 21.07.2016 um 13:56 schrieb Wang, Qingqing:<br>
          </div>
          <blockquote
cite=3D"mid:SN1PR12MB0511DD6F60EAFDB326320B46EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
            type=3D"cite">
            <style type=3D"text/css" style=3D"display:none;"><!-- P {marg=
in-top:0;margin-bottom:0;} --></style>
            <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
              <p>alright, I didn't realize you're not in that thread.=C2=A0=
</p>
              <p>we can add people in if necessary here. so the initial
                though of this change is with latest big memory GPU
                released, the remote memory goes very large, like
                Polaris10.</p>
              <p>According to the windows WDDM, remote memory size
                is=C2=A0half of the system memory, I don't know what was
                discussed before, Please let me know if there're use
                case indeed need that big of remote memory.</p>
            </div>
            <hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
            <div id=3D"divRplyFwdMsg" dir=3D"ltr"><font
                style=3D"font-size:11pt" color=3D"#000000" face=3D"Calibr=
i,
                sans-serif"><b>=E5=8F=91=E4=BB=B6=E4=BA=BA:</b> Christian=
 K=C3=B6nig
                <a moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc2396=
E"
                  href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">
                  &lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2016=E5=B9=B4=
7=E6=9C=8821=E6=97=A5 19:48:17<br>
                <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> Wang, Qingqing; <a mo=
z-do-not-send=3D"true"
                  class=3D"moz-txt-link-abbreviated"
                  href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                  amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>=E4=B8=BB=E9=A2=98:</b> Re: =E7=AD=94=E5=A4=8D: =E7=AD=
=94=E5=A4=8D: [PATCH] drm/amdgpu: adjust gtt
                memory size</font>
              <div>=C2=A0</div>
            </div>
            <div>
              <div class=3D"moz-cite-prefix">Am 21.07.2016 um 13:15
                schrieb Wang, Qingqing:<br>
              </div>
              <blockquote
cite=3D"mid:SN1PR12MB051120166EEFC6A65C7BB795EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
                type=3D"cite">
                <style type=3D"text/css" style=3D"display:none;"><!-- P {=
margin-top:0;margin-bottom:0;} --></style>
                <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
                  <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
                    <p><span style=3D"color: rgb(33, 33, 33); font-size:
                        15px;">Actually that discussion was held long
                        ago internally but we never got a conclusion on
                        this IIRC. So we should probably continue the
                        discussion on this thread now.</span><br>
                    </p>
                    <p><font color=3D"#212121"><span style=3D"font-size:
                          15px;">-there is a thread for this topic
                          yesterday, some people are not in amd-gfx mail
                          list, we'd better=C2=A0discuss=C2=A0in
                          the=C2=A0internal=C2=A0thread.</span></font></p=
>
                  </div>
                </div>
              </blockquote>
              No, exactly for this reason we have the public mailing
              list. I for example wasn't part of the internal thread
              either.<br>
              <br>
              Christian.<br>
              <br>
              <blockquote
cite=3D"mid:SN1PR12MB051120166EEFC6A65C7BB795EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
                type=3D"cite">
                <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
                  <hr style=3D"display:inline-block;width:98%"
                    tabindex=3D"-1">
                  <div id=3D"divRplyFwdMsg" dir=3D"ltr"><font
                      style=3D"font-size:11pt" color=3D"#000000"
                      face=3D"Calibri, sans-serif"><b>=E5=8F=91=E4=BB=B6=E4=
=BA=BA:</b> Christian
                      K=C3=B6nig
                      <a moz-do-not-send=3D"true"
                        class=3D"moz-txt-link-rfc2396E"
                        href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">
                        &lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                      <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2016=E5=
=B9=B47=E6=9C=8821=E6=97=A5 17:48:41<br>
                      <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> Wang, Qingqing;=
 <a
                        moz-do-not-send=3D"true"
                        class=3D"moz-txt-link-abbreviated"
                        href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                        amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <b>=E4=B8=BB=E9=A2=98:</b> Re: =E7=AD=94=E5=A4=8D: =
[PATCH] drm/amdgpu: adjust gtt
                      memory size</font>
                    <div>=C2=A0</div>
                  </div>
                  <div>
                    <div class=3D"moz-cite-prefix">Am 21.07.2016 um 11:16
                      schrieb Wang, Qingqing:<br>
                    </div>
                    <blockquote
cite=3D"mid:SN1PR12MB0511612A271156A2EFC7B449EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
                      type=3D"cite">
                      <meta name=3D"Generator" content=3D"Microsoft Excha=
nge
                        Server">
                      <!-- converted from text -->
                      <meta content=3D"text/html; charset=3DUTF-8">
                      <div dir=3D"ltr">
                        <div id=3D"x_divtagdefaultwrapper"
                          style=3D"font-size:12pt; color:#000000;
                          background-color:#FFFFFF;
                          font-family:Calibri,Arial,Helvetica,sans-serif"=
>
                          <p><font size=3D"2"><span style=3D"font-size:10=
pt">This
                                doesn't work on 32bit systems since
                                totalram is a long (IIRC) and
                                <br>
                                so this will certainly overflow.</span></=
font></p>
                          <p>-- can you be more specific, how could the
                            overflow happen?</p>
                        </div>
                      </div>
                    </blockquote>
                    <br>
                    Both values are 32bit on a 32bit system, so as soon
                    as you have more than 4GB installed this will
                    overflow.<br>
                    <br>
                    You need to cast the long to a 64bit value to avoid
                    that.<br>
                    <br>
                    <blockquote
cite=3D"mid:SN1PR12MB0511612A271156A2EFC7B449EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
                      type=3D"cite">
                      <div dir=3D"ltr">
                        <div id=3D"x_divtagdefaultwrapper"
                          style=3D"font-size:12pt; color:#000000;
                          background-color:#FFFFFF;
                          font-family:Calibri,Arial,Helvetica,sans-serif"=
>
                          <p><br>
                          </p>
                          <p><font size=3D"2"><span style=3D"font-size:10=
pt">Additional
                                if I remember correctly we didn't ended
                                the discussion on
                                <br>
                                what to do here with a conclusion.</span>=
</font></p>
                          <p>-- ok, since it happens in anther mail
                            list, we should stop talking about it here,
                            you can send out your ideas there.<br>
                          </p>
                        </div>
                      </div>
                    </blockquote>
                    <br>
                    Actually that discussion was held long ago
                    internally but we never got a conclusion on this
                    IIRC. So we should probably continue the discussion
                    on this thread now.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <blockquote
cite=3D"mid:SN1PR12MB0511612A271156A2EFC7B449EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
                      type=3D"cite">
                      <div dir=3D"ltr">
                        <div id=3D"x_divtagdefaultwrapper"
                          style=3D"font-size:12pt; color:#000000;
                          background-color:#FFFFFF;
                          font-family:Calibri,Arial,Helvetica,sans-serif"=
>
                        </div>
                        <hr tabindex=3D"-1" style=3D"display:inline-block=
;
                          width:98%">
                        <div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font
                            style=3D"font-size:11pt" color=3D"#000000"
                            face=3D"Calibri, sans-serif"><b>=E5=8F=91=E4=BB=
=B6=E4=BA=BA:</b>
                            amd-gfx
                            <a moz-do-not-send=3D"true"
                              class=3D"moz-txt-link-rfc2396E"
                              href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> =E4=BB=A3=E8=A1=A8 Chri=
stian K=C3=B6nig <a
                              moz-do-not-send=3D"true"
                              class=3D"moz-txt-link-rfc2396E"
                              href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">
                              &lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                            <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> =
2016=E5=B9=B47=E6=9C=8821=E6=97=A5 16:53:05<br>
                            <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> Wang, Qin=
gqing; <a
                              moz-do-not-send=3D"true"
                              class=3D"moz-txt-link-abbreviated"
                              href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g">
                              amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                            <b>=E4=B8=BB=E9=A2=98:</b> Re: [PATCH] drm/am=
dgpu: adjust
                            gtt memory size</font>
                          <div>=C2=A0</div>
                        </div>
                      </div>
                      <font size=3D"2"><span style=3D"font-size:10pt;">
                          <div class=3D"PlainText">Am 21.07.2016 um 09:46
                            schrieb Ken Wang:<br>
                            &gt; Change-Id:
                            If00d5b97ba9e30f9b7f68fdfc134a0f8b3ad2add<br>
                            &gt; Signed-off-by: Ken Wang <a
                              moz-do-not-send=3D"true"
                              class=3D"moz-txt-link-rfc2396E"
                              href=3D"mailto:Qingqing.Wang-5C7GfCeVMHo@public.gmane.org">
                              &lt;Qingqing.Wang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                            &gt; ---<br>
                            &gt;=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/g=
mc_v7_0.c
                            | 7 ++++++-<br>
                            &gt;=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/g=
mc_v8_0.c
                            | 7 ++++++-<br>
                            &gt;=C2=A0=C2=A0 2 files changed, 12 insertio=
ns(+), 2
                            deletions(-)<br>
                            &gt;<br>
                            &gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
                            b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
                            &gt; index a3b6048..0b095d5 100644<br>
                            &gt; ---
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
                            &gt; +++
                            b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
                            &gt; @@ -336,6 +336,11 @@ static int
                            gmc_v7_0_mc_init(struct amdgpu_device *adev)<=
br>
                            &gt;=C2=A0=C2=A0 {<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 u32 tmp;<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int chansize, numchan;<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 u64 sysmem_siz=
e;<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 struct sysinfo=
 si;<br>
                            &gt; +<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 si_meminfo(&am=
p;si);<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 sysmem_size =3D=
 si.totalram *
                            si.mem_unit;<br>
                            <br>
                            This doesn't work on 32bit systems since
                            totalram is a long (IIRC) and <br>
                            so this will certainly overflow.<br>
                            <br>
                            Additional if I remember correctly we didn't
                            ended the discussion on <br>
                            what to do here with a conclusion.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            &gt;=C2=A0=C2=A0 <br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* Get VRAM informations */<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 tmp =3D RREG32(mmMC_ARB_RAMCFG);<br>
                            &gt; @@ -392,7 +397,7 @@ static int
                            gmc_v7_0_mc_init(struct amdgpu_device *adev)<=
br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * size equal to the 1024 or
                            vram, whichever is larger.<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (amdgpu_gart_size =3D=3D -1)<br>
                            &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                            max((1024ULL &lt;&lt; 20),
                            adev-&gt;mc.mc_vram_size);<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                            max((1024ULL &lt;&lt; 20),
                            min(adev-&gt;mc.mc_vram_size,
                            sysmem_size/2));<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 else<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                            (uint64_t)amdgpu_gart_size &lt;&lt; 20;<br>
                            &gt;=C2=A0=C2=A0 <br>
                            &gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
                            b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
                            &gt; index 02b6872..790bf7a 100644<br>
                            &gt; ---
                            a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
                            &gt; +++
                            b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
                            &gt; @@ -413,6 +413,11 @@ static int
                            gmc_v8_0_mc_init(struct amdgpu_device *adev)<=
br>
                            &gt;=C2=A0=C2=A0 {<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 u32 tmp;<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 int chansize, numchan;<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 u64 sysmem_siz=
e;<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 struct sysinfo=
 si;<br>
                            &gt; +<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 si_meminfo(&am=
p;si);<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 sysmem_size =3D=
 si.totalram *
                            si.mem_unit;<br>
                            &gt;=C2=A0=C2=A0 <br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 /* Get VRAM informations */<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 tmp =3D RREG32(mmMC_ARB_RAMCFG);<br>
                            &gt; @@ -469,7 +474,7 @@ static int
                            gmc_v8_0_mc_init(struct amdgpu_device *adev)<=
br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * size equal to the 1024 or
                            vram, whichever is larger.<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if (amdgpu_gart_size =3D=3D -1)<br>
                            &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                            max((1024ULL &lt;&lt; 20),
                            adev-&gt;mc.mc_vram_size);<br>
                            &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                            max((1024ULL &lt;&lt; 20),
                            min(adev-&gt;mc.mc_vram_size,
                            sysmem_size/2));<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 else<br>
                            &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                            (uint64_t)amdgpu_gart_size &lt;&lt; 20;<br>
                            &gt;=C2=A0=C2=A0 <br>
                            <br>
                            <br>
_______________________________________________<br>
                            amd-gfx mailing list<br>
                            <a moz-do-not-send=3D"true"
                              class=3D"moz-txt-link-abbreviated"
                              href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                            <a moz-do-not-send=3D"true"
                              href=3D"https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-g=
fx</a><br>
                          </div>
                        </span></font></blockquote>
                    <p><br>
                    </p>
                  </div>
                </div>
              </blockquote>
              <p><br>
              </p>
            </div>
          </blockquote>
          <p><br>
          </p>
          <br>
          <fieldset class=3D"mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap=3D"">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated" href=3D"ma=
ilto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext" href=3D"https=
://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesk=
top.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <br>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/=
amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------16FD5342321CF5B5F3691A06--

--===============0529173878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0529173878==--
