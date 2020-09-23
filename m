Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25270C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C6E206FB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2ZluLi35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C6E206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551B86E9BB;
	Wed, 23 Sep 2020 14:41:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16D76E9BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 14:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z02Gn5l3Y0DwCgWUpJJJeOSVQ/D8BPBo3mT7DpFzXjiC9ZxFFnCitWAYgCaWT2yW6FcpKLM35HCfnMRArxNjB2fDKDkCsPvnidGAHLBAn73nLP+g8iEEMtfIOE5p0cENqY6ufR8BYKNVQ0wyeCt6+PwAb62I8+Uz8sRi656y9zZsxkHnviydnS/KsDs0q4yDTUg64vl9tVAdeo7jwJv6rK8a4LuFNjFOrES8JrI7n7dfIXCnKipeGraNJSZdNqXcz9/iBLu8TFjr6+7w5n0Z+u1G+Qs5ZwIRiv4MMKTd5D5PsQk5YUyHlqlts1kuCNEngB+TZ3XpmdoyEE7M9cMRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEYoHdq/DHkbcreY5LYvV0c22P4ADS04f4XngCk29k0=;
 b=liE0ksMinytHgihhZNHa5kVqbBG/EaOv6LF+0+2CJCzQ2c08IdwBFjR9XwuNrH+A8OKnNZvlbr/isvPXFpI5x59HNTJADdHy1lWZ1f9scGfvbWWIItZIH+vTFxPN1UoEQTotYyZF0M8R3i6uZ/9FrUAEL5xz/Sbh39hoOtzVOXHHLWAWP4EX+qMsfhROOkWAD5SVINihre1QpAF/xERR5IzIBVfYfq4jSTslme7Mf53UD1/8O9EfO7nyqUe+xFc3mFpirDjnWt/RWbw7+k4g7nHlMFgi/GFi9KdwpE1W9tmQmB7hhWlAZkU7GlslnLgaDPFIqNvnIRqAM3yuoaEWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEYoHdq/DHkbcreY5LYvV0c22P4ADS04f4XngCk29k0=;
 b=2ZluLi35GoAXfgL7Go1QI5jmYJcL8w4piQuG7yY/X64AgjYxK/P08nQNAcEYGQ+5aVsM0rm9vh3mJOcJnNzlYClnIivSAtrOloHDqEU2hP8ehPmg6fpJ0E0bPx1XeKnjphjr/dxZdox2yC1tNVV5TqQk+kpj89tanpY0alNj0us=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1164.namprd12.prod.outlook.com (2603:10b6:3:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Wed, 23 Sep
 2020 14:40:59 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3391.025; Wed, 23 Sep 2020
 14:40:59 +0000
Subject: Re: [PATCH v2] Add PP_FEATURE_MASK comments
To: Ryan Taylor <ryan.taylor@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200922155500.9239-1-ryan.taylor@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <be88bf11-c18a-f316-9255-1a9d69b76308@amd.com>
Date: Wed, 23 Sep 2020 10:40:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200922155500.9239-1-ryan.taylor@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 14:40:58 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95b93cc2-6fcd-4c3e-73e0-08d85fceafc8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1164:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1164D9568F1773539BF070BD99380@DM5PR12MB1164.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRc3shuDbdQIEjUe+guoyRARuaK3ki+jvp6mGytoEl6pCtKTc2M/WzUjxFhtCCyv3e10dvVPZjcAAVowuIfpaJYFn1bK4cIp6Ftiw6wbd1TRbuVr9g8oRnwTF1pRFCiDLW7YkYoAESQhM4pcSVzJcIeYEcm+6AVXI0jVBCNUth7vt84WaZ9y6fsFR2kubvxV8Snr547qqi+GUGSxrEco3UVCPSAf+7EmQHSAsxf4I5keCl9eBHdpLZ11I2vPnxxxHajUmpsgOJqv2ebWKH9zoPZPoQvpCu3lAepytnxMIVWvFnpTaR2b7c+NV0uLnMEGJHhAdssPK1RxQPSSay7sEubIZG6iAyavpf+d09DW6b6ZulHMwUMofEyBtDEqrNQl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(66476007)(52116002)(5660300002)(316002)(16576012)(31686004)(53546011)(478600001)(8676002)(26005)(956004)(4326008)(8936002)(16526019)(186003)(2616005)(36756003)(86362001)(66556008)(31696002)(66946007)(83380400001)(6486002)(2906002)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +YoTdqMWwqxUj0WwjMSoJKCiwtmg58lR+0UEAEai5/I0J3X4ENHvicKLdm+v4bvUwAWD8/KD2xq5mk4/IiXD7RbDH7bo3Poqz6//W3Y+VOrWg6dYQ6vhdUXQarH/cq+ywG57RVf/jZoq4FE6VVGRcSwzSEJGL2cvaD0yOYVtc4Ue7xJl+biVn4tPKHmdK+8/MbWiFHq2A7zk9XbqACw2A5aQLxnh0xHTbteKtrPjEipi1c5aK78GdJ6l5m+lHmM+J2tAivOo8VrdnM+wnwwlVbAzPkYG8wO8ZvmYQ7zG4gklDKjmoXgKuXNk7MFbIyUuqTBkD3FYO4C0mik5uyCToyBKZA2WBPVsyODsdApzNXadNbOsM7dTBj4rD4C797vlRhXxuXJ8FIh2qfCoVrvwW9pgzZ2HqGMZvx9TFnH1p0SpsJAyLwncMMwpXPx1XWJwVVadWKtLKGH1xs+2h+rVha1pkRXW8d4oV0jA7xiR0lpjmyAnWR0u7mwW+xKZMjqAmqFAhYl4iFS5MfFsjj2AhxFNHPrJ4TwZDH5X2ykMKlVFAhqwaXXRHWOjWxj+22RpAdAqQH/eI/8cvHiN33Z7AaLFHIzNxxqbA5S1y4rXfiUsD8E8LyosjDJ3nDeBcmY+BhOxkbU9Fd2n6ReMe5uDbA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b93cc2-6fcd-4c3e-73e0-08d85fceafc8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 14:40:59.1305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9um4jVsy75PSw9xESQWLaHq0ziVZc8PEMTVhPPgw40e6ytCX/o6qewdAIhhyn8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1164
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-22 11:55, Ryan Taylor wrote:
> Documents PP_FEATURE_MASK enum.
> Provides instructions on how to use ppfeaturemasks.
> 
> v2: Improved enum definitions. Adds kernel command line
>     parameters to ppfeaturemask instructions.
> 
> Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index e98c84ef206f..7c84d5beb600 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -128,6 +128,34 @@ enum amd_powergating_state {
>  #define AMD_PG_SUPPORT_ATHUB			(1 << 16)
>  #define AMD_PG_SUPPORT_JPEG			(1 << 17)
>  
> +/**
> +* enum PP_FEATURE_MASK - Used to mask power play features.
> +*
> +* @PP_SCLK_DPM_MASK: Dynamic adjustment of the system (graphics) clock.
> +* @PP_MCLK_DPM_MASK: Dynamic adjustment of the memory clock.
> +* @PP_PCIE_DPM_MASK: Dynamic adjustment of PCIE clocks and lanes.
> +* @PP_SCLK_DEEP_SLEEP_MASK: System (graphics) clock deep sleep.
> +* @PP_POWER_CONTAINMENT_MASK: Power containment.
> +* @PP_UVD_HANDSHAKE_MASK: Unified video decoder handshake.
> +* @PP_SMC_VOLTAGE_CONTROL_MASK: Dynamic voltage control.
> +* @PP_VBI_TIME_SUPPORT_MASK: Vertical blank interval support.
> +* @PP_ULV_MASK: Ultra low voltage.
> +* @PP_ENABLE_GFX_CG_THRU_SMU: SMU control of GFX engine clockgating.
> +* @PP_CLOCK_STRETCH_MASK: Clock stretching.
> +* @PP_OD_FUZZY_FAN_CONTROL_MASK: Overdrive fuzzy fan control.
> +* @PP_SOCCLK_DPM_MASK: Dynamic adjustment of the SoC clock.
> +* @PP_DCEFCLK_DPM_MASK: Dynamic adjustment of the Display Controller Engine Fabric clock.
> +* @PP_OVERDRIVE_MASK: Over- and under-clocking support.
> +* @PP_GFXOFF_MASK: Dynamic graphics engine power control.
> +* @PP_ACG_MASK: Adaptive clock generator.
> +* @PP_STUTTER_MODE: Stutter mode.
> +* @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
> +*
> +* To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
> +* the kernel's command line parameters. This is usually done through a system's
> +* boot loader (E.g. GRUB). If manually loading the driver, pass
> +* ppfeaturemask=<mask> as a modprobe parameter.
> +*/

Alignment should be:

/**
 *
 *
 ...
 */

Also, you can use Git's own patch version setting,
but I've seen here we usually put it in the commit title.
(Remember, titles do not end with a period.) Something like

	Commit title (v2)

I don't mind using either. Not sure what the direction is
on this one.

Regards,
Luben

>  enum PP_FEATURE_MASK {
>  	PP_SCLK_DPM_MASK = 0x1,
>  	PP_MCLK_DPM_MASK = 0x2,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
