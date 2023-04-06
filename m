Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2560C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 15:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2DA10E22D;
	Thu,  6 Apr 2023 15:01:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DB110E123
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 15:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHclHou1FxpH39mT4PNjQw5F5aKFsaLfKHnbFPP4vc0YzaNxmkjLq4cXVYGoiV9P2+Pv3LnFhJdXcQUnHAA1H2Lxeg6bxa0qyW3fl/KAqJsA1e3Q6w7La302ILAJYn68MvYWRCjbR/7RQlLQb/TUt8cSU80UBC5JBRRCtBNnfkA8IpiLU9Wk1KPYKlJbErZXJ86OK+o+KEUXcuUK71w3wTbZpql5j6H5G3rMO98i64xhApmqjnFiX6KNLms0jYeN/tFJCa+1z5Ns9Bk3PZBycUu8ZEklRBrHz0fHr2Uw+he2oDfdQknbtbC51IChd3cKCqUlb+gJ8Uq35OCa6kLMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UDEdQFslvQ9LrLxxaEOIhJbSSsiG/rZOqdNNnKYn0E=;
 b=PSDlrJZ0BvgMkh5ghCFQ+pM4UZf+wb+P/txtZ5TZgQzNUIXa6jGO5B5xHP74KRjY82Yaf+j5GbuFjg6dRMUCQ1VbS2/I7ii5+IPoIP+D8O1DC9eRomN7/JzPq2q7U5pIjJkmG50BXQsbrcUG2h0k3DbUw0a7YiBI4ECkEstlN0SvrpQ3fZFf/sRqBRBGImCyAeK3ubzonG9/zQSgaZwmUOiBloDhG2rwYBVV+bqX65pC0idkNd7EGyqq/Mx9WmTPcqSWlL9VfXQM+8trHsTZcHgQlW4GyH98LTI51kol7qP5OZ2rhyKRsBMMlZFAWt7UXOjfRxX8rzx1stY15Y13Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UDEdQFslvQ9LrLxxaEOIhJbSSsiG/rZOqdNNnKYn0E=;
 b=bHXgXKAvPeZVAlNItRfprArppacb+Znjm7CrpO1pKQ8FoDzWap92CHDOChkJZ9bVX9geEd2nn/ToUSenU2o9BSdN+Oqhd8PW2HHJiy789kuW1/O5/vqZt0aKih5YGDUW//aSLpa38yN9jDLepImY0MnLnAxQ1sEXl8HhNaWH95M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 15:01:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 15:01:27 +0000
Message-ID: <9a9fb334-50c3-5a6b-8f58-486927c6cf58@amd.com>
Date: Thu, 6 Apr 2023 11:01:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: Update invalid PTE flag setting
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230404215923.3739152-1-mukul.joshi@amd.com>
 <67923897-fef1-1b6b-75d6-0a33922e0132@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <67923897-fef1-1b6b-75d6-0a33922e0132@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 048148bc-a203-4aee-a689-08db36afcba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j99yvH7qXKJxMeVSia0cIAQfevJNAG6Vb3M2KALcoKofojTeuW/1WaJ65ks4Yr3FmpCGQxSkb5x8/L+XJBl60n1KHvaT+sWZDMAn6srps8ciikjQKCrxWqHfOSgCx2WrxDx/0AEvSAit53whDh3E3pyjNcHE9WsEsDUqIKt4paWjKblDhj3TqYF3Vt+YTkMcYwQYXwaLYav5ljsMFEBX65uJKCPOf7bQ7jzwsVvp4fTIywvRcIqmHqEYGZ3kY4AiylUV3wzRYa2TG3MzA6xqSJMIWFx8HApQWRTIUrqkvb9Ft3nNRJz4L3l2bjjHY6d/3PDuuG/qHi/ZO07KPKVoazmm/lT5s1dfjdj/xes125jsbpkSuvn3U136LeGnrsw1peYDpcTZMtH1yIC2aojiiUcc48CtkIBvn/ZVP/d+GC2NUwvG6UqhcFEWGT8x11qlusKqXUvYJOEPUXXnvKDlBM6Dv1M69yLDJbsgGZH3kOtwZIMBg46xahKa6VGUM4gRb6DFcjpVwACVgxTxQ/OTQwK9Wr9hp4egqYEkT5ifOD8GNyM4Z/5onBoVy41XAK/VNMNoS1N955iCoJAl2APhRpXiLa0oIw8owmxjlwzmxrKB49TmAqzee/Q/fXM0u7tYLnt0w1l7wYqkoSNTUlCHhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(66574015)(83380400001)(36756003)(186003)(31686004)(2616005)(5660300002)(66476007)(66556008)(44832011)(15650500001)(478600001)(8676002)(316002)(41300700001)(4326008)(66946007)(8936002)(38100700002)(2906002)(86362001)(110136005)(31696002)(6666004)(6486002)(6512007)(26005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NjeTZqVDZ6QU1EM1p5Y0hXa1U2bjRYbEc1ckZlbzA5VitadDJDTXpxWlBj?=
 =?utf-8?B?b0xRME9sR0tUSDV3S3VwZGFpem1CblBhQkpEaFpuV1J0NnNLb0FEUElwamh3?=
 =?utf-8?B?R3RIcUZKcllQRnNhOTBUa2dYeElySFd6U3VZTExoaUdkTUx3c0QrWVhPczhF?=
 =?utf-8?B?cEFUa3ZwUEZqemNUVTRJZkhLeHozOEtUc0ZDTzV5dVVPMitVbUlzb3gwRnl2?=
 =?utf-8?B?a3kvSTVxMjdYWW5UQ3VHOG40Qk9LMUdxNEFTSldzMHF4ZEtrT1ozbnMzOVo4?=
 =?utf-8?B?aDhidFR5RzZ0MmY2Qys0VDlubnhxOC9NMTNrYWQxNlduNE1odzhGRDlXYjV0?=
 =?utf-8?B?eDR3QTZYNUlRb0hiNDRaN2NjZFRqbElmYWtnMHA5NVZQTkxqVXlveFR3NE5N?=
 =?utf-8?B?VU9YV1FTU1FzZG9DTHZsVUEvRHJpVDRtdFIyRHVaaHlqaTR6akZBT2VLcXd4?=
 =?utf-8?B?QUNMdlJsK1pueXFSb0F5SHU0UUEvZDBPZDhJTFFwWTJUeVVteWpISW10elVu?=
 =?utf-8?B?dFEvYUttSW5ValNWSzgwY3p6M3FaNndlUU5hQ3lXS1hPNWpZQVprODgxanFk?=
 =?utf-8?B?Y0pqOVg4ZlpjeGpkKzR4Q0U0TFU3T21SQm9HY0IwdnVPa2JIWXNQVUtFTkE2?=
 =?utf-8?B?dFZKbHN3Ulh1cmhvWkdYSDNhRGhOTUFKKzhiQ0VQMTM5TFVvUVVKeHQ4am5o?=
 =?utf-8?B?S2RsTnd6NHdmalJkbDFvTStvNHhSZlRRNm16NngwU3BoTmNxYnpPVzZuQk1I?=
 =?utf-8?B?Q3JCUmNBV3dsa2NHUDV1aEFxbVQveDVwbjZJenI0T1hlcWJvTStsMWM2SUtU?=
 =?utf-8?B?LzRsRGc5THg2OXJROGVoS3lxbmFGUUY3bDd1R29Hd2lRNU85UElybVk3VjRl?=
 =?utf-8?B?dXpkNXROVHp4WlN4c0N3WVlTcGVJaE5tZlZOOWhSa2xWOEp5eHVhOHhXK3dN?=
 =?utf-8?B?NlVYNmw2TkEzZ1d5Vy9JYS9FcUlBVHdTRHlIR28wcHA0SExDN2JmMTFCbnda?=
 =?utf-8?B?OUhvbHFtYWx0dUNjYXlKWFJGbFA4UUpSMTZuQndzMmJhWlpsVURuL1czcEZZ?=
 =?utf-8?B?VGc4ODZkeXhwbEhvbFN6cTd4L1JadEpjamQyZlN0YnhaMC9XUVVyOU9DaHNB?=
 =?utf-8?B?UUlDMHhHcmRVdVB6MnhFSEdCbU0vV2xPeURuWkw4T3N3cHF6Qk9wcVBGbFY3?=
 =?utf-8?B?Q2RlMkp3WG1kcTVZay8zNVNpcFc2TllCRENNYUxOYzBCcDg5UzlYYURjdTBK?=
 =?utf-8?B?RFg1VmxBbm9RdXBBWEVZMTVmaEUzOHJCUmIxUEZSdHFBclNlMmZyL0F4SkJ3?=
 =?utf-8?B?d3pBZmFoYy9KUHpVNUUxdWhCTm5HNzlaamRua1ZpbjlFRXV4ZTFySG5helZG?=
 =?utf-8?B?WGJjMEI1N2FrRzYwRWJFOW5CWmFRZGptZ0xEZkhVd0RPc2lvR0VIZTBlMmNk?=
 =?utf-8?B?ZjM2NUtvR1k5elVDMVJFVVBuVDQzTERkdjh5WXVaNGt2Z3F4MVRVSHU4eEs2?=
 =?utf-8?B?bUtBSWJZWkRTazhvMlZ0MUpab25YS3hmWHBkY0VGVzFpaGhyc0ZlNEQzS0wv?=
 =?utf-8?B?bk9zTjZBdTNVUnlLVUtaTkFUS0ZJUWFNM0Y3ZitzUlR0MzRuaWZ5a2N2UWpM?=
 =?utf-8?B?SFdJVGYwL0VrMjJ3Vm5qUU5RVnFpd2hQQ1U0U042MGlhZ0E2QXd2cjBLS1F1?=
 =?utf-8?B?TDE4WHJ3ZCtCbGlOb3FjcHByR1QxdVVTL29wVTdBK25VYU4walMzY3YzUE10?=
 =?utf-8?B?WWJBb3B6VnQrZmNEWlpsbFB6ckgvWFBEMTZDeTVKYm5GRXVkQUllQmt4RXFj?=
 =?utf-8?B?akVjWHZSeG4zelJCRmJ1Zk0zUUVqOWZURXlxaFFWQ1V1eWJ6UUlNMHB1QnN4?=
 =?utf-8?B?RTd3V2YwTXFSc3F6dzVtQmhGTGNSSW5tU282R1p6TU9Rd0VySHdDTmNUeHdF?=
 =?utf-8?B?MUxvUmJtK2l2OEFDWVNLMitva3dWU1dEaC9EWlRMVzh0MDlLbkJmWUtEV0c0?=
 =?utf-8?B?YnBpalQxNjdBS0FHck5nREcxTzFiY2E5a3lyVnFNT1JxRjgzVHdQYmNTWUhr?=
 =?utf-8?B?cG5pclJRZ3M3OGs3TDFXY2FaQnBROWU1K1NwTGhjcGlXVGlVTmxkZkMxaEpF?=
 =?utf-8?Q?CR1+D42HVfM9//JvnPsBq3ZFG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048148bc-a203-4aee-a689-08db36afcba8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 15:01:26.8310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz4391p4SdWWhRHf/MAg93qQG3IyRgJxLkImX9v+gyTPm7OxFpGoIO3iauMDau/0xxgGkDtY+5lQXo/G/vV9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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
Cc: jay.cornwall@amd.com, laurent.morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-04-06 um 10:36 schrieb Christian König:
> Am 04.04.23 um 23:59 schrieb Mukul Joshi:
>> Update the invalid PTE flag setting to ensure, in addition
>> to transitioning the retry fault to a no-retry fault, it
>> also causes the wavefront to enter the trap handler. With the
>> current setting, it only transitions to a no-retry fault.
>
> Well that was actually the intended result. Why should it enter the 
> trap handler here?

We need the trap handler for reporting the fault to the debugger. The VM 
fault interrupt itself doesn't provide sufficient information to find 
the wave and the program counter that triggered the fault. It also 
doesn't work well when several waves are faulting on the same address.

Regards,
   Felix


>
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index af6f26a97fc5..5df4f7bb241f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2488,7 +2488,7 @@ bool amdgpu_vm_handle_fault(struct 
>> amdgpu_device *adev, u32 pasid,
>>           /* Intentionally setting invalid PTE flag
>>            * combination to force a no-retry-fault
>>            */
>> -        flags = AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT;
>> +        flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM | AMDGPU_PTE_PRT;
>
> As far as I can see this is actually a valid combination and would not 
> have the desired result.
>
> Regards,
> Christian.
>
>>           value = 0;
>>       } else if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_NEVER) {
>>           /* Redirect the access to the dummy page */
>
