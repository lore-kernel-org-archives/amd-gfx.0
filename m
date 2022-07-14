Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03458C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 07:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73D911BA9D;
	Thu, 14 Jul 2022 07:58:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5044A1893
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 07:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE2utSxttcxT2FDk4nKEg7+JF1jlfvl5s66rSl7Dwc4s8FLL7v1AZBmB5xYC567r9AXivSdxysxJJpQgM9nnv6SEaAWXSftwCB5S7H1/GPWbSHYUTM8yJWuhBpeRzHp5FjkBYHmn+EDbaWsbn6xQmrnhJ0TRw32g1y7OdqS9Zu/RUDa2JG5SOBBCo7+iNz1yXitOg9zD3BUrRBimfkV1yK6rVPtkWWX6Ma2CHbYUW0CLSO3XbG3uQ6HTqvFQ74TnKU2iVy0OLuyyLZO7fdXl8Fr/NSS+rvX4RXNcB8SQWz2Mpm+J9CoZuRNFp23/hMCbsOMeqcYVaPqmbzz7nZvnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP3w8iO2jua4mrB7gWFM/DFWNP3guFmm0M0cmcNZ66g=;
 b=Krwx09RygGVDEdCSo5HgzuzoNgH36P3Hsl1HYldjJBfYeqbU3TgJ/pxvJCZr9omnUhe1rDsOrF36fP6+9t2PgxTkj2I4LYntShLpJKJ45PwaHyar1qHV2eGiYIT/TSlR9B2pr6M8hyij9Uf+R4CONqQ6losXgYx+xNgFt3fQbfd5skn3RsAAFakyW4I9CIS24u2MUjhD08DmruiVy7F1M5BjNlxn/vfZrfTGS9gsGoi2OEeglkYSh1SqxqPwu30c/ku9OAya4axjiKGJIKxis5tM0IzdKD5iCEXIyQWb7Bkyd1zIOZwUfi1zSMec+u2KuD0Iem4yHuO4hVFi4QjunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP3w8iO2jua4mrB7gWFM/DFWNP3guFmm0M0cmcNZ66g=;
 b=bxuqOeFPuVYyvvKj7xTLDlhT8wJqip55TpwYc4BR0vsAeCFpCOC+mv35sYB0JOqTCv3k+rzajtP8PL8hyrf7uhmD5XK1NFP1K3S16Q8QRFk7yt8c+FwNae9KoLKwVRrBtyUpaL35crOOSWLYMzikZLLuEtnsFH3t3EezbS9O4xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 07:58:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::905:1701:3b51:7e39%2]) with mapi id 15.20.5438.013; Thu, 14 Jul 2022
 07:58:25 +0000
Message-ID: <78b89eeb-4448-e6b3-59b5-3d4996836d67@amd.com>
Date: Thu, 14 Jul 2022 09:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/1] drm/amdgpu: Protect the amdgpu_bo_list list with
 a mutex
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220712053924.91960-1-luben.tuikov@amd.com>
 <20220712053924.91960-2-luben.tuikov@amd.com>
 <4e6c8eac-d4e2-54fe-2a3d-8949ad70d696@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <4e6c8eac-d4e2-54fe-2a3d-8949ad70d696@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 495a65d1-0ff7-4f43-5a4a-08da656ea181
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyLZUIgDbMPPThPRNMBy5UtyMarlsfCEGeKVcXTE0dwcsdcjjNthpEHBZcHUGgstyOa2MscaY6FlBfMeV2eL7B/qlH+P36iTlT5DKpWRTZVBJEua7vgGMM/ID5uXqtmWT3sYDNhPqQ7R9RV6FH91z2Sh0AwqfekquJrHhhOz74LVLrDuWvq24iD0/8EJxrtgr/rEd5r4XOFp/CUuQatQ6NaYDPxqYwyjnjGSPKDmPIgKskYmZZh3j3itEPE3wTjxvZbdd2VeVF6FLnp15DBmRGWR87Kx77MZzLTh4WubaUg7ZN3hbzhkEtDokO2vi4smVY2pisysRMZ7dBWlO70+TwInY4IK7VHMAZLkZ+EWRoS9Tj3rYmaKTQNi65GVFkLgNUn3FjPkg0pcY7VJVvopE+mUKTqZM21twpRc1hQAxvhtQCswSz76bhj36KPOyGS1kxgsFhBozPjaTGBwWNYa4RD09ZgjmpjBETk94ttkfCqPXNAHbSHN2+DcmsXB3siX2+Mcbe4ZK48TwIDHBikG0VxL7mV8lJV3Hi/YWP1QOYQgKMwQeY1nwTwgN/md3XrIziCxGyWVfriOVPVZ0fbmj7dk3Ehx4vfeutbslyQ7sl2BpZCYVZBd52+DVeftrMOQdqAccmDDq421L0LgOqPb4czRwUHq4P15xupJf1RUFGTvhAo5RA8V4i2ilDSutEsMj67uLwh2gie0x1vV0wkQtnInA1nXbrcGoh3yRYX/Wj1XLQAdcr6rcMWDXf0pzi4UccD2AYnZYQ1xEnVAHh5aUNp2s6zDssxM32KAS0GpdTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(478600001)(8676002)(4326008)(66946007)(66476007)(66556008)(6506007)(66574015)(83380400001)(2906002)(8936002)(5660300002)(6666004)(45080400002)(966005)(6486002)(54906003)(110136005)(38100700002)(36756003)(316002)(31686004)(2616005)(41300700001)(86362001)(31696002)(6512007)(26005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkt2czdnZUJDcWQvT1RpM2ZyUlJUSFVzdnFBMlplUEEvR09xQU5VQmNKcUpO?=
 =?utf-8?B?c293c3A0US8rd2VxV1MwZlZwK2ZGYnphaEpyTEV1UGJrUlhwalZWcVFXQ0J3?=
 =?utf-8?B?cldrZSt6Q2dIVFZJS2NZZzNzVi80djROQkt1V0pkVk9vdlRTWUdHazZlUEl6?=
 =?utf-8?B?SDlTaGdud0ZPYTRuNXY1MnpYZFdnNXZoTjVBeU80ME9IaHcyeHkyMjlpRkF4?=
 =?utf-8?B?TjRYOEgyTnJCc3A2NTUrSytRSU4zbG41MlU0ZEswdXhBYVExUXlaNTY4dEtD?=
 =?utf-8?B?TG9HUjhLQ1kxQnBjSXNwVG9idVhnYmZEdkdGby9vWGdlcjJEdkl2YVczQ2dX?=
 =?utf-8?B?aEY2ZWNuc1JZTVBrdnA4enBUTjFtSC9sMWZXYzlMTjAydjZnTnBRWDViUkdQ?=
 =?utf-8?B?KzVYTUhHTUJTZEE1ZXJCSnBSQ3k3SHA4bUFDcllORXgyN05iYXJrdDUwc1kx?=
 =?utf-8?B?b3drMDViZVJ3alJtamNHSlNrMkhubDhGd1pWTFVvMms5WHlnRlI0OUNURXZB?=
 =?utf-8?B?Q2VTcGQybHQ2THlNUWV1R2owWWNnTGhaSWVtcHFrUnZMSEVuOWVVWTZrTFNP?=
 =?utf-8?B?anNMMlk1M25ZSzhTa3I1UndmUnZiKzI3ZlFYMVdUMlphMS9UZGNGSmpSYUt6?=
 =?utf-8?B?d3VjTFA0SEMvK01ZYlM3azVCVmhCVXhIYXN5c3lPUE5Ra3Qvd3Z4bWFCNXF2?=
 =?utf-8?B?VkdWZEdhM2pBMVF3MHFySzdrcGRGRnIyQ0hndC9ZNS9Bb3pkTjNHczM1UkY4?=
 =?utf-8?B?V254d1hpZDZVcW9LeE5Walpwa3NpN1Qyb0s1VHFGUFYzTlBFY2Jxa0xPMFpr?=
 =?utf-8?B?cHVkTWVRVmlMcmJTM2ZPemNJQ0Fnc1crWmVZVUF6dlY2VkJ0U2xSMEFBYTBj?=
 =?utf-8?B?SUwybm5QVUtPdmtUTGpaMzFFNkNlb0tKdDMrOEtERmdRck4xWEhUNlV5Tldo?=
 =?utf-8?B?T0VKNDBRd3hBTCtJTnU0MHJRS21scXRYWnJ3ZUh6N0E4Kzg3bk9zVlAyd1NJ?=
 =?utf-8?B?WU1jRE1ISkNMREx3cHYyNy9rd200YXdKYTI4eFk2OFVGcFpjSVBZajJjT2VX?=
 =?utf-8?B?bzQ0bFZvME5NaURmbVJ6N0dqUkUvVUUzSUg0Qzh1b01iSHdKbTN2YXA0MXBC?=
 =?utf-8?B?WVZLWVZvYlNQaFN0a2hDWmpYdU9CT3NIQ2YxTzVUMmErenVMRzVXV2FZYzFp?=
 =?utf-8?B?bXd1QVBHZ3RiNGF0alFNVHcvOHRPSjBJcG5UZHExUTlyQU1VUGNtM3MvWjRt?=
 =?utf-8?B?aCtZR1dYNE1IRFU4a21IMlV1dzkrRTNER0JwdUtYUnJhamJvQ0hDRnlPbFlF?=
 =?utf-8?B?MytvbjlIVkRiak9mcGllMEJyVVVOQ3FjaUVKQ0hEdzNucXNrYTRIYkxyZlJ0?=
 =?utf-8?B?cHdxdm1Va2pJWVc1Qk1TYlhyazZGaXBkRmM0aUlhSzA0UjhEK3AyNTBSK1Vq?=
 =?utf-8?B?WWxNckwwMXR5ZFNPK2xMaXg0djVLMHhYUzZHcUZKZVZtWllTeFVRL01WOU5G?=
 =?utf-8?B?MGZrT1IrNVF1YStvODRaNmxRZTkxWEZ6MlpId1IveFdQekNIV2tBZ3pCUlhn?=
 =?utf-8?B?WFk5QWQvL296d015bEdkN2VMWURiZWFnUUZtVW4zYTluOExtY044QTJUYnp3?=
 =?utf-8?B?bkFMVTlIQXA4Tm9VNU1CbWJ0aExkY1pEWVB1SUpGWFlzUlgyTTVNODRhL3cw?=
 =?utf-8?B?SzFzWk92dkxLOFo5aVVHcGZoTXVwblhES0thSCtZQXRpUzhsaHdOYTgxNGJa?=
 =?utf-8?B?TUdBSU0rcWJIN3JCWUY3a3M5NXRJSGxPdUJpemo2RWwxS09zbzNKd0xPRk44?=
 =?utf-8?B?dm1pWmZhWVdyc2lqVUpRUFFYTXcvTy9qL055ZGNLODlKUGxGYmRuV2NrQ3BX?=
 =?utf-8?B?dlV0UElCbGZVRy9zSmZzZ014TkwreDQrZXRPWUhjcnlKd3YrRHVReEdHZGRX?=
 =?utf-8?B?N3dObXkwOWR5SEhXUGxaUCswZmtYL1FhYWJLSjVVZjFEbCs2anlveW5qeU5B?=
 =?utf-8?B?ZWFlOU1VWklVMmNoQzV6RXgvR0FiTmdGS3gzeWxNbTcvV0ZEOHJ6YUZpWXdw?=
 =?utf-8?B?SkZUaHNsc3Z2Qm1QSkhQdGoyZVV4NkdXREVHcEJLaGRKek5hRUFSWjMvbzBl?=
 =?utf-8?Q?8rt0g4RfgxzWckdf0ph4tuPa7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495a65d1-0ff7-4f43-5a4a-08da656ea181
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 07:58:25.8169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuYtzSKnUuZId2xSVbotoAqwxXeSrC0yDsf/qX0rcb8TrZEbp1lpfzt80yywDFJ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

I need this fixed for the gang submit branch. So I'm going to pick up 
this patch and make the necessary modifications to make it stable.

Thanks,
Christian.

Am 12.07.22 um 10:07 schrieb Christian König:
> Am 12.07.22 um 07:39 schrieb Luben Tuikov:
>> Protect the struct amdgpu_bo_list with a mutex. This is used during 
>> command
>> submission in order to avoid buffer object corruption as recorded in
>> the link below.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
>> Link: 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2048&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C1fc0be908ec3423f396c08da63dd8b6d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637932100428991697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=KzScTABB44b7TxNlbCe2gNU%2F%2F9om5JyvK88SeJ5SBus%3D&amp;reserved=0
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 31 +++++++++++++++++++--
>>   3 files changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> index 714178f1b6c6ed..2168163aad2d38 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>> @@ -40,7 +40,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head 
>> *rcu)
>>   {
>>       struct amdgpu_bo_list *list = container_of(rcu, struct 
>> amdgpu_bo_list,
>>                              rhead);
>> -
>> +    mutex_destroy(&list->bo_list_mutex);
>>       kvfree(list);
>>   }
>>   @@ -136,6 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device 
>> *adev, struct drm_file *filp,
>>         trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>>   +    mutex_init(&list->bo_list_mutex);
>>       *result = list;
>>       return 0;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> index 044b41f0bfd9ce..717984d4de6858 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
>> @@ -48,6 +48,10 @@ struct amdgpu_bo_list {
>>       struct amdgpu_bo *oa_obj;
>>       unsigned first_userptr;
>>       unsigned num_entries;
>> +
>> +    /* Protect access during command submission.
>> +     */
>> +    struct mutex bo_list_mutex;
>>   };
>>     int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 36ac1f1d11e6b4..0b2932c20ec777 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -517,6 +517,8 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>               return r;
>>       }
>>   +    mutex_lock(&p->bo_list->bo_list_mutex);
>
> That lock/unlock placement is not correct and probably the reason why 
> you still run into trouble with this patch.
>
> You need to grab the lock before the call to amdgpu_bo_list_get_list() 
> and drop it either after a call to ttm_eu_backoff_reservation() or 
> ttm_eu_fence_buffer_objects().
>
> If the lock is dropped anywhere in between we would have list 
> corruption again.
>
> Regards,
> Christian.
>
>> +
>>       /* One for TTM and one for the CS job */
>>       amdgpu_bo_list_for_each_entry(e, p->bo_list)
>>           e->tv.num_shared = 2;
>> @@ -544,6 +546,7 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>           if (!e->user_pages) {
>>               DRM_ERROR("kvmalloc_array failure\n");
>>               r = -ENOMEM;
>> +            mutex_unlock(&p->bo_list->bo_list_mutex);
>>               goto out_free_user_pages;
>>           }
>>   @@ -551,6 +554,7 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>           if (r) {
>>               kvfree(e->user_pages);
>>               e->user_pages = NULL;
>> +            mutex_unlock(&p->bo_list->bo_list_mutex);
>>               goto out_free_user_pages;
>>           }
>>   @@ -568,6 +572,7 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>       if (unlikely(r != 0)) {
>>           if (r != -ERESTARTSYS)
>>               DRM_ERROR("ttm_eu_reserve_buffers failed.\n");
>> +        mutex_unlock(&p->bo_list->bo_list_mutex);
>>           goto out_free_user_pages;
>>       }
>>   @@ -580,11 +585,14 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>               e->chain = dma_fence_chain_alloc();
>>               if (!e->chain) {
>>                   r = -ENOMEM;
>> + mutex_unlock(&p->bo_list->bo_list_mutex);
>>                   goto error_validate;
>>               }
>>           }
>>       }
>>   +    mutex_unlock(&p->bo_list->bo_list_mutex);
>
>
>
>
>
>
>> +
>>       /* Move fence waiting after getting reservation lock of
>>        * PD root. Then there is no need on a ctx mutex lock.
>>        */
>> @@ -607,6 +615,7 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>           goto error_validate;
>>       }
>>   +    mutex_lock(&p->bo_list->bo_list_mutex);
>>       r = amdgpu_cs_list_validate(p, &duplicates);
>>       if (r)
>>           goto error_validate;
>> @@ -614,6 +623,7 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>       r = amdgpu_cs_list_validate(p, &p->validated);
>>       if (r)
>>           goto error_validate;
>> +    mutex_unlock(&p->bo_list->bo_list_mutex);
>>         amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>>                        p->bytes_moved_vis);
>> @@ -644,15 +654,18 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>     error_validate:
>>       if (r) {
>> +        mutex_lock(&p->bo_list->bo_list_mutex);
>>           amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>>               dma_fence_chain_free(e->chain);
>>               e->chain = NULL;
>>           }
>>           ttm_eu_backoff_reservation(&p->ticket, &p->validated);
>> +        mutex_unlock(&p->bo_list->bo_list_mutex);
>>       }
>>     out_free_user_pages:
>>       if (r) {
>> +        mutex_lock(&p->bo_list->bo_list_mutex);
>>           amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>>               struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>>   @@ -662,6 +675,7 @@ static int amdgpu_cs_parser_bos(struct 
>> amdgpu_cs_parser *p,
>>               kvfree(e->user_pages);
>>               e->user_pages = NULL;
>>           }
>> +        mutex_unlock(&p->bo_list->bo_list_mutex);
>>       }
>>       return r;
>>   }
>> @@ -704,6 +718,7 @@ static void amdgpu_cs_parser_fini(struct 
>> amdgpu_cs_parser *parser, int error,
>>       if (error && backoff) {
>>           struct amdgpu_bo_list_entry *e;
>>   + mutex_lock(&parser->bo_list->bo_list_mutex);
>>           amdgpu_bo_list_for_each_entry(e, parser->bo_list) {
>>               dma_fence_chain_free(e->chain);
>>               e->chain = NULL;
>> @@ -711,6 +726,7 @@ static void amdgpu_cs_parser_fini(struct 
>> amdgpu_cs_parser *parser, int error,
>>             ttm_eu_backoff_reservation(&parser->ticket,
>>                          &parser->validated);
>> + mutex_unlock(&parser->bo_list->bo_list_mutex);
>>       }
>>         for (i = 0; i < parser->num_post_deps; i++) {
>> @@ -839,6 +855,7 @@ static int amdgpu_cs_vm_handling(struct 
>> amdgpu_cs_parser *p)
>>               return r;
>>       }
>>   +    mutex_lock(&p->bo_list->bo_list_mutex);
>>       amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>>           /* ignore duplicates */
>>           bo = ttm_to_amdgpu_bo(e->tv.bo);
>> @@ -850,13 +867,18 @@ static int amdgpu_cs_vm_handling(struct 
>> amdgpu_cs_parser *p)
>>               continue;
>>             r = amdgpu_vm_bo_update(adev, bo_va, false);
>> -        if (r)
>> +        if (r) {
>> +            mutex_unlock(&p->bo_list->bo_list_mutex);
>>               return r;
>> +        }
>>             r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
>> -        if (r)
>> +        if (r) {
>> +            mutex_unlock(&p->bo_list->bo_list_mutex);
>>               return r;
>> +        }
>>       }
>> +    mutex_unlock(&p->bo_list->bo_list_mutex);
>>         r = amdgpu_vm_handle_moved(adev, vm);
>>       if (r)
>> @@ -874,6 +896,7 @@ static int amdgpu_cs_vm_handling(struct 
>> amdgpu_cs_parser *p)
>>         if (amdgpu_vm_debug) {
>>           /* Invalidate all BOs to test for userspace bugs */
>> +        mutex_lock(&p->bo_list->bo_list_mutex);
>>           amdgpu_bo_list_for_each_entry(e, p->bo_list) {
>>               struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>>   @@ -883,6 +906,7 @@ static int amdgpu_cs_vm_handling(struct 
>> amdgpu_cs_parser *p)
>>                 amdgpu_vm_bo_invalidate(adev, bo, false);
>>           }
>> +        mutex_unlock(&p->bo_list->bo_list_mutex);
>>       }
>>         return amdgpu_cs_sync_rings(p);
>> @@ -1249,6 +1273,7 @@ static int amdgpu_cs_submit(struct 
>> amdgpu_cs_parser *p,
>>        * added to BOs.
>>        */
>>       mutex_lock(&p->adev->notifier_lock);
>> +    mutex_lock(&p->bo_list->bo_list_mutex);
>>         /* If userptr are invalidated after amdgpu_cs_parser_bos(), 
>> return
>>        * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
>> @@ -1308,12 +1333,14 @@ static int amdgpu_cs_submit(struct 
>> amdgpu_cs_parser *p,
>>       }
>>         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, 
>> p->fence);
>> +    mutex_unlock(&p->bo_list->bo_list_mutex);
>>       mutex_unlock(&p->adev->notifier_lock);
>>         return 0;
>>     error_abort:
>>       drm_sched_job_cleanup(&job->base);
>> +    mutex_unlock(&p->bo_list->bo_list_mutex);
>>       mutex_unlock(&p->adev->notifier_lock);
>>     error_unlock:
>

