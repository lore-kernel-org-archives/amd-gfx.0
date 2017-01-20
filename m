From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 2/3] amdgpu: A new option to choose which device to
 run most tests
Date: Fri, 20 Jan 2017 22:08:27 +0000
Message-ID: <CY4PR12MB1640A585145DD409BEB07511F2710@CY4PR12MB1640.namprd12.prod.outlook.com>
References: <1484866391-17175-1-git-send-email-AlexBin.Xie@amd.com>
 <1484866391-17175-2-git-send-email-AlexBin.Xie@amd.com>,
 <CACvgo52ia8zBmvFm9P_zSv0fFntO1od71OawQ9e4GD64yj3DQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0354529542=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo52ia8zBmvFm9P_zSv0fFntO1od71OawQ9e4GD64yj3DQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0354529542==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1640A585145DD409BEB07511F2710CY4PR12MB1640namp_"

--_000_CY4PR12MB1640A585145DD409BEB07511F2710CY4PR12MB1640namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI Emil,


See below.


Thanks,

Alex


________________________________
From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, January 20, 2017 8:24 AM
To: Xie, AlexBin
Cc: amd-gfx mailing list
Subject: Re: [PATCH libdrm 2/3] amdgpu: A new option to choose which device=
 to run most tests

On 19 January 2017 at 22:53, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org> wrote:
> This can be used to test multiple GPUs
>
> Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
> ---
>  tests/amdgpu/amdgpu_test.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c
> index e42ef9d..2437db4 100644
> --- a/tests/amdgpu/amdgpu_test.c
> +++ b/tests/amdgpu/amdgpu_test.c
> @@ -108,12 +108,14 @@ static void display_test_suites(void)
>
>
>  /** Help string for command line parameters */
> -static const char usage[] =3D "Usage: %s [-hl] [<-s <suite id>> [-t <tes=
t id>]]\n"
> -                               "where:\n"
> -                               "       l - Display all suites and their =
tests\n"
> -                               "       h - Display this help\n";
> +static const char usage[] =3D
> +       "Usage: %s [-hl] [<-s <suite id>> [-t <test id>]] [-d <device_id>=
]\n"
> +       "where:\n"
> +       "       l - Display all suites and their tests\n"
> +       "       d - Choose which device to run tests\n"
You want to elaborate on what you mean with "device" here.
Even if currently "card0 is my Kabini, card1 Hawaii, card2 other" that
may change upon reboot.
So although very nice to say "0,1, 2..." things are non-deterministic.

[Alex Bin Xie] Originally I just want to give a simple solution for people =
to swap to test another GPU device.
Every time amdgpu_test runs, it lists the device id and its information. I =
was thinking to improve this but such as adding an option to list the devic=
es. So that the 0, 1 ,2 does not change if computer is not reboot. If 0, 1,=
 2 is not deterministic, I have to give up this human friendly interface...

How about choose the test device by bus ID?  I will add an option to list t=
he devices with BUS ID (if people run drmdevice program, they know the info=
rmation too). Then people can choose  device on which BUS ID to run the tes=
t. I will provide a new patch if there is no object to this.


-Emil

--_000_CY4PR12MB1640A585145DD409BEB07511F2710CY4PR12MB1640namp_
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
<p>HI Emil,</p>
<p><br>
</p>
<p>See below.</p>
<p><br>
</p>
<p>Thanks,</p>
<p>Alex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Emil Velikov &lt;em=
il.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, January 20, 2017 8:24 AM<br>
<b>To:</b> Xie, AlexBin<br>
<b>Cc:</b> amd-gfx mailing list<br>
<b>Subject:</b> Re: [PATCH libdrm 2/3] amdgpu: A new option to choose which=
 device to run most tests</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 19 January 2017 at 22:53, Alex Xie &lt;AlexBin.=
Xie-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; This can be used to test multiple GPUs<br>
&gt;<br>
&gt; Signed-off-by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; tests/amdgpu/amdgpu_test.c | 25 &#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<b=
r>
&gt;&nbsp; 1 file changed, 20 insertions(&#43;), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c<b=
r>
&gt; index e42ef9d..2437db4 100644<br>
&gt; --- a/tests/amdgpu/amdgpu_test.c<br>
&gt; &#43;&#43;&#43; b/tests/amdgpu/amdgpu_test.c<br>
&gt; @@ -108,12 &#43;108,14 @@ static void display_test_suites(void)<br>
&gt;<br>
&gt;<br>
&gt;&nbsp; /** Help string for command line parameters */<br>
&gt; -static const char usage[] =3D &quot;Usage: %s [-hl] [&lt;-s &lt;suite=
 id&gt;&gt; [-t &lt;test id&gt;]]\n&quot;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;where:\n&quot;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; l - Display all suites and their tests\n&quot;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; h - Display this help\n&quot;;<br>
&gt; &#43;static const char usage[] =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Usage: %s [-hl] [&lt;-=
s &lt;suite id&gt;&gt; [-t &lt;test id&gt;]] [-d &lt;device_id&gt;]\n&quot;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;where:\n&quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; l - Display all suites and their tests\n&quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; d - Choose which device to run tests\n&quot;<br>
You want to elaborate on what you mean with &quot;device&quot; here.<br>
Even if currently &quot;card0 is my Kabini, card1 Hawaii, card2 other&quot;=
 that<br>
may change upon reboot.<br>
So although very nice to say &quot;0,1, 2...&quot; things are non-determini=
stic.<br>
<br>
[Alex Bin Xie] Originally I just want to give a simple solution for people =
to swap to test another GPU device.<br>
Every time amdgpu_test runs, it lists the device id and its information. I =
was thinking to improve this but such as adding an option to list the devic=
es. So that the 0, 1 ,2 does not change if computer is not reboot. If 0, 1,=
 2 is not deterministic, I have
 to give up this human friendly interface...<br>
<br>
How about choose the test device by bus ID?&nbsp; I will add an option to l=
ist the devices with BUS ID (if people run drmdevice program, they know the=
 information too). Then people can choose&nbsp; device on which BUS ID to r=
un the test. I will provide a new patch if
 there is no object to this.<br>
<br>
<br>
-Emil<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1640A585145DD409BEB07511F2710CY4PR12MB1640namp_--

--===============0354529542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0354529542==--
