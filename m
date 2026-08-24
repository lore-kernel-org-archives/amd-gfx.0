Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D716C5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 13:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D7210E543;
	Mon, 24 Aug 2026 13:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JuZsp2fZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6318210E543
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 13:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFeZNwsltSkCpMwCfsOPIePSO/wvfNACr9HmKvniEVSkgh5DkeBQ0r1241gFxbmK2oKeB98FMAqXUFtLPARhbEfx9zVa6s8dkeny4PLLkiGwaaakCqfUgy6f1e6tlBlkzCF350B8BiBcJOVmWTtXw9XWCzSOVrZCm7QDjYxpHyO0q267waTGbPZTqkyZlvHF+LvyQodOSyec315g+faijhgtkUHn4bHf8pcujXoQX/CBGzQXVY5TwFA3yPt71PLIJ04MZsKZU/lE95s49IiIR3L0V/WbPFX1zulORv/VbZz7yegdtqw+yd6usTjlJCfj7zMgyzybmmAofHSxq67mMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhukwyJsmh7TDEI9chV3AMqTup1FxnmmCzJvpkbkW8A=;
 b=eM2vptRq554a4tC3xU74e4/F/jPjohHi2MubgH2WXyHgYA1phkgx7xYF7ZZRKobLCAqjCLVKafPy7fGjLb5sF8TUhLzfDjHmSJQ+IpFKxjh9nppfDhJc4rAgQVpPCGUhcBk/KfClvvJoRn4yGp4aj/s72M5YgkEX+Khfs/eWXbaIx6NA+EWRRmTH003XdKyUoIy9P0ABDFnX+H36WRlCPxWrCo4FMvTixRO1X5ak5ysV77nHyTmFF1hNPfL70mh0viGLtHtDs8RvbzPytT6WwodTNbnJmXI9FS67Z9CRnvGfmgcH6aCACHDdWRf30mNy8G4k8tmn93hZueXelaWP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhukwyJsmh7TDEI9chV3AMqTup1FxnmmCzJvpkbkW8A=;
 b=JuZsp2fZXOFuNSQBOBAcW/zyCOpE/GGjvy4IjwsnZ6Dpu0GYe1J4ct6XLv1Aq+Ys/dqkbK+2giDvX70EisphkPS+tdXvh0nzlc+T/FY7fYYVeOII5bDfl1mEoZPUh+5lZE1PTJ6KXMHQPEu5nepVVDIIqBJq2cqo7nEbcIZeB7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 13:31:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 13:31:33 +0000
Message-ID: <5c05faeb-b310-4e0d-b6c9-6ade9da7f8b5@amd.com>
Date: Mon, 24 Aug 2026 15:31:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Sunil.Khatri@amd.com, Felix.Kuehling@amd.com,
 Shaoyun.Liu@amd.com, Mario.Limonciello@amd.com, Pratik.Vishwakarma@amd.com,
 Veerabadhran.Gopalakrishnan@amd.com
References: <20260816172608.14470-1-Priya.Hosur@amd.com>
 <59918fde-87c3-434a-a606-abb11ab3d899@amd.com>
 <CADnq5_O+qrWfFiLoMtdjFzXm2x35QK5ZFYgqX98qepXkfP2HGQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O+qrWfFiLoMtdjFzXm2x35QK5ZFYgqX98qepXkfP2HGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e138264-7fe2-4478-e4da-08df01e40396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|22082099003|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: BHiHO9GADy942RUmXfwIuenTr1SBm9YJohKnv12FzM2zhLNh6GFdONyl4/A/7IDVfoOdfWDGp7l6gJfD+94PW868BB/5jn5quWovDR8e4Ld/aDRKisxYjssuj4grH4kMMP4I24AW7lqez57j8A7k1K7cE7BaVoupKL3GchqwlJWeUpTLcB0hMkhN3OQyXUBYDJ0sA6t5krM32d9ak2DIBvrkNpn4jzRgAIJlZDlR1kCvvizVAfzYsSf7K/lY1btqZQXsHFWt6mJgsumeIKBwqTxuzgTbXxycnRu9saVs4YMioCD2YgP9MQQhL9N+isVa2mRx12EDLwCDR83fvJvh7YLmPo+R21ZtjTeZBXDHxkLs7D0hdl049+KL9ekcGfnLP1OcRK/xwAkTpzUAWEk7tP9s2PRVZFU+HY6H5kmjKKvT1OlaGHiNQatXkTgvpqIbApbcl/U655a9clqxMnrWFNhKqEGV+ExEF4ptreuemCWSfl3bQG7mIMbOAWYUJUswT0KDRsi9pjPYOcL3JViML6EMGvP+9b+b6iIXwfhY7VGigeQbh49ien6Oe0ihsR8ASp7LtSVM/W2dPa80KZGyh5d/w2C4PzNEqmKYFjRFvYUXzZyBfJhnprq5Wy6nva3fKyopzUJGjWpj2gZRxMWcSNczFedXM80w/5TcxKdaEvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(4143699003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENrQ0p5MUVtVC94SDB2cGlmWmFTVThsb0pPZFliT0hMMXpkZWZQYU5nY0wy?=
 =?utf-8?B?TXU4Zk05MzlyMTBaRnd4cG1OUFpKWnQ4NkVNUHRqcjdrcHRWNVRKcGdEelEw?=
 =?utf-8?B?QVFHYUJxMXJHck9lOXpSVjRQU0JDQnRkRk0zV0owa2oyeEtBQzBaU1ZaV0ZD?=
 =?utf-8?B?YndMUHBVQXJkbERDaGt6aWNMeUZkQ05KTUZwWlk4UG5tSVVybXNUV2pXNktz?=
 =?utf-8?B?SVdKWHRjWTdORi9LNzl6amE2MmJJWE9BK1lTRU5pRWlGdWtERmNsYTZLcUpQ?=
 =?utf-8?B?blpzVnNXUlVoNlFwS0xnLzhMU0FWUWFpcnE4TmJRNzFLbUQ0RXdkaDBDeXZI?=
 =?utf-8?B?dlBSS3dzeHpLNVFBUk96aXhVbkdVUjlqUjFLdVRDTWg2MWNZWllLdkV0d3Fs?=
 =?utf-8?B?R1AwN09kZUhaUlA4eXFTSi9DRm5YVVdtTHAzMGEzdmg5djIvclY3SlpsNWMv?=
 =?utf-8?B?eGVXYVJuVEdCc0RHR1hMWUdwRWo4UFJuTk1OYzFCL3h5QjZ4MC9vU2pka05B?=
 =?utf-8?B?ZzRndDBZWnFkUkZBY0ppSXFiNHRYUlJPY0tMdUNoZDZFdjRSVkVGeVpEOTBw?=
 =?utf-8?B?Z0szeDlsd2dCNmk0Snc4WTYxeVdkcFRMS2VDRHVyV1hYbzBydzRUZFlPTDU3?=
 =?utf-8?B?NXBWV0VQK1c2bVFNWC8rM3J2dVlrR1MxRE9PSjBZdS80dENEZ1pSQmg0TzBL?=
 =?utf-8?B?Vy9DZGx4MEFkQStoa1MxaGZOeHNJTkxxTWc1T2tUN2JQbDNRS2hsV2RzdmFi?=
 =?utf-8?B?T0hpbVlVY05sL0N4SWpDeGVjOEEwdnZsMDR0ZEhlVU9pZUJONkZ3TjVsNEdU?=
 =?utf-8?B?R3ZqUVM5endrVlJ3d3JZaENHeDZGZkg2NVpjd0lqVGsrZndvU2E0R2N2RGQz?=
 =?utf-8?B?cCtPYUFSbmliWStMRTc0ckFScnF4bTJhdm5yMEZ4NVNvTzZKUWN1dUcvSUtr?=
 =?utf-8?B?b2lPRXdRc3p1QUd5VmlndU5PYStCMWtKMVZXSEJrWlFKUGpZOC9VVzYrbDFm?=
 =?utf-8?B?aU9oOWxIR2ViWkJHQitlNXJZLzNhbnpZckNNNTV2V0xhZDhodDNFNExSNk9W?=
 =?utf-8?B?aFh4ditRVDk1dEUxSm1GSEhWUEhTWnpFVzlHUml1a0doeTJKclhYaDJWRUNS?=
 =?utf-8?B?VnlmelpkMEpZenFROG4rWjV2MDJPeHhQWWRDdGtSKzVGSjBKZFkzWUlDYldu?=
 =?utf-8?B?d3dXbTZyTEFWNjlaM0RsdXRpanRWWURibHl0N3ovZ3pIcXo0TlZqeHV2WVBX?=
 =?utf-8?B?am43S0hMVWJydkw2K2hiOWo3TVJEb0JoY0JUdEVsMWU2KzJrQjVLT2F2SW9x?=
 =?utf-8?B?YmRjdHNNclRzSWVuMkgzbWNMblh3by9VK09GOXlwMEVOdk9KWkk5MEJZSE8r?=
 =?utf-8?B?L0FJZi9zSTYxbFZmUXlHbkFWOUdxUGI3WmdtcGhZeXkrc09KUjNObytTTjRV?=
 =?utf-8?B?ZnJVZGxGcnVFcVdWcVZ4TzEzZHBFaVU5RjF4YUxFUEJuc0t6YlV5UVhOMzZL?=
 =?utf-8?B?eFU0MVM4bVArUFF0bEt6QVo1ZWJwN3d2L25RSGNoSVFGNDM0a0ljSnpqM3B4?=
 =?utf-8?B?SUpmZEdBczdhZ014R1QvQWQ0RHBFUU9DM0l3R0R2MS94SVBCOWNabnJ6QjdU?=
 =?utf-8?B?dzhaWE51dGdkUWhQY25MZ0M0T0poV2NsNmtlYjVvNEJQek1BMGNqVTZjdjdT?=
 =?utf-8?B?RTFWdFdndUY3K2wwYmlkTFFDd05ZTjQyNnhRS0JpV1o0YzZVa2MyZEJWZ2NQ?=
 =?utf-8?B?TVVYVzJHblFzOE54bTFsSWtXY0FySnQ4aDZXbkpndVM5TTJOZklQUjlEQ3lZ?=
 =?utf-8?B?VkxSL1dXVnl2WkVFcFNhWnhTQ2s4cTlsVVM3azdxZURGdmVaellUNEZFYWpj?=
 =?utf-8?B?dnZvNWtjNGJocTNydTBjdXppdUxlTkZVeDBoNkFqSmZCY3AvNDRoZFo4elJM?=
 =?utf-8?B?bDFhOTVvRW43R3JEZ01naDB3bDhZR1QvZ0I2WkhuVFZOQWZmV29LdURwL3pP?=
 =?utf-8?B?TGF4QzZJeE5YanQrMC9PdXV1ejBuSURiY0ZGRy9WWjkzYWpKd1lMSWRhUXg2?=
 =?utf-8?B?US9pSGE0aW9LVEJjR1dRT2hKcGJwVnF5Qm1uUzY2VVBWKysxa2xvRUs2bFJI?=
 =?utf-8?B?NHpVSkh4ajc3aHJPWVVQSWd2aHpCLzRQZkdJVkFkOVdkbmxMY1JsTytYdnli?=
 =?utf-8?B?MVdDUmUvdk5TSnQwVjh0WkoyM0xHWGlPb1pKaVlDdHFMc0RPYk9melNSVE5z?=
 =?utf-8?B?YWltaTl0WC9lbFl0bDJ1ZjRYZ3lOY2Y3bkNIdSt4dmhIMVlpdEJBVEpvNjBB?=
 =?utf-8?Q?/xE/x0i/q2y1pdOk7l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e138264-7fe2-4478-e4da-08df01e40396
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:31:33.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4YbYfzhKCqqNpNcdcLfeHUieo/n1m6JIrtHZYnjtFvJcyRW/ThLSIqVV0dbv+Q/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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

On 8/17/26 16:17, Alex Deucher wrote:
> On Mon, Aug 17, 2026 at 4:07 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 16-Aug-26 10:56 PM, Priya Hosur wrote:
>>> This patch adds heavy-weight TLB flush after MES queue eviction/suspension
>>> to fix SVM page migration hangs on gfx1151 with XNACK mode enabled.
>>>
>>> v4:
>>>    - Dropped userq TLB flush patch per Felix/Lijo feedback: TLB flush is only
>>>      needed after batch unmap in amdgpu_userq_unmap_all(), not per-queue unmap
>>>
>>
>> Sorry, that was not the intention. I was thinking there is a unmap_all
>> API in MES in which case this could be done within FW itself instead.
>>
> 
> There is a suspend_all and I believe the reset detect and
> detect_and_reset calls end up suspending all queues the type specified
> (gfx, compute, sdma).
> 
>> I believe Alex was also asking to check about batch unmap cases of user
>> queue. Ex: - amdgpu_eviction_fence_suspend_worker there could still be
>> inflight transactions similar to KFD case.
> 
> RIght.  When we evict a KGD userq process, we evict all of the queues
> for that GPU VM.

Yeah I completely agree with Lijo.

An unmap operation means that the MES *must* make sure that all work from the unmapped queue is finished. Usually by issuing something similar to an EOP packet/event.

A TLB invalidation is necessary when the debugger wants to attach and we only suspended the queue, e.g. in other words prevent work from continuing but doesn't take it of the HW or wait for it to finish.

So something here is clearly badly going wrong.

Regards,
Christian.

> 
> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> v3:
>>>    - Split into 2 patches per Alex's review
>>>    - Added userq TLB flush in amdgpu_userq_unmap_helper() (amdgpu_userq.c)
>>>
>>> v2:
>>>    - Removed "SDMA" from comment as this affects all in-flight memory
>>>      accesses, not just SDMA (Felix Kuehling)
>>>    - Added Reviewed-by tag
>>>
>>> Priya Hosur (1):
>>>    drm/amdkfd: Add TLB flush after MES queue eviction/suspension
>>>
>>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>

