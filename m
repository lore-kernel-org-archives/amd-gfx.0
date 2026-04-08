Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04473FD5F99
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 08:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9443D10E58A;
	Wed,  8 Apr 2026 08:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pqb1HNlG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 494FE10E58A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 08:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyWjfQ5PM5+pj1M+o+9Rp+yO5Uq8XOumIC/m0ohobj1zWaOUre79u9PpzbPM+W8HM/nM1OWSulz1r4RZSbHMB9AuVJNPQ4pnhol6mKLbOjbZKrlaUpFFsaLqbP0vq9L/ALU8+dZ2ZxACS8h2qHkqkXsEdFlAMfp7iTfNdnGjk/4CT8a73dKSVfIG7Zn5Zv64q2ETe2o7oinr4w1h4ccX2wxmzM6T2LWuQe65VLV3S7ECraPKiISe7ENEqlQfHt4wtF94Ie5dhvL7hguFURgTuhaUiUJTqUFZ7hjEm0b9VU9KVpzGUDCO8KjPRZIZgOpVLKYiFtng5tK8RhOz1Ru/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo4/0g3+KVJVQEH9CcNyIVU5eRgxu1Z5eGGzc2MSfwM=;
 b=b0KWujL7O2J2yKrg85+T0zvdvHriok0wTeD8jwADoj5COlhzh1/v4+OPDY0jT7FWQmSZU1S3gQdf2u6Na5PzZE5U/WLcUB/z2d2CVtfjFVPHcdJ15EsCOk7+tsxZEtg3xGnZoESz/pIEoSqe4NRvCokItqns64H7s2yk4ffhs15w5ZNn6y8xAdzaWAnt5osXgjqgoZISD6vD69dFWan4inbOI1cVMtMqnojrxk2OWq3lMk7MWbQP4Q3gvgbrNMxq52ybdIXtVIzfCzR1RBXAqiFZSZwaQaNtMbuCJunx+UZMB91kekh03sD3sskfwdVdJQIYmPdiXdgXwqcBKuGERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo4/0g3+KVJVQEH9CcNyIVU5eRgxu1Z5eGGzc2MSfwM=;
 b=pqb1HNlGlhcudLLKOtF7//ncmgXiYjjlTqxmemCJm7gz27UP8PzJqm+S74IwETx0/ZPHHKhZfqzJVGkMRwNxdIvNmzbdkPQ1WxbXdmsfcwLNw4iqPtNVWOIAel5VG7wU0u5W0fo4OhPcPiVHVZp3Qk8ifkHKb7fIwB8BHa/oPwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::990) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 8 Apr
 2026 08:36:46 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9769.015; Wed, 8 Apr 2026
 08:36:46 +0000
Content-Type: multipart/alternative;
 boundary="------------zxZJM0iv0rnFTGzcjAsBGrOb"
Message-ID: <560b9f8d-aa19-4122-9b3d-2319e7ece628@amd.com>
Date: Wed, 8 Apr 2026 14:06:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/2] drm/amdgpu/userq: avoid uneccessary locking in
 amdgpu_userq_create
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260408053603.2894742-1-sunil.khatri@amd.com>
 <6e31b77d-a465-46d8-a299-1dd10c88334c@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <6e31b77d-a465-46d8-a299-1dd10c88334c@amd.com>
X-ClientProxiedBy: PN2P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4cad28-163a-4216-d156-08de9549f7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: DSbM+hSB0ddb3QY3a7Wbmb+np9utyRO+5Va5g4rmS3lMczbySwoVI7aSP47QTSfdALTtDslfSH74XWyhzXLeWKunNgR4dYmK8rMj0OLFdYzJpHRM4a0cGN41bcNQdWlDibJ2NHbnST+J4SJoo0bKex+lIMYLR/QEDvwijdnNX4dGdgS7Vl3IbZZjJMV8Q5SFjLVlm/Ze71l2K3BbXU9zY2v5pYb/N0raTKlUiUVBeHUubmd024aorLaNrEcv09HpdRSkCR77xCYPMmBejSwQmAdl/3W9OmpeKAXXAg9ND9FMIizArLQVorDMWCzvGeBfCziHFHgXERfmCaa1750FpY3CEFkYdW60U49XCfvsDLJpDi5PXtB972+mwYDKT1bCfyZT9jeoUY2CweL0J8ykoC+sbwu6PmA6XvEUJtqY11Q+6vy+GMn2v4vb8IrL8/KADZOVPIqgcrexfhgfKTSG9fYrQ+Bw78xzu50RraufDb56JW1h5UMJ7TqTwfd0OMhTlzY7V0P789jmDGtbYyiNRTNEFIhzDfam4eU+66u4ceiNXq5nBk+LN/G1M6n4VGAHrLCpl5hzG8uQNhyCjQe3AUuvsz7/XUYAa7x6oTe4EA/eOwzSNUA9mgIl4fc85Aqxa+aydogpetilC9MRijZzyVQ43ur3XTcU9W42VxPTQpr/5HACeBV3cjaDABUoPI5XvUbqdcNbB0Gl2iS8+/0EkgXYG3YoiIwNxDpSjr5W35I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzI1a1hEc0NveWQzUlVTY2ZINlZUY1pidG5EZGtMMllpUlp6dnh6VVpjOVFo?=
 =?utf-8?B?STBIV3dWR0d6WG41SjBwWkxjRUNTU3dkbWhBMWplNzFkNWlkQWhZUFJoTnJi?=
 =?utf-8?B?dVg1YjNsbmRXU3ovc1lnOTBubVZrUWVXc2wvc1NDd25ELzRyNENmY2V2TUZC?=
 =?utf-8?B?eU82K2Y5eWd0UkcxUytvRldPMmhiV0oyemdsOHdEVHgwQUd6L0JOeWRta0p3?=
 =?utf-8?B?N0xqaEpJNWlUVDI2V0NNY2RLUytnb0dRY0l4aGRKejB2UXZmcDZ5dXBJYWNS?=
 =?utf-8?B?U21nTkNTVGxkRUViMnkrSWk2OUZYb2QvdEJLUlp3Tkt3cXkxcEI3VU5GeWZD?=
 =?utf-8?B?YlYranoxSEZYdVJpWTZkR0l2OUxiNy94akd0aTBKbFBPeDhBbHN0WllCUzYw?=
 =?utf-8?B?SG1HWFgyS3BiUUtUaHVjeitZOGFSRFFPdzFDQkxRSFkrNXUvM2VrWUE5c1do?=
 =?utf-8?B?TSswdVFUQTcrYVpWK1pEMVBEOUJFYXQvcUVQaS94MXdCa2JTN1J3aGhwRDBO?=
 =?utf-8?B?SzlycUsvMDZRLzJ6WVBabm4yYkVPMm5PQTZ3MXZMRFA4ZVczTldGL0NjblVZ?=
 =?utf-8?B?cEEyN2wyREtxb0VaRHJOSFdud1cvZXBuUkx6VnZZS3g3N3ZZUWZMci9LZG5G?=
 =?utf-8?B?K3ZzUVlxNlB5WWp1ZGZQWnBCMnZla3N6ZUVSdWU5cnVYd0hScFRXNDY4QzJN?=
 =?utf-8?B?QklIUzVpSXhPYmx5SmdFdlF4NHNOTTZUZGJ4MnBsVU1EbU02SHUyZUlOdGdC?=
 =?utf-8?B?S2gxY0JraFpWbmJrdmFJL2pMN1JiZFI2eWt4dncxQ2RjMXMvcm9nMXJiYXdx?=
 =?utf-8?B?c2xleXFYWjd4ZzhtRjVVMU5rUHhnci9jR2Z6T2wwd0drelZPb2JFRklnVnpU?=
 =?utf-8?B?UVE4d204OGhtRjkvaVp2Rk9aN2poRjZ0ZmhDbFh0bDR1dE5Yc3V0ZHE2d0lT?=
 =?utf-8?B?SUFzY29qR1AyaUxVZ1hsQjBpcjkrYUN0U0t2czJUOUNQMWwwS3NTWmtJRDJo?=
 =?utf-8?B?d1ErVmZ5YlI3ZTVVTENjbzRWajQ2emhTRFlEM1M0UE1rT0FCWnVSSXg3eUJv?=
 =?utf-8?B?aWJLYW5mbjBvSmZIblQ3cm9kY3NIVUZ4TVpCaSt4N0Q3QXE1dGlJeHU2UDJ1?=
 =?utf-8?B?RWw3eC9ndkE4S294dXRSanU2eTVHaSsyNU1NUWMwMEd5KzBvTUFZRGllRXNa?=
 =?utf-8?B?d1pnaUdpNC9nL1VtQ3N4bE9aOTU5eGx6WnhNUEZVRUhUTmlNaUxFSlVCcXpW?=
 =?utf-8?B?NWdnclRYbENqSXpiUzRUbHgrN3o1ZW5WYm9XbFEzN0h2Z3lIb2lIOXJnQ0NN?=
 =?utf-8?B?WWdvWnd2dER3TFRNTURHSjByZ2tYSUE3NnduUy9ES1ltajlvV3V4TVdQbnFz?=
 =?utf-8?B?TUlGYXVwaEhoK04rcUQ2MTB3VUpvdGNVRGlDMlRFYWNxMmxYWHVCMWIvN0o0?=
 =?utf-8?B?MUFNRTZwaUYwVm8vZDZ3VzVZWHM1QjNLL0ljZVRiaGR2cjdvdDNIajljNkY3?=
 =?utf-8?B?RGtqZ3pCYXhrNUx2Y1VmOG9xaWRTamxGcWhBUUVyc0xYckFLZmJyVFZmaGRO?=
 =?utf-8?B?WThhd2cwbUlGSkdaUHhMZHFqb3BaZ2VST0ZmMWh1Z3hLb2NhTndLWVpqRE90?=
 =?utf-8?B?R2w4V20vQThuL0tCMjFEN0c1L1pYR2k5dEZlMytRT1ZBUUwyRTB1RjMyK1ZU?=
 =?utf-8?B?ZG9kQnpoMTBjZ2ZXekR3YXFLUFc0VlZvKzFZZUNIR2RGSFM0Ry84eE1RMlRK?=
 =?utf-8?B?UVNEMzYzdXdwb1hSMUdDM3R2QlRSWlRJbW5qL1VlNDBpZ08xaVNmMzFaYUlI?=
 =?utf-8?B?WEg0bVJWTUVNekMvYy9oamZQdU1lUmpJR2VOWE1KdnN5cUljM29QVm5NUkl1?=
 =?utf-8?B?emxiWUpxSlNkbXVBaHJsajRqSDhUZjFjREw2Q3NNY005bkdGUDFkTmhxTFdo?=
 =?utf-8?B?U2pOQmphQXJXaFNWVW5mWkFCVXUrSm5neGdqL3pweDYxU0JxK2FXT3N3UGlL?=
 =?utf-8?B?Tno0R0FZQ3dTYzMyWmkyM1pVaFBRanVweTRVYmV1enNoOUt3SWhMTTVGOFZx?=
 =?utf-8?B?aHRGL0Q0QmxqNXFsaE5VRzA4bGtOUFowaVlOdmRnMktVZEw4bGpNTnd1WlJP?=
 =?utf-8?B?aTB4YU1lN0xYeDZsbER0ZHZlRUluQlQwbzdmNG1oOHpoWFdWT0QvcENvdmE2?=
 =?utf-8?B?NE1xcTJtaG8vdi90UnpBcWsrVk9FZzBxN0hGcFNEc3lCdGpSWnNQbzh1WU5J?=
 =?utf-8?B?Z1VWKytnbzdOUjJPMmJVUkZpbG1PeWpTd2NvVitldkxCQ3RiaVpCRUQrZlU0?=
 =?utf-8?B?N2xXUXRRVE9LRGJXRk80N0pwc0huUmpPMlBoNHRvN3gwcDFTWSt1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4cad28-163a-4216-d156-08de9549f7f0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:36:46.0068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL5UoVopsh0KnSBoNwVY8lc6NJRO2rDXpqTLIUKvuFGJbgQESBFsXFaocaFmsRAGS7yGqiAk+l6zh7saC6vn9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
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

--------------zxZJM0iv0rnFTGzcjAsBGrOb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 08-04-2026 01:53 pm, Christian König wrote:
> On 4/8/26 07:36, Sunil Khatri wrote:
>> Reorganise code to avoid holding mutex userq_mutex while
>> also trying to grab exec lock ww_mutex where its not needed
>> for function amdgpu_userq_input_va_validate
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++------------
>>   1 file changed, 15 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 3a6e7a569c78..3f502c18879a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -737,28 +737,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		return r;
>>   	}
>>   
>> -	/*
>> -	 * There could be a situation that we are creating a new queue while
>> -	 * the other queues under this UQ_mgr are suspended. So if there is any
>> -	 * resume work pending, wait for it to get done.
>> -	 *
>> -	 * This will also make sure we have a valid eviction fence ready to be used.
>> -	 */
>> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>> -
>>   	uq_funcs = adev->userq_funcs[args->in.ip_type];
>>   	if (!uq_funcs) {
>>   		drm_file_err(uq_mgr->file, "Usermode queue is not supported for this IP (%u)\n",
>>   			     args->in.ip_type);
>> -		r = -EINVAL;
>> -		goto unlock;
>> +		return -EINVAL;
>>   	}
>>   
>>   	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>>   	if (!queue) {
>>   		drm_file_err(uq_mgr->file, "Failed to allocate memory for queue\n");
>> -		r = -ENOMEM;
>> -		goto unlock;
>> +		return -ENOMEM;
>>   	}
>>   
>>   	INIT_LIST_HEAD(&queue->userq_va_list);
>> @@ -781,12 +770,21 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   		goto free_queue;
>>   	}
>>   
>> +	/*
>> +	 * There could be a situation that we are creating a new queue while
>> +	 * the other queues under this UQ_mgr are suspended. So if there is any
>> +	 * resume work pending, wait for it to get done.
>> +	 *
>> +	 * This will also make sure we have a valid eviction fence ready to be used.
>> +	 */
>> +	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> Even that position is not correct. After grabbing the userq_mutex we can't allocate memory any more.
>
>> +
>>   	/* Convert relative doorbell offset into absolute doorbell index */
>>   	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>>   	if (index == (uint64_t)-EINVAL) {
>>   		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>>   		r = -EINVAL;
>> -		goto free_queue;
>> +		goto unlock;
>>   	}
>>   
>>   	queue->doorbell_index = index;
>> @@ -794,7 +792,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
> So doing that here is also forbidden.
If i am not wrong we could move this whole code including 
amdgpu_userq_fence_driver_alloc and above out of mutex. Does that sounds 
correct ? Regards Sunil khatri
>
> Regards,
> Christian.
>
>>   	if (r) {
>>   		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
>> -		goto free_queue;
>> +		goto unlock;
>>   	}
>>   
>>   	r = uq_funcs->mqd_create(queue, &args->in);
>> @@ -858,11 +856,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	up_read(&adev->reset_domain->sem);
>>   clean_fence_driver:
>>   	amdgpu_userq_fence_driver_free(queue);
>> -free_queue:
>> -	kfree(queue);
>>   unlock:
>>   	mutex_unlock(&uq_mgr->userq_mutex);
>> -
>> +free_queue:
>> +	kfree(queue);
>>   	return r;
>>   }
>>   
--------------zxZJM0iv0rnFTGzcjAsBGrOb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08-04-2026 01:53 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6e31b77d-a465-46d8-a299-1dd10c88334c@amd.com">
      <pre wrap="" class="moz-quote-pre">On 4/8/26 07:36, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Reorganise code to avoid holding mutex userq_mutex while
also trying to grab exec lock ww_mutex where its not needed
for function amdgpu_userq_input_va_validate

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3a6e7a569c78..3f502c18879a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -737,28 +737,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return r;
 	}
 
-	/*
-	 * There could be a situation that we are creating a new queue while
-	 * the other queues under this UQ_mgr are suspended. So if there is any
-	 * resume work pending, wait for it to get done.
-	 *
-	 * This will also make sure we have a valid eviction fence ready to be used.
-	 */
-	amdgpu_userq_ensure_ev_fence(&amp;fpriv-&gt;userq_mgr, &amp;fpriv-&gt;evf_mgr);
-
 	uq_funcs = adev-&gt;userq_funcs[args-&gt;in.ip_type];
 	if (!uq_funcs) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Usermode queue is not supported for this IP (%u)\n&quot;,
 			     args-&gt;in.ip_type);
-		r = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
 
 	queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
 	if (!queue) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to allocate memory for queue\n&quot;);
-		r = -ENOMEM;
-		goto unlock;
+		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&amp;queue-&gt;userq_va_list);
@@ -781,12 +770,21 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto free_queue;
 	}
 
+	/*
+	 * There could be a situation that we are creating a new queue while
+	 * the other queues under this UQ_mgr are suspended. So if there is any
+	 * resume work pending, wait for it to get done.
+	 *
+	 * This will also make sure we have a valid eviction fence ready to be used.
+	 */
+	amdgpu_userq_ensure_ev_fence(&amp;fpriv-&gt;userq_mgr, &amp;fpriv-&gt;evf_mgr);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Even that position is not correct. After grabbing the userq_mutex we can't allocate memory any more.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &amp;db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to get doorbell for queue\n&quot;);
 		r = -EINVAL;
-		goto free_queue;
+		goto unlock;
 	}
 
 	queue-&gt;doorbell_index = index;
@@ -794,7 +792,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, &amp;queue-&gt;fence_drv);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
So doing that here is also forbidden.</pre>
    </blockquote>
    If i am not wrong we could move this whole code including&nbsp;<span style="white-space: pre-wrap">amdgpu_userq_fence_driver_alloc and above out of mutex. Does that sounds correct ? 

Regards
Sunil khatri</span>
    <blockquote type="cite" cite="mid:6e31b77d-a465-46d8-a299-1dd10c88334c@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	if (r) {
 		drm_file_err(uq_mgr-&gt;file, &quot;Failed to alloc fence driver\n&quot;);
-		goto free_queue;
+		goto unlock;
 	}
 
 	r = uq_funcs-&gt;mqd_create(queue, &amp;args-&gt;in);
@@ -858,11 +856,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	up_read(&amp;adev-&gt;reset_domain-&gt;sem);
 clean_fence_driver:
 	amdgpu_userq_fence_driver_free(queue);
-free_queue:
-	kfree(queue);
 unlock:
 	mutex_unlock(&amp;uq_mgr-&gt;userq_mutex);
-
+free_queue:
+	kfree(queue);
 	return r;
 }
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------zxZJM0iv0rnFTGzcjAsBGrOb--
