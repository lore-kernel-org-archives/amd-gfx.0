From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRDSF0gZHJtL2Ft?=
 =?UTF-8?Q?dgpu:_adjust_gtt_memory_size?=
Date: Thu, 21 Jul 2016 15:19:38 -0400
Message-ID: <458f751a-6f4a-1dd9-45d0-ad1ad5f7154f@amd.com>
References: <1469087199-20802-1-git-send-email-Qingqing.Wang@amd.com>
 <fe341676-48d3-a847-89b4-224f2ba4620e@vodafone.de>
 <SN1PR12MB0511612A271156A2EFC7B449EC090@SN1PR12MB0511.namprd12.prod.outlook.com>
 <cb3c1f87-f14f-dd6b-df69-26c12672c51f@vodafone.de>
 <SN1PR12MB051120166EEFC6A65C7BB795EC090@SN1PR12MB0511.namprd12.prod.outlook.com>
 <324ba8e3-c296-2d74-0cb5-5d212a6f2d54@vodafone.de>
 <SN1PR12MB0511DD6F60EAFDB326320B46EC090@SN1PR12MB0511.namprd12.prod.outlook.com>
 <3839ef42-6275-99d8-9aee-54143a971f0b@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1167215699=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3839ef42-6275-99d8-9aee-54143a971f0b-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1167215699==
Content-Type: multipart/alternative;
	boundary="------------7E393F8687DEE3C8A0076110"

--------------7E393F8687DEE3C8A0076110
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

TTM limits system memory allocations to 1/2 system memory for regular
processes, or 3/4 for privileged processes.


For compute we opted to make the GART bigger than system memory to allow
for fragmentation. However, we argued that you don't really need GART
for most buffers anyways, since they are never accessed in VMID 0. They
need to be mapped in some VM page table, but never in the GART table. So
I think the long-term goal should be to remove the need to allocate GART
addresses for system memory BOs. Then you could get away with a quite
small GART size.


Regards,

  Felix


On 16-07-21 08:04 AM, Christian K=C3=B6nig wrote:
>>
>> we can add people in if necessary here. so the initial though of this
>> change is with latest big memory GPU released, the remote memory goes
>> very large, like Polaris10.
>>
>> According to the windows WDDM, remote memory size is half of the
>> system memory, I don't know what was discussed before, Please let me
>> know if there're use case indeed need that big of remote memory.
>>
> Well that is at least something that makes sense.
>
> Previous discussions where always settled around making GART bigger
> than VRAM and not the other way around.
>
> Anyway I think a prerequisite to this is actually allowing half of
> system memory to be allocated for GART and I'm not sure if that is
> currently the case. TTM has a limitation for that as well, but I off
> hand don't remember how high much it was.
>
> I think we should use the same value which TTM uses for the upper
> limit here.
>
> Regards,
> Christian.
>
> Am 21.07.2016 um 13:56 schrieb Wang, Qingqing:
>>
>> alright, I didn't realize you're not in that thread.=20
>>
>> we can add people in if necessary here. so the initial though of this
>> change is with latest big memory GPU released, the remote memory goes
>> very large, like Polaris10.
>>
>> According to the windows WDDM, remote memory size is half of the
>> system memory, I don't know what was discussed before, Please let me
>> know if there're use case indeed need that big of remote memory.
>>
>> ----------------------------------------------------------------------=
--
>> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* Christian K=C3=B6nig <deathsimple@vodaf=
one.de>
>> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8821=E6=97=
=A5 19:48:17
>> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Wang, Qingqing; amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org
>> *=E4=B8=BB=E9=A2=98:* Re: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=A4=8D: [PAT=
CH] drm/amdgpu: adjust gtt memory size
>> =20
>> Am 21.07.2016 um 13:15 schrieb Wang, Qingqing:
>>>
>>> Actually that discussion was held long ago internally but we never
>>> got a conclusion on this IIRC. So we should probably continue the
>>> discussion on this thread now.
>>>
>>> -there is a thread for this topic yesterday, some people are not in
>>> amd-gfx mail list, we'd better discuss in the internal thread.
>>>
>> No, exactly for this reason we have the public mailing list. I for
>> example wasn't part of the internal thread either.
>>
>> Christian.
>>
>>> ---------------------------------------------------------------------=
---
>>> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* Christian K=C3=B6nig <deathsimple@voda=
fone.de>
>>> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8821=E6=97=
=A5 17:48:41
>>> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Wang, Qingqing; amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org
>>> *=E4=B8=BB=E9=A2=98:* Re: =E7=AD=94=E5=A4=8D: [PATCH] drm/amdgpu: adj=
ust gtt memory size
>>> =20
>>> Am 21.07.2016 um 11:16 schrieb Wang, Qingqing:
>>>>
>>>> This doesn't work on 32bit systems since totalram is a long (IIRC) a=
nd
>>>> so this will certainly overflow.
>>>>
>>>> -- can you be more specific, how could the overflow happen?
>>>>
>>>
>>> Both values are 32bit on a 32bit system, so as soon as you have more
>>> than 4GB installed this will overflow.
>>>
>>> You need to cast the long to a 64bit value to avoid that.
>>>
>>>>
>>>> Additional if I remember correctly we didn't ended the discussion on
>>>> what to do here with a conclusion.
>>>>
>>>> -- ok, since it happens in anther mail list, we should stop talking
>>>> about it here, you can send out your ideas there.
>>>>
>>>
>>> Actually that discussion was held long ago internally but we never
>>> got a conclusion on this IIRC. So we should probably continue the
>>> discussion on this thread now.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> --------------------------------------------------------------------=
----
>>>> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org> =E4=BB=A3=E8=A1=A8
>>>> Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>>>> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2016=E5=B9=B47=E6=9C=8821=E6=
=97=A5 16:53:05
>>>> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* Wang, Qingqing; amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org
>>>> *=E4=B8=BB=E9=A2=98:* Re: [PATCH] drm/amdgpu: adjust gtt memory size
>>>> =20
>>>> Am 21.07.2016 um 09:46 schrieb Ken Wang:
>>>> > Change-Id: If00d5b97ba9e30f9b7f68fdfc134a0f8b3ad2add
>>>> > Signed-off-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>
>>>> > ---
>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 7 ++++++-
>>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 7 ++++++-
>>>> >   2 files changed, 12 insertions(+), 2 deletions(-)
>>>> >
>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> > index a3b6048..0b095d5 100644
>>>> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>> > @@ -336,6 +336,11 @@ static int gmc_v7_0_mc_init(struct
>>>> amdgpu_device *adev)
>>>> >   {
>>>> >        u32 tmp;
>>>> >        int chansize, numchan;
>>>> > +     u64 sysmem_size;
>>>> > +     struct sysinfo si;
>>>> > +
>>>> > +     si_meminfo(&si);
>>>> > +     sysmem_size =3D si.totalram * si.mem_unit;
>>>>
>>>> This doesn't work on 32bit systems since totalram is a long (IIRC) a=
nd
>>>> so this will certainly overflow.
>>>>
>>>> Additional if I remember correctly we didn't ended the discussion on
>>>> what to do here with a conclusion.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> > =20
>>>> >        /* Get VRAM informations */
>>>> >        tmp =3D RREG32(mmMC_ARB_RAMCFG);
>>>> > @@ -392,7 +397,7 @@ static int gmc_v7_0_mc_init(struct
>>>> amdgpu_device *adev)
>>>> >         * size equal to the 1024 or vram, whichever is larger.
>>>> >         */
>>>> >        if (amdgpu_gart_size =3D=3D -1)
>>>> > -             adev->mc.gtt_size =3D max((1024ULL << 20),
>>>> adev->mc.mc_vram_size);
>>>> > +             adev->mc.gtt_size =3D max((1024ULL << 20),
>>>> min(adev->mc.mc_vram_size, sysmem_size/2));
>>>> >        else
>>>> >                adev->mc.gtt_size =3D (uint64_t)amdgpu_gart_size <<=
 20;
>>>> > =20
>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> > index 02b6872..790bf7a 100644
>>>> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> > @@ -413,6 +413,11 @@ static int gmc_v8_0_mc_init(struct
>>>> amdgpu_device *adev)
>>>> >   {
>>>> >        u32 tmp;
>>>> >        int chansize, numchan;
>>>> > +     u64 sysmem_size;
>>>> > +     struct sysinfo si;
>>>> > +
>>>> > +     si_meminfo(&si);
>>>> > +     sysmem_size =3D si.totalram * si.mem_unit;
>>>> > =20
>>>> >        /* Get VRAM informations */
>>>> >        tmp =3D RREG32(mmMC_ARB_RAMCFG);
>>>> > @@ -469,7 +474,7 @@ static int gmc_v8_0_mc_init(struct
>>>> amdgpu_device *adev)
>>>> >         * size equal to the 1024 or vram, whichever is larger.
>>>> >         */
>>>> >        if (amdgpu_gart_size =3D=3D -1)
>>>> > -             adev->mc.gtt_size =3D max((1024ULL << 20),
>>>> adev->mc.mc_vram_size);
>>>> > +             adev->mc.gtt_size =3D max((1024ULL << 20),
>>>> min(adev->mc.mc_vram_size, sysmem_size/2));
>>>> >        else
>>>> >                adev->mc.gtt_size =3D (uint64_t)amdgpu_gart_size <<=
 20;
>>>> > =20
>>>>
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>>
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------7E393F8687DEE3C8A0076110
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p>TTM limits system memory allocations to 1/2 system memory for
      regular processes, or 3/4 for privileged processes.</p>
    <p><br>
    </p>
    <p>For compute we opted to make the GART bigger than system memory
      to allow for fragmentation. However, we argued that you don't
      really need GART for most buffers anyways, since they are never
      accessed in VMID 0. They need to be mapped in some VM page table,
      but never in the GART table. So I think the long-term goal should
      be to remove the need to allocate GART addresses for system memory
      BOs. Then you could get away with a quite small GART size.<br>
    </p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>=C2=A0 Felix<br>
    </p>
    <br>
    <div class=3D"moz-cite-prefix">On 16-07-21 08:04 AM, Christian K=C3=B6=
nig
      wrote:<br>
    </div>
    <blockquote
      cite=3D"mid:3839ef42-6275-99d8-9aee-54143a971f0b-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Du=
tf-8">
      <div class=3D"moz-cite-prefix">
        <blockquote type=3D"cite">
          <p>we can add people in if necessary here. so the initial
            though of this change is with latest big memory GPU
            released, the remote memory goes very large, like Polaris10.<=
/p>
          <p>According to the windows WDDM, remote memory size is=C2=A0ha=
lf
            of the system memory, I don't know what was discussed
            before, Please let me know if there're use case indeed need
            that big of remote memory.</p>
        </blockquote>
        Well that is at least something that makes sense.<br>
        <br>
        Previous discussions where always settled around making GART
        bigger than VRAM and not the other way around.<br>
        <br>
        Anyway I think a prerequisite to this is actually allowing half
        of system memory to be allocated for GART and I'm not sure if
        that is currently the case. TTM has a limitation for that as
        well, but I off hand don't remember how high much it was.<br>
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
        <style type=3D"text/css" style=3D"display:none;"><!-- P {margin-t=
op:0;margin-bottom:0;} --></style>
        <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
          <p>alright, I didn't realize you're not in that thread.=C2=A0</=
p>
          <p>we can add people in if necessary here. so the initial
            though of this change is with latest big memory GPU
            released, the remote memory goes very large, like Polaris10.<=
/p>
          <p>According to the windows WDDM, remote memory size is=C2=A0ha=
lf
            of the system memory, I don't know what was discussed
            before, Please let me know if there're use case indeed need
            that big of remote memory.</p>
        </div>
        <hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
        <div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11=
pt"
            color=3D"#000000" face=3D"Calibri, sans-serif"><b>=E5=8F=91=E4=
=BB=B6=E4=BA=BA:</b>
            Christian K=C3=B6nig <a moz-do-not-send=3D"true"
              class=3D"moz-txt-link-rfc2396E"
              href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple@vod=
afone.de&gt;</a><br>
            <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2016=E5=B9=B47=E6=
=9C=8821=E6=97=A5 19:48:17<br>
            <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> Wang, Qingqing; <a moz-do=
-not-send=3D"true"
              class=3D"moz-txt-link-abbreviated"
              href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists=
.freedesktop.org</a><br>
            <b>=E4=B8=BB=E9=A2=98:</b> Re: =E7=AD=94=E5=A4=8D: =E7=AD=94=E5=
=A4=8D: [PATCH] drm/amdgpu: adjust gtt memory
            size</font>
          <div>=C2=A0</div>
        </div>
        <div>
          <div class=3D"moz-cite-prefix">Am 21.07.2016 um 13:15 schrieb
            Wang, Qingqing:<br>
          </div>
          <blockquote
cite=3D"mid:SN1PR12MB051120166EEFC6A65C7BB795EC090-z7L1TMIYDg7GFhS5Ttmc/L2jyFyIFlFv@public.gmane.org=
.prod.outlook.com"
            type=3D"cite">
            <style type=3D"text/css" style=3D"display:none;"><!-- P {marg=
in-top:0;margin-bottom:0;} --></style>
            <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
              <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
                <p><span style=3D"color: rgb(33, 33, 33); font-size:
                    15px;">Actually that discussion was held long ago
                    internally but we never got a conclusion on this
                    IIRC. So we should probably continue the discussion
                    on this thread now.</span><br>
                </p>
                <p><font color=3D"#212121"><span style=3D"font-size: 15px=
;">-there
                      is a thread for this topic yesterday, some people
                      are not in amd-gfx mail list, we'd
                      better=C2=A0discuss=C2=A0in the=C2=A0internal=C2=A0=
thread.</span></font></p>
              </div>
            </div>
          </blockquote>
          No, exactly for this reason we have the public mailing list. I
          for example wasn't part of the internal thread either.<br>
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
              <hr style=3D"display:inline-block;width:98%" tabindex=3D"-1=
">
              <div id=3D"divRplyFwdMsg" dir=3D"ltr"><font
                  style=3D"font-size:11pt" color=3D"#000000" face=3D"Cali=
bri,
                  sans-serif"><b>=E5=8F=91=E4=BB=B6=E4=BA=BA:</b> Christi=
an K=C3=B6nig <a
                    moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc239=
6E"
                    href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimp=
le-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                  <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2016=E5=B9=
=B47=E6=9C=8821=E6=97=A5 17:48:41<br>
                  <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> Wang, Qingqing; <a =
moz-do-not-send=3D"true"
                    class=3D"moz-txt-link-abbreviated"
                    href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                    amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>=E4=B8=BB=E9=A2=98:</b> Re: =E7=AD=94=E5=A4=8D: [PAT=
CH] drm/amdgpu: adjust gtt
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
                  <meta name=3D"Generator" content=3D"Microsoft Exchange
                    Server">
                  <!-- converted from text -->
                  <meta content=3D"text/html; charset=3DUTF-8">
                  <div dir=3D"ltr">
                    <div id=3D"x_divtagdefaultwrapper"
                      style=3D"font-size:12pt; color:#000000;
                      background-color:#FFFFFF;
                      font-family:Calibri,Arial,Helvetica,sans-serif">
                      <p><font size=3D"2"><span style=3D"font-size:10pt">=
This
                            doesn't work on 32bit systems since totalram
                            is a long (IIRC) and <br>
                            so this will certainly overflow.</span></font=
></p>
                      <p>-- can you be more specific, how could the
                        overflow happen?</p>
                    </div>
                  </div>
                </blockquote>
                <br>
                Both values are 32bit on a 32bit system, so as soon as
                you have more than 4GB installed this will overflow.<br>
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
                      font-family:Calibri,Arial,Helvetica,sans-serif">
                      <p><br>
                      </p>
                      <p><font size=3D"2"><span style=3D"font-size:10pt">=
Additional
                            if I remember correctly we didn't ended the
                            discussion on <br>
                            what to do here with a conclusion.</span></fo=
nt></p>
                      <p>-- ok, since it happens in anther mail list, we
                        should stop talking about it here, you can send
                        out your ideas there.<br>
                      </p>
                    </div>
                  </div>
                </blockquote>
                <br>
                Actually that discussion was held long ago internally
                but we never got a conclusion on this IIRC. So we should
                probably continue the discussion on this thread now.<br>
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
                      font-family:Calibri,Arial,Helvetica,sans-serif"> </=
div>
                    <hr tabindex=3D"-1" style=3D"display:inline-block;
                      width:98%">
                    <div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font
                        style=3D"font-size:11pt" color=3D"#000000"
                        face=3D"Calibri, sans-serif"><b>=E5=8F=91=E4=BB=B6=
=E4=BA=BA:</b> amd-gfx <a
                          moz-do-not-send=3D"true"
                          class=3D"moz-txt-link-rfc2396E"
                          href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org">
                          &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</=
a>
                        =E4=BB=A3=E8=A1=A8 Christian K=C3=B6nig <a moz-do=
-not-send=3D"true"
                          class=3D"moz-txt-link-rfc2396E"
                          href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">
                          &lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                        <b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:</b> 2016=
=E5=B9=B47=E6=9C=8821=E6=97=A5 16:53:05<br>
                        <b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b> Wang, Qingqin=
g; <a
                          moz-do-not-send=3D"true"
                          class=3D"moz-txt-link-abbreviated"
                          href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                          amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                        <b>=E4=B8=BB=E9=A2=98:</b> Re: [PATCH] drm/amdgpu=
: adjust gtt
                        memory size</font>
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
                        &gt;=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v=
7_0.c | 7
                        ++++++-<br>
                        &gt;=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/gmc_v=
8_0.c | 7
                        ++++++-<br>
                        &gt;=C2=A0=C2=A0 2 files changed, 12 insertions(+=
), 2
                        deletions(-)<br>
                        &gt;<br>
                        &gt; diff --git
                        a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
                        b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
                        &gt; index a3b6048..0b095d5 100644<br>
                        &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<=
br>
                        &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<=
br>
                        &gt; @@ -336,6 +336,11 @@ static int
                        gmc_v7_0_mc_init(struct amdgpu_device *adev)<br>
                        &gt;=C2=A0=C2=A0 {<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u3=
2 tmp;<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t chansize, numchan;<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 u64 sysmem_size;<b=
r>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 struct sysinfo si;=
<br>
                        &gt; +<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 si_meminfo(&amp;si=
);<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 sysmem_size =3D si=
.totalram *
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
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Get VRAM informations */<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tm=
p =3D RREG32(mmMC_ARB_RAMCFG);<br>
                        &gt; @@ -392,7 +397,7 @@ static int
                        gmc_v7_0_mc_init(struct amdgpu_device *adev)<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * size equal to the 1024 or vram,
                        whichever is larger.<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (amdgpu_gart_size =3D=3D -1)<br>
                        &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                        max((1024ULL &lt;&lt; 20),
                        adev-&gt;mc.mc_vram_size);<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                        max((1024ULL &lt;&lt; 20),
                        min(adev-&gt;mc.mc_vram_size, sysmem_size/2));<br=
>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                        (uint64_t)amdgpu_gart_size &lt;&lt; 20;<br>
                        &gt;=C2=A0=C2=A0 <br>
                        &gt; diff --git
                        a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
                        b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
                        &gt; index 02b6872..790bf7a 100644<br>
                        &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<=
br>
                        &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<=
br>
                        &gt; @@ -413,6 +413,11 @@ static int
                        gmc_v8_0_mc_init(struct amdgpu_device *adev)<br>
                        &gt;=C2=A0=C2=A0 {<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u3=
2 tmp;<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t chansize, numchan;<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 u64 sysmem_size;<b=
r>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 struct sysinfo si;=
<br>
                        &gt; +<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 si_meminfo(&amp;si=
);<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0 sysmem_size =3D si=
.totalram *
                        si.mem_unit;<br>
                        &gt;=C2=A0=C2=A0 <br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 Get VRAM informations */<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tm=
p =3D RREG32(mmMC_ARB_RAMCFG);<br>
                        &gt; @@ -469,7 +474,7 @@ static int
                        gmc_v8_0_mc_init(struct amdgpu_device *adev)<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * size equal to the 1024 or vram,
                        whichever is larger.<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (amdgpu_gart_size =3D=3D -1)<br>
                        &gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                        max((1024ULL &lt;&lt; 20),
                        adev-&gt;mc.mc_vram_size);<br>
                        &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                        max((1024ULL &lt;&lt; 20),
                        min(adev-&gt;mc.mc_vram_size, sysmem_size/2));<br=
>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se<br>
                        &gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;mc.gtt_size =3D
                        (uint64_t)amdgpu_gart_size &lt;&lt; 20;<br>
                        &gt;=C2=A0=C2=A0 <br>
                        <br>
                        <br>
                        _______________________________________________<b=
r>
                        amd-gfx mailing list<br>
                        <a moz-do-not-send=3D"true"
                          class=3D"moz-txt-link-abbreviated"
                          href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                        <a moz-do-not-send=3D"true"
                          href=3D"https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</=
a><br>
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
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/=
mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/=
amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------7E393F8687DEE3C8A0076110--

--===============1167215699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1167215699==--
