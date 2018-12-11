From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH libdrm] tests/amdgpu/vcn: fix the nop command in IBs
Date: Tue, 11 Dec 2018 21:11:10 +0000
Message-ID: <BN6PR12MB18090D97F02E0F57CF4B6F99F7A60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181211210318.10807-1-leo.liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0820037746=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181211210318.10807-1-leo.liu@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Liu, Leo" <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============0820037746==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18090D97F02E0F57CF4B6F99F7A60BN6PR12MB1809namp_"

--_000_BN6PR12MB18090D97F02E0F57CF4B6F99F7A60BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Liu, Leo=
 <Leo.Liu@amd.com>
Sent: Tuesday, December 11, 2018 4:03 PM
To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
Cc: Liu, Leo
Subject: [PATCH libdrm] tests/amdgpu/vcn: fix the nop command in IBs

Just make them properly i.e. put 0 to the Nop reg

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 tests/amdgpu/vcn_tests.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c
index d9f05af8..859ec496 100644
--- a/tests/amdgpu/vcn_tests.c
+++ b/tests/amdgpu/vcn_tests.c
@@ -268,8 +268,10 @@ static void amdgpu_cs_vcn_dec_create(void)
         ib_cpu[len++] =3D msg_buf.addr >> 32;
         ib_cpu[len++] =3D 0x81C3;
         ib_cpu[len++] =3D 0;
-       for (; len % 16; ++len)
-               ib_cpu[len] =3D 0x81ff;
+       for (; len % 16; ) {
+               ib_cpu[len++] =3D 0x81ff;
+               ib_cpu[len++] =3D 0;
+       }

         r =3D submit(len, AMDGPU_HW_IP_VCN_DEC);
         CU_ASSERT_EQUAL(r, 0);
@@ -336,8 +338,10 @@ static void amdgpu_cs_vcn_dec_decode(void)

         ib_cpu[len++] =3D 0x81C6;
         ib_cpu[len++] =3D 0x1;
-       for (; len % 16; ++len)
-               ib_cpu[len] =3D 0x80000000;
+       for (; len % 16; ) {
+               ib_cpu[len++] =3D 0x81ff;
+               ib_cpu[len++] =3D 0;
+       }

         r =3D submit(len, AMDGPU_HW_IP_VCN_DEC);
         CU_ASSERT_EQUAL(r, 0);
@@ -373,8 +377,10 @@ static void amdgpu_cs_vcn_dec_destroy(void)
         ib_cpu[len++] =3D msg_buf.addr >> 32;
         ib_cpu[len++] =3D 0x81C3;
         ib_cpu[len++] =3D 0;
-       for (; len % 16; ++len)
-               ib_cpu[len] =3D 0x80000000;
+       for (; len % 16; ) {
+               ib_cpu[len++] =3D 0x81ff;
+               ib_cpu[len++] =3D 0;
+       }

         r =3D submit(len, AMDGPU_HW_IP_VCN_DEC);
         CU_ASSERT_EQUAL(r, 0);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx@lists.freedesktop.org. You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BN6PR12MB18090D97F02E0F57CF4B6F99F7A60BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher@amd.com&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Liu, Leo &lt;Leo.Liu@amd.co=
m&gt;<br>
<b>Sent:</b> Tuesday, December 11, 2018 4:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org<b=
r>
<b>Cc:</b> Liu, Leo<br>
<b>Subject:</b> [PATCH libdrm] tests/amdgpu/vcn: fix the nop command in IBs=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Just make them properly i.e. put 0 to the Nop reg<=
br>
<br>
Signed-off-by: Leo Liu &lt;leo.liu@amd.com&gt;<br>
---<br>
&nbsp;tests/amdgpu/vcn_tests.c | 18 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;------<br>
&nbsp;1 file changed, 12 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/tests/amdgpu/vcn_tests.c b/tests/amdgpu/vcn_tests.c<br>
index d9f05af8..859ec496 100644<br>
--- a/tests/amdgpu/vcn_tests.c<br>
&#43;&#43;&#43; b/tests/amdgpu/vcn_tests.c<br>
@@ -268,8 &#43;268,10 @@ static void amdgpu_cs_vcn_dec_create(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
msg_buf.addr &gt;&gt; 32;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
0x81C3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; len % 16; &#43;&#43;len)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ib_cpu[len] =3D 0x81ff;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; len % 16; ) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D 0x81ff;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D submit(len, AMDGPU_H=
W_IP_VCN_DEC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
@@ -336,8 &#43;338,10 @@ static void amdgpu_cs_vcn_dec_decode(void)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
0x81C6;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
0x1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; len % 16; &#43;&#43;len)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ib_cpu[len] =3D 0x80000000;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; len % 16; ) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D 0x81ff;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D submit(len, AMDGPU_H=
W_IP_VCN_DEC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
@@ -373,8 &#43;377,10 @@ static void amdgpu_cs_vcn_dec_destroy(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
msg_buf.addr &gt;&gt; 32;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
0x81C3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D =
0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; len % 16; &#43;&#43;len)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ib_cpu[len] =3D 0x80000000;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; len % 16; ) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D 0x81ff;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ib_cpu[len&#43;&#43;] =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D submit(len, AMDGPU_H=
W_IP_VCN_DEC);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk53758" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.freed=
esktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15445623887420.5236685554508548" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15445623887380.1564058365798745" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15445623887390.032671432095180974" style=3D"vertical-ali=
gn: top; position: relative; padding: 0px; display: table-cell;" colspan=3D=
"2">
<div id=3D"LPRemovePreviewContainer_15445623887390.6231212730891129"></div>
<div id=3D"LPTitle_15445623887390.5213951363639248" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15445623887400.8061479971000387" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15445623887400.8280153656906918" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15445623887410.3923663823028356" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx@lists.freedesktop.org. You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB18090D97F02E0F57CF4B6F99F7A60BN6PR12MB1809namp_--

--===============0820037746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0820037746==--
