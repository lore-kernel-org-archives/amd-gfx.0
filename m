Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB9DCA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 14:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41E710E375;
	Wed, 10 Sep 2025 14:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tA7MDLnW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E9EC10E375
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 14:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Md3ERmsfreBWlEihpVmb2k8VbuGq4RCQUZvGvveRbqgCegf+PgUqQHIpXP56Uad7vOfoaHoT3QHkxpzkxtt6m2/l/+yyyxJLkGtxNAnKyWQzTo9LWfZzuDM3cnpuX99++UGRR1u1zNmf07SIaMzE+oL5guba3exbqw+MZLb84n5ldsgeq2/I3VQKKWS3ihQzynKaac8haG4x2ioLlks8QPf2IHDvXd75LK2B7Ss3ofiypENGS2vHGFH+ni2ZiqFYQH7TcvnmwrbElG3RhCkgAl/1LDPFKrkvrVfqM+pr7vsj5uFvkPS2m+evYs6ZtBcXe6P9SUJPQhIyc+IBKyH8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCw6ptwX9Jmp4wmt8AC1/1+09gon3aIhKT1pPMc9D3Q=;
 b=IZpdsbB1WWfUJUysvJJ4MeTpEHuwHtLMJjctcUkrdLh2zjOECZcLCvbBKXTL7osnNsVMIhTnveRoVAaF8pDsVEPdh7DI5dY0KjRh4Gxqi31FS1+FVIjUU00Ikw7k5Qe+35bgqDk4EOB42jNLLStiMEAOXfYRt4H9hVjWgS5sme6bA8qPjQpLF1HFAwHZgDwubYiukJEG70FkCwXNUn54OLfl9oyhYGQvQqldTD3myEsKR8WYJLCjKCA4gb8VcYFMiVLpveJBnVbOJjio1BOLQ7yiHpzv1ogvcoIvR1hLLOOAxjC7Lsz0jHRS8UqUdJ8jy5429z+C5oNKP3W42TLgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCw6ptwX9Jmp4wmt8AC1/1+09gon3aIhKT1pPMc9D3Q=;
 b=tA7MDLnWK2aOzUpjBOJC8nD6kHVqDPa3t7x5ppy8tSKTI8QinLH+7RmqHZvfSvi9S0ueJm0nY8u+XWBLFOHyff3Zjm4qMQzsCXp3mRJSsJyrhsG0xERXN3Aa1JwLFuwaE5OqvRo/abVsMfF041CqzFeoOmJ2o0WCjz4FbQmvHRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:57:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:57:08 +0000
Message-ID: <eff9b0b0-ff7d-490b-b81c-ab866f5a4b14@amd.com>
Date: Wed, 10 Sep 2025 16:57:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Set SDMA v3 copy_max_bytes to 0x3fff00
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-2-timur.kristof@gmail.com>
 <26b5d36d-1c9b-4891-962c-ec13b65f02ac@amd.com>
 <a065f044dd629a9863ca18bb0e913d8f9299bedc.camel@gmail.com>
 <32b1c868-8b0d-41fd-94b9-0ebfbc6b3711@amd.com>
 <0d07fe34d3857ece68d29ce21ea2768e43538aa6.camel@gmail.com>
 <a77a5934-afa8-48e5-bb15-a7f55087c245@amd.com>
 <CAAxE2A4ZUG_DLnMpW7yd=pSqnGoyELmxi_u9GveLg1zra82_wg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A4ZUG_DLnMpW7yd=pSqnGoyELmxi_u9GveLg1zra82_wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:52f::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 910d9c44-615c-47ba-a2a0-08ddf07a508f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmthUW9zU3dxekJHWWg1a0tiVFRvZzI4cVlGTnBpR0tXMHRMNDRRaE9JbTlO?=
 =?utf-8?B?WjE0TDdOcGQvejJ6NFZ5cTdaSWFraDFUS0U3a1ZQcE93M3dad3lkUHRBNHl2?=
 =?utf-8?B?YmVGWVNuSVlGLzB2ajF2Y2UyV0p5RE1ML2dNLzdKYmdkK0UxcXdKU01oUHFa?=
 =?utf-8?B?aXN4Q2VlR0kxTnl3NFdaSFRtVVJ5RFB4ZEVMOFpCemE3MmxyLy9sNUxwRmxY?=
 =?utf-8?B?Y3RXa09IaDdqbDNHc3BwcmdVYzNaZVErMU55UW14UWtkLysvUG54Qzg2RXlr?=
 =?utf-8?B?SzA3YXFxRE02WGNTL0E1N3JjMUxqZS9KOG5WeVFIa3ZqaHBQSUFkdFN5V3ZS?=
 =?utf-8?B?SG03V1BQdms2aUcyVEphMGFpbXJXUFcxNmdHSllPaFFKVWVUZXpIaUtkRjV1?=
 =?utf-8?B?TEdHUjNPT2ZYOEptRnlITE9OTkx3SWJHV3RMVHBleXAvL3JybWVGSjNvdWl3?=
 =?utf-8?B?akE0WUtnWGJKT3Y4Y1ZuNk01WUgvRUpkOVlpVnhlSTIycHpZSk9hMEJNVGJY?=
 =?utf-8?B?SzZiVUlJUStGSG1mSHhpVjl3bGdoS0g4cHA3STUxYjJ4SUpCQWltQTI2Ylp2?=
 =?utf-8?B?YndjdDZkM0ptM0NobmlaUEtTZ3NVUGhDYWZJeXVlZDBxMVR0cW83Qnp3d3hq?=
 =?utf-8?B?dFp2VFJVckJXRDZleThrYkhDNzd2TEVlVm1jbkdtb2ZJUERwdXB2Q3VWbEtE?=
 =?utf-8?B?SXVlNjVnbUVlU2Y3cHR0S2NEbGdzQ0NZcEJTWTdhWHRIUHNjZEZwZlg3V2pq?=
 =?utf-8?B?SHFBMU1iUmZablZ6VFpMT2FhQzJobzI4VlpOMXlZd2hlbmJzNzlsSWt4QnFM?=
 =?utf-8?B?QlBRYVIvSURrWkh4aWN1Q1huLzl1THBBRlhuT1VLQWJtZUgxcmVBcmtBKzcv?=
 =?utf-8?B?SHJIQlVUUVoyYXV4RGc4bStHMFgyb0FxNEVnL21rcVp3UnBnRzczNjlyUTdL?=
 =?utf-8?B?SWNNMkg2MnhLd1owMTE5RmEyVFFTcjVhdDlZcmI3ZlZJaGR1TWhSOVpzenVC?=
 =?utf-8?B?QXI1d2E0Nzc4WVdNYWdFeVFsREVrZkRPdUIrTnFjenpOQjJ0cnZ5cnN6V1oy?=
 =?utf-8?B?VkprTXhERU9GOGw3RGFONXJNVDdkYTZZY2o5ZGdieit6MkxGTno0Vnd2WHZC?=
 =?utf-8?B?bFh6bm00TGNvajFhakszaU5VandKa0dMUkRKeVJqVGNiZHo5SjdTQ0U1UFNn?=
 =?utf-8?B?VGRkMDFSV0N5MWo3enRBcFJCSFlKRG02Vm9mWnNRUHRtTjl4NEhCUVZCejJN?=
 =?utf-8?B?SlV5QkNiSHRpaENSRGo2ZWpmWGtJRHhQWVhaMG40NytkSDluTi9NaVFyZWcr?=
 =?utf-8?B?T2R2RXBJM2JaVEdoOFB2ZWdYL1lPd0htTUZvNGdWYXRrZHNlVEVjWDJtSWlE?=
 =?utf-8?B?bXJWRzJBejd2UjJOWU14UjZjUFdCcUlmZXh4UTRRMEE5YXJVUUZUR3RvZnVE?=
 =?utf-8?B?TXFpSHJiOTZJbVkveHlXTFNrK1pkNEdCVTVNdmdocFNsM1RsWmN5eUxHUGtz?=
 =?utf-8?B?RlVySHFGbDh4LytFUG8yK3JBUHVISVRzbHRBWFNZVTFneTA3cklvTWRSWGE1?=
 =?utf-8?B?d2hvYUExNnRxbmJoYUNjRHNGeERQNjFEY3JoVG4yMmYzcGhaRHNDYzh1Rm52?=
 =?utf-8?B?aEFkWXZNVEFRSzFCM2ZDQTRZTlNFOUR2eHhlNExKY2MwWldqbnlZbm1HZ0Nh?=
 =?utf-8?B?elNUWWNYVEdHZXRGUCtiVTZqWm9idTBCS0dMbjJDcFdLYW9qRmtpUFJEbCtZ?=
 =?utf-8?B?c1BEVWg2MGRwcWZQZDZFRlRyR1RmSTBiczZDOS9kMTh3Mjg5RisrNXB5WTBC?=
 =?utf-8?Q?6Cb4J6UVynuHv8UESE9aeNqBWkbkLTTWUKs40=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjI5MlZJeTNsTkp2VjZXOVRCSEU5VitnUjRteVhaV1BpNTlUSmdZd3NDckJ1?=
 =?utf-8?B?eWhLeGZhQmNkdWZ3RVVNQUJvWWFuQXJUdjlWYlJLMy8rV0ZndEpYSTBqRlN4?=
 =?utf-8?B?alpjUE5uWlIwUkZpdlUwRkpLN3hrZ1c2ZGxLQSsyTTdvV1J0MVRhbHlaeHVL?=
 =?utf-8?B?NEcwNmdBTWNzM1lSYXRXTmY3NXZtV0dTQXhieWpJV2NPbEhnL2l2cmFNVGF4?=
 =?utf-8?B?RldPUzRsQm1LbEhIYk4vK1B1bG9PSUFReVZ3T0pDL1ZUZW4xRUx3eUNrUlg2?=
 =?utf-8?B?bmU3enlKWG1ndStoZCtUOWtJOVBRTFdWZy80M1JOTGV0Y1dLMDBreWxES3o2?=
 =?utf-8?B?aEIvOC9GOUdHa0U5MFFwSi8rSGZZMWZ3YzlCSEZkYjlob2dJMXIyeXBpV0pz?=
 =?utf-8?B?QzBLODhwWTJuSnJYSUlzYWRGR2NaRysxRnAwK0hNTjVFQVRsK05lSm1mUlBy?=
 =?utf-8?B?SExELzdqT1lCWTB1Q3U3SHhuNjlzdWhBS3dKbUVvRXVXZ2MvUFBWSjhxZE42?=
 =?utf-8?B?TWdJb2hjQ3lXRHRYd1ViL0pXeHVJcGd1NHJYL21vcDdOeG5OZlF2NHFsYndU?=
 =?utf-8?B?RDJsSW0zRnlQQWh6WURobks2OUpxVEVQalJVSXdXVHNsSkNqSjFidGlXZlJr?=
 =?utf-8?B?QnIveDY3ZmRGWWNHVlpoSlZqeXEyOElsQ0J2ZmdEVzJod0h1NFUyc1RzaDdB?=
 =?utf-8?B?T05wZUs3eStPek54ZWJjK3p5c2FxcnJtclFZVlJVQTlVMUZxUHNSTytNUmFu?=
 =?utf-8?B?bVY0dzNkN0FTVTVYMVdNQW5SVDhjVWkxN1k1bTZyQXBvZ0xCVkFhRFdnQStN?=
 =?utf-8?B?RkxVZ3l3alZGVndhdUwrWFZDL1FmcU4zYitGVjNhZXowMEx4eUgzSml1Z0g4?=
 =?utf-8?B?NlV3TjdrSUtFTkI2d0g2ajlHNVBoRFdocDUxYUk2anArOWczTXBqTmtYeWhO?=
 =?utf-8?B?Wm9Ya1pYU0tKUnJIdGtqcTkvYUR0dmZIY084Y2pTeFcvRE5GdHZjQU85alRn?=
 =?utf-8?B?bWMySGNCR0tqVGZ0bTNSc1F2RSs0SEFocUZrbW1YNHJWQ1RqeG9tS053eTlH?=
 =?utf-8?B?MkNsSWJCaEZkT3FZYWcrRTQwUTVEM2VXeHBkMEt4WDhBTVkvakFLUkVnL2hP?=
 =?utf-8?B?S294ZksvRURnVXN4aFJvTnFRbFJlREdwamhqOVhkQkRzSlVGSXprWXE5VUpN?=
 =?utf-8?B?TDBUTjJ5RGRiVEpwTDNTWFpBN213bzJNbHNTc0lQb0o5QnR1RHFyUXJIU043?=
 =?utf-8?B?UStlV3BtQjdFMUN2Q3NSRGlReE91c0t1MGJOdDdTR3lWdTlQVDgxSzAzMUlj?=
 =?utf-8?B?cHVucE4wNnE3cm11TjA0UWcvbHJmUmtzbWxNRVMwRWRhQUNocTVUT0dsWlh1?=
 =?utf-8?B?U1FHeW1HRkszZkFNU28wbXJ3RkE2Y3V5ZGh0YUpKcXg2RWcyUCtiVjJjMGF1?=
 =?utf-8?B?ZVl4Ynl6cldTSWdUSmN4SFd6eXN4QytwcUU4TFYvZ2dEdFNKRlAwaWdoaXcy?=
 =?utf-8?B?dm44dEZ0eHU1dHArMWNsY1Q0cEtFWk9CWFZVam9tSGJyYlBTTVI2VGNXVEhu?=
 =?utf-8?B?ZTdtVUMxTUczV2xGMDBtSVA0Y1FuK2VkTm5nLzhZODZpcSt1TXJ0NFBsSUk4?=
 =?utf-8?B?RGhTWDFORWxqMzBhMDVVRlh1bVpZeTdRVVN6cW9palZyNGhjUHI1dGllN2pV?=
 =?utf-8?B?TVpyN25TNWFKZUVIQ1RRMDcvWDc0OUVQcGFyTUpONkxVT2xhZXN5cHFTSmQ5?=
 =?utf-8?B?cEZCQ0Y0cE81Z01QTndyaU9GR0hXVDdTMFlzVExzUldUZ01PaUNLdFlRMGNi?=
 =?utf-8?B?TnllS3pINU5VQ09aZmxIVy9Da1puNjJ2Tm9GVFplcE5MdjBnd1JPV3VueWhQ?=
 =?utf-8?B?NXhoOU0rcUFZRVNIL0JKV2RhSjA5U1REb0hkVVFOR2hNS29HWXhrZU5lWGtH?=
 =?utf-8?B?RXBHcGVLUnBpaTBZT0NDeW1MWndZV1dNaXNzYUJ1eUxUeFc4ODBndW5LY3Yz?=
 =?utf-8?B?YStRYXBQSWJMaXNZK0NVZHJFR0plZmdvdU5xc3gwNmlRWE1xR09LZk1qb2FY?=
 =?utf-8?B?OGFidnhsZlliQmFlcnRQZSt4d3U0NktaRE5HZ3hCN2k0U1kyb1BMVERoZ1Zy?=
 =?utf-8?Q?AxrqOHCLFDNP6ExUF4xJm5jyo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910d9c44-615c-47ba-a2a0-08ddf07a508f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:57:08.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ee+7rmGqmvtgW9YVeSWN1NAl7XUAiPyRMHgZho+a7VkIJbkIH0tFpdtuBRV4OFJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

On 10.09.25 16:52, Marek Olšák wrote:
> It's probably better to use 0x3fff00 to match Mesa and PAL. There is no benefit in using a different limit, not even a perf benefit, and it's better to be consistent with all UMDs.

Unification with Mesa is certainly a valid argument, but just using an approach because PAL does it has proven to be troublesome before.

If we are interested in best performance we should actually round down the value to the next multiple of PAGE_SIZE.

Christian.

> 
> Marek
> 
> On Wed, Sep 10, 2025 at 7:54 AM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> 
>     On 10.09.25 11:34, Timur Kristóf wrote:
>     > On Wed, 2025-09-10 at 10:34 +0200, Christian König wrote:
>     >> On 09.09.25 18:56, Timur Kristóf wrote:
>     >>>> Even when we apply it I think we should drop that, the value the
>     >>>> kernel uses is correct.
>     >>>
>     >>> Hi Christian,
>     >>>
>     >>> The kernel and Mesa disagree on the limits for almost all SDMA
>     >>> versions, so it would be nice to actually understand what the
>     >>> limits of
>     >>> the SDMA HW are and use the same limit in the kernel and Mesa, or
>     >>> if
>     >>> that isn't viable, let's document why the different limits make
>     >>> sense.
>     >>>
>     >>> I'm adding Marek to CC, he wrote the comment that I referenced
>     >>> here.
>     >>> As far as I understand from my conversation with Marek, the kernel
>     >>> is
>     >>> actually wrong.
>     >>>
>     >>> If the limits depend on alignment, then we should either set a
>     >>> limit
>     >>> that is always safe, or make sure SDMA copies in the kernel are
>     >>> always
>     >>> aligned and add assertions about it.
>     >>
>     >> That's already done. See the size restrictions applied to BOs and the
>     >> callers of amdgpu_copy_buffer().
>     >
>     > Based on the code comments I cited, as far as I understand, the issue
>     > is with copying the last 256 bytes of 2^22-1. Do I understood your
>     > response correctly that you are saying that the kernel isn't affected
>     > by this issue because it always copies things that are 256 byte
>     > aligned?
> 
>     Yes, see the kernel always works with at least PAGE_SIZE buffers (between 4k and 64k depending on CPU architecture). You never get anything smaller than that.
> 
>     The only exception is the debugger interface, but that always copies < PAGE_SIZE, so the SDMA limits are irrelevant.
> 
>     > I checked the callers of amdgpu_copy_buffer and can't find what you are
>     > referring to. However, assuming that all callers use amdgpu_copy_buffer
>     > on 256 byte aligned addresses, there is still an issue with large BOs:
>     >
>     > When the kernel copies a BO that is larger than 0x3fffe0 bytes then it
>     > needs to emit multiple SDMA copy packets, and the copy done by the
>     > second packet (and other subsequent packets) won't be 256 byte aligned.
> 
>     I've just double checked the documentation and for SI it clearly states that the limit is 0x3fffe0. Documentation for later HW says 2^22 - 1 - start_addr[4:2] (which is 0x1f in the worst case so you end up with 0x3fffe0 again).
> 
>     For backward, tiled and windowed copies a 256byte bounce buffer is used instead of the 32byte buffer for the linear copy. So the limit is then 0x3fff00.
> 
>     Looks like that buffer is also used for byte aligned copies and that limit applies there as well.
> 
>     >>
>     >> We could add another warning to amdgpu_copy_buffer(), but that is
>     >> just the backend function.
>     >>
>     >>> Looking at the implementation of
>     >>> amdgpu_copy_buffer in the kernel, I see that it relies on
>     >>> copy_max_bytes and doesn't take alignment into account, so with the
>     >>> current limit it could issue subsequent copies that aren't 256 byte
>     >>> aligned.
>     >>
>     >> "Due to HW limitation, the maximum count may not be 2^n-1, can only
>     >> be 2^n - 1 - start_addr[4:2]"
>     >>
>     >> Well according to this comments the size restriction is 32 bytes (256
>     >> bits!) and not 256 bytes.
>     >>
>     >> Were do you actually get the 256 bytes restriction from?
>     >
>     > The comments I cited above are from the following sources:
>     >
>     > PAL uses 1<<22-256 = 0x3fff00 here:
>     > https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308 <https://github.com/GPUOpen-Drivers/pal/blob/bcec463efe5260776d486a5e3da0c549bc0a75d2/src/core/hw/ossip/oss2/oss2DmaCmdBuffer.cpp#L308>
>     >
>     > Mesa also uses 0x3fff00 here:
>     > https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390 <https://gitlab.freedesktop.org/mesa/mesa/-/blob/47f5d25f93fd36224c112ee2d48e511ae078f8c2/src/amd/common/sid.h#L390>
>     >
>     > The limit in Mesa was added by this commit:
>     > https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411bc0d41c095004232ed <https://gitlab.freedesktop.org/mesa/mesa/-/commit/2c1f249f2b61be50222411bc0d41c095004232ed>
>     > According to the commit message, Dave added this limit when hitting an
>     > issue trying to use SDMA with buffers that are larger than this.
>     >
>     > For SDMA v5.2 and newer, a larger limit was added by Marek later:
>     > https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c04660cc4b3f8abbde259 <https://gitlab.freedesktop.org/mesa/mesa/-/commit/a54bcb9429666fcbe38c04660cc4b3f8abbde259>
>     > Which confirms the same issue copying the last 256 bytes on these
>     > versions, although in this case the kernel isn't technically wrong
>     > because it uses a smaller overall maximum.
> 
>     Yeah, I mean that totally makes sense. When you want allow byte aligned copies as well then you have to use 0x3fff00 as maximum.
> 
>     The PAL code even has extra checks to speed up copies where src and dst are byte aligned, but size isn't:
> 
>         if (IsPow2Aligned(srcGpuAddr, sizeof(uint32)) &&
>             IsPow2Aligned(dstGpuAddr, sizeof(uint32)) &&
>             (*pBytesCopied >= sizeof(uint32)))
>     ....
> 
>     So it totally makes sense to use the lower limit in Mesa but not for the kernel.
> 
>     Regards,
>     Christian.
> 

