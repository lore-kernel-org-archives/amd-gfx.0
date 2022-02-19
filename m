Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB72C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Feb 2022 04:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347C410E740;
	Sat, 19 Feb 2022 04:25:25 +0000 (UTC)
X-Greylist: delayed 542 seconds by postgrey-1.36 at gabe;
 Sat, 19 Feb 2022 04:25:23 UTC
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE57010E740
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Feb 2022 04:25:23 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aebd4.dynamic.kabel-deutschland.de
 [95.90.235.212])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 51CB261E6478B;
 Sat, 19 Feb 2022 05:16:19 +0100 (CET)
Message-ID: <90dd45cd-9cf4-d79f-dc32-76169fe10ee7@molgen.mpg.de>
Date: Sat, 19 Feb 2022 05:16:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] drm/amdkfd: make CRAT table missing message informational
 only
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220218204248.830299-1-alexander.deucher@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220218204248.830299-1-alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex,


Thank you for the patch.

Am 18.02.22 um 21:42 schrieb Alex Deucher:
> The driver has a fallback, to make the message informational

s/to/so/?

> rather than a warning.

Maybe extend it a little?

Component Resource Association Table (CRAT) are only applicable on some 
AMD APUs. The message is perfectly expected. Even on AMD APUs we can now 
fall back to treating it like a dGPU when the CRAT table is missing.

> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1906
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 24898238b024..1eaabd2cb41b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1569,7 +1569,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>   	/* Fetch the CRAT table from ACPI */
>   	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
>   	if (status == AE_NOT_FOUND) {
> -		pr_warn("CRAT table not found\n");
> +		pr_info("CRAT table not found\n");

Maybe make it even a debug message, or only print it, when a 
corresponding AMD APU is found like in `kfd_is_acpi_crat_invalid()`? 
Especially since Linux logs

         amdgpu: Virtual CRAT table created for CPU

     later on.

>   		return -ENODATA;
>   	} else if (ACPI_FAILURE(status)) {
>   		const char *err = acpi_format_exception(status);


Kind regards,

Paul
