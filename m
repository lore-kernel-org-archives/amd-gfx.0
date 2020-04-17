Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D67C352BE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 09:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08CF2137B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 09:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6NRU1g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08CF2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA246E108;
	Fri, 17 Apr 2020 09:17:25 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FDD6E108
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 09:17:25 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a25so2249758wrd.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=c/CTRgsWP/N8IvGAQ45hrE0oms2l2m010ozGZmUzztI=;
 b=l6NRU1g+q1DKebwnwy5V7lPWoVd6bgSKYp8621O9BsC3LpXbYni48auL6XAfG7ur2d
 eYeRmoWz05f/k5JictjnGTKY6TsO2E6huVSenoPN/pGjoPeHcDy/bdGPkoKufDYfsBtd
 8d0K2z34Id2rg+c1S0yBqjsyhKTJQuifj8z8SXxVGKJn9UBRAGQKJKm9MERIp3k6S/eQ
 Gea5rS7D9fjaMCsqod+NJnLdR77BTmrR8vwC0i3cj/jd0X0V5HmH5YRTZ4nnxWEJsyy6
 HFO95x15hO1q95EpJgVLr8JnOH12UxW9m/HHSWGJ0KsM397MbcX9HBCPQ2Qr2F23pBm9
 311Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=c/CTRgsWP/N8IvGAQ45hrE0oms2l2m010ozGZmUzztI=;
 b=Mb/8mCt/gkpCM2bTPzvFpd2eAPFbCF6vW00zdDz89YOBSCtlTSbk0Z6Z8kF+x95a+J
 dgR5QQxzerxRR3ZS6fpn0FWSDl9MBhfZ1qjizIUeolNcbAwbxEbitKaHVnzYvo9bzKUf
 VlBURcB+Ew5JXlxbPlxVNFvVBXQ3jQPOQAwuAmB+DDSjRm8F4+IrNktvmFFwnO+9zgM2
 rfUONa44XujRQHOV+3mhmbJF/fbxzG7dmwbzm1MRU0BkY2bkvlrfRKfN+8yb0ODb2YGN
 BxrMI+laQ3MLkh7splQ1aFW/jyorpOzY3hBy1SnvbVfmf76jaAtB0+C+VRKJQIHhYq5R
 iNoA==
X-Gm-Message-State: AGi0PuYClKUFtSgjrALRfevUd47TtvBH6p1oza0JcgN1O72fB5Yss4cq
 SKRBzBi7i7iMn9PoqvTFxUHGCt4c
X-Google-Smtp-Source: APiQypJHEbDLjvI5dviccsoLBL9a6juLwQ7HQEi+a9lAOwbsBjt1XAUYVr98H7WvUIuZg/UU8mH/rw==
X-Received: by 2002:adf:cc81:: with SMTP id p1mr3049974wrj.372.1587115043639; 
 Fri, 17 Apr 2020 02:17:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t13sm15219253wre.70.2020.04.17.02.17.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2020 02:17:23 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recovery
 on sGPU
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, John.Clements@amd.com
References: <20200416154748.32138-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <050666bc-6754-0fed-7b88-131592fed03a@gmail.com>
Date: Fri, 17 Apr 2020 11:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200416154748.32138-1-guchun.chen@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.04.20 um 17:47 schrieb Guchun Chen:
> When running ras uncorrectable error injection and trigger GPU
> reset on sGPU, below issue is observed. It's caused by the list
> uninitialized when accessing.
>
> [   80.047227] BUG: unable to handle page fault for address: ffffffffc0f4f750
> [   80.047300] #PF: supervisor write access in kernel mode
> [   80.047351] #PF: error_code(0x0003) - permissions violation
> [   80.047404] PGD 12c20e067 P4D 12c20e067 PUD 12c210067 PMD 41c4ee067 PTE 404316061
> [   80.047477] Oops: 0003 [#1] SMP PTI
> [   80.047516] CPU: 7 PID: 377 Comm: kworker/7:2 Tainted: G           OE     5.4.0-rc7-guchchen #1
> [   80.047594] Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
> [   80.047888] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b27d9d62c9df..260b4a42e0ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1448,9 +1448,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
>   
>   	/* Build list of devices to query RAS related errors */
> -	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
> +	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
>   		device_list_handle = &hive->device_list;
> -	} else {
> +	else {

The coding style here is incorrect. If one branch of an if/else uses {} 
the other(s) should use it as well.

> +		INIT_LIST_HEAD(&device_list);

That was suggested before but then reverted, but I'm not sure why.

Regards,
Christian.

>   		list_add_tail(&adev->gmc.xgmi.head, &device_list);
>   		device_list_handle = &device_list;
>   	}

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
