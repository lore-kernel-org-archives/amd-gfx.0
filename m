Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026C0C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 12:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD3710E111;
	Fri,  9 May 2025 12:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="36rpSzdT";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8136610E111
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 12:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1YNG82GPK9vRbT6WVpF41kS4m+CRu/aNLT5/T4jbx2RlY+9FE10fv8DA5lUy1jwSnjFywSRzCpaeFs5627ZzIzKbKQw7u/9Z8IyhWprUJKcErJrXVwSh1SR86H3jI6v6LaXmylcqlDgzZO4OC0FFt51ufh+FSkEHC9ipkYo+FwPjyYpfPLMcXc8IeWZuAmsxkNUwZA8daXOHY97q9OmixxNHMoECTNFyJzfyeGSlbwVgqAsCFfagomhLhEvKttP2dqZitEnnhLj2OUC+fjQVYZV543Iq5CAoYFvkaTyiB9vwNR6c4VvNn5NIHa/3eu8lxVcB43LSCgAkx32rTq7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAjlYP/3D+MeDVnEbzKKIavpj8acjSN54niB1pNCG2w=;
 b=LChklDDgd/r3h/iRQwyVbddQTzQF3BzLFqgfRRs+5idRbA5hbgkIXulT7W0NG4LbOSFgqbELfHAXbpMbg0+rS18pAer6qwV9ow6CZ5L3m/35UFf8GSRKITBSwbmSXO4r1HsAesAjwmFqLvYv+FDA6sIOH9Jd+r6KB6j2HSMO4zhi4TEtDX3QCt3ADitAQoGMBQrA4heaf+eg5dyiXouHPbUBnKaxSNkF1gw/EkQkZU4l+FCx2hj54Olmuf0xQ5kDfx1tDjhpZfvuAYgfxNfytPu4UMk4SxEid2EDIos7Pq38FU1Szwf7WrKuVj81KCIvxTkE1nTQGlkk4YmVd+xuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAjlYP/3D+MeDVnEbzKKIavpj8acjSN54niB1pNCG2w=;
 b=36rpSzdTNL75T0tk56zlSkix6Rg/QLnjkFvMtXDku0vRlagzfLAt6jn0rC3iI9qxMpIV9+LXqGUtALofsACyOeb01r+9PpFWi8DZM9rHtU5QBrB9KGd7+xEt8tR+D9+FQBg+EaobfiiL4MiM1peO0aEA/JF0Q3tR5C/o8mPOpaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 9 May
 2025 12:18:16 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.028; Fri, 9 May 2025
 12:18:16 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix user queue deadlock by reordering mutex
 locking
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: Alexander.Deucher@amd.com, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250509092215.3667971-1-Jesse.Zhang@amd.com>
 <aeed65a7-e422-4f40-b085-6632dacf2562@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <c415a1f1-420f-ee57-ac1b-f2d3b47b8761@amd.com>
Date: Fri, 9 May 2025 17:48:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <aeed65a7-e422-4f40-b085-6632dacf2562@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN4P287CA0066.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:267::7) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: c16809d3-049e-4929-331e-08dd8ef393cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TExzMEVLaklWVWI2SXNETFB4UlVDbCtHc3M0QnFpRTJIWmNCaEN2dWdicmtL?=
 =?utf-8?B?N1VyWXl4bXQ5WXlya2xmVTI1SVk1enNqRk54cTdjNE9RM2lmTnRYT1puTWh0?=
 =?utf-8?B?QXFxdzZSbE1sOVdQdDJwbnJzL2ZsWkNPNVUzWmVqeTAzRlNCdW9aaHBiWUM5?=
 =?utf-8?B?Y0dHOUI5TlFsVXJ2Vk9iNlpqNVUyNXcyUmdmV1l2RmlJVGlFYURNZ3ZrSDli?=
 =?utf-8?B?WGt2RFg3N0UxZlhHU1dOcm04a1dkeitzVjBRdElyRmhYZEQ5Rk5YTEdLV1E2?=
 =?utf-8?B?VEt1S2ZpcG9meXZLYWIzazViVWFDVENJNURrOTlCcEpSSno4WVlLYWdBOUoz?=
 =?utf-8?B?ZFhiRUJKYWxGUnI5cUttSy8rUDgwbmZLY2hMUlY1a1M1VnZseTZpcXpSaThN?=
 =?utf-8?B?VjN0Rnp5L1IrcU5Yd1l5MXdMUXI5akhqQjRCN3lJQ0Y5eEpJNktFbE5heFNn?=
 =?utf-8?B?QzhvcnM4c3VMN1EzQlRTWDYrY1laUXBQTnQzeFhvdEE2OHcveHRINWFnVlox?=
 =?utf-8?B?SEhBTU9LS2RCQW9STkpXVjhKQm5qa0dqdWFRL3NIaW96UlBoRTlQK2diNW82?=
 =?utf-8?B?YUVDRDNmeU9MeC9Yc1E2OWhyWEpxOTV6UVpQOFlha1o1SUZZOTkvcjU5WGNs?=
 =?utf-8?B?aXJmYlRRV3U0RVRib3dPUWMrY3crSGVDQnFsYlVpZXViUndYWkVxNEhVOU5M?=
 =?utf-8?B?a1RVaTRCOFJDem1jcWQ3dUhiQi9zclp3MGtHQXlLTHRqdU5DK1J3R2hJTnBU?=
 =?utf-8?B?MmtKVnJhdzBRb3A2V0dOQ0FjZDVPT2tsa2dlUnNENTNwdDkrb2hSbXZSSlZ3?=
 =?utf-8?B?RDk1SXd0bVpERU0wZjVaM3JXL2VOZVZmdVl5MTJDL0o3WmN4cmpMYzNLUHVX?=
 =?utf-8?B?SnVBNis1S1Z6NkFFNnVVVXNMV1JmTW9lWGphMHdKWVpXY29VQlU5ZHg0Wk1V?=
 =?utf-8?B?U251d3g5bGlKUXNVYnJyUmRENUNzY3F5ejFpbVNMam1mczROZElpTmYzdW9p?=
 =?utf-8?B?U0FCaUdOS2loelRwd3FKa0puakd5WlpMaVBUYjQwdVR1YUJ4dDFmMGxBNFJK?=
 =?utf-8?B?OWhvRWNOaUVlWWxqNmN5d1RkWmtWS3AyRk1yMmJtVXJZVUh6eml2ZUVjRWsx?=
 =?utf-8?B?QVN2QXJFb2ZzNGUwZ3Byc09XU2g2eXo2b3JmV3k4N2lIaFgvRGZkYng5MS9C?=
 =?utf-8?B?dTd1djBEemZiRC9lL3BOWW9NMndZd1BoRVZPcHV0ZThkdlVFVERYMTRyM3dS?=
 =?utf-8?B?MnpxeWlublhtbnU5RTRVTGcxc1FWUnVEaFB3S0pjcHVjaWFEUC9yWXYyUzBs?=
 =?utf-8?B?OHJYZnd6WklYZ05hckRpMFE1aTRaUVltbzJwT1l2Mk5uMEpJcGZMdEwvYUFx?=
 =?utf-8?B?clNQeStyR3UxeFNFeWxrd2JDRXE1K1BUbzJsZDJGUFV5eDQ0bHlreTJsMlBO?=
 =?utf-8?B?Yjl2NTE3cTN6dlhyeGJON2czMWNrMmY2VTNLLzVnOWVBQ2llMmpnOHpwRFhF?=
 =?utf-8?B?M1NoRGxVaElyM0MrT3Y2cE50N1BhRTZ1S2NkU2xzOWdZL2VWbFVOUnN0SXZT?=
 =?utf-8?B?TFBVZ1Y4Y3FNbHRTV29EbVNucStTTUx1WUxhMTBSMEFJTU1mcEZEL0RkQzU4?=
 =?utf-8?B?cnVoanRPaTA1YjBKeFgwbE5uTDV3dy9yUlRtVXRkTUpLUTB6ODNWUVlNL1Z1?=
 =?utf-8?B?NEpzVW5FZWRTNHQxTW93cXRocXIxck1nWHVlcFNNb0pQc3hOTjlURTR5UU1J?=
 =?utf-8?B?bzhreFM1WHhNdDkyQTJCUEJ5TFVuZWJEVGF1U2tqY215Q0JITlBDQmN5NjdW?=
 =?utf-8?B?eUMvZGtjbkFPV3crV0VHNWFPVEtZeUFUV3NsUEJXeW1tVzNWMkd2UXZ4SEFN?=
 =?utf-8?B?NDJvVnJ1MjgrdFFacVUvQWtYQzZMN3Nuek9rVzRRVStEK1VZNzJUN25ZQ1Ev?=
 =?utf-8?Q?Qm9nq6NnnGQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFU0ZWVGSUkwQVd2c3pGSHF0aWJZSzdZckcrNjNDQkdyOXpvY3FaWEhTMFB0?=
 =?utf-8?B?RnZVK2I2dEN5TWpsOHVPd3F5b1NrOWpoZjBZN1VLWjdydlN3eFVPa0VnNTBy?=
 =?utf-8?B?OE9pZU5BRXB1cFNwVjZ6ZklPSVpGRVEveWoyS0loVVpqcmNsYm9IcDBIYXQ3?=
 =?utf-8?B?N3RYN2diTVJhSnRNbFl0T3FsL0lhcmN1Q092aXhBOExnNUluWHN2Z0hzNkc0?=
 =?utf-8?B?cnVBQStOTkQ2U29aVWoxZ3YxUVhoQXZMUlA0MzZONFBjeHRyR2t6dlZ6aStN?=
 =?utf-8?B?ZnZIN1BmU2RnbmlXOWJTejdSTkJEcnpndkp1aWlsVWVVNVNoU2NhL3pNSklx?=
 =?utf-8?B?UlhuaG1XcmwrSm9xSDVPVzhnNE9VRHA3QTEwSCsvNVhTVnlLL2hLVTU5TTNY?=
 =?utf-8?B?NmFxNloxRlVHbVZDL0hwZzRnQ0preHMwQUZHNmh4Rkl4SEFkcjNMcVZyNU81?=
 =?utf-8?B?Wm5FZ0JsM0RXMjEveXpMS1NWcmhzTXl5OHkyeUpMNjYzMkFuaUNzWVNCclY2?=
 =?utf-8?B?YzV0NklWTkxWN2I3QTRlTFB5Sy9wR09sTElWbk5POFVRTTRnZkZOWGlFYmQw?=
 =?utf-8?B?QXNaQmU2L05aaUhRbFlQb01iak1WN082SVl2L0IrSW54QzF0NUpVVVRyVjB5?=
 =?utf-8?B?cVI2YVVZUnhMSk1zckw4ekNoZnZBZzlnNVNSR2s0M3hLblVENWdSSTNDelhx?=
 =?utf-8?B?eEFQVFVHa1JlSmtNbE9DUEFQc0cxS2hJbGVuZU9EaEdIL1VpTVNnbnZjbTBV?=
 =?utf-8?B?V2l6UTRoUWpqS0g0cTBYMVVlZ0hITWphd1BzNTd5TnF0YVN1azZ0QjNXK2FG?=
 =?utf-8?B?aEd6RWdFRFVDZEJFYzF0QVBldEVEdzNDUVhvc2NpS1N2VVFFSlJ1SHJqZFk3?=
 =?utf-8?B?WHZKTmxqVlFFN2lrUGtqSW5ZQ3A4L1JsK3NDQ2Y4b1p0YkxDL1NsaVJsVVVo?=
 =?utf-8?B?UWdGNGRiMmJtL1RVeVNUOTZrVUpCS0hhOUY5cmQ3SFpUeWMvaVBodGU5clg3?=
 =?utf-8?B?TllQcjVVTGpIYU9VbGxRbDRqZk0vMm5zejhFdWZSMGFkRGNFdW5EOHI0UnJP?=
 =?utf-8?B?TGhhbkx5OWhKZmdBdGVwbnQ4OHJudWhVT0pnSlJhc3NCQkJlUGlueURTcGI5?=
 =?utf-8?B?dy8vc2t4Q0E1NGdKU1liL0hVeUhqK0xUWnBUUlpkMjg0eVBNMkEzK3RLTEJp?=
 =?utf-8?B?RVdRTXVMbzNPMVlMd1hxQ3cxR1BiZ3Y5ZThQVFVZNXFSQlV0MEV6TldlcW9p?=
 =?utf-8?B?Q1R5aTdaRE80aTdPaXVFUGsyNVhCU2VOSVAzQTVzdE1yWkhvRjN1VlhNSnpY?=
 =?utf-8?B?TnRUN0ZsQitjKzV0aVN3emx0eTIwNjJadnp5b1RkSjZHSTVFTWFReXJUSURh?=
 =?utf-8?B?U0N3NGpRL1pQN1Y1OW8wb3orTlZpMVExcTIrQ1pTamVyRHowWXBhblNGa1ZX?=
 =?utf-8?B?NTlQV25GajV0d0hZTVVZYzJ1My93MEpXbWNLckZ6YVpHZjN3eDVMcDdUUzZP?=
 =?utf-8?B?cDl0WHpTUjlpM1UzNXVXaTg1aGpYMGZRdHl5a2kxdTFpKzA0L2N6d0xncFkv?=
 =?utf-8?B?a0ZPb3IrQXlQWm9hdlZkT3dNTjhEUU9va1lSVHR0N1Y0a2lkMkdtb0tjQ3hS?=
 =?utf-8?B?T1ZXcHpLUFYvWGxmOXhCdHovZXIrTlJzU1pLM3M4ZkgwSmxJa0tuTFExRWlu?=
 =?utf-8?B?OGE0WjFlbkFZQWZiY3BxNXpTcE1CMkRjVFlPTHpFY0ZKVm5lWnBSWXlOSlNL?=
 =?utf-8?B?RCsrcGJwbC9FbDBCUlZBR3NhUXJEbzdQcWNjUWFJNWZzaWRueC9pZXJTenQy?=
 =?utf-8?B?b09xckRuS04xMkhXUllDTWFhTW9ON2o4NG4yUzE0TWsxSVNiSUowR0hNdnNQ?=
 =?utf-8?B?eDZSTGpDbFAwOGFvREJ4MXpEdlVjbUNmUE82ckthaVM4d2FRMUQ3QkZaNDVr?=
 =?utf-8?B?RXRvUmFzc2N5T3RKVDZQNlhkUzNOUjJ6MkhERW8zaG5wWFBteEhyblVrNkJj?=
 =?utf-8?B?cXZVVlpMem1tYWlWdmhYMW44VUtlTW8rL3V0YnRMbm96aGlZcW5lQlppVDE0?=
 =?utf-8?B?RmxDSWp1U21iUEs0cmNDMTZQSy9PRGJIOGxUSk5TWk5KZGJ4bzBmL1AxZVVF?=
 =?utf-8?Q?w07KkvLVKMEo5mjb/KsmvMtTw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16809d3-049e-4929-331e-08dd8ef393cb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:18:16.5111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3l7ef+MGXBswdCjYprIXV8KeaQD+qNgdm3/vztxxXrcrk3ZX17osMOANuWHXSRiPgLqk9lQvj92WHZksCFezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
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

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 5/9/2025 4:48 PM, Christian König wrote:
> On 5/9/25 11:21, Jesse.Zhang wrote:
>> This resolves a deadlock between user queue management and GPU reset
>> paths by enforcing consistent lock ordering.
>>
>> The deadlock occurred when:
>>
>> 1. Process exit path (amdgpu_userq_mgr_fini) would:
>>     - Take uqm->userq_mutex
>>     - Then try to take adev->userq_mutex for list operations
>>
>> 2. GPU reset path (amdgpu_userq_pre_reset) would:
>>     - Take adev->userq_mutex first (for list traversal)
>>     - Then take uqm->userq_mutex
>>
>> The solution establishes a strict top-down locking order:
>> 1. Always take adev->userq_mutex before any uqm->userq_mutex
>> 2. Maintain this order consistently across all code paths
>>
>> Changes made:
>> - Reordered locking in amdgpu_userq_mgr_fini() to take device lock first
>> - Kept existing proper order in amdgpu_userq_pre_reset()
>> - Simplified the fini flow by removing redundant operations
>>
>> This prevents circular dependencies while maintaining thread safety
>> during both normal operation and GPU reset scenarios.
>>
>> Fixes: e274db8c826 ("drm/amdgpu: store userq_managers in a list in adev")
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 1c0ddec06280..0f1cb6bc63db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -879,22 +879,23 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>   
>>   	cancel_delayed_work_sync(&userq_mgr->resume_work);
>>   
>> +	mutex_lock(&adev->userq_mutex);
>>   	mutex_lock(&userq_mgr->userq_mutex);
>>   	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>>   		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>>   		amdgpu_userq_unmap_helper(userq_mgr, queue);
>>   		amdgpu_userq_cleanup(userq_mgr, queue, queue_id);
>>   	}
>> -	mutex_lock(&adev->userq_mutex);
>> +
>>   	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>   		if (uqm == userq_mgr) {
>>   			list_del(&uqm->list);
>>   			break;
>>   		}
>>   	}
>> -	mutex_unlock(&adev->userq_mutex);
>>   	idr_destroy(&userq_mgr->userq_idr);
>>   	mutex_unlock(&userq_mgr->userq_mutex);
>> +	mutex_unlock(&adev->userq_mutex);
>>   	mutex_destroy(&userq_mgr->userq_mutex);
>>   }
>>   
