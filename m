From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 18/18] DO NOT SUBMIT: drm_next fixup
Date: Tue, 18 Apr 2017 23:04:42 -0400
Message-ID: <CAFQ_0eG=Mk6Rz_RyV83pW6MPM+0=tDDn3duWTTDoFnEZtFPbtA@mail.gmail.com>
References: <20170419023546.3084-1-andresx7@gmail.com>
 <20170419023546.3084-19-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0830831616=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170419023546.3084-19-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0830831616==
Content-Type: multipart/alternative; boundary=f403045cf5bc3a4554054d7c4968

--f403045cf5bc3a4554054d7c4968
Content-Type: text/plain; charset=UTF-8

Ooops, please ignore this patch. It was just for local testing.

Regards,
Andres

On Apr 18, 2017 10:36 PM, "Andres Rodriguez" <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> ---
>  drivers/gpu/drm/drm_property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_
> property.c
> index 3feef06..3e88fa2 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -459,41 +459,41 @@ int drm_mode_getproperty_ioctl(struct drm_device
> *dev,
>         out_resp->flags = property->flags;
>
>         value_count = property->num_values;
>         values_ptr = u64_to_user_ptr(out_resp->values_ptr);
>
>         for (i = 0; i < value_count; i++) {
>                 if (i < out_resp->count_values &&
>                     put_user(property->values[i], values_ptr + i)) {
>                         return -EFAULT;
>                 }
>         }
>         out_resp->count_values = value_count;
>
>         copied = 0;
>         enum_ptr = u64_to_user_ptr(out_resp->enum_blob_ptr);
>
>         if (drm_property_type_is(property, DRM_MODE_PROP_ENUM) ||
>             drm_property_type_is(property, DRM_MODE_PROP_BITMASK)) {
>                 list_for_each_entry(prop_enum, &property->enum_list, head)
> {
>                         enum_count++;
> -                       if (out_resp->count_enum_blobs <= enum_count)
> +                       if (out_resp->count_enum_blobs < enum_count)
>                                 continue;
>
>                         if (copy_to_user(&enum_ptr[copied].value,
>                                          &prop_enum->value,
> sizeof(uint64_t)))
>                                 return -EFAULT;
>
>                         if (copy_to_user(&enum_ptr[copied].name,
>                                          &prop_enum->name,
> DRM_PROP_NAME_LEN))
>                                 return -EFAULT;
>                         copied++;
>                 }
>                 out_resp->count_enum_blobs = enum_count;
>         }
>
>         /*
>          * NOTE: The idea seems to have been to use this to read all the
> blob
>          * property values. But nothing ever added them to the
> corresponding
>          * list, userspace always used the special-purpose get_blob ioctl
> to
>          * read the value for a blob property. It also doesn't make a lot
> of
>          * sense to return values here when everything else is just
> metadata for
> --
> 2.9.3
>
>

--f403045cf5bc3a4554054d7c4968
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ooops, please ignore this patch. It was just for local te=
sting.<div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=
=3D"auto">Andres=C2=A0</div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Apr 18, 2017 10:36 PM, &quot;Andres Rodriguez&quot; &lt=
;<a href=3D"mailto:andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br=
 type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">---<br>
=C2=A0drivers/gpu/drm/drm_property.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/drm_<wbr>property.c b/drivers/gpu/drm/drm_<wbr=
>property.c<br>
index 3feef06..3e88fa2 100644<br>
--- a/drivers/gpu/drm/drm_<wbr>property.c<br>
+++ b/drivers/gpu/drm/drm_<wbr>property.c<br>
@@ -459,41 +459,41 @@ int drm_mode_getproperty_ioctl(<wbr>struct drm_device=
 *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_resp-&gt;flags =3D property-&gt;flags;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 value_count =3D property-&gt;num_values;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 values_ptr =3D u64_to_user_ptr(out_resp-&gt;<wb=
r>values_ptr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; value_count; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &lt; out_resp=
-&gt;count_values &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 put_u=
ser(property-&gt;values[i], values_ptr + i)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_resp-&gt;count_values =3D value_count;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 copied =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum_ptr =3D u64_to_user_ptr(out_resp-&gt;<wbr>=
enum_blob_ptr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drm_property_type_is(<wbr>property, DRM_MOD=
E_PROP_ENUM) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_property_type_is(property, DR=
M_MODE_PROP_BITMASK)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry=
(prop_enum, &amp;property-&gt;enum_list, head) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 enum_count++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (out_resp-&gt;count_enum_blobs &lt;=3D enum_count)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (out_resp-&gt;count_enum_blobs &lt; enum_count)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (copy_to_user(&amp;enum_ptr[<wbr>copied].value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;prop_enum-&gt;value, sizeof(uint64_t)))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (copy_to_user(&amp;enum_ptr[<wbr>copied].name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;prop_enum-&gt;name, DRM_PROP_NAME_LEN))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 copied++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_resp-&gt;count_=
enum_blobs =3D enum_count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* NOTE: The idea seems to have been to us=
e this to read all the blob<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* property values. But nothing ever added=
 them to the corresponding<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* list, userspace always used the special=
-purpose get_blob ioctl to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* read the value for a blob property. It =
also doesn&#39;t make a lot of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* sense to return values here when everyt=
hing else is just metadata for<br>
--<br>
2.9.3<br>
<br>
</blockquote></div></div>

--f403045cf5bc3a4554054d7c4968--

--===============0830831616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0830831616==--
