Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7326EF5A8D3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 03:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC2910E13E;
	Tue, 21 Apr 2026 03:21:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dagduf9s";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F65910E13E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 03:21:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBqWBBpYiCy/qBmhiIJKiPgM16kFIBgHmMvVzjCjn1ZjHDynUyJtv6mUsRUows14hwp6CFPp7jc2w4pJSjekO9xRHnVNP7ldPrUFF9oi2WlF2x8QpD8M4tCAPRGnJtuy16ehrQVKdkMaXqBXXkDu4In+DaVF1y14FRiy5+aKnIPSqoVpUpnEfac/fYqeZbo+hZa12hsJs4aJ9/eMXKqV+qjfDJDZOR8nD6MzFgo5BswxjNPZEgvw+9Tvtl35tiCPMjMcBqSWSvg2x66gjj60V/FXNJe8XV69ejP6ehMbbMdY5KDf4cY891iE6f15RFiYZdsPZQL2dWSgn5M6lVv04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzkHuOaWHtSe0C1m+STdyAOXVVnJyFHeTjbEvuPdfEw=;
 b=j/UWCEa/nrh5TjBdyG3O8n/f9AG2uewYHj24BANTOnmcLLMADomogc2qq7MzvzkmKIpb+Se5/qNKQBqNcJa5FgejgAEpGYlWYi5EKyLGLJs9ubMSQ6XcAaJTqY0WkV1OxlgV3fmBz4lBmwCGRF1nkCTjdcozAxGdPWutoKStHUXls+cqM9ZAsv9lNsDv5mSrBMTZ62VNl8Gf91CTCHvoPF92UhP5n+Yw9Hu1IAhc+peRodut/EftOyElEqya1wJnykHAarN+NMEOb1VKvAkDrx5L+IBWlZbxRKEF53oWsSUkvYhPe0+YLyrivyeuS9ekGtQYrqCtiJ67JN94f5+zWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzkHuOaWHtSe0C1m+STdyAOXVVnJyFHeTjbEvuPdfEw=;
 b=dagduf9sBnb5NGBvTS6M6iNAwBHAl8b2pcYx1RQLzZjjQfw92a6J513B84xvG2B9RP7PXQNpYWyf1ganbXzBKuZsO0PSQIaiiDojGQ3ijRyJhatiP9/wKS8DTC+7sD9ZxhAaToNLnhftL9PMQyfsZFLs40rCJPcBYTINJN8Y5l8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by EAYPR12MB999132.namprd12.prod.outlook.com (2603:10b6:303:2c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 03:21:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 03:21:33 +0000
Message-ID: <f1e6e2f0-4ba5-4d91-adad-f75d5d781c6d@amd.com>
Date: Mon, 20 Apr 2026 23:21:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: Mario Limonciello <mario.limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>, Xiaogang.chen@amd.com
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
 <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|EAYPR12MB999132:EE_
X-MS-Office365-Filtering-Correlation-Id: c75dff9a-e0ab-4bbb-588f-08de9f5516a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11006099003|56012099003;
X-Microsoft-Antispam-Message-Info: KgJiDNnH30lGD68qbB1ykbuJ3ocqX2TL1LwB3Vu9tzKDi4t7DOL46ZiKGpsBbBXChjdXUJBSUKsxP7g2CmDx/XICtbqk2Snsi1nfdn2qHsUsIOsNbkm4vxZ7eehq6uI2uVp2AvEok4AFRq1M9LAHeNVR0Lr3UYIwBoAHpS2WplZSDUjiKsfIkFUgl/uRi5A/41hpI3j6o2n1zFE710fp3CXxtI7+IUtDwSg0T2dbYtAm0QafHTWVC/V5r4WvpqavbZ2c3rmeyZ5i/e/CbJfThGwAM0yuDwyWBj1wQ85YvcNMbprSGFIHa3A/vDpv5cnorzdA8l/RduXAXxT5C8kC0idvJ0wJ5AaPpVMvesTxiSNIOigPSpoEn4Hh6W2kQxPRfzdfJJMgi99i3C0POQKIUjwQ/CDVM7P7hu3RTYwtbkHbWWJy0GT/AdmcWoJTjXA8Aq4emNGR9q7ULqpyDawTVxKuWZsvx8yF34kDh7BiMRolJNDhow+4iGKFeN2DzLuvSZbBueqEK8/TjxuWFxj3keCFvWRIwOO9+Zi0RY54o30H7OrK2Zc+p+EIKYLI65IGi79c4Vg+a03of5QFBQyIN/uahcexkMZOS9pl0qmdzvcurAUrN11TlULjEjsUV/RSAIuQ821wRRd4OwczQv142VlKZAK/DXieW+ta9jsae6IwTnniL39UqfSATmWVKNQF2HvL75jIAR2AhLFTzbXI6IqtywWAGY8NQeBFQg+2s8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11006099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2MwSTdteDFpQkhINEJnMjNwR1p2R3FiV2gycHlsL3FjK05jUytnWjlMTGFH?=
 =?utf-8?B?RVFsOEhRNTVJcFFZVEp0cWtmMU03UnVnTHQ4OEJSZ3J1US9qYUdKK0wrZEtG?=
 =?utf-8?B?ais0Ly9WSFZEbVk4aGlScjNGcnJTTGszZW1MK2lqSDNFNWY3TjdHQWFERmth?=
 =?utf-8?B?Rnh6M01zQ09wODhlQnhUUkRYSm9VOHlNcXo4WUtGMlNDcDJBelVPTHNKS0Z2?=
 =?utf-8?B?eFcrWUx3WUh4UEM4QzlCWXNCOEVXZjFTaTU1NmpCOTBUSy94cEthSGdIT0cz?=
 =?utf-8?B?MzYrVzV0eGt5QmI4UnhnaUJwNHBhQThxcTRPQjBwT3BMdXpyNFZET3ozcmVs?=
 =?utf-8?B?VE1RUmppZ1lMZ3RQY21CZVJ1ZHk2MXB2RmNUV3B5VVpPMHBaYUdJcVFGMlpy?=
 =?utf-8?B?TTgydGEvUzlxWm5maFcxakZmMno1N3Z6NEpvN1dXK2NPTGgxTFBJU1hKa3Nm?=
 =?utf-8?B?QUdUdWg2aFIrZHFKTm5yK1h1OUxUV0x4NksxaHo4c3gxOGRFeFg2U1BidXoy?=
 =?utf-8?B?d0F6SDZydHZlRkh6ejlONlVlUk9NVHJKaFFrdWpxd3I2U2hxTDMxNDhEdUZh?=
 =?utf-8?B?alJJdkUxdXVtZTBjektTWTJRUmxFc1NhNGg5MXcyMUxCcGVzNDkzMjBnNUdR?=
 =?utf-8?B?bkJncEFjZTBYM0NHbTlzNzhXYXR3MnB5NVloemhtSTBLVUFORTJERnUvODN1?=
 =?utf-8?B?TjJKbVg4SFVPOVhvZnhUTndkbUtKdFFYdmtrZU1DblNOQ1pMWWxZdEwxVmZO?=
 =?utf-8?B?ZDE3d00xNnFIUng2UDdmL3VJZWV6bkRiVnc2eENNSTc4dU9KNkRDeXhLeENr?=
 =?utf-8?B?aXV2dmgvYng0M1dxdnZtQlVLOURYdTB4ZUpQb1FSRXNUc2FVQzV4S0swM09j?=
 =?utf-8?B?bkdZcHd3T0pyS0t6Nno4bDRIMUJHRzNTYXNkcjhKMWNzWVo0SUJoSERzOTho?=
 =?utf-8?B?QUQxQ2hPQXc1cUV3aEQ5S0F3RVFhaVZ0V3oyVzc4VmJzT3hXa1UxOEc1S0tm?=
 =?utf-8?B?dzdEWG1GVEVqZTlkNUdRNW94WTVndWJzV2ZYTE8vMTAvc1RhTGU5R3A0ZHY1?=
 =?utf-8?B?bC8vcnFOZzY0M3BMNVhxcjJHZTluWUNrcm5QRDdJcmxjaUxGT0lMY0RESzA4?=
 =?utf-8?B?ZWgyU1B5aTJOSUNKR3daNlV1MGd2d3NaVER4RDF4Uzk5Z3FvL2RvTlJnc2tH?=
 =?utf-8?B?cFBwTnR5U2tyK25TQVhHbVRYQnhpUUZYSE1EQ2NiRGFUQzJGMlNXY0lXODJi?=
 =?utf-8?B?RlAvNlZQL1RxcWpablI0dXBjQnBGajlHOXFKMjNGVy9OK2pFNkFrR1Q3Lzha?=
 =?utf-8?B?NzhVNWtpYlhkWTBqUk9nb2xjOFdJWW8rczlVbDFIOHlQYncwakM1UVZrU1k0?=
 =?utf-8?B?NkRhQWZVc1JNSTdVVmVJekF6cGdsbGhhbUcxaGI0Y25HanI4V1IwZmozakhy?=
 =?utf-8?B?SEx3d01zbVdwR0xaKzRxcFdValBEYmpXWExSTXpGWlRHRUI5UW5lOFBxc3Nh?=
 =?utf-8?B?NkY1YlE5eFhEZmdhM2VKVC9Ic0J0ZGNPRUNpbWUydHQreTl3TEY2NXkrSXJw?=
 =?utf-8?B?TWl6UHJ4anVzM3lUa3FFdUdzdytEcVpXcDhIQ0FzdGRmUVYzb3VDbkh6SVk4?=
 =?utf-8?B?MWlET3lkdnhSaERVcU1HdDZmd3FHMnpEQzFNeTNXdjRlNjBpZjEzMVhIQ1k0?=
 =?utf-8?B?czJqWVhJUGx0aXBSZU9vdkd0M3dUNkQwdDVITjBxM0hraHVKSlVoOEs5emVB?=
 =?utf-8?B?YVlaUTFMTFlnSm4vaVZCc0swcG5Rb3NHMXBXbDZKZ0hyVVV5bko5Mm1mL2VV?=
 =?utf-8?B?WFhaNjJ5eUU5N3c5U0s2YnlZeGpIaDljWmhtSXFIb1BjTHVDbkFhMWpSS2lr?=
 =?utf-8?B?MVBzb2VEYTBFNHF6QzlvK0dYckl6OTJmWnpsT0lLUTBpREZMM2RTMklNTDhH?=
 =?utf-8?B?Ni8ycEZUT3I5LzFYT2l6b1ZkUDVYa0VtV2paTlFrQVh0RFY2OFRlUlpOQXN5?=
 =?utf-8?B?c0VQMHNrcFdyTUt3K1VnNy9NSHZZUEZUcFNZN3VHUU5JWEpUNWhQYURvMzZ3?=
 =?utf-8?B?WEh0MVZBOEU2VWpEYytXcWVpa2RxUnZXVmRQbExBRFFlUzVnV1A5WkIxRHAz?=
 =?utf-8?B?cXNSZ2NQZzdoUG03NDA5TkNKblJZeWlqQWZLNVJKOGRDNTNRb2w5SXNNa3Fa?=
 =?utf-8?B?SXBZWkY5WDQxbW1nWUNMam5qUjlyMlRYdCtDZzNjMUNtaEU0K2VKZlZTc09R?=
 =?utf-8?B?ZTlCajhBZUFpQXhEcVNNUGFqaVlST0poaE90MVlMMUlBeVZpWW01SjZtMlhi?=
 =?utf-8?B?cGxWNDc4T2phM1VMK3J3UWlTSDRobUhGZm5xbzVkaTBCNHp0VGZydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75dff9a-e0ab-4bbb-588f-08de9f5516a3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 03:21:33.4979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: finwNcZY5mAcQXOwBFwSHn05rbJYIaxZtbkFw96QLro3d7jyreska8RBHKrx6+WP5mXwyzMEFm7NQFaHongjBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999132
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

On 2026-04-20 17:25, Mario Limonciello wrote:
>
>
> On 3/7/26 06:49, Mario Limonciello wrote:
>>
>>
>> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>>> When a surprise unplug occurs while a process has active KFD queues,
>>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>>> properly clean them up. This leads to a WARN_ON in uninitialize()
>>> complaining about active_queue_count or processes_count being non-zero.
>>>
>>> The issue is that during surprise unplug:
>>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>>> 3. This leads to kfd_cleanup_nodes() -> device_queue_manager_uninit()
>>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>>     dqm->processes_count > 0)
>>>
>>> The warning triggers because the queues were never destroyed - 
>>> userspace
>>> had no opportunity to clean them up before the device disappeared.
>>>
>>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>>> calling process_termination for each affected process before
>>> uninitializing the DQM. This mirrors what happens during normal process
>>> shutdown (kfd_process_notifier_release_internal), ensuring queues are
>>> properly cleaned up even during surprise removal.
>>>
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Cc: Kent Russell <kent.russell@amd.com>
>>> Cc: Xiaogang.chen@amd.com
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Ping?
> Ping?

Hi Mario,

Sorry for not responding. I think one of the reasons is that the people 
you CC'ed may not know how hot-unplug is even supposed to work with KFD. 
I think most of what the process_termination function does is 
unnecessary because the GPU is being unplugged anyway. But without it 
you would leak the MQDs. I think that's the only good reason to go 
through this. One the other hand, could this be done later when the 
process actually terminates?

I'm also worried that we have pdd->dev pointers that will probably be 
dangling after unplug. So maybe this is only the tip of the iceberg and 
we should really be cleaning up all the process-device data structures 
on unplug. Then we'd also need to make sure that all the code that loops 
over p->pdds is able to handle NULL pointers gracefully.

Regards,
   Felix


>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 ++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/ 
>>> drm/amd/amdkfd/kfd_device.c
>>> index e9cfb80bd436..7727b66e6afb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev 
>>> *kfd, unsigned int num_nodes)
>>>       flush_workqueue(kfd->ih_wq);
>>>       destroy_workqueue(kfd->ih_wq);
>>> +    /*
>>> +     * For surprise unplugs with running processes, we need to 
>>> clean up
>>> +     * queues before uninitializing the DQM to avoid WARN in 
>>> uninitialize.
>>> +     * This handles the case where userspace can't destroy queues 
>>> normally.
>>> +     */
>>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>> +        struct kfd_process *p;
>>> +        unsigned int temp;
>>> +        int idx;
>>> +
>>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>>> +        hash_for_each_rcu(kfd_processes_table, temp, p, 
>>> kfd_processes) {
>>> +            int j;
>>> +
>>> +            for (j = 0; j < p->n_pdds; j++) {
>>> +                struct kfd_process_device *pdd = p->pdds[j];
>>> +
>>> +                if (pdd->dev->kfd != kfd)
>>> +                    continue;
>>> +
>>> +                dev_info(kfd_device,
>>> +                     "Terminating queues for process %d on 
>>> unplugged device\n",
>>> +                     p->lead_thread->pid);
>>> +
>>> + pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>>> +                                       &pdd->qpd);
>>> +                pdd->already_dequeued = true;
>>> +            }
>>> +        }
>>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +    }
>>> +
>>>       for (i = 0; i < num_nodes; i++) {
>>>           knode = kfd->nodes[i];
>>>           device_queue_manager_uninit(knode->dqm);
>>
>>
>
