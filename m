Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF08CA5FAC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 17:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A730E10EFD2;
	Tue, 29 Sep 2026 17:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mi0s/0x+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E2D10EFC3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 17:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApdZVygWln17pRsSBirSOPWbeiPxwdv+6fwDMoCFtbjXjnONHSKYe4ofVTyQD0zlwU6WPtj+3VYZx9H/xJofKpDMEsMbq+felXCs9nTbo+RVjHEPylZppAkBl2eqQCmIms/D3iC+5poTuaJ1rRQD3AJ/X8jvdYKkCxX7wtKjdg/LJ6KrqJs4mI1vTG+LzhzJHsShr1QDU2+P+d5btP6Uv7nSeTpZ2BBJMZhDyQHRUHhuyV8t6Mp53kBXkQSgtkPgEURSLfFKQfBjLGz5ZZAO/eB59WyZ8sMRhmqaLBNzUdz58syzRjQ+GXXsXZyoxumcqEcJWh4OASa2sTZ9zS3SXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0S8KsC75xPhqts1jZk//08tDMF7Ltyrfl4xw/6YBQU=;
 b=QmqvoElVCyb4OZFEoWpii7zY2L6Z72KxdFj5uhP37k58ItvtyubqaKYGFYrt6QTz54BjyPPLGkzNC6iLZY3nv8ujoUFOFlUvdFdRvROXp9IbxKH4H5NJ3lGGhXXhMw+RwruCJ8DR2ibmiYd+fgAelrkLqg0cFEYsUabtzVU0Rhci/qFwAFCpQ7gLjJIfkXmuzgvseEq0nFZ4uYch2PNESdChcm5SPLMeHtV704XajsD1jxT/FT7hao25zEyAj6Lf/IIyQBJThfB+ER2PU/WkvTLO47dB4GVG6x6jEGEFC8oHCaGyxv1SKuJvDimGhjUL725PEf+lW+HqXTIp9DBThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0S8KsC75xPhqts1jZk//08tDMF7Ltyrfl4xw/6YBQU=;
 b=Mi0s/0x+EGHmxP3tg7O4BLNGFLmKNLYHO+A8J4dKSGhKcywaJV3La1T6hwch3e/l1AZvrwUWAw7mBlJvUZKEWm12zhC0Eo9LMMJOBg9UlfUwsb7NKaDkCedpF0J8UYuN0ip6F+hMdDoUu9Ek9DdeHF27VktoeZJ0bIYXgVhGjP0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:40:54 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 17:40:54 +0000
Message-ID: <bd17d876-3ee1-4aba-b86c-f40a9a6b7da5@amd.com>
Date: Tue, 29 Sep 2026 23:10:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] drm/amdgpu: use spm_vmid for the default RLC SPM
 VMID
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-9-sunil.khatri@amd.com>
 <fb63b082-0430-4711-b68e-d2eac63db26c@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <fb63b082-0430-4711-b68e-d2eac63db26c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::15) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 6107237b-4ff4-4a6f-02b2-08df1e50cf8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e68tmnGzVgBrJe1SvHubt6R6z2+BE21W2MWxBsnkYCKUipuJd9SIFoGznDNDFoWpD4dA2xTFFYhOK9o8T8culJ4spPkgtcnf/s82f3zCldW2ivjdM5xLUEVBKwi0+kuE7TQDFGgFpJ47+Iy8x1qMFA2W0nl5ldhILzpKfAaTitVSAKugwA+w0vBi9f7/Yk9AfpO6veROcoF7L/Dot4X7Rnj2XlLi33Tz6xlYT6g5R7X26wciBHhZVO8S5MUMPZ0rOHR6vU5W9crq5o6gbGgFCd5Rgy3MMQolSSRN2R7Gjc8/q3DML1VygjmQn0FNkdfrfABwLW6oYiFrPBYxj4diaJ5azYMyRzMkK5c/O7VOdt6r48sy3HGbD5Vyn9XDu14A3B/afcTte1aVvAvMZwvLtyfV4oISDL04AHrWGXsxQH10iDnznbN6aEYflGUzzhVBKx9ZmdKhzJG4tO06M+tDhzPfxOkvUPOWu5PXbJUgHspZwQ1gXRhXMDXaYdmwsviWBxqfzQKYKiQ71AcIqEwS+zK7cDVpS+btzHw9jv10r5YOrSV1JKjucRQnc1Lkzxjna0bitWBdeS5R6Tdv0h15UCtIOYSeWK6Cm+vRx9p3IMlVeF1dHI73FxoG3GhykgOhKFN33y8kA/runh7x2WjpSYKd9N8V08ITltdrHjyh1LU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFZdm54L2VlR0U0N29NeG1qRE1UYms4MmFyN3VRaWNuQWZEWHpPZE5Kcmpl?=
 =?utf-8?B?QjdGSmtKUkxpU3BTdUU2amVWbUo3cVJyczhYbzZxbnNMTC94OE5rQXU2QUk0?=
 =?utf-8?B?N3Iyb2lURTlXbTRmcjk2YXZPZ1AwR1QrakQ1L0N1RjJiMnpFVjJDVlFFK3F2?=
 =?utf-8?B?a2liM2NpVjlVcEorSEF0dnhCMFArb1J1czdlSkJVOFdaUjFyeWtMN0cwK1F1?=
 =?utf-8?B?S2l3elk3ZU1qVU9qVTNNNXZPNkZzdGpFUi9PLzUxWlI5MmlPb25NS2lCc2Fz?=
 =?utf-8?B?UXdnWVYwWlkvbTVRSDkvbFpsRWVaWEovSUQ0aEQwTEFMTmM5dFo4ZjFMb3E0?=
 =?utf-8?B?T0xiWTd4UUxYOTRWS1hWRDFDVmc2RjM5eUpYL01tYTNvRkJZUForSDk4NEpP?=
 =?utf-8?B?blpnVzdHd0ppZmd0Q2R1WW1iSzl5SlM2MkVZT21EbUxyNU9FVjlaa3AzVjNB?=
 =?utf-8?B?MTM0ZllJRWdkdWU3ZWJhMld6OUhZenZ3R2pDLzQzejl5cEtkSlBWeVd3Q004?=
 =?utf-8?B?TXlXK2k4YzI4cXU0cVNTNGRHaFQ1NjBzUEFwL3ppRWVmME45M3pTcUR2OVR0?=
 =?utf-8?B?VjhZdHN6K1FXZTV2b2hDazYwUGEza2pEbmVlRzM3OTNia2s2bzU0aHhSOWdL?=
 =?utf-8?B?ZFB1eWQwa1I2YTI2M1A2Z2o2dmw2d2I2Zk5PQmh4S0pRbTBRUUhwdVZjZ2R4?=
 =?utf-8?B?Z3NnK3lHTFd3VHJER1RXQTl3Zklmdy9tYkQvc0hxd1M4eDRENDYrRzhDL2JZ?=
 =?utf-8?B?V3YzUS9RdU5PN0wwQ1JndkdOTEFtdzEybVVxclJOY1hHMU1TWVlISlcybmZK?=
 =?utf-8?B?MURhRjRjUkFjNVFBaEVpZXZjVXNuTzVCVVJjL2h4WURzZVpBdjQ3UWFVRUM1?=
 =?utf-8?B?UGNSNmxFblVJYnU5R1BYR00rcnc5K0FQK2xkVGNGOCtKSDBId29kak1VZFVI?=
 =?utf-8?B?bTNKUkdhUWRIWHNSM05xc1RLNXZPUlJWRFo1enJ5ZUZjeFdHOTJmdXdjTThZ?=
 =?utf-8?B?V0tTRlo5aWxHWGFrM1F1c2VJQm10aEJ0dU8vT1VKUjJ1ODJoVjhrWStUQmpR?=
 =?utf-8?B?V3VJQ0ViSmhXU0ZGMUEzUDZ5R2k4QXJRQkVCOTlBbzVjUGZjaUEyR3VLRno0?=
 =?utf-8?B?QVpHSTZBN2EwaXRPVzJITGVaYXlyQVlnK041Y2JYbXJFUnRjRnZLczgrVUoy?=
 =?utf-8?B?c2d0NjFwNnFjbzJYZ2hFZXdVZnVqYzVOYzNCSitzNWMwM3ZZTGlVT0QwSnd1?=
 =?utf-8?B?cWcvdTUzSW5ncnUvL05XcDVqM0VFKzZZMUlNUkkzNnpSNk9LdTQ3bmxaSkIy?=
 =?utf-8?B?RjdldWV3SkJrWERxdk9aVDdKSHhmSW5QaFZJZFRVZllUbUEyTlpIK1hjSWVs?=
 =?utf-8?B?aks4ejJXSWtDVzFtZW5wcGlQNUN1YTJWa0RGL25kUnpRcWlMU1doTEl3bVUy?=
 =?utf-8?B?VDc2cVJaemtqRnNjaW96SFJiUXQ3V2Frb1dPSXpFL3dERmJ5T3RiNzQyL1U2?=
 =?utf-8?B?RldvTE93UFRJZm1DdnJ6TmU3WHhGS29nak4yTndOT3NNZnAwYzIxTGtxSk5O?=
 =?utf-8?B?ZHhUOVg4bWdkNU1wcVBGL0wxeWFzK2FqUGlRWE9pVjJlZ2lvQm5pN3NWdzNs?=
 =?utf-8?B?YlNuVWR2ZzdjNXdvRnZEanNndHRiaXRNLzVrTHFmZjltRUFKTGJSTStCY3ln?=
 =?utf-8?B?dncrMnVROFRZU1pYYVdvQllNKys3Q3Y4NitHaG5JRnpJdU56OGxrRlhDdnNM?=
 =?utf-8?B?RSthK1VoU2ZtWXcvdFVDR0tPSGE1UXN0cVIwQzkvaWlmdGxGYmtUZGdUcjVQ?=
 =?utf-8?B?Q21WamNmOWM4VDM5b1dpcE9iYzJGUmZrTWJIdHFHQWQzNjJLTCtESmRlSHRP?=
 =?utf-8?B?UlpuNDNHQWNhc0JJdmxmamY2L0pacTFraDNlazJpQmM2bE9MZDh3cHMvalJH?=
 =?utf-8?B?ckJhSUp3YS93Mkhod0JjZ21tRGFKb3dGSE5iTkpEVjJGUkVjdWVydEIyUFFJ?=
 =?utf-8?B?OVNUWCt5SVIvUllUU3NLYk1pVkVveVpJU2lCK09tTGJvRG1BWEwyUlFQUy9t?=
 =?utf-8?B?cU44UUM2NE1UUkRnQWhscTRwSndrTXhQR1NHanRwbC9uWUMzSGllNno4VVBK?=
 =?utf-8?B?Nm01TGtZbE56Ny9hdTV1K2JnbjhVRUxYc09yWU9VU3hDTGtld2pvWTBIUUVH?=
 =?utf-8?B?ajVpZVp5V0VPOWRaczluL2xzYzFKblEzV0prbjVNNDl2bW1CN3VjYWcvL2lo?=
 =?utf-8?B?YjJtTXNuRGVkYTFJWjZzc2FJT2hFZVZqTTJRNHRKcmhXd2wxWUtFUFVlenlq?=
 =?utf-8?B?ZWE1VXpzQWJmbE9MY0IxTWlhS0JDMXN4RFdlQVp3SEM3WkVQV2NzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6107237b-4ff4-4a6f-02b2-08df1e50cf8c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:40:53.9418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHtkzPDe7UXAVCVXcJ2r5UEBN79TUGveX77ATws8T8uG9ZfB0w0Gx81rvwxQFrHYYRpjYNm21YrQhfjhAclvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
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


On 29-09-2026 05:34 pm, Christian König wrote:
> On 9/28/26 20:57, Sunil Khatri wrote:
>> The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
>> 0xf as the idle default. Now that the dedicated SPM VMID is tracked in
>> vm_manager.spm_vmid, use it directly so the idle default matches the
>> VMID the reservation path hands out.
>>
>> No functional change: spm_vmid is the top VMID (0xf) on all affected
>> generations (gfx7 through gfx12).
> You also need to remove all the calls to adev->gfx.rlc.funcs->update_spm_vmid from amdgpu_vm_flush() and amdgpu_ib_schedule().

Sure in the next patch set will remove them...

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>>   8 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 33403e16df5ca..88f9f0b0bf524 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -5583,7 +5583,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>   
>>   		gfx_v10_0_init_csb(adev);
>>   
>> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>   
>>   		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>>   			gfx_v10_0_rlc_enable_srm(adev);
>> @@ -5615,7 +5615,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>   
>>   		gfx_v10_0_init_csb(adev);
>>   
>> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>   
>>   		adev->gfx.rlc.funcs->start(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7bfc8cbdcad85..036d1b7ade4e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index b75512e7b1db6..4caa43ff50a1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> index 91764f2e5ad01..a3d72cbaa6cf1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> @@ -1848,7 +1848,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>>   	int r;
>>   
>>   	/* init spm vmid with 0xf */
>> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
>> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>   		gfx_v12_1_xcc_init_csb(adev, xcc_id);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 549d1239e326b..04ee7e1725a94 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index ab4123ddbb942..61ba71b57b8e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>>   
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index 1678015ce5a97..4862d17a58237 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -3240,7 +3240,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>>   		break;
>>   	}
>>   
>> -	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
>> +	gfx_v9_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>   
>>   	adev->gfx.rlc.funcs->start(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 01ed1701c781a..add8099cf8e05 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>>   {
>>   	/* init spm vmid with 0xf */
>>   	if (adev->gfx.rlc.funcs->update_spm_vmid)
>> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>   
>>   	return 0;
>>   }
