Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A9C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2033060EE0
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2033060EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9466E19B;
	Tue, 17 Aug 2021 13:44:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DADE96E1A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 13:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnU4QlDdgKzFbwYsOKRLg8Yzta/JaRZlVpyvE3aa6pD2XzVvi9oiuNluCU1375CTkkey2ALOqmirX3mSEiltX4cY4myi4qLHmYCnGHRLv4qlezr8qsBvrMYWcLO2Snk42owC/B0qgy/d5VOiSRRymmRb+8YXgJ8REzkfc0CXvrVc9IjD61JA/YgbToYC2bEcux+o/C2ZhmLyB1hXR8tRH/asBIyMTgGo899k32etdQDhyqRJAegthPeOmgGSQkqsjBw38WPaY3IAO/ugSwAWCCAnsb8Xplp0X8xqeZCn8MEdhh5CQA3GilDkbfv5igwgzPwFaVcAfJE1JQlTSZmkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rnYe7a3M7K6qGSUbV8HahQEkv+qLJmx7yQyfWWjB9I=;
 b=fQP4LeMP9QyZtB91+tSqixChYh5uGlf/MhJ007XjJ5SS4bkYmHcpt9RLb/HccGIEiauAn2IDDHNgnPMtSWl5qJi8O8BIPmMSsAnDjqiVlpv7lI6Y0dSsBC7v++O1yDJW1BhS9V+cDNoa2SdNoghCACUrv18jQg7UeZj1cOzbVt7iQpgzqoADMWkGp1vItaZ4wEUnMxgTt3WEa4mKb55w7j8uAbjWh0Liq6SY9+/u6G/Rmh/7VvlBC5HLV6r/9pxMhLjZy8ycZpSibXHg53nJkw9iv9A2ysHN3uK9vmAI0egMbl7ruc7MDQQ4m6xblT15L6Xdsj/Dl4pZy/6osKwktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rnYe7a3M7K6qGSUbV8HahQEkv+qLJmx7yQyfWWjB9I=;
 b=Ge42C95hP7VUbfCfb9KFROCufFgMKky12XFaeS7R5wrJkCNYsaQUBUgahFY92Q/Y34qgi9U2YBBrrQ/TCpIE3Yt/9hsp81j73kT/Q1zaVyTkHTHcP6u36euDYLZ7uxOEZAc1zsDAi6MOZlO90vNKchWyreU5KMuCxh7DsoVUP9Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2452.namprd12.prod.outlook.com (2603:10b6:207:3f::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Tue, 17 Aug
 2021 13:44:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 13:44:02 +0000
Subject: Re: [PATCH] Revert "drm/scheduler: Avoid accessing freed bad job."
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com
References: <20210817042815.1269454-1-Jingwen.Chen2@amd.com>
 <e5db89e8-22b9-2539-7a53-4a10b751ed88@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2126dab8-3484-7fd6-b99e-b94e830fd50b@amd.com>
Date: Tue, 17 Aug 2021 15:43:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <e5db89e8-22b9-2539-7a53-4a10b751ed88@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:5ed8:be6b:d062:84f3]
 (2a02:908:1252:fb60:5ed8:be6b:d062:84f3) by
 MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Tue, 17 Aug 2021 13:44:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12953d9-0a2d-4344-5b7e-08d9618512d8
X-MS-TrafficTypeDiagnostic: BL0PR12MB2452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2452EC3B77A6915EF52CD10783FE9@BL0PR12MB2452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lONuPRyiGyitTHVQhsH1Po8bjcfkms2OzMsjx90v7jnrIJlRJIsO6Um2BzvQWWlqtq5G9bJeV9JyOBFquErPpurM4Xu8gTuhqP3usGsYIgSoR+rO5G2MyvYAF+8ClmnboIw12w70EhLZaiEssQ7inD4PLSvcbaAf6VEbTRJEQc1q1vxVcD2Y0p//zXsXolMf5Xvv8ZWdZHSrl36fs1dVSgCT3WWbReaLDpMEGCVXK957TpljUNjAveks3un58YWneWECeW1sb6RkNmrwe4OwLJEGcbD2xcm2CHdYmICSwDIE0Kp/B7qgqMlY1kyNGeTh4ttZFOSPe1pKuP79TEgm79TOgX0O6vxAV/K1KhdUx/VwyEkxPewcaulH1SkVC8qIPmFxeIBYJHbvjPU+1Z9QdOu6AE1yvJAhSNz7eYm0Mfg4pSXmQWzTCuEKJ9mnDQhOCeHCw9t3w3u5q5Bzdu+eiEmtl8w956X7cjL9ouWlB57C63YvBZDCigR1DwnNzKzqoil1hr2J/C6rKhl/K+hO3J6fzvEiEaHxr7Z4B0Bu/Y56PyyDlSjUs/LWLuL0vK5YlWxjagwrWJmTYgl28JqvrPpeC45BFcnu/CZuABSB26OYaT+fIGyBOzUl8Z6mH8bUs6khYU8JBFYPas4v0BQTSEvvxXYLa4Va+I5tvo6qtC/6S/rrpsTiHkk17opNTG019bKlRpl6kPtLXOVpsfgLwF0qSOEJMkUsRlATpzBTwxgDyNldyDyVeA3S7JsiK3J7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(53546011)(6486002)(316002)(4326008)(31686004)(36756003)(83380400001)(86362001)(2906002)(8936002)(8676002)(110136005)(5660300002)(2616005)(508600001)(38100700002)(66946007)(66476007)(66556008)(186003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVJodDMyck96TlRCQ0xkK2VLRmRTcHFVdE9HK3lkUE5uWVZuMTI4VjJlTG0y?=
 =?utf-8?B?enVRTHRHelFSUnlrTGFmc20yK3JqdE8vbHU4TGFXWUtybE16ZlJJM3pXcHRy?=
 =?utf-8?B?VXF0dDY5eFFseUJnZWRmdTRCVE5IclpjT2xuMndjSHE3OUs2UWpKNzlRcnhU?=
 =?utf-8?B?UTRSbkMvemNYejdycWpYMmJocTBPWFFQWTV4bnE1ajg4bzdxQkRMYmRxTEJB?=
 =?utf-8?B?dXBnaUd5TXRlaWRYTzlIRGJDTG80YU1LTWpaa1RHL1VkU3NYVmxjcWREYTd5?=
 =?utf-8?B?NEtwRDZvNG1reWFsaWtxZVExRUdmTWtVWTU2V1MvZ2U5cmNXWEZja1JUZFA5?=
 =?utf-8?B?T0N6allHQ1lLRUVSTGVDZWkyY0d6bE40cUErM2p2Y2dNQTA5V1d3VjhOT3VF?=
 =?utf-8?B?RUVEMUVKZ2RiVnI5NVhPdzJyRFkwM1V0dzl0RWFsNlZ4eTlRazIxUTRjZFAv?=
 =?utf-8?B?QmZZK3pCZFFZWGV2YndxVzhTR1BpbXZxL1Z0Kzl3R04rUUZxMy9CNHZpZ3JE?=
 =?utf-8?B?cU5jeWhDVENubTdFRmkvdzNsSWtwUWo2ME56S2NGaEZiWFhGRkpNcTlpYU43?=
 =?utf-8?B?WE8ySWpMV21EeE9POUtNbFBnS1Fubm12WDh1dlBVT1VWd0d5UGNOTHpxaVRU?=
 =?utf-8?B?bjJSdE02dWZ2RW1xQkNkMnA1U0hTbDhTOHFtNFpRNXZVRUxQMUp0SithVXZu?=
 =?utf-8?B?OC8wNXQzcnp5UW50bTR4eTRmajZEWTZ4VVlCV0dZd3hmZ0ExOU9NUEtRU3lR?=
 =?utf-8?B?VHN2dENWT1lVT0Vwd3hrWUxGaFkzTmxZTFpuM3RGRndhd2xBLzlXZTY0Z2JB?=
 =?utf-8?B?MkVRUkd2b2c5K1RCUzJzd29ZR0p3SjVYTjNqTkRneXlXeHZhM1JBQ0s4YVUz?=
 =?utf-8?B?dkRjaXZWS0l4UHliMEJ4T3dvd01hNUZLNU5CdG1OdzNXZkNhZmY1OFRRc0o2?=
 =?utf-8?B?K3BORzV3YUc0amhSMFRpSkVjaUZaZ0YvZ2xaUE5TMlYwREU3d2hVcGlUVWNR?=
 =?utf-8?B?Wllna1dqcHFWZUYrUzNZNU9MS2syRWEzbFcyTnpCbElNOEdRdkh5M2hsbmhy?=
 =?utf-8?B?djB0V3JBM24veXhFOFAxUjhlNTcvTWVHblhXcS82SDA3bXFETHVtNkZYeEEz?=
 =?utf-8?B?NnFDL0JsaHZhd2hTWndyZzh2UlVjaFJpSVdSSldKd2t4UEd5Z0l0Vk0yRUpo?=
 =?utf-8?B?N25VT3hIRlljZmlSblNnNEtXWGFlcXRhU0kwY1lQNityb2NSUTVzcTlKSlJK?=
 =?utf-8?B?bENxTDk4Z0REN3h5bXdYSVJUWmdLZmNNQVc1NGt1ZTRBOVhmV1dhMldGR1Nm?=
 =?utf-8?B?WGlOTU4zSk82MUVXM1NlT1lUZ2ZUT2dkZGEycnhXd1NENWF4R2JtbDhWRG1G?=
 =?utf-8?B?anNESGttbVVrUHYyWnlmTWlPR2U5cmpLS0RQNHJNdlB6MFZ4S0NWVDg3YTY5?=
 =?utf-8?B?OHZ2d2czZXd0b1Z6U1dMZGdWK1dPbmRjbDdRemlKY3RxT0hjSzdkNklsVG1h?=
 =?utf-8?B?ejFNeWt1bG5RUC94d0M3UVRQWVpTSHg5WnpzclBTUEVoeEJlcHpobExDWTBG?=
 =?utf-8?B?bU5Qa0tIczZoSjdJTU1XeDVPbFh5K0NKL3RabWx2a1VxV2xPS3R2YjhOSzRs?=
 =?utf-8?B?cWNmYzUwWEVMY0YyNFVKYVpnMlNqM0JBbEgxUWF3eFcrM2dIUjl2c2hvVFhE?=
 =?utf-8?B?NGFNMjdVTXc3bDg0NStXUDNzaXFJOTVvNCtqbFRPZng4Ti9IT3BoVzJ3ZnYz?=
 =?utf-8?B?Ni9ISUZHcWhaMVV0cTVJQStSaFpRMlJ1QVRIbDdUdWxmT29yYSttanlyUWM2?=
 =?utf-8?B?ZEc5aVFDZHgxdWM1dk5ENk1pODY4OHovbWRFRmthSEtXemU5NVdZU2Nvd0c3?=
 =?utf-8?Q?iaC4sCoYDIXAs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12953d9-0a2d-4344-5b7e-08d9618512d8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:44:02.6478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHp8yqu+ulwIA3WQ3lDlZhW7Ky5FORcwz1UO3kRBYibguLB3OrEelt1yWFzhz0jj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2452
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



Am 17.08.21 um 15:37 schrieb Andrey Grodzovsky:
> On 2021-08-17 12:28 a.m., Jingwen Chen wrote:
>> [Why]
>> for bailing job, this commit will delete it from pending list thus the
>> bailing job will never have a chance to be resubmitted even in advance
>> tdr mode.
>>
>> [How]
>> after embeded hw_fence into amdgpu_job is done, the race condition that
>> this commit tries to work around is completely solved.So revert this
>> commit.
>> This reverts commit 135517d3565b48f4def3b1b82008bc17eb5d1c90.
>
>
> Can you elaborate please how this solves the race ?
> As far as I see and  with this patch reverted, in drm_sched_job_timedout
> you get a pointer to next job to process in timed out handler, 
> immediately
> next this job is actually finished and it's fence signaled, this in 
> turn triggers
> drm_sched_get_cleanup_job which fetches this job and returns to 
> drm_sched_main
> which in turn call free_job callabck->...->amdgpu_fence_free which 
> frees the job
> from the HW dma_fence release callback. After that you proceed with a 
> freed job
> in timed out handler.
>
> If you could take the HW fence reference from drm_sched_job_timedout 
> before
> starting processing then yes, I think it would work.

Yes, precisely that's what I had in mind as well and seems to be missing 
from this patch.

Regards,
Christian.

>
> Andrey
>
>
>>
>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 27 --------------------------
>>   1 file changed, 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index a2a953693b45..31d1176d939f 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -317,21 +317,10 @@ static void drm_sched_job_timedout(struct 
>> work_struct *work)
>>       enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
>>         sched = container_of(work, struct drm_gpu_scheduler, 
>> work_tdr.work);
>> -
>> -    /* Protects against concurrent deletion in 
>> drm_sched_get_cleanup_job */
>> -    spin_lock(&sched->job_list_lock);
>>       job = list_first_entry_or_null(&sched->pending_list,
>>                          struct drm_sched_job, list);
>>         if (job) {
>> -        /*
>> -         * Remove the bad job so it cannot be freed by concurrent
>> -         * drm_sched_cleanup_jobs. It will be reinserted back after 
>> sched->thread
>> -         * is parked at which point it's safe.
>> -         */
>> -        list_del_init(&job->list);
>> -        spin_unlock(&sched->job_list_lock);
>> -
>>           status = job->sched->ops->timedout_job(job);
>>             /*
>> @@ -342,8 +331,6 @@ static void drm_sched_job_timedout(struct 
>> work_struct *work)
>>               job->sched->ops->free_job(job);
>>               sched->free_guilty = false;
>>           }
>> -    } else {
>> -        spin_unlock(&sched->job_list_lock);
>>       }
>>         if (status != DRM_GPU_SCHED_STAT_ENODEV) {
>> @@ -392,20 +379,6 @@ void drm_sched_stop(struct drm_gpu_scheduler 
>> *sched, struct drm_sched_job *bad)
>>         kthread_park(sched->thread);
>>   -    /*
>> -     * Reinsert back the bad job here - now it's safe as
>> -     * drm_sched_get_cleanup_job cannot race against us and release the
>> -     * bad job at this point - we parked (waited for) any in progress
>> -     * (earlier) cleanups and drm_sched_get_cleanup_job will not be 
>> called
>> -     * now until the scheduler thread is unparked.
>> -     */
>> -    if (bad && bad->sched == sched)
>> -        /*
>> -         * Add at the head of the queue to reflect it was the earliest
>> -         * job extracted.
>> -         */
>> -        list_add(&bad->list, &sched->pending_list);
>> -
>>       /*
>>        * Iterate the job list from later to  earlier one and either 
>> deactive
>>        * their HW callbacks or remove them from pending list if they 
>> already

