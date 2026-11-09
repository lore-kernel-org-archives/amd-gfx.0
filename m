Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F1A606A31C
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oU5/abyW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE3710F196;
	Mon,  9 Nov 2026 11:16:30 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B1710F196
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 11:16:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuPdRfmdvVHqI6SMkhSOYkcJvxxPskc2L5yOmyOPoDvis9eG7RKAzj2sUrVOCizZwpoIS/NzLa05N5sR+ueN1k3ZIuCAwbKuopRAyLaW2gZSDg2RJ51lPwK5ZYPhXJTLvLi1gXwWTP+iIxsp6NgrMcfnBqk8nUUw4OPmuXWn9+/H8UjzyNO0UhKrusxJ+BviUcLRL9vFHTmItBMhu1FmT2OS02cwSAp5TDeYRZUwHdDcYO4cuzHdUmuuPrjBcXoFw68P2vwy1irKVng8l0KFCdfTxWI1QMPgwV+gblH8WInPCLc9Ys8rAFjgAXxZ4FmIuYrAZQtCpLkaPdGuokChpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40Ib/LWTmMgokGeeSIKrOozMlYaDWTdED3+kyyK/FCc=;
 b=y7fwpqUOJz7+0mhEeFo59jCbK6vX4Zc3LC4f0EcIECteDiflxE7B+QGr0vyro6cnmfRCGOZ6BW24lljAMc1S9N87m4q2EN4J98qGbgxz6dLsy+Br6rHB6cWi5N5vMmFGQ3pB+Cjxg+iWqXU20E/iemLdMm5qDt8gS0w4BOGhp+jeaLtOYy4YJxYHZup2HXGWPnmk5ijmJxgyozNLZj3wYmCvQMFiAI38qb+9VEb3xvcRAn1wdp2qhk52wwvQEj5FAl36w9/BX48B1T4V2dsshBE+7xYbys6o+SFbGbSypCBdN100DPne4PbaOkQp//TUH/gy/MfBul+bfre5ey2EGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Ib/LWTmMgokGeeSIKrOozMlYaDWTdED3+kyyK/FCc=;
 b=oU5/abyWw9DwSNwc3QyWahuF5z51RXvw5J+6ivIcNm+22opCJX0iNrwltnF2lgGQwXPfaqXF8T4leELYf82DiJ6zXRzyrMGg+TuI72T8UUVULUiIUIP9ojeJi1+132g09uuA7ngomq2HW2tje6hU3qfaj8azO2I7mNfgq0z/1eY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:16:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:16:22 +0000
Message-ID: <e236932f-3d43-45ee-8484-3b1998167003@amd.com>
Date: Mon, 9 Nov 2026 12:16:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
 <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
 <60d3ba67-880d-47a9-b71e-8c96d3085991@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <60d3ba67-880d-47a9-b71e-8c96d3085991@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 4adf3a09-f19d-4ef1-2d68-08df3e52e290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|4143699003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Y8tnqPzMth3fjQbuzh3T4FSNzv5xN/etgi9cAHFbFUgjWhdEEQSoVzbdSZw55Ni0u5Szeh/mcf00TbEdILc0NN7urdde++RcQO+mb2/NIozQ2vuaTo+or05LFgLmaMwPW++gNChkucNc1lEVmH4QJARrnreJsYGGpqN7WRkEcX39JfAOd3dqagQ6zCFGKQXwOCTIavHcM+RJf7zSGczecwdfMAZ+kwfmHyhFv5yzC8jXXdt+J53Rs7PuH7IgeCxE6jwg7isQLeKd/gTHauGcCARheIa45TQvUgxLbV836fxHJZ/GdfMM+9Y2tW75iaaeouBfSWSMe9oDs9YfI26Fx9+0gc2gytaPc3hwhzFHmTLl/81dC1QjKX/Yzoc4pqhrbWsFdek3GnOYvPnbzOfl8IEDacE0Y+mZvDvQVJaICDaBJ8yckWAISS79N+jSY97qjN/oK+sdBvKjCn/GatYvi0g37ref6H5rbyaHscdmEiX7Wn6mTMF11RAmBUDA7OwGr7VzeJvjNcjO6awoYO185zdpos7jcYOO0vaizfwaG/O1+USh7NWZ+0OPds221JtsRZgtGSqku6Lt0iDcgmwN/G99gvQaKypTDteUmtAvfDVW1jN4TockbeZ2s91QnPtuaBeRJjUJcax2ftC+82OJ9lOG0tcN78o2LfF5/8NqN10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxOZnVpdDVFTVJlRERYbWhVYytoWDNKVGJsWk1DU0U0L0RvNGI1VTk4cEpQ?=
 =?utf-8?B?dUZwWjVBTHVzempRcjQzTmw0bnZ0VEdMM3JMbzNEZ2lPOXg0TlYzN254cnV3?=
 =?utf-8?B?UXRBQVZPTzF4Yy9mMm9reUkrSmxNTjlsK2t2VVFTZWFQTDZReGRUWG9ZUFJV?=
 =?utf-8?B?VkNkbE5CS2hYTnZZWFF1a2RYSzhoZG5lOUVBMkpKajUxZS9YVy81eFVyNmZW?=
 =?utf-8?B?TC9IMzFpbDVzN3pyamtyN1U1TXlQNytyWHJEeFZNTXBFeHBjNVRUbXQvd01E?=
 =?utf-8?B?b3gwclN6K0xndk8xSWRtcElKL0RwMldVSldYZVFXdkw2QitsREtYTVVlUDVr?=
 =?utf-8?B?aUpPenZua2FxVHprU3U1QXdkOFVmWEVBNUw4aUVPcDNnejdmQ0FKaWhVQnQ3?=
 =?utf-8?B?TnpFQnB0M1pVSnFBWWRpakJJVWhaeG9nb3pTc1k4NWZvd2lUdEF6RHRXaDRQ?=
 =?utf-8?B?Z0ErZ3Zyd3VrRENReW5PRDFuM0NEYVV0OUN1T0hqZlFWMWpwdG8yVm9YRlhB?=
 =?utf-8?B?UE54NEs5S3ZMNHRUQ01obzNvOVdDditnakFIS1oyZXBHL01LVkJZdUpHQUNT?=
 =?utf-8?B?OWRVY1RIL2tCNEltQVAydllRUncwWDN2TVRINW1QSjc4aWkwSDk4WklGUFlI?=
 =?utf-8?B?RmhwUDVaUlFHU2lrdk1yRGp0SU1ndkZlNk9YMk1YOXIwdEJYbU03MGtEcWI0?=
 =?utf-8?B?NkFpejZPN0pQZzYyRTUyWFphYXNMNWhNbVRxRktGS2h6VmxPTzFqQUx0VXlN?=
 =?utf-8?B?T3VIRnRuWkhXUFBvY3JCYmhyQzI5MGNqWEZ2WGhLTTB6d2lGZUpFRHA3bWZo?=
 =?utf-8?B?VzRBeW1TWVhGVU5iTDZKcjdIeG1GcC9iVllXYlhNWmFOYlY1WXdyZXluWUJK?=
 =?utf-8?B?c1AzTU5weWFKQnBxY0ZBaHpDdHVoOExjM1d2Zkc1Ykgva254MmFVR1dndFM1?=
 =?utf-8?B?QnZHK1RIQ0NvT2xrNHVBa3dCN0RsUTNxQzFlNVRwa1QzRTdiWUd0dDRwZnY3?=
 =?utf-8?B?SHF0RHRhZkg3MDhSUTdBR3h5bmxDcDFLdUZMWUxuTFBEaVQwNmhWalVmWVBM?=
 =?utf-8?B?MU1SUFhBeTRWTmxPOE0vMFp4OVJnZVdhb3VDemtEbGpneXlFYUJueHBJZmta?=
 =?utf-8?B?UnZ0VUlZZ05JSDFXTEd1VmQ1N1prb3NoOFpXSnFEZmJqNDhMa0I1RmdtRUFM?=
 =?utf-8?B?K2pqd1g1TlJJbkZxRU1pSXVVWHpYMm9CenBKdlZWNDgwdHdMd1NhU2owV0tF?=
 =?utf-8?B?dXNNbkxBVC9ycHpZQWUzRVhXNVQ2ckMxVzBXRTNkOFJ2cjdTZXZmaTQ3YnJv?=
 =?utf-8?B?dUNNNFJ0S0Q2YTRBYXFCbE4wTjlVcHNzbGlCeU9UMGxqcTRPVjF3L1N2eU5q?=
 =?utf-8?B?ZnduZXRuSTFFUzAxSTVBR3lmRERJYkZzSnV3a3V4dXBTd1hJTUx4aDMyYkM0?=
 =?utf-8?B?aFZid3h5Z2RQNDhHeWQrei81MDByNXFzQWZESWxJVEVhTGwya3R4RHhJSGwx?=
 =?utf-8?B?cVVjUkJONVVwdkFxZHJoeUMvYXhtVTQ2RTRSQ0NQaU1ibW9yZUlLcFZtWFFN?=
 =?utf-8?B?b2MzZTBkbnFMVG5BallFT0RhTWlycGRzSEQzQ3hULyt1NkRtRXI4VStldytG?=
 =?utf-8?B?dG9MeC9sSUJkRVp3ZmN6YXVPbmdRM0RUWGpWRlpOcEtWV3Baa0dML093Z05I?=
 =?utf-8?B?YVAyaGlaUWN4bjlKN1VnUHF3WG9NSFlIT1ZxKy9ReDE5WlozSmROOUk3S2ZY?=
 =?utf-8?B?MmtrVXBLMXlic2M4Uk44MWszd0xwTUUySzR5ZElpVlhObTJCbFBsU1lFRmhn?=
 =?utf-8?B?YlE0cGVpdGxYaDRDNUM3VVNadDJKTTJqMDlZVC9penhMcG0wT20ybjBHOHJD?=
 =?utf-8?B?NnVXTXVRcE9zMGFVc1F4Z0tmQ28yTzUvWHovM3Mrb0tKMkMzWU8rV3JjQStt?=
 =?utf-8?B?Z0JOcm53VUFFMnlHcmlZRWNUWHQxalAwd3ZqZmpNRmNEekpJRGZSMm0zdCti?=
 =?utf-8?B?QU5MdXVpdVB5d0pvR2pla0ZCVWFGWlEvUXB5enh3TG1HZVNFTEdzUi96dld2?=
 =?utf-8?B?aEJpUENSWmpSQ3UrYnB6OGdjdEdtYU5vTlpZMitqMUJtdUZQazMvSmJPVWEr?=
 =?utf-8?B?YjRta3l4YVdtTGNXQUNOdENSVzhaM1pWZTJIcUN2MytGT0daaFpPWWRZUFg5?=
 =?utf-8?B?YVo3OFZxQ2hDYXB5L1pwT1JkRWc3czRjRG1rdDZvYjZrWVd4V2dKbnlwdjlH?=
 =?utf-8?B?NDg2MDJmSENRNzczOVhiYkx1ZFpPS01GcU9ScU5zd3VzNGlHTFMzMVlSZXBL?=
 =?utf-8?Q?PRlhoahHMbiJYJNfgM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adf3a09-f19d-4ef1-2d68-08df3e52e290
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:16:22.2215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvCU+0KI6wS3qi/HgaUtLeRXDiNFMqEMDucyVlCzAU6ey0+L6tmJ2dCI6XsA5uXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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

On 11/6/26 21:03, Benjamin Cheng wrote:
> 
> On 2026-11-06 03:55, Christian König wrote:
>> On 11/5/26 22:00, Benjamin Cheng wrote:
>>> In the happy path, the job gets freed when the job is submitted.
>>> However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
>>> would leak the job.
>> Yeah that was already brought up upstream as well, but that here is the wrong approach to fixing this.
>>
>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> came up with a few patches on the public mailing list to tackle this as well.
>>
>> Essentially we need to commit PTE updates before we allocate any new PT, background is not only that allocating PTs can fail but also that we need to drop the lock for this and that can make the PTEs we already constructed in the SDMA IB invalid.
> 
> 
> I gave this some more thought. I think these two fixes are still needed.
> 
> If we commit the PTE updates before allocating PTs, the pt_alloc could still fail and we would run into the same leak/use-after-free that we do now.
> 
> I think we need to both commit the PTE updates before allocating and have these two fixes?

Not quite, when the SDMA work is committed before the PT allocation we need to allocate a new SDMA IB after the PT is allocated.

Regards,
Christian.

> 
> Best,
> 
> Ben
> 
>> I wanted to get that fixed for weeks but couldn't find time for it. Can you guys together look into that?
>>
>> Thanks in advance,
>> Christian.
>>
>>> Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
>>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 2ba33212d507..f6cb2b5854dd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  
>>>  		tmp = start + num_entries;
>>>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>>> -		if (r)
>>> +		if (r) {
>>> +			if (params.job)
>>> +				amdgpu_job_free(params.job);
>>>  			goto error_free;
>>> +		}
>>>  
>>>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>>>  		start = tmp;

