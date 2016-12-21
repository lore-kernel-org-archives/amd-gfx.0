From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] amdgpu/drm: Refine the way to check
Date: Wed, 21 Dec 2016 10:44:58 +0100
Message-ID: <CA+nq7DtXaf3eQ+80fSjgw4tQWqV62CgG082AECycCoj0M9j-qA@mail.gmail.com>
References: <CY4PR12MB134963093979F255981DF512FB930@CY4PR12MB1349.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2079603630=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB134963093979F255981DF512FB930-rpdhrqHFk04TyeVEJk5hrgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Xue, Ken" <Ken.Xue-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dl.SRDC_SW_GPUVirtualization" <dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============2079603630==
Content-Type: multipart/alternative; boundary=001a11422abc91edde054428014d

--001a11422abc91edde054428014d
Content-Type: text/plain; charset=UTF-8

Hi Ken, a comment below


Den 21 dec. 2016 08:19 skrev "Xue, Ken" <Ken.Xue-5C7GfCeVMHo@public.gmane.org>:

There are several ways to check out a ATOMBIOS. In previous codes, try
a new way to fetch out vbios/rom, until current vbios/rom is started with
0x55AA, then check if this vbios is ATOMBIOS. Now, try a new way to fetch
out vbios until all flags of ATOMBIOS are verified.

Signed-off-by: Ken Xue <Ken.Xue-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c   | 174
++++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +-
 2 files changed, 102 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 4f973a9..a6fa91f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -42,6 +42,44 @@
 #define AMD_IS_VALID_VBIOS(p) ((p)[0] == 0x55 && (p)[1] == 0xAA)
 #define AMD_VBIOS_LENGTH(p) ((p)[2] << 9)

+/* Check if current bios is an ATOM BIOS.
+ * Return true if it is ATOM BIOS. Otherwise, return false.
+ */
+static bool check_atom_bios(uint8_t *bios, size_t size)
+{
+       uint16_t tmp, bios_header_start;
+
+       if (!bios || size < 0x49) {
+               DRM_INFO("vbios mem is null or mem size is wrong\n");
+               return false;
+       }
+
+       if (!AMD_IS_VALID_VBIOS(bios)) {
+               DRM_INFO("BIOS signature incorrect %x %x\n", bios[0],
bios[1]);
+               return false;
+       }
+
+       tmp = bios[0x18] | (bios[0x19] << 8);
+       if (bios[tmp + 0x14] != 0x0) {
+               DRM_INFO("Not an x86 BIOS ROM\n");
+               return false;
+       }
+
+       bios_header_start = bios[0x48] | (bios[0x49] << 8);
+       if (!bios_header_start) {
+               DRM_INFO("Can't locate bios header\n");
+               return false;
+       }
+       tmp = bios_header_start + 4;
+       if (!memcmp(bios + tmp, "ATOM", 4) ||
+           !memcmp(bios + tmp, "MOTA", 4) ||
+           (size < tmp))


Is the last condition here correct? Can you have valid atombios without the
signature? Maybe add a comment if that's true. Also the extra parents
aren't necessary.

Best regards
Nils

+               return true;
+
+       return false;
+}
+
+
 /* If you boot an IGP board with a discrete card as the primary,
  * the IGP rom is not accessible via the rom bar as the IGP rom is
  * part of the system bios.  On boot, the system bios puts a
@@ -65,10 +103,6 @@ static bool igp_read_bios_from_vram(struct
amdgpu_device *adev)
                return false;
        }

-       if (size == 0 || !AMD_IS_VALID_VBIOS(bios)) {
-               iounmap(bios);
-               return false;
-       }
        adev->bios = kmalloc(size, GFP_KERNEL);
        if (!adev->bios) {
                iounmap(bios);
@@ -77,12 +111,18 @@ static bool igp_read_bios_from_vram(struct
amdgpu_device *adev)
        adev->bios_size = size;
        memcpy_fromio(adev->bios, bios, size);
        iounmap(bios);
+
+       if (!check_atom_bios(adev->bios, size)) {
+               kfree(adev->bios);
+               return false;
+       }
+
        return true;
 }

 bool amdgpu_read_bios(struct amdgpu_device *adev)
 {
-       uint8_t __iomem *bios, val[2];
+       uint8_t __iomem *bios;
        size_t size;

        adev->bios = NULL;
@@ -92,13 +132,6 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
                return false;
        }

-       val[0] = readb(&bios[0]);
-       val[1] = readb(&bios[1]);
-
-       if (size == 0 || !AMD_IS_VALID_VBIOS(val)) {
-               pci_unmap_rom(adev->pdev, bios);
-               return false;
-       }
        adev->bios = kzalloc(size, GFP_KERNEL);
        if (adev->bios == NULL) {
                pci_unmap_rom(adev->pdev, bios);
@@ -107,6 +140,12 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
        adev->bios_size = size;
        memcpy_fromio(adev->bios, bios, size);
        pci_unmap_rom(adev->pdev, bios);
+
+       if (!check_atom_bios(adev->bios, size)) {
+               kfree(adev->bios);
+               return false;
+       }
+
        return true;
 }

@@ -140,7 +179,14 @@ static bool amdgpu_read_bios_from_rom(struct
amdgpu_device *adev)
        adev->bios_size = len;

        /* read complete BIOS */
-       return amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
+       amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
+
+       if (!check_atom_bios(adev->bios, len)) {
+               kfree(adev->bios);
+               return false;
+       }
+
+       return true;
 }

 static bool amdgpu_read_platform_bios(struct amdgpu_device *adev)
@@ -155,13 +201,17 @@ static bool amdgpu_read_platform_bios(struct
amdgpu_device *adev)
                return false;
        }

-       if (size == 0 || !AMD_IS_VALID_VBIOS(bios)) {
+       adev->bios = kzalloc(size, GFP_KERNEL);
+       if (adev->bios == NULL)
                return false;
-       }
-       adev->bios = kmemdup(bios, size, GFP_KERNEL);
-       if (adev->bios == NULL) {
+
+       memcpy_fromio(adev->bios, bios, size);
+
+       if (!check_atom_bios(adev->bios, size)) {
+               kfree(adev->bios);
                return false;
        }
+
        adev->bios_size = size;

        return true;
@@ -273,7 +323,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device
*adev)
                        break;
        }

-       if (i == 0 || !AMD_IS_VALID_VBIOS(adev->bios)) {
+       if (!check_atom_bios(adev->bios, size)) {
                kfree(adev->bios);
                return false;
        }
@@ -298,7 +348,6 @@ static bool amdgpu_read_disabled_bios(struct
amdgpu_device *adev)
 #ifdef CONFIG_ACPI
 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 {
-       bool ret = false;
        struct acpi_table_header *hdr;
        acpi_size tbl_size;
        UEFI_ACPI_VFCT *vfct;
@@ -309,13 +358,13 @@ static bool amdgpu_acpi_vfct_bios(struct
amdgpu_device *adev)
                return false;
        if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
                DRM_ERROR("ACPI VFCT table present but broken (too short
#1)\n");
-               goto out_unmap;
+               return false;
        }

        vfct = (UEFI_ACPI_VFCT *)hdr;
        if (vfct->VBIOSImageOffset + sizeof(VFCT_IMAGE_HEADER) > tbl_size) {
                DRM_ERROR("ACPI VFCT table present but broken (too short
#2)\n");
-               goto out_unmap;
+               return false;
        }

        vbios = (GOP_VBIOS_CONTENT *)((char *)hdr + vfct->VBIOSImageOffset);
@@ -330,20 +379,25 @@ static bool amdgpu_acpi_vfct_bios(struct
amdgpu_device *adev)
            vhdr->VendorID != adev->pdev->vendor ||
            vhdr->DeviceID != adev->pdev->device) {
                DRM_INFO("ACPI VFCT table is not for this card\n");
-               goto out_unmap;
+               return false;
        }

        if (vfct->VBIOSImageOffset + sizeof(VFCT_IMAGE_HEADER) +
vhdr->ImageLength > tbl_size) {
                DRM_ERROR("ACPI VFCT image truncated\n");
-               goto out_unmap;
+               return false;
        }

-       adev->bios = kmemdup(&vbios->VbiosContent, vhdr->ImageLength,
GFP_KERNEL);
+       adev->bios = kmemdup(&vbios->VbiosContent,
+                               vhdr->ImageLength,
+                               GFP_KERNEL);
+
+       if (!check_atom_bios(adev->bios, vhdr->ImageLength)) {
+               kfree(adev->bios);
+               return false;
+       }
        adev->bios_size = vhdr->ImageLength;
-       ret = !!adev->bios;

-out_unmap:
-       return ret;
+       return true;
 }
 #else
 static inline bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
@@ -354,57 +408,27 @@ static inline bool amdgpu_acpi_vfct_bios(struct
amdgpu_device *adev)

 bool amdgpu_get_bios(struct amdgpu_device *adev)
 {
-       bool r;
-       uint16_t tmp, bios_header_start;
+       if (amdgpu_atrm_get_bios(adev))
+               return true;

-       r = amdgpu_atrm_get_bios(adev);
-       if (!r)
-               r = amdgpu_acpi_vfct_bios(adev);
-       if (!r)
-               r = igp_read_bios_from_vram(adev);
-       if (!r)
-               r = amdgpu_read_bios(adev);
-       if (!r) {
-               r = amdgpu_read_bios_from_rom(adev);
-       }
-       if (!r) {
-               r = amdgpu_read_disabled_bios(adev);
-       }
-       if (!r) {
-               r = amdgpu_read_platform_bios(adev);
-       }
-       if (!r || adev->bios == NULL) {
-               DRM_ERROR("Unable to locate a BIOS ROM\n");
-               adev->bios = NULL;
-               return false;
-       }
-       if (!AMD_IS_VALID_VBIOS(adev->bios)) {
-               printk("BIOS signature incorrect %x %x\n", adev->bios[0],
adev->bios[1]);
-               goto free_bios;
-       }
+       if (amdgpu_acpi_vfct_bios(adev))
+               return true;

-       tmp = RBIOS16(0x18);
-       if (RBIOS8(tmp + 0x14) != 0x0) {
-               DRM_INFO("Not an x86 BIOS ROM, not using.\n");
-               goto free_bios;
-       }
+       if (igp_read_bios_from_vram(adev))
+               return true;

-       bios_header_start = RBIOS16(0x48);
-       if (!bios_header_start) {
-               goto free_bios;
-       }
-       tmp = bios_header_start + 4;
-       if (!memcmp(adev->bios + tmp, "ATOM", 4) ||
-           !memcmp(adev->bios + tmp, "MOTA", 4)) {
-               adev->is_atom_bios = true;
-       } else {
-               adev->is_atom_bios = false;
-       }
+       if (amdgpu_read_bios(adev))
+               return true;

-       DRM_DEBUG("%sBIOS detected\n", adev->is_atom_bios ? "ATOM" : "COM");
-       return true;
-free_bios:
-       kfree(adev->bios);
-       adev->bios = NULL;
+       if (amdgpu_read_bios_from_rom(adev))
+               return true;
+
+       if (amdgpu_read_disabled_bios(adev))
+               return true;
+
+       if (amdgpu_read_platform_bios(adev))
+               return true;
+
+       DRM_ERROR("Unable to locate a BIOS ROM\n");
        return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b7f17c2..e23acbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1753,15 +1753,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,

        /* Read BIOS */
        if (!amdgpu_get_bios(adev)) {
+               /* Must be an ATOMBIOS */
                r = -EINVAL;
-               goto failed;
-       }
-       /* Must be an ATOMBIOS */
-       if (!adev->is_atom_bios) {
                dev_err(adev->dev, "Expecting atombios for GPU\n");
-               r = -EINVAL;
                goto failed;
        }
+       adev->is_atom_bios = true;
+
        r = amdgpu_atombios_init(adev);
        if (r) {
                dev_err(adev->dev, "amdgpu_atombios_init failed\n");
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--001a11422abc91edde054428014d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Ken, a comment below<div><br><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">Den 21 dec. 2016 08:19 skrev &quot;Xue, Ke=
n&quot; &lt;<a href=3D"mailto:Ken.Xue-5C7GfCeVMHo@public.gmane.org">Ken.Xue-5C7GfCeVMHo@public.gmane.org</a>&gt;:<br =
type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">There are several ways to che=
ck out a ATOMBIOS. In previous codes, try<br>
a new way to fetch out vbios/rom, until current vbios/rom is started with<b=
r>
0x55AA, then check if this vbios is ATOMBIOS. Now, try a new way to fetch<b=
r>
out vbios until all flags of ATOMBIOS are verified.<br>
<br>
Signed-off-by: Ken Xue &lt;<a href=3D"mailto:Ken.Xue-5C7GfCeVMHo@public.gmane.org">Ken.Xue@amd.c=
om</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_bios.c=C2=A0 =C2=A0| 174 +++++=
+++++++++++-------------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_device.c |=C2=A0 =C2=A08 +-<br=
>
=C2=A02 files changed, 102 insertions(+), 80 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_bios.c b/drivers/gpu/dr=
m/amd/amdgpu/<wbr>amdgpu_bios.c<br>
index 4f973a9..a6fa91f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_bios.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_bios.c<br>
@@ -42,6 +42,44 @@<br>
=C2=A0#define AMD_IS_VALID_VBIOS(p) ((p)[0] =3D=3D 0x55 &amp;&amp; (p)[1] =
=3D=3D 0xAA)<br>
=C2=A0#define AMD_VBIOS_LENGTH(p) ((p)[2] &lt;&lt; 9)<br>
<br>
+/* Check if current bios is an ATOM BIOS.<br>
+ * Return true if it is ATOM BIOS. Otherwise, return false.<br>
+ */<br>
+static bool check_atom_bios(uint8_t *bios, size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t tmp, bios_header_start;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!bios || size &lt; 0x49) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;vbio=
s mem is null or mem size is wrong\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!AMD_IS_VALID_VBIOS(bios)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;BIOS=
 signature incorrect %x %x\n&quot;, bios[0], bios[1]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D bios[0x18] | (bios[0x19] &lt;&lt; 8);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bios[tmp + 0x14] !=3D 0x0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;Not =
an x86 BIOS ROM\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bios_header_start =3D bios[0x48] | (bios[0x49] =
&lt;&lt; 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!bios_header_start) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;Can&=
#39;t locate bios header\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D bios_header_start + 4;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!memcmp(bios + tmp, &quot;ATOM&quot;, 4) ||=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!memcmp(bios + tmp, &quot;MOTA&qu=
ot;, 4) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(size &lt; tmp))<br></blockquote>=
</div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Is the last=
 condition here correct? Can you have valid atombios without the signature?=
 Maybe add a comment if that&#39;s true. Also the extra parents aren&#39;t =
necessary.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards<=
/div><div dir=3D"auto">Nils</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+}<br>
+<br>
+<br>
=C2=A0/* If you boot an IGP board with a discrete card as the primary,<br>
=C2=A0 * the IGP rom is not accessible via the rom bar as the IGP rom is<br=
>
=C2=A0 * part of the system bios.=C2=A0 On boot, the system bios puts a<br>
@@ -65,10 +103,6 @@ static bool igp_read_bios_from_vram(struct amdgpu_devic=
e *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (size =3D=3D 0 || !AMD_IS_VALID_VBIOS(bios))=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(bios);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios =3D kmalloc(size, GFP_KERNEL);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!adev-&gt;bios) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(bios);<br>
@@ -77,12 +111,18 @@ static bool igp_read_bios_from_vram(struct amdgpu_devi=
ce *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios_size =3D size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy_fromio(adev-&gt;bios, bios, size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(bios);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_atom_bios(adev-&gt;bios, size)) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;bios=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0bool amdgpu_read_bios(struct amdgpu_device *adev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t __iomem *bios, val[2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t __iomem *bios;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios =3D NULL;<br>
@@ -92,13 +132,6 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0val[0] =3D readb(&amp;bios[0]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0val[1] =3D readb(&amp;bios[1]);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (size =3D=3D 0 || !AMD_IS_VALID_VBIOS(val)) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_unmap_rom(adev-=
&gt;pdev, bios);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios =3D kzalloc(size, GFP_KERNEL);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;bios =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_unmap_rom(adev-=
&gt;pdev, bios);<br>
@@ -107,6 +140,12 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios_size =3D size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy_fromio(adev-&gt;bios, bios, size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_unmap_rom(adev-&gt;pdev, bios);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_atom_bios(adev-&gt;bios, size)) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;bios=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
@@ -140,7 +179,14 @@ static bool amdgpu_read_bios_from_rom(<wbr>struct amdg=
pu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios_size =3D len;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* read complete BIOS */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return amdgpu_asic_read_bios_from_<wbr>rom(adev=
, adev-&gt;bios, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_asic_read_bios_from_<wbr>rom(adev, adev-=
&gt;bios, len);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_atom_bios(adev-&gt;bios, len)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;bios=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
=C2=A0static bool amdgpu_read_platform_bios(<wbr>struct amdgpu_device *adev=
)<br>
@@ -155,13 +201,17 @@ static bool amdgpu_read_platform_bios(<wbr>struct amd=
gpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (size =3D=3D 0 || !AMD_IS_VALID_VBIOS(bios))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;bios =3D kzalloc(size, GFP_KERNEL);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;bios =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;bios =3D kmemdup(bios, size, GFP_KERNE=
L);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;bios =3D=3D NULL) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy_fromio(adev-&gt;bios, bios, size);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_atom_bios(adev-&gt;bios, size)) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;bios=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios_size =3D size;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
@@ -273,7 +323,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *=
adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D 0 || !AMD_IS_VALID_VBIOS(adev-&gt;=
<wbr>bios)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_atom_bios(adev-&gt;bios, size)) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(adev-&gt;bios=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -298,7 +348,6 @@ static bool amdgpu_read_disabled_bios(<wbr>struct amdgp=
u_device *adev)<br>
=C2=A0#ifdef CONFIG_ACPI<br>
=C2=A0static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bool ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct acpi_table_header *hdr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_size tbl_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 UEFI_ACPI_VFCT *vfct;<br>
@@ -309,13 +358,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tbl_size &lt; sizeof(UEFI_ACPI_VFCT)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;ACP=
I VFCT table present but broken (too short #1)\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unmap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfct =3D (UEFI_ACPI_VFCT *)hdr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vfct-&gt;VBIOSImageOffset + sizeof(VFCT_IMA=
GE_HEADER) &gt; tbl_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;ACP=
I VFCT table present but broken (too short #2)\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unmap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vbios =3D (GOP_VBIOS_CONTENT *)((char *)hdr + v=
fct-&gt;VBIOSImageOffset);<br>
@@ -330,20 +379,25 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhdr-&gt;VendorID !=3D adev-&gt;p=
dev-&gt;vendor ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhdr-&gt;DeviceID !=3D adev-&gt;p=
dev-&gt;device) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_INFO(&quot;ACPI=
 VFCT table is not for this card\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unmap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vfct-&gt;VBIOSImageOffset + sizeof(VFCT_IMA=
GE_HEADER) + vhdr-&gt;ImageLength &gt; tbl_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_ERROR(&quot;ACP=
I VFCT image truncated\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_unmap;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;bios =3D kmemdup(&amp;vbios-&gt;VbiosC=
ontent, vhdr-&gt;ImageLength, GFP_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;bios =3D kmemdup(&amp;vbios-&gt;VbiosC=
ontent,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhdr-&gt;ImageLength,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GFP_KERNEL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!check_atom_bios(adev-&gt;bios, vhdr-&gt;Im=
ageLength)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;bios=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;bios_size =3D vhdr-&gt;ImageLength;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D !!adev-&gt;bios;<br>
<br>
-out_unmap:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
=C2=A0#else<br>
=C2=A0static inline bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)<=
br>
@@ -354,57 +408,27 @@ static inline bool amdgpu_acpi_vfct_bios(struct amdgp=
u_device *adev)<br>
<br>
=C2=A0bool amdgpu_get_bios(struct amdgpu_device *adev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bool r;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t tmp, bios_header_start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_atrm_get_bios(adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_atrm_get_bios(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_acpi_v=
fct_bios(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D igp_read_bios=
_from_vram(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_read_b=
ios(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_read_b=
ios_from_rom(<wbr>adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_read_d=
isabled_bios(<wbr>adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_read_p=
latform_bios(<wbr>adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r || adev-&gt;bios =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Una=
ble to locate a BIOS ROM\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;bios =3D N=
ULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!AMD_IS_VALID_VBIOS(adev-&gt;<wbr>bios)) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(&quot;BIOS s=
ignature incorrect %x %x\n&quot;, adev-&gt;bios[0], adev-&gt;bios[1]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_bios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_acpi_vfct_bios(adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D RBIOS16(0x18);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (RBIOS8(tmp + 0x14) !=3D 0x0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_INFO(&quot;Not =
an x86 BIOS ROM, not using.\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_bios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (igp_read_bios_from_vram(adev)<wbr>)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bios_header_start =3D RBIOS16(0x48);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!bios_header_start) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free_bios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D bios_header_start + 4;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!memcmp(adev-&gt;bios + tmp, &quot;ATOM&quo=
t;, 4) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!memcmp(adev-&gt;bios + tmp, &quo=
t;MOTA&quot;, 4)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;is_atom_bi=
os =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;is_atom_bi=
os =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_read_bios(adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG(&quot;%sBIOS detected\n&quot;, adev-&=
gt;is_atom_bios ? &quot;ATOM&quot; : &quot;COM&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
-free_bios:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(adev-&gt;bios);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;bios =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_read_bios_from_rom(<wbr>adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_read_disabled_bios(<wbr>adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (amdgpu_read_platform_bios(<wbr>adev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;Unable to locate a BIOS ROM\n&q=
uot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/<wbr>amdgpu_device.c<br>
index b7f17c2..e23acbe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_device.c<br>
@@ -1753,15 +1753,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read BIOS */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!amdgpu_get_bios(adev)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Must be an ATOMB=
IOS */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D -EINVAL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto failed;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Must be an ATOMBIOS */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adev-&gt;is_atom_bios) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(adev-&gt;de=
v, &quot;Expecting atombios for GPU\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto failed;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;is_atom_bios =3D true;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_atombios_init(adev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(adev-&gt;de=
v, &quot;amdgpu_atombios_init failed\n&quot;);<br>
<font color=3D"#888888">--<br>
2.7.4<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</font></blockquote></div><br></div></div></div>

--001a11422abc91edde054428014d--

--===============2079603630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2079603630==--
