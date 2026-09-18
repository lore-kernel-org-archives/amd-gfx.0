Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487AAC982DA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 10:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC59410E092;
	Fri, 18 Sep 2026 10:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWc1Mj9f";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6B110E092
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 10:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZi+ysvhAogZhLU+J/5vv5aOqPgy2Y8O+YScZgyw8ZcWPeeUmqSzRIxzPAnD56582Elm+bxDquYfhPgcMd+LiLP5HkMdWuVjnv1TjHsTtIVcUBJtOiCYMLN9ri7QYekLV3RQ4fWKQ77vJXBDue5S1Hr7AGA6O0XkKKEwhzUol2mcrc/rg3L3xvl01mmCPTCgficKL7U2A7gAygIUCgGTEA/XYkezrJ2DhhvjQn8CC3Y9+e1wx8UevzPkllYfcB9932zfcossStU0w9WNPeIOC3Ka6cibGMGKyRB6hccNDrow/WrBI953vA9biVzf27szF6G+wK/NPUoIXc1x+O4KDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iykwmfo2uIcqOXV1o5LKPmCs6+y4VuKxrA0xGPNe44s=;
 b=gVkxWco1WnnAJQp/XyXAxsDO1fgW4syr7CqvsA6QS8ll4Gjl0r81qXGE9rdwEJvPoVDzvDBaf2PQ85L0TYpk5CLb5b6luHoB0NLcbG7IlGFYrtSfj521It9g1/lmtvVUwmsLBrmOF7vkkrZgBHdSbA48p84Lb5Ih3Zbq3Pm8DZOW8aAoIdQ1JsJyigT4eNm1lJMHGhuREluLvyu/5wqaXIiRfiFE0PEeaapi+yTa0HXuwkn689kG1IVus+hyrKIxfFQV1jN/JjoBFM+sg2OeAyJpbQgh74wvtKTbjoZpxX4OMLM6pZXilAM9/ML4MDQOGr4fi9lCG1vBXrxkDWeyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iykwmfo2uIcqOXV1o5LKPmCs6+y4VuKxrA0xGPNe44s=;
 b=RWc1Mj9fznfNEVSRZlfrtf5zjpZp5FHVskhj1SkZJ9zTWcLSk7+Ua/aWHIHwZRaHvztc0Iiz1OfJtXcTHtYaXHSn3jmEQi4cTK8O4KRy1GxW+a9TdAVRgKgwflKXP03COy6/JZ0kLc1tigp1xz6kXOBpUp+JSMWW3mnied8YpeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 10:01:55 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 10:01:55 +0000
Content-Type: multipart/alternative;
 boundary="------------0OTGaiVxx85TT21bjVUgRoq4"
Message-ID: <443c6d8c-107e-4eaf-b81d-d6df2733b5a2@amd.com>
Date: Fri, 18 Sep 2026 18:01:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
 kref
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
 <CH2PR12MB945710EE0E52DC2498C528C28CBA2@CH2PR12MB9457.namprd12.prod.outlook.com>
 <BN9PR12MB51464E162658C6DC2425638AF7BA2@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <BN9PR12MB51464E162658C6DC2425638AF7BA2@BN9PR12MB5146.namprd12.prod.outlook.com>
X-ClientProxiedBy: TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::14) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: ff930d26-32b4-4bcf-a3cd-08df156bdea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|22082099003|18002099003|13003099007|8096899003|4143699003|5023799004|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: YWJcM8xeujWQ/ZcDC/b9/DRzc/SIMyYwxXB2e9b3rA6Oei9XjoVfbYWOXrtQcaqDN37mKAXa2efqjPm8RGS0rNu78gdFN+8HyY3ySmS0qTNgDm+g6esUEOTVBSEeZvTFy+mpgx4F1ay5nKc1Tf1Is5g+uG+PmrRDZB24+q4aasEUGeH4HzVkWIzD85gnjKe3ZQ6oCHvyl/Cc2Ay7P4vtCZvCZ6VpJQ2N5WsqdP5Rg/wOBjrTIp4QAjpbEDQfw12RVMVdK98fxlqAWLfJYmm1rtQsyqwQowdBhOztZtzquzoQAnvhBF2uYvCTbc8DD7YQmnhpjNlE1iWqpTLyC3g9UfLQvzUdNchSqoVwwAsXxPBcrJwb2L3NTVVSJd2XThIAq0GiYyH1Es6X+ZVGrw19OF5K/d7AFQq1tJIIHr4Xgu77wcmrLYhG7IW49nJ5/kUxCJr3mD5sYpqcx6m2uHXGXl/rK93FB3aNFlqMZTT2GkXcGMhPOS5Smi2INXXrWrD/D67tYDFgngT7A2moGDU+5Un6wkiIV9mM5K7R4LWUMaoJFH3FfMgRxEgTlhvlZ7suEKGCFR7aRrRTjVYEx6nLROvmVSLuriLxpHZtC3HrV6JTjl2O6xf0XZXkN3g6S8+i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(13003099007)(8096899003)(4143699003)(5023799004)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG4rdzJqOG1hQk1uWVBJNmpUaklXSzdVeXBaRVEwcUdyVjZIOGhQVnBlSmpU?=
 =?utf-8?B?VzZ6U3NNL1h6N2V6Rjl1MFAzVW1oZzRpeEd4Q2w2aXRmblhiNFprUEVPMEUw?=
 =?utf-8?B?VkVHait2Sk1zaUVYTXJIbm53ejhLcmVDVjE2K3VpL3A1eGpQMUtWRk8yNWJU?=
 =?utf-8?B?algwRDR0aHk1N3k2Um9qaEVuWlpIM1ZZOHllWGlyWDllaGJ1d1o3SmNHY2xa?=
 =?utf-8?B?OWxYV1J4Zm0zTnkrbzB0cGp3VEJrdW1PZGE3V2ZKRS9HOUkvY3pEN2pTNVRz?=
 =?utf-8?B?cllUdk9NNWhOTEFEbzNpcW9FZWxmc0syY255bDFaSDl5N1BlQ1BpbHlzeDhE?=
 =?utf-8?B?YkRIelREeHlCbUhLNkYrOXdSSTdRdmNINnpaaWRJUld0UHhNaHYxeGd1M1dv?=
 =?utf-8?B?dXBnT3RpR1Njc0x5aUZ2eUdpcG9BTUVQQ2wxdG1xbzhhM3VxVDU1Mk5zOExJ?=
 =?utf-8?B?L05ZQ3FtMmFPVVZSWjhnVS9XNjcrYzE0RTU4QlprQ0lNaVNnN2dnTVlGeTdo?=
 =?utf-8?B?ekRwSUdVd3loWTY1dlJ1eTgyck9qelBBOUJZWjZxMlBFU0M2ZjJPQ3IzRGVN?=
 =?utf-8?B?NXk2bzJKU0kvdGdocEtSc1ByaVVZZWs2RVRtSXN2Q0pQd2VZaU1tQ2RLZFph?=
 =?utf-8?B?MXh3T1BCSE5RT0U2anV0UkdsQkFiNTFTK0Z4UkM2RTFkdFVnSXdXY1N2RnRv?=
 =?utf-8?B?NG51aVhXWXhlUERJREI2VTQxclFXZkVqTlhUdjhwM3VHdnRkcjF2dVdaNTZh?=
 =?utf-8?B?ODhyZVA3akR5M2lBSVVTSzduVmw4aHZwV2p1RVd3VkVLclZWdDdQVTdmWU9P?=
 =?utf-8?B?OGZ6VlQzVGxpMTlFUzFRM1ZiNnpuQmd5cFROTXNqdEhNMGY0Nmt3ZTVCY0hT?=
 =?utf-8?B?eUVrb0tzUGVUMTZodTE3c3kvMEM2UGtBcmFYN092bklQbytac3hQTi9BWUNM?=
 =?utf-8?B?Vk1aZ29SZ0xvK1oyNHhIcm85aUwwSHJ4TlpSWUZJRHRkVnpPOEVib202NGU3?=
 =?utf-8?B?eGJNc09XVkhuZ0luVERtZm1JcmVFS254K0NMYTQxMUhjTDd4a3kyNzU2aStH?=
 =?utf-8?B?V2NkQlM3WERvSHo0bmQ1SjZyZ1ZRd3llYzVsckNPbGZ2YkJOZnpBOWhnVTdF?=
 =?utf-8?B?RE1EMHJ5MGw1ZWJCYU9UVnBYVnZmRDlNTEhhWVExWTZyd3FCYmd4UlN1WmVR?=
 =?utf-8?B?a3BrTGRTRGhuYkN4V2JUTVZrdy9QYUlvSWRkK0lrMm1xZGE0cTc2S0J3VUxv?=
 =?utf-8?B?OXBhdjZUc1M5YnVRVmdTQlZXcGdKMi9wVkI4VnBFZ1RnWkY0MkZDb3RCdERP?=
 =?utf-8?B?bzBBOUhvS1QzVkk2OU5FWkhHZ3Vaa2RPcDVuWEhVNTFhVFdVb0dlL3Vpdmk1?=
 =?utf-8?B?STdLYTExanl1bVVOc2YwTk9vR3dNTThkbUhVTWFFTjBHaU5VQUJodCtYVktG?=
 =?utf-8?B?d0ZHQ1U1WFJVU21pN01qUm9qczE3MW9yemFLell0TEdJYUF0dkhIOUtYNVJq?=
 =?utf-8?B?S2hia0hrOFMvVUd6VVdMakpWTjFJbEc4R2RPVjZQaXlVTXkvM2p3aFFBMjBY?=
 =?utf-8?B?TmNKRjEvTm1MMjVYSjdESnI3QWZ3NmhxTk1OLzIyazdzeGNLL3JiTmIwZVA4?=
 =?utf-8?B?TVp0ZFFtVjJ5TE9PR0R3cklpclNDVFVnQzliam1QOUVtZnNOcGNPcm1PVWZs?=
 =?utf-8?B?QUltZTRHSGM2aHVzNUFlNE5VUDlsN0t0YkZQdGNDaEQ2SzU2eE9XM2EvZjc0?=
 =?utf-8?B?djN0ZTVVSGRZSDJDZkE0L1RZclUzeXM3aG1YUUh4N2JwSHA2ZFZob1kwVUNH?=
 =?utf-8?B?L3F1eXdualpXYndmdVlsMm44Sm84OUtaOUNwZ05kdVZlcnFHMndhbEJHRkF4?=
 =?utf-8?B?R1dUcm41T0llUXFXSldkZzMwRnljSEY0MEtZRlJZZGMzcUIxYnpaWjlxSGI1?=
 =?utf-8?B?WDF4K001Z2NKZDBqR0lET2J5YjlnVks2WURrQUpyQzY0aFJJOFBZY3NQRUx3?=
 =?utf-8?B?T3lTdHFILzJIYzExSlhiNDJCOHdYUDBLUzJndU1KSTU5WkNvL1FjN1FjQ2Zr?=
 =?utf-8?B?UmR1dGZsVjhMNm1QZ3RnS1FLLzRXTTdnRnp3bFFRUjdzUnRTbGZLNDdvZHc5?=
 =?utf-8?B?NWhSM3lMK2kyUTRZTmZ4Vjg0b2RVM0VuZFBobUY3NDBsYUE2WENNMUc2RFRz?=
 =?utf-8?B?d3ZBRHZZV08ya3ZQTkx4Y3dyMnJjZGpBaHhQWVhBdmVmK2hUckwwTFNmdkF3?=
 =?utf-8?B?WHpXSVN2dVFKRGZRNlZIWnU5SklYWG85THd2aHFkNEpFZ3VsRXpoZERpSGJR?=
 =?utf-8?B?aW5HRU4vKzlFRjIyVDBWbCtFdFFmV2VnVXpNZXhnUXArOFY4djE3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff930d26-32b4-4bcf-a3cd-08df156bdea5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:01:55.2476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QfhQNhp4c5sdczBq3O6bfrR1SHgmUMI9sSxg2H635jZQxAWvLnhZKxK3Umawi75qP417HQB2HGx2HjyR5O6Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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

--------------0OTGaiVxx85TT21bjVUgRoq4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/2026 6:18 AM, Deucher, Alexander wrote:

> AMD General
>
>> -----Original Message-----
>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>> Sent: Monday, September 14, 2026 9:55 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>
>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
>> kref
>>
>> AMD General
>>
>> Gentle Ping Alex
> It doesn't look like Christian's concerns were addressed.

Hello Alex,

I didn't hear back from Christian for almost two weeks, hope I did not miss any emails

This series tries to fix a common use-after-free issues for user queue.

The user queues are destroyed when its kref get to zero. So any code paths that work on a user queue has to
take a kref of the queue to make sure the queue is alive during its operation.

However there are several critical functions does not take a kref of a queue when operate on it,
for example mes_userq_reset_queue(patch 6) and gfx_v11_0_userq_priv_fault_work(patch 3).

There could be use-after-free bugs if the user space invokes AMDGPU_USERQ_OP_FREE, or close the drm file,
or the user space program unexpectedly crashes/exits when kernel processing the user queue without holding a kref.

This series tries to fix these problems, and this series is a dependency of the PMC work.

Please help Review

Thanks
Lingshan

>
> Alex
>
>> -----Original Message-----
>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>> Sent: Monday, September 14, 2026 9:07 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>
>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; Zhu,
>> Lingshan <Lingshan.Zhu@amd.com>
>> Subject: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
>> kref
>>
>> A struct kref is embedded in user queue, which manages the lifecycle of a user
>> queue. However, several code paths access user queues without hoding the
>> kref of a user queue, especially from the doorbell XArray.
>>
>> These accesses can race with the queue destruction process and result in use-
>> after-free bugs.
>>
>> To fix this issue, this commit:
>> 1) Introduces a new helper amdgpu_lookup_queue_by_doorbell, which looks
>> up a user queue with locking and hold its kref during access.
>>
>> 2) Implement asynchronous userq destruction routine, because the last put of
>> a queue kref may be placed in a code path where can not sleep or conflict
>> locking with the destruction process.
>>
>> 3) Hold kref during access the user queues
>>
>> 4) Keep the userq manager alive as long as its queues, to avoid UAF issues.
>>
>> This seires passed amd_basic tests in igt tests
>>
>> Link to previus discussions: https://lists.freedesktop.org/archives/amd-
>> gfx/2026-August/151692.html
>>
>> Please help review
>>
>> Thanks
>> Lingshan
>>
>> Zhu Lingshan (10):
>>   drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
>>   drm/amdgpu: keep the userq manager alive as long as its queues
>>   drm/amdgpu/gfx11: hold userq refs in private fault worker
>>   drm/amdgpu/gfx12: hold userq refs in private fault worker
>>   drm/amdgpu: implement asynchronous userq destruction routine
>>   drm/amdgpu: hold userq kref in MES reset
>>   drm/amdgpu: hold userq kref during isolation scheduling
>>   drm/amdgpu: hold userq kref during suspend and resume
>>   drm/amdgpu: free userq by kref_put when fails to create
>>   drm/amdgpu: take queue kref in userq_create to avoid UAF
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214
>> +++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> |  18 ++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
>>  5 files changed, 246 insertions(+), 46 deletions(-)
>>
>> --
>> 2.53.0
>>
--------------0OTGaiVxx85TT21bjVUgRoq4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/16/2026 6:18 AM, Deucher, Alexander wrote:</pre>
    <blockquote type="cite" cite="mid:BN9PR12MB51464E162658C6DC2425638AF7BA2@BN9PR12MB5146.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">AMD General

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
Sent: Monday, September 14, 2026 9:55 PM
To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Subject: RE: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
kref

AMD General

Gentle Ping Alex
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
It doesn't look like Christian's concerns were addressed.</pre>
    </blockquote>
    <pre>Hello Alex,

I didn't hear back from Christian for almost two weeks, hope I did not miss any emails

This series tries to fix a common use-after-free issues for user queue.

The user queues are destroyed when its kref get to zero. So any code paths that work on a user queue has to
take a kref of the queue to make sure the queue is alive during its operation.

However there are several critical functions does not take a kref of a queue when operate on it,
for example mes_userq_reset_queue(patch 6) and gfx_v11_0_userq_priv_fault_work(patch 3).

There could be use-after-free bugs if the user space invokes AMDGPU_USERQ_OP_FREE, or close the drm file,
or the user space program unexpectedly crashes/exits when kernel processing the user queue without holding a kref.

This series tries to fix these problems, and this series is a dependency of the PMC work.

Please help Review

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:BN9PR12MB51464E162658C6DC2425638AF7BA2@BN9PR12MB5146.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
-----Original Message-----
From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
Sent: Monday, September 14, 2026 9:07 PM
To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
<a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhu,
Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
Subject: [PATCH RESEND 00/10] drm/amdgpu: secure userq lifecycle by its
kref

A struct kref is embedded in user queue, which manages the lifecycle of a user
queue. However, several code paths access user queues without hoding the
kref of a user queue, especially from the doorbell XArray.

These accesses can race with the queue destruction process and result in use-
after-free bugs.

To fix this issue, this commit:
1) Introduces a new helper amdgpu_lookup_queue_by_doorbell, which looks
up a user queue with locking and hold its kref during access.

2) Implement asynchronous userq destruction routine, because the last put of
a queue kref may be placed in a code path where can not sleep or conflict
locking with the destruction process.

3) Hold kref during access the user queues

4) Keep the userq manager alive as long as its queues, to avoid UAF issues.

This seires passed amd_basic tests in igt tests

Link to previus discussions: <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd">https://lists.freedesktop.org/archives/amd</a>-
gfx/2026-August/151692.html

Please help review

Thanks
Lingshan

Zhu Lingshan (10):
  drm/amdgpu: introduce amdgpu_lookup_queue_by_doorbell
  drm/amdgpu: keep the userq manager alive as long as its queues
  drm/amdgpu/gfx11: hold userq refs in private fault worker
  drm/amdgpu/gfx12: hold userq refs in private fault worker
  drm/amdgpu: implement asynchronous userq destruction routine
  drm/amdgpu: hold userq kref in MES reset
  drm/amdgpu: hold userq kref during isolation scheduling
  drm/amdgpu: hold userq kref during suspend and resume
  drm/amdgpu: free userq by kref_put when fails to create
  drm/amdgpu: take queue kref in userq_create to avoid UAF

 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 214
+++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
|  18 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  46 ++---
 5 files changed, 246 insertions(+), 46 deletions(-)

--
2.53.0

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------0OTGaiVxx85TT21bjVUgRoq4--
