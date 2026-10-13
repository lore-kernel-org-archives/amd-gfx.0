Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03298CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 07:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8669D10F501;
	Tue, 13 Oct 2026 07:20:01 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F8610F501
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 07:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzO33HcLjl+eCcxc/SXXWI+3i6e/KIiBn/cVf6AnQT2eulBLxpeOrl6fpJVLRHUxRU+FAieSPz5bx8B6cTzid3BCPPhK2+KlIGFf4MQAhpSiIkgtzPamqNSdY2/y8KYdOsFsmfoEtULmzB7gTEphrW8C49v+C0ulu95rbT6RDANtjLXV51kI4JU03oP5rFqHepmJ9Yrl0uv3s0wwkwcrTphXgVCP02Hs7gl+mtei+U4c4FfmQosAUKCzQXOrS9WDnHg9lNjuTZOtUApr0lI3JldavocFHgLR67sHtrbU/lV1jE7pID4p2eeXSaFLQAKbcOEmiGJ/OZnsIBix8kYc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvs6OBrtNwnt4RhKpE8BHLhNRcnSxgTA87JYFsoNrX4=;
 b=yXFGc/Ieo8GD5MpCRqBnYUdVASMz9LyJHkXGBVTkwkBYZijjpojkJQUhsDI5omfI5Fmthg90WX5SMF4nxZhTTE6lj1iaveoxbaJEGuttdF6NBfoADol0ms08f+bfeEFU24peWBIPnUIoMTJ8VAgmNyoiEkB9q5J2w7qMo/WBUbwu8f+T+0Q1mL+asfC9LLOWWm+sOGJhJN9GgFyvkyhaF6iwGeyjmLwOzoHT6+WlLXa7Z9KqkfpcAtwV98y82Iwqmq92kSv7/ZNi6wvdOmoNv+HcECDJTArPgHluj4c+Utmda4CdGPPZ2BC5gy0gcpaGbCsIWNuoBPhUh6R2dZRuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvs6OBrtNwnt4RhKpE8BHLhNRcnSxgTA87JYFsoNrX4=;
 b=cx/CQCBSJTnJ19Rwumg+jj6V7CxOeUiIkxsPmlPsmWoq9eEZD9OykhCXV+nPVt5UBBqVMY/rbGfawBxQV6JcxCl7nANOcvKYQWP03AoSUyfPzVjMrEe/B3smiXQVh/qBRiD6oc6JJ+GrMESebuqb8lGfOZUMb8hefsNA8PEdF9s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:19:52 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:19:51 +0000
Message-ID: <611d7951-ff04-4e99-b398-3872bedd5957@amd.com>
Date: Tue, 13 Oct 2026 12:49:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] drm/amdgpu: use dedicated SPM VMID from the
 reserved path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261012092429.3937825-1-sunil.khatri@amd.com>
 <20261012092429.3937825-3-sunil.khatri@amd.com>
 <c0230e72-5a35-4e4a-a834-4b9413f611d2@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <c0230e72-5a35-4e4a-a834-4b9413f611d2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0250.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::11) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a9f288-1c88-4973-a939-08df28fa5f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7W3gpcnE0ySn3jgUbJqY1IFMhCXpFZgVge3gvw9B7uJFCl9deoZ26fDPp9iQNxxo4Dcp/RmDrQu36r0jdsAhfvttrocBgWS7iMT8yUdRoBCA5P+Kv4BtClz8/tCW0cyFtwYpDSkEqg5hQC+iOrU7RvslvJSi9eyByF4sZCgF7s4MylQJzRiT1enkBPbIqTQd6uXq++J0sqD2pDfmZZ+/o0c/4m1hM24jV63QMf2gUNXd5q217bAvxTlSafzJBUSpPGq2aZzB9HpJoPsvtVCY3Y9ovbtFhGrYdnb3RHioUGI9omKQso5TNh0nRRXBvKZI4luKCIg/XDcU+gJPKJHekRTit5QclZAllXqpCJiNiQGDKam5fZtotkFh9v4/8FxR2h2FenRqinDUdYWNbce+KfKRAYOjvaLWxW1dyLL3ZN6brBvX6YDjsHx8p6Sc63cdxYG0JH2/yrZ4TLDI/3l2u+5QQ6ecQ7+CmMm1IdI8qvJNFpBQp+uEolK3lLwf/lRWShcjB/UwBdsygBHWDn+9Xz0Iy2dL3SUtsQWyzhgNlN9LPIXc78xBlSRauHDNPMmpJ8T+eZuJdcOgCAdTKg16ecJ/6gNG35tk5XLHTKWOYdiGm0klLuJqKkqkbZ0CHGBOxbXxWDPcxaIpaBWYpFlwwWo4Sl6nLFbzlCPlwLunosE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVVtQllTbzZvVERISUd1SURUMkMvbVIzSlJDM2dwRy82Rk9jYXMvSGVuRnBs?=
 =?utf-8?B?WFVzSkZzNFJMZjU2RExIeVgvN2JrSTl0WElMZXEvaTJYREJCb3RmUzF4UW9D?=
 =?utf-8?B?Q09NV1g4aDZNTVVaTGlSdU4zcDdDaEY4QWpDbEZaNWlPTE4xVTVZejFBTWFv?=
 =?utf-8?B?OHpwZlZIYVF5aUZpcDVKTVZrdHdEdFhWM3ZkcS9XdkNyK0JzTmdpL2tKTmNq?=
 =?utf-8?B?Zk5JcmU0cVBNRUF5ZzBnbGt4ZkNSN21ObGdPZ2hqbVErN1ZTak5Ud2lHZlhm?=
 =?utf-8?B?eWN2OTFYK3RYbXNZUUs0TXY5WVBIZGlQMmhVVUJuMnBPbXVSaEJHT2MwekNQ?=
 =?utf-8?B?UW10RVI2OXBIRDFjMk1tQkJBWkk0K2xzSTE1VVVHeFgyWXBBWXNRaVhhVmpa?=
 =?utf-8?B?MXNJemgycHp6OU9zMGdtaFV1STR0QUFGV1ZuaGFmWHVQS2lJbjNRRzZTSUtY?=
 =?utf-8?B?MXp5MEdRZmh3bHBiWnpPWmNLYTkwSTJTQVhSeWZJWklZazFMZFd2aGJiM0NF?=
 =?utf-8?B?MlBjcDA5TWwxdmhtMWVtNVU2SFJkQjdYQkkxVlR1anFpeDlEbTFXOENncTRz?=
 =?utf-8?B?WU9yeFhybHlFQ3VPK3d0NEY0L3VMRURGcHBpVWRkcXhwbHFaSjR4eVBXbmhw?=
 =?utf-8?B?RTZPdk5lZ3lEV3QwWGptRE83TVVxUzV4MFFBNkMrMFVxcDVxQTR0QnpDQ3dE?=
 =?utf-8?B?Qnc2YUlhY0RQTW5PbSs1UkZIMDFuaHV5V2dOazFzZFNoUDhVcm5ueG9MRmZu?=
 =?utf-8?B?QUlGWmZWTHV0VktsTllzMjRweTdXNmtVRm01VndUT1dxbE9jbUNHcEJNZUxP?=
 =?utf-8?B?OFJrYzFjR0tzY2FsNGNvekpadFpCNU81dCsvMm1ldG9GM0FpM2Rmcm5Lcmdw?=
 =?utf-8?B?V3JpRFp6TzErMGFGbnRqZGx5ZFdRQkZ1WURmSUtkVTJZVE9UMGt5aHU4cU5k?=
 =?utf-8?B?UWwvMmxvTEFlZGZGSXRUL2JuOHYxTnA0Z2xhQVhVVXYrcGxmNXUyU0tPTDlY?=
 =?utf-8?B?UFdQakNPVmxVMCtmS3J2RG1RamVHWENJZ2k3OC9LeGtrUm5MUXBHTWRCZ1Y1?=
 =?utf-8?B?YXV0TitKRFRMSHlUNXZ1RzRBTExSYXlYaGl0cDVlS2hvQ3J1T0tsa0ZtdjBw?=
 =?utf-8?B?UXA0RnpFMUdrNEpib1I5SVEvMHA3K3FkM1p0cVV0cVFlaVczZ1htbGZlemg1?=
 =?utf-8?B?TGtBY1dnVkI5QjBlKzllUmtQVDlLSzZmdklCaklzU3V2UldROHh0NkVKUGRU?=
 =?utf-8?B?SWZKd1ltNDFHbzhKSnNYUGdhYnVqVUROR1ltOTdUZGk1alpONXNkL3lrVTRD?=
 =?utf-8?B?SlU1UzlLWVFHdzZqeDlnNTVSNUVhMlFBejJHS3lmUENnQ1FpRkNYckY2SDZl?=
 =?utf-8?B?R25WdUtXOFVRSXA5Z0FKZlhDZGY5dVFDdkQzN3BCbldhMHg5V1crRmlpc3Jr?=
 =?utf-8?B?S0xZaE9VOVQ5WkpJN3F2Z3JiZHV0OHJleWtlR2ZMS2EyaFBmOFVHTnRaUjQx?=
 =?utf-8?B?QkxQdkkwVlZUbnVYOS8vWDhWZnNBNUlDL0szYkFMMjdrMDV1Y1dvQ1ZCZ1FP?=
 =?utf-8?B?Q2cxUktRU3hjWUVXeGd0ZWZ1cjdQM0o5VisyYmJsR0ZHeURlMGFCZTh4UnBD?=
 =?utf-8?B?eWNtMzBjRUh4Z3VoSWhLMGxFUzk3MGd6akN6MjBZOGpVQ0hIS2lUSHJwd0JN?=
 =?utf-8?B?Z2xvWmNYWHV3Q2JsUnd5dlBkNXg2U3JLaVI5dE0yNTRQbnBUdUtMVUhYWjBH?=
 =?utf-8?B?WngzdkcxeStGWndSMEZIbk5SYmoxZk1yUFgzNU5YR1lnc0M5YjZFeGR3YlFL?=
 =?utf-8?B?YXlDUjMzaWs4TFdENEZkVkx6RThaL3pvSk52MFEzbnZRMFlhSXVhbTVBaEx0?=
 =?utf-8?B?dGdaOWtCUXNySHZGUlIrdThpeXMxN0xHZUZOOFRmNjdMZ2lrUzBueU9zZlYv?=
 =?utf-8?B?SVE5dm1XYUhYN2JLTVFGTW15Y25lVWNqTHhGSnp2YVBjSVpScTVoODRONGl6?=
 =?utf-8?B?dEZ3L055R2xoQjF5aCsyUzFGMmN5M014QWp2ZTJuUW1NTnZOMy9aZmphRW83?=
 =?utf-8?B?M09veXFkS3ExOU5FL2NkQ2tVUU9qQXhxQWhvZCtKSFFpZHpUQy9iT1AwSFlE?=
 =?utf-8?B?S21EUy9uN2p2ZUxSNlB4S0lkNEV1MkUyUkZUdTB6dU4zakhjWlBIMGRDQXdJ?=
 =?utf-8?B?NFV3dVlqTTFtUUUrN1FGK3E1R0pJa2JTdDJnWUdEbmJteG5QRTV0YzVRTmtN?=
 =?utf-8?B?NDFXbCthUllBVG9Ta1ZLRW1VUnY4ME9uSjlmYXdqZk55amhSRmcvbnZPeSts?=
 =?utf-8?B?UUVqR0hTa2VmR1dRbnRsdjNUSVI1SlBjU1NMNnAzK2tqY0FuNkR6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a9f288-1c88-4973-a939-08df28fa5f07
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:19:51.6363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/rTDAK/W+gg/dl/OcgPhQRDU5UWw27JIt3UlEjJp0FnBsGLw6jS+NdiQyBL3MccoNsK153mYifrjdVv2jPCGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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


On 13-10-2026 12:43 pm, Christian König wrote:
>
> On 10/12/26 11:24, Sunil Khatri wrote:
>> Use the spm vmid which is dedicated for the SPM only and update
>> the function paths accordingly.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index ed1efde29a9a5..3617de2368d5a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> @@ -551,9 +551,12 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   		r = -ENOENT;
>>   		goto unlock;
>>   	}
>> -	/* Remove from normal round robin handling */
>> -	id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, list);
>> -	list_del_init(&id->list);
>> +	if (!adev->vm_manager.spm_vmid) {
>> +		r = -ENOENT;
>> +		goto unlock;
>> +	}
>> +
>> +	id = &id_mgr->ids[adev->vm_manager.spm_vmid];
>>   	vm->reserved_vmid[vmhub] = id;
>>   	id_mgr->reserved_vmid = true;
>>   	mutex_unlock(&id_mgr->lock);
>> @@ -577,8 +580,6 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   
>>   	mutex_lock(&id_mgr->lock);
>>   	if (vm->reserved_vmid[vmhub]) {
>> -		list_add(&vm->reserved_vmid[vmhub]->list,
>> -			&id_mgr->ids_lru);
>>   		vm->reserved_vmid[vmhub] = NULL;
>>   		id_mgr->reserved_vmid = false;
>>   	}
>> @@ -627,6 +628,10 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>>   			&adev->vm_manager.id_mgr[i];
>>   		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID)
>>   			amdgpu_vmid_reset(adev, i, j);
>> +
>> +		/* out-of-pool VMID, not covered by vmid_mask */
> Better write "The SPM VMID is not part of the normal kernel pool, reset it anyway in case it is used with kernel queues.".
Noted
>
>> +		if (adev->vm_manager.spm_vmid && AMDGPU_IS_GFXHUB(i))
> If would be nice if we could rather come up with a loop over the GFXHUBs only.
let me see to that.
>
> E.g. something like this:
>
> for (i = AMDGPU_GFXHUB_START; i < AMDGPU_MMHUB0_START; ++i)
>
>> +			amdgpu_vmid_reset(adev, i, adev->vm_manager.spm_vmid);
>>   	}
>>   }
>>   
>> @@ -711,6 +716,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>>   			amdgpu_sync_create(&id_mgr->ids[j].active);
>>   			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>>   		}
>> +
>> +		/* out-of-pool VMID; create its sync here */
> Something similar here.
Noted
>
>> +		if (adev->vm_manager.spm_vmid && AMDGPU_IS_GFXHUB(i))
> Same for loop here as well.
Noted
Regards
Sunil Khatri
>
> Regards,
> Christian.
>
>> +			amdgpu_sync_create(&id_mgr->ids[adev->vm_manager.spm_vmid].active);
>>   	}
>>   }
>>   
