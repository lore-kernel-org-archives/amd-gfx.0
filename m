Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9BFCA5FAC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 17:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38ECA10E1D2;
	Tue, 29 Sep 2026 17:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dUj6SiXf";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010007.outbound.protection.outlook.com
 [40.93.198.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF1510E1D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 17:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baJ9YXjRrzwuA2PO8rAd5vIJQIt26baYPZHHqAH9WvrymXo2WVvx29ZQBxf4Wx/imW3dcIBzHqwe6zTY1JQmQi/3zeLlQ0j539iiAgiNpdxi468dCDHSuN+tyXHRvvBZzLplq4q1tXJKZhyp9abzdF5ZPGGny4NcbTNUZS7YzfJ2CUileJtc9BrI0jELTBMpWPIdpgU3Rgaqi9pK6LxvQ6FB/6ZuxSL/bFvDDenjpzG1vPaIQKKZ8pU2eIUmtuCH4vflv3I1fZpdC1GSgR64Jsdghz/ZvG6Ssdus5CYAJG130yXdglcBUfFDCUYMIGt8dXTLyX7RcGa7/2xe8ofUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwyWrK+Sh7KZMzokSM0m+xSdHJR8mLOLUWw7iufIWYw=;
 b=CjFDr7u0U8vC0AmvFFG/iw1F+e5Gy2J5GOcfJze5Yff8ZZGGT9T5pvPFYo8dFUuMo1pXFPqU7aZH88yjHKE5eqNE1NFEkqY9zibM4g/Mw4A92tkjpnYgp+8ylEhqthGwyKB6cRuN4FGEe5+qFu+X2dzDTJW+i5VeKTXHxGLIzDTGo9luYH1WmHdgg2rD+apFla2k1PWnmfTdt82Z7U9ntzpRjmnhR8dhvaoVMfxR+Lt60ZU7ZfFq6ysiaulBzyBMvYVviXKfe1nvaFg3Ft6OMYeWEZsheBzAt6YOzXL0+XurRYOKFyy7UQXqkFEFo6jPaiRdpC8X5dQG1NvAZMwecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwyWrK+Sh7KZMzokSM0m+xSdHJR8mLOLUWw7iufIWYw=;
 b=dUj6SiXfdZywbRDv7a7ybWCimfDYAy3BNQH4lLozNvDYeVQOKhnqILoMeOjhNoSVVUaJT8xn3mgixDaymCWsvHSKTlXb32ZDpJFDcfRxLHhtEduW0THLB9FJk7WzesI+KxYcREVL3MW2HLkliOotwXybJGuQpGLabCHhLS6izgE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 17:41:46 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 17:41:45 +0000
Message-ID: <f100d2bc-fe66-45f8-be68-9d0436df9bc5@amd.com>
Date: Tue, 29 Sep 2026 23:11:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] drm/amdgpu: hand out the dedicated SPM VMID from
 the reserved path
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-2-sunil.khatri@amd.com>
 <4731b165-af7d-4a1a-a06d-cc817e80d0ca@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <4731b165-af7d-4a1a-a06d-cc817e80d0ca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0093.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::13) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 5886250f-c4a1-46e0-5041-08df1e50ee3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|11063799006|5023799004|10067099003|6133799003|3023799007|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: OlHv16eOnWIWLh4aavelMb4/yldOU+/bJZiIn+OhF+4RUwVSGf9bVwm/olss/I+IGWCYTdKQduTud0B/E2f8p1md1BaSYGeg3iI7tZqhE0L9AMuTappQttKjctK4DSIYkX5xS4RabPnf1PIZWA/wuAEArpL7ThbrKMTchqaaF574Vjce958hbYlvzdOypx26EIi8JX3F98kmxkFfdBkMVS2Ob+qngIkrhm3b1qBTOpLPkoeUtKex+FD8HQPdwcIhtWf7RXhCHTR/fFAHIQ8gOV8WaW42neQjk7p4hpdLH4pGzsp3gJDCJ8s3PCVVQcyA58udPvAevSql9E0e24xgyh1TOLPV+E+BZPoIx1xZgcXEyPgfbeYxdROYav3oMiZ+pwkl0+2c9oxQJbLOND3n/cNxOhZXAI83elUjS/WlBYqhGbjxCC2E3tzwxiQU2smXlD+PUyzU0Vj7LwFgzKe4hI9uwIv6l4Bo/ZvZzvtw811+9baQFsf+AWn1wJcEPNdhorBVXh8nzISVPzlhZkEcxUNBZ3k/ESsYwqdSZM1GnWF1lTctGqFMwzwd09d/0uHpml35KXMnfDqnkfJzKTY7VMI7FRfgBtbM5WWYwbiEerflW77cNpgru6S6m9P2T4NZC0x6WbTjmv/kiOLD9WkfmlF/W01eXcgtQBWWGjxRp5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(5023799004)(10067099003)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdMT000MXJyNmJXdTJtbkE2Q256ems2TjlzVEs0aHpEMjFkZjFDbVpvYzhZ?=
 =?utf-8?B?Z3FtZ3dhNlNPVjFabTJMNVBGR0pwNUVZTi9OS3JSeDNZd28vN1dSOEVROW5l?=
 =?utf-8?B?OXA1SkxwbnJMNFc0Tm1kalpHWmxucmx5bmw0RUJTeXVRejVQcktYS3ppYVIz?=
 =?utf-8?B?cG9kZ3Z2cEhGZDZ2QWIybURLUjNJckxIdUVyQjhNbENPb2RuamYwbm9Mb3Ar?=
 =?utf-8?B?blhGd2szd1dndWpURjhrQ3VtQUJpLzlQWHROVW1NWlh3a29XZ0tMengxdEI0?=
 =?utf-8?B?QVkxeCs0Vm5PbTY5bG1rUWJXMTBIT0RVdzRyczh1RXlHY2c2VUpGdDIwM1R0?=
 =?utf-8?B?UTJnWmlWZHdSbEt3TWlEdWxWN3l2NWtOa0dyQ0ZWZzk1RXdJZmxwcWZ3a09O?=
 =?utf-8?B?NGJBZUtDdjVmWjdUNFNSa25OL0VOZnhUZExyZFBtOFdhMVhuWFR5VHduMlNG?=
 =?utf-8?B?ZGl3RFBrL2dXQTZsbFh3cTF0TE1kT29SMFN6SlZOT1BpSE1FcDdMb2lEOGtF?=
 =?utf-8?B?SEFnbkVLUmhoRjZzd09ZT3VsMnRuQXM1Y3huOVpRNkVoNlppWnZrbXVqVmgx?=
 =?utf-8?B?MWdYdmR2b1dBZmJNWm91dWZ1SkpqdU1LT1I2azE4ZUloMXZack53M2w0RCtI?=
 =?utf-8?B?TjZ0NXhTTkNMTG51cFBhdkF6WXYremgzREZ0YnZUUlZWeEV0OGVTOUtlbEZn?=
 =?utf-8?B?Z1I2ZVIxS2NhQTRIbzRIRVp4SUplUjYvU2FyemRsak94Q3FqalF5OXI4TE84?=
 =?utf-8?B?MENCVkpGVlkyVGE5UzZQUWpnUkxwakdtV0s3RjJlaFFMVEpVeTVBMHMwQXVT?=
 =?utf-8?B?YkRBZk1BUGRGKzdLakRFam9UVEFQK3U4Z3ZKaXplZys4ZE1hUVJ4Z3Njb09m?=
 =?utf-8?B?blRrNjVXS2NZeXhTdm1yd0VxaWgxMnFJUzJDWkRGL1RHSHpRTGZ0ZHlvU2JW?=
 =?utf-8?B?OEsyYkhuVU9QUWdmd0JLWnpMdU92d2U1REZiaFdGYitPZEtSMWNQTDZxZ1dy?=
 =?utf-8?B?VDBkNjVuYUExYkhrdEtUdkJ0RWxtSGFwU045TEtvckJTd0V0VURHUGJyQjdQ?=
 =?utf-8?B?d0h2cUhqcWxZeTl0RHhZenBwK05xdG8xR0RnSmVJRzR6MW94dExxWmZUc25h?=
 =?utf-8?B?aWt4VTVVUHFPMlZSYjFpRENWSHZJQ3FkSnB6bGM5VXl0ZUpqTkdYRlJERzgr?=
 =?utf-8?B?ekN2blZWazJlUFBjMHlYS2RNUm55QnlBYUhvV1pFSStQYVVpdWpEOVc5cXRo?=
 =?utf-8?B?cnlLcmR4N2pwbkx2TitkQnlreWRZTEZZV0F0RGpSNU9Idm5SclpQclp1cUN2?=
 =?utf-8?B?RGsvTE85cEs2YkhYMnBVUVN6SlRRVmRxZ1dVOWpheUpMYTBDeEwrTStrTzIz?=
 =?utf-8?B?UlhSamRqK0V4dE5Kc1AwT2hjMXVHUndKc3BZckxiTFRHL0FpZGZUU2ZLMGhB?=
 =?utf-8?B?S1ZCc0F1SVZSb2E4aVBMeFFqYXRXQ1dYQi9jRG1jdmRzd3grb0tLOWNHQnds?=
 =?utf-8?B?dS8yMmxHcUZncm9KaUYxU0lEVEJOd2p6UjdvcVJ2NGRyTUFQZnVGQnN2QVlM?=
 =?utf-8?B?aERiSUJzcE1WdDhCbktUZHVIbGpjZTNDcExSanQ5TGxTNzFBM2pGbGIxUDIr?=
 =?utf-8?B?UTFSZXVZVzhJcThZWS84RnNVLytIYXNqelVjU0x1WGpNbjg2bVpLK3RoeWNC?=
 =?utf-8?B?SC81YzRqamUrVnJvOGt0ZDNYMDN1YS94K2M4bkU0cWdKNityVER0aUU5b1BI?=
 =?utf-8?B?N1dUZkxCN0p1eXJEZjRTYW1nMDBZNy9peUdDVFNuakJyQVdWZHZqTGtmR3lO?=
 =?utf-8?B?TS9KQnE3Tk1vM0gveUFlV1g1UTZHeWVja3NEL0V5ZVV3RWFlckVPTGRDU3Jk?=
 =?utf-8?B?ZElJa2g1TXh5QkFjWEFIaGlHYzR3SDlXSHhINHNpcEMxUkM3TlJaRHVETmcw?=
 =?utf-8?B?emgrakdWaUl2cjZNSmk1ZmV3TmZHbjZQL0NNRmxMOWs5enptYkRJWkFVRkV2?=
 =?utf-8?B?ZC8vTExDc1YxRmllOThFM0h6RUtpMURQOG1lY0lCZWVxZmZ3dFZmT1dQa01y?=
 =?utf-8?B?aHRFTnhkVXBLMnpXcWdXVXZIdWZES0wzZTZWekdaRXUxUGNmMGdzMDVVSWwv?=
 =?utf-8?B?YUlJbkdFcE1hemwza0NqUEZmdUlIR3ljMXJDZUpqaW9ycmpRcGhsNkJGZzlW?=
 =?utf-8?B?L3NKZWtkTGJrUStXUTVuZ203NTNQcitsaHBiWmtwZlZCYTl2UlEvMnFWNDVC?=
 =?utf-8?B?dndoaGJtUnFzbjRsU1JQVHhZNmdXd0lNcTNJWm9SYU16Zjd6V0VRZjVSR3hu?=
 =?utf-8?B?bWFCcVpUOWJEOGJwVXdFckd0NEpiWFM5RytuTE9sbjB5MmZjL3VrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5886250f-c4a1-46e0-5041-08df1e50ee3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:41:45.7168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILUiSAggTankec+FTAqH4bHln8ZfnARmEjR+yuR98CVcgv2pEiNd80VsUL/IBEnGvmTxkAzISlWBVZCVfSco6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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


On 29-09-2026 05:18 pm, Christian König wrote:
> On 9/28/26 20:57, Sunil Khatri wrote:
>> The SPM reservation borrowed a VMID from the GFXHUB round-robin pool
>> shared with normal graphics contexts (VMIDs 1-7). SPM streams its output
>> through the selected VMID's page tables, so sharing that slot with
>> dynamically scheduled contexts is a poor isolation boundary and makes
>> the profiling VMID non-deterministic.
>>
>> Reservation now uses the VMID a hub dedicates to it. When
>> vm_manager.spm_vmid is set, amdgpu_vmid_alloc_reserved() hands out that
>> fixed VMID directly; when it is unset the reservation is rejected with
>> -ENOENT rather than borrowing a pool VMID, so a reserved submission can
>> never end up on VMID 0 (the kernel VM) or on a slot shared with graphics
>> contexts. The dedicated VMID is not part of the round-robin LRU, so it
>> is given an initialized active-fence sync on every GFXHUB instance in
>> amdgpu_vmid_mgr_init() and amdgpu_vmid_free_reserved() has nothing to
>> return to the LRU.
>>
>> The behaviour is gated on spm_vmid, so hubs that do not dedicate a VMID
>> simply do not support reservation.
> That won't work like this. The SPM VMID would still be used round robin with that.
>
> You need to take the VMID completely out of the mask. Take a look at when amdgpu_vmid_mgr_set_vmid_mask() is called.
Noted
Regards
Sunil Khatri
>
> Regards,
> Christian.
>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
>> index 5e424e3b6e71f..c8cbd0851d478 100644
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
>> @@ -670,6 +671,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>>   			amdgpu_sync_create(&id_mgr->ids[j].active);
>>   			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>>   		}
>> +
>> +		/* out-of-pool VMID; create its sync here */
>> +		if (adev->vm_manager.spm_vmid && AMDGPU_IS_GFXHUB(i))
>> +			amdgpu_sync_create(&id_mgr->ids[adev->vm_manager.spm_vmid].active);
>>   	}
>>   }
>>   
