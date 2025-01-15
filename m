Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64BBC02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 19:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F6510E7C8;
	Wed, 15 Jan 2025 19:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xHRuktjR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B5610E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 19:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJXK3gbcjyrD79mxMjW3NrUfWFJoYQ14/THMJ54g6o0TEe8UP/5/TOMIM+WHTnzFFkJKsrkHXram+9CKorNlZocwcUGupkWGRKUvq0pAjG13PkpMWSAQlHdT2sbV9C/Er/ufh27vaH86Y0pc5eQk7x0NaHXrswhsDxN1Uc0J/L70jgccMABMvGuC8aTYCR/ZnycXA6qtmJ0mVuF90VQokUcS7mg48i5DWfcsHRBS9XCwsSL3LDjPhRa0+gE5kbmQCi7gq1jiVDgBW6ja2y81NpQsgmTbnMPVuwC+9WCAEVRoGZDf1Aa4kb+lELd7/js2ty6IzZxPTo+B4JaqMCAwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVg4LcYRad7p/GzZYCHu2XcElyR1QcZ9q19aIgX5h4Y=;
 b=EPXxYf4md9FoSkFeXkSUaAEHi1fYH39YBEfX+GUPzNdadVxiH78U4FOmi3WZ+aCG5mn09zPv8ZSswDyxXhBBpCQOq3VAxpS4n3zTwU2X/VVEEW+ctHozL9MrQ94PBBmsGm3mmYU2+PAzjyVkDa00EJhQ784po+iSZQaNhD3ECd/wwlrfyXCAR0luR1pw57hd7qqSaRj1tYDCxaVq3rYG7S4ALVqse14hHbA1fmalLN1Mg4cKpxzPDGyOZGvSJWAnjz9ksS/uW/+JNtFn1jeYObBLJZmTHogpP7vka8CNHVkCFLtgzec0iOhUDIL7bi3PXdXIxVXo0yxMphG+VobDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVg4LcYRad7p/GzZYCHu2XcElyR1QcZ9q19aIgX5h4Y=;
 b=xHRuktjR7RxlEGF0WJ/Pn/S7XIy40KCU5Zt3NjLt+cfjVrOVB7yv0XIlM8cVi/PWsaNU9o7Sfpd4mFTBWiZWpbjRcBOZSZAWXI6h5TO8EwpMIk46OyQiC90t5992Gwo/Y5GzBKEdZexMNobmgszumsjV0TKkNWsiBtElMVnXx7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 19:36:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 19:36:45 +0000
Message-ID: <28fc2420-2b9f-4416-b04c-7267f5f90cbb@amd.com>
Date: Wed, 15 Jan 2025 13:36:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 10/15] drm/admgpu: make device state machine work in
 stack like way
To: Gerry Liu <gerry@linux.alibaba.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <f9816814dd71316bf371c01c5f4d71ca85954ade.1736732062.git.gerry@linux.alibaba.com>
 <69691ba3-454b-4185-b789-00655829aaa4@amd.com>
 <2C342A4B-DF28-41EF-A26E-0D1ABEE076FF@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2C342A4B-DF28-41EF-A26E-0D1ABEE076FF@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0143.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d206f9-b500-4fd2-c3e4-08dd359bf1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkxxQXRUVTJKaXlZY1J0ZWt3Unl5R1hmbkZmSTBuQWFJNDF3V2hwdUN2eEFV?=
 =?utf-8?B?YnN1QWsrMFlQVGNXY1RSaEtjM1NESXM3QzZ6d0hjdHhPNzZuZzlPNEdVZndo?=
 =?utf-8?B?S2NEQ2Y5b1BmRUNYampJSkNkNXk4U2tTTXFLTitGSzFHMW95Z0JNVitnSkU0?=
 =?utf-8?B?cS9vSTgwV1VRWVlNRjlsS0xlQ1ptc0JlcDM1WlRMYlMrZkpxd2QwdHF5RUNE?=
 =?utf-8?B?QzVLRStoZzFibWpyOUtJVUlKUkFUZ2syREJkV0RVOG1taHpwZjI5eDhyeUsz?=
 =?utf-8?B?ZmlEbTJGcW0yRW11b3VsT1dPM3VhdW10eDRmNGRsUGZIOTlxVGM3TU05Q3BF?=
 =?utf-8?B?c1RFZDNSWTg0cSsrZktNbVlCYkZGcjkyblBDczFWc25MVjBnZHYxdkFReW1Y?=
 =?utf-8?B?NnZacERackkzSS9vaWxKdkdWN0dOc0swbTNBa1RScXIxb1I3K09wdDlVWjJs?=
 =?utf-8?B?dTRZbHJQUzdWVmxmNWw3bmdHNHFMSUdsMGQ4d01uaHh5RlJpYWVzc2lhVVR2?=
 =?utf-8?B?aW52ZnJHOHd4M0tvODljYVAvdmJSSUx4QU00NlpLcmIxVGN0Rmd5c3RGZ1Ri?=
 =?utf-8?B?WkpWVXhaejlDbkp0VDFpcDdyeFNYZStQR3Z1NjJxZGhUZCs1eEVTU3pYZFkv?=
 =?utf-8?B?eVZKNHdIOE9WcllZeERzQUdLK1puUG9McUQ1V3JCU200MytYUW0ybEIrcVpL?=
 =?utf-8?B?MHZmd3pDUDJCa2pFTCs4L1JTZ2wrVlhzelJtazIzZDkzQjVpdXRId0FTRysr?=
 =?utf-8?B?SWdDeW9OY3A0bmxzWFNhbGtxUXpQcTBCb1NWaEtVTmVyZ1U0cGJ3ZmlxTGR4?=
 =?utf-8?B?ZG16aHFRM0tXOXU3djk2R0lFWEh6R1NMY3c1RFhBVjl2WU96ZVpGS0IvNk0x?=
 =?utf-8?B?N0E0VkVndFNXejMrTkhzZzRaeXk2dkpneVdGbitBMnNBS0dqZmp5MS9QTUwz?=
 =?utf-8?B?ODR1a0FRMDM5OHc3THpZcnF2K3ZoK29jZFhFOEkva1VXQk1mVU02SHNtMzdM?=
 =?utf-8?B?R3pXVXpYaXpNTEhvNEVpejhCZ0VDQlRJRFJlQ1ZIZGlNVFpNM2tZUGo3eXhj?=
 =?utf-8?B?R1lBL1VTalpFWmtUQkJGTTFZQVVOaExNM1lWQ1BYcTRRMWpnTzlYMUxNNEtj?=
 =?utf-8?B?UGhzY3NTSUJtVVdVZHlGZzFkbTdRNGNNS0g5ZmFkMWRhN1Fsc1V2UTZ4ZGd6?=
 =?utf-8?B?M1BydnVoYzl3NVEzUXZZbjArazhmcWxOb1BXNCtyeVZZdlZzd2NtbzRpWmxT?=
 =?utf-8?B?cDQ1NU9XUG1SUmt1anBOelVLeFc3aG1TRUVKYWMrc052TGJiTDc5bXJjSDM4?=
 =?utf-8?B?Z3FQNGhTVXMxZHJqZkFjZE5ZQ2IvMzZjZWxpMDB5YkhJMUhlVnVkelRkd2FE?=
 =?utf-8?B?dUtsS3Ewd09JNDNwc2g0RE9HQ25xMEdLNFZGRmsxajB3VW1DdE8rVUgzd0F6?=
 =?utf-8?B?cXExTmVqZFVyeTk0N3BqaW9iQmdOYVU3eC93VHBZTkp5dnZPR1pYY3RsbUhj?=
 =?utf-8?B?Q3VKNFl1ampRdFppVlNoWG9vTW55b2RmY3RnUUQrNXFOYlJ1RVBKVjZWY1hE?=
 =?utf-8?B?ZkJCbjBwNDhwMTNkc0lZTi94ajlKRkhVV2NwdzJkZHdCN2prdVBXQnkzb3dG?=
 =?utf-8?B?c1J0Tm16Nk82K1hEajNHOEFpMENYWHREUUlMcERNTGowcTZ1Zm9QamN2aGN6?=
 =?utf-8?B?STd5d1l1NWJIWXNVcmswcGQ3KzFqOTZzNFAySmt1SWU0N01xQ0V1Nys4czUv?=
 =?utf-8?B?eW5lMXFLaWFFZ0IrSUtmNVA0MjNlV0JQMGMyZjBuWEhvRCtoZWs3clBacUE5?=
 =?utf-8?B?RFZPcDRBbmRJL0w1ZzlxQjJ3Ykp5Y2p3U2hDYVNxaGRCM05mdDdPNW5zUTVQ?=
 =?utf-8?Q?LB6RxyJnOr7pR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCtSZ2JYNmFmVE96Rmw0dzg4bGVKRGIrYUdJdlNyYlhmNVEwenovWklvZ3JM?=
 =?utf-8?B?S0w0UThENDh6TXhlaTc0bjhkMEEyZ3NQM2p3TEFuZ09OcXRzTjVlN0ZNYVFk?=
 =?utf-8?B?M2ZtSkVJaGpiZ3YzME4yaEdJdWhUcTc0MjdVTXRGSHVldzRnMm1oRVE1dXBt?=
 =?utf-8?B?K2Vub1ZuMVVwUVlScFJxTmJ4S1h4czJuVE81QjQvYW9mNEIrVk14TEVXZ2U0?=
 =?utf-8?B?RzhrNzNJRDdwdDMzWUtpemVlbWwzZkZXMVQ5cUM4RE5hZWFQK1R1U1M4VjI3?=
 =?utf-8?B?dVdYeDJxOXkxYWsvMkhzZU1hNjBNd0VEYjJXemF3Y0pXMkxaNEdvZENkRDV1?=
 =?utf-8?B?MmQvd1diQWg3R2E2bU5wdzVsVnVMbE5NY0pVa0R0VmpWZGVGVGFwYzVycjNC?=
 =?utf-8?B?Y0NaengxTWprY25tWjRvRVM1YjJHMDJSaXQrU2F3eUVzTGtNdHBaaWcwMUF6?=
 =?utf-8?B?MXk1c1JxNmRyaEhDUUpPei9rRVdyVGJTNlNGV1NwbUthandLcURXM0d3N0tH?=
 =?utf-8?B?SE5Bd2ZhN1ZHMFhVdWtnTjNyZytsb00yT2dweDh3ZmlicTdWdC93Uit6QzlZ?=
 =?utf-8?B?MThpek1EdGxMQ2g0enpIeUQ2WVBiNVJQaDMvdDVLbXU2ZDdMRFpEbUYyVFEx?=
 =?utf-8?B?ZlNPMXJzRE9UalVlMUdvaHEzTDdNcEZOQW1ORmgyTHVReElJT244R2xtMjJQ?=
 =?utf-8?B?a1ZtdHVGZnBFUFlyZEY1czlxbFNIQk5jZ3RFTXM2c211K3lzeUtZMVVxK3Vk?=
 =?utf-8?B?MnJPZDBMNzIwZitDZDhrSXJvS01XR1pUUE92dVZVUEtlbzNMZTVpQ1R5enFO?=
 =?utf-8?B?UEZGWkFObVF0UVl3bnlqV2NEOEVOd0ZhenV5Z09TdHA4cWNHdjhGZ2NDQVBL?=
 =?utf-8?B?Y2plYUcrcUZjWndZbEkzd1lUZFRoZVUwSHNLL2Y0OGZHeGcvanpac0FEeE1K?=
 =?utf-8?B?bTB2V3pnRkh6cUpzTnZ4S1VnWkg2ZkNEaVd3MFFzWFplSERWdElYRVVJRm1R?=
 =?utf-8?B?M2IyYTMxSUF6TTFEVjRjQWdIUHJOaFRRektMRUIwYnZhdEliaGJKaGkvamsr?=
 =?utf-8?B?ZFkva2FnTjc3YkVUMGJwS0RSNFpUd0NQb0lkd3hRMjhwNXM0SDA3ejRReFRw?=
 =?utf-8?B?cDVsZlNmZWg0TWRxTnNxdjNzVDd5QzVSMFZnWWJHdXBPbmlmUFhiSDZkMG83?=
 =?utf-8?B?QU81NlIyYWtZeDU0V1p3U2wwZ2JaWXdCejdBd21pUDZObHFlSUpZdmdkNDA0?=
 =?utf-8?B?ZVRkWFZRT1Q4ODR2Q0NpVzBWQ1FCK0xFSWY4RGpwbTVGMzFnZ2FZR3cxWkJD?=
 =?utf-8?B?K01iWTFKM3lvcjNMVFVwU0lEeDdPTUczeTZJV0d2bVJRM0NuSnIvN2hTNXNv?=
 =?utf-8?B?K2tJWHUxNnJoMzNXOFJrRGs5NDdUZzNqUjVQeW1XV0dQUi9BMnptcDhORTVW?=
 =?utf-8?B?Z1VRUCt4dGtxb3JRMDNVS2QrTkhjSUZtUHQzQUlIcS9pQnE0YXdrOWFwNUhZ?=
 =?utf-8?B?Wkg0ckhoZFFmSGZRVWIwcDhYY09PK2xYR2NBdmVWQ2Y4MVdFQkNmczdCMFl4?=
 =?utf-8?B?SWRIMDM3VnBzQlJ2YW1tZk5wUVNtNXdaUjRPSmJRNksvWnNEa05Ta1lTTHho?=
 =?utf-8?B?WUR4ZEFhWk03azBhbmtxSGVmOUd1Y0tVdy9zdVhab3ZvM3o5bXJ3REh2TWIr?=
 =?utf-8?B?bDU1SFpBbHFXbmQrekxwYkw2VkhlbzZMNGNHSWt2V2RQVXgxYzE3aGg1VjZB?=
 =?utf-8?B?T0c4ZkYxaXYyVVpXangydEUveFViWWFOalBSTTV6TzlkRGNPWndQYm0zNlRv?=
 =?utf-8?B?Vy9yUzVjNnJXSnFQQ0I0QVR1RG1SZjlEajhkakhJNmRhZnNHcUlyTEJUWjk1?=
 =?utf-8?B?VUlCc2l1aXJ5cVBHU1lnc1BXK3ZIK3hlSkJNeHU5YWJLQVgvTHNTYzlYK3JK?=
 =?utf-8?B?TVZNMHhJZGdnbkJuSSsrNFowTUhNQTBqUHdpVWN2Ykp3SjZ6MDFiUzRhNzY3?=
 =?utf-8?B?c21HNmtYS1ZpdytSNWJyN3pvbWllZkgvRUFXdE5BRzBxQ25mS2pNaHpqWWhW?=
 =?utf-8?B?R21uUEp1eVZWcGpnL2toeWFCbEY5aUFIYTFCZ2trV0t3TjFkYXpYT0kwYzV4?=
 =?utf-8?Q?C588Ni/Vv4k+J5ryluiSTbWj4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d206f9-b500-4fd2-c3e4-08dd359bf1ec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 19:36:45.2979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7L/bP5AZtlaYwOvj+UpTE0SQgmtEj42k32g2p5rxqfaEjQNP58Jo5LsZNFE9W68yzya09uwXMx/Z0bBfNtkCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

On 1/13/2025 19:58, Gerry Liu wrote:
> 
> 
>> 2025年1月14日 06:27，Mario Limonciello <mario.limonciello@amd.com> 写道：
>>
>> On 1/12/2025 19:42, Jiang Liu wrote:
>>> Make the device state machine work in stack like way to better support
>>> suspend/resume by following changes:
>>> 1. amdgpu_driver_load_kms()
>>> 	amdgpu_device_init()
>>> 		amdgpu_device_ip_early_init()
>>> 			ip_blocks[i].early_init()
>>> 			ip_blocks[i].status.valid = true
>>> 		amdgpu_device_ip_init()
>>> 			amdgpu_ras_init()
>>> 			ip_blocks[i].sw_init()
>>> 			ip_blocks[i].status.sw = true
>>> 			ip_blocks[i].hw_init()
>>> 			ip_blocks[i].status.hw = true
>>> 		amdgpu_device_ip_late_init()
>>> 			ip_blocks[i].late_init()
>>> 			ip_blocks[i].status.late_initialized = true
>>> 			amdgpu_ras_late_init()
>>> 				ras_blocks[i].ras_late_init()
>>> 					amdgpu_ras_feature_enable_on_boot()
>>> 2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
>>> 	amdgpu_device_suspend()
>>> 		amdgpu_ras_early_fini()
>>> 			ras_blocks[i].ras_early_fini()
>>> 				amdgpu_ras_feature_disable()
>>> 		amdgpu_ras_suspend()
>>> 			amdgpu_ras_disable_all_features()
>>> +++		ip_blocks[i].early_fini()
>>> +++		ip_blocks[i].status.late_initialized = false
>>> 		ip_blocks[i].suspend()
>>> 3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
>>> 	amdgpu_device_resume()
>>> 		amdgpu_device_ip_resume()
>>> 			ip_blocks[i].resume()
>>> 		amdgpu_device_ip_late_init()
>>> 			ip_blocks[i].late_init()
>>> 			ip_blocks[i].status.late_initialized = true
>>> 			amdgpu_ras_late_init()
>>> 				ras_blocks[i].ras_late_init()
>>> 					amdgpu_ras_feature_enable_on_boot()
>>> 		amdgpu_ras_resume()
>>> 			amdgpu_ras_enable_all_features()
>>> 4. amdgpu_driver_unload_kms()
>>> 	amdgpu_device_fini_hw()
>>> 		amdgpu_ras_early_fini()
>>> 			ras_blocks[i].ras_early_fini()
>>> +++		ip_blocks[i].early_fini()
>>> +++		ip_blocks[i].status.late_initialized = false
>>> 		ip_blocks[i].hw_fini()
>>> 		ip_blocks[i].status.hw = false
>>> 5. amdgpu_driver_release_kms()
>>> 	amdgpu_device_fini_sw()
>>> 		amdgpu_device_ip_fini()
>>> 			ip_blocks[i].sw_fini()
>>> 			ip_blocks[i].status.sw = false
>>> ---			ip_blocks[i].status.valid = false
>>> +++			amdgpu_ras_fini()
>>> 			ip_blocks[i].late_fini()
>>> +++			ip_blocks[i].status.valid = false
>>> ---			ip_blocks[i].status.late_initialized = false
>>> ---			amdgpu_ras_fini()
>>> The main changes include:
>>> 1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
>>> 2) set ip_blocks[i].status.late_initialized to false after calling
>>>     callback `early_fini`. We have auditted all usages of the
>>>     late_initialized flag and no functional changes found.
>>> 3) only set ip_blocks[i].status.valid = false after calling the
>>>     `late_fini` callback.
>>> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
>>> There's one more task left to analyze GPU reset related state machine
>>> transitions.
>>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>>
>> Ideally I think you should swap the order of patch 10 and 11, what do you think?
> I realized this when working patch 11, many changes introduced by patch 10 are changed again by patch 11.
> But swapping these patches will cause too much rework. How about folding these two patches instead?

It might be too big of a patch because it changes a lot all at same time.

Re-ordering is painful but leads to more reable patches and less 
ping-pong of code.

I think you can do something like this (I've done this myself on big 
patch series):

1) squash the two patches together
    git rebase -i HEAD~15

2) Spit it out as a patch file
    git format-patch -1 $SHA
3) Check out the commit before this combined one
    git checkout -b gerry/rebase $SHA~1
4) Apply the patch using patch -p1 (NOT git am)
    patch -p1 < foo.patch
5) Use vscode (specifically) to stage the lines that should go into 
patch 10.
6) Commit patch 10
7) Stage the lines that go into patch 11.
8) Commit patch 11
9) Note those two commit hashes
10) Go back to your original branch
     git checkout gerry/original
11) Run a rebase again, but swap out the "squashed" hash with the two 
hashes you made.

IE if your two hashes are aaaabbb and bbbccc and it's currently

pick abc123

change it to

pick aaaabbb
pick bbbccc

Then finish the rebase and it should swap them all out for you!

> 
> 
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 6b503fb7e366..c2e4057ecd82 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3449,6 +3449,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>>>   		adev->ip_blocks[i].status.sw = false;
>>>   	}
>>>   +	amdgpu_ras_fini(adev);
>>> +
>>>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>>>   		if (!adev->ip_blocks[i].status.valid)
>>>   			continue;
>>> @@ -3457,8 +3459,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>>>   		adev->ip_blocks[i].status.valid = false;
>>>   	}
>>>   -	amdgpu_ras_fini(adev);
>>> -
>>>   	return 0;
>>>   }
>>>   @@ -3516,6 +3516,24 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>   	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>>>   		dev_warn(adev->dev, "Failed to disallow df cstate");
>>>   +	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>>> +		if (!adev->ip_blocks[i].status.valid)
>>> +			continue;
>>> +		if (!adev->ip_blocks[i].status.late_initialized)
>>> +			continue;
>>> +
>>> +		if (adev->ip_blocks[i].version->funcs->early_fini) {
>>> +			r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
>>> +			if (r) {
>>> +				DRM_ERROR(" of IP block <%s> failed %d\n",
>>> +					  adev->ip_blocks[i].version->funcs->name, r);
>>> +				return r;
>>> +			}
>>> +		}
>>> +
>>> +		adev->ip_blocks[i].status.late_initialized = false;
>>> +	}
>>> +
>>>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>>>   		if (!adev->ip_blocks[i].status.valid)
>>>   			continue;
> 

