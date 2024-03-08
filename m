Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237F7C54E4A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 14:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BF410EDE4;
	Fri,  8 Mar 2024 14:01:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CUqW9L+t";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70EC510F9F1
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 14:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt4nLn34vDvGj2bs15UMGGKEmju82/9epuTRK8EdyfHhBKDXZqvtYZ1G8Ft05jhlfQ0HPb0K4NRQjGOPXQrNNMvlzm6oNhqYyzpD7wsSy8gqPGDOjjs8wol9shRtLwTXj5tjnpMmPFdEX3DnE3MOTPxGt/LOWNjQ6MrazO1YkMkS80KAA5HGzKDwlgTZBJ7Fl0JKttV6jx9udksszNwq8JvSuzxq/EoVgILJxNOgJwKUf7wPmvrZdNeLi4Tqk0Fjs6fPg10gstFCqXg2OZcm56Df+mmL4Vfc1teW8mzSybrLxIlr4gKarIwocMInrjye0eBlQVrYsR7Z8qaSjC5vZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E3CMjDL58PBB2dluCQ+Y1mu/bb/ByvJJjzIutidkfc=;
 b=Vkd9qtjMIYELBzV0iASgZmUTEbUQlFDTqvmLFFSIHZ8pIBP2h+L3bvSUDAAuazNtyX7oQfLVtzDS59wl1q7fyQwGPJRI0uTnffmB8I9ssecdfdtj0Joe5Rw0vDI3UJ7WmtArNpqUjH1X/D7zKZCbfWauiALYHcI48b78rEOsapiXILj80ro1Cv/kiM3PvWaMTHRI4m6kK5P6VpmJzcwFZQNQYO0osQ68pSLhyLhHeKUlFmljkkZNYespwRmGkD56cgQABCGxVu0mSJ4fCkPYTV4CyqXsjxCcQClAFs90iHc4vzqM9IVw4RHT55N+8a8Dny7K0IrLsvsQolXt9ySb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E3CMjDL58PBB2dluCQ+Y1mu/bb/ByvJJjzIutidkfc=;
 b=CUqW9L+tSyZ3MwNbDBBsBnaGS8LEHRfKsH+mDhdm6a85BubO8o4VvpWtc75Q/lVKq5mn1QuV1UydFenpRy9zd8V+vddAW7Tb0GXZgfCl6fBaCs8pUmPI9u5apWwjllgmzkJFaZaioS8aZmRRgaX3qqUEsnftiSbQjVEYxfLdRyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Fri, 8 Mar 2024 14:01:02 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::621:96e2:a3a0:486a%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 14:01:02 +0000
Message-ID: <9f3c2e9e-7c9c-4b8d-9e90-58a0d9bfa87d@amd.com>
Date: Fri, 8 Mar 2024 19:30:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/pm: Fix NULL pointer dereference when get
 power limit
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com,
 Yin Zhenguo <zhenguo.yin@amd.com>
References: <20240308095140.2221137-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240308095140.2221137-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: efb24591-a645-4827-1a40-08dc3f78304f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEYq5i3Th3Gi4TUWrYLt4czG5tERPEQSEIWUKRCq81OUKZ+CAEDxpc33NamuJn/aK+mM3JoZEJZOgldHXOQSkM9bb3Ob64p5m88H7VJIj5YtQzVcOL1R7i8KuUWKfqmSZtJuBri9IAUV2Dahx9f/svhH5s70ssJQZ4wlYPLxF7Baw2U+B7rinmcn5RnCV5DvFck0/OJnqFCZeBmsivZ3hGfl1uenFGBIpz0ijaK/CQfdUbN6C+raZG+40vdRNnUNPTsjhCE3c9djVNJ29EYihI12F7PhM0Jr8Na0lvV/c8sK0iJB6AduF/z1vXbSscnQcqW4G4OETBguGmp0SezAFfE7LpP6i6QnALsfXYOSTXXLzrWfYCWmjW77avTlPUP7E6G9EhBiHJT8BAVDTbhZ5T1NDHwy1vrqGNST19uz7SO5YchN2gjS06cNhy8xc526KqnKyu7RKWE+cP186jrK286VVd7zywAgl28ELuSWu5XMQYWJhq2N/eQuc7195wGNDDpOxMIyHHGxKTtZLJ68yAhysAixZ7eJ9i+e/NdcoNswk4rUZeGcFDb9GoY9tj0Z2j73nDNVII8yikKFy1CqedTb3SWykIfNn49ysFTD1FoHstrGD3kHx2Gj5rMv/F7qik5rT/uUM+wXiJo0hvbuErFIdq9E2Kv2FukKdAb4044=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJsSkZhZlpyYWZvd1h2MTdZdWs0VlVSKzVXQXNRUEczUnY5OUhGSmZuZDdE?=
 =?utf-8?B?bTAyV2o5dlg3Rk9MalMvcnZreUk3K1hyZkRsM05ybmllVk1jMmZ2VElnUFRv?=
 =?utf-8?B?a2RTMDZKemtUUVpiakhnemRJMTZlYjJiZUs5ZCsxWkFBZTdMck02RTJKM3NE?=
 =?utf-8?B?UlFMaXQ3ODI1NThFbHJIN3N5QjdoTzFoVVUzRlBld3IwdUNzcklKOXhBRUt2?=
 =?utf-8?B?OVE4S0lUNzFiWVA4eUphZVlETjA5aGErOVRiSi9zV2dXa0tiUE5kc24waHBF?=
 =?utf-8?B?SGU0OFdwSnFYdm51SEg0M2hQb1Y5WXVReTZHNnVpd0JGTTFJdU5JV0c1aG5N?=
 =?utf-8?B?YWd2Um5YR2JIU0NFMFVSUlNxNUNnSm9oVlpFaERPSXpFZGFwaUI0VXlxdkdQ?=
 =?utf-8?B?MHo0aHM4REpsWlk0TWo3Q293cEd6Sm1ZdG9FMzdkQXFlMkljbG5GUjdob3p0?=
 =?utf-8?B?QVpNU0NtUUtDaFhpcWpFa0VVV2lDV2N2QmNYQXVJZUl0bXpoakd6WTU0dlpK?=
 =?utf-8?B?dEt1TnNIdHZoSDZJN2U1bnhLQXBjK3hDdTVQdWVwaFVTamVqSW81aWJuQkg3?=
 =?utf-8?B?bGF2VWtCL1pVTWtYVVlKbHBWektmR3Brdmx3SHlyWGZkVUw1dlhNY0M0Qm9a?=
 =?utf-8?B?L3l6R3pPNW1YeGN5YjJwTUZSQlpIV3oydEZ6R2FZUnZPZXF1TjRMeHpjb0ZE?=
 =?utf-8?B?cTJQQmoyMjd2eG9nOGJCMFhabnUxVFM2OE9FRWVHSktjYzhmTjhhak5hR2RG?=
 =?utf-8?B?QktvM3lrWDhtbFdWUkhoQnBHVWpPQklsa0RKRUljMzRDdUhnV25IcTVIMTRU?=
 =?utf-8?B?azNzbC91bHNnRkhZUGxIbmZpMVRVeFQrb0NkM3RzcHpwTXJ0VG82RkRGV3RY?=
 =?utf-8?B?aXE5UVBMdGFjZjNUZWdFQzUyVE1DSDhUYlp4akJtNncvdytDaXZqZ29DUkE0?=
 =?utf-8?B?VW01YldvMVhNemdoM241cVRSN1N3N0gyMUlNTDNYMzA3OE5FdjlJOHBXcm0v?=
 =?utf-8?B?bzlCS0MvUE1OQnBUdlFPQWZPT3dOSk1lM3hMa1pnc0RPWTRMN1dPV29nMFhQ?=
 =?utf-8?B?dHFHcG1wVHdNOERKcjYyK3ZXZnp4elg5RVlxdGJRSmRkdmltWXIyeHJFUjl0?=
 =?utf-8?B?TkFOZXN2dzRPcG00NFEzQ1J6ZkcwU0tmOTduM05xYlU3R1V2cmJ0YzVLNzJp?=
 =?utf-8?B?ZnVaNTlyTnl6YnVoci8yb2RXMlM1RjVoWm1zbGFlb3pCdHhONlM1ODVISmlZ?=
 =?utf-8?B?QWJta2FaeExmdnlMOVg0dWRCdzVGOEUvZ1NmbmRoSW5rYXhWbERrazA2RFZ5?=
 =?utf-8?B?TCs1c2xJa0pvamtLbWdDMWZuNHF0STVzaFB0Z3lwbysxN2pkemtmWWdRc0Uw?=
 =?utf-8?B?MWNDdTRYLzhXSVNoZ0FPL0pXdWNjTk5Mc2FWYWNrN3J5Q3hURXJmbGpFTTA3?=
 =?utf-8?B?VXQ5c1pLb0tRdlgzck5kYWJtRTF1NEtxYmhDMGFIbDV3bm16Vlpta0RqZXFH?=
 =?utf-8?B?Y0pFa09Fa3hLVVdZOUI1WCtvRkZCYzRzMVFEbW8wc1M2VnJ6TmphcWxUdk1C?=
 =?utf-8?B?cTJKcDcvQUxXSXNrNVpqSUFrZkxzNGpkTzZ2ODNjUUJmbXZBZXdycE91dWtH?=
 =?utf-8?B?aTdkQUEvMmVVZEVoeWxaRkt2OFhDVDBkVUFQTnVzSTRqTWtUcTgxbTByT3k0?=
 =?utf-8?B?a2U4K0M5SSsvNVE4WHR3UFdzWlEyREhKYWQyQWZtb2VROEFNamlwSk8wR0pt?=
 =?utf-8?B?aWZWR3JWY055SGxlU1R6VEpUeDZFYkRERnpqaVBCeG1Cb3BFalZyNUd6ckFn?=
 =?utf-8?B?eGpLWXkwTEU5VUxpN0sweThhV2I0MzNQN3RsamNmcTc3QlhCeXN0NnRxeHpz?=
 =?utf-8?B?NWx4cHgxUEhtTXgrNWlQUXhSK2VhTmlCQkV3T1Q5aS96UHo2cC9WODh3dmlw?=
 =?utf-8?B?cHpjdUgvYmQvV2lNemZPc2xhY2lycHBGcHhSUjUvWEpUdmhqVzBLbXZWWkw4?=
 =?utf-8?B?SVJpNVZScWhmLzU3MkpTbVNLdzQwaDNqbjVOUGxkMFJjWlhwM3o3VkdsQlZN?=
 =?utf-8?B?VGcrM01jSXgvQVhhbW1NeWwxbUZmMWF6bzVoNzU4QUN2c210OWoyYzZBcXlo?=
 =?utf-8?Q?xq6sKxRD+sDlu4z7Edu8mSZRo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb24591-a645-4827-1a40-08dc3f78304f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 14:01:02.3002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+nVb1hvVc9+TgJytcpMaXT0V+TsbSEMtz8ti1EdiOqJuYiuQUJF0uL/DSkBFj7o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
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



On 3/8/2024 3:21 PM, Ma Jun wrote:
> Because powerplay_table initialization is skipped under
> sriov case, We set default lower and upper OD value to
> avoid NULL pointer issue.
> 
> Also, It's necessary to check od capability before
> using the power limit value from powerplay_table.
> 
> Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
> ---
> v1->v2: Check the od capability (Alex, Lijo)
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 18 ++++++-----
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 18 ++++++-----
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 30 +++++++++++--------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 22 +++++++++-----
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 22 +++++++++-----
>  5 files changed, 68 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 1d96eb274d72..862d5d198f42 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1285,8 +1285,9 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>  {
>  	struct smu_11_0_powerplay_table *powerplay_table =
>  		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
> +	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
>  	PPTable_t *pptable = smu->smu_table.driver_pptable;
> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>  
>  	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>  		/* the last hope to figure out the ppt limit */
> @@ -1303,12 +1304,15 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> -
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +	if (powerplay_table) {
> +		if (smu->od_enabled) {
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		} else if (od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {

This check is applicable even for od_enabled case. Presently OD provides
multiple feature capabilities; only if a capability is valid, then the
limits defined in the table are valid.

BTW, I'm not sure if that is the subject of this patch.

For arcturus, overdrive doesn't look relevant; again that may not be
relevant to this patch topic.

Thanks,
Lijo
> +			od_percent_upper = 0;
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		}
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  							od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index ed189a3878eb..fe8d24a7d319 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2339,7 +2339,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
>  		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
>  	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
>  	PPTable_t *pptable = smu->smu_table.driver_pptable;
> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>  
>  	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>  		/* the last hope to figure out the ppt limit */
> @@ -2356,13 +2356,15 @@ static int navi10_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled &&
> -		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> -
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +	if (powerplay_table) {
> +		if (smu->od_enabled) {
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		} else if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
> +			od_percent_upper = 0;
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> +		}
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index a405424dd699..c86e13f6b6c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -617,6 +617,12 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
>  	return throttler_status;
>  }
>  
> +static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
> +						   enum SMU_11_0_7_ODFEATURE_CAP cap)
> +{
> +	return od_table->cap[cap];
> +}
> +
>  static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>  					  uint32_t *current_power_limit,
>  					  uint32_t *default_power_limit,
> @@ -625,7 +631,8 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>  {
>  	struct smu_11_0_7_powerplay_table *powerplay_table =
>  		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
> +	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>  	uint16_t *table_member;
>  
>  	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
> @@ -640,12 +647,15 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> -
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +	if (powerplay_table) {
> +		if (smu->od_enabled) {
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +		} else if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_POWER_LIMIT)) {
> +			od_percent_upper = 0;
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> +		}
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
> @@ -1250,12 +1260,6 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
>  	return dpm_desc->SnapToDiscrete == 0;
>  }
>  
> -static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
> -						   enum SMU_11_0_7_ODFEATURE_CAP cap)
> -{
> -	return od_table->cap[cap];
> -}
> -
>  static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_table *od_table,
>  						enum SMU_11_0_7_ODSETTING_ID setting,
>  						uint32_t *min, uint32_t *max)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 6a501d2661f5..e17f93ba861e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2356,8 +2356,12 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>  		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
>  	PPTable_t *pptable = table_context->driver_pptable;
>  	SkuTable_t *skutable = &pptable->SkuTable;
> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
>  	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
> +	const OverDriveLimits_t * const overdrive_upperlimits =
> +						&pptable->SkuTable.OverDriveLimitsBasicMax;
> +	const OverDriveLimits_t * const overdrive_lowerlimits =
> +						&pptable->SkuTable.OverDriveLimitsMin;
> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>  
>  	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
>  		power_limit = smu->adev->pm.ac_power ?
> @@ -2369,12 +2373,16 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> -
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +	if (powerplay_table) {
> +		if (smu->od_enabled) {
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +		} else if (overdrive_lowerlimits->FeatureCtrlMask &&
> +					overdrive_upperlimits->FeatureCtrlMask) {
> +			od_percent_upper = 0;
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> +		}
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 3dc7b60cb075..684cb5a7ef6c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2320,8 +2320,12 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>  		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
>  	PPTable_t *pptable = table_context->driver_pptable;
>  	SkuTable_t *skutable = &pptable->SkuTable;
> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
>  	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
> +	const OverDriveLimits_t * const overdrive_upperlimits =
> +						&pptable->SkuTable.OverDriveLimitsBasicMax;
> +	const OverDriveLimits_t * const overdrive_lowerlimits =
> +						&pptable->SkuTable.OverDriveLimitsMin;
> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>  
>  	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
>  		power_limit = smu->adev->pm.ac_power ?
> @@ -2333,12 +2337,16 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>  	if (default_power_limit)
>  		*default_power_limit = power_limit;
>  
> -	if (smu->od_enabled)
> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> -	else
> -		od_percent_upper = 0;
> -
> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +	if (powerplay_table) {
> +		if (smu->od_enabled) {
> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +		} else if (overdrive_lowerlimits->FeatureCtrlMask &&
> +					overdrive_upperlimits->FeatureCtrlMask) {
> +			od_percent_upper = 0;
> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> +		}
> +	}
>  
>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>  					od_percent_upper, od_percent_lower, power_limit);
