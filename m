Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E54CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 12:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BB110E8F4;
	Thu, 25 Sep 2025 12:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVHuHLcL";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C0F10E8F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqXsT4xly7i53Es/9Ki05moYhP4MgG2rgTrOXzPm2zVkKqlgzKZunE+tw6GbJwLIy14cVQ4wzYQI6AFEWArZfJYqsazYuDGTcc8mGnQI77736uOQ2WNxJQ92iAQekMzDwWnBc28llkZwcjycwUycbBubfLRSEFuRBtcPU9fPk/sB18NHyvpQiDY7gybPa0/vCY8oqgXNtOx+uFrwPce6eAgCXWCBwj7ecOFDwy55sfonL5u4R/RvBR9hUpI/WFfSEvzGytoptOJ1xM+x92uHK9now9ktSNums/DO3hBUrXvtHTcN++Wf0pbuPni6vCtmh0YhV40E8Q3h4dGotwQYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t9oQt/prg/zVOv2Gl+1ZjPt+Fbyx0evQyybcWcnZJQ=;
 b=PZnihQdhwfr9M9G8W6sSRY9NKBfffPBGcCTpcz/nzqOGwFAOfL9NjQi3wrjdkoLcfdaCS1x8wG7/UMdyeto5kVPWdwF+71MRKeBKFH2A/5gmaqdTIIjWPsHGjGPtk1n+E0+0s+qwcy8yEI4tEr+Hr2z6k7nNchn3vKIDi/+wO+AhL59IUd2pm4yEBfmcoH/UIYkQMjrKpEli7U2RUqvqS5ZmRJ8lK3l6qtPtI88zTv0hwEM/wPhEHuDZ4Xrr9tHFVT23nRdn6qwxSR0Bv1DdCSrVfCe/IkNo4p8F42QQZGgoPd0DHxn4pBm8RqYp3lEW4K2fj7gc37oLK1wBSyzdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t9oQt/prg/zVOv2Gl+1ZjPt+Fbyx0evQyybcWcnZJQ=;
 b=nVHuHLcLj7NZwCIVDnloevC2oW2tlrkQl69YjlPjxphjboS8zHRkodgRjfpm83NWWuvlw5i1h8TmDxwbs7MRhNfh6PB0QKvVRVuj/+Jbs9FH1l3b1nOqAXuGW6g0U9TRoHpdGMDxP2554cNCIZEWb18C986/CIh3YD+OqyUMPpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 12:13:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 12:13:32 +0000
Message-ID: <72888d6e-db5d-4c27-915a-90f507eacd63@amd.com>
Date: Thu, 25 Sep 2025 14:13:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix for GPU reset being blocked by KIQ I/O.
To: phasta@kernel.org, Heng Zhou <Heng.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com, Emily.Deng@amd.com, Victor.Zhao@amd.com,
 Felix.Kuehling@amd.com, Qing.Ma@amd.com, HaiJun.Chang@amd.com
References: <20250925094334.2012248-1-Heng.Zhou@amd.com>
 <4e3e1e20fe4842f4a7cc61d6c47e270156c2e87c.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4e3e1e20fe4842f4a7cc61d6c47e270156c2e87c.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 761ebd8d-08ce-4bf5-7da8-08ddfc2cf1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWhWaGJhMlZpSnlDS29sTTlqZERsQnRSejRRTGlZMXRKLzdwcHk0TmN5Q2tl?=
 =?utf-8?B?dU5DSldnb1p2TDBuRnlsWDdqTHdtMFQ4ZDM3NUhUUnZDcU5NbmhEN2ZnSVd5?=
 =?utf-8?B?dGRhNXMzK3NSRFlPZ0tXV01vUWlWblJvMExhUW5rN3F5THF3ZVoxT3EyTUht?=
 =?utf-8?B?SHNJQjNJODRHSE13LzBIaFBJMTUycU14cXo0S0x1NnV1azBzMmd6YXRqalFB?=
 =?utf-8?B?MWI5a1Nac2NKdXhuVU9zNHUrelVtTWQyQ3praWdXb3ZEMTRKNTAzMDM4SDVI?=
 =?utf-8?B?alVwRU83Q3VMYmNkOWRZSFJWMlN2Zm9HZTJNVWwzZW1IbmhBalZOT3k5MXAr?=
 =?utf-8?B?Si9UdmoyeG9pUlFRZXcxSzFlQ0x1Z0hSVjNmTmlFWFRrUmc0RVJmd2UxakdO?=
 =?utf-8?B?L3lCWkdKTHVsVEx1YkxTcmZqb0dTeEhHU1FDc1RNSjdmVHUzekJYam1QUlJn?=
 =?utf-8?B?SUdyckt3Ui83b0FzcC9MT05WajdoSm1qek9pWEE0V0ttSHowQ1NaMTl1WjNV?=
 =?utf-8?B?ejBFek44ZVBEZExpN1JBRzFZc2FYYmVBVm1SaEFaeWdyNGl0UytBaVVYWks2?=
 =?utf-8?B?dnA1ZGNxaSttOUsvcUtMOWE5d1NEQndNc0xuZm1LN2dGUE5OSmNGU1ZrR2dk?=
 =?utf-8?B?enhNS2dzYkQ4UUtMY204UmdNaFR1djBHQ1c2WmR5TDY4RkwybmZ6WSsvS1Jv?=
 =?utf-8?B?V1dqSGY2SGg5YmY1SG9ieWxUbkU2OXJ6UkcyRERzdkNNYnNhZEd2ZnN6ajVz?=
 =?utf-8?B?bVJueWJrdGhwVE44dHBlR1BTSjdUSmw5UTZrWWYyVEdoUW9BQTd6aWJxK2ho?=
 =?utf-8?B?WGhQemtFM0s1MGRESUgrbE8rakdWaUZvc0VJaE1ZSHNDcHVwdm5aYXdoMFRJ?=
 =?utf-8?B?ckljaitTMUpGMTFKZ1BOK3FmVUVPYnlDQkh6YzZDcS81bjh2ZFYycjVrZ3k0?=
 =?utf-8?B?QkxSTE5SeWgyQ0lrT2ltRnNhTXFtOGsxQVk3SmE1R0EzNUd0S0N4TEJDWnhU?=
 =?utf-8?B?cXF3a1BDU0JvWGVDR093dXNNSCt4ckJITnh2Yk1XZ0hmdk9JTVFlUFhhMjRN?=
 =?utf-8?B?eXRySGhhNFFSaVJGSVM1bjZlS2ozTmdWa2w0OXh1cUZLVTV5WFlRVkFPd2ZG?=
 =?utf-8?B?cStEb0F0aS9PWTVMQUo0MGdHSDFpVmRPc1NoeEdhdmVsYXNzZUFEZXJ0MUcv?=
 =?utf-8?B?aUoxYTl3YUNwT3R4Nk1jZEdKdVRyeHo4VWhnZ1g3SnAyOXJjZnY2bkVmdW1I?=
 =?utf-8?B?UzVsRGFIeGtRNG1hNG5yV1Y4NUpKR2NCTFJBOENwU05XWjBQcU01bnVaWmQz?=
 =?utf-8?B?QzNDNHB5TERTeU1DcDEvRkpGWFA1OWlkZmJkMjREcHFjN1NqdmxuaktQakNu?=
 =?utf-8?B?U1gzYjdCa1ZxN1p3Z0dhc09PcUsxTFZ0KzR4dGxWZUFIZDU0RlFOVlo4N1Jn?=
 =?utf-8?B?OU5uM1k1VUtTMmc4N1pGKzYxckgyTjROVFVyRkE2emlkVEJVaWk2NDd5VG55?=
 =?utf-8?B?dXVKL1JhVy9nbUxlWDduZkVSa0lVbDcvVmtkS1dmY3lHOVVsZGpFeWVwUVlj?=
 =?utf-8?B?dFFpTk5lak9QUkNaWE5KR3JCWFl0SkRZREp1dzFjTFBWV2FoVmdDN3JpZnpM?=
 =?utf-8?B?Zlo1amgxNjlxdFV5YVFMY29vNlpxSXJqOGlpRldZMENEQjBLQWRIbU1ydnUx?=
 =?utf-8?B?Q05Bc01vTlBTbXJ3MUhtbkQwcnM4WFhlVEs4b2dQTVFtVklDTFdPQ2hSaUFZ?=
 =?utf-8?B?bmxpN3JSeW9IanFPSzJHYkErMHZZenZTNlpvY0pKVityRHBBMGZ3aUcyakND?=
 =?utf-8?B?Z0Mxd2szbkgvOWE0TnRrbTcya2tNRzkvaHdrc2ZVUGRvR2ZKWjBvaXBFdW9k?=
 =?utf-8?B?RENGSHdTS1hFVTI1SnpaYzZkUng4TEVQbUV2UXlYSkord2JQMVJ2MFQ1UFJ6?=
 =?utf-8?Q?RS3kdpMWoKI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czdwVktDSVZ1VFR5ZUlObWNYQUE4VHRDMEg3bHloQ0xEaXJRQW5wNDdaRjZP?=
 =?utf-8?B?VG5kWTllSERCc0lLa0oreXVVamx0Z21lb1JyanJFS1NiOFdubW5TVWVVOXJw?=
 =?utf-8?B?TVFIR0NOemRtZFBuL3c0eDk4c1BYTWs1MnFlK1c1N3gxSVJ3dnFDTGtYQkhP?=
 =?utf-8?B?dEFpV2VlZXpyUC9ONHllOG5vVUJXYndRWkFlUm5uUDBoOWdKWUlLaDJCaWZ3?=
 =?utf-8?B?ZGlVUHJYOW1LUk0rL0ltb2NkUXRHdDJxbGxwbFQrV3FaQ3ZDY2x2bnZpbVVv?=
 =?utf-8?B?cUlKNGRyTHVkRHliQzMxM1F4THNEUDZFNFBMSVVCbGR3Y0dpMXRaTkw4UFJq?=
 =?utf-8?B?aWxZV1JObmFFamI5YkhkWGl4VjFweEhoWGZ6QkM2b1Nva2lUMVFjeUt5NXVy?=
 =?utf-8?B?Y2t0bHhhOXBMa29FTW9oNUNBclZGVGQ4MzF4RXBOM1FMZkh4Mit5R0tUd3hy?=
 =?utf-8?B?TjloK0pJdEJ1MmdWYUIwZEZnWFRSaVJiZ0d2dFFiTUVNVkU1VnJwbURrWUxO?=
 =?utf-8?B?b1gyWS9GcUVMTkFyZFV2S1ZSSVRlanFPeHdYTS8vampNWEt2eG8vaVpWbDVY?=
 =?utf-8?B?Z3dIdmdhUUt5Y0poTzFyaTRIczZ6eHVHSlR6ZUE5bTRCV1lrMTRXZWhXTStn?=
 =?utf-8?B?bWF2bk9IS1VFS1Mzek9ZblBoSUI0NHJIWnhwam1tRVFxb1lXUkw3Qkl6Qm91?=
 =?utf-8?B?a2tnd2pyMUxRWis1QmdiblV2dE5WaTRYWWlIVFRQM1hnYUJEcHlmcUd1cjZk?=
 =?utf-8?B?OFVsNVpDR3JVckx3MWhzeXhCYXQzcmRQSWhaYWlFSUlYSk9PWGFwV2ZZazVW?=
 =?utf-8?B?OGNScjVFOEw5c0N4ZjVTVFU4aHM3NFFXMTM4YmxvQ3l3dG1JWEtrOUFtVEdP?=
 =?utf-8?B?WnpOMDRvU1VmY1BJY1NmM05XbTJlNDUrb0tjK1NDSXdOYzNneHRiNjFjdm8y?=
 =?utf-8?B?T1ZodFRZVVkzSitCNDJTQ1NQTDhEMjNtQW9wY1ZMbWRMN29nS1p3eXlobm1h?=
 =?utf-8?B?K0RqYzc5ZFYrNFlQaUJDb0lJVU1GS0RteE1NRmpvSzdqQjBmbnNDcFZKWWZl?=
 =?utf-8?B?cFZrWUkxZjNQRU5ZOVZtWkN5UkJtWTVWSEV5Z0tXZ0o3UFp3MGpCL0t0M0NI?=
 =?utf-8?B?WUNDZGNORjUxa3Zmd21EOUYxUHJydnZNa1pjYlU5aGZaMksyZkNlK25TSUpz?=
 =?utf-8?B?UkU2WkhUbGQyTDBMTTBzcnF5a3hYQ2J1YnZ2LzBRY1Fjbm54ZFh4TkQ1MnZF?=
 =?utf-8?B?K2g0eWhxcHJDMmp5VzhjWnlMeEFMUzhNSVR1VUN4ZWl3Vlp3ZEt2RjNPUXdK?=
 =?utf-8?B?SDQ0clI3bFV2UFhGV2RNZlJ1RmNtY3BQNkNHOGI2cURabDVRa3dORVQ1MDlp?=
 =?utf-8?B?aENjWmNqOEdLMElxSWhFR3VBU1cybFJER1ZqeDhBN0F4L29wNlVGYk5sTGhw?=
 =?utf-8?B?QXV6ZHZZYnhRMnhyQVM0N3g2TnBrb09rTXZYZzdlL0J6dm5RaHBWalZ3WjRR?=
 =?utf-8?B?ZHQxOEhuaVQzdGppTGd4MTNITDB2S2c2d0haMHpoWnJNTWlKbGgvUlBLV0xG?=
 =?utf-8?B?Ym9nV29xd1p1N2R0TUJ1VVlkalp4R2FSOVZoQktBTlNtS3RSd1B2dzdRcDJR?=
 =?utf-8?B?WmYwNm90MTJrc29VWE0wbjJta0lJelI5U052cXl5VU5BNVdvRTdtdS9NNC9z?=
 =?utf-8?B?V0c0d1pSaGhJbHRhMUozS2Z2UGhmMzhOMjQyS25lMWVmZDZ4ckgrSEpLbnU2?=
 =?utf-8?B?b1hOSWFHZ1NxLzhQaVFiaU90Z1FQVVFRTlJia0ZnZHo3ckxSd1VIWVVQYmtx?=
 =?utf-8?B?Ylc2UzI3R3ozNUk5bTNvamN0TjFRMjRuSzFKdzAvU2JOcGszdy9DcWpWc1J6?=
 =?utf-8?B?WEx0SUEzVzhWSm5id05GVUc4NGFzd0s2UU5rM3VCQVZSSFp2MG1xcVVyaHBW?=
 =?utf-8?B?WmZGYmpVOE9DNlZLWmtSeE4veDhVK0RhZitDKzlTNDh2endFT3N2R2dwNXBp?=
 =?utf-8?B?WjU2ZlN0RXFvTENjdFkvWExHMDNBRExJc0VOZ0NobytlSmUrWmMweXpaT0tB?=
 =?utf-8?B?SUtUK24yeHBMMTl4SkZ6djQyUHVPQmtqL3ZNWEZpMEVQUjZMVUlsQUJvSGJT?=
 =?utf-8?Q?R612h5GGBX7/5rKuCGloJ8VZd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761ebd8d-08ce-4bf5-7da8-08ddfc2cf1b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:13:32.1749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33CVRG8o2qa5F0x6yldMOx6hpIK+gPIwOtrOPgSkY2AayIKg8z7R4tY6KF+WP0+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

On 25.09.25 13:55, Philipp Stanner wrote:
> On Thu, 2025-09-25 at 17:43 +0800, Heng Zhou wrote:
>> There is some probability that reset workqueue is blocked by KIQ I/O for 10+ seconds after gpu hangs.
>> So we need to add a in_reset check during each KIQ register poll.
>>
>> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
>> ---
> 
> You should create such patches with git format-patch -v2 to create a
> version 2 field in the header. And, ideally, provide a small change log
> below the three dashes like so:

Alternatively depending on your setup you can also directly use "git send-email -v2 ..." to send out the patch to the mailing list.

> 
> ---
> Changes in v2:
>   - foo
>   - bar
> ---
> 
> JFYI for the future; I guess this patch is fine for now.

Yeah, agree feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> and push.

Regards,
Christian.

> 
> Regards,
> Philipp
> 
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index 89fc1015d3a6..7f02e36ccc1e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1102,6 +1102,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
>>  
>>  	might_sleep();
>>  	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
>> +		if (amdgpu_in_reset(adev))
>> +			goto failed_kiq_read;
>> +
>>  		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>>  		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>>  	}
>> @@ -1171,6 +1174,8 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>>  
>>  	might_sleep();
>>  	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
>> +		if (amdgpu_in_reset(adev))
>> +			goto failed_kiq_write;
>>  
>>  		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>>  		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> 

