From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Add comment for NaN checks in DCN calcs
Date: Thu, 12 Oct 2017 09:32:16 +0200
Message-ID: <CA+nq7DvTS3crAD+o5y3XZteovHG7EJXCUsAkudZpmwGUhOAoKw@mail.gmail.com>
References: <20171011145502.7551-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2076097125=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171011145502.7551-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: dmytro.laktyushkin-5C7GfCeVMHo@public.gmane.org, airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alex.deucher-5C7GfCeVMHo@public.gmane.org

--===============2076097125==
Content-Type: multipart/alternative; boundary="089e0826d05c2c3597055b548a2c"

--089e0826d05c2c3597055b548a2c
Content-Type: text/plain; charset="UTF-8"

Hi Harry, couldn't a simple isnan() macro be used? Also a question below.

Den 11 okt. 2017 17:01 skrev "Harry Wentland" <harry.wentland-5C7GfCeVMHo@public.gmane.org>:

This is confusing as-is and really needs a comment.

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
index b6abe0f3bb15..f95dc4ff9a23 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
@@ -27,6 +27,7 @@

 float dcn_bw_mod(const float arg1, const float arg2)
 {
+       /* NaN checks */
        if (arg1 != arg1)
                return arg2;
        if (arg2 != arg2)
@@ -36,6 +37,7 @@ float dcn_bw_mod(const float arg1, const float arg2)

 float dcn_bw_min2(const float arg1, const float arg2)
 {
+       /* NaN checks */
        if (arg1 != arg1)
                return arg2;
        if (arg2 != arg2)
@@ -45,6 +47,7 @@ float dcn_bw_min2(const float arg1, const float arg2)

 unsigned int dcn_bw_max(const unsigned int arg1, const unsigned int arg2)
 {
+       /* NaN checks */


How can the int arguments be NaN?

BR
Nils

        if (arg1 != arg1)
                return arg2;
        if (arg2 != arg2)
@@ -53,6 +56,7 @@ unsigned int dcn_bw_max(const unsigned int arg1, const
unsigned int arg2)
 }
 float dcn_bw_max2(const float arg1, const float arg2)
 {
+       /* NaN checks */
        if (arg1 != arg1)
                return arg2;
        if (arg2 != arg2)
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--089e0826d05c2c3597055b548a2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Harry, couldn&#39;t a simple isnan() macro be use=
d? Also a question below.</div><div dir=3D"auto"><div class=3D"gmail_extra"=
 dir=3D"auto"><br><div class=3D"gmail_quote">Den 11 okt. 2017 17:01 skrev &=
quot;Harry Wentland&quot; &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">har=
ry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;:<br type=3D"attribution"><blockquote class=3D"q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">This is confusing as-is and really needs a comment.<br>
<br>
Signed-off-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org"=
>harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/<wbr>dc/calcs/dcn_calc_math.c | 4 ++++<br=
>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/<wbr>dc/calcs/dcn_calc_math.c b/dr=
ivers/gpu/drm/amd/display/<wbr>dc/calcs/dcn_calc_math.c<br>
index b6abe0f3bb15..f95dc4ff9a23 100644<br>
--- a/drivers/gpu/drm/amd/display/<wbr>dc/calcs/dcn_calc_math.c<br>
+++ b/drivers/gpu/drm/amd/display/<wbr>dc/calcs/dcn_calc_math.c<br>
@@ -27,6 +27,7 @@<br>
<br>
=C2=A0float dcn_bw_mod(const float arg1, const float arg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* NaN checks */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg1 !=3D arg1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return arg2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg2 !=3D arg2)<br>
@@ -36,6 +37,7 @@ float dcn_bw_mod(const float arg1, const float arg2)<br>
<br>
=C2=A0float dcn_bw_min2(const float arg1, const float arg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* NaN checks */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg1 !=3D arg1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return arg2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg2 !=3D arg2)<br>
@@ -45,6 +47,7 @@ float dcn_bw_min2(const float arg1, const float arg2)<br>
<br>
=C2=A0unsigned int dcn_bw_max(const unsigned int arg1, const unsigned int a=
rg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* NaN checks */<br></blockquote></div></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">How can the int arguments=
 be NaN?</div><div dir=3D"auto"><br></div><div dir=3D"auto">BR</div><div di=
r=3D"auto">Nils</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg1 !=3D arg1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return arg2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg2 !=3D arg2)<br>
@@ -53,6 +56,7 @@ unsigned int dcn_bw_max(const unsigned int arg1, const un=
signed int arg2)<br>
=C2=A0}<br>
=C2=A0float dcn_bw_max2(const float arg1, const float arg2)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* NaN checks */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg1 !=3D arg1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return arg2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg2 !=3D arg2)<br>
<font color=3D"#888888">--<br>
2.14.1<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</font></blockquote></div><br></div></div></div>

--089e0826d05c2c3597055b548a2c--

--===============2076097125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2076097125==--
