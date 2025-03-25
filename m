Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FAAC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 08:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E7E10E067;
	Tue, 25 Mar 2025 08:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OhoAaxDX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F2E10E067
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 08:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMwo8jZomhGYwP4xFu+6BsMEpytPHRjC+AAZ82N9wzviODrMgp/hW13xSRXowDu6veOmpL4HCu/aztNM6eeZUrNVqXUIA4//ju3qXWwCvcWGeLSlaVqixnIz1rGRTVwF7BeVnDPlHFoO9MSJJoIOGa53wL7iujdFhLOZ+CW5wtpBAOjbFuetSzez7y4jWkOojyhc/P0gd1hYyg9S+HaChE0OtH143Vwr7CU9UGAfg3wfepfawJ9HOMRejtsTA3Y1J9gsnPJ6jCrRU0+0EZ6s9Y8FYIUEjuuxtI25ksNoTFjwJewoxqAY/bpLm8kgXr1Bt047Kqz0z9c1Byz/Qg+JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F37IeUR7LoEDs7hvjxnU3E3WCJBqiw5wNWxBgHjGIDQ=;
 b=GMLGaw+YmEvFmZ+L5RX3gZqiBWghReqU3FpWX7eMJNGlgngYW/ox7hyNaUJ7eyUOVLVzFBDRbH+EI4Wry52U0hvyk63OoUFen+/68RK+pIO480JbfxIqDgQeb1oj7MgLBeI93qaClpiGBznJkKuvOhndrBUVgsr2JErehsbrWu69TpciI65GIQOJ6b+I9ZvdT0wB7v7JCiHu/3HXPvI9fjanrk6HeyRZlyPXNkvalOhAsBlgFCUm+6Gt9JxGAzyPPZk2ryOnZR83qguNAVfylXl5U0wExdfNyKgyqp7AhQnSfY6z15iU09TJNhQim/rqS+W5duEJDGkbs5qXMCLDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F37IeUR7LoEDs7hvjxnU3E3WCJBqiw5wNWxBgHjGIDQ=;
 b=OhoAaxDXdolgQomMgFPaWHDIdsvyzG8a1TvZCPj0vQKIyaaAA7GkJJKr2uKc6F5qibNrXc3dFvj0u3Cl3ISZJOXDVMAuqOi5d74v4Mo+jph3H6ccEF9mfcAN1dGXaLEkfZlITxha2px+tQclXyozdPPJ3AzcKmWWC9z6eM2yehM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:37:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Tue, 25 Mar 2025
 08:37:01 +0000
Content-Type: multipart/alternative;
 boundary="------------1N1PHiFk0x3O0bSB0dX9wKHs"
Message-ID: <634e77d7-4f3c-4d1a-8aa3-1978896f9bf2@amd.com>
Date: Tue, 25 Mar 2025 09:36:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Balbir Singh <balbirs@nvidia.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250324230712.4122-1-spasswolf@web.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250324230712.4122-1-spasswolf@web.de>
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ceebdf-145f-4334-9088-08dd6b783697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STNtRHVoSE1Cd3dneG5lMWIwNE95dytIVDUrZStOM1lVNTRkekx1RjJQSHky?=
 =?utf-8?B?emJsS0FrYVE0cU5ScHNIRzZDdUN5NUwxbnpBc29rU3Blc1UvNXI1VlZ0a2pr?=
 =?utf-8?B?OFhpYW54STV4eGYzNjltenRvejE0K1RXVnRiRDYySlE3dHZTZU40ZzRoMEN2?=
 =?utf-8?B?SkVHSFJhK2xzeHdRcVJuN0dOdzRjNjJGWjBHeVBQbWpCRTh3Tyt6L2Rrc3Jz?=
 =?utf-8?B?WjlyOXR5WDV5NzlwNEpZT0V6c1J1ZkRHQWU5QU9RK3dlMWZiYkJmYmtlS3ND?=
 =?utf-8?B?UWVnSE05LzVqMUVmOEIya2I3R1FJa0syd2hHdUZ4M0I5N3ZxM0svbW9LcWs0?=
 =?utf-8?B?ZU5ib1hJOUM2czhoZ0ZCaXNTZGxVdkJqdThyQkhrdWZxdkFnNUJ3bzAvQm5L?=
 =?utf-8?B?UGZGakVQemJWUDg1VDBDVndGa0dEUGl5K2NCbWQvd3J2Uk5xY254MWFVaktL?=
 =?utf-8?B?MDNqOHNTUitncGsxRllPVXBWL0VUVDhlRnd6UjRUbUVVbW04TkxnZkVwaGpx?=
 =?utf-8?B?YzJuT2dsUFJ1M1lmV0tSWGJTWmRxY2hUbXBCSEtRUkhxY2tNcDNaYkg3RTg1?=
 =?utf-8?B?MlpnenJ1VHNIbVRieVNIeFlNcSt4bnJkR3ZEbGZoUGNwUThGYlEwTGxaOTNK?=
 =?utf-8?B?RWdEZlZHUVB3OThKdk5DWGkxejBNUlVzUERTQWZkWktKYTJkcUpTU0lxVWpm?=
 =?utf-8?B?OUREZHBudzFQUkNhTjRoMmlsQXJwckxWUDhFQTRScGNGSjltTEZocEo1Mm44?=
 =?utf-8?B?Q3k0TCtqM1RoRWF1aTNSVWZVUWJ2WFkzQ3ZOV0dWRUc3UTFOYzlreU9oVlNa?=
 =?utf-8?B?RzRYdDhwUUpOVDI3MnRCUi9pcEtzUys5YVhLYkZWTGMzd3ZyQ3hSazZQMGRG?=
 =?utf-8?B?c1ZIMTd3OEUxcVc0d21ya0NTN0poQUZrMnJUa3B1a0gra3VsT0liWnF0dVpC?=
 =?utf-8?B?dWZ2ZFpMTUl4RUVVb1o3YmFyek8zbGZ2eFRXT3BFdHlKWHBWT0dlR0U5dEtn?=
 =?utf-8?B?MGs1NWFxa1ZHZ081WnpzYXJHbWh4TXpzckhudnBNemhLOWpQQ0gzOTBCY0lB?=
 =?utf-8?B?bStrempBZWhpbGI2OG83dy8wNVJScFFEQWt5Q3lLVG5icWFSbDcwdzJKRHAy?=
 =?utf-8?B?cEJUc1V2QURjazloSW51WTF3MEs5c2JFUjRtbUEzRzdPQS9ROGJrdDVseEpI?=
 =?utf-8?B?OWlGS0Jmd085dXNtWmsybmUzMlpGRTgrUUMwQnNBN3FrM3hxWWRYTkNMSnhw?=
 =?utf-8?B?NFVNNmJRVjg0Ty8rRW4zQThOdm9Bcks5YzkvcEJUMDVKSG54K1lNUTdJdFRC?=
 =?utf-8?B?YWwvVjRmblNiaWNQNHRLQWo4dHV6VzJQNElVK2piRmZCL3p5UEEraitheCtP?=
 =?utf-8?B?MmQyQ2pqb3hVcE13YitabUVGd2NmRml6MGxnWjhPd2cwRGtmUXhYNktBaXM4?=
 =?utf-8?B?Z05kam12bUMzU1hQa2o5Qlc5bjU4UWdERW5JeDRCeWNxUXlDMDJLZWJGeWU4?=
 =?utf-8?B?Y3dtUVhjRk9LU0h4aXljeXFqL0FCMTNNVkUza3NtN3MrSHdwSjV4clplckh6?=
 =?utf-8?B?dnZLRkFEKzVEd3VKbEpjQ3BCT1JTMW9TWk9VYUpFNlBHVWRtTUZPVVNmR3Bj?=
 =?utf-8?B?VHdUN1RYSUZvNFJnczdieVpYbXYxK0dPaXdNZmFEcEFIdnBoWW0wQmhBS3ZK?=
 =?utf-8?B?MW9scVhlN2xEenFjL2plaUhCY2tjQm4xb3dXS0dQWlBZOThpQUFnMUErUitN?=
 =?utf-8?B?SHp2d05vMUE3YUdhYXRYN2srZWt6T1pHTTE2bjg5alBDdFI2NEVnUm5ZSHp5?=
 =?utf-8?B?dXFjaC91QkVUWFh6c3dTMHRJbFVmQVNsbENYZmFSSmpOWFJYZEtSWk1haDlY?=
 =?utf-8?Q?RMApItAB6fmfi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDNrSjNrcTN0cFlRczlVa2wyR3lMQngzYnZlMVZUNE9yYUVaTHhVcWZLRjVV?=
 =?utf-8?B?UnNENE1scUFWVmE0R01HamJnUlZ0b0NZZm5wdmIxa21BZ2FtS1JjWFhpZlA1?=
 =?utf-8?B?b0k5TmZWWWhZRHNJeVlRRjFVM29HRXB2RU1uU3dmYnNhOEJ6OFR6NWxqNEhS?=
 =?utf-8?B?WUpMMzh2OTJyeWtFRFdTNEkzVjNhM1lYU0RRd2NwODBqMzJlZGFiRkNiM0Ft?=
 =?utf-8?B?YTFXUDZvQ3NKUHpkd0pNdG1QUkhNUnRWcDAzQWlFQ2Qyc3BhRnp5WUlJRm0r?=
 =?utf-8?B?M0NEMm9RdExUNjJOL1VYVlNRTm9GQjFxb0FhSXNJYlRBQittSThpRkx5M0pw?=
 =?utf-8?B?R0Q4NXhkRHRLUWFVLytxZ1huQUhaMDF1cVBjaklSQ2pHT2dTVVVoWVBlbTQ0?=
 =?utf-8?B?OUxFNkppd2F1Q2cxcjh6MEdMaXg1T0hBdFFJejBKOGROc3VtdkhlOFlOSkRa?=
 =?utf-8?B?ZWs5Uzh4cWt5cWFKQVNLc3p1SlpoTkdMZWowRFRBMDFEeVlCRVk0ZnoyT2R2?=
 =?utf-8?B?M2hpSnNieVRQSGhxYllBcGVWbnozNVp6Qmtna2RXSTRhTVdNN2FKZWVSajRm?=
 =?utf-8?B?bjVnNDNwVjZ4a3FPNmVPYVMrU2lRd3lodGd3YzU5cVhOcHBSU2EwWHA0ZE92?=
 =?utf-8?B?L0hCQlFXbm1yNlJsOVBSS1BlZDdSSkh1dkw2MmNyYWZHWnNDdFhHSW4yWUZt?=
 =?utf-8?B?Zlc0ekQ4bFdEbTFhU1paRG5uRzRxZmpKaS85cEljM2RSSC8ya0pXdGdjYldH?=
 =?utf-8?B?L2I0OGFvVXNPYkxPQlhyRVVKeUEyYXIwbE9EbFcyemZtUHVqS0doWG5iTWVz?=
 =?utf-8?B?UkZuQi9VYTVCb2c0a0pERlhjVWh5NTFFRUI2QWNYSURWZkRiSERnTjFrdDVR?=
 =?utf-8?B?cDh5bGpLWFM1RGM0eXpYTVUzZ2VHeFNyOGFUcXUvT254SGU4U1p1VHUyYXNw?=
 =?utf-8?B?MkVjQ3gwekNZVFRnbU94ZUFML1liR05uMWRya01qUDRqcm1Qa1g4cVh4M3ht?=
 =?utf-8?B?MGR6M1dTZ2h5RCtMaVZjcGJiTVl0ZHlvaGVnckpDc2MvaG9ZajZaQ0FUTUlW?=
 =?utf-8?B?enV2WFdmR2VzV1Zxc1FhSnhscU93TVBXdit1UEoxNmE3Skt2N1VHNGJtTjNI?=
 =?utf-8?B?L3hINEV3a2tNcmlKQlcyREF2RHgzOVo4S1llT1dnOVdrUVZybllPbHRkTTVX?=
 =?utf-8?B?cVdVMnIvYTJtOEdKeEozSDJmSENVd2ZDbEpYNGhLUHBjTjNYb2pwSVlyTkVL?=
 =?utf-8?B?eGY2ZDdPNnl5UGZQendxd2VMSm82RHUzZ3RTdXUraUI3Tk9veEcwdWd4Qndm?=
 =?utf-8?B?RkdCQlVSZDRkNklxN3pFcC9Nb2ZyY0F5WDIrTTlJelpuY2Z6NGF5eGZYcjVq?=
 =?utf-8?B?YmF6S0orb1Y4dFBLTGhKWjQ0UXprdHJ2TlBHeHphTjE5alJsTHBMa24zMXUx?=
 =?utf-8?B?S01PY3k5QTFBRkM5bk9EdFJPMnllenE0Zi9LKzBNRDEvMDUzMDlqMnFzNlhh?=
 =?utf-8?B?TFBmVkUwOXUrNHJTUys0di9iZVQrbjhyQWtqQks3UnNidXIxRUwybm1TVXZY?=
 =?utf-8?B?TVcxUkFteVNUTjMrdzVYb29qSlZtSWxqSVhZdkozQzFYYWdWVisvbExxRXpj?=
 =?utf-8?B?THlHdW8xNll2TWJKVXBsSnVETHlDL2tkeVZIRlZSU2pNMldNM3IzdmZnYUNY?=
 =?utf-8?B?QkFKa2ZBclh0V2xWekVLQjhJNE04OUc3YkUwM1hub2JvT1hvNWx2QTBhVDlj?=
 =?utf-8?B?QlRCNXRzTDNndGRwLzlPQ1luanZrd3BnTUFQNXcybS9raHY1NUtKREQ1cDlo?=
 =?utf-8?B?TFRlRWlSdVJGM1lNQ1dSLzZyaktRRmxxNkI1UXVkMGlhZVNkUC9QUG1sdjE2?=
 =?utf-8?B?aWw2anVLRGN3L0hrRExucUZoWEhtSXJ0Y0Q2Y1NHSUZnMlpDSVFRMExlWFpu?=
 =?utf-8?B?TnMza1NubGdGMHFkTHNBU1BROTJiNEgzczlkck1zT2Q0by9UYnlITE9MTGJr?=
 =?utf-8?B?Y2IzY25MTDFlTnVtLzZyd0Y4SStpcGZhMTN0WlVONlRHMXVJRlFxbTEzK29n?=
 =?utf-8?B?MGRyM042enFQOXZWRy9tUjMwZlN3K3FZQTZwSWdxMjk4RHdja3dEenFWbWxN?=
 =?utf-8?Q?PaIBYmBE7qKDuvnRhYHeNt1Wb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ceebdf-145f-4334-9088-08dd6b783697
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:37:01.5422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYfenJHkBIviS47UhZjAWt6m09G2we7jjpq6di2iwRXtuatJ8LGS5PeONvN9Skdq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739
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

--------------1N1PHiFk0x3O0bSB0dX9wKHs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 25.03.25 um 00:07 schrieb Bert Karwatzki:
> Here's the dmesg from linux-next-6.14-rc7-next20250321 (CONFIG_PCI_P2PDMA not set)
> The memory ranges of (afe00000000-affffffffff) or (3ffe00000000-3fffffffffff) are
> mentioned in neither of them.

Ugh, next time either in two mails or as attachment please. I had to separate the logs manually again.

The BIOS programs multiple root PCIe resources:
[    0.310962] [      T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    0.310963] [      T1] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfcffffff window]
[    0.310965] [      T1] pci_bus 0000:00: root bus resource [mem 0x1010000000-0xffffffffff window]

But by default all BARs end up in the 0xf0000000-0xfcffffff window and are so accessible to the iGPU.

So I don't see a reason why dma_addressing_limited() should return true.

Regards,
Christian.
--------------1N1PHiFk0x3O0bSB0dX9wKHs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 25.03.25 um 00:07 schrieb Bert Karwatzki:<br>
    <blockquote type="cite" cite="mid:20250324230712.4122-1-spasswolf@web.de">
      <pre class="moz-quote-pre" wrap="">Here's the dmesg from linux-next-6.14-rc7-next20250321 (CONFIG_PCI_P2PDMA not set)
The memory ranges of (afe00000000-affffffffff) or (3ffe00000000-3fffffffffff) are
mentioned in neither of them.
</pre>
    </blockquote>
    <br>
    Ugh, next time either in two mails or as attachment please. I had to
    separate the logs manually again.<br>
    <br>
    The BIOS programs multiple root PCIe resources:<br>
    [&nbsp;&nbsp;&nbsp; 0.310962] [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T1] pci_bus 0000:00: root bus resource [mem
    0x000a0000-0x000dffff window]<br>
    [&nbsp;&nbsp;&nbsp; 0.310963] [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T1] pci_bus 0000:00: root bus resource [mem
    0xf0000000-0xfcffffff window]<br>
    [&nbsp;&nbsp;&nbsp; 0.310965] [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; T1] pci_bus 0000:00: root bus resource [mem
    0x1010000000-0xffffffffff window]<br>
    <br>
    But by default all BARs end up in the 0xf0000000-0xfcffffff window
    and are so accessible to the iGPU.<br>
    <br>
    So I don't see a reason why dma_addressing_limited() should return
    true.<br>
    <br>
    Regards,<br>
    Christian.<br>
  </body>
</html>

--------------1N1PHiFk0x3O0bSB0dX9wKHs--
