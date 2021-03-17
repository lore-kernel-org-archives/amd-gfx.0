Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC5C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5E764EEE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5E764EEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF8E6E83B;
	Wed, 17 Mar 2021 17:41:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D076E839
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616002609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JOdr3pyod5+SolyquXi4mCwLkYoXjfdw7Xom99NirA=;
 b=TqVGVI3SFfS+eQuw+x30F4wlgG3hH1c6LjOhoAyD+XBG/uaMBur0SQrE0/wBT542t+wpf2
 NIxV0tanlRsWwjNF0LP1wB+87DlTYly4eoXJB2xubxsimak0G1jdqR/LAct+re3ecJxjO9
 wSsvSBSWnjVb4Tf5OE4p2MsWCBx3XBQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-J-bGDFKYOtywVbw-RyMMvQ-1; Wed, 17 Mar 2021 13:36:46 -0400
X-MC-Unique: J-bGDFKYOtywVbw-RyMMvQ-1
Received: by mail-ej1-f70.google.com with SMTP id di5so15498274ejc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 10:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5JOdr3pyod5+SolyquXi4mCwLkYoXjfdw7Xom99NirA=;
 b=TPL/zNuUmvrLcdYjLloMZlgLh1dUE9k7mSghzSBe0QTEAXLE48SsDD60Ckq37oM52I
 DOKywPV+fJTm3oBYodI1uxnnjByWbinI/Gk+bXVm9r1iz/pL92++SglN/G8Gw5POEnEz
 76nn0/vAlWWa66H2ww3dVMCk+AXjx3WzzzL+sovfeD5tCErbbm5MzFoOM2shNrOR7AcA
 uMXZnWEMmK2q02ZfCQ8MYQ6Erxk0mg/muWTPIL9St4uhrBvXzl7PPmKWNhucFx7MHYwy
 ED+1ALeJHjNOEJSufuW0Uwp7J4Yl4TkG0lOiV9NlY0NlLXNPOdTsvns3NlGndvrk+TRi
 XkSg==
X-Gm-Message-State: AOAM531+39Hs3LbXO5HzFRVwm+nE4ohpy2P4bL+H+DPggtgIEH34F+03
 AI4L4cVeNoJt2rQX6/ubzufJ9w4hTIrsOs1zm1DXT0ZMjgKaIN8Du5TWN9VDb26mmuOwlMHecXM
 Zmdnh4SbuTvbw9oo6UIEfFsCv5Q==
X-Received: by 2002:a17:906:5949:: with SMTP id
 g9mr4867080ejr.518.1616002605631; 
 Wed, 17 Mar 2021 10:36:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqinHOoTwYUtX6nZhOFnJb6qXcHsgbaTlxUMnWG+ZMrSyNasCQ3Hhph7Glnso55BkCS1u4BA==
X-Received: by 2002:a17:906:5949:: with SMTP id
 g9mr4867059ejr.518.1616002605496; 
 Wed, 17 Mar 2021 10:36:45 -0700 (PDT)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id c15sm6266853ejm.52.2021.03.17.10.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Mar 2021 10:36:44 -0700 (PDT)
Subject: Re: [PATCH 2/2 V2] platform/x86: force LPS0 functions for AMD
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org
References: <20210317143842.786380-1-alexander.deucher@amd.com>
 <20210317143842.786380-2-alexander.deucher@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <070ee308-aed5-b2bf-5177-76ee2d9f404a@redhat.com>
Date: Wed, 17 Mar 2021 18:36:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210317143842.786380-2-alexander.deucher@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Wed, 17 Mar 2021 17:41:43 +0000
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
Cc: Prike.Liang@amd.com, Shyam-sundar.S-k@amd.com,
 Marcin Bachry <hegel666@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

On 3/17/21 3:38 PM, Alex Deucher wrote:
> ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD are supposedly not
> required for AMD platforms, and on some platforms they are
> not even listed in the function mask but at least some HP
> laptops seem to require it to properly support s0ix.
> 
> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Marcin Bachry <hegel666@gmail.com>
> ---
> 
> V2: rework the patch to just fix up the specific problematic
>     case by setting the function flags that are missing.

Thanks, the new version looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
>  drivers/acpi/x86/s2idle.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2d7ddb8a8cb6..482e6b23b21a 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -368,6 +368,13 @@ static int lps0_device_attach(struct acpi_device *adev,
>  
>  	ACPI_FREE(out_obj);
>  
> +	/*
> +	 * Some HP laptops require ACPI_LPS0_ENTRY_AMD/ACPI_LPS0_EXIT_AMD for proper
> +	 * S0ix, but don't set the function mask correctly.  Fix that up here.
> +	 */
> +	if (acpi_s2idle_vendor_amd())
> +		lps0_dsm_func_mask |= (1 << ACPI_LPS0_ENTRY_AMD) | (1 << ACPI_LPS0_EXIT_AMD);
> +
>  	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
>  			  lps0_dsm_func_mask);
>  
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
