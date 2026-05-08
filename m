Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA6ACD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 08:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F08610E2EB;
	Fri,  8 May 2026 08:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fUvyc0So";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77D910E2EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 08:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMNtChPY++vqDyr1+JYrMOufYkjhkLlC2NB6GEif3n9U5yqPkfXAvZzsm371uyfQVlx6cshiIeaiizzDw1wbqL3m8j4iGodStyWkoiGP0KCO57+6sfLoVIP9lAgC11JG5akAy7tMJ/123/kT83g4vqnTxf/NmXOi9QygC1PSFbA0dGReJ27IJJ85rjc2RIUz1uER50+g+O1BhdfWRYxsEhQeWL/7P/2teZyzjCD7mzDX+O0D57vA7q6pm3Yu74jiYa0BvHsybDXdN5S8sy/jka4DvbAqqZDeOmEYsdKZWRzvN6CaO919pePoZVCol+w04wNC/PlQ0oxb/OtKRE8TiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVmRUtiLykis/njc33fEzrY9j4ZLWQRRfPQjN66ZUyE=;
 b=xHo6uILspewYSl7OM99RvjGqU0S/VuiQgV81DC5Ua29RzOeanpqun+7JLlYKmp4VA8JxHYnwsQaBs+Lc9NQ17B7ArTG8w1ZKFy4NIwUCV+DoT0Zl0xiHozk7wgdNRlDkucvAqDcRPUe1TlZuvnhI1uWgOtxJqXxNzSCQX9rkcICs+5BFWDuhQnvU/f8VD6jYDEYz4pMFh26IDBj8KBTsz5M/tBZb5xqSAf4I6HygCmvxP3cVc/mVDaS/WvKIz8rtb39dNgGJctMYDj1f488QIehISZaodu19Kc3GeFGG5T42ki6ssYWaHEogOIhUl+r4/usfy9L9hyPNRHEJUf83Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVmRUtiLykis/njc33fEzrY9j4ZLWQRRfPQjN66ZUyE=;
 b=fUvyc0SoBvZ2V0dujv9sy4zvluFoxHP37Mogng7wUSTewApXPG7bn4Ul2de8SWoE/xsQrFB6vRfnpLbwsfHh5EsToNCCp3i3C80cnIMoKaYUyRQFSH2O/C1A53Hn+VlftHgBVAcWJ4K/l79JrHFRH7m/jhYKEg58AjtLRA5v304=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 08:21:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Fri, 8 May 2026
 08:21:37 +0000
Message-ID: <6b29d9f7-7085-4c06-92fe-39766d9e5a11@amd.com>
Date: Fri, 8 May 2026 10:21:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] drm/amdgpu: restructure VM state machine v2
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-8-christian.koenig@amd.com>
 <DS7PR12MB6005A74AE8382FB0FEDBC08EFB3D2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005A74AE8382FB0FEDBC08EFB3D2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:207:17::46) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 590d26fe-fe63-4789-984c-08deacdad25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: r2vPeANisbQ0T/Z27+Rsil4koUqw90zxK0mAdnw02A/ZHAsRgIAOAoybo3cdD4ZsCYrYlzfr8YWpT7PszGrSuu0SholtMy9WJjWiPjNBwPQC8XITD4Bjm95DH96C6MxpvkmtZuPwfAF961vbot/xh+A8bgTbi/1PP/FMXZrxA/OIEznR8dBqvkSfmEsWd7Up8T7dq5Bk0vkyZ2ENUvMk4hA9LU2ah9mfviI1TU0V6rN9oIJTduBmjcJesI21iBBk0MDlR8CDE2mAyWtajdC7pNS/XUA4lVo57ItzHFbB173N7hVAYt/85/01fp7S+muHorSef7hsGth1MWMEnfnokLnfU/mfRXLR63r/Y3MHFY/hmK84UrwpMc03GiN5n2Bigk4DbpXIS1l/6C5jAtT8WW7ND7L86we4dfT0A6JmRehKSyH6wnt/KVv7LLEtR4WQ2/U7YnG8WTvs5AKwscwM3EvfJHiky8XeqA/iRJL8NyWcCdHigVt0tBa6EtNqs5cEuRlRSq319wMJPLle5yVL2Vhnu/yfhJQ4pareH0CBymAxQl/eruSO8S1aBFESvxJIdZUspiu3xBnjr6Nf85ViaZMFV5BmQugSl5Hib/4Mx4NKOcecGc/6j3LdwQmrIIzCWFYbH3pqMVihZgrRwSX0qokDh8jZvkvQ9uJGSlqkwrmGorY9PGhdbsPC4D5Sxhr5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YThpQlJueHVneEd6QUMvRlBLSDJ5WkNYSy9WUU40N1hzaXVVSmIvaCtkV1pE?=
 =?utf-8?B?Wkl6ZGNnRm04QUdSSlBlZjAxYWZuQnhZS3RGOE1iV0JaR0tXMnVWUzVQNkJ3?=
 =?utf-8?B?Zm9SZ0RwZ3VmdkFyTS9ydEVBWng5eDJkaTd1bStnUmV2VkFmbE9rTTQxZHdn?=
 =?utf-8?B?UFRiaWg4NFZxaVY0SC9ZYTAwZ2ZJQnlMbExGcUdsV3lsVWQvY1dZQVl5eTlO?=
 =?utf-8?B?Zi9ZSGs3VHQ3dzJQcnBtUUpaOGd1Z2hVV0JaMCtreXdNbWFKZkkrZFhkT2Fk?=
 =?utf-8?B?cVVwaEFTYzRiVlN3cHZMQVpaSzJGalVtL2lXL3BVTnlMYk5TRXl2eTJwZUp6?=
 =?utf-8?B?alJRbnJmRjBEaGFxMXoxNy9iZnpOQW9yOVZ0RVE5MUhNRkQrdThyUVhvYW5D?=
 =?utf-8?B?cVFibEZORHpBa1Fhd1FkaHdiSThGdUxhd2dtcUE4NGdiMFp5aDZvSWFRejNp?=
 =?utf-8?B?WjJpZnZ4OFNJWjlRQ0I3U05LcHEycmE0bkgyU29yRm9RY2lrRkFDOFp5Vms0?=
 =?utf-8?B?MU5uSnRlbUx6aEwxNkxSVHpkcDN4ZUpUcy9UQjdqR21JV2hKUVVCN21rNjZw?=
 =?utf-8?B?ZkNZeDMzeDJWa2U5bllJT2d5QWZCUXNLVDY1UnV3aXFSc1FlY1dZTGlwQ0Jx?=
 =?utf-8?B?UXdvZmZ6YkZ2czhGeXd3TnBzbjc3OXhpWFVweXhSc3djUVJXRWZadUgyMmVz?=
 =?utf-8?B?MzJqUkNJM2RHdDY2ajhFa1Z0UFZ0RHppMmlpaFdFdHhmVHBrdnB3eGpMWlI5?=
 =?utf-8?B?NnNhUWNocDloZTRwNDlXVFd3ZEFVSXgxanJ6Z1dPZzZ5UzVuc0dsWEZqSW94?=
 =?utf-8?B?VUx0bDdmRUVkQlk2MzBqdFl2aWdEVXk2Z2Z3dERjSDJrNnpGMmpkdS9qTW9B?=
 =?utf-8?B?dEhVMmVRdzZMVDh5WHlEVm9ORGhCbEFkVlhtUFluZHRQTy9qYUNPQk1ZQ0Rk?=
 =?utf-8?B?bUQ1SWpRcVQ3UlBSVW5NQTZWTmtmWnFwbGhMRWRnc0U0a1FwRzI3bm95eE1C?=
 =?utf-8?B?NlltRXRkRTVJaisvcTV4RmJFQ0JEbi90R3pjSEV3Z1EyNGtaNStOY3BmalB5?=
 =?utf-8?B?Tkxma0dvNHpXVFBaekhyOGxIVDNueUUyblBQQTFZWUw1alF1eUZFd3dxRmUr?=
 =?utf-8?B?TEdVVEpKOExzUUlsTG1WOU5BRHJIVmJkcEVxNGVpcDQ2aElaTHFNUUh4UTd6?=
 =?utf-8?B?OVZwWjd3YUlwd3JSZXVTN3J4VFpJSzNXVUVMSE4xRlA0TGxXakdtdG5WTzNJ?=
 =?utf-8?B?SWVHc0pnMFN4d1c4Z2M1cEVnNDJaM1hYTDB1ZTljN1dORDFPSWFkOUJ6eWp2?=
 =?utf-8?B?UWFNMXY2SzNxYno0ckFOdGRtVHdoYTQrT2FOelkwdWc0RnhJdXR2cW1NcUpR?=
 =?utf-8?B?Mk1BY24vbzZnUXIrdTR6WkFkVHo5MnJVSDN4TkliY0kwaWwwNzRnSkJRbzFa?=
 =?utf-8?B?bWdJRTBxZm1CU21LYUpQMFdoSjJLaDlDeFp0OVh2Qk04ZGpJL3VqTjNDcmpz?=
 =?utf-8?B?c1JxNmFRaUhld2lweGtqdEZjV2dFelp2OU5LNGVONGRtZG1NdVYrb2hEMnlv?=
 =?utf-8?B?czdHVEZZdWNaTFRGUVJEV2kxMmVsUXE4bXJHdFZuNEpNRENwTTQ4WHFKQTRm?=
 =?utf-8?B?VVVKekFDdTFTcWg2NU80ZHRaT2dRalkyemk2eFF2Q3h3b1pGS2txWkY3bHI2?=
 =?utf-8?B?dUFjM25CcHAxdWJ6dWt0Yjg3Tnc4eDhDejU0Vko2a2pXTXpsV0tMY0JZZDdu?=
 =?utf-8?B?aEhTV2lzaWIyZG9PM0VKZXNqVnhTbkZSZEQ1QXl0dHBzeEFNbVY5MDJFejVL?=
 =?utf-8?B?cFBrYXpTNnNWRmNFY2xZS1B0L2ptTVhNcTM4Q1BvSTBxQWc1cUlZUjNSRVQ3?=
 =?utf-8?B?QmFxaXdOTkY5enhtR2lHRkZFZWh2bnRpeXQ3djNvUFo1T1R6eWloTkdiZE8r?=
 =?utf-8?B?N3ZPb0QwYW5tZmdhMUNVU0dMYVFnYllpQllzQmpyemp3aWNPUTlULzZEdjNQ?=
 =?utf-8?B?Tk9lMGlPNFVJb3ZSZzM0c25zTy9VcDV6VUR5NXJmSHF0cEd4bk5FbEQ3U2pG?=
 =?utf-8?B?bDBpbks4ajYrRHdZY3k5eTVsMjBScDFnRnBPTk95RHdINDlXU24wQmkvQnRZ?=
 =?utf-8?B?aU9zdmJZemV2Rzk0SXpyK0taZ2o2OWhlcWRmZFNRRzJna2pLUWhsRVpSS2tK?=
 =?utf-8?B?TGZNOGQxUFpoZ0VqcHREV212RS9hTUZrSkN4Vm52TGZpd3kvcWdlOVd1QTRm?=
 =?utf-8?B?RVoyMFZGOGc3UU9kTEZoejVjeWhkZFBlSndQcG1WcW9jNHo2emc5clV4enR5?=
 =?utf-8?Q?5U9gRXqd8l6AKUxx7V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d26fe-fe63-4789-984c-08deacdad25f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 08:21:36.8498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZsgOgBNQxwK/zi1iMT4jy+N9qycekvOb+r8g71ICmgpPRIK1PVhIMgKrYSWFvWz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

On 5/8/26 04:24, Liang, Prike wrote:
>>       amdgpu_debugfs_userq_init(filp, queue, qid);
>> +     amdgpu_userq_put(queue);
>>       args->out.queue_id = qid;
>>       return 0;
> 
> Should this userq creation get/put and error handler changes be splashed into the patch#7?

Oh, good point! That looks like my branch somehow got messed up during rebase. This is reverting some of the changes from patch #7.

Going to fix that, thanks.

>> @@ -1091,7 +1100,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr
>> *uq_mgr)
>>               if (unlikely(ret))
>>                       goto unlock_all;
>>
>> -             ret = amdgpu_vm_lock_done_list(vm, &exec, 1);
>> +             ret = amdgpu_vm_lock_individual(vm, &exec, 1);
> 
> 
> In the following ttm_bo_validate() may consumer all the reservation fence slots by the reservation internal pipeline eviction fences or move fences, then this will
> result in the userq eviction fences attached failed due to the out of reservation fence slots. How about set the amdgpu_vm_lock_individual() reservation fence
> number as TTM_NUM_MOVE_FENCES  + 1 (validate() move path fence slots  + userq eviction fence)?

Good point as well.

This code was written before Pierre-Erics patch to introduce TTM_NUM_MOVE_FENCES was merged and I've forgotten to adjust it.

Thanks for the comments,
Christian.
