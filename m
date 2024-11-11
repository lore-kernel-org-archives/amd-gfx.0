Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC4AD2E9E3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 12:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3B410E48D;
	Mon, 11 Nov 2024 12:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDpfkqjz";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0099510E48D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 12:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmpHb4ZVNbU9L3HwUur4/qf82Bd0xZtNSXWz56CUlGtnPgBDR7WkgilcLxMfvTwTTkl0L5A5sml/eOibUNK0DauMQO3hysgiLTMkjgyAI1PMWZeHvaTa/b0vb632Fg7ROhMTPD4k7d/gapRBks6McjVr1UEfkpbYLZhIrzmZHDeXLBngKcVlz/lAsnrg6ntOinP1vElYihMGhTANxsrL2b2Ns/5lUMPh+i9mU45TiienRp25ht76aZiIbQyBRMPyTSedXieN8Os/YjVqmEgSAYQ75tmeDaE8ogym5XgFCtV0NE1/UfdccFw9Fi8sbXR90ZXWygPCOAFJeImWzf3vIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0yWELOG66XVZMMI1YS5Jh5o8g1cJh7qAPjFN7tN8uk=;
 b=P4AG5EqFjWvC0UKOcQwO4ckCMFY8vbWSlAkSd7tMgdznOF0cezNG+BKRSe302vccDGwHvvw1QwxGIpoup9ncl1zO9IyoHmqy9ZX5gVuqc2Uci5+n7qnbt7DpUErruHGh0aP1rchF+nyKQXXNnhp8SLgn8gnpxdkZpovcgCvlDMWyASsJfYoIaX/lETvWUQc3hWEveRAUP4hEsLF0+aKZhE3EWpJYVT/NE3riT1m9q+hjDoq8Sg3FhWHljtdtWlVun2oaARhNcJYzAFrsK1KRpzAOtniihoC//G24rMXDAuMYqrErq1bb2y3KwALmBiRmasx0E0cX2Qqr3tdWt7I3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0yWELOG66XVZMMI1YS5Jh5o8g1cJh7qAPjFN7tN8uk=;
 b=NDpfkqjzNmlkOtGKwIY2fBW0IlxkEI37LYvS+esD5gu/C6L1QyP59yFYC/U9AoyazFeO60o1rT9McMqG6CWafdyVwDbjoSGRJV+0PiSmj224GOPfi8YOu1V4NQZGJE2iluuP10gsQkoDafpsS6AvAFK+71RccvzcJc9JNpqnHNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Mon, 11 Nov 2024 12:29:55 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 12:29:55 +0000
Content-Type: multipart/alternative;
 boundary="------------U1cT8glYWeivinNdH4fqBFC6"
Message-ID: <02f3438a-e917-480e-8a37-9277fc72b963@amd.com>
Date: Mon, 11 Nov 2024 07:29:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu: Add missing 'inst' parameter to VCN
 v4.0.5 function interfaces
To: amd-gfx@lists.freedesktop.org
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
 <20241111024612.1881727-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241111024612.1881727-3-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: YT4PR01CA0405.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::18) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c1bc1a-fcbf-4707-08e3-08dd024c8c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWRxUDJmZml6Y2xCRjBXVEFWMTMzQm13S1dqL0xXbFFyQ1RaSEM4TjZ6R2Mw?=
 =?utf-8?B?dlpNTXNpZkRyb1hDQ3YyR1F1QlVEd2lRNWk1TWRSZEtMTjlTWk5Qdyt4QTAr?=
 =?utf-8?B?cnN6ZHRHbHJ2ZmdHaDRwUnd2cW82ZUNKbjJjUk9icW9VdzNSZ3FGU2lXaEVz?=
 =?utf-8?B?QUM3TmsyTVJJb3IvY2JRdDNQMk95RzdWTytwbmJhdXVCMi9aWTdoU2NUNTdi?=
 =?utf-8?B?MUF3aXdvT1Y0a1dhWkNZRjdHQlc0VisybTdjSGFMcG1YbXZzdGdsS0hicTVX?=
 =?utf-8?B?N0p6MmdYQlFGZEFHYkR2dEJrZDVYVXBwOXZQYXZMMXVyWEtiWE9wSmhOZ00y?=
 =?utf-8?B?b3FRMUdYR1lDOTloNXpndlJmMmlJYU9LVWl5Sk5UbUZaa3RMblVoYTRDM2d2?=
 =?utf-8?B?WTF2bGZSRkFTSWZKbXFQbzJJSG94RXpCNjVFZCtDSDhFVDRzOFRzTDdOaU9n?=
 =?utf-8?B?RGJZRExhSHZpa3hUck5DVVh2Tlo5WW9RRm9MMUkyYktCL3VualRMNHFObWYv?=
 =?utf-8?B?VHJJQzg3RDN3QzlYbzRLaXlmRGUrUlpuT1BPVVVYUU1TbkkybXV1L2xzL2l6?=
 =?utf-8?B?bDc3UXZsTDB4WWlnQU1KUEZZaVY3alZsOVBhNEU5Tm04di9aK3FiVERadnk3?=
 =?utf-8?B?L3Jmd01nZGR4ZVNGdC8yNWt1N09RQkk2dVZmdXJRTzFaZTJiN3hMWXZwcUF0?=
 =?utf-8?B?TnRjWUVmL3lXOUhiZnhBVEY5QXIrWWdFQlBNU2Joa0ZpTy9kbkkveFM3UE5n?=
 =?utf-8?B?bStmU3h5VTAvL0hDdXlQY21LdlVHUkVlN3JsWjh1UC9ZSjhXKzJ2VnRMUnV2?=
 =?utf-8?B?UEVLMTZkMXdhREdLbUxYQUFRZXhpR09KWkQ5cStYS1RMRVEvbEk1b0x5Tmhh?=
 =?utf-8?B?SVM4MWU1cEhocVJHNHliMWFQdHliS1owTkRvbmRWbHFtTUxGWDhMaE8zeEYw?=
 =?utf-8?B?MWlWM051TnpwRnhlVStlcG5zZXFsZFB5UHFqaTFaQnNkMzFrVmVVam5QZEwz?=
 =?utf-8?B?UkJnZ05oeDhXcDQ0Wnd2OWZBWTBVejVaV0JYZ05USTh6Q2xVUi8rVnhBS09z?=
 =?utf-8?B?QjA0ZSt4a0VrSFpST2RZWXR5WDA1a0RhWHhuVkhudlExSHVkK3hOWXRqTW9F?=
 =?utf-8?B?UjZJakZIcU1aYTErVnFETDhucHZlZzlBVE5uTHpWM05hWmV4NXpvNUEzTXgx?=
 =?utf-8?B?N0hmQk04WGtaYTB1SytnVDVWUWpnRUFPKzUvdFM2aVU5Y1l6ZjRJTmJhb0Ny?=
 =?utf-8?B?ak4wTHpLNkZ6MU5rS1NiNmJOY2RIam56NUtXN2FEZllCYVplK0pOZGFzYlQw?=
 =?utf-8?B?RGtqSmo1Q0o0WGpTSnNPMjI3Y1NVQ1dJdEcxbTNaUEMzMy90T2tnM3lTMmI4?=
 =?utf-8?B?SSs3T1hwQ3I3Z2JRNC9KSThuWXlGR2toemplZEdXWm9Ubm4rYy91VTdXTUtG?=
 =?utf-8?B?dlowajJiOXdnQzFsbGQvWTNpUXE0Ry9neVl6bVgyd0JwYmtQNFVrRklxUlNu?=
 =?utf-8?B?TXpYaS8zR2NiTTJpa2tqV1NUcE1DbFR5SitJaUtuZ2s5RWpCQWpkKy9EWGxD?=
 =?utf-8?B?WXplWmNzd2h1aFJQc2NaSzFnRHlhYis2WDUxbGpxLzBmMi9WN0VqZ2hjUHlZ?=
 =?utf-8?B?MTd2S2UyMkZJK3RFL2JPS1lQN01XTlFFRXBJWmxmOEZINEEzUjU1OG0vOVJE?=
 =?utf-8?B?NzNTV2F4QnN5K3NwNE5XQUtMNXEwQXdzbmdkQnRsZGV0Mk1rcEZrY3ArVGw3?=
 =?utf-8?Q?hjkxcoEX44i9m2UE0XGv6bsAi1NtV9zdtAFDyo6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FtaU80VldXOGFCYTlqWGIvRm00UDVCL1duMnJROGR5TktlbEtRMU5ZeUVX?=
 =?utf-8?B?R0pYRmo3eDJLSVZWSENlMHRQT003MURkdkNIVmUwWUFFM2o2aVVHeDUxNlcz?=
 =?utf-8?B?bW5rRUUvSGV4eG5saFFaVGt6MHI0SWUwSzhKQ051dHBVWStISVdqMXFhcFZE?=
 =?utf-8?B?YmJCS2pNMmJTdTFMc3ZwZWFNVXE5QjVENTgybEZvYU9GVGN5WnBxQVl3ZWRO?=
 =?utf-8?B?UmJkL21lUkVCQ2N0ZkhqQXZnQkV1eGFWeUJGdnFtNTVSdWtrNXVETkRyTFVq?=
 =?utf-8?B?NExxVkZhL2FHMndhdWUzT3dKT0NaT1d3T2tiNHhIMDlmdW1xQ09ERDVTT3la?=
 =?utf-8?B?MWtiWWd2M0NFR3JVUFlVS2ZQQWE2Um1HOG96Wmc4YjFGRlVyZkRHRTdvV3pv?=
 =?utf-8?B?clBhNklRTFFDN3JBTk81ZXRJdXZSNGRSaXdBNDk0RnhsWjZlY1hKQTZOM3Ra?=
 =?utf-8?B?RDZyc3JtZGNaNmpFblc4dWhVK1pkNUpiMlJNbDZOUE1xQU5oZnY0SHMybUJL?=
 =?utf-8?B?bEdVejd3eDNZQWF0MmFCRkpFaEpkd09WQkZqSlBoZVd3WnhYeU9TdDd5QThx?=
 =?utf-8?B?dTVRa0lXVlBtcHdMdHBWZWhxM0l1dTd5b1NLNnpUcnJlSFpVcC8ySlBYUHlm?=
 =?utf-8?B?NWpLNHRhMzVMZWNrbDZxcS9Ra1ZuQmtWdnFzZXdlTEl1VXpvK1NKZlRTNXZ3?=
 =?utf-8?B?cTI2TUdRY25FMkZSRnV6T3ZGeVZjVTJSenB1SDdraEM0MU1QVHpJY0FPVzF5?=
 =?utf-8?B?dWxDYSs2bTZUZW5sYnFnOTdIdGFvQ2dwVXUvU1lQS2NGM1g3bVFQc01pYU03?=
 =?utf-8?B?SFFTOEp5UjhhM3U0czd6d2xUQUZreklqak4va25Id2tFZGIrbFQ4TU1GbzdL?=
 =?utf-8?B?bVhXUlFMV0VZczVweXBGNGdGREdqMEVhNXhudzdpdWxYUDdqUmVsblVBQXdv?=
 =?utf-8?B?MThrTFp5RUlwWkVsZjJIRUJ4UkFIOHBSUjAxOEJCZzUwSTJGdktVOEEvM1FV?=
 =?utf-8?B?dlFPZTFJRFhRQk5yVkkzUHFOS0NFeFU5aTJLRUxkZGJ5YmQwSnJXKzhVQ3Vr?=
 =?utf-8?B?dFpnNzRWcm9LMW1JYUZUOUNrSmo3UjZWZ29EeE10SVVDQVlqNGxPcGowVzNF?=
 =?utf-8?B?U2tnT1l3WUcrMklmQlJhWjFEUy8zUEt1d0dFSjlUZ0FCd2NlOEk0Nkt0TllY?=
 =?utf-8?B?S2lTc1l5SUZGVDQ5QXhJR2Z5dytQMjYvWEZ4YkswVlBaN1ZYVmw3M1daczdE?=
 =?utf-8?B?T1JvKy9yVlN0cDFwQTd6cFhSRlY1T0dkRGFmazdnQmFPUlRnVGtWSVZsNW1W?=
 =?utf-8?B?S01ONHBGWnJDTFJxaWJBWlVDc0x5a1ViOWJvdlRYKzkvVHRNTHpndmh1M3dI?=
 =?utf-8?B?SXk5VHB4VHp1RjVIZkorQW80bS9kOU5vd3kxRkR5MWJBdWJSRk1lQzNNcVlJ?=
 =?utf-8?B?SzJhbVZJQW9kU0V2QWFVZ1VyQXo3a00wcnlPRWxSNkJJV1ZJOFRMU0h0TUd5?=
 =?utf-8?B?MVNjZG93eXZMc2QyNEsyelZjZ0lRTXFiYVk2dSt2MEpIMWhYZmZkL2lnSVlr?=
 =?utf-8?B?dVA4ZEJBelFKMEhmSVVqd3lRcytLakRyZUN0U3NFU1QzaFdyNjFjS25zSldM?=
 =?utf-8?B?Ry9CSXpKWmd3TDdKWkRNRVk5bGNXZTNaTXFlVUJxSEpBZGVZMUloOEtVblBP?=
 =?utf-8?B?QkNzRWpnNDhmSnRjMEtRQW1SR25PeTRQSHdhYnlVNEJoRnNmZkUxMkM2cDIr?=
 =?utf-8?B?L3R5ZGthcVEzQTJSa0xFdE5YR1UxZGs1dHBmRUhOZFJSWGphb2UvNFZ3RENh?=
 =?utf-8?B?em95TSt5YUExNno3MXhuNUw4ZWpLRWVBVU9BNDFJSVBEN3g2WFFwWFg0bVZW?=
 =?utf-8?B?cGsyL2NhallRSi9YSHBSeWU0ZW1iSE5pNGNDL1d5ckpKMDdXQ0lUWHhXSDhB?=
 =?utf-8?B?b3JkZTFnNHY4VlpIcno2MktnVHFDKzNZTzlVMFgzVEhwUkNjSTc4VEhFSXRa?=
 =?utf-8?B?d0JYMW5SY3hjeHYzZUpRT3J2M0xRWHpCMEFJd3FiV3J4UGM4L2s0TlpnNG9h?=
 =?utf-8?B?TjV6dXcyZnA5eXNxcTBwOGZWdWtHRVBLQlhWL1VzVmNoN3ZvZTZuWlBab1Fp?=
 =?utf-8?Q?fs+AlYG5An5I9GQpWo/pBbbGE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c1bc1a-fcbf-4707-08e3-08dd024c8c17
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:29:54.9350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhmbJoF8CKaadKV4wUg1whlu76G1mpi3HemiXTj/of9LTgwfjZbHyRKzCiAB2W0R55rSsxlmB10ee8DXKWLsfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

--------------U1cT8glYWeivinNdH4fqBFC6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-11-10 21:46, Srinivasan Shanmugam wrote:
> This patch adds the missing parameter descriptors to the functions
> v4_0_5 _start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:996: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_start'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1205: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_stop'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1428: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_set_unified_ring_funcs'
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1594: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_set_irq_funcs'
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 4e7da56a9f34..e487b68cecdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -989,6 +989,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>    * vcn_v4_0_5_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index to be started
>    *
>    * Start VCN block
>    */
> @@ -1198,6 +1199,7 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v4_0_5_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: VCN instance index to be stopped
>    *
>    * Stop VCN block
>    */
> @@ -1421,6 +1423,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
>    * vcn_v4_0_5_set_unified_ring_funcs - set unified ring functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the ring functions
>    *
>    * Set unified ring functions
>    */
> @@ -1587,6 +1590,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
>    * vcn_v4_0_5_set_irq_funcs - set VCN block interrupt irq functions
>    *
>    * @adev: amdgpu_device pointer
> + * @inst: instance of the VCN block for which to set the IRQ functions
>    *
>    * Set VCN block interrupt irq functions
>    */
--------------U1cT8glYWeivinNdH4fqBFC6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-11-10 21:46, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241111024612.1881727-3-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">This patch adds the missing parameter descriptors to the functions
v4_0_5 _start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:996: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_start'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1205: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1428: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1594: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_5_set_irq_funcs'

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <div tabindex="0" aria-label="Message body" class="XbIp4 jmmB7 GNqVo allowTextSelection OuGoX" id="UniqueMessageBody_29">
      <div>
        <div>
          <div>
            <p><font size="3" face="Times New Roman"><span style="font-size:12pt;"><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody">Reviewed-by</span>:
                      Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="0" id="LPlnk671546">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></span></font></p>
          </div>
        </div>
      </div>
    </div>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20241111024612.1881727-3-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 4e7da56a9f34..e487b68cecdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -989,6 +989,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  * vcn_v4_0_5_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be started
  *
  * Start VCN block
  */
@@ -1198,6 +1199,7 @@ static void vcn_v4_0_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_5_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be stopped
  *
  * Stop VCN block
  */
@@ -1421,6 +1423,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
  * vcn_v4_0_5_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -1587,6 +1590,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs = {
  * vcn_v4_0_5_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
</pre>
    </blockquote>
  </body>
</html>

--------------U1cT8glYWeivinNdH4fqBFC6--
