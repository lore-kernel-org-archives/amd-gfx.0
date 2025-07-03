Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACE0C83030
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jul 2025 07:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFF310E7CC;
	Thu,  3 Jul 2025 07:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tsJYk5Ei";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF9510E7CC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jul 2025 07:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNvm393uqaHmqSJ5hdK7DbUTzV0pFkuu1Mu30iiLADEugksBZ8JQ9/+nnGaYrLX1mu+cEPT1ztNV6puT0iXBRoABPcefr8t1n6AcyQT+jT6V4s2kZETqRuvE71g+7CcgsaM+YeHJtxyH7MbF2Z6s/H4BR0p2zNXCsTDH5DZMyuh2HSQGmqoVo7nxWosx4uBFVIrWudTHsxPqC6d77m6DLHTdBz5MGVmck0pCCsJavKe5lD1BXfs/7fGqfCwY82ujAJo2zNWVxS+vLc6AJMPDodxLH+0D8kMfkGmmGS8ceNmoGqMSpnFUPByOsLbk8ZbktHvvkGDZ2HXcrDIv/0teag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TorRD9VZRCgpgQV/KEnEKYVLzO8HGfcfE0UnmtXermk=;
 b=Ad13bz9C3OXCMjaWO1PTlMHM97JSO1kvh4FIf+FkJ8UjnUfbohKon7mscBtcQKZZVPrN+HI/Qd6ufSzwle6xzPQh8ABtjXUX4cxSDAjQTSH7JFrkhfcw/pmbqt8M8uLxylsC12hLkxI/7GuGXTf9yKxP20QRG3fTwoGWCl+SntGhZAwvbYAahRFVPWVBExHW3PIRugDqh0Y+IrsHSwM5OYYcEd+mOOikQMbRxpFEpUTA11KfCwdMSbCBYcLE9X4BXkbvBB8e+a2ZdLakN/R89AL4U3IwV4T2MF2RVGfrNLkQD+RvqDcHyFA+L9ESb+sO94ax6NQKnDUaaj5676L7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TorRD9VZRCgpgQV/KEnEKYVLzO8HGfcfE0UnmtXermk=;
 b=tsJYk5EiqDDs3juYOOcGGvD/C9+BWhtDE7249aRqEyQKmbe/5WS5Rxu3SVMwQsYJf0Gl7qDp7pbI67Rdv2RwA+b7CFU6Nbk6EhGfqfXn4/sF7/pTkm/r/RW3wTt5wpFRtfYvq6dI+tfb97H1q0onkS31ifVFPtMp1ufNpk0cTI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 07:18:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 07:18:10 +0000
Message-ID: <0aee7f5d-3064-4894-b448-d97a2cef90d5@amd.com>
Date: Thu, 3 Jul 2025 09:18:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c"
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20250702171020.69028-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250702171020.69028-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 029224f8-e855-4e8c-8db8-08ddba01c3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2FUTVNJTHFGK0FobmFBTGFHY3RDVmd1bmQrSndaS3RNNFJydStmSU5pVThp?=
 =?utf-8?B?NG0zdUQxZlBBWXNPbWtHSHlaSm5qeU5INzlUQjZndE5YUkp5bDc1dVc0M2Nl?=
 =?utf-8?B?bEFnWk1FQlY5ZCtFZFovUmJDNFd6SlF4L2l4Rk5nQzIzQVkvYThkZFpwRnV6?=
 =?utf-8?B?WUltNjJVbklYWXR4NDYvVnN4Mml3Z0xxazhwRjhTdXRSM3d2SXNRNnlDRlZT?=
 =?utf-8?B?Q25EZFBFUys1bmFzOEFFSnl5RGEzaUJCWWI3TzhLRjVSMVFzQmVnYVcyWC9k?=
 =?utf-8?B?MHp6d1RnclNEQk54QXVzR3JQN2JSWFQ0MG85M1p1LzlEZ3Awak5tTmpONXF2?=
 =?utf-8?B?R294VmtXSTg4MzVnNXhkUGxFWXlEWkRsZStJZEkzZEZhMDVNdTVVMmxsWW9D?=
 =?utf-8?B?UDFyek15YVZ6QVdkQkhzRkxNK2oyZ2JWaUFMM3p2YVhzeklWQ3MyR3Zyd0tl?=
 =?utf-8?B?alhvUkZmVFVVVWZhZmJ0RzBNNXBLNDliZ04rbkZFQWZScUJnajBtNkMxWnMz?=
 =?utf-8?B?WnNuK2xrL0pEQlVuYkprQndiMldoQ0RNWGlvSWlxc2FtaGZiWFJOSk9CWkRy?=
 =?utf-8?B?a2dwenZyY2YzQ1BwS2xIWDl0a2Q3bWRmcURvdi80N0JoOFkycXA3TDV4dGFW?=
 =?utf-8?B?Q2VMSml4NGxEVXFuRTRGczlKOHJvMm1FUlJTUUt5RGFlQit1TEc2a0pkL21Q?=
 =?utf-8?B?RVZWSGJkdGQ3MkFla3FuM1ZJTjVXT01rSi9sd2xjUlFyZ2VmQis1QkZUSTlh?=
 =?utf-8?B?K1ZjUzdZdnlzdVprM0t5bnRIcG55WGlwL0RzNVhVM0FJZ1pGZVZCQUpjbVE2?=
 =?utf-8?B?cW9UNnJ1aGQ4aThZZkFIVjN3eG9EY3RITTJ3d1Eyajdjc3NVdEZRQzJMaXQy?=
 =?utf-8?B?WVhuMUcxdFZ5R2drN3daLytkeDRkWUxBbWVQN05JS0pGMm1PMVRGTDFXUWY5?=
 =?utf-8?B?ZCs0VTlTS3NJeVVBOXNSNlY2N29TU0o0RDRRdmlJUVZ4QTZqVkdDMVRMKzNL?=
 =?utf-8?B?bFp2RDhVSFJ5K0ZQbm82K3Nza0xDNVZQc0xDQUJWWTVLSlZ0Z1EvR1NTUHp6?=
 =?utf-8?B?d3Jab1ZNeTN6L2w5WlFFVThVRm5wUGZwQ2cxRGNyamxQUENLL0grK0txenc4?=
 =?utf-8?B?c2Z3UHE1aFJPbnI2dzNNMWpNNVlyWHFOaUMxNEcxQjdpWmhWaUtrbmlRY0ZE?=
 =?utf-8?B?VXEvS294cnQ5MUFVbHR0M0VtUWdZNEFmc2loaTVlNkVBMDczRnNCd1VaVzQz?=
 =?utf-8?B?UlhaZGpYZlQvMW9YRjFaWThuRGpXRDdmUko0dXgxRG1YbVVHRGhDanFma1NZ?=
 =?utf-8?B?bmUvVVVxNHRzQ3AwSUJ3Q3hDVk9rSkw5cFVwR2ZQR29lWEJFVkRoV25uMUlv?=
 =?utf-8?B?VENtMEtuSkhmK1B1SjNCYmpBbWVtbVdNY1BRajZTMVNWem1Ka0FlMTdPUW0v?=
 =?utf-8?B?b0d0UEk2bXpHRGlpSGwrUDFIV0ZNclpISms4Sk1yTDNuV3AranV5dXlqZ2g0?=
 =?utf-8?B?QzVYek02dzJhYnROSU5qeTVMRTRreVQ2QzV6ZUlYZDRBaFBkRUcvcmdSOEMr?=
 =?utf-8?B?STFNY3o2MkI1NElJN2kzeGJ2ZnpOV3MwSHFJVG1uM2FpalNwNmVPMTkrYm8z?=
 =?utf-8?B?YmhqaTFpN2N6aE1Qd0YyUlNMVmFFQkVobFNIc2FoZDJpang4RXhJeXNQK0Ja?=
 =?utf-8?B?QTlrR0UrK05SNGh0cDJlZkcrY3BHdWI3QW1aZ3ZTQ20wek5PV1czd21zbUp3?=
 =?utf-8?B?QVZwZjZ6Uld5Rmd0cCt1RlUyQXpJWXVBbnZuUUZ6SG5LNzZIRXAwMzZXSk1r?=
 =?utf-8?B?RkhDNmcxTmNwUjBTOUVsaUQ2ck95TlJFcnlVUXZuRjUyRkxycVNWVEZFdlhY?=
 =?utf-8?B?ejNGemlYUUhqeE1lMXlydkR6K0x3SzMvKzhUWVNLaVh0aDQ4WnJrVDJEYjhM?=
 =?utf-8?Q?Mlam/+lDMGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZhcXY0VldtcytxTFg4dVYvM3hxSHVKV2c1L1N5RHV5dnkrU09lNDgvdkdo?=
 =?utf-8?B?NktYR2RER2hYRlE3dlc5MWJyUy9menpUUlpjQnc0WTR5YkZ5VGxmSEVHUHVB?=
 =?utf-8?B?enJUdTJBcEZYSGRBa2VCb0IvejMvdnhtN1FQa00raTR2NjhjSUtqSVFOQzZy?=
 =?utf-8?B?OHBaTVhVVnMwbFV4RUE3TXl4NUF3eEo4dnFnckVXQnozRkdncmh6VjgrL2F0?=
 =?utf-8?B?QVBzaVpqVmdEVEJsNTNudkx3bTlJWFpDc2x1dmJjS2lPQnJkNGFKRWRIQUJK?=
 =?utf-8?B?RFpmQ29FNFJKTUNyZGtjajEwRW04Z0xabS83ZS8rVjVlbE1Kek5nWUZsaXRS?=
 =?utf-8?B?Ym9oZE9zOWpwU0VJZ3dCc1VLcEdUajk1MDY1TEtFeGNra01hN2dleHZpaXlJ?=
 =?utf-8?B?aTVaTlE2bmdNUHpuNkkyY0dINWVwMTRGL0xUSUcrN0JsNTA3WG9DTmxFQU1E?=
 =?utf-8?B?aE5NV3NuL1BjR3YxYkkrNmVSUEV4UXpCRDlDVFh5dFlqdG5xbFArUWgzSGlN?=
 =?utf-8?B?ZnpNS1FqSmpCOTAwVERwODRKc05EQUozUzdJTWZ6WHVvdGhncTZBNmJ6MllR?=
 =?utf-8?B?WUlZQlpjUkMrYlhkWmROaHdQREpjWUZpcytSVjdPOTNkazNsT1o3c0NOUHZi?=
 =?utf-8?B?R3JpaWQrWXhpaHQ1WStVaVVyK3dXY2ppMXNqN004WVphM25VQkgvaEt5d0Nv?=
 =?utf-8?B?MnNHVDBsbU90aHA0d0RYU2VkOFlKcFAraXVnZXg0aHRLTFlOdnNlTHNJdUN2?=
 =?utf-8?B?bTFwbkR2eENQRkNrVk02VzQxMnVHK204UXkrclVTQmxneW9sZ2lHUXVLamJO?=
 =?utf-8?B?bXRJQTh4ZEFIb2ZTbDhRei9lWGtUMVJmSHc4Y2pCeWs5YjhjSkJONjlVQlJT?=
 =?utf-8?B?c2Ruck1PVEhkWHJIQS9yUkcvZ3BtRXZhTG9wQkc0bVJrT0poKzRpL3NKdy9W?=
 =?utf-8?B?MGdGejZIUHlOcUZ6bTgrUi8vbXVVT2w2YVVEZXZvSzFtdktpeU4vN3ppWDdq?=
 =?utf-8?B?NFMxck9IOUtaWER5WVg0M3E2Qld3NWhzUHREazVUL0pYYW1DYXBRWENqVm9H?=
 =?utf-8?B?eUpScnkzYXlSS2FBVDhIQmEwSXNTMXYzMVRzbytTcFBqRzRQTm84MktRL1BQ?=
 =?utf-8?B?eUw2V21aU1d6M1Zra1FPb0VzVkh6MFlTbG1MRGtlKzVOOU91eGhYSnRDaDhr?=
 =?utf-8?B?aHhWNjNreGdXVE1vS1JPVVBmMlRwdFpsYlFsSFJWRytra3Uzc1JvbytNWkk4?=
 =?utf-8?B?QVA1amx2ZHg4dzUvUmlaeEQzSCtLYXZ0dVI3Z1QwNUJnTGVJSjY3LzRlaENl?=
 =?utf-8?B?S0p2T3Q4VnlSNm1lM3M4TCtoeDhGSUc1VzFrT21qOHZodVRZVkIxbXp1Qitv?=
 =?utf-8?B?UWowSVdQd0k0YkIvd2xYajZIbTBjdzBkbmxSQ1MvcHZtbi9qb1MyOFRlWW5Q?=
 =?utf-8?B?bGVkOVlTOHNrejVrcFJTd1E3ZVpJSGpoTUtMb2dFNXJycFBRZHZITUg3b0Nr?=
 =?utf-8?B?R2VyTmR1bmg1SEc5SHFXYnN1Zi9sQktGQXJiNnRpcElEVTdBT3VXMldVYXdL?=
 =?utf-8?B?K3Z1N01idFRRZm1xbk9JL0hLWVNWbnNxNTJGR3NQUEJlNnlUeXZpNmsvRU1D?=
 =?utf-8?B?Yk9PMEIzcUJsS2ZQK0R2L3FTaW5KSy9JcEx0SzRxeGxBS0dLZ3BraFpieW10?=
 =?utf-8?B?YVppUUcxRkVYUy9WU2hWdXpRUitrMXFLZTd3MHJQbm00OHFQcnRtY3ZSTDhk?=
 =?utf-8?B?R2hqb3JNNjhLY1hyUS9STWgxVDRmeTRieUZQbWhqRVZEUmZwelRGdnZMRURZ?=
 =?utf-8?B?QWRBV3drZjY0VUtObUUvTjFjSVc2ODY2bFhnckwvVWx5YzhtcXVvYXRKbUFj?=
 =?utf-8?B?RUxNcmNyTWdGdEc0TStyNHdOWS8vUDQySDlWSVlabmc0S3VIVEduUFJRd0I3?=
 =?utf-8?B?S2JTT0c3VXNyMjEvQm5qbW9IRU84Z01uV2p5RjcvejJPVFAzaVpIVjBJaDI1?=
 =?utf-8?B?ak1iTkM1WDJNNlg5VzZ6YkFnZzZvVnNpSlJiaG9BZ3Z5UTZlSGhEbWYrRThX?=
 =?utf-8?B?SjRIWDUwcXNONzY3S1JnbGJ6S3BWenM4d2x2cmZMZzJDWGgzQmFHUGxkVDBt?=
 =?utf-8?Q?dLq1rbWibUYs0K+mughKo04FL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029224f8-e855-4e8c-8db8-08ddba01c3ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 07:18:09.9813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnCdRdHBFQqjR0C899j3VKgdyslUBFFFqSZ7AvxEkOQf9hzrByv/D9sHC3dHIfGF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
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



On 02.07.25 19:10, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> This reverts commit 0203ef5eb3b2a3a10dd31bac8fc2fa3b439cbb09.
> 
> The original patch moved `amdgpu_userq_mgr_fini()` to the driver's `postclose`
> callback, which is called after `drm_gem_release()` in the DRM file cleanup
> sequence. If a user application crashes or aborts without cleaning up its user queues,
> 'drm_gem_release()` may free GEM objects that are still referenced by active
> user queues, leading to use-after-free. By reverting, we ensure that user queues are
> disabled and cleaned up before any GEM objects are released, preventing this class of bug.
> However, this reintroduces a race during PCI hot-unplug, where device removal can
> race with per-file cleanup, leading to use-after-free in suspend/unplug paths.
> This will be fixed in the next patch.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 ---
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4f8632737574..1c54b2e5a225 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2911,6 +2911,20 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>  	return ret;
>  }
>  
> +static int amdgpu_drm_release(struct inode *inode, struct file *filp)
> +{
> +	struct drm_file *file_priv = filp->private_data;
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +
> +	if (fpriv) {
> +		fpriv->evf_mgr.fd_closing = true;
> +		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +	}
> +
> +	return drm_release(inode, filp);
> +}
> +
>  long amdgpu_drm_ioctl(struct file *filp,
>  		      unsigned int cmd, unsigned long arg)
>  {
> @@ -2962,7 +2976,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
>  	.owner = THIS_MODULE,
>  	.open = drm_open,
>  	.flush = amdgpu_flush,
> -	.release = drm_release,
> +	.release = amdgpu_drm_release,
>  	.unlocked_ioctl = amdgpu_drm_ioctl,
>  	.mmap = drm_gem_mmap,
>  	.poll = drm_poll,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4aab5e394ce2..adba7d0ac147 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1521,9 +1521,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  		amdgpu_vm_bo_del(adev, fpriv->prt_va);
>  		amdgpu_bo_unreserve(pd);
>  	}
> -	fpriv->evf_mgr.fd_closing = true;
> -	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> -	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>  
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>  	amdgpu_vm_fini(adev, &fpriv->vm);

