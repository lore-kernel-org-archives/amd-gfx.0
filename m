Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70F8D11704
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 07:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE9610EA0B;
	Fri, 25 Oct 2024 07:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wtvqErUh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0964F10EA0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 07:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJaQ8vZJcA0cKM5rsCyDyPm6ZHddnW3jfvAKPeAkvp7mj2/GhG9AhzV1UB4dSlwkjyvW22YSm4XUpf4IO43erxCZGyp2khHTt+kGXO2wYQajmeBSZEDT6o5kxqqEC6ktTox2D51Y5WsLp1FkdJgleV0Jyxsfe264d5Be92R4YNBjoK0jgYyZ5JoMr2aA/zB3MfA4J020EGXkTDXJweRp8kte/46EZh6VGF15W1Sbe5H/p+FgiLyLvjdoGL3tikUkcUZWp44ZcB0kw6pem4ZKkoMBVQrTMzkyP8ThsTV/Qa9XVDQPV+rk7BRcIRlLDPNsogN23qsWmQC2kNrsKjZt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/7YUASByigfYSBQOTGNGez5UXa80VcBwe8ercCc+24=;
 b=rlBxn7UF+JQFCJYiYBW7oxmB6c5gUWBXNyrDRBprYTNwe8rI/W1nxu9JJAzjo/+Gw0EphwgR22FlB4/jCKE8wA39viBJz2Twsi+J8jEobLLlzlvGYVyVV7Wp526iTydJ4UzJRTlb2YVlgMlbSqRa2wJO80XcAqqeT6Z5gEcCvF2yVbtk7aSckdSOOPGUE/3SIOjfVrzmiahSkDTClRvJQFTfCmpFPioynq3LvO50ZPJi1mURDP63+ePd6x21A5xLsXzjb/s9W7L6oWDzienx7F3QFp4atQr1PbVIKSKW8GLsjQmBQDUf0qX+kUEJ3nzEhS3i+aroAXXOngrP4IKydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/7YUASByigfYSBQOTGNGez5UXa80VcBwe8ercCc+24=;
 b=wtvqErUhNgif/2MLY6wEDyD8PxoKbneDctiQ8g6xNd7tn1pkLCL4YZxYQN7eD/P+ugaUXtW7BdoyLbpO9Sbc8w/3573NW0xsuutD2plUl/2DUIF/F0dS2SvxDnWnfXyGU0OuXy0UiSRdrzeOU1gBxY80d33MP6XxKoCX63Ltrfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.19; Fri, 25 Oct 2024 07:24:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 07:24:58 +0000
Message-ID: <fc9e60c6-2796-4ff9-b1c3-f023b07fca85@amd.com>
Date: Fri, 25 Oct 2024 12:54:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize ACA log print
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, tao.zhou1@amd.com
References: <20241025071922.95979-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241025071922.95979-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0042.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 908619f6-d177-4b5e-b030-08dcf4c62172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2lidDhrd0prQVFZVjFvTFRYTWEzaXlSWXlxUU5GTTdCQ2xBZHZSS3V6TjZt?=
 =?utf-8?B?L0VyS29Pald3ZlhFM3JacithZ2NwSm93M2lzbjhjS203UU1UTnlTekY0MnRV?=
 =?utf-8?B?eUxvQlBITHJXOUZMeGdhbGVBR1FlcTlIZnV2azIwUHVtTVV2Mi85VjIzQWtU?=
 =?utf-8?B?QkV4MGNFamZsL2cyZWU0VnI1ejh1eTYzT1FuMlZ0ZHArVk9KVVZIeERpb1Aw?=
 =?utf-8?B?b3RiZ09tbzBNbkpOZkdaQXJjeEF4cmhIazYvUnZic0lmRVJxRko5UXRrWVgw?=
 =?utf-8?B?b2FUemdpSUVTdGpIUUJ3YTc3bkltYlNSS09WbEpnY3VRSndlVGZNY3U3OXJh?=
 =?utf-8?B?Z1JYQ2s4MUtXYnRFR3dOaHJNYS90MGFubHRIZi9lZEwxWFRNakt1VDFQbW1Y?=
 =?utf-8?B?cVhsZkQ0ckhrQzk0dTh0Z3o1TTRKOUJsN1VhRnBPL0lXdDVEcDkvQkFFc1BP?=
 =?utf-8?B?bVF1ck1sczZ5ZmRUZXMrRGRPTno5elpLcDdqTVJ0UG9LSGwxL1hlU2wvTFRC?=
 =?utf-8?B?VCtpNHNhWEVpZWpGWEkybzg5cEJEcFBoQkFwcW1HSlBTQVBEdGl6QVpzdWhS?=
 =?utf-8?B?QStlVGR4QVo0YTluemtCMkVnOWNCOTFJeGhhdGVhNit3L3gvb250eHhvZ0xX?=
 =?utf-8?B?eW9RZTRDNlM1bmV1UXBMVWlYcTNOaytpT05ieWxOS2EvM2xheU9sSFpVemIy?=
 =?utf-8?B?bFVGU0VlS0pjQUhmSUtZVk5PVXdOeGhpRGVWY1FMd21FSHNDbUVKbm9pcWxt?=
 =?utf-8?B?d3NyTWxoZHNUNHNwUHpFRkd1MUM0TmZ3OWhWQzdDTXUwVmlmN0FnME5oU3RS?=
 =?utf-8?B?QW9mWnRNTWoxYVdiaXRTYXllaW1maUN5bEpTclNhaWNKUkk1VER0ckNYdEh5?=
 =?utf-8?B?QThkRCs1Q1p6LytCMmtybThUQWZVa1lMZUpLNmdnVllGTVlNeGltOFRPeHFx?=
 =?utf-8?B?RUlWMEpNdW40REtoc3FKRmtEWFhLL0Z2a0ZZaEtKZjB6bXl5L0JBVEkxYlVj?=
 =?utf-8?B?dWxpSjRyVTRCWDJ3YVdob0w2ZlVrNm1RenV6NU9zRkpLNEh1bEJ4SFgxS2FI?=
 =?utf-8?B?Q2Z3cnFiTkM4aVc2TFR5ZHAvd0tsb1dMUVJtRnkwcTlPT0t6c3o1dTZialNi?=
 =?utf-8?B?NVdnWEtNaXJ0NGc3ck5zNjM2OEJSRlRtckhRaGxnQWFWNjIvZVM2TCtCVG1q?=
 =?utf-8?B?c0l4cXVucUFIaVM3Vk53VktIb0VlYms1SkcrS1REZTNORStpdmVEVFhlL20z?=
 =?utf-8?B?ZUpGUEhndlIvQ1g0b2c4WHR6bUprWVdiK010UGU0dCtZV3pHUTFzUDU4T04x?=
 =?utf-8?B?MlFGbE04bkFhR3FJbEhKY0JxbjBqSUlnSUJ5TXBya01XTjJEN0RqYzYwL3E1?=
 =?utf-8?B?TVJHSlpTTEdPMDZlUmdEZExLTFVkQUpDNk1tMVYxZEhCK1A2TUd4MndQV01O?=
 =?utf-8?B?WWlrRmdYNVBmODQwOXc5enN5U3ZqcWRmWUhyS2hSdFhhNkNuNmVKOERMcUha?=
 =?utf-8?B?L0YxVjV0SFJtcW9hNDE2TngvaHZuU1ZXS1A5Tnd0dExGRUszVytHZVBucWdy?=
 =?utf-8?B?d3hvM29XamRNL0pEVitPNXk3RDhPdXFTQlh0U0FEMWpXQmI2K2FlNlhTVEpk?=
 =?utf-8?B?d01HSFh4ZWNXb1VkT0piT0pwenhrcXdJaVZMZ0piMzlLb001Qm00NytZMVR5?=
 =?utf-8?B?ZHZBeXkydlM4dC8zSEV3Vkg2L1lHQXd1anJlc0dscHFpclU4S3UyYnpGMDRU?=
 =?utf-8?Q?ZzMG26LkHG64HMmSVM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhrbHpIUSttNTRkVUtOWjc3WThrYnU5cHduSWFWOXlHZ3FVZk5YZ00yQUs5?=
 =?utf-8?B?QUk3aTcxNjJVTzltUmlGWUp5OFY5NFlMWlFlTnBWN2dmNFowMXQvZGdZa0FY?=
 =?utf-8?B?Zzl0ODFZNWhQQjRVcWYyaVZidUQ5bzhDOHEvajVxT1pzczlQWG1HT3JUK2Rw?=
 =?utf-8?B?NHlDT0syNDV3TE9RdFZZcTFXYzk3aDh6czlxVGxrYzBmWmV3K0IybGdFVUZX?=
 =?utf-8?B?ODBBRmhZRWFmRDBWeFRVWWdBVnBoQXVhZUJHQ1JCQkRENUJlM3BPc2gvZmxk?=
 =?utf-8?B?NGNoK1dLYnVMbGxCZjJieUw5SmhUNnM0WDAwL2wyR2pjWEUwbTIwUWpIbnda?=
 =?utf-8?B?eG5PWjBDWno5WDkvSW51NnRzbXlhS2NHeklsTXRkcFhjQldjZUVNalR5T2hU?=
 =?utf-8?B?TzdOUUhtTmlnVDlrZkJKSjYvdy9abWtTeU9Gck5UVEZUSFRXYVBxTDFob1hn?=
 =?utf-8?B?QXBVN1FVQXg4enVjT3pNekZsaTRhdzB2MmVkdURHZ3psTXR0aHVvZDFSaGsv?=
 =?utf-8?B?YVlRbnBTeDJ4K0ZWS0xKZDVrZWcyU0NOT255KzJrRlRlaVNZNjRnNnIxZXBS?=
 =?utf-8?B?Vm5XNjJFMEhEejhzQWV0ZzF3Z0p2bmpVRXhkeTBDeU9tRCs2SVZnSGhvTHB5?=
 =?utf-8?B?NDdrL3lJN0hpbUlWMGhpRW4rZ0FEODFjNUgyb1ljU1VpdmhsN1A2dldoY2NH?=
 =?utf-8?B?bEYzektjZzd4L2hyRWREQ0ljYTM5dHFUM2ttcFI3ak82RVk2ZnVFcTk3L1Fn?=
 =?utf-8?B?TWZlaW83aWFYRE4vbFFpWGFzUnc2Q0YwSW9rZEJka3RGMU93TW5JYnJOUTE5?=
 =?utf-8?B?NTl1T2E0bkpoTGJPeU9rM0pvVndXclBHVkhnWWhQYnViUUJrZ1l6VnRlOWRk?=
 =?utf-8?B?ZUUwdlpUUTJibllQcndSQVNrYkVVeVUwWVl0ZFhEWGprNlFtT3FtVnAzQnJB?=
 =?utf-8?B?V3FjUFVWOUc3OVVzOHhTUlN1aFAxb2tjbmwzWUl0WUl4N084ak1leWxTanUy?=
 =?utf-8?B?MmtLNkFnRDZCdGFVdTYxMlR4YkMzZ2RRWUp3dDdCRUdlQlRBKzlqQThiWkdw?=
 =?utf-8?B?UDdLc3FQUzB3K0V6Ukk4Mm42VG9iT1Y1Q21LR3B0a1V2UFVxd3pBSUw3d2My?=
 =?utf-8?B?WUlFNHhVazRVMVdmZS9DVmtsendGMmlmY1hzYnhlVGdMekl5MHNaWlkxUXRM?=
 =?utf-8?B?VldocGpFRVNDWVl0R0IrQVo0WTljZURXejlHR092YmpqQWpMTXhQWE1ZSndr?=
 =?utf-8?B?NGNwd09nM1BjeS9NN2ZQWEdIeXA5V090VWg3MWpNR0FaM2JaSzNuTGpVOWhM?=
 =?utf-8?B?V3Z4TlBsd214aXBXZ0VmM2N1em9HMnRiMjF4TzgwS1A0UW1oRVhBZUQzV0U0?=
 =?utf-8?B?WWJ0Z2gwTE1vR2M2QjNXUWliMXRrbnVPRTlBZGEyaU1GY0pSMUFSU3cwOXhq?=
 =?utf-8?B?K0x6U3o4d1BHYWh0VUE3SUFGZTUxa25RMmF1NURUU1d6Y3FqdzBQNFF2WjBP?=
 =?utf-8?B?YThoMGloN05rcEdoVjBSUkU3N0x4ZkxVaURjT3kzU3R2YnFKWUZ1YnVCSDVJ?=
 =?utf-8?B?ekRCVGJqWmZDSzRDeTBOdml4L1p4dTNLQitBWWI3cWdOUWozanB0N1AvM1hI?=
 =?utf-8?B?aWIwcGJhSmw2anFPLzBPbWRnWjJnaU5rUWE1SytZR1hHL0x6QWVvL3pZSWZw?=
 =?utf-8?B?dDNUYW5pcDB5NjJpNHR6Z3JBRWowSlppczZyTWgzZktudXk1K2t2SVY5NTFo?=
 =?utf-8?B?ZXVaYXZuUEduZlVSYk9sZXh6d1ZNYkVvRms2eEJRaUk1VUJDTTFwV2EzSDhR?=
 =?utf-8?B?ZUpsLzV2dVV2QkFjOGw5T0dwRFl6UmkyemJRcHpNRVFVMktVOUl6OXh4TURH?=
 =?utf-8?B?eGRVejB4WUhTdERab2c2b1VTNzRlOXhxYURlQUJOcTkvSnJYSVMyWHNscVNn?=
 =?utf-8?B?UlRiZW94QUl1VVZSYVprMkxSbnVwbTRWdXJnVnc5UW40d3k2dlJLM3drL3R5?=
 =?utf-8?B?aGFKZy8xdVhPL3RYSURnalZlRStoVDQvdVFvZnJaSjB2OU1qZkRmc1BmNnlw?=
 =?utf-8?B?R2pseGxTUEpZV0ZPYkdGQXhScDkyemdMU0ZOVzExTUlTUVY4Ykgwb0N5aHJm?=
 =?utf-8?Q?5Qf60K1JTtgZvJhnWQ/gd68QN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908619f6-d177-4b5e-b030-08dcf4c62172
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:24:58.5122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +r4fVPL4k4GmdZqT9/6F7GOnlzyQO4Pg3ecCM7uMKwILxBkn2Z3XWVyyiPhoX5pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
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



On 10/25/2024 12:49 PM, Yang Wang wrote:
> - skip to print CE ACA log.
> - optimize ACA log print for MCA.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 18ee60378727..3ca03b5e0f91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -348,6 +348,24 @@ static bool amdgpu_mca_bank_should_update(struct amdgpu_device *adev, enum amdgp
>  	return ret;
>  }
>  
> +static bool amdgpu_mca_bank_should_dump(struct amdgpu_device *adev, enum amdgpu_mca_error_type type,
> +					struct mca_bank_entry *entry)
> +{
> +	bool ret;
> +
> +	switch (type) {
> +	case AMDGPU_MCA_ERROR_TYPE_CE:
> +		ret = amdgpu_mca_is_deferred_error(adev, entry->regs[MCA_REG_IDX_STATUS]);

AFAIK, deferred errors are not correctable. Shouldn't it be checked
against AMDGPU_MCA_ERROR_TYPE_DE?

Thanks,
Lijo

> +		break;
> +	case AMDGPU_MCA_ERROR_TYPE_UE:
> +	default:
> +		ret = true;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mca_error_type type, struct mca_bank_set *mca_set,
>  				      struct ras_query_context *qctx)
>  {
> @@ -373,7 +391,8 @@ static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum amdgpu_mc
>  
>  		amdgpu_mca_bank_set_add_entry(mca_set, &entry);
>  
> -		amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
> +		if (amdgpu_mca_bank_should_dump(adev, type, &entry))
> +			amdgpu_mca_smu_mca_bank_dump(adev, i, &entry, qctx);
>  	}
>  
>  	return 0;
