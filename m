Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A618C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 15:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4677410EC05;
	Thu,  6 Apr 2023 15:17:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7698310EC05
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 15:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGOJtjpRGum4TTvbnNiFXj9ffpYEWcRhxv6sheVrVdb+IItl5+P9euJMwtD7WkiA/0vYHWoV/UwUdMtGBEaSAxHytjofFF142Nq6xJFC+m9gdGWakf5rFo3B/0/wdkqaKhPwno+fGQFtlUW0VHAHvjmSjWM83CBX59OoMWShWdp7urXDTBK3srDBwDYIr7NdrL+duT/6GS61pGl1ziLbue3lQxUbDJQUCmFexfGgljbhtf+g3D7nD+4RN66lJumuXEx75473Kr6T+O+2jSCyk34xKnPMCIFAbPFrqItpbcHIUFW8kfRlpewEzQ1n937rHZ1iWuF8wvzdlfaFMUWVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VFZ9B5B2iYl3a+Jczg803Vr9otrZLE67Wel5EGiknM=;
 b=NLWO4uSbcKqFewjbAjs4vsWmpmP7mEuezYfES5vWzFhPjk7KMR3Y7u2Oq27ZPXoiJSh5rB9ZL6obHo/8g8I+VbDU6zJfiw0SEay1tzUexwXCYlB1ohDaURXCYR7bd6/EEhzajkDa9cfIqNjyIwYfEjp71BC870rwxn5mlj9UT0kyUpWMioMUTE9eIvfqufLYEBYbnJy6gh2gSeVBS2k/TJFY+BKyC3WMYmCl0Wqh8w3pqoSSAVk98+TdZ4zzAmLK67mSBzqTcfwQX5LBtUwIiQ5+7E9TRb1rYYa2aXU7avc81Sk9gTZjdnYmFRDSo7RH2Mg61OKstPvUYDZ2DZIbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VFZ9B5B2iYl3a+Jczg803Vr9otrZLE67Wel5EGiknM=;
 b=dQ01QrgrcD4NDU0zkdo9rwGYKyNHo7t07VjBZ/eaooyOpEQ2xDr/pZguGSwJp9etUGWpGj9G4kFqnYVivzGFSC7KlSec6qjN7283fjhUWN9hyOnRZcSlnJ+6Caa6ZBjGMRnPSRAgyX02n2cyWD1XXByKhWmaQoGS3laN+szuCxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 15:17:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 15:17:01 +0000
Message-ID: <000399c1-b5fc-824b-4379-49ecf19dddbf@amd.com>
Date: Thu, 6 Apr 2023 11:16:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 7/9] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-8-shashank.sharma@amd.com>
 <9e2c2b90-f1b6-8ecf-fcc8-166b038d1993@amd.com>
 <5127600a-09ed-ac76-e841-f975e4d5ec7c@amd.com>
 <772cf310-9414-b229-5bbc-90c0de03679a@amd.com>
 <501eb889-0591-b0ad-901e-fe8d1d5c9761@amd.com>
 <bfbfab82-ca0b-d70a-86a6-6a72301beaa2@amd.com>
 <f4f3f3dd-f8a2-6bbf-b241-ed29aa95bed4@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <f4f3f3dd-f8a2-6bbf-b241-ed29aa95bed4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::24)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: ed926302-45c2-40f6-0d55-08db36b1f87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5azzW+3F+EyT1P8GAsEAOzptomTtQd0D1ZoKw8ZaI+pDg5UJZdnChrcK917mn09DfI10ZCUJZz5zAZfbulILzcTq4nOGTv9VFk2olViPDVFoyzhJ/DGBP8C45DCRRLvaWv+zvaRIiZs9NI61he4wfEX7ywKBaUTrp6k6CxGm0RlnhBFjLL3+/xzpjuvauYepmQKLv5k2urN9y7HwYydvVGgXXGOk5hSMW/umKdF+7fmVfmJ+NK4jpT8smyN+X4nLCMBF9+1VgkUxirxqDm68dsiAdN9IpsZYBSb7U6H759VGmxx3Wn164uogRZwHZ0VBoC9jlAYuQjyghq7dKNfj8bgUXGgGhgYJ4fbBnYe90/VEcDjDkzX+50C4qZjPYgFWM+5NPPI685ojT52+/7/eUkONUO2dGnHZDN0DZS4hZLOm23R2ZPz7pB7y9XJ/tHJTAQQoGxKWxYiw0fG3tGHeIPSkOs2OraD2c4bLm62w46zF0azWDvXBqe+pYu0ZORnFa/cRBOrY0CGGLxfIUceZMZKj5eVDNudgH39nYysw+YjuvWLrfFI08hML7rGD/kFRWvQfv/AK0XFGz3yAO9fF5IUlMid8VF3U5NZgocf7aAqkxmWQ1yjGVI1KTmNHjiadHwDU8g2gsnZzXJQCWk9YebMbyRFRVpsrOtV58dM8QzCfNIfY6VTcvkTnQo7QS7W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(31686004)(4326008)(36756003)(38100700002)(5660300002)(2906002)(44832011)(31696002)(8936002)(8676002)(86362001)(66556008)(66946007)(66476007)(41300700001)(966005)(6486002)(83380400001)(2616005)(186003)(6512007)(26005)(6506007)(54906003)(110136005)(6666004)(53546011)(478600001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWU3bnM5S3ZFVkxYRnI1ZXpLQWFvRUo2a29GQ2IzWWt1MExUUHMrMnlMMHZq?=
 =?utf-8?B?ZFBxT1lqTHR4VVJzNU5vbDEzSWhlRGdNOCtGVHJ5NFVtWC82SlVGZnRJZXlx?=
 =?utf-8?B?dmZuc3p5RDFQMm5PM2p3YUhaV0xwbmJuMGFZUlREOWZMRGFJVVFiS0hNN1RB?=
 =?utf-8?B?L1QvKy9HUllOeHpRdTFRNm0zSzNxdm5tbjBkcTBXSERrS00zRkJrbW5ld01X?=
 =?utf-8?B?bEpsRFdna3BQelhVMXdMQ2gwN3lWZFNaaHgzci9valBXd1FmbkxKYXdLSEtS?=
 =?utf-8?B?TnFBSXNCT2R6Zm5FL1p6alBQVkpOTzlLay9mc1pkUDBmRnZrcVhYMlpTZkdU?=
 =?utf-8?B?WFN3REx3NTlOUk14MExPOGRVY0c4TUlqczNidzZtN0NFell3UHBIVlV4V2Mx?=
 =?utf-8?B?UXJhUTFzSFdLZU1FZkhvNDRvVGxDdVVXYjgrWUh0Znl0K2h5RmxqaGR2WkRn?=
 =?utf-8?B?cmgwZ29Hek92UjErSk9TSm9ldXA3dTdHdU9DUTVJekFvVmlEYU5ubmFnV2NS?=
 =?utf-8?B?Z0hUem9jYU5nbHVpanFTWmlxU2pqWHBsbGxnWXVmWVJncWQ1SXpyZG9mQ1NH?=
 =?utf-8?B?V2ltRjU5Y083WklKSTF5dkttS2tiRnJqTVJkWWh2NDh2RHB3VHhwN0szWlVh?=
 =?utf-8?B?NGtoVFVnemo1K1hUeFRlc3FpNnpWSGZwakZzSEJDL0FvOHREQWNrc2tmcjNE?=
 =?utf-8?B?dUhjYUhoSzZ2YW9EcUI1b1J4UkNSMklIL29xamtjdGdxaS9TcnNxZUkzSWtK?=
 =?utf-8?B?UEI0bkp3UHEyZlFaYWpVdVg5cmlaUHVaU2JiaTY2UEhuSDZPU0dTYkxVcURP?=
 =?utf-8?B?aVhvMmM2Q2gySWhHSjFCaWlQT293anFUdDA0YS9rVkY4dTB3Z0xkcWV0MnpZ?=
 =?utf-8?B?Rk91NmRRcWtYT2x5QTNWUDBGWjFtQktKakEvU2RhYjg4eDBiVjRyZ1JBZ2xP?=
 =?utf-8?B?ZFFESklpd3FHRmQxM2x4VWk2aFV6SU9iaUpCOVhhY0VvUXhEbnpLK2Fyczlk?=
 =?utf-8?B?NGlQQlRqbHVVRmlCMytkS3ZKUmlGMkYwMm53RGUxQis0aVpmM3JTcU9lYkFm?=
 =?utf-8?B?d2ZRYlJ1VWorVWhPNXZKVForT0E0dC9SQUkyZytCZ2RPMWdXanZ3MnZYbWRv?=
 =?utf-8?B?ajB1eHhNR3FPQmYxZGtqeGlmSDA2dWpudlNEVnpKWEk3Mnc0QVk4RjBWaWl1?=
 =?utf-8?B?RUUxUzhHTzQ0L2RmdHVkTkpNRDFZN2d6MHRXb0p4OU1MYWIzMG9icmpUSGdJ?=
 =?utf-8?B?ZmdCL1hDbDFwR1UzMFRFM3ZKa3Z3Q1dCR3BwU210dEdxeDFFOVEzbDM3am9H?=
 =?utf-8?B?ODRER0x5MVc3WjBmVGpCWGh4UjA0NDdYa2JpU3ZoR2NzZzh5RjlvYkRMV0dk?=
 =?utf-8?B?RE1VYnMvK05QRzBCTlZ5TjNwakEyK2oxaWVFREFGeFdBMVZDV1VXYk01YnpB?=
 =?utf-8?B?RXBaaThVd0NlOWROd09LZ2RyYmZwTHgxdkFHMnFLVWtrK29CRXZGWXAvckhR?=
 =?utf-8?B?S2VFN3pUMlAvOUhIWURiWHFaUzNJTnhJb2NqMTVJd0hHaVlWczlFZVRlYllw?=
 =?utf-8?B?LzhrMHlPYXZDTXYwMFpDbGJ4Uml6Q2hXemRmTzB0QXVQd2tvaVJwZ1R2bkcr?=
 =?utf-8?B?V2p0WEk5a0pwTzBGdjBoeUJ4WTZMRzVPbktBanZSbkl3dnFVY29NOTA3ZENH?=
 =?utf-8?B?YkhBSHRqRm9kdG9sOE5ua2YwT3oyMW9qV1FiNzUyUW9YRHJkaU9pZzBNMHAw?=
 =?utf-8?B?aGhkT09kN1NIUjFlZ0huRThXTkxCYnNHcTN5enV5d2pGVXdPQUVDL0FCRHdi?=
 =?utf-8?B?ZjJtSEJOY204RmZpNVNmYUh2L3lNVHRzYnRqRHdXUmhxN3h2dGJNbWFFSXRL?=
 =?utf-8?B?a0NRdkkyaXdZbzFCQkQyVVJsM3RzdCt3dzd4NUprNUV1ZFBOaWlhUTNxNS9o?=
 =?utf-8?B?dmQxNzhHcUtUbGlnTkY0WmpXNGgwQW5tVEFCbElsMEkxMk1ZZVNCZHZQR0p3?=
 =?utf-8?B?R3B6Nk9iRFovNlhYKzhPL0RzUEExbE4ya0RDbGdyWktGUlZSOHJUa2JENlkx?=
 =?utf-8?B?RGRuSEkyOXhpQ3FtR08wRXN6cDR6Wmt0Qk9scUkwRmJFc2lpQm1iOW5ML0ZC?=
 =?utf-8?Q?CBBhZe17eMikBlEVIwoywaBJF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed926302-45c2-40f6-0d55-08db36b1f87e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 15:17:01.0572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE+GazRMoyoV++9sHeqKiTayN2MAuR8wp65oVJAU7l2ukpzNsc8NPD60I0zXUHd9s2HoVLdRiWqJM4vsvkREHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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

Am 2023-04-06 um 03:45 schrieb Shashank Sharma:
>
> On 05/04/2023 23:18, Luben Tuikov wrote: So, then why isn't Felix in 
> the Cc tags? Doorbell changes touch that area too.
>> He's actually the only one you left out, other than the MLs emails.
>> Either add everyone to the Cc tags in the commit message, or only add
>> your Sob line and leave everyone to a --cc= on the command line. Both 
>> are
>> common practice and acceptable.
>
> This code touches KFD code, and that's why Felix needs to be involved 
> in the code-review process. But
>
> once code review is done, I don't want to spam his email every time 
> this patch is pushed into some branch,
>
> so he is not in cover-letter CC. This is how I prefer to drive the 
> code review of this patch, and I don't see a problem here.

It's a big patch series, and I don't have time to review the whole thing 
in detail. A CC tag on the patches that need my attention would help.

Thanks,
   Felix


>
>
>>> Also, I would like to express that in my opinion we are spending way 
>>> too
>>> much time in discussing the 'preferences' around cover letter,
>> I agree. But those aren't "preferences," they are common practices,
>
> This is not a common practice, its your interpretation of it.
>
> I also picked a few examples:
>
>
> https://patchwork.freedesktop.org/patch/531143/?series=116163&rev=1
>
> This patch has multiple communities in Cc, none in cover-letter (also 
> R-B'ed by you).
>
>
> https://patchwork.freedesktop.org/patch/505571/
>
> https://patchwork.freedesktop.org/patch/442410/
>
> These are some of patches which has multiple people missing in the 
> cover-letter CC than email-CC.
>
>
> https://patchwork.freedesktop.org/patch/530652/?series=116055&rev=1
>
> This patch has multiple people in email-cc but none in cover-letter CC.
>
>
> There could be tons of such examples for both, and the maintainers do 
> not have any problem with that,
>
> So I don't consider this as common practice in DRM community, its just 
> a preference, and hence it consumed
>
> a lot more time and efforts in this discussion than what it should have.
>
> - Shashank
>
>> like for instance not separating the Cc tags and the Sob tags with
>> an empty line, or shifting struct member names to the same column
>> for readability, and so on. Use "git log -- drivers/gpu/drm".
>>
>> Regards,
>> Luben
>>
>>> words, comments and variable names. No cover letter is perfect, no
>>> commit message is good enough to explain what is happening in code,
>>>
>>> no variable name is flawless and no comment explains what is going 
>>> on in
>>> code which is clear to everyone. These are very subjective to the
>>>
>>> author and the reader. The only deciding factor is if there is a
>>> community rule/guideline on that.
>>>
>>>
>>> I appreciate your time and suggestions but I also certainly do not want
>>> to spend this much time to discuss how should we add people in Cc.
>>>
>>> Let's keep preferences separate from code review process.
>>>
>>> - Shashank
>>>
>>>> A good tool to use is "scripts/get_maintainer.pl" which works
>>>> on a file, directory and even patch files.
>>>>
>>>> I usually include everyone get_maintainer.pl prints, and on 
>>>> subsequent patch
>>>> revisions, also people who have previously commented on the 
>>>> patchset, as they
>>>> might be interested to follow up. It's a good thing to do.
>>>>
>>>> Here are a couple of resources, in addition to DRM commits in the 
>>>> tree,
>>>> https://www.kernel.org/doc/html/v4.12/process/5.Posting.html#patch-formatting-and-changelogs 
>>>>
>>>> https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#the-canonical-patch-format 
>>>>
>>>> (The second link includes links to more resources on good patch 
>>>> writing.)
>>>>
>>>> Hope this helps.
>>>>
>>>> Regards,
>>>> Luben
>>>>
>>>>
>>>>> - Shashank
>>>>>
>>>>>> Regards,
>>>>>> Luben
>>>>>>
>>>>>>> .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 70 
>>>>>>> +++++++++++++++++++
>>>>>>>     1 file changed, 70 insertions(+)
>>>>>>>
>>>>>>> diff --git 
>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>> index 39e90ea32fcb..1627641a4a4e 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>>>>>> @@ -23,12 +23,73 @@
>>>>>>>     #include "amdgpu.h"
>>>>>>>     #include "amdgpu_userqueue.h"
>>>>>>>     #include "v11_structs.h"
>>>>>>> +#include "amdgpu_mes.h"
>>>>>>>         #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>>>>>>     #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>>>>>>     #define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>>>>>>     #define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>>>>>>>     +static int
>>>>>>> +amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>> +                         struct amdgpu_usermode_queue *queue)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>> +    struct mes_add_queue_input queue_input;
>>>>>>> +    int r;
>>>>>>> +
>>>>>>> +    memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>>>>>>> +
>>>>>>> +    queue_input.process_va_start = 0;
>>>>>>> +    queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) 
>>>>>>> << AMDGPU_GPU_PAGE_SHIFT;
>>>>>>> +    queue_input.process_quantum = 100000; /* 10ms */
>>>>>>> +    queue_input.gang_quantum = 10000; /* 1ms */
>>>>>>> +    queue_input.paging = false;
>>>>>>> +
>>>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>>>> +    queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
>>>>>>> +    queue_input.inprocess_gang_priority = 
>>>>>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>>> +    queue_input.gang_global_priority_level = 
>>>>>>> AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>>> +
>>>>>>> +    queue_input.process_id = queue->vm->pasid;
>>>>>>> +    queue_input.queue_type = queue->queue_type;
>>>>>>> +    queue_input.mqd_addr = queue->mqd.gpu_addr;
>>>>>>> +    queue_input.wptr_addr = queue->userq_prop.wptr_gpu_addr;
>>>>>>> +    queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>>>>>> +    queue_input.doorbell_offset = 
>>>>>>> queue->userq_prop.doorbell_index;
>>>>>>> +    queue_input.page_table_base_addr = 
>>>>>>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>>>>>> +
>>>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>>>> +    r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
>>>>>>> +        return r;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    DRM_DEBUG_DRIVER("Queue %d mapped successfully\n", 
>>>>>>> queue->queue_id);
>>>>>>> +    return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void
>>>>>>> +amdgpu_userq_gfx_v11_unmap(struct amdgpu_userq_mgr *uq_mgr,
>>>>>>> +                           struct amdgpu_usermode_queue *queue)
>>>>>>> +{
>>>>>>> +    struct amdgpu_device *adev = uq_mgr->adev;
>>>>>>> +    struct mes_remove_queue_input queue_input;
>>>>>>> +    int r;
>>>>>>> +
>>>>>>> +    memset(&queue_input, 0x0, sizeof(struct 
>>>>>>> mes_remove_queue_input));
>>>>>>> +    queue_input.doorbell_offset = 
>>>>>>> queue->userq_prop.doorbell_index;
>>>>>>> +    queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
>>>>>>> +
>>>>>>> +    amdgpu_mes_lock(&adev->mes);
>>>>>>> +    r = adev->mes.funcs->remove_hw_queue(&adev->mes, 
>>>>>>> &queue_input);
>>>>>>> +    amdgpu_mes_unlock(&adev->mes);
>>>>>>> +    if (r)
>>>>>>> +        DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>>>>>>> +}
>>>>>>> +
>>>>>>>     static int amdgpu_userq_gfx_v11_create_ctx_space(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr,
>>>>>>> struct amdgpu_usermode_queue *queue)
>>>>>>>     {
>>>>>>> @@ -129,6 +190,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>>>>>>             amdgpu_userq_set_ctx_space(uq_mgr, queue);
>>>>>>>         amdgpu_bo_unreserve(mqd->obj);
>>>>>>> +
>>>>>>> +    /* Map the queue in HW using MES ring */
>>>>>>> +    r = amdgpu_userq_gfx_v11_map(uq_mgr, queue);
>>>>>>> +    if (r) {
>>>>>>> +        DRM_ERROR("Failed to map userqueue (%d)\n", r);
>>>>>>> +        goto free_ctx;
>>>>>>> +    }
>>>>>>> +
>>>>>>>         DRM_DEBUG_DRIVER("MQD for queue %d created\n", 
>>>>>>> queue->queue_id);
>>>>>>>         return 0;
>>>>>>>     @@ -147,6 +216,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct 
>>>>>>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>>>>>>     {
>>>>>>>         struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>>>>>>     +    amdgpu_userq_gfx_v11_unmap(uq_mgr, queue);
>>>>>>>         amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>>>>>>         amdgpu_bo_free_kernel(&mqd->obj,
>>>>>>>                    &mqd->gpu_addr,
