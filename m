From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/9] misc patches related to powerplay
Date: Fri, 9 Sep 2016 22:45:59 +0000
Message-ID: <CY4PR12MB1687D690F513C9C6F6FC9552FBFA0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1473428259-580-1-git-send-email-Rex.Zhu@amd.com>
 <ead74fd5-6d6f-ba4e-d0a1-fea21e7296dd@vodafone.de>
 <CY4PR12MB16872A6C90804AF1D368A194FBFA0@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <bf78afe1-9829-2316-2922-7e04d9babb75@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0701636676=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bf78afe1-9829-2316-2922-7e04d9babb75-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0701636676==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687D690F513C9C6F6FC9552FBFA0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687D690F513C9C6F6FC9552FBFA0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,


you are right,  I missed mult-gpu case. i will refine related patches.


Thanks.


Best Regards

Rex

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Saturday, September 10, 2016 1:51:30 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 0/9] misc patches related to powerplay

Hi Rex,

exactly as I feared, please don't do this.

I for example have a system with multiple PEG slots to be able to test diff=
erent hardware generations at the same time.

This is rather common setup for testing and will break horrible and quite u=
npredictable when the code suddenly overrides a global function table which=
 is used by multiple hardware generations.

Either create one function table for each variant or make the function tabl=
e a member of the hwmgr structure so that you can overwrite it in each inst=
ance without affecting others.

Regards,
Christian.

Am 09.09.2016 um 18:29 schrieb Zhu, Rex:


Hi Christian,



I used smu7_hwmgr for  all the asics of smu version 7 , CI and Vi. Please s=
ee  powerplay code refactoring patches.


But some functions in the table were different between those asics. so we n=
eeded to overload those functions for some asics.


for example:

from tonga. we used pptable version 1, but ci and iceland, no pptable,

so needed to overload related functions:


         hwmgr->hwmgr_func =3D &smu7_hwmgr_funcs;
         hwmgr->pptable_func =3D &pptable_v1_0_funcs;
         pp_smu7_thermal_initialize(hwmgr);
+       if (hwmgr->pp_table_version =3D=3D PP_TABLE_V0) {
+               hwmgr->hwmgr_func->get_pp_table_entry =3D &smu7_get_pp_tabl=
e_entry_v0;
+               hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D smu7_get=
_number_of_powerplay_table_entries_v0;
+               hwmgr->pptable_func =3D &pptable_funcs;
+       }


Best Regards

Rex



________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org><mailto:deathsimple@vodafo=
ne.de>
Sent: Friday, September 9, 2016 10:23:26 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org>
Subject: Re: [PATCH 0/9] misc patches related to powerplay

Patch #1-#7 and #9 are Acked-by: Christian K=F6nig <christian.koenig-urvtwAKJhsc@public.gmane.org=
m><mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Patch #8: That looks fishy, usually we don't want to override static
functions tables.

So what is the specific use case here?

Regards,
Christian.

Am 09.09.2016 um 15:37 schrieb Rex Zhu:
> Rex Zhu (9):
>    drm/amd/powerplay: mark symbols static where possible on tonga.
>    drm/amd/powerplay: add feature flags in hwmgr to enable/disable
>      special features.
>    drm/amd/powerplay: add module parameter for mask pp feature
>    drm/amd/powerplay: initialize platform caps in hwmgr_init.
>    drm/amd/powerplay: add common functiones for visiting pp table.
>    drm/amd/powerplay: wrap get evv voltage of fiji and polaris
>    drm/amd/powerplay: move smu related variable definitions to smumgr.
>    drm/amd/powerplay: delete const flag of hwmgr_funcs for overload.
>    drm/amd/powerplay: delete dupicated function and definition.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   4 +
>   drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |   2 +-
>   drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c   |   2 +-
>   .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |  34 ----
>   drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 186 ++++++++++++++=
++++---
>   .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c    |  10 +-
>   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c  |   7 +-
>   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.h  |   5 +-
>   .../drm/amd/powerplay/hwmgr/polaris10_powertune.h  |  13 --
>   drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c  |  21 +--
>   .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |   1 -
>   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  32 +++-
>   .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |   1 -
>   .../drm/amd/powerplay/smumgr/polaris10_smumgr.h    |  20 +++
>   drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |   1 +
>   16 files changed, 229 insertions(+), 111 deletions(-)
>




_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_CY4PR12MB1687D690F513C9C6F6FC9552FBFA0CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body bgcolor=3D"#FFFFFF" text=3D"#000000">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Christian,</p>
<p><br>
</p>
<p>you are right,&nbsp; I missed mult-gpu case. i will refine related patch=
es.</p>
<p><br>
</p>
<p>Thanks.&nbsp;<br>
</p>
<p><br>
</p>
<p>Best Regards</p>
<p>Rex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, September 10, 2016 1:51:30 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 0/9] misc patches related to powerplay</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">Hi Rex,<br>
<br>
exactly as I feared, please don't do this.<br>
<br>
I for example have a system with multiple PEG slots to be able to test diff=
erent hardware generations at the same time.<br>
<br>
This is rather common setup for testing and will break horrible and quite u=
npredictable when the code suddenly overrides a global function table which=
 is used by multiple hardware generations.<br>
<br>
Either create one function table for each variant or make the function tabl=
e a member of the hwmgr structure so that you can overwrite it in each inst=
ance without affecting others.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 09.09.2016 um 18:29 schrieb Zhu, Rex:<br>
</div>
<blockquote cite=3D"mid:CY4PR12MB16872A6C90804AF1D368A194FBFA0@CY4PR12MB168=
7.namprd12.prod.outlook.com" type=3D"cite">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-family: Calibri, Arial,
        Helvetica, sans-serif; background-color: rgb(255, 255, 255);">
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
<meta content=3D"text/html; charset=3DUTF-8">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" style=3D"font-family: Calibri,
            Arial, Helvetica, sans-serif; background-color: rgb(255,
            255, 255);">
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;">Hi Christian,</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
<p><span style=3D"font-size: 12pt;">I used&nbsp;smu7_hwmgr for &nbsp;all th=
e asics of smu&nbsp;version 7 ,&nbsp;CI and Vi. Please see &nbsp;</span><sp=
an style=3D"font-size: 12pt;">powerplay code refactoring patches</span><fon=
t color=3D"#333333"><span style=3D"font-size: 21px;">.</span></font></p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;">But some functions in th=
e table were different between those asics. so we needed to overload those =
functions for some asics.</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;">for example:</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;">from tonga. we used ppta=
ble version 1, but ci and iceland, no pptable,&nbsp;</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;">so needed to overload re=
lated functions:</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><span style=3D"color: rg=
b(33, 33, 33); font-size: 13.3333px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;hwm=
gr-&gt;hwmgr_func =3D &amp;smu7_hwmgr_funcs;</span><br style=3D"color: rgb(=
33, 33, 33); font-size: 13.3333px;">
<span style=3D"color: rgb(33, 33, 33); font-size:
                13.3333px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; hwmgr-&gt;pptable_func =3D &amp;pptable_v1_0_funcs;</span><br style=3D"co=
lor: rgb(33,
                33, 33); font-size: 13.3333px;">
<span style=3D"color: rgb(33, 33, 33); font-size:
                13.3333px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; pp_smu7_thermal_initialize(hwmgr);</span><br style=3D"color: rgb(33, 33, =
33); font-size: 13.3333px;">
<span style=3D"color: rgb(33, 33, 33); font-size:
                13.3333px;">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (h=
wmgr-&gt;pp_table_version =3D=3D PP_TABLE_V0) {</span><br style=3D"color: r=
gb(33, 33, 33);
                font-size: 13.3333px;">
<span style=3D"color: rgb(33, 33, 33); font-size:
                13.3333px;">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;get_pp_=
table_entry =3D &amp;smu7_get_pp_table_entry_v0;</span><br style=3D"color:
                rgb(33, 33, 33); font-size: 13.3333px;">
<span style=3D"color: rgb(33, 33, 33); font-size:
                13.3333px;">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;get_num=
_of_pp_table_entries =3D smu7_get_number_of_powerplay_table_entries_v0;</sp=
an><br style=3D"color: rgb(33, 33, 33); font-size: 13.3333px;">
<span style=3D"color: rgb(33, 33, 33); font-size:
                13.3333px;">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pptable_func =3D &amp;=
pptable_funcs;</span><br style=3D"color: rgb(33, 33,
                33); font-size: 13.3333px;">
<span style=3D"color: rgb(33, 33, 33); font-size:
                13.3333px;">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</sp=
an><br>
</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><span style=3D"color: rg=
b(33, 33, 33); font-size: 13.3333px;"><br>
</span></p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;">Best Regards </p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;">Rex</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
<p style=3D"color: rgb(0, 0, 0); font-size: 12pt;"><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"color: rgb(0, 0, 0); font-size: 12pt;
            display: inline-block; width: 98%;">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr" style=3D"color: rgb(0, 0,
            0); font-size: 12pt;">
<font style=3D"font-size:11pt" color=3D"#000000" face=3D"Calibri,
              sans-serif"><b>From:</b> Christian K=F6nig
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">=
&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
<b>Sent:</b> Friday, September 9, 2016 10:23:26 PM<br>
<b>To:</b> Zhu, Rex; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 0/9] misc patches related to powerplay</font>
<div>&nbsp;</div>
</div>
</div>
<font style=3D"color: rgb(0, 0, 0); font-size: 12pt;" size=3D"2"><span styl=
e=3D"font-size:10pt;">
<div class=3D"PlainText">Patch #1-#7 and #9 are Acked-by: Christian K=F6nig=
 <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org=
">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
<br>
Patch #8: That looks fishy, usually we don't want to override static <br>
functions tables.<br>
<br>
So what is the specific use case here?<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 09.09.2016 um 15:37 schrieb Rex Zhu:<br>
&gt; Rex Zhu (9):<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: mark symbols static where possibl=
e on tonga.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: add feature flags in hwmgr to ena=
ble/disable<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; special features.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: add module parameter for mask pp =
feature<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: initialize platform caps in hwmgr=
_init.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: add common functiones for visitin=
g pp table.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: wrap get evv voltage of fiji and =
polaris<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: move smu related variable definit=
ions to smumgr.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: delete const flag of hwmgr_funcs =
for overload.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: delete dupicated function and def=
inition.<br>
&gt;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c&nbsp;&nbs=
p; |&nbsp;&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c&nbsp; |&=
nbsp; 34 ----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; | 186 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c&nbsp;&nbsp=
;&nbsp; |&nbsp; 10 &#43;-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c&nbsp; |&=
nbsp;&nbsp; 7 &#43;-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.h&nbsp; |&=
nbsp;&nbsp; 5 &#43;-<br>
&gt;&nbsp;&nbsp; .../drm/amd/powerplay/hwmgr/polaris10_powertune.h&nbsp; |&=
nbsp; 13 --<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c&nbsp; |&=
nbsp; 21 &#43;--<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/inc/hardwaremanager.h&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp; 1 -<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 32 &#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; .../drm/amd/powerplay/smumgr/polaris10_smumgr.c&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp; 1 -<br>
&gt;&nbsp;&nbsp; .../drm/amd/powerplay/smumgr/polaris10_smumgr.h&nbsp;&nbsp=
;&nbsp; |&nbsp; 20 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; 16 files changed, 229 insertions(&#43;), 111 deletions(-)<=
br>
&gt;<br>
<br>
</div>
</span></font></div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre wrap=3D"">_______________________________________________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>
</pre>
</blockquote>
<p><br>
</p>
</div>
</body>
</html>

--_000_CY4PR12MB1687D690F513C9C6F6FC9552FBFA0CY4PR12MB1687namp_--

--===============0701636676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0701636676==--
