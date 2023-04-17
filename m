Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FACC77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 02:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0345310E0B9;
	Mon, 17 Apr 2023 02:20:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512EF10E0B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 02:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEmuLh3vSAv4egMW0jzU7lHkU6fDt1QLtU3msejy5c3MCO8eWRWmh0XFW6hxOI8kvVBGYyCPxlbqQAIQkxpav/SDPC0A/9xyiygq1OV66IRZHOdoW9hv2JX0gltOJ3Sy3eCT8qRaJa0a9iB742ZbbDEt4M78GG5lEhS2tgbu0mcAoQuRzJ7KKk9S71mEbASp2qukP+SqTRF8aGVLIUVEoo7ty3rsGL36IFdqZeTa1d0eQxXAJB7e7l6p+u3xgAry5hggW+TsdRyiNVkrXteJ4roq0ylLUcXV5IzFrIYm7jrQUpF3B0H2cz4nYo0iME/046adX81H+jtUbEb4Pr/JXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O23DWP+SzSGWJNVURs2H2kZZ/QgoQH9LaOklwYnJGk=;
 b=If9lWiu7vi5W6czQi0WlYsfKGpsmXlkhoSr5/dpA6NTu4hryalCae3HtqHVMQiEHWtD7j0hX9cggZB046XiIi11l1sh5L76Zb8JYNeX69jIhYqkLnol/T5Uq4X9Dlj2Q6NY//tGcBlzPRYxndE7AuEQAFxPPwzFWUioAQ5z7FabDIHzmHlymxg5f9se/PEtWicPxFiHWl3WzGKPsbWaynXaijQNDX/dPaaA0gXmb2QIiaQZwVOjAsxYJzUTB9Hisp9BIgPBV3YL1QOb68f80F4BbbCquCivj4fSEDAYeJoUlfy8Pp5yyBWOsQm1nYHLZLfmNMJiSpekdC39SqynTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O23DWP+SzSGWJNVURs2H2kZZ/QgoQH9LaOklwYnJGk=;
 b=02E9G9uqS3VIp4gE/dr39AdEZ6/C+k0yqqaX8dTydp6gXGlUhwoNoVjkaXgl9bnLIGdRJlQUSB8xKNLzezlxYA941t9f8fyBUWBL2GAxM4C0z/30euxcSpXsbOMgiE9ndwHdIAyQT+WRSY3UVJDvsgqIv+grM9WRQKsQTBlvuf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 02:20:11 +0000
Received: from SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::977a:52f:acf1:55f9]) by SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::977a:52f:acf1:55f9%7]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 02:20:10 +0000
Message-ID: <52256912-4b21-0e9e-8092-3ca82c3b6970@amd.com>
Date: Mon, 17 Apr 2023 10:18:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
To: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
References: <20230414162215.1201883-1-HaoPing.Liu@amd.com>
 <ea433d88-507b-5b0f-e3c6-8711e15bd166@igalia.com>
Content-Language: en-US
From: "Liu, HaoPing (Alan)" <HaoPing.liu@amd.com>
In-Reply-To: <ea433d88-507b-5b0f-e3c6-8711e15bd166@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0199.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::17) To SN1PR12MB2445.namprd12.prod.outlook.com
 (2603:10b6:802:31::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2445:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df27b7d-dc08-4b6e-eee9-08db3eea451a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnXj/0HpTyIBgmAtnGXsjKyR2mKqO4SXSm6KKQGSCZm+aJNI4HH6lxf5W8Zl4XHBLMJmmTol3wUBFGGb2IGygEZ74o8Ak0r8GX/tYjAJptjhSkRxNg7sHkKZVKE8cCB+mUtBDZGjueyoLEDPCJVrEt60uQhl+NHt5bt4TLpkaHT4K5JuzNenB69XB0oJfCpu58QU+3X+UvGse7dLEHl2KsD8+Q/7/2ZSDpGGtJnQUGI8a0XPqNCcOxIl4v9EhksfQcrSEf7tPFDZSbJfyTLsV+EPM3zWuMA4dCz2+j7POYt/0PySjPzBWxOm6dCJC0+mPGvyhzbfHTTS64a8qKxmcuAb9oK3u5mZ+HXEEDuHyGcSMk1w+wZUqO9SfuBBkAA1A+fgYJa53B5gFsMWKyY36M24kbPHExtncGeNNAKbCSfOaOCwNZmmdoYhpIpXpapODTfIc6WVqvfAovscGwveHdJ+nE2rBpbChUdV4lVFpDtdfs8x6+ORZwQVazv//qqeBulppaX7r3jeLKJCnZ9dY+uAn+J0zEbt3L2th1pzNv7JXjxelvH/BSA1sxfGn23r/fMSpGs3rNfYqHJFEDhBik4IlmLr1V++YGwREAHxNyodwFnUyRnhWCtwonEMlBc1MvkHJpv+/bMK0iMCBm150Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(2616005)(6512007)(26005)(6506007)(31686004)(478600001)(66946007)(66476007)(66556008)(83380400001)(316002)(6486002)(6666004)(186003)(4326008)(6916009)(8936002)(8676002)(41300700001)(5660300002)(2906002)(36756003)(31696002)(38100700002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpKMTl3Qzk2bEh2Mlc2RnkxdXVZelJvYk1zSmZhMHh2UjNBVGpTY3p4N0lt?=
 =?utf-8?B?WWxiVnRrYzNMKzBhaFVMSXg4bjNXdVI5N1p3N0ZUR0NMdWFOMlJaL1RBVG01?=
 =?utf-8?B?NW9WeldlcGd3UXd4NFFwWXo2a05HS0ZVRXptc1p0Qmd0NXR2eXh0M2V1NEJU?=
 =?utf-8?B?Y01CVkxkMWNqUWVuM0swWVZucHhkeDJHR051d0trdU1Jd2VYcGw2Z1RybTEr?=
 =?utf-8?B?MWxsUi8zWUNiR0Z6eDBRSzg3cGppZFdhM2FUUkM5d1lWSkN5RHpnWFc4THBv?=
 =?utf-8?B?UjNqQTFUOHpVVUE1WkRiRVROMFczNU5VV1d0OHplTEJhenh3VE1wZ000cXpQ?=
 =?utf-8?B?Qk84S2Q0c2pDbGpubWdFL3dzelBjQzJBNDZ4VjVVbDNOOGhJNXhNMXVGc2tp?=
 =?utf-8?B?eHFqSm9oWFY5WU1BMzdidVZTYmtvb0x0Q21oRU0rbXQySk1xS2txWkhJalBK?=
 =?utf-8?B?SEhzbDhvbkpYUTJSeWxoTkJ0elNZK1E5ckcvd2VIMkY4Q0piTWJOYmJPbGps?=
 =?utf-8?B?TzNucFl1cm1NTTczMEZhT2tXUzhXZjhxeStBTUI2eWJXYlpaVkw1Y0tudHcw?=
 =?utf-8?B?Z0gyOWZkaWYxeTlyZE9IQkVISTJoRGY2dTBSWW9zTmJNRkFHTE00ZVdLeSth?=
 =?utf-8?B?OFR3ZnVhdlRMYXdDYWxETkUzK1E0ZmFiMFNrd1huSGtiTjVka1MyOEd2Zkg3?=
 =?utf-8?B?WHpEZ2hoV1QrVmJObXRxVzJMK09CeGtVdUV1YkNSTDZOZlFaRmIra1NsTXJj?=
 =?utf-8?B?V0Y5L0tMYnNhcDJoY0dDYlhaVmY2NGRYUkY4Q1FQY2Joei9pQjJWTElmUmRX?=
 =?utf-8?B?Z0JCMEdoT0c3Mm0raXUzY0FaWnNNWGpKc3pNWmFiMktMdDVuZnhoYU85RHp3?=
 =?utf-8?B?VXRYQnNWTUhXQXJ0WkVYTzNub3ZaRVkxN2FNU0RMZmVTSlVBSmxhR05nS0p0?=
 =?utf-8?B?THVTMFpWSUtuMHJ0cjhZaHRLS29EZVdzRXdzVmp5b3FwNzlnUGcxeitBMEFv?=
 =?utf-8?B?cFJWelVFdGRnQkZkcFR1dlJJQkhrTDU4LzlXMVpOMVJtQ2YzVnNxQ0RqQ2dz?=
 =?utf-8?B?UURDWHhDVkxXc2hmL29FdTg1SjRiUjQ1TXlienBQcXZJSEVQYzRSS3dUM2Y5?=
 =?utf-8?B?RElEemJoeGU4WkhTSmFwdlA2Q1U1REhyVzV0ZlZBV3lzSkIwNnBJR2hLelln?=
 =?utf-8?B?WDcvalIyZEpzaU9SOElIbUsveFd3Q3VjdFBrTUZycC9UaUVXZVpGVlNPa2JX?=
 =?utf-8?B?VWdJbVZ3ZEtoZ1RlUXUwT3FTQ2ZVbFJobC9vZUhLWGt6cEppRDlaRDdWdVNV?=
 =?utf-8?B?N0oySDBQN0ViTElrdWoxc1Fwem9LMmFNc1A5QXdZcTRPaWdHeDVVaVRsamFO?=
 =?utf-8?B?Y3RnRitYa0RrV3hPZ1JWaDBEQTNqZDkwWksybUVKNXQzSXBZS0d5TXJDRmpq?=
 =?utf-8?B?dkF0TysyN0RFak43NE5pYjlzNjJleGFVUUhpdFY2Y2xiNmtsQklNN0hyNEVo?=
 =?utf-8?B?UUp1bGRaZGhMeFh2SjhJSUY4djBGWXl4cndUZWpyVlV4NjI0NTZQTFVMTFBR?=
 =?utf-8?B?dldBaWNVeGpBRjFiYnUvR1k0TEZmbGU1bnkzUXJUUVJsKzc5Zi9tdFh0cURJ?=
 =?utf-8?B?T014RWh4UUd2bE40VlNic3F2TjBRSHNuVDM2ZzNPZkFoZys0TWNDTDZYMENY?=
 =?utf-8?B?TlQvT1hocHl1WlhjSnNydVVEeWR3c0xWMnR0dVNDTStxTllhNE93dHFFSXp6?=
 =?utf-8?B?ckxsT253RG9PNm1nUFJudGZyVmdZR2hQK1J3MG1oYUtndk9SUGc3TFhuVFZG?=
 =?utf-8?B?c1VnVmtNQXFQVVorbHhPS0IvMVdHYlk3aTA0Mk1HMGpwVFpZNmZoaUpHZ3Bs?=
 =?utf-8?B?dC9yWEpjVHQ3a00weUFJeHA0am1VTFB4VVlnYVBpTEEzRmdhQTZPWW4xTnpp?=
 =?utf-8?B?VUZpZnNXMDVUWlZ6YlZSRUVnN3dVTVlLeXZvMmdCVGNITWJ2VGcwNkxqNkJt?=
 =?utf-8?B?MG5EK0lkTlV1VFdKS1crUXlNeEtqNWkxcW9oZkdzcUY4dEpOaXZsV0ZGVGU4?=
 =?utf-8?B?MXB1bjcrb3lTRkxPajlYV1BkRjFRQlQ2TGhMTnc2K3ZPVXNwSERNUnA2TFpl?=
 =?utf-8?Q?6DlE63eKbDBRBZ0/IYu9gLvss?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df27b7d-dc08-4b6e-eee9-08db3eea451a
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 02:20:10.8918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 589B/hj7Yl7L31InoT7u2jV6PXTnudETOy0nmBholQXfVC03jH3XfnVNz4UJ07l8J6ggTIRb1in/eAfRYj285w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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
Cc: bhawanpreet.lakha@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi André

Thanks for your comment, please see inline.

On 2023/4/15 上午 05:11, André Almeida wrote:
> Hi Alan,
>
> Em 14/04/2023 13:22, Alan Liu escreveu:
>> [Why]
>> After gpu-reset, sometimes the driver would fail to enable vblank irq,
>> causing flip_done timed out and the desktop freezed.
>>
>> During gpu-reset, we will disable and enable vblank irq in dm_suspend()
>> and dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we
>> will check irqs' refcount and decide to enable or disable the irqs
>> again.
>>
>> However, we have 2 sets of API for controling vblank irq, one is
>> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
>> its own refcount and flag to store the state of vblank irq, and they
>> are not synchronized.
>>
>> In drm we use the first API to control vblank irq but in
>> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>>
>> The failure happens when vblank irq was enabled by dm_vblank_get()
>> before gpu-reset, we have vblank->enabled true. However, during
>> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
>> checked from amdgpu_irq_update() is DISABLED. So finally it will disable
>> vblank irq again. After gpu-reset, if there is a cursor plane commit,
>> the driver will try to enable vblank irq by calling drm_vblank_enable(),
>> but the vblank->enabled is still true, so it fails to turn on vblank
>> irq and causes flip_done can't be completed in vblank irq handler and
>> desktop become freezed.
>>
>> [How]
>> Combining the 2 vblank control APIs by letting drm's API finally calls
>> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
>> synchronized. Also add a check to prevent refcount from being less then
>> 0 in amdgpu_irq_put().
>>
>
> How have you tested this patch?
>

I triggered gpu-reset by this command: sudo cat 
/sys/kernel/debug/dri/0/amdgpu_gpu_recover

When display lights up after gpu-reset, the desktop becomes freezed once 
I move the cursor (sometimes you need to retrigger gpu-reset for 1 or 2 
more times to reproduce it).

I made this patch after finding the root cause, and didn't find the 
display freezed after testing for about 20 times.

>> v2:
>> - Add warning in amdgpu_irq_enable() if the irq is already disabled.
>> - Call dc_interrupt_set() in dm_set_vblank() to avoid refcount change
>>    if it is in gpu-reset.
>>
>
> If this is a v2, please use [PATCH v2] in the subject.


Thanks for the reminding. I will keep it in mind.


Best Regards,

Alan


>
> Thanks,
>     André
