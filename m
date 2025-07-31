Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF99C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 17:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6778B10E292;
	Thu, 31 Jul 2025 17:27:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rSvs+Itv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD06B10E292
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 17:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3WMObxYgeKggMehgnXnSWQ8eWumXpVo9X9p62dXH9M/++yAZXsXrxM9eTN4lvRPYvpdqquFM1aF8DUaWR8G88W6LGFybC0H4YSD5mdwn+QQQHZ/yPIqFRcVJy23TtXPOX43TnzHNPZC3KaXS8nbXHjV+hJQCtjZJ51B2kkDEt4SI2tIibrwYXv4ni4Q3pBgAbxoZFr8a9hRB1aZ+g0XmdVsrm7fPx77VI4eKRPQCMAh5nBVdvFqtaI38FvTizH0fKEQuvMcF07RYxlYx5itJbCqSoqmyr2lqpIxKamzaFgOQjBgzrUXNUZkPDtFeuFUsxSCV/tVlMI9Mg9HpRpsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxMI3L/zr/vo4uLt52mlP8/Y51OVHY+D8W1AvR7a/qQ=;
 b=vIrT94Mp1i1HDgR6GzQE1XqUwlb+YsBtNPX0Zf/ylD3nkimWidOT8eMesYhHC9ObLNexvubU2w9PGrcV0YHSZC0OHu9SNsf0t7riQq+uYr/gm/uPRxe+TXAt1JS1Ah0+IzYax7mXFl0fseNURgifX3G69GU3WgQ82BT+GJ0hkEjI5CobFwXDyq1y0FRG1SnCPKF2SUSZILBxihTHblj8hF24T20bat9QOIE0GjfqM1yIq+7nRVnpycfwiIJeBq7uQqvXI3dWTMxNGJo6K+48Kz9hEIzPUCm9s3aA4VhNCir40Tj7KkuDVohsC1LQAVDKyr4Z3GMkbi+wzqYaUkT8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxMI3L/zr/vo4uLt52mlP8/Y51OVHY+D8W1AvR7a/qQ=;
 b=rSvs+ItviAWnyl0pS7Lcgpd/tYFBp1wSzDLTmghvf/7pVcuBn54PgVutMyiWbiCd0YoGe6BemacTjH/Br4JxwdgGUlJNoPjQx70wzTUJrI1a0audtY05nD/KXZOV3EcauZlSbSw6iX+1h9VsP3EMboK8K/WLLoCyiOAiOLLrra8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 17:27:30 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 17:27:30 +0000
Message-ID: <5620e30c-d953-4cd3-993d-0aea878574a1@amd.com>
Date: Thu, 31 Jul 2025 13:27:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add primary plane to commits for correct
 VRR handling
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>,
 Xaver Hugl <xaver.hugl@kde.org>
Cc: amd-gfx@lists.freedesktop.org
References: <20250730080902.6849-1-michel@daenzer.net>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250730080902.6849-1-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9f306a-a49f-4864-407a-08ddd0578704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlZpZlUwY0hmYnEvaVp3SjJpQm5pbGdjK1ZiRzFkNkgydDdqbmhNNGpwT3ZN?=
 =?utf-8?B?bVpaenlBTE16YnhrSVlra05NODgwa1ArblhTY0NneUt5R3pOMnFPYURjMFlj?=
 =?utf-8?B?OElBdWxzbVMzQ2JyeDNzU0YwZDZXaE5ScE5vaFNPaE5PYkxkRGtGSW0yM3Iw?=
 =?utf-8?B?ZGNwWVZHYnUxdFRIVHA3STFsWlhaVU1YcEpmZ0dOd3hjZ2dIMlJGQWxFWmxq?=
 =?utf-8?B?SXRCWTE0NWkwYTY2ODB2WHFReVM2cWV5RFUxK0UzTmM4blgweERaSWRhUEFy?=
 =?utf-8?B?N0FnVVZnMkdHZ3lwcTdlNU5Fc2J4ZTRIc0lqYTUwNG1MWHJLUC82UzBuTW9w?=
 =?utf-8?B?cDhYSXVSRTFGMFhXc1NBelJzVStNRlFtY01JaXl6WXFScHI4K2ZYeFc1SVhx?=
 =?utf-8?B?WmppWlAvYU1yWS9kVFlWdzZRVGV2SFR5dGFSUlRSeTVqb2xKdVVKblM4ejVq?=
 =?utf-8?B?TVVKNVRrRi9xNmxJcDQzeGdEVlFyVUVBUmJXUmZIaTU0cWttYUFXYjl2b1JJ?=
 =?utf-8?B?NWpINEtBNzE4Y3pRdmpjYXlWSU9YUmZEd1NJZWhuN0h4MVdaUXJWLzZtS05z?=
 =?utf-8?B?SEJSUWtZSi8xQko4R2VCSzE3eWRwYVI5U1djNWJsUVArOUxtdTJISitPR3JP?=
 =?utf-8?B?VlBENGRxWERPWEpiMWt3OFZjRkFqNFI3SnJZOENLakV0VjVxZ3lPUU15Mmwy?=
 =?utf-8?B?UFFuUmoxaE5qQXNVNGo0STN2Yk9oM3V1R0N0amI0dE1xb0dENkk2RVRZVTYv?=
 =?utf-8?B?NWpNTklsOGs1d0NaZjR6azRVRlBGQlphVi9DbkZlMnFBUEwzdkNRL2crZFhY?=
 =?utf-8?B?bUV3N1lyaXhqTUErSUVweElFUmpVNWhCNE05bzlFMXA1OUVoS1ZROVpOaGxv?=
 =?utf-8?B?a2xDaDlWVngrSjNmbCtPWkpxdmk3aWR3YjJlb3JPTnRGWUV6S0tPUklacWtL?=
 =?utf-8?B?c3cwNFZ0TFcxUzE0TUJXOEdQTkNKNXpSWXlmcjZZUkpRZFpqdmJoODhZMDMz?=
 =?utf-8?B?Vzd6NDdlZlEwWDNUTjl0UHFqR0hoT3ZkcmxuWHQ4UkNJUmRWQ0ZVN0RLS2di?=
 =?utf-8?B?Szd3OFRmTDVOVEdXWkdzUmV3V0xzTnBrd3Y4eEZwWlYzNmtzUkVIdW1maVc5?=
 =?utf-8?B?WXRvcXYzN0Fuc0RyOWcweHVwSHFCcHh4V3VheFEwSTh2YmRJS2lhVzgvTDVU?=
 =?utf-8?B?TnN2TXJlZExjQUtPNGwvWE40UURPQWNpVXkzemJ4QzFGSUIxazRDQkFDbEVZ?=
 =?utf-8?B?ZjV1R3RYMlUxV0xRbzVoRFNFSldOcVU2KzlGQ3lUVTNzeXJYemFFdWF3eUdq?=
 =?utf-8?B?bTAwbHhzUkc5a0tsWDNPQ3llMEthS3p2OTFGSmRpT05aeVRzbDE1MlVTb3Yy?=
 =?utf-8?B?eGZsU3FyaG5QZERkMkFuWUtpVytjZnEyeXhYNStjU2tmOGpCYzB0UGxBNGdi?=
 =?utf-8?B?ME1PM0RCQVNyOGRSSkIxRnlqMEFNcG9yai9KZlVCaWRCb3kzMXFlUjZkUTVh?=
 =?utf-8?B?aW04am1jSFB6SmRwRE1PTXhNdkFuQnJxKzF6TDBnTkdWRzYvRVJKYVkreU8w?=
 =?utf-8?B?cytIcFQ4MUF1dTZxQWN0VFRiWXh4alVxa2ZIYUI2WHN1RlFTT0dUR25HL3JE?=
 =?utf-8?B?QzFGL3UrclNYZERGSTBRWm5yQU91RW9nZU94NUFzZTFhaFl6K3dBL1piZmdZ?=
 =?utf-8?B?WFJMTEFTN1FZY2ZwMThEbUFpd3ZrZDBnU3hJU3BwNldCTWM5VjFmYzEzYmlF?=
 =?utf-8?B?QXorNHZWQk5PWkRJNW41all3WDVpc3hhMkpXcTIxSS9rVm9HVmt0WU5Wck1m?=
 =?utf-8?Q?vlrXcac8mWq09+vjRgsCF0VA7LQPV7e3Erz3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9yY0ZTR1UwT2l2cnNqdTdVSUthYmJIWW9kTGk1cFdDTzRyYWkvamcvZHU0?=
 =?utf-8?B?bi8yTExiZ0lnLzBCUVFhak1FZFdFeUh4alhFRTZiVkJ5d2dDQ2ZVOFl1S2gy?=
 =?utf-8?B?cUNKM1l0SXZ4cURDcmp0eFNhLzdNUlFxRXcyMWxnSTNHL2NoaUpiZko2V3lC?=
 =?utf-8?B?ZHdhSSszczVrTng4VDVhcW4wbDhjS1pnU2wyMU1MWVVjQlpSYjRPcVhQNDFH?=
 =?utf-8?B?YmpHZWllU3dnNWNTRU1qWG92Um8yYWdyTUxrVkE4eGI1TGcrd2x0L0dZOFpY?=
 =?utf-8?B?RjBzK09Wa2s0SzZORUFZdmdxZnFDb1pGMXV3dTNDYkRXWC9YTXlsY2dDS2dk?=
 =?utf-8?B?Y3FzMzFySFZ5S1NFcGdIdjk4ajN1T2NzVTFzcGkvTGxWT1A0SGJSYmhhRUxL?=
 =?utf-8?B?bFBQK21Wd0h5bFdCczQ4MEEvQTJoVzV6YUNNbjhJOE9OQ0lNNjNuU3dMZlFU?=
 =?utf-8?B?UjlzUmxxQ3ZiRWIrK2k0aVZMTndJak12YXZNb1JnK2ZQc0gzaWtqS3hYS20r?=
 =?utf-8?B?KzVQdGVsemZiVXlZNXoxaFd6eGZLa1h1ZVM5UGdBa3M0UlJhVm4zd0FRNnlN?=
 =?utf-8?B?MWxISlAzc1B4Q25LV0JiSktkVVAvZXZTUFU5SytZaDhiaDIxUUZrYVVQZk1j?=
 =?utf-8?B?K0Q3bUN1WGpYQXlIVWo0V2ZmdFljN2FaNXBkK29IdTR6L2pqc1NHcE1JMGs5?=
 =?utf-8?B?anp0czQxcjJYcjFBalRMTkhZNHRLUzNhaFdHNjdkM2lqMUtqa2k1NWlmUXlt?=
 =?utf-8?B?ekRTaURwQm9ZZEZEODQ1TlZ3SWVCTittWlJIRTQ0S2dWL0NOYitGM092WDJJ?=
 =?utf-8?B?bXZ3T1JQZmR3RytxNXFjNFNjUVpKTGtsaFIyOXhnWHJLdjdRNEJPWVgwbW0v?=
 =?utf-8?B?emdoMWZla3JNOUd3LzZlZnBvT2xrdmVQaEg4SzZ3Qm1DVjJEeTJ3WVhIK1V6?=
 =?utf-8?B?cVI5OGNXM1BoaWNOUEh6MEZGMzB4Z1MzL25MblBpL2tXZkxrN2taNkdkZTFJ?=
 =?utf-8?B?ekY3bWQycFJZZHhMRmhYT1NCNFp1MzlWMVZFYlArUnRKeEZYNnd4QnFWM2li?=
 =?utf-8?B?MExhd01NSks0b1pZSmIwWmoyLzhScmtCcXR3YTN1Z1pjaGUxamRCSFZaZ2xI?=
 =?utf-8?B?eGF6K0JmZzBJVXViaHBwbjI4VzBQM2pseHQ0RVZiVlptazF4WEdmOVZDZ3BL?=
 =?utf-8?B?bHRKS0t1dXlMTWtOV2t4OFNzNHdHSE9vUmhHMDUrWVdNT0JKOXZVZ0s2SU92?=
 =?utf-8?B?WTVJYkp4OWkxbnV4bUNtKy9OV0FWNWJuUXV5ZXNtTlR5NkJSUzNJdGpIOFd4?=
 =?utf-8?B?RGFxbzlHR3FlOTA1emVZWWZEOVZpaU9DdEVSVm9mY01YbHpmRW11MmVaTEkw?=
 =?utf-8?B?bG1PamhBaGVlVXJ6T3BQZEdvSVdJWkc5OUFOWkVISGEzdm90MDNBLzU5eVBi?=
 =?utf-8?B?US90RWp0Q1JWZU5oYlFZakpRYWFpd1cyVHZCT3g4cERrSE1aK3BtenZmTDZa?=
 =?utf-8?B?RWE2VDVIZ0k5VjhuSElGREQwenB0OWpmU0J6QTluQktCTFlLT1FEaDR6NkN3?=
 =?utf-8?B?NU55RzZFRmx3NU9IWEVBME1qQTdmRXNuME1GNDk5aHFBMWc4NEk3YjBEeHor?=
 =?utf-8?B?SXl1Y3JLY0JEbWtYUGxPNTJqckI5T0ZDcVF1VUxwR1B1MGEzR20xNUNWU2NO?=
 =?utf-8?B?a2dwTVdieWE5YTcydHN2OVJ3OTNBSzlvZnRSZ080RjRrTS8zREFqRWFneDQ5?=
 =?utf-8?B?aExuRW5STmdVMUs0a2l6NEhuYmJnajVrcVZndGtYNWswNTdvUVJSUkNFTytS?=
 =?utf-8?B?UzVDUTJRWjNheDU5K3NaTzROQTJ1NWQzZHVqZU9ZTHdSVjUrMXhVcktPUVI5?=
 =?utf-8?B?em9saHk1em9rTnQzeWNFbVlKa3VWNmZZUk5HZUs2d2psdFlpQTZnM0s2cGlq?=
 =?utf-8?B?WStsck1leHVHZGJsOHY2cTNRQWc1eWlFL3ZSeGFQVzVoNUJPbWkwbHFRL1N6?=
 =?utf-8?B?Q0F6QlB4YW5GSTdpaGVEYUxkRlhla0FtVy9LYU8xcHE1RlF3ZXlYZEs2TlM4?=
 =?utf-8?B?elZqOXBqcktPZzJBQlJWVEJGWkRUUjk3SnFmSVpFN21RWHhhTG1oTThCbEd2?=
 =?utf-8?Q?EAXMujr0l8/gOiV6kkL2bW2px?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9f306a-a49f-4864-407a-08ddd0578704
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 17:27:30.3748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+GtT9XWHDB0HJa/iKNxkfkLBuz90xRYqLUqxgzc5KP/TSfvt+KqJ56X5NDWylaWLe/8pAFrgG/JWS4roduhDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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



On 2025-07-30 04:09, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> amdgpu_dm_commit_planes calls update_freesync_state_on_stream only for
> the primary plane. If a commit affects a CRTC but not its primary plane,
> it would previously not trigger a refresh cycle or affect LFC, violating
> current UAPI semantics.
> 
> Fixes e.g. atomic commits affecting only the cursor plane being limited
> to the minimum refresh rate.
> 
> Don't do this for the legacy cursor ioctls though, it would break the
> UAPI semantics for those.
> 
> Suggested-by: Xaver Hugl <xaver.hugl@kde.org>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3034
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 2551823382f8..010172f930ae 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -661,6 +661,15 @@ static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
>  		return -EINVAL;
>  	}
>  
> +	if (!state->legacy_cursor_update && amdgpu_dm_crtc_vrr_active(dm_crtc_state)) {
> +		struct drm_plane_state *primary_state;
> +
> +		/* Pull in primary plane for correct VRR handling */
> +		primary_state = drm_atomic_get_plane_state(state, crtc->primary);
> +		if (IS_ERR(primary_state))
> +			return PTR_ERR(primary_state);
> +	}
> +
>  	/* In some use cases, like reset, no stream is attached */
>  	if (!dm_crtc_state->stream)
>  		return 0;

