From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: increase timeout of IB test
Date: Tue, 26 Jul 2016 15:40:22 +0800
Message-ID: <579713E6.2040805@amd.com>
References: <1469512669-13954-1-git-send-email-David1.Zhou@amd.com>
 <7ab14e56-0a68-3435-f686-d5b20f9b7eae@vodafone.de> <5797112A.2000200@amd.com>
 <46261ccd-61dd-0fc5-ba9d-eaafb40da038@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0396276130=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <46261ccd-61dd-0fc5-ba9d-eaafb40da038-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0396276130==
Content-Type: multipart/alternative;
	boundary="------------010903070007040906040008"

--------------010903070007040906040008
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2016=E5=B9=B407=E6=9C=8826=E6=97=A5 15:32, Christian K=C3=B6nig wrote:
> Ok, I really wasn't expecting this. How about 100ms?
I tried it just now, 100ms isn't enough as well, see the append log.

>
> I just want to avoid that a reset takes more than 1 or 2 seconds even=20
> when it didn't worked.
>
> With 1 second timeout for each IB test we easily need 10+ seconds when=20
> the hardware doesn't response at all.
This isn't true, when anyone of them timeout happens,=20
amdgpu_ib_ring_tests will return error.

[   59.286927] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx=20
timeout, last signaled seq=3D30397, last emitted seq=3D30399
[   59.287253] [drm] IP block:1 is hang!
[   59.287262] [drm] IP block:5 is hang!
[   59.288375] [drm] Some block need full reset!
[   59.288385] pp_set_clockgating_state was not implemented.
[   59.343335] amdgpu 0000:03:00.0: GPU pci config reset
[   59.422762] amdgpu 0000:03:00.0: GPU reset succeeded, trying to resume
[   59.423971] [drm] PCIE GART of 4096M enabled (table at=20
0x0000000000040000).
[   59.433374] current thermal is out of range
[   59.436736] [drm] ring test on 0 succeeded in 14 usecs
[   59.437341] [drm] ring test on 1 succeeded in 27 usecs
[   59.437388] [drm] ring test on 2 succeeded in 23 usecs
[   59.437399] [drm] ring test on 3 succeeded in 5 usecs
[   59.437405] [drm] ring test on 4 succeeded in 2 usecs
[   59.437412] [drm] ring test on 5 succeeded in 2 usecs
[   59.437420] [drm] ring test on 6 succeeded in 3 usecs
[   59.437429] [drm] ring test on 7 succeeded in 3 usecs
[   59.437435] [drm] ring test on 8 succeeded in 2 usecs
[   59.437493] [drm] ring test on 9 succeeded in 6 usecs
[   59.437501] [drm] ring test on 10 succeeded in 6 usecs
[   59.464320] [drm] ring test on 11 succeeded in 2 usecs
[   59.464322] [drm] UVD initialized successfully.
[   59.564307] [drm] ring test on 12 succeeded in 14 usecs
[   59.564316] [drm] ring test on 13 succeeded in 3 usecs
[   59.564317] [drm] VCE initialized successfully.
[   59.662835] [drm:gfx_v8_0_ring_test_ib [amdgpu]] *ERROR* amdgpu: IB=20
test timed out.
[   59.663030] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* amdgpu:=20
failed testing IB on GFX ring (-110).
[   59.663227] amdgpu 0000:03:00.0: ib ring test failed (-110).
[   59.663349] pp_set_clockgating_state was not implemented.
[   59.749358] amdgpu 0000:03:00.0: GPU pci config reset
[   59.830784] amdgpu 0000:03:00.0: GPU reset succeeded, trying to resume
[   59.831982] [drm] PCIE GART of 4096M enabled (table at=20
0x0000000000040000).
[   59.841412] current thermal is out of range
[   59.844763] [drm] ring test on 0 succeeded in 14 usecs
[   59.845341] [drm] ring test on 1 succeeded in 27 usecs
[   59.845385] [drm] ring test on 2 succeeded in 21 usecs
[   59.845397] [drm] ring test on 3 succeeded in 5 usecs
[   59.845406] [drm] ring test on 4 succeeded in 3 usecs
[   59.845412] [drm] ring test on 5 succeeded in 2 usecs
[   59.845421] [drm] ring test on 6 succeeded in 3 usecs
[   59.845429] [drm] ring test on 7 succeeded in 3 usecs
[   59.845435] [drm] ring test on 8 succeeded in 2 usecs
[   59.845493] [drm] ring test on 9 succeeded in 6 usecs
[   59.845500] [drm] ring test on 10 succeeded in 6 usecs
[   59.872362] [drm] ring test on 11 succeeded in 2 usecs
[   59.872363] [drm] UVD initialized successfully.
root@zhoucm1-System-Product-Name:~# dmesg -c
[   59.971707] [drm] ring test on 12 succeeded in 14 usecs
[   59.971717] [drm] ring test on 13 succeeded in 3 usecs
[   59.971717] [drm] VCE initialized successfully.
[   60.070820] [drm:gfx_v8_0_ring_test_ib [amdgpu]] *ERROR* amdgpu: IB=20
test timed out.
[   60.071051] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* amdgpu:=20
failed testing IB on GFX ring (-110).
[   60.071252] amdgpu 0000:03:00.0: ib ring test failed (-110).
[   60.071375] pp_set_clockgating_state was not implemented.
[   60.151397] amdgpu 0000:03:00.0: GPU pci config reset
[   60.230844] amdgpu 0000:03:00.0: GPU reset succeeded, trying to resume
[   60.232044] [drm] PCIE GART of 4096M enabled (table at=20
0x0000000000040000).
[   60.241412] current thermal is out of range
[   60.244746] [drm] ring test on 0 succeeded in 13 usecs
[   60.245322] [drm] ring test on 1 succeeded in 27 usecs
[   60.245368] [drm] ring test on 2 succeeded in 23 usecs
[   60.245380] [drm] ring test on 3 succeeded in 5 usecs
[   60.245386] [drm] ring test on 4 succeeded in 2 usecs
[   60.245393] [drm] ring test on 5 succeeded in 2 usecs
[   60.245402] [drm] ring test on 6 succeeded in 3 usecs

>
> Regards,
> Christian.
>
> Am 26.07.2016 um 09:28 schrieb zhoucm1:
>> CQE has found timeout when they cherry-pick your timeout patch.
>> I also found ib_test could be timeout after gpu reset.
>> 1s maybe too long for a simple testing command, but I just think that=20
>> doesn't matter to judge timeout.
>>
>> Regards,
>> David
>>
>> On 2016=E5=B9=B407=E6=9C=8826=E6=97=A5 15:24, Christian K=C3=B6nig wro=
te:
>>> Am 26.07.2016 um 07:57 schrieb Chunming Zhou:
>>>> we should give enough time to IB test.
>>>>
>>>> Change-Id: I92bfbe9b3aa35083f41baed8663907abfa15c8e6
>>>> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
>>>
>>> Do we really need more than 10ms for an IB test? A whole second=20
>>> sounds awful long when we need to do 10+ tests currently.
>>>
>>> Christian.
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c=20
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> index 050062e..a31d7ef 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> @@ -33,7 +33,7 @@
>>>>   #include "amdgpu.h"
>>>>   #include "atom.h"
>>>>   -#define AMDGPU_IB_TEST_TIMEOUT    msecs_to_jiffies(10)
>>>> +#define AMDGPU_IB_TEST_TIMEOUT    msecs_to_jiffies(1000)
>>>>     /*
>>>>    * IB
>>>
>>>
>>
>


--------------010903070007040906040008
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <br>
    <div class=3D"moz-cite-prefix">On 2016=E5=B9=B407=E6=9C=8826=E6=97=A5=
 15:32, Christian K=C3=B6nig
      wrote:<br>
    </div>
    <blockquote
      cite=3D"mid:46261ccd-61dd-0fc5-ba9d-eaafb40da038-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type=3D"cite">Ok, I really wasn't expecting this. How about 100ms?
      <br>
    </blockquote>
    I tried it just now, 100ms isn't enough as well, see the append log.<=
br>
    <br>
    <blockquote
      cite=3D"mid:46261ccd-61dd-0fc5-ba9d-eaafb40da038-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type=3D"cite">
      <br>
      I just want to avoid that a reset takes more than 1 or 2 seconds
      even when it didn't worked.
      <br>
      <br>
      With 1 second timeout for each IB test we easily need 10+ seconds
      when the hardware doesn't response at all.
      <br>
    </blockquote>
    This isn't true, when anyone of them timeout happens,
    amdgpu_ib_ring_tests will return error.<br>
    <br>
    [=C2=A0=C2=A0 59.286927] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* r=
ing gfx
    timeout, last signaled seq=3D30397, last emitted seq=3D30399<br>
    [=C2=A0=C2=A0 59.287253] [drm] IP block:1 is hang!<br>
    [=C2=A0=C2=A0 59.287262] [drm] IP block:5 is hang!<br>
    [=C2=A0=C2=A0 59.288375] [drm] Some block need full reset!<br>
    [=C2=A0=C2=A0 59.288385] pp_set_clockgating_state was not implemented=
.<br>
    [=C2=A0=C2=A0 59.343335] amdgpu 0000:03:00.0: GPU pci config reset<br=
>
    [=C2=A0=C2=A0 59.422762] amdgpu 0000:03:00.0: GPU reset succeeded, tr=
ying to
    resume<br>
    [=C2=A0=C2=A0 59.423971] [drm] PCIE GART of 4096M enabled (table at
    0x0000000000040000).<br>
    [=C2=A0=C2=A0 59.433374] current thermal is out of range <br>
    [=C2=A0=C2=A0 59.436736] [drm] ring test on 0 succeeded in 14 usecs<b=
r>
    [=C2=A0=C2=A0 59.437341] [drm] ring test on 1 succeeded in 27 usecs<b=
r>
    [=C2=A0=C2=A0 59.437388] [drm] ring test on 2 succeeded in 23 usecs<b=
r>
    [=C2=A0=C2=A0 59.437399] [drm] ring test on 3 succeeded in 5 usecs<br=
>
    [=C2=A0=C2=A0 59.437405] [drm] ring test on 4 succeeded in 2 usecs<br=
>
    [=C2=A0=C2=A0 59.437412] [drm] ring test on 5 succeeded in 2 usecs<br=
>
    [=C2=A0=C2=A0 59.437420] [drm] ring test on 6 succeeded in 3 usecs<br=
>
    [=C2=A0=C2=A0 59.437429] [drm] ring test on 7 succeeded in 3 usecs<br=
>
    [=C2=A0=C2=A0 59.437435] [drm] ring test on 8 succeeded in 2 usecs<br=
>
    [=C2=A0=C2=A0 59.437493] [drm] ring test on 9 succeeded in 6 usecs<br=
>
    [=C2=A0=C2=A0 59.437501] [drm] ring test on 10 succeeded in 6 usecs<b=
r>
    [=C2=A0=C2=A0 59.464320] [drm] ring test on 11 succeeded in 2 usecs<b=
r>
    [=C2=A0=C2=A0 59.464322] [drm] UVD initialized successfully.<br>
    [=C2=A0=C2=A0 59.564307] [drm] ring test on 12 succeeded in 14 usecs<=
br>
    [=C2=A0=C2=A0 59.564316] [drm] ring test on 13 succeeded in 3 usecs<b=
r>
    [=C2=A0=C2=A0 59.564317] [drm] VCE initialized successfully.<br>
    <font color=3D"#ff0000">[=C2=A0=C2=A0 59.662835] [drm:gfx_v8_0_ring_t=
est_ib
      [amdgpu]] *ERROR* amdgpu: IB test timed out.<br>
      [=C2=A0=C2=A0 59.663030] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR=
* amdgpu:
      failed testing IB on GFX ring (-110).</font><br>
    [=C2=A0=C2=A0 59.663227] amdgpu 0000:03:00.0: ib ring test failed (-1=
10).<br>
    [=C2=A0=C2=A0 59.663349] pp_set_clockgating_state was not implemented=
.<br>
    [=C2=A0=C2=A0 59.749358] amdgpu 0000:03:00.0: GPU pci config reset<br=
>
    [=C2=A0=C2=A0 59.830784] amdgpu 0000:03:00.0: GPU reset succeeded, tr=
ying to
    resume<br>
    [=C2=A0=C2=A0 59.831982] [drm] PCIE GART of 4096M enabled (table at
    0x0000000000040000).<br>
    [=C2=A0=C2=A0 59.841412] current thermal is out of range <br>
    [=C2=A0=C2=A0 59.844763] [drm] ring test on 0 succeeded in 14 usecs<b=
r>
    [=C2=A0=C2=A0 59.845341] [drm] ring test on 1 succeeded in 27 usecs<b=
r>
    [=C2=A0=C2=A0 59.845385] [drm] ring test on 2 succeeded in 21 usecs<b=
r>
    [=C2=A0=C2=A0 59.845397] [drm] ring test on 3 succeeded in 5 usecs<br=
>
    [=C2=A0=C2=A0 59.845406] [drm] ring test on 4 succeeded in 3 usecs<br=
>
    [=C2=A0=C2=A0 59.845412] [drm] ring test on 5 succeeded in 2 usecs<br=
>
    [=C2=A0=C2=A0 59.845421] [drm] ring test on 6 succeeded in 3 usecs<br=
>
    [=C2=A0=C2=A0 59.845429] [drm] ring test on 7 succeeded in 3 usecs<br=
>
    [=C2=A0=C2=A0 59.845435] [drm] ring test on 8 succeeded in 2 usecs<br=
>
    [=C2=A0=C2=A0 59.845493] [drm] ring test on 9 succeeded in 6 usecs<br=
>
    [=C2=A0=C2=A0 59.845500] [drm] ring test on 10 succeeded in 6 usecs<b=
r>
    [=C2=A0=C2=A0 59.872362] [drm] ring test on 11 succeeded in 2 usecs<b=
r>
    [=C2=A0=C2=A0 59.872363] [drm] UVD initialized successfully.<br>
    root@zhoucm1-System-Product-Name:~# dmesg -c<br>
    [=C2=A0=C2=A0 59.971707] [drm] ring test on 12 succeeded in 14 usecs<=
br>
    [=C2=A0=C2=A0 59.971717] [drm] ring test on 13 succeeded in 3 usecs<b=
r>
    [=C2=A0=C2=A0 59.971717] [drm] VCE initialized successfully.<br>
    <font color=3D"#ff0000">[=C2=A0=C2=A0 60.070820] [drm:gfx_v8_0_ring_t=
est_ib
      [amdgpu]] *ERROR* amdgpu: IB test timed out.<br>
      [=C2=A0=C2=A0 60.071051] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR=
* amdgpu:
      failed testing IB on GFX ring (-110).</font><br>
    [=C2=A0=C2=A0 60.071252] amdgpu 0000:03:00.0: ib ring test failed (-1=
10).<br>
    [=C2=A0=C2=A0 60.071375] pp_set_clockgating_state was not implemented=
.<br>
    [=C2=A0=C2=A0 60.151397] amdgpu 0000:03:00.0: GPU pci config reset<br=
>
    [=C2=A0=C2=A0 60.230844] amdgpu 0000:03:00.0: GPU reset succeeded, tr=
ying to
    resume<br>
    [=C2=A0=C2=A0 60.232044] [drm] PCIE GART of 4096M enabled (table at
    0x0000000000040000).<br>
    [=C2=A0=C2=A0 60.241412] current thermal is out of range <br>
    [=C2=A0=C2=A0 60.244746] [drm] ring test on 0 succeeded in 13 usecs<b=
r>
    [=C2=A0=C2=A0 60.245322] [drm] ring test on 1 succeeded in 27 usecs<b=
r>
    [=C2=A0=C2=A0 60.245368] [drm] ring test on 2 succeeded in 23 usecs<b=
r>
    [=C2=A0=C2=A0 60.245380] [drm] ring test on 3 succeeded in 5 usecs<br=
>
    [=C2=A0=C2=A0 60.245386] [drm] ring test on 4 succeeded in 2 usecs<br=
>
    [=C2=A0=C2=A0 60.245393] [drm] ring test on 5 succeeded in 2 usecs<br=
>
    [=C2=A0=C2=A0 60.245402] [drm] ring test on 6 succeeded in 3 usecs<br=
>
    <br>
    <blockquote
      cite=3D"mid:46261ccd-61dd-0fc5-ba9d-eaafb40da038-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
      type=3D"cite">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      Am 26.07.2016 um 09:28 schrieb zhoucm1:
      <br>
      <blockquote type=3D"cite">CQE has found timeout when they
        cherry-pick your timeout patch.
        <br>
        I also found ib_test could be timeout after gpu reset.
        <br>
        1s maybe too long for a simple testing command, but I just think
        that doesn't matter to judge timeout.
        <br>
        <br>
        Regards,
        <br>
        David
        <br>
        <br>
        On 2016=E5=B9=B407=E6=9C=8826=E6=97=A5 15:24, Christian K=C3=B6ni=
g wrote:
        <br>
        <blockquote type=3D"cite">Am 26.07.2016 um 07:57 schrieb Chunming
          Zhou:
          <br>
          <blockquote type=3D"cite">we should give enough time to IB test=
.
            <br>
            <br>
            Change-Id: I92bfbe9b3aa35083f41baed8663907abfa15c8e6
            <br>
            Signed-off-by: Chunming Zhou <a class=3D"moz-txt-link-rfc2396=
E" href=3D"mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>
            <br>
          </blockquote>
          <br>
          Do we really need more than 10ms for an IB test? A whole
          second sounds awful long when we need to do 10+ tests
          currently.
          <br>
          <br>
          Christian.
          <br>
          <br>
          <blockquote type=3D"cite">---
            <br>
            =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
            <br>
            =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
            <br>
            index 050062e..a31d7ef 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
            <br>
            @@ -33,7 +33,7 @@
            <br>
            =C2=A0 #include "amdgpu.h"
            <br>
            =C2=A0 #include "atom.h"
            <br>
            =C2=A0 -#define AMDGPU_IB_TEST_TIMEOUT=C2=A0=C2=A0=C2=A0 msec=
s_to_jiffies(10)
            <br>
            +#define AMDGPU_IB_TEST_TIMEOUT=C2=A0=C2=A0=C2=A0 msecs_to_ji=
ffies(1000)
            <br>
            =C2=A0=C2=A0=C2=A0 /*
            <br>
            =C2=A0=C2=A0 * IB
            <br>
          </blockquote>
          <br>
          <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------010903070007040906040008--

--===============0396276130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0396276130==--
