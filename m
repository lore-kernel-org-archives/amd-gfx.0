Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF279C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 10:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8189310EC44;
	Fri, 14 Feb 2025 10:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkUONDvQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8D310EC44
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 10:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en+qELZFlF3GSxhwRhLYmBs9JuHR3dSFLnMhg8zj7qapTXIsuAlqBdv36w+HUZXi0a5DLTjot6PM+ou/QkXBhV26npLm9qYyUjE+xsFhLzzCvwrDbAd4LLTvB5/J3QDMhN57QU3cYxB2gQNHEkEDHEL1g453blNDOZIPod7U8QcKBu8YVpO+Pt12e6y9OC5r7TQr+nxdevnPJ3wISNYJB/YUnCajWU5mpT8J4UhNzOA3MNQI8tpB/8nUgVkc9UCMnRSJkM6a5ptyRt9hh1LDvD4hh2PHr/5VLYD0LkQIEOtKZE23VvBWUghQmeqCsNHI5Pcucw7h+5+8e5mpUO4R+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDlpuEYH3lJi+8UHinFRAqga2O086yl1mx5aR4LGzcI=;
 b=j3GYar4lcKnk5/jE4pdrgLLqiR/2AdREbcVFx6OFzJYgs1YeamMEOZqG6bu4s9TAroDKPeq1tf6dMelbl0eCECgKcslzeAjUYgOMrml413qRz2TTT6E3klMYLndnx1PLjTDHJi8LfON/RWAT0Npnb5if0EKHL0wbkLGHW/9S51JMkq3kqyBggE6VHzWMSO9X+K8teG+rUQ+8Lz6293GoOgRTL28kW4cnlAkBs8wmMLVHMZ0dnx7UaID7quxDxJJyEvKJ3ysRirIhD7KVC9LYz6VkYQFMZbsLvnhC5576RfhUe5cNCNJ2tGgzHEvLM7wabb9NYcuWU5VpYk4j/s3Gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDlpuEYH3lJi+8UHinFRAqga2O086yl1mx5aR4LGzcI=;
 b=BkUONDvQGiV0PKHQODFVrom2ET/yy78hYoR7hBAwWSL2Np/JUGM1gGX+oARIITedz/jsAzZ2IcGnh8yJ9HLE/hz4XSQ4UEvXSUJMpqngYQDLtbXiA4P0GVaYyNtM7paHoHrnsaSHH3nIXPUlLhZ4r+2h7N/cb1jIGWuDo4kuOxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 10:38:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 10:38:04 +0000
Message-ID: <0e49dc7a-d932-403c-88b5-9b16ab9477d0@amd.com>
Date: Fri, 14 Feb 2025 11:38:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not
 released
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
Cc: hawking.zhang@amd.com, lijo.lazar@amd.com
References: <20250214100718.2663073-1-le.ma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250214100718.2663073-1-le.ma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 72df4c4f-e102-4894-d8ff-08dd4ce3a9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a00rZWkreHFhRmYvazB6MGZqdVp3YVRTSG5tQ2huMU1MR1FsRjRvMVVoS29L?=
 =?utf-8?B?TUNaWjRmVnNMSFVqR1k2STBvdW1NV1V5b2NISWkza2pLLzRsN0djc2RZTEMr?=
 =?utf-8?B?SHdwTFc5RDJSc3BFMjgyNUdWQWIvalIwUHU4ZGNCakdEak9adEIrbjU2SXZD?=
 =?utf-8?B?N0tjK3dweDh1MEdnVGxzVjhla3c4dSt1aHkwVEVjSFFsa0s3ditpR2JFMUZZ?=
 =?utf-8?B?MGtBREEzY1dQY0xMdVRNVDRHM3lESy9vVzY1VlJpVHRJTDRKRGFMME5kSXZU?=
 =?utf-8?B?RmtBTzdpU3NiTCszaVRCQTJBUE1jQmNzam5KSEFHejNlRnNOU0hqclduNG5S?=
 =?utf-8?B?cnZ5UE54TmtIVTR0UE0zb2V6UUxKajlDcTQ1SitYREI1bmE5RWxlWDdnZkt6?=
 =?utf-8?B?TGMxaXkrQlhOSW95T1BVUnpIL3ZnMjl4RlpVZm9BSmJmNkdzMFFiUERzQXpV?=
 =?utf-8?B?bEkwTkdWSktmbVNYNUFQZTY3U2NyNU9oaER5bkJ6RFRCTURIWVVLMDc1NHZm?=
 =?utf-8?B?UjJUWC92elBiZlV4MlNTTjZGcFFDSGVxWU9aTnNvelRSc0xTei9SZGpVWS9J?=
 =?utf-8?B?U3N2ejdjcDJvSStDajhMc3ZPUWtBNXpTQ2tRa1BrN1JlQzVpZm9lT1ErVkdZ?=
 =?utf-8?B?OVlXbUtRTURqTDN6clYvWUNWRW1xcStpT2xxL2xrVGxTZEY0UlhZR0pKeFhT?=
 =?utf-8?B?ajFPdmhVZE0xbHN3VWE2bUlLUFd4YWRYUDBlOFR6TVlhK2V2VUt2eVdmdk9D?=
 =?utf-8?B?eXptc1dNUWRNeWpWaSs2anlxUFJoeEhXeDBRRmNFOXpZYVpYNzR0ZFJyS2xS?=
 =?utf-8?B?cU9yZFlnWTgrQXVwY3NoTEpQWVVWUzBacTVFYmZ3SFQ1SEpqMWFVVWJqaEZF?=
 =?utf-8?B?RDBXZWVxVmhEbk5sWGtPTEJ4S2FWMGtWZTdUNG9JakUvS1llOWdjMTN3TVlS?=
 =?utf-8?B?WjNlMk8xT2lLalBjTGFqOHMrTHErVVBYY0lHSXZrRmM5Z3Z6c2RicmJBS1Y0?=
 =?utf-8?B?RFRpdXAzaWpMQ3dBQlFiTkw4N1NmSTRjbmdqS2JlTjBYRnlsNnZHRERpTjRV?=
 =?utf-8?B?d1JVbXBEd1cxbEx4ZzBZWWY4dlNKWHg2Y0ZMWEluQ3JscGk2V3A5R1UrRGpk?=
 =?utf-8?B?cUs5aUdXVTFlMHYzRnZqc05rakdZRkhxU0xYejBHeFluc1RwdWhLNENvTjIw?=
 =?utf-8?B?U0ZpQ1pDbHEveG5zQkhpM0ZxWmVVd053ZGtDbTc4WWFvNklPRkFwQlZpR25s?=
 =?utf-8?B?M0xqbGw2b2pXZjc2Ynhzdlp3QW1pQmJWdnNWUnpPbStLc0RHSXhrTU5lc3R6?=
 =?utf-8?B?WVNpU0lsdUZ6L2tBOFdlKzZVUUtmeDVkQ2dWYTRtL3U1UnNMS1NBZVpyV3BS?=
 =?utf-8?B?dUhhdHZPc2FDVWMvSzd5QzhJVHhHTXFtbGRmbDhzbVl4VUpyM25mdmNyQm1n?=
 =?utf-8?B?eUpDV2RiZlFoWnREaDRNVll1aUIxa0piYzlGRlFnd3BjYmJhUk54bkh2T3pQ?=
 =?utf-8?B?NXlET3ZyUTdGOHVSRmMrd3ltR3JSRWludU80dmpiemViVHVmcllhRnJPOVow?=
 =?utf-8?B?Z1ZFVlJDbFlzcmZTaXdjRTZTNFQxcHFWUE50eVNYazd3ZjlVdnJpYU1GaXRU?=
 =?utf-8?B?M0t5aHYzRXJyM0RycE9FVGU1Qm9aMktvY2duN0VFVHVBUGNMWjR5ejlkV3g0?=
 =?utf-8?B?MEpCSnV1SDZaTHhYQXpsZEIzYjlyVWtIQmFlN1MvZkRRQWE5ZEV0VWlvdnVS?=
 =?utf-8?B?K1kwV3ZnYWlSS1VHV21ZQnNoQkU3VjNOa3dkUUJBcTh2UW8yNlF4RWtwV2Uy?=
 =?utf-8?B?c0krc2FHaG1DdzVWSVVBQXd3TlMyTTV6b3ptR2U4Wjl4UXQvKzlDaTY3M3Fi?=
 =?utf-8?Q?ynCHHjLzu1+h3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXR3YWY4d0hmQi84QlpJeFJWb1k2THNXT2JUakpjTmdpeEZTTGMxS1c3cENi?=
 =?utf-8?B?dmpISXBNam9pUmYzRG9vN0RiQWJzaW9NK1JHYlcxN2wxMVk5N0g3ZWFzM3d4?=
 =?utf-8?B?dzhQazVNa2dYVG8vc2NkL241UUJwelZUL2VHdGtsSWlsZFhrWjJ2eGh6Z1J2?=
 =?utf-8?B?NDl5MFA5VmhMZHdTMjZwSnNTTGQ1ZDVIQ1ZwVnlTUDFoY2lERmlhSEMzd25j?=
 =?utf-8?B?bGpSZ2ZQQXVlODN2cmJnUTA3azlFSUlDRU84ODhrZlRRM2RtbDYxa1NnWWZj?=
 =?utf-8?B?QWlkRFY0c2o5bnJqRFo5SjVVbERtVU1YU1QvaWQ3MnpPczVXaUh2b0pRd0xa?=
 =?utf-8?B?dXQ1S1A1ZlBuZjczc1Brd0h3Y09JZkVNTktKQTQ2cTBPeGF5TUZnZDRyb0Z0?=
 =?utf-8?B?VDM0TXhTZ094b1FTYzhJU09qTGQ3ZDVHV1hpd3dZRnJDekFIV1ZpOENZQkFI?=
 =?utf-8?B?aXNpQjNLOVBRQW1zOFFpT0hHQVdPbzJab3UweTdBb1h6TkNWcmRscE41cjN2?=
 =?utf-8?B?NDVNcjNqUDQ4T3RYWkJEcU9JclFva2FoYng3eWlPRGRObGhlRDg1VGdobitR?=
 =?utf-8?B?cEdyNWlHejFWZFVLc0JFaVd0VVNsdlBBK3JmbVFpcUkyTVVmVUIvaFc1bmc1?=
 =?utf-8?B?QkZqdm1zVHVNSUpBZXdSekhLYnhpc25IeW1yQnVsYzF1TDQ0TkxtREFoaTdz?=
 =?utf-8?B?WEdDV0JCdmd1YWlKb1FMM1JMZFlVQkJBakFFajdabmw3MExNSXZqNXFzbUlk?=
 =?utf-8?B?UEdyVnB1Z2w1S3NzbnpCOHM5RGVFYmJUOEQxem9qR2FrdUFnaGpGUWpRM21J?=
 =?utf-8?B?WWl3UkNMUE1WUjhoRjZEQ0lRSDdTN3ZGM00zd1Y4N2p1WmVtV0JOcHJVQmJZ?=
 =?utf-8?B?bmpUMlUvMTZhZ21XUDQ1cldEQk5TQ1FzVXJXUk5SV0ZqWGc5eFdyT0JITVpj?=
 =?utf-8?B?c3ZySEowNGozemtpSi82WG9iellCWUVPWUxoRkxUR29XTUVCZWE0MTY4OXA3?=
 =?utf-8?B?VXR0NlQrZkJEbkV5NzhZWW1iQVhvTFM0azlZT3JiK1NPV284ZHZHb0xPbHhU?=
 =?utf-8?B?RlhGZEdwakZPeEVFQ1VtOVErOW1qTkhHNmVJeTFZc3g2emdLYm85dXdCUDRV?=
 =?utf-8?B?VmIxd3JIWW1Fa3BKNUlSTG5EQWlBdUNhYmk1OU4xdjhCRDJSSUNlZTZBZ3E4?=
 =?utf-8?B?MHRYK0Jxd3ZDaHpSNDN5bHRjVWZBcmh6U0hoZHZzeU0yOTlWZTFoUzVxSkl6?=
 =?utf-8?B?SGpFc3AxZVRuOVlpUndBYUpiTzFLekU3NnQrMHRkekxjdEpyQTRjeGNuU2lV?=
 =?utf-8?B?N3hvK2R2Z05jWWxsL1lUdjRoOXVsczNDR2p4KzlWMmlhalQ2RWl0SkpXTU1p?=
 =?utf-8?B?b0ZpMTBKaXkrNDZ5QjlacklVNlpveVJOOExiTDErRkc0R1ZGVkZxeUxvK2tN?=
 =?utf-8?B?MmI1ZTJGeWliOEpQbU5CSUpMZ1hiaHg5VzdGeVp6a29sMFcvUnNVUXlLUkgv?=
 =?utf-8?B?c05hak5aTk12ZXEvRTR5YWRKUjFmZ3R6elIrRmowUjBLdTg4Yk4vdnN4V2tT?=
 =?utf-8?B?Q1g0QXJoM2pJSUJzUVJWdjNOOXFNTjJSMFdmMGFwVWU0ekJWMDEwTUUzMkwr?=
 =?utf-8?B?MWRLOWRGNE95bTF1WmQvZUI3YzVmb3cveExFMzRTeEQxeWJaN1owcmZ5M3FT?=
 =?utf-8?B?MkQ5cWNVYytQeHp0b1pJcWF6R2FBVlNvREYwUmRubXhGSERyTTgrbWN6UlV4?=
 =?utf-8?B?eXc3Z2Y4a2wwOE9NOGEyTFRWZFJscjFVNVJBQk4xUi9PUmNJNHgxZmhWVUhr?=
 =?utf-8?B?TUFKYkkrRkF0SXllZk56MGl5WlpVSlBKYlAyR3VWdklCT0p5QmhySHNmZlpO?=
 =?utf-8?B?dlZDOVpLbzhQNFRJOUJiZGZldjFHWGZZaTRIMXgweDNDR3NJOHBnTzZVTmhp?=
 =?utf-8?B?UU5pdGxJTXB0azNJMHhQWEl5T241eVI2UzhZM2VkTHoyUGhyczFwM0tpcldL?=
 =?utf-8?B?c0x2MXpQZEpiQ3lVdlhyMEVrdXZrRWpuWkFxM3V6WDhYRG9HZGpnbjM4V0pL?=
 =?utf-8?B?dVJLZlkveXFIMHJackw2YlZBRHlMMDNqWHdlSmNDWFlINXZOSVlWMFV5b25p?=
 =?utf-8?Q?aIWuDpZzMhA1ynjghb50JgGDG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df4c4f-e102-4894-d8ff-08dd4ce3a9d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 10:38:04.8350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZAxDBlWhQZJ3ApiveFCGXAZX1pOLpz22wN9imRL244Y8ATwBriSlXeG05d/b01c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742
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

Adding Arvind, please make sure to keep him in the loop.

Am 14.02.25 um 11:07 schrieb Le Ma:
> On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
> will show up explicitly during driver unloading if created bo without
> drm_timeline object before.
>
>     BUG drm_sched_fence (Tainted: G           OE     ): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
>     -----------------------------------------------------------------------------
>     Call Trace:
>     <TASK>
>     dump_stack_lvl+0x4c/0x70
>     dump_stack+0x14/0x20
>     slab_err+0xb0/0xf0
>     ? srso_alias_return_thunk+0x5/0xfbef5
>     ? flush_work+0x12/0x20
>     ? srso_alias_return_thunk+0x5/0xfbef5
>     __kmem_cache_shutdown+0x163/0x2e0
>     kmem_cache_destroy+0x61/0x170
>     drm_sched_fence_slab_fini+0x19/0x900
>
> Thus call dma_fence_put properly to avoid the memleak.
>
> v2: call dma_fence_put in amdgpu_gem_va_update_vm
>
> Signed-off-by: Le Ma <le.ma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 8b67aae6c2fe..00f1f34705c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -759,7 +759,8 @@ static struct dma_fence *
>  amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			struct amdgpu_vm *vm,
>  			struct amdgpu_bo_va *bo_va,
> -			uint32_t operation)
> +			uint32_t operation,
> +			uint32_t syncobj_handle)
>  {
>  	struct dma_fence *fence = dma_fence_get_stub();
>  	int r;
> @@ -771,6 +772,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> +	if (!syncobj_handle)
> +		dma_fence_put(fence);
> +

Having that check inside amdgpu_gem_update_bo_mapping() was actually correct. Here it doesn't make much sense.

>  	if (operation == AMDGPU_VA_OP_MAP ||
>  	    operation == AMDGPU_VA_OP_REPLACE) {
>  		r = amdgpu_vm_bo_update(adev, bo_va, false);
> @@ -965,7 +969,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  						    &timeline_chain);

Right before this here is a call to amdgpu_gem_update_timeline_node() which is incorrectly placed.

That needs to come much earlier, above the switch (args->operation)....

Regards,
Christian.

>  
>  		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -						args->operation);
> +						args->operation,
> +						args->vm_timeline_syncobj_out);
>  
>  		if (!r)
>  			amdgpu_gem_update_bo_mapping(filp, bo_va,

