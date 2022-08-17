Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE741C28B2B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 14:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A240D944D4;
	Wed, 17 Aug 2022 14:01:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957F894458
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 14:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3Rv9Gl0jfGL5t+bONIrSLdi/yZVbGUqQypGkTzqSHqOB4yeuJRENVW1x2pANxBso7OGqKHPUsqMsdUN5cFHMRtjYbnpLq6dy0B/bGBohV4Sn0Vwgh8gN1M+1rQZaaVroB60TrwH0/iWTuu0YhHa5jouUktzW7aaCE3zGe2NH+nfk9ikIpTBY5zK8F/llmJSrlExA4UGE2dQjk6TR3bKeoRv5dAO1nReRPUPhtqN88DgSBiCEoeMAT079W1Sw50sDe28mymwUjAAax+AyvuZzKMJhg5SgWY9kF7h2UfMF9J5tjV57BqsjZpuafeu4B72MmFRk6qPyAO2dSu1dOwk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbgEM/adtFEungrhDHt2dDoXu0KCooylBYdtHnlMafU=;
 b=AOeoJQ1FB9aIdaVUFBhyim3A0X/co2kXONBehD1CgLGee+lXAaQHc913NJS6XtdrdSARf8Fbm89sTK5tSzTpbSKujZDGwDBphlJMExGfwdAzAP7LGfobA1MeKHqjQ9NRSKgtvtjbBqlemAbC62R5RvfSWrRo56xuCFGcvWOiay8dCdK9rmzbAJVhylNgjO1sqz2b6tCzJ/Zih10hwcZE4FdeFPBCqaOflUyR3Vkiyj2+Oh5Lj/TiByhBnPQpIafcoHltPFXZGcv29q3uajj9DIZZHBmOloeoreUtQN0vdALasyp6tTNNd0ZBPb/J97phm5ZArAS49EWA+OpdyqevRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbgEM/adtFEungrhDHt2dDoXu0KCooylBYdtHnlMafU=;
 b=fObO9eiCHjAcWFHdDZAa2GvwXmkh+t36Dm2b3hiOBHBxG2pqZuGvP5fCa7niHhT26Bx4to4ae50ItW6xRhd6BjPCkHpceen9+3FoVQF3ZI0FRHwpLvS1jOLwsnFchgbyNOcWud0cQPVHJBEb81id8gCijHe5hitJ3y8rR3+DXX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1125.namprd12.prod.outlook.com (2603:10b6:903:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Wed, 17 Aug
 2022 14:01:30 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 14:01:30 +0000
Message-ID: <fc69f557-5851-c1fa-da6c-435fdb13241c@amd.com>
Date: Wed, 17 Aug 2022 10:01:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: TA unload messages are not actually sent to
 psp when amdgpu is uninstalled
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
References: <20220815070512.452430-1-YiPeng.Chai@amd.com>
 <CADnq5_NLzjD+4q0vF8n8JRaOf3iiGYoNN+W9K3FPLEP+_FHjUg@mail.gmail.com>
 <CH2PR12MB42155B12C1A2C1D7101EAA2EFC6A9@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CADnq5_NyNxCdJOC6d0du=+AAYA13xCFVXZRjsXEJT_rXSQTm-w@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <CADnq5_NyNxCdJOC6d0du=+AAYA13xCFVXZRjsXEJT_rXSQTm-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::21) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd76985-9730-464d-f759-08da8058fbec
X-MS-TrafficTypeDiagnostic: CY4PR12MB1125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aoS59L1ja+QtVKEDlvDJJJ3AUEU0A5WurRsIsd2H9p5N65JXL6Y6J8RgkhUXjrZTq9TbPAIwwEK7d5kgS4kSkBU918WPIin2EIZvbHHyKDztDACEcrEEikCK/mku+NPdgqEF7Nqm59CMuNDsNAqGaQ2doXekz0mH8DobxgOe1VKWw79l8B3NfdtUNag4CXAqaVMuqBNal2SHrtvXqTrbE7Fq5ZK0ISd6uf/hJ5UW6VRstxHDErQUGXXX1enQc4/hx67wLjF6qXm3MEE0YuYgouMkDk1nh9t21amrfXe8EPYbNOHkTnBEcTTnoJTiASi3opukfsp+4Q8tmiytNakdq91do12cTOxVdJmR1cCfQzOmMIViuy95iuOXbAFvaDVldwSG8OQXTzWseJ6GIxwL2jBdyVbKrBX2Yz/6uiPWAC4h1vxZIqB4YiYKu1agPdaKSDXL8nuo+CQjANdLlVlkSwDTUKr13D/4HmPWFYnAnUByqyO4INtvDfndoVRMdcw2XZgPAO7lWgHHiiDfVWllerKsdLYAgIEKzSYFmyD5zsqyF6Yhg2XsYtEes9u6E3tzqotAhh0x95hjYLvukr0XxcfySqgwGlrkhShN/HEfpAW6UWNQl9S61BtCR5zF8MR978t7+DxqjAbiF1Zh7kw8Qt5GuYaJQtIciKUK15E1fpGFt5xSRslj6Lc+gZ8AwZU6EqXGu8CmPzsw98MnBaqBf0mtwZTtGQMDHYx5KdVhikIqkX6QrUIuJH4hXnEbb4V1FE/OLeh+T+7dSchWB+u2q/5n4j0ai90gdkjC/qyanBFRVcfhwlhQj/1rfDKBiSSnW9gcg7Uj+fa3CKRJQTYLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(6636002)(6512007)(478600001)(186003)(6486002)(2616005)(83380400001)(66556008)(4326008)(8936002)(66476007)(66946007)(316002)(36756003)(54906003)(110136005)(31686004)(8676002)(38100700002)(2906002)(15650500001)(44832011)(41300700001)(6506007)(31696002)(5660300002)(53546011)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmxBU1REU3NleHJaMG1YWmJ2a0VtbFdYRFZaRzN4MU1zK2F3MExodXNuVkdJ?=
 =?utf-8?B?blpuSWhFNkZyN0M3MFhERDRSOXlKTi80cWhtZDMwYVY4enNkdUNCLzNkMmZD?=
 =?utf-8?B?bytVTC9YVXA2KzN0VE5oZlFYY2RlNGUzcGtCelZEWDdYRnJ0OXVDTEZLMERr?=
 =?utf-8?B?eXdRaWpFN3pvV2NiWjdoRTdqVmJmU0pDWXY0RGY2eDdLSllGZTJKTEowVGpY?=
 =?utf-8?B?c0wyZTdHaEpOdzJTbkFQMFBGcXZoeHc4SWRhbzRRRk5aZHMzbE5QcUVJN0Nt?=
 =?utf-8?B?d1daaXRDaVUzRUFSek1mWGZxZTd4YTd3bFZDZWlEcmVvNE1MSlRjOVpSYTZD?=
 =?utf-8?B?Y2VuTkNBTWg2NldhaUViRlFaUC81YzB4bVU0Z2RaZE5mN1BsdU02eWJncE1m?=
 =?utf-8?B?ejVORVo4TXAxWkMzejN4YUZhTWpSbmw1Qzl3RHVlZGplNk5nU1RseTBxTzg2?=
 =?utf-8?B?RDY0aFk2cGhGWXkrRVNKUWYzRlZmd1lCdEJKUGRjSjQ2R3JLSi85cnhzcisv?=
 =?utf-8?B?S2dtV1BGYzBjTldBeGRIakdKZVVUdVRQcVBVL21RbHAweHR0b3k2bnhDVzdh?=
 =?utf-8?B?b1dVdkRuRUVXSjRrWXhhU1Y1OUJiU2dSK0lJMXlURDBqS041SllheDVIaGhM?=
 =?utf-8?B?TzdxVEFHenRMRXQ4ODgrbTd2YWFqblRlV3JTc1JXOVZBMVNTRmszZUlObGRk?=
 =?utf-8?B?cnc3TXpiS1Nmay9HR053U1hVREJITmJuOExkaWpqckdnTmVuQUhyVGZrUW9C?=
 =?utf-8?B?SGdqUWo2V0N4VUNOZDJUN2VPa1F3Y3NsbDJFbnRaVE5SaWpSdzBJclV3TEJU?=
 =?utf-8?B?enFsc3JFSlNta2ZQM1JRdHlabWlKODRSSldEU1dYUW5jSWtNaWlSRG1rc3oy?=
 =?utf-8?B?bGxtQ0pCRm5tR3NBUUpEcC96NmpKZHlHK2pPZ1VsQWZidUxTL1ZiNC9PeGw3?=
 =?utf-8?B?aEhKRmRyaXZJc0VmVzhCM1dOSkd4M05NVkZNejFmdndVRWpwMjZnZTBFVlRC?=
 =?utf-8?B?R1NnendEUjdkU1Fmc2ZTbjAzL3k0bi85dnRuT2ZnclhaSHRPWGg0aGZaY291?=
 =?utf-8?B?T1pYSmVUdjVMWEVWcllpTEttQ0FhNVZXNElUTTl1b1A3Lys0U2lwUjJwbG1j?=
 =?utf-8?B?UWVZMGhhV1hwamQ2RDFhOVVHVlpscVE1bTN0UEw1QUVUYlMrZEYzb3NhbGpQ?=
 =?utf-8?B?U1ZHTitqa0doWXFBWjQ3NGNXeGdkMWZtSytMaThkREd6Q1BaY09teitETFhE?=
 =?utf-8?B?cUxPVk1vaHN3L3NGRWVuMGYrY3hjV2Iyb1ppZEdjYnpGdjkzdFdoYktJQm5M?=
 =?utf-8?B?NE1GekMydmNtYjJ3Skt1VjFHU0xkZGdDajVDeHZRc0pzeU93dHlCLzRtS0ZE?=
 =?utf-8?B?U0JGZTFxdC9PUVcwSWI0cTMzbm0ydkVFRzJIM3NYc3hMTjNZZzc2SkdSMG8w?=
 =?utf-8?B?YUI2ajVvTEIzRFo4elhQN285YmV2MjRZNExlSmJGZkU4U1o5NGV1Z2ZLQUha?=
 =?utf-8?B?SUk0a0JXOFVRSkF4S25vNzF6YXk5QWlUTXBwU3pPZGRySE1hY1lzbnpXRElT?=
 =?utf-8?B?eVQ5d2FZMG9hQ2ZGay9hbFdlbVZEMnIxWE5VMTVPKy9vWnp6bGJBYWVVZGJZ?=
 =?utf-8?B?SmtrRm9OdU1VSENuOUhGcnBZcm9iUlVNSzNKTmRXUVAyRXIvRlRMOTVZZEpB?=
 =?utf-8?B?Z0ZleFlGRXRaSUtycCtwRkd3dXY0WFY3VGdKdldlLzNMRzBVdXpTbklEclVK?=
 =?utf-8?B?R3JVUW1NbGR6YldYZzVPQjVWTFI5eGMxWk01Yk83L0ViSkE2Y1MwTjdqZytY?=
 =?utf-8?B?UE9LNnJmek9XdTIwZUVjLzhFcGpXM0xFY0JJc1V5VHo0S2t4TFl2LzhTNlZY?=
 =?utf-8?B?aWNDV0Jra09iVjdtUW5MSEFYQVYxc2kwWDRpeUYzUzdEcWZSZjZYTkRLeTg4?=
 =?utf-8?B?UHlqM2ZyZ3dheVRiTFpjMzlCWDVJZm5CUmdWUkN1dVl3Zk5vdmh6dHZmSHhK?=
 =?utf-8?B?MGpHcDhxVjY4YWtRbWRCb3VSZEQzUUlESUdmZ01aMFZtZ215RldkN3VDMmZ1?=
 =?utf-8?B?ZW4wOFRLL3V3Rjh0K2k0T2N2S1g5VFEyRWgxYklHMHZzRXBLSlBXUXZNTFor?=
 =?utf-8?B?Wm8vSXBHRmxISFZnVWU1NWR4b1pSTlQ5R2xCSWZhWElBNnpkVE5MRFo4RTNY?=
 =?utf-8?Q?8/BfGdoXq3XxSqqxyaQvNssw4nduyqO9YyB5xzn2137j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd76985-9730-464d-f759-08da8058fbec
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 14:01:30.0466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz2VfEWMcVG5l+l31x1mG1RA/EwoiGbkDAqTG1OszmjzW+khuUwgCrb19tFg1q8j4bZYzvvfZVbEksKpFC+rjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1125
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-17 09:44, Alex Deucher wrote:
> On Tue, Aug 16, 2022 at 10:54 PM Chai, Thomas <YiPeng.Chai@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Alex:
>>    When removing an amdgpu device, it may be difficult to change the order of psp_hw_fini calls.
>>
>> 1. The drm_dev_unplug call is at the beginning in the amdgpu_pci_remove function,  which makes the gpu device inaccessible for userspace operations.  If the call to psp_hw_fini was moved before drm_dev_unplug,  userspace could access the gpu device but the psp might be removing. It has unknown issues.
>>
> +Andrey Grodzovsky
>
> We should fix the ordering in amdgpu_pci_remove() then I guess?  There
> are lots of places where drm_dev_enter() is used to protect access to
> the hardware which could be similarly affected.
>
> Alex


We probably can try to move drm_dev_unplug after 
amdgpu_driver_unload_kms. I don't remember now why drm_dev_unplug must 
be the first thing we do in amdgpu_pci_remove and what impact it will 
have but maybe give it a try.
Also see if you can run libdrm hotplug test suite before and after the 
change.

Andrey


>
>> 2. psp_hw_fini is called by the .hw_fini iterator in amdgpu_device_ip_fini_early, referring to the code starting from amdgpu_pci_remove to .hw_fini is called,
>>     there are many preparatory operations before calling .hw_fini,  which makes it very difficult to change the order of psp_hw_fini or all block .hw_fini.
>>
>>     So can we do a workaround in psp_cmd_submit_buf when removing amdgpu device?
>>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Monday, August 15, 2022 10:22 PM
>> To: Chai, Thomas <YiPeng.Chai@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: TA unload messages are not actually sent to psp when amdgpu is uninstalled
>>
>> On Mon, Aug 15, 2022 at 3:06 AM YiPeng Chai <YiPeng.Chai@amd.com> wrote:
>>> The psp_cmd_submit_buf function is called by psp_hw_fini to send TA
>>> unload messages to psp to terminate ras, asd and tmr.
>>> But when amdgpu is uninstalled, drm_dev_unplug is called earlier than
>>> psp_hw_fini in amdgpu_pci_remove, the calling order as follows:
>>> static void amdgpu_pci_remove(struct pci_dev *pdev) {
>>>          drm_dev_unplug
>>>          ......
>>>          amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
>>>                  ->.hw_fini->psp_hw_fini->...
>>>                  ->psp_ta_unload->psp_cmd_submit_buf
>>>          ......
>>> }
>>> The program will return when calling drm_dev_enter in
>>> psp_cmd_submit_buf.
>>>
>>> So the call to drm_dev_enter in psp_cmd_submit_buf should be removed,
>>> so that the TA unload messages can be sent to the psp when amdgpu is
>>> uninstalled.
>>>
>>> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> index b067ce45d226..0578d8d094a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> @@ -585,9 +585,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
>>>          if (psp->adev->no_hw_access)
>>>                  return 0;
>>>
>>> -       if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
>>> -               return 0;
>>> -
>> This check is to prevent the hardware from being accessed if the card is removed.  I think we need to fix the ordering elsewhere.
>>
>> Alex
>>
>>>          memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
>>>
>>>          memcpy(psp->cmd_buf_mem, cmd, sizeof(struct
>>> psp_gfx_cmd_resp)); @@ -651,7 +648,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
>>>          }
>>>
>>>   exit:
>>> -       drm_dev_exit(idx);
>>>          return ret;
>>>   }
>>>
>>> --
>>> 2.25.1
>>>
