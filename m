Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2065606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a7kITRnQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7461F10E5FC;
	Wed, 28 Oct 2026 09:35:31 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D13C10E5FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 09:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBz2wXDNHusH+put8LnZ/i9fGfIoi95rDdP0rrGIvp53jEJIKjjjtR+E5O6u1BWYe0onCmEVFFbRhDjSieSewrKCpBq8aypporwIJPF1M0j0E72JLbL1UcbnA3kS946wooZqheW/nPOBPJ5zYraaN/bAP54uFqymHcz+3iWM0B+MRzU/SEaJva34B9uOdb1VDj+myclljN1QhM/FL93eQA3nbeeFHfqxsGJunqCDvBxQeQRiGdlLx7k8w7OIb2VlF2KlHUqoqUMBGwsrCPP1qMTyajshOonaEbiqgDDyG2dfKktiIYGUS2SahPfZ0eexRuTGE1nKdghhMiI8TS9E4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPr6ff3Dp9H8MlHP9xEG3ccKp6TlGjmel58zTHcXPSY=;
 b=aJ5TCZpLCUJcmt2CS7t/dYVogReVTQnio5hN80aPziwm0ofjcA8kxBqPZ3hfo1WJN1ur53yzZ8ZUTtV5jlqYpa6nixU+yKrrZY5aARp0ZRj2KK9v7wUeo+XhS3FIxne6KGhCxtmhPhrTEdTJvWBAhdwL1VT1YdER8FEd5ORfEm7mb5vMvAqBDtUtr50k64hQbB9lLN1N/geJ4IzxXB0Ouehklr9L7wIbxhnr/MLveajxf8h06RJfB350oYG+7b+hhVWG82Dvq/GGu56aRt+2ehmV2yacWONhnvJUtVf+IdNKnV1LaYRvTeiLse9KU1sZ7bNwgJpRGfkKbsyRp2DYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPr6ff3Dp9H8MlHP9xEG3ccKp6TlGjmel58zTHcXPSY=;
 b=a7kITRnQTuLm3VdEfyiKEqLrNgU0ZDDrGdl2KT6JzM8VpRR6Ap/t4sV0q8iA1b2fMkyxxn1GjLY0f8oLovi30bIvUDvu7HcW3APiE2bybGA3Ax9QdiUVa0ls6vg+pZW7kYj2kwNp9ixCqlUMxdYEuhnYKDpPpnXoQJo4Lv44bhM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 09:35:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:35:21 +0000
Message-ID: <bedff0c1-ffe6-4d64-a67a-9926f815344c@amd.com>
Date: Wed, 28 Oct 2026 10:35:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdgpu/gmc11: don't access the fault registers
 during GPU reset
To: vitaly prosyak <vprosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-8-Prike.Liang@amd.com>
 <a59eb8f6-c346-488c-abeb-3e37ec68f4c8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a59eb8f6-c346-488c-abeb-3e37ec68f4c8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0434.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1f8fa9-e4dc-4927-accb-08df34d6c8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|10067099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: lfZDRRA9ZcwEtAnMvNZiikgGYtgZtjqS0D7HhRmhFt63HSTu/OPgT+N2bjRzwerBMNab/NREwcY/t9wIKotwwV1w2TIbzEMAKTGz4Va1HAwrtp3hO0oE2OdizrHjPPpCTcsAp3d9zCzw5Uud0OpunLdJWge9p3CB8yoD6bRIbY+DaW84inv/HFo+57ZuJ68bpatCtS3W4FzD9WDwoEG1u9ybD7UUc4gXZQ8qHqVRtoZx3Zhyq2EkhnKbV1cakp+f30I7Uj/fjZRe3JJ4jkugHzvfbfDvGNMp7EiSRYjqknAZiG2eGkZidWApIpqVjf0ZG+P1NK8+x+79yvNNwHCLc2Okbne5feu9MWwD/riZYTsUamK1ixYtcZsRdOCzIHMPuu7tUtMJt0PbKD+AXuP2gg3QZ2NZwQEa5nB57cDjv3dZ7jXg8FHTb8K3PHiOfb0OGxm2vdL7DMag+GJqF6zkOGnmu9Rjf93EDQi/0dyz2oP27+iaDpLH9aDz14EVre7gJ9mp4O0fu3C1uepmEMk3/im2EeO9WhhiGWaNy9bU6+Cb5jggwReMcW3xq38VX/DtRmIMKnDQzHWVrdMyh1v3qeKJtX5rg9XTLkE3danIewnyJYfyyEwBHZvEMKow7R7Gf+LL254jtxO6qLdn92XHY9uJYPfsSHYzX4Oc/RqXgt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWExMS91Y2JtS3BCaDIrMVNFT2ZlM00rQ083RE1Jdk14VHYrQXlqaFpPb3d2?=
 =?utf-8?B?KzI3WnZyOXNNeEFRMUZ5Z1Z3bi9samQ5RUdqM1JpTUh6R1dkcnQ1cWViQi9Q?=
 =?utf-8?B?U2FZcURIMytZQmVSWDRFenVraFNNbWlqajN6OWkvVnNsaUFGWXpYdkFMVFBu?=
 =?utf-8?B?dS9Gd1ZCMnRPS2daK1kwb1VuSnpLaGV0SlZrM3pYY2pZeGdnbFpuYnBiVWI5?=
 =?utf-8?B?TUFEUkgrazRrVkFFZXVKeDZVQktmc2JvV0E5NHQwelNLNGp5eXB2NG1qNUlT?=
 =?utf-8?B?cXAwMlE4am13ci80VVVrMGV2VVJOb0xXbmg5U2UrN1JGV1RkUm9KNkZLb05F?=
 =?utf-8?B?bEcrS1pQVHpic0lxa2tqWFFmNFNJWkt4elMyVHpXUHMycEN6Smd5bXEycHg2?=
 =?utf-8?B?MzZTSi8zU2xkMnJkVVFJN3VCcS9QVUkyRU9TcVB3bXJjYm5wSUw5MVhVQ1ZZ?=
 =?utf-8?B?Ykdmb25aUWs0TkF1ZG4zUjh4aWE1QnZ4MU4xczF0ell3M0p4UDQwWmhDRi9O?=
 =?utf-8?B?ZlFlVElzbHJhd2lxZFZzcjBqZmFRZVpid2l4Z1NzS3hBaWROTVAramN0SXJ4?=
 =?utf-8?B?VHFuV3hxWGgza21ZOGhDSG1tMm1VWEdHWVo0aTIvVDRaUHUwaDlyNk5ab01R?=
 =?utf-8?B?d05uRml1UUdqTFVUamoxcFU3aytDQ1ZUN2lmZDg2TUhxVHhYOHUwRUZ2WFhn?=
 =?utf-8?B?VHdTRUxFcnNiSGtaYkZQLytZZk9nR1JFbmxLR0pXZDNBSmFpZlhnVnRMaG1U?=
 =?utf-8?B?bXNJTTZkU2NIWk42dk5MS2NHYzBXUkR4REtFUjdqak1YbDBiN093TDF6T29D?=
 =?utf-8?B?bmxHUjh1YzcyTHlTVXRiZzN1a1MwTkd0aTVSckVvNGxuaUlwMFBWdEpiV0Ur?=
 =?utf-8?B?d1VUeExENWFYWTJXNUdGRkdVUnZBTThualk2SDAzN01Qc29tMmJQK0hmNW42?=
 =?utf-8?B?Q016MzhsUVhKOEx2bHRiV21xWHkvWHdkL2h4QTNzN1BGbm9Pd0U3dGhObjQr?=
 =?utf-8?B?TGl4ZDVDdHNzZnZ4citlWjYxZWpmWlJGaHEySFQ0ZHJMQ3N5Rlh1enB1K2Rx?=
 =?utf-8?B?c01ndkJPd1lGTnl5NnI3NmtRVnhQUUs5cFNzaWNvYjRyQWdwOFJqZEIwOU9F?=
 =?utf-8?B?N1IwdUI5WlVKR1c4VlRscnN4bmtCL2I3a25PNXQ3Z1ljNkx2MUd3UXo3TzVV?=
 =?utf-8?B?aFFiTU1ZTHhTNnVqS2RFWDhpRzQ2azE3UU9NbXBRalVHZ2d1OHNpQ05Pd2V2?=
 =?utf-8?B?Qmpxd1hpeWRBNEI1VVVWSXZKZzJacHRaZmRxTVBsaHhLVkhMcnZ4WFZjc3NO?=
 =?utf-8?B?bUx2TU82aHFwS3lDQnlCNVNMdFlDLzRGZW5kOU82ckY3allkbkUzQXBibHRZ?=
 =?utf-8?B?dTRycUxBRm0rM1I1TG0rVVhkb3liRmtPRVIwV3pNWCtBK2VGcnZ3TTdzUG9S?=
 =?utf-8?B?Rkl2VU11WDR3MERWMFZOUUx2MUhzVGpXdmRFNUJReUdiRlhSV2dtbFpDZ2ox?=
 =?utf-8?B?LzdDUHlMRlZVZ1pQSE1MUVkxOHo3dU44cTRyK3VkNkRPTHI2UkRWU2lQdXhu?=
 =?utf-8?B?Z1RkNWNHN1U3MjQ3TVJzR1AvUE1vVmJLK0d2cDcwUjNpRmFjZTlKeEdRcmxp?=
 =?utf-8?B?QmszZ0M2VFB0NkRvZk9SY3N1cHB3V3cxRGJSMnR0c3pFR0hheStLUGdlN2Jx?=
 =?utf-8?B?RElqdlhoU2V3YXBVZU0vd1lQV3ErdWJZVm5VbHM2eGNXdFl5K0lLMGhHVUQ0?=
 =?utf-8?B?QUJPSDZFcE85aFJSUG9FUEF2OWZjYUZPWnFHQVZVbmRzdTZRbFMzem4zL3Nx?=
 =?utf-8?B?cU1qZFJORTk3R1l3QzVhNU5kYjF6RnRVTlNhUFhncXNVVVRhcTVhVE9wK1pS?=
 =?utf-8?B?SmtHY0dLVmRSemJsUUZML2NFZ3RSN1Q0NzVxQ3FxSXoyQ1VHK0wrV0Nvd2VQ?=
 =?utf-8?B?SkVXbjVkanZGVmMvWk81Nk9ZTHdJNWcvakhXL1diMk9sVmlqY2YwL1NLWU91?=
 =?utf-8?B?RlNXVGc5cFdFVWtOUzFjMlNQNVlSZk1vMFJDTDNBR1lwVk9OdUFERTc3Nkcv?=
 =?utf-8?B?dW1Nek0wNnpHYUdKNmZ6b2ZkUUJ0TUZhQzlGMDB3TjVOT29UeDRWY3dCczl3?=
 =?utf-8?B?Zy8vMXg4a0EyU3NYYWVmU0R3eXFqN0Q3TlpGVVBmTFowVFZGWnhMYTM2bndq?=
 =?utf-8?B?SUZQMWRVK2QwMDZ6enczdUU2S2g5aFBGZnFMNHRDRnlEbzJ3NnNQUGNtTVY4?=
 =?utf-8?B?UVB5dHpVZFZ4WHFhdElmVjBqQXNJZ3dsRXJuMFFuZ1BOMFVmNW5rVXFINGFY?=
 =?utf-8?Q?dDinLC25XaZDXUuIjz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1f8fa9-e4dc-4927-accb-08df34d6c8ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:35:21.0308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6KQ0qkevgBsLsnwhnSiU38ldw4Am//MDpf3Wt5T0yvyFYkyVEH4JD9TKVtumPmK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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

I think we need to take a step further and prevent interrupt processing from the workers while in the GPU reset.

So in amdgpu_irq_handle_ih1(), amdgpu_irq_handle_ih2() and amdgpu_irq_handle_ih_soft() we should do a down_read()/up_read() while calling the amdgpu_ih_process() function.

That should also cover this case here as well since in_task() is only true through one of those call paths.

Regards,
Christian.

On 10/27/26 21:21, vitaly prosyak wrote:
> Preventing register access during a GPU reset via |down_read_trylock()| within the |in_task()| is a  clean  way to avoid the hardware access warnings.
> 
> Reviewed-by: vitaly.prosyak@amd.com
> 
> On 2026-10-23 04:34, Prike Liang wrote:
>> IH1 and IH2 are processed from a work item, so a VM fault delivered
>> there can read and write the VM L2 fault registers while a GPU reset is
>> running:
>>
>>   WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
>>   Workqueue: events amdgpu_irq_handle_ih1 [amdgpu]
>>   Call Trace:
>>    amdgpu_device_rreg+0x21/0x50 [amdgpu]
>>    gmc_v11_0_process_interrupt+0x241/0x250 [amdgpu]
>>    amdgpu_irq_dispatch+0x12d/0x2f0 [amdgpu]
>>    amdgpu_ih_process+0x70/0x190 [amdgpu]
>>    amdgpu_irq_handle_ih1+0x23/0x30 [amdgpu]
>>
>> Trylock reset_domain->sem around the register access when running in
>> task context instead, and only print the fault when that fails. The
>> semaphore is held just for the register access, so the reset never
>> waits for the fault handling. The hard IRQ path for IH0 is unchanged,
>> the IH is disabled before the ASIC reset.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 709c3d1b9998..bc3b1ffb5488 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -108,6 +108,7 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>>  			      AMDGPU_GMC9_FAULT_SOURCE_DATA_RETRY);
>>  	bool write_fault = !!(entry->src_data[1] &
>>  			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
>> +	bool read_status = !amdgpu_sriov_vf(adev);
>>  	uint32_t status = 0;
>>  	uint32_t cam_index;
>>  	u64 addr;
>> @@ -125,7 +126,15 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>>  			return 1;
>>  	}
>>  
>> -	if (!amdgpu_sriov_vf(adev)) {
>> +	/*
>> +	 * IH1/IH2 are processed from a work item, don't touch the registers
>> +	 * while a GPU reset is running there.
>> +	 */
>> +	if (read_status && in_task() &&
>> +	    !down_read_trylock(&adev->reset_domain->sem))
>> +		read_status = false;
>> +
>> +	if (read_status) {
>>  		/*
>>  		 * Issue a dummy read to wait for the status register to
>>  		 * be updated to avoid reading an incorrect value due to
>> @@ -137,6 +146,9 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>>  		status = RREG32(hub->vm_l2_pro_fault_status);
>>  		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>  
>> +		if (in_task())
>> +			up_read(&adev->reset_domain->sem);
>> +
>>  		amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>>  					     entry->vmid_src ? AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0));
>>  	}

