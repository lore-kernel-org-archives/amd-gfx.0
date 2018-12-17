From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: correct the return value for error case
Date: Mon, 17 Dec 2018 15:23:51 +0000
Message-ID: <BN6PR12MB18093C785CCF2CB3A6910A12F7BC0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181217095902.12549-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0394379356=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181217095902.12549-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0394379356==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18093C785CCF2CB3A6910A12F7BC0BN6PR12MB1809namp_"

--_000_BN6PR12MB18093C785CCF2CB3A6910A12F7BC0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, December 17, 2018 4:59:02 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH] drm/amdgpu: correct the return value for error case

It should not return 0 for error case as '0' is actually
a special value for index.

Change-Id: Iced8b4427d4403f86826a7c8e3c9d1da3394246c
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 20 ++++++++++++--------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 24dea17b4161..ee26181222ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -83,8 +83,8 @@ struct psp_funcs
                                   enum AMDGPU_UCODE_ID ucode_type);
         bool (*smu_reload_quirk)(struct psp_context *psp);
         int (*mode1_reset)(struct psp_context *psp);
-       uint64_t (*xgmi_get_node_id)(struct psp_context *psp);
-       uint64_t (*xgmi_get_hive_id)(struct psp_context *psp);
+       int (*xgmi_get_node_id)(struct psp_context *psp, uint64_t *node_id)=
;
+       int (*xgmi_get_hive_id)(struct psp_context *psp, uint64_t *hive_id)=
;
         int (*xgmi_get_topology_info)(struct psp_context *psp, int number_=
devices,
                                       struct psp_xgmi_topology_info *topol=
ogy);
         int (*xgmi_set_topology_info)(struct psp_context *psp, int number_=
devices,
@@ -216,10 +216,10 @@ struct tmz_clear_vpr {
                 ((psp)->funcs->support_vmr_ring ? (psp)->funcs->support_vm=
r_ring((psp)) : false)
 #define psp_mode1_reset(psp) \
                 ((psp)->funcs->mode1_reset ? (psp)->funcs->mode1_reset((ps=
p)) : false)
-#define psp_xgmi_get_node_id(psp) \
-               ((psp)->funcs->xgmi_get_node_id ? (psp)->funcs->xgmi_get_no=
de_id((psp)) : 0)
-#define psp_xgmi_get_hive_id(psp) \
-               ((psp)->funcs->xgmi_get_hive_id ? (psp)->funcs->xgmi_get_hi=
ve_id((psp)) : 0)
+#define psp_xgmi_get_node_id(psp, node_id) \
+               ((psp)->funcs->xgmi_get_node_id ? (psp)->funcs->xgmi_get_no=
de_id((psp), (node_id)) : -EINVAL)
+#define psp_xgmi_get_hive_id(psp, hive_id) \
+               ((psp)->funcs->xgmi_get_hive_id ? (psp)->funcs->xgmi_get_hi=
ve_id((psp), (hive_id)) : -EINVAL)
 #define psp_xgmi_get_topology_info(psp, num_device, topology) \
                 ((psp)->funcs->xgmi_get_topology_info ? \
                 (psp)->funcs->xgmi_get_topology_info((psp), (num_device), =
(topology)) : -EINVAL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 0b263a9857c6..8a8bc60cb6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -97,8 +97,19 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
         if (!adev->gmc.xgmi.supported)
                 return 0;

-       adev->gmc.xgmi.node_id =3D psp_xgmi_get_node_id(&adev->psp);
-       adev->gmc.xgmi.hive_id =3D psp_xgmi_get_hive_id(&adev->psp);
+       ret =3D psp_xgmi_get_node_id(&adev->psp, &adev->gmc.xgmi.node_id);
+       if (ret) {
+               dev_err(adev->dev,
+                       "XGMI: Failed to get node id\n");
+               return ret;
+       }
+
+       ret =3D psp_xgmi_get_hive_id(&adev->psp, &adev->gmc.xgmi.hive_id);
+       if (ret) {
+               dev_err(adev->dev,
+                       "XGMI: Failed to get hive id\n");
+               return ret;
+       }

         mutex_lock(&xgmi_mutex);
         hive =3D amdgpu_get_xgmi_hive(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 0a390a9544b5..d9b4a3aca3be 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -704,7 +704,7 @@ static int psp_v11_0_xgmi_set_topology_info(struct psp_=
context *psp,
         return psp_xgmi_invoke(psp, TA_COMMAND_XGMI__SET_TOPOLOGY_INFO);
 }

-static u64 psp_v11_0_xgmi_get_hive_id(struct psp_context *psp)
+static int psp_v11_0_xgmi_get_hive_id(struct psp_context *psp, uint64_t *h=
ive_id)
 {
         struct ta_xgmi_shared_memory *xgmi_cmd;
         int ret;
@@ -717,12 +717,14 @@ static u64 psp_v11_0_xgmi_get_hive_id(struct psp_cont=
ext *psp)
         /* Invoke xgmi ta to get hive id */
         ret =3D psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
         if (ret)
-               return 0;
-       else
-               return xgmi_cmd->xgmi_out_message.get_hive_id.hive_id;
+               return ret;
+
+       *hive_id =3D xgmi_cmd->xgmi_out_message.get_hive_id.hive_id;
+
+       return 0;
 }

-static u64 psp_v11_0_xgmi_get_node_id(struct psp_context *psp)
+static int psp_v11_0_xgmi_get_node_id(struct psp_context *psp, uint64_t *n=
ode_id)
 {
         struct ta_xgmi_shared_memory *xgmi_cmd;
         int ret;
@@ -735,9 +737,11 @@ static u64 psp_v11_0_xgmi_get_node_id(struct psp_conte=
xt *psp)
         /* Invoke xgmi ta to get the node id */
         ret =3D psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
         if (ret)
-               return 0;
-       else
-               return xgmi_cmd->xgmi_out_message.get_node_id.node_id;
+               return ret;
+
+       *node_id =3D xgmi_cmd->xgmi_out_message.get_node_id.node_id;
+
+       return 0;
 }

 static const struct psp_funcs psp_v11_0_funcs =3D {
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18093C785CCF2CB3A6910A12F7BC0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Monday, December 17, 2018 4:59:02 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amdgpu: correct the return value for error case=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It should not return 0 for error case as '0' is ac=
tually<br>
a special value for index.<br>
<br>
Change-Id: Iced8b4427d4403f86826a7c8e3c9d1da3394246c<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp; | 12 &#43;&#43;&#43;&#4=
3;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 15 &#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c&nbsp;&nbsp; | 20 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&nbsp;3 files changed, 31 insertions(&#43;), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index 24dea17b4161..ee26181222ad 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -83,8 &#43;83,8 @@ struct psp_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum AMDGPU_UCODE_ID=
 ucode_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*smu_reload_quirk)(s=
truct psp_context *psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*mode1_reset)(struct =
psp_context *psp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t (*xgmi_get_node_id)(struct p=
sp_context *psp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t (*xgmi_get_hive_id)(struct p=
sp_context *psp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*xgmi_get_node_id)(struct ps=
p_context *psp, uint64_t *node_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*xgmi_get_hive_id)(struct ps=
p_context *psp, uint64_t *hive_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*xgmi_get_topology_in=
fo)(struct psp_context *psp, int number_devices,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct psp_xgmi_topology_info *topology);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*xgmi_set_topology_in=
fo)(struct psp_context *psp, int number_devices,<br>
@@ -216,10 &#43;216,10 @@ struct tmz_clear_vpr {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;support_vmr_ring ? (psp)-&gt;fun=
cs-&gt;support_vmr_ring((psp)) : false)<br>
&nbsp;#define psp_mode1_reset(psp) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;mode1_reset ? (psp)-&gt;funcs-&g=
t;mode1_reset((psp)) : false)<br>
-#define psp_xgmi_get_node_id(psp) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((psp)-&gt;funcs-&gt;xgmi_get_node_id ? (psp)-&gt;funcs-&gt;xgmi=
_get_node_id((psp)) : 0)<br>
-#define psp_xgmi_get_hive_id(psp) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((psp)-&gt;funcs-&gt;xgmi_get_hive_id ? (psp)-&gt;funcs-&gt;xgmi=
_get_hive_id((psp)) : 0)<br>
&#43;#define psp_xgmi_get_node_id(psp, node_id) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;xgmi_get_node_id ? (psp)-&gt;funcs-&gt;=
xgmi_get_node_id((psp), (node_id)) : -EINVAL)<br>
&#43;#define psp_xgmi_get_hive_id(psp, hive_id) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;xgmi_get_hive_id ? (psp)-&gt;funcs-&gt;=
xgmi_get_hive_id((psp), (hive_id)) : -EINVAL)<br>
&nbsp;#define psp_xgmi_get_topology_info(psp, num_device, topology) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;funcs-&gt;xgmi_get_topology_info ? \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (psp)-&gt;funcs-&gt;xgmi_get_topology_info((psp), (nu=
m_device), (topology)) : -EINVAL)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index 0b263a9857c6..8a8bc60cb6b4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -97,8 &#43;97,19 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.sup=
ported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.node_id =3D psp_xgm=
i_get_node_id(&amp;adev-&gt;psp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.hive_id =3D psp_xgm=
i_get_hive_id(&amp;adev-&gt;psp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_get_node_id(&amp=
;adev-&gt;psp, &amp;adev-&gt;gmc.xgmi.node_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XGMI: =
Failed to get node id\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_get_hive_id(&amp=
;adev-&gt;psp, &amp;adev-&gt;gmc.xgmi.hive_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XGMI: =
Failed to get hive id\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;xgmi_mutex=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_get_xgmi_h=
ive(adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index 0a390a9544b5..d9b4a3aca3be 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -704,7 &#43;704,7 @@ static int psp_v11_0_xgmi_set_topology_info(struct =
psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_xgmi_invoke(psp=
, TA_COMMAND_XGMI__SET_TOPOLOGY_INFO);<br>
&nbsp;}<br>
&nbsp;<br>
-static u64 psp_v11_0_xgmi_get_hive_id(struct psp_context *psp)<br>
&#43;static int psp_v11_0_xgmi_get_hive_id(struct psp_context *psp, uint64_=
t *hive_id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_xgmi_shared_memo=
ry *xgmi_cmd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
@@ -717,12 &#43;717,14 @@ static u64 psp_v11_0_xgmi_get_hive_id(struct psp_=
context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Invoke xgmi ta to get h=
ive id */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_invoke(ps=
p, xgmi_cmd-&gt;cmd_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return xgmi_cmd-&gt;xgmi_out_message.get_hive_id.hive_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hive_id =3D xgmi_cmd-&gt;xgmi_ou=
t_message.get_hive_id.hive_id;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static u64 psp_v11_0_xgmi_get_node_id(struct psp_context *psp)<br>
&#43;static int psp_v11_0_xgmi_get_node_id(struct psp_context *psp, uint64_=
t *node_id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_xgmi_shared_memo=
ry *xgmi_cmd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
@@ -735,9 &#43;737,11 @@ static u64 psp_v11_0_xgmi_get_node_id(struct psp_c=
ontext *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Invoke xgmi ta to get t=
he node id */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_xgmi_invoke(ps=
p, xgmi_cmd-&gt;cmd_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return xgmi_cmd-&gt;xgmi_out_message.get_node_id.node_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *node_id =3D xgmi_cmd-&gt;xgmi_ou=
t_message.get_node_id.node_id;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const struct psp_funcs psp_v11_0_funcs =3D {<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18093C785CCF2CB3A6910A12F7BC0BN6PR12MB1809namp_--

--===============0394379356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0394379356==--
