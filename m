Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FECEC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C36410E082;
	Wed, 14 Dec 2022 22:56:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0817110E082
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/Rju3Bm9nfU04FR5QPVxViryOA0Qp9ac3+w+TnaCMqOmFRsyJLLKngiG1ZdqDS/DDEsU9Wd7jh8PhpOGBAWukZbNQbPKvYO4iWXKdt5sOFlp1J/SYkUEizj8T98hn980Tdx0LzGTl6HsmFUDAh5PSwra4Cq5rs4gcIotpToG9wjXSyP8462p9NlXFZqI2aNpnOLZCTteuTvhW53OF+tmsBZoSORMBQiVoMudkzTaCtXlDNeegZItZF2gVeNoOG5wWqhwkWRBHc4MAgEuxIxFvi95Z+EO3gC68q182x5JB4PnSZ2b9bKzdm38Pr3m2xguwFzpCJu/9QRRdVgomA0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svfxXffqFUuHRcCP309V2edp9h6MocYpekTsz0NWw5E=;
 b=Kdj4q2/vKG46dnenKlIyXSReJUxdqfOKKh03EtN+lwOzjrDgLHhQxHT0upmFx9tqORS50WMhEB7szuHqALV5+TjHDSCY0Cm84Xs/UHOTsR0jIcWFW/Z0L6ECTON9dm5aLEYk2SnFutgMpnyEs1WIZ9gBRssD+Y4O4kyZMjbFvqS63Mp8kCiLFjF0vuomG8j8CEsXWADMYmTFuArBBoKUBeE9DOyeKLThyEdE8SKTQ3nsmKRg7STUeRZRSM5vE1yFQgjYxpkQEXK3y0wrBp355gJhYrHjtlLrVYK9Rj42jW7erToHYI2cIBTTPdRWH6VK5ozD46wKGkT+hG3lVoSSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svfxXffqFUuHRcCP309V2edp9h6MocYpekTsz0NWw5E=;
 b=K2sfRfpHfEZA7SXthE1FVYP6YLyS8m0m0VGGfDCHeNeNqw9S4rpleZ2e/pGN/hJQ4uCTgNJY0P3KOQNIFvo558lIInLK2NA+c91MmvU3OHd333iDCoXKSOlBGL4yyIcI5Cf2p8Ar6e16/BvngSk1yixyJoeFB+FwvhfWVrs4VAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 22:56:00 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 22:55:59 +0000
Message-ID: <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
Date: Wed, 14 Dec 2022 15:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
 <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7a79cd-bad9-4878-fbc9-08dade265e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iL1AWBcxJCfBp/c8K9KbjfstrV1YzDDSKGtLuVi42tRgey4NIIvj6CL1FINMuipRBP3MUS7qsMAJTZqzhCsiM/EtQ+F6i+/9e3/uR2IIGFqJwpWsRpxhODCLbskf3yHKbxt9Tnyl8D3kOpmIlyKyuOMKXzh3919UC1z2qkiqdA/q7km7h/x0ToUIBJTXXa10QqEtgMTwjfXpiGobr5QREWvBuBpqkxHrUE9yrfwY7sWUqkr06IZqo4Ih1CBV+NR24upO99VvE0CWPD7XtQYu5PC3UIA974TL0jb0RoTnoNIGjbvh7MLgY48SG4fBRY7wWniuCQnBtXm8AiIa7iisfKlZk4NfjXkzinTIsgjjKEqMniwSHz7nWWgCoPLig7HcdVS0uoySnv3lBA4YE1JKjbBW+r1KtPkNhBsQPNeUlHljgZAWnR6zJM6RoTLYvy8O9BRuzgJA2kZ59lPQNGi/w0g8dovqsvXAEA4N32IgaCdajqKUC+3pzXNPrfmIgpDefDYkAl8h23DiXjU21/U6Tuh18cSxbvfw/U/L4edrpZT9JQtI+7kQZqoFFwmx/OQCHdlcdDsxKbw1HPzJRHlbikYo3pp8eQbgheRqQkr/gEo/muNmawGWfL6q896g65WEaGu2UHlr3xazGhFU5b95KgkpsIq3YwD1KOxCtCWV7SxrQ0fqMHB1+CwCsoI77KLE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(36756003)(8676002)(2616005)(66946007)(4326008)(66476007)(5660300002)(316002)(83380400001)(2906002)(4001150100001)(44832011)(8936002)(31696002)(86362001)(38100700002)(41300700001)(6916009)(66556008)(6666004)(6486002)(31686004)(478600001)(6512007)(186003)(45080400002)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZyNm80Vk1neXBEeFN5dXJ6b2s0Y2wzZUEwdkphUk4rajVqcjZQRURCWW1m?=
 =?utf-8?B?T1FFN1RLUkhmaHhrVkpLSE5BYitvbU9vcFRRT2hBejl1c01mSzYwaFg1MUpj?=
 =?utf-8?B?OHdUM2IyaVI4STdTbkUrRlFxWHRZUlBxaUM4dzQ4NGU3UEhJem96LzBOU2hk?=
 =?utf-8?B?ZElxOHpZbUdaSWZ4UjE5QWVRMFNodTZvR2NTUWpWc2o3OE9GY1J6WXQ5eW15?=
 =?utf-8?B?U29TdW9idU5ad3Eyb2tXK3V5ZHZBQ3VMM3NTbTlsVitsbStwS3F4QXBCK2Nw?=
 =?utf-8?B?WGYzUkNBSVJYVm9TejlxVkFLZzJFV3g0N0VSNGsrYlQ2b1VrOXlza0Naa3Ju?=
 =?utf-8?B?N3krTEwxUUE0VDRtVGFrUDBDTG00WFlzcE96cVhrb3ZYbUhqS0dUUEY0b0pu?=
 =?utf-8?B?YU5mOERpYnUxdHRoV3B0UnUyUGtZYjFkc2ExUjNBRHpCNXMyOFlVUjgxaHQx?=
 =?utf-8?B?bDNyVTNZUkhPSVU4dnpMek4rK3VNWlFIZWVHdlhCL1YzRDBIdWNDQWZwL0xy?=
 =?utf-8?B?TVhQbGlXTStCeWN5T1czMEFUdE4wblV6L28vaVhBUGVoWU9ObEdVYWFJcDJE?=
 =?utf-8?B?QlloaVpCTW9lcnM3enBYbnQ4MUNlc0d0WkE1bnBSMk94eUlZTFlLMDBvWERx?=
 =?utf-8?B?dklBd3RKK005UkJvVjZOTE9YTlh1VEVrRkxIbHl6TXZOM2o0c1doN0pqeXZv?=
 =?utf-8?B?SEFHWGw1a0VranVvY2l5eHh4Wlg0K1VUMUZ0cTg3V3p1SmJpQ3Fua25sNjBo?=
 =?utf-8?B?cVJNSmE0T3J5K3VNTG1ndldwTnlwSldpdVhBVDNLUzBiQlU3MUNncEpORTAx?=
 =?utf-8?B?RmQ3ZFRsamR3WGkvVGVJQmNRSzk2a2xlWDJ0Zm01N2gzMzhMUkppR0wzZDFx?=
 =?utf-8?B?S2ErUFh5UkdqSExvRldKTDhVWC83US9hTlRySlpwQ0d6NUJDVldGeVdtalZk?=
 =?utf-8?B?ZUhkQ3d3ZTlmeXJyZXVCSFRldXJJeUgxNDllQXR1ajA3bG0zaGFGYk5RS2JT?=
 =?utf-8?B?TFNlSmk5SStkZ0d0dy9zc2dvUThzQlp3QldML2tLaFBpcURtZG1xWVR3a3hI?=
 =?utf-8?B?R00yOFRXemI1MDI3TzBzMnExdHEyY003YVQ3M0E0ZDRUZ3R6dkZ6d2wxcXpO?=
 =?utf-8?B?V1oxVC84dGI3UExDTzlUUUdIMGt6bTQvYjd2VnRROFluYkpDTm9HQVlYV0VL?=
 =?utf-8?B?TVJHR2d4T0lGL2VSNHk2U3M5TVVITlFZdzZHdU1vUjQrdkMvYjN4WDArMnU5?=
 =?utf-8?B?TFNVckJPSjliRmsxZm9xMGZheWtyclFJTEZHYzZndDc3bzJZVVUwZXNmamJu?=
 =?utf-8?B?Z2hUNEdUakM2TTFNeTU0cVRtZWxtRnpyaHFpRVN3UU1WSVJTazZGSFh6V1Nh?=
 =?utf-8?B?Z1c1dUN5c0JoVG1tSjBLOGI1TXh6bDRjelkyZFVjaU9LME1SazEyTWpKWFJO?=
 =?utf-8?B?RjZoWDFKRk5jek5zWlpaSVRJZjJVamtmZ2lBeGYveitwVE9COXdZeFViWGs4?=
 =?utf-8?B?YmlTdDg5K1FGU2M4VmFMLzVoZisveFJNYXZKaVFKNWQ5U2c2cXI2N1UrUUhU?=
 =?utf-8?B?NDhiZHdYVlhtV2pHb0NLV0ZPUUw5Uk1waSt4L2dGaG9zZzRCY2o5OW1uM0hC?=
 =?utf-8?B?ZjBZRUljYTUxNjVmUG1NWGlUMGg4TVdZYS9NT3prM3doUHBKOFNhUkdnc0FP?=
 =?utf-8?B?RlJXeThJT3c0bE5vSlR3Y1k5UGlVcVRsVDRaSGgySis2NmxxUkZKclRHNEhY?=
 =?utf-8?B?TXBrYWxGRkowVzl1QTFaaVlvdjA4anlQaFFPSHVMcWN2MWVhcnhWWTJJejY2?=
 =?utf-8?B?YUZEdHhjNG9tK3lLQzJ4eHQ5UFlrTmxpdk56Yy9Vam0xZlRzQkx1Q3pjUXY0?=
 =?utf-8?B?MGJmMlpyNlV1cktMbHExYmxrUzhmU25meWk3K3EySllGYUpjVkE4SlliQVhF?=
 =?utf-8?B?R1RZd1JWeU1XdUJ0Mm0zY0tpak9jemxOOHpyYVZZMTRtK1hsaHJBbW8xcGRJ?=
 =?utf-8?B?WkUyb1FBdDEwbUdSZWZEQkdSZjJzSjNTcDVXL0wxU1FXNWlqMlI4QTRPRG5p?=
 =?utf-8?B?RkFNWFRjb3puWTlpLy9pMDRiemF5M3U0NDNURTd6QjRYTXFxQkZtMWJUMG9T?=
 =?utf-8?B?emxYeU9EdGQ5U05OOFJ5aWp2ZGVRSnVBNFlCUitEODIyQzlRRjIyZ2FZZ0dJ?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7a79cd-bad9-4878-fbc9-08dade265e0b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:55:59.6188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nADk+73zT4zXMezPyU3VLOwGNJU3ikXPujAJtN22yC4X9iakTm3u/dB7H2qYCWVt0Lm7avQ6a9AqBzx1sNQUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-12-14 15:35, Alex Deucher wrote:
> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>>
>>
>>
>> On 2022-12-14 14:54, Alex Deucher wrote:
>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>> <aurabindo.pillai@amd.com> wrote:
>>>>>>
>>>>>> From: Alex Hung <alex.hung@amd.com>
>>>>>>
>>>>>> [Why]
>>>>>> When running IGT kms_bw test with DP monitor, some systems crash from
>>>>>> msleep no matter how long or short the time is.
>>>>>>
>>>>>> [How]
>>>>>> To replace msleep with mdelay.
>>>>>
>>>>> Can you provide a bit more info about the crash?  A lot of platforms
>>>>> don't support delay larger than 2-4ms so this change will generate
>>>>> errors on ARM and possibly other platforms.
>>>>>
>>>>> Alex
>>>>
>>>> The msleep was introduced in eec3303de3378 for non-compliant display
>>>> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
>>>> msleep(60) when calling "igt_remove_fb" in IGT
>>>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Figt-gpu-tools%2F-%2Fblob%2Fmaster%2Ftests%2Fkms_bw.c%23L197&amp;data=05%7C01%7Calex.hung%40amd.com%7Cef40490c3d0f4a0448a808dade239493%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638066541657914573%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=kx7mnbuN%2BhmIPEgj4l1cuek0nvqK16Ig3fWAHopA8CI%3D&amp;reserved=0)
>>>>
>>>> It is possible to workaround this by reversing order of
>>>> igt_remove_fb(&buffer[i]), as the following example:
>>>>
>>>>      igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
>>>>
>>>> Hangs:
>>>>      igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>>>>
>>>> No hangs:
>>>>      igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]
>>>>
>>>> However, IGT simply exposes the problem and it makes more sense to stop
>>>> the hang from occurring.
>>>>
>>>> I also tried to remove the msleep completely and it also work, but I
>>>> didn't want to break the fix for the original problematic hardware
>>>> configuration.
>>>
>>> Why does sleep vs delay make a difference?  Is there some race that we
>>> are not locking against?
>>>
>>> Alex
>>>
>>
>> That was my original thought but I did not find any previously. I will
>> investigate it again.
>>
>> If mdelay(>4) isn't usable on other platforms, is it an option to use
>> mdelay on x86_64 only and keep msleep on other platforms or just remove
>> the msleep for other platforms, something like
>>
>> -                       msleep(60);
>> +#ifdef CONFIG_X86_64
>> +                       mdelay(60);
>> +#endif
> 
> That's pretty ugly.  I'd rather try and resolve the root cause.  How
> important is the IGT test?  What does it do?  Is the test itself
> correct?
> 

Agreed, and I didn't want to add conditions around the mdelay for the 
same reason. I will assume this is not an option now.

As in the previous comment, IGT can be modified to avoid the crash by 
reversing the order fb is removed - though I suspect I will receive 
questions why this is not fixed in kernel.

I wanted to fix this in kernel because nothing stops other user-space 
applications to use the same way to crash kernel, so fixing IGT is the 
second option.

Apparently causing problems on other platforms isn't an option at all so 
I will try to figure out an non-mdelay solution, and then maybe an IGT 
solution instead.

> Alex
> 
> 
>>
>>
>>>>
>>>>>
>>>>>>
>>>>>> Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>>>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>>>>>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>> index 913a1fe6b3da..e6251ccadb70 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>>>>> @@ -1215,7 +1215,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
>>>>>>                             * After output is idle pattern some sinks need time to recognize the stream
>>>>>>                             * has changed or they enter protection state and hang.
>>>>>>                             */
>>>>>> -                       msleep(60);
>>>>>> +                       mdelay(60);
>>>>>>                    } else if (pipe_ctx->stream->signal == SIGNAL_TYPE_EDP) {
>>>>>>                            if (!link->dc->config.edp_no_power_sequencing) {
>>>>>>                                    /*
>>>>>> --
>>>>>> 2.39.0
>>>>>>
