Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6053C3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 08:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D63B10E7A6;
	Thu, 15 May 2025 08:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nbTuIsqy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3269910E7A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 08:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPhy4AASLOGhhTscH0TSRwIjCvSW9XSGstJ0StBImuSzojd9C17AToz8fDmL1dtdIGmJYOY/ZCBcHrnF2pL6kg/6Tu1VdQCTiZOrD8VXewLVmio8hCftzdJXHCjLQ5Vhr4TjzB7lGK0tI1pXQDmwnp6e04ffFLrTCh1jwFk/AWUKl8eyQKRpELY2+QopdfgzSK9aTwABTv5uqyy5R5ItUTtSOYMX/aWQ6VgLxgQXy6+gJDeqjGOD8ztRNGLgMxq+Ted4k+54HWEj+yv3g2twg+oEYOUc2gq3cs+0evxoMb8iltL7qoZz+h8YH7OyuUh6dRw1pAQusbJlL2Dv3EFNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sQY+daeggj/pGMRNkwsZvLYf7kA6meT0XKDY+oVvSw=;
 b=h3RwEDGTiDHCexzXUp9U+8+I4aPDE/y0FMP/e1m0+J/at3JFsfU0m0Ril58GQ/XwfpaDumApCJDJU6JBHYDf2deS1SQ3Audw4noDLWVWwXvNzrDtvOOEtHXEO95wLru3OlFp0tJx11U6XwDo6fRq5fbIiN8K+zS3XBD+So0XxmnLrHEWpScNLWqQNL0DYO3qQEjvJSGXGRzNxZgFY43cbTl7qtjNc2iKwR8kqfky/YjoEnmfymk1Qdo4mRtD9cqwORJbFdSS1i+oxYSqOoceasbHxhfq4C1Y0MexhZC71vBfT9L2++FlSi0GEd4Ab3m601V+llAm2aRsSQS87PbAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sQY+daeggj/pGMRNkwsZvLYf7kA6meT0XKDY+oVvSw=;
 b=nbTuIsqyJcvJm9dOoK9H7QOhym+PyXz2ivfEQNHcT+xPmL/Mh1HbHEZUm6619QBAIq7DL4uTWyhWRtqLh+uk/+j9ZygohFG3EQjEdnUqxIkHJsDa+QNIcc8W2UZY07beHMEW8TNMXwCNUVTmtv4cum/9A8elw5PhXNlfK62l1QQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 08:14:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 08:14:28 +0000
Message-ID: <f6ca6bb1-7482-4ac5-8df1-9ed1dcbc53ad@amd.com>
Date: Thu, 15 May 2025 10:14:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: lock the eviction fence for wq signals it
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250512022016.395502-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250512022016.395502-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0267.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 60be1a72-5a0b-4294-8686-08dd93888321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE4walR0Z2gzQWVWdnlNSGRyaVVhNUZ2SVVXR2NIMnpEL0hReHlNVG5FR202?=
 =?utf-8?B?TngzU3FkV21DZWVpdlR0bVVySngvK1RCdWFPVzBQRTlPbXdIaXFSejZKYWo5?=
 =?utf-8?B?YTRzRTUvUnNSN3ViYjVRcWIzUks3aFQvc1pGdHV1ZnFuWWJ4Y1JLVVp5UnVI?=
 =?utf-8?B?SW9GZEh5OVRKRTV6Wm1mM1E5bEdPbG1qZ2NOb1ErY3JMM2RVeWt2c2Ira3Ux?=
 =?utf-8?B?Z3p2dEdUVVVZaDJxL3FQd3pyMjNhUXNWL2RodE5OakxYc1lpWGFnL2YrY3RV?=
 =?utf-8?B?bFF0THdzZTJnd1ZaY2hqanYySHRhbkxUUUMzcExWM3AxS2t3NGNXYlR6RDJz?=
 =?utf-8?B?OENRWUgwT0VvOWVzSHNlT1JsU0RoUHJ4M2xHemVPRHRDeUttNnFNa0Zmd0FK?=
 =?utf-8?B?VUJUNTdqOEQ5RmRDcWowc0JCdEdiZGplc01NTWk3L1ZaL2syWUg5SXNZWXFn?=
 =?utf-8?B?SUNOZFQ0a0FqbGJyNUNJK2k3MFNIKzRtaGx0cTgyZWt1aksyMkRXZU1lbUdX?=
 =?utf-8?B?L3JYcUo1ZmxFZURzZTZWMkFjZ2xnenBKOFBwYStLTWZDQTNjd0xsdm5Sa2cx?=
 =?utf-8?B?WDREZGR2ejJFRjBpMUdrcDFYOWI5eXVVNGo1eGlNc3dHWmF6ZFBMbStuSjZX?=
 =?utf-8?B?MWkrSC9WbTVQak5yR2MrOU9mbUpmZ0t4dFpVMUNyNUhySm9uTnNCY0MrZTRv?=
 =?utf-8?B?cU11VGpoNXJ5V203dmxBOG94SFJZUWxqKzNSN2g1Y243L0ZDN1c0WFUwUWk0?=
 =?utf-8?B?cE1tdzhSVHZrb1BLejBScllXaDdlRXc1WVJTcUNpSTZnbGpibGNDMldzK0Vi?=
 =?utf-8?B?YXBqOXB6NytFYTJ3S3lQRkZpY3diUHJEUm8raWROeTZuUWsrT2t6TWE2RzhD?=
 =?utf-8?B?VUlJcnBVRktFbXpjd3JnYkpwZjV6QXc3OTRKZGdNbHEwWlVIc0tqaU9ydVc1?=
 =?utf-8?B?UmZxZ0c0TlRDTHR4M085RUovNnJYTk03a0QwalQvd3BLaHdVNEhTSmpJNGx1?=
 =?utf-8?B?dGxRYUhLcFd4NXM1YitLcVBhUE4wY085R2Y0NVJ4Q21kd1J3SlRIQ1RrYXYv?=
 =?utf-8?B?MXFWRDJsV3R1aVg1RjZqSm5lQXBXMkxtNmRKNCsyeDlFRFNyd2tNdHBBZGFY?=
 =?utf-8?B?OUFsalZ4aVQwSU5wYW9VL1NsbmdRQlVTZU5YNytDelBzNzNWcEFCNnlNbUhK?=
 =?utf-8?B?U280Y2lZRnlxYTN5U1VuK1QwTjhTVFVGdktyQnZycU5VTWlHT1BXcVRWNVVB?=
 =?utf-8?B?MUtWaVNtUkt5RFJ0YWszTDNobmcwQVNHVTdrME81YlNRL3hrMzE4a1lyb1VW?=
 =?utf-8?B?Q2NiNWZ4SnpqU1dERG1PTGw0WlhvckVJNFdlYS9tK2F5UUk1R1VLeUJ5b2Uz?=
 =?utf-8?B?ajdoRXJGbGJ6YUlNb2JxOXpZVnJ5Zmg2S2VYZVEwcW1nNmtlaGNZVDNwTmR2?=
 =?utf-8?B?SkJzb2JsWllSakhMa2tTWWUzVHJHZlRKSUY0OTVEbFpPSHJxQm9hUDVYejRj?=
 =?utf-8?B?MDBRaDYxdXZjKzNySmptWFdTRDFSWFBWV3A1NTlSbXpyOVN1M2Y3Q0srS1BO?=
 =?utf-8?B?NktHczhmMXBtQzB4N2txR3JKZ0M5QkZnVG9DWExuZTNDZ2ZMTFZBVjlmeGVK?=
 =?utf-8?B?NzRiMUlhMVRlcEg3NkNSZW92MHRFeWQyUEFub0JtM1orcy9JVUxlZkVhTWtw?=
 =?utf-8?B?eGhRdFVxOW5yaTEzVDJ6clllYnIvQnZNZisyZkFjU1p2WFBUTzkzSGlvRFcr?=
 =?utf-8?B?T1NyQ0RCVm9odSsrY2ZOc29waTF5b2ZJZWViUXE3azYvcHpkZ2RPWS94VGR3?=
 =?utf-8?B?VGoxRks1RVc4NjZSVTRRZ2U5QkpDdk9rLzdFcXVHVmtDWkpwbGJrWEc1dnFh?=
 =?utf-8?B?azZYQzVVNHlKRW5wMmlFM2M3TSsxRzZqRzNadTk0SEhqQ1NwUTR1N1p0bEhZ?=
 =?utf-8?Q?xu8+Bo3thwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEdYcGs5c2dRTmYrejJWZDd5aWY4VEZRc1o0R0JqTVY5MnBEQWprRDhqS21t?=
 =?utf-8?B?c2FrbGg1eGxlc1UrMlM5eUVHV3Rrd1NLUnlzNzF1Z0dRbWY0aVhKWjJuZ25N?=
 =?utf-8?B?bXlmS3k2YmQ1Tm43RHI5S2NrMVlDUkJJdXRmVjN5d1hUb2h4YUhhVW5MWkxR?=
 =?utf-8?B?VTFlUE51emVlVWFNRlJmWitTMDY3WGt0Rm8vcGtZaFhOUnVoaTMydHdabThU?=
 =?utf-8?B?QnM2VHF3ZDl2dDVid1VubCtLVFpaMU9VTG4rTEhKQjFCU29FU2pnZ2wrRTdV?=
 =?utf-8?B?enRJbUpIYWxKUm16Y2xEVmxUekJjTG1iT21kVkNHUVN2VmZ4WUI2dHB2cjN1?=
 =?utf-8?B?bE8vL0d6YUd4aEVUNnlKdUdiYTZ0V3VqU2VNSkJnZS9Jckc0SndYNXFRZXpG?=
 =?utf-8?B?eEZNWTBqTFU4cmJIaHBDOXNlckFBL1NXbjFXR2pwNy90MG5WMmtORzdqelBK?=
 =?utf-8?B?RGYxUnduU0JtSDk5YkhPSkFZVHhaenAzdDNDckhJeXlRWTlsNGhaWk9SUDZK?=
 =?utf-8?B?TzBqb0RTTWdFTDVKbm1QMmhISGIvei85RC82VjMzZVlCUDQwcUNhUUQrV0Y0?=
 =?utf-8?B?bTczREdtS0NzakRJQXdhdWVrV2FHaUh5UzMybEVxOVh2anVVb1dUbnNaVmRZ?=
 =?utf-8?B?UUVBa291Zjg4azdEaEFzWXVsdXhnSFJsSjY3WGRsZkVVSkRFTVQ2Skpvc0xI?=
 =?utf-8?B?S3g3T3ZCbXAzeVhENHVhTVhKNUhiTkQ5K3VrY3FSME5XOFB5ZXdkN2xoSUNk?=
 =?utf-8?B?SFNzb1ZKMHdrMi9ydHpYZVF2dk5KbDZ6V1V1Vm1rK2hrN0NSRFVNa1BmbGVE?=
 =?utf-8?B?RTV6ZzVpSzN0THRUM2g1eWdQMTlkUTUraFUyQkdoMHBhMktoSWU3ei9GRTJ3?=
 =?utf-8?B?TUFVSCtxTU1IVjlxSHRGMUt5STFTL1I0bytNMFE1RE1ZRVJScmxwUzBkVUNE?=
 =?utf-8?B?Qkx2bnhJRXN1cWZrNnI2Wnk5RzJxTldscmNVdkRBVk9RVEg3Q2xmTStNS0ls?=
 =?utf-8?B?T3lhbzlCYi93TnZFN3Evclc1RmJsWjJrWWY0QmkvYnRMaVdXSUxZbWVvTFUz?=
 =?utf-8?B?NXZtVWNWZXBxeXdPSkxTeTZHK1BwMFdrbVVZSjVOMUJyYkw2MUg3YUxRc3hB?=
 =?utf-8?B?bVB1WlJuTHQ5TTU3dkNaaUxHN2Q3TzhFMSs5MG5ab1lHQUpQVks1WjRMZ0d4?=
 =?utf-8?B?czZjM1FheHExeHZSNTkwekVKODlTOUJLMThxRGY5UDNJa2pFN0NHUnQ1Tk5E?=
 =?utf-8?B?V2NIV0taUXlEZGJZSXBYSDlqdVFRTUNENk94cWZpdTJKOXIwN3lZcWpzeUk0?=
 =?utf-8?B?WWRZOFVsUlhjUHJ4OE42VGltMVBuWXB2WHZ4blROUEFTSHJyVkhUQ3RNUTEy?=
 =?utf-8?B?eCtrMVhEWjBYUFY5dWNhK3V6eE53THNodURyZXlXaWZmdjQ2cnJzMHlTamxZ?=
 =?utf-8?B?NGdOQ3pmL2tvT3l3UUVRM015cW1tRGQzZmJkMFU2TWw2UHo5Zm1qWmc2dW5n?=
 =?utf-8?B?UTFNWEtrWnJEMHZmN2YwTjV0Z2Y1SmVTY1p0d3o3c2FTTnJpZXFmRm1OcVRZ?=
 =?utf-8?B?clNFUU81aS9KeUZWUmZNOEhQQUQwRFhRckgrd2E5MDhVQjVsNTNBY1JoM0My?=
 =?utf-8?B?K0NxeXZLMFlrYmRtYkYzL0w3eFg1OThnU1JwcVZSSE5NaDRpMnduTnB0Wjdj?=
 =?utf-8?B?eS8yOVFYcHpDRmdLb1VQam1XL0lBSEwvV1g0RGo3ZzZVdGwzRFE3M1g2d05W?=
 =?utf-8?B?QmcyNVlNNlc1S3hzdFR6amdYc0pLMnNQckdmbzdOTlVHY1hrOWJRNXpWbi9T?=
 =?utf-8?B?Q1QxVWFHNS9QSlBLRE9aM2wvWUhCTWpxTTAxamROVnUxLzhoTHZ1Q0JnenpW?=
 =?utf-8?B?S083cll6YmxoblZBRnlodGUzdEtaLzl5eVUzN1cvTjJkMHliaGwzU1d2WHZk?=
 =?utf-8?B?cE1pUzVRY0M0Ti9hekE4SlF1N25BbVkrUmtUNlgvVEtwbTc1SWNsZ1RVUThi?=
 =?utf-8?B?emdPRjE5VWZIMGVYQVVaSkMxSStNUGpibFhzWDFzNHdmQ21jNDF0dkE3anJs?=
 =?utf-8?B?Zkd2ZnNuUFNCZ3Z6cTJBeVQzemRzZHZYQUhVeHdEanBmVlhDR2c1V3pNbk1s?=
 =?utf-8?Q?6APE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60be1a72-5a0b-4294-8686-08dd93888321
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:14:28.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46EzBWvfH+OJkrdCBHuNn/b5yrVyHSLCgGK0ON6rgZnPwuVQE5tjGrCl87QIcDug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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



On 5/12/25 04:20, Prike Liang wrote:
> Lock and refer to the eviction fence before the eviction fence
> schedules work queue tries to signal it.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 1a7469543db5..d5f176fef357 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -108,12 +108,18 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	struct amdgpu_eviction_fence *ev_fence;
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
> +	spin_lock(&evf_mgr->ev_fence_lock);
>  	ev_fence = evf_mgr->ev_fence;
> -	if (!ev_fence)
> +	spin_unlock(&evf_mgr->ev_fence_lock);

The dma_fence_get must be done while holding the lock, otherwise the change is rather pointless.

Regards,
Christian.

> +
> +	if (ev_fence)
> +		dma_fence_get(&ev_fence->base);
> +	else
>  		goto unlock;
>  
>  	amdgpu_userq_evict(uq_mgr, ev_fence);
>  
> +	dma_fence_put(&ev_fence->base);
>  unlock:
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  }

