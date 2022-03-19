Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3DAC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Mar 2022 07:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0948210ED91;
	Sat, 19 Mar 2022 07:00:28 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5AE810ED91
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Mar 2022 07:00:26 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5ae905.dynamic.kabel-deutschland.de
 [95.90.233.5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EB21E61EA192A;
 Sat, 19 Mar 2022 08:00:24 +0100 (CET)
Message-ID: <ab0ad09e-cd35-3803-023a-8b50cff9f96c@molgen.mpg.de>
Date: Sat, 19 Mar 2022 08:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 07/13] drm/amd/display: [FW Promotion] Release 0.0.109.0
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-8-alex.hung@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220318214800.3565679-8-alex.hung@amd.com>
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex, dear Anthony,


Thank you for the patch.


Am 18.03.22 um 22:47 schrieb Alex Hung:
> From: Anthony Koo <Anthony.Koo@amd.com>

Without a commit message a person not involved in AMD graphics 
development has no idea, what this version bump is useful for, and what 
“FW Promotion” is. Could you please add one, and also do it in the future?

> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 71214c7a60fc..ce773b56a778 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -46,10 +46,10 @@
>   
>   /* Firmware versioning. */
>   #ifdef DMUB_EXPOSE_VERSION
> -#define DMUB_FW_VERSION_GIT_HASH 0x929554ba
> +#define DMUB_FW_VERSION_GIT_HASH 0x51b95a35

Unrelated to this patch, but could you please add a comment to what git 
archive this hash refers to?

>   #define DMUB_FW_VERSION_MAJOR 0
>   #define DMUB_FW_VERSION_MINOR 0
> -#define DMUB_FW_VERSION_REVISION 108
> +#define DMUB_FW_VERSION_REVISION 109
>   #define DMUB_FW_VERSION_TEST 0
>   #define DMUB_FW_VERSION_VBIOS 0
>   #define DMUB_FW_VERSION_HOTFIX 0


Kind regards,

Paul
