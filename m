Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475EAC5474C
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Aug 2024 03:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFD510E039;
	Sat, 31 Aug 2024 03:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jNfTwell";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C773E10E039
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Aug 2024 03:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDHqzP5Fa9AC2w7SlvZd2GzgYzLJMNYdm5m1lR2V1JcBzCsFNcCT3NX/sCdpDsCYU+id6MYAeePD5B7Wc7tfVhXfvzeLd61aLA0A8A2KtP7bzUp4bGC06hcqJUWkwTGe7qBmeTIPubimRiqnoRnUdvuhh1WHtQSuJFaqtWdx/Wp0VPlfiTxEKjfXQaH92xbZG7qnSDcNoE3bq4j5VVkwdMGmCj+CbHjSzCSyirNF077bu3oyA+mxXC7uA71kSSLdNPnfsNrQgh16saiR3X/B7plXdCnjLFmyN8jAYOAh9y1Xzpa9MBZndW8OGjia6y4t3b3Cyr+TD2Hcf4WY5elmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LxUezgz3FaMd3O8xsz6x3lxmXQgxGE3cWQmPyNegOc=;
 b=VFxDyZkxZ6ebSzURPbSnj1GoPwvxegp2QTRynRHo3wGn3MY6KlJmHUNtHObZsZNeQZ7TQtizZShvu3jQ51GNaCprZJigBXGvYcDHLz4VmwzBG2i02Otzx9YCeEE4cWbmstN6lXAM1+ZDnzhq5NnLJwcgyyGbyCrA5pOmvMU+jWj1C3zxRlpG0ZzW3NGKQv/dqy95mfeJbOrPgNxaFXx6efVjfYh2UDzYNi2rWfBCIQeM310eYLqM9zNJgXUEWsjR5cB+vGQACvWOdLq89OYWL/08PDqbCDhl+ZuQkHCBzMqQYmARHnUFIMsiLPFfwFuM72azHVqCvOogwJGZu/9UFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LxUezgz3FaMd3O8xsz6x3lxmXQgxGE3cWQmPyNegOc=;
 b=jNfTwellISdpMA09hqpw5H/KnPgkZNx92HU1RFcgDVn9t6bH9Q6lfs50uf35L4a0wTbKiakf1scyBfQJfangxjVpyGuiVyNX5PpwbWm+k6xivZ2gHrCmEcKuDPVyCvGIlLwBdly0aQbAOlRphG1LShW2z/h8gXcmvEiOTHjmcsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Sat, 31 Aug
 2024 03:43:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 03:43:19 +0000
Message-ID: <4f4364ed-40b7-4546-bc7c-7655fa933d8b@amd.com>
Date: Fri, 30 Aug 2024 23:43:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: restore_process_worker race with GPU reset
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com
References: <20240823194901.25068-1-Philip.Yang@amd.com>
 <1376d3e2-f978-418d-9aee-c8282565d236@amd.com>
 <83273bfa-7bbf-4eb5-17c0-05d1fa9b72a4@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <83273bfa-7bbf-4eb5-17c0-05d1fa9b72a4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd0aa85-15d5-4cfb-b208-08dcc96f0e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlBhcy9zUVRKYXY2VnI3dFcvY2hWT0J2QnU0UHZwMkRZRHhnRXRsaUo3Z3BB?=
 =?utf-8?B?ZEFkSjdJc0R5U3dKK0FZdnc3d1hJTlNyY2p6aTVLR1hUVVJ6eUIxUkhwaTVQ?=
 =?utf-8?B?c3F5S0lwYXd0N1FDMitPUE9rR2JMNFNWR284dEhTbUpJMWd2THVzbkpGZ2Vy?=
 =?utf-8?B?ZlE5SGZXUW01d0gwcEhmdXBwdmQwem1pQkFMcTROK05YWVpISkwrY3ZXU2I5?=
 =?utf-8?B?S3NhZ3ZJRzZhSW1EQW1FZ0ZWZFJCMFAzbDVYdXRRc1VPT1BhQ3lpeTIzaTAz?=
 =?utf-8?B?K2RXS3RmMVREUDFFdXBLOUh3NnhZdUEyUlh3SUdyRTRvSWFwdEJ5bzJmSml4?=
 =?utf-8?B?ZEpmY1lmZTZtWGs1clpVV3BJb2J2a0dGYm84UjBlTGhGVzBPODN1bnBVT0Jh?=
 =?utf-8?B?bFV2RHNrMUczTmsvZS90RWIvLzBhczRVU0pTaXlZSWNmcDhiWFdwSEhvSVVG?=
 =?utf-8?B?OXZiZzlSSEhUQk44eURBUStWY0J5MjgyaklDUWlVYXY5ZlI0UDFGUnRTRS9n?=
 =?utf-8?B?OFJjaFNnVHlhNXdZUk42amFtK012RHd3S3ZWTzVhb1hSNUJqU08rTEtoY3hT?=
 =?utf-8?B?QVBCcE8ybmIyckk2Yi9ZZk5MdStFaHFrL1BkMThINWJqQmZkazhSelQvSVNq?=
 =?utf-8?B?M1lkM2RmZy9kWHROV0d5OHM1QWlhdDZQS3dWOFZEVTZiNFh6cm03NllxcVJh?=
 =?utf-8?B?RHVGazYzZ3dWb1kwRHJaTWlyZnhhZ1o2RWE3aWJzZEN3Q05XVXhJdE5GUmJZ?=
 =?utf-8?B?YWNnVXkzN3N3M1l1NTN6OVZqM2UzRkh0T1JOV3VEL1pjZWdqcUc1SjhWUXV5?=
 =?utf-8?B?a2xRRTR1SmxNR24yeFhmZDRDZWdENUNMQjRjVmZ5dis5STlnSjg2V08xZzZE?=
 =?utf-8?B?ZHhwY2tjYWZxYkVQaGtpbjY5TCtlcElsOENJL3JNNmZENllPRk02eWlqa2E1?=
 =?utf-8?B?VWt3ZHBKRnUwQ2hRNHdudU81QVI4NW9lcGNGeUtUeDdzZkh4Nk5tZFJianZt?=
 =?utf-8?B?dkhFOFUrUm1XUmlKTWZlU2VMYWhuUnlDcE52Nk9WNnV3R0p3N1d1c1BGSks1?=
 =?utf-8?B?Z09MbE5QdjQwTlNjZ2dhQkZIc2x2ZjBkSndDSHgrc2htV0NwbXdSamY5QzdI?=
 =?utf-8?B?K25RQlMwRmJSbVA4LzZ1VGxWMm9XNHVwSXMzeUhwR28wNUVHdlpIaEN2MHFS?=
 =?utf-8?B?dGpzajJzTWZkWXVtQWRVOGE1Q1U2d2lQOXZQSDFaV2VpbGxQc3FSSjlIaUVN?=
 =?utf-8?B?Z2I0SkFKdTdTZUhFQ3lWWGlWK3FTek0yWVUvenVrc3UxdTFCaXJKTkFWSUdh?=
 =?utf-8?B?ZjhMbVpHRGlDMXdjOC9PNzRVcE1TNWlKSEg1MmlHaTVvOEllaTNxZjV4ZnRU?=
 =?utf-8?B?cEhTZEdlWU1KaTdRR2g5clQ2UVZ5elVYaE5zbWZUK3BHUjdXYXJ1UHBCOURJ?=
 =?utf-8?B?TW1nMmNOd0JWZnA5ckE0MEgzZm51Y3B0b0U1bUdTZXZweDNWT1lySDZ6QzNq?=
 =?utf-8?B?WmZJMElzOWV5eEFKbllMcHlQRk1tT1FIS2xrUXBhNVJCYkQwWWdJN3VYQTQy?=
 =?utf-8?B?OHJwMjFRb3hDNmw1b3BjUmlZSytqQ0VqVlN1ZzZpaUExWmVlSStQQlQ2U0FS?=
 =?utf-8?B?cSsrTXZoYkNVcVBkdDZxVWVOSUJackwwSi9pWnpDSUFYcEloZ2YveE1UeTJi?=
 =?utf-8?B?cTlVb0t4K2xvYzB4alg1YWdmY2syOEVnWC9XVGNnRGVIS3pocUtqQUZmUklx?=
 =?utf-8?B?bTJtcGw1U1RodTJuM2RhZWxmaUpUdGlZRk1vNmhrc1pSVGtIbW9ENTJ3MnhM?=
 =?utf-8?B?aGZ6L0k4NVJRZGtWQ3lWUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNlOXNuVVNyc1RVMjRsQ3piR1ViVTdNdnlOOTVJVk5LYlBCSmQzeHlPa1FP?=
 =?utf-8?B?cjVJNFNvSG9PR0NKVkpqOGovMzhjanVyUnFZOXgybWVKcURRdUg5NEtMWkJh?=
 =?utf-8?B?dWtPNnFlRFM1VXliZ2g2cjFBWCtIRWVOU3Z0ellUUnhYVHhYcjhFYzRHSGVV?=
 =?utf-8?B?cE44N25FZXpwNStibTRtSlQxczBONzZrY1hyL0RKUjBJMzMzT3ZHMUovaGtJ?=
 =?utf-8?B?NjMzeXNndVBCdWtFNWlXNEN0VzVuRXF0Z3dSTFFmekRvM2FLamQ4TzlFckJL?=
 =?utf-8?B?K0N3NmlMcjAvTjZMM0RlU3B3NnVQY0RNUFpDbStVOXBXakhuN0VWN1doMjJO?=
 =?utf-8?B?MXl3eFhueUVNQzV1RmdodjA0cGFXYnhoMTJ6UVNhT2NWL1o2cWUxMUEyeTRt?=
 =?utf-8?B?cVBuTHpsYWhURnFXc3RXWGZkaDB3cTNwNjBjTFdBN05KMG4zNTFRNW5Eckha?=
 =?utf-8?B?TnhadUk1bzJWSUYxNTZ0Zm1oZHBtcXZ6M0sxMFVoa2JmampvVmZ3Y09GQkJX?=
 =?utf-8?B?YXgydCswYWszQnNxZ2Zod2E1eEpyQ0lCbUc1OHFwenJtMDdHRW8rLzkxUjcy?=
 =?utf-8?B?c1drRG1qeDRhK3RPRzR1QlcyZDZhSklyeUUyTGE1VVRnMWdycnRKZEh6UXhQ?=
 =?utf-8?B?Qlk3SWhnTkZCMUg3SVJwWFVPSnZrNmN6ZjRtVUZjYzZ2ZjlJSFpYcHovU2J4?=
 =?utf-8?B?b21EMGxCc3pzQnFKS0lweHY2VFpaVDZZenNPNktlaThMTEltQVg5YStLd0Jj?=
 =?utf-8?B?d1pzN1JRYURrdHhVZ2dGeDQyT015ZjNpVXRId1d4QmFrc2pvdm9ROWdNVEs3?=
 =?utf-8?B?UDdOQk04VXlFSmZra0JVUUl3ZDErWmc2anFiT3VUenZpY3M0MHhJR2orU1Q2?=
 =?utf-8?B?bjFVOGpXekovNzIrOWtyZGJuTzJsWTQxSnhGTGd5d3M1MGV2NlhadkpueVJj?=
 =?utf-8?B?NUxCN09mTnZuZEJmcVg5RTk3NDQyTHVpNHl5L0hWQ1ZRS2UxS0FqNElVSUVY?=
 =?utf-8?B?alROMEhabi9kL2IxYWNaM3BMdGFpWGxDeU1xalNla0txZzFHTm80UmtMdldv?=
 =?utf-8?B?NWRxeHVFSlhtbTc2U1ZzZTdzZzJ2YWtVSTNTa1l2WGdRUnVISVgvZGxTUkdF?=
 =?utf-8?B?dm1yeVEvVzFINTlaN29IWjE4QzdvNDJuV2dWWHlSVFF1V0FQZU5rM3dZS00z?=
 =?utf-8?B?K0tMeWhTYzlWazRXU3JMUzhtZ2FGRzJIRDdHZ1UrOEVWT0tHbXA1UjlPeUV3?=
 =?utf-8?B?aXVuSy9HZUtYQnl1VXpVSGphMGV3U00xS2pYK0FwRnFYdHI0T0hRcm9jUUps?=
 =?utf-8?B?U0x0bGVrNFJqM3dnVHZjTWp4cHhwSnBCTGluYkNsUFgzanZab0R5dkFBUWI3?=
 =?utf-8?B?TUNIUTVoQUh2Qk1aUXFmL2c0SWRERjZOWFc3TkMzUG44WkNLZ29uRW0vY3Yz?=
 =?utf-8?B?SEZMQVprMkFHZlJ0M2FvTzJ1QWt0Y3FKUmhIM3RCVStEcmhFMFBzQXpIMW9s?=
 =?utf-8?B?Y0J4RWFMOGsxWkduendacTQweFRjM0NIa0NSWEswZktISnhjdTVwK3VZam9E?=
 =?utf-8?B?eEFMenFDTkt6QzQ5c1oreGZZbzI0cVE5cXdGQ2prSUdUckhuRVovTWNYNU5t?=
 =?utf-8?B?WWsyMXZrNE5tNTJlSVIycHVLTWpIKzg4UGgwdzE4UFZ2NXZVUWtvcW5hVG5H?=
 =?utf-8?B?aWVwRDFkT0dxY1J0bEt4TVpLYjBLNU1kbkRsZmxFVFptZlUyQm85SDE5ek1y?=
 =?utf-8?B?R043S2xYMEwxK2l5Uzh3OWM2UzJDQ1liSjlyaHJ6RXY1ZmZ0clp2MktCRTNh?=
 =?utf-8?B?bjdFcW90WW1Zdm4wWDJRTEZPc0F6WEtURmpLWnl5MUVGc1Q1cXJUMEZHZnZK?=
 =?utf-8?B?TGtZaGs1R2U0dk5nZzhtNEJKSHE5UE5hWFVRWVJwTVJvT1RiQ011MDViT0Ju?=
 =?utf-8?B?bjdZbTBqZ0RPT3ZIRzVaemVyb2ZjUVZNeTFORXpQd2YvdjV5Z3VVSjJ6S3dr?=
 =?utf-8?B?WVJ6N2s1TUZJeU8zUU9meng1WlBvZ0h3ZXY3eUtvazdmMFZJQkhVN2ZaOG5u?=
 =?utf-8?B?RURUcThFVGdKOUN3YlJ0NkpXaURONmRMeFpmSmhJUXB4STBYWEdhZWRkRVVm?=
 =?utf-8?Q?KEyvYxkYSfJIb8gM/VonwKeM8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd0aa85-15d5-4cfb-b208-08dcc96f0e23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 03:43:19.7125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDKw4igJ4Oftueti+cfPIMLha7N1pqwcjWuOPt/QpDCYUGFU5CiAjp2Xalh+gQ5NH9pUN3KwNYespOV9L1Gp4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
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


On 2024-08-29 18:16, Philip Yang wrote:
> 
> On 2024-08-29 17:15, Felix Kuehling wrote:
>> On 2024-08-23 15:49, Philip Yang wrote:
>>> If GPU reset kick in while KFD restore_process_worker running, this may
>>> causes different issues, for example below rcu stall warning, because
>>> restore work may move BOs and evict queues under VRAM pressure.
>>>
>>> Fix this race by taking adev reset_domain read semaphore to prevent GPU
>>> reset in restore_process_worker, the reset read semaphore can be taken
>>> recursively if adev have multiple partitions.
>>>
>>> Then there is live locking issue if CP hangs while
>>> restore_process_worker runs, then GPU reset wait for semaphore to start
>>> and restore_process_worker cannot finish to release semaphore. We need
>>> signal eviction fence to solve the live locking if evict queue return
>>> -ETIMEOUT (for MES path) or -ETIME (for HWS path) because CP hangs,
>>>
>>>   amdgpu 0000:af:00.0: amdgpu: GPU reset(21) succeeded!
>>>   rcu: INFO: rcu_sched self-detected stall on CPU
>>>
>>>   Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
>>>   Call Trace:
>>>    update_process_times+0x94/0xd0
>>>   RIP: 0010:amdgpu_vm_handle_moved+0x9a/0x210 [amdgpu]
>>>    amdgpu_amdkfd_gpuvm_restore_process_bos+0x3d6/0x7d0 [amdgpu]
>>>    restore_process_helper+0x27/0x80 [amdgpu]
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>
>> See comments inline. I'd also like Christian to take a look at this patch since he's the expert on the reset locking stuff.
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 56 +++++++++++++++++++++++-
>>>   1 file changed, 55 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index a902950cc060..53a814347522 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -35,6 +35,7 @@
>>>   #include <linux/pm_runtime.h>
>>>   #include "amdgpu_amdkfd.h"
>>>   #include "amdgpu.h"
>>> +#include "amdgpu_reset.h"
>>>     struct mm_struct;
>>>   @@ -1972,8 +1973,14 @@ static void evict_process_worker(struct work_struct *work)
>>>               kfd_process_restore_queues(p);
>>>             pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
>>> -    } else
>>> +    } else if (ret == -ETIMEDOUT || ret == -ETIME) {
>>> +        /* If CP hangs, signal the eviction fence, then restore_bo_worker
>>> +         * can finish to up_read GPU reset semaphore to start GPU reset.
>>> +         */
>>> +        signal_eviction_fence(p);
>>> +    } else {
>>>           pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
>>> +    }
>>>   }
>>>     static int restore_process_helper(struct kfd_process *p)
>>> @@ -1997,6 +2004,45 @@ static int restore_process_helper(struct kfd_process *p)
>>>       return ret;
>>>   }
>>>   +/*
>>> + * kfd_hold_devices_reset_semaphore
>>> + *
>>> + * return:
>>> + *   true : hold reset domain semaphore to prevent device reset
>>> + *   false: one of the device is resetting or already reset
>>> + *
>>> + */
>>> +static bool kfd_hold_devices_reset_semaphore(struct kfd_process *p)
>>
>> I find the function naming of these functions (hold/unhold) a bit weird. I'd suggest kfd_process_trylock_reset_sems/kfd_process_unlock_reset_sems.
> ok
>>
>>
>>> +{
>>> +    struct amdgpu_device *adev;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < p->n_pdds; i++) {
>>> +        adev = p->pdds[i]->dev->adev;
>>> +        if (!down_read_trylock(&adev->reset_domain->sem))
>>> +            goto out_upread;
>>> +    }
>>> +    return true;
>>> +
>>> +out_upread:
>>> +    while (i--) {
>>> +        adev = p->pdds[i]->dev->adev;
>>> +        up_read(&adev->reset_domain->sem);
>>> +    }
>>> +    return false;
>>> +}
>>> +
>>> +static void kfd_unhold_devices_reset_semaphore(struct kfd_process *p)
>>> +{
>>> +    struct amdgpu_device *adev;
>>> +    int i;
>>> +
>>> +    for (i = 0; i < p->n_pdds; i++) {
>>> +        adev = p->pdds[i]->dev->adev;
>>> +        up_read(&adev->reset_domain->sem);
>>> +    }
>>> +}
>>> +
>>>   static void restore_process_worker(struct work_struct *work)
>>>   {
>>>       struct delayed_work *dwork;
>>> @@ -2009,6 +2055,12 @@ static void restore_process_worker(struct work_struct *work)
>>>        * lifetime of this thread, kfd_process p will be valid
>>>        */
>>>       p = container_of(dwork, struct kfd_process, restore_work);
>>> +
>>> +    if (!kfd_hold_devices_reset_semaphore(p)) {
>>> +        pr_debug("GPU resetting, restore bo and queue skipped\n");
>>
>> Should we reschedule the restore worker to make sure it runs again after the reset is done?
> 
> After GPU mode1 reset, user processes already aborted, it is meaningless to reschedule restore worker to update GPU mapping.

OK. With the fixed function names, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> 
> Regards,
> 
> Philip
> 
>>
>> Thanks,
>>   Felix
>>
>>
>>> +        return;
>>> +    }
>>> +
>>>       pr_debug("Started restoring pasid 0x%x\n", p->pasid);
>>>         /* Setting last_restore_timestamp before successful restoration.
>>> @@ -2031,6 +2083,8 @@ static void restore_process_worker(struct work_struct *work)
>>>                        msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>>>               kfd_process_restore_queues(p);
>>>       }
>>> +
>>> +    kfd_unhold_devices_reset_semaphore(p);
>>>   }
>>>     void kfd_suspend_all_processes(void)
