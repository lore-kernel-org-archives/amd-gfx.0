Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A0606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rWE0CNdw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C0410E75C;
	Tue,  3 Nov 2026 01:40:38 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481B210E75C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 01:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNCzp5xLYtHlHcwWpJxxtexspP1wamdJ6+Oe0hMtgoALkYmG3pwKs9290QoT5RbNRPF9BKcpZ+KdTffOIxCl0BZcP2lB4Nx5PI+A4oxgWwF+0exJ6Y4DvcTh/ckk8hIZUvZxh/V/Dpk+fEvBNukARhi9uNaHG8pFLd6UpIOUL91LSWelzKrL4hGF+KXJo7SfNaJXCe7Nepqj6dRMXXbTSPh3p7jKxfRWUNI4H0vO19Kmu+4th07ObwbLgQeTIEGS8ArTpr6fxAABNmH+4QzBu2JIfYtLuTyye1fumXcV28mUc/Vwlj0/+wAQQ96qeujG67HIwgZiFR4zOqcKjA7wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgMTbZ1sp+zwppVyCzUNtETzPwqpsm17MhCZeU98M9Y=;
 b=NyMjjMc8zoVieMVZHpf/UAyfLkUAwPR7z75SLQVxybDnKeW9N/5fzFyT0Bzfb1MGr0u+sbBqdlTb39K0Fb5Gwumk7gopUljixwpTCUkc4faLzTceewv2JX4OYrvU/dh0POD2FFlsLXftTd6f9XhshaZuS3JGywGleT7igHPiIyQFy/93CfUSRWtUQUCoCCooEram437g1envQTKcGQS8KElSkuefFVK4s2Hfb6Uw37nk7To9XDpZ1UvQjbKks4YtyfPHqhAYjwGUJGPXVIJXXd+iiDGLdb3q7DUqaZYHb/jFIFDn4C/ubs8Laf/7WHV81tClRYvPj32BBOtXw3ojiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgMTbZ1sp+zwppVyCzUNtETzPwqpsm17MhCZeU98M9Y=;
 b=rWE0CNdw4b9wE6Pd5q7pIXU+/jY15MsMILWMhgT8F+p0AME6DkrCsXvnYPGnS2TLv35Ng3iEqHsuDeCdhaapMnenqidxAgJpqBW1v/agLN+D1xKlaej8Aaws+qRtEVQctDDF6CgkhVBrs6mT9mY4fjGweN42CrwA5i5/EINJB5E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7) by PH0PR12MB7932.namprd12.prod.outlook.com
 (2603:10b6:510:280::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Tue, 3 Nov
 2026 01:40:23 +0000
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7]) by CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 01:40:23 +0000
Message-ID: <8840096e-a76a-4578-a9de-b3b716b0e755@amd.com>
Date: Tue, 3 Nov 2026 09:40:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amdgpu: Correct hung queue number for reset
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20261027075017.121456-1-amber.lin@amd.com>
 <20261027075017.121456-4-amber.lin@amd.com>
Content-Language: en-US
From: "Lin, Amber" <amber.lin@amd.com>
In-Reply-To: <20261027075017.121456-4-amber.lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB504406:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0759e808-9ae5-4913-2def-08df394b6d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|261102123227099003|56012099006|261026121527099003|11063799006|4143699003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: B0MTWKCg0drpf9snwYM5PSr6UkDpsYsXnmIUdbQgkvRi99ouKYGIQ+YChTAeAwz/HUVlHZvoo1ecaDqTdFBLOVbNg3IMYg0TSoQohPJIRFoFPR2Lwk2bSA2inuvpBCZkMziW12rJrUqkj5DRJ8JcuY0JOXGr7mx59vwtPQ6vOf8dsm0EPzR6bMyGBtu/Z6CR4DNRzDtCk4f9sjUC9Hn53scw7NPxm2Fwzv9UTDOHWbeCAjMfQEuSIIXufjP88mbPOJzTiqn9i34d6HALX2sSHmGnGYiDc9yJqSJp+qxJ1ZyBAqWg5FTfRkWTR6CF0Go+2NnsvaSyIQXPqqTubzboroGf3veqcv39T7f9Cib6wh4O0U9QTJP2CiMJC36cQjMRwVpbz+/s/YLSVWWx0L4aqe1Qpp7NxsVYYxBz939TAii36iTfyvv3i+QZXaY24AI5cUpK6YSzV5jqvQNInILipwBg8fqsK2Xzx/PI9sncyhLIhjs7/gMwqwi+szW6+6AojrztQzYfr+6jPJigMppA8xyf7PTujnPNJfKINsesIXlkp21vRl0gsvS81enDT1o8GWbkh4SeN0lX6R/bziGSFayTXNReclDC9N/ZoIB0Dq5WlARYPWfK5NWoDEKFYE1ZnmMhw759DysTCZdbC37G79pMI/6GACYrjwfldh2jZrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB504406.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(261026121527099003)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzN1QXVsNDEwMW9iVlowNk14eSs2czRCaTF4cHl1Z2kwbGFrakwraTR2MURF?=
 =?utf-8?B?Rm8vL2hlWFpaL3l6dkdrbmxYRjdPZWFoa1d5WmN5cllha1pTWGwxOE9ad0lK?=
 =?utf-8?B?MGZIenlIQVczRE9RaERnTC9CR1Z6ejN2QjR6dVlVWlFJOHFTeCtTclNZM05a?=
 =?utf-8?B?b1NvWFBXdVovYXBRSkN4YzdldC9Yc1I3NEJkeEtjb1hYSUNHYlVscXhxRFNR?=
 =?utf-8?B?WU5tWjUvN0pvZ24wcDk3OGt3Zld2bkp1N1FyR3dHalowaWN5dm5ROFJmN0N4?=
 =?utf-8?B?SGFuT203anR1TlhUM3NSRFRZV1RPMWJFdXJ1aXg3ZVBsOFZwUVUyQXlXTE4v?=
 =?utf-8?B?bVN3N3MvQlpIc1lsQVZkeVVkUlVTTkc1RC83YkUyUzdZUVhHbGQ3NVdaSzhh?=
 =?utf-8?B?Qmg1bEs3d3hGMFJxR2F3R0xmV1hMWVZnanBRRGJiSFRBWU04Y2k4SnFaTDhG?=
 =?utf-8?B?SFVXZFNkZW1oV3BSWWpVTFdwUE1zaGk5NDVRQUZkZDllS2JuNStUMFViZ3hr?=
 =?utf-8?B?KzUyenRCZW1MTTg2OFdSMWJpQXpnMDUwdWI5THBpbnJVRFkyRnlDM2hIZkIw?=
 =?utf-8?B?bWF6cFZVRi9Wb0tKaFJTTjRheHhVYVhWWEF2ak1BMDJmb2IwaFJkVnNnajVH?=
 =?utf-8?B?VmROemhudXNaNnVmdy8rakNZNjBhYnFDNTZIeGNMWCtaUjZ5dE1MQWVncGtj?=
 =?utf-8?B?Y3Q1a0VRdE5ZRmprWHZ5Q2gzWlN6T0JFVjUxNUgzSTVYYk5NOVF1dlhJaDhV?=
 =?utf-8?B?L2hTN0pBN0MxVEdjclh6M2Y2ei80RlNyaXRncnM2cFdnOFBNY0dLa3VpZDRk?=
 =?utf-8?B?aHovRitHelB0VmNORzRLSGZ0Zk9rQitiN3VGdC9SOFlLNFVsWnhoM0hWSC9S?=
 =?utf-8?B?RlVSc21TUG96MmFVSWNLaHRxbmhheDVITzBkZ1BWeVF5MWNNa2w4eFREUFpj?=
 =?utf-8?B?YXFOVWp6dUd5WE1mYURxNEZhcmFMaGNjWlhZWURtd2VVaUdSUTBJdXl0aTJ1?=
 =?utf-8?B?cWRPY1RQNk9HektXUUF2ZmJTN2dPM1AvMWo0VE9LN25kWEkvR1RMcXI1TEpp?=
 =?utf-8?B?bDNFU2xjbzJGc3ViM0hpOFd1TWJZdjdmSDRwN2F5bFBwT3RLZWdnNi92dGlm?=
 =?utf-8?B?SURWZyt3cDNERzhYRnlDZzh5RFpyUTBmMDhOYW1aS3hwck13OEQ1THZCVGhH?=
 =?utf-8?B?OXVvc0M1b0F2YiswTFdlNzhRQjV5TDRhOGdJLzd5aUhiQndyamM3QWZPaE9m?=
 =?utf-8?B?Q0M1VnV5ZkJVZkxSdGpBQ3dBUHJ3SEVDMFJHTEtoTm5VcmFJbU9pczh3aEta?=
 =?utf-8?B?Y1RYMGdpcTlCb3FvSnA1NkFDU3BZNXJjcXhGc2pzenFPZlJqR0h0NzduQlJC?=
 =?utf-8?B?c2s1b0diQ2hZV0JEMm02QzdORWVWa3dKTHNrS1VOaU5RazlLWUVQNFlHUmdw?=
 =?utf-8?B?Ukg2MTdKV2hlYzBBRjNvZUwrTzJxOFhJMzh1aHVJSTc2ZlZocUNBcnkvam9W?=
 =?utf-8?B?SVorZkhDRHpiajM0clZQUy91LzJyMXNKVTVydWVhNmFTK1JOVWFxWU5vZUVS?=
 =?utf-8?B?QWpFdG1ieWFlUzU0dlNDdXZrRWVaWUpXaXdBbjlOY2lOVi9LVjZ5blpxMUd2?=
 =?utf-8?B?aS9ud3l1TzR4b0xjeE5OaVNLZ041YXV6dXJkajdSQzFPbU9KQjg5YzlzUVcv?=
 =?utf-8?B?L3hCY1BzSHF0QUtoZk1zN0VkYUsvWWFqcEU4am5ZUUgzNHFaNEJidzdVTUxh?=
 =?utf-8?B?aG16NTRPMTJPV05vbmd2cGJZZG0yMUxlMFRQeURhdjl3eUk2WlRmUnl2ZmRl?=
 =?utf-8?B?b2d2VmpxLzF3SWZQN1Jmd2g0c05Wd0pHVnRQb1lDYjJsNzFDQ3Z4Mlh1b1Ey?=
 =?utf-8?B?K0o2aHVSOVJVUW4zbXN5SGJNU3Z4Y1hZckJZZk1zNm9mbE1ibVZyM0tzTXBX?=
 =?utf-8?B?c2MrMjZvWHhGZUcrZ2pPVFdRL2hWNmRpZTUyMjZENVFvRU5qbHkySWNLM3lP?=
 =?utf-8?B?TGQ4dXR5cGlEZFlicHR1M3ZjTkViTVJVRzBOdkEzc2ZyNzJ3T2JhNXExL0F6?=
 =?utf-8?B?bVBnWU1NSWMrRUhpNWNmK1pjNThOT21LSG12YWRQR3ZScVovRGV1Smdwdkcv?=
 =?utf-8?B?ZmQ4VU5JS3V4Lyt3WHBva01Tb1N0VVZCa1Zwa1Vqa3B5TTdwT2UrRENpMnF6?=
 =?utf-8?B?Rmh0aTNzV2lTVHdPZ1BURGkwc0RoRFd3MWJOYzNsTVU4eVU5bThtNzY1SHBa?=
 =?utf-8?B?Q0Q5b01HY0VITDdpdVZxc1ZIZStMaTM0V3kvd3c0ZGJRK3J4MGErWC80MlVS?=
 =?utf-8?Q?TahVAx9SA/fq2Vfcev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0759e808-9ae5-4913-2def-08df394b6d51
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB504406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:40:23.0113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qd6csw4b2vL6xHUhqlpJxcVcZ4k+j3wBkE9UkOOI73+OzGnGnrF/U83YIUdKd1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping

On 10/27/2026 3:50 PM, Amber Lin wrote:
> In an ASIC supporting multi-compute partitions, the number of queues
> varies with the compute partition mode. We need to adjust the hqd_info
> offset to get the correct hung queues doorbell offset and hqd_info.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 49 ++++++++++++++++++-------
>   1 file changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index b58a9ffef4e4..d81e613081c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -108,6 +108,24 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pipe,
>   
>   static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struct *work);
>   
> +static int get_num_queues_per_xcp(struct amdgpu_device *adev, int num_xcps)
> +{
> +	int i, num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
> +	u32 num_queues = 0;
> +
> +	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> +		num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
> +
> +	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> +		num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
> +
> +	num_xcc /= num_xcps;
> +	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> +		num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
> +
> +	return num_queues;
> +}
> +
>   int amdgpu_mes_init(struct amdgpu_device *adev)
>   {
>   	int i, r, num_pipes, num_queues = 0;
> @@ -222,21 +240,19 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>   		goto error_doorbell;
>   
>   	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
> -		/* When queue/pipe reset is done in MES instead of in the
> -		 * driver, MES passes hung queues information to the driver in
> -		 * hung_queue_hqd_info. Calculate required space to store this
> -		 * information.
> +		/* When queue/pipe reset is handled by MES instead of by the
> +		 * driver, driver provides the buffer for MES to store the hung
> +		 * queues information. Calculate required buffer size, which is
> +		 * the number of maximum queues. This number varies with compute
> +		 * partition mode. We allocate the biggest size, which is SPX,
> +		 * num_xcps = 1.
>   		 */
> -		for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -			num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
> -
> -		for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> -			num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
> -
> -		for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> -			num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
> +		num_queues = get_num_queues_per_xcp(adev, 1);
>   
>   		adev->mes.hung_queue_hqd_info_offset = num_queues;
> +		/* Double num_queues. The first half is to store doorbell offset
> +		 * and the second half is to store hqd_info.
> +		 */
>   		adev->mes.hung_queue_db_array_size = num_queues * 2;
>   	}
>   
> @@ -526,7 +542,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   {
>   	struct mes_detect_and_reset_queue_input input;
>   	u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr;
> -	int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
> +	int hqd_info_offset, r, i;
> +	int num_xcps = 1;
>   
>   	if (!hung_db_num || !hung_db_array)
>   		return -EINVAL;
> @@ -551,9 +568,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   		return r;
>   	}
>   
> +	if (adev->xcp_mgr)
> +		num_xcps = adev->xcp_mgr->num_xcps;
> +	hqd_info_offset = get_num_queues_per_xcp(adev, num_xcps);
> +
>   	*hung_db_num = 0;
>   	/* MES passes hung queues' doorbell to driver */
> -	for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
> +	for (i = 0; i < hqd_info_offset; i++) {
>   		/* Finding hung queues where db_array[i] is a valid doorbell */
>   		if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
>   			dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x\n", db_array[i]);
