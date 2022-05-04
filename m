Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D656C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 16:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DDC10F7EB;
	Wed,  4 May 2022 16:48:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF59410FBA4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651682914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C80PpJdtHsQYh9YgWUU5AwvnusQPkG7yGp50RdkZ4AQ=;
 b=QrjpOCjn3qeEBvxQ0thItK9MBahgDD6bMrdTZM1lDi5MsRp7WlUR47IPhmtIr119BGp9vL
 aoyTx/sK5JvpeRsHzbJjippFxH3pNKb3yQPNTW8Luqgu30JMHa9QlBuZmri6jOXfheiCa0
 N2BaLjjhsB7QAavrwgpW01UE8jeeoKQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-2kR76PfkNU6BbqlRulM2oA-1; Wed, 04 May 2022 12:48:33 -0400
X-MC-Unique: 2kR76PfkNU6BbqlRulM2oA-1
Received: by mail-wm1-f69.google.com with SMTP id
 p13-20020a05600c358d00b00394586f6959so1456689wmq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 09:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=C80PpJdtHsQYh9YgWUU5AwvnusQPkG7yGp50RdkZ4AQ=;
 b=DOA+oKb1SdE5xIl5ZFTiC70cOvDTtD3N/tzzH1PBbYkxhO/6Y3I4XvBHuHQ4J23ZEz
 1W3bpgiwSzQsq2P6xjJjuaXOzkfl0iawJoF9tPjKn8P8Y6ZFqKUEnwMt1xCgjG/YbmOX
 fir2+LnZLVs3r8lP0DtaJutSIrCz1qQH77pqqKAhy9Ywudu50vaZBRuZNUDX8MPkftxq
 tJwe+aiyJxmDMIkWpeppPd7mF0O6cQWbIcFUAZvXCcVy3DvKyaGVEfGC44VFxJcX1/qH
 6XAtMJFey5CMK9v8jvBTkqaRpVPTB5AAMGDtQdW4GmBgVIdErtUlpVCZRdF+hQ1qxGuM
 0j7w==
X-Gm-Message-State: AOAM5338z/oYp3/ba7/169+2yXBDXWbcoMfjrw8ANt5kBPslVoK4X+g9
 8LF6wxDwsZk6w4n78IlOXKDiv/7Gw/UALwwi4KIMD2Hi1N/I+7g6w53mAbebtpsRMwdnVL6/aWu
 2w9wd//eU7WWPKgNGxA3o5AXVtQ==
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id
 21-20020a05600c231500b0039401f6f663mr246774wmo.115.1651682912620; 
 Wed, 04 May 2022 09:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZK5Pq2mU8Y6HYAf07iPFmDU9QsrrAa709Zmpug1Tah5gE9QRBp5SnHlIO72P1fOlS/u8xMw==
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id
 21-20020a05600c231500b0039401f6f663mr246763wmo.115.1651682912419; 
 Wed, 04 May 2022 09:48:32 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 n124-20020a1c2782000000b0039447beb28asm293220wmn.23.2022.05.04.09.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 May 2022 09:48:32 -0700 (PDT)
Message-ID: <6bf00fca-20c6-b682-1806-e7ff49568532@redhat.com>
Date: Wed, 4 May 2022 18:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] Revert "fbdev: fbmem: add a helper to determine if an
 aperture is used by a fw fb"
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220504134833.1672728-1-alexander.deucher@amd.com>
 <20220504134833.1672728-2-alexander.deucher@amd.com>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220504134833.1672728-2-alexander.deucher@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=javierm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 5/4/22 15:48, Alex Deucher wrote:
> This reverts commit 9a45ac2320d0a6ae01880a30d4b86025fce4061b.
> 
> This was added a helper for amdgpu to workaround a runtime pm regression
> caused by a runtime pm fix in efifb.  We now have a better workarouund

s/workarouund/workaround

> in amdgpu in
> commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are displays attached (v3)")

Again I would write it as:

commit f95af4a9236695 ("drm/amdgpu: don't runtime suspend if there are
displays attached (v3)")

> so this workaround is no longer necessary.  Since amdgpu was the only
> user of this interface, we can remove it.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

