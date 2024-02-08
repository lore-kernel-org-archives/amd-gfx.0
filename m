Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4655C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 20:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6986110EC31;
	Thu,  8 Feb 2024 20:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0EMDcmMn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954C910EC31
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 20:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTesMMKpB9eDrtz/GN7CKNNfprbfBTTi5LrEb6E8ajQCTX3ww7otj3N2+u7+Qi5XXEjkkzqeTet2nylu8e551VMqagzb+vZBXhKnTO5+qSRI3VMjVdK5BE9QifsTX0nwcMsR+or5dlK4VMTNaSbxL3s7AOzIuY/ZMbj2uOsZeW1/sI7AnSgMK1gyQ4oFv8ofT3hNf3cj7ZH85xhL1LN/KNpt08cF9DgIFUE4/MEai+EOajNehumPkHX04Oqj+ZE2jH98RKQFRySkgnO/ijtIVm3kuV/3gaMBaZ+kfK0+7PFI3+wcbinQ+M3cIBxBMNOzkRtCl6UUdP6SMZd6d1MfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHJq+PKM/2RxibD6JGKfucFwsMLllKsntAj/62PPS5g=;
 b=LThZrJ93fx0N8dHMIeQAj4z4Q762z5W6Yum6w0cIeV6Be0QLjPGxCZu0XpluO0VnljpVRGCotVcYSKWRnQV0pT3s/QaKTSB4pBipaJt/0tCeAecZJn3R1+pZwjtxJFPDBw8k6VEhtRSBL9VoDv41NuL6pjyB5tCpUvEF4XeVccNRSt3Io6R6Ig4vs8xLmw37ta8dCUfKteb3TKe8Rzkk0E+Ee580yRPPQ0bdSwFvYpsX44eNU7sjT5VN44irQNltQjWsfXKvXLUQZIHOn3UID8OuwJbUdGcrkK/zi/XBq29MlN5CZBsTcdiYXCC5o5fl0mtqYQht4hoGX6VZTyYvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHJq+PKM/2RxibD6JGKfucFwsMLllKsntAj/62PPS5g=;
 b=0EMDcmMnY20qqkg6o5wN1szHka5/ejm/JuOO9Cg5YhZjiIHXql5e+MdErLSIqUjs4wg6BNTCv3KnMG7QOkjNaUa7Yb9rIQCA7U7YsekCDjdA1stF1OSN3jsJlnCTvM3tzJHhuJYKvMpz5V+tnV0OJe2S/Y/PnPVXqZr7CeB8D/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Thu, 8 Feb 2024 20:02:40 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::5704:c345:989b:8095]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::5704:c345:989b:8095%7]) with mapi id 15.20.7270.015; Thu, 8 Feb 2024
 20:02:39 +0000
Message-ID: <c14bd877-742c-4a53-aad6-a6d7061569de@amd.com>
Date: Thu, 8 Feb 2024 15:01:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdkfd: update SIMD distribution algo for GFXIP
 9.4.2 onwards
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240208041401.1870940-1-rajneesh.bhardwaj@amd.com>
 <c14611b8-b524-4520-b6e5-ca67118c4b12@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <c14611b8-b524-4520-b6e5-ca67118c4b12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::8) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab06fd0-998f-456e-dcfb-08dc28e0e72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zb3yNUyNfi+S0llYEphG4FwzdLZoFnqrkiGP2iSBy1sHFsMi4fejzIikiP5ZYZoJDYTMGcWsx6GfTH3TAfTIb3Sf0/C95sSPbzazCGh0UFRHO042scLXkLauNUKnHALE7/FppMBZaIYHX1O6vWYWVRC5lCzgTPDYcUKENXOk26t4NSAYSt+DS5dMnowVIOFMyrsrxYDZh+BAaFlcBuXDl8D1idecaPXg15j+iqT2RYBGKdCs44r/briGUWulTU5TDWSG6s+7HR45xEWbs2Zf7GGdAAeZqtDg7GpGGUG8ocmf9ZvaX1N08Eli+H2BV6Muc+PFylcoLFOY7NUgn85O61RCKd01j5i3xORY8cJfZAFtwnYfaRA3RpK9/5H20zTMvXwHMcaEnmGVgwH82kMxHDpH2ElGbT1Qd/QA1eoMHDHffqeVqF6aZ4d5BrnjmeKt8eL9qXuJxFc64kykQTfQrg4fWxdVDMnr/0EUMjXIwMn0VAZ6bwCva989a/2Hi86EwPARv2DnaT0FjfP2u+bgn5bsgDCwPhecVX5XrE9u7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(86362001)(5660300002)(66556008)(8936002)(4326008)(15650500001)(8676002)(2906002)(66946007)(66476007)(31696002)(6512007)(316002)(53546011)(966005)(36756003)(31686004)(6486002)(6666004)(38100700002)(6506007)(478600001)(26005)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5OSUg0Z3A1eDZLa3UrZkNRWTJ3VGthcG1SakVBcmYrMVBka0dvS09KRFZ4?=
 =?utf-8?B?Q1E5QzBJNVU0d3FUeE91Rk0vS0xmQk8ranZpbXlBcmdVZWtqL1grSTNJU3N1?=
 =?utf-8?B?VXBodU5EZWZGa2Z0UUkwUS95bE5OYWpOMU1ZVXZaQ092Zm82M2lSQnlxNFUw?=
 =?utf-8?B?SEw0L0hRbG51N0hzWitOUDF2VkZCMkIrVGVsTXF6OWFvYzd0czVuNDM2Tity?=
 =?utf-8?B?cDlKTmlEeS8wcEhmeVZqMHJTUGxIenRVQjRUK3Y1VkFWbzlPY1dqN0FLWUd1?=
 =?utf-8?B?UHVIbDFaK2UraDJYRUFVeHYyWCszTXdrcHlsaGkyekxkZlhQNFY2VlR0MjFP?=
 =?utf-8?B?eTJZU1dhWDMrQnp5dHByaU1yQXExeE5meVBVTzU0RldEUHk5NDFoZ0xrODlN?=
 =?utf-8?B?WnVqS1ZlcDBVSkk5YXFZUkhGY28wazRWNW50RUVTZkNyR0Y4ZEQ0T3VQanN5?=
 =?utf-8?B?VkNDL1VHUzMzODJhcU14dEYvUW1wRDVpVXhRM25LTFQ4OFhZcFZDMjl2c3NT?=
 =?utf-8?B?cU43NStNMHBaQWJtdmlGaFpZVWh0UXlBWEJzd1luY2QxRk54VkE0VE9OTVpN?=
 =?utf-8?B?aitsTVYwc3VkMUdqU2J5QksvTFFwTjB1aVFXUmthbWlsckRhMllGb3paaWpo?=
 =?utf-8?B?bUhOOThFZ2lNOFVWZ2M0OVpjUko1NkcwQkwwWXBJc3l6ejBEd0c4VG9LVjND?=
 =?utf-8?B?Q3RqZ1FBazY2ZzUxc01Ka0hKNDZSUndVS21GNFVQMGxFM24wMHZWVjFiV0Ur?=
 =?utf-8?B?TjdMVS9IS1FGUE9pcWpoQlJZRngwclp6c1dxMXEwTmNsRHlqT204NlFETHpG?=
 =?utf-8?B?T1V1bHFNTVpIQVlzSGwxeVFsb2FneWlrZTc2N2RDVnpIRmk1TVFaZndpT2Q4?=
 =?utf-8?B?MTVmdFJabnBCSkVXVUJOQUkzTjA3Zko2WXBrbWs2bVdGdW91VXN1V0ZnSE51?=
 =?utf-8?B?TEYzVkdRVTluMisvdUdRSXJYVDhYc2JxL3VCTlhYcjJNZHF6RUtSNitzbnhB?=
 =?utf-8?B?N3BxTytrZTBBeGNjSDBzQ2lMY3VSNXdvdlJCLzRnRVUvMWFlSXJURDhzOThh?=
 =?utf-8?B?V1NVR2FLa3RlNzRheWo5UDlYdmU2OFpTUElDY2pmaXRQRjZIdEdqOEtHUitR?=
 =?utf-8?B?NkpRSlBiTDNjTWdLdFBCVU5ERkREWHdQL2tJZHlreVZQazlVd1J6STBkNEwy?=
 =?utf-8?B?QUFRNm1SS3ZaQzUrSjQzS05Ra016dTBkSWVGYkNsemNXck54dkxEaVczNUZi?=
 =?utf-8?B?VGFTY1F5U0pQWUFFRDFkRWxGcENWQ0FvWjRqamp1ek81OWMwYmhmS1h4RVdq?=
 =?utf-8?B?ZGo3VUU2RUpqdm4rNnJlOHhybUR6c08rQjRPS2xpU1A3NFBDOGR4OFlUdEZW?=
 =?utf-8?B?M3hNYTc2aU9uY1RJUnA4VFFWUy9aOWloeGlGSEVXeGYwVkgwcEJGcEtCK1dP?=
 =?utf-8?B?QWNIaGprOVRBMXlmTXlKZDdaTVR0ZTRTYjJyNVltM3lvQmFTZWpwMkRNcjZl?=
 =?utf-8?B?cG1NZE13emN3T0hjL2l0ZnNRZWNtRElqdCsvTTlxdXcvZE9KNjl1OXUwMDMw?=
 =?utf-8?B?RGt4czJPSVdXSk1WdXNBVGxwSmxWdk5iL0dJYUxYYnoxdTNBcE0wMXVreU9T?=
 =?utf-8?B?SlFPME0zN2xDelVQVG9oWjNYT2ZOdEl1akdWL0swSmRKeUdvRFE1VFpETXRj?=
 =?utf-8?B?dDdFSDcvYVE0dWNKSHZOVnhUUnFlNkhaUmk5cDU3VXd3cWFtNEI1bmowV1oz?=
 =?utf-8?B?WTZrS2FtVkV6OHAwb0pLc2NVZ1orR2pya3d6WlJhd3Ywc25jWHc2KzRqWjBp?=
 =?utf-8?B?NmY5U3FMd3ZBZXAvOXVKbnJBdkdNNENsaWNFajlnSHlWOXVlVXlxdEVQS0ts?=
 =?utf-8?B?U1MySWhUdngzbXQwcE1JK2p1Y0VGVmQvSmJFcXZlYXlnSUZwVVZBcThkcTU5?=
 =?utf-8?B?Yzl5VFN4TVJQeVV0Q2ppYWZMVmV5eHBWSzZDK3FCaUVpRGhrYkwyckk4b3Ez?=
 =?utf-8?B?SWp4QkQ3cFhxVThCdWJNSTkwN2Nxc0hBajIvYXZVYXJtUWp0Qm1GSzM3eFhU?=
 =?utf-8?B?TUxGcy95L3JUN2M0cE5lOTZTRGZEc29wcjJlb1RkTjNTTGJTQjAwR2lDVWx0?=
 =?utf-8?Q?B+c6aRvX33K6Lj3vNyu3UTSN/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab06fd0-998f-456e-dcfb-08dc28e0e72a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:02:39.7592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaOY3HqnUiYV9pNhp7ATxc34EdqP3xOUh39TEcxaEU2mzNF+aJK5ljwMGib6hm0RTrYqGGczBTW4SNPWf+V+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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


On 2/8/2024 2:41 PM, Felix Kuehling wrote:
>
> On 2024-02-07 23:14, Rajneesh Bhardwaj wrote:
>> In certain cooperative group dispatch scenarios the default SPI resource
>> allocation may cause reduced per-CU workgroup occupancy. Set
>> COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
>> scenarions.
>>
>> Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> ---
>> * Found a bug in the previous reviewed version
>> https://lists.freedesktop.org/archives/amd-gfx/2024-February/104101.html
>>    since the q->is_gws is unset for keeping the count.
>> * updated pqm_set_gws to pass minfo holding gws state for the active
>>    queues and use that to apply the FORCE_SIMD_DIST_MASK.
>>
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 4 ++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
>>   3 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 42d881809dc7..0b71db4c96b5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -303,6 +303,10 @@ static void update_mqd(struct mqd_manager *mm, 
>> void *mqd,
>>           update_cu_mask(mm, mqd, minfo, 0);
>>       set_priority(m, q);
>>   +    if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2))
>> +        m->compute_resource_limits = minfo->gws ?
>> +            COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;
>> +
>
> This looks OK because we don't set anything else in 
> m->compute_resource_limits. If that ever changes, we have to be more 
> careful here to not wipe out other fields in that register.


Yes, Should I change it to below and send a v3?

  m->compute_resource_limits |= minfo->gws ?
             COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK : 0;


>
>
>>       q->is_active = QUEUE_IS_ACTIVE(*q);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 677281c0793e..f4b327a2d4a8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -542,6 +542,7 @@ struct mqd_update_info {
>>           } cu_mask;
>>       };
>>       enum mqd_update_flag update_flag;
>> +    bool gws;
>
> Instead of adding a new bool, can we add a flag to mqd_update_flag?

Maybe, I initially thought about it but then I chose the bool approach 
since  those debug flags are generic KFD non per-Asic flags while this 
bool is per-Asic request so I felt they didn't fit together. On the 
other hand, those flags and this bool are both quirks anyways so maybe 
they can be together.   Please let me know your preference.


>
> Looks good to me otherwise.
>
> Regards,
>   Felix
>
>
>>   };
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 43eff221eae5..5416a110ced9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct 
>> kfd_process_device *pdd)
>>   int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>>               void *gws)
>>   {
>> +    struct mqd_update_info minfo = {0};
>>       struct kfd_node *dev = NULL;
>>       struct process_queue_node *pqn;
>>       struct kfd_process_device *pdd;
>> @@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager 
>> *pqm, unsigned int qid,
>>       }
>>         pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
>> +    minfo.gws = !!gws;
>>         return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>> -                            pqn->q, NULL);
>> +                            pqn->q, &minfo);
>>   }
>>     void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
