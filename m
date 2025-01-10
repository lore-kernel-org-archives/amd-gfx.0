Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68BDE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 06:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7842710EFD9;
	Fri, 10 Jan 2025 06:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVaaZAEs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4355F10EFD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 06:39:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYdhf4GzNBuwgfys65rZM454TbJz93+zubaAd/Rkj7KKNNHfu1KJeVYlKPp5iGDjWkPHsLJ5R9veKo2ACOLXJBUJHZSizcDM94VljRsFO5YmdKsiqtkVB2w+u3AB1+qwSK6pxSQKRCHE39DNlpo4zlY4Gw4dsMlt6tYC2hp0LKrB7L7dkF5WEh1i0Hy12zm1W+t7+oAQwg+BviuUKBAi1xiZ7D5R/DS0swdf1q4F0K316eRCLBDSMpS7+ewLDdbYGIdkdRjYFUAkoed+/VxJOJR+1KCsvqabh8wFm5+xwONuLJfxWIdwOeTGi89wzRmom+rH+GuDwYtqfSfK0O301A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J7Ksln3ZhzRzDLntWuhuGcMy/vGmAR9EeN4ryKvax8=;
 b=wp9kGSUPeCwweFvf9V9qhiKOMG3kZkhpDlQjpxTOdW4S0BBUKUaSL0jfPIKognuUSLQA80f2EUkck/8a1dezWJxyfFiEFREPZDWY1y/bzq+1F64VGRhsc/lq3JCyZ36U6qD4Iw7+WZG3V3tsWLiwSYk1punQNuKjOGhVEBrCtMYMAxIBaXyDByuBqCzn6Vefbxg6dO+rKx7I04vcfCUDFSvZlbNHRGedUzMCguRMprwcVp49RkhCrTGA6mJUy+rb7L8YGYytWm8pqrf7gHFTli6ZLB8A2du2Mw5+RtBML//mtATGJCCt8Duuh+35ZMYJMmvhaErbRul8ZCx7X2BOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J7Ksln3ZhzRzDLntWuhuGcMy/vGmAR9EeN4ryKvax8=;
 b=BVaaZAEsPuTb9qS/nqQ1vu+7+aB/xYslbh4Cs2UNvaHt9+DoVCa5lRCJF+BZRQXXkjZOlcUvQBiAvzmEhRk382eGCWD8aknxYqDU6bO0lMmJ0hyDQcfKgfqQTnHr4BylQt9SsvOLsyGcUh4N+jzb4MU9c5uP1xttkmXkdhjBvq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Fri, 10 Jan
 2025 06:39:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 06:39:00 +0000
Message-ID: <f0ca8ded-731d-4a6d-81e1-cc81d3b8bbd4@amd.com>
Date: Fri, 10 Jan 2025 07:38:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add mutex locking to VMID Manager
 Initialization for Process Isolation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250110033857.3034258-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250110033857.3034258-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: f4285b8f-2d75-4e2f-6e25-08dd31417772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjFpeTQvYXdMVUxOc0pxdW9YSk9aZFJycXlXVGkyZkwwb1hxR3YrZVZDRWkw?=
 =?utf-8?B?V3VTSXlHeVNESlZyNUdOcm5MajhrbEVtZFlxVmZHSHBNMzhSRy9ERlp5dkRk?=
 =?utf-8?B?Z3lIaHlEQjk5YnMxc0lxTSsvRTRHZE1MV045amRoS2ZOZGtKbGZwMEVVRDlh?=
 =?utf-8?B?L3JwaTlRb0FDK1d2bXlUVkpLck9sTWlMTGFmRFF6ZlNMY0NhVGlaM1gxOFlK?=
 =?utf-8?B?aHNJRDd0MjhWcUFBWmF6YlYwWFJVdHNvbXVtT3ViL0lXZ1dpNVpPY0QvOVN2?=
 =?utf-8?B?MEprb2trT1J2WG5OYWdhRTNJSWE3WWJhUStGVENTWVdOTkxwVHQ4YmdJZ01t?=
 =?utf-8?B?em1Yd3ZNWUppeERXZ0w1dXRCUzM5dGJ3QUdYRnFBQVBKOHBjV1dBY1BIKzM2?=
 =?utf-8?B?eVBuK3FKSVozbm9JV1V0eTUzOEdiLzZoUXZlS0ZHeE9kQlh5c05QODRMRHdN?=
 =?utf-8?B?UDU2dWxZK3VlaHh0WWdNOEJjTmpPOTd6eUh0elJIWDhyVEZGS3NaZlpZTzNu?=
 =?utf-8?B?eGVrN2QybGRHbUpJaUdzK3M0UzRoc1BVaVJjZVIvdFhiTkdmSnFuTjZaUnBB?=
 =?utf-8?B?UW95dk1uTmNoVjk4VnF2dE52OCt3SlpZemUxQ1BCQkRITEx0T2YzL2F4bjJz?=
 =?utf-8?B?d3liQk02VFk2L01vbXNzZkJ1c0liT1doeDh0Q0RrVUVUUHcrNG9rdmRKeEpv?=
 =?utf-8?B?N2FUNit3cWE0Y2xMTm4xeXhiOU1USXpTTjZiVjdvcGVWVkNMeFRWczk1cDIx?=
 =?utf-8?B?UTFGQlZvOUNkOTlyT1ZmcjFqK3hrMlhMeHptcmlpbnZhOUtFdmpMSUxDLzNL?=
 =?utf-8?B?Z2o3ZTd3bFpDOTZydXZFcWRYSVF0eVlJcWh6czkwR01kYkI2bDhTK1M0U1NP?=
 =?utf-8?B?TDh0ZlFvNzJUOHZSZlhBN1lWWGI4U0ZLNnZjOVNwbWhOYnVMeVpRSmxXSmps?=
 =?utf-8?B?eGdFTDJ4NzBtTFI1L3JQK0pnMVg0Nk5SMWNkUTIvLzhMVmV1bkhhQnI2K3BU?=
 =?utf-8?B?TndIN1V3alFLa0xDQVZrVG9kZnp0MEhvandmUDVSTjJQaithZ0twdkhCYzEz?=
 =?utf-8?B?c05WV3lEYXFKeHh3NTk0WnhGYkVxbUU5WnpRYXJYTS9FNCtLY1R0cnVKYWxH?=
 =?utf-8?B?YkkvNEJOdlk3a1R6UzVIMDZEeGxYOExvYTQwN1hteXR5MnBpeGlBbngzNS9n?=
 =?utf-8?B?Q01SNE1EY0JyOWZ0SUdqUDVNb2Jja1NJc20wekNBOTErbEFhSUdVNEM4V2hU?=
 =?utf-8?B?VEhjWVo2WjdsdWU0WDlQdktnQ2ZZZDNZdm1wTnorY2hEZ2VrU2loaUg4VlNK?=
 =?utf-8?B?V1hpZUFHSHdkNE11a2hKQnl3M2F1dWVKZEptVkR1QS8vWVhvWk91Rm9lYzdo?=
 =?utf-8?B?bWR3SzhoYlpTeW5ZUWF5L3pkdDlZQkpsYWkxYXp2a0FMK2tEWGZvMFhLMXM1?=
 =?utf-8?B?aEJ3ZUNnSHhGNHhIQnRadVhlYS81MWllYnJaWGxteUV1eVMxaXpUeEo2bFBK?=
 =?utf-8?B?VXhnWmJnWVlWcWZkank1N24rM3NPeHhpc3B0L0NQWlpSNDhPMWoyUmNqRVdk?=
 =?utf-8?B?aldlKzF1YTVYYXczS1grUUdzYTE1NEtjVDhwN2VtYXpkNk5ZWnVOSmNBeWd4?=
 =?utf-8?B?ZEJzRjVGeU12V1JmLzNNN2EyL1pDN3BvY29EU3pPWllKZFh3S0Q5UDFjbll3?=
 =?utf-8?B?WERiZDNpR3A3UDd4ZXRveEgwOEg1QUFlNTZMcXQ5a2hWVTFOTkMyZU01WTlN?=
 =?utf-8?B?RVU2OW1GMGQ0bGEwWFY0OTQ2dngrVkxJei92UFpFU09nUHlObXFjeitDYVZS?=
 =?utf-8?B?dDhGTzFBeUp6Sk1UT2ZMT1hpMWR0bkMySHNsalloY1N5YVAyaFZmKzY4a2RI?=
 =?utf-8?Q?Yj+98MJy0uk8C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZiM0lqT0plNjN1c0xrYVpKZ0NTbnYwaWpGK3MwTlI1ZHFaTGNOek9ibGlv?=
 =?utf-8?B?R1IrdzhPVEE3QmRkcXV2UUhPVDEwbHBxYkRPRk5VWktDZnZaaEl6aE12cHRj?=
 =?utf-8?B?MkVTRGlzeG1LSnR5RmJPWVlCVmo5cWdRZXBSdXhQamh3MUt0ZVhEQ2M1ZHNR?=
 =?utf-8?B?TFZIaHkyK1BUUFcxLzV3YTVRZjFXcmdiNDBPTlFBNzZTOVl2SWoxNTFrMG1t?=
 =?utf-8?B?V0RDbW9QeHhqb2h4VUZvLzlIcWdYVXp3TzlGTU9KU1c2SFU3QlhsSm9nRVJx?=
 =?utf-8?B?M1pnQnZmSHFGTnMyczROTTFTNU8zQ1ZQOVRBbE1jcFp0dDZCTHF6N0lpYnRC?=
 =?utf-8?B?Z0pJY3k1VzlnSi9wcEFXNDBYd3RDb3ptZXR1V1JQckNjUnY1SFByZUorMWNW?=
 =?utf-8?B?N1FRUjIzaENMWUprUmhSbjBoQzYyZlNSeFBEUWdEVjQxSG1NNzE5SFdFanBk?=
 =?utf-8?B?ZUdnVEwyVFU5bytzSDBLOXFHVUlzNE1oZFVYT0FMMkNGWEdhZTgzcWMyWTBP?=
 =?utf-8?B?S1l6UUtLSUt6VmJKdlVFdC9IaDhMamY0TGtTMndpV0VSdUFqcXp0OUVtYm9M?=
 =?utf-8?B?dlZqREYxN05XdEIvUFpNRFd1WXhRNHpkQUhXVkM0ZUFhaDJOZ1M0NFlneHU3?=
 =?utf-8?B?TTdUQUVVUkFwc21Kd0hvb0FIUDdTK0lGR3ByNVdXc1pqTStTazloc0VHQUhr?=
 =?utf-8?B?MkJ4cWJVUFdPNDVYRFdtMFE2aVhwSmF6eHEwZFExdWRoYUc0RHJtQS9La3FE?=
 =?utf-8?B?UkFoS2J5YUZnRGpmSTJ6R0JIRDBVRzZOSlE4ZVQzN3pxWnVHdlFRcUpGajFh?=
 =?utf-8?B?cXRVYVdqN3RSRlQ3eTFzSmRGeU9zZ3VralFoU01IQTNkRGVvQ3J6Wm4xQnlq?=
 =?utf-8?B?Vys0K2Y0cTNjUHRPaHd2UktjVzN1RVlHcitmT21QWlRWeDdpRFkvU2tISk9I?=
 =?utf-8?B?a1dUajBxUXNFZ2o5RWp3YWFXVjJ0Mi9DVXI5d0JvbEN1WHV0QVoyZ1YvUzha?=
 =?utf-8?B?bmZic2llVEVuRTdXUXlsRXk3L3B4dkMyUE1uTXQ2NGRscUhMTVFSMmw4NXY1?=
 =?utf-8?B?MWs3bHFVR0NXQm1RK2wvUzhaR2g0Rkd0R09YY3dBcXlJUnA3R1BZd25Va0Nw?=
 =?utf-8?B?QWFHTFhwUHp3dDBiS0t0Rm96V0k0Z3NYamNiTWMwVUkxQmZOOWNOamN1d0c4?=
 =?utf-8?B?ckNMcjNxOGQzUkJPU3Zqa3g0elZmT1IwNHBQLzV5VXd1WnBnVGNNS1B1eW5n?=
 =?utf-8?B?MldaVzgwY3hySndQQWZNYzc5NnJtcDhSekwyaUVLRUpENVoyWStlaFoycHla?=
 =?utf-8?B?NWpzU0JJR0p2eVFpZVZNRVVER2dxQ0xzV1R2bUxpempXQnAvS2ZBa1gvUUZi?=
 =?utf-8?B?d1NJVWJQUk5IbVpMNmU2NS9aMVVON1BOMC9vK2pxdkg0OEY1MkFTQ05ZT1B1?=
 =?utf-8?B?aDkyR2xHNW05QmdKbng0RWVlYXY0OFZ5b0dHLzZodExBaHdXMkkvZVhpNWg5?=
 =?utf-8?B?bGo1dllvZVpPMWRrdUF2bGZ3dkxaY3MrdkRKMVl0N2RHb2dKZ1BrbkxSZWtS?=
 =?utf-8?B?TmFmelA2YnpEUGs4UTdTcjFkQ3lrdnFWczRUUU1xMVR3OGZYa09WV3h4MWRt?=
 =?utf-8?B?RXlOcUxLVlRkZ005cS9ydkFkRllranZaMzhZd0dkeFVuWCs3ZXhFdXVRMnl4?=
 =?utf-8?B?NU15Y0kzSUFydnltQkFQOXFhWjFvM2syVGM5ODlZY1hjNzAzemhYdjFYZWxS?=
 =?utf-8?B?Q3FzcytJUUNicGlWNlg5WFlGMVRCVWVFR0dpVEhqTzUvcGNpQzg3bGwwcG14?=
 =?utf-8?B?S2ZSMXJ6Sjh2UTZDZGdVMHZsTkU3SllvelJJeWlOeGRLK1RZNjhnMVJTckpZ?=
 =?utf-8?B?U2VscktEY2ltalZyUHluU3NtKytpV2JkbUkrWG80NFNySlI3T1hhY0w3US93?=
 =?utf-8?B?UTQzbVhCeHFLWEluQktPZm13bjEybnZML2xLQjdVQVpGVnE5VmJQbCs1NFor?=
 =?utf-8?B?N29NY3RQays2eUFrWWdsV0VNaVJ5Yll1L1V1SmRYTWwxaGZsbWplSklTSjUy?=
 =?utf-8?B?dmdORmVJeHBkUjFwOXZQRkxGeEJNbjkraTc4VWJSeTM3dXh0dTFJVi9SYUEv?=
 =?utf-8?Q?QGlB1Ndca3wa5sy5/+dBc0TRQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4285b8f-2d75-4e2f-6e25-08dd31417772
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:39:00.5570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xu9E3LvMkcYUejcn6GVauvcpOWSsVDHS2Plh8+Y85Wp/0ugkr4gdlrqCPwIY6Ur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
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

Am 10.01.25 um 04:38 schrieb Srinivasan Shanmugam:
> This commit adds mutex locking to the `amdgpu_vmid_mgr_init` function.
> By acquiring and releasing the `enforce_isolation_mutex`, so that it now
> safely allocates reserved VMIDs, which is important for enforcing
> isolation between different GPU processes.
>
> Mutex ensures that the process of allocating VMIDs is done
> correctly and without interference

That is unnecessary.

The VMID mgr is only initialized during driver load and at that moment 
the enforce isolation setting should be static.

Regards,
Christian.

>
> Fixes: 96595204195d ("drm/amdgpu: Make enforce_isolation setting per GPU")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 8e712a11aba5..6ae835a7f031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -602,10 +602,12 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>   		}
>   	}
>   	/* alloc a default reserved vmid to enforce isolation */
> +	mutex_lock(&adev->enforce_isolation_mutex);
>   	for (i = 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); i++) {
>   		if (adev->enforce_isolation[i])
>   			amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i));
>   	}
> +	mutex_unlock(&adev->enforce_isolation_mutex);
>   }
>   
>   /**

