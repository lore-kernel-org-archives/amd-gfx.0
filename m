Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE44CC3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 16:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508D510E326;
	Mon,  5 May 2025 16:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPAGEPSH";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBC7E10E326
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 16:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioQj/gQXfnasar+j0MU4vH+FA30yqca34b0NC1eRrsrFVxJiSuI50l8TvK/RV5mfz1pEgU8nmKaKOVlKJUXkNPubwK0ocGcXx/U6GcszDRphBhxYlejDm102OVR5YEEgtoCid23JPgnNav1eFfRyTsFImgg4wRWH5a0sjCWqOK5o5OdUO6fPec28efTVLINGdCCA4NdKkMfp7dIVW/oaqtGp2oihXthucWpytt+qrGZkkYRAcyQ954hT1dEJC/QY2pken2HaQ6gOiPB8wM7KspBD8mCpi8VkWhe2/YoMwhExDJB0ccaNJugeTGlPxCgYROgcy9qzylahvr0aj9e7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjABu9aFFItZuq9q1R/8p0ndFopDzENNik/kE+3E37c=;
 b=dHFNOjDhA4XYAhqIi6EAh8pvimcqqDD6bW3/bBm4NR80JNVmtS1lzPbmah3CV0C+O5xHirFzV29VaFCGyIO7Ynvy9cQJGuEdDQRlYb9Qjoq3tVAXfSzAbXjBRzs44QouUVDvoNsjXlzI1dTYVtwTKa4zXwTsJcgBU8FeqF29rg0133yAyyifvRtanzGCqgvsFZs7vCkSBS7eu0c84d6mRGq6+sgOf9WtRyEvuShTcpE/wIdzK60bcWt0qd7BRi3CgYyNQv4QkKJqieOS80bDpzsQ8sjkL5G1N1ksPDh0Pj4ZxjWNoxZTyq7MaN4PJIUC7WY/WtkzCbcLjx4StU3SgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjABu9aFFItZuq9q1R/8p0ndFopDzENNik/kE+3E37c=;
 b=VPAGEPSHPAJoMrVWrvosZR8KW9qKlgkszunrXQt6Cs54muvC3JfSzcp60ZGRHxklIkVgn7oVJ+dasgaX1vZXs0foUyJDg9xp+JyuNmZrJ230V7BKpj2n8Su+5UzufbA5hDWr9gQRah33m3dJsekDhP+dDb8dhcPvPUlDQyVcMRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 16:32:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 16:32:31 +0000
Message-ID: <3417c8d2-459b-40dd-ad09-5757bb279935@amd.com>
Date: Mon, 5 May 2025 11:32:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amd/display: Use optc31_disable_crtc for DCN 31
 and 401
To: Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250504221154.409695-1-siqueira@igalia.com>
 <20250504221154.409695-3-siqueira@igalia.com>
 <41016b22-d09d-4cdb-abca-a2ab016e47ed@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <41016b22-d09d-4cdb-abca-a2ab016e47ed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0094.namprd12.prod.outlook.com
 (2603:10b6:802:21::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d95a54-e209-4f00-ff00-08dd8bf26ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0w0T3k2UFpRUm1McFNlNjhRclp6LzVJZUZxMTdFd1RhK2xUOG1oQ092Z3JC?=
 =?utf-8?B?VktQYkZqaG1mai92anRqNWdBSjg4Y243UEhYbHF6RjJ2cG9DWkV4aExPMHJu?=
 =?utf-8?B?QW12VUtkcVZEalBoVzVJeUhHZFYyL2hjUFBFeEpQdVlmWjBtTmhFd3hJMjlo?=
 =?utf-8?B?T0ZHT1FOTVd5OFJUR0hMRy94aHhsL3hXT3JNV3NDbTRjWlJ2ZWsyM3hNUkZp?=
 =?utf-8?B?VEM0MUtVeVRBVWxTcEg3RUhLbFlzaHRPWDk2ZVVBMjZ6OUtZVnJkVExvU3NG?=
 =?utf-8?B?NUxHSjJTbFVyKzdGS3RCbHlDbHIySEpDY2tnNjNrNHovSUZLSjF5Sjd0aFhQ?=
 =?utf-8?B?K21HYWg1L1AwaCtMd2tBQVpWV0J5cVMxVVNSZnFmZ1VBTlpIN0tEUWcwZGZu?=
 =?utf-8?B?TlhlbzBkODVVSnIvbWkxT3RjTGR4bWRsOGEyMVRWbEFMcVl1OFp6eGsvUm5r?=
 =?utf-8?B?RkYvWmhLYndBLzNtbWwxbG5SeXM1NW8ydW5WQmo2ZmRGbE1GeVpXYnRTY28v?=
 =?utf-8?B?aHhXRHNUYytSSmMwbzZmUnVsaFYwY25SV1BqMTRUWTZ0T2puMExJMksxK0Y5?=
 =?utf-8?B?RitFUElXWHRoUlR2ZmJLSDlQenc4OHZzakptYjVvV1U0citjL1NTODExN3Rt?=
 =?utf-8?B?QnRpQ2RhV3V6THJaSzZuZ2dWVU9BQldqOFpucWRNNGhJU2l5cTh6b2pMc3FJ?=
 =?utf-8?B?NVdCTWFTZzdpdUR2S09lNG1zQVdCR20rVER5S3Fsc1Z5NnlwRUl1L3I2bEI0?=
 =?utf-8?B?aFFaRStmcVYrUVNrS3JwaHFpeWQ5VXp4aGhOa1ZVNXhvbWJFbktiWU82TTA4?=
 =?utf-8?B?V0R6ajE2cWVFcndUR3J4YlFmQ2JmaHltMzV4RkxMRmZWK0FCUlJCbWZMdjhv?=
 =?utf-8?B?S3pxODdyOTk4VEZ2VDV3cGpOT1dUd290UEF5MzRVUEZoRmJZcUhicUh6TzZh?=
 =?utf-8?B?bnpxTWUzYXh0ZC8xWjErWU5uUkhkOW02OEZheDd6eUh5Mk9ZNWV4dUtrR0M2?=
 =?utf-8?B?NFQ3WkVPNmFZM0kxVVJ6YkYzdmFHTVlnRXFhQXVKYnh0endvcWpvOFY2QzF1?=
 =?utf-8?B?QVZtREJzUW1lczBuUTFibUNlOVBvaHJwcXQ4Y3huOTZYT2FDZmJIRTQ0SHNs?=
 =?utf-8?B?VHdqRm1KVnl3U3luRnBKNmZIc2RPSEFITlUvUDlJaUttdE05STlWTmNhYzRC?=
 =?utf-8?B?WHJCYWVGY0wwK1V0NnZ0UUpCWm5UMnNmVTBMUUVudVI1R2xnTEtOd1JOVGha?=
 =?utf-8?B?dFhxQnpRbUdJZHJQRm9lWGRoU3YzWTRwTkNDcUIvRXBNRE53cEtXay92b2ph?=
 =?utf-8?B?b09RVmF4YmFrSGg0TXNYTGdNa1ZmTXdiMmw4cWV6TmZicGU5T2lYQ2pZU0ND?=
 =?utf-8?B?TkdWOTZScE9zQ3ZwZ0Z2eGljQ21XS0kxd1QvS253MkVERXovNnlXOU1qMWtn?=
 =?utf-8?B?cFB6SDhocXoyelJoNE83SWZmdWlwWDNrWU14WElIT2xScEZ2MGxkOUR1b21u?=
 =?utf-8?B?SnBsNDVhYjF5NHZIOUxXa3M5eUNtaEdhTW8raXhJZlBsdndqOUlEREprdkF2?=
 =?utf-8?B?cHBzNWhsWEQyRUFOVENvTFVVQUFzSlpGRGFhQjFZcXRPUUhIUkZGRG40dnNE?=
 =?utf-8?B?bEVZaUxqQktKQS9jV2R1Q2lNZ3ZQUng0UTAvdlBkenhpNmh3SlFQd0gzbGJD?=
 =?utf-8?B?dFA1Z3J6NXVjbzFIZU1tWnJmanpWU05uOEFXZVVPN21pRUVqTWdZdDh5UktN?=
 =?utf-8?B?MjlOaEpLZVFlODNmVTFURFJpak1SMEpTdkZ6L05TMWs0WTBudmhpN0gzaENT?=
 =?utf-8?B?TXppcWMreGVpQTJiSUdpcFdreGFOeENOWm1xK0FuekV3b3VPTTB3eEdHb1c4?=
 =?utf-8?B?MU1YWUVLL0xzODA4eUZEdVpGOS9veW1oRzdiakhZN1NEcWVTT29ZZ04zTkRQ?=
 =?utf-8?Q?GimaUbG+0pY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujdma3JNeEZqWjZmbTh3bk1oYXJPYmhNeXA1R3RWaGs1eXF4S2lQSlZXN2ZU?=
 =?utf-8?B?L3FqL1ovc1FZZVZWczZCS0hBK1F6YmRaaS9YSTVtb3JYQjcxeVhNMjBxVXNT?=
 =?utf-8?B?UkFsU2dHbm1Pd0dnNmthVUVUU1pURkxDTkxyYVU3c3lpbU55aVA2WWpJVE9w?=
 =?utf-8?B?S3Z4ODdSRGtXd282OGtCdUpmSWpHQmVIclBZUUE2MmJGZ3k5NGY4S3RlQld1?=
 =?utf-8?B?eVhLc2UvWTNIeTVaVTVZalRJNDFET3pVbzJ1Qmo0eTdnTWdTRlA0R1ZGS241?=
 =?utf-8?B?L0s1RXF3andneXh0WDJjYWR0SVdHREZmU2NIRktWZHJoVW02ZEd2Zk9WcDQz?=
 =?utf-8?B?eUx5UWo2Q21WZWE5a0w5NnVzY0Y3ejJ6L2kyR2RvUis4SmdIcFJVdFdwSUxG?=
 =?utf-8?B?dERDSGdGRXROSGtQOU5JVDBDT1dIR2ZDU2VPSmVMbUxxc0xPUStCd05CLzdT?=
 =?utf-8?B?eE9ZZG4zT1NJc05JNG05a3ZvRjgrRVB0YStxb2Z0bjJHRWU4UEg5T1lhMTli?=
 =?utf-8?B?VFJjc1lRNnl1RHA4Njh4YzRMY082R1JzVVJRYzVFekJSUStJYXVqWVlJZXBm?=
 =?utf-8?B?eUYxeE11NmZuOW41bVNIdmxEUUVXUmtrV2h6aHFlNStuY1FETXJPWlNiSGYv?=
 =?utf-8?B?UXkzeEFHVWFSVnh1OHczQmc5MTBvcm04cFVOb2hjZUgxUUcrVm1zZGszeFht?=
 =?utf-8?B?Vm9ad1JzcVpzdUt0WEUrY2J1VmtvS2RBYU1VL2xnNGVIMVJxbXNDNUlFeG52?=
 =?utf-8?B?K1JiL3pya2NkQitNMSs1b3RPSjkxUWhNUzJLNmwwWlVpY1pqUS9nTUNGZnpG?=
 =?utf-8?B?WXI1ZjIxTWdoLzh5Q3I3UFBhRlp6NTlQUWh4TEhjMWVrNVRIVmF4NFBKOThN?=
 =?utf-8?B?T1NlUEIyWWdOMnBnQzJVSUJYOGtaS3l6azBKVXBrd1c1enNOT2ZHM1IzM2tt?=
 =?utf-8?B?NnVNckE3OGdMdmtvelExTFdXZFZWdEtsQ2NIZk5XTEV2VnVtYTBySlZ2OHM3?=
 =?utf-8?B?TW1MQitudDc1ZmRwdWR5LzZWMGY0U09CN251dHlUd3k2YkNwbnJHekp5dllo?=
 =?utf-8?B?QzZwTHA3NFJUdFVnVGJzaGR6b3gvcE56UGFxcnJyV0ZWMm9QdmpVdU0wVmVE?=
 =?utf-8?B?M3hYb1NrN0ZoUno4d1oxTFYwRkVMUzYxeWxFTm12d0tmTXpGbjVCcy9JWFJZ?=
 =?utf-8?B?ejJES3FkcHI1cHl5N0RyNVRRaVEzeEJjeU5GRis1MTVhaDZQTkhBMXAwNzNh?=
 =?utf-8?B?cmxTdkswL1ZpU3doQWEwNnJjTGlUZCszNVFYNVlHQ2hkSlpGS1BRRTBTckRG?=
 =?utf-8?B?b0tLa3FualZ0ZFRZdFl1VFFWTnlsMGdJcDV2ekJPZVNKK285K1M0QkE2Ulho?=
 =?utf-8?B?Y2RvWGxTN1ZGNWM5RWlxOG9uZVZObWlYdXJWM0hGOXQ3NWw4NWVQQzFDZVBo?=
 =?utf-8?B?cnlxdHE3clQ3RzVZU3VRS3BBZGw0bXVTWlhjY1kwa0lOeEhRcDU0dytjMitJ?=
 =?utf-8?B?NERaVEZsS21VcW9yWVdZbkVXZ1RxOW1ORndTRU1SODVuclZmcDJmS3pvT0lB?=
 =?utf-8?B?VWh6blcwSzkwdUhvQVpreHM4c0hLYjRmS3Q2R0taVzhKem5TZ3UvK1Q1RVlW?=
 =?utf-8?B?TGo1cTFmcHo0aENtQWFRNTF5dTJYZm5DUjlSYmlsMm1UamVTL2dqa2Q3Mjlm?=
 =?utf-8?B?MjIrdmszYTJkTlhFY3J6V3JzazdKam0zcWJxV216SlBHZUFTUm5BRWxFeXIy?=
 =?utf-8?B?QVpEWkhUQ0t6cEpYMHlTWmdaR0hlVzlWUUYrZ2VTaGJ5cVdGSzdiMHhEcjdy?=
 =?utf-8?B?ckZzQmQ3UmdQV0VISkNMWFNyUno4RDhuSG40YU1RbUNlRnJHbDVKZkNiZHZ5?=
 =?utf-8?B?NXhYeVlNK2pCbHVtQTkvZGJTeXUxeXpvdHFTbDhFRHREamZLTFc0MERtaHYy?=
 =?utf-8?B?RGFJVWhIMXFxM04rQzVmTjcvdm4xVUNmSTlsNVZVUzExSnNZcGtEcVZEZkNJ?=
 =?utf-8?B?UU91ZStaNG5DMWZUWm94aTJpQ1ljWkJmSjVtMFd0Nndja2phRCs4U09rdm1G?=
 =?utf-8?B?TzVaZ01aMzRsM2NMazg5V25Kb2Z2VG9GbGczc1hxNTdVdHdFamFCY2h1MFdQ?=
 =?utf-8?Q?7affPxhKbBaUIiHR6fnMsuCCC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d95a54-e209-4f00-ff00-08dd8bf26ea8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 16:32:31.3412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiS//oHNEtN8OCAvk4YtbZv2JTMdp7Qy/z2OVRd6UuuDE6O0qz5wlAU5ZXZNshF4AUzMQik+Jxtn6bWDi2CQFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658
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

On 5/5/2025 11:27 AM, Alex Hung wrote:
> On 5/4/25 16:11, Rodrigo Siqueira wrote:
>> DCN401 and DCN31 share the same implementation for disabling CRTC. This
>> commit makes DCN401 use the DCN31 implementation and removes the code
>> duplication in the DCN401.
> 
> Hi Rodrigo
> 
> optc31_disable_crtc is not the same as optc401_disable_crtc. Please see 
> the dfiff below:
> 
> < /* disable_crtc - call ASIC Control Object to disable Timing 
> generator. */
> < static bool optc31_disable_crtc(struct timing_generator *optc)
> ---
>  > /* disable_crtc */
>  > bool optc401_disable_crtc(struct timing_generator *optc)
> 147,148c232
> <                       1, 100000);
> <       optc1_clear_optc_underflow(optc);
> ---
>  >                       1, 150000);
> 152,155c236,237
> 
> 
> However, optc31_disable_crtc is the same as optc35_disable_crtc (patch 
> 3?) and optc32_disable_crtc is the same as optc401_disable_crtc.

Is that last argument a timeout?  How about just extending the timeout 
to be the same for all of them?  That should be relatively harmless, no?

> 
>>
>> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>> ---
>>   .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  2 +-
>>   .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  2 ++
>>   .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 34 +------------------
>>   .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 -
>>   4 files changed, 4 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/ 
>> drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>> index 13c1f95b5ced..e6246e5ba86f 100644
>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>> @@ -125,7 +125,7 @@ bool optc31_enable_crtc(struct timing_generator 
>> *optc)
>>   }
>>   /* disable_crtc - call ASIC Control Object to disable Timing 
>> generator. */
>> -static bool optc31_disable_crtc(struct timing_generator *optc)
>> +bool optc31_disable_crtc(struct timing_generator *optc)
>>   {
>>       struct optc *optc1 = DCN10TG_FROM_TG(optc);
>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/ 
>> drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>> index af67eeaf8505..db7e51fc787e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>> @@ -267,6 +267,8 @@ void dcn31_timing_generator_init(struct optc *optc1);
>>   bool optc31_immediate_disable_crtc(struct timing_generator *optc);
>> +bool optc31_disable_crtc(struct timing_generator *optc);
>> +
>>   bool optc31_enable_crtc(struct timing_generator *optc);
>>   void optc31_set_drr(struct timing_generator *optc, const struct 
>> drr_params *params);
>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c 
>> b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>> index 6eba48de58ff..f472d2efe026 100644
>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>> @@ -170,38 +170,6 @@ void optc401_set_h_timing_div_manual_mode(struct 
>> timing_generator *optc, bool ma
>>               OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
>>   }
>> -/* disable_crtc */
>> -bool optc401_disable_crtc(struct timing_generator *optc)
>> -{
>> -    struct optc *optc1 = DCN10TG_FROM_TG(optc);
>> -
>> -    REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
>> -            OPTC_SEG0_SRC_SEL, 0xf,
>> -            OPTC_SEG1_SRC_SEL, 0xf,
>> -            OPTC_SEG2_SRC_SEL, 0xf,
>> -            OPTC_SEG3_SRC_SEL, 0xf,
>> -            OPTC_NUM_OF_INPUT_SEGMENT, 0);
>> -
>> -    REG_UPDATE(OPTC_MEMORY_CONFIG,
>> -            OPTC_MEM_SEL, 0);
>> -
>> -    /* disable otg request until end of the first line
>> -     * in the vertical blank region
>> -     */
>> -    REG_UPDATE(OTG_CONTROL,
>> -            OTG_MASTER_EN, 0);
>> -
>> -    REG_UPDATE(CONTROL,
>> -            VTG0_ENABLE, 0);
>> -
>> -    /* CRTC disabled, so disable  clock. */
>> -    REG_WAIT(OTG_CLOCK_CONTROL,
>> -            OTG_BUSY, 0,
>> -            1, 150000);
>> -
>> -    return true;
>> -}
>> -
>>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
>>   {
>>       struct optc *optc1 = DCN10TG_FROM_TG(optc);
>> @@ -435,7 +403,7 @@ static struct timing_generator_funcs 
>> dcn401_tg_funcs = {
>>           .setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
>>           .program_global_sync = optc401_program_global_sync,
>>           .enable_crtc = optc31_enable_crtc,
>> -        .disable_crtc = optc401_disable_crtc,
>> +        .disable_crtc = optc31_disable_crtc,
>>           .phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
>>           .disable_phantom_crtc = optc401_disable_phantom_otg,
>>           /* used by enable_timing_synchronization. Not need for FPGA */
>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h 
>> b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>> index 8e795e06e615..be74fd709d43 100644
>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>> @@ -180,7 +180,6 @@ void optc401_program_global_sync(
>>           int vupdate_offset,
>>           int vupdate_width,
>>           int pstate_keepout);
>> -bool optc401_disable_crtc(struct timing_generator *optc);
>>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc);
>>   void optc401_disable_phantom_otg(struct timing_generator *optc);
>>   void optc401_set_odm_bypass(struct timing_generator *optc,
> 

