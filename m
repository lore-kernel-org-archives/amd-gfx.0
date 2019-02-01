From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
Date: Fri, 1 Feb 2019 16:12:42 -0500
Message-ID: <CAAxE2A7LKNXpqOafXuAV9tr79p00JdxE=pmee999g+wy_D0UcA@mail.gmail.com>
References: <1549050670-18395-1-git-send-email-andrey.grodzovsky@amd.com>
 <1549051196-25609-1-git-send-email-andrey.grodzovsky@amd.com>
 <CAAxE2A6EnRR4OUJkspWqdhDqHiJuTevW+=G+YycyOrnxtLGiuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0661545900=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A6EnRR4OUJkspWqdhDqHiJuTevW+=G+YycyOrnxtLGiuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0661545900==
Content-Type: multipart/alternative; boundary="000000000000ca900e0580db9c1f"

--000000000000ca900e0580db9c1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you also bump the KMS version?

Thanks,
Marek

On Fri, Feb 1, 2019 at 3:09 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:

> Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> Tested-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>
> On Fri, Feb 1, 2019 at 3:00 PM Andrey Grodzovsky <
> andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org> wrote:
>
>> New chunk for dependency on start of job's execution instead on
>> the end. This is used for GPU deadlock prevention when
>> userspace uses mid-IB fences to wait for mid-IB work on other rings.
>>
>> v2: Fix typo in AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>> Suggested-by: Christian Koenig <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 12 +++++++++++-
>>  include/uapi/drm/amdgpu_drm.h          |  1 +
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 1c49b82..3f21eca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -214,6 +214,7 @@ static int amdgpu_cs_parser_init(struct
>> amdgpu_cs_parser *p, union drm_amdgpu_cs
>>                 case AMDGPU_CHUNK_ID_DEPENDENCIES:
>>                 case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
>>                 case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
>> +               case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
>>                         break;
>>
>>                 default:
>> @@ -1090,6 +1091,14 @@ static int amdgpu_cs_process_fence_dep(struct
>> amdgpu_cs_parser *p,
>>
>>                 fence =3D amdgpu_ctx_get_fence(ctx, entity,
>>                                              deps[i].handle);
>> +
>> +               if (chunk->chunk_id =3D=3D
>> AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {
>> +                       struct drm_sched_fence *s_fence =3D
>> to_drm_sched_fence(fence);
>> +
>> +                       dma_fence_put(fence);
>> +                       fence =3D dma_fence_get(&s_fence->scheduled);
>> +               }
>> +
>>                 if (IS_ERR(fence)) {
>>                         r =3D PTR_ERR(fence);
>>                         amdgpu_ctx_put(ctx);
>> @@ -1177,7 +1186,8 @@ static int amdgpu_cs_dependencies(struct
>> amdgpu_device *adev,
>>
>>                 chunk =3D &p->chunks[i];
>>
>> -               if (chunk->chunk_id =3D=3D AMDGPU_CHUNK_ID_DEPENDENCIES)=
 {
>> +               if (chunk->chunk_id =3D=3D AMDGPU_CHUNK_ID_DEPENDENCIES =
||
>> +                   chunk->chunk_id =3D=3D
>> AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {
>>                         r =3D amdgpu_cs_process_fence_dep(p, chunk);
>>                         if (r)
>>                                 return r;
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index faaad04..43d03a2 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -526,6 +526,7 @@ struct drm_amdgpu_gem_va {
>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_IN      0x04
>>  #define AMDGPU_CHUNK_ID_SYNCOBJ_OUT     0x05
>>  #define AMDGPU_CHUNK_ID_BO_HANDLES      0x06
>> +#define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07
>>
>>  struct drm_amdgpu_cs_chunk {
>>         __u32           chunk_id;
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>

--000000000000ca900e0580db9c1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Can you also bump the KMS version?</div><div><br></di=
v><div>Thanks,</div><div>Marek<br></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 1, 2019 at 3:09 PM Mare=
k Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mail=
to:marek.olsak-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;</div>=
<div>Tested-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd=
.com" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 1, 201=
9 at 3:00 PM Andrey Grodzovsky &lt;<a href=3D"mailto:andrey.grodzovsky@amd.=
com" target=3D"_blank">andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">New chunk for dependency on=
 start of job&#39;s execution instead on<br>
the end. This is used for GPU deadlock prevention when<br>
userspace uses mid-IB fences to wait for mid-IB work on other rings.<br>
<br>
v2: Fix typo in AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES<br>
<br>
Signed-off-by: Andrey Grodzovsky &lt;<a href=3D"mailto:andrey.grodzovsky@am=
d.com" target=3D"_blank">andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Suggested-by: Christian Koenig &lt;<a href=3D"mailto:Christian.Koenig@amd.c=
om" target=3D"_blank">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 12 +++++++++++-<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 +<br>
=C2=A02 files changed, 12 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index 1c49b82..3f21eca 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -214,6 +214,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parse=
r *p, union drm_amdgpu_cs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_CHUNK_I=
D_DEPENDENCIES:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_CHUNK_I=
D_SYNCOBJ_IN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AMDGPU_CHUNK_I=
D_SYNCOBJ_OUT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_CHUNK_I=
D_SCHEDULED_DEPENDENCIES:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
@@ -1090,6 +1091,14 @@ static int amdgpu_cs_process_fence_dep(struct amdgpu=
_cs_parser *p,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fence =3D amdgpu_ct=
x_get_fence(ctx, entity,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0deps[i].handle);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chunk-&gt;chunk=
_id =3D=3D AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct drm_sched_fence *s_fence =3D to_drm_sched_fence(fence);<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dma_fence_put(fence);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fence =3D dma_fence_get(&amp;s_fence-&gt;scheduled);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(fence)) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 r =3D PTR_ERR(fence);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_ctx_put(ctx);<br>
@@ -1177,7 +1186,8 @@ static int amdgpu_cs_dependencies(struct amdgpu_devic=
e *adev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chunk =3D &amp;p-&g=
t;chunks[i];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chunk-&gt;chunk=
_id =3D=3D AMDGPU_CHUNK_ID_DEPENDENCIES) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (chunk-&gt;chunk=
_id =3D=3D AMDGPU_CHUNK_ID_DEPENDENCIES ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chunk=
-&gt;chunk_id =3D=3D AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 r =3D amdgpu_cs_process_fence_dep(p, chunk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (r)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index faaad04..43d03a2 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -526,6 +526,7 @@ struct drm_amdgpu_gem_va {<br>
=C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_IN=C2=A0 =C2=A0 =C2=A0 0x04<br>
=C2=A0#define AMDGPU_CHUNK_ID_SYNCOBJ_OUT=C2=A0 =C2=A0 =C2=A00x05<br>
=C2=A0#define AMDGPU_CHUNK_ID_BO_HANDLES=C2=A0 =C2=A0 =C2=A0 0x06<br>
+#define AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES 0x07<br>
<br>
=C2=A0struct drm_amdgpu_cs_chunk {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
hunk_id;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>
</blockquote></div>

--000000000000ca900e0580db9c1f--

--===============0661545900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0661545900==--
