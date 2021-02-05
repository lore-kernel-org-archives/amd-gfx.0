Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E5FC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 05:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1195E60230
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 05:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1195E60230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F306E187;
	Fri,  5 Feb 2021 05:59:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBEB6E187
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 05:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkr9KwtLx0TCqZFIS1sFaLA/9wK9mZFM0C0zC9UHtbspv/rBAoHzUiLWpVWjYz1Z2/VIldJjrkcV4uvyu16JSjvxfYqGbKm0JMLGQeZLdYMOjt3ZVU8qUrLnermVwbrkAC3SSGipIVZzyjmnGLex6o9jBe+KAnS7rsH9spMyZnLR4gAfnIk4T166p6Yl4veXZmMjJtdGsxZ14QoYAFqxdA7n1GGcQVShQhxbRJHChNApcXdXMs/avGU/BJ5hKu1PgqgjWx/YbCchbNasxScNsILlGK46uDbekyJOZyWY0qR051yZ2pYPz4xfN2VMjRrKY6kGkU4V8tcawCFXE645bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78nlSatzEl7TDTvSl4b+/qu8GNYHyK7xw8Vx7/ZrhMw=;
 b=igTYxciQun+j5uYzQWylORQ//qUJKa9MWtzQdmKvN3iHzIJNCaWMjW+6A6rKd0mQUPhohxBYaydVKxC6WPcI2FZFTYAD/IxB5ZYAO18BYab/WuV+xUmmkVqEwAxVEkYr0Ox8Wz49ea+wAoGTueJ7Rjp9QNUF6+CjUaJNvj17MNH0f6Bm2H4tAZ49OtmrgpHmh9H428gc1Tem4qWTHktPuh+rDQHs2nxnuwDW1EGK2Og4PJh4B7h8BWTgZOziQdkdOHITQfXLw8Sq5ktDvcP7QiW0abdQUKDGlzHvDV4nGK5wGWW9FUatCYeJzJAH37n+n8ov8HNPYYTtxCJXC9Ddmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78nlSatzEl7TDTvSl4b+/qu8GNYHyK7xw8Vx7/ZrhMw=;
 b=JyuxCI97NrnCNK4aiJmcI3p7Uq7Mi090sBWeA12AR93t8sq7tWkaQh63Q9g8zNweiLBompBDo0DdJgPfWoN31OTaxVr1T+zlS6NiZ4WQEJEngnnnWAn7QxS5N19dm9kJZGR2pm1Cf9cfiaaMzrTGmiQedDCAgD9VYLERS2NQSZk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2692.namprd12.prod.outlook.com (2603:10b6:408:2a::10)
 by BN6PR12MB1731.namprd12.prod.outlook.com (2603:10b6:404:106::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 5 Feb
 2021 05:59:11 +0000
Received: from BN7PR12MB2692.namprd12.prod.outlook.com
 ([fe80::ad58:45e1:d143:b248]) by BN7PR12MB2692.namprd12.prod.outlook.com
 ([fe80::ad58:45e1:d143:b248%6]) with mapi id 15.20.3805.033; Fri, 5 Feb 2021
 05:59:11 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20210202171748.1062530-1-alexander.deucher@amd.com>
 <20210202171748.1062530-2-alexander.deucher@amd.com>
 <MN2PR12MB454926B93FE2B67447AF46A197B49@MN2PR12MB4549.namprd12.prod.outlook.com>
 <CADnq5_NH0ezDtVhOE-teJZBZNdDV22is1jVkaKxe7pcof8-qbg@mail.gmail.com>
 <b153dea1-2c64-5607-028f-855c1c86fea7@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <a22e0960-d93f-9d65-179d-af0c8f280ef4@amd.com>
Date: Fri, 5 Feb 2021 00:59:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <b153dea1-2c64-5607-028f-855c1c86fea7@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To BN7PR12MB2692.namprd12.prod.outlook.com
 (2603:10b6:408:2a::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.18.117] (165.204.54.211) by
 YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Fri, 5 Feb 2021 05:59:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9de5892-76e0-4fc2-b093-08d8c99b284c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1731:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB17317CDB92DA5A1D8268D9CAFEB29@BN6PR12MB1731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/mjZvKgWOZdhPVjAiPbnM5RNCZ2/gKeDEfa0xNMsKJJ/75KUEIPSP8jFNEoGjDYEIwruKglKRRbp09YV7+odPm6w8R3a/avFV6sXMY39ojZlLKT7wROin0LmemjKqEdjjlLqMNulsWAl4t5PaUSZEiQf0LyZrjjOkDqLDl1a6aKoEJIt16yXqeV1+ZGWa6oA4dwy0OBpEkvY2Q46t1U338xqU7EALn3z6WyBCHtVbViznjS/XSelyb50R344G3yByUxbQWy3osEFARypUpHrrZl1ybbo/UE7QJ/bGqxCLCAiQ9aLSK7sRzvU5T8+KdnDXNk/fOTh/dHJqKXqDqlbwnvxcvrSBnBJrGK2EojwqHG64rCOh8lCMYpv+8oBMsorGd6IWscEXxrvtBvWsBgF5kGV48M2eWeNu3n8ZAdYPZD2cywQ6hHzJNZ/NLvHP+6pkvr1xRBHoz7UjmAxQQXlRdm6HKij/iliy+fOJQjLvVePqCoBjarexQwFRvY17qyO/hSgwIjAnTfsCqVRXyZjOx2Qn77Kw4sbAVCYkpWLvJT/zreN3Jwb8uXwRqdxhOS6BHwRFTmw18Iyx0pNt0s27ZSy1rennQmb0hFMRFNYJOBGGcWlvfOEWUtBuS3hVMIXLd8237O5DDgwg8K4BjmFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2692.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(33964004)(478600001)(16526019)(31686004)(966005)(8936002)(31696002)(186003)(6486002)(52116002)(86362001)(16576012)(2906002)(110136005)(5660300002)(2616005)(956004)(4326008)(54906003)(166002)(83380400001)(66476007)(66556008)(66946007)(8676002)(6636002)(316002)(53546011)(26005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UnZxY2hRRnFwcmx0SElMSmVGakhFQmt0NnZ3RGJIaUZPem1ieWVmNW5ueDhn?=
 =?utf-8?B?dy9Sc3NrTCtPMzdTTThZTWV5OXZoRzFCTCtsSERsR3lnR2hMQmtzY3YvUG9n?=
 =?utf-8?B?OUFLZVM4QmcvcFV0ejUvb0hGNXh5aUczWC8vSzBwWCt2QzZxT2ZPR0ZTRlgx?=
 =?utf-8?B?Ym9IVTN4YUVvRmRNbGdlNXpDVWVPTnF4UHBCdnVZcFJaK1lzSitJOUtXeEQ4?=
 =?utf-8?B?OFZZZlpITTkwZi9Zb1c5Q2t2Rzd1UmNuZm1IbjVOOTRTeWlQbllFS05tVGFz?=
 =?utf-8?B?bEYxWkdJZGlOeFBzQ0JOTEJZelhMUkMyZ2pGMUNWK202V1pOZHRMTk95VnJj?=
 =?utf-8?B?d2cxd2x6MDVCcXloRlh0RjRQU0ViYlRBdU5CVWc1L3pVUHJZR0xLT0Y2T0RJ?=
 =?utf-8?B?ZldnRWp6WWZCQnpTQ2VMMGNFcjRXR1RwVUdURWlSY1lzVWY4UlRDMldEL1Nx?=
 =?utf-8?B?ZDB2SEhjazJFVDZDVWg0YkZsZnVuRzFuSStaREpsK2wyeUl0S0Y1bEFNQ2R1?=
 =?utf-8?B?WkVhYlRXVmlaMFd4NGNZSVB0SjQyQXVxY3o0UHhBdjU0enNkblIyVXhTYzUz?=
 =?utf-8?B?MDNkeXR3YzV1ZStqVVBPdUJ6ZTFFdXlUY2lySEtGWWZ5aklqUWc3Q0hTMlVV?=
 =?utf-8?B?SDdnWmo4RWhuNDlBS1Y4aDN3c2c0M1o3TmdpaTR3K3dqVkNhKzFNMHB0c2ZH?=
 =?utf-8?B?bnM5dkZDc3U2Zk8rb0tTYjg4U1puVS9rZFkrMEJlWTVCVWVvQ2xCZXU3MFZu?=
 =?utf-8?B?WVJHQ3RhbFdrWStBODBNU29UU21kWUdCeW1vQWdLc0JvZ0hMSzkzVlZLMzZa?=
 =?utf-8?B?VU5ZSVZsQloyRG9mc3M4K0ZMaUJRaXVMQTJLUFJEYXM4a0FzMTRTN3AxVUto?=
 =?utf-8?B?dkNNa3NrSlp5QkZzbGtzZGk2Q1p5VzV1dmRYcytyMkd6a1E3OHhRZmNXc2FF?=
 =?utf-8?B?ck05RFhCQXE5SXF2c2JvbGdMWVVZMHlOR1BaVk43SDU1K2cydHkzd1VyYmhB?=
 =?utf-8?B?VGF6Yi9ObmZ2RzdhM2JKcSszbWF2R1VPZ1lodTBKUVI0UDVmc2xYYzc1QlBh?=
 =?utf-8?B?b2g4M0NxOUJQVlFvVGJJK0xERSthVUVsN0VVeDQvckl5ekF2QlBEYVpkSk1O?=
 =?utf-8?B?MjB6bjMrSS9UTjBHKzFjVnBYMUljZEFnZEdTdmFEanVZTlFOSWpsaFdSeEFN?=
 =?utf-8?B?bEFGQ25RNTZtVk1kMU9oU2tzbFkyVnFwa2ZkSE9KUXpEdGFRVmtkQ0ZrTTA2?=
 =?utf-8?B?VFJvN2xySXdrbnREaWovUyt4LzhXK1FwL0FGWW8wSjF2Z3JTM0FVMXF1T1Jo?=
 =?utf-8?B?bURKcDhFbGVOaCtjNGozZ1hZc2piZ0Uxb1ZPdnV1eVp5SjZCTmxYV29pc1ZT?=
 =?utf-8?B?T0dacG10Smh1TDJXSjJoYm43bEhTVHlqdlN1MlN5YlAzbExYSVUzK1FZTWRG?=
 =?utf-8?B?V3hGRWhTUWZ1OThMRFZ0b240enFPRElrOVBmeTk1WkhIZmlCcTNNTWd4dFZH?=
 =?utf-8?B?UkJ1aXpnTVpuend6Y0NQVFR0M0V6enBvSzJKS2pNNmxUV2ZCamJ6MUlLbDh2?=
 =?utf-8?B?Wmd2QlVUSnNhU2k1VzVyQm16T1pLZGkwYXBTR3FhUitIbHJMNEFwcGJEQmVn?=
 =?utf-8?B?c3FDa21CczBFdkhUZU8xa1pkOG8yWXJEQU50NTg4WGgyK010eVdId3BzWFdR?=
 =?utf-8?B?WGpwR3d4VW5DQW1uSkdMb0lRMFhzVjhNck1rLzF5MUt5d1AyZ0dmY1NxT0ZN?=
 =?utf-8?Q?dNec7pwV7btBPoFdJlLT72M8WlNWYytHoxrK38J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9de5892-76e0-4fc2-b093-08d8c99b284c
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2692.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 05:59:11.1720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oycMKCZKYuwgQIGf2Op1rWcgQ1NsXCfT/kYkI5IL+FOc+ov8W5n8Fhj/ffBkIBSqqO8Yt/077/CHOJ+Eo8HHHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1731
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0162835042=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0162835042==
Content-Type: multipart/alternative;
 boundary="------------32761223696D3F568AA9AFEA"
Content-Language: en-US

--------------32761223696D3F568AA9AFEA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/4/2021 10:14 AM, Felix Kuehling wrote:
> Am 2021-02-04 um 9:37 a.m. schrieb Alex Deucher:
>> On Wed, Feb 3, 2021 at 2:56 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>>> [AMD Public Use]
>>>
>>>
>>> -----Original Message-----
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
>>> Sent: Tuesday, February 2, 2021 10:48 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and DPM_FLAG_SMART_SUSPEND flags
>>>
>>> Once the device has runtime suspended, we don't need to power it back up again for system suspend.  Likewise for resume, we don't to power up the device again on resume only to power it back off again via runtime pm because it's still idle.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index b4780182f990..b78847fa769b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -206,6 +206,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>>                  if (amdgpu_device_supports_atpx(dev) &&
>>>                      !amdgpu_is_atpx_hybrid())
>>>                          dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>>> +               /* we want direct complete for BOCO */
>>> +               if ((amdgpu_device_supports_atpx(dev) &&
>>> +                   amdgpu_is_atpx_hybrid()) ||
>>> +                   amdgpu_device_supports_boco(dev))
>>> +                       dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_SUSPEND |
>>> +                                               DPM_FLAG_MAY_SKIP_RESUME);
>>>
>>> Device runtime suspend callback does -
>>>          amdgpu_device_suspend(drm_dev, false)
>>>
>>> System suspend callback does -
>>>          amdgpu_device_suspend(drm_dev, true)
>>>
>>> One of the effects of this flag is for KFD to decide whether to evict all processes. It is done during system suspend but not during runtime device suspend. Will that have an impact if  the system suspend routine is skipped in this way?
>> + Rajneesh
>>
>> Can you comment on this?  Idea of this patch is to not wake the device
>> for system suspend and resume if it's already in runtime suspend.

KFD doesn't allow amdgpu driver to runtime suspend the device as long as 
the per process device data is valid. This patch only enables direct 
complete path for already runtime suspended amdgpu device so its 
implicit that kfd had no active process. While we may be OK to not 
explicitly cancel scheduled work or suspend all kfd processes (since gpu 
is already runtime suspended) we still leave KFD unlocked for a system 
wide suspend via direct complete path.  I think we should still be ok 
with this since locking is only used for making sure that kfd is not 
open during a gpu reset.

Also i suggest using DPM_FLAG_SMART_PREPARE as well, since we are 
relying on prepare for skipping late/noirq phase during system suspend.


Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>


> KFD only allows runtime suspend when there are no processes using the
> GPU. Therefore it should be safe (in theory) to skip process eviction if
> you're already in runtime suspend. Just make sure all the suspend/resume
> calls into KFD are paired up correctly. If you skip suspend but then
> later call resume anyway, it will likely cause problems.
>
> For testing this, I'd suggest running some KFD application (e.g. kfdtest
> or an OpenCL app with ROCm-based OpenCL) before suspend, then suspend,
> then run the app again after resume to make sure KFD is still good.
>
> Regards,
>    Felix
>
>
>> Alex
>>
>>> Thanks,
>>> Lijo
>>>
>>>                  pm_runtime_use_autosuspend(dev->dev);
>>>                  pm_runtime_set_autosuspend_delay(dev->dev, 5000);
>>>                  pm_runtime_allow(dev->dev);
>>> --
>>> 2.29.2
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------32761223696D3F568AA9AFEA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/4/2021 10:14 AM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b153dea1-2c64-5607-028f-855c1c86fea7@amd.com">
      <pre class="moz-quote-pre" wrap="">
Am 2021-02-04 um 9:37 a.m. schrieb Alex Deucher:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On Wed, Feb 3, 2021 at 2:56 AM Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[AMD Public Use]


-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of Alex Deucher
Sent: Tuesday, February 2, 2021 10:48 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
Subject: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and DPM_FLAG_SMART_SUSPEND flags

Once the device has runtime suspended, we don't need to power it back up again for system suspend.  Likewise for resume, we don't to power up the device again on resume only to power it back off again via runtime pm because it's still idle.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b4780182f990..b78847fa769b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -206,6 +206,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
                if (amdgpu_device_supports_atpx(dev) &amp;&amp;
                    !amdgpu_is_atpx_hybrid())
                        dev_pm_set_driver_flags(dev-&gt;dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+               /* we want direct complete for BOCO */
+               if ((amdgpu_device_supports_atpx(dev) &amp;&amp;
+                   amdgpu_is_atpx_hybrid()) ||
+                   amdgpu_device_supports_boco(dev))
+                       dev_pm_set_driver_flags(dev-&gt;dev, DPM_FLAG_SMART_SUSPEND |
+                                               DPM_FLAG_MAY_SKIP_RESUME);

Device runtime suspend callback does -
        amdgpu_device_suspend(drm_dev, false)

System suspend callback does -
        amdgpu_device_suspend(drm_dev, true)

One of the effects of this flag is for KFD to decide whether to evict all processes. It is done during system suspend but not during runtime device suspend. Will that have an impact if  the system suspend routine is skipped in this way?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">+ Rajneesh

Can you comment on this?  Idea of this patch is to not wake the device
for system suspend and resume if it's already in runtime suspend.</pre>
      </blockquote>
    </blockquote>
    <p>KFD doesn't allow amdgpu driver to runtime suspend the device as
      long as the per process device data is valid. This patch only
      enables direct complete path for already runtime suspended amdgpu
      device so its implicit that kfd had no active process. While we
      may be OK to not explicitly cancel scheduled work or suspend all
      kfd processes (since gpu is already runtime suspended) we still
      leave KFD unlocked for a system wide suspend via direct complete
      path.&nbsp; I think we should still be ok with this since locking is
      only used for making sure that kfd is not open during a gpu reset.</p>
    <p>Also i suggest using <span style="color: rgb(0, 0, 0);
        font-family: SFMono-Regular, Menlo, Monaco, Consolas,
        &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier,
        monospace; font-size: 13.6px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: left; text-indent: 0px; text-transform: none;
        white-space: nowrap; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(252, 252,
        252); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">DPM_FLAG_SMART_PREPARE as well, since
        we are relying on prepare for skipping late/noirq phase during
        system suspend.</span></p>
    <p><span style="color: rgb(0, 0, 0); font-family: SFMono-Regular,
        Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;,
        &quot;Courier New&quot;, Courier, monospace; font-size: 13.6px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: left; text-indent: 0px;
        text-transform: none; white-space: nowrap; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><br>
      </span></p>
    <p><span style="color: rgb(0, 0, 0); font-family: SFMono-Regular,
        Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;,
        &quot;Courier New&quot;, Courier, monospace; font-size: 13.6px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: left; text-indent: 0px;
        text-transform: none; white-space: nowrap; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">Acked-by:
        Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a><br>
      </span></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:b153dea1-2c64-5607-028f-855c1c86fea7@amd.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">KFD only allows runtime suspend when there are no processes using the
GPU. Therefore it should be safe (in theory) to skip process eviction if
you're already in runtime suspend. Just make sure all the suspend/resume
calls into KFD are paired up correctly. If you skip suspend but then
later call resume anyway, it will likely cause problems.

For testing this, I'd suggest running some KFD application (e.g. kfdtest
or an OpenCL app with ROCm-based OpenCL) before suspend, then suspend,
then run the app again after resume to make sure KFD is still good.

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Alex

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Thanks,
Lijo

                pm_runtime_use_autosuspend(dev-&gt;dev);
                pm_runtime_set_autosuspend_delay(dev-&gt;dev, 5000);
                pm_runtime_allow(dev-&gt;dev);
--
2.29.2

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------32761223696D3F568AA9AFEA--

--===============0162835042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0162835042==--
