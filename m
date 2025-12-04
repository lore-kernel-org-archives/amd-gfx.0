Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762A2D1D892
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 09:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11BA10E8F6;
	Thu,  4 Dec 2025 09:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZKbZiRmU";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B9610E8EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 09:20:35 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-7aace33b75bso642464b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 01:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840034; x=1765444834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kNTEPYIRMsS8c1Zlreq8EXc9nU2wIRUfoJLEsW39VaI=;
 b=ZKbZiRmUbews8iAl+9nU9Qi8tfUqYPLA76iQDCeRnaPqybHSdO+qSMVMEB9lDrRYNH
 060bMaCeUZDSAe01U/HHhLGG4jVkFYTxtz3p14PIhnxuqt5e2iwWM+pYfxtd+VznPGds
 By00hSOY/gh1hi93j5efBPl/Bkx2Ki6xKWiJEIRoieovEs95dQuhU4+uFW3e+p/shzjd
 EsE5RMIt2LC4fWGt4fT+BMX2meIRUCe0pH2ahrSOTVyBXPaOPOOIBIwr0EVtV3dIHFBB
 vGV8FBT0BL24PBOnDaiuyIJ6tXE5FDKqCZmoq8e5RF7K7xKLnbyR5uD1rJ+ZxgP5sGBp
 ZqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840034; x=1765444834;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kNTEPYIRMsS8c1Zlreq8EXc9nU2wIRUfoJLEsW39VaI=;
 b=ju7hK+U1+Tqiby2y/km+yUJYa1TD9nBccdkQZPFc/H0T1AxwAJUQhtM/GlrgURWVda
 K8NEYUsFeqzkewdjT1ybn5EICIBqoCvmNbPhY/OwHi100+n9PnZECWOTU1nGy1T42eCq
 tPwQa4ygQnSCufVMewNLvt6wS6AAzgk3kP11g4vUqtkU5SvrqeY1LcIh/i7dAn2v/mcv
 FnNImL1qeJVuNP5QBLt2pmEKR9xxGcIjlK2+iq12MvXGvt5c9ehRC384oBz7lngLSQLd
 0eEqjs99PILN8SW8cKItwSFoA6vHrHr7F7ORqSyHMhj7OsGYg/1Hyw0PWp21BmEd235V
 DJTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2rCugu2P41XstHs8+3tkiespBKBnodvcc7uJn/0OPAToFnxju2Yewes8PF63RLeVtQAeknhl7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXnUw5fB9eXSprX8SOdBN1XQZhp9yK0YCTYKCGv7Ydk5CRX8Ea
 N6eZ7VX3FplBh9cOWhxUdW04vj8XICBSs7fJ+JDh834OfAYaihPwmpJT
X-Gm-Gg: ASbGnctNDvGk8ijxBNOL6UrY954Vmi0vRLEDFUd6FGpi4fIT+8ZpIu1rA7Qej0a3o4d
 WHX6BdDyNxeUdjSm1xkE0TpaA6pWMsNAH52JXdCbkjOscTsLtHgu83ICIBI0GkhgVg7VblNEfiS
 HE7QMMo3YbU9gtih/EzoYzi9H74s9VTUJ0FTbZAxYIoLdFbrZCgmXMCv8ibaIeT+rcy6QSkFN4g
 Je6y+CTAItP55T27sHEBz9QPCjRMZ6Z0ojsfH+cymL75u5hXWmtsuwZ6c7uIf32LkF0JBN0rY1s
 TZERknp6NqfBNYgq+4eyy3/r/aDLIE+EsbZlHRdF9/vgj91A0//+0CPbQwg9oqpcHg7pBAJKudt
 9Vw1fark+r3Ku4i6djyZg0sgBu2ESNGtvWxEfC4VxxQrgU7OslF9XyKlMYONw0l+iW6UAGT7CWa
 wolX3Zit7knI0Zr2r2GVE75cpd9U4=
X-Google-Smtp-Source: AGHT+IFjDbMk65ig2ZffGCIrJmX8cyW7aNZ1qat8j+nin+84kE/XPcCqUzV+wiZGrc9KWD1xde06zA==
X-Received: by 2002:a05:6a00:39a4:b0:7aa:3642:2173 with SMTP id
 d2e1a72fcca58-7e00e3bc1c2mr6926281b3a.31.1764840034509; 
 Thu, 04 Dec 2025 01:20:34 -0800 (PST)
Received: from ehlo.thunderbird.net ([117.231.198.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e29f3e52c8sm1559196b3a.10.2025.12.04.01.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 01:20:34 -0800 (PST)
Date: Thu, 04 Dec 2025 14:50:27 +0530
From: Saleemkhan <saleemkhan083@gmail.com>
To: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, saleemkhan083@gmail.com
CC: =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_drm/amdgpu=3A_do_not_use_am?=
 =?US-ASCII?Q?dgpu=5Fbo=5Fgpu=5Foffset=5Fno=5Fcheck_individually?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251130090502.83707-1-saleemkhan083@gmail.com>
References: <20251130090502.83707-1-saleemkhan083@gmail.com>
Message-ID: <37888E3D-72C1-4522-870A-F596E152BEB7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----SSTA4D5XBGW41KC2Z2GEAGL524WUOT
Content-Transfer-Encoding: 7bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

------SSTA4D5XBGW41KC2Z2GEAGL524WUOT
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping=2E?

Thanks,
Saleem

On 30 November 2025 2:34:44 pm IST, Saleemkhan Jamadar <saleemkhan083@gmai=
l=2Ecom> wrote:
>This should not be used indiviually, use amdgpu_bo_gpu_offset
>with bo reserved=2E
>
>v3 - unpin bo in queue destroy (Christian)
>v2 - pin bo so that offset returned won't change after unlock (Christian)
>
>Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail=2Ecom>
>Suggested-by: Christian K=C3=B6nig <christian=2Ekoenig@amd=2Ecom>
>---
> =2E=2E=2E/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec  |  2 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec     |  8 +++++++
> drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec    | 21 ++++++++++++++++++-
> 3 files changed, 29 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec
>index 3040437d99c2=2E=2Ebc7858567321 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec
>@@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_d=
evice *adev,
> {
> 	int db_bo_offset;
>=20
>-	db_bo_offset =3D amdgpu_bo_gpu_offset_no_check(db_bo);
>+	db_bo_offset =3D amdgpu_bo_gpu_offset(db_bo);
>=20
> 	/* doorbell index is 32 bit but doorbell's size can be 32 bit
> 	 * or 64 bit, so *db_size(in byte)/4 for alignment=2E
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq=2Ec
>index 2f97f35e0af5=2E=2E98110f543307 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec
>@@ -586,6 +586,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
> 		amdgpu_bo_unreserve(queue->db_obj=2Eobj);
> 	}
> 	amdgpu_bo_unref(&queue->db_obj=2Eobj);
>+
>+	r =3D amdgpu_bo_reserve(queue->wptr_obj=2Eobj, true);
>+	if (!r) {
>+		amdgpu_bo_unpin(queue->wptr_obj=2Eobj);
>+		amdgpu_bo_unreserve(queue->wptr_obj=2Eobj);
>+	}
>+	amdgpu_bo_unref(&queue->wptr_obj=2Eobj);
>+
> 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
> #if defined(CONFIG_DEBUG_FS)
> 	debugfs_remove_recursive(queue->debugfs_queue);
>diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec b/drivers/gpu/d=
rm/amd/amdgpu/mes_userqueue=2Ec
>index 8b0aeb89025a=2E=2E23cf517bec39 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec
>+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec
>@@ -94,8 +94,27 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *ad=
ev,
> 		return ret;
> 	}
>=20
>-	queue->wptr_obj=2Egpu_addr =3D amdgpu_bo_gpu_offset_no_check(wptr_obj->=
obj);
>+	ret =3D amdgpu_bo_reserve(wptr_obj->obj, true);
>+	if (ret) {
>+		DRM_ERROR("Failed to reserve wptr bo\n");
>+		return ret;
>+	}
>+
>+	ret =3D amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>+	if (ret) {
>+		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n"=
);
>+		goto unresv_bo;
>+	}
>+
>+	queue->wptr_obj=2Egpu_addr =3D amdgpu_bo_gpu_offset(wptr_obj->obj);
>+	amdgpu_bo_unreserve(wptr_obj->obj);
>+
> 	return 0;
>+
>+unresv_bo:
>+	amdgpu_bo_unreserve(wptr_obj->obj);
>+	return ret;
>+
> }
>=20
> static int convert_to_mes_priority(int priority)
>--=20
>2=2E43=2E0
>

--
Saleem
------SSTA4D5XBGW41KC2Z2GEAGL524WUOT
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div dir=3D"auto">Ping=2E?<br><br>Thanks,<br>Salee=
m</div><br><br><div class=3D"gmail_quote"><div dir=3D"auto">On 30 November =
2025 2:34:44 pm IST, Saleemkhan Jamadar &lt;saleemkhan083@gmail=2Ecom&gt; w=
rote:</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=
=2E8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class=3D"k9mail"><div dir=3D"auto">This should not be used indiviuall=
y, use amdgpu_bo_gpu_offset<br>with bo reserved=2E<br><br>v3 - unpin bo in =
queue destroy (Christian)<br>v2 - pin bo so that offset returned won't chan=
ge after unlock (Christian)<br><br>Signed-off-by: Saleemkhan Jamadar &lt;sa=
leemkhan083@gmail=2Ecom&gt;<br>Suggested-by: Christian K=C3=B6nig &lt;chris=
tian=2Ekoenig@amd=2Ecom&gt;<hr> =2E=2E=2E/gpu/drm/amd/amdgpu/amdgpu_doorbel=
l_mgr=2Ec  |  2 +-<br> drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec     |  8=
 +++++++<br> drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec    | 21 +++++++++=
+++++++++-<br> 3 files changed, 29 insertions(+), 2 deletions(-)<br><br>dif=
f --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec<br>index 3040437d99c2=2E=2Ebc7858567=
321 100644<br>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec<br>+=
++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec<br>@@ -129,7 +129,7=
 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,<br> {=
<br> 	int db_bo_offset;<br> <br>-	db_bo_offset =3D amdgpu_bo_gpu_offset_no_=
check(db_bo);<br>+	db_bo_offset =3D amdgpu_bo_gpu_offset(db_bo);<br> <br> 	=
/* doorbell index is 32 bit but doorbell's size can be 32 bit<br> 	 * or 64=
 bit, so *db_size(in byte)/4 for alignment=2E<br>diff --git a/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_userq=2Ec b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2E=
c<br>index 2f97f35e0af5=2E=2E98110f543307 100644<br>--- a/drivers/gpu/drm/a=
md/amdgpu/amdgpu_userq=2Ec<br>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq=
=2Ec<br>@@ -586,6 +586,14 @@ amdgpu_userq_destroy(struct drm_file *filp, in=
t queue_id)<br> 		amdgpu_bo_unreserve(queue-&gt;db_obj=2Eobj);<br> 	}<br> 	=
amdgpu_bo_unref(&amp;queue-&gt;db_obj=2Eobj);<br>+<br>+	r =3D amdgpu_bo_res=
erve(queue-&gt;wptr_obj=2Eobj, true);<br>+	if (!r) {<br>+		amdgpu_bo_unpin(=
queue-&gt;wptr_obj=2Eobj);<br>+		amdgpu_bo_unreserve(queue-&gt;wptr_obj=2Eo=
bj);<br>+	}<br>+	amdgpu_bo_unref(&amp;queue-&gt;wptr_obj=2Eobj);<br>+<br> 	=
atomic_dec(&amp;uq_mgr-&gt;userq_count[queue-&gt;queue_type]);<br> #if defi=
ned(CONFIG_DEBUG_FS)<br> 	debugfs_remove_recursive(queue-&gt;debugfs_queue)=
;<br>diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec b/drivers/gp=
u/drm/amd/amdgpu/mes_userqueue=2Ec<br>index 8b0aeb89025a=2E=2E23cf517bec39 =
100644<br>--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec<br>+++ b/drive=
rs/gpu/drm/amd/amdgpu/mes_userqueue=2Ec<br>@@ -94,8 +94,27 @@ mes_userq_cre=
ate_wptr_mapping(struct amdgpu_device *adev,<br> 		return ret;<br> 	}<br> <=
br>-	queue-&gt;wptr_obj=2Egpu_addr =3D amdgpu_bo_gpu_offset_no_check(wptr_o=
bj-&gt;obj);<br>+	ret =3D amdgpu_bo_reserve(wptr_obj-&gt;obj, true);<br>+	i=
f (ret) {<br>+		DRM_ERROR("Failed to reserve wptr bo\n");<br>+		return ret;=
<br>+	}<br>+<br>+	ret =3D amdgpu_bo_pin(wptr_obj-&gt;obj, AMDGPU_GEM_DOMAIN=
_GTT);<br>+	if (ret) {<br>+		drm_file_err(uq_mgr-&gt;file, "[Usermode queue=
s] Failed to pin wptr bo\n");<br>+		goto unresv_bo;<br>+	}<br>+<br>+	queue-=
&gt;wptr_obj=2Egpu_addr =3D amdgpu_bo_gpu_offset(wptr_obj-&gt;obj);<br>+	am=
dgpu_bo_unreserve(wptr_obj-&gt;obj);<br>+<br> 	return 0;<br>+<br>+unresv_bo=
:<br>+	amdgpu_bo_unreserve(wptr_obj-&gt;obj);<br>+	return ret;<br>+<br> }<b=
r> <br> static int convert_to_mes_priority(int priority)<br></div></pre></b=
lockquote></div><div dir=3D"auto">--<br>Saleem</div></body></html>
------SSTA4D5XBGW41KC2Z2GEAGL524WUOT--
