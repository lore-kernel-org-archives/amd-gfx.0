Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CC4C282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 06:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB9210E143;
	Mon, 10 Mar 2025 06:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ASolnd2i";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E65310E143
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 06:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUdSfZS6h/JHH88ocXgkuHoKlu2RGHO2Whh2Nsct+e37khMgGiJ2fbnI7e2DAei+u3bBmcqfOlEG4R5fPC+eR6zrH1cdyxiewVZgaLByEYY3cWescXKCQmgGdTbfPAYE8t/GE0lk65atybhKXXwo2mIGYQk0Hsyg8kTtzzU+++RVHSlV5PnOkQCTOvtxnB1QHFnEOZneLOHLc/qt2KcbH1vvSNIDH0uuscPELCAA75KPqgiFIMM1P0hhewkDwEOHoUvDgAjFNTZ/2NEi5/KDcCKxqLGuY0E/dk6jF+R3IMkrmA88uXZQfXPCSV+jIpZo8ToXMcVyGKwtDN98D1ht9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGPKqT/CwJN+RbBIUTwmfN6h9KGCrsz50pX91/pIQHI=;
 b=FCGJ5NLSEtE3ZYtV4+OI2HggpYey0YmBRU7DKo2SxLo7tVTBteyFgFPnT13HpNb874p27UxcofNVJ0yNUxQnwtFFI+ljR+lFcamiblmeS7gMp6giYUtagcNjxf5NfQ6yAqCxoAar0mgqoiX7JLcUaffboEpizZ9qRbBTRFPlrKYe0MbH7zKbjKgZSxFMA016sRnGPCvK0YhWTksamzHRuXxKtd31UwohLywoSugW5Dp7ZtKOUbFUniFhWTJyAOYihyjb3ISCm1je6R5JOHKwNxGjzXU9NbCDOpH1N+9cmPZQ9HOBbtAXaFJNTmB/1tcY9mxQV43ypDKhpiKXBufIQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGPKqT/CwJN+RbBIUTwmfN6h9KGCrsz50pX91/pIQHI=;
 b=ASolnd2iFz1rTIjV5utuTWVa0jIsnkztt6OG8TDtMXT1Q+h5DOLVScr9umDMTB1zKklFjqllMRF20t8TsDOipTUloDlKP7enw2KGjxCQp+q13FbX5XUzSuaFYnELGTM0ZK4jSB9LPf2DU3qwZzKc/kzrqZi0TIMw7nkdP3arAIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 06:25:20 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 06:25:19 +0000
Message-ID: <6279c262-a920-4f66-acbe-3823badeeb9c@amd.com>
Date: Mon, 10 Mar 2025 11:55:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250307151605.946109-1-alexander.deucher@amd.com>
 <20250307151605.946109-5-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250307151605.946109-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 26effc6e-92b6-4440-dcab-08dd5f9c5495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azlGNWtDRktyY0tUVWNHajk2YlU3V2tUYk1pRTlkMnFyUjUrczVtMVcxVjRC?=
 =?utf-8?B?eHkvNUxBR3poY3BnR3V1b2VvWGVtY2FlaGRzVHhBQ3NQMnk2UEJGYUpEcmxF?=
 =?utf-8?B?a0RWOXpSdXFHQWFpVmtBQnFjdmNsUFF4K2RKNzFmTyt6VlhJOUFuTGdlSlpW?=
 =?utf-8?B?OGNrbWNOZi93T3hTSCthUzhTVzlGbGpJN3R6dzIvZDV2RFhycGJjcEx1dkZL?=
 =?utf-8?B?Rm5DNjQ3RXk4OFhUWXUvVEhabDZySEFVNkEwU1BiR3NPRHNGQURQZzB2T2xz?=
 =?utf-8?B?V05nQTJ0MGNIdytWWTBOWThXL3grMTNNRjFDSmpSVjBKMjRsWVhzZXpSUCt1?=
 =?utf-8?B?MmFCTkFpZzlmUjlHdEkwUmFPSWJkb0tMZWtzSFo0NU1rdEs0M1BqdHE1Y3BS?=
 =?utf-8?B?ZXgzWndMOG9iRUFWVnBpbVBMVzAyMDNoRGQxeGxnMzdwaGlQak1EL3d0Y3FF?=
 =?utf-8?B?WGZrMi9oSy80V0FlYTUyR3Y0MTdSYzAwUHpaNEdCekc5THQ5UnhyVXZRR3hy?=
 =?utf-8?B?ckFtOGFublVXNXJUbjRUTWRKWnBOUGo2UnhzNTFwS0tqVWJLU0lLQ054V3RV?=
 =?utf-8?B?R3hIOTdqdTFxdTNZSWV2UEJEMUNYRlg5RFNvK1I5OGpvNWtMY0F5cENISkxU?=
 =?utf-8?B?WGUvbjhYZ1crbHl3YUxvMUlBaC83UnFkcTBJZ1laZWh5d0RCblUybE9xUlhO?=
 =?utf-8?B?MU94NHFWaGdjMUhadkNBRFdidXRQL0huUHRZbTZyZWQ2THR2bXBsc0l2c05Z?=
 =?utf-8?B?OVZFVEJkZVc1cnFBR3VNRlFYYzF3cVBNWjZ1RXl5ZjRVNXBtWUpBcHNObTF6?=
 =?utf-8?B?UDZaUEp1MVlEdEpreHFWelV5aHpWb2hJcC9WNHcwRlpvRnA2MGprNWswWFhL?=
 =?utf-8?B?anpVR0lMUWNhZ09OK1dNQ2hwM1l4OXdkaDVmNlg2MW55VGlqNUkxSG5OVStE?=
 =?utf-8?B?NWhaQlNWMmNRaTc0TnltbGRFYzJ5ZU5mV1hOVjlSY0ZIQ0tXd0ZmT1VxdE1a?=
 =?utf-8?B?MnJSRVZaK0E2N1FEOVZmcGJyaWxLdk9ubjZMTFlUaEdWQU9ON1dDaTZ5V2VN?=
 =?utf-8?B?VVdOUkZyYnJodVFET0IrU0RyNW9ISlQrTzFFZFdPWGNNeUlsQytTdndmeXRE?=
 =?utf-8?B?R3hwRXZFNkNybVFRMCtqMUdUblR3ZlJmeURsU2FVemsvWGVFSEtXRlVYZGZz?=
 =?utf-8?B?ektvZEUyMFZqRk1DeERCRGFhamdNbkJGS281RUpUQjFzek1Da0Nmdi9sS0g0?=
 =?utf-8?B?c1kzdEl0bHd5Q0lMdDRXZDZYVmdjNzNHS2lGd3pBN0VKQTZTU0dtNmh3WUtU?=
 =?utf-8?B?WTI5RU5TRUxucXN4ZkxYdDhsQTRhaktULyt5b2x3MzArQkVXVjVCL0psMjdH?=
 =?utf-8?B?c2ZGL245V0ZNaVlwUXV4TU5tTUFnSEJwMVRpWWtDRG56OVJyeEN3UEFNQmho?=
 =?utf-8?B?QjZ5NzgvM0VrR2svcXk5U0xacHl4aHFBK0ZzbTJ3L2Q0UmViNmcyY0pzVDlL?=
 =?utf-8?B?RHlXOXBGV01HNDRrd3J2WGNGaGRSYUFmU0s4Z291eXVkRldBTlIyR2h0eng3?=
 =?utf-8?B?YkY0TkZTYjFkcEw3UjN0cC90Vzc1cDNYR2tKRWxJZzVMQ25iNkdnaVlGMXlv?=
 =?utf-8?B?MGlEdE1nRS85dHlEemhQSkcvalhGdnZuckVHMGxyUFJoTi9wUUV0cW5tZmU2?=
 =?utf-8?B?ZW8wa1diQXkza2F1My9JMnIrUG9PRUl0QnNtZXpxTkY2bTB4YnNueXFIQk1p?=
 =?utf-8?B?V2VYdlR5ZHpuKzlUUzV5cGVlVGk5ZEUvL2JDQXRMS3ltVlJoZmZQejRuYkhO?=
 =?utf-8?B?YlJSMGJ6WDZWOXpUUmpXdnRVZWJTQ2NlZHg1UTgxVlB1MG80U2hvVkxEY1Jm?=
 =?utf-8?Q?iRYQigS63GFrZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWo2L0s0TGJ4dUd1aGtCVDhMRkVKcHdGZ2VIZHM2b0VmdmdVMW15SkU5L2tR?=
 =?utf-8?B?UUwwWTB0T1JmVnRTQ2tlUGxGcFMrd0x6a21IV2tkeGxCL1dINVEyYkNRc3Jv?=
 =?utf-8?B?WSs4bnlRMTZqUkthdk9ocUtFekdGQmc5VjlDVmpreE5wZU1rTjZHQ1lRaE9Q?=
 =?utf-8?B?N1NYUDVkNzJhQ3VTeFRPNC9JbVExaFRUVGRHNk1XSlNiWDRoRjdsMHQ0UXlR?=
 =?utf-8?B?Y2hReXFWRmtvZE9tZVdpSExuNjBuUWo4NWZvV0lFN3dwWEEvZEk2RzhhMjNX?=
 =?utf-8?B?Z3FnTXJuamZsamYzWHZpZ2hJWmRqZmR4QjFWVUljeFpTRnlpNHM5cWRhZytV?=
 =?utf-8?B?TzRqMk9uU0xQeTh2QUViWUxmNmJTS0pFNWQxWHkyVXVlWUE0bGkyMVdpaDhM?=
 =?utf-8?B?YVVReTlPQ1BGdkV3SEU3b2szSVVBMTdpTXNOR01DY3FIK2ZzTGRESWhLN1lv?=
 =?utf-8?B?THgvTEJUTEs3VjhsdXlMZFYwRjFvSHRkS0gvbDNIZU10QUlFV2NWZExBUlJD?=
 =?utf-8?B?V1NJWmg2c3kwcitWUWV5clpSVnhtWk1xOHhGdDd0Z21McTB3R1haS2liSGFO?=
 =?utf-8?B?Mjk0Wno0dzI1UHFZQk4xbm1BOGk4cVZSMGtTY0FOb21FNXVtdkRnZUN5RHhy?=
 =?utf-8?B?NnJyUFRKZEdpR0JnZ0hpdlZ2anlMbTFJZ3FTbTNOTjE5cDZDcHZCT1dqVitm?=
 =?utf-8?B?K1RoWVk4a01IVzhCc21QRWtGVEpsVmtuaGVNREFPRmdVdUIrN1dWOHZjblNC?=
 =?utf-8?B?YWdyeVJqMldjMHFYWUhQSkdVZmRhVytvOHhkeCtHZ2x0WHNCMEJWUUlRSVA2?=
 =?utf-8?B?a0crNU8xUmZzRk9pOUU0S2N6cTlzZEpsdXdGS2k3TDZFS1hkdmI3b2hWVy9p?=
 =?utf-8?B?NWNxUHF5bDZiOUl5eDNieXR6NXhnb0pnOWhOVk5PR0FUTVdDUFVaNm5yb21n?=
 =?utf-8?B?NHgwYmtVUFpUVG1SYlNPenArWkNTQTBjb2d4NGs2VkNnUWVhR1llaDd0YWVO?=
 =?utf-8?B?OFhnSG94dlBzMVA3SnNHd3RodXhvdW5IOGhXbjMrek9PdGU4STduQWZLanpz?=
 =?utf-8?B?aUM1V3RKOFQ5ZFU3QVE1eDRYVlFUbW8zbDVGdWdIaks4bXlxVVptdDI5bHR6?=
 =?utf-8?B?QUVkdWJSaDlicEtJV3k4djZLWXpmN0QvcjA0RHpEcjhkNktCbzRuS1pGR2E4?=
 =?utf-8?B?MkZzZ25vNjRFbDErM2FIczlNMmtCSElUWlFkQ0lBYTRJT25lS2lzejlkcEhW?=
 =?utf-8?B?YmFoY1JoUTVPeXNDalRiTDZQb2RRdVJiamxJOFg4Vnp0VldzRmZ5VVhuZzhy?=
 =?utf-8?B?Q3lyaUFnT1lpbDgxaVBNV1VzYnQyVGZNVllablIvVTdFekZhejE3cGpQbU5n?=
 =?utf-8?B?NkI0VUE1MS9PbnlvdjFBVFJZVGV0aWxaT1NPNnp0QTZxeitibUZ5cXNPK29X?=
 =?utf-8?B?bC93eUdlQUNHWXBiV2p0QklhSnhHTHRBVlRWV3diZHByd1BCd1lBVVdYRm8w?=
 =?utf-8?B?a210KzVwNzlVTWh5QlJ1SER2M255aXZTT1BNejJWUUxBQU82SW5JTnNseFhW?=
 =?utf-8?B?NDRXc1B0blpOK0ZnQUdJL3BjYm10ZngvQjhpbU4vdUlQZEU2Y2R6Q3AxK0Nr?=
 =?utf-8?B?bGZ2aDR6LzVpbGMvdzlDMU5ubzMrNWl1UE5TSjNIU3Z4ZHdHR3IrRCtzb0w4?=
 =?utf-8?B?M20yN3NSaFNnZk9ETUZQdk5LdExWYjlHSVZNRFFZR3VYbkhqWVhwRGozTGFU?=
 =?utf-8?B?NE1LcXljdTNvT2hnV2kvc2VqS1psdE9NdURCWkZpdnkyaExuNTVpMXZmdUZY?=
 =?utf-8?B?REJFNkE1cXFybWZwK0J2TDhwVEl2bUV1cXpDRU5sc2piczJpbTduL2NnSmFk?=
 =?utf-8?B?cFc0T2wwaitYcnFkQ3JONWxtLzZDbGVBYkV1SHJ1NjBUM0FtZXNheG1TdGxo?=
 =?utf-8?B?bHlFYXMxS21iZmxPYS9YMjBUdWNpT05LV0RzN2o1Z0JMZVR0MTBVZ2xDM0Fa?=
 =?utf-8?B?N01qQ0p1cy9yUGErM1pmUlQ3c3Y3MEpNSVMvTXJ2VU1PYnR6ODlsTkhCY284?=
 =?utf-8?B?VzQyUFl3Tzk3NW1rSEhvbHVvS0hEdkcyQVVpQVRXMWNSQ2wrMWpzMnk5ZFUv?=
 =?utf-8?Q?Q1Esexe+YdATnS/gIrl9dYvGg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26effc6e-92b6-4440-dcab-08dd5f9c5495
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 06:25:19.7766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Uvbo2n0JmurX5WKraBOfqpMMpdDFVBAva+IIKArWIN1FusyqEgNatcyjttejARjdA8a2nnqde7aI175q+gi6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
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

Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>

On 3/7/2025 8:45 PM, Alex Deucher wrote:
> Move it to amdgpu_mes to align with the compute and
> sdma hqd masks. No functional change.
>
> v2: rebase on new changes
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
>   3 files changed, 28 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index ca076306adba4..5913c5ba85ed0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -144,6 +144,28 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   	adev->mes.vmid_mask_mmhub = 0xffffff00;
>   	adev->mes.vmid_mask_gfxhub = 0xffffff00;
>   
> +	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
> +		/* use only 1st ME pipe */
> +		if (i >= adev->gfx.me.num_pipe_per_me)
> +			continue;
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
> +		    IP_VERSION(12, 0, 0))
> +			/*
> +			 * GFX V12 has only one GFX pipe, but 8 queues in it.
> +			 * GFX pipe 0 queue 0 is being used by Kernel queue.
> +			 * Set GFX pipe 0 queue 1-7 for MES scheduling
> +			 * mask = 1111 1110b
> +			 */
> +			adev->mes.gfx_hqd_mask[i] = 0xFE;
> +		else
> +			/*
> +			 * GFX pipe 0 queue 0 is being used by Kernel queue.
> +			 * Set GFX pipe 0 queue 1 for MES scheduling
> +			 * mask = 10b
> +			 */
> +			adev->mes.gfx_hqd_mask[i] = 0x2;
> +	}
> +
>   	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>   		/* use only 1st MEC pipes */
>   		if (i >= adev->gfx.mec.num_pipe_per_mec)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index a569d09a1a748..39b45d8b5f049 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>   			offsetof(union MESAPI__MISC, api_status));
>   }
>   
> -static void mes_v11_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
> -{
> -	/*
> -	 * GFX pipe 0 queue 0 is being used by Kernel queue.
> -	 * Set GFX pipe 0 queue 1 for MES scheduling
> -	 * mask = 10b
> -	 * GFX pipe 1 can't be used for MES due to HW limitation.
> -	 */
> -	pkt->gfx_hqd_mask[0] = 0x2;
> -	pkt->gfx_hqd_mask[1] = 0;
> -}
> -
>   static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   {
>   	int i;
> @@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>   		mes_set_hw_res_pkt.compute_hqd_mask[i] =
>   			mes->compute_hqd_mask[i];
>   
> -	mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> +	for (i = 0; i < MAX_GFX_PIPES; i++)
> +		mes_set_hw_res_pkt.gfx_hqd_mask[i] =
> +			mes->gfx_hqd_mask[i];
>   
>   	for (i = 0; i < MAX_SDMA_PIPES; i++)
>   		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 96336652d14c5..519f054bec60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
>   			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
>   }
>   
> -static void mes_v12_0_set_gfx_hqd_mask(union MESAPI_SET_HW_RESOURCES *pkt)
> -{
> -	/*
> -	 * GFX V12 has only one GFX pipe, but 8 queues in it.
> -	 * GFX pipe 0 queue 0 is being used by Kernel queue.
> -	 * Set GFX pipe 0 queue 1-7 for MES scheduling
> -	 * mask = 1111 1110b
> -	 */
> -	pkt->gfx_hqd_mask[0] = 0xFE;
> -}
> -
>   static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>   {
>   	int i;
> @@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>   			mes_set_hw_res_pkt.compute_hqd_mask[i] =
>   				mes->compute_hqd_mask[i];
>   
> -		mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> +		for (i = 0; i < MAX_GFX_PIPES; i++)
> +			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
> +				mes->gfx_hqd_mask[i];
>   
>   		for (i = 0; i < MAX_SDMA_PIPES; i++)
>   			mes_set_hw_res_pkt.sdma_hqd_mask[i] =
