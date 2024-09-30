Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66534CE834E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED3D10E51C;
	Mon, 30 Sep 2024 14:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ly5l66Ua";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEA410E51C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmJPUmWrFI+06O8GXdwwujTmW5N3laSai+CsplvQPOGzRpeGvNDZLOa30Ht2I9TB6H2ZLw00Ozh/wvP/6tApbt8Eayqm32phvruunH7H8FAMf+uhVCNMJw5UnkZl9A5me5J75Ju+xxbRmtCIRDVfa0BxLnt8EoO61kGJV0nIzxAxlIgt2Q/Ax4NYIkzkKxSKb1PAVi5s6GUYEsTa4s3i8N/kK05u+OtFHTFM3gPX5iGi31iK546cri8ZE2XTCiKlVR9nmWJDymArbj19SqpDnEsew2TCJsUVF0k/EWi4JzHEqJZ6eFlr5e+ANv+jnwpmsz1rUlM2FIJY9s/x6U6Tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QMgYZ1YoRRQGf6SEocQ5erit4GOPPUMwLUuUFDbGdQ=;
 b=l2Lyn8kzakPFesohh05VFcZ+q0JSSTToFyosJexh/WQP09DuoBgM+qdGUNsH/Jtq0XAtp3DUP7dETXrNfKni1624UIGqgjMHelnDATi+L89XRPuq5YIJ6Vnl0QCbswmzbknp76q+ORMexqt5J2UaJiFB8hol7MCLfmBKg8KIxqC9wNy46pTEydpQOe8M7DIEHeyldfA3ilf7aHQn+4NPfT3KbFv4xUxri8DRCypxv+aY6G4LA6qvMEFPlF/VWcV9r+dYg6B8JlbwAep25FpyYzAzD23iTCMwr4tWy31MDHAeWXVam2JOJ+gaP+UWX8dorl2KVM/2rYolhyjl+A1eNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QMgYZ1YoRRQGf6SEocQ5erit4GOPPUMwLUuUFDbGdQ=;
 b=ly5l66UaLdWYL/eBMywyLpTqdY1tMuP5wXtKgtihAdi4fek58QfkcBU7B4ljSrhfk+o3urWr2QLRdcJtNK22/AESTboA6+hzPsy8646XMxtgBgPM5P2K/VKUdkwSSLavO4rc3qgbSROAPpxiNz7RD8MM1Ozk00Z3Z3gp6JfvVSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 14:36:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 14:36:29 +0000
Message-ID: <4f5266eb-ae68-45d9-8a1c-4521d29f85af@amd.com>
Date: Mon, 30 Sep 2024 16:36:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: remove the dummy fn acp_early_init
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240930143019.2682202-1-sunil.khatri@amd.com>
 <20240930143019.2682202-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240930143019.2682202-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fa4c68-5779-4e6d-f492-08dce15d4543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHdlNlZIQTlLRERpa2ZvSlpYdXNhVGZ5M01DN2p6THcrK2pXTlI4STF6dFVn?=
 =?utf-8?B?NXByNW1OTllrS0l4THJHY2MvK1pzN1B4d2NaMGdZWDlmbUJYYjRocjVLQkhP?=
 =?utf-8?B?VzNDMU5UbE5kUlJXQzU1R0R0VXBncW5wdzE1d3BDZVQvSmpmUDNNNHpRMDcw?=
 =?utf-8?B?N2N6L3Z6WktyVm1mbkwwMTFZc0dmM3ZwUVJlLzFqMlNBbWhGQU92d1hNZzdn?=
 =?utf-8?B?bnZBVmtQK3IxWjZsM0tHVzB2aENnQjlId2pEQXd4S2dFVHA3ZVQwVWZqbjQx?=
 =?utf-8?B?SzNucFlyQm5NTWJaZ1plT3I5ODJuSFo1YWs0Rnd3YjlRa3ZKYzhPZ3BIbThZ?=
 =?utf-8?B?T05ldFJuS0N5U3BzWm8weXZLVnRkTy9yeGJHMUFnMy9IVjFNYnVZZ3lQK05I?=
 =?utf-8?B?Y0NMbW5RNlZwa2ZOcXhxcTJmR0hjbnVIV0FJbjJMZVl5cWU3RnVIZ0xJRW5w?=
 =?utf-8?B?NFBNdm05L09SbFBJeFIwdktGWEF1UGdWdnhmWG1EWSt6eEhKdW5ZRkVwK1Ux?=
 =?utf-8?B?eStxaGFvVzlVMWtLMXBxeHZJbU1XZzMvQk03VnBTRHBtT1pFTzFVN0d6MC94?=
 =?utf-8?B?amFscVk2OU5TNDU1RDI5MlNCN20yNDVCa0NxdkxTKzNSNU42OEJ4bGRYc0tv?=
 =?utf-8?B?aExYdTdEUi9PQXVlU3duS0JYL1dpUzQ0Z0VTS2Z1VkRmUTZCaXFoUm8yOXhI?=
 =?utf-8?B?aDJhcHFxRVIxQXBSaEFOVzZ1cThkUDFzR1BnTlhNTjdXQXlpdE9OOW01ZHIr?=
 =?utf-8?B?ZU4zK3FWUEJxeS9IL1c5K00xcSs2UkEwbTdTU2NnSWxhcUozdVJwLzhLeCs5?=
 =?utf-8?B?N1FFYVpvRjRzY05JTEdMd1o5bWpaNXdqQmN1T25PWU0ybnBUR3lmTFcvSG5m?=
 =?utf-8?B?ZGFybVVLc0xjNVFoSEI1Mkt0TktyTFdJalRZa284eDBTbXBoZmYwdGxKN1E2?=
 =?utf-8?B?aGFMQ2xGczZIcENLV3JmSmd3UWRJY25OU3BpZml3SDd2Vm96dktnakREZVVX?=
 =?utf-8?B?TWo2bEt6clRPSnFHdk9vdTNha0ZURGRwdjQxOUlPQXZUbGV5OHBvVnpDVHJI?=
 =?utf-8?B?TnRLMUI2QVZES3ZDU0VrUnhWMUVFTzdVQStaZEF6R3IyVUhnZ3VwY2hueFZm?=
 =?utf-8?B?MnFhV0RBYUI0b0xRYmg5T1FKdVVRd1hNT1l5WStJbk1pOHJ0a2JoMW1WVlc3?=
 =?utf-8?B?Y2h4RXRLUXh0S0tlNWpqcEdQUE5qQkkvZzFvL09pdEhRanVGWTVLY2g0VXdF?=
 =?utf-8?B?dlNPTlRudkNkMmMzS1loazdCUFU0ZnE5OTBGb0lRVnJNTzlFdXluU2RsTGdq?=
 =?utf-8?B?bzhCbFRWYmxCUUtHOFJsbGxCb2U4clpMNWkzN3JvcGo0cVJNSUNLTC9RalY5?=
 =?utf-8?B?OENQVmFoWGxRUDBkaE1KdTE4RUU2OGVBTFpOOUhrYWxVTnZ4ajJZY0RsOWNQ?=
 =?utf-8?B?MDRQS1ZOV0RCZmU3bWFTdUhYdlQ0ZjI3SzFRZjVDb0YxTFFtVEVPM2VTSC8y?=
 =?utf-8?B?MkhBcEg5ZzM5bGhjeGVleEZJZXRlS3NMb1hZOUhwOGFOdEM3MmJFeWV5dEM3?=
 =?utf-8?B?TVA0OVlpT2FhWlE5WDc3RUlNbjRYSjU3QUpRNHhuRzNVN2xzZlJnaDBuUFp2?=
 =?utf-8?B?R0JFd2hsY0FsZmlxNW5VVmZONENYUFFESE1BVmhpZ1N0UzkzaTFNZ3JMb0xy?=
 =?utf-8?B?anhwakl0dUFHNWJRb2hxOEpXRnoveWpBbm9xUGtxVGNnM0hzajhjNTNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhvREFrNXB0bDRLa0VDMFVQMngwTXV0S3lGMFo1clYwSHZzNUZQNjV0cExx?=
 =?utf-8?B?WTUxK0JZdFVpS0Z2MitqMmpSTnk2TWZhZzMwbUZvN25Jak1sZS9qM3g4SlA1?=
 =?utf-8?B?TjlrdU5mYytOMm84SVNSZTh4di95RVFBY2hjYTYwNG50RGIvbjcrWUdLMmYx?=
 =?utf-8?B?WDArY1d2SXByMFB2dWFxeWNKekovQWQ3U3B3YWlpNmF5bEJ0UzRFK1YyWi83?=
 =?utf-8?B?OXYxRjdOY3lkZVFnNEdONUliTHdtc1FmMnYzdFZwZlBnMFdnL2hSU2E4SUJV?=
 =?utf-8?B?ZE9GNDBzRGt0bFU4NHdoaGVTZ1g1Nkk4NTdyb29ncEIwNGltd1NTY0lXTmRp?=
 =?utf-8?B?ZEthZFdwYmxRckhHeTQwelZUOGUrS3JnVlFUUGY5eXZxSldPR1gxU1lUUkl3?=
 =?utf-8?B?NTJlS3E5ZnZrdXVoenBtT201UFNHMFU0REs0amtVWUlGRFpkcEttMG5ka0Nj?=
 =?utf-8?B?QmY5T24ySmIzZXlYVEl3YzFBUGhzZGJualoyQjhXeDdqTVc5SlVseGFRMTB5?=
 =?utf-8?B?ajBXMm1rTzlqOCtpb1pwTGxpOE4xcUxUZmhOQ1ZSSGdIWmN0N3c4TzJRL25S?=
 =?utf-8?B?UXRWMWtQeExoT2ZZYi96TFRwS2M3aUoySjU5UldHM2JwdWZMK3VKNWR1L0p2?=
 =?utf-8?B?bTJKQVNxaURhTG9HWjRzcUxmSGlpOW54Ukp5YWdSN2FGRy9aY2VrZm5mZ1BD?=
 =?utf-8?B?dTV2UVA4VGhiSWFhaU9ZRnh3NVpFNXovNDRFblNLaThMVzBnaTNkNzUyeGNZ?=
 =?utf-8?B?Y2RsT3BNU0E0UFMxVnNyaDdXYkJsbXk3eEpWY21ZVmRWbCtybTZBVEtIeTNs?=
 =?utf-8?B?S2k4QitGM2xZWGxWWnZJVDEzMkhxSnIzYU85dmZ2MG4zQ2toTFhLS295Tk9U?=
 =?utf-8?B?V2FWZEpsbDl4RGNPb1ZzMUVFc29odWNEc2ltQkVIL1JIZ1RDS2ZCblpNOFFP?=
 =?utf-8?B?RDVHU3pHdU43MjE1VXdmbGVDRG0zalRrVlZXY3RhdGoyam9yZGpmWUpUN2tM?=
 =?utf-8?B?OUk3RjhrN1RLRVpvUTUzYjJaakdWMXpQQjhKV1FPcEdtS0M4TDBNVEZMVmhq?=
 =?utf-8?B?dWMya2RRMExOL0VyTElwV0k5S1dCc0Q3Mmp5RXJJaUd2TW5ZM0RaLytlaVlX?=
 =?utf-8?B?dkgvQmMrUWdZZWJNOGdpTjExaHp4dHByZHZtRXVOa1NzanhuZW1CRm9HTk1W?=
 =?utf-8?B?akpHOTZ3TEdpdnBSb3BGWUNzeTEya2dnSy9EeUZRTlN0bEhsY1dhUjVSUVpT?=
 =?utf-8?B?d0diN0N6RmwrVDBKWVp5eFFOcHdGelhycTQ4a2l4djh6eFF3ZC9BOGFBT0JY?=
 =?utf-8?B?U21WQUt1WGxoVXF3aGVRR3N4QTFRdFhmdXVRMkVOanZUQjNnTTdxR2pLcUp2?=
 =?utf-8?B?OG1IQlMrN3pqUm1INWt0NFA2RUFBRHpuQmU0T2lOMWg2d2JsVHdTR3FWNnN3?=
 =?utf-8?B?cnJKdWpRYWxOdjBLOWJuS0Q2aGRCQ0RSVXF5bjVJRFRDb2NlQWU4eHFKQjVy?=
 =?utf-8?B?N1ZVRUFRWUdIRlpjOWExVXdsT1lOMXVWQ0NYeFgrbXNnS3JzWjFsSitRSTE5?=
 =?utf-8?B?K3ZrTVliS2o1U3NRZHpBZm82amh0UTZGbXhQa2w1eWpHUVhIOGI1a0lxZGU2?=
 =?utf-8?B?dWFwaTNHcU91SVVFMklBTElDcHBYVW9iSU9ZSzJzcVczdGpUNFA1VGQyN3lT?=
 =?utf-8?B?b3Yrb2RlS2g0akhvQ3RSeDBodkw1bTNjUkdVSXgwQnlMOTZmdWZ6SVF6Tnlh?=
 =?utf-8?B?OC90c1pTQURNbVp3UUdnTlk5WDlqeXplTFh5bnhZNUh2cHFmV01JenBhMUZk?=
 =?utf-8?B?WDJLUVM4ejBLVmJJRlQ2MzBwb01Tenl5TGNSVUhuV25qVmFnVkMycUp6cDNX?=
 =?utf-8?B?NUJpNG04bVM0bm5Ta2UwSlFjZ0s1U1FHYjB2dVFFYkZJdG1Zai9EZ2ZZOUwv?=
 =?utf-8?B?NFBxMm5mNDRGeFFSK0ZrajhsOThic3BtQjVEd3llckNZMUFhbDd2MktCaUNV?=
 =?utf-8?B?eU1rZ1lhMmsyS25JcEdkRU9qbUN6S1YyK3pnM1FON3JiZzlYNE1MelpVK28x?=
 =?utf-8?B?TkFBdWVLWFQ4TjVsNlA4Z3U3NFd6RUZJa0JDZE9rSlNWTzVJcmxCT3V0VTRz?=
 =?utf-8?Q?zEFFOa15OzCnL/Xh7bXagd7oo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fa4c68-5779-4e6d-f492-08dce15d4543
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:36:29.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ornTQ/M+jKjQw5lgcy6EkR6Bvn510MAHQr83SkWH3vfBJwo6qnfS835nbZGvxFc2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

Am 30.09.24 um 16:30 schrieb Sunil Khatri:
> acp_early_init is a dummy function and is not being
> used and hence removed.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index 08f5a8614356..8c85d7a9e0b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -585,11 +585,6 @@ static int acp_resume(void *handle)
>   	return 0;
>   }
>   
> -static int acp_early_init(struct amdgpu_ip_block *ip_block)
> -{
> -	return 0;
> -}
> -
>   static bool acp_is_idle(void *handle)
>   {
>   	return true;
> @@ -624,7 +619,7 @@ static int acp_set_powergating_state(void *handle,
>   
>   static const struct amd_ip_funcs acp_ip_funcs = {
>   	.name = "acp_ip",
> -	.early_init = acp_early_init,
> +	.early_init = NULL,
>   	.late_init = NULL,
>   	.sw_init = acp_sw_init,
>   	.sw_fini = acp_sw_fini,

