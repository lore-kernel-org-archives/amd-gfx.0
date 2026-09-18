Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6DCC88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 08:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530A210F250;
	Fri, 18 Sep 2026 08:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sq22peXw";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2735C10F250
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 08:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEsjYhrcBsHcTXx2Mm6F/pByjCiEA4X+eh6MPM5mIsyq9VlZCO/f1ZbDM+njp/M1ePiU1I07yjEuFLb80InxSHvDy4oEWPdmo5N0SzIjg2PD5pJmrTR24BtxLzbrypgaL7g1/O1QpbXzVgJrermwZD3JTbDxpn3P0d6f8QO9O2TfZUhO5X2G26m5l7rKCo8IJN53QzHIsiZyiZg2LJX59ilMMlIhB7AU2ppBtWxb2ApWwTqoHX4QXemum0Oqs81zVFHbAezzLVMvk1rKHdSmUwHyYILP2fQkiMroearAfIfcOY7mXKWM+ZezKTz83zA9kEkfnG8YCxlNR2i9+nmC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX+xpeJ6QPfTAtrCvMzGKOm4HK03GGKo8iaAEV46gyI=;
 b=B8C+B9XT0QKrc8dIj7hn8NiUdVyueEoeaqCPseRtqCrgwR9XA6hRydkCJebTDHvmk89Alm8Le0jOynTRo4MUVb8TsiUqSXcdY+4ytnIbcc7YmO3gciLw3CITLuve2814sXfPJkix+NLb1lE3AM7g5xR44SMugsjV8hDCD1ct7fhdP/ZuAS/oqN8RznvoqojUChn2EQ4Ltelon+UKppE1TdlpzCoTU4RyedSw5+CKBT4yJGeTER0yjc5ZczU+XpOkt8KxfPULYwUJ8u/nGg2c54Grq/jxDPUlD70s4ITXZtwbDM4FlF2KpYFNEpyuvypm5lCk4flEKukI5Pdaynvgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX+xpeJ6QPfTAtrCvMzGKOm4HK03GGKo8iaAEV46gyI=;
 b=sq22peXw16qJLMdkqE/bP1hpXrmHuIj18niV5prnKrRIVz5tzvKNeXZJYPgImFr1sDkhP59h+6Yt3/ulf+bt6fxnACSHLDuKsawwYStxHrULxFPHWjiXlRARaEDNz/OANTZHDP9G3ik87B/geIynOpBsxTJaEubjH9DRx8bO/VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:03:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 08:03:19 +0000
Message-ID: <0437bcc1-3c56-4f93-8235-bbc12b4afbbc@amd.com>
Date: Fri, 18 Sep 2026 10:03:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] drm/amdgpu: prevent suspend in fault handler
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260917195812.72917-1-shahyan.soltani@amd.com>
 <20260917195812.72917-7-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917195812.72917-7-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0359.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 949f21ef-e6a8-4dbd-669a-08df155b4d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8ZwoUo2DiR6MJKhU+JYdT2QgMrdObhJAqGs29ksB1nIzkXONzk7Ia+0GTFPlmJ55GeXy5NmdtBszS8i25gpfEA4GavnhqhB7C15olhlEDhIEHHQG9ouAO7KQ3bbxGVpFP91AT8ZkuBkHjQky6uR1lrADPfKp2muS3A6CnC7ouHmv+TDsxpg3yqTsKHqq84sL0bEkR+SSiSRCHkrf+XNsUUceHxxT+dPSk7Ldn6X9CPRhQVVAA6wTFRwezgYNhZ7wd2uEWzp+MDg24ThwBlOHVJnY+g0ONIQgdZTda5V5FnYjXAmtPw1QLQamYuyVfY+k2LqzWtxXHr/1qCiOhfR5/gGNFGxrJJi/VmdRVarhSlT49zSu3OxTZLacBNKtAd4IARJnEwgferXZoyn8MBGAnihWVnTspK894+MLAUghOqpV3xfiqwKFXWXclRsB0YiVQ+oG/FLfJ5CdF5PzvQoUTN97vaoFVM0E0ISEMbmQTAC8KQNVGR4n60Q+8dNHDrvIJ3KwmtO1PheecKNk7cW6iFT11O2ACzrZFgQWgPMsTvsBlbFCGkflAbdR/eFWPXF5hgW3c47jV+G3BgwZmf3mflDgXobfmPOZVSHchF4ob8yFJQzOZ1s8MXgA4jlFwVMdADgqMMIlp+i9N3I7raDE2ePSpeTMqwyeMvUDma4u63g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVvV2YybDVWZkJybkd6NExrQjl4Q3pQcnhnRkdpeDBFR0tNWHdMZk45MzZs?=
 =?utf-8?B?b1MxNkszbXBZR0g3YlVBVGR4ODl4cFpLcXZBVlZTQjhsdFd0VE9IazdHelVX?=
 =?utf-8?B?azBCRzJodWswc1prWlgvRGlnVFpkSFMvMzBSODFmRUtNOEdUR09TYmMybS9a?=
 =?utf-8?B?YWgySDJRTkNZZzVLLzJCa2Y3UzY5bm1lL1ovYTFnaU9xbkY4U21sVXIwU0V4?=
 =?utf-8?B?WGxhKzFjK1N2RjJpOWUrTitlK3lybnpNKytGa0NtZEsyYWpJbFNUUXEybUlK?=
 =?utf-8?B?UDQ0RzYxckFjalBFcGVHZjRGcG1OYi9peWN4Z0tZVjczUWM0bTFHeGFUWHpl?=
 =?utf-8?B?aVkvTXdNZE0zT3IzL08zaTBNTHJRMlZEQk1Lc0ZhcDk1THJWK1dLSENkcW5y?=
 =?utf-8?B?NlRpYnFXSUQ2TlR2aFJzeHN0U3BqeW1DQzZuMlFlcHFrZ3FSMDNEUzE1bFN1?=
 =?utf-8?B?K0I3ek5rN0VRNFpBbm9TcjVJTkNTd0ppVDR2UDZnc2lGWVJFZU8yRlY4cVll?=
 =?utf-8?B?MFEvL1VCWHVFSUxYMzkvTER5U1JYdUdCdDlITnY2MmFaT1NWV1JWWGt3b1o0?=
 =?utf-8?B?WEx1MXkrNmNES1FQdnlNVFlGNUNvU1NMS0JnL3FDemptUi9zNE1IdnQrd3pk?=
 =?utf-8?B?S3JBaUtSOFlTaC9ZVHlza05RdTBMZUFzSXp6ZTUrMW1SRThnUmkwVmJIeGxi?=
 =?utf-8?B?blk1c1kyQTdVVkVHS09jNXVEenpVeFlxSmFWcStlY2RVeGRYT3VjMXlaMGtN?=
 =?utf-8?B?TWhZbzFHZm1tNHRJL1phSjlKQzU4ZU9DY3RMYXgwZzJqYXU2TVZjN3R1Vklz?=
 =?utf-8?B?UHVqYW9KdnFpbG9OZ2g1d2wwbWd2YVBoenRCZnNMWjV3UExTbWlHSXJuQVgx?=
 =?utf-8?B?NW5MVndndlBROUQyUndvbGxnQjRhWXJZU00rK0ZackJPc1J4NEtickc3SFR2?=
 =?utf-8?B?K09WT0o0K2hZbEwvNGdQU2FoT1JncUtCTC83Yk1XWmZ3bUZ2SCtEN3hGMTRq?=
 =?utf-8?B?bStNd0JDb0tYQTJjN3lKMlNVZngvVThDWFNKR2ZQVytCMVBmeElmckpvdUFL?=
 =?utf-8?B?M2ZYVzlzOUtkY0xIOGlOejhoMmhocG9GQnZLZ3RPZGVhVTNxWUFCMzQ4YTJp?=
 =?utf-8?B?RGVNekRyQUQ1WUpiTDdNNnlvSHhpdUhFb1VVYy9CdXdoNlB6OG9XNEgzRlFY?=
 =?utf-8?B?NnpkWWQ1cS9vV0FIa3lkQXIyLzRYL3JmWGd3MTNXWHovOXNOd0VWTytibDB1?=
 =?utf-8?B?K1ZneVhKdnJxMnk3YUxuVDhub2dQUmFYenhRZ3JPM0VOS0pXY09SM01McTd4?=
 =?utf-8?B?UGhhTFJEOUNPeUtmRHE3QTR6YzFPbURqd1luc0k3RGVxSTB2NFFQU1Vua3hL?=
 =?utf-8?B?L2dWMkVVRWZ4YVU0Z3Rtd2RrbVhKWFdIWGlwVmViTDZpamJIUjgvS0FYRWxI?=
 =?utf-8?B?S2prZ0FXZEtlNC9LK25hcC9VOEJIRDlrNENJZkpEK2FyMDh3MlE1RGR3Z0lF?=
 =?utf-8?B?dmIvMzByanRRWWdOTW8vQkVUcS9tTHRSS2ZrU1BDVlg4STBRdmhURVhsWDJa?=
 =?utf-8?B?WnJOUnNCOFAxeVlkV2xjVkdicGxGWTVhd1RmcW00MVZXdGJaRkNHS1Q5Z1Zh?=
 =?utf-8?B?eHRUem5lUlZuYmJPZlRUaG94NExxQ25xZXpRc3NodCtTMkJCcW54OFF6ZW9m?=
 =?utf-8?B?MEdUK1h1aklRUFJFTUxtT21sdjJwdWQxN2VMbE9WTjVQek80bXdrTEhiUzU1?=
 =?utf-8?B?ZEc4VlM5Y0NTS2IrOVlZUlZ2bTQ2OWNQZGE4QVNMQ2V0RkpNZDQ4ai9tNUx6?=
 =?utf-8?B?VkhPS2QyY20yZWdXbUVqMjQ1YndqQmFGUTFEbkpTNi94bHF5UUt4S3ZVZUF2?=
 =?utf-8?B?NFZSekJINFljd1EzanJlUDIvZFpKcXp4ZVc4TTNXMjFBbXB5UTVya1dZVnlX?=
 =?utf-8?B?VUpHMGxDUG5BbVk4VzBrRWwyRi91elBTRCt1YkRVN05VbFJyTThRT0RzRmVE?=
 =?utf-8?B?NDhheWk5b1h5U2xrVk9hT1FMeWJHeUZkYS9ybjJrMnZZQmd0WU56QVd2YU8r?=
 =?utf-8?B?L1pjdk5tU3dJeGZqVnQ5ZmRRalpZbDVtbER6YmhBNzJ0M284UHFGY3NDK1cy?=
 =?utf-8?B?dnhIRytUQU1BV0RHNTFHS1VzMDhTOHUySWdrZDJmdWtEWGJEZm1kQlN1QkVU?=
 =?utf-8?B?M0Zqay9TZkFuQlVzNXk0RDNsV2J5T2liQlRuZk9ZOEJmMEpTY0hqU2lZUkxN?=
 =?utf-8?B?aVJ5eC9EWmNsZHZsUUtYNTZSTUpLODlqY2JPeXNEbzk4QTFsWFphT2NFZmFk?=
 =?utf-8?Q?78FAGDSW2CcZK4Ev23?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949f21ef-e6a8-4dbd-669a-08df155b4d84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:03:19.8971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vR4rttKVGs89UMyB/ve4kRCZa+8hUVBOunTonEOZ49+/djpqmfOnSlyBHiFh0/n1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683
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

On 9/17/26 21:58, Shahyan Soltani wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Temporarily increment the PM reference count during page handling to
> ensure the GPU does not enter a sleep state.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> v2 (Shahyan): Added commit description
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e54d30f75b2e..cc6b7c4a947d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -129,6 +129,8 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  		return ret;
>  
>  	if (drm_dev_enter(ddev, &idx)) {
> +		pm_runtime_get_noresume(ddev->dev);
> +
>  		ret = amdgpu_bo_fault_reserve_notify(bo);
>  		if (ret) {
>  			drm_dev_exit(idx);
> @@ -138,6 +140,7 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  		ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
>  					       TTM_BO_VM_NUM_PREFAULT);
>  
> +		pm_runtime_put_noidle(ddev->dev);
>  		drm_dev_exit(idx);
>  	} else {
>  		ret = ttm_bo_vm_dummy_page(vmf, vmf->vma->vm_page_prot);

