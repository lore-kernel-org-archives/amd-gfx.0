From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module
Date: Fri, 9 Mar 2018 05:10:48 +0000
Message-ID: <CY4PR12MB1687F2F0D4288F02D750C755FBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180308205409.3203-1-alexander.deucher@amd.com>,
 <20180308205409.3203-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180308205409.3203-2-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--_004_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


How about keep the firmware type checking in set_ip_blocks.

and remove the same check code in psp module.

also no need to change load type if psp load firmware failed in psp module.


Please review the attached patch.


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, March 9, 2018 4:54 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module

We already handle the firmware loading type checks in the
psp module directly, no need for an additional check.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 8dc8b72ed49b..ecf58a68cf66 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -531,8 +531,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
                 amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
                 amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
                 amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
-               if (amdgpu_fw_load_type =3D=3D 2 || amdgpu_fw_load_type =3D=
=3D -1)
-                       amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block=
);
+               amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
                 if (!amdgpu_sriov_vf(adev))
                         amdgpu_device_ip_block_add(adev, &amdgpu_pp_ip_blo=
ck);
                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



--_000_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">How about keep the firmware type =
checking in
<font size=3D"2"><span style=3D"font-size:11pt;">set_ip_blocks</span></font=
>.</p>
<p style=3D"margin-top:0;margin-bottom:0">and remove the same check code in=
 psp module.</p>
<p style=3D"margin-top:0;margin-bottom:0">also no need to change load type =
if psp load firmware failed in psp module.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Please review the attached patch.=
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block;width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher=
@gmail.com&gt;<br>
<b>Sent:</b> Friday, March 9, 2018 4:54 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We already handle the firmware loading type checks=
 in the<br>
psp module directly, no need for an additional check.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c | 3 &#43;--<br>
&nbsp;1 file changed, 1 insertion(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 8dc8b72ed49b..ecf58a68cf66 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -531,8 &#43;531,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vega10_common_i=
p_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gmc_v9_0_ip_blo=
ck);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;vega10_ih_ip_bl=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_fw_load_type =3D=3D 2 || amdgpu_fw_load_type =3D=3D -=
1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;psp_v3_1_ip_block);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v3_1_ip_block);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;amdgpu_pp_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;enable_virtual_display || amdgpu_sriov_v=
f(adev))<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a previewremoved=3D"true" id=3D"LPlnk123469" href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_15205709349260.10638474698232214">
<table role=3D"presentation" style=3D"width: 90%; background-color: rgb(255=
, 255, 255); position: relative; overflow: auto; padding-top: 20px; padding=
-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200);=
 border-bottom: 1px dotted rgb(200, 200, 200);" id=3D"LPContainer_152057093=
49240.2808290117558123" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_15205709349240.5375816182761378=
">
<div id=3D"LPRemovePreviewContainer_15205709349250.20990631388199998"></div=
>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_15205709349250.744=
041292827629">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_15205709349250=
.5260705269625694">amd-gfx Info Page - freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_15205709349250.4352603789039715">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_15205709349260.44569=
05619796764">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_--

--_004_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-Remove-additional-firmware-loading-type-c.patch"
Content-Description: 0001-drm-amdgpu-Remove-additional-firmware-loading-type-c.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Remove-additional-firmware-loading-type-c.patch";
	size=2261; creation-date="Fri, 09 Mar 2018 05:09:32 GMT";
	modification-date="Fri, 09 Mar 2018 05:09:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyOWI3NzE3Yjk3ZmZmODFmMGRjZDgwYjRiZGEyNGNlYTNkNjkwM2JiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IEZyaSwg
OSBNYXIgMjAxOCAxMjozNDowNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IFJl
bW92ZSBhZGRpdGlvbmFsIGZpcm13YXJlIGxvYWRpbmcgdHlwZSBjaGVjayBpbgogcHNwIG1vZHVs
ZQoKUFNQIGlwIG9ubHkgYmUgYWRkZWQgYW5kIGluaXRpYWxpemVkIGluIFBTUCBsb2FkIGZpcm13
YXJlIGNhc2UuCndoZW4gUFNQIGxvYWQgZmFpbGVkLCBjaGFuZ2UgdGhlIGxvYWQgdHlwZSBpcyBt
ZWFubGVzcywgYmVjYXVzZQppbiB0aGlzIGNhc2UsIGRyaXZlciBkbyBub3Qgc3VwcG9ydCBvdGhl
ciBsb2FkIHR5cGUgYW5kCndpbGwgcmV0dXJuIGZhaWxlZCBkaXJlY3RseS4KCkNoYW5nZS1JZDog
SWViZTgwNjQyZmNiYjBjODAyZDI1MDA1YmU1ZWY2MDczNWE1NzU4ZWUKU2lnbmVkLW9mZi1ieTog
UmV4IFpodSA8UmV4LlpodUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYyB8IDE1IC0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE1IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCA2
ZTcxMmYxLi4xOTk3Zjc5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5j
CkBAIC0zOTEsMTAgKzM5MSw2IEBAIHN0YXRpYyBpbnQgcHNwX2h3X2luaXQodm9pZCAqaGFuZGxl
KQogCWludCByZXQ7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKiloYW5kbGU7CiAKLQotCWlmIChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgIT0g
QU1ER1BVX0ZXX0xPQURfUFNQKQotCQlyZXR1cm4gMDsKLQogCW11dGV4X2xvY2soJmFkZXYtPmZp
cm13YXJlLm11dGV4KTsKIAkvKgogCSAqIFRoaXMgc2VxdWVuY2UgaXMganVzdCB1c2VkIG9uIGh3
X2luaXQgb25seSBvbmNlLCBubyBuZWVkIG9uCkBAIC00MTQsNyArNDEwLDYgQEAgc3RhdGljIGlu
dCBwc3BfaHdfaW5pdCh2b2lkICpoYW5kbGUpCiAJcmV0dXJuIDA7CiAKIGZhaWxlZDoKLQlhZGV2
LT5maXJtd2FyZS5sb2FkX3R5cGUgPSBBTURHUFVfRldfTE9BRF9ESVJFQ1Q7CiAJbXV0ZXhfdW5s
b2NrKCZhZGV2LT5maXJtd2FyZS5tdXRleCk7CiAJcmV0dXJuIC1FSU5WQUw7CiB9CkBAIC00MjQs
OSArNDE5LDYgQEAgc3RhdGljIGludCBwc3BfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAJ
c3RydWN0IHBzcF9jb250ZXh0ICpwc3AgPSAmYWRldi0+cHNwOwogCi0JaWYgKGFkZXYtPmZpcm13
YXJlLmxvYWRfdHlwZSAhPSBBTURHUFVfRldfTE9BRF9QU1ApCi0JCXJldHVybiAwOwotCiAJYW1k
Z3B1X3Vjb2RlX2ZpbmlfYm8oYWRldik7CiAKIAlwc3BfcmluZ19kZXN0cm95KHBzcCwgUFNQX1JJ
TkdfVFlQRV9fS00pOwpAQCAtNDY4LDggKzQ2MCw2IEBAIHN0YXRpYyBpbnQgcHNwX3Jlc3VtZSh2
b2lkICpoYW5kbGUpCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKiloYW5kbGU7CiAJc3RydWN0IHBzcF9jb250ZXh0ICpwc3AgPSAmYWRldi0+cHNw
OwogCi0JaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSAhPSBBTURHUFVfRldfTE9BRF9QU1Ap
Ci0JCXJldHVybiAwOwogCiAJRFJNX0lORk8oIlBTUCBpcyByZXN1bWluZy4uLlxuIik7CiAKQEAg
LTUwMywxMSArNDkzLDYgQEAgc3RhdGljIGJvb2wgcHNwX2NoZWNrX2Z3X2xvYWRpbmdfc3RhdHVz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCXN0cnVjdCBhbWRncHVfZmlybXdhcmVf
aW5mbyAqdWNvZGUgPSBOVUxMOwogCi0JaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSAhPSBB
TURHUFVfRldfTE9BRF9QU1ApIHsKLQkJRFJNX0lORk8oImZpcm13YXJlIGlzIG5vdCBsb2FkZWQg
YnkgUFNQXG4iKTsKLQkJcmV0dXJuIHRydWU7Ci0JfQotCiAJaWYgKCFhZGV2LT5maXJtd2FyZS5m
d19zaXplKQogCQlyZXR1cm4gZmFsc2U7CiAKLS0gCjEuOS4xCgo=

--_004_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY4PR12MB1687F2F0D4288F02D750C755FBDE0CY4PR12MB1687namp_--
