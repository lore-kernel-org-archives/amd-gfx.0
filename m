Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD016606A323
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5h37O6LJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4BC10E2FB;
	Mon, 16 Nov 2026 15:26:57 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B2810E2FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5wxl9zVQyrWlklh6es1AVz+N56CBcZ3JgXUWf4c/bfvwbcTqlG8h+Ydet7tWfpYkCn9tIHSG/5fdYo8ImVQaMNzBaB9mVgXLMNeIqN2cyfNAWzpyUQmAIuZsWiwe2/Sem7UkB/NhY9OS3heLfN6RgNMhEeN1RmAG7euysU2ETS1twKOLtgf4p0mA321lxoDeE7g6eAkvt725GhWmopC2jIUllW+yPVqlZ+3U1dLApyfSEHbDEjNoz26iX/oWrww2q3JaOVReOZUU+iDj59bNPa6xzhfluv9Y7F1qH5FJ0Ir1hBwYyAgvSITSg2gC3t9L9TWlqvmdEt08EZYUncM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkQU+OkJXg27B+aZiV+eO5nFao07hkU8h6hrXH/y/mI=;
 b=B4L24gFUgFSmJdjk1vdwZGz1SrImFynr5tvIUw/0x0nqdLXUn5WKeldtWVhlQc8ViAHB7iQF7C9lF+/XtIhhCVqlnIplZKHP1raXzQc1yCRcFIcZGT86lwagL1462Oydvmkdfve14aVfl93tjt0Uf0sFMN6ZdcNLmJOP7w2RXUv0B1P2Qkk7TyJMxNLNWyutHWNSOf13PlfSEMP68V8ib3GsHTW5GfGHwhVEKcLq1f9VpRNYJV4EuTz1gfSm6GbRMw/AYObleKH/GtkGTDjbcUk0SjIrSKZKN4rnp69g2aXLGMqeELxP2v6dH5DmucnbonKMcm7rIxEEOU+Ea2fN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkQU+OkJXg27B+aZiV+eO5nFao07hkU8h6hrXH/y/mI=;
 b=5h37O6LJtzFkWPDXCvBxAHxCFqQLf6EwqUXFHeaT/CmpZKHs0MVKB+uRGyfAOwZTePAnSCFnCPDrM0nrTViEz6MxCNvit4Cm7FiXWzJ4Z7zDNzB0TGuzMHWe7YcDTMM7GZR4L0OWNCAyVBmI2jZiMROFZMziUXrttk+ufsDaWmQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB720236.namprd12.prod.outlook.com (2603:10b6:408:3e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:24:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:24:45 +0000
Message-ID: <2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com>
Date: Mon, 16 Nov 2026 16:24:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, yangp@amd.com
References: <20261113202944.3006069-1-shahyan.soltani@amd.com>
 <e5e11770-9d68-486c-9c15-31369966a536@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e5e11770-9d68-486c-9c15-31369966a536@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB720236:EE_
X-MS-Office365-Filtering-Correlation-Id: ccdfeb4a-fb6e-404a-287d-08df43f5be4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|18002099003|22082099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|261022105027099003|261028144727099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Tw0SBaPmtEV67xSPKMUktrflboz3D/JgQ2gO1XEwdJ3QisQ+bfl7WeedyBnz9RSs48Ck3cp3tRsJbjtwjEppkrGruZfaQNkOWw+8Uat39rSx3ChsRNrwsNbQPpQ+mnNoMuU0mPSTaHLyMDJ1p0Ip1YMM3e1hjqwoWI4pwzqxT/xgog2NprWFrQOcabaKZfakVySPMMM6DrPSm4fAw8flr4qeRExq8L5JmoZSeoMO+L6CT3/7XyhXnmytAmghM7jB2ydl+y1sYC3Cw1n8QAo0ewmHJZFegHadlbsuZCxhjZCv6v4TAnBYg+byMt0uX1vU756Zbpg+i6OdeiVnSpKdNmQJROYcW98cKefRdKuPs7nXZi/yHiCy9EKwB5StUd12PWi5xhWZlvEaJzDEqDS7lzT24GxGI8dClcyi6MUrGd9GTKdECtoaSk05x6icYGVgnQjhxEppKlkZ072Jqsjt+sr9Gyz13vYwQJsAoCz8/UwyJjbN7joTs/ACUJ0TYhO1SOkalgOetl3ezvQkdLPfiC8SzHerWkVOfIPGA6cUbqS368imByECj9uXiDZ1lLnUakuuTWcf7W+LnpCDFLg8XpJZ1uSofxh5sg7L6fZlAWPQt/BURTXQahw51xeO8Iy6SsRmJg0rF8Sdn8Q5IYVzASLqef/T1e70UtzSfndEcoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K21QT1V0UlZ1SEFjREFiL2YrM0RIUzZDcEFLc2t1bW44VEpGcVZqNS9POUhq?=
 =?utf-8?B?U2JXYmJXQmdEV0dTNmxIRnR5WEd2VFlGbm9SOVB2L3hadTVTU3RINmJTN1FB?=
 =?utf-8?B?RnRTRE96eFhwZDF1ZmF5aHpMRUQrbkc3alJYSEJrbjhpUXdDQWVwUEFrSlRE?=
 =?utf-8?B?dWdNRmlkNVJWODRBejNWOEJJWENqZDZSMmp6d00wVWQxbURZMU0yL2FheHh5?=
 =?utf-8?B?VVZzUnJocUxrTk1hOW1yb0JYYnBqbWxEaUpGeTErUFA2b0dZSlRsYmtzZno5?=
 =?utf-8?B?aS9vL3RYTHZ4K3NLdlFPaHlveS9KQWhVMVExRFpKTlA3Y2xXTkxXVFFYcXQ0?=
 =?utf-8?B?dmtHcXhlSm94bjMrSXd6d2hSYnlOUVBIWWdmSkVBQXA5UEUyYUtzd1IrdlVH?=
 =?utf-8?B?eVNDRjMvL1gyNCtQbmNKcUs5alBueHlQMzZyaDNudWQwakxPdnJBTEFUMHRM?=
 =?utf-8?B?M0tya2toRXJpNUQ5OHp3Nm1yMktyV3hmT1VLcTVzZDhwcVAvS2dMaWdKVnNm?=
 =?utf-8?B?YmlBcldSUG53cnZKTklaS3VYMHorOE9uSHB0M2tkUGhsWXFncHNtQ2pVVTEz?=
 =?utf-8?B?OUJiWkVTNXpJeEI4eWFwVmVLOEs3WmFUdm5LRll2M1BhZ1VQek1xSG5EVDNV?=
 =?utf-8?B?TC8zVFlxWFNFdzRVai93ZzloZllneEs4dTBpYXVGUHJhNVgxMW1HSXg4YlJl?=
 =?utf-8?B?aWNCeG9YaExyWldPMEVkNzJTUzdmYmxNQUJ1WitPUU0xOGJwNjlxb0xIZmEw?=
 =?utf-8?B?VXE0NVF6SHlXZCsreVZOOHpOWk1GaStwSzlGRHZRR3pzNENZM2NIN2hYc2NB?=
 =?utf-8?B?NGxGVXBMZkxuaTB0cEhtblhkYUUxZFRZZHNmS0J2cjh3akFwSXdxU1BKSWZ0?=
 =?utf-8?B?QXkvVnRYZ0dENFVieTVuS1dqSk5oK29YcjdOT00zdmsrR2NWVitValFIS3ps?=
 =?utf-8?B?Z2ZQRTljRFc3bUE4bGNIOW83RFh4c1ZoS09TQ01RWjRRWGQvNS9UME9KbEtE?=
 =?utf-8?B?aTg3b2VIM29UWFFFV0diWGl0Z0MySExYWUI0bnp0V1lBQlpXV1l5akF1dXRN?=
 =?utf-8?B?Wi9OVTdPc1ZjYVg0bStjMFlCVFNpMmJuK2d5ZkIreFQzNHAzc3hJZGZjb2Qx?=
 =?utf-8?B?bGxmbUFNeWVhdlYxWUFBdFV3azJEMXVKTi9oUHpPZnlHWkQxa0hpN1VlaGRF?=
 =?utf-8?B?ZGJsUDI3QWVqUUU5OW1kQ2JkZ3hpamJvVVpTc2M2Y1hxeFFWcVd5UjBiQnFI?=
 =?utf-8?B?QlBZakpYc29MNHhZN0NGaVpEOEcwKzlTWTA2NUhhYXdlQmV3dlByc3JSM3M2?=
 =?utf-8?B?d1ljYVpieS96dm5kODg1R3Eza012eEV5d1dXT3E2b0hxN1Y1SWlKdVVyeUky?=
 =?utf-8?B?QVpKNE40eGNZcitBZTZzbitqcmM0MWVRTkhnZ2hqc3hFUDRiSjJZOWFUY3F0?=
 =?utf-8?B?MVFHQVVSVWNaY1NDa1lkelg5NEhlMWtvQUJ5NDd5Y2RTWTFvUDRmUzZkVmNW?=
 =?utf-8?B?QjRxSWQ2Z0pTWWJBNGwyZkhaWjI4OGlqdWpJMk50ZUFOL21xSUZKdjFoWVYy?=
 =?utf-8?B?aW1TR3VzNzhBR21pL05lU2ZBZHY0ME5PRkNiWnBwK3ZHWnZ2ODFpcUNPK1dj?=
 =?utf-8?B?TTRoWUE1ZTk0K0xnYmFEWGZFUjdKWmF3Q0pET2U0L2p1KzF6M1BqNDdUSDRm?=
 =?utf-8?B?V1BDelNMNHRkWmhZWTd6UUlYMXFFTm8wd1c5N0d5ZXJHcERhWUo0TW5DUm54?=
 =?utf-8?B?MzZ2RUNLTVJGL0NxM1RobUxvbzVqQVVaQ0k5NW94M3JyYkpsTnZrTFVMMXZM?=
 =?utf-8?B?UjlaOUVDY0QvM0w3NWFGTTF6WHpMQm0zZ0V0UkxWNHZaeFczMFBXWERiSDZz?=
 =?utf-8?B?Q1U2M0Q3ZjFVV0lQZEI0djNsRWVwcHNtcnBBQlMrcE1HSFF1NlV6M1daYjRT?=
 =?utf-8?B?MlBkanRzSUFZa2RkQmxURDB1UEdxeFlMbjZLZFZtMXdtZWh0WTBwdHIvaGo4?=
 =?utf-8?B?aHBNVnp0TEUrRldjWGlGYnhtcEhLM3hNYmNlMnBQK3d1eHhFUDdOOWJxL29B?=
 =?utf-8?B?R0VzY1NLNmNPSHcxNjI2N0RCV29yWHRGS0R1c25WZkxoc01nSi9KUmppY0J3?=
 =?utf-8?B?em1UYzNxM3YvakJ1VExmbDlpOUR1Rm5xZG13RElCRU14ZGgyYkU4UEYzZFZi?=
 =?utf-8?B?bHlXK2JPZ0ZNNE94TlNhYUJPQXFLeUNoenlndHVTWG1CdXFRSEFPazdmVVF6?=
 =?utf-8?B?QVBtVW43SHZHeDFPbjBwOFR2MkZmbnllUG9zTXhoUU5qMWF5ZUFNdVBUWWZt?=
 =?utf-8?Q?TFqUsAMmouXvxIcHeK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdfeb4a-fb6e-404a-287d-08df43f5be4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:24:45.1678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOV5h/+p3GimSLbvr3Gv97iKuLTa1+NpB7HhAt/pEdeISecqas2mjkNT66YfIosq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB720236
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 21:40, Kuehling, Felix wrote:
> On 2026-11-13 15:29, Shahyan Soltani wrote:
>> Previously, the root PT was never cleared after setting vm->is_npa =
>> true within amdgpu_vm_make_npa(). This resulted in the flag
>> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>>
>> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
>> been pinned/validated. This allows the root PT of the NPA VM to be
>> cleared with the correct value.
>>
>> If the pinning or reservation of the bo failed, the vm->is_npa flag will
>> no longer remain as true. This is to avoid conditionals outside of
>> amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
>> the VM is a correctly initialized NPA VM.
>>
>> Warn if the VM already has mappings, since clearing the root PT will
>> break existing mappings. Do a heavy weight TLB flush after the root PT
>> clear to avoid any stale translations being left behind from a previous
>> table.
>>
>> Remove the redundant second setting of vm->is_npa = true.
>>
>> v2:
>> - Add the WARN_ON sanity check regarding an empty VM. (Felix)
>> - Change the return handling to only set vm->is_npa = true upon a
>>    successful pin (Felix)
>> - Add the heavy weight TLB flush after the root PT clear (Philip)
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 94b1cfe05e3e..c7187e0f99b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2820,20 +2820,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>    */
>>   int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>   {
>> -    int r = amdgpu_vm_make_compute(adev, vm);
>> +    int r;
>>   +    r = amdgpu_vm_make_compute(adev, vm);
>>       if (r)
>>           return r;
>> -    vm->is_npa = true;
>> +
>>       r = amdgpu_bo_reserve(vm->root.bo, false);
>>       if (r)
>>           return r;

You need to reserve fence slots both for pin and clear after locking the root PD.

>>       r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
>> +    if (!r) {
>> +        /* Check if VM mappings are empty, clearing would break existing mapping */
>> +        WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root));

You should probably move that to the beginning as if (WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root))) return -EINVAL;

>> +        vm->is_npa = true;
>> +        r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
>> +        amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
> 
> The TLB flush isn't really needed IMO. We don't expect there to be any previous mappings that would need to be flushed. If there were previous mappings, we're in a broken state anyway, and the WARN_ON would tell you about it.

Completely agree. Sashiko-bot also complained that this wouldn't even compile.

Regards,
Christian.

> 
> With the flush_tlb removed, this patch is
> 
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> 
> 
>> +    }
>>       amdgpu_bo_unreserve(vm->root.bo);
>>       if (r)
>>           return r;
>>   -    vm->is_npa = true;
>>       vm->need_tlb_fence = false;
>>         return 0;

