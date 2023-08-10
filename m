Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44564C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 15:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC40D10E559;
	Thu, 10 Aug 2023 15:11:59 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224BA10E559
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 15:11:58 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52307552b03so1309676a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691680316; x=1692285116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xespiNkSlw0wRf2502uztmWgveGe2n0FoJqmYJ5+72E=;
 b=ppzhT2bicn4nKx3yj6JjdFL+jcRB/HrDbEfKADJ5hsf5lRlfLOvkvpFO7isOs79b5i
 wZKBvZQyRR1ox5M9TMMXDCDIivGmIQSFHKXdatQGBmtckBGjbe9Dj28kCIJx8ft/Pw5c
 KN0Jd8TW6qmfKJqxfEWZtplPKs1tfMYMwH4TgasR0eCLqWhC25ZPNOJVjcNSdEvZsMlM
 G3J/mEjPnp0F+ZIRQEWqp95WIEHmenQ5rJ+b+FkNjXockRcbEcuWCfssOaOzstRBKbFh
 7i1gG5PtTIiHKCDWG4m48QxXs08gNOvqdvrQz5eLpn7ot9obKMXVqv1bboQ1lnzBSZDd
 txzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691680316; x=1692285116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xespiNkSlw0wRf2502uztmWgveGe2n0FoJqmYJ5+72E=;
 b=jcUj/hOwTZPxERJTJZcYem9mAOqH6EYgre6GgG6J3PmcFn2kRIeWHlITOzleOEUCxo
 QQwHQQUraxsKVgYvDZlTCKC0DHQoqPSseQmzbjusKwdgv9zy4ZxBMG+OBoYETKYYPxot
 wRDUY7/6mWVpRpyygcFQsfpJvocSvJYB8WvNJJfI/CEgOsVmwbgunEccxc1ABjy8pTK1
 lGKCGb4HNjPSwTFAi9vfuWd1p7v+iSWKl+H0kM5K3sZP5cJnstZo6dVtWLPFUwIZjOhb
 nalWqLcXBl7cejAxTDw/i+zv7RQM4DBYkryXXc4qxUljEBxiMEjb6RV6BcDa8/TIWkgO
 W+9g==
X-Gm-Message-State: AOJu0Ywkv7c+3fmHmJz3SEOBujsKibbRgm7H5pqlNBlIS6jyP8ox1guU
 VP4/KDrh+G4jvHhJJerPQZU=
X-Google-Smtp-Source: AGHT+IEltesLnaFSRD4PoWJ2pcWdSRrZYCRsFbxpeHFQecjjc9PGegWO2Isf/X42LPwX+FtNFocaZw==
X-Received: by 2002:a17:907:2712:b0:991:d9cb:247d with SMTP id
 w18-20020a170907271200b00991d9cb247dmr2175062ejk.57.1691680316259; 
 Thu, 10 Aug 2023 08:11:56 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15b2:9200:8df7:b3c1:e289:852a?
 ([2a00:e180:15b2:9200:8df7:b3c1:e289:852a])
 by smtp.gmail.com with ESMTPSA id
 oy17-20020a170907105100b00982cfe1fe5dsm1046655ejb.65.2023.08.10.08.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 08:11:55 -0700 (PDT)
Message-ID: <08853e2a-6485-7ab1-bb49-acba97d0020d@gmail.com>
Date: Thu, 10 Aug 2023 17:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Keep reset handlers shared
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230810114425.645209-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230810114425.645209-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.08.23 um 13:44 schrieb Lijo Lazar:
> Instead of maintaining a list per device, keep the reset handlers common
> per ASIC family. A pointer to the list of handlers is maintained in
> reset control.

Why should this be beneficial?

Christian.

>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 19 +++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  8 --------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   | 16 ++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 20 +++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 19 +++++++++++--------
>   5 files changed, 45 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index 2b97b8a96fb4..82e1c83a7ccc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -48,20 +48,19 @@ aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
>   {
>   	struct amdgpu_reset_handler *handler;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +	int i;
>   
>   	if (reset_context->method != AMD_RESET_METHOD_NONE) {
>   		dev_dbg(adev->dev, "Getting reset handler for method %d\n",
>   			reset_context->method);
> -		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -				     handler_list) {
> +		for_each_handler(i, handler, reset_ctl) {
>   			if (handler->reset_method == reset_context->method)
>   				return handler;
>   		}
>   	}
>   
>   	if (aldebaran_is_mode2_default(reset_ctl)) {
> -		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -				     handler_list) {
> +		for_each_handler(i, handler, reset_ctl)	{
>   			if (handler->reset_method == AMD_RESET_METHOD_MODE2) {
>   				reset_context->method = AMD_RESET_METHOD_MODE2;
>   				return handler;
> @@ -124,9 +123,9 @@ static void aldebaran_async_reset(struct work_struct *work)
>   	struct amdgpu_reset_control *reset_ctl =
>   		container_of(work, struct amdgpu_reset_control, reset_work);
>   	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +	int i;
>   
> -	list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -			     handler_list) {
> +	for_each_handler(i, handler, reset_ctl)	{
>   		if (handler->reset_method == reset_ctl->active_reset) {
>   			dev_dbg(adev->dev, "Resetting device\n");
>   			handler->do_reset(adev);
> @@ -395,6 +394,11 @@ static struct amdgpu_reset_handler aldebaran_mode2_handler = {
>   	.do_reset		= aldebaran_mode2_reset,
>   };
>   
> +static struct amdgpu_reset_handler
> +	*aldebaran_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
> +		&aldebaran_mode2_handler,
> +	};
> +
>   int aldebaran_reset_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_reset_control *reset_ctl;
> @@ -408,10 +412,9 @@ int aldebaran_reset_init(struct amdgpu_device *adev)
>   	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
>   	reset_ctl->get_reset_handler = aldebaran_get_reset_handler;
>   
> -	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>   	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>   	/* Only mode2 is handled through reset control now */
> -	amdgpu_reset_add_handler(reset_ctl, &aldebaran_mode2_handler);
> +	reset_ctl->reset_handlers = &aldebaran_rst_handlers;
>   
>   	adev->reset_cntl = reset_ctl;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 5fed06ffcc6b..02d874799c16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -26,14 +26,6 @@
>   #include "sienna_cichlid.h"
>   #include "smu_v13_0_10.h"
>   
> -int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
> -			     struct amdgpu_reset_handler *handler)
> -{
> -	/* TODO: Check if handler exists? */
> -	list_add_tail(&handler->handler_list, &reset_ctl->reset_handlers);
> -	return 0;
> -}
> -
>   int amdgpu_reset_init(struct amdgpu_device *adev)
>   {
>   	int ret = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index f4a501ff87d9..471d789b33a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -26,6 +26,8 @@
>   
>   #include "amdgpu.h"
>   
> +#define AMDGPU_RESET_MAX_HANDLERS 5
> +
>   enum AMDGPU_RESET_FLAGS {
>   
>   	AMDGPU_NEED_FULL_RESET = 0,
> @@ -44,7 +46,6 @@ struct amdgpu_reset_context {
>   
>   struct amdgpu_reset_handler {
>   	enum amd_reset_method reset_method;
> -	struct list_head handler_list;
>   	int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
>   			   struct amdgpu_reset_context *context);
>   	int (*prepare_hwcontext)(struct amdgpu_reset_control *reset_ctl,
> @@ -63,7 +64,8 @@ struct amdgpu_reset_control {
>   	void *handle;
>   	struct work_struct reset_work;
>   	struct mutex reset_lock;
> -	struct list_head reset_handlers;
> +	struct amdgpu_reset_handler *(
> +		*reset_handlers)[AMDGPU_RESET_MAX_HANDLERS];
>   	atomic_t in_reset;
>   	enum amd_reset_method active_reset;
>   	struct amdgpu_reset_handler *(*get_reset_handler)(
> @@ -97,8 +99,10 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
>   int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>   			       struct amdgpu_reset_context *reset_context);
>   
> -int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
> -			     struct amdgpu_reset_handler *handler);
> +int amdgpu_reset_prepare_env(struct amdgpu_device *adev,
> +			     struct amdgpu_reset_context *reset_context);
> +int amdgpu_reset_restore_env(struct amdgpu_device *adev,
> +			     struct amdgpu_reset_context *reset_context);
>   
>   struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_domain_type type,
>   							     char *wq_name);
> @@ -126,4 +130,8 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
> +#define for_each_handler(i, handler, reset_ctl)                  \
> +	for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
> +		    (handler = (*reset_ctl->reset_handlers)[i]); \
> +	     ++i)
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> index 8b8086d5c864..07ded70f4df9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
> @@ -48,18 +48,17 @@ sienna_cichlid_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
>   			    struct amdgpu_reset_context *reset_context)
>   {
>   	struct amdgpu_reset_handler *handler;
> +	int i;
>   
>   	if (reset_context->method != AMD_RESET_METHOD_NONE) {
> -		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -				     handler_list) {
> +		for_each_handler(i, handler, reset_ctl)	{
>   			if (handler->reset_method == reset_context->method)
>   				return handler;
>   		}
>   	}
>   
>   	if (sienna_cichlid_is_mode2_default(reset_ctl)) {
> -		list_for_each_entry (handler, &reset_ctl->reset_handlers,
> -				     handler_list) {
> +		for_each_handler(i, handler, reset_ctl)	{
>   			if (handler->reset_method == AMD_RESET_METHOD_MODE2)
>   				return handler;
>   		}
> @@ -120,9 +119,9 @@ static void sienna_cichlid_async_reset(struct work_struct *work)
>   	struct amdgpu_reset_control *reset_ctl =
>   		container_of(work, struct amdgpu_reset_control, reset_work);
>   	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +	int i;
>   
> -	list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -			     handler_list) {
> +	for_each_handler(i, handler, reset_ctl)	{
>   		if (handler->reset_method == reset_ctl->active_reset) {
>   			dev_dbg(adev->dev, "Resetting device\n");
>   			handler->do_reset(adev);
> @@ -281,6 +280,11 @@ static struct amdgpu_reset_handler sienna_cichlid_mode2_handler = {
>   	.do_reset		= sienna_cichlid_mode2_reset,
>   };
>   
> +static struct amdgpu_reset_handler
> +	*sienna_cichlid_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
> +		&sienna_cichlid_mode2_handler,
> +	};
> +
>   int sienna_cichlid_reset_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_reset_control *reset_ctl;
> @@ -294,11 +298,9 @@ int sienna_cichlid_reset_init(struct amdgpu_device *adev)
>   	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
>   	reset_ctl->get_reset_handler = sienna_cichlid_get_reset_handler;
>   
> -	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>   	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>   	/* Only mode2 is handled through reset control now */
> -	amdgpu_reset_add_handler(reset_ctl, &sienna_cichlid_mode2_handler);
> -
> +	reset_ctl->reset_handlers = &sienna_cichlid_rst_handlers;
>   	adev->reset_cntl = reset_ctl;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> index ae29620b1ea4..04c797d54511 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
> @@ -44,10 +44,10 @@ smu_v13_0_10_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
>   {
>   	struct amdgpu_reset_handler *handler;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +	int i;
>   
>   	if (reset_context->method != AMD_RESET_METHOD_NONE) {
> -		list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -				     handler_list) {
> +		for_each_handler(i, handler, reset_ctl) {
>   			if (handler->reset_method == reset_context->method)
>   				return handler;
>   		}
> @@ -55,8 +55,7 @@ smu_v13_0_10_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
>   
>   	if (smu_v13_0_10_is_mode2_default(reset_ctl) &&
>   		amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE2) {
> -		list_for_each_entry (handler, &reset_ctl->reset_handlers,
> -				     handler_list) {
> +		for_each_handler(i, handler, reset_ctl)	{
>   			if (handler->reset_method == AMD_RESET_METHOD_MODE2)
>   				return handler;
>   		}
> @@ -119,9 +118,9 @@ static void smu_v13_0_10_async_reset(struct work_struct *work)
>   	struct amdgpu_reset_control *reset_ctl =
>   		container_of(work, struct amdgpu_reset_control, reset_work);
>   	struct amdgpu_device *adev = (struct amdgpu_device *)reset_ctl->handle;
> +	int i;
>   
> -	list_for_each_entry(handler, &reset_ctl->reset_handlers,
> -			     handler_list) {
> +	for_each_handler(i, handler, reset_ctl)	{
>   		if (handler->reset_method == reset_ctl->active_reset) {
>   			dev_dbg(adev->dev, "Resetting device\n");
>   			handler->do_reset(adev);
> @@ -272,6 +271,11 @@ static struct amdgpu_reset_handler smu_v13_0_10_mode2_handler = {
>   	.do_reset		= smu_v13_0_10_mode2_reset,
>   };
>   
> +static struct amdgpu_reset_handler
> +	*smu_v13_0_10_rst_handlers[AMDGPU_RESET_MAX_HANDLERS] = {
> +		&smu_v13_0_10_mode2_handler,
> +	};
> +
>   int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_reset_control *reset_ctl;
> @@ -285,10 +289,9 @@ int smu_v13_0_10_reset_init(struct amdgpu_device *adev)
>   	reset_ctl->active_reset = AMD_RESET_METHOD_NONE;
>   	reset_ctl->get_reset_handler = smu_v13_0_10_get_reset_handler;
>   
> -	INIT_LIST_HEAD(&reset_ctl->reset_handlers);
>   	INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
>   	/* Only mode2 is handled through reset control now */
> -	amdgpu_reset_add_handler(reset_ctl, &smu_v13_0_10_mode2_handler);
> +	reset_ctl->reset_handlers = &smu_v13_0_10_rst_handlers;
>   
>   	adev->reset_cntl = reset_ctl;
>   

