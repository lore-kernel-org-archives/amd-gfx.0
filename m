Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F805CA0ED3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 08:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA93110E6CE;
	Wed,  4 Sep 2024 08:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T0BWsAKq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2781410E6CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 08:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le0XGg99UL860DIlVtLCpdnWsTFvqyckFORrd388KKk6N1SGZXPq+lkUhmK0LrM44xf6c8v8jgS+HuNdA+fe4pggU+KZXKxDDAGEWrIUKN/9bafugzgRPSCvN+UxyTcwcXcZiEFTcCZHuCZ/5FdhSNkeojTC8HHMTgJXOG6YmNgNkaj0sabm6rKJkL7S59YANPmOz/v6Mcop+PYGmRAm1JNIqkHmc4KUT42wS76LgNILUeTqcHjDuVMR45cJEgDRFL0liozUMNl0bDRjvuEER1I/nfaaeeEcrBfZNwMo4VPzBO9Th9Ad+PmHcsR0AUR9NCaknstHhkv0GMdoiDIkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hSiSs9FYUdkIFqI0ajTAqw8V+eCdVANH1BEWPJkMrg=;
 b=Ry61Mf8tvUiwEWi8M8VI2wBtqrPGWIO+/7a9b0GNg6O2ZQPf6AGmFQtZ77FYDGvnjxsQon/Yy9A5Odj4zlgksYHKbdobsaKP89E8mHomFdnAigZEQLJcyGfu99JU/WKUmX4fStUN6V5IlQfdwKQUhye5aFxW0ruNM9tdNMtq5QbtDLTExjUalDbK87kYyw0h1POct7mNBZTGQz4XMMkvojpVi4np8/kJTGzIWPx/wJD+BDAEhH/4yE+Wiz74ZDeKVDzf+ZheMk0qaCQvUQsSGVNAdN31JvYrPdM7ANKqaq36ZXqeVEg8Q6mUWRPRV+B5Sg5jfR/Po1pF4XeoKldNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hSiSs9FYUdkIFqI0ajTAqw8V+eCdVANH1BEWPJkMrg=;
 b=T0BWsAKqi4TI/PfqJAArjDVjT+3TJbeO0l5zARYHmGyxr01F1nIwGmXf38PY9kZWUr8LtUu8lH6eAR9qxdPjwd48j6ARDfZaqdRFJNU0BwEFyRTWGeATJP189pdI+EmODNDRZuKURlCwFrCVQTR2BBz4NXAAg4Y10aNsn4syJ7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 08:43:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:43:48 +0000
Message-ID: <3c674516-fd7f-40a0-9e18-b047112e68eb@amd.com>
Date: Wed, 4 Sep 2024 10:43:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Replace 'amdgpu_job_submit_direct' with
 'drm_sched_entity' in cleaner shader
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240904083847.1768731-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240904083847.1768731-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df42a65-88e5-4239-b9f4-08dcccbdb192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE10b1JMd2J1Mithemxid1hna2d6T2huelhUWEpaalAxeUhwU1FlUmVvVW9F?=
 =?utf-8?B?b3lWbE1WcXFOUkNnT1IzdFdqNlFZSEh5S2ZTbHJOZ2hFTFpkcnlPNU9nSndY?=
 =?utf-8?B?ZTZwNUlGVHk0YUdYOWdNOHY1UTRQQk5jdytvcEZZbzJRMy95VlM3Nlk1K08r?=
 =?utf-8?B?cGM1TktwL1lYODhhZFpZNlQ4Y1JhT0gyVng2R3FpdHZnM2pCUzJBOHlxc0F1?=
 =?utf-8?B?dVg5S1BaTWtmNkRaTnZ1c3BUMlEweml3QjRnSVdiVmZuVWZGTHBvUWx4TWR2?=
 =?utf-8?B?ZGxJdTk2NmtES2g3Tk50QXBOdWFuRGUxdHpaN2JaNW93MzMxZEFjQnpienoy?=
 =?utf-8?B?TGdLZ2ZaSGZlWmNpZWtxOTJxUDhNL0loeXJ0YTZ3clRTbnZjeFRhR3VGN2tO?=
 =?utf-8?B?dnNoRnB3S1NSenY4WnRaeUNrb0p1NStnY1o1bGh6OEpuN3pnb3lKc0RLQmR1?=
 =?utf-8?B?ZjlwU1pISXY3REI1NUo5UVQzWjFVREx2Y1hsUDhMUnJDQmE2V29DK1EycXc4?=
 =?utf-8?B?L3gxMnJoRjZwNzVkek1NL3pmcXVYVTYvQkhid2RhTUpJT2Z5VWEvVlFJWVI1?=
 =?utf-8?B?Nm0rU25SZTRoa3VUTVNTTHozUnQxWis1Y1R5T1hXY2tRenFUa2RGSk84SndX?=
 =?utf-8?B?cnBoNE9HbXFrKzlOOWhNNEJud0RWbnpNdnZpanFnZEJiQ01iTzdjeDdZZjVu?=
 =?utf-8?B?RXpTd0dSV0U1OUpYRDZFaGVuWnRCZUxsYkI1VmZQRFBhUkR1TWIrZHh3Wi9R?=
 =?utf-8?B?ZEhGRUVYT29hVFdpQkszUGl0eVN5cmxZbGE2T2htdWk3ZEl2cS9MS0ZkTjJZ?=
 =?utf-8?B?RC84MForcHd4ZUFhdWpoSmFDZ1puWWtTMlFReW9kYjNLZUxCVmhlZ3JJOUhx?=
 =?utf-8?B?dVdrdjJ5ZHducCsrOGxMelcrb1VGVGNpd0xNSEJ4V0s3Wmpxbm5tbGRwOEZl?=
 =?utf-8?B?VGROVUtoRGlEaHdkT0k0aDNVVmJYU3Z4K0Y3MmVGY3YxVEwxMStpN0Vua3d5?=
 =?utf-8?B?TjZXMW1LMk1rRURjNEI0MHBIUUh2Q3pLY01mN1FpbGtCa3VBbkNNaXloVHk2?=
 =?utf-8?B?S29vS2plOSt5SWlxRUlXNDV2dTVrYkdCVFZiWnFtWG9sM0FaQTNZNnFIamZx?=
 =?utf-8?B?bzQvMm1sd3UxZjQ0bUxGQzY5RlpOT2diblRVTitFL3RGL3JxdlZzSUIzTnJP?=
 =?utf-8?B?aCsxOXYzL3BHaFh5YjVWNU5EVFhtN1BBL2I1eW95T0NjUk8wWnJJalBjMHRJ?=
 =?utf-8?B?aG1ET29EMTI5ejB5SlJnM3N1dXIwQS9xRWNGVkM0bEJxeHJZbXUwUnROTkp4?=
 =?utf-8?B?M2VlcWdLN1BsNnNaY3ZISGNHd2xKL2Y2M1BOWjlvK2VqWm0rU250YkFZUkV1?=
 =?utf-8?B?YnhxalNwZW44cW9qRzNGcDhkcXBjcFlwVENPUlgwb2F5R0gveEV2K3h2QWN1?=
 =?utf-8?B?VEZWb2tRVG1BSWEyVXhzcUU3WE1wUnFCU0tDeXgvUDNRMU9RUnNUdzVWcG1r?=
 =?utf-8?B?bFZ1Mm4vNmE0VmZsaXdyZkxCS1RQVXRjSUNFL0l4anE2bGVUc0FPNU94TEhO?=
 =?utf-8?B?Z1RnQ1dIaC9jYXVxTmFBUitFRHJzVmowQXhMNUxwZmpZakZ5bDJpdW5XRllo?=
 =?utf-8?B?bE8rSENBZndBY1BLSWwveEdmMldRWmRKYy9ySlhUYnl2VEpnWThWUENCNXd0?=
 =?utf-8?B?dnBNelBJWHh5YXhBR1VWcFJSYUlMRnJJWWdXelhYS2JIa0VSaWU0NUZnM1dr?=
 =?utf-8?B?VGh6VENQWG5VaGlPVUk5dG55ZmRrSW5MbXMvUWV2WFhtN0ZSK2V2QTh6VFpH?=
 =?utf-8?B?OVJ6OVNXZHZPcHVPL3ZTUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZyZERia3IyeVQwZldsYzBUUk5idEkrcU1Qb0ZPak9zbjcveEl5NjZWS21M?=
 =?utf-8?B?NTNLSzg4QUhYTHM3N0wrR2dFc2dKdlJmTVJPc3Frb2E3anZndUJVenE2STJm?=
 =?utf-8?B?cFBWcWNrZlBITWc4bUt1dFpFNWxYc2tqVUlLTWF1OUorcXIyeUhCQWxOSVZ4?=
 =?utf-8?B?MXFqc1hzNklvRDhEWmcya0JyMjFHMDRKdnFKWFBCS21DR0YvSFVYTm92Sk5O?=
 =?utf-8?B?aWRXVTlKbmdrZ1Z5YzNwKzlqQjJ2TnlLWEF3MGZSL1RWQlM5bVVYZ0JVS0ZR?=
 =?utf-8?B?aUJwVmR5TjNsZEY5QUc4UUp1SkNRWjg1bDJmdkZldHc3aURMWGROSWhjd0dH?=
 =?utf-8?B?aGdKRHlOa2M3ck14eGYzbklZN1F1LzJJdHFoK2FGUHdXNU9EZ1FCR1k4WVJq?=
 =?utf-8?B?SzFqVzBHSVR1bkxjNXlhUGhaWWlMdmI4ekVzR0NhdjNmc2xvTVQzOE5QaFgx?=
 =?utf-8?B?OUVjUzNISVNJTGMyRUp5eGk0OFIwcStvcWR2TzNEeUhpeGVNTWsxR0V1V3g1?=
 =?utf-8?B?NTNZcjRLOEVTSmdvaXJOS1VkY1RtS2x3dGNGY1RFRGcvc3pwdmFkK3BlQTgz?=
 =?utf-8?B?NW0zemtrdmoyWGtCL01xSXgxYzZ0czJRRnkxUlEzSkxycDBGNHRhQ29RcGo3?=
 =?utf-8?B?VGd1ek9RNnNCMlluby90SjhwZ0RtdzZ1TlFscVJxN3ByR2dub3BEcHBlR2Y2?=
 =?utf-8?B?UFdPaHFuOHRjM2JTcDd6MUpsMXpGaHdvdTVyUTM1VjduT0VucE9IU3c0dlJv?=
 =?utf-8?B?K1dhZTUrUGxlU0dmR25Vd01yelh0dng4Q0JrQ2VhK0EvUFdYbkJIMGFKaXhV?=
 =?utf-8?B?TE55b3o2cXFoR25Ob1NnOUE2bFVweDZPbGtGNlVPeGNYY1NzRjY1dklPZnI1?=
 =?utf-8?B?SUJtSUJGRVRjYzd3QndEcmowVWhUQXJGY0dYWkxLS1Q5eDhPNXowZHNrMnd5?=
 =?utf-8?B?aHJUQjBEb21zTE40M0FKaU93d0dBc25yYjVtS2tzSG9BNXc4S21TSytzZk9W?=
 =?utf-8?B?aFUwTzNUZmRkcE1mRTVnZ0t1SFZtOThkaUM4RFlpTUVISVVyU2Q5UmM4aGl2?=
 =?utf-8?B?dG5iblRydDhzdUFhdjduRjVVN1BYalRDV0l2OTA3aTdtODhiQWN1c01xaUlw?=
 =?utf-8?B?QkZCYjh3OFp1YVIzYjF6aVNjTi8vbnVuTjVXSHFBMW9icVN4UldxdTNPV000?=
 =?utf-8?B?bjB4dTdnbnIxL0hMV1lKRWRtNkZ2QjhERm4xckNDVlo0ZzNsMytUekE2Z3Qy?=
 =?utf-8?B?REpIZWZNQnJmWm1UbGRXaHlTMTF4OUdhNk5rNHNLa3d4Zm9KUUpnWWJjNVV5?=
 =?utf-8?B?TnNQc3QyM2JRQXI0ODNNLzhDMFVOY1hqR3dxeEgxaDFvdnMrZURkd0ZIWUR4?=
 =?utf-8?B?MFNaeFNjNUE4NWNGNDhCRndqM0Q0LzJIeDA0ajFlejh0di9SL3hsMGQ1M2JN?=
 =?utf-8?B?d290UzZ3QlRSeXhNVTFPTnp2a3R3UUsxNWlFWXFJL0JMZWJ4NlhEQ2ROM3B1?=
 =?utf-8?B?a3pDS3QzS3lBbXljSnJoQkR2R1djZTVCd2grWEtWNG9Vam5pSW91Y3Y1Qy81?=
 =?utf-8?B?QmtETTFZeVZNZXRYTjdEblVsS0NDME8xVnJrd2lURTNLR0lFS1JxT29QSThp?=
 =?utf-8?B?L25tU0tlWU5yYXBpU3hxMytuUjVwYkhvUlk4WFdBa1owV0liY3hYOFNEQ1po?=
 =?utf-8?B?QWdyT0x2S2xLMmlTZWZLUzN2ZUpTSnQ1RHp5S29jeFdlRWY5ZkIwTnM2ZENE?=
 =?utf-8?B?YmVnS1h1RjFUT3ZWaElTRTZIRnloQXlxZ1hMNHJOQUhidkRMSDVkT3ZCdXNh?=
 =?utf-8?B?RGduckpXWWliV3JIbnAxc2U1bXZzMndrNlNVUWltSEN5V1lORFB3YVArL011?=
 =?utf-8?B?WDZjbWRBNlRVdGlRbkN3NHd1TGtWajRkNVhieG1USnBrWUJONXBQTlNVVGw3?=
 =?utf-8?B?N1dPNWtadWMwOHFZbWNpdHBqOTQ1ZFI4VkpPN2dPNFIrVWVXMytZTFNsYVdm?=
 =?utf-8?B?Q2xhZXRKYVRGYlJvVkJ2SXpQVFI2bFp6Z3RNejNtSGJmejh3N1BCV0EzNDRJ?=
 =?utf-8?B?S3NMRmQ2dTV4Q0JzU1ZINU1LMlBNWUp1Kzk2KzFNSC8waHJidGVQQk1XTTJV?=
 =?utf-8?Q?adId8aVZclnerUnH3P+tEEp/F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df42a65-88e5-4239-b9f4-08dcccbdb192
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:43:48.1243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gse0mj66LyDKLFBF+CjSTSW7xBBhKmVS2t1W8dLfE9dq8L90xnHUVW5I2UiITmUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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

Am 04.09.24 um 10:38 schrieb Srinivasan Shanmugam:
> This commit replaces the use of amdgpu_job_submit_direct which submits
> the job to the ring directly, with drm_sched_entity in the cleaner
> shader job submission process. The change allows the GPU scheduler to
> manage the cleaner shader job.
>
> - The job is then submitted to the GPU using the
>    drm_sched_entity_push_job function, which allows the GPU scheduler to
>    manage the job.
>
> This change improves the reliability of the cleaner shader job
> submission process by leveraging the capabilities of the GPU scheduler.
>
> Fixes: f70111466165 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> v2:
>    - Dropped default assignment of f. (Christian)
>    - Moved drm_sched entity; to stack from amdgpu_gfx structure.
>      (Christian)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 35 ++++++++++++++-----------
>   1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b779d47a546a..83e54697f0ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1397,14 +1397,23 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
>   static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	long timeout = msecs_to_jiffies(1000);
> -	struct dma_fence *f = NULL;
> +	struct drm_gpu_scheduler *sched = &ring->sched;
> +	struct drm_sched_entity entity;
> +	struct dma_fence *f;
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	int i, r;
>   
> -	r = amdgpu_job_alloc_with_ib(adev, NULL, NULL,
> -				     64, AMDGPU_IB_POOL_DIRECT,
> +	/* Initialize the scheduler entity */
> +	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
> +				  &sched, 1, NULL);
> +	if (r) {
> +		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
> +		goto err;
> +	}
> +
> +	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
> +				     64, 0,
>   				     &job);
>   	if (r)
>   		goto err;
> @@ -1416,24 +1425,18 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   		ib->ptr[i] = ring->funcs->nop;
>   	ib->length_dw = ring->funcs->align_mask + 1;
>   
> -	r = amdgpu_job_submit_direct(job, ring, &f);
> -	if (r)
> -		goto err_free;
> +	f = amdgpu_job_submit(job);
>   
> -	r = dma_fence_wait_timeout(f, false, timeout);
> -	if (r == 0)
> -		r = -ETIMEDOUT;
> -	else if (r > 0)
> -		r = 0;
> +	r = dma_fence_wait(f, false);
> +	if (r)
> +		goto err;
>   
> -	amdgpu_ib_free(adev, ib, f);
>   	dma_fence_put(f);
>   
> +	/* Clean up the scheduler entity */
> +	drm_sched_entity_destroy(&entity);
>   	return 0;
>   
> -err_free:
> -	amdgpu_job_free(job);
> -	amdgpu_ib_free(adev, ib, f);
>   err:
>   	return r;
>   }

