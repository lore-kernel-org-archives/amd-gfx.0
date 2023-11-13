Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43407C4167D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 15:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C420C10E3A7;
	Mon, 13 Nov 2023 15:31:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C4C10E3A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 15:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzcwWBu65Ej8Ff3nVwMqFmHJvyinGtru0yiCZdhJ402LMCRwSAb7o42MVDn/khSneDwUDYd2DfI/ufOiayDDdPnQ8iMOe9l1Wx8Al9E29WA2Nuv8dBCzec3hC6IXJO8F7flun3oeX/aP/xFY1jm0N+wgUrjyKy8ecIwDv2xudE5B3hBFti0IoCV7B1VAH8YclddkG1AVT55R4v0cI5Y5vMPaseMkbZ+/gALuZJf+Ky6g/PtrGNLEv/ZwDgINVzhJC2fE5Kdl22rOttyejdGhU3TXWrtnozbXtQUdqON6NU/6hr6VxuCb4VSHn3P/a+XfYW9l1E3E4k/ngMbvIhzUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNxvjwdXjTJcHYFreJM0nbv+SRwO6xEr6/vyMOPDePw=;
 b=GBP+IBsgRXvYh8YcLL/J9IwEghxFutplIpAPMRs5ZAoKbU4GtNbMY2WlzczJT+mk8l/HDLsIryHGbd5hXFd1e7xsL7du5BV5OgrsP940qDSkMhULu6sroersovt5lrrwJM4UqVFMyQdD9sJT8ZlU/LS1XUGlCVworqJStXdE/ndlha4arEkRO5xuZYgGSNjomedwNiM89A112eLTrSd51MfJ5wpdNTntGsTXGVo8gxPyt8NVAWfvPE50jjg2BOb9rp9OytG2ef1IdFtqFqMeY1A5u2ESGt/qQfjA97VSFO64xmpsKxK5CcMOJMtEGr+JQHDupvxpbOGrMhE3MWdQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNxvjwdXjTJcHYFreJM0nbv+SRwO6xEr6/vyMOPDePw=;
 b=AYeLehr7RbbO924uIPlWH2XPgdbfGEdyWjVPPeKvv7l42eS87DLQ7d78iylzTfS6nA6OVdFWO2hXFwykSRke7sIHmDsxqeuhOon7fOwfSk3HKbpNPUYRtuwIUvLBldRBo+bQiTCAhISSj/IoRT54v/7M27/DkPZVPokJCxRmQ44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:30:56 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:30:55 +0000
Content-Type: multipart/alternative;
 boundary="------------r6JMQFiqU8GjVNCDoe98Nu1S"
Message-ID: <f3d9fafb-79f6-42c5-ae72-e96e89b4780c@amd.com>
Date: Mon, 13 Nov 2023 10:30:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
 release
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-23-James.Zhu@amd.com>
 <DM6PR12MB5021960306E3061166F20DE095AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
 <e26179d6-f172-4df4-8ea3-a3cbceac6ce0@amd.com>
 <DM6PR12MB5021BC6217026CE5B39A17A395B3A@DM6PR12MB5021.namprd12.prod.outlook.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <DM6PR12MB5021BC6217026CE5B39A17A395B3A@DM6PR12MB5021.namprd12.prod.outlook.com>
X-ClientProxiedBy: QB1P288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::35) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 855993d4-4cd9-4da9-c2be-08dbe45d874a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXK3GeFH2JEoZ8cv3T9+wanF6t/JJ5vEiukWfBdHujirQAWN5PVlv12LAR+Zo3ukHY2+FflraCnlKqxtrAZheaiCZlmMVHn0PQwzO/CxWprmup2sX/1pH0VcEfNbiRWQeiSMTtH6rDsuNP0vT301Nvrnt+TBrO83/FYoJBZANbY606fgwpb9h0BjciDZR2f8qpljwIyY6HrsgVHu9g1cOhF7gIiWI80rEFSeSUymye3ByD2RjJbfSY+G6vxGb/2hmvZFWky8jsGHWvlUJGI+e0SQnIyY7ZnhAgJlSoi83j+OmBNvuvnd2ckMEBtB+QuX+CqTorNRYzJ2VjdOxFrlSjJ4WInmqhQA5Etx8AJuvmqcqFgl6yQqahDenXe3xZTvwylr/8+BwK+Rm+67Qp9cxu7+4kUXoE08lmfehMQxdNCn5jzFVc7B3iOdwYvw+KIV8/TVRiVjpbWvX20rQE6sVqvjKr0hZK8fErS5G+OrYBWNmyXvoqRZOL6bH2xqHvvA6BxsuEI4y7PjKVuJvyHJ9hFC/oeLlIn9XxE7LcCCd4XJqrBiMM9JCeHlb4pfGKwPCnhNGVzP83R2mJ9gZwTH0qKWz+lm6Xgxs7Pq+RbqqnqwYK2Fy5F7D5NZUGAiqsekTR2gvZdPNe2j/+lr1CUwQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(2616005)(5660300002)(31696002)(41300700001)(26005)(4001150100001)(110136005)(54906003)(66556008)(66946007)(6512007)(66476007)(316002)(38100700002)(83380400001)(31686004)(36756003)(478600001)(6486002)(53546011)(36916002)(33964004)(6506007)(8676002)(4326008)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRZWFhZMWlsUWp4Z1dlZDl1ZW4wamY4UkdvajV0ZXphdUhTS29yRE4wcUZn?=
 =?utf-8?B?ZHlidmRwTytIdTRSU1ovWHQ3RDQ0QWNVRjBuQTlhNU5zTWs4VFJhVTNzZ2wz?=
 =?utf-8?B?Y3Z3VVlkNmFTaU5PSXVMV25IM0pZZG9qSXlMajd4VEJDTDl4S2xrTVJnaFZ5?=
 =?utf-8?B?T3hadVRTTDJLTG84Z2FXdnNOMzIwclFYNGhUbWFhWWFHL2hsOUdhUHdkNTZm?=
 =?utf-8?B?ZGlJN2VRbUdjeVdGUlVvU3g3NXhlaS8ybmEyRUdXN3c4R0k1RThEY1Y4NGdS?=
 =?utf-8?B?eG5kaEF3UzdXSTkyRFd1dFpLajRBQU9DTnQ1UXVlSzZQd0FsTC9CcmtrQ1R2?=
 =?utf-8?B?M3Y0SUJxMUUyOWswNTB3RFJiclNDMkloK2w1SFp5ODdpYm5sUjhhMHNyMytT?=
 =?utf-8?B?TDh1WGl6WVdnYzE0dVZHOVlCZjBURDZPaE0zZU1JUGZDWFhKUE83L2tMZlFK?=
 =?utf-8?B?RFVJcXdBVXZGcWVrczVKYzh6VWJldzRPR1l4c0dycko5VEsrbVdUVFdRQUV3?=
 =?utf-8?B?MmJTOXUyNmdsZUlWQTlIc0xlTC9RMWI1NTVHU2wvejhoZk5PUitsY2Q2N0NM?=
 =?utf-8?B?bUg3SnN6TWhpbDQ1Z0FodCsyWWxVZEZ3aWlYaU5heTVHek1SQ1lHK1lNMFhS?=
 =?utf-8?B?OVFMWXVtbXdod2pnUVB1R09BVFMwUHQyeWtpWHBJSDhPbEVaWXZOR2QvTitz?=
 =?utf-8?B?NSs1S0N3OFNYTDVaeFc4UW1tWm5ERUJGTGtXNk5zWWx2Tkh6bGVZUUhHeUJs?=
 =?utf-8?B?WDErTFpDMHdiaDcyaHVNcHQyaUJteHdod1A0NllWdS93Uklrc1hwNkk0UC9I?=
 =?utf-8?B?c1ZqYmNrYnlZMm1SVGxOQlpKTXRaRUdFNENrYTJRd3g2N2tQSENCZ3FkNzBU?=
 =?utf-8?B?RU1YYkluTWt2UEVCMGdTVW9MbnpXa1BsZ0ZzaDNZYjhQcUFNVW5Zcm1RZUs1?=
 =?utf-8?B?em5xcmt1SlMvdk5ZRzFMZy8vYjFuQWJPWDdhYXpHNGxqU05YZ3gzdUc1ejFU?=
 =?utf-8?B?amJHRk40TnB6NEJZWWpiN0xCYS84UFpyYk1pQ2JYRHdEVGdVWUFUalBpa2VI?=
 =?utf-8?B?WmJhamt5R0QvSzREdkJGRUJWYkFnVngvQmNSb1N1QldUdnlEUjh2RWNlTUFL?=
 =?utf-8?B?NUFZeWVYb2duVzFaaGZnWjBEdlk4NnFranRzeUU1UHJWbXhmTVdFYkVtbE9J?=
 =?utf-8?B?ckR5bktnRGhveFlQS1ZMZXhrQWRGSzRVUm1RV1NEcjdtcGtlZ01SL2VBTGZo?=
 =?utf-8?B?M2hXQ2FmUzg2NUY3Qm9LLysyWlpEeUZwbDRTZUhlMzk1SzRONlN5UkFGemc3?=
 =?utf-8?B?aFErS2Zmc3ROTzFaK2JGWm9FZEJYVlJySG5uMVFmSnl2MHFGUWQxdUZ0bll3?=
 =?utf-8?B?dmZiRkIzbEd4TjVLV3RGdUxsYTF3VEJ2WmhWdm5rck9RNkFPd0JYZmliN3FL?=
 =?utf-8?B?a3U2L003dE5QUzRtMnllQjN2VHorSTBYKzRla0l6YWR2UGxWbE1LZlNZSlha?=
 =?utf-8?B?NWsrMU1LNmFqVGp4OFNqaDM1VmhKQi9YYlljSWxFYUs2djVna2ZmUW9YQlFh?=
 =?utf-8?B?Y2VVbi9GTXFKUWxLTC9TR09Bb1plQ0phdWR5WFZQazQzQzB2SVJma1JwR0cx?=
 =?utf-8?B?NGh1UVQ2VHJ1Mk5WdGt6TGRLRDdRWGdXR2xxUms2V0RsOGl2TXlMWVNRUkgz?=
 =?utf-8?B?eWVlMzFRandJaGhHYTY2MnhBUElPSmRSdTlCamxydXFWNXF1Uzd3UEZHQ090?=
 =?utf-8?B?OEhFWGVwb3R3RXNPYy9aRHFZTkdzOVY4V0VxcnE3WjNWQjZsUWRBT09VUkFj?=
 =?utf-8?B?L3FjQ1ZZZ0x2blZyaTgxQkFKSDl1bUJZaitUdTVIYUtYb2F2SFhjemFrMVBU?=
 =?utf-8?B?U2tFSllHdSt5TWhrTitMVE9MeE54QyszZ3JlbjJBbXJ1TjdQTWZmN2NZTDNV?=
 =?utf-8?B?S1JCemdjbzNselhqK1FpTEwzQkxlZ1kxRE4zdmd2bldwcmRYNXROT1pWVEgv?=
 =?utf-8?B?cWNabDBiblRRWkUxYnhtV2UzZUx0MEF2a3JpM1dubXEzYlZmaWNKNTgzdDV0?=
 =?utf-8?B?Tm94Z0wyaVg4b05oTjlza2RiYlprL09TaXNQWnlTNjNQMDhsWjVDcWlaR0cz?=
 =?utf-8?Q?KmHrnnd52naaTH0eK7GuhE16p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855993d4-4cd9-4da9-c2be-08dbe45d874a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:30:55.8351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldMrPP9EUCNRvYSKYIXICSVNi5lGd0syAWbQVga+av5Dy19jNNUR0/nWya+313yw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------r6JMQFiqU8GjVNCDoe98Nu1S
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023-11-13 10:19, Yat Sin, David wrote:
>
> [AMD Official Use Only - General]
>
>
> *From:* Zhu, James <James.Zhu@amd.com>
> *Sent:* Monday, November 13, 2023 10:13 AM
> *To:* Yat Sin, David <David.YatSin@amd.com>; Zhu, James 
> <James.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph 
> <Joseph.Greathouse@amd.com>
> *Subject:* Re: [PATCH 22/24] drm/amdkfd: add pc sampling release when 
> process release
>
> On 2023-11-10 14:08, Yat Sin, David wrote:
>
>     [AMD Official Use Only - General]
>
>         -----Original Message-----
>
>         From: Zhu, James<James.Zhu@amd.com>  <mailto:James.Zhu@amd.com>
>
>         Sent: Friday, November 3, 2023 9:12 AM
>
>         To:amd-gfx@lists.freedesktop.org
>
>         Cc: Kuehling, Felix<Felix.Kuehling@amd.com>  <mailto:Felix.Kuehling@amd.com>; Greathouse, Joseph
>
>         <Joseph.Greathouse@amd.com>  <mailto:Joseph.Greathouse@amd.com>; Yat Sin, David<David.YatSin@amd.com>  <mailto:David.YatSin@amd.com>; Zhu,
>
>         James<James.Zhu@amd.com>  <mailto:James.Zhu@amd.com>
>
>         Subject: [PATCH 22/24] drm/amdkfd: add pc sampling release when process
>
>         release
>
>         Add pc sampling release when process release, it will force to stop all activate
>
>         sessions with this process.
>
>         Signed-off-by: James Zhu<James.Zhu@amd.com>  <mailto:James.Zhu@amd.com>
>
>         ---
>
>           drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26
>
>         ++++++++++++++++++++  drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |
>
>         1 +
>
>           drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
>
>           3 files changed, 30 insertions(+)
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         index 66670cdb813a..00d8d3f400a9 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
>
>         @@ -274,6 +274,32 @@ static int kfd_pc_sample_destroy(struct
>
>         kfd_process_device *pdd, uint32_t trace_
>
>                return 0;
>
>           }
>
>         +void kfd_pc_sample_release(struct kfd_process_device *pdd) {
>
>         +     struct pc_sampling_entry *pcs_entry;
>
>         +     struct idr *idp;
>
>         +     uint32_t id;
>
>         +
>
>         +     if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>
>         +             pr_err("PC Sampling does not support sched_policy %i",
>
>         sched_policy);
>
>         +             return;
>
>         +     }
>
>     You do not need to check the sched_policy here, already checked in kfd_ioctl_pc_sample(..) , so cannot have a hosttrap session if policy is NO_HWS.
>
>   [JZ]kfd_pc_sample_release is not called from kfd_ioctl_pc_sample. It 
> is in process quit process.
>
> [David] I know. But you cannot have a PC sampling session during 
> process clean-up when policy=NO_HWS because the session creation would 
> have been blocked on session-create.
>
[JZ] good point.
>
>         +
>
>         +     /* force to release all PC sampling task for this process */
>
>         +     idp = &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
>
>         +     mutex_lock(&pdd->dev->pcs_data.mutex);
>
>         +     idr_for_each_entry(idp, pcs_entry, id) {
>
>         +             if (pcs_entry->pdd != pdd)
>
>         +                     continue;
>
>         +             mutex_unlock(&pdd->dev->pcs_data.mutex);
>
>     Can we not release the mutex here and just tell the worker thread to exit by setting the stop_enable bit.
>
>     I find we have a lot of places where we are acquiring/releasing the mutex within loops and this results in a
>
>     lot of extra states that we have to account for during the start/stop/destroy calls.
>
>         +             if (pcs_entry->enabled)
>
>         +                     kfd_pc_sample_stop(pdd, pcs_entry);
>
>         +             kfd_pc_sample_destroy(pdd, id, pcs_entry);
>
>         +             mutex_lock(&pdd->dev->pcs_data.mutex);
>
>         +     }
>
>         +     mutex_unlock(&pdd->dev->pcs_data.mutex);
>
>         +}
>
>         +
>
>           int kfd_pc_sample(struct kfd_process_device *pdd,
>
>                                                struct kfd_ioctl_pc_sample_args __user
>
>         *args)  { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>
>         b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>
>         index cb93909e6bd3..4ea064fdaa98 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
>
>         @@ -30,6 +30,7 @@
>
>           int kfd_pc_sample(struct kfd_process_device *pdd,
>
>                                                struct kfd_ioctl_pc_sample_args __user
>
>         *args);
>
>         +void kfd_pc_sample_release(struct kfd_process_device *pdd);
>
>           void kfd_pc_sample_handler(struct work_struct *work);
>
>           #endif /* KFD_PC_SAMPLING_H_ */
>
>         diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>
>         b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>
>         index d22d804f180d..54f3db7eaae2 100644
>
>         --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>
>         +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>
>         @@ -43,6 +43,7 @@ struct mm_struct;
>
>           #include "kfd_svm.h"
>
>           #include "kfd_smi_events.h"
>
>           #include "kfd_debug.h"
>
>         +#include "kfd_pc_sampling.h"
>
>           /*
>
>            * List of struct kfd_process (field kfd_process).
>
>         @@ -1020,6 +1021,8 @@ static void kfd_process_destroy_pdds(struct
>
>         kfd_process *p)
>
>                        pr_debug("Releasing pdd (topology id %d) for process (pasid
>
>         0x%x)\n",
>
>                                        pdd->dev->id, p->pasid);
>
>         +             kfd_pc_sample_release(pdd);
>
>         +
>
>                        kfd_process_device_destroy_cwsr_dgpu(pdd);
>
>                        kfd_process_device_destroy_ib_mem(pdd);
>
>         --
>
>         2.25.1
>
--------------r6JMQFiqU8GjVNCDoe98Nu1S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-11-13 10:19, Yat Sin, David
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM6PR12MB5021BC6217026CE5B39A17A395B3A@DM6PR12MB5021.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Consolas",serif;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> Zhu, James
                  <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a> <br>
                  <b>Sent:</b> Monday, November 13, 2023 10:13 AM<br>
                  <b>To:</b> Yat Sin, David
                  <a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a>; Zhu, James
                  <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  <b>Cc:</b> Kuehling, Felix
                  <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Greathouse, Joseph
                  <a class="moz-txt-link-rfc2396E" href="mailto:Joseph.Greathouse@amd.com">&lt;Joseph.Greathouse@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 22/24] drm/amdkfd: add pc
                  sampling release when process release<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">On 2023-11-10 14:08, Yat Sin, David
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre>[AMD Official Use Only - General]<o:p></o:p></pre>
              <pre><o:p>&nbsp;</o:p></pre>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>-----Original Message-----<o:p></o:p></pre>
                <pre>From: Zhu, James <a href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><o:p></o:p></pre>
                <pre>Sent: Friday, November 3, 2023 9:12 AM<o:p></o:p></pre>
                <pre>To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
                <pre>Cc: Kuehling, Felix <a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>; Greathouse, Joseph<o:p></o:p></pre>
                <pre><a href="mailto:Joseph.Greathouse@amd.com" moz-do-not-send="true">&lt;Joseph.Greathouse@amd.com&gt;</a>; Yat Sin, David <a href="mailto:David.YatSin@amd.com" moz-do-not-send="true">&lt;David.YatSin@amd.com&gt;</a>; Zhu,<o:p></o:p></pre>
                <pre>James <a href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><o:p></o:p></pre>
                <pre>Subject: [PATCH 22/24] drm/amdkfd: add pc sampling release when process<o:p></o:p></pre>
                <pre>release<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Add pc sampling release when process release, it will force to stop all activate<o:p></o:p></pre>
                <pre>sessions with this process.<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Signed-off-by: James Zhu <a href="mailto:James.Zhu@amd.com" moz-do-not-send="true">&lt;James.Zhu@amd.com&gt;</a><o:p></o:p></pre>
                <pre>---<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26<o:p></o:p></pre>
                <pre>++++++++++++++++++++&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |<o:p></o:p></pre>
                <pre>1 +<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<o:p></o:p></pre>
                <pre> 3 files changed, 30 insertions(+)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>index 66670cdb813a..00d8d3f400a9 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c<o:p></o:p></pre>
                <pre>@@ -274,6 +274,32 @@ static int kfd_pc_sample_destroy(struct<o:p></o:p></pre>
                <pre>kfd_process_device *pdd, uint32_t trace_<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></pre>
                <pre> }<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>+void kfd_pc_sample_release(struct kfd_process_device *pdd) {<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; struct pc_sampling_entry *pcs_entry;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; struct idr *idp;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; uint32_t id;<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;PC Sampling does not support sched_policy %i&quot;,<o:p></o:p></pre>
                <pre>sched_policy);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
              </blockquote>
              <pre>You do not need to check the sched_policy here, already checked in kfd_ioctl_pc_sample(..) , so cannot have a hosttrap session if policy is NO_HWS.<o:p></o:p></pre>
            </blockquote>
            <p class="MsoNormal">&nbsp; [JZ]kfd_pc_sample_release is not
              called from kfd_ioctl_pc_sample. It is in process quit
              process.
              <o:p></o:p></p>
            <p class="MsoNormal" style="margin-left:5.25pt">[David] I
              know. But you cannot have a PC sampling session during
              process clean-up when policy=NO_HWS because the session
              creation would have been blocked on session-create.</p>
          </div>
        </div>
      </div>
    </blockquote>
    [JZ] good point.<br>
    <blockquote type="cite" cite="mid:DM6PR12MB5021BC6217026CE5B39A17A395B3A@DM6PR12MB5021.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <p class="MsoNormal" style="margin-left:5.25pt"><o:p></o:p></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>+<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; /* force to release all PC sampling task for this process */<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; idp = &amp;pdd-&gt;dev-&gt;pcs_data.hosttrap_entry.base.pc_sampling_idr;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; idr_for_each_entry(idp, pcs_entry, id) {<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pcs_entry-&gt;pdd != pdd)<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
              </blockquote>
              <pre>Can we not release the mutex here and just tell the worker thread to exit by setting the stop_enable bit.<o:p></o:p></pre>
              <pre>I find we have a lot of places where we are acquiring/releasing the mutex within loops and this results in a<o:p></o:p></pre>
              <pre>lot of extra states that we have to account for during the start/stop/destroy calls.<o:p></o:p></pre>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pcs_entry-&gt;enabled)<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_pc_sample_stop(pdd, pcs_entry);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_pc_sample_destroy(pdd, id, pcs_entry);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pdd-&gt;dev-&gt;pcs_data.mutex);<o:p></o:p></pre>
                <pre>+}<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre> int kfd_pc_sample(struct kfd_process_device *pdd,<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_pc_sample_args __user<o:p></o:p></pre>
                <pre>*args)&nbsp; { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h<o:p></o:p></pre>
                <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h<o:p></o:p></pre>
                <pre>index cb93909e6bd3..4ea064fdaa98 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h<o:p></o:p></pre>
                <pre>@@ -30,6 +30,7 @@<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre> int kfd_pc_sample(struct kfd_process_device *pdd,<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_pc_sample_args __user<o:p></o:p></pre>
                <pre>*args);<o:p></o:p></pre>
                <pre>+void kfd_pc_sample_release(struct kfd_process_device *pdd);<o:p></o:p></pre>
                <pre> void kfd_pc_sample_handler(struct work_struct *work);<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre> #endif /* KFD_PC_SAMPLING_H_ */<o:p></o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<o:p></o:p></pre>
                <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<o:p></o:p></pre>
                <pre>index d22d804f180d..54f3db7eaae2 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<o:p></o:p></pre>
                <pre>@@ -43,6 +43,7 @@ struct mm_struct;<o:p></o:p></pre>
                <pre> #include &quot;kfd_svm.h&quot;<o:p></o:p></pre>
                <pre> #include &quot;kfd_smi_events.h&quot;<o:p></o:p></pre>
                <pre> #include &quot;kfd_debug.h&quot;<o:p></o:p></pre>
                <pre>+#include &quot;kfd_pc_sampling.h&quot;<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre> /*<o:p></o:p></pre>
                <pre>&nbsp; * List of struct kfd_process (field kfd_process).<o:p></o:p></pre>
                <pre>@@ -1020,6 +1021,8 @@ static void kfd_process_destroy_pdds(struct<o:p></o:p></pre>
                <pre>kfd_process *p)<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Releasing pdd (topology id %d) for process (pasid<o:p></o:p></pre>
                <pre>0x%x)\n&quot;,<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;dev-&gt;id, p-&gt;pasid);<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_pc_sample_release(pdd);<o:p></o:p></pre>
                <pre>+<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_device_destroy_cwsr_dgpu(pdd);<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_device_destroy_ib_mem(pdd);<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>--<o:p></o:p></pre>
                <pre>2.25.1<o:p></o:p></pre>
              </blockquote>
              <pre><o:p>&nbsp;</o:p></pre>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------r6JMQFiqU8GjVNCDoe98Nu1S--
