Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6BFCCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 11:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F8810E3A1;
	Wed, 15 Oct 2025 11:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fWoEZ7Pk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF48010E3A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 11:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J81wcAsXWvCaB+AScfE+QaFd0QSXv/61XpRy4MWvZC2DSu9HwO+4pwdgxglehePOmBir1h/M5vNCuxQFFb1cQkO7z9HfeAfgyzeYyDA+Q03Cf2AwqcSYhnpKDXPVKf909SUkyQB0T6S8sYr1L0OTxoufGrghYo3TZq4IFOD7EUjsfShaI7w3W5CVgh7PR0SSdJJm1xWIxwS/qOgSZeVqnDZQG+iFNvYP+8saWGhHeFch96bfmbstccB2keNa/ixXyd136yGwmeQshCbh/K6VoX5ecunPPcxtwQU7Q79yzfAR5xDWfyC39Ww4SzKy3iwUBJcSA+tMmVuvndFiFztMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyf8Qj0c4aLELsOXVMZoaiPdYMHgNQWbOqxoU5UXj0o=;
 b=YB4uGOC2BUJYSTd1uh83dud7lA9iLOylOjoq7EWSO4Mm1kQaCG7A5sHu/VAHouCTDkpxqg5OdHSuoPKEKrVN6bSPh/pF8kxlXPH5XYK+2u2FYVrprLl7uExAhd/pzXyKekCd7no29x+O+m0oaVn3LRe2UkCz7alVk3vZHZzMqrTBsQdu7p5qceZgG9rYMuVxZBu8/TwBayEH9Qm/Hi90CIYPxBpzZyr7QlkNjZsDgpZENiXSRnbVGfA0VVcOkjRWzgizC5x/UgPsCabnovZ3qwYY+CVCWqu/y/K+GBbql57EKBpbC/TboHT7LOKG6c1mve0UTmOWDriC2gFeaTtYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyf8Qj0c4aLELsOXVMZoaiPdYMHgNQWbOqxoU5UXj0o=;
 b=fWoEZ7PkoLNdVZqHlFQviD32EWjNG0utGPISVRvI98zW7aMnd6JE0rPNRTUdPEpHQCtsULwgBdNTenLZcdJDW2x54Lry0l+CoIaazSkFMbUIHf7BJ6SN+5sNj6/FgB+fwiZiikALdgme7freORIuRKSN2J5t7eFgvr7uVOEYurw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:16:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 11:16:20 +0000
Message-ID: <2c49cdc8-799b-42b4-a9d1-e48db5c1bec1@amd.com>
Date: Wed, 15 Oct 2025 13:16:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] drm/amdgpu: add the kernel docs for alloc/free/valid
 range
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251014115420.522595-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251014115420.522595-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0564.namprd03.prod.outlook.com
 (2603:10b6:408:138::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: bd149242-974d-4491-0a65-08de0bdc4454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0pkN0dTNlphZG9IRnl6R3dRMVh5UmhTbGk3aGxkL0tsVExqdkEvZTgyK3FV?=
 =?utf-8?B?ZU5zTTE0eDlRZE9mNWtZWTZKZHNQUytaUFlkang2aWZSRlhrRHVjdlN5NzF1?=
 =?utf-8?B?bk1VRm9MVXpYcXpySHdoNTVpOFdIak5mQmEraUUvZkZJZWE0WnRQbTJiNjhs?=
 =?utf-8?B?T1pQVSt2ejNFMXNyeTVuRjNRY1M3djZqa1ZJdGFpNk1SaEorNHVuUzJGYUZ4?=
 =?utf-8?B?dXJMa0lmVStDL2ppaGQxTTdZOGxwMlJhc1NhRGdoNWl1WDNmWkNVdE5KZkN0?=
 =?utf-8?B?SHJXSzVUejRHVjRLOVByNU5Ldy83bTdybjRlVEFsQk1HTlc1QzNMcHZXQUlW?=
 =?utf-8?B?UXhVSnB5OXZ6NlhJT01rYjY5RUFrcmJvcGo0cmR1VjFKRXlxb2FEd0hvTlpv?=
 =?utf-8?B?Vks0Z0tSL0pZUCtoWUkwU3ZtV2hwaGlpSkVVMTdUcWExZ2NtTURqK0xub3hl?=
 =?utf-8?B?OU1ROE1hRVJvMDVTUmN1dlJvbGgrWTFicTE1Q1pvUjQ3TnJWbWN0N3BNbHB3?=
 =?utf-8?B?ZGh2clY0dGI4cnF3bU5GSDB3aTlQcE1LQ1cranp4WmtEMmtYeGhpYUordDlz?=
 =?utf-8?B?MXVFZGV6UlNMVnFSVkZaV000LzFZdXgyRU9ld1plM2llaHZoa0ZNK1FZY3Fv?=
 =?utf-8?B?ajc0NU84bXpUNDhYUVFFSzdEdXFocEFTampXdHliRTlJWXBvYmRpM0d6bUxG?=
 =?utf-8?B?dXdpajR3QytLSy9Qa01DbTF3NTVnN0xncGx4SldpTjJEa3dWUnNMTHk3bExG?=
 =?utf-8?B?U0xIME9PMktDNEE2N2VyMW42bjVseG5YcUdQTGdYQlRZcGd0cXM2VWoveTU0?=
 =?utf-8?B?WXViVWxiSFpDZTlFNmUzVkZ5Y3VaWlN4NmJNMTRUZG04YnlNaVNJUkF6dldW?=
 =?utf-8?B?S2x3UHV0cjh4RGZDU2xLditMRnF3UHQ1YWN0bDQxb0JPOHlhRkkySWoweXQx?=
 =?utf-8?B?R1ZBRXB4RDNVNWNGQzJGNnZxOElUWXlEd1RUVXZWa0QxZndpWXlOUkJIOVM1?=
 =?utf-8?B?V281Y0YxT2lpS3haL0JoQXVaV1cvM3hsNHZ3RTZJZHJ4Z0FxN25KMzE3d1ZC?=
 =?utf-8?B?cEhoR3lJTFJzSm1Vd1FXWXZDQjFhbG9RZkR5Mkp3UllqbGRVUEthdlM2cklG?=
 =?utf-8?B?MVVUbjVqOFBMV2ZvWFZjTVlnQTQwNFpmWFBhN1VRWmVqSWR4bSswQVVXaXJN?=
 =?utf-8?B?cGhUT1lKTlUydk1GSkpaZTFTK1MvNFozdjJPTlZFRlZSRlVPRkxjY0hQZWcz?=
 =?utf-8?B?a1FyMElQTHBudnIwZU9ORjVuZGpJbWs0MWNscjR6TmFvRXVKb0R4YndiVGF4?=
 =?utf-8?B?SU1Yc2xTTE44UExEZGZYTFVwcjFmVTF5bE1MYWlIQ0ExTXV2VitVcVZSWG5q?=
 =?utf-8?B?ZmlhTjdIVTZxSTZrN1poZ0lzY2NSS0pzZFVGcDVOVWUwQTJZTXNwNkVJQmVF?=
 =?utf-8?B?QXpJbk80VldIMm1ONnY4RGRYNkJkSEV2UGxHTm9ldUl5WVpKTDdBWEZYWHB1?=
 =?utf-8?B?M2RBa3dMVytoMWI5WlMwUHlNZFFqeXlTQjRHMUJWMGFueEFONnNLaC9OR0dP?=
 =?utf-8?B?WmhpbW1vOXdDbktRL1ZCSUZzdDB1U1BKMVBvcGdpanRSSVVIVVQ5ZWdTTG5u?=
 =?utf-8?B?OUdLREk1dXAvZ2dLT3lYQ1plU2ppZzQxUnR5bDk1Wm1HZW5aYmJOa0xhU29r?=
 =?utf-8?B?UDhOaGRYc0d5MVIvaTRuRlJ2Y1JjMkY5alluQWpiL2NwSWJIVGtSNnBUd3hk?=
 =?utf-8?B?RlgwV0RtL3V0TUpIem9Hcmp2dXg2TUtZSFdhU2E4cGo4dVo1YnRFUnJnY0hG?=
 =?utf-8?B?MkMvd2xWdjNqT0kvMWttTTBmVExMYkZoWUZPcFNJNXlkZ2ViZzh4NFBJa095?=
 =?utf-8?B?M2hXc0VkV2NOVUpZalI3YVQxRC9WSWRCSTRWeUttMitRN3cyT0hmOUFrMFlD?=
 =?utf-8?Q?INEk/Fuk5jF4Ct0VlRoxn2iO8cuS9Gx1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhJT1kvUXdkNXd1VVYvZEJDcjlXaDBoTzNQWDAwWktZTEc5RzFHNkxxSUVw?=
 =?utf-8?B?UW16bGJja056em5Yd3V5d1ZXVHgvQ25HelMzK2RYWTlrcU5XTzhqY3U2ZzdU?=
 =?utf-8?B?L2wvZFg3c1BYamQ0bEpPM2ZhQmVveVBuUERrZ1N5djZUQXFjb053SDdBd0Ro?=
 =?utf-8?B?eUhYNFRIbjBzZzAycHJiRUtkSGdqTlJDZzd4anRPWFRDejcwVjFiZjZ6Vk94?=
 =?utf-8?B?SjJMWnVPejY1QWFMWkp2c3V3b1VROVJkMlBHaDRtVnRIVEpuNUVJSEp5K245?=
 =?utf-8?B?K041OWc5ekhib2dpbEVGVHVQUzhtMEt0RWF0T1BUU3pBckE2eWZBVDltc3Z0?=
 =?utf-8?B?STlDZUo1eW4yd0RnQmV0NVc4VHdFcFhDd3F5c2xyVjBHem56cnNCYzlqcW40?=
 =?utf-8?B?Vk82SEs1a1pHZ0djS04vemw1Z3kwUnBxbFNldkNJYWJSRWlBWGxaQlUxYmIy?=
 =?utf-8?B?VDlwVkIva3RjYnZOR053ZVV5TGxSUlVNQkFVRTlCd2ZMVXI5ckFWUVdyMkZs?=
 =?utf-8?B?TTJuaVRyQXZEajk0SVlJeE94UFlkU0p5UUVjek1OczF6cnM1WUhKMGR2eHJP?=
 =?utf-8?B?Z1AvWTFWTzBsTDQ0Wk1kRWtHMGlQY0VrUWIvRkN0bzZxaVRqZ3JSejB0Szha?=
 =?utf-8?B?VjMxUjNkNHR3MzBWTHRwNUZLZkhXcWZncEk1WXRqVFFmTmxmazJLMHhqS1lX?=
 =?utf-8?B?cnN4SmQzRXg4TmY4ZzR1SGI1enBnN3NrWk9ENWxZWm4vcjZmMjNyemtmaG11?=
 =?utf-8?B?cU5RS3llaTJ0T1gySVl2TWQ5MkNMSmI2amRmV1YwRzFRWEZmWTFWRUlEaW1o?=
 =?utf-8?B?RERyUkpMQ2lBWWYyMDcyaWhuT21IM0JyZVpyMUMwT29zcGhvWGlscE5QalQ5?=
 =?utf-8?B?ditpb0xYS3lzTFNmNGhsakdSR1RJeVF0UEtROVJ5dXM1ZFhDOGdyeVlLdW1T?=
 =?utf-8?B?N3dZU0MzWWlnUy9KZXdzR0Z1R0hvY0luOFc3eFB2SkZhY2pxVnQ4MWhDT05p?=
 =?utf-8?B?ZGZKdHFMdk0wYmM3M2gzbkM1aVhIWWRNR0dnUUpRUXJCTW5PYk1zcWU2UGhL?=
 =?utf-8?B?RWVqVWovYkRTY01ZOWRqWU5rT0lhOHk2SkxhL05YQmx0SU1BeDZjQm5iT2xw?=
 =?utf-8?B?M1F0OGZlSVBEekdyTG1UQmVsR2ZqejV2WEdHMEtrRjVsNFhkaGpka3U2RU5J?=
 =?utf-8?B?dlgwTWtLZDl5UnQrcklrcVovWHIzTEpmNVpJTW5ZNVFTUXRBZ0xnOVlWNkVF?=
 =?utf-8?B?OFI1VzFDeWp6RHppRTBudTVkYnpXMU0yWjRRbnZTbGhGRi9FUXZERVNCN2s0?=
 =?utf-8?B?L1VmSEJtMGxUdXg1cUVpRC91elQrbkFzZ2Zub0gydDZidTc3T1hRcE5wb01s?=
 =?utf-8?B?Z25Qam9qNkFzM3FIKzFOR0pUbGZuU1J6RTFBdytkNHdxeWQveTJQZE1DVmpD?=
 =?utf-8?B?MDJZblNyK2pWVnNabWJaVmFpMkZaaFg4K0laZTdobXIwQmgzMW9Ra2pkSXNR?=
 =?utf-8?B?ZlczZlpTT2FwREFDQlhoMmxEUXdkOVFUUjloQ2xoMkMzaS8xMExUY09yTWVl?=
 =?utf-8?B?bGFKK2F4OEJZcGx4cWM4dzAzZXRGUkN5RHY2bjBvdVdKNkdwWjBMTkVtN3Mx?=
 =?utf-8?B?aTdhNkU0Y0ZXUndxTzNYY3hIQ1BjYkRzQXJ4NC80WGxkQTd5Y1hvRFlPN1ZU?=
 =?utf-8?B?OVlnTmErZE5UTUpjdE9aRFI4ZVFQNGphdUpEM2syY3MyUVhhb2tQek5UTWVY?=
 =?utf-8?B?RVlpYXRqaFBXeWdiNWFwV0pVRmF4aU9kMXdpdFg4VGJWZWJTMWF2Y0svN3Zv?=
 =?utf-8?B?L3hKNUFsaTZQMDFhZ1kweG83QVdiUnFhMWo1U0xJR3drNUJNZHRCU1RpTHhB?=
 =?utf-8?B?NkwrS3NPUzNWcFlRanNtSlI5cHRCZitxT2FkclJ3QTIrK3hNZ2NrSERMZXpj?=
 =?utf-8?B?STAxZnpCUTNZczBpdjdGZkRmYTRjeUMxVmRLZlZ6RUNxQmRWNFhrYzYrdW1S?=
 =?utf-8?B?VnhsYVduTlJFY2JOWFV0dVlsV0tudVVmYytSR1RhYnRRdklrQ1JxcXRCeVhr?=
 =?utf-8?B?dGNSUnNOTjVGTmhaanQyV3IyZGVScU9ONW0vcVBDOENsVjc5LzMyT3FMb1JN?=
 =?utf-8?Q?AUp6a2Ghtypn8ZSU27JeOXCBA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd149242-974d-4491-0a65-08de0bdc4454
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 11:16:20.2691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4ZuAm+gbvrjjBpmE3mXjsJzzSRm46VpkPZyx1VoESowFh6LdNXBOiQ+G6tSzDzP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

On 14.10.25 13:54, Sunil Khatri wrote:
> add kernel docs for the functions related to hmm_range.
> 
> functions:
> amdgpu_hmm_range_valid
> amdgpu_hmm_range_alloc
> amdgpu_hmm_range_free
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 33 +++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 04f02e0c8bb3..d6f903a2d573 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -227,6 +227,19 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	return r;
>  }
>  
> +/**
> + * amdgpu_hmm_range_valid - check if an HMM range is still valid
> + * @range: pointer to the &struct amdgpu_hmm_range to validate
> + *
> + * Determines whether the given HMM range @range is still valid by
> + * checking for invalidations via the MMU notifier sequence. This is
> + * typically used to verify that the range has not been invalidated
> + * by concurrent address space updates before it is accessed.
> + *
> + * Return:
> + * * true if @range is valid and can be used safely
> + * * false if @range is NULL or has been invalidated
> + */
>  bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>  {
>  	if (!range)
> @@ -236,6 +249,17 @@ bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>  					range->hmm_range.notifier_seq);
>  }
>  
> +/**
> + * amdgpu_hmm_range_alloc - allocate and initialize an AMDGPU HMM range
> + * @bo: optional buffer object to associate with this HMM range
> + *
> + * Allocates memory for amdgpu_hmm_range and associates it with the @bo passed.
> + * The reference count of the @bo is incremented.
> + *
> + * Return:
> + * Pointer to a newly allocated struct amdgpu_hmm_range on success,
> + * or NULL if memory allocation fails.
> + */
>  struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>  {
>  	struct amdgpu_hmm_range *range;
> @@ -248,6 +272,15 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>  	return range;
>  }
>  
> +/**
> + * amdgpu_hmm_range_free - release an AMDGPU HMM range
> + * @range: pointer to the range object to free
> + *
> + * Releases all resources held by @range, including the associated
> + * hmm_pfns and the dropping reference of associated bo if any.
> + *
> + * Return: void
> + */
>  void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>  {
>  	if (!range)

