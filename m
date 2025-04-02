Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC426C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 17:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AAE210E890;
	Wed,  2 Apr 2025 17:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCSuyFsn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1F910E890
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 17:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sqk53ZPXhg43mv3nG4RWWKuprq50boVrnikG0J6atPz0j1GVqrZxvb4diFoZqoIsGH/q71B52amwhlzgJw6hgKXRl0Z6WNzuDnJSAyefu+xG7jYc0EUZfEe+ahMDuXksCX++dI7PsQt6JdsRJJRQ2HcZ4FmHeSMx+OpWGg04sczDk9GB/hV1hkD11ND9jrQ1g7q8rv5+wAjMruTx1mGQHXOyTSe7nuWRJSoOdwIv2nAZugT/GPpA2wh6Oguqkq9cDISskQfVd5QCccH73EStadX+HOlsGZorh3EDjzh5215YSt7lnpgEyRYR4AY5fAaC4BP5YRm25CuI72qkk7aezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE0QPUZ25pMl/jGdFiXoNO0X2PNP7bAdLFG+6a91vdc=;
 b=AyFHHrU8KvtqxIv2gC7LSIEDd+fSxXuSKECtILLADs9xYoseWbwF1uWVeqwcNdeo8KpYQmEpX/dMqiWFVux8vKZOvgn12OWi/q0PY8mkQ7CvsLYGYUSw2qs8guZ5OLxeQu6mc+g/yTHbMLIXmLit06g9JO59hwjMbSHZSITQZLgzIZJZXTPt0cuMAUlyxS2i8FHeDmWcm04LJJQZb9a1pHQXfASj1zj3HiDpRtsWhERz8WuC4Oftmo9dYBdV9uNGlYmAxpz8nr85lo0dZCElMMcFBqGtyyZxw0C9pdrxL2XCglw7XvydpDVhLGWNj+6ywRfAHh47z6RGFCj/pnql3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE0QPUZ25pMl/jGdFiXoNO0X2PNP7bAdLFG+6a91vdc=;
 b=WCSuyFsnuMuQJqWHe28XBLKvML3Z/uOpuTJsgYbX5hNgWPOSKBRiCJIsl+HjqPrdG0UuODCMwUEad/O5oaSWSDMd3AIS2UTAo7OOw88ZNvkdkW/ET7PysHOln9S2K5Igz9yixpx6vU3BFGVjMdpZZMbqJDzyxGUq31fqJM67Z/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 17:51:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 17:51:55 +0000
Message-ID: <2272934c-f52b-4d96-bba7-2ff9896930e9@amd.com>
Date: Wed, 2 Apr 2025 12:51:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add AMD Phenom 2 to pcie dynamic switching
 exclusions
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
References: <20250402051349.3206659-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250402051349.3206659-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0047.namprd13.prod.outlook.com
 (2603:10b6:806:22::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: af5bd6b3-366a-4d22-7642-08dd720f0e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTgvVXJRbE9UbXlidC81dU9mL242M3lhbVliWWprWk5KOTFDQjZqQzh3UmN4?=
 =?utf-8?B?Qi9ucExYeGtqczJvRG04TWdwSVhGNW1TeEtIYnVpTldHZmxZaGhKMWoyQWNh?=
 =?utf-8?B?em9CZDduaUQ2MEc5Yi90T2JUaFhVVG5xd2dqVjdkUDJnVnZDWk9OZVY2RHNl?=
 =?utf-8?B?RlprdHJiQTNLcHdpOVlpQ3RzaDNYUC9Qb01yYUg0RTJ1UGJ4SHBNQ29nWkhz?=
 =?utf-8?B?RWZnZ1Naa3dnQnhRME1RaXZuNzNRYVk5UUpUZkxCbDVBY3IyTXlHWVQ4Tkc0?=
 =?utf-8?B?ZzJvWk0wTWVNWjcxWTJVQjdSOVRtU2h1Ni9BTW1jbEQ0ZFl6M1NEYS9qdC9I?=
 =?utf-8?B?QmdsOEZ4eGdtektUVHpTY3VEdEMwRUNlTERPbjRzSnB2ZUJZU0VmYnJBT1lr?=
 =?utf-8?B?b3NELzdkNUk3N2Q4WU94WmplbkFrMkdYZ2tKbDFNc2RkT1pLcjFtV2tCZXFD?=
 =?utf-8?B?eW52N1NVbCszSmcyNmh3UXVXbEZzK1BpRUYvM1VKeUN5N2JtKzU2Q2NvVk5D?=
 =?utf-8?B?MHVVQUcvMCtOYUFQSGhyWmdWc3ZCdFJ5YzVWeFlWNnFnOERLcFlTbVBWeTZ2?=
 =?utf-8?B?Rlc5MldqbWl3TWdpSWFBVFFsUEdmRjRVaDRqN0hTQ1o3T0MzQmNCU2pWckVR?=
 =?utf-8?B?ZnlOUVd0dURXbXUvOVhhRGdmbjc1UEtnbGI3TUUwekkrd0d3dmRaNUNIUWV0?=
 =?utf-8?B?VmE4ZnA5anh4aTFoankwNU5CN2h2T0FlZWhtVk1CcVpoUmpjcVJhYU52czh6?=
 =?utf-8?B?Z2NmMzF5dDNsUjRURjc2cUhzNCtIZjdKemtnNE5RVzkvNXdJaEphclFhaGFp?=
 =?utf-8?B?ZFRhUi9vcjlxbkJYWlR5T2J2SStmVkZQRjFlVmhBbWFNNVVWMEVCN0pyWFZG?=
 =?utf-8?B?MFZIMDVaL2dIU0h3SWpGQ0wwWFVOU1c3SStBNnVXV1VjaXNFaU1xeElyTzJw?=
 =?utf-8?B?NlJoaStMSzU0VExaMnoycEh4Q2h6aWtYTUIxNjJESjZib1lWNmlvSFEvak9q?=
 =?utf-8?B?UFpFVUVubmNUKzJMWnhoMWdULzRQUTV1d3diRTQ1Z2NJT1h2YXA4WDBiaGhv?=
 =?utf-8?B?VmtYSjQ5TlV6eGhRUXZOK1VCbFpsb1JkRXl6NFBMUEZNN2hENE9jY2IwUVpW?=
 =?utf-8?B?QzFxcXpURlkrSWJkS0Q0VWp3QlhjanRYMnRLVUI1RVpVTW9Mc0Z0dENRUGZL?=
 =?utf-8?B?ZjdvMDhEd0gwbEZHK0hhNktHWFJod29TQ0NadGVUU1JsMEZUajNXWnJPK2pZ?=
 =?utf-8?B?NXVMRVhGd3FGci9xTEVKKzBkcCttMmxyNnV6TFhiYllYQVdCakM0ckVFWnBi?=
 =?utf-8?B?Q3JnejlOTFRJWm83ODN5NVJCUGU2bzBoWGkrZ3RvODVaR0Z0NE00SDRYVGZ0?=
 =?utf-8?B?c0VJL0ZsNEhPODhTMzRGcFF1QXhWdDdNU1pML0kvRWsvQm01S29uUHlpc2JL?=
 =?utf-8?B?VW10MXkycFpIUkVPR21LVnRqdUI2R09sS2pDQ1RqU2pyTFVLNmMxbVo4V0hk?=
 =?utf-8?B?WEtnaEVESk1JMVFXYzFlVWVac3RKSG8vVWMwK0lONXg5bGR3aWpGa3BxdHg1?=
 =?utf-8?B?MGtETldxaTdVZS9qRitIYXB3MUFwTXdPQkR0bm1FaldWdTlzUU84a1hXRkto?=
 =?utf-8?B?a3ZxbU80VHc2Z3RnR0VZTUU0NGl5citkTEw5UXRMWHp1Vi9xRTFTSFExSFhw?=
 =?utf-8?B?SXpPdzE1b1NuV1R1c2ZieWZCYTgxZktGQ3pJOXVsZUt1S0w3bUJVZmN2SkRh?=
 =?utf-8?B?eC9aaFNhUE9YZFViYVhMOVlBdm8vYnFXTnpDYlA0QUpFSXNlMmhtUW5sNndn?=
 =?utf-8?B?cC9hRElvanR1T2VFNTRodz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckorWXZjRVM3YUNQOWl1dXZKMUlxR0U3Qyt5R1BoUWVvdC9ESDd2KzBtQThM?=
 =?utf-8?B?aVE3Z2g5TEpRYktnaENXaTdmL3hBZXd2M21CK0pEWkRPSEdKMFdiT2VGa1F2?=
 =?utf-8?B?bkhWT1lqU1J6aXM4SkJLaDJnampHV0dsMTI5WnAxemp2T3N5azZuZ040ZVlZ?=
 =?utf-8?B?VzlsY3dJekhWN21QcW1XY084OEVuU3N3ZlVMcUI5ZkFRVnNHcDRsRjRqa21Q?=
 =?utf-8?B?Qmp1OUZ4eWFmY0tTaDJpUlpVQTZoMnN2OFJBRWNLTkVCdU5vdGVWSFphLzVi?=
 =?utf-8?B?dWQ0WjFoSHpqWWxCV2VTK3ZyV2pmdGU0akpIQ1JwNmU1WU9PSUZxQ3dkT2dC?=
 =?utf-8?B?bktWVUcvWVF4V3plUXROYXpGQm5kTUl2ODltOWtZS0JYR0ZHdHBXTlFJNFpv?=
 =?utf-8?B?Z08rS3lnemFRcXlUMGVEaEIyRjNHaEkrUEExSi92SUNkYWlPQVBzN2FOQTZq?=
 =?utf-8?B?di91QXhYeFpZR1RDVHVCK0JTY3FWTVI5TndDRk82NkRvTUNlV3QrSVdEQTAw?=
 =?utf-8?B?cDVaV1VDQ01WUXl1V1M3RnkyQW1uTXlWdzZXcWlNMkI2bUpSMGRyaDFjNFp5?=
 =?utf-8?B?SnhGNVhUZ1d4WnNsajYrQ1ZhRTdSazMwZXp5WnJ4cFNlMFlKZlFFTjNZYzMz?=
 =?utf-8?B?Q3NIelpKczg1Z2ZqNS8wT2Iyb01tQllvMldjK3MySVZJZ3pmTnhscnMyN0VB?=
 =?utf-8?B?QkZMd09RMG00TnN1cmQzb3BEeVJnUTdhVE9ubUtyZFp4MlpBaFZSdUdpRzVx?=
 =?utf-8?B?clhGVFl4K2w2SGNtYWJ4dmFpN2ZYd3pjZUs3Tko5ZTRFL1FQdGpZSGJKUlZR?=
 =?utf-8?B?MVB3SzlTczJPWERrWjBYa1lhMGtFWmN0QVpvY1UxM0lzdGN0dUo4VExONGJL?=
 =?utf-8?B?R1JJNlQxU1czUDRWWkNnVDQwdytOck1tcTEvYnptOUlFbGFOYU02d0N3QURm?=
 =?utf-8?B?MjBjc0tLZnk3QTZRWDQwdk9QeHFOWkZGNVZzVW0vV2hLM0ViRWdmNU1qdy9t?=
 =?utf-8?B?U2dBT1JidzBDS1VHZVBZcUhNMWVZR1BIbzYyM2hJRU1wS1d1b3NZUDh4dmhp?=
 =?utf-8?B?M0hWTlFST1RFdHd5UVQwU3ptN2xqdzNsSFFVQUt4T0FRWHgxQVN6TGZNZFQx?=
 =?utf-8?B?ZVpGZStBUG9OVUZYWStiSitvUjdwRFRMN0ZUQ280clp4enZZRjlEa2p3U2RJ?=
 =?utf-8?B?TTdyc3VIWnBCczZxV3BCNldMUDNaS1FKTzRvQTB0VG4vMldGVlRCRWRNSmVI?=
 =?utf-8?B?UmNXbXhDMGRaZjJlUFNtb2NzTFNHTllOdmRUWkhmM3RHQndIa3FGdnRKOUJw?=
 =?utf-8?B?d2krRHB1Q3BndUZERHAwV1dSVFlHNzBXRTZHaEs3RkRxNEwwSnVhWHJVWFpF?=
 =?utf-8?B?dEFPZjBnSWUyVjB3S0RWcW0vNGpuLzk1SThza3dPR0owei9QQndyK3kxT0NF?=
 =?utf-8?B?SzFoK0hwdTFzTElISEdlSWNXZHhyakpDQktDR2diM2JaaVIyQTFHREY5MXpu?=
 =?utf-8?B?TjY1dHJnaXVZM0xCRUh3UWMyQXFCNlJjYTZpZUJtMGIrQ0lERmhxa2JSckx0?=
 =?utf-8?B?SWNqbGsza2UxdjByS3JSYXMzQm53KzNjaHhMY1ZqcTRTeWpER3Y5MGo1TWk0?=
 =?utf-8?B?NlFuMXRNRWxBV09DR0EwS1dhZnFXQmVvbkVMSWRpTjgzWkEzQ1I5UEU1QXpX?=
 =?utf-8?B?QTFvaEtQRHVKeTdDSmx4c3hFOHVzdHhZK3BCWElkdTdTbnd2RmttZXpWSTBC?=
 =?utf-8?B?MTdHM2p6eTZ0ZUtVc0JEODU5eTJMNTJ4OHdaS2FvaDQwQnFZVkNlYnVHM01I?=
 =?utf-8?B?b29BWE00NUlZd0owRjBzR1JQeFNQQmdSUnYwbU1wSmxzS2NEOXZ4V2hFZStp?=
 =?utf-8?B?dVlmbm1hYXJEODhCam8zaGIyaHcxUVBkSUVZb0h0bHgzUmFvUi9vRUdpZUU5?=
 =?utf-8?B?a1BwVDQzdFJXVGowejFVYitHM29rb29DNjhJRkd5TDJ1TElNMHlzTjdlWGpW?=
 =?utf-8?B?T0hWYThvTXZxejVodGQ5bFpvaWhMY1lTSzhnSGF5dTJ1eXpXL3BzMWtQeTRn?=
 =?utf-8?B?UWV1Z0RuRzhIWEwyQTNIeG5paVNuQTNvWDlzS2VtdGFzTndLZkJCNWlzUjVU?=
 =?utf-8?Q?WlFTPhGC/Yq9u/mAKVm6+P5zg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5bd6b3-366a-4d22-7642-08dd720f0e9e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:51:55.3710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Loi89aT/ReRMUyTR2kHX7kihVyfIV6CmT7UKhzL7czer0HoaU2OqO0GtwmpCy+Gb2ZLT2DMpOFriqfM10YxYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

On 4/2/2025 12:13 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> AMD RX580 when added AMD Phenom 2 has problems with overheating. This is
> due to changes with PCIe dynamic switching introduced by commit
> 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW limits")
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4098
> Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW limits")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6ebf6179064b7..22a0a0bbb4bf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1854,6 +1854,9 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>    *
>    * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processors-datasheet-volume-1-of-2/005/pci-express-support/
>    * https://gitlab.freedesktop.org/drm/amd/-/issues/2663
> + *
> + * AMD Phenom II X6 1090T has a similar issue
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/4098
>    */
>   static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device *adev)
>   {
> @@ -1866,6 +1869,8 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
>   
>   	if (c->x86_vendor == X86_VENDOR_INTEL)
>   		return false;
> +	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 0x10 && c->x86_model == 0x0A)
> +		return false;
>   #endif
>   	return true;
>   }

Please disregard this version, I will nominate a version to cover more 
old hardware.
