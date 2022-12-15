Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A137C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 08:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7547D10E4F4;
	Thu, 15 Dec 2022 08:09:37 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9951610E4F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 08:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSpABJ/BGoTLdAborsdqZ/5TE9FyTEZBpgnXaVYFTRLo1Wu1n2ypJ383cWETD3zifjJiVq/lLGnRj1+Ce4sea/4/E48PcnRRDlYTxx+DffyvTmq9ThaMSsSPyH4d1V8A0mB78XnbED86zKCEWgmbtdRO2QO/HuR9RuazeBa3L1lefaKoTRQ3x1aj3PyFPQGs+YyvLBuYHeBFy5mMr2VmOyv1eBvyFJmp3Thf9KZDh2IoC4zc+9Y9IdeKQlsbqA/v5II3Gtrne3FHtKlpttOsTKUYrlt0eZpjh4/18LDjlx7RlGZtTAJFvWefJClpvbc1zyLaypf7ZBn7x4dsQ/YJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0I6i3YQKTV+2Cb2GFXtH3NIHLNat9hKScQ72XD89ig=;
 b=RyrKpEVtDC5/OAvGouMjE8eePwv8G+V/0Ep26JN9bkaDOt5oBUIs6NK8c9oy10LvUmW6Pxa/+K5IDtKCyYXRcb8adKcY4sOg+j3q7BLu/ea69RGJm+GSQx3cDpiNYWmKuarg7/zOzN3yqz0GFrqaNnMvui0n6JEbmOUfbznhH1HemYUw0rBuESsK007A0uPZeCYbCpjpdmkHg62odbz3AVINZjbBqZNdngdF+1XiUz0Dc8/WbAYARoxoMb9+BtLxVQB/g3qMESFvyN+IT9nILmTZw0o3Td4aROiGgsqr2nmhRXMRAFYDJUrBFmk/Dlaoq82yzTNyfumrZqCF70AUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0I6i3YQKTV+2Cb2GFXtH3NIHLNat9hKScQ72XD89ig=;
 b=ji7kEOTTZS6xJcxDBTF7Q2qK129lVYw+xWSkmEPYnWsHE7W0gDw7gLuhbRre43B/TsT41rHMtI8TIHNhcrc64Ut2vZubita4jh2CUkk6yX05XHiJUogJuN+TDQGxay7RdlbsF6VRff682Q9oxxz7dyPtsRvYvBHWBasZ+wZuEfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 08:09:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 08:09:30 +0000
Message-ID: <e2337d02-594e-9c69-d8a4-b046fc9c221f@amd.com>
Date: Thu, 15 Dec 2022 09:09:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
 <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
 <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
 <CADnq5_Pz=JDUaGW3HE17sL0rnkOB9KSVKeNc5u5zn-8QNTNPrQ@mail.gmail.com>
 <7a976873-033c-461e-c6de-4df01051ec24@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <7a976873-033c-461e-c6de-4df01051ec24@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfb3b12-17f3-467f-6f45-08dade73b119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9EOR+gWkNlM83RCLuXG8Nvj+3bU6shF1g2Ch0VtUwJdEmQgSrUogG6lGiYvqP3JMGxL7oID8sbE8KWc1+tVvrSfpR0pgz0m9aBQRJGkGibc+/lTy/zVZ23TYcb5asgw8Yg5bX6+QozFO3hNsl7rWPB3DEUGWYU1/Sn6O/Ab36z2E2K9jhrsL3FPdswzkJ22Z6WpT+UdRzQ5EFDmmN6IzTXZI4YWQrJYMkjeqn15RT/00sbqQV+O26T5eZVYIVhIlJr0a6T5rc5+HiA8XERo7svSZ6xwN+N4+nYpo+07koeD4rNVHR0nNwmyT78qv8m0aJMq3xZ3BXw4nYU0OC8I58D1ukkRYUWjQZuulDDw3PFPU+7pOyybQUXqolKvs2ChDkYNttxLySl/5kambTWh4SS71Pq5Lqad/P6L0eTbwL/qzALf19i9lCx2efhxrKkTsFsP2Cr+kA8xTUh6DiYkCwgQ0GeSr8iw6PqVdZRotE8Bng0/Y/pziq+a2T93AiGuS1XnuDki9vFRK8pCA6IxBKowwKnHKozu4h2ifqLu1sbM23syQTQ+xuv/noUcF0NZjxkj1bljbKNL2KXYs6ipG0OwlPZG5hiQDGuc+sxNd80pxFgj8uBuTzId1F8QHwZdMQaAEtVrIDb5oTRNqmALt6E15sMj0YylN5QnSZOM1xreP3yrIis8WGmPjINrrWky
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(83380400001)(31696002)(86362001)(38100700002)(2906002)(4001150100001)(5660300002)(41300700001)(8936002)(4326008)(53546011)(6506007)(6666004)(186003)(26005)(2616005)(6512007)(316002)(66946007)(66476007)(66556008)(8676002)(31686004)(6486002)(110136005)(45080400002)(478600001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2h3cUtMbU90QWRISm8vZnQ3QjhxQjQzUUJNV2cyRHhJQ0Z5Z2NRc1lvelg2?=
 =?utf-8?B?UElJamI5NUdaYXd5R1RhM1ZrckR4NElpUUl4MW95TGlVSzhBd3R0V1Y4S2ZV?=
 =?utf-8?B?aGZOVnpRaHVsdnlDT3IrWUxLLzhqQ2dZSXllUVRheE81ZExMSkRnR1VzeUZy?=
 =?utf-8?B?b2FRQ3RSVENydE9KWjVuL3FHbGptMnNrY0tVY3cwb3JuSm54TlNmL3Q4VVBN?=
 =?utf-8?B?TzNpdFRRRC9XOU1sWDQyTzlWTFVFM0tUVmorRTg5L0loYnlWV01UUU9qSCtO?=
 =?utf-8?B?T0JwMTBURHN4NVczRy9qVHRKR0RPV0VBSHo3TEwvK2x5UDE0MDNFUFhRN1NN?=
 =?utf-8?B?bG5yZ3BMdG8ybVdNOFlTR0NKcGJQM2MrUmp4d1g1RnNaSkdIb1MrQk45Q3Zi?=
 =?utf-8?B?Y29HdC9JSklrSWUyTXlYb1JSbGp1TDB4QmZaZ1ZOWnZBc2F0OVBabjJDcnNp?=
 =?utf-8?B?MzlWWXdTbEpPbEdtVForWEVCMU5zTWdYMlVBQld2NU5TNGRVVEpKZXVmaG8x?=
 =?utf-8?B?SUppRkl4ckF1eC8wWTN1Njg5aVMwcGJaQ0l3WEU0dTJoTHRhb1lmeDBYTVdv?=
 =?utf-8?B?L1F1bmVsUmhYL1JKVnhnZURlSUlwNzlzWUwzNkJlMzhaSjRFdXZJNVFIdm51?=
 =?utf-8?B?UitJL0RKSGl3OGoza3VDdGpUckpuUnRPN2s5Mk1GM3RVWUhnRmtBMWxLdkNk?=
 =?utf-8?B?czJHTVA3cWtRSG53eU00d0hjRkc2WHdkRHE1WGVJMXlLS0lSS2dpaTBOd3RZ?=
 =?utf-8?B?YzA4VjZvWDJXN3VvTERJYmQzSEFsWEswa3AyMXpCdHZSbTJQejF1ZTBvRXlX?=
 =?utf-8?B?S2ZyR1gzb2F1bnczWHVjRHc3ZVF2ZnIrRUEvWnh6VGZUYmpMYWRxbEUwS2d4?=
 =?utf-8?B?MTl0c0FsLzBTMlZYTGZGWGNRL00xdU54TCtXZTNJbk9uSHJ0d1ZaalQ1c1l4?=
 =?utf-8?B?VE5ZakVoTlpRZzFzenlHcURtRVRHV3EvWjA4WXpaaElhZS9QSDhNb2JqN0hO?=
 =?utf-8?B?eGVrYTEybi9tZEkxcWpqMFRmZGNjcjRJa3Rvem5GQVRZNHpydWF4dzJwa1Vk?=
 =?utf-8?B?UWY4eWtqb0R5aDArdjNSREdkRjd5cVhzUXRhenJ3dVNqYyttdzFYbTdQM05i?=
 =?utf-8?B?Rkh6bjl2dElhNmVwdkk4ZlE4NDRwVEp6bVhSMTRKYW1BVXhzUnpha3VmaFpa?=
 =?utf-8?B?clZmdUF1aFFyVW5QMDNjekQ3R2tpekpXWFhIbXczUEdlK0JaSzhUTHY1bERm?=
 =?utf-8?B?SzYxdmthRFZWUHExOEpkNU0veWRyd3dZOWJ1VWJHMDNwalh6bHhZRFRMNllz?=
 =?utf-8?B?QWl5OTFPM2t4cTMwbDNURDNCaDdlK0ZFaXQvWkZxM0tYU1ZuL3NSczFCSDBr?=
 =?utf-8?B?VFl6bE5HTUFkSXZyaG9yb25QTUhRQmtKMms3bjUrbHp2dWhXeHRMbUtvQm0v?=
 =?utf-8?B?eHppR2JnMTNlRFJEZWxaOWU1WWZVWGk5T3crL2czdDRVUDhHMk96SzY5WHRr?=
 =?utf-8?B?RzRDb0RDTGdCeHVoYjNPcnBpMG1LVy9JVThzdUdIdE9OaEJwWk5lYXY5a2dP?=
 =?utf-8?B?VHpFbkRsYlZ2MTdRc1NJSk9pRSs1aXJsT2VpMU8vTE4rUVpWaXFSYk9rU2lM?=
 =?utf-8?B?eFdTRXdCVURHaWpDMkcrTW5hN1dtS2RFSjJOdEtrMVU4M05wWEx5ZlFnL2h3?=
 =?utf-8?B?N1lZQU1XZXRIcndIRitsRkFnZmdvc2Q0R25mMThyUDltOG15UHU3c1Jydmta?=
 =?utf-8?B?U0xwdEU0WXBUVklzTENHRXR5WnFlRjZEQThzM2Fqc1BLd3pMSzIwbFViSU9Y?=
 =?utf-8?B?OU5SMmJjRkdzZmluY1I2NTIxYTJrdFl3OUV3LzduYloyTEpXa0VrUHlBcU5z?=
 =?utf-8?B?anR5YXUrZTVvRjlSS2N1eGJWMFF2MkZEZVpMcEM3QnY1V05FWFBOblhLSHdn?=
 =?utf-8?B?OEdpUGdkWW5xSGFpUFdQV0pFeXBaUzBGbk8veWNrRzJxVW4xSi9hVThkY09m?=
 =?utf-8?B?Y1Zsbk9ONTByOVZXQU4zeGY3VVcxRUJDdWl6NVFBeVBzd3hiYmZhQVlxQjF4?=
 =?utf-8?B?djJkU0VaUC9YYlpNcGNkV2VLcUpzL2JBNGtLMzc2dUc4dUh6SHFMZTlza2tJ?=
 =?utf-8?Q?sqqqc+olTdtaCSsFDvdH8XgFS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfb3b12-17f3-467f-6f45-08dade73b119
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 08:09:30.3154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+NGfpAx98YCQ8twtqULcY+NwlSf3faBin4ANo0dHHsKaCLP3JZndFG4ejXGyT76
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.12.22 um 00:33 schrieb Alex Hung:
>
>
> On 2022-12-14 16:06, Alex Deucher wrote:
>> On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <alex.hung@amd.com> wrote:
>>>
>>>
>>>
>>> On 2022-12-14 15:35, Alex Deucher wrote:
>>>> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2022-12-14 14:54, Alex Deucher wrote:
>>>>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>>>>> <aurabindo.pillai@amd.com> wrote:
>>>>>>>>>
>>>>>>>>> From: Alex Hung <alex.hung@amd.com>
>>>>>>>>>
>>>>>>>>> [Why]
>>>>>>>>> When running IGT kms_bw test with DP monitor, some systems 
>>>>>>>>> crash from
>>>>>>>>> msleep no matter how long or short the time is.
>>>>>>>>>
>>>>>>>>> [How]
>>>>>>>>> To replace msleep with mdelay.
>>>>>>>>
>>>>>>>> Can you provide a bit more info about the crash?  A lot of 
>>>>>>>> platforms
>>>>>>>> don't support delay larger than 2-4ms so this change will generate
>>>>>>>> errors on ARM and possibly other platforms.
>>>>>>>>
>>>>>>>> Alex
>>>>>>>
>>>>>>> The msleep was introduced in eec3303de3378 for non-compliant 
>>>>>>> display
>>>>>>> port monitors but IGT's kms_bw test can cause a recent h/w to 
>>>>>>> hang at
>>>>>>> msleep(60) when calling "igt_remove_fb" in IGT
>>>>>>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Figt-gpu-tools%2F-%2Fblob%2Fmaster%2Ftests%2Fkms_bw.c%23L197&amp;data=05%7C01%7Calex.hung%40amd.com%7C81664450189542a7bbc408dade27d0e9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638066559844526853%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=M%2BF4H2qddXItPoUZRVyhlc5N8UF1%2FHIh8PpfT%2BCmdZ4%3D&amp;reserved=0) 
>>>>>>>
>>>>>>>
>>>>>>> It is possible to workaround this by reversing order of
>>>>>>> igt_remove_fb(&buffer[i]), as the following example:
>>>>>>>
>>>>>>>       igt_create_color_fb with the order buffer[0], buffer[1], 
>>>>>>> buffer[2]
>>>>>>>
>>>>>>> Hangs:
>>>>>>>       igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>>
>>>>>>> No hangs:
>>>>>>>       igt_remove_fb with the reversed order buffer[2], 
>>>>>>> buffer[1], buffer[0]
>>>>>>>
>>>>>>> However, IGT simply exposes the problem and it makes more sense 
>>>>>>> to stop
>>>>>>> the hang from occurring.
>>>>>>>
>>>>>>> I also tried to remove the msleep completely and it also work, 
>>>>>>> but I
>>>>>>> didn't want to break the fix for the original problematic hardware
>>>>>>> configuration.
>>>>>>
>>>>>> Why does sleep vs delay make a difference?  Is there some race 
>>>>>> that we
>>>>>> are not locking against?
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>
>>>>> That was my original thought but I did not find any previously. I 
>>>>> will
>>>>> investigate it again.
>>>>>
>>>>> If mdelay(>4) isn't usable on other platforms, is it an option to use
>>>>> mdelay on x86_64 only and keep msleep on other platforms or just 
>>>>> remove
>>>>> the msleep for other platforms, something like
>>>>>
>>>>> -                       msleep(60);
>>>>> +#ifdef CONFIG_X86_64
>>>>> +                       mdelay(60);
>>>>> +#endif
>>>>
>>>> That's pretty ugly.  I'd rather try and resolve the root cause.  How
>>>> important is the IGT test?  What does it do?  Is the test itself
>>>> correct?
>>>>
>>>
>>> Agreed, and I didn't want to add conditions around the mdelay for the
>>> same reason. I will assume this is not an option now.
>>>
>>> As in the previous comment, IGT can be modified to avoid the crash by
>>> reversing the order fb is removed - though I suspect I will receive
>>> questions why this is not fixed in kernel.
>>>
>>> I wanted to fix this in kernel because nothing stops other user-space
>>> applications to use the same way to crash kernel, so fixing IGT is the
>>> second option.
>>>
>>> Apparently causing problems on other platforms isn't an option at 
>>> all so
>>> I will try to figure out an non-mdelay solution, and then maybe an IGT
>>> solution instead.
>>>
>>
>> What hangs?  The test or the kernel or the hardware?
>
> The system becomes completely unresponsive - no keyboard, mouse nor 
> remote accesses.

I agree with Alex that changing this is extremely questionable and not 
justified at all.

My educated guess is that by using mdelay() instead of msleep() we keep 
the CPU core busy and preventing something from happening at the same 
time as something else.

This clearly points to missing locking or similar to protect concurrent 
execution of things.

Christian.

>
>>
>> Alex
>>
>>
>>>> Alex
>>>>
>>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>>>>>>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>>>>>>>>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>>>>>>> ---
>>>>>>>>> drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 
>>>>>>>>> 2 +-
>>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git 
>>>>>>>>> a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c 
>>>>>>>>> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>>>>> index 913a1fe6b3da..e6251ccadb70 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>>>>> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx 
>>>>>>>>> *pipe_ctx)
>>>>>>>>>                              * After output is idle pattern 
>>>>>>>>> some sinks need time to recognize the stream
>>>>>>>>>                              * has changed or they enter 
>>>>>>>>> protection state and hang.
>>>>>>>>>                              */
>>>>>>>>> -                       msleep(60);
>>>>>>>>> +                       mdelay(60);
>>>>>>>>>                     } else if (pipe_ctx->stream->signal == 
>>>>>>>>> SIGNAL_TYPE_EDP) {
>>>>>>>>>                             if 
>>>>>>>>> (!link->dc->config.edp_no_power_sequencing) {
>>>>>>>>>                                     /*
>>>>>>>>> -- 
>>>>>>>>> 2.39.0
>>>>>>>>>

