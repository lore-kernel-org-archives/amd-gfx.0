Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D2AC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515DC610A5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 515DC610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97796E062;
	Tue, 24 Aug 2021 12:34:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0D389FDE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 12:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD+wInSpJtbesU5sikUePlugSxAukXGlj17MQ0Ot09Kd8Bs4+SxbiOb+d0xrquKZFlE6heFyX1Xwbn7Oio1t0xeaFODy61CEXWX3gx8jRNlTRdP64Y8meMKhbS/sMIIpT+0OVL4Bvi+dvt88iToSloTZ0gkZNxsUNLSszJyK2FTP4Pas/x4veyWgkHLDVPh0KFhNTH0oaB13c+TIKCMJKXJALFwE+PWLLEhNslKRpH2SAMJygUNYLj16UvDqHqWnCxuJKM9NEt3KVSfUrkDVWxvMpU5/VIYT8P5e0frjCg7efd7htdLZhC2ruoRWD5/WyI79MDFpUW8Rr7fFa0gVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDYGN/tDgc29ZVAHw0yq7dcqrU2rLSWtJ4fMFsk6NJo=;
 b=Y5TcknlvTpUlcrN7vFyaHLBK16p0VEu5ixrLF3Hm/saDIjDfiTAywFRIJGPdmZQLP1E8Iz31Ozp/er5bYmU0keLSoGPXq3be/ZV2pvbgy3b/Z5tMtUFPf6QciavAj/OOy/8XAMmmvsB7k4TNb/AZIJIakrSH67o/dVhJjh3o0LqPHV8Uc2WLOgXjit/sJcuqCIP7dYymLZAz95cfOlQSitU6qTZ7IzLIo+6flrFCdR1UWuhgIS+Hwvusw5l+SkqLhgULgwtOWGrfHogXEIEp1fnRIeYvuMiP+xK4PFASZXzb5voargAzY0xT/B5xXCVjLy827Kn3NWAUKnS2Dae8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDYGN/tDgc29ZVAHw0yq7dcqrU2rLSWtJ4fMFsk6NJo=;
 b=Eszdy1W+uFF2HTAXrcQ/b6s56nJhCc2InOATmJcLMx8TEmaNXiChOIKGPz21tD+3tmLaVqCDmN85bxlkdTzbsljKYE+MSdY+rONqIDIRiSMsYcggFcZpAoZFLwUt5FQLQVgmUzy5dxPA7pxajlyB35XvB9yObl8tREUAbPV/cA8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 12:34:08 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Tue, 24 Aug 2021
 12:34:08 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
To: "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
 <6f77bb91-4ee1-3aaf-3ed8-cbccfdbcc0e5@amd.com>
 <6ef290ca-e79f-c2a2-539e-b5d2a5eb9b02@amd.com>
 <adff087c-ad28-b827-ad56-b1fb3b2dd50f@amd.com>
 <SN1PR12MB2382647752D0EFFAFC25E788F9C59@SN1PR12MB2382.namprd12.prod.outlook.com>
 <fde6bb6f-2306-df84-0da4-4e7b30b27c4c@amd.com>
 <SN1PR12MB2382910A45F75D97E47697CFF9C59@SN1PR12MB2382.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <3317f73f-7209-8e7b-3dd6-59a4717c6d71@amd.com>
Date: Tue, 24 Aug 2021 18:03:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <SN1PR12MB2382910A45F75D97E47697CFF9C59@SN1PR12MB2382.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::12) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 12:34:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd8e1f58-7896-4a31-429f-08d966fb7789
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51738114A77ABD4F3FCCD5C497C59@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ib9PU/T+t1i4tGf7Ncoh+NUXmOhAs3uAfLjzsaDLWFwzYiPnrnUR7vn2VO+6aMCt76Io4EnoQj/NEqf7IwStSoZnRqHETZGlKQmBfDxnF310hKGt4x2FbSod/pyBLFuOl2m2pgkyXpfgS+1ZGDj8gTsTZOOz948xK6DqGwdk2XQPYvJSPcBwkKnymqhU0GcH0R15nVZ1C09lFZiUUOJid5YKH45B+f4/PbYAfKzo/uXmYN6+xcmGEZ0iJVZ1wTvIbNby7EfUbl82l7dQLXiBJ30kiN+91QLo2bo7Q0wcuJJi2jNbA/edl83/szGmLD+byi8LktAA1rq22MneIsxNvEsEX94s1qDSeSCA8qRjeUSYCccTNlENqotMVCIsLub4K6yD6ZH8sMA8hF1AKC9yldSxAyTTZoXU+ZCOmzZWJu/IPDXqDfHBLxdkum5OkzRg6yk3Bw/LCKGwbXBCl7EOJEEnBw7Ia/XrZ7BSalSUT88oKXn+UVZjwShU1rg9mu0sc+AzzRCzr0/it8PkWYXEeNNLh3+jx1sb534KM2Wi1fj8NQX2tPTyo5p7wB4dV7aof368gTmapDFaaXSnSnC3dyFkFSDy4eweRF7fSPtz3Ga0HZPa5uG42P4VCJ2EePXaDc3bJMiIAV7Uh9epOmZX6Gfqsmk06ZGje1qHJJKJC11Z+iRg+KzTxU+ZNv+qFktbVFk7GwbUFkrkK4kxOv0PWAAce9hz3UUa4eW0A+pfIDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(30864003)(478600001)(8676002)(186003)(26005)(53546011)(5660300002)(66946007)(83380400001)(38100700002)(110136005)(6666004)(316002)(86362001)(2906002)(31696002)(16576012)(6486002)(36756003)(2616005)(8936002)(956004)(66476007)(66556008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUFwTTdrbm9TcVVzT1JmWDBBZjlMUGxITjZOMXVHdGdjQ3dkcUROZHE5WkNN?=
 =?utf-8?B?Vlg1aFBES3Y0c3pRem16azh4UnRPUzlGb3ZLYUZ2czJFcjBHTm9KTkVEa0I3?=
 =?utf-8?B?d2F3ZUZNb0Z1SlhPaFJDWmdPaGs1Q0dFcEtpRlVyV2pLK3BjN256SzNtSS9q?=
 =?utf-8?B?UWhNR3Eya052bHovVjRvdXFTRnAxZGJEQlR5ZGZ5UU4vbU9tYjFtWjQ1bEww?=
 =?utf-8?B?eE1xYWVOb0o0WTBGSzZhVWU0alRXK2xZaDJUeGVpVFNHcGNRVTVvTHBYVytu?=
 =?utf-8?B?Tkh3ZnRSRnpkaUFwVW13NkFLYmNVdjhORWh3U1hJYi93Q3cyMjZUZ2NOOVdW?=
 =?utf-8?B?V0UvNFJjbUlUZWhCYmhTVUZGWEZyVjFJUFBoek5WTTkwOXJ2cUN5b0cvb1Jk?=
 =?utf-8?B?c01EdFNFYWZFa3cxMFhHRmhTcjA1Z01tOUY4QlRJVFJBUGZMemM5YWF3bEQ1?=
 =?utf-8?B?Z3VSK0hwREMzTVFyRzJVZkVBSzZkVGsvRnQyNTRpaVVOVDJ5TGhER2JMcEtl?=
 =?utf-8?B?ei9IVlBDR2pmSk40MmFPRXpaNFlkZHU5a2hUaGRLNExpSVhaNDRGT2tkUlNH?=
 =?utf-8?B?TDA5KzRLTXV0TncxRk1GY1BXU0N2cDZ0dDdFbnFSWVBWZXdRMHRRb1BnUHBE?=
 =?utf-8?B?NWh6WE1MK25pRGN6dzFEMUc0VFl2TWVjQ3pCTWdEemNwcXFrclBYVkx1bnVC?=
 =?utf-8?B?cWVXcFJybnFudTVaWnl3ME1FeVVNTEFGU2lreXd2dkZCZHNvTFdlcjFDcmdu?=
 =?utf-8?B?Zlg4MFVORFNMS0ExVzlROWFFU3JpaUt4ZlAxRXhXWGVSKytKV2lRamxHTXpa?=
 =?utf-8?B?a1hkSHdnaGtOY3FaQWFMTUZXRVZyUkRTblBYWS8vZld1TkZXUVhnWXFYekV2?=
 =?utf-8?B?WHRVNXVRdTl5QUlGU0FLNkZSenpITUw0V0dxd1BFdTBTNWNzZnZQOUI1WC9P?=
 =?utf-8?B?VE9nMHREbGFQY1UrV2lxalY0NmtndEx2MVROamdrZk9BQ2JTM01VWTlPNVBn?=
 =?utf-8?B?TVZ2UWJVSjZzZkxIdVRreEMvZzI1ejBWU1ExS1JjTFFaVE0zZU5jb2dycml5?=
 =?utf-8?B?QlFka2NBT2NnNE83b0hEYlhLSjh2NXR6eDRKcWlDYXBFdnhyR3c4YldYMkc3?=
 =?utf-8?B?YzZxNU83aXQwc3Q1N0JQb3YvUFZObklyNDRzTGdOY0s1SXhrRXhicFhmTkMv?=
 =?utf-8?B?UW0wRFdScUdmUUIwRTY0VUx0VE4wSTV4UG4xQkp5eitZUERlTHE0YWt5OEdV?=
 =?utf-8?B?cmd2K095akVIS21oeTU3aTIxQ1lFMUZLejE1N05qWldMYkhWeW8zaHRDUG1Q?=
 =?utf-8?B?MjhZZlFRVHAvdWltdVVlNDlsWnU2ZGgxUTh4NEw2ZUZKa0R1QWN4Qm5GeEtL?=
 =?utf-8?B?ZGlwNUFieGlzYzZObFhNNk8yWkJZbDU5blU0aEF4RzRRZmlEa3cxWVREcXNl?=
 =?utf-8?B?RHE1ejgzV3BoT3lrZVBjWGtJVDJHZUhNUmJiVFdFWm0vTEI0My93Smd0RHEw?=
 =?utf-8?B?SEwyeGQ3L1VGS1MzSkR4TWRMUDk1Q0JKNGY3aTNDUWRNN3RxYmxjRDNtLzN0?=
 =?utf-8?B?ZDd0K21VUVo4dkRLdVhHdjNGQVU2WGNUcnVHVWpsZEMrdE1IenJqRXlDbW5F?=
 =?utf-8?B?S2U0bTlzaFlqRjBmeEFxMkFrSHp2TWVjczQ0ajRDek44cVpBS2hEY3VCMGVB?=
 =?utf-8?B?RDlQd3JuRlAwcmFtM21ERCs4VUY4REh2OWNoZXBMMGdyQ2dEWm5qUTBzczRv?=
 =?utf-8?Q?qxwgMw/bE0eukc6sVXVwVMOSSZP1WuJ/U1ALBd1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8e1f58-7896-4a31-429f-08d966fb7789
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 12:34:08.4117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii1XAQD+NPOSpp5zNYcuAIuLvaznqInTfW3vPSFiKQImgXdqbfZF3ximICKynYU+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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



On 8/24/2021 1:26 PM, Greathouse, Joseph wrote:
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, August 24, 2021 2:24 AM
>> To: Greathouse, Joseph <Joseph.Greathouse@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
>>
>>
>>
>> On 8/24/2021 12:19 PM, Greathouse, Joseph wrote:
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Monday, August 23, 2021 11:37 PM
>>>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph <Joseph.Greathouse@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
>>>>
>>>> On 8/23/2021 10:34 PM, Felix Kuehling wrote:
>>>>> Am 2021-08-23 um 3:08 a.m. schrieb Lazar, Lijo:
>>>>>>
>>>>>>
>>>>>> On 8/20/2021 11:02 AM, Joseph Greathouse wrote:
>>>>>>> Give every process at most one queue from each SDMA engine.
>>>>>>> Previously, we allocated all SDMA engines and queues on a first-
>>>>>>> come-first-serve basis. This meant that it was possible for two
>>>>>>> processes racing on their allocation requests to each end up with
>>>>>>> two queues on the same SDMA engine. That could serialize the
>>>>>>> performance of commands to different queues.
>>>>>>>
>>>>>>> This new mechanism allows each process at most a single queue
>>>>>>> on each SDMA engine. Processes will check for queue availability on
>>>>>>> SDMA engine 0, then 1, then 2, etc. and only allocate on that
>>>>>>> engine if there is an available queue slot. If there are no
>>>>>>> queue slots available (or if this process has already allocated
>>>>>>> a queue on this engine), it moves on and tries the next engine.
>>>>>>>
>>>>>>> The Aldebaran chip has a small quirk that SDMA0 should only be
>>>>>>> used by the very first allocation from each process. It is OK to
>>>>>>> use any other SDMA engine at any time, but after the first SDMA
>>>>>>> allocation request from a process, the resulting engine must
>>>>>>> be from SDMA1 or above. This patch handles this case as well.
>>>>>>>
>>>>>>> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>>>>>>> ---
>>>>>>>      .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 +++++++++++++-----
>>>>>>>      drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
>>>>>>>      drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +
>>>>>>>      3 files changed, 107 insertions(+), 33 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> index f8fce9d05f50..86bdb765f350 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>>>> @@ -52,12 +52,14 @@ static int unmap_queues_cpsch(struct
>>>>>>> device_queue_manager *dqm,
>>>>>>>      static int map_queues_cpsch(struct device_queue_manager *dqm);
>>>>>>>        static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>>>>>>> +                struct qcm_process_device *qpd,
>>>>>>>                      struct queue *q);
>>>>>>>        static inline void deallocate_hqd(struct device_queue_manager *dqm,
>>>>>>>                      struct queue *q);
>>>>>>>      static int allocate_hqd(struct device_queue_manager *dqm, struct
>>>>>>> queue *q);
>>>>>>>      static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>>>>>> +                struct qcm_process_device *qpd,
>>>>>>>                      struct queue *q);
>>>>>>>      static void kfd_process_hw_exception(struct work_struct *work);
>>>>>>>      @@ -349,7 +351,7 @@ static int create_queue_nocpsch(struct
>>>>>>> device_queue_manager *dqm,
>>>>>>>                  q->pipe, q->queue);
>>>>>>>          } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>>>              q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>>> -        retval = allocate_sdma_queue(dqm, q);
>>>>>>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>>>>>>              if (retval)
>>>>>>>                  goto deallocate_vmid;
>>>>>>>              dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
>>>>>>> @@ -410,7 +412,7 @@ static int create_queue_nocpsch(struct
>>>>>>> device_queue_manager *dqm,
>>>>>>>              deallocate_hqd(dqm, q);
>>>>>>>          else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>>>              q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>>>      deallocate_vmid:
>>>>>>>          if (list_empty(&qpd->queues_list))
>>>>>>>              deallocate_vmid(dqm, qpd, q);
>>>>>>> @@ -475,9 +477,9 @@ static int destroy_queue_nocpsch_locked(struct
>>>>>>> device_queue_manager *dqm,
>>>>>>>          if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>>>>>>              deallocate_hqd(dqm, q);
>>>>>>>          else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>>>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>>>          else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>>>          else {
>>>>>>>              pr_debug("q->properties.type %d is invalid\n",
>>>>>>>                      q->properties.type);
>>>>>>> @@ -1039,42 +1041,93 @@ static void pre_reset(struct
>>>>>>> device_queue_manager *dqm)
>>>>>>>          dqm_unlock(dqm);
>>>>>>>      }
>>>>>>>      +static uint64_t sdma_engine_mask(int engine, int num_engines)
>>>>>>
>>>>>> Looks more like the queue mask for an engine, the name doesn't make it
>>>>>> clear.
>>>>>>
>>>>>>> +{
>>>>>>> +    uint64_t mask = 0;
>>>>>>> +
>>>>>>> +    engine %= num_engines;
>>>>>>> +    while (engine < (sizeof(uint64_t)*8)) {
>>>>>>> +        mask |= 1ULL << engine;
>>>>>>> +        engine += num_engines;
>>>>>>> +    }
>>>>>>> +    return mask;
>>>>>>> +}
>>>>>>> +
>>>>>>>      static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>>>>>> +                struct qcm_process_device *qpd,
>>>>>>>                      struct queue *q)
>>>>>>>      {
>>>>>>> -    int bit;
>>>>>>> +    uint64_t available_queue_bitmap;
>>>>>>> +    unsigned int bit, engine, num_engines;
>>>>>>> +    bool found_sdma = false;
>>>>>>>            if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>>>>>>> -        if (dqm->sdma_bitmap == 0) {
>>>>>>
>>>>>> This is still a valid optimization and no need to loop through if
>>>>>> nothing is available anyway. Valid for XGMI loop also.
>>>>>>
>>>>>>> +        num_engines = get_num_sdma_engines(dqm);
>>>>>>> +        for_each_set_bit(engine, &(qpd->sdma_engine_bitmap),
>>>>>>> num_engines) {
>>>>>>
>>>>>> Probably a naive question -
>>>>>>
>>>>>> Theoretically there are 8 queues per engine as per the mask code. In
>>>>>> the below code, there is an assumption that a process will use at best
>>>>>> number of queues=max num of sdma engines or xgmi engines
>>>>>> simultaneously. Is that true always? For ex: there are 2 sdma engines
>>>>>> and 4 queues per engine. Can't multiple threads of a process initiate
>>>>>> multiple sdma transactions > number of sdma engines available? This
>>>>>> code limits that, but I don't know if that is a possible case.
>>>>>
>>>>> When you use multiple SDMA queues on the same engine, the work from the
>>>>> queues gets serialized. You can either let the SDMA engine serialize
>>>>> work from multiple queues, or let ROCr serialize work from multiple
>>>>> threads on the same SDMA queue. There is no obvious benefit to let the
>>>>> SDMA engine do it. But there is a drawback: Fewer processes get to use SDMA.
>>>>>
>>>>
>>>> The fact that there exists multiple queues and there is no such
>>>> assumption made in existing logic (prior to the patch) tells that there
>>>> is indeed some advantage of making use of hardware queues. For ex:
>>>> switching to different ring buffer may not need context save/resubmission.
>>>>
>>>> Just like different processes, different threads of same process may
>>>> take advantage of multiple queues. More interested to see the impact in
>>>> cases where the focus is on single process ex: impact on running some
>>>> benchmarks or in HPC where entire hardware is dedicated for a specific
>>>> compute purpose.
>>>
>>> Each engine has multiple user-mode queues because we expect to see multiple processes sharing the device at the same time. The
>> internal datasheets from the hardware team strongly suggest using one user-mode queue per engine per process.
>>>
>>> With that in mind, the ROCr user-mode runtime attempts to create, at most, one queue per SDMA engine within each process. For
>> instance, ROCr creates one queue for H->D transfers and one queue for D->H transfers. We want these queues to be on different
>> engines so that we can get full-duplex PCIe transfers. If both queues are on the same engine, the engine will serialize the transfers
>> (because it can only work on one command at a time), and we will get half-duplex.
>>>
>>> The queue allocation algorithm that this patch replaces could accidentally yield two queues on the same engine. If Process A
>> allocates its first queue, it would receive sdma0_queue0. Process B could then allocate its first queue, and get sdma1_queue0. Then
>> Process A could allocate its second queue and get sdma0_queue1. This would yield undesirable and unexpected serialization between
>> H->D and D->H transfers in Process A. In addition, I believe the old algorithm would allow an uncooperative process to allocate all
>> SDMA queues to itself. Looking at the git history, I believe the old allocator is basically the same as the initial KFD SDMA allocator built
>> for Kaveri. I'm confident we've learned more about how multiple processes should share our GPUs since then. :)
>>>
>>> To your last point: even if we have different threads in the same process submitting transfer requests, the ROCr runtime within the
>> process will submit all like transfers (e.g. all H->D transfers) into the same queue. Submitting those same commands into different
>> queues on the same engine will not yield any clear performance benefit since the engine will serialize the commands.  And it will likely
>> yield some performance loss due to queue-switching overheads in the engine. I think this patch yields a more fair allocation
>> mechanism (e.g., no process can starve out other processes by taking all the queues on all engines), and it also more closely match
>> what user-space expects (e.g., different SDMA queues can run commands in parallel).
>>>
>>
>> Thanks Joe for providing more info related to ROCr.
>>
>> One other thing is - seems the process will keep waiting for the second
>> queue (assuming first is still in use) to be alloted always on a
>> separate engine. In the example cited above, do you expect a case where
>> sdma1 queues are all full and Process A has to wait till a sdma1 queue
>> is free even though there is a free queue available in sdma0 (by virtue
>> of long/short jobs submitted earlier by other processes). Is that
>> situation managed by ROCr? Or, as worst case allocate on sdma0 itself if
>> nothing is available on other engines? Rather than going in any order,
>> maybe another way is to order engines based on max free queues and give
>> preference to the first engine not actively used by the process.
> 
> I think there are a few parts to this answer:
> 
> User-space has always been responsible for handling an allocation failure and falling back in some capacity, even before this patch. If the process receives a NAK and has no SDMA queues, it may need to fall back to a blit copy-kernel submitted to a compute queue. ROCr does this today.
> 
> Another example of when this allocator could NAK is (for example) if this process tries to allocate a 2nd PCIe queue, it already has a queue on SDMA0, and SDMA1 is full. User-space could also use a blit kernel to handle this, if it wants transfers to run in parallel (one direction in SDMA, one with a blit). Or it could decide to serialize all transfers commands into the single queue it already has.
> 
> A third situation would be if Process A initially requests a queue while SDMA0 is full, so its first queue is allocated on SDMA1. Later, another process ends and one of the SDMA0 queues is freed. If the Process A then requests a second SDMA queue, it will receive it on SDMA0. (Except on Aldebaran, due to the hardware quirk mentioned in the commit message. On Aldebaran, you would end up in the situation from the paragraph above, with one SDMA1 queue).
> 
> In none of these cases would we expect user-space to wait until a queue is free and keep trying to allocate. For all one process knows, such an allocation may never succeed. Imagine, for instance, 8 other processes that run perpetually and never relinquish their queue allocations. This SDMA allocations are not time-sliced on today's GPUs.
> 

Thanks again for the details!

> As for the "rather than going in any order" suggestion, the 3rd patch in this series attempts to address this concern without adding a lot of extra code complexity. I worry that ordering engines based on max free queues: a) would requiring more complexity than the current bitmap-based free-queue list, and b) doesn't allow us to easily handle the Aldebaran quirk mentioned above, which specifically deals with SDMA0.
> 

It may not be so complicated once this bitmap is viewed differently. 
Sent a sample logic separately, please check.

Thanks,
Lijo

> Thanks again,
> -Joe
> 
>>
>> Thanks,
>> Lijo
>>
>>> And thanks for the code suggestions up above, I will make those changes as requested.
>>>
>>> Thanks!
>>> -Joe
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Regards,
>>>>>      Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> +            /* Do not reuse SDMA0 for any subsequent SDMA queue
>>>>>>> +             * requests on Aldebaran. If SDMA0's queues are all
>>>>>>> +             * full, then this process should never use SDMA0
>>>>>>> +             * for any further requests
>>>>>>> +             */
>>>>>>> +            if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>>>>>>> +                    engine == 0)
>>>>>>> +                qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>>>>>>> +
>>>>>>> +            available_queue_bitmap = sdma_engine_mask(engine,
>>>>>>> num_engines);
>>>>>>> +            available_queue_bitmap &= dqm->sdma_bitmap;
>>>>>>> +
>>>>>>> +            if (!available_queue_bitmap)
>>>>>>> +                continue;
>>>>>>> +            /* Take the selected engine off the list so we will not
>>>>>>> +             * allocate two queues onto the same engine
>>>>>>> +             */
>>>>>>> +            qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>>>>>>> +            found_sdma = true;
>>>>>>> +
>>>>>>> +            bit = __ffs64(available_queue_bitmap);
>>>>>>> +            dqm->sdma_bitmap &= ~(1ULL << bit);
>>>>>>> +            q->sdma_id = bit;
>>>>>>> +            q->properties.sdma_engine_id = q->sdma_id % num_engines;
>>>>>>> +            q->properties.sdma_queue_id = q->sdma_id / num_engines;
>>>>>>> +            break;
>>>>>>> +        }
>>>>>>> +        if (!found_sdma) {
>>>>>>>                  pr_err("No more SDMA queue to allocate\n");
>>>>>>>                  return -ENOMEM;
>>>>>>>              }
>>>>>>> -
>>>>>>> -        bit = __ffs64(dqm->sdma_bitmap);
>>>>>>> -        dqm->sdma_bitmap &= ~(1ULL << bit);
>>>>>>> -        q->sdma_id = bit;
>>>>>>> -        q->properties.sdma_engine_id = q->sdma_id %
>>>>>>> -                get_num_sdma_engines(dqm);
>>>>>>> -        q->properties.sdma_queue_id = q->sdma_id /
>>>>>>> -                get_num_sdma_engines(dqm);
>>>>>>>          } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>>> -        if (dqm->xgmi_sdma_bitmap == 0) {
>>>>>>> +        num_engines = get_num_xgmi_sdma_engines(dqm);
>>>>>>> +        for_each_set_bit(engine, &(qpd->xgmi_sdma_engine_bitmap),
>>>>>>> num_engines) {
>>>>>>> +            available_queue_bitmap = sdma_engine_mask(engine,
>>>>>>> num_engines);
>>>>>>> +            available_queue_bitmap &= dqm->xgmi_sdma_bitmap;
>>>>>>> +
>>>>>>> +            if (!available_queue_bitmap)
>>>>>>> +                continue;
>>>>>>> +            /* Take the selected engine off the list so we will not
>>>>>>> +             * allocate two queues onto the same engine
>>>>>>> +             */
>>>>>>> +            qpd->xgmi_sdma_engine_bitmap &= ~(1ULL << engine);
>>>>>>> +            found_sdma = true;
>>>>>>> +
>>>>>>> +            bit = __ffs64(available_queue_bitmap);
>>>>>>> +            dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>>>>>>> +            q->sdma_id = bit;
>>>>>>> +            /* sdma_engine_id is sdma id including
>>>>>>> +             * both PCIe-optimized SDMAs and XGMI-
>>>>>>> +             * optimized SDMAs. The calculation below
>>>>>>> +             * assumes the first N engines are always
>>>>>>> +             * PCIe-optimized ones
>>>>>>> +             */
>>>>>>> +            q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>>>>>>> +                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>>>>>>> +            q->properties.sdma_queue_id = q->sdma_id /
>>>>>>> +                get_num_xgmi_sdma_engines(dqm);
>>>>>>> +            break;
>>>>>>> +        }
>>>>>>> +        if (!found_sdma) {
>>>>>>>                  pr_err("No more XGMI SDMA queue to allocate\n");
>>>>>>>                  return -ENOMEM;
>>>>>>>              }
>>>>>>> -        bit = __ffs64(dqm->xgmi_sdma_bitmap);
>>>>>>> -        dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>>>>>>> -        q->sdma_id = bit;
>>>>>>> -        /* sdma_engine_id is sdma id including
>>>>>>> -         * both PCIe-optimized SDMAs and XGMI-
>>>>>>> -         * optimized SDMAs. The calculation below
>>>>>>> -         * assumes the first N engines are always
>>>>>>> -         * PCIe-optimized ones
>>>>>>> -         */
>>>>>>> -        q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>>>>>>> -                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>>>>>>> -        q->properties.sdma_queue_id = q->sdma_id /
>>>>>>> -                get_num_xgmi_sdma_engines(dqm);
>>>>>>>          }
>>>>>>>            pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
>>>>>>> @@ -1084,16 +1137,32 @@ static int allocate_sdma_queue(struct
>>>>>>> device_queue_manager *dqm,
>>>>>>>      }
>>>>>>>        static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>>>>>>> +                struct qcm_process_device *qpd,
>>>>>>>                      struct queue *q)
>>>>>>>      {
>>>>>>> +    uint32_t engine = q->properties.sdma_engine_id;
>>>>>>> +
>>>>>>>          if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>>>>>>>              if (q->sdma_id >= get_num_sdma_queues(dqm))
>>>>>>>                  return;
>>>>>>>              dqm->sdma_bitmap |= (1ULL << q->sdma_id);
>>>>>>> +        /* Don't give SDMA0 back to be reallocated on Aldebaran.
>>>>>>> +         * It is only OK to use this engine from the first allocation
>>>>>>> +         * within a process.
>>>>>>> +         */
>>>>>>> +        if (!(dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>>>>>>> +                    engine == 0))
>>>>>>> +            qpd->sdma_engine_bitmap |= (1ULL << engine);
>>>>>>> +
>>>>>>>          } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>>>              if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
>>>>>>>                  return;
>>>>>>>              dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
>>>>>>> +        /* engine ID in the queue properties is the global engine ID.
>>>>>>> +         * The XGMI engine bitmap ignores the PCIe-optimized engines.
>>>>>>> +         */
>>>>>>> +        engine -= get_num_sdma_engines(dqm);
>>>>>>> +        qpd->xgmi_sdma_engine_bitmap |= (1ULL << engine);
>>>>>>>          }
>>>>>>>      }
>>>>>>>      @@ -1303,7 +1372,7 @@ static int create_queue_cpsch(struct
>>>>>>> device_queue_manager *dqm, struct queue *q,
>>>>>>>          if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>>>              q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>>>              dqm_lock(dqm);
>>>>>>> -        retval = allocate_sdma_queue(dqm, q);
>>>>>>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>>>>>>              dqm_unlock(dqm);
>>>>>>>              if (retval)
>>>>>>>                  goto out;
>>>>>>> @@ -1365,7 +1434,7 @@ static int create_queue_cpsch(struct
>>>>>>> device_queue_manager *dqm, struct queue *q,
>>>>>>>          if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>>>>>              q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>>>>>              dqm_lock(dqm);
>>>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>>>              dqm_unlock(dqm);
>>>>>>>          }
>>>>>>>      out:
>>>>>>> @@ -1536,7 +1605,7 @@ static int destroy_queue_cpsch(struct
>>>>>>> device_queue_manager *dqm,
>>>>>>>            if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>>>>>>              (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>>>>>>> -        deallocate_sdma_queue(dqm, q);
>>>>>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>>>>>              pdd->sdma_past_activity_counter += sdma_val;
>>>>>>>          }
>>>>>>>      @@ -1751,9 +1820,9 @@ static int process_termination_cpsch(struct
>>>>>>> device_queue_manager *dqm,
>>>>>>>          /* Clear all user mode queues */
>>>>>>>          list_for_each_entry(q, &qpd->queues_list, list) {
>>>>>>>              if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>>>>>>> -            deallocate_sdma_queue(dqm, q);
>>>>>>> +            deallocate_sdma_queue(dqm, qpd, q);
>>>>>>>              else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>>>>>> -            deallocate_sdma_queue(dqm, q);
>>>>>>> +            deallocate_sdma_queue(dqm, qpd, q);
>>>>>>>                if (q->properties.is_active) {
>>>>>>>                  decrement_queue_count(dqm, q->properties.type);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> index ab83b0de6b22..c38eebc9db4d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> @@ -576,6 +576,8 @@ struct qcm_process_device {
>>>>>>>          struct list_head priv_queue_list;
>>>>>>>            unsigned int queue_count;
>>>>>>> +    unsigned long sdma_engine_bitmap;
>>>>>>> +    unsigned long xgmi_sdma_engine_bitmap;
>>>>>>>          unsigned int vmid;
>>>>>>>          bool is_debug;
>>>>>>>          unsigned int evicted; /* eviction counter, 0=active */
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> index 21ec8a18cad2..13c85624bf7d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> @@ -1422,6 +1422,7 @@ struct kfd_process_device
>>>>>>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>>>>>>                                  struct kfd_process *p)
>>>>>>>      {
>>>>>>>          struct kfd_process_device *pdd = NULL;
>>>>>>> +    const struct kfd_device_info *dev_info =
>>>>>>> dev->dqm->dev->device_info;
>>>>>>>            if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
>>>>>>>              return NULL;
>>>>>>> @@ -1446,6 +1447,8 @@ struct kfd_process_device
>>>>>>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>>>>>>          pdd->qpd.pqm = &p->pqm;
>>>>>>>          pdd->qpd.evicted = 0;
>>>>>>>          pdd->qpd.mapped_gws_queue = false;
>>>>>>> +    pdd->qpd.sdma_engine_bitmap =
>>>>>>> BIT_ULL(dev_info->num_sdma_engines) - 1;
>>>>>>> +    pdd->qpd.xgmi_sdma_engine_bitmap =
>>>>>>> BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
>>>>>>>          pdd->process = p;
>>>>>>>          pdd->bound = PDD_UNBOUND;
>>>>>>>          pdd->already_dequeued = false;
>>>>>>>
