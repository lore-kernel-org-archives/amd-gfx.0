Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA88D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 09:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF1810E6AC;
	Wed, 10 Dec 2025 09:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YuCRiHtt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A716010E6AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 09:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB73/RXBlRZ6KmBhnXQRl7JWtzgBI/ZAi7PYmwPUJbB63fF31+TREehfA9eHRqnQQKFaRz6Iyg2EIZHtbbZVVrLv1ujYJG8GyERL0P+Y9/IAzLN8Y3D4GncJmQpauJ46awFkJK2AOwzMWIWbulKuEiAFqrjimUzCzD1zJumDyxHOgDMf0VLSEabE/6SfwpkFxuF7qXS3I7KZ9wRlV0r5XpEGXPTwFiar76WtWV8rCxXGc7WkW7ucXLY33a4ehDtPi4DIyxMO18tG+0o2IEP2fY635jcEMwA+rhM+nrnAloib3iSWHhLWy+SNJC2e133rn0IdrL06YXRdJ9K8o32siQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4PA8BV7qKO43HV56fDumQE3062V38rwLW4xT9p0+nA=;
 b=inRAHJjKsdgADsV/vuLSOdmHXTdsvbr4cvx1VBlhb47sop6Gxpheaxh7foFisjnWT/5G025/VaubLVOkMREhhA3muyzy2DmXyf7Oe4xnE9IziS57yYjTkwPeQijMk1WMYn7xqW8fgK/kJzkzax/rAiqtUR32uS25ZPFrVW8QrfvhVSNy/3IgvfcUJMDV+OpNCJ1oxE9Xt38AaZzr8rJkqK9IU77XEkrtSu15ZIi4jJ7Ew7deg+bdQLWbLbb78Hzj8h/aHrZCtCfui54v3yxem/ZGmXUe7BzPLR8alZA9T51ZeMCqE7ttBwntZc2yoLRGAi6oEp4eJp3eAlkx4jz7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4PA8BV7qKO43HV56fDumQE3062V38rwLW4xT9p0+nA=;
 b=YuCRiHtth3L/iOJ8BHJ7iwKaZg8vkinoDdJ0NuMzsYwIGGydQEpHIwFlNH6cZDr1pzvAH+cnD3kdgDaq3P3XS+AoVD2VgoqjLeDQOi6R3sTkrnudKvHQhJhbzef3jOBrUAaUKQOu+bakybmWT4HOgvo/a7K7eXq7FmBrdBL3m+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 09:08:02 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 09:08:02 +0000
Message-ID: <8a8e0a29-f744-4b32-a9db-18a97d16ef74@amd.com>
Date: Wed, 10 Dec 2025 14:37:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: fix mes packet params issue when flush hdp.
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: emily.deng@amd.com
References: <20251210074026.1495081-1-chongli2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251210074026.1495081-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e88788-13ef-463c-423b-08de37cb9f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2Q0NTgrNHBSbytsSmlUWnZUNjZXSk1UdkZtTnZyaFk2dEdHNHkwSlR2aWNN?=
 =?utf-8?B?NTg0ZjNEREsvMUFGTy9XMXZja0hObGZqc3dzYm1jcW5ma1NmdTRVVGcvU3lT?=
 =?utf-8?B?RlVjWGpRYjUrRHVHWmU1MDEvZU1qTDlIZ1NPYUNkUlJpbkRqV0UvNTU2Sitt?=
 =?utf-8?B?a1pyTVBwdkpYZUE5L2RlNnFnM3BmaXhGQVpFVEpoa09NRjd2QnJHT2ltZUVN?=
 =?utf-8?B?SDg2a21aMzVVYmhzd0cvbWZvc0VTUXlBdTBEdmxkSEM1MHBNZVc4ZWhwWXZo?=
 =?utf-8?B?QURGbUIvZUhmMEJ5bmtrckZqZDd1SzlrclU3YzRxQU9qNW04UnByU1E4WGpY?=
 =?utf-8?B?bDhWVkJjSm9aSmFvL2psSXloQTZ5TTZ6WkZqSTlJWHlhOVNKQ2RsYjI2RDRt?=
 =?utf-8?B?dHhLcGFXNWNGM0lpQzkxT1pSSnZQckhHeG5vRzFlbkxwRzRhV2xsM2Z4cVdG?=
 =?utf-8?B?MmtUT2YxODd1NE1HUEhBR1FmaXE3aDFTeWp1dEFEejdxMm5rWXQ5VG5IRjNZ?=
 =?utf-8?B?dXlud2J3MjErTzc3U2FmOEY4WDBYQ0xFK0tYaEFGUDQ2UEd1OXk5S2Q3QUNP?=
 =?utf-8?B?Y3loVWVLVnRGcVVUWUF4V09YUnpYTlo3dUNRUzJFbk9VVEEwaUVWM2V4MXFZ?=
 =?utf-8?B?ZEZDMlYzZWZXbEdVclc4NXhNRFJJT3F2eUJRd25GdVF4Tjl5NkRyNElIc3NG?=
 =?utf-8?B?byt3N1pWa2pVYThCOXFLNDhka2JOWm1wMDUzSC90TWNmUjJnTUpCZCtjRTY1?=
 =?utf-8?B?Sk95TTJiNWFjUkJYZHI0Qkp5RDlaL1dxdjdkVDBYZDVaYVk4U25qTGFnMG0y?=
 =?utf-8?B?SzZURGI5Sks1WjhGQTFJYmhMK1ViN2JkMkVQZ1JCdFlZVjBOdlZLNWRpUExR?=
 =?utf-8?B?L2JlMTBPNDlHQm1HbVYxRVk1RHJ6cVVQemVPR0dqWWZGSDMxZ3FTU3liVzFB?=
 =?utf-8?B?WDFudW8rRHBRdE8rRjBBVGlINGN2R1Nsa0txbEsybVBEQWVUbUlrTFU5UFB2?=
 =?utf-8?B?YjJmUFpJb0lKN3NYUUxvUEJ4NTQxczdObTlXdllNS2NEU2Zmcnd2RjY1Z2ZT?=
 =?utf-8?B?eHJGN3FSeXk2MHU2OFNyK3NESENXUndsb1ZkRUFZRUFCUVZPRHExZnZOQk1o?=
 =?utf-8?B?c0NaT0tSWnBNQ3F3Nmg3dXEyaWVCczdSSTRaQlVmVlVsOW5JTHd1Mzd3UnEw?=
 =?utf-8?B?M3F1QVhya3BTbXZTeWJHSCs3L0JBcGVBaGQ2alQyK1dBdGI2OWJQQ25kYS9k?=
 =?utf-8?B?dkU3U1hxb2F5WUVLV2hSbmwyWDk2akR3bWJMZGdoNkJHV0RDSTF5cGxjL2lx?=
 =?utf-8?B?WmJxWE14N1htc2pUQ1YwOFIxUmpjZy9Qc3BXczhYWDUrOUVPQitEdS8xSEMw?=
 =?utf-8?B?Mm9xMkpqRnNJTzk4ZnpGTFlRRTlsYjNFY3ZwZEUzWWVtcTFjT0FTVUVYRVRj?=
 =?utf-8?B?V0FmeXFQZSszVVBNOFdLMkQzdFBHa1JmbU1mRkJNZi84S2RFWEU4SUtTN0ZF?=
 =?utf-8?B?MXUzVkptb1dpSWZjQm5IbWdvbitEbUlxQnFpSEl0dEpsdHcxSjNBMkxWcDVE?=
 =?utf-8?B?SVk5eitXWndHQkVpV3hkOWhuWnF5ekV0b3RqcXJZZHR3NGRoU3JCS2Z0dUJJ?=
 =?utf-8?B?Rm44SHdBUTRMRkdZd3hBbFVGRzU4K3ZhSWg5aENpMElpN2p3ZkR5dThkeE0w?=
 =?utf-8?B?Zi9OZWl2VGJDay9qT1RNazNlZHQzdkNKV05OdjYxaTFHajluU3lTbzFnMHEy?=
 =?utf-8?B?eTBKUkZ1QlZFQVVNSUVtZkZjMFZyMjZFY1FXSkhLc2R4bEdlbk1CY1pyemhw?=
 =?utf-8?B?dERUM2xCNXJaT0pRaWIxYzluM2N0NTQ3WFpNLzJuOGVFb1pzbzBVWnFJRThZ?=
 =?utf-8?B?RUdzUHNucm9DSzE4Q2E1K2kzNlkzY0l4QlBpUVZxN2VpYXFRcitjNVFIVGxx?=
 =?utf-8?Q?yRtDbu67q6Mj8UZkR+QYIXfS0Os5HG72?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5DdCswTXNsOERKQ2UxVDJ1dkJ3UlFZYktjWGY3d0JOY2JCWnVBS1RlZWto?=
 =?utf-8?B?UlZEUC9ZOHdwT2s4NS9LckFSZ2pHNFZvWk1RN3NGN2xGelMrRy9qUDB4SHZU?=
 =?utf-8?B?MUw5THk2UmtwUnZVamI0Qm10SGhiNjVlWnFmbWJpREdyL0dMT2tIRm9vaEFF?=
 =?utf-8?B?N1ByQjBaQzdjQlR2eHVlVFZpbkZuK1NGK0dPR1U0aXNIQ1BhZUJLSHF1UVdY?=
 =?utf-8?B?dmo4L2Z3L2ZqTmNLWEdvZGM2RmxyUDVEaFluNkI4eWROMjRhRVc4b2RISm9y?=
 =?utf-8?B?YUR1NkhnU0lUU1QxZXc1Y0hibzBOakRUem1obkdRMGxWNnJRY3k0VDhydFZL?=
 =?utf-8?B?Rmw4U1hKcmRVQjh4R0h2K21RSytQQkFxUEk3SjVwaHpvOWJYdE80aUJheE9R?=
 =?utf-8?B?SWk5R28xVkhVZkw2cDBaaURuSzVUT3Nab0s3bk1ObU1ZUkF1UzVZUmNrZmxU?=
 =?utf-8?B?bURleUVyZ1JUcnZDbzVQckdNNmJQUDNtRDNrMTNNaWRHT3JxSFk1NlptMlZ3?=
 =?utf-8?B?aXRJVVNhdE1pRzhKT0ZENVF6U1FzQmEvMmtpZG01T1UrU1hHazIyZHMvNG5l?=
 =?utf-8?B?K3EwT2NDTGZxZzdlemVISFUrTlBMQ1YycWVwV2hvdE9VN3lGcldiZnZob29K?=
 =?utf-8?B?RnBDZS9hZDFrSWZKSG1RUjUvZVMwTEFhVVdFbkpvZ3ZiNWxMZkdOQUUxL0hj?=
 =?utf-8?B?K2tvZ20vb252YndrWmx4Z2M4QmpxcVl0TmtPS3RoQmZhV0NpL1dYd3RHTGg0?=
 =?utf-8?B?ZWhEM09pbjE1NmxpKzRxR3I2cWNXbnY0VVRpNU12SDBnN2NSUGFDY0VFemdR?=
 =?utf-8?B?dTlqUUZXcm1xbmhVWXNPcW1BTXh2SEM0SXpOSGx1QjhuMXVNbUNQR0x0N21p?=
 =?utf-8?B?RTEwa1YralloUHNEL1BxWlVkTEFYdDIrMnZzbFpMRmkzME03Y1BBSU9XdGNh?=
 =?utf-8?B?QTFDaWxhRFVFRzlNSW5NWVRHM2FWQnAzaTBiaVhJS0tVY1I1Q2FTc09wN2Uz?=
 =?utf-8?B?Z3VJSDhpK1hFWDdhL2Z0RUsra0lZYjc1VldzVUNUNURWVEU4d25GamRMM1Nh?=
 =?utf-8?B?T1lmL3VvMXdPSi82cG9TVERYcGxJQ0xjZXVUMWMyUGE4cmZMZVZOc0hPNFR6?=
 =?utf-8?B?Ny9wVUI4YUFqM0s5ZloyVnI4bjlaazJMek1iaGd6a1MrQUM1bzByRkdFemxm?=
 =?utf-8?B?M0pjS1FyTDF6bElEYU5jNmFIUnowb3Qrc0JiOHdOTTNEcmtaNGxCQURVdVQv?=
 =?utf-8?B?VFFkQTE0VlRXcUJtNUJITVh4UHZLaHRVdEd4K2NUUWxOenhFYk9JYTJWV25O?=
 =?utf-8?B?VVI0anRzT3JxYTRtZisxbHVWcUtWT3BENEdQNGVnK0l4SlhSaEZ3dnB6dDkz?=
 =?utf-8?B?NDNSU0FXMDlCS2dRc1d3V1ZJY296Tjd5cmpFUTA5SEI4cVRaSmx5anNWeVpB?=
 =?utf-8?B?d0ZSUm9iUElGZTl4ODFsVjU5RVo2WFV3M0lTa2V6Si9RUExYcyttSm0vTktR?=
 =?utf-8?B?REkwZ3N2THI1RmV4TXZuNko5Q3NwRkFzZFFlSkYwL1AxMFNyM1lpYzF1bjVp?=
 =?utf-8?B?d1Z3eDZxd2NvQkFKR3NTcUtjVkVLVytqTEJNUVVMTENDK1FJdnFoMGp2VkFF?=
 =?utf-8?B?VFlQZU44RGwvaU9rbnlWMW5NY0dKUmR3N0NKRHdVUjFiVVNvek04SkRjSXRs?=
 =?utf-8?B?WEF4RS9oOTdGVGdOUU93NkZHZllCQkthd0E1WDIzWEhsV1lDWHdwS2hFRHpv?=
 =?utf-8?B?T2ZtLzJvUTBhcDJieWFzK3IzWDRsdmNERXdkOVU3NyswZFVHRHhTS0tpTlZ1?=
 =?utf-8?B?MEtmVGhGdXN1bml6di92Q2YyU0dvc1AvZWFCZGZXMVhLSW9rWGdFUE5BcWdH?=
 =?utf-8?B?eURnWmdZNS9ROXdBMm94bHNuckNGeXQxZ1A1bENHeHhmL3FQN3B0SHdaSlNo?=
 =?utf-8?B?c1FzNHNObGYyNWl1d3N0SlZUSVpPSGxhUnVZT1IwMVZYNUs4QnJ1VmdPWVV2?=
 =?utf-8?B?TjlXbVl6VVRBZ2hYaUVvdUIrM2pndS9YMWppTzhnOTU4UkZiMExIVUtlUnpD?=
 =?utf-8?B?NlVqMW9tZDJOTWwxT3RNbUM1RVBxT0xPTUp2QU1uL0dXVnJxUXdTd0tqOFZh?=
 =?utf-8?Q?JwdQNLR7PZ0OkQq8xA5bWz1TN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e88788-13ef-463c-423b-08de37cb9f48
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 09:08:02.4769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJpJ6zeusRFyXubzv4BqX1aB/cmN1iNYDysgxTnopiUjyiLnuNouIyUsnVdOi0ui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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



On 12/10/2025 1:10 PM, chong li wrote:
> v4:
> use amdgpu_gfx_get_ref_mask to get ref_and_mask for
> gfx9 through gfx12.
> 
> v3:
> Unify the get_ref_and_mask function in amdgpu_gfx_funcs,
> to support both GFX11 and earlier generations
> 
> v2:
> place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
> since this function only assigns the cp entry.
> 
> v1:
> both gfx ring and mes ring use cp0 to flush hdp, cause conflict.
> 
> use function get_ref_and_mask to assign the cp entry.
> reassign mes to use cp8 instead.
> 
> Signed-off-by: chong li <chongli2@amd.com>

One nit about the function name (comment below).

Apart from that -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 34 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 21 +++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 21 +++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 21 +++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 59 ++++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 59 ++++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 21 +++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 21 +++------
>   10 files changed, 160 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1ffbd416a8ad..cf0f5b3bbfa5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1197,6 +1197,40 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>   	dev_err(adev->dev, "failed to write reg:%x\n", reg);
>   }
>   
> +void amdgpu_gfx_get_ref_mask(struct amdgpu_ring *ring,
> +		uint32_t *ref_and_mask, uint32_t *reg_mem_engine)

I don't know about the origins of 'ref_and_mask' name. Would prefer 
something a bit more meaningful like get_gpu_flush_mask or similar (for 
this as well as the callback naming) which associates this with a flush 
request.

Thanks,
Lijo

> +{
> +
> +	if (!ring || !ref_and_mask || !reg_mem_engine) {
> +		DRM_INFO("%s:invalid params\n", __func__);
> +		return;
> +	}
> +
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = ring->adev->nbio.hdp_flush_reg;
> +
> +	switch (ring->funcs->type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> +		*reg_mem_engine = 1; /* pfp */
> +		break;
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +		*reg_mem_engine = 0;
> +		break;
> +	case AMDGPU_RING_TYPE_MES:
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8;
> +		*reg_mem_engine = 0;
> +		break;
> +	case AMDGPU_RING_TYPE_KIQ:
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp9;
> +		*reg_mem_engine = 0;
> +		break;
> +	default:
> +		DRM_ERROR("%s:unsupported ring type %d\n", __func__, ring->funcs->type);
> +		return;
> +	}
> +}
> +
>   int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev)
>   {
>   	signed long r, cnt = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index efd61a1ccc66..e7718485eae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
>   				     int num_xccs_per_xcp);
>   	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
>   	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
> +	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
> +				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
>   };
>   
>   struct sq_work {
> @@ -615,6 +617,8 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_iv_entry *entry);
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
>   void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
> +void amdgpu_gfx_get_ref_mask(struct amdgpu_ring *ring,
> +		uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
>   int amdgpu_kiq_hdp_flush(struct amdgpu_device *adev);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>   void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 895b841b9626..77d25317973e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>   
>   int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>   {
> -	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
> +	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
> +	struct amdgpu_ring *mes_ring;
> +	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>   
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "mes hdp flush is not supported.\n");
> +		return -EINVAL;
> +	}
> +
> +	mes_ring = &adev->mes.ring[0];
>   	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
>   	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
> -	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
> +
> +	adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
>   
>   	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
>   					     ref_and_mask, ref_and_mask, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index aaed24f7e716..57ed8bf6b78a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4575,6 +4575,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
>   	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
>   	.update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
> +	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
>   };
>   
>   static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -8614,25 +8615,13 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> -		reg_mem_engine = 1; /* pfp */
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
> +		return;
>   	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f4d4dd5dd07b..11c866d7a49b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1081,6 +1081,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
>   	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
> +	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
>   };
>   
>   static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -5833,25 +5834,13 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> -		reg_mem_engine = 1; /* pfp */
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
> +		return;
>   	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index f9cae6666697..fc8e28d7921c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -938,6 +938,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
>   	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
> +	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
>   };
>   
>   static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -4389,25 +4390,13 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
> +		return;
>   	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 66a4e4998106..29a6378cbf04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2068,23 +2068,15 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>   static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	u32 ref_and_mask;
> -	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
> +	int usepfp;
> +	struct amdgpu_device *adev = ring->adev;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -	} else {
> -		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
> +		return;
>   	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>   	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
>   				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
> @@ -4075,12 +4067,49 @@ static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
>   	cik_srbm_select(adev, me, pipe, q, vm);
>   }
>   
> +/**
> + * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	if (!ring || !ref_and_mask || !reg_mem_engine) {
> +		DRM_INFO("%s:invalid params\n", __func__);
> +		return;
> +	}
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> +		*reg_mem_engine = 1;
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v7_0_select_se_sh,
>   	.read_wave_data = &gfx_v7_0_read_wave_data,
>   	.read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
> -	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
> +	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
> +	.get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
>   };
>   
>   static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 5d6e8e0601cb..0fd17fdf2cb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5211,13 +5211,49 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
>   		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
>   }
>   
> +/**
> + * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	if (!ring || !ref_and_mask || !reg_mem_engine) {
> +		DRM_INFO("%s:invalid params\n", __func__);
> +		return;
> +	}
> +
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> +		*reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
> +	}
> +}
>   
>   static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v8_0_select_se_sh,
>   	.read_wave_data = &gfx_v8_0_read_wave_data,
>   	.read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
> -	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
> +	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
> +	.get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
>   };
>   
>   static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block)
> @@ -6000,25 +6036,14 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>   static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	u32 ref_and_mask, reg_mem_engine;
> +	struct amdgpu_device *adev = ring->adev;
>   
> -	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> -	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> -		reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
> +		return;
>   	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>   	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
>   				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e6187be27385..9e31a27a1a7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2004,6 +2004,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>           .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
>           .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
>           .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
> +	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
>   };
>   
>   const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = {
> @@ -5380,25 +5381,13 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
> +		return;
>   	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 89253df5ffc8..d428ab2a4313 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -848,6 +848,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>   	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
>   	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
>   	.get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
> +	.get_ref_and_mask = &amdgpu_gfx_get_ref_mask,
>   };
>   
>   static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
> @@ -2818,25 +2819,13 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
> +		return;
>   	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),

