Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ED9C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 07:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E3310E908;
	Thu,  6 Mar 2025 07:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNj+F3WN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7540710E908
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 07:37:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTLICL9h+HKMsykD+f/V9vx5RhxlSJP6fhz1UxAONK6nHVRr2mgP2JrK8UDQdtEP5xxV1qP42/qtacBtCIS2ELPuvrr83cS5/F+WNaUS/C47kgCT5Gzw+W7cqp+JO9l46Y5PXdkD949ch8ZOENxy8sQ124ofJdFj1nHW3dCUutoWxb+2P/CQQm5PbRzYHgG/fSVqGdgfUBn7qSY5CQ5U05c8lT80objTxjBZTui/7Q9bcI16hvpVhHVJ7UqrOLHwVLxMk9EW4TVU8O2I+p+jJPKpnxfF8wZytAzJcNRyoFmlTWMloxl2in4WY+y5rA2l7b/7eTna9g84p+ezwHA/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2uLgcULhSscG2VXl+tqM+J/x35OLy19VSSukd3LF/s=;
 b=abzCzdbiRygFWtzd7yuEFHjmS5CXa4nxczaExfZjlEXd/vhny28uKKTFWlKDWbThwFURHP27/hYZzlaIHYPW6L3H4aMi6xlsZphX1VWPRTzUWGnTdtwalQIvZ45ybGBPSmQWaVfTIOrlbyfbDoQk7Zglu1fcDA26jX+2zX+tG+/Q2UJIXKuayRiqOyp1xntESjfIf4O7RY5pVXY1SMFxUMwojKe1afaFen/QncL/fUxCLkueziSr3qeBjbJpXCXJ3Gis5NZMzfx4j5/m3UCbHULdidfACXfLnb3C5Fvw8xlF1/AbleCFwoNQ157YWXT+vb3ainzisE4VwfhDbfV4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2uLgcULhSscG2VXl+tqM+J/x35OLy19VSSukd3LF/s=;
 b=UNj+F3WNieXH6dw5hRsyxiEdgFHuQ7mR70YP41jCNFvZvWCus/wFa2uvT9G9QIHPJ288PtLHyZuSBh8FHxt/0D0UEgO5e2FJxoslY47e1VFvh82a5WQLSoDoOSLHs+X+jjT5UAyHTOHu/5vO5mcuXbtWFI1kMtpfNllc5BuFRj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 07:37:06 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 07:37:06 +0000
Message-ID: <3c2eca14-62a4-4b30-9250-87bf4444213f@amd.com>
Date: Thu, 6 Mar 2025 13:07:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/amdgpu: add parameter to disable kernel queues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6871db11-eaa8-40f2-a820-08dd5c81b17f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkhqdElEOFJuS1dMa0ZpVU1rL0M3Q0dhVVh6M2NnOG9mTi83LzZXV2pUNDlh?=
 =?utf-8?B?UlM4MlRyNHluQldVL0Urb29zN0ZiR3dLUktvcGlSS3RtWnF1bldzZXU4MjJH?=
 =?utf-8?B?KzdhUTRRcDZPcitoVFFrSCtxS250UGpWWWh5WmRLQkxWNG9DWW5xSVloYUZu?=
 =?utf-8?B?enA3KzRKZFVNOXBmUmhmajZ1cUZpVlMvSUpFY1BMKzhqWFMweklkeHlsSmRm?=
 =?utf-8?B?dVEzbzJiREZXanFJOEgxZGFLeG02UG01S3ZBZk84V3NVRzloTXcwenZJSlZi?=
 =?utf-8?B?U2kzMXh6YUpqUzYySWhJT2ZhZ3NyVU5ibzZNcVQrK1RiR0NiT0ZlNlNLKzdt?=
 =?utf-8?B?OWxldmdlbm1pd09KMDhhcHVQaStHNDhDZVFuNUJ6cm9jSFFTQkc4K1NiWWEz?=
 =?utf-8?B?TW9Ia1J4dmticXRDbFczdTA3MVhyajhGMXlrMUJEL3l0NzdlaEZzeWFTbnJl?=
 =?utf-8?B?UGszTUY1TExyQWZWOEJKaEVMa3ozM3A3NnN5aHJUOWwra3lnVzQzYWppNG0r?=
 =?utf-8?B?a0RyREI1dnUrZlNpcDFNYzJsd3ViZnlvUHFJQjJCazV5MlAzeWU4L28rQlE1?=
 =?utf-8?B?VVFqeXo1UnZPemhJamYycmpFWFhjRWUwWXdNWGlpTW9zM3UzcXU0WUtwd01y?=
 =?utf-8?B?YkRibmR2MWtJdExFR2doVFoyd3ZhczNGZkoreHRrV2s5amx4b1NhSGlTK3Bj?=
 =?utf-8?B?dnUvNUdNcVVxUEg3THlLUGg3dGNWZmJFWUtHSHIxdlNybVVMeTExM3hNbUV5?=
 =?utf-8?B?VjNZSXhDSzcxODJ4TzZ6cUNOSGZCaVU4QXM3TTI0ZzNRc09QUzZmT0tyZGZM?=
 =?utf-8?B?ZjR6RGV5cHlQWUZqL3Z0anNaREJTYUFZMjdOMi8yL1ZZMGFPY3k2ek1XNVow?=
 =?utf-8?B?akNCalpNUlpiWmNnMUVNT0JOTkFMWFJMMllvS2FoRnJEUlpOaDZzZ1pJQmV0?=
 =?utf-8?B?MjI1ckMzN1NzY0tKYWZ1T2NFQ3VPN1JlZzg4WnNTR1ZhTXg4T0d4MUpvL2Zk?=
 =?utf-8?B?YVJ6MmJsT3cxRjBjaWNsWFcxNklNQldpa0pGbVJha2ZTU1ZFYk12bURORFdU?=
 =?utf-8?B?SmRkQXdkYlRRbnVJOFVReUNESTBueW92SGcyQXJiaVZwd3V4RjNVRzJZMm9D?=
 =?utf-8?B?ai93NTM5V2VVaU9GRldyczFucVBOR2pZNXZ6SWd1QkUreXUzQTB6SnBOOWVK?=
 =?utf-8?B?cEx4QXpMTm9EcWVQWk0xeUYxTFZlajdpU1FSbUJ1U0ZpNWVoWm45T2wxeUc0?=
 =?utf-8?B?dzZGZlhJTFU5VmJGY3oxWEh6Z2pEc1Yvc1lwRnpFVkNRSWl6VHhIUkFMejlh?=
 =?utf-8?B?dGJsSVFINE9LTEdlYlZocmY1Z3ZNcEVPSkd3Tlp6bDBSMDNLMTFzODYzZlFt?=
 =?utf-8?B?WnVsWmE1UXpIT0E5d0NXcUpMeHRQK0JnQ3d0Qm9VTEx3ZFA1aWlrTVAvQTBr?=
 =?utf-8?B?MlNFMjlnS2hxNk9sanE2UGlUSlYrUHIxUGMyTzdkdnJDeE1IZzBiZmcrNk1T?=
 =?utf-8?B?ZzdDazlxQlM3K3BpYlJJM1cyWCtoU1NIWUxsODNQbVdTblBPWm1JYzRQajdE?=
 =?utf-8?B?a1lzdFBGMGNkcDg4dnMzN0RVRk1LbEFqejI5N2dNQlFzRzhLT0xXcTBZUmpK?=
 =?utf-8?B?dVNEek5Jc05BWUFicEg4dGV0NHR1Mlpza2h3dnVwTVR1dnFtNEsvaXEvdnVx?=
 =?utf-8?B?ZnRJVTVaSElYREVMREk0d2tsa05ENy9rUW5wZDFPSkxIMkY0YXd6TGtxUjE5?=
 =?utf-8?B?QVZnbjRBU2FTaVMyYkRWaDR3blNLb3Y5eW9RRGRLR0RVSElKcVc4SGFHNnhR?=
 =?utf-8?B?VndsOThDWmVUL0hySVlWTEhsRzk2VmJGRTlqUFBsV3R0KzZMejRuQkN0ZnJC?=
 =?utf-8?Q?bpUehvd1i0VU6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21lZlVoQ2lpVzlDN1ExanJkVmxSTWlKdzVHb1BLaDZ5ZENkQ0M4ek9LYVlZ?=
 =?utf-8?B?UTg2enRaOVJEekdXUmtOQzhQTGFGaUhoVlVnMWVmQ3pRNEpnc04xUnZqOXNy?=
 =?utf-8?B?Kzl3MkkwZzlzWC9wVU0zT0huK2ZuaHc2bWVXUWxjUzZLcGdJNnorQW9Qcjhz?=
 =?utf-8?B?MUdLUnp4UzdhdjZGT1lUMUpMcGQzeTlXbTZlVXNjZllsVkJZVjl6c1EwbWp0?=
 =?utf-8?B?VFBoZWNnUDVRZWhNSUMyVFlRU0pkZ3pQR1FBTWh1SXc3WElaeVNndTBLOExw?=
 =?utf-8?B?YlQ1dE82RFdOU2pyL0xFdlJKdEJobkNYU1hGYXlQU2FEcTFtcnl1dDNpT0Vw?=
 =?utf-8?B?MWNDT3pSVjFiUDFqZFZvM09ZNk9uNUdMQjQ4R1FJWFBXODFsOWJqZExUK2NL?=
 =?utf-8?B?Q2lMRWZVN2ZQTTBoczdFUVhCZGVHUzZ2bnZCcm5QQmZTNVV2VWZkY3p1OSsv?=
 =?utf-8?B?SkxLWlBCS3h3dmx6ckJUb1NraHFmdm1GR0JsT0JGQ0c5ZnJKM0ZrVnQ0TXY1?=
 =?utf-8?B?NWNjRzJkRXRwNG5Oa2R2cFBaOWRIZzdUSHk2YURBZXN1NGtIdGFkMmNtSERP?=
 =?utf-8?B?RHNGYzVOL0xQVG1XZnBlZjh6cFJzZWlzZDVETStDWmdlVWU0c1JmZ2l0QzZW?=
 =?utf-8?B?N3ZMQldlcTkrZDlSLzBES1ZMcGpPWTBJL1NTNUVtS1FVVzBXQVpvY1dGc1VX?=
 =?utf-8?B?amxWV1F1K1NRZDl2dTJUaVZhR1BxZGxWVko3VVZzKzljRXJzTUViN2RWQno3?=
 =?utf-8?B?TmlFN3hxc2hvdHdxQzEvQSszd3Y2QUxiWFVsRlFNWWFvOWJiNVBsTHVrcXkr?=
 =?utf-8?B?RHh5NythMkpNNkNDWVNlUTFzN0ZVenVqUU5kcTFqZkl5cTlSK1hpSlVUekJr?=
 =?utf-8?B?bGk3b2pDUmRlMGU4eldUeGFVUUl0WWM2ZTNNd1dDZ1VXdEtJZEIxTUtKUGxO?=
 =?utf-8?B?QzRRd2crTHUzRXVXTXVMNFN0MDJyNUhqajNYbzFsZklRcWpQNXByd09qOGRM?=
 =?utf-8?B?aGVHUjFIRko2WTMvOGNaQmtqVXBoV09UOWFPbEo4UUZYcFBUMmJhcFpJQVdr?=
 =?utf-8?B?VUtIaWFDOVFaYmZJVjBqcDJvVHNOYk9la3E0N1EyV0IvWTBKcTVUMWJtd1Qx?=
 =?utf-8?B?dlJWQmY1WldscW50V3NEc3dLaWNIb3RVUHYwbTRwbUNkclZVTzcxNHovWVhT?=
 =?utf-8?B?b2YvdnBZZDVHZzB4VmVoSy9uR0lnRVBpaXNsMmFsRWg0T0UzRDN2Q09oOUpM?=
 =?utf-8?B?L1M2NU9nc3VHTE9aMjZkT0FrVmwvK1l4Z3R6djVSNlU5Z0Q4N2J5alJMc3ZL?=
 =?utf-8?B?ck9PRnBNcXJHK3kzTzdNQVRIVkVPV05pbnpDSzZPQUFwazcrMjdpY3lDVGVS?=
 =?utf-8?B?VC83QnlTeG8wc09hQmgzbTBOdlN6Yi94WFd2TVpsM2t6SFpWOW5uMUFqejNm?=
 =?utf-8?B?YXMzb09ISG5wdGluSk1SZTBQU1NtZWl2NVdvM1JKVzd0NVNDb0IvTndxTDVs?=
 =?utf-8?B?ZE1kdEFJZHBLSXN3RVhnblZ2Vm9vTWV5cUo1N3RCd3FlV0I2dm0wVGJsaE1i?=
 =?utf-8?B?WlRIamt1dHhUWk04aE1sTk1XWWlwU0k3MzliVmhxRDJPQ1hWZnpwbWRXWGR1?=
 =?utf-8?B?b212NWQ4T0VWSHVSQUJWQkNtZENVcnUwaXJmczZkM2xobjlQdTJDVFZMZzJp?=
 =?utf-8?B?MjRUdWpNVm1lcXJQV0hVd1Vtb0dsK0VBVEd3TW83NENKeWZaSlEwYUQ5NHl2?=
 =?utf-8?B?ak14Mm9uRjI4WFpEdzZlaGJ1TERQYVliN3hQMUd6TDdhblMxb1ZxdGw1bnNS?=
 =?utf-8?B?aWt4bE9nTU40LzV2cFhkVGZTK3kwZm93V3V1STZBRGRFLzBkOG1DakVJQ3FZ?=
 =?utf-8?B?Ty9nYjNjMHFWb21WUE9EaGU5Qmx6ZkljRjdmbUV5dFJMcG1pVmtoOVRhZ0pF?=
 =?utf-8?B?cE5oWUlVUmlzc01ieVZjanBGNkhiOUc5VGJ5aWJtbFhQQXNXc2VaMnZTVEVJ?=
 =?utf-8?B?b1RqOUlHQVBmNGZtL3NlNkFzelk1MUwvZnBabU5xSUpFNmg2SnN4NDJaRTZN?=
 =?utf-8?B?Rk9KbWs4akdlUDUxdXovd2FPWVpnRU1MMUhpZUJhNEt2N0t3cjJORFAwSnFo?=
 =?utf-8?Q?veRb1ZJu7LD2TS1HwiUKq/+Sd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6871db11-eaa8-40f2-a820-08dd5c81b17f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 07:37:06.3083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ii9Mw1cyJw+lszPgtLrDBxqmHVZ/ISFTC80n2CWrZuYntqUt7k/wgGplSLi338FqUro/PIcwXwSCh2BBmkGxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
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
> On chips that support user queues, setting this option
> will disable kernel queues to be used to validate
> user queues without kernel queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 87062c1adcdf7..45437a8f29d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -270,6 +270,7 @@ extern int amdgpu_user_partt_mode;
>   extern int amdgpu_agp;
>   
>   extern int amdgpu_wbrf;
> +extern int amdgpu_disable_kq;
>   
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b161daa900198..42a7619592ab9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -237,6 +237,7 @@ int amdgpu_agp = -1; /* auto */
>   int amdgpu_wbrf = -1;
>   int amdgpu_damage_clips = -1; /* auto */
>   int amdgpu_umsch_mm_fwlog;
> +int amdgpu_disable_kq = -1;
>   
>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
>   			"DRM_UT_CORE",
> @@ -1083,6 +1084,14 @@ MODULE_PARM_DESC(wbrf,
>   	"Enable Wifi RFI interference mitigation (0 = disabled, 1 = enabled, -1 = auto(default)");
>   module_param_named(wbrf, amdgpu_wbrf, int, 0444);
>   
> +/**
> + * DOC: disable_kq (int)
> + * Disable kernel queues on systems that support user queues.
> + * (0 = kernel queues enabled, 1 = kernel queues disabled, -1 = auto (default setting))
> + */
> +MODULE_PARM_DESC(disable_kq, "Disable kernel queues (-1 = auto (default), 0 = enable KQ, 1 = disable KQ)");
> +module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
