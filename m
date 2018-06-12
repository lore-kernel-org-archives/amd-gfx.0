From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/include: Update df 3.6 mask and shift definition
Date: Tue, 12 Jun 2018 20:49:34 +0000
Message-ID: <BN6PR12MB18095EC7A1506208E2BDFE82F77F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1528825125-31423-1-git-send-email-Shaoyun.Liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0244729233=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1528825125-31423-1-git-send-email-Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0244729233==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18095EC7A1506208E2BDFE82F77F0BN6PR12MB1809namp_"

--_000_BN6PR12MB18095EC7A1506208E2BDFE82F77F0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Shaoyun =
Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, June 12, 2018 1:38 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liu, Shaoyun
Subject: [PATCH] drm/amd/include: Update df 3.6 mask and shift definition

The register field hsas been changed in df 3.6, update to correct setting

Change-Id: Id625d7698b610c07081f421537964686f8f0b67c
Signed-off-by: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h b/dri=
vers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
index 88f7c69..06fac50 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
@@ -36,13 +36,13 @@
 /* DF_CS_AON0_DramBaseAddress0 */
 #define DF_CS_UMC_AON0_DramBaseAddress0__AddrRngVal__SHIFT                =
                              0x0
 #define DF_CS_UMC_AON0_DramBaseAddress0__LgcyMmioHoleEn__SHIFT            =
                              0x1
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan__SHIFT              =
                             0x4
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel__SHIFT              =
                             0x8
+#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan__SHIFT              =
                             0x2
+#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel__SHIFT              =
                             0x9
 #define DF_CS_UMC_AON0_DramBaseAddress0__DramBaseAddr__SHIFT              =
                              0xc
 #define DF_CS_UMC_AON0_DramBaseAddress0__AddrRngVal_MASK                  =
                              0x00000001L
 #define DF_CS_UMC_AON0_DramBaseAddress0__LgcyMmioHoleEn_MASK              =
                              0x00000002L
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK                =
                             0x000000F0L
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel_MASK                =
                             0x00000700L
+#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK                =
                             0x0000003CL
+#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel_MASK                =
                             0x00000E00L
 #define DF_CS_UMC_AON0_DramBaseAddress0__DramBaseAddr_MASK                =
                              0xFFFFF000L

 #endif
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18095EC7A1506208E2BDFE82F77F0BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Shaoyun Liu &lt;Shaoyun.Liu=
@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 12, 2018 1:38 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Liu, Shaoyun<br>
<b>Subject:</b> [PATCH] drm/amd/include: Update df 3.6 mask and shift defin=
ition</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The register field hsas been changed in df 3.6, up=
date to correct setting<br>
<br>
Change-Id: Id625d7698b610c07081f421537964686f8f0b67c<br>
Signed-off-by: Shaoyun Liu &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h | 8 &#43;&#4=
3;&#43;&#43;----<br>
&nbsp;1 file changed, 4 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h b/dri=
vers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h<br>
index 88f7c69..06fac50 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h<=
br>
@@ -36,13 &#43;36,13 @@<br>
&nbsp;/* DF_CS_AON0_DramBaseAddress0 */<br>
&nbsp;#define DF_CS_UMC_AON0_DramBaseAddress0__AddrRngVal__SHIFT&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&nbsp;#define DF_CS_UMC_AON0_DramBaseAddress0__LgcyMmioHoleEn__SHIFT&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x1<br>
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan__SHIFT&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x4<br>
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel__SHIFT&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0x8<br>
&#43;#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan__SHIFT&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x2<br>
&#43;#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel__SHIFT&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x9<br>
&nbsp;#define DF_CS_UMC_AON0_DramBaseAddress0__DramBaseAddr__SHIFT&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0xc<br>
&nbsp;#define DF_CS_UMC_AON0_DramBaseAddress0__AddrRngVal_MASK&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br>
&nbsp;#define DF_CS_UMC_AON0_DramBaseAddress0__LgcyMmioHoleEn_MASK&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x00000002L<br>
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x000000F0L<br>
-#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel_MASK&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x00000700L<br>
&#43;#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvNumChan_MASK&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0000003CL<br>
&#43;#define DF_CS_UMC_AON0_DramBaseAddress0__IntLvAddrSel_MASK&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000E00L<br>
&nbsp;#define DF_CS_UMC_AON0_DramBaseAddress0__DramBaseAddr_MASK&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFFFFF000L<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk712828" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18095EC7A1506208E2BDFE82F77F0BN6PR12MB1809namp_--

--===============0244729233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0244729233==--
