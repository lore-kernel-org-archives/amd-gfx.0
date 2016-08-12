From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup
Date: Fri, 12 Aug 2016 09:52:07 +0800
Message-ID: <57AD2BC7.70709@amd.com>
References: <20160811143253.24718-1-tom.stdenis@amd.com>
 <20160811143253.24718-4-tom.stdenis@amd.com>,
 <MWHPR12MB1694FE8258E0ADB4F32DC885F71E0@MWHPR12MB1694.namprd12.prod.outlook.com>
 <DM5PR12MB1132A35D1BAAB0027D5FE23AF71E0@DM5PR12MB1132.namprd12.prod.outlook.com>
 <MWHPR12MB1694A14EF7C0FAD8E46B5A97F71E0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0266664437=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB1694A14EF7C0FAD8E46B5A97F71E0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0266664437==
Content-Type: multipart/alternative;
	boundary="------------060705060906080602040904"

--------------060705060906080602040904
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Agree with Tom.

On 2016年08月12日 00:09, Deucher, Alexander wrote:
>
> I guess I don't really have a particularly strong opinion either way.  
> If others are ok with it, I'm fine with it.
>
> Alex
>
> *From:*StDenis, Tom
> *Sent:* Thursday, August 11, 2016 11:48 AM
> *To:* Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup
>
> Just trying to make it easier to read.
>
> WREG32_FIELD(foo, FIELD, 1);
>
> Is easier to read than
>
> WREG32_P(foo, FOO__FIELD_MASK, ~FOO__FIELD_MASK);
>
> (also I already pushed them after getting a RB by Christian this 
> morning so we might need to hold a different discussion).
>
> I agree it's not really a functional change but making things a bit 
> more uniform and easier to read helps maintenance.  And I did find a 
> bug in the process :-)
>
> Tom
>
> ------------------------------------------------------------------------
>
> *From:*Deucher, Alexander
> *Sent:* Thursday, August 11, 2016 11:46
> *To:* 'Tom St Denis'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Cc:* StDenis, Tom
> *Subject:* RE: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup
>
> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of Tom St Denis
> > Sent: Thursday, August 11, 2016 10:33 AM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> > Cc: StDenis, Tom
> > Subject: [PATCH 3/4] drm/amd/amdgpu: VCE v2 register cleanup
> >
> > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org 
> <mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org>>
>
> A couple pieces of this patch could be split out as separate cleanups 
> (see below).  However, I'm not sure how much value there is in 
> switching WREG32_P for WREG_FIELD other than code churn.  They 
> basically do the same thing.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 39 +++++++++++++-------------
> > ---------
> >  1 file changed, 14 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> > index 80a37a602181..21ba219e943b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> > @@ -127,15 +127,10 @@ static int vce_v2_0_start(struct amdgpu_device
> > *adev)
> >        WREG32(mmVCE_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> >        WREG32(mmVCE_RB_SIZE2, ring->ring_size / 4);
> >
> > -     WREG32_P(mmVCE_VCPU_CNTL,
> > VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> > -
> > -     WREG32_P(mmVCE_SOFT_RESET,
> > - VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> > - ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > -
> > +     WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);
> > +     WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
> >        mdelay(100);
> > -
> > -     WREG32_P(mmVCE_SOFT_RESET, 0,
> > ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > +     WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);
> >
> >        for (i = 0; i < 10; ++i) {
> >                uint32_t status;
> > @@ -150,10 +145,9 @@ static int vce_v2_0_start(struct amdgpu_device
> > *adev)
> >                        break;
> >
> >                DRM_ERROR("VCE not responding, trying to reset the
> > ECPU!!!\n");
> > -             WREG32_P(mmVCE_SOFT_RESET,
> > VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> > -
> >        ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
> >                mdelay(10);
> > -             WREG32_P(mmVCE_SOFT_RESET, 0,
> > ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 0);
> >                mdelay(10);
> >                r = -1;
> >        }
> > @@ -345,13 +339,13 @@ static void vce_v2_0_set_dyn_cg(struct
> > amdgpu_device *adev, bool gated)
> >                        DRM_INFO("VCE is busy, Can't set clock gateing");
> >                        return;
> >                }
> > -             WREG32_P(mmVCE_VCPU_CNTL, 0,
> > ~VCE_VCPU_CNTL__CLK_EN_MASK);
> > -             WREG32_P(mmVCE_SOFT_RESET,
> > VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> > ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > +             WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 0);
> > +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
> >                mdelay(100);
> >                WREG32(mmVCE_STATUS, 0);
> >        } else {
> > -             WREG32_P(mmVCE_VCPU_CNTL,
> > VCE_VCPU_CNTL__CLK_EN_MASK, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> > -             WREG32_P(mmVCE_SOFT_RESET,
> > VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> > ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> > +             WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);
> > +             WREG32_FIELD(VCE_SOFT_RESET, ECPU_SOFT_RESET, 1);
> >                mdelay(100);
> >        }
> >
> > @@ -458,9 +452,7 @@ static void vce_v2_0_mc_resume(struct
> > amdgpu_device *adev)
> >        WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
> >
> >        WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> > -
> > -     WREG32_P(mmVCE_SYS_INT_EN,
> > VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK,
> > -
> > ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
> > +     WREG32_FIELD(VCE_SYS_INT_EN,
> > VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);
> >
> >        vce_v2_0_init_cg(adev);
> >  }
> > @@ -474,11 +466,11 @@ static bool vce_v2_0_is_idle(void *handle)
> >
> >  static int vce_v2_0_wait_for_idle(void *handle)
> >  {
> > -     unsigned i;
> >        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> > +     unsigned i;
> >
> >        for (i = 0; i < adev->usec_timeout; i++) {
> > -             if (!(RREG32(mmSRBM_STATUS2) &
> > SRBM_STATUS2__VCE_BUSY_MASK))
> > +             if (vce_v2_0_is_idle(handle))
> >                        return 0;
>
> This could be split out as a separate patch.
>
> >        }
> >        return -ETIMEDOUT;
> > @@ -488,8 +480,7 @@ static int vce_v2_0_soft_reset(void *handle)
> >  {
> >        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >
> > -     WREG32_P(mmSRBM_SOFT_RESET,
> > SRBM_SOFT_RESET__SOFT_RESET_VCE_MASK,
> > - ~SRBM_SOFT_RESET__SOFT_RESET_VCE_MASK);
> > +     WREG32_FIELD(SRBM_SOFT_RESET, SOFT_RESET_VCE, 1);
> >        mdelay(5);
> >
> >        return vce_v2_0_start(adev);
> > @@ -516,10 +507,8 @@ static int vce_v2_0_process_interrupt(struct
> > amdgpu_device *adev,
> >        DRM_DEBUG("IH: VCE\n");
> >        switch (entry->src_data) {
> >        case 0:
> > - amdgpu_fence_process(&adev->vce.ring[0]);
> > -             break;
> >        case 1:
> > - amdgpu_fence_process(&adev->vce.ring[1]);
> > + amdgpu_fence_process(&adev->vce.ring[entry->src_data]);
> >                break;
> >        default:
> >                DRM_ERROR("Unhandled interrupt: %d %d\n",
>
> This too.
>
> > --
> > 2.9.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------060705060906080602040904
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Agree with Tom.<br>
    <br>
    <div class="moz-cite-prefix">On 2016年08月12日 00:09, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote
cite="mid:MWHPR12MB1694A14EF7C0FAD8E46B5A97F71E0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 14 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">I
            guess I don't really have a particularly strong opinion
            either way.  If others are ok with it, I'm fine with it.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p> </o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #B5C4DF
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">
                  StDenis, Tom
                  <br>
                  <b>Sent:</b> Thursday, August 11, 2016 11:48 AM<br>
                  <b>To:</b> Deucher, Alexander;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: [PATCH 3/4] drm/amd/amdgpu: VCE v2
                  register cleanup<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Just
                trying to make it easier to read.  <o:p></o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p> </o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">WREG32_FIELD(foo,
                FIELD, 1);<o:p></o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p> </o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Is
                easier to read than<o:p></o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p> </o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">WREG32_P(foo,
                FOO__FIELD_MASK, ~FOO__FIELD_MASK);<o:p></o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p> </o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">(also
                I already pushed them after getting a RB by Christian
                this morning so we might need to hold a different
                discussion).<o:p></o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p> </o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">I
                agree it's not really a functional change but making
                things a bit more uniform and easier to read helps
                maintenance.  And I did find a bug in the process :-)<o:p></o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p> </o:p></span></p>
            <p style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">Tom<o:p></o:p></span></p>
            <p class="MsoNormal"
              style="margin-bottom:12.0pt;background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p> </o:p></span></p>
            <div>
              <div>
                <div class="MsoNormal"
                  style="text-align:center;background:white"
                  align="center">
                  <span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">
                    <hr size="2" width="98%" align="center">
                  </span></div>
                <div id="x_divRplyFwdMsg">
                  <p class="MsoNormal" style="background:white"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">
                      Deucher, Alexander<br>
                      <b>Sent:</b> Thursday, August 11, 2016 11:46<br>
                      <b>To:</b> 'Tom St Denis'; <a
                        moz-do-not-send="true"
                        href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                      <b>Cc:</b> StDenis, Tom<br>
                      <b>Subject:</b> RE: [PATCH 3/4] drm/amd/amdgpu:
                      VCE v2 register cleanup</span><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p></o:p></span></p>
                  <div>
                    <p class="MsoNormal" style="background:white"><span
style="font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"> <o:p></o:p></span></p>
                  </div>
                </div>
              </div>
              <div>
                <p class="MsoNormal" style="background:white"><span
style="font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">&gt;
                    -----Original Message-----<br>
                    &gt; From: amd-gfx [<a moz-do-not-send="true"
                      href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                    On Behalf<br>
                    &gt; Of Tom St Denis<br>
                    &gt; Sent: Thursday, August 11, 2016 10:33 AM<br>
                    &gt; To: <a moz-do-not-send="true"
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    &gt; Cc: StDenis, Tom<br>
                    &gt; Subject: [PATCH 3/4] drm/amd/amdgpu: VCE v2
                    register cleanup<br>
                    &gt; <br>
                    &gt; Signed-off-by: Tom St Denis &lt;<a
                      moz-do-not-send="true"
                      href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <br>
                    A couple pieces of this patch could be split out as
                    separate cleanups (see below).  However, I'm not
                    sure how much value there is in switching WREG32_P
                    for WREG_FIELD other than code churn.  They
                    basically do the same thing. 
                    <br>
                    <br>
                    Alex<br>
                    <br>
                    &gt; ---<br>
                    &gt;  drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 39
                    +++++++++++++-------------<br>
                    &gt; ---------<br>
                    &gt;  1 file changed, 14 insertions(+), 25
                    deletions(-)<br>
                    &gt; <br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
                    &gt; b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
                    &gt; index 80a37a602181..21ba219e943b 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c<br>
                    &gt; @@ -127,15 +127,10 @@ static int
                    vce_v2_0_start(struct amdgpu_device<br>
                    &gt; *adev)<br>
                    &gt;        WREG32(mmVCE_RB_BASE_HI2,
                    upper_32_bits(ring-&gt;gpu_addr));<br>
                    &gt;        WREG32(mmVCE_RB_SIZE2,
                    ring-&gt;ring_size / 4);<br>
                    &gt; <br>
                    &gt; -     WREG32_P(mmVCE_VCPU_CNTL,<br>
                    &gt; VCE_VCPU_CNTL__CLK_EN_MASK,
                    ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
                    &gt; -<br>
                    &gt; -     WREG32_P(mmVCE_SOFT_RESET,<br>
                    &gt; -             
                    VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
                    &gt; -             
                    ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
                    &gt; -<br>
                    &gt; +     WREG32_FIELD(VCE_VCPU_CNTL, CLK_EN, 1);<br>
                    &gt; +     WREG32_FIELD(VCE_SOFT_RESET,
                    ECPU_SOFT_RESET, 1);<br>
                    &gt;        mdelay(100);<br>
                    &gt; -<br>
                    &gt; -     WREG32_P(mmVCE_SOFT_RESET, 0,<br>
                    &gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
                    &gt; +     WREG32_FIELD(VCE_SOFT_RESET,
                    ECPU_SOFT_RESET, 0);<br>
                    &gt; <br>
                    &gt;        for (i = 0; i &lt; 10; ++i) {<br>
                    &gt;                uint32_t status;<br>
                    &gt; @@ -150,10 +145,9 @@ static int
                    vce_v2_0_start(struct amdgpu_device<br>
                    &gt; *adev)<br>
                    &gt;                        break;<br>
                    &gt; <br>
                    &gt;                DRM_ERROR("VCE not responding,
                    trying to reset the<br>
                    &gt; ECPU!!!\n");<br>
                    &gt; -             WREG32_P(mmVCE_SOFT_RESET,<br>
                    &gt; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
                    &gt; -<br>
                    &gt;        ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
                    &gt; +             WREG32_FIELD(VCE_SOFT_RESET,
                    ECPU_SOFT_RESET, 1);<br>
                    &gt;                mdelay(10);<br>
                    &gt; -             WREG32_P(mmVCE_SOFT_RESET, 0,<br>
                    &gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
                    &gt; +             WREG32_FIELD(VCE_SOFT_RESET,
                    ECPU_SOFT_RESET, 0);<br>
                    &gt;                mdelay(10);<br>
                    &gt;                r = -1;<br>
                    &gt;        }<br>
                    &gt; @@ -345,13 +339,13 @@ static void
                    vce_v2_0_set_dyn_cg(struct<br>
                    &gt; amdgpu_device *adev, bool gated)<br>
                    &gt;                        DRM_INFO("VCE is busy,
                    Can't set clock gateing");<br>
                    &gt;                        return;<br>
                    &gt;                }<br>
                    &gt; -             WREG32_P(mmVCE_VCPU_CNTL, 0,<br>
                    &gt; ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
                    &gt; -             WREG32_P(mmVCE_SOFT_RESET,<br>
                    &gt; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
                    &gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
                    &gt; +             WREG32_FIELD(VCE_VCPU_CNTL,
                    CLK_EN, 0);<br>
                    &gt; +             WREG32_FIELD(VCE_SOFT_RESET,
                    ECPU_SOFT_RESET, 1);<br>
                    &gt;                mdelay(100);<br>
                    &gt;                WREG32(mmVCE_STATUS, 0);<br>
                    &gt;        } else {<br>
                    &gt; -             WREG32_P(mmVCE_VCPU_CNTL,<br>
                    &gt; VCE_VCPU_CNTL__CLK_EN_MASK,
                    ~VCE_VCPU_CNTL__CLK_EN_MASK);<br>
                    &gt; -             WREG32_P(mmVCE_SOFT_RESET,<br>
                    &gt; VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,<br>
                    &gt; ~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);<br>
                    &gt; +             WREG32_FIELD(VCE_VCPU_CNTL,
                    CLK_EN, 1);<br>
                    &gt; +             WREG32_FIELD(VCE_SOFT_RESET,
                    ECPU_SOFT_RESET, 1);<br>
                    &gt;                mdelay(100);<br>
                    &gt;        }<br>
                    &gt; <br>
                    &gt; @@ -458,9 +452,7 @@ static void
                    vce_v2_0_mc_resume(struct<br>
                    &gt; amdgpu_device *adev)<br>
                    &gt;        WREG32(mmVCE_VCPU_CACHE_SIZE2, size);<br>
                    &gt; <br>
                    &gt;        WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);<br>
                    &gt; -<br>
                    &gt; -     WREG32_P(mmVCE_SYS_INT_EN,<br>
                    &gt;
                    VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK,<br>
                    &gt; -<br>
                    &gt;
                    ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);<br>
                    &gt; +     WREG32_FIELD(VCE_SYS_INT_EN,<br>
                    &gt; VCE_SYS_INT_TRAP_INTERRUPT_EN, 1);<br>
                    &gt; <br>
                    &gt;        vce_v2_0_init_cg(adev);<br>
                    &gt;  }<br>
                    &gt; @@ -474,11 +466,11 @@ static bool
                    vce_v2_0_is_idle(void *handle)<br>
                    &gt; <br>
                    &gt;  static int vce_v2_0_wait_for_idle(void
                    *handle)<br>
                    &gt;  {<br>
                    &gt; -     unsigned i;<br>
                    &gt;        struct amdgpu_device *adev = (struct
                    amdgpu_device *)handle;<br>
                    &gt; +     unsigned i;<br>
                    &gt; <br>
                    &gt;        for (i = 0; i &lt;
                    adev-&gt;usec_timeout; i++) {<br>
                    &gt; -             if (!(RREG32(mmSRBM_STATUS2)
                    &amp;<br>
                    &gt; SRBM_STATUS2__VCE_BUSY_MASK))<br>
                    &gt; +             if (vce_v2_0_is_idle(handle))<br>
                    &gt;                        return 0;<br>
                    <br>
                    This could be split out as a separate patch.<br>
                    <br>
                    &gt;        }<br>
                    &gt;        return -ETIMEDOUT;<br>
                    &gt; @@ -488,8 +480,7 @@ static int
                    vce_v2_0_soft_reset(void *handle)<br>
                    &gt;  {<br>
                    &gt;        struct amdgpu_device *adev = (struct
                    amdgpu_device *)handle;<br>
                    &gt; <br>
                    &gt; -     WREG32_P(mmSRBM_SOFT_RESET,<br>
                    &gt; SRBM_SOFT_RESET__SOFT_RESET_VCE_MASK,<br>
                    &gt; -                    
                    ~SRBM_SOFT_RESET__SOFT_RESET_VCE_MASK);<br>
                    &gt; +     WREG32_FIELD(SRBM_SOFT_RESET,
                    SOFT_RESET_VCE, 1);<br>
                    &gt;        mdelay(5);<br>
                    &gt; <br>
                    &gt;        return vce_v2_0_start(adev);<br>
                    &gt; @@ -516,10 +507,8 @@ static int
                    vce_v2_0_process_interrupt(struct<br>
                    &gt; amdgpu_device *adev,<br>
                    &gt;        DRM_DEBUG("IH: VCE\n");<br>
                    &gt;        switch (entry-&gt;src_data) {<br>
                    &gt;        case 0:<br>
                    &gt; -            
                    amdgpu_fence_process(&amp;adev-&gt;vce.ring[0]);<br>
                    &gt; -             break;<br>
                    &gt;        case 1:<br>
                    &gt; -            
                    amdgpu_fence_process(&amp;adev-&gt;vce.ring[1]);<br>
                    &gt; +            
                    amdgpu_fence_process(&amp;adev-&gt;vce.ring[entry-&gt;src_data]);<br>
                    &gt;                break;<br>
                    &gt;        default:<br>
                    &gt;                DRM_ERROR("Unhandled interrupt:
                    %d %d\n",<br>
                    <br>
                    This too.<br>
                    <br>
                    &gt; --<br>
                    &gt; 2.9.2<br>
                    &gt; <br>
                    &gt; _______________________________________________<br>
                    &gt; amd-gfx mailing list<br>
                    &gt; <a moz-do-not-send="true"
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                    &gt; <a moz-do-not-send="true"
                      href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060705060906080602040904--

--===============0266664437==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0266664437==--
