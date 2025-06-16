Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F3DC71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 11:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EDB10E32E;
	Mon, 16 Jun 2025 11:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCopDsUF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D22510E32E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 11:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKX7t17rIVpemVSogy3bXl/GgbS+gYc4BsqArBfQeFie41i2nvgpBgR39TUreFg2bqBiS17RYsy52mFIwypLzBrpA14jCyrpZfT+lGO2ykXBddEzikdZ97wFgPLVO9adF31QVahysYQKetHMybMaJQR6OafaL26woOcGbHv2TgaINJRzuBZbPxYSv4f94JR6zdkA0XbyZavlgi3E5CbGzV0Lc+szAnZ95lonHMVLakpqNfTdLPeU4ONuoqKCknnRhzos1gujaz/vpgoaUgLDXnt+MWUtUkpf54kX1gPHByZzNrounNy3zHvniUQ85qzciSKjYsDf/7y4KmZe+TXI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRZxfK8FY7KzA3Bpm1ShGtUo7xHeDnYvwis9WqJEtIg=;
 b=qtagKFcnqKttRCto3TSfaToIbZInNOcYiwMP+ADx2gP1eujt29Yeg9QT9hRfjI3nymcYxhwvzezmEAm16ZR7sN7iv3vyOeMZRe1AkvJxPA5/igA0ZDPyapGgXOVn3DNtxlu5VitO8Yafm5MI4lxJEpweDstC5AU3FM3x9PF2Kvp5r1j/Tg2or0ZUIS58LZVkzoQOlXoes2HvoaGwH4xgUdvR7c2UtIJt5PJzDMHUGswmnEhPJdXj2a/Gn/YqPpWdL+ba2UkGiJVptMV3DamzlA32RTtJasf7UpMqSaJ0cynsl3+e/3w8Rgo1hNFckSOyE86utDnACtcWiBqcxHixWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRZxfK8FY7KzA3Bpm1ShGtUo7xHeDnYvwis9WqJEtIg=;
 b=OCopDsUFtjUxckQH65nb9GX5nSthz0/wjJVShdLWzLjNbhi454jXjPadilc0HORFnTQsx176a8JtDwQOCXHjn3zRLLZeDEOSpmAFOZ673Wpbtx1WmURZbT1mF9np57fsIMW55bNU6b/9PXovhb6iZLiX5wx2CfYG19VlcbyIyT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 11:51:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 16 Jun 2025
 11:51:25 +0000
Message-ID: <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
Date: Mon, 16 Jun 2025 13:51:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu vs kexec
To: Peter Zijlstra <peterz@infradead.org>, alexander.deucher@amd.com
Cc: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d9269a-45ae-41bc-dc7b-08ddaccc1ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TENZSzRYK0w4ZU9ENjVqVU8zL3pPN2svWU9TMnlkcjBhR1F1aXhybFk4SkNH?=
 =?utf-8?B?UXNwRzV1YWxCbml4ekRPcnZLcHVTK29mMGplZkx3Tkd3UXhQSjVmUlJmK3VX?=
 =?utf-8?B?dGpFTVlybjVha2lwWmw0dFZiT3ROdkRYUUFicDVzMzliMVlsSm0wUDhJUG9a?=
 =?utf-8?B?R2VSdS9NYjBER0l6dTgvNWRESWVURUhSY3VJaFJSRkFTOG5aQlVDaHJpcUFM?=
 =?utf-8?B?a1MvZkFMOWF6Rll3dFcrQUVDeDV6ak9yaTVJaWVKWlpYNENQWEdqWTNDTWZL?=
 =?utf-8?B?UEE1ZUJPVDJ4bEFzVFZTTVRmY1FaUng5Q1pqdXVncEYyWmxTSmNKelUyaUdZ?=
 =?utf-8?B?NE4zUCtxdW1pdEdlNzFNTGpXQkZaY25QaFA5WS8xL0NmVldxeHlMMGlZdFNJ?=
 =?utf-8?B?WlZOMWoxTlZPVkN3Kzhzb3JDUHlRMnU0VWtKVC90ZVBkcmlud0JQWHFMM2ZF?=
 =?utf-8?B?TDB5TE1Rc3FpcDV3ZWFvRDZldGFRWGsrUmlUaG5NZmZ4cUkvQXI2enNYSUw4?=
 =?utf-8?B?NSs3dFdVcnQ3WFBuK2tuaW03RjdJaStkY0FQbWt3UEJQY0c3NzRxbHMzWlA4?=
 =?utf-8?B?bjRyM0RiTGxoK0F4ZDJOOXZSbU5Bd2pDWXJsUkIvZVVwcG5NVUR6RVFiTmE1?=
 =?utf-8?B?Y2l0eXlqa0ZhRkNMTDdtR0w1dHZ6VjFpYTQrTUpHWmtSV3pPNXpSeVVrbzdw?=
 =?utf-8?B?ZGV2OEN3NlFEaXNhcFhqSHhkQk9BK2VrWUlTM3B1bTdBaEpoV3h2WmpRSU1h?=
 =?utf-8?B?ekVDZzUzbS93cjdHdmlKUDgxNkthZTVpL1FDRWlIZWpncUZ4dzM3L0tOWUg5?=
 =?utf-8?B?ajdhSHpobGdBZVVENXE5cURxbWMvMWcvWTdiUG5zZWhkNGQ5dUVFdzRCUVMr?=
 =?utf-8?B?R2lWNWEzSmdjYi93cGJUZkQ1WmpYNXVMalEzTHdMQUFmWVJ0dDQvc3NDdkJX?=
 =?utf-8?B?RHAzUzhwNzhJRVhQbWdnTk1qbDBGcitvWkc5U3lBVWJwc3ExQzJsNmcrc2Fp?=
 =?utf-8?B?TXp5VVB0dGMrOC9IdmFvczNwU3ZXZ1RsQmhVekxZNk16eVhnVkk0LzFMUmIy?=
 =?utf-8?B?WVoza1JodEtkSW1SQy9VRWliV2xqV1hvcHlVYTJocTRkOGU5U2pSYzNUcW4v?=
 =?utf-8?B?L1J6MlVDYlpzVEl3czVMN1NqaTBUcCtCZUhmSkFwc04reFNUQytOdU9ua0Fl?=
 =?utf-8?B?OUp5SXlzcHpBWDk0S2QzeWdJRUt5Q0tBcW1PWlU0c0ExTU9zYUl3dVFhK2Z4?=
 =?utf-8?B?am92M2JLblIwc2JodUt1UElPWEhrdEIzYldmNE5wTVdtWVlVL2pGdlZFREZr?=
 =?utf-8?B?M2dWUDNJNFB3cXBOWEFmWmkzbWFpS1hTNnZDcDJsbmRIK1ZISkRmQXpFWVgv?=
 =?utf-8?B?STVFTVFmVUFldEx2UFNBSGEzY0t0MDdOb3lVcWtWVzk5VnZtMW5wUFZ6OU9q?=
 =?utf-8?B?NlBrSUx0a08wa1pwRzlVd09jTUdZc0xYODNXKzlVREh0UXlXQnRsZnRqbDNm?=
 =?utf-8?B?YjFUbjVIemZPUThGL3VrbHp4SlcyNjJacXVuZ1gzWUIxbHBIdEhpQVlXR3pM?=
 =?utf-8?B?QW1ad29UdU80cE1zSit5em5vMVh6MnNrVkxlb1VIT1FVOGJoNjFJbnhyUkZO?=
 =?utf-8?B?NEpEc2dsZkhDYVlFb2FMK1lIU25namtwLzJEaW9yMU9CQ0NKMGZIWVJQdm5C?=
 =?utf-8?B?dFAyZFU5cWR0bnJYbEFBUzkwb2RpNllzOStrNG5LcVpFbXFXSUdXVVgxM2Fp?=
 =?utf-8?B?T1JXdGRMZW84L1h4K1NIRTEvanRzWExXMzdiK0huemE0akV6c05zNHJSbU1G?=
 =?utf-8?B?Y29OUk9uVkRhYm43bUNMZXpER0oyUlFzMWkrSGF4WDNEVHFoak5jWUJORHRt?=
 =?utf-8?B?ajBLWDE4dDlJNTFVMUxlbWhadTRxYUM5clVpYkk5ZzVsL0R3cWZPOHZzc3Zt?=
 =?utf-8?Q?KrY5cmVPd8s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzZPUktCVHoxR1NyYUpqOEpGWU1LOTBZdTNSU2RDSkJZeFpDZDFsR2M4aEdj?=
 =?utf-8?B?R1BxOHkyK0lOSVVvL2IrUjFOWTJlRjgxNkxBakxYQVpUTlRlMy9VSGszSW93?=
 =?utf-8?B?ZFNpZS9Uczh5MVM4dEZWNHFCSXpDTDV3TEpDdGxRU1Voa1BPMGU4bnNuaFJ3?=
 =?utf-8?B?TGFsSGpuOCtqejNBNnFrZzNDUlZDTDFNWXZ6SlV2bFhYazNneUc2elYzZyt1?=
 =?utf-8?B?Mk03ZEtiSnNOdlRPSjh3T1hFcFJwK3ZTVi9XTXJodFliRTdyV2Y2WkltTlFO?=
 =?utf-8?B?eHNobFRvOTVSVkFFVy8rVjQ2aGJIVlhIZjM4TXpzNk9vZWU1TUZjMmVwSnBD?=
 =?utf-8?B?aklmakhNdGhFWUxSTFdnMGxkb0F4bTRlWkZRR1ZkakhIaDA4RFNOa2VYeXlF?=
 =?utf-8?B?QUFIQ1FJOTcrL0JZcEUzaWpycWNlaFpEcGUzYk1LQ252Qk4zVUJZK01MY2xM?=
 =?utf-8?B?WGkxYmt4S2lwUDVuWmNSbkhWNWxySXUwVFAxN2FlN1lqak5CVHUxWHZhQklF?=
 =?utf-8?B?RkpQVThDK2xyaEMrZFgwVFZ1R0JJbzZibDIzaEZ2T0xUY1pZRXIyMjZvRVlS?=
 =?utf-8?B?NHNjaG0vdUdqTGExSEs5RmNvaWcycHdUS2grN0pnRzVIRXhtdklmRTNteEw5?=
 =?utf-8?B?NG5jTUZsVjc2MVF0elB6eXZ2N0JLbkEyN3dpbTJCNlRnVEVFbXdGcWlwYVlO?=
 =?utf-8?B?SDhBSTZ2RGRKV1V0blJvU2dwb0gzcmh3RnoyS05iVkFXbjVvRExwajdmMXlz?=
 =?utf-8?B?SDhNMCtlSlZxTG1vRWVQQ3hTY0xmWjNpb0FidkswK1kxbG0vUFNnUkMyb1Rv?=
 =?utf-8?B?a3RheUxwWEZKSlVIMk1tMEJLZkpRQUZLS0podFBPblp3di9mNHBNNVdYOGRp?=
 =?utf-8?B?VW9ESkpnaEM0SXN4aVZ5SWpKRjJUU1hqK2x2LzY4QUlQbzhUc2pkUmovWVZM?=
 =?utf-8?B?TEpPRW8yRmVaNGFUM29zWFozNmVhYWxCNG9UWFozd1BpZ3lKMUVURmJEWFZF?=
 =?utf-8?B?MFFqeFRXSitVa3FPREsvd1U1cWxmR3dqWEJkMGUzekI2RTlEcHR0ODkxVUxE?=
 =?utf-8?B?NTVyMVZTNEYxWlJycG5QbzgzdU8vYzFPVk9SV1dxZk9zZFVqa0FPck1qNHB0?=
 =?utf-8?B?cExJTGpraTFYNnZGSnJJdjBZWEVHbktwaVRtR2MxMWNLMlFxM1ZPTnJUaE1S?=
 =?utf-8?B?bkwzaXJrNmxjZ3JvNUwzTlMvUWZ0VXFRTHNjSDV6cFZ6QUxVc1l6TGFESGFm?=
 =?utf-8?B?R0xhdGh0Z2ZWV2dIYzI5eHJHQjBUdGxVU1E0VFpCOFVPY0NWd1pLRkZjOHg2?=
 =?utf-8?B?ZE04ejhLb0N6MklEL0Vva0krTEpaRE5OcytuOVpQbDJ1akIrMHpnRW5GZUlG?=
 =?utf-8?B?a0o3UnVRZFYvMVZUYU9HdnRLODNWeCtSeHRScGpmbWc4L25LeVFQZS9IUHZp?=
 =?utf-8?B?RUc1bThhVk82Mmc1NzhseWh2V3gyczlCUDZ3bXlCN3ErR0F1NEd4WFVVZ2Fi?=
 =?utf-8?B?UjlaU09EMC9WS1lVZkRCbUk1MmFrdURRVFRhR0drNEFOYzhOTmFOMEpIR1BJ?=
 =?utf-8?B?VjdUcmpYbHFTWmV6dHlEMlNXV3phREJ6NkRvMTlPcEltbVlRUXRzZ1Y3VDZo?=
 =?utf-8?B?S2xMTXZHVUN0QXdZMGViRDhXSThTM3N0U2IydnJ4cllMRmMrT2VkZEprbEYw?=
 =?utf-8?B?TzQrWjdFc1Bxc1JNQVFkKy9NalhWczJ0bG95V21SMWlQZnVIUE1yQ1o4Ymxj?=
 =?utf-8?B?cEZGUXJCQWZCaXd4MEsvaHVHZHBpYXBlYk9IenFmUzVEemVJeC9yU015ZTJK?=
 =?utf-8?B?ZGRHcXJtaTJXY3RIb3lpWkxGdFB2bTVjWFJpS3VzbFMwKzd6c29EaGQ5bis1?=
 =?utf-8?B?cVArSTZaa3JIcDA0d20wTEdnRTVpYXltQ0ZGK2JyRDVSUnJTTUg3SEozQ0pB?=
 =?utf-8?B?NjNLTnJKYkh3bG1vK0hocFY0Slk2UXRHemZqc1d6KzZGa2sxMEtwNEJ4TWVi?=
 =?utf-8?B?MWRCVHNSNkNEVGs2SzBNd082MVlIU1BGU2todGpoYnZ5U3VzY2VYZ24veFZX?=
 =?utf-8?B?dVozeFdGQXV0eEYrSE5UbFcvbGdQNEtjYlRXYnR4WlpCNWFvL0JTcFFiT2xE?=
 =?utf-8?Q?ojE7hCF9AxmldxcmhYLLmMeAk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d9269a-45ae-41bc-dc7b-08ddaccc1ed4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:51:24.9734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GRyMkZ1mKIr8BqLjRuxZayH6tXBXi2MH9JJFXTkHDmfCaPWdsOpZnDswbZx+dso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484
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

Hi Peter,

On 6/16/25 11:39, Peter Zijlstra wrote:
> Hi guys,
> 
> My (Intel Sapphire Rapids) workstation has a RX 7800 XT and when I kexec
> a bunch of times, the amdgpu driver gets upset and barfs on boot.

yeah, that is an "intentional" HW feature and yes you're certainly not the first one to complain about it :(

The PSP (platform security processor IIRC) is designed in such a way that you can initialize it only once after a power cycle / hard reset for security reasons (e.g. to not leak crypto keys used for digital rights management etc..).

On dGPUs we work around that manually by power cycling the ASIC when that situation is detected during amdgpu load, but that unfortunately doesn't work 100% reliable.

On APUs the situation is even worse because the PSP is shared between the GPU and the CPU.

We have forwarded such complains internally for years, but there is not much else Alex and I can do about it.

Regards,
Christian.
