From: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU
Date: Tue, 13 Dec 2016 16:14:38 +0000
Message-ID: <BN6PR12MB1348DDDE4F10510BE614C230E89B0@BN6PR12MB1348.namprd12.prod.outlook.com>
References: <55d5e664-25f7-70e0-f2f5-9c9daf3efdf6@amd.com>
 <CAPM=9tx+j9-3fZNY=peLjdsVqyLS6i3V-sV3XrnYsK2YuhWRBA@mail.gmail.com>
 <5a1f2762-f1e0-05f1-3c16-173cb1f46571@amd.com>,
 <20161213094035.GA10916@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1266762744=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161213094035.GA10916-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Content-Language: en-CA
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
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1266762744==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1348DDDE4F10510BE614C230E89B0BN6PR12MB1348namp_"

--_000_BN6PR12MB1348DDDE4F10510BE614C230E89B0BN6PR12MB1348namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>>If the Linux community contributes to DC, I guess those contributions
can generally be assumed to be GPLv2 licensed.  Yet a future version
of the macOS driver would incorporate those contributions in the same
binary as their closed source OS-specific portion.


My understanding of the "general rule" was that contributions are normally =
assumed to be made under the "local license", ie GPLv2 for kernel changes i=
n general, but the appropriate lower-level license when made to a specific =
subsystem with a more permissive license (eg the X11 license aka MIT aka "G=
PL plus additional rights" license we use for almost all of the graphics su=
bsystem. If DC is not X11 licensed today it should be (but I'm pretty sure =
it already is).


We need to keep the graphics subsystem permissively licensed in general to =
allow uptake by other free OS projects such as *BSD, not just closed source=
.


Either way, driver-level maintainers are going to have to make sure that co=
ntributions have clear licensing.


Thanks,

John

________________________________
From: dri-devel <dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Luka=
s Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sent: December 13, 2016 4:40 AM
To: Cheng, Tony
Cc: Grodzovsky, Andrey; dri-devel; amd-gfx mailing list; Deucher, Alexander
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU

On Mon, Dec 12, 2016 at 09:52:08PM -0500, Cheng, Tony wrote:
> With DC the display hardware programming, resource optimization, power
> management and interaction with rest of system will be fully validated
> across multiple OSs.

Do I understand DAL3.jpg correctly that the macOS driver builds on top
of DAL Core?  I'm asking because the graphics drivers shipping with
macOS as well as on Apple's EFI Firmware Volume are closed source.

If the Linux community contributes to DC, I guess those contributions
can generally be assumed to be GPLv2 licensed.  Yet a future version
of the macOS driver would incorporate those contributions in the same
binary as their closed source OS-specific portion.

I don't quite see how that would be legal but maybe I'm missing
something.

Presumably the situation with the Windows driver is the same.

I guess you could maintain a separate branch sans community contributions
which would serve as a basis for closed source drivers, but not sure if
that is feasible given your resource constraints.

Thanks,

Lukas
_______________________________________________
dri-devel mailing list
dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel

--_000_BN6PR12MB1348DDDE4F10510BE614C230E89B0BN6PR12MB1348namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>&gt;&gt;<font size=3D"2"><span style=3D"font-size:10pt;">If the Linux co=
mmunity contributes to DC, I guess those contributions<br>
can generally be assumed to be GPLv2 licensed.&nbsp; Yet a future version<b=
r>
of the macOS driver would incorporate those contributions in the same<br>
binary as their closed source OS-specific portion.</span></font><br>
</p>
<br>
<p>My understanding of the &quot;general rule&quot; was that contributions =
are normally assumed to be made under the &quot;local license&quot;, ie GPL=
v2 for kernel changes in general, but the appropriate lower-level license w=
hen made to a specific subsystem with a more permissive
 license (eg the X11 license aka MIT aka &quot;GPL plus additional rights&q=
uot; license we use for almost all of the graphics subsystem. If DC is not =
X11 licensed today it should be (but I'm pretty sure it already is).&nbsp;<=
/p>
<p><br>
</p>
<p>We need to keep the graphics subsystem permissively licensed in general =
to allow uptake by other free OS projects such as *BSD, not just closed sou=
rce.
<br>
</p>
<p><br>
</p>
<p>Either way, driver-level maintainers are going to have to make sure that=
 contributions have clear licensing.
<br>
</p>
<p><br>
</p>
<p>Thanks,</p>
<p>John<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> dri-devel &lt;dri-d=
evel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Lukas Wunner &lt;lukas@=
wunner.de&gt;<br>
<b>Sent:</b> December 13, 2016 4:40 AM<br>
<b>To:</b> Cheng, Tony<br>
<b>Cc:</b> Grodzovsky, Andrey; dri-devel; amd-gfx mailing list; Deucher, Al=
exander<br>
<b>Subject:</b> Re: [RFC] Using DC in amdgpu for upcoming GPU</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Mon, Dec 12, 2016 at 09:52:08PM -0500, Cheng, T=
ony wrote:<br>
&gt; With DC the display hardware programming, resource optimization, power=
<br>
&gt; management and interaction with rest of system will be fully validated=
<br>
&gt; across multiple OSs.<br>
<br>
Do I understand DAL3.jpg correctly that the macOS driver builds on top<br>
of DAL Core?&nbsp; I'm asking because the graphics drivers shipping with<br=
>
macOS as well as on Apple's EFI Firmware Volume are closed source.<br>
<br>
If the Linux community contributes to DC, I guess those contributions<br>
can generally be assumed to be GPLv2 licensed.&nbsp; Yet a future version<b=
r>
of the macOS driver would incorporate those contributions in the same<br>
binary as their closed source OS-specific portion.<br>
<br>
I don't quite see how that would be legal but maybe I'm missing<br>
something.<br>
<br>
Presumably the situation with the Windows driver is the same.<br>
<br>
I guess you could maintain a separate branch sans community contributions<b=
r>
which would serve as a basis for closed source drivers, but not sure if<br>
that is feasible given your resource constraints.<br>
<br>
Thanks,<br>
<br>
Lukas<br>
_______________________________________________<br>
dri-devel mailing list<br>
dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel">https:=
//lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB1348DDDE4F10510BE614C230E89B0BN6PR12MB1348namp_--

--===============1266762744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1266762744==--
