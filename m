From: Luke Miller <dodgyville-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bug reports for beginners.
Date: Wed, 7 Jun 2017 11:25:45 +1000
Message-ID: <CAFs5HV33E3Bq3pHFCzUidWXcpjkbNX2MUENa7JnX_83TGq7YRQ@mail.gmail.com>
References: <CAFs5HV1kA4OxDh5Kqe4r1CxBYcVNec6Ch_Wmc+dv79rsQ_QT7w@mail.gmail.com>
 <0910432c-a8d9-c66a-ae6e-7530f353d872@daenzer.net>
 <CADnq5_PTExrHF6WWOxpbOeLHptahYJtOoWqz98DpVZQ5t7MJPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968759225=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PTExrHF6WWOxpbOeLHptahYJtOoWqz98DpVZQ5t7MJPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0968759225==
Content-Type: multipart/alternative; boundary="f40304389034c9e3010551549e7b"

--f40304389034c9e3010551549e7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Done!

https://bugs.freedesktop.org/show_bug.cgi?id=3D101325

Also, running ue4editor with R600_DEBUG=3Dcheck_vm GALLIUM_DDEBUG=3D"pipeli=
ned
10000" set made a difference -- program crashed but didn't take out the
whole system. I take that as a good sign.

Luke

On 7 June 2017 at 00:09, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Mon, Jun 5, 2017 at 10:05 PM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> =
wrote:
> > On 03/06/17 07:46 AM, Luke Miller wrote:
> >>
> >> I have a recurring problem with one 3D program (UE4editor) crashing my
> >> computer during a particular operation.
> >>
> >> I believe the problem is at the DRM layer.
> >
> > It's actually more likely in Mesa. If you set either or both of the
> > following environment variables for running ue4editor:
> >
> > R600_DEBUG=3Dcheck_vm GALLIUM_DDEBUG=3D"pipelined 10000"
> >
> > it should create a file in ~/ddebug_dumps/ with more information about
> > the GPU hang.
> >
>
> Please also open a bug (https://bugs.freedesktop.org Product: Mesa,
> Component: radeonsi) and attach your dmesg and xorg log along with all
> of the relevent info from this thread.  That way we have a central
> location to discuss the issue and store all of the relevant
> information.
>
> Thanks,
>
> Alex
>

--f40304389034c9e3010551549e7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Done!<br><br><a href=3D"https://bugs.freedesktop=
.org/show_bug.cgi?id=3D101325">https://bugs.freedesktop.org/show_bug.cgi?id=
=3D101325</a><br><br></div>Also, running ue4editor with=20
R600_DEBUG=3Dcheck_vm GALLIUM_DDEBUG=3D&quot;pipelined 10000&quot; set made=
 a difference -- program crashed but didn&#39;t take out the whole system. =
I take that as a good sign.<br><br></div>Luke<br></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On 7 June 2017 at 00:09, Alex Deucher=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_=
blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><span class=3D"">On Mon, Jun 5, 2017 at 10:05 PM, Michel D=C3=A4n=
zer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wr=
ote:<br>
&gt; On 03/06/17 07:46 AM, Luke Miller wrote:<br>
&gt;&gt;<br>
&gt;&gt; I have a recurring problem with one 3D program (UE4editor) crashin=
g my<br>
&gt;&gt; computer during a particular operation.<br>
&gt;&gt;<br>
&gt;&gt; I believe the problem is at the DRM layer.<br>
&gt;<br>
&gt; It&#39;s actually more likely in Mesa. If you set either or both of th=
e<br>
&gt; following environment variables for running ue4editor:<br>
&gt;<br>
&gt; R600_DEBUG=3Dcheck_vm GALLIUM_DDEBUG=3D&quot;pipelined 10000&quot;<br>
&gt;<br>
&gt; it should create a file in ~/ddebug_dumps/ with more information about=
<br>
&gt; the GPU hang.<br>
&gt;<br>
<br>
</span>Please also open a bug (<a href=3D"https://bugs.freedesktop.org" rel=
=3D"noreferrer" target=3D"_blank">https://bugs.freedesktop.org</a> Product:=
 Mesa,<br>
Component: radeonsi) and attach your dmesg and xorg log along with all<br>
of the relevent info from this thread.=C2=A0 That way we have a central<br>
location to discuss the issue and store all of the relevant<br>
information.<br>
<br>
Thanks,<br>
<br>
Alex<br>
</blockquote></div><br></div>

--f40304389034c9e3010551549e7b--

--===============0968759225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0968759225==--
