From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Issue with amd-staging-4.7 on rx480
Date: Thu, 6 Oct 2016 14:12:30 +0000
Message-ID: <CY4PR12MB1768C5EE5166DBDB8156F199F7C70@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <CAHOSEu8-fa0RznKX7s-vbU_1g_eCaa-ZBp=0ySP5X_VqJA13Ng@mail.gmail.com>
 <CY4PR12MB1768EB91BA59663BC700C2AAF7C70@CY4PR12MB1768.namprd12.prod.outlook.com>,
 <CAHOSEu_mFEy5W5v=603raJC21xnAK5TScABCGm-8haO0-xRnkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0207130336=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHOSEu_mFEy5W5v=603raJC21xnAK5TScABCGm-8haO0-xRnkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0207130336==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768C5EE5166DBDB8156F199F7C70CY4PR12MB1768namp_"

--_000_CY4PR12MB1768C5EE5166DBDB8156F199F7C70CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,


Nothing between the UVD PG patch and the tip of stg-4.7 seems to be that re=
levant to 480.


If 8f877a8 is stable best you can do is bisect (shouldn't take long) with c=
old boots in between.  I too run Fedora 24 + GNOME and have good performanc=
e with Carrizo, Stoney, FIJI and Tonga (with the 5dw patch reverted) on the=
 tip of stg-4.7.  I have yet to test a polaris asic though...


Tom


________________________________
From: Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, October 6, 2016 10:07
To: StDenis, Tom
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: Issue with amd-staging-4.7 on rx480

I apologise if what I said was unclear. When I mean I reverted back to 8f87=
7a8, I mean I did a hard reset to this commit, i.e. reverting all commits/c=
hanges after this one. Basically I reverted the following commits: e3bb40f,=
 32ba038, 6892173, 55a9ab5, 4760300, 8ee5196, 381c90a, 5ae6bd0, 9a846b4, 04=
2f89f, and 78d1842. I just skimmed it last night, so I can't say for sure w=
here the issue is, but I'm assuming it's one of the drm/amdgpu commits, i.e=
. excluding commits9a846b4, 042f89f, and 78d1842.

I have only tested based on a snapshot at 8f877a8 and another snapshot at 7=
8d1842. The latter caused the issue, while the former seems fine. I just di=
scovered this last night, but I'll do some builds tonight to bisect the iss=
ue if need be.

Commit 6691270 on the other hand doesn't appear cause my issues. And lastly=
, I rarely do warm boots on my machine, so all of my tests have been cold b=
oots.

Thanks,
Jeremy

On Thu, Oct 6, 2016 at 9:41 AM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:To=
m.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:

If I read this correctly you reverted the commit which enables UVD PG on To=
nga?  I can't see how that impacts Polaris at all.


If I had to guess it's a dGPU state issue.  I've had on occasion to resort =
to cold reboots to bisect the kernel because the GPU firmware can get into =
states that aren't 100% resolved by a warm reboot.


There is a known bad commit which was reverted by Christian which I guess i=
sn't out on fdo yet.  https://cgit.freedesktop.org/~agd5f/linux/commit/?h=
=3Damd-staging-4.7&id=3D6691270952b6909218c520dcc71a342070c96874 that commi=
t seems to break dGPU support.


Cheers,

Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<ma=
ilto:alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Wednesday, October 5, 2016 22:54
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Issue with amd-staging-4.7 on rx480

Hello,

I'm currently regularly building and using the amd-staging-4.7 linux branch=
, which can be found here:

https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-4.7

It seems that one of the commits pushed on 2016-10-03 broke something, and =
I just wanted to give the devs a heads up in case no one noticed. I'm guess=
ing it was caused by one of the commits in the range of e3bb40f all the way=
 up to 78d1842.

I'm using an RX480, polaris10. The issue seems to have two symptoms:
- Plymouth (the boot splash screen) seems to get visually corrupted or just=
 blacked out.
- After login, the screen just remains black until I hard reset.

Reverting back to 8f877a8 seems to fix it. I'm using Fedora 24 with GNOME. =
As well, I haven't had time to bisect, but I can do so if desired.

Thanks!


--_000_CY4PR12MB1768C5EE5166DBDB8156F199F7C70CY4PR12MB1768namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi Jeremy,</p>
<p><br>
</p>
<p>Nothing between the UVD PG patch and the tip of stg-4.7 seems to be that=
 relevant to 480.</p>
<p><br>
</p>
<p>If 8f877a8 is stable best you can do is bisect (shouldn't take long) wit=
h cold boots in&nbsp;between. &nbsp;I too run Fedora 24 &#43; GNOME and hav=
e good performance with Carrizo, Stoney, FIJI and Tonga (with the 5dw patch=
 reverted) on the tip of stg-4.7. &nbsp;I have yet
 to test a polaris asic though...</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Jeremy Newton &lt;ale=
xjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 6, 2016 10:07<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: Issue with amd-staging-4.7 on rx480</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">I apologise if what I said was unclear. When I mean I reve=
rted back to&nbsp;<span style=3D"font-size:12.8px">8f877a8, I mean I did a =
hard reset to this commit, i.e. reverting all commits/changes after this on=
e. Basically I reverted the following commits:&nbsp;e3bb40f,&nbsp;32ba038,&=
nbsp;6892173,&nbsp;55a9ab5,&nbsp;4760300,&nbsp;8ee5196,&nbsp;381c90a,&nbsp;=
5ae6bd0,&nbsp;9a846b4,&nbsp;042f89f,
 and 78d1842. I just skimmed it last night, so I can't say for sure where t=
he issue is, but I'm assuming it's one of the&nbsp;drm/amdgpu&nbsp;commits,=
 i.e. excluding commits</span><span style=3D"font-size:12.8px">9a846b4,&nbs=
p;042f89f, and 78d1842</span><span style=3D"font-size:12.8px">.</span>
<div><span style=3D"font-size:12.8px"><br>
</span></div>
<div><span style=3D"font-size:12.8px">I have only tested based on a snapsho=
t at&nbsp;</span><span style=3D"font-size:12.8px">8f877a8 and another snaps=
hot at&nbsp;</span><span style=3D"font-size:12.8px">78d1842. The latter cau=
sed the issue, while the former seems fine. I just
 discovered this last night, but I'll do some builds tonight to bisect the =
issue if need be.</span><span style=3D"font-size:12.8px"><br>
</span>
<div><span style=3D"font-size:12.8px"><br>
</span></div>
<div>Commit&nbsp;6691270 on the other hand doesn't appear cause my issues. =
And lastly, I rarely do warm boots on my machine, so all of my tests have b=
een cold boots.</div>
</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Jeremy</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">On Thu, Oct 6, 2016 at 9:41 AM, StDenis, Tom <sp=
an dir=3D"ltr">
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_-3510539901589408934divtagdefaultwrapper" style=3D"font-size:1=
2pt; color:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>If I read this correctly you reverted the commit which enables UVD PG on=
 Tonga?&nbsp; I can't see how that impacts Polaris at all. &nbsp;</p>
<p><br>
</p>
<p>If I had to guess it's a dGPU state issue.&nbsp; I've had on occasion to=
 resort to cold reboots to bisect the kernel because the GPU firmware can g=
et into states that aren't 100% resolved by a warm reboot.</p>
<p><br>
</p>
<p>There is a known bad commit which was reverted by Christian which I gues=
s isn't out on fdo yet. &nbsp;<a href=3D"https://cgit.freedesktop.org/~agd5=
f/linux/commit/?h=3Damd-staging-4.7&amp;id=3D6691270952b6909218c520dcc71a34=
2070c96874" class=3D"m_-3510539901589408934OWAAutoLink" id=3D"m_-3510539901=
589408934LPlnk533633" target=3D"_blank">https://cgit.freedesktop.org/<wbr>~=
agd5f/linux/commit/?h=3Damd-<wbr>staging-4.7&amp;id=3D<wbr>6691270952b69092=
18c520dcc71a34<wbr>2070c96874</a>&nbsp;that
 commit seems to break dGPU support.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"m_-3510539901589408934divRplyFwdMsg" dir=3D"ltr"><font face=3D"C=
alibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b>=
 amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targe=
t=3D"_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>&gt;
 on behalf of Jeremy Newton &lt;<a href=3D"mailto:alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" targ=
et=3D"_blank">alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, October 5, 2016 22:54<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Issue with amd-staging-4.7 on rx480</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"h5">
<div>
<div dir=3D"ltr">
<div><span style=3D"text-align:right">
<div style=3D"text-align:start">Hello,</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">I'm currently regularly building and using =
the amd-staging-4.7 linux branch, which can be found here:</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start"><a href=3D"https://cgit.freedesktop.org/~ag=
d5f/linux/log/?h=3Damd-staging-4.7" id=3D"m_-3510539901589408934LPlnk449083=
" target=3D"_blank">https://cgit.freedesktop.org/~<wbr>agd5f/linux/log/?h=
=3Damd-<wbr>staging-4.7</a></div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">It seems that one of the commits pushed on =
2016-10-03 broke something, and I just wanted to give the devs a heads up i=
n case no one noticed. I'm guessing it was caused by one of the commits in =
the range of e3bb40f all the way up
 to 78d1842.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">I'm using an RX480, polaris10. The issue se=
ems to have two symptoms:</div>
<div style=3D"text-align:start">- Plymouth (the boot splash screen) seems t=
o get visually corrupted or just blacked out.</div>
<div style=3D"text-align:start">- After login, the screen just remains blac=
k until I hard reset.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">Reverting back to 8f877a8 seems to fix it. =
I'm using Fedora 24 with GNOME. As well, I haven't had time to bisect, but =
I can do so if desired.</div>
<div style=3D"text-align:start"><br>
</div>
<div style=3D"text-align:start">Thanks!</div>
</span></div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1768C5EE5166DBDB8156F199F7C70CY4PR12MB1768namp_--

--===============0207130336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0207130336==--
