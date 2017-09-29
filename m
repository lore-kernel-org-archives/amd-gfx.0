From: "Cyr, Aric" <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>
Subject: Re: global data in display/dc/dce/dce_abm.c
Date: Fri, 29 Sep 2017 02:05:18 +0000
Message-ID: <BN6PR1201MB0036CB1B864974604DA1FD54827E0@BN6PR1201MB0036.namprd12.prod.outlook.com>
References: <CAPM=9twUB=1GLcdGaKhwXr=B_baXXaXxCchBbwF0Pv4k=Ss+GQ@mail.gmail.com>
 <CAPM=9tykZtUS0y_njv-GpcO5hZp6cTswV6rLMc1dEgAu8VCTPA@mail.gmail.com>,
 <59b9f26c-cd5b-e056-5038-4d352b4f5877@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0864652416=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <59b9f26c-cd5b-e056-5038-4d352b4f5877-5C7GfCeVMHo@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koo, Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0864652416==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB0036CB1B864974604DA1FD54827E0BN6PR1201MB0036_"

--_000_BN6PR1201MB0036CB1B864974604DA1FD54827E0BN6PR1201MB0036_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Agreed, those should probably be per adapter. We'll take a look and fix the=
m up. Thanks for pointing them out.

Regards,
Aric
________________________________
From: Wentland, Harry
Sent: Thursday, September 28, 2017 8:29:58 PM
To: Dave Airlie; amd-gfx mailing list; Cyr, Aric; Koo, Anthony
Subject: Re: global data in display/dc/dce/dce_abm.c

On 2017-09-28 08:24 PM, Dave Airlie wrote:
> On 29 September 2017 at 10:18, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi Harry,
>>
>> stored_backlight_registers is a global static struct in bss segment,
>> it should probably be per device.
>
> There is also cached_wait_loop_number in
> amd/display/dc/dce/dce_dmcu.c
>

Thanks for spotting these. We probably want to fix them up.

I think both are used for embedded panels only which is why we haven't
noticed this being a problem.

Aric, Anthony, thoughts? Can you provide a patch to fix these?

Harry

> Dave.
>

--_000_BN6PR1201MB0036CB1B864974604DA1FD54827E0BN6PR1201MB0036_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black; background-color:white">
Hi Dave, <br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black; background-color:white">
Agreed, those should probably be per adapter. We'll take a look and fix the=
m up. Thanks for pointing them out.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black; background-color:white">
Regards,<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black; background-color:white">
Aric<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Thursday, September 28, 2017 8:29:58 PM<br>
<b>To:</b> Dave Airlie; amd-gfx mailing list; Cyr, Aric; Koo, Anthony<br>
<b>Subject:</b> Re: global data in display/dc/dce/dce_abm.c</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 2017-09-28 08:24 PM, Dave Airlie wrote:<br>
&gt; On 29 September 2017 at 10:18, Dave Airlie &lt;airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; w=
rote:<br>
&gt;&gt; Hi Harry,<br>
&gt;&gt;<br>
&gt;&gt; stored_backlight_registers is a global static struct in bss segmen=
t,<br>
&gt;&gt; it should probably be per device.<br>
&gt; <br>
&gt; There is also cached_wait_loop_number in<br>
&gt; amd/display/dc/dce/dce_dmcu.c<br>
&gt; <br>
<br>
Thanks for spotting these. We probably want to fix them up.<br>
<br>
I think both are used for embedded panels only which is why we haven't<br>
noticed this being a problem.<br>
<br>
Aric, Anthony, thoughts? Can you provide a patch to fix these?<br>
<br>
Harry<br>
<br>
&gt; Dave.<br>
&gt; <br>
</div>
</span></font>
</body>
</html>

--_000_BN6PR1201MB0036CB1B864974604DA1FD54827E0BN6PR1201MB0036_--

--===============0864652416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0864652416==--
