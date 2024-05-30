Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A78CC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 14:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8EC10E16C;
	Thu, 30 May 2024 14:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZKPC3NC7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E7010E16C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 14:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JixviW+STcLq7Qsp2qopOIh4MnFWfWDF+tDo0ISzrJBiv1u3aq7rV+GJTmQ+1UCynzvgI2cus55aAg2jjYo/LtONljesQVdLphxUSyi00Pvh3wDxoItDG41MAG8Scf5AFbSbUbFNa3Pq6YByMaDDLXCDUaZBVcsHZGRh/ACqZE6yzkCWj4j6cvFMVOvMyXWOG7NtyyUA8ArVR8O7tNnd7ETRRHnDWTjgupEQuvsRIQk8Ih8MWQUUsFrWm3J5OmYxIHNKzLzzzL2rfxDWgmsnmEILo4Rq3np5knu2BH/2yvS1w7Db4Smuu2Gy7PXnMZ0TAE31BwQ6GH9NLk5NvQY/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91FnbOThXVY9hscpnlGn5J01N355NBwdv58SvZVL7bM=;
 b=XUwniNHwJZY4h4XikWGBORp75ZJdEQ9Ogj85h1thNrgJzMWDsC0YDsZjQQdPyFSrrptJkOFIQU+Id46marQIyRTvvateIznk0Dsv7KCoDcOPZH4BUUxUlR/vn0wudcPCDGntYFdhF7EtvIBIX0LNbAUHzc4LecDxX1y10/pNXdKjt4H2GwwccosvJbBf5VozaSIR8yfjJzXlO38zYjadDkH/L9ZdtCFoRrmAJedUNb19lfgrg/9+g/fxv3xb5OLSz24/dXnPe1jrmGouZvlZgDKWhO4GrBJwU6r5O5Ibf2RZV9AYKM3pIPdkAEXPW9WnaPZU2i4oaVD2HPLd68ydUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91FnbOThXVY9hscpnlGn5J01N355NBwdv58SvZVL7bM=;
 b=ZKPC3NC7hJhbwSXAJtHnaVxu+apLbKMjScA0DDTL1xZ0sdNnxxvCYhUI0oDPlY5CKaCKEOnuekQa57iTnLaAHMLXE0a7vwSoj0glVX6PUlco3aPcPYT1PQBKWG0ErtwTZpoqDpRDb/AiwlKR+9B7qN8yvmY8iHswe/TDs//ZDtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 14:09:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 14:09:14 +0000
Message-ID: <2f66954a-a2c2-4aab-8caf-035fb28b1827@amd.com>
Date: Thu, 30 May 2024 16:09:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgu: fix Unintentional integer overflow for
 mall size
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 jonathan.kim@amd.com, Tim.Huang@amd.com
References: <20240530034654.2341118-1-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240530034654.2341118-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e653b2-befc-45ea-56cd-08dc80b215fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFZZMEZrTzRJZmtqa0NtbUNGWHI0L05hNmJBaDlqeGVUOGJ5b2ZoZFBFd1Q0?=
 =?utf-8?B?L1UxbXV2cEswSmgyUjhlOFJmYkJYWThwZnF3WnB0SDNmVmFNckQ1YzdiTUxR?=
 =?utf-8?B?TVF1dENqS25ISkppT0NTUmxVYSs2ekwzUkF0RTV4VWJOenE1RHJVYWFxeDhJ?=
 =?utf-8?B?YlVsK0hFNXJtS1F3UGo2V1JoNGRMakZoKzh0NGxRaHpxbEVkcmt4aUp6bUhQ?=
 =?utf-8?B?NnZaSmlwNDJ3NHJacHlDUDFxcjVkdnVkYXBBWHF1Ny9nUVRmYktkRUpZMXJS?=
 =?utf-8?B?N3oyekJVMnJDNFM4cnNRc3RrWVNIQW8zNysxekRKb1Y5UEZ3aVpNZm9FdFBL?=
 =?utf-8?B?Uk9TRkx4RlYwNkNnUmwweHFFVXpFRzEzdmo2ZmdER3Fyb1J2YlNHZS9aVlBu?=
 =?utf-8?B?Ni90aCtUS3dONzR3dkFzYVk2N3FLdkJ6S0hXbHQxRUFtQ0pURkkrWnBRWnl2?=
 =?utf-8?B?YkllQWUwS25GZFR5M281MStZVndic1c0R0tBaDNWZ3QvMmthbHo5ZmZNWUVy?=
 =?utf-8?B?WXRWWkp2ZkFFUXJmRzk4cE5oNytpVWYycGpla09wVTVDdDBqdk5zLy8rL3RY?=
 =?utf-8?B?Rm1wQ0gzNW5NRzVBLzRJWG1ZSHBQUFFCN2lOQXNLTkNKcUNWYjdjUXN4WE9V?=
 =?utf-8?B?OXFHYk9nc3RhRll4Sk5FWFk2cnVLb1BVanpueHpySWlZdlk1ejdyZGRsdUdI?=
 =?utf-8?B?Q0RpY3pkVWNFRGpOTmhvZmtkeENleTB0UmhjaDhWOHZyTThKRVNaeXpta2lF?=
 =?utf-8?B?Vk9xTzFFYkhIV1ZKNVlLMnR4M1JnTFBqT0VaVFBkcWVNQ0w1NnNxKzU4L3Jp?=
 =?utf-8?B?a2NJb1RjZW1kT3RKYnNzeXNCV1RJMW9hbjdSS0QrNnZkOUw0UEtoT05jRGZW?=
 =?utf-8?B?TzRFUmlPWDRKc1d3TGI2Uzg3TXVtbTZldlExZlZ6QWlkNHVzcS9ZTjRvR1RQ?=
 =?utf-8?B?VG1iVFRHelpoQXJMT0pNUWpWZ090TjZTT1NFNG96VHhWSDloN0J1Z2FqVUFI?=
 =?utf-8?B?aDUra1VZL1M3MTJ3NnVxQTVUSVAzeXpReXJiU3JrS3hNazA3QVFCbkV0TDYy?=
 =?utf-8?B?dEsyUnhBdld1RkN4VVpUdFFML2ppV2lnK1ZUd281UFkzakpTZWtpNElzb3Iy?=
 =?utf-8?B?T1J4VHJlSWRPTE90SDRLSmxEUVNuVG1INTE0ZG5TYWNlNXJZTTNHMGtmbWx1?=
 =?utf-8?B?K09NS0lJZ1JJR2RoNjdNN2U4TnAyU2hydGY0WVMxZ3BkamdRRGQrSTh4V2RV?=
 =?utf-8?B?Ry9GeUJCR212UnpHZXJ3Z1ZwMDZFakU3Nlc3dlBIK25KQnBualFFY255bW1M?=
 =?utf-8?B?N1MwOEpZWlh6UDFOZ0twbENhYzNrL3RzZW5QekZGclVRSVMxaWpPekxEc2Y2?=
 =?utf-8?B?MGVPOExvQWJyamNTTjJhdkwyVXUrV2JYa1gvVFRIYnhmQ2Y1dVgyWDVNOUZT?=
 =?utf-8?B?OWRpOWVXZDE5TmY1emdPZTRDd2VpendEVmxTR3VaYWtNTVhWeXk3SzFIY3B4?=
 =?utf-8?B?cE1NNVJhZVM1L1phY09iUlVCN3R2dTBCbUhFb085dTI4cW9hVjVjMnF6Q1Y3?=
 =?utf-8?B?cWE2OGUrRURCTTVMeHZKcWRIODAxbWNiM3BUS3VIY1krMm9CUElrMkw0YnlM?=
 =?utf-8?B?YlBJUk11ekFDTmcxeXloSjJ6NUN0c3k4UmY3QWNtYjZqK0V2ZFhTYjd5R2VQ?=
 =?utf-8?B?WGl5LzlzQzl6bXdvM0lFNHlxci9qajFGV2IraFUwanBFWUtTS3E1ZkpnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2lEalY2eU5ISXlMWVAwUDJaM29rMS9oaG5QeVNvS2RyVnFaMiszKzlUS1l0?=
 =?utf-8?B?eFcxRUsxNnJQRit3UkNxV3VtNkVxZmNSbmlZaFltNFR2MXlhMnFWMGx6VjM1?=
 =?utf-8?B?QWp3U3ZpaENHYzEvVFRIQ3dObEFBMjc1QnRlN3B5emVwQjZ0N2NYOHkrV1NW?=
 =?utf-8?B?VExqbzRENFYrSHQzVjVVUUMwOWhXdEhlaGs1cjFTbnpwdTl0Y2RRZHRNV0xQ?=
 =?utf-8?B?K0V5M1hTbmdqVFk3cU9nRm5ETEEyTTY5WWJ2UThqNVNjRk5ZeFNveVo0dW8w?=
 =?utf-8?B?UzVJaG50b0JscWJLV0JMcHRvbWRxYlFoQ0R2a210R1U3VEIzeGNwUW13M1Uz?=
 =?utf-8?B?TEFleGk4NEluaFpka0Z1blFzUnlvNG51UU84aHdwL0I2VzBuV2NaMnZCb3pT?=
 =?utf-8?B?M0FLTG5Kb1Z5RktEQ0RyemFHWHRpWWxPbDhhRTA4YWpRMXgyRWRCbnVQVnY1?=
 =?utf-8?B?NGoydFhSNmpCaFh6TkxIQ3F2TGdyQ3BFZUJiZGdYbFg2TXY5YWh0d2FUVVhH?=
 =?utf-8?B?M2ZpNTZneDJEaUZ0eHAyYlVHQ0pmTFIwOHUxZW1xYVo4S3VKdmE4d3hVTnlP?=
 =?utf-8?B?Y1pIU0hKSFlFbDVJM2F1elB4dnZlWllHK1lVYVlPWldDajhMM0EzTU92K0Z2?=
 =?utf-8?B?TERSM2dsMXlEL3J4MlpJYS90Q1cwUmJGaENkdkY2MkpQTThEc3hGK21kR2w2?=
 =?utf-8?B?R0JIQm5kbSs4dzd1RE8yVHBwUzdaWUsrdVBZQVFlRm8rMldLNHhxWjMzWmNG?=
 =?utf-8?B?MW9HVlRmOEwzVmU3cStMTk01Wi9MVGswNDZMZGp6ekJVU0ZuWFQ3ekpQRHg3?=
 =?utf-8?B?OE5zdnUvNWtyWHFONGFLZUIwZkttVnFpYWI0b0xPSGk1S1MwYUExaDNKSVRs?=
 =?utf-8?B?K0hmYmg1ZENqWStITkU4a1JoV3RMbXlnZllwMzRER1crWmpLSE1pS21iU0hq?=
 =?utf-8?B?djA5N0UzalFqZkxyM2VHZFhTaDZ2NllReHJSZHZIODZXSFhIZ2xjbzFUb2I1?=
 =?utf-8?B?RmExdDlZLzVsUkUvTWJZMjRCRTkrQkpFZGRVbENVTzl5UWZ2aC9LaTd4RStr?=
 =?utf-8?B?dWdPTUt5ZytNWjZJUlZDamltS05vc3Z1YjZEOVVYMXd0M1k1Qm9RUkgzT3pM?=
 =?utf-8?B?ZVd3cys3L0FlWlQxK1pYMFd3cS9YOC9BRzd5eW83ZHpGL3czNkJlUEhEM0g1?=
 =?utf-8?B?Ny8rNHNWamZSeDY4NTFOeEp0WS9jdmIweG9KU1Y1Q1pmeW0ySWE4RjJ1UFJQ?=
 =?utf-8?B?QlNrMENiT25qV3Z2SEtiSEhGYklpMVZ0eGc5ZnZ5a2R5ajJSZTZNK0gvczQv?=
 =?utf-8?B?STJraHArMWtWamdsTmorNnc2RnBvQTBJSXBFYWZCYWFSZjFLQXoxNWpjdTdj?=
 =?utf-8?B?TXdkbW01TGJrMGROZk5pZjh1TzhneDBXcVVPVzJnUlBKck9NQlJJU1N1aFJU?=
 =?utf-8?B?MDNVdGl5dkJjYjhMVEo0MGYxSUtoMEZCQzdMeWUzZ3BEQXhhZC9RUW4vcUQy?=
 =?utf-8?B?OTBxMk9ydHEzcWZFOWxMaHlWWXNzNHhSS0ZqUzUwU2V5bi9MYmxsY0tFN1VF?=
 =?utf-8?B?TkJaZ2U3RU54MENTV1NEaGlaNXc1ekE3NnZkaVlUayt5cHVJT0tuZkhxc25p?=
 =?utf-8?B?VHdTR3dWL204Z2dmTnFRalZLaEtQZW51QkpwMnpKaVlzR1gzTVlYRXZnd3Bh?=
 =?utf-8?B?d2hTNnR0ckROZzVWeHJTMWNMa2ZIMDZQU0ZFWW9ROFRTV1U3TG1WczlUR0RQ?=
 =?utf-8?B?bzIxekttU0NSYzB4TVo2VjJJN2FUM1lFcllvbDVMQkRvQmNjanRrL0E3VlQv?=
 =?utf-8?B?R2JWMG9ZRm9Sakp2TnF0SDNqR3EzWHZxcEZITnZlK2xra3hlc0lMR0dnTytX?=
 =?utf-8?B?UFVQS2VGNHl3UEE0TlpYai9PZEpSVmM5M05QTUxPai9VUFhleUxyMUhEMnhL?=
 =?utf-8?B?TXFxMWtXUmdzak1SVW4vNWVOTVVvR0tOTDVUdkZ6N1FFQTVWRytsMmFLcjdL?=
 =?utf-8?B?Sno2a2phNVBCdW5oWDVuME9renZDc0o3bVQ5Zzk5allHNXF2MHVTUVFTQnVT?=
 =?utf-8?B?UTlKMlBuS21ZMy9HdHY5NmJBd1R2bEhnc0xTZlQ5ZVgvSlZ5UFpJR091V3R4?=
 =?utf-8?Q?+/dBpzCe3Sr/PJJ+d24TyH1Xd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e653b2-befc-45ea-56cd-08dc80b215fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:09:14.3980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cl/vDwKwJF/PIL8+OZGrI73ZdjGe7b94BYoAz+Xen4Gz7y3ZPSq4BBoIL2AfgZub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
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

Am 30.05.24 um 05:46 schrieb Jesse Zhang:
> Potentially overflowing expression mall_size_per_umc * adev->gmc.num_umc with type unsigned int (32 bits, unsigned)
> is evaluated using 32-bit arithmetic,and then used in a context that expects an expression of type u64 (64 bits, unsigned).

Maybe better change the type of the local variable instead?

On the other hand feel free to add Reviewed-by: Christian König 
<christian.koenig@amd.com> to this one as well.

Regards,
Christian.

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 98e8f30824c3..9e0cfe06c8b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1639,7 +1639,7 @@ static int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
>   		break;
>   	case 2:
>   		mall_size_per_umc = le32_to_cpu(mall_info->v2.mall_size_per_umc);
> -		adev->gmc.mall_size = mall_size_per_umc * adev->gmc.num_umc;
> +		adev->gmc.mall_size = (uint64_t)mall_size_per_umc * adev->gmc.num_umc;
>   		break;
>   	default:
>   		dev_err(adev->dev,

