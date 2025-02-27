Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7917CC19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 16:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2539710E396;
	Thu, 27 Feb 2025 16:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjF7pSRL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D5110E396
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 16:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2BNKYtKRpsLP42udAaWnIzFqx731lDnwvRySySCx5O/bI5zN1sFOOeyh1KqKADh+TJci08KMQCfWwfKU0cwV0MpgVy2wgwwdQrnxfBf95M3qmRiXiO0E/qppo5M45VpbqFeYgU4BZnVfVdSKQ0tI+ZdRJ7Sj94QeEcnuN4/rqj7mz8ztiEAOGyAFGO4KGbmzOyvTEnCEoqNzjkB1NpaF7cqVEcdJ8UwabKCvCs5qyywswem3a4M2jm+A3WWGoBHnv+8CEf2yoOHoawvE8u+bJ2w+4KrVBcBXiwcWhT3wUqEci//Zxxne/qqJNjXwn9mJTmijmP5F4G2xHfmmDrULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmNjNUnZqrbpRlLCnGL2KG5nWrD7S7VYE+12wW4wtm0=;
 b=rAoED3y9dvDzm1SsKiuTmlDgA6GtrS3JgavFX0ZzQTe5C9PZLTawVuNl4DjuZQurU0S2cPyACjpTwnu+Csur0Efi/AOjr65wYQ+0jdNdDJIUPR/u2QRNd3klsK8MABbo25ZydGuXTongzGFkss9vxDfluFQb6B77F785AEJ3nGiwgcMw6kCmFf3pyopeJlEKCsMiR2knimDI0LhhzVeIME9B2Px36wgLHanC1bP7tfw9SIa6EvCeOa4yQvHu0zYvK0p6oSBLZUxHtic94M3+E+ag6CwWtXpVOt1bnJE0pfSoI3XNEq2UHOetc0uiIdbt2lAg3Me9mpgavb/KV6KD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmNjNUnZqrbpRlLCnGL2KG5nWrD7S7VYE+12wW4wtm0=;
 b=jjF7pSRLoJ3PTyvgf0tp8DlvPPe0949idN+ssm3fUSsHd4b9G+IwZXXFb35QAkl6SJIgCIKGxVagSv8cDsFLQNSJmVLBe/9b5Yc4pHGkpnjXKNXPbbhb3IKox3eMJoU6/oQCAiQ35/1ZnLCLGFGsnHO+1tBDJ2BR7QvOgtsQsEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Thu, 27 Feb
 2025 16:00:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 16:00:40 +0000
Message-ID: <2e5d8bea-eaf7-49d6-b508-75c10f19a06e@amd.com>
Date: Thu, 27 Feb 2025 17:00:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3 v5] drm/amdgpu: Optimize VM invalidation engine
 allocation and synchronize GPU TLB flush
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250227114755.444535-1-jesse.zhang@amd.com>
 <20250227114755.444535-2-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250227114755.444535-2-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: d0298fe2-f34b-405e-f962-08dd5747e1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE1sTjlJRFgyN2NHZmR4WDRZTG9jclFuRmc3WUxOSHhnTWg0ZGNCdWhBWGo3?=
 =?utf-8?B?Z3F0Z0NROTYrSlNVR2kwT1JQWnVSbFlSR1ovdVhXaEFKVC83d3FWVk9JYnZx?=
 =?utf-8?B?QWl1RnZiN21YdFF5a050bVNsOVp3VDBmcmNLeVpZazRJQ3JTTlQ0V1l4UHdP?=
 =?utf-8?B?RndudWVmbXhrRnR4SWdlNytFdFJCWnFDRnNzVDJtL1VxTVdXRWw5RVdqY0ZQ?=
 =?utf-8?B?bHl0WmRsNEk0YkdvNHJlRmpTaE03TTlDZ3RyOHJQYmJCSUtSblRhZWl4Rmhw?=
 =?utf-8?B?cTdmenFhOGJaVmZhMzRnbUwwVDg4T3R5YTF2WmVIVjBWQVBNMkY3U2lyMkhU?=
 =?utf-8?B?RDd6TmJNVmYvdjVha0t5dnlCUVJwZm4reFBPRVRnVzh0SzRQeDJNakthY1Fw?=
 =?utf-8?B?NnVjQlowbWx5VWJSanJ6M2ExRFpKOSt4YXY4OHRGZmdEUGJEd2xFTzg4aWNz?=
 =?utf-8?B?cnVCRTBzWkRvUDc3UEZ0ZldGSEduQmhlNHAwSVlTb2Z5dUE3NE4wU0QybzBn?=
 =?utf-8?B?VVVrTmRSRkxWY2hmR1dIaXBtekpUMHg3bjlQc3JTdzc4djZ5RDU2blVsamZl?=
 =?utf-8?B?TlluOVZ1WTYwWmNiYjJiRk1rbnBzU0RPaWlucmF3K2NpZFFBRzkwTURXSm5V?=
 =?utf-8?B?ZjdCVTlyNkkzbGplajh0MHgyUmdubnR3bUFGWEdVcnREMlZwRWkxakJhYzE1?=
 =?utf-8?B?ZW5LVVpMYS8rZ25peGJNeCtqSkhIV0ZWVHZZWUFoenFZUkxHakRnaDlVV2Zs?=
 =?utf-8?B?RVloT1VTSTlQMDJKMWZrMmY4UEVPOUtGY3BadWR4TVpzVm5PZm5aQ0hnRk5u?=
 =?utf-8?B?UnNyK0FNYUMwT25QWEdxUzhmdkg3d1pMVnlKbWpaTEhMb2lJSGZCWFYzSkVE?=
 =?utf-8?B?b3hFd2ZvZ0NZNVk3dGE5OWthOWJncUtKQit0VGcyZmZ0TERuUTFXUWJRMHFF?=
 =?utf-8?B?a2pHWXdsZDVENHlMRE5qQ3RIaUVocFJCR0RGbFB3cTBrZjRiK3doZTFoclNq?=
 =?utf-8?B?MUJJS3BaT25JZnk0M0ZkQ05jZkgzeHdjUGZGcHExSGhOb1owaGJzZzFpRld5?=
 =?utf-8?B?MTZpb3ZvcFgzMm16Y1VEVWN0OEpTYzhIcFZFdUh1SEhyZ0xNSm9wK2JGdm55?=
 =?utf-8?B?VWVSVW1tV1RHQnFOZTJ1T0lobXUwQTFIWTN3UFE1SXZvTEt6YWJrcDNGbksz?=
 =?utf-8?B?Z3JSZXNiTFkvRWlQekdrcGpra3Q2bFJoMHZ6VENHVS9sVzZBVzdkV1dPTU9C?=
 =?utf-8?B?SURoVzF1ZDdHQWV3dmRqcnFsQkFjd0YrZGUwMVNscC9UOXU2cTdmcEJIc3Bw?=
 =?utf-8?B?M2E3Y2MvWFhuUEkzMmlEaDVpUVJHYUlJaXI0UlJoQ2hqc1dXb3J5U3h0cnR3?=
 =?utf-8?B?NVZDUnFkVGFpVlRmUlRXRll0V3Y4b2lDc3lFT2RrdzVzWkhBYzN5eGF2WTdu?=
 =?utf-8?B?a0VBZlFGSzlOL2VjV0JteEZKNUtmQmxKV1RsTFVFK1pGa2xTMEdPaWhtdEJU?=
 =?utf-8?B?a2h2N050V1pBa2M5RHMvOTJQcFJ4K0VEV2JnZmRNbDcxMkU4ZEpiR2ZvYlBn?=
 =?utf-8?B?azFmSExnQWowQ243NENJV0oyOC9hRmlwQ1N4YkRkeUVud2NBdzEvcjYxMG1h?=
 =?utf-8?B?bFV6WTJ3YjFrSUhuRVdZbTdtTzJWOVZTOXFQT1dDeWpZd0RMT2RwT3ZxK1hZ?=
 =?utf-8?B?bWRWUGp3QjJ5U3Arc2pCVnFEeGkxVXRhNWs0RjNiWWJCSkphb2c4SWs0VHdX?=
 =?utf-8?B?aFlJcXAzTVlmYkZjQjFmWm9ZUnlPOXVhZ1VOb09BdnlST2EvbDNYYXhpVHFZ?=
 =?utf-8?B?TStPMktkZk15azgzbWlVbXRaNlU3Y3o2UlljMTNsdnY4N1hzc2orRmZtU0V4?=
 =?utf-8?Q?5b2LEn1vltdCR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRvZGs5aElOUzhGTUM0S3VGb1ordll1UE9OL0NySHNMY3RYR2x2K3BuYlBi?=
 =?utf-8?B?QUlvYWxoblcyeWQ1QWVSTlM1QnJYTDM1LzF0OWFOb0JPUE9wR1JVc3FYZmpq?=
 =?utf-8?B?aEg0Q1J6S0FNRXpqUE92clZQK0FkZk5NRVhhaVdBTWVGalBpZGVISm1NU29Q?=
 =?utf-8?B?azc0UnpDRXNyWE4yVGhldVd5Nkw4T1FBUkRxa1dONElnTnFtYlQzUUZUY295?=
 =?utf-8?B?bFVCVUw4YlhMNUowOW9oeDFsYUcwSCtGUFBkQ25XK3FIOHBRVHBVZ2JYT1FB?=
 =?utf-8?B?RlJ3Nk5ZZUZoYk5VNytXYlUxTS9rZ0hCcGE0Uk92UG9yeTVKSHZUQzJtYWNl?=
 =?utf-8?B?MjZXT3l5Y0pHOUd0SFo5YkExbFRKdmF5TThQMkJQSEgwZnJHbWp6ZWI5cXlV?=
 =?utf-8?B?aTd0RFV4RGpmeDJGR3lna3ZUa1BhTE5nTG8wUWx6ZzFsN3RzLzBPejZNWDhC?=
 =?utf-8?B?OG5ud29UTmxGa3N1aGFmcU9XY3A1aStMS20yNXBSdkk0MW42Q0tiK0xNbjlH?=
 =?utf-8?B?MDVONm9yUWVwN3ZFWmhHSkdHa1FSd0FIYjhpdUQ4YnJTNndzR25CZmt3UHBa?=
 =?utf-8?B?ZGxqU0lidEJyNXJoUnlrOVp2YktjM1VLZjdLOEFEaTVqcDYzajBPc1pXT2hC?=
 =?utf-8?B?ZVZjRkI0aDVTV0xKbjRpQnhBUEViejN0ajAvMitxRkpkYndHeG5VU3FjZmZ6?=
 =?utf-8?B?a3Z2ZFFjQlE5WDhWbFlsYWQxTXF1MHlXUm40TFVyUFdQWER6SWw0Ym93Vm93?=
 =?utf-8?B?b1pkWTRvam4rOVdBUG9EVUFXUWdUaUhRSlZCY3ZBTTNDdkRtYjJyRHpJUnpj?=
 =?utf-8?B?cDVsa1l5d2hKUnZSTm84YkhjemJyVmVEUGsyTm03UGZ5S09nRUs4T1JFWHFh?=
 =?utf-8?B?SlVZdEdIb3pKSHpUQWRhWUhQdlpMQ29jM0dCNjcybi9ydDVmTnd6WFRLSGhI?=
 =?utf-8?B?Uk9YaUdCZGN6SzJTZ3JhQldqV1Bld3l1d1RNckMxaEhGNFJRUFhwMXFsKzJY?=
 =?utf-8?B?anZUdkMvaHdoLy95MFNWVjRKOUpJNXVlTVVDVXdQZW9lekswNC9PckZkVHhs?=
 =?utf-8?B?akxYUjd6ZzRqM1Vxc3ZSVGVOMDgrUmNKeWt5OVI4Sys2T1RFL2wvL3E2ODJm?=
 =?utf-8?B?aEJQV2lRSTJNMFpxQkk4Mll6NjdFMzB1NHZQZi9UWTlPdnFYSTJYbGtUWGNI?=
 =?utf-8?B?M2k0dGVyU3hQNVQ2L3JMbyt4ek5iL2hKVUgyYU9JeTcxTU1VYTU2YWJVakx5?=
 =?utf-8?B?aDZHY2dORm9QNEE5YWJZVklJaVJBeUxHZW5qU2ZFTTk0b3VobXlZTDlkSGhL?=
 =?utf-8?B?WVVPemdId25qeUZMVFRHWUxXVkx2SDFBZVpvbXBLS0kwOXVMNU1IQmZhWjFy?=
 =?utf-8?B?TkdyUldoSUtKVWRyNzRjSDRqYU9EMUN5VHlNbUFGbWc4ZWlpL3BjYmRGMVJF?=
 =?utf-8?B?RnpibGZKUDJhWDN4aFB5aTdSNUtrcFRzV21Eb0Vqc09xeU9JQzV2Z0psMWlP?=
 =?utf-8?B?NkxGUThrTUxkektJSk1BV1gveUJhNGNCaGpvdDlXT3ppVEh3OGV3dzVvNkF1?=
 =?utf-8?B?R2xLZXVDL2EzOEVoazlsOVJyOHBLZjlEM1U1NDhONnVWM0QwNVVBNGJ1VnZw?=
 =?utf-8?B?Y090U3RxQWJNUCtuWTNRWWtRSHJPS0pPN2VuU0VuSUJEYjZJc3VobEJFQmhF?=
 =?utf-8?B?MzNScmVFSnVuN0crb0dQcVIvTVk1bHlKVWY0QVhKaEtTV0J3V1NEak5Dek9j?=
 =?utf-8?B?RmZhSk00eDV2QWI5QVdiek8xcitiYld3dSsyTmRIQ0F6R2RYNkNnQ2pteWlw?=
 =?utf-8?B?UUxkTklDQUhXQWJsQU1EME1vdExoQWRnUVFNcUJVd0Z3RDBtdVB0cFcwWVNB?=
 =?utf-8?B?eCtMZUxadmNjR2hXQ2lUUzhEb1dDMi8wNEVNZWtPdXVzVExGa2YrTFlEZ29q?=
 =?utf-8?B?Ty9qTGQvaDFMb2dyb0s3UkNiTEg0MmdnS09rMmo3VzN4Rm0vOUwybjdrQ1hx?=
 =?utf-8?B?UG9YNUxPUHAwQ3A4VGxQbnI3WXVFbSt3Qit5dkljYzAzTUNXYzlaeUZoN1dI?=
 =?utf-8?B?TkNZK2JaUVcveG80dEwveHpNNHNVdFczWHArRkY0WWlDM0tXaEdSa0creGRL?=
 =?utf-8?Q?R3JYRz8ZJxpz6UssvyAoAdequ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0298fe2-f34b-405e-f962-08dd5747e1d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:00:40.0849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9OJcJEHHOvvX4DD6VSW6gFjZXFoH0KUJ9pnogwhCDsif0soyoWcn6Sv8yi6JtmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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

Am 27.02.25 um 12:47 schrieb Jesse.zhang@amd.com:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> - Modify the VM invalidation engine allocation logic to handle SDMA page rings.
>   SDMA page rings now share the VM invalidation engine with SDMA gfx rings instead of
>   allocating a separate engine. This change ensures efficient resource management and
>   avoids the issue of insufficient VM invalidation engines.
>
> - Add synchronization for GPU TLB flush operations in gmc_v9_0.c.
>   Use spin_lock and spin_unlock to ensure thread safety and prevent race conditions
>   during TLB flush operations. This improves the stability and reliability of the driver,
>   especially in multi-threaded environments.
>
>  v2: replace the sdma ring check with a function `amdgpu_sdma_is_page_queue`
>  to check if a ring is an SDMA page queue.(Lijo)
>
>  v3: Add GC version check, only enabled on GC9.4.3/9.4.4/9.5.0

This needs to be the last patch in the series and not the second. Otherwise you have a broken state in between.

>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 23 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
>  3 files changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c6e5c50a3322..68088d731c23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -602,8 +602,15 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
>  			return -EINVAL;
>  		}
>  
> +	if(amdgpu_sdma_is_shared_inv_eng(adev, ring)) {
> +		/* Do not allocate a separate VM invalidation engine for SDMA page rings.
> +		 * Shared VM invalid engine with sdma gfx ring.
> +		 */

First of all that comment has style issues, please use checkpatch.pl.

Then you need to describe why that is done and what are the pre-requisites to make it work.

E.g. something like "SDMA has a special packet which allows it to use the same invalidation engine for all the rings in one instance."

Christian.

> +		ring->vm_inv_eng = inv_eng - 1;
> +	} else {
>  		ring->vm_inv_eng = inv_eng - 1;
>  		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> +	}
>  
>  		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
>  			 ring->name, ring->vm_inv_eng, ring->vm_hub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 39669f8788a7..019f670edc29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -504,6 +504,29 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  	}
>  }
>  
> +/**
> +* amdgpu_sdma_is_shared_inv_eng - Check if a ring is an SDMA ring that shares a VM invalidation engine
> +* @adev: Pointer to the AMDGPU device structure
> +* @ring: Pointer to the ring structure to check
> +*
> +* This function checks if the given ring is an SDMA ring that shares a VM invalidation engine.
> +* It returns true if the ring is such an SDMA ring, false otherwise.
> +*/
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring)
> +{
> +	int i = ring->me;
> +
> +	if (!adev->sdma.has_page_queue || i >= adev->sdma.num_instances)
> +		return false;
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +		return (ring == &adev->sdma.instance[i].ring);
> +	else
> +		return false;
> +}
> +
>  /**
>   * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
>   * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 965169320065..dcc8fd7a6784 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -194,4 +194,5 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_sdma_sched_mask_init(struct amdgpu_device *adev);
>  int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
> +bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_ring* ring);
>  #endif

