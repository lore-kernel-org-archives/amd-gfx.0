Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D93CC28B22
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 11:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674C910E940;
	Thu,  6 Mar 2025 11:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2xziSZZa";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDBC10E940
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 11:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHvbAIAKhz/5c4U+Xpn2StGIr1eD0Z2/BD5gtu2BLy3TfwaW9DHSE9oJqdrI4f4jrEPy+PYaFpMi/00ZWocXp9idD3vS3cJw48vYE9MpOgSbbGZ2+TkjpwBGmTnrAWSjwN7beZobT/FI1p2tBTjlmKSLBpCssdVonw9wvwG54CGFjo/gg9v2FA+8VtswSvd4EIv1n6YfGM9UUcA0pd+7m2ftEWYrkc03cB8ZtzrfjQxqEptHmH41+O4IFyAw5ACdsBX9R3dKUCJH8PqIRgZUNs/ZPCyftHt5hz479jrVo1twww0+jXhfWdQmW6NCfYiKM1BP/XURTE9AhuSIuHOGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjOYRLOL1NH02Ocy4nFkMiDSQkmiHyLX2yQIsZORLTA=;
 b=aRmal/ccjdTUL6xJ9ZSCykNwSU6WP3Qnnm5cIG8Y+gWQQN4NN+6a3KneW1FfPyPD7NRlqLzGwRPT0R6uuY9aLeXfMQ9sCVzHV+IaAIB7To8nxwoEbFj1eyH4m1vgQrqVeXEhkTfwCYWqhwmX/b1ZS1//l1cJ0d1RLRGxWEO6onueNnb50/+CZ4v/59TtIShB7uV0c5vvNgiPQyd0fcQarZFsdvcsRsP3iRLBz+MhjovsKPFqtQ6NUdqqAcmcS4giuObhhBkr9Coau8g6FY2sOQGECjbpcd9lECgrjwGr0RoPHoiTgoShoz11+e7ENzVAXKfFms7euDfpFQb5ki0s2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjOYRLOL1NH02Ocy4nFkMiDSQkmiHyLX2yQIsZORLTA=;
 b=2xziSZZauvYCZMQ3+MiWwCMRbJRRevWYdb2q7Tbu7TuWVvR4LhVhP0+EkNqxI1QzjV6WUnzJRv3wAkDyETyV4h2HzHkXVQzoox20wz8TbvTUejvWObr3yRmtWgSxYrWvkuksA+tLjPqCnHsQiLoddtD1g2ADsgMKxvTlPAHCzs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 11:16:53 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 11:16:53 +0000
Message-ID: <28273bac-e97d-4e12-8439-fab1bcf248bc@amd.com>
Date: Thu, 6 Mar 2025 16:46:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] drm/amdgpu/gfx12: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-9-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::14) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 38754106-4339-45ef-e52e-08dd5ca065d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1JCRzI4VFJVbDRseEVuaUxLNU9nR3VrZEFadzQ5VEFFQUNyV2k3YmxkR2Rq?=
 =?utf-8?B?MGhMcUpiTElnWlhBTkxjcGlNQ3Z0RUlWbGNXSzJzekZIK2JPYmJiZG16elBE?=
 =?utf-8?B?QnYrTmdRUWd4WjQreXBqVjFjWGRzUnc4aUdoQXJha294UUZ1c3pnVHFmZXlu?=
 =?utf-8?B?cjVQb1YyckVNb3B6b3lrZm5oaXZZdGFzalc1NDZSY3lVSDh0YVp5a2RkNDBB?=
 =?utf-8?B?Z1g3V3ZDUEErUnRDQm1HY2NkMHNuZFRCalBkdmhHYzlIL0pEOUh6aHV5MERs?=
 =?utf-8?B?QjlMQ0wrUG94WTFwK3ZhL3NZN08xR0hsSHN3MHhKTS9JZEZMVUNSS0I4K0di?=
 =?utf-8?B?Y2RJSW1rajNpeUFlTkJDaVR1dE45SFhkM3dWQ1Z6TXFUN3Y1NTlUNDRaZGJV?=
 =?utf-8?B?dVhVdzNpeGdYZHJiajBVZWFwdm9BeWFkMUR4UG5kU1NWdVRlY3cvVGM0SVVY?=
 =?utf-8?B?TnhUM0hQSVlKRVVQeTRhUFBxT3QrV282bC8wYlBmTjZDQ3kzQ0JuYVNFdm5x?=
 =?utf-8?B?UExPeXE3eGlKYkd3OUVCc3lYQzZvMkJBY0VvWVZvQzlOMCtQbjQrczgybUZn?=
 =?utf-8?B?cUhKOHhibnE0ZFVoUCtvcVZqaTh6bDI2YjdodFdSaHBoMy80anJDWVVldlVx?=
 =?utf-8?B?L0t3ZWVQNmY3bm1QOHNoR3ZiY2FCMHhlcHkyL3EwZ0tCVk5rSC9DWEUwdnhH?=
 =?utf-8?B?c09VaUZmeDAyb0JTMnc3ZmFwZG96dy9zNkhkcXA0R0NKOFp2Q09QVVhMM3M0?=
 =?utf-8?B?UENrZzZxbXo0S1NsSlRjRWRVYm93YTArWllnUllCM3U3WE5jVWVVZTBhWHZo?=
 =?utf-8?B?ZHZueGZQcXZDSjE5NWN4TXhEdWVsd1RKTmVYeFhRUnhkUmswVThnQVlrU1dp?=
 =?utf-8?B?UjYzaXExS21DQ0ZibTcrQnp1dmNWenVxcFdCTlNIWGhFS0NaTWl5bUcwdGlE?=
 =?utf-8?B?WitnQ0hMMDBYbytoSXZleWlQL1JGbTB1cytMRiszZ2k1NmtRZFBGSDl2aDFp?=
 =?utf-8?B?RitkT0VWeDhrWm8vVFhPRVJSSDR6c2pLYjdSVERKMCtaMlJFRlVzV0pVMFRQ?=
 =?utf-8?B?QjhWSzBCQ09GVkppR2NGbDBHanlnS1hsSEFkUHNydnUzMzJpWUVnNmw4c2Mv?=
 =?utf-8?B?STNFL2hHV2ZGRjZicm9tVDlFV25uSHNlSm1RdENGTldyYjgzRW0wZHEyY0ZM?=
 =?utf-8?B?SDBwR3ZwODlJbG5MRnJnRHgrV3NHbGVqdlJoNng4Zi96eGg3VGpNdzlnZnUv?=
 =?utf-8?B?WE96SWhDcFZ5bFp1S0Zxbnd5eEdBaTFVMU1vV0hPSVc2TStuOEYrWHlVWHFP?=
 =?utf-8?B?NTlWdkhEUVJJREc1YzJuOW54S09WZkpXaEhJaWZGOE9TeFF6cXZlTEJIdWNl?=
 =?utf-8?B?L0VZeVQrY1JDV0hjUXkvb254UzVGOU1JbEFTVXEweWpCcmZLNXhyS2EvaWh3?=
 =?utf-8?B?VmJuZVlyMXZrZmdaWUpCdnl1ZDZiUDJnV1JjNzIvVnF2dTQ0ZkxWTENabkZK?=
 =?utf-8?B?NnRISEt6OVJiV0ZWNWlSN0VFb2FpOWVxY3E0TmRoMmx3NjdZeWFjNFlUeHFx?=
 =?utf-8?B?M1FRTUFvcmQwclN2QmNiMDFRUG9aQUgvRkZKK3Y5dlJqZkxZMXAreXVkWWdQ?=
 =?utf-8?B?aGl5QVhsRmFMN3BNdjFqL0lJV1IrSDQvaUVrVjhSTlBlQmpoc3U5dk9wcTVU?=
 =?utf-8?B?QzJUUkNzdWJXbEswWDkwc2FLSE1oZzAxVHZuTG9EQzl4RHNsK0RaODlidUFp?=
 =?utf-8?B?d3lJTTVvTlRaZTlOd0o5Ukg0TjdvS2JmclliU3AyWlNFVXJjS3BzeFR6YW0z?=
 =?utf-8?B?OEVLSGFjNkROVitsRjJvWkJUcjdoblpTQmtreEhwdVcwZ21nSWJoeCtkNXA2?=
 =?utf-8?Q?7Gbg+9QHw8Hn5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dERBbjdvMlVkWkNRdndMbHErU004aXd1WEF3RlFXVDcxMlAvNmdSYXFqTXpO?=
 =?utf-8?B?cEwvbnpKUVh1Y1A0a21JYlZ5alBGMXZTWGMwOTU0NWNzcmNOdHdYWVNBOGUz?=
 =?utf-8?B?bzlwTzJKeHZES0JjcEFHTysvalUvR2IwNzZwNmtGTXZWQ082OFk5bTg1M2Vu?=
 =?utf-8?B?dys3bDA2TnZkQ1NjRkZHK01QeTdWOWxRbW83RWpRc3dOeTJ5ZGhKbGNlWUh4?=
 =?utf-8?B?Q2t6czY5U3pBa29RMTVYOVhGb3NUQjg4cFVXL0NqeGMxdEo2ZTNuQlhLaHlC?=
 =?utf-8?B?MGc0SU1XbWlIMTZDYjdpMmJtTUVmbHBBSExERnhzZjZFWlpmZEloQXNrTW4r?=
 =?utf-8?B?bHJBWWtWVmVaRzlsVzVTTDl2eEdwbjVqdWN2TWQ3aERXS2tmZ3hYU3liOU5H?=
 =?utf-8?B?bS8wVjhSenFPM2cvVjhhclg3aHJrZnI4ZnpyUmwzRDV6ZEg5eThHTjhFVFdQ?=
 =?utf-8?B?MDhqTVd5cWpHK1VBNTdYdW9KQUF2a1ZtVDNRWEZ6bGM4QUdkdGZvU0JackIx?=
 =?utf-8?B?dXdEUm8zTWVUZklJZ2d2QXYwaFQrNTZKTldZTlRPdC80WjExbHVmb1hLVmlC?=
 =?utf-8?B?VWRlY1l1NWpUWWNsdmFFakFjTTdXdlR0Ni9sQWxsaU80S0dmbU5UN1oyZ0tS?=
 =?utf-8?B?VUF1WHBVc1F3RXRUWVB0Y3czbGhuN05GT01LOTRnZis0U0kvQXBmUm1RREUv?=
 =?utf-8?B?ZEwyTEp6V3NVTlJzaHdoM2xZdUR0Mm43eEJKbVFRQkcrWVFwdllCNFNLem1y?=
 =?utf-8?B?TWpOVHpzNS9mU0llTVl5WUxLcW1JWCtGN1lGcS9aMTlpNmg3ZnoydVVSYkc3?=
 =?utf-8?B?SmZRMm1kV043eE9OUk12eXVjUHo4ZzExYnUvWHBReXdtUFZxZDZncFdyOTgz?=
 =?utf-8?B?c1hYK0MwM0lmbWl5d3BsNmNWaGh2aTMrQlcxcDFzOStxMWRxRHZMRHNxREM5?=
 =?utf-8?B?SG83dUhKUVQzdFlNYjRtRnhPd0JsVzJsdXZ1a0V4U2pLRVFlNDBRZGRlRkhS?=
 =?utf-8?B?dCt3dlZqU1Z1UENzQXY4eUdmN093b1hyNlBKTGNGalZRTkVEM2tKSTh0RU1E?=
 =?utf-8?B?M2VpcGlQQnQvNG5LUExvdGNnNHl3bWNrT3pkM1NHRkhsN2FuV29IUE1oUk9n?=
 =?utf-8?B?alZMWFc5S1FTOTBOVStIL0hrQmVBVncrdG9KNUY0bFJnSnZ0SGN2VUoxbU1E?=
 =?utf-8?B?QXVpZTBlOTZuMDlkNUM2WDZ3ZHk5azVqejJYZ1JSZHloeER2eTFtVWJtekJj?=
 =?utf-8?B?TkFPa0Mzd1hmc3ZBVmlzTUpPaFVVUWpGQUFESWxTTUlhNmdLRFlVSFp4d1FS?=
 =?utf-8?B?NGZHcEFJalA5VFNzMFd0ajNCb3Z2UEp6bWZadDZCMldaa09GWHJXeE52YWFq?=
 =?utf-8?B?OXBZZ2IvYUJRK0VPd2VUK29WaStBRVFreis3eE1uZUpUbEJqalVnUHlvUncv?=
 =?utf-8?B?OXI2dGxPZWRuUmdsM3NMajBSRDlqaXI5R1k0VVZOZ2d4cklOTCs1NWY5aTl2?=
 =?utf-8?B?cHJLbXhJOWgvKzJiWERsb2JIMG8zTHBxTTc3dEVsWVl1RFFTdzRkVEh1eHZ2?=
 =?utf-8?B?WmdEbkkvTDFPWUh5MUN0cys4Ym9FRG8wa0ZMVGJ5ZG9TUVJnS1JVSG1xUFN1?=
 =?utf-8?B?aTd0dGZJZHhqVjN3QWRBN3N4akZjQTdiWEsxVTREcFNFU1NiL2RHRVM1L215?=
 =?utf-8?B?TEhUdWxTcW1OVlFkUHVZL1V3bDg1cGFoODNUcGNDSEpnbFJXZkNHM3pMem1x?=
 =?utf-8?B?VWJqQnJza1JKSGVaSm9sTk1PZUtRNzZaWmVyTFhPMTFRTXNRNy90R3ZZalVq?=
 =?utf-8?B?KzNEaXRFQVhaS0lzNHpBam5GZ1NYM0NuOFV4LzhJUXo5RHJBOEdyMTRsak5Z?=
 =?utf-8?B?TnZSUnJCQi83enk2c0hsK1llOWY3MEZzOXcxZzR1OUdsVDk3WS9ZRERVeVpC?=
 =?utf-8?B?YVoydDhRbXFUcmU2VHN1SXVYWVBhUGM3dW9zaFVLQVpzRXpldEpmZ1VobkxU?=
 =?utf-8?B?VlJSaXFNQzZXUlVnQ1hzaXdmc0trT3V0ZDFSZGJrS3lYTmw5ZWlUTXk5eHRY?=
 =?utf-8?B?MzFMaSszRXREaDJxZlh5a1UxOTZ5NElVZVlZN1BZWGxZbFc3VTlLMGhYYmRk?=
 =?utf-8?Q?GnT87Y7goxcvOmcl7PZZGvU4F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38754106-4339-45ef-e52e-08dd5ca065d1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:16:53.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nU1RmSow8M6dMGUGGkPh0XgZNXrDwqtdic5JQ+hwT38adVr2CbUwbkwFRGUhzmbqDpy4uwZ59l46uQl+bHYn2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/6/2025 2:17 AM, Alex Deucher wrote:
> Plumb in support for disabling kernel queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 114 ++++++++++++++-----------
>   1 file changed, 65 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 8a448a20774a8..8fde7b239fdbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1453,37 +1453,39 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   	}
>   
> -	/* set up the gfx ring */
> -	for (i = 0; i < adev->gfx.me.num_me; i++) {
> -		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> -				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> -					continue;
> -
> -				r = gfx_v12_0_gfx_ring_init(adev, ring_id,
> -							    i, k, j);
> -				if (r)
> -					return r;
> -				ring_id++;
> +	if (!adev->gfx.disable_kq) {
> +		/* set up the gfx ring */
> +		for (i = 0; i < adev->gfx.me.num_me; i++) {
> +			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> +					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> +						continue;
> +
> +					r = gfx_v12_0_gfx_ring_init(adev, ring_id,
> +								    i, k, j);
> +					if (r)
> +						return r;
> +					ring_id++;
> +				}
>   			}
>   		}
> -	}
> -
> -	ring_id = 0;
> -	/* set up the compute queues - allocate horizontally across pipes */
> -	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> -		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_gfx_is_mec_queue_enabled(adev,
> -								0, i, k, j))
> -					continue;
> -
> -				r = gfx_v12_0_compute_ring_init(adev, ring_id,
> -								i, k, j);
> -				if (r)
> -					return r;
>   
> -				ring_id++;
> +		ring_id = 0;
> +		/* set up the compute queues - allocate horizontally across pipes */
> +		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> +			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> +					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
> +									     0, i, k, j))
> +						continue;
> +
> +					r = gfx_v12_0_compute_ring_init(adev, ring_id,
> +									i, k, j);
> +					if (r)
> +						return r;
> +
> +					ring_id++;
> +				}
>   			}
>   		}
>   	}
> @@ -1572,10 +1574,12 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	int i;
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> -		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> +	if (!adev->gfx.disable_kq) {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> +			amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> +		for (i = 0; i < adev->gfx.num_compute_rings; i++)
> +			amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> +	}
>   
>   	amdgpu_gfx_mqd_sw_fini(adev, 0);
>   
> @@ -3418,6 +3422,9 @@ static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
>   	if (!amdgpu_async_gfx_ring)
>   		gfx_v12_0_cp_compute_enable(adev, true);
>   
> +	if (adev->gfx.disable_kq)
> +		return 0;
> +
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		ring = &adev->gfx.compute_ring[i];
>   
> @@ -3477,28 +3484,34 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> -	if (!amdgpu_async_gfx_ring) {
> -		r = gfx_v12_0_cp_gfx_resume(adev);
> +	if (adev->gfx.disable_kq) {
> +		r = gfx_v12_0_cp_gfx_start(adev);
>   		if (r)
>   			return r;
>   	} else {
> -		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
> -		if (r)
> -			return r;
> -	}
> +		if (!amdgpu_async_gfx_ring) {
> +			r = gfx_v12_0_cp_gfx_resume(adev);
> +			if (r)
> +				return r;
> +		} else {
> +			r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
> +			if (r)
> +				return r;
> +		}
>   
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -		ring = &adev->gfx.gfx_ring[i];
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> -	}
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
> +		}
>   
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		ring = &adev->gfx.compute_ring[i];
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> +		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +			ring = &adev->gfx.compute_ring[i];
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
> +		}
>   	}
>   
>   	return 0;
> @@ -3791,6 +3804,9 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +	if (amdgpu_disable_kq == 1)
> +		adev->gfx.disable_kq = true;
> +
>   	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
>   
>   	adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
