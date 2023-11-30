Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECABC4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 09:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5900810E1BD;
	Thu, 30 Nov 2023 09:18:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD95610E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 09:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDRePGGWa6YkK/c8srch6s6AwRi1OlGfxzB0+ImqzkE8nkvTvfUhxAcCsslGxRvNUitnNjzvPU+P8Xbhlt8phmZfD+JILfRs4aVFYfUhuToTJnebwW+3LMvbeCJRK2h9UpMALjuW7iq1IkMBltBqA5Hhmu1adCBCVBHg/fGBqBP5OGaCedWqmmsZkeG6uiEeLlPaLVIrczcUhpqbELn0a7X+mXcqz1zOITKx4Sppetd+1ymaX8eF4lYTWY0wNLQJmArp8PmQN5y6LoHcHdi3qV/qbRE4JzkR3NADwiB+iSTti5d2R9grTKNakRz8S+5oQFfFzXp8LP4xKAg1KzAIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHfreLrznOT2hcuU1/HjfZ3O7T96E1cIBpjujwv2oRk=;
 b=inVpCh3E5YPMSqDYv3xFZtbidAAXA89SoSLEOHLbrTndtmCwU5ok7LYW2m6gGICFal98VJZ26IGGNHlMMIod7eDL1tRU4NQ4actR5MdvcNClv+2pykWBnhZB1AV76hjkIJkDdLOunPlEaJLdStINzBmd17qiv4S4p2rJ7pQEAKBz9Cj+dZyXRrQNjI+uajGUVhnXgH1RIQMI2EuVNOZTUIvgzqVWEMvga9L45P05+T8D2PBAAbNPwwFeVBbEUQoyUimkylz8SVco+IjkzjVU0mxXx+BTux/5qfe1vWQ+9v0Le/KST9ge2gf+2iq4M/JlQuel/K9kHHIbUC9SSP+z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHfreLrznOT2hcuU1/HjfZ3O7T96E1cIBpjujwv2oRk=;
 b=piHl+gxGAaroTjcVFj+b+0JrGvx1o/YOq1CnwG/Ms8dnnZIh8NsUf13McR9qCQUrlRi/+k4/R25NV1NxVu94VVoYos8NS/nQSNuntCie5g8Qco3JVvqUh5b37krYQZeL7WOH9CQqZ46S6tMS8ErgTp/TwME56LV6bSpkM0L9v2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 09:18:50 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 09:18:50 +0000
Message-ID: <f03a4515-b73f-4e13-8eec-384443c75503@amd.com>
Date: Thu, 30 Nov 2023 14:48:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
 <CADnq5_NX1hfyq34+HkVirXxS28j69-hFdH-q9jwnfDwmdcBsLA@mail.gmail.com>
 <42d53ace-3cfb-469a-ad10-f2a2ee8609fb@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <42d53ace-3cfb-469a-ad10-f2a2ee8609fb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW3PR12MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b331be8-9ddc-4785-f9ed-08dbf1855cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KAzC5sJ5NM0sRbmPmzSjy4T5uGMuMNCQ5vFHkKvT0qlZg0eNmF2D5qCmIi2PMtHhSGgf62lxuyd+BRi8T4X1j+WbraJOlW255IZ5qAUyJsTggoDZrRUrEz2+DOw/TQ9GNaRlNyLysJgOCFNSdOZISdTyYHXTlPuW+VLkvfekuODcYHclEyE88jNZuqodiB9m36DfgmkeoZlJnR9Z2txfrYEpcgh+eBjsCWboOm7e7GoKI8mGZFSrLuUyAJViYZOcAzWj4dJ5XIWkXSUHcPQC1G0tZ0r4u6/EjfNW73rpkdi4BqFHWgx0qmlrf8wHSniK1ZvL5lHpAWwSqqeEY+Cpn9GilbuURTeVvMNSZiacKlhQ3/Jpp9UZANGBQ6l8DAs7QIwhsZ5Oi//EyUvmi9tILZvxdmEMGOlHLhiXF62q4LqxaKd/HRQgC2Xl8bvjpNrDTNyKn0nqFslaXBgT2bHjJe9JrYhB3C6q8jDC5o0qKIOdwTp8ryCLl2C/p+SuzBRPpL65j053Db848w0BZovnJGDMSBdVXs11mCGc/XzSj8cKPVYQCdIUo7K/PKxeLgKsD4sMc+maKszv7jHj8GecrjhMhDB8c9UuZECeSfpEvhCFIdRrEaFmaU4MltmJIxwqIq5GQYZ1Y3yJO6ymCvZevJWBn7yRl9pp3UF8+71/enOdafYUywVQ4ZbPTJtJJv7rPtAEG3VbH6+YmhjUPA44oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(26005)(202311291699003)(31686004)(38100700002)(2906002)(5660300002)(6506007)(53546011)(83380400001)(6666004)(2616005)(6512007)(66946007)(478600001)(6486002)(36756003)(41300700001)(6636002)(4326008)(66556008)(86362001)(66476007)(110136005)(316002)(8936002)(8676002)(31696002)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekcxUElpekhxQVpXY016a2k3OGt2dnR1TzU5cE42OVhFcmFZVGxSeU1pckxn?=
 =?utf-8?B?L0NWcGlaL1RjenlnU05JZWx2ZUJST2I5cHRMbUlpdk9WSHdMMVZvampCRXJq?=
 =?utf-8?B?UmdLVWtIdW5YNWh2V1VRK0RURGpYWnVlNVhlald1MXBjV3AxOXdsWnBuQ1N6?=
 =?utf-8?B?NDZ6bE1vRUcvUnVTYkFyU0dMM2dVcjVMNmV1T0E0K1d3eEtmTXcvUGgzc21Z?=
 =?utf-8?B?b09kNG9td0hUYTZLSnFHY3NJSG9PVHIwU0hyRTN4Y3RFSnhFQkRYRVFrVGxx?=
 =?utf-8?B?cGVQbGhTUCtwSzhybThvcXNuYnFIejAwL0I4ZUlvcHBOeXhIYjNlTVZ1ZnNv?=
 =?utf-8?B?bnhNUk0wOTl3OWJ0bWhFdGp6eDNtTHUzQlYwYStFV3FoMmdWUFdWOGZkRDkx?=
 =?utf-8?B?WWtJSGgwODRvMDF0SXBZRE5lWFZ0N3RmRW5hZVNqcWhwNC9qaDFGaGhnRVBa?=
 =?utf-8?B?MDdVMUVSclVJQWhreHo1bnMxSVZmemFpWVpJSlFyZk1ZNDNoTGloUnBsM1B5?=
 =?utf-8?B?Rzd6RENPalNlbE1zUDYvRUxQcklVRFA2OXFsSlVtZGFCTi8yY0lzRlpvS1dT?=
 =?utf-8?B?b0RuM3lseGQwck5sUnNCaWh5QlJCQzNvZ3ZvTjIrTDFLV09VSTUyQzJ4RHhs?=
 =?utf-8?B?cDN3akVaTjRaZ1Z6Y05tem55RU0yNmNwQ1lGZGpVWkpOMFo3MTlEcCtzSHBh?=
 =?utf-8?B?NDI0cXcvTyt3djJtOGtPbkZmMU9tTkNDZ2NkWVI4MVI1a0JkaFVzNFkzRnhF?=
 =?utf-8?B?VTBWSW1kMWhRV0xFTnE2bVRGVmwyVHdVQmRhWmpFS2xQdjFYMjNkT3h4UXQv?=
 =?utf-8?B?NEVqZzBRUDlCeUd2b3pLcmZpdC9ocnR5MVdQUEpTSUZXYlNaTUVaM2RXWlBl?=
 =?utf-8?B?SCs0ZWdZRXpjZHY4SGhiRmtvcDZPSnVyajJyUUxJMUMzNHVzSW8wNTdNbUdU?=
 =?utf-8?B?aDl2T3QrVHZnQXgzdCs0bTY3NVhIV2FuN1k0QTAwOXFBQ3ZlcEpndlJLNjJD?=
 =?utf-8?B?WXFEcmhzSFEvelVjZ0xkSlpsL1A5ZzNxb1lmYzJJS2M4ZHBVbUhaSWE1MXBV?=
 =?utf-8?B?Zk5iR21mU3F3T29kS0EydHF4ZVBnRTJ2ZERrSS9pRVgzUVI0OUcxZEdOUGRt?=
 =?utf-8?B?UE9Gb2xiYnJ0U0cwZExMUFRCOEhDNlRlTkI4b0tyTjNEbFd1dDZYQjVDdkEw?=
 =?utf-8?B?Sk94b3lxdkJvZFVlTWI4dVFXNTdDdmlQUDVDeXNONTlqZDRIZjU0TThmUHpr?=
 =?utf-8?B?ZHlNTVBjR21iYTMza2pYZ0tQU1BxMkxONFhPQzYxcEhKVG5LN29KU1lhWTFh?=
 =?utf-8?B?MU1tZG1Ub0VYeXdqMGxqQmlGZnZlbDEwVGRsaktyRGpoL3l3OGJ2UWpJUXRT?=
 =?utf-8?B?NE9kYzUzV2Jyai84K2U4NlpiSWg2OUEyL0xIekVLb3oxMmpCQUo5TjlpcVU0?=
 =?utf-8?B?WTFmMW5TZ0RxUVNGVFlqMkVDMlIyais0Mk52TXBnbm5yYXpld1BGbldCLzBw?=
 =?utf-8?B?YzFwenpIME44Si9QYkpFV0xmem1zeFJHbWxESDFCQ0hLQ2NPb0tsZ3J4WFJB?=
 =?utf-8?B?UWFZc2lvYngyL3p0NWRwVnJrZWcxVXBaVjBkK0ZhS1NweVFOemNBNmt5RkZV?=
 =?utf-8?B?Z0puQjFDamFuc0V3M3ZzRERCWkYwSElnM0duRnY3Ti9hcVZnVHlPYUt6eThn?=
 =?utf-8?B?d2x1ampxMWpXUGVicDNQckg2R1UwbHR6NXFvMFVpcjY2YndJdmozQkd2UGhr?=
 =?utf-8?B?a0p2QXJ6TjJDTUJWVFhveXdzMzhIWWI5RUY2WUZ0dUhaVGR1K2laRFRuVHBD?=
 =?utf-8?B?cXpzaFU5UWthUTdkNGRxdnd5QjFRWWZNc3F5Z1ZDZ3FMYWxNUEVieDRkcUx1?=
 =?utf-8?B?ZjVBNTFyb01YMDZzRTA2cm1DbGlqbjhCYm1kaEsvNXNJaGp2V2NodUZ4cTVJ?=
 =?utf-8?B?SjZFaUhnSFdGeW9odjNML054WmhLRVphYWx5ZGZoYlJERU5jYmZjR1ZSUStM?=
 =?utf-8?B?ZmFvZGtzNDBXS3N4c3k2NVczU2Y5ZXlXbmN0aTU1WU1tQ2RtaUQxSWJ6aWJK?=
 =?utf-8?B?NkE4RXdPUFdGY2NCOUdweEhYcEpKclFjbXJNRWo0OXJnUm5lZnlBTFdDVDFM?=
 =?utf-8?Q?Rb3KJM6TznuJ79WPEV7MQPaGM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b331be8-9ddc-4785-f9ed-08dbf1855cf3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:18:49.9280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b86X9gpKaZlyw0DD6dtXBwM4hyD/l142y5+FirIqw0ocSzqpoYkB95M+H4xIFz7I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com,
 amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/30/2023 11:59 AM, Ma, Jun wrote:
> Hi Alex,
> 
> On 11/30/2023 12:39 AM, Alex Deucher wrote:
>> On Wed, Nov 29, 2023 at 11:37 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>>
>>> Some platforms can't resume from d3cold state, So add a
>>> new module parameter to disable d3cold state for debugging
>>> purpose or workaround.
>>
>> Doesn't the runpm parameter already handle this?  If you set runpm=0,
>> that should disable d3cold.
>>
> runpm=0  prevents calls to driver runtime_suspend/resume functions.
> While d3cold=0 allows calls to runtime_suspend/resume functions and puts
> the device in d3hot state instead of d3cold.
> 

Why not use the sysfs node to change "d3cold_allowed" on the device's 
upstream bridge?

Thanks,
Lijo

> Regards,
> Ma Jun
> 
>> Alex
>>
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
>>>   3 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index a9f54df9d33e..db9f60790267 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>>   extern int amdgpu_dpm;
>>>   extern int amdgpu_fw_load_type;
>>>   extern int amdgpu_aspm;
>>> +extern int amdgpu_d3cold;
>>>   extern int amdgpu_runtime_pm;
>>>   extern uint amdgpu_ip_block_mask;
>>>   extern int amdgpu_bapm;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 22b6a910b7f2..90501c44e7d0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
>>>   bool amdgpu_device_supports_boco(struct drm_device *dev)
>>>   {
>>>          struct amdgpu_device *adev = drm_to_adev(dev);
>>> +       struct pci_dev *parent;
>>> +
>>> +       if (!amdgpu_d3cold) {
>>> +               parent = pcie_find_root_port(adev->pdev);
>>> +               pci_d3cold_disable(parent);
>>> +               return false;
>>> +       }
>>>
>>>          if (adev->has_pr3 ||
>>>              ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 5f14f04cb553..c9fbb8bd4169 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>>   int amdgpu_dpm = -1;
>>>   int amdgpu_fw_load_type = -1;
>>>   int amdgpu_aspm = -1;
>>> +int amdgpu_d3cold = -1;
>>>   int amdgpu_runtime_pm = -1;
>>>   uint amdgpu_ip_block_mask = 0xffffffff;
>>>   int amdgpu_bapm = -1;
>>> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>>>   MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
>>>   module_param_named(aspm, amdgpu_aspm, int, 0444);
>>>
>>> +/**
>>> + * DOC: d3cold (int)
>>> + * To disable d3cold (1 = enable, 0 = disable). The default is -1 (auto, enabled).
>>> + */
>>> +MODULE_PARM_DESC(d3cold, "d3cold support (1 = enable, 0 = disable, -1 = auto)");
>>> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
>>> +
>>>   /**
>>>    * DOC: runpm (int)
>>>    * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
>>> --
>>> 2.34.1
>>>


