From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Regression on gfx8 with ring init
Date: Fri, 21 Sep 2018 14:04:28 -0400
Message-ID: <b697d918-062c-79c8-21ea-b21b5b04f1b7@amd.com>
References: <8cdb037b-7db7-9be9-2c8a-d52c1b058454@amd.com>
 <7f748397-265d-20e9-b081-108b28994c1f@gmail.com>
 <1fdbd1f8-afb8-59e7-c057-10da9b9f6e25@amd.com>
 <80d8437f-0873-8318-01c1-2710adea67e0@amd.com>
 <aa62adca-48cb-fb3c-65ac-7d2e3311d602@amd.com>
 <43e69bf1-8751-dbe8-6b8d-5250c527154c@amd.com>
 <34359f9e-be6f-945c-e084-c109e6584d67@amd.com>
 <12ac8b66-0ce2-0304-d9ad-6e3f2479e04f@amd.com>
 <3ad24617-bdee-846e-b47c-d854c48fce43@amd.com>
 <BN6PR12MB1809B0E02DDA1E8AACFFD1DAF71D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <4a250398-d2ac-1650-739d-e4a6598f1c48@gmail.com>
 <edd44be9-2ef3-3c39-3342-5d3b4bbfa40a@amd.com>
 <4afeb01c-37e9-ca76-8055-5dd15fca98d3@amd.com>
 <c81338de-5fc7-3be3-961a-bba0eba05351@amd.com>
 <04944e7b-044b-4b16-3d2f-e760eedcee9a@gmail.com>
 <681ddd4e-6bd2-db28-4286-2cc577d0f00a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1065349509=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <681ddd4e-6bd2-db28-4286-2cc577d0f00a-5C7GfCeVMHo@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1065349509==
Content-Type: multipart/alternative;
 boundary="------------945FA6F53627828F2DC63981"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------945FA6F53627828F2DC63981
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

BTW, this also seems to be what breaks suspend/resume.


Andrey


On 09/21/2018 01:56 PM, Andrey Grodzovsky wrote:
>
> No worries, I will just revert locally until then to clear the extra 
> errors during my investigation of current GPU reset status and issues.
>
>
> Andrey
>
>
> On 09/21/2018 01:53 PM, Christian König wrote:
>> I unfortunately don't have a Polaris to test this myself.
>>
>> But please give me time till Monday so that I can at least try one 
>> more things to fix it.
>>
>> Christian.
>>
>> Am 21.09.2018 um 19:11 schrieb Andrey Grodzovsky:
>>>
>>> Ping...
>>>
>>>
>>> Andrey
>>>
>>>
>>> On 09/20/2018 04:35 PM, Andrey Grodzovsky wrote:
>>>>
>>>> What's the status with this error and the suggested patch to fix it 
>>>> ? It impacts GPU reset on Polaris11.
>>>>
>>>> Do we want to investigate why the original patch breaks it or just 
>>>> disable with the proposed patch ?
>>>>
>>>>
>>>> P.S Suspend resume also stopped working on latest branch - will 
>>>> bisect it later today or tomorrow.
>>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>> On 09/18/2018 11:00 AM, Christian König wrote:
>>>>> Tom,
>>>>>
>>>>> can you try if the following makes it working again?
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>>> index b6160de70d12..d65f5ba92fc5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>>> @@ -937,6 +937,10 @@ static int gfx_v8_0_ring_test_ib(struct 
>>>>> amdgpu_ring *ring, long timeout)
>>>>>         return r;
>>>>>  }
>>>>>
>>>>> +static int gfx_v8_0_kiq_ring_test_ib(struct amdgpu_ring *ring, 
>>>>> long timeout)
>>>>> +{
>>>>> +       return 0;
>>>>> +}
>>>>>
>>>>>  static void gfx_v8_0_free_microcode(struct amdgpu_device *adev)
>>>>>  {
>>>>> @@ -7174,7 +7178,7 @@ static const struct amdgpu_ring_funcs 
>>>>> gfx_v8_0_ring_funcs_kiq = {
>>>>>         .emit_ib = gfx_v8_0_ring_emit_ib_compute,
>>>>>         .emit_fence = gfx_v8_0_ring_emit_fence_kiq,
>>>>>         .test_ring = gfx_v8_0_ring_test_ring,
>>>>> -       .test_ib = gfx_v8_0_ring_test_ib,
>>>>> +       .test_ib = gfx_v8_0_kiq_ring_test_ib,
>>>>>         .insert_nop = amdgpu_ring_insert_nop,
>>>>>         .pad_ib = amdgpu_ring_generic_pad_ib,
>>>>>         .emit_rreg = gfx_v8_0_ring_emit_rreg,
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Christian.
>>>>>
>>>>> Am 18.09.2018 um 16:41 schrieb Christian König:
>>>>>> CRTC and GFX interrupts seem to be working perfectly fine.
>>>>>>
>>>>>> The problem here looks like only EOP interrupts from the Compute 
>>>>>> queue are not correctly handled.
>>>>>>
>>>>>> Most likely a bug somewhere in gfx_v8_0_eop_irq().
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>> Am 18.09.2018 um 16:36 schrieb Deucher, Alexander:
>>>>>>>
>>>>>>> FWIW, a number of consumer Raven boards have bad IVRS tables 
>>>>>>> (windows doesn't use interrupt remapping so they are sometimes 
>>>>>>> wrong and probably not validated.  There are a number of 
>>>>>>> workaround to manually override the IVRS tables to make 
>>>>>>> interrupts work.  I think specifying pci=noacpi is also a 
>>>>>>> possible workaround.
>>>>>>>
>>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>> ------------------------------------------------------------------------
>>>>>>> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on 
>>>>>>> behalf of Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>> *Sent:* Tuesday, September 18, 2018 10:31:16 AM
>>>>>>> *To:* StDenis, Tom; amd-gfx mailing list; Zhou, David(ChunMing)
>>>>>>> *Subject:* Re: Regression on gfx8 with ring init
>>>>>>> Well looks like interrupt processing is working perfectly fine.
>>>>>>>
>>>>>>> But looking at the error message once more I see that this actually
>>>>>>> affects ring number 9 and not the GFX ring.
>>>>>>>
>>>>>>> Can you fix amdgpu_ib_ring_tests() to print ring->name instead 
>>>>>>> of the
>>>>>>> number?
>>>>>>>
>>>>>>> That must be some of the compute rings.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Christian.
>>>>>>>
>>>>>>> Am 18.09.2018 um 16:20 schrieb Tom St Denis:
>>>>>>> > On 2018-09-18 10:13 a.m., Christian König wrote:
>>>>>>> >> Mhm, there is no more failed IB-test in there isn't it?
>>>>>>> >
>>>>>>> > oh sorry I thought you wanted to test HEAD~ ... Attached is a 
>>>>>>> log from
>>>>>>> > the tip of drm-next
>>>>>>> >
>>>>>>> > Tom
>>>>>>> >
>>>>>>> >>
>>>>>>> >> Christian.
>>>>>>> >>
>>>>>>> >> Am 18.09.2018 um 16:09 schrieb Tom St Denis:
>>>>>>> >>> Disabling IOMMU in the BIOS resulted in a correct boot up...
>>>>>>> >>>
>>>>>>> >>> Here's the log.
>>>>>>> >>>
>>>>>>> >>> Tom
>>>>>>> >>>
>>>>>>> >>> On 2018-09-18 9:58 a.m., Tom St Denis wrote:
>>>>>>> >>>> Odd I couldn't even boot my system with the dGPU as primary 
>>>>>>> after
>>>>>>> >>>> rebuilding the kernel.  It got hung up in the IOMMU driver 
>>>>>>> (loads
>>>>>>> >>>> of AMD-Vi IOMMU errors) which I wasn't able to capture 
>>>>>>> because it
>>>>>>> >>>> panic'ed before loading the network stack.
>>>>>>> >>>>
>>>>>>> >>>> Bizarre.
>>>>>>> >>>>
>>>>>>> >>>> I'll keep trying.
>>>>>>> >>>>
>>>>>>> >>>> Tom
>>>>>>> >>>>
>>>>>>> >>>> On 2018-09-18 9:35 a.m., Christian König wrote:
>>>>>>> >>>>> Am 18.09.2018 um 15:32 schrieb Tom St Denis:
>>>>>>> >>>>>> On 2018-09-18 9:30 a.m., Christian König wrote:
>>>>>>> >>>>>>> Great, not sure if that is a good or a bad news.
>>>>>>> >>>>>>>
>>>>>>> >>>>>>> Anyway going to revert the change for now. Does anybody
>>>>>>> >>>>>>> volunteer to figure out why interrupts sometimes doesn't 
>>>>>>> work
>>>>>>> >>>>>>> correctly on Raven?
>>>>>>> >>>>>>
>>>>>>> >>>>>> What does "doesn't work correctly?"  My workstation is a 
>>>>>>> Raven1
>>>>>>> >>>>>> (Ryzen 2400G) and other than the TTM bulk move issue has 
>>>>>>> been
>>>>>>> >>>>>> perfectly stable (through suspend/resumes too I might add).
>>>>>>> >>>>>>
>>>>>>> >>>>>> Anything I could test with my devel raven?
>>>>>>> >>>>>
>>>>>>> >>>>> The problem seems to be that on some boards IH handling 
>>>>>>> doesn't
>>>>>>> >>>>> work as it should.
>>>>>>> >>>>>
>>>>>>> >>>>> Can you try to disable the onboard graphics and try again?
>>>>>>> >>>>>
>>>>>>> >>>>> If that still doesn't work there is a DRM_DEBUG in
>>>>>>> >>>>> amdgpu_ih_process(), make that a DRM_ERROR and send me the
>>>>>>> >>>>> resulting dmesg of loading amdgpu (but don't start any UMD).
>>>>>>> >>>>>
>>>>>>> >>>>> Thanks,
>>>>>>> >>>>> Christian.
>>>>>>> >>>>>
>>>>>>> >>>>>>
>>>>>>> >>>>>>
>>>>>>> >>>>>> Tom
>>>>>>> >>>>>>
>>>>>>> >>>>>>>
>>>>>>> >>>>>>> Christian.
>>>>>>> >>>>>>>
>>>>>>> >>>>>>> Am 18.09.2018 um 15:27 schrieb Tom St Denis:
>>>>>>> >>>>>>>> This commit:
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>> [root@raven linux]# git bisect good
>>>>>>> >>>>>>>> 9b0df0937a852d299fbe42a5939c9a8a4cc83c55 is the first 
>>>>>>> bad commit
>>>>>>> >>>>>>>> commit 9b0df0937a852d299fbe42a5939c9a8a4cc83c55
>>>>>>> >>>>>>>> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>> >>>>>>>> Date:   Tue Sep 18 10:38:09 2018 +0200
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>> drm/amdgpu: remove fence fallback
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>>     DC doesn't seem to have a fallback path either.
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>>     So when interrupts doesn't work any more we are 
>>>>>>> pretty much
>>>>>>> >>>>>>>> busted no
>>>>>>> >>>>>>>>     matter what.
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>>>>> >>>>>>>> Reviewed-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>> Results in this:
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>> [ 24.334025] [drm] Initialized amdgpu 3.27.0 20150101 for
>>>>>>> >>>>>>>> 0000:07:00.0 on minor 1
>>>>>>> >>>>>>>> [ 24.335674] modprobe (3895) used greatest stack depth: 
>>>>>>> 12600
>>>>>>> >>>>>>>> bytes left
>>>>>>> >>>>>>>> [ 26.272358] [drm:gfx_v8_0_ring_test_ib [amdgpu]] *ERROR*
>>>>>>> >>>>>>>> amdgpu: IB test timed out.
>>>>>>> >>>>>>>> [ 26.272460] [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR*
>>>>>>> >>>>>>>> amdgpu: failed testing IB on ring 9 (-110).
>>>>>>> >>>>>>>> [ 26.407885] [drm:process_one_work] *ERROR* ib ring test
>>>>>>> >>>>>>>> failed (-110).
>>>>>>> >>>>>>>> [ 28.506708] fuse init (API version 7.27)
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>> On init with my polaris/raven1 system.
>>>>>>> >>>>>>>>
>>>>>>> >>>>>>>> Cheers,
>>>>>>> >>>>>>>> Tom
>>>>>>> >>>>>>>> _______________________________________________
>>>>>>> >>>>>>>> amd-gfx mailing list
>>>>>>> >>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>> >>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>> >>>>>>>
>>>>>>> >>>>>>
>>>>>>> >>>>>
>>>>>>> >>>>
>>>>>>> >>>
>>>>>>> >>
>>>>>>> >
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> amd-gfx mailing list
>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> amd-gfx mailing list
>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
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
>


--------------945FA6F53627828F2DC63981
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>BTW, this also seems to be what breaks suspend/resume.<br>
    </p>
    <p><br>
    </p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 09/21/2018 01:56 PM, Andrey
      Grodzovsky wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:681ddd4e-6bd2-db28-4286-2cc577d0f00a-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <p>No worries, I will just revert locally until then to clear the
        extra errors during my investigation of current GPU reset status
        and issues.</p>
      <p><br>
      </p>
      <p>Andrey<br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 09/21/2018 01:53 PM, Christian
        König wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:04944e7b-044b-4b16-3d2f-e760eedcee9a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <div class="moz-cite-prefix">I unfortunately don't have a
          Polaris to test this myself.<br>
          <br>
          But please give me time till Monday so that I can at least try
          one more things to fix it.<br>
          <br>
          Christian.<br>
          <br>
          Am 21.09.2018 um 19:11 schrieb Andrey Grodzovsky:<br>
        </div>
        <blockquote type="cite"
          cite="mid:c81338de-5fc7-3be3-961a-bba0eba05351-5C7GfCeVMHo@public.gmane.org">
          <p>Ping...</p>
          <p><br>
          </p>
          <p>Andrey<br>
          </p>
          <br>
          <div class="moz-cite-prefix">On 09/20/2018 04:35 PM, Andrey
            Grodzovsky wrote:<br>
          </div>
          <blockquote type="cite"
            cite="mid:4afeb01c-37e9-ca76-8055-5dd15fca98d3-5C7GfCeVMHo@public.gmane.org">
            <p>What's the status with this error and the suggested patch
              to fix it ? It impacts GPU reset on Polaris11.</p>
            <p>Do we want to investigate why the original patch breaks
              it or just disable with the proposed patch ?</p>
            <p><br>
            </p>
            <p>P.S Suspend resume also stopped working on latest branch
              - will bisect it later today or tomorrow.</p>
            <p><br>
            </p>
            <p>Andrey<br>
            </p>
            <br>
            <div class="moz-cite-prefix">On 09/18/2018 11:00 AM,
              Christian König wrote:<br>
            </div>
            <blockquote type="cite"
              cite="mid:edd44be9-2ef3-3c39-3342-5d3b4bbfa40a-5C7GfCeVMHo@public.gmane.org">
              <div class="moz-cite-prefix">Tom,<br>
                <br>
                can you try if the following makes it working again?<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
                b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                index b6160de70d12..d65f5ba92fc5 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
                @@ -937,6 +937,10 @@ static int
                gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long
                timeout)<br>
                        return r;<br>
                 }<br>
                 <br>
                +static int gfx_v8_0_kiq_ring_test_ib(struct amdgpu_ring
                *ring, long timeout)<br>
                +{<br>
                +       return 0;<br>
                +}<br>
                 <br>
                 static void gfx_v8_0_free_microcode(struct
                amdgpu_device *adev)<br>
                 {<br>
                @@ -7174,7 +7178,7 @@ static const struct
                amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {<br>
                        .emit_ib = gfx_v8_0_ring_emit_ib_compute,<br>
                        .emit_fence = gfx_v8_0_ring_emit_fence_kiq,<br>
                        .test_ring = gfx_v8_0_ring_test_ring,<br>
                -       .test_ib = gfx_v8_0_ring_test_ib,<br>
                +       .test_ib = gfx_v8_0_kiq_ring_test_ib,<br>
                        .insert_nop = amdgpu_ring_insert_nop,<br>
                        .pad_ib = amdgpu_ring_generic_pad_ib,<br>
                        .emit_rreg = gfx_v8_0_ring_emit_rreg,<br>
                <br>
                <br>
                Thanks,<br>
                Christian.<br>
                <br>
                Am 18.09.2018 um 16:41 schrieb Christian König:<br>
              </div>
              <blockquote type="cite"
                cite="mid:4a250398-d2ac-1650-739d-e4a6598f1c48-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
                <div class="moz-cite-prefix">CRTC and GFX interrupts
                  seem to be working perfectly fine.<br>
                  <br>
                  The problem here looks like only EOP interrupts from
                  the Compute queue are not correctly handled.<br>
                  <br>
                  Most likely a bug somewhere in gfx_v8_0_eop_irq().<br>
                  <br>
                  Christian.<br>
                  <br>
                  Am 18.09.2018 um 16:36 schrieb Deucher, Alexander:<br>
                </div>
                <blockquote type="cite"
cite="mid:BN6PR12MB1809B0E02DDA1E8AACFFD1DAF71D0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
                  <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
                  <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
                    dir="ltr">
                    <p style="margin-top:0;margin-bottom:0">FWIW, a
                      number of consumer Raven boards have bad IVRS
                      tables (windows doesn't use interrupt remapping so
                      they are sometimes wrong and probably not
                      validated.  There are a number of workaround to
                      manually override the IVRS tables to make
                      interrupts work.  I think specifying pci=noacpi is
                      also a possible workaround.</p>
                    <p style="margin-top:0;margin-bottom:0"><br>
                    </p>
                    <p style="margin-top:0;margin-bottom:0">Alex<br>
                    </p>
                  </div>
                  <hr style="display:inline-block;width:98%"
                    tabindex="-1">
                  <div id="divRplyFwdMsg" dir="ltr"><font
                      style="font-size:11pt" face="Calibri, sans-serif"
                      color="#000000"><b>From:</b> amd-gfx <a
                        class="moz-txt-link-rfc2396E"
                        href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                        moz-do-not-send="true">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
                      on behalf of Christian König <a
                        class="moz-txt-link-rfc2396E"
                        href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                        moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                      <b>Sent:</b> Tuesday, September 18, 2018 10:31:16
                      AM<br>
                      <b>To:</b> StDenis, Tom; amd-gfx mailing list;
                      Zhou, David(ChunMing)<br>
                      <b>Subject:</b> Re: Regression on gfx8 with ring
                      init</font>
                    <div> </div>
                  </div>
                  <div class="BodyFragment"><font size="2"><span
                        style="font-size:11pt;">
                        <div class="PlainText">Well looks like interrupt
                          processing is working perfectly fine.<br>
                          <br>
                          But looking at the error message once more I
                          see that this actually <br>
                          affects ring number 9 and not the GFX ring.<br>
                          <br>
                          Can you fix amdgpu_ib_ring_tests() to print
                          ring-&gt;name instead of the <br>
                          number?<br>
                          <br>
                          That must be some of the compute rings.<br>
                          <br>
                          Thanks,<br>
                          Christian.<br>
                          <br>
                          Am 18.09.2018 um 16:20 schrieb Tom St Denis:<br>
                          &gt; On 2018-09-18 10:13 a.m., Christian König
                          wrote:<br>
                          &gt;&gt; Mhm, there is no more failed IB-test
                          in there isn't it?<br>
                          &gt;<br>
                          &gt; oh sorry I thought you wanted to test
                          HEAD~ ... Attached is a log from <br>
                          &gt; the tip of drm-next<br>
                          &gt;<br>
                          &gt; Tom<br>
                          &gt;<br>
                          &gt;&gt;<br>
                          &gt;&gt; Christian.<br>
                          &gt;&gt;<br>
                          &gt;&gt; Am 18.09.2018 um 16:09 schrieb Tom St
                          Denis:<br>
                          &gt;&gt;&gt; Disabling IOMMU in the BIOS
                          resulted in a correct boot up...<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; Here's the log.<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; Tom<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;&gt; On 2018-09-18 9:58 a.m., Tom St
                          Denis wrote:<br>
                          &gt;&gt;&gt;&gt; Odd I couldn't even boot my
                          system with the dGPU as primary after <br>
                          &gt;&gt;&gt;&gt; rebuilding the kernel.  It
                          got hung up in the IOMMU driver (loads <br>
                          &gt;&gt;&gt;&gt; of AMD-Vi IOMMU errors) which
                          I wasn't able to capture because it <br>
                          &gt;&gt;&gt;&gt; panic'ed before loading the
                          network stack.<br>
                          &gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt; Bizarre.<br>
                          &gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt; I'll keep trying.<br>
                          &gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt; Tom<br>
                          &gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt; On 2018-09-18 9:35 a.m.,
                          Christian König wrote:<br>
                          &gt;&gt;&gt;&gt;&gt; Am 18.09.2018 um 15:32
                          schrieb Tom St Denis:<br>
                          &gt;&gt;&gt;&gt;&gt;&gt; On 2018-09-18 9:30
                          a.m., Christian König wrote:<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt; Great, not sure
                          if that is a good or a bad news.<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt; Anyway going to
                          revert the change for now. Does anybody <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt; volunteer to
                          figure out why interrupts sometimes doesn't
                          work <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt; correctly on
                          Raven?<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt; What does "doesn't
                          work correctly?"  My workstation is a Raven1 <br>
                          &gt;&gt;&gt;&gt;&gt;&gt; (Ryzen 2400G) and
                          other than the TTM bulk move issue has been <br>
                          &gt;&gt;&gt;&gt;&gt;&gt; perfectly stable
                          (through suspend/resumes too I might add).<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt; Anything I could test
                          with my devel raven?<br>
                          &gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt; The problem seems to be
                          that on some boards IH handling doesn't <br>
                          &gt;&gt;&gt;&gt;&gt; work as it should.<br>
                          &gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt; Can you try to disable
                          the onboard graphics and try again?<br>
                          &gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt; If that still doesn't
                          work there is a DRM_DEBUG in <br>
                          &gt;&gt;&gt;&gt;&gt; amdgpu_ih_process(), make
                          that a DRM_ERROR and send me the <br>
                          &gt;&gt;&gt;&gt;&gt; resulting dmesg of
                          loading amdgpu (but don't start any UMD).<br>
                          &gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt; Thanks,<br>
                          &gt;&gt;&gt;&gt;&gt; Christian.<br>
                          &gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt; Tom<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt; Christian.<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 18.09.2018 um
                          15:27 schrieb Tom St Denis:<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This commit:<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [root@raven
                          linux]# git bisect good<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                          9b0df0937a852d299fbe42a5939c9a8a4cc83c55 is
                          the first bad commit<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; commit
                          9b0df0937a852d299fbe42a5939c9a8a4cc83c55<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Author:
                          Christian König <a
                            class="moz-txt-link-rfc2396E"
                            href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Date:   Tue
                          Sep 18 10:38:09 2018 +0200<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;    
                          drm/amdgpu: remove fence fallback<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;     DC
                          doesn't seem to have a fallback path either.<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;     So when
                          interrupts doesn't work any more we are pretty
                          much <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; busted no<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;     matter
                          what.<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;    
                          Signed-off-by: Christian König <a
                            class="moz-txt-link-rfc2396E"
                            href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;    
                          Reviewed-by: Chunming Zhou <a
                            class="moz-txt-link-rfc2396E"
                            href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org"
                            moz-do-not-send="true">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Results in
                          this:<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [  
                          24.334025] [drm] Initialized amdgpu 3.27.0
                          20150101 for <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0000:07:00.0
                          on minor 1<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [  
                          24.335674] modprobe (3895) used greatest stack
                          depth: 12600 <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; bytes left<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [  
                          26.272358] [drm:gfx_v8_0_ring_test_ib
                          [amdgpu]] *ERROR* <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amdgpu: IB
                          test timed out.<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [  
                          26.272460] [drm:amdgpu_ib_ring_tests [amdgpu]]
                          *ERROR* <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amdgpu:
                          failed testing IB on ring 9 (-110).<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [  
                          26.407885] [drm:process_one_work] *ERROR* ib
                          ring test <br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; failed
                          (-110).<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; [  
                          28.506708] fuse init (API version 7.27)<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On init with
                          my polaris/raven1 system.<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Cheers,<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Tom<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
                          _______________________________________________<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx
                          mailing list<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a
                            class="moz-txt-link-abbreviated"
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a
                            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                            moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                          &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;&gt;<br>
                          &gt;&gt;&gt;<br>
                          &gt;&gt;<br>
                          &gt;<br>
                          <br>
_______________________________________________<br>
                          amd-gfx mailing list<br>
                          <a class="moz-txt-link-abbreviated"
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          <a
                            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                            moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                        </div>
                      </span></font></div>
                  <br>
                  <fieldset class="mimeAttachmentHeader"></fieldset>
                  <br>
                  <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                </blockquote>
                <br>
              </blockquote>
              <br>
              <br>
              <fieldset class="mimeAttachmentHeader"></fieldset>
              <br>
              <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <br>
            <br>
            <fieldset class="mimeAttachmentHeader"></fieldset>
            <br>
            <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
          </blockquote>
          <br>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------945FA6F53627828F2DC63981--

--===============1065349509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1065349509==--
