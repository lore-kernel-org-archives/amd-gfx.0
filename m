Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79956C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 21:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFE710E498;
	Thu,  7 Aug 2025 21:06:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cr2WKvDO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46B9A10E498
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 21:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FypC05ZjrDvSxWskI3KHRpzR+zB8aBjLlsorcG+V5LD0c8EzZSq7+31w2sfF/B0wS9JDtQBAIVKn5GrX09ew7D0TvbXNmk1SRwWoMCPa1h1Nv/XF3VKrL4Sj+ANDaTEaVL0J029EBAR5qkBsRRf9W3YzDO7aPfaF+sZtRRpafWqwK13yOX+PjReOMTKY8tlEJ7LkVX5aqRJCSWh+OUUqosGWKLVAL/s4WjxiKYtJUmwA/CMvpamV4KqP0NFTCzkU7TVIaoBx+5qdGyjCGSU9V2TodKdtNsPX0yrjhwKQruqqQen00nrpX3V5Hw8gwpCpwaXCnmSPOeTrrLulZy8wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tZkYtQQEnskszsgvyz2UhOuA1qKwrqtwjfOOpj4m+8=;
 b=eU9Rko27rITjEdOtyjH1Rlhd0WyEb+ng9+G3FIPK6ViSBMxJLaqI+XFHb2KK0Q6QT3snXOOt4UBXa+wD5+7BcQNUNPzA5odHxAGesUaY/zImch0nFVMY2Rrr4iH7SknErWRGPva0clIHRvmGr/QxqDGdy3NJryicgF4RcsDcfzXrR0URFi+iQBWsBBxs0YdjCI64ZAADI87eYjmYjnyqbo67OyiGct9xumH2O++6at/6ea3dHkREJMmtyOVcEAI0z64gy3TTYPhNf1pjBPYwCNJ45P5JcsEmQEZ63i+XCwG6Q3+aCmqLPWQxyBEaBx3Y3mMRuKFS4go/auMLVY1zdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tZkYtQQEnskszsgvyz2UhOuA1qKwrqtwjfOOpj4m+8=;
 b=Cr2WKvDOLdRF7y3QlvaupHxLCBaIw6VDz+GiHTHxRSFxp+ia4kDpLqnJ+aWVGvluwUvmr6GnSCZ7swQw+2uf/IuVtLm1NW+ThXLHzjNvG5b6DjWMIs0+CRQaLJpB2pOB264CfoXa8oIp9/78NZakrzSSQRnoygjF30VlRbLC5vQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 21:06:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Thu, 7 Aug 2025
 21:06:27 +0000
Message-ID: <ed10ef32-77a0-499f-a274-2e0ca48eb434@amd.com>
Date: Thu, 7 Aug 2025 17:06:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 12/13] amdkfd: remove test_kq
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
 <20250804110550.261311-13-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250804110550.261311-13-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0493.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: a5473407-5b8b-40bb-eaac-08ddd5f645ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVYrNlVCVTkyT0s5VjEyN3pkbmF2Q3FoSEp2WmZqM1F2MjRUSUdXNEhQWGdE?=
 =?utf-8?B?Q1oxZU1abHl4TTgvREdzT2ovSElyaVZ6bGRDLzlXb3NDWXlSeU5oajhHNUV1?=
 =?utf-8?B?YlNKelFvUVV4UkE0UDJJQjUybm5WbUpnNWpYU1NSL2ZyRWk4bmN5bk5oTjFo?=
 =?utf-8?B?a3o2RTlENlBwRmFQWk5iU1hQK0x3Y2poUFJBeTBUZGF1c2EzdlppV1NUckNa?=
 =?utf-8?B?WDRER1hQZTk1WUowZi9YYnA2ZUVxbGxuWjI5UGJXdURLaGhxMnQzWFc2Tmh4?=
 =?utf-8?B?R2MwSm5pQlNQbUhRdWJtV0ZnaEFsci9SR1lXL0kvbDlhRXRmak1Eb2c3U2xx?=
 =?utf-8?B?NDRlZTJ2OWRFcWUxZnJtMlN4Y3lTSjcwUWdDbjUrVWZuaW10djByWXFoVExU?=
 =?utf-8?B?WEVwejZaV1M3V090cWsvVWQvdmY2ZzZIV1ZSNXk4NTZKR3YxNXN4OGcvVnZI?=
 =?utf-8?B?alI1SkY3SGg2ZGs5TWlray9NUU1yS0VmWGxIV1VESnZ0RllmNzhicWhIdVg0?=
 =?utf-8?B?eVNiSUFadGtYNDhsVndxWXlXZnAyY2NGRzJLT2NZL2lLRlRqYXg2SFUrSlcx?=
 =?utf-8?B?ditXaGhKVTNRNWhvZkhJZUhpbGNnVkk1R2padk9naXJCdFp1M3NzWG5IN3JD?=
 =?utf-8?B?c1lvS3JtRXh6ZDF1YWtCUUtXZHhBdjJYaFFMN0hOcTVQRkRLVWYxelFIQlRB?=
 =?utf-8?B?Z1Vaay8rb0NaTUpsS3o1a1pjN2s2NGJIOGIrbnUrUElnVWxqZVJZS0dWZDBK?=
 =?utf-8?B?MnlKR0xicUJVUVIzaEdQWjh1eVAyTVdJNFUwMUdGMktiQU1VeUJ0Vi9FQmNZ?=
 =?utf-8?B?TnNQbThyQURDaVpDeVk5SXBkU0RZMU5oaFdQUGd6Q3VaNVdzRk4vWXJoc3Jw?=
 =?utf-8?B?dkFEUHRLeW15OFNYLy91dVVzL2I3ZFozWHJPN0tld1l3MDFCVEowWGpPRTJi?=
 =?utf-8?B?M2ZCVk8vRHNjSWdQYzlpd2xDVyszVWM2RkhrbFpkRnlodnBTRUxqYmQwUDND?=
 =?utf-8?B?VVB1MVllVEwzRWZEQWRSMlRtU1lFU0tsUm44WmxCYk5YNGtLVnp6Q0FGL3I1?=
 =?utf-8?B?Nnh5ajBIaFZKWlpKMG5KUE02STFqSWEwdThBR2JOY1FpUXo0L05kZWQ0U3Vr?=
 =?utf-8?B?RXB1UkZWUEtlUldhL29CSVRRQjZwTlN5WDQrL1BLSjBBRUxDT2VuRU9UZTBG?=
 =?utf-8?B?M0dMUGMxeXRMNU1iYWZib1JKZGlhOEU3ZU51aGlacC96U3hTSXpsR085OEYx?=
 =?utf-8?B?QmQvL3dJMDRITmFuN29DZUlkNlgxbkIrckVkc21rZk90LzJhWEYvRGRaSjdV?=
 =?utf-8?B?NlJibXRZVFBKQTBnNzg0R1RCYVB6ZzlBYzVNdkh6MnlIZy91VFBwS1VKZ3FK?=
 =?utf-8?B?cnM3NWcvZG0xSnFqbzQ1UTRuQjl5QzU2azNmbDVYOVB4UzVUMFVTK1ZtVTVz?=
 =?utf-8?B?VnR5aUVGLzdIZ3h1dTdEb3ZLbjZLVG9vTEJFTms4MTJnZnpPS0pkNWcxenYz?=
 =?utf-8?B?NVJDaGZ2bDlhVjJ3ZnE2TFdZZ3ZwRWtnd2dET3p1TlhTVGtRUStOb05RTjY3?=
 =?utf-8?B?NHpzOGdLVWdJdlc5VExYTWYrclNDbjBTZFFLVGFaVWhoUE8rMzRXY1lTL2Yr?=
 =?utf-8?B?d0QxR1N2K0tOTnoyY0srN0NpRUQvUDZ2YmJsRlNIcXRJbGExWGJ2eVVQMG9l?=
 =?utf-8?B?UlF6NEFEZm9RZUdlRlhYZ3VIRzBpZkhhbkdNUGFJczZjcFh1bDJXeHF2cVph?=
 =?utf-8?B?c1NTM3d1VXM1VEJYNGpGUnpFa244QmVPRmo1MmIyQXhYUktKRm5VSFBON0RW?=
 =?utf-8?B?YUJZN1lJVzVhM01UeHVWcjB1NDkva3hRVnZXWUUvWkQ4dWlmLzZFbnRDVnVz?=
 =?utf-8?B?NDliUDg0MEdwNGNxSldUOCt1bU01TmpyMHhCWjFEbUVtMlNxbW5hV0xlRGFl?=
 =?utf-8?Q?uxZZlghkrUA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnA5VkhLZDJoRWhTZGJSMTUvSmJOckQzdlYwa1hZS1ppMXlWZ2JmVzA5Q2Jq?=
 =?utf-8?B?K1pMdmVLSTRoWlk4RUJ2MmV4ZzNndzA4b0xMTHJrV3dOVnNhUFYvZ0RvVzdt?=
 =?utf-8?B?YkhJQWhCMzNVbU9HcE1qMXNDWHRsZXV5SWhuRUprcWQ1VFVYNmdobXF0SlJD?=
 =?utf-8?B?ZldTR2NhNW5oZFYwQ0U4RG0yVDZlZnJjV2MxS0hXc0Zob2l4NERRSHlKcTE2?=
 =?utf-8?B?eVFIWXBxTHMrK0pGVTc1Ti9KZ3pNUFB5UHdYU3J4eDRvdFVpcTJsZFkxdEpn?=
 =?utf-8?B?Sm82UDE0L01OMTFIWDBSSlEvTEV5TENXRUhEcE5uSG9vYzd0QUJFMXFtd3k1?=
 =?utf-8?B?YitQTHJSY1U3ZnRxQjU3RW5JVnlZenJXMDJ6a2piNTZpWGhiQ2NuODhFNjd0?=
 =?utf-8?B?Y3lLK1IwaGVNNlFWMWd1Y3ZuT1d6bDkvRXFxSVZJZjRqSmd3RU1hb2RZcnhv?=
 =?utf-8?B?THBZUUkwWHhZRDAvcWJrL044bUZTeEs2SEZTVUUxVVdFY3ZoS1FQSzVDc3BY?=
 =?utf-8?B?Q2x4cWpsbktyYXpSL3dHYjRSNFZIM0hxUnhGTlpVbkxkQ0I0T1E5M1htQkxT?=
 =?utf-8?B?eU9JOUtTbG1hdEdEeHVJa1p1L3ZhTXdBV0Z0U1dubnM0QzcwOUNwT0RhNWI1?=
 =?utf-8?B?ZE9aMXA4MGt0MURUVnZLQU00OHZjN2ZpeGROYk4yQlAxSklQY3VteGxKd3ZS?=
 =?utf-8?B?ZlM2WWJiankvVTNrYkQyTUxjQmQrSUF4WlRubHY5aGlzdmNnNUp5czNqczJD?=
 =?utf-8?B?QnJkZ1dWZ2NOVW5PUUFJR0owQWJMMTcxa1dldGJDTzFEZ0VlWTdTTmo5aUll?=
 =?utf-8?B?YWR6bWRxd2x2WDVyb0NZS2NmWm5WeEtpcTFXRVJNQmRzdXRNeUpkZGgxaHpZ?=
 =?utf-8?B?MHRoUFNQN0c1VGFnT24wK0VPejdjbERQb0xuRlZqN2k2aWp6ZkJZNHFYN0Vm?=
 =?utf-8?B?SVJ2OEN0R1NZMW1BbllEbE4xQVhVRXRCY21sdjFDMGZZdktsajF3aDhHRUMx?=
 =?utf-8?B?bTNPZzZHTXVLRWI1NlIzdDk0N0pTQ1Y0T1R0KzZNaXhUOUFmbllhUGg5cXF0?=
 =?utf-8?B?Wi95d1FZNXJjUHpHV2NnTytYa3BieEQ4OEY3MmFrNDRUSGJiby9sazZNYXkw?=
 =?utf-8?B?eTZNbXNSZjBRZlZVczd5WGtiU0FpUUczSW1PT3dCd1BjNFlOei95Z1RidGFB?=
 =?utf-8?B?ajYrbGM4N0EyeUdIR3h6Ym85endlZC96ZmNud1VtbHUvUmI0T1BNUUdaTzl3?=
 =?utf-8?B?aTBQb290SUkrNWxNaTlwK1QrU0x6dUlwU1ZHbEhIaUxrTmxSNkt0bnQvYzBN?=
 =?utf-8?B?SUh0RGNmajR6cncyMnZZS2VIRC9VTFozeFlKeVoxaUhoUXorVjd3QUdFQ1c2?=
 =?utf-8?B?NlJ0azcxQmhJUS9NUUVaOXJSVzRlRUh3a1ZIMkVZS0xXS2M4cFpWc0ErTll2?=
 =?utf-8?B?L1ZzRXZreWZYZGY5NThXV0tkVUFMVm5hZnhBSndtQVRqOXRSc0RPY1BSK29l?=
 =?utf-8?B?Smd0ZWRNTkQwMGJxMWU1N1VGRlZmODQrZXZtb0hLMWZOb1Fpd1JkcWZMdm4x?=
 =?utf-8?B?VTU2T2RYNHlVaEUvVG5tWlVJcEVSMEVVWVRaREJWdVRLWFMxRDZXN3VqMWVr?=
 =?utf-8?B?MGx1VytYamFJaXNTcit6eTNhdTZ0MzZHMGM3KzQ4VmJ5OUZuZ0lINjVKU1RW?=
 =?utf-8?B?Nk9qdHA0Yk9ucDQ2dmdWbzhVeWkzWk54eFphLzUrZStvcXdQbDd1M1BYaHR1?=
 =?utf-8?B?QVp4WUtoWDRobGhJR0dFQm5YMTc5NGFaUTNtSDFWRzJoMy9LWEprOTc5VzZP?=
 =?utf-8?B?VlhCWkJaV1hHSTFlcmRrOEsxM0N2aGdRL05KZmppUnlTZlF5dUFER2xJUnBQ?=
 =?utf-8?B?eWc5V3l5Vy9MNnZBVnFNVFh1eGRWVzVwVmRXUk8wRkRwb3B2Z2tGbGxRcU5Y?=
 =?utf-8?B?dXo2VjFrRXhJL3JVbzlHZnROc2g3WWwxQmkvbXFRcDd6dFlOWlNqUHJGWEFo?=
 =?utf-8?B?RFRUaXdlMEg0RWdXNUdMSWE4RHpoSmtxRDBjZVFRWVRjRVlnTDgyeVZ1bGVD?=
 =?utf-8?B?aWpVUndjbGNuMmRIbkFvWUg1ZHpZQ2FOVC82Z0VIdE1jZEFJK3l0Rjh6Tnh5?=
 =?utf-8?Q?8x0d/cTnxddYvwPS+RXouT1zC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5473407-5b8b-40bb-eaac-08ddd5f645ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 21:06:26.9536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+YaQ44avpkxExWxVFBOd1AIRLBzmu2xuKYXvIVixQGjdHD81Wx5daVvR515Q+3loPJM8LtCtVaZtQacjfr9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357
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

On 2025-08-04 7:05, Zhu Lingshan wrote:
> This commit removes test_kq() function becuse it has been
> marked as unused since 2014 and no other functions calls it.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 31 -------------------
>  1 file changed, 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index f676b7419984..6aa8b0348bad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -339,34 +339,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
>  	kq_uninitialize(kq);
>  	kfree(kq);
>  }
> -
> -/* FIXME: Can this test be removed? */
> -static __attribute__((unused)) void test_kq(struct kfd_node *dev)
> -{
> -	struct kernel_queue *kq;
> -	uint32_t *buffer, i;
> -	int retval;
> -
> -	dev_err(dev->adev->dev, "Starting kernel queue test\n");
> -
> -	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
> -	if (unlikely(!kq)) {
> -		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
> -		dev_err(dev->adev->dev, "Kernel queue test failed\n");
> -		return;
> -	}
> -
> -	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
> -	if (unlikely(retval != 0)) {
> -		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
> -		dev_err(dev->adev->dev, "Kernel queue test failed\n");
> -		return;
> -	}
> -	for (i = 0; i < 5; i++)
> -		buffer[i] = kq->nop_packet;
> -	kq_submit_packet(kq);
> -
> -	dev_err(dev->adev->dev, "Ending kernel queue test\n");
> -}
> -
> -
