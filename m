Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D6C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 13:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C239320656
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX5EOdDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C239320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AF789D49;
	Tue,  7 Jul 2020 13:40:47 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1CF89D49
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 13:40:46 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id f18so37116687wrs.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=MpaIbRI2oc7jnjQZ7EOjbehMNM8SXGjLQwmy659ReYI=;
 b=HX5EOdDIoZggSD16x3YLxOOA0HkpPlKXHmW/8SSwExMDEHnsSO6L1Pj92Py6BZvj56
 1s6j9lVieOEjboPAGIrVuVKABGA0nPBRTkXw61CJmtazVj50l6tM7hce/azDZ5Ysnb3u
 RphRpRlrRviJ+LvtBdIVYY9p6JO6iANdMVZAJZ/TAyr7mpKxLeTa6qVT+oN7Di0zFqqb
 xrap4+S3njtij1o1YgEDnfrbvRdVrr4tnmNR5y+HbCLMomgBW7F6Lk3hz1FA1jNSNYyN
 albPNginwt8P3E+umBnzs4lshvflbiOO4k3n2y57fJ/1l+zEsIxYOMh9COejKQXe2c0N
 Qr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MpaIbRI2oc7jnjQZ7EOjbehMNM8SXGjLQwmy659ReYI=;
 b=UIPfRyfabQqO+KmmoANmBAqUM3xsd9ugKoLG/5eDHJ5yLy6GZYV8NsHlU8wCOLTfeh
 42F07V2OtZEJyeD09jRVX7DS+2l/F5qvgjKZK/C2aF8EjTQLgVytF7avci+cT1Usmiim
 qwShIaL1ODB07hYSxtvnXvygTotooMSiU61OiYkHEk0ybd5LwAj9H0LHgUlLoEuxKRTW
 CjLO82TZa4Pgsz48kGOGN3A5C1NbJoTe0iULb2Qjhi+TYOyB/rbz2gGF1Cd4FE8LGCkX
 vHjumbvwkwP0jpLtSj76xVeA6fYH97hQVncihNy2rJmi++1oeHq+c3SXlRRA1KVxGHbO
 BjMg==
X-Gm-Message-State: AOAM532e0dVBlTY/IZ6/Kt1Hlqhu3UA7mt87ERcu0gSnzn6tbSEv0n6V
 HCxUSzXi+hBl2oC0zS0KFJuhpYXw
X-Google-Smtp-Source: ABdhPJzLT8QIkWEWi4LrgmikH8qChRPQgRA1HMqMQlfLSl0urYd7X60yBUG+8FHKE3KcaClW+wU4Vg==
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr51503052wrx.332.1594129244760; 
 Tue, 07 Jul 2020 06:40:44 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u23sm1159558wru.94.2020.07.07.06.40.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jul 2020 06:40:44 -0700 (PDT)
Subject: Re: [PATCH] tests/amdgpu: set emit fence flag for multi fence
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200707131504.2994506-1-likun.gao@amd.com>
 <MN2PR12MB4078A186CF4FB3333A6837F9FC660@MN2PR12MB4078.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4d37be35-273b-898b-e5f2-9e5c77947f45@gmail.com>
Date: Tue, 7 Jul 2020 15:40:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB4078A186CF4FB3333A6837F9FC660@MN2PR12MB4078.namprd12.prod.outlook.com>
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

There is a document about how the libdrm copy of the header is to be 
updated.

Can't find it of hand, but our userspace guys should be able to point 
out where it is.

One more comment below.

Am 07.07.20 um 15:24 schrieb Zhang, Hawking:
> [AMD Public Use]
>
> It seems to me the kernel amdgpu_drm.h doesn't sync up with libdrm amdgpu_drm.h if your patch is based on drm-master.
>
> I'd expect another patch to add AMDGPU_IB_FLAG_EMIT_MEM_SYNC flag in libdrm since kernel already has the flag for a while.
>
> Other than that, the patch is Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: Gao, Likun <Likun.Gao@amd.com>
> Sent: Tuesday, July 7, 2020 21:15
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
> Subject: [PATCH] tests/amdgpu: set emit fence flag for multi fence
>
> From: Likun Gao <Likun.Gao@amd.com>
>
> Set AMDGPU_IB_FLAG_EMIT_MEM_SYNC flag for specific ASIC when test multi fence.
>
> Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> Change-Id: I41e5cb19d9ca72c1d396cc28d1b54c31773fe4d5
> ---
>   include/drm/amdgpu_drm.h   | 2 ++
>   tests/amdgpu/basic_tests.c | 6 ++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h index 4fe35d60..8a4d7da9 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -586,6 +586,8 @@ union drm_amdgpu_cs {
>    */
>   #define AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID (1 << 4)
>   
> +#define AMDGPU_IB_FLAG_EMIT_MEM_SYNC  (1 << 6)
> +
>   struct drm_amdgpu_cs_chunk_ib {
>   	__u32 _pad;
>   	/** AMDGPU_IB_FLAG_* */
> diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c index 57496c82..c0f7ec33 100644
> --- a/tests/amdgpu/basic_tests.c
> +++ b/tests/amdgpu/basic_tests.c
> @@ -45,6 +45,8 @@ static  amdgpu_device_handle device_handle;  static  uint32_t  major_version;  static  uint32_t  minor_version;  static  uint32_t  family_id;
> +static  uint32_t  chip_rev;
> +static  uint32_t  chip_id;
>   
>   static void amdgpu_query_info_test(void);  static void amdgpu_command_submission_gfx(void);
> @@ -607,6 +609,8 @@ int suite_basic_tests_init(void)
>   		return CUE_SINIT_FAILED;
>   
>   	family_id = gpu_info.family_id;
> +	chip_rev = gpu_info.chip_rev;
> +	chip_id = gpu_info.chip_external_rev;
>   
>   	return CUE_SUCCESS;
>   }
> @@ -1769,6 +1773,8 @@ static void amdgpu_command_submission_multi_fence_wait_all(bool wait_all)
>   	ib_info[0].ib_mc_address = ib_result_ce_mc_address;
>   	ib_info[0].size = i;
>   	ib_info[0].flags = AMDGPU_IB_FLAG_CE;
> +	if (chip_id == (chip_rev + 0x28))

That probably needs an explanation or at least a comment.

Christian.

> +		ib_info[0].flags |= AMDGPU_IB_FLAG_EMIT_MEM_SYNC;
>   
>   	/* IT_WAIT_ON_CE_COUNTER */
>   	ptr = ib_result_cpu;
> --
> 2.25.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
