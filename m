Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A67CF99368
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32B410E350;
	Thu, 23 Apr 2026 11:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I/TL+1xA";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE1610E350
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kminCO3DCPMuo5nGZ7NDnHiwugIM4xWjNmLVmhg7EIijtNsb+cOs4eCZEbO2qS3RZtI5KcGdyGMjzZqUp45rhAyf6pn0QQjLOukQqfV2h7LInNfc9YnSBaqKkGW8a0ZA1zNQsKYBcfpYVp4xMtUqOhqVaYS5DqaXbMPlgf3nIqyleWLhMpUA3fTqrGT4kBvt59Sp/bGU4wdwgf1ZkVUMjs0zt0DVGozZVKdJidgaNVoN+ccjD7eT6oqAFEwC4ZT/B+gAWrjefFgkkEOZB/h/Bnwsg/WfNS9ajxY+YzxnmlkuOJ38kVn99I5nD8RVLfpRqQ/M9S59ejC7muuQmmB6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lfnVjNwd7/MHF+gitrqML1Gp3vsM90SesD+oF5znuA=;
 b=TIwPAEwRL0Za6vinl7EMJzMMPYEsvrdz0evKOX4E+2lzeBDkmspMu7vRJQdMF/o5npVGRRBuWaD2t+wHd6AoarUUqSzelyEXWbrpzs79LwaKcv4GjBGTlSnzARwPCuxfY08ZdOZO4IxyQt4jfSmJ3cJLI+FuACH7cNLS36UaxpJE98RKlhMgAEq3nJlBSSUC0DFw1e1ARad48BDL+PfbNA0ZlpYbdvyOwePEgl2uv9ave2KLxIa+Be1/lXneSkIsBVYj0LOy5dnCF4PZa/VkQrRSlEjOE7338MyAJLqc2UgfU7pKLmkMddPteH9TFcJUyMzx5RE1BCTDmaT0bqCWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lfnVjNwd7/MHF+gitrqML1Gp3vsM90SesD+oF5znuA=;
 b=I/TL+1xAPNYiGHiWyuOfcJHnUDCWJhnHr0xrkESbg0/6LN/74CbA98ztdkavHZDwGUdgc++1RpCKgpJhyNDD2QwI/s1avFI/ZzwAQykzmPzXtPXz/FicNPKl6F2FMX31y3+RzJSLMddYlJzAzI4lj8cAeWqElAhfoo/hIvgPGSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Thu, 23 Apr
 2026 11:04:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:04:56 +0000
Message-ID: <a3dc4b02-505a-4547-885a-ab585310e652@amd.com>
Date: Thu, 23 Apr 2026 13:04:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB
 size on Tahiti
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260423011614.309180-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:207:3c::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cba837-17a0-457a-f100-08dea1282763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: szhAoWzN3xf4xmdtWV0WOYoMHzQ1nSK3AOhnAeXyF9eOW6Sw87UdmAJiXHwCPb1eln4R01EnWiWmELRwcTbuVm9pidy0CdAnEbnWk5lBAtKttBLeEYu0i8y0p5iFM810WTPQPQYyeBxJ3x32KVjxQGH5ZmlheytLam64Z+hJSMiAEGBGQGY0+LylaTFwRbCPWlLJuy4PLhmGCQyi4dpXMp+0JGvpPMugIoWRfLGhYdQ/uJiEUnRXiZAegd7k2HVtOW1zZgUQfM49NCZ9flbEX6lAEU+zxma2BzjaehnBP3Pkg8mgY0RALeJtjKPE+jKplRexT42707VQAdJKyWMYZ6pRHamc7r/cSCH3AkovCYZQL2uitlik4NwwovHsZI9tbFmRS0NuD4fhmSRqaGB5IMTDJLpdzpi1AwZUs8+B14jsEcmwnqIyH0gM8lx+gahTDlVb5k01zOjszO853qvW2Wz7Q5REW0qOEQ86ckIU4zcBq1hW7srsRhskFiNbiyTrhZUZhE9AWLYrm4VZFu8KUUwT5HkxPY4jrBrN2jCYUZW2C5x2GpBDgK4/a4h4Ti0O03bjVrx6xm1ykQt3RiE8PyIGGTn1WfFpVVmaLWQIAUpAlT73vt8Ac0/YKg56WrXUHUQCqtWNEsFpGh0/v67OH+lgXEqkWhZ96w53IGywCyeKWz5IHh4PtyQv8F6ItNRgunmW7HNupEN0k/T8I/LXI6EsL53vfBqy5M2fhhTelNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9IalRrWVR2Z1FFNTc3TjE0S0d2NktadkJYcEhteEV5RXZmVTJNMWRBclJE?=
 =?utf-8?B?Y0lEVHV5dVJDbVFJcFJjeGNaMitTZkZZMDNCem1ldWhUVEtBRGkzN3o4MDRN?=
 =?utf-8?B?Wmg5V3hQVCtIS1pKK1E1NDNLT1J3ZVUyVmM5dUVDQ1ZDaEZqdXF2MmlnZ1VJ?=
 =?utf-8?B?Ung0QWpzM0poUFFCNlpZaHdBWXRod1NDZnpjK0l1bVRuNjRQUkhpMlNIVEJt?=
 =?utf-8?B?V3BWR25PWWxWenBQWUs1UENyQjFPYUl3WUQ5SkJsOHBrZ1hFTmRsWURETnNN?=
 =?utf-8?B?RHVnVGpEWmdITFVoN2lpYkRhNFhMRnhtQ2xXM0IyRkFIOG1PWXVpMm5mdEwx?=
 =?utf-8?B?d1BYRTByaW56MDVBWjdNOGw2cWlxa3kzdnF3TUIyZUdocmVMZzF1dnlaeWZO?=
 =?utf-8?B?T0JNMGVQWVhYTGY1QUxodFNJYkRkYUsxYTB6emkzb2laOHk4RzdGNjJrTHZ5?=
 =?utf-8?B?RzZLdzBHZ2Y0Vis1dVEydElVaUN5aXh4VHIzd3dBWFFJbDZaSzJxZ0Q1WGtB?=
 =?utf-8?B?Z0VONlVYK3kzMC91R3pxeTJsV3NrVmVEb24zbnljNGYyTUZHWGJrYnRKWkVR?=
 =?utf-8?B?OHR3Z2tETHpUU2pES2RyYllDUE0xbldyQ3VLSVJPWVNsanZEL3JTSDJzbE1O?=
 =?utf-8?B?ZHVabVNERTFXTmVxbEZiamZBc1hkVlFMOGVNdEpxZEZaQU55emlhMmZzZ1Ny?=
 =?utf-8?B?R0JDRndnczl5emR6VjBnZjNvM09hbklyQUY4K3R5SUwzVmtnSXk3UHRmanBp?=
 =?utf-8?B?YTZob3pvdnBYamVMdzJucndsdHY0cDNVUUxCazFUaUE5WjNkOFNwZG5xOENs?=
 =?utf-8?B?ZXovMm9Tcmk2NmVkM0pRNklpYWFET1F5Nk5sdStaVm50UnZtMkdUVVEzTjNk?=
 =?utf-8?B?NlM0UDNtVXdWd3JIUFhBR2VIVjBCMWVYYVpTbmhMMWlvT2lMRWt1akVSMnBR?=
 =?utf-8?B?QjBFM3ZjYTVSSTl0SEl4SlplWnBtcWh6KzNVVnBaSDJsdDZzdDYwMjNZakwz?=
 =?utf-8?B?aHlhTHBlMXlLMmxBWEFWeCtRbmJvQ1UyK0xrQkhhNGF1RkNJaXhxV1pZVjJp?=
 =?utf-8?B?Yi9JUVFBWmt2R2tWTGpOWTFNQVordmQrcXF6OGpCN052ZmY2VlpSSWtCV2kz?=
 =?utf-8?B?clBqUnNiMkRwaEorMVR0bDc0b1hmbXhKZDJhSjdqZ2piVFREY2dVdVN1UVJt?=
 =?utf-8?B?aUVlWSt6YVdOZGNwTlVMUU8zOXZUeFhlZ1pKRTBxMDBTcnFxc1ZvRklKeCtv?=
 =?utf-8?B?ZmVWbmVDUUowV1NrU25pSUVCT1QyaUlKWjZMZHFEcXhXeHcxdW5rNnZPZXRn?=
 =?utf-8?B?Skc0T0lZL2tVVDdjZC9ERmZoUlNDWjIxL2JRMDRmQ1JDZkVLakFEVTh2U1Q2?=
 =?utf-8?B?T1ordmgzRDd3QzlIcjc0dkU4cHRIYS91SXpSL2ErR0pyc3N3MVo1UnZuenk3?=
 =?utf-8?B?TGpUVG9rVXNtWWM3RGRTRzJOUnQ1T01QVldSdWxsb3hMUkRKK1FSeGYweUJh?=
 =?utf-8?B?aVp1emRwOFM1bWZBZnB0ZFZPY1VPZHJ5NHpqSHNPZjVHbUhBdTVPN2JjYUhU?=
 =?utf-8?B?aWJISTk0Q29uazAwdi9jY3RZY3VVMUF5NEZWZHVkY2Z6U2xkYXFTZXVRNEU0?=
 =?utf-8?B?blhuRDFzNU94RWpKRDFEbm9TZnM5ZThkZWl2M05YZ2JibFNNa2FHL1p3RDh4?=
 =?utf-8?B?OEV2QUh3VWIzcVN0VGhSVHpjazBsQ0x2QmFpWENHbElTVG1Ib3c5U1FLckMx?=
 =?utf-8?B?eUF4R1d5QzRuRVVmSENqb2xPaHB1ZE5OYi8zRW5WN0JOT3RidEgzZEV6dmdO?=
 =?utf-8?B?d3FaVXpYZDNDY0hHR3JKdlc1SG81bFlVd2Q1Uldpb2hRcHZnNUU3UHFoV09r?=
 =?utf-8?B?dU5NaVJSVDUzZVJseXhzditkTys1cEthSG9xQkMwWFZqbkRGRTRlK0dXbHcz?=
 =?utf-8?B?QjZsak1WSHhYVWRucm9tQmJKd1JZc1p1bGtTYnhKZkVVMHdOaTNtQ3Z6bXRo?=
 =?utf-8?B?MFRHbjFZMnZEbFk3d1NMdEJrT2d5MXBzS1RzakRYMWF1czF0RXlaWXptZm13?=
 =?utf-8?B?azVackZ5NlRGeWIvSEZ3amMrVUJEdzk4ZFVTZGlxS0ZGVitlZS9MWjZxc1NL?=
 =?utf-8?B?WWtaaHpmcEZ1dVVhem1nMS9ka05qWm16RGZzZ2JqUDgxeGZMdktVdER4bHFs?=
 =?utf-8?B?VHhUMzNTR0JiT0dSZ01oUmx0T2gvYVUzMFZjOE55eGhZOGtYSWVDSUx3UHI5?=
 =?utf-8?B?dVNickRGZi93aW15L05jdjRKR0ZtYTIxMURpMEJ2Y1QrMWFKVkplOTRHamo5?=
 =?utf-8?Q?hRMQhR9aN0YBFyCUNa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cba837-17a0-457a-f100-08dea1282763
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:04:56.6174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFXjKDUZXefDthZKfr/U100r6AW567Zz78PUegkl3Mb4gKpsN7oh5bsMx4Hm6YQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

On 4/23/26 03:16, Timur Kristóf wrote:
> The TLB is organized in groups of 8 entries, each one is 4K.
> On Tahiti, the HW requires these GART entries to be 32K-aligned.
> 
> This fixes a VCE 1 firmware validation failure that can happen
> after suspend/resume since we use amdgpu_gtt_mgr for VCE 1.
> 
> Fixes: 698fa62f56aa ("drm/amdgpu: Add helper to alloc GART entries")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 9b0bcf6aca445..673e9e08c66a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -198,12 +198,19 @@ int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>  				 u64 num_pages,
>  				 enum drm_mm_insert_mode mode)
>  {
> +	u32 alignment = 0;
>  	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>  	int r;

Only a nit, but reverse xmas tree order please for variable declarations.

>  
> +	/* Align to TLB size on Tahiti */

Oh that needs improvement.

Maybe something like /* Align to TLB L2 cache entry size to work around V bit HW bug */

Mostly nobody will know what that "V bit HW bug" is, but at least AMD people can search for that in the HW docs.

With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>.

Thanks,
Christian.

> +	if (adev->asic_type == CHIP_TAHITI) {
> +		alignment = 32 * 1024 / AMDGPU_GPU_PAGE_SIZE;
> +		num_pages = ALIGN(num_pages, alignment);
> +	}
> +
>  	spin_lock(&mgr->lock);
>  	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> -					0, GART_ENTRY_WITHOUT_BO_COLOR, 0,
> +					alignment, GART_ENTRY_WITHOUT_BO_COLOR, 0,
>  					adev->gmc.gart_size >> PAGE_SHIFT,
>  					mode);
>  	spin_unlock(&mgr->lock);

