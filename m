Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71889C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 08:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FCA6F447;
	Wed,  1 Dec 2021 08:46:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C22436F417
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 08:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=echphW9eoUDA6AosP9oPAhr/ESKAJ2XFwOinGZM6yuWXMdnzVeO1j/u8PHOX9KzYgqUaP/im0FeF84BWJinafJGB5RWqkzwF/gN9aRb0E+5+O6mEEv3slJA58lE+QWRcWR2cSX8anhiymW96H4XZ2c0V+DRjHP0nI4UUeEd9Eu6ZE7O+/PWza20fY1HaSuZCyXQrFqpvygbnpq2oHNbATrwVWiD+Pxe6qEdaMJAyPyoiE0iGipT3MaQlrpwMGkrymHmBfMfU649yyz5B1fVBhY0Wp+9RIq+Ds/YMyhI/XD7mquu/uBlS5HLR14JzFGXkGQdqPjm2BHfdUiTQ2dXKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHmty1z/XeJrvV/JU6Siyk/1d2m4zeGGrjF9hm1OEc0=;
 b=TrMBn7HQnYnpQN6yAsFIzuj0q1x0h84LS2lN5VZDUqNFVqk6fzfjooK4yQrPL9zMIC+18xdStkL45CZr6Yh84rxxvYnOdLf4n2C6WGB43psD/OKBnaYieVcEo08CWxFd7lOOVUjP8pVPNY2gVDl+3ikCLUzbvK3TwQF3QLfUrlWw/PRIa3SxtTLnQ66uIVdMFDUGEpk/Jqpp/lBYLGA9ueYe9HNEU7r1SUuE0rXfEfBilG6Om+oSx2XiTFVvXgeK7+GVC00k1uErbQddxb7MyRjRFFWWXUVPn+F3nf+FgKvnJ4zigp4/2o9zmzbhlmBXK6V4DQk9rUFQeNu5wmVlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHmty1z/XeJrvV/JU6Siyk/1d2m4zeGGrjF9hm1OEc0=;
 b=HPXC0Ulz4gAljSYJrvep32q/WCY8t6hXPBrwAJ3++3hCq5+QNms4QFpeORnl+WuKdiu/nWDE//ibF+ocZiOsucD9PUR+kQgPrQcYhuZDhJh5wYiwSca1QnBogPIJnapK/L25isGk9KQyudWkjpkx1PJqGHHo8zjRtqC3kKP8ZM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1833.namprd12.prod.outlook.com (2603:10b6:3:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 08:46:31 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 08:46:30 +0000
Message-ID: <056d0882-1c15-fb4a-7d00-5ed66b8279fe@amd.com>
Date: Wed, 1 Dec 2021 14:16:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211130051721.3192979-1-lang.yu@amd.com>
 <53f6a9da-9197-3cfd-3d9c-586dbad4584c@amd.com>
 <DM6PR12MB39306D37D616E811E56A1E6297689@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB4250B9CF078EF70E804BCA1FFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <19b5cf3c-9ced-4abb-6d33-f5c4408a6e25@amd.com>
 <DM6PR12MB4250B223A492C9BB6B55C46AFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <891c0f73-4f2d-4cb2-b969-c68491362509@amd.com>
 <DM6PR12MB42503B4460809152535EA2B0FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <DM6PR12MB425030F971505ED3218D3A30FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB425030F971505ED3218D3A30FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::34) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0048.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24 via Frontend Transport; Wed, 1 Dec 2021 08:46:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cce84e6-a0be-496b-3a09-08d9b4a711df
X-MS-TrafficTypeDiagnostic: DM5PR12MB1833:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18339B4EB677C58842B5C8A697689@DM5PR12MB1833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4RsYiPeCNJFEdYcV8FDeLG0tqlkG7XFRGDWpgFvt12cqpX7oMtgMb9g4rO8FE0zkV+ywvNNo+P/zsYlq6sv2g/X+VPY0ZveDeGg9ABvWrRa8qK1xvJi2SF02mKgiddIrGPLKKjRHQeWxdiKplVY2lr8kpy02RQ8/QXbrCsAJAEWAQG1QywmFMWOLCFVc+ixBtuvfMT0tixTIqaMu43twnsGiNhY8vBTOQCgsjwOsx8B0+YHQI4xcrTZUVau3sT4lbPxXDP3/LWAw5cgRPqKXmA2H1a1kLMiORpGEDLFu/5cX45LhiVBPygbZP66IVXLlvRumRXsH2MJyInkqvoTZa/nc83JPpGo3RpbM1jkLV8fQ9SvVSrgDvBAN2R7+E4HbIFbkBfoMUI6NG7mR2nuYDBoJi0CscKy4bfZnjh3Wfmpb/Xe2+/SSKh+Lg4QW2FhEct7PKphsM5aVyrBUpTfkpxmJ2zNe+hzJek2kttuWTWtJLKmHIC+OvL/Tx9mTlSJQ6bmDa0vfMrnFyS3WraDCX0NdEedJS9vMIo2QpGijkZvGmFejWeHPXRt+lsyjedLtXyR8Kk7xHnEQyGeRpXajL7nBkAxgOUp5b8jP9AyHXsrYEcNQ2RRnKlT0qgTenswW8KcIzJ7J38CG2MZi7OW1TRNj5jrObvql2PKtueVQPCC+1O52OrvsKf9WzbMl7rbfE9j+joD4eN6tZMqmXR9VPOeml/lGJbDruhzP9KSQxesGncz644g48cz9gr1dyzc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(83380400001)(31686004)(4326008)(2906002)(6486002)(508600001)(36756003)(30864003)(6666004)(66476007)(66946007)(8676002)(8936002)(66556008)(316002)(86362001)(110136005)(54906003)(186003)(2616005)(16576012)(53546011)(5660300002)(26005)(38100700002)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVuaGRuMFAzckpYZTZpbXIyd0lPZXB4MGN1VzJjVzFoY2VJaTlFNkdVMkNH?=
 =?utf-8?B?U3FibVBYWmRDMEJnYmwwYlQxbDgxSGE3OWl1R2lCSTMzSWdZY1M5bXF1Uys4?=
 =?utf-8?B?VDROd0lXS0Q4NkFRY0lZS1FjMm0vREo2dGVRWWZtQWtRNzUvU1FUUHNuR0FC?=
 =?utf-8?B?RUo3YjkwbFdXT0Z5S0c1alZxV3M3OUg3SHF6T0NJRXE3WldPQTRFdVdHR3Iw?=
 =?utf-8?B?UGtlM1NLUjE4QU9wVWdINndLb3lqVUZqZndiMFB6WkNiMlUydUh2SVBIVUZB?=
 =?utf-8?B?ejIwS2hPQ1hORUUwenlQd3ZvcHZBaWc4aUdNa0FpSEFjVENHdytQbXliSUhH?=
 =?utf-8?B?YUZVdkpMRlFUUGcyMElsQzVNbXoyMHNmOStJdDVlYW9BdWlsbGR3U3g1cTFx?=
 =?utf-8?B?UElaN2VlMnRaRGFsdzVRcEJuSzJsbHRQWmt0aXo2ckEzV1pKc3FHNmV2V1V5?=
 =?utf-8?B?aXpMSnVxa0hocmpFUDRFUDRPUkFZblR4Vng4WjYwMUxnb2ZzczcrcjZSLzlB?=
 =?utf-8?B?T1ZlQVVZSktGUG5SSExBRXNrckZiWHBOcXllNkpOTkZCck52TktDMEJIWmpW?=
 =?utf-8?B?RzdoeTErN0toTE9Oa3B3OHo4MDNQald6RlY5ZXJWWmEwZ2xPNk81RzFSaEJx?=
 =?utf-8?B?V0xBSFVxMFdKdlc2Q2V1ZittTytMeDRFRWcvWG9oUGtLYjF0d2czMGxmaTdU?=
 =?utf-8?B?SVdFRkY2VHE4RXArM25YNkpVREY4YVdjbW0yaW5YdFh6ZlFwSXpWOEJPUU96?=
 =?utf-8?B?ZWVtYzlGaE9CeDZlUFdGNEVibFh6QVB4Y3pPWDRLRkpxR3ZnUWJBNmU4VTZK?=
 =?utf-8?B?WGtVL2txTkdnVVFNcXc5ci8xS09RcklkZGhpVktoNnYvSlo2cGs2SFRheFU2?=
 =?utf-8?B?Ty9uazNEZGlBWXhaUll5blZXQzZTMWR3bmtnVTlqYVFrYVhwL0JpVkVXMFBm?=
 =?utf-8?B?WE9hVmhUbklyTklWY1NPNjBqd1NpL2VWMmZvYkU5ZVF4aEZRZHNyRXVGZ2pB?=
 =?utf-8?B?UzIrQTBwaHh5RGdKQlhXQzM2RXhZYzdua09sQVBVaC9UNmNrYjZVYUVvMmcz?=
 =?utf-8?B?ODhRaDFJM1QzNWlQVTB3SS92ME0zWVJvQzBGT0RlS3JCcGtMVDUwbVlDb2t2?=
 =?utf-8?B?ZGRvK2kvRVg0RFdDZkY1bjJlTmFvT2FzelVRVDdEVWpuMEU4T0svRXhQSGIz?=
 =?utf-8?B?SEdIOGJNMlFWcUpLUzdrRFFNL0dLdEdxcDI2YjNjMlArcXBJZ2hqTGRhZ2xm?=
 =?utf-8?B?SmxmQzdueDBNeENuTjlHVTl6SERSOWsvRVVtaVZZMjZxbE9TeStKVkJlSXpu?=
 =?utf-8?B?QWlXeXBhMGsvKzJkSGs4TmMreTZqa1RaSlozQTZ2Vi9BMEtRVFQxREdRWUIz?=
 =?utf-8?B?anlhOUdzS3JONmxFblk4SmVaSVJKemJsWkNZeDI0L0s5bC8wWDZVYVZxL2lh?=
 =?utf-8?B?akZNQjNCWXgrY3Y5SXR0dkgrK3p5bS83U0tzclM1K2ZvWkorcWlBMzNYNlJC?=
 =?utf-8?B?S0s0akJ4eTh0bG5tdXpGcjlZZnU0RkxhNERhSm5jb2I3dG45Q0xWME5RQ2k2?=
 =?utf-8?B?cnB4Z1ljcDBZZy9XY2pHSFgzVnQzdHR6ZkxHbEVtZkF3TyttQ3lsWTFPS1RU?=
 =?utf-8?B?Q1ZZQ3ZaYm9NM1hNaFVEWE9yd2I2d1JndkF1WFhCczMzditrM1pMSmpiV1Bh?=
 =?utf-8?B?UHF1VUxWaTdzdXdZdW13c2JXUEZidy8xYVhXd3E3bEJoNG5JdGw4Nk5qeWV1?=
 =?utf-8?B?anE5TERSTktJNS92dnpxZkc0WFBCN2h2R3I1Y2NEWkxwMDFuUzZOcVVIWk9r?=
 =?utf-8?B?WmxINWJ6VDlpZXlEZjVsb1VoSXhKL3FDVmhiVW9vS3E1a28rRUljbkc1TkI4?=
 =?utf-8?B?dXp3Z3d5YzZ1T0RrUllVa1NmRFI0QUpJdnozZVoyYnptVkQrQ2JnK3NTeXhI?=
 =?utf-8?B?UTZ0VEtDYlJFN1k4V3R4UkdFWUhIRXZVM1M1bGlTM0d6eHR0Y1ZjYW4vMnlm?=
 =?utf-8?B?c1djVDE3RSszS29xZUc3aTBoVTVsYnhTZThLNnVGUHlsdExUZUVJck1xMldr?=
 =?utf-8?B?ZTQxSy9VcEhORkYyMEw1VnFDclYzaENoVUtPNmRIREdFb3RTdFRSNHB5ZzIv?=
 =?utf-8?Q?95/U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cce84e6-a0be-496b-3a09-08d9b4a711df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:46:30.7612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+U+hJBglm7yZynmyP+FWMGsk/KHe/HNvSGdVDTbIT2kRIdLCnpBZOXYHzwCXeJt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1833
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/1/2021 1:48 PM, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yu, Lang
>> Sent: Wednesday, December 1, 2021 3:58 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: add SMU debug option support
>>
>> [AMD Official Use Only]
>>
>>
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Wednesday, December 1, 2021 3:28 PM
>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
>>>
>>>
>>>
>>> On 12/1/2021 12:37 PM, Yu, Lang wrote:
>>>> [AMD Official Use Only]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Wednesday, December 1, 2021 2:56 PM
>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
>>>>>
>>>>>
>>>>>
>>>>> On 12/1/2021 11:57 AM, Yu, Lang wrote:
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>> Hi Lijo,
>>>>>>
>>>>>> Thanks for your comments.
>>>>>>
>>>>>>    From my understanding, that just increases the timeout threshold
>>>>>> and could hide some potential issues which should be exposed and solved.
>>>>>>
>>>>>> If current timeout threshold is not enough for some corner cases,
>>>>>> (1) Do we consider to increase the threshold to cover these cases?
>>>>>> (2) Or do we just expose them and request SMU FW to optimize them?
>>>>>>
>>>>>> I think it doesn't make much sense to increase the threshold in debug mode.
>>>>>> How do you think? Thanks!
>>>>>
>>>>> In normal cases, 2secs would be more than enough. If we hang
>>>>> immediately, then check the FW registers later, the response would
>>>>> have come. I thought we just need to note those cases and not to
>>>>> fail everytime. Just to mark as a red flag in the log to tell us
>>>>> that FW is unexpectedly busy processing something else when the message is
>> sent.
>>>>>
>>>>> There are some issues related to S0ix where we see the FW comes back
>>>>> with a response with an increased timeout under certain conditions.
>>>>
>>>> If these issues still exists, could we just blacklist the tests that
>>>> triggered them before solve them? Or we just increase the threshold
>>>> to cover
>>> all the cases?
>>>>
>>>
>>> Actually, the timeout is message specific - like i2c transfer from
>>> EEPROM could take longer time.
>>>
>>> I am not sure if we should have more than 2s as timeout. Whenever this
>>> kind of issue happens, FW team check registers (then it will have a
>>> proper value) and say they don't see anything abnormal :) Usually,
>>> those are just signs of crack and it eventually breaks.
>>>
>>> Option is just fail immediately (then again not sure useful it will be
>>> if the issue is this sort of thing) or wait to see how far it goes with
>>> an added timeout before it fails eventually.
>>
>> Are smu_cmn_wait_for_response()/smu_cmn_send_msg_without_waiting()
>> designed for long timeout cases? Is it fine that we don't fail here in the event of
>> timeout?
> 
> Or we can add a timeout parameter into smu_cmn_send_smc_msg_with_param()
> to specify the timeout you want for specific message.
> I think this may be another story. Thanks!
>

Yes, that will be a different patch. For now, skip the extended timeout. 
Every timeout will trigger a debug alarm and let it be that way for 
debug mode. I think you can skip the retry also (originally I meant this 
by that comment - retry again for response reg check).

Thanks,
Lijo

> Thanks,
> Lang
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Lang
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Lang
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> Sent: Wednesday, December 1, 2021 1:44 PM
>>>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Yu, Lang <Lang.Yu@amd.com>;
>>>>>>> amd- gfx@lists.freedesktop.org
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>> Subject: RE: [PATCH] drm/amdgpu: add SMU debug option support
>>>>>>>
>>>>>>> Just realized that the patch I pasted won't work. Outer loop exit
>>>>>>> needs to be like this.
>>>>>>> 	(reg & MP1_C2PMSG_90__CONTENT_MASK) != 0 && extended_wait-- >=
>>>>>>> 0
>>>>>>>
>>>>>>> Anyway, that patch is only there to communicate what I really
>>>>>>> meant in the earlier comment.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>>>>> Lazar, Lijo
>>>>>>> Sent: Wednesday, December 1, 2021 10:44 AM
>>>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 11/30/2021 10:47 AM, Lang Yu wrote:
>>>>>>>> To maintain system error state when SMU errors occurred, which
>>>>>>>> will aid in debugging SMU firmware issues, add SMU debug option
>> support.
>>>>>>>>
>>>>>>>> It can be enabled or disabled via amdgpu_smu_debug debugfs file.
>>>>>>>> When enabled, it makes SMU errors fatal.
>>>>>>>> It is disabled by default.
>>>>>>>>
>>>>>>>> == Command Guide ==
>>>>>>>>
>>>>>>>> 1, enable SMU debug option
>>>>>>>>
>>>>>>>>      # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>>>>
>>>>>>>> 2, disable SMU debug option
>>>>>>>>
>>>>>>>>      # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>>>>
>>>>>>>> v2:
>>>>>>>>      - Resend command when timeout.(Lijo)
>>>>>>>>      - Use debugfs file instead of module parameter.
>>>>>>>>
>>>>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 32
>>>>> +++++++++++++++++
>>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 39
>>>>> +++++++++++++++++++-
>>>>>>> -
>>>>>>>>      2 files changed, 69 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> index 164d6a9e9fbb..f9412de86599 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>>>>> @@ -39,6 +39,8 @@
>>>>>>>>
>>>>>>>>      #if defined(CONFIG_DEBUG_FS)
>>>>>>>>
>>>>>>>> +extern int amdgpu_smu_debug;
>>>>>>>> +
>>>>>>>>      /**
>>>>>>>>       * amdgpu_debugfs_process_reg_op - Handle MMIO register
>>> reads/writes
>>>>>>>>       *
>>>>>>>> @@ -1152,6 +1154,8 @@ static ssize_t
>>>>>>>> amdgpu_debugfs_gfxoff_read(struct
>>>>>>> file *f, char __user *buf,
>>>>>>>>      	return result;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +
>>>>>>>> +
>>>>>>>>      static const struct file_operations amdgpu_debugfs_regs2_fops = {
>>>>>>>>      	.owner = THIS_MODULE,
>>>>>>>>      	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl, @@ -1609,6
>>>>>>>> +1613,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>>>>>      DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>>>>      			amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>>>>
>>>>>>>> +static int amdgpu_debugfs_smu_debug_get(void *data, u64 *val) {
>>>>>>>> +	*val = amdgpu_smu_debug;
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int amdgpu_debugfs_smu_debug_set(void *data, u64 val) {
>>>>>>>> +	if (val != 0 && val != 1)
>>>>>>>> +		return -EINVAL;
>>>>>>>> +
>>>>>>>> +	amdgpu_smu_debug = val;
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_smu_debug,
>>>>>>>> +			 amdgpu_debugfs_smu_debug_get,
>>>>>>>> +			 amdgpu_debugfs_smu_debug_set,
>>>>>>>> +			 "%llu\n");
>>>>>>>> +
>>>>>>>>      int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>>>>      {
>>>>>>>>      	struct dentry *root =
>>>>>>>> adev_to_drm(adev)->primary->debugfs_root;
>>>>>>>> @@ -1632,6 +1656,14 @@ int amdgpu_debugfs_init(struct
>>>>>>>> amdgpu_device
>>>>>>> *adev)
>>>>>>>>      		return PTR_ERR(ent);
>>>>>>>>      	}
>>>>>>>>
>>>>>>>> +	ent = debugfs_create_file("amdgpu_smu_debug", 0600, root,
>> adev,
>>>>>>>> +				  &fops_smu_debug);
>>>>>>>> +	if (IS_ERR(ent)) {
>>>>>>>> +		DRM_ERROR("unable to create amdgpu_smu_debug
>> debugsfs
>>>>>>> file\n");
>>>>>>>> +		return PTR_ERR(ent);
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +
>>>>>>>>      	/* Register debugfs entries for amdgpu_ttm */
>>>>>>>>      	amdgpu_ttm_debugfs_init(adev);
>>>>>>>>      	amdgpu_debugfs_pm_init(adev); diff --git
>>>>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>> index 048ca1673863..b3969d7933d3 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>>> @@ -55,6 +55,14 @@
>>>>>>>>
>>>>>>>>      #undef __SMU_DUMMY_MAP
>>>>>>>>      #define __SMU_DUMMY_MAP(type)	#type
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>> + * Used to enable SMU debug option. When enabled, it makes SMU
>>>>>>>> +errors
>>>>>>> fatal.
>>>>>>>> + * This will aid in debugging SMU firmware issues.
>>>>>>>> + * (0 = disabled (default), 1 = enabled)  */ int
>>>>>>>> + amdgpu_smu_debug;
>>>>>>>> +
>>>>>>>>      static const char * const __smu_message_names[] = {
>>>>>>>>      	SMU_MESSAGE_TYPES
>>>>>>>>      };
>>>>>>>> @@ -272,6 +280,11 @@ int smu_cmn_send_msg_without_waiting(struct
>>>>>>> smu_context *smu,
>>>>>>>>      	__smu_cmn_send_msg(smu, msg_index, param);
>>>>>>>>      	res = 0;
>>>>>>>>      Out:
>>>>>>>> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
>>>>>>>> +		mutex_unlock(&smu->message_lock);
>>>>>>>> +		BUG();
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>>      	return res;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> @@ -288,9 +301,17 @@ int smu_cmn_send_msg_without_waiting(struct
>>>>>>> smu_context *smu,
>>>>>>>>      int smu_cmn_wait_for_response(struct smu_context *smu)
>>>>>>>>      {
>>>>>>>>      	u32 reg;
>>>>>>>> +	int res;
>>>>>>>>
>>>>>>>>      	reg = __smu_cmn_poll_stat(smu);
>>>>>>>> -	return __smu_cmn_reg2errno(smu, reg);
>>>>>>>> +	res = __smu_cmn_reg2errno(smu, reg);
>>>>>>>> +
>>>>>>>> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
>>>>>>>> +		mutex_unlock(&smu->message_lock);
>>>>>>>> +		BUG();
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	return res;
>>>>>>>>      }
>>>>>>>>
>>>>>>>>      /**
>>>>>>>> @@ -328,6 +349,7 @@ int smu_cmn_send_smc_msg_with_param(struct
>>>>>>> smu_context *smu,
>>>>>>>>      				    uint32_t param,
>>>>>>>>      				    uint32_t *read_arg)
>>>>>>>>      {
>>>>>>>> +	int retry_count = 0;
>>>>>>>>      	int res, index;
>>>>>>>>      	u32 reg;
>>>>>>>>
>>>>>>>> @@ -349,15 +371,28 @@ int
>>> smu_cmn_send_smc_msg_with_param(struct
>>>>>>> smu_context *smu,
>>>>>>>>      		__smu_cmn_reg_print_error(smu, reg, index, param,
>>> msg);
>>>>>>>>      		goto Out;
>>>>>>>>      	}
>>>>>>>> +retry:
>>>>>>>>      	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>>>>>>      	reg = __smu_cmn_poll_stat(smu);
>>>>>>>>      	res = __smu_cmn_reg2errno(smu, reg);
>>>>>>>> -	if (res != 0)
>>>>>>>> +	if (res != 0) {
>>>>>>>>      		__smu_cmn_reg_print_error(smu, reg, index, param,
>>> msg);
>>>>>>>> +		if ((res == -ETIME) && (retry_count++ < 1)) {
>>>>>>>> +			usleep_range(500, 1000);
>>>>>>>> +			dev_err(smu->adev->dev,
>>>>>>>> +				"SMU: resend command: index:%d
>>>>>>> param:0x%08X message:%s",
>>>>>>>> +				index, param,
>> smu_get_message_name(smu,
>>>>>>> msg));
>>>>>>>> +			goto retry;
>>>>>>>> +		}
>>>>>>>> +		goto Out;
>>>>>>>> +	}
>>>>>>>
>>>>>>> Sorry, what I meant is to have an extended wait time in debug mode.
>>>>>>> Something like below, not a 'full retry' as in sending the message again.
>>>>>>>
>>>>>>>
>>>>>>> +#define MAX_DBG_WAIT_CNT 3
>>>>>>> +
>>>>>>>     /**
>>>>>>>      * __smu_cmn_poll_stat -- poll for a status from the SMU
>>>>>>>      * smu: a pointer to SMU context @@ -115,17 +117,24 @@ static
>>>>>>> void smu_cmn_read_arg(struct smu_context *smu,
>>>>>>>     static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>>>>>>     {
>>>>>>>            struct amdgpu_device *adev = smu->adev;
>>>>>>> -       int timeout = adev->usec_timeout * 20;
>>>>>>> +       int timeout;
>>>>>>>            u32 reg;
>>>>>>> +       int extended_wait = smu_debug_mode ? MAX_DBG_WAIT_CNT : 0;
>>>>>>>
>>>>>>> -       for ( ; timeout > 0; timeout--) {
>>>>>>> -               reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>>>>> -               if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>>>>> -                       break;
>>>>>>> +       do {
>>>>>>> +               timeout = adev->usec_timeout * 20;
>>>>>>> +               for (; timeout > 0; timeout--) {
>>>>>>> +                       reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>>>>> +                       if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>>>>> +                               break;
>>>>>>>
>>>>>>> -               udelay(1);
>>>>>>> -       }
>>>>>>> +                       udelay(1);
>>>>>>> +               }
>>>>>>> +       } while (extended_wait-- >= 0);
>>>>>>>
>>>>>>> +       if (extended_wait != MAX_DBG_WAIT_CNT && reg !=
>>> SMU_RESP_NONE)
>>>>>>> +               dev_err(adev->dev,
>>>>>>> +                       "SMU: Unexpected extended wait for
>>>>>>> + response");
>>>>>>>            return reg;
>>>>>>>     }
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>      	if (read_arg)
>>>>>>>>      		smu_cmn_read_arg(smu, read_arg);
>>>>>>>>      Out:
>>>>>>>>      	mutex_unlock(&smu->message_lock);
>>>>>>>> +
>>>>>>>> +	BUG_ON(unlikely(amdgpu_smu_debug == 1) && res);
>>>>>>>> +
>>>>>>>>      	return res;
>>>>>>>>      }
>>>>>>>>
>>>>>>>>
