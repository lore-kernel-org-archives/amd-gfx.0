Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DD4C021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 04:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6046410E36F;
	Thu, 20 Feb 2025 04:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rP7KuMH0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C759B10E130
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 04:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg/h9018w9hPu0yXcZJ2tsM6cUBiVMBK4GB7RLBJuYqG//D8QGzj+cK7uucveYm5uY1wlfIBs3gthLcHGimoKvkjTPdXQsINkmtO4gH0HywHn/jIx8S/cFEAjzAIZ591gE9OuXbY12+rLq9wvQMf3ZKoOI71maKYdyZRXKC3cCbR1qcJCdocMG6ITH1unteEYpZ/86PhOO9imHRjEh5v9rBwjhthXgsb9x21ndreGlFrEGExfbPFoNO3XKtXOXwAG/6+98p8zxXo/f48CF5OEHVp85zPrYcoIIve8HZE6rwxl5wNyk74WEp5TlKhb09UMma3oALqTmjkDvGNgG7+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN1BhtkTK/iHjb50ueUApe1FP+f7wqrSh0KZUS76bhk=;
 b=W5Wl5dWWWqy5sHGPWpnTXopAIDgYtpx9NKR0h3YWCDj+S/Qr6QUt3RPF/0cIdMk5B/AZ6NpO34WBr6YA1d09caPVtkhm8kT7BK+nWwwOLR4cEUlxSfoaKev5cMBMSKRwRXmcDlRsz4POVRohftZt3prDwSx4/wvkVw7NinlI1/rQKWrMj00Y3IccqbnupPJf2WkYGmfFOBXKAd6dPpKPIA/PT0aIAdgju9jjQgeS4oXMA+6nzTyfovgTJoCLES+4EkqO7k5jaaktdORsrHe922ektsAUatYlJGwAXQAW7x/RtMCiYVe5UB7r1tSM9AaU+0TcirI9QL6RTTLdyS7FRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN1BhtkTK/iHjb50ueUApe1FP+f7wqrSh0KZUS76bhk=;
 b=rP7KuMH0YUbhwv60n3WHBiaU88W9EL9gkDTnkZhVZqbbbDigIrb5TkUcloTM300U8LwRV0u4Wnq7Ua2ic28+eLj1hbLN1CyRuyZn3kXWEfEdjhlIxAPR7RPTaLersesWVJ45UpgfyLZ4LckPYIctmef28XgNVsucKXjfD2cA/Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 04:55:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 04:55:54 +0000
Message-ID: <41eea943-18e3-460b-a088-e2325b9a3064@amd.com>
Date: Wed, 19 Feb 2025 23:55:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix Circular Locking Dependency in
 'svm_range_cpu_invalidate_pagetables'
To: Philip Yang <yangp@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Sierra <alex.sierra@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250218160130.810595-1-srinivasan.shanmugam@amd.com>
 <5348d3b3-a9eb-24cf-b6cc-33e433bacb7c@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <5348d3b3-a9eb-24cf-b6cc-33e433bacb7c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 132c00ed-13e9-4a4b-f0c4-08dd516adb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjVPZG1wSjVhaHhnV0ZaMnlGeXNzb1dRWFZJZ2JLZUNXSmZpOEtkK3ZkN3J2?=
 =?utf-8?B?RVVNQzFuT2lpNFVVa1BrMlI5ZFNCdzFSbkYyUEVCYW5iKzNXTXI1Y1JwMXdU?=
 =?utf-8?B?NHdUZnlVanNvZlg0ZytkTU1FaWx6N045TDZ6aGRoYitqYVRVWHMzNHdBb2tW?=
 =?utf-8?B?OUZTTlFCbVpjeE44M2hkb0NuWjdHZ1VXdjkvSUpzRFJWNjNVUFpPRGE0NGxF?=
 =?utf-8?B?NUxKSXgvZkRwYVYyam9ONnM5UEFaTmErcnVKaENOaXJTWXZzM0tQRTRKYnZv?=
 =?utf-8?B?a1ZYNS9FTmFTYWxzUVVsK2F3eW1YamNlREI1SmhzbURVNGpVUnBZT3kyRUlq?=
 =?utf-8?B?STBLS3lUMmcya3RCL1lMY2toa0d6TjJTcERHaUsxWjZVWDFrYjVFNmd2VnM5?=
 =?utf-8?B?bmdtQjFiRndSSTZZZEhCL3Rka25TN0RRNzZzTDhLQkFoQUFPbnhqZ2pyNk5B?=
 =?utf-8?B?emRHM2hCaWgwY2tzMEJDS0pxdVhPVFF3Nng5L0Y0RmNQTUZaNEVLZHFaZE5o?=
 =?utf-8?B?ekkwcEVGaTh0OXBDYVJ4ODc3cVo2TUhVN0g4Y1BXZEt5S1QrZ05KeGdnMUI2?=
 =?utf-8?B?aVdwcXo1SXZVemc2NmF2L0xWWTM2K2F2Tk9Yam9UeHRFdDMwbU5QRnh3eHZF?=
 =?utf-8?B?Y2NUMm12eWdydnZCUU16ZWdEQUp2RlZCYmRkdDdNREdSWWVEWUxPaVlQM2sw?=
 =?utf-8?B?dHA3WGV3elR3Q1FzM1pDR1pWNUNqZkg4ZFpiL3hMN2ZKTldHdHBuMHg1SjdN?=
 =?utf-8?B?V25VSk5LeVJCeWlTZ0l2VnFPWEpwWjgxRndndWpRSEpidVc5NlRTU3VRQ1Rw?=
 =?utf-8?B?b1dndVNTNzRqdkZubitvUEFVK1BvZ3Yxalh2NVpSZE9LNnduMEx1Y1F2bEpt?=
 =?utf-8?B?ZTAzWmxES3IxQUk4RksxL0JTK2VsRVBKQ0haMS9qWVlZS1grS1pwL3FoY0Ey?=
 =?utf-8?B?ZzYvMVcwZkFlOHJCU2p1dmFaYlduOTFKeW50N1hqY0ovZG1BVnk5MTQ5Y0wy?=
 =?utf-8?B?aGpGczBjQ0daNG1aempqRmd4SndaNk54aGlOOFZweVEveWNlTS9tQWgwYlIv?=
 =?utf-8?B?WjJMTXdXbkd3OWdONktkcWdvalQvTndwL01QZXptV1ZMV3p1LzROTjkyQm1E?=
 =?utf-8?B?ZGxGT1UxUmxhUHp0RHk1dXV5dG0yRkIrbEFmU2JIV2N1RTZ6NmRyMmZ3aHdQ?=
 =?utf-8?B?NUZjUnY1WjBmNWZqQTRVdG5VL01WVFZmK2dLOTVPMG5vWW5veUhJNDJPUGxY?=
 =?utf-8?B?Qm5iZWUvWENHZHlhQW5SYnVwc2JqVkhUOFhaZDFaRkpFN0w0TzRFSDdSQXIw?=
 =?utf-8?B?SFBZZ0w2eGVrcU9ib3I1TVovL01QNGJZOEw1U3ZLTnVmQ1I5TUFXaVgrblhh?=
 =?utf-8?B?RFFEVlFLTHg5Sk9zenByWW9VT0c5ejRZNkovTkhiUm5rWDFodkVmUXFSbmxx?=
 =?utf-8?B?S3R4TFFWaWUvbTVkQ0NsM0dNZEU2QzVEenBQQ2plblM3VlZOYzBJSzRkS1Vk?=
 =?utf-8?B?UGZScDlRU1RQbkc1T21pZFFieG8ydWpKYzhvWVlCZ09VTkhWOFF1U1c3OTJW?=
 =?utf-8?B?QkprSzN4dXBTaUt5eVN1eFJmeDJLTDBjVzdkT2hWWXJDeGgwYnFtZkRwUGpa?=
 =?utf-8?B?NG1OV2x2OWJLZ2VYcHJCV245RGJsZkx3TzVTTWJicDhSb1ZBTWMxdXdtbG5M?=
 =?utf-8?B?VzEva2had1ZjUXI5VEJpdGFpNkExL2FsZjJBVmRGSlpFRnNJZnNTNldDWHJO?=
 =?utf-8?B?dlhBYkE2T0txd1pXZDFxRWRTaXFWTFF5VnRDbVRtUGRoVmhUa2tHQnBWV1li?=
 =?utf-8?B?Znh0cFF4Y3hyUWNUNzNRMExWTHFPWit1MzhlYmVEOFIxdk9TYU5DWUJaM1Ev?=
 =?utf-8?Q?abTQ3bMo+b90X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2kwVGdBb2JST0Y2bUttY0x2ZDhYUkp2SGRSQ1JNYURUeGdDd0FZSVhGQTV1?=
 =?utf-8?B?dkxjWVYxY2pRQnh6dVc4WEJ4WWpOb1NoWGJqMHBGeEw0MlhMdUdnQVd5eXA3?=
 =?utf-8?B?ZjBpTmozS3dKU3RxUnVsRTJPWG9HdDlKWGFVV3ZHMy9RVXd3LzRCcTh5QXFa?=
 =?utf-8?B?ZHRxcXR4cjZxT1BYWEV6QWlKL3NzSUE5RTFteFRlc1N0WDN1QTVlZXlvcFNR?=
 =?utf-8?B?MWJBZXVoeGprQkJPaTUxZllOMjUrMmdsNVIxN21lTWY1WkpZZHNKK0pwTlpW?=
 =?utf-8?B?Y3BZc1I0alFLMTFNdDRqb2xyUnhQSVJRK0NzRzQxZG1qMm9teldEVW96SnFK?=
 =?utf-8?B?dG8yMERzaStGcHhvODl1UWJYeEUxOGRGeVJkQ3J5UW1sWGJHbGZUK1Jhd29R?=
 =?utf-8?B?TUM1TCt4ZEx5ZGhHM1JQWllhVldPTjNCclQvZU1CcTdnU1FPZFZWRW9vRGl3?=
 =?utf-8?B?NHZ0aFZ6UWkweUY4bG1LbUR5bGpQV0hFd0JWdllBVUZoVk1WYXpZN3VsZmJO?=
 =?utf-8?B?cE1kRWg3bVlkS3UrT0sweWFCNGwzWDEyTnZJeFlCcFN3ZWE5QXVwTHZha2tT?=
 =?utf-8?B?ZGZkZGR4L0M5V09peXVuWlZzbG5KLytLNzljakk0T0V5dmQrNllSd1NRQnV2?=
 =?utf-8?B?STh2bGswbGR1bFJQb2h6VndYeU9aZDBVdDZSTzR3ZnRjODhpMm53MVNIb05N?=
 =?utf-8?B?NVlVajZHOTE5ckViN1NBOWZCbFU5Y3Bucy9aZTBQWWFoeExvZVBSQjd3K0dR?=
 =?utf-8?B?aTd2Rlp2ZWNNZG5FWXdlVm9WaW5ydE5TQ0srM2p1aWpxek9TTFlJcHlYTGxx?=
 =?utf-8?B?WUgrUXMrL256Z3dhUVhIT2s0NGV1d01jZHJlak5VZGc1ajdwTGZUR3VuY3NL?=
 =?utf-8?B?UGdVbGJjQUhpZk9JNEFLK25ZUldlMURFOFhPcyt5M3BlbEtrSHlKYlBqZkJi?=
 =?utf-8?B?UHVsc2ZOSHZxNW5FNkRhZWQ4Z29XVzJ1YmtKSGdNeG8yNlpiM0lJUHRFYzNI?=
 =?utf-8?B?Z1pQbDNMdXYxN3pYV2laOHlZaUM4T1U2QlpnNVlCaThZSWxwMnVtL3g4aHlQ?=
 =?utf-8?B?NFJpQ0lQVTNKa0kreTlKUnMzV01vbUVLd2o5Rms0dzRBT1VlOXo5SUlIcG5w?=
 =?utf-8?B?WmFESlE5dVJyeFY2aFZmUEd4c1FDeXhhT3ZFazdpTlpCUXpoOWpDcnlmQ3lU?=
 =?utf-8?B?alhEdGgya3RXdDlVSnhQMlhkRWwvOFdQK2IrM1FIRkEyVm9abyt4UHgyajhU?=
 =?utf-8?B?OEJBelJWbDNuN0tPRUJRMXNDYTdFaVpWMVFOMEhtWDdGZkR2ZkRrWGxJVXVk?=
 =?utf-8?B?Z0ZxbUJWQUtlWUFTN0EvWm9UajRZQ3YzWU8vOEpjSmlqbndNNStmbXNybVNu?=
 =?utf-8?B?ZkFuRzRNVmNldXE5YmtFYXoyWHBHNnpSZUxnZ1I2NjlqQWNZSnpqc2FHVHor?=
 =?utf-8?B?NFZnVnNpZ0FGcEZsVmdwVGJZUDc4Sms4SkRaTE9BbEdjU1VQdGpMT2taQk50?=
 =?utf-8?B?S0JFL2g1M2hJY3hBNzhwYjU0WW9pODZMaUJqL1ovQWFxZzRsYndFMkZJTHZ3?=
 =?utf-8?B?MXNQNlNwUFBNVUxnTVZrbGR4aklRa2VpRUVLZTh1UEx4eEI5ZkpRcjV1NWRU?=
 =?utf-8?B?TERlMFVTYno2bFNCUm83SVM0a2pRbERHLzNhSXlsZlFBNlk2UjR5OENUSVJ6?=
 =?utf-8?B?eHdxcmtSc2o5bUVwZzF3S2hRVWlDMzh0NDV4YVR5QUV2Q05lN3pKSVhUQlRp?=
 =?utf-8?B?eFhZQkVaSmZqbmIrRkp4cC9jNC9nVFNvRm5sQ1h0UEF4QThseXFBVmRCd1FB?=
 =?utf-8?B?UmtGTTlVRkxoN1o2ZWFJcjBxa3lJbFhPZXN0KzZFdW1TT3MwemN0aEVEQnpJ?=
 =?utf-8?B?aEFkWDlybmN1SmZrK0lxaXN2TFZsZ05YZ2k0K3FRc3liemg4Q1BTcTlDMTkr?=
 =?utf-8?B?Rm1jbXFlcDNUN2RCYy9mcEhsaUxYcThWaWhBaTZXeHVKVThlb1pncDhzRC8v?=
 =?utf-8?B?UGVXd0t1Z2VNdXlMTVZ5TTZJVHZKMnJSRVNHNHI2MnFaR0tsdXJjRG1ZV1lQ?=
 =?utf-8?B?RXFpTGU0TGQ0cXI1aDNWWkFKb0hTQ1dRQll3eGlyUHpNWCswSlFDcjMxV1Vv?=
 =?utf-8?Q?shoZO++sCB1L+Os4WSHyhElBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132c00ed-13e9-4a4b-f0c4-08dd516adb6b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:55:54.7917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yftUxIL/w1yUpAzEp07NPiVgjWldR3yDYjB3+sBbNTxKh4vvW4bL9t36S6M2aNjJskvuG7jye4TcDZKEGyKC4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
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

On 2025-02-18 15:51, Philip Yang wrote:
>
> On 2025-02-18 11:01, Srinivasan Shanmugam wrote:
>> This commit addresses a circular locking dependency in the
>> svm_range_cpu_invalidate_pagetables function. The function previously
>> held a lock while determining whether to perform an unmap or eviction
>> operation, which could lead to deadlocks.
>>
>> To resolve this issue, a flag named `needs_unmap_or_evict` has been
>> introduced to indicate if an unmap or eviction operation is required.
>> The function now unlocks the `prange` lock before performing the
>> necessary operations, ensuring that the critical section is minimized
>> and preventing circular dependencies.
>>
>> Fixes the below:
>>
>> [  223.418794] ======================================================
>> [  223.418820] WARNING: possible circular locking dependency detected
>> [  223.418845] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
>> [  223.418869] ------------------------------------------------------
>> [  223.418889] kfdtest/3939 is trying to acquire lock:
>> [  223.418906] ffff8957552eae38 (&dqm->lock_hidden){+.+.}-{3:3}, at: evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>> [  223.419302]
>>                 but task is already holding lock:
>> [  223.419303] ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
>> [  223.419447] Console: switching to colour dummy device 80x25
>> [  223.419477] [IGT] amd_basic: executing
>> [  223.419599]
>>                 which lock already depends on the new lock.
>>
>> [  223.419611]
>>                 the existing dependency chain (in reverse order) is:
>> [  223.419621]
>>                 -> #2 (&prange->lock){+.+.}-{3:3}:
>> [  223.419636]        __mutex_lock+0x85/0xe20
>> [  223.419647]        mutex_lock_nested+0x1b/0x30
>> [  223.419656]        svm_range_validate_and_map+0x2f1/0x15b0 [amdgpu]
>> [  223.419954]        svm_range_set_attr+0xe8c/0x1710 [amdgpu]
>> [  223.420236]        svm_ioctl+0x46/0x50 [amdgpu]
>> [  223.420503]        kfd_ioctl_svm+0x50/0x90 [amdgpu]
>> [  223.420763]        kfd_ioctl+0x409/0x6d0 [amdgpu]
>> [  223.421024]        __x64_sys_ioctl+0x95/0xd0
>> [  223.421036]        x64_sys_call+0x1205/0x20d0
>> [  223.421047]        do_syscall_64+0x87/0x140
>> [  223.421056]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  223.421068]
>>                 -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
>> [  223.421084]        __ww_mutex_lock.constprop.0+0xab/0x1560
>> [  223.421095]        ww_mutex_lock+0x2b/0x90
>> [  223.421103]        amdgpu_amdkfd_alloc_gtt_mem+0xcc/0x2b0 [amdgpu]
>> [  223.421361]        add_queue_mes+0x3bc/0x440 [amdgpu]
>> [  223.421623]        unhalt_cpsch+0x1ae/0x240 [amdgpu]
>> [  223.421888]        kgd2kfd_start_sched+0x5e/0xd0 [amdgpu]
>> [  223.422148]        amdgpu_amdkfd_start_sched+0x3d/0x50 [amdgpu]
>> [  223.422414]        amdgpu_gfx_enforce_isolation_handler+0x132/0x270 [amdgpu]
>> [  223.422662]        process_one_work+0x21e/0x680
>> [  223.422673]        worker_thread+0x190/0x330
>> [  223.422682]        kthread+0xe7/0x120
>> [  223.422690]        ret_from_fork+0x3c/0x60
>> [  223.422699]        ret_from_fork_asm+0x1a/0x30
>> [  223.422708]
>
> This hold dqm_lock, then allocate pdd->proc_ctx_bo and map to GPU, it is illegal usage.

Good catch. The problem was introduced by this patch after a suggestion I made in a previous code review, to allocate this buffer in a lazy fashion when the first queue is created.

commit 3e5199134e47745256c3be448ca466d06acaebde
Author: Jesse.zhang@amd.com <Jesse.zhang@amd.com>
Date:   Thu Dec 5 17:41:26 2024 +0800

    drm/amdkfd: pause autosuspend when creating pdd

    When using MES creating a pdd will require talking to the GPU to
    setup the relevant context. The code here forgot to wake up the GPU
    in case it was in suspend, this causes KVM to EFAULT for passthrough
    GPU for example. This issue can be masked if the GPU was woken up by
    other things (e.g. opening the KMS node) first and have not yet gone to sleep.

    v4: do the allocation of proc_ctx_bo in a lazy fashion
    when the first queue is created in a process (Felix)

    Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
    Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>

I guess a better approach is to allocate this buffer somewhere in pqm_create_queue when the first queue of the process is created, rather than when it is added to the MES scheduler. That should be outside the DQM lock. Do it with a condition that applies only when MES is enabled.

Regards,
  Felix


>
> Not sure but seems pdd->proc_ctx_bo/proc_ctx_gpu_addr is only needed by debug mode path, as kfd_dbg_set_mes_debug_mode also allocate proc_ctx_bo, the proc_ctx_bo allocation should remove from add_queue_mes, and move the allocation into kfd_create_process_device_data if this is also needed for non debug_mode path.
>
>>                 -> #0 (&dqm->lock_hidden){+.+.}-{3:3}:
>> [  223.422723]        __lock_acquire+0x16f4/0x2810
>> [  223.422734]        lock_acquire+0xd1/0x300
>> [  223.422742]        __mutex_lock+0x85/0xe20
>> [  223.422751]        mutex_lock_nested+0x1b/0x30
>> [  223.422760]        evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>> [  223.423025]        kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
>> [  223.423285]        kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
>> [  223.423540]        svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
>> [  223.423807]        __mmu_notifier_invalidate_range_start+0x1f5/0x250
>> [  223.423819]        copy_page_range+0x1e94/0x1ea0
>> [  223.423829]        copy_process+0x172f/0x2ad0
>> [  223.423839]        kernel_clone+0x9c/0x3f0
>> [  223.423847]        __do_sys_clone+0x66/0x90
>> [  223.423856]        __x64_sys_clone+0x25/0x30
>> [  223.423864]        x64_sys_call+0x1d7c/0x20d0
>> [  223.423872]        do_syscall_64+0x87/0x140
>> [  223.423880]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  223.423891]
>>                 other info that might help us debug this:
>>
>> [  223.423903] Chain exists of:
>>                   &dqm->lock_hidden --> reservation_ww_class_mutex --> &prange->lock
>>
>> [  223.423926]  Possible unsafe locking scenario:
>>
>> [  223.423935]        CPU0                    CPU1
>> [  223.423942]        ----                    ----
>> [  223.423949]   lock(&prange->lock);
>> [  223.423958]                                lock(reservation_ww_class_mutex);
>> [  223.423970]                                lock(&prange->lock);
>> [  223.423981]   lock(&dqm->lock_hidden);
>> [  223.423990]
>>                  *** DEADLOCK ***
>>
>> [  223.423999] 5 locks held by kfdtest/3939:
>> [  223.424006]  #0: ffffffffb82b4fc0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1387/0x2ad0
>> [  223.424026]  #1: ffff89575eda81b0 (&mm->mmap_lock){++++}-{3:3}, at: copy_process+0x13a8/0x2ad0
>> [  223.424046]  #2: ffff89575edaf3b0 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_process+0x13e4/0x2ad0
>> [  223.424066]  #3: ffffffffb82e76e0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: copy_page_range+0x1cea/0x1ea0
>> [  223.424088]  #4: ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
>> [  223.424365]
>>                 stack backtrace:
>> [  223.424374] CPU: 0 UID: 0 PID: 3939 Comm: kfdtest Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
>> [  223.424392] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> [  223.424401] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PRO WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
>> [  223.424416] Call Trace:
>> [  223.424423]  <TASK>
>> [  223.424430]  dump_stack_lvl+0x9b/0xf0
>> [  223.424441]  dump_stack+0x10/0x20
>> [  223.424449]  print_circular_bug+0x275/0x350
>> [  223.424460]  check_noncircular+0x157/0x170
>> [  223.424469]  ? __bfs+0xfd/0x2c0
>> [  223.424481]  __lock_acquire+0x16f4/0x2810
>> [  223.424490]  ? srso_return_thunk+0x5/0x5f
>> [  223.424505]  lock_acquire+0xd1/0x300
>> [  223.424514]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>> [  223.424783]  __mutex_lock+0x85/0xe20
>> [  223.424792]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>> [  223.425058]  ? srso_return_thunk+0x5/0x5f
>> [  223.425067]  ? mark_held_locks+0x54/0x90
>> [  223.425076]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>> [  223.425339]  ? srso_return_thunk+0x5/0x5f
>> [  223.425350]  mutex_lock_nested+0x1b/0x30
>> [  223.425358]  ? mutex_lock_nested+0x1b/0x30
>> [  223.425367]  evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>> [  223.425631]  kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
>> [  223.425893]  kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
>> [  223.426156]  svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
>> [  223.426423]  ? srso_return_thunk+0x5/0x5f
>> [  223.426436]  __mmu_notifier_invalidate_range_start+0x1f5/0x250
>> [  223.426450]  copy_page_range+0x1e94/0x1ea0
>> [  223.426461]  ? srso_return_thunk+0x5/0x5f
>> [  223.426474]  ? srso_return_thunk+0x5/0x5f
>> [  223.426484]  ? lock_acquire+0xd1/0x300
>> [  223.426494]  ? copy_process+0x1718/0x2ad0
>> [  223.426502]  ? srso_return_thunk+0x5/0x5f
>> [  223.426510]  ? sched_clock_noinstr+0x9/0x10
>> [  223.426519]  ? local_clock_noinstr+0xe/0xc0
>> [  223.426528]  ? copy_process+0x1718/0x2ad0
>> [  223.426537]  ? srso_return_thunk+0x5/0x5f
>> [  223.426550]  copy_process+0x172f/0x2ad0
>> [  223.426569]  kernel_clone+0x9c/0x3f0
>> [  223.426577]  ? __schedule+0x4c9/0x1b00
>> [  223.426586]  ? srso_return_thunk+0x5/0x5f
>> [  223.426594]  ? sched_clock_noinstr+0x9/0x10
>> [  223.426602]  ? srso_return_thunk+0x5/0x5f
>> [  223.426610]  ? local_clock_noinstr+0xe/0xc0
>> [  223.426619]  ? schedule+0x107/0x1a0
>> [  223.426629]  __do_sys_clone+0x66/0x90
>> [  223.426643]  __x64_sys_clone+0x25/0x30
>> [  223.426652]  x64_sys_call+0x1d7c/0x20d0
>> [  223.426661]  do_syscall_64+0x87/0x140
>> [  223.426671]  ? srso_return_thunk+0x5/0x5f
>> [  223.426679]  ? common_nsleep+0x44/0x50
>> [  223.426690]  ? srso_return_thunk+0x5/0x5f
>> [  223.426698]  ? trace_hardirqs_off+0x52/0xd0
>> [  223.426709]  ? srso_return_thunk+0x5/0x5f
>> [  223.426717]  ? syscall_exit_to_user_mode+0xcc/0x200
>> [  223.426727]  ? srso_return_thunk+0x5/0x5f
>> [  223.426736]  ? do_syscall_64+0x93/0x140
>> [  223.426748]  ? srso_return_thunk+0x5/0x5f
>> [  223.426756]  ? up_write+0x1c/0x1e0
>> [  223.426765]  ? srso_return_thunk+0x5/0x5f
>> [  223.426775]  ? srso_return_thunk+0x5/0x5f
>> [  223.426783]  ? trace_hardirqs_off+0x52/0xd0
>> [  223.426792]  ? srso_return_thunk+0x5/0x5f
>> [  223.426800]  ? syscall_exit_to_user_mode+0xcc/0x200
>> [  223.426810]  ? srso_return_thunk+0x5/0x5f
>> [  223.426818]  ? do_syscall_64+0x93/0x140
>> [  223.426826]  ? syscall_exit_to_user_mode+0xcc/0x200
>> [  223.426836]  ? srso_return_thunk+0x5/0x5f
>> [  223.426844]  ? do_syscall_64+0x93/0x140
>> [  223.426853]  ? srso_return_thunk+0x5/0x5f
>> [  223.426861]  ? irqentry_exit+0x6b/0x90
>> [  223.426869]  ? srso_return_thunk+0x5/0x5f
>> [  223.426877]  ? exc_page_fault+0xa7/0x2c0
>> [  223.426888]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  223.426898] RIP: 0033:0x7f46758eab57
>> [  223.426906] Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
>> [  223.426930] RSP: 002b:00007fff5c3e5188 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
>> [  223.426943] RAX: ffffffffffffffda RBX: 00007f4675f8c040 RCX: 00007f46758eab57
>> [  223.426954] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
>> [  223.426965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> [  223.426975] R10: 00007f4675e81a50 R11: 0000000000000246 R12: 0000000000000001
>> [  223.426986] R13: 00007fff5c3e5470 R14: 00007fff5c3e53e0 R15: 00007fff5c3e5410
>> [  223.427004]  </TASK>
>>
>> Fixes: 4683cfecadeb ("drm/amdkfd: deregister svm range")
>> Cc: Philip Yang <Philip.Yang@amd.com>
>> Cc: Alex Sierra <alex.sierra@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index db3034b00dac..a076269cce7f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2574,6 +2574,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>       struct svm_range *prange;
>>       unsigned long start;
>>       unsigned long last;
>> +    bool needs_unmap_or_evict = false;
>>         if (range->event == MMU_NOTIFY_RELEASE)
>>           return true;
>> @@ -2597,14 +2598,21 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>         switch (range->event) {
>>       case MMU_NOTIFY_UNMAP:
>> -        svm_range_unmap_from_cpu(mni->mm, prange, start, last);
>> +        needs_unmap_or_evict = true;
>>           break;
>>       default:
>> -        svm_range_evict(prange, mni->mm, start, last, range->event);
>> +        needs_unmap_or_evict = true;
>>           break;
>>       }
>> -
>>       svm_range_unlock(prange);
>> +
>> +    if (needs_unmap_or_evict) {
>> +        if (range->event == MMU_NOTIFY_UNMAP)
>> +            svm_range_unmap_from_cpu(mni->mm, prange, start, last);
>
> This is incorrect, we should hold prange lock to split prange.
>
> Regards,
>
> Philip
>
>> +        else
>> +            svm_range_evict(prange, mni->mm, start, last, range->event);
>> +    }
>> +
>>       mmput(mni->mm);
>>         return true;
