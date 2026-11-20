Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749D606A686
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MPgFKKJ1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB4E10E05A;
	Fri, 20 Nov 2026 23:17:04 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6363110E05A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 23:16:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXn74GDnam8cK4kONcOk1K/g6cS1OhQzRMaPt+GBcew0Zuj/9BgnqfbBYYiWN43620bg21y/IghyUDwD5iLam08wc4aw7vXMG3CMYPDqJyF+W8eL0tjIvlSNqNSzeQgOWG51UVRKk/pnYsCTqdzVdNRg2ropy7//tkDc/D3tNv9/JEt8nr0vepNoWZTGL1YWb+dc4B9mFJOxFaL7E9mxaC7Yz2ObhQwd6vP82hX+AmfjJr8W1l4ypLmR7vjFR5gLC5e45cZwzX8c7MkOjNJQmefgWQAnh/XXWFQ9ryrsCZKf2qOjVvBiaDr7opi0C22LlEV14QSeYaPpBQKJFr5H7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8oYUj4L3mkNeJVH9fSkXrSayjaNK/RWcus2o3YVdBU=;
 b=nfiAfxTJZ+wV6fF/DV892StU4soyoythT7oYxtc1N9uze4/lFGRRYkmd/uLdxUM0jvCRTeNe+vgPpwKkDUhK7MfAaX1VcfBToxnurdN/D4vZNkn4Nm+7frF2arhW5PA2QhY7LV5+jJy79PfxXGCQ/C0EWWbfqEgUoEiAGP7rDmgCNtpLagJAkGu4ZzP8OIk2UL906wuILQK0bdX+H3jxzZugOlsB855S5NqnEWtFQWB8pQWVCtb4kgpVYaXFpF26XAGbgPxwFMrULg+9uC2JCcuL7bVvxzviVwntoGZkVQ8oNwO3vICY3DqY0Po5gaDNih1Ejczt8aLqQizqHqonTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8oYUj4L3mkNeJVH9fSkXrSayjaNK/RWcus2o3YVdBU=;
 b=MPgFKKJ1JX9dFOYuzHtTFXa/OFACnz8feYSbqcK+qOvq7Y5rXpN3GnU7wAH5x26p0woL1axYELG12kdn8Y6CtHtUPImYyO2POwKAn3rFKUPVmjDo7HbI7Y3BuDAwdjyQMPDQlWvsg8FEE7OLvyyjYkzP4UkNjkvYX8AN6P/Iqrg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7) by DM4PR12MB9069.namprd12.prod.outlook.com
 (2603:10b6:8:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 23:16:53 +0000
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7]) by CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 23:16:53 +0000
Message-ID: <18eaf274-988a-4a52-befb-0797bf0b482c@amd.com>
Date: Sat, 21 Nov 2026 07:16:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Move gpu_recovery location
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Cc: jesse.zhang@amd.com, harish.kasiviswanathan@amd.com,
 kent.russell@amd.com, mukul.joshi@amd.com
References: <20261116075047.35150-1-amber.lin@amd.com>
Content-Language: en-US
From: "Lin, Amber" <amber.lin@amd.com>
In-Reply-To: <20261116075047.35150-1-amber.lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0003.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::9)
 To CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB504406:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 9240713f-5eca-4547-ae6e-08df475c5d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|11063799006|261026140227099003|261021121427099003|261022105027099003|261028144727099003|56012099006|261009223027099003|261026121527099003|261021123027099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 9sjBBMiimryooVe21r+Oi4w4bE9th50cqgbk/ojAdrun8apKMrFSGTQrgDA/xEfWvBGnpvRlKoOaqCtTetb+A/8/a3GbLAwfI7IeIHstqQZ7Y4ExxL08VC6p3jm3L8corprwfV3RQ5oKw7pbe8FCdFSv+l6fAxxdcyjE3mEWmewOTCQCAcaTswEXlSauRR4XhVF/ClGiG/dnHJZaK7XK/KcoDryEM4JpOTfbU0x4G5fhNJYmWcs4CRCPjqDeckwiJthj8aOLlVGL/Btq3EU7mJCWeROsBi/N4rCoDpmh5At2tb/LsjqQvX5VlIA9im/btZliYpvcmcaJCE8eOu7dnXED+LIZZObY0pD8GCuiSdhOKS5gOrqttyvhFVGbd6sG44eUNHNvMK5bcax5TwoY2XC11VGQAduhlVwccb323uJNmsScYTWCkNG8nSIAhgVizA2bXufzY/pv2qUgN0PW+84ueN13dwiUWHi+R/3yYY3bYf6Cihi+j/SKtc+vUPQCJi+ptZObU5u9NnhDxVGiGCJqsjB9ZgcojbTnuh3PH2dy0XJnDe69spz3N1TZGxlEhADmItAJ+H598VCVKTPzMq6s48VX7VxhBYOn4R+pywfmzAg6RPHIh+Lnmvj49+tBkTit6r1+NN/Xg0YvFR7VhkFQMg5SzXqY0xzv8HtVyCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB504406.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(56012099006)(261009223027099003)(261026121527099003)(261021123027099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZRUTM5WjRhbDhST1o0RFRMUWN2Ynd4Skg3QnAwWC9sUG1xUWZPaFExcHZs?=
 =?utf-8?B?ZzdBQzZHbU51WU9MRjJ0MXR0UUhlOHJqNDFvOTRDbTNTQjZneDNNZGE3eVh6?=
 =?utf-8?B?SldZV0JhaW50eDVkZWhXT0l5aHh1MGJJS0tVZlRnL082NHBDbmZyS1hjMGJN?=
 =?utf-8?B?Z1NZN3lPbVM5SUE3Z1JKWXI2WnBoek8wZyt6d0kxRDRybWRZbmROa0xFSjNQ?=
 =?utf-8?B?bDA3dTB5QVg3VjdqTHpBczZsR2JwRFlUTG5KdlNhV1lpa01COHV5R2NXYVBI?=
 =?utf-8?B?Q21RNmVWL0VyNGlMNWthODQ0ZFFNMkxSbW16OXZrZ3h2bE15WmFZUzVYOW4x?=
 =?utf-8?B?WmlZMjMvanltMmgyVDN3LzFhYlFsTkthOUdsN3BZQmRkTDdNVFRMOHB1MjUw?=
 =?utf-8?B?VllnRmpvTitOVmZDdTY5dG1JV1FsNjV5cFZMbnlLN0JlWVErQ2EvNUh3QjhP?=
 =?utf-8?B?MkI2UWtvMjZFNVJ3dm93bE95bnIySEZhVnlGb21Ua0UreGVXWG1WdFBSVGkv?=
 =?utf-8?B?eG9YRU8xaDdHT281SWJyVmZ6ek5yM3hpa3IzVlJ5Rk9ja3gzVU9rZ3hkb2dP?=
 =?utf-8?B?NEVTRWZpNzZnMVJmaWtpUE5TNU1tNmg2TFo5ajJtVTVFTTkzUk5jbTcwR3Fx?=
 =?utf-8?B?TDBGaTlrV2VsaXROVE05dUxoRFM2TEF1NlJta2M2RHBqY0pNQnRXTEI2Q0du?=
 =?utf-8?B?ZHh5QlhVck8rRHZFRFdEQkR0anFzRFFwYUhoM0xqcC9nMXBNckxnWWFyUjN3?=
 =?utf-8?B?MVlrSGxYUnI4bExXenpnUFRoWjc3OExGVVRIT0FRQUZWS2RTYVNmWWVJaS9C?=
 =?utf-8?B?MHZBQlVrRCsxbytuTW0wbUtqcW5oNHVieS9sK3ltYVVNejVWZVI1RytKR0FQ?=
 =?utf-8?B?NWRzY0xZSUp0cTdJdzVLaytCazd2anFUMHI5dnF1Z3JLbnpCcVN4T3d4WnBO?=
 =?utf-8?B?UzJad0RwTnZxejZ6cUtHcmtTNW9MY04vM05OSzgvTlFvbzNXQk93N2J0Q3hh?=
 =?utf-8?B?REpBK285a2pCcjAreEdoMTZucmVTanJmMmZOVllPaFExT05PYU5XN0RzaUx1?=
 =?utf-8?B?b3cwbml5L090VnlDZXhDOURpTVhrMUtGUDhTNmdLU1NDOFQ3MlZhNWVNWnMy?=
 =?utf-8?B?VmNoWVV1dFFuaXFDMG05ZkdvaC9DYmYreGVnWUtDMGdKaUpYN2Z5bG9xSkVO?=
 =?utf-8?B?OW1jY3ZGSzBRNUIvbEZ1ZlBTSS9pNHk0aFJyMVJ6VVREK0Y2QjQxRTRhMytI?=
 =?utf-8?B?SlIrOENGSVJ3d25nTjFwUjJzbkFTR3VDc0c5VkI1Y1E5c2ordlRjTVJ6NjFD?=
 =?utf-8?B?SktWNFFXR2V4bzFDTE4rMG9oemVDZlQxMy9TTnZNSXV2c2hyTmFobGZwaGND?=
 =?utf-8?B?OFNzMks4U29EbktJbWd0UnUxbHBFYVV2UDVLbkJSaVJXdGNzU3NnZFBHT2Zl?=
 =?utf-8?B?L2RxOGJxY1FOOVpUL1hGTjJOZ1RBd1d5cWZxK1plYURlM3VCWTZRMmQrT3Ni?=
 =?utf-8?B?SE9CY2xxNVV6Z2IzcGdVVFRGR3dwZFpoeGx3czU2cDhxcUFyTDVWR0lnaWNE?=
 =?utf-8?B?UGRZTlYwWVVmWEw1VzJwSFM4RWlMN0hZN25hbXRaYTZSalgzTUpmVmJKQVNF?=
 =?utf-8?B?V0pncHJVdTRjd2pya0FBRTVldCsvcGVlck1lQmY5dUg5V0cxazN1TWNIVStT?=
 =?utf-8?B?a0lFRThWS2xEeDdTY3hPQ1I1UU1rL21TdEkzMkZlMnBVQUlaeXdtTmY5K1NU?=
 =?utf-8?B?RnF4UXBVQWJjZEtQMDhOdHNvOVVuU2lKdmMwbTRGWnUxWVA1Z05CYmh1RUc0?=
 =?utf-8?B?V3U0L2FsYTBuaGRlYXdHWW9TY1ZYNzdIc3JSWHZIeE04alJQYmxWbWp6WVEv?=
 =?utf-8?B?UkZESVRzaU90M05vSVIzVVNHWXMwNzFKT3pwSC9hVTJHL0s4eHRCT3pFelRO?=
 =?utf-8?B?OVFwQUNpZ0x4TW5VR05wa0xaOGhqUmdEWldrWWptcTZGelB0WnVVV0VQeURq?=
 =?utf-8?B?VHJOTjVLTEYzSEVpeU5haHIrbGZIbDVOZ2ErY1NscGNIQnhCbkVBSkhCemJQ?=
 =?utf-8?B?bDlMeXVLUUZDTXhackV0UVRtZjBPNXRBQk1qTHg1dHcxNVRxNnExaFVEeFBo?=
 =?utf-8?B?RmhNbmxKb0VaYWZOV0VybkZpdnhwcnR3T05xTXUxTjZlczV6Z0VWYlFDNy9w?=
 =?utf-8?B?R1FYenlxNmhBQVdQM21KS2RFUUc0amI2dlFoVVo5SVBxWFV1QytsWmIrbWYz?=
 =?utf-8?B?cGNhL1diZkJ2NHd6NG41cUI5RlR0ZVdqODg0ckovWkVzUm9JR0ZMeHlla3Qy?=
 =?utf-8?Q?yGQawMOpkzX6MhvHOA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9240713f-5eca-4547-ae6e-08df475c5d1a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB504406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 23:16:53.6215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi3OB9x2S84KRq1xeDw3dlLi8mDlguFjQd4yUDPxqd0Wrm3vi0u/KTgJ/zjmHsvS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping

On 11/16/2026 3:50 PM, Amber Lin wrote:
> amdgpu_gfx_reset_mes_compute combines two features into one:
> 1) hung queue/pipe reset - suspend all/queue reset/resume all
> 2) bad queue removal - suspend_all/remove_queue/resume_all
> GPU recovery aims on 1)resetting hung queues/pipes. When gpu_recovery is
> disabled, we need to keep 2) going. Therefore move the gpu_recovery
> check from KFD's reset_queues_mes into amdgpu_gfx_reset_mes_compute
> where queue reset is done.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c               | 10 +++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++------
>   2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c5a2dcff5058..c30fecc653b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2594,14 +2594,17 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>   	 * reset detect will return the array of bad queue doorbells
>   	 */
>   	r = amdgpu_mes_suspend(adev, xcc_id);
> +	dev_dbg(adev->dev, "Suspend all returns %d. xcc_id %d\n", r, xcc_id);
> +
> +	if (!amdgpu_gpu_recovery)
> +		goto after_reset;
> +
>   	/* if suspend all success, it should no hang queue */
> -	if (!r) {
> -		dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", xcc_id);
> +	if (!r)
>   		/* always reset the KCQ/userq since we need to signal the fence
>   		 * and we could be stuck in a loop which is preemptable.
>   		 */
>   		goto fence_reset;
> -	}
>   	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
>   						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, xcc_id);
>   	if (r) {
> @@ -2662,6 +2665,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
>   			goto out;
>   	}
>   
> +after_reset:
>   	/* MES doesn't detect any hung queue but we have a known bad queue
>   	 * and it is not KCQ
>   	 */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 86b70748617b..b77cfd8ba907 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -471,11 +471,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>   	if (WARN_ON(dqm->detect_hang_count > 0))
>   		return 0;
>   
> -	if (!amdgpu_gpu_recovery) {
> -		r = -ENOTRECOVERABLE;
> -		goto fail;
> -	}
> -
>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>   	queue_input.doorbell_offset = q->properties.doorbell_off;
>   	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
> @@ -3609,7 +3604,9 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
>   
>   		list_for_each_entry(q, &qpd->queues_list, list) {
>   			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
> -				reset_queues_mes(dqm, q);
> +				if (reset_queues_mes(dqm, q))
> +					dev_dbg(knode->adev->dev,
> +					"Fail to remove bad queue. doorbell_id 0x%x\n", q->doorbell_id);
>   				q->properties.is_evicted = true;
>   				q->properties.is_active = false;
>   				decrement_queue_count(dqm, qpd, q);
