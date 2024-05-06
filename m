Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D800CC25B4F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 20:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C3110F28E;
	Mon,  6 May 2024 20:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NWrq/zSH";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920EC10F0DC
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 20:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfeSR+ZeKG25sUHncqVuldw0dIT9XF1z2hy1Gzs23/ablEMg2ogFNkYOabGDcNGk8BJf4fFA31rvYDIVXU/toXuYi278Jw7/n21b5JT5qxeAaLuCGKde9OD3ps8PahUcC+Vx84TqD3Foph2PHV2Txbu7P1EZiSMj97TyLSetj+sEgDrFxnfm+jr0ArX6FBF+gCvhxUFLkY+Z1R2UafZlTM2IlX6F0mEUbpsyAD1CaForeBK2aaJ6GiB+zdB3AWFWlsQxqOs5z0D1OFYIdVJaPuwjmI6tpUPgmi65rLmU59SYnWT6j/qXLHFgT/8TaIdAB6vX6tL1GxlApc9VWro08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvNI4g2AEaUTLXXPK3NInvtYyR4Oa8F5CrnfClux6gk=;
 b=EpvJOaiWMfMCvMhDKnVbbyiZLfBsFJ8rVmFPkZnHxF6p1lusJLWUeQbNylaoH3719U1cvsGTVpTOU1mWStQOSgGIRwXYjkvOG4631lzvA4M0EcPPKAfUvGdXABONLqYkQk9ox0hcjDI+A0klsTou3zWWJyFXi+BIbSaEwA4hoZXxIAeh5RSV/CXLtK2s9kzWsZOfhJy008ILnu/39eci69unPzQPx+9xOTjP/RbHtFvBkamNZLrhhtieEZSj12lPPOJLqY1gciDAjgqyrAI5XUFMYTb13ehwzRq6u7KL40DJp7k2QyoBk1Ff8wILyhOhNm3XLs7r6Z3tUAISQIOtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvNI4g2AEaUTLXXPK3NInvtYyR4Oa8F5CrnfClux6gk=;
 b=NWrq/zSHOl6TEGg2y7mLGqRLwfm6eGYw/VSC/xAhSYdrL+OH6GJz9gFZ2zHUa6AaPNa2lvCp7hev6j5H6Vg5QIjZcyMdmx4e72cyU768yqyb495y240A9flx22MgdyIz5w5vhIYDQN2s04ZnsQC0K5GWJu9SK/xPB8T2SWw42Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 20:30:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:30:56 +0000
Message-ID: <64bbdff6-1944-41ea-85b6-d836165c9952@amd.com>
Date: Mon, 6 May 2024 16:30:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ensure gpu_id is unique
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240503220639.335198-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240503220639.335198-1-Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f55c52-14eb-4155-9c4e-08dc6e0b6db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHpWeVd1RVFpU2VGWVB6RjJyS1lBRjdaRTZCZ3NXTE5Ub0lOcnQvd2Nydmds?=
 =?utf-8?B?MFYyQy95Z21rd0hFenpEeDhvRUJwWnlkK0xVa1dkaEhNSDgvbTN5c1RPTVJu?=
 =?utf-8?B?Q3hOV1lOY0hhdkZZSmhFOHRmaDdxa0M0ZUxsRWtSSUppSU9SUkd4NnJnU1d3?=
 =?utf-8?B?SWRwK1ZiQTVJTTRNT01OeU1OdlpuSHhSQVlMUTkwL2JDd2VJbUtNRUxwd1pM?=
 =?utf-8?B?elU3c1Jsd0tQREN2VVhKNTU0cEhGUTNqYmV3d1B4M3pmeDMvQSszSUhuT09N?=
 =?utf-8?B?dC9iTjhLU3AvalJCOFRrRzlGUjQwTGo3MHFYT3UraTl5c1NXT003ZTlZUTdP?=
 =?utf-8?B?WURSQ2k3dmlHUTZ4L0NnUkV6V1pUaDR3eEVObnNBSHZ1cjE5N2ZxekJ4ZERS?=
 =?utf-8?B?SC85a0hlSnpwcStKV3FBU0IzZ3lTNlZkeWFNM0JUYWkxNG5yR2t0MXZiRytY?=
 =?utf-8?B?c05xT0JlQ0RUaHRkZG5mZkJGUUZrM0VjYmprbEs2R3V1NDJPVlZCMEFxMnA5?=
 =?utf-8?B?QUl2OUtxYUdqMmllcmxPU1NSaHU1WU54U0hncVE4VzBmcXJPSTRORU1ZOGF5?=
 =?utf-8?B?M3RJQVFpWU8vUXo4cG5aZzZ3MEtJS1hjTW1lRmVYc2pXV0ZTTUpzRHlOZUJt?=
 =?utf-8?B?aEh4elVzbWFwMmdPR1JqL2NpbHFBdks3TENDSTdYaDd6dHVFMUloUktWTlBy?=
 =?utf-8?B?dE9maUJYRDB4dFJLUWFDdnV5czJld1BRendOeHM4Z2ltNHRDMmRzZk9FSzE0?=
 =?utf-8?B?L2RMaDkrU1ljTlExbzhTM2xJSXhtU1RJNEQrQzZKeW9welJCMW1taGxpSG85?=
 =?utf-8?B?Ri82RjNLR01hVFdPUVFzMDVkTDhmM1lVaktmbW1XeHZxdlB4YXhyTXpGZkNY?=
 =?utf-8?B?ZzJGYWk4d21McWFXS08vWmJ3ZmpWdWxuQTVmUi9vRGZrcUJSYUVvL09yNFN5?=
 =?utf-8?B?U3Vqd0U4UHpiQ1JhQWpHMUpCUUtOT3FDUldCLytkZ1ZoYk8zaFFhM2xQT3Ji?=
 =?utf-8?B?RW0rMWNmTTBlaXBKdEtMeE1HNnZSQW9JVjVDNnB5eFpJbVlCNW1GcmhjV1Uw?=
 =?utf-8?B?VTlVSXVmUm9BbmU0T3A2SnhOcEVwRGpoWjQ5QUF1WnRjSWRYYWU4WVlyY0No?=
 =?utf-8?B?Tm1tcU16NFlQYzRGeERJRXU1TnVFUFQxZHJIWW1vaHJwYWU1eVJNTW1LdStZ?=
 =?utf-8?B?T09mTzM3NnlaZmIvblJWS29MSG55bWxuaFp1aENhL1ZYYXFKbHJZS3RsUVlN?=
 =?utf-8?B?RXEvb0I2QVFlaGgyTWwzSlE4bUhrUk83STJCd2lOcW9zUVp5bjh4TktaWnpv?=
 =?utf-8?B?WjNZKzgvSHpIWDQvM2FuVFF1cFVSb3JrcTh5SFpXRXY1dWpjenY5NEF1aDFy?=
 =?utf-8?B?YzJSTkpONXJ3VWtzQnlLTFlESkR6VnRWY1N2Vks5OHN4aTlnR0RsOVBQMEZZ?=
 =?utf-8?B?Z0F6dHlrTVVTNVhRRm9icGI4TlNCaDE5b3Q5VnhZRXRxSWJmcmtJakdZNmVM?=
 =?utf-8?B?TFh1cmluRjg0VXlGUTZpNzJ4TTB6TWcrVkZtaUxINGozdTFZSFM4RlRaUE1s?=
 =?utf-8?B?aWxNWkRrOERIY2V0MERLbzJESXZiV1BUQjY1VHRNUFhTWGRic3FIdW80WStP?=
 =?utf-8?B?cVY3eTQvN2ZwNUxWU3RTYjNmbFpTdFNZMW84TncyWlZFUVExeTNJZDdWRkU3?=
 =?utf-8?B?R0lZY0d0R2hqaUhUSGptL25PM3l3aTE5VWpNMzV3NUdPelpRR0YvZzVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2E3ZlpsbXlnKzhDNHRkRm5FWnp5VE9oNThNQWlhL0NOdm9HWDQ5RWdxTURx?=
 =?utf-8?B?ejRKb0l3YmxObDh3Y0dodFdYUjNpRVJtaTY5cHVmcWlMV2xMK3haTnJBWk80?=
 =?utf-8?B?YW84OEMwMmpiem05OU9FTnVLdWVWS0pRWTRwaUNFVUFFN2l5eEZmL3V6TG9I?=
 =?utf-8?B?N1ROejhTdXI3OVhwL0xVZEdacWFzS08vem0zUnJIMFJNRTh6TStmZ1Y1WVJY?=
 =?utf-8?B?anMxV2l5L1pHbmx1L0dFUUN0QitkSTNEQldQWmtQalZoLzE5SEE1bjlldENm?=
 =?utf-8?B?Ym5qakF4L2h6cHB0TmlORXBkMnhkWGFaZFNGckczeHBUZHRKbFNmdzVYcnQr?=
 =?utf-8?B?bUJFQ3hOZkh0N2t1TC9PRm1VMGVCa1BEUWFQQkQyVW5HVHdJR3dKbFQ4aEd3?=
 =?utf-8?B?ZUdKN2hVZExXWnV0dmp5azVoV3I0RU9TVVRiSkdtcnpOei9IZ3NnTFFQZ0Fm?=
 =?utf-8?B?NjU0VEdQK2ZaWDdFK05wQ3hEWWNyMWhiUS9Ia1RQMkxoOGUyZnlnUG1sSzRZ?=
 =?utf-8?B?bjBXaGJKZUphZHkwTFJYLzlQUFR1bUhzU0V2S0NrVXlYcXZMMzNUMzFSZjdi?=
 =?utf-8?B?alI0QUhzc3djbnRUY0h1NG1ZYTR2dnloZEZSZ05KaU5uMHljMG1OcDVtZGJP?=
 =?utf-8?B?dmRjZjdTQjR2WFEyOWJDcm1YN0NjNzBMVmt6VzlYR25ZaHFzOGtKNFI2czFn?=
 =?utf-8?B?TTRYZHNVZERLcVlFSWYzbW91MWZCWThsNWcyd0hMSlphKzd0Mytmc1R0S0wy?=
 =?utf-8?B?Z202c2gxVkpGUzhDWnQ1NGVMR2tLejMvaldQc1k0RUlpZjZEM2dKQ2dkYTZu?=
 =?utf-8?B?U2RicjJYWC9zeTdBMDAzajRXRnBjTXIzMUlGNWZGb1VNTUtQa2h3TTFNdnVq?=
 =?utf-8?B?R0NBZFVPcXFaanZHS0g1YlBGdktKQVV2YjFTc2tzRzBRa1JodkVQQ3NrVDN3?=
 =?utf-8?B?ZlBRUjNMWXptUUl6REhIT3o5N2FBQ0pVOTcveWoweitEU1ZwQTNUeitjbVVw?=
 =?utf-8?B?TWRza2ZQR0dWblVSL2pNTzZXK2JMbDg2RE5NY2VYWWhpRlpBeDRRVitEUGVs?=
 =?utf-8?B?Wk1Fa0RINFBRNTNtRUZhNXZXdE5lMWxFb3hiOGFiNEZvNHRleG9GTUhKM0Jw?=
 =?utf-8?B?cHZoaTkyY1hQVkVDYVVPTFVCbi9pQjZPeVhXTkZIZDZwdWFPTENocnE0SGtJ?=
 =?utf-8?B?QWd4elBkR2Q5ejhWbFEyZVRyS2ZUUEdwK0VrbzZCVmVlU1A0SXN6SnNwUXlr?=
 =?utf-8?B?LzZHQVlZb3licWhDcHlmRWJldHlHM1FZSkFHdm5PMnhTMStPMFZPdi92SjN3?=
 =?utf-8?B?V2tKTFEvc01NWmc5TndTc0dTdW96SjZhU25BaFpXa1d3YTBmOEZKazZKc3hU?=
 =?utf-8?B?OGExa2dmWm9zNUFGNzI1Z1FFcXRGNGN5TlpPQ0N5SXpydGlWQk9hckc4cFhv?=
 =?utf-8?B?aFh6all3ejRqQzJ4UVJZNGl4Mm1VK3ZzZmFGZFV2WWEzT1N5K2xBMDhTVFdj?=
 =?utf-8?B?YkFJL3JmQ2VGTDVneGl5UkhPQ0xNZmVvZGJHSnpqTkpvTm1uWXQ5cmdZQUZr?=
 =?utf-8?B?VkVNNVBwYWd2Yk96anNScHdWZ3U3c2s1dDQxM0NXenBFM043TkZQTXBYajcv?=
 =?utf-8?B?b0JOdFpweUxJTXJ2ekhqa1IrOXdDNnVJK0ZHbmcyd1JvZ1UwcFRtd2VUUUVI?=
 =?utf-8?B?b29XZzZXWkk4L0FZYkN0VVdTMUtSVnY4QzJ3VWU4cHRZNXVqaXFBMGF4QURL?=
 =?utf-8?B?NlpNdVdTSHd2V0lZd2MvdG1LRGRIMWYzZzBRRHoxSENlYy92WXdXWC9odVRk?=
 =?utf-8?B?N1FmUWJKb013UzIvbTB6MUtWemZ6ZXlDTW10WWlqUENIT1dFMnc5bDhSMVVX?=
 =?utf-8?B?N2tzNFAvbmRmV2RXYjFTa0dEOXdIOXFaWnpzSTFFQUVuM1hTNGR4V1NpdUxz?=
 =?utf-8?B?aFdlUDY4WUg0eUliUTcxQjkzWnc1RlFnU0dhelJYS1dNOTgwS1N6Q2U0Kytu?=
 =?utf-8?B?Nms3LzlsTVRUNERWdGFFVklJTXZVTmlBdklyd0liY0JZMzRRcmY4ZE01REFI?=
 =?utf-8?B?dEsxanFURkVEVGpqV2FjY0p6Z3NwS1BHaFlKSElUcVk2dTU1Q3ZEaElhRVpF?=
 =?utf-8?Q?NIjrFWzuJm6IYI24Ur0Bybe6s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f55c52-14eb-4155-9c4e-08dc6e0b6db5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 20:30:56.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzJlxjbKVRzG2vHT/ByURW1xmXvq9rdevlu2P1xJviSWTiJcwoS3eQ6AgJwNQskTNMXsNILvEfkAIL6IbreOzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
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


On 2024-05-03 18:06, Harish Kasiviswanathan wrote:
> gpu_id needs to be unique for user space to identify GPUs via KFD
> interface. In the current implementation there is a very small
> probability of having non unique gpu_ids.
>
> v2: Add check to confirm if gpu_id is unique. If not unique, find one
>      Changed commit header to reflect the above
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 26 ++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index b93913934b03..01d4c2e10c6d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1095,6 +1095,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>   	uint32_t hashout;
>   	uint32_t buf[8];
>   	uint64_t local_mem_size;
> +	struct kfd_topology_device *dev;
> +	bool is_unique;
>   	int i;
>   
>   	if (!gpu)
> @@ -1115,6 +1117,28 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>   	for (i = 0, hashout = 0; i < 8; i++)
>   		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
>   
> +	/* hash generated could be non-unique. Check if it is unique.
> +	 * If not unique increment till unique one is found. In case
> +	 * of overflow, restart from 1
> +	*/
> +	down_read(&topology_lock);
> +	do {
> +		is_unique = true;
> +		list_for_each_entry(dev, &topology_device_list, list) {
> +			if (dev->gpu && dev->gpu_id == hashout) {
> +				is_unique = false;
> +				break;
> +			}
> +		}
> +		if (unlikely(!is_unique)) {
> +			hashout = (hashout + 1) &
> +				  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
> +			if (!hashout)
> +				hashout = 1;

This doesn't catch the case that hashout was 0 before incrementing it, 
and was found to be unique.

Regards,
   Felix


> +		}
> +	} while (!is_unique);
> +	up_read(&topology_lock);
> +
>   	return hashout;
>   }
>   /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
> @@ -1946,7 +1970,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
>   	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>   
> -	gpu_id = kfd_generate_gpu_id(gpu);
>   	if (gpu->xcp && !gpu->xcp->ddev) {
>   		dev_warn(gpu->adev->dev,
>   			 "Won't add GPU to topology since it has no drm node assigned.");
> @@ -1969,6 +1992,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	if (res)
>   		return res;
>   
> +	gpu_id = kfd_generate_gpu_id(gpu);
>   	dev->gpu_id = gpu_id;
>   	gpu->id = gpu_id;
>   
