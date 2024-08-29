Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF24CA0EC4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 21:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28C510E782;
	Thu, 29 Aug 2024 21:15:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mC144Vxo";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D156510E77D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 21:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbJPmSKQUEpUrUJYbpmXfImOtPYeKKLFqe9Qq17IlxB6QPyrBkCDEwuv14PBrwdYN5p6LPm35lP1CC4yIiWZJSVPJs9AKBFEkJwN0kGtnhvDKOz6Qe9RjXHmoXHz0rgEFGvefbwVysrTpqEil2DxwWvL5Y5On0wx2i4si8tCnj3BKxd0hB1L0zYJ4iWPUCQP7vl0TbksqDwWymYAClHkfqHe3pHN6saiiCObFDAZhCl1tlWGWGDoz/0HrVNXzo2aNu0FnoXOF6RObyJ/eytCuKsWT+PXbu14zNyyNIa3nJ6d8kjtmXTgu+4fQIZbu/b+D/AAjwMGXQLucRY0KeyAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3ZaExzWkSVflxDQaZpO24VEG5uRT3jOFXfhdX2wav4=;
 b=pAx5gVmS1U4smnaodn0p1N1Deo/i1QBXO3ElE7fAOYoIz/3xF3aNneEZXikcbHSsGfb8dPFP14xeXZphqDlmSjsArQe7dGgFB5u91S0rG4vGm/4q4G6UV+QgpiKusahGNToLo7oigP3b3meG/o4/zd3zgY4jV256QEu9gCZv2Z9KocbUDFb0O+e7+AWXfP/FlwXR1xZId8YMXfHutZ3VH47e5mfQKQS04UzNpXOzgKi3g52YxADBaBdAP4roc+l6KWvbIw1C6kN4NjjZIesl9AvbYhn4X4LtYNfEt6itb5JOgobeYaTkYR8ELCvC3h9/6uEXVDUrdoPh2vhpYoX/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3ZaExzWkSVflxDQaZpO24VEG5uRT3jOFXfhdX2wav4=;
 b=mC144VxoCwTTwx8n21LpWnCjL0WkLGz8Ua4Sg7LxKO+pToG3+2KdQszHa9/4xAkXEt0orWMVtL1vXnpVoSudHb2DvnS1PtE+eepSjm6ZvwRG7COJzgOv8BikvhSY9vL1IQOs8TNwoW4xL/HzAvq+4nBjTZTXuH4Ct/p76q0Z3jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 21:15:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:06 +0000
Message-ID: <1376d3e2-f978-418d-9aee-c8282565d236@amd.com>
Date: Thu, 29 Aug 2024 17:15:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: restore_process_worker race with GPU reset
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com
References: <20240823194901.25068-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240823194901.25068-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0ca0d5-46ec-481f-c6bd-08dcc86fa7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1BmS044TWRVeXhmUG8xTmFHbjhHZzAzSmZGdjBOZWgxMEFkeWszOVlUZHFI?=
 =?utf-8?B?VWJ3c1FEY1BRMFlGU01BZWUyUUFOYVU0YjI0cXcwYm1mUTlMSDJZRUdDSW5N?=
 =?utf-8?B?SEhwTDNvRFBHTDRWdk5xdmV6SVR6T1kzOUYvTER2Uzg0bDhabHRXRnJKcXYz?=
 =?utf-8?B?MDB3VmxvUFRDZHJqemlRRjBUQ2FyaGw5YW1Pd0k4Ylc1ZXMvbXgvNkE0MmpB?=
 =?utf-8?B?aVNPWmROOFN4ZDZTRHh0Uk1jSWVBUDhsM2dhS0JjNFl6WnkxUnNTVExlOEVG?=
 =?utf-8?B?bkVaNzVXUkY3OTk3ZUVSQ0cwUHhUSDNOTjYrZlYwdTJhSWZmSHJYaGY0TENh?=
 =?utf-8?B?U1Y2Y0N5ZUY2VnJPczdSc2QyRmdrUWY5VFFBa1FoYklmZkZXSm9ySWJ5SzJV?=
 =?utf-8?B?RGFQTW5VaXU1Z0NvTHovRlBaY1EyUzc2TE1GZGtZVWI0VlRBRWF4Y2VXOVRp?=
 =?utf-8?B?NXd0S1NKNGk4eG5MOERIUjNjeHBIL0FpR0xOSkgrOFdoV01vVFlwMklGbUM5?=
 =?utf-8?B?REZYbGdXb0pyelpUaE0rNkY5L3pzTjdjWVlFVVBLWWMrY0ZnOEZubjZFTW9J?=
 =?utf-8?B?cmZDSDFkV1ZkWFk0SG95Yzh4UjNZM1E3aFVFbWd2RmNyekdBeW1DVnVTcEdq?=
 =?utf-8?B?SVk0a01YTWh0U0lvVGZJVWR5SmNtaWtpc1FUNWNNZ1Y5QUxSNWduRndXZ1BT?=
 =?utf-8?B?TlcybEdnL0M2UEpwV3JmVjZ5a0VmK0JwY2xPOHZHVENhM0ROdFBVOVFmOE42?=
 =?utf-8?B?cE1tL04zNExDQXdpS1VVSG1Sc0lhNnovMU1abUk1TktoQ0FnN1FiRkRwYzFH?=
 =?utf-8?B?VEhqU3FXTDRUTCtzeWtaVHVpaVJDTmhNTXM0NEVHUDRwUFlIODRWNEMzNzZL?=
 =?utf-8?B?eHJYb3pmTVV5eUhzcEJSeHo2Y2dmcHF3TmVGaitZTW56aDd2QUI5aXBNR2Vs?=
 =?utf-8?B?dlB5c1hjNTdlNGhySi90MENjUWVvZkU3Y083R1dWVjVsOEdhWmtZa1FsMWdl?=
 =?utf-8?B?NWFuZHQxTUZ5VnVHTTNCTWNVT1ZKZmNtY1FSRG1FOVkxV21RQnVybmNBV0gy?=
 =?utf-8?B?eTVxTWtPTmdvaEl2aTFhZGVmazN0eGQxYXRRMkZZVmFrRVJRTnRzSzl0K1hM?=
 =?utf-8?B?YUJLSE9HQjNGZlJqV2QzcWtzMzhBOEFkOE5jQXN4VllvZmFmdkFTUDMvUzFH?=
 =?utf-8?B?cnVpQ2hGelZ5djlia0RKbFdyRXZ5bzRXcU9lcys0UEZKT3ZBMEJXZnd2bXBU?=
 =?utf-8?B?UlhaMW11NmdBaXpCVWVXaE5VTDdIQUxwaEVhY0NwdGthUXJaSGI5UjNVcHIy?=
 =?utf-8?B?aC80Njl1SmlSVVgzWE92R0RheDRHRjBuRk96MHJaanYzSTdqcVdMOEFxcW55?=
 =?utf-8?B?b3d1aTF4ejdwNmllRGRNeG0ybUtmMnA0VXlnQjJ2ZXNQMWp3RVpxZEcweWpC?=
 =?utf-8?B?My95NWNSYUo3Ukt2clFJQVpRMVVRamdYWmRENkJuNzFrc0Z0bU5HTmp3UHZR?=
 =?utf-8?B?Vjl6WTlmc1dSLzd2QWZXZ0JUMURrOEpadFQ0a0VoTWRmWkRPdDl2Z3RGNXNk?=
 =?utf-8?B?ZDJLcSs3a3RTbW56bHlXQ0NEci9ucUphbjVGS2t0L2RiYmp5WCt6anBGd0RC?=
 =?utf-8?B?b01MbW1jcnNFaGVnckZDRWU5L3huYUtUQUNrMCtBc2hIUU5PbVdzdnQwc0di?=
 =?utf-8?B?UUs4TkVmUkNMZk5HVWFMVFYrb0lpaTgxNnMrNGRlQ3VINzFvOCtsRWxyMnNs?=
 =?utf-8?B?dmpnRmpCRHZEeFRqbnJiMjNWaHYwakJqY3o3SzVuZEMvTk4zT2M4SjcydGoy?=
 =?utf-8?B?Yk41NVRnKzRDQm1NcmNYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJhNUtLa3ZqZWZyTnlCK1QySnkxaGFOb2s3ZzhrNkh6U05KL1VjMGptQkFs?=
 =?utf-8?B?UnRlb3hPaHdreUlvcXA3TzIzS2xYdHRhRk02N2Z3SzdaYXNFOFBDdHhSZExt?=
 =?utf-8?B?MWJDN0RWSTBjeVI2bWx5a0N1SkRVSk9uZnNqQWFKV1o2THVNS2RweExpWFpK?=
 =?utf-8?B?a3ZxcWZCa2xyYXdEWXVDYVVHaDdNdjJ4enFBSXh1WlZpTzR6SThkR1hFZ29j?=
 =?utf-8?B?U0VXMlhySjFSR2pnMkFraWlwYjY1T0F1bXkzbHlPUUhLVFR2WW1pWDFoQnJ1?=
 =?utf-8?B?N20wak1UU0Q5QkZFbWhqd21TeEJiY1hINVJVdk9MdGU5dDlmWWRabTQ1RlhG?=
 =?utf-8?B?WEMrdWtucW83b1hPSnhDKzBlZXR1OTRCN01seUVIUEFOK0R2TVZPM0MyVTcr?=
 =?utf-8?B?dTVnRm9pNHdlSXU3V3dTZnpuZ2MwZWE5R2Yzbmg4K2VUWVlCbFNPSkJoaG8r?=
 =?utf-8?B?dXpkbFRaanFvelVlMkVkZkowbHE0V21JWW0vTkEvdEk5TThRUjcwMk9LMml6?=
 =?utf-8?B?UE9KdkVFSEZhS2Y3dldaUk4wWjczVmJXcDRuMHpMVndKcW1EUlY0Mk9WNkRY?=
 =?utf-8?B?QnJZY1QvSVZJU3V4REd1SGp2VmdvMUwwYkN6YmtZS2lPVFNnQnFuK213Y1c3?=
 =?utf-8?B?NDVEUkUrYVpUbUlSUk4xUFQyTGZCWnZSUi9QOW96dDU2S3hVOXJIUE9rb0Yz?=
 =?utf-8?B?aGRhUWs2c25RQTIxMDZmRDdFT0tOQTExU3FlbTBSV2l4cEN4ZHhEdjhvQlpt?=
 =?utf-8?B?ck4wck5JZXhPN1kyaFJmdTdFWWI1RHdycGJrYm9oWnRYVmgxRFBFamJYSDhY?=
 =?utf-8?B?Tk4rY3hrdUMvTllvRjFVSllrQ0JCdDAyZElFekNYSmEwYkd5RkhONXhYejZR?=
 =?utf-8?B?bDNGajhwaVpBSzN4c1g0d3VzMnl3MURSQlVwUlJ1eVpJRXRYUVZ2bms1M0ZS?=
 =?utf-8?B?anZWeHRQVVQ3ZGdmZnoweWc2b0d0ZmtaRTFYZStOVHVpNE94STZnRkc5MjZK?=
 =?utf-8?B?R2NMMFY0d0hCemJwY1N3bDE4YnlYV1gyVlgxajdkSS9kbVNkd1J0cjBkbENU?=
 =?utf-8?B?QjNidjUwVUxnZEJybnpnL0Vwc1cwY1d6RDh2dDg1R3VLRU0xSCtoUkhXTnN4?=
 =?utf-8?B?dkM3aHZ0Wk5BWUdYdENxaGFPS0kvanBNN3I1dE93cnFMb284bCtjcEh5a2pq?=
 =?utf-8?B?eUdQWDF5Z3Z5ZjhPTFJGYWhrb1BZY0NTSVlQZ0ZpbHZBT1JCc2U3MTZ6eWFq?=
 =?utf-8?B?dTV5bFJvcFk4MjVicHMzYXJacUNjRms1eTA4TkpwNEpQdktPQ3diK0d1MFM1?=
 =?utf-8?B?a1N3dzVHU09QVHlZdUEzUk5SeXY1bE1BUDBvT0YxNXZ1Vm5LRGd0cFVQaEJK?=
 =?utf-8?B?Zk9jWmZHbXZpWTVRZE5wNlhaS0ZFeFRxUG5SM1p4ekhzOFJ0SERBU29VUTlG?=
 =?utf-8?B?T3dzUkdSR25OTXFzSlVCY0R2QTEyL2cxbTJGd2FqYnF1YmpOSEtHQlZUT3BV?=
 =?utf-8?B?bXBkVXpUOXR4UnNjcEwvYkRaTzRBYVhxU0NybGF3SWVFcXNNczNWd0lkN3NT?=
 =?utf-8?B?QmU0djJ2c3RtQ05rZGlOVng2SGRldEMyYVB2VUtPRU1pVFNuYk9id2xxeVRm?=
 =?utf-8?B?MVgxNUJuM0N4NUY4WE9CTGV5SytvajNvVVgrVHRKYVZIS1Q4M2ZrN0xVc3ZE?=
 =?utf-8?B?NXdLMFc4ZktxdzA1d2xYK3pITkRWVitYMzZGYlpiZEdFdHlSV1ZqZkwwSlht?=
 =?utf-8?B?UlZjc2VGTEZJenJvTGhJSTBwRk1RUnFrR3RqMEZZU0d2N3Nad28yQzFyYUpM?=
 =?utf-8?B?QWovUlNGT3pvcTJiNk5kdmpDeXQ5SEw4UXZ3YW5LRGQ2SHprMndiSWd2ZFg0?=
 =?utf-8?B?cWVXL1BENGRCUFZhcUZTNWxWc090aFlvLzJwYTZ3UjRYWkh3TXBFMGk4Sjlu?=
 =?utf-8?B?RFFZL1JOdDJKQVNKS2lkbEh1YzFLRE5CV3ZFMjAvSnZ6aGVsMmtlbFZtUGN6?=
 =?utf-8?B?QjUvRFlCTWN6YVVMUXRpTzNTQmVKbVY5L3pFYmlqWUh6aFJ1YlJhYjJhL1ZI?=
 =?utf-8?B?aTZKSkJmN05ybzN6b0N2NmlOT3FKencrR2piaGFCbnlTbDhJKytGTVpQNHN3?=
 =?utf-8?Q?Cu3RfVYyy1koF9x0JB5RtPLU3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0ca0d5-46ec-481f-c6bd-08dcc86fa7cc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:06.3521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8XweljV4IqIc5K+Qw6yNAJIzOZM8mxOIfb0DtYIvPyB3uluBuGEhJ/+f7+X4JvdK2qTB+HYCGigb2TzCKFFyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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

On 2024-08-23 15:49, Philip Yang wrote:
> If GPU reset kick in while KFD restore_process_worker running, this may
> causes different issues, for example below rcu stall warning, because
> restore work may move BOs and evict queues under VRAM pressure.
>
> Fix this race by taking adev reset_domain read semaphore to prevent GPU
> reset in restore_process_worker, the reset read semaphore can be taken
> recursively if adev have multiple partitions.
>
> Then there is live locking issue if CP hangs while
> restore_process_worker runs, then GPU reset wait for semaphore to start
> and restore_process_worker cannot finish to release semaphore. We need
> signal eviction fence to solve the live locking if evict queue return
> -ETIMEOUT (for MES path) or -ETIME (for HWS path) because CP hangs,
>
>   amdgpu 0000:af:00.0: amdgpu: GPU reset(21) succeeded!
>   rcu: INFO: rcu_sched self-detected stall on CPU
>
>   Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
>   Call Trace:
>    update_process_times+0x94/0xd0
>   RIP: 0010:amdgpu_vm_handle_moved+0x9a/0x210 [amdgpu]
>    amdgpu_amdkfd_gpuvm_restore_process_bos+0x3d6/0x7d0 [amdgpu]
>    restore_process_helper+0x27/0x80 [amdgpu]
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

See comments inline. I'd also like Christian to take a look at this 
patch since he's the expert on the reset locking stuff.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 56 +++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a902950cc060..53a814347522 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -35,6 +35,7 @@
>   #include <linux/pm_runtime.h>
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   
>   struct mm_struct;
>   
> @@ -1972,8 +1973,14 @@ static void evict_process_worker(struct work_struct *work)
>   			kfd_process_restore_queues(p);
>   
>   		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
> -	} else
> +	} else if (ret == -ETIMEDOUT || ret == -ETIME) {
> +		/* If CP hangs, signal the eviction fence, then restore_bo_worker
> +		 * can finish to up_read GPU reset semaphore to start GPU reset.
> +		 */
> +		signal_eviction_fence(p);
> +	} else {
>   		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
> +	}
>   }
>   
>   static int restore_process_helper(struct kfd_process *p)
> @@ -1997,6 +2004,45 @@ static int restore_process_helper(struct kfd_process *p)
>   	return ret;
>   }
>   
> +/*
> + * kfd_hold_devices_reset_semaphore
> + *
> + * return:
> + *   true : hold reset domain semaphore to prevent device reset
> + *   false: one of the device is resetting or already reset
> + *
> + */
> +static bool kfd_hold_devices_reset_semaphore(struct kfd_process *p)

I find the function naming of these functions (hold/unhold) a bit weird. 
I'd suggest kfd_process_trylock_reset_sems/kfd_process_unlock_reset_sems.


> +{
> +	struct amdgpu_device *adev;
> +	int i;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		adev = p->pdds[i]->dev->adev;
> +		if (!down_read_trylock(&adev->reset_domain->sem))
> +			goto out_upread;
> +	}
> +	return true;
> +
> +out_upread:
> +	while (i--) {
> +		adev = p->pdds[i]->dev->adev;
> +		up_read(&adev->reset_domain->sem);
> +	}
> +	return false;
> +}
> +
> +static void kfd_unhold_devices_reset_semaphore(struct kfd_process *p)
> +{
> +	struct amdgpu_device *adev;
> +	int i;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		adev = p->pdds[i]->dev->adev;
> +		up_read(&adev->reset_domain->sem);
> +	}
> +}
> +
>   static void restore_process_worker(struct work_struct *work)
>   {
>   	struct delayed_work *dwork;
> @@ -2009,6 +2055,12 @@ static void restore_process_worker(struct work_struct *work)
>   	 * lifetime of this thread, kfd_process p will be valid
>   	 */
>   	p = container_of(dwork, struct kfd_process, restore_work);
> +
> +	if (!kfd_hold_devices_reset_semaphore(p)) {
> +		pr_debug("GPU resetting, restore bo and queue skipped\n");

Should we reschedule the restore worker to make sure it runs again after 
the reset is done?

Thanks,
   Felix


> +		return;
> +	}
> +
>   	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
>   
>   	/* Setting last_restore_timestamp before successful restoration.
> @@ -2031,6 +2083,8 @@ static void restore_process_worker(struct work_struct *work)
>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>   			kfd_process_restore_queues(p);
>   	}
> +
> +	kfd_unhold_devices_reset_semaphore(p);
>   }
>   
>   void kfd_suspend_all_processes(void)
