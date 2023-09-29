Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ADDE80ABE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 10:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F9610E0FA;
	Fri, 29 Sep 2023 10:28:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551F010E0FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 10:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9TBhctd+7IZZeOwqjgasCJIrZbI6qcCNPDAjOFsk3Q3B1PzKtq7+6oYmrAoHRr0agFkeHfDf+YoIYaj3EPFtDS4wuHKU64vCTzSJ5SEeJKnpOPDcirXc9wWGzSeewc0LGFQCfrfN2QFt24eOOEpx71F7fFJ+lHebT9Yeezbzo2tdezKjtJQaiX8v/eQraPGj6Cqe5TLgJvVD5V/+P5qmkknwcMJfQ/kaBsB0+MdysIMCNa1X7bjt/iVk/w9jWSQ/ME/6a1qIwO98meqnAWXr5Lk/M7pK9Ohvn/kUsqLsF3cT4UaMNu8QfcNLyyV9ZsTSBQBtJF5YJcUpKts9GJ3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53fIb8+dvt/ioiC14b+iQWqk/66Auqaxui9YA+Ascuc=;
 b=XoY9Eq/J/4L5DxOMRCOmEMfhYknAGa3fqwLDfwIvBZCPsWKtExrvYgGbdjwZrUtBusRfi7QcO1+NppARfrSjSdo4PyFL3923BFZVFjGi5v8b526tqMDsF5TJn0eKy3FRriOagl1H1yvsFzW/+8Z8aobQKeTUwys1u3OLWV/rmCdV26TijW3f4jV0AEX5e1Q+2HhwzR30T3cIFcVh86N+NskHG+q6317zDCJhRSHKZ0pRSmP8RduF94oY27xb3AyUIdoPXjmbRNfhZSAyys8KZN5cN9pyYqFOchirKTPcH5YmQqA9cBuG3C7ohzpKIIA8eBNYVEoJKmwb6zzTGYkPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53fIb8+dvt/ioiC14b+iQWqk/66Auqaxui9YA+Ascuc=;
 b=1aYM9dLrfMPjUsulxfCzJ6IFlOXsrQ9Wjv/hicNy76920JNmv+sv8n9AgAhFAN29R1dzVFwIX4wM6q5uScStyHDrDj96oiBMdTSUzRLXrRslAkHHsgq6YxwV6WJz5wNCApZVqdd2OWIlTtl32qFrg+7RGGadw6NPYPo3np9QQ+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 10:28:30 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:28:30 +0000
Message-ID: <357177ac-49e0-3207-a072-7d7517830e52@amd.com>
Date: Fri, 29 Sep 2023 15:58:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
 <7b3ca5a4-2b48-24bc-10c2-3c373e7c1d85@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <7b3ca5a4-2b48-24bc-10c2-3c373e7c1d85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8fe25d-f5e8-47b4-73fa-08dbc0d6d2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjzCHeJrrkmjfGILeWGX7neDzGRprBxOPoidIXWxihy1jW7OQXXOBeqmsQxsExQiy/y0HH2pDFpab1tq4ZKT7D+9+GHDx81/eg9txZh7xHDfW7DFwDknzV/ISI3LH7vjzQPnKbbUQ/zH7TmGQkOPlJSv122MLSX9EnBDuocacPiIhS/j/mDQimN3ccL+bC+yZlR6iHYigdXutdvbspOWS37XtoD5M989iO7Tq9dxqLq2ytErn7pgI1zglcHQiDTDTXT9nfZcseLtxo+bc54GTfe5/d3NmQ3dZOgIeUSlI0mFWoNaI8kd77+juJwNNP2KFljt2KT7qDblHUjXOKDbgUHiWV9IEnGkfkxOipsC1KgwJeMDO3++1GX3a6JEMMUNrNMdIdPpVdl/Ha8YZxQLdOduYS/0TUQmTY317SHw9JDgIWmWEc7QQ/xwx4whbXJuFxZGQIH3u5ZU0WBMlh0FyVnYxPwghPmYvgZjlw1wZNG32hocvECM3tKme8FsTSIOnYiGmjnekjcQKi3qWmWJ5kCjvR6YkFafZ0smIfR6AazE0sUXKkfdmaP3YJtFmQUjumxiiev4k4KW1hZ1JVnUjRwDWQPxExklazLrFH8Sw1G837gaws6sLqvPZF8vVJIlvFNCldcDOkNBcv9lbilBEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(38100700002)(316002)(66556008)(66476007)(66946007)(31696002)(6666004)(6486002)(2616005)(83380400001)(36756003)(6512007)(6506007)(53546011)(26005)(478600001)(2906002)(86362001)(31686004)(4326008)(8676002)(8936002)(41300700001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3o1aXIwR0dCbDNPeUxuZnQ0WFBua2tTam9YaE8zVzZIeWdNbkQyajJ4SWE4?=
 =?utf-8?B?R2hzS1IwWkl5UEdFeGJkZHdncE5XK0M1OXAzMmhCcTRCaWFZVVphK1FCR1Jk?=
 =?utf-8?B?ZEJ2SE1jOGlIc3Y0a1A1T0dIay8yZERnTTQwbmRBNUthRjU2MW5RVjBWazFH?=
 =?utf-8?B?TEhqdEo3T1ZpQmRoVjdVRkdINzN5Um1ydzlRMC83emkvdWUxQzcxU0dCeWxo?=
 =?utf-8?B?b3p1dUNsclBCVG1uRmpWZDdRNmZkc0VxOEJvRGtnWkJWRjhnUmk1dDQvakgx?=
 =?utf-8?B?Ry94UzZuNUNkTHVlMFZZNXkycDM5a25tczZDVEh3RTRybmRsZWtBa3hNWXBj?=
 =?utf-8?B?Tnp4dlBwcEduSC9IYWZGU0dEYzlLUUlhckd1cS9naXRIZDdSNTJDVk9sWTVz?=
 =?utf-8?B?QTdYZ0JMVFlOYTYxa0xURjV0N1Y3NmZhOHJyQTRrVDZ1VkVXWjllVE05YUhw?=
 =?utf-8?B?ZHJ3bUJXSFhFREc5YVlLU0Q2WnViOFpzTXI5Z0RBb3dOK3V2WUxFQnM0VUJ3?=
 =?utf-8?B?UmNNS3lpeEY0a3lkakprZWt6WklFQWh2RVV0ZkRGK2ZDVm5UdFNVVVlBakV4?=
 =?utf-8?B?SFlZTkZ2ZzJwdEtUOFdMZm4ybkNTeG5paHFWVnpXUmtIbnhwdUszVGxuTHov?=
 =?utf-8?B?ckdxR3dDVXRaMXdSUk0zV1gwb2FObVllMVNPN1habTh1cnZTakUrSFVpSlp0?=
 =?utf-8?B?d0FMdFdTd1g4NXppNm9IWFdSUGVNVFhuc3l3cTIyYkprTDZPSU16ZDZ4UUwr?=
 =?utf-8?B?TTFIaExoU3hIQTFrcnZTMW9TQWFraHo4OEtmVFIyMHQ4bVIyK0NBSlpONytK?=
 =?utf-8?B?aXgvcEhMNnhHa2U1dE1VZTBpbFFFeXAyUTVDUkNoQ3ZXeWthYnJob1AvQlgy?=
 =?utf-8?B?NkxjekNEVmFSVlpHdmlIR1phRTllY2s1VGVLMytSc2wzNzI5dTBIbjdGNlJz?=
 =?utf-8?B?aU9WQTFuMWNWSmwvZlhXNWd3Q3BZMFlUejR0NExZSHZibjlmUUlKc1U3R3RH?=
 =?utf-8?B?cDhGQk9yNzBBYnliaVF1TE0ydHJWWVdWWjlCUEZkaEZuZlVSbTVQOEV0SmJj?=
 =?utf-8?B?U0VxYkRIbnBVVzRRUVBDTUY3S2NQVXRyUmc2cWZjQWdMV3pGNkphdmYyWExU?=
 =?utf-8?B?dGIxc1hwWUhBRExOQzk3d1FBOEdUS2pvVEdTZ0U2TmxPdllaa2dBNzdxWGdZ?=
 =?utf-8?B?QzNRb3A3dFdLaDNYTElob0pPWE82Z2NtRmFieVZ1VVg0SnVBK2xhazJ6ZXc1?=
 =?utf-8?B?Q050R1ZpcmVWd3ZROXFCQUJrRndCZmJocVdJZHdLOXBqOUwxVmx5ZjQ0SnUv?=
 =?utf-8?B?QUJDNjZUSkVTek85T2RvR1VMSjJSZU9zS1YzNmcwU212WUJFTnBmR1V1WmlG?=
 =?utf-8?B?R0UvcHJJK2MwSitKWVV2NkEyVnF2MFVXVjFhTG15YkFld3c4dU94UHdSTy90?=
 =?utf-8?B?djhVTkppeDVDVzJnR0ZqdXRXZGIrSm9XNCtPL0ptaThLdVVFcWxWOUc5OU5w?=
 =?utf-8?B?U2xvczVic29hUWcwS294N0h4K2JtemJaeUZaSlM2c1N5UXZ4N0FBSHNxSlJ2?=
 =?utf-8?B?UjJacHF2dHVCUkcyT2FzdSt6SHdyM3BoY2lzTWlWQ1hxbDlwakF5WFZwbDg1?=
 =?utf-8?B?K21DYmk1WEdPYUhlWkY4OW96eXRzSE56RmorU1k2eXJQRWVjNi9NMGxSN2tH?=
 =?utf-8?B?aGNZMmMvV20rUExKd0RnYTZ4b3llNTJUT0F3akJ6UmJKcXdpcUlCcVVCTzE3?=
 =?utf-8?B?UHlzMmI4RG8vckdPbFBmSkVxekFOYVZpMXVJRE54SGpWdUk4RklQRUw1Wi9t?=
 =?utf-8?B?cG96UEpDNkRLUjBSVTJ2eWllV2R0aWJSZ0dUVG82TjdleW9aaEovQVlGMjVz?=
 =?utf-8?B?aWp2c3orSE1LQ3FtcXZJSi9zeGxuT1lVU1dKLzFVc2FLUEpHaWxkcDVQQk5o?=
 =?utf-8?B?UlIyYTljMk1UNE1GWW91TDB3TjIwZDVURjNtcGxlQ2FrQy9xRGc1Nm5QT2lE?=
 =?utf-8?B?cmF2VlRrWmpnTE85cEhxNlB4SlZKc3JjYVJyVWVhT3VkbXgxVzF1R3lSYTJ1?=
 =?utf-8?B?cnJ3ZWdOY2RzY2JIUE1nNGhqMWR2T2h0TEI1anVybFdSZ0VkaFozYXp5RWhW?=
 =?utf-8?Q?o5QYSSYYSrpfQ+Bn4fUqxeDHm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8fe25d-f5e8-47b4-73fa-08dbc0d6d2cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 10:28:29.8978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk7goUX8Hk6ELcNCT54lq2J0P0enMfl+qD0Wt5ASRz8FFmFu5dVkvuIb2TNIJhyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/29/2023 3:56 PM, Christian König wrote:
> Am 29.09.23 um 11:37 schrieb Lijo Lazar:
>> Move definition of package type to amdgpu header and add new package
>> types for CEM and OAM.
> 
> Please don't move anything to amdgpu.h that header is in the process of 
> being deprecated.
> 
> What are CEM and OAM good for here?
> 

Is there a new header to keep device/SOC property enums?

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 7 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 5 -----
>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 73e825d20259..ac048a77e97c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -302,6 +302,13 @@ struct amdgpu_hive_info;
>>   struct amdgpu_reset_context;
>>   struct amdgpu_reset_control;
>> +enum amdgpu_pkg_type {
>> +    AMDGPU_PKG_TYPE_APU = 2,
>> +    AMDGPU_PKG_TYPE_CEM = 3,
>> +    AMDGPU_PKG_TYPE_OAM = 4,
>> +    AMDGPU_PKG_TYPE_UNKNOWN,
>> +};
>> +
>>   enum amdgpu_cp_irq {
>>       AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
>>       AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 42ac6d1bf9ca..7088c5015675 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {
>>   #define NUM_XCC(x) hweight16(x)
>> -enum amdgpu_pkg_type {
>> -    AMDGPU_PKG_TYPE_APU = 2,
>> -    AMDGPU_PKG_TYPE_UNKNOWN,
>> -};
>> -
>>   enum amdgpu_gfx_ras_mem_id_type {
>>       AMDGPU_GFX_CP_MEM = 0,
>>       AMDGPU_GFX_GCEA_MEM,
> 
