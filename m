Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57165C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 10:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB77D10F097;
	Wed,  8 Jul 2026 10:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnsdK2Kv";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C8810F097
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 10:23:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKJvGTQOkNKMvd8vWQeZEZrQmU75jZmpO2evAlNb3OjjQW3yR8oKVLE2rbYeAm/Pu1yJZ8bXU3pzhBDaMDbOlCblMXi4Wzp2/1kjnb/XjM6DjWYLPSHFFLtkgPkYSeqAdHxFzDWfk8DHQ9hWrLMtza1+4vFTTXNWeaKLc4+2SnVO7b4Fe3b466dn6JC0r2fnPsq/NFBplVRfJeAuHCWQ71h9S/UGHZKwyN8exaQfufqZayW1wqm4WQQP434wKOPqvUfRGv2MofgD2P2yxNALxspS/rcPGA/ynqsaY4a5Knlvdi/qPdJhgaCaWGpaPOO7rl8tr9205igcyS5K4LcWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObcHBNN/VndNiVOSgdVkK2My8jLiAtH2GKSfVfyV2+o=;
 b=jPBeU5Lx+uwUTRMP7Tu8uzfKEU3BB4RiFgxP4NDMz5KaVWUwo91zGVtLpGSxskAT3IogI2holyNv1BAL8ABkOD+Wtob67sP8M/hwvtaZIyCcUPqw2hj6XDRL9YyfYk/g2z/Szm3wTddeO8uWye0g6nJEeyb3A6bPGp6dajD+t2MfhpiuXQr4Ms3nHUuhmevv4cCQSkW7UfOMloYd9BYI+LQSJy4uEvJxWynP+n9x2RkE4OUGlsIbHJAeMAcBpxco4yKcH7KTuDyHdg5F2wQfmAzGgq6gFzBP6KjLabiuWq5zjWugYgmQf7Vwg73Upijd1J1hrTKv4NefUywLvMgG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObcHBNN/VndNiVOSgdVkK2My8jLiAtH2GKSfVfyV2+o=;
 b=xnsdK2Kvb16eDKYWdnpDp3Vde2seL5m+//puTy8xvC15HJey0+DND3uOH6gpH4ymTQNiDZPI2tF/C2cfzXVOgm4XgWy6orgQ1omym8RWMG4F+7ncNjcGLcDtOFrO9y4lPx7+TILOCk8HH98p73KeuYL+CUaXT+hFxJQ8qJZrps0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 10:23:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 10:23:42 +0000
Message-ID: <de530731-21de-4470-9316-dccb767c87ac@amd.com>
Date: Wed, 8 Jul 2026 12:23:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: "Lazar, Lijo" <lijo.lazar@amd.com>, "Li, Chong(Alan)" <Chong.Li@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
 <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0433.namprd03.prod.outlook.com
 (2603:10b6:408:113::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d68cc3-7cf2-45e0-7af3-08dedcdafc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|5023799004|11063799006|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AbMHsvM3lg1HBCIbM8pWwloZvMOHV4UrsjZVXqD5NCfXTeaswpTaF0KjDUJB9xMTJXVLMyBrzDftAYa/wI7ViTcwdT1CoIhkOSZORz9CJTMriF8acDH0BWjnz54PTO2z3JkqdxixM71w+AhcDcAE2xstAT0cLpEPw1gYZOuP9RnUIortnbeUwIzagUqnCYh05FYZ504kcOqqtgkVmKAEBq87gVX+HmKUrm3N7B4OhDTEN7YXdRvKoe5+TF9S5Cgf27R4X1B5eD9MGRQF34fQToORPPlk5EUEWq0Xr9lng3h8wpPcAb8SkhEuK9AUSDjL2HfjSZxXbsilZaLmOfc9ywC/qHK0DaGKB8H8/3L5Mfo4BLFIoGdbIX1Uvg44IYA91tI8t35dcp+b+sKknlrq+1FFe1b4bN23ROCq0+ajEbq9xEI3FZ4nK0rOg9mtFdqTofYs8ix4tkZzssaoA0VQJafK13mqmqdvosQTsUq5HM/X1TrPfOq8WRlfOetSw3xQA4wdljOSR6PvGaIh7+loW7WlHJHBJ13qXC2g5ROPC9ky9J9bGnKC0XpEdjXQls1O1NmPP5Ia6FRMzYKGEHvgyjRo33HrnoMXW5jxUloxmWK6XgMTt7t+O64yaQwiur1oAe/AaSnPu/WXOtmxy0oWQalMQRtKYCTBGp5vk0klLDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnRrOWl3TFhPclJhdkxIZnRZeXp6K2xCK2NNOEdpWjBlbC9yYlBjeHZ5TmMz?=
 =?utf-8?B?bFhUQ2RvOFVjVkVzMVZ3Y3ZISlV5U1YyTDJWWDNvV09Td29UWWhHd09LNklG?=
 =?utf-8?B?WmR5eW9TSE43MkRDR0I5VTVSMXpQNGFobmxzQ2c0bWovYVg3cnVlSy84SWNk?=
 =?utf-8?B?aXY4c3lNODhvU3lvNDk4dkZFSjlyUWdQNnlkaDB6bjFqNUo0aG5ZN3Q5Wk9P?=
 =?utf-8?B?UW5hZ1N6RDJ0SW93VHJPWS90T3k3NysxaHZzMzBmY1NjTmJTbThhWE92Yytp?=
 =?utf-8?B?Z1Zsb3FyVytRdmlFb3hCMmVlUXNYaXJiUjFTT3FKOEYwME80RG01WU9jc1RV?=
 =?utf-8?B?R2lxNTNSVWpMNUZUUzdzN0xHZlpEUUtZZTVHMFo3NnJ5cm94VElqb1ZHazgx?=
 =?utf-8?B?Vm1aaHJ6ZXFqUTlUZ1VJTVMxMnBZV2FIOFp1WTZ5ei9zNXRsbWgvRnRoUXhQ?=
 =?utf-8?B?VU9JSmhjUGZIUGgxMW52WnlIeVk5TEVwb0xYM1pSSWtkR3FYeVFydEZnT3Zn?=
 =?utf-8?B?d2U0Vzg0VXl3MXdmR0t3ejFMb2hHUWhyc0twZXAzTHRxR0t5R0xaR1lFeXVR?=
 =?utf-8?B?L1VDOXhCTVZRcmsyREN5bWN4UXRQbE10azBObW1nb1FYMmlkckgvZDBYczBQ?=
 =?utf-8?B?YjJySVU0Um1QWkRtaGV5c3pKTjdmSlB3SEgyRHhLeEg1eFhPZE9lMDNRbHU2?=
 =?utf-8?B?dVZrRk5zR3grQjh0cnhqNVUwbGJid3RUa1ZNK2QwZ29oRFVMdzFCT0grSU5D?=
 =?utf-8?B?ODA4Szh0MnBtNTlVRnlJdEdQakVoZFowcU16enZTM2t4bkhNWTNmRSszMnMx?=
 =?utf-8?B?K21UNllIWjBrTVk1RmVWQWQ1eWxFZ0JnQjNTU1RtUmJ0d1BNRFNmOW9ka1JX?=
 =?utf-8?B?VGRIVTRaOG1qYVFDNEpoc1FUa1NKRWhOTE5nSjZXUjc5Wnk1a2FrZHhmZ1Y1?=
 =?utf-8?B?MXBCT3R4Uitha0FNUnVwME5iMVh5SWY0QUxBNHRDVDFHMjhGTFZSaCtzRHo4?=
 =?utf-8?B?bHJPanJZTDB3MlVLR2d5aFBUUVl2M0sxdFg4NEZIUXZjVFVtdzJRVlNnSjRi?=
 =?utf-8?B?SWJZV0xSZXdxa05ONE90K3RVUkdCRGhqU3ZjZ2FGV0FZMWtLbUFEL1R2YkdW?=
 =?utf-8?B?UUVaUlNXaUwzdEIwWUVIWWdCZkRzQkhjMjJzOFRFYVBubTlMWmhJWk1YdnpV?=
 =?utf-8?B?anZqU2R1SUZsUFExMEZPWWtQS2tlSjdTNHVpUXAwemVTbWkxeUpybGMyTkU4?=
 =?utf-8?B?MXhZbFdCUkt4dWtnRGd1aXBocVZkbm5tUGVSR2JSYnJqaTUvOXA1UDBJam1W?=
 =?utf-8?B?Y1JVbWI4QTF1cERsbTJFclIvWlJFODhqTzBHdmh2Q2lBeUdWZ25uSlFwcnIr?=
 =?utf-8?B?SDc1MXVnNGpBNktUaUF4bTlDOFZBU2lic0syOGVTOTRKQTdUWUpMUkJwYXZO?=
 =?utf-8?B?Nm5HNGlOYS9VVFZQY3dYMGVUam8xMlMvUnFpVm1jc05BYXJvdmdreDFYQVJx?=
 =?utf-8?B?VWJvUi9kV1ZEQ0VpYSt6Q1o1MkVmK0k1ZFg4TGxyYldBN3owVzA2c3RTRHdU?=
 =?utf-8?B?bzVNQlBLa3ZGOEpaYksreE9QUGJyQ3V5MjIzbzUyRUFuRTJjc2ozY2twTEFQ?=
 =?utf-8?B?OFRISmQ4ZjAvNHcxK0ZPLzMzdWxxRGJjZUEwc3ZwdzNsem9lZmczcDV3QWlW?=
 =?utf-8?B?QmhMNFN1S3dlM3BSOXFRNVdNOXVISzhXUTRMQVduYXU2UDNUaG9Fb2hRWmhD?=
 =?utf-8?B?Y3A5TSt4akE2YlJwVk5zRkRLaUxWY0NLdXJhbE9VWkpMTTIySlpLMnpjN21D?=
 =?utf-8?B?aXMwTXpCVW5uK0M2Njc3L2Y0ek5rRlY3REtOWEJNZkFWOUdtSTJiVDkwR00v?=
 =?utf-8?B?cEp5VHVjeXBnVGlrKzQwazhlaE9hL0JDb2l1L09iaHFXdC9lWTRhb2JyNDB0?=
 =?utf-8?B?L3psM1lHeTVXS2hUTHZmeFg4NjVUYTJ1WEFFQTkvbHAvL09EZHlibnI0Qy9s?=
 =?utf-8?B?K3l3Mjd3Uy96NXJFVWVFVmR1QUNraGFUSG5CL0FEeG4xSjV3NE5zYmxKM3lI?=
 =?utf-8?B?eDJLeXE2Z09sTXFkZlRqVE9wSnMreDVnWStPU2tuRTVVYzhmK245eWFUQnhR?=
 =?utf-8?B?MGIxZWhBNzRFTjZ6WWIrWTRBL05taitSK3Q0MDJLMkNxUUQ1UU5tOGRKblR2?=
 =?utf-8?B?RzRPaS8yMk1BOE1rZzU5RVNXa2txKytkRlNSaC9xaEI1KzRyVnQ0b0t0anJJ?=
 =?utf-8?B?Ty80RmVlWjljd0tiMWlwWEw0VmNCZ1ROMG9ZVVNLOEtLU3JLaDE1V0pjM1NF?=
 =?utf-8?Q?EZp0jnzlx8rbdpI9n6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d68cc3-7cf2-45e0-7af3-08dedcdafc01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:23:42.3467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEVO40QkM3aIMv0MgmugRRWRGdwsUOSCb2IZ8vGesislqnIy0RNhPeNhaaoBig6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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

On 7/8/26 12:03, Lazar, Lijo wrote:
> 
> 
> On 08-Jul-26 3:23 PM, Christian König wrote:
>> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>>> AMD General
>>>
>>> Hi, Christian.
>>>
>>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>>
>>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>>
>>> Distinguishing the host platform was a mistake,
>>> and I have explained the situation at the end of the patch email.
>>>
>>> I have pasted the content below:
>>>
>>>          Hi, Christian and Lijo.
>>>
>>>          Sorry, I made a mistake.
>>>          Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>>
>>>          I borrowed an ESXi server and tested this patch there.
>>>          The amdgpu driver works normally.
>>>
>>>          I rewrote the background. Is anything still unclear?
>>
>> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
>>
>> As far as I can see that is Hypervisor specific and a NO-GO.
>>
> 
> I think this should be seen as a policy set by host driver on when a guest operation is allowed. Host driver could do it based on other conditions also, not specific to hypervisor environment.

No, this was intentionally changed in 2020 because of a new feature. See this commit here:

commit 00a979f3d69e0c275e88c741b854dbe0d5238ae0
Author: Wenhui Sheng <Wenhui.Sheng@amd.com>
Date:   Tue Jun 23 13:43:49 2020 +0800

    drm/amdgpu: invoke req full access early enough
    
    From SIENNA_CICHLID, HW introduce a new protection
    feature which can control the FB, doorbell and MMIO
    write access for VF, so guest driver should request
    full access before ip discovery, or we couldn't access
    ip discovery data in FB.
    
    Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
    Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

So as far as I can see this change here will break older hypervisor versions and that is absolutely clear reason to NAK it.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Chong.
>>>
>>>
>>>
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Wednesday, July 8, 2026 5:05 PM
>>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Cursor <cursoragent@cursor.com>
>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
>>>
>>> On 7/8/26 10:25, chong li wrote:
>>>> v2:
>>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>>
>>>> v1:
>>>> Move the initialization of non-GPU resources out of the full GPU
>>>> access region during AMDGPU device initialization.
>>>>
>>>> Background:
>>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>>> VF_FB_EN and places early initialization data, such as IP discovery,
>>>> VBIOS, and PF-VF exchange data, in the VF FB. The guest should then be
>>>> able to read this data before requesting full GPU access.
>>>>
>>>> Before this patch, the VF still requested full GPU access in
>>>> amdgpu_device_ip_early_init(). At that point TTM is not initialized
>>>> yet, so the normal VRAM aperture mapping is unavailable and the guest
>>>> falls back to MM_INDEX/MM_DATA register access. That register path
>>>> requires full GPU access.
>>>>
>>>> Use the BAR0 framebuffer read path, amdgpu_device_read_fb_via_bar0(),
>>>> for the early init-data copy instead of MM_INDEX/MM_DATA. This lets
>>>> the driver delay the full GPU access request until after the early
>>>> init data has been copied.
>>>
>>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>>
>>> So once more: We can't adjust the driver to the hypervisor!
>>>
>>> Either this works on all hypervisors or I have to reject the change.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++++++----
>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>>   2 files changed, 19 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 610d82b79de3..ac66796e8634 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -38,6 +38,10 @@
>>>>   #include <linux/apple-gmux.h>
>>>>   #include <linux/nospec.h>
>>>>
>>>> +#ifdef CONFIG_X86
>>>> +#include <asm/hypervisor.h>
>>>> +#endif
>>>> +
>>>>   #include <drm/drm_atomic_helper.h>
>>>>   #include <drm/drm_client_event.h>
>>>>   #include <drm/drm_crtc_helper.h>
>>>> @@ -1987,16 +1991,19 @@ static int amdgpu_device_ip_early_init(struct
>>>> amdgpu_device *adev)  {
>>>>        struct amdgpu_ip_block *ip_block;
>>>>        struct pci_dev *parent;
>>>> -     bool total, skip_bios;
>>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>>        uint32_t bios_flags;
>>>>        int i, r;
>>>>
>>>>        amdgpu_device_enable_virtual_display(adev);
>>>>
>>>>        if (amdgpu_sriov_vf(adev)) {
>>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>>> -             if (r)
>>>> -                     return r;
>>>> +             early_full_gpu_access = (adev->virt.req_init_data_ver == 0);
>>>> +             if (early_full_gpu_access) {
>>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>>> +                     if (r)
>>>> +                             return r;
>>>> +             }
>>>>
>>>>                r = amdgpu_virt_init_critical_region(adev);
>>>>                if (r)
>>>> @@ -2159,6 +2166,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>>        if (!total)
>>>>                return -ENODEV;
>>>>
>>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>>> +             if (r)
>>>> +                     return r;
>>>> +     }
>>>> +
>>>>        if (adev->gmc.xgmi.supported)
>>>>                amdgpu_xgmi_early_init(adev);
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> index 9a40107a0869..340703d89d6b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>>>>        } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>>                /* Dummy REQ_GPU_INIT_DATA handling */
>>>>                r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
>>>> -             /* version set to 0 since dummy */
>>>> -             adev->virt.req_init_data_ver = 0;
>>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>>        }
>>>>
>>>>        return 0;
>>>
>>
> 

