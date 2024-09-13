Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B36FA3722
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 07:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F99710EC9A;
	Fri, 13 Sep 2024 07:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1oKuEo8c";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C2310EC9A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 07:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6LRYMolEnALeN5PNyfAyNSasy3jdi+pogYVnpwhgR2f2vPqWHO+8a1V5oPn/0I1qkrwpfPTANOF0UYg9JMpMhnDIw0XDefTtR43hVfzSbTf+JczqfDNy2PUV6fEI+HPeFr0BxKuL0AxkS/BrUGDdvHnV7wv8PDWoEMGIq1Dx/1a0Vlayovdcgd39p2DwWjPWy47XffCawlZDw0ALm6vYwZoYZojnynf/1d+3RVoXhs0Hhodzc5up914hrI3oIIG7y6r5C8M0LhuGysm8ZYOArvbvR4Ww5uz3IwN09KXAkvJQjcuQ1zugINY8m+9RnXjXaOyE06yXe4G63nIDo7o/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb74dqvDtYEYENtAX4ooTC+cyHe3/FM0yltoouS9Z2g=;
 b=feY/MUVQxGC0lNRNfRJg0MZ/D35IxULVTaftUKFmnGxTLI576+vwEnTZfxT3XAGN7Fyx2AXY1vszI94TKOoMlOJ0MbJ7C6eXWJgOomnqH/TfObyEfYoOB2YNDWJCJawtXyEsrpaJx8pykW92XnZlwuiKrvE+UwQ8ihvFMnEHSPqj3gMjBjtDeW8LNJ7RxXWadT5AnmhtShC+/YfHW/xWKGTQux3jp9KZNKW7TwJWDYgMgvWBn3DAVcJWxxisjdRL9NxpEVSSiBqwmZDrCkEAUdIgxC7cR+oCazn7DZmpq/J+NUHLS941aaqw5VckOBJhUeliXt/SFbBGt8Pb5Wq/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb74dqvDtYEYENtAX4ooTC+cyHe3/FM0yltoouS9Z2g=;
 b=1oKuEo8cKP44g8rhahta2PD0axjfBb1IyDVsGJte0fK09ivaQxbwD3AECranLS4nxoucAWN8Hy1Qo/ZsUXgzjSwYoB/1glLr/n42PdktdwGmqLDTQ/zmjSsvV0GL8NdP1iDfA8KIcTQdbuBxHSf8w8YikOoV/Aet+y/Ifn/CUQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.21; Fri, 13 Sep 2024 07:21:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7939.025; Fri, 13 Sep 2024
 07:21:24 +0000
Message-ID: <d4f5a4ad-2fd3-41d7-95db-6de95c8d6782@amd.com>
Date: Fri, 13 Sep 2024 12:51:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/amd/pm: Use metrics 1_6
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 charis.poag@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com
References: <20240912115947.2208807-1-asad.kamal@amd.com>
 <20240912115947.2208807-5-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240912115947.2208807-5-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017E.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4e) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: fb668634-dd2c-4038-10f6-08dcd3c4acb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUZMclgrTjg2dkFIaWl0SDJvZmdpUGgrUHBnb0QzNWp5TGVxbXh4WkNicVc5?=
 =?utf-8?B?cU80VVBiQ2pheXJicnBLc3FqVmtsS1FHellsQU8yVkdRMkwzWmZmbXZGTjl0?=
 =?utf-8?B?NExKMFMyeEZmb090cm95UXd4NDlJSDBjWXdDZHVOY1kvMVJSQmduY2JhcVpX?=
 =?utf-8?B?OEdPN0duQytmYzdhYk51RG4xd1h1QU9PNHkyTDlIR0lha2F2eTVJWWV0V25a?=
 =?utf-8?B?TzltOGNZR3JoTTgyS2VIL0hVb0MyU2wyR1ROdGdMdDRhYmgvVHhiMm5qV2o1?=
 =?utf-8?B?YUNWOHFPRjJpNXlGK0xSVGRGQVdhWnczNk13dDUyWGxiMHF3OG5OMlNYcEhq?=
 =?utf-8?B?djZmck42TVJ4VGVadVpBZ01MNjdwRkZUdnRMUWdSYkM5bi80dzN0blpqQ3dk?=
 =?utf-8?B?TVQ1Tk5QdWxBRmlrS3dkODdwOFF1Zi9XQmdtOXQyaVVwa2UxRHk4alNlNWpi?=
 =?utf-8?B?dC8zaWVYaWtMNXlaaHlUMGpZTkdlT21UbjRKM0FpeDMzSE50dlkvMnRYUzJr?=
 =?utf-8?B?cVlwWldUWUp0R0pjWkZBM3VyUXJUSHdVRHpxNXhaQXFTVFQ0VmpSOU52UXZp?=
 =?utf-8?B?NEliZ2s4UkdBdll0cG1QM1dIMHMwaTk5ZzB0WXRUQkdKMWZxU1RxM0ZVRER2?=
 =?utf-8?B?MTlTU3RyZnB0UnNvQUVQbGFZd3RnNEhpNkIzdkRVd1NDdGVPbWpMblNJeEpX?=
 =?utf-8?B?Q0cxWS9lcEFoK0tna2cvQk5nNUY2UXhZSnZLSTZtRm90YnZjS09BL1BKTGdm?=
 =?utf-8?B?a1FtckRrZlNsTzRXWTd4L0hQcXJJQW92b1pJaFA0K3BGdHkwYzNxVTF0ajNH?=
 =?utf-8?B?RlNBRFJUQU4yMDRXRTFLZHV6aFdUblErZUd4elJKS3I2NFl6c2NvNFBnWHQ2?=
 =?utf-8?B?WXpDTHdIblcrbGRQSWxkd01pc0lhQ1ZGbVhTbG9FV1dCTklUclpsRUtRT1Z6?=
 =?utf-8?B?eDQ5UVcyc0FOcU16ZGx2RmQ3NjJvejd1aHlQQXNwZ1hRZ0JDZTQ3ZmV6RmU5?=
 =?utf-8?B?T0p0U0FOZURhUFhlYm1tcVVTd2t3MFp5WDh2WUcxVFJWcEV2TzQrV3JSMTNh?=
 =?utf-8?B?Z2EwV1pDdGpkSGZqa2pFM3JkQUUzL2xxZ0ZxM3BkV2hESlRtdmdiN2t5T0F2?=
 =?utf-8?B?R0E5eWo2S3RtOTZPZ0RwTVZlWFp2NjBEU3VsUi82Rk80dlhQRm1jTHdSV3VZ?=
 =?utf-8?B?QWUzY3dxcXl2bXdTOWZCajFSbzZlNXpHYW5EQXRwMGVmRm16Y0huUUl4M2Nx?=
 =?utf-8?B?WHpRbXo3bXZNdVdpMVRJUkM5SmhhcmYzbE9KcmFPa2xDeXY4KzJNcFlVMG5M?=
 =?utf-8?B?cFVLSVRjeWtrTFNJcUF0STByTzU0dHZ1dlVFQ0RlUWNTL3BEaFZWK1FWR1Bp?=
 =?utf-8?B?d3dOclpsVkpTb3g4d21WaTFIaXdvR1lXbHRxaU9BeGJ3TERSejE1bnRCSG5S?=
 =?utf-8?B?U2NRSGNqdlozMDJ2VndKc1VQL1paaWJBNmhVUGpGYlhhN3FxYW9ibXJHUHk0?=
 =?utf-8?B?azlPYWdPODdrKzcrN0NIQzdJckhzTW9QcVhnMXN5VmZleHdTTlp3RUtWNHU3?=
 =?utf-8?B?QUhncnIycEdPWEljRncxK29YdFRiMDA0amhraU9ML240OTl6ZVJKSjBXZTZF?=
 =?utf-8?B?THpxenpBWE9XRmJoa3NhUW5lMmN0RzIvQUxyalZjZ2RNaWdSejJYWE1JWnFv?=
 =?utf-8?B?YkJqVE4zT1lUTFM1cnNlUEJVeHRmQ3pmcmxUU2tnNC9JdmRuZlRoYUpRL3JG?=
 =?utf-8?B?cThFaG1DeWxlWWFyQU82ekxnNitPd0NJMi9qams5cGIxNk4zUDluTlgycDls?=
 =?utf-8?B?NnpSNmJ4OVdzN3V0eHVBZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVZcUVPUld6bkdSdFJpWWNlNk5QeDBVTStaZS9sZ0Z1VW10NDhWc1JYSE5v?=
 =?utf-8?B?VlJNNEpBNnRvUlJ3bHZycHhKUzBqbEoyZUU5NURkSU40aHRjTFQ5eHNzT0kr?=
 =?utf-8?B?amFJQUVxeEhESy9rZFFlRmsweDVObXZyYndvQ1RheXZMdzdLeFk0SFlIM3Rp?=
 =?utf-8?B?YWZ3akc5MnNvb1lKWVc4dXRBL2tRNFM4a3NEV24vdXhGY3BYVmhBRlVFaDI0?=
 =?utf-8?B?eFdVdDFNY0pkOTRQdVVmamVqQldlS2JCN2dUNU1UaTlicjVadWRCelZjMWJK?=
 =?utf-8?B?YXY3RmpJTDVBazJwVlZlamtVT0ZZSzhkUkFxQzJGNEh6OFlUM2Jud3pZT1NQ?=
 =?utf-8?B?cWliMU9xZitud2owL2lzejFsYTZpYi9oRjZhYUpRbEk0d0lQTllSM2oxK1I5?=
 =?utf-8?B?V3NUd1g3M002a0tzNG9OY3lCSlFTekxqdlZLTlhLZmh2N1JRNGpPbWoyWmdM?=
 =?utf-8?B?WDJtNTB2N1h4MkMxMmF3dGdpWXVnalJBYy95SFVXVW5SQjRXOUJpS0NGcWs3?=
 =?utf-8?B?Z3c4RG1OR2RHakVNdlRXMHVWSGVVWTExemFFTDMyQnhrcmlrWGIzVnVVMW5V?=
 =?utf-8?B?ZFJLRTdiWWpjbmJHdEVoZmsrbWlEbHNYa0xsYmNZVU9Hck1ZVDBJQ3ZFSHh6?=
 =?utf-8?B?aDhRT3IyQzA0NFFTUnFvNXZoWHVtSkowK2wwUkd3TG1uRWVjOHRtdTBFdzhD?=
 =?utf-8?B?QzdKSGxJWjI3MnhlWjdwM3pvMjQrcHo1V2lWQWFHOTZybjVDQXNpdW1ROFdm?=
 =?utf-8?B?aklzRjErZXVUdTI2Rk5IUHlsVHBuVjBxK3lMajR1NW45V0szc0lBelh3SmZD?=
 =?utf-8?B?V3hEN25WeWx2NEVlVW5jTWNKMlE5VGtjQjEyQzB0ZGZBTDE5RjlDTFREYzYv?=
 =?utf-8?B?RzBxRDRudW9Zd01tOGNCQnUvQUl6ZTI3dUVBNWFxcnowRmlOL3BLZE5IZzIw?=
 =?utf-8?B?cXBscUFiZFQ0b21DcjRoUld2NFF6YXNaNGk1U2N1MlVLbVBHb2x1b25ha1dG?=
 =?utf-8?B?SlRad1dWVGM3cFMvMlJ4cElZZ1NpaFYzaE94OG95VTNnUzZtalF1elFPdnB5?=
 =?utf-8?B?SzMwWWcxMzd0b1owODJ0V01FRU9pcFh3RzNjbXZjS04vUGE5aDVIa3Z2Tm8z?=
 =?utf-8?B?TWxLU3NvNmg2aThGOWJKaFJkQThYTXhoYjBTb1ZJNmdhbGdSUlVmWmljblF5?=
 =?utf-8?B?VUlrQXZHZi9ueWJjeXV3ZTZKdzdVU2hQdVd0NU9qTzYwalJiVDRNSkVxZFFT?=
 =?utf-8?B?UkJVemVtZjgwVWRkS3VmbEdPS1Q5SWNGSjRmS2RueU5JbGRoM3BOWDBTSk9r?=
 =?utf-8?B?VmtubXdIY214VkVpblU0R3ZObC9OSm15Qk1Bbm8yRU9KN0RFUzN6V2V2RnFO?=
 =?utf-8?B?a0dXeFM5bzhZNUVPcHdQbkcvMVNhOGlLb0JYVDgzT3RoUElCMVh4cUczUkFr?=
 =?utf-8?B?VGt1ZkdUM2E4eksxc25jN2s0QUczT05wZkMrU2V1TXd2SUswUWJ3eWVOTUYx?=
 =?utf-8?B?bzhoMVZ2T1RYMFkvMkdGT3o0VnJDbm1vWjNxTVA2M3Jwblk0cHh6T2l1TVV1?=
 =?utf-8?B?Ty9xZWR2RGlQZ0FaZlhhV3hWOXlSYWl5aDZlbHBVQ3RQK01vdXJ3NWF0bE1B?=
 =?utf-8?B?dXR4N3FHcUpBMFNPSTFDbXhSZzhqSldIUG81YlhpVmc1VTZtU1NnNVJnS3g4?=
 =?utf-8?B?WDZYeUFOZ3pLd1FHa1ppelhrZFpPNTRXZUJrYlpueS80d1dWSkJXV1Z1VXRv?=
 =?utf-8?B?Y0pEZnZ6cytIVzB2WHcxQjY1RmJyMWF0MzBnZmM5RWlnODFMa1Z5SUZNQW1v?=
 =?utf-8?B?OG0vQVJWMmdMZzgvRkRLVWRpK3libXlvWVZHT1dCWXhCczQwZFV0TTRtQndx?=
 =?utf-8?B?d2xLekZCYW81S25RRExuSlhlalIwZGc0VlB6VjRXaEpBUmpxa3c3TEwvMnRC?=
 =?utf-8?B?RUE4bzNiVUI5clZ4RE14cloyaFdTQVBVVlFTL3RZaHlldzhnZ2M1UG5xMUsv?=
 =?utf-8?B?M3dBMHMwbFprK2JDQ2k4RVR2TEsya2dka1dwenZUdk5NZ2w4dHRCakpGdzVB?=
 =?utf-8?B?eE5Ob3F5QUZ1eU5jZmFzc0JTa0F1SllpQWpwY05kT3REZWJ6a1lnZ3NnVWZK?=
 =?utf-8?Q?uedljY2uE4+AQzAqYoL4pNfGl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb668634-dd2c-4038-10f6-08dcd3c4acb2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:21:24.7517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJYQKZXoUkTr+Rv6RC8/TeSymwiVRyt65T6IY3QIWL70NjOsEA8ssdlZgAGz1CbQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967
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



On 9/12/2024 5:29 PM, Asad Kamal wrote:
> Use metrics 1_6 to report activities per partition
> 
> v2: Use separate per instance for different platforms, shared
> vcn handled by other fix
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 78 ++++++++++++++-----
>  1 file changed, 60 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index ee178914ca53..cd739f627df0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -358,7 +358,7 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
>  		return -ENOMEM;
>  	smu_table->metrics_time = 0;
>  
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_5);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_6);
>  	smu_table->gpu_metrics_table =
>  		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>  	if (!smu_table->gpu_metrics_table) {
> @@ -2302,15 +2302,18 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>  
>  static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
>  {
> +	bool per_inst, smu_13_0_6_per_inst, smu_13_0_14_per_inst, apu_per_inst;
>  	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_5 *gpu_metrics =
> -		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_6 *gpu_metrics =
> +		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
>  	bool flag = smu_v13_0_6_is_unified_metrics(smu);
> +	int ret = 0, xcc_id, inst, i, j, k, idx;
>  	struct amdgpu_device *adev = smu->adev;
> -	int ret = 0, xcc_id, inst, i, j;
>  	MetricsTableX_t *metrics_x;
>  	MetricsTableA_t *metrics_a;
> +	struct amdgpu_xcp *xcp;
>  	u16 link_width_level;
> +	u32 inst_mask;
>  
>  	metrics_x = kzalloc(max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)), GFP_KERNEL);
>  	ret = smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
> @@ -2321,7 +2324,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  
>  	metrics_a = (MetricsTableA_t *)metrics_x;
>  
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
>  
>  	gpu_metrics->temperature_hotspot =
>  		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));
> @@ -2363,8 +2366,15 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  
>  	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
>  
> -	/* Throttle status is not reported through metrics now */
> -	gpu_metrics->throttle_status = 0;
> +	/* Total accumulated cycle counter */
> +	gpu_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, flag);
> +
> +	/* Accumulated throttler residencies */
> +	gpu_metrics->prochot_residency_acc = GET_METRIC_FIELD(ProchotResidencyAcc, flag);
> +	gpu_metrics->ppt_residency_acc = GET_METRIC_FIELD(PptResidencyAcc, flag);
> +	gpu_metrics->socket_thm_residency_acc = GET_METRIC_FIELD(SocketThmResidencyAcc, flag);
> +	gpu_metrics->vr_thm_residency_acc = GET_METRIC_FIELD(VrThmResidencyAcc, flag);
> +	gpu_metrics->hbm_thm_residency_acc = GET_METRIC_FIELD(HbmThmResidencyAcc, flag);
>  
>  	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
>  	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak, flag) >> GET_INST(GC, 0);
> @@ -2419,19 +2429,51 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, flag)[i]);
>  	}
>  
> -	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -		inst = GET_INST(JPEG, i);
> -		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> -			gpu_metrics->jpeg_activity[(i * adev->jpeg.num_jpeg_rings) + j] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
> -				[(inst * adev->jpeg.num_jpeg_rings) + j]);
> +	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
> +
> +	apu_per_inst = (adev->flags & AMD_IS_APU) && (smu->smc_fw_version >= 0x04556A00);
> +	smu_13_0_6_per_inst = !(adev->flags & AMD_IS_APU) &&
> +				(amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
> +				 == IP_VERSION(13, 0, 6)) &&
> +				(smu->smc_fw_version >= 0x556F00);
> +	smu_13_0_14_per_inst = !(adev->flags & AMD_IS_APU) &&
> +				(amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
> +				 == IP_VERSION(13, 0, 14)) &&
> +				(smu->smc_fw_version >= 0x05550B00);
> +
> +	per_inst = apu_per_inst || smu_13_0_6_per_inst || smu_13_0_14_per_inst;
> +
> +	for_each_xcp(adev->xcp_mgr, xcp, i) {
> +		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
> +		idx = 0;
> +		for_each_inst(k, inst_mask) {
> +			/* Both JPEG and VCN has same instances */
> +			inst = GET_INST(VCN, k);
> +
> +			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> +				gpu_metrics->xcp_stats[i].jpeg_busy
> +					[(idx * adev->jpeg.num_jpeg_rings) + j] =
> +					SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
> +							[(inst * adev->jpeg.num_jpeg_rings) + j]);
> +			}
> +			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
> +			       SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
> +			idx++;
> +
>  		}
> -	}
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		inst = GET_INST(VCN, i);
> -		gpu_metrics->vcn_activity[i] =
> -			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
> +		if (per_inst) {
> +			amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
> +			idx = 0;
> +			for_each_inst(k, inst_mask) {
> +				inst = GET_INST(GC, k);
> +				gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
> +					SMUQ10_ROUND(metrics_x->GfxBusy[inst]);
> +				gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
> +					SMUQ10_ROUND(metrics_x->GfxBusyAcc[inst]);
> +				idx++;
> +			}
> +		}
>  	}
>  
>  	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, flag));
