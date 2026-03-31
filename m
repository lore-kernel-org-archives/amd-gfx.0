Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0A61061B21
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 03:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043D810E851;
	Tue, 31 Mar 2026 03:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aIUrqgJy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011030.outbound.protection.outlook.com
 [40.93.194.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB8F10E851
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 03:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdoUBf0LmAhkDAAoOTK5jbjpV1UNmJwsw39vhjd75MNtF4gpy1L0IF8kMW++EStVssQ5rMrrjdD2eoTMJsrMC4rUPPAkx0CsO8be93RyDU6FlL7pD0CDi9qr3nEwBSCbeqqEsplbDvsArHTkfFMwgmUUmZNsOCE94W7DXm5mOtO3XMVNrjRjMnJkz8rB/wEqMynKbse93ZYkfVTIb9y24V+TBNR1YXBi3cQF2gjAwfxM00FHNxFyDpdmos372mjkdg+kfwsFNfV8hliH5vspsFXAEfRGq34JM1K6cwdkMCAiP1zLw2ijaTCCvOTanKafnEDBhSiWDI5D8ZPmbRLL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+gtSNqPWtkNP8D1okwQQNgMxkYx6VLff1eh/X3Mx0g=;
 b=NfxDz8vSDvSAYyQTVItrgbvkZoD138ucSa+VXoGpcOkViUmTGQ4ckirgoZCwa7c7mC7ax3Ul2CbasNRCl+PedygWYoBHOFPbCDnfDfhyNvoX0kEapHMNEiMg5oIqFOnmG7k5tT3nG+8kXjuP1BTxqry2Z9vwnlFLp5kkCqtwCtgchqCM7uM6QB9K99ShctsZr0dW8fKsJ4UV5BeYTX9UlcpbbmWlQnJFGz9q8VQ2e+qs1dUIuLKoDZIvuv+2o4Aj9AMyB60Br/aehLpW/S6iyuVnmVPGnzSSqVF4ElaGj3DrH7RAvQb3Wu9jbP9lHz+UBvi4vKj3/fM1lJWUFwiZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+gtSNqPWtkNP8D1okwQQNgMxkYx6VLff1eh/X3Mx0g=;
 b=aIUrqgJyq0kq0cGPagf0nu3a45FuaDjG+ShDrjuxr27MfnDlsHJSgfPRTs1GKH0NJNqyirZ9pj+QirAJPi6YpK+GDNC8yC3DcF24IjdRWpYJDdf2ml7+bIIMmW1uNH11oQoMKAboHodpXR0PVkifvlfiqQDJqB1azBDWmH87stY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:24:14 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 03:24:14 +0000
Message-ID: <08b7d9c2-2a54-49e3-8b9e-4d778beae08f@amd.com>
Date: Tue, 31 Mar 2026 08:54:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd/pm: fix null pointer dereference issue in
 smu_v15_0_8_get_power_limit()
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, Asad.Kamal@amd.com
References: <20260331024705.1361626-1-kevinyang.wang@amd.com>
 <20260331024705.1361626-2-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260331024705.1361626-2-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b81a22-00af-4cd7-26d3-08de8ed4fbbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ZS8dAYvMYQ1nSVUMh9232lRiFy0+AsXNv9QEbN9N+3y6Q4BtS05KV1Po2P0GTIRnoZZ1T0Z+tSBVsC+oTnqLTjScePPLYa9LuRVCTDqoRkyXpaoLfBCbnbjOp850qkSL0plCJbzE3snhySv+gte4Pis4VQUFB3m/ddZMQ/TXlU/8qjm80DTmkoxiCEauS24wx5hoEuzVimd5Aq9+LEtNaicKSEKqTNIeioPqwr4tDdq6n3F4Bme9K3epyfK1nMinkiR0RM+uN2mfpon3xgYljPf/v2BxCqaUynlsgR1spHQLOehgu41ET+YZRk+2JOEFZLhwQt9fxFYpmFG5SnntF/y3X047hZClniRsKJp/mtQxNyIKsSDwHRi8EiNrUJBDnuQHD1N9aJLSarpLTNGox0fPdr2E8UbLk+MM+khnwrkQ4prvH9OOGZNwz9QLHCuNaFHmxT/LDL8YWxKPqj1ebSDZBS5XLHjGOjj6M5TjldeUrF6MkKXblQsk2XxVc6iPs32X/dOf+lM2GA5ZRggcY7BIKX7pW+WPBkNuW7JqgMDJNAAIonFRDGc6ROICXZXaCWip9b4szhXdQAoG6JELb+CEBit9vljV7p1D3Nx3xb+RUyHZHJ/L2PBc7PjvT2jZ+xQ+L1FgyDBiAWlHA0O9iatCCqThZ30mpdN5ch45ef0fpPtqdDr0xWSoWSlQ79QnrtxJBEVLF2InUPTtk1fkfFMbRIxOEBM9cuPeIe9ILCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtjb2EvOFpuNmRmWFE5eUdnWElndzFqaWg2cDU0bXZSdElmL0hmNEEza0lE?=
 =?utf-8?B?U0JtVWc4MFBWME5YMzdsRW50VHBhRnpoeWx4akJ1b05Wa0QwVlNZR2UrOHhk?=
 =?utf-8?B?QWpOTGpKZVU5WHVyaXg1NXk0NEoxSWdESms5aENhbWtSZGx4VkRob1phUFBC?=
 =?utf-8?B?ZUdUeFpGZmdDMVRLYnA3ODFNcTh4OXpaVkNWQTY2Q0RIcWVBZ2d5Y0lUZGtt?=
 =?utf-8?B?WGRzNnA1TU1sc3hpMGtmYVRDN28xTmJ3MEN1Si8zNFZYWlhEVktsVTZUMzNh?=
 =?utf-8?B?OUowbGROdzU4Wlh3ZktRdHNWSUN3ZHVydldBTGNYSW1vdjlWT0xLL1o5RGhK?=
 =?utf-8?B?MitwbXJGcTM4RkZOU0UrZk9lT3B6N0FVUFJRSnR1eW00RElIaDM5UUNvNzlP?=
 =?utf-8?B?eVpRTUZnTE9DNitmb0UvWWsrQTFDUHgzdXBOYS9DV0pTR1hlZEtTZmNXUHNG?=
 =?utf-8?B?a3hqN1BodWtLd1BkSXJpUkNVeUVzdXo1b1pBUGg3NU5yYmdNZFE3Tk04VCtw?=
 =?utf-8?B?SC84TEpzd3NBVzd2RHlLdGtnb0hodHFCRGJMdFV3eCtEMzJldWtDZnBUMGZ6?=
 =?utf-8?B?cmR3UytRSEN6KzFBOGJSanJvZ2cxVFRmZ0VPamE5VDB3dEljOVpqQVRpdGJY?=
 =?utf-8?B?c21CS25mSlVuRG5sY2lvbE5MUWx0WDJ0VjVwbHdUUWhNajNxVGN4cVIrL2Vm?=
 =?utf-8?B?TW5oeFBZS2NpNklIeStHaXp5Y2szQkFrK0hCaGpnWFdIa20zOWw2Mi92aGFr?=
 =?utf-8?B?UkNSeFdVdld1ODd6a2hEci9sdDhCaEJ6RlY1QkJsSUNUYXN6dis1U3dXZW40?=
 =?utf-8?B?clB6djkyejFaTHVsWVhmSDl6UHROM3ZFNUJsd21odWludVFDRVl4dUpOUmdt?=
 =?utf-8?B?dDBNbWFhRjIvV0xTaXpRbVEzUkFLOGdrczBMV0ZlNzlOU1hnNCtSSjY3WlFx?=
 =?utf-8?B?S1BjRjVURzUzRDY3L2xqMWQ2QWFCR0JnVjNCU0VKc3dSQitIOWQ1d2pBbXJw?=
 =?utf-8?B?cCt5VnpJOUpXSS9HdWNTaEU2K3ZPaUZuL1dzbVg1QTlGTS9QQjgydEg3VDBO?=
 =?utf-8?B?bUJNZ2FCWmNUZHd5N1ViK2NYQ2YxUXZhQnE3bkFRZUxNOFd0ZVg5YVNtdTBx?=
 =?utf-8?B?Ymh0dUxscjdGeHo1VWQxeStWeml4dnhtcXorN1pZanE4bHVMNFlRTmJzMEZr?=
 =?utf-8?B?VG1Ra2Yzcmo5R2tIS2RlaE0ramNVMkJXR2ZWdDdRZTB5dkFZN2t3L2xrUzNx?=
 =?utf-8?B?YkltU2hVZVk0NWxxcXowMWRkV0laTExmRjhxeDFzZE5EVDl0d1VBamRtekJo?=
 =?utf-8?B?eWtZbFBtWXdXUUpUR0dINFFVQ1JNeHVTOUpoUzRjc3pDQ0tXY1U4a25wTy9R?=
 =?utf-8?B?cXhNY2ZVenZ1OU9zb3Z6bjZtN3ExOW9FcExydnJ4U1BaeUxFdWNqY1hENmxC?=
 =?utf-8?B?WHc4dzhTMXIzWkNYK21JZk16RHRVam1KRVFXUUZ0cEd4VnZOMThWck00cC93?=
 =?utf-8?B?SWlXQUpCKzA3SWZ0ZUZ3TzA5bTBPOWg2UXJTU1c5VGJXR0xsMlBoZHh0amp3?=
 =?utf-8?B?bVorVVFwRjVaUWZnUk1LRlF4eWlzRndLSC8xamM2cEdBeDVVeFBEMVVYU2tO?=
 =?utf-8?B?ai91VUR4d2R4cnNzVEdMT2YwbDdtOTFLc0R6bUEwc2ppdGVtZ2VSc1FZM291?=
 =?utf-8?B?Uy9lMFBzUG1RRGR5WWtaTG40NWRVQzNsSDFRbll4U2VvdXptZ2pHNk1PTmZ0?=
 =?utf-8?B?TUtjNnZoR2F6QjJiYTdEcU9hdnZEUjBxYW0wYkFETEpHa2NMdHJKYW8wbmxm?=
 =?utf-8?B?NDI0TWRGUGtlekp1SnMyeC9iei9Rd3ptT2hxWHZKNHFZVm5veW9tSDBTMzRH?=
 =?utf-8?B?dkxQeFFjRDNkajg0a1ZueG1rK2lQMVZjNWladWsvd2MreFh4bE44cTFQQ3VC?=
 =?utf-8?B?cUZUMzFJV3FVUFgyQkE5S2JXSXNra0syNGtSZ0FCTldhcVMyd2dPNytSU2Y0?=
 =?utf-8?B?b3JWYVg1amVpMzVjOWdsNTd6QkpiYi85MHJOUk5YdWNWYVNxSlRnRitoZ29T?=
 =?utf-8?B?SlllUFdnOUM4V2prOXp5cU1vbFlUVks3U0QvdlZsWVphTy9PeWJTQU5yVjBG?=
 =?utf-8?B?K3BtZUdFK0QvTkVrdkE4M1hKV1dFY0Q0d014Z2hnTUEyUEpHNWVjWGZOb0lX?=
 =?utf-8?B?U01MTERqakhLRlhWRzNyVEQ1dk1tSzVrdmwwNnZUWkMyVzhxL0VaY1N3VmUy?=
 =?utf-8?B?R2RyenFGZXNwRHRHN0UwNjQ3VHRlYWNmMkxhQTdka241aG13NHJua2NJcmt1?=
 =?utf-8?B?czBCeGJIcW1penV6YWJ2VkdBSG5XalVNZno1OE9halBDQnA5VHV5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b81a22-00af-4cd7-26d3-08de8ed4fbbb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:24:14.5093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCppdoZu/amFOfiaU/kq+A+0aTiVbeRo+3LNHq0o+7DlGhnz41M5MwYlUlQRR9f+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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



On 31-Mar-26 8:17 AM, Yang Wang wrote:
> Fix null pointer issues caused by coding errors
> 
> Fixes: e4efa501f972 ("drm/amd/pm: add set{get}_power_limit support for smu 15.0.8")
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index b158be7cd7bc..ae43edfa93a5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -1773,7 +1773,7 @@ static int smu_v15_0_8_get_power_limit(struct smu_context *smu,
>   		*current_power_limit = power_limit;
>   
>   	if (default_power_limit)
> -		*max_power_limit = pptable->MaxSocketPowerLimit;
> +		*default_power_limit = pptable->MaxSocketPowerLimit;
>   
>   	if (max_power_limit)
>   		*max_power_limit = pptable->MaxSocketPowerLimit;

