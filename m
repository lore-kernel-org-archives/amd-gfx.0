Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75DCFA3722
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 07:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DE510EC93;
	Fri, 13 Sep 2024 07:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FFAX25CP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539CB10EC93
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 07:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llh0eqZERStg3Osa3I9U4nJN5WtDcCJpnDwuBtgAEQFjy0KVJIwaXg+UfY6dbDb0swrd5GPAgIQlI/9fFlyHM2s5awpNSbyArVJVOdWyrMKqignXNs7hVoWiodIJF9QibXy3yh3XGgF5T2hq/+yK3//c6Dg3GqBZs937SsnBNaWnYiw8yALSxUq2/k5Ul14O4+71acogsst4LiimyrR9OGdZYhnjJNTcYV8x4SGKgm9C1muPJmoFCUys7x+R1C1CD2RXyJiAR9DtoIuaajhtNxSAW8nq0IOIM+WYZ+y8IBSkykSHJfsgDO8txsrThSSZdahoUeFiJlnRZ/vQoAmv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgisORJ+JOUUpOKNTqmAddLG0+p4+eugrm/TLUPxJU8=;
 b=ky7SUBbyb/mN3bz/8SEdq1KR6OU80clChuoDTJs++hvTmq0mGq8aesYosKRU9M0sWMMQE0Kj2sQZxOUbuINmGPrrQrU1OjDsBfk0kGwR9tsJ8bmSlQeIwZ5KSQne5Kexd+oJol3Wcs/nROCQ9y/MsJso7eWqIpq02nZ1mVk84i1eGLTUb/5CcGCaBDVoRBDaXfxT+5VU65wHprcuD/6wvV+lvzv5YS51zdNUZGhk/jGH8xVVtAxAZgTAC7u/5Te4uGALOxAQhCXHaxQdVCd3b8fnd/VDNd6fLJguPjA7t7sNHBFIKBIcL+T+bow3pCwmdJpP3aSKcDWNitgG5KsEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgisORJ+JOUUpOKNTqmAddLG0+p4+eugrm/TLUPxJU8=;
 b=FFAX25CPaJ55CchdOyqTh0fdQKEBAb6TM1ocyim4BuRCvEqNFDrUqnebJcgQD5T07369Ns9TxPdQb5ZbBCq+oAWvZiy4KSFWrMNG+HQqr6YSDbr8jegz/5agF0AHWCRECC/lhf5mq/Fg3f2Geu95jR3HeBeL02fWoVjGXDW7dVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.21; Fri, 13 Sep 2024 07:16:43 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7939.025; Fri, 13 Sep 2024
 07:16:43 +0000
Message-ID: <060f9308-8316-427d-8fe6-850d8ad520c5@amd.com>
Date: Fri, 13 Sep 2024 12:46:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm/amd/pm: Use same metric table for APU
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: le.ma@amd.com, hawking.zhang@amd.com, shiwu.zhang@amd.com,
 charis.poag@amd.com, donald.cheung@amd.com, sepehr.khatir@amd.com,
 daniel.oliveira@amd.com
References: <20240912115947.2208807-1-asad.kamal@amd.com>
 <20240912115947.2208807-2-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240912115947.2208807-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 435bc735-30d3-4be0-14a8-08dcd3c404cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkRBbmZCcVFwY1JaT21mRHpLTStNNEhpVE9hZ1Fnemk5UGVvV3Y3TURRRURw?=
 =?utf-8?B?TGc0OFpMaytKSzVpWmpMcFN5enNQMHBmUENSaFZTeFhFUFJxT3lXV0VVbDdN?=
 =?utf-8?B?QlU3WENHajdpeW5MTHlrV0pEQ25HMmFLL2NFNm1TN3JpVW5kWlhnS21kQjM5?=
 =?utf-8?B?RkJoRkRoTEpBQ0N1ZHdTQmVURGZqakhTYWtnZHpXMGF0VDhrV0hUL2orY01E?=
 =?utf-8?B?bkg2WWhXUSs0MjIxRC9ET2NNRnJIU2tMdDcvSXFheHZGSTJEWVF0MEtVYUZC?=
 =?utf-8?B?cDRyb2l2L0UxdHhITFpkZlR2c3R4VStLa24wdmRuQjAzR2l4UmcrdFVabHVW?=
 =?utf-8?B?UlR6ZHJGRCtReXl1RHdtY2poclFueW1tL09vU1dzUVZoWkdMSWpISkNNdjI1?=
 =?utf-8?B?cWFDZ0psQ0pFMENvYWZMTjdKY215N0RSOWVBOXlZbWQrNzBXT2Nrd1R6NGh0?=
 =?utf-8?B?b044VkxFMG93cDlkVjBNTmZ0TnQwZ3hNSm1INU9ScTM2OWwwLy9XV2JuZ0Vw?=
 =?utf-8?B?d2paSlkvcWlOU2NmRUVIZXJZeHpKTXJScmJBS1dXY3pxMGpBaTZxN3RsMkFV?=
 =?utf-8?B?anFPbU5tNDI0M0JTY3I5eXJuUVlKZG81RWQxdXVxNnlIQkk1WHNOcEFGTU0z?=
 =?utf-8?B?RVlENExKZWRBU2s4MzAwQkk1czVDMUhHcWFKLzc0VnVYdkc3blBqVllQUlBi?=
 =?utf-8?B?dnZpOExzM3lmYmMyVzNLOFRrSjdlc09lQzE2SVZZSG1HbGpqRzRwOWZTSlVv?=
 =?utf-8?B?eXdaaVRkZTB2RXhlM3lROE9qcHk5UnhVeEpHaE9rMElMVWlHYWZoZ2I5Ulhp?=
 =?utf-8?B?QU1kSytVOFRTb2JnSHpHUm1NY3NvL05GMnFrd1hkSW5IOXFYMXIyOE1VTzhM?=
 =?utf-8?B?QWhDQm5qZ0E4NkxYbVlzamZxaDJQaFZEUFJPcDRoUWtNdjF3ZHh0c2tya2pP?=
 =?utf-8?B?L2FQNkVlWm1EcnJPRFZOSlhwUGJwY24wY3NPNTBEMHhTVHRKR3R0YmNvK3Rr?=
 =?utf-8?B?RjRTQjIwM0w4bjdvY1EzRHFVUk12VEVOMVlYaUxRY0pSM1ZZUVA0dHhneEYv?=
 =?utf-8?B?L0h1aVkzSTNndDZRNHdDMlNrS1FDUUpjUkFLejBQaFc0M0hSakZKaHo2VWFJ?=
 =?utf-8?B?V3dsZ3RUWEdQRTJ3M1JUSUpLdHFEanN0dWY3cDUvS3ZlTHdGRk5CR1FzcDRo?=
 =?utf-8?B?aFB4TmVGd3dFeWhLVCtTZDdST3Q1ZGpDSFJ6T3RRL0JTaWNUNlhkUGRSdFpu?=
 =?utf-8?B?VEROZVFrcmw3OWNxZ240dW1SZUZzaTN6TjNxT1NJNVFYbUVpc3NKK1FTMTIx?=
 =?utf-8?B?M2pYWG9Db3hHNkc2K1dFSTV4Q3dpd1YzN0UxRWEwMHBtb1NOcHZoVGY4WVFD?=
 =?utf-8?B?S1BrdUthVHZQeUh2bitWQXg1Ny85aTdXTS9nY3VsT1YzdFRzdXZBb0hWeXpx?=
 =?utf-8?B?WGVGR2V5TWxTOXFQSk84NVpqQlg5SWI1aTFMUHpRQVhiYjNJRDkwc1UvSm5i?=
 =?utf-8?B?UkJScHFhNXNlYjBCejhRcWI2UjFDekdYYVltUEw0TXk1Y1lkUzBGQVhJSmw5?=
 =?utf-8?B?WE8wZGFEMGhPcjdnNmUyd3BVamRWOUgxdkZINDFsd3NYK3krOG1ONVhWdWJS?=
 =?utf-8?B?QTZHaE5VcVVTZ3A3YkVJd0pWK1YvTy9yZytZTjhKemdDQkVjVkdiOHBMRjhZ?=
 =?utf-8?B?NkIzTkhxY2hsR2hNbFBuR3JmaUtZMnJwbDB6Sm5hYTdyKzNpdTI0a2hkY25t?=
 =?utf-8?B?U2s1Z1MxNjllQXJBWlp1cU03cEZYVWZMTFNadkp0M3ZPR0RkczRJQXExOUEz?=
 =?utf-8?B?YVZDdkVJclhoZFZtS1BVZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9jSDRuMExCRVhzUTZJazNEVWt6TzgwdEdwam1MR1FRS1R1SmxFRjJxY2ln?=
 =?utf-8?B?SG5Wc3F0VjRUUTFxcFB2c2JjY2s1T1VzU0RGd2NOcVgwbmROc21PNFRqV08z?=
 =?utf-8?B?djhtS3M4WGZQREtWZXl6dS9KbHBHZ05HVk1NcnpqelFyY3h3dWpWNHBvdjFJ?=
 =?utf-8?B?WVQ5VHJ4VCtMOVY0em81dnFUck84dWxCUDE5UlhiYkhXeDY1UWRETGtVY2gv?=
 =?utf-8?B?MDlBeE5MNEYvU2NFdjZXaWQzQ09kTG00N1AraUNtKzlHUFI3dHZHTzdVU094?=
 =?utf-8?B?N0FBcUprdjk3WjU4N3FiczF1Yms5aXZhUDFTVHlmc1FDWkJmZkVtdDR6UHJI?=
 =?utf-8?B?WGdDZlNTWUdSb2tWZjNYdURGa1lOV1R6VnQ5eU1tb2dhSGh2em1Mczl6b2NX?=
 =?utf-8?B?WE42RW1QTUVFcmQySUhFK0NHUWs0MEIycFQ0SnVGazBOUWdzZkFkaktsQi8y?=
 =?utf-8?B?bGR3YXFaSDBHYnRLUnh1WXVzWU9UaWZnWmJnenZieUpEL2thNUp1eUdDbDdL?=
 =?utf-8?B?NXFNSVRHQWx0SWFTRnpYTXZHSkZsNDF1TlJheFFXeVdzSEFTOVkwWGNRNlMr?=
 =?utf-8?B?Tk1BVTRWYUs3Z1dSRGU1TjdubkRoR05RUHdJS0ZMZ3FEdHJsQ3M1dDk2MWo0?=
 =?utf-8?B?ZVMwU0pncHVGK2hubXlqaXEvQnNMckxtR1RnRVovNnl3Qml1dUloMjl5TFZ1?=
 =?utf-8?B?YVpkYWFTWkY5ZGdOL096eEg3TlYrTXN3eU5EREpCMy9DV2JEbkdXYThvQlBO?=
 =?utf-8?B?MDBqK2gxdk9vSVBTRkF0QmJOZFBwa1dGeHZwb0M4Z0tIbTF5d1MrdW5ZKzRP?=
 =?utf-8?B?eWppc2xOYkRxT3MrUVprbmxhY3pNSnNubDMxU0JDbm5laUNIc0w0ck9wbXBl?=
 =?utf-8?B?eWJmM2h4MXh0U3Riem5sVlJXUm5iWFNDTjN4Z0dqTmhPTTJRY0NtamxDUUhC?=
 =?utf-8?B?K2ZNZFZMWUVIRWEwTVJGTWQ2TGxGdXI0NmYzdVdZZmI4aUVGVmlqcFlsQ09Y?=
 =?utf-8?B?ZTBGS2hNVkhnQmMrWXhIY0ZPV3lHSjRGK0gvenlVa3RxS1NnTWZYVm1OMUxM?=
 =?utf-8?B?dStlc1pTV2hMZ1Y2b2FCRjVhMmIreTVXaVFhVloyNTJCKzdwNUpwcGpnNVAw?=
 =?utf-8?B?WnZucERKWm41L0d6REhMS3dtOHVvSnBkdE9MR0QzUFBoU3lYOFZBUktUbjNh?=
 =?utf-8?B?anhuTVEvendFVW1Jb2tiK0ZhOStIcUFtOHFybnJpREpJaHlYNFAzVUwxdVVy?=
 =?utf-8?B?M3prTVoxNTJRam41aFVQK2VuM1pieFNYZnhZR0x0Nk16VjdLL3JJNm12aHVh?=
 =?utf-8?B?ekVoUzhzRmY1UEtsbTBPSU0zMS9KOS95VWlMTFZCZWlyNEk0bU1xTXdNVGtP?=
 =?utf-8?B?UDNyb1Q2bmlyd1F5b2kwdDVVaTZoTHp0MS9KTmpNUkNPTWRscTNqNXNtZ2R1?=
 =?utf-8?B?eEdpUVk2bkNtb0Y2bklCY0FLVi9VanpRN1pzVWZyK21jbnM4SGJkTmt0bFBX?=
 =?utf-8?B?NEZPYi8wZXp4ZDRVQ2VtTnZGSDIxclVMdGFaa2dtN1d1WWVtZnVBT1NuRzJt?=
 =?utf-8?B?M3lmb01oUDhiaFhVQUNnRnUyR1NyeE5ZWnVONThZS2hiWHFpbmR1VXRNbEFV?=
 =?utf-8?B?OTNUTFV1cDlsa2V6N2VqTktwRm1SWXBTL0ZsejJRWS9vSU5LMDZSYWhxVGhr?=
 =?utf-8?B?MkptUDA3bTV3V0R1bFJkZ0pSbk1QVlhuSWhyS2JlQkxXK3FETys0dEFSTUVr?=
 =?utf-8?B?YWQ3Uit3VU8xRHVuRFlHS3JacHgwLzc0dW0wV1IwZVRzM3QwaE5rcUNycm1k?=
 =?utf-8?B?Y0p4UVBXN0FFVjJQQWsvWGZXT3hNWGRGZ3YwYTlIUzBLVUZiRzNxMkJQOCtQ?=
 =?utf-8?B?UENZWnZkcUpDazhwaEcwR1kvcFoxYUxMaWdPdVBSV053elEvS0trZU9iUzNP?=
 =?utf-8?B?cjJvamsrM1lGTkhPMlF0TytaQys5bGFaUERhcDJzdFFpVUkwVmJiakJGS0JF?=
 =?utf-8?B?RHM0aG04d2RwTXlNRng3bDBReXRPeHF2ZFg2Vzh1c0FEVExRQ2x6TTFnMzJp?=
 =?utf-8?B?ajJENVk2bUVBQkR6alJ5QVN4WWxLeGFTOEJlWUQza05FdXphZm4wWmFHTG1j?=
 =?utf-8?Q?6WgDnlB+ZyxNnIKzcai+XcR64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435bc735-30d3-4be0-14a8-08dcd3c404cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 07:16:43.0796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mc9PTVGo/vf9/xTWbJsR1RMpty5olEiiFmOGpr3npp1NMgUsZtKz9E0XSWAD7vBk
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
> Use same metric table for APU and Non APU systems
> for smu_v_13_0_6 to get metric data based on newer pmfw
> versions
> 
> v2: Use inline func to check for ubified metrics support
> 

Typo -ubified  => unified

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 102 ++++++++++--------
>  1 file changed, 55 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 9974c9f8135e..ee178914ca53 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -102,6 +102,12 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
>  #define MCA_BANK_IPID(_ip, _hwid, _type) \
>  	[AMDGPU_MCA_IP_##_ip] = { .hwid = _hwid, .mcatype = _type, }
>  
> +static inline bool smu_v13_0_6_is_unified_metrics(struct smu_context *smu)
> +{
> +	return (smu->adev->flags & AMD_IS_APU) &&
> +		smu->smc_fw_version <= 0x4556900;
> +}
> +
>  struct mca_bank_ipid {
>  	enum amdgpu_mca_ip ip;
>  	uint16_t hwid;
> @@ -253,7 +259,7 @@ struct PPTable_t {
>  #define SMUQ10_TO_UINT(x) ((x) >> 10)
>  #define SMUQ10_FRAC(x) ((x) & 0x3ff)
>  #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
> -#define GET_METRIC_FIELD(field) ((adev->flags & AMD_IS_APU) ?\
> +#define GET_METRIC_FIELD(field, flag) ((flag) ?\
>  		(metrics_a->field) : (metrics_x->field))
>  
>  struct smu_v13_0_6_dpm_map {
> @@ -583,7 +589,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
>  	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
>  	struct PPTable_t *pptable =
>  		(struct PPTable_t *)smu_table->driver_pptable;
> -	struct amdgpu_device *adev = smu->adev;
> +	bool flag = smu_v13_0_6_is_unified_metrics(smu);
>  	int ret, i, retry = 100;
>  	uint32_t table_version;
>  
> @@ -595,7 +601,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
>  				return ret;
>  
>  			/* Ensure that metrics have been updated */
> -			if (GET_METRIC_FIELD(AccumulationCounter))
> +			if (GET_METRIC_FIELD(AccumulationCounter, flag))
>  				break;
>  
>  			usleep_range(1000, 1100);
> @@ -612,29 +618,29 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
>  			table_version;
>  
>  		pptable->MaxSocketPowerLimit =
> -			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit));
> +			SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketPowerLimit, flag));
>  		pptable->MaxGfxclkFrequency =
> -			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency));
> +			SMUQ10_ROUND(GET_METRIC_FIELD(MaxGfxclkFrequency, flag));
>  		pptable->MinGfxclkFrequency =
> -			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency));
> +			SMUQ10_ROUND(GET_METRIC_FIELD(MinGfxclkFrequency, flag));
>  
>  		for (i = 0; i < 4; ++i) {
>  			pptable->FclkFrequencyTable[i] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable)[i]);
> +				SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequencyTable, flag)[i]);
>  			pptable->UclkFrequencyTable[i] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable)[i]);
> +				SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequencyTable, flag)[i]);
>  			pptable->SocclkFrequencyTable[i] = SMUQ10_ROUND(
> -				GET_METRIC_FIELD(SocclkFrequencyTable)[i]);
> +				GET_METRIC_FIELD(SocclkFrequencyTable, flag)[i]);
>  			pptable->VclkFrequencyTable[i] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable)[i]);
> +				SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequencyTable, flag)[i]);
>  			pptable->DclkFrequencyTable[i] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable)[i]);
> +				SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequencyTable, flag)[i]);
>  			pptable->LclkFrequencyTable[i] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable)[i]);
> +				SMUQ10_ROUND(GET_METRIC_FIELD(LclkFrequencyTable, flag)[i]);
>  		}
>  
>  		/* use AID0 serial number by default */
> -		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID)[0];
> +		pptable->PublicSerialNumber_AID = GET_METRIC_FIELD(PublicSerialNumber_AID, flag)[0];
>  
>  		pptable->Init = true;
>  	}
> @@ -957,6 +963,7 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
>  	struct smu_table_context *smu_table = &smu->smu_table;
>  	MetricsTableX_t *metrics_x = (MetricsTableX_t *)smu_table->metrics_table;
>  	MetricsTableA_t *metrics_a = (MetricsTableA_t *)smu_table->metrics_table;
> +	bool flag = smu_v13_0_6_is_unified_metrics(smu);
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0;
>  	int xcc_id;
> @@ -971,50 +978,50 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
>  	case METRICS_AVERAGE_GFXCLK:
>  		if (smu->smc_fw_version >= 0x552F00) {
>  			xcc_id = GET_INST(GC, 0);
> -			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
> +			*value = SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
>  		} else {
>  			*value = 0;
>  		}
>  		break;
>  	case METRICS_CURR_SOCCLK:
>  	case METRICS_AVERAGE_SOCCLK:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[0]);
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[0]);
>  		break;
>  	case METRICS_CURR_UCLK:
>  	case METRICS_AVERAGE_UCLK:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
>  		break;
>  	case METRICS_CURR_VCLK:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[0]);
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[0]);
>  		break;
>  	case METRICS_CURR_DCLK:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[0]);
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[0]);
>  		break;
>  	case METRICS_CURR_FCLK:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency));
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(FclkFrequency, flag));
>  		break;
>  	case METRICS_AVERAGE_GFXACTIVITY:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
>  		break;
>  	case METRICS_AVERAGE_MEMACTIVITY:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
>  		break;
>  	case METRICS_CURR_SOCKETPOWER:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower)) << 8;
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag)) << 8;
>  		break;
>  	case METRICS_TEMPERATURE_HOTSPOT:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature)) *
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag)) *
>  			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	case METRICS_TEMPERATURE_MEM:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature)) *
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag)) *
>  			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	/* This is the max of all VRs and not just SOC VR.
>  	 * No need to define another data type for the same.
>  	 */
>  	case METRICS_TEMPERATURE_VRSOC:
> -		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature)) *
> +		*value = SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag)) *
>  			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>  		break;
>  	default:
> @@ -2298,6 +2305,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	struct smu_table_context *smu_table = &smu->smu_table;
>  	struct gpu_metrics_v1_5 *gpu_metrics =
>  		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
> +	bool flag = smu_v13_0_6_is_unified_metrics(smu);
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0, xcc_id, inst, i, j;
>  	MetricsTableX_t *metrics_x;
> @@ -2316,50 +2324,50 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 5);
>  
>  	gpu_metrics->temperature_hotspot =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, flag));
>  	/* Individual HBM stack temperature is not reported */
>  	gpu_metrics->temperature_mem =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, flag));
>  	/* Reports max temperature of all voltage rails */
>  	gpu_metrics->temperature_vrsoc =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, flag));
>  
>  	gpu_metrics->average_gfx_activity =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusy, flag));
>  	gpu_metrics->average_umc_activity =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, flag));
>  
>  	gpu_metrics->curr_socket_power =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, flag));
>  	/* Energy counter reported in 15.259uJ (2^-16) units */
> -	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc);
> +	gpu_metrics->energy_accumulator = GET_METRIC_FIELD(SocketEnergyAcc, flag);
>  
>  	for (i = 0; i < MAX_GFX_CLKS; i++) {
>  		xcc_id = GET_INST(GC, i);
>  		if (xcc_id >= 0)
>  			gpu_metrics->current_gfxclk[i] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency)[xcc_id]);
> +				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency, flag)[xcc_id]);
>  
>  		if (i < MAX_CLKS) {
>  			gpu_metrics->current_socclk[i] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency)[i]);
> +				SMUQ10_ROUND(GET_METRIC_FIELD(SocclkFrequency, flag)[i]);
>  			inst = GET_INST(VCN, i);
>  			if (inst >= 0) {
>  				gpu_metrics->current_vclk0[i] =
> -					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency)[inst]);
> +					SMUQ10_ROUND(GET_METRIC_FIELD(VclkFrequency, flag)[inst]);
>  				gpu_metrics->current_dclk0[i] =
> -					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency)[inst]);
> +					SMUQ10_ROUND(GET_METRIC_FIELD(DclkFrequency, flag)[inst]);
>  			}
>  		}
>  	}
>  
> -	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency));
> +	gpu_metrics->current_uclk = SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, flag));
>  
>  	/* Throttle status is not reported through metrics now */
>  	gpu_metrics->throttle_status = 0;
>  
>  	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
> -	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
> +	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak, flag) >> GET_INST(GC, 0);
>  
>  	if (!(adev->flags & AMD_IS_APU)) {
>  		/*Check smu version, PCIE link speed and width will be reported from pmfw metric
> @@ -2400,22 +2408,22 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>  
>  	gpu_metrics->gfx_activity_acc =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(SocketGfxBusyAcc, flag));
>  	gpu_metrics->mem_activity_acc =
> -		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc));
> +		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc, flag));
>  
>  	for (i = 0; i < NUM_XGMI_LINKS; i++) {
>  		gpu_metrics->xgmi_read_data_acc[i] =
> -			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc)[i]);
> +			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, flag)[i]);
>  		gpu_metrics->xgmi_write_data_acc[i] =
> -			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc)[i]);
> +			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, flag)[i]);
>  	}
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		inst = GET_INST(JPEG, i);
>  		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>  			gpu_metrics->jpeg_activity[(i * adev->jpeg.num_jpeg_rings) + j] =
> -				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy)
> +				SMUQ10_ROUND(GET_METRIC_FIELD(JpegBusy, flag)
>  				[(inst * adev->jpeg.num_jpeg_rings) + j]);
>  		}
>  	}
> @@ -2423,13 +2431,13 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		inst = GET_INST(VCN, i);
>  		gpu_metrics->vcn_activity[i] =
> -			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy)[inst]);
> +			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, flag)[inst]);
>  	}
>  
> -	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth));
> -	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate));
> +	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWidth, flag));
> +	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(GET_METRIC_FIELD(XgmiBitrate, flag));
>  
> -	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp);
> +	gpu_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, flag);
>  
>  	*table = (void *)gpu_metrics;
>  	kfree(metrics_x);
