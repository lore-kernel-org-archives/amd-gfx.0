Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BF6C36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3B110E8A2;
	Wed,  9 Apr 2025 13:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDJMfYeT";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44C910E8A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0Snx8JNWbWc2IvMckNbgQBOVuTULcYHYpL3JyiCsMj+CvFnn9tL0nFsZzCfFzm6TM0zSulOAjNphPMu14MXmYialoxmDPzT1KVZ/FjkXHmkudp3ja75YOX4rvN0x07qAYgGnFsqAySnrPir+BMXDcah2atoLNwAtKMykTTLLWM1Nx17a8sNh9IEwcNmnbnAQWmLF9JcG1pbYQvb/8MRE9ptjhPOzV6gZWpTXMNnaHo7B2tY4xOFYMENwBukMssHDqMVEZwCUlCPPSfrWAu1SGiAAsHKiwbTs555lFeOgZJ2zlKn2J1RZMOFMIf8McguizAmj1hjfzd+OoAczakOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlSg3/0o47VVGsYZ8UOolHakU7pT4xBHi3U8lx0SgGQ=;
 b=n4TwExCfx+vZmUYqhol/ix66PJvj26NNdQLDJ8nikRaAN3GeZgaAkJxWF4i7YPqyeVlRceAW+JIkUJPlC8zlVDFy2vQusEFYrw+tl4wzeMgr60/RMxJIFbUc80t9lMp7QGc2wjq9+sCWJNIDp0GzDtle7qNSGZ30NWTc+QmpXaaRpJZLuIRN89K6xW+WVdFoLxbhBfwZ+ZF1e29gZRE2dPFCrawP3FJamTjO/eYXWp2cV8bmifgQoeRYfdk+gFlCLPLdOrgiV8+wc1xTNz/QwnkYO4s9IWdo4OSTYTMUhbrVv2SMdQ2/Hh9Ujp9V0oYbqEDot8RWuB4xmeTZhert/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlSg3/0o47VVGsYZ8UOolHakU7pT4xBHi3U8lx0SgGQ=;
 b=kDJMfYeTcR5NpvZhPerK5ulzO0HKiWhZvef/NZL6JQhd7l+7uhlL7zmTz1TnBOWhp4F9QydAbU3xLD/djGYUBRITt0JtKCQPCxKh6tkZGTj5HQcuPjUxsmkQaWHnGwIRvJ+vog3b+siBjLmIZCp45JKrkrFotduXQItwkt3BOXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 13:15:44 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 13:15:43 +0000
Message-ID: <965773b6-40fd-481e-8699-ae7234cc1934@amd.com>
Date: Wed, 9 Apr 2025 18:45:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v5
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250409104500.2169-1-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250409104500.2169-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 401f28e3-584a-4928-daeb-08dd7768a1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGVpaWZ1aG4vSzRCNGN3dzkvWkRsTTFWS1ZrVDdNQVZPeHBtNndPNDJzYllX?=
 =?utf-8?B?bmRmUlRiTnlKbHZoemx2QUkrMkRSVGN3VjA0V3pQdTN0WEptN3VuQUN5bC9Y?=
 =?utf-8?B?T01PNHNERHNOeGp4RjFCSVF6M1MvNEZNa3NEVnY3bXUwTlBQeEhvVWU2YUNL?=
 =?utf-8?B?L25ocU45M3RRWVNqdVZzYVljWC9VRk5qMmZYM21PbmFZUDVTbGNkcVJEVVMz?=
 =?utf-8?B?NlFsTCtQT3Q4UkpXVVFnUzJqUzJTYVI1MEoxVTNpK0U2UzNrRGFxSTVlNlJM?=
 =?utf-8?B?VUYxTjhJZ0h6OE9Td1VaNGFxR01Na3lJYTlNRG1RSzFrL09hdzFuTFZ5M1Q0?=
 =?utf-8?B?VmhJYTUySTVNTkZVQTdHNVVJeWFjZjM5V3pJVE9kU1RhZE1ZYWE3UUU3Z0xh?=
 =?utf-8?B?amVtTUI0UE11NnE5aG1DdWExSmo5WmJwRUY5ellEVFRMcVpWanVPN0ZYTmZ1?=
 =?utf-8?B?b29iV1hpOXh2MmlrYmZSNGVSZUQxa0R5aUVSdHJQTjJoY0VaSlpzS0QwVlRL?=
 =?utf-8?B?TmpoUk4zNjlCZlU4OXQ4MVdWMFRqc0p3VjV4OGt4WC9tR3NGdTEyVU5SWmI1?=
 =?utf-8?B?TWI0Z2UzdEVIR1hMSmhiMWFqaEhkQUpDZXo2WVdLaEdiM1kvTTRidnRJMTVh?=
 =?utf-8?B?Q3VFelpSTEVob0Z1OVgvSUNsTk9XSmkwODJiUkY2ZVhPYVNkc256dmFNMW1P?=
 =?utf-8?B?dFNhRXc1a3ZpV2l1amlsQlNSbnBsaDVuQWN2NUdRNHlvbnZ3b0Q4Yks1ZDRY?=
 =?utf-8?B?WjdYcWM4VWRpdUJmVXVxSHcrellyeFREc1VVdmxHenJqeGhEc2s2MVFPWVln?=
 =?utf-8?B?Nyt6eDhZSC9uOFJUMHVzTzNzTEQ5L2lLUVVFcGE0ZVV6SHI5V3daVXdpRmZG?=
 =?utf-8?B?VitoTjRuRUNQWlJWcUI5d1J1c1pLSUZxQ1VuMEdHc3VFTlJNRlV2bzlLQ1pW?=
 =?utf-8?B?YmN3aHdVMEltck5KN0tac1VBTUtrbVFUSVB1Qk1panBRbG84ZDI4bWc4cCsw?=
 =?utf-8?B?dnJEYUtncHk5bDVoaGZ4bzJ5bzNHekxFby9uR0xCS3BjQkhuYmxPNTdnWk5J?=
 =?utf-8?B?Yy8wejZwYXVwSVNteUNzU2huT0JQajg0WlRKdFRjNkxJNjlqcTh6dDVhak9U?=
 =?utf-8?B?Y3U0OTI5SzBmc3A5Q3N5aWJvcm5oMys1bzJXRElVNnpnUlRpMHRuWGJETzcw?=
 =?utf-8?B?dm9JbEJqbEhqOFNGWVFYTldHNGJxRXhJRi8zdTRERElXdForeGQ3S2QyZFcr?=
 =?utf-8?B?S1I3aEdWV2d1N0VMOWVkdTlnSStzZTFqUkhaS0lhUVhtQzMyRXJjdlJvZTFk?=
 =?utf-8?B?OTZQN0NwREY3a0Nrb3RGSC9SQVVHbnpLeUlBaUt2SXFIRkZtZ0NjTlJUdjBZ?=
 =?utf-8?B?VkRBSDVNM0VEVFBFNHoyL2p1NDYvTkYzZ0JUcklNa01QMXhwU0wrc0ZhNWJi?=
 =?utf-8?B?R3JQWFZzRDlkWXJNbjNqc0VrUjh6MHU3QlM5K1VHWXRSWHVINDZzWHNwRFVm?=
 =?utf-8?B?QVppUVJVL3JmMWJRRTVwTW1nR0MzeGhLMCtnbVZrTm5rWkk1SEFFQ2gyVXBX?=
 =?utf-8?B?VHZRV05LTFFPVVBibkJjN0FrbTFXaGRVaEFpMjRIUkU3UmRTUmVOWEF3bzFa?=
 =?utf-8?B?TDhKMERrSlZzOHlpcjNSTW5ZUmJSMmpYTFVsM01kTXFiaXVNdmNCMWNvNk45?=
 =?utf-8?B?NjNxMHJXd05iaTltbDNaZHkwTzgvMWFUSnBPMWdJWHZLaWJ6QW95cGZSZzcx?=
 =?utf-8?B?QVhLcVZSWlVURVhHSWFuY3pxR0FJRElveXpkTS9tREtBUzk0ck41N1RLNDFC?=
 =?utf-8?B?MjljYTB5enBVdUZSbkdzWER5Q1R1d3pVK2oxQ0hESlFsNkFZSk9lVG00enZR?=
 =?utf-8?Q?zt1a8twCRegL9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkk3dmVGUXVZWlhrcHdVM1ZCbkpNTFpNMXIydnVwQjZlVW5oSndIUXk5N1RJ?=
 =?utf-8?B?NDU5bEVuUnFNTUZUQUljNHFFTitUK1NOSzREa3lYNlVydTdhMGdMNEJsSmpE?=
 =?utf-8?B?Nk5WTW5oOUJCWEZ2NlEwL2VQOVg1Z2pNVE9TeTdvVGFKUnZ4TUduL2srWVNU?=
 =?utf-8?B?Tm5LbjhXNEo2NVU0Y2VyM0dHWFdTTFU3a2EvL1VCU2JpZjBpMlNYMFdqcnB0?=
 =?utf-8?B?U0U5NHFpSEw0ay9mOHZJWjhTWVh6NHF1b1g2cTJ2UEg5NnEyaGx0aVlrNDNs?=
 =?utf-8?B?OHhQNXZSWW5jeExGcmFqSnlrTTBLeUs4QnBoQzN4Sld3V0NHNG8rVi9sMHpV?=
 =?utf-8?B?ckR6WnZZZXU2emhTZDJLN1VOcGdLR2QxbmpMRDNPQzJjc3VlS2FrbC9VTWkw?=
 =?utf-8?B?SFBLb2ZxZmFrMWRsU2Rqb1RjUjRuWXVtWU5jZWpNSjZqRjdBek5MK3NDQlZw?=
 =?utf-8?B?b1oyeXFzSi9KRHh5OUtLSDZQelFKWVZ2S0huMTJTU1M4NEpXRVVPTUU0Z1hR?=
 =?utf-8?B?UzZ4YmdKYTZwYXFNRTlaZHlPNUhPTmV6QTYrVHBCU0sycHlidUJtZDZad0sw?=
 =?utf-8?B?cE1vcVp6NVFUeUE2Y211a0VnRlBNbEdObFJ2dXpIT1kyQ0hsSFJBUUErbTB2?=
 =?utf-8?B?TDJVcDhKdWt5WmlWbEFmdVFXT3hZOElpTnNBOW5nQUpCeno1K25admtBbDNI?=
 =?utf-8?B?K2hac1FNaUdsNDVkbWFiZWUzU1gxbUNscjI0ZkphOHpiZm1qa2FDM0lWZHN5?=
 =?utf-8?B?STBzOVpUV0N0ZXJ2QlQ4TDFPQmNmSlFaTHR4REdCaEVpU0lIUlpBQW00TXk3?=
 =?utf-8?B?TUlxVTVBamtnakZPY2VTaGlOT0hWaDhUVmNnbkZTeXIxTy9jbUNqaTFxQkFx?=
 =?utf-8?B?eVBEN25iUzY3aVBHaU9HcFJOdy9jMEN2M3lQUDg5RnlFTFA4aVNYeCs1clNF?=
 =?utf-8?B?Q1A5dWxMQjhpN1lHZ3ozNjRzU3oweUtIM25LcEVOL2dJZjJMY2djQTdSZldl?=
 =?utf-8?B?QmFDTUhaUksrcTRhbTFKQzJhYnVJakVlYXZXa0IvL2NEYThkL2ZCb2hmT0RX?=
 =?utf-8?B?Q3BCWFphcXFZcmV6eTlZOVFHVTM0N0xCVUw2Y0Q0NVplbVpZNmlPMkR4eUJI?=
 =?utf-8?B?ZjgyVWZldXl4Q0RxSzZoWTJhQzNVNm1UWEVDeEt6aWMrdmN4S0R5VFQvTmMr?=
 =?utf-8?B?M1NkdlRGVmZtNi93VHZBb2NvQzJrVzlqMjBwTzBpNURzandhYjFsUVA1d0Jm?=
 =?utf-8?B?VEM0Wmc3clAyajRFeDYyUzNxYStyTWdrbW5HYkxtN2lYMWRDMEhYSXBHRzQv?=
 =?utf-8?B?Ny96S0cxc3hadlNXQ2t1Q29pcDNYczBJc0RDQU5vR0laSGUxWVdyYUZzUHdR?=
 =?utf-8?B?MzZyMmFrN1lUamNUMHFxZWVaLzVDSERheUJPNS9Xd0ZwOVA5R2VsU1RxdXRj?=
 =?utf-8?B?NDFSLy9QY093bzNobE9rVGlrNVdOYVZvUTB2QXZuUHh4NHFoZGhKT1FidnZw?=
 =?utf-8?B?bWw2eG1ERGVXUEF4am5iaTFHN2RDS0NaOUREbmJRdEpnY3dlTTU3cW1sMWFs?=
 =?utf-8?B?VnRJRXZzV2tndUtNcHJOQlZPeitKckE0ZWZwelZjUzBlaGFQblJkbVhUZGtV?=
 =?utf-8?B?R1hIRVl5NkxJQmprdjJrNnY0SktyQndDL0dvelB1dnViayt3ODhrcldPRmlP?=
 =?utf-8?B?RmwyVWwyQ1BRNDA3WDNUd0RTL2I4MFhqVjdyTEVWNWdaUGVMUVMzREhMN3pM?=
 =?utf-8?B?QW9FeFBEdjFWZFJZeFNmajlRMkIxcFQ4dzJtVThjeHBZUHhZcW1ZT0xkeU1L?=
 =?utf-8?B?U2lxckFaUW9mQS8rN0VXeERRTUw4Q005aFlmRmtVMHR3TU1wN1RPQS92cmJS?=
 =?utf-8?B?bjBjZkJ3YzNpSDc4R2RhWHR1a0xZR2l2MXJCR0Z4bmc3MDZsRWdIV3pacnIw?=
 =?utf-8?B?eVV6M1Y2L2s3ZUhQQ3MrOU9pdVMxYk9vVG5INnpGQ2cvYWNxZmxVUDkrOXh2?=
 =?utf-8?B?bnZ1WWZ0dFFCVUg0NmlNQ1NOM0cxMVpCQjI2VU9CaHZDK21qWHdSY0pUcEJ1?=
 =?utf-8?B?OEE3Y0lpSTJJZE5yTG94eXhtaFBNZFNUb3A0MG8wcFBJelBpWVd0UGZVc1ND?=
 =?utf-8?Q?HWf2uNFGM+64nx5UhlK3bwnLF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401f28e3-584a-4928-daeb-08dd7768a1f0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:15:43.8210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWurqu9wTgfBgiwHvmuL59Re6Z8sXLIF25Qt9zonn2vgQb7lpzE2iDxvyrwvwG+kLfBNE0fj7gs3AcS+lWo54Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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


On 4/9/2025 4:15 PM, Christian König wrote:
> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
> that this has some negative consequences for some workloads. Instead check
> if the cleaner shader should run directly.
>
> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
> if the VMID has seen a GPU reset since last use and the gds switch
> setiing can be handled more simply as well.
>
> Also remove some duplicate checks and re-order and document the code.
>
> v2: restructure the while function
> v3: fix logic error pointed out by Srini
> v4: fix typo in comment, fix crash caused by incorrect check
> v5: once more fix the logic
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 94 ++++++++++----------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>   3 files changed, 39 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b3..30b58772598c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	}
>   
>   	need_ctx_switch = ring->current_ctx != fence_ctx;
> -	if (ring->funcs->emit_pipeline_sync && job &&
> -	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
> -
> +	if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||


Direct assignment in if condition looks like may not be allowed, may be 
can we split this logic , something like below:?

/* Check if job is present and get the fence */
if (job) {
     tmp = amdgpu_sync_get_fence(&job->explicit_sync);
}

/* Check if pipe sync is needed */
if ((tmp || (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
     need_pipe_sync = true;


> +	     (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>   		need_pipe_sync = true;
>   
>   		if (tmp)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b5ddfcbbc9fc..8e99dbd70968 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
> - *
> - * @ring: ring on which the job will be submitted
> - * @job: job to submit
> - *
> - * Returns:
> - * True if sync is needed.
> - */
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> -	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -
> -	if (job->vmid == 0)
> -		return false;
> -
> -	if (job->vm_needs_flush || ring->has_compute_vm_bug)
> -		return true;
> -
> -	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
> -		return true;
> -
> -	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
> -		return true;
> -
> -	return false;
> -}
> -
>   /**
>    * amdgpu_vm_flush - hardware flush the vm
>    *
> @@ -647,43 +616,49 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> -	bool spm_update_needed = job->spm_update_needed;
> -	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
> -		job->gds_switch_needed;
> -	bool vm_flush_needed = job->vm_needs_flush;
> -	bool cleaner_shader_needed = false;
> -	bool pasid_mapping_needed = false;
> -	struct dma_fence *fence = NULL;
> +	bool gds_switch_needed, vm_flush_needed, spm_update_needed,
> +	     cleaner_shader_needed


I think, should we initialize the "cleaner_shader_needed" here, 
cleaner_shader_needed = false?


> , pasid_mapping_needed;
> +	struct dma_fence *fence;
>   	unsigned int patch;
>   	int r;
>   
> +	/* First of all figure out what needs to be done */
>   	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> +		need_pipe_sync = true;
>   		gds_switch_needed = true;
>   		vm_flush_needed = true;
>   		pasid_mapping_needed = true;
>   		spm_update_needed = true;
> +	} else {
> +		gds_switch_needed = job->gds_switch_needed;
> +		vm_flush_needed = job->vm_needs_flush;
> +		mutex_lock(&id_mgr->lock);
> +		pasid_mapping_needed = id->pasid != job->pasid ||
> +			!id->pasid_mapping ||
> +			!dma_fence_is_signaled(id->pasid_mapping);
> +		mutex_unlock(&id_mgr->lock);
> +		spm_update_needed = job->spm_update_needed;
> +		need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
> +			cleaner_shader_needed || gds_switch_needed;
>   	}
>   
> -	mutex_lock(&id_mgr->lock);
> -	if (id->pasid != job->pasid || !id->pasid_mapping ||
> -	    !dma_fence_is_signaled(id->pasid_mapping))
> -		pasid_mapping_needed = true;
> -	mutex_unlock(&id_mgr->lock);
> -
> +	need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
> +	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>   
>   	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
>   		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>   		&job->base.s_fence->scheduled == isolation->spearhead;
>   
>   	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -	    !cleaner_shader_needed)
> +	    !cleaner_shader_needed && !spm_update_needed)
>   		return 0;
>   
> +	/* Then actually prepare the submission frame */
>   	amdgpu_ring_ib_begin(ring);
>   	if (ring->funcs->init_cond_exec)
>   		patch = amdgpu_ring_init_cond_exec(ring,
> @@ -703,23 +678,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (pasid_mapping_needed)
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
> -	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> +	if (spm_update_needed)
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>   
> -	if (ring->funcs->emit_gds_switch &&
> -	    gds_switch_needed) {
> +	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   					    job->gds_size, job->gws_base,
>   					    job->gws_size, job->oa_base,
>   					    job->oa_size);
> -	}
>   
>   	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>   		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
> +	} else {
> +		fence = NULL;
> +	}
> +
> +	amdgpu_ring_patch_cond_exec(ring, patch);
> +
> +	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> +	if (ring->funcs->emit_switch_buffer) {
> +		amdgpu_ring_emit_switch_buffer(ring);
> +		amdgpu_ring_emit_switch_buffer(ring);
>   	}
>   
> +	amdgpu_ring_ib_end(ring);
> +
> +	/* And finally remember what the ring has executed */
>   	if (vm_flush_needed) {
>   		mutex_lock(&id_mgr->lock);
>   		dma_fence_put(id->last_flush);
> @@ -749,16 +735,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		mutex_unlock(&adev->enforce_isolation_mutex);
>   	}
>   	dma_fence_put(fence);
> -
> -	amdgpu_ring_patch_cond_exec(ring, patch);
> -
> -	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> -	if (ring->funcs->emit_switch_buffer) {
> -		amdgpu_ring_emit_switch_buffer(ring);
> -		amdgpu_ring_emit_switch_buffer(ring);
> -	}
> -
> -	amdgpu_ring_ib_end(ring);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index daa2f9b33620..e9ecdb96bafa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct ww_acquire_ctx *ticket,
>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>   		       void *param);
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +		    bool need_pipe_sync);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   			   uint32_t fragment_size_default, unsigned max_level,
>   			   unsigned max_bits);
>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
>   struct amdgpu_task_info *
