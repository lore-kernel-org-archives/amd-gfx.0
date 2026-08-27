Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46170C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 16:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C1510F112;
	Thu, 27 Aug 2026 16:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="prgEDUfT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C93410F112
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 16:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+hHQO3VQyVfaA1Lw+jopjrrSCboVJbd69ho6G7bMtXdsBN3Bdvg2kfsrDUZqrle5PcKlZFGL8OWFw4Ex+kdO1o+3WNpJKX+XRcfngItJkvF4SoHqcjlG66gKMt7aG4Ca1lYsAdISQ1ZYFXcsMrePIwq9KFP/OxPnEj/aCyVNuctNXZJ9TMnkCwwGjm8PhdvMErwbHyOkAoobSLhs/TCIn4DEzBAlzsuUejYADwi758aZBi0IbQ6vaRU66ieAR3PrCQsDDjxUvWZU244Jh9jmg7sJJu841vAszDrx3x9rJgaJR7BAR0Tda3Sg0AhxLJWaEtfaSdB06h+UYzQbGhfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx7PUhIl8/TpcWC+X3T8CtJE8bVY8TgXuskCQpeZp/0=;
 b=S/O+wA7qNHDU11bsL1nVJrAuxfZIfCC/B7iWsZFXVoNeHpcXjor6OpGGjcfZJMI65ZXqSKDPM8Zhz/GVhjkaG2C0txXf/14719ShCJKFvAi2E0kC1UHnGBQ4IHbfd7r3LgY6bQWWGCwUw+2ivoKyf/zepy99N0ZQQ7ZYMHsxiAXXJ816Tq13aN5q5agRimPnlgB5+SY0O+0Lq/d/J6vvE3w7VHqlWhGaP8IWauHYR0FfUMH3u62brKGSnno8z3lnRwX0vKsvJkEOpkcCg0dkXIiy71oiX/YejsXFK3qLMa45A6+1n5gQyy04T489YXzWGxMZ1yPXRFtp+mi8oj7eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx7PUhIl8/TpcWC+X3T8CtJE8bVY8TgXuskCQpeZp/0=;
 b=prgEDUfT4jdXQFzpkLyf4qF6H6ssv+fjouzyUGiVFodsZIcVS5AbXhEXjup/VBDvlpe7Y3luAsxIlvLUUHlDn+gkpR5TOK2Rsql+PWLOT29Yr1ndYDqTmy9WCnFIJBDXYnRU8djE6A4hy7y+WFbfB5LHrCrWHeO8/n0i3LOWLB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH0PR12MB8127.namprd12.prod.outlook.com
 (2603:10b6:510:292::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 16:39:47 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0360.005; Thu, 27 Aug 2026
 16:39:47 +0000
Message-ID: <d79f2f2a-e5fe-43f9-91a6-65f4007c9193@amd.com>
Date: Thu, 27 Aug 2026 12:39:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Enable SDMA queue oversubscription for GFX
 12.0.x
To: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com
References: <20260820153609.2264412-1-Sreekant.Somasekharan@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260820153609.2264412-1-Sreekant.Somasekharan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::12) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: c042efb4-bdf6-4d9f-4bdd-08df0459ce5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: mZEUft/zOxU/GL2g3v8PGHpYiH1aDWztjGAPUzy0tVv1MvNZNDD68J9zkDXD2KkiycBVBVnLe/KHIz89VQ8i5e3T0Sw3B4g0nB5DnJ+IV5ieEWH4hkFtJ0bHHlQd5UXKz2xFxKF+h8XFwYti1eO8+agro/OMzygrrYgsf/TQe7q0F0Fhu9oClDuQT2XaG9GR3R7SXxMMzpvsyRQRwCRZmkWZmiuSPRSrcgoP85wz7YyiFOdz1UUHjWTTz93fh1AOnEPUj1fIW6XjYl9VN9hT5ilZf3v7SmfLgYFPFFGHFQff3vLTSoFeRoMFZlZSP5/ksshpOKM6fTNUzTMavvbGbvZt1d67slphJNcz5OK9t2+3alYiB/O8iAbjgBo641eN/6GA9DzT2TfkxwqW3iSf+WwuSyDXjaw/lNpgJrVhL74donqpjoC276Rxfeus9qmRIwFUhdApvjUin/8eDm3AJWGMMldSPHDNSbAuoT999VE0NrEP2sA/eLmOXNUWtpC//SrGHCaTgNDPfsn3CsI0YTqlrR9RZT/wkAwcAi91EbGrHM9fIRR29M2HNZtgS2AZcIfK6njug/AEKiE7VL6VRR57IDYIU63FsjUloCKX8Qar/zOumS9lcobkD3DnbSGexg86IKJU8lWzqCfHzQHquqZn7hP+nbAv8r1368W5bbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXp5WWYrNXZxYWc2ejVGWUJkU3RDQm5ES0tON29mTGVTbHZRQWRYSXBKWjli?=
 =?utf-8?B?eWh1MUQyaTEzMlhpdGN4Y1lIbGl4Ynd1cDUxNWFJaUhmYzBWNExZdlkycXoy?=
 =?utf-8?B?OWtYMlpvM3QvZi85bmh4NTI2MGpLVkhsemFTMEJiVXMzRGlheGxYMnZqY2RN?=
 =?utf-8?B?MURqeG54eWU5dzZDS25Ib25WU3R5MnNNcUZjT2Fid2wzV0xqT04wV1hNSlM0?=
 =?utf-8?B?NXB1LzNQTmJqWUQwQzZOZ0RXNzJLOVg1UE8xekFobEJYN3VET1ZaYUlXUnVs?=
 =?utf-8?B?VVZTekYzd3NFUXdFay9qWlR2RDA2U1ozWVArblBvMFhHSS9wTTdIWUxJQUNW?=
 =?utf-8?B?Z1U4TjZtR1BFTFpUTnlsVVFTeVo0U1FvWnVwd1NpYWxyYmtxTUladGZGTzlW?=
 =?utf-8?B?VnJzbmpzUnRZeVJONlR2Q3p3NjFDVFVaMVJTU3JodWtlaThlem41dGxxRjBY?=
 =?utf-8?B?OWliVTlaRzhES2RiUTRhMVJ6Mk9FRVJZLzRITG83bUsyY2FiUnZPbU5pOXpo?=
 =?utf-8?B?WkU5Z3Q4R052RllZdjhSNjZxNllzM2htNXVVT0RMaC82dm1MQmtlays2cFpJ?=
 =?utf-8?B?NFg1RDJJZ3JsdDBFY0FDSU04a3FSRXNoa2VJSGZxTnJuRFNabkdKZFBXbXA4?=
 =?utf-8?B?TktJT0s5Sm5GZFMxMjFkeXJhWGxyRG5TZnZBZW4veFEyVUJ1cTJIN1J0YkVP?=
 =?utf-8?B?R2lQK1g0TFpPd3ZQZnFnb1hrSjRvbXh3RUpjd3lJdEZZdEF0bWhQblVrYndQ?=
 =?utf-8?B?NlFpUjFua2Z6c3hIZkczM0tJQlRFZE51eU1RWHBRb01SOFp1MTRBbzFKczg1?=
 =?utf-8?B?TnBLQzhYTlhqWEt0dk9pUkcrU0FkS1phNUpSNXdDL25MN1VxdUNyZWdGOWM0?=
 =?utf-8?B?cUxBMUgwNFBxd1Z1eVZ4M1IyN1ZoNFZ0eW9UNUVpK1FDWEs0Z0t6WlhHaHNX?=
 =?utf-8?B?RFFnaUJUd3gybktZM3VMZjloa2VIOEx0Y2pvaXhtNDN1OGovbkxObkpPTm1M?=
 =?utf-8?B?dWc5RzFRdUxDWTVpbnZBQmlNNUJySjZ5WktuTm9oY3JDZ3psbko5M3FjUURy?=
 =?utf-8?B?dFAzd2U3QW9xM0xtUFFMMXlyQ3c3V1FGRERmUGplL0V5bDJjOWtERnI0Q3V0?=
 =?utf-8?B?QURDQ3V2eElWaXpSUnRMbDU5REl5MTZIUkZ2Y1FmR29oYVpSZnVaMmdIQTVj?=
 =?utf-8?B?L2dhNFRocS9DTy9MM3VjSEVwTkh2VmpSOFlLb0drOWcwZ3lLVFQ5RitnZkdD?=
 =?utf-8?B?ZHhEcjZFU1RuMXd3akJmdUZRZUlmbnFwWTNVdm1JMnFPZ0FIMnZacFhMRGZz?=
 =?utf-8?B?S29lbmRGRXdiRUNNT3BESTRSZkEwN0lmbkhWODN0SjZKVG00OHkwb0t1Yndr?=
 =?utf-8?B?NzF0R0lVR2pTaUZRV0RlTVZnVlZaQ0Z0NDdtMk5LdENycEF4YU9mc3Qzd0Qw?=
 =?utf-8?B?MnlXQWEzbVBKUGFhb3piQ0FUbk0rdmVkK2V0aWtLUmJCTmtEa2RuQXJRdnRv?=
 =?utf-8?B?UllzYW11WVluU29FUnViN3A0ZXZQU1pzenlTeFUrNFRNVmFTekE2aVE5WDNL?=
 =?utf-8?B?bEd4bTlrYWJmYnhqTmQzVXdibHY1Z1lHbkZUZm9FTSsxRjllU1JtUktnYTlC?=
 =?utf-8?B?WndicDBQcDl2eTc0T0FaTVJxK1NpUXhpL3lQOFdlcW9pQklkTEJUSlo3Yksr?=
 =?utf-8?B?YVBYSkp3ZTVQTEdiMTZSbzdrWEo4RVdnVmtwL3FBeWptYk5UUGxHQTZoamN2?=
 =?utf-8?B?dUFrZnQ3YS9HdEsraGhwVHNab1B6dDZNQ1RZYzhBNkt1WUQ1Ly93NEwwUFlx?=
 =?utf-8?B?YmdPTEk3cVhhNkZhQ2V0SDZYYTZMUXVvOVVaMEN2dC9WSGhKTFluSWxjU3ZC?=
 =?utf-8?B?aGhZeE5QN0MrbndNMXhhRVNCN0Z5ZUdrTzEzVGZCUGtZUWJMZ2lHdHVMRWJP?=
 =?utf-8?B?T1JqQ1NaNUtwQXFWa2pvdEQxWFRNMjA2UkFJSGZGU1hjcnQyd3g0aXh2VDFq?=
 =?utf-8?B?YlRWaklSNlB3YWVqOHdXTUtDQk5UNjAyNnBnY1YxWjdIUXl6QXFHVzNMWW8z?=
 =?utf-8?B?MmxrT1k1UmV5NG9ZdGc4YXBIVFVMb2J5YjRGSGpqayt2TzQ5WFBNUmlLK3dN?=
 =?utf-8?B?bmNadGJqZ0F0eWMzbUFZUE1PbmtzakJJWXUzOVFjSmR3VEExU3Q5RWhrMVEv?=
 =?utf-8?B?QkVXNys1REhEdmYyc1ZnV3JoN1RabWhzV3g4ZURCbFFXemdueXI5VjJRSFNn?=
 =?utf-8?B?UDVWb1VrbDZtTFhVd2hWRGI0Q3MvZ3N3VHdORnZBajhXWFNpU29kV0pjM0ZI?=
 =?utf-8?B?ZU1Kdm5ZTUZVU1pKZVRtMWtqRS9Fa3BLMUdoVnBXL0xTWUhtWjBBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c042efb4-bdf6-4d9f-4bdd-08df0459ce5c
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 16:39:47.3363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iVH1F8ZmOma+T7CUIJ2gieJ7tNKNcOmN6XPqnvGWpw3jRHQzYz6Il8kJ9IJxCZYM/5aLpO8iJvCAoAbr7INHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
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


On 2026-08-20 11:36, Sreekant Somasekharan wrote:
> When all HW SDMA slots are exhausted on GFX 12.0.x with MES enabled,
> allow new queues to reuse HW queue IDs round-robin via a dedicated
> monotonic rotor. Each oversubscribed queue gets a unique doorbell from
> the per-process bitmap pool so MES can multiplex them independently.

This special handling of doorbells for oversubscribed SDMA queues is 
only needed if you use more queues than doorbells _in the same process_. 
Across multiple processes this is not needed, because each process gets 
a unique set of doorbells.

Is the goal of this change really to enable oversubscription of SDMA 
queue slots by a single process? Is that even useful? Do you have a use 
case for that?

Regards,
   Felix


>
> Normal SDMA queues and all other GPU generations are unaffected.
>
> Assisted-by: Claude:Sonnet 4.6
> Signed-off-by: Sreekant Somasekharan <Sreekant.Somasekharan@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 54 +++++++++++++++----
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  4 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>   3 files changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index a23384571193..10a672b87ca5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -556,8 +556,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   			return -EINVAL;
>   
>   		q->doorbell_id = q->properties.queue_id;
> -	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> -			q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> +	} else if ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> +			q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) &&
> +			!q->properties.is_oversubscribed) {
>   		/* For SDMA queues on SOC15 with 8-byte doorbell, use static
>   		 * doorbell assignments based on the engine and queue id.
>   		 * The doobell index distance between RLC (2*i) and (2*i+1)
> @@ -583,7 +584,10 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   			return -EINVAL;
>   		q->doorbell_id = valid_id;
>   	} else {
> -		/* For CP queues on SOC15 */
> +		/* For CP queues on SOC15, and oversubscribed SDMA queues which
> +		 * reuse HW queue ids and so need a unique doorbell allocated
> +		 * from the per-process bitmap pool.
> +		 */
>   		if (restore_id) {
>   			if (*restore_id >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
>   				return -EINVAL;
> @@ -621,9 +625,14 @@ static void deallocate_doorbell(struct qcm_process_device *qpd,
>   	unsigned int old;
>   	struct kfd_node *dev = qpd->dqm->dev;
>   
> +	/* Oversubscribed SDMA queues allocate a doorbell from the bitmap pool
> +	 * (like CP queues), so they must be freed; normal SDMA queues use
> +	 * static doorbell assignments and must not be.
> +	 */
>   	if (!KFD_IS_SOC15(dev) ||
> -	    q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> -	    q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
> +	    ((q->properties.type == KFD_QUEUE_TYPE_SDMA ||
> +	      q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) &&
> +	     !q->properties.is_oversubscribed))
>   		return;
>   
>   	old = test_and_clear_bit(q->doorbell_id, qpd->doorbell_bitmap);
> @@ -1800,15 +1809,33 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   {
>   	struct device *dev = dqm->dev->adev->dev;
>   	int bit;
> +	bool is_oversubscribed = false;
>   
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>   		if (bitmap_empty(dqm->sdma_bitmap, get_num_sdma_queues(dqm))) {
> -			dev_warn(dev, "No more SDMA queue to allocate (%d total queues)\n",
> -				 get_num_sdma_queues(dqm));
> -			return -ENOMEM;
> -		}
> +			/* All HW queues are busy. On GFX 12.0.x under MES,
> +			 * oversubscribe by reusing a HW queue id round-robin;
> +			 * MES multiplexes the SW queues via their unique
> +			 * doorbells. The non-MES HWS runlist path cannot express
> +			 * duplicate sdma_ids, so it still fails with -ENOMEM.
> +			 */
> +			unsigned int num_reserved, num_available;
> +
> +			if (KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) ||
> +			    KFD_GC_VERSION(dqm->dev) >= IP_VERSION(12, 1, 0) ||
> +			    !dqm->dev->kfd->shared_resources.enable_mes) {
> +				dev_warn(dev, "No more SDMA queue to allocate (%d total queues)\n",
> +					 get_num_sdma_queues(dqm));
> +				return -ENOMEM;
> +			}
>   
> -		if (restore_sdma_id) {
> +			num_reserved = kfd_get_num_sdma_engines(dqm->dev) *
> +				dqm->dev->kfd->device_info.num_reserved_sdma_queues_per_engine;
> +			num_available = get_num_sdma_queues(dqm) - num_reserved;
> +			q->sdma_id = num_reserved +
> +				dqm->sdma_oversub_rotor++ % num_available;
> +			is_oversubscribed = true;
> +		} else if (restore_sdma_id) {
>   			if (*restore_sdma_id >= get_num_sdma_queues(dqm))
>   				return -EINVAL;
>   
> @@ -1901,6 +1928,7 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   			return -ENOMEM;
>   		}
>   	}
> +	q->properties.is_oversubscribed = is_oversubscribed;
>   
>   	pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
>   	pr_debug("SDMA queue id: %d\n", q->properties.sdma_queue_id);
> @@ -1914,7 +1942,11 @@ static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>   	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>   		if (q->sdma_id >= get_num_sdma_queues(dqm))
>   			return;
> -		set_bit(q->sdma_id, dqm->sdma_bitmap);
> +		/* Don't return oversubscribed queue IDs to bitmap.
> +		 * They are shared by multiple queues and managed via round-robin.
> +		 */
> +		if (!q->properties.is_oversubscribed)
> +			set_bit(q->sdma_id, dqm->sdma_bitmap);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>   		if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
>   			return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index c9f9f7a87111..81626e657055 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -255,6 +255,10 @@ struct device_queue_manager {
>   	unsigned int		gws_queue_count;
>   	unsigned int		total_queue_count;
>   	unsigned int		next_pipe_to_allocate;
> +	/* Monotonically increasing counter used to round-robin oversubscribed
> +	 * SDMA queues across the available HW queue slots.
> +	 */
> +	unsigned int		sdma_oversub_rotor;
>   	unsigned int		*allocated_queues;
>   	DECLARE_BITMAP(sdma_bitmap, KFD_MAX_SDMA_QUEUES);
>   	DECLARE_BITMAP(xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d8631847f0eb..5fff5e55fb09 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -531,6 +531,7 @@ struct queue_properties {
>   	bool is_dbg_wa;
>   	bool is_user_cu_masked;
>   	bool is_reset;
> +	bool is_oversubscribed;
>   	/* Not relevant for user mode queues in cp scheduling */
>   	unsigned int vmid;
>   	/* Relevant only for sdma queues*/
