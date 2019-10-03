From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: improve MSI-X handling (v3)
Date: Thu, 3 Oct 2019 13:33:40 -0400
Message-ID: <CAAzXoRKMd2gSrK5GE2Y6UDkbjLifZ5UuAvpTS06eeqB7zJP_Aw@mail.gmail.com>
References: <20191003172951.15866-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0569022426=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191003172951.15866-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0569022426==
Content-Type: multipart/alternative; boundary="00000000000023423b059404fdb1"

--00000000000023423b059404fdb1
Content-Type: text/plain; charset="UTF-8"

Tested-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

Cheers,
Tom

On Thu, Oct 3, 2019 at 1:30 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Check the number of supported vectors and fall back to MSI if
> we return or error or 0 MSI-X vectors.
>
> v2: only allocate one vector.  We can't currently use more than
> one anyway.
>
> v3: install the irq on vector 0.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 50771b2757dc..6f3b03f6224f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -245,11 +245,19 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>         adev->irq.msi_enabled = false;
>
>         if (amdgpu_msi_ok(adev)) {
> -               int nvec = pci_alloc_irq_vectors(adev->pdev, 1,
> pci_msix_vec_count(adev->pdev),
> -                                       PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +               int nvec = pci_msix_vec_count(adev->pdev);
> +               unsigned int flags;
> +
> +               if (nvec <= 0) {
> +                       flags = PCI_IRQ_MSI;
> +               } else {
> +                       flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> +               }
> +               /* we only need one vector */
> +               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>                 if (nvec > 0) {
>                         adev->irq.msi_enabled = true;
> -                       dev_dbg(adev->dev, "amdgpu: using MSI.\n");
> +                       dev_dbg(adev->dev, "amdgpu: using MSI/MSI-X.\n");
>                 }
>         }
>
> @@ -272,7 +280,8 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>         INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
>
>         adev->irq.installed = true;
> -       r = drm_irq_install(adev->ddev, adev->ddev->pdev->irq);
> +       /* Use vector 0 for MSI-X */
> +       r = drm_irq_install(adev->ddev, pci_irq_vector(adev->pdev, 0));
>         if (r) {
>                 adev->irq.installed = false;
>                 if (!amdgpu_device_has_dc_support(adev))
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000023423b059404fdb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis@=
amd.com">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<div><br></div><div>Cheers,</div><div>T=
om</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Thu, Oct 3, 2019 at 1:30 PM Alex Deucher &lt;<a href=3D"mailto:a=
lexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Check the number of supported ve=
ctors and fall back to MSI if<br>
we return or error or 0 MSI-X vectors.<br>
<br>
v2: only allocate one vector.=C2=A0 We can&#39;t currently use more than<br=
>
one anyway.<br>
<br>
v3: install the irq on vector 0.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
" target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 17 +++++++++++++----<br>
=C2=A01 file changed, 13 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_irq.c<br>
index 50771b2757dc..6f3b03f6224f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
@@ -245,11 +245,19 @@ int amdgpu_irq_init(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;irq.msi_enabled =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_msi_ok(adev)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nvec =3D pci_al=
loc_irq_vectors(adev-&gt;pdev, 1, pci_msix_vec_count(adev-&gt;pdev),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_IRQ_M=
SI | PCI_IRQ_MSIX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int nvec =3D pci_ms=
ix_vec_count(adev-&gt;pdev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int flags;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nvec &lt;=3D 0)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0flags =3D PCI_IRQ_MSI;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* we only need one=
 vector */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nvec =3D pci_alloc_=
irq_vectors(adev-&gt;pdev, 1, 1, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nvec &gt; 0) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 adev-&gt;irq.msi_enabled =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_dbg(adev-&gt;dev, &quot;amdgpu: using MSI.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_dbg(adev-&gt;dev, &quot;amdgpu: using MSI/MSI-X.\n&quot;);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -272,7 +280,8 @@ int amdgpu_irq_init(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_WORK(&amp;adev-&gt;irq.ih2_work, amdgpu_ir=
q_handle_ih2);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;irq.installed =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drm_irq_install(adev-&gt;ddev, adev-&gt;d=
dev-&gt;pdev-&gt;irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use vector 0 for MSI-X */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D drm_irq_install(adev-&gt;ddev, pci_irq_ve=
ctor(adev-&gt;pdev, 0));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;irq.instal=
led =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!amdgpu_device_=
has_dc_support(adev))<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote></div>

--00000000000023423b059404fdb1--

--===============0569022426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0569022426==--
