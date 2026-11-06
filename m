Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF43606A32E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oquYxw03
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7C210E476;
	Fri,  6 Nov 2026 19:25:42 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D3D10E476
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 19:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAB4hGwYkZ8FwztWbpIovpegBpTe6r0Ob6NqakAr+Hvuw81fVwdMZ53jKel8gdQOUG0QKgkXmYozNRw2k//YUameW33TBmGGTz4K/2ElEhiqyozdQP0vzURO0FF089rwZKsDScv/dMGx0jSnBmjkmhD5qaotkXRO4HBTZpiLb424QhO0+QnAyeBEXEOoN7eduCUAs2U4g8cZ3uTWzLo74TXCOuzda6z+soLP1OKUwP5aivWZxO9S8SBDOBGH3H6DCv7IbP01u+UbCFrwM6YDqh0Yl064o5QwZWICvHA7i4vipU/H8zfSBnJ6bkKTIXrgbWResGASgw2T6uLFNmQr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBzJgGCp6xJIRvHInJTEwz+BgXtwRyH8oZA8DEAP9es=;
 b=Zb/7htr3tcDj3UnryuIzdXxlG4s+GRDwbrZmCjIj32hHckYtguoXfLnXdddS+PlAhHNZ8cdQz3w7lRPcMZ1MhHy+JIVIuHE77+TQN0iltnKW4eGMReLM1NOJBmw3pJ5qRP0fRuVR96RjLc+vXXVaeUc9pTJTVDELx/K4OBYY3TcZq9Kfde3tINLY1gkDh23ugt4sYbHl/2DLMfvA719ckYoJ3kNV4xMayjeLdPKq1slo9Ucv6pw5lhc+jjgE2gFvC67zNImPlu2gC+OP/hQNyEge9aO5xOyidcb8qM6BGboKf6uedYvlf7jriLXPRFOxyj4A0X/lTh+88pPK7gcCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBzJgGCp6xJIRvHInJTEwz+BgXtwRyH8oZA8DEAP9es=;
 b=oquYxw03AuRS2A+93+Jx1/uGWlyn5SZMzNB64yBXYglTnKqyEjnmuD64oezsMtuH8slrnh1M6t2XQrOZLS13e5KL7DtCvOyDbYshmrOunTGY6u3MPSgVB5BX52ZlPPbNAMOemt5PHijdXka2Wf48mI+gtINkd6VbL8gI69FWic0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 19:25:32 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 19:25:31 +0000
Message-ID: <c1fa1903-0822-4a2e-85a0-12c0244569ed@amd.com>
Date: Fri, 6 Nov 2026 14:25:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: load-balance SDMA_BY_ENG_ID queue allocation
 across engines
To: amd-gfx@lists.freedesktop.org
References: <20261102154823.20736-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20261102154823.20736-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0391.namprd03.prod.outlook.com
 (2603:10b6:610:11b::10) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cb1ff7-cc94-4675-6023-08df3c3bb911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261026140227099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: joLUKTZzsYS9kqxZu1nLBO9CLXC7Pg+cFS2USdVZLfvpAKsM0P53SZTakcAdXcy9WI9tkP8LHxrY+0EJB/4k6EefqOO1irD145xTA84ELZeXLlDN2xOEMY7CSv69Tb4nuxsNaA/dyXYrQ7Oq5V4ON9+gv/1NW+23jx0t1RV0GC9JGl/nogvoP+Gq0urKyRdSrV9V5eHxuVCViQekicLP7/0EdeG0TCQl3H0WMC2csZgM4aLC1EmXhWFk6uzYf1s8v4JhZ6+UyFme73qNT2q/4dO2o5HnCBVK2NJVdY1ix6bGsL9td01IaFYHeCzHlxBXIDVk2ndwzBy/koBAct5Dd8fqWeSCZzhG1rc24ChKbXCNF3pksU3Yk3euxZsqziF7Tk79FpdPJaChB2GS7lieKNz8IEdjHVYn9sWa+UxVDnCekhDPxbMectwFxrJ2BDAza5f7JtsoRxBFVRIRpdAYck4ewrcSN7Tjd5jr6ctEQSrdiut3gGc0+HnCX/kxbEUXUUJlDRlyEN32asia2iEfk6Eebi18+a6Up15mIkUiAxMs9KLC5GsJo6MMfLUSfuxRJxjWpkQfYmlf2d+I1m+713E4iUckJ4mYjPOD5PD/exbH+CnEDi1U10WPI3fFVzjbzLvfNw6GBQoL9YnR+g86zS3cFklVJP+S5oqOc/q4MeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261026140227099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V21qZnV2emNuZm9sU2NyVkRYd3lTTE9LZTAvOXFsZTFFeWpOOHlZTEVYcUdC?=
 =?utf-8?B?cTVPcEtXRVIydkdZcFBvMzBydVJNNnJRTDFGTTZOTU9GR0lPUmtRckNKdVln?=
 =?utf-8?B?cDJVVEJxV0xYblQ0Y2hQRXJLQ1ljbklCNlN0dHo5YUlaRWRmZnExaGZYaG5s?=
 =?utf-8?B?Q0RWNStvTnRPWXh6d3ZEL1FjK1RLOWY0WVdsem5xTWgzeUJSMEc1MHBmeHVB?=
 =?utf-8?B?eWxEeDI4aWpIZldTZGdTWnNyZkJMVnA4QVRxMHVFMlNEQzBOMGFIemJ4d2FC?=
 =?utf-8?B?UDEwVjRWWnlrem9OL054Z2ZtOW4xUFRkNmxDNWdzMnZURU5xU1RnZFd5enlJ?=
 =?utf-8?B?c1plMExTMHUwN0hvWTExcjAxUTZ5ajYxRnZmcU9LakVkY2hoSlVaZUpkc2d3?=
 =?utf-8?B?T2VTeW1Mdk01WVk3VG1YaGk5bFBKSDNHRThIYmFRUThETkovT2VEZWZrUmpi?=
 =?utf-8?B?SnR3S09pYkR4Qk92aXhqUlJ4d2Nsb2lWUGQxcGNybzJaNG1WQzNzemZwam9z?=
 =?utf-8?B?akZKNUZtcHZkZSs2ajFvczU3RDdsOE5DZ1NDekhBdXN3NG5sbk9tTEJMSGhN?=
 =?utf-8?B?NXh4eCs1WXZPZUNscXJJcEgwOWhUVDZ4YVI3NjVobURDV2VNME1ybEpQMUt5?=
 =?utf-8?B?SjZIRGwzN1AxNXhtVWRnaEVsREwrTmdCZ1E4S2Rhb1BRaHZFWkw0THpJOHUy?=
 =?utf-8?B?akphNGxZRGhaNG9KS0t5MmxDSHp0M25lWVJHb2l4VEY3bFhBcmpjQXZzY2tL?=
 =?utf-8?B?bTZDREhtcFlxQzJ0ZHNIdktjOTlZR1Raay9qeWgwWHhnL0dSbGdZeksyakw3?=
 =?utf-8?B?ZFRwYjFMamMrVEx0YmFmOU01MWg3ZFZNVUpvdnZ5TEZOVmxhL2MvNUhjOWlI?=
 =?utf-8?B?eWRqZE5VSFI1c3JkakZZY0tyUHhuZkljKzJ5azVIOVBsUEdDbEhOdGFGeHhy?=
 =?utf-8?B?VnoyUG9EV3pvcHpUaDNMOXN5QWIrSGpRTkpWWWpnazhZRU1BMGc4QWs1THBr?=
 =?utf-8?B?SytTVzh6VS8vUVZIR3E3SGJtQWdBSVVha2VLVlFOSnpNTmNESWEyYXVlS3g4?=
 =?utf-8?B?RFdWbW5sVnk1SzZjc0FaQiswdC9DeEtxRVJyQ3o4Y0FmM29WNklsMTc1VHZj?=
 =?utf-8?B?VDhYdjMwaWlFRkpaSWVZZk9ZUFZSSWd6SXc1aGlpcVZHVjN1SUFTZVl4dXNj?=
 =?utf-8?B?TDE0bzM1ZmNHTnhUVGRwRit1clhCS0Z6b29XN25EZzVhMzJNS0Z5c2VnVCtI?=
 =?utf-8?B?Z3Y0d2d5U0p6a2VLUW42dTFSNkxDWnZ6QmxEV3JGcGM5ZU0vLzdhS3didHha?=
 =?utf-8?B?OUVuR3ovQkphQUliSks5aXNrUkN2R1ZKcVFLbVNsSHRScEprcUQ1VUxISWwr?=
 =?utf-8?B?bG4wTm5tMklFa0hSUVpUMlVZZ3NubjZML1BsRS9YejZ5djY0Nk9WQ3RjQjdF?=
 =?utf-8?B?MGhWN3k5U1o2c3VsQ3pmMTFSay93U3lORFdqU2w2Tk16VG1lWWpNeU5Lb3lh?=
 =?utf-8?B?clNPSS94MGhTU2UxaW9aV3JaSjFyekk0Sks3THlVVm1NTGhqdnpJU3ZKelAv?=
 =?utf-8?B?RHdXVTVVUGhuZit0K2xiNmE0M1NZc083a0RzNHFMUTJUR29jeFVZeStCR2lQ?=
 =?utf-8?B?dS9EVE5mT2cwTTNONjhQVTU1TnJLTnVmMHMyZ2l0dXBKNklPN1FMRXVRMm5J?=
 =?utf-8?B?ZElCRVA3cnJkSVJJcWVNL2RLVGhHQUsxZGs4bUVmQ1lzSUJpaG04KzVWSU96?=
 =?utf-8?B?aUtPMzIvVlFVeFN0c2VCMU13eUUwN1dmMDVoODQ3eW1uZm1Kd1N1cUJvN3hW?=
 =?utf-8?B?UHE5SkJ0Q0NLcnVBbXRIakdNakk0U3N4d0lIcU50MUl5a2xJSjBTV0M5N3p4?=
 =?utf-8?B?RWh5M3loaGdtZ2t2SVlKZzEyTEczZWRyN2Z2WnQwWVVGTU1pMzNIRWNLZHhQ?=
 =?utf-8?B?VzRPNmdVTHNUZi9nb0N1bkVlNktFUTk2MWs1OWJrdjZrUGFEeHhoTTZMVW12?=
 =?utf-8?B?a2xWcU1Zdmtrd0tQRktxVVQxdkZtNVVzTmhGODRJcUhjN1I4aEF3aS8vVUJ4?=
 =?utf-8?B?Y1VjUi81NCtXdzlSM2VZVGl4N255Y1V5K3BUS0lRR1doQURPckVhb3F4QWgx?=
 =?utf-8?B?c2VmWnArek53VDBXby9BdkNSVTNHRmx5R044d3RTdE85MSt0VDJjNU9mYjZs?=
 =?utf-8?B?c0NBWlJpdU9HWi8xdnN3aTNNSDNqaGZYSjdSVTBma0FuelFWNmxFWHdVYktS?=
 =?utf-8?B?QUFiZ1NHMEhYU3gyM2RBYkdiVkZ0Z2gremNrZlhJTTI4YTljVm00MXk5Tkhr?=
 =?utf-8?Q?5vbzX6gxzvmH04QQwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb1ff7-cc94-4675-6023-08df3c3bb911
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:25:31.7323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS2156AmcxX1VVhgWp5RBK6vhjvxCrl2x6rPmLoRn1mihRkilvZl2hfKmi1LFISspiT82WPg0cWLXmkMsHtQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
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

Ping.

On 2026-11-02 10:48, Eric Huang wrote:
> ROCr picks a P2P SDMA engine independently per process, so many
> processes sharing a GPU can converge on the same engine while sibling
> engines idle. Use the existing per-engine sdma_bitmap/xgmi_sdma_bitmap
> occupancy, already tracked across all processes, to redirect queue
> creation to a less contended sibling engine when the requested one is
> shared with another process or full. Prefers (in order): a fully idle
> sibling, a sibling used only by this process, the requested engine if
> it still has room, then any sibling with room.
>
> No uAPI change: KFD never reports the allocated sdma_engine_id back to
> userspace, so this redirect is fully transparent to existing callers.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>   1 file changed, 140 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 7b2f6636ae0f..c8db35952e4b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -70,7 +70,8 @@ static inline void deallocate_hqd(struct device_queue_manager *dqm,
>   				struct queue *q);
>   static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
> -				struct queue *q, const uint32_t *restore_sdma_id);
> +				struct queue *q, struct qcm_process_device *qpd,
> +				const uint32_t *restore_sdma_id);
>   
>   static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
>   static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
> @@ -807,7 +808,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>   			q->pipe, q->queue);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>   		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
> -		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
> +		retval = allocate_sdma_queue(dqm, q, qpd, qd ? &qd->sdma_id : NULL);
>   		if (retval)
>   			goto deallocate_vmid;
>   		dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
> @@ -1923,8 +1924,125 @@ static int stop_nocpsch(struct device_queue_manager *dqm)
>   	return 0;
>   }
>   
> +/*
> + * Count how many of one physical SDMA engine's queue slots are already
> + * claimed by a queue, by any process sharing this device. Per-engine slots
> + * are interleaved in the bitmap with a stride of num_engines, i.e. engine
> + * "engine" owns bits {engine, engine + num_engines, engine + 2*num_engines, ...}.
> + */
> +static uint32_t sdma_engine_busy_slots(unsigned long *bitmap, uint32_t num_engines,
> +					uint32_t num_queues, uint32_t engine)
> +{
> +	uint32_t slot, busy = 0;
> +
> +	for (slot = engine; slot < num_queues; slot += num_engines)
> +		if (!test_bit(slot, bitmap))
> +			busy++;
> +
> +	return busy;
> +}
> +
> +/*
> + * Count how many of this engine's busy slots (per sdma_engine_busy_slots())
> + * are already owned by the calling process itself, by walking its own
> + * (typically short) queue list rather than every queue on the device.
> + */
> +static uint32_t sdma_engine_own_slots(struct qcm_process_device *qpd, uint32_t num_engines,
> +				       bool is_xgmi, uint32_t engine)
> +{
> +	struct queue *cur;
> +	uint32_t count = 0;
> +
> +	list_for_each_entry(cur, &qpd->queues_list, list) {
> +		bool cur_is_xgmi = cur->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI;
> +
> +		if (cur->properties.type != KFD_QUEUE_TYPE_SDMA &&
> +		    cur->properties.type != KFD_QUEUE_TYPE_SDMA_XGMI)
> +			continue;
> +		if (cur_is_xgmi != is_xgmi)
> +			continue;
> +		if ((cur->sdma_id % num_engines) == engine)
> +			count++;
> +	}
> +
> +	return count;
> +}
> +
> +/*
> + * KFD_QUEUE_TYPE_SDMA_BY_ENG_ID callers (ROCr in particular) always ask for
> + * one concrete engine id, picked with no visibility into what other
> + * processes sharing this GPU have already claimed. When several independent
> + * processes make the same locally-reasonable choice -- e.g. each one's
> + * round-robin or recommended-engine logic lands on "the first XGMI peer I
> + * ever talked to" -- they collide on one physical SDMA engine while sibling
> + * engines sit completely idle, splitting that one engine's bandwidth across
> + * every colliding process instead of spreading the traffic out.
> + *
> + * dqm->sdma_bitmap / xgmi_sdma_bitmap already record per-engine slot
> + * occupancy across every process on this device. Reuse that existing,
> + * cross-process-shared state with redirecting preferred oder: requested
> + * engine not foreign-shared and still has room, a fully idle sibling,
> + * a sibling used only by this process, the requested engine if it still
> + * has room, then any sibling with room.
> + */
> +static uint32_t pick_sdma_engine(struct qcm_process_device *qpd, unsigned long *bitmap,
> +				  uint32_t num_engines, uint32_t num_queues, bool is_xgmi,
> +				  uint32_t requested_engine)
> +{
> +	uint32_t eng, busy, own, slots_per_engine = num_queues / num_engines;
> +	bool requested_has_room;
> +	int fallback_own_eng = -1, fallback_any_eng = -1;
> +
> +	busy = sdma_engine_busy_slots(bitmap, num_engines, num_queues, requested_engine);
> +	if (busy == 0)
> +		return requested_engine;
> +
> +	requested_has_room = busy < slots_per_engine;
> +	own = sdma_engine_own_slots(qpd, num_engines, is_xgmi, requested_engine);
> +	if (own >= busy && requested_has_room)
> +		return requested_engine;
> +
> +	/*
> +	 * Single pass over sibling engines: return an idle one immediately.
> +	 * Otherwise remember the first sibling with room, split into a
> +	 * same-process-only candidate and a general one, so a fallback that
> +	 * is merely shared with ourselves outranks one shared with another
> +	 * process.
> +	 */
> +	for (eng = 0; eng < num_engines; eng++) {
> +		uint32_t eng_busy, eng_own;
> +
> +		if (eng == requested_engine)
> +			continue;
> +
> +		eng_busy = sdma_engine_busy_slots(bitmap, num_engines, num_queues, eng);
> +		if (eng_busy == 0)
> +			return eng;
> +		if (eng_busy >= slots_per_engine)
> +			continue;
> +
> +		if (fallback_any_eng < 0)
> +			fallback_any_eng = eng;
> +
> +		if (fallback_own_eng < 0) {
> +			eng_own = sdma_engine_own_slots(qpd, num_engines, is_xgmi, eng);
> +			if (eng_own >= eng_busy)
> +				fallback_own_eng = eng;
> +		}
> +	}
> +
> +	if (fallback_own_eng >= 0)
> +		return (uint32_t)fallback_own_eng;
> +
> +	if (requested_has_room)
> +		return requested_engine;
> +
> +	return fallback_any_eng >= 0 ? (uint32_t)fallback_any_eng : requested_engine;
> +}
> +
>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
> -				struct queue *q, const uint32_t *restore_sdma_id)
> +				struct queue *q, struct qcm_process_device *qpd,
> +				const uint32_t *restore_sdma_id)
>   {
>   	struct device *dev = dqm->dev->adev->dev;
>   	int bit;
> @@ -1995,7 +2113,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   			kfd_get_num_xgmi_sdma_engines(dqm->dev);
>   	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
>   		int i, num_queues, num_engines, eng_offset = 0, start_engine;
> +		uint32_t requested_engine;
>   		bool free_bit_found = false, is_xgmi = false;
> +		unsigned long *engine_bitmap;
>   
>   		if (q->properties.sdma_engine_id < kfd_get_num_sdma_engines(dqm->dev)) {
>   			num_queues = get_num_sdma_queues(dqm);
> @@ -2008,16 +2128,29 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>   			q->properties.type = KFD_QUEUE_TYPE_SDMA_XGMI;
>   			is_xgmi = true;
>   		}
> +		engine_bitmap = is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap;
> +
> +		/*
> +		 * Treat the caller's engine id as a preference, not a mandate:
> +		 * redirect onto an idle sibling engine if the requested one is
> +		 * already shared by another queue. See pick_sdma_engine().
> +		 */
> +		requested_engine = q->properties.sdma_engine_id - eng_offset;
> +		start_engine = pick_sdma_engine(qpd, engine_bitmap, num_engines, num_queues,
> +						is_xgmi, requested_engine);
> +		if (start_engine != requested_engine)
> +			pr_debug("SDMA engine %u busy, redirecting queue to idle engine %u\n",
> +				 requested_engine + eng_offset, start_engine + eng_offset);
>   
>   		/* Scan available bit based on target engine ID. */
> -		start_engine = q->properties.sdma_engine_id - eng_offset;
>   		for (i = start_engine; i < num_queues; i += num_engines) {
>   
> -			if (!test_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap))
> +			if (!test_bit(i, engine_bitmap))
>   				continue;
>   
> -			clear_bit(i, is_xgmi ? dqm->xgmi_sdma_bitmap : dqm->sdma_bitmap);
> +			clear_bit(i, engine_bitmap);
>   			q->sdma_id = i;
> +			q->properties.sdma_engine_id = start_engine + eng_offset;
>   			q->properties.sdma_queue_id = q->sdma_id / num_engines;
>   			free_bit_found = true;
>   			break;
> @@ -2392,7 +2525,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   		q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI ||
>   		q->properties.type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) {
>   		dqm_lock(dqm);
> -		retval = allocate_sdma_queue(dqm, q, qd ? &qd->sdma_id : NULL);
> +		retval = allocate_sdma_queue(dqm, q, qpd, qd ? &qd->sdma_id : NULL);
>   		dqm_unlock(dqm);
>   		if (retval)
>   			goto out;

