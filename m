From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/amdgpu: Clean up memory leak in cz_dpm_init().
Date: Thu, 25 Aug 2016 17:11:41 +0000
Message-ID: <DM5PR12MB113240C05FF389B5EF0F865CF7ED0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160825171010.7121-1-tom.stdenis@amd.com>,
 <20160825171010.7121-3-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1207715967=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160825171010.7121-3-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1207715967==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB113240C05FF389B5EF0F865CF7ED0DM5PR12MB1132namp_"

--_000_DM5PR12MB113240C05FF389B5EF0F865CF7ED0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Patch #2 has a typo should be 'j' in the loop.


I'll resend that patch in a second.


Tom


________________________________
From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, August 25, 2016 13:10
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: [PATCH 2/3] drm/amd/amdgpu: Clean up memory leak in cz_dpm_init().

If init fails free up any allocated memory.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/cz_dpm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cz_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/cz_dpm.c
index b06b95ce1350..d97604386766 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_dpm.c
@@ -44,6 +44,7 @@

 static void cz_dpm_powergate_uvd(struct amdgpu_device *adev, bool gate);
 static void cz_dpm_powergate_vce(struct amdgpu_device *adev, bool gate);
+static void cz_dpm_fini(struct amdgpu_device *adev);

 static struct cz_ps *cz_get_ps(struct amdgpu_ps *rps)
 {
@@ -411,11 +412,11 @@ static int cz_dpm_init(struct amdgpu_device *adev)

         ret =3D amdgpu_get_platform_caps(adev);
         if (ret)
-               return ret;
+               goto err;

         ret =3D amdgpu_parse_extended_power_table(adev);
         if (ret)
-               return ret;
+               goto err;

         pi->sram_end =3D SMC_RAM_END;

@@ -469,23 +470,26 @@ static int cz_dpm_init(struct amdgpu_device *adev)

         ret =3D cz_parse_sys_info_table(adev);
         if (ret)
-               return ret;
+               goto err;

         cz_patch_voltage_values(adev);
         cz_construct_boot_state(adev);

         ret =3D cz_parse_power_table(adev);
         if (ret)
-               return ret;
+               goto err;

         ret =3D cz_process_firmware_header(adev);
         if (ret)
-               return ret;
+               goto err;

         pi->dpm_enabled =3D true;
         pi->uvd_dynamic_pg =3D false;

         return 0;
+err:
+       cz_dpm_fini(adev);
+       return ret;
 }

 static void cz_dpm_fini(struct amdgpu_device *adev)
--
2.9.2


--_000_DM5PR12MB113240C05FF389B5EF0F865CF7ED0DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Patch #2 has a typo should be 'j' in the loop. &nbsp;</p>
<p><br>
</p>
<p>I'll resend that patch in a second.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tom St Denis &lt;ts=
tdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 25, 2016 13:10<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH 2/3] drm/amd/amdgpu: Clean up memory leak in cz_dpm_=
init().</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">If init fails free up any allocated memory.<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cz_dpm.c | 14 &#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;-----<br>
&nbsp;1 file changed, 9 insertions(&#43;), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/cz_dpm.c<br>
index b06b95ce1350..d97604386766 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cz_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/cz_dpm.c<br>
@@ -44,6 &#43;44,7 @@<br>
&nbsp;<br>
&nbsp;static void cz_dpm_powergate_uvd(struct amdgpu_device *adev, bool gat=
e);<br>
&nbsp;static void cz_dpm_powergate_vce(struct amdgpu_device *adev, bool gat=
e);<br>
&#43;static void cz_dpm_fini(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;static struct cz_ps *cz_get_ps(struct amdgpu_ps *rps)<br>
&nbsp;{<br>
@@ -411,11 &#43;412,11 @@ static int cz_dpm_init(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_get_platfor=
m_caps(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto err;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_parse_exten=
ded_power_table(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto err;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;sram_end =3D SMC_RA=
M_END;<br>
&nbsp;<br>
@@ -469,23 &#43;470,26 @@ static int cz_dpm_init(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_parse_sys_info_=
table(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto err;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_patch_voltage_values(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_construct_boot_state(ad=
ev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_parse_power_tab=
le(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto err;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_process_firmwar=
e_header(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto err;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;dpm_enabled =3D tru=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;uvd_dynamic_pg =3D =
false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;err:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_dpm_fini(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void cz_dpm_fini(struct amdgpu_device *adev)<br>
-- <br>
2.9.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB113240C05FF389B5EF0F865CF7ED0DM5PR12MB1132namp_--

--===============1207715967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1207715967==--
