Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91285C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 23:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CC710EA35;
	Fri,  9 Aug 2024 23:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eg0xCswM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CFB10EA35
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 23:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV/LW8SNXHrL+BVZVRwZIWQtGDPzXdNBIQ7RDM9Sfb/OyRGNEKfVHEdgr410XOioxztxbhKSycgPpdiKkpIAnCgSPmEVgz0HB87qGD8gb6ANgkAdZQtVcoO7iZwRLI1Naq0QyFkIKM1LJHRU3WDMJhRCW8mG5KDg7Xn7nprWLulvlVIhxaUlurpAfFXfb2O5sfce3XVTtV0+gU0gb1bG8MKeCx+gvnPeN3F//KCJQXpeU21OY/e8LJbjfEsvPGJORwOL1lPlEJ2mZphKnYW9WwpbR15NcnZP3KG74M9pB43AqptGOSaMDz399uAcQjk63rlVMYo7o7mmnDx2wsLrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGo7huv3eoLYr6ltJZPbfHVkKHzAkAAdahmMpJzSl7M=;
 b=PgYliMAPIi5fUzeo2LvV5q0NnYRdc7CDEw/S/oU+/SXE98DQTlZWZ923IcUZcwI6f0jO59VnMAy8SSGtWAhwgQoUa+XUMgFVRrNaQRYNJkKvMv0rbpKhzXR2nwWMnd8NccG8WOiXm2ZDehr3bF01Sn4FsCAAKGRYfP8CiI2ieezjeDqaLH5MHA+qYA6N5cTFOXql6k6ccpyuOu0rToQ9cM4TpEMuA5emM9mjJsVAPvVhmEVO75DJx6QZ5SpCNQfH4YRybjPzJlHdFNDyld1ymODH6x+Rf8kBkmYpObG0CKbKaS+Pqx7FZ2LpbdQgyYXVIgVpahkBLH0QZNVeOumCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGo7huv3eoLYr6ltJZPbfHVkKHzAkAAdahmMpJzSl7M=;
 b=Eg0xCswMaKbAfE+7mi3jJcohk+UHJIWORvkg8ZC8qXXIYY9QxV8AknTOqD2aZeo+x+YYmRKby1K39xsXH7zGnY3Y/lT3GHaNTjY5aU5xRXn+LgXzkJh/WsINetP4A2hBKjgFJFv+Fv0g9EMIGcFmkhQgUzrQ4cKgw87MmudquA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 23:36:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 23:36:53 +0000
Message-ID: <bd4a1e0f-6ce2-449c-bb49-2378d0778dc9@amd.com>
Date: Fri, 9 Aug 2024 19:36:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>
References: <20240808084421.2755417-1-yifan1.zhang@amd.com>
 <CY8PR12MB7099066850F032CF0AF32A038CB92@CY8PR12MB7099.namprd12.prod.outlook.com>
 <CY5PR12MB63696ECC884783C0812DF219C1BA2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CY5PR12MB63696ECC884783C0812DF219C1BA2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0026.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: f8288758-250b-4fbd-28af-08dcb8cc266f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjUxNnNjY1h3NHhvemp1VHV2blp5K2RnWTZWWDY3YnBnNVhsVnNuNnlLSnhT?=
 =?utf-8?B?bG9YQnlBcUFjT1R3Y2lWczgxV01KKzNXbVloZEdEWTIvZnJlMHNFY3VTcU9S?=
 =?utf-8?B?Um5CQmMvUjJnZ29JZEVzWWc4LzYyWWU0UkxrZHdtNXFwVkdUYXJZV0FJd1Yy?=
 =?utf-8?B?WHVPMjNlWDRVKzZUcHF4eVZ3anVvV2dmY0llQ0V6emZOMjIwZzVoeldWalNK?=
 =?utf-8?B?UVJoTFYrUHBZZm01dCtIejUzRmI4aUlIQzlLbDRkSlU2djMrVTFYMFhtZS9h?=
 =?utf-8?B?emU3ZVpOZnU2QjU4YTEyaDNKUFhZRmlvNjk4VEc1K2xobjdFcXpJZXZ0M1lC?=
 =?utf-8?B?czNSRDZSYnBKd3JqdERtTkFhclYxck0reDRqU3NzOWFvMHlGcEp2aXhGeEhE?=
 =?utf-8?B?bnpiUWpyd3ZZR1dOUnZWS1RoZHkyck5oVlUvTlhoNXE0aEtnMlJicHNabGdq?=
 =?utf-8?B?TjQyeThwaDREdmVIdjdvNjYreWdkOXpGZFJkWHppRnl5YUlQc255YVR6Rmx0?=
 =?utf-8?B?TUlHTTNJRHozaWt4NzVLYVpmU0Y0RUVuTWZUeXFxRjR3ZGNCNVZhMGRJdjNY?=
 =?utf-8?B?T1I0QXl2azkwaDIwY0szWWZDQjVraFRvRkNVd2l1blhWR1ZxaW52YzJScE85?=
 =?utf-8?B?d25JcDcxTEhkdHd6eDVoKzVqVVAzUVdYN2VPaUVXZzB1bEVDUFI2VC94ZUlq?=
 =?utf-8?B?OXowcDlabWJOU0RRdlhrOFgzeVN5d0RvNGdTWkJnb0crckZQcUd1bjVobDhG?=
 =?utf-8?B?cWVvOTVpY2pmS1NmcFZpejlQaENjWE1iUG9XV1RkTWJKWkxTWTdQWFFTMVJk?=
 =?utf-8?B?a1hpcUF1bWNYYWlQVG9vWjR4ZUZLRmQ3dUNZVUJieGQ3SWVTZmF6RGlCUHVT?=
 =?utf-8?B?dGlxMlpOM2Z2b0V5dlQyOEw5YlVodmZOQmpEQ3hISWxRbENMK3ZRcWNXWHA1?=
 =?utf-8?B?c09mZkVIU2pRNDJDMGcxeFJ2Q1RnWVBybHNaNXFRb0x0VmROdE5nTTlqRitS?=
 =?utf-8?B?bmFUUlZhcDk4QTRCaXh4LzNYSVBGVEtTUmNzZzNRSDA4UXRIZlBpelQyVHhX?=
 =?utf-8?B?SSsyY01uRlhoUno4UjBiZFpMRkJvU2UwNDVFQzJOanBMbThsN1BCTW1ybkla?=
 =?utf-8?B?c0dvZ29nc2VyK0F1SUR2VXBiTUcvVk5NcTUwc3M0aHVLOURzZXN6WUxEWnNa?=
 =?utf-8?B?aFZNUE15MENOSnd6OU1VWFJIZXgyUUdFZUhiYnU3TmR4UnBKYldLT213S2FJ?=
 =?utf-8?B?YkhYM1d3OEprcFdUT1ExYzJWbm5kZmJ2UWlCZU1JUDJMc0l5ZGgwWVB0NDg3?=
 =?utf-8?B?UnFHV3NTa0ZHLzEwTE5tUmlUR1RwS2RlbG9DYlNFK1hFOVUvNkxpejkzeHhu?=
 =?utf-8?B?U3NvcVh1enNzYmJFZ0Jqbm9KbjFHY0plVGhLUFlpdDhKTlBjMUpicklYN1lk?=
 =?utf-8?B?QTZGU3BGZUljdHJnZ2NxbEpLTmViNUU3UWU5ZE1IUXd4WWFWK09ZWmNPMllJ?=
 =?utf-8?B?WkRjclZnMHllZlVlQjAxTWlZY1p4N2IzeVBzcmJObTExODl5K3FuQU9XTm1h?=
 =?utf-8?B?b3czWDRJcTFKdEgrK2toMmRhb1dqY1ZEK0w0QmlZTllHM2hNdmpEaXdzWHVT?=
 =?utf-8?B?OFViOXdUc0hJK3luSUlEZ09xTVlGVStuajQ2dFlsbUtEM1ZnNGtsNEJjUUZS?=
 =?utf-8?B?MUV6TTI2OE9nZWc4RUVSMXorbU8vMUdNWjczUTN2ZVVnNmNyc1RUczJnSVVi?=
 =?utf-8?B?RHI4eWVxdTN3UlIyb1dVTE9aVTliYVVYMHVhak1ZbEJ6NFlXUndpUUZsdWl0?=
 =?utf-8?B?d0ZPZ0RLSldOMWxUTWh0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkMxVElGanN4a1VQZ1RuM25YL1BvZDdMTnhSV09LQVdQMnQ0aEJHc2FhL3pG?=
 =?utf-8?B?VWxQUWlMdTZzUlkzOUxCL0xHVHVkeituZnU0UTd2OTdHenJIRGdKNTl5QTN6?=
 =?utf-8?B?dGFXTnJZRGF1UGRmZ29MREQyekphQ2o5RUtzdy8yUk5NZEp3TEg2RUVsWDk2?=
 =?utf-8?B?YkZGejRLNVZDVmtJWmJKd0QzZ21sdUs1cTBXRlpBR1RkTGx2Qmx2Z3dncy9Z?=
 =?utf-8?B?Y3VLcENsTGYyamVNeVlzUk5NSVpCWldYR3NxL29mWU1uSU1NeEk5WStld2pP?=
 =?utf-8?B?YTJQRzl5N3U3Lzh2UEdUaGJZcDBCNDYyZXlpMDNOTnR3QU9TTjJ2c05nb1Bq?=
 =?utf-8?B?eFNGK0YvczB2ZmZCbk9rUjBaRXQ2amxmc2UxL1RCU2kvSjFyTWc5cWZRNjlG?=
 =?utf-8?B?YXRwN2pkMjc5TStSNHZ3aXRsaFZOUythRXdMb2RBRGxwUXVkRXo3MmRJL1ZC?=
 =?utf-8?B?Qi9LdVlubFhLTDBLL0NIdHhEZVFUMlBBM2NTMThyNURPZmluc3BBUG9sdXl6?=
 =?utf-8?B?eGJ0UHlpWldyNExMd3k4dXlkVlY5dmIwVlNmeDdlWS9JOXNZK0l4OHk0MzRR?=
 =?utf-8?B?c0tGaDk3SEtlV1NHNm5SbWRubHpQb2E1aFdOWENOOHgxcHBZTGhIQ1RYN3hU?=
 =?utf-8?B?WTJJU2FnUFVCNGdVZ0k0anYrR2NFQjFsc0Y2bGJlVmE0bXZFZDE3STl0Vk85?=
 =?utf-8?B?UUN3dU5YZUlPZk0ya2tBeXpFNVBlS0FEeEdWWTdnbnl3ZVpCbGZndkFYMTNU?=
 =?utf-8?B?UkRuVkhvMXZ1WGYzY1Z4eENyNUxNeHlTbmpoSmdkbkM4NTRTbndlR3BzWkdi?=
 =?utf-8?B?eEhrNHVFN3dNQ0dCelU0WE9kTjJqcUdzSHo2SFhPcXl0aWR5OVRLbGVNTGV5?=
 =?utf-8?B?R2IrN25nYWYycEhMQitGMUtwS3ZVb3JXUUpncVVSSUZocnp0NERYcnNrOU5X?=
 =?utf-8?B?Vk5UTXV1MkpOdVBJc0J4YStXd1B6NmZ4QmM3TG9mMGtrTW12NzRHeU1YRkdX?=
 =?utf-8?B?dlJBV3ZSYjh1NU80VVFPNVp0L05NcUNzaDJ5NG5SQWVrZ21EVmlMRkwrNDdj?=
 =?utf-8?B?RUEybWRmaUd0QVI1aEJjU1JQUVM5a1A5NWlqR0k2bXYvTFlHb2pUU2dxQkxC?=
 =?utf-8?B?dUNhOEpqeXlpL2dPT3FlQm8xS1NubCtGM1ByWGM1c2QxUkhJNGt4VldMMUMy?=
 =?utf-8?B?V3NSa0FodnpWcmNhajlaOGo2VzBpYTFZdXVNd0Z6REFRdkl2VGtOWk1FU3RQ?=
 =?utf-8?B?M0FXL2J4bFFhVDcvc08vU2FrTHFhSlRRRW5GTXp6TVVEUFlFK2xCZldvYkd4?=
 =?utf-8?B?V1hyUzdkYTVnY3hDTjZWZjFUZzNvOFBsaFl5QlgrMWU3UnU5eEEwNHVDZUQ1?=
 =?utf-8?B?ekJpTWdKcUMySk1kbDlma3VOYTh5Unk3eUlDYlNDemlLcEc0T0E2RkhlbUJo?=
 =?utf-8?B?bDBjajNvN01yb0syemNPVW1Bd1dXdDl4Q3FjZkpxNHdaM3VCeDVwdHU1T1JW?=
 =?utf-8?B?OHB6MTRFclQ2VVBOYllYb0N0bkRoZkRBVHdqWUVucDl3cms2UC9tZ0J2NUx0?=
 =?utf-8?B?OFlXb2kxTWw1SWkzdFJhZWpaaFo2ZHNwb2JzMkUzdytqbWdLRUgwT2JUVklG?=
 =?utf-8?B?YXAyZWw0MVppbHdLWkwzdXNRMGgwRjl4NjVzZTRVY1VGWVhkaEdaN2RjTUo4?=
 =?utf-8?B?T0MvQzBoc3EvQnE5TU1zMmt0NkFLdWY0Wk9ublVBaTh1cHRqSlpmMjJ3ZEdN?=
 =?utf-8?B?UzhvZWlZZkxZdlFlQi93OWxBVy9tei9xOHFMU05KRldvNTBkSFZZV2VibEVy?=
 =?utf-8?B?R2pQRzdFbjZxQ1Q3Y0NtUmlQak5PTksyUVFPdWw4b08wZmRpaFllcmxXc1g2?=
 =?utf-8?B?NnR5cDBBNWp4UVA4VXhqZVNTcFVmRkYvWUtYRTN3U2Myd0k2NGpKVkQxWnZQ?=
 =?utf-8?B?aW43WGY3UGtjaDJvMjlmYUY3WTU4SElZY2lkVm8rNmFMRG1Pa0dwaEZEN2dt?=
 =?utf-8?B?S0Jibm5takFuQW5xeTB6ZTRiRjJ2Wks4QUYxaHFlcmJ6ODJNNm1FRm40bUNk?=
 =?utf-8?B?LzNGbzk4S0NGR2E3US9GNktNM0Z2c3FJMnlIeVcyMUMxRmQwaEFmcnl0dUtx?=
 =?utf-8?Q?HkzUYn6dyIYwWYQh7kmZInBF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8288758-250b-4fbd-28af-08dcb8cc266f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 23:36:53.8977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlQ/pBpGfBcXks7SZGDnvPUy4lzNsxXjw9NGYPUmjvZaNXe+1HyBRNH1EmHWH9lzh+0bbMU0CHwYV9zwxtSY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
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

Maybe we can turn this check into a warnings if, and only if the 
exp_hw_support module param is set. That way we don't water down the 
checks on the production code path but allow experimental setups to run 
without a seat belt.

Regards,
   Felix


On 2024-08-09 01:39, Zhang, Yifan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Yes, I think we need that change for a normal code path, but this case is introduced only with the HSA_OVERRIDE_GFX_VERSION environment setting, which implies that "the override ASIC is compatible with the real ASIC." It is intended for experimental purposes. When a user is using HSA_OVERRIDE_GFX_VERSION, they should be aware of the potential risks it may bring. Usually, HSA_OVERRIDE_GFX_VERSION is used to force an unsupported APU to be recognized as a ROCm-supported high-end dGPU, which has a large cwsr save area, making the operation safe. This check was added to KFD two weeks ago, the HSA_OVERRIDE_GFX_VERSION environment had been working fine before that.
>
> Best Regards,
> Yifan
>
> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Thursday, August 8, 2024 10:46 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: keep create queue success if cwsr save area doesn't match
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> In this case, shouldn't larger of two sizes be used. Also, we should have an upper bound check.
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zhang
> Sent: Thursday, August 8, 2024 4:44 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: keep create queue success if cwsr save area doesn't match
>
> If HSA_OVERRIDE_GFX_VERSION is used in ROCm workload, user space and kernel use different spec to calculate cwsr save area, current check may fail create queue ioctl. Change error to warn to make create queue succeed in that case.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index e0a073ae4a49..9f283aff057a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -295,11 +295,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>          }
>
>          if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
> -               pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
> +               pr_warn("queue cwsr size 0x%x not equal to node cwsr
> + size 0x%x\n",
>                          properties->ctx_save_restore_area_size,
>                          topo_dev->node_props.cwsr_size);
> -               err = -EINVAL;
> -               goto out_err_unreserve;
>          }
>
>          total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
> --
> 2.37.3
>
>
