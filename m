Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F74CEDDA1
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 14:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBC010E749;
	Wed,  9 Oct 2024 14:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZqCnVZSm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 439ED10E742
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 14:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOFfPUvu5Xzgv+51ZybIA2EZCqznx7CbJxd8LhA90McZzQrXnUoUvXerwdbwFtZm7MA8Nw+R96oO9AQU3ta52PuikPUSW/sIeDYmcJjhsUMWmqEWlhhUQwHs6trT8imj+ppVjl262dwaUitauF4mAMZ5gzhBcEsKR8XJb46h/c7i2/rkr8qnFoJWQU688z9plXvQcGcTx3gtCa2HE+xaWXFTf/6N+ouquKGX8syvee5Z2rAWhuElC/F7SIKqm3k7yJvExYzOPI0ByXtSuwzTzEbSaCvrMA5Koa7RDX6CzndFeCAEEKRFoSbeApYMkuLWUf1X0IkXtQNDsjwJWDRKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcqwnKsJxqN26Jhjz/Mitqzfij6UftMcZz1Pa4aEp2U=;
 b=IaXzvvO9vIOw80sEfVM5s4jxtAmCs3sKuY3aVxEXXA6G3jBVY73tzffHjM3qCI2ohY7Bj1uqvCm7OqbEgXBJ+dutM7/cdACe2CkdrdI1lZojcs2jsF1yP3swmqGg7LJqpsPSR1m/AOGpTBA6ur+B8KQFEAnfy1RN3j4fTRQi7HiAzybbRsxj8XWA6cann7fMD7nEH9NjtzlG8Xs6RlsOW3/jbp4UMmagZBffeuFmk7gzxcDZO0yaTX8Tvst4lzC503trT6gTgMdycDjiWrISfEKl/3RDH8dcr1vxiNMGZvPYGCNCmL/eJYy/HOOpgF1zMVQUWBxXasAjUOBm3xO5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcqwnKsJxqN26Jhjz/Mitqzfij6UftMcZz1Pa4aEp2U=;
 b=ZqCnVZSmn4UMW3GJI5Oja7PPcIo6xcaFIg8FLQvqsP6oa+Ada4JJnB4AytcGhOjTiqPNC+S4t0HTCM3kIv/rD3iaAaxl1IRTg5g7L2Ao8Lv9lKd+8zCiDb0dWVe3Hs/hExL/eaz+nl/Dvk9HDV0h+XRdIlc2Nt2gmMmh7n+XwzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 14:25:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:25:13 +0000
Content-Type: multipart/alternative;
 boundary="------------58OvEp53pKOLCOHous8vZIR4"
Message-ID: <ec919dc7-8745-4efc-8611-299a59b80861@amd.com>
Date: Wed, 9 Oct 2024 16:25:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add submission flag to disable implicit sync.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
Cc: airlied@gmail.com, faith@gfxstrand.net, friedrich.vock@gmx.de
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
 <CAP+8YyGODBJO3hDKo8H9KwpdwR=O+ROOpxqrs8ureyvOVm7YoQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAP+8YyGODBJO3hDKo8H9KwpdwR=O+ROOpxqrs8ureyvOVm7YoQ@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: e3893605-d725-4413-ff65-08dce86e3050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzV6dFNIZVMyUHhESkVxaWI2RkMrWW9DWXRyQVFJdzR0bjRiQ1lsenU5Y1Zq?=
 =?utf-8?B?dFgxWFJRRkxrYnYxTW96eXd3V3Uybm1YQUdEdGhMOE9MK3daSW1yMjR1Z0Q4?=
 =?utf-8?B?eFBtRUFNMmhjdWxnL04wVEN0UkgxdGs5a0hxa3QwMlE3OS9KSitqenJYeW9l?=
 =?utf-8?B?WVAvWEFKc1dvcmRYcFFIeithalJoNmtoOWF0amU3RXlRTXN1ZXpFaWVlNlV0?=
 =?utf-8?B?UGR3aWwwQXErNFd3NngxV2JQdGZDMVJ2QTNXQ1c0TDROUG9vaGZpb01ob1do?=
 =?utf-8?B?RFRIVWMzSjFiS2FHSEk3V0hTaHBXWFFZYWNadFI1WXlwNnRlMGNCdG0zR1lE?=
 =?utf-8?B?ZWpiSVlVUHJpNWROcU4zZERZMmdPZTBzWDlKK3UxUEY2cGptUEZvUzBPakJX?=
 =?utf-8?B?a1ZBMHV5M2tPU2VkQkpoTDM5VG9jb2FsMk1vUGp5YzVXYXI2My9PWlo1NDV4?=
 =?utf-8?B?bWs4Y1BQMHY4aEw0WmtBUFpLRTVuQ2s1MGF5YU42NGNUWHRUdm5oVXQ5Qlhp?=
 =?utf-8?B?REZWSzJpQkNNNEY4c0liaklrS3d4T0p6N25xYUhVM1Y2SGFnYktkMlQxTXAy?=
 =?utf-8?B?TWRzSDhVRlQycFdqdTFKWDhqYlJEc0dVVE5IRXZvK2tRK1l6aU1GM1J0VUVX?=
 =?utf-8?B?dHhOL3E3V05VSGc0Mi9TWnMvdTVZZ2dWVFNuZVFTQVk1QTFwVXYrRlNBL3pK?=
 =?utf-8?B?eTFMODZoRjZUWEFCc0JmT1BXU05xL2hnQVRGMkR2NlppdGdWTzZIR1pubUtx?=
 =?utf-8?B?U2xkUWo0ZXRZZ2ZMdER0N2habUtCYkZJUmgwK0xlMDlxRi9HaEdmL2V4VFM3?=
 =?utf-8?B?WkduY09QSUh4NjBBK2Nnekp6eVl0YU9BTnhwL0t0UTJrWFF6SEpBM0lVR3BD?=
 =?utf-8?B?Q1FxSURzU0tuZjlZSmVtcE1TcWxaU3dYNXN5U2NUOFM1ZFA5TjZFYTVxWVBY?=
 =?utf-8?B?MEp0RUZJVXZ5OWhxREt1TDR2eURzeis0S2FIY0xHVkJPUXI4WUhXZ21aMEdu?=
 =?utf-8?B?K3BSNG1LTHVkRjZCMExOc2kvNFRaeS9XY0hjMmFsaHdXeGFIbDFVcnZtbEN4?=
 =?utf-8?B?clE5VHppVE11d09ZNE5DaXhGL2NqQzBhY1hBWmRxZEVpSndVb2xkYjR3T2Qz?=
 =?utf-8?B?Q3J4cTZmQldQKzRnbHpiS2k5dlhHT3JySzdZbElKYVRwVjlnZkN4TTRzaURz?=
 =?utf-8?B?SE9sbFJLRFNtLzljRWhHOFdRc1IxWkRNOUduU3I5N1dWZHA3Smkxckw4eWJq?=
 =?utf-8?B?bmJCU0hsMXV4WkpuTkVma2JmRTJPeStwdVE4TlByLzJnUWRpVUlUYWRrM2hC?=
 =?utf-8?B?b0FoYTN6dkNDaDN4dmdPQmtnNzI3d01UMFlpNzBBOS9VbkpkUG5XODh5aS9z?=
 =?utf-8?B?cTJKU2RiTTBWbXFYd2xuVjBCazRnSFYrS25kUjlveXFtakxxOXNURkZ0YnZF?=
 =?utf-8?B?alZOY0I1R3JrdmJVZ2dZZGQ0VERZMmVaMUcwMU80d2xKOHRvWWoxVk1KZHBS?=
 =?utf-8?B?V2g4K2hydU5MdEpDYUxoQlloa0E2SU1zNERyTHFQaTRWbUsxK29GQU9SRk9Q?=
 =?utf-8?B?SDlNeWlVbU96SUN1RSt5c2NiUEt4ZUtZNGVNWkJiTUFSdlQ0d1BJQUJhN1ln?=
 =?utf-8?Q?efc9tRarTTrJIre3SfjfSvGwKEIeeyoqic6gDqzp+8o0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUM2TkFwMHdraGZzVU9pbm1mUTBLUXdKUWtZb3RqdkkxNldRNm9kTlg3T0Zj?=
 =?utf-8?B?RmdUVjlOS0xXaG1OMEVrMllCQVJDck1CK0dBM0QwU0FZdzZ1WnppZVI5VHF2?=
 =?utf-8?B?b0pWT3lEN2ZXSW9RTVExOGY5NnZEL2hCMC8wbjFVS2k0dC9ITUh0SEtnRzJL?=
 =?utf-8?B?YUlKQTRtUzBZSTBIb2c5amFXVEw4ekkxUHhweDk4WFg2NWFsNXE2M1NZNWEr?=
 =?utf-8?B?ZVVyU1dVS1BpeFZ4eVMrYTNHQi9JY2E0V0U3dW1iZnpLQ1VkcWNGdzJ6Z3Yy?=
 =?utf-8?B?RzRhbUZIN0hNTUo2cGZPVzdZMHhtcThZUmNpZWhPZyttQk1Fby83R3l0RVdC?=
 =?utf-8?B?UUdtZXhCSHBOTjJNVDJlM0ZnVmFrT0ZkajNPQ25rclc4NWhwYkpoTDFCSGNR?=
 =?utf-8?B?TnZZMkVXSVVBbXlTd0xaMEpqcWlmNkVZMCtCR29sb3pYNk9DK2lMN2plZHlR?=
 =?utf-8?B?RFEycU5SQjlmWWIxWTBoKzlQK0lhb1pHV2RyNUs3MGl0ZWJqQUtzQmZlRTJT?=
 =?utf-8?B?ZzBRN1VHWVBmSm9wQlVIUWJXOE9NRFNHQ2FvbWpBdElCZ1Z0TW8zNjExMVpX?=
 =?utf-8?B?elZjb1NZRHhQMk5obm93eGNuVkFONHE3ZFVxK0ZTeFp1alpYL1FZWjZrU2Zk?=
 =?utf-8?B?bWdLQ1hHdHlJNlNDcW9NM0Eyc080UXVvQUI3cFE0eCtIUWxWaUY1Njk2Y0VD?=
 =?utf-8?B?QWNZcWRYZHByamNFRGp0WGlSYU8vaWxvY1VmVjhEbHZxRnpPVTVycC9Sak1C?=
 =?utf-8?B?SVNjeFdpOEVOKzFHSVJ2bHFFbGtzL0hYQXBVeHVIMWhhZ3hxazYxOWJsSDFv?=
 =?utf-8?B?UE1MbG4vN3hjVUV4bStZT01SaGpYQ3hmL0o3RnFJeGxTN1o0clFkTExuVU9Y?=
 =?utf-8?B?eGd5aS9XcFgzakJLMUVtRUZuTkVUTVcrL1JLanhPN2N5Z1cwMklyWHBMbjNp?=
 =?utf-8?B?OTBaYVlYUWlPcy9uejFoZVBpa1JKdG1KcTZRRnEzRElKNW1MOXhBZTdLSW5E?=
 =?utf-8?B?RGJSTFc2Qm5MdjkxMFVtMXNhZkcyc25xdGVQa0ttT0k2TDBYVDQvYkQ3QklV?=
 =?utf-8?B?UnJQRWFRYm8vdTdDNG80Z0p0MGdGRS9wR1Z5MEFxcmR3NTlBY0RGekdycEFG?=
 =?utf-8?B?NFVqa2tTL3NlUHdxRzZ5dEtFYSs1ZGlMSDJwZENRZzcwciszVDdTZkhTQ2hm?=
 =?utf-8?B?MVhXSUZJanI5d2laNHBtN3lsNmk0eHc4QzVqYUlEeDNoUmJRNDA3bktLZWty?=
 =?utf-8?B?cHFRZkhWczVRdlExaVNKSGZ4TTc5aStrU3FCR2NLNXJHQll3ZkM2aFk2eExG?=
 =?utf-8?B?UklOTGU1b0JSMC9oOXE4ODdJRUhjRTJ1RTdjK1RyaVJENldVKytxY1poQUhG?=
 =?utf-8?B?cmJkN0pmVU9XQnlyV3AvcFRWYVpvL3ptdUwvK2NCT0YwbXR1MWttSDhVNWtC?=
 =?utf-8?B?cUhOaDZlK0pERUdlcGl2Z3IxNGJnb3lUcmJrQ1ZlSUFXUmp3ZUdldzgydGZ2?=
 =?utf-8?B?d2dwV1FhOFAyNnVrYnJVVFg0YTZ1Y01yc1Exdzh2aXF1WExiOUxmd1hlYWhm?=
 =?utf-8?B?LzN1c3BFd2gzYzhSK3lxNmlHcHdQa1lQM0tnS2NDSTFIOHc4Qm12WTd5ZUNz?=
 =?utf-8?B?YkwrZXIxbmgvck9QQlNUdHBQdXNva2k1NjhTREdQNjZEWmFRTGpNV045SHNO?=
 =?utf-8?B?di9HMHJPSE9nQTJjY0N6d2YrK0F0TWFaWUZhOERrbnUvU1NCZ2dxVFkrVzlZ?=
 =?utf-8?B?SDYvaThGQWZMc3VyVWRJNDEzdXJMcG8rVTU2RWFKektaRVRPTnlyWU9jL1l6?=
 =?utf-8?B?NitJRXVBMzdSUzFOUFgzdS91bmd6bHJlU0ZaSTU2UTU4UXRUZ0wvb21QeXQ5?=
 =?utf-8?B?TTl2OG1iTGZjalpzbkFrQ05UbDlyMFBPY3N1OTRPMkdGN2VYTSs3YUR0TVFR?=
 =?utf-8?B?YXZSZDJJM1licll4VFBnZXN2Q3FFb2NlRGdhTDhlNEg3S3BjOXZrblhrWXA2?=
 =?utf-8?B?MFdWWExMQzhoMmJxQlhnTTE0b3pCWU9LaTVWRjR5dk1HNmdTcjhuMkF2THQw?=
 =?utf-8?B?U2pZS0pNQzdUbmovMWpOTGQyazNoTTdNTlFqWCtjUTBNVVNoRHU4b0dQc1pT?=
 =?utf-8?Q?cvaw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3893605-d725-4413-ff65-08dce86e3050
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:25:13.6751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpW0GGzn2ZSMF0tR28ExSE03pw9a23FOuHDPStrlmNHrcT3eNQrLcYl5rcYqyUrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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

--------------58OvEp53pKOLCOHous8vZIR4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Already working on that, but userqueues have pushed that back quite a bit.

Sorry,
Christian.

Am 09.10.24 um 16:17 schrieb Bas Nieuwenhuizen:
> Friendly ping on reviewing this series from the AMD side. Thanks!
>
> On Thu, Aug 8, 2024 at 3:09 AM Bas Nieuwenhuizen 
> <bas@basnieuwenhuizen.nl> wrote:
>
>     For the rationale see the earlier RFC by Faith:
>     https://lists.freedesktop.org/archives/amd-gfx/2024-August/112273.html
>
>     This mainly makes two changes:
>
>     1. Uses a submission flag rather than a context creation flag.
>     2. Uses DMA_RESV_USAGE_BOOKKEEP to avoid adding implicit fences still.
>
>     Note that this doesn't disable implicit sync wrt VM ops
>     (map/unmap), I know we have series for that going around,
>     but I believe doing just submissions here is less involved and
>     doesn't really complicate doing VM ops later.
>
>     As of now this has received a limited set of testing, no full CTS
>     runs etc yet.
>
>     For Userspace see:
>
>     libdrm:
>     https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/commits/basic-explicit-sync
>
>     mesa:
>     https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/basic-explicit-sync
>
>     (Still missing a bunch of the version bumps & version checks,
>     would like to postpone that till we know the actual version)
>
>     Bas Nieuwenhuizen (6):
>       amdgpu: Add usage argument to amdgpu_sync_resv.
>       amdgpu: Ignore BOOKKEEP fences for submissions.
>       drm/amdgpu: Check cs flags.
>       drm/amdgpu: Add UAPI for disabling implicit sync per submission.
>       drm/amdgpu: Implement disabling implicit sync per submission.
>       drm/amdgpu: Bump the driver version for the new flag.
>
>      .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  1 +
>      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 21
>     ++++++++++++++++---
>      drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h        |  1 +
>      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  3 ++-
>      drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 ++-
>      drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |  7 +++----
>      drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h      |  4 ++--
>      drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |  3 ++-
>      include/uapi/drm/amdgpu_drm.h                 |  6 ++++++
>      9 files changed, 37 insertions(+), 12 deletions(-)
>
>     -- 
>     2.45.2
>

--------------58OvEp53pKOLCOHous8vZIR4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Already working on that, but userqueues have pushed that back quite
    a bit.<br>
    <br>
    Sorry,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 09.10.24 um 16:17 schrieb Bas
      Nieuwenhuizen:<br>
    </div>
    <blockquote type="cite" cite="mid:CAP+8YyGODBJO3hDKo8H9KwpdwR=O+ROOpxqrs8ureyvOVm7YoQ@mail.gmail.com">
      
      <div dir="ltr">Friendly ping on reviewing this series from the AMD
        side. Thanks!<br>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Thu, Aug 8, 2024 at 3:09 AM
          Bas Nieuwenhuizen &lt;<a href="mailto:bas@basnieuwenhuizen.nl" moz-do-not-send="true" class="moz-txt-link-freetext">bas@basnieuwenhuizen.nl</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">For
          the rationale see the earlier RFC by Faith: <a href="https://lists.freedesktop.org/archives/amd-gfx/2024-August/112273.html" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.freedesktop.org/archives/amd-gfx/2024-August/112273.html</a><br>
          <br>
          This mainly makes two changes:<br>
          <br>
          1. Uses a submission flag rather than a context creation flag.<br>
          2. Uses DMA_RESV_USAGE_BOOKKEEP to avoid adding implicit
          fences still.<br>
          <br>
          Note that this doesn't disable implicit sync wrt VM ops
          (map/unmap), I know we have series for that going around,<br>
          but I believe doing just submissions here is less involved and
          doesn't really complicate doing VM ops later.<br>
          <br>
          As of now this has received a limited set of testing, no full
          CTS runs etc yet.<br>
          <br>
          For Userspace see:<br>
          <br>
          libdrm: <a href="https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/commits/basic-explicit-sync" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/commits/basic-explicit-sync</a><br>
          <br>
          mesa: <a href="https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/basic-explicit-sync" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/basic-explicit-sync</a><br>
          <br>
          (Still missing a bunch of the version bumps &amp; version
          checks, would like to postpone that till we know the actual
          version)<br>
          <br>
          Bas Nieuwenhuizen (6):<br>
          &nbsp; amdgpu: Add usage argument to amdgpu_sync_resv.<br>
          &nbsp; amdgpu: Ignore BOOKKEEP fences for submissions.<br>
          &nbsp; drm/amdgpu: Check cs flags.<br>
          &nbsp; drm/amdgpu: Add UAPI for disabling implicit sync per
          submission.<br>
          &nbsp; drm/amdgpu: Implement disabling implicit sync per
          submission.<br>
          &nbsp; drm/amdgpu: Bump the driver version for the new flag.<br>
          <br>
          &nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; |&nbsp; 1 +<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; &nbsp; &nbsp; &nbsp; | 21
          ++++++++++++++++---<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h&nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; 1 +<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp; &nbsp; &nbsp; &nbsp;|&nbsp; 3 ++-<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c&nbsp; &nbsp; |&nbsp; 3 ++-<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c&nbsp; &nbsp; &nbsp; |&nbsp; 7 +++----<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h&nbsp; &nbsp; &nbsp; |&nbsp; 4 ++--<br>
          &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c&nbsp; &nbsp;|&nbsp; 3 ++-<br>
          &nbsp;include/uapi/drm/amdgpu_drm.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|&nbsp; 6 ++++++<br>
          &nbsp;9 files changed, 37 insertions(+), 12 deletions(-)<br>
          <br>
          -- <br>
          2.45.2<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------58OvEp53pKOLCOHous8vZIR4--
