From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3
Date: Mon, 25 Jun 2018 15:15:12 -0400
Message-ID: <f5941769-c342-6127-f932-414ab13414f8@amd.com>
References: <1050162536.2570273.1529798571780.JavaMail.zimbra@raptorengineeringinc.com>
 <03467f4e-bcab-165c-028b-fea16441446a@amd.com>
 <5B310FE8.4060900@raptorengineering.com>
 <BN6PR12MB1809E207A784F6EE6D79239AF74A0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <2b12b893-e2a0-9362-cb8f-15b57b12fe11@amd.com>
 <CADnq5_NVoR3zRRPWdQHTbRzZ7e0XYsjajDSx-jS_sa0-B3id1Q@mail.gmail.com>
 <b0c2612a-ac0b-ca7a-be8d-1a3d1cadc938@amd.com>
 <CADnq5_O3P68Er_oEf9YybKxFBXk4BFQnJ45wtiKCs9oSxJBcAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1574064037=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O3P68Er_oEf9YybKxFBXk4BFQnJ45wtiKCs9oSxJBcAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1574064037==
Content-Type: multipart/alternative;
 boundary="------------4FDCDCAE2FD1D243C4F9B3F4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4FDCDCAE2FD1D243C4F9B3F4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2018-06-25 03:02 PM, Alex Deucher wrote:
> On Mon, Jun 25, 2018 at 2:59 PM, James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org> wrote:
>>
>> On 2018-06-25 02:53 PM, Alex Deucher wrote:
>>
>> On Mon, Jun 25, 2018 at 2:37 PM, James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org> wrote:
>>
>> For one UVD instance case,:
>>
>>
>> In function amdgpu_driver_load_kms, all ring->me should be set to zero.
>>      adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);
>>
>>
>> For two UVD instances cases:
>>
>> static void uvd_v7_0_set_ring_funcs(struct amdgpu_device *adev)
>> ..
>>      for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
>>          adev->uvd.inst[i].ring.me = i;
>>
>> static void uvd_v7_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>>
>>      for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
>>              adev->uvd.inst[j].ring_enc[i].me = j;
>>
>> uvd_v4_2_early_init in uvd_v4_2.c  adev->uvd.num_uvd_inst = 1;
>> uvd_v5_0_early_init in uvd_v5_0.c  adev->uvd.num_uvd_inst = 1;
>> uvd_v6_0_early_init in uvd_v6_0.c  adev->uvd.num_uvd_inst = 1;
>> uvd_v7_0_early_init in uvd_v7_0.c
>>      if (adev->asic_type == CHIP_VEGA20)
>>          adev->uvd.num_uvd_inst = UVD7_MAX_HW_INSTANCES_VEGA20;/*2*/
>>      else
>>          adev->uvd.num_uvd_inst = 1;
>>
>>
>> I didn't know when ring->me is set to 2. Maybe there is some leakage
>> somewhere.
>>
>> What about older uvd (4.2, 5.0, 6.0) blocks?
>>
>> I think the below code will reset
>> adev->uvd.inst[AMDGPU_MAX_UVD_INSTANCES].ring->me and
>> adev->uvd.inst[AMDGPU_MAX_UVD_INSTANCES].ring_enc[AMDGPU_MAX_UVD_ENC_RINGS]->me
>> to zero.
>> for older uvd IP UVD block.
>>
>> adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);
>>
>> Do I understand correctly?
> Yes, it should.  That's why it doesn't make sense that it would be
> getting another value.
>
> Alex
     ring point is refer in struct amdgpu_device. Miss using it may 
cause simple leakage.
    struct amdgpu_device {
    ..............
      struct amdgpu_ring        **/rings/*[AMDGPU_MAX_RINGS];

The simple possible leakage could happen at
./gfx_v8_0.c:1995:    ring->me = mec + 1;
./amdgpu_gfx.c:190:        ring->me = mec + 1;
./gfx_v9_0.c:1406:    ring->me = mec + 1;
./gfx_v7_0.c:4471:    ring->me = mec + 1;

Timothy,

It is not easy to find root cause based on current information.
What asic are you using on this test. IS this UBSAN test open source?
Is it easy for you guide me to reproduce it on my bench?

James

>> James
>>
>> Alex
>>
>> Best regards!
>>
>> James zhu
>>
>>
>> On 2018-06-25 01:29 PM, Deucher, Alexander wrote:
>>
>> Odd. The structure should be 0 initialized.  Does this patch help?
>>
>>
>> Alex
>>
>> ________________________________
>> From: Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>
>> Sent: Monday, June 25, 2018 11:53:12 AM
>> To: Zhu, James
>> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Zhou,
>> David(ChunMing); Koenig, Christian
>> Subject: Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3
>>
>> n 06/25/2018 09:46 AM, James Zhu wrote:
>>
>> On 2018-06-23 08:02 PM, Timothy Pearson wrote:
>>
>> amdgpu_fence_driver_start_ring() attempts to access
>> UVD instance 2 during setup, while the existing UVD
>> instance count only allows instances 0 and 1.
>>
>> Increase AMDGPU_MAX_UVD_INSTANCES by one to avoid the
>> invalid array access.
>>
>> Caught by UBSAN.
>>
>> Hi Timothy,
>>
>>  From design of view, it is not right to just change
>> AMDGPU_MAX_UVD_INSTANCES to 3.
>>
>> Could you tell me some detail of UBSAN test and attach the dmesg also?
>>
>> Definitely, was looking for some feedback from anyone knowing more about
>> the internals of the UVD system.
>>
>> What's happening is that "ring->me" in amdgpu_fence_driver_start_ring()
>> (drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:379) is set to a value of
>> "2".  The overall dmesg is otherwise uninteresting, but I can try to
>> grab the UBSAN output if needed.
>>
>> --
>> Timothy Pearson
>> Raptor Engineering
>> +1 (415) 727-8645 (direct line)
>> +1 (512) 690-0200 (switchboard)
>> https://www.raptorengineering.com
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>>


--------------4FDCDCAE2FD1D243C4F9B3F4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-06-25 03:02 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CADnq5_O3P68Er_oEf9YybKxFBXk4BFQnJ45wtiKCs9oSxJBcAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <pre wrap="">On Mon, Jun 25, 2018 at 2:59 PM, James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:jamesz-5C7GfCeVMHo@public.gmane.org">&lt;jamesz-5C7GfCeVMHo@public.gmane.org&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">

On 2018-06-25 02:53 PM, Alex Deucher wrote:

On Mon, Jun 25, 2018 at 2:37 PM, James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:jamesz-5C7GfCeVMHo@public.gmane.org">&lt;jamesz-5C7GfCeVMHo@public.gmane.org&gt;</a> wrote:

For one UVD instance case,:


In function amdgpu_driver_load_kms, all ring-&gt;me should be set to zero.
    adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);


For two UVD instances cases:

static void uvd_v7_0_set_ring_funcs(struct amdgpu_device *adev)
..
    for (i = 0; i &lt; adev-&gt;uvd.num_uvd_inst; i++) {
        adev-&gt;uvd.inst[i].ring.me = i;

static void uvd_v7_0_set_enc_ring_funcs(struct amdgpu_device *adev)

    for (j = 0; j &lt; adev-&gt;uvd.num_uvd_inst; j++) {
            adev-&gt;uvd.inst[j].ring_enc[i].me = j;

uvd_v4_2_early_init in uvd_v4_2.c  adev-&gt;uvd.num_uvd_inst = 1;
uvd_v5_0_early_init in uvd_v5_0.c  adev-&gt;uvd.num_uvd_inst = 1;
uvd_v6_0_early_init in uvd_v6_0.c  adev-&gt;uvd.num_uvd_inst = 1;
uvd_v7_0_early_init in uvd_v7_0.c
    if (adev-&gt;asic_type == CHIP_VEGA20)
        adev-&gt;uvd.num_uvd_inst = UVD7_MAX_HW_INSTANCES_VEGA20;/*2*/
    else
        adev-&gt;uvd.num_uvd_inst = 1;


I didn't know when ring-&gt;me is set to 2. Maybe there is some leakage
somewhere.

What about older uvd (4.2, 5.0, 6.0) blocks?

I think the below code will reset
adev-&gt;uvd.inst[AMDGPU_MAX_UVD_INSTANCES].ring-&gt;me and
adev-&gt;uvd.inst[AMDGPU_MAX_UVD_INSTANCES].ring_enc[AMDGPU_MAX_UVD_ENC_RINGS]-&gt;me
to zero.
for older uvd IP UVD block.

adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);

Do I understand correctly?
</pre>
      </blockquote>
      <pre wrap="">
Yes, it should.  That's why it doesn't make sense that it would be
getting another value.

Alex
</pre>
    </blockquote>
        ring point is refer in struct amdgpu_device. Miss using it may
    cause simple leakage.<br>
       struct amdgpu_device {<br>
       ..............<br>
         struct amdgpu_ring        *<b><i>rings</i></b>[AMDGPU_MAX_RINGS];<br>
    <br>
    The simple possible leakage could happen at <br>
    ./gfx_v8_0.c:1995:    ring-&gt;me = mec + 1;<br>
    ./amdgpu_gfx.c:190:        ring-&gt;me = mec + 1;<br>
    ./gfx_v9_0.c:1406:    ring-&gt;me = mec + 1;<br>
    ./gfx_v7_0.c:4471:    ring-&gt;me = mec + 1;<br>
    <br>
    <pre wrap="">Timothy, 

It is not easy to find root cause based on current information. 
What asic are you using on this test. IS this UBSAN test open source?
Is it easy for you guide me to reproduce it on my bench?

James
</pre>
    <blockquote type="cite"
cite="mid:CADnq5_O3P68Er_oEf9YybKxFBXk4BFQnJ45wtiKCs9oSxJBcAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">James

Alex

Best regards!

James zhu


On 2018-06-25 01:29 PM, Deucher, Alexander wrote:

Odd. The structure should be 0 initialized.  Does this patch help?


Alex

________________________________
From: Timothy Pearson <a class="moz-txt-link-rfc2396E" href="mailto:tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org">&lt;tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org&gt;</a>
Sent: Monday, June 25, 2018 11:53:12 AM
To: Zhu, James
Cc: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander; Zhou,
David(ChunMing); Koenig, Christian
Subject: Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3

n 06/25/2018 09:46 AM, James Zhu wrote:

On 2018-06-23 08:02 PM, Timothy Pearson wrote:

amdgpu_fence_driver_start_ring() attempts to access
UVD instance 2 during setup, while the existing UVD
instance count only allows instances 0 and 1.

Increase AMDGPU_MAX_UVD_INSTANCES by one to avoid the
invalid array access.

Caught by UBSAN.

Hi Timothy,

>From design of view, it is not right to just change
AMDGPU_MAX_UVD_INSTANCES to 3.

Could you tell me some detail of UBSAN test and attach the dmesg also?

Definitely, was looking for some feedback from anyone knowing more about
the internals of the UVD system.

What's happening is that "ring-&gt;me" in amdgpu_fence_driver_start_ring()
(drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:379) is set to a value of
"2".  The overall dmesg is otherwise uninteresting, but I can try to
grab the UBSAN output if needed.

--
Timothy Pearson
Raptor Engineering
+1 (415) 727-8645 (direct line)
+1 (512) 690-0200 (switchboard)
<a class="moz-txt-link-freetext" href="https://www.raptorengineering.com">https://www.raptorengineering.com</a>



_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>


</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------4FDCDCAE2FD1D243C4F9B3F4--

--===============1574064037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1574064037==--
