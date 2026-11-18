Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF59606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s/8+1yeI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006C310E5EE;
	Wed, 18 Nov 2026 18:02:24 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C165610E5EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDlOAPTfghij59GRw+i0sk59bK1O644pFLoTEyszbGBdGWJDKsCO0mSNrJXXpzr8Uq9dbETlt4WxSu2Q1tNz4faju/a8PjVWyrtU2wFWkbpoNj91wueKwM58Vs0DPag/dRKFNGUnmL6B84V1DtFXoDJz7H7QIKFP9ryDFVssuFP+VoT7uG5Lf1YhsB8F5yF8pUwOnNbwsdcIWMAfDAtZF6nHJyrcXanpB0i2Zd/F4t2z7ZKJbR6Fe04zIXzLlmOVthvJsy7vQYK4yFE9Ahuj8tZ5jZqNsBKNjvXHwdqhGmXkA8gFAtv6Qi8EbNyH17K9118bHCvACKCUjG8ALr/hvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25Pc9n6MGGglfdMf76JanAjaGPvH/yTIskgfQrkyCPs=;
 b=miTOZOUnYwsZLjMnmrZKYToqjPAVlRCFNXr7OIig7nVbUW9/lyVVP+qXxSuNgpVqerxG10Cqsj0WcC6wWTzvd343BU1/4yGSExJG1AgWjq5vzyd3oF4g34zKALMvAFGlg+M4nEGdLCG3Y+KltuUIvzgsgNVBF1B71wkJD2dhjAZoN2eD22G98t7JpcA5pJ9WADvCb7owk6ojEAVn1DZ0jH4i5m/tQ/YUH9hQtR8AXqb+BJ/NGhJN53W1oRiswDOBSa0vadzP7HWQ/jCi4+v6Lya8hPElbVUmchBOXavyiWLK5LVonOI82cGA4pR9IRMDVvfJI9x5jXlC3oTfw8eVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25Pc9n6MGGglfdMf76JanAjaGPvH/yTIskgfQrkyCPs=;
 b=s/8+1yeIzUwUPpSRqi9MJKHzRF26BI6hFvi5fgJI4DNxuT/GC/NcTh2CzrZMy7HvTUPWRzhjdDFeys1pf5CLeTxVdFcrTFkH4iFibYHaW5aACz+7V8Lc9YL4uCmMpuRpGe3tu8Mko4IqEL5oDqAxWgxgFmGsOSMufvRIudfHi0U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Wed, 18 Nov
 2026 18:02:12 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:02:12 +0000
Message-ID: <46f92a74-e83b-4025-98d1-d94f1678a418@amd.com>
Date: Wed, 18 Nov 2026 12:02:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Swap order of svm_range_dma_unmap_dev and
 migrate_vma_finalize
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261118151045.134908-1-xiaogang.chen@amd.com>
 <20261118151045.134908-2-xiaogang.chen@amd.com>
 <3adb82f7-7e82-4695-bbb3-4adc95787a11@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <3adb82f7-7e82-4695-bbb3-4adc95787a11@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:806:f3::25) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: c440ad24-db59-48b9-c851-08df459e1210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|261009223027099003|18002099003|11063799006|4143699003|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: sK357V+b2kogP5z+X4NcC+LL+DkVLqnnw7tQUoEsmvaLldHO36w/1Zb0GMO/xSP2YfNXZOgfEonnYI/iHjoe/ntlpl8IhuFCE+P8y5JboGJe5JUxL61HRA3suKb4nxr+Ts4lje4m22ZS8wjP/BNI1MyHTCpLntz4L+NWpmc/NjPhFhZzYPEHoOaRWZK82nErvow16+fe9xHvQunNQZQm0Uo4kCKm98m3DFGWyBudnf3y2CoCYL1TEqSXTzQVtsvYAOijfH0uyalOiluzdyzR4qZZLXXR4/mlFGlC6XogQqS+fn6wA7KvIuj5z0vddehlAe4cH3jULohyoqQt2WmeJEHyQIIaerFFI39VZ1cEhnOwFgjJj4mU6IRwclpvtafTcvDeoxdBz46KmvboCpBTK85qlyaU9Sz0Dg/WV4sgkTy05GVv+K9eDmV6k9QOWzxJE1hPO634noF5jqaIdFTUGg3Jg5SZNSevxXre6kRp3SGKQDIi8lBXjxubkJr08DvvPKoigXjshKgpXfyWR7phdQqmTn0eecAukzjbIxsQhYpTbnzKLj7hBKvHNuZTXtdhpHwt/VcVBkTNb1TQb9QjjGh/utUutlguaGGDli1Q4nuIrgKO5gsjKjj9LwWDd5IIxb9pbmzQoA+6ejBoAuW+n66wiLu9mNEzIzkLmwcrNqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(261009223027099003)(18002099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBtak5GUjF1bEs5dzVMdU1neVI5WVBEUytyZFZVSWtXbFdia0MxcDNERHhr?=
 =?utf-8?B?UFF1dDFLT09mREJyUzljUWhEZmtoNzB2ZFVhNlVjODJPSFFvYzdBUGY1b2JJ?=
 =?utf-8?B?dnQ4Z2NxVExTK3ZPOW1FaTdwSlFiM3ZxSCtPaXpPSjJLSTdiWWNNRXAvWGlR?=
 =?utf-8?B?NnUzb05xS1A3Ry9zV2QzcDNtaDVNVFpDSk5vd2dkVXpkQkp3OVFuL1U0OWZT?=
 =?utf-8?B?ZDdxdENYMDJZVjNpYlBPSHZDZXNLSHNGUExMNFp3WVE5amJRS2ZzNVlEVjdJ?=
 =?utf-8?B?aFZaSXdBOWVvc0s4ZDQ2OFNSS1g1NmorOW96b3lSOW5ERE95bDVvenRMOEhK?=
 =?utf-8?B?czczeTJSQ3NPV1M1ckpkcEx4am1MZ082Qk1idWxZOXBWKytQaDBjNzVQQTJm?=
 =?utf-8?B?RUZZVysxTFF5MDlvSGJOOE9hYkVMZEJ3MkIzV3pLQUpFeUgzT09WZUdTOHpE?=
 =?utf-8?B?VFJQYzRNZXhoNnBLUDVHWVB3Y21jV2wvQVcrWTVsMU4xVXIxMHZaUmVURjZ1?=
 =?utf-8?B?R0NXejdEMHhvWXJQRXhCYkRydW5Ibi9TaTBmR3k1ZUFsQW1lVDY3MHpTYXYz?=
 =?utf-8?B?S0dqYzE4V1g3ZTI0WG0rV08rcm5DM2hBOGd5ZVZJUzJ2ZGVteUpkdEtldkZL?=
 =?utf-8?B?T2lsc1ROZnRxcFIrbEx5ZTFpR3AyYTg2Mkh6NGFBUDU4clhBVU9IbmxjV0l6?=
 =?utf-8?B?ODhTVTBvQWREM28xZGtwWGF3SVZLRk9aMVBWTkhYdEsySUtaRC8xckVLRUh0?=
 =?utf-8?B?bmMwR0w5VHp5ZTF5VGlUM0JrYW9mcDRua3c2alo3MHJCa0kvL2pJZVVxZFhs?=
 =?utf-8?B?QWhEcDBaYXR0Q3NaNWRLVmg0Q2xBd2t2UjVZSzhHcFNDR1YrTmhqLzdvMlUv?=
 =?utf-8?B?cERzajRTd1BEMTJOWks4cnBlUGNxS0FyaStBeWtocVN6WXdiVm10cVI0RzE4?=
 =?utf-8?B?SHpQUTFKQkkrb1pLTDcyQWtEaldRTU1BVWROQXM0L0pEZU9FdW1yK2ZweTNV?=
 =?utf-8?B?ditXY3hxajZtSjNFdHpoQlJodzhOSkMyR0E0TkVIWHp5S2pKSUNtSVYwcnJV?=
 =?utf-8?B?UHlRYTlhdFFpNk9SU0w1Y2xCM0FoZzNsSEh1MHNaM3NrcWJpZzVZUElzV01j?=
 =?utf-8?B?aUZFR2tDdmVyK0gvejhMRVhXMklQeUJNdUNFZ1hRMXZTcnJNK2NDbU9qTlM1?=
 =?utf-8?B?YlhETnhJTUdKVndrQ2tHL01iUmp5aEp1eVdIOVhHY015d3ZuaDB5d2dDRmZt?=
 =?utf-8?B?NDhFRUZxWWRLbDFDQ21RVGhYQ1pMaXYyQTc0clEwci9GdGV2UWdkd0xxclFi?=
 =?utf-8?B?N3VyVUwrcHV4RnhlbGxqUzc1aWlwY0NBRlJNQnFtL1dmVmQ5TEJSR3JtOE1U?=
 =?utf-8?B?eU81VUUwcXdocHRTR0NsN3hiUUZKbW9KSEsxOFJuZTZjaWNuU0pnbS9KWkhv?=
 =?utf-8?B?L09xQ3Y2bW5zTno2eFZ6V3NEQVp4Ylk4NXVTaUxRZzJ6WnFFOTJ2Z1Q0WWhl?=
 =?utf-8?B?ajNPUUM0ODd5ZFdoWDVYTkV6K05sTWZrOTdrQXZRWFY5bXhmbkFaNTRNSW9r?=
 =?utf-8?B?S25OY1QrZnc5NlFRc0p1MWs3cWM3SkxZcHFOWUdpd0x3L3U2dnpuRjlqcmJr?=
 =?utf-8?B?L3MvRTJtbUNEQzFiT0owa09pODhXMm90RHBKeXkrSHIvMEhlbnhNOHpJOUtl?=
 =?utf-8?B?aG5RQmN6b0tUOUdtV2FCMkZ3b2xNaU5naklDODI5MFhHa1UweVhtcGF1VXVl?=
 =?utf-8?B?R3A4Z0hlNS9sT3BxaDhpRjhxUFFWNEZOYnNvUGJpZmVzczQ2S2h4eWdZSGdu?=
 =?utf-8?B?OHIvRi93N0xXaFcySjZnT3h2c1EvaXV4NmtzMWZHY0FNUVp3ZjBkSHUzclJK?=
 =?utf-8?B?MTgweEtzZWZZOUlhUzVXd003VFprblArUGQ5SnI0R2NLSlFubHlUUkJoakRx?=
 =?utf-8?B?UVNpZE5pWHdwV1dGL3pueUE4NlFka3FFWFpmQjBNUUxKTitjODdBNnlEYXhD?=
 =?utf-8?B?Q1pMMytySU85TEh6VyszNU1uakZjTUlBVXZiNDZ5SkpDV24vVjVYd04wNWIw?=
 =?utf-8?B?R01HSXcwZnBsYVVsVjF4R1ozZVdRTHNlcFZKVUxmN3lEYm0yeFJ0ZUNJc2cr?=
 =?utf-8?B?SFVFWGs1WEN0ZFlka2VMTlg2RklNcm5jQVBnelBYV3RXejQyaHNLcDNIQUxi?=
 =?utf-8?B?di83Wk5oaHpDYUtmaUQ1YkZ6OFovN2o0YThOdGhhUndhT3VsaGtNMWIyZ2Vo?=
 =?utf-8?B?ZEg0bGZpbU1ybmM3REkxOEU2dGNFOCtXWDdzdUNZQ1c0QmJ5QW5INHBxOThh?=
 =?utf-8?Q?yxxx9KXqKl124Flhoa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c440ad24-db59-48b9-c851-08df459e1210
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:02:12.2363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgUbpaItX+tRzCNvLY//ZgAbbNIIXzrKNRhJq3md11cqWYNFiiDTa1BIKLVMAa/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
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


On 11/18/2026 11:48 AM, Philip Yang wrote:
>
>
> On 2026-11-18 10:10, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> svm_migrate_vma_to_vram() on success: migrate_vma_finalize() releases 
>> the old
>> system-RAM source pages. Only after that they are DMA-unmapped.
>>
>> svm_migrate_vma_to_ram() for slots that failed to migrate: finalize 
>> frees the
>> newly allocated dpages, and the unmap comes afterwards.
>>
>> Every mapping uses DMA_BIDIRECTIONAL. With swiotlb, that kind of 
>> unmap copies
>> the bounce buffer back into the original page, and by then the page 
>> may belong
>> to someone else. With an IOMMU, the IOVA stays valid for a short 
>> window after
>> the page is freed. During the window GPU may write into the pages 
>> that may
>> belong to someone else.
>>
>> So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both 
>> migration
>> direction to make dma unmap happen before sys ram pages got released.
>>
>> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> index 78a2aab81c17..4bcdedd91d2e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>> @@ -494,14 +494,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, 
>> struct svm_range *prange,
>>       migrate_vma_pages(&migrate);
>>         svm_migrate_copy_done(adev, mfence);
>> +    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>>       migrate_vma_finalize(&migrate);
>>         mpages = svm_migrate_successful_pages(&migrate);
>>       pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>>            mpages, cpages, migrate.npages);
>>   -    svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>> -
>>   out_free:
>>       kvfree(buf);
>>       kfd_smi_event_migration_end(node, p->lead_thread,
>> @@ -838,9 +837,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, 
>> struct svm_range *prange,
>>            mpages, cpages, migrate.npages);
>>         svm_migrate_copy_done(adev, mfence);
>> -    migrate_vma_finalize(&migrate);
>> -
>>       svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>> +    migrate_vma_finalize(&migrate);
> With the suggested change in patch 1, this will be
>
> if (!r) {
> svm_migrate_copy_done(adev, mfence); 
> svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
> }
>
It is sys->vram path. There is no dma_wait at error path.

Regards

Xiaogang

> migrate_vma_finalize(&migrate);
>
> Regards,
> Philip
>>     out_free:
>>       kvfree(buf);
>
