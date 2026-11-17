Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5D606A32C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dNuWnXXk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDFE10E51E;
	Tue, 17 Nov 2026 09:08:36 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE3710E51E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 09:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzPDHE2EoxSzIsNY1hnFUiDWQOaFDTAhqAU4apLTrFnRpzAC4QfD5C7E7bmRtujtPway4a+g975/F4BAY69ciSpT1TL4ycMkadjiw3LrsbYBDB7RXcYwtdrlIGx747Nw7TYWYz6UMd3r1TOf0bBnptQ5lTSkJqxPv8BXADolnWL5Oxd4UMG4tgi0/PVxPWCeeA7N5ZkjAc6No7Z9o6cZClVaz2IaNnkwdxj+6cgWiSTCs9FMrb6wxmLfA85+stqQpTuxFGIiyTgHKALamfOq3wPG7H0DMaNuJTxoDDavb2jE6eGYUHGOyOUT8ZaHqMymh2FYhHeJAmAJ/5qgU83/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk7RrlBA0+rg3gtPiZUWGLzLMyqi9cvc3ScF2V7v2tw=;
 b=hlIM3Vyf2whwDSh/c7Gf1wck7URstZQhG76Va+vb+d70UE7aHOid48pmqKOOLI9Y3yXOMP49iUkvJYr6NqpVtVAzdfK7AHQHgOiCjawmHaS4jf/EyGdyA0CB/d1SkiYstHtBiNYz8mzDal97YDD3c/OvbFSoo1xt1WqGTpjNWDIxIkEKIl0zw5EsHsEuv26d+PXaoS/MmF/xIkAPR6qZOfBQADerPkgf/B8xlTVdKm/NQxtH/Oa8I/+wrF5abKxD4CQIwUHrcf0FUnALK0kXx7eIY7x6cirL+O5sCuGbgbc+kaqI8rq1f/+LbIrQid4nKjxMCmG12lv0WPhtbIo99w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk7RrlBA0+rg3gtPiZUWGLzLMyqi9cvc3ScF2V7v2tw=;
 b=dNuWnXXkpV0qrPcBuSDRgLegL6J9TDR0UyIOAEDJSgZmJcsm6/wXN9QQHTsHdvRXp1oqKu+KJMP+HzO34u7W1lncGYMO8rdn0dlKyYJv/HnHYEP0RW2OOTwkQK2Ji2n0cDy0+o5jwD0J+D9x1jdG99Vi2LskaQi++wtBISK7y60=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 09:08:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 09:08:26 +0000
Message-ID: <a38323ef-f85a-4b7e-ad37-c0fdfab5b51d@amd.com>
Date: Tue, 17 Nov 2026 10:08:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <sashiko-outbox-217693@kernel.org>
 <e2451b28-908e-4ff5-a8ea-62ff074300e3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e2451b28-908e-4ff5-a8ea-62ff074300e3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f997537-b269-42ab-019f-08df448a56a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|5023799004|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZH/jlUKp+LGVU2hgwWxCaYlEnNliqTbBxStADVLWA8BeOTFdrA7sAiLoji+Sjtmnx3qE+jHP/yYUArMHXVfTQiXk0hGikI5dcZscAqLOIz11eK2uA31TPpP0tkJYX1dCzRJKMnE3yio5MK5qoqlEDZ61DSrl1YPku9Jo7kmn1A+IifbS7hNXueFbx5UHf9Zl21EwZu/fDCvV86uqDja5GrqenIrV3v5sQbA+gYoMRGd8HYtIwKYdLWSI6NrzH4c7ZBgrYGPOH64OQQcWN34WQgvXIgpxEYFDgQMecaqtYtB8JtajzPxUYtyvFKGt2zIsxzTH4HHDGnrZCnrIVArlR2CLwGnbjkRSjjPGPOl5vfImB+mC2PLw/jdcSrZsV5FKXPwi4uGjduCOoBAegc6rvGPSHTs7rS2ZXJsTEzIq4nO6zDQ+pfEC7g5hFK523CvLL15uhzHtgsGlWuhfkZCkF8vA7uSv661/YN+1oQMmJLWrGqhEOX/jQxiRsLqbHp5X1XgcPoUWZsn3bHO/1/hJJo3uuqp2xKVWKiDIuPmFPWVebWpONEuev+aC/HCvpefSucGfnT6+pA2UHV8crPp3S1ShiHKPSEkhOM4dR4BEScAV3+kGeSkGeuhzlPUmmJcxQclFvrXRJzSrjZjKILN1chKNN3U5tOnQ1IWY/LD9vaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHh6UldKVUJEbjdacjlSdXE5YStWMSttR25PWllBckx0NmVBemVIU3ZqSnhJ?=
 =?utf-8?B?SmRUWnRDOFhYdUJsYkQ1Ujh1dmJkQlZUU0Z3dk5kWmFFWTVYTmRuVEhoN2tK?=
 =?utf-8?B?TmNOS1U4bW1mMUpLSVpIZldmTjRFejFFeWlWblQvWjlOcFpwbzhuVE5GaWQ1?=
 =?utf-8?B?K09qZllXbHZudnlBckNBbG9yZzF5bkVEa3lHMVEyWENLTnNsN2xNenB5OUZQ?=
 =?utf-8?B?c2JGaG40aVlIWk5rZmJlODRrVFhDOGJGeHJMdXRIWTFQMUdTN1VZdUxrN1Q1?=
 =?utf-8?B?ZmhXN2h1WDlFVjBzNWdONnVDZGwzdEs0bU9mT0FZNHd2ZkpUZDdZOTQzV0JW?=
 =?utf-8?B?VnBJWE9iY0IxejY5WkNZeWRXb1FYcEVqbEFYMDNIRlo2ajd5aCtPYVRsQzY5?=
 =?utf-8?B?ZGt3UFJoc013YVRQbWFsUm5rZ0NaWXA5a1hTcG93U3ZvLy9tVXF5VXNOZWpM?=
 =?utf-8?B?M0Q0dWhJYnNOblMvcmZrVitDcGZxTjR6SWpQYWVPbFc2d1k2V0dzbElHZVpO?=
 =?utf-8?B?amRhZWF2c0RxUFRIdHRJV3BTOWZFWVk1UlFxNmRtaVJXVmZlS3dDNjlKUkdD?=
 =?utf-8?B?M2JuS29IV2hnM0FzVSt0LzkwMWFLT20vb1dsK2lpRzNNQmpZamZ2ZXpsSlg4?=
 =?utf-8?B?bmdCQnJwZUtwOGxKaFF6cjdxU1grbVR1MlBYeUxXQlZPZ3VndGJ0SmFVc2tB?=
 =?utf-8?B?MVNsMmdvN0YzNTIxQi9zbXRoTC9oNytGN280ZVhtZDJBdEwwWjFxMlBSL3dC?=
 =?utf-8?B?b016d0lJL2hnMnhWR3g5cWpFVU81YVVGMUlQTnBzZEEwTEowSVQ4Q0ZMOERW?=
 =?utf-8?B?RTFpc21odFAwUkd5ZUtFb3phWEdQaEp2aXpaalBPSVNUZjk4eEtTdVQ2NDVN?=
 =?utf-8?B?bkZFQVhFT2pqMFpYRXNDdmtrbFFYODN4TGp6QnRSR2NrdmJjUFRVdy9IdXlV?=
 =?utf-8?B?N0U0Q3pZci9uZDQwRVF3OGI2czhiTytBdUozem1JSGlZRnJrUzJPc0xCOVRW?=
 =?utf-8?B?cTUwR1VDdjc3aTRhbVNmZjdJVzV3Zjgwb05HNW01WE96RnJ6YWhkT29Nbzcx?=
 =?utf-8?B?eC9GRmJ5dGYzbXhiWWNrZ01lSElvaXYxc2JleFVJeEw5b09McFhJRWQ2Ymd0?=
 =?utf-8?B?TURUT2k3SnNYUGtQdzhDVnUzSWxTLy83Z1RGbXJyYnRYZjBlNDRYYkpiVkQw?=
 =?utf-8?B?MWNueWVLMXp1bFN0b2lpYllndUxoQWhXOGtKWU52T2Jtd28xQjF4a05CR2l6?=
 =?utf-8?B?WnVTdEw4NmozUUU4eW0wRG1zZDg4aHlPM2tIOTlaYzV3MnU5dDRCR2FyQ2g5?=
 =?utf-8?B?MWhBdTcrbHFUZXdZcTZNUU5Pc3dlNlJPeGtEbGE5WVBtY05KTkFlMTUySTBI?=
 =?utf-8?B?Y0hYajJjUERRY21rKysxWnI5V25keXpNUzB5eXRxeGRrOG1aN1dYTHRDTFJ6?=
 =?utf-8?B?dmpHeldudDlzOC9FTkhYSXBTNWpNRXA1TCtmcnJTMTVCblRpU0lDTEtXZTQw?=
 =?utf-8?B?V2VrMHBIZU5QQmVxVWovanRjZDEwditVR0xsVEs0RkZOT21NQmN6L2RVNzRJ?=
 =?utf-8?B?MmxkdHdtR2xqSlA2c2VhZGZIRnF2S0dtVVg1RE5selp1VWF5cS9DaXZuVlAw?=
 =?utf-8?B?VVNLUTFOWjhUSlZiV2ZXZnVaOExIbTJ4NHFKTkRUNU4vd2xpbmFQalRGYWt1?=
 =?utf-8?B?bjVEcEVyU2xyaUcvN0Q2RUIza1BacVd6TXE1N2FEejZ4K3c2VlgvUWo5cStD?=
 =?utf-8?B?S2Mvb2ErTmJ4c241S093RWFzWXIwMk40bmhDRWZjQ0ZyMEZGcGwvdGgrT3J5?=
 =?utf-8?B?dkphMDRtdU5QdjlSRjliTGJza3RkdWhuMU9sZllIaTR0TWZKc2Q4MmNDNlFq?=
 =?utf-8?B?ek5xV3lhbnZDR1hienNlQ1JldGlFUis0bXRDbDIycEJpejVkM0ZoVFVQVDY5?=
 =?utf-8?B?dUR2RlUrNHVNdjhsNVZJcW9RWExNZEN6TVRKc1o1bmhublFSREowWnZQQTlF?=
 =?utf-8?B?bEJVMW1PVUNhV3k4YXU5UWwvd2tFT3luUnlzeE9JM01ueEc5eGw2SzFVeTRB?=
 =?utf-8?B?czFGL2RkT1d3L0E1b094MXNuWW8rSS9SUGNEWU5BREtway9WOGhzK1dGMEJ0?=
 =?utf-8?B?RDY4VnZBTGdROG43L0c3bEpkTWlEUHFiZDk0LzNmazNMNTlnMFNTT3M0SGlS?=
 =?utf-8?B?dktodWxlbHl1SG5NZTh1b3dGc0k1Sk5iTmg4Wlh3VHRYYVNpMHdja2VVVlJL?=
 =?utf-8?B?L2w4ck9KVHdTdkphMmJycHlkV0JzTFpha1RxSU9oZlZKT1RzRE91QzlYeThJ?=
 =?utf-8?Q?BoX/NTZ8t/n4OwS8zA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f997537-b269-42ab-019f-08df448a56a8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:08:26.4633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VytZkyq7q/2isGZH9BgsiS0Pdj9JhvC0qCal8BH2JQ4aiSgmxztE3/qtSBTNwDgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 22:21, Mario Limonciello wrote:
> On 11/16/26 15:13, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issues to consider:
>> - [High] drm/amdgpu: deadlock in amdgpu_device_flush_file_entities() on
>>    suspend
>> - [Medium] drm/amdgpu: race in amdgpu_device_flush_file_entities()
>>    before run_job()
>> -- 
>>
>> commit 2d3632cb05b8d04352d9590da3fabb5b096f1b19
>> Author: Mario Limonciello <mario.limonciello@amd.com>
>>
>> drm/amdgpu: drain queued scheduler jobs before suspend
>>
>> This commit adds amdgpu_device_flush_file_entities() to flush the context
>> and VM scheduler entities of all open DRM files during
>> amdgpu_device_suspend() before evicting resources.
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 19a566187dfb5..d18348116d3f1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>>>       }
>>>   }
>>>   +/**
>>> + * amdgpu_device_flush_file_entities - drain scheduler entities of open files
>>> + * @adev: amdgpu device object
>>> + *
>>> + * Wait for the scheduler entities owned by all open files (the context
>>> + * entities used for command submission and the VM entities used for page
>>> + * table updates) to run out of queued jobs, so that nothing can slip into
>>> + * the rings after the hardware fences were waited on at suspend time.
>>> + */
>>> +static void amdgpu_device_flush_file_entities(struct amdgpu_device *adev)
>>> +{
>>> +    struct drm_device *ddev = adev_to_drm(adev);
>>> +    struct drm_file *file;
>>> +
>>> +    guard(mutex)(&ddev->filelist_mutex);
>>> +    list_for_each_entry(file, &ddev->filelist, lhead) {
>>> +        struct amdgpu_fpriv *fpriv = file->driver_priv;
>>> +
>>> +        amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
>>> +                        MAX_SCHEDULE_TIMEOUT);
>>> +        amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
>>> +    }
>>> +}
>>
>> [Severity: Medium]
>> Can drm_sched_entity_flush() return while the scheduler worker is still in
>> the middle of popping a job and before sched->ops->run_job() has emitted its
>> hardware fence?
>>
>> CPU0 (submit_wq)                  CPU1 (suspend)
>> drm_sched_run_job_work()
>>    drm_sched_entity_pop_job()
>>      spsc_queue_pop(&entity->job_queue)
>>      drm_sched_rq_pop_entity(entity)
>>                                    amdgpu_device_suspend()
>>                                      amdgpu_device_flush_file_entities()
>>                                        ...
>>                                          drm_sched_entity_flush()
>>                                            drm_sched_entity_is_idle() == true
>>                                      amdgpu_device_evict_resources()
>>                                      amdgpu_fence_driver_hw_fini()
>>                                        amdgpu_fence_wait_empty()
>>    sched->ops->run_job(sched_job)
>>      amdgpu_job_run()
>>        amdgpu_ib_schedule()
>>          amdgpu_fence_emit()
>>          amdgpu_ring_commit()  <-- ring written after fence wait
>>    complete_all(&entity->entity_idle)
>>
>> drm_sched_entity_is_idle() reports the entity idle as soon as
>> spsc_queue_pop() empties entity->job_queue, before drm_sched_run_job_work()
>> calls sched->ops->run_job() and complete_all(&entity->entity_idle).  On APUs
>> such as Picasso where amdgpu_device_evict_resources() returns immediately
>> during S3 suspend, amdgpu_fence_driver_hw_fini() can finish waiting on the
>> ring before the popped job emits its fence and commits the ring write
>> pointer, leaving the ring hang on resume window open.
>>
>>> +
>>>   /**
>>>    * amdgpu_device_suspend - initiate device suspend
>>>    *
>>> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>>       if (r)
>>>           goto unwind_ip_phase1;
>>>   +    amdgpu_device_flush_file_entities(adev);
>>
>> [Severity: High]
>> Can calling amdgpu_device_flush_file_entities() here deadlock runtime or
>> system suspend when an entity has a job waiting on an unsignaled dependency?
>>
>> drivers/gpu/drm/scheduler/sched_entity.c:drm_sched_entity_flush() {
>>     ...
>>     if (current->flags & PF_EXITING) {
>>         if (timeout)
>>             ret = wait_event_timeout(
>>                     sched->job_scheduled,
>>                     drm_sched_entity_is_idle(entity),
>>                     timeout);
>>     } else {
>>         wait_event_killable(sched->job_scheduled,
>>                     drm_sched_entity_is_idle(entity));
>>     }
>>     ...
>> }
>>
>> Because the suspend task or runtime PM worker does not have PF_EXITING set,
>> drm_sched_entity_flush() ignores the timeout and sleeps indefinitely in
>> wait_event_killable() while holding ddev->filelist_mutex.
>>
>> In amdgpu_cs_ioctl(), a runtime PM reference is only held during the ioctl
>> itself, and per-job runtime PM references are only taken in
>> amdgpu_fence_emit() when a job reaches run_job().  If a client submits a job
>> with an unsignaled syncobj dependency, runtime autosuspend can enter
>> amdgpu_pmops_runtime_suspend() -> amdgpu_device_suspend() and block in
>> amdgpu_device_flush_file_entities() while the device status is
>> RPM_SUSPENDING.  When another thread or process then calls amdgpu_cs_ioctl()
>> to submit the work that would signal that syncobj, its runtime PM resume
>> waits for RPM_SUSPENDING to complete, deadlocking both tasks.
>>
>> Killing the process owning the blocked entity does not break the wait
>> either: amdgpu_flush() times out after 2 seconds and calls
>> drm_sched_entity_kill(), which drains the entity without waking
>> sched->job_scheduled, and the exiting task then blocks on
>> ddev->filelist_mutex in drm_close_helper().  During system suspend,
>> amdgpu_userq_suspend() also runs right before
>> amdgpu_device_flush_file_entities() and unmaps usermode queues while
>> userspace is already frozen, so any entity job waiting on a usermode queue
>> or userspace fence can never make progress.
>>
> 
> I'd say that these findings both look real and this being able to potentially deadlock the system means it's not the right solution.

That's just AI nonsense.

All dma_fences *MUST* be signaled before suspending and runtime PM shouldn't be able to suspend the HW while there is still work queued up.

What could be is that runtime PM is not correctly implemented here, but that is an independent problem to what we try to fix here.

> How about instead we stop schedulers with drm_sched_wqueue_stop() on each of the rings?  Restart then in any unwind and resume paths.  That's kinda like how SDMA already works from what I can tell.

Suspending with pending work is completely broken and can trivially deadlock. So we should never call drm_sched_wqueue_stop() from the suspend path.

What we could do is to issue a warning from the run_job callback when we are already suspended.

Regards,
Christian.

