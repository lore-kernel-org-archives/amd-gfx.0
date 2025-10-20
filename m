Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CA1CCD1A2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 21:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2465010E52B;
	Mon, 20 Oct 2025 21:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2MzSvY+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286D810E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 21:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0SPGcKKBv2n+Cd9aopEjm3jtGAlsd98CjIeUgmA3MNpHE5sNcItgdSjs58az6jwio2S25scbq1vk1UlecDXFkiy3SUPMiTnqFGoM14mpqZw78/ZQebuSG6dzkMcKTRvuVKdITFoLZVrG8Lku8JJvOj+VMJK1Re0J/FZckv/G3XSKD9GQ0n8lXqrxu1t/HgmVLBZD7S2x2P37kPxH7HfW9xBs2cG6spLWUKiaYPfmMlUMU/B3X1Gos32AlZptLds62RI3DZGiGr5iJuMjo9HW8gm8XFfWo9rQIyKzqRQr2OCj+GirWZWUUOdtq3cAPht/GzRSftmz9YW+3C3yii2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h7RKrmZ5NkJ3wW2P10gDE0nyVRSmwenGqc8TaGA6wE=;
 b=sKimrWdbbXPGUUSRkgvaU6L/y0VwNCVXo4vL6IxYd2l9zNKdOEN7xx7ZXhZyDzUOxpixT3E65UFZek19xeTe0Wuti0wR+Un63FN0rPcVnsgHgjDK8r5LkNV0NDbcsw0H7Z+SSLVUphJg+N8GgacapQJTZEnn6iGzleXwou3UopnWcs+5dM92piZB9lsrSYc/Yfpx2BFTCaSvDLDhbfOshZapvAtfjtQi2pmG+rPM6Lgyaf0U9ZXWidbtwawGJ/0a5diqpf9LZ8B7qd3jXiT8TvxQQ5xMII6agZb6oP8U8/ti+PocolTfvFuLdpfTx1VHJrA0vnxwFK+kUJg++6DRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h7RKrmZ5NkJ3wW2P10gDE0nyVRSmwenGqc8TaGA6wE=;
 b=R2MzSvY+YXt4ERjTcZ4ORmeLolGuTtSDwH+QVf5gu6jSPnxVawqdhEYlUnyUFvOUrs9+rN8y2JL/JaQGgu8ZvisJ1Sk4sMqyTu+jJd2soeE5U8/be/SGpOrMuU8hILB/L3+a4HD2bcfxwHd1TxZ3SeeBW+JbumOOlsXeYBHbJ3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 21:58:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 21:58:13 +0000
Message-ID: <360ae66a-a12c-4bc4-9a9c-02c3f77b4c2e@amd.com>
Date: Mon, 20 Oct 2025 16:58:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amd: Check that VPE has reached DPM0 in idle
 handler
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: amd-gfx@lists.freedesktop.org, Peyton.Lee@amd.com
References: <20251016185527.1796606-1-mario.limonciello@amd.com>
 <aPawCXBY9eM8oZvG@sultan-box>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aPawCXBY9eM8oZvG@sultan-box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:806:a7::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: abd5410a-ec93-4817-92a1-08de1023c3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDl5RXdHMkhhM3FlNVFqWmlsYzhONXJHeXdUc3MzVXVMcGt3dUNhVElXcDdH?=
 =?utf-8?B?aG9JeHZ5dTlPbjZLY2ZtbE1kN2J6MVBIQ2lOUi9IeDNGbTM4akR5L3ZxZE90?=
 =?utf-8?B?TU9kaExZSU5ZRi9ZYW1EdlFFQnlKRXdxejJuMEZEYVVxTzRsYmtTcGI5MWgy?=
 =?utf-8?B?V0VNTU1iTGZMd3dGa1E5V25qcEJYZzBzaTY2V1prT0JwNDhWejZvWDJmQng3?=
 =?utf-8?B?QWFZRzhHRlhQUklmVTRObm1KWkg1OStjVDJ2NTFtS1EwL2toQjlsUmRITkRo?=
 =?utf-8?B?RFR2d052RGRZa2djcVRjazFhV1J2bEU2cUwxWkY4dTR2QXFVd0xRNHpGam9i?=
 =?utf-8?B?NmUwL29JazhGb3BabHRjNENlVzRsQXoxcUxQMTV0TDZaMkhYNWZaYmhJWjJ6?=
 =?utf-8?B?SUJZVjZKS1JOU1QzYjVyT01HZDhmWXJrZDFncWd1VC9hK0orZXNDWjlGOVNy?=
 =?utf-8?B?MkNnaXhPd1RQWFJhSTRubmpMSG44NGFXZzZNZURBODlLeW5IMlgrVER5R2VJ?=
 =?utf-8?B?UE9TSFZLK09KaVZTeGNHbmtBcExNMVo2dm5Ia25xRXlHU3ZsbGR3dzMvM29P?=
 =?utf-8?B?SWRLd3F2Nklad241NkY1TWdaZEQ5MlhJYml0djBrdTlxOUZJSkxqQ2ZaYjQ5?=
 =?utf-8?B?V25OMGlrdTE3SHBOWjBrak5vY29zM3ZGUEhkOEF6UEU5U2RJZkJaSnozVjNQ?=
 =?utf-8?B?MWxjYXVBUlR0ZmE1VHJuTHdyeDU5K0Zqa2VqOHlOdnBia2lJdjVxNUJwRStM?=
 =?utf-8?B?Wk1VaS9KVi9QOW0rejU2UURvSlo2TVU2NEg0VkdRT1JmZGlRaDE4SnNVV0U2?=
 =?utf-8?B?VFR6VzErT3VzMTdlWFdvR3NKU1RKS284OU5QZHorZFRxRTZnRG5qc1dRL0RR?=
 =?utf-8?B?UGl2V0tlYlNlbnFXaTdWOTBzUVZOM05xL1pyNGttbjNhbE14eUZNVXpjT3p0?=
 =?utf-8?B?bnpVWFFIa2FHZmkrdGtvWk04WWhCY0Qxa0tUNkhDUkFWdEFyNzJHSjdNUW5N?=
 =?utf-8?B?dnhMaVlsZmhrMnJZbXhFK2VoMlNzMUZGRzBoSmkrK1ZHbVlQQkZIRjB6a1oy?=
 =?utf-8?B?Rkx6UnhBRnBzMnFVMzczaEM2Ymo4WnNsQ1djelduSmN5M0k0b1FnSUhVQk1E?=
 =?utf-8?B?MWphQTY5bDdKcEk5RGEzaEduclVWZitjdkdIRm1ZYjNUVFozS1plUEkyRXRk?=
 =?utf-8?B?c3BlUnAxL2ljRVBob0xFZUIza2RPNVBlSFo0V2E2MFpZWFhxL25wVjQxQlk1?=
 =?utf-8?B?TnAxU2M3NzlONkNUZjdETktCSVpWRGlGa2x5bUVqQkRjRHFjam9HRWlITGJ5?=
 =?utf-8?B?M3BzSjIyZlNLcHB6N2ZJR3l1b3NTZnpPanBNcC8yV2RMd2tzLzBTQi8zYmh2?=
 =?utf-8?B?c0kycFRBeWE0U0hiUmNXOXpoMnJJYUw0ZFB1YThoSWpxYVp1VER4bVBxNzBk?=
 =?utf-8?B?ZTdSamNOM2JESGUxVjFXWGNuYUM3M3VxUlh0cklXV01qdWlwY050UENpT3Zj?=
 =?utf-8?B?R1FnRWs2TGNFSTNVSzZEa0ZLMlZtaGROckgyRFpXcytNQlZTNVdWMi94TUpn?=
 =?utf-8?B?SUU3ZElLcy9wMEhINEV3SGdCOWlJekhsT3R5V05Lb0p2UkZoZ3lvdFF1aloz?=
 =?utf-8?B?MTRTTUFtZlZjNk4xV05JNkNYYzk5N0NJM04vTWx3eThuMEdPeUttVHdJMk93?=
 =?utf-8?B?dE1ZN1Bwcjg1Tkk1bWFlaS9kM2tYVWNHRjdBcm9DSGk2RTdhaTlpZVBReHhL?=
 =?utf-8?B?NHBRa041QVJvOXdRVExUWGVBd1BNU3J3cXVxczBYdkgrVU1SNE8ycWx0SS9r?=
 =?utf-8?B?aEZKblVkRGNvdDFya3Q2a1dVa200emZXckl2NENlRWlxZlI3aXpmRUIvQW9t?=
 =?utf-8?Q?QZjrH4z8qvZeL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG9XT2QxWlQ3SFNoN0Y0OXpWczFiVUUzUlRxcUtzYVVwM1grSkphbHhSc2hT?=
 =?utf-8?B?L0o4d09QMDV6WWFwbVRad2FDR29YM0tTWVB2Zks4YXFXejJmQlJGa3lDaEs5?=
 =?utf-8?B?ejJCV3AxQThHQTdPVndFTCt3MzJsQmFzTmdRYk83RWU0UzIzWEZGMURwaXBG?=
 =?utf-8?B?SDAreC9RZTdmaDhVSkFGb1pQd05NWGFtbTdVaHpEenZ2WEIzdlVPRllNR2Z1?=
 =?utf-8?B?UDlpNzdOUm9UUHZYZnZJWlNqNSt1Wi9lR01KT0IrbUp2czFjRjNjd0NJVTNB?=
 =?utf-8?B?WUY3TmRlT1F0K2k5UlA5dXBiU0pxTytaeTF3SmhpT0xmd0syVUNFK2puL25W?=
 =?utf-8?B?QzdvOTFFd0V4RUJRUmNXNFk1R2VRREJ3OXIyMi8reVQ3eTF2Q0FmUlZWcjNO?=
 =?utf-8?B?RDE4TVV6WUZuQ0s3dTQvZytLc1gwODVaMGRPTnlPcWZZdzVjM1pKWHlKWmZH?=
 =?utf-8?B?REpiYXhLUVdzVkJmdU5ZOXB3OWZqbDF5VVJQU3Nqcnh3SzZGK3c2SkswdnFG?=
 =?utf-8?B?K1A1R3I5bGNYN1V1SC9BcGx2czFKbFZvTExlbEQ0TUplWGNtRHQzTlBEa2E1?=
 =?utf-8?B?cCtMOTJDMm1leDJBdnFlaUZldmhaMFE0Yk5tSlJIVmZNSm4xZm1SQmZYKy84?=
 =?utf-8?B?MktGRE1xZEMzQUtJRWpySmI0cWNDVTQzVXNGcUQydTNwbkRzMEJFNThtNHNl?=
 =?utf-8?B?YTRlZU1RMFBIL2wzNXUreVluOFVhekVuLytyalFnelEvd0wwNnFVeThKcnpr?=
 =?utf-8?B?TGpBVkYrSEt2aHdRMEpoN2VBcUJ4MkZ3QWU3ZVlGc244ME5JcUNLQjd6NDV2?=
 =?utf-8?B?bGJvT1VYMG5EOXRxVTdZejB0ZzhmV2lRcnZDV2VkK2Y5WFYyNzJxazRyUWc0?=
 =?utf-8?B?Q3oxbDZlaDI4aXpUb25XZFJQTktENmhyVDZmYy9yaDgzZWQxcXJLZC9XVDlt?=
 =?utf-8?B?ZERuejNoeTdEektDdE42cnBtV2VIdXFiSTlpbm5nUjIwZm52bkVoeWhERTE1?=
 =?utf-8?B?ajFxTzR0RFQrYlQvUHIzTWlrcFdNQTBEUTBvZnNybmI4QkpXZWI0Qmttc0ZN?=
 =?utf-8?B?NDJKWjJoRE1QOENQd1FVY2JTY3J0YTFHamVIRlVzMVBuS3pOZlZNSWVaMmZO?=
 =?utf-8?B?dzFTcllsWWNFbE9mYlQxMkNONDk2SmJCckRZaDEvRjVnK2Y3eDNPcWpQTFY1?=
 =?utf-8?B?eWQ5RzE4U2gvMkdicWs1RHlPMktVL1dobkxMaXp1K3hPajFXMlJmZmJxQnUv?=
 =?utf-8?B?dFkrZzJRNGRCbW1sOVd0Z0w1WjRMZTRiSTkvRnZNTTk5TCtQbzNmSndpU0dW?=
 =?utf-8?B?WnRXSm1CRnU4U3paVVd1V2xGY1UvYmdhOVl6L0NLZ3l0d3ZrenFQSVNjOXlj?=
 =?utf-8?B?S3NlYlg2VjRzTHlETjhJSFRyYklmczBnUTNZci9JTXE2aU14VlpjaVI4UEVi?=
 =?utf-8?B?QzdQTVE0ZVo5Mm9wSTk2S1JhZHhiZEFIOHYwT2FsRUsyMll5cGQ3QXM0ZDNu?=
 =?utf-8?B?cVJqNk5EUit4bmxZaHRpY0xGUXJpdUQ5bVFQZGp5UkZ4d2gwaW5aRDZBcXZZ?=
 =?utf-8?B?aC9xRU4wR3VHOTVxRmhuckQ0TXp2ZnhqcUlqUFJvSkJSQzF3dWZJeXdOSlBh?=
 =?utf-8?B?UU1aVGJVV2ppZmZCb25YS3RwZFd3Z2VkM3dCQm00d0lIZ3hCcDY0Q3VRU0RB?=
 =?utf-8?B?Z05SM1Zjd3lKckQ0ZDhmb1BvZklWbTdCTUtFK1pwL0ZXa1M2UzlySExRV2FP?=
 =?utf-8?B?VEs5L21CMGpIQldkSDgxb2lDNE1oL0JraVpWYzRJWDRwbm5zbGxETHRteVBP?=
 =?utf-8?B?c0FlOWI0TzhXRnpudHhwWml4MmVBWWl4UmVRY1N0NGRIOFNraXNwTEtCRWhU?=
 =?utf-8?B?Z2R3UXBVR2JkSWdQRnJjMjdKWE84Y0NYcDN6bHd1Z21lQ0FXaTBsUzI2a0dn?=
 =?utf-8?B?bXExQlMwcnlFWHUxaGY2T3lKR0N2VDBuVyt2ZUsvK0Z5VXRJUXZCR1JvQ2Jq?=
 =?utf-8?B?eGk2dUh6MW9OWk5NSmc3cnQyNkZOTHZBSHlJN2VtRmx5bmtWVU5zbjYrZTJT?=
 =?utf-8?B?aUcvOW43NkgrMXp5Tkd6bnkrU3FhMXBDblpvZ3RyNllsTVIxbFAxdGE2dDF3?=
 =?utf-8?Q?BTWsFlTU0XSDvfOkX2nU45G5F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd5410a-ec93-4817-92a1-08de1023c3e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:58:13.0953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xanvtaLGAhVEvE7TWZGaeHDywTB7F5tAooYw+W+OmlHrDkE8Dd6nlfUftG7BV2lx4zkpukltdihKP1crVTAjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
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



On 10/20/2025 4:56 PM, Sultan Alsawaf wrote:
> On Thu, Oct 16, 2025 at 01:55:27PM -0500, Mario Limonciello wrote:
>> [Why]
>> Newer VPE microcode has functionality that will decrease DPM level
>> only when a workload has run for 2 or more seconds.  If VPE is turned
>> off before this DPM decrease and the PMFW doesn't reset it when
>> power gating VPE, the SOC can get stuck with a higher DPM level.
>>
>> This can happen from amdgpu's ring buffer test because it's a short
>> quick workload for VPE and VPE is turned off after 1s.
>>
>> [How]
>> In idle handler besides checking fences are drained check PMFW version
>> to determine if it will reset DPM when power gating VPE.  If PMFW will
>> not do this, then check VPE DPM level. If it is not DPM0 reschedule
>> delayed work again until it is.
>>
>> Cc: Peyton.Lee@amd.com
>> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4615
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 33 ++++++++++++++++++++++---
>>   1 file changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> index 474bfe36c0c2..f4932339d79d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
>> @@ -322,6 +322,26 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
>>   	return 0;
>>   }
>>   
>> +static bool vpe_need_dpm0_at_power_down(struct amdgpu_device *adev)
>> +{
>> +	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
>> +	case IP_VERSION(6, 1, 1):
>> +		return adev->pm.fw_version < 0x0a640500;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static int vpe_get_dpm_level(struct amdgpu_device *adev)
>> +{
>> +	struct amdgpu_vpe *vpe = &adev->vpe;
>> +
>> +	if (!adev->pm.dpm_enabled)
>> +		return 0;
>> +
>> +	return RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_lv));
>> +}
>> +
>>   static void vpe_idle_work_handler(struct work_struct *work)
>>   {
>>   	struct amdgpu_device *adev =
>> @@ -329,11 +349,16 @@ static void vpe_idle_work_handler(struct work_struct *work)
>>   	unsigned int fences = 0;
>>   
>>   	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
>> +	if (fences)
>> +		goto reschedule;
>>   
>> -	if (fences == 0)
>> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>> -	else
>> -		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
>> +	if (vpe_need_dpm0_at_power_down(adev) && vpe_get_dpm_level(adev) != 0)
>> +		goto reschedule;
>> +
>> +	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
>> +
> 
> Wait a second, there's no return here! My laptop kept getting kicked out of
> S0i3 as a result when I'd suspend it, and I found my laptop cooking in my
> backpack with its battery mostly drained. :-(

Oh gosh, whoops!  I'll get a fix on the list.
> 
>> +reschedule:
>> +	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
>>   }
>>   
>>   static int vpe_common_init(struct amdgpu_vpe *vpe)
>> -- 
>> 2.51.0
>>
> 
> Sultan

