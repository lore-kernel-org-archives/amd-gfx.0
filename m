From: Dawson Dias <thexerothermicsclerodermoid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ryzen 5 2400G Stuttering since 2018-03-07
Date: Thu, 15 Mar 2018 13:21:56 +0530
Message-ID: <CAFuwKQNqgPf0b65r4adT-e50ZChOJnoZR74O4MuV3od4r6UnjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362619659=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0362619659==
Content-Type: multipart/alternative; boundary="94eb2c0971404103f605676ec5b9"

--94eb2c0971404103f605676ec5b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I managed to pinpoint the issue. The stuttering is caused by enabling
TearFree via xrandr. When on `auto`, there is no stuttering, but when
enabled by setting it to `on`, there is intense stuttering noticeable when
dragging windows around, but it's also very noticeable when just moving the
mouse around on the desktop with no windows open.
I use Openbox with Compton for compositing.

-Dawson Dias

On Sat, Mar 10, 2018 at 11:32 AM, Dawson Dias <
thexerothermicsclerodermoid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Got it. Attachments next time.
>
> I started a git bisect but noticed there were updates pushed to the tree,
> so I built HEAD instead (d1eeebbd78fd185988c3c90e3dab304cc8b86c4e). The
> stuttering is now gone!
>
> -Dawson Dias
>
> On Fri, Mar 9, 2018 at 7:36 PM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> w=
rote:
>
>> On 2018-03-09 12:30 PM, Dawson Dias wrote:
>> > Hello
>> >
>> > I'm experiencing extreme stuttering in X on my Ryzen 2400G. This
>> > stuttering can be noticed even while only moving the mouse.
>> > Said stuttering does not exist under Wayland.
>> >
>> > This constant stuttering started on 2018-03-07 with the patches that
>> > were pushed on that day. Stuttering occurs on both branches
>> > drm-next-4.17 (f6c3b601bd490eda08c27b03607448abd4b4841b) and
>> > drm-next-4.17-wip (6896a66bc6d0fcb69b6be564fa43f02c09348b72).
>> >
>> > dmesg.log <https://bpaste.net/raw/06e6dcc4545b>
>> > journalctl.log <https://bpaste.net/raw/f6f3dc8d108d>
>>
>> In the future, please attach files directly instead of referencing a
>> paste site.
>>
>>
>> > What sort of information do we require to pinpoint the source of this
>> > regression and fix it?
>>
>> Ideal would be if you can use git bisect to isolate the individual
>> commit which introduced the stuttering.
>>
>>
>> --
>> Earthling Michel D=C3=A4nzer               |               http://www.am=
d.com
>> Libre software enthusiast             |             Mesa and X developer
>>
>
>

--94eb2c0971404103f605676ec5b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I managed to pinpoint the issue. The stuttering is caused =
by enabling TearFree via xrandr. When on `auto`, there is no stuttering, bu=
t when enabled by setting it to `on`, there is intense stuttering noticeabl=
e when dragging windows around, but it&#39;s also very noticeable when just=
 moving the mouse around on the desktop with no windows open.<div>I use Ope=
nbox with Compton for compositing.<br><div class=3D"gmail_extra"><br clear=
=3D"all"><div><div class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure"><div dir=3D"ltr"><div><div dir=3D"ltr"><font face=3D"arial, helvetica,=
 sans-serif">-Dawson Dias</font><br></div></div></div></div></div>
<br><div class=3D"gmail_quote">On Sat, Mar 10, 2018 at 11:32 AM, Dawson Dia=
s <span dir=3D"ltr">&lt;<a href=3D"mailto:thexerothermicsclerodermoid@gmail=
.com" target=3D"_blank">thexerothermicsclerodermoid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Got it. Attachm=
ents next time.<div><br></div><div>I started a git bisect but noticed there=
 were updates pushed to the tree, so I built HEAD instead (<wbr>d1eeebbd78f=
d185988c3c90e3dab30<wbr>4cc8b86c4e). The stuttering is now gone!</div><div>=
<div class=3D"gmail_extra"><span class=3D"HOEnZb"><font color=3D"#888888"><=
br clear=3D"all"><div><div class=3D"m_1361116894601055033gmail-m_-466792222=
3938059029gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font fac=
e=3D"arial, helvetica, sans-serif">-Dawson Dias</font><br></div></div></div=
></div></div></font></span><div><div class=3D"h5">
<br><div class=3D"gmail_quote">On Fri, Mar 9, 2018 at 7:36 PM, Michel D=C3=
=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=
=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span class=3D"m_1361116894601055033gmail-=
m_-4667922223938059029gmail-">On 2018-03-09 12:30 PM, Dawson Dias wrote:<br=
>
&gt; Hello<br>
&gt;<br>
&gt; I&#39;m experiencing extreme stuttering in X on my Ryzen 2400G. This<b=
r>
&gt; stuttering can be noticed even while only moving the mouse.<br>
&gt; Said stuttering does not exist under Wayland.<br>
&gt;<br>
&gt; This constant stuttering started on 2018-03-07 with the patches that<b=
r>
&gt; were pushed on that day. Stuttering occurs on both branches<br>
&gt; drm-next-4.17 (f6c3b601bd490eda08c27b0360744<wbr>8abd4b4841b) and<br>
&gt; drm-next-4.17-wip (6896a66bc6d0fcb69b6be564fa43f<wbr>02c09348b72).<br>
&gt;<br>
</span>&gt; dmesg.log &lt;<a href=3D"https://bpaste.net/raw/06e6dcc4545b" r=
el=3D"noreferrer" target=3D"_blank">https://bpaste.net/raw/06e6dc<wbr>c4545=
b</a>&gt;<br>
&gt; journalctl.log &lt;<a href=3D"https://bpaste.net/raw/f6f3dc8d108d" rel=
=3D"noreferrer" target=3D"_blank">https://bpaste.net/raw/f6f3dc<wbr>8d108d<=
/a>&gt;<br>
<br>
In the future, please attach files directly instead of referencing a<br>
paste site.<br>
<span class=3D"m_1361116894601055033gmail-m_-4667922223938059029gmail-"><br=
>
<br>
&gt; What sort of information do we require to pinpoint the source of this<=
br>
&gt; regression and fix it?<br>
<br>
</span>Ideal would be if you can use git bisect to isolate the individual<b=
r>
commit which introduced the stuttering.<br>
<span class=3D"m_1361116894601055033gmail-m_-4667922223938059029gmail-HOEnZ=
b"><font color=3D"#888888"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</font></span></blockquote></div><br></div></div></div></div></div>
</blockquote></div><br></div></div></div>

--94eb2c0971404103f605676ec5b9--

--===============0362619659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0362619659==--
