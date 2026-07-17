Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A738C44514
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 08:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C42F10E442;
	Fri, 17 Jul 2026 08:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cW/TEKgp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727C510E442
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 08:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHvNxm+pXVmg5xf7Dj2A8lY0x/bouo3NsrE5/MFRE22gl1ltvRpGbVuG6Xtab9b4Nyh8pm8uNwmmzbv6ysPAvpqEN5gWAF2kp4lEML1KwmA9Uph9Lzxbq2Z26q6t3sI87ryN4684J3B2uA6MyTsMVeaYYCHQbGX9B1GmEGnsCE0Q7apIrO/GtqINqtRMBZwBzD4qBX3X/tVTVUCq4v/BMV087JRurbgEluxyHU3zPeaSF4pS40HP7QcAWJWr+Z7k4o5HopcjjEQGu3XLVemYbgLcYK0jUpKoIBs2yrrfrto0TV7uRRzvoxX1ePg3sQ0SIy3Xure4GBRfa0+sADDm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0KVtiIWzZD9IKnUh5xKFMIyP/qMNnrN4TrJQLVJNN0=;
 b=DNNIwY52E7cACpV7/arMq9t5IqCBox7q6b9KhYPYFqtZUYuHYV4UG5LkKKtorya/nbFal17No7f021AwNDAA6rNPNhkD/UTD3wJ1JYCg5nbdh5UXAAjQ6aorArfq3c8lMJAsiWyogG4gn7vLgIQg42JJsaCpC4qxGLOzg95w2gJ8JuvVvB9xfr6C4rrJ34Ux14vWxcZ/q5UXHpZlMK0UA4t/i8om3iVE56v5A4zgtgzb5nCBxuzo2Fx7Y6l2wgylMOSPo5NjuyvshEj+UJdToUsnY4cIcrX6pAOs1svTMwf4zvTiDkD743Cnwf+mENo1rnw9IcxwdCf+bqXA2mui4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0KVtiIWzZD9IKnUh5xKFMIyP/qMNnrN4TrJQLVJNN0=;
 b=cW/TEKgprdT1sLWIPRjW+5iPnMILY6TdCZxUG7DIzwI9mfqOKKxIVL/DZiTbNIXoZ3pha02KANcW2kRYk5XaoAW/qLRvtChRez0wQme/oBE/cEgaImKrd8jtRVA+PEuuMBCKN29ow3zBrflSWAIdfykOS7jvlWhH2gSAD06bsBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Fri, 17 Jul 2026 08:59:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 08:59:28 +0000
Message-ID: <da934005-b10b-4e86-b8b0-a910e59b3d66@amd.com>
Date: Fri, 17 Jul 2026 10:59:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: save/restore MQD across hibernation when
 MQD is in VRAM
To: Shikang Fan <shikang.fan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com, alexander.deucher@amd.com, felix.kuehling@amd.com
References: <20260715103056.3529178-1-shikang.fan@amd.com>
 <20260717085357.41610-1-shikang.fan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260717085357.41610-1-shikang.fan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 04607381-fe4e-45a0-0c68-08dee3e1b55e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 638ExbmV9COeiYqhHsttW0DUESH46jb5RCgqJhgcJvZ+dEvpiP6diKQokVFiPLnStv0+O6T17+yLpt30ng9dpCNh0KeViFH3xl4HkUASEs3PpMMs+mh1bN9UgwndeLIL7KKSKWHvsqg1bu3b8Ugrvy5rfurVsbBiFttF1qPxX/e/3OCPBBY/ltxdy3jRPt25MZCQXYFv3/PA60qVvM0NupxE7CqrZjXfBMmqZBlXSDyKR54C0zY+mCcGMzS0B4aI4mAOCZOGww6nyByJS6Zg1HhjbJI1eSAO1QT7UDNEXug/+HxA2+ZamiVG30M+AdUbfkKvJoBU5RwCgum9kl4/sakJieGDc/EBqUjkE6gv1GvL7ugcv7C8g3ZFGV3UWQfUL1E58kbJyir+EbSvCMgWwppw2yBjGZKe9fJ8DPoQEw0wSMlovagOyYllUAv3ENr/YWv8sDPSHK4c6tf3+vL5HQsWXXGq8XMTydwUZbT0Mf81dc3tnAGvRp4YIhCUckD3UaOOTQM+AsDbLpKe/JvcMUQE8PV4uR8hssXUB7iwcUhoFFX2kQ51K9sYQY/ZYIxQJO10VPiXdPQC7Aeih2huQV+pBMus6OleuJ7d6wEjXbWjAC6TKHW64bLbZTRIlj/xF3U1bY7oqHmju3gOeVsDh7wRXNWrverW2LUzX4JOo7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RklweDdEWVhPcEFRVi9zbUI0ejN1UjNzb3J1NkZ3L3RrVXdlclVQYWpnYlJl?=
 =?utf-8?B?aGRRR205VmZscFRKYlh1dGFmdXJrMnNBOFVITERha2hEUVVNVlc1SUQzalNo?=
 =?utf-8?B?SUVmOXduemtnTHpxZEZyT3NNMng1VFVhSEFSVVpMQXMwdlExamhCRGkxUkp4?=
 =?utf-8?B?VDdJNzkvZGNERGxTVGxWWjFkaHRYVVFuSHhLT0Z1UkplS2duQWRyTm9RcHZn?=
 =?utf-8?B?MWZjeXB1WGFwQThUQ29BaU44Wi9Uc0xtL2gyUTNTOWx2UW8vU3FuWmdFSEFl?=
 =?utf-8?B?OUdxVTUxSlozaUNnYmp4eDBxOE8wdUVLWW1KY2ZqaXdKbldyWFRnMy9UZVFO?=
 =?utf-8?B?SmJHRnc2QVlpemRSazBROHVVbXdpVmpQUUk0OXY5S2JZN0FyL213ZTdRM204?=
 =?utf-8?B?V0xnS3ZOZmd0UXNDMzJwZHJqRW05dmxjaG1MOVQrbXk4SXM0YTJiNGkwZmhy?=
 =?utf-8?B?citWVmlEbCtmNGJNWlp2eTgwbXNJRTBvdkUxbFl5cmVZSGRnYm9JUjVkMGdy?=
 =?utf-8?B?UGJldlNYd0lnVTA5eUZRQ3UyeDd0WnJMekh6Z1ZDcVFCdVFXQk9NWHJiQ3Q0?=
 =?utf-8?B?MHJlR1BlQTkxempaYjRWSWRUSnRFcTBRbDlJd2c5bFBXQVhJRDRVS09GNW1U?=
 =?utf-8?B?WW1DMGkyNDBVYzlNVkthUCs1eldVL0E1RFZFTnptZCtOc1l2YjcrNS9xbHFm?=
 =?utf-8?B?MTBVbkdVYmRKR3RqYm1PbkpOQ2ZUVE5OT0IzTktiNVdWYys2My96cG1MVXFN?=
 =?utf-8?B?Zndoc0VvbkVjV1hKN2k4OXdYNW0rUGcwNEtvK1IwMTg2azdGMUQ3d2ZGOVdZ?=
 =?utf-8?B?VXRUWHRSYzh1L2o0TkVHOERrbUxVYzc1VVkydXcvSHI1TXNMdHRsb1RuN0RG?=
 =?utf-8?B?NCtpZ21hS1JKWm9SaWJoWnYySEZESUovUmNtbjJIMlBKVmNENWV1Q1pDM0RQ?=
 =?utf-8?B?bVVwVVZIOHFDZlN1MVlueEVMWnhmUTFjRG1pRUNuek1PUjh0NHplU1hoMnpE?=
 =?utf-8?B?a0Nsc01nZ1RhUG1ETnJwT0VsQjVDTGhvbkdVOFpGaEZENzNpZ2xFWFJneXMw?=
 =?utf-8?B?YTJFbW1HN2lCajlEb3hJZWhjWFo1dFFLWjB2RjlJQ1F1eCtaNHRWUGoySmp6?=
 =?utf-8?B?TWlvcTZhRlZqYlI4TGllVC9hcDYxT2g5OFdRWkFDS3R5bHczeHY0dndWdWR0?=
 =?utf-8?B?dDczaXIxdTU5OWFVVDJ6Qi92SHkxVnp4ajJQWEx0REdTWGo5blZDTUYxWnV0?=
 =?utf-8?B?L2hncTB5SHhjVTZiMm1XUHV6OEF5WGlCZm9yTDB4OFV4NHpoajNVekczQTJw?=
 =?utf-8?B?OXp3VWZQSUNrS1NQL0lranQ2Z292cndUbGxKYnZBaGRyY2x1T2IrbDczSkdt?=
 =?utf-8?B?QWpBNjRla0hLVDkwZktLSURMTi8zZDZqWGRSTENOZDBieEUzZmdnTHhYbURQ?=
 =?utf-8?B?b0o3WGtkM2dTMDRrRU1HZ1R2ZTFJWjUzUDVhL0FCdVVhZkRtYS9IZzViRGgy?=
 =?utf-8?B?QWZ0OTU0NlEzY0dqTTdWNzRNRVNDbklIemU3WXgwYWJIMXBqcWNpN09JOFBO?=
 =?utf-8?B?SXZCVHk3bUxsV1kzdExlZnAzWmpNdTdDNGhRS2pLaTJvUVRyekIyOW9VZllB?=
 =?utf-8?B?Y3JSOEdPbCtZcmZZWHAyTm5PQUdnQW1YWkxCeXdZOHBudkFJZVFMclBkNkgy?=
 =?utf-8?B?NmpjTzNjZzB6akFrVVN3U1ljRTRFZjhWaXUxQXVMcStBRnhFUXNpSXRiSnky?=
 =?utf-8?B?TmpSNkJudi9OTUVDT2ZVT2o0ZkVLN3YvcHhvVWN5WlpxN2tmajN2MW90aEF1?=
 =?utf-8?B?R05XNVZ6dis5bGJkZW15OU9hZDZJdlNJeG5SZG03dVlocnVZNGJkREpKR3Zp?=
 =?utf-8?B?TkhHYWdZVWU0UGdCMzkyMkMvdGxnZzFyV2NrYzlXS1RvdGFMbmFleitzNmZo?=
 =?utf-8?B?bzRJemtmMmFYc3ZEQ0pFNThPay96LzdSOEhJL3g0cEg0TitTaXFKT21wdU95?=
 =?utf-8?B?Um1OckJVcXd5Wml5cFI4ODF2MDZtc05HL0xodFkwbDQ5UUZMbmFHRStiQXph?=
 =?utf-8?B?YTN6Mm1FLzhIdFltaDlkaGZhM3FUcGd0QjBtaXIrSWZWTnBNMGw2aHVaUXp5?=
 =?utf-8?B?Ykc0R3kxMTRiZGQ5TFBLSG1ZVC9KL3RzRERuSXhrSHIzSkVpR0tXVTBpZ2Rs?=
 =?utf-8?B?amU0Z3FmUTh3RGhQMUx4OTk2T1plb0oxcFZnZzlIUWNXdFBnUGlHMEtGOFZQ?=
 =?utf-8?B?NXNkZmxrNC9RRDduQ2Z0VUJNZTVOK1o5ZG5EUDJMd0g0ZHpsRi9NRWRiZmlO?=
 =?utf-8?Q?jMt0fV0mMD0UHgKg+w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04607381-fe4e-45a0-0c68-08dee3e1b55e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 08:59:28.5353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlKXi2EdBoMKBr3TayRZy6CD7u9CrVXNEvx90r4E9g3PcWKYB2m5ORxPZ60knBW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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

On 7/17/26 10:53, Shikang Fan wrote:
> On gfx942/944 and gfx9.5.0, KFD compute-queue MQDs live in a pinned VRAM
> BO (mqd_on_vram()). Pinned VRAM is skipped by TTM eviction and not saved
> across S4 hibernation, so the MQD is garbage on resume and the first
> submission faults. Save it to a system-RAM shadow at suspend and restore
> it on resume, reusing the CRIU checkpoint_mqd/restore_mqd primitives.
> 
> v2:
>  - Also snapshot the MQD when a process is already runtime-evicted at
>    hibernation start. The qpd->evicted refcount early-return previously
>    skipped the save loop, losing the MQD across the VRAM wipe (both the
>    cpsch and nocpsch evict paths).
> 
> Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 120 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |   2 +
>  3 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..d168686ee324 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -65,6 +65,9 @@ static int map_queues_cpsch(struct device_queue_manager *dqm);
>  static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>  				struct queue *q);
>  
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct queue *q);
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct queue *q);
> +
>  static inline void deallocate_hqd(struct device_queue_manager *dqm,
>  				struct queue *q);
>  static int allocate_hqd(struct device_queue_manager *dqm, struct queue *q);
> @@ -802,6 +805,10 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>  		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>  					&q->gart_mqd_addr, &q->properties);
>  
> +	retval = dqm_alloc_mqd_backup(dqm, q);
> +	if (retval)
> +		goto out_free_mqd;
> +
>  	if (q->properties.is_active) {
>  		if (!dqm->sched_running) {
>  			WARN_ONCE(1, "Load non-HWS mqd while stopped\n");
> @@ -1263,8 +1270,16 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  	int retval, ret = 0;
>  
>  	dqm_lock(dqm);
> -	if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +	if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +		/* A process already runtime-evicted when hibernation starts
> +		 * skips the save loop below, so snapshot its VRAM MQDs here
> +		 * before the S4 image is taken. dqm_save_mqd_backup() is a
> +		 * no-op outside S4.
> +		 */
> +		list_for_each_entry(q, &qpd->queues_list, list)
> +			dqm_save_mqd_backup(dqm, q);
>  		goto out;
> +	}
>  
>  	pdd = qpd_to_pdd(qpd);
>  	pr_debug_ratelimited("Evicting process pid %d queues\n",
> @@ -1297,6 +1312,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  			 * maintain a consistent eviction state
>  			 */
>  			ret = retval;
> +
> +		dqm_save_mqd_backup(dqm, q);
>  	}
>  
>  out:
> @@ -1304,6 +1321,88 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  	return ret;
>  }
>  
> +/* MQD software-shadow save/restore across S4 hibernation, reusing the CRIU
> + * checkpoint_mqd/restore_mqd primitives.
> + */
> +static int dqm_alloc_mqd_backup(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +	uint32_t mqd_size, ctl_stack_size = 0;
> +
> +	if (!mqd_on_vram(dqm->dev->adev))
> +		return 0;
> +	if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
> +		return 0;
> +	if (!q->mqd)
> +		return 0;
> +
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> +	if (!mqd_mgr->checkpoint_mqd || !mqd_mgr->restore_mqd)
> +		return 0;
> +
> +	mqd_size = AMDGPU_MQD_SIZE_ALIGN(mqd_mgr->mqd_size) *
> +		   NUM_XCC(dqm->dev->xcc_mask);
> +	if (mqd_mgr->get_checkpoint_info)
> +		mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, &ctl_stack_size);
> +
> +	if (!q->mqd_backup) {
> +		q->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);

Please note that you need to be super careful when allocating memory during suspend. The amount available is really limited because both swap and OOM killer are already stopped.

Instead you should probably consider unpinning on suspend and repinning on resume, for this we have memory put asside.

Additional to that it could be that backing up the MQD is overkill, we should be able to re-create the MQD after resume from the housekeeping information we still have around.

Regards,
Christian.


> +		if (!q->mqd_backup)
> +			return -ENOMEM;
> +		q->mqd_backup_size = mqd_size;
> +	}
> +	if (ctl_stack_size && !q->ctl_stack_backup) {
> +		q->ctl_stack_backup = kzalloc(ctl_stack_size, GFP_KERNEL);
> +		if (!q->ctl_stack_backup) {
> +			kfree(q->mqd_backup);
> +			q->mqd_backup = NULL;
> +			q->mqd_backup_size = 0;
> +			return -ENOMEM;
> +		}
> +		q->ctl_stack_backup_size = ctl_stack_size;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dqm_save_mqd_backup(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +
> +	/* in_s4 is reliably set at evict/suspend time; skip normal runtime eviction
> +	 * (pinned VRAM MQD stays intact then).
> +	 */
> +	if (!dqm->dev->adev->in_s4)
> +		return;
> +	if (!q->mqd_backup)
> +		return;
> +	if (!q->mqd || !q->mqd_mem_obj || !q->mqd_mem_obj->cpu_ptr)
> +		return;
> +
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> +	mqd_mgr->checkpoint_mqd(mqd_mgr, q->mqd, q->mqd_backup, q->ctl_stack_backup);
> +	q->mqd_backup_valid = true;
> +}
> +
> +static void dqm_restore_mqd_backup(struct device_queue_manager *dqm, struct queue *q)
> +{
> +	struct mqd_manager *mqd_mgr;
> +
> +	if (!q->mqd_backup_valid || !q->mqd_backup)
> +		return;
> +	if (!q->mqd_mem_obj)
> +		return;
> +
> +	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> +	if (!mqd_mgr->restore_mqd)
> +		return;
> +
> +	mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q->gart_mqd_addr,
> +			     &q->properties, q->mqd_backup, q->ctl_stack_backup,
> +			     q->ctl_stack_backup_size);
> +	q->mqd_backup_valid = false;
> +}
> +
>  static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  				      struct qcm_process_device *qpd)
>  {
> @@ -1313,8 +1412,16 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  	int retval = 0;
>  
>  	dqm_lock(dqm);
> -	if (qpd->evicted++ > 0) /* already evicted, do nothing */
> +	if (qpd->evicted++ > 0) { /* already evicted, do nothing */
> +		/* A process already runtime-evicted when hibernation starts
> +		 * skips the save loop below, so snapshot its VRAM MQDs here
> +		 * before the S4 image is taken. dqm_save_mqd_backup() is a
> +		 * no-op outside S4.
> +		 */
> +		list_for_each_entry(q, &qpd->queues_list, list)
> +			dqm_save_mqd_backup(dqm, q);
>  		goto out;
> +	}
>  
>  	pdd = qpd_to_pdd(qpd);
>  
> @@ -1350,6 +1457,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  				goto out;
>  			}
>  		}
> +
> +		dqm_save_mqd_backup(dqm, q);
>  	}
>  
>  	if (!dqm->dev->kfd->shared_resources.enable_mes) {
> @@ -1423,6 +1532,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>  
>  		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>  				q->properties.type)];
> +		dqm_restore_mqd_backup(dqm, q);
>  		q->properties.is_active = true;
>  		increment_queue_count(dqm, qpd, q);
>  
> @@ -1486,6 +1596,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>  		if (!QUEUE_IS_ACTIVE(q->properties))
>  			continue;
>  
> +		dqm_restore_mqd_backup(dqm, q);

Those are the wrong point to call those functions if I'm not completely mistaken.

Regards,
Christian.

>  		q->properties.is_active = true;
>  		increment_queue_count(dqm, &pdd->qpd, q);
>  
> @@ -2161,6 +2272,10 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>  		mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>  					&q->gart_mqd_addr, &q->properties);
>  
> +	retval = dqm_alloc_mqd_backup(dqm, q);
> +	if (retval)
> +		goto out_free_mqd;
> +
>  	list_add(&q->list, &qpd->queues_list);
>  	qpd->queue_count++;
>  
> @@ -2193,6 +2308,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>  	list_del(&q->list);
>  	if (q->properties.is_active)
>  		decrement_queue_count(dqm, qpd, q);
> +out_free_mqd:
>  	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>  	dqm_unlock(dqm);
>  out_deallocate_doorbell:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 88191a4c1657..1f728f13813e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -637,6 +637,15 @@ struct queue {
>  	void *gang_ctx_cpu_ptr;
>  
>  	struct amdgpu_bo *wptr_bo_gart;
> +
> +	/* system-RAM shadow of a VRAM-resident MQD (+ control stack)
> +	 * for hibernation snapshot/restore
> +	 */
> +	void *mqd_backup;
> +	void *ctl_stack_backup;
> +	uint32_t mqd_backup_size;
> +	uint32_t ctl_stack_backup_size;
> +	bool mqd_backup_valid;
>  };
>  
>  enum KFD_MQD_TYPE {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 98a5512b701b..cbc90bf87792 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -83,6 +83,8 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
>  
>  void uninit_queue(struct queue *q)
>  {
> +	kfree(q->mqd_backup);
> +	kfree(q->ctl_stack_backup);
>  	kfree(q);
>  }
>  

