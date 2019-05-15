From: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re:[PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU during CS
Date: Wed, 15 May 2019 14:21:09 +0000
Message-ID: <-z5t5bc-r0qydowvgp2jfwhsru6hathty0w6tmefo8lvfrqj4298bq6-53859k-e09jr8-7uhi4m-ne8q5-er44kbg5jt6sh5lbep35sue0-8jf289-u3ez2g-1jbf4vwi8mtu-b26by3izukbi-qq632i.1557930062576@email.android.com>
References: <20190514123127.1650-1-christian.koenig@amd.com>
 <20190514123127.1650-11-christian.koenig@amd.com>
 <-vf7xt3-qgf5mz-veq8ih-okgxtz-9ehg3tx8dyemoidihe-fwj066fntvvx-x3y4nh-bn07hl-82anfo4oofx-4di7gg-3nkfhtbcgh58-yj9ws0-pthytc-oq9qcxd40s4g-249dv8-x6wbfujry6xi-mu2nvl.1557839540398@email.android.com>
 <f9017911-b08a-1f98-3fc9-98121bbde78a@gmail.com>
 <-wsx1tz-kxfbz1yns7x33sra134gl11xhlux4lx3izissqr2httt4mb1vleyxgj8i7k6-q6ze8ub3ff8c4o0fxmx7niu76yg4-ybakue-3v14jw-ed5ol8ybh6o9-1ze886-hbstfi448pvq3pwhkj.1557844282594@email.android.com>,
 <451e8757-b509-c0f7-eced-6ccedc45117b@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1894761688=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <451e8757-b509-c0f7-eced-6ccedc45117b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1894761688==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_z5t5bcr0qydowvgp2jfwhsru6hathty0w6tmefo8lvfrqj4298bq653_"

--_000_z5t5bcr0qydowvgp2jfwhsru6hathty0w6tmefo8lvfrqj4298bq653_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Isn't this patch trying to stop removing for all BOs  from bo list?

-David

-------- Original Message --------
Subject: Re: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU durin=
g CS
From: Christian K=F6nig
To: "Zhou, David(ChunMing)" ,"Koenig, Christian" ,"Olsak, Marek" ,"Liang, P=
rike" ,dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
CC:

[CAUTION: External Email]
That is a good point, but actually not a problem in practice.

See the change to ttm_eu_fence_buffer_objects:
-               ttm_bo_add_to_lru(bo);
+               if (list_empty(&bo->lru))
+                       ttm_bo_add_to_lru(bo);
+               else
+                       ttm_bo_move_to_lru_tail(bo, NULL);

We still move the BOs to the end of the LRU in the same order we have befor=
e, we just don't remove them when they are reserved.

Regards,
Christian.

Am 14.05.19 um 16:31 schrieb Zhou, David(ChunMing):
how to refresh LRU to keep the order align with bo list passed from user sp=
ace?

you can verify it by some games, performance could be different much betwee=
n multiple runnings.

-David

-------- Original Message --------
Subject: Re: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU durin=
g CS
From: Christian K=F6nig
To: "Zhou, David(ChunMing)" ,"Olsak, Marek" ,"Liang, Prike" ,dri-devel@list=
s.freedesktop.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:dri-devel-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
CC:

[CAUTION: External Email]
Hui? What do you mean with that?

Christian.

Am 14.05.19 um 15:12 schrieb Zhou, David(ChunMing):
my only concern is how to fresh LRU when bo is from bo list.

-David

-------- Original Message --------
Subject: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU during CS
From: Christian K=F6nig
To: "Olsak, Marek" ,"Zhou, David(ChunMing)" ,"Liang, Prike" ,dri-devel@list=
s.freedesktop.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:dri-devel-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
CC:

[CAUTION: External Email]

This avoids OOM situations when we have lots of threads
submitting at the same time.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christia=
n.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index fff558cf385b..f9240a94217b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -648,7 +648,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser=
 *p,
        }

        r =3D ttm_eu_reserve_buffers(&p->ticket, &p->validated, true,
-                                  &duplicates, true);
+                                  &duplicates, false);
        if (unlikely(r !=3D 0)) {
                if (r !=3D -ERESTARTSYS)
                        DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
--
2.17.1





_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_z5t5bcr0qydowvgp2jfwhsru6hathty0w6tmefo8lvfrqj4298bq653_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta content=3D"text/html; charset=3DWindows-1252">
</head>
<body bgcolor=3D"#FFFFFF">
Isn't this patch trying to stop removing for all BOs&nbsp; from bo list?<br=
>
<br>
-David<br>
<br>
-------- Original Message --------<br>
Subject: Re: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU durin=
g CS<br>
From: Christian K=F6nig <br>
To: &quot;Zhou, David(ChunMing)&quot; ,&quot;Koenig, Christian&quot; ,&quot=
;Olsak, Marek&quot; ,&quot;Liang, Prike&quot; ,dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
CC: <br>
<br>
<div>[CAUTION: External Email]
<div>
<div class=3D"moz-cite-prefix">That is a good point, but actually not a pro=
blem in practice.<br>
<br>
See the change to ttm_eu_fence_buffer_objects:<br>
<blockquote type=3D"cite">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_add_to_lru(bo);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (list_empty(&amp;bo-&gt;lru))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_add_t=
o_lru(bo);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_move_=
to_lru_tail(bo, NULL);<br>
</blockquote>
<br>
We still move the BOs to the end of the LRU in the same order we have befor=
e, we just don't remove them when they are reserved.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 14.05.19 um 16:31 schrieb Zhou, David(ChunMing):<br>
</div>
<blockquote type=3D"cite">
<meta content=3D"text/html; charset=3DWindows-1252">
how to refresh LRU to keep the order align with bo list passed from user sp=
ace?<br>
<br>
you can verify it by some games, performance could be different much betwee=
n multiple runnings.<br>
<br>
-David<br>
<br>
-------- Original Message --------<br>
Subject: Re: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU durin=
g CS<br>
From: Christian K=F6nig <br>
To: &quot;Zhou, David(ChunMing)&quot; ,&quot;Olsak, Marek&quot; ,&quot;Lian=
g, Prike&quot; ,<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:dri-de=
vel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32k@public.gmane.org=
eedesktop.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
CC: <br>
<br>
<div>[CAUTION: External Email]
<div>
<div class=3D"moz-cite-prefix">Hui? What do you mean with that?<br>
<br>
Christian.<br>
<br>
Am 14.05.19 um 15:12 schrieb Zhou, David(ChunMing):<br>
</div>
<blockquote type=3D"cite">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<style>
<!--
.EmailQuote
	{margin-left:1pt;
	padding-left:4pt;
	border-left:#800000 2px solid}
-->
</style>
<div>my only concern is how to fresh LRU when bo is from bo list.<br>
<br>
-David<br>
<br>
-------- Original Message --------<br>
Subject: [PATCH 11/11] drm/amdgpu: stop removing BOs from the LRU during CS=
<br>
From: Christian K=F6nig <br>
To: &quot;Olsak, Marek&quot; ,&quot;Zhou, David(ChunMing)&quot; ,&quot;Lian=
g, Prike&quot; ,<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:dri-de=
vel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">dri-devel-PD4FTy7X32k@public.gmane.org=
eedesktop.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
CC: <br>
<br>
</div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"PlainText">[CAUTION: External Email]<br>
<br>
This avoids OOM situations when we have lots of threads<br>
submitting at the same time.<br>
<br>
Signed-off-by: Christian K=F6nig <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c<br>
index fff558cf385b..f9240a94217b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
@@ -648,7 &#43;648,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_pa=
rser *p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_eu_reserve_buffers(&am=
p;p-&gt;ticket, &amp;p-&gt;validated, true,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;duplicates, true);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;duplicates, fals=
e);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (r !=3D -ERESTARTSYS)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&=
quot;ttm_eu_reserve_buffers failed.\n&quot;);<br>
--<br>
2.17.1<br>
<br>
</div>
</span></font></blockquote>
<br>
</div>
</div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
<pre class=3D"moz-quote-pre">______________________________________________=
_
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a></pre>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_z5t5bcr0qydowvgp2jfwhsru6hathty0w6tmefo8lvfrqj4298bq653_--

--===============1894761688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1894761688==--
