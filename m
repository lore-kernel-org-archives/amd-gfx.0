From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Implementations of missing dce6 functions: how should patches be
 organized?
Date: Mon, 08 Aug 2016 15:05:39 +0000
Message-ID: <CAPEhTTGL3dCySnxoVyMOBdPtJZRieB=eBqutZVcY7=PQQvbpCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0067312724=="
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
To: Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alexander Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============0067312724==
Content-Type: multipart/alternative; boundary=94eb2c147ffe711165053990c099

--94eb2c147ffe711165053990c099
Content-Type: text/plain; charset=UTF-8

Since yesterday was a rainy day over here, I took some time at the
unimplemented dce6 functions and  I'm almost done with them.

I still need to:
- mimic how MASKs and SHIFTs are used in dce_v8_0.c (purely for consistency
and clarity)
-- rename some variables and split imbriqued MASKs and SHIFTs (almost
completed for dce_v6_0.c usages and some other files that were using the
same defined variables)
-- move MASKs and SHIFTs to their own file (dce_6_0_sh_mask.h)
- complete implementation of two remainging functions:
--- dce_v6_0_afmt_update_ACR()
--- dce_v6_0_afmt_update_avi_infoframe()

I found a few duplicated "#define" in sid.h while porting code that I'm
cleaning at the same time.

So, in the next few days, I'll send patches for cleaning duplicated
"#define" in sid.h, renaming, splitting and moving MASKs and SHIFTs to
their own file first. It could be grouped as follow: a patch for removed
duplicates, one for renaming and splitting masks and shifts, and a last one
for moving them to their own file.

However, after that, would it be better to send a single patch for all
unimplemented functions or should I split them? Per function (or group of
functions)?

Thanks for your input.
Alexandre Demers

--94eb2c147ffe711165053990c099
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>S<span style=3D"line-height:1.5">ince yesterday was a=
 rainy day over here, I took some time at the unimplemented dce6 functions =
and</span><span class=3D"inbox-inbox-inbox-inbox-Apple-converted-space" sty=
le=3D"line-height:1.5">=C2=A0=C2=A0</span><span style=3D"line-height:1.5">I=
&#39;m almost done with them.</span></div><div><br></div><div>I still need =
to:</div><div>- mimic how MASKs and SHIFTs are used in dce_v8_0.c (purely f=
or consistency and clarity)</div><div>-- rename some variables and split im=
briqued MASKs and SHIFTs (almost completed for dce_v6_0.c usages and some o=
ther files that were using the same defined variables)</div><div>-- move MA=
SKs and SHIFTs to their own file (dce_6_0_sh_mask.h)</div><div>- complete i=
mplementation of two remainging functions:</div><div>---=C2=A0<span style=
=3D"font-size:13.3333px;line-height:normal">dce_v6_0_afmt_update_ACR()</spa=
n></div><div><span style=3D"font-size:13.3333px;line-height:normal">--- dce=
_v6_0_afmt_update_avi_infoframe()</span></div><div><br></div><div>I found a=
 few duplicated &quot;#define&quot; in sid.h while porting code that I&#39;=
m cleaning at the same time.</div><div><br></div><div>So, in the next few d=
ays, I&#39;ll send patches for cleaning duplicated &quot;#define&quot; in s=
id.h, renaming, splitting and moving MASKs and SHIFTs to their own file fir=
st. It could be grouped as follow: a patch for removed duplicates, one for =
renaming and splitting masks and shifts, and a last one for moving them to =
their own file.<span style=3D"line-height:1.5">=C2=A0</span></div><div><br>=
</div><div>However, after that, would it be better to send a single patch f=
or all unimplemented functions or should I split them? Per function (or gro=
up of functions)?</div><div><br></div><div>Thanks for your input.</div><div=
><span style=3D"line-height:1.5">Alexandre Demers</span><br></div></div>

--94eb2c147ffe711165053990c099--

--===============0067312724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0067312724==--
