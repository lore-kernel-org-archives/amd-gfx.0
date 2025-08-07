Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8527C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A83710E493;
	Thu,  7 Aug 2025 20:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IhjP4qc+";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA06010E493
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVvDFsFWx+udQdzPJ60ON6m0v5gEf1YrOk8I/dn6rBkKgpJtIHvMsO1iyY5KNnGEzxlhIeS/faO/D9Z/Jzn8YbjDKzHC6dW8grcNzJftScKbPX4Ct47bC9YZdO+fE690+OhdfLSO/PD3VZLuR7wVXF7YRArG3mY4Evwb8cjZPpGslGl0on8T//Bc9n9e77oTuPJm6MHhI4i9p/3ADL9g1XZ3oNOZbM0xaNJ6LSqEjxBnGVIoKL8Dteh/2yqCk+FwU+zNZQNO1j/U/60GwE2EPCEvNHXlBaVQAMNsVCZLNtpQipSwDIjgEwFY80ItOuRReWjqBeVYCj+485YZ2gZFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN+8o/7MyUyCIIGKknJ39zzm22yNuBZGGXIHAyYl4aY=;
 b=rDaihrJbvkdGA0Nm5otEdfJODgeZTRLl2HSiHi01Mer6yME/RXRFHlJQe8uERkk12aAlODTvYcrI0u5ahVmVV46acshcGuL4sLE1sgrxXvISc+iKFu0HP13pZd+rv9neB5rsEUUmh9Sy0ANIpBAhOvlmzD6d7jxlQaXMKowgODP+4dvBtI+/simFeai5T54hEngFWrXnQvOYwUMnWar8K9w2lxXVNMBWiyPvqNmFrp0PU7CDzxWnFWzucGmrowAPJMkrlhxmAHmwxY52twZmkaP4OxX1z1LcL872HbohujX3znCXnhFYOjGvCM4rP41MSstxvVCh/VTXWZgftcf+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN+8o/7MyUyCIIGKknJ39zzm22yNuBZGGXIHAyYl4aY=;
 b=IhjP4qc+cP2eoy5/siF4uVwNE9f+zN8uYBPU8TdQVbnfhFSuyT1g3OuZwUROflmK9/FkKKgvKr7ukK14FiaXCC8nkZ9AHEdaudwcTcEDsN2e8inF2x0f6uI8NraSqoDP6Y5dCw3Hcf1MHtXl84AnqY6JqXkc/sVPRq8hNSIxPxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 20:34:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.9009.017; Thu, 7 Aug 2025
 20:34:15 +0000
Message-ID: <e68d8be2-4687-4a51-a2ac-1ecc73cef355@amd.com>
Date: Thu, 7 Aug 2025 16:34:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection
From: Harry Wentland <harry.wentland@amd.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-14-timur.kristof@gmail.com>
 <fd4adcc9-44bd-4f54-b37c-3eb4dc286b03@amd.com>
Content-Language: en-US
In-Reply-To: <fd4adcc9-44bd-4f54-b37c-3eb4dc286b03@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0215.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: a97652c9-cf55-48b2-ab20-08ddd5f1c6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cG5zcXdZbFJZdnlQcXRwREpuSGN1emd0OStBUmNsdm1janFoWUVMS3MxSGhu?=
 =?utf-8?B?QUtGZFIzT1lPZkxEWFZLVXhiWUgvWHBFMjd4WlBTS2dCYWlpdnRMbW1mMVFk?=
 =?utf-8?B?cXhXY2RaajBHSGtPT3pYa1Rab25JL2JNVk1maS9pSnZBZDRWTzRPaVMzWEhE?=
 =?utf-8?B?WVlTdWRhNW14SnRKMG5PTVdZbXVvUUJFMTQ5cDQ3dlJodVM5ZTRxL2NSTjVD?=
 =?utf-8?B?VU5XdmF5dktoTmZYbUlydHJKYnk1Si9rWktHWWlYZ1MrOG9OWENQdmE1OW5K?=
 =?utf-8?B?ZnpvVVRLRTZ1TGkxekNybUFSdHdIVVB4V0tJR1FaL3JudUswZDdsN2NkTGtl?=
 =?utf-8?B?djRMVVB6YmJoSkNKM2JBb0pDYXRoeUtZb05LaEo1enpsZ0w3RzQ4SDZOMEtE?=
 =?utf-8?B?TGtOc3prRnZURW9jYlRYbFFJMmNHcWtKQ1QvYnVWWG9xcGFCYnN2OHRxNVFx?=
 =?utf-8?B?aWd1b1R1dG5nNUVQb1NxTklZZU5Zc1FwQ2Jhajd3bkFBSm9HZmcwUGliaU9R?=
 =?utf-8?B?OWlqeW1OajB6RmZYUVc4MkplRGJnalRENnhQWURteWJFOGhNam51Q0tseHVO?=
 =?utf-8?B?S29jNnVMKzNtdXNPRzdzUnVxbkR6Y0FVNHQ3eUdjcGQ2QWhUcHNDOVphYmh3?=
 =?utf-8?B?cDZqV29BOTFBMEFESW00WllwRmtoQnpwQUMrRDVQcjNsbUtYTFFpcTlxbElE?=
 =?utf-8?B?aWZWSUpaMWMyamZHeFdxRzlVR2M5MUdrQkp1bENKR3JXUkxFQmwydmFWd1Vz?=
 =?utf-8?B?dUhHUTRBamtjT0tWNTJ6aStsV0I0MW5ZRURzNm5ORGJzVFFLSTRrMmRNSXVC?=
 =?utf-8?B?M003VkxZZituclRnV0xINVRvb3ZGcWFudFpvS041U2lKb0xtQWdQanYra2ts?=
 =?utf-8?B?T3NLR1MvT0x1RU5zNFE0c3MwenpWOVI2VjFjZFd6a1JUTlpjeGJrVjNRaWJR?=
 =?utf-8?B?cUVETGxzTnpLeCt5YXFwbXhuWlJzakx6SHQwSzdjUFYwUmp6R0hBZGpkYVY4?=
 =?utf-8?B?dXpwSmdueHBEcitDN2s0Y2JQRG94eGFKNGxJbVZsNEd3aUo0QS9IZGlhU3p1?=
 =?utf-8?B?NmVoazV2Y25kaUxBVUxwekhqQkRETk5EaVZKbURUOU1VZXYvTFJLWDhzeGRZ?=
 =?utf-8?B?TnlhRUdwa2IyaWszVFdoY21mVWh3UkxPbG92aW1mb1c2TjhreGNXWUgzcWsz?=
 =?utf-8?B?R2VOT1dFQ0hLRFVnTlJFZUF0eVkzb2tiSTdQLzVuNFFEVGExSFl5M2dyZHMz?=
 =?utf-8?B?aUJFYXRVb044czlSbG9ZN0hUQUVrQks1RGZDQ0RlelpvcFVwa2N3RVZSdDk5?=
 =?utf-8?B?Q3pFem5LalYvR2VZWE44N3lISUhpOXhXSm1VQWUxZXZ3dHJRdDEwei84bXUy?=
 =?utf-8?B?TmxrVEo4bkIxSUo2ZDNKTFl2UndXcDNiMVhPZHlXWlVOdEpYSlNtQTV0c2Va?=
 =?utf-8?B?SUxDYnVJamphL2xUK1RhNnVaT3FpNEErV05paVZpSkZyWVlBaytjQkN6QjhY?=
 =?utf-8?B?K3p1UHZ5K29pRVh6aGhBeGlKZDFqQUU2aFVVU1JkTGx0NGMwOVFjSHVHaCt5?=
 =?utf-8?B?WDVFSytvSTRUZXpmaVQ0TlF0dUp3bENhcjF2aG1WcnNUNUhEUnRZeG9LcFV3?=
 =?utf-8?B?cGYxNDVyQ0N5bGpkTk5KRWxQR2dtNlFkVTQzZEQ4citsNFlHaVF4SVdhZ2t1?=
 =?utf-8?B?bUFJeUZadGFqSGM1QkJKZXR6aUJLUzV4VHFtcy9QdVdFb2ZlblU1K1FPdjhO?=
 =?utf-8?B?eVR2WHFOdXdPYVN2MHV6eVhCc21IZUZWc0xBTHRpd2xHdUl4a0pXbWtRSk56?=
 =?utf-8?B?YmdHRUJ4dk5zbkJsVjlIdkMydFNvdlZUUm9YcWoyWmxrcEZLdHlBamczSERH?=
 =?utf-8?B?WStHUUcxMUVQUkJNOHlhR3l2Q216ZXFKcjdwSzdpT2t1R2d0MU9mZlZQS2xv?=
 =?utf-8?Q?LC3zX/yKDyI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFCY0J3aUUrNWFYWnh1N2daVnRIZ0dvcndwdHp2T3NJOG80aVExTjVkUk9s?=
 =?utf-8?B?MU9IbGVUeER4VnQzdW9Kdi8wS0RxSVFQd0MxQWYwZGRmaVprUE1PeURhdmRS?=
 =?utf-8?B?cVZFVDBYR0tOdnQ3VDV3dGgyZ0tEeUZZM3VwNVp2WHRXa05WNnZZMHJlRVdV?=
 =?utf-8?B?aVZJNHgyTUhvV0tVN292VWR4YnRGMUhEaGg0VHJTYUlCM1FtUGgyRVlDdGhY?=
 =?utf-8?B?QVpSTWVCMXkzUWhoTVV3cUR0cmNXQmdiNHN3aTdsUkVpWFNGaDYrVCtyQk8y?=
 =?utf-8?B?bENMKzJzdHFCZWRHNklhcERIWDBpc0trdkxqMUwrTi90c0NCWGZ5c3JrUlR1?=
 =?utf-8?B?NTcrYk5XbHg2b0U4cUlWeWx1NU8yT1RYbWNvekFRbEhDTWIwZ0ZwZHk4WkJY?=
 =?utf-8?B?MEt2OXNNd2JYNnlybFI4M2xremk2U2FkRSt3ZVFHQXpaN0JxWG1MVDhwOXFx?=
 =?utf-8?B?ZEErWUJ1TVRaTmpmK3pmQ1BMR0hOeXFrdmF0UEF4dWhoZHM3VEduWCt6ay9k?=
 =?utf-8?B?ZlFreUZnTURJaGJGRm5tWU9kb2s4NTYrbllMencvVUtvVjdVNyt4azgvU0J2?=
 =?utf-8?B?TGhOMGkzTGxrWnpZUEwwRUcrOEFNRkxCRlI4U0s2ZXhIOUswb1ptSVBEYTBr?=
 =?utf-8?B?R29zUjhwZkJuc3huZ3hhcWxGdWpXbXlocDNoakJ2UzhDVTNLcWl5VmNzWndu?=
 =?utf-8?B?aGpHQTRoWk5OUHQ3aTZvQXlFaXluSGloaG9rSjhuUUU0UFRBbnRVcnp4QzR3?=
 =?utf-8?B?b3pwelZuTXVZVDJKWmJWQVlnOWpiUHJHSWRyVnQwQkRieU45VDAvV0hWU2Nn?=
 =?utf-8?B?VnN6YWJvVHNsaG55dDZReGRkOTVZbEJkbG1URUpORFdsWng1Zzg4dVpEUDJI?=
 =?utf-8?B?b1pmT0g4cjR0TytLdGtOb25qWjF4WGJoVE52bjg4aE16Y04rZ2hodXduZ1lr?=
 =?utf-8?B?UVNWQXNOb0pGSjZ4K2xGOTU1Ui9aTFdLLzRZeUhjT2J4a3QvNlA5S0lWNFlR?=
 =?utf-8?B?c0dML3ZkeVU3dURWWUNXdStmT21GWWVvZkxSSjloRHJpd1FpUFgwMXB4RWlx?=
 =?utf-8?B?TDByWHNFbFZHaWJrV2RYM3Y1QmF2MEtZdWF2d204VWdzQTU2bVBObFJDUjVa?=
 =?utf-8?B?VlhLbXNtM2prWFg1WFFwZzhGbmY5YmxXUkY3VXlOTlFsdXk3MkxHRyt4NjRZ?=
 =?utf-8?B?bE5CbDhEc2NpalFUUWxNN1p4dVdMWGVtc0k2enRpSExRRDZpNDJLL015TTJi?=
 =?utf-8?B?VlNWNFJhWU0wVmtSZWl2NkRIY3R4VjRPeU93bE1CREt1Q2Q4djBlNFpkZktV?=
 =?utf-8?B?bXVxcFNsMVhGL093SFpSWFpuNDJaMnQxS3JUdFNvYW90L0NRRU91QzBSYUVS?=
 =?utf-8?B?NHMxaVBOYy85bkVVd21DWjkzZlV3QmNQOVNTN0VLRk9sSTlaNmM5M21JbVUz?=
 =?utf-8?B?OHk0RjdpWFZxdXpkR2ltd2lBTVlyMEVRemV0NWNUSWRTd01oWC93OGEvVDB5?=
 =?utf-8?B?c2tPd0pLNXdTWkVJZ3RqQSsvaGliWGRjdlk2SitaRE5jRERHV2F2bHo0cXhN?=
 =?utf-8?B?WFZPOFdUTVA4NVVLTUFhMnE2Rjh4K1lPVXFqOXlpeDZOT3pWZzAxWUE0eW84?=
 =?utf-8?B?S0lnZ05nWXA5QUUxWE1aeFdPZWFqdWRWSmpQL0JsNER3OWZzdVRiZ0xaMS93?=
 =?utf-8?B?aXAxSGVOUlh2T1lXZmxIQTFGV3VJbnRnQ016djZ2elVDWVJJWWVmZm5TR1I2?=
 =?utf-8?B?OTV6R3lBOFdvNG5wZmFMZzFvdDFZY1VMeTIzMkxqcFBCUlFDOTI2L2FmS1hM?=
 =?utf-8?B?MXVPelpQMnM0NkRmL3dqNG1mSWJHd3ErQmhFSTNJMDRKaTdzYVNWYnNyUTJl?=
 =?utf-8?B?ZVllRWsraENzT2VpVEdvekRLaDVjcEQ5dzhVVlZNc2FxMnBKQ1A2K1drZU5z?=
 =?utf-8?B?U2VBNWt2MjhjVXN3L1RxbWF1UmFoL3NjcXk1S1hKWERGdUN4LzIvYklLTVlp?=
 =?utf-8?B?UHkyTkF1S2xFMVdoL0pOQ3BpVXB5eFRnd3ZXR3RkR1BpNzFLejRZNWdxMUgw?=
 =?utf-8?B?VGQwTG41a0ExQmpNWUd5V3lFYTZVZG9IN2JLSU5SbGFaR3FFNDNhVmozUHlW?=
 =?utf-8?Q?PZ1XxUaWrh8rVIowVafnVQMTf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97652c9-cf55-48b2-ab20-08ddd5f1c6af
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:34:15.7033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0QgVnkVgaA/HX9lYeQqq9Pt5CAhMR2f3pbpz4r5pMUkNWhI2FOhUOcomUrr5xCKGgO9WVjsuNVVZ9gWWfg1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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



On 2025-08-07 15:12, Harry Wentland wrote:
> On 2025-07-23 11:58, Timur Kristóf wrote:
>> Analog displays typically have a DDC connection which can be
>> used by the GPU to read EDID. This commit adds the capability
>> to probe analog displays using DDC, reading the EDID header and
>> deciding whether the analog link is connected based on the data
>> that was read.
>>
>> As a reference, I used the following functions:
>> amdgpu_connector_vga_detect
>> amdgpu_display_ddc_probe
>>
>> DAC load detection will be implemented in a separate commit.
> 
> Another regression in our internal testing with this patch, unfortunately
> only on not-yet released HW.
> 

While this shows on unreleased HW I wouldn't be surprised if it
repros on other (recent-ish) APUs (integrated GPUs). It's just
that this week's test was on currently unreleased HW.

Harry

> I wonder if pipe-ctx->stream could be NULL in some cases.
> 
> Harry
> 
>>
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> ---
>>  .../amd/display/dc/link/hwss/link_hwss_dio.c  | 16 ++--
>>  .../drm/amd/display/dc/link/link_detection.c  | 80 ++++++++++++++++++-
>>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +
>>  .../drm/amd/display/dc/link/link_factory.c    |  3 +
>>  4 files changed, 95 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>> index f3470716734d..b9ebb992dc98 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>> @@ -58,8 +58,9 @@ void setup_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
>>  		return;
>>  	}
>>  
>> -	link_enc->funcs->connect_dig_be_to_fe(link_enc,
>> -			pipe_ctx->stream_res.stream_enc->id, true);
>> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
>> +		link_enc->funcs->connect_dig_be_to_fe(link_enc,
>> +				pipe_ctx->stream_res.stream_enc->id, true);
>>  	if (dc_is_dp_signal(pipe_ctx->stream->signal))
>>  		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(pipe_ctx->stream->link,
>>  				DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
>> @@ -98,10 +99,13 @@ void reset_dio_stream_encoder(struct pipe_ctx *pipe_ctx)
>>  	if (stream_enc->funcs->enable_stream)
>>  		stream_enc->funcs->enable_stream(stream_enc,
>>  				pipe_ctx->stream->signal, false);
>> -	link_enc->funcs->connect_dig_be_to_fe(
>> -			link_enc,
>> -			pipe_ctx->stream_res.stream_enc->id,
>> -			false);
>> +
>> +	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
>> +		link_enc->funcs->connect_dig_be_to_fe(
>> +				link_enc,
>> +				pipe_ctx->stream_res.stream_enc->id,
>> +				false);
>> +
>>  	if (dc_is_dp_signal(pipe_ctx->stream->signal))
>>  		pipe_ctx->stream->ctx->dc->link_srv->dp_trace_source_sequence(
>>  				pipe_ctx->stream->link,
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> index 827b630daf49..fcabc83464af 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>> @@ -942,6 +942,12 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>>  			break;
>>  		}
>>  
>> +		case SIGNAL_TYPE_RGB: {
>> +			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
>> +			sink_caps.signal = SIGNAL_TYPE_RGB;
>> +			break;
>> +		}
>> +
>>  		case SIGNAL_TYPE_LVDS: {
>>  			sink_caps.transaction_type = DDC_TRANSACTION_TYPE_I2C;
>>  			sink_caps.signal = SIGNAL_TYPE_LVDS;
>> @@ -1133,9 +1139,17 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>>  				sink = prev_sink;
>>  				prev_sink = NULL;
>>  			}
>> -			query_hdcp_capability(sink->sink_signal, link);
>> +
>> +			if (!sink->edid_caps.analog)
>> +				query_hdcp_capability(sink->sink_signal, link);
>>  		}
>>  
>> +		/* DVI-I connector connected to analog display. */
>> +		if ((link->link_enc->connector.id == CONNECTOR_ID_DUAL_LINK_DVII ||
>> +		     link->link_enc->connector.id == CONNECTOR_ID_SINGLE_LINK_DVII) &&
>> +			sink->edid_caps.analog)
>> +			sink->sink_signal = SIGNAL_TYPE_RGB;
>> +
>>  		/* HDMI-DVI Dongle */
>>  		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
>>  		    !sink->edid_caps.edid_hdmi)
>> @@ -1228,6 +1242,64 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>>  	return true;
>>  }
>>  
>> +/**
>> + * Evaluates whether an EDID header is acceptable,
>> + * for the purpose of determining a connection with a display.
>> + */
>> +static bool link_detect_evaluate_edid_header(uint8_t edid_header[8])
>> +{
>> +	int edid_header_score = 0;
>> +	int i;
>> +
>> +	for (i = 0; i < 8; ++i)
>> +		edid_header_score += edid_header[i] == ((i == 0 || i == 7) ? 0x00 : 0xff);
>> +
>> +	return edid_header_score >= 6;
>> +}
>> +
>> +/**
>> + * Tries to detect a connected display by probing the DDC
>> + * and reading the EDID header.
>> + * The probing is considered successful if we receive a
>> + * reply from the DDC over I2C and the EDID header matches.
>> + */
>> +static bool link_detect_ddc_probe(struct dc_link *link)
>> +{
>> +	if (!link->ddc)
>> +		return false;
>> +
>> +	uint8_t edid_header[8] = {0};
>> +	bool ddc_probed = i2c_read(link->ddc, 0x50, edid_header, sizeof(edid_header));
>> +
>> +	if (!ddc_probed)
>> +		return false;
>> +
>> +	if (!link_detect_evaluate_edid_header(edid_header))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +/**
>> + * Determines if there is an analog sink connected.
>> + */
>> +static bool link_detect_analog(struct dc_link *link, enum dc_connection_type *type)
>> +{
>> +	/* Don't care about connectors that don't support an analog signal. */
>> +	if (link->link_enc->connector.id != CONNECTOR_ID_VGA &&
>> +		link->link_enc->connector.id != CONNECTOR_ID_SINGLE_LINK_DVII &&
>> +		link->link_enc->connector.id != CONNECTOR_ID_DUAL_LINK_DVII)
>> +		return false;
>> +
>> +	if (link_detect_ddc_probe(link)) {
>> +		*type = dc_connection_single;
>> +		return true;
>> +	}
>> +
>> +	*type = dc_connection_none;
>> +	return true;
>> +}
>> +
>>  /*
>>   * link_detect_connection_type() - Determine if there is a sink connected
>>   *
>> @@ -1238,6 +1310,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
>>  bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *type)
>>  {
>>  	uint32_t is_hpd_high = 0;
>> +	bool supports_hpd = link->irq_source_hpd != DC_IRQ_SOURCE_INVALID;
>>  
>>  	if (link->connector_signal == SIGNAL_TYPE_LVDS) {
>>  		*type = dc_connection_single;
>> @@ -1261,6 +1334,8 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>>  		return true;
>>  	}
>>  
>> +	if (!supports_hpd)
>> +		return link_detect_analog(link, type);
>>  
>>  	if (!query_hpd_status(link, &is_hpd_high))
>>  		goto hpd_gpio_failure;
>> @@ -1269,6 +1344,9 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>>  		*type = dc_connection_single;
>>  		/* TODO: need to do the actual detection */
>>  	} else {
>> +		if (link_detect_analog(link, type))
>> +			return true;
>> +
>>  		*type = dc_connection_none;
>>  		if (link->connector_signal == SIGNAL_TYPE_EDP) {
>>  			/* eDP is not connected, power down it */
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>> index d6b7347c6c11..ac25d89a4148 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>> @@ -2256,6 +2256,9 @@ static enum dc_status enable_link(
>>  		enable_link_lvds(pipe_ctx);
>>  		status = DC_OK;
>>  		break;
>> +	case SIGNAL_TYPE_RGB:
>> +		status = DC_OK;
>> +		break;
>>  	case SIGNAL_TYPE_VIRTUAL:
>>  		status = enable_link_virtual(pipe_ctx);
>>  		break;
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>> index 71c10a1261b9..c9725fd316f6 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>> @@ -555,6 +555,9 @@ static bool construct_phy(struct dc_link *link,
>>  	case CONNECTOR_ID_DUAL_LINK_DVII:
>>  		link->connector_signal = SIGNAL_TYPE_DVI_DUAL_LINK;
>>  		break;
>> +	case CONNECTOR_ID_VGA:
>> +		link->connector_signal = SIGNAL_TYPE_RGB;
>> +		break;
>>  	case CONNECTOR_ID_DISPLAY_PORT:
>>  	case CONNECTOR_ID_MXM:
>>  	case CONNECTOR_ID_USBC:
> 

