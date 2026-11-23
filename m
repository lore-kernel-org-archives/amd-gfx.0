Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF7606A334
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w16znPlp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643E710E7EA;
	Mon, 23 Nov 2026 14:45:34 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D2010E7EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 14:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXwOtvYckwSuuwLWlmTR/6nu97x4HXuQ8Q10Yipc7BzMHq8QHSbKVX4mw1Bp0IaJpnkgwHNl4sMup3gyQ/ZaL+VoRx1ErTYBtDYMpA3jO1xUKDJbfrzqCx7cmUHSY7N6qsJlEaAD3ZVeQCsLGa/nza1WEqOTOXV11diC4DMYqskvX+5xhpE1z37LJ4ni18Ban0WiwZ5G5sC5MHg70AG9xkAwuk2K1v1T1aQsSfV9K3ObYrs9zaDVWCElFQAq6kBr74JiZHOCtuGev6gzUfgocmhAyL/7i6ULumzdJlnm/ZdXAWlA7QcIiAqaZ6EyT86iaNEuvTA2cD584ZWkVezbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfv5TDFVQ601naZYSG3M44fEVMkJ3wPJRz9BYgJO9M0=;
 b=M/xnseTDmadiZWJzjA1ENT4xvi5P07WQcbrU/mOM3/20sDC8Yq9ng2y4IQXirIp1hAxDUav929ww1wgrAnFEUaeDFpa1xVQKvKmzzwr3D6RcPkiuRmz67Co21AAXCroSJLje9c/LT9QgidBjkvChjRHBRLcdcuFO+3IZ03Kcv8snI5CrO0Sm0zpXb9nAVId+522uVGc+i17Ri7odCuFjlrTha+ZaZQYwkKXLCtZyADCASdYP06Tdkmw7ipn7+xo+4Zou3CUyauSW4Ew198uYqtxU6PQZsSZK44J3SwkB2IwGQbToQb6yEJa3kZ4nJMXnM/11B0Gc4ax29gRgD7V+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfv5TDFVQ601naZYSG3M44fEVMkJ3wPJRz9BYgJO9M0=;
 b=w16znPlp50WAlbMn1o+tEUBtVvIwGSGbu6HXwzJchIZOfvIJ4yDYJlw0JcDhLH51kVT+XqBNjxknf2ThbJDJr6wdTOzB7d6s4xFjb552vlp6bVYZ8Nz8GUKqDjayHr/MCg0d3Cdx92dAmFHBu/JXNOp3kdNTC2kdD4TlBDO76CE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 14:45:21 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 14:45:21 +0000
Message-ID: <1a8d7f1f-3478-4855-b101-ea9b99b48f63@amd.com>
Date: Mon, 23 Nov 2026 09:45:17 -0500
User-Agent: Mozilla Thunderbird
From: Benjamin Cheng <benjamin.cheng@amd.com>
Subject: Re: [PATCH v3 4/7] drm/amdgpu/vm: reserve space for last_unlocked in
 handle_fault
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-4-benjamin.cheng@amd.com>
 <90b6d1f2-2ed4-4259-9470-96144c27d5e1@amd.com>
Content-Language: en-US
In-Reply-To: <90b6d1f2-2ed4-4259-9470-96144c27d5e1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::19) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: c93edb9b-2226-4165-ac4f-08df4970667c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261102123227099003|261022105027099003|261028144727099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: cfT2lfq79gTNFpsVtHbceNd+7Cw4Mf0w0/ejdUUvV5Ivr4UlZPV01DNzfX0XT2oTLYSdEoigW1W50Xl7yHS4Fg/pOKUmdciOJxw3/wnWllrDvTpcCXZR+1sdHYPdEpXZZl5gv8K3wrPeY9i0pz/m5BiJLftfKu33q8K56PhjcC6ImykXIJuewFYfakrQSwuUmUfvSTpRk3onNgaVpK9iP7EFP0IiVDrhlpriM4fFfllAXvw9IuKxg9JkmN3APQJSWlHHb2hTUOYbldbkKrdQ2qRXYfdltgl+j6Qy8Hlsx3PIkcdiDvoRJa2TPmNAo9HkbL0qdMxR825tQKDTKh7NVf7mxQUKxbTJ2kv3+4GsVKP70/AkNPNHcpgVsukgM9Ge97dMOKKEaxSB4LsTLFqQG9W8hL19oG//Y+tBTNcKxdg+W8grrjdtIGRgAIadRENk4bcrz5N6hty+RKaZ/ZdnyqFxrduqOmJ40r3EfXhsG+bKrUI0LW/jkuT6J76uuH6eYEOAaz8NQDUGRmFl4ZfOXXuOk+eJ6iLvGMN/OSNiRxNkN7Gbo1YKJf0vMB/C4yKME5PoxplVCqJqeyS7Finfx5y+zvCJ5XJBKhsrArZUdpENS82cO1UPKzafNzG2Tc9/Cbid0vw6431Kt7Vj7ocNAs7JdQ/hVScoVveKWiIEWLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BDZFBMSTJnTTlsbzZ4bkVGMjIzY05zdVJaZGZmNHFvRFFLU1VybE9INXZN?=
 =?utf-8?B?dDlQYUlzMG15ekt0S1g3VVNDZFQ0dUE3Nk8zMWdOZk80NUN0VDhPa1NrZ3Js?=
 =?utf-8?B?eXk4cU9kdUVqcVhuK2YvU013eFBsOW5Dc0EyeXExZjNvcHhlNlI4RGdwYzZE?=
 =?utf-8?B?NjJmWG5PbkYwNlZIQTIvSWlTWFNhYnAvYWdKVUY4bTNUVjhhZVUyaW9ZWmlp?=
 =?utf-8?B?RThlRGFmOXdFWXNGL3Z4R3FRM3paUjFmNXJUZjUyYmhDWFNrRGhaUzUrR1R4?=
 =?utf-8?B?dS9DMzh0VUlFWjh0VHFQSUVpbjhkSFNMUVh0c1pWTXVDYWNCa2MxRHAzSTdD?=
 =?utf-8?B?WVJoenFaek5BT2FmeVNqUXdQMTF3VUFaczhjWlhHdS9XNWhkTlpJZENIblhx?=
 =?utf-8?B?Wk9aTzdtSjg5ZVNJdk1aeVZmR1p5bUZuSzZxYWtNeGVyUGZ2N043cTZ1TnZX?=
 =?utf-8?B?cUsyVW5kemF6SEV1bkNwL0hsUUxGQWZLQW5JdUt6d3J0ZlNZQTNVYi9wSkt0?=
 =?utf-8?B?VVR0NHV3MnNtb0lkang5Ym1zOXRlMWtkUURYM2RWQVNnYTZ0ckN1ZGRlVlZX?=
 =?utf-8?B?UUtoeHZ3MVVnamVwS0MzanU0RWtFRjRUQ3FpRTJjQ0pDbng0dExTa1BTZDNz?=
 =?utf-8?B?bkp4cXVoUEdUUVFhTmgvczdSTzB2N1RwOHVJWmx4S1dhR0Y4SDZGZ0JZNGVr?=
 =?utf-8?B?Rkc4YTRnYXltQTBKMlhEV2VENjRhK3ZCVDg0L2g0VnV1ejNKR1Vib3NFS3RT?=
 =?utf-8?B?Y0U0ZmRtYnFDSWJjV3dxcEw0VlU1dDRLTlRvdjFxM3h1VTQ2ek5BQ0poaXFG?=
 =?utf-8?B?ZUM1bkE2UmtrZWNlT1EzVC9yOXpqVHg5WG1ld2N2SllLVGhINmtCVDBjdUhu?=
 =?utf-8?B?cXBabllzS0Jqb1FaQ2I3cXl2bVp2azhZeFpPY0UwNjA3SmsrSDJKdXEwN0Vr?=
 =?utf-8?B?ejBwQjl1ZGF4eHpZSk90aURuZjNMV0JVeGV4YjM4U3dienU0RHNTY1loeUIz?=
 =?utf-8?B?VkdIRzN6SlFtRER3YjRTWDF3cTY4RkZhQ3BYVlhrTEp5SHBVTnJGeUVMckZU?=
 =?utf-8?B?RUZZSDlVYWpuRXc4SXZCam5wNi9xY2RUNHFhMS8rbFZRN1pZT2JvbjNuLzJR?=
 =?utf-8?B?RCtWL290dXNDTjBvcFN6citKbnJrNWVtd3RzbDQvR0ZxOVRlY1p4WStGNVV3?=
 =?utf-8?B?eVV2dFBrd2ZGRW5kN1BQc2lnUUpOTkQwb3E0UkVZRklNWEtFcENQM3pubmIv?=
 =?utf-8?B?ano5VkZ1cEVjeGVZSm5rR3RLbHUzVGUwc2M1REx3Y1NNd1RuQlFDSm1IczdY?=
 =?utf-8?B?VHozMkhLOEVRakZodllMVDZpVnZhV3NicmZrejI0MDlmVTZYbHhweDdQRkRj?=
 =?utf-8?B?WUVudm1QbXlvejEzSGgyQXZ6bmhXUGxkd052c3hjTFZWSmlvS05WUHNoaFVK?=
 =?utf-8?B?ZHZoemJtUER2d2xLWWJRZXRwc25uZ1laV3NjQW4yclB1MlFZQm0yMjlLaWVF?=
 =?utf-8?B?a3dlOElyRmlMd2JKUFZ5U3pVWFVxcUtUWDYxQjZIMWcyaFRGajluaDdXbE9t?=
 =?utf-8?B?MTBaOUJTdmszWTlFcGF0anFsZ3liOC9hWWREQjJBUTcyWmZxN0Y5OGthWlRr?=
 =?utf-8?B?RHk5b0tXbWVUOHBEVk16aHBtUU94elh5aTdxTEpiNmc1c1FUbWJYbk5MTjl3?=
 =?utf-8?B?Q1VzeC91RFltNzN1eEFZd0V2V1UyVWlrSDh4SUo4QUg1RmM2bkQ2VVVNeTNJ?=
 =?utf-8?B?OG9ST1BGdE9FOSt5aGhKVTdlSnR0VFJHUmVPZ1NLekIrVGROMjgxZ0pTT1Fs?=
 =?utf-8?B?RW5sWnVacDJWM3MxVTRIV2Y0Y3Q3bTRjbEgxV28xMU1MQ2RRdktBQ2pCS1dZ?=
 =?utf-8?B?RytKWmRjeGZQdWRTbExuNnRxa2x5OWJ0Zm9aRlZBc1QydHhycjlKVTRtQXhG?=
 =?utf-8?B?ZjdRNHlLcUk1dTFnSVBlS2lMRm1Kc0R4Ykl4VEJvTXNaVEZwR3JnMnN1cVNB?=
 =?utf-8?B?TjJOb3lWRi8zcU5ZWnZNVnJpNDRYcTE0dlExVDUzL1FsWmdSWCt0SmR1N250?=
 =?utf-8?B?YUJ2cCtMaFQyQXFXTjRzYXVrUWVab2t4SGNkVmpwblhLbHdpU1E5YWRIRW94?=
 =?utf-8?B?T0d3a3N4OFZmOGZCRkNSbkRKTFJCS2Jpb2V0dWxab0FId2dkbFZtM3BVYjA2?=
 =?utf-8?B?dnlIVlhaaHNtNzk1aytWN2RUMEdZWFBZVVZlMzBWdkZaMzZBandpZXE2cUxG?=
 =?utf-8?B?ejI0OVNLQU5lSFZKZ1VLR09uL3ZJUVJwZjZBMW9QOElzRzlka01QMjh0cWpC?=
 =?utf-8?B?OVg3WENXMi9TVlpqbHJ0bE9sdzBZbzNpR2hqbStMZXlsSU45V3Zkdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93edb9b-2226-4165-ac4f-08df4970667c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:45:21.6321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfqEBJShGYKDG2OaKUQJLJh9h1jFBLmy+xg0yIGwOQJmIn/YaEwIzt6ky8lXhTqSsRyh/19MWhuyRD9ob3JQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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


On 2026-11-20 07:03, Christian König wrote:
> On 11/19/26 15:40, Benjamin Cheng wrote:
>> Normally last_unlocked lives on the same entity (vm->delayed) as the
>> SDMA commit so they would use the same slot, but in this case handle_fault
>> calls update_range in immediate mode, making the SDMA commit live in the
>> immediate entity.
>>
>> Since the two fences are not in the same entity, we need to reserve two
>> fence slots here.
>>
>> Fixes: 2b665c3735b3 ("drm/amdgpu: reserve fence slot to update page table")
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>> v3:
>> (Christian)
>> - No TLB fence or TTM_NUM_MOVE_FENCES need to be added here.
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 4d31c41fb684..b1d2779a2aee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -3187,7 +3187,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>  		value = 0;
>>  	}
>>  
>> -	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
>> +	/* update_range operates in immediate mode here meaning the SDMA commit
>> +	 * is on the immediate entity, while the last_unlocked comes from the
>> +	 * delayed entity.
>> + 	 */
> Oh that is a good catch but clearly not the right way of fixing this.
>
> We should not touch the last_unlocked fence in any way possible while doing an immediate update to handle a page fault.
>
> My patch set already drops that handling, so we should be save for now. Please review patch "drm/amdgpu/vm: add amdgpu_vm_pt_leaves() v4" on the mailing list instead.

Hi Christian,

I have not seen v4 of that patch on the mailing list yet. Is it still being worked on or did you forget to send it?

Best,

Ben

> Thanks,
> Christian.
>
>> +	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 2);
>>  	if (r) {
>>  		pr_debug("failed %d to reserve fence slot\n", r);
>>  		goto error_unlock;
