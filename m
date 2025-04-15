Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8923DC369AB
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2197E10E7AA;
	Tue, 15 Apr 2025 14:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PscBFNWA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 573CA10E7AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTiDr4VK7O2h32To3sSgY512w74J8rbEEKeKtPrHPF+d0F0udbD1xr4+SI2n/c/zQwWxCwnyzqxo/cO8bUud5ypVuUFIvQ+6kXZj5XPxnb5tyflF7AXdzGPhXJKuAybsAVGlmmfv5NUz441+EsH2IuE9iIXWwGbf32ZydbNcOcKs3uB4VKg9hmmm3oyzWknH/YHyjQqRgKPwNMnMoZWiIzX/xd6E/61CiMBLpQywN4Q964DviPKV63DtTtIu5H/W/xN4fiydVI+eUeb8wsii/jTTYXE7GEFHsQ1Cp7aKxRGnaiWwT4/ID5AedbO48Pw5lUUyyCUE7mgwZrMqBfhhuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WUYHrgR4PwblpHeW0uR5wRWn3M5eiRKLZo5g5H+h20=;
 b=JLslina/lctG1gy0kxZD4GJDkdd3XgibQq3NHe0nvxgoIKV5j8+Lhz9q9hmKq7w3xsWm9bIcIdU+IhHnZeOZi86FIiK8ivB457jVoBNkStfyfrk/XkWHdsn/RFiWKD8zT2Ao2XPNbW1NBp0myERcmd+pQS0qAY98Kne6c1J9BkCdNeh9K0U7A8y5Cw8tLyUdIR6oSUbJ+BibUvLLAuP6N8kxAguFUTHlqSXZogHd5JPXiyUfB1DPYwe5OhZQ5LSScGK2igMi7zxxJoadUDEOaWR5glL9C1Obq+nKVX1w4yTsX1DEeR1BlgGaUFrVT2lSdzG+Qq0nJ5H11+hMI81lRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WUYHrgR4PwblpHeW0uR5wRWn3M5eiRKLZo5g5H+h20=;
 b=PscBFNWAi5G5ZKiCgL2uVIhcKwfREDiAQ9gFIg3WQ/3uoRAHTNNQNWObkrLFvADfMZwELcaqQJ64ati+/W9PPbPHpRGUCdWCw1bl1VOih4iSs3wcRp8mm3GM5axoHeFv1W0YMDGHkelP1eChAynEtZj31A3i99IoWNCAm0kbL2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 15 Apr
 2025 14:23:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 14:23:25 +0000
Message-ID: <e41f6932-6398-4bd3-a85b-0c7d6a259a37@amd.com>
Date: Tue, 15 Apr 2025 16:23:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: only keep most recent fence for each context
To: Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250415141848.58478-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250415141848.58478-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:208:134::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc4adca-707a-47c6-81f2-08dd7c291580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1VrUXZEcUUzSXIxc2hGTW1mTlJid0NuOXg3WG0xMHRuUFZZakpRcWprNHlR?=
 =?utf-8?B?TVNaZGJXNENMS2dwZ2RnS0taQmF0OFBOekw4NFNkUGt6MXZsVzBxRTFxREVM?=
 =?utf-8?B?VTN3Q3psSUx3SUFvYmtYcE12WmtZT3lTNDdGOHFXQmcxKy9Kd0RsSGlGelpE?=
 =?utf-8?B?SklMblo4VUhPU2hlanRieEtrQzg2QVJINlF0TDZSbUFwTzcydnAyRzNiQmRa?=
 =?utf-8?B?NElGWGVwMXFmQXVneWErbENxbWtNQ0RhNXJjaXRPYnhDUno5VklWQ2Vtelo2?=
 =?utf-8?B?TlREdHZzcEU1bXdNRjJndDVXY0pKTHZ0R1VqRFV0cTl5ckNIZU91Zm5Ia0ts?=
 =?utf-8?B?YWkxOSs4SjU0QlFPSnF6RnVDOWhiTSs1ZEt1TjV5QnVTQi9tMXZEYjFsczk1?=
 =?utf-8?B?SUhrYzVpQ0x2NTZzek10VnhLRTVWeVBuRUNOT0VDbVJhQWFtd25mNENqWUJQ?=
 =?utf-8?B?S3IzVG85aFBSd1hsRjdQM2NsNzBTRU4yM2c5S3hucXJyajU5RnlPZHZIRW1Z?=
 =?utf-8?B?UExRWUVRMkhyVlZ3eTZVWVVYWHZ4OGZNb1Y4c2EzRkZQeVdiWnYvVjNubldR?=
 =?utf-8?B?a3RjcWlWemFQLzhVdFhZREZ6QzBhazhmbXdyMGh4RzJYR2pmSCtJb1dGc2FQ?=
 =?utf-8?B?dFFGSHJueTNIWWowNUdSV3N0eGMvMkdOUHdGNzA3U3VweVliQVMwYTd0OW5r?=
 =?utf-8?B?MDZ3R2poUjgwNkxqWjR0R29kT2VDRmhnbnQ5ZkRML3dBYTRLRDU4WlE0dUtL?=
 =?utf-8?B?eUUvUXpMTVZ4UEw5N215M3NKMTljZzB0QXNGdkNRSTAxOFk3blN4RXlFalBP?=
 =?utf-8?B?QjlINm40a3FkZXRVc2VCOTNmUzg3RndXcUcvL2U1Rmxzei9xeFZ1bk9xLysz?=
 =?utf-8?B?UThWSzFVMlhQRlRwZjdKMmMzam5rVDNmUGkxdnIrZ2VhaUxuK0lmYlZzRXlV?=
 =?utf-8?B?dEQyeDdZN2JOc1RuQUF0dnFpRjIzYWxRTEJIOFZubS9BWGwrbzBMWVpzVDBO?=
 =?utf-8?B?STByMlhtU3hGU3kzcVNsRUU4N2xWVmlOSEZoTDdNRGVqWFJiOXVEdm01S2dC?=
 =?utf-8?B?VmJUTXJHSzJVYSsrd2VUQVNBNVdoNE0vM2V4dTc1RjdyLzBOZzk3K0RMakov?=
 =?utf-8?B?SHdhRWZGeFQ3aGhIRlRDaUFtTTdjVGErd0JOMXl5elJQeVhrZFNCbmVOTjRX?=
 =?utf-8?B?Q3RuVVZsNGNqTUZGb1JtWEIyZVBWNHVWWGhjMXJCNjJJcEVVOWpNK3MvZDZu?=
 =?utf-8?B?M2ZUVGFlWTdMeDRQSGlweWJYWi93bWpkOU9LbFFUeW9SUHJKMHkxRW1aeU44?=
 =?utf-8?B?ZWJmOEhsWU1aMHVEYVZmd1FPSUZDdzdXSWtRZDZhemt0NnBBN3hFVWdQcENL?=
 =?utf-8?B?NEJjb3NRMmpML3htOHJyN000Yk5lajRESzhER0Zsdlc1MU1kQ0xlczc3eVBs?=
 =?utf-8?B?WWhDVTZXaDNobUJUcXUrakw5akRwakxmYWRsR1BLVVc0cWM3THdFOUlOb1Vy?=
 =?utf-8?B?Z1grM1FiY1d6a1BHQ0hGLzF2ZXo5VXcrRjRuakkvRlJSRnAwb0l3V01XM3VQ?=
 =?utf-8?B?V01VYTUvMEVGVHVKdUZPOFgzWlNndGhEcFpWOUlCanc3Tm5aU09EQVhFaWc5?=
 =?utf-8?B?aEQxMzZtSjk2czdPdkwxUUdCRWFOa1hFcXJRenhoRjZEdVRWbTRITnBQejNG?=
 =?utf-8?B?VUVyalZKSkZVakdOd1JXZ2FZNkRHektuRlFpQm9OSWpLVDk5VnBqaWg0bmJE?=
 =?utf-8?B?NmxhVExvSmRRT3AwdXNFV1RrNjd5cFZYa0JCZjRRSlhYU0h4WjAyNmxXdkFl?=
 =?utf-8?B?UngraHhrcytFZkdrY2NKWkNQWnR6NWlTK3YzK3FBeUQ3SnhJY2l4a01YSnF4?=
 =?utf-8?B?YmF5Q09VQmZLenpCdGlETlU3b09QSnJoMmxyUjZKbWQyaWNQQUVBUEZCQ0Rz?=
 =?utf-8?Q?1QwWqc1Oy3A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVRMys2anI5N0MxRy9jZm9YTlc1blZkTEZCZy9qYVlJYVNoUlZndElTMWxk?=
 =?utf-8?B?cHdhOGN1RlRmNVo3T3M4dGg5alRXb2JZaVRUMFFHT2N2RUlIME5FdEZzRHBO?=
 =?utf-8?B?SVVua20vN0dQZGEvbWpLWTJIRE5hcGFqR1B1RHdpb205MXZYMDFYSGRTcFd6?=
 =?utf-8?B?a2c2aDJxNFYySDJQVFR2NGpaZWxULy9WUGg2SmpML3BBMW5aRkNlOUU4eUZ1?=
 =?utf-8?B?OW14M3FCcHFsbUI5cTF2eVFoSi9yRzdocDQrZTYvOXZUbFRMY1V2QjBaeTZT?=
 =?utf-8?B?eUdRaUJKZ0NnUFRCUDJHR1p2d1RnNEROdEtGTnhtOW4rWk54SHltU3ZiQnVY?=
 =?utf-8?B?enBHVytpVlVGYXpJMkdvTjdlZGhsdVI5U2VkeXN3U1JiMTUzYXM3UzE4RTVL?=
 =?utf-8?B?TU9KYnl5NFoxV3d5cXlvRkNPZGVtSlovbUFVM1ZhNUlyd0hPYmtmQzdXa2Ro?=
 =?utf-8?B?Zk5aMWhja2w4ci9RODdXZEM0T2dPYkJGVUNiV09NK0plRnBLbTYyMjZLMkFE?=
 =?utf-8?B?NU9vKzUwRW1aNTAvekI5eTJiczk0VENDNUFVSXJLNUQvc3loQkdVSTZ0ZXBs?=
 =?utf-8?B?MDZYd0tDUVhGdGRiQnFOc1lOQ1dCVHZIWTQ1Um14cWp3cmRZeENZVmpNMTF0?=
 =?utf-8?B?MEtGaFRyUnpYUFJLQ01hV0R0ZGN1TGl0SmNMQ21HSGVHMUtBU2dBdTdpeWdk?=
 =?utf-8?B?YmxkQS9TYk9SYnpsMDBGeTU1L3l3ZDFPd244c3FvdlRKSjhtY3pqaWRCSzhF?=
 =?utf-8?B?WVBDL1BkUGx5N21jWXo3VFZSMnRIRnhLWG1kaEt5SktHQS9WcktOOE44Z1JQ?=
 =?utf-8?B?Y2phdnVjOURnbGdHREx0dkNGdHFhckpnVEhrWFh1Tmx1NzdYUHFhcWwzazdu?=
 =?utf-8?B?VmJkTmw1MGtjSkJDN1ZhWmlqdDdaMjF6Nkw5RloxNXlYS0hTL3BudFZzbGVU?=
 =?utf-8?B?NzlHN1h6OXVRU3ZSaU5YZlRCUXNweU1PTzNrcXppbmJabDVNUW1SRHZmdzYv?=
 =?utf-8?B?RjNIUEhaRlpNQk1BNmt6UDBEV0x3ejFZNHVkdDJ6MmRRaFVtUFVvd3JzRGdO?=
 =?utf-8?B?d1JWeUkyS2VuUVpEZ1hqaExLMTBCZlo4MHZzZHFMTjlxTzJKYVJ6ejJCb1JK?=
 =?utf-8?B?aDdOQm53UElPdGtFVjZrNEVQc1ZxYnp3Rmx1Nnk4NlhSMTd2VlhYSzkyMW1H?=
 =?utf-8?B?c0xrV0xMcGo5WDRCVzB4Q0tuQm9CVTJwZ3kyQkN3K3BtMUk2TDd3ZHdjQUo0?=
 =?utf-8?B?TGhUYlFzUnA4QVFvRUVSZCtuMUFpMTlnb0pqQXNvNk81WXhVbHdNbUQxaFhM?=
 =?utf-8?B?bkM1OFlFL2J5T2dkd09vd21sdDJNZmMvZGhFRUw0Y2ZtU2JuRVJzaXdDZVlu?=
 =?utf-8?B?ZEN5WnozeXZDYTZQV3FCVU1GYUd2eEd3N1FZTzMvUjhrbVdrajNieUJFY3VP?=
 =?utf-8?B?SU1pdUgvVytZMkxuRWMwZnpKblpuSmlzOHk4TFFvVmlwRHhHL1RBbkRwVGFE?=
 =?utf-8?B?MGd1WjJQNmJwcEg3ZjRyaCs4NUdPanp4SVk0d1FMeVMzNEF2bDdUOWtHd2Za?=
 =?utf-8?B?bGJXbnhSQlNncytnSmJQb0hhUlUyNUdLMFB1WkMyYU5RdnRaYWZmL0kzWkZ6?=
 =?utf-8?B?NVg5cVZKb1U1Vi9VQ01GcWhvQUpDUGpTdDdBSGdIYUhaN09kRVRWeEI5RmFi?=
 =?utf-8?B?TEJMNHFYbUV3VWZEangrdWpFR2hGZ2xma3dEWXNqMU41N3JoN3FQMzdKa0NU?=
 =?utf-8?B?TkNHYVg4TEpuU0JZdGVYUTRPcUM4TkN2ZkRDWVNrV0JuWndMQ1V1cXlkdzU1?=
 =?utf-8?B?SXozSGt6ZW0wTS9UNWk0SnlJdTNIeDdmS1RqTzdreE1scm4rSlpUQ211dmNT?=
 =?utf-8?B?dHJrN1ZUaHNBTEpZRjY2ekRXVGZ5dG9FdERvL3VoWFI5aXI5RFRTb2VCMjg0?=
 =?utf-8?B?OFVsS1VWWExLS0NaY1pKaHVPQzJDQ3Fvd1hvNGkwS1NYbGdONjFoOHZuK0ZD?=
 =?utf-8?B?alJ4U0tPc3V0Z1FZTGN4NHQvK3Z6ai9rTCt1VmxtdDZySDZ5bVVOd0tGdGhU?=
 =?utf-8?B?WUNoQnFldzg5L1o3L1c1UkFvVEFCUFZCRkI3YTdJRUMwODVjTTNMa3lrblpm?=
 =?utf-8?Q?Q76HOYFTyUoe27sm5xSlsoVeU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc4adca-707a-47c6-81f2-08dd7c291580
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:23:25.4660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBIHr1DLu4C5TgWk/zOVccY48kSq6CEYWoQzHw3a1HMaELCgFTV/xkWh30bAcdqU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
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

Am 15.04.25 um 16:18 schrieb Arvind Yadav:
> Mesa passes shared bo, fence syncobj to userq_ioctl.
> There can be duplicates here or some fences that are old.
> This patch is remove duplicates fence and only keep
> the most recent fence for each context.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a4953d668972..9a09d545ceb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -25,6 +25,7 @@
>  #include <linux/kref.h>
>  #include <linux/slab.h>
>  #include <linux/dma-fence-unwrap.h>
> +#include <linux/sort.h>
>  
>  #include <drm/drm_exec.h>
>  #include <drm/drm_syncobj.h>
> @@ -584,6 +585,24 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  #endif
>  
>  #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> +static int fence_cmp(const void *_a, const void *_b)
> +{
> +	struct dma_fence *a = *(struct dma_fence **)_a;
> +	struct dma_fence *b = *(struct dma_fence **)_b;
> +
> +	if (a->context < b->context)
> +		return -1;
> +	else if (a->context > b->context)
> +		return 1;
> +
> +	if (dma_fence_is_later(b, a))
> +		return 1;
> +	else if (dma_fence_is_later(a, b))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			    struct drm_file *filp)
>  {
> @@ -840,6 +859,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			fences[num_fences++] = fence;
>  		}
>  
> +		if (num_fences > 1) {
> +			int j = 0;
> +
> +			sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
> +
> +			/*
> +			 * Only keep the most recent fence for each context.
> +			 */
> +			for (int i = 1; i < num_fences; i++) {
> +				if (fences[i]->context == fences[j]->context)
> +					dma_fence_put(fences[i]);
> +				else
> +					fences[++j] = fences[i];
> +			}
> +
> +			num_fences = ++j;
> +		}
> +

We already have the same code in drivers/dma-buf/dma-fence-unwrap.c.

I suggest to export this code from drivers/dma-buf/dma-fence-unwrap.c and just use it here as well.

Something like num_fences = dma_fence_shrink_array(fences, num_fences)

Regards,
Christian.

>  		for (i = 0, cnt = 0; i < num_fences; i++) {
>  			struct amdgpu_userq_fence_driver *fence_drv;
>  			struct amdgpu_userq_fence *userq_fence;

