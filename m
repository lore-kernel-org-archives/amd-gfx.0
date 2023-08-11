Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ECAC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 21:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C8E10E6FC;
	Fri, 11 Aug 2023 21:22:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B451E10E6FC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 21:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYCrtZkiF+qMWM8M7mjpxPgKANprAE4r80OGeT0hpSEU72D+NwxMI0Ez3KuWgq6tEaXlGW70g/ZH5SBB4Br3OLfAba0cHz0HZKokSQCRsP7+wxYAAOySryLqLT1pt/ei5KzWbwSLNGnowTO/ygKtaeczNXZLrr7IJU+SuFe45/h8YQCKFBxJS89tho4tuWVWZmuHE3NmLnX2iIK5IelRDeq7DLYnaIwUzFnF09lH3Tr0KazKIXTh/vbyEpKj0PkePJFLcWx4x+3Xn4jCVoklhEMB7RxdAM+prFmT7eorIMyjijfe8BtoOT9zRiC4wDUD6quXGVge17WVc0ntSibBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh+lsca24m5WC7uzs3Zv7ncxenrbwJEf49re/jSaoT0=;
 b=JkIp0RHFknSZm2w2vHbYIzF80bQ6XOLBD3gfWHFojhjyJXESJsaSwc9gEdRtzgPRYmN46kGe4tJ4QXKuXpnX89YukMnF/3ofGfp+tNhNzYfRXlIUKwXYpZ+G6aAUYSnLO0WtTs4mCj83xVgXZqG8P8TyTDl3uUJgsWQGQfrqxbtu+Wiaggx3lICyhOpfeTGuTIuojzX5tTZ6ljJwVyTWBFIvZGm2SoQiqGaSjqDP+10VkDbAuXGtA1M8e2T7nLIEsjAOdnBoTNenGKC3XHN9NsIx5FJSIt5uvOHIt25V83DT4qcOI3k//GkABT+PEmWn/sSNLK3gE/bKQI9SzqApVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh+lsca24m5WC7uzs3Zv7ncxenrbwJEf49re/jSaoT0=;
 b=2v00qQwbJI3Ywv1YTNUcAAldh48Zl35QoBm+tPUZ1RzSwXdrk1EVm1TnOGtkG28Pl09+dpbOk0IcF2nuisiCPq+L644beUcYE4zO/ziAviYG8VggcFpxmoJem9rjPafsQNur/gVG9ZL/DKeowQ0aRZCHbef0PIpE5Pk0o9mdmzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:22:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 21:22:55 +0000
Message-ID: <9c146294-f979-a2f9-13c9-fac588a63406@amd.com>
Date: Fri, 11 Aug 2023 17:22:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 06737205-2d08-4c8f-adb8-08db9ab120a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5B36K46mMqND1UhAfYWAOC9tgJeuSPXbUzPag33ZnCATCGmT/mnh6BRBEY5FLaQ35lpwq315oZJrmUUIYqGUp0jVlxPSR5605ACzLDC2DHOXxs7RRD5y4B0qIpZ8wBL6UdVDZ0wYlEcD/FdFAxk0FUhFyUAteApOPD1J6Vej2Azfz8SeWw96EyYxLyscr9WFX/FYq6y0w8Pvskk92hZaJwWAwwsxDudUmxgBNf0H2hP5Y8bnfLfjg1wvw9IU4axTpX+QFaKesO1JS1bzjVb71gw6ghgopoCjCqmKyO0LHsFVUn33yU5iccY7RQXzQvSw1tnNjwxmbV2MsIKomloOanbUN+gj7Hp7bTPwtf70vN0THEbsrgcFK30VR8RNks6HRXNRh8pzngYGqw+Rj7XyW0WAmhcULX+QEv5QNJJyS7epJGKVawwHpfVWh2/bGv9TGMFalRrPk3CgjV4PpAMMkClIedgQILJydxRk5Zn4doVRPOAdh/Wg9S2YJ0vr8F1PK9TRLTXkN8uidG28CnqhC1xr9SymSPI4KK9Xf55K05v3AxA03iv2ukFpd1mUrvqx1VnsW2PMuknCoCNg3e70LfaoTGys7i/DhUYdJHC9C3rGPJXT0CaOIi1hAmfwl65+JGcEpSWWr7S4weefnbbUbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(1800799006)(186006)(451199021)(8676002)(8936002)(53546011)(26005)(6506007)(41300700001)(38100700002)(2906002)(83380400001)(36756003)(2616005)(31696002)(86362001)(44832011)(66476007)(4326008)(66946007)(66556008)(6512007)(110136005)(31686004)(6486002)(36916002)(478600001)(5660300002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cit4WFJaaWl4T3dxQ3lkcnZPZi9WdXg5TTdJWGw0dHF6QVczYnpRV1BHUm1H?=
 =?utf-8?B?enZicUpuVHgyUnVUdzk0amJwNzhnai9qYkZaNlpyQ3E2SExrNGhZdnZ6dTRV?=
 =?utf-8?B?UzhWeTZYTHpxOTZzT3FxMWUwakx4NGVXc0pLWkw2QndPaWJLSTZvVzBBUElZ?=
 =?utf-8?B?dm5PLzFmYjl0MWkxZkQrVEJtWlZWRmJOQ3BTK0pBbVYvOUl6eHZDL0R1MHlT?=
 =?utf-8?B?VkxjSkY2SU9icm8zZkkrcmpNcUo2aHpZWncvcU9LRld3QXpQMHVjYTRNenBy?=
 =?utf-8?B?Z1l4RitweFdGVWF4RVNySVFqbXZuM21weDhQaGtnM3JyTTJXNkRObVVvb2h2?=
 =?utf-8?B?Ui9nbWtMWEd6OFNkNTFmRlByUk9abWVJZnR3dDFhUzl3SVFraDd1MFFCaGlU?=
 =?utf-8?B?d1lCQ2E0MGQ5VnRhMUFLSWd5OHFGcFVKMkpNUnFzVG9ONjYvM0dRVUIraU0z?=
 =?utf-8?B?Z2M4MmdQMExaMkI4czZhMnJScUloQXdUQkwvR2diTTJYTERwVXdaUzVmTGtQ?=
 =?utf-8?B?OXd4TTN4ZndsS1MzdUM1TG56RDVreDNPWVhVSGJ2REpIUFpReW05bVhyOCtz?=
 =?utf-8?B?S2V2QVhScTJkUkZUVko0TnpUaDRlejlzMllMWExhcDcwbEx1aHYyQUVIb2gx?=
 =?utf-8?B?cFYvSERrVHZmc1hFVUlpTjdyd1AycFdMT0tpa1pQMnhSTmhRcWdVMG9TU1U2?=
 =?utf-8?B?QmVzdGpWT3NueE50ZHQ4aFpZOUFySTl0UFh4UGFPWVpHUmdCZGU0a3R0aHhx?=
 =?utf-8?B?SjJHb29NVVhPcFJBd1NsR0NJSXpveHY5K2xpN0xKWTQ0Yk10OEZya01rL0Nh?=
 =?utf-8?B?VkV6NlVreWQxWmxWM0t1R0V3a2FURkNralQ5dVpBN2JSWHRvcEZuNHljRUJm?=
 =?utf-8?B?cHFNT00yd2psd2U5NEZNTWhqbitteUVxd3VVbU5pOWFDREJKNTNlWEVSaUpG?=
 =?utf-8?B?dWdQMHBlNUJaLzlITEVyWXRsY0xwSUhtMjVLTnEvVG9nTWZPNHZ5N1pIRHNW?=
 =?utf-8?B?RytRZHVoMCszcTJwU3FJUCtsOE5DMlVPQ2FBQkpoaHlqWXRLQWtJTTJ3SFdQ?=
 =?utf-8?B?ejB3cVk5L2YzTE9BbnVzajFZRjVlaGJBUkYwbjB6YUFGU2lXODBtNURLNkps?=
 =?utf-8?B?SUhuL0NKOE1talIwOXdaWWNCak1ZMGdlOXJEcUhQYUVXUmI2VEg5VmZsRTFk?=
 =?utf-8?B?SW5UWGJFdE5GZVBEL3M2cTVqU2lBRUFEcmk3US9uSFJPWWtmSFhrY2hJYzFJ?=
 =?utf-8?B?elpPaVNRaGVlaXdHcElBaGF5SWpmSDdEaWZiazByNXZUc1FHTHUwWFZ5MFEr?=
 =?utf-8?B?cU9OalNzTU5XZkFlNHp4RVV1RXQ1WExvSytDUUtLK1FIOUVweHRsZGdTcVlp?=
 =?utf-8?B?YlczSnhaaHNLTld4UEwzSWFrb09EVmF6Q216NHdDaCtrMTlFQ1liV1pldlZE?=
 =?utf-8?B?eHUwQWRGbWR5SVliZGhUNkhkOEhPVWhkeTN2S3BsVE9KR2E4bWFiU2ZHcVNu?=
 =?utf-8?B?TVhSa084TFZCc2MvYjFUeFVpRXNqeUtydEV1ZG9JWm5WS2hwQnVUbzZrY0NN?=
 =?utf-8?B?NGVQWE9kd0tTVERBNkkwWlNsNm43TzVIYVNqSTZmMVhIQnpYZWVQWkZQbTdW?=
 =?utf-8?B?ckV4dkxpU2tTVU9sdGtHMW9ROGNRWGNUb0U1Mk1wb21DdTdBTTRkYWFjN1Rq?=
 =?utf-8?B?aTlreG1PbHQvN0hBTmxGMVVrUTYrME9tbmtMTmNyRFQ3NTYwRGVKMDNKN0xR?=
 =?utf-8?B?RVBFcmZVRVg4a0pjQWVhdGQ0Nm15cURiOSt5MG16UnpUQjQ1d2l1WnphQmw5?=
 =?utf-8?B?OTVndHZBZ2tkeVZvaGZsL09JVmE4VDI1MDdvdzNGRWhyeDZiMVY0QmM0d0Z4?=
 =?utf-8?B?RXF6d3FFYTRINW9ibHpnRlBmRW1mU3VSQlZ3QmJLTUt5WSsrdjlXYlBUUFlj?=
 =?utf-8?B?K1BDWnEyTEtSNjRCdWUrSUpPbk5JRlo0Ky9SNHgySXpkS2dCOFNRWWM0N1RW?=
 =?utf-8?B?TFNJNFp6ZCtHODRZckttKzVoby9VaDRMSDNYTmNJZFZZc1YvSTJ4eGFVemto?=
 =?utf-8?B?d1pvYmx0SHhlOFpuMFJUOVBnRnRCNERTd3FpcTlLcWJGM3J3RDAyakdSZE8r?=
 =?utf-8?Q?3FD8zf0LvZkyVueTWZwnv0L+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06737205-2d08-4c8f-adb8-08db9ab120a9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:22:55.2697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+GzHXGozEqR+vNUWbfenb3Fet2boYiAQ6VF2XuYJG+2A2J9hiq93p9DKSM5Agd5KXuageek2wvfdfsqAo+7hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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
Cc: jamesz@amd.com, Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-11 17:12, Chen, Xiaogang wrote:
>
> I know the original jira ticket. The system got RCU cpu stall, then 
> kernel enter panic, then no response or ssh. This patch let prange 
> list update task yield cpu after each range update. It can prevent 
> task holding mm lock too long.

Calling schedule does not drop the lock. If anything, it causes the lock 
to be held longer, because the function takes longer to complete.

Regards,
   Felix


> mm lock is rw_semophore, not RCU mechanism. Can you explain how that 
> can prevent RCU cpu stall in this case?
>
> Regards
>
> Xiaogang
>
> On 8/11/2023 2:11 PM, James Zhu wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> update_list could be big in list_for_each_entry(prange, &update_list, 
>> update_list),
>> mmap_read_lock(mm) is kept hold all the time, adding schedule() can 
>> remove
>> RCU stall on CPU for this case.
>>
>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 
>> 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 
>> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>> migrate_vma_setup+0x6c7/0x8f0
>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>> __x64_sys_ioctl+0x92/0xd0
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 113fd11aa96e..9f2d48ade7fa 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>                  r = svm_range_trigger_migration(mm, prange, &migrated);
>>                  if (r)
>>                          goto out_unlock_range;
>> +               schedule();
>>
>>                  if (migrated && (!p->xnack_enabled ||
>>                      (prange->flags & 
>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
>> -- 
>> 2.34.1
>>
