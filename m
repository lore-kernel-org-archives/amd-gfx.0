Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622C8ECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 03:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF1B10E25C;
	Tue, 20 Sep 2022 03:43:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA9A10E25C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 03:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZBmOfD3vOwHw1A07Amxg0U5mKOgLkutovS+WZ0OTB+Qnsks8tCcc9Sh0W7cRa93RjhqxvGyLAmawMx5A3+BEr4dud4SuOqKh5qgxVem5sAeGDzfyv7Z9C1Dt1svxCoTkx9kdvpqbOf8/MUy0ChCf8/16aD62mtLcAiYNdY3spysXsLJL1bg1iE8AjpoleUWWUGgx7CZmV/DzuVVuyjjW2l6KTeB986N9L21E1ILvNkJeCVfzVJ13u9uS8cf8DcluAQBOCJvewiMgj9kavQbd01TbZwffUk25cwUiN2mSoM589KYP4UOetypqkGSU0LpU441mxAH1UaN90OQ+/6VhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTmjxaGCZCKPlyI8FG70iuzBX3fYivUAuj4Uqa7ldns=;
 b=nH+sriyiJVdUcazOym5MeMi4btc9cIjWL6toggooUux+3ynvwrm2ndZ14wLY14XFMsntYSBekhw4m2Ql47nhmrNMZFw6vkCSJ/l8skuez5kFHRttAsBkuS8ghSPV/Nwvsg7dxkcdwKrcwSCXb0KqfsangNY42VTQymjgDSDq0f0UzeP5An1h1ohA8KbxvvDclmuptkcqhAzNjbgQs7Od2JwFjTPZGzEXT4dG296zBzQP/aR7Z7PStxk8sY+XhU59jc3RGSy3S8f1B6d535chyt6SqM4zNBdgUU0M3OfqZlkHKAXyFEaKheokRV4BpAN4VnQvCfuox110LQ8d3qrhSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTmjxaGCZCKPlyI8FG70iuzBX3fYivUAuj4Uqa7ldns=;
 b=la5DczPxgeQEd/om48XU+P0gZxSWZoOfiz5cGXrZSYYCmAyntNZfbO1BlGi9XqqwBpL7CUp+uWVzU+uvPCXWkQM1M3U9XGfKaDDQrSBvnq5nI3D678UNqPgdFhqn5loJbzdmRn4c6J+np0wLvfcB8/pzjRla5h6JKSPKTI5R2GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 03:43:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 03:43:01 +0000
Message-ID: <e711fd93-5df9-8ca8-234d-e66a937268cd@amd.com>
Date: Tue, 20 Sep 2022 09:12:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 2/7] drm/amd/pm: drop the pptable related workarounds
 for SMU 13.0.0
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220919020251.7048-1-evan.quan@amd.com>
 <20220919020251.7048-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220919020251.7048-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: b71d3518-a26f-4eae-7550-08da9aba37b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SijhK2EcHpMzExUmSFRC1wLlptWKuuiJ7QW8Wl8Pl6fMLhKxU970HWUhbnhwCQY/wsATGmA6xWSoL2g4xn59MPJCm9z5Y0VY+aacS8VWovpXb3HUAorc3BpmY9sTsTgWXs1qX6gWgWeQTrl9bIgFXLyQI3h6S90JWpg/pCm2Ts7pov7rk0xetTegXzZePYDo7ntI2q+iwx2ghPFUfBP5wKfG1J4MG3YM0WIvEuEdP82AxlODFJwNNkn5GNtJHeSfuiqg0wv//DrlAWG+iecPtViICVMDUwKLvgem5/PIxQv9U2rNKKhYFlS1KigqvFrw1ZtseuSjFg32KlJKTkSRdKZxhJnKpAj4FOL4sgpOCIh30ahyOTxG7WNCICrZmGh1PVCR5Ho6/FEX/WMQXMWEsXRA4OEq9C32kTm3fX53b6E1mL+fQq3+1UPooS1bRETv5jxgAidKYDGVagtNYYAQLzkj+kRqTw8gUdIzUAHF6B6I3j4giXxFuQSzS5gz4ZHoP6B+K3gHdURG6NcV6b/Sc2liv8j57wVDhqcUfKCDao02NjVLhXcRSZqhjeoLJVrDyedhYBi/GpXgWB0A6BvQZjCQ+UTMFYvO4PT78mDJLTJzEjNtMoYIJ2aBtmm3jc9Q3/thIZMZIN/HI3s70IJfr1UHVZ3VfkUbClx4AG50TXvflmr36lxZE4HGjmiGUmg0Cz5MSUPAW16cohMf2NQB+cHzlUfS0V9uT14dhwIVnSqh2aRxClN8non7lCmnbx9aFDoZhDLNHIqOLWa7uMxJmFilQebarX2g4U4Y//0JCaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(31686004)(36756003)(2906002)(316002)(38100700002)(4326008)(8676002)(66556008)(5660300002)(66946007)(66476007)(31696002)(86362001)(186003)(478600001)(2616005)(6512007)(26005)(53546011)(6666004)(8936002)(83380400001)(6506007)(6486002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1BLYXR0RktueVVEQUM1c1ZtR0dCeW8rOHk2ZSs3WlRBQ1BObnJ6QW1ROHpG?=
 =?utf-8?B?TWtBZExuTE1raDNlaUk5ZittYkprcHYxRDhaYms3L04vaGs5VmlUOTkvZEFT?=
 =?utf-8?B?U2xMWXNEbmJDanVGTXIzTFRPd2hxNUpMVFkwMytYUWl3b3NGWnNFemw1NDRP?=
 =?utf-8?B?U2R1aHc1RGZRZHdTbHJLeGNWVjFCV0VYRlNOVGtKRzVlZVAvTXkrWFlqdW1a?=
 =?utf-8?B?UjFIdG5iQXAxUUZjN3pUbXhFMTBpeWh4TENEalkrck8xVmJRWEkxZXV6Y0pU?=
 =?utf-8?B?MkRyVXdkeFlxaTJiQkpXakhaM3ZLbDlYd2xrOWp4Smk1LzBmTVhSVjBFNzIw?=
 =?utf-8?B?NTBmTi9ubXdoSkJtMUNaaEo1NVpRcC9Dc3ZHMzlmMnlqTjNOTmlFdmQzbGVG?=
 =?utf-8?B?OUliU2NPa0lUVVl0Qnlydzh2K3FOWFFtZ0ZNa2svTFZqMzRzVGtJSy95NTV1?=
 =?utf-8?B?YTRIMXZMOHN6dDh5WkJ1T2ZBeTVIT0E1OUV0SXhYSnhzbm45b1Z4aVArby9P?=
 =?utf-8?B?ZlZHVFl1SzVmaEhSZW9EL0thNzFGcytzRWsrZ09Qclp0MVA1UDV1Vi9BK2pL?=
 =?utf-8?B?andoNUduYVo5U055bGxOQ3JaUWxTRExjSHhvaU9scnQ1TEZQUnd0QS9pMnU1?=
 =?utf-8?B?M3JLMEhWblhwOHI1aGhoQUNZME1vQVVVa0tFKzMrbWQxMGNYUEpyWGFjTnRW?=
 =?utf-8?B?NzJEelhEeFJuTjcvVEZKT3VsQWxRUnVSZjRYTXFKczFBM21CaVMxS1Z5S1dH?=
 =?utf-8?B?NERpZ05iOXdlTjV4VmQ5ODhtWjNzZ1UwdStVQUZTMEpLUlp3Y0RON2dCUGRV?=
 =?utf-8?B?bWlrSWdNYjEyeDMwRU9BemFHOG9RUkpydWR1aHNGWUVBNDNndDNOYTR3SEFs?=
 =?utf-8?B?T3E4RFVtVklINnBGNXRwUHd5VWZBS0V1QVFvWmxUaUtqeWZZR2UwZWFmZ0xt?=
 =?utf-8?B?QzBRNFJuTkR5WDlpcjVseVh4TlJTY2NXSW1LUE4xOHZmeENBejZQaFJuWHpM?=
 =?utf-8?B?V0tSZlNacTlGSnJ6RHpmSjF0OTU0S0x2bUtlZzVDNDVqQVRsV0RKbTR2MDA3?=
 =?utf-8?B?c2p6Q29tRHlWU1hob1FuVTBqS3VGSjlPTjFtdkkvTXFQZkhUUEs2elUrQUg5?=
 =?utf-8?B?ZEwrWlRiTzREV0RBVGtkT1JoN1E4bmpUZ2wrRWRjRXg4ejZ0Qk9HK3loQ2dq?=
 =?utf-8?B?aVg0dEZPbW9hVVVtT1NKTmNRN1hIZG11dHMyTXFHRlVCUmJKUndNN0pwZ3g4?=
 =?utf-8?B?dkZlam9qQUVPYldMa3YxKzlmZmMzUlFzZ0RFS01HQ09RaEhmSWlFM29QOXc5?=
 =?utf-8?B?ZHhxNXZtc083Vi82NllXNlh1dEVKVGRJYTZKcWZGbHVoVTlIN0FkM3ZEYlU5?=
 =?utf-8?B?THIwMjRHZjI0Qm90OVdPZTB1ZkxCbTlQNWc0YUpsMDZvK3dGRDBwZ1QyTTVr?=
 =?utf-8?B?RnRRSXFEdUUvYjc5SlNObWpLRlp4OHhQaGF5RDlOOHE2TWVHSW0xcEtSK2pX?=
 =?utf-8?B?bS9PblRVQ3c2Mm9EM1ZmaStNNTJ2dVk3ZzdoQlY3bFlEdkpGMHF2MDYxaXdU?=
 =?utf-8?B?bm5WV0J5bDErZ2R4NjJjTjJqbTNMSmhQWnBiUkJiaFAwZmFBWlhIUW01ZWRY?=
 =?utf-8?B?TDFsY2MwZXUyUlY3L3NRcU5rRGY5U1dsbkFLR2lENnVkZnFsT2FxWkh5RWl0?=
 =?utf-8?B?dTZvTkN1dlk5dG0rZng2UGxRTTJqSFVWSVNweEVqZUVvemc3TG9ldy9SY1Zi?=
 =?utf-8?B?WE5YSGNjTUkxdWRXZ1hrYktOdnJpY2p4NzlDWkg2WDF6SVdwYklDQVJldHRI?=
 =?utf-8?B?L2h2ZjVvQjByQXJsZGNVb1hKcGpnWDh1MWhUT3dhNGJVd2tsWE41MDRlZkdI?=
 =?utf-8?B?ekJyY3VlZ05Ma0E4VlZuQWJoZDVDVW41b2RYTFZIU2c0SWZCL3BNc1R6MDJV?=
 =?utf-8?B?UW1EQnltSTV4WEhiZktGTWxxZkxWUERUbTd5L1k4YjAyb012WGh5SmtCak8y?=
 =?utf-8?B?UEVRM2tlUG8wK0NxajZiL0xjcGV4TFF0aTRsZ0k3eng1bkg0Y0E1YU9LbWpl?=
 =?utf-8?B?QjhmWDM1YjNnRGllK3A1ZDJXOHc3Uk5ocEJQNGdJL1ZyVUFsdU9CWVplV0dE?=
 =?utf-8?Q?GKZx9WEZycd8ghrH3YgfaESw3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71d3518-a26f-4eae-7550-08da9aba37b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 03:43:01.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kHiXVnpTdNQGXjQUSiGVbhNWDLCleaaG2Ymw9rLUhmfFHFFNofMxFbsmKziId5H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: Alexander.Deucher@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/19/2022 7:32 AM, Evan Quan wrote:
> The pptable in the vbios is fully ready. The related workarounds
> in driver are not needed any more.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Change-Id: I2549cd1acd6eebde361ed8e27d5631bd57644e52
> --
> v1->v2:
>    - drop unrelated and unnecessary changes(Alex, Guchun)
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 46 ++--------------
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 54 ++-----------------
>   2 files changed, 6 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 4fd685af8fa4..53d26bca524a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -210,7 +210,8 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
>   	if (!adev->scpm_enabled)
>   		return 0;
>   
> -	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7))
> +	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 7)) ||
> +	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)))
>   		return 0;
>   
>   	/* override pptable_id from driver parameter */
> @@ -219,27 +220,6 @@ int smu_v13_0_init_pptable_microcode(struct smu_context *smu)
>   		dev_info(adev->dev, "override pptable id %d\n", pptable_id);
>   	} else {
>   		pptable_id = smu->smu_table.boot_values.pp_table_id;
> -
> -		/*
> -		 * Temporary solution for SMU V13.0.0 with SCPM enabled:
> -		 *   - use vbios carried pptable when pptable_id is 3664, 3715 or 3795
> -		 *   - use 36831 soft pptable when pptable_id is 3683
> -		 */
> -		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
> -			switch (pptable_id) {
> -			case 3664:
> -			case 3715:
> -			case 3795:
> -				pptable_id = 0;
> -				break;
> -			case 3683:
> -				pptable_id = 36831;
> -				break;
> -			default:
> -				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
> -				return -EINVAL;
> -			}
> -		}
>   	}
>   
>   	/* "pptable_id == 0" means vbios carries the pptable. */
> @@ -475,28 +455,8 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
>   	} else {
>   		pptable_id = smu->smu_table.boot_values.pp_table_id;
>   
> -		/*
> -		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
> -		 *   - use 3664, 3683 or 3715 on request
> -		 *   - use 3664 when pptable_id is 0
> -		 * TODO: drop these when the pptable carried in vbios is ready.
> -		 */
> -		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
> -			switch (pptable_id) {
> -			case 0:
> -				pptable_id = 3664;
> -				break;
> -			case 3664:
> -			case 3683:
> -			case 3715:
> -				break;
> -			default:
> -				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
> -				return -EINVAL;
> -			}
> -		} else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10)) {
> +		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
>   			pptable_id = 6666;
> -		}
>   	}
>   
>   	/* force using vbios pptable in sriov mode */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a6b7319fbfe6..1d454485e0d9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -375,59 +375,11 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct amdgpu_device *adev = smu->adev;
> -	uint32_t pptable_id;
>   	int ret = 0;
>   
> -	/*
> -	 * With SCPM enabled, the pptable used will be signed. It cannot
> -	 * be used directly by driver. To get the raw pptable, we need to
> -	 * rely on the combo pptable(and its revelant SMU message).
> -	 */
> -	if (adev->scpm_enabled) {
> -		ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
> -							&smu_table->power_play_table,
> -							&smu_table->power_play_table_size);
> -	} else {
> -		/* override pptable_id from driver parameter */
> -		if (amdgpu_smu_pptable_id >= 0) {
> -			pptable_id = amdgpu_smu_pptable_id;
> -			dev_info(adev->dev, "override pptable id %d\n", pptable_id);
> -		} else {
> -			pptable_id = smu_table->boot_values.pp_table_id;
> -		}
> -
> -		/*
> -		 * Temporary solution for SMU V13.0.0 with SCPM disabled:
> -		 *   - use vbios carried pptable when pptable_id is 3664, 3715 or 3795
> -		 *   - use soft pptable when pptable_id is 3683
> -		 */
> -		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 0)) {
> -			switch (pptable_id) {
> -			case 3664:
> -			case 3715:
> -			case 3795:
> -			case 3794:
> -				pptable_id = 0;
> -				break;
> -			case 3683:
> -				break;
> -			default:
> -				dev_err(adev->dev, "Unsupported pptable id %d\n", pptable_id);
> -				return -EINVAL;
> -			}
> -		}
> -
> -		/* force using vbios pptable in sriov mode */
> -		if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode != 1))
> -			ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
> -								&smu_table->power_play_table,
> -								&smu_table->power_play_table_size);
> -		else
> -			ret = smu_v13_0_get_pptable_from_firmware(smu,
> -								  &smu_table->power_play_table,
> -								  &smu_table->power_play_table_size,
> -								  pptable_id);
> -	}
> +	ret = smu_v13_0_0_get_pptable_from_pmfw(smu,
> +						&smu_table->power_play_table,
> +						&smu_table->power_play_table_size);
>   	if (ret)
>   		return ret;
>   
> 
