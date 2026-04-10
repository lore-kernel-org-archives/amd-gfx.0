Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ABEF36BAA
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 03:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DCF10E00F;
	Fri, 10 Apr 2026 03:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m01xmAcG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828CF10E00F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 03:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiIyIEuIyGSZcVp8C9lG9oljkLkbj2uEUjqkbtsLEREONOQQya76HBRtxJ/AISiO/+AFSw8H1gdga7xs/F9GJ7UScOi2BWkKEEyVbdeFzqFhkP7rG/eOxDHvZMKSK1mKd/W57q5rjXKwTG9liB3YkOLxEACd5N8lcGXpvItuyz4UO6PI+YyQUBhSHEKODZlbDW2e2vsyYrYd2HNLZIMrzz61vlaTe4CGRXvKLwUTHrigtSc/MD0t8sFj1RUQv0zycsxjjAjU7f1YwgD5aKqkZ85F242U1AY2HAhOvjU9Oyh/Lwa38GqkgwdF0PUigrPKgfnQGnPF36OS/6iyS7DO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyHyaAJkN54WDQLsmSLut7ilESO3ux+xspxGhrmciNQ=;
 b=gaN6LUY8QZno6YDqomKNyTKU4BCGLp61tBusrNOx6V2VxfY1G4CydxnSTRpkri8uNmS2S6N8Jgsl0HeANOgQntp822j+Pk3UDySErYEoX43NBQhOSSzJ2aISHgTereT5uJMHq0te1kBYHprHELPZNscx4vtzWEDe1a98+MLr1wfgPaS5aIrPjKauv/jILkY3zL+fQDG/ACTmd4PsScR0FgZmDOdhKD97/7XnXeqSywO9TgxaAg7sv7KeranhBkBcSd5O2G+d+GMU0HlZ+UosKSbs9f3NbpoLEZnWyOcDOvT9YNsr1AiyRSXV4lWs8/yeAxq3wt64VzJ1ETx9e1MGDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyHyaAJkN54WDQLsmSLut7ilESO3ux+xspxGhrmciNQ=;
 b=m01xmAcGXcflvW8a2H8Qa5lJSYi5T+7WYGUuwi8Yzj/U9EoQb+pRtTec/gZjMeJp2K/2jrgMsYcJ174UW7cexhg4vCNIsDMZkUBQHKSugh6ToUVJvoHn/T9Hr+o1WiKAgbNYXsHQ+iSTx5R4zqGGIFIDGIGb2I9WBmOcU2b6WHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.45; Fri, 10 Apr
 2026 03:55:39 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 03:55:39 +0000
Message-ID: <b82e93fa-b7c3-4ee3-906e-09a2cc89b72c@amd.com>
Date: Fri, 10 Apr 2026 09:25:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: correct single device PCIe reset flow for DPC
 status
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com
References: <20260408054126.2202627-1-cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260408054126.2202627-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fde8aa-ec6b-456a-baa7-08de96b50763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: mSDIz+q3LDu3lJuQHRsqIH8+rbeTL6nDlOrzG+uJgZBfX4bthFf6taSEgmaMkl9qClMstYi9wiEjDE6HOUCg+6j3XC04N488+pijaq7P9ta3eZTU0xKM6jiS5nuGV5z+3+0sHgG1n1acAT2pCGk8PTP1fWwGtxvXyaaByu6yCRv/ejNZx6rsVyLUmpFh2GuVLG2J36EAMzwE9AyoZ0E7oTmYJJcn/1qTAt1RHo7aaRdnMmli9gw+e+8ZVYFyNulsg5g9vUVpCUqyBp7bBVvM2t5bANhBtmfgZtAGCgz7Cm3sMj/OPDux2Z/maY6Kk3p8lMfFnQiSbiPRBtd4AIIQQMZxdpmayp7iyFM/3ybWZQ11lxObOm4z7YxX1TMDp/xVNYDHRX3+Uls8kiaFvKqrsIdn3d9eVSIue0d5YfEu+7beCRvc4eHhsPu5nAyvR1Wsa90XuuiL+ujc6Cn8lgAqtOQqGbeb02eaLy8G+ltGctRHk85bRI3EEpxGgyo/JcnDWtw98dwtkpSVKY87n5S3vWKy4Re9GbmkuWzXkVt52x/B5ER8Gj6LvZDM8bXgKcPcGQxYlkVuPiVMKg6PrftlJ7fiiAwSdNJmxF3vhrlNOU6MPo8PkuwzRtFS5hfrKf/z7n7YGY92GdXl2l7V6svgwQdgvR+0eDGwGD0C0x/j45ElLTkfhaXnBgN73+YzGwFz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NFOFA2Slo4OStiV1JEaTN0SzY4NlFoaHFpRFcwdTVHMUtUbEkyVXBSd2Vp?=
 =?utf-8?B?SWR4Nm9kdUtCM3hNdUVPSTVPODQ0dVVoTzFGd0xIUVhTZWFBaUM0L0ZzMVlH?=
 =?utf-8?B?cFJXdWQxNVptMTBoTjlPVFJCZEprRTlxZE1va2Rjb0paUzhRK3BpTGFzMzJB?=
 =?utf-8?B?N0lHQ0NEWkhLaVFzK2h3UGhTR3JHaThqaSsyaFR5YWZRTXdHY3d3OGt5QXd1?=
 =?utf-8?B?bGZQdUpSV29DVVMzMzgwMXVqejVrRDhEcUsvMk0vTWVDbldkNzUybVM1ZFo2?=
 =?utf-8?B?cEx1UGVlS00vNFBmVFlnY3VxcFJPU2toMDdrT2VEdGR4T0t6V3k4K3ZiQktH?=
 =?utf-8?B?SmhQQWpMK3NLTFVCZ01ycDkrKzVaTDJDd21XTVBDcEpHWHBoOENPTGNnSlNF?=
 =?utf-8?B?aGVzRzBTMTJMR0YwZFBlWGZ1RmZpN09XWnQ1aDJMeHd3WmpwTVNxTW1jdUVy?=
 =?utf-8?B?YWgreXFLZWs0SXFWVmU0bU9MTTk1ODd2WG1OSFJPMWlnblBJUTZYSFFPT3B3?=
 =?utf-8?B?aVFPd2MzQkZzRERhU0JJcm1IRTVkeTFRK0tnQXlZWFhmQVRWMFpsbDluTFFu?=
 =?utf-8?B?SDlEb01XcTkvbzdST1RKNHRMMk5LdGxGbXI3SXVpYmdneXhYWFlCRTVqajFy?=
 =?utf-8?B?T2dIRHgydHF6U1o1TUgwY0l3ZENpTU15c295UUpnc2pHNzN4VUdiYVZXMDJo?=
 =?utf-8?B?MXZtcWFNelVVNjBJc2I2MHJrVkdTL0hQTnpHRmZDUklzM2Exek5sQWx1Ylhl?=
 =?utf-8?B?QVdkSUtFVml6WlFXL1NYanFFSkFWRFZaL2JmSklWakRRRHBGSjMzMkMrdHRl?=
 =?utf-8?B?MzJKNnFubVpyR0d4dFpoa2VFVkJMK2dEVTJCTjlXenpkeUx1L0VLZGF3a2Rj?=
 =?utf-8?B?YkZWNzVxZHJXZEdSRDErdmx3aklzNDljUUlaYkErZXRObm05MHptam1MYXNx?=
 =?utf-8?B?NzJwMXpEWHBlQmlEejI0VzI5VExvdHJuYXlyMG9nRGFOZFliS1IxUVBGQ2d6?=
 =?utf-8?B?bU5jL2dHZ3NoaUFkRjRjUTVJdUQ5NmZ3aXMxV2huWFhPV0tWbmZrT0c0cGRa?=
 =?utf-8?B?UXBhb2ZQNGxJK0oySFljZGFld0M3UVJGaGhMZ3FLR2hVdnhKR1R0b0FpK1NL?=
 =?utf-8?B?MEZON0ROeVRUZWdpby9BSWJMbXVvSHVDQmNudVRzZXZLTGdTZ2R6Snl3NThp?=
 =?utf-8?B?bnpoNlhaY0VWVmtLQWdGRTlqaDVCRitjem15dlFvck9aaVh4N3JJTmFvM2la?=
 =?utf-8?B?ZEhQeWJXekhFb3FLVnRMcTJZMWxDMWhmby8xWEFqckFmek54cHk1THBsRDBi?=
 =?utf-8?B?OG9CSzBaN1JSV2ZEbm9ZekJpNE5SckJkOEtEWFYwMDdQZzhPWG52VzlvVlgz?=
 =?utf-8?B?VGl2Y25iUGlaWm5pOFlSTFAwblBUdkkrdkpnNDdpYi9zM3JwQ0tVM2hlajFZ?=
 =?utf-8?B?RE15dC94bDdMY2Z0MDA2emh0T1ZyVlUxU0FSbGMyWStmV09UTTRXTXBMNG5H?=
 =?utf-8?B?dGJFRkRNSmxlcDNZb0JXMzNaMEIvN1QwUWQ0Nm1NKzBvamw3TEwyVmpueVVy?=
 =?utf-8?B?UDQ3QU1lMkxsbllPem1SNlBlYko5K0NGY3pGZWlLYy9vak50Y21mb2VRb3Zu?=
 =?utf-8?B?anVia25JaWd1WUtPeENCcjZzck03Z0VTMGVTamVQWHB0MVNBRkVCaHpzb1Q1?=
 =?utf-8?B?TmNGZ2NzL0dER3Nqb0pxQUJxYXk1MWdLdW5DMTJiRTRMUHFFUXpDc1Jackh3?=
 =?utf-8?B?U21xUFFVZ0wzL3VCeUMzb2phZm1BWmluaHY4Vk05cWczSXFvUnRRNVNBayt4?=
 =?utf-8?B?cWdRVDJBK0pQblFLQlFYanRuNUNjeGpLQ2d3L2ZjYzJsSzZ3ajRKSktpOGRD?=
 =?utf-8?B?TkJ3MmNvTXhTYjlOTVNJTDBBZTJIanVjM08xVlQwN1ZJVllJYitkZGQxaTc5?=
 =?utf-8?B?UXQxR2xWdGlJUTArLzh4bVBuQlgvY2RaS1lFSkxTL281TnNwRTl6OUdUcEVa?=
 =?utf-8?B?YUFSd1oyN1ovc2RDRDVCcnJMUnlreFV0OUVwcUtYMExLQ0J5b2xOR2FGbTJV?=
 =?utf-8?B?b1QwY1lTRVNmK0FpTUNCbS9aeElGNmdNY0NYYmFldVhpSlNTeE14RkhyTkZS?=
 =?utf-8?B?dUVwbUFzSldNNkFZQVJ2V1MwZFhzWDBNUkhVUzNwSDI1bTA0S1ZlMTNqZU9G?=
 =?utf-8?B?LzRYblh2UTc3VENVT0d0V3crTTFFVVVLYkRWS2Q3UEhTZEloZXg5SFVseVlG?=
 =?utf-8?B?WEFxc1JIdU53VXFFd0tRM3VVcXNNY3hOV01XYlBuNDFXclc1VU1OZkxzMUM4?=
 =?utf-8?B?NVI0QmhWaW53V3hCMG4vaFQ2cmJYY1NRYW5UQnl5MWNCSGJaM2xRQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fde8aa-ec6b-456a-baa7-08de96b50763
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 03:55:39.4020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdJ+Qd5hjJSD0w0w/pbQDaTo6gFDd+R5oYA6g0rqdwouEI9+ukFitKJCOb0En6jz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
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



On 08-Apr-26 11:11 AM, Ce Sun wrote:
> For triggering the dpc event with a single device, we still need
> to set the in_link_reset flag and the dpc status.
> 
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index deb41c095b59..0bdb54ab9a53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6291,6 +6291,9 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   			amdgpu_reset_set_dpc_status(adev, true);
>   
>   			mutex_lock(&hive->hive_lock);
> +		} else {
> +			if (amdgpu_device_bus_status_check(adev))
> +				amdgpu_reset_set_dpc_status(adev, true);
>   		}
>   		memset(&reset_context, 0, sizeof(reset_context));
>   		INIT_LIST_HEAD(&device_list);
> @@ -6411,6 +6414,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>   		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
>   			tmp_adev->pcie_reset_ctx.in_link_reset = true;
>   	} else {
> +		adev->pcie_reset_ctx.in_link_reset = true;

For the device which gets into DPC, this status is set in detect stage 
itself within amdgpu_device_recovery_prepare() -

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L6245

You may keep the same for single device case also.

Thanks,
Lijo

>   		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>   	}
>   
> @@ -6467,8 +6471,10 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>   			tmp_adev->pcie_reset_ctx.in_link_reset = false;
>   			list_add_tail(&tmp_adev->reset_list, &device_list);
>   		}
> -	} else
> +	} else {
> +		adev->pcie_reset_ctx.in_link_reset = false;
>   		list_add_tail(&adev->reset_list, &device_list);
> +	}
>   
>   	amdgpu_device_sched_resume(&device_list, NULL, NULL);
>   	amdgpu_device_gpu_resume(adev, &device_list, false);

