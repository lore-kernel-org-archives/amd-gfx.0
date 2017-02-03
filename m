From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/12] mise patch related uvd/vce cg and pg.
Date: Fri, 3 Feb 2017 12:10:14 +0000
Message-ID: <CY4PR12MB1687B033A06043A6620A9DE8FB4F0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1485428438-13989-1-git-send-email-Rex.Zhu@amd.com>,
 <29b2ec13-be6a-acb0-6dff-9620671cc026@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <29b2ec13-be6a-acb0-6dff-9620671cc026-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--_004_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks Alex and Christian.


Patch7 is just a workaround for issue: when dpm disabled, can't initialize =
uvd on Ci.

Now I have found the root cause. so no need to add timeout time.


Please review the attached patch.

Best Regards
Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Friday, January 27, 2017 4:34 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 00/12] mise patch related uvd/vce cg and pg.

I only skimmed over it, but what I saw looked mostly good to me.

Patch #7: Please add a code comment explaining why we do this.

Apart from that the rest is Acked-by: Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Regards,
Christian.

Am 26.01.2017 um 12:00 schrieb Rex Zhu:
> Rex Zhu (12):
>    drm/amdgpu: when dpm disabled, also can enable uvd cg/pg.
>    drm/amdgpu: add current_pg_status register define for smu7.1
>    drm/amdgpu: power down/up uvd4 when smu disabled.
>    drm/amdgpu: refine uvd pg code in kv_dpm.c
>    drm/amdgpu: refine uvd4.2 init/stop code.
>    drm/amdgpu: refine uvd5.0/6.0 code.
>    drm/amdgpu: add uvd timeout time.
>    drm/amdgpu: when dpm disabled, also need to stop/start vce.
>    drm/amdgpu: refine code for VCE2.0 and related dpm code.
>    drm/amdgpu: enable vce pg feature on Kv.
>    drm/amdgpu: move subfunctions to the front of vce_v2_0.c.
>    drm/amdgpu: refine vce3.0 code and related powerplay pg code.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |   9 +
>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |   9 -
>   drivers/gpu/drm/amd/amdgpu/cik.c                   |   4 +-
>   drivers/gpu/drm/amd/amdgpu/kv_dpm.c                |  68 +---
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              | 130 ++++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |  24 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  21 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              | 451 +++++++++++---=
-------
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  17 +-
>   .../gpu/drm/amd/include/asic_reg/smu/smu_7_0_1_d.h |   1 +
>   .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c  |  71 ++--
>   .../amd/powerplay/hwmgr/smu7_clockpowergating.c    |  23 +-
>   14 files changed, 438 insertions(+), 414 deletions(-)
>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Thanks Alex and Christian.</p>
<p><br>
</p>
<p>Patch7 is just&nbsp;a workaround for issue: when dpm disabled, can't ini=
tialize uvd on&nbsp;Ci.&nbsp;</p>
<p>Now I have found the root cause. so no need to add timeout time.&nbsp;</=
p>
<p><br>
</p>
<p>Please review the attached patch.&nbsp;</p>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<span style=3D"font-size: 12pt;"><br>
</span></div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<span style=3D"font-size: 12pt;">Best Regards</span></div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
Rex</div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<div></div>
<br>
</div>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;death=
simple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, January 27, 2017 4:34 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 00/12] mise patch related uvd/vce cg and pg.</fo=
nt>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">I only skimmed over it, but what I saw looked most=
ly good to me.<br>
<br>
Patch #7: Please add a code comment explaining why we do this.<br>
<br>
Apart from that the rest is Acked-by: Christian K=F6nig <br>
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 26.01.2017 um 12:00 schrieb Rex Zhu:<br>
&gt; Rex Zhu (12):<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: when dpm disabled, also can enable uvd c=
g/pg.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: add current_pg_status register define fo=
r smu7.1<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: power down/up uvd4 when smu disabled.<br=
>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine uvd pg code in kv_dpm.c<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine uvd4.2 init/stop code.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine uvd5.0/6.0 code.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: add uvd timeout time.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: when dpm disabled, also need to stop/sta=
rt vce.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine code for VCE2.0 and related dpm c=
ode.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: enable vce pg feature on Kv.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: move subfunctions to the front of vce_v2=
_0.c.<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine vce3.0 code and related powerplay=
 pg code.<br>
&gt;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 12 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 &#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 9 -<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/cik.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp; 4 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/kv_dpm.c&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 68 &#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 130 &#43;&#43;&=
#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 24 &#43;-=
<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 21 &#43;-=
<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v2_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 451 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 &#43;-=
<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/include/asic_reg/smu/smu_7_0_1_d.h |&nbsp;=
&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c&nbsp; |&=
nbsp; 71 &#43;&#43;--<br>
&gt;&nbsp;&nbsp; .../amd/powerplay/hwmgr/smu7_clockpowergating.c&nbsp;&nbsp=
;&nbsp; |&nbsp; 23 &#43;-<br>
&gt;&nbsp;&nbsp; 14 files changed, 438 insertions(&#43;), 414 deletions(-)<=
br>
&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk95829" previewremoved=3D"true">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14861233545480.24770334642380476" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14861233545370.7303266131784767" cellspacing=3D"0"=
 style=3D"width: 90%; position: relative; overflow: auto; padding-top: 20px=
; padding-bottom: 20px; margin-top: 20px; border-top-width: 1px; border-top=
-style: dotted; border-top-color: rgb(200, 200, 200); border-bottom-width: =
1px; border-bottom-style: dotted; border-bottom-color: rgb(200, 200, 200); =
background-color: rgb(255, 255, 255);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14861233545420.6267699955496937" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14861233545420.5892529881093651"></div>
<div id=3D"LPTitle_14861233545420.3257206380367279" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, 'Segoe UI Light', 'Segoe WP Light', 'Segoe UI', 'Segoe WP',=
 Tahoma, Arial, sans-serif; line-height: 21px;">
<a id=3D"LPUrlAnchor_14861233545440.7875377230811864" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14861233545440.3748800181783736" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, 'Segoe UI', 'Segoe WP', Tahoma, Arial, sans-serif; font-s=
ize: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14861233545450.265732379630208" style=3D"display: =
block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_sego=
e-ui_normal, 'Segoe UI', 'Segoe WP', Tahoma, Arial, sans-serif; font-size: =
14px; line-height: 20px; max-height: 100px; overflow: hidden;">
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
</body>
</html>

--_000_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_--

--_004_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-fix-uvd-can-t-initialized-when-dpm-disabl.patch"
Content-Description: 0001-drm-amdgpu-fix-uvd-can-t-initialized-when-dpm-disabl.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-fix-uvd-can-t-initialized-when-dpm-disabl.patch";
	size=2228; creation-date="Fri, 03 Feb 2017 12:04:17 GMT";
	modification-date="Fri, 03 Feb 2017 12:04:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMDJmN2NmNmQ4OGU3MmM1ZjkxMGM5YjMzNTY4ZjAxNmI4OThkMjE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IEZyaSwg
MyBGZWIgMjAxNyAxNzozMzoxMSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZp
eCB1dmQgY2FuJ3QgaW5pdGlhbGl6ZWQgd2hlbiBkcG0gZGlzYWJsZWQgb24KIENpLgoKbmVlZCB0
byBzdGFydCBzbWMgd2hlbiBkcG0gZGlzYWJsZWQuCm90aGVyd2lzZSwgdXZkIGNhbid0IGdldCBy
ZXNwb25zZSBmcm9tIHNtdS4KYW5kIHNvIHV2ZCByaW5nIHRlc3QgYW5kIGliIHRlc3Qgd2lsbCB0
aW1lb3V0LgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2RwbS5jIHwgMjAgKysr
KysrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2NpX2Rw
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMKaW5kZXggMTEzY2QxNi4u
Zjk3ZWNiNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lfZHBtLmMKQEAgLTIyMTAsNyArMjIx
MCw2IEBAIHN0YXRpYyB2b2lkIGNpX2NsZWFyX3ZjKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCiBzdGF0aWMgaW50IGNpX3VwbG9hZF9maXJtd2FyZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIHsKLQlzdHJ1Y3QgY2lfcG93ZXJfaW5mbyAqcGkgPSBjaV9nZXRfcGkoYWRldik7CiAJ
aW50IGksIHJldDsKIAogCWlmIChhbWRncHVfY2lfaXNfc21jX3J1bm5pbmcoYWRldikpIHsKQEAg
LTIyMjcsNyArMjIyNiw3IEBAIHN0YXRpYyBpbnQgY2lfdXBsb2FkX2Zpcm13YXJlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCWFtZGdwdV9jaV9zdG9wX3NtY19jbG9jayhhZGV2KTsKIAlh
bWRncHVfY2lfcmVzZXRfc21jKGFkZXYpOwogCi0JcmV0ID0gYW1kZ3B1X2NpX2xvYWRfc21jX3Vj
b2RlKGFkZXYsIHBpLT5zcmFtX2VuZCk7CisJcmV0ID0gYW1kZ3B1X2NpX2xvYWRfc21jX3Vjb2Rl
KGFkZXYsIFNNQ19SQU1fRU5EKTsKIAogCXJldHVybiByZXQ7CiAKQEAgLTYyNjksMTMgKzYyNjgs
MTMgQEAgc3RhdGljIGludCBjaV9kcG1fc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAJYWRldi0+cG0u
Y3VycmVudF9tY2xrID0gYWRldi0+Y2xvY2suZGVmYXVsdF9tY2xrOwogCWFkZXYtPnBtLmludF90
aGVybWFsX3R5cGUgPSBUSEVSTUFMX1RZUEVfTk9ORTsKIAotCWlmIChhbWRncHVfZHBtID09IDAp
Ci0JCXJldHVybiAwOwotCiAJcmV0ID0gY2lfZHBtX2luaXRfbWljcm9jb2RlKGFkZXYpOwogCWlm
IChyZXQpCiAJCXJldHVybiByZXQ7CiAKKwlpZiAoYW1kZ3B1X2RwbSA9PSAwKQorCQlyZXR1cm4g
MDsKKwogCUlOSVRfV09SSygmYWRldi0+cG0uZHBtLnRoZXJtYWwud29yaywgYW1kZ3B1X2RwbV90
aGVybWFsX3dvcmtfaGFuZGxlcik7CiAJbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgpOwogCXJl
dCA9IGNpX2RwbV9pbml0KGFkZXYpOwpAQCAtNjMxOSw4ICs2MzE4LDE1IEBAIHN0YXRpYyBpbnQg
Y2lfZHBtX2h3X2luaXQodm9pZCAqaGFuZGxlKQogCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAKLQlpZiAoIWFtZGdwdV9kcG0p
CisJaWYgKCFhbWRncHVfZHBtKSB7CisJCXJldCA9IGNpX3VwbG9hZF9maXJtd2FyZShhZGV2KTsK
KwkJaWYgKHJldCkgeworCQkJRFJNX0VSUk9SKCJjaV91cGxvYWRfZmlybXdhcmUgZmFpbGVkXG4i
KTsKKwkJCXJldHVybiByZXQ7CisJCX0KKwkJY2lfZHBtX3N0YXJ0X3NtYyhhZGV2KTsKIAkJcmV0
dXJuIDA7CisJfQogCiAJbXV0ZXhfbG9jaygmYWRldi0+cG0ubXV0ZXgpOwogCWNpX2RwbV9zZXR1
cF9hc2ljKGFkZXYpOwpAQCAtNjM0Miw2ICs2MzQ4LDggQEAgc3RhdGljIGludCBjaV9kcG1faHdf
ZmluaSh2b2lkICpoYW5kbGUpCiAJCW11dGV4X2xvY2soJmFkZXYtPnBtLm11dGV4KTsKIAkJY2lf
ZHBtX2Rpc2FibGUoYWRldik7CiAJCW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgpOworCX0g
ZWxzZSB7CisJCWNpX2RwbV9zdG9wX3NtYyhhZGV2KTsKIAl9CiAKIAlyZXR1cm4gMDsKLS0gCjEu
OS4xCgo=

--_004_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY4PR12MB1687B033A06043A6620A9DE8FB4F0CY4PR12MB1687namp_--
