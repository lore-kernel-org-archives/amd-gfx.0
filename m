Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC7560E90
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 08:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CC7560E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1C4F6E448;
	Mon, 11 Oct 2021 08:53:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 600EB6E448
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 08:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy3SqZo8vOVUkVVlyjeJ2yYbX+js1QyCcyHVPXPqK2tBWZJ2bCugYzHznpQ7I4tXYWA26OPSlMH+SThj9z1f/pO2bAGtICphM4bfvIJlgtEHNTcabJyuLtobcteqm/5ZEB3sBtd3f4d+Yax50voDThH5xQjm6REs4LXr1X6Mf+azw9M+F+2L54WbKkUT3CwbIKbN/xxxKEWn5wMxvBWMko9p8Ce/8ZKIhhIXwXKx+HiOHOy/MPRfEx9I+LExrkhsGnh8RmCfC023v0LBtXkKT6Dt68siuNdAI2tY9fyeZUm3zyVc8Twaf1JhUTnyoOPNS/MLf0UyrlscIXDVeZpZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2MMf4JoRXk0/dkV9MPJIwDg012Awg3wUhu0a7BCxaM=;
 b=YsEaVOqhsSBQGFb/7lqWPOK4Czk4THaBH/e18XTBimG2r3ub133l/Ee26cSBDh/NxAn0hTHyGcPhTTG0lCGnW1sOZk1RqZQM/aPVI0rsfGcqgZyoElGdyEnrzrO7vaaWN1z4HVdQnDWtylM6/dG4UQOFAJY+1wQ0ZPeCY7nN1BloB2PWrBy4et+WHufDvp4NtTRwilrHTZe/OGHs4ZCv5qcGQ6/S6HLJqOOYzavnewVpjIyN52vecUvMGKY0mDkFqA/wl5uyvMpcLZDra8BAhxyZ6lzwla1IS9PboYMMpYddORK13oXFUknyYgm5nG2PIini2DxvtsbgwPXx2109Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2MMf4JoRXk0/dkV9MPJIwDg012Awg3wUhu0a7BCxaM=;
 b=GNgbn/3dAe2cPLLrkmJCfcHQij26GH6OYGpTCOcltWC3KKTeQUm54CnEUiR1cWjQKr0jFyVLp22L+fedeH1EnwQQ3Zsso4N2uqD6kxTKdKw3ozYm+vXSbW2P6oh1mkkxLLp/UrjB5Gylo5u1paECFmgRWwuLkALIDEn0TnW2+c8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 08:53:44 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:53:44 +0000
Subject: Re: [PATCH] drm/amdgpu: query default sclk from smu for cyan_skillfish
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211011083147.577024-1-lang.yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <53bf0be2-be7a-5a38-4c04-dbd82a928db0@amd.com>
Date: Mon, 11 Oct 2021 14:23:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211011083147.577024-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::24) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.21 via Frontend Transport; Mon, 11 Oct 2021 08:53:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 542a9ed7-a762-4b9c-a553-08d98c94a175
X-MS-TrafficTypeDiagnostic: DM6PR12MB4842:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4842683D8E255B516BABDA5E97B59@DM6PR12MB4842.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFQsPOT+J7rBUhTgJpoIIXaYPvXokjDY+IEc2Jv3Y4VVkVrkAjDQqgUPEq+kFH1b1/aPuSh2YFC+SJSKh3/Y8RTpVRLvYY/kyHMb0nx8E1ZFSdilHqvvWBOfP8W+zh4+4eWNySNjYS6NP2nng9GCKgV7CSux3K32egEItdfbhFBFA6Z1+MDZRWRb/xy8QJhKvN9d74We/0mK9hK2Ho0/iEDj1BNq1K+Y1d2yOp4g4PCkKgOSHlalruHW0g8cmkxmKsN/uOAg1/gB841ehpUPGBjDrl0GeZTtwtTDO6XyJkMVxaB66BFmm3kb4kEcVkCDcq7VVzOs3YcVWrvtG8rpodIatLEQ0WOpjS9/3tHb8ZEBAxbjuQVAXPE2xav9TcVkGdps65DgeaHRQ5V35FRziZrxop9jfeQ5HVfGVywl4Ra0KVbHpnliUstSuUTmFCW8yWE93B6BFV8z5Tz8vi/V78onbqhnNnKcsiItIyQboemNAHRlzfY6GJtgPUeHbGD3fX6jJ2q/4cbf9pm+v3h5U/J/V+EXadY5JrFdkItwICNaBnNiaqSr5DpUJ+d7gFYA1ya0u+WJkaX8N+ia4gRgQ3ft5+kWnlskOUDNSID6Jsh+zmxI/6+80NE7Hmr7Bg+SJ9ycSm6qpdvGSAQAsfV09S0iEf5CABy8DusAwh4oUGPKVhmeuB5tH+RrAONQ3j0ZYI9EIqYo7k/TvKDlNowFHtUFFjj9ZZS8QHqWAlFDU7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(66946007)(6666004)(8936002)(83380400001)(8676002)(31686004)(956004)(2616005)(2906002)(36756003)(31696002)(186003)(38100700002)(4326008)(5660300002)(86362001)(316002)(16576012)(508600001)(54906003)(53546011)(6486002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9vQUdWdVNXeEJhUGpKWUFiVDYycDQ0R05udW4yY0hlOHVhczc4MVFzYjFh?=
 =?utf-8?B?VWViWlJEcjFOYjg5ZHlDSzBMS1VZWTBvNUZaWEJLU0p4cnJ5OTdmWlVDUDRt?=
 =?utf-8?B?cjl2UVA4TFFPd2hsbUVTaGJybFYxRnJyenhON3NlcFRZdGJWRGt5KzhiUFB6?=
 =?utf-8?B?VlcxazFiRG5Hek1vTU53dXRzOXVZNFZEdE5FSHdqRTRqVGkvK2l0SlRMem9v?=
 =?utf-8?B?THNDd3V1ZzdGZENaYnVjT1NYZlZaSWZOdlcvR09sVGhMaU9BdW1BQmdXQndX?=
 =?utf-8?B?czlyU0xzWjRFakpxZW5iMzJSVkhYRnFWMWxxbDBQZzhWTkZ3SkJVMEQwM2li?=
 =?utf-8?B?K2lURnNMNGtrandMVzRyZXpNZStySkhaWEdPOGIza1JBTS92Tll6akxzSzZE?=
 =?utf-8?B?V0R6eFVGOWVLQUllOUo5YkZMNHhqODZmbHFLeXJ2NndBVVRiMkQrSGhVSlVQ?=
 =?utf-8?B?UEt4c0Rpa1dIRzFRM3NnYzgxakg0VXpPZGR3OWFwNGdXbTJ3akdtSE50WjdI?=
 =?utf-8?B?ckpjOFhJVW5uYWl4QVFlWUlBczVhS1ZLY1lhNGpXeFh6dkxsa0pSWW5yT0Qz?=
 =?utf-8?B?azljQ1M4NmFuZnoxakFIb29PemU3RVEvTVdZVE1pek43MFpRaGpUTVJ0ZEVi?=
 =?utf-8?B?YjRCK2lKeXVvdXpRMmszVmZ6WkZXYTFybXdZOU93SmpsamxNWHZ6RjYzV3Rp?=
 =?utf-8?B?Y1JyL0c5cVRkY2sxS0FnRlBJdWRNMXdDejVKUGdiZE5KbTFWV2trL3dCU25E?=
 =?utf-8?B?UzJ0YlVPM1RTWVdYaTVNbzhmV0M5UHl3cXRXMjN3K2JtNjJDRTlETWlVWDR0?=
 =?utf-8?B?bEJzcGpTTXZPV1phMUNOWk9nczdFWGJuNFEwSEF4NEZZZXZ0Tm43MkRwWlQw?=
 =?utf-8?B?U1RaSnVaVFRUS28yUWROZmxzUkN4TU9vSlBxZHRTMDROWk4yeThzREtyNXEv?=
 =?utf-8?B?NGZXQzN4VE54d3Jjb3FJYnhqS1l2R3FDa3NrRDJSVVFoTGFuNmtkVzdJTy9n?=
 =?utf-8?B?V3R0U0w3Q1FHL1ROWVkrUEtXVXQzTENEaGJLdXRnZTM4TEl1Z0V5MWd4MnJX?=
 =?utf-8?B?NzFpMzFyNldDWUd1Vm91NkxLaGxFQVJzaThUbHRuT3pQK0c0WVIxU0wzc2tt?=
 =?utf-8?B?U3hlOHpxR0VaWG9TOXkrcEJjTVM3N0JRSmZqbXRqdFkra0tIUGNleTVQM3d3?=
 =?utf-8?B?czdiZWlNZDQ1QlF6cnd0Y2hmdW52dVlwalRqVHE3MzBnOEk5QXk4bURVT0t2?=
 =?utf-8?B?M2RCbDNSQjRydWhheDhQMUJvQmtrbW9TZjJKdThNOFlySnpVQkFEQWhNVzJu?=
 =?utf-8?B?ZVRjbnd3amMwNW0xT21OdDI3eTBMajF4WjZKT3VXUlZWb0o4LzVFSWcvU00x?=
 =?utf-8?B?L1BHQWRWYlNLTlcvMXlOWmZNL2Nqc2NmcDBVMEY2dGVDZDVZQy9Udis4NTBw?=
 =?utf-8?B?RmVJTEl4R0VkMTFqVHo0UU16Q2NMc1cvdlUwcTJaSjBBYVN3cGZpODJSZEdX?=
 =?utf-8?B?M2pZN2w1YThrc1dYSzZEbk5iS25pMmVRWnlpK291TDhDanB6VkNoYlYwR2Zx?=
 =?utf-8?B?OXdLbENFeDJIRFdqOEdxdEl4ZVozVCtReFE2Sng4b2J5eExaWitWUjBpa3R6?=
 =?utf-8?B?OHNWZFIraEtBSS8zcDdzNkw1dHJtRjVlR2lyUDlCT005Vm9pRWVYdXBTazlI?=
 =?utf-8?B?ZU9tZU1XVTJ1aXZ3QVI4UG9LS1hoOWlzN3pNU0lOR1ErSkp2VHhRNUhDeElr?=
 =?utf-8?Q?ibqtz2Ui4VB+FeWnEDHPy6C2WjqjLBgf60VqIQH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542a9ed7-a762-4b9c-a553-08d98c94a175
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 08:53:44.3375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIV4nu7dlvus1+6B5lTrM4Wa+37iLVRT6dqzi7mt75VrzKdTEnVMTkKh7aN8bgxk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
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



On 10/11/2021 2:01 PM, Lang Yu wrote:
> Query default sclk instead of hard code.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c  | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 3d4c65bc29dc..d98fd06a2574 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -47,7 +47,6 @@
>   /* unit: MHz */
>   #define CYAN_SKILLFISH_SCLK_MIN			1000
>   #define CYAN_SKILLFISH_SCLK_MAX			2000
> -#define CYAN_SKILLFISH_SCLK_DEFAULT			1800
>   
>   /* unit: mV */
>   #define CYAN_SKILLFISH_VDDC_MIN			700
> @@ -59,6 +58,8 @@ static struct gfx_user_settings {
>   	uint32_t vddc;
>   } cyan_skillfish_user_settings;
>   
> +static uint32_t cyan_skillfish_sclk_default;
> +
>   #define FEATURE_MASK(feature) (1ULL << feature)
>   #define SMC_DPM_FEATURE ( \
>   	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	|	\
> @@ -365,13 +366,18 @@ static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
>   		return false;
>   
>   	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
> -
>   	if (ret)
>   		return false;
>   
>   	feature_enabled = (uint64_t)feature_mask[0] |
>   				((uint64_t)feature_mask[1] << 32);
>   
> +	/*
> +	 * cyan_skillfish specific, query default sclk inseted of hard code.
> +	 */
> +	cyan_skillfish_get_smu_metrics_data(smu, METRICS_CURR_GFXCLK,
> +		&cyan_skillfish_sclk_default);
> +

Maybe add if (!cyan_skillfish_sclk_default) so that it's read only once 
during driver load and not on every suspend/resume.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   	return !!(feature_enabled & SMC_DPM_FEATURE);
>   }
>   
> @@ -468,7 +474,7 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
>   			return -EINVAL;
>   		}
>   
> -		cyan_skillfish_user_settings.sclk = CYAN_SKILLFISH_SCLK_DEFAULT;
> +		cyan_skillfish_user_settings.sclk = cyan_skillfish_sclk_default;
>   		cyan_skillfish_user_settings.vddc = CYAN_SKILLFISH_VDDC_MAGIC;
>   
>   		break;
> 
