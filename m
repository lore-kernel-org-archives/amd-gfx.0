Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C7BCAC5B0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 12:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F67410E3E8;
	Mon, 29 Sep 2025 12:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ENOrc8K4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637E010E3E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 12:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y80hJc1zKWvjEDxb8DKoXARyXxlN/oxZIyjl65+EXCYM0839Ie/Rj5yWbgMj80wbtMm9nSJ1Ykettr4Zz2yXl6o4lHXAvPTDAGdbTU4M/9LXjYaU2A3AcJVoMJDbkrNUakS304hVYhLV8VPswPER9bnWURhapmNPgoXaruW6iWy0stQd0biM5EBNveHhSBNK/aGKF59NJXFDW4I7qJGOEzleULMg5sKhYtXlYTRz/0H3Wq77/UFwzMpPswUzlVK+xh+a8lvBJsUQ18CrjZc2C7SHmyzHGoU1m5Uy3HC8slj1Dt0D6BFENgFQMKVF0vDPbvwRL6Oth3f62h/qV5/guQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2glaJj8wmbIwWDRovUwReJ1g2kZTLT94KVQFf1ZxI8=;
 b=W+mnZ19USVpri8iY9FUaa5+HWPGosaVQdoDSqX0j6dLSQ3CIGjY3Oc7DKqLtRfZ7xqanekIy65YWqffOO4efbip78S5Fa+Wfzh7FR2hLwObVW+rdWAeK5QRhf1/uUb7dNkBSTKmTbLfKQ/93sAyTUxlCHOUYAHbuHIj+YqysKoN7swW9YXFVUZaXbrlYLTDMVrn+qWCBTnbGbp4ANEqwlEtGMGZ6lwXwNuOXEh9C/2IMETVJHEhAYrfd2gdL+13YpNBcItA6HjrBYaE0FbFG/2sCd5UDS/KoT2RqhUVjjJpICWV87k7YehFGKYJ98D0zVNbc3uF+ZGYCrhZCuHrz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2glaJj8wmbIwWDRovUwReJ1g2kZTLT94KVQFf1ZxI8=;
 b=ENOrc8K4LoGGxxVEehsZalOqwfzR5oXt9Sb9dfFk1rO4NH4LhR4BW+PHl9xTaL4M+hFobk9UrxSalvBwq3Vm3MpoIHOePShZSsuJkDNQ99vnT84ya+7VdHnPALiTRWxQMAHp4lZ1RucWN0g23nEpwRPWPEfBoPPGLjpDDnd3COo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:06:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 12:06:32 +0000
Message-ID: <7d70caf5-e74c-4f28-9e4b-efd2f52810f6@amd.com>
Date: Mon, 29 Sep 2025 14:06:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix general protection fault in
 amdgpu_vm_bo_reset_state_machine
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250929085121.3181721-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250929085121.3181721-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:fc::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ba5288-406a-4ec6-d7bb-08ddff50a12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHBvWWgwbVlWSGVSQTNvbi9PZlA0Y1BaUTBzNGV6b2JnRFVBTmNPQVhtSElo?=
 =?utf-8?B?YnJ1aFc1eThTUWN1TWxXRVZnbUtIbC9DRVNERE41TzQzeDBIcnVBL3p6cEl2?=
 =?utf-8?B?VjVXdGx3N2NoczMzL3hxbEQxSjNiQVZnSkJZZHNya0lEdXh6SllyRnBXRmxm?=
 =?utf-8?B?UHB4dWVzWmIvZnNqU0dkbnlZMy9zV1NkRWNzOEVYbTkxQ25nWTkwVTJUSSsz?=
 =?utf-8?B?UkJuQjhBTkM1cTVkOVRnNU00QUhFalkzOVBlakFxV1BySWhram9JbWhENlVN?=
 =?utf-8?B?aHJ0eksyaEpQazZROUdpcnhjUHp2d3FWQVp4dnhhSHBESlVwc0ZOWDdJSXNY?=
 =?utf-8?B?dCtrbVhnOW9yeDhuQm5PcDBnb2JUUjFOZmZ2UXpqV3dGdldwT1I0dll0Uko5?=
 =?utf-8?B?aHdpS2ZOSEtOS1RmRDhXUWN0NGVNSTBzSEdteXZVSnRSNUtjL1p0RU5hc0p0?=
 =?utf-8?B?elEzUXBVeVNCQlBvS00wOW42akNYdnE4aVpRbGovYy8vM3lwUThwS2MrMC9p?=
 =?utf-8?B?bjhkVk54VFhLLzNHM1RjajV6L2FhSlBzUzRCNndoU05ZdXpQSENpbXljUFBX?=
 =?utf-8?B?eWxqVi9XMmtGdVZEekJBamN0QW1SbS9sZ0I0NGlrM3ZPRld1TjJTZkI3QXQv?=
 =?utf-8?B?NC80cFIrc0VaMzIwbk1wZkptRVRMcUFYM0xGdGI4OTczSm52dU5mV21kK0l4?=
 =?utf-8?B?aitWMHVHR0pvdjRPdUsxZTRtRjd1TFlLeWtybHk1SFBXSit5cmZGUTBLNlRm?=
 =?utf-8?B?WnNiRUZMOHYzYUlDendPTm04ejlqMGgwV0JKeXpydk9URnZwVTliWVNVVlJH?=
 =?utf-8?B?eUhHc0FRa283c080QSttcDYwdjllWmx5ZXVzdmt5Sk5nRlJGQSsrUWx5ZW51?=
 =?utf-8?B?eFZLY0Z6QzJFQnNHQW5PZGdVcU9yTEJHM1FPU2JqSWIrZ1RaeDdnVlF0YWZI?=
 =?utf-8?B?SmtaOGFHeGFFdFJUM2NrYkFIZWNXTldOd2UyRWh6blRxS1drZU5lYVAyVzRm?=
 =?utf-8?B?N1NhMzAycXZubkEzVE1vb2s0WjBuRFJrYjNDK0ppNmRvRWpnQUNGeTRCYkNI?=
 =?utf-8?B?WFVBYys5UHo2cUJHSE9MZHVLeStvSUE0VkJocVIxSkZxcGtTdXFOM2FDQzVz?=
 =?utf-8?B?T1AvSC8wZDZzczFBWjJYb3lId1JhTlNMb0NxRzBPQ2RrNkxxbE9na1A5ZHU0?=
 =?utf-8?B?U1VoR21hQndhL1ozQkdESjFzL0tyNDlsQXZJSUJtcE1UQmt0U3h4OFlqdkdZ?=
 =?utf-8?B?ZjJhcEtHVlBIWjFRWG4wclp0ekZEL0RBbkVrdHpiWmNodElDa1Qxb01Jemxm?=
 =?utf-8?B?ZnV5L2ZjN3BHcGhJQ3kyamRielFKL0dTRVFsNEgySERrUEVicDRqemZ1K1lE?=
 =?utf-8?B?a1BPYTdYUTh5K3MrN3lLclZjU2MxUFhtZ0pVQmg3cjNCemhoYklLaGNMM3dk?=
 =?utf-8?B?eDhjaEVYR3l4dEpUSmt3cnpEbllaZmpreEtWYlQyajVIZCtpSWFCbWZqZEJE?=
 =?utf-8?B?V3NhV0k5QTFXTFVOREoybjFIUCtjUVRxaGZBa1Z3VTZ2TGgvUk5ESFBueUxE?=
 =?utf-8?B?RVFxQ2R0V3pCQUYzc01mNVRETXVIUjhqZjR1VmpuNlVxa0NYc1d5S09hTUc1?=
 =?utf-8?B?WDZGNUxybFoyd09tR25rc1laajU5ci85UDVBR0xDbVRlOFFKYlFlYmk4N2RP?=
 =?utf-8?B?MHltbVdRdCtlZjdUckhXcEF3ZERsN1Z2MjRpNmVnVE41WEtFWk1HTjJ3dTN4?=
 =?utf-8?B?NytKM0RwM21jK213Q3pNK1ErZlkraE15cWhVTjlsWUF3OE1WQ2pGMVR5SE5Q?=
 =?utf-8?B?UnYwR01Ea0pPdXRIV2F5STh3em9ScnJCdld3ZW11QzBGRERNYjA5TlBnd09Q?=
 =?utf-8?B?MVNDL0o3NHowb2JiZG90RnJDd01MQzNiRjlkYjBNdlJ1WjNkazJwbm1NSjI2?=
 =?utf-8?Q?TTTePz68nMnbLcY/LS8n9zWOgxvO/PRR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0E1RS9hUjVpbDE0RUtaWjlYblArdzljTW4xamdOdFRQVUFseWhTd2M0Y1dv?=
 =?utf-8?B?M210K2RVWXY5MnJsckdtTGJvREpxYjVNQXhJWHJ6RSt4RDVjUEFvR2lxWmVm?=
 =?utf-8?B?Tm9haWFYdE96T1JJZlBYd1lzdENoSDM3L09RdHU4WDM2Q0RmM3VyejI2eFQz?=
 =?utf-8?B?RVZMQk1BR05sMkFtVDRzWWlIRk5LclhiVm40QTJsc3RKYitvbFZ0QkNFK016?=
 =?utf-8?B?TzNuSVphUWNFdHh5MmM4am9aU0poUFF5SXJjazVzQS9QKzZ3akFZVVdTTVhQ?=
 =?utf-8?B?UUJlaXJ3UGoyTUV0Zy83VWhXQ09BOHViNzViNWtBUEtMTEZDOGNqbmZja2I5?=
 =?utf-8?B?b0lsQUxpbEpTMEdrcFNzZnVnTHlVeTRQOGNCS0g5L3RjTU9VZ0xwUVliSFc5?=
 =?utf-8?B?SklnWDIyVW9FZFR5UktjS2RPakVhR2tuZzNlVGJIdkFSc1ArWXZxWUJWb3pp?=
 =?utf-8?B?R3BaYTg2ZEc4bThYTXhiQmsyVUF3MGZ6bTlLL01BVUlLWVRKeXBJdEhJRXVX?=
 =?utf-8?B?QU54OFo0ZHAvVHBQN0F1QndDMTN2emJNYm9QNnVFUWZqcGhjWDlKbitCN01D?=
 =?utf-8?B?QU40WkN3WE5EWGMxNjNtcUtOV1JqamdmN0N4THFIcS9STGFyRVNKS2NuaDJx?=
 =?utf-8?B?VXJFSnZ2R1NiTzZTcnpJeHpHM2RqeVArS3pjOTN0V2lJaTRTcVRSV2V3K2Uw?=
 =?utf-8?B?N05IdkFsRVcvWTJpSkx0OHM5SzhiWSt2M1U1Qm5ldTZQbm1JRWRBOHNIanBs?=
 =?utf-8?B?ejVPODI5cVZ5UVZjVzA1bXBCTktBYy9DU29pRldpS0NsSlJoSlRXZkpJVEZY?=
 =?utf-8?B?dW5UZHcvMDY3cXh5S3luYlY5RGFQZVIrdzNhb3RlV29jV3d0OFRlMHRXTFFw?=
 =?utf-8?B?bUhXQ1VITy9BamtMbnpCbURhR2FCekcxUlZENnB5YjNVSForUjBpdnFCSk4w?=
 =?utf-8?B?S1RJWS8wSUVqWjF0NTlMMjh4MlRINTdDenBJR1JjQXBWQ1lXeC9hL08vMXlv?=
 =?utf-8?B?N3VLZUhTLy9IRlZ6K29nd1lwRytoOFpGTDc4dy9LamVEY1ZUVmpQdUtoSDRW?=
 =?utf-8?B?ejVCQkc1QjlhdWtETzI0U0RwUUNXSmpBbWhKWlBQdzViUXVjZkpYRFJNcE80?=
 =?utf-8?B?RlV5R2M0dHpOTUxpTW5oQnQ0TGEwQ0d5RHo5ZlFEZFYyazBCbWFwUUhaTVhK?=
 =?utf-8?B?VUNYMmhtZ2R1U2pqRFNySGU0UGhLcnN6MzJFWDN1ODFIZ0VPSXpOcktXcnRm?=
 =?utf-8?B?WEd5V1dGd1N5Tk4zZGZGbkJQRG50bGQxbWx4cDFmY3BaS1F3K1d6OTBieklp?=
 =?utf-8?B?UHV1UEN6c1N0MGlwMHdNTjhkU1J6aW5oY0JyZWh2WDVoSU00d0orM2QrbTlC?=
 =?utf-8?B?UkI4Vm5JUm9mTmFKZndaOFEraEJ0NDBjazBDVkExZWY0b2xlTmZZaVROUzRs?=
 =?utf-8?B?Y1M0bGs2UXhITEd3OVVVR1R1VENKNGxsVkswOEYzdU5JWlk0MEJKWi9ZMTYz?=
 =?utf-8?B?MmEvLytIWWxaU0RPOFVBQ1VNbm1CWll2amorMGpaLytEZ3NFLzFjYUg1UGFk?=
 =?utf-8?B?Z3ZsWFZKbUVjQ1pka0NYSlVjVFdkN2sxZXJhOGFJQlpjT3NpVkZzVlVVdkVx?=
 =?utf-8?B?b0ljbDVtWTVnVStTOVh3YVhhQlc3UDR6WUFvbWsvTkdaNHJidjlMVTErbUQ1?=
 =?utf-8?B?Nyt5clN1Nys4MlJLQ1hYdktMRjFYSW9BRmZ2eldEQmNOSmJCWXllSWE4R1FG?=
 =?utf-8?B?Z2dhRnY4K21uSnZyNFNIdFBmK2lxWk4zM3gzYkRYUFZ4amhtUk9YbnI4ZVRK?=
 =?utf-8?B?SWkvcHNiTWlYSlAxbm40QmtLTFhRYjJDREZJa0JsRDVUSS9CQUNSUDZkSHNj?=
 =?utf-8?B?ekxjMEx6S01xdms3bUlmM29OS2JWMzdwNGJQTVVmL0JzWmFPcEJRYXFIWFdQ?=
 =?utf-8?B?Z1dPOFRaZ0dld2E1clhDdlE2RmhmaVJrTGJZMFlLdUtNL0cvV1V4cVNEaFRN?=
 =?utf-8?B?MndDZEpDZ3RPak16VVNxMnlSWVIxQjFjZytlYnZCTm1GcFFmaGtvR0tEYkgy?=
 =?utf-8?B?djhNQldzWGl0QXc4YmJoNmg4U2I3cVI0YnJWV1hPTEx1T0ZQNlJMOHJucVUv?=
 =?utf-8?Q?Wzbki6xF3b20vj5kvRzHBkFAL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ba5288-406a-4ec6-d7bb-08ddff50a12d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:06:32.6488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOCJW19quQia61f2hojNJg3OSvLRWmmVTLwYgm5gK7YV7tKKYpjavqCRwslqF+mf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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

On 29.09.25 10:51, Jesse.Zhang wrote:
> After GPU reset with VRAM loss, a general protection fault occurs
> during user queue restoration when accessing vm_bo->vm after
> spinlock release in amdgpu_vm_bo_reset_state_machine.
> 
> The root cause is that vm_bo points to the last entry from the
> list_for_each_entry loop, but this becomes invalid after the
> spinlock is released. Accessing vm_bo->vm at this point leads
> to memory corruption.
> 
> Crash log shows:
> [  326.981811] Oops: general protection fault, probably for non-canonical address 0x4156415741e58ac8: 0000 [#1] SMP NOPTI
> [  326.981820] CPU: 13 UID: 0 PID: 1035 Comm: kworker/13:3 Tainted: G            E       6.16.0+ #25 PREEMPT(voluntary)
> [  326.981826] Tainted: [E]=UNSIGNED_MODULE
> [  326.981827] Hardware name: Gigabyte Technology Co., Ltd. X870E AORUS PRO ICE/X870E AORUS PRO ICE, BIOS F3i 12/19/2024
> [  326.981831] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
> [  326.981999] RIP: 0010:amdgpu_vm_assert_locked+0x16/0x70 [amdgpu]
> [  326.982094] Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 85 ff 74 45 48 8b 87 80 03 00 00 48 85 c0 74 40 <48> 8b b8 80 01 00 00 48 85 ff 74 3b 8b 05 0c b7 0e f0 85 c0 75 05
> [  326.982098] RSP: 0018:ffffaa91c2a6bc20 EFLAGS: 00010206
> [  326.982100] RAX: 4156415741e58948 RBX: ffff9e8f013e8330 RCX: 0000000000000000
> [  326.982102] RDX: 0000000000000005 RSI: 000000001d254e88 RDI: ffffffffc144814a
> [  326.982104] RBP: ffffaa91c2a6bc68 R08: 0000004c21a25674 R09: 0000000000000001
> [  326.982106] R10: 0000000000000001 R11: dccaf3f2f82863fc R12: ffff9e8f013e8000
> [  326.982108] R13: ffff9e8f013e8000 R14: 0000000000000000 R15: ffff9e8f09980000
> [  326.982110] FS:  0000000000000000(0000) GS:ffff9e9e79995000(0000) knlGS:0000000000000000
> [  326.982112] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  326.982114] CR2: 000055ed6c9caa80 CR3: 0000000797060000 CR4: 0000000000750ef0
> [  326.982116] PKRU: 55555554
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 563cad9c6cbc..86c8288c665f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -265,7 +265,7 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>  		vm_bo->moved = true;
>  	spin_unlock(&vm->invalidated_lock);
>  
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> +	amdgpu_vm_assert_locked(vm);
>  	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
>  		struct amdgpu_bo *bo = vm_bo->bo;
>  

