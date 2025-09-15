Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD25CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 12:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF42910E484;
	Mon, 15 Sep 2025 12:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XL2TGk4S";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5DD10E489
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 12:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Wh8qCgAO27/1nztL9VqrbDtJNs+QRoLjxFIsjEPKZqTVGVMJsklU4lKHG/KMThzKIC+nhHgFOcn5p6J/v36W0xP56mxKSvE6S6PfdBLY9YOp8EmJ5eM7QXFTZ9vi/l7JSXBWvpB/vDwNvFAZi3OICthBQ1p0jHEJt3cNpTHs8jBVmH3/aUCi0Dq1OpZcKdIlSCGs6Hp4Cex/pzoHOHmsxsr4+JCBKtTmsmaIMOUnbUFi5ZvkRnpoH7Zqf6zmlcjOErqMGGK6ygl+C7H7taXfhRQqrTTaM/vJiDsggVuC+1/fr8Hw1xW7MOSfL1uVNfMO/Kc7nuwc0DB4coqz+ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vslNbWcbttxD1BZIVvJDMatuRzM9n3buYyH/1h6plYw=;
 b=h+i2435B/u4f8DgPZJlB+WNnNaxLPPj56K58iBcUnm9A0yloC+vokxAB9h4WuzxH4OJjTvjg2RwtD8Sd4BUtgX8m15u2szqf72v6UhOkXgPY8ocQqXX4zZz6khMLV0tye+um9s53AZSALmkAgmAxWi3AZCcx8fz9Fb9z7H+EV+vNZRyvCyXjeOOx9CF26b+6qe/tr2+9DajS59b+JzMNZ76nHsr+1DEZsLvC4unIASBd1z0KpCldOOh2WtqqZbroABv040fAnX9HvIoukb+mhjVU/iQAd1E9lXtd9IhZjp8ZnKRoMpdUrM4rxHEOSrOEPtYgAHDRfGUYIHTSZgBXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vslNbWcbttxD1BZIVvJDMatuRzM9n3buYyH/1h6plYw=;
 b=XL2TGk4SERNmqkGQWUzFfpL5EF3UQveMwNG1H3t99fOowyku9PN4zq+qF2qsg3R4zBmND9fo1vwtFDQ8H4CMlN0mTIKRk4d7wTVBVr5ljhH/Vu7b+G6oJOoW6m4p84f/6YedbEaN9ZuVkfhzOrnmPeIOgDUCJw5OJB4Dcc2NoCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 12:37:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 12:37:20 +0000
Message-ID: <b5325cc9-1379-496f-885c-4fd54db1a38c@amd.com>
Date: Mon, 15 Sep 2025 14:37:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com
References: <20250908024021.1857440-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250908024021.1857440-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab024a3-6554-46ad-0112-08ddf4549c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU84cWVBVE9rTVNBaEJYbTZzTlFxTVc3TDlBdjBCbjhDdWx6YW1QTkdTSW4y?=
 =?utf-8?B?N09KaDB1ZHNjQUZlMURQZ1JjZzRlYmYxYVMzeFZsRjNDNGR0Z0J1bmtTU1BL?=
 =?utf-8?B?WTBUSXIyVi9lRUNTd2VzaGtaY2tIR3NZSnlyU1lwRG9sS1Z0ejN2RzJuc0ZE?=
 =?utf-8?B?VmEzNmM4MVhyWFhlbVlxM1c4Mk1menpKRVprNzYrR3dyS3I5TXpYS0dyYWRM?=
 =?utf-8?B?ZUNTaWRDcVJ3SENpblhRQkJlbkdYR0s5c2R3bzI2QnpEY2tRd2NKWGo3SFd5?=
 =?utf-8?B?N0NtMXdmcmJxRk9JMTEzOXh3QVlicCtCdEV3V0lSbjBiWVVna29wQXdpSlgx?=
 =?utf-8?B?QW5Sc2NxU1FZWjBBdnRwRTRNblQrcGl5czJmTk53a1JENjZXK3dxY0JJMS9i?=
 =?utf-8?B?STRsSkJsc2NSOFEvVlM4Qnp5eXNxTkNPQ2lFYjdaVzZ1QS9CYTNFVklram5V?=
 =?utf-8?B?VG5qNDhKUFNrclorZ1BhY3krZGJWWjFab25rMWdTTXYrMVBMMUJSNnpNY2NZ?=
 =?utf-8?B?cld5SDgvbVMxTytRVU9RM0YrSE9vNlNDbGw0N09UVUkrejFjSGpzTGhNbElm?=
 =?utf-8?B?NzNUaE0vZFJkV3VMV3ZQTEdkbVhxKzc4ck5uS0l5aFI2M25YRktuTnV1M25r?=
 =?utf-8?B?UWxRUWo3empidGRZZTByVmJ4azhLRzJiR0lKeVd2Y1lWbUEzU3ZBRmdtdVVH?=
 =?utf-8?B?RmJlUHVTV1dnTGNRclJobUFKQ1dueldLOExqWC9OYzZwbXl0SlZ4cFNvT1Zj?=
 =?utf-8?B?aGxEUmJsNGVQUUJDUkJJalJYQUdhWU15c0FscU44ZzVjSDVWL2dHeXNvSGdZ?=
 =?utf-8?B?RVQvZFV2eERja2srRHFvYkVVdm1RYThwOHUwOFVpb2JFWURVbWJzU0E4L3hP?=
 =?utf-8?B?emMrdUp2Rmh4S2tjbTRIeHozRDF5S0lrdHdTdFgvRXRBQXUvWGhmYW5mS2FE?=
 =?utf-8?B?QU80ekN6WUtvbnRJZVF1bnhzMnd3ZnRXU0N5SVlhMWsxdVpjS3FFSHdNMVJG?=
 =?utf-8?B?Y0dBVVFGMWRzMlNXN3JNa1JLeVVaSDU5M2ExQXphNWlPQnkvSWRIaTBBTmRm?=
 =?utf-8?B?R0ZlSloxL1ExWVU5alJtWld0OGdOOElrL200RzlSN202TktrL0k5aTBsUkJ3?=
 =?utf-8?B?L2I4Z1RYdzV5NVlJVEtCc0NBMGZxeXkxYlQ1Z2NuWEdWQWJQbWtLaWtNV3Ix?=
 =?utf-8?B?akpBbzNTYUlyQWlLeXNWMVdBT0MxVUUzd3M5TVFIZ2VQbXRjeVlKOWYvVHlj?=
 =?utf-8?B?YXlKMnRlSFhaaEdkUUwvdzRzczNYSzk0SHZMYUR2MTJmQ2JUNzNhOGEzdzRQ?=
 =?utf-8?B?UVYvUTZON05aVWZ4OVdFSHlwNW9jRWZuY3V1MzRCUFl2TG1sYzM2eSs5OTJ4?=
 =?utf-8?B?c0JrdUxHMS8wR0NyZVZIWktoWjZkMFc2WVNzdk0zRmdTdGs3T3BTaVkzYkFa?=
 =?utf-8?B?dllKbS85QldoamZHNmJaRTNLTEJjZ1FydStZR3FwZEE0NEVyKzY3MjZCdXBu?=
 =?utf-8?B?bmtpTlRtQ2MvaGhrSUpqME4vaUIwRStUMnY4S096Y2Z0YjRLeUVXUDRvNVJ2?=
 =?utf-8?B?MWs0enMzMW9NaHdxaGdqbUhDbTNZY3pZd0ttbXpGRHNPRHJOWUtXRnYxelk5?=
 =?utf-8?B?ZDZ3RzNrMng1bUtKdlE5NUc2aDFhMWxxTFV0UXpnSEl6SHdWSCtSelBOWjhX?=
 =?utf-8?B?K3p5RnZHWTBPMm42VHpYT0R2UEN2ZFVySmU0U2pHSy9WdWNUV1BUVUFWV051?=
 =?utf-8?B?YzhFK2QzUi9HbXdYMXZyT21TdlB2Z2ZPV3RzZ0pPZ3BoenVBV0RncnZtclNC?=
 =?utf-8?B?dlk1QnN5cCtaUjVFSDZ1a1BPdjV5c0RaZWJJNWd3dHlzQ0RSdmZwanFra0Jz?=
 =?utf-8?B?dXFETXZPK2wydVZCVlZCTDJRTm1ncnlqdXozcTliK1BrRXJma3JIMWEwTkw5?=
 =?utf-8?Q?y7/wrF8XnOM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTcva0FLelEwUDduZDIwZkVkY3p6Q09yUW94Zktkai9NUDdIRmFyZFpUei9q?=
 =?utf-8?B?aThBeUd5K0FaQUZvSFJ1M0E2YW54T3p4aEZWUCs3Y3IwTVU4bytQakt1L1Nu?=
 =?utf-8?B?MEdPSVJpczFrUnhoWkNqOVJHVWVveGhmeWFadSt0QVNzNmdlbkVoemsvdXVj?=
 =?utf-8?B?cjNjRUNiUktEV3NhTC82TksvTWlDUUpnYmx1Qm5kTE1rQS9BOTJOSCsyMUJR?=
 =?utf-8?B?RzNnbE9Xbkx1SURObmNzY0wvbVlDM2NVMDNUekt5Z1B2VkZNYng4dUVIdkpR?=
 =?utf-8?B?QVhmdDFkd0xyU2MwaFdNd0lMM3J3ekdoclZLZ1lic3lCZGV2aHc4djlPa3ZJ?=
 =?utf-8?B?dXg1SUxnSTJTQlZLbldEQVBRQWdZUWprZ0ZLUEU0QjBQdFJpZG12Mm9HZVds?=
 =?utf-8?B?UlVQck9oMTUvZkJXcW96V2F6c1VwRnZKNWwxRlJVN0pEeXpRaEpLZGRnYXBz?=
 =?utf-8?B?cFRHSFlLQjkyWitQd2VjNXlkQ1lCeHlDTDA2Ri9pSmszM2x2ZXIvQmEzVzAy?=
 =?utf-8?B?dHJydnZveVFNVEV2QVpwM05aS3Y2MkhkdEp5QTBSdkErMlJqZklHRW9WU3RT?=
 =?utf-8?B?MjF5b3JOSVlvQ3FTcjBoeDJnRkw4dFJ5VXBpQyt6Wit3bDdxYjN3VGNIcUZm?=
 =?utf-8?B?dEJ3eUcvTVpNT1pYL25HZ0NKaktneEJMMDkzTS9sREhobU9YZk0rMVVwcC81?=
 =?utf-8?B?YmNjTnlKdSswSEpBVmRjQTByUVVGaWhRMkJ5c1VvY2I1ekZZVmNEdDNWUG16?=
 =?utf-8?B?Q2tPSEF0YTM5VEZOU2VuZy9RNjZHSWREQ1J6RGV1QU5ucGVUWHl2eUUvUDJG?=
 =?utf-8?B?VHZUeDRIbTlCMFo2elNIZCtXWHpzVGdmRkdURExSQVpmZElqOFZSWVlQWlp6?=
 =?utf-8?B?aEJBeWFrZk1VN2tsMCswWEE4K0JLM0RLakVHamRkQzhsdkFhNXRSOWl4V0Nr?=
 =?utf-8?B?Q1pZMVU2MGp4cHpjMitmYkFyYnFnZEFseTU3TCtQNXprdlA3NEY2SFlyZlpP?=
 =?utf-8?B?Nkp3czNxOW1iRXpLY3ZDeCtWU1B5b1A2VlBuaXBDYXFURk5Dem5UUkpxc1VT?=
 =?utf-8?B?VWJxSVVzVDdMMHhRcjBTbFM5SDdVOTB4NEFsWWMzVmJBbzZ2N1piWlhpaFdJ?=
 =?utf-8?B?TU05TEU2SzlDSFhhVVZOZU9TVzQwa1c0UENhWi9Sck9NdkwrY0RDVS9KZWFi?=
 =?utf-8?B?Z0VHZ3hneEM2L0krQjhuUnBnSHVzQjM3d1JnRk5HelFoa2hQOXM0eUh6VFZ5?=
 =?utf-8?B?dGdKMm5sbmVLOENXeUc0SEVZMy9YYkZKRkpqa3Z1bmxEd1VkRUdkc0xnUHpt?=
 =?utf-8?B?bjdhdWlYc0pPb0lQeUwzNDd0QVBJMmFqekI3QUZqOHNyN2VLN2NTbjUvRGQ0?=
 =?utf-8?B?Wkl2bW5zSjlEbG4zUXhZVjFqQkJVN0tqQWpTRUhLSExqRmIzd0pSVlhSZWZo?=
 =?utf-8?B?aXJ6T3NEa3VqZjRMVkU4RWU1WkRZRS9jQ1FTZVl1T29GSW1aZmJScmlvK0Mr?=
 =?utf-8?B?V1Q1SFhLR2NOZVg0Y0wzQUZQcGRFQ0tmOHNvbkNYWGNCdm1PUXBzQjJRUkhX?=
 =?utf-8?B?REdhZW1RaUFSTXY1OHRmWXNzdXc0R2FHNS9aQlMrck1rRWo3dU9EWGc5dXJm?=
 =?utf-8?B?T21yQkROdGJOaTlWSlpKRlBpdHFNbDBzSHIxTzMxU2c4OW1CMmRPUzRsQW1B?=
 =?utf-8?B?OGJ4ZmxiYVNWcFlyak01ZjIrSXczMUxSWFRwSVJ3SGdrTXBmVG13WFA5SnZZ?=
 =?utf-8?B?WVJuWFpVaWNCeFhEakdZNkVvVnlWb254TE5JeUFEM08xeEVVQ3hPeDdIRVhL?=
 =?utf-8?B?cGMyRCtxR3RnSTFuaG9JOTh1Wnk0STgwV1V3MHk5V29vTkovaWFuUlFOeUcr?=
 =?utf-8?B?Q2lyb0xQdEU5WjJvWmEwTkpQaUJpYmF0UXJ3WERacnFxUVpDVHQ3NWZ4Qmcw?=
 =?utf-8?B?dzRXM2xLSnIvMDhsNWNDV2pRNnpTTkFKUHNreUpZU2ZBZjhrTm8vUlgwWi9o?=
 =?utf-8?B?bFl0amZZYkVGbzdaNmNMREFrY291SkV6K3NDMGM1SXFVVGc3UXJLZ2xJTDVF?=
 =?utf-8?B?MlVzbmJPV0hMUDBteUFyQmthWWdKNUlDYWo1OW5SVUdEMDczdTBscEE4dTM3?=
 =?utf-8?Q?Q7jqY/FaMUsFM4vJVWwPiAVdi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab024a3-6554-46ad-0112-08ddf4549c86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:37:20.0328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPkLBf7G+6gAOUcGo+MQTeCdVml12q/wHF+2CZdgaEaLjR/Q6FkpSO6ls9a5Oqr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
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



On 08.09.25 04:40, Prike Liang wrote:
> Since the PD BOs are assigned at initialization,
> the placement stage can obtain the PD physical address
> (PA) directly from the PD BOs without additional lookups.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 260165bbe373..fd9cbbebbdf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -476,7 +476,7 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
>  		return ret;
>  	}
>  
> -	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +	vm->pd_phys_addr = amdgpu_gmc_pd_addr(pd);

Storing the PD physical addr in the VM is a really bad idea in the first place since that can change all the time.

We should potentially completely drop the vm->pd_phys_addr variable.

Regards,
Christian.

>  
>  	return 0;
>  }

