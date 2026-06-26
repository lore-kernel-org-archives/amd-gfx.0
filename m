Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E0FCDE008
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 11:37:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D31D10E1EF;
	Fri, 26 Jun 2026 11:37:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hXQHW6bH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012019.outbound.protection.outlook.com
 [40.107.200.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321D810E1EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 11:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4H+Pg3x4IktD/792ozdLbM5tUmhPQ1V6kbYkJjhVa9uTaVURWs1mPTPDoaD5dyt8ShrPJmF3b+Z0pWC0IutfOWAnOUIrL2Y8ujHmJAzMpe63qUisV/FOy2BYsc3cJZRih613DxhWdNmzzlppjt1nOpSUbSBUfmRzy5SwARD9QWMcLbPZkuVnjGJe9dFVE4pUiW/ky+F0VY/6uxfSus1mJP3DbRvCvy/X3S6PFzgKUr6sZceJH11zRfk7ECNUkkKwQ69OIkDNbYWPFeZMW3D685DkZ9gtmRGNktIONXEMTsxnZfa5/EJoU7uxlCMrM8bEx3CTehxvTPIiwsev7WmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF2poUVAOwOTj0rH3lI6jGyeMcBx8qqn8XTj0NlXOo0=;
 b=W0ZN/z7+q2HYqu8ziv86g4LmSUCE2Df/C5XMMTbGCl1Le3iWsm4Y9k2jpZH0j2TbiiufROWxv9CF8R6FHRog8eVjefSwRhoOwh2mdwbAgJK9S+hxjaubkTH/Yq8xt6de2NXlnDnkmYbHK+RUb731d14tn1Kr4i5XXUrC8PnnkU9lb49RM2+sbSZzYwkm3rYNffuICieBO87DZk5gIVPptYhWJS6nHkTCJ4co/N+wr6yTVPE7xTMqyVeum1ooNS2SVjWvLqd1U8sXCF39joHgqUgRWVh+Txtsnb/G6Eo8qJ6NR47LJSG+zth1keJawfWGE4k/TE4DB/Cl01yyHbcmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF2poUVAOwOTj0rH3lI6jGyeMcBx8qqn8XTj0NlXOo0=;
 b=hXQHW6bHOck0y/+wMQZvykNb4+IQlyzzlKyMS6OyCQ4wNCPEhBAZB7gTFEaVcSe5HVJX/UGQzGRx0lhaiwUyjZQBNZ3vQsLFPRU7Y6Kkn0FXHIHLWhgjvmf3QodeSgWc5is4NxM0dimqb2+0lF4CR4Yt9BhXWCgJ4mx9BW/1OyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 11:37:12 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0159.012; Fri, 26 Jun 2026
 11:37:09 +0000
Message-ID: <4569930e-6507-42c0-8470-e33cb69af088@amd.com>
Date: Fri, 26 Jun 2026 17:07:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps
 dynamic switch
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260626071752.192163-1-Stanley.Yang@amd.com>
 <d06a5c88-63cb-491f-8090-6df38325acdb@amd.com>
 <DS7PR12MB832415758449F9B1FE398BD59AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
 <a518c22d-35c0-4e05-98b1-de95d8f31fa2@amd.com>
 <DS7PR12MB8324DFB3CC667353307A93869AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB8324DFB3CC667353307A93869AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0221.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::9) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e878d9-3a99-48fc-7426-08ded37741e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: EfCAXsGK8p1DvIEuCrB4Co1P1y4RT02SdwAV+/zb8wkP8brOHG3P9rh61rEshT/d8U8HX18JZw9LIgMyIN8LWZYZms/LT1qlcap46JGgqrKi0J5sUK0n1p0XQFQiD4ni0e2bwtXRrO+dVmacJ8ZnScnnXV4LvVRKmon46Lie75V2yoiXcBo4aPOtlazKSY/qIq4qG5vBeJLex6hjxkbMUWCE+0M3uTdisheO+Ue0p9LC4lOmxNrxYGZWCRrL0LRGXJ5qjeGtA0+uxONYdKCo0KdiImZBP7aS+w4o5EvtG2VrYrGv0RaVTxAOT27beQ+Bb94HKM38ZWPEI+6GlwEHX4iLdFt/aDU0+QHt1U9ZY2QvclYcEZTkx1E41mJZesiEqd5DPxp4W77GRQlAjhf3NafUw3u5bLrz/gO86tHdgaYvcVIXb3BZRzzaDQeocEpeUV6WRPVU5DJrlvB69qlj99+adp3EySoVXccQPdZklxYIqyY1P28E7H+h0IiIBCFqd3K4CyTVMAC4j5nAMGchF4tfSBof5s7mUgapb0e1hxySSPoKR5F/4GNJ3aUrV2aiWP/7weCLjE4aH/tvb0OEOHx26PxRHFL5o0dI873V0eRsN8DJ0G9YjXPyyEpq58qh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXY0M2dYYnNWVVkrYXZGc2V4VmIrY1RsQ09Qd3hhU3NKSWtNNnJIUnVkdzd5?=
 =?utf-8?B?ek45Zklmdms1eTArMFpFdk5yU0ZQQmVTVTdRYXFrcXhuQ0VEVVdFOG9kVkpY?=
 =?utf-8?B?em81cTUwYUJmWnNHY2RjMUhQNlpYQStabnVDZnVwUnRrNE5OOHovQ1Y0NjYr?=
 =?utf-8?B?NWZLblNxK0NFVVVSakVlSG95MzFHUks1dXlmeldSbTZSd3NwY0h0dDFpa1hU?=
 =?utf-8?B?UEYyV1JFeXUwdTJ1ZVVoL3dtRUU3dUljNzBNWEJyTXdKekNYY1IvTXhWanBO?=
 =?utf-8?B?ejZ1d2xhTkFUS2l2QTRzTDQ3SG1CRG5GQUhDejkrYTBlcG8xako0VW96VklI?=
 =?utf-8?B?QUwvb3dmbUE0N1hRSkN0N3NlUzNnc2kyWjBRYkxyTmFyd1JscFg2dndvUFBh?=
 =?utf-8?B?a1Jrd2k4WTdvM0JxRUxrWjJwc2hMYjlDeFJORlh4L2hjVWYzeXZiakNYeTFI?=
 =?utf-8?B?VUxaeUN4UjlkQUZwemZCVTZHclptQ0dGNVNZZmZvbFhRbEl2OXNiZlZKazcz?=
 =?utf-8?B?K1Jya2FucGh4SGtDWk9nYm5DZEJYUncrM3B3RFhvNEtKZ0NHZzhSZ0IrVDRp?=
 =?utf-8?B?NDhrV3F2eGUzbHhDZ1V4OFAyWXNqUllnSEx6K3ZLRDVZaEVsZkYrNFRXQW5l?=
 =?utf-8?B?OWlUcVVIeW41TjBmQXFzQklGUjF3SGpodEJJb2ZiODJsYmNvcGVnM0l5RjFq?=
 =?utf-8?B?OVpibE5sT0dBWUlIV3gzdHU4YkVmV1VPL2VsRTREblhaZ3pQZ0h1NGV6MXI5?=
 =?utf-8?B?KzVqMWN2L0RaSnpEaHJjSm40RDB6bUtabTdrMnlVZEpsSzlnbmx4TnRHM2VC?=
 =?utf-8?B?SWhGeWZHTW9RMFhjVjBNSEtxWFVTdGcyLzBzZ2dyamFJU244MlJONlNEZ3o2?=
 =?utf-8?B?SVlDUU1XVHBjZm5RcW9qUDZSQ2lXQmNFSE5OZ0czT0xvQTJCMk80d2ZES2Zs?=
 =?utf-8?B?LzBGR1ZmQ1A5YzB5UlVZckVnUkt2Z0ZIUG93dytaT2E3R2YyeVhsWDdEK2lB?=
 =?utf-8?B?cFZnUEZVOWZEVlZXcDNIdVVxZ2pXaVllWHNWdlBxYVN2T1h4SkliNnIvN1pk?=
 =?utf-8?B?dXFPQm9TOEg0T1dnL1FHSVVoNksrK3V0S0VXWXNncnA5cXB0MTBaRzhuVjdO?=
 =?utf-8?B?c3BwR0hpOUMxaHNzV0FPejY1aUhxckFobGt1MTJxRTUxVktkZDlWYnNXV1Bz?=
 =?utf-8?B?RkovMFRJK29QWWY2bGYwbmg1MVFLOXhtVC85YlFYRkhOYnFEZzFhYXNvWlZ1?=
 =?utf-8?B?cWZhWjAyT2dTaUNxWEM2RTNCcjJPTGU1RDRtaWdKZkFKa3d4blBDR2hYNlVo?=
 =?utf-8?B?cUZjalpqckZEVEVleElUL0FxSXJ3T05hUUIzUE1FOUNxQ1NzOVZvVFZFYTla?=
 =?utf-8?B?d2lmNXhNRHFxOUY2M1RJSEZHZ2xJZldWc0ZWYnFOVVZvWWpWRU1MQnRXZVli?=
 =?utf-8?B?cWkvTGhUWnY0MDhDKzhwTExyaFU5aFBZTkpHL1drQ2dYb280aHJ5bzJSU0R5?=
 =?utf-8?B?RisxZ0ZvYVgyaklkUm9CNmdXL1pGRmpIcjRNZzBFQkVYSytwcXdrN1E3MHo3?=
 =?utf-8?B?Wkp2Z2F4WjlxYU5PSmUzajMvZkZSRTJIWTRDN3dpcEVvWkwwUHEzL2tLNEt3?=
 =?utf-8?B?dFZUZnl5Ry8xeWd3RGlvVmJJR2RNbW1kZ29YWWJ4UWtvOGxVNzBPekJjcmtn?=
 =?utf-8?B?UDVDcFdMM0g2SnNMS2VEeGpTYWJlWWFNSzhrMU13amhtMGx3dUJ1Vy9pajFS?=
 =?utf-8?B?UmF0OXhEbUlxZnZybFVqNElzMkFjc1laNXhaNVpvNjl0VC9USk5lZytwMElw?=
 =?utf-8?B?d1JFWVI4aHZFWkdPZVdSTXlaTFkyY253ME9yK1M3OStaSjdtK01WcWFUaVRw?=
 =?utf-8?B?bFE0ck5PRS91QmxmZVRSajFkd1ZmcDlIMkdGTnpOYjdIMjVBamsxeDN3QUxw?=
 =?utf-8?B?V3E3WXRUZ3pkYWo3cTdaa1V6NWIxTFQwc0hkM29McHJsRURQYXdMeEF1VnlW?=
 =?utf-8?B?UFdFRENUU3hEcko5bGtEVlBDL0tEOFpEZVM5eWFSSmM4K2xSOExHWGl2amlO?=
 =?utf-8?B?TFIzT09GeEs1cC9qVU5GR1liWGEvcnIxdnQ1eFAwTmd2MEh3ZS91N3ZlKzhP?=
 =?utf-8?B?MW9SNHMzOHhOQXNPejlsblVwV0crS2xKbTltQmNOYWJ2Q0dId2F4cFdwWE93?=
 =?utf-8?B?Z2pXajdNQ0ZFUXgrUzJMWmQyN2ZwdFZUWnBUS3dyM2U5SGNEUDlGWC9xem92?=
 =?utf-8?B?czBIQ1VOVjRwT3Q0R3lYYVJXK1Iza0xtV3hKUlBOTmtZOExYeGl1US9nTHFB?=
 =?utf-8?B?OHNyaElYZmJ3NHdCc0w2bnI4dnZmZHlxTDV4ckhaSlJHUzhaTkNDUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e878d9-3a99-48fc-7426-08ded37741e6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:37:09.6835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NnXng++Da0LtCt64/Y3otkGVAFyi1DF5WmCZ7HjEmCaeScq51+giJLzcTxyG2a9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 26-Jun-26 3:56 PM, Yang, Stanley wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, June 26, 2026 5:44 PM
>> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps
>> dynamic switch
>>
>>
>>
>> On 26-Jun-26 2:04 PM, Yang, Stanley wrote:
>>> AMD General
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, June 26, 2026 4:16 PM
>>>> To: Yang, Stanley <Stanley.Yang@amd.com>;
>>>> amd-gfx@lists.freedesktop.org
>>>> Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during
>>>> nps dynamic switch
>>>>
>>>>
>>>>
>>>> On 26-Jun-26 12:47 PM, Stanley.Yang wrote:
>>>>> On an XGMI reset-on-init (NPS memory patition mode swith), RAS IP hw
>>>>> fini, sw fini is called but hw init is skipped due to RAS IP block
>>>>> is not included in hwinit mask, so need call RAS IP hw init during
>>>>> XGMI reset-on-init.
>>>>>
>>>>
>>>> After reset, we set it to default level.
>>>>
>>>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amd
>>>> g
>>>> pu/amdgpu_device.c#L5211
>>>>
>>>> The default level includes all IP blocks, hence it's supposed to
>>>> resume all blocks.
>>>>
>>>> With RAS as a separate ip block, ideally it should have resumed.
>>>> Could you check why/how RAS IP block is missed?
>>>
>>> static const struct amd_ip_funcs __maybe_unused ras_v1_0_ip_funcs = {
>>>       .name = "ras_v1_0",
>>>       .sw_init = amdgpu_ras_mgr_sw_init,
>>>       .sw_fini = amdgpu_ras_mgr_sw_fini,
>>>       .hw_init = amdgpu_ras_mgr_hw_init,
>>>       .hw_fini = amdgpu_ras_mgr_hw_fini, };
>>>
>>> The RAS IP block does not register suspend and resume callback function, so
>> RAS IP block hw init function missed under this case.
>>>
>>
>> How does it work for regular reset? For regular reset also, driver calls the
>> resume sequence for the IP block.
>>
>> I think the proper fix is to add a resume sequence which calls hw_init (if those
>> paths are identical).
> 
> [Stanley]: Normal cold start is at the DEFAULT init level, and RAS hw_init is executing normally, so uniras is enabled; Normal GPU reset, because there is no. suspend, ras_is_read remains true and the state is preserved - so only NPS switching to this XGMI reset on int path will trigger this bug.
> 
> Not suggest add .resume sequence because during RAS IP block hw_init process need hold reset domain semaphore but the semaphore has already hold before, the other reason is adding .resume will break regular reset, it doesn't need to be reinitialized due to all RAS error info is cached.
> 

Then a dedicated resume sequence needs to be added which checks if 
device is in reset (being resumed from a reset) before taking hold of 
the semaphore.

As an IP block, it will need suspend/resume for other scenarios like 
device runtime pm or system suspend/resume. This can be used only as a 
temporary workaround till that point.

Thanks,
Lijo

> Regards,
> Stanley
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Stanley
>>>>
>>>> Thanks,
>>>> Lijo
>>>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 14 +++++++++++-
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      | 10 +++++++++
>>>>>     .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22
>>>> +++++++++++++++++++
>>>>>     .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  1 +
>>>>>     5 files changed, 47 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> index 7ef7c54ab982..e11c542a01b6 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> @@ -3857,7 +3857,14 @@ int amdgpu_ras_init_badpage_info(struct
>>>> amdgpu_device *adev)
>>>>>       if (!con || amdgpu_sriov_vf(adev))
>>>>>               return 0;
>>>>>
>>>>> -   if (amdgpu_uniras_enabled(adev))
>>>>> +   /*
>>>>> +    * For the reset-on-init path (e.g. an NPS memory partition,
>>>>> +    * switch) the RAS IP block hw_init has not been enabled and
>>>>> +    * the amdgpu_uniras_enabled return false, check amdgpu ras
>>>>> +    * context uniras_enabled flag, eepron init will be called
>>>>> +    * during RAS IP block hw_init.
>>>>> +    */
>>>>> +   if (amdgpu_uniras_enabled(adev) || con->uniras_enabled)
>>>>>               return 0;
>>>>>
>>>>>       control = &con->eeprom_control; @@ -5859,3 +5866,8 @@ void
>>>>> amdgpu_ras_post_reset(struct
>>>> amdgpu_device *adev,
>>>>>                       amdgpu_ras_mgr_post_reset(tmp_adev);
>>>>>       }
>>>>>     }
>>>>> +
>>>>> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev) {
>>>>> +   amdgpu_ras_mgr_resume_after_reset(adev);
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>> index a86ab65aa2f0..ad24c7cf8936 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>>>> @@ -1045,4 +1045,5 @@ void amdgpu_ras_pre_reset(struct
>>>> amdgpu_device *adev,
>>>>>                                         struct list_head *device_list);
>>>>>     void amdgpu_ras_post_reset(struct amdgpu_device *adev,
>>>>>                                         struct list_head
>>>>> *device_list);
>>>>> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
>>>>>     #endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> index 9a4e8715742a..f175c8987aeb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>>> @@ -1669,6 +1669,16 @@ static void
>>>> amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
>>>>>               if (r && r != -EHWPOISON)
>>>>>                       dev_err(tmp_adev->dev,
>>>>>                               "error during bad page data
>>>>> initialization");
>>>>> +
>>>>> +           /*
>>>>> +            * For the reset-on-init path (e.g. an NPS memory partition
>>>>> +            * switch) the RAS IP block hw_init was skipped under the
>>>>> +            * minimal init level, so uniras was never enabled. Bring it
>>>>> +            * up now that the reset domain has been unlocked. This is a
>>>>> +            * no-op for any other reset path where RAS is already
>>>>> +            * initialized, and for non-uniras devices.
>>>>> +            */
>>>>> +           amdgpu_ras_resume_after_reset(tmp_adev);
>>>>>       }
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>> index f627a97797ed..a70e532b3d00 100644
>>>>> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>>>> @@ -465,6 +465,28 @@ static int amdgpu_ras_mgr_hw_fini(struct
>>>> amdgpu_ip_block *ip_block)
>>>>>       return 0;
>>>>>     }
>>>>>
>>>>> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev) {
>>>>> +   struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>>> +   struct amdgpu_ras_mgr *ras_mgr =
>>>> amdgpu_ras_mgr_get_context(adev);
>>>>> +   struct amdgpu_ip_block *ip_block;
>>>>> +
>>>>> +   if (!con || !con->uniras_enabled)
>>>>> +           return 0;
>>>>> +
>>>>> +   if (!ras_mgr || !ras_mgr->ras_core)
>>>>> +           return -EINVAL;
>>>>> +
>>>>> +   if (ras_mgr->ras_is_ready)
>>>>> +           return 0;
>>>>> +
>>>>> +   ip_block = amdgpu_device_ip_get_ip_block(adev,
>>>> AMD_IP_BLOCK_TYPE_RAS);
>>>>> +   if (!ip_block)
>>>>> +           return -EINVAL;
>>>>> +
>>>>> +   return amdgpu_ras_mgr_hw_init(ip_block); }
>>>>> +
>>>>>     struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct
>>>> amdgpu_device *adev)
>>>>>     {
>>>>>       if (!adev || !adev->psp.ras_context.ras) diff --git
>>>>> a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>> index 4f44a917d48b..3f80b9f1f0ac 100644
>>>>> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>>>> @@ -82,6 +82,7 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct
>>>> amdgpu_device *adev,
>>>>>               void *output, uint32_t out_size);
>>>>>     int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
>>>>>     int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
>>>>> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev);
>>>>>     int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct
>> amdgpu_device
>>>> *adev,
>>>>>               uint64_t addr, uint64_t *nps_page_addr, uint32_t
>>>> max_page_count);
>>>>>     #endif
>>>
> 

