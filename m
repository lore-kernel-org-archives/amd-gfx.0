Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95526C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 13:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2168F10E055;
	Tue, 24 Jun 2025 13:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sfD2vUOe";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF0110E055
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 13:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MA4tdZFy7RCCl5y8PByFgnYWtYN6s2neUW5bdkw5sBf/YY2gRbwoVVFzbCTzqTAfOpASYabNZSFA4U5bWEO+czWYXZ7feNJXHpMHmLl/pNXYTub4tWwmYdb/PsvcG33ABykg7ObH2VrDCZGgHEuUzMSbQJBxK5WWj8vv2v31wfXI23KD5GyV1DQ5JnNINZX7qrgk0YFFosjCJWBc6QPyGu61cLLu3qzi6GXWHlnM0RYPEvD8teyQwblNemLSKhcAGqVM3VhTLHqu9WED0C3DlbYo6fxlc3jr+m8vqRYmRrQb1/hQFhOTTMtCDQAllX3oW3e40gOGF9WKSoSdoudYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4UqcU/FkINktMvy2Lx8NaTTdhK1GpWnkWNgQenv7to=;
 b=ZVGivItMWEc5UkmyJScYENFQqwElhSgEd+SIVOyifbLp2NEswF6McXgBzAb+U771ed1vMN7bzV7kRhEmA1skyaKwrBES6LddCS0h+niHikqPqDL3QVqVv1j9JllQG9D4C9GByknAgQkN88a3hSynH14FCia/aw6LhBP2Tec2R6xb7WBxH1Of1FvSkWAo0cJm6RzFXTuaZc5UMFo4kUreY+ncP0vDYdTu0uiWJZcjpf0x0pMlZtPxJxby3N160XrpFxmc8MV2eDrSPpTD5Xp0Nydz6G3MYnYf3IWrG0RB0FcjlCR4/dOkG63t2fvfvr//9kMA6Q+k3QOLLqIIgkRB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4UqcU/FkINktMvy2Lx8NaTTdhK1GpWnkWNgQenv7to=;
 b=sfD2vUOe6YkddgMzXhCfjrXlap8RRBrEuQJXKgAFquye+v0gjPW1k6/tH3FZui7n8tquTM5+fOu9d+nYN0qjDUpA4QPfg1IWUPhIsJ1CQ45inoROqyp94nnNkYf/SBrnXyrVhzno8FrT/ja4Lp0gQ7ryiK/aWK+Lm2u9iQJ3s7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 24 Jun
 2025 13:11:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:11:48 +0000
Message-ID: <a88d5329-d500-490c-a054-7ed584322e1d@amd.com>
Date: Tue, 24 Jun 2025 15:11:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: put ctx's ref count in
 amdgpu_ctx_mgr_entity_fini()
To: Tvrtko Ursulin <tursulin@ursulin.net>, "Lin.Cao" <lincao12@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: haijun.chang@amd.com
References: <20250624091823.3963949-1-lincao12@amd.com>
 <b7fc658e-2778-48dd-8584-3f33bbcc5ab7@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b7fc658e-2778-48dd-8584-3f33bbcc5ab7@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: d31feeb2-b1e9-4eb1-5310-08ddb320ad1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEJUdklXS09QSlFiNjJxWnRBVm1mc2liNitmcnBzU3VrRXdVN2xDRExxVWp3?=
 =?utf-8?B?REJLdktpY3grNllpS2JaeHpKVjN2d01WbTliWlR6ak5tLzd2T1VxNXE4M3Rv?=
 =?utf-8?B?MkpQbS9zUGZVS2Q3eDdvMXR0bGlaMnhWd3YvY2hIWDFWeUdwYjJLVlQwZW0z?=
 =?utf-8?B?aTQzWnpOMUlxaExUVmJyYk1uNEV4REEveTViZHBLTnI2UTJ1RGNzVHN0d213?=
 =?utf-8?B?TzNNM1h6VGpLQ1d1Q1Jqa0FZVjVXMjdlMVQ0R3V4N1VQZlBLYm9LMGJYQzFN?=
 =?utf-8?B?cDMvRFh3bTZBM2gzK00rOER1RHZQWGY5cnlPaWFpZ1M4eHV3dFdJOGV1Q0x2?=
 =?utf-8?B?dlNWajBsUUg5Sk9ZT1FFNG1WdjUxbW9acVhiZldDN1E0TmZwS0hBNTk3SjBG?=
 =?utf-8?B?MnA4c0JGWjRKblZQSGNXR294U095Z1FjajE0SFBjektCS2JjWGtmSnZqdHRo?=
 =?utf-8?B?cCtLV2dnalNWYUxOZDZMNVdGZEpWNDVEanNOUnVuOVhwR2FEOW1PZDhqQ2Mx?=
 =?utf-8?B?YzlDb1p2cnlMU2poZVVHaXBVTCt3MGRBalUrckp4Yy9EVjZSdFRRYXliNG1s?=
 =?utf-8?B?MXkwUEtZTFFaTEw4T09ESE9YM1JuSzlUdEdleHJvK3NJZUFJWkQ3NHZWVThS?=
 =?utf-8?B?U1FRWTNrQlRzdUFXYlMxdms4cnNZU0ppRTBDUCsya2wxbDczZHYzbStsaElS?=
 =?utf-8?B?alRUYXJqa1I3bEVZYm5zK0R5MUlEakZtME5tUnIvVmpjc3UvcEtKWFAxd1Ez?=
 =?utf-8?B?ZWduNDVYS2V1K1lmUDNYbit0bFZGdGlTNktCSllWdHZMRkFyVjBZdEQ3cXIw?=
 =?utf-8?B?V081WVdTRjVPQzEzdDFLdjc5SEN4VDlLQm1wOTg1RnA3Q1lZanp4UGNDaE90?=
 =?utf-8?B?cmtlY0ZPaXd2M3pTUjF6eWxWV1FQcCtBRzl2MWZxeTAxbjl6SFdPVWRLOVVN?=
 =?utf-8?B?bmtSeVJoRk9GYUcwS3RGa0xHbmVyQ2NzRFl1QjBqR2F6RkpwZHR2ak1wUGxY?=
 =?utf-8?B?VVJHS3A2K1FOM09OYWdIOFpmR2gzVGp2eGhhR3NZc3hocVhWemI3czBRQjB4?=
 =?utf-8?B?b1l0NlZQR1Z6eERSVVVyeHBJTjBoWnNWMG41aFFhYmFhbVFkeGVhelBTWXZK?=
 =?utf-8?B?cSsvY3dWbmpKMXVXbzJzN245WU5CSjFuUkE0Q3pZODM5aVkrNFA0SitmRFh1?=
 =?utf-8?B?T3RqVFFWdXpudldRWDRKQTJSck5Bdzd4elhHT0Y3Rm5iaWRtSHpySXhrRm82?=
 =?utf-8?B?SUVocEN2YUhORUpaUkpGTnNBeTRJczdWOEFnS01VSDBXWThOMjRQbDBjc2pE?=
 =?utf-8?B?enVjTmlLNmdyTTFaMzFETDhILzI5M2VDRkE3YkFtbC9rWnkzM2wxVWloaTNX?=
 =?utf-8?B?ck5zMlNOcGJBVzgra3g3K252L2dleEgvZEo1RTh5QzlyS2VKNkwwQm1WdW5w?=
 =?utf-8?B?RzU0aks5SWg4ZWVZZytTbCtOZHBmRXdYOUwyYkZhdE9FMmJ4ZXlOOU5keVpL?=
 =?utf-8?B?bDkra3hSQ0E3UjJYb1I1RXJGNmFnYS9mYWpEMFJsUjJTSGc1dTJ1UGdaTFRU?=
 =?utf-8?B?by9uVkNlZGdXRExGRHM2cGdwWG1wN05janJvRUptM1haWWxyYXdnSlhYa3lx?=
 =?utf-8?B?WTNtellXclVyUndtL2VjVjZHakJuRlNyankra0g5REwweHBwRGg5dnlubjA1?=
 =?utf-8?B?TTdqeU95ZGNmMDVTUkpmSjBOZ0dqUVllZDhDdXU2VFI4R0JRVnJRQ000N1Bw?=
 =?utf-8?B?am1wYjZmUzg1bUxKNVEzcjNCcEpmV1hVYUFhclVsd3N3WU9hZU5TaXYzNE5j?=
 =?utf-8?B?NEkxY0JJUVVvUzVJV0twNEFqVHVBRm8xcUpMdjhyWlFxRHFjZnBrdHE2MWVU?=
 =?utf-8?B?MW9LalQ5Um51NklMVm85eWk3ckF3SXhGVkFIMmZtQmcrY3p6c2lJdXNTQlNn?=
 =?utf-8?Q?pk7w83ecJ8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2tabXJmNVZvOEpCZS9mdFNOem9ud1ZRZHFFV25ENnhsbVlFd3Mwc2tPQ250?=
 =?utf-8?B?WlRETWVMaUk3WGpIMGVpaG82R0IrbkoyL0xDOE16Z3hYL0h4VkR4TFpwUUgw?=
 =?utf-8?B?SEZ3Y1pyQkcvZ0dMYVdxcXlVS0JpNE42cDh2OHQxenFobVU0TndSbFhLSytZ?=
 =?utf-8?B?c2I1ejdKdmQ1eERyL05PNytDd2tYUlJnVGxBaHRibU1Qd1ZpNlN0TDZRc3Bw?=
 =?utf-8?B?VzBFc2VzckpZQjFiNzBTdnYzajB0SWlZbHJqWTVHN0h0dFNKN2JwMTIyeWhw?=
 =?utf-8?B?ZlFWSnNkSzRYMUNRR0RYTGczZGRMNUpIUllsMUF3aVVlbnFJQ1BPc2xhQjBq?=
 =?utf-8?B?YUdEQ01QSlB4OGNNYjdIZUtoRVdSWHppNGcyQzZIKytFMkcxUzU1K0RSWW04?=
 =?utf-8?B?aHJRRVl0cXhabGI3cTV5Z3k0Y1BFU3ZScGdydFRiRlYwVnVJQ2cwZHplWUtp?=
 =?utf-8?B?bnp1M0dBRkZDYVhEYXNDVW9EaTNrR21yTFpiN0JXb2FKQkhOZHU0RW9kc0N6?=
 =?utf-8?B?cVpzUys4UVlvaTM5UUVnWE0zbUtHVUpyUENvemlhc0d4aUtYM09ncDViUUJV?=
 =?utf-8?B?MjN2MXYvODJVSTd2K1RSa1BIMWdVZWp2Skx1d1FaR3BiV1dzQnRqVTZYT2Ur?=
 =?utf-8?B?Uks0eWVpeUh5MWd4TWJwRm9scjhjZVlsU2xNTDdld0RsV0lxUUVjUC83UUlh?=
 =?utf-8?B?QjZoTHhHbUNjeEJwYlRSYlY5S1VxWXM2N1B2aVBGQ3MxdXZYNWVWL1pqTURw?=
 =?utf-8?B?cnNSQWdnYzhZRzlNbEJ2aUJCSWVOdUFHcGovc09aTU1WNlJnaEdRMGxqb0p3?=
 =?utf-8?B?TmxWL0lrWWxWVDFIeVRsc1Q1NVRuZ1hMY25iQ0djUElaOXZabFk3eEhIditP?=
 =?utf-8?B?L2tGY0F4cE0yMHRGakJ0QldXYU9QejdlTDArVUJOY1VyYnlLTkxlSGpmMlUz?=
 =?utf-8?B?NGdPZ3UyYzROb2dUamhaNnAwcnQ3SzlncW1HTEU5RzJSV29hdUN1M2dLVzJq?=
 =?utf-8?B?NDlQTGZDbi9mYit0T2tIUFFoN2lwcnVrT2VxNGFwckptcnpLN040a1ZzdWk2?=
 =?utf-8?B?Qy9KTUd6NUpXYVY1ZU5zWTNrV3pqZHR2dXQxTDN2RUJjWVh4Q3NkZlJaZXgw?=
 =?utf-8?B?SXlHWGh2b0dESS9sT1F6Q3BoRUNXY1pjZmhsNTlDTm5CaW40QWZ5blZCa3k5?=
 =?utf-8?B?OENOSms4M3JEQW9HUnlSWXhqay9scTREVVowQUx3SU1CdnZ0SXUrMXdiZkYx?=
 =?utf-8?B?TU1HdzNEU3BtcDNRVGlZQmtEQlpzNkF6TEhEbWV6M1hHRjl0eXVsMlpNWk02?=
 =?utf-8?B?cUdMMmVZYW9CWlZtSmdiTUYrTTdORnlOam44aHdhaE1jbTRZVG5KRW5XV0s1?=
 =?utf-8?B?YWlmcE0yZlJHUFhyQXphUTJ3ektyV2dOVUhEWjZBaktBeDBvZTNyWTBCVEd5?=
 =?utf-8?B?czBsY1lLdUJJQ3VMaDdRak56TmFLSXNpRlVYUG1IcVF0ZDlkdXNHeUY2Y2RL?=
 =?utf-8?B?WEFSc0E4K3hYcEU2UXplS3VLbGhPMkhHZDUzMFI0cW5VL0RvM3ZwYS8rSkZp?=
 =?utf-8?B?TWwvOVZGcjl4Zk9sWVNVTHdhbDFqdzRxcVRTYXJEODJtSyt3d3FSNDhxUUZI?=
 =?utf-8?B?OURzcTBiVHNxeUdnV3pob1BzbEZTR0k0QXc3WXpSTW1ySVRRWWV3ZWh6MHMv?=
 =?utf-8?B?OWNnNG5OTEx4MjlhaVVpa0NGRmxRMWQ0K1VESGVmY0FLbjdPYWVuV1FmUFJ6?=
 =?utf-8?B?eTdqVDZ6dEhVaHFETDROWlZ4UUFBbFg4SzNWRHcvOHc2aTBQdzFpVmV0Uitl?=
 =?utf-8?B?T1UzUWlhR2hMRE9MTVpGNXNIdERaWHlaaVUzQ3VOWkxPTFBtSjEwZGxsUTBs?=
 =?utf-8?B?bm1odWhraFdDb1FRdGR3U3F4VW4yWUVYWHV5emN1a01EZDZucVRSaUtUWkRX?=
 =?utf-8?B?R3Y5ZXZhSWNwOFZCTkhKcXZhcjFSZ1Z3OVBIa0Z4VnJGYU1SR24zWHJybnZI?=
 =?utf-8?B?SDJwSlhhNFE5dERpeUhGOXU3N3J6dm9lK09Pd3RxV0R1QWFlT2ZrWUtaR2N6?=
 =?utf-8?B?elZqTm0xeld4L2pXQ0g3UjRoOVdpMStvVkt3eXFjU1M3THh3SDFRSHJnRFJj?=
 =?utf-8?Q?2M9X5+ZFln/MT327nvxP3vZa/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31feeb2-b1e9-4eb1-5310-08ddb320ad1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 13:11:48.4073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mweU6r6UMqayjVFlSOfqrGN5b+7hbOa/QeQrn27RDTsomUm/kbNne0IVuJolYiVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

On 24.06.25 11:46, Tvrtko Ursulin wrote:
> 
> On 24/06/2025 10:18, Lin.Cao wrote:
>> patch "daf823f1d0cd drm/amdgpu: Remove duplicated "context still
>> alive" check" removed ctx put, which will cause amdgpu_ctx_fini()
>> cannot be called and then cause some finished fence that added by
>> amdgpu_ctx_add_fence() cannot be released and cause memleak.
> 
> Ouch I removed the wrong one. :( Probably misread kref_put as kref_read..
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Acked-by: Christian König <christian.koenig@amd.com>

> 
> But is the SHA correct? I see it is dd64956685fa.

That could be because our internal branch is not yet rebased.

> 
> Which would mean adding:
> 
> Fixes: dd64956685fa ("drm/amdgpu: Remove duplicated "context still alive" check")

And maybe CC stable? Or in which release is that patch upstream?

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>> Signed-off-by: Lin.Cao <lincao12@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index 85567d0d9545..f5d5c45ddc0d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -944,6 +944,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>>                   drm_sched_entity_fini(entity);
>>               }
>>           }
>> +        kref_put(&ctx->refcount, amdgpu_ctx_fini);
>>       }
>>   }
>>   
> 

