From: "Pierre-Loup A. Griffais" <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>
Subject: =?UTF-8?B?UmU6IFJl77yaW1BBVENIXSBkcm0vYW1kZ3B1OiByZXN2ZXJ0ICJkaXNh?=
 =?UTF-8?Q?ble_bulk_moves_for_now=22?=
Date: Tue, 17 Sep 2019 14:56:44 -0700
Message-ID: <f4fd2410-7031-764b-1ee6-4182dec04a82@valvesoftware.com>
References: <20190912101535.71686-1-christian.koenig@amd.com>
 <f0b19f35-5852-8cbe-2256-e769169d8884@amd.com>
 <df915c16-198d-502d-6eed-975a0471ec13@gmail.com>
 <ayyik7-bhm0th-f76qzcrx4nuhoz097-fqib6y-d00kkm-l8swdj-bb0hlq-6hyzem-xpderd-hmxy8m-n7py9m2f0bz2o58vot2offja-ec4pyzuy9pjm-235qpt-69n2k9ugq2z1gpw45e-vjjmkviqgdj4.1568301521040@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0260363629=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ayyik7-bhm0th-f76qzcrx4nuhoz097-fqib6y-d00kkm-l8swdj-bb0hlq-6hyzem-xpderd-hmxy8m-n7py9m2f0bz2o58vot2offja-ec4pyzuy9pjm-235qpt-69n2k9ugq2z1gpw45e-vjjmkviqgdj4.1568301521040-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0260363629==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="------------10F568794A1E5406AEBAF53B"

--------------10F568794A1E5406AEBAF53B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

Applying this locally, the issue we were seeing with very high submit=20
times in high-end workloads seems largely gone. My methodology is to=20
measure the total time spent in DRM_IOCTL_AMDGPU_CS with `strace -T` for=20
the whole first scene of the Shadow of the Tomb Raider benchmark, and=20
divide by the frame count in that scene to get an idea of how much CPU=20
time is spent in submissions per frame. More details below.

On a Vega20 system with a 3900X, at High settings (~6 gigs of VRAM usage=20
according to UMR, no contention):

 =C2=A0- 5.2.14: 1.1ms per frame in CS

 =C2=A0- 5.2.14 + LRU bulk moves: 0.6ms per frame in CS

On a Polaris10 system with a i7-7820X, at Very High Settings (7.7G/8G=20
VRAM used, no contention):

 =C2=A0- 5.2.15: 12.03ms per frame in CS (!)

 =C2=A0- 5.2.15 + LRU bulk moves:=C2=A0 1.35ms per frame in CS

The issue is largely addressed. 1.35ms is still higher than I'd expect,=20
but it's still pretty reasonable. Note that on many of our usecases,=20
submission happens in a separate thread and doesn't typically impact=20
overall frame time/latency if you have extra CPU cores to work with.=20
However it very negatively affects performance as soon as the CPU gets=20
saturated, and burns a ton of power.

Thanks!

 =C2=A0- Pierre-Loup

Methodology details:

# Mesa patched to kill() itself with SIGCONT in vkQueuePresent to act as=20
a frame marker in-band with the strace data.

# strace collection:

strace -f -p 13113 -e ioctl,kill -o sottr_first_scene_vanilla -T

# frame count:

cat sottr_first_scene_vanilla | grep kill\( | wc -l
616

# total time spent in _CS:

cat sottr_first_scene_vanilla | grep AMDGPU_CS | grep -v unfinished | tr=20
-s ' '=C2=A0 | cut -d ' ' -f7 | tr -d \< | tr -d \> | xargs=C2=A0 | tr ' ' =
'+' | bc
7.411782

# seconds to milliseconds, then divide by frame count

(gdb) p 7.41 * 1000.0 / 616.0
$1 =3D 12.029220779220779

On 9/12/19 8:18 AM, Zhou, David(ChunMing) wrote:
> I dont know dkms status=EF=BC=8Canyway, we should submit this one as earl=
y as=20
> possible.
>
> -------- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 --------
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [PATCH] drm/amdgpu: resvert "disable bulk =
moves for now"
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AChristian K=C3=B6nig
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"Zhou, David(ChunMing)" ,amd-gfx@list=
s.freedesktop.org
> =E6=8A=84=E9=80=81=EF=BC=9A
>
> Just to double check: We do have that enabled in the DKMS package for a
> while and doesn't encounter any more problems with it, correct?
>
> Thanks,
> Christian.
>
> Am 12.09.19 um 16:02 schrieb Chunming Zhou:
> > RB on it to go ahead.
> >
> > -David
> >
> > =E5=9C=A8 2019/9/12 18:15, Christian K=C3=B6nig =E5=86=99=E9=81=93:
> >> This reverts commit a213c2c7e235cfc0e0a161a558f7fdf2fb3a624a.
> >>
> >> The changes to fix this should have landed in 5.1.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>=C2=A0=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 --
> >>=C2=A0=C2=A0=C2=A0 1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=20
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> index 48349e4f0701..fd3fbaa73fa3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> @@ -603,14 +603,12 @@ void amdgpu_vm_move_to_lru_tail(struct=20
> amdgpu_device *adev,
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_bo_global *glob =3D ade=
v->mman.bdev.glob;
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_vm_bo_base *bo_base;
> >>
> >> -#if 0
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vm->bulk_moveable) {
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 spin_lock(&glob->lru_lock);
> >> ttm_bo_bulk_move_lru_tail(&vm->lru_bulk_move);
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 spin_unlock(&glob->lru_lock);
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> -#endif
> >>
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&vm->lru_bulk_move, 0, size=
of(vm->lru_bulk_move));
> >>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------10F568794A1E5406AEBAF53B
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hello,</p>
    <p>Applying this locally, the issue we were seeing with very high
      submit times in high-end workloads seems largely gone. My
      methodology is to measure the total time spent in
      DRM_IOCTL_AMDGPU_CS with `strace -T` for the whole first scene of
      the Shadow of the Tomb Raider benchmark, and divide by the frame
      count in that scene to get an idea of how much CPU time is spent
      in submissions per frame. More details below.<br>
    </p>
    <p>On a Vega20 system with a 3900X, at High settings (~6 gigs of
      VRAM usage according to UMR, no contention):</p>
    <p>=C2=A0- 5.2.14: 1.1ms per frame in CS</p>
    <p>=C2=A0- 5.2.14 + LRU bulk moves: 0.6ms per frame in CS</p>
    <p>On a Polaris10 system with a i7-7820X, at Very High Settings
      (7.7G/8G VRAM used, no contention):</p>
    <p>=C2=A0- 5.2.15: 12.03ms per frame in CS (!)</p>
    <p>=C2=A0- 5.2.15 + LRU bulk moves:=C2=A0 1.35ms per frame in CS</p>
    <p>The issue is largely addressed. 1.35ms is still higher than I'd
      expect, but it's still pretty reasonable. Note that on many of our
      usecases, submission happens in a separate thread and doesn't
      typically impact overall frame time/latency if you have extra CPU
      cores to work with. However it very negatively affects performance
      as soon as the CPU gets saturated, and burns a ton of power.</p>
    <p>Thanks!</p>
    <p>=C2=A0- Pierre-Loup</p>
    <p>Methodology details:</p>
    <p># Mesa patched to kill() itself with SIGCONT in vkQueuePresent to
      act as a frame marker in-band with the strace data.<br>
    </p>
    <p># strace collection:</p>
    <p>strace -f -p 13113 -e ioctl,kill -o sottr_first_scene_vanilla -T</p>
    <p># frame count:<br>
    </p>
    <p>cat sottr_first_scene_vanilla | grep kill\( | wc -l<br>
      616</p>
    <p># total time spent in _CS:</p>
    <p>cat sottr_first_scene_vanilla | grep AMDGPU_CS | grep -v
      unfinished | tr -s ' '=C2=A0 | cut -d ' ' -f7 | tr -d \&lt; | tr -d
      \&gt; | xargs=C2=A0 | tr ' ' '+' | bc<br>
      7.411782</p>
    <p># seconds to milliseconds, then divide by frame count</p>
    <p>(gdb) p 7.41 * 1000.0 / 616.0<br>
      $1 =3D 12.029220779220779<br>
    </p>
    <div class=3D"moz-cite-prefix">On 9/12/19 8:18 AM, Zhou,
      David(ChunMing) wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:ayyik7-bhm0th-f76qzcrx4nuhoz097-fqib6y-d00kkm-l8swdj-bb0hlq-6hy=
zem-xpderd-hmxy8m-n7py9m2f0bz2o58vot2offja-ec4pyzuy9pjm-235qpt-69n2k9ugq2z1=
gpw45e-vjjmkviqgdj4.1568301521040-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
      <meta name=3D"Generator" content=3D"Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border=
-left: #800000 2px solid; } --></style>
      <div>I dont know dkms status=EF=BC=8Canyway, we should submit this on=
e as
        early as possible.<br>
        <br>
        -------- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 --------<br>
        =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [PATCH] drm/amdgpu: resvert "disable=
 bulk moves for now"<br>
        =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AChristian K=C3=B6nig <br>
        =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A"Zhou, David(ChunMing)" ,<a cla=
ss=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
        =E6=8A=84=E9=80=81=EF=BC=9A<br>
        <br>
      </div>
      <font size=3D"2"><span style=3D"font-size:11pt;">
          <div class=3D"PlainText">Just to double check: We do have that
            enabled in the DKMS package for a
            <br>
            while and doesn't encounter any more problems with it,
            correct?<br>
            <br>
            Thanks,<br>
            Christian.<br>
            <br>
            Am 12.09.19 um 16:02 schrieb Chunming Zhou:<br>
            &gt; RB on it to go ahead.<br>
            &gt;<br>
            &gt; -David<br>
            &gt;<br>
            &gt; =E5=9C=A8 2019/9/12 18:15, Christian K=C3=B6nig =E5=86=99=
=E9=81=93:<br>
            &gt;&gt; This reverts commit
            a213c2c7e235cfc0e0a161a558f7fdf2fb3a624a.<br>
            &gt;&gt;<br>
            &gt;&gt; The changes to fix this should have landed in 5.1.<br>
            &gt;&gt;<br>
            &gt;&gt; Signed-off-by: Christian K=C3=B6nig
            <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:christian.koe=
nig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt;&gt; ---<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm=
.c | 2 --<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0 1 file changed, 2 deletions(-)<br>
            &gt;&gt;<br>
            &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt; index 48349e4f0701..fd3fbaa73fa3 100644<br>
            &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt; @@ -603,14 +603,12 @@ void
            amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_bo_glob=
al *glob =3D
            adev-&gt;mman.bdev.glob;<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_vm_b=
o_base *bo_base;<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0 <br>
            &gt;&gt; -#if 0<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vm-&gt;bulk_mo=
veable) {<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&amp;glob-&gt;lru_lock);<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
            ttm_bo_bulk_move_lru_tail(&amp;vm-&gt;lru_bulk_move);<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&amp;glob-&gt;lru_lock);<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
            &gt;&gt; -#endif<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0 <br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&amp;vm-&gt=
;lru_bulk_move, 0,
            sizeof(vm-&gt;lru_bulk_move));<br>
            &gt;&gt;=C2=A0=C2=A0=C2=A0 <br>
            <br>
          </div>
        </span></font>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <pre class=3D"moz-quote-pre" wrap=3D"">______________________________=
_________________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a></pre>
    </blockquote>
  </body>
</html>

--------------10F568794A1E5406AEBAF53B--


--===============0260363629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0260363629==--
