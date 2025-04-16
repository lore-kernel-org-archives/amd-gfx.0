Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07908C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 11:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD9A10E69C;
	Wed, 16 Apr 2025 11:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hKD5qR0y";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E014A10E69C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 11:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdiOwHGzMib0RGRUkN0kkyrlWTCSQuXrWhszHJkEPxjGIPSBsfuqxIvgYMzoMxKz6h1AFUyR4apnt2VE207XZdfCWrzqFtfmy9W4Izrv/rmRfpEf//519/Fw+0LYfrvrIEXU1Gl5oB779GpYt3V+SwrsWUtHzebKG5/weFGVY07l6PHycQIMrTZ27/gn91upTfR5JRaxl77dYLntt1c7yMvJDu1nKawrELZhEltIuCepc2w77RpQOjl7tXLvEMPSgZq2DCnsUExo0DI2F58hyTxh+8S2erKgF30U3w5njfXItwkRxIG/LhwsZ9KHtA3OEq6PnqqgGhi8HJANutKOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ineWelAZunQkT3qrzvdjJ1e19XJftrR7OATYq7Lklzc=;
 b=VIFbQmrmL3p9/37VU1f3VKnMmHIYJccSvCPN9yUfReJrl1R6cR3AaRy4nIoUV7GfP05Pj7a3nw1wvJJ8T+x+ddJKsn6n4ZM76ppiqtLWI0gBV3DucmAXjYtuf4BI/dhjlUZAfNvaKhINHJW0CLQ6CKQlI0UxV+2xAIB/pah38xkQ8yHV+MiA7zXOWNta6BGPyJB/FFrcVJwlSLwd0NPBnBHbuXL1aB3RDSr5zR8nf5DeFgffwjQIaYxsbE9Einx766srEVB5Ff91mEnMGzlDCl9z9YMLdF1UgOu5nCwCSVmgL6k0YhXkRX5DMtSnVcARywM2WF7LdOWpKZcJrAeedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ineWelAZunQkT3qrzvdjJ1e19XJftrR7OATYq7Lklzc=;
 b=hKD5qR0yugUxLyivJxH5iJSfQI3cRsOm6WPyZEZjrGxIW88RPXiiKCJDz8VLegrLmSsDyzxoHZLp84KxGmDqPMrEqpxzUDOcML9jiOFtjYmXIPsSPsu8OK2gIELZtrUBWQa2DqluRHMOc2LvjNT4uog34g/clopAe6I80EHSJ78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 11:04:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 11:04:10 +0000
Message-ID: <b11d325b-77e1-4350-8caf-406fac4d13d8@amd.com>
Date: Wed, 16 Apr 2025 13:04:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: trace the scheduler dependent job fence
 name
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250416085029.2278563-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 395ffc82-bb94-4dbd-d14f-08dd7cd66a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1ZLZkV4MFJKSmcwZUFRTE1zYmRST0RsS09Dd3huVzhLVXVCbWU1STBDUXFP?=
 =?utf-8?B?RS81bGI2cThZZnNqV3RqQWt2dC9seU9EWUtOVjRRQnZkVXhraUxxelh6dk1q?=
 =?utf-8?B?M3Bib1J0c2krVVNiWnUvcVU5VkNlU1BNcDNvQ3BZUHF6bk9ZcDFxUmxPdFJH?=
 =?utf-8?B?VW9pYmVkRFhmL2FqZkMvYnlxNGViTXNWTEphT2FMYjcvTE90WnlkQkJuSVdo?=
 =?utf-8?B?UFBNSTBQYWh6OGcvTXBmbm1pOGRwSHdqZXZmcUJDR3VmYytQc3RNYlIzWWJH?=
 =?utf-8?B?bzVGVzdwdm1UdzhybHFqaEhFdG44MzZhZEY3ODNPNzh6SkZ4THlKWXYrYWtu?=
 =?utf-8?B?RXhJemZydnM3cjNFVE1mbGR0aFVCdjZNYnJkelN0ZEZSYWlsOWQxQUM3M1lx?=
 =?utf-8?B?akU0Zllnb2dWbWdNNFM5SStvTGdXMk55S25QZmkvaHdYRFJ6bExyVUFlcFRa?=
 =?utf-8?B?YWZPcHIrckd4b2xtckhZeGxUOFRCSGlNOFAxWk1abHgzbURHcUVISUUwdVFR?=
 =?utf-8?B?NkFTRW5BTUNBTVEySENXaXBrSDZFYlp5TUhYZUVoSFBvejBLZEphbTA0WDN3?=
 =?utf-8?B?VXp6dDZpZ28xbTlUMlE5SHl6OC9RYmo3QjJXbFEzcVRtcTluTitsWlZtbVBr?=
 =?utf-8?B?cHRBUXNLWGRrMnEybzRXL3V6Skk3dUp0M0c4QTlPcVcwU1M2SysxcjhVVVZv?=
 =?utf-8?B?ZjlsdXZuK2tkWGx5T0JzZTFBdzN2NExIR1h5bVEvdU5JOG5Dd0lDdDZuc0My?=
 =?utf-8?B?SERtdlYvS3VnOTg2dkV1ZDFkdzlpNGZTSkIrdDVwTjI2cndFSTc0NnFqOU9v?=
 =?utf-8?B?NkdoVUJ0NENrT0swbjVYT1FMVkJxYWNOd0liN3lQc2U4bUkzaXV4ejMvLzl6?=
 =?utf-8?B?TmZXRW5sYTJNMVNGQ3d2cHByQXlNOU5uSmdCempJM0hLS1Q5MlVvdW82VFpB?=
 =?utf-8?B?OXZoNmhGT1Y1VkpET2VyZjBoY25jTnFVd0hnc0FPZDZvOUtDMGN2ODJPVVhE?=
 =?utf-8?B?aHhjcDd2QmlwcVJjN0s3MTI3SElkelllVlVHVVhmUk9ZZWwyRXJrU1YySXM0?=
 =?utf-8?B?bVB6MEJFWFZxVDRMTzRRcTI2dXNyL0NrWWhLYUlQSlNVRkdmSU9yYlI2aVgx?=
 =?utf-8?B?Y0FRTXhGYnd6eGJnSzlZMjlVdlVYOUlxeEZYVG9kVnlPQTFmK1RtdVNYYWhW?=
 =?utf-8?B?eEhoNFpEMGtrVVoxS1l2UnV0SHdxeUtNeFBmYTFJdnZVeVpnRVJneVVGMWdi?=
 =?utf-8?B?NkdMTnRjdTBkNDZUZGNGTCtRcUNaMkJUSjhNMVZmd0RIb2RSNzJGMWpub2oy?=
 =?utf-8?B?TU5QNVNhYXhIT21lak5VKzBJU0NYdmxIZ015THl5OTVRMVNaa2I4a1FLYlRo?=
 =?utf-8?B?UjJFV0hsT2pmTDEzZHhyMjE3ZUJGUWpmUmhQemVsY05YMGNJQTgrcjR1bFUw?=
 =?utf-8?B?V2NYQURUL2ZyQ25Xdlo2ZnlYNmQxNTlBVm9VU2gwV01saE9HMlZFeTVSKzlW?=
 =?utf-8?B?RDZScWhRT3A3UVhpcm1OKy9wbk5jRHVKakNqQWwyRzhKakFOdW9hNFhQV25O?=
 =?utf-8?B?TkNNeCs2MFVMbkVhVXpKenZjaUlqQU9TYWFQbUdmZGwzNndMaG9pVTZlY0F0?=
 =?utf-8?B?Tm8zSlk5K3kxWXFrMnRrVGdTVlozZFVkck1jSlcxTUpPUElFSWNRNU5lSE4w?=
 =?utf-8?B?eW9OMENMVko5ZzZVbWZnZUpiYWdLck1LTGdvRnVFUFBmQlpSNHBVZit0YkJY?=
 =?utf-8?B?REZFVjBDaWVRbG1EN0hVdWYyV2Vld3gvdy9FempPUjVFeGZyc2FVYld4b0xN?=
 =?utf-8?B?a0JpaEJVczFLa052YzBZaVdUZm5sSDBxMmk3VTJWTnVNZ3BKSlMyR1Vjc3RR?=
 =?utf-8?B?bkZJcnoyYTVKWi9zOWcrYnFHZWxSRmpuY2dKRVVPeUtjTG1YVXJJdU9UWDhM?=
 =?utf-8?Q?cZ8rwYHiurk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUpRVFFpd0NGaEJ3LzFLN2MzbGk2bERURG9FYkN4bk44anJUVHVUR3BuVjdr?=
 =?utf-8?B?NEtWbTdHdWpTYVdtZUlFN0lCQkJEYVZocmxkcDNsOG1VSUVMYjdRdnlLUVRx?=
 =?utf-8?B?Z3V0RVd0OTJGZWU0ZzI0T0FuOUxKN0NhdS9TSG1iTUtOTnE5eHRyZmdzbG9t?=
 =?utf-8?B?SXZOcTFNVVhHTE9vMTY1SHErYTdEclRlaWVWdUIvQ3M2UWtnMGxPMHRLMzZR?=
 =?utf-8?B?c2xJMUs5dmNsMGtmZ294bU1uTlUwTkRqdXdRa0kxTHBKYk4zM2g5a1ZZY0wx?=
 =?utf-8?B?ZDM2OW9Oa0hlKzF6TWYvSEFXNVJnQnJQbmpDK2R0VVluTHFUSXgrSTlUTlRr?=
 =?utf-8?B?eW1PZzV6K0YyV2hYUURpSVEwVHdaVGtaVmdTSC90UUhFK1VEd0ZnNDJpUEJV?=
 =?utf-8?B?UnZJKzlMckJ4QlFPTUVnZ0Q3ZWRmaE1mVU5YQzYzQkI2TDAvR2hZdTdwZnZr?=
 =?utf-8?B?eXdLNEV2NTJ4djZ0RVlpbTFuV1hvM0w3MG82Nm5Oc1M3ZjJqczZybWk2RVhM?=
 =?utf-8?B?UktTVG94NktlbkgySWtqSG1tZ0s4cjVLa25GdWxsaW1wWHlmTGQxUFZMb1N6?=
 =?utf-8?B?a3ltZ2c1VHJqZDYxaVZQLy8zOGJQQ3RQOG5hcEVEQXpEa2lubmpUVDMrRFpn?=
 =?utf-8?B?VURVOFdXdnBGem5LKzh6R3pqMnBqNjVoSi9Xb3ZwSmsxMlBMWGhNMjIySGpY?=
 =?utf-8?B?dW9xQ2FzbzUzeHh6TXNFR0pEbXNEUjdSWnloblV5R01rRGpxZXFyRVg2M3pP?=
 =?utf-8?B?LzZOaGhOK0dGUDhlMWRYNWF4d1N6dEk4UWVkcVV5QkszYWFhTS9zZ1BXVEZK?=
 =?utf-8?B?Qzl5QTM0d0JxVzByTWVVNTY1S0FzK0crbG5ZeStOcWl2TVRVRjdFZ1REcG11?=
 =?utf-8?B?Z0ZMRFI4MUg3aUtXNzFHTUJ3b252aDRmVlFvV1Z2RXR2ZjdQeC9QeWV4MXNM?=
 =?utf-8?B?THM4UGFiRDhUdm5OVmVnWUVKWVpONGJtQjVqMnpaZU11QURqRlZxY0VVcWdY?=
 =?utf-8?B?OGV4eGpEcUpmQ0s1RnR3cEk1WlBSN3ZtUXFkcHhsOC9JbGxTNEFFMVNTb0Nq?=
 =?utf-8?B?cG1tUjNSaXpRMmFjT1NjNXR1alNDTEdCa1RIdlp1dnB1SzJFemIwSnl5cGsz?=
 =?utf-8?B?VmZhZmJOSUNFSnNRaXBDWkt0dXlHcTVGV2FkVmYrR2hFTmFwL2dEWWNVVmxm?=
 =?utf-8?B?S2lqajR4QXFkdmJpMUZ0aTUzVVFyODBVZGJsUFNYUG1LVzhyTUlnQjRNV21w?=
 =?utf-8?B?TXUyRlAwWktiQURoc25TL1FQZGwzbWx1MWh4V0ZnYzR1SjNNWis1RUxNNkF5?=
 =?utf-8?B?dlRyWTJpMTNVaE1XNWpEalN0NjRPUk84RitSWWdOVFVwUmJ6c3Y2MGVGOTdm?=
 =?utf-8?B?NTJBWkpEOHlLUDFXaTd6dkxCSjU1RStqZzhoUTdYRGNzaDEyUjdVTyt4R0F6?=
 =?utf-8?B?cWhoblFBVDFLb1AzRS9JOUNDNmpFYWZTdTljaWk3OWZUTFNHM0pISEt2MzYv?=
 =?utf-8?B?L1dwd09rMVA0ZmlzTkl5Wm5DdGJBNVVUWWcxbmZ4WmRQNTdzVDdHUHJXOTQ5?=
 =?utf-8?B?QVdZQVNLOHlYZStaNTRaU0t3QWdnd200LzZSUmE1elBnTE0wKzVnNkhQcEx2?=
 =?utf-8?B?bVlrang3OFZHaVVRQndoTW1JbHhwVzUwekx4b3RkWUxKNnNBbW00TnpQOStD?=
 =?utf-8?B?R21tb0R5ZVZVYU0rcjVLU3JOdm8yZUNjL0U5Um1jdndXY2dkVDZUU2RkK2JJ?=
 =?utf-8?B?S3NsaEoxQzU5TWdoMGV1QWF1empLenREajNIVjVRQUMweDBqRGxaQ1hRYmpx?=
 =?utf-8?B?WVQ2U3QxWG03SStlajNYaUpTMXFXK0xPY2hNNTlWMmsyRjkzanlUM1BRbkUv?=
 =?utf-8?B?dFZ1QXIycU5MWGs2OUR6RmhiUUl0MDZrVmJMMEZTaXlJQmhHdWR6Tk9kdUhP?=
 =?utf-8?B?cHRVSHROUWtqS2pJVkhyYzUzTGFPVmdvdWFvb1RUdTRKSXN3WDBEODdXQXph?=
 =?utf-8?B?eUNwSUlxOWF3Y1ZVN0pSaTZGMFAzSWptOFFSTTAvTFJHTUJzNHRoR3loRFBQ?=
 =?utf-8?B?K0xKWjBCNnk3K1ZPU0I3T3pYSjRWdi9uWWN5V1dPT1dSbDVSVTE1Q1pJK2VF?=
 =?utf-8?Q?ZKiOOAukmyFrW1pv2oUKSssqJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395ffc82-bb94-4dbd-d14f-08dd7cd66a2d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:04:10.5560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4V+ZELBJaQsyzSUdLqKr7g8YYrW7wrcAmX4KbyWFR/3Cdddhqw417dSPDSzPQBf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348
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

Am 16.04.25 um 10:50 schrieb Prike Liang:
> This trace will help in tracking the scheduler dependent
> job fence.

Changes for general DRM code need to got o the appropriate mailing list.

Apart from that IIRC we intentionally didn't do that. Why should the driver name be relevant here?

Regards,
Christian.

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> index c75302ca3427..473a2cbbd7bd 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -91,6 +91,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
>  			     __field(struct dma_fence *, fence)
>  			     __field(uint64_t, ctx)
>  			     __field(unsigned, seqno)
> +			     __string(dep_fence_name, fence->ops->get_driver_name(fence))
>  			     ),
>  
>  	    TP_fast_assign(
> @@ -99,9 +100,11 @@ TRACE_EVENT(drm_sched_job_wait_dep,
>  			   __entry->fence = fence;
>  			   __entry->ctx = fence->context;
>  			   __entry->seqno = fence->seqno;
> +			   __assign_str(dep_fence_name);
>  			   ),
> -	    TP_printk("job ring=%s, id=%llu, depends fence=%p, context=%llu, seq=%u",
> +	    TP_printk("job ring=%s, id=%llu, depends fence(name: %s) addr =%p, context=%llu, seq=%u",
>  		      __get_str(name), __entry->id,
> +		      __get_str(dep_fence_name),
>  		      __entry->fence, __entry->ctx,
>  		      __entry->seqno)
>  );

