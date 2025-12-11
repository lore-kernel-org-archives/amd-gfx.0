Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6238FD3E791
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB20710E6DF;
	Thu, 11 Dec 2025 05:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G5jsW3si";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA2610E6DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuylQtXCL6leBr3oI6TDQMeMkQ/S+qQ0+92V2NrVNVK7pUe6MdseJWXjo0k/F+zviA5fGDYUMf7uIPUMZUyKWJxcAvcbajqGr01l5tEkZxIC1xIQndlNkRIS1JuVbmhrBMF30QAiBixUQjnkHJvPUHWFTpCSA0zXypDpUwPSYaRvh9zP+T7PFPzND+60rKl4zZJb9QJnDq6rRf4adZAr9+XSpQibrdkgRRpv6ePuWaJtkJN3Wq+qSRnPquYkwye+6SjeNxlhxduU5yOuMf4/X9IzGU9GZqQUumilK+97p1FqzvUzZgTmdPZbF5ytiL6seVIt7kIto/+rQKJnj9U40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EldWNcPB4kpdRg8Po6735FjvjfKUiDzxEDOLz8C23FM=;
 b=XUtrn3NOOvdVguPnQlvukR5bpvxmDQNHGYAq9YSZK/k14Ne/s065vPeLjK98CmW/RFp9eV4oxlPWdJ/aiQb6RoDF2BVLxQgqUYP6wdPFccfEzV60FgOiu3/XYldjF44hxh7zxlzkJx0RkPfc7c8aPk+n16+Ec0+IaSIRmpO2D0AR4r3UYBFGQJQbhVaIVY6oIObqkNQUWnMk5OpLFr4CcA1ImW1X3uA0T8++1JN+s6E3fs5RUKAoAgJZePv73cZWcOxgIc5hfCWp0AkfN9qmF4zx59T+ehPw3J3h5xmey3vKDA6Qs1r7XCA1U3R8+QYi/1ComHYfSgPSjTNtaO9wJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EldWNcPB4kpdRg8Po6735FjvjfKUiDzxEDOLz8C23FM=;
 b=G5jsW3si/9+f0YslqGqE1V9q9j3OL6lSM8uq41Y7opy8tji5Bi6aK69npQ9re0ZapfBonp4NpUVOvHXyPgAUlozMMy7qNpWLszWAL2KjJJ7f17I91+OaPGw0M7nNixmJPdp4PDGKBiM5ZZqzs13W6OKZrUQRxJmIAOadsTS36UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN0PR12MB6344.namprd12.prod.outlook.com (2603:10b6:208:3d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 05:03:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:03:59 +0000
Message-ID: <adf41aa5-3172-4e9e-9bfc-c8b853b7c0c0@amd.com>
Date: Thu, 11 Dec 2025 10:33:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: SRINIVASAN.SHANMUGAM@amd.com, vitaly.prosyak@amd.com,
 christian.koenig@amd.com, Matthew Brost <matthew.brost@intel.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251210202347.63243-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN0PR12MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e7f753-c985-48d3-30a5-08de3872b164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFhQclIwakNvNi9VQStPa01tSmxaYmxxd09HcTZqWTdObnBaMWV4NnRQdXAz?=
 =?utf-8?B?Z000VWVZcWVoT1kxLzlPbTZZdDVubmZGblRsK0g4N0hCbnRkdUszd0ZTWHUw?=
 =?utf-8?B?WFlHdU0vR0JRR1RPbWYvZjI0UDFCZXZzbC9Hb1FwZ3hQWHNXemFGc2ZvOVZC?=
 =?utf-8?B?b2NpY0lTL09ZQUF3UmxnVkVySDRkVmR1c3ljcE5VNTc5RCtoaHllWW9OUHhG?=
 =?utf-8?B?ZUcrYnFnZXFwRmxEUUM1Q2plS2dmTnRPalFwcFFPTGhaMWdjSHZlWFhYYzB3?=
 =?utf-8?B?M0w2OWNHMnYzcy94V1BGNmdaWGxxU01ZdSttVFJLYU1rU0RrSnlBRXRFck4v?=
 =?utf-8?B?cTVFR3FqTzA3bmNONmFGdlRuNlE0WmtESTcvLzVuekNIZjlLSjFqejR3STBE?=
 =?utf-8?B?VFpDeFdqYWduNWlNSXZ6ejZaVzhmV0tpWjQydHFhcjkrU3RvLzVDV0wxalYz?=
 =?utf-8?B?RW1vM3c3ZG9OWkVQQlNhMGl3SFhwYlpydlJYRElKdE5seUkwVC9KbTl3bms3?=
 =?utf-8?B?OThrbnNCK3Zqc2ZucFUwdDVUSTYrWWhlQUJLVEZTKzFpZTRsNGdUM05Ccmd2?=
 =?utf-8?B?eHNyTHdaYzRoejB6eHNRNkpLSGhMaGVadnNRK08xcEJ1WWJlVVkydXNVUWhK?=
 =?utf-8?B?QXk3a2JiY1NVeS9xdHJWVzJXQmJDWmpTcjkzUU9ud3F0bGFMeFlnRFRWa3R0?=
 =?utf-8?B?TlN0S1NLeklsQzd4dDIzazhCMXF0V0Rsc3BZcnJmM3ZDN0tlUXloMnhZdEo1?=
 =?utf-8?B?YXFIMnhaSlNmNzRjQ0tWQmE0a2xvenU0bUUwWm8rckhic0J2bDkwdjZQSmNN?=
 =?utf-8?B?bjY0Yi8vQlc1cHJSMWUvREFDWHQ5Q3JITFY3UlE2OFB3bUMxT0dGY2ljNFBR?=
 =?utf-8?B?bHJTd2FlT3puWkcyeXlINHVsSElmUVZHNDFFR3RDa2xQL2F6ZEZhaGJjTkNL?=
 =?utf-8?B?THBUNElSTXc1MjNISENEN3VSc1ZsWXUxVFVxOTh0aTM4UW5tL2hOMjRvcjFv?=
 =?utf-8?B?c0t2TlVhS2Z5aEVUc1pIQWxCZll5SVVNaVdtcGJ2dkRwQjR1NTVPL0lOclBH?=
 =?utf-8?B?QlB4TU8zY0ZGaWl5VG9HNHNTcGN6WDVGRGxxYWsvU0hVbXNwWnhZWFRzeDRq?=
 =?utf-8?B?ZkxUblMyek1oMzVGVFNWTWgvSmZLaVJIZ2lteDFKa2d4SDhwdHJDWldNbzVN?=
 =?utf-8?B?NGZYdmlWcGdnamRQbzFYalkxM25CNFhpMXpSUzJhUElWT0ZSUy9SdTV6cmg2?=
 =?utf-8?B?TVRrWDZSL05yd0RQN3BSNms2N1RIbUdnVmVXRWR3Mm96YllIQUFkTTc1NFhq?=
 =?utf-8?B?Y2JZSHkvcUx0bFdFYVhoa0VicklMNHd4RnNjVnVkbFNuTXczY3N5NXlWdUs4?=
 =?utf-8?B?WUZrN1M3TFBhSnIwYStuV2RZUzhvMmZyVGg3RFNQTTh1RXFBaWJFVS9NbndI?=
 =?utf-8?B?SlVhZVp2TUMxN3Z2TjV3a0MyM040VFRVNE4xb21NcXNqYVNIQjMyeU52Y2pa?=
 =?utf-8?B?TDJEdno1T2s0c1lJeWZNOWZ6dThPMlhCWGNzcXBaajBPa25mQUJpb0l4T3ph?=
 =?utf-8?B?NFQ4YWtKR3Z3N01KTlN5dlY0U1o0aENMMlhreGsxUklLb0Y3U055ZnlyQjVk?=
 =?utf-8?B?bnlPM002cnlORXJBazBrVzhsMWc2QVJTeVNGU3ZKMzVnb1V5dFBpaFBFRUpj?=
 =?utf-8?B?bEVxR1hCcll0QVhzeEtzZkFIQzhGazdqVWlmMk1xdkpZaHQrdThBbnNCVHcv?=
 =?utf-8?B?c1BsN255Zk5KaWJTNWhla09HV1RUMkwzRitIMXFXTHlLQnhHd2lIOWo1d2dT?=
 =?utf-8?B?bGkzSE5xSmxnVXRuQ283UVNEL0RzUUpGU1JrNE9nWDB3VGFMOTNvVGp4VUhv?=
 =?utf-8?B?NmZ6b0tyYXVhNGxFUVRISEpwQnRlN2JXd0NsUEV5dXZlRmgxTnZxeHBEbXVK?=
 =?utf-8?Q?EaahXR72Jf8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzROZko5MklWT1lwV29sSnFUMm5aa3pRMFh4THdJUlFWWDA0aXVLd0hCZkhS?=
 =?utf-8?B?Z0syNFMyQzhORHY5UjJOSmxBSUhGelNLWUpXaUZ6MDRsRXpXUy9pcTdPRllE?=
 =?utf-8?B?Z0tySjJ4QnRYME9EaUNBMysxYlVQYXVQc09BaGFRVllxdlZNQ1g2c3V2NTNZ?=
 =?utf-8?B?emhzWGYwS2UwTGd6L2srV3gyMFpxcVdSa2NwRFJxNnFHYXMvV29GSFM5UU5a?=
 =?utf-8?B?V050UExheHhlRkRmcWsxY2lLR1RUZSsyTFQ2ckl0UUR4U2YrTG5RNGtTSkxO?=
 =?utf-8?B?Q3kzc2xORGt1QjU2Y2huTmhBQ0pFK3huMmYzWi9NR1lIM1BEME12aVVKMmVD?=
 =?utf-8?B?dWJHcG5OZlpRZ2hXZDFDVTc1RXFsRnhoTmk0ZWI5YWE2WW5wcmpRSzhBUUVW?=
 =?utf-8?B?TnoxU0JWSnljendwRjVlODNRY3g5elBKZmUyeml4SjFKNUJGeGlBWWVWbUpq?=
 =?utf-8?B?Q05lWk5LYXZZb3k4anFtak5oQzBHaWMxaWlYUzE0OWJQSjVQMUtKc2pVVFpK?=
 =?utf-8?B?OU4wdENzcFlsVGFPZ0tEWGxMdlVyNDB1Y2tYbEdQZGJOb1RCN1gyOThCNTFP?=
 =?utf-8?B?YkNHM0MveGZrZldGYW9HMm8rZlN4ZkZSTTNNM3pMYmdUdDAyMTkwUXl5d2kx?=
 =?utf-8?B?Qzl1N1ZvM2dmUVpmUjVVbTFsWnlYekh6YVBCYlQ4YjVpYU1sUDdzeUVUWjBB?=
 =?utf-8?B?QU4zTllUQ3lheXNXRm1TWXpsZEd5WG95YUgwaGgvWm92aVhJZHFZWnd1T2t4?=
 =?utf-8?B?c1N6eHFoMnFYVkc4cm1rdnN6RUplYWhJQk5DZDRTM2loMGVCOStIUW9EU1FZ?=
 =?utf-8?B?MTdDaTZWVTlmT292c3MwSTRNbnFCWmZGYlNhQUNlWDdnbXhPdjA4VCtQRTJs?=
 =?utf-8?B?QlB3a3Fmdm5zdHhrMlJvNVd0THo0WnpKSDBNOFgxT0RNaWwxSjhsVkVmRVM2?=
 =?utf-8?B?WnNyOWJOMVNJNEhINjVpK1ZYc1Jqci9YSmJham5QTE8zVHdHSVdBTzh6SVU5?=
 =?utf-8?B?V3ZJM3ZmQUtGOFNLVlFtTWVnNTU1SFVVVDFpYVBGR2NFVWRTbG1oTEFlZzZF?=
 =?utf-8?B?dmpLUDdoYlRiTHZpRDlFR3pvSG5iRFdka0w4d2lZWWJka0xnWUYwdGxKZFM1?=
 =?utf-8?B?OUdnSXZqeklBdlRxaVBQUmFhU1QzN3pFcS9KNVVZTE5OZU9aVDBRaEF0T0hS?=
 =?utf-8?B?OEdqWFlKSndpUU1WanFNekpuTWsxSzljakRqL2poa3YrdHlXVjk2L2xnOENr?=
 =?utf-8?B?UUJLQTJWa2wxbWI3OEtQWSs3TE9uN29GZnFoQlp6aWdKM1dIV05mb0NIK0tv?=
 =?utf-8?B?QmpVS29WM0pFWE9FTzNyblZDT3VaeVNkZGVneDhwdDlDbUJGVFFEaXA4OHBx?=
 =?utf-8?B?eHhBcW1mQllMcTZVTzBiRDZzMllTMk95WVU2V21OQnd0TkV2RmUrd05nSWxS?=
 =?utf-8?B?UDJtdytZd2dteHBhQi9zaGxJdkpLWFpwRzcxWUxQa1MvWVorU1BIb3V0US9K?=
 =?utf-8?B?Q0ZjRkVaSm1TazdIRVJQeXNEOTVJeTBuYU5STk8zbVRRSGRENlkrWjl4SDVH?=
 =?utf-8?B?Uk5HOW1LQ1ZSdFNzWFJxSzR1d3luclF0R08zZ05PL09yRGozV3M5NHJ1UFVz?=
 =?utf-8?B?TXVZYmk5Um9zTHpEQitnSGpaYUkyZzhoWmZJZkQya1RQOGwyazJ0eGQ4aEl3?=
 =?utf-8?B?R3I4TFh4Nms1aGRQQzdMWWZOQnc2OUNuVTdON2lWVUJxaDl0ekJWT0JvTmRE?=
 =?utf-8?B?Y3F3MjFReDZDWWRVaUxQRjlBYzdyaHNIMnpFbXQxT0tVNDIzUVpBbGR5dDBY?=
 =?utf-8?B?UENnSWFPcDVxZnpuS3MyYWpNWUNVQ0NDMEt5QXhlNElmK2hzSWc1L2E1Smcx?=
 =?utf-8?B?RTVUQXY0UnYzZUFlRGkrdmxZRndlai9zL09OKzd4UHpWdVM3VzdwTUxFKzlz?=
 =?utf-8?B?b3drQnloZHR3ek1ZL1pyL2M0TnpOcFkxRkZwbm4zQ0diRW92RkFPclBiUnRh?=
 =?utf-8?B?Nks2Rkdkak5aM2lueGxDZTZDUERBbWptelBMOWRaWGxQcHBIdHd5bTVDcnBK?=
 =?utf-8?B?M01NT1BtSTVnb1oxd0drcWZxTFFsaS9BQStWSzkwQ0FNRnJkQ3VxSU8wMzBI?=
 =?utf-8?Q?PWnv0pYp0u5YiqXgu2XumRzxX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e7f753-c985-48d3-30a5-08de3872b164
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:03:59.0509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJW3DFDOmYguBa286onl9fyDJeHV2VNoH6vMSB9eo7VRo7l9AG3JSlRojMfggiu3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6344
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



On 12/11/2025 1:53 AM, Alex Deucher wrote:
> Avoid a possible UAF in GPU recovery due to a race between
> the sched timeout callback and the tdr work queue.
> 
> The gpu recovery function calls drm_sched_stop() and
> later drm_sched_start().  drm_sched_start() restarts
> the tdr queue which will eventually free the job.  If
> the tdr queue frees the job before time out callback
> completes, the job will be freed and we'll get a UAF
> when accessing the pasid.  Cache it early to avoid the
> UAF.
> 
> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
> Cc: SRINIVASAN.SHANMUGAM@amd.com
> Cc: vitaly.prosyak@amd.com
> Cc: christian.koenig@amd.com
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> v2: Check the pasid rather than job (Lijo)
>      Add fixes tag (Christian)
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8a851d7548c00..c6b1dd95c401d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	struct amdgpu_hive_info *hive = NULL;
>   	int r = 0;
>   	bool need_emergency_restart = false;
> +	/* save the pasid here as the job may be freed before the end of the reset */
> +	int pasid = job ? job->pasid : -EINVAL;
>   
>   	/*
>   	 * If it reaches here because of hang/timeout and a RAS error is
> @@ -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	if (!r) {
>   		struct amdgpu_task_info *ti = NULL;
>   
> -		if (job)
> -			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
> +		/*
> +		 * The job may already be freed at this point via the sched tdr workqueue so
> +		 * use the cached pasid.
> +		 */

amdgpu_device_gpu_recover() is run in tdr workqueue.

Now if this is the case, someone has to explain the logic  -

Timeout is triggered here -
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/scheduler/sched_main.c#L559

This calls amdgpu_job_timedout() -> amdgpu_device_gpu_recover()

After that, there is this access to the job -

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/scheduler/sched_main.c#L566

At least, in some condition, job is not expected to be freed. Then I'm 
not sure if this is the right fix.

Thanks,
Lijo

> +		if (pasid >= 0)
> +			ti = amdgpu_vm_get_task_info_pasid(adev, pasid);
>   
>   		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE,
>   				     ti ? &ti->task : NULL);

