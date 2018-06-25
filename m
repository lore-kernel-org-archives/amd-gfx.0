From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3
Date: Mon, 25 Jun 2018 14:37:46 -0400
Message-ID: <2b12b893-e2a0-9362-cb8f-15b57b12fe11@amd.com>
References: <1050162536.2570273.1529798571780.JavaMail.zimbra@raptorengineeringinc.com>
 <03467f4e-bcab-165c-028b-fea16441446a@amd.com>
 <5B310FE8.4060900@raptorengineering.com>
 <BN6PR12MB1809E207A784F6EE6D79239AF74A0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0211043645=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809E207A784F6EE6D79239AF74A0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0211043645==
Content-Type: multipart/alternative;
 boundary="------------E60B45E67291A2F75043D3D9"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E60B45E67291A2F75043D3D9
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

For one UVD instance case,:


/In function/ amdgpu_driver_load_kms, all ring->me should be set to zero.
*  adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);*


For two UVD instances cases:

static void uvd_v7_0_set_ring_funcs(struct amdgpu_device *adev)
..
     for (i = 0; i < adev->uvd.num_uvd_inst; i++) {
*adev->uvd.inst[i].ring.me = i;*

static void uvd_v7_0_set_enc_ring_funcs(struct amdgpu_device *adev)

     for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
*adev->uvd.inst[j].ring_enc[i].me = j;*

uvd_v4_2_early_init in uvd_v4_2.c  adev->uvd.num_uvd_inst = 1;
uvd_v5_0_early_init in uvd_v5_0.c  adev->uvd.num_uvd_inst = 1;
uvd_v6_0_early_init in uvd_v6_0.c  adev->uvd.num_uvd_inst = 1;
uvd_v7_0_early_init in uvd_v7_0.c
     if (adev->asic_type == CHIP_VEGA20)
*adev->uvd.num_uvd_inst = UVD7_MAX_HW_INSTANCES_VEGA20;/*2*/*
     else
*adev->uvd.num_uvd_inst = 1;*


I didn't know when ring->me is set to 2. Maybe there is some leakage 
somewhere.

Best regards!

James zhu

On 2018-06-25 01:29 PM, Deucher, Alexander wrote:
>
> Odd. The structure should be 0 initialized.  Does this patch help?
>
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Timothy Pearson <tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org>
> *Sent:* Monday, June 25, 2018 11:53:12 AM
> *To:* Zhu, James
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Zhou, 
> David(ChunMing); Koenig, Christian
> *Subject:* Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES to 3
> n 06/25/2018 09:46 AM, James Zhu wrote:
> >
> >
> > On 2018-06-23 08:02 PM, Timothy Pearson wrote:
> >> amdgpu_fence_driver_start_ring() attempts to access
> >> UVD instance 2 during setup, while the existing UVD
> >> instance count only allows instances 0 and 1.
> >>
> >> Increase AMDGPU_MAX_UVD_INSTANCES by one to avoid the
> >> invalid array access.
> >>
> >> Caught by UBSAN.
> > Hi Timothy,
> >
> > From design of view, it is not right to just change
> > AMDGPU_MAX_UVD_INSTANCES to 3.
> >
> > Could you tell me some detail of UBSAN test and attach the dmesg also?
>
> Definitely, was looking for some feedback from anyone knowing more about
> the internals of the UVD system.
>
> What's happening is that "ring->me" in amdgpu_fence_driver_start_ring()
> (drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:379) is set to a value of
> "2".  The overall dmesg is otherwise uninteresting, but I can try to
> grab the UBSAN output if needed.
>
> -- 
> Timothy Pearson
> Raptor Engineering
> +1 (415) 727-8645 (direct line)
> +1 (512) 690-0200 (switchboard)
> https://www.raptorengineering.com


--------------E60B45E67291A2F75043D3D9
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>For one UVD instance case,:<br>
    </p>
    <p><br>
    </p>
    <p><i>In function</i> amdgpu_driver_load_kms, all <font size="2"><span
          style="font-size:11pt;">ring-&gt;me should be set to zero.</span></font><br>
        <b>  adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);</b></p>
    <p><br>
    </p>
    <p>For two UVD instances cases:</p>
    <p>static void uvd_v7_0_set_ring_funcs(struct amdgpu_device *adev)<br>
      ..<br>
          for (i = 0; i &lt; adev-&gt;uvd.num_uvd_inst; i++) {<br>
             <b> adev-&gt;uvd.inst[i].ring.me = i;</b><br>
        <br>
      static void uvd_v7_0_set_enc_ring_funcs(struct amdgpu_device
      *adev)<br>
    </p>
        for (j = 0; j &lt; adev-&gt;uvd.num_uvd_inst; j++) {<br>
                <b>adev-&gt;uvd.inst[j].ring_enc[i].me = j;</b><br>
    <br>
    uvd_v4_2_early_init in uvd_v4_2.c  adev-&gt;uvd.num_uvd_inst = 1;<br>
    uvd_v5_0_early_init in uvd_v5_0.c  adev-&gt;uvd.num_uvd_inst = 1;<br>
    uvd_v6_0_early_init in uvd_v6_0.c  adev-&gt;uvd.num_uvd_inst = 1;<br>
    uvd_v7_0_early_init in uvd_v7_0.c       <br>
        if (adev-&gt;asic_type == CHIP_VEGA20)<br>
            <b>adev-&gt;uvd.num_uvd_inst =
      UVD7_MAX_HW_INSTANCES_VEGA20;/*2*/</b><br>
        else<br>
            <b>adev-&gt;uvd.num_uvd_inst = 1;</b><br>
    <br>
    <br>
    I didn't know when ring-&gt;me is set to 2. Maybe there is some
    leakage somewhere.<br>
    <br>
    Best regards!<br>
    <br>
    James zhu<br>
    <br>
    <div class="moz-cite-prefix">On 2018-06-25 01:29 PM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1809E207A784F6EE6D79239AF74A0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Odd. The structure
          should be 0 initialized.  Does this patch help?</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Alex<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Timothy Pearson <a class="moz-txt-link-rfc2396E" href="mailto:tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org">&lt;tpearson-z0qzliK6Om0mgXJStvpl+vpXobYPEAuW@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Monday, June 25, 2018 11:53:12 AM<br>
          <b>To:</b> Zhu, James<br>
          <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander;
          Zhou, David(ChunMing); Koenig, Christian<br>
          <b>Subject:</b> Re: [PATCH] Increase AMDGPU_MAX_UVD_INSTANCES
          to 3</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">n 06/25/2018 09:46 AM, James Zhu
              wrote:<br>
              &gt; <br>
              &gt; <br>
              &gt; On 2018-06-23 08:02 PM, Timothy Pearson wrote:<br>
              &gt;&gt; amdgpu_fence_driver_start_ring() attempts to
              access<br>
              &gt;&gt; UVD instance 2 during setup, while the existing
              UVD<br>
              &gt;&gt; instance count only allows instances 0 and 1.<br>
              &gt;&gt;<br>
              &gt;&gt; Increase AMDGPU_MAX_UVD_INSTANCES by one to avoid
              the<br>
              &gt;&gt; invalid array access.<br>
              &gt;&gt;<br>
              &gt;&gt; Caught by UBSAN.<br>
              &gt; Hi Timothy,<br>
              &gt; <br>
              &gt; From design of view, it is not right to just change<br>
              &gt; AMDGPU_MAX_UVD_INSTANCES to 3.<br>
              &gt; <br>
              &gt; Could you tell me some detail of UBSAN test and
              attach the dmesg also?<br>
              <br>
              Definitely, was looking for some feedback from anyone
              knowing more about<br>
              the internals of the UVD system.<br>
              <br>
              What's happening is that "ring-&gt;me" in
              amdgpu_fence_driver_start_ring()<br>
              (drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:379) is set to
              a value of<br>
              "2".  The overall dmesg is otherwise uninteresting, but I
              can try to<br>
              grab the UBSAN output if needed.<br>
              <br>
              -- <br>
              Timothy Pearson<br>
              Raptor Engineering<br>
              +1 (415) 727-8645 (direct line)<br>
              +1 (512) 690-0200 (switchboard)<br>
              <a href="https://www.raptorengineering.com"
                moz-do-not-send="true">https://www.raptorengineering.com</a><br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------E60B45E67291A2F75043D3D9--

--===============0211043645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0211043645==--
