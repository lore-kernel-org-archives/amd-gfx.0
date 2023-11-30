Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BCEC46CA3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 10:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D85C10E07B;
	Thu, 30 Nov 2023 10:55:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F83010E07B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 10:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuWP4Y2gCkSlD+gGfV4bEAuUNk5r/5NYq7jQb9Hm5bD7s8SE+VeUfxM+lSY/Y+P1vlYJWRruvgblevylYsJ9GCaLfdqkE6ZqKppe5cBDuFvOC1NnNPMGAaJ1qmeEkCeC3l5mmEYTnN5SN3U87IP7ztU0siWgYLGqXR6vEgoGc55Xy8ndCF/eJ2Ft4eDQaDqJC2aeWQUKshzjhn0RmV592rArVDWbZJ2MjdE6xZpPuj38vqV3pBZ9YNf9LpZRckLI4LvdOwwVJGmYYuv8mnPfVUN5+jm4k9ZEy2mfFBc5L6YJnMd1qEcFytecO7dVwAhDjfaw6H7fEpfZZh6Pp8aoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuKnAvzGHSyaYVZKhV5yqn8jRmVRgrazTPul9z8L/e0=;
 b=huN879XiP0wTjEDKyJFuQfwXIn0GDUb26iJ8S4epolZCcHwa5j3tbYs/uHffFH6544UenfLozd3dhuzxf+esgzig1Vr336PX3O6AUIa4CdPeIj1SQZx4KwGZFq6FVF3vF6w/vNlvps5v3b3QSAHkly94z7HVzifSWi7S6IeIfwlUDtefpTZkxM/G1WdjZ75C082Nm8Lj0JSe75JWmHIDtJanXAUS6L9LNdNEDpWO/653yWd9Hl/olidWsrM4BCAvH4VBU9FP5XF6XsRDmM7wpL327XewAiiRku/RpZyABVxygxQ9soL2VT3q1QZd7FL29hRTWY2WhrAWuA6Mh+Jd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuKnAvzGHSyaYVZKhV5yqn8jRmVRgrazTPul9z8L/e0=;
 b=tH6Qb+1tQq6rwdUfb72u/3HRJqTloMRWQrMRFAhcJ+TQpskePiULScB6r9HF1E3Dx/OzVIuRMKIXcOSilKcoafFOS6j4aMXslaYIl4TUhrSUOrnWkxPYPIckr5LGYUq4TqTort72fd7ZCk/m3yuRHglEs3nw5ZJJiGyIksbG/bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 10:55:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 10:55:23 +0000
Message-ID: <6b4ae32d-26ef-476e-b7c4-990c4bd5ce6a@amd.com>
Date: Thu, 30 Nov 2023 16:25:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Ma Jun <Jun.Ma2@amd.com>
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
 <CADnq5_NX1hfyq34+HkVirXxS28j69-hFdH-q9jwnfDwmdcBsLA@mail.gmail.com>
 <42d53ace-3cfb-469a-ad10-f2a2ee8609fb@amd.com>
 <f03a4515-b73f-4e13-8eec-384443c75503@amd.com>
 <24200e4f-ec60-418b-81ee-d7adf79174a7@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <24200e4f-ec60-418b-81ee-d7adf79174a7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a91d7c-a44f-4e3b-1404-08dbf192d9d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBNX0rhnApv8XAXVCXDvUdQxtPvR4cksl6QXy8xN0JfrfviDrrzUDD4dg6PJ6fQ6CbK6FWPMTJQmAJstPlRv15D+d5K4ovqyrGNpM0lISlHxdMu/QnkhqAP/8O2+Em5prvRhGeGmZO6xTX1yToXRkQuEOxI3pIkh49Wl16Zni0edrvDD0IEATRqs9cnBr7hKukvJxpbhtx43wkYOo1Mjm7rbmqT09EWNxhXxIFJXr259ZALZfWKTWoslUhukuNpOqU55XAVYlqqsbhktl0Oyny0PyZFp2ngZvVtxMFDrnR9YfELVSBqgflaQUmh8gCEh6o0F8oDC4bDBTSAIKPBLZXanopoGaOVujCQPbyOCqaEeMpfg3z060xKYTqILRN9KByF/okQKrgR840uTiVudLudY5/k2uIwuWiHef0l7qL7EceOcvvuDDwQ2pFPLaUQPl2zfHCsHZOQnIEi/hwrFCBiSitsnFJRmfthb20UqQMShBGvdSOfEgTLfA7TjXPFciwsuH+54UFiQTDT24mryYV124O8JhDCB1sc5QJeHPP0dC7tjacu+2+iBUjWXK+tEzzatR1xkCFGq6Rkw67FKkLRFSMVa8Ye8gVao/Rk3w+PKQlobrjrqB+Tc4N4plH7IvTnlilZqYikO998n0QzcatJ3vRFohCKLAwH06MXd5/K8q7OjdisVjP5or9c1RDTHkvSo5lqsOeXEGXsu7Z2wEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(2616005)(6512007)(478600001)(8676002)(6506007)(8936002)(31696002)(5660300002)(4326008)(110136005)(6486002)(66556008)(6636002)(316002)(66476007)(66946007)(86362001)(83380400001)(38100700002)(31686004)(53546011)(202311291699003)(6666004)(2906002)(36756003)(41300700001)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFYyRWNWOUNJbmVnTkZuaExSek1KRkNMRlRRcExFMk5MY284d0RBbUtGVVB1?=
 =?utf-8?B?NVVhK2h4Wk54QXAzSkFoU0JPRCtjQnJqYVBTVStkYVdvbU42QjRvckgyTjNi?=
 =?utf-8?B?ayt3OWp0a3Ixd09UKzVYRjdKWm80QjRtQ21Fa3hPY09XejJBZHhFb2FVaWxh?=
 =?utf-8?B?K1F6SHVNbFhuU1RFN1FBYVZ0WWJiZHVUdDFhTU9OaEZkOTZWMEFIYTlLNXY1?=
 =?utf-8?B?TDZTRm1wQkI2M3cxdVg3T0NOUlVyVW8zTUk1UE5OMFN3TmJqUWllNnRwQ0tm?=
 =?utf-8?B?TlpzbEVWNmNIZDdxU2p6ZXRZWlJoNWdpN3R5UlBVU2JUMlVvc0dRWU5OcWlO?=
 =?utf-8?B?Z0NzQUtRZjZtVDlHeTNqQ3AvNE9RSE9Hd1pEU0lORFBUQWNRK2VNSnJsUjM4?=
 =?utf-8?B?cE1Qc0R4NjJBc3h6WFgrN3lxUHAxVHQ3bnFBQm5scTJ1Zi9HendsdXprMkho?=
 =?utf-8?B?UmhyVkF4VERlLzFsb3FmUW9JMk03MzJ0SUQ0di9jK2pOUWVNVytsNVNCZWMr?=
 =?utf-8?B?UmZpbHBTQy83SEJCaW5qUElvWlFaTlU1OVlZVWhLV2E5bm1SUmk4UDlNN0V0?=
 =?utf-8?B?cG5ETDdzWHJXVEdXZFg1WVQyUmZDVVc0RzdBNHhrNTAwT3NHNXFJZTZYcjE0?=
 =?utf-8?B?Wk82dEJGRVV6YW9wZHkxRHVRaXhNN3FSTDUyblZaU3ZqNmltUENLdGVLUmZn?=
 =?utf-8?B?YWdDZm0rRHhFdHhYQWRWNUVjaDh6dSthUmJNMTVxb3hRV3pJcmNLV3prV1Ri?=
 =?utf-8?B?WGZ0ekRmajJ1Q29lQmJrU29XOVJUUlRKdUptZjgzbHRvdnFWcG9UbHVVdGps?=
 =?utf-8?B?dnBzaFVKcVBSUWZzdmRDczcyRlZVYlZ2dGd0dEhFc3orelVPckx2S1pYQ0RO?=
 =?utf-8?B?bklDMGtDU0dKOVlZTHlkelNiU0IvVFQvWjVpRTNDRS9jTmFQVmF0dU1uL1lI?=
 =?utf-8?B?NmQzZWpHWkNHN1JGNWlkU3N6NGZDUEl6OWlaOERXVUNVQTNLd0VQdmJGQmh4?=
 =?utf-8?B?ZVlFTkVvcXRKcXJSbGZBenhqcE1zYWh0U20vTmRXczc2enRYbWxaZ3ZVWFhW?=
 =?utf-8?B?L0hQa3R2aEQ1c0FSU0lRMGlSbERoczRBVkM3RzdEVW1CYVBpdjYwYmd2d2RC?=
 =?utf-8?B?Um5MeFlHZi8rYWhRSFA1c2s4dWhxYURQOXdFSWhhellwTWhxeDR0dExXTHRX?=
 =?utf-8?B?OU5FTm8rTWFLZWFna1VKYlVBVEhFVHhveVNXZk91bFpvNUpHSURFYVpxdzJl?=
 =?utf-8?B?RklVZndPcE1RcUozRktOSVZ3U2FONjM5cEJOWkpyOCtiTDRYeXZ1TmQraTdw?=
 =?utf-8?B?M2hOZ0FJZnBMMk96bzRyMkk3L01ib2wzYlpnWTAwSCs1T0g0VzR6ZG8wTnJk?=
 =?utf-8?B?OHIvTFNmbGpzRlJzRDEyTzFwaW5meWpkTEs0bTJPMk00cVM5Wkd2QXpTQ1Vl?=
 =?utf-8?B?WFhNOHY3bWZBWEdoYVpyd1o2R3Z3SVVsZFJWdkgwSGRzWkgzdGxrOS9peEsv?=
 =?utf-8?B?WVNZQlM5TWFqalQ1eGYxRnliY1lSOGtWcjlRamZ2d3lOQk4zdlU0ZmVjcndl?=
 =?utf-8?B?WXZKTGwyNVd0R3IvaGdXZXFKRXV1b3JUN1gxV1hMZ3YvNEllSzR6cmtwelVL?=
 =?utf-8?B?dWt0Nkd2a2s0RXZnaXVoZnlCcnMyNnJxR0dUVGZUY1gwbTJ3dVVDWnpGM05B?=
 =?utf-8?B?eE5ybENIUXlmZGdvQWRzQmQ1NWpIK1JOY285WS9FT3ZnNE53VTFGL1hldDdL?=
 =?utf-8?B?MXBtV3NTK2RUeEpKWjZSNmM4aEtuQ3R1cWN5VklHQmt0UDk4R2tHNHBuWFdJ?=
 =?utf-8?B?eCtWQjFGY09hc2E5MlVkazROS2taTDByeTNCK245Ums5K0FyajYwK1lNa1l2?=
 =?utf-8?B?dW1ldTNEL1R1YXVEd3EwVFZ2RGxXcC8wSDNJY2U0VkhWV09Vc0dVWHBocFRT?=
 =?utf-8?B?cFllN2h2SFVKMkpEUStnb3M5ZHNZVzByNkhTRS9xT1ZMY243MTh5KzNrN29X?=
 =?utf-8?B?dW9oT091V0N2b2xxdElPelphdy8reGZxZWRWb1k5QTJhRm5DWmpXYWNDYUMz?=
 =?utf-8?B?THFwRndOQVY4aGRWWjBNc2pGbEc5VjVmQm5LbEVNM3grRnQvbUVKSEdneWh2?=
 =?utf-8?Q?Z23kWms9UaldWY9qE4e/ruSTK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a91d7c-a44f-4e3b-1404-08dbf192d9d1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 10:55:22.9326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8fEdAcPgn1C8dLBga0vN5TzvbEKoA7nSa1zNL4nMAaS81bBq/8zBqrH2W7akZTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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



On 11/30/2023 4:17 PM, Ma, Jun wrote:
> Hi Lijo,
> 
> On 11/30/2023 5:18 PM, Lazar, Lijo wrote:
>>
>>
>> On 11/30/2023 11:59 AM, Ma, Jun wrote:
>>> Hi Alex,
>>>
>>> On 11/30/2023 12:39 AM, Alex Deucher wrote:
>>>> On Wed, Nov 29, 2023 at 11:37 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>>>>
>>>>> Some platforms can't resume from d3cold state, So add a
>>>>> new module parameter to disable d3cold state for debugging
>>>>> purpose or workaround.
>>>>
>>>> Doesn't the runpm parameter already handle this?  If you set runpm=0,
>>>> that should disable d3cold.
>>>>
>>> runpm=0  prevents calls to driver runtime_suspend/resume functions.
>>> While d3cold=0 allows calls to runtime_suspend/resume functions and puts
>>> the device in d3hot state instead of d3cold.
>>>
>>
>> Why not use the sysfs node to change "d3cold_allowed" on the device's
>> upstream bridge?
>>
> It seems the same question as Mario. Please refer to my reply to his question.
> 

Once you disable on the device, all upstream devices along the path will 
be taken care. I don't see a special need to disable BOCO separately. 
pci_d3cold_disable is the same API used by sysfs node also.

Thanks,
Lijo

> Regards,
> Ma Jun
> 
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Ma Jun
>>>
>>>> Alex
>>>>
>>>>>
>>>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
>>>>>    3 files changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index a9f54df9d33e..db9f60790267 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>>>>    extern int amdgpu_dpm;
>>>>>    extern int amdgpu_fw_load_type;
>>>>>    extern int amdgpu_aspm;
>>>>> +extern int amdgpu_d3cold;
>>>>>    extern int amdgpu_runtime_pm;
>>>>>    extern uint amdgpu_ip_block_mask;
>>>>>    extern int amdgpu_bapm;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 22b6a910b7f2..90501c44e7d0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
>>>>>    bool amdgpu_device_supports_boco(struct drm_device *dev)
>>>>>    {
>>>>>           struct amdgpu_device *adev = drm_to_adev(dev);
>>>>> +       struct pci_dev *parent;
>>>>> +
>>>>> +       if (!amdgpu_d3cold) {
>>>>> +               parent = pcie_find_root_port(adev->pdev);
>>>>> +               pci_d3cold_disable(parent);
>>>>> +               return false;
>>>>> +       }
>>>>>
>>>>>           if (adev->has_pr3 ||
>>>>>               ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index 5f14f04cb553..c9fbb8bd4169 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>>>>>    int amdgpu_dpm = -1;
>>>>>    int amdgpu_fw_load_type = -1;
>>>>>    int amdgpu_aspm = -1;
>>>>> +int amdgpu_d3cold = -1;
>>>>>    int amdgpu_runtime_pm = -1;
>>>>>    uint amdgpu_ip_block_mask = 0xffffffff;
>>>>>    int amdgpu_bapm = -1;
>>>>> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>>>>>    MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
>>>>>    module_param_named(aspm, amdgpu_aspm, int, 0444);
>>>>>
>>>>> +/**
>>>>> + * DOC: d3cold (int)
>>>>> + * To disable d3cold (1 = enable, 0 = disable). The default is -1 (auto, enabled).
>>>>> + */
>>>>> +MODULE_PARM_DESC(d3cold, "d3cold support (1 = enable, 0 = disable, -1 = auto)");
>>>>> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
>>>>> +
>>>>>    /**
>>>>>     * DOC: runpm (int)
>>>>>     * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down
>>>>> --
>>>>> 2.34.1
>>>>>
>>
>>
