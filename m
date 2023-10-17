Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A23CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 16:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AEF10E178;
	Tue, 17 Oct 2023 16:59:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226FB10E178
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 16:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnYFN/DdXH5nYK+a5npNyRiZKjJzO6hxhFmNOfWeRGtsww7EjJ/sttnXNmuDcfr+I5qvbM2bojTcyls+KHVH2uRrm1H5YfdGXZmekzfanwTWEPuVw91o8ldzHvxwn8MFmTSoE0l5y6A4k6QxdJ010Y+/AYczYHreIDN3MlNm9bQmxa+mbnCitvNzVhMbkvSNdLQydKtaEkB0q2RHs8fPLgjp1i+CUKX+DBwNse2PMA/udW25ztHGCZ8q4jBelf/hj1PsVqk8pvku5zfO6kv44/DPPMa6iA/4gkAOE4FlPpEJPgzqeuArcy3mzlFFXpTkYipUkL3F8bWPhZ8jcr9gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehOBcW4nIzFtLXlnMHNhGMoCnNaw6X+f4wWje3s1gjU=;
 b=dzTdXhr6tRpYKrw0CoBcs9/jrXq3hJ+dEDJkrWzEl/uKPgh1WbibqrnH5U1e1eVdUlyy973eII/NXmJsmaAzKJ+BK3Nk4yhloSBB4UGGtNAwHBwOSx4wEgeWhuF+UGwOnjh0i9rVZFKd3Frd0ak0JHnZG9W4C/FwuGKO2TrYGeAKjEGmSl8yx2f+nT3EIvZV2fJKMgdbmywqjelEZmzcCyFVChJV7XqrQ/+IMJN+0cBSw7znRmLfY93mpok0OVjPJhHRXKE+rKd4KYYxQq5BJ0Oy/pdlrt0aFIBWop63DCgBOGaqGeLGeNNKn42J6HKRRS95eYWJ53KNiMU8Rb+DJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehOBcW4nIzFtLXlnMHNhGMoCnNaw6X+f4wWje3s1gjU=;
 b=BvvnJzNgz04NPv7N210UsFGVRausQvDFLieg9crEhLqljkS+1/d1Zgu7XxSnD6M/2yjvJ4K6WQSnJK4uOQG1mxhKTsphjP3Wd4eaw40woS1SbZ6Mes+1ysT/+XTyfaW5MtGvRAIaIhh/A06nnzIxio5gd7xbeeSMSGA/4BJAjRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:59:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 16:59:32 +0000
Message-ID: <dbf0e676-1614-4426-bd7b-05952cd4bb4a@amd.com>
Date: Tue, 17 Oct 2023 18:59:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: ignore duplicate BOs again
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20231017121015.1336786-1-christian.koenig@amd.com>
 <f7e00a0a-fa67-4391-93fc-402dae14a6ef@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f7e00a0a-fa67-4391-93fc-402dae14a6ef@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 579c5f8d-4953-4824-291b-08dbcf326f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6aghow+eTEPaOR9QidziyboTzJtVNLRsb3KpxFYwu8/f5pcW6ZDGDrzsus4v/g9sAArAnj2wKx3hcOynUd3T+Tc1dCEYnaKumzMQDNEiQJHP/y+QMr8OQ54Uryh//ZsobuV/gVTrSNLYFns1lCvLxftzK7y3j248E1zN1xgDEA9OSGh4iAztmEp6tn3QCCr1GeDpKDiNO4H5ZbijY1biapK7a4pwvd7+YR7HphEccfNQzNGUItBuH3mGBPyqbOO6DVoG8BOWRulY5vifT9ZzHN5/6r3514Wqt/wg9B2ufNduT40h14gr/ER30MslNcAZy4HEw16xCR7/p7al39BIFJtIei5eLolCO4prLQ7QPELTqP60Kfn0seziwDF9M5DGKqqaLgTK8vJVIXXQ/OX8x5GcUrZjenMdaFh2MyaMv4+gxOxlGABCafsmA7VTnD+TxVNAdXNDuTW0cNqCmtl+gmieKyyfDN6eMgu/mNASC6udz9WVRvV096vNp5UwhV+voZ+XQzEjspQWptVtk6NQBKQN9v7MvgOi8WVTF01F1aD8TdxoyTyE6a3+j7lj3+XaP5lbhfVCbYofZGzmMd9l0Ek0UelADi7WElHRuba0iJFmnI5crdmnu7SoMqgtXyO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66574015)(83380400001)(6666004)(38100700002)(6506007)(53546011)(6512007)(26005)(2616005)(966005)(478600001)(31686004)(66476007)(8936002)(6636002)(316002)(110136005)(41300700001)(66946007)(8676002)(6486002)(31696002)(2906002)(86362001)(66556008)(5660300002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXdUNC9HazZXZFBlVjFGRlhjQ3FRQmYvYTZLb24weStDWTIvcHcrV3VYN2Jv?=
 =?utf-8?B?RktjZ2NEUFpRMDNCVWxqMzlvUE12SGp2VE56bWR4emhWSEg0bXRtSCt1eXJU?=
 =?utf-8?B?UGk4TDVUbXlkLysxMVFPRjVzOEExL1lJRzc1VmhTQjZEcGh3QlFlU01JVjhU?=
 =?utf-8?B?WU42UXVvL0x2d1FmRkw2SHRjYlJoekdxTzBGRW9XSUdyYVNRU2liUnFoaW5U?=
 =?utf-8?B?RTFxa2o5YytWV2JDQnZnUWVHR0NzODgyVURTZkdmYWtKR3dsUXBFc096U1BV?=
 =?utf-8?B?Z2hTZVBPL1BGYWJFc3ZZS3V3c0c3L3RmODk0VzlyR2g0aW85d2lZNVAxb3Zu?=
 =?utf-8?B?Rng2V3pZTDkvWHpnSEpFQ2hYZkNPMEcwd0tUcjZvMHNDWFhqZVFDei96VUZL?=
 =?utf-8?B?dndRQk52UjIvSkhHWTZzTlIveVNTb0JPY2VFT2NxVjJYWWZ0MnkzKzRJWURm?=
 =?utf-8?B?TjJUcGxQTlZsaWVncmxuWHNucndIMmtQRkRnRkJuYS9uYlRWVm5kU2hOSFJo?=
 =?utf-8?B?QUQyWWUweU93WjZrZDVwK2pGSzFZN1A5ZmZYaDlGSWN3UXN1eFA3SmVoQU5z?=
 =?utf-8?B?K0Zzc2NFcCtsWGRFQUg5VEIrMEpuKzNHTXN5dXFyTkFOSUloYXFWWXcvYkow?=
 =?utf-8?B?YUJnUU5hYVFwU1ZaOEpxcCtTZStBVzMvMW9ZY3ZOQnNFNyt6QjBXWmgrRFZD?=
 =?utf-8?B?elNiNU9zYkZkOEZSNXMwc2JqRjU1Rll6YXVOSTlkUFN5SFdVRHdIU0JXbVRt?=
 =?utf-8?B?ZGp0YXBqV2duSVd2U3FWZXFkeGtjSTVoRWQvaUovenJtMnZGV3hNWkdxcFVi?=
 =?utf-8?B?Z0RxRjBYdlovdFVuTUY3M0hmOU00NU9NdGlUcVNxZE5nQ251WWhzUGxXNDRo?=
 =?utf-8?B?QkxUQTJRTEhCYWRjR1ErSkxxZ0NOK2U4SERkZy8rOTJCZThmZXlhcnVmTGI3?=
 =?utf-8?B?eEpBVjR4SUFFWlN6eWlNaFB4cE5HMEd6Qmd5VDZrQUVzRzhoM1Z2MGROR3Q4?=
 =?utf-8?B?UGprUTdqOTBBQTNDcE42RDBwTG1LbzlKb2lFaWM4NDlxVnFMdUR5YTVRWk1D?=
 =?utf-8?B?YVluYzFnYnRzVnVMaXlad1ZkM3Nja3ZYVFUrcjFpcEpuTTB1blZlQTZhSlRB?=
 =?utf-8?B?ZTlpZWpzUHBQZ0RrdGVJLy9YRjdHb2FQb0JNZi9BVW92dHcwM0pWQ0UrWFRm?=
 =?utf-8?B?VFBTQ0xFMEx1TWhrRFNsTmR4WU9wYlFob0FyN1hzRU96UUJUb0dLeno1QVVB?=
 =?utf-8?B?WCsrYnVMS3FMMlRhMlpZTTdxb0tIei9DTVRWYjdYOFRnQXEzVzRLVFRqQlh4?=
 =?utf-8?B?OXJGbzdZOUxNMVd2bVA1Z1VRU1djR1FjOHBvUENVYlp3RTdXYmhGY0RYK0FW?=
 =?utf-8?B?eHhpbWxVb09SejFIM0x5WDlEZW9YdERpVzlTYXQ1b3pRRGNyTUw5Tk14aWta?=
 =?utf-8?B?QkVpRlpQZGFTVHZ1Y1BBVWNBa005VjBTRGFweEtsajM4MXljdWRMZWRNNnlB?=
 =?utf-8?B?ZmFpVUNXaElzcDk4UUE1eGVUUEJ0cGNkTC9pRmY0VGU5dEdCWE94UFhuMU12?=
 =?utf-8?B?cEhNTlltR2ZqSGV3Q3Q4bjFPMklHTk54TUFkZlhNb1BSNnJHRFZiM2Y1T0Ft?=
 =?utf-8?B?Z0NFclNSYWNmQ2tpcEFFOWNBM0tQdWRtdW9GS2p2UXducUp1SVBTWXA2ZkpT?=
 =?utf-8?B?VEh6NXBwSzRybzQwWTZUYzJWc1J4VWQvbzhGYlcvOEFRTmhldk5rV0xpYTlk?=
 =?utf-8?B?OGFiQyt2MFhETVNaazlUVThZQjB5NnhXM3F6OUhWQjdMeGhOVUl5cVhsNU1X?=
 =?utf-8?B?aC8xdmREOU9qOUJvYWVNalFxWjYxZE9pblJmQUNoR3EwRkFkaGZSM0sxVGdT?=
 =?utf-8?B?WWZKSjUrRmFhSlljNCtXclArNEdEY2J5MHRRNDF1MlM5YU5ITVJHclNON0h5?=
 =?utf-8?B?WDZUTmk5YWxueDlwZW52ZTFRclgvVGlxRkJoYnQzTzFmY0pPaHkzK1gwUFJi?=
 =?utf-8?B?cU5SWElCTktnQWZxSVptd0pGZDZGcXBzdUlBRFZGSTVkTEE2YTZjdTd4dHlD?=
 =?utf-8?B?V1RoTkFjb25mNG9lUmhkMnFZajVrNzU5Z3BodG91NU1IcC9uZVUzU21yREV4?=
 =?utf-8?Q?XtSMXwlTHZZpFEvT25xfirW5+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579c5f8d-4953-4824-291b-08dbcf326f19
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:59:32.6578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wAk4EBllt7snNbAM3myK+JOTobWbrZwM92s1gHvYmkbaBjYGKFQWrCZJ6PFatgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

Am 17.10.23 um 14:42 schrieb Hamza Mahfooz:
> On 10/17/23 08:10, Christian König wrote:
>> Looks like RADV is actually hitting this.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Fixes: ca6c1e210aa7 ("drm/amdgpu: use the new drm_exec object for CS 
>> v3")
>
> Do you think this will fix the following issue?:
> https://gitlab.freedesktop.org/drm/amd/-/issues/2893

No, that's completely unrelated.

Regards,
Christian.

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index efdb1c48f431..d93a8961274c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -65,7 +65,8 @@ static int amdgpu_cs_parser_init(struct 
>> amdgpu_cs_parser *p,
>>       }
>>         amdgpu_sync_create(&p->sync);
>> -    drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
>> +    drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
>> +              DRM_EXEC_IGNORE_DUPLICATES);
>>       return 0;
>>   }

