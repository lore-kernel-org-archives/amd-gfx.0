Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10EDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 09:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1031110E752;
	Wed, 13 Dec 2023 09:05:22 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF7A10E752
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 09:05:20 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so76477605e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 01:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702458319; x=1703063119; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1FC5FKjUKiNUhFJxEaa561WQ/VWqpgUI1yeQWlRK0AI=;
 b=FBl71cpiNW+tFd9ZUn3MGPixGIITzU77jazLrAnZ5vpdjDsUQNzKRAY0pkDD2OOunP
 QpFbrboEcOO7m2TsaR/3SHyZaPugVvuh/WbUTXSqTYkexBa1oG5aqjIRU1d8f2wh/tjs
 wQDNAWyDx6aGQWs7CE8T4crGrNwDlM7XtTRId5lY096062bVbtRBhwjQph0K2PdQIYid
 gzXpcxqamiJGDxBCLunF5rfVjUz0K95Ir/Cqovis9dGxuSmirWlAbpv4bg6wmB4UjNnl
 IohMhz8SUDfKGiZhcz9///YMBqCZAVyLcB9RrsyVgRF/PXy/eFbV5cPVeMnkeB0RDq91
 X+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702458319; x=1703063119;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1FC5FKjUKiNUhFJxEaa561WQ/VWqpgUI1yeQWlRK0AI=;
 b=Y7Zj4G5kh/fs65WP6f9OHsNpyurt3jWobOpObCO7oqmgLx5CjXbR/DTggCqINupNDU
 q0LbF3Lr1JKxa0KILc8WxygI5LJrKjpu9TxHreOJJot1KlkG3VVlAtQql1AJjAS/eTsD
 y/hixtxsNn06L4dCq3kdXJ4wMDSuZxRw6yXD4BHRkePfAKxH5ZlUUa9q0IvFda8fomj6
 xF6DDqyjHwkcAwCgojstsRxV7ge+PAni8X3haNsunLmWSLQ61h1sSEfzOkKdxfL1rg13
 5HCNtrBxwErC1mhsoGN8aUBbwaaY92N4SMsdxf5el16uJD0Ug2pgBSO9kSDkWy8wBVc7
 URHA==
X-Gm-Message-State: AOJu0Yx1ebJYLf91M/bC702SXNuznRwJzSro9Bgm0nJEYcTfKVee9Wvo
 u16AOb0OvSfbaCpJbWZIew0=
X-Google-Smtp-Source: AGHT+IFQyKF/wt2NpDnm3TImCOIg3ufBbC7DtctJqPHT/b8EKUxdAm/CAp1R++hAUJndYCf1TNRIyQ==
X-Received: by 2002:a05:600c:6028:b0:40b:5e4a:4081 with SMTP id
 az40-20020a05600c602800b0040b5e4a4081mr3724170wmb.161.1702458318715; 
 Wed, 13 Dec 2023 01:05:18 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 m11-20020adfe94b000000b00333504001acsm12716359wrn.15.2023.12.13.01.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:05:18 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------kJljMRSqTViubywEuAHqMZdc"
Message-ID: <155567fc-a3aa-4376-8ac2-cb26af73935c@gmail.com>
Date: Wed, 13 Dec 2023 10:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix ftrace event amdgpu_bo_move always
 move on same heap
Content-Language: en-US
To: "Wang, Beyond" <Wang.Beyond@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <BY5PR12MB4194EF791E7B45D0A2251CD4F78DA@BY5PR12MB4194.namprd12.prod.outlook.com>
 <BY5PR12MB41949DF20026C57A77489022F78DA@BY5PR12MB4194.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BY5PR12MB41949DF20026C57A77489022F78DA@BY5PR12MB4194.namprd12.prod.outlook.com>
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
--------------kJljMRSqTViubywEuAHqMZdc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.12.23 um 08:27 schrieb Wang, Beyond:
>
> [AMD Official Use Only - General]
>
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
> Fix: move trace_amdgpu_bo_move from move_notify to amdgpu_bo_move
>
> Signed-off-by: Wang, Beyond Wang.Beyond@amd.com
>

Yeah, that makes much more sense. Reviewed-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

> ---
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +------------
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  4 +---
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  5 +++--
>
> 3 files changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> index 7416799750c1..1870775d582c 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>
> @@ -1282,19 +1282,15 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo 
> *bo, void *buffer,
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
>   *
>
>   * Marks the corresponding &amdgpu_bo buffer object as invalid, also 
> performs
>
>   * bookkeeping.
>
>   * TTM driver callback which is called when ttm moves a buffer.
>
>   */
>
> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>
> -                          bool evict,
>
> -                          struct ttm_resource *new_mem)
>
> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict)
>
> {
>
>         struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>
>         struct amdgpu_bo *abo;
>
> -       struct ttm_resource *old_mem = bo->resource;
>
>         if (!amdgpu_bo_is_amdgpu_bo(bo))
>
>                 return;
>
> @@ -1313,13 +1309,6 @@ void amdgpu_bo_move_notify(struct 
> ttm_buffer_object *bo,
>
>         /* remember the eviction */
>
>         if (evict)
>
> atomic64_inc(&adev->num_evictions);
>
> -
>
> -       /* update statistics */
>
> -       if (!new_mem)
>
> -               return;
>
> -
>
> -       /* move_notify is called before move happens */
>
> -       trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
>
> }
>
> void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>
> index 876acde6b10a..dee2c577427e 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>
> @@ -360,9 +360,7 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, 
> void *metadata,
>
> int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>
>                            size_t buffer_size, uint32_t *metadata_size,
>
>                            uint64_t *flags);
>
> -void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
>
> -                          bool evict,
>
> -                          struct ttm_resource *new_mem);
>
> +void amdgpu_bo_move_notify(struct ttm_buffer_object *bo, bool evict);
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
> index 41ed6a3e5a06..f0fffbf2bdd5 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> @@ -576,10 +576,11 @@ static int amdgpu_bo_move(struct 
> ttm_buffer_object *bo, bool evict,
>
>                         return r;
>
>         }
>
> +       trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type);
>
> out:
>
>         /* update statistics */
>
>         atomic64_add(bo->base.size, &adev->num_bytes_moved);
>
> -       amdgpu_bo_move_notify(bo, evict, new_mem);
>
> +       amdgpu_bo_move_notify(bo, evict);
>
>         return 0;
>
> }
>
> @@ -1852,7 +1853,7 @@ static int amdgpu_ttm_access_memory(struct 
> ttm_buffer_object *bo,
>
> static void
>
> amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
>
> {
>
> -       amdgpu_bo_move_notify(bo, false, NULL);
>
> +       amdgpu_bo_move_notify(bo, false);
>
> }
>
> static struct ttm_device_funcs amdgpu_bo_driver = {
>
> --
>
> 2.34.1
>

--------------kJljMRSqTViubywEuAHqMZdc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 13.12.23 um 08:27 schrieb Wang, Beyond:<br>
    <blockquote type="cite"
cite="mid:BY5PR12MB41949DF20026C57A77489022F78DA@BY5PR12MB4194.namprd12.prod.outlook.com">
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
	text-decoration:underline;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
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
          <p class="MsoNormal"><o:p> </o:p></p>
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
          <p class="MsoNormal">Fix: move trace_amdgpu_bo_move from
            move_notify to amdgpu_bo_move<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Signed-off-by: Wang, Beyond <a
              href="mailto:Wang.Beyond@amd.com" moz-do-not-send="true"
              class="moz-txt-link-freetext">
              Wang.Beyond@amd.com</a></p>
        </div>
      </div>
    </blockquote>
    <br>
    Yeah, that makes much more sense. Reviewed-by: Christian König
    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:BY5PR12MB41949DF20026C57A77489022F78DA@BY5PR12MB4194.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p></o:p></p>
          <p class="MsoNormal">---<o:p></o:p></p>
          <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            | 13 +------------<o:p></o:p></p>
          <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
            |  4 +---<o:p></o:p></p>
          <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c   
            |  5 +++--<o:p></o:p></p>
          <p class="MsoNormal">3 files changed, 5 insertions(+), 17
            deletions(-)<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
          <p class="MsoNormal">index 7416799750c1..1870775d582c 100644<o:p></o:p></p>
          <p class="MsoNormal">---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
          <p class="MsoNormal">+++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></p>
          <p class="MsoNormal">@@ -1282,19 +1282,15 @@ int
            amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
          <p class="MsoNormal">  * amdgpu_bo_move_notify - notification
            about a memory move<o:p></o:p></p>
          <p class="MsoNormal">  * @bo: pointer to a buffer object<o:p></o:p></p>
          <p class="MsoNormal">  * @evict: if this move is evicting the
            buffer from the graphics address space<o:p></o:p></p>
          <p class="MsoNormal">- * @new_mem: new information of the
            bufer object<o:p></o:p></p>
          <p class="MsoNormal">  *<o:p></o:p></p>
          <p class="MsoNormal">  * Marks the corresponding
            &amp;amdgpu_bo buffer object as invalid, also performs<o:p></o:p></p>
          <p class="MsoNormal">  * bookkeeping.<o:p></o:p></p>
          <p class="MsoNormal">  * TTM driver callback which is called
            when ttm moves a buffer.<o:p></o:p></p>
          <p class="MsoNormal">  */<o:p></o:p></p>
          <p class="MsoNormal">-void amdgpu_bo_move_notify(struct
            ttm_buffer_object *bo,<o:p></o:p></p>
          <p class="MsoNormal">-                          bool evict,<o:p></o:p></p>
          <p class="MsoNormal">-                          struct
            ttm_resource *new_mem)<o:p></o:p></p>
          <p class="MsoNormal">+void amdgpu_bo_move_notify(struct
            ttm_buffer_object *bo, bool evict)<o:p></o:p></p>
          <p class="MsoNormal">{<o:p></o:p></p>
          <p class="MsoNormal">        struct amdgpu_device *adev =
            amdgpu_ttm_adev(bo-&gt;bdev);<o:p></o:p></p>
          <p class="MsoNormal">        struct amdgpu_bo *abo;<o:p></o:p></p>
          <p class="MsoNormal">-       struct ttm_resource *old_mem =
            bo-&gt;resource;<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">        if (!amdgpu_bo_is_amdgpu_bo(bo))<o:p></o:p></p>
          <p class="MsoNormal">                return;<o:p></o:p></p>
          <p class="MsoNormal">@@ -1313,13 +1309,6 @@ void
            amdgpu_bo_move_notify(struct ttm_buffer_object *bo,<o:p></o:p></p>
          <p class="MsoNormal">        /* remember the eviction */<o:p></o:p></p>
          <p class="MsoNormal">        if (evict)<o:p></o:p></p>
          <p class="MsoNormal">               
            atomic64_inc(&amp;adev-&gt;num_evictions);<o:p></o:p></p>
          <p class="MsoNormal">-<o:p></o:p></p>
          <p class="MsoNormal">-       /* update statistics */<o:p></o:p></p>
          <p class="MsoNormal">-       if (!new_mem)<o:p></o:p></p>
          <p class="MsoNormal">-               return;<o:p></o:p></p>
          <p class="MsoNormal">-<o:p></o:p></p>
          <p class="MsoNormal">-       /* move_notify is called before
            move happens */<o:p></o:p></p>
          <p class="MsoNormal">-       trace_amdgpu_bo_move(abo,
            new_mem-&gt;mem_type, old_mem-&gt;mem_type);<o:p></o:p></p>
          <p class="MsoNormal">}<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">void amdgpu_bo_get_memory(struct
            amdgpu_bo *bo,<o:p></o:p></p>
          <p class="MsoNormal">diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
          <p class="MsoNormal">index 876acde6b10a..dee2c577427e 100644<o:p></o:p></p>
          <p class="MsoNormal">---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
          <p class="MsoNormal">+++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<o:p></o:p></p>
          <p class="MsoNormal">@@ -360,9 +360,7 @@ int
            amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void
            *metadata,<o:p></o:p></p>
          <p class="MsoNormal">int amdgpu_bo_get_metadata(struct
            amdgpu_bo *bo, void *buffer,<o:p></o:p></p>
          <p class="MsoNormal">                           size_t
            buffer_size, uint32_t *metadata_size,<o:p></o:p></p>
          <p class="MsoNormal">                           uint64_t
            *flags);<o:p></o:p></p>
          <p class="MsoNormal">-void amdgpu_bo_move_notify(struct
            ttm_buffer_object *bo,<o:p></o:p></p>
          <p class="MsoNormal">-                          bool evict,<o:p></o:p></p>
          <p class="MsoNormal">-                          struct
            ttm_resource *new_mem);<o:p></o:p></p>
          <p class="MsoNormal">+void amdgpu_bo_move_notify(struct
            ttm_buffer_object *bo, bool evict);<o:p></o:p></p>
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
          <p class="MsoNormal">index 41ed6a3e5a06..f0fffbf2bdd5 100644<o:p></o:p></p>
          <p class="MsoNormal">---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
          <p class="MsoNormal">+++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
          <p class="MsoNormal">@@ -576,10 +576,11 @@ static int
            amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,<o:p></o:p></p>
          <p class="MsoNormal">                        return r;<o:p></o:p></p>
          <p class="MsoNormal">        }<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">+       trace_amdgpu_bo_move(abo,
            new_mem-&gt;mem_type, old_mem-&gt;mem_type);<o:p></o:p></p>
          <p class="MsoNormal">out:<o:p></o:p></p>
          <p class="MsoNormal">        /* update statistics */<o:p></o:p></p>
          <p class="MsoNormal">        atomic64_add(bo-&gt;base.size,
            &amp;adev-&gt;num_bytes_moved);<o:p></o:p></p>
          <p class="MsoNormal">-       amdgpu_bo_move_notify(bo, evict,
            new_mem);<o:p></o:p></p>
          <p class="MsoNormal">+       amdgpu_bo_move_notify(bo, evict);<o:p></o:p></p>
          <p class="MsoNormal">        return 0;<o:p></o:p></p>
          <p class="MsoNormal">}<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">@@ -1852,7 +1853,7 @@ static int
            amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,<o:p></o:p></p>
          <p class="MsoNormal">static void<o:p></o:p></p>
          <p class="MsoNormal">amdgpu_bo_delete_mem_notify(struct
            ttm_buffer_object *bo)<o:p></o:p></p>
          <p class="MsoNormal">{<o:p></o:p></p>
          <p class="MsoNormal">-       amdgpu_bo_move_notify(bo, false,
            NULL);<o:p></o:p></p>
          <p class="MsoNormal">+       amdgpu_bo_move_notify(bo, false);<o:p></o:p></p>
          <p class="MsoNormal">}<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">static struct ttm_device_funcs
            amdgpu_bo_driver = {<o:p></o:p></p>
          <p class="MsoNormal">--<o:p></o:p></p>
          <p class="MsoNormal">2.34.1<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------kJljMRSqTViubywEuAHqMZdc--
