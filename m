Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD81C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 22:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A3C10E0E3;
	Mon, 14 Jul 2025 22:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aFIdKvqv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E4C10E0E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 22:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5b6QKREMUpwjZkGY5WmhqPQFBG0hIHjvFlb0or8U1pPsTm7u2M3nXlL256iHgZ/aXL89eImpDueUIb8OxGC7+U/MvXCWnebou0SDVYZ0/z06bYvSUKpqsRVwMpPSxvIC9BIo9SVxA6dY0FwDjwareEOoSeHcLkJnEZZ+kdYw5LS2XSboI8v9HvAtL6oHmMsM5rfotbMHY/FospDziFqO4eP39zdXkHuKdXxwsACfccba4ocYbIKj6nZdcJYgBoJIhHFzxsLwuh44d4L+uZvVJejQxu2lYT5DUkhBeYJRbmaCXXK+UASe6M5Eu0Tf09usFGndU9x9qlUV8ilPVu+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH6vixqsioLmecRs7JPsyy8ews+TfU3DUessEpcUSlI=;
 b=ya1Olq+Ep09pB+bTjmlNazytjBqRgNuT5+Af1A1tGNeRdO/ef5/ADlQHjovwezfDKm1QLekni7x3dwGs2N4HoAqR1BQVpzkAMjtrOij6A3fE9m14qhWbVGLQp+D1O1OJ1zKipjWz92ZjJ+zsm7odIiITdohBeZPL0ycZV/ameMfGhXF8MezwzjjyY4SAsR7gY8VhrekX4RKcAF24X3+e4Q9yxTd9xqSIAT9nZmg0UWEqDSKJSo0oygtlPEQEMTzEu79tehuvTE+sfqBl+w8z/5X9G635ipM06vGx/BbiI4+OJinxUyhGvXTcsgPCTxHUa0hj7yOFKFMPftk9dYmvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH6vixqsioLmecRs7JPsyy8ews+TfU3DUessEpcUSlI=;
 b=aFIdKvqvtbJ9tqE45T663Pw4ZRCAeWM7skvTx7IigE7pcO04KkoXe+e1vtEn0fxDI3FsgPvbaWc9SoESEuOMrgkTCl9/2o4F8uLp2W2wz2X/l7B/P+RtSDU0CjeKF6gorbFfyzfpBeh7AgXddhV+hbEE1cl5a8KzXvE2tfVCfCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 22:40:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 22:40:31 +0000
Message-ID: <880855c5-dede-4497-8ca1-916bd0dbd08a@amd.com>
Date: Mon, 14 Jul 2025 18:40:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: rework how PTE flags are generated v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 david.francis@amd.com, amd-gfx@lists.freedesktop.org
References: <20250709125119.1606-1-christian.koenig@amd.com>
 <20250709125119.1606-2-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250709125119.1606-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0377.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f41cbb-6b53-4388-d7fe-08ddc3277032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmdQciswWitocHIzUGsvUTJRWlp6VHBHeFpUZHhLTXFnTG8zei92dWcvR1F2?=
 =?utf-8?B?a1JqSldjNDhQanh6R0FCS0c2dkduT1dOY2oxWGdYWDFsZTd1TkhEVDdwSk9m?=
 =?utf-8?B?cVJWM2gramxXRG1TRnYvblh2NTNLQk9TZU5EcGNrY0E2TDRZbnBFK1VJZEIr?=
 =?utf-8?B?RWwwNHJtd1ZiQ090R1ZKZ085bDBJRVZzaEdlTlkxakhUNjB0aXV5SGR4MWdE?=
 =?utf-8?B?dlZ3bzR1MUM3bS84UVhEQVlrbXhNam9LdTc1TGtpTnI0V1lWUE1kNUhmNXJ0?=
 =?utf-8?B?ellnMzJpQXo1L3VPakgwNGIvQW5wSitYWDZLVnR3aVNHQjRhU1pOMUd5NWZ6?=
 =?utf-8?B?SFM5aW9nNkZtQWhYVWFlR3A4R2VESld6RjlUSzlSQTVBbVRRajJaK1BIL01v?=
 =?utf-8?B?QlNJY2s5cWNrTmgxTmJOWUM0MDlLNmZuQ05EZGt1Y3c0aWNiMW9rSnJFaTlO?=
 =?utf-8?B?T0s5VEoyQ282TVdnOUtnN0haUGkzMVpWUy9HWXBGZmF6SmxOYjh3NWprUHVL?=
 =?utf-8?B?Y0NuZnRpWXltNmRSTEkxSGlDcDVwUEpWdi9MYS9KYVEvbWhxVDY4bFVNYy95?=
 =?utf-8?B?VTdpOHVaeGxWbnUwUjBBT1Ruc3U2OE5qcVNLNHg5cEg2WENMUGtBSVA3aDlE?=
 =?utf-8?B?aEZCcjBrRjIvL3VqQXlvb1pqd1V6K2E0QjhDcWZTcUg3OVpmK2x4NElPZzB6?=
 =?utf-8?B?SmVlWjlKOVY1M3NldkZNUW1nK2c3eW1ESmF4NlN1eGFvWjdUZURSWDNFS2xT?=
 =?utf-8?B?QUtKandHcnJRZ2NWWG9qeDFWTzJ5SExhOEt1ZkR1NzlyWTd5ODRrZUtlRzEv?=
 =?utf-8?B?STJHcnBlWVhMdUNidTYxdnN2WFpSYjcxNE1sQzF1TVpUS2FNWHdyTEZ1STBE?=
 =?utf-8?B?dVhFcElCaGdPNEJyemNtc1RWMjZ6OHdBSTZiaG12VHNHUVZvYkFyT2w5cWdq?=
 =?utf-8?B?UENLem8rbE92YUJpSWluVm1BRTgzakdsMmF5SzZ0S1RUQUFZNytLT3BJSDdm?=
 =?utf-8?B?L3VLT3BSbDUzNGpMejBlSVlPeTdTZ3I3THk0Ymxlc2lmZnBQb3h6dE8veUxH?=
 =?utf-8?B?MUZjTW9yMklvYjI5LzNON2xKKzZ1VERSVjFvZlZTaVNkenFBWWJwbHp2WnBM?=
 =?utf-8?B?ekhkdWhEV3FIZk43MWhIcXk2ZEhCNkRIYW52RWpMYmNwb2hhOWk1dlJmR2lt?=
 =?utf-8?B?Q2NmQkNDaGlMMGVZWUJ1eVRUakRoSnF1TjZYWU1WQ09zNjJacEdhMWN2eWpk?=
 =?utf-8?B?cGMwN3JuWW5LSzUrdTVGK0NXZERmOFQ4WVpTeHlOanRVV3F0K3ljWEloNHNE?=
 =?utf-8?B?cjZTVSt0bzNEQlBNU2JwcGxhS2Q1NjJXTVloNkdQQUJjUEttUDNpVjZ5VG1p?=
 =?utf-8?B?R1FwRHNTZVNSUTNGN0M1REQ1Q2piU3luWmhjbmdObzZFYVFpcXIwQStJSzlm?=
 =?utf-8?B?dGpNUVZGL09BR0xpaGR1clQ2RU9EemZkM1BoeHZjZnNqR0taNEZHNzVJa0FH?=
 =?utf-8?B?QUtUbWZvRmtmclRySDNWT1djQlR0MjNrc2s1WG5XOFl4NEhYUUJrc0cxdUZr?=
 =?utf-8?B?dG11Y3BOdm1hRkVxcGJnY216MEc4Mm0rcHQ5M2swVWZGaElvd05rRnovTTZQ?=
 =?utf-8?B?ZFVQN2RSNWdvbnN2L3A3MXV6MUFKbnhoQllrdy83Y0FpODhsUGFlWXlGbC9C?=
 =?utf-8?B?TVhESDFwelF5cE5nT3VZeGlPTVo5R3RaRWR2OG5lY3ZUVTQvWkQwc1g0dVJ5?=
 =?utf-8?B?SUdDcVkxODc1T3M1UjkzSjhveEl6VTJraFVpTmhYYk8vbjlrVXRhMm8yRi9r?=
 =?utf-8?B?SktadHFlS2Rkd0JmM0JqVDd5RzBVU0c4L0RTRG5XdkFRWjZlODcrWmc2UnBh?=
 =?utf-8?B?Skl3aGp1bW9pdGVJZjRhNDlYeVBXTlc0Zlg4ZEc1WmVWcWFCZC8wSG44MEVi?=
 =?utf-8?Q?0A/cJzuQlfA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE42UkZZV3ZtaUJTVkVIMlg5eWhCeTB3Q0hUNndnbk9CVS9oWS92ZmVqTWF2?=
 =?utf-8?B?SEZnZzB5Sm1nNXp5THpCNXo0Y0RRNHJGaE5GN1hJVjJpODFrd0ZBNy9SbU1K?=
 =?utf-8?B?NzlObXRDYU5QUndqZGo5YXl3NDV0OEJFU2srUzluMjRqL2N6NGhldEN3UlUr?=
 =?utf-8?B?ODRqMmI4SHR1TGZQYW5sS3dEMjg3NTIvd0JuUDhuSlhXK0FuRGw0SW1VUkE0?=
 =?utf-8?B?R1VhTjd3NUJXSDBrUjdlOGVpTDVnazk1YlY3RXRaakcxZkI5SXFveU5HU1c2?=
 =?utf-8?B?aC9kcDRwSkNPSHlSVmNucWM3K1pOUjNvTG01WkRRYWRLN3EvOHhvbzJGS1E5?=
 =?utf-8?B?bWZzZHRCeXB0VS9DdnFMMUVPQnNCTy8vQ3lVZlZiUkwyQVprK21HR3hUWmpQ?=
 =?utf-8?B?TUxwV2N2cGhUNjh6clIvVlFWbXVPcXFPVmF4Z0lweHhrb0F2R3JnbzVMS2tq?=
 =?utf-8?B?NnRGR0kwVU9COU5lR0JSMWxUTUxFV09LeXRqenNKUFBTNGJXNmVnZTN5OUF1?=
 =?utf-8?B?eXV2bWJrdDdiUmNXaTExTVprUVR1eWVXdVltTCtONkdwNVRHcnhHWGErNVJT?=
 =?utf-8?B?Y0xndnJsbmk1YWV0L1F1M2pWRk5RZzhOdXZGM1lISUdhNWV0M04zQko0Ymdy?=
 =?utf-8?B?Qkp2UkhmczJOZ3cvVGlwU1VpN3ZoV0U0ckJPM2ZabXFiWjJXK3NpVU5xYlU1?=
 =?utf-8?B?KytJMm1sbm9sVkN1d1RzQjJMR082cHlyZnk2SUVnVFRaNUdsanBUQ1diU0FE?=
 =?utf-8?B?aXZGWTM0STd4MXN1eElwWFNIdjIxQStBdlZhTEJGMTRJYkUvVThOWXBJK1BI?=
 =?utf-8?B?U3lwUXRrRC9xVEdBY1NVbWRsMjRNSk1zVDhVV2pLdERyN0RHb3V5VFlwcmQw?=
 =?utf-8?B?aTBBdGE3OEprVUxkUXdaUjdQN2xqazdUY2M0dHFBS0F4czJueEM5Mit2SVRY?=
 =?utf-8?B?RXpzL3A2eEhhNXFYZ2o5RkxpVFRoSGFqZnVOa3FvRCtKTVFxWDhYZGFNUzQ1?=
 =?utf-8?B?RHlGNzZGazYvMDFUM0JmaHhNaURZNFBCNE9BS3RFMHM1Y0llaGg4MWQwL0hr?=
 =?utf-8?B?NnplMEY3QlI2QkQzSTViWGEwY0k2RmhuNmNPaVE0U29OamN3d2dkRFI2VWpa?=
 =?utf-8?B?QjBCY3oyRHFzTmFjWjdkRlhyYWtUZUthWk9ZNitjaXkzdWpVUWNldXZtWmxq?=
 =?utf-8?B?ZFYwV0twaG85cUlzTXFCeDJDQXNSNVl2RlB0MmNzS3JkUEZkd2pwcU9wcFN1?=
 =?utf-8?B?RmxDbGZkeG5ONmxQZGIyT0xiemZyTkhVM001TTV1VTJUcGhwWWM2YWhkL1lq?=
 =?utf-8?B?VkdrTDJJMUJsZ2FSTis2OFl2UHI1Nk50ZE5qcUY3alZWaGdXcHNDdVFNUmFx?=
 =?utf-8?B?NmNjck5vWmFMRDdJODlUY2JacmFmOXYrTmdJQkphNlFia3g0QWVpbnBjYUhv?=
 =?utf-8?B?SlI3RnF5NngyeTlSeit5S0k0Z0JIM1lreUZwb3FvVy9IZkxMdE53eERtd2J2?=
 =?utf-8?B?NC9CUHJYb2NrN3BKRUVEMy9QdmVPbVFOUGpzeHhuOHN4T3hMMUVSWCs2NmFs?=
 =?utf-8?B?TjZzUzRKUy82OHVzYW5kVjFTajFoQTBuZVgvdWNHT3c2U2FweDViaHJ2OWRa?=
 =?utf-8?B?bUVVSjR0aWtnQTFhVmU2K3gveFpVejRuYWt3THMreU5sbDRPUFRNdnNXeWVk?=
 =?utf-8?B?WW8yRzB5Mk95ZDBPU0drRjZaUGQxM1Q2eWJMM3pIb2NUQ2NET1NtSlJaN09q?=
 =?utf-8?B?anV0WUsydnRmbElHb3M1R1EyUHJWaFFrSVNsWXRiU2YyMzRpOGszc1RtdTlj?=
 =?utf-8?B?M0lmNUFxbDhRYmdZZS9jQnFkRzZjK21nTjNmTEhYM0JReU9zQ2V4a0lOTFFk?=
 =?utf-8?B?SXRQcURQOXBWWTRCYzNTYkFVWFNlZmN3NlRFOTFERTRNZThPa0xxeWIyZE1N?=
 =?utf-8?B?SnU1dFoydTJlYkRYUm5aWjdvZzZ0T0VLQ1p0RHdVTVEzY3d3bHcwVHg2MXpP?=
 =?utf-8?B?WmZoQys3NlZ5L0VGUVF0U3dLSXY4Z1NwVytvTjZ0ekV0OUdWOFJtbGJXZytI?=
 =?utf-8?B?TkNqSkNZSFBXNy9tQ1FFRjFRbDZ3ditjQ0ZVRVBQT1hhaWRPc2dXSzVFdXBT?=
 =?utf-8?Q?OVYpDqagRBo1+d18I1dr3H9up?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f41cbb-6b53-4388-d7fe-08ddc3277032
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 22:40:31.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89gizklcXEH4qnN4HPV28lM518OWecs3gKhw5t2mj1cFOsVvUQrdUB+oAwMhsQufThRC/SaDTuEOgSPyJUxL8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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


On 2025-07-09 08:51, Christian König wrote:
> Previously we tried to keep the HW specific PTE flags in each mapping,
> but for CRIU that isn't sufficient any more since the original value is
> needed for the checkpoint procedure.
>
> So rework the whole handling, nuke the early mapping function, keep the
> UAPI flags in each mapping instead of the HW flags and translate them to
> the HW flags while filling in the PTEs.
>
> Only tested on Navi 23 for now, so probably needs quite a bit of more
> work.
>
> v2: fix KFD and SVN handling
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  7 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 37 +----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 15 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c     |  8 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 17 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 57 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        | 57 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        | 56 ++++++++---------
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 10 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 61 +++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  9 ++-
>   16 files changed, 160 insertions(+), 189 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 260165bbe373..37d8a7034a7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -494,7 +494,8 @@ static int vm_update_pds(struct amdgpu_vm *vm, struct amdgpu_sync *sync)
>   	return amdgpu_sync_fence(sync, vm->last_update, GFP_KERNEL);
>   }
>   
> -static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
> +static uint64_t get_pte_flags(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			      struct kgd_mem *mem)
>   {
>   	uint32_t mapping_flags = AMDGPU_VM_PAGE_READABLE |
>   				 AMDGPU_VM_MTYPE_DEFAULT;
> @@ -504,7 +505,7 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
>   	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE)
>   		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
>   
> -	return amdgpu_gem_va_map_flags(adev, mapping_flags);
> +	return mapping_flags;
>   }
>   
>   /**
> @@ -961,7 +962,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			goto unwind;
>   		}
>   		attachment[i]->va = va;
> -		attachment[i]->pte_flags = get_pte_flags(adev, mem);
> +		attachment[i]->pte_flags = get_pte_flags(adev, vm, mem);
>   		attachment[i]->adev = adev;
>   		list_add(&attachment[i]->list, &mem->attachments);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b4cea08f4886..e3f65977eeee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -790,36 +790,6 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>   	return fence;
>   }
>   
> -/**
> - * amdgpu_gem_va_map_flags - map GEM UAPI flags into hardware flags
> - *
> - * @adev: amdgpu_device pointer
> - * @flags: GEM UAPI flags
> - *
> - * Returns the GEM UAPI flags mapped into hardware for the ASIC.
> - */
> -uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	uint64_t pte_flag = 0;
> -
> -	if (flags & AMDGPU_VM_PAGE_EXECUTABLE)
> -		pte_flag |= AMDGPU_PTE_EXECUTABLE;
> -	if (flags & AMDGPU_VM_PAGE_READABLE)
> -		pte_flag |= AMDGPU_PTE_READABLE;
> -	if (flags & AMDGPU_VM_PAGE_WRITEABLE)
> -		pte_flag |= AMDGPU_PTE_WRITEABLE;
> -	if (flags & AMDGPU_VM_PAGE_PRT)
> -		pte_flag |= AMDGPU_PTE_PRT_FLAG(adev);
> -	if (flags & AMDGPU_VM_PAGE_NOALLOC)
> -		pte_flag |= AMDGPU_PTE_NOALLOC;
> -
> -	if (adev->gmc.gmc_funcs->map_mtype)
> -		pte_flag |= amdgpu_gmc_map_mtype(adev,
> -						 flags & AMDGPU_VM_MTYPE_MASK);
> -
> -	return pte_flag;
> -}
> -
>   int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *filp)
>   {
> @@ -840,7 +810,6 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   	struct dma_fence_chain *timeline_chain = NULL;
>   	struct dma_fence *fence;
>   	struct drm_exec exec;
> -	uint64_t va_flags;
>   	uint64_t vm_size;
>   	int r = 0;
>   
> @@ -944,10 +913,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   
>   	switch (args->operation) {
>   	case AMDGPU_VA_OP_MAP:
> -		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
>   		r = amdgpu_vm_bo_map(adev, bo_va, args->va_address,
>   				     args->offset_in_bo, args->map_size,
> -				     va_flags);
> +				     args->flags);
>   		break;
>   	case AMDGPU_VA_OP_UNMAP:
>   		r = amdgpu_vm_bo_unmap(adev, bo_va, args->va_address);
> @@ -959,10 +927,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   						args->map_size);
>   		break;
>   	case AMDGPU_VA_OP_REPLACE:
> -		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
>   		r = amdgpu_vm_bo_replace_map(adev, bo_va, args->va_address,
>   					     args->offset_in_bo, args->map_size,
> -					     va_flags);
> +					     args->flags);
>   		break;
>   	default:
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index 3a8f57900a3a..b51e8f95ee86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -63,7 +63,6 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *filp);
>   int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
>   			      struct drm_file *filp);
> -uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *adev, uint32_t flags);
>   int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>   			  struct drm_file *filp);
>   int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 397c6ccdb903..57ad7a9e3747 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -154,15 +154,15 @@ struct amdgpu_gmc_funcs {
>   				   unsigned pasid);
>   	/* enable/disable PRT support */
>   	void (*set_prt)(struct amdgpu_device *adev, bool enable);
> -	/* map mtype to hardware flags */
> -	uint64_t (*map_mtype)(struct amdgpu_device *adev, uint32_t flags);
>   	/* get the pde for a given mc addr */
>   	void (*get_vm_pde)(struct amdgpu_device *adev, int level,
>   			   u64 *dst, u64 *flags);
> -	/* get the pte flags to use for a BO VA mapping */
> +	/* get the pte flags to use for PTEs */
>   	void (*get_vm_pte)(struct amdgpu_device *adev,
> -			   struct amdgpu_bo_va_mapping *mapping,
> -			   uint64_t *flags);
> +			   struct amdgpu_vm *vm,
> +			   struct amdgpu_bo *bo,
> +			   uint32_t vm_flags,
> +			   uint64_t *pte_flags);
>   	/* override per-page pte flags */
>   	void (*override_vm_pte_flags)(struct amdgpu_device *dev,
>   				      struct amdgpu_vm *vm,
> @@ -356,9 +356,10 @@ struct amdgpu_gmc {
>   
>   #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
>   #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
> -#define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
>   #define amdgpu_gmc_get_vm_pde(adev, level, dst, flags) (adev)->gmc.gmc_funcs->get_vm_pde((adev), (level), (dst), (flags))
> -#define amdgpu_gmc_get_vm_pte(adev, mapping, flags) (adev)->gmc.gmc_funcs->get_vm_pte((adev), (mapping), (flags))
> +#define amdgpu_gmc_get_vm_pte(adev, vm, bo, vm_flags, pte_flags) \
> +	(adev)->gmc.gmc_funcs->get_vm_pte((adev), (vm), (bo), (vm_flags), \
> +					  (pte_flags))
>   #define amdgpu_gmc_override_vm_pte_flags(adev, vm, addr, pte_flags)	\
>   	(adev)->gmc.gmc_funcs->override_vm_pte_flags			\
>   		((adev), (vm), (addr), (pte_flags))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index c316920f3450..87523fcd4386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -69,7 +69,7 @@ struct amdgpu_bo_va_mapping {
>   	uint64_t			last;
>   	uint64_t			__subtree_last;
>   	uint64_t			offset;
> -	uint64_t			flags;
> +	uint32_t			flags;
>   };
>   
>   /* User space allocated BO in a VM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index d45ebfb642ca..a0b479d5fff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -67,9 +67,9 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_bo_va **bo_va)
>   {
> -	u64 seq64_addr, va_flags;
>   	struct amdgpu_bo *bo;
>   	struct drm_exec exec;
> +	u64 seq64_addr;
>   	int r;
>   
>   	bo = adev->seq64.sbo;
> @@ -94,9 +94,9 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	seq64_addr = amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
>   
> -	va_flags = amdgpu_gem_va_map_flags(adev, AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
> -	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
> -			     va_flags);
> +	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0,
> +			     AMDGPU_VA_RESERVED_SEQ64_SIZE,
> +			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
>   	if (r) {
>   		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
>   		amdgpu_vm_bo_del(adev, *bo_va);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index f042372d9f2e..e1c9f34bbcb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1328,13 +1328,14 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		/* normally,bo_va->flags only contians READABLE and WIRTEABLE bit go here
>   		 * but in case of something, we filter the flags in first place
>   		 */
> -		if (!(mapping->flags & AMDGPU_PTE_READABLE))
> +		if (!(mapping->flags & AMDGPU_VM_PAGE_READABLE))
>   			update_flags &= ~AMDGPU_PTE_READABLE;
> -		if (!(mapping->flags & AMDGPU_PTE_WRITEABLE))
> +		if (!(mapping->flags & AMDGPU_VM_PAGE_WRITEABLE))
>   			update_flags &= ~AMDGPU_PTE_WRITEABLE;
>   
>   		/* Apply ASIC specific mapping flags */
> -		amdgpu_gmc_get_vm_pte(adev, mapping, &update_flags);
> +		amdgpu_gmc_get_vm_pte(adev, vm, bo, mapping->flags,
> +				      &update_flags);
>   
>   		trace_amdgpu_vm_bo_update(mapping);
>   
> @@ -1475,7 +1476,7 @@ static void amdgpu_vm_free_mapping(struct amdgpu_device *adev,
>   				   struct amdgpu_bo_va_mapping *mapping,
>   				   struct dma_fence *fence)
>   {
> -	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
> +	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>   		amdgpu_vm_add_prt_cb(adev, fence);
>   	kfree(mapping);
>   }
> @@ -1754,7 +1755,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	list_add(&mapping->list, &bo_va->invalids);
>   	amdgpu_vm_it_insert(mapping, &vm->va);
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev))
> +	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>   		amdgpu_vm_prt_get(adev);
>   
>   	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
> @@ -1814,7 +1815,7 @@ static int amdgpu_vm_verify_parameters(struct amdgpu_device *adev,
>   int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_va *bo_va,
>   		     uint64_t saddr, uint64_t offset,
> -		     uint64_t size, uint64_t flags)
> +		     uint64_t size, uint32_t flags)
>   {
>   	struct amdgpu_bo_va_mapping *mapping, *tmp;
>   	struct amdgpu_bo *bo = bo_va->base.bo;
> @@ -1873,7 +1874,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   			     struct amdgpu_bo_va *bo_va,
>   			     uint64_t saddr, uint64_t offset,
> -			     uint64_t size, uint64_t flags)
> +			     uint64_t size, uint32_t flags)
>   {
>   	struct amdgpu_bo_va_mapping *mapping;
>   	struct amdgpu_bo *bo = bo_va->base.bo;
> @@ -2731,7 +2732,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	dma_fence_put(vm->last_tlb_flush);
>   
>   	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
> -		if (mapping->flags & AMDGPU_PTE_PRT_FLAG(adev) && prt_fini_needed) {
> +		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
>   			amdgpu_vm_prt_fini(adev, vm);
>   			prt_fini_needed = false;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f3ad687125ad..f9549f6b3d1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -539,11 +539,11 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   int amdgpu_vm_bo_map(struct amdgpu_device *adev,
>   		     struct amdgpu_bo_va *bo_va,
>   		     uint64_t addr, uint64_t offset,
> -		     uint64_t size, uint64_t flags);
> +		     uint64_t size, uint32_t flags);
>   int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
>   			     struct amdgpu_bo_va *bo_va,
>   			     uint64_t addr, uint64_t offset,
> -			     uint64_t size, uint64_t flags);
> +			     uint64_t size, uint32_t flags);
>   int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>   		       struct amdgpu_bo_va *bo_va,
>   		       uint64_t addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index a3e2787501f1..846b67d52dfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -469,24 +469,6 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v10_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_WC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
> -	case AMDGPU_VM_MTYPE_CC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				 uint64_t *addr, uint64_t *flags)
>   {
> @@ -511,21 +493,39 @@ static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
> -				 struct amdgpu_bo_va_mapping *mapping,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_bo *bo,
> +				 uint32_t vm_flags,
>   				 uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
> -	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_WC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
> +		break;
> +	case AMDGPU_VM_MTYPE_CC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	*flags &= ~AMDGPU_PTE_NOALLOC;
> -	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
> +	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> +		*flags |= AMDGPU_PTE_NOALLOC;
> +	else
> +		*flags &= ~AMDGPU_PTE_NOALLOC;
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT) {
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_PRT;
>   		*flags |= AMDGPU_PTE_SNOOPED;
>   		*flags |= AMDGPU_PTE_LOG;
> @@ -566,7 +566,6 @@ static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v10_0_map_mtype,
>   	.get_vm_pde = gmc_v10_0_get_vm_pde,
>   	.get_vm_pte = gmc_v10_0_get_vm_pte,
>   	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 72211409227b..36720d1c07a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -433,24 +433,6 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v11_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_WC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_WC);
> -	case AMDGPU_VM_MTYPE_CC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_CC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_NV10(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				 uint64_t *addr, uint64_t *flags)
>   {
> @@ -475,21 +457,39 @@ static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
> -				 struct amdgpu_bo_va_mapping *mapping,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_bo *bo,
> +				 uint32_t vm_flags,
>   				 uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_NV10_MASK;
> -	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_WC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
> +		break;
> +	case AMDGPU_VM_MTYPE_CC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	*flags &= ~AMDGPU_PTE_NOALLOC;
> -	*flags |= (mapping->flags & AMDGPU_PTE_NOALLOC);
> +	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> +		*flags |= AMDGPU_PTE_NOALLOC;
> +	else
> +		*flags &= ~AMDGPU_PTE_NOALLOC;
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT) {
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_PRT;
>   		*flags |= AMDGPU_PTE_SNOOPED;
>   		*flags |= AMDGPU_PTE_LOG;
> @@ -530,7 +530,6 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v11_0_map_mtype,
>   	.get_vm_pde = gmc_v11_0_get_vm_pde,
>   	.get_vm_pte = gmc_v11_0_get_vm_pte,
>   	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index b645d3e6a6c8..fb3fb31724a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -456,20 +456,6 @@ static void gmc_v12_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned vmid
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v12_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v12_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				 uint64_t *addr, uint64_t *flags)
>   {
> @@ -493,30 +479,45 @@ static void gmc_v12_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
> -				 struct amdgpu_bo_va_mapping *mapping,
> +				 struct amdgpu_vm *vm,
> +				 struct amdgpu_bo *bo,
> +				 uint32_t vm_flags,
>   				 uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_GFX12_MASK;
> -	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
> +	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
> +		*flags |= AMDGPU_PTE_NOALLOC;
> +	else
> +		*flags &= ~AMDGPU_PTE_NOALLOC;
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
> -		*flags |= AMDGPU_PTE_PRT_GFX12;
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_SNOOPED;
>   		*flags |= AMDGPU_PTE_SYSTEM;
>   		*flags |= AMDGPU_PTE_IS_PTE;
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
>   
> -	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
> -		*flags |= AMDGPU_PTE_DCC;
> -
> -	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
> -		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
> +	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENT |
> +			       AMDGPU_GEM_CREATE_UNCACHED))
> +		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
>   }
>   
>   static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
> @@ -546,7 +547,6 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v12_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v12_0_map_mtype,
>   	.get_vm_pde = gmc_v12_0_get_vm_pde,
>   	.get_vm_pte = gmc_v12_0_get_vm_pte,
>   	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 8030fcd64210..f6ad7911f1e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -382,7 +382,9 @@ static void gmc_v6_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v6_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index a8d5795084fc..93d7ccb7d013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -504,7 +504,9 @@ static void gmc_v7_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v7_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
>   	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 99ca08e9bdb5..1ea198fcb51f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -716,11 +716,15 @@ static void gmc_v8_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v8_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   	*flags &= ~AMDGPU_PTE_PRT;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 71f134d54fe1..6663ae830651 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1076,27 +1076,6 @@ static void gmc_v9_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int v
>    * 0 valid
>    */
>   
> -static uint64_t gmc_v9_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
> -
> -{
> -	switch (flags) {
> -	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
> -	case AMDGPU_VM_MTYPE_WC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_WC);
> -	case AMDGPU_VM_MTYPE_RW:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_RW);
> -	case AMDGPU_VM_MTYPE_CC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_CC);
> -	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_UC);
> -	default:
> -		return AMDGPU_PTE_MTYPE_VG10(0ULL, MTYPE_NC);
> -	}
> -}
> -
>   static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   				uint64_t *addr, uint64_t *flags)
>   {
> @@ -1126,6 +1105,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   					 struct amdgpu_vm *vm,
>   					 struct amdgpu_bo *bo,
> +					 uint32_t vm_flags,
>   					 uint64_t *flags)
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -1239,25 +1219,43 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   }
>   
>   static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
> -				struct amdgpu_bo_va_mapping *mapping,
> +				struct amdgpu_vm *vm,
> +				struct amdgpu_bo *bo,
> +				uint32_t vm_flags,
>   				uint64_t *flags)
>   {
> -	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
> -
> -	*flags &= ~AMDGPU_PTE_EXECUTABLE;
> -	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
> +	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
> +		*flags |= AMDGPU_PTE_EXECUTABLE;
> +	else
> +		*flags &= ~AMDGPU_PTE_EXECUTABLE;
>   
> -	*flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
> -	*flags |= mapping->flags & AMDGPU_PTE_MTYPE_VG10_MASK;
> +	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
> +	case AMDGPU_VM_MTYPE_DEFAULT:
> +	case AMDGPU_VM_MTYPE_NC:
> +	default:
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
> +		break;
> +	case AMDGPU_VM_MTYPE_WC:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
> +		break;
> +	case AMDGPU_VM_MTYPE_RW:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
> +		break;
> +	case AMDGPU_VM_MTYPE_CC:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
> +		break;
> +	case AMDGPU_VM_MTYPE_UC:
> +		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
> +		break;
> +	}
>   
> -	if (mapping->flags & AMDGPU_PTE_PRT) {
> +	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
>   		*flags |= AMDGPU_PTE_PRT;
>   		*flags &= ~AMDGPU_PTE_VALID;
>   	}
>   
>   	if ((*flags & AMDGPU_PTE_VALID) && bo)
> -		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
> -					     flags);
> +		gmc_v9_0_get_coherence_flags(adev, vm, bo, vm_flags, flags);
>   }
>   
>   static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
> @@ -1394,7 +1392,6 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
>   	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
>   	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
>   	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
> -	.map_mtype = gmc_v9_0_map_mtype,
>   	.get_vm_pde = gmc_v9_0_get_vm_pde,
>   	.get_vm_pte = gmc_v9_0_get_vm_pte,
>   	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index a0f22ea6d15a..bfafcf804cec 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1189,7 +1189,7 @@ svm_nodes_in_same_hive(struct kfd_node *node_a, struct kfd_node *node_b)
>   }
>   
>   static uint64_t
> -svm_range_get_pte_flags(struct kfd_node *node,
> +svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
>   			struct svm_range *prange, int domain)
>   {
>   	struct kfd_node *bo_node;
> @@ -1292,8 +1292,6 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>   	}
>   
> -	mapping_flags |= AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE;
> -
>   	if (flags & KFD_IOCTL_SVM_FLAG_GPU_RO)
>   		mapping_flags &= ~AMDGPU_VM_PAGE_WRITEABLE;

This needs to move down. See below.


>   	if (flags & KFD_IOCTL_SVM_FLAG_GPU_EXEC)
> @@ -1305,7 +1303,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	if (gc_ip_version >= IP_VERSION(12, 0, 0))
>   		pte_flags |= AMDGPU_PTE_IS_PTE;
>   
> -	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
> +	amdgpu_gmc_get_vm_pte(node->adev, vm, NULL, mapping_flags, &pte_flags);
> +	pte_flags |= AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE;

KFD_IOCTL_SVM_FLAG_GPU_RO would need to be handled here.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>



>   	return pte_flags;
>   }
>   
> @@ -1412,7 +1411,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
>   			 last_start, prange->start + i, last_domain ? "GPU" : "CPU");
>   
> -		pte_flags = svm_range_get_pte_flags(pdd->dev, prange, last_domain);
> +		pte_flags = svm_range_get_pte_flags(pdd->dev, vm, prange, last_domain);
>   		if (readonly)
>   			pte_flags &= ~AMDGPU_PTE_WRITEABLE;
>   
