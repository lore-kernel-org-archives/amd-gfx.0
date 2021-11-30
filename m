Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B1FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 12:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1BB96E558;
	Tue, 30 Nov 2021 12:28:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC16E6E558
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 12:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJj5Mv+VT5eM34m3/+9lZeeaDdmaezjtVcZzryItvq2jkeBKMad81lG7qfSo7BXs5DAkCs6zvo/MX4OXFForv4why90QvvwJJJE/++6nEIgmipyRWXTjmPD3AQCdJJnDTcghxxYHI9H+pmEg5ihor+GaPbfv3MjcwJ7PTC29rB7L+0nXhJPf0rnJ3Gj2REynruWqK5pahJ1dFEYM2vgC6IDPpHW5VHTtYurxCgHQNGjrTx/O0y4cCkYRo5XiB9fuRsvUwJ/hNKN9QPXRTMR1Blz5AzvnucghXTbETqg9EeSiKDo+nRwPYl3soUCQDEHoS+4znBKRPjBjEyKaFrbwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL9o1OwqAVwumY1zzrSJ1pnh16RGEhNGdJoa2gC1TE8=;
 b=KEED7HVeeNDXD1h9DYLVtbcciDwu9iCDRhO9w2FF3Ru47ciOqawFWoFqYB3Maf/NT/TEbeQ5QKLu5yjeq/aCMGo2q6NiqbqxXL8DtbWLZdlO3HVGZeQ3Jp+fTeqrYuX7aXvOShNlEmsQaq2vrbIgyf8NrjxBJkZpsggSJ9DO/USkiEbDk6ItTOII2lbuDXsOZBT3M5l4CvjFa+4u8FD9GZPzViKXrkTkdGddkdJ4/X2j/krneIf9jjwoYcflzvyTBUwzoF42XjZeuFW3LsK1Ut68RerX0aG6xLIQWDLZht5JZq/YByCBi6VJVasfnz7NuzfcRgKtVYcGt9reCqc99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL9o1OwqAVwumY1zzrSJ1pnh16RGEhNGdJoa2gC1TE8=;
 b=uS5lzAO2/xtYadn65Sd1xmOfWQdmHLPuug1GFBXiVQoZu8vT+vaYwPTfPavI15oLxHxgODqMgl3q5FRg1ErJ0IAGhVG3wvOfYEme0+DuaDQtZCB1+Bl/esLedtaHU7Ea3ZoSakEndsJUxf44eTRkRF9ebdLlRPFLXPPJSmoAASI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:27:58 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 12:27:58 +0000
Message-ID: <4a7fecc8-5c09-b0cd-ffee-2141aef9df05@amd.com>
Date: Tue, 30 Nov 2021 17:57:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 06/17] drm/amd/pm: do not expose the API used
 internally only in kv_dpm.c
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-7-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211130074259.1271965-7-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::31) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23 via Frontend Transport; Tue, 30 Nov 2021 12:27:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d47327f8-a849-43e1-4cb6-08d9b3fcd7e8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882F66D0C24DBED6EE94BD997679@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGJDEo+FQqv3SXHWWDxwtcZLvBVa2Q0TNaFPV+kGBkA5GcB0CWbF5KtWH/fudN0XAtiRKlThGOyrM+ynk470nVmEKdeWMyfX1f9SeBvlv2A/cXwy9ZSNyNmUpJ7UrZ6SSVa1aQoYNcv3FFGqy650Y1YKTN3HSnyQAd+0L8fXRz35vVRQO6KKKHHv48md3hiKnFSF83RIhY0PH9q+RSdnh7d36QeVNsVIYYs17BQFWRycZYdsCpV334rYxqopPJrH1dug+cpR/LibqYEtBAc2XFm9Vca/n6A0/0TC0ohbJJhCwyWuv+l9sKf17pgaSVfDnHY+jD/8JKzKTieXcRMdjXbilG/GsmX8EFw+GOXcOa/dgyqR59dDUHxeBp++Nh1jcuCO/3JPQhais05u9h7WnKsdobAjiInYLjwyy3VnTSqLgr2OGkgkPaVpa+NjtiWJ8GY/Wu5/kMSKqEoJ+Gu2GspI7WdMoD8YozYTaW9L0puWsfrOLTiU4hAu7vRen6PLeheFuUepbyW9Argcp2V1rFAFyLv+lS4QwlGhX6+X1CFDclF7sPS4PTtZojYiPGCQddy2uiAMmp0FYDQIzEFdal4OB0BFQGYa1FQUk9vEmWVbDQsaQZCX14QrSiNzS5O+oEUAnPvv0fMtkKe8aChPUKk06yXK3b/WnslkLxv7qIRuAiJQovjQBxsAOPpQxVSGiQ0+INP6Qszb228TQ4Nh351mfaW9Ls85XkdMKatA6Ev9qmQq8beq61dsffOPiknf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(16576012)(26005)(8936002)(53546011)(38100700002)(6666004)(31696002)(2616005)(2906002)(36756003)(86362001)(66946007)(66556008)(186003)(83380400001)(8676002)(508600001)(316002)(4326008)(31686004)(956004)(66476007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzB6VDJUa3lQVlN6SkNsK2NOM0xDWTZXRzdOZ2tGSkpoTkgxZ3IxZU1yanlj?=
 =?utf-8?B?Y2xLVk5pbU9xQldQZUFLWVlja1BGanJ5S3M3dWVnK1NaWnNiKzBnU1kxRHQr?=
 =?utf-8?B?dXBCeXM0aGczbmFuNVdiVnBnTk9sSGZnNnZQVUJzbTZKMXFla2kzN2NERzFn?=
 =?utf-8?B?OXUvMFdlRi9BTDNkSzRkTUZRelFMSVUwVGlna3dyZ0F4bUNoY2YwWkF2aTFO?=
 =?utf-8?B?ekd3eENvOXpvSW9mTWJPb2JCeDFzTnljSS9aV3o3ejkyQWc3Rm9RSmloWERK?=
 =?utf-8?B?YWxYbVNSS01PZXVUUmh1Y3NET3M2STlLTG9MYzdjWEQxZGs3SmZFTWJ4QzRx?=
 =?utf-8?B?d0ZDMlpZS0V0WVY0eWp4ZmhmMllzTGNOMkZJUk9mZmYwMEpjMkY0S0g4VVdP?=
 =?utf-8?B?eDQyaXorZ3BRSzhqdXllcWpDeE96ZHgvcE04SjRBM2dpbU5QTEFob0xZTDJH?=
 =?utf-8?B?ZUxkVC9TeFJwZ0dlUGYrWkFKOTFNdXRhcnlFczNnaEcrZDhZMkg2eGRFYkpF?=
 =?utf-8?B?dDd0Y2hTK3Q1TnBIM0ZudFV2Rm9VSVdPck1lRWE5R3pMbzM2dWdkY2pNZ2pn?=
 =?utf-8?B?N2lNS242N1pwcDV4Z3VNSjZIaFdUMDBYMVc4aTVNNFRKZ0VicDlKZ21Rdmg5?=
 =?utf-8?B?VEhyOFI3VUEvM3ltejlZeTFQTGNQMGx1cmJna3FBNUduT1ZuNFBDVzVYMk9s?=
 =?utf-8?B?WGN5NlVGK0l1aTYwTlNaaEV5T3Z1ejV0Y1hPZUw0S2dpclgyVUZ3bitVSS8v?=
 =?utf-8?B?aFY1NnkvWHNBeTR3RjE2V2V6ZEZqME9kV1RSRXZHKzJ0WWdpSHdQR1RJencv?=
 =?utf-8?B?QzJseXZuY01qNmx4b0NXY0QxTWdwYTNFeVdJZVZKMTNXVTNOSzlvU29Tc0J1?=
 =?utf-8?B?WjFOanR1bTFjSEIwbkw0Y29UcHpmbFRUR1Urb3RYeDZ6M3o2Mlh6NVcwdXNq?=
 =?utf-8?B?a09KV1habmxwUGU2UDVKWnlYVElzSktqaWVaNTQ5NWU0RWFseW9leDZ4dUhI?=
 =?utf-8?B?NmlUUm1rK1Vxd2xGTE5sOE5Sbko5REZCY0xWaHI0eTl2ZGM2Wmo4MlgzNlpa?=
 =?utf-8?B?YnRlNUIxMHozWElEK0ZRU3ljOE9kR01VUm9WTklZT0QzaFNFSEpmNERONzRM?=
 =?utf-8?B?bm03TlhYc3lLSHFnT3JkOUhaajB3T0JwcXgvNVBQcDAxUWU3aGdEM1lPSVVD?=
 =?utf-8?B?Mnc4ZW9FcHBCZy9rcnc2eGZndG9WVGZoNHhUS1REdlgxZkI4UW8vNWJpeWJi?=
 =?utf-8?B?bGFRY2JmMU8vWlN5ZytjZXVLcVRZMWVwd01oUUZLMmNwbGJFZU1obk1yWHkr?=
 =?utf-8?B?NzVLUkZaQTJUbFN0VGM5ZWc1NHVJcmEzRExuL2NsMnlGY2ZCZElLN2VWdU5n?=
 =?utf-8?B?SVhoQmt5TXAvVVpnZXQybCtjV0t6ZHN4OGthYXl4VHIvSTV3UDV5cjdIaC93?=
 =?utf-8?B?RzVFVGg5WUo0cXlERi91akZYNE9lN09lQ1ZDdVV1MHMzSUJCMWtkeWZSVnNU?=
 =?utf-8?B?TjhkU2JTRGF2dkowQTlDYldWQXdycFh2SWJyWVMyK2FFMHdkYUVST2hiUVhQ?=
 =?utf-8?B?UXV5dXhTMytLTXF3Z2ZKZXhmZHR2cnFkY2ZWOGthcm41RUs5SHNRa2ZlTFZn?=
 =?utf-8?B?dDlkN1UxM2RWc0lCU080V29haGdNenpKU2hMSU05MUs4VkJyY1dLYlhZR3RI?=
 =?utf-8?B?SFYrOW1FVVBUSG5LMCtRd25KSFpZTW5SUXFsczdWT3JtbWdJaWdmQ1NXTDNH?=
 =?utf-8?B?ZkxBbW1ZTFVsazU0SnFUS2hHdjdIMUFIa3pYaUpKVmRyU0U1aHJwRjZlV3pJ?=
 =?utf-8?B?b3pYT1BoaXFOYTQyWnVQNHhhL3BGQkhUTHRzMXgra1ZtZ05RMEZETnpzb3lI?=
 =?utf-8?B?WDdvSll6b1c1MlNtK2pKb3d2a3lkMjd6SkpkQ2pjUzlPN0RCbjJlVnlsSFVX?=
 =?utf-8?B?SVo3R2ZtY1BCNXNydlJjcjNHMURZWmZHZlFia3VVZlpzbFhzeHptRFp2Y01Z?=
 =?utf-8?B?MGxBQ3NydjRMaEFGTkhiN0VEMmVKYkt5bUdGN1FuUnNEbjFoNzZDaEY5UUgy?=
 =?utf-8?B?SmQrVGlVMFRqR09RZzVWcFZ1VzkyNWhtNnNVcWpMbzhiWk4reFJIb05lLzN1?=
 =?utf-8?Q?J1ts=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47327f8-a849-43e1-4cb6-08d9b3fcd7e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:27:58.8979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09SeO3In51+7oNYO6ZWptcpaFOcbK3bP2C8ZeLw9VGD0yx9cRRWMxtU0qh2GRDQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/30/2021 1:12 PM, Evan Quan wrote:
> Move it to kv_dpm.c instead.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I554332b386491a79b7913f72786f1e2cb1f8165b
> --
> v1->v2:
>    - rename the API with "kv_" prefix(Alex)
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 23 ---------------------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   |  2 --
>   drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c | 25 ++++++++++++++++++++++-
>   3 files changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index fbfc07a83122..ecaf0081bc31 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -209,29 +209,6 @@ static u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
>   	return vrefresh;
>   }
>   
> -bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
> -{
> -	switch (sensor) {
> -	case THERMAL_TYPE_RV6XX:
> -	case THERMAL_TYPE_RV770:
> -	case THERMAL_TYPE_EVERGREEN:
> -	case THERMAL_TYPE_SUMO:
> -	case THERMAL_TYPE_NI:
> -	case THERMAL_TYPE_SI:
> -	case THERMAL_TYPE_CI:
> -	case THERMAL_TYPE_KV:
> -		return true;
> -	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
> -	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
> -		return false; /* need special handling */
> -	case THERMAL_TYPE_NONE:
> -	case THERMAL_TYPE_EXTERNAL:
> -	case THERMAL_TYPE_EXTERNAL_GPIO:
> -	default:
> -		return false;
> -	}
> -}
> -
>   union power_info {
>   	struct _ATOM_POWERPLAY_INFO info;
>   	struct _ATOM_POWERPLAY_INFO_V2 info_2;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index f43b96dfe9d8..01120b302590 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -374,8 +374,6 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
>   int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
>   			   void *data, uint32_t *size);
>   
> -bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor);
> -
>   int amdgpu_get_platform_caps(struct amdgpu_device *adev);
>   
>   int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> index bcae42cef374..380a5336c74f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -1256,6 +1256,29 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
>   	}
>   }
>   
> +static bool kv_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
> +{
> +	switch (sensor) {
> +	case THERMAL_TYPE_RV6XX:
> +	case THERMAL_TYPE_RV770:
> +	case THERMAL_TYPE_EVERGREEN:
> +	case THERMAL_TYPE_SUMO:
> +	case THERMAL_TYPE_NI:
> +	case THERMAL_TYPE_SI:
> +	case THERMAL_TYPE_CI:
> +	case THERMAL_TYPE_KV:
> +		return true;
> +	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
> +	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
> +		return false; /* need special handling */
> +	case THERMAL_TYPE_NONE:
> +	case THERMAL_TYPE_EXTERNAL:
> +	case THERMAL_TYPE_EXTERNAL_GPIO:
> +	default:
> +		return false;
> +	}
> +}

All these names don't look like KV specific. Remove the family specifc 
ones like RV, SI, NI, CI etc., and keep KV and the generic ones like 
GPIO/EXTERNAL/NONE. Don't see a chance of external diodes being used for KV.

Thanks,
Lijo

> +
>   static int kv_dpm_enable(struct amdgpu_device *adev)
>   {
>   	struct kv_power_info *pi = kv_get_pi(adev);
> @@ -1352,7 +1375,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
>   	}
>   
>   	if (adev->irq.installed &&
> -	    amdgpu_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
> +	    kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
>   		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
>   		if (ret) {
>   			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
> 
