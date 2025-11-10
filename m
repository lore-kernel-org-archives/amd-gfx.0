Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B5ECCF9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Nov 2025 16:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5874B10E03B;
	Mon, 10 Nov 2025 16:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1MA8UwWk";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010009.outbound.protection.outlook.com
 [40.93.198.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97DCF10E03B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Nov 2025 16:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm2kAYsOyt64hUEl0gpyTRBG4jDl9TwJRgD1aaq3RBUifZKAiVq1pjTL3Dz8GEO7ow7n+C7FU/RFqynTTJSw/WC//T2T4BvT6y7dQeEm3wrjJ7ee+YNySFwXk55D33fKW4grAQjgWyJ48645LMKaGB3IpojWB/xqM2raYnNhqeZj5/S23acXd+8ZYrdYBmwGLgpBWsX+l5/nf6+BfFtYpf0of+GycuMKUb8ih/4/V2LBGO9A4/1Nf0f8X4sLs+RMBZGq2Ldqr89Qp03RPpCeSvuuvJTERGRx2ZglzCX0jhglAUL+DbtOOSo3GK5lZ5w/S9MdqvxBMMekuyLrkXtRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn4tGZ0cJow2OkVLmphf0X5jt7t5tCXdLGdXVS9cDBg=;
 b=d/IBpTtiymqBiJeVGTvWzrla+Q39oXn6/AmQV+B4ySSZmzPOjjgmdI3IFP+yLPqyF0/pIUiQuh5JIrMBQpvvKcgTmhUjrFZB2xUahnRZQ0DNGQavZkS54QxQuVWNz1Rq+NLkakFH+jdBUa6TNl46KQ5FCPzvzVz0ueNFqS0/8EBQFlJv0XzOroFD1Cx1vHEV0/AKHCBwv8KRL3Yt+lntTL6pn5yZb3Wjzt5mWCCcejwfOtRh+geFsc/mcmmDLBEHqxvVT6vAC+EUvkl0J5Vyr7eoeDQzyUigYyGBqvd6j8sRu9Rax/5QozMpCwvhHw+lJKByWvK5KXE3vCz3TGO6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn4tGZ0cJow2OkVLmphf0X5jt7t5tCXdLGdXVS9cDBg=;
 b=1MA8UwWkxOhk6XbRpv8zxPPJV2gyxXqNrrnui3cnXjaKeug7NaJEjmeJHovTkiGQh+BqSjOF+DL5Ggg5+yf1nl0FakpId8C/LMb3CASxG+r/N3OaqId0BsJ5p4uGX3uH6Iu8FxoW/XGPHXUtgBAgBTZ4n45tYoWUG2xlK468eNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:49:33 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 16:49:33 +0000
Message-ID: <50b1de08-3531-03a6-2e7a-c0751dd49120@amd.com>
Date: Mon, 10 Nov 2025 11:49:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: relax checks for over allocation of save area
Content-Language: en-US
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Six, Lancelot" <Lancelot.Six@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20251108005717.3414138-1-jonathan.kim@amd.com>
 <SN7PR12MB7451001D3551BB2F5B39162E85CEA@SN7PR12MB7451.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <SN7PR12MB7451001D3551BB2F5B39162E85CEA@SN7PR12MB7451.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: e4db5c2a-14ff-423f-8fae-08de20791f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXpvYnVnRm13MjJxRWhSK1RqTjdHV3F0eEF6SS9QNXFkKzUzM0o3OU9QV3NC?=
 =?utf-8?B?djhUS25wZzdYZjBvR0swSVNFOXZCcWFnTjdEVTdXeisvWUZQUHRxN091WmVJ?=
 =?utf-8?B?ZGRZck9vZ3h6UEVYRVh2OFdMbktGQjZMa2svWGw5TzYzRWpWQm9aRlpGaUVH?=
 =?utf-8?B?em05d1ppZkJmcFgxdnMxS3NvNWc0WnZwM3dBdmdobS96eU5ZMklQdzJRK0lT?=
 =?utf-8?B?NEMyMHVCcjB5TmtBRlpFRzEvMjlPYzNydXZHQUsxcERrSndsTjFVVEd5eUpk?=
 =?utf-8?B?eWw4Rkx3bjRpOEIvYXRHWDhEOXh3R0kyeUVmWkkzbUJuTTMzSWhKeUhyb0RR?=
 =?utf-8?B?ZThDSllrZDJ1WnB1aHRMUWhNTFEvdjVGWmxpL0tERDVOdGIrSFNhckJIL0Jt?=
 =?utf-8?B?MVB4YVp6OG1zeTNXWS9ES1dmTzRBeEtBb1pvekNtaGFCZUxTd2VYYTVaeS8w?=
 =?utf-8?B?akw4K1NwK3VpQ2dmWThsTnl5aWNjanN0dVB4K3pCVW15QlBKeUI4b1U1Qlda?=
 =?utf-8?B?SDJyb1ZRVmJiaG8yZlVwS2hQN1dKeE4zZzBJTCswdHQ2ejVjbFM5RzdwZkxQ?=
 =?utf-8?B?QVJFOFUybXQ4YThMQWxGMmlHUVQ5Nk16a2psS0RlR1VsUFBUT04wMGxQYUwv?=
 =?utf-8?B?RUpzbzZ0aEdMWmd2MlowS01Gcjd4N1lZc0FxNCtaa0FRcW9naEkvNlQ5dDhq?=
 =?utf-8?B?cStsMUswSXczaW9FSWlaZ1JmbXNBQS81T0lxZm0waHA4aGI0a0FhQlF1MFA2?=
 =?utf-8?B?dFlQc3ZRUTdKNVJ1ZksvQUZYYVo3Um1HV2s5NllkNy9YRjBUSDh4ZHNPUmp4?=
 =?utf-8?B?WUxCeUFCZmZyc0JyMWdJeFRyZlRzU2dhOTUyUU9PcFlnVG85b2VUdXNUckkx?=
 =?utf-8?B?L04xbG9la3dxOE5mbWdBN0FSUityUHprdzdiYzlaOEtzblZzT0dXRE1RR1Jt?=
 =?utf-8?B?UUR3RGM4T2xhRDNZbGt3OVN2T2UxeWEyMGl1MVp6aTB4MlNTR2NFOERRaXNu?=
 =?utf-8?B?M0FTb2IzVXZIYU56Ri9WUVFNMW5XbXBjWjJKU0Y4S0owY29FVzZyTHZEamNG?=
 =?utf-8?B?NEdTUUFEdlVmemtRUzJmdlFQcmtXRzNnUDRrK2c4L1ZZMVRqK3dUdUdKQmhL?=
 =?utf-8?B?RGNTQStMTTVrN01RVG9qc2dxazBHK2VJeUJHR1JwdkpPQjFuWk9jT2Jhcm4x?=
 =?utf-8?B?SjNLVG5WZGpnRzV2ZTlONFdFRFgxbGFtMFhYeEtDWE5vOWRCZFVOQkZ0UjU4?=
 =?utf-8?B?aGZCaEhoNStYYkpEQjhwVFNhSk1mMkVtQzVhVFhyNy9GK2ZrTlA1aWYxRk81?=
 =?utf-8?B?cDI2YkFLN25HZWZNQVJ6L2FvUHNUeERpeXFyVG1KMWFxdlNrTjg5VU9ZUDhs?=
 =?utf-8?B?dWdIeFl6L21BRE8wRHY2K2ZuazhQZnEwRG8xQ0s5aUFKNVp0YW1rUlZmODBV?=
 =?utf-8?B?SVQ1Q1JrYXp3UXA0bThxOGQ4eGRIUVZYaXc1S1M5L1o0V3RaUVpZNmMwV3Js?=
 =?utf-8?B?cldDaE43dXlzcjRpQUJJT2JxM3lob0FSOFRWUlJVaVdYTGFDTElRK3FubjBh?=
 =?utf-8?B?R1kwWkQ0Y2Nhajl1STk3L3pFcXVnQUFnT2VXdmJFUERkMU95RVFuMUJyeFR1?=
 =?utf-8?B?SHNnV0hucjhqaHBvaHlPQVVaRTVpWWVhSnowUXNhZGJuKy9peVdzOHV0Z2hM?=
 =?utf-8?B?S0xldTRWNzlFVk91dDZ3am42WE1yTVpzM1dUbW5LYmxCeHhUQ1hBeFJJOWtz?=
 =?utf-8?B?N1BUSXVhR2pjM2k0NER4TW13NncxQVJGNGpBbUExeHMwRWU2N3B0TVdmN08z?=
 =?utf-8?B?THF1L2lNejAzL2ZKOGtJbWFFcytFZE81c0NxN3RmSTBxVGNqRUN2dTF4cG1I?=
 =?utf-8?B?eVlWZDZzeCtnVUVsamNLUlVJY0JFUS9EdE4yQXpsb3MvV3RrMkdYSmlqVVRH?=
 =?utf-8?Q?TmISAg3wDbjXv8TovCbxNpYSqTnOeU+e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkcvaEpjZXdvYURZcXNaMDBwRGR6Z2NaUUN0OFhZYU1JRk9HTU5ScnJ5VVh5?=
 =?utf-8?B?UWVUL24veUhyU2Z2UkpnVDkwR2RDWmV6VjZsUEdpYUlMWERLRVJzSnVDa01z?=
 =?utf-8?B?TmFFQVNibXcvWVBQZ3Qxak16cEY3V3AwK0FUNlY4bHVjd1BMSHo4QnNObDBv?=
 =?utf-8?B?b1BZandSM0d1TG9WOHZVTEVPMmFtS2dRaEhCbVRIb2pJWmhvUE15TFg4cUhl?=
 =?utf-8?B?RHZTblZudFVEb1h5OWVDNmgxLzd0NjFKNE1QUFVZL29nOFRpVDJXcnYvdG85?=
 =?utf-8?B?NUNQVWdSOFlRNWp0b08xcWlpNDMyejcyeFVVaXVkWWkvM2dYUnpVN1pFeTBM?=
 =?utf-8?B?dGhGdHhwaTVZdDlsaDBYUGVlRllSNk9KU3dKOWdrNlN5eFFHcWk2cldYLzVl?=
 =?utf-8?B?RXRONGlhdDc3OHdUY2NZQUY1SVIyU1haM05EcFdhMzZzV1ZSenh1YXJueXlH?=
 =?utf-8?B?aW5Tb0FFeVZFNE1FUXJUMk00RmdJMWtjaUYveFhXVFZmbVlsT0dHNUsza1FK?=
 =?utf-8?B?MUdVYlNKYy9RN3B2TUwvMmdhOU1HNjdqOWYyY0I5ZzRFREk3VzlyV3JXUkM1?=
 =?utf-8?B?TzlEVHdaK21lOVpIbFZDUHR6a2lWd2FQbktsaWJwU1VIM0FGbFQyUGRwSEtl?=
 =?utf-8?B?amNhM1VEQVVGT2JTVmFCSExiaVpQTXpBc3BMWWJINW15N2drNmVPMXFiQkFH?=
 =?utf-8?B?em8rSG9UZjJJSnBxUjRaZnplSFVZU0JqN3hoeG1hdk9CTlpaNWgxOVZEdmwz?=
 =?utf-8?B?dFozOXBZcVVITmkrdHE1ZFFyd2Vwb0YwNElMMmVDeU42Tm1OSFBGWTdocWIr?=
 =?utf-8?B?dFZZT083N2hUTzFaeHBFNm9hZzNVa3AyOHR4L1Y1aC9GNEV2eWhzOWE0dzA3?=
 =?utf-8?B?ZzVsZXM2YzY5R2FqSE1uYnUvM1NlZVVwN3JUaDZ5MWpBWWxlSE5lWS9sTEo0?=
 =?utf-8?B?ai9xeG15eFlvMkJGdjhocmFwaCt3eW5aQ2RxQU9LZ29qanVDKy9ZUHdwUW1t?=
 =?utf-8?B?OHVERE1QVGwrcnJ2TEl5cy9jYjMrZzFtc0ZMMlVKZHNRTmpuVFVGTGFPNnlC?=
 =?utf-8?B?dHJRelpEZC9FR25rYkVhc3RXaDJKaVMwQTJ6UFRDWlh4d0JhZmYraGxRZHA3?=
 =?utf-8?B?OXF4eGIrZmVWaDlvdXpHL0FCc3JIL2s0VEdpaGQrMUhrVkVKY2hpVEt5bCti?=
 =?utf-8?B?YnpMMERtUFl6UE1rMTJYNk1pd1VZbGRobXNPN1dXUnJxYXRuZUJab0Y1UmlD?=
 =?utf-8?B?UDlocjlkRVZMaVBQd2pLQ1BaYW5QWXAwcHNQWTNhQU5yMFl1YUVQb2pwM3dE?=
 =?utf-8?B?VitDUXFDUTdSNTEvS0xxWnpjdDhJY3VhWXpCYVBsTUs2M1ZGaVFNclVQc2pN?=
 =?utf-8?B?dEFocndzL0xhd3VWWGI3dkFkczV3RFE4dUZpazlIdkt0VzMxOFAvd3VYSmdj?=
 =?utf-8?B?azUvUWNqUC9kUGNSTnNidFQxcDY1Yy9qZnFTUGowTW9UN0ZFUElQWkJBK3VR?=
 =?utf-8?B?Ym5DTFpFQ2NmRStzMEpSVFVJQWtXWlpWMG94c0RvbllhSFpwMHdjM2k2NkI1?=
 =?utf-8?B?ODliN1NDckZVczBGUVh0KzRmVmo1MkZ4NFpleXh6RlJ0MnEvTW1qcjdSc0JC?=
 =?utf-8?B?WFR3UzNEazdzZTNPVmtkQUt3MGlMR2k3OUV2QzBKdUV5dk1CL0NURG1wWnVz?=
 =?utf-8?B?em0zODJ2TjJqRUprK0tiVlh2S3BSMFI1MTJORkJQODhRRVh6bGFSbjM0b1pM?=
 =?utf-8?B?SXVWdlhCOHI2b29LVGI4dXQ2anRMSDN2RGoyeTJsNUVsZ2dkZ2FlRGU1b0th?=
 =?utf-8?B?amgvbTVuN1dVd2N4OWZEeWtDUjFTcEdYUitTSWxqRUlJWE5yU1prR1g3MVBu?=
 =?utf-8?B?ZVdSNlAwU0RwRDBONHpCSEJRbDBYcXJOb3dVYVV5dUttVzV0dmx5eTJDMU9I?=
 =?utf-8?B?QnN0VW00QllSOVRZS2s4SDFuRms1eEJoMjgrckM5RlRaSWc1K3hQc3B0VG5C?=
 =?utf-8?B?TGwzTUIwcmVubXZ0UkVCNGFaQUtGMncrU3dqN0loUzEweDlwMUFRNUcyQ3FK?=
 =?utf-8?B?TWJFYWh5YmFYenYxaVdveFl0bGFCUTZpcjIrSnNBZ004Ung4NFlmTFJPcnBt?=
 =?utf-8?Q?kINc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4db5c2a-14ff-423f-8fae-08de20791f9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:49:32.9706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cfn9hk7ey8FU9N8k3HAkTWGCIjq0CDw3ZxwUkQ9ZFhJtAVw1XAhs5CCX3jBDN33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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

The size up-limit check is not needed because user buffer validation 
will fail if the size is larger than the cwsr_bo or cwsr svm range size 
allocated.

Reviewed-by: Philip.Yang<Philip.Yang@amd.com>

On 2025-11-10 09:50, Kim, Jonathan wrote:
> [Public]
>
> Ping
>
>> -----Original Message-----
>> From: Kim, Jonathan <Jonathan.Kim@amd.com>
>> Sent: Friday, November 7, 2025 7:57 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Six, Lancelot <Lancelot.Six@amd.com>; Yang, Philip
>> <Philip.Yang@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
>> Subject: [PATCH] drm/amdkfd: relax checks for over allocation of save area
>>
>> Over allocation of save area is not fatal, only under allocation is.
>> ROCm has various components that independently claim authority over save
>> area size.
>>
>> Unless KFD decides to claim single authority, relax size checks.
>>
>> v2: remove warning
>>
>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> index a65c67cf56ff..f1e7583650c4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> @@ -297,16 +297,16 @@ int kfd_queue_acquire_buffers(struct
>> kfd_process_device *pdd, struct queue_prope
>>                goto out_err_unreserve;
>>        }
>>
>> -     if (properties->ctx_save_restore_area_size != topo_dev-
>>> node_props.cwsr_size) {
>> -             pr_debug("queue cwsr size 0x%x not equal to node cwsr size
>> 0x%x\n",
>> +     if (properties->ctx_save_restore_area_size < topo_dev-
>>> node_props.cwsr_size) {
>> +             pr_debug("queue cwsr size 0x%x not sufficient for node cwsr size
>> 0x%x\n",
>>                        properties->ctx_save_restore_area_size,
>>                        topo_dev->node_props.cwsr_size);
>>                err = -EINVAL;
>>                goto out_err_unreserve;
>>        }
>>
>> -     total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev-
>>> node_props.debug_memory_size)
>> -                       * NUM_XCC(pdd->dev->xcc_mask);
>> +     total_cwsr_size = (properties->ctx_save_restore_area_size +
>> +                        topo_dev->node_props.debug_memory_size) *
>> NUM_XCC(pdd->dev->xcc_mask);
>>        total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>>
>>        err = kfd_queue_buffer_get(vm, (void *)properties-
>>> ctx_save_restore_area_address,
>> @@ -352,8 +352,8 @@ int kfd_queue_release_buffers(struct kfd_process_device
>> *pdd, struct queue_prope
>>        topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>>        if (!topo_dev)
>>                return -EINVAL;
>> -     total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev-
>>> node_props.debug_memory_size)
>> -                       * NUM_XCC(pdd->dev->xcc_mask);
>> +     total_cwsr_size = (properties->ctx_save_restore_area_size +
>> +                        topo_dev->node_props.debug_memory_size) *
>> NUM_XCC(pdd->dev->xcc_mask);
>>        total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
>>
>>        kfd_queue_buffer_svm_put(pdd, properties-
>>> ctx_save_restore_area_address, total_cwsr_size);
>> --
>> 2.34.1
