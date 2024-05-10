Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE6AC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 09:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F80510E7C4;
	Fri, 10 May 2024 09:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0DbmUDLz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C71710E7F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 09:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMbTfEN83bfZrQc1B7WpatzJ8/uM0iFS9sErIMqgae1L6gQdr/Uzbx4a0VSOssOIoRyxpN1x53rGcEPpQzvSC/nZ7jAYavG4fQzXRybz9evJH5LMvGs23zGvKIQWE8Ebi67h2w3l7BeQ+4gEC2aZetiUqSTQo74+yedcQc2+9dbEft7KWLzGF8CUG8zt7SeufyamHB1QoP/yJDmlywxuM89if4c//r/LD5UrGQU7TXt3n5aUZauRbMlRX7sLaCYsbgme/sXJpmU0OXGJLu72wwbze1WJLtXFdLSbslOMibN8THo9aZz7ieqVB+6MYOnceKlfZoNQjfwJZA4oQkwb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G84FfmMeOhizV+ZVzwTpk77vemtIzhvOTji/UnlA+g8=;
 b=OXhJqmHrprBa4IZPyw+aoPKJV3EOfzramSr37hXm1RKkokZCXBtHhG83kPKKFQuHwbEz79H/Q4qut63+B7TOgmbqReA0+TWbibfYAmNSVLAgg3I7CNHhd+6p99EFEM6bjGnwaVwwv9aPc4lYzhgfOoICK8un2E+41ClAUzJ57SmGlZxsFn85yZF1+u/ypjBjghNC4yAN8zB1uDSDL/P6gjJxXk0krsXh43dyI1U7vgpKEV3v8LOpsr6oycSWuAH012AoLmRR0rshzm81+FuTI45yD7s90vliSprqJLqEJqak7Shn5yXv1jocqayKS3CPvp+h0qfCIPhvIIdaNMCL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G84FfmMeOhizV+ZVzwTpk77vemtIzhvOTji/UnlA+g8=;
 b=0DbmUDLzrpjZjHmsTuSsohn4nyvbHzKw5HVMxW5JV4F+x2uSRsDgZX8wDgzTJMyTS3p1QkHP47LfPSmo69jVAp8AmWfiSLRvIGyDX8kot0wMmdY4+Sh97XP5Q1D1nWpdusMuxEQFOtpEO/S7K3M5AYUI2aBiu3BcXbCAdOod1Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 09:30:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.049; Fri, 10 May 2024
 09:30:36 +0000
Message-ID: <fe0c458c-7c1e-481a-acda-6a58dc49319b@amd.com>
Date: Fri, 10 May 2024 11:30:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use the slab allocator to reduce job
 allocation fragmentation
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240510081145.4081645-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240510081145.4081645-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0164.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb2d31a-d6f5-4df5-b3b2-08dc70d3d95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjdtTmE2a05CR3hYa1MxVG9PNVpsa29DL3ZaSUZDQmcrc0prVXpTY2VnTVVw?=
 =?utf-8?B?T2QvOUcxSkc3R1RkeVBHbE1WWGFJZ0hrdDRJYVI1d3VtTDNBV3pGdHkyVkNV?=
 =?utf-8?B?OVdBYTduY1ZLcTE2YjFrSythdDRpN1ROcGpHRnN2N3lzMnR5OFVDMEhnSnNJ?=
 =?utf-8?B?RTBTY25iQmNXTWttb3N5ZldPV3FXeW9pcmdQUmdDNDh6eHhKVmI2YWEvNXlH?=
 =?utf-8?B?dlBNNmhLRzB0UVYzQmJVTHRoVUlzMkNwMnU3WFFOKzliV2RvMytST0x6Tlpx?=
 =?utf-8?B?V21XeEdVZDFuSTF3enhOeHd0Y0ZYalFQSW4yUTJtb3ZQaTN2alVvT0xDK2Q2?=
 =?utf-8?B?Mk9ScUZxaktWM2RlTjcraUFBZllnamFVOW9IT1RKMm5MbkttVWlaY0F6Z0F1?=
 =?utf-8?B?RFl4eVZtdTNSVzhUTGhFb0JZZURKckFCSnJXTDZQUEU1MkdMNjFzSWh2QUJk?=
 =?utf-8?B?anZBalBDcytqQlBQMmVQR0RmM2pjdjJORWhwb2kydklLSHhQN0EwTSs1aDZ4?=
 =?utf-8?B?VnBPU2V6Z251N09VQU1MWG0zRlB3RDNoL20xUFArWU5hVzNXaUNqQ1M1cFh3?=
 =?utf-8?B?bFUwbEovcVVyckJCSDhtQ1JhUno0NDZvSTBRQkY3ZENOU1pnRWhreWprTzhk?=
 =?utf-8?B?d3ZCNlFyZVN2QnB0RGc1KytLcUFabEI0M1hraG1PMkVtczR0NkhzY3V5T0Fh?=
 =?utf-8?B?Qm42VDRkZmJsWk1LeS9nZjRmUHZHcGxXRXBYTjNSOVd3UWJLdXIxVzlOeFJT?=
 =?utf-8?B?ZkQyc0xBM2ZXeEdnOXd1QTdpN1ZyZThqTnRZWTFpdC9jQVp0NERHS0JzYzd5?=
 =?utf-8?B?d3kzV1ZSajdYR2tZYWZHZ0ZHYk9Mb1NaSHdiUDhIWHNiM0tERnArQ2o1T2VX?=
 =?utf-8?B?L1F0NzFIQmw4UUVRc0llc2hKK0x4UDc5eFI4bExmWkgvVDFBSlpJZ0NqeFZC?=
 =?utf-8?B?SGpoaEhUQjdRVXUxeGN3UkJDWWpuK1NqdFJubFFZSXVhcXlSSCtLZGVycERm?=
 =?utf-8?B?R2pKM1lCYXg2d2tXYnExNlFMVzBYSFk3NE5xelJFU2ZEMk1DRzMrdXVpTnhq?=
 =?utf-8?B?b281YTlGM2RKY3RhR01rMDNyaHhiWlhTbCtvWTRnOFZZOSt3eXMxM3FLTmdY?=
 =?utf-8?B?Y1crZlBzTXVYRDVRNXJsL1MxbDgxakp6THhrenN0UHFCRjBDT1psMU9pZFRH?=
 =?utf-8?B?anBFcG01SXJMQk4wamZaNmw3MW4xNVVOdHdkOWZCc1NSM1Vka3lCQlRqdnJJ?=
 =?utf-8?B?T21IYXdLNDVaTW5hdGVvQ2Y3ZWVNZE92bW9JK1V1S1JkdHpGOU1kYXgzQnp5?=
 =?utf-8?B?QnViem1vV1BlU1l6N1BOSnN2U2tBbThMVWIrc3VleXlnZ3ZJaWsrYW1hcHJn?=
 =?utf-8?B?SzRjL3JZTys2TzNMUmpuS1hnOUhjeU5tOE91dzBXZlpmYldSKy9sRzc1OHg1?=
 =?utf-8?B?dlVrNlcvSFBuSGRUZ3c3SW01TGRZR0tNVHNmUUFhZzJwaDFCS0c4SmxZTGxq?=
 =?utf-8?B?YVRLNG5QM2grVnFRYzNseTFET21qUlF1TDlkUjJnSGdVK1ZrZGJpVUE5VVpP?=
 =?utf-8?B?eWlrL1VuaEN3bThtTlUyVTYyRE1HMERFYlhiUnJrU2NCYkpYU1ZnRTROK0lG?=
 =?utf-8?B?OVdhSWhlVEhJdXBVOEVsa3J3WUZhTnF0RWFxek9ZN0FqS2tHRWdMMTQ2bXov?=
 =?utf-8?B?cStJZWVDK016c3VHOHFKaE96NHdHTDVIMWZDNmJyM1I2cjAxZVZKa3JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZLV3BUeEJ0OFhpRG1FUVU3aE5kdGROQVVnZnFSTVkyZnB5a25wOU8yUXpi?=
 =?utf-8?B?RlVHSk1JdTREK2dOZ29nYWUxL0NCZ2N2MlpTRE5LamlMQVg2NlBjc1JUTWlR?=
 =?utf-8?B?ZlFESHVjT0JNRW1BZEtGc2ZTR3RLUHpoMFJWcGRZRTVqZE9rVEZMQVltT2Ji?=
 =?utf-8?B?azZSTm9DYXU1NU5oVHN5M283ZzNPRDR5bmwvOTdmT3FTOFh1VVNHRHdPWUF4?=
 =?utf-8?B?SGwvejcwclRDLzRuSjdjZURsZEhXZTBJSEFUVWdqVk1mbGhXRFpGWGZGdEJN?=
 =?utf-8?B?TUFCV3hXZXN3cEM3VTVYNE1sK2o4eTdHcUlhRzRLUWNOSGFybUpIUndQUUdn?=
 =?utf-8?B?SkJHWk14UVhFWkVheU85MEtHNWpCcWwrdmZXeXhHenFLc3hkdEhkalB5aEw4?=
 =?utf-8?B?ZFRMbTBFK1Irem5ZcXBsOXk3cUNSZ042cHg0STM1a0Vscy9ITGVMeGtlNytY?=
 =?utf-8?B?RVBBWFNLY0JCQWlHK3YvODJDQ0ZQZGs0RUtaaGphbDdCTU1hak5iVjFGN25h?=
 =?utf-8?B?MTdSbGl5REliV0NPbVhjSE1zUStlUkl1ZTBhZzhLWVRRdHNETWFZdjBveVRo?=
 =?utf-8?B?YWVXYWRqM2dZQWlmTVlTWm9xMjVDdG1OeDF3QTl0dnUwY3YvcHpyalpTTG1j?=
 =?utf-8?B?OWR0UzJLMGw3V1AzdHJHODA5aDFZQVRMNU5qNWhFM25NckVCVzdlNnpwVG5K?=
 =?utf-8?B?SndHbjdkTy93cEpqVWk3a0RRRzlrRlZyRmxDZE9XaFphNUJCSFNqeHlHTDNE?=
 =?utf-8?B?dHBMTzAyTUwrWmVqSWdRR0pnbGJqVDcvcXc5Q1ZSZnUzbkR2cVNVMjM4dDZF?=
 =?utf-8?B?Wkh6Q2pUS2hqTWErcVRTOGVoRWN0Qkp2YjBqaTVUR2VxZHRPcFE1c3hBVDZN?=
 =?utf-8?B?L3cxcCtYQ2x0WHpGbGZGNTdwZTdUZGFBcEoySys2U0lxeXgrRm50b2ZjNHhD?=
 =?utf-8?B?RktlTFY4R2xrMzhBQWkxMVdUUGNoYkRDcXpUMXF3NzNtS1RTR1dLcTJZRCtW?=
 =?utf-8?B?RDkyaEtOaWd4WXhpSnJjTzZrUUlLVGcwOTFsUEJDL3hJZ01CN21WcWlhQlk5?=
 =?utf-8?B?b1hRZmRLSHdiZXhZMmYwaWRFUHVVQjJTTS9neGs5SHU1M1Q5N2RvLzhuN3h1?=
 =?utf-8?B?b2JENzFTOEMwSGtxQWJBY2pkcXNqVVFCL2NFVHR1eWRvUHZKM0krUWUvNnMz?=
 =?utf-8?B?ZjJsVEpWT1ZhRisxVTd1ZFUrZ0VUQXNpYjVaTDJLaUQ3am1aaDZieDgyUzVs?=
 =?utf-8?B?Z2FoZ0N5aGdyNjhkdFJRNFRSdXpySEhLRnJvUnZBREZBTy9ValRadHhUVlFQ?=
 =?utf-8?B?dDRMeFVrUlQ0OXA1MnZMS1pnaFZtOXozd0kvWnJtVDhFRzhCcUx3MUcvNXlQ?=
 =?utf-8?B?cU5iZDc1Tk94K2xWZkF2dHVIbnlyODR1Z0dYd1J2YUkwV0FFZSt1YWF0UVRo?=
 =?utf-8?B?WEtDeThhSlI0cU1Nd0dLSjd6YVpHR3Y3Q0NyTzh1VjIvL0dUb1JmQzcrZXkr?=
 =?utf-8?B?YkMzTVlkclRzZFdpVlExM1FoUFdzenJwN3ZwVmoxa2NMeG94Ry9ZeUsvc3Vx?=
 =?utf-8?B?L2ZPbUJiNzljZ0xHYXgzTWQxeG5OdHAvUmYxUTZBSFBteHB1aU8vNHhvZ0Ra?=
 =?utf-8?B?U0dTVHhqYnlDKzZSK1JJdVhMUHcrSENLYStqZ0RJL2lNNThTVmxoRTJlUFNK?=
 =?utf-8?B?UVVmYWM5ZEppUkpESmNsV0ZGakplNjdPbE1mMXVSOVB1OW1MVkY1N2hzRUQy?=
 =?utf-8?B?SHZyRlg4c0pHbmRFY25YOHpiLzA5Q3NrV2NheUZIT0MwNEc2MGg2NlY4MlEv?=
 =?utf-8?B?bm11R1VHaTV4NDVidFlKb2ttd3ZCU0VpaTBxNzUzVXdkWVI1Y0xzWEhqZXg5?=
 =?utf-8?B?MmMxa1ZoQldJZ0lja2pxZytiazU4V2J1VUcxa2R3azBoVm9tRGsrY1hyUkhm?=
 =?utf-8?B?NmtrSUo1NVlkZVhnaHB2RUxFYVcrVTkwMTQydUF2ZXFsS1h4KzVaTE1qanRN?=
 =?utf-8?B?Ujh1eVg1NmNFei9XSnE1T1MzaGR3aWVwMkpkMDJiTk9leHJVcjk0ak1NL2lC?=
 =?utf-8?B?TkV4c3JDbUI0V1BweHh1SmZmUk9KcVB4akNxUE9XUDdmeGN5V0YzOVNCcDFa?=
 =?utf-8?Q?Dmik=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb2d31a-d6f5-4df5-b3b2-08dc70d3d95e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:30:36.8498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrpao/FtX6nuOiIb3UJ/g2DIKD6WnwnDosz+5vsPumt2EBBHAVYynqS90u9EnRqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
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

Am 10.05.24 um 10:11 schrieb Prike Liang:
> Using kzalloc() results in about 50% memory fragmentation, therefore
> use the slab allocator to reproduce memory fragmentation.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 ++++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>   3 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ea14f1c8f430..3de1b42291b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3040,6 +3040,7 @@ static void __exit amdgpu_exit(void)
>   	amdgpu_fence_slab_fini();
>   	mmu_notifier_synchronize();
>   	amdgpu_xcp_drv_release();
> +	amdgpue_job_slab_fini();
>   }
>   
>   module_init(amdgpu_init);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e4742b65032d..8327bf017a0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -31,6 +31,8 @@
>   #include "amdgpu_trace.h"
>   #include "amdgpu_reset.h"
>   
> +static struct kmem_cache *amdgpu_job_slab;
> +
>   static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
> @@ -101,10 +103,19 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (num_ibs == 0)
>   		return -EINVAL;
>   
> -	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
> -	if (!*job)
> +	amdgpu_job_slab = kmem_cache_create("amdgpu_job",
> +				struct_size(*job, ibs, num_ibs), 0,
> +				SLAB_HWCACHE_ALIGN, NULL);

Well you are declaring a global slab cache for a dynamic job size, then 
try to set it up in the job allocation function which can be called 
concurrently with different number of IBs.

To sum it up  this is completely racy and will go boom immediately in 
testing. As far as I can see this suggestion is just utterly nonsense.

Regards,
Christian.

> +	if (!amdgpu_job_slab) {
> +		DRM_ERROR("create amdgpu_job cache failed\n");
>   		return -ENOMEM;
> +	}
>   
> +	*job = kmem_cache_zalloc(amdgpu_job_slab, GFP_KERNEL);
> +	if (!*job) {
> +		kmem_cache_destroy(amdgpu_job_slab);
> +		return -ENOMEM;
> +	}
>   	/*
>   	 * Initialize the scheduler to at least some ring so that we always
>   	 * have a pointer to adev.
> @@ -138,7 +149,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>   	if (r) {
>   		if (entity)
>   			drm_sched_job_cleanup(&(*job)->base);
> -		kfree(*job);
> +		kmem_cache_free(amdgpu_job_slab, job);
>   	}
>   
>   	return r;
> @@ -179,6 +190,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>   }
>   
> +void amdgpue_job_slab_fini(void)
> +{
> +	kmem_cache_destroy(amdgpu_job_slab);
> +}
> +
>   static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   {
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
> @@ -189,7 +205,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   
>   	/* only put the hw fence if has embedded fence */
>   	if (!job->hw_fence.ops)
> -		kfree(job);
> +		kmem_cache_free(amdgpu_job_slab, job);
>   	else
>   		dma_fence_put(&job->hw_fence);
>   }
> @@ -221,7 +237,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   		dma_fence_put(job->gang_submit);
>   
>   	if (!job->hw_fence.ops)
> -		kfree(job);
> +		kmem_cache_free(amdgpu_job_slab, job);
>   	else
>   		dma_fence_put(&job->hw_fence);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index a963a25ddd62..4491d5f9c74d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -103,5 +103,6 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>   			     struct dma_fence **fence);
>   
>   void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched);
> +void amdgpue_job_slab_fini(void);
>   
>   #endif

