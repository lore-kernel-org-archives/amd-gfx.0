Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E218C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0349610E689;
	Wed, 25 Jun 2025 07:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5S9o3NRH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A5210E689
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 07:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm1Wi0KrwaSuErODSKbTjbrhXOwGMteY2dvCUHbMjYTAHZwrpqtVeFpPg1NTwLEn3eYsSHf9Z/ivJ0Ix4uMop07Q6GRycQCPGxhTltCzwrxagVk0AzaddNBPPNnTk0J4gkVqXqSS61ajrzp80qruwK9xHDea9r0YferQGcjAprEb/LKYQfjO5gkiS2o6nLsPP5Sb/QTJQuGgvIUdazoaeiUYrp6lHPCmADBPQ4FHbX9/gVM95Ww7Mnr0jXFaPtm7Wqz/iQu2ERodzOTfxWZXvzYdO/Q3FF8R0ihCtvRJ5YfIj4VQr1rJ+krpGT9FH+qYU7X0d+qJPd51Oa/RWifRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m44TCqsCcAv7oydigQEAINOLTW2a36evfvexTDZHk4=;
 b=kwLL0cQOQVhbbRuLfPwpSGe0kZKfmrMdlr5XPMxrTu7gkB1aMvHDUbjvJyMrJ+wfghBnpIITYLH+8PgyO0EN+Cwp0kNxQRgJhdLLsUqrAaEYsYKzkqnOynM+MAxYS4yB40ChgZZPzDverAQpg8VUWqyq+pO37pkFwffBv8DMV3nb3pE00KG/yPXHkQLy2w9l9qDC/uc8/hWDlHJRUVMrA+knOy6Ckl6lHSj5gxMFNH1XKlbQRh5nv2nWIL6AUve/O+I57j1qKzYtS0cLB0MH8byWbszFzqh4BlVxaxEb6Mg5ka0YGQuigMSCTnfMuCKa0uUBMMYVVHZWyg1qEvGDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m44TCqsCcAv7oydigQEAINOLTW2a36evfvexTDZHk4=;
 b=5S9o3NRHxolzmUBm+0TNi1iYHScvrRhdDhG7+VLMZrNPmdRwOzFHG1RqRBMEzAStD/eCp022IDNJYHNRNjXS6G9Fcdh6rc+cSkHn6tZ0DHy3znvlRWerty7Zh1PJFhP/OuPz/5tpB07utAmjf6rVbm7ZlzwKJEVIhhLonNmz+ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 07:58:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 07:58:55 +0000
Message-ID: <b88388c7-c984-400e-83be-1daf3a819172@amd.com>
Date: Wed, 25 Jun 2025 09:58:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] drm/amdgpu: validate unmap status for destroying
 userq
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250624084535.1178476-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 49861417-4305-4ed5-2406-08ddb3be21d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nlk1TEU1T2ljRnVoNUloNlVaWWJXWndGTFJ0c0Z6NStEOWZOb3BBaUhUd0JP?=
 =?utf-8?B?VWZ1MU9zMG95N0lOWk04N0VHOWJaMjdSZWtIME5vdzY2ZDhNbEpoQllXM2JY?=
 =?utf-8?B?b2RWenhreng3MzhpajZ6VnM2ZWJqR3hxWDR1N2pmVENOTkJrc1ZIWVpBTTlX?=
 =?utf-8?B?UjVWTlc1WU1aWU5DTUd0V1VHdTJyaThoNVpRK2lDaDVBV0srYzVVY0c4NGZt?=
 =?utf-8?B?bWtrM2NPRkQvMWJWWDIvOXkyUkNCMGdGNzB3MVM4QlJmWmxXMTZMZ2MyeUVJ?=
 =?utf-8?B?UFRvY1V5aTlvRk8rVkRHTFNsL2hpNitLOVlid3V1Rkt4WjhSS2ZRZW05Rm8y?=
 =?utf-8?B?VGdVU0JDeUQ3RHFQUG9UeXBqZmt6dnpySVNMbXE0Nm5RekxTT251ek5EN0VS?=
 =?utf-8?B?QXdHcU13ckt5RUdXbG56Rml0T0dTZmJqQWY5R0dLUDdjam5xR0VWQi9uZjRT?=
 =?utf-8?B?bjNyQWtRZlBrWFdtUDIzbmUzc000RlJocWI3bmRzRVprUFFmVEttazFocXIz?=
 =?utf-8?B?UnRBVTRmbksxdWlJb1BOQ2tCN0hDbmRST0pqUnIwbUl0S0RjdDZIcTlDYmVx?=
 =?utf-8?B?U2pPU0t0M0lWNzlZd1hNcnJLcG55MEdEdHZSemdrRXNsNEgxeXk2RHMzd1RO?=
 =?utf-8?B?MFYzZFp4bjBubUp3dVM2dlJlalhMYlRsTk4zRXExaWJLUjNDOS9jeTJnam83?=
 =?utf-8?B?eDhuMmNVcXdZRVcxS1VUczlRQjEreVZZUHp3TmtjRW1ML1EwK0t4aWlobE5E?=
 =?utf-8?B?WHgxQm14WlhUK3hpcEM4aWFUTW9aNjFHV2VTdnFhTjhzK1pMdyt3WWFEdStx?=
 =?utf-8?B?amRneXJUQ0V6NGpmS2IwaVlka0RtSjZqSFJGS24xM0pxUTFGOENtV0FuOXc1?=
 =?utf-8?B?Mkh4cEd0K2haY1ZNR2g1K2FyZHlJRHo4OHRITFhhMWxHRHJQeGR6SWRYL2Ft?=
 =?utf-8?B?ZWNFU0tuVS93MDQwbzlNY0hMTFE2enFuVk9PZy9iWStjTW82TWpCTFZ3Rm1o?=
 =?utf-8?B?TWNJWmxIYVRqR3JsOE5vbnVaUDdZbGxHaG1QTDdSK01WUzBBYldFakFSWXNI?=
 =?utf-8?B?eHZyeU1WRmtvL1hNdDlSc1ViaUZITVE0a2pXdzBNZmlhbU9tU1A4QnpWNExQ?=
 =?utf-8?B?SnhYMTVveStDZUFFT3JRSFlhTi9MRDBzcWNCQVhndVlTcUxZaVZVWWlHNE5P?=
 =?utf-8?B?OU9peFhCb3NyUHlvb1owYVpvL05yNFpEVlcvZEZGMWdJYTFVeUtVY2lIT1Nj?=
 =?utf-8?B?UU1aV25zeDFYTUFKUXpkNE5kZGNpY21WQ1RTV2ZQUnFRbnRsakNxdWNQSXNT?=
 =?utf-8?B?c2x2ZHk0eVdlSVVDeTVDYnI3K3lmTnJGOHRvdGV2dU0xUUhVZ2dMaU5JSFd6?=
 =?utf-8?B?OWdaTi9iV3NmMWd0V25ZV2tXM3hlano0aXkrMyt1LzI1cGcwRnZoeTdjYkp3?=
 =?utf-8?B?M3E3a3NBN3l4MVJVNExSOElWM202cmwzeERHNzZKa0hZNzIvZG9oajVYQlFq?=
 =?utf-8?B?Vkc4SkppTkZrMU1iQjh3bTIvZ01wNjZvU280WDhJK2hVMHBTQjE3dys5cGYw?=
 =?utf-8?B?M295MU5CUlErRmR1TVVhMVgvNVJBQzRRM0pFZGE0akNyYVFmMUJQNEU2OW1O?=
 =?utf-8?B?MUY1dUxwM3JPK2NoK0dzTytyTmxXVDBYZDk1ZFMybE54VkMyZ0JmZ205VUh2?=
 =?utf-8?B?R01TRU1Ub0RHSHVNQUxhZE40SlJRL0NyRmJCUUsvNGphTDBJNmM0QVpLb3pG?=
 =?utf-8?B?b1ozWFBGaHhhMDA4K1l5VS9GMFpmNG4wL25IRzRBVmlMcWlzWnZtcnJTeU1V?=
 =?utf-8?B?WVgrUzZFcy9tRE5IVmNzcGZ4WkZHTmJKMzlKeGxFQjA2bStVTUxZa0F5NFZ3?=
 =?utf-8?B?bG16QWd4bm5HdERTYjVtL3Zoa3lIZHFFK2V4NWJVNG12WHl2aEM5K2FXaGZC?=
 =?utf-8?Q?N3o45q/C2f4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1A0U0R5dDk1cHFqZW9wZEoxY2xOTmRndUFMdG1lNzlMbStMSEYzVkIrR2NS?=
 =?utf-8?B?NDdxWmRad3ZWLzk0SHZBa2VTVmpza1VTcmZpMHpMVDRwOGpSUnZ1eDVDQTRk?=
 =?utf-8?B?TFBuclluS0NGbEZPWlZuVU41MmovT2dGRnhuOU9LVWJWRklXVDBRaUhwcWlk?=
 =?utf-8?B?d2NyYU1zc0pZSW80NEtEdjNyQmtLSTBVVnRubmZyTmRPK2xqeHpoMFNYM0ti?=
 =?utf-8?B?TFZ4SVRnUWF2MWRGeS91WUR6Tmp1U1RrOWtiaEhIN3kzdGdrSWtpRTNIZjRC?=
 =?utf-8?B?Z0dERzZQR2RZd3pwR01IeFRoaG1KeGpoc1lyaWpQd0hZanE2VXdvWWRqMzU1?=
 =?utf-8?B?RXVJYmN3NVBtNVZOK2ZacEw1U0FNQndvWVIvMXZpOHJpQkl6d2hvcmNrRlhB?=
 =?utf-8?B?VTBsZXFPSlBsYytDMTRuV1JVeXpXckhqZDFpTnl1Sm5PakR0TGJBYUFIVW80?=
 =?utf-8?B?UmR5Qm1jYmhyQXVtby80aVMwL1JkL0VaS21EU2MvYUNqN2FLNnMzTzU5MDNS?=
 =?utf-8?B?RGJ6WnhZNHhUOHptMndwa3p2VXZ1RVhSTHFxb2lsY3l4ZVRTTFMrUjdrTU8v?=
 =?utf-8?B?RHRLYjUyM1dCMms0b1lGY2lxQm1Pc25PUG8zQ3FoZ2tkZU5lRERYdzNVa2Fz?=
 =?utf-8?B?VHFFdFM2L3lCVHB2UTBKOG14Wm5FaTZmTFp6czY3UlkycGpZckxqZkVvdWpa?=
 =?utf-8?B?em1reUxnem5SRTBJbzF0aTA4VmF4SXdkRGFCNUNBUzlVeWZMWVM0RWJYV01j?=
 =?utf-8?B?ZElVOUllYWFPSnUyUmNFTFN5Rzl1Y3kwdnBuZVJ6NlZFQTFoRG5nTzRWTTlJ?=
 =?utf-8?B?QWNZY1I2eUFaZmdMUjRTY2xucUgrU3U4TmQ5dWRjY0tJNHVSaThzcFN2QlQ0?=
 =?utf-8?B?RFp2RWppNDNKRFFzU3ZOajhlSVduN1h6VWh4QzRTSUZVUk90R2lUV2dvVmts?=
 =?utf-8?B?RkZtRjZyRVhFc0hTS05lRG4zMW1QYzVlejh5bEdxMHVmZHpYOFVLYzBHbERE?=
 =?utf-8?B?aGxYeEZKODBZeWZ3SzdUai9NV3ZHeWVnM1NreDlWMUIwWDcvWWJuSlRsVGtB?=
 =?utf-8?B?S2NZNHVGWURKamJHaGVVMlhSSldRVjFpSlM0T3l3QjhvVGVpSyt1c0thbyth?=
 =?utf-8?B?S3pkZzVTKzhoVWlSaDM3a0lHdzNnOWFjZjFwemVNUEdocWFrU2V5byswQ0V6?=
 =?utf-8?B?WVppQVFkL0NEdGdKbzJxa2NQWGFJajNXbTQ4ZHJ1cW42OEs3ZjBLSVJyQ2Vu?=
 =?utf-8?B?ajNsb2pHYmNJenNCdkxjV2J5Y1R6THk3cWZ1VFd5RENkZjFpVXArTnh2YVlz?=
 =?utf-8?B?OEtlUWVoYkN2REE5SlJLb1NHZmRaRGF6OHpTeGMzUGFNMFJqTUJHZ1VQVlJT?=
 =?utf-8?B?a1ppNll4RmMrcjIxblplSmJ1V3B6dlo5ZVI5YTJuSXNtTVBzTFpPOEhZL2VI?=
 =?utf-8?B?WXpoaFFvcC93WXlBRHBYSnNkaWErU0dEVWtlN3l0RlJBY0JVdGNFSU9EaXA5?=
 =?utf-8?B?TDdvWmVPUmdhaGlTb0VZems0YVQ0WXRaaXdDNHBFZGV6VUFCVEk3Zis2NkEx?=
 =?utf-8?B?eHhhQjFOdk1iaHpyVFJkR1RhdTNRZmxIQzAxVDFnVW9HbkZsVWExR2Fwazh4?=
 =?utf-8?B?aVQzT2hneUZhbVJDQUlRNGhwL0twcnV2RnFyMVRYRHBhcGtHczZBSWpHU2g0?=
 =?utf-8?B?VkVHUHBBOUJMN0tTc3VNcTlOeDJQQzlvRXN2K2ZoT1UrRmxDUDZkanRhVnVX?=
 =?utf-8?B?WkRHQmY3bitnems3UW5teTRpNUdIdDFiQXNtNFJtQ0dxYm81Z2JWMVhZK2Jl?=
 =?utf-8?B?NTFtc3NZeDllVmdWSFRqUkhjVU13TUMzNmZvQVFkN1lUUGVSRHVoK1d0b2hM?=
 =?utf-8?B?cnZJWEhIdjBkclZaUW9hejFQUVRwMmJyeXVWNTgrbDZxRkd6S2ZWcVZGMm5p?=
 =?utf-8?B?bHdSQ2pPa05HYjVRcE14K1ZLN2ZVODZXd01hQlVEYmN5WVVJWFFEWm9qeXBj?=
 =?utf-8?B?aENGeUdvT1dKTTg2R2dtOEVOZzBsTDV3aVhEeTV0WXIwL25RMU9FY3lIUlVW?=
 =?utf-8?B?bzF4OXZrNDBoalJ0NUpsN2MvMDJhWmJsWVVGcENNdlJORnJTL1pjTnAzVEEy?=
 =?utf-8?Q?yjBBjkVIuvl9maoUhHzYGiTSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49861417-4305-4ed5-2406-08ddb3be21d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 07:58:55.1841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V41hVUoi+8RM4ZMkd7wDBfAHP2BPsv9AyADZF43R4Hu5dZS2uUsa7agEtFFxZaSN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

On 24.06.25 10:45, Prike Liang wrote:
> Before destroying the userq buffer object, it requires validating
> the userq unmap status and ensuring the userq is unmapped from
> hardware.

Hui, what is that supposed to be doing?

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 7f9dfeae4322..c7c9f9e597f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -319,6 +319,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  	}
>  	amdgpu_bo_unref(&queue->db_obj.obj);
>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
> +	/*TODO: It requires a reset for unmap error*/
> +	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
> +		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
> +		r = -ETIMEDOUT;
> +	}
>  	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  

