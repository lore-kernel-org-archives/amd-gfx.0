Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A85AC83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 13:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0271710E292;
	Tue,  1 Jul 2025 13:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lbi/42En";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9C210E292
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 13:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR3Xy3RGA6RvTY1AQ/ejQnrqSW3mYpWVJsAYuPC+0qlD9rTPCwEafxymxq3gHUimWdx0viLnBS03+1gh4cKuFD4OxkuDNqicyA+wtNMdsZY2qaaJfjlx70gY4efyumgSnyUZRaC1CJv6kayMzsjLYTSxOBJYqwlmGw9yRIlQh5CI2qFIH0RIR8ZMM/fdyyq34N0ggMMP9d3DqrU4k7cKbCJOFDk2PRHYr1lu3cxoCM+Wmfw7Quy5E4lN/X+0qQxd11gLmjfuOxV+vVaP7b+sWuSX6QpYTGOvtDZoZHgX5C0oS3qGKIaN7qQ0ZzfnaH0cIU/61hNuYzsSrGs3r/Y9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8X8SaQZjv5ADY7mZEAyHP2Rn3vcCbsWe3O0f334o/g=;
 b=CbGjqWL1U02dGGsSUUVOWUgbMlYlq932M9eGSXgzuiZeKxV6RDnNvWaTmy42doqU1IX3f/WNA0m+vnMWaOVWZOtiKBygaEULjSbU5o4XHaEtSGhbVlzb2muGr/mfLyFpnE6SEWsrOz0BjPxbbO+R6np8ZTo0E1JotevhTObonQqKN1My93JO8yzFlnmQP9VGbzS2UZSRSAC6OMy8xWSBCRSER64SjF5aEQbQvvxhH1g+H62KrZLePlV2VNtWZFU9flAKeQVVN5NOBGdAhE2mUm7mVMBbMTfQ9dOMuvbHsQMi4xd7/j6uS5RUQQZOmNy+fY0hF5oc4GJ2vmSjVZqO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8X8SaQZjv5ADY7mZEAyHP2Rn3vcCbsWe3O0f334o/g=;
 b=lbi/42EnO6OYzk0owVcskoTSxCTsalporbSTzipu0kflUYf1pXVZEyCjC62uM5+kk9hEao69nm64oJVMdWOljrt4YDMqxG7oLnzy/KxXHkruQG9otbIT1uPuEqMdzBbIavArEO2ODrdl3D80eyepivtY6RrZ3iBwMYEKvG0LuIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 13:30:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 13:30:55 +0000
Message-ID: <84032389-ee87-4f7f-9acd-2bc809258a5b@amd.com>
Date: Tue, 1 Jul 2025 15:30:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] drm/amdgpu: add user queue vm identifier
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-7-Prike.Liang@amd.com>
 <faed435a-1f15-4a77-a66e-2e03062699a7@amd.com>
 <DS7PR12MB60053702F3897C9C2065B634FB41A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60053702F3897C9C2065B634FB41A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dd8da9-a628-4d33-babc-08ddb8a381cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFdpWUNqYjJVK25FZVhFcDVqQm1Za29ONFhZbUxNN1BWekhYYlp6aTA0RmhW?=
 =?utf-8?B?Z2tmVHg2elc5dllJcElxMU1jUVNuRkxpTmp1ZFZiRVBTOU1mcFd0aHhLMjkv?=
 =?utf-8?B?aWxjNlNGUVp1QzZPbzc0eG1XeE1yVTFLRzN3eE0wZFdVNnhhYlozbDJUMEhO?=
 =?utf-8?B?MUl2WHRBaEcvMnlkSW9ETkhWSWQ1MEdyYXVadnVleWpxd0hVRFY5K25IdGlU?=
 =?utf-8?B?cnZUd3Zzam9SY0dnbUcwZU5LUjhjRWtIbzZDRG56TWw4bzdLbHc4OWZCZW1D?=
 =?utf-8?B?WWgwK0dNcENWSnZKUjZRQ0JtVVVYN1VsaTlxSUd0Ni9wOE1WWGliOXNvajhY?=
 =?utf-8?B?em9JZU82OFErdTY2Um5JYjJnRDJsWTg0SUtJOFBlQ1lWeUUwbGtvakpvWkt5?=
 =?utf-8?B?dTVVUFlPbHllNkxnZmhtQ0V6UDNWc3h6YW5IMWYzYmFiYlREc0piblQ0MWdF?=
 =?utf-8?B?M0l4UW1YOTk2UWFjd1VjSHlKZVNiU0pmYkV1ZThwQS9vY2s0N04waWZSeSth?=
 =?utf-8?B?VnVnNUt5V2dEVGZVQ0p2WWRmTWdjMys0OE5ZWVFRcDdKN05HYStYUlQwMHRP?=
 =?utf-8?B?THlFOUpEcHlqSVh0WGozUzltS3ZVUzQ3dGVPM2lidDVsVnRUSXFkSG00NXNO?=
 =?utf-8?B?RlVIUTROcjRQczlWQ1pmS1ZxN3ZQM3ZZTnhqcjB5VUZqVnJxdEYrZkwwaUFn?=
 =?utf-8?B?L1o2SVdsc0Eza25JcE9WRFVYMzJYRlEyRHZiNVUxeGNqUnRYUDFmNTlka0Nk?=
 =?utf-8?B?MFJWQUJpQnVlRFZHM3pkY0o5WW5yWEk1QnhwRDF1WkpIVXMxS2pTZTdTdkVo?=
 =?utf-8?B?NjVReTh6WExuZlFKS211dmt0eUljNU93MHJrSFlhNjVuWlhEWWxEZHUwb29q?=
 =?utf-8?B?d05xRjY4ejBKNS9LNWhEQ3JzUm9NcFFaNTVvV3JoL0d2anlncjNLWFBuWkZl?=
 =?utf-8?B?NUhiakRBYUZMRUlheGhXWWxENDRxVEF5N2ZGUzdSVFFoMDJUN0ZTcWRydmRI?=
 =?utf-8?B?MVRmMElxcTJyTlVkd3hGamUzekxhMVFtM05LdE5ON0tIdTZ2c2J3N3gwQlJX?=
 =?utf-8?B?TDFwR3NnWW1RUFJjc2ZvMUxaV09CZ0ZFK3VJdTBZRkwrWjRCRjhIN3dWeWpy?=
 =?utf-8?B?SS9LVnRFYklPMnVLUHE3NmU1QUdaT0VNSWQ3K1BQUWdKV2tyNVNLQkRHSWxj?=
 =?utf-8?B?dXJJVXhDdWFWUUJ0bEFtWUQ0QnhocHBLV3ZIYzJzOHMrU0xJOTVVazRqVWZx?=
 =?utf-8?B?alZrZU9Tb1dsdllMaWVSZWZTbG80Y1BxdTF3cy96QWFWb1gxOW9hU0IvSzdJ?=
 =?utf-8?B?UEppRUs3N3ZFUFhKOUxJcnNMcXM3VnhSRzk4b1pKb3BVd3JvSDd1UlRXRkd1?=
 =?utf-8?B?UHlKc084U254NTFQQjgwdGtQNHJRUldsT3B0SHpLWnp3bE1xM2NqSXdQWGlj?=
 =?utf-8?B?cHl1eklkb1JMOTFxc09qM05Henh0aHMxMmRaMzVaWkVXdzh5UFpMbjVFL1Jh?=
 =?utf-8?B?T2ZqS1c5aVRQZTNmMjR6Wk5oVHdSQ1NRTlZhR1N5MVdIK1ZsMGFKOWMwZ25P?=
 =?utf-8?B?RFdRWWJNRXN1UzMrN3BJcFBxb0xEZm9BdjVBemErSkNOcUY1QWZhaWtJMldw?=
 =?utf-8?B?Wm92c09BOEowSWIvMTE3NFhXZFVZdnRDZlBQaklBT0dRQlphMVpEZVVHZVE1?=
 =?utf-8?B?TE5XOUhJZ0pLc1BiWHZRRkNyOHBZWm1kU0dMVUdPTTFnU0ZLZzYvRXA2RTg3?=
 =?utf-8?B?TFRoSFZMNmVlUkhZVnNBbEc4S2o2RDdNRjZOZWJGZWRLZStGOHBNMnYrN1ZF?=
 =?utf-8?B?VGdkamxQUXZiMkJFME94eENwVHYyUWUrc3hxdzJ5NnMvdlppemtIbUxWUjJP?=
 =?utf-8?B?N09UcHVqUkNzRXFXUHMyaFU4dW5XQzNoWnNCemdSbzNlT2xzOUUyNlM4SWN1?=
 =?utf-8?Q?zMmMbGi/Lmo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0s5RDBpNHRUSmVUanFyNm5CeFcvUVIrbDQ1VlZCMk5ad3hJejVZbG5qeVhU?=
 =?utf-8?B?clhQbisrRUZIbWs2TXlzb3l3aHNISjIrVjkvUjY2OWpuMmJOUkhNQ1pzeUZB?=
 =?utf-8?B?L1ZrTUJMd0hNaUlIYXlIdTM5VTBXZkttZU9ReG1iSWpTRzFLa2ZBOGtCR3dY?=
 =?utf-8?B?dVVwdDIweVRqN1BsSVlydE5GYjRvdGJJcGl0dlBhVU1wc01DbFRqSU9uTXd3?=
 =?utf-8?B?UVQ5blZkM2U4WktxWkN2Q3Jvckw3NitxWEFxdUhRck5tUTFnSlVSQXIySzVQ?=
 =?utf-8?B?Z2gwRFdYUVFnTXJPUkVCemFUNStnWWp2aElGbnFwN1FMaXdaMHRRREkyTHVU?=
 =?utf-8?B?WnlNQUxYRXdaVkZJcUR1OFBFcVFmQ2pOUklXZENwMmM2TGwrdHhqcjJWd09G?=
 =?utf-8?B?a1JueXpNcUlsMzBSZHEzeDhuRDZkMG5UdUpXbi9DNFVnbDMzQkwxTkJsVkpo?=
 =?utf-8?B?cGI2NXNQN0ZTaG1Cbk9QbWtxdnZRU3Q5YkxmZ0NVWTk3NlpzOVpzUE41VVI0?=
 =?utf-8?B?b2ZtZ2p3bUFJbUs3aFovSzdldUY4MmxpZkFSN0pHNHBxNDM3cWZ6NTZjaW11?=
 =?utf-8?B?cmVIcy9MdFJMR0VuWkhxUU1pbkRmSmQ5dkFVZldFZkg5NXgxYTAzNVBWR0V0?=
 =?utf-8?B?T21IVU1uNzhmaVl2ZU9qUWtCQ3YxVFMvN1VYL0MyNFcvbVZma2FMUTRScDVi?=
 =?utf-8?B?Yk5IRktKVDdxQWVyTEVQWitHWENkN09LNFV0akwxdlIvUXlucW1QL3M2TGtW?=
 =?utf-8?B?SXRlN0hEanpnRWZ6MzBTalArT3hyemphcmZwRUl4aXN0QU4vZGdyZWVteXBC?=
 =?utf-8?B?K3FteHd5SmpMd1Q4byt1UmZicjZlemZia0p1Mk94U293VWl2dzRlYnFTeE1I?=
 =?utf-8?B?ZHBJT3hTMEFHUlkwWFhZYnh5U0tqVE9TZmdETVBlNk96eWllSGZKV0pHMDlK?=
 =?utf-8?B?UnN5WGdpVUw3OTBqMy9pcmVuTDJHaUVSTjlsM0JNdi8wUm42eE9hSFZTQnJ6?=
 =?utf-8?B?eW05Q2hjeVZLZTJZQ2Y4T2FVbCtzeWY2ZG1iSVE3T21lQUV2azZWUXEvK3Nw?=
 =?utf-8?B?ZG5xajZyZUVPMmpSdTBqdUNkQ2I4VUNhYlcxR1M4dTdoM1ArSzNhNmFDcVNU?=
 =?utf-8?B?RHQycDkvYnZ1clBOWG5WRzAzVGt2TlJKcVhJSDNxTEx5UTdjTXNmWEFvTUxx?=
 =?utf-8?B?R3U2TTlLWmtXOXNjZERmR1lvV0haQmJkVDJ3VHJHekJoZm0ycy9Bd2tqYVUy?=
 =?utf-8?B?SFptYUp4QU1XaXpPTkJXL1BYRnhBaU9ML0JQY3MxL0Q2cHQ4dEpFVEdWelFq?=
 =?utf-8?B?WDdGTUZGUkE3NW1BdFFqVHJJK0hGc3B1blgrbjBuOG9XNm11OFdFRWsyTUpi?=
 =?utf-8?B?T1R5Ulp1QktvQ2pWL1BLQXZTajF3bzBHeFJHamlvVENlYVNEWDVOL05jY0Va?=
 =?utf-8?B?K3loY2lOTk4vbko1UDZob0daM1RVeXJieUJBNFJjRlVjMnVVSUxWVHd4bGxs?=
 =?utf-8?B?eTNzLzZzRG5zVEdmSnJmaGpUNjNjYmF1RTZsMVp2ZDF4bTV5bXRLcXZtcWtG?=
 =?utf-8?B?RWFzQjZ3dlVLVTNXRElMVXFjVFE3ZmZiWFM1ODBhSllpejBCMVMyd2h4YklD?=
 =?utf-8?B?MzIzTGZZd2ZTUVoycUZnZXh5amZTcW9GQUFQSEgzekJNUzd0Wjh1OEp2VE5s?=
 =?utf-8?B?S3JKVGJxQXhRL3lkaWVsaVh6c3lOS0dPeWh6Y2kxYzFEUkRNTngrSTM4Mk9Q?=
 =?utf-8?B?VFNQMk1laDJDL0ZoeVNhZVRWVjB1d3RndzVaNEczU0pEWFVHcXlwZm02MkZ4?=
 =?utf-8?B?NFU0QUZ3dmtxcStJSnhEYWV2NklIYUZsVWhmbmtYVG0yY1g3ZHBZeTQwRjlm?=
 =?utf-8?B?eEpuYld6emxQZXFHQmloOEN0cVgxZE5FZFBJc1liN0ZiY2MxcnVrTmZTd0JO?=
 =?utf-8?B?UUZsRHJQVWhVS3RMcG9nVUpSYjB0TmZqR0pRSHFBd3ZlVjFHMFZ4K1dKazNz?=
 =?utf-8?B?SlhOQnFidDhvLzlaSXhiQ1JGNjFINTh6Zm5PVUNDWFpFOEpzN0Rqa1FWVTM0?=
 =?utf-8?B?Vy9FK2x1QmM3SUtSdC9ZdC9abllZazNIeVhldzdtb1ZNbmhkVHdoc3ZwU21B?=
 =?utf-8?Q?eXmM/bd7xyeI4aO/TzV5q4/pk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd8da9-a628-4d33-babc-08ddb8a381cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:30:55.5069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfnwbHElGbqjmdLXcIYWji7nj+zCUuI7t4Ib7CE8YUQ2Tc0DF6CUrfz1SGqQOPh5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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

On 01.07.25 15:12, Liang, Prike wrote:
> [Public]
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, June 25, 2025 3:52 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v4 07/11] drm/amdgpu: add user queue vm identifier
>>
>> On 24.06.25 10:45, Prike Liang wrote:
>>> Add a user queue vm identifier for each userqueue kms opt accessing.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
>>>  3 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 79b263c18eb1..0208c6b8a8e0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -501,6 +501,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> +   fpriv->vm.is_userq_context = false;
>>> +
>>
>> I really don't like that approach. The VM should not have any special handling
>> dependign on if user queues exists or not.
>>
>> Why do you want that?
> This change is using the is_userq_context flag for identifying the user queue task to see whether it has been scheduled, and then
> further used for handling the sequence of attaching the eviction fence . The eviction fence is only available when the user queue
> process is scheduled, but in the amdgpu_gem_object_open(), it always attaches the eviction fence to the BOs regardless of whether
> the eviction fence is valid or not.

That is intentionally done this way.

> Based on this flag, we can simplify the eviction fence attaching sequence and only attach a valid
> eviction fence to the BO.

That won't work and is over all unecessary. The eviction fence is a no-op as long as no user queues are created, but should always be attached.

What you do here sounds like it is racy as hell. Please completely drop that approach.

Regards,
Christian.

> 
>>
>> Regards,
>> Christian.
>>
>>>     return r;
>>>  }
>>>
>>> @@ -535,6 +537,8 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>             (args->in.flags &
>> AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
>>>             AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
>>>
>>> +   fpriv->vm.is_userq_context = true;
>>> +
>>>     r = amdgpu_userq_priority_permit(filp, priority);
>>>     if (r)
>>>             return r;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 3911c78f8282..5e075e8f0ca3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2560,7 +2560,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm,
>>>     ttm_lru_bulk_move_init(&vm->lru_bulk_move);
>>>
>>>     vm->is_compute_context = false;
>>> -
>>> +   vm->is_userq_context = false;
>>>     vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>>>                                 AMDGPU_VM_USE_CPU_FOR_GFX);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index f3ad687125ad..1e3c0f85c98e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -422,7 +422,7 @@ struct amdgpu_vm {
>>>     struct ttm_lru_bulk_move lru_bulk_move;
>>>     /* Flag to indicate if VM is used for compute */
>>>     bool                    is_compute_context;
>>> -
>>> +   bool                    is_userq_context;
>>>     /* Memory partition number, -1 means any partition */
>>>     int8_t                  mem_id;
>>>
> 

