Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE16C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 13:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B917D22247
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 13:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIyx6+re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B917D22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEFFE6EC9E;
	Tue, 20 Oct 2020 13:42:56 +0000 (UTC)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3342A6ECA1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 13:42:55 +0000 (UTC)
Received: by mail-io1-xd44.google.com with SMTP id n6so3299026ioc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aY16vNArVdV1rOij/qsvZ8hpQrW5chnTlObOEDw7HdM=;
 b=cIyx6+reXEhqJYkEeQf8ib+Bips9M2UDag919RoHJWCsNMFIUKYkaKkyEAGkA6HY2I
 TcFMW/aNkicKitq2LyB0S7gXNXMfZa/7Dgd7qNrk268O7CdKmyARmV6R0BEu7karwmAS
 rULdhA/oAlElpFvk+3gouGnwJmg0lE3NTiaqFWqn2bLb+C77tjuV/kWh2YB+jL6yY6F6
 DkXcGqMv+XoPQyjaq2YLrpOKfbCj5wR3JdSHYa38O2zw+JiTgTKKzHARzBFMa07XvoAL
 p7qQhnbj9moIcE8J+R9kdGdmd0+3K2x8H3REDJIn0UpvrqIBFrjgb63PmVs6UncQbXHC
 pERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=aY16vNArVdV1rOij/qsvZ8hpQrW5chnTlObOEDw7HdM=;
 b=FIPdAaI+ltLEJtom4VqkNYPoCXijfS5Wn54DBIHO4ZZrGZN6Gw8SuaTvkc/cds86Jo
 8Vc0+6PHv+NbYAs0Gpygpl6T50SKd8qMxKFq4Wn8fRB4lnOdi7zVoWbpWjmP8b69mJY5
 i4saAHNis6f7zbb48l6iKlzpWqCVYG5qY2SGRaUB26go/m0rmw6fFUcj594587c8d/PQ
 PknojMf47PjPXs+M2bvlM0oE0ef6iBjjDbShKRj45DOKTxaaiPVA6JeJXO9RlRuAHTu2
 OOkhY28qlwdHmyA+zMMuBbdbeQpuqJnXiTirtJ1S2YsHEIMvfZDfUFPqKa4xtZ1k3tGp
 pwNQ==
X-Gm-Message-State: AOAM530nO44UFn85a6TqoH+hJ+CkjPRHDj2z9mnFHyCCrVgo2Wie8hEX
 eAMZL9s25/cDxLBlLuuwbmo=
X-Google-Smtp-Source: ABdhPJwGSROvjfLSV5znbYSjzku8ZP1//SZrQE/gu7/Y9wivC8tczxoaX5ZDBC4hFAA9NjT57vithQ==
X-Received: by 2002:a02:9667:: with SMTP id c94mr2095914jai.91.1603201374450; 
 Tue, 20 Oct 2020 06:42:54 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:aa5e:45ff:fed0:7395?
 ([2602:4b:a6ae:c000:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id f1sm1838593ils.23.2020.10.20.06.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 06:42:53 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/display: Fix the display corruption issue on
 Navi10
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201020064846.3155-1-yifan1.zhang@amd.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 H0qwCIawk+A+IV3Jri8YZx+EJ1F10DxXcsQJdA==
Message-ID: <d8c317e0-7d98-e68f-df38-1343961a877b@gmail.com>
Date: Tue, 20 Oct 2020 07:42:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020064846.3155-1-yifan1.zhang@amd.com>
Content-Language: en-US
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
Cc: sunpeng.li@amd.com, Alex Deucher <alexdeucher@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the quick resolution! Might want to add a Fixes header just
for reference when people are reading commit messages?

I can confirm that this fixed the issue introduced by that previous
patch, though!

Patch is Tested-by: Matt Coffin <mcoffin13@gmail.com>

On 10/20/20 12:48 AM, Yifan Zhang wrote:
> [Why]
> Screen corruption on Navi10 card
> 
> [How]
> Set system context in DCN only on Renoir and Cezanne
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3d534a4da20b..6855aad7f312 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1061,10 +1061,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  
>  	dc_hardware_init(adev->dm.dc);
>  
> -	mmhub_read_system_context(adev, &pa_config);
> +	if (adev->asic_type == CHIP_RENOIR) {
> +		mmhub_read_system_context(adev, &pa_config);
>  
> -	// Call the DC init_memory func
> -	dc_setup_system_context(adev->dm.dc, &pa_config);
> +		// Call the DC init_memory func
> +		dc_setup_system_context(adev->dm.dc, &pa_config);
> +	}
>  
>  	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
>  	if (!adev->dm.freesync_module) {
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
