Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17029C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 06:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFE110F79C;
	Fri,  8 Apr 2022 06:29:10 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0DA710F7B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 06:29:08 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae932.dynamic.kabel-deutschland.de
 [95.90.233.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A3C0E61E6478B;
 Fri,  8 Apr 2022 08:29:06 +0200 (CEST)
Message-ID: <ac14165d-ee61-7fa6-56ad-6c336b710330@molgen.mpg.de>
Date: Fri, 8 Apr 2022 08:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/1] amdgpu/pm: Clarify Documentation of error handling in
 send_smc_mesg
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>
References: <20220408022639.7909-1-darren.powell@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408022639.7909-1-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: andrey.grodzovsky@amd.com, luben.tuikov@amd.com, evan.quan@amd.com,
 amd-gfx@lists.freedesktop.org, wenhui.sheng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Darren,


Thank you for your patch.

Am 08.04.22 um 04:26 schrieb Darren Powell:
>   Contrary to the smu_cmn_send_smc_msg_with_param documentation, two
>   cases exist where messages are silently dropped with no error returned
>   to the caller. These cases occur in unusual situations where either:
>    1. the caller is a virtual GPU, or
>    2. a PCI recovery is underway and the HW is not yet in sync with the SW
> 
>   For more details see
>    commit 4ea5081c82c4 ("drm/amd/powerplay: enable SMC message filter")
>    commit bf36b52e781d ("drm/amdgpu: Avoid accessing HW when suspending SW state")

Please remove the indentation. If you re-rolled the patch, you could 
also spell *documentation* lowercase in the commit message summary.

> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b8d0c70ff668..b1bd1990c88b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -356,12 +356,15 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
>    * completion of the command, and return back a value from the SMU in
>    * @read_arg pointer.
>    *
> - * Return 0 on success, -errno on error, if we weren't able to send
> + * Return 0 on success, or if the message is dropped.
> + * On error, -errno is returned if we weren't able to send
>    * the message or if the message completed with some kind of
>    * error. See __smu_cmn_reg2errno() for details of the -errno.
>    *
>    * If we weren't able to send the message to the SMU, we also print
> - * the error to the standard log.
> + * the error to the standard log. Dropped messages can be caused
> + * due to PCI slot recovery or attempting to send from a virtual GPU,
> + * and do not print an error.
>    *
>    * Command completion status is printed only if the -errno is
>    * -EREMOTEIO, indicating that the SMU returned back an
> 
> base-commit: 4585c45a6a66cb17cc97f4370457503746e540b7

The diff looks good – despite Mozilla Thunderbird quoting it strangely.


Kind regards,

Paul
