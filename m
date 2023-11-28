Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2A9C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 15:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AAE10E560;
	Tue, 28 Nov 2023 15:00:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02D0B10E560
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Nov 2023 15:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnLhZ8k8GGQqO9G3vY4hIZiCceTZ0uXNYU8sEK3QsRWyTlDDd2ZA2YDqQk40Ll9Zs0Ar2OP755r6pOS36xDljlaYvjrB++MND+eiSH/Eg6j2kgYdNKA1KOSZgez6IJJekHQnEy1DWFsX2mrg3gGPo5pqQBH9sStPFgh0AGELZ5/q4s1p2In6/HplcS4nIZa0ZiCyKwOOoqWVhbc4uepItUWNt0Rpu68unJG/OpZbS/LB7o98zrVDilbTqDbtVrB/Np0iDXNv5ju0oOGZ8qCLPeUkPPPxs2x04dEIPXb120nQTQ3b8HknDe9TeqUpFNutIGmRPQ2Udj6XVX6V5380/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTqniOpa4btowbFYgvnoa2Kh9shBapBvPMYw4rv62H4=;
 b=X9GTxK8/2HNrkqFcwW7jwCx1BP9uKI5StJusxc2hOt7Icx8PQCUrdUtSK0VdOd3eSoQXIn62cDeA7ehgv1I+4gzixF88LJlqrFXTi7XgdUZduja2El3GHTwIocT68IQIUInm6eKR7Xw/RPB2d5L0DnfU+50rumE55j0PphwYzCW0fgjNbtFBmWV1bAZS0+Ni9avSOSeN0NgFppNtFwuxbjQQLCqSpr7JfKV3D3Fjzp4qpLZSGg7iuzJUJG1igj6qfDzDLYUrTNpinJdH4QGrDAUnbNvb/laxQRtBQjWIs9uaaC7RTEb7S8V4cfizpk8rw0uXlEVpt2BrEDa9Dkvlcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTqniOpa4btowbFYgvnoa2Kh9shBapBvPMYw4rv62H4=;
 b=V4W7GU1nhuUlUFwjwuDYv774ClMm5qTZoG7hDaxyPuKISCRgqD3YqQ6Nuu5olvamhhQ0w6fbkLhjG7DCR+V2BIiiL4H7zQvhSeJzD/2fco3WeFltM5v1qvnc7mik4qQI1NruFIYS0pgLqWLeX2Vh9thEFMdVIYcl7sBa9PiDZjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 15:00:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 15:00:19 +0000
Message-ID: <4558e54e-f0e9-4810-8c49-437b588f2d72@amd.com>
Date: Tue, 28 Nov 2023 10:00:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix uninitialized return value
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20231127182945.1109556-1-lijo.lazar@amd.com>
 <ac4bc87d-7ae1-45d3-8f85-0e294289ad3a@gmail.com>
 <CADnq5_NA0fi8cGvrSzCtmtsWpgKhaG4O8T6cW+ObJoCm=iwzSQ@mail.gmail.com>
 <1c1877d8-c062-4648-950b-4e05f568b356@gmail.com>
 <a61886fc-358c-4f89-961d-8145f70d31ee@amd.com>
 <4664a573-da9a-4d48-bee7-4b2bef3081b6@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <4664a573-da9a-4d48-bee7-4b2bef3081b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 657f52fc-42ab-44e7-6937-08dbf022bcd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7YbbN8wy2wlFtZpIHnaCX+JqTbF386sKLqK0dhDC3KGh3Wn8cDJtcwW7asbEk2PQK9RF1VhmVkjhjR+0c7qMSlQsHIy+dGVuPTTJocaD3xh0If2nt5s2R7p7DdKETrozmOZA6M+KfoUVrmuMxwMNopRDcGY/q3QVc7BsrylglLMNC+3KDOsiMtw+nsfjmb9+cpU5MYl+3pP3yn4DW0nGcgvBU1frXRC393uRcJQ7S+xYhVSot24G2ukZqB84o+0APwr/4zumD46XucC7+fn3hl1BG/h0VpZC5lU0sqjoxnlHIXsM3wKMUmlfFGY+H6HmsViVbG7FdV8q/d5Mrrsf1r24tUxq2vavt23flF8PV3zE6mdn4r9Fv6UJs37N1TpU+z46/56pbiR7jdIVz//RfCPZ0jHYoFfXixjRPQ5iVCrDQucxENIQ5dz/Zw297V2af8kfH4X8nqiolYhn2ANQL3+rJAhx5evu428kDC2uRJW12iWiNcaF8eiHfN9zjdtcTnnU+pdtiqy0wl7FVbrS40WLQZXfYvmQyGTmQD62as3/E2qLFmpiUqdCiSJ3+23giuHpCjs+U9Sqph1RSoBGm9W3gdJK/KC/4bbQQQk8dZy+QqFpfgiBpxl8Y7a+VqBTnkk9MR6Z80+znlKeulWcu8Tj7ttvOujfbWKqs8/9/AYpOkAP/xskvknoMwb1U73
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(86362001)(31696002)(41300700001)(2906002)(4001150100001)(6486002)(66476007)(26005)(66556008)(2616005)(66946007)(110136005)(6666004)(6512007)(6506007)(53546011)(478600001)(8936002)(8676002)(4326008)(83380400001)(5660300002)(36756003)(44832011)(316002)(66574015)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmdBRU5UZ2tRV1VvSVBmb0h1UktNaDlMSjF2Y2RJejI0SHJLUkhyaWhmb1dy?=
 =?utf-8?B?cUduZUFIanJiMEQrY080NGY1VFdLWGVnTXdweThPMER1VC9hU2VPQWRUUXE0?=
 =?utf-8?B?YWFIbkpiaGhDbEJBUUszcWZrd2x5VzJ2cHNWTi9NbjZHVFpueW1XQ1J0SUdZ?=
 =?utf-8?B?bHg5YkRhZkJTM3FNRTRaT1IzZXBoTS9qRS80aFhiQ3I1SUxPVnA3WDVQRG1q?=
 =?utf-8?B?TGhSdEFnWFJRNkRwOUdWZVpwNHpsOWVST0c4K2Z6bkNWdlFCc2QzMG00MXNi?=
 =?utf-8?B?Z3lPUFZRUlJsVTZMWXVzSVNUUlAyNzJ4UGVTTERqak4zOW1teDlURDFPQlB6?=
 =?utf-8?B?S3JwS0hkY0F0QVBvWmVrendWQk1jd3pMTHlrdnV5MnVxMEY4WmxEcGR3R1Rh?=
 =?utf-8?B?QTI0VGg5d3ZrRkxWRmFiRFVKdW1IOWJtcW9ybDJrOGFqd01OaVZ3eHZoamxQ?=
 =?utf-8?B?MVNSLzQ1endaQU90dHpWdTBheXJnYXI1V0dsL0dXV1hCZHVqbmZ6dkNRaUxz?=
 =?utf-8?B?UXA0UFhNcVJVNmlEaU04alN3Uk5UdFZaYytPNTlGcXdBclQxU3R0RS9aZVdJ?=
 =?utf-8?B?RUtQb3ZKK3dvbHg3V3hETlpiTVM1Ukh3Y29MRStTMVN0REorb1N4NEtCclRD?=
 =?utf-8?B?ZWFmOFJPRDdPWTBELzJXbnVUTktkSE84MHFET1lNMWtVVDFJb2JUNHhFM1RY?=
 =?utf-8?B?Wk5zVjlia0xZclBsWGlXNWRiR25mWVNJMmlGb3pqcFBrZnVrUE51RTZQRW90?=
 =?utf-8?B?Qkt3dmRJTnJNMUhTS3U2TE5ZSDV5YTZBTjY5UGRFcDVsTTBpZUlhZjFlRGV2?=
 =?utf-8?B?OGVtQXZFOG5TckQvNiszUU1aN1owL1BPSlBPNHdtRzFuaDB1cTdsS3JnWFhV?=
 =?utf-8?B?cml4ditBV2pUTkZnbmdYSWhqTzN4MnZuRVVNbWZ0Wlc4b2FRNk1GVXhOb0tH?=
 =?utf-8?B?WEhyeDFqNDdiQnlLaS90Qmx4VVVPdENyYW13WEVGam5DaTQvZWwxMlh4RjY5?=
 =?utf-8?B?Y1prdTEwdUFJbkdIb1ArNGdoMDJhMGFGbm9abVU1NlQ5YXY1U0JnN2xqN1Nl?=
 =?utf-8?B?YTFIRExwbnBFVVRBeVREY0lGSXdneXVzVDNZdTRUMkZXM1owTThXZzg0Z0Vp?=
 =?utf-8?B?ckxkTDByQk5GcUZ1VDRUMnI0Q05wd01MaUkwekpPWHpwZlBHcWpOeEJNZm5p?=
 =?utf-8?B?ejZGTFd4bkNvWURZWWdSUHZJWGdNUHUxdXJqSnk2WEphc0IrMzNpdzNjM3o5?=
 =?utf-8?B?alFwREErNjBmcEVrL01qd2E4cnJNblFvak9nVUtmQnZ4YUNKZ21xL3pYeVFh?=
 =?utf-8?B?dVZmeE8wcTY0UTIxVVI1SlZydVhKMjBCeUNwMm5JUk9PRDFPVS9xalJyZkFO?=
 =?utf-8?B?M2hnSkRQd0JCUHNDWkVEMFlpR09UbEZ5Y0RraE11VHJLUzVWQjNTVjlNb3Nn?=
 =?utf-8?B?TEVLb0oramJHV1d2QmR1cXVOa2xKVU5OdS9pcTJTc2RmSnVuZk9taUg4Yy9O?=
 =?utf-8?B?V3R2NCtHMDNDdlA5bkR3bUQzN0tZQmpJNmNxUzVmWGpLbWxxblN0RE00bk1z?=
 =?utf-8?B?ZVk4QlBjcHlyNnRIZFpnVndCQjFhTHZVVUNrVFd6a0E4bmhseWNKMEhTaTdr?=
 =?utf-8?B?S2xIRmtsVC95TXdlN3p5anZGZUFGRkxUa3hLendUdGFadjIrMGF2b1VSNnFF?=
 =?utf-8?B?bWxGZUhmY1RxenVGbFpFL2VmaXgwbko2VXMzSURJakFMQkZrdUl1aGZkd05G?=
 =?utf-8?B?WTJJeklPanpiT29pQTZCYndBOThTMkpFdkFXbW1td1FwT1lsSHIxSnhKWUZx?=
 =?utf-8?B?MU5YWW5IVS9Fenplb04rTlgyMENFSkw5bENZQW1zdElUdGVyRkpNOGR6ME9r?=
 =?utf-8?B?bVBjb1JBMEN6MnA5RVBaNm5zRm9UVTBVRHg3WkFaTnhRSHFNSGhXYlhZR3JK?=
 =?utf-8?B?ejlZSUxMc0krM1g5RVkybVk1VmdGcEx6VzRxQ0tYeWZaQTMzYlNFVFU2em03?=
 =?utf-8?B?ZmV0WW52MjNpRFRNYzN3ODgvRXJkQktIOEhERW9odzR3aG8wYi9MUVcrK3BC?=
 =?utf-8?B?K2JqdjBlZ0FnNE5iZE5EQVJmQ3FJM043dnZYRmxnM05GUElMSnZHZW1nOG5a?=
 =?utf-8?Q?BHrUZBvqkhsLpQ3qhTutT58S0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657f52fc-42ab-44e7-6937-08dbf022bcd8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:00:19.2057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFSbNNiRanPnGNoZSdJkwB+q2tDIXtzkJjjE7t7cgCLi/ruLZTy6oAiH/1m8t7jJ78YFlqdnryblq9Gqa4csHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-28 8:18, Christian König wrote:
> Am 28.11.23 um 10:49 schrieb Lazar, Lijo:
>>
>> On 11/28/2023 3:07 PM, Christian König wrote:
>>> Am 27.11.23 um 22:55 schrieb Alex Deucher:
>>>> On Mon, Nov 27, 2023 at 2:22 PM Christian König
>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>> Am 27.11.23 um 19:29 schrieb Lijo Lazar:
>>>>>> The return value is uniinitialized if ras context is NULL.
>>>>>>
>>>>>> Fixes: 0f4c8faa043c (drm/amdgpu: Move mca debug mode decision to 
>>>>>> ras)
>>>>>>
>>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>>> index 1a8668a63e67..f6b47ebce9d6 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>>> @@ -3410,7 +3410,7 @@ int amdgpu_ras_reset_gpu(struct 
>>>>>> amdgpu_device *adev)
>>>>>>    int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, 
>>>>>> bool enable)
>>>>>>    {
>>>>>>        struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>>>> -     int ret;
>>>>>> +     int ret = 0;
>>>>> That's usually considered very bad coding style and complained 
>>>>> about by
>>>>> automated checkers.
>>>>>
>>>>> Instead explicitly set the return value in the code paths not 
>>>>> actually
>>>>> setting it.
>>>> In this case, the function is so short, I think it makes things less
>>>> readable to do that.
>>>
>>> Yeah, indeed but that doesn't help us with the coding style checkers.
>>
>> Are these checkers for real? I see many instances of variable 
>> initialization including in core kernel code (ex: workqueue) code.
>
> Yes, I've got multiple complains about that already.
>
> What people basically seem to do is to search for patterns like "int 
> ret = 0;... ret = whatever();.. return ret;" with cocci.
>
> This then results in a note that an initialization isn't necessary and 
> should be avoided.

Isn't that the opposite of defensive programming? If you write your 
kernel code in Rust, all your local variables will be implicitly 
initialized. In C you have to do it yourself. And the compiler is 
notoriously inconsistent warning about uninitialized variables.

Regards,
   Felix


>
> Same for things like return after else, e.g. when you have something 
> like this "if (...) { ret = whatever(); if (ret) return ret; } else { 
> ... ret = 0;} return ret;".
>
> Regards,
> Christian.
>
>>
>> Thanks
>>
>> Lijo
>>
>>>
>>> We could do something like this instead:
>>>
>>> if (!con)
>>>     return 0;
>>>
>>> ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
>>> ...
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>        if (con) {
>>>>>>                ret = amdgpu_mca_smu_set_debug_mode(adev, enable);
>>>
>
