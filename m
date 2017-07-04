From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Make KIQ read/write register routine be atomic
Date: Tue, 4 Jul 2017 18:13:41 +0000
Message-ID: <DM5PR12MB11793F1D1012089CED2530C6F4D70@DM5PR12MB1179.namprd12.prod.outlook.com>
References: <1498770496-28032-1-git-send-email-Shaoyun.Liu@amd.com>
 <14d97048-a0ba-69cd-1eac-e82c4462c51f@daenzer.net>
 <d9834700-f977-e5d5-2c79-7c2332ba44e9@vodafone.de>,
 <DM5PR12MB11795DAAD88232D2874CEF17F4D30@DM5PR12MB1179.namprd12.prod.outlook.com>
 <BLUPR12MB04498F84A6D9E542753D234C84D60@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0155293285=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB04498F84A6D9E542753D234C84D60-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0155293285==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB11793F1D1012089CED2530C6F4D70DM5PR12MB1179namp_"

--_000_DM5PR12MB11793F1D1012089CED2530C6F4D70DM5PR12MB1179namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi , Monk
The TLB flush code is not used from IRQ , but it's been called while holdin=
g spin_lock . This is the reason why I want to change the routine be atomic=
.  After check the  register spec again , I found that the  TLB invalidatio=
n and  HDP coherency cntl  register are safe to use in the VFs  and  in cur=
rent code we already try to avoid use KIQ in TLB flush function  by directl=
y program the  TLB invalidate registers  but just missed one place on HDP f=
lush . So  I think  it 's better to fix the HDP flush code and  leave curre=
nt KIQ code un-touched .

Regards
Shaoyun.liu




From: Liu, Monk
Sent: Monday, July 03, 2017 5:45 AM
To: Liu, Shaoyun; Christian K=F6nig; Michel D=E4nzer
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be at=
omic


Hi Shaoyun



looks you want to make KIQ reg access be atomic & UN-interruptible,

I think most user of KIQ reg access is not in atomic context, so your patch=
 only benefit for the place using KIQ from IRQ.

why not implement another KIQ reg access function ? e.g. :

amdgpu_virt_kiq_rreg_atomic(...);

amdgpu_virt_kiq_wreg_atomic(...);





that way you can satisfy your requirement and not introduce unknown issue f=
or other places that calling original virt_kiq_r/weg() function.



because busy polling have chance to hang cpu in SR-IOV (imagine 16 VF, and =
many VF doing FLR one by one,   your busy polling may let guest kernel cpu =
stuck in ATOMIC_CONTEXT for more than 5 seconds )



BR Monk

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org<mai=
lto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, June 30, 2017 10:55:39 PM
To: Christian K=F6nig; Michel D=E4nzer
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: Make KIQ read/write register routine be at=
omic

Hi , Christian
The new code actually will not use the fence function , it just need a memo=
ry that expose both CPU and  GPU address .  Do you  really want to add the =
wrap functions that just expose the CPU and  GPU address in this case  ?

Regards
Shaoyun.liu


-----Original Message-----
From: Christian K=F6nig [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
Sent: Friday, June 30, 2017 3:57 AM
To: Michel D=E4nzer; Liu, Shaoyun
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be at=
omic

Am 30.06.2017 um 03:21 schrieb Michel D=E4nzer:
> On 30/06/17 06:08 AM, Shaoyun Liu wrote:
>> 1. Use spin lock instead of mutex in KIQ 2. Directly write to KIQ
>> fence address instead of using fence_emit() 3. Disable the interrupt
>> for KIQ read/write and use CPU polling
> This list indicates that this patch should be split up in at least
> three patches. :)
Yeah, apart from that is is not a good idea to mess with the fence internal=
s directly in the KIQ code, please add a helper in the fence code for this.

Regards,
Christian.
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB11793F1D1012089CED2530C6F4D70DM5PR12MB1179namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
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
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:1.0pt;
	margin-bottom:.0001pt;
	border:none;
	padding:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Hi , Monk
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">The TLB flush code is not=
 used from IRQ , but it&#8217;s been called while holding spin_lock . This =
is the reason why I want to change the routine be atomic.&nbsp; After
 check the &nbsp;register spec again , I found that the&nbsp; TLB invalidat=
ion and&nbsp; HDP coherency cntl &nbsp;register are safe to use in the VFs&=
nbsp; and&nbsp; in current code we already try to avoid use KIQ in TLB flus=
h function &nbsp;by directly program the&nbsp; TLB invalidate registers
 &nbsp;but just missed one place on HDP flush . So &nbsp;I think &nbsp;it &=
#8216;s better to fix the HDP flush code and&nbsp; leave current KIQ code u=
n-touched .
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Regards<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Shaoyun.liu<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Liu, Mon=
k
<br>
<b>Sent:</b> Monday, July 03, 2017 5:45 AM<br>
<b>To:</b> Liu, Shaoyun; Christian K=F6nig; Michel D=E4nzer<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Make KIQ read/write register routin=
e be atomic<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Hi Shaoyun <o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">looks you want to make KIQ reg access be atomic &amp; UN-interru=
ptible,<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">I think most user of KIQ reg access is not in atomic context, so=
 your patch only benefit for the place using KIQ from IRQ.<o:p></o:p></span=
></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">why not implement another KIQ reg access function ? e.g. :<o:p><=
/o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Courier New&quot;;color:#D4D=
4D4"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Courier New&quot;;color:#DCD=
CAA">amdgpu_virt_kiq_rreg_atomic(...);<br>
<br>
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Courier New&quot;;color:#DCD=
CAA">amdgpu_virt_kiq_wreg_atomic(...);</span><span style=3D"font-size:10.5p=
t;font-family:&quot;Courier New&quot;;color:#D4D4D4"><br>
<br>
<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"line-height:14.25pt;background:#1E1E1E"><sp=
an style=3D"font-size:10.5pt;font-family:&quot;Courier New&quot;;color:#D4D=
4D4"><o:p>&nbsp;</o:p></span></p>
</div>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">that way you can satisfy your requirement and not introduce unkn=
own issue for other places that calling original virt_kiq_r/weg() function.=
<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">because busy polling have chance to hang cpu in SR-IOV (imagine =
16 VF, and many VF doing FLR one by one, &nbsp; your busy polling may let g=
uest kernel cpu stuck in ATOMIC_CONTEXT for more than 5 seconds
 )<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">BR Monk<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org">Shaoy=
un.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, June 30, 2017 10:55:39 PM<br>
<b>To:</b> Christian K=F6nig; Michel D=E4nzer<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Make KIQ read/write register routin=
e be atomic</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">Hi , Christian<br>
The new code actually will not use the fence function , it just need a memo=
ry that expose both CPU and&nbsp; GPU address .&nbsp; Do you&nbsp; really w=
ant to add the wrap functions that just expose the CPU and&nbsp; GPU addres=
s in this case&nbsp; ?<br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
&nbsp;<br>
-----Original Message-----<br>
From: Christian K=F6nig [<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:=
deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]
<br>
Sent: Friday, June 30, 2017 3:57 AM<br>
To: Michel D=E4nzer; Liu, Shaoyun<br>
Cc: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be at=
omic<br>
<br>
Am 30.06.2017 um 03:21 schrieb Michel D=E4nzer:<br>
&gt; On 30/06/17 06:08 AM, Shaoyun Liu wrote:<br>
&gt;&gt; 1. Use spin lock instead of mutex in KIQ 2. Directly write to KIQ =
<br>
&gt;&gt; fence address instead of using fence_emit() 3. Disable the interru=
pt <br>
&gt;&gt; for KIQ read/write and use CPU polling<br>
&gt; This list indicates that this patch should be split up in at least <br=
>
&gt; three patches. :)<br>
Yeah, apart from that is is not a good idea to mess with the fence internal=
s directly in the KIQ code, please add a helper in the fence code for this.=
<br>
<br>
Regards,<br>
Christian.<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB11793F1D1012089CED2530C6F4D70DM5PR12MB1179namp_--

--===============0155293285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0155293285==--
