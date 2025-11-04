Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19C5CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 18:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6009710E2A8;
	Tue,  4 Nov 2025 18:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OEAJfEOT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842D710E2A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 18:07:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7yxCDrNEVPXD70lLudyCzR18VQZQ6r72MAui9dDuOJCWrJfp+X2IFM840i/9bnuwwSRYfhpVlvy8OHqeL824KwLuaUzY469WJ0PdUh28I8CAJQKgp/nPUmk4aiBc6tBMoSdSKbda5uOlNqXmC7G0HczEKLfuta2l2zNyKoCM+TrRXtSZejhcZTXz0argVVTTZWl+HWNZC1gq3Pqv0/0OFSg8quZwvdlLNWd5pRqBthoKpADsDGn65pDQkOLPbmbEUVhenUz5OgyK6faECzySOvP56VgTV1NIQ8Qn1nvH5uLIsjo5N0pqkChm2e+tnHIsiDRSvl0fAYR7HLZvaPT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5Hi0fYRqfwnbylPVKbRUK7JTbrueP5CxxsV3OF8qEI=;
 b=L11twdwYz0Vx6d0HlD47PrnxB2DV15aYKzS4a3mRqB3Lya1NfP0PtapvxGrvYfjoOpoPl+/uj7i6S+6bpiHY308qYSz7rxEV14Uv3d/iDcsrZy4BK57xXsKS9KpO9rhp1H0O+oBBPapROvdB0BxMz6+kryYj/ERlsCToE4c/DJc/0zb0FN4gq3Ukp29PDyzKOpzLT7oxSS8rnKTgfdYn/UgpLhV/ilZNxirGblu656t97K+3B81F/2F0sZzH1pW1wtqNK8cx61JSRZl/fKA4LATHmXqeNn8Jsr0bjbn4iyHCcduPEaVmIGAMcWfUi/fOIKRmiyK/w0t2sA/RNgiSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5Hi0fYRqfwnbylPVKbRUK7JTbrueP5CxxsV3OF8qEI=;
 b=OEAJfEOTFpBznpHNDX6HWSg7Gl2FbidE9QO+0ADHa1VbZvuH3txRDWkRA/U6pD8w5LAFmGO1uKvEZzYOrkOTCpM7V/fm+rOG7y+65SbyqPhd8oUAlqqUN8YeUSpBVvUAHlTFIPz4De9louMtcmR+XDOcwYIIfx5bgRoWbpwASz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:06:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:06:55 +0000
Message-ID: <65bceb8b-3088-4e72-8606-5bdd02f02061@amd.com>
Date: Tue, 4 Nov 2025 23:36:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Do nto wait for queue op response during reset
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251104173325.1381513-1-Ahmad.Rehman@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251104173325.1381513-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fea5570-52c7-4aad-5f2d-08de1bccf031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkxFazJkS0FiTnBpTVp5VWdFNXY2bkIvbU5XelUvVVBRcUdibXZnT2lBNndR?=
 =?utf-8?B?RE5vYWhYKy9zc0Z5VnAzbDFZeGgvbTFFY3E4UXY3V1JQWlpSZEZINGlDNTdm?=
 =?utf-8?B?ZVNYUUwzSzR0NWxHdWpIbDdMcm1Ob2VNZlJoY0FkWEcwWVVFd05lOXV6Uk9h?=
 =?utf-8?B?UTdvL210QXdybEtzYkRXanpqSkRoVkhiQm5yNXF4bnlHWW1lYjIrUWNhVHVy?=
 =?utf-8?B?bWdHM1FUWnBhMGpNRnVLMjdMUzJUT1NmcFg3aGF6Tmt1ZjA5UFYzVG4yVWhk?=
 =?utf-8?B?ZnZ3S21lMmRMaGs5ZFp1ZGdGMnd4SlM3bHRGdm1SZTNSUnNYMlRJdG9tSkRE?=
 =?utf-8?B?WWdzd1BUZldlMENCYm83Zk9idDdWaThkZDh4eFR4RS9DMVUxakdwai83bmc5?=
 =?utf-8?B?YlYzK3RKeXZrZmdzWjlKb3d1dmE0WTVJcitrMDdEdFZIYSs4RlFrVEJqUWNV?=
 =?utf-8?B?YmJudTVVUTJCbzhUcUp1a0l6c1gvNytGYmxSWVB5SDM4Z1BHbG1hT2xoWUdX?=
 =?utf-8?B?Rm4xRklTVkZKUjdzcGpXWkhiTzVEZDVka1h1Z3dwcDhtVmlFbE9IeVczTmZF?=
 =?utf-8?B?NmIwQThlbHFoYVRqUDFoWUVVYS95VjRaTmxCejdwOTNGZDVwMmVNSWtRdzht?=
 =?utf-8?B?NzEzaVRTSUdpcTJiM25rUkY2NXVWYmhremYraDBnem9RREtjajQ2UFhpRzZ2?=
 =?utf-8?B?ZHBkRVdTSHQ3MlZITW9HaTdkUnJMRFFMeXlCUjFEWUJ2VFpNakRlQVBNNnU1?=
 =?utf-8?B?Qnp3THMyaW1xTmRpOVk1L0o1c0o2andqUUpndmo1WjVjOUp0Z2xqTURBanJu?=
 =?utf-8?B?eUVNL2RLOEMzVi8waTVydXRxcCtKdnV0OTZnaitiWVZ1dGRtMXBMdTRqME5Z?=
 =?utf-8?B?ckRaWjhDdTV4a2lCMTBHbzVkTGJZUVRNUnFnZEI5d2VGVkFlRWo3clArTzF0?=
 =?utf-8?B?ZW1qYlc5blpvbjA2bWUzUjB2ajJFMTFYYTBNV1htS24yd0ZXaC8zTVgxTnFn?=
 =?utf-8?B?NkhCWk9qVm90d0xLREVkb3RzZ1ZCd1JNN3lkNzVJaG1waGFUcDhic2YyNlVa?=
 =?utf-8?B?enpLQlJQSFQ3RzBnQ0w4NmpTMnR2Y2pBK3phQ25tRjNURE8rWmtORHNwVmwz?=
 =?utf-8?B?QTdQUEplOFRsNVlLSUVTd1NyRDhxYjZtaTNqQUJFaTFJZUNHMTZEbmNCaWdE?=
 =?utf-8?B?bVp3M0doNnlQWWdUNEtVN1NqWjRBWU8vbGdOVXFObmFoOEpHS1FlSTNMTnJF?=
 =?utf-8?B?bUtCOWVZSk11L3RVQTZJU0dvR0VVR2tETHNTUVdVeFhIcFdnbDJWQXByZysv?=
 =?utf-8?B?OTZrUmQyZVlUWUFNdWJ6QWNhbmdsT09UUFRCUnlSUmRPNEZMOU9DbHZ4R2V4?=
 =?utf-8?B?WElIZy9INGZaakx5Mm1oVDRpZVJkd1hITjcwWlBHRSt3VytvRmRpQ3dVZ0c3?=
 =?utf-8?B?RFg1YTdRTVpQNDgrUDlpdWw0VWxhKytseDhMMDVLRGlRRmFEaVVuWlZFUWRM?=
 =?utf-8?B?OVl5U3VQM1JPZ01DUWhmcE4xMkx0TmFJOWxtdXdvZWU5UlNDOTdjMDNuN1Vw?=
 =?utf-8?B?WGdzQWNidG5mUDRpMG1sT1ZPTGZRc2R0TFZWbFpDM1R2UUN2M3d2cHBsRzh0?=
 =?utf-8?B?MVczdXB3Q2Rkb0dheVJsaVdKbDhNMndQTmFYZndpZ1JaQ1I4cUZuZmIwckVl?=
 =?utf-8?B?eTFpK3Z6TTFLeHZNMHA3OFNiY1RnbG1wQ1Y5VG5jelVtaDRwN3AxeXV3alZT?=
 =?utf-8?B?dm9yTVU1b2x1Y1FzYWYxT0JTeDdyYVNIZ1dZVnM5VEFVMFYzK0JEcVYxbTY5?=
 =?utf-8?B?NjVieHUwQzRUaWtsbHlQWDV1azFVTXc2KzIyK3dTRXc0UERxdW0yS3g1bTNq?=
 =?utf-8?B?S3M3V3RkOHlLQjRNNVduOEo5b29rSVhrd3BwWllzKzB6SlVDY1lFTXRkY2VG?=
 =?utf-8?Q?iNtOySwP5F/ch8uwfYoKClaLJQY7KcTN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGIrVkJoVGxnLzBDR2RJVlZZMFZiY3VseDFsZWNLeTdhZE8xd2YvcFloVGND?=
 =?utf-8?B?TXFmZWp4Qmo2UkFsSUl4VDgrbjRiSi8xOFZhZ256MnZNdk5mMFB5d1QyaGNr?=
 =?utf-8?B?RVRiVml4V2FhOWYxb0ZxN1lnR1U3RjBTRWNKTlZLQWRjSWtJUVRUSDRoSUdo?=
 =?utf-8?B?Z2dXRytpZlEyNG4rZ2wzMWtITmh0ekdTbHBQWGtCajlNK1o0TDN6SG9xU3NS?=
 =?utf-8?B?L0ZnOGVGb0l0d1krV0ZqZVlKeThlQjYxUnNTMWl0M0hqRWlrMzBzSTA2YWRt?=
 =?utf-8?B?RlFnTEdTNTFkenJOR2s2MDJDNTJSQ3NNTVBBNGJlSm9QWFlLNjh5Ti93U2l2?=
 =?utf-8?B?MWZQWlY4RXF1bERqVVZnRk9VK3d1ZlZQaWpHbDZPSThJU3NweHRteTA0UlBs?=
 =?utf-8?B?RFRJVEN0VnFWNFNVTjBrZHkzbDRGc04zQTBuck1waXVmSDBJcVVHcXdWREtt?=
 =?utf-8?B?bitjNzRuNktaL3grQUpyZmtaUW55aWp0aWs4ZmFLUzBrQTZlUXB6dDFmVkdt?=
 =?utf-8?B?d3VCbVlQbjFSSmY0L3dVbFM3bUtUK25RWEVVWjdxWnNYdUF2NklyT2syaEZj?=
 =?utf-8?B?RDNOY0EwQ0hya21rNFYvbzJvaEZZY1I4QW1FK1JGNUZzOXBicFIxWGM0SWhj?=
 =?utf-8?B?RmVpN0d0alRQdU5YZ2doT1dPcjRGbGNnSmFBZ2FDSU9sMWxTeHhhVEVOR2g1?=
 =?utf-8?B?cmt0N0IvOHZJSnpFRnR1bTVkdE1IMFJKM0tsY3Vuek1oTi90T2d5aGFQM1Vy?=
 =?utf-8?B?cXZXK0RKbXV6TEtTeDZDT29QVis5aVVxMlIweHN5cVJ0VTlxamFEWnFsVzB1?=
 =?utf-8?B?WFZkSlBRbVFmdEQxcW0vT1NDVVR5d0JiVklsVndoVmdrYzlOR2RyemxnOTZM?=
 =?utf-8?B?am1hQVpHd2JLcUlWcHFtZzZrVCt6VWEwRHhFaHJFd01kMzJlcWZ4a2czS1Zw?=
 =?utf-8?B?bGVvckMvc1NnbkQvSkduV0tuTzVMdUUzRFZqN3FYMHhYckNWbGlGeUl1eFhj?=
 =?utf-8?B?bFczeFNObjBOQUZiRkhLbytRVzM1MitLUWY0ZTBkZW1odHh5ZjBsdXc4Kzdp?=
 =?utf-8?B?c284OHF2UUF1VmhoWUFVTDZUM1l0Qll5cXFFcFFnY2xkU29FMC85OWhJUEY3?=
 =?utf-8?B?NE1PWnh2L2ppRmJacGZzNHlsbTV6bzRwbmJaZjd6VFk4QnMvMFhhcHNVcGN3?=
 =?utf-8?B?UWxUZGlrc0lSQnRpWXE4ZGJKQkNSeDRBRXpjdEtYdW9rUzAwa28xL3dBNmtL?=
 =?utf-8?B?THZaMjc4d2pFS2JwMzRWWWYyOXFUS3JUOGJFbDNMM1RJcldlczM4aG9lQ2Fi?=
 =?utf-8?B?ZmZkZmNRdFprRURlNmpQQWtsbzR5K1U2S3RKc1UrT3F1QmVhNkhPZFpONUJW?=
 =?utf-8?B?VHRWamFnTU1uL0tBQU1JeU9Sc3F5Z0JzZDZoUFJzR1RDbERjMVNIUkIyMUtI?=
 =?utf-8?B?cVRNaWFNYTJtUllnNnRjU0hWNTN4TUptRmo4YzVIRjdjSDd3NTJtQzlrMEI3?=
 =?utf-8?B?WTRQOUt3bk5NeE9Wd091MFNCa1crTnNqZ0xqbFRZYjVwRitKb1VVVUpJcElJ?=
 =?utf-8?B?eXJhRmI4VlFWZzE5cFVXeU1MbHZ1KzRRUktEQTdOQW85eE5jYVJVMmp5R3gw?=
 =?utf-8?B?bkVUYjZvM1NmZDM2WUYwR1RUZy81QUVVcVhhOUdXWGR2UU9rYXAwVXVjdFpu?=
 =?utf-8?B?ZkJQN3FaUlA1UWNxQUFFVjlKZk9FM0t5a0dxdkRLcm50Sk8vc0xibzNuUEhL?=
 =?utf-8?B?bHFtbzJXeEdDcjk1T3FEaEdEWnorQk9wUEdVVzQwdVRyWk5zc2pVSTl6aHUw?=
 =?utf-8?B?UEN3MmQvVERyNGs2SGhyZXExWUE5NTNncXZkek1qUXlIWis0T0NEMjBOSTl5?=
 =?utf-8?B?alhWSnh3aXMzVHpMOXFzTWVoQmVKTktRZ2dlSDNFOWJFdG5IOFNtVktLNGR4?=
 =?utf-8?B?bUcraWIvRm9VMUFOM1Zjdnhabml3YzF0K29vUldmeUR5aFcxc2N0VTdhblQ3?=
 =?utf-8?B?UTY5RXdlZ2QrS1A4SEdlM0JCL0t4ZTZpaWpSbktxUWpxZ0lWRzlHTGNmWXA3?=
 =?utf-8?B?VE9SNjhSR1g5aXhLQ3lLMWdWWFU1SWpUYU9oZmJ0SjlaSk1aNSt3cWkyRFZi?=
 =?utf-8?Q?qnPGF+G7M4Kuzqb079MaDXBDt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fea5570-52c7-4aad-5f2d-08de1bccf031
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:06:55.4054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQeOArYPgQ5H3DrnDEIhvQ9U9yXvQFwllpk52dzEDPlPCz69v2OBOKjgRnXv4OJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
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



On 11/4/2025 11:03 PM, Ahmad Rehman wrote:
> This patch adds the condition to not wait for
> the queue response for unmap, if the gpu is in reset.
> 
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4fbe865ff279..0904c36192c7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2094,7 +2094,8 @@ int amdkfd_fence_wait_timeout(struct device_queue_manager *dqm,
>   
>   	while (*fence_addr != fence_value) {
>   		/* Fatal err detected, this response won't come */
> -		if (amdgpu_amdkfd_is_fed(dqm->dev->adev))
> +		if (amdgpu_amdkfd_is_fed(dqm->dev->adev) ||
> +				amdgpu_in_reset(dqm->dev->adev))
>   			return -EIO;
>   
>   		if (time_after(jiffies, end_jiffies)) {

