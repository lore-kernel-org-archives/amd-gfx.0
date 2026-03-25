Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53E3FEA806
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 06:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB4410E77C;
	Wed, 25 Mar 2026 06:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nw+ll9Up";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B068610E77C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 06:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSotxzZVg0fcrPdBjlnzzEYg5mjyA8EXMXMBzpNNfLtkE62rqIvCoxVTI5Rrl+q7s+8+dKOMhIPHU7RRMRpKhVYj67umlWKdGgjfTT7MgWGMb4G60QU+p4j1KhqqFGiqlCpTyEhk5e3WHK6oyGomz3BFArA7Jjue9jOitj5NLif6ZoSX87iuo4r+P4DJ4HEMOKtN08KLmVGrMQr+kDRoN852g+bRiachZF7mK6po4lPTSfc+nVQGBYIy35jzB3+E79eWTygKmxei2Fc/qg70bQ2muqYwflv6w72oR1BPKbWGZQM8Xj79ywMCky7Qj5U5gF2eP1X5TfORaRE8+7Vqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh9xfNsvrYVj0t2LLFGWC+ftkKHy3SReC02j8nv/lWg=;
 b=Es/9/Eepj0iK3f3TdSA/u0KVWYfGkWoCXR0W7C4u8wB+hvEWiBMvlpDgwfM0VS5idsY/7HAhtNdzcKw2txW+6APIXy1D7i3WJ3P5CZnAsCkNHhw0ulrRbnxNHp6z4+WbaUa9xR+W9yCsHZpFobhocJrH/v8ZjjzxpW68qvbkZbcDRwpaVu6ctQvt+9PJ26owOjRu6IWBlll1fHoBiMFk3cvR5CoIpMR6/CsSlBudEk0S0jvxD1gERzaSN+93KX9prJibW5IPh1Y+dOF0tb8qbAwvGTv2LBsyay5Ic4KIt3uBQR/YqZt8fgrr/9almXEPKVipfGLJmOqBAJqLPqNsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh9xfNsvrYVj0t2LLFGWC+ftkKHy3SReC02j8nv/lWg=;
 b=nw+ll9UpMgqgnj/pHP+d2UkMZW9cVenSM/8cDY6rOLbfNC3LVXIRsBHI0bNRLiBHQN+7WfwZm5anNN5ZujQ+ApAziBfGTEjpMGL82XHXK/ol1y9RNB3kOGLhXrHENwvyXV78iG/CbMxJlaZA0M/n7UX1dLDzDJqywRecNch8JSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.21; Wed, 25 Mar
 2026 06:17:06 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 06:17:06 +0000
Message-ID: <0d8b475e-6858-4056-a0ce-b4010ed6aba8@amd.com>
Date: Wed, 25 Mar 2026 11:47:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] drm/amdgpu: add support to query vram info from
 firmware
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com
References: <20260325040727.2016678-1-ganglxie@amd.com>
 <48d5730b-384f-4b97-918b-ce9a63e5ad8e@amd.com>
Content-Language: en-US
In-Reply-To: <48d5730b-384f-4b97-918b-ce9a63e5ad8e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0095.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b8::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d232f8b-2f5d-4467-ee22-08de8a362390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: EjR4/YRB6Jcmbsz52PgbnkZQ+ATuUXLrmqnODpjzaW0NBJQvmTucAIO31HlQwzgV6lUF8RsK+MMFm0O9c6eU7SPGnlrC9uj3OZ5HgY5Uvd2vLamTClo9Lqyu1eFvetLbDNVhrL+SC6hSggOqAyX2q36KRziwXCOadyz3X4c9e+GFYkfvLZ7Vgr5YxE+rFUSlZzJOnDcfWloeHjI8+0AgFXATog6aTqTJCGLeeDo47YzE5ZcVPB7C7oKlJRM7f4+DYYza+w9aVatMZKp9a13s8Ur91kYVT6B5+d4Sj449hRYv/fo+cLxxPwyEhRDlJVasUBMoUk8vjCZnbI8yTpr3inXhrusUhY1Q7vVf8PEtXhPJKswcNblj87wRMckCKuxiNnWFLG4xVJF8gnyILh3QCv1Sws1Vlj4RtKotDclXxewsiCS/FBdxAw+R8rJFIKmLAsbZ4tFFzPAJ0/TeyYykuRDHvGyUX3LxrnKlbI3cnSCv/y1XZ0KsFDYDWvvSfj1NCv9xMfjj2Rqe6O4y/WQcx2SVifG8iP3AvXW4N4nyRPkZUNtIiocvlt+RHejQqE+3fkIF1yIY/qexkP+MJ6IOFNKothJcqQtf1dZuDz7R4weFLN0oKzjBAzlVR0wRg/LQ4kn+P52+wfw3+L+JzlYgszh6bwRc0w/SNjzgivyx2ZZI7ae4tKHC/BKWri0hO/vCppWafFr79t4BfjV0XaejLP75GMR6h412zyP2k8dzAzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck55aHhROFNrcTVVRW5leGxDZUZRM2FsdDVHZkZGNERmNXpBM0czSWdibFJI?=
 =?utf-8?B?U2M3ZmkrUXpmcVdPVXo3ME5vVkxxNUFTOEwvemF6d21WbUwrM3NBWkFCUHNi?=
 =?utf-8?B?SVExUjZ0dW1PckVxYUpzNFpKRWlpSzFtelEzSGZFaFZvbm1DcVhFcHJ2NVQz?=
 =?utf-8?B?SGNxSVZ3ZE1zR1RRYzExcHBRaGdnRTlOYjZJbkJNRjhMNmY2bGpMRERucmxI?=
 =?utf-8?B?cmo4cnN0MHlzWkhNSTFXRkZNTFVWMXBiUEswZUlnaHh4SmFhSUF2a2FPS0hz?=
 =?utf-8?B?aGlBMWl0eFNiQkQya1d3U042WG9MQ2lydHcrelptREI5eFJCK3FDOG54c3Js?=
 =?utf-8?B?RERpZzZ1L1l4VmdMS2hmZmEvcEV6QW9xdTB6a0FlUzFCTXNzOEFPNTgzczBY?=
 =?utf-8?B?Sk16ejJrOUVrL3Q5MHBRWTAwbTBYVGZ0VTdhVTJyQk1WNEhvM0ErcUN2bW1U?=
 =?utf-8?B?dm5lMFVuL3hBY2hoK09QVXJmalZnM3grbkN1RHVjNTVzM3hoY1YvWDBWMU92?=
 =?utf-8?B?WWh0akI5WjVXUWEza2h6OWh0TnFIbjlxbmlENU5jREJLUE9POU1xcDg3djd2?=
 =?utf-8?B?TDA1Rnpmb3lKQWoyNEFrMDFpV1R4cUJ1a3ErUmpUdVpkNEx0SGhmQWRMTXk1?=
 =?utf-8?B?cFQ5RUNxVGFSeitFOGp5VnVkV3JnaVh2ZlZWYThWMWpXeEdQVFQ0bDRhVkNp?=
 =?utf-8?B?elMvZUkvVTNhRG9SZ2RRdUY5cWREeW5aSmN1bnRLYmtoZ0NxM29VNHVnNTZ0?=
 =?utf-8?B?Snk0cUFrSkM4UmVSOEVFUWY3TDNMeE01TE52aUpnY1hESFRtejhXRTFXY0tT?=
 =?utf-8?B?ZzRaZTVoYzV6amk0YUdLYnZwaXNVNkoxbGh1NEhsMkVha2d1M3F3aWxmdDFt?=
 =?utf-8?B?REZwQzQ1OXBUMUEwT2J3UkkxL0F3RjZHSVJkSUMrdUtUYU9jWXExWm9tc3RI?=
 =?utf-8?B?dTJiSzNLbzBEL3J4M01NcmUrVmNpSEtsZStCNDFBYVNpNHc2UUhuMDdJTlcv?=
 =?utf-8?B?OUplSE5od2lVazN6WWlvS3FVaTJDQW5sb1hhZkw3ODhZZ2hNcndTL0d3TVdS?=
 =?utf-8?B?d0FSMExnakxVRWVQUHluQmFjR1BubTUyQ0ozVHNacmxWUHRXbWppQ2UvY0V0?=
 =?utf-8?B?d0pHT3JTTnF3N0lySEZ4eG12d1VnYnE1TWl4ODRhRzRzTnl5NnIzTU1iamxp?=
 =?utf-8?B?bHdEU1FzK3kyWTI4Rm92RmFBeGlhSURZWkVxaWRhaE5LcFFOakZReWhZWU5I?=
 =?utf-8?B?eHU5cnErUzkzMzZLMXFYbVljVkhxS08yN2FyZTU1eng4QVRnemFtOWJyZG8x?=
 =?utf-8?B?ZHR3bGtGYzh5T3ROVVBQQ0c5OEFoS04yeHVIQlVjblFmNm0rMXB2S2dmY2VF?=
 =?utf-8?B?VCsybHBmMVVjYlZFSWJUWjJpdjJPYjBORXpuYW1rSW5JRWFDamtqQWZKVEZ5?=
 =?utf-8?B?WkxLa1JDcmN0djJxRTUyMHNvWXBKQ003bUdTYzNGcW1pN1M5Y3VFOU15MGxa?=
 =?utf-8?B?NnFUZUlNOUNTY2xXMUVFVjZiWTg1ZTlkTXkxMUFQdWNNdlNwbUJsZFZIQlZL?=
 =?utf-8?B?dFNkSCtNRCswMnBUTFlmSUNvTi9tSzh0WkdwaDVhQVRvOFJOd3BQSFNRTjNw?=
 =?utf-8?B?OTB2RS9nR0Y4K21uejBzK3NCRlJVaHBIQ2VzalNqcG1QLy9adkZpblRsNFBq?=
 =?utf-8?B?WVVtL2ZwOFpZZ1BWVDFPaHVaVE45bFBVZ2lGa3QxUWxLc1dJYW10N09wOFVv?=
 =?utf-8?B?WElxd0lFS0lTVnZxV01DY3VtTlBPMEs3Zy91YmFHdGhJTjhZblpaY2t0aU1B?=
 =?utf-8?B?dWtQRW1vUEdvS3lqYWp3NE12R2E1UEQ1VEliMEt6TDM4THNXM2RUSWdhSVBV?=
 =?utf-8?B?MHVjK3NQVm15RnQ5RGplN21zdnNVanQ4ampGdlJwL3IxeVowSVZzakQ0VlRM?=
 =?utf-8?B?ZVFFNlpNZ3QzUXcyTFN5STZZU0NRUXRpaGltZGk5eUlpcnNnazg2UGphR0tt?=
 =?utf-8?B?Z3c0TW5iWm1GeUpqYkR4Qy9aQzZ6eEtXMXcwS24weW1vRFRwemNxcnd1VmQv?=
 =?utf-8?B?eUZ0UGFWLzFYTEdUcms3YzJnRG5BYVN1QVNXa1JnZVhDcklVN1k1bFlmYVJi?=
 =?utf-8?B?RzNHZVd0SERrS0VRUlVnTys2VytQWHUwa29DZDVJWlVBVzhweDhZQkx6NzF3?=
 =?utf-8?B?ZGYrQ0VWdVU4UzJUbnZOeGM2ZTdPS2Q2TWdrMFlGa2tHMjV0WklJaFBLa0Yr?=
 =?utf-8?B?NWx2akMyUGFHdUsyV3IwK2ZNQmFQUmg4b28ycDAzQlZoT2xsWHczSXYvN1Vx?=
 =?utf-8?B?WjFhbkh5NFp5VXUrektWNkdhWUtZaGl3SDBjaTVkKzhJNlV2cVZWUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d232f8b-2f5d-4467-ee22-08de8a362390
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 06:17:06.6763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKwmx9LhssTOkWCSCi+nK7PWD5xYb3uDWARhgjwzjr75JuBcD7tOnjT/nFBq8Kc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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



On 25-Mar-26 11:10 AM, Lazar, Lijo wrote:
> 
> 
> On 25-Mar-26 9:37 AM, Gangliang Xie wrote:
>> add support to query vram info from firmware
>>
>> v2: change APU vram type, add multi-aid check
>> v3: seperate vram info query function into 3 parts and
>>      call them in a helper func when requirements
>>      are met.
>>
>> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 459 ++++++++++--------
>>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |   4 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  22 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  58 ++-
>>   8 files changed, 308 insertions(+), 243 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/ 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> index 7f4751e5caaf..cd9aa5b45e94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> @@ -373,249 +373,280 @@ int 
>> amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
>>       return -ENODEV;
>>   }
>> -int
>> -amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>> +int amdgpu_atomfirmware_get_integrated_system_info(struct 
>> amdgpu_device *adev,
>>                     int *vram_width, int *vram_type,
>>                     int *vram_vendor)
>>   {
>>       struct amdgpu_mode_info *mode_info = &adev->mode_info;
>> -    int index, i = 0;
>> +    int index;
>>       u16 data_offset, size;
>>       union igp_info *igp_info;
>> -    union vram_info *vram_info;
>> -    union umc_info *umc_info;
>> -    union vram_module *vram_module;
>>       u8 frev, crev;
>>       u8 mem_type;
>> -    u8 mem_vendor;
>>       u32 mem_channel_number;
>>       u32 mem_channel_width;
>> -    u32 module_id;
>> -    if (adev->flags & AMD_IS_APU)
>> -        index = 
>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>> +    index = 
>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>                               integratedsysteminfo);
>> -    else {
>> -        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>> -        case IP_VERSION(12, 0, 0):
>> -        case IP_VERSION(12, 0, 1):
>> -            index = 
>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1, 
>> umc_info);
>> +    if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>> +                      index, &size,
>> +                      &frev, &crev, &data_offset)) {
>> +        igp_info = (union igp_info *)
>> +            (mode_info->atom_context->bios + data_offset);
>> +        switch (frev) {
>> +        case 1:
>> +            switch (crev) {
>> +            case 11:
>> +            case 12:
>> +                mem_channel_number = igp_info->v11.umachannelnumber;
>> +                if (!mem_channel_number)
>> +                    mem_channel_number = 1;
>> +                mem_type = igp_info->v11.memorytype;
>> +                if (mem_type == LpDdr5MemType)
>> +                    mem_channel_width = 32;
>> +                else
>> +                    mem_channel_width = 64;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * 
>> mem_channel_width;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                break;
>> +            default:
>> +                return -EINVAL;
>> +            }
>> +            break;
>> +        case 2:
>> +            switch (crev) {
>> +            case 1:
>> +            case 2:
>> +                mem_channel_number = igp_info->v21.umachannelnumber;
>> +                if (!mem_channel_number)
>> +                    mem_channel_number = 1;
>> +                mem_type = igp_info->v21.memorytype;
>> +                if (mem_type == LpDdr5MemType)
>> +                    mem_channel_width = 32;
>> +                else
>> +                    mem_channel_width = 64;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * 
>> mem_channel_width;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                break;
>> +            case 3:
>> +                mem_channel_number = igp_info->v23.umachannelnumber;
>> +                if (!mem_channel_number)
>> +                    mem_channel_number = 1;
>> +                mem_type = igp_info->v23.memorytype;
>> +                if (mem_type == LpDdr5MemType)
>> +                    mem_channel_width = 32;
>> +                else
>> +                    mem_channel_width = 64;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * 
>> mem_channel_width;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                break;
>> +            default:
>> +                return -EINVAL;
>> +            }
>>               break;
>>           default:
>> -            index = 
>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1, 
>> vram_info);
>> +            return -EINVAL;
>>           }
>> +    } else {
>> +        return -EINVAL;
>>       }
>> +    return 0;
>> +}
>> +
>> +int amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
>> +                  int *vram_width, int *vram_type,
>> +                  int *vram_vendor)
>> +{
>> +    struct amdgpu_mode_info *mode_info = &adev->mode_info;
>> +    int index;
>> +    u16 data_offset, size;
>> +    union umc_info *umc_info;
>> +    u8 frev, crev;
>> +    u8 mem_type;
>> +    u8 mem_vendor;
>> +    u32 mem_channel_number;
>> +    u32 mem_channel_width;
>> +
>> +    index = 
>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1, 
>> umc_info);
>> +
>>       if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>>                         index, &size,
>>                         &frev, &crev, &data_offset)) {
>> -        if (adev->flags & AMD_IS_APU) {
>> -            igp_info = (union igp_info *)
>> -                (mode_info->atom_context->bios + data_offset);
>> -            switch (frev) {
>> -            case 1:
>> -                switch (crev) {
>> -                case 11:
>> -                case 12:
>> -                    mem_channel_number = igp_info->v11.umachannelnumber;
>> -                    if (!mem_channel_number)
>> -                        mem_channel_number = 1;
>> -                    mem_type = igp_info->v11.memorytype;
>> -                    if (mem_type == LpDdr5MemType)
>> -                        mem_channel_width = 32;
>> -                    else
>> -                        mem_channel_width = 64;
>> -                    if (vram_width)
>> -                        *vram_width = mem_channel_number * 
>> mem_channel_width;
>> -                    if (vram_type)
>> -                        *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                    break;
>> -                default:
>> -                    return -EINVAL;
>> -                }
>> -                break;
>> -            case 2:
>> -                switch (crev) {
>> -                case 1:
>> -                case 2:
>> -                    mem_channel_number = igp_info->v21.umachannelnumber;
>> -                    if (!mem_channel_number)
>> -                        mem_channel_number = 1;
>> -                    mem_type = igp_info->v21.memorytype;
>> -                    if (mem_type == LpDdr5MemType)
>> -                        mem_channel_width = 32;
>> -                    else
>> -                        mem_channel_width = 64;
>> -                    if (vram_width)
>> -                        *vram_width = mem_channel_number * 
>> mem_channel_width;
>> -                    if (vram_type)
>> -                        *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                    break;
>> -                case 3:
>> -                    mem_channel_number = igp_info->v23.umachannelnumber;
>> -                    if (!mem_channel_number)
>> -                        mem_channel_number = 1;
>> -                    mem_type = igp_info->v23.memorytype;
>> -                    if (mem_type == LpDdr5MemType)
>> -                        mem_channel_width = 32;
>> -                    else
>> -                        mem_channel_width = 64;
>> -                    if (vram_width)
>> -                        *vram_width = mem_channel_number * 
>> mem_channel_width;
>> -                    if (vram_type)
>> -                        *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                    break;
>> -                default:
>> -                    return -EINVAL;
>> -                }
>> +        umc_info = (union umc_info *)(mode_info->atom_context->bios + 
>> data_offset);
>> +
>> +        if (frev == 4) {
>> +            switch (crev) {
>> +            case 0:
>> +                mem_channel_number = le32_to_cpu(umc_info- 
>> >v40.channel_num);
>> +                mem_type = le32_to_cpu(umc_info->v40.vram_type);
>> +                mem_channel_width = le32_to_cpu(umc_info- 
>> >v40.channel_width);
>> +                mem_vendor = RREG32(adev->bios_scratch_reg_offset + 
>> 4) & 0xF;
>> +                if (vram_vendor)
>> +                    *vram_vendor = mem_vendor;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>>                   break;
>>               default:
>>                   return -EINVAL;
>>               }
>>           } else {
>> -            switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>> -            case IP_VERSION(12, 0, 0):
>> -            case IP_VERSION(12, 0, 1):
>> -                umc_info = (union umc_info *)(mode_info- 
>> >atom_context->bios + data_offset);
>> -
>> -                if (frev == 4) {
>> -                    switch (crev) {
>> -                    case 0:
>> -                        mem_channel_number = le32_to_cpu(umc_info- 
>> >v40.channel_num);
>> -                        mem_type = le32_to_cpu(umc_info->v40.vram_type);
>> -                        mem_channel_width = le32_to_cpu(umc_info- 
>> >v40.channel_width);
>> -                        mem_vendor = RREG32(adev- 
>> >bios_scratch_reg_offset + 4) & 0xF;
>> -                        if (vram_vendor)
>> -                            *vram_vendor = mem_vendor;
>> -                        if (vram_type)
>> -                            *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                        if (vram_width)
>> -                            *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> -                        break;
>> -                    default:
>> -                        return -EINVAL;
>> -                    }
>> -                } else
>> -                    return -EINVAL;
>> +            return -EINVAL;
>> +        }
>> +    } else {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>> +                  int *vram_width, int *vram_type,
>> +                  int *vram_vendor)
>> +{
>> +    struct amdgpu_mode_info *mode_info = &adev->mode_info;
>> +    int index, i = 0;
>> +    u16 data_offset, size;
>> +    union vram_info *vram_info;
>> +    union vram_module *vram_module;
>> +    u8 frev, crev;
>> +    u8 mem_type;
>> +    u8 mem_vendor;
>> +    u32 mem_channel_number;
>> +    u32 mem_channel_width;
>> +    u32 module_id;
>> +
>> +    index = 
>> get_index_into_master_table(atom_master_list_of_data_tables_v2_1, 
>> vram_info);
>> +
>> +    if (amdgpu_atom_parse_data_header(mode_info->atom_context,
>> +                      index, &size,
>> +                      &frev, &crev, &data_offset)) {
>> +        vram_info = (union vram_info *)
>> +            (mode_info->atom_context->bios + data_offset);
>> +
>> +        module_id = (RREG32(adev->bios_scratch_reg_offset + 4) & 
>> 0x00ff0000) >> 16;
>> +        if (frev == 3) {
>> +            switch (crev) {
>> +            /* v30 */
>> +            case 0:
>> +                vram_module = (union vram_module *)vram_info- 
>> >v30.vram_module;
>> +                mem_vendor = (vram_module->v30.dram_vendor_id) & 0xF;
>> +                if (vram_vendor)
>> +                    *vram_vendor = mem_vendor;
>> +                mem_type = vram_info->v30.memory_type;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                mem_channel_number = vram_info->v30.channel_num;
>> +                mem_channel_width = vram_info->v30.channel_width;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * 16;
>>                   break;
>>               default:
>> -                vram_info = (union vram_info *)
>> -                    (mode_info->atom_context->bios + data_offset);
>> -
>> -                module_id = (RREG32(adev->bios_scratch_reg_offset + 
>> 4) & 0x00ff0000) >> 16;
>> -                if (frev == 3) {
>> -                    switch (crev) {
>> -                    /* v30 */
>> -                    case 0:
>> -                        vram_module = (union vram_module *)vram_info- 
>> >v30.vram_module;
>> -                        mem_vendor = (vram_module- 
>> >v30.dram_vendor_id) & 0xF;
>> -                        if (vram_vendor)
>> -                            *vram_vendor = mem_vendor;
>> -                        mem_type = vram_info->v30.memory_type;
>> -                        if (vram_type)
>> -                            *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                        mem_channel_number = vram_info->v30.channel_num;
>> -                        mem_channel_width = vram_info- 
>> >v30.channel_width;
>> -                        if (vram_width)
>> -                            *vram_width = mem_channel_number * 16;
>> -                        break;
>> -                    default:
>> -                        return -EINVAL;
>> -                    }
>> -                } else if (frev == 2) {
>> -                    switch (crev) {
>> -                    /* v23 */
>> -                    case 3:
>> -                        if (module_id > vram_info->v23.vram_module_num)
>> -                            module_id = 0;
>> -                        vram_module = (union vram_module *)vram_info- 
>> >v23.vram_module;
>> -                        while (i < module_id) {
>> -                            vram_module = (union vram_module *)
>> -                                ((u8 *)vram_module + vram_module- 
>> >v9.vram_module_size);
>> -                            i++;
>> -                        }
>> -                        mem_type = vram_module->v9.memory_type;
>> -                        if (vram_type)
>> -                            *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                        mem_channel_number = vram_module- 
>> >v9.channel_num;
>> -                        mem_channel_width = vram_module- 
>> >v9.channel_width;
>> -                        if (vram_width)
>> -                            *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> -                        mem_vendor = (vram_module->v9.vender_rev_id) 
>> & 0xF;
>> -                        if (vram_vendor)
>> -                            *vram_vendor = mem_vendor;
>> -                        break;
>> -                    /* v24 */
>> -                    case 4:
>> -                        if (module_id > vram_info->v24.vram_module_num)
>> -                            module_id = 0;
>> -                        vram_module = (union vram_module *)vram_info- 
>> >v24.vram_module;
>> -                        while (i < module_id) {
>> -                            vram_module = (union vram_module *)
>> -                                ((u8 *)vram_module + vram_module- 
>> >v10.vram_module_size);
>> -                            i++;
>> -                        }
>> -                        mem_type = vram_module->v10.memory_type;
>> -                        if (vram_type)
>> -                            *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                        mem_channel_number = vram_module- 
>> >v10.channel_num;
>> -                        mem_channel_width = vram_module- 
>> >v10.channel_width;
>> -                        if (vram_width)
>> -                            *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> -                        mem_vendor = (vram_module->v10.vender_rev_id) 
>> & 0xF;
>> -                        if (vram_vendor)
>> -                            *vram_vendor = mem_vendor;
>> -                        break;
>> -                    /* v25 */
>> -                    case 5:
>> -                        if (module_id > vram_info->v25.vram_module_num)
>> -                            module_id = 0;
>> -                        vram_module = (union vram_module *)vram_info- 
>> >v25.vram_module;
>> -                        while (i < module_id) {
>> -                            vram_module = (union vram_module *)
>> -                                ((u8 *)vram_module + vram_module- 
>> >v11.vram_module_size);
>> -                            i++;
>> -                        }
>> -                        mem_type = vram_module->v11.memory_type;
>> -                        if (vram_type)
>> -                            *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                        mem_channel_number = vram_module- 
>> >v11.channel_num;
>> -                        mem_channel_width = vram_module- 
>> >v11.channel_width;
>> -                        if (vram_width)
>> -                            *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> -                        mem_vendor = (vram_module->v11.vender_rev_id) 
>> & 0xF;
>> -                        if (vram_vendor)
>> -                            *vram_vendor = mem_vendor;
>> -                        break;
>> -                    /* v26 */
>> -                    case 6:
>> -                        if (module_id > vram_info->v26.vram_module_num)
>> -                            module_id = 0;
>> -                        vram_module = (union vram_module *)vram_info- 
>> >v26.vram_module;
>> -                        while (i < module_id) {
>> -                            vram_module = (union vram_module *)
>> -                                ((u8 *)vram_module + vram_module- 
>> >v9.vram_module_size);
>> -                            i++;
>> -                        }
>> -                        mem_type = vram_module->v9.memory_type;
>> -                        if (vram_type)
>> -                            *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> -                        mem_channel_number = vram_module- 
>> >v9.channel_num;
>> -                        mem_channel_width = vram_module- 
>> >v9.channel_width;
>> -                        if (vram_width)
>> -                            *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> -                        mem_vendor = (vram_module->v9.vender_rev_id) 
>> & 0xF;
>> -                        if (vram_vendor)
>> -                            *vram_vendor = mem_vendor;
>> -                        break;
>> -                    default:
>> -                        return -EINVAL;
>> -                    }
>> -                } else {
>> -                    /* invalid frev */
>> -                    return -EINVAL;
>> +                return -EINVAL;
>> +            }
>> +        } else if (frev == 2) {
>> +            switch (crev) {
>> +            /* v23 */
>> +            case 3:
>> +                if (module_id > vram_info->v23.vram_module_num)
>> +                    module_id = 0;
>> +                vram_module = (union vram_module *)vram_info- 
>> >v23.vram_module;
>> +                while (i < module_id) {
>> +                    vram_module = (union vram_module *)
>> +                        ((u8 *)vram_module + vram_module- 
>> >v9.vram_module_size);
>> +                    i++;
>>                   }
>> +                mem_type = vram_module->v9.memory_type;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                mem_channel_number = vram_module->v9.channel_num;
>> +                mem_channel_width = vram_module->v9.channel_width;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> +                mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
>> +                if (vram_vendor)
>> +                    *vram_vendor = mem_vendor;
>> +                break;
>> +            /* v24 */
>> +            case 4:
>> +                if (module_id > vram_info->v24.vram_module_num)
>> +                    module_id = 0;
>> +                vram_module = (union vram_module *)vram_info- 
>> >v24.vram_module;
>> +                while (i < module_id) {
>> +                    vram_module = (union vram_module *)
>> +                        ((u8 *)vram_module + vram_module- 
>> >v10.vram_module_size);
>> +                    i++;
>> +                }
>> +                mem_type = vram_module->v10.memory_type;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                mem_channel_number = vram_module->v10.channel_num;
>> +                mem_channel_width = vram_module->v10.channel_width;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> +                mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
>> +                if (vram_vendor)
>> +                    *vram_vendor = mem_vendor;
>> +                break;
>> +            /* v25 */
>> +            case 5:
>> +                if (module_id > vram_info->v25.vram_module_num)
>> +                    module_id = 0;
>> +                vram_module = (union vram_module *)vram_info- 
>> >v25.vram_module;
>> +                while (i < module_id) {
>> +                    vram_module = (union vram_module *)
>> +                        ((u8 *)vram_module + vram_module- 
>> >v11.vram_module_size);
>> +                    i++;
>> +                }
>> +                mem_type = vram_module->v11.memory_type;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                mem_channel_number = vram_module->v11.channel_num;
>> +                mem_channel_width = vram_module->v11.channel_width;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> +                mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
>> +                if (vram_vendor)
>> +                    *vram_vendor = mem_vendor;
>> +                break;
>> +            /* v26 */
>> +            case 6:
>> +                if (module_id > vram_info->v26.vram_module_num)
>> +                    module_id = 0;
>> +                vram_module = (union vram_module *)vram_info- 
>> >v26.vram_module;
>> +                while (i < module_id) {
>> +                    vram_module = (union vram_module *)
>> +                        ((u8 *)vram_module + vram_module- 
>> >v9.vram_module_size);
>> +                    i++;
>> +                }
>> +                mem_type = vram_module->v9.memory_type;
>> +                if (vram_type)
>> +                    *vram_type = 
>> convert_atom_mem_type_to_vram_type(adev, mem_type);
>> +                mem_channel_number = vram_module->v9.channel_num;
>> +                mem_channel_width = vram_module->v9.channel_width;
>> +                if (vram_width)
>> +                    *vram_width = mem_channel_number * (1 << 
>> mem_channel_width);
>> +                mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
>> +                if (vram_vendor)
>> +                    *vram_vendor = mem_vendor;
>> +                break;
>> +            default:
>> +                return -EINVAL;
>>               }
>> +        } else {
>> +            /* invalid frev */
>> +            return -EINVAL;
>>           }
>> +
>> +    } else {
>> +        return -EINVAL;
>>       }
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/ 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>> index 67c8d105729b..0760e4510513 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
>> @@ -30,6 +30,10 @@ uint32_t 
>> amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *ade
>>   bool amdgpu_atomfirmware_gpu_virtualization_supported(struct 
>> amdgpu_device *adev);
>>   void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
>>   int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device 
>> *adev);
>> +int amdgpu_atomfirmware_get_integrated_system_info(struct 
>> amdgpu_device *adev,
>> +    int *vram_width, int *vram_type, int *vram_vendor);
>> +int amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
>> +    int *vram_width, int *vram_type, int *vram_vendor);
>>   int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>>       int *vram_width, int *vram_type, int *vram_vendor);
>>   int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device 
>> *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_gmc.c
>> index f165d4e401e8..ecb42b304ccc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -34,6 +34,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_reset.h"
>>   #include "amdgpu_xgmi.h"
>> +#include "amdgpu_atomfirmware.h"
>>   #include <drm/drm_drv.h>
>>   #include <drm/ttm/ttm_tt.h>
>> @@ -1748,3 +1749,24 @@ int amdgpu_gmc_init_mem_ranges(struct 
>> amdgpu_device *adev)
>>       return 0;
>>   }
>> +
>> +int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
>> +        int *vram_width, int *vram_type, int *vram_vendor)
>> +{
>> +    if (adev->flags & AMD_IS_APU)
>> +        return amdgpu_atomfirmware_get_integrated_system_info(adev,
>> +                            vram_width, vram_type, vram_vendor);
>> +    switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>> +    case IP_VERSION(12, 0, 0):
>> +    case IP_VERSION(12, 0, 1):
>> +    case IP_VERSION(9, 5, 0):
>> +    case IP_VERSION(9, 4, 4):
>> +    case IP_VERSION(9, 4, 3):

Missed to ask - vram_width had a multiplication * 4 in v2. That is 
missing in this version. Was that a VBIOS issue?

Thanks,
Lijo

> 
> These can be cleaned by up checking if umc_info >= 4 is available, fetch 
> info from there within atomfirmware logic. That may be done separately.
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> Thanks,
> Lijo
> 
> 
>> +        return amdgpu_atomfirmware_get_umc_info(adev,
>> +                                vram_width, vram_type, vram_vendor);
>> +    default:
>> +        return amdgpu_atomfirmware_get_vram_info(adev,
>> +                                vram_width, vram_type, vram_vendor);
>> +    }
>> +    return 0;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_gmc.h
>> index b9fdc3276e81..32e73e8ba778 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -482,4 +482,6 @@ amdgpu_gmc_query_memory_partition(struct 
>> amdgpu_device *adev);
>>   int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev);
>>   void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
>>                      struct amdgpu_mem_partition_info *mem_ranges);
>> +int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
>> +        int *vram_width, int *vram_type, int *vram_vendor);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/gmc_v10_0.c
>> index 2568eeaae945..fd691b2a6e21 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -767,7 +767,7 @@ static int gmc_v10_0_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>           adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
>>           adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
>>       } else {
>> -        r = amdgpu_atomfirmware_get_vram_info(adev,
>> +        r = amdgpu_gmc_get_vram_info(adev,
>>                   &vram_width, &vram_type, &vram_vendor);
>>           adev->gmc.vram_width = vram_width;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/gmc_v11_0.c
>> index 6349e239a367..e6db87b94eb1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -751,7 +751,7 @@ static int gmc_v11_0_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       spin_lock_init(&adev->gmc.invalidate_lock);
>> -    r = amdgpu_atomfirmware_get_vram_info(adev,
>> +    r = amdgpu_gmc_get_vram_info(adev,
>>                             &vram_width, &vram_type, &vram_vendor);
>>       adev->gmc.vram_width = vram_width;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/gmc_v12_0.c
>> index f1079bd8cf00..6e184ea069ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> @@ -825,7 +825,7 @@ static int gmc_v12_0_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
>>           gmc_v12_1_init_vram_info(adev);
>>       } else {
>> -        r = amdgpu_atomfirmware_get_vram_info(adev,
>> +        r = amdgpu_gmc_get_vram_info(adev,
>>                     &vram_width, &vram_type, &vram_vendor);
>>           adev->gmc.vram_width = vram_width;
>>           adev->gmc.vram_type = vram_type;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/ 
>> amd/amdgpu/gmc_v9_0.c
>> index 1ca0202cfdea..d865059e884a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct 
>> amdgpu_device *adev)
>>           adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, 
>> mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
>>   }
>> -static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
>> +static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
>>   {
>>       static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
>> +    int dev_var = adev->pdev->device & 0xF;
>>       u32 vram_info;
>> -    adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>> -    adev->gmc.vram_width = 128 * 64;
>> -
>> -    if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
>> -        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>> -
>> -    if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
>> -        adev->rev_id == 0x3)
>> -        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>> -
>> -    if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
>> -        vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
>> -        adev->gmc.vram_vendor = vram_info & 0xF;
>> +    if (adev->gmc.is_app_apu) {
>> +        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>> +        adev->gmc.vram_width = 128 * 64;
>> +    } else if (adev->flags & AMD_IS_APU) {
>> +        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
>> +        adev->gmc.vram_width = 64 * 64;
>> +    } else if (amdgpu_is_multi_aid(adev)) {
>> +        adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>> +        adev->gmc.vram_width = 128 * 64;
>> +
>> +        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
>> +            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>> +
>> +        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 
>> 4) &&
>> +            adev->rev_id == 0x3)
>> +            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>> +
>> +        if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 
>> 3) &&
>> +            (dev_var == 0x5))
>> +            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
>> +
>> +        if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
>> +            vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
>> +            adev->gmc.vram_vendor = vram_info & 0xF;
>> +        }
>>       }
>>   }
>> @@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       spin_lock_init(&adev->gmc.invalidate_lock);
>> -    if (amdgpu_is_multi_aid(adev)) {
>> -        gmc_v9_4_3_init_vram_info(adev);
>> -    } else if (!adev->bios) {
>> -        if (adev->flags & AMD_IS_APU) {
>> -            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
>> -            adev->gmc.vram_width = 64 * 64;
>> -        } else {
>> -            adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
>> -            adev->gmc.vram_width = 128 * 64;
>> -        }
>> +    if (!adev->bios) {
>> +        gmc_v9_0_init_vram_info(adev);
>>       } else {
>> -        r = amdgpu_atomfirmware_get_vram_info(adev,
>> -            &vram_width, &vram_type, &vram_vendor);
>> +        r = amdgpu_gmc_get_vram_info(adev,
>> +                &vram_width, &vram_type, &vram_vendor);
>>           if (amdgpu_sriov_vf(adev))
>>               /* For Vega10 SR-IOV, vram_width can't be read from ATOM 
>> as RAVEN,
>>                * and DF related registers is not readable, seems 
>> hardcord is the
>> @@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>           adev->gmc.vram_type = vram_type;
>>           adev->gmc.vram_vendor = vram_vendor;
>>       }
>> +
>>       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>>       case IP_VERSION(9, 1, 0):
>>       case IP_VERSION(9, 2, 2):
> 

