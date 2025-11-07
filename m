Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1145BCCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 04:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3833110E064;
	Fri,  7 Nov 2025 04:55:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0PjlN3wZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F23410E064
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 04:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGyFRtGhFfgYYlFszUiJZsFfCCDIwQ6dkvkVkN9SADB4h2YwE8dOFN7YYk/E6gagO4Ozf7sVmZwrUpV4yWzAGEhaEOhm4l+lxC0JJzi8WWdNCKUGJacFeTVa+xRyFqwQzHxLc0v20q5JKPT/m75fFL/qHx/VJIj1UGMQAINIrP3w0AhZIhMS42f14dT6LdCDe8hiqHhLg2jBjMY9i25thUKlBbA/ki3aC+r/vfFQ6dSij5RISu412/JPv4ABvEt0MAsKHC9DlWaXPWW/fcHOTfM+ffIzXdULa0Q/A4Gs6nt4zzvLpfT0kf6b7JQUiRwH6WXHvXf+rsgARuYQbyYmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23YPYI4B+BGwTylMJi3/VqgGVSq5krQTVc/zn6OiXsM=;
 b=FkodTdxO/0Wn6w77izH3bbdmL6AuiR98XRUMBshuPbPaV9KPPiNnaHK4EfrcsQ0dab/DWn3k9zBKRfGWErnIImUmebIqaobXgtueY+SSsZO2wCIKAnWF3vnnbULxEcH2ZfUCMqhK3QL7Fjp6cePCc+eosRIFEMGuNZ1U7vDK0u/hWmowX1Dxe4R8uvTE3FMkKBxbum6/tEzjeashV5tujF7iMMj3cez2oKf7CM0yGFHtnFm4XE/pJudLq8oqA69ExhFORlZ7ZWZC7dX800S3lHBFcoE+kmKLU/gA3GwrPIpxgCiYCuSPSU0n0v+YN2J8szEU0eOFvFuIzsVYhOmK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23YPYI4B+BGwTylMJi3/VqgGVSq5krQTVc/zn6OiXsM=;
 b=0PjlN3wZ4qRbUK6WDDuLtfthe0Vm82UyegHuvD5QTqH20tMXak6u/glShUdpOTTXa6lxq69eIfO/fJZB1LSS3UCv9n5MtYNtuAe7OeU413sbijYDW/WO9HQbcULXEs5oFOk/VNBx9ROJwnNazNqKFRVa1U1FKQdo5TX+hXv8700=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 04:55:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 04:55:12 +0000
Message-ID: <c7f68f3c-86fe-4900-aa8c-07e46590d2b2@amd.com>
Date: Fri, 7 Nov 2025 10:25:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Remove power2_average node
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251106165911.3786289-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251106165911.3786289-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ebd6a9-bdad-4d73-d51e-08de1db9d597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3NqdGFCK1FOTDg4L3B0dGRhTXMxWkZtR1dwQmo1T1ZxUkZRb2JWRzBpYkFk?=
 =?utf-8?B?V3c5Z28zL2V1RG83bjFoa01jM0tjZDROZEVnUUxwcWFNcW1ESDlQTG1zd2Vm?=
 =?utf-8?B?VjlPY2pIdzhQQklPWlNXV3lrdFRJbXpGaXVocU15dXRncUZjSXgwc3QvOWJy?=
 =?utf-8?B?d2lJaTU2RHNSLzlsVGJnYWNOK0ZNRVkwMHJySGpncEpnUFhqS05teVh5a2Vv?=
 =?utf-8?B?ZHNrNmpmaEsrWDBtYndzdGM4NEYxZFhPUHVrUm0zWWQ3endGaDNBbWVSZTdr?=
 =?utf-8?B?d1hWcnNMQllGRlNuKzlqZFZScUlSOHdoY2srNks3NGdXSnlxaENXQmhreEhu?=
 =?utf-8?B?UEVqcW5xaFQzUTRHaUptQmJveXEvMUVMOWtlbEtGSVBvZ3RLNS9HUmhHdFZO?=
 =?utf-8?B?dWs1ZzZJQ1Jsb3lDcmNuUElTM21vc3BIQUI5SWxOMklNS3NsNjlsTlhGcXdm?=
 =?utf-8?B?bE5QM1Q2bmdpRVMyamowYUsyUDJucHdlTjRkSVV1OXVkek1PWUQ4MjcrTWNi?=
 =?utf-8?B?Qms3OUtoQ2FYNnFYeWlqTmJkWnhOQmhUNEZkOE5VRWt0N0FQY1FodW4rQVNu?=
 =?utf-8?B?dnFVRzM0blFVZXNFQ21rMWV2Tkx4MUx4SFhPLzNBZnY1MDZabWY3KzZ5bGRJ?=
 =?utf-8?B?U3RWNHkvendkUWpqb2tMRGtieGxMZ045WlJNc2ZNVUR3Y0ZiT2tDL1ZCWUE0?=
 =?utf-8?B?UlhWR2dZVTc2MkkxUFBtcUlmYlVjd3NRZTV1REZqVlVUWEhHS0NQbXBvYUpR?=
 =?utf-8?B?Qmd5M2Y3ZG1hVWtPL2ZaWXFRMEJBV0RSUlJIR3dyNnBFajRDdG9HamJoeUd2?=
 =?utf-8?B?b056Z0I5aXEyZFdTQlBaZUhNZmJ4U3RlTG1KV3JKZUh1VkhNWkd4d1NMUTda?=
 =?utf-8?B?c2owZ3dpeFo1dkZrZ00xeEpXWVZ4OVA0R2x1cmxGb256UVFZS2Jrb09iR1ky?=
 =?utf-8?B?a2FHMkdNOEF6OXJjOStoa2xJMk1FbXR4aFdIZVUyUWRRVmRLTjdmZXI0N3kx?=
 =?utf-8?B?YzR5N3NOQTc1UGl0QmJPS2g1MUJ5RHdGakprQW5JQnVUWkZTYVYzR0g0YnNM?=
 =?utf-8?B?aWEyTUlGWjhUdzlUQkM3ZGMwRUxRTG12ckx3aVI4VkJWeWVsVmUrQVVVdWJ1?=
 =?utf-8?B?WDdmWjFpNmFlMGZRM3ZsSjdFa1V3WHBvTW9reE9WRkxXK3RYQXdkK1huaWw5?=
 =?utf-8?B?eDZYenVVWGp2VUtxTEUrd1owUjg0SEZlYUx2eHdPNUJOTkhVUUkzYlBVaEc2?=
 =?utf-8?B?YkVuVXU0bmllMnYzTytERk5lNkdzNUNFVzhJSW5JSTZlS09qWVFyZytId1ZP?=
 =?utf-8?B?ZnRGOWxJVTZNZFhmTndLTTRBQkM4S0lVSHdCNzlmdEN0d2tjOElhRDBsaEV3?=
 =?utf-8?B?NnozM2tuYzNNOXliYVVMRTl1QysyczVlbnhhN2dNYzZnUXNEUUYzWFJtRGRl?=
 =?utf-8?B?bGEybUZ2T3NvM2tZZlplaFpqRXo4TTNSdG5ueFJGQUw4cyszWUNTRFBMVEpQ?=
 =?utf-8?B?Nkw4MjV4NThXSWtpZDFOV2pkTmJSUjd5dGVTeXlrVEc2RWFodkVyUWJTVmtG?=
 =?utf-8?B?ZzVnSlVMTDY5OWlpc0dpOGhqdGFRZTgzMmxORFZ0b1VQek1SWmVlMkR0NWpZ?=
 =?utf-8?B?aHNuMEU2NEUrOFRuanF4Uko3bzBCc2FEV3I3QnUzeW5iMTdpZ1MzZ2RyVlVk?=
 =?utf-8?B?Zy9RclZGWnVJdW8yT2ZLK25UdU1lN1FsdEZBVDJtMTArNXJsaVVLS3pHMU8z?=
 =?utf-8?B?cmlPaXFZa25ENlo0S2V5THZZREhUVGZreFN6WFJwL1ZrNk0zYUx6SEEyREZw?=
 =?utf-8?B?RENyelNnWER2RVEwYi9uTFRoeGE5ZmNJNzNFb3BPNnA4S3QzSjVacUtYd0FJ?=
 =?utf-8?B?U1BqTVlUOHhHa1Jhd3ZhelkrK2tISjlFbXVXT2ZONmt2V2FjM2JyRGlWdmdD?=
 =?utf-8?Q?Z66/a/qNWN1OcXVS1KWDAZOdxzQMIviO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnI5eXdpUThFZm9PU2hnRlFRb0lSRnJ0bWFhZ2hqWno3ekRzOThpa2NkeGZN?=
 =?utf-8?B?U1F1UTBUTEJFOEFpOVBhTysvaUxmVVFMdzRYa3lDUi9TbzV5ZlZuNEtzVDZU?=
 =?utf-8?B?WDhRcUtLM01zWmx5R1dCNjJMSWVJOTQ0ZHFrZFZmL3ppMm1BTWc0MmVXNEx2?=
 =?utf-8?B?WEVvZDE3QSs5bUFNcTRxemw5YUo0ZGszR1dvRWxEQk4rSUNwdW1CdkkxZHBn?=
 =?utf-8?B?d3ptdEd5eVAwOUFmNllMK0JwOXh4UFRaM0dzTGpmYlovdG5rRm1TaG9MS1Ns?=
 =?utf-8?B?czRMZ3VOeDZzUUkzZ3JUVE0wVGFNTTdDakhvUzVyanVNdnNlUEg1NmpzZGIw?=
 =?utf-8?B?M2orMlFqUmY2K0xjSFZuNjdSN2pnaitHcDVKbE1OcjdQY2tPeTduUmxZUFA1?=
 =?utf-8?B?ek05S3VQNjRMS0tZZnA2azJwUTN4S0NsMmlPYUFzbXVDcGxramhRUmg4dE13?=
 =?utf-8?B?bW9NczVEK2dXSjNLNjRCKzYyWmtWYmJYbHNhVG1raFEwN292NW4yY2dLSEFR?=
 =?utf-8?B?cGZLb0lYQXRiQVB4U0xPOU5ZYWE4T2NTb3c2SDAvZkFCeU5KRTg2VXdRTncv?=
 =?utf-8?B?YnUzNjd1TnY0alB0eTJGK3lHT01VT1dWMnFqWlgrdERxZ1MwMFZtbm9hMkFT?=
 =?utf-8?B?U1ZINXZkS2FucWNYQUNLUUpJZUtZajUxUnN3QXlVaG1GRlNISnQzS3AwZ1k3?=
 =?utf-8?B?cTJQdW83ek1KYkMvdmpWcTVxNFZPSDVjSHVxNVhwR1hEcVpZdnFTeDhLMWJU?=
 =?utf-8?B?V3ZyM3hjeERiYTZjZWdRNlozbFhiVDRKMXhlVmYyUjlsSHZnV3I1U1I0bnlZ?=
 =?utf-8?B?Q1VMcHlzVzI4UVdFZFUrZ3Z5azg4WnI1anFoWndqci9qS2RlUDF1WVZiemM3?=
 =?utf-8?B?SUE5eUl4WmtEMDRQQ1QvQUNIaW9Nb2h6cjQxaWZ4T1ZDS0VWT0w1R0RmTW5w?=
 =?utf-8?B?N3JaS3Q3VGhua21wa1F0Rng2dnhWcFJHMWxvT3p1QTRLOTZZYUpLcHkwOHNU?=
 =?utf-8?B?eFZaMHFBQ3J0U1NoM1VqUlVSTmVxNDZXM1NLMHBjOGF3MXZIekZ6ZFZMb2pz?=
 =?utf-8?B?aTVQL1VvRFVQZ3BCdGpQV1hPSXhxbUpGdTlJQmVzY1QwV3JweUNOVWg4cncz?=
 =?utf-8?B?S1BNeFZIU3AzM0hLMzVTcUVwcW5tbmtGYkNLZzBBZGg3NXNFbnVkei84TU02?=
 =?utf-8?B?YzFvWFhSSkJLYUFSN1FNZkJrR3ZYZnA1VjRMOU1ESUdZbFlPdnV4R05kSW1o?=
 =?utf-8?B?SXJ2aTVPSUxMOVBMMElHaXBIVzlkK0NsbWhHdXNDOE5LRGNUak0zbjdCV2dm?=
 =?utf-8?B?Z2ZEKytSSVlZcitmOEdOVTJzcFJsNlhNU3BibEdaMGR1MWJFZEtEWkJENERa?=
 =?utf-8?B?QXpUbE5NOGhYRHZKWDhqSy8rbVZkdHNqNTVaaDBtVDdrWUNRb3llam9JdjdZ?=
 =?utf-8?B?Wkd2RkJXZy91TS9CV0IxV2RDd2pvd1BUcGc1dFRCV3dQNlU5UC9raVN5bmJW?=
 =?utf-8?B?VlY3eFhFbjBtM2htRHR5NnBYaHR3MzdGbC95OXRnakFMQzJ3UUVZVmRoRjlH?=
 =?utf-8?B?b0JZUXZydG1oOTMxK0tjWEFjYXBzREZ6c2MzRS80TnNMaXdvYVIrNGZseWxD?=
 =?utf-8?B?Sk1MdG10VUlMaEdKVTd1RDR2V1ZYRS84dWxCd2VBclBQMTBKekhyOUhySnZU?=
 =?utf-8?B?dlZsVjNVQ09VcTZZREdwR0lVTnlld1RWWFZZNGNXd0NDMmVFeDYyaGVXSHdx?=
 =?utf-8?B?QW90Rmc5RUpNcERnajhaTnVDM1ZDWnRwem44aFFyK1JLai8xNDB6OW1qSG8w?=
 =?utf-8?B?SjZCaWdhOE5BMVdZb2ZRa0VkLzZ6eVNqWWJKb254cnMzdVpsN3hqQk14N1Nk?=
 =?utf-8?B?M0RRT0RwTW1RNlVJUnhDNkNSaGxMTGdMRXNZcjlGUHl2b0d3K2RWQ3p4bnQ1?=
 =?utf-8?B?T0FxM0VKUGdTOXIyOXQzTVIwRU8reHgrSzVwR2VOaVczeTBKTW02ZUswVFhH?=
 =?utf-8?B?aHFVT2lJWlFCWTNoaFUwd0EyVEdXN0IzZDZmM1o5NXdRUGxoN3YyMHpweDZD?=
 =?utf-8?B?SHVZTEw4UEtpMWNXWU9XL2h6N1BkSlR0Qldyc2dQbDhLck91cEJFZkltaE1l?=
 =?utf-8?Q?qCrPynwjkGVhiUN15dw5fW0Zi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ebd6a9-bdad-4d73-d51e-08de1db9d597
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:55:12.5050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX4/bt3GqS8sXg4izaJEOB+TfPikgQs5Y1cffiIn6/FyBgv02L8Ufk6IB8/PXyDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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



On 11/6/2025 10:29 PM, Asad Kamal wrote:
> Remove power2_average sysfs node
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Please add more details in commit description for the background - SOC 
power consumption is reported by power1_average. 
power2_cap_default/min/max only represent second level limits and don't 
represent a different type of power or power consumption by a subsection 
of the SOC.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index fe7a2f09e021..d9e37fd6e186 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3580,7 +3580,6 @@ static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_m
>   static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
>   static SENSOR_DEVICE_ATTR(power1_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 0);
>   static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
> -static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
>   static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
>   static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
>   static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
> @@ -3629,7 +3628,6 @@ static struct attribute *hwmon_attributes[] = {
>   	&sensor_dev_attr_power1_cap.dev_attr.attr,
>   	&sensor_dev_attr_power1_cap_default.dev_attr.attr,
>   	&sensor_dev_attr_power1_label.dev_attr.attr,
> -	&sensor_dev_attr_power2_average.dev_attr.attr,
>   	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
>   	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
>   	&sensor_dev_attr_power2_cap.dev_attr.attr,
> @@ -3828,8 +3826,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* only Vangogh has fast PPT limit and power labels */
> -	if ((attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
> -	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
> +	if ((attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||

