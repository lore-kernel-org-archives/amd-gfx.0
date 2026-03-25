Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114B0FEA806
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 06:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C5410E1EB;
	Wed, 25 Mar 2026 06:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y8ORt1RJ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5D010E1EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 06:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LffSc8wch8NWKJ2A+n0gUSRBBFtlyVDzzgyl6Cefs2XJFKCCHhZihq0ORoYs1LVl9eai6l9kx86AYRTudHpdYLjx1dffJdrvz9eoOdkKGWHQKTZ13cswQVErBX38QtceV2cbHUO8/QT9YBJjM3a5jrS9+xnMB2H0TkjY04sh82X0S/l3wkZo/xHarW2/OGwknc6VY6x43Cc14JyjJZAiRrtSHINdRSWiGqHGlDYYyyDX+o6pw7kDnPBOnPXq3Bo4kXCT3LdASOatU6jmuMzVeyt4QCzsK9MKtB8vkH20yY9R+uzkRK58fMWo+CoJW41J4ZUuG72xAUGtZurit9C7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie690/x6Px9dTl3AekZppno59v2/O7vHS14KtYoEVJE=;
 b=Wd7H/O8qVfkw+wUdzrPYmCDucZhS1u+EoepF3xulnf7nCCQX2NvhWcMWqIBAUPj3gSC6aGGs8WBhLcyijlx0Sw9Mrr7q0YKT9G58Vl6UYZjUaqG6yAD8BAVbgOmuxC2qg/+w37NjbCAYaWFXhPWZckStgdvGQ5Ozqm53nZd7nYY2MKKgPWPwQQtQ+OoomB0s8xhzJ+gBHiF5Y94VEF2g+qPfDnVFC62iqEZDAu5AI6ts5sAS5MZ7xAiWCUnoW2ZD3OWdA5PWODwziEMtcpH1dMWoBEuXvRaJlkonXGw5GzToN2WaXrAn/ZFQL6qomQ00VrFEovc0mfsqIuAPf3SwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie690/x6Px9dTl3AekZppno59v2/O7vHS14KtYoEVJE=;
 b=y8ORt1RJ9UrVZXGEVw2CGPgyuRyZJgoyBtyDB1aZKDYuvAWOoMiHYzJHUoc25lMZQpHS59/YPsMxZztzqCpfjOSC+eJhx+nFWbyTLRuF2CfAe9jmjc0s3YAJyuU0xrMOPC9cRJ1x80ux10pVaiTI4ikmLsY8LLl4QWhdUUnz+s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 06:27:30 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 06:27:30 +0000
Message-ID: <abbb3c91-9629-4648-8a6e-d962be6a0803@amd.com>
Date: Wed, 25 Mar 2026 11:57:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/amdgpu: add support to query vram info from
 firmware
To: "Xie, Patrick" <Gangliang.Xie@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
References: <20260325040727.2016678-1-ganglxie@amd.com>
 <48d5730b-384f-4b97-918b-ce9a63e5ad8e@amd.com>
 <0d8b475e-6858-4056-a0ce-b4010ed6aba8@amd.com>
 <BYAPR12MB2597208291C54BEC86D3F652E549A@BYAPR12MB2597.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BYAPR12MB2597208291C54BEC86D3F652E549A@BYAPR12MB2597.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8c59cd-2d25-469f-6713-08de8a379768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: h1VOgkPHw4OGcLhyU4UOA2XJOAs2jRWFbcZzCVRYZ1rL0IbjSxJORnbjp7UsvRoVUVimZoTJQN9a4yL647CobgpMQcspJNnJuCiI9MlKESEYuXtyglhtOqi9ApJlCG72C4zKcWup0s6bwK8IvnIodNgXb73KD9uNFyMe0gLdYrC0To6eGGzbRz2SRmdOW2Hp5NgGHKRfoDvLqHUE3avoA03nESbHmg0LUCnZrryAXH3dtZziAApOIq97ve/45s6kNmPiNAAJRawQcYPl4M4aaD+NQjWyQawlYU2bA3vExtnAFzvCCY2U2Px9gslu0zuiBENGsZAGNjPOlxjjPi9+bRxF6yxWgUNQ1jnHLS3tUq7h5z7iFr24HAPAHR9ZTXMIeso77mGNPgemuQoHVfraFuRDXWmZLuMPL9Pzq8Bnu3YzqmILBJvnOm+52bhcupzLHxz/tSSXwiR+v34COVQExGEAOtp7zMyu6WVFgl5KtQvdrvnmKmxpF+n8fWoK1W2tQH4rJoNMKZHWt6OwZezcaEIwm6d7Vm8ZhjiENZjp/4Cpdfyv6S+uuEUa2ZGP2udVPf2VmlqS14QKIwhbSQx/+oHWqj/JhE2uIidr8Awyvdmx5kFXqqQ6M67O3k8RkGDEaEn1B9X2zAKN/ZhbXc6xoHqU9YTpVW1c/o1yoiPGGrXYU4/9b7ay2WfAaPQyjCosfCQt5JbTawFZxXrrJE7Tz1UgAbQ6sEHiro0zVjuuTwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1ZNSDlFeTVJdzZ5UTNDRmpLN1FLeTdtQk5CYlBkbC9zZkpBalJxVjZMcnpz?=
 =?utf-8?B?eVA2dTcyNElNRGVqeVNWakxpMXptdlIyU214NlpsVEM1U1o4M3l2WUQ1NGdp?=
 =?utf-8?B?a1ZXeFYrdUtjaStiZWNHbDNRazJBSUI1ZkF1cXZ5c1hQeFNQNnNEOTlUdnJo?=
 =?utf-8?B?YVVRckdmR2FGanprWW11QkYyQWtDaHFmWDdsTjRFUERmQ2RzV0lMVzBQNm1S?=
 =?utf-8?B?ZUtIbm82UlJySlErZkdEak4vWCtDSFVORVRpeUZ3RjhjYTF4RjZBL09qQ0JX?=
 =?utf-8?B?bVFRSVpLZlNVLzZucjA1VTlNSlVORExuRGsyNDRJeWlBU3pzQ1VjQlo2eW0y?=
 =?utf-8?B?UkZ5WlpnU3ZSaitQZ0JOR3dOODcyVGpJVVkyZUZJK09vcENEWDlxeVhJeTJB?=
 =?utf-8?B?YkMzZ0F6UTBxVjBVenpraVBQaTV5Z0E1Y3JvenMxTFhZaFFwV0V6MUZmTTU0?=
 =?utf-8?B?c3dLWnFpNGd1d2VBMmNYOFV3blRWU3BpdnlHVitlZ0lTUXZ0VGxENENQdDRM?=
 =?utf-8?B?Nmc4THJQbTIxYVJ6M0dhWHpnRUpERG9WbXNVcU0reUVZUWllZk03QVAzcms0?=
 =?utf-8?B?cFVIR3hGak9qcVNzY3J2YUwyN2k4QjU4cmI0ajdyeGU3d1lyM1cwdlJ2Q1Ro?=
 =?utf-8?B?WlpHUXRJMXl6ODVZU2R5Z2FLVS8wUTZhSEM5TXJqSXBEKzJiejNyUmNwcnRr?=
 =?utf-8?B?WVVrZ0VaOUk2MXN2S1dDbHQ5cGNWbVg5eGNZWUZTSFA4SmlFZVpwR1RpWWI0?=
 =?utf-8?B?U1NRQmg4VUF0bjVPWHI0d3kxYkpJdGRDbHA4REdBKzAwMjJZcHlZTmk1Skdw?=
 =?utf-8?B?K0pjWTVWaDcxM2dtRWo2NWt0QlhHZkIwZVAxMmc5R0lLUVI5T2d6UW0vS1c0?=
 =?utf-8?B?eVQ2UmQ3U2xmWHZVbU14emVZbGMvbnZ1d3Boamp1OTJaUHFpVWNFaDM1YzZ1?=
 =?utf-8?B?Nnp6QmZ1RjV3V3RDelFLdTN5QmRvU0Y2ZWtTL2toY1prUFNqSXFlMjVVbnFP?=
 =?utf-8?B?ZS9jeXE5Q3lKek55YXBBL1ROUzg3a2NyLzNRSTNJa3RpbmlsVFl4clFDZXVM?=
 =?utf-8?B?NDA4V2txRlBnR2FwQ2pxd2JkV29XbnNpeThJM2s2b2VHZDVXdUpwYXMwb2Za?=
 =?utf-8?B?R2orWW9OMExnR1BobjA1aXhvSkIzT3VHSXBHdnFtUDZhaTNjOWkwa1k2ZlFr?=
 =?utf-8?B?NElqb0lMaGNmZzIwTDljK1M2cHMzM1BlZll0ZkhzTmJmYVJyZDk2UmJHOEF6?=
 =?utf-8?B?bC9XKzdWdk9CL01aWEs1UTdrNGdnSk9kTGFlbXNGK3NuNkVhUWRSYlRORDho?=
 =?utf-8?B?eWhkcXZuZnF5K2tPY1FFeEZsMzZnM0dkQlFERlJmMFBiVm9STHRDb2hmVjl6?=
 =?utf-8?B?Y3ZOUElzQUxsSXZUVXAxWFBFNW9LK0pJRDd2UW0zNmtkQ25GVU1XMng1TFgv?=
 =?utf-8?B?UXRob0ZYYmlsald6WThMZkpaUnR2bXVwN3didUg2RDZCWXg2bm0xMWIxUmJi?=
 =?utf-8?B?QkVheTZBYzcxTUx4OENQdTBCU095SHhPa3ZUVmtTemR0UUp6NUF1K3RNK0tR?=
 =?utf-8?B?SG1UWm5teXFnNFB6TTB5eHZnWFZ6azM5Y21xUWw5blVGeTNnNjgwUUVsNmtk?=
 =?utf-8?B?YnRITmNtWVY5OXd1OC8weWVNQ0xiaGF2YUNCazZyNmxVWGkrSk9aSjV1VEkr?=
 =?utf-8?B?aW9vcDdTOUhKRmVsd3RIU1VtMkp3YjRmTW1SNHZZWlRlVDg3b2dlVG1QZmhy?=
 =?utf-8?B?SUhTVUNCVU1FV3FrNmRjU2QrN3lDb1M2MFNNVWU1Nk01QVhUWUJTZnBNVzRm?=
 =?utf-8?B?OXM2RUpqYmJZSCtPTk5SV0FPV2pIS2ZVYVAxMHN0NE1nNS96dkJja2ZRNjha?=
 =?utf-8?B?SHZ6YnlDYUZndXQ1bkJNZ0dDdjNNakl4WjdYUm94L0dlU0p4Y1F1RHNZbGFW?=
 =?utf-8?B?ZHNEcmJVWEVwTHcrSWdEL2FCTjlVcDd3eEZjZnE5dGJwWXJyMG40Q25va1pn?=
 =?utf-8?B?ZFRPNzdZWS8wSUhEYytXQXEzNWhkUWZ4bnQzeGR6SFFvbXZ6VFRwaFNpdDJO?=
 =?utf-8?B?REdxRUpYNjRncVhSUk5RNXQwdWJHWDJ6OW1TU2VGeDIzVkZtMklBNHRtQUdt?=
 =?utf-8?B?NStlZUdNYWFCVEpZdFhSbWZPMkNoMTlqRHRRQk14NmpMMHdrTU1vTUNSbmRx?=
 =?utf-8?B?amw1Nkl2NDY5bXdnN3hWbWVKNExNOFd0UXJTeTQ1Z0g4OFFQeUVEekhwanpK?=
 =?utf-8?B?Nm8raDhFbEZkS21sY1dzd0NxZWkrLzQrNGJpbDhLK3VOcTJaaDNmMldmQ3pL?=
 =?utf-8?B?R2FXNEdkcllFbUx2S05aZjR2djM2ZGRrQ3BEa3g1WS9UMTk4aG1XUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8c59cd-2d25-469f-6713-08de8a379768
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 06:27:30.4957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+ldYHbRbmrXdCN1crw+sm4rfwZJXhfTS1vDPX2bRIRWjKf/QaofuFru995eK9/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
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



On 25-Mar-26 11:52 AM, Xie, Patrick wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Thanks, that is missed, will add it
> 

Looks like VBIOS is providing values for single AID then. If you are 
adding it for 9.4/9.5.x, keep it like * hweight32(adev->aid_mask).

Thanks,
Lijo

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, March 25, 2026 2:17 PM
> To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: Re: [PATCH V3] drm/amdgpu: add support to query vram info from firmware
> 
> 
> 
> On 25-Mar-26 11:10 AM, Lazar, Lijo wrote:
>>
>>
>> On 25-Mar-26 9:37 AM, Gangliang Xie wrote:
>>> add support to query vram info from firmware
>>>
>>> v2: change APU vram type, add multi-aid check
>>> v3: seperate vram info query function into 3 parts and
>>>       call them in a helper func when requirements
>>>       are met.
>>>
>>> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 459
>>> ++++++++++--------
>>>    .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |   4 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  22 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  58 ++-
>>>    8 files changed, 308 insertions(+), 243 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> index 7f4751e5caaf..cd9aa5b45e94 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>>> @@ -373,249 +373,280 @@ int
>>> amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
>>>        return -ENODEV;
>>>    }
>>> -int
>>> -amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>>> +int amdgpu_atomfirmware_get_integrated_system_info(struct
>>> amdgpu_device *adev,
>>>                      int *vram_width, int *vram_type,
>>>                      int *vram_vendor)
>>>    {
>>>        struct amdgpu_mode_info *mode_info = &adev->mode_info;
>>> -    int index, i = 0;
>>> +    int index;
>>>        u16 data_offset, size;
>>>        union igp_info *igp_info;
>>> -    union vram_info *vram_info;
>>> -    union umc_info *umc_info;
>>> -    union vram_module *vram_module;
>>>        u8 frev, crev;
>>>        u8 mem_type;
>>> -    u8 mem_vendor;
>>>        u32 mem_channel_number;
>>>        u32 mem_channel_width;
>>> -    u32 module_id;
>>> -    if (adev->flags & AMD_IS_APU)
>>> -        index =
>>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>> +    index =
>>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>>                                integratedsysteminfo);
>>> -    else {
>>> -        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>>> -        case IP_VERSION(12, 0, 0):
>>> -        case IP_VERSION(12, 0, 1):
>>> -            index =
>>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>> umc_info);
>>> +    if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>>> +                      index, &size,
>>> +                      &frev, &crev, &data_offset)) {
>>> +        igp_info = (union igp_info *)
>>> +            (mode_info->atom_context->bios + data_offset);
>>> +        switch (frev) {
>>> +        case 1:
>>> +            switch (crev) {
>>> +            case 11:
>>> +            case 12:
>>> +                mem_channel_number = igp_info->v11.umachannelnumber;
>>> +                if (!mem_channel_number)
>>> +                    mem_channel_number = 1;
>>> +                mem_type = igp_info->v11.memorytype;
>>> +                if (mem_type == LpDdr5MemType)
>>> +                    mem_channel_width = 32;
>>> +                else
>>> +                    mem_channel_width = 64;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number *
>>> mem_channel_width;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                break;
>>> +            default:
>>> +                return -EINVAL;
>>> +            }
>>> +            break;
>>> +        case 2:
>>> +            switch (crev) {
>>> +            case 1:
>>> +            case 2:
>>> +                mem_channel_number = igp_info->v21.umachannelnumber;
>>> +                if (!mem_channel_number)
>>> +                    mem_channel_number = 1;
>>> +                mem_type = igp_info->v21.memorytype;
>>> +                if (mem_type == LpDdr5MemType)
>>> +                    mem_channel_width = 32;
>>> +                else
>>> +                    mem_channel_width = 64;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number *
>>> mem_channel_width;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                break;
>>> +            case 3:
>>> +                mem_channel_number = igp_info->v23.umachannelnumber;
>>> +                if (!mem_channel_number)
>>> +                    mem_channel_number = 1;
>>> +                mem_type = igp_info->v23.memorytype;
>>> +                if (mem_type == LpDdr5MemType)
>>> +                    mem_channel_width = 32;
>>> +                else
>>> +                    mem_channel_width = 64;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number *
>>> mem_channel_width;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                break;
>>> +            default:
>>> +                return -EINVAL;
>>> +            }
>>>                break;
>>>            default:
>>> -            index =
>>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>> vram_info);
>>> +            return -EINVAL;
>>>            }
>>> +    } else {
>>> +        return -EINVAL;
>>>        }
>>> +    return 0;
>>> +}
>>> +
>>> +int amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
>>> +                  int *vram_width, int *vram_type,
>>> +                  int *vram_vendor)
>>> +{
>>> +    struct amdgpu_mode_info *mode_info = &adev->mode_info;
>>> +    int index;
>>> +    u16 data_offset, size;
>>> +    union umc_info *umc_info;
>>> +    u8 frev, crev;
>>> +    u8 mem_type;
>>> +    u8 mem_vendor;
>>> +    u32 mem_channel_number;
>>> +    u32 mem_channel_width;
>>> +
>>> +    index =
>>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>> umc_info);
>>> +
>>>        if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>>>                          index, &size,
>>>                          &frev, &crev, &data_offset)) {
>>> -        if (adev->flags & AMD_IS_APU) {
>>> -            igp_info = (union igp_info *)
>>> -                (mode_info->atom_context->bios + data_offset);
>>> -            switch (frev) {
>>> -            case 1:
>>> -                switch (crev) {
>>> -                case 11:
>>> -                case 12:
>>> -                    mem_channel_number =
>>> igp_info->v11.umachannelnumber;
>>> -                    if (!mem_channel_number)
>>> -                        mem_channel_number = 1;
>>> -                    mem_type = igp_info->v11.memorytype;
>>> -                    if (mem_type == LpDdr5MemType)
>>> -                        mem_channel_width = 32;
>>> -                    else
>>> -                        mem_channel_width = 64;
>>> -                    if (vram_width)
>>> -                        *vram_width = mem_channel_number *
>>> mem_channel_width;
>>> -                    if (vram_type)
>>> -                        *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                    break;
>>> -                default:
>>> -                    return -EINVAL;
>>> -                }
>>> -                break;
>>> -            case 2:
>>> -                switch (crev) {
>>> -                case 1:
>>> -                case 2:
>>> -                    mem_channel_number =
>>> igp_info->v21.umachannelnumber;
>>> -                    if (!mem_channel_number)
>>> -                        mem_channel_number = 1;
>>> -                    mem_type = igp_info->v21.memorytype;
>>> -                    if (mem_type == LpDdr5MemType)
>>> -                        mem_channel_width = 32;
>>> -                    else
>>> -                        mem_channel_width = 64;
>>> -                    if (vram_width)
>>> -                        *vram_width = mem_channel_number *
>>> mem_channel_width;
>>> -                    if (vram_type)
>>> -                        *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                    break;
>>> -                case 3:
>>> -                    mem_channel_number =
>>> igp_info->v23.umachannelnumber;
>>> -                    if (!mem_channel_number)
>>> -                        mem_channel_number = 1;
>>> -                    mem_type = igp_info->v23.memorytype;
>>> -                    if (mem_type == LpDdr5MemType)
>>> -                        mem_channel_width = 32;
>>> -                    else
>>> -                        mem_channel_width = 64;
>>> -                    if (vram_width)
>>> -                        *vram_width = mem_channel_number *
>>> mem_channel_width;
>>> -                    if (vram_type)
>>> -                        *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                    break;
>>> -                default:
>>> -                    return -EINVAL;
>>> -                }
>>> +        umc_info = (union umc_info *)(mode_info->atom_context->bios
>>> ++
>>> data_offset);
>>> +
>>> +        if (frev == 4) {
>>> +            switch (crev) {
>>> +            case 0:
>>> +                mem_channel_number = le32_to_cpu(umc_info-
>>>> v40.channel_num);
>>> +                mem_type = le32_to_cpu(umc_info->v40.vram_type);
>>> +                mem_channel_width = le32_to_cpu(umc_info-
>>>> v40.channel_width);
>>> +                mem_vendor = RREG32(adev->bios_scratch_reg_offset +
>>> 4) & 0xF;
>>> +                if (vram_vendor)
>>> +                    *vram_vendor = mem_vendor;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>>                    break;
>>>                default:
>>>                    return -EINVAL;
>>>                }
>>>            } else {
>>> -            switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>>> -            case IP_VERSION(12, 0, 0):
>>> -            case IP_VERSION(12, 0, 1):
>>> -                umc_info = (union umc_info *)(mode_info-
>>>> atom_context->bios + data_offset);
>>> -
>>> -                if (frev == 4) {
>>> -                    switch (crev) {
>>> -                    case 0:
>>> -                        mem_channel_number = le32_to_cpu(umc_info-
>>>> v40.channel_num);
>>> -                        mem_type =
>>> le32_to_cpu(umc_info->v40.vram_type);
>>> -                        mem_channel_width = le32_to_cpu(umc_info-
>>>> v40.channel_width);
>>> -                        mem_vendor = RREG32(adev-
>>>> bios_scratch_reg_offset + 4) & 0xF;
>>> -                        if (vram_vendor)
>>> -                            *vram_vendor = mem_vendor;
>>> -                        if (vram_type)
>>> -                            *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                        if (vram_width)
>>> -                            *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> -                        break;
>>> -                    default:
>>> -                        return -EINVAL;
>>> -                    }
>>> -                } else
>>> -                    return -EINVAL;
>>> +            return -EINVAL;
>>> +        }
>>> +    } else {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>>> +                  int *vram_width, int *vram_type,
>>> +                  int *vram_vendor)
>>> +{
>>> +    struct amdgpu_mode_info *mode_info = &adev->mode_info;
>>> +    int index, i = 0;
>>> +    u16 data_offset, size;
>>> +    union vram_info *vram_info;
>>> +    union vram_module *vram_module;
>>> +    u8 frev, crev;
>>> +    u8 mem_type;
>>> +    u8 mem_vendor;
>>> +    u32 mem_channel_number;
>>> +    u32 mem_channel_width;
>>> +    u32 module_id;
>>> +
>>> +    index =
>>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>> vram_info);
>>> +
>>> +    if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>>> +                      index, &size,
>>> +                      &frev, &crev, &data_offset)) {
>>> +        vram_info = (union vram_info *)
>>> +            (mode_info->atom_context->bios + data_offset);
>>> +
>>> +        module_id = (RREG32(adev->bios_scratch_reg_offset + 4) &
>>> 0x00ff0000) >> 16;
>>> +        if (frev == 3) {
>>> +            switch (crev) {
>>> +            /* v30 */
>>> +            case 0:
>>> +                vram_module = (union vram_module *)vram_info-
>>>> v30.vram_module;
>>> +                mem_vendor = (vram_module->v30.dram_vendor_id) &
>>> +0xF;
>>> +                if (vram_vendor)
>>> +                    *vram_vendor = mem_vendor;
>>> +                mem_type = vram_info->v30.memory_type;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                mem_channel_number = vram_info->v30.channel_num;
>>> +                mem_channel_width = vram_info->v30.channel_width;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number * 16;
>>>                    break;
>>>                default:
>>> -                vram_info = (union vram_info *)
>>> -                    (mode_info->atom_context->bios + data_offset);
>>> -
>>> -                module_id = (RREG32(adev->bios_scratch_reg_offset +
>>> 4) & 0x00ff0000) >> 16;
>>> -                if (frev == 3) {
>>> -                    switch (crev) {
>>> -                    /* v30 */
>>> -                    case 0:
>>> -                        vram_module = (union vram_module
>>> *)vram_info-
>>>> v30.vram_module;
>>> -                        mem_vendor = (vram_module-
>>>> v30.dram_vendor_id) & 0xF;
>>> -                        if (vram_vendor)
>>> -                            *vram_vendor = mem_vendor;
>>> -                        mem_type = vram_info->v30.memory_type;
>>> -                        if (vram_type)
>>> -                            *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                        mem_channel_number =
>>> vram_info->v30.channel_num;
>>> -                        mem_channel_width = vram_info-
>>>> v30.channel_width;
>>> -                        if (vram_width)
>>> -                            *vram_width = mem_channel_number * 16;
>>> -                        break;
>>> -                    default:
>>> -                        return -EINVAL;
>>> -                    }
>>> -                } else if (frev == 2) {
>>> -                    switch (crev) {
>>> -                    /* v23 */
>>> -                    case 3:
>>> -                        if (module_id >
>>> vram_info->v23.vram_module_num)
>>> -                            module_id = 0;
>>> -                        vram_module = (union vram_module
>>> *)vram_info-
>>>> v23.vram_module;
>>> -                        while (i < module_id) {
>>> -                            vram_module = (union vram_module *)
>>> -                                ((u8 *)vram_module + vram_module-
>>>> v9.vram_module_size);
>>> -                            i++;
>>> -                        }
>>> -                        mem_type = vram_module->v9.memory_type;
>>> -                        if (vram_type)
>>> -                            *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                        mem_channel_number = vram_module-
>>>> v9.channel_num;
>>> -                        mem_channel_width = vram_module-
>>>> v9.channel_width;
>>> -                        if (vram_width)
>>> -                            *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> -                        mem_vendor = (vram_module->v9.vender_rev_id)
>>> & 0xF;
>>> -                        if (vram_vendor)
>>> -                            *vram_vendor = mem_vendor;
>>> -                        break;
>>> -                    /* v24 */
>>> -                    case 4:
>>> -                        if (module_id >
>>> vram_info->v24.vram_module_num)
>>> -                            module_id = 0;
>>> -                        vram_module = (union vram_module
>>> *)vram_info-
>>>> v24.vram_module;
>>> -                        while (i < module_id) {
>>> -                            vram_module = (union vram_module *)
>>> -                                ((u8 *)vram_module + vram_module-
>>>> v10.vram_module_size);
>>> -                            i++;
>>> -                        }
>>> -                        mem_type = vram_module->v10.memory_type;
>>> -                        if (vram_type)
>>> -                            *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                        mem_channel_number = vram_module-
>>>> v10.channel_num;
>>> -                        mem_channel_width = vram_module-
>>>> v10.channel_width;
>>> -                        if (vram_width)
>>> -                            *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> -                        mem_vendor =
>>> (vram_module->v10.vender_rev_id) & 0xF;
>>> -                        if (vram_vendor)
>>> -                            *vram_vendor = mem_vendor;
>>> -                        break;
>>> -                    /* v25 */
>>> -                    case 5:
>>> -                        if (module_id >
>>> vram_info->v25.vram_module_num)
>>> -                            module_id = 0;
>>> -                        vram_module = (union vram_module
>>> *)vram_info-
>>>> v25.vram_module;
>>> -                        while (i < module_id) {
>>> -                            vram_module = (union vram_module *)
>>> -                                ((u8 *)vram_module + vram_module-
>>>> v11.vram_module_size);
>>> -                            i++;
>>> -                        }
>>> -                        mem_type = vram_module->v11.memory_type;
>>> -                        if (vram_type)
>>> -                            *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                        mem_channel_number = vram_module-
>>>> v11.channel_num;
>>> -                        mem_channel_width = vram_module-
>>>> v11.channel_width;
>>> -                        if (vram_width)
>>> -                            *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> -                        mem_vendor =
>>> (vram_module->v11.vender_rev_id) & 0xF;
>>> -                        if (vram_vendor)
>>> -                            *vram_vendor = mem_vendor;
>>> -                        break;
>>> -                    /* v26 */
>>> -                    case 6:
>>> -                        if (module_id >
>>> vram_info->v26.vram_module_num)
>>> -                            module_id = 0;
>>> -                        vram_module = (union vram_module
>>> *)vram_info-
>>>> v26.vram_module;
>>> -                        while (i < module_id) {
>>> -                            vram_module = (union vram_module *)
>>> -                                ((u8 *)vram_module + vram_module-
>>>> v9.vram_module_size);
>>> -                            i++;
>>> -                        }
>>> -                        mem_type = vram_module->v9.memory_type;
>>> -                        if (vram_type)
>>> -                            *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> -                        mem_channel_number = vram_module-
>>>> v9.channel_num;
>>> -                        mem_channel_width = vram_module-
>>>> v9.channel_width;
>>> -                        if (vram_width)
>>> -                            *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> -                        mem_vendor = (vram_module->v9.vender_rev_id)
>>> & 0xF;
>>> -                        if (vram_vendor)
>>> -                            *vram_vendor = mem_vendor;
>>> -                        break;
>>> -                    default:
>>> -                        return -EINVAL;
>>> -                    }
>>> -                } else {
>>> -                    /* invalid frev */
>>> -                    return -EINVAL;
>>> +                return -EINVAL;
>>> +            }
>>> +        } else if (frev == 2) {
>>> +            switch (crev) {
>>> +            /* v23 */
>>> +            case 3:
>>> +                if (module_id > vram_info->v23.vram_module_num)
>>> +                    module_id = 0;
>>> +                vram_module = (union vram_module *)vram_info-
>>>> v23.vram_module;
>>> +                while (i < module_id) {
>>> +                    vram_module = (union vram_module *)
>>> +                        ((u8 *)vram_module + vram_module-
>>>> v9.vram_module_size);
>>> +                    i++;
>>>                    }
>>> +                mem_type = vram_module->v9.memory_type;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                mem_channel_number = vram_module->v9.channel_num;
>>> +                mem_channel_width = vram_module->v9.channel_width;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> +                mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
>>> +                if (vram_vendor)
>>> +                    *vram_vendor = mem_vendor;
>>> +                break;
>>> +            /* v24 */
>>> +            case 4:
>>> +                if (module_id > vram_info->v24.vram_module_num)
>>> +                    module_id = 0;
>>> +                vram_module = (union vram_module *)vram_info-
>>>> v24.vram_module;
>>> +                while (i < module_id) {
>>> +                    vram_module = (union vram_module *)
>>> +                        ((u8 *)vram_module + vram_module-
>>>> v10.vram_module_size);
>>> +                    i++;
>>> +                }
>>> +                mem_type = vram_module->v10.memory_type;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                mem_channel_number = vram_module->v10.channel_num;
>>> +                mem_channel_width = vram_module->v10.channel_width;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> +                mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
>>> +                if (vram_vendor)
>>> +                    *vram_vendor = mem_vendor;
>>> +                break;
>>> +            /* v25 */
>>> +            case 5:
>>> +                if (module_id > vram_info->v25.vram_module_num)
>>> +                    module_id = 0;
>>> +                vram_module = (union vram_module *)vram_info-
>>>> v25.vram_module;
>>> +                while (i < module_id) {
>>> +                    vram_module = (union vram_module *)
>>> +                        ((u8 *)vram_module + vram_module-
>>>> v11.vram_module_size);
>>> +                    i++;
>>> +                }
>>> +                mem_type = vram_module->v11.memory_type;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                mem_channel_number = vram_module->v11.channel_num;
>>> +                mem_channel_width = vram_module->v11.channel_width;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> +                mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
>>> +                if (vram_vendor)
>>> +                    *vram_vendor = mem_vendor;
>>> +                break;
>>> +            /* v26 */
>>> +            case 6:
>>> +                if (module_id > vram_info->v26.vram_module_num)
>>> +                    module_id = 0;
>>> +                vram_module = (union vram_module *)vram_info-
>>>> v26.vram_module;
>>> +                while (i < module_id) {
>>> +                    vram_module = (union vram_module *)
>>> +                        ((u8 *)vram_module + vram_module-
>>>> v9.vram_module_size);
>>> +                    i++;
>>> +                }
>>> +                mem_type = vram_module->v9.memory_type;
>>> +                if (vram_type)
>>> +                    *vram_type =
>>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>>> +                mem_channel_number = vram_module->v9.channel_num;
>>> +                mem_channel_width = vram_module->v9.channel_width;
>>> +                if (vram_width)
>>> +                    *vram_width = mem_channel_number * (1 <<
>>> mem_channel_width);
>>> +                mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
>>> +                if (vram_vendor)
>>> +                    *vram_vendor = mem_vendor;
>>> +                break;
>>> +            default:
>>> +                return -EINVAL;
>>>                }
>>> +        } else {
>>> +            /* invalid frev */
>>> +            return -EINVAL;
>>>            }
>>> +
>>> +    } else {
>>> +        return -EINVAL;
>>>        }
>>>        return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> index 67c8d105729b..0760e4510513 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>>> @@ -30,6 +30,10 @@ uint32_t
>>> amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device
>>> *ade
>>>    bool amdgpu_atomfirmware_gpu_virtualization_supported(struct
>>> amdgpu_device *adev);
>>>    void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device
>>> *adev);
>>>    int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device
>>> *adev);
>>> +int amdgpu_atomfirmware_get_integrated_system_info(struct
>>> amdgpu_device *adev,
>>> +    int *vram_width, int *vram_type, int *vram_vendor); int
>>> +amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
>>> +    int *vram_width, int *vram_type, int *vram_vendor);
>>>    int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>>>        int *vram_width, int *vram_type, int *vram_vendor);
>>>    int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device
>>> *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_gmc.c index
>>> f165d4e401e8..ecb42b304ccc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -34,6 +34,7 @@
>>>    #include "amdgpu_ras.h"
>>>    #include "amdgpu_reset.h"
>>>    #include "amdgpu_xgmi.h"
>>> +#include "amdgpu_atomfirmware.h"
>>>    #include <drm/drm_drv.h>
>>>    #include <drm/ttm/ttm_tt.h>
>>> @@ -1748,3 +1749,24 @@ int amdgpu_gmc_init_mem_ranges(struct
>>> amdgpu_device *adev)
>>>        return 0;
>>>    }
>>> +
>>> +int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
>>> +        int *vram_width, int *vram_type, int *vram_vendor) {
>>> +    if (adev->flags & AMD_IS_APU)
>>> +        return amdgpu_atomfirmware_get_integrated_system_info(adev,
>>> +                            vram_width, vram_type, vram_vendor);
>>> +    switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>>> +    case IP_VERSION(12, 0, 0):
>>> +    case IP_VERSION(12, 0, 1):
>>> +    case IP_VERSION(9, 5, 0):
>>> +    case IP_VERSION(9, 4, 4):
>>> +    case IP_VERSION(9, 4, 3):
> 
> Missed to ask - vram_width had a multiplication * 4 in v2. That is missing in this version. Was that a VBIOS issue?
> 
> Thanks,
> Lijo
> 
>>
>> These can be cleaned by up checking if umc_info >= 4 is available,
>> fetch info from there within atomfirmware logic. That may be done separately.
>>
>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>
>> Thanks,
>> Lijo
>>
>>
>>> +        return amdgpu_atomfirmware_get_umc_info(adev,
>>> +                                vram_width, vram_type, vram_vendor);
>>> +    default:
>>> +        return amdgpu_atomfirmware_get_vram_info(adev,
>>> +                                vram_width, vram_type, vram_vendor);
>>> +    }
>>> +    return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/
>>> drm/amd/amdgpu/amdgpu_gmc.h index b9fdc3276e81..32e73e8ba778 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -482,4 +482,6 @@ amdgpu_gmc_query_memory_partition(struct
>>> amdgpu_device *adev);
>>>    int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev);
>>>    void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
>>>                       struct amdgpu_mem_partition_info *mem_ranges);
>>> +int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
>>> +        int *vram_width, int *vram_type, int *vram_vendor);
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> b/drivers/gpu/drm/ amd/amdgpu/gmc_v10_0.c index
>>> 2568eeaae945..fd691b2a6e21 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -767,7 +767,7 @@ static int gmc_v10_0_sw_init(struct
>>> amdgpu_ip_block *ip_block)
>>>            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
>>>            adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
>>>        } else {
>>> -        r = amdgpu_atomfirmware_get_vram_info(adev,
>>> +        r = amdgpu_gmc_get_vram_info(adev,
>>>                    &vram_width, &vram_type, &vram_vendor);
>>>            adev->gmc.vram_width = vram_width; diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/
>>> amd/amdgpu/gmc_v11_0.c index 6349e239a367..e6db87b94eb1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -751,7 +751,7 @@ static int gmc_v11_0_sw_init(struct
>>> amdgpu_ip_block *ip_block)
>>>        spin_lock_init(&adev->gmc.invalidate_lock);
>>> -    r = amdgpu_atomfirmware_get_vram_info(adev,
>>> +    r = amdgpu_gmc_get_vram_info(adev,
>>>                              &vram_width, &vram_type, &vram_vendor);
>>>        adev->gmc.vram_width = vram_width; diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/
>>> amd/amdgpu/gmc_v12_0.c index f1079bd8cf00..6e184ea069ef 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -825,7 +825,7 @@ static int gmc_v12_0_sw_init(struct
>>> amdgpu_ip_block *ip_block)
>>>        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1,
>>> 0)) {
>>>            gmc_v12_1_init_vram_info(adev);
>>>        } else {
>>> -        r = amdgpu_atomfirmware_get_vram_info(adev,
>>> +        r = amdgpu_gmc_get_vram_info(adev,
>>>                      &vram_width, &vram_type, &vram_vendor);
>>>            adev->gmc.vram_width = vram_width;
>>>            adev->gmc.vram_type = vram_type; diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/
>>> amd/amdgpu/gmc_v9_0.c index 1ca0202cfdea..d865059e884a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct
>>> amdgpu_device *adev)
>>>            adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0,
>>> mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
>>>    }
>>> -static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
>>> +static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
>>>    {
>>>        static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
>>> +    int dev_var = adev->pdev->device & 0xF;
>>>        u32 vram_info;
>>> -    adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>>> -    adev->gmc.vram_width = 128 * 64;
>>> -
>>> -    if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
>>> -        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>>> -
>>> -    if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)
>>> &&
>>> -        adev->rev_id == 0x3)
>>> -        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>>> -
>>> -    if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
>>> -        vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
>>> -        adev->gmc.vram_vendor = vram_info & 0xF;
>>> +    if (adev->gmc.is_app_apu) {
>>> +        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>>> +        adev->gmc.vram_width = 128 * 64;
>>> +    } else if (adev->flags & AMD_IS_APU) {
>>> +        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
>>> +        adev->gmc.vram_width = 64 * 64;
>>> +    } else if (amdgpu_is_multi_aid(adev)) {
>>> +        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>>> +        adev->gmc.vram_width = 128 * 64;
>>> +
>>> +        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5,
>>> +0))
>>> +            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>>> +
>>> +        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4,
>>> 4) &&
>>> +            adev->rev_id == 0x3)
>>> +            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>>> +
>>> +        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4,
>>> 3) &&
>>> +            (dev_var == 0x5))
>>> +            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>>> +
>>> +        if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
>>> +            vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
>>> +            adev->gmc.vram_vendor = vram_info & 0xF;
>>> +        }
>>>        }
>>>    }
>>> @@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct
>>> amdgpu_ip_block *ip_block)
>>>        spin_lock_init(&adev->gmc.invalidate_lock);
>>> -    if (amdgpu_is_multi_aid(adev)) {
>>> -        gmc_v9_4_3_init_vram_info(adev);
>>> -    } else if (!adev->bios) {
>>> -        if (adev->flags & AMD_IS_APU) {
>>> -            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
>>> -            adev->gmc.vram_width = 64 * 64;
>>> -        } else {
>>> -            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>>> -            adev->gmc.vram_width = 128 * 64;
>>> -        }
>>> +    if (!adev->bios) {
>>> +        gmc_v9_0_init_vram_info(adev);
>>>        } else {
>>> -        r = amdgpu_atomfirmware_get_vram_info(adev,
>>> -            &vram_width, &vram_type, &vram_vendor);
>>> +        r = amdgpu_gmc_get_vram_info(adev,
>>> +                &vram_width, &vram_type, &vram_vendor);
>>>            if (amdgpu_sriov_vf(adev))
>>>                /* For Vega10 SR-IOV, vram_width can't be read from
>>> ATOM as RAVEN,
>>>                 * and DF related registers is not readable, seems
>>> hardcord is the @@ -1896,6 +1901,7 @@ static int
>>> gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>            adev->gmc.vram_type = vram_type;
>>>            adev->gmc.vram_vendor = vram_vendor;
>>>        }
>>> +
>>>        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>>>        case IP_VERSION(9, 1, 0):
>>>        case IP_VERSION(9, 2, 2):
>>
> 

