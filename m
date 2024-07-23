Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E09C3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 11:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723FB10E57D;
	Tue, 23 Jul 2024 11:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3oyZGu1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D33510E57D
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 11:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTAZjpFN6lJ6KAoVU5C/40KP0CvO9ResPKFwYTczOBGXEW8QpX8SeHazNfmy1908PJ4g6cwsENWPEYZoNu9yXY2Zl71CBupF9vbg3RsiJL8gsTeIG654BpT3Pd7joX1uL5ZNv/+J2CSZShhZl56C5QOeMMdJmqe7n/vpzEX66ipYWFNc9LQRZezAiPrinFAJfF3waV3/+vEAKMRhfC5CHUS2hv7ktJEt4XrGBrVvZxIxZmDltDtAvhu+KbOCwgleQHN0kHWuk9xjksR4b1J4dFzXGPg1NijuaZll+uUklINCDVF0bVkaq9ioIg+RQLC6//flfVLaFIzFJMpdx+KS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei/guK6irtwEp7u7deFInpoAzmT0irtlNh5u8PiSCOs=;
 b=yyLvKeajUebiPH5XGZ8Q/Eh5IhJlntK/Y1KoeLeLA6GLUatTbt/JJyKi2HPnQvzPrMMCs5h8d7ZWiInOAEnu59qHFnWIQ0PWHcQknvZyrJLXmxAYwebMkT+t4SUn0v4a6jmILQy08YDo4kfjgh845Fa+stZxc1INAJl733dcGCutW7U5o37By5JBMf5ghoIMdKa+SToJcVA9aWOfHnEtjYhlRq1+PRNaxe3nXlHcNgaGnF2/HgMwe7TKMWQwzcr6eePVqwjL67yDEMo7Yk1UfquAPb4kpjuP560TrSJJReQb47H7yvOV0N6RzhD8dUc3MvDyvrIct2abr+8joRTwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei/guK6irtwEp7u7deFInpoAzmT0irtlNh5u8PiSCOs=;
 b=j3oyZGu1GBkCxzvF9X8lijUeEn/YaIe4Xy2a3iXO69ZY9JWYnlvCbyyQWCz8R9wHBYmg+ZQmq36F5y7kWaZ4S45J1pS7EstIX2fyfhzWlUr13IqkLWFb+8d7Usha8aqDBcOm+wY9feDPTLPwtB6HuBkXbbprH4l8Zj4WCvgynso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 11:46:32 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%4]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:46:31 +0000
Message-ID: <bf3c0116-a37f-4105-ba90-bd304d2ffa4f@amd.com>
Date: Tue, 23 Jul 2024 17:16:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add missed harvest check for VCN IP v4/v5
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com
References: <20240723110716.313756-1-tim.huang@amd.com>
Content-Language: en-US
From: Saleemkhan Jamadar <Saleemkhan.Jamadar@amd.com>
In-Reply-To: <20240723110716.313756-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::14) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2034abc8-09fb-4888-e83d-08dcab0d1897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGowZjFneUhCUGJHVW5KZW5ueWFhUnJ2L1dROGFaaHMxYzc3dG4vTVZDdUUx?=
 =?utf-8?B?azVCOUhmU1k3OHFpcUsrU1BGeUFndE5kdCswZENVQW5TWmdRZHl6M3hGalBH?=
 =?utf-8?B?UUQwOS9ZN0FGcjk1eUxscHNTNEVhbDlsMnRNNjlFTnI3a3B6a0taa1BqRXAx?=
 =?utf-8?B?aURYUlZ0MGVnSEdaajN0SzhYanRzQ3BYZ3JIblpMbEVMU2wxQ3BZSjhqdGI2?=
 =?utf-8?B?dEpyVFJML3R5WU1aMkxhYWRwbnRPcnhpd3Qyb1M4VmI5T0xMUXB6c0llRnNX?=
 =?utf-8?B?RFhnclNzTU42dkVxS3Y2bHJra3JlOER4aE5pR3hCb0lEeURNWVBoRUw3QjVm?=
 =?utf-8?B?bFd3K1VLdGxhTTRoMjJCdlJIVFhsZzZTTGMzOGtpdk5GVldNM3RJaFkyZHlE?=
 =?utf-8?B?T0g5cFYyM0dpc1RycGM0THZ2Y3N0TzhRakhaNHg5VXRYM1UrR1h6M2JlT3dt?=
 =?utf-8?B?a1ZaanJ1L0sxVXlCMjJLRlZuYWpNUkUwTlJ6T2U5aFVlcE5hMTJadkxZeTlj?=
 =?utf-8?B?eFlIcWQzYTIwL2ZHc0hvU1IyQmlEaGc1dkZmZVBpNTlwMHA2Qk04YzVEd0gv?=
 =?utf-8?B?eXNXTkswUzdPTzdIZDBOTVdRWmZuSWNuNm5kVXF3bnpuL3l1eWljamJ0cVJl?=
 =?utf-8?B?U1BDRVQzRkx1SnZmU2dLYTVYcGJFRXk3R01pR09WdWtQWm9vNytoNHZKUVdl?=
 =?utf-8?B?MWZBekcwaXBNbVhEa0I1N3hZTldZSzJuNjZFWnpZaUNRTytHSzhGMnlYTkJ4?=
 =?utf-8?B?YUhSL04rcDV2Tm5NdEU5dytIRTZXZkRkUUh2ZFhOaWlDd1ZWTUZlTjJYNy9S?=
 =?utf-8?B?T3RvdGIzUTFIV0JUOTlBbEdqQjFHb1Y5b0tmMSs3RFUxUUhmRHJDdEduMXF5?=
 =?utf-8?B?cVZKL3J3VzJKckdLdVhyVTVnb05wS0h6Tm0yKzdGS25vVmtPNGFkd0pad29u?=
 =?utf-8?B?OHl3OWQwYk5NRE5aT2pDb0V3QjNCNzRDU0UvTUozSi83b3JuV2pPOFc4V09W?=
 =?utf-8?B?emR2djhTdXB6aUNPOEdESWRPMmg2Wi9qMlA1Tmd5eHZBdWQ4Z0NTbUdRTGph?=
 =?utf-8?B?SEp2MURXckxERkFUUHpKQnh2L1BQWC95VjZHYlF5K0szOHVWcjBMZEJvT0pY?=
 =?utf-8?B?T0NwallqZTJxck9xZVk1anMrRFlWV01uZ2V3L28xNmpVNGorRy9SdlREOHZZ?=
 =?utf-8?B?cVB0b29WK1J5NVhaTXZUWTVsNTE1VWN5Yldiazk2c2dXRmVKZDFZWTZzeGlE?=
 =?utf-8?B?c1pyeFFuNW5jTlBLTW5SRHc2ZWdsUktiaGVMNmZsYytXbzNqK2pVcGJETlBZ?=
 =?utf-8?B?RnhjREMzVHlSMGZnRzBNc1FxUHJwMGVjeUp3ZUhJanVKT0NFaHBKYXllcWtt?=
 =?utf-8?B?V201NnZJK1JMQ0tWQ2ZpUTI2aDB5cWFOa0tCK051UnRKZ0lsdVc2R2Y0Szhj?=
 =?utf-8?B?akNEQjcwakJiOUZDWGJpK3g2cEljUWxNUzd5bFUxQkNXMnNKRzZ3VUtGVVlj?=
 =?utf-8?B?WmJZaEJtSVVCYXZrRmh0SVVNUEx5eGpmcDUrUTYreGtRbmxJSnJpWDdhZVVK?=
 =?utf-8?B?VmZ4blhKUW1FUk9iRXhHVlk4VUVtQnRBZS9TRGI2RkpwQzRnTFgxZTdmUFFP?=
 =?utf-8?B?dUpzT2FtdFlRcno4OFVYNlVSMk4zeHZWQXRjOFY4d1VHQmtnOXNXZ0Njd3Ba?=
 =?utf-8?B?cjBnVnoyejV1N1BDdTdTMHloQ1kweWZldGhqR0puRnVHaUs2c1REdWlYTTZE?=
 =?utf-8?B?Wko0Tzhic0cvRFdGditIbHJvUlNWUWtnRmNCdll1aXlkbUVBeStMU25tSDJN?=
 =?utf-8?B?ZWY0S08wcTRDdldjNlNwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpUdUU2azc3Ly84MG1uMXdKWTFyOUNoSHV5NWE3WjhLOG14UndEY214bDdR?=
 =?utf-8?B?MndmaHdqa1VHV1hzVGo1MHFJNVdPYnFWVWpmb3NUM3RUcXFUYXhKclBqRHdv?=
 =?utf-8?B?VklNNEdrcXZXYkI1eVV1VHVpZEJtUnp6eERJaXF4U0pQYkZZREVTMjdKSHlt?=
 =?utf-8?B?VFpkbWx3L2RnSVJvUzhtalV2dGx0ek94SFQ2Vis2dzBpMjYvNy9URGNBQTNJ?=
 =?utf-8?B?b3d1d1cvWVpBZHRVQjJRbVl5S21nWWgzWkVrNDhkRlpHaTRyekcxdXlZQjJS?=
 =?utf-8?B?RGx1OU5LcHFvbUVSc09Zdnp3bTJXd2FoNlN0MGxtZkxSTGY1VVMrZ2VuTThF?=
 =?utf-8?B?VG9OclNYaS90RGxFa3RYU09VWnJIZEZGL1dZeHcyYTRZV1cvYlJDRFhzYmVp?=
 =?utf-8?B?Z2IyUjV0eVNiUjhFSWdTdGFpWXhZMDZQOXhQcTRvQ3gyeE50bVVxbS80UXdL?=
 =?utf-8?B?TDZNUDR2MTZDOXNGMXVXTmtGMUxCRlNwWDRSRzVTOHdJc25ldEZuekRkeGFU?=
 =?utf-8?B?ZE40ZlRoeFZhZHRNWVhmbm42aWdTN2NVYmZpK1ZjRmsvN1R1OWVtRVRETjF5?=
 =?utf-8?B?V2VJYlFHS2ljcUgremhDL2tya1VHZkhIZGl0UHhvRzRkUnNHaGdBd0hwN2tr?=
 =?utf-8?B?clN0bXdTRHZMWEtZeU91YjVRS0J5TGpZN0wxSlhtTlViMS9hZ1pIZjNjWHdx?=
 =?utf-8?B?K08vSTF6ZThVRGR3aXhYemtZOGpXcFFxWHJ3Q3k3dXRubU8xS3R1NzNvd1NG?=
 =?utf-8?B?NkRjVW1ML0I5aHhVK1o3b2hva0txNWdwZ1NnSWtzY0lZdTNCUUdRSjdRN0Fh?=
 =?utf-8?B?NnAzV09RNUF5bWxFaWgvVU5nekllZVBub2c0clNqMHVrNWMrK1pVeUdXMVZn?=
 =?utf-8?B?MEdNaGU4N1hjZ1plL0ZUMEpEYjNvbEE3RlcySnFkRGZtT1A4TDc5TEVPeVBR?=
 =?utf-8?B?QVY0Slk5SkhXaksvNjdQQUhGcUpzL3ZzN1N6d0JSSTR1OVphanc5K0F5a2Nu?=
 =?utf-8?B?SFY2VEQxQ09oenNaSDVHRml4L3lqUGtFZ0lJODdCMndIVmtFNFA5UDlsUlVy?=
 =?utf-8?B?OUpsVk5sdHJhUll6KzZGSDVzSitYeXpjTWpDUHc3ZHdNc2htUExrdnJtZzFm?=
 =?utf-8?B?cURoMzVaYTJBSU5KVUJFUENneWhsT0dHTUZMYlphcytwQWFBR3lVOVhZM0hU?=
 =?utf-8?B?NGlFbXlDa1RZOXZzZWtLdzQyelJYcHlLSkVJZ2RSWUxBcS9Ra3FTS09tYklQ?=
 =?utf-8?B?ck4xTXVDZXVrQjZON1dFUkRITkplMDUwNk1aeUVXSFF3dU5TbDMvZWlJalQx?=
 =?utf-8?B?M1ZXNzBYdk1HUWhUMUhYbHlPWjJOcW1xT2pKMWxTWExCQlBGNnlJbkgwVkRt?=
 =?utf-8?B?SUkxN29zdWRaQmpuRVBFRTBBSmppN1JqdFArVHEvVkVDUWZPcHFySzhCc2ZK?=
 =?utf-8?B?VmRpYlBkcUNwajAvM2pnNXovSDloazg4TFhFQ0czbHFJZGd1VXR5K2NzSXFs?=
 =?utf-8?B?Z2E1SmY4YnhCZ2p4Ry9xemVGSUVCcW1VMkRkcHc0SVNvaXNxc1hqakQ0WGxw?=
 =?utf-8?B?bnpmZGVXS1lSWmluNGxHZEkzbFp0R2RuYVJGbFNsbUxDWElmT0dOS1ZnbENK?=
 =?utf-8?B?TC9ianZBQ1JYLzM4bm1tZDhZcDRNcmRLTWk4SGxYVmZsTVZGSTZXRlBQNU1N?=
 =?utf-8?B?UkJjaGRqSi8xNVU1Yjd0WFFhOTZyUlJ0dlRrdGtKcElyTTJWUTFkd05aUDdT?=
 =?utf-8?B?cGN6YWVmeE5XbHJlRGQ2U3UrSGlwNlR0dVNRTjgxUlN5L3lYN0VRaXBWUGNw?=
 =?utf-8?B?UU1WcXdobFBKNDhiUHBGYmZvQUpaMTRycE9BZmJLNERvWVMxUnBGZGdVS3Zp?=
 =?utf-8?B?amROUFRwVm8yOUIzeUdSMnVtd3hGTnRmMXFwYTB0TVNSZzh6bzFFOCtJcmls?=
 =?utf-8?B?a0Y1c1lXV2pacTZ6aXdURjRBVWlDT3J3TGRuVkVKWmxGQUdNNVMwNTc3Rlcz?=
 =?utf-8?B?NDVyOWN6YzArZ3hjNXlBTWhLcG94RVIzc1JtNkcrNnM4Y1NVWVBmRGlRdEZC?=
 =?utf-8?B?RWl5N0tCL2tTTGYrcDdCU0tXMUo1dWZsSjVscXN3UFhuK3VzYUlkQmhsMjhJ?=
 =?utf-8?Q?/1Pt4NiiOIs0Zw0t8xsFVzITG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2034abc8-09fb-4888-e83d-08dcab0d1897
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 11:46:31.8648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5YZXrNRMyROAJkkFsLtxpOwHYbBxGAbRLWdBzMJCPQM4zaR6ZvRUSGxCpLkXhPEErc98EfTIynBLuc7HXumRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
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

Hi Tim,


Looks good to me.

Reviewed-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

Thanks!

--

Saleem

On 23/07/24 16:37, Tim Huang wrote:
> To prevent below probe failure, add a check for models with VCN
> IP v4.0.6 where VCN1 may be harvested.
>
> v2:
> Apply the same check to VCN IP v4.0 and v5.0.
>
> [   54.070117] RIP: 0010:vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0 [amdgpu]
> [   54.071055] Code: 80 fb ff 8d 82 00 80 fe ff 81 fe 00 06 00 00 0f 43
> c2 49 69 d5 38 0d 00 00 48 8d 71 04 c1 e8 02 4c 01 f2 48 89 b2 50 f6 02
> 00 <89> 01 48 8b 82 50 f6 02 00 48 8d 48 04 48 89 8a 50 f6 02 00 c7 00
> [   54.072408] RSP: 0018:ffffb17985f736f8 EFLAGS: 00010286
> [   54.072793] RAX: 00000000000000d6 RBX: ffff99a82f680000 RCX:
> 0000000000000000
> [   54.073315] RDX: ffff99a82f680000 RSI: 0000000000000004 RDI:
> ffff99a82f680000
> [   54.073835] RBP: ffffb17985f73730 R08: 0000000000000001 R09:
> 0000000000000000
> [   54.074353] R10: 0000000000000008 R11: ffffb17983c05000 R12:
> 0000000000000000
> [   54.074879] R13: 0000000000000000 R14: ffff99a82f680000 R15:
> 0000000000000001
> [   54.075400] FS:  00007f8d9c79a000(0000) GS:ffff99ab2f140000(0000)
> knlGS:0000000000000000
> [   54.075988] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.076408] CR2: 0000000000000000 CR3: 0000000140c3a000 CR4:
> 0000000000750ef0
> [   54.076927] PKRU: 55555554
> [   54.077132] Call Trace:
> [   54.077319]  <TASK>
> [   54.077484]  ? show_regs+0x69/0x80
> [   54.077747]  ? __die+0x28/0x70
> [   54.077979]  ? page_fault_oops+0x180/0x4b0
> [   54.078286]  ? do_user_addr_fault+0x2d2/0x680
> [   54.078610]  ? exc_page_fault+0x84/0x190
> [   54.078910]  ? asm_exc_page_fault+0x2b/0x30
> [   54.079224]  ? vcn_v4_0_5_start_dpg_mode+0x9be/0x36b0 [amdgpu]
> [   54.079941]  ? vcn_v4_0_5_start_dpg_mode+0xe6/0x36b0 [amdgpu]
> [   54.080617]  vcn_v4_0_5_set_powergating_state+0x82/0x19b0 [amdgpu]
> [   54.081316]  amdgpu_device_ip_set_powergating_state+0x64/0xc0
> [amdgpu]
> [   54.082057]  amdgpu_vcn_ring_begin_use+0x6f/0x1d0 [amdgpu]
> [   54.082727]  amdgpu_ring_alloc+0x44/0x70 [amdgpu]
> [   54.083351]  amdgpu_vcn_dec_sw_ring_test_ring+0x40/0x110 [amdgpu]
> [   54.084054]  amdgpu_ring_test_helper+0x22/0x90 [amdgpu]
> [   54.084698]  vcn_v4_0_5_hw_init+0x87/0xc0 [amdgpu]
> [   54.085307]  amdgpu_device_init+0x1f96/0x2780 [amdgpu]
> [   54.085951]  amdgpu_driver_load_kms+0x1e/0xc0 [amdgpu]
> [   54.086591]  amdgpu_pci_probe+0x19f/0x550 [amdgpu]
> [   54.087215]  local_pci_probe+0x48/0xa0
> [   54.087509]  pci_device_probe+0xc9/0x250
> [   54.087812]  really_probe+0x1a4/0x3f0
> [   54.088101]  __driver_probe_device+0x7d/0x170
> [   54.088443]  driver_probe_device+0x24/0xa0
> [   54.088765]  __driver_attach+0xdd/0x1d0
> [   54.089068]  ? __pfx___driver_attach+0x10/0x10
> [   54.089417]  bus_for_each_dev+0x8e/0xe0
> [   54.089718]  driver_attach+0x22/0x30
> [   54.090000]  bus_add_driver+0x120/0x220
> [   54.090303]  driver_register+0x62/0x120
> [   54.090606]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
> [   54.091255]  __pci_register_driver+0x62/0x70
> [   54.091593]  amdgpu_init+0x67/0xff0 [amdgpu]
> [   54.092190]  do_one_initcall+0x5f/0x330
> [   54.092495]  do_init_module+0x68/0x240
> [   54.092794]  load_module+0x201c/0x2110
> [   54.093093]  init_module_from_file+0x97/0xd0
> [   54.093428]  ? init_module_from_file+0x97/0xd0
> [   54.093777]  idempotent_init_module+0x11c/0x2a0
> [   54.094134]  __x64_sys_finit_module+0x64/0xc0
> [   54.094476]  do_syscall_64+0x58/0x120
> [   54.094767]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 6 ++++++
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 6 ++++++
>   3 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index f6d96a44d75f..776c539bfdda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1045,6 +1045,9 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
>   		amdgpu_dpm_enable_uvd(adev, true);
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
>   		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> @@ -1498,6 +1501,9 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
>   	int i, r = 0;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
>   		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f45495de6875..8d75061f9f38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -958,6 +958,9 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
>   		amdgpu_dpm_enable_uvd(adev, true);
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
>   		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> @@ -1162,6 +1165,9 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
>   	int i, r = 0;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
>   		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 070b56610c7d..68c97fcd539b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -721,6 +721,9 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
>   		amdgpu_dpm_enable_uvd(adev, true);
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
>   		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
>   		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> @@ -898,6 +901,9 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
>   	int i, r = 0;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (adev->vcn.harvest_config & (1 << i))
> +			continue;
> +
>   		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
