From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: fix to clear ASIC INIT COMPLETE bit on
 resuming phase
Date: Mon, 10 Apr 2017 15:09:17 +0300
Message-ID: <CANOLnOOcnUitqWAWjtTEa0U69pEj5mFMMJZSHrKz5S_TQEcoDA@mail.gmail.com>
References: <1491817071-17014-1-git-send-email-ray.huang@amd.com>
 <1491817071-17014-3-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2021951249=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1491817071-17014-3-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============2021951249==
Content-Type: multipart/alternative; boundary=001a11373aca36e679054cced8e3

--001a11373aca36e679054cced8e3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 12:37 PM, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org> wrote:

> ASIC_INIT_COMPLETE bit must be cleared during S3 resuming phase,
> because VBIOS will check the bit to decide if execute ASIC_Init
> posting via kernel driver.
>
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c     | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index ad43299..b0dd72a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1727,8 +1727,11 @@ void amdgpu_atombios_scratch_regs_restore(struct
> amdgpu_device *adev)
>  {
>         int i;
>
> -       for (i =3D 0; i < AMDGPU_BIOS_NUM_SCRATCH; i++)
> +       for (i =3D 0; i < AMDGPU_BIOS_NUM_SCRATCH; i++) {
> +               if (i =3D=3D 7)
> +                       adev->bios_scratch[i] &=3D
> ~ATOM_S7_ASIC_INIT_COMPLETE_MASK;
>

Maybe move this line before the loop?
A comment may also be useful so that somebody doesn't delete the code again
in future.

Gra=C5=BEvydas

--001a11373aca36e679054cced8e3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Apr 10, 2017 at 12:37 PM, Huang Rui <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:ray.huang-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">ASIC_INIT_COMPL=
ETE bit must be cleared during S3 resuming phase,<br>
because VBIOS will check the bit to decide if execute ASIC_Init<br>
posting via kernel driver.<br>
<br>
Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.huang=
@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_atombios.c=C2=A0 =C2=A0 =C2=A0=
| 5 ++++-<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_atomfirmware.c | 6 +++++-<br>
=C2=A02 files changed, 9 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_atombios.c b/drivers/gp=
u/drm/amd/amdgpu/<wbr>amdgpu_atombios.c<br>
index ad43299..b0dd72a8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_atombios.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_atombios.c<br>
@@ -1727,8 +1727,11 @@ void amdgpu_atombios_scratch_regs_<wbr>restore(struc=
t amdgpu_device *adev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; AMDGPU_BIOS_NUM_SCRATCH; i=
++)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; AMDGPU_BIOS_NUM_SCRATCH; i=
++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D 7)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0adev-&gt;bios_scratch[i] &amp;=3D ~ATOM_S7_ASIC_INIT_COMPLETE_<wb=
r>MASK;<br></blockquote><div><br></div><div>Maybe move this line before the=
 loop?<br></div><div>A comment may also be useful so that somebody doesn&#3=
9;t delete the code again in future.<br><br><div><div class=3D"gmail_signat=
ure">Gra=C5=BEvydas<br></div></div>
</div><br></div><br></div></div>

--001a11373aca36e679054cced8e3--

--===============2021951249==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2021951249==--
