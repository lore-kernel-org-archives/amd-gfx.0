Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCA7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459CC10E653;
	Thu,  9 Dec 2021 16:54:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A92B89E59
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN4UVIKNYE9e7mwyV9qW2ZdFv5+BXnc1kRWE7oMb31nN7WjY1ln/Cm8KwReXsjWM8GhZcMPOlWfQTVmEVkiJ+GxseTuvYBfC5Ac9eBlE5dejj6q7X+LUJHCwpnpW6L+QDOPzNNATQc6Csmxx7xxJIyGYQdiZfSw45uPVPwMaD04504cmboT56QUnp+q0dPgr2FKNMzEOXgG8SzJA6FPcaeIYkCMV9X1nQkfqKM0+OGbcE0MuJwABSvPw/JcVVijMSqNWmVRmwGjCk+89COUWnJ/KR3kvcgPe+NNiw8zK5xzBE38rgc6OT/tCK6m1DLRt6PCWVgJ9bwCsqt7lVA2Ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwcRdZxKE8edx0dmdqmz6AwPEpJO4oEkIRn7Ocjc7dQ=;
 b=OYtpYbf2GOE/GRCS60NLkmeri3v5JXhcGzyDQFWh/meQgSZ8ew3XLAmL8qw9UwN2jpMwXMcHFmgHbhfQEzYR2IOthohK3ffvZxgzGml1uHHNeYQX6NRIWRlzt0dHE1pWCO4G4ecQhkUDN9M/aURwtk3O1ojrPtV0xRH7Xd+jyM/CpobmAV00tatkNZNn1p+5KdvaBxIa6AzNgsiRHDkWQqeEjJO6DY/5FmC55nzau4ESf9KcBcX+xLxbfA64yPuc1K0Ba8iJVsyic23iTyUgnwcFMK+azQ/eNSXE9N4qtfY0kRRlCuatbgifvU3WFMVROZ35s26w8tQG081vHniBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwcRdZxKE8edx0dmdqmz6AwPEpJO4oEkIRn7Ocjc7dQ=;
 b=l9YBrLMLuxnkug4VoYVBB2hjzqhlHaeqnW6ZRzi+mtkLyO2dUfPsCRBRRMnvK8Tdsl2PkYvqgQP7abyWOKUZ3u5HkO7G5luwElKjWZDdEIXx34smCrdt07PwzBtGcVZ4uHauTnhWqf51Jn1xb4AB6zhft0Hg/b3HSOgCXuLdx1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1500.namprd12.prod.outlook.com (2603:10b6:4:11::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Thu, 9 Dec 2021 15:38:06 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b%7]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 15:38:06 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: introduce a kind of halt state for amdgpu
 device
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211209084914.261889-1-lang.yu@amd.com>
 <af6c19e6-fcf4-ac19-637e-1fb47f15f9e6@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <432a38b5-2c56-2b54-4e05-b0a3862ddb2f@amd.com>
Date: Thu, 9 Dec 2021 10:38:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <af6c19e6-fcf4-ac19-637e-1fb47f15f9e6@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::28) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:5877:f59b:f2f9:1520]
 (2607:fea8:3edf:49b0:5877:f59b:f2f9:1520) by
 YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Thu, 9 Dec 2021 15:38:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77c7c65-49e1-4bc7-b423-08d9bb29e4d8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1500:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB150099F904AA2B794A20AA2DEA709@DM5PR12MB1500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loAXiCI+iaAs5nWfLtohXMCp/9ozicqrffngJyzUVqSCQYgIAAEUysWB9TO2AOWpsnW3QLlzGP52wrJiE7bMpIFUXPHp2NQ6bxEg04ZQ0UxAILK9A47B4mFrlIp1YGIfJA9/kF652ULq16WPW6XL1mHruIfn9cAReV1uIlHL5af38nG93IEYw3rAIINFbNuRv/q3R/u3g5c0h5lUjIeFnv1eKqP7MR27TLuS8c10D87gTlbRMsBxYS8YfEKW80PuTBZMtU2SX05tc0jdK2gM5u3lS5ySu6trWtHmr/AT7PwCgglvx67H6zgSzAsLoe0JVFI4EN1KGVfjxPEgxgW3w5ECAn2ydVXMuoKEk+BvQkfE0W3LV02RbKBE4gDUqJMiWueRpUu5dSAms5ROtuMNQcRqY5sh5RrKHqThpOqiPmd8/Q84TLnYesGW05XGs8yLCfh47zPm6KSQjy9etqRczrhNmOgq2fuRVGvq/tkGXQyC/XsWJkhzQolAMgECtjpCKM5KdxDZO2SeAuYu6dMmb6KNiNAsgvpw6upIt+3oiiTh5vTegf96UsIpLhyIuZgfczzTGD+IydI9T3t5FjgZByqTT3a5X+qwm5EMc+KV8C5/8xJqtGgxivss2l8/cKpT4bD0Sjv48izRVT7q1V2fUK8ZeEmk5E+t1rD0lWJGp3p2Bh6WZ+pw9pFG218J59pPA6mLCeYt/09mLTsJgp/z29kmQr+JLd23m624yUPgmw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(6486002)(508600001)(53546011)(186003)(54906003)(8936002)(31686004)(83380400001)(2906002)(66574015)(86362001)(66556008)(66946007)(66476007)(36756003)(8676002)(316002)(5660300002)(44832011)(2616005)(31696002)(38100700002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2U4NWxUY3ljQUM4SmtqNVNZQUxiZVNMRmp3RkgxcmZoQXY3QkFMYk5sc3E5?=
 =?utf-8?B?N2YxRGlIOXkycWx3bWdEcEt3U3R4bDd4YUZsMForT3U0WmhBQUEvS1hFU3VJ?=
 =?utf-8?B?akMrWUNWcjdSUUJYRzR4L25nTGY0RGJiY2c3UVZRMmxRNmZiNzdIVWdlaW02?=
 =?utf-8?B?UG03bTdHZ2hWNWgrSHlYWGZoY0V6YWJ6ZnErTjBPdURJZUZVclNEbytZSVoy?=
 =?utf-8?B?akNPYXRLOHpsMFZoTmxIUjN4cjJWZUVqZjI1d0toTG5qNDM3QVdyUERyR0c4?=
 =?utf-8?B?V2MxMDlwSFMwcytGUGszZGoxNjVVUHdCZVFIUnRuQm9paFNnU2F2dG5JQkll?=
 =?utf-8?B?L21qK3pRRzdSN3ZhQXVOU0NsZXRHT3lEeGZiTjVxZVpxWWxGZzFyWm9GYitl?=
 =?utf-8?B?WVZjRU5vaWZ5YUxIa0VyR2grVnd4ZHJlNUF2anVTckVCZUNuQmVFVEtma3Zn?=
 =?utf-8?B?cUtuMXNFUWsyaVNDMmsrVG5xUTVRS3BBUHo0elBmZHhNVVJCOWUvQ21zYmVG?=
 =?utf-8?B?MU9LMzNkd0VuUGtaYmVzQVRXMkRCNURLRVRyV1EzbHBRVGRMRlIwSkJZeUoy?=
 =?utf-8?B?dEljbW9NdTBYSGVKT3VyUnpZMDE1ZGNaQnlKd2RROHU2ZXJyNCtTY1UvREpT?=
 =?utf-8?B?RzlzKzgxRjZYRm1EWFFKNXNhb3hJMWhxRXVtdVJEeHZSaU5YaGdUTzlVMm5t?=
 =?utf-8?B?NmRvVGp0K0IzbE1rOGc2bGJXMHJKSVJBbzdrZ0g2QUxITXNCSG1wQTFBTHBp?=
 =?utf-8?B?eHhKVUh5c0tYTDJWSmF4S0trZGU5QmYrTVNqYk9abW5lOEN2amVuV0Fyb3Vu?=
 =?utf-8?B?VHZpaERXRFkxcGV1YTB3MUlJakd2bngyVWtGcmtmNlR0WFRZeDdTSCtUYnR6?=
 =?utf-8?B?Szg3bHYvL0VaeklMVTRLaUp2TENuY0VlNlRBZzk3QXZ3WnBuVlExaTN0N1ZI?=
 =?utf-8?B?ZG9ZNm1mdkpYbzdqWUNyWm1janJVR0tDUUxIbkwyUWdoS3U0MEQ2TFdUcXpI?=
 =?utf-8?B?T284U2ttWUI3ak5hc1lQRXBHejZWTGRCcHl2WWhDVkdvRFhmS0QwZHNwd085?=
 =?utf-8?B?U2NpTFFEc0RXZ29DMTZwM3JZVXRFK1dzc0s0cmdnT0NuTDBzRGVicmVHSU5i?=
 =?utf-8?B?aW90WGU5d2k0a2F3cTRESXo3WTlaRUlNTnNKOWgxS2RTY3FKNkh1YmpPSncy?=
 =?utf-8?B?cWdKaXFvZUMwOEJzbi9pTXJrYTJRK1VRN1RRODcvVWErdFpoWEtEZmw2ZkdF?=
 =?utf-8?B?SjUwNjFoeUVkK3Q0SDh1cmdtVmkyU09EamV5WXRhRlo0cjFwMU11VktXcnEw?=
 =?utf-8?B?TGlwc21lUHlmYkxwOGZpeDArT1VRZXk3YUhHZTVWYTQ0MGtvbUxjMnF5Z2pu?=
 =?utf-8?B?ai9wR3lucWhXR3o5M3NIVnpBcDc4UXlIejB5dUprcVNHUmY0d210cXpQaVBj?=
 =?utf-8?B?WHhGN1FvWTVqVHhhTWhPdFFubWxVK1dIN0ZuQkdrcXgwSGtzUTc1NStsSkov?=
 =?utf-8?B?ayt3YjUxbjFZemkzS0o4b3oySDhZc1JUa1JhTlh3OVUzSHQybndNNTYvWWdU?=
 =?utf-8?B?SXVDRmwrRzFQQ1ZSajFZbGtKS0tVWkRxamVMR24xVitCMTl3cWdkSnczVCtt?=
 =?utf-8?B?SzFob0R6UmtrYjZtTDJWV3V2ZmZwSURtRW5pbmdybklzTWtxOXM5Q0RtZGJj?=
 =?utf-8?B?SnFWb1I4Y2N2RFpHNC9TMmZsdVFjemtJYmxDcWpaVmF5NkJVaHdYSUlHaXVw?=
 =?utf-8?B?MlFzNmZURUs1cXZMbHc5SVNDdi9pN2hKWTRadUpTTHdUVHdOZ05kQ0VxbHNr?=
 =?utf-8?B?VjltT01xMi9pblQwZ0J0UVAvU3puY1pJNWNsYzZFN2xiRHpWdkRiVjltanlN?=
 =?utf-8?B?YmtYRDRaWjNlNkN4MUdobHRWQkxsOWl1TGQ2U1d6SUk4RGFYOFBNOUhBdTlU?=
 =?utf-8?B?RUxJcmZ3cmpXbWxqR21DUFF3c3FLMlVLVDFKUE5iU1J1Sm9pTHR1RUJucnVu?=
 =?utf-8?B?UGVSODJTYUFZUkgrZWFoN3I3UzJrTnQ4Z1ZUcEJCWkE5Z0wvTm5jMGd5ZFVU?=
 =?utf-8?B?bGRVT2ZPaER4Y0tnK2xiNXpvTmZQZExhSHUvUlRTRnNhUkVQdFBNRTJOK21F?=
 =?utf-8?B?K2FqbHBsMXF5WkY0dVlMOUZsUUNETENLTnM0Z1EyY2RibWYxRjZ5M3FTQkpa?=
 =?utf-8?B?ZWxBekdnd2Y0YVo1bXJLajlvWlBzUTlLakhKazhONmhkVFRYTVVRYVhnVFNo?=
 =?utf-8?Q?7ZfO6yoEniKn/rMtDCmRDW2hh5ZpKoSpGnWbLKNpnI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77c7c65-49e1-4bc7-b423-08d9bb29e4d8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 15:38:06.0574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ6FXQ2digFwS2mwx0krRQWqCk4mf05acD1YH+8LJvw6uk6abjP40uhryAC1DMzEopwDUJxvKz7Vs1cTD5ufAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1500
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2021-12-09 4:00 a.m., Christian König wrote:
>
>
> Am 09.12.21 um 09:49 schrieb Lang Yu:
>> It is useful to maintain error context when debugging
>> SW/FW issues. We introduce amdgpu_device_halt() for this
>> purpose. It will bring hardware to a kind of halt state,
>> so that no one can touch it any more.
>>
>> Compare to a simple hang, the system will keep stable
>> at least for SSH access. Then it should be trivial to
>> inspect the hardware state and see what's going on.
>>
>> Suggested-by: Christian Koenig <christian.koenig@amd.com>
>> Suggested-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index c5cfe2926ca1..3f5f8f62aa5c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1317,6 +1317,8 @@ void amdgpu_device_flush_hdp(struct 
>> amdgpu_device *adev,
>>   void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>>           struct amdgpu_ring *ring);
>>   +void amdgpu_device_halt(struct amdgpu_device *adev);
>> +
>>   /* atpx handler */
>>   #if defined(CONFIG_VGA_SWITCHEROO)
>>   void amdgpu_register_atpx_handler(void);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a1c14466f23d..62216627cc83 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5634,3 +5634,42 @@ void amdgpu_device_invalidate_hdp(struct 
>> amdgpu_device *adev,
>>         amdgpu_asic_invalidate_hdp(adev, ring);
>>   }
>> +
>> +/**
>> + * amdgpu_device_halt() - bring hardware to some kind of halt state
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * Bring hardware to some kind of halt state so that no one can 
>> touch it
>> + * any more. It will help to maintain error context when error 
>> occurred.
>> + * Compare to a simple hang, the system will keep stable at least 
>> for SSH
>> + * access. Then it should be trivial to inspect the hardware state and
>> + * see what's going on. Implemented as following:
>> + *
>> + * 1. drm_dev_unplug() makes device inaccessible to user 
>> space(IOCTLs, etc),
>> + *    clears all CPU mappings to device, disallows remappings 
>> through page faults
>> + * 2. amdgpu_irq_disable_all() disables all interrupts
>> + * 3. amdgpu_fence_driver_hw_fini() signals all HW fences
>> + * 4. amdgpu_device_unmap_mmio() clears all MMIO mappings
>> + * 5. pci_disable_device() and pci_wait_for_pending_transaction()
>> + *    flush any in flight DMA operations
>> + * 6. set adev->no_hw_access to true
>> + */
>> +void amdgpu_device_halt(struct amdgpu_device *adev)
>> +{
>> +    struct pci_dev *pdev = adev->pdev;
>> +    struct drm_device *ddev = &adev->ddev;
>> +
>> +    drm_dev_unplug(ddev);
>> +
>> +    amdgpu_irq_disable_all(adev);
>> +
>> +    amdgpu_fence_driver_hw_fini(adev);
>> +
>> +    amdgpu_device_unmap_mmio(adev);


Note that this one will cause page fault on any subsequent MMIO access 
(trough registers or by direct VRAM access)


>>
>> +
>> +    pci_disable_device(pdev);
>> +    pci_wait_for_pending_transaction(pdev);
>> +
>> +    adev->no_hw_access = true;
>
> I think we need to reorder this, e.g. set adev->no_hw_access much 
> earlier for example. Andrey what do you think?


Earlier can be ok but at least after the last HW configuration we 
actaully want to do like disabling IRQs.

Andrey

>
> Apart from that sounds like the right idea to me.
>
> Regards,
> Christian.
>
>> +}
>
