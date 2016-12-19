From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/8] dal: remove some unused wrappers
Date: Mon, 19 Dec 2016 12:53:38 +0000
Message-ID: <CY4PR12MB1768D6FCEC097FCDE97E314EF7910@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20161213064112.20004-1-airlied@gmail.com>
 <20161213064112.20004-3-airlied@gmail.com>
 <f30d9730-8d3d-4b9d-ced2-4a1bb93138d2@amd.com>,
 <CACvgo53HxQq4HhizR-+VY4W7cGb5O3XXmLUNhEGbipeo8ODjWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0854113316=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo53HxQq4HhizR-+VY4W7cGb5O3XXmLUNhEGbipeo8ODjWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0854113316==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768D6FCEC097FCDE97E314EF7910CY4PR12MB1768namp_"

--_000_CY4PR12MB1768D6FCEC097FCDE97E314EF7910CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Emil,


Thing is, with all due respect, the vast majority of DC contributions are l=
ikely to come from AMD at the moment.  The code is in high flux and require=
s knowledge about the hardware that the public does not possess.


That's not to say that submissions aren't welcomed.  But on code that is in=
 flux don't be shocked if you get a higher percentage of NAKs than in other=
 parts of the driver which are relatively static.


It's a bit of a catch.  The public (re: Linux) wants open, stable, efficien=
t, and featureful drivers but then they want to dictate to the vendor exact=
ly how that's going to be executed.  That doesn't really work in practice o=
r theory.  The kernel team has standards that AMD has to meet but the proce=
ss to get there won't always make everyone happy.


Once DC is actually cleaned up, validated, and merged into the kernel I sus=
pect the RB/NAK ratio will clean up.


Cheers,

Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Emil Vel=
ikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, December 19, 2016 07:46
To: Wentland, Harry
Cc: amd-gfx mailing list
Subject: Re: [PATCH 2/8] dal: remove some unused wrappers

Hi Harry,

On 14 December 2016 at 16:26, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org> wrote=
:
> They are still used all over the place (e.g.
> dc/dce110/dce110_resource.c:413).
>
> We should at least do an spatch to use kzalloc/krealloc/kfree across the
> board if the wrappers are an issue.
>
> NAKed
>
[Ignoring all the heat around the DC/DAL topic for a moment]

Pardon for reviving this old thread, yet I believe it's beneficial,
esp. for the less experienced open-source/kernel devs.

There is little-to-no merit of keeping dead code in upstream kernels.
That is, unless there's a series in discussion which uses the code ;-)

NACKs like this one are not cool, furthermore the tend to
alienate/push away people trying to help. With DC/DAL in mind, I think
you/others want all the help people can offer ;-)

Regards,
Emil
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_CY4PR12MB1768D6FCEC097FCDE97E314EF7910CY4PR12MB1768namp_
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
<p>Hi Emil,</p>
<p><br>
</p>
<p>Thing is, with all due respect, the vast majority of DC contributions ar=
e likely to come from AMD at the moment. &nbsp;The code is in high flux and=
 requires knowledge about the hardware that the public does not possess.</p=
>
<p><br>
</p>
<p>That's not to say that submissions aren't welcomed. &nbsp;But on code th=
at is in flux don't be shocked if you get a higher percentage of NAKs than =
in other parts of the driver which are relatively static.</p>
<p><br>
</p>
<p>It's a bit of a catch. &nbsp;The public (re: Linux) wants open, stable, =
efficient, and featureful drivers but then they want to dictate to the vend=
or exactly how that's going to be executed. &nbsp;That doesn't really work =
in practice or theory. &nbsp;The kernel team has
 standards that AMD has to meet but the process to get there won't always m=
ake everyone happy.</p>
<p><br>
</p>
<p>Once DC is actually cleaned up, validated, and merged into the kernel I =
suspect the RB/NAK ratio will clean up.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Emil Velikov &lt;emil.l.vel=
ikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, December 19, 2016 07:46<br>
<b>To:</b> Wentland, Harry<br>
<b>Cc:</b> amd-gfx mailing list<br>
<b>Subject:</b> Re: [PATCH 2/8] dal: remove some unused wrappers</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi Harry,<br>
<br>
On 14 December 2016 at 16:26, Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;=
 wrote:<br>
&gt; They are still used all over the place (e.g.<br>
&gt; dc/dce110/dce110_resource.c:413).<br>
&gt;<br>
&gt; We should at least do an spatch to use kzalloc/krealloc/kfree across t=
he<br>
&gt; board if the wrappers are an issue.<br>
&gt;<br>
&gt; NAKed<br>
&gt;<br>
[Ignoring all the heat around the DC/DAL topic for a moment]<br>
<br>
Pardon for reviving this old thread, yet I believe it's beneficial,<br>
esp. for the less experienced open-source/kernel devs.<br>
<br>
There is little-to-no merit of keeping dead code in upstream kernels.<br>
That is, unless there's a series in discussion which uses the code ;-)<br>
<br>
NACKs like this one are not cool, furthermore the tend to<br>
alienate/push away people trying to help. With DC/DAL in mind, I think<br>
you/others want all the help people can offer ;-)<br>
<br>
Regards,<br>
Emil<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk955156" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14821518066090.875104265451631" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14821518066070.13362218626518296" cellspacing=3D"0=
" style=3D"width: 90%; background-color: rgb(255, 255, 255); position: rela=
tive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: =
20px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted =
rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14821518066080.7046383869348254" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14821518066080.5099265648873654"></div>
<div id=3D"LPTitle_14821518066080.5966373441933683" style=3D"top: 0px; colo=
r: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_14821518066090.9322333198849966" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14821518066090.3291112186612033" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14821518066090.8497682457560758" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768D6FCEC097FCDE97E314EF7910CY4PR12MB1768namp_--

--===============0854113316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0854113316==--
