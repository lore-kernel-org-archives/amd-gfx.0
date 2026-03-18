Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D65FCD0CC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 07:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E2E10E021;
	Wed, 18 Mar 2026 07:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQqNHODS";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012025.outbound.protection.outlook.com [52.101.53.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCE610E021
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 07:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PicN0UOWtsdf4XpZajr75NUKe+lhovT1a4MFLyf4YyPU9ANsWFe9Js9+yOI9BjdDMgATrDalz2pgmkzuGB4f4g9n0UP2dD2/GkYDrT8ZohuIbcNuWwteR5f65YRPVLTKpM6ImFi8iKHeKK3QDV/zMnj2k6WisuKOpeFhSERdKVPbqD51ECUnbYeE392IOJXbKKgB86v+bmGcaisSRIBsorP9ds4paOYkxvAghRxldVuZlAxbKtbYvkqag8YFs7cNoU8I4S1O285hMk465j75YnohVrxXYVPiSCb1EfbzUzCD/whLRhy4mYbJyDIPZd0MOvIhrDI+GWkZ/Li7Sv1QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWOwGoc68Z6rG/aiN87O9+e7XbkFz09f5e4vvOJxwSU=;
 b=jGlMAk1J3myYXlgRPHZAbLEmtHsiS3qke3W0LykomtpwOcnZtfp7IejfydeOSdB4ljivJBT7/T5PyrHTewM8Mfh9tqY5dCCBxk0HnrHMXkB7G9bIdl6nd1iw4ubUZ4IZbGWGxK8u47FvPA0jpGFWjGAIL4y2izI653sPgB/uuExTz6rM5UURvNceFYxH0OMaPaHJXgYAHH/8kBicpa4XNrDZF18tnFyHja8fOFHAuxjxC558XUeI9c5grK3yDEDmYg+OF7PkE8xUMObcNXfY0s9u7CSJ59i7DOatmz2AOJ0Wp53MCTfPcCueE+EQQwG+NyTsGMAQyY+vi/rPMLw3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWOwGoc68Z6rG/aiN87O9+e7XbkFz09f5e4vvOJxwSU=;
 b=pQqNHODSaTTrLi7UtV6ETPZdXphIBNQ5U8jPF7ARNROcy6GbNg8nXwR10KvlyljxzYxxqpWdTbVBCetyqrz7+Z736v3NiRXCcWE+sjLpiMUBHduyq7qmFYilIh2pOnygVDnVnVC9gU3A2HdUL5a3Exbg3lKWdfCFKE3akh0BW0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Wed, 18 Mar
 2026 07:59:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:59:30 +0000
Message-ID: <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
Date: Wed, 18 Mar 2026 08:59:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jesse Zhang <jesse.zhang@amd.com>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260318074708.2078535-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0910.namprd03.prod.outlook.com
 (2603:10b6:408:107::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcc6350-4c5c-4fa1-e1b5-08de84c4489b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: TbgGhciRG7Q55toaA7Brm5jfrTYnz2ow0tr6ezBbdgfsDiucHrSAwa8ojkqoD0ESzbqmEKJVctmeJyzXyMW5yNW4LAXWML6D3JL4mC/yZC8XrOwUL3tjMZ8zKAY++x6MSdpMeYgnpwWH/O2BOo0ncoa6RbwKNwFXrAp+hHJlpKCn/sMklfPCq6cfm/pWWRkOA6C14GnWk3ZMWz6ktao/1ntnSm5wnJsbCggKbknqdMMQCI6fC4Eh/aF96Y1qvU2B0u00ob2J8n7by3GTxYViCXsI0HEuflEbFh3eQokT2EATI5+euz712c14hLs6Rq4GBpQqTPiIIMXS/mpE7uKxwb/aSlbPLiM+Pv0yYWGZPGrl4gRkwcp6AvBa29PM3BXQlEjX64W3/ViBOG2/h2u48OsaVJCU5TNsfKzwKSUbUt3AKVR5nqWYN0Yvzd8UA1Q8bhJyU2PQYmKppY3H50S7FFLiXaVcHO1etsSZA4jSdRxeCXNKs6AyllOZPOod9jANSr70BE6nMJmWmODzSJsICAXPg+NHDW5UehHrlgvQ/BUvQKTrkAtBvwTUmcaHMXKpAwZmskAB/BLATs0oI9x8K+YTIvjZAgEIIO+J+ALDafWmG+OrVwNbnxxt0BatWnJakpngW88yL88yRTQBtpq4Il54eO+vzGBPvSzqFFg3iwZY7L9SAQK5qu39GeELFecQ3nH/nf3to7qePf8ETPC+9QJ/dfC9AYoiXmvSRAV/vX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBwWi9MQzFHL01EelBlOWV5RTlkTXJwR2kzdWFvMUdaQllHdVpLTGpuamxj?=
 =?utf-8?B?eEt5TGhQU2xsNWsvamk3WXRtUWdCOS9qVTdFZkVaQWs3djIxb2tyYm8wdE52?=
 =?utf-8?B?eTNFc0FQTXBoU2poSFhjK1ZzMVdidTF3K1Z3VUt2QmJySTJMdU85L3FEZGdU?=
 =?utf-8?B?QjdHeHRRRWJOQkc4eWtnMWhEVmN6MCt1TktyQmNTMHhHUkE5MHlqbkthNTl5?=
 =?utf-8?B?VnpZcFk2ejJ1QkJzMCtoUWwwRGZwL3ZuMkF0UVJvQU5od1ZLakpza1dlQWxs?=
 =?utf-8?B?cUhSRkZ3dWhrK3NkZGtmM1E0OTFEUElsRkRkcFJSdUx4NytKYzZKV2RpbXRJ?=
 =?utf-8?B?ZXBidEwrNTZnWlZLYXJYZlhpMlNzaHBhSlRLQXhNQzljS29CUzJnREZFdVht?=
 =?utf-8?B?RWdpMGxkYzlxTEs2bzVmL1ZxbVBZWTdHTTgxbnNUVXo0a0VwSUxPRXIwRlVt?=
 =?utf-8?B?M0FEUUlzdGVQUWZETFhEMkM3cjhzckJ1SGhRUXA3UGd1RUhvWVB3UmpBcURZ?=
 =?utf-8?B?Q2dBWk43MnEvZ091SlREdXJlQkVucGpiWVlPWjBveXN4c2pUN1E4WjhVbFpu?=
 =?utf-8?B?M2NQekJHVkU4SW5hZVpTT1F1L3Jna3BjYmphSVJCL2dFNmtKakhPcHpLQlkr?=
 =?utf-8?B?ZktDT2VIRVhCR0NuVEhRTzhpVzBTSnVseTNGOXRnWGJDTlN1c1ZDNnRGYmNW?=
 =?utf-8?B?cUFUUGpvQSttK2lYS3hLbkd4ZTFKWXk0YmNMVmtPRGswZmRjYmRxQnQ5TllJ?=
 =?utf-8?B?TGoyU0ZTVXNWOHo4MjJCeGNOdXdoTzJHZVJJZ2s1cnNKOHBBOVVSQ1RVVlY0?=
 =?utf-8?B?em1EajAxdlZ6di9La2ZuZisxVFViWXBkOFpHY1NvN3RrTEFRZWtjTkJQd3NC?=
 =?utf-8?B?ODJ2ZWREQjVST1cwV05sVnc0VlI5SWJhNXA1UUpLMTdRd0FkZ3Zua3FGT3R3?=
 =?utf-8?B?YVdhVG1KQ3lveWZhb2x6R1A1MzNCTDdiMFpYSUNyYlB0UUoxSWZNc2lvUHhG?=
 =?utf-8?B?amo1NENqWkJoYWlEdGRReWNFWU4xK2t0K040S1ZBNTNvN2c1ZDNmZkZxVVNq?=
 =?utf-8?B?SFdrT2N5eXVJTWQ1c0tnUEZ1OGs3M0NKT0J4d0NheWdrR1RIYThmY0lGajk1?=
 =?utf-8?B?UzRxbXZGcWV5MGVUd2YydVJvT3hGN3UxVnB6cWc5UTluQlR0NU5SSUJyc1pl?=
 =?utf-8?B?bUxDYnJkcEU3eUM4QThuZ1dVUmZnM2dHbTh5eXdUMnp4aytDVHNZRkdxYXAw?=
 =?utf-8?B?ejcraHR3SzdPOUVGcUJCWG5mY0VCYk8raXloSFFxWi8wVk9LajBoSkFQUXpW?=
 =?utf-8?B?MzdtOFpHa21ETXlQUXlZbGdtSW5wMkxMV3ZxeHN3WWY4M1dqTEkvckQ4dEsz?=
 =?utf-8?B?TFZuWG5RZHJGODNUN2ErMHZmbXYvcXdielpwbk56QmxHeENlM0hsRWl4VU5x?=
 =?utf-8?B?RmRnd2oyQXVHVEY5Um94YXNDTTcxaEJiRE90K3ZGOFVkNTVzWkZ6UERKL3RS?=
 =?utf-8?B?UlpNYTh6ZGg5ZkduZkhuL1ZKcUN6TXBYSDJYUkY0d3RyZVpPNU5qR2JXQnJ0?=
 =?utf-8?B?ZGsxTDNwQ1pzektEeVRsMUtpaEVuN2MwSXZySEVxRk5oNFEwSklJbERUK3Z6?=
 =?utf-8?B?dmpFazM4R0orcXA0b3NJOHJkQk5WWUs0RG9TdXNYcWxwRzFBcGcwRVhCRHc2?=
 =?utf-8?B?TlhWa1kxTDBCd3d3STNpa3gxYmxSdlRldnN3V05LbUZVa2gvWCtWNVNKaWx0?=
 =?utf-8?B?Y0FUdmNFQVRkaGwwSlZqMjQwWnQ4NnY5dU1wa0tpWGtESWFaL1JKaHdMNmFv?=
 =?utf-8?B?L0VCNE5QU1lYQkxKdmFyR0I4Yi93Z0VvcVIrNnBIbXlnamFOUWFmQTVSZCtQ?=
 =?utf-8?B?QnN6bnVGYmlKem9KaWFmcEhVc1NjL2dBa3JFeVhKdFBwOTlCK0lnODZFRTdC?=
 =?utf-8?B?aUUzdTZuZkI2bHprUVRTZ2VxT045Zk1hZm1sQ3VLQ0todlA1MExWaFozTVg4?=
 =?utf-8?B?emw0MkxtRXNJSHE0VmhDcjF2MmNaSFErWlZ3Q25DNTN5L2FUaHpFdkFiemtt?=
 =?utf-8?B?Vnl1ekdVTkhvekxMdUhwTTZiaXRIamFONVB0UFlwS1B1RkltRHRTcWMrMWVB?=
 =?utf-8?B?bk11MXVCR0FuWmVHdHBOamZJMlIybVM5cTNtb3Q3eGdLQmtnamhEOUduREdY?=
 =?utf-8?B?MnNoWFVHYnZsTVFHSUtFcGtCUmtaNDZXSWJtQnRISVlPb0VMZkh6QmxmL3d5?=
 =?utf-8?B?RHJTbnRMaHBaY3BUT2NML2QvMUoxb2p0NitRamRhSUljTUFNd2tvZ2RZUHpy?=
 =?utf-8?Q?dbuOzBniaBwqHV0q0k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcc6350-4c5c-4fa1-e1b5-08de84c4489b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:59:30.1322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4qkcqdItQL9DdgTIr3sv2jyDnmdqOoZNwDSvijaFQK4C+e+UmDEa8JzOFg67aiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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



On 3/18/26 08:47, Sunil Khatri wrote:
> This reverts commit 0cdff8eb31c139dde4716e4aa37198c16364629e.
> 
> The patch has caused regression for userqueues where user is stuck
> and is waiting for fences and a gpu reset is triggered in kernel.
> Also for any of the parameters when count is zero, the driver does
> not read from the pointer and having that check is overkill.
> 
> Application:
> MESA: error: amdgpu: getting wait num_fences failed
> MESA: error: amdgpu: getting wait fences failed
> MESA: error: amdgpu: getting wait num_fences failed
> MESA: error: amdgpu: getting wait fences failed
> 
> Dmesg:
> [  122.668493] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0
> [  122.668504] amdgpu 0000:0a:00.0: sq_intr: error, detail 0x00000000, type 1, sh 1, priv 0, wave_id 0, simd_id 0, wgp_id 0
> [  124.687518] amdgpu 0000:0a:00.0: Dumping IP State
> [  124.688351] amdgpu 0000:0a:00.0: Dumping IP State Completed
> [  124.688355] amdgpu 0000:0a:00.0: [drm] AMDGPU device coredump file has been created
> [  124.688357] amdgpu 0000:0a:00.0: [drm] Check your /sys/class/drm/card0/device/devcoredump/data
> [  124.688361] amdgpu 0000:0a:00.0: ring gfx_0.0.0 timeout, signaled seq=569, emitted seq=571
> [  124.688366] amdgpu 0000:0a:00.0:  Process Xwayland pid 3471 thread Xwayland:cs0 pid 3479
> [  124.688369] amdgpu 0000:0a:00.0: Starting gfx_0.0.0 ring reset
> [  126.560451] amdgpu 0000:0a:00.0: MES(0) failed to respond to msg=RESET
> [  126.560456] amdgpu 0000:0a:00.0: failed to detect and reset
> [  126.560460] amdgpu 0000:0a:00.0: Failed to detect and reset queues, err (-110)
> [  128.789840] amdgpu 0000:0a:00.0: Ring gfx_0.0.0 reset failed
> [  128.789848] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  1
> [  128.790161] amdgpu 0000:0a:00.0: Guilty job already signaled, skipping HW reset
> [  128.790174] amdgpu 0000:0a:00.0: GPU reset(1) succeeded!
> [  128.804538] amdgpu 0000:0a:00.0: [drm] device wedged, but recovered through reset
> [  128.804574] amdgpu 0000:0a:00.0: GPU reset begin!. Source:  6
> [  128.816663] amdgpu 0000:0a:00.0: Dumping IP State
> [  128.817458] amdgpu 0000:0a:00.0: Dumping IP State Completed
> [  130.963939] amdgpu 0000:0a:00.0: MES(1) failed to respond to msg=REMOVE_QUEUE
> [  130.963949] amdgpu 0000:0a:00.0: failed to unmap legacy queue
> 
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 -------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3fcd70a38374..0d9a13081f2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -484,16 +484,6 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>  		return -EINVAL;
>  
> -	/* Reject non-NULL pointers paired with a zero count. */
> -	if (!args->num_syncobj_handles && args->syncobj_handles)
> -		return -EINVAL;
> -
> -	if (!args->num_bo_read_handles && args->bo_read_handles)
> -		return -EINVAL;
> -
> -	if (!args->num_bo_write_handles && args->bo_write_handles)
> -		return -EINVAL;
> -
>  	num_syncobj_handles = args->num_syncobj_handles;
>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>  					    num_syncobj_handles, sizeof(u32));
> @@ -950,25 +940,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>  		return -EINVAL;
>  
> -	/* Reject non-NULL pointers paired with a zero count: the pointer
> -	 * is meaningless and indicates inconsistent input from userspace.
> -	 */
> -	if (!wait_info->num_syncobj_handles && wait_info->syncobj_handles)
> -		return -EINVAL;
> -
> -	if (!wait_info->num_syncobj_timeline_handles &&
> -	    (wait_info->syncobj_timeline_handles || wait_info->syncobj_timeline_points))
> -		return -EINVAL;
> -
> -	if (!wait_info->num_bo_read_handles && wait_info->bo_read_handles)
> -		return -EINVAL;
> -
> -	if (!wait_info->num_bo_write_handles && wait_info->bo_write_handles)
> -		return -EINVAL;
> -
> -	if (!wait_info->num_fences && wait_info->out_fences)
> -		return -EINVAL;
> -

Mhm, in general such checks look valid to me.

My educated guess is that userspace sets num_fences = 0 to query if it needs to resize the pointer out_fences or not.

If you have time please double check which check fails here.

Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

>  	num_syncobj = wait_info->num_syncobj_handles;
>  	ptr = u64_to_user_ptr(wait_info->syncobj_handles);
>  	syncobj_handles = memdup_array_user(ptr, num_syncobj, sizeof(u32));

