Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C32C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 06:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B5610E571;
	Wed,  8 Jul 2026 06:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="411MNmy0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2844B10E571
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 06:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiaDjzQXkKPaK292l3G+j1SEMifJ8hYzOoNeKQ4uIkMqXiLODM7NlgoeeeGNM2ODjJoK+ATVHIWb09BbsK6XkkSaYj2p3sw3qdP/aslyzazG9mhO7vwvR0NhUnvih2kn6tb/kHLGuhFql/pB/9h3QeU1idxWDTNPgkz3XWvrR2WUbObzbSpwWHikp22dLW+XQToy7bN+DBw2gUnYq/sEgjKaGpG92sXfsgUDArphScQoUdQ97ZwzcLzgHmk1s45vrBd3wPC4HEW1yH7JXlNeDD/0ZD7LL5Kn6J0FGXp7dP++gpjy1cayAkSimPWIOnHubkC9UsXKe5agRLh7JkwIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba8WtLVASzlxgaHVxfPY8VnsVXUBHQrp6fO6aXsQiyE=;
 b=HykfG1FNMk10B1t3XzdvmsPEGNjyXCvqgHFeKgiEFzG9Kk2+SDLQlO3t0ZqQ/pachsMnP++AnymH0qrHgCRtqtHyf5mB1vSFpnJYqwOORzLyLB973ppD2mT4HRZVOE1FrHyL1rtNmU/eu+UXG8DfQLhMCTZupyNoh5QVEDncT7lWZ0QtK1R9jdwTetGwAZ+1rpPALbtTEeNsFpFdVjSWTGwPpo+j0QSVneO6QPu3Ec+xl8PxDBAWobi/wGLDOA+Zq+HUIpSq2xRS9TpcUh6/1z14pWSD9ycf/VrYMvjhOIRNK4nF+YFTJh5W6AuPatY7MPa8j0R/t6pXxhMyG6PmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba8WtLVASzlxgaHVxfPY8VnsVXUBHQrp6fO6aXsQiyE=;
 b=411MNmy031oIa3VABytsmhu7LnVM85pAODXSDJ/2u40d8C5aIvkbIaYO9WdTiyiPIcYLb8e7oBx6zeurhsyeda5F2s7fN6QyEJVQ1zIAc0PPhcqLtS8muUkSwtVhF4P4YW4M2tFKyCSq6AMoeJD/cLmZd0zrcKV92XMhbomTrTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 06:54:40 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 06:54:39 +0000
Message-ID: <a2a283de-89d1-4876-8c9a-ff587f59837d@amd.com>
Date: Wed, 8 Jul 2026 12:24:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: improve the amdgpu device init
 progress in sriov mode
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Emily.Deng@amd.com, HaiJun.Chang@amd.com, Victor.Skvortsov@amd.com,
 Cursor <cursoragent@cursor.com>
References: <20260707113423.159063-1-chongli2@amd.com>
 <292b2854-8506-4186-acca-1f92bb34851d@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <292b2854-8506-4186-acca-1f92bb34851d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0354.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::8) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee9ece6-43f0-4d59-4a63-08dedcbdc79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NDp+eqNR5uNpfbL0fo4o/+3IwAh4sn/2IOK/aC6yiCwGSrSbSmoz8YD/gm/J+qySvJA3Sp3m+yFB1EGd0d9bmlSSg+bb5ft2XCjrUmpxN5g/eXsZ6ksYU81eRTIQVvWE7WcEhBCcwJT9Ic481tmym+T/sHPFlrM+agM9wa6mYGh3YcryJa3g/Lhz+9wT4pudvcJdoUm1vEmC/UBbB9W5LIt90RLO3r4PI1u5KKjlmVegJS1ZWzDJDJ5kI1qmYJYN3zI2FWADLMKMOR9lflfhqoN2nhbIJNZKYvypV5E7gRVzW8pgOIAGgS7KNBXAN6/r+Cb6sHveD1iD1Q0iTu3p1A7A78Dn/LWOMv/fV6njsKDkVuX3jacr7isyK8hwpHAMpM7afsnOsCqPAMKk2L5B6hMHR9sq4lv+112ZPUIIXZs3opsPiU2Izq+9BtSv16mZ0jIDxAGltjCF64Fli1nd07rMP2lKOE+SEIfzuFYRdCqTN2gmiDvtmOPbtWMAtHGhq9WULkfutvt7yMMWIl0ypMs1nsBq6VoAT/IvqhITweSGAObEme3k5aGZa3vykP/N1i2P6kK4AtHyoh8qMn2EY1JNlpRASY4UONaY/ow9PHTBohIigoUPhwLwqEOhp/DaBfPKzJMJJ0DoDPPchl/eTF6V7sIOkNbtIsBoOE0qFcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0RLdHV2UjA5RjVsdGt1RGxHOU92VXliVGdWMmlJYWs3dmNGNmZkVDQxbkMz?=
 =?utf-8?B?WEExVmFlbWNVcDNGN3B5YmhqV0RvaFVLYWZCbi9HVDh5bmp4aVJzVHM0Wmlz?=
 =?utf-8?B?NGZ5dGpaVDRQaE1STERqTktKd1hocDZNNVRlMURKVXQwKzNYaUNRMTdReUgr?=
 =?utf-8?B?dFVrSnU4SC9YYnBvYlp0dWNBa3k1Vmw3Zm52S2tsNFhWZ1Qvc01YaVZYa0NC?=
 =?utf-8?B?M1BHZFBIZTZXSDlVT0tYcCs5akIxUVJlVHJIUTJRRWVpZExzVnBpNlZYK3dH?=
 =?utf-8?B?UjFzSlFyTURyeDBnYTZ0L3NUazdDTVF1eDU5OFZmRTJkWi9HNEpYS1V0NGxj?=
 =?utf-8?B?Um1GeU5ReldPK0pEYTN6YlJvdjRXQ3A2VWVybjJMdlc5TkoyZVpBaWxWMEFT?=
 =?utf-8?B?a3oyU3laaitsRXlSbDZXZU1jbDN4SFJYdDl2MWk5T2EwVEc2MldBUTJiM09v?=
 =?utf-8?B?SlZDL0ZOVXRjVWh4V0pMQ2c0czJhODhva05wV2FvVWROeW1SKzRTM2xmMTI0?=
 =?utf-8?B?Smh1VzlKVktkeXdMUnZoYkZZTm9nZGhYZEU0NXJIblNtSGZua3VEc0h4Q1lh?=
 =?utf-8?B?bElVb1FiVSs2RFdrR0RMS0xGK0VEeXU2Zk93ckYwVzJ2T04vOUlBM0FlODBB?=
 =?utf-8?B?dENKdjkwUTAvbjVpdE1HS3plcjM2S1FxcHR0TnBoQWhkWUU3NVo0K2xEaGtL?=
 =?utf-8?B?YWdKTWxWOUVIeUNrUFdGR3dWWE9sU0V0YjRxTC8wVkpWNmdlcFV3dGVvc0pD?=
 =?utf-8?B?K2RRdWdUYjYvNXdUZFdzdFE4MG5lWGY4eE9wMmdQMThkS2E0Q080angxOS9y?=
 =?utf-8?B?L3dwajYwT0E0YmFEZHo5VVpzQ1ZnMDFvSWY5NFRwbDM0ZmZma2JPTHlvRk94?=
 =?utf-8?B?cUtHTlh3Z0ZjUlQyb2hBR0J3YUExSm1KZTB0RytlbDhURGZ0Rk95aFRZd3hH?=
 =?utf-8?B?VDRoU2FOa1h5WVFhR3VZNWJnV2kzOWJtUmVGdk9wcEhVODV1cEpwZmEwNThk?=
 =?utf-8?B?OFJycFFqMWZ0RkVscXR3ME5kZjlPOFIvRURwN2xnMi8vTUY5ZVp0azM1ajFS?=
 =?utf-8?B?TXVjWTlKeTlpYkpKZ0YwNCtIc3hnZEJXWFlaUHZJaGFtVnlDN01sUWlKZTM4?=
 =?utf-8?B?L0JzMDdNa2FJWHlIMFYzM2hzVUp6VjNOb3ZYNTJXc1dOZGk2dzRSYWNGZDdH?=
 =?utf-8?B?ZmxNbnBiOWFNTmFUSkNYb05qMW52SmpQV2xESmZhNXE3ZmtmR1FLaWZldTV1?=
 =?utf-8?B?L0lYekxlTy94RmNaSlIrR3RXNHNHODFlWEhHcmNzMFY4RExyMlAvSGNtZ2hu?=
 =?utf-8?B?SE5sdmlkZExzV3hZNmJxV2R5Ukl4a0x2Q1FzenltQkRFNUpxRHZYTjR2MDdR?=
 =?utf-8?B?UVcrNGM5MGJ4SEE4ME9OdU5CZUt5QjQyVVRuN21VMGhJZm1vQmFXdzFySHFT?=
 =?utf-8?B?MWVyTG9jUDNSb1N1L2cvVlhjZjg0QkRsY1BmSkIveldoa3JnMWVZc0NuQWk4?=
 =?utf-8?B?bjNJMVR1dVVRQkFPcEhkUzNTZWRTUHRiMWVYSEJiUmx4OWxXTzIxbDVrSW56?=
 =?utf-8?B?b3ZTc085Z0ZaclowbjFkSUJHS0U3VDBOcWxDRUdFczRDUjViTU9zS0VWR0pZ?=
 =?utf-8?B?YjlsSVlIbnpLS1JabXY5OE1iN0pFMHFENXVCcUZtRjRlR2IybE02ZTJpRElq?=
 =?utf-8?B?OWxKYlZKKytRQnhrUjVGVy9sT2ZLS3lYRDlmTDN6SUViTjBtYW1vSVQ4c1lG?=
 =?utf-8?B?b0N1UVNlY25HUW5XR2p6ckpHUE1jN2w0NFdNOFdlcXFnSDByYTE0bDlLUFdK?=
 =?utf-8?B?SGZ5bmU1TmJudFR5YVc1VUVvb1p3SmNrMmxIZjd5ZmMzOW5UVUNQZkZQZ1VZ?=
 =?utf-8?B?TWhsYUNFaDNzUjFhK0JpczhZVWtSMks2dlIrWGZTVVVmdHV0b011cFBOUmc3?=
 =?utf-8?B?djdMeTl3VHN5TFE0QXVianNNK1FOUlV5bUdmdEdUZE9RWGl4ZlhDOW1Benkz?=
 =?utf-8?B?a1NhSEZYY2p2MHNVeldFRjJyVWVoaTZtQ2JTS2p2M1I2NVl0ZnR0eVVYWGxa?=
 =?utf-8?B?UGtwYS9Db2xkWmNsK3dHZVhnd3NVbXYzcHJUUzhFUC84U1B6OUkvWk90YmRG?=
 =?utf-8?B?TExFN3crRkkxQ2NGVFJNMElqWjg1dERFdEF6VnRNWm91R2RvaXpuUDkwQ2lO?=
 =?utf-8?B?aG1GbmhJUjZ2TWdGRmZuQmZiaVdrdk5iMjlTTk8ybTRNUjdBU0ZkMU5jQ0RE?=
 =?utf-8?B?RjFaQUtyNWpTTnVTSlZacnJLSUlzbG1pSHQ5ZWYwZjlLQkp4K2JqaVpTQWM4?=
 =?utf-8?B?ejRFdEs3NWMyMncwMUQ3TzVVa0dMbjBOVUNQTDJvSDZjOGN5bStGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee9ece6-43f0-4d59-4a63-08dedcbdc79c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:54:39.2231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1XdpHLHw2TeQWdN3+aNlgr2+EqsH2asCBzgtgzM53q5mwIsWEghJ07OG6rEzv4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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



On 07-Jul-26 5:25 PM, Christian König wrote:
> On 7/7/26 13:30, chong li wrote:
>> v2:
>> Some legacy ASICs do not support amdgpu_virt_request_init_data().
>> On platform ESXi, the PF can access VF VRAM only after the VF
>> enters full gpu access mode.
>> Only move the full access request later when the required conditions are met
> 
> This is adjusting the driver to the hypervisor and not the hypervisor to the driver.
> 
> If the existing init order doesn't work on ESXi then that is an ESXi problem and needs to be fixed there.
> 
> So still absolutely clear NAK.
> 
>>
>> v1:
>> Move the initialization of non-GPU resources
>> out of the full GPU access region during AMDGPU device initialization
>>
>> background:
>>
>> After the amdgpu driver sends GPU_INIT_DATA to the host SR-IOV driver,
>> the host dumps the IP discovery/VBIOS/PF-VF exchange data into the VF FB.
>> The VF can then read these data blocks without requesting full GPU access.
>> This is the purpose of the GPU_INIT_DATA event in the SR-IOV init flow.
>>
>> However, during ip_early_init, TTM is not initialized yet.
>> The current amdgpu driver therefore falls back to reading these data
>> through MM_INDEX/MM_DATA. That path requires register access,
>> which still needs full GPU access.
>>
>> As a result, even though amdgpu sends GPU_INIT_DATA and
>> the host prepares the init data early,
>> the full GPU access window is not reduced because
>> the guest still needs full GPU access to copy the data.
>>
>> To fix this, use amdgpu_device_read_fb_via_bar0() to copy
>> the init data from VF FB before TTM is ready.
>> For this early copy, the guest no longer needs full GPU access
>> so the full GPU access request can be moved later.
> 
> You are just explaining the chicken and egg problem here instead of giving an actual justification.
> 

I guess there is no other technical reason to disallow accessing FB 
using visible BAR range. The only reason of going through HDP indirect 
path could be because the offsets could be outside of visible range. In 
SRIOV case, if host driver guarantees discovery offsets in visible FB 
range, there is no reason to disallow that.

Thanks,
Lijo


> Regards,
> Christian.
> 
>>
>> Signed-off-by: chong li <chongli2@amd.com>
>> Co-authored-by: Cursor <cursoragent@cursor.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +++++++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 +--
>>   2 files changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 610d82b79de3..ec353f4dd0d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -38,6 +38,10 @@
>>   #include <linux/apple-gmux.h>
>>   #include <linux/nospec.h>
>>   
>> +#ifdef CONFIG_X86
>> +#include <asm/hypervisor.h>
>> +#endif
>> +
>>   #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_client_event.h>
>>   #include <drm/drm_crtc_helper.h>
>> @@ -1973,6 +1977,17 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
>>   	return parent;
>>   }
>>   
>> +static bool amdgpu_device_delay_full_gpu_access(struct amdgpu_device *adev)
>> +{
>> +#ifdef CONFIG_X86
>> +	return adev->virt.req_init_data_ver > 0 &&
>> +		(hypervisor_is_type(X86_HYPER_VMWARE) ||
>> +		hypervisor_is_type(X86_HYPER_MS_HYPERV));
>> +#else
>> +	return false;
>> +#endif
>> +}
>> +
>>   /**
>>    * amdgpu_device_ip_early_init - run early init for hardware IPs
>>    *
>> @@ -1987,16 +2002,19 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   {
>>   	struct amdgpu_ip_block *ip_block;
>>   	struct pci_dev *parent;
>> -	bool total, skip_bios;
>> +	bool total, skip_bios, delay_full_gpu_access = false;
>>   	uint32_t bios_flags;
>>   	int i, r;
>>   
>>   	amdgpu_device_enable_virtual_display(adev);
>>   
>>   	if (amdgpu_sriov_vf(adev)) {
>> -		r = amdgpu_virt_request_full_gpu(adev, true);
>> -		if (r)
>> -			return r;
>> +		delay_full_gpu_access = amdgpu_device_delay_full_gpu_access(adev);
>> +		if (!delay_full_gpu_access) {
>> +			r = amdgpu_virt_request_full_gpu(adev, true);
>> +			if (r)
>> +				return r;
>> +		}
>>   
>>   		r = amdgpu_virt_init_critical_region(adev);
>>   		if (r)
>> @@ -2159,6 +2177,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>   	if (!total)
>>   		return -ENODEV;
>>   
>> +	if (amdgpu_sriov_vf(adev) && delay_full_gpu_access) {
>> +		r = amdgpu_virt_request_full_gpu(adev, true);
>> +		if (r)
>> +			return r;
>> +	}
>> +
>>   	if (adev->gmc.xgmi.supported)
>>   		amdgpu_xgmi_early_init(adev);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> index 9a40107a0869..340703d89d6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>>   	} else if (req == IDH_REQ_GPU_INIT_DATA){
>>   		/* Dummy REQ_GPU_INIT_DATA handling */
>>   		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
>> -		/* version set to 0 since dummy */
>> -		adev->virt.req_init_data_ver = 0;	
>> +		/* Version is set to 1 since GPU_CRIT_REGION_V1 */
>> +		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>   	}
>>   
>>   	return 0;
> 

