Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 18:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533FA610C9
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 18:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 533FA610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78E46E8EF;
	Thu,  9 Sep 2021 18:07:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080EE6E8EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631210821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNibGrAA/+A0pyLLbVlfzWrJzpMQe1QdN+Fpf11X7CM=;
 b=Tsv9KIDOMkHUjzqdGxScsrBRMtVwxOJ/SVLgBLt7YQbydnmRxmMMwiu3gXpR1eAfzAQC5a
 mv8R6drEPp8DFEXREbk9dRD5xOAeo0OIxdaY/cNt7AgXpONWz2ybcse4UUBlUoblMZatUb
 ezmGCfbeyRac3QTrIfM++C1JV/ecpf0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-pl-AOH17MySpcIVE5uCYog-1; Thu, 09 Sep 2021 14:07:00 -0400
X-MC-Unique: pl-AOH17MySpcIVE5uCYog-1
Received: by mail-qt1-f199.google.com with SMTP id
 r6-20020a05622a034600b002a0ba9994f4so5608921qtw.22
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Sep 2021 11:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=hNibGrAA/+A0pyLLbVlfzWrJzpMQe1QdN+Fpf11X7CM=;
 b=OKNmE0e5ojuNhSMzO6cQoQbIBSZVip+gUQqruA5YtYUhjhRHebRWz0Ntw3PbvDkkDQ
 PZfvtwk8JoOqpm2Rc/Xf1KuSTcnaU5/mEs9NCKod+mOMTVHBB4Sm+Qg+NHlfqAvzGqAR
 NwrEAMxvsCg5kZ3bWkEWL7RHi4gyMxLvxrrCd7S1/ow4b2KuIhi/Kv8EWN0bGn6fxqPF
 VESAETxx82zHZ74IK5ze4aQIUoqxVgNI+UuxVaTcB0sI9JgQC3hU7/2XSj9jQH+QuyP1
 8XLNaAj/19+4AxuoqTDN+phfKXg9GJ4Zc1UhkB6dH1lLr2RxsHQ0QQUpz+9pLT6QqcHn
 h3QQ==
X-Gm-Message-State: AOAM532cwBgblB79hUfnTpbEEQkxB5uDzq/xeMEsTW2c0uVF9wZaOjcY
 OpOPGYIWpMt4/Lkq1/POJy5SWpwwC2mXQsUjaex7mYQDykmjL6JZi/T63I7m8Vk9l5v3CQH2Fce
 tPxK4cr0pphcX80qNQOcKlHo3dw==
X-Received: by 2002:a37:6447:: with SMTP id y68mr3936430qkb.296.1631210820447; 
 Thu, 09 Sep 2021 11:07:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm6cMUDC8k0F+IZqjFluESuHebfJt+aJ2rhmlqD3NmWjcgqchPqzefvZxWQSbCQA0AUavwWg==
X-Received: by 2002:a37:6447:: with SMTP id y68mr3936404qkb.296.1631210820226; 
 Thu, 09 Sep 2021 11:07:00 -0700 (PDT)
Received: from [192.168.8.206] (pool-108-49-102-102.bstnma.fios.verizon.net.
 [108.49.102.102])
 by smtp.gmail.com with ESMTPSA id w11sm1883999qkp.49.2021.09.09.11.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 11:06:59 -0700 (PDT)
Message-ID: <9bf1d2d42a1488e3e1253841fd7ead146e1bc42f.camel@redhat.com>
Subject: Re: [PATCH] drm/amdgpu: Drop inline from
 amdgpu_ras_eeprom_max_record_count
From: Lyude Paul <lyude@redhat.com>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org
Date: Thu, 09 Sep 2021 14:06:58 -0400
In-Reply-To: <20210909165628.1927131-1-michel@daenzer.net>
References: <20210909165628.1927131-1-michel@daenzer.net>
Organization: Red Hat
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2021-09-09 at 18:56 +0200, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> This was unusual; normally, inline functions are declared static as
> well, and defined in a header file if used by multiple compilation
> units. The latter would be more involved in this case, so just drop
> the inline declaration for now.
> 
> Fixes compile failure building for ppc64le on RHEL 8:
> 
> In file included from ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h:32,
>                  from ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:33:
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function
> ‘amdgpu_ras_recovery_init’:
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h:90:17: error: inlining
> failed in call
>  to ‘always_inline’ ‘amdgpu_ras_eeprom_max_record_count’: function body not
> available
>    90 | inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1985:34: note: called from here
>  1985 |         max_eeprom_records_len =
> amdgpu_ras_eeprom_max_record_count();
>       |                                 
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> # The function is called amdgpu_ras_eeprom_get_record_max_length on
> # stable branches
> Fixes: c84d46707ebb "drm/amdgpu: validate bad page threshold in ras(v3)"
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 194590252bb9..210f30867870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -756,7 +756,7 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>         return res;
>  }
>  
> -inline uint32_t amdgpu_ras_eeprom_max_record_count(void)
> +uint32_t amdgpu_ras_eeprom_max_record_count(void)
>  {
>         return RAS_MAX_RECORD_COUNT;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index f95fc61b3021..6bb00578bfbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -120,7 +120,7 @@ int amdgpu_ras_eeprom_read(struct
> amdgpu_ras_eeprom_control *control,
>  int amdgpu_ras_eeprom_append(struct amdgpu_ras_eeprom_control *control,
>                              struct eeprom_table_record *records, const u32
> num);
>  
> -inline uint32_t amdgpu_ras_eeprom_max_record_count(void);
> +uint32_t amdgpu_ras_eeprom_max_record_count(void);
>  
>  void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control
> *control);
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

