Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686B5CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC9C10EACE;
	Fri, 31 Oct 2025 08:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3i547dyf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BE910EACE
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBe6UtdoKmpRuPVVdGxMOu7FPvPxHi1J9YiMajXwvmDfSzBK87d6/KSNLXly8dRIuUH+Qz9p9+DPnI8XwNe3YjSuh8YvC35zsIPcHMApptHuVVu/0EhYKiWQy+4Wy0FeGx6kbn5LP8eXqpuWYQ8W2+WY6abtwPkZSQgGjVKge08sxLu4PGy9VVfdkL1C5+NoIAxwi1FWY7G9j/y2IGwaAPfmh4/667rIuzRIhI8ZoFZKD5UoR4qVtKEiun9RZ24s71FP2IyyiAJImtttsnNL6keeXztP/NXPgVKFYHH4h7goJyklzqX8tC/7Nl14WNa9n8b0TjHOYqzVNtEiUtiIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6xfa6FSAmI/Iz4pZCFBRmT7oQFUB8Pqn3R0G8G/BaM=;
 b=GRM/HYuoKv3Vlub7MvrN/oknOr8oTm5T26cr7L+N5vYVzFYVKBWCcQV4STJ2hJ1T8AhrBcl0YizR+juGehXEqergs5cGveQSP6aaWjRLDOszy41dIgAjSr/K+0ofU/MYHT2TuRwMptEfM69aYOKZzQhmFveCKv2opLGuAdUxSE3YPc5YX/RqN2kkSdP1AYFLLvZ5yRCC4+eDCY0KXNR6fTvv0+Ig01/DbPhFsDcmpWnvo313OPkhHyRynigwv5TmvzoIqdPra5zfptRTZlgR+kq4CUZJWpMDJADh2bWyjLOPWuMzVHVdOO7PQ7rDWm4KW+dsz3uEfXIWPOuepFap6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6xfa6FSAmI/Iz4pZCFBRmT7oQFUB8Pqn3R0G8G/BaM=;
 b=3i547dyfeVPXEw7dyRyDYvvPgJlkxBVDt8p4n7xZ7hjD1qQGa3dcpUcZwMhds8D7K8npJzZw4hrMR9JDuyQHaHSzTqiL6nVrrZUX1dl6KPVoU7UEu05JvuNq4RjGCdGjbQqPo9IEiLjl9y6xYC1cgOIRKGDyeFH4CIIRQJQFWTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 08:41:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:41:59 +0000
Message-ID: <cb246b08-c8b3-4095-b94f-dc72dbb3b375@amd.com>
Date: Fri, 31 Oct 2025 09:41:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: grab a BO reference in vm_lock_done_list.
To: "Khatri, Sunil" <sukhatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil.Khatri@amd.com
References: <20251031082531.32715-1-christian.koenig@amd.com>
 <6ffc1416-ae2b-4ab0-a602-a3f6711fa213@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6ffc1416-ae2b-4ab0-a602-a3f6711fa213@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9322470f-825a-4f82-da34-08de18595ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3lrTzZpTVduYkEyK2ZBQzJUMkdPMjlBdVlHS0ltclZZZWdnUnVyZXBqZ2Fj?=
 =?utf-8?B?ZVQ3d041MnZSS1JGa1ZqeFpWQS9mV2piV0pBQWZkcUVLME4vaHFIRDRDZ21D?=
 =?utf-8?B?OUlQaG1Lc09oUGVhbUNNSU9RM2ZVZDZLZ2M5dTFxMFRLdi93c3FNL09vY0NS?=
 =?utf-8?B?TWJTWVE1V0JLQ2ZUUkZKcjRFZEZkRkJYcTJXdjJtbmFsY0ZIQ1VydjdiSzAy?=
 =?utf-8?B?ZCsxTTBURmlYWWVYU1FzOVhqU091dnF1Qm5nVG13WTlCdEpIa2ordFF4RnBP?=
 =?utf-8?B?QlV0K3RoakxTVU9XSXpEZ1dLRmhYblZ5bExxYnNrODFOMEhqdmZyWkNZdjl1?=
 =?utf-8?B?ak5VbGtYay9HcS9VNk5POXgwSFNUaU5vczQ2d3lId1JTaHdyRldGaVFaTW1r?=
 =?utf-8?B?VU5SUUw4RndwNmdtYmdkUFdFcVYxZnBVMkNCTHk5Z1VkREkzbUpseU5uSlE5?=
 =?utf-8?B?U2NTOHlkdXRtVG5XdVhUNkZEQXoyTzJIRzlDeXQvMkxGZlN4em4rTXEydVk4?=
 =?utf-8?B?MW9ZSElxQVVwcE9wcVNVSDhhdkNIdUtFMXNNOHQyNVlyd0JiMkhoM2NTT21Y?=
 =?utf-8?B?NmQraUMrTzN4VWFpd3RHdUNCRjJkNDhUa1lWMmh1eisyQlp2dFJ0SCs1YUVX?=
 =?utf-8?B?MGE2dFhzb0VjeXVJSnA3L2czQUVNYy9hNGExQ1NQbTNpOHpMYXo3UXFxWi80?=
 =?utf-8?B?OWhvQ3ZMREsyM05qcGlPV2Ryb2g1ZGxkT3g3WGFHL3hiYUFxT3hGdWp3c08w?=
 =?utf-8?B?M2xiQVpya3ZLNlpZWUo4cXM0WGpzNjVZMHZXYkh1UkhJdmQ2RVpOQk11d0Ji?=
 =?utf-8?B?dHUycklUT01maWJaT0ZwUURTRHNwQkZ0U3lxSXVwZFgyVUxMV1RuZm5PMDlN?=
 =?utf-8?B?M2UxbmtxeWdLU1NUbG9MVkMwVzVqY2w3OUVUdXdud1RUWVlkUmpEVmdjQTEv?=
 =?utf-8?B?VHl4UWI4a0tnelZkWmpsamFhNFVUZFhURGN3MTZvUmp5Q0xMQnFGRW5kdytQ?=
 =?utf-8?B?Z3RBWXd1bHozNFdJblE5TjdNS1JLeGFxdWZjT2Qya0Rna2U2R2xUTXNtdURn?=
 =?utf-8?B?aThPa3hObUtxNzIrcjh6VXdHMEJ0YTUzZHNiaE9aazRadDhPTWFTNms4Y292?=
 =?utf-8?B?bWFKdWpxOVE3eGxUaHp6eVUxcFZpM2VpYUxJOGpWT0oycnZ4RWZnMm1hS0RH?=
 =?utf-8?B?VVplMUFmME1vN1NsK0R2ekl6aHM4bDVOMkdkYTA5QVpTd0tWMWlnWGY4bFVM?=
 =?utf-8?B?K0duRWFWSVpRc2ZseVBSdHRpQzhrUDFsd3lubis5cm0zSmdLbExHRVhKT040?=
 =?utf-8?B?SHdPcTNrZnNCWExRRUQva2F4N1BkdVlndFNBdU8vN2poNXVYN1FSb2E5YXJG?=
 =?utf-8?B?am9LWUFRZC9LbWQ0NDJHbFNsdTF5Z1psTDlmZ1M2cEI2U3dNamJSTWwwU3B4?=
 =?utf-8?B?bEVkWVVybzJHZDEzcllYdVNLdXpERzQwWkVSeitiTTRTcWQwUGsxTEZHeWhx?=
 =?utf-8?B?dEdpbFFVbFpocm5qeUptYVlNUEJlRVhPL2FDOEs5VDFGZXdsdk45UHhocnh2?=
 =?utf-8?B?cFBnc0ltbTlDem1lNDhUKzkrSDRveFljWHhIT0svWjBzL3dYODlCUlFkeWp1?=
 =?utf-8?B?SXdSWjRydDNZRjhtaml2blhhQlZZNTZzdTQwYVRTeEEvWGV4T1ZldGl4Sitp?=
 =?utf-8?B?Q1REdVVleTJRWmRER0UzcjVCbHp4Z1RpMDYvUFJTRkN4WGwxdmU3c2ZWKzha?=
 =?utf-8?B?bWc5T3VuelN5TldPZ0ZMWEVoZ1dTOVU5aFVTSWxRRUpPWitiVXlvdlY4L29Z?=
 =?utf-8?B?WUt1RUJDc01CZk1LSjlQSjBnZzJvWGJLNHZkdk56TFlvR0tFWWFIZHh6Zngw?=
 =?utf-8?B?azNNUVJKQ3lUcUE4MUhwSEVMQW5lWXZIVEpDazBNQzYyQ2loSm80VVFsUjYy?=
 =?utf-8?Q?xYGm8HRj5XFHpOyp/2mvJR4eQqEizLuy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRSSFVvU2p2RmRRT1M5R3dndnkxOHk0Sytac0tpYUhVMmFnYzQwU0xuaS8z?=
 =?utf-8?B?MitUMEVTYXYvS0hSVUZvZWhMeG42YWVzK1pzNHRmR1FCZS9kMUF3TUh1c3kr?=
 =?utf-8?B?V2lGSjh0UHZ4QTluM2p2OEhxdFdZQ0o5UUNxWE1xM01ia2dTb3p0T3ZtWHIv?=
 =?utf-8?B?Zno0cnN1b1BPSzRjMDlsei9SWTZWRjRMVFBmOHUzMWR2ZVJmL05od3NDcytH?=
 =?utf-8?B?clI2MGYzVnZmVER3QUpoTk9Wd2pXNitwWnYwaFNjbXllaVBlcTdlSXRWREMz?=
 =?utf-8?B?akYrSUVkbmozM09OZ0JDLzhPVWxIQ3Z0ejFuUjR6LzdTYkhnbnozcTBDdjUw?=
 =?utf-8?B?dnZNc0RKOEswTUt1MjhJQ01LajQyTW5DR1ZWSlN6V1g4eW4vT0xFdWJKNWdy?=
 =?utf-8?B?b3FEZ0lLdmpSRGZQd1hDWmE0bXo0SGlROGNMVlZsbyszRGhlK29KWjFVOU4y?=
 =?utf-8?B?UjRCU3FocWdUemhIckVuekZMTzZCZG9MZGhuQkJKcHhkSFVnWmJEMzk1eUdP?=
 =?utf-8?B?NitBRUlnbHUrejlVYU1KOG5oOHZMYnVTQlV2dkZqdTBCcWNSTmdkTS9Oa2dx?=
 =?utf-8?B?bmNUZjR0WTRzZnZZSUsyaTZEenNnNHN4OXhIbzV2QUdNUmU0ZW5WWUhGS2Uy?=
 =?utf-8?B?QzQwNUJjUnVDM2NtbVdjOXJLdmhIdmxxZTlKMkd5VXY2ampTWXZIVlB6MFIr?=
 =?utf-8?B?LzJIZXAySjd4NE1EUU5MTzVQY0l6UmhyUFFjbXVBQ0E1QkFVVlZUd0M4UWV2?=
 =?utf-8?B?OW8xNkVIS2UvYytFSU95cFVCV3BINTZqdy9WR3dZRkljdjFDKzMzV2FTYXo1?=
 =?utf-8?B?VmMzSWlpQWw0b2FFdUlNTE1HUVlyS2lOM1FwQjN6eFVkdTZnV3I0Wk1QaVJy?=
 =?utf-8?B?QmJpUVBWUElaYzBZZXhFcC8zcWRVbTlpZURjY0ZUKzNCQlo1VGpFUEJGWEJs?=
 =?utf-8?B?d3pSWThad0xiWVN4aXRUb1FnSDVFZGRmMTFlNExZdWNYcTZNSE9XTURTQWFC?=
 =?utf-8?B?RU1YUDZ0aEsyR2VtbVpVbWY0V0QybWJIaGlkdjlqQ0Yxd2dRZnBDTERxcW1t?=
 =?utf-8?B?ZG0xY0h1dmw0VDMvQXhiYVVweVV2TlNLam9VVXJuNEdqYUtiQUtmNkQ1Y1ZC?=
 =?utf-8?B?RXg3UUJrN0UrL0kvNVpMTnFTcjV6Nm1RL09PeEpWTjJXWVlMTnFXMkR6QU01?=
 =?utf-8?B?RlhJUnBiVDYvSmU2L0U1c0llWFZqKytQRnQ5UXlqOUZWdkV0VzB0Q3ZmYW1H?=
 =?utf-8?B?VTNBOGZtSUJ2U2NLMmdnQWNQeWc3TEhmWGl6WTlOaUNaK0JoRER0UGFyeCtK?=
 =?utf-8?B?WDZITndrNXR6YUx3Q2lOYi9JcC9jck9SL2hLWlpKM2UzMElldy91M3FvR1FL?=
 =?utf-8?B?citUUk1IWmJjRUhHQ2hod0s1bzhyUzF6ejdWd2pGMFFJL1ZVVzd0aU9EYXlr?=
 =?utf-8?B?WmNvVUdWMEJTa3NrVmNIeDhTR09xMG1waDYyNTZRMTRwL1lHUVpSalE4L3FN?=
 =?utf-8?B?SXVXNVlhRmc0Z2ErSExVazE0Rlpic05xdGh6Y2dKM0JqTjJZZ1A4TDFEaWNH?=
 =?utf-8?B?VmFFcldRU0hBSjgyeXArRkRjbnFCb09JSThtUTc4UjgxTDU2YUtoM2loa2gv?=
 =?utf-8?B?aFpOcnpaazFtdDNKaGhwemNRc2NtVWNEei8wS0NaTHhrWTBHOHNxVWd0M1NR?=
 =?utf-8?B?YkhPVGxyVnFUQk1VYzR6eUF6S3NDNk5QK0VQUTFrYnRETHJqRmdJVXpoUXYy?=
 =?utf-8?B?dnd5b1BmVkFwRjBnWi9aRmRKaFhIZ0Z5b09uYU5kc3lEU0pjc1c0eHltL2pn?=
 =?utf-8?B?aGp6Y0JtQWsrelZTeG81emhaekowOXRZWXN6cS8vSnZCa2tFcitRVmpTUnVK?=
 =?utf-8?B?Qnl1c1VENTZ1WEFpMDdjbWp3bXE5RW8xWW9PMlV4TDlXc1dxaUZZM08xc29x?=
 =?utf-8?B?cTJJUWJUdk9sQ055V2lyZno4WFQ0b2VhUkhVVXJLYU9jRkN4aktYbnk2UUR1?=
 =?utf-8?B?Mi91UlVQRlZRSlJCenV5TllOS2x3ZTlFYXdFWno4ajRjaExYUG1GcFV3bGVa?=
 =?utf-8?B?OUVpOFowYS95TGs1TW95Y2IyNytCRy9YVzhwTi91V2wyMk9EVDA2aFhHQXdI?=
 =?utf-8?Q?RKgqc4Dn1Q2eFx0oA9kizmhCw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9322470f-825a-4f82-da34-08de18595ad7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:41:59.2259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dct+9+3a/5LDy+YA3pgxkLSI8IxU+qC1ciorLGqthQ0TjOq6Fh0Hb4qKOKrtYVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

On 10/31/25 09:39, Khatri, Sunil wrote:
> 
> On 31-10-2025 01:55 pm, Christian König wrote:
>> Otherwise it is possible that between dropping the status lock and
>> locking the BO that the BO is freed up.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index db66b4232de0..c3dfb949a9b8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -484,15 +484,19 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>>  	spin_lock(&vm->status_lock);
>>  	while (!list_is_head(prev->next, &vm->done)) {
>>  		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>> -		spin_unlock(&vm->status_lock);
>>  
>>  		bo = bo_va->base.bo;
>>  		if (bo) {
>> +			amdgpu_bo_ref(bo);
>> +			spin_unlock(&vm->status_lock);
>> +
>>  			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
> 
> Just for my understanding, there is a possibility that a bo is free after spin_unlock and we might be using a stale/NULL ptr of bo.  So we are taking a reference before releasing the lock to make
> 
> sure the bo is valid. Now calling drm_exec_prepare_obj take a recount to make sure the bo is always from now on.

Yes, exactly that.

> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Thanks!

Christian.

> 
>> +			amdgpu_bo_unref(&bo);
>>  			if (unlikely(ret))
>>  				return ret;
>> +
>> +			spin_lock(&vm->status_lock);
>>  		}
>> -		spin_lock(&vm->status_lock);
>>  		prev = prev->next;
>>  	}
>>  	spin_unlock(&vm->status_lock);

