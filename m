From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Wed, 21 Mar 2018 09:07:11 +0100
Message-ID: <471e7bdd-4faf-8a11-22e3-e9911d46d56b@gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
 <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
 <CAAxE2A7ffe2fkOQG0mFpPfP4uRKZ1BVTKWQ3Q+FhLWQnYU4nww@mail.gmail.com>
 <f7bce36e-d9c6-dc13-6b1f-0e2bf91aaff0@gmail.com>
 <DM5PR12MB18205326885F0857CEC4FAA6F7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
 <7bbc4bc8-1b44-efc3-44b7-47ebcb4b9c76@amd.com>
 <BY1PR12MB0504EA3793147F7A133CCC8FF5AB0@BY1PR12MB0504.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0023084570=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY1PR12MB0504EA3793147F7A133CCC8FF5AB0-PicGAnIBOoZIlHzfMOeg3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0023084570==
Content-Type: multipart/alternative;
 boundary="------------9603CD718AEC51D4E26FEB0D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9603CD718AEC51D4E26FEB0D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> But for CZ/ST, due to hardware limitation as discussed before, we 
> either use VRAM or GTT, not both.
That is actually not correct, as far as I read up on that the issue for 
switching between VRAM and GTT placement is minimal.

We should just make sure that we don't do this on every page flip, e.g. 
have double or triple buffering where one BO is in GTT and one in VRAM.

Regards,
Christian.

Am 20.03.2018 um 21:38 schrieb Li, Samuel:
>
> ØI think we can also have the case of systems with similar amounts of 
> carve out and system ram.  E.g., on a system with 4 GB of system 
> memory with 1 GB carved out for vram.  It would be a big waste not to 
> use VRAM.  We'll probably need a heuristic at some point.
>
> Agreed. But for CZ/ST, due to hardware limitation as discussed before, 
> we either use VRAM or GTT, not both. That might be changed for later 
> ASICs, but it is beyond the scope of this patch.
>
> Regards,
>
> Samuel Li
>
> *From:*Koenig, Christian
> *Sent:* Tuesday, March 20, 2018 4:17 PM
> *To:* Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Marek Olšák 
> <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Cc:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Michel Dänzer 
> <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; amd-gfx list 
> <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display 
> support
>
> That's what I meant with use up the otherwise unused VRAM. I don't see 
> any disadvantage of always setting GTT as second domain on APUs.
>
> My assumption was that we dropped this in userspace for displayable 
> surfaces, but Marek proved that wrong.
>
> So what we should do is actually to add GTT as fallback to all BOs on 
> APUs in Mesa and only make sure that the kernel is capable of handling 
> GTT with optimal performance (e.g. have user huge pages etc..).
>
> Christian.
>
> Am 20.03.2018 um 21:04 schrieb Deucher, Alexander:
>
>     I think we can also have the case of systems with similar amounts
>     of carve out and system ram.  E.g., on a system with 4 GB of
>     system memory with 1 GB carved out for vram.  It would be a big
>     waste not to use VRAM.  We'll probably need a heuristic at some point.
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>     <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>     *Sent:* Tuesday, March 20, 2018 2:32:49 PM
>     *To:* Marek Olšák; Koenig, Christian
>     *Cc:* Alex Deucher; Deucher, Alexander; Michel Dänzer; Li, Samuel;
>     amd-gfx list
>     *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather
>     display support
>
>     I don't think that is a good idea.
>
>     Ideally GTT should now have the same performance as VRAM on APUs
>     and we should use VRAM only for things where we absolutely have to
>     and to actually use up the otherwise unused VRAM.
>
>     Can you run some tests with all BOs forced to GTT and see if there
>     is any performance regression?
>
>     Christian.
>
>     Am 20.03.2018 um 15:51 schrieb Marek Olšák:
>
>         On Tue, Mar 20, 2018 at 9:55 AM, Christian König
>         <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>         <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>             Yes, exactly. And if I remember correctly Mesa used to
>             always set GTT as fallback on APUs, correct?
>
>         "used to" is the key part. Mesa doesn't force GTT on APUs
>         anymore. It expects that the combination of BO priorities and
>         BO move throttling will result in optimal BO placements over time.
>
>         Marek
>
>
>             The problem seems to be that this fallback isn't set for
>             displayable BOs.
>
>             So what needs to be done is to just enable this fallback
>             for displayable BOs as well if the kernel can handle it.
>
>             Christian.
>
>
>
>             Am 20.03.2018 um 00:01 schrieb Marek Olšák:
>
>                 In theory, Mesa doesn't have to do anything. It can
>                 continue setting VRAM and if the kernel has to put a
>                 display buffer into GTT, it doesn't matter (for Mesa).
>                 Whether the VRAM placement is really used is largely
>                 determined by BO priorities.
>
>                 The way I understand scather/gather is that it only
>                 allows the GTT placement. It doesn't force the GTT
>                 placement. Mesa also doesn't force the GTT placement.
>
>                 Marek
>
>                 On Mon, Mar 19, 2018 at 5:12 PM, Alex Deucher
>                 <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>                 wrote:
>
>                     On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel
>                     <Samuel.Li-5C7GfCeVMHo@public.gmane.org <mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>> wrote:
>                     >>to my earlier point, there may be cases where it
>                     is advantageous to put
>                     >> display buffers in vram even if s/g display is
>                     supported
>                     >
>                     > Agreed. That is also why the patch has the
>                     options to let user select where
>                     > to put display buffers.
>                     >
>                     > As whether to put the option in Mesa or kernel,
>                     it seems the difference is
>                     > not much. Also, since amdgpufb can request even
>                     without mesa, kernel might
>                     > be a better choice. In addition, putting in the
>                     kernel can save client’s
>                     > duplicate work(mesa, ogl, vulkan, 2d, kernel…)
>
>                     Why do we even expose different memory pools to
>                     the UMDs in the first
>                     place ;)  Each pool has performance
>                     characteristics that may be
>                     relevant for a particular work load.  Only the
>                     UMDs really know the
>                     finer points of those workloads. In general, you
>                     don't want the kernel
>                     dictating policy if you can avoid it.  The kernel
>                     exposes
>                     functionality and userspace sets the policy.  With
>                     the location set in
>                     userspace, each app/user can have whatever policy
>                     makes sense for
>                     their use case all at the same time without
>                     needing to tweak their
>                     kernel for every use case.
>
>                     Alex
>
>
>
>                 _______________________________________________
>
>                 amd-gfx mailing list
>
>                 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                 <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>                 https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>         _______________________________________________
>
>         amd-gfx mailing list
>
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------9603CD718AEC51D4E26FEB0D
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">But
          for CZ/ST, due to hardware limitation as discussed before, we
          either use VRAM or GTT, not both.</span></blockquote>
      That is actually not correct, as far as I read up on that the
      issue for switching between VRAM and GTT placement is minimal.<br>
      <br>
      We should just make sure that we don't do this on every page flip,
      e.g. have double or triple buffering where one BO is in GTT and
      one in VRAM.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 20.03.2018 um 21:38 schrieb Li, Samuel:<br>
    </div>
    <blockquote type="cite"
cite="mid:BY1PR12MB0504EA3793147F7A133CCC8FF5AB0-PicGAnIBOoZIlHzfMOeg3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
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
	font-family:"Times New Roman",serif;
	color:black;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.xm-3838486020630618689hoenzb
	{mso-style-name:x_m_-3838486020630618689hoenzb;}
span.xm-3838486020630618689m8572536124089128592m4947926278827078055hoenzb
	{mso-style-name:x_m_-3838486020630618689m_8572536124089128592m_4947926278827078055hoenzb;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#2F5496;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1133061508;
	mso-list-type:hybrid;
	mso-list-template-ids:-1982298110 -203232636 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;
	mso-fareast-font-family:SimSun;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p style="margin-left:.5in;text-indent:-.25in;mso-list:l0 level1
          lfo1"><!--[if !supportLists]--><span
            style="font-family:Wingdings"><span style="mso-list:Ignore">Ø<span
                style="font:7.0pt &quot;Times New Roman&quot;"> 
              </span></span></span><!--[endif]--><span
            style="font-family:&quot;Calibri&quot;,sans-serif">I think
            we can also have the case of systems with similar amounts of
            carve out and system ram.  E.g., on a system with 4 GB of
            system memory with 1 GB carved out for vram.  It would be a
            big waste not to use VRAM.  We'll probably need a heuristic
            at some point.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Agreed.
            But for CZ/ST, due to hardware limitation as discussed
            before, we either use VRAM or GTT, not both. That might be
            changed for later ASICs, but it is beyond the scope of this
            patch.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p> </o:p></span></p>
        <div>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Regards,<o:p></o:p></span></p>
          <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Samuel
              Li<o:p></o:p></span></p>
        </div>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p> </o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">
                  Koenig, Christian
                  <br>
                  <b>Sent:</b> Tuesday, March 20, 2018 4:17 PM<br>
                  <b>To:</b> Deucher, Alexander
                  <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>; Marek Olšák
                  <a class="moz-txt-link-rfc2396E" href="mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                  <b>Cc:</b> Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>;
                  Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">&lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;</a>; Li, Samuel
                  <a class="moz-txt-link-rfc2396E" href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org">&lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>; amd-gfx list
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable
                  scatter gather display support<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <p class="MsoNormal">That's what I meant with use up the
              otherwise unused VRAM. I don't see any disadvantage of
              always setting GTT as second domain on APUs.<br>
              <br>
              My assumption was that we dropped this in userspace for
              displayable surfaces, but Marek proved that wrong.<br>
              <br>
              So what we should do is actually to add GTT as fallback to
              all BOs on APUs in Mesa and only make sure that the kernel
              is capable of handling GTT with optimal performance (e.g.
              have user huge pages etc..).<br>
              <br>
              Christian.<br>
              <br>
              Am 20.03.2018 um 21:04 schrieb Deucher, Alexander:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div id="divtagdefaultwrapper">
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif">I
                  think we can also have the case of systems with
                  similar amounts of carve out and system ram.  E.g., on
                  a system with 4 GB of system memory with 1 GB carved
                  out for vram.  It would be a big waste not to use
                  VRAM.  We'll probably need a heuristic at some point.<o:p></o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif"><o:p> </o:p></span></p>
              <p><span
                  style="font-family:&quot;Calibri&quot;,sans-serif">Alex<o:p></o:p></span></p>
            </div>
            <div class="MsoNormal" style="text-align:center"
              align="center">
              <hr align="center" size="2" width="98%">
            </div>
            <div id="divRplyFwdMsg">
              <p class="MsoNormal"><b><span
                    style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Christian König
                  <a href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                    moz-do-not-send="true">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                  <b>Sent:</b> Tuesday, March 20, 2018 2:32:49 PM<br>
                  <b>To:</b> Marek Olšák; Koenig, Christian<br>
                  <b>Cc:</b> Alex Deucher; Deucher, Alexander; Michel
                  Dänzer; Li, Samuel; amd-gfx list<br>
                  <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable
                  scatter gather display support</span>
                <o:p></o:p></p>
              <div>
                <p class="MsoNormal"> <o:p></o:p></p>
              </div>
            </div>
            <div>
              <div>
                <p class="MsoNormal" style="background:white">I don't
                  think that is a good idea.<br>
                  <br>
                  Ideally GTT should now have the same performance as
                  VRAM on APUs and we should use VRAM only for things
                  where we absolutely have to and to actually use up the
                  otherwise unused VRAM.<br>
                  <br>
                  Can you run some tests with all BOs forced to GTT and
                  see if there is any performance regression?<br>
                  <br>
                  Christian.<br>
                  <br>
                  Am 20.03.2018 um 15:51 schrieb Marek Olšák:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <div>
                  <div>
                    <div>
                      <p class="MsoNormal" style="background:white">On
                        Tue, Mar 20, 2018 at 9:55 AM, Christian König
                        &lt;<a
                          href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                          target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                        wrote:<o:p></o:p></p>
                      <blockquote style="border:none;border-left:solid
                        #CCCCCC 1.0pt;padding:0in 0in 0in
                        6.0pt;margin-left:4.8pt;margin-right:0in">
                        <div>
                          <div>
                            <p class="MsoNormal"
                              style="background:white">Yes, exactly. And
                              if I remember correctly Mesa used to
                              always set GTT as fallback on APUs,
                              correct?<o:p></o:p></p>
                          </div>
                        </div>
                      </blockquote>
                      <div>
                        <p class="MsoNormal" style="background:white"><o:p> </o:p></p>
                      </div>
                      <div>
                        <p class="MsoNormal"
                          style="margin-bottom:12.0pt;background:white">"used
                          to" is the key part. Mesa doesn't force GTT on
                          APUs anymore. It expects that the combination
                          of BO priorities and BO move throttling will
                          result in optimal BO placements over time.<o:p></o:p></p>
                      </div>
                      <div>
                        <p class="MsoNormal" style="background:white">Marek<o:p></o:p></p>
                      </div>
                      <div>
                        <p class="MsoNormal" style="background:white"> <o:p></o:p></p>
                      </div>
                      <blockquote style="border:none;border-left:solid
                        #CCCCCC 1.0pt;padding:0in 0in 0in
                        6.0pt;margin-left:4.8pt;margin-right:0in">
                        <div>
                          <div>
                            <p class="MsoNormal"
                              style="background:white"><br>
                              The problem seems to be that this fallback
                              isn't set for displayable BOs.<br>
                              <br>
                              So what needs to be done is to just enable
                              this fallback for displayable BOs as well
                              if the kernel can handle it.<span
                                style="color:#888888"><br>
                                <br>
                                <span
                                  class="xm-3838486020630618689hoenzb">Christian.</span></span>
                              <o:p></o:p></p>
                            <div>
                              <div>
                                <p class="MsoNormal"
                                  style="background:white"><br>
                                  <br>
                                  Am 20.03.2018 um 00:01 schrieb Marek
                                  Olšák:<o:p></o:p></p>
                              </div>
                            </div>
                          </div>
                          <blockquote
                            style="margin-top:5.0pt;margin-bottom:5.0pt">
                            <div>
                              <div>
                                <div>
                                  <div>
                                    <div>
                                      <p class="MsoNormal"
                                        style="background:white">In
                                        theory, Mesa doesn't have to do
                                        anything. It can continue
                                        setting VRAM and if the kernel
                                        has to put a display buffer into
                                        GTT, it doesn't matter (for
                                        Mesa). Whether the VRAM
                                        placement is really used is
                                        largely determined by BO
                                        priorities.<o:p></o:p></p>
                                    </div>
                                    <div>
                                      <p class="MsoNormal"
                                        style="background:white"><o:p> </o:p></p>
                                    </div>
                                    <div>
                                      <p class="MsoNormal"
                                        style="background:white">The way
                                        I understand scather/gather is
                                        that it only allows the GTT
                                        placement. It doesn't force the
                                        GTT placement. Mesa also doesn't
                                        force the GTT placement.<o:p></o:p></p>
                                    </div>
                                    <div>
                                      <p class="MsoNormal"
                                        style="background:white"><o:p> </o:p></p>
                                    </div>
                                    <div>
                                      <p class="MsoNormal"
                                        style="background:white">Marek<o:p></o:p></p>
                                    </div>
                                    <div>
                                      <p class="MsoNormal"
                                        style="background:white"><o:p> </o:p></p>
                                    </div>
                                    <div>
                                      <p class="MsoNormal"
                                        style="background:white">On Mon,
                                        Mar 19, 2018 at 5:12 PM, Alex
                                        Deucher &lt;<a
                                          href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                          target="_blank"
                                          moz-do-not-send="true">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
                                        wrote:<o:p></o:p></p>
                                      <blockquote
                                        style="border:none;border-left:solid
                                        #CCCCCC 1.0pt;padding:0in 0in
                                        0in
                                        6.0pt;margin-left:4.8pt;margin-right:0in">
                                        <p class="MsoNormal"
                                          style="background:white">On
                                          Mon, Mar 19, 2018 at 4:29 PM,
                                          Li, Samuel &lt;<a
                                            href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org"
                                            target="_blank"
                                            moz-do-not-send="true">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;
                                          wrote:<br>
                                          &gt;&gt;to my earlier point,
                                          there may be cases where it is
                                          advantageous to put<br>
                                          &gt;&gt; display buffers in
                                          vram even if s/g display is
                                          supported<br>
                                          &gt;<br>
                                          &gt; Agreed. That is also why
                                          the patch has the options to
                                          let user select where<br>
                                          &gt; to put display buffers.<br>
                                          &gt;<br>
                                          &gt; As whether to put the
                                          option in Mesa or kernel, it
                                          seems the difference is<br>
                                          &gt; not much. Also, since
                                          amdgpufb can request even
                                          without mesa, kernel might<br>
                                          &gt; be a better choice. In
                                          addition, putting in the
                                          kernel can save client’s<br>
                                          &gt; duplicate work(mesa, ogl,
                                          vulkan, 2d, kernel…)<br>
                                          <br>
                                          Why do we even expose
                                          different memory pools to the
                                          UMDs in the first<br>
                                          place ;)  Each pool has
                                          performance characteristics
                                          that may be<br>
                                          relevant for a particular work
                                          load.  Only the UMDs really
                                          know the<br>
                                          finer points of those
                                          workloads. In general, you
                                          don't want the kernel<br>
                                          dictating policy if you can
                                          avoid it.  The kernel exposes<br>
                                          functionality and userspace
                                          sets the policy.  With the
                                          location set in<br>
                                          userspace, each app/user can
                                          have whatever policy makes
                                          sense for<br>
                                          their use case all at the same
                                          time without needing to tweak
                                          their<br>
                                          kernel for every use case.<br>
                                          <span style="color:#888888"><br>
                                            <span
class="xm-3838486020630618689m8572536124089128592m4947926278827078055hoenzb">Alex</span></span><o:p></o:p></p>
                                      </blockquote>
                                    </div>
                                  </div>
                                </div>
                                <p class="MsoNormal"
                                  style="background:white"><br>
                                  <br>
                                  <o:p></o:p></p>
                              </div>
                            </div>
                            <pre style="background:white">_______________________________________________<o:p></o:p></pre>
                            <pre style="background:white">amd-gfx mailing list<o:p></o:p></pre>
                            <pre style="background:white"><a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></pre>
                            <pre style="background:white"><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></pre>
                          </blockquote>
                          <p class="MsoNormal" style="background:white"><o:p> </o:p></p>
                        </div>
                      </blockquote>
                    </div>
                    <p class="MsoNormal" style="background:white"><o:p> </o:p></p>
                  </div>
                </div>
                <p class="MsoNormal" style="background:white"><br>
                  <br>
                  <o:p></o:p></p>
                <pre style="background:white">_______________________________________________<o:p></o:p></pre>
                <pre style="background:white">amd-gfx mailing list<o:p></o:p></pre>
                <pre style="background:white"><a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></pre>
                <pre style="background:white"><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></pre>
              </blockquote>
              <p class="MsoNormal" style="background:white"><o:p> </o:p></p>
            </div>
          </blockquote>
          <p class="MsoNormal"><o:p> </o:p></p>
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

--------------9603CD718AEC51D4E26FEB0D--

--===============0023084570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0023084570==--
