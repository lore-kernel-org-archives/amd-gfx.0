From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: KASAN caught amdgpu / HMM use-after-free
Date: Wed, 27 Feb 2019 18:32:11 +0000
Message-ID: <BN6PR12MB18090BDFE1DD800785C5ED76F7740@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <e8466985-a66b-468b-5fff-6e743180da67@daenzer.net>
 <83fde7eb-abab-e770-efd5-89bc9c39fdff@amd.com>
 <c26fa310-38d1-acba-cf82-bc6dc2f782c0@daenzer.net>,
 <35d7e134-6eef-9732-8ebf-83256e40eb65@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1734016698=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <35d7e134-6eef-9732-8ebf-83256e40eb65-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1734016698==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18090BDFE1DD800785C5ED76F7740BN6PR12MB1809namp_"

--_000_BN6PR12MB18090BDFE1DD800785C5ED76F7740BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Go ahead an apply it to amd-staging-drm-next.  It'll naturally fall out whe=
n I rebase it.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yang, Ph=
ilip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, February 27, 2019 1:05 PM
To: Michel D=E4nzer; J=E9r=F4me Glisse
Cc: linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: KASAN caught amdgpu / HMM use-after-free

amd-staging-drm-next will rebase to kernel 5.1 to pickup this fix
automatically. As a short-term workaround, please cherry-pick this fix
into your local repository.

Regards,
Philip

On 2019-02-27 12:33 p.m., Michel D=E4nzer wrote:
> On 2019-02-27 6:14 p.m., Yang, Philip wrote:
>> Hi Michel,
>>
>> Yes, I found the same issue and the bug has been fixed by Jerome:
>>
>> 876b462120aa mm/hmm: use reference counting for HMM struct
>>
>> The fix is on hmm-for-5.1 branch, I cherry-pick it into my local branch
>> to workaround the issue.
>
> Please push it to amd-staging-drm-next, so that others don't run into
> the issue as well.
>
>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18090BDFE1DD800785C5ED76F7740BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Go ahead an apply it to amd-staging-drm-next.&nbsp; It'll naturally fall ou=
t when I rebase it.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yang, Philip &lt;Philip.Yang@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 27, 2019 1:05 PM<br>
<b>To:</b> Michel D=E4nzer; J=E9r=F4me Glisse<br>
<b>Cc:</b> linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: KASAN caught amdgpu / HMM use-after-free</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">amd-staging-drm-next will rebase to kernel 5.1 to =
pickup this fix
<br>
automatically. As a short-term workaround, please cherry-pick this fix <br>
into your local repository.<br>
<br>
Regards,<br>
Philip<br>
<br>
On 2019-02-27 12:33 p.m., Michel D=E4nzer wrote:<br>
&gt; On 2019-02-27 6:14 p.m., Yang, Philip wrote:<br>
&gt;&gt; Hi Michel,<br>
&gt;&gt;<br>
&gt;&gt; Yes, I found the same issue and the bug has been fixed by Jerome:<=
br>
&gt;&gt;<br>
&gt;&gt; 876b462120aa mm/hmm: use reference counting for HMM struct<br>
&gt;&gt;<br>
&gt;&gt; The fix is on hmm-for-5.1 branch, I cherry-pick it into my local b=
ranch<br>
&gt;&gt; to workaround the issue.<br>
&gt; <br>
&gt; Please push it to amd-staging-drm-next, so that others don't run into<=
br>
&gt; the issue as well.<br>
&gt; <br>
&gt; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18090BDFE1DD800785C5ED76F7740BN6PR12MB1809namp_--

--===============1734016698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1734016698==--
