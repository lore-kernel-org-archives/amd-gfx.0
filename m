Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3738C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 18:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C57010E4E5;
	Thu, 15 Aug 2024 18:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wiJHLqFG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C265D10E4E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 18:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtdYfOHBJWQHvd53vehZXIsYOH8RgJ+38YMChH6sCqocwkLjxc0X1blpYgAHUETHHNsD73OqmOyvw6E30TqLVuLItAmLtzvcDU+/N71C7D4sieY+uB7oeqXVrcvPsHhAl+aLAD584/jgNJl13W67vjKNQVUDr/Y+d8htZXbjL1WBEauCXD5oKpGrN4aU9OLT3Gm+Dfuu6offuQJeW1O3J/1WA5tzz/xDoJKhNK4rg00aztQt1kga6BsR5LnYVcI+dw9y088kZEO/FStNPg0u2NgwTq3885WjhWglV4RQes2avcVkF6Ck/AKTIPAB9vAAALGATRTKyNuMCsZ6BKg3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OHUkTaiW4IiXzmnePFh5mP64xJ6Q+QC0s4iERwz4uc=;
 b=u8eVkQZQPnrPYindaxok1uyxGVjCT9zw4siNCNreD4l6DlmAVNR3JVw0RMz0lhtfXHv9cyIBpqAQB+A9GaRCwQInO7qCOZgsUgD8ZbSr9U51/9j0mDGvHvJoav00K5UHRg1bxfalhNEnW+Sy38dk4NvjcHIpT1xZHJz1v1tspFPTyRSKqszV9+Eg4cZ67/tLT+vgUsG6AIHB32q9etGnhQ0+fekrpZaN79UVj1EbcCc2wtxH2z1jC8OktGf0U+t6HEy2XJCX6HEfyg1y5dbgNM4pFs4QYiV8NuLVo7SxHMCdbjJo8SqbQDbUVU4IO5aZAM/OBcPX/TOcrlBnf3ZIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OHUkTaiW4IiXzmnePFh5mP64xJ6Q+QC0s4iERwz4uc=;
 b=wiJHLqFG1/CifO282sVQBoET28D3kYvOYj+CtNgLtyHqRlkBf3ePHZuDLkVEa9GxTSC+21XXGG7ajSzqnRFDj5JOSv2pOrTTMPWsFFKvioe28PJ6LcFH3V4RRf8ZccazYlUG2kd+cAMzdUkb2/TRlKRzvWvMuxl4uZSrTcR9K/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 18:25:17 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 18:25:17 +0000
Message-ID: <e60025db-2cf9-4976-9351-67a69973f6b5@amd.com>
Date: Thu, 15 Aug 2024 14:25:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
 <20240814232754.1119319-2-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240814232754.1119319-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::30) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd8e543-036f-43d8-1b54-08dcbd579cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1BYdmQwQllFMFBLMmJRa0NJNVpyTGpLbE5NcGJuSm1YMDB2TjlIdzVoRDhP?=
 =?utf-8?B?cWQ2S1IrUmJvY1B5eFV1eGJtVDY1UDl3R1NiUk1LZEIrSmdTbkxRTVMwUTRw?=
 =?utf-8?B?N1dheXp0b2lBSUllOHI3eHJaWE9sVDhjeFFiZkdreDVZRFZnSENXVmFSTUNp?=
 =?utf-8?B?RW43MFBDTjBSK1BMRWZza1pXVmhlL2ZQNTZ4b1JidWk1aWRoc0JSTlViKzEv?=
 =?utf-8?B?QW9nN2t1dlNMa25MZE5lK3lyMGRkN2tVZTBTbTZPSHVCL2h3QjJJOVh4cFZI?=
 =?utf-8?B?endkV09DN0hXOFArNHp3d29WeVQ5ZDFuVi9KWjZoRFVjM2NkMlNJTlloaU1B?=
 =?utf-8?B?eVArZEp6c1FSRlNmbG9TUEd6cURBc2orUDlTcG9ud3ZObFhLbWVjdHc1R2NM?=
 =?utf-8?B?TUZmZk14cXRSTHF0MzBRelpoRC9Nbm92aGdEa0U2ckZyU0NEVVh6QTQ2R3gw?=
 =?utf-8?B?cDl6YVJUblFMUDk5S3MwVnptOGV3dEp4NGhrT1JLZHMzaWVlUnUya1RwSkN3?=
 =?utf-8?B?ak9OeU8rUEhTK3Y1VVM5c2Z5bk0zaWE5MGZXZVd2eG9kNUVvV0Z2N3dDVFo2?=
 =?utf-8?B?b1o0SWQ1MWRFbk1QQzJ3b1RKWWF6ZENFRUdVVmZiempLdG9IRGNUaVZ6c2x2?=
 =?utf-8?B?UlpqYnJBZUFBeUszUzRQQzZpRjhwRVJPOTJxQ3hwUGZsblcvSCtRSzZRZ2Er?=
 =?utf-8?B?MWM3YlVLKzN3VzJYWUNubVl6Z1l4a2ozWmdhSkUwRiswV0NCdzkwOXpvTDh6?=
 =?utf-8?B?RktmMTAyV29zMUEzSm9LUWpIYVJhM21KeEFVNnk1Znh0YWw3YTFRQUprc09N?=
 =?utf-8?B?SmozaFhuU0xXdVB2ckkwT1ArUkl6cTVJUURiMnJoazFlUGlQY0lESm9GMFVr?=
 =?utf-8?B?Vk90L3I5K0xMWDhLRTRCQ3EzdVI2clBTQ0N5OU1heGNkazk1eUxCb1RwdUEv?=
 =?utf-8?B?cHo2SjFvNkxzMk1sZEVPNGlsQ0lKQXVWNExJYjZnQ2hQS055c1Z1aW91Witj?=
 =?utf-8?B?clpDdVZEL1RGNUl5bkFwNkYzdjk3VHI0b0FFbFdSMy9VRS90c0FibXlWcnl6?=
 =?utf-8?B?cFRVTXBVTHhDcDU2bXpCZjQrMU50V0tJa05obzZNUTYwSmRFdHltMHpkQk1r?=
 =?utf-8?B?SDNnRzB1RzdXVWhpd3VzNDlOS0NDVlpHSEhnaTdIOEhlV1pKQThacGVkRm9s?=
 =?utf-8?B?cGxpNTY1c3RkTDk0dlJQRnhuY2ZaeTJnamhwNVpwYkh1WkwrNzg1c1FHc1Bu?=
 =?utf-8?B?bzhJamRpdEZVY3BwSXViMzJORXY5cDNTYzBMNC9OK3o2djNVemV2VVdhL0lx?=
 =?utf-8?B?enVic00yOG1OeDhFeWlIS3Z1R1FoU3Q4WU1KV0M2RytUQUg4WDFjTHJSSFRB?=
 =?utf-8?B?TUY1S2g2ckcvM1A4RUlWVEM4SG1qbWRmM1MvTzA0S3c3VDl4ZXlsQjkxT0E3?=
 =?utf-8?B?S3ZBWGhJd1ZDOHozRXV6WHpuS085ZVNWYStWU0FUOW10Z0ZxWUFiQ1piMHFX?=
 =?utf-8?B?TmMzakVDUy95WUdIVFltQ3kzQlBnVmZNN3kxTWxiOXo3Q1owcldVUzBEcmx4?=
 =?utf-8?B?dXEzL3B6ZjhZN3VSTzIzNG5DRzlJcmQzcVg1THFpZ0sxaVIzc21Ja0tteWp5?=
 =?utf-8?B?MTE5MWh6NThGZE1KYkVsdC8zcEQrOGUrSW1ZbkJxNFlaZDBXRmhVa3dqQTBQ?=
 =?utf-8?B?aGgyMS9tV2lGdmpQUUpUZFhiTStaelc5Q1lEazdySUlTUWNxYzFraHpzWUd2?=
 =?utf-8?B?cno5bUZsandVV2FyRFlBZmZKVlgxK01xNmo3TnRLVWRzVTdBa1VoOUdGVEVw?=
 =?utf-8?B?czNaQ0pkaDdYamdhNnp5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDBPa0VKdUtZVTdweUxOc01pYnhsMjVUajdqbUFlc1RGWTU2bzRVVlNIN1JP?=
 =?utf-8?B?eFRGK3RmVTUyOGswVndlNFlZdGVpVHB5ZUhoMmxLZkszd0pyKzU3YnZHRXFG?=
 =?utf-8?B?amN1Ym4rMnY4RmRHSGUzMnlrczR0Rzh2RkJueGtLWnZ0UkRZVzRGc2pId29v?=
 =?utf-8?B?NTZXNHZzYnVveWhyRVJWdFNxME1LVzhrZG5uY2J3SVN3bEhBdHlHcW81MWpM?=
 =?utf-8?B?MTVFTXlBQVB2TWQzT05vemN2ZTdhVkJwMVlOS3p2SVpLb1R4K1IxUVpXZThq?=
 =?utf-8?B?dS9DUEpGNnBpdVg4U2hmYjFpeEtaUGNDbXlNaTdJWjdtUnlYdkFFRjZiQUZw?=
 =?utf-8?B?MGdZMmV0cDFoMi81bldjUjFvaXkycWI0Z1Z4NmkwdFVnZElabk4rOW84SXNo?=
 =?utf-8?B?S1U1YmdoaDhXcUZPMHRtTWZGSVo5RmczTnh4OXBVU3RUYzMrRlNuWnB5Nkxp?=
 =?utf-8?B?SzZaeUh1MGwralpSTUEwS0xaSWhyVjAxTGpHaXQzYUUxZGo2U1B3bndGaWpH?=
 =?utf-8?B?NTg4OHlMRzV4RHZKU0FaUnpuSno1T2JuanVJbGxKTHErbS8wWndKTTFRU0FR?=
 =?utf-8?B?K0RGaS9zc2RNSnJpRDBuc3N5OXZEalc3QkVqaXlZcHJQZFhDN0sxOVZVTjY0?=
 =?utf-8?B?aUlpRE4vR01vbUV3U0ZLcittQjAyVkdNR1d2SnRiNm5vS2o2SUpLVGRSaXh1?=
 =?utf-8?B?OXk2bkkxRGFJZ0ZiNTRGT3VuLzF3Q2NYazFyVmVEMVAvb0JKSlp5WDFHbjBp?=
 =?utf-8?B?bjJSck9yTU1NODVwUFR0cVhuNHVJMDZQbnNqVEpKYW1MbHFJYWJjQTF3Zml0?=
 =?utf-8?B?dTFneGc3eHNRdlozN2ZhQndSNVJsa2IwcHY1OTdkWFlGTkRFOXo2RWowajhu?=
 =?utf-8?B?eUo0SXUvdlkzelZQNlVhaUp3YzZMNlpyenJuaDNrek9rSDgwSXhsRXNxVDB5?=
 =?utf-8?B?eWJpREx3b3hGdlF2aU4zQ2Y3dGFZalp0SG4rZnV2dERzdW5BcTArZGU1WHZ0?=
 =?utf-8?B?d21JNld1aFZvNVFwd3lFZ2lTd1NMdWF6RzZOaEdPRkkrNmUxVzFMTUZUcFZJ?=
 =?utf-8?B?OUdRV2I1KzlJZldnM3ZHSlRNMHdVcTR3cy9ZajRvVHlsTnZDem04ckhwWVJx?=
 =?utf-8?B?TjI2bE1ENDBlZEJTd2I2NFNKbENGczNYcExqVmpwbHFQSUJMdWZCM0l0TkR5?=
 =?utf-8?B?SFQreGlyT3lKKzk0S2tMVGVVOXRWRzUvQVFFbWgxTktnTVhVU2tHL3FsSEVt?=
 =?utf-8?B?WStJZi8xMnpKMmg1R2xuQ3pIRHFZVmhkc2JsUWdXSHcvZGp6TmlteDExSitZ?=
 =?utf-8?B?aEhRMUFUT3ZiL0Nta2djRWVxYnJRL1NGV2JPak1vdVJKWVEwQk9GZ095WVQ4?=
 =?utf-8?B?TVdSSm95YnF0OWtyeEJPYzBtYVNjY3ZSWGh0aElHdCt6dlVpekxSQzVLQ1dI?=
 =?utf-8?B?M0ZMYWpwdEppR1ZZdGZySnRsSnpCcFRDMUMvOStZUkhmc0xzbjNZSnNWcmR1?=
 =?utf-8?B?VENvU0ZFbzd4TWtmSExBNU5FSTJ1ek9rNFRvOTFIbEd2WWpJaHA0RUVNWkJo?=
 =?utf-8?B?SmVlYUNTbnVtbHk4S1lwSDA1a2NoeE8yNTJsS2tpanpET1BWMHJPVk5WMmxP?=
 =?utf-8?B?L1kvQnFTaUg2YklyOHVRTnMzbTYrSE1ZdGthZyt4SVgxbEpwZVd1MzhDTWph?=
 =?utf-8?B?ejNGUFpibGNDZmNxSGh3SEVNTlVaaFlIcGRmODRGaFZ4aHNuZUVpblEyTStH?=
 =?utf-8?B?ckJWaDFxd1lvWk8yVVlUUFF1KzI2d3JRM0hvSXc4SDJOY0JEcDFiMHRqYkhx?=
 =?utf-8?B?eXltY3QxeUtwdFRoTHFIbnFoNHcrOW16dTdJMEcreDZ1Y294L0t6NXhkWXow?=
 =?utf-8?B?NTRBbXREZWxTRmdxdE42OXVSdXl2b0tBN2piWUFFNzc3UVF2ajdmdjlqaEFl?=
 =?utf-8?B?cnRtcHpyRC8wNnJUYWJ6RTUvRzFqQTd4VnNUbEdCbHZwZVdOY1BYZElJeWRB?=
 =?utf-8?B?ejhLc3JtM1hiT21rc2dMeFRTMGtkbUl0ZGxiNUJvQSt0TXNkUXc0czZ2ZHVn?=
 =?utf-8?B?T0dFbXNpKzAvRzk4dW9uZVlkbWdOWm84UC9pbjN1UzBmNEg0azVqS1ppNEJ3?=
 =?utf-8?Q?PUhPiP4uiVSrzjAE7dDzH1RNc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd8e543-036f-43d8-1b54-08dcbd579cf6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 18:25:17.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LTyvqGijaraDDt8Xbm9RpLP3p91uWycWpoyJoaAnogbXFtjgPL/tCdNlBduSgRrHPypxluUtHzzHV1bEsIC6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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

On 2024-08-14 19:27, Mukul Joshi wrote:
> MEC FW expects MES to unmap all queues when a VM fault is observed
> on a queue and then resumed once the affected process is terminated.
> Use the MES Suspend and Resume APIs to achieve this.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Add MES FW version check.
> - Separate out the kfd_dqm_evict_pasid into another function.
> - Use amdgpu_mes_suspend/amdgpu_mes_resume to suspend/resume queues.
>
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++++++++++++-
>   1 file changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f6e211070299..cb5b866eee3b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -319,6 +319,42 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static int suspend_all_queues_mes(struct device_queue_manager *dqm)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	int r = 0;
> +
> +	if (dqm->is_hws_hang)
> +		return -EIO;
> +
> +	r = amdgpu_mes_suspend(adev);
> +	if (r) {
> +		dev_err(adev->dev, "failed to suspend gangs from MES\n");
> +		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
> +		kfd_hws_hang(dqm);
> +	}
> +
> +	return r;
> +}
> +
> +static int resume_all_queues_mes(struct device_queue_manager *dqm)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	int r = 0;
> +
> +	if (dqm->is_hws_hang)
> +		return -EIO;
> +
> +	r = amdgpu_mes_resume(adev);
> +	if (r) {
> +		dev_err(adev->dev, "failed to resume gangs from MES\n");
> +		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
> +		kfd_hws_hang(dqm);
> +	}
> +
> +	return r;
> +}
> +
>   static void increment_queue_count(struct device_queue_manager *dqm,
>   				  struct qcm_process_device *qpd,
>   				  struct queue *q)
> @@ -2835,6 +2871,40 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
>   	kfree(dqm);
>   }
>   
> +static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd)
> +{
> +	struct device *dev = dqm->dev->adev->dev;
> +	int ret = 0;
> +
> +	/* Check if process is already evicted */
> +	dqm_lock(dqm);
> +	if (qpd->evicted) {
> +		dqm_unlock(dqm);
> +		goto out;

qpd->evicted is a reference count. Without this shortcut, 
dqm->ops.evict_process_queues will increment the ref count. You probably 
need to increment it here before dropping the lock. Otherwise two things 
can go wrong:

 1. The corresponding dqm->ops.restore_process_queues will underflow the
    reference count
 2. A race condition where the queues get restored too early

Regards,
   Felix


> +	}
> +	dqm_unlock(dqm);
> +
> +	ret = suspend_all_queues_mes(dqm);
> +	if (ret) {
> +		dev_err(dev, "Suspending all queues failed");
> +		goto out;
> +	}
> +
> +	ret = dqm->ops.evict_process_queues(dqm, qpd);
> +	if (ret) {
> +		dev_err(dev, "Evicting process queues failed");
> +		goto out;
> +	}
> +
> +	ret = resume_all_queues_mes(dqm);
> +	if (ret)
> +		dev_err(dev, "Resuming all queues failed");
> +
> +out:
> +	return ret;
> +}
> +
>   int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
>   {
>   	struct kfd_process_device *pdd;
> @@ -2845,8 +2915,13 @@ int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
>   		return -EINVAL;
>   	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>   	pdd = kfd_get_process_device_data(dqm->dev, p);
> -	if (pdd)
> -		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> +	if (pdd) {
> +		if (dqm->dev->kfd->shared_resources.enable_mes)
> +			ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> +		else
> +			ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> +	}
> +
>   	kfd_unref_process(p);
>   
>   	return ret;
