Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F19C76196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 06:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D55D110E089;
	Fri,  7 Apr 2023 06:42:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CE5010E089
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 06:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNLKGIZQhJn0I67SdS3SNMB5CF2qeVpuZpJPKjweMRgMJ4LGGSA1q3EV8EKO7Im0R82vaGAs2QpFG2s4XpG2rzBeCTH07l8GmnYaZ9QBQgtachP93NlTScpJqU5mEw8fJzAIbC0ZGdnvx5n8CoXM75qC6by+cKRMI7B5Eb9I80k2LwY4f+EvsDDUGTWXquX+joSbF0OIDRir5O8pbRSZ1SdpOb81KSGv86WMR2MYKg73Q14EtMqTX6bgCup8lVs6yCxdrWeEdtkrf3BkKOmkgQ+9YkIhwpx/xaQpraoiyUWNNVvUDueB7bj4lgRECpEbqmz//vFR71EtploRoB6HFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJjLhCK8hUBWsOiriAnbajLnmPzzTcgy1Xwb9UKGuDo=;
 b=XSxroxf7PPa8DhXZr/7QIA/Zb5gEHT2s+H0NUCglsuzkx5MikH1ni1W9LWI0tWisc4TTmRCi0xRsh+1oM1YiWC14unBGln6WzbkXJtNxW5khNVSxAzui2E+z0ja1lSygVffUycBYw1jh2hyMndutb6oau4Ys+4G9PvuLmZZ420XvT8COHvrWHGrUMe3Gzu4+wdCLTcOJ1PbUbJipVvzSzvy2UFOFMqb8OEJq6NqCC9yVg9ds3PiIc7oWT0rJNaJfmM0mKELHWn989pJbQlVBD6lppUW+oiN8+0IAvoXQ4SboBb/IAepU04hmGnHD4G4GbthE12W0hDvOESbwGed7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJjLhCK8hUBWsOiriAnbajLnmPzzTcgy1Xwb9UKGuDo=;
 b=DX94+LvALjZiLje0GXUzyXn6b0hYdTR5XHQlsSVpeiqCflHDHGnmeRiTb2cnJ12Vumkco0cJF0eTvZVzf9w15TIsg7oigeQN+vW/FJ6phlpithq2S7Y9Kj+QXXzQWlAlbGzlqkPfkXWE5GYD9D3UQAbp35AJU9L4s+QtGTrTmeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 06:42:03 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6254.033; Fri, 7 Apr 2023
 06:42:03 +0000
Message-ID: <fa1e9c94-7ca3-421c-3976-c5a8b456e061@amd.com>
Date: Fri, 7 Apr 2023 08:41:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
 <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
 <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
 <772cf310-9414-b229-5bbc-90c0de03679a@amd.com>
 <501eb889-0591-b0ad-901e-fe8d1d5c9761@amd.com>
 <bfbfab82-ca0b-d70a-86a6-6a72301beaa2@amd.com>
 <f4f3f3dd-f8a2-6bbf-b241-ed29aa95bed4@amd.com>
 <000399c1-b5fc-824b-4379-49ecf19dddbf@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <000399c1-b5fc-824b-4379-49ecf19dddbf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a424bc-5df8-416d-c99b-08db3733329e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2ybh+ms1BODnJ4ow2WyuCva7Ky/IxQHtygje0Q02J/MQz5C3sYUOp2Ix9+kdpl3g9yBjB20NXPgE1kp9zKLxm0X5qMg0kDfPdm7c2xxXQ4PLOQ9NtE/52B0tccuP3KijxvrDyMsgjOARo7NXnnqX8dHGvf9BpYy/8JpkEi5DvOTP7HBKcJp7U+AEuIuMmWtO0141ZKwb9nhPtr8VN39HSZ1+afIEfS8GTeUkp+apYexZ+iI6JbE792PVt+mXke/H/biQ0APYfrrHaQWJVJDZ6hkIoP5g8jBH8o7/0nM2PJrA8oP8ab0IdGjC3UF0Vt8nDImO2AzqnjxDW9NQ0+4R1s3aHf1Ce9cfRWXzVz1TigmgtA1+0dZOhJneBM/b1ecJWM+M9Vk5Uiu3C64MByZWx/LBohlVNJJn3gnoT0HXtr8jQnUA/nCb5jdTJ/S/X8Y7flOo+LCDwiBFRwA8OisBYj7wSxG8mMCRpCbwYVHVsHpBpgsLfGPJgAEtU8SYtrWCzusioY6RmlQXy4gD2Il+VmPg7ZMFAplzm2vokRsqCi+Awt98zY7ciHj55tpHkICqdI3/I7oWmKxicJArOnjcpsqeLsio0jeM0GIUq12yZw16mjsI1o5X7wVQKF6kLkY10buq5dSR92z5BwkPBxxbonClBahbAOs3vcW8Ecm0FWnlbZM85PCO7iBYbMMrQfR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(83380400001)(2616005)(36756003)(186003)(26005)(6506007)(6486002)(6666004)(966005)(6512007)(54906003)(478600001)(110136005)(316002)(31686004)(66946007)(38100700002)(4326008)(8676002)(5660300002)(8936002)(41300700001)(44832011)(31696002)(53546011)(66556008)(66476007)(86362001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJJekJIRlowZ3RvUFpWTXE2M29jMjhwZWpaazdvczVKR3JnS0VlelF5Ri9y?=
 =?utf-8?B?U1FXUkVKaUx3eDgzR1FVRlNXNjNWYUZIcE9pV2hXeTduV0VISEVXYXcwdDFS?=
 =?utf-8?B?c1RkSnBRRVN1QllxWHNLcU9WeXpkcFNOYjZ1dmlCbEhWYXJ0Z1pENnNrRERi?=
 =?utf-8?B?UG1wL3ZHTFYzUjFldUtpc2dVcm1wcTk2a2N5NmgyYnc4akJHM3p1b2JuSzdR?=
 =?utf-8?B?TmxoeEk3MFkyZ2M4bitvdE4xWW5rUjNia0NyZU1YaTl5ZDBQWFlkZVVsYWFK?=
 =?utf-8?B?MkxGZjUxU2NRVUtuSHNBdWh1SUkxQWJQcW9rbnpsL2pZMVFiUUtQTUYwTjZJ?=
 =?utf-8?B?ejhUSHRpR0cweHhhS3Fja0dzMElsT3FhSFkyUzc2MXJpbzFlQ3lyb2pQS1gx?=
 =?utf-8?B?MnZkdnE3WGNRZTRJNEYrMXpIcnoyaU5LNDhFZ01kandsYytDZHRneVorTjJi?=
 =?utf-8?B?djZ1STV1RDhucWhlQlNZWUFjaTA1c1FMcDcwRFNBOGNJTlR6SG1wZEttcWkx?=
 =?utf-8?B?OFhEVmJEZUpzVkh3NnJDR0FGWGNQSnVGV05ybGpTNzNKNXF1ZGNOZ1RxNlBs?=
 =?utf-8?B?MElvMzFJOGRDVzJMTVpqZXVuK0NnN1BMd3hFZG5FMDEyMjdMSEViTlpSYmVO?=
 =?utf-8?B?b2lRR0VOVWpUTHNwMzVvWHJGMmZsWDNCVzFUbFJRWHVMSmdVOFVwSTFHOWxI?=
 =?utf-8?B?a2lKRVpFQ2tJVGt4WlJ2MmxBQzd6ZmRaZjBNUENZN1pLVGJ4WHRjVDdiRi9m?=
 =?utf-8?B?eXhNVTVQZmk5aTB2bWxEMTlFZFBkSVVnVkg0VnhaaXdmOW1QMkFzNXo0MXdJ?=
 =?utf-8?B?RWVCWUlpSHBlV1lKeVFQQjlYbEFXbXcxMGUwa3pLYWh1MFRjOGJQclFLcG1R?=
 =?utf-8?B?VFpBaHJuMnBEWnh6TXRrTitOczlNV0M0MGhIZnNrbDRVOU5HUUpOTS9RRVNs?=
 =?utf-8?B?MEZ6N2kxWlNBelR2aHlvekc0ZWtPcE1QVWRuSzRKRjF1K3crKzlYa1B2RzBy?=
 =?utf-8?B?OXFQUGZHOWJGaDlXSUtNR1BJdnNrRTZudFVrLzVDbzV5K2FOd0tMMEZrbjF4?=
 =?utf-8?B?M3JJZUREWFd2RTVRWjV5NjFBYU43TXFIeUFWbnJWTnlhQmozcHROem9rWlZx?=
 =?utf-8?B?OURnWVl3eXQvbjg2d09UUnFIVitoSW9UWk5Zb2JDRGpQZTJEQ01raXY5YTBt?=
 =?utf-8?B?d1Nld0VvL0NaSmlSRVlRa3hvamI4WklXUnNQSmpGNldpOHFoVWI5REVwdGRK?=
 =?utf-8?B?ZEhuckVkTkt0UXNsOEE3YmhsYVZZQXgvVDFoV0JsRlU3OExHVnVtYXA3OVk3?=
 =?utf-8?B?MnNWUE9vVVBVanN6ZFRieXYxSU5yVUlYaitTQ3NRVjNqbGw5RmUvYzFQZDZh?=
 =?utf-8?B?ZGJUYzlLNExxeENuQ0ZPbEUxcUhXbFdwTGZFK0Q3LzByNGhTU3hGbzRhNTJJ?=
 =?utf-8?B?R0FEUW9xSFVNU2ZkdFNmQnFCdWE4SE8zdG5lbllYSnZTeFdKakNOZGs0OG5E?=
 =?utf-8?B?NWY5ZDRDei9nNjFHTzhlQXRDdzd1Ti81YWwyRFNqMG40bm1NbXdPVU9Pdi8y?=
 =?utf-8?B?NjVTU0MveE9HZ1FURVBtZUlDZ2NjMC9yU0dSMHIvVk01b0l0M3ZkZTYzZlJx?=
 =?utf-8?B?V0lFR2s0OGo5SXBOci9UZnI5L0lCaTVOaDFFaVh5dkN4MUU1S3hFaHo2ZDJB?=
 =?utf-8?B?dHQxS0dDSjNYQTVnZEJqNDgyMG9tdy9lemFyV2EzOG1iMEFVd0w2V01OQUww?=
 =?utf-8?B?L0owalhVcXc5NTFTd2JITXdwQW9rbjl2Q21wcHF4MVc4TC9NNndnWWdpUFB3?=
 =?utf-8?B?dmhYUjJKL3VBMkpOREtYZXp5UkF2U2g1NEp0cWF4MjZxNHVBRkc0eTFGRC91?=
 =?utf-8?B?ajdKSTlqV2xtaCtZWXRGazZBZ3dQQXdTS2tRRU1EcWpHRitJVURuNDA1NzhC?=
 =?utf-8?B?Y3JpcHkwZ3dRdEt6aDYyR1pJUGFhWDY5Ui9lRHRkRGhhMDNScE80cERkUktj?=
 =?utf-8?B?Ui9rZjBYSGpZaGFSV05FaFlFdzBlVXZrRlhmRUhWN2xiV2dmN3BVbHorejRV?=
 =?utf-8?B?TGh0dk1lYTJoVHZSR2QwOWI2ZmwrdXNGdGtvVjFWNE9nSkFJRWJnMjRSOXpU?=
 =?utf-8?Q?Gr73tMcLol+AKv99FvaTeqGPN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a424bc-5df8-416d-c99b-08db3733329e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 06:42:03.6969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0/R7e+WXgL433guUMAUlc0A3Byj2Fg8N0MPmyP79VtpqabfYr4F+MLS1+k3uf8OxMHyGFvnXtMakuGDyGkg7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 06/04/2023 17:16, Felix Kuehling wrote:
> Am 2023-04-06 um 03:45 schrieb Shashank Sharma:
>>
>> On 05/04/2023 23:18, Luben Tuikov wrote: So, then why isn't Felix in 
>> the Cc tags? Doorbell changes touch that area too.
>>> He's actually the only one you left out, other than the MLs emails.
>>> Either add everyone to the Cc tags in the commit message, or only add
>>> your Sob line and leave everyone to a --cc= on the command line. 
>>> Both are
>>> common practice and acceptable.
>>
>> This code touches KFD code, and that's why Felix needs to be involved 
>> in the code-review process. But
>>
>> once code review is done, I don't want to spam his email every time 
>> this patch is pushed into some branch,
>>
>> so he is not in cover-letter CC. This is how I prefer to drive the 
>> code review of this patch, and I don't see a problem here.
>
> It's a big patch series, and I don't have time to review the whole 
> thing in detail. A CC tag on the patches that need my attention would 
> help.
>
Hey Felix,

noted. There are only 2 patches which touch the KFD code, I will keep 
you in CC only for those.

- Shashank


> Thanks,
>   Felix
>
>
>>
>>
>>>> Also, I would like to express that in my opinion we are spending 
>>>> way too
>>>> much time in discussing the 'preferences' around cover letter,
>>> I agree. But those aren't "preferences," they are common practices,
>>
>> This is not a common practice, its your interpretation of it.
>>
>> I also picked a few examples:
>>
>>
>> https://patchwork.freedesktop.org/patch/531143/?series=116163&rev=1
>>
>> This patch has multiple communities in Cc, none in cover-letter (also 
>> R-B'ed by you).
>>
>>
>> https://patchwork.freedesktop.org/patch/505571/
>>
>> https://patchwork.freedesktop.org/patch/442410/
>>
>> These are some of patches which has multiple people missing in the 
>> cover-letter CC than email-CC.
>>
>>
>> https://patchwork.freedesktop.org/patch/530652/?series=116055&rev=1
>>
>> This patch has multiple people in email-cc but none in cover-letter CC.
>>
>>
>> There could be tons of such examples for both, and the maintainers do 
>> not have any problem with that,
>>
>> So I don't consider this as common practice in DRM community, its 
>> just a preference, and hence it consumed
>>
>> a lot more time and efforts in this discussion than what it should have.
>>
>> - Shashank
>>
>>> like for instance not separating the Cc tags and the Sob tags with
>>> an empty line, or shifting struct member names to the same column
>>> for readability, and so on. Use "git log -- drivers/gpu/drm".
>>>
>>> Regards,
>>> Luben
>>>
>>>> words, comments and variable names. No cover letter is perfect, no
>>>> commit message is good enough to explain what is happening in code,
>>>>
>>>> no variable name is flawless and no comment explains what is going 
>>>> on in
>>>> code which is clear to everyone. These are very subjective to the
>>>>
>>>> author and the reader. The only deciding factor is if there is a
>>>> community rule/guideline on that.
>>>>
>>>>
>>>> I appreciate your time and suggestions but I also certainly do not 
>>>> want
>>>> to spend this much time to discuss how should we add people in Cc.
>>>>
>>>> Let's keep preferences separate from code review process.
>>>>
>>>> - Shashank
>>>>
>>>>> A good tool to use is "scripts/get_maintainer.pl" which works
>>>>> on a file, directory and even patch files.
>>>>>
>>>>> I usually include everyone get_maintainer.pl prints, and on 
>>>>> subsequent patch
>>>>> revisions, also people who have previously commented on the 
>>>>> patchset, as they
>>>>> might be interested to follow up. It's a good thing to do.
>>>>>
>>>>> Here are a couple of resources, in addition to DRM commits in the 
>>>>> tree,
>>>>> https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs 
>>>>>
>>>>> https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format 
>>>>>
>>>>> (The second link includes links to more resources on good patch 
>>>>> writing.)
>>>>>
>>>>> Hope this helps.
>>>>>
>>>>> Regards,
>>>>> Luben
>>>>>
>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>> Regards,
>>>>>>> Luben
>>>>>>>
>>>>>>>> .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 
>>>>>>>> +++++++++++++++++++
>>>>>>>>     1 file changed, 70 insertions(+)
>>>>>>>>
>>>>>>>> diff --git 
>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c 
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>>> index 39e90ea32fcb..1627641a4a4e 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>>> @@ -23,12 +23,73 @@
>>>>>>>>     #include "amdgpu.h"
>>>>>>>>     #include "amdgpu_userqueue.h"
>>>>>>>>     #include "v11_structs.h"
>>>>>>>> +#include "amdgpu_mes.h"
>>>>>>>>         #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>>>>>>     #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>>>>>>     #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>>>>>>     #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>>>>>>>     +static int
>>>>>>>> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>>> +                         struct amdgpu_usermode_queue *queue)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>>> +    struct mes_add_queue_input queue_input;
>>>>>>>> +    int r;
>>>>>>>> +
>>>>>>>> +    memset(&queue_input, 0x0, sizeof(struct 
>>>>>>>> mes_add_queue_input));
>>>>>>>> +
>>>>>>>> +    queue_input.process_va_start = 0;
>>>>>>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 
>>>>>>>> 1) << AMDGPU_GPU_PAGE_SHIFT;
>>>>>>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>>>>>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>>>>>>> +    queue_input.paging = false;
>>>>>>>> +
>>>>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>>>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>>>>>>> +    queue_input.inprocess_gang_priority = 
>>>>>>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>>>> +    queue_input.gang_global_priority_level = 
>>>>>>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>>>> +
>>>>>>>> +    queue_input.process_id = queue->vm->pasid;
>>>>>>>> +    queue_input.queue_type = queue->queue_type;
>>>>>>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>>>>>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>>>>>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>>>>>>> +    queue_input.doorbell_offset = 
>>>>>>>> queue->userq_prop.doorbell_index;
>>>>>>>> +    queue_input.page_table_base_addr = 
>>>>>>>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>>>>>>> +
>>>>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>>>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>>>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>>>>> +    if (r) {
>>>>>>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", 
>>>>>>>> queue->queue_id);
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void
>>>>>>>> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>>> +                           struct amdgpu_usermode_queue *queue)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>>> +    struct mes_remove_queue_input queue_input;
>>>>>>>> +    int r;
>>>>>>>> +
>>>>>>>> +    memset(&queue_input, 0x0, sizeof(struct 
>>>>>>>> mes_remove_queue_input));
>>>>>>>> +    queue_input.doorbell_offset = 
>>>>>>>> queue->userq_prop.doorbell_index;
>>>>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>>>>> +
>>>>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>>>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, 
>>>>>>>> &queue_input);
>>>>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>>>>> +    if (r)
>>>>>>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     static int amdgpu_userq_gfx_v11_create_ctx_space(struct 
>>>>>>>> amdgpu_userq_mgr *uq_mgr,
>>>>>>>> struct amdgpu_usermode_queue *queue)
>>>>>>>>     {
>>>>>>>> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct 
>>>>>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>>>>>>>             amdgpu_userq_set_ctx_space(uq_mgr, queue);
>>>>>>>>         amdgpu_bo_unreserve(mqd->obj);
>>>>>>>> +
>>>>>>>> +    /* Map the queue in HW using MES ring */
>>>>>>>> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
>>>>>>>> +    if (r) {
>>>>>>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>>>>>>> +        goto free_ctx;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>         DRM_DEBUG_DRIVER("MQD for queue %d created\n", 
>>>>>>>> queue->queue_id);
>>>>>>>>         return 0;
>>>>>>>>     @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct 
>>>>>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>>>>>>     {
>>>>>>>>         struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>>>>>>     +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>>>>>>>> amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>>>>>>>         amdgpu_bo_free_kernel(&mqd->obj,
>>>>>>>>                    &mqd->gpu_addr,
