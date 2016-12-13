From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [RFC] Using DC in amdgpu for upcoming GPU
Date: Tue, 13 Dec 2016 15:09:13 +0000
Message-ID: <BN6PR12MB16837DC9F895CEBFFE09BE70F79B0@BN6PR12MB1683.namprd12.prod.outlook.com>
References: <55d5e664-25f7-70e0-f2f5-9c9daf3efdf6@amd.com>
 <CAPM=9tx+j9-3fZNY=peLjdsVqyLS6i3V-sV3XrnYsK2YuhWRBA@mail.gmail.com>
 <5a1f2762-f1e0-05f1-3c16-173cb1f46571@amd.com>
 <20161213094035.GA10916@wunner.de>
 <0fcd4fc6-970c-da48-f790-e927c79cca26@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0886257512=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <0fcd4fc6-970c-da48-f790-e927c79cca26@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Cheng, Tony" <Tony.Cheng@amd.com>, Lukas Wunner <lukas@wunner.de>, "Bridgman, John" <John.Bridgman@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0886257512==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16837DC9F895CEBFFE09BE70F79B0BN6PR12MB1683namp_"

--_000_BN6PR12MB16837DC9F895CEBFFE09BE70F79B0BN6PR12MB1683namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Our driver code and most of the drm is MIT/X11 licensed.  Lot of other non =
GPL OSes (e.g., the BSDs) already import Linux drm drivers and core code.

Alex

From: Cheng, Tony
Sent: Tuesday, December 13, 2016 10:04 AM
To: Lukas Wunner; Bridgman, John
Cc: Dave Airlie; Wentland, Harry; Grodzovsky, Andrey; amd-gfx mailing list;=
 dri-devel; Deucher, Alexander
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU


Only DM that's open source is amdgpu_dm.  the rest will remain closed sourc=
e.  I remember we had discussion around legal issues with our grand plan of=
 unifying everything, and I remember maybe it was John who assured us that =
it's okay.  John can you chime in how it would work with GPLv2 licsense?

On 12/13/2016 4:40 AM, Lukas Wunner wrote:

On Mon, Dec 12, 2016 at 09:52:08PM -0500, Cheng, Tony wrote:

With DC the display hardware programming, resource optimization, power

management and interaction with rest of system will be fully validated

across multiple OSs.



Do I understand DAL3.jpg correctly that the macOS driver builds on top

of DAL Core?  I'm asking because the graphics drivers shipping with

macOS as well as on Apple's EFI Firmware Volume are closed source.
macOS currently ship with their own driver.  I can't really comment on what=
 macOS do without getting into trouble.




If the Linux community contributes to DC, I guess those contributions

can generally be assumed to be GPLv2 licensed.  Yet a future version

of the macOS driver would incorporate those contributions in the same

binary as their closed source OS-specific portion.
I am struggling with that these comminty contributions to DC would be.

Us AMD developer has access to HW docs and designer and we are still spendi=
ng 50% of our time figuring out why our HW doesn't work right. I can't imag=
e community doing much of this heavy lifting.






I don't quite see how that would be legal but maybe I'm missing

something.



Presumably the situation with the Windows driver is the same.



I guess you could maintain a separate branch sans community contributions

which would serve as a basis for closed source drivers, but not sure if

that is feasible given your resource constraints.
Dave sent us series of patch to show how it would look like if someone were=
 to change DC.  These changes are more removing code that DRM already has a=
nd deleting/clean up stuff.  I guess we can nak all changes and "rewrite" o=
ur own version of clean up patch community want to see?



Thanks,



Lukas


--_000_BN6PR12MB16837DC9F895CEBFFE09BE70F79B0BN6PR12MB1683namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	color:black;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	color:black;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	color:black;}
span.EmailStyle22
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
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Our driver code and mo=
st of the drm is MIT/X11 licensed.&nbsp; Lot of other non GPL OSes (e.g., t=
he BSDs) already import Linux drm drivers and core code.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">Alex<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext">From:</span></b><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:windowtext"> Cheng, Tony
<br>
<b>Sent:</b> Tuesday, December 13, 2016 10:04 AM<br>
<b>To:</b> Lukas Wunner; Bridgman, John<br>
<b>Cc:</b> Dave Airlie; Wentland, Harry; Grodzovsky, Andrey; amd-gfx mailin=
g list; dri-devel; Deucher, Alexander<br>
<b>Subject:</b> Re: [RFC] Using DC in amdgpu for upcoming GPU<o:p></o:p></s=
pan></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Only DM that&#8217;s open source is amdgpu_dm.&nb=
sp; the rest will remain closed source.&nbsp; I remember we had discussion =
around legal issues with our grand plan of unifying everything, and I remem=
ber maybe it was John who assured us that it's okay.&nbsp;
 John can you chime in how it would work with GPLv2 licsense? <o:p></o:p></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;">On 12/13/2016 4:40 AM, Lukas Wunner =
wrote:<o:p></o:p></span></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>On Mon, Dec 12, 2016 at 09:52:08PM -0500, Cheng, Tony wrote:<o:p></o:p=
></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>With DC the display hardware programming, resource optimization, power=
<o:p></o:p></pre>
<pre>management and interaction with rest of system will be fully validated=
<o:p></o:p></pre>
<pre>across multiple OSs.<o:p></o:p></pre>
</blockquote>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Do I understand DAL3.jpg correctly that the macOS driver builds on top=
<o:p></o:p></pre>
<pre>of DAL Core?&nbsp; I'm asking because the graphics drivers shipping wi=
th<o:p></o:p></pre>
<pre>macOS as well as on Apple's EFI Firmware Volume are closed source.<o:p=
></o:p></pre>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;">macOS currently ship with their own =
driver.&nbsp; I can't really comment on what macOS do without getting into =
trouble.<br>
<br>
<o:p></o:p></span></p>
<pre><o:p>&nbsp;</o:p></pre>
<pre>If the Linux community contributes to DC, I guess those contributions<=
o:p></o:p></pre>
<pre>can generally be assumed to be GPLv2 licensed.&nbsp; Yet a future vers=
ion<o:p></o:p></pre>
<pre>of the macOS driver would incorporate those contributions in the same<=
o:p></o:p></pre>
<pre>binary as their closed source OS-specific portion.<o:p></o:p></pre>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;">I am struggling with that these comm=
inty contributions to DC would be.&nbsp;
<br>
<br>
Us AMD developer has access to HW docs and designer and we are still spendi=
ng 50% of our time figuring out why our HW doesn't work right. I can't imag=
e community doing much of this heavy lifting.<br>
<br>
<o:p></o:p></span></p>
<pre><o:p>&nbsp;</o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>I don't quite see how that would be legal but maybe I'm missing<o:p></=
o:p></pre>
<pre>something.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Presumably the situation with the Windows driver is the same.<o:p></o:=
p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>I guess you could maintain a separate branch sans community contributi=
ons<o:p></o:p></pre>
<pre>which would serve as a basis for closed source drivers, but not sure i=
f<o:p></o:p></pre>
<pre>that is feasible given your resource constraints.<o:p></o:p></pre>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;">Dave sent us series of patch to show=
 how it would look like if someone were to change DC.&nbsp; These changes a=
re more removing code that DRM already has and deleting/clean
 up stuff.&nbsp; I guess we can nak all changes and &quot;rewrite&quot; our=
 own version of clean up patch community want to see?
<o:p></o:p></span></p>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Thanks,<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Lukas<o:p></o:p></pre>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ti=
mes New Roman&quot;,&quot;serif&quot;"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB16837DC9F895CEBFFE09BE70F79B0BN6PR12MB1683namp_--

--===============0886257512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0886257512==--
