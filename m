From: Jeremy Newton <alexjnewt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Staging kernel failing to build on 32bit
Date: Wed, 8 Feb 2017 11:53:17 -0500
Message-ID: <CAHOSEu8+cAB3O=uT3vA_6N=3f7kRynXTE3DHAKwSh21ZLLJGWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0854191384=="
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0854191384==
Content-Type: multipart/alternative; boundary=f403045dd960898a74054807b3b7

--f403045dd960898a74054807b3b7
Content-Type: text/plain; charset=UTF-8

Hi,

Heads up to whoever is using or developing for the following kernel branch:

https://cgit.freedesktop.org/~agd5f/linux/tree/?h=amd-staging-4.9

It seems like a recent commit has caused 32bit builds to fail. I haven't
been able to look into it myself or do a bisect, but it seems like it was
something committed between Jan 25th (d0c15b8) and Feb 2nd (99eb22d) caused
it.

Here's the error output:

ERROR: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed
Makefile:1200: recipe for target 'modules' failed
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

After a quick glance, it seems similar to a previous kernel commit:
https://cgit.freedesktop.org/~agd5f/linux/commit/?id=1f827f5138292a6124430cdd37bcb68f30c05467
<https://cgit.freedesktop.org/~agd5f/linux/commit/?h=amd-staging-4.9&id=1f827f5138292a6124430cdd37bcb68f30c05467>

just a shot in the dark, but it could be caused by this commit:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=amd-staging-4.9&id=7adb2bbcdf7259533c5afc95c4a788b59bb59306

As it's the only one I see with 64 bit division in it. As I said, shot in
the dark here.

Thanks!

--f403045dd960898a74054807b3b7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Heads up to whoever is using or dev=
eloping for the following kernel branch:<br><br><a href=3D"https://cgit.fre=
edesktop.org/~agd5f/linux/tree/?h=3Damd-staging-4.9">https://cgit.freedeskt=
op.org/~agd5f/linux/tree/?h=3Damd-staging-4.9</a><br><br>It seems like a re=
cent commit has caused 32bit builds to fail. I haven&#39;t been able to loo=
k into it myself or do a bisect, but it seems like it was something committ=
ed between Jan 25th (d0c15b8) and Feb 2nd (99eb22d) caused it.</div><div><b=
r>Here&#39;s the error output:</div><div><pre style=3D"color:rgb(0,0,0);wor=
d-wrap:break-word;white-space:pre-wrap">ERROR: &quot;__udivdi3&quot; [drive=
rs/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
scripts/Makefile.modpost:91: recipe for target &#39;__modpost&#39; failed
Makefile:1200: recipe for target &#39;modules&#39; failed
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2</pre></div><div>After a quick glance, it seems =
similar to a previous kernel commit:=C2=A0<a href=3D"https://cgit.freedeskt=
op.org/~agd5f/linux/commit/?h=3Damd-staging-4.9&amp;id=3D1f827f5138292a6124=
430cdd37bcb68f30c05467">https://cgit.freedesktop.org/~agd5f/linux/commit/?i=
d=3D1f827f5138292a6124430cdd37bcb68f30c05467</a><br><br>just a shot in the =
dark, but it could be caused by this commit:</div><div><a href=3D"https://c=
git.freedesktop.org/~agd5f/linux/commit/?h=3Damd-staging-4.9&amp;id=3D7adb2=
bbcdf7259533c5afc95c4a788b59bb59306">https://cgit.freedesktop.org/~agd5f/li=
nux/commit/?h=3Damd-staging-4.9&amp;id=3D7adb2bbcdf7259533c5afc95c4a788b59b=
b59306</a></div><div><br></div><div>As it&#39;s the only one I see with 64 =
bit division in it. As I said, shot in the dark here.</div><div><br></div><=
div>Thanks!</div></div>

--f403045dd960898a74054807b3b7--

--===============0854191384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0854191384==--
