Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE565E8B397
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645E010E353;
	Wed,  4 Feb 2026 03:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UOCAWD32";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012033.outbound.protection.outlook.com
 [40.107.200.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D27A10E353
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3q7gAg7IoB42L7J9qNCkEO64Sulzmnu94eAIfip1Ais5gcBUBLBy033/s2UsxGEfFd+xV4s7bi5KVrU8eVtNIllLb2Uv3NL6etQ4R9ORT2NtQfOSpNbYGwWsyBGUjmzHtDEx+7UtxkzmdOANO1ZppX0w0lJDO4ZwJTc/GMl65lMet1zvf1tf6tTAoQ/lJZ3B7nfctSDeXHOV4n0MKhRknQszCb89BYpZmWB9+S2HQvoaKjrY7bhaLr98r4TduhLSTzai6uC5u9lG3aYxBW09MvUgZUafwMjiG8j5iNOnY2x/RVQ+n7k5hXufkmEhFuamNxotfsBFUqsqbUClctHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZF4O/2JNWMP4krfgSCB9bVHhDJI0VXKW4Cf3xNQT/4=;
 b=k0Z9YpuE3pj4GFr1RR+fOukOAwpuHncC+briMQ4uK/a07zBYVWrwTGJGhJCnLdsr1KR8VvHvsNSsDEpXWmtKPTjz3THVh1Sb9Hnf0+UHZg0bu6gl6R715TXeSPK/6bTPP7MBhDYojppwQEFbY1rea4XdpburFvJKjhHh8DlCfNVPoPcIoIas4ExvwG6pwgUQ14cKO9C9w4NR6Q+btF/XlLySLd9QtpHOBba0N03mdTYmYAOVNHc81avwC7MwFe8lLr/RcDpLdVliUBRz5NYqkbDbWUPEjNEABmVRqGgyVxeO253R5W4puGfgSpDCNP2x8rYfboa0a+Lf8Vgh2iFeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZF4O/2JNWMP4krfgSCB9bVHhDJI0VXKW4Cf3xNQT/4=;
 b=UOCAWD32Qye22zfjQTPpjMsGGrpJw9DBCpSuEKMAoDrGJQotIgw/i7KnB5VtwyvMnfN9of6KjEaE9mb2mPCPGmLqVh9XSn6S7jg3I45Ls9U2SyvxgwGo4xhnD2GXrYyIcO3NKZ0MsP449NgfQKdWg4x1OkqhM4oRFhQYzb+fqt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:35:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 03:35:38 +0000
Message-ID: <91d64450-96dc-4d3c-af8d-3891647eeabb@amd.com>
Date: Wed, 4 Feb 2026 09:05:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] drm/amdgpu: Skip SMU init for backdoor loading
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbe7f8a-1be2-4db3-13e9-08de639e7660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk9iVzZsbkRPc0x0ME5zYlhWc09hMGl2ZnJVWndvOWowWlpRRDJNTnEwWmFa?=
 =?utf-8?B?aU00ZUxFaWpyYmFMTHlJNTFON0ZtUG16QkpyQXByVk5MaXVxbnltYWt4aWFU?=
 =?utf-8?B?QU5qYjBLZTA3NjZGK1hCYWxqbWJ6T0p2dWZvcGEwKzcwMllzaVRQdmg4Z3Va?=
 =?utf-8?B?ekpBQndLYnIrTXdIM1JxbWZrZnFhdFFWMFpYZ0s1bVZQdWNnTXdTVXVsS1Zv?=
 =?utf-8?B?L3JkM0FObVR2OTVpdG1JVVFhbVNRQnZiWEsvRHN1bTlZWVhPTjhBRlVtWUdr?=
 =?utf-8?B?YStLL04rR3I3T0FlUVJ3TmNRVVFQclZLTk5KalkrYm04VEFseGpYWkZCaHBq?=
 =?utf-8?B?U1I2RDJSSE1CNitzaUVlWXdtZnZ4ODVyT3JoRnppRTZBeTAwR2tqWnZjc1FN?=
 =?utf-8?B?TDlVUmFXeVZVODEycmJGWEZNOGE4YW1mRW5GNDY5MzNJZHNOYWF4amx4cWht?=
 =?utf-8?B?RlZISFV3U0FVaHh0RVFsa3paN0dlbCtlNWRXUGZ0KzVxWEZTN3BBbmpKRmtS?=
 =?utf-8?B?amhwU01YOCtxYnd5T3pJT2llbExuUjcwOVM2Z0V4WTE0RmhyMHhqdWlFUjMz?=
 =?utf-8?B?RzJLL2FMTktBUjgzTUxmZUZ6aGhVeEN2L2J2b0p2dmxJL2s1VFhXQWYvRTk3?=
 =?utf-8?B?UWQ3KytXZmM0c251Vi93WHFjb1RhMXdHOCtFb2p2amtJeW8rcGJFREhtS1JN?=
 =?utf-8?B?UndFOVVaVitCb1lScEExUW0zMXFwSEVXTnJLY3d2dDdzNWNUK2wzNEJFOVl4?=
 =?utf-8?B?aFFFUWxQTlNZdVI5QzQySXUzQnJ1TXAzTzJWaWtMZnMxS280UFBNRm5FVm1P?=
 =?utf-8?B?QjNsc3I2SVRnKzdJZFhGNjVrK2ZCdlBrYjZ1NXdPTjRXY2xMQWFLajBRWG5r?=
 =?utf-8?B?OWQ4OVpIc29pRVVQcWRVUDNDYVRUNWdiOXlma1djRHVoT1lKVmxBdW44Mi8y?=
 =?utf-8?B?NG5jTFZ3bk84NVBtQm9FM2NrV2pnM0ZSVEo4UmwxUFVyeWhKMlZkbDVxZzd6?=
 =?utf-8?B?TE1HWTV0QUs4d0craUdRaVBVb1RTaTcwb0hBNU9ydGJ1YTNCczd1UmFFL3Nk?=
 =?utf-8?B?eCtTYXZ5UlZ1MStEYzgvdVgzcFhONGRjRlFkazdsYTNTbXFFSlNaTVBGQ2J2?=
 =?utf-8?B?WUY1WGc5NFp3RU1nRllyME5ndlBDOGlPaElzaUNFUFVyL2JUdjdrMGhYTlZk?=
 =?utf-8?B?Nksvc3BKU2xQdUlHcXpYMU9RdURRVFNFdy96Zzg0RUdaUDN0SmRCMHE4L0VZ?=
 =?utf-8?B?UnBvbTljMWpJd1dualp4L1BjZHIwdDNmdXVQTTArWUNvaVhBVjB6a3JvOWtK?=
 =?utf-8?B?MlFpVzd4NjRvTER3bGFGVDhiNEV0UnJHamdSWk9CZXVRb1lNYXRQSml4dldY?=
 =?utf-8?B?YWFoVFNEN1BBdzJYWmRTY1JOeldLVmxqanNJT3R2T1lzTGZETWg3aHdYR29Z?=
 =?utf-8?B?cHlPZUo5ZGtXRERXTkY2MktKRHhxQ213Qnh4OVg4SGRMOFlqLzRTTEFydHhY?=
 =?utf-8?B?bC94R01leWd5VzFnamlwUEI0Z3VIQU0vcXFTU3A1bjk1THNFaFJ4WlFCcWNl?=
 =?utf-8?B?UWV6NWZxQmlyYW5Ma2pGUmNTenIyd29uazdSMXBLREVBTlhEdTFiOUt0NHA0?=
 =?utf-8?B?c3d0TFBmOG9UaEUzb2tMREV1VklmOXZHWVJydkxhOW05TzE1WGt5T251NVll?=
 =?utf-8?B?SmtUNXM3bU51cm5ncHBmdWxWdzRZek1OVjVvd0NDcEZXZ2duZFhIaXZIUjZB?=
 =?utf-8?B?UHFpZGRtWnpyK0pOaER6MnJWY2JEdGxTNndINy9BS1U1Sm9jUnlTQVhOMWZ5?=
 =?utf-8?B?bHBxajVjeFFlZUNqaVhoTE54dVJNNkZsYVg0dXhiUUMwMktldisxYk92K0d1?=
 =?utf-8?B?NkZ2YkZkNGwyYmZPQXBIVTgvV2RWZXJVeWlEaVBhSDU3bmd6bHovb2xVcHRw?=
 =?utf-8?B?RDJscDJtcHFOZCtJZk91L1hBcDVOdzFobElxL2tya3VzL0p3aUNZd0xGemNX?=
 =?utf-8?B?WlR0NUUwNkR0R2dJQUZwbGpVVkhHQVJYK2EyOTBvVmx4WWJMbXBQY1E4NFJz?=
 =?utf-8?B?eFlwVG1xekNzYWJKK2dLMjFYbkttblR0WVBCV2FtbTNsc1FTY0VGbThKcXFr?=
 =?utf-8?Q?SWXs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REhFbHBJcUpXNEs4dXFTRS9oWVlpV2VDVnBIdzg3aUxmSjZUYmpQM28xRVZq?=
 =?utf-8?B?R2pNaXJtWWZyOGd2UlVqak5CRERLQjB3enkwWWplODhORmtlZk5zelB2R2du?=
 =?utf-8?B?c1d4dWhjVXBsZGlxWnVJSVd1M0ZEWlBzbnZMT2c5YnVzdWNCNjBhY04yNWth?=
 =?utf-8?B?V1JTUGJ1bHVTTGRtMmR1VkpJTHdwN3Y3KzNYcUU5eVNwMUhPUGZZUDNDbGZK?=
 =?utf-8?B?ckFIWUJKdjdFRm90WDljRFVkMC85K0JIcWNmUUc4Z01VZ29kbFFXSGhiblcv?=
 =?utf-8?B?bmpaY0h1WWR3eVYrRkhJNHNGMnFvSVpuaENjWmMrMXlnYml1RTBZLzFOT1Np?=
 =?utf-8?B?ajVoc2NpVElTMkV3cFE2L0NNK0Urb0lCTnk1UGdWSnJyTzlOTHU0bjJ4Mitj?=
 =?utf-8?B?RUJUWjJhRWQvcVM0cEdNM0hOYlJHeHZ5REZlaEZONGFVOWhHTy9VWEtjYmNl?=
 =?utf-8?B?WjdvcVNTNEx4azU3bjlRZzM0SElaODMwbmlpNklXT2hRMlZVOXlLdEJnVWJn?=
 =?utf-8?B?WjhzUmlzNVBOY2FKRk5aZk16Sjh3aGJWZStDUGwyVzVISmV0VHJwblRKcmEr?=
 =?utf-8?B?TTdKaUlySnJkY2xLM1IvV1dTak92OXMzTExtQmJrOTFwOUFYWUVtRmVYblZk?=
 =?utf-8?B?Skd0dFhtS0p0M1Job1BmeE5uRk01aC9BZlZwbzJFRUpDMkdqeDFUWWpLOGly?=
 =?utf-8?B?ZU5qU3ZSSHR6SU1kZHNUOUZpSWRzMndDRXJ0cy9hbzEzRGJaNWU3R1RJV1Zt?=
 =?utf-8?B?V2lEYVE3OXI0emNPM1FJT1lQdVJFQ0RvUHdpbHhFelhTM2RwbW9Ob3Rhc0pF?=
 =?utf-8?B?b0dyWVBrOGY5dWJYaExVN2NvWTljbHphR2FuZFFRU0Z0Z3hjTVQveDA0ejRs?=
 =?utf-8?B?aU5qcUhlSXVCRzNOSEw2cE01THZaTkp2aGxTMlArb0wvelRMbnZPRmtYRi9a?=
 =?utf-8?B?Q090aHhGWEorWVVRd1BzN1ppc2RsL0JWdVljNGpYc3JWcmZ0UDV4Z2JMVlhm?=
 =?utf-8?B?WVEwWHhQNHAzMXRPSzd6aE9yMjNkKzVMN0NMbUsxV3hhcE9uVVJON1VvWlBo?=
 =?utf-8?B?em5BNEQyOHFiUFQ5R3drSTdMRWdSUS9DMGJPNlhSaUcxSGJTMjRiVWYyMDBs?=
 =?utf-8?B?VUZmWHJmYklja21iM1ZjdVpxN0lFWXFCNmQrM2ZsWkk1Z2tzQzF1Z2lTdEtO?=
 =?utf-8?B?TmRtaE5ocklmbnNHRUI5YXNvcWlhNVZmTnlocDVoUjVyUWpKZU9hTlRGZitz?=
 =?utf-8?B?cFY1T0JDcy9iOGFyMXlna1hzNldhRWhoaTVYK0tuTEpCNWUrbFRTU0VwMjdJ?=
 =?utf-8?B?OHdIR0l5UC9xU1c4cFBLYWtYTnNScWdaUHl3dWE0amZqL0cwNnZqTlMzOFJT?=
 =?utf-8?B?aDNpQVcrNjVrL1duTWdodU9vSTB5UGVVaHA1T253alZOZ0FCcVFvblNpVzRt?=
 =?utf-8?B?V3RCOW5QOVNScjBsOG8rNE5xOHYrRS90eEE2WHNaUVBxdk84UURjNGRnenp1?=
 =?utf-8?B?dnEyTiswNXpiZnAvL1VhNXVPa0krYVF0bnp0bi9EQmJVc212dmhBRUFoYTJy?=
 =?utf-8?B?dy9FK040a01iaG5MK2c5dGQxdFd6QTdwemFkdlR3d0t4NXg1U0Z4VE10eGxS?=
 =?utf-8?B?QjFqYVd1ZnJIclhmdTBDWHZwUE5HMkgwOGRpQ2JqZ25RVkRYRjlPQVdRWjY0?=
 =?utf-8?B?UDMrcElCZ2VOWk9oWTNYZnNINGtpaEl0dE0rZUQvT3dxb2xoeXhaUGx4Zmky?=
 =?utf-8?B?RUxYby9zY3oyQkY2T0JBRDc3VVJJUWI5RDBrQW1HQVRnL0ZMcWdIdTV2UTZK?=
 =?utf-8?B?UGZyNytvUEkvOXBkbkFlR2JJYXRldEdQaDhpYm15dW1pQU1HeTl6MmdWZ0R0?=
 =?utf-8?B?M2d2TEd0MWU0eEZWVXUwYmlFNFZkSFZtdkhndnZsS3VQN2gwQ2V4UkE3Mk00?=
 =?utf-8?B?eHBUaVVxampiTE41NVhMZGtoVHVBNGlkK1VGUXRjYkJDRUNUYmNOZzVaS256?=
 =?utf-8?B?Y0o5STM0bEZxQjNMa0hkOE1qM3VqZStnMUxGQVJ2bVF0UE1WTXRMMDRFandr?=
 =?utf-8?B?cURLRjRYSjRLa2VQU3NQU2RCeUsrWHlUQ3Rad2gyWU44blh6T0wxTnZ3Y29X?=
 =?utf-8?B?b3AxTVI1eGZ4S1NTWHRRZk5OditKY2JYb0VSWG41eVliODZLRHVzQzZQUVBu?=
 =?utf-8?B?NE9qUWFpVzg5TmkycnRrc1hoSHd0ZG5pZHQxOHZZc1VCVkRQYVNjcU11OWRG?=
 =?utf-8?B?SzV3b3FXMzRpR2Y2RHVEQVRub0J5Y0RLcjNuOVN4WHVvc2FYbzhnY0NPNHpN?=
 =?utf-8?B?NlpCN0dTaGNoOGcvT2wrQjR1RGZJRmQzOXBpcHJTNndpakpFbDNnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbe7f8a-1be2-4db3-13e9-08de639e7660
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:35:37.8986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkLjjCtoH33PCUzJ0iAZPJVi1deN2Iq47IqhHr0a0rHUJ7VN8FOiUvAdNLnEpSox
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578
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



On 04-Feb-26 8:36 AM, Pratik Vishwakarma wrote:
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 9f52b7b24198..fc68dffdea98 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1909,7 +1909,10 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
>   		smu->pm_enabled = false;
>   		return 0;
>   	}
> -
> +	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> +		dev_info(adev->dev, "Do minimal SMU init for backdoor loading case\n");
> +		return 0;
> +	}

This doesn't hold good for all SOCs.

Thanks,
Lijo

>   	ret = smu_start_smc_engine(smu);
>   	if (ret) {
>   		dev_err(adev->dev, "SMC engine is not correctly up!\n");

