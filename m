Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0B1C25B0C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5BCB3F3A;
	Thu, 11 Aug 2022 15:18:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB5AB3E7F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 15:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWTvpvgOWHsOrDA1qO3+r/rxuNJ/MAu+PiYPpiG+NhFwE2icYafW4PxA9GjjfbaMiAhpQtgQqFVzimC/YNsmzJl4aPQFLgE4jQ89sW2LtDR2hiKtMyS6wm3hvfYmwkizc3WMWKxj5onUVl9R/5Xr1SNP+o/yPRDv3Bf6e84H8NwzOs8OVflmoedc7CNuO4me4XBAoru8toUbcm59S11in6TONrmQdxosXnXCQ1OCO6ZXFqsofFMtYv+p3Xmm7gaEouEZYu6S6KaSXK8A3QLpFcxAPVOSC4Z7x22TgnAoYJpUhQImUWTux8sWtipAF6PPjLqCSAw7HrLammup3dcbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT+itr4cd/Fzr7OQihD4yO0z64jhQypeP4me4ba4U4M=;
 b=XS/wqDC8YYv3sejV5IirSAhO9befojUPbuHhsQCVHAx4z4UzhwRQPSr9NeOgqBNIb6Zq8ZQHy3wVXcAZ3S2Hjnj4X4su1Da5bzm7k4k2+rgj9vCuKp/vjuQEmRfZqlSLJq8doYRiH1qLRkKyRBoU+sVtTfOwLPUn+zIr6JDI6dF/XMckq+Ry0H2MK2jq65TsIIfdjUuZNf+jkAJjXRkWEP23sDHTcnf7coocISLYv9P5sPRhHXQPjvAwBuAKLyzNBxMJ6evec5k701TAARTPbvwVikedE9navMibOIkQW34sNmMi6A1zbhAAhao4RS/r07hy46JiCbBZsz7DW0T//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT+itr4cd/Fzr7OQihD4yO0z64jhQypeP4me4ba4U4M=;
 b=OQrxIwxsb34/olJdZ/+fbLyQWg98TdsXTZfDPYqBDw4t+AOLncx+Qkd1Sx8oo6q37ZYKXwOPfoGopfe5eatj1CGgJ0ZpL0G0iYc6OQzE84ob1rMxAyo7BaaQAi39hRmW++Qs5wlT/Bb4YBmSbls/ca8k3E8wloRwwvkWXQmPLTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Thu, 11 Aug
 2022 15:18:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.025; Thu, 11 Aug 2022
 15:18:51 +0000
Message-ID: <78c8501b-fbda-43a9-764b-2176eeff1243@amd.com>
Date: Thu, 11 Aug 2022 11:18:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: fix reset domain xgmi hive info reference leak
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20220811134217.138701-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220811134217.138701-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 865ce6db-4841-496e-d7d2-08da7baccbc6
X-MS-TrafficTypeDiagnostic: CY5PR12MB6381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puL8zypYR66AF8hk8DNdSB9bezejdNrAR4v5vHtgSdrsLjgSu3ByhhYGaXJg7hnyVox4ZaY/aVvoZPKLTdqVC4LmWkYSWbbiV+a8VbZZihllJJB+HZ0QtgRams8pAEZHarAIuUbNax3M/Q06a7K9x95xPvYn1H5ihVnvx+tkPiko8vropYWjq8o9v88SMvSivlMZ9kQEBuDg8MPE4/LCf5tLppZSjjOSzHh37vk3EFp83fwhtOwfK4bq+WQjZ94aUKUbJJOB2mpEuEHud9U87Q1rpPFlgwgct1UGopZuGvQUyzlSCDqRqkDDjMrPkPXKAmM2VzO+N6VKVDF5529gfVFy7F8LZ36KOZ1TMhkbWciNEQpxpZCFMbcK1wnjmXVXjW/cQ8n/cir+K5nF2IGdxaWQvDCPByHIxWdC5gGIQnPQETgVDasMHjgmTF5GlbKI3dEbHO/LLcYdjcsebmNr2UokguWNo2oqqNHWxVsN0s6qU5r9sXeMm5WT9LqbiNj7GIcOUm9YnJbiSFnM7NqI3xHejaaqo6BiCAbqUHXc88q4JCuobonf7agS4qBADzZIp5jgnNfBTQS6RtVGGFomiyQ9IipVFemZ7XWspLuR/zT1WrfOSMy2XVASyIGeypEsaGQkI289d3TA/lv2JHPSyYA/a2LYEasxtATT+h5JsE14nzjz15/YsFrjinLyuaj6m0A0XhqB1G8JRksHZZ/ilR/cPUajMq+snacMB2hiTAvER78Rn4NQoq8TbrBDrxKihwXb2TygZqprFgkkDxSd0i40vE/kxwLof8uKvrpRT7e9GH+8ySsrzgcLT6wOCwG910xiGIq2+DJtX6DzbWKXAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(316002)(6636002)(37006003)(31696002)(86362001)(8936002)(6862004)(5660300002)(66476007)(66946007)(66556008)(8676002)(83380400001)(6506007)(26005)(41300700001)(2616005)(6512007)(38100700002)(6486002)(186003)(478600001)(31686004)(44832011)(36756003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2RtZ1lvT1o2MVplT1NkakdKQkViNmt6cytwZ3NERmNlMHZmME91WDB1YUta?=
 =?utf-8?B?NlFhZ3Q2NG1YRUpCTWgrOGJaV09OY2w0V3Rpa3VoeldHWmNlUE9KMndMRW1H?=
 =?utf-8?B?QzlwYXFaK3NubHB5eWNIeWtaeGdjRXJ5enhDemwrclNxMVZQK1lGNDJua1hT?=
 =?utf-8?B?ZnBTbUZJQUR0cE1wWUhzQ05KdWdKMVU4NkhXM3pyT3V0OFhieDBNY09YcVRO?=
 =?utf-8?B?eWtrejJlRFBpT0prL3UrT3ZlTTZSL0JteGxXbDlRYUNRT0YwaEZ4UFBUN3o0?=
 =?utf-8?B?NUExeVdla1AxTCsxSUZRb1JhTjVIdXBJTUlWK1M1bGgrdFd2cjU5TTc1U1VO?=
 =?utf-8?B?eklKdnFpMTFYQ0tJd2drTWtlU3VkcWhReHdORG5hQjZrZG1PZGduZ0lUUFhr?=
 =?utf-8?B?UzdLYS9ocFZGTWtZWE1PUXRNQmk0RVV3RUtGNHNuMDJtdXR4RXRzai93UGJL?=
 =?utf-8?B?RjFiWGxleTB6T0ttWkIzeURNclk5TVJLOGI5d3pYdEpPamRxV3dUQXdLS29i?=
 =?utf-8?B?YVBxRnpyTXZkQlpqbTd3MHIzMU0rK204cmFzUmZQV0tVTHFWWEVmSmRrcm1p?=
 =?utf-8?B?VnlwbUljdFpXMGFybWl1NS9KbFJyZHhyTEZxeUtadW5DSEdNYnlkN1RpVFdK?=
 =?utf-8?B?d3NNUXpxZWRWa1hLUXl4YXNiUW43cHdWOUpEZXFCeFRjWWt1aU9PaklYL1c0?=
 =?utf-8?B?emZiSGtTeUxKaUVjU0U3djVGeXA0cnRYMTREbGtqa296N3NnSE9hTm5TVnI5?=
 =?utf-8?B?SjVpUlU3cHBydFY5cC9tQ3ZaenNRVTF1SUdvSTA1c25xRDRjYVJwZ1c3MWpC?=
 =?utf-8?B?SE56NEVvNUNsS0ZJR1RIVGcxOWorUjdOcDgyS01YVjJrdG5uUmFLd3VtbjJ4?=
 =?utf-8?B?MmVsdWptU2ppbWVjUWFUbWVzYVpMOXlpekcxUnlXaXl0NHNIcFVMK1drRmdR?=
 =?utf-8?B?Rm1iUW1jOWh2VlN1UnlIWWlsTjNVVmR5TG5zZlJ0RE0ySkgrRGR3NG5GdkhB?=
 =?utf-8?B?UXF2V0d2UEFhSWovcnorNmlOZVMzVFV6LzNiQ1pBd0FzSkR5SEZjc0N0akFZ?=
 =?utf-8?B?SHNOMk5MRHUrdnA4N2QwMXlLbmpuTUF5WjRaeUZ0UndzYVdRZGVLYkxHeWlU?=
 =?utf-8?B?MllFLy9hbHVJV2pKbDRweklnZmFCaGdYZlR6MHBJU0FtWDdWMkV5aThzZG45?=
 =?utf-8?B?cTdzTUd3QkJqYVhLSW9TalhRRjRlckFGcVhPUWVlcmY0cFlSQ2g3NkZrZ3JQ?=
 =?utf-8?B?U3hwMGJoNklzNlgwaXhYWmpKNi9EYTFSUzRvMm94WUYrQlo3WjdoUkVJYlVT?=
 =?utf-8?B?L3gxbjNNUmVMaHpYQ1N6SHY3NHdmMkFZcERod29icEdKM0NPejVNc2VpdWFP?=
 =?utf-8?B?dXNlUXUrUkluQjh5M2JGQml0b3ZaR0dYT1F1S0JhR3Q5TGdWRENXeWFsUkcz?=
 =?utf-8?B?dEN6OEZqUllTSXJ2eUE5ZXBSYlRwenBhd0lWNnRWVlZQRXVuMDMySW5JSDFX?=
 =?utf-8?B?U3QxaHFCTWkyajBPTUlaVDhFQmhPdTFLaEFER1JXcUtpcFNnZloyVHUrWWJC?=
 =?utf-8?B?UTN0Z093Sjlqa1gxbFVpOEtBdWx1NWtSUkozdUZrUUpva3FiVkZCc0Y1aU1N?=
 =?utf-8?B?V3NPSC9Ddlg2US9VWkJ2QjVISExJRWdGanFxWkpWdVFma3RDZWU4RUVEZmFN?=
 =?utf-8?B?OFNCMHczcVVCWkRBM2k1TjdWNzg5OUlxeGJMdmZDaXorOHliQWRxWGc3Nit2?=
 =?utf-8?B?eFJ1eUcybWtBQlVGTi9iSHk3cjlDbU5vc1B2RTYra09TcGRpc2tNMGlneVdT?=
 =?utf-8?B?bFBoSkVPZ1dvaXNnY0hzcUtOVi9JZXkxU09scTlBYVhNUzNxdFJyT2QzL1Ra?=
 =?utf-8?B?K0tVN0dCMEg3WFBQNnZpaEc5cmdoR0hLanJXc25VeXdydGJwQURzLzdMRjZJ?=
 =?utf-8?B?dTI0Wml1bVVaa2kxaFdWMmVSZ3VvU0pvOXJoSE95Z2ZGZVppK21YeFFoS2hY?=
 =?utf-8?B?bUplbDZDS055ek9kMHRvb3hWSVhrbEt0RjZ1Mk9OcEJnb1kxaDBaMjFmWTB6?=
 =?utf-8?B?RER1Sy9FeGJKV1JROTEwdzUySjJ1bmh2dG5CUHFqdG82MXRHbjRyWDV1bTlk?=
 =?utf-8?Q?ygYJJq5tsExEM6LkdHW5BksfQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865ce6db-4841-496e-d7d2-08da7baccbc6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:18:51.0837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uacGUxtEuyM2gd8DyZMAVtiBu9Hxy7bYHXoQ3hL5IUANbKu7bTWE1506h45eNusa8bcSE8elwlleAVpUcP6B2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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

Am 2022-08-11 um 09:42 schrieb Jonathan Kim:
> When an xgmi node is added to the hive, it takes another hive
> reference for its reset domain.
>
> This extra reference was not dropped on device removal from the
> hive so drop it.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 1b108d03e785..560bf1c98f08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -731,6 +731,9 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
>   	mutex_unlock(&hive->hive_lock);
>   
>   	amdgpu_put_xgmi_hive(hive);
> +	/* device is removed from the hive so remove its reset domain reference */
> +	if (adev->reset_domain && adev->reset_domain == hive->reset_domain)
> +		amdgpu_put_xgmi_hive(hive);

This is some messed up reference counting. If you need an extra 
reference from the reset_domain to the hive, that should be owned by the 
reset_domain and dropped when the reset_domain is destroyed. And it's 
only one reference for the reset_domain, not one reference per adev in 
the reset_domain.

What you're doing here looks like every adev that's in a reset_domain of 
its hive has two references to the hive. And if you're dropping the 
extra reference here, it still leaves the reset_domain with a dangling 
pointer to a hive that may no longer exist. So this extra reference is 
kind of pointless.

Regards,
   Felix


>   	adev->hive = NULL;
>   
>   	if (atomic_dec_return(&hive->number_devices) == 0) {
