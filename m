Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090E8CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 11:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D9C10F34C;
	Wed, 30 Sep 2026 11:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XJQmiQGY";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315A810F349
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 11:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjDBHmarcSk2CBfKeTg3fhZ0coYjL8mX+xrC1yhXuYeuxpxbUfGwsH3HdLEtVseNRVv3zabrvfIJtHK/+7jM0GyD7LlzXNHUm6N/A6TZgqo3NpHnQJuYa5EYI5LhkqUVt/z+XSFZjnYG5cEdBOlnhOS/fpB9IOTNHwfA5In1uaspQ1bL5f0qm3aN1nnrHv+9snLj3swMvxfLrS/rEqhOobzNd05A8JWhkv7532fEMathjA3VlhX3jpnd52XI5+jMrFrK0zmqLTtlWL9uB3QuhZ8DPXicE2tupabxsnpAmd/T1aUkazZUOi7UAsdFqOMVgspm/S5SmtpYWxkH06QNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAMnZffI12gHAGIwebldT9wQDK/ZiqZTkHrJC9AHpSY=;
 b=FqVRIpV62EYCthHflVFx/ASDlCasfl+G2qNodlEuYYnpmVkunMDZJDDxMoZGrtOyGZInkNu+iiK5F++zQR8lydxrQ6JhrXbbIHIo8fWy8uebcqzZRuX6wikgZeX30B9kcp/jEEaqT9OhQaSlUU3M8alHb9crylwMpiG1k5wYU8UGTF7/5AG2YtD/OY59Fk9eWNhH5Ah8XA9EtNtvMYIkVTiqt5ElEmAV/Pt4MY443NVCJXvF4yRkVyd8lQxCS7+3b6LBjXNll5uu0BzzNXL4FhrML8thae6+aU6zjsurlaJ9/72mJDu9kX8FG65G6fvm349wfeRHXkwRZJzee3ogQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAMnZffI12gHAGIwebldT9wQDK/ZiqZTkHrJC9AHpSY=;
 b=XJQmiQGYMpA3vQj2rdMv5baCiRS3FX0SO5fgfNPxak2X3124gJ4YwXRldev5n6mtgcy1d4Lbu3bYqPn/CxoVzxXWoRo+jb9pTuStxPpIMWSqbjEP3+XlobuRvHGQb/HytBRxk5DtrY5FIhkOmrfs1CBZb/pieZ0+fiE5hgORudo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 11:58:15 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:58:15 +0000
Message-ID: <36532d93-3880-470b-9b64-38d3b24d0060@amd.com>
Date: Wed, 30 Sep 2026 17:28:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub to
 vm_manager
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930111601.3721001-1-sunil.khatri@amd.com>
 <2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com>
 <8939b352-899f-4327-a8ed-26e12e3b6c39@amd.com>
 <0e990a33-7251-4c96-b52d-e87f924eee99@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <0e990a33-7251-4c96-b52d-e87f924eee99@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a561b14-bb93-46dd-1e91-08df1eea1bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GHwmDVnI15mG/zoUe9KYO32RrZcdr4XF+dKiLTOIQqCCU5HhricAMSSR0AWO4TPF+Ojcc4hmsq9Px9AGdMi72ACqUxDqGhZxttmPkMPbmQt4lP87484jgON4Tl3saYOpL+dMQJr+LuuE+DJ4CBseAssFK0nygOnVr0XNiutXXw0haIP+gTZQKnNexQwcL1uIhIkCJc3WeGTYY49HZvlKWuen8YUXqtn090byPF5oqVtQWNiS3zLKnbV361TR01oYZ9E5ZRKSI498TYVq1ZI23yo639v5kU3mY45vRq+qnV2weJHVgD+M+CbkKftp+xxF9TDAe03QCdM2Xg5lBg0xqSqMVWqO7OBzRMarZoJd4mZo60zkLiSNr8Hd5Ts+CS1UlAT5LvxDMVi3zcjozPMdCTSQ4IoM8hHphn1kRGFFGWkQhVZelQQS7CvVNoDxyEWeRwaHB6vp8puegg+bwwWLcRfHnBzuacc1EJccHx42Lso8y1SMtUHNhFhH2yk552Wm0ej1jSvC1vsDOTgfYjUeFh3+sNAMtRddMobcLDylFgnYVejuVfhbMLJw5GV0q9I5dnisCKAar8WsmGsYsM5NJjiNFWqHl9fYHagQms4khEihZbnSqmeO6iVEepslAcEUMB17t7QyPRGqrXP0LPAUGkEXoxD0nqPkzZdt3lyz9dY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEpuMGpLYjFNM2xPRWdrbDRldkpDSlNpZ2c2NHFGSDdCckIrc25ycEJwTUFK?=
 =?utf-8?B?MW9kQ2c4ampkUTVvZmdCcHdtY2VNUE9XaUtYSkdzR29MOHhlR2tKRGJuQ2VR?=
 =?utf-8?B?Z2tybTVMRUpMbTlSQVR4MnRGTGFxYUdGK1J5c09VZGNheVBPK3E4dEpMUk0r?=
 =?utf-8?B?QkVOYUQyeEVFbTBHMzB6NldFdTY2SU1hRHdQaU1Ebzd2VVRhTDRiTnY2UUtm?=
 =?utf-8?B?MEJlbVdpcnd4SkJrSVRZbThoeVhFOUVUMy9OaVRGa1ArMjJXeU9LSEZ1RTIz?=
 =?utf-8?B?bzRyUkpvQ2EvdEcwY0Z3bXMxRzZVVGJOQm5JUSt3azIvWm5GTUtlZUJ1dWtm?=
 =?utf-8?B?QXpIVzhxOFY4blV0VmRPNVpuRjNVUUpBTzBQUUVUcjcyVjRQQi9uZnJRa2Fy?=
 =?utf-8?B?VU1aTjIvanJIVWJVY1kwb0d6WllUdHNLQWlYdEE0ZytLUE1yQ2JMNXRrSXg5?=
 =?utf-8?B?ZE12RlRRMHVMYlJBeWdYMUVFY3FvTzM4SDJoa2cxS3dqZE9VanFJOGNVdFlD?=
 =?utf-8?B?Rmx2SElHTzVVQ2sva2RTdXhFRGluU2pxMmdscmcxTU9RS0lRbkhJeWZpb2Zy?=
 =?utf-8?B?OFBTUUhicjI0ZERxOXRncis5SlFZQkh3Sy9YNGNVTStVNzFiQTU2WURiT0gz?=
 =?utf-8?B?VHh0aC9uT0ZwR0VvN0NCN21rVm9MRmFsZy9BVk5JRTU5NE1BNXd2WVVZcVpC?=
 =?utf-8?B?ZnlaRWwzVXMrNjU1UlM4QnBQMjZEZVFRMXN1ckErVHhpcDBKUkFLTXlHWWZN?=
 =?utf-8?B?cDhndHBEWnV6THgyZFRLNGlDaEx3MmU1ZXdmZHY5cEhOcWQrMUFZSWJacDZp?=
 =?utf-8?B?a0R0VURLNFQ1WEFaQ3lnVGVuQlFnNTlvY1FCR21lMlNCQmhOWHVhUytoUWZ5?=
 =?utf-8?B?eWQxeUFoSFhONzJ1bE0zUkt5amFzMTJlbTB0SGJvbkZHNzR5Q2ZaQVY3dWZL?=
 =?utf-8?B?Uld4cDNxYTYrSjRXa0srbzZLZFZ2Z295WmcwWW94WmtFeDhFbHdUbVBMSUoz?=
 =?utf-8?B?ZzFTUDJMVG9TYjRhYVJuSzNUdTNpZXdmUGgxVU9VOXRPWnZVaGVDdGhHd1Nu?=
 =?utf-8?B?NWRKWnpxOW1zZThqT2I2RWpDSWpvU3VIckd5Mkt2Mnc5c2lyRHhXa2QrWTdj?=
 =?utf-8?B?RndpZzYySUxCYitLL05pSVhlcHdVaXY0bjdBdmlCQ0p2REJxU1I2OWR1YmRH?=
 =?utf-8?B?R2pSSXdhaUdJTDVqZzFSbXYyRmJ6SlZ3WVJiQktOT080cU00WE9Qa0xGNWZE?=
 =?utf-8?B?a21Zemord0RPcTJtSW96WnIvSkg0VzlXQjEvejdhNGZGdDVSOFJ5aVNLdEx1?=
 =?utf-8?B?NUt2M2dYY1paNmVzcGFXWlNuODFUUlgwWTNLYk5TUnd2MmhKRGVhRW4wR2pv?=
 =?utf-8?B?Y083UlV5WEpBeHNndDBpVlgzZUlrVGVGVVkzdVFXWDJEK2JTK2tJajlrUk5y?=
 =?utf-8?B?eTBsa2dzeldrZDhEUCtHR2Z4VStiNTc4UWYxUGU5eFNVeGJzS1h2Q2I0SU1h?=
 =?utf-8?B?dkNzUkFuRUVCc0lmS2pRU0M1eXNJVWpRcDF1ZVlIcmxHSTM1dm9xUGw4WTdh?=
 =?utf-8?B?eHJuc0dUSTM4RVNhRktnelNxY0JoRDd6bmxVMXRENUFuWkRoY2R2WmJQZFc1?=
 =?utf-8?B?WlVIT25SSmNhbVB4U2xDdGRJZ2VUL0pWekN2UDlUaERKTCtQMDdvd2M0SDRJ?=
 =?utf-8?B?b3VvbWtDbVdrUHMvQzBSMk5wdFoxdEJZMkU4WHo2aHZ6eGpjSEJndWxJbGww?=
 =?utf-8?B?MHBIeXRKNEZBSWgwTDBrWWdDYVAybTk2NDBITFpoVWhtam8ySTVlSmlCRDd2?=
 =?utf-8?B?YjE3c2RVNEpRMkkxTHJMMWxjdTlJeU02UDFxZkh2d3JaUFJvWUc5OHNkcHBh?=
 =?utf-8?B?RUlWUGNnajZMSzArTGh6MCtwNHUvYWxJSG5hUmUreDdqcXJyWVlZOWo5YlNV?=
 =?utf-8?B?Y2lUSXljNXhtWlpOTVo2OXpTQ3RwTktzOGZyNHpGT3ZaeU5nVGYzaFl1WVJT?=
 =?utf-8?B?OXFIZWhVWVFHSHhsVnZ3bXU5Z0JTUkJ4RkxXaFhRYXRBeUZlQ1hwSXRvQ0tw?=
 =?utf-8?B?c2N2U29wUmZ0RTkyUnpKZS9kSVYrNVVUSTRGSFlxUlpxa1QyOTJXSXZNdlYv?=
 =?utf-8?B?ZFo5cmZ5OU13WnV3djJPRXF1SldWckZ4Tmp5djNCRnpQM0luSU5FSjBxczFT?=
 =?utf-8?B?eXB0a08zWUFGbU9rY2Z5d1F0MUJKTVFGS1FGeEo0ZHNEMGdtVnhXdUFnU3ZX?=
 =?utf-8?B?WG12QlUwR3ZDTE54R2V1dzJwaXIrSXlJQkF1NmVrb0R1WGRUeHpyVmxyQnVE?=
 =?utf-8?B?MUhQZlR3S2FsZklkOVJTRWYrQXV0aCt4N2FyNVRvM2VjN09Qa25wdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a561b14-bb93-46dd-1e91-08df1eea1bbe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:58:14.8466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHXo1coN3mAAXrumbvumL0U055MSjWA68xz+yR10ggC9uknVoHUXhWGa5t8swkGCLpPyfVclNf3sIWIu70l/yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
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


On 30-09-2026 05:11 pm, Christian König wrote:
> On 9/30/26 13:35, Khatri, Sunil wrote:
>> On 30-09-2026 05:01 pm, Christian König wrote:
>>> On 9/30/26 13:16, Sunil Khatri wrote:
>>>> vmid_mask_gfxhub/vmid_mask_mmhub makes more sense logically in
>>>> vm_manager than the mes ip struct.
>>> That's the VMID mask for the user queues, so I would name it vmid_mask_uq_gfxhub/vmid_mask_uq_mmhub.
>>>
>>> Apart from that looks good to me.
>> Noted. Another point here if that is the case then should i change that in MES HW layer too..
>> unionMESAPI_SET_HW_RESOURCES{
>>          struct{
>>                  unionMES_API_HEADER   header;
>>                  uint32_t               vmid_mask_mmhub;
>>                  uint32_t               vmid_mask_gfxhub;
>>
>> Should i update here too or this is fine ??
> No, that is fine. The MES handles only user queues here so that is unambious.
>
> But thinking more about it, we should also do a bunch of more cleanups.
>
> The structure amdgpu_vmid_mgr is really the per VMHUB structure for example.
>
> And the vmid_mask in the that structure is really the mask of VMIDs used by kernel queues.
>
> We should probably name that structure and the field more appropriate.
>
> Regards,
> Christian.

That's true.
But since it is used by both GFXHUB as well as MMHUB so something 
generic seems ok to me. But we can change vmid_mask -> kernel_vmid_mask. 
Suggest if you still think to change the amdgpu_vmid_mgr to something 
else like amdgpu_vmhub_vmid_mgr or amdgpu_kernel_vmid_mgr... but these 
names seems pretty big.

Regards
Sunil Khatri

>
>> Regards
>> Sunil Khatri
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++----
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 4 ++++
>>>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ++--
>>>>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 ++--
>>>>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 4 ++--
>>>>   6 files changed, 14 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> index 5285c1d1fd4cb..9c36ccf5d5659 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> @@ -137,8 +137,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>>   	total_vmid_mask = (u32)((1UL << 16) - 1);
>>>>   	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>>>>   
>>>> -	adev->mes.vmid_mask_mmhub = 0xFF00;
>>>> -	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>>> +	adev->vm_manager.vmid_mask_mmhub = 0xFF00;
>>>> +	adev->vm_manager.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>>>   
>>>>   	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>>>>   	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>>>> @@ -184,8 +184,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>>   
>>>>   	dev_info(adev->dev,
>>>>   			 "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
>>>> -			 adev->mes.vmid_mask_mmhub,
>>>> -			 adev->mes.vmid_mask_gfxhub);
>>>> +			 adev->vm_manager.vmid_mask_mmhub,
>>>> +			 adev->vm_manager.vmid_mask_gfxhub);
>>>>   
>>>>   	dev_info(adev->dev,
>>>>   			 "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> index 594fb817e0a38..2b13a5b375393 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>>> @@ -122,8 +122,6 @@ struct amdgpu_mes {
>>>>   	void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
>>>>   	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_INST_PIPES];
>>>>   
>>>> -	uint32_t                        vmid_mask_gfxhub;
>>>> -	uint32_t                        vmid_mask_mmhub;
>>>>   	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>>>>   	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>>>>   	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> index 98cdd7e3475fb..5f22c146e2339 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>> @@ -413,6 +413,10 @@ struct amdgpu_vm_manager {
>>>>   	/* Global registration of recent page fault information */
>>>>   	struct amdgpu_vm_fault_info	fault_info;
>>>>   	unsigned int				npa_vmid;
>>>> +
>>>> +	/* VMID masks for GFXHUB and MMHUB */
>>>> +	uint32_t                        vmid_mask_gfxhub;
>>>> +	uint32_t                        vmid_mask_mmhub;
>>>>   };
>>>>   
>>>>   struct amdgpu_bo_va_mapping;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> index d1cd665ab301c..178ef8dfe6d61 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>>> @@ -1080,8 +1080,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>>>   	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
>>>>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>>   
>>>> -	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>>> -	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>>> +	mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>>> +	mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>>   	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>>   	mes_set_hw_res_pkt.paging_vmid = 0;
>>>>   	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>> index c0719d8fa63e9..f2dd4323ffd3e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>>> @@ -1042,8 +1042,8 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>>>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>>   
>>>>   	if (pipe == AMDGPU_MES_SCHED_PIPE) {
>>>> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>>> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>>> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>>> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>>   		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>>   		mes_set_hw_res_pkt.paging_vmid = 0;
>>>>   
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>>> index 20159fb9d6ea3..c3e1f9a746ce0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>>> @@ -685,8 +685,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
>>>>   	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>>   
>>>>   	if (pipe == AMDGPU_MES_SCHED_PIPE) {
>>>> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>>> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>>> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>>> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>>   		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>>   		mes_set_hw_res_pkt.paging_vmid = 0;
>>>>   
