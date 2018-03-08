From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: deprecated register issues
Date: Thu, 8 Mar 2018 10:40:36 +0100
Message-ID: <7e01679a-81fe-3e1d-9eb1-c7668145a87a@gmail.com>
References: <BLUPR12MB04496DB9A508E4AEE114AF2484D80@BLUPR12MB0449.namprd12.prod.outlook.com>
 <0258a141-8849-623b-9949-de14026e76a8@amd.com>
 <BLUPR12MB044941D93445D001B482655984D80@BLUPR12MB0449.namprd12.prod.outlook.com>
 <58B0701E-D93F-417B-816C-0616F364789A@amd.com>
 <8ccdd2af-4520-866b-9b55-fa41b05c1fa1@amd.com>
 <DM5PR12MB1660D5E735D17FEEC2E5E51CF7D80@DM5PR12MB1660.namprd12.prod.outlook.com>
 <BLUPR12MB04499E74336A32888737C2B584DF0@BLUPR12MB0449.namprd12.prod.outlook.com>
 <BN6PR12MB165241AC2937FA73FE9E95C6F7DF0@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BLUPR12MB044941CA8B586506C47EF57184DF0@BLUPR12MB0449.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1409692106=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB044941CA8B586506C47EF57184DF0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Cc: "Jin, Jian-Rong" <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1409692106==
Content-Type: multipart/alternative;
 boundary="------------A90022607724C835746DF1C1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A90022607724C835746DF1C1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Monk,

> While we can avoid such vm flush failure by stitch together of the 
> sending REQ and reading ACK part, at least for compute ring this is 
> confirmed.
Well there are two misunderstanding here.

First of all this solution doesn't really work, it just hides the 
problem because we don't do a world switch in between those two packets 
any more. And while we could change the SDMA, UVD and VCE firmware do to 
something similar you can't apply this solution to CPU based flushes.

The second issue is that this isn't related to VMHUB flushing at all, 
it's just that VMHUB flushing is the first thing where you notice that 
something is wrong.

The real problem is that when you access CC_RB_BACKEND_DISABLE and a 
bunch of other registers the bus on Vega10 sometimes gets a hickup and 
drops other reads and writes.

So we need to identify those registers and removes all accesses to them, 
otherwise working with the hardware will just be horrible unreliable in 
general.

Regards,
Christian.

Am 08.03.2018 um 04:05 schrieb Liu, Monk:
>
> Hi Alex
>
> While we can avoid such vm flush failure by stitch together of the 
> sending REQ and reading ACK part, at least for compute ring this is 
> confirmed.
>
> And I believe for SDMA ring (even UVD/VCE ring) it could also be achieved.
>
> But @Koenig, Christian <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org> insist 
> stitching together the REQ AND ACK part is not a formal way to fix the 
> issue, instead just a walkaround and I cannot debate that
>
> What make me worry more is what if there are more registers like Alex 
> said that behaves like this CC_RB_BACKEND_DISABLE,
>
> since we don’t know their names(too hard to filter them out!) so we 
> couldn’t remove them all from SR list,
>
> So I still think we need plan B to handle above case,  A.K.A use one 
> package for the REQ and ACK job
>
> /Monk
>
> *From:*Deucher, Alexander
> *Sent:* 2018年3月8日10:53
> *To:* Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian 
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Mao, David <David.Mao-5C7GfCeVMHo@public.gmane.org>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Jin, Jian-Rong 
> <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>
> *Subject:* Re: deprecated register issues
>
> I think there are more than just CC_RB_BACKEND_DISABLE that could 
> cause this problem. IIRC, some entire class of gfx registers could 
> cause it, it just happened that this was one of the only ones we 
> readback via mmio.  Also for the save and restore list, I think the 
> RLC uses a different interface to read back the registers so it may 
> not be affected the same way.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Liu, Monk
> *Sent:* Wednesday, March 7, 2018 9:42:41 PM
> *To:* Deucher, Alexander; Koenig, Christian; Mao, David
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jin, Jian-Rong
> *Subject:* RE: deprecated register issues
>
> Hi guys
>
> According to Christian’s found, reading this register would make vm 
> hub failed to finish the vm flush request , e.g.: sdma is doing vm 
> flush which first write data to vm_invalidat_req and read result from 
> vm_invalidate_ack, but found driver will forever failed to get the 
> correct value from vm_invalidate_ack if the meantime BIF is reading 
> this CC_RB_BACKEND_DISABLE register.
>
> Now SR-IOV world switch also may get such similar trouble, see below 
> save_restore_list ( during world_switch, RLCV will save current VF’s 
> register according to this list and restore all those registers when 
> loading back this VF)
>
> uint32 register_restore[] = {
>
> (uint32)((0x3000 << 18) | mmPA_SC_FIFO_SIZE),   /* SC   */
>
> 0x00000001,
>
> *(uint32)((0x3000 << 18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC 
> PER_SE  */*
>
> *0x00000000,*
>
> *(uint32)((0x3400 << 18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC 
> PER_SE  */*
>
> *0x00000000,*
>
> *(uint32)((0x3800 << 18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC 
> PER_SE  */*
>
> *0x00000000,*
>
> *(uint32)((0x3c00 << 18) | mmCC_RB_BACKEND_DISABLE),   /* SC SC 
> PER_SE  */*
>
> *0x00000000,*
>
> (uint32)((0x3000 << 18) | mmVGT_VTX_VECT_EJECT_REG),
>
> 0x00000001,
>
> (uint32)((0x3000 << 18) | mmVGT_DMA_DATA_FIFO_DEPTH),   /* IA WD  */
>
> 0x00000001,
>
> (uint32)((0x3000 << 18) | mmVGT_DMA_REQ_FIFO_DEPTH),   /* WD   */
>
> 0x00000001,
>
> (uint32)((0x3000 << 18) | mmVGT_DRAW_INIT_FIFO_DEPTH),   /* WD   */
>
> 0x00000001,
>
> (uint32)((0x3000 << 18) | mmVGT_CACHE_INVALIDATION),   /*  IA  */
>
> 0x00000001,
>
> (uint32)((0x3000 << 18) | mmVGT_RESET_DEBUG), /*  WD  */
>
> 0x00000001,
>
> (uint32)((0x3000 << 18) | mmVGT_FIFO_DEPTHS),
>
> I will do some test against this CC_RB_BACKEND_DISABLE register, see 
> if vm flush failure issue could be avoided by removing those four 
> register from SR list
>
> Thanks
>
> /Monk
>
> *From:*Deucher, Alexander
> *Sent:* 2018年3月7日23:13
> *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org 
> <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>>; Mao, David <David.Mao-5C7GfCeVMHo@public.gmane.org 
> <mailto:David.Mao-5C7GfCeVMHo@public.gmane.org>>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org 
> <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jin, Jian-Rong 
> <Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org <mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org>>
> *Subject:* Re: deprecated register issues
>
> Right.  We ran into issues with reading back that register at runtime 
> when UMDs queried it when other stuff was in flight, so we just read 
> it once at startup and cache the results. Now when UMDs request it, we 
> return the cached value.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Koenig, Christian
> *Sent:* Wednesday, March 7, 2018 9:31:13 AM
> *To:* Mao, David; Liu, Monk
> *Cc:* Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Jin, Jian-Rong
> *Subject:* Re: deprecated register issues
>
> Hi David,
>
> well I just figured that this is a misunderstanding.
>
> Accessing this register and some other deprecated registers can cause 
> problem when invalidating VMHUBs.
>
> This register itself isn't deprecated, the wording in a patch fixing 
> things is just a bit unclear.
>
> Question is is that register still accessed regularly or is it value 
> cached after startup?
>
> Regards,
> Christian.
>
> Am 07.03.2018 um 15:25 schrieb Mao, David:
>
>     We requires base driver to provide the mask of disabled RB.
>
>     This is why kernel read the CC_RB_BACKEND_DISABLE to collect the
>     harvest configuration.
>
>     Where did you get to know that the register is deprecated?
>
>     I think it should still be there.
>
>     Best Regards,
>
>     David
>
>         On Mar 7, 2018, at 9:49 PM, Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org
>         <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>         + UMD guys
>
>         Hi David
>
>         Do you know if*GC_USER_RB_BACKEND_DISABLE is still exist for
>         gfx9/vega10 ?*
>
>         **
>
>         *We found*CC_RB_BACKEND_DISABLE was deprecated but looks it is
>         still in use in kmd, so
>
>         I want to check with you both of above registers
>
>         Thanks
>
>         /Monk
>
>         *From:*amd-gfx
>         [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]*On Behalf
>         Of*Christian K?nig
>         *Sent:*2018年3月7日20:26
>         *To:*Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org <mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>>;
>         Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org
>         <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>
>         *Cc:*amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>         *Subject:*Re: deprecated register issues
>
>         Hi Monk,
>
>         I honestly don't have the slightest idea why we are still
>         accessing CC_RB_BACKEND_DISABLE. Maybe it still contains some
>         useful values?
>
>         Key point was that we needed to stop accessing it all the time
>         to avoid triggering problems.
>
>         Regards,
>         Christian.
>
>         Am 07.03.2018 um 13:11 schrieb Liu, Monk:
>
>             Hi Christian
>
>             I remember you and AlexD mentioned that a handful
>             registers are deprecated for greenland (gfx9)
>
>             e.g. CC_RB_BACKEND_DISABLE
>
>             do you know why we still have this routine ?
>
>             staticu32
>
>             gfx_v9_0_get_rb_active_bitmap(structamdgpu_device *adev)
>
>             {
>
>                 u32 data, mask;
>
>                 data =RREG32_SOC15(GC,
>
>             0, mmCC_RB_BACKEND_DISABLE);
>
>                 data |=RREG32_SOC15(GC,
>
>             0, mmGC_USER_RB_BACKEND_DISABLE);
>
>                 data &= CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;
>
>                 data >>=
>             GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;
>
>                 mask
>             =amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se/
>
>             adev->gfx.config.max_sh_per_se);
>
>             return(~data) & mask;
>
>             }
>
>             see that it still read CC_RB_BACKEND_DISABLE
>
>             thanks
>
>             /Monk
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------A90022607724C835746DF1C1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Monk,<br>
      <br>
      <blockquote type="cite"><span
          style="font-size:10.5pt;font-family:等线" lang="EN-US">While we
          can avoid such vm flush failure by stitch together of the
          sending REQ and reading ACK part, at least for compute ring
          this is confirmed.</span></blockquote>
      Well there are two misunderstanding here. <br>
      <br>
      First of all this solution doesn't really work, it just hides the
      problem because we don't do a world switch in between those two
      packets any more. And while we could change the SDMA, UVD and VCE
      firmware do to something similar you can't apply this solution to
      CPU based flushes.<br>
      <br>
      The second issue is that this isn't related to VMHUB flushing at
      all, it's just that VMHUB flushing is the first thing where you
      notice that something is wrong.<br>
      <br>
      The real problem is that when you access <span
        style="font-family:&quot;Calibri&quot;,sans-serif;color:black"
        lang="EN-US">CC_RB_BACKEND_DISABLE and a bunch of other
        registers the bus on Vega10 sometimes gets a hickup and drops
        other reads and writes.<br>
        <br>
        So we need to identify those registers and removes all accesses
        to them, otherwise working with the hardware will just be
        horrible unreliable in general.<br>
        <br>
        Regards,<br>
        Christian.<br>
      </span><br>
      Am 08.03.2018 um 04:05 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB044941CA8B586506C47EF57184DF0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style><!--
/* Font Definitions */
@font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;}
p.xmsonormal0, li.xmsonormal0, div.xmsonormal0
	{mso-style-name:x_msonormal0;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:宋体;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:宋体;}
span.xemailstyle21
	{mso-style-name:x_emailstyle21;
	font-family:等线;
	color:windowtext;}
span.xxapple-converted-space
	{mso-style-name:x_xapple-converted-space;}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:等线;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
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
            style="font-size:10.5pt;font-family:等线" lang="EN-US">Hi Alex<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US">While
            we can avoid such vm flush failure by stitch together of the
            sending REQ and reading ACK part, at least for compute ring
            this is confirmed.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US">And I
            believe for SDMA ring (even UVD/VCE ring) it could also be
            achieved.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US">But
            <a id="OWAAM88494E83DC8949F581E2AEBF1FC603DA"
              href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
              moz-do-not-send="true">
              <span style="font-family:等线;text-decoration:none">@Koenig,
                Christian</span></a> insist stitching together the REQ
            AND ACK part is not a formal way to fix the issue, instead
            just a walkaround and I cannot debate that<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US">What
            make me worry more is what if there are more registers like
            Alex said that behaves like this CC_RB_BACKEND_DISABLE,
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US">since
            we don’t know their names(too hard to filter them out!) so
            we couldn’t remove them all from SR list,
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US">So I
            still think we need plan B to handle above case,  A.K.A use
            one package for the REQ and ACK job<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US">/Monk<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal"><b><span
                  style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                  lang="EN-US">From:</span></b><span
                style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"> Deucher, Alexander
                <br>
                <b>Sent:</b> 2018</span><span style="font-size:11.0pt">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">3</span><span style="font-size:11.0pt">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US">8</span><span style="font-size:11.0pt">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                lang="EN-US"> 10:53<br>
                <b>To:</b> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>; Koenig,
                Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>; Mao, David
                <a class="moz-txt-link-rfc2396E" href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org">&lt;David.Mao-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Jin, Jian-Rong
                <a class="moz-txt-link-rfc2396E" href="mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org">&lt;Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <b>Subject:</b> Re: deprecated register issues<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <div id="divtagdefaultwrapper">
          <p><span
              style="font-family:&quot;Calibri&quot;,sans-serif;color:black"
              lang="EN-US">I think there are more than just
              CC_RB_BACKEND_DISABLE that could cause this problem. 
              IIRC, some entire class of gfx registers could cause it,
              it just happened that this was one of the only ones we
              readback via mmio.  Also for the save and restore list, I
              think the RLC uses a different interface to read back the
              registers so it may not be affected the same way.<o:p></o:p></span></p>
          <p><span
              style="font-family:&quot;Calibri&quot;,sans-serif;color:black"
              lang="EN-US"><o:p> </o:p></span></p>
          <p><span
              style="font-family:&quot;Calibri&quot;,sans-serif;color:black"
              lang="EN-US">Alex<o:p></o:p></span></p>
        </div>
        <div class="MsoNormal" style="text-align:center" align="center"><span
            lang="EN-US">
            <hr align="center" size="3" width="98%">
          </span></div>
        <div id="divRplyFwdMsg">
          <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"
                lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"
              lang="EN-US"> Liu, Monk<br>
              <b>Sent:</b> Wednesday, March 7, 2018 9:42:41 PM<br>
              <b>To:</b> Deucher, Alexander; Koenig, Christian; Mao,
              David<br>
              <b>Cc:</b> <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
              Jin, Jian-Rong<br>
              <b>Subject:</b> RE: deprecated register issues</span><span
              lang="EN-US"> <o:p></o:p></span></p>
          <div>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
          </div>
        </div>
        <div>
          <div>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">Hi
                guys
              </span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US"> </span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">According
                to Christian</span><span
                style="font-size:10.5pt;font-family:等线">’<span
                  lang="EN-US">s found, reading this register would make
                  vm hub failed to finish the vm flush request , e.g.:
                  sdma is doing vm flush which first write data to
                  vm_invalidat_req and read result from
                  vm_invalidate_ack, but found driver will forever
                  failed to get the correct value from vm_invalidate_ack
                  if the meantime BIF is reading this
                  CC_RB_BACKEND_DISABLE register.</span></span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US"> </span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">Now
                SR-IOV world switch also may get such similar trouble,
                see below save_restore_list ( during world_switch, RLCV
                will save current VF</span><span
                style="font-size:10.5pt;font-family:等线">’<span
                  lang="EN-US">s register according to this list and
                  restore all those registers when loading back this VF)</span></span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US"> </span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">uint32
                register_restore[] = {</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) | mmPA_SC_FIFO_SIZE),   /*
                SC   */</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                0x00000001,</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  (uint32)((0x3000 &lt;&lt; 18) |
                  mmCC_RB_BACKEND_DISABLE),   /* SC SC PER_SE  */</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  0x00000000,</span></b><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  (uint32)((0x3400 &lt;&lt; 18) |
                  mmCC_RB_BACKEND_DISABLE),   /* SC SC PER_SE  */</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  0x00000000,</span></b><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  (uint32)((0x3800 &lt;&lt; 18) |
                  mmCC_RB_BACKEND_DISABLE),   /* SC SC PER_SE  */</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  0x00000000,</span></b><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  (uint32)((0x3c00 &lt;&lt; 18) |
                  mmCC_RB_BACKEND_DISABLE),   /* SC SC PER_SE  */</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><b><span
                  style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                  0x00000000,</span></b><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) |
                mmVGT_VTX_VECT_EJECT_REG),      
              </span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                0x00000001,</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) |
                mmVGT_DMA_DATA_FIFO_DEPTH),   /* IA WD  */</span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                0x00000001,</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) |
                mmVGT_DMA_REQ_FIFO_DEPTH),   /* WD   */</span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                0x00000001,</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) |
                mmVGT_DRAW_INIT_FIFO_DEPTH),   /* WD   */</span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                0x00000001,</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) |
                mmVGT_CACHE_INVALIDATION),   /*  IA  */</span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                0x00000001,</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) | mmVGT_RESET_DEBUG),  
                /*  WD  */</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                0x00000001,</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">      
                (uint32)((0x3000 &lt;&lt; 18) |
                mmVGT_FIFO_DEPTHS),      
              </span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US"> </span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">I
                will do some test against this CC_RB_BACKEND_DISABLE
                register, see if vm flush failure issue could be avoided
                by removing those four register from SR list
              </span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US"> </span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">Thanks</span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US"> </span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US">/Monk</span><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="xmsonormal"><span
                style="font-size:10.5pt;font-family:等线" lang="EN-US"> </span><span
                lang="EN-US"><o:p></o:p></span></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0cm 0cm 0cm">
                <p class="xmsonormal"><b><span
                      style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                      lang="EN-US">From:</span></b><span
                    style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US"> Deucher, Alexander
                    <br>
                    <b>Sent:</b> 2018</span><span
                    style="font-size:11.0pt">年</span><span
                    style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US">3</span><span style="font-size:11.0pt">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US">7</span><span style="font-size:11.0pt">日</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                    lang="EN-US"> 23:13<br>
                    <b>To:</b> Koenig, Christian &lt;<a
                      href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    Mao, David &lt;<a href="mailto:David.Mao-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">David.Mao-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                    Liu, Monk &lt;<a href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <b>Cc:</b> <a
                      href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                      moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                    Jin, Jian-Rong &lt;<a
                      href="mailto:Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">Jian-Rong.Jin-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                    <b>Subject:</b> Re: deprecated register issues</span><span
                    lang="EN-US"><o:p></o:p></span></p>
              </div>
            </div>
            <p class="xmsonormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <div id="x_divtagdefaultwrapper">
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black"
                  lang="EN-US">Right.  We ran into issues with reading
                  back that register at runtime when UMDs queried it
                  when other stuff was in flight, so we just read it
                  once at startup and cache the results. Now when UMDs
                  request it, we return the cached value.</span><span
                  lang="EN-US"><o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black"
                  lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif;color:black"
                  lang="EN-US">Alex</span><span lang="EN-US"><o:p></o:p></span></p>
            </div>
            <div class="MsoNormal" style="text-align:center"
              align="center"><span lang="EN-US">
                <hr align="center" size="3" width="98%">
              </span></div>
            <div id="x_divRplyFwdMsg">
              <p class="xmsonormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"
                    lang="EN-US">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"
                  lang="EN-US"> Koenig, Christian<br>
                  <b>Sent:</b> Wednesday, March 7, 2018 9:31:13 AM<br>
                  <b>To:</b> Mao, David; Liu, Monk<br>
                  <b>Cc:</b> Deucher, Alexander; <a
                    href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                    moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                  Jin, Jian-Rong<br>
                  <b>Subject:</b> Re: deprecated register issues</span><span
                  lang="EN-US"> <o:p></o:p></span></p>
              <div>
                <p class="xmsonormal"><span lang="EN-US"> <o:p></o:p></span></p>
              </div>
            </div>
            <div>
              <div>
                <p class="xmsonormal" style="background:white"><span
                    lang="EN-US">Hi David,<br>
                    <br>
                    well I just figured that this is a misunderstanding.<br>
                    <br>
                    Accessing this register and some other deprecated
                    registers can cause problem when invalidating
                    VMHUBs.<br>
                    <br>
                    This register itself isn't deprecated, the wording
                    in a patch fixing things is just a bit unclear.<br>
                    <br>
                    Question is is that register still accessed
                    regularly or is it value cached after startup?
                    <br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    Am 07.03.2018 um 15:25 schrieb Mao, David:<o:p></o:p></span></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <p class="xmsonormal" style="background:white"><span
                    lang="EN-US">We requires base driver to provide the
                    mask of disabled RB.
                    <o:p></o:p></span></p>
                <div>
                  <p class="xmsonormal" style="background:white"><span
                      lang="EN-US">This is why kernel read the
                      CC_RB_BACKEND_DISABLE to collect the harvest
                      configuration.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="xmsonormal" style="background:white"><span
                      lang="EN-US">Where did you get to know that the
                      register is deprecated?<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="xmsonormal" style="background:white"><span
                      lang="EN-US">I think it should still be there.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="xmsonormal" style="background:white"><span
                      lang="EN-US"> <o:p></o:p></span></p>
                </div>
                <div>
                  <p class="xmsonormal" style="background:white"><span
                      lang="EN-US">Best Regards,<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="xmsonormal" style="background:white"><span
                      lang="EN-US">David<o:p></o:p></span></p>
                  <div>
                    <p class="xmsonormal"
                      style="margin-bottom:12.0pt;background:white"><span
                        lang="EN-US"><o:p> </o:p></span></p>
                    <blockquote
                      style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <div>
                        <p class="xmsonormal" style="background:white"><span
                            lang="EN-US">On Mar 7, 2018, at 9:49 PM,
                            Liu, Monk &lt;<a
                              href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;
                            wrote:<o:p></o:p></span></p>
                      </div>
                      <p class="xmsonormal" style="background:white"><span
                          lang="EN-US"> <o:p></o:p></span></p>
                      <div>
                        <div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                style="font-size:10.5pt;font-family:等线"
                                lang="EN-US">+ UMD guys</span><span
                                lang="EN-US"><o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                style="font-size:10.5pt;font-family:等线"
                                lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                style="font-size:10.5pt;font-family:等线"
                                lang="EN-US">Hi David</span><span
                                lang="EN-US"><o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                style="font-size:10.5pt;font-family:等线"
                                lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                style="font-size:10.5pt;font-family:等线"
                                lang="EN-US">Do you know if<span
                                  class="xxapple-converted-space"> </span></span><b><span
style="font-size:10.5pt;font-family:&quot;Courier New&quot;"
                                  lang="EN-US">GC_USER_RB_BACKEND_DISABLE
                                  is still exist for gfx9/vega10 ?</span></b><span
                                lang="EN-US"><o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><b><span
                                  style="font-size:10.5pt;font-family:&quot;Courier
                                  New&quot;" lang="EN-US"> </span></b><span
                                lang="EN-US"><o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><b><span
                                  style="font-size:10.5pt;font-family:&quot;Courier
                                  New&quot;" lang="EN-US">We found<span
                                    class="xxapple-converted-space"> </span></span></b><span
                                lang="EN-US">CC_RB_BACKEND_DISABLE was
                                deprecated but looks it is still in use
                                in kmd, so<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                lang="EN-US">I want to check with you
                                both of above registers<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                lang="EN-US"> <o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                lang="EN-US">Thanks<span
                                  class="xxapple-converted-space"> </span><o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                lang="EN-US">/Monk<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                style="font-size:10.5pt;font-family:等线"
                                lang="EN-US"> </span><span lang="EN-US"><o:p></o:p></span></p>
                          </div>
                          <div>
                            <div style="border:none;border-top:solid
                              #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
                              <div>
                                <p class="xmsonormal"
                                  style="background:white"><b><span
                                      style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                      lang="EN-US">From:</span></b><span
                                    class="xxapple-converted-space"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                      lang="EN-US"> </span></span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                    lang="EN-US">amd-gfx [<a
                                      href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                                      moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]<span
                                      class="xxapple-converted-space"> </span><b>On
                                      Behalf Of<span
                                        class="xxapple-converted-space"> </span></b>Christian
                                    K?nig<br>
                                    <b>Sent:</b><span
                                      class="xxapple-converted-space"> </span>2018</span><span
                                    style="font-size:11.0pt">年</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                    lang="EN-US">3</span><span
                                    style="font-size:11.0pt">月</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                    lang="EN-US">7</span><span
                                    style="font-size:11.0pt">日</span><span
                                    class="xxapple-converted-space"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                      lang="EN-US"> </span></span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                    lang="EN-US">20:26<br>
                                    <b>To:</b><span
                                      class="xxapple-converted-space"> </span>Liu,
                                    Monk &lt;<a
                                      href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org"
                                      moz-do-not-send="true">Monk.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                                    Deucher, Alexander &lt;<a
                                      href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
                                      moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
                                    <b>Cc:</b><span
                                      class="xxapple-converted-space"> </span><a
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                    <b>Subject:</b><span
                                      class="xxapple-converted-space"> </span>Re:
                                    deprecated register issues</span><span
                                    lang="EN-US"><o:p></o:p></span></p>
                              </div>
                            </div>
                          </div>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                lang="EN-US"> <o:p></o:p></span></p>
                          </div>
                          <div>
                            <div>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  lang="EN-US">Hi Monk,<br>
                                  <br>
                                  I honestly don't have the slightest
                                  idea why we are still accessing
                                  CC_RB_BACKEND_DISABLE. Maybe it still
                                  contains some useful values?<br>
                                  <br>
                                  Key point was that we needed to stop
                                  accessing it all the time to avoid
                                  triggering problems.<br>
                                  <br>
                                  Regards,<br>
                                  Christian.<br>
                                  <br>
                                  Am 07.03.2018 um 13:11 schrieb Liu,
                                  Monk:<o:p></o:p></span></p>
                            </div>
                          </div>
                          <blockquote
                            style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <div id="x_x_divtagdefaultwrapper">
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US">Hi Christian</span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US"> </span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US">I remember you and AlexD
                                  mentioned that a handful registers are
                                  deprecated for greenland (gfx9)</span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US">e.g.
                                  CC_RB_BACKEND_DISABLE</span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US"> </span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US">do you know why we still
                                  have this routine ?</span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#569CD6"
                                        lang="EN-US">static</span><span
                                        class="xxapple-converted-space"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                          New&quot;;color:#D4D4D4"
                                          lang="EN-US"> </span></span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">u32</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#DCDCAA"
                                        lang="EN-US">gfx_v9_0_get_rb_active_bitmap</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">(</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#569CD6"
                                        lang="EN-US">struct</span><span
                                        class="xxapple-converted-space"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                          New&quot;;color:#D4D4D4"
                                          lang="EN-US"> </span></span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">amdgpu_device
                                        *adev)</span><span lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">{</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">    u32 data, mask;</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">    data =<span
                                          class="xxapple-converted-space"> </span></span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#DCDCAA"
                                        lang="EN-US">RREG32_SOC15</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">(GC,</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#B5CEA8"
                                        lang="EN-US">0</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">,
                                        mmCC_RB_BACKEND_DISABLE);</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">    data |=<span
                                          class="xxapple-converted-space"> </span></span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#DCDCAA"
                                        lang="EN-US">RREG32_SOC15</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">(GC,</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#B5CEA8"
                                        lang="EN-US">0</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">,
                                        mmGC_USER_RB_BACKEND_DISABLE);</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">    data &amp;=
                                        CC_RB_BACKEND_DISABLE__BACKEND_DISABLE_MASK;</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">    data &gt;&gt;=
GC_USER_RB_BACKEND_DISABLE__BACKEND_DISABLE__SHIFT;</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">    mask =<span
                                          class="xxapple-converted-space"> </span></span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#DCDCAA"
                                        lang="EN-US">amdgpu_gfx_create_bitmask</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">(adev-&gt;</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#9CDCFE"
                                        lang="EN-US">gfx</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">.</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#9CDCFE"
                                        lang="EN-US">config</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">.</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#9CDCFE"
                                        lang="EN-US">max_backends_per_se</span><span
                                        class="xxapple-converted-space"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                          New&quot;;color:#D4D4D4"
                                          lang="EN-US"> </span></span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">/</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">                    
                                        adev-&gt;</span><span
                                        lang="EN-US">gfx</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">.</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#9CDCFE"
                                        lang="EN-US">config</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">.</span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#9CDCFE"
                                        lang="EN-US">max_sh_per_se</span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">);</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">    </span><span
                                        style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#C586C0"
                                        lang="EN-US">return</span><span
                                        class="xxapple-converted-space"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                          New&quot;;color:#D4D4D4"
                                          lang="EN-US"> </span></span><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">(~data) &amp; mask;</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                                <div>
                                  <div>
                                    <p class="xmsonormal"
                                      style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                        New&quot;;color:#D4D4D4"
                                        lang="EN-US">}</span><span
                                        lang="EN-US"><o:p></o:p></span></p>
                                  </div>
                                </div>
                                <div>
                                  <p class="xmsonormal"
                                    style="line-height:14.25pt;background:#1E1E1E"><span
style="font-size:10.5pt;font-family:&quot;Courier
                                      New&quot;;color:#D4D4D4"
                                      lang="EN-US"> </span><span
                                      lang="EN-US"><o:p></o:p></span></p>
                                </div>
                              </div>
                              <div>
                                <p class="xmsonormal"
                                  style="background:white"><span
                                    style="font-family:&quot;Calibri&quot;,sans-serif"
                                    lang="EN-US"> </span><span
                                    lang="EN-US"><o:p></o:p></span></p>
                              </div>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US">see that it still
                                  read CC_RB_BACKEND_DISABLE</span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US"> </span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US">thanks</span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US"> </span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US">/Monk</span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                              <p class="xmsonormal"
                                style="background:white"><span
                                  style="font-size:9.0pt;font-family:&quot;Calibri&quot;,sans-serif"
                                  lang="EN-US"> </span><span
                                  lang="EN-US"><o:p></o:p></span></p>
                            </div>
                          </blockquote>
                          <div>
                            <p class="xmsonormal"
                              style="background:white"><span
                                lang="EN-US"> <o:p></o:p></span></p>
                          </div>
                        </div>
                      </div>
                    </blockquote>
                  </div>
                  <p class="xmsonormal" style="background:white"><span
                      lang="EN-US"> <o:p></o:p></span></p>
                </div>
              </blockquote>
              <p class="xmsonormal" style="background:white"><span
                  lang="EN-US"> <o:p></o:p></span></p>
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

--------------A90022607724C835746DF1C1--

--===============1409692106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1409692106==--
