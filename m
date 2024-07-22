Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4290C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 06:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B8F10E368;
	Mon, 22 Jul 2024 06:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iBFte2gB";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48A9010E368
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr+On5loV4w0DFfioqadjgErh8hDe4iZYpjzePt5iT3JjPYbcntm3ci5ni61HVrquUFgzjhRPbj2gbgH/3bAgyeyqgcf2kCOJAd/McKCnaTzxm5ges/HaaLam+St1Cawmvo+PPhK3ZSDoP1q9k2GmbTo0TolkRmJewpyIGsf5iIvUZ8F31JvyUevx4ajAWfGVNv/Ld9XYYmQIwDwGvvOWXgvWLdgya4qxfw/OsG+JV18auqcUtbnTee+wMpGzJMHydQ9AU79U/W1fcZr3QJ//cB8ByQ0MyjaQ8oRFCc1Bdfc523KxqGtN+TrPDFzHopyK0vpmJQUfPV5FZhP2STZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zD9audTJkw6dQVGdkL1hubJtn4g1/UXwQk5Ep0QEIw=;
 b=EDFBUEfOmnNtpQx/Ff3LJ2Pu5m8fP2RHR9Q5Sd+RawLA5TR1/aHnmeaeuI0eMtlO4m7aEGm1KRwxCh6ltHZJPfa9WfzJxI0WlOU02AgLUeojX2DafIq3IUF5ph2OKbdlZE7hG+4dyv1YvUNWkIVrGhTphgv4EQicgLx7yL44eDtm+ENm/ef8+tbJ73uNG1JnD/UUQB7EBzG6yIQ+aewdgfrRov+6Qwig9iGzufM8VdUKZJvPFtHjpM3bsdxR7g39n/T5XeBVzq0YZjAmcX+WD3EE/+b6O2GHFhVxC2luRVyp8u6UjVXoE9GG1SBqe5t9nV7YkgQ05wfddgKzJ2o4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zD9audTJkw6dQVGdkL1hubJtn4g1/UXwQk5Ep0QEIw=;
 b=iBFte2gBXch1+NrTQ7OaVdzjsd9KiN6J+OpT5aMyJ4yKcTxvsOkSzAgcgjxl+buCdoLXIP5mzKD0Nnk3zDkYFnxIfj2G2iozBy1vxHpxIHQK8qoXUC8qsv5807Hgf2LFfxCX672WzuLt2Mqo2Pp/qkkilsdw+F+Tx1pATfF4fM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 06:16:37 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 06:16:37 +0000
Message-ID: <46de3904-cf61-43d5-b970-dd2b0bf3950c@amd.com>
Date: Mon, 22 Jul 2024 14:16:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix index out of bounds in DCN30 color
 transformation
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
 <20240721062216.3151119-5-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240721062216.3151119-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bdcbd8-f5dd-42de-5f9a-08dcaa15d7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFROQjRkU3ovSlJKWWZPcjZSeFpuZGJoSkxRTysrZlJuVWM2Z2JtR2NnUUVw?=
 =?utf-8?B?TTd5c2tldFVPKzFJWWk2VWNVOGRqaHViek5CUUd2d1NqaHF5OVN3djhuN3JS?=
 =?utf-8?B?b1pFbmJheHBtU1YyMDlEK1Z0aDNPYzRibm1BcElaMzBVdUZhWUZKeHpRd2ZL?=
 =?utf-8?B?UGdSQ3ZYcUt3K1NnMGZDK2tpNUZrNDdtTHZpRlV2Z29lNWRkenRwTmp2NXpR?=
 =?utf-8?B?blJDMjU1RkExSDVhMmZmRUtVaE5sYzVsRTlIVUJsNjZmZU5uRXV1UGRhbUlQ?=
 =?utf-8?B?am5ySnM0WUJ2dGdQSlJQdWpySDdDUzVPZmt5djE1ZHArdWh1SHpmTjdWNExq?=
 =?utf-8?B?NmRrQjAvdkNOYmpYUnJyUXBwRm11TCtmcGJGSm1TL0phV0NucUprMDlIQUhY?=
 =?utf-8?B?NytGYXZCWXZoNXV0QzQwUkhtNEZiZVBLZVZ0S3NOQkE5TmlBcUF3NXJieXVU?=
 =?utf-8?B?OUdzaXFlZ3J0UEdzbUwxL1hqQjdNYU53ZDRwYWkrak1VWVhJaWN5WWlkbjNl?=
 =?utf-8?B?bUpBN211OWFIYWtOd2grTCtuR1JZN2pYS0F0OWVxWHVyYmxidmt1VmprWEpx?=
 =?utf-8?B?OEJFNldoRmVmbU9hOXRhNVdobE9DVThMV2VIOUIwN1N4bnNvbm4zM0M4cmU1?=
 =?utf-8?B?ZVh5MWpaUityMlFhUE9RZ0xXU3lrc2M1cm82SWx4U2dtWGl5UkZnVnkrTHdv?=
 =?utf-8?B?bWZhQWN0TlQ5bkM4cWxpUHZlMyt0YlVhMzhpcHRncElQajhGUmRtbDNrSjZy?=
 =?utf-8?B?S0tzTmZoYzFXYVJQM2lVVVZhcktiK09haWlaK0ZxL3JHMzV4YVdFR2FGUTZj?=
 =?utf-8?B?eEo5U2xGT2o4emRYZ3ZSQ3dmc0lTZXlrbkNQWkpZYTNKeWxSUGcwV2NQK0F4?=
 =?utf-8?B?RC9sbnpEMURWeVVab3dpdlRjenVnREEwY0R2N1BDcnZGMDZuL0RHNkNuOXla?=
 =?utf-8?B?MTdZdW9ZWkg1NG9FWEFqaWxWYVNHcEN0TlI2cVRTckFuY2NjZ2pRQm44Yi9o?=
 =?utf-8?B?N2MxY21kYXRja1ZNellJK0RaRHhCRUg0cGJ6K21EbnFGRzRqQm8zdm5BeUkv?=
 =?utf-8?B?aTF1THJadm5kUHBXZkZhSW1UN3p4cVE3RzF4K2YwcjVYMWdTZ3FERU9ZZ1hB?=
 =?utf-8?B?cEZ5RGZ6bm5OSGJmWEVQcXNJODhSM0ZGYTJrcDZNeE1YQVE1NDVRbmxLQ3VO?=
 =?utf-8?B?VmhPN1AvVTc5MDVQVnFzRVdSWUtrRHIzbmtoSVRZdTFKa3AvL3czQ0tjYmFP?=
 =?utf-8?B?eHJRRnFwTGlZSGZyK3U4bkd4NUtpMTZ0RWw5VFl6QVBRdmY1aVpkZE1PSG54?=
 =?utf-8?B?R0VzbGorR2pCTjFVSlByREowTWwwVktCTk5WOXZlTmx3YVhDQ0JSL0RRUGtV?=
 =?utf-8?B?R1ZnOTNoMzBINWhEdDBpQ256M01LQmRUWmVEQ3c3dXV5NlFLcWlLM1phRTVD?=
 =?utf-8?B?b0ltWVprS2IzbVVxMzFPY081ek1kOUpHV3hDMXJLWkdZQTNnSjJkNm5QVVBi?=
 =?utf-8?B?QnYzSGNFd1Yram9TeGdhSkw0V2JUMWlhZGhST2JqWHUxN21ndTFMRHppMGZU?=
 =?utf-8?B?TmRLZ3dxZzdBVXk1YkRLaDFYdlhucU1odjBwbFBzOFV4RzBtaDdxMFlJZ1JY?=
 =?utf-8?B?eFJyRys3eWREMmZ2TTMyZmlRcE9STC9DOXIxT3NEMWJJNXdhRytVc1YxSEJL?=
 =?utf-8?B?eUQ1RUF2MW1ka3kvSU1kMHVWQWswcGFpTE5Vd3hzNThuaDNjeDJoRVRUbC9z?=
 =?utf-8?B?Q0NyUXQwTzRaNEliUlNMaHkra0Q5TnpEUEJMZ0JHaGRZbUtPemUveFZUK01L?=
 =?utf-8?B?d1g4cEpEeWsyWTNqbVd6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUd5aGMyNUxKWVBqdTl3Ykgwa0QrWHBXM0ZUWjQwOWJGSE9nLzYzZUE4SEFP?=
 =?utf-8?B?WjFTbEhaTDZlemtwNVZQUkVSaUFxOUZYNXFqMEp5eS9mMWdORGNVbExvMlND?=
 =?utf-8?B?b3pMb0NVTDgzUTJ0bXplR2wzUFVGZHkySU8wc0JCajVWNkZuVTJyQ0JINTZQ?=
 =?utf-8?B?bHJmRWZCVk0xeTZ2VmxZamhSZEQvVkVWUkpzQjNqRGNQQkEyK09uWEZFMXhM?=
 =?utf-8?B?ZHdPZ0xTN05PN3BSS3JNR3R5bGttSGdrWTJ5alFidUV0bWZ6dzhNN09xUlAv?=
 =?utf-8?B?M3pBSTd1M25SUG5EV2RxRFhSR25WOWlFaXRkK0N6bzgvYmsybS9jN2lienRY?=
 =?utf-8?B?czg1bEsyUUt2WTYzTWdua2xQSHM4aGxVSm1LQ2RUVmRHaG9vU2thQVlEcXhy?=
 =?utf-8?B?cHk2OUx6UHg3WWRqVDJwZTVZT1RNKzJwUTRJVWxSbm1kWUU4cHhadXV1NWJn?=
 =?utf-8?B?THRPNjBXNkxLUEdlQjR5Vkp6YXFrN3loMEpOV0RwQXVMcmJCQ0Jyd1BYbm1Q?=
 =?utf-8?B?N3BXOC9jTG1QNGxTUTZNc2V1Q1JYYldWTHd5K2cxbGVoUDRQZG5VNXR5OVZH?=
 =?utf-8?B?Vnl6dmVuREkvZGFnN1BNWUFqMU51Z21OVzNUMXZDTmVSZEVtU2wyakNleFFQ?=
 =?utf-8?B?VmJnN044K3JBK2krMVROc2MrS1QyeEJ0MC9nZzdNQ3lsVE9qb3gxMjQ0YkR3?=
 =?utf-8?B?b2p2YmIzdEI2UlY3REsyNHNnZHVyaVdIeHg2QjlNUnM5ZW9HZGtsc2NRemxp?=
 =?utf-8?B?bWovYVQ5d01YOVQ2ZExRWGUzZ0syREtLd0cyU0VZMEhGdFNBVEYxMVUySEEw?=
 =?utf-8?B?NHc4VjVIdHcyUWZnRkFvVXdsdEhtM3djSUxlbVhYdXRDM2VIb0lqd21HcWpw?=
 =?utf-8?B?RFBPbXlWK0JxUXVXOTVDem43bVpuNEJ1c3V2MkhWNmJPRklubmlZNlJTL0pK?=
 =?utf-8?B?T251TXJJUEV3KytoYWJycnE5RElhdFBnUDRoYWxmYW5mK24zWFBSaktWNUxP?=
 =?utf-8?B?dzRwZUMvWEdnRTZLNUxKQVdFWllBa1UxelBJVGRWS2REaFdXTVdSN3NlWVMx?=
 =?utf-8?B?MlViQkx3VlF4ZmhUaE43M0FWOXR6NkdLZy9LT056a1E0WWVkSDE5dzl2bHNU?=
 =?utf-8?B?cmd5WXc1MDdxcVAyTTdlUHZ0eWpuSVdtelZDYUlUei83RGxNcSszeGM3dUF2?=
 =?utf-8?B?SFRxaVJrcENqRHNVVTl1VWpnRk1IbXFHV0VKOXVaTDVEUnVVYmhZSWJMdHRv?=
 =?utf-8?B?YitGVVZJLzRZR3VHUmMwTVJzbEJ2bWpFbWhRekF1U3liUHJLdFRZYW80RUhE?=
 =?utf-8?B?cWV1L2FLTTVodUNzeURaSXpxbmhEbjhvdFFmQ2NRSEt5U0Z3NzRQbVlpT09x?=
 =?utf-8?B?a1BFL1lteFF4L3UrZHZuYmZ3Snc4OFViU1NITHQrWndtaDhTU0xtUnIyV04w?=
 =?utf-8?B?N3p3RHYzaittcm52ZFI5bjBWZFRSRWVReEtSb25JajVVL3Z3WjJnbzdwQWhu?=
 =?utf-8?B?Zjg2WDRGSGgzZnArSlhTRmlYRHJ0SHR6YnFrZjJNajc2SUlFc0dIM2xpT2Iy?=
 =?utf-8?B?ZlhUcjlFUk45UzR6Ymd2QjJtczhMQlNSRjFDOTVkSnhvR05ENWVkSDJpcDVR?=
 =?utf-8?B?OEJjYk4yZWthUEUxb2E4dFdwUENuY2ZvbGh5NG5YaExDakdoYVFOM3FwZXJE?=
 =?utf-8?B?a3lrSDFLMWNmUEhhTGNMaVpaZjZpdWdiSFY5R0NuNGhOVlZSalp2WEphRW5Z?=
 =?utf-8?B?Z1Q0SmIxenFFUThLNVRCOE84SkZXWjlZVEw5MlBJY2U4Rkk3MU9LS2hqemp2?=
 =?utf-8?B?c2xYY3NvNlBJWGtqUndvbEZPemFTN3ZkT2hoRkFtK09CcHNTMnl6SjdmeXln?=
 =?utf-8?B?SGZYMzkxc3RRVXFkQVhPMFdpVjUyT1ZpSWtYNzI5NTlmWWEyMkc2OGlGL2RC?=
 =?utf-8?B?Um9Ta1RlakxRSng3Y0laTFUvVTYwQTVzbXo4ZUhoRjlQSm9sZ3VrYno5bjZL?=
 =?utf-8?B?b1ByNWU1c2syL3RjTVQyaDUySVRybHRWNUFWZEJIRW4xNi92MTQwdS9SeW9a?=
 =?utf-8?B?d3JraDdFNHA2UkFaTlg4azdEWExyUHZYUno0VnZHbUQvbTdiMm9XajRkUjUw?=
 =?utf-8?Q?d4JFtRQYJsbPio2aIP6vsNbDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bdcbd8-f5dd-42de-5f9a-08dcaa15d7b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 06:16:37.2004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 059NJwpJxfgM8X5VIb4xRK810Fm9F2LMRr55PN+EC24kxVFD7xJUOl2hF79MtwiFP+Q2lFdb1wUL8jid+VahFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/21/2024 2:22 PM, Srinivasan Shanmugam wrote:
> This commit addresses a potential index out of bounds issue in the
> `cm3_helper_translate_curve_to_hw_format` function in the DCN30 color
> management module. The issue could occur when the index 'i' exceeds the
> number of transfer function points (TRANSFER_FUNC_POINTS).
>
> The fix adds a check to ensure 'i' is within bounds before accessing the
> transfer function points. If 'i' is out of bounds, the function returns
> false to indicate an error.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:180 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:181 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_cm_common.c:182 cm3_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> index 685702321d32..ef7d75f6ab93 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> @@ -177,6 +177,8 @@ bool cm3_helper_translate_curve_to_hw_format(
>   				i += increment) {
>   			if (j == hw_points)
>   				break;
> +			if (i >= TRANSFER_FUNC_POINTS)
> +				return false;
>   			rgb_resulted[j].red = output_tf->tf_pts.red[i];
>   			rgb_resulted[j].green = output_tf->tf_pts.green[i];
>   			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
