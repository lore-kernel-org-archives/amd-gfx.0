From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/6] drm/amdgpu: add info ioctl query for vce clock info
Date: Fri, 7 Oct 2016 14:35:50 -0400
Message-ID: <CADnq5_M4Bw5aiov0+TKmY5n7X+Rv=HmbnhZGh8-4ZFX8-tuLKA@mail.gmail.com>
References: <1475864905-21269-1-git-send-email-alexander.deucher@amd.com>
 <1475864905-21269-2-git-send-email-alexander.deucher@amd.com>
 <BN6PR12MB1764E581BC7A01B74C850D83F7C60@BN6PR12MB1764.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0246468539=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1764E581BC7A01B74C850D83F7C60-/b2+HYfkarS51p+Siuid1wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Boyuan" <Boyuan.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Fang,
 Peter" <Peter.Fang-5C7GfCeVMHo@public.gmane.org>

--===============0246468539==
Content-Type: multipart/alternative; boundary=001a113f1770f41f76053e4aad35

--001a113f1770f41f76053e4aad35
Content-Type: text/plain; charset=UTF-8

No, you can just check if it fails or not (i.e., the ioctl will return
-EINVAL if the query is not supported).

Alex

On Fri, Oct 7, 2016 at 2:33 PM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org> wrote:

> Shouldn't there be a version bump if you're adding a new command to the
> ioctl?
>
>
> Tom
>
>
> ------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex
> Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, October 7, 2016 14:28
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Fang, Peter; Zhang, Boyuan
> *Cc:* Deucher, Alexander
> *Subject:* [PATCH 2/6] drm/amdgpu: add info ioctl query for vce clock info
>
> This is needed to set up the vce clock table in userspace
> for proper VCE DPM.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index b6a04d4..7cb71f8 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -491,6 +491,8 @@ struct drm_amdgpu_cs_chunk_data {
>  #define AMDGPU_INFO_NUM_EVICTIONS               0x18
>  /* Query memory about VRAM and GTT domains */
>  #define AMDGPU_INFO_MEMORY                      0x19
> +/* Query memory about VRAM and GTT domains */
> +#define AMDGPU_INFO_VCE_CLOCK_TABLE            0x1A
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT  0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK   0xff
> @@ -677,6 +679,22 @@ struct drm_amdgpu_info_hw_ip {
>          __u32  _pad;
>  };
>
> +#define AMDGPU_VCE_CLOCK_TABLE_ENTRIES         6
> +
> +struct drm_amdgpu_info_vce_clock_table_entry {
> +       /** System clock */
> +       __u32 sclk;
> +       /** Memory clock */
> +       __u32 mclk;
> +       /** VCE clock */
> +       __u32 eclk;
> +       __u32 pad;
> +};
> +
> +struct drm_amdgpu_info_vce_clock_table {
> +       struct drm_amdgpu_info_vce_clock_table_entry
> entries[AMDGPU_VCE_CLOCK_TABLE_ENTRIES];
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.5.5
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - lists.freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx
> Archives. Using amd-gfx: To post a message to all the list members, send
> email ...
>
>
>

--001a113f1770f41f76053e4aad35
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>No, you can just check if it fails or not (i.e., the =
ioctl will return -EINVAL if the query is not supported).<br><br></div>Alex=
<br><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Fri, Oct 7, 2016 at 2:33 PM, StDenis, Tom <span dir=3D"ltr">&lt;<a href=3D"=
mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"m_8418366582461279974divtagdefaultwrapper" style=3D"font-size:12=
pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Shouldn&#39;t there be a version bump if you&#39;re adding a new command=
 to the ioctl?</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_8418366582461279974x_divRplyFwdMsg" dir=3D"ltr"><font style=3D=
"font-size:11pt" color=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b=
> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targ=
et=3D"_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>&gt; on behalf =
of Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_bla=
nk">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 7, 2016 14:28<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Fang, Peter; Zhang, Boyuan<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH 2/6] drm/amdgpu: add info ioctl query for vce clock =
info</font>
<div>=C2=A0</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"m_8418366582461279974PlainText"><div><div class=3D"h5">This i=
s needed to set up the vce clock table in userspace<br>
for proper VCE DPM.<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
" target=3D"_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++<br>
=C2=A01 file changed, 18 insertions(+)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.<wbr>h b/include/uapi/drm/amdgpu_d=
rm.<wbr>h<br>
index b6a04d4..7cb71f8 100644<br>
--- a/include/uapi/drm/amdgpu_drm.<wbr>h<br>
+++ b/include/uapi/drm/amdgpu_drm.<wbr>h<br>
@@ -491,6 +491,8 @@ struct drm_amdgpu_cs_chunk_data {<br>
=C2=A0#define AMDGPU_INFO_NUM_EVICTIONS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x18<br>
=C2=A0/* Query memory about VRAM and GTT domains */<br>
=C2=A0#define AMDGPU_INFO_MEMORY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x19<br>
+/* Query memory about VRAM and GTT domains */<br>
+#define AMDGPU_INFO_VCE_CLOCK_TABLE=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1A<br>
=C2=A0<br>
=C2=A0#define AMDGPU_INFO_MMR_SE_INDEX_<wbr>SHIFT=C2=A0 0<br>
=C2=A0#define AMDGPU_INFO_MMR_SE_INDEX_MASK=C2=A0<wbr>=C2=A0 0xff<br>
@@ -677,6 +679,22 @@ struct drm_amdgpu_info_hw_ip {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=A0 _pad;<br>
=C2=A0};<br>
=C2=A0<br>
+#define AMDGPU_VCE_CLOCK_TABLE_<wbr>ENTRIES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 6<br>
+<br>
+struct drm_amdgpu_info_vce_clock_<wbr>table_entry {<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** System clock */<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 sclk;<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** Memory clock */<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 mclk;<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** VCE clock */<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 eclk;<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32 pad;<br>
+};<br>
+<br>
+struct drm_amdgpu_info_vce_clock_<wbr>table {<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_amdgpu_info_vce_clock_<wbr=
>table_entry entries[AMDGPU_VCE_CLOCK_<wbr>TABLE_ENTRIES];<br>
+};<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Supported GPU families<br>
=C2=A0 */<br>
-- <br>
2.5.5<br>
<br></div></div>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"m_=
8418366582461279974LPlnk721057" target=3D"_blank">https://lists.freedesktop=
.org/<wbr>mailman/listinfo/amd-gfx</a>
<div id=3D"m_8418366582461279974LPBorder_GT_14758651863140.1876984528471310=
5" style=3D"margin-bottom:20px;overflow:auto;width:100%;text-indent:0px">
<table id=3D"m_8418366582461279974LPContainer_14758651863120.59432373178883=
46" style=3D"width:90%;background-color:rgb(255,255,255);overflow:auto;padd=
ing-top:20px;padding-bottom:20px;margin-top:20px;border-top:1px dotted rgb(=
200,200,200);border-bottom:1px dotted rgb(200,200,200)" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"m_8418366582461279974TextCell_14758651863130.019189628010207516" =
colspan=3D"2" style=3D"vertical-align:top;padding:0px;display:table-cell">
<div id=3D"m_8418366582461279974LPRemovePreviewContainer_14758651863130.370=
5829285253708"></div>
<div id=3D"m_8418366582461279974LPTitle_14758651863130.3572217220295699" st=
yle=3D"color:rgb(59,87,119);font-weight:normal;font-size:21px;font-family:w=
f_segoe-ui_light,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quo=
t;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;line-height:2=
1px">
<a id=3D"m_8418366582461279974LPUrlAnchor_14758651863130.4017346381452327" =
href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" style=3D"te=
xt-decoration:none" target=3D"_blank">amd-gfx Info Page - lists.freedesktop=
.org</a></div>
<div id=3D"m_8418366582461279974LPMetadata_14758651863130.05535673901982507=
4" style=3D"margin:10px 0px 16px;color:rgb(102,102,102);font-weight:normal;=
font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif;font-size:14px;line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div id=3D"m_8418366582461279974LPDescription_14758651863140.97601792936054=
6" style=3D"display:block;color:rgb(102,102,102);font-weight:normal;font-fa=
mily:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Ar=
ial,sans-serif;font-size:14px;line-height:20px;max-height:100px;overflow:hi=
dden">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>

</blockquote></div><br></div></div></div></div>

--001a113f1770f41f76053e4aad35--

--===============0246468539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0246468539==--
