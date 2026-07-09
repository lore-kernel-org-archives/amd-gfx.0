Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC62C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 09:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B45110E564;
	Thu,  9 Jul 2026 09:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEisrucB";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E53610E044
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 09:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkpdckshH7DbEddlumrbIHh+xwJwpSc1N5CwZb2QzJs6t8+7DF9aXsyCfmseAHEnMUTqSq+EReocsVDUdR0CeUzbO+437v+4a8f6EIP4MiDRbzRM2VrZSSUFxKX9h5UsB1vxj8MRg15s1UKj3ogYDLHYZEfILYcwlHQskV0jXgKd2lsgFyq7T8PEvC8bVUEEcqBwcOIYhKirOXVOAK3rEzu/R39hPihmUv4tIG0CS0TOoG8ladxebMAsUEOPyCn3Ih+cwdVjBKu3QcKhcEzojVdKRRkiTK9vxHfRrYgVh70pqgjqBJiMrse2GB0dbrcLuu2j9zicyzP3gZWb/fsa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKapdCagBTC21RTJhQ8vbIKicRJj8RInr8wcOI53+n0=;
 b=j1ePeEa0JGAmMHT6VW5lmAkbZcA3NCiqnvpx9xCNuPBgKsablQcZpuH2DmO+09N7mg1vfFjTIAxs1A7JhZbla6P/bX/F/7Oga4m1VpdEY5wUkEhDJ3ia1rfoJxkdON+JOjp81uM3lkqZmLdAbTdnRm35Yp3YHlZCVeX3IGxJTZADqMOkbgGpXHODSV+P9qs3lWOzewJEd25N8x+wqNg76GVy7VPrF5OlhF6+cJZwYkxERZqG6ZlcDnsJIQB6JqepzRoDiqcqdlyZsz8zEldrP+Sbch3UtNeXOZ80X/sVzadlxGgjGHnnQJzrh6nPmHdFWCS10pjIEQW9hZXjjbznkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKapdCagBTC21RTJhQ8vbIKicRJj8RInr8wcOI53+n0=;
 b=ZEisrucBeBXUxvyT1CNyECMyhAdHe4W9GjMf5B0PfX9oi2GuaEesw6g2lavS4IWr9zI9YT9FQsBciKnJQBSmMUEc1JebJcdVUW+iToRifYpz5vbLS2b+EvnArLiZaJMFRXsf/cOI7GaAkqmxfkykeXRHcOCBExPHgNnM/gNz+1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 09:09:24 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:09:24 +0000
Message-ID: <3e1473a8-eb3d-42b2-a415-55bb2e8fd5ee@amd.com>
Date: Thu, 9 Jul 2026 14:39:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen
 Pinnacle Ridge
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260709031520.841611-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260709031520.841611-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bf29c7-4f8b-4be2-3cee-08dedd99c535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: K/XxAR96EfjBFAU6mt5rCP7boustneGynjr9MOqlong67xqC+Z+3p29E84xx1qCJZPKgewxYxXET3zbl9CGfV0dDWVUyQO6nMZygdv/v2877LvUHna7kR3gBc9gs0xBbssgUc9T5anKUoFYp55b1IhA8c7x32I5bRZMlg/DVHSyaYPmyH2yA6y199xDUgkg+SZW18cDDiEXNu3S8BMpubQqxgkPfiBq/FWtirHAM/mP54igop94kBnU2GYSKNdaASnmUwnOALBRIapZYqlJptoIUvl/U5O4/pdBqpqaHKMYuOvwW7KfisHS23N93nOCMLI2AbDQrlmWXW0TP6RnLDLOzAqKLExkLnFn6W+89lsoqdlJiPL3qR7alOny7oAR59hHYxbH3TUrYGRUk9YyoGMf1D8sOMDkrbqQoZNfWg2ZIdjuii572WkeLjmlF27Ojrm1I+8LJTq/Elt06SgQDVXHYjnB4gb2/jjK++zbGmFcFoTwyRyLtQnMkccyB2KOjPhDllwOoHaqsLloANdVodTxl+wiEaxz1gX8yUzNppRirz8g5N+JWoI7hiNaxEaWV1rRILGj1HrhdwfXe8t5zA4E860f0T39WZijO60+vKwV2rhkJtzQMf6I5Vh6iqJvg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXlzVGRBd3gzeHg0cWJNd2JqTjBrVnpOSUt6NUFRTTZlbm15UVQxV3ArRlFO?=
 =?utf-8?B?N1AzZEpSVGVmVDdyUUJJK0k0aVFSMXRrYldoUTBYVHJ3SkR5WVl5b2JDWTZs?=
 =?utf-8?B?a3lwbFhuUk9vTEg2a1QvajZWWFIwanpaOVc5K3gwdkVobjRONW05OWFvYXI5?=
 =?utf-8?B?ZEE5WkZ4dWFyK0g4TXBSVjJGTWcwYUZwT1UvS1UzMjFkZkdlNXp5T1N5VjUy?=
 =?utf-8?B?WUdpVVVHeGkvN1ZsUTVnQ3ErMGt4OFpnRURKMmdvQkt0QWtjeTc4TzYwSE1P?=
 =?utf-8?B?aTY5NW5iREpoQXVJblA2Nm5qYUI1enVQczZsZC9xVEdzdzFqSUFKVzBGVUU2?=
 =?utf-8?B?YU5zd2VTU2REc00rWEZkKzZ2ejhTaVBpL0VzQTBBazFkSzEvWlBRNE1PVlo3?=
 =?utf-8?B?MDl4aXI1cEZzRmRvMFM3dDR5SkZmUCtCSEN3MCt3UXkwVWlhTXRCL1UrWFZh?=
 =?utf-8?B?Y1hJbWJ5SnJkbTBpSmZTVHJFVHUyS1dqVjdDK1g3SThpUG03M0U4aXVNU2hK?=
 =?utf-8?B?QXNyMjlTNGtETWRrYkJjUk9MUzVtV0FKRzVPU21PeFk1TFAvSjc2dUxjdERV?=
 =?utf-8?B?YnRVWFFPM1k2QmNzMGpZcUlENFB2TkJQVEZGK2htRUJObmlpM0UvdVFrWE1D?=
 =?utf-8?B?VXFsZWc5SE1HTGx0WVA1d0NqNDBHM292VHA1elVCdloyK2diL3pWTDhDcXpY?=
 =?utf-8?B?V3k3bm5DZi9qVUhNeXdUYmpUR1pNWTVoVkZ4b01xaEdOdDZvY3JNbXdBN1Np?=
 =?utf-8?B?UDJKaHFnYUpWNFZubGpabUVoS3orb3MwUTV6WUZwdS9EelZNbHFJakxycmhK?=
 =?utf-8?B?cCtDaFpxUFhadW04ZEJjckY2RjcvSmhUUHYwM3ZudThjemdvTWk2TVVrVEl4?=
 =?utf-8?B?VEhKNG9sOU9rUU9yWmVuY3NRSXdKT3Y3dGY3cHVuaDVYajFLblJRYnhmQU91?=
 =?utf-8?B?djkxTjE5NUdXT3BLMlNXSzNReFZOZVNLMmVkRWw0blI0YWNJNEZzYUhEdnk3?=
 =?utf-8?B?MlJXUVFoOHpuNDdpZUNaM2hncURwT0p4SVVuYTFNd0gwZ2pMd0diQlVFenZ6?=
 =?utf-8?B?eU1QczlJOUh0OWxxK1NWNXBtSVZhR2xmYVZUT3Nhb2NqcklZRkhodXpnQ242?=
 =?utf-8?B?OFJZUjJBdkF2Qm42TC82aFNaMjYwTHZGY2hxNHlRcXI2NlhtNjJjS1BLZ3RE?=
 =?utf-8?B?R1lhR3dUWG4vTVJURVBPWjFIV0VCenFDVDhxUkZ2Qis4SVNiaFdVZENuSzJH?=
 =?utf-8?B?TFNrWitPd2MzVHFUSFJ4c0h2aDhsVTNIeFVwaytlNmJGM0hNL3h5K1JRT1NU?=
 =?utf-8?B?aXo3cHIwbVhHTHRyQWR1QWxqVHBId25ESVg4VXVxOTJzbk5hRU1VeE1obDN5?=
 =?utf-8?B?M2owR0R6RWhQdlpDQUtQRlNlY3hhemtqTy9WMGpnd1FqSm1weTFlZVpBaG82?=
 =?utf-8?B?K2ppc2xyckJtL0o5YjVvZ2ZlVkF6WGlnNWozcXZwNTBxZlJUeXBqa0FkRkZi?=
 =?utf-8?B?WVowK3JmeWxVTEI4WWhHa1lvU1RkZFVDNHRnMzc3Q2x0UW9FZmtPc0VkZ1VJ?=
 =?utf-8?B?Q0VWMUxnSE5uckx3WGtlSmtXRHdPUDVnZFlKVGkyV2g2c1AyU2YwbkYwYmNj?=
 =?utf-8?B?alFKVkJzc0ovV3lCMy82VHg5NHc1NG1ucGx3aEpBK2dUSXhmVEorQ3haQUlB?=
 =?utf-8?B?TkdzRUNML0hod1krdXNWclJ6S2Y3RWVTRUZUUnkxUG0vRmxzaExFZXFINXJW?=
 =?utf-8?B?KzZDeGJYd1ZzaDZ5Y0F0ejNlTWJMT0J5bWxlVUY1WTNVL2lTUEhUSjRMbzdv?=
 =?utf-8?B?azA1ellwS016dHFtaisvQm5MMnVPVzV4Vm95Q1IyMUJoWjJCY3IvTkxpQjI1?=
 =?utf-8?B?QUlpMnJEMVVNanRDVDZvN21YZmFUMlEva1RHbHlpOHVkNWlHL1V5MFM0Q2lI?=
 =?utf-8?B?SWJqVkxCNzd3Sm1pNmY0MnpSNjVSVDVwVm44S3F1VlZ2UXQveGpBejR5QUd6?=
 =?utf-8?B?ZlI5V1VSbi9MOGc0MjJpSUVHd3RnMjBWZ3hGSDlLQ1plNWp2cFplOGlFdjRk?=
 =?utf-8?B?UkNhZkNrWVAzelFuUG1taEw4V1R3dFB5Z1pEdXpwUjNoaE1jajYvVEordXdM?=
 =?utf-8?B?WlF0SHRCUWRNeUlxWEFIZ3BUNFdBMFQ1allUWEdzcEs0MXRGUlhITS9NM2Z2?=
 =?utf-8?B?TlU1K2pSWkdMMGRFQXRDK1hPMkpha2c2cFN1ODBYUWV5bmJ1STl6ZGpJZGFP?=
 =?utf-8?B?djdIQk1XU0tpOGI4dG91UWFqNXFGaENCM0tTVDdJYVJsS0p2S0JTOCsrS1Nr?=
 =?utf-8?B?T3ErVlI1OXZrTDVLYVo4WHR1cHNIYlNkS3ZiVTVoQmRCZ1hya3NWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bf29c7-4f8b-4be2-3cee-08dedd99c535
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:09:24.3118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YDphvjJREJ9xwr4RtCPR15x9kimVOBRsPYokgzKDDpf716nOZNgyv4zABjf6MKA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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



On 09-Jul-26 8:45 AM, Mario Limonciello wrote:
> AMD Ryzen Pinnacle Ridge (Zen+, family 0x17 model 0x08) CPUs have
> PCI controllers that don't support PCIe dynamic speed switching,
> causing system freezes during GPU initialization when enabled.
> 
> Disable dynamic speed switching when this CPU is detected.
> 
> Assisted-by: Claude:sonnet
> Fixes: 466a7d115326e ("drm/amd: Use the first non-dGPU PCI device for BW limits")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5436
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 27f7a841cd623..f8324712b712c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1289,6 +1289,15 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
>   
>   	if (c->x86_vendor == X86_VENDOR_INTEL)
>   		return false;
> +
> +	/*
> +	 * AMD Ryzen Pinnacle Ridge (Zen+, family 0x17 model 0x08) CPUs don't
> +	 * support PCIe dynamic speed switching.
> +	 * https://gitlab.freedesktop.org/drm/amd/-/work_items/5436
> +	 */

Assited-by effect is visibly seen :)

As per rev guide, Gen3 switch hang is common in 0x17/00-0F.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 == 0x17 &&
> +	    c->x86_model == 0x08)
> +		return false;
>   #endif
>   	return true;
>   }

