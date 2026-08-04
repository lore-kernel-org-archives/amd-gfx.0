Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A161C55ABA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 22:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 899FB10E07C;
	Tue,  4 Aug 2026 22:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8IfN5FY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CC210E07C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 22:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGkNPtiredMMzkfuSg2HWAQUkoFKXurtzsTePF079dI4X0b6lDdNuCuyPkwIZOo5VkAqG6DcOeuqwg1gjtJJIxPyaYmlkKOAfZDZscmDPQFI5BNASvZkQaI90GUF7/72P0Fq1p3BgHcGKL8RNQLP37zjr4RGzIJTZnUfPPI3I4E/czD57IzWy/PN+XuRDMYh51/6AEFoe2Vz2qFvh1B36jpO7WwPkN8MZ2MzyjQVts4oa2ziX98ktRs2OXcw2OR9zrKQtc0ZLF2Z+7w6kldtDMaXa0BSsL0tcH/yUC/gTghPzlaAyJAd7jxOe6IwVztrCYeKDmXOYNxVnExnTZFdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8bAT9oBCgmDoawfK+RbUSzHO5jSRZ5STK54QuZPE9w=;
 b=UAF9llrAScmY3qRLoYahCplSG4aQsdQj7YROXXZeYjJICqHL3uuREIUhLfycW98FJBoWQBxblH6TC6k6o+vS+mWiII2fta+/6VKbOsfdFlVQ27YYkv46E2wr+VRFeoC5IlJVDon1zvTVloeijBhTvyqJED5wuCB8V64OpiSmnktp3zPmb4GWqkAmeB3sekA7CpuAmpwM3eldNFE4z3Rpz265O3nTd1TaYjIrgp03HnlMh1WFXBjeuwxr8UkMx5RcAApVOP4XYkB0xRZXGG8yTuQkRCK8KABEx7OeUXleWyPi+Yq2E+CeV+vEXpPcATaYLbJyg+Io2oBsT389MDFrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8bAT9oBCgmDoawfK+RbUSzHO5jSRZ5STK54QuZPE9w=;
 b=Z8IfN5FYqXQYKEfdHkt13HlH7lLbWHxWEcfO3T3WHpMUwMP603rLQvn/pMPjZO9b6nficdhrDOV9sVbGg3hcCAEKdlYGIY2DA3TBvdEk1OKgg7//h+UXkbED7FWpWbozP8mKRl2eduviW7mVZADpn2JVU9gIPtMBvkc3866ItcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CY8PR12MB8244.namprd12.prod.outlook.com
 (2603:10b6:930:72::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 22:11:06 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 22:11:06 +0000
Message-ID: <04fff61d-2749-4f6c-be82-ba4dec9146b2@amd.com>
Date: Tue, 4 Aug 2026 18:11:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: preserve VRAM MQD across hibernation via
 unpin/repin
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Philip.Yang@amd.com, 
 Mario.Limonciello@amd.com, Srinivasan.Shanmugam@amd.com,
 Tiantian.Zhang@amd.com, Victor.Zhao@amd.com, Guoqing.Zhang@amd.com
References: <20260803100659.469806-1-shikang.fan@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260803100659.469806-1-shikang.fan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::33) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: e084424c-1129-4d32-c6a2-08def2754796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: p86gdLS6of/EhHupYYue7+ND823xzxwAiSjprptAjw7DtHj1XiariqsFPnJC+yBrXsQTk71JuuH7yc4MS6YGYANiQynEmtP7VfIAKHZNz2pTdggiSBWRJoEQY5/Vq1Lb0tG7/QeWTFgZ9RQz5A70Myuty32figqsaNZ0JUm0yB7UetpmllXviqimXSnxmsnOwuXVdgPo7yxUatnL2gLnAEmWPvq8vdwODySQRgvveCvIYqcZ4yjBB+UFGbHnjMu5nwRHfDyLwVQ249fvQDxyKxk/5Y0bgxNKLYtRMk46DFBpSxhT3vKE2zypzcfnPj7eqzcPivb6/DzbbJWJbqkzV61XzUYCbN4Tr5myOxF5sv0SfkMukQq/fFmFiXoT7LEQOykLey5Y1jRsi4DEdtQOGZd6JOuxk1gkr++16WJmxReUC32cVEuvIkQp69/mBag1CNIep/kbzXVuDHFciV8TZBIxC8pv8dPJ3ajkWNpBiSoX1gZ2v2sBH38ghxMw6qeZCzCE9qm8yVBKhpm/MNMJFHPYgSomnazGqTdvsISSifij/35el/BtfgwIXUn3/qjG5jblEzOgdb/dsofmIN9ixH8lf24GL8rkmiqjnSxOKkhU9ql0wyuySNOQVrgCZ7ejO6VbOHJvgP1ydFfP+geSj9v6TliWSB+PESB2APlpUdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhCNG45NDk3dmdrejd3UkMrM08xS3p0WWluMnJ2cjdRNVZXWnRNa01WcjVZ?=
 =?utf-8?B?WVFtaE1hMCtla0t4em1zTFFOcEFjaE44R21VQ3B2Ylp2MGZRSnBsa0U2Witq?=
 =?utf-8?B?Uk4yMzFaVTVUNGdGcUhzaVVERzVyVXN2eGErRDJ1VlNqMFRJRXhjMnV1TjFO?=
 =?utf-8?B?NjRyaXBlUlo4aVJOVnRLOVhHVkNobEVMNXNkN2ZCdHRLWHhvZUp2cXhZaEpB?=
 =?utf-8?B?SlphNUNRZHg2K3FFeUREOU5wbXM4aWI0N3hnUDJIdzVHMnVVdWhUbWNDZUo1?=
 =?utf-8?B?Q1Q1WW5FN2xENGltRG1GQTlFQ0xVUmFQMGkwZ1FZRWJvTTlVTmtEbml6UTM4?=
 =?utf-8?B?SVhtaWUzb3dJN2NJRWxUZmVlOW5IYUZ3WlJack95VTZEdks3SjR3aVJueTZo?=
 =?utf-8?B?TGJvQ3o0STRleEJyTlVrK0NqQXJvbW5WTExScFI0dkwvK0Rlc2pPUHk4R0Rz?=
 =?utf-8?B?M3FRNHlkY3lmZmtEY2VaT1RRSnBKazlFeksxcWpFQkNTdGRUMkV6RXVVUXN4?=
 =?utf-8?B?Sk9zMmRLUklaSWJ6WDU1TTVic2VwT3lMd1p6L0MwZlppZ3NkenJ1Q3NYRjNw?=
 =?utf-8?B?cGJOOTVobXA3cU5LTHVOREVZZjk5ZDlqZWE5S3g0UFNNUDJPV1lLUXlMTTRy?=
 =?utf-8?B?YjVDcVJVeDdvVGRvczFYTFM5UHBvaTczUDZMYXJrMzVLR0hpZmxjN1U1TTFI?=
 =?utf-8?B?L1laeGI0UWJTRk9FTUhLeEYwYm5FT2JtNmJoUkRIeWJZQVJML2lnNGJGbDA1?=
 =?utf-8?B?eVRIZzg1eEJzNG44UlAyMVdYYTcySXlVR0hoajd0d1RLbHVqL1pMUHBwS1E4?=
 =?utf-8?B?aFJ2c0ladXloRFJIQXB4eFAvVytZUFdFaEpKaUdteldHSGR2eUp0dXR0eFVn?=
 =?utf-8?B?UnJMWHNXRS93eG9nYzEvNlArQ3JTejhiUU05dkluRE5GMGpCTnArc0pCVGlj?=
 =?utf-8?B?eDNTaTFJMzh3aFhpMkZzN3hJU3YzNytBZGNTQ29ONzJ4RU1Ra1BHZkxhNCts?=
 =?utf-8?B?cHZNaXB4OHk2NW9MUmFQdnp5U1l0RGhFOFU2NkhydnBjN3pkQ1k0Y1M5Vk5T?=
 =?utf-8?B?SW5Tb0hIeTM0clZaYWcxdWFsSS9McTFqb2M2U0VEOGhCQVhKSmNBcXhMTytr?=
 =?utf-8?B?Nkw4REtYcVkxc3I2cDFJNmJaRHZXTjVmQUxzUzRFcFZYUERMVUFZbXFCUEp0?=
 =?utf-8?B?UlNNZ2RWNFdQOER2NCtlanhsNS9JRFVmdTBIQXRuK1VudndqMStSNDBCN25L?=
 =?utf-8?B?aW9ORGRZblJNZTI1VFlwMUx2QU53dWFuaDM4UGRqMm1VTTRtb3Uxb1FnVm83?=
 =?utf-8?B?ZHdRblZYbWtQNnN0UmE2UzFhaHl5MzN6REFpaGZYcWhPUnFQZWZLOFY3NTh6?=
 =?utf-8?B?U1U0b1lXZ3pMeWpadW5KVEhlbWsyNjRLUEw0K3pyRlZUU3dyZXZRUmtSdkRi?=
 =?utf-8?B?ekJOWGZjdVlpVEpYVW1OUVhocGFrb0d1QVVwSlRjVGZudVJMK3dnTG4wL2wz?=
 =?utf-8?B?SXdpUUxUZC9KZmVPQUIwdkVOS3IvQ1FMbmhmK1FrS0VuZ2tDaFpyRTlIWkNq?=
 =?utf-8?B?alc1U0tLa29PUDdYZG1Kd3U0OTh5UUhVWXJRVEs2dmxKd1pySm9UdHBrUDFz?=
 =?utf-8?B?aENBTzE5ZHYzR1RmcEM5RlhNTlMwOHV4MEJuajNqNWN3eDRpNFlPamh0R3Jo?=
 =?utf-8?B?bXU4eEQ0YmZGU2hXb2FJZlE4a2RxTnl4VHlWRUtraWpMRC9vdU9kOG9IN1Jm?=
 =?utf-8?B?VzZlcHU2R1JJSmJiU3dZTmU1cnlYbVVLRU1Falh3dmErSFE3OFEzTjFxNU9K?=
 =?utf-8?B?dytGbFlVMFNGQ3pUY1BpdVRTY0ZCWXppQmVQQ1pSN3dBWC93bGtkRGtGM2Mx?=
 =?utf-8?B?UDlBSzZ2d0pWc1p6cGVlVjhlQm5kd3dhZ3Fodm9hWDhPV1hyM3VPOXJidFVY?=
 =?utf-8?B?K2Q1cEt0YmpFTjViRGJPaVJvaS9CbWNuZzdQL0hNMk51Qy9LSTdGb1R0WWZs?=
 =?utf-8?B?aEd2QWVZOFMwcElFNzBSdXNFZStVcTZDWjVKb1ZWS0lYc2oxdll6STlROTgz?=
 =?utf-8?B?NkxaSDNlU3Y1d29XUitDZm9rY2kzVzMzcEt2LzZMRzU0TWZQUjVmeWw0ejBT?=
 =?utf-8?B?bXpka2p5a05PaXlWeldaK1FkZ3BHL3B5aFZEdGIxM0NYa3dzZ0orV0FWQi96?=
 =?utf-8?B?d0lDVFJqVzVNMzh3S1ZCaDlmRjdMdHZHTVJGL3ovM0daMkZGMUdFMkRrWVdI?=
 =?utf-8?B?SmlmN0dINXZEcmZWNm9KL0VqSkxkSDRqNTBZZjZha3d4TkRKNmprQVNWUk9O?=
 =?utf-8?B?RG9tQUdjbzZBTVhtOFlSZnB0WVRrRllNTCsrN0Zqd3VaTkpFNzVqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e084424c-1129-4d32-c6a2-08def2754796
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 22:11:06.1822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0E6+SdFgBSxhXRGWu74cWu+bYr73zQis6NwdgibDI6oTHZWUwm8wCULP4Bsx6CyxYZIjt+Rpi4D9P57pkp8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
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

On 2026-08-03 06:06, Shikang Fan wrote:
> On gfx9 ASICs with mqd_on_vram(), a compute queue MQD lives in a pinned
> VRAM buffer object. Pinned BOs are skipped by the VRAM eviction done at S4
> suspend, so the MQD contents are lost across hibernation and the first
> submission after resume page-faults on a stale MQD.
>
> Unpin the MQD BO at suspend so the eviction migrates it into the
> hibernation image, and pin it back to VRAM on resume. The BO may return at
> a different VRAM address, so refresh the kernel mapping and cached GPU
> addresses and patch the MQD self-address via a new update_mqd_gpu_addr()
> mqd_manager op; skip eviction with a warning if that op is not implemented.
>
> v3: use unpin/repin instead of shadowing the MQD into a separate buffer.
>
> v4: drop the explicit VRAM->GTT placement at evict (a bare unpin is enough
> for the eviction pass to move the BO out of VRAM), and also repin at queue
> destroy. KFD queue restore runs late - user processes thaw before it, and
> under SR-IOV it is deferred until the VF regains full access - so once the
> VM has resumed an application can destroy a queue before its MQD BO is
> repinned, which would otherwise unpin an already-unpinned BO and touch a
> stale q->mqd.
>
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 123 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
>   4 files changed, 177 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..5ce4d4cb423c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -77,6 +77,7 @@ static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *
>   static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
>   			       struct qcm_process_device *qpd);
>   static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q);
> +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q);
>   
>   static inline
>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
> @@ -1048,6 +1049,11 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   				q->properties.queue_id);
>   	}
>   
> +	/* Repin the MQD BO if it is still evicted for hibernation, before
> +	 * destroy_queue_nocpsch_locked() dereferences q->mqd or it is freed.
> +	 */
> +	dqm_repin_mqd_bo(dqm, q);
> +
>   	dqm_lock(dqm);
>   	retval = destroy_queue_nocpsch_locked(dqm, qpd, q);
>   	if (!retval)
> @@ -1254,6 +1260,98 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>   	return 0;
>   }
>   
> +/* Unpin the MQD BO at S4 suspend so it is evicted into the hibernation image;
> + * dqm_repin_mqd_bo() pins it back on resume. Gated on adev->in_s4 so runtime
> + * eviction is untouched.
> + */
> +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +	struct amdgpu_bo *bo;
> +
> +	if (!dqm->dev->adev->in_s4)
> +		return;
> +	if (!mqd_on_vram(dqm->dev->adev))
> +		return;
> +	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
> +		return;
> +	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +		return;
> +
> +	/* Without update_mqd_gpu_addr() the MQD self-address cannot be fixed up
> +	 * after a repin, so skip eviction (with a warning) instead of faulting.
> +	 */
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> +	if (!mqd_mgr->update_mqd_gpu_addr) {
> +		dev_warn_once(dqm->dev->adev->dev,
> +			      "MQD is in VRAM but update_mqd_gpu_addr is not implemented; skipping hibernation eviction\n");
> +		return;
> +	}
> +
> +	bo = q->mqd_mem_obj->mem;
> +	if (amdgpu_bo_reserve(bo, false))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +	q->needs_mqd_repin = true;
> +}
> +
> +/* Repin the MQD BO to VRAM and refresh the cached mapping and GPU addresses.
> + * Used both on resume and when a queue is destroyed before resume has repinned
> + * it. A no-op unless a repin is owed (needs_mqd_repin set).
> + */
> +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +	struct amdgpu_bo *bo;
> +	void *cpu_ptr;
> +	int r;
> +
> +	if (!q->needs_mqd_repin)
> +		return 0;
> +	if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> +		return 0;
> +
> +	bo = q->mqd_mem_obj->mem;
> +	r = amdgpu_bo_reserve(bo, false);
> +	if (r)
> +		return r;
> +	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (r) {
> +		amdgpu_bo_unreserve(bo);
> +		dev_err(dqm->dev->adev->dev,
> +			"Failed to repin MQD of queue %d to VRAM: %d\n",
> +			q->properties.queue_id, r);
> +		return r;
> +	}
> +	/* The BO may have moved; refresh the kernel mapping and gpu address. */
> +	amdgpu_bo_kunmap(bo);
> +	r = amdgpu_bo_kmap(bo, &cpu_ptr);
> +	amdgpu_bo_unreserve(bo);
> +	if (r) {
> +		dev_err(dqm->dev->adev->dev,
> +			"Failed to remap MQD of queue %d: %d\n",
> +			q->properties.queue_id, r);
> +		return r;
> +	}
> +
> +	q->mqd_mem_obj->cpu_ptr = cpu_ptr;
> +	q->mqd_mem_obj->gpu_addr = amdgpu_bo_gpu_offset(bo);
> +	q->gart_mqd_addr = q->mqd_mem_obj->gpu_addr;
> +	q->mqd = cpu_ptr;
> +
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> +			q->properties.type)];
> +	if (mqd_mgr->update_mqd_gpu_addr)
> +		mqd_mgr->update_mqd_gpu_addr(mqd_mgr, q->mqd,
> +					     q->mqd_mem_obj,
> +					     &q->properties);
> +
> +	q->needs_mqd_repin = false;
> +	return 0;
> +}
> +
>   static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   					struct qcm_process_device *qpd)
>   {
> @@ -1297,6 +1395,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   			 * maintain a consistent eviction state
>   			 */
>   			ret = retval;
> +
> +		dqm_evict_mqd_bo(dqm, q);
>   	}
>   
>   out:
> @@ -1350,6 +1450,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   				goto out;
>   			}
>   		}
> +
> +		dqm_evict_mqd_bo(dqm, q);
>   	}
>   
>   	if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1429,6 +1531,10 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
>   			continue;
>   
> +		retval = dqm_repin_mqd_bo(dqm, q);
> +		if (retval && !ret)
> +			ret = retval;
> +
>   		retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
>   				       q->queue, &q->properties, mm);
>   		if (retval && !ret)
> @@ -1489,6 +1595,13 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   		q->properties.is_active = true;
>   		increment_queue_count(dqm, &pdd->qpd, q);
>   
> +		retval = dqm_repin_mqd_bo(dqm, q);
> +		if (retval) {
> +			dev_err(dev, "Failed to repin MQD for queue %d\n",
> +				q->properties.queue_id);
> +			goto out;
> +		}
> +
>   		if (dqm->dev->kfd->shared_resources.enable_mes) {
>   			retval = add_queue_mes(dqm, q, qpd);
>   			if (retval) {
> @@ -2760,6 +2873,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   				qpd->pqm->process, q->device,
>   				-1, false, NULL, 0);
>   
> +	/* Repin the MQD BO if still evicted for hibernation, before it is freed. */
> +	dqm_repin_mqd_bo(dqm, q);
>   	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>   
>   	return retval;
> @@ -2827,6 +2942,12 @@ static int process_termination_nocpsch(struct device_queue_manager *dqm,
>   		q = list_first_entry(&qpd->queues_list, struct queue, list);
>   		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>   				q->properties.type)];
> +		/* Repin the MQD BO before destroy_queue_nocpsch_locked()
> +		 * dereferences q->mqd; drop the DQM lock as reserve may sleep.
> +		 */
> +		dqm_unlock(dqm);
> +		dqm_repin_mqd_bo(dqm, q);
> +		dqm_lock(dqm);

You don't really need to repin before calling destroy_queue. You need it 
before freeing the MQD. That is done a few lines below in another 
section that already drops the DQM lock. You can just move repin into 
that section and avoid some unnecessary churn dropping and re-taking the 
lock repeatedly. I think it's OK to do that after 
destroy_queue_nocpsch_locked, because that function doesn't actually 
free the queue struct.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   		ret = destroy_queue_nocpsch_locked(dqm, qpd, q);
>   		if (ret)
>   			retval = ret;
> @@ -3017,6 +3138,8 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		list_del(&q->list);
>   		qpd->queue_count--;
>   		dqm_unlock(dqm);
> +		/* Repin the MQD BO if still evicted for hibernation, before free. */
> +		dqm_repin_mqd_bo(dqm, q);
>   		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>   		dqm_lock(dqm);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 59eff3389d39..38b46b696243 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -117,6 +117,14 @@ struct mqd_manager {
>   				const void *ctl_stack_src,
>   				const u32 ctl_stack_size);
>   
> +	/* Patch the MQD's cached self GPU address after the MQD BO has moved
> +	 * (e.g. repinned to a new VRAM location on hibernation resume). The MQD
> +	 * contents are otherwise preserved.
> +	 */
> +	void	(*update_mqd_gpu_addr)(struct mqd_manager *mm, void *mqd,
> +				       struct kfd_mem_obj *mqd_mem_obj,
> +				       struct queue_properties *p);
> +
>   #if defined(CONFIG_DEBUG_FS)
>   	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..b95720198e28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, void **mqd,
>   	qp->is_active = 0;
>   }
>   
> +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
> +				struct kfd_mem_obj *mqd_mem_obj,
> +				struct queue_properties *qp)
> +{
> +	struct v9_mqd *m = get_mqd(mqd);
> +	uint64_t addr = mqd_mem_obj->gpu_addr;
> +
> +	m->cp_mqd_base_addr_lo = lower_32_bits(addr);
> +	m->cp_mqd_base_addr_hi = upper_32_bits(addr);
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>   static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
>   			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
>   			struct queue_properties *q)
> @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
>   	if (mqd_on_vram(mm->dev->adev))
>   		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
>   }
> +
> +static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager *mm, void *mqd,
> +				       struct kfd_mem_obj *mqd_mem_obj,
> +				       struct queue_properties *qp)
> +{
> +	struct kfd_mem_obj xcc_mqd_mem_obj;
> +	uint64_t offset = mm->mqd_stride(mm, qp);
> +	u32 num_xcc = NUM_XCC(mm->dev->xcc_mask);
> +	struct v9_mqd *m;
> +	int xcc;
> +
> +	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
> +
> +	for (xcc = 0; xcc < num_xcc; xcc++) {
> +		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
> +		m = get_mqd(mqd + offset * xcc);
> +		m->cp_mqd_base_addr_lo = lower_32_bits(xcc_mqd_mem_obj.gpu_addr);
> +		m->cp_mqd_base_addr_hi = upper_32_bits(xcc_mqd_mem_obj.gpu_addr);
> +	}
> +
> +	if (mqd_on_vram(mm->dev->adev))
> +		amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> +}
> +
>   static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>   		   enum kfd_preempt_type type, unsigned int timeout,
>   		   uint32_t pipe_id, uint32_t queue_id)
> @@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   			mqd->get_wave_state = get_wave_state_v9_4_3;
>   			mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
>   			mqd->restore_mqd = restore_mqd_v9_4_3;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr_v9_4_3;
>   		} else {
>   			mqd->init_mqd = init_mqd;
>   			mqd->load_mqd = load_mqd;
> @@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>   			mqd->get_wave_state = get_wave_state;
>   			mqd->checkpoint_mqd = checkpoint_mqd;
>   			mqd->restore_mqd = restore_mqd;
> +			mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
>   		}
>   		break;
>   	case KFD_MQD_TYPE_HIQ:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index bcb929002839..0dc4f76a36d4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,12 @@ struct queue {
>   	void *gang_ctx_cpu_ptr;
>   
>   	struct amdgpu_bo *wptr_bo_gart;
> +
> +	/* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 suspend so
> +	 * TTM evicts it into the hibernation image, and repinned on resume. Set
> +	 * while the BO is unpinned so the resume path knows to repin it.
> +	 */
> +	bool needs_mqd_repin;
>   };
>   
>   enum KFD_MQD_TYPE {
