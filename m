Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A97606A32F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qw3jMRta
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA2A10EA60;
	Mon, 16 Nov 2026 16:15:26 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013070.outbound.protection.outlook.com
 [40.93.196.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09ED510F2C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 16:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fu3aKAGCbCcKEVOr2l2lFix6T+8brIC6Z6VAp+jnTzrhvFP8rXdxq8LJnaKEqu6tZEteT30aVZxe/jgMdYSooh2yOgZUdh8eYfVw8RvFeemtxo2LHAa3wWJAxZfSt2STj55wSy7Jz3c+oWZy4amziQim6iAz0eYaIsJsAJhxKZcPIsHYbqsbt4hMhQybV2KLy5B4gRKKVrHUcsHPfyvaHFv92OzxczYenS/JXQyui4fJ+7400GnUEeZEVlj5yMHz9bK1cjynAGiDT8WdlpNmdZ0x0ySYodASuk5ljeyURfiuZYC95fnBz0+i1vDbbcDHf3I5n0Ptz6ee2JAZ1jr4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49zZFxOAxE4l8qCDXeMkv5y55rNqFDcdiglxKCJM6Wk=;
 b=Rtej0K2j6EE90cmbqMKxksH3Ju5x+AiDDufUzVaOO9mIJajOjpTM3nHeyvtTFCNniKgXvrg7LnEiT3+5ePf+lk4szsFjZBlke9kOoAA59e8KVYRQ/nS6Nsjhesl1NxUHmkVGHC9zIsphqDEc3MKuEbUOUDbsakeLi7DlAzrPQmYerx80XPM7CxL3zinYPf08ttokxxZxJ3Lx419bK5w3w9qV1IRbshOtxJgBLPCYSUrQ89HV8cWGDBVjNacCqbjGGlCN5I+riEBARBRg5B+4AJLP4A9w8OBeydZuimDcAMbjbVJ91pztbcqKi23ZZNaquR87LszdbnXDer2KUo4Y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49zZFxOAxE4l8qCDXeMkv5y55rNqFDcdiglxKCJM6Wk=;
 b=Qw3jMRtar/nbegKJ0bMQitlifgxMzJhqI1GrFnWxZLl62qcsgJhO34zCEiF/nMHu8Gj5kIJ12BsSdYZXKSMlk2rwg4jlElUrCMiKVpuSyNf/1+iQUVhRz8Dsg2fmCVMYjwxI4iDM8VGfHm1gEtp61LFgPrBOL7r5yiCQMzyKC48=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 16 Nov
 2026 16:15:15 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 16:15:14 +0000
Content-Type: multipart/alternative;
 boundary="------------lZU3jGsSkJRcHfbRYHMuIN0q"
Message-ID: <ccb9de6e-5456-4898-b370-0724b3aa4af7@amd.com>
Date: Mon, 16 Nov 2026 11:15:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20261113202944.3006069-1-shahyan.soltani@amd.com>
 <e5e11770-9d68-486c-9c15-31369966a536@amd.com>
 <2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com>
X-ClientProxiedBy: YQZPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::20) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: aee518bf-9bb4-4fe9-bfee-08df43fccbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261026121527099003|261028144727099003|56012099006|11063799006|10067099003|261022105027099003|4143699003|261026140227099003|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261022075727099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: 6oqV4oIK4iBLheSDyzBYz6k5c2dqXifxws4+xd4hl/eDQrBIWesHrpDmkOCay2Od+dBxCSj4tdGb/Y0bU9gdZTBqaG4DPU2fRvAd56Rzcm+6QH+C/sOFtd3ippktdhf9z5VAKTFBzXx9pP2NJK7tJagQ1YYO5kN03x3o5rAwdZ2hOiAupL8Th7NNDT4MogXEEeBqtxdOwOHsoIkpQoaeBwry+I84MZ2kAx51Cv6RD39kSyQF5UL6/9bxxsMBW/oNk8IHvMGQHipia5kasgxUSdgkJ3ugW7c1RxwLtYDSB7/vB+qHdyhWHsYXuuWTrmbkFiuruaHFZ+hEYObAypwxi/ArcqtUjF8NHlm/FyLur9Ybx52NasK7cCVEYUOpR+xN4Ul6kHhIWM7tW10WqirAOTS+E2DCs1KbZOeOJS2i/p8cBl8zURF7oW8ihWDN5mel9rWmxafS+4e1jAZDfWEcn8uNuAphqlcv0MuZ86wdDrHTbuo38tng5TUNR8qQYdTx9qdslH6MZ/Y34XssICZfykCmpLXxc8t+XBVESHhWyrr3Kvo3v+WXU5oyT1SCnm+RChxW3zS20Gnp2s/6g+rQBgg0zRcZibbESwxhS6n+yLbTOfUYhagIgWAo2fLEqZ+wA6BTN41jWcP/yYH5CGl19cre5xW7PEGydeUsuVvz5tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261026121527099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(4143699003)(261026140227099003)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261022075727099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0J6bWo1R2RmSkoyWVJYc3JsbGNsMWVIQjZuRUgzRDg1aFpCOU5UU09CNlhW?=
 =?utf-8?B?bzFISmJUWndKTzEydjlIV1IzYnl3azRRNVhWMy9JVGJwcS8vOUhNaUlrUUEw?=
 =?utf-8?B?T0M4VzEvalBGY01qdTFKRGoxdTBTN3FVUTI1NkFnSXBaS2VLcmFOcFB1UE5k?=
 =?utf-8?B?eEhlT3htNC9BaHkxRVdsR2gvL2FLWlBIakkySEVrWE1FV0hleFErRElnS3dj?=
 =?utf-8?B?SkRxSFpVamZjd1FDbGhjU0w3Wld1VWxpaTJHb3diS2hsWnVVZHoxUUg3bzJs?=
 =?utf-8?B?Y0lEVkVPTFJSTC9ENlIzOUlHNVZEYndWa00rU2poYXZsUUU5ajlRdkxZSk0x?=
 =?utf-8?B?K2QzbEU4b25hM0FUbEZVQi91NlJ0RGhZWitlQkpaWnB2S0M2eXpEM0NrVzdr?=
 =?utf-8?B?dzY3NDMyRDh0Q3hpYUVqUEZXNFRLMTd5ZVlpZm1Oa1NldytvNThuSmkzeHI1?=
 =?utf-8?B?NkhoRWhYSFdBTDlpTTNJUlNSM2d1TlJLdTZuMVFpeVFwSHBVY2l4MmVUUkti?=
 =?utf-8?B?akZPbElGZHh0TjY3STVwdy9GTjREeWlIMXhRRzcramovZ3ZVQUpqRlRTNGpI?=
 =?utf-8?B?QWFYYXJLeDNBVmtvTVozY2VKVHZPNTFtR0dOalRyeGF3ZlhBRTBmV3F6MTMy?=
 =?utf-8?B?RFlMMW1kcEFFUlNySUE4VzhvMjhnWldjRm8yL003dE8zMUVSL2w3aWY3QmNF?=
 =?utf-8?B?M2UxUUF4NmxPRmVsV0xSWDI4VFpoVy8yWjhXOWROVE11UVc0ZFBiSVdabWdO?=
 =?utf-8?B?ZUZYRm93dkVHWndhTFJiVHpGOXU3STJvdEhhZk9IUzlvek1MM3M3bnBLbzdh?=
 =?utf-8?B?akZoTkN3Rmc2aWtFbWpzZGJkQTgyYjZNU3VTOXViNHhjRnJRWTRsRE5VYzNp?=
 =?utf-8?B?aWxtbUhxaXZhQkVCWGZ2d0F5eUJjM2ZLNExFVlJoQzh2MmVSc0E5bVBzRjJv?=
 =?utf-8?B?ZUlHWHV6T3c5Wmc2VGR4Vnh0UWhjK3lSbWdKV1BOMTdVU2s2N1grZTI2RnZk?=
 =?utf-8?B?ZExTUHJnOVFHenBzV2RQK3RRUFhWdUVLd1M1ejlqd3p4aFpBWm01TWpza1dN?=
 =?utf-8?B?WVJkUkxrMFp3MGhtMkFMdnY1ZWtEeU9DcnVXUFVOTlR3UElGRXB5YmZHZXNt?=
 =?utf-8?B?cXBybjBnYWRoZ2kzUFlRVHc4K0lsQnc1V2k0d2hoVU1NOVMwU0JLQWlycWhQ?=
 =?utf-8?B?NWc4UStYQkRISU1jUlJlQmNDcTR3ZzBBQXU3aDFvamhocmpiQlpXbTN5Q0Js?=
 =?utf-8?B?YU9mOFRaRGpTNlRFc3daZmxPTm5XR2psdUgxZ0hIZjNzbEY4cytkaytKUE9M?=
 =?utf-8?B?M1YwVmkyNmdmV2Q1WXo1TXB6T2xnZDREazFqTlRYd2pOUiswMWNBd05Pd0c5?=
 =?utf-8?B?SnJxUWwxNElnS01jRCtzUnZxbFZYRm4yVUMyaHR3d2k5TVZUR2FJcXhVV3ht?=
 =?utf-8?B?VnZmTGNtbmhRU2laSTdtZWttWUVzRFBLeEprVVUvTm5VUVJINFpKWTR5NmVo?=
 =?utf-8?B?U3IxbFM4ZlRzWklRWEVzWCtld0V2djVqRFQxYTJQdEpCZHp4eFJnUDA2RlVO?=
 =?utf-8?B?TWlOeG1Ia2ZHaGcrK1Y4b2Uya0oyOUh2WDkwS3d4OTl2MmZKWlhsNS93RmVo?=
 =?utf-8?B?dk9aVnc5MklWbXBCS2hnYzlUSHJON0F0SEFHQVI4SVhyM0RCMFpRelpzdXJr?=
 =?utf-8?B?bTBmKzdiNGN5QWFiTGk5Uk9TQXltZnRudjFJb2tnU1ZiSkQwSzkxQWEyOTdH?=
 =?utf-8?B?MWhpZ1U5VDRhV1dIZ3M5RHVPUm94NGZQK3h4eUdka1VuWlY4K2kyb1J4N1Y4?=
 =?utf-8?B?cW02RC9rYkR1SUtvSnkxZ1RyNDFweGducVpicm1qRi92V1YzczBWb21FdDRq?=
 =?utf-8?B?bG5iMFp1VzhkbDdOVGJ2cWxFNE03SnJvWGVtMUFBMlAwNlpsMlhySVVEOFU1?=
 =?utf-8?B?WVhRdDFIWTZINWtqakswaStmMEUyZXloeXNQd2RKQVpRWHMzc1haUDBGNit4?=
 =?utf-8?B?RUZvWGFlUjRQaHU0TFdEWDJHWkdWTXpkZEo4bTVyQzJWQS9LSzBwTHVRdXQr?=
 =?utf-8?B?U1FvS0o4RFlTenphZmVmYmJzb0JzeTZubGFOSG4zUFUySVFQSURjY2VyVnBR?=
 =?utf-8?B?OGdqS0pUMEFEMytrKytwTUNPcTRhZ3RKM0dLZ2VLbE5ZV3I5WjVVZmpBWUIr?=
 =?utf-8?B?eXAvMk1JUE9nS0RhWFZRSWxqVzkxT3lsb0ZqYjB0TFNNQW8wYU9DSGlpRlBI?=
 =?utf-8?B?V0ZyMXB5bnhqU0JidWt6NVFaNkMrcmZOeXF1czFwc0gzUENmUEZrZEJDWnFu?=
 =?utf-8?Q?mq/6pHZ1JOuiTn3+SY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee518bf-9bb4-4fe9-bfee-08df43fccbff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:15:14.6417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xgk+4kn99bt9esEw6FY3TXcZE2t5ti8mNuMaorNCYEAik6giLTcRpZ5/fuZfl2WJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------lZU3jGsSkJRcHfbRYHMuIN0q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-16 10:24, Christian König wrote:
> On 11/13/26 21:40, Kuehling, Felix wrote:
>> On 2026-11-13 15:29, Shahyan Soltani wrote:
>>> Previously, the root PT was never cleared after setting vm->is_npa =
>>> true within amdgpu_vm_make_npa(). This resulted in the flag
>>> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>>>
>>> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
>>> been pinned/validated. This allows the root PT of the NPA VM to be
>>> cleared with the correct value.
>>>
>>> If the pinning or reservation of the bo failed, the vm->is_npa flag will
>>> no longer remain as true. This is to avoid conditionals outside of
>>> amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
>>> the VM is a correctly initialized NPA VM.
>>>
>>> Warn if the VM already has mappings, since clearing the root PT will
>>> break existing mappings. Do a heavy weight TLB flush after the root PT
>>> clear to avoid any stale translations being left behind from a previous
>>> table.
>>>
>>> Remove the redundant second setting of vm->is_npa = true.
>>>
>>> v2:
>>> - Add the WARN_ON sanity check regarding an empty VM. (Felix)
>>> - Change the return handling to only set vm->is_npa = true upon a
>>>     successful pin (Felix)
>>> - Add the heavy weight TLB flush after the root PT clear (Philip)
>>>
>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>> Signed-off-by: Shahyan Soltani<shahyan.soltani@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 94b1cfe05e3e..c7187e0f99b3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2820,20 +2820,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>     */
>>>    int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>    {
>>> -    int r = amdgpu_vm_make_compute(adev, vm);
>>> +    int r;
>>>    +    r = amdgpu_vm_make_compute(adev, vm);
>>>        if (r)
>>>            return r;
>>> -    vm->is_npa = true;
>>> +
>>>        r = amdgpu_bo_reserve(vm->root.bo, false);
>>>        if (r)
>>>            return r;
> You need to reserve fence slots both for pin and clear after locking the root PD.
>
>>>        r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
>>> +    if (!r) {
>>> +        /* Check if VM mappings are empty, clearing would break existing mapping */
>>> +        WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root));
> You should probably move that to the beginning as if (WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root))) return -EINVAL;
>
>>> +        vm->is_npa = true;
>>> +        r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
>>> +        amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
>> The TLB flush isn't really needed IMO. We don't expect there to be any previous mappings that would need to be flushed. If there were previous mappings, we're in a broken state anyway, and the WARN_ON would tell you about it.
> Completely agree. Sashiko-bot also complained that this wouldn't even compile.
I agree that there is no mapping on VMID 15 beforehand (which raises the 
question of why we clear the page tables in the first place?) My concern 
is stale entries in the cache: after we set up the VMID 15 page table 
address, we could still get an invalid translation.

Sashiko-bot complained "premature TLB flush in amdgpu_vm_make_npa()", 
probably means we should flush TLB after vmid 15 pt setup, like this? 
amdgpu_ualink_manager_start() { .... amdgpu_vm_init amdgpu_vm_make_npa 
amdgpu_vm_pt_clearsetup_vm_pt_regs amdgpu_ualink_flush_tlb ... } Regards,
Philip
>
> Regards,
> Christian.
>
>> With the flush_tlb removed, this patch is
>>
>> Reviewed-by: Felix Kuehling<felix.kuehling@amd.com>
>>
>>
>>> +    }
>>>        amdgpu_bo_unreserve(vm->root.bo);
>>>        if (r)
>>>            return r;
>>>    -    vm->is_npa = true;
>>>        vm->need_tlb_fence = false;
>>>          return 0;

--------------lZU3jGsSkJRcHfbRYHMuIN0q
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-16 10:24, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com">
      <pre wrap="" class="moz-quote-pre">On 11/13/26 21:40, Kuehling, Felix wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 2026-11-13 15:29, Shahyan Soltani wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Previously, the root PT was never cleared after setting vm-&gt;is_npa =
true within amdgpu_vm_make_npa(). This resulted in the flag
adev-&gt;gmc.no_retry_flags to never be applied for the NPA VMs.

Call amdgpu_vm_pt_clear() after vm-&gt;is_npa = true is set and the bo has
been pinned/validated. This allows the root PT of the NPA VM to be
cleared with the correct value.

If the pinning or reservation of the bo failed, the vm-&gt;is_npa flag will
no longer remain as true. This is to avoid conditionals outside of
amdgpu_vm_make_npa() that depend on the vm-&gt;is_npa flag to determine if
the VM is a correctly initialized NPA VM.

Warn if the VM already has mappings, since clearing the root PT will
break existing mappings. Do a heavy weight TLB flush after the root PT
clear to avoid any stale translations being left behind from a previous
table.

Remove the redundant second setting of vm-&gt;is_npa = true.

v2:
- Add the WARN_ON sanity check regarding an empty VM. (Felix)
- Change the return handling to only set vm-&gt;is_npa = true upon a
&nbsp;&nbsp; successful pin (Felix)
- Add the heavy weight TLB flush after the root PT clear (Philip)

Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Shahyan Soltani <a class="moz-txt-link-rfc2396E" href="mailto:shahyan.soltani@amd.com">&lt;shahyan.soltani@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
&nbsp; 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..c7187e0f99b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2820,20 +2820,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
&nbsp;&nbsp; */
&nbsp; int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
&nbsp; {
-&nbsp;&nbsp;&nbsp; int r = amdgpu_vm_make_compute(adev, vm);
+&nbsp;&nbsp;&nbsp; int r;
&nbsp; +&nbsp;&nbsp;&nbsp; r = amdgpu_vm_make_compute(adev, vm);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
-&nbsp;&nbsp;&nbsp; vm-&gt;is_npa = true;
+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_reserve(vm-&gt;root.bo, false);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You need to reserve fence slots both for pin and clear after locking the root PD.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_pin(vm-&gt;root.bo, AMDGPU_GEM_DOMAIN_VRAM);
+&nbsp;&nbsp;&nbsp; if (!r) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if VM mappings are empty, clearing would break existing mapping */
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!RB_EMPTY_ROOT(&amp;vm-&gt;va.rb_root));
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You should probably move that to the beginning as if (WARN_ON(!RB_EMPTY_ROOT(&amp;vm-&gt;va.rb_root))) return -EINVAL;

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;is_npa = true;
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm-&gt;root.bo), false);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
The TLB flush isn't really needed IMO. We don't expect there to be any previous mappings that would need to be flushed. If there were previous mappings, we're in a broken state anyway, and the WARN_ON would tell you about it.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Completely agree. Sashiko-bot also complained that this wouldn't even compile.</pre>
    </blockquote>
    I agree that there is no mapping on VMID 15 beforehand (which raises
    the question of why we clear the page tables in the first place?) My
    concern is stale entries in the cache: after we set up the VMID 15
    page table address, we could still get an invalid translation.<br>
    <br>
    <span style="white-space: pre-wrap">Sashiko-bot complained &quot;</span><span style="white-space: pre-wrap">premature TLB flush in amdgpu_vm_make_npa()&quot;, probably means we should flush TLB after vmid 15 pt setup, like this?

amdgpu_ualink_manager_start()
{
....
   amdgpu_vm_init
   amdgpu_vm_make_npa
   </span><span style="white-space: pre-wrap">amdgpu_vm_pt_clear</span><span style="white-space: pre-wrap">
   setup_vm_pt_regs
   amdgpu_ualink_flush_tlb
...
}


</span>Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
With the flush_tlb removed, this patch is

Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>


</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">+&nbsp;&nbsp;&nbsp; }
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
&nbsp; -&nbsp;&nbsp;&nbsp; vm-&gt;is_npa = true;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;need_tlb_fence = false;
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------lZU3jGsSkJRcHfbRYHMuIN0q--
