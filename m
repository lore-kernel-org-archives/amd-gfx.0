Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBE60A2604
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Qbi3mxAQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A56010EDAE;
	Mon,  2 Nov 2026 12:43:37 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4574F10EDAE
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 12:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv6RlfO2jniHiZ9/RICAO7DiONPERFee1Ocxi+f+iSrOkWUcS8dXTRSrmi7cwj8N6QoNCYngbowJ+xAs0e+kh6GSMENRNy9TbYvbKd7JuiEpUEEarHd502YsrkPUjClT5bGteN4kUIhHqCgO0dq7sUEBh6Xb9nLZRorQ2WhCKO/XKavBT3p5h15NWZ2Q95fqxXHV9V/3qIJp40jerQIkuhh9FnawPG6yGaw+8+E5nNn4bEsEZb0pRhe5Xv+jiAXc9qP6Yol0hVQl6B0+TvlWpzoG2VKct7Sw0Z8WvcaWqbuVuU1E4ePIw13wND5x2rwfwTtrgSEQWdLkPz/+Ww+Kwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UepFMWcte525n85U4mHaUX6idc1I/4HVG3yd2JzbRas=;
 b=JT2l65EeMAXs2rqAMzd8GwCppEv47rCmxTxdfFHBCfLul6uf/G0AbEDZ7vvUeb6f1xUfSmMHIPyvlkOMLcRcbNsz4oZ5fiqECDsJlgpqZXHKWmtztNitNJr2OPYcMHc+31QdOa7QSchYTYKYzhpqyr4KfzwpNq0d2LFrWf72d68THri925e3enyZ6r/orR6zYzqxxAgp5E7rFT9k3cJoICxbL50AdDQYKLZdoNtSSJ9b3G3kwxSkuRIWyrCI2U7fvARKPftw49ICEfKCvCYdu/xqnzYgsIClUxEVrTIyLqrWw4MYhEVYuRCpODtLTcV+5IfxAubSXvZ6Dq9N06Lblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UepFMWcte525n85U4mHaUX6idc1I/4HVG3yd2JzbRas=;
 b=Qbi3mxAQloN3uxbUKGI7oebnfkf+jMV+7sNCCAhwnvyKy/LYyXK1Q82Ij5vjMUs9gCtN3CqQs4/EyyIgMXqlUroZ4qHJ7yaNQVTFUtJFrpA7QSN6BfRKZuKj8kfWubeipqYCszg6IktsKtWJ9FdFpOCvEMd0U9PaybSJC8mlQmg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:43:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:43:27 +0000
Message-ID: <ebc4edc7-636a-463c-8e22-4501ca98c9a7@amd.com>
Date: Mon, 2 Nov 2026 13:43:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the size in GEM_USERPTR ioctl
To: Natalie Vock <nat@pixelcluster.dev>, Perry Yuan <perry.yuan@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: Yifan1.Zhang@amd.com
References: <20261102082915.2289352-1-perry.yuan@amd.com>
 <e6aa9e92-fd51-4d90-b88e-b346d67eb713@pixelcluster.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e6aa9e92-fd51-4d90-b88e-b346d67eb713@pixelcluster.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 75836200-2d1a-4969-c72f-08df38dee460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|5023799004|4143699003|11063799006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: fVEaDUO0XaqYytnKYBYQgxRlFqZaWvJpLFvboTB7FPTOCVPCuAcRzoS58GNrh9GyhEESmbOQianitsYN3YG92iZdCQcy4CvUkb63sDFTkOoOJDYhVhrheXR9ulECly9OSMk+TeQz3Uyx5+imuSa/zd3cqjSZOL1UJzA3nVmshNVp0VYsP83rLTDrNMDBHjGBb09YQ6xr4Q01pC5LkrEFycrrSX5n2EZd+cAxRG1UfORU1/54+IhBLQ66ln3EuBTWX6PeOz/gYxglOEnU+SkPymmA47kNbQgCMBflv9MQfs0zRZrtqQ9XqE5gyEu5weOVsnJfLNB+0XWHchaSwFQ0W+bWEXNACzqj7Idffpg9k4NWGp6rdsw2TBPb+RiZK7d5F0kFhvHYahBHcLJK9ysEFKtkM+03Ne0kRZb8+ZyhBYVOMeSrM1z7FHLyfgAQVyFteqHx7+yHoDtm4WEP7XJrJrodcIlpBwP5ahqPXe8rJZomKbTZZZiPsDnAjuVgJA1JKhls+MjNk3pAJQqp3OAKVS2l4TPfruPJLI1KUAs8mOssUcR6ZM0lcsjp0/0ANC5kGjLMmkL1pOULSQ18rkLQwt4li1hZQk2Bh25h6fzrhK1tdQdDY5rGyXJMxubsSyhk7F3zQdSRUFnDYPJ2rme110plSSXuDud/un6tu5nSzjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(5023799004)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5oN0IvUEFXTW5LUXVGbjB1bm4xbUhKMGFVQlR1QTJZQ083TGRrZ3hJclBE?=
 =?utf-8?B?TjR2MGl6SG9GamI1L3ZoS2ZNelRLUWE3YVV1a1Zsa3EzclBVWG4za0UwL1d1?=
 =?utf-8?B?OWFqbFJZUml6L2ovdEpzQW1OdlFCUGNTZ2ZnMzhhbXI3Q2tjMHNBaWpxazZm?=
 =?utf-8?B?eVBzVHJTejJlMzNnMUd1UW85SkwxenJGYUx4eFU0a2Y3OFRIczgzWWdObEdv?=
 =?utf-8?B?eU5EL3dSbUNXeWtoMTY0SCs2aVJIM04wczlmYmo2cWxCN3RmNkFxQXpCOVFB?=
 =?utf-8?B?SWtwZXBhTXNRZi9JSHZlRG1PZTRPWk8xTFlmeWRVYWlxM2tvR3c2MGFRa1Bv?=
 =?utf-8?B?R3lMaUpNWVhza1dxNXVGSFJIQU9xSUFiOXB1YmpMWlFlUDVRSVhaNUtlN2hN?=
 =?utf-8?B?L1Fwb2tYbEJHL1JTVVVRaTlkSk9KbVh6V2toWHFCUmxaUnQrSDk4b1pWS0pZ?=
 =?utf-8?B?UWhNSTM0ai9wUWdMUG52eHdGMEhPOC9GUzg4Nmpac2ZFN2JJWitzQlZCaTBv?=
 =?utf-8?B?WFBuUVFwRHVkRzVubzBJV0cxdVFHVTBCY0hERkFySCt2WEU1T3dBUTBTWFRR?=
 =?utf-8?B?MHZJWHFmNGZBMk1pZmJWTDk2QlR6Tmk1UlpiR28xWHBqYndkdG1WN3hUbDdY?=
 =?utf-8?B?M2l0aVlLVExmeGIrbTl0cUxTSmhRYm96bnZ5NWtWbFhJOXhCS1M5L0pMMHdo?=
 =?utf-8?B?ei9yZFY2QVRzWU1KNTZ1MS9nR3FwQnU4dk56WHhRTmtEQy9sRzhFbTBocUVr?=
 =?utf-8?B?SUV3TVhLakJMbmt4cnJlcnVIMjFKNndSdHF4V0tKTVFGdWdjY1dSR0JNT2lP?=
 =?utf-8?B?MUFhSHkyOGVsbUQycDdDbzh4MjB3WUxXL0tqem5YZUMrRTdhRnh2M3FYdkNk?=
 =?utf-8?B?WlF1NGt6azE0Zkk3UW1FSXVnTnNFc3Vjc1ozUkFRektRN1l3VWg0ZlhJcnZ6?=
 =?utf-8?B?dTM1dTBMVlhUOVFKNm9EQW5yYmRVMkxyang1aEJRWVI3bU5TZHFLTnMvbmVj?=
 =?utf-8?B?ZUQrR1lHazQzc2V3bnBJekUrakk3V2N1WFFBdWxCa2UxcHNabmk5T1pBOG5M?=
 =?utf-8?B?NzB6V0dHUFRuRzlSVnpnN1g2a29vYWF2ZkRhQnZHcWl5eXpYNVZrWklCUlhG?=
 =?utf-8?B?clVnSnFGUW5vSzUvbTBmcXpNU21RamJEYlJIbEF3MmhPUXBqUjBXZHluNkh6?=
 =?utf-8?B?b1M2d2FPNWpYNXBDM1Y2TXBTUXc4VTNnZTZkZUszY0h5cFN5TWxOM1d6bExv?=
 =?utf-8?B?NUc2aW1Yd09HdER0anoxWldiWHJQTUd3TkhnR2hVREwwdE9sdkszOWNyL0Vu?=
 =?utf-8?B?THdwb1RKeWxOVWx6OU4yd09XVUhyY1g2NlhMc3Q0cXZTaDRVcktReFhjQkJL?=
 =?utf-8?B?T1RYMXBxcm8rQ05RSzVJMnlMRlgyQmVEc1lzQUJWcHR5Z0w2ZWwwTi91aVBs?=
 =?utf-8?B?ZkxIV0lFK3RHTm82NTlWRG9hbEQvY1pLQVMvZHdMUkYvS0NMeWVyNlN0VFpX?=
 =?utf-8?B?TWs1N0ZLTURvdkJWcHp6Uld2SEM0RS9PNEVCZThUbDZsU0ZITHFRNUtuT01C?=
 =?utf-8?B?MkNTVmtJam5KWnpCVVE3am8rWTkwMVBnOVRCRFBxV1hXc2xGd3pDN3B1eUVj?=
 =?utf-8?B?MElrMnA1cDZ2M0pPS1ZTVm5VM2pCamtORjU5WFQ2TEpnY2taeFlBMTBrSVJY?=
 =?utf-8?B?dkk3ZFEvei9aVFVKT1BuMGFzd0RqSmMyZUdFbHA0cE80Mzd3TUdKNmZ1bXBp?=
 =?utf-8?B?SU1Tc3N2cnVHZ1krM080ZFJVVTIvYjIreVhCZGF5TjB6eC82S2VLNVk5R2l1?=
 =?utf-8?B?SmF0WVMrenJ6ckIyait4MDVreFM4N24rWkRNeHdQNXFmK1IyZ3NOWTZIcGNT?=
 =?utf-8?B?RTlKdGVUbzNwbHZEUDAyb21hUzFZS2k1dDFJUkNBV1Z3THJRall2Z3FHK0dm?=
 =?utf-8?B?R1pXSm1DalRlR3JBNUxiWHJzam9OYkUyZEFScDJzTEMwWlduZFBsK3A3eDhG?=
 =?utf-8?B?RWtsSkNEQ0YxeGZJRzVHeUpqWGJQY1Y2YXpvTmRFWkdwRXVFUm1aWkIweFhO?=
 =?utf-8?B?TWxGYWNMTmxkTUZ0c2pZWDJ0RjFaVEZUUCsyV2RQQXZlTXpGaWdtblhEUmNP?=
 =?utf-8?B?R3B2aVJ0M0lXRE9lZ0l2Z0JJZkVWWm5FMXQvcDB0Yml0OVJUeFpOK0ptZnRO?=
 =?utf-8?B?ZkxmbXNlbWkyTklLOVE5dVBLWFYyUnBDN0RvaG12ank2bzByUUtMRmlKQ3ZL?=
 =?utf-8?B?QytlNE9wZWNtSGM0cWJZMVJ4dERSMjExNkF0bVg4QTBCR0JPYVBSZEtUQUI2?=
 =?utf-8?Q?OK7QJ60FH3JKDZ9SyB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75836200-2d1a-4969-c72f-08df38dee460
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:43:27.7387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzdrlfTSLgjbjc0BWi2sgmmiz9m4jtVYgy2q/mHjoVmyPp84zj3M8udrH1Vcb4s1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

Hi,

On 11/2/26 12:39, Natalie Vock wrote:
> Hi,
> 
> On 11/2/26 09:29, Perry Yuan wrote:
>> Nothing limits args->size in amdgpu_gem_userptr_ioctl(), only the
>> alignment and access_ok() are checked. Acquiring the DMA addresses for a
>> huge range and cleaning everything up again whenever it changes is
>> expensive enough that a sufficiently large userptr can keep the machine
>> busy more or less indefinitely.
>>
>> On top of that the interface is increasingly used as a replacement for
>> real driver or udmabuf backed allocations, which it was never meant for.
>>
>> Reject a zero size and anything above 1GiB. That is far more than a
>> temporary upload buffer needs and stops the ioctl from being abused as a
>> general purpose memory allocator.
> 
> FWIW, Proton games may attempt to use userptr backing for some game allocations,
> and I don't think we can assume that games won't try allocating userptr ranges >1GiB,
> nor that games will gracefully handle userptr allocation failing, so hard-capping
> the size might break some userspace programs.

Oh that's an interesting information. I wasn't expecting games to do something like that.

> Not sure if bad ioctl usage should really be worked around by outright rejecting
> certain inputs.

The problem is that we can work around the limitations we have but userptrs will always be slower and more fragile than native allocations or proper DMA-buf imports (udmabuf).

Having no limitation on the usage created the impression on the customer side that they should be equal and that is clearly not the case.

I mean we can release pages as batch (which BTW is only used on really old kernels in the DKMS module), but that really doesn't solve the underlying issue.

Regards,
Christian.

> 
> Best,
> Natalie
> 
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index c982d102614e..348693023563 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -566,6 +566,10 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>  	if (!access_ok((void __user *)(uintptr_t)args->addr, args->size))
>>  		return -EFAULT;
>>  
>> +	/* Userptrs are for temporary uploads, not a general memory allocator */
>> +	if (args->size == 0 || args->size > SZ_1G)
>> +		return -EINVAL;
>> +
>>  	/* reject unknown flag values */
>>  	if (args->flags & ~(AMDGPU_GEM_USERPTR_READONLY |
>>  	    AMDGPU_GEM_USERPTR_ANONONLY | AMDGPU_GEM_USERPTR_VALIDATE |
> 

