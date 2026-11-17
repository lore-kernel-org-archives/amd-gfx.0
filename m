Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984FC606A333
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XPFLBQdx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA9B10EBC1;
	Tue, 17 Nov 2026 16:21:45 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B1010EBC1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 16:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3Uw+Wn3gAV6yIDO8x61rjRZRRVelCjVg9OGS9fp7OVAYjJk8QWgSAjZuOaImfmeGB3lQPmTohkTB+WRNRmz4kgPk4JdBMEqBfWzBNlQ2NyMMmbRSzqPE7J33MfYIiDbpPrxXhoBGt2OsALez+ZJYwjlM2MBmCMHkPWmrS2OVOl8PMF/s/OfQRSRabJOgq794a1W5+B2fOmcTRHqHvllBNIfnjjbJAtNdidkTD21n1kGGzTC5fdaNze6mUql+MqjNxJPCiVahPF3LTXTUSVrKMVvkxpEBh6UWv9csAJysseAhHEKvS0bXw+iWTzK46NMvro7N6UjDCJVyVNiUDmwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQmDUlgosa92kuR5p6z8qCry2iaciJ08fOj/gy5uZ58=;
 b=GZEzPqeiYIAzEtJ4hUWvNsnK8wNlSr6w8syF6fCKlXZESArF/QnLzM3q0RBJb+2R9edQ6QClLbllUrKuHc+SQ7aNrSkWhHaQRBdXob0FNCKj3NunOAORXlpWrlFacTn3KLUvcC4upjpZ7ktqtj1Ln9zeSNVdoGpxdEHnol54BdkRomFdUQvBDClze9rGUXZHuOoxpOYGFhcbzsru5lVe4vVTjZKTF1u/7VCrILbcuDyIWMSd00ByvcE23FRTn0N8rSQvduLsjkbK5GpbAHkisi/x154k5GlyRs4NdrjO5GciIWJ+zLxzPKvwfyGlphkEX/Quwob8RyYH27IDvSxddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQmDUlgosa92kuR5p6z8qCry2iaciJ08fOj/gy5uZ58=;
 b=XPFLBQdxyzdPJIB51YYmnrRuHFTsOwu94dSWYPBgNYaPWM6qcPeKPzWo9IyCWTjqwDezmE/ynUR44YvCEMaWXxzUrLqSKFYx5egHJAY3aYUbqOWCro4lyl9te1MDjS03XooPNr+UdUj57DfaMI7QBkWgenUbqCojyWOAynfGq7w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a) by SJ0PR12MB8137.namprd12.prod.outlook.com
 (2603:10b6:a03:4e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:21:32 +0000
Received: from SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 ([fe80::a63:c537:f76a:675b]) by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 ([fe80::a63:c537:f76a:675b%4]) with mapi id 15.21.0615.007; Tue, 17 Nov 2026
 16:21:32 +0000
Content-Type: multipart/alternative;
 boundary="------------odJoaui050ZbSUNvsMvOjrDw"
Message-ID: <387bc959-6020-473a-b38e-81753f9aa358@amd.com>
Date: Tue, 17 Nov 2026 11:21:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, yangp@amd.com
References: <20261113202944.3006069-1-shahyan.soltani@amd.com>
 <e5e11770-9d68-486c-9c15-31369966a536@amd.com>
 <2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com>
Content-Language: en-US
From: Shahyan Soltani <shahyan.soltani@amd.com>
In-Reply-To: <2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com>
X-ClientProxiedBy: YQBP288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::11) To SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF7B9E98CB6:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 0276cfae-77ea-4031-16c8-08df44c6d75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|261009223027099003|8096899003|4143699003|11063799006|56012099006|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: nQhrn3eczk++r4Ktja1CG4yxQ9UYUTS3peSwmhE6Ir3q1JJVmS3idP166qyb3jNvjPtVdMLmeHKbXBi9c34IwJT8Frn/h/KLmtrU5N9o+22X/P7qx+HuPB1O5jVzLwvbrkKjOYHsDb8UGP1BWOYSIe5Z7p/qWGbY5750H6q6LqRFjUL76QJ+Afi+acQVwY0rJLvDS/Q6Rli5mH6ddwo83dj+Qo0l8DMzVIgtMBiM/u6lu5jO1PQPckSSAjAYrRyXaPP5IPY6IFh0YByWzRx6E1UaYxK9yArBeEnCswu703SJ9IEucnehenAVSOkmlB7uoXfYqiCWtyCzxU/6q5ZvuHPUbBDIcVdeqDC0+yTYOZfGjrI3k+xvSaGWUe3mt8uTQl+vcvXH4ga6jc32LFg2Tc268G01V8I8FEz4Wpsl6OUM4KCP031WNMJaWKlXrmM5JTDv0G6/L5gKvr9r2TqcwdMcKIBS2YwkJCyJEeAMSnP5vxpE271CrWrSyqWH2fheDcvt1T1SY59MC+DLzMAiVJK8+D8wtpAAfc5Gq4/3RxZ3woXBoKVsxV3tMgOz/U0tX2MMGUyLxnZTRAqI7qmUXkiVgYOKhQaHQ2M8UHJOZ4Y8Af/ROYxjBRMWhX3qUAX4wNiGiuH7O99bVK9oQWaEwUUr3Qk2ER5gk2ETrDFyMzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF7B9E98CB6.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(261009223027099003)(8096899003)(4143699003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBzZndjV3BGcXFyVzdEYmhuaEQrMUUyd2MxSUNhYWVvSUZjdG1CcStyeUhP?=
 =?utf-8?B?dllYN0JBWWwvWEpzenVHT1pqeFBqeDJrNXZWd0Q2Nzc2QVpsa2lHUXpoRjNT?=
 =?utf-8?B?YTNITDBDemxZbGZib0hrZVJtdFVBLzJuV0dGSnFzZEE2V01Ya3VsQW8xSG9C?=
 =?utf-8?B?ZmtQd24zYzBhZHZSMThkSllYaTFRelZSbFZSaTFVZlNQMXlvL3ZOYnNzcTFO?=
 =?utf-8?B?bmJjbzd3TzlmaXBPWEgwV25XQzRIUnQ1NFluY1B3emFRc1ZWTldBNGkzK3dP?=
 =?utf-8?B?N0xJWDVLNW1NcGRvVkxUcCtzTkZvUGw5Q2FmcVc5M3hjWVkxVThxTStpc0F3?=
 =?utf-8?B?b3dzK0VVQ1FTc3hqRnhiL3lpckVzWFlITWYzR3VJN1FVSmdFUURYbU1FTVh1?=
 =?utf-8?B?NGJrZzZsNGFXVUdiMVlEYTVxaXNFaWhDaUV4UlcrSmFmb0krS0IrYXlSa3Ri?=
 =?utf-8?B?SXJaQlk0b0FpZkVuYlRDYlVGcGZYdjFjeVB2UkRDVGl1RHNZQkdIRzBjOC80?=
 =?utf-8?B?SFdya1ZPc0duV1Myc0ZXci9NUUJib2hCQmRnRkMwdTBocm9vdjgwV3RyWWUx?=
 =?utf-8?B?eEhBQVVoYzZCVk9TZkViTGREcHBUUVg2dHpJQm5wcVgrUUVUTEx2TEhTTVRy?=
 =?utf-8?B?Uzg4amx5MjBkSlVvbnUvNUdwVWtXcm9vQVQzWHMwMmlvZFA5UFZuOVpYNHVT?=
 =?utf-8?B?NThEYjBXVHZ2NHM1OGRPWFRmV3ZvcGNqdDMwQWhPVHRsR1UzcHFQV0laNUov?=
 =?utf-8?B?T3dNQUNRY0NBL3J3SE5RckZkOWRtTEU1MjdWTWs2ZWluL25RNnFZSmM4MDh2?=
 =?utf-8?B?NjEzcXl1dTkyb0MvYnM0bk9weG5xdlRNNnhmSVh6aVFWSUNSQmc3V2wzRU1N?=
 =?utf-8?B?d04zQWtIc1ZmZFR1QWhjVlFWYUNMc21wQ3Z2N1hCYTB0WFdVdm9OMnR1dmZF?=
 =?utf-8?B?b3I3TVRxUWxGVjR5SUpDbEEyeWxETUo4cWFPbWg5ZlFZWUh2bG5zMEJ2VXBm?=
 =?utf-8?B?WXFJWTVNR1ArWjdBaDBhUnowK1RkRDAxdG5DRkY1d2hwUk5KRWhoQ2xjV2d3?=
 =?utf-8?B?djhvbkVGcHo4RXRZMlozVVQzTXFSZmdUTS90ZncxeDdpbzhqUmN4U1phZ3Ay?=
 =?utf-8?B?R050OEtGeTVYRWJKTThCSDAwNG9rRnNZc1h0Y3Z4VVdWZ29EYTJjYkR6UDlI?=
 =?utf-8?B?Nll5elNTZHZzdmVTc2JtK2tQalQ0MXZtQ0JzL2h6aHF5VzRINHMwRHQxSHdx?=
 =?utf-8?B?c0dtSUg4K1Z0Tm1JQ2FtUHYxQXBEK0dDQS8rVzlWRlE3dHk1QWlhTjZtamxq?=
 =?utf-8?B?OWE0RWxLSTg0ckZEcU9MTm9lU29rNHl1eVhLMlM0ZjBiYnJrVC9FaVFoWCt0?=
 =?utf-8?B?UFI3cUw1WnJHWmh1L1ZiU1EybVVxUmhHeXJxcDJPTUxiaklkY3ZENEZrVnNi?=
 =?utf-8?B?Sy9RRXgrelJPcm8vMUZuNERmVUZySGF4aTc1VEovSWdUbGNIVDM4ODArNHNy?=
 =?utf-8?B?OFl1QmVSNjl3N0RzTnZrZWpXeDhTY09lZFFlN3FSdTVQOENtSUtWdzJHNnB2?=
 =?utf-8?B?VnZIbm5EM3BHVDZkclcvRW9HSmZoaUF5eXFvQ3VoU1A0NlZjS1NJd040dnor?=
 =?utf-8?B?aWpCcDBGY29YQWI5T2I5bTVrQ3BoWWpXYmt3dlpVTTNSL0Q3aDMyTDlhYjVQ?=
 =?utf-8?B?d2VNSHF6WmtOaFV1TEEzaHlyWkw0cHowbmFHVVdRbDM0OVE5TklqVnVqU204?=
 =?utf-8?B?VFI3WG1LYzJ2cVFnbGx4cGpwVy9aZTBrWUgzV1kyeXNCTE1GaGhWQkZSNFJQ?=
 =?utf-8?B?c0FnemRKR0lhQVBEbnVVK1ExSThJTVlBOEdnc3V4MXpxRTM0QVFyeWhzWlRO?=
 =?utf-8?B?VC8xVm1SZS91ZlBIUDJ0MmtsZ1FNR0F3dmVXVFgwOE05Si90eUNiUlErVTZO?=
 =?utf-8?B?ZjhtdzVEajdBUldhVE1GN1JXRjRSUHROMUF0REZUZGREQTJFNy9Qd0VaK0Vy?=
 =?utf-8?B?bEUrbDVmMTVNdEMybVNMNHRKQUdRb0tPbjFBellFV0tFVWlvTlBkZjRsVjdr?=
 =?utf-8?B?Zk9DdGZMZXlnSFk4b0xZa2hCSmJ3V0tpY29MYmRjaE1wbW9sbUZGZHBEK1Fa?=
 =?utf-8?B?R3RrZXpQa2dvM2tDbWpqc3JoTzduUFJPa2s4d2xJWFVVVEY5K3Ixcjh4dzgv?=
 =?utf-8?B?eFJaK3dyVVhxVm9wdEgxN0tnSU5SMHJqSGtiNEJrTHBTSTAxRno5dmtFR0FE?=
 =?utf-8?B?V3NndUZyV0dUbWdrOXJncTczVE1hN0lHV3Zodk41N0VZdC8wbzZTQmhyTzBi?=
 =?utf-8?B?Szc3ZU9RcERpdTFxSnNFZHE3cVZsSmc1bEs2K3dqMjA4Y0tybUpvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0276cfae-77ea-4031-16c8-08df44c6d75e
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:21:32.0214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hvSLveg/++L/nTujpzkX9kmHJ1sWi9/rz1utB0/fAnA+h8uZjmSWaJCQqEi1/vkLtq5u0cJ3JG1rcKb+wEdtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

--------------odJoaui050ZbSUNvsMvOjrDw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/16/26 10:24 AM, Christian König wrote:
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

How come we need to reserve a slot for amdgpu_bo_pin()?

As far as I can see, amdgpu_vm_pt_clear() needs a fence slot to be reserved because of "r = vm->update_funcs->commit(&params, &vm->last_update);" calling "amdgpu_vm_sdma_commit();".
That function then needs the fence slot to be reserved as it uses "dma_resv_add_fence()" without reserving said slot for itself.

amdgpu_bo_pin() on the other hand seems to already reserve slots for itself anytime it uses a fence ("amdgpu_bo_pin()->ttm_bo_validate()->ttm_bo_alloc_resource()" is a good example).

Additionally I couldn't find any instances where a fence slot was reserved before "amdgpu_bo_pin();" was called.
Unlike amdgpu_vm_pt_clear(), "amdgpu_bo_pin();" is called without reserving a slot.

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
--------------odJoaui050ZbSUNvsMvOjrDw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/16/26 10:24 AM, Christian König
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
    </blockquote>
    <pre>How come we need to reserve a slot for amdgpu_bo_pin()? 

As far as I can see, amdgpu_vm_pt_clear() needs a fence slot to be reserved because of &quot;r = vm-&gt;update_funcs-&gt;commit(&amp;params, &amp;vm-&gt;last_update);&quot; calling &quot;amdgpu_vm_sdma_commit();&quot;.
That function then needs the fence slot to be reserved as it uses &quot;dma_resv_add_fence()&quot; without reserving said slot for itself.

amdgpu_bo_pin() on the other hand seems to already reserve slots for itself anytime it uses a fence (&quot;amdgpu_bo_pin()-&gt;ttm_bo_validate()-&gt;ttm_bo_alloc_resource()&quot; is a good example).

Additionally I couldn't find any instances where a fence slot was reserved before &quot;amdgpu_bo_pin();&quot; was called.
Unlike amdgpu_vm_pt_clear(), &quot;amdgpu_bo_pin();&quot; is called without reserving a slot.</pre>
    <blockquote type="cite" cite="mid:2732b8fc-42de-44d4-8131-3d4c8b031362@amd.com">
      <pre wrap="" class="moz-quote-pre">
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
Completely agree. Sashiko-bot also complained that this wouldn't even compile.

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
  </body>
</html>

--------------odJoaui050ZbSUNvsMvOjrDw--
