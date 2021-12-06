Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A577C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41B76EA81;
	Mon,  6 Dec 2021 10:56:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBC56E8B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 10:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtWjb7LZVkEdPy2euATJcMjgPRhsDuhYKACdPCp9mDvBPf+ulosLDq8MWV0vja61QKinmjH6jRJdDYNSTKEVsxn6Os/Gcjoho5VDa/xQwOKSGXiDmoEhf0E3Ma8BYozo7CKBIc3y9BO1ODcU1StDG14cDN+eD+6XhLwISV2Uo3SKNA4HeOe3yKS8FKdYW8Akl2spKov84GoJ+0LBPSkgWjFEEgwUt/YFxklHvuMXkwvdbKM3tx5xuUjQ4Ttb5rbkiMHTPzdODL5wH3/eZD4fF4jo1pEUZup97Ws/2ntQlzL8tR/xsVh1BavMT4AYPRzBsSE2Rw0AkgryLFu16d1XBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=914HwkiqFs93n9bHkyZCJuj3xf/RmFRWeUsEghduL+E=;
 b=Hk1kaa4GkAlSfiINzTedoPxF+MoHJ4jIkYYQlzWA2YhU8fcP8kEWbTKQTZEtdfpDcTJ+tO1FyZO+zqsgKSdqy1I+H9lrVEYiDy8q73P4Ll6akgrJGlh01C4L306a867hcTZCov+6KWnARfE5biwYAsSkD3s3hauMd7gSn/YEe6GBhCfU2XTiayLvgf5pmetZhzkNGf8EJDZ1ulkjI5sp3xyveo9VZ0x/L8WLsMgpaIFG0RSB+xtnypkzH6zRpDXGJ+NPZ747KBXNbVY7repWqvFONBzrjGHLnakZ0qXhSXNamTAry1NRstJx3i9VcHVSIkA6LOFmYkDhy6sHF+zfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=914HwkiqFs93n9bHkyZCJuj3xf/RmFRWeUsEghduL+E=;
 b=LyUMik5rJyt/KuVto2vNIhc16CsBCtFTqblBSQ78UOk3g83zX5CiqGCHKzlo/uUS2I7Z+fu5VlaB20P3/hri9ABkeK1Gc1uwWFD4zzEcm5w4Ejpne6NuhS3KBf17yhOctpkGBpDtVKhB3/YhgWPgsDADN8SGTvaOVMCZwnstG5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 10:56:42 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.030; Mon, 6 Dec 2021
 10:56:42 +0000
Message-ID: <8e0b8d8f-b64f-8d17-a877-9a3171b60b2e@amd.com>
Date: Mon, 6 Dec 2021 16:26:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20211202191912.6148-1-alexander.deucher@amd.com>
 <b05f1327-b26d-ac47-4bac-f94979bd3741@gmail.com>
 <CADnq5_OgW3vfG5kjV-67KYc4RxavJeZOWvNEo5vm9siHj2B0HA@mail.gmail.com>
 <79ab8197-890a-494d-6687-de0f3d467360@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <79ab8197-890a-494d-6687-de0f3d467360@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Mon, 6 Dec 2021 10:56:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68b5ca7a-cae7-49ca-2080-08d9b8a715f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1340:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1340651F99E199EE0B1FE04D976D9@DM5PR12MB1340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWhCduBcBuBcZRKk4sngCyoAskTh76+9FRlc3+3Tv69ukTfMNP+mvTdMG+MBYGF9rch55mSKdyeYysMels5GUva/yjkivX6Z4N2vlemlgdf67KEpJnuW1lT0An8xxXKUlfiuaig0TMqTUYUFJ7SZzKgJhmuEWI7Obp42JrR/gBtQA4sYWtgEevRDxBdCiqB8fLrX/sc0VbuUxaIU6FlqPbfAchLayYO8IsGtZtyTgUEndPD1ggaPgi4fkWdewlpYv+g6CtIdRwAg1d/LnDeRh8DM0L6kDAqldB8mDL6mctqWKkgiK+LOeHO1m4DOJAsjJ4sQVxBI1dFWJhp6TcWWSiX1IV7Q1+QMMJTvQT/6O181tu/P8sCcvYgRYGOuq8aRaxg89UsYTKnDjfXEuznSA2TjTS3OwbuCSfKL9docifewCEWDo5p8QO0D+zUxrqrW0drqPj6+TedUSEhKOBKLVVTF2X80ZjWyo/WvMc6bJRIpSScedITsC9Zsfg3QnwOnWeHevPV5qg7FFok8n+LpM/ihncq/5A5A7UbZVmCMbltAvKXIL+gM604aJh/8F8etV8/FoMGI4JK/ZfrdEYA0uCl8MfkqspqaNNxUEWpwdU5+T1kYH3VCa5PEX9BIvMAJo4/+7+dQMYIJDnvsdJkj9DpWoiN4QEv1PsUTnatE8xZBUCAyrx4k+kyC+Us+7/6hpsK8gyKwzCE4LWD4OtRd6OI1Tf87xVHd43mAZOwe6ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(186003)(31686004)(66574015)(2616005)(26005)(4326008)(66476007)(86362001)(508600001)(6666004)(31696002)(66556008)(66946007)(83380400001)(16576012)(316002)(8936002)(5660300002)(53546011)(110136005)(36756003)(30864003)(54906003)(8676002)(2906002)(956004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2diRjBsV3lYeWU3ZVV2VVY2WExFall6U0plOUtodzc1WlhjdzZXUHVod0tm?=
 =?utf-8?B?WnhMVElqdDROQXNwNHdGeE1QTFV4RDhzZUhpMnNQRDlVdGxXKytaUDYzOWNN?=
 =?utf-8?B?L200WC8xOTlnb3ZqQ0lzeE9wVW51Nm45dlAxRUNsOW9oSU1OTTlOQXpoSDFL?=
 =?utf-8?B?aGlwMGphdDVMMHdQOUdNQTg0bWppT2dQM0xOZ2pXN1hNSmhBcG1DZnRlSlFZ?=
 =?utf-8?B?ekg3dXU2cVJnQU1peXVBaFUyME1XYXFDbXpGb09zUWpzdldXbkptOUlJSk1L?=
 =?utf-8?B?Zk1KZ2tqK25ZTzRKVVRxWit5cnJSQmNraGdENFlnNVlJd1R4NThpSEkrRHNr?=
 =?utf-8?B?bThFd0g3T2VCL2w3N2xKY2FwOU5ncExBVXJaeVFLZ3g5QVlBR2EwNEdsWGVz?=
 =?utf-8?B?WHhWVXpLTkRqcG9IOGw3QlZMQU9yRWNQMTNyTHczYy9rRnd2bUF5TkNNVkNt?=
 =?utf-8?B?ODQrM1hoSnMxaVdXVXpwY0hGVElzb05FVTNyYXNPaGs5c1NlMlA0ZTVvcVlG?=
 =?utf-8?B?Vm9EMUZCcmZydDRoRml6RG5LQVlpRHF6Z3prNmpIcHk1RzNtT3R1M1F6Nk9s?=
 =?utf-8?B?L25XbFN2aThIZDhXZ3UrVlR4WFdpdVRwSzJWSUFmaFdPeUpFeG55L1lEdzAz?=
 =?utf-8?B?WTFnRlJJdjNRZEc3dCs4TFhvWmVXRXVvUytXU1FQTzBnMzlNT0R4c2M0MktX?=
 =?utf-8?B?aVhJaVNUUm9oMnFZRzFhVWlSRjFtMnQ0ZlFJNEdMRXFlWm5uWVN1VU5QOWJQ?=
 =?utf-8?B?NGt1Syt1UUhJZHJ6NDU2djArL3VRNW5tUk5WSFlJdHRTUEdLZHk0dldDUHBL?=
 =?utf-8?B?ZmNBVUJJR05FYWZJUWlkYm05ZlppOXp6c0tqODU0R1pjQk5JeHRQVkpxano3?=
 =?utf-8?B?djMzUFhGeUpobVJreXltRmZ5aEM5dDQ4WEZPcklYcUcrWGhkSVB1ZjA1NUQz?=
 =?utf-8?B?TXFCL1dONFEzVThyWGdjdFg0dXVFTEs5d1YwZ1Q2VmQ4emcwdFBXSWljUzN4?=
 =?utf-8?B?c0wzUVZFSFBmRWp1S0tFZmdsV3lQVGFja3cyK2MrK0MyL1hoSlRtNzRvN0Ji?=
 =?utf-8?B?MHNGWlJEZW5iSmFSWUtxV3RSSllDWEMzcElTUlNtZVlxV1lPaU4vT05JWVV1?=
 =?utf-8?B?OTZxNHJxU3BQQUdhdDJPSUJWUGQrdlVCS3hqYnZhMFRFbmtIRk5xTHE1NFRU?=
 =?utf-8?B?R3UreVozb2I4TFNaRjBZWXZ4WENhb3p2cWg0SFRqMzZvQzJsVFBBWmtkdVJD?=
 =?utf-8?B?U2dsTUd6SEo4ZndqSWdqVGpjNUdMWFJNdlRZWW9OK0NZR3VSWXNrWHh3MjRl?=
 =?utf-8?B?OEQ5MWFQTmV5NExZcjd2Rm03dVIwNWJyZ204cWhJV3RQL1l4ajhIZ0M1RGRi?=
 =?utf-8?B?QzI2MHA5eXFyMVpTbnBFWWlJQ1dRZnlOaGg5NDVvUmhqRDRwaElFeXN3Ymxi?=
 =?utf-8?B?T1BUdWhsc3VpNEJvQjlxQmkvcmlKZzRxcEdIQ21rL2g0dFVkakhPeWdrSGk2?=
 =?utf-8?B?Rmh4Z25XK1VObUtQUy9iTytIMWVOQnhiZ2xTR3hJcmpZY2JBalV3Vi9qbjRt?=
 =?utf-8?B?c1NYWHdOR3phVXRGcEl5TGR3ME05a1dBNmxEaUNSZStTZ09UVzNyeVJCWTFJ?=
 =?utf-8?B?RlE4RWNORGZ4VTFCL3RDL3FhSVRUV3dTYWhqQ3E0VHd1cUhZc2JiUkd6NGI2?=
 =?utf-8?B?NDBRL1B2NzUxRWFSaHc0SFY1Ykc1MmVVQmpEUUM0SHY3RVozUEVtb29PNHk5?=
 =?utf-8?B?bTN4UzRDalFRUGVDWEFtR0RVN25wUWQzZm8xWHJyOThBVGtnTmhhMW40bi84?=
 =?utf-8?B?R0Qyd0lHQWV1dXg4Sm9nQTZnR0U1L1VDc0gxMnYvVXgyVDdPUlZxcGlnK3Zx?=
 =?utf-8?B?UjJmM2ZvNVZFbkRZa2R5NitJc2FjcUVXUlg3UktXSnZuMXNxbE1sU0d4MGhm?=
 =?utf-8?B?c0h2VTJqdy91VkxhM0ZKRUplcG5nS3BSNFR4OVZzSEljU1RSK01jZmhQY1VP?=
 =?utf-8?B?S1lPREFoQVNyWGxZYmxtbFBYQWpRY2NEM2N6NUppVjRlTkZWNEIybHZhbTMy?=
 =?utf-8?B?bTB5VWw3aUVDaFc1bGdHaEpnWUd3MjZ1akRQb0RxbmVXTUlMRUdEMVVEKzRQ?=
 =?utf-8?Q?Wm1U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b5ca7a-cae7-49ca-2080-08d9b8a715f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 10:56:42.0387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVRN2OkF0JdQj+OMLKTbZicm5xmccPehAK/cDIOyw+Xky9suM8TOqba1eVN8n2AX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1340
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/5/2021 2:53 PM, Christian König wrote:
> Am 03.12.21 um 17:13 schrieb Alex Deucher:
>> On Fri, Dec 3, 2021 at 7:15 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Am 02.12.21 um 20:19 schrieb Alex Deucher:
>>>> This adds a new IOCTL currently used to implement querying
>>>> and setting the stable power state for GPU profiling.  The
>>>> stable pstates use fixed clocks and disable certain power
>>>> features in order to get accurate pipeline profiling.
>>>>
>>>> Currently this is handled via sysfs, and that is still
>>>> available, but this makes it easier for applications
>>>> to utilize.  Note that the power state is global so
>>>> setting it will affect all applications.  There are currently
>>>> no checks in place to prevent multiple applications from
>>>> using this interface, but it doesn't make sense to do
>>>> profiling while you have multiple applications running in the
>>>> first place, so it's up to the user to ensure this in order
>>>> to get good results.
>>>>
>>>> This patch add an interface to query what profiling mode is
>>>> currently active and to set enable a profiling mode.
>>> First of all I wouldn't call this profiling mode. Profiling is the use
>>> case, but performance and power management are what is controlled here.
>>>
>> Ok.
>>
>>> Then we already have functionality for process and context priority
>>> override for the SW scheduler in amdgpu_sched.c. I think we should add
>>> this functionality there.
>> I'm not sure I follow.  Do you mean to integrate this with the
>> rendering context?  That was what my original patch did (attached).
>> Or were you thinking it would be better to make this part of the sched
>> ioctl?
> 
> The later,
> 
> The scheduler IOCTLs are all about adjusting the default priority of a 
> process (and optionally a context as well).
> 
> Putting the hardware power management control alongside that kind of 
> makes sense I think.
> 
> Something like AMDGPU_SCHED_OP_POWER.

That doesn't make sense to me. This is not optimizing scheduling for 
power. These settings are applied to the whole hardware. Even if we 
assume a hypothetical case of 'no-scheduler' (only one app running), the 
settings can be used to figure out whether an app is sensitive to GFXCLK 
vs MCLK or which phases of the app are sensitive.

Thanks,
Lijo

> 
> Christian.
> 
>>
>> Alex
>>
>>
>>> Christian.
>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 
>>>> ++++++++++++++++++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
>>>>    include/uapi/drm/amdgpu_drm.h               |  28 +++++
>>>>    5 files changed, 173 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> index 7fedbb725e17..4cf5bf637a9e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>        amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o 
>>>> amdgpu_nbio.o \
>>>>        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>>>        amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
>>>> -     amdgpu_eeprom.o amdgpu_mca.o
>>>> +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
>>>>
>>>>    amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index bc1355c6248d..0e27f9673f8f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -46,6 +46,7 @@
>>>>    #include "amdgpu_sched.h"
>>>>    #include "amdgpu_fdinfo.h"
>>>>    #include "amdgpu_amdkfd.h"
>>>> +#include "amdgpu_profile.h"
>>>>
>>>>    #include "amdgpu_ras.h"
>>>>    #include "amdgpu_xgmi.h"
>>>> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc 
>>>> amdgpu_ioctls_kms[] = {
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, 
>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, 
>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>        DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, 
>>>> amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>> +     DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, 
>>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>>    };
>>>>
>>>>    static const struct drm_driver amdgpu_kms_driver = {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>> new file mode 100644
>>>> index 000000000000..94fe408e810f
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>>>> @@ -0,0 +1,112 @@
>>>> +/*
>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person 
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the 
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without 
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following 
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be 
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +
>>>> +#include <drm/amdgpu_drm.h>
>>>> +#include "amdgpu.h"
>>>> +
>>>> +/**
>>>> + * amdgpu_profile_ioctl - Manages settings for profiling.
>>>> + *
>>>> + * @dev: drm device pointer
>>>> + * @data: drm_amdgpu_vm
>>>> + * @filp: drm file pointer
>>>> + *
>>>> + * Returns:
>>>> + * 0 for success, -errno for errors.
>>>> + */
>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>> +                      struct drm_file *filp)
>>>> +{
>>>> +     union drm_amdgpu_profile *args = data;
>>>> +     struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +     const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>>> +     enum amd_dpm_forced_level current_level, requested_level;
>>>> +     int r;
>>>> +
>>>> +     if (pp_funcs->get_performance_level)
>>>> +             current_level = amdgpu_dpm_get_performance_level(adev);
>>>> +     else
>>>> +             current_level = adev->pm.dpm.forced_level;
>>>> +
>>>> +     switch (args->in.op) {
>>>> +     case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
>>>> +             if (args->in.flags)
>>>> +                     return -EINVAL;
>>>> +             switch (current_level) {
>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
>>>> +                     args->out.flags = 
>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
>>>> +                     break;
>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
>>>> +                     args->out.flags = 
>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
>>>> +                     break;
>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
>>>> +                     args->out.flags = 
>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
>>>> +                     break;
>>>> +             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
>>>> +                     args->out.flags = 
>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
>>>> +                     break;
>>>> +             default:
>>>> +                     args->out.flags = 
>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
>>>> +                     break;
>>>> +             }
>>>> +             break;
>>>> +     case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
>>>> +             if (args->in.flags & 
>>>> ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
>>>> +                     return -EINVAL;
>>>> +             switch (args->in.flags & 
>>>> AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
>>>> +                     requested_level = 
>>>> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
>>>> +                     break;
>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
>>>> +                     requested_level = 
>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
>>>> +                     break;
>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
>>>> +                     requested_level = 
>>>> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
>>>> +                     break;
>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
>>>> +                     requested_level = 
>>>> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
>>>> +                     break;
>>>> +             case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
>>>> +                     requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
>>>> +                     break;
>>>> +             default:
>>>> +                     return -EINVAL;
>>>> +             }
>>>> +
>>>> +             if ((current_level != requested_level) && 
>>>> pp_funcs->force_performance_level) {
>>>> +                     mutex_lock(&adev->pm.mutex);
>>>> +                     r = amdgpu_dpm_force_performance_level(adev, 
>>>> requested_level);
>>>> +                     if (!r)
>>>> +                             adev->pm.dpm.forced_level = 
>>>> requested_level;
>>>> +                     mutex_unlock(&adev->pm.mutex);
>>>> +                     if (r)
>>>> +                             return r;
>>>> +             }
>>>> +             break;
>>>> +     default:
>>>> +             return -EINVAL;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>> new file mode 100644
>>>> index 000000000000..cd1c597bae11
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>>>> @@ -0,0 +1,30 @@
>>>> +/*
>>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person 
>>>> obtaining a
>>>> + * copy of this software and associated documentation files (the 
>>>> "Software"),
>>>> + * to deal in the Software without restriction, including without 
>>>> limitation
>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>> sublicense,
>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>> whom the
>>>> + * Software is furnished to do so, subject to the following 
>>>> conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be 
>>>> included in
>>>> + * all copies or substantial portions of the Software.
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>>>> EXPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>> MERCHANTABILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>>>> EVENT SHALL
>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>> DAMAGES OR
>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>> OTHERWISE,
>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>> USE OR
>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>> + *
>>>> + */
>>>> +
>>>> +#ifndef __AMDGPU_PROFILE_H__
>>>> +#define __AMDGPU_PROFILE_H__
>>>> +
>>>> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
>>>> +                      struct drm_file *filp);
>>>> +
>>>> +#endif
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>>>> b/include/uapi/drm/amdgpu_drm.h
>>>> index 26e45fc5eb1a..b6edf4a826f9 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>    #define DRM_AMDGPU_VM                       0x13
>>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE  0x14
>>>>    #define DRM_AMDGPU_SCHED            0x15
>>>> +#define DRM_AMDGPU_PROFILE           0x16
>>>>
>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP   DRM_IOWR(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>    #define DRM_IOCTL_AMDGPU_VM         DRM_IOWR(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE 
>>>> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union 
>>>> drm_amdgpu_fence_to_handle)
>>>>    #define DRM_IOCTL_AMDGPU_SCHED              
>>>> DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>> +#define DRM_IOCTL_AMDGPU_PROFILE     DRM_IOW(DRM_COMMAND_BASE + 
>>>> DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
>>>>
>>>>    /**
>>>>     * DOC: memory domains
>>>> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
>>>>        struct drm_amdgpu_info_video_codec_info 
>>>> codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>>>>    };
>>>>
>>>> +/* profile ioctl */
>>>> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE  1
>>>> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE  2
>>>> +
>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK      0xf
>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE      0
>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD  1
>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK  2
>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK  3
>>>> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK      4
>>>> +
>>>> +struct drm_amdgpu_profile_in {
>>>> +     /** AMDGPU_PROFILE_OP_* */
>>>> +     __u32   op;
>>>> +     __u32   flags;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_profile_out {
>>>> +     __u64   flags;
>>>> +};
>>>> +
>>>> +union drm_amdgpu_profile {
>>>> +     struct drm_amdgpu_profile_in in;
>>>> +     struct drm_amdgpu_profile_out out;
>>>> +};
>>>> +
>>>>    /*
>>>>     * Supported GPU families
>>>>     */
> 
