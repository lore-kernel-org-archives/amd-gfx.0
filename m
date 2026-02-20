Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3F9C55ABE
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 13:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFCD10E159;
	Fri, 20 Feb 2026 13:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xxKbl7w3";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF98A10E159
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 13:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNY/KqErdS7iS7pVb63sjDYZ4cOqbHKBqVvqCbDPqrSV7UfU0hsi0zTAW7I6gk4vrxNVcDVVIrC2TQBTtq2ktnMdvlbwvQzc9r0GHiSU6D3Qev/dfEvAFoWJFogbHpGZt1Wh6OrjsZgA9MkWri3H9i6fw9vcVuY1enOebuxGdLHwJNRJRiscMD606LIhNR3iUVy2U03gcfKp9/DHFFmf6HC/ciYw4+A0yllX415l0fQZKxDMIL/t/iy5DsQfOXI3/3+4BdK5S1hmFqcwJxXIGZKn9mPk7kFibdtv8GVvGo4ceb6fegAxgN2v9rxX3cU8cWAMEQM28RAuzkE3NmHMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUq8af3obpnFf2bF1qSkfSNiGQ43jYB4hmzcAcXJ9V4=;
 b=jQ2/fDX7MddLA5an2985RodmnWxia2dmwPVjHy/yecKLv07+DvmYpAR2iybC6Gi1jGg0Xg5KkgCrZsg2ixmHaH6dvXLJ/6gG+MQ656zfMlzmf5HkfPSuAorDfE7L/HWMkJqFnh0buYqA5Zcu1Xv3C43OzXPat6MSM9/4J9a0uJ+ro6LlL98Y2i7k2mxV0313pMLuoYAnEN7YRtHfk/uoJwN0lKw2Vlpc/DuUG5VfzSBNd3jetff+1IeZ6bgN5KcYfJmhJIGidC26U5XQxxBHN03QtNlTlZGvWV3Fc2Qs8rMHbJfxk2i2ReXiQwDjHCP2+U4DpscDU+afF2YOSdL2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUq8af3obpnFf2bF1qSkfSNiGQ43jYB4hmzcAcXJ9V4=;
 b=xxKbl7w3yB1HDZKdxpMm8TJmvvXEbYA+CBa6rHzrX0+BsZdjpcWwWUkY9rcuuktC1b+eeYQrpI9h96BywcG+Y33hdRJ7i6AOwWFI42kJLFhRxDhhHOpANYyYm4oH/AYpM6LUtsFxkrTbKsWuzBjh9cYu88aMIqKtSREMTATmiXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 13:19:26 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 13:19:26 +0000
Message-ID: <4a824f5e-5279-4cb7-b6a9-fb4c6f87cd91@amd.com>
Date: Fri, 20 Feb 2026 18:49:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
To: Tvrtko Ursulin <tursulin@ursulin.net>, Sunil Khatri
 <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::20) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdd9756-31a8-4b35-6949-08de7082ab4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGwxaCtMMWVwMFJCUkQwYXkwQ3FTNElrVTA4L0NiVEc0VlBwNTQ3VDluV1JZ?=
 =?utf-8?B?TnlQRkFVVjZYVkNmUHdBZzZDeG5WOWVqM3lDL2JSNDNoUU40MVpjUjF0Sk1D?=
 =?utf-8?B?RTkraEYrOSs5T2VmRXAzYisycVpRYTgvOVhYZnFGY08xeXl1VmJSeWhLVUpV?=
 =?utf-8?B?cEh5b3dtVzdwdmcvcE9BK2ZJbEJhaFJBbmN1MHd2ZC9DNHdSMHV0NHFqOXRB?=
 =?utf-8?B?V2pTamdaZExRZzdBNlVrVEVDNGErY3drUFNIbVVXYWZ6VGtkUWhkV1NIWnAw?=
 =?utf-8?B?NUJtRmMyaFozOTNEN3RLMHpCeFhjaGVUMjh2VDN6U1RtWkxiYW1FVFJ4UnZ5?=
 =?utf-8?B?QWR6WDZaeVZjMS9WVUNTSURFa1FlQlQ1NTd2em9YK2U2d2JvM0NEamFRZ3VH?=
 =?utf-8?B?N1oxcXV0WFcxRlk0czBQR2FKY3BrZE1UNmtjZXFTRkVia0xnbXRWSEM5V2dl?=
 =?utf-8?B?VzR4Zkl1SlNYSGdraVZ3SUJuTlMxcEdVMkVlU1VIUWI4Uk5PSjdvVVQxWVlo?=
 =?utf-8?B?YzZ1SG9JZzR6TDFVN3hqcE5oZmp6TFd1c2tXT0lOSDZzWkk1UWtzRGxKaHFy?=
 =?utf-8?B?Y1gxTHRiS2NqKzlDZHkzbnl6YS94RHpld2N2OVhRQnByQkVxSHU4aktDUXY1?=
 =?utf-8?B?RDhIcDI5dHJ1NDM4K3ZBVE5tcjVaR1BPWmxITEIyUlJWVTliU1RoK0VDNFVp?=
 =?utf-8?B?K2k1Zms2T3ZJTU9MVmVvSjMydDQwKzNwMlVYNHE0N3VoQXJSendFc3VOK2xC?=
 =?utf-8?B?dFBZcEVlR3k3d0xTWHRDV1JFSzhFck9TcnRaOFlpQVFkaUlxZ2ZoYzYzbkpa?=
 =?utf-8?B?amJrSWlacVZJTWdWNjBVU3F2TnI4dHV4MjRNMW1BRjBDR2xKaDNzNWJkd1Fn?=
 =?utf-8?B?eGxjTGVBbmVvRnVIcFhoaXllT3RXZnJ0Z2YxZElqenlaVVhhMWQzVnZBNXZY?=
 =?utf-8?B?dWFGbjRMcTJIRkhSYm52TktRWU9PNVI2UjVyQjZJMWhTbzB6bGtQQWtmS2xw?=
 =?utf-8?B?QUIyZmt3aHRUdGJUOXNieldRNW9ZSlIvajJFemJ6dEk5NVdQMTFIYlE5eXpn?=
 =?utf-8?B?UnpONGZZc0hYWmVza3hqNEJCanVyVWZiWWVBU2tKbk1DR1JqU1NPNktKYVNK?=
 =?utf-8?B?RXV6V2VaVUZWSEJidlFoWWNoS0R6M0Y2MmR3aFFrdmk3MDZPSEN0Mzk0bFpU?=
 =?utf-8?B?VEJLOERlcmNvUDBmakFyRUpFNEFtOFZXakVNT3Q2WlN5RzM1WDNZNUlvSDQv?=
 =?utf-8?B?L1ZheDNGNFdDT1poSjc1ZnFkZDZJS0dKb3RXdktOQTdDaDYzaVRyQVcxdGV0?=
 =?utf-8?B?MlpkOU9peklxT3YrNklmUjEvUWY3S3hEaHh1dFhtc0IyR3pOQisycUdXNnRh?=
 =?utf-8?B?NjRVdVpkWWtKMVBSU0JnR2cvMWl5dFVIVnlzbmlRa0RtOGI1bks4SkJUR3NF?=
 =?utf-8?B?cWtUbXVMSUEzTXlKS2RrZUowU2QwZ2V6d2U2R1pFSzdrNEFkTENWTHVPUndi?=
 =?utf-8?B?MTFPYlU3amFaZlNTTEhpRXM1djhNcEIwUHBzSVM1VGZaRUpwcXBJaXljVDlt?=
 =?utf-8?B?aFByeWxkWXlwaXlWNU1sTXEvWE55VnN6bWFmMnVOVG55T3RIOU9VbUw5RE5q?=
 =?utf-8?B?Rm1ZS1ZzbnhyalN4bDVlWFlWSXkvYWsxd0sreDN6SDBIazQxVUtuM2pwWXho?=
 =?utf-8?B?NTNZV2JUOXhreGM5ZVJTamRNenJpcDNtaVRFOVdRbEoxakh4TE1HZkd3cDBr?=
 =?utf-8?B?UTFsMzk1aFkrYXUzMC9KT3BtQlJHcTJuNkRINkllRXBBbzhOYVlsTis2UDhn?=
 =?utf-8?B?RVJUdWNPU2c1MG5wWmI2WWdUVDN1MjJ0b2tGRTRQNjhEblAvT3NEdk1IR0dK?=
 =?utf-8?B?bFljNnVyNUoxM2poUTdaUzd5ZGxRdWJ0T0V1Z3B0bVRlc0xLbjNwaWJUeUE2?=
 =?utf-8?B?Y2k2d0QyWlZaeG4wVzEreWxtMTNUNUVvM0ZsU0I1YVVrRmVNZEZBTG9zQjVJ?=
 =?utf-8?B?MU5RS2U5NnBYMHhHOFRnK1BPM21Nb2Y2K2UvNkpidzFsR0ZJSTM3citoQ3JE?=
 =?utf-8?B?Z3RnaE5IaSs5U3Bwem5ScHlBMXpMMTkvRnBjTmJUbWxlYjd4VkNyMlFUU0tX?=
 =?utf-8?Q?qnLCzabkmY37ZtSdKGt7E8fIx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVFxWklCWVJKWnR0ZzJUZmJPSW96cnRjQUZoYkRzRy9qaTVEK1ErTVpTZXFC?=
 =?utf-8?B?cmxCTXVBeUJrQ3haOFEyTVpYK2w2endBUmxIemswTTRUUXV2bzJFNllvRHBv?=
 =?utf-8?B?emc1NWl1Ujd2MFdIaE9OMEJKYi9HNEo5QjNiT0Nnc3U0ZVlGQ1JPekZNeDZG?=
 =?utf-8?B?T1RDaXJOU0I4MnVHcHBPZGt3aXZSQWtiUXlBbHE1aDJkQXNJV0ZrSVFGT1FD?=
 =?utf-8?B?ZGlwNDA1WHRJQU5teWQ4aURnbW9QdTVLWk1RNnV0a3NZYk5HSjJnU3h2UENh?=
 =?utf-8?B?TGxYdk92U3NQMGlQL1UwS1pTL2xWL0s4M1FDRDY2UkhYUWxzd3B3blIrZFdx?=
 =?utf-8?B?bHpFZTlmSzF5K2h1M0JMZzRHR2orQS9Za2FRd3JIaVFEd3dnejR0eVAvUDlS?=
 =?utf-8?B?Ymtad20wNTA3cHhVd1NPNnRtSFhTaEVLby9ud1ZnQW1ZcDB4ZXlXYm5sWHZI?=
 =?utf-8?B?OUtEckR1bHFQdVdHTFAyRGJWSnZuUDlEbjJEY0YxZ3haSGxlSkc1VkovSm1u?=
 =?utf-8?B?Q3pGQmRYQklXbER3d2MxMUl0MFB5U2RQNVlUUXRDeWN0Yk1wRmRwRjdPb3hL?=
 =?utf-8?B?djJHRkV2WVlhN3hFZ0RZanE2WnpUMXA0bEpOZnVGOVhHUW5sTkE3eWV1ZUhK?=
 =?utf-8?B?VVR3OTlZNEdPOTd1Zi84eERBa1NuZkFaM0RqVHZueU5lUldKMjU4STYyNTk5?=
 =?utf-8?B?S1BuTmo0VEpkR3JLcElOVVBPS0ZoZjNiMFVJeDNURGlJWDVQakdoNGwzT2Rk?=
 =?utf-8?B?ZnNWT1Z0QmRnUmQ2ZngvTXZpL0xDV3lNZ28rNUVQUjBLeW91djNpNGpYU2k1?=
 =?utf-8?B?OXJpbUtOSzdzckk5S3FZOUVVOFc1Tm5vZ2UxUG1rOXdMaGtKa0VBOU5tbUlO?=
 =?utf-8?B?c0ovaUg1ODFONSs0N1poL1Z4cWlDT1hZd3lkY3lwaXZSQkdPYnhWdnVLV2ky?=
 =?utf-8?B?VXRNNTZtMkZidTZHcHZZcmc0NWdnUEdXSXFMU3krUy81ekNCenVDMDVnVVhF?=
 =?utf-8?B?N3pBNHVvQVU4TDhHVE81L1NvZDUvUU04R0cxN0hiVTIraDR0UmRkc0ZjalBo?=
 =?utf-8?B?R2V2c01nL0srbGUrSGVjMXRvZllRa3hIakVLWlcvYnV3aUN5cEhBZndlSlZY?=
 =?utf-8?B?U3AyOHZCb2F1VUdmMy9LMitXUDZpTHNUcUZMczhKbEkweVVzSFo3SkN2WUxm?=
 =?utf-8?B?MlVMRXFBRmJNODQrZW1OWWtGaDYvT2NuSXdnVERlOGlheGkrYm84S0UvK1Zv?=
 =?utf-8?B?UXV5M3RvWVp2K0hKYlcyMVlYQ3lsUnNIeERkeVhSdklONjUzbFpOTmQ2OGhY?=
 =?utf-8?B?MFduWEVOSnVHNXJ4Yk5JdlNYOGdEeHAwQ3MvNEt2QzljN3dqS2FXZi9IZjRv?=
 =?utf-8?B?RXlQYU1McU5tTjJVZlIxK3lJOGtCblhiMEtPQkRqTjBKRlcrZnZ6Tmt6eFEr?=
 =?utf-8?B?Tm5NZVd0bjZPdTNVT1JsRk0wVGF4V0xWWjM1cnFET2xTYTROSXhYcFlzVTdN?=
 =?utf-8?B?SlhvOWkxL0xJQ2N3THdrZHRTSUpNYWYzNEhEM29PaWpaNWk1dEliVnF6T2tl?=
 =?utf-8?B?aTc3RlVidEZQdHlnOVlHMVFwVUZsZUR5Z0Yvc3Q2aXB0U1ZGaG1TcFBsMnMw?=
 =?utf-8?B?d2p5Q2xjcW5OaUM2V01zS3ZZRXk0VG93WU5oWDlmMHcwYW9BWEtMNXNvaWEx?=
 =?utf-8?B?TW9VL00zS1FkWTV5TzdVZ29MeFhWUGwyOXBHRWpVVGlBWnBrU3N2VzZ5a3hQ?=
 =?utf-8?B?S1lwZHB1QVBGOFdIMXZqT2RpYUZKSlAzaFoxdGQyUUYxQ3hRbWFNRFFaUEw4?=
 =?utf-8?B?Vkw3Q3lVczJoUjRZVXBCQWxxTnR6TnFoQ0FHNndnSTE4Mmh3TnpNTEtsemxh?=
 =?utf-8?B?RGpSdWN0OTFGYjBZbGVLZEJ4VDd1QjhjUTBCRU9pVzN4U1o5Vm5EWUszMzV2?=
 =?utf-8?B?R2tyanBoRWhqUTg4RUVnVDZad3VXcG1QMVVMbHE4SkROS3k0WURiWUc5UzN2?=
 =?utf-8?B?ZTF2MXV2L0hrN2pjNGkyQS9IanJWM1pJWUhiS0JnaVRnUUd6Z1BBVThVcWNM?=
 =?utf-8?B?WGxKcDh0LzJoNEl4bDBtRXZjank4a3ZXcHRXU041VE1sVUdFZzVXT3I2QlY1?=
 =?utf-8?B?cmxQYk84eCtleFl6TjBsaEkwNFZmaFhDbHRYbmtqQ0FGL2lYSmd1Z1VKYlJI?=
 =?utf-8?B?aDVzWDA1NXgxUXVGSVgxd0phdWRYRXp6QVh3eFpuQ2tmMHdrL3doSlBDTHFs?=
 =?utf-8?B?Qm5Jc3p3N04xMTQ4bUd1Zm56WitOVmp5QWluYXQrYW05ZXF6S0tlb0Z2KzI2?=
 =?utf-8?B?MFN4YzhZd3NYOVJHc0hwamdOL1BpdVp5RzAzT0VwWWJGYXhFS2dOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdd9756-31a8-4b35-6949-08de7082ab4b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 13:19:25.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nx5xtB32RQTMsWvtu9HqMtcnaaVZF8/kLrS1FS+XnXiwAUQB3DAYJ+El+7yjeK+GewmGo9Q0z3CUUCmudEYNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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


On 20-02-2026 04:54 pm, Tvrtko Ursulin wrote:
>
> On 20/02/2026 08:28, Sunil Khatri wrote:
>> memdup_user could return invalid memory allocation if
>> there is an integer overflow. Using memdup_array_user
>> make sure we validate the size requirements upfront
>> and return with an error.
>
> FYI:
>
> https://lore.kernel.org/amd-gfx/20251205134035.91551-1-tvrtko.ursulin@igalia.com/ 
>
Are you awaiting for anything to merge the changes Tvrtko or they are 
merged in drm upstream already? Since issue is reported now so we need 
to fix this.

>
> And later:
>
> https://lore.kernel.org/amd-gfx/20260202125149.2067-7-christian.koenig@amd.com/. 
>
Yeah i am aware of these Christian changes and we decided we will fix 
the issues first and reorganize the code later as needed along with 
Christian changes. So we are going to push the changes

on the existing code base first.

regards
Sunil khatri

>
> Regards,
>
> Tvrtko
>
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 +++++++++----------
>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 212056d4ddf0..a6eb703b62c4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>> *dev, void *data,
>>           return -ENOTSUPP;
>>         num_syncobj_handles = args->num_syncobj_handles;
>> -    syncobj_handles = 
>> memdup_user(u64_to_user_ptr(args->syncobj_handles),
>> -                      size_mul(sizeof(u32), num_syncobj_handles));
>> +    syncobj_handles = 
>> memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>> +                        num_syncobj_handles, sizeof(u32));
>>       if (IS_ERR(syncobj_handles))
>>           return PTR_ERR(syncobj_handles);
>>   @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>> *dev, void *data,
>>       }
>>         num_read_bo_handles = args->num_bo_read_handles;
>> -    bo_handles_read = 
>> memdup_user(u64_to_user_ptr(args->bo_read_handles),
>> -                      sizeof(u32) * num_read_bo_handles);
>> +    bo_handles_read = 
>> memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
>> +                        num_read_bo_handles, sizeof(u32));
>>       if (IS_ERR(bo_handles_read)) {
>>           r = PTR_ERR(bo_handles_read);
>>           goto free_syncobj;
>> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>> *dev, void *data,
>>       }
>>         num_write_bo_handles = args->num_bo_write_handles;
>> -    bo_handles_write = 
>> memdup_user(u64_to_user_ptr(args->bo_write_handles),
>> -                       sizeof(u32) * num_write_bo_handles);
>> +    bo_handles_write = 
>> memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
>> +                         num_write_bo_handles, sizeof(u32));
>>       if (IS_ERR(bo_handles_write)) {
>>           r = PTR_ERR(bo_handles_write);
>>           goto put_gobj_read;
>> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>           return -ENOTSUPP;
>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>> -    bo_handles_read = 
>> memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>> +    bo_handles_read = 
>> memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
>> +                        num_read_bo_handles, sizeof(u32));
>>       if (IS_ERR(bo_handles_read))
>>           return PTR_ERR(bo_handles_read);
>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>> -    bo_handles_write = 
>> memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>> +    bo_handles_write = 
>> memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
>> +                         num_write_bo_handles, sizeof(u32));
>>       if (IS_ERR(bo_handles_write)) {
>>           r = PTR_ERR(bo_handles_write);
>>           goto free_bo_handles_read;
>>       }
>>         num_syncobj = wait_info->num_syncobj_handles;
>> -    syncobj_handles = 
>> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
>> -                      size_mul(sizeof(u32), num_syncobj));
>> +    syncobj_handles = 
>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>> +                        num_syncobj, sizeof(u32));
>>       if (IS_ERR(syncobj_handles)) {
>>           r = PTR_ERR(syncobj_handles);
>>           goto free_bo_handles_write;
>>       }
>>         num_points = wait_info->num_syncobj_timeline_handles;
>> -    timeline_handles = 
>> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>> -                       sizeof(u32) * num_points);
>> +    timeline_handles = 
>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>> +                         num_points, sizeof(u32));
>>       if (IS_ERR(timeline_handles)) {
>>           r = PTR_ERR(timeline_handles);
>>           goto free_syncobj_handles;
>>       }
>>   -    timeline_points = 
>> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>> -                      sizeof(u32) * num_points);
>> +    timeline_points = 
>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
>> +                        num_points, sizeof(u32));
>>       if (IS_ERR(timeline_points)) {
>>           r = PTR_ERR(timeline_points);
>>           goto free_timeline_handles;
>
