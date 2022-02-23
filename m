Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66822C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 15:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D4C10EB94;
	Wed, 23 Feb 2022 15:20:32 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BBC610EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 15:20:31 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id gb39so53277362ejc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 07:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=PjNlT+Hyu/NIp/fRRHTKZXubCat7OEu8vKaVJHOVlB0=;
 b=iyT9505+XewJ0fWT5qeh13WKMq/94jOZVYyCRq+mf8pD6ES6oF4x3D0KEmiz3x+R2k
 DhlTN6zVSt/1k6UdS86zTeHwCYkxQm8N21LSsQ1vAwzY2nUTG/0LmK9ucVvN91X7a+z4
 z9oSBPl9n/PCwLz4Z5UVicn0/K3qxavb0mQ525cd57yG9PMBdYIHdg2XqE/kAuGQ9lyH
 HdGSizfwE1FGpqauX/ddUVvuDttxXS+q1ky/sWQf/wNMcNgJqrgkTfeM1EdJz12KAD9Y
 QekGLBT5pU55sGp+fAnttcrQE5aBe8ifmZqFMeqNmxdQUqtZ4EF7qt8SzI0/LG4PwPL5
 q4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=PjNlT+Hyu/NIp/fRRHTKZXubCat7OEu8vKaVJHOVlB0=;
 b=7OLoHOSiYWjYObaA9syiySYsc9qCRUJw+pEpl3P6e9JVJe3GTuOxPFjPF5nws3kUOG
 gY7bQtk6ViTsnznIX4i3y12bUXV4QFcvmFHNekV8tpo8ESbE8e+LvBTmsdGmI8HonBV8
 jL5vCXDolU2GnJ4CrhoEffqiaC79ef0ThmkffikaoqE07VK+Z0UkYSGTOt9M+MGdK5GA
 zfq4F4GuZ37GarimMKUQ/rAl7pC8sJJMVSwI8xd6DGVo3XdnP8WScdwkIn98/rUhH/d0
 LuTivHnqPSIGEsDKukSfC7Cb9kbyjNMsErnjHGkP3+xEfVjDwMVTrJniDGfUp0c+aXzQ
 OR7g==
X-Gm-Message-State: AOAM533Lg2krlYKLz/AFiBZ3BBQ7fKe8G3jHp/u4Prl6oTvPNPGOZ3hA
 /g/ULcDmjekqyXkForJwAjY=
X-Google-Smtp-Source: ABdhPJyPp/TRNiEKRCKr2Nw4Nb+AjeSf39gE2/c9Usrz8zjYwwiW4+17pW7qVVarMU3O6pzmomeJiQ==
X-Received: by 2002:a17:906:dc8c:b0:6d5:826c:6850 with SMTP id
 cs12-20020a170906dc8c00b006d5826c6850mr184328ejc.514.1645629629780; 
 Wed, 23 Feb 2022 07:20:29 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:6302:a8d7:78e4:4380?
 ([2a02:908:1252:fb60:6302:a8d7:78e4:4380])
 by smtp.gmail.com with ESMTPSA id dq22sm6775872ejc.100.2022.02.23.07.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Feb 2022 07:20:29 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------kR9ozTEUn7o4wvy0lBakS6KZ"
Message-ID: <1f7e0a90-a49a-9547-48a6-13bf5f70271f@gmail.com>
Date: Wed, 23 Feb 2022 16:20:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: install ctx entities with cmpxchg
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220223133829.21443-1-christian.koenig@amd.com>
 <BL1PR12MB514438D37ADF99A28A0A8F5CF73C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM5PR12MB24698390D11135CF1347D9ADF13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM5PR12MB24698390D11135CF1347D9ADF13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Xue,
 Ken" <Ken.Xue@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------kR9ozTEUn7o4wvy0lBakS6KZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

No, as I wrote in the comment that is not an error and should just be 
ignored.

Regards,
Christian.

Am 23.02.22 um 16:18 schrieb Chen, Guchun:
>
> [Public]
>
>
> Shall we add a print to aware user when failing to install a new ctx 
> entity?
>
> Regards,
>
> Guchun
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Deucher, Alexander
> *Sent:* Wednesday, February 23, 2022 11:06 PM
> *To:* Christian König <ckoenig.leichtzumerken@gmail.com>; 
> amd-gfx@lists.freedesktop.org
> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Xue, Ken 
> <Ken.Xue@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: install ctx entities with cmpxchg
>
> [Public]
>
> [Public]
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> ------------------------------------------------------------------------
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Wednesday, February 23, 2022 8:38 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Xue, Ken 
> <Ken.Xue@amd.com>
> *Subject:* [PATCH] drm/amdgpu: install ctx entities with cmpxchg
>
> Since we removed the context lock we need to make sure that not two 
> threads
> are trying to install an entity at the same time.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: e68efb27647f ("drm/amdgpu: remove ctx->lock")
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f522b52725e4..16eb1ee600ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct 
> amdgpu_ctx *ctx, u32 hw_ip,
>          if (r)
>                  goto error_free_entity;
>
> -       ctx->entities[hw_ip][ring] = entity;
> +       /* It's not an error if we fail to install the new entity */
> +       if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
> +               goto cleanup_entity;
> +
>          return 0;
>
> +cleanup_entity:
> + drm_sched_entity_fini(&entity->entity);
> +
>  error_free_entity:
>          kfree(entity);
>
> -- 
> 2.25.1
>

--------------kR9ozTEUn7o4wvy0lBakS6KZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    No, as I wrote in the comment that is not an error and should just
    be ignored.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 23.02.22 um 16:18 schrieb Chen,
      Guchun:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB24698390D11135CF1347D9ADF13C9@DM5PR12MB2469.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p
        style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;"
        align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">Shall we add a print to aware user when
            failing to install a new ctx entity?<o:p></o:p></p>
          <div>
            <p class="MsoNormal"><o:p> </o:p></p>
            <p class="MsoNormal">Regards,<o:p></o:p></p>
            <p class="MsoNormal">Guchun<o:p></o:p></p>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                <b>On Behalf Of </b>Deucher, Alexander<br>
                <b>Sent:</b> Wednesday, February 23, 2022 11:06 PM<br>
                <b>To:</b> Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <b>Cc:</b> Koenig, Christian
                <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Xue, Ken
                <a class="moz-txt-link-rfc2396E" href="mailto:Ken.Xue@amd.com">&lt;Ken.Xue@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: install ctx
                entities with cmpxchg<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p style="margin:15.0pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <p style="margin:15.0pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
            <p class="MsoNormal"><o:p> </o:p></p>
            <div>
              <div>
                <p class="MsoNormal"><span
                    style="font-size:12.0pt;color:black">Acked-by: Alex
                    Deucher &lt;<a
                      href="mailto:alexander.deucher@amd.com"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<o:p></o:p></span></p>
              </div>
              <div class="MsoNormal" style="text-align:center"
                align="center">
                <hr width="98%" size="2" align="center">
              </div>
              <div id="divRplyFwdMsg">
                <p class="MsoNormal"><b><span style="color:black">From:</span></b><span
                    style="color:black"> amd-gfx &lt;<a
                      href="mailto:amd-gfx-bounces@lists.freedesktop.org"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                    on behalf of Christian König &lt;<a
                      href="mailto:ckoenig.leichtzumerken@gmail.com"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                    <b>Sent:</b> Wednesday, February 23, 2022 8:38 AM<br>
                    <b>To:</b> <a
                      href="mailto:amd-gfx@lists.freedesktop.org"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>
                    &lt;<a href="mailto:amd-gfx@lists.freedesktop.org"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                    <b>Cc:</b> Koenig, Christian &lt;<a
                      href="mailto:Christian.Koenig@amd.com"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;;
                    Xue, Ken &lt;<a href="mailto:Ken.Xue@amd.com"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">Ken.Xue@amd.com</a>&gt;<br>
                    <b>Subject:</b> [PATCH] drm/amdgpu: install ctx
                    entities with cmpxchg</span> <o:p>
                  </o:p></p>
                <div>
                  <p class="MsoNormal"> <o:p></o:p></p>
                </div>
              </div>
              <div>
                <div>
                  <p class="MsoNormal" style="margin-bottom:12.0pt">Since
                    we removed the context lock we need to make sure
                    that not two threads<br>
                    are trying to install an entity at the same time.<br>
                    <br>
                    Signed-off-by: Christian König &lt;<a
                      href="mailto:christian.koenig@amd.com"
                      moz-do-not-send="true"
                      class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;<br>
                    Fixes: e68efb27647f ("drm/amdgpu: remove
                    ctx-&gt;lock")<br>
                    ---<br>
                     drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8
                    +++++++-<br>
                     1 file changed, 7 insertions(+), 1 deletion(-)<br>
                    <br>
                    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                    index f522b52725e4..16eb1ee600ed 100644<br>
                    --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                    +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
                    @@ -204,9 +204,15 @@ static int
                    amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32
                    hw_ip,<br>
                             if (r)<br>
                                     goto error_free_entity;<br>
                     <br>
                    -       ctx-&gt;entities[hw_ip][ring] = entity;<br>
                    +       /* It's not an error if we fail to install
                    the new entity */<br>
                    +       if
                    (cmpxchg(&amp;ctx-&gt;entities[hw_ip][ring], NULL,
                    entity))<br>
                    +               goto cleanup_entity;<br>
                    +<br>
                             return 0;<br>
                     <br>
                    +cleanup_entity:<br>
                    +      
                    drm_sched_entity_fini(&amp;entity-&gt;entity);<br>
                    +<br>
                     error_free_entity:<br>
                             kfree(entity);<br>
                     <br>
                    -- <br>
                    2.25.1<o:p></o:p></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------kR9ozTEUn7o4wvy0lBakS6KZ--
