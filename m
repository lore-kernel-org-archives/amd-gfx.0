Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45037606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=D8JlYLlw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0CB10EA65;
	Mon, 16 Nov 2026 15:11:08 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A88310F23F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB9eYMDczhLwFRzKmLBmC4FzEan+pGbynoLhZ8PpQoEF94PUSAvUzbEgcArnfIVtuQB3WyoAQNwwJPLq3ns8A8qyIr1Mbb4828VE5fEHBDK0TU1O4zJOQVNAT84GzW5Ny+luIDMCibPxD9gGDuZJ6Pl+IMLAcjtBkQpOmvh6owE7hQMu4mzdXPeZTqYWEsSzKTRov5VRG7+du1VMYy0F5ILI2EL99t1kmnb9yJOFMeBChnZ//96H9EOzbkGflJWYUuAgCb43il0dMreD1/cvyDPy+M+pvPCmh2s0M676qp9q4V5CvwioSpHgzlzHrNH5e39J08I+ePDnGhBEKVHbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws7csE4eWuCIZ0PDCVv3N0XsjeavmlRNOyn2/717zrU=;
 b=VBPxGyNvfoqS9m3PYdLbEpuWmpxQT6+81xRVdQy/M2No/NQk4AfVxMcS+48rgljO882MjH/bqst9WfZXMfLVNRVjb4mWPTbsavB5u5sgsjFUpuO5ArIr4q8g/95ISfWBTPbJo94VAUQ9GLS57YAXZ5X8vYbX8c7amnTNWsBluvWfcmKG7CeqjHPT1hXzn4SAK5KDWNkqjdzzNNl/rUjxBv7f//dzyDn4CYX/8Gl2zSTn5L7wHwraQBloptAWO3Yhqfpd8Mu5szWGZvg6kSY46elyPYh6VlYLsmqvn1/8erqfpVMwIqQgwBA8+oJZ4bHjcnkZj55agy9Q94VBc0j6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws7csE4eWuCIZ0PDCVv3N0XsjeavmlRNOyn2/717zrU=;
 b=D8JlYLlwLYz2QTcaEhZ7WXotj4Djyfiw+D8WX27iKmVcCt9y+zo5SIMXSHPIvh2dDjQyBEvdHLRXV2G3jxfT6RdEX9odrBHbJwycS2tN2/5q3g8pP7uJ6jTSAL5uf0S9nx0pm3KqCQBoUK8ZdFihK2GeOT/9zmJQGu3MaaDImiA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 15:08:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:08:47 +0000
Message-ID: <e5daf4cb-cdec-4933-a188-5f757ac6a8ad@amd.com>
Date: Mon, 16 Nov 2026 16:08:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear root PT after setting vm->is_npa = true
To: Philip Yang <yangp@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, alexander.deucher@amd.com
References: <20261113134017.2781893-1-shahyan.soltani@amd.com>
 <db8300f3-247d-45fa-8ae8-1846bde7efc1@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <db8300f3-247d-45fa-8ae8-1846bde7efc1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::16) To MW5PR12MB5684.namprd12.prod.outlook.com
 (2603:10b6:303:1a1::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e62e8e-2ca9-40fc-932f-08df43f382c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 54slZ95/mGvaIWfexXTt/ZC1++ic+uMyMgD4VYjfvGv+mPq8Njp6RPaJ1urhhlObaETqZnq3nwtlQCtVELt7J8tUpRgW4vVxE/uyXN0wGFRayIrp9mqgPv+Cg2AWOrHvEKhQgjJqDI5ZZjjmLTILzCb0feGXx6owZXykF7Tz13Gze/x3lj9uPQgrUBEy2bMt0EGn6PauHnAhIwy3XWlaizYXHFFd375d8xzu9mkmb0oKWF+zwffhlKmQE4SDqvE8WqqLW8sjom8yDnS18ztRo4Su55VRM8G92ySv8YopQM/ApfwDYrIgB3wK7z4CbFD1PmDLm/98Ly6vUnlpVE09jy9fFfWwQFQUYekp0akuaM3HIxeVbwF3mpbvMyiDaT1BHxty0wy3tQb3pVe+wCHZzUXeDADgizFkwlMCfCsXHDaQe+P95BgFEMa7TbPhgbTtEKcZh2Ilv6b4iTp4g2x7SsNQwB2GOmd7Vvm2x5iv/iNDqmQ5FQI4UrAGy5N/Bui6cjmySRao/PU3XnPwRC3TNyGzuhi2n40w5SVXIlQSo8VIRdeXCuZGJxM6rvr0SiZZYuE0ia8ou6KEhvAvTwgzTTE4aSFQD0sSgp6GcjjGhdWv6yQgHkf5If+KsxTc7HyDeWCPNuqMvEd0I1WR8I7apa4ZmPXYh1YtqdUMgNLXGuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWpnRHJiaFJnMXlnclZsOGFqcVpTU1VuKzVmVzBtZFVUcmhoNVdVcGhxdVAy?=
 =?utf-8?B?V1VLWUxVNGkzYVVKaTJJUWl3clY0V0NMZ0RiVVFsTTVyRjczb3hweE1JbkJn?=
 =?utf-8?B?djFtSUhZSjdIdGk2VlNIK0NzNHdYVlowMW5naHRWMDRSaHNpNEZGUWhPM2tP?=
 =?utf-8?B?V1UvYTNvOURrS0ZhbkNwbjhTbTBmOVZuUlhtL2hrNC9mQUQyQXAzd2dIZVVl?=
 =?utf-8?B?TzFXWitISWwzcHZORnk2UHo2QUtoQ2hncXF2V2Y4NlF5NTJnaUtEYlErdXJV?=
 =?utf-8?B?WmFnMWhhTnlLRS9aOW1XaXh4dWFyYWd1MFBTOGkxUzk0M1Z5WDNuSGtEblBp?=
 =?utf-8?B?eXJIR3gwNzJKT3lDKzZmQm1KUldhN3BTS2d1Uit0YkZqajVRbXoydHQxajV5?=
 =?utf-8?B?QjVqbE5peEp4S21Fd1V1SnpnQnJqeXYyR1ZXZEZOajhjUVhNVEVVdWJUS0tH?=
 =?utf-8?B?eEQ3N25xNk95OHZyWXRZdW0zU3dwRi9aYitlM1hXYTFZeEk3MnpUWkVQWk0x?=
 =?utf-8?B?bGdkaDlEdEJCZDVsdHdIQUk0UjJEbzlHZEQwMVFXcXJQaGtEUTFWdUVQc2pu?=
 =?utf-8?B?b3pwdWRscVJBUyt4MTFEaEhvWEtVdkxQR1Y4Ymg0YlJrTVk1R3JwZlZBN09O?=
 =?utf-8?B?WEJ3cUppVTd5cW5EenFaN0R1MFdKeUVxUHAyNHZsdXFCMFhQWmZ5dmN4bkdv?=
 =?utf-8?B?cVMxTXJaRkJBbXIxbGpmK3JMNG15MXZLMFBiVDZVL3k4ZmlzU05salFpRWdu?=
 =?utf-8?B?azhWNDExc2p5SWNKV3dsTjhOdHUzUGoxQ2dHeUdkVWRDeWVJMVI2aGtjb2x3?=
 =?utf-8?B?bXQxVFFuVnU1ZWsvMDFkY0JDYmJrVDFIU3QwWHZqek9UZlptZ0t0ZWpyR2Vu?=
 =?utf-8?B?TGxGUXV2V2hGS25BVVQyRXZtSFcwZnNSSGRZcW1MU2txeHBGUHd6eEJrZHl4?=
 =?utf-8?B?cWM5RDJVV2tXMVREcXZENEdKeGlCb3dvaUVEOWJTNThRbGZ0UDN1TW93U1ZN?=
 =?utf-8?B?Z0tkWmYzdGJFcHlHdkk2SEtqSkJTV1RBeVJuRmdCQXVhN28zU25qdGNyb0NX?=
 =?utf-8?B?YWl2V3FIdUgwbzVtQzhKa05Nb2srNjFBZG1tSFFsUHdvNGpsZTBqdHc5UERW?=
 =?utf-8?B?MHRnZmcrVFV6bjdBNGdYMTh1ZE0rRCtGcnNqYjFYMVZldkNFZldYUzRVV3Zs?=
 =?utf-8?B?R01IK21MV1ZBNWhLTGU5SG1qVXBZRW1Zdi85WVNzdzhLRENvUFZjVVQ3NlNp?=
 =?utf-8?B?aU12aHhWbVRHK0VMZ2xCU2ZMSStwTGVxc2NWUDU2bzlhSk9pY0xBZm9DeTRo?=
 =?utf-8?B?R004TmQzcExuY2xXRkZ3SDRpZmlza2pkR1dsSWM1Sk95SDhGUExJRjY3dmVT?=
 =?utf-8?B?cVdHNGt5Rm13aHZLTWU1QnBoQlY0ZjZRUHFaU092U1NoREt5Y04wVlE4TEJs?=
 =?utf-8?B?SUpia2poNWpWdm82bm0wNjJLL2FzYXpjZ25mYUZISnJOREF4c1BRTUprZVRI?=
 =?utf-8?B?Zk9OQUVsa0d6YTA3SUNFL01RVlg4SGNndFdIZ1N4c21HL0EwRllXVUJ5L1Jl?=
 =?utf-8?B?WWJxOHg2allzU0c2VEwwcTRvQ28vUFJBVzM0dGc3RDhSMEVPekgyRHFnQ2hW?=
 =?utf-8?B?M0VXb3VrbE1KdGQ0RVdOb093UXlVMVRhOE9WRGlra1ZJOXZHUmRwQXZGbXZR?=
 =?utf-8?B?MUdrL1cwVWY4aG5wMXplWFh6OEJBOVdvNXBjRXhSb2ZGeDNMMnRPc1JzTllq?=
 =?utf-8?B?d1JxTlhsSXRRYnJkWXJKM0VnNTFMcFc3TDBzbmp6a0hTY2JlWHUzL3Q5dlJF?=
 =?utf-8?B?SFZvTFJNYXUxMGdkTXQveVFZSWl6OUdHNFVsVjdrSG5hWklUYVRwN1NTT2lj?=
 =?utf-8?B?OU5PVVBhbHBvbmxHdUdrZ01venljYkRBbUVhSjQxMlVLZ2dOWWFjVWJTMlJi?=
 =?utf-8?B?TjBVc2QzSVQzRUFmbzZsbDY1WFNvOVhXc3NIY3pGYkx4ZHJPaWVIb0wyZDVL?=
 =?utf-8?B?M2hVYnFLelh0a1hYY1hka1RGL2lmcktQVFpsa1BBc0xuVWs1R2k3SFRMMDJq?=
 =?utf-8?B?WWVzaFRlZkQ5SDVqbzJ3eXU5VUsyZWk4TitSMUY5V0ZOckF1cjlha3NyREFn?=
 =?utf-8?B?eVVHekwyOStsY2ppZlFTQ0lhOXF4OU4rR0VLR3Rla3l3Wm5WU000MjNJK1FM?=
 =?utf-8?B?MnZZczhVZFRkNDFjbVJPMmxlWXZvZ1MvMzZ5dTU1c3JQbStBb3FyK2RldmI5?=
 =?utf-8?B?Z2ZzUXNIU1hVKzAzTk5FWDkrYzJFSXhSa1NWWUlPamlvWVlQckhzV3FmOW51?=
 =?utf-8?Q?kB1crmd78BXPBSPfHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e62e8e-2ca9-40fc-932f-08df43f382c3
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:08:47.4484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjeIrl+s8Q3M7qflJZU+vWcQoUug4hmdcbdQYPyMNJLhOAkJ2/xvtBEyWB9YMpUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229
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

On 11/13/26 19:17, Philip Yang wrote:
> 
> 
> On 2026-11-13 08:40, Shahyan Soltani wrote:
>> Previously, the root pt was never cleared after setting vm->is_npa =
>> true within amdgpu_vm_make_npa(). This resulted in the flag
>> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>>
>> Call amdgpu_vm_pt_clear() after vm->is_npa = true is set and the bo has
>> been pinned/validated. This allows the root PT of the NPA VM to be cleared
>> with the correct value.
>>
>> Remove the redundant second setting of vm->is_npa = true.
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 94b1cfe05e3e..bc5d4bfdd424 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2829,11 +2829,12 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>  	if (r)
>>  		return r;
>>  	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
>> +	if (!r)
>> +		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false);
> Here we should flush TLB, so no stale translation is left behind from a previous page table.

This is for the initial clear on allocation and from Felix comment there shouldn't have been any previous allocations on the VM.

Regards,
Christian.

> 
>      amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);
> 
> Regards,
> Philip
>>  	amdgpu_bo_unreserve(vm->root.bo);
>>  	if (r)
>>  		return r;
>>  
>> -	vm->is_npa = true;
>>  	vm->need_tlb_fence = false;
>>  
>>  	return 0;
> 

