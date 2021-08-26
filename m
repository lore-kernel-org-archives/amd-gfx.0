Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CE0C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0451B610A4
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 09:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0451B610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975236E56D;
	Thu, 26 Aug 2021 09:07:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4926E56D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 09:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJbaj8c4fCujcino9MXpplgeB61B/r4SVCowrdBS5V6mTvzsunGEyhlA4zN+D2lTAp/HojvUpWBQiCIE9Gf6HyGF++3LtRxXABWpn8Rd4mahWRSRgWhX5KamFkpEMaHY5b715rTrEVKYO4D/z1tqYtVZLm+On/qqhaNVrhznmzVNVZNb2vwLYG0cSUFFk1eVxmDhOSw68wfK6wg9apwX+Uc3N7GHKuNI2IkIt7CHLHOdzcKnVtrPnAVjUvKYYznmTSpwxX2CLDCo74r0qBW0PHPchXG7X0UOuh8k4i19+aa8jaaLSL/5iWCjLh0/J7WrGIkBVNeKCma90jvIzGclIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWo3a9TSsorqmE5x8PRt05o4Vro3rKyU8g+x7r2jFKE=;
 b=i/91ntqPolokh5v4QPqtyBDHW94j053LYiVxY5CxbP7Z3j4CNb3XuWV1uP4q89PfulSHvfDiU8gzpQt9EHUEAhEMdJJ5X1BGhi0jbMY8yFnpo50jBSVbelAv7gYXtKUF43Z5CrJqIRqJrzrrI6VPiyjqtsdKREERN3S6mWFAPLEVjK4VfIDyxGNo5UeAZ6aQJB73cHpAFh2HUn4tYSoRhE76NmD0ZSGDbZ91i67Ntp8oPjtSYISUGhW6GbsLQCZTfq3ToNrKPxBQDuzNyx/5XRd43SDpyivnWy43e+zBDwET+Fs+sCGTxYQ40RxH3Ln7sKxER4izprFq3M4OX+sYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWo3a9TSsorqmE5x8PRt05o4Vro3rKyU8g+x7r2jFKE=;
 b=HQkBco2VgbNAeS2wQZ+BrJp20Csw7nxNnyDBfTqeGaY7s0TI8z/PQ4dor2HUi0erkPQ3O0qH1sYJ6rwJimcWP8Fa0NwaRj9uuTQ+8YLw+DXwywEkijSRh+XdxP0knMFmLY06KiShE8mt9AzOa/B0pQ6qz3dD0pmHOiHY9EaCYwE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Thu, 26 Aug
 2021 09:07:24 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 09:07:24 +0000
Subject: Re: [PATCH V2 1/1] drm/amdgpu: Disable PCIE_DPM on Intel RKL Platform
To: Koba Ko <koba.ko@canonical.com>, amd-gfx@lists.freedesktop.org
References: <20210826013523.394705-1-koba.ko@canonical.com>
 <20210826013523.394705-2-koba.ko@canonical.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <b95b0e84-8fbc-bdd9-2079-a2dd84dff70f@amd.com>
Date: Thu, 26 Aug 2021 14:37:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210826013523.394705-2-koba.ko@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::28) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0088.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 09:07:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6775e10-26fb-4c8e-7efc-08d96870eb5a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5093:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5093DCC3D020567E158C070097C79@BL1PR12MB5093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAQ3/Psfa0sDmKGlx5EzFfty8RHeA9oKuseLJbBEk7MZktJ9ZXmdTJblu/VA9HaiCpO4KiWCAtGi4n88YJnFKdtAgcJ8VCOuQ2GPcICgOZWbM/2WClcV+ef2JsWbmz4B7pP/LYZC9OhGcUqFti8DefTQNG+aPfHd830w7hdlWBQMkh1x9LjNcjLC7iD1lQdxpXVKoQmrwcS90a5e+7eaaDqklLZg4bPrJSCe+FIFyKzoWnGDSGfxGGmqBJtxLSdzNs4KKgi+URIrHsebEJNgCHRHKLB2oTUpRJ+4UptYMzUVnZcIUgmcvIny1Bk7Nj1i4ogvAeuhRVrGiIwPU9bZzgS4QHFnOVDEzQ309YbnMx07cZtTEZdy5awuPCMGHwYV1KOYc+gDvSlnWKCFqTft68jbTkZofSMrTsxHGX5mRibbv7c4m454V5lR/WO9uEVcpP9AGiphi1QRnR4jaFjg/5481qncE4faLPyIGFPoB2Enx0untgHH8yTh/u3bslv3g5d2U5ec5/70AkEhwlRQ/a1r2mFmDwUDfvVak24MzomDH10qYn6qPMdCkyh2zRz0FyFU37qV7CT7zTdV7yMGDiveMFaGNqQuDNLppl2t7LJqCR43DXvzFXv7Jwz4DX6FfO323cnBAQ/xbO96Q9Rl+QGBZEwKguzc7gdu+eXx1lWpC4qMdwvHZPySlF2s2sgpPxw+aDAJ0VknkxJMEhiuDXm5f383+8ZxsIN+Tj97hdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(6666004)(31686004)(26005)(66476007)(8676002)(53546011)(66946007)(66556008)(38100700002)(186003)(6486002)(8936002)(2616005)(31696002)(5660300002)(478600001)(966005)(956004)(86362001)(83380400001)(16576012)(316002)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0R4MEZMQmRNdTZ0blQzR2J2UWdDUmpDektsYnNvRkMybWM3K096ZmFhUHRj?=
 =?utf-8?B?ZzM3YUo4UjZTbHlvK29lN3lackxXTzZnYm5vcEFVVEIveGhST25pMEhsS2dW?=
 =?utf-8?B?ejczSG9OTDkwMm1XUFBwWXpLQU8vVG8wMmxZSUt6V2pJb01kZVVLSFhvVmVh?=
 =?utf-8?B?VGFzQUowUmdFWWlxV0o3OWVFZEdOZGxncEo4elNEWDRjRGpYVit6Q1AvQkpj?=
 =?utf-8?B?WE1HRy9vSXVHL3Y2bU40cG9LL0dOK1pySVFIeitLZzVLeWZUMTJIRVVZNEJS?=
 =?utf-8?B?UWNhWUZmT1BOTU80NFpidTBhZHRxckZTWVJxWm00ZlUzc3Z3bXJ6Nnp0S0dY?=
 =?utf-8?B?VDNiODcwajd6Vk41MlAzWnhzN0NuM29KZFN4VjlpRU0zRXFuWkNtNXQyTXZQ?=
 =?utf-8?B?N2ltRXpKR0lDaDNqSElqUGIyQ01PSXBoUUp0N2hsd0tnVDZwZDA5c3B1OU9o?=
 =?utf-8?B?Wmt2bFhzOUFtT0JsbVJlVWk3L3JMRHZYcGd3dzBMclg4S0VDUGpLOWRaem9R?=
 =?utf-8?B?QWF5OGNMSm5FYVIrbTRBY2xqUGZzWHBoc1J2a0o3ZWQrV1h6SkowMXVZZE4r?=
 =?utf-8?B?U014TFN3cVpKbmxLNHdWUVdWTnp6RGk3MHpzYk9jRU9OdGZuL0RLK0xJRnZX?=
 =?utf-8?B?RVUvT0xMM2ZNZ1Uva0ZROEtZUnVTSkEwZk1heFV2UFNhcVFDRGlFY3lVUi9h?=
 =?utf-8?B?ek54MGMwSnB6WkZZc0V4SEh4czZ6KzMyMnlMa3RVQWNWeFRzNDcxZXh4aUFn?=
 =?utf-8?B?UGIrTDNRZHV3MUNpRm1uMGQ5Y1VNVEZDS2hiRFRSUWQ0SHBid1k5SXlOamRC?=
 =?utf-8?B?bGwzUS93YUtpSDNOUzhYcUlYOHpIM0RVbFJtYmNYWUQ2TTVPOFRIMzhoeEY5?=
 =?utf-8?B?RkFDd1BSN3Qyb3B5U1NkR2FYcHY4ejk1VzJoMTlFaFEvU1l3dWZLR3lGcXh3?=
 =?utf-8?B?Ym1Mdzdaa0tUaGZScXU1eXZ2dVRqTytMYk9oekpQa21ZZUNCUk4xd05IY3Nv?=
 =?utf-8?B?UVBHMHk3TTBQUTM3UVBVOEVIbHROQ3hVUEdSUG9iTWNHclZEcnBsME1aRDZo?=
 =?utf-8?B?WEEyRGV2MXdKSklJbWI0NklBOGNsbTNxTWJPMGRnVXZjdm0rR2FnblZtZ3Zh?=
 =?utf-8?B?ajhycnRqNWMzcEpBOVhFaEd6Rk0rTXBoR0NoQXFmQVl4dnNIekpnRlFsMERv?=
 =?utf-8?B?UVd0SFZkYy8wMWFsTjBoT3FRcDVlc0xuVUc1TS8yYjVZUnBmNjJnb2FrT3Mv?=
 =?utf-8?B?WTdWc3ZNSnprVGtGN0F3cmwwRFI3UUxvYW40czhmT3NzZTBkSGVnZGVwZllx?=
 =?utf-8?B?QzFEdmpFRDZXYlNXNFJ1ZkdZOUlmaEVlQjNmNEx4M2UxWlhKcGxsRmVEby9a?=
 =?utf-8?B?UUhFYWo1OTB3amtOMktwWGp4ZU9Xb2htMjBpTjQwcXk3QkJqNE5kV1NYbU1B?=
 =?utf-8?B?QUZyUzZLWmJrY3BDQ0RQcGRwcXRmdHpMcnV5R3pSalFibWcxWGQzQXU4OWUv?=
 =?utf-8?B?dnIzQS9kaU1wZ0czcDlFdTVSWVVHcTRFb25nZSt6MzFWVmljS3pSOGtPRktj?=
 =?utf-8?B?b1BKYnhIMEdEUk9DMVJtWEhRb09HQkhzRUxkc2prQ0lLV3ArOUU0MW9WS2VX?=
 =?utf-8?B?RFBmc01FLzFWSmljeGErSmVaYXBHTE04ZVJRWkdIKzM0MTNsNVBmWEQwOWhF?=
 =?utf-8?B?YmJhLzd1eFp4Q3NPMVd5WS9qSitOZmg2SjJJWVphcDRCTnVtbnhWT2gwcnVZ?=
 =?utf-8?Q?Fo3IayNmnQ3HxIaDz/Dq9Qcyxi8kJ9mjfPvM6mO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6775e10-26fb-4c8e-7efc-08d96870eb5a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 09:07:24.5769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC0A+fl0QBBhP2YEpY+dUEtanFCVP3aCNIqJdrtRmqVb7c+gIw7QPU0hK9iTiXbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
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



On 8/26/2021 7:05 AM, Koba Ko wrote:
> AMD polaris GPUs have an issue about audio noise on RKL platform,
> they provide a commit to fix but for SMU7-based GPU still
> need another module parameter,
> 
> modprobe amdgpu ppfeaturemask=0xfff7bffb
> 
> to avoid the module parameter, switch PCI_DPM by determining
> intel platform in amd drm driver is a better way.
> 
> Fixes: 1a31474cdb48 ("drm/amd/pm: workaround for audio noise issue")
> Ref: https://lists.freedesktop.org/archives/amd-gfx/2021-August/067413.html
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 0541bfc81c1b..6ce2a2046457 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -27,6 +27,7 @@
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <asm/div64.h> > +#include <asm/intel-family.h>

Maybe, include conditionally for X86_64.

>   #include <drm/amdgpu_drm.h>
>   #include "ppatomctrl.h"
>   #include "atombios.h"
> @@ -1733,6 +1734,17 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
>   	return result;
>   }
>   
> +static bool intel_core_rkl_chk(void)
> +{
> +#ifdef CONFIG_X86_64

Better to use IS_ENABLED() here.

Apart from that, looks fine to me.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	struct cpuinfo_x86 *c = &cpu_data(0);
> +
> +	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
> +#else
> +	return false;
> +#endif
> +}
> +
>   static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>   {
>   	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
> @@ -1758,7 +1770,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>   
>   	data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
>   	data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
> -	data->pcie_dpm_key_disabled = hwmgr->feature_mask & PP_PCIE_DPM_MASK ? false : true;
> +	data->pcie_dpm_key_disabled =
> +		intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
>   	/* need to set voltage control types before EVV patching */
>   	data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
>   	data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
> 
