Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAB8C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 08:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A8F10E18C;
	Tue, 12 Dec 2023 08:54:17 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A1C10E18C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 08:54:14 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3333a3a599fso3401805f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 00:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702371253; x=1702976053; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtBXWtjv4pVOg3ERzuYd9Uns5fVwiMVjIiCbARCzI98=;
 b=KiLd/g+5q4jQdwrrSqw8QUX1e0v2/WlxPr8H6zYuim3cbW+Z0GemCfCxdOfzqr8qdL
 NJO1r43V39YIwAkNTF12YqRQPOuab4mKnsT+zVZkmeyZGfRE21oW4pkIZXSFEbgkdTNk
 xtBy80rwnAvaQWL2z+2LqZz8KIgudQDSFiOXPMFLtn/XLO/UxGgd/0kJIVodSyJ8LGzg
 g+QMjGNbjZBxRnvtHsdcN1L1m3q/pattChyH5puh59KsGKbiBU4PH1UDjmh4vYCvLhaS
 8hEe0DDeQ9rgUCT9jOrZkwvW8GP7PLYF0BQmS2XBNbVvC8PsPRrpUd+A34/GJihP3voy
 ci3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702371253; x=1702976053;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PtBXWtjv4pVOg3ERzuYd9Uns5fVwiMVjIiCbARCzI98=;
 b=GAEgZL2cdLHNbOqMu89nAJbvIC9OrgeM2urOkjgqB1C+PgpHmV6aEIzpSfcm0vCAEN
 MBR5ySA/GsQg8pfKQmF+zSp6ccTMYxUtn7da9UAJogVuDxSAimKQt8fLohOqZ0dbuyPF
 LEc3wdrpyIOOQThYXzryYIvRb7GDfM3VpuOE3qCHgLEMCq1LzBc4Ee4hZ7njhj8G1kmz
 qvy/bniif2jm/BWP1SzaHO9mQPsnjHyag8JFqa71outRwa1aVY7K+Z9MvZKNelYa7jnR
 KhlrMdT9falPX5HIsYwnB+tO55DR56w0ZiwFpKOBr920+4bERQikzpykrwUILsgwTb7T
 S2lg==
X-Gm-Message-State: AOJu0YyUN7Uc3hMoAXZpdjbwnW3lF96B62eG/fXApeH/ybNa+7ipFvBt
 MbmJVt27c4hDdxfqB7w6KMHZgfsnEIw=
X-Google-Smtp-Source: AGHT+IFQjDzuUHEWUdu5gyxQzrn5G3A7Z0gW6HzBR3aKUTcHSGedw6DX6L7ZPD0Nkx/DTyUAPQdGfg==
X-Received: by 2002:a05:600c:444d:b0:40b:27b4:b4eb with SMTP id
 v13-20020a05600c444d00b0040b27b4b4ebmr3633287wmn.4.1702371252788; 
 Tue, 12 Dec 2023 00:54:12 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 d12-20020adfa40c000000b003333fa3d043sm10413811wra.12.2023.12.12.00.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 00:54:12 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------N7bw0bnqTD8OpstRg01kmQPf"
Message-ID: <1f9a9d98-b710-4ada-97b6-81184fdbae8b@gmail.com>
Date: Tue, 12 Dec 2023 09:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu: fix ftrace event amdgpu_bo_move always
 move on same heap
Content-Language: en-US
To: "Wang, Beyond" <Wang.Beyond@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <BY5PR12MB41949AE4BD8E4178962FFDE5F78FA@BY5PR12MB4194.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BY5PR12MB41949AE4BD8E4178962FFDE5F78FA@BY5PR12MB4194.namprd12.prod.outlook.com>
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
Cc: "Jin, Jason\(Yong\)" <JasonYong.Jin@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------N7bw0bnqTD8OpstRg01kmQPf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.12.23 um 05:29 schrieb Wang, Beyond:
>
> [AMD Official Use Only - General]
>
>
> Subject: [PATCH 1/1] drm/amdgpu: fix ftrace event amdgpu_bo_move 
> always move on same heap
>
> Issue: during evict or validate happened on amdgpu_bo, the 'from' and
>
> 'to' is always same in ftrace event of amdgpu_bo_move
>
> where calling the 'trace_amdgpu_bo_move', the comment says move_notify
>
> is called before move happens, but actually it is called after move
>
> happens, here the new_mem is same as bo->resource
>
> Fix: pass old_mem instead when calling amdgpu_bo_move_notify
>

Good catch, but the tracepoint should probably be removed altogether.

amdgpu_bo_move_notify() is more for invalidation the mappings when 
something is moved or released.

We should rather add that to amdgpu_bo_move().

Regards,
Christian.

> Signed-off-by: Wang, Beyond Wang.Beyond@amd.com
>
> ---
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  2 +-
>
> 3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> index 7416799..0288495 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> @@ -1282,7 +1282,7 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, 
> void *buffer,
>
>   * amdgpu_bo_move_notify - notification about a memory move
>
>   * @bo: pointer to a buffer object
>
>   * @evict: if this move is evicting the buffer from the graphics 
> address space
>
> - * @new_mem: new information of the bufer object
>
> + * @old_mem: old information of the buffer object
>
>   *
>
>   * Marks the corresponding &amdgpu_bo buffer object as invalid, also 
> performs
>
>   * bookkeeping.
>
> @@ -1290,11 +1290,11 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo 
> *bo, void *buffer,
>
>   */
>
> void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>
>                            bool evict,
>
> -                          struct ttm_resource *new_mem)
>
> +                          struct ttm_resource *old_mem)
>
> {
>
>         struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>
>         struct amdgpu_bo *abo;
>
> -       struct ttm_resource *old_mem = bo->resource;
>
> +       struct ttm_resource *new_mem = bo->resource;
>
>         if (!amdgpu_bo_is_amdgpu_bo(bo))
>
>                 return;
>
> @@ -1315,10 +1315,10 @@ void amdgpu_bo_move_notify(struct 
> ttm_buffer_object *bo,
>
> atomic64_inc(&adev->num_evictions);
>
>         /* update statistics */
>
> -       if (!new_mem)
>
> +       if (!old_mem || !new_mem)
>
>                 return;
>
> -       /* move_notify is called before move happens */
>
> +       /* move_notify is called after move happens in amdgpu_bo_move */
>
>         trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
>
> }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>
> index 876acde..88be4b8 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>
> @@ -362,7 +362,7 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, 
> void *buffer,
>
>                            uint64_t *flags);
>
> void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>
>                            bool evict,
>
> -                          struct ttm_resource *new_mem);
>
> +                          struct ttm_resource *old_mem);
>
> void amdgpu_bo_release_notify(struct ttm_buffer_object *bo);
>
> vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo);
>
> void amdgpu_bo_fence(struct amdgpu_bo *bo, struct dma_fence *fence,
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> index 41ed6a3..8cc85d3 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> @@ -579,7 +579,7 @@ static int amdgpu_bo_move(struct ttm_buffer_object 
> *bo, bool evict,
>
> out:
>
>         /* update statistics */
>
>         atomic64_add(bo->base.size, &adev->num_bytes_moved);
>
> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>
> +       amdgpu_bo_move_notify(bo, evict, old_mem);
>
>         return 0;
>
> }
>
> --
>
> 2.34.1
>

--------------N7bw0bnqTD8OpstRg01kmQPf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 11.12.23 um 05:29 schrieb Wang, Beyond:<br>
    <blockquote type="cite"
cite="mid:BY5PR12MB41949AE4BD8E4178962FFDE5F78FA@BY5PR12MB4194.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator"
        content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p
style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
        align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">Subject: [PATCH 1/1] drm/amdgpu: fix
            ftrace event amdgpu_bo_move always move on same heap<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Issue: during evict or validate happened
            on amdgpu_bo, the 'from' and<o:p></o:p></p>
          <p class="MsoNormal">'to' is always same in ftrace event of
            amdgpu_bo_move<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">where calling the 'trace_amdgpu_bo_move',
            the comment says move_notify<o:p></o:p></p>
          <p class="MsoNormal">is called before move happens, but
            actually it is called after move<o:p></o:p></p>
          <p class="MsoNormal">happens, here the new_mem is same as
            bo-&gt;resource<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Fix: pass old_mem instead when calling
            amdgpu_bo_move_notify</p>
        </div>
      </div>
    </blockquote>
    <br>
    Good catch, but the tracepoint should probably be removed
    altogether.<br>
    <br>
    amdgpu_bo_move_notify() is more for invalidation the mappings when
    something is moved or released.<br>
    <br>
    We should rather add that to amdgpu_bo_move().<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:BY5PR12MB41949AE4BD8E4178962FFDE5F78FA@BY5PR12MB4194.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Signed-off-by: Wang, Beyond <a
              href="mailto:Wang.Beyond@amd.com" moz-do-not-send="true"
              class="moz-txt-link-freetext">
              Wang.Beyond@amd.com</a><o:p></o:p></p>
          <p class="MsoNormal">---<o:p></o:p></p>
          <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            | 10 +++++-----<o:p></o:p></p>
          <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
            |  2 +-<o:p></o:p></p>
          <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   
            |  2 +-<o:p></o:p></p>
          <p class="MsoNormal">3 files changed, 7 insertions(+), 7
            deletions(-)<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
          <p class="MsoNormal">index 7416799..0288495 100644<o:p></o:p></p>
          <p class="MsoNormal">---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
          <p class="MsoNormal">+++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
          <p class="MsoNormal">@@ -1282,7 +1282,7 @@ int
            amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
          <p class="MsoNormal">  * amdgpu_bo_move_notify - notification
            about a memory move<o:p></o:p></p>
          <p class="MsoNormal">  * @bo: pointer to a buffer object<o:p></o:p></p>
          <p class="MsoNormal">  * @evict: if this move is evicting the
            buffer from the graphics address space<o:p></o:p></p>
          <p class="MsoNormal">- * @new_mem: new information of the
            bufer object<o:p></o:p></p>
          <p class="MsoNormal">+ * @old_mem: old information of the
            buffer object<o:p></o:p></p>
          <p class="MsoNormal">  *<o:p></o:p></p>
          <p class="MsoNormal">  * Marks the corresponding
            &amp;amdgpu_bo buffer object as invalid, also performs<o:p></o:p></p>
          <p class="MsoNormal">  * bookkeeping.<o:p></o:p></p>
          <p class="MsoNormal">@@ -1290,11 +1290,11 @@ int
            amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
          <p class="MsoNormal">  */<o:p></o:p></p>
          <p class="MsoNormal">void amdgpu_bo_move_notify(struct
            ttm_buffer_object *bo,<o:p></o:p></p>
          <p class="MsoNormal">                           bool evict,<o:p></o:p></p>
          <p class="MsoNormal">-                          struct
            ttm_resource *new_mem)<o:p></o:p></p>
          <p class="MsoNormal">+                          struct
            ttm_resource *old_mem)<o:p></o:p></p>
          <p class="MsoNormal">{<o:p></o:p></p>
          <p class="MsoNormal">        struct amdgpu_device *adev =
            amdgpu_ttm_adev(bo-&gt;bdev);<o:p></o:p></p>
          <p class="MsoNormal">        struct amdgpu_bo *abo;<o:p></o:p></p>
          <p class="MsoNormal">-       struct ttm_resource *old_mem =
            bo-&gt;resource;<o:p></o:p></p>
          <p class="MsoNormal">+       struct ttm_resource *new_mem =
            bo-&gt;resource;<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">        if (!amdgpu_bo_is_amdgpu_bo(bo))<o:p></o:p></p>
          <p class="MsoNormal">                return;<o:p></o:p></p>
          <p class="MsoNormal">@@ -1315,10 +1315,10 @@ void
            amdgpu_bo_move_notify(struct ttm_buffer_object *bo,<o:p></o:p></p>
          <p class="MsoNormal">               
            atomic64_inc(&amp;adev-&gt;num_evictions);<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">        /* update statistics */<o:p></o:p></p>
          <p class="MsoNormal">-       if (!new_mem)<o:p></o:p></p>
          <p class="MsoNormal">+       if (!old_mem || !new_mem)<o:p></o:p></p>
          <p class="MsoNormal">                return;<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">-       /* move_notify is called before
            move happens */<o:p></o:p></p>
          <p class="MsoNormal">+       /* move_notify is called after
            move happens in amdgpu_bo_move */<o:p></o:p></p>
          <p class="MsoNormal">        trace_amdgpu_bo_move(abo,
            new_mem-&gt;mem_type, old_mem-&gt;mem_type);<o:p></o:p></p>
          <p class="MsoNormal">}<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
          <p class="MsoNormal">index 876acde..88be4b8 100644<o:p></o:p></p>
          <p class="MsoNormal">---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
          <p class="MsoNormal">+++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
          <p class="MsoNormal">@@ -362,7 +362,7 @@ int
            amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
          <p class="MsoNormal">                           uint64_t
            *flags);<o:p></o:p></p>
          <p class="MsoNormal">void amdgpu_bo_move_notify(struct
            ttm_buffer_object *bo,<o:p></o:p></p>
          <p class="MsoNormal">                           bool evict,<o:p></o:p></p>
          <p class="MsoNormal">-                          struct
            ttm_resource *new_mem);<o:p></o:p></p>
          <p class="MsoNormal">+                          struct
            ttm_resource *old_mem);<o:p></o:p></p>
          <p class="MsoNormal">void amdgpu_bo_release_notify(struct
            ttm_buffer_object *bo);<o:p></o:p></p>
          <p class="MsoNormal">vm_fault_t
            amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object
            *bo);<o:p></o:p></p>
          <p class="MsoNormal">void amdgpu_bo_fence(struct amdgpu_bo
            *bo, struct dma_fence *fence,<o:p></o:p></p>
          <p class="MsoNormal">diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
          <p class="MsoNormal">index 41ed6a3..8cc85d3 100644<o:p></o:p></p>
          <p class="MsoNormal">---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
          <p class="MsoNormal">+++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
          <p class="MsoNormal">@@ -579,7 +579,7 @@ static int
            amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,<o:p></o:p></p>
          <p class="MsoNormal">out:<o:p></o:p></p>
          <p class="MsoNormal">        /* update statistics */<o:p></o:p></p>
          <p class="MsoNormal">        atomic64_add(bo-&gt;base.size,
            &amp;adev-&gt;num_bytes_moved);<o:p></o:p></p>
          <p class="MsoNormal">-       amdgpu_bo_move_notify(bo, evict,
            new_mem);<o:p></o:p></p>
          <p class="MsoNormal">+       amdgpu_bo_move_notify(bo, evict,
            old_mem);<o:p></o:p></p>
          <p class="MsoNormal">        return 0;<o:p></o:p></p>
          <p class="MsoNormal">}<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">--<o:p></o:p></p>
          <p class="MsoNormal">2.34.1<o:p></o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------N7bw0bnqTD8OpstRg01kmQPf--
