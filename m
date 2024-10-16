Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E25DD2069D
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 04:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33CF10E087;
	Wed, 16 Oct 2024 04:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pn2e4uCe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6AA10E087
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 04:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoaE3Xbmi3nQZc4MIjwMCRJUu1C2eFF6m7fcHMtX+gF70RcLLQxasv+GURgUPsI61DAh3J95E4rK5ayZKKDPdac+GTu+z+giMmc44gKWTVymj7PnskSwQs7qXit0j0Qc0YEu/1tTzYInDdq9fJveI7G82njpwLvKB9DM9Yg+2uEA5ajCcapSkHDecQ+bDQYyNZwYaGFbu71eeKHUR949l1VrvOulUmf+4QTkZMvShw9udKYf1gdgznIv1S8nxjEbOD2hPZ0GBXojCEYhO/diPvxgr8mMNVS79nr4AJ9J58svbFP+sft1nsfO7GlbJVcRIhU7rnB3IojynJB1/923vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWCCgYngnbdsYjT7GsKWLcNf1UNNatwY/vDFA27Jxg0=;
 b=qCXcvPFzD/NuQeNZY6va9inCoPOf7yYhqfpFxe8faNKgPlNc6a2qs0PMT/HCnRa31kqFAtqMVZ9pW0Ctkbxsv/x3YVxaA4eAJDipUH7xOK9LNidjfH5CmQojK0d3OGSuBrxmNeAtNlEpRYRPnCKH0LQPt+xO3LrJzjrKlFVP0RYvlNtTZ93FP+iRw5vGVWKrsGthaOGm+Uu4rsI+4kOcW2mVZz+L4stN6+1QetJGhcWMOvDJMvVyELMryLdeyj+hJ8uiT+0Bd/K8/vnM51iH/AVNiWeisbZohMeWVmTm8KzbBSqVaPb00MPBiZBE6JyxPDY00H42zXKA9cW0zspiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWCCgYngnbdsYjT7GsKWLcNf1UNNatwY/vDFA27Jxg0=;
 b=Pn2e4uCeUqYe2AHPm0qr1RuW18aq05WUUT1yyhHqNF4DaBw/nLDLd9QiO1jxseibeB3/vrA2toNcsnQuYpBVlYHdyFwI5URsp1ATQdlKevGLfVZvfo7uiN5QZG96YTSfPXEOMXPX6/zkbAu4gnlo8/I9vu1jUknvgnyXz6HRUio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 04:41:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 04:41:05 +0000
Message-ID: <349b1d5d-7153-411c-9667-fbb5c5f24110@amd.com>
Date: Wed, 16 Oct 2024 10:10:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix random data corruption for sdma 7
To: "Min, Frank" <Frank.Min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Gao, Likun" <Likun.Gao@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
References: <20241016023558.22970-1-Frank.Min@amd.com>
 <SN7PR12MB69328B4538D6D15775646499E9462@SN7PR12MB6932.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SN7PR12MB69328B4538D6D15775646499E9462@SN7PR12MB6932.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f71a9d0-f7d9-4c94-390c-08dced9cbe88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmNVcFdsVk1CZVFZMTNlVVZtcGtCRjZNS0ZQT1gxVzlmSU1CUlRlT0RqOXFs?=
 =?utf-8?B?UXVmeHVBYnc1QVlVQVZvdFNRTTZYamZ1REgvV05sRkpSdXcxL3Y2RWgySGdF?=
 =?utf-8?B?cFZIMURxRE9tSVBFRm5MdCtJb0JMN3E0TDd4eUQ3aXZuT3FIdWl5RXZPbjNE?=
 =?utf-8?B?MTF3Yy8wRkZkMVBrL1BWWk5HaDl3MWtwenhPK2ZZSXFnZWdnRGMydWxnYklm?=
 =?utf-8?B?cGxtMFM2c0tYUmlCZENNZFNMbWEyOUVPMTlwdlFVNjV2K0t1RHVPY2E5bEp2?=
 =?utf-8?B?WEpYTTZTQVduOGdSelV2QjZZdmUyU1AzWVVPOXRSNTMyUXpLUVkvdmZhMllU?=
 =?utf-8?B?SlRCSzBxc0NrYi9aRWY2SVhqRytnOGNURVNJcUd2VjFKSGE0ODFSbjhXbFU5?=
 =?utf-8?B?NjJHTjI3cmQyV0N6ckZnMVQ4S003WTBJTDFEdUhFNm81OTJLNHhXV2RhWU02?=
 =?utf-8?B?NXB0bFpxaW1DWUpNSVFMK3ZaSWRJbmRSVENrSGVoQUZQOW5pa1JPOWRka0pn?=
 =?utf-8?B?aUkwRjV5S2h4NzZDZXJ3K3h2eGJ1ODNzZko4R2pGQVl4VER2MFBIVkl0ZlA0?=
 =?utf-8?B?T0xGaTh0UDk4Szh2M0pMYlg4eXhRWUxpN3M0UnFBSWFiTWllVU1lQmRFdWJF?=
 =?utf-8?B?c05IQXh0S0krTXlSeThYQnk4akI5ai83Z255RFZlM1h5emQzZmN6L0tHMWJV?=
 =?utf-8?B?RFB6YU5HWXdqam8wdFZtY2tWRGdNaDFmeW8wOEsvVTRqc0JBZS83dmd5dU4y?=
 =?utf-8?B?emRkZFdDbFpCVFVnYnRhQjNOUjhXaWNZeDJmS2FvUTVZTjU3M2ZCRm1RdXFS?=
 =?utf-8?B?WGdJZi9WN28xUFltdnRFMThpOWcybnFVbEx5RVZyZUUwaGZpcHBUWkVSWlpJ?=
 =?utf-8?B?V1Y3RHlVT215ZFE1WG9vUVZHZittMjZoam53dWU3Smg1d0JQaVBmd21vY3J6?=
 =?utf-8?B?eW5UVkFoUFFjdm54RE1peWhqV0lITVJ3dUhLb0FZOSs2WGNnMS90MDY4VUtL?=
 =?utf-8?B?Ym1TVE9UZmpDSFU0V0lUSUdtYVAwMThYOFpBN2NNVk5EdVhTM1hjbis2MFUr?=
 =?utf-8?B?Um1aZGpYRE5tRGhqMVhFTVAvM0NVRTNJQXBlZ29CQzNvT2VGaDlBaW1aZEt2?=
 =?utf-8?B?aGhFVWdvcGtxZUNKMFd1R3ZRTFQ2aHEzZ1dTb0NBaTRCckVWQTViUW5wY1Rv?=
 =?utf-8?B?S2toREtmUXFzQVA1QXZudHVjSUQ5ZDVFSlBvRitra01CajBoWHBtUEFvMlJL?=
 =?utf-8?B?WVBnbFBBYTlNejZBN0w2emhqWTN3UnhGcWg2OEdXZGNRTTRxUWoxWmI5a05P?=
 =?utf-8?B?UHVYVmtsdUM5SUdleEQrbWZJVS9RdDlvanpER0xtR1kxc0pJc3E0b0sxb0d1?=
 =?utf-8?B?S1I3Y1JXdnZDbGdsMHh0MndGS0RLQWxieEllMkNmekNBNHIzZ09wQjR3MzRl?=
 =?utf-8?B?WXYzRFZHbC9NQ2JRQ244QjNBQ0pBcG91Ui91M3BHQkVZazBrMFRQcVhyMGhm?=
 =?utf-8?B?SE11QW8xK0VhZ1Jxb1RRSkd2d1IwVHZlYVp6SVZRWU14UXNYanpBMDBWV3I3?=
 =?utf-8?B?T2xsUy9qTk1hdEtQOGNDRTRHR2o5Qnk3Y3ZPWExKN3BjbzdGTllBVzFmWW81?=
 =?utf-8?B?LzYzRUhaR2ZCV2NXbGpRVXhsL1Y0d0JpWnlkT3NlM29NYUdJRE5HRlhyNUg0?=
 =?utf-8?B?QWhZdjBydjRTeE1PeFlGRGtrcWdwMTlQd0lMeG1SZXZMNWdKU2orK0w4ZEFE?=
 =?utf-8?Q?Pn7JEzlJhnKID34CBuGVg2/MHfEqcK4gZCsaK6J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk51R0pjQkgzVVB2RUd4aXBURXFKNHF6aHFZUWdicUJuSEpMdW1zZEV5UmtF?=
 =?utf-8?B?Y09aeE5lSEJodjJWVHdBeHF5cDZqd0tqbU5zM2xnUTd3UWZQTm5RcG9mMTc2?=
 =?utf-8?B?RmNhUjZ0a285U1NXbjcrSWRvWDNFTHFrV2svWVI3VUNzUURpNjRsL2NySndn?=
 =?utf-8?B?d2NnM1NUNUVCai9qNUxaY0R0elM0V2FpaDlVcVZWZ1o2YXl0VmlIZzhZcHhR?=
 =?utf-8?B?ZkxKWUpiNHhRc3NXbSt2d3FaYUoybENGcVQ4S053VGEzR0xyOGFNRmdhT29z?=
 =?utf-8?B?N2JvR0xwNVdNNEpzcVlYSWFxUTR2UXdGSFRuclVRdHRCbDZORUgvVXE0Wisw?=
 =?utf-8?B?TG94bG9qbEI1VVlKaUpuTHNCR1NEWVN4NmdTUGh1MmlXMjJFaUY3MTM4NDJ1?=
 =?utf-8?B?cDZ3d20yQVBhK0FldDVzWFJjdFNQYUduek9NZk02TmpYWGJVVGdHQ25kTTd0?=
 =?utf-8?B?Mmk4eldzdXVKWVpOSTdBTzNGTGJOcnJaK1ExZTUxM21RdUFBZ3RSbUROWmVL?=
 =?utf-8?B?eUxMa3VPbXB1V0VLYnM4V01MYTRSSG12cVZ6SlJMT2ZYYmd0S3pYeXpoU0c0?=
 =?utf-8?B?TUw5ZFgvZTVQV2pqOHYvalRsUFc0dTBLdkp3RDZ5a3R6cVRkVjg4RWoyUWtS?=
 =?utf-8?B?Ujk4aUhJUU1Ea3hZSFRpY1lPZC9xRi82bElQdkk4UUErRkNsZW5BT3pEL0tB?=
 =?utf-8?B?Rmcvd2t2N0ZpOTNDdWFjT09CUkxidmFQVyt2UHRJakhhd1llV2g3UDJoQzRu?=
 =?utf-8?B?c1JtdEdPQXFqb2R3VS8vZkNkTDVIaVlobjNGVHhCZTdFY3NqaGRNU200Wldt?=
 =?utf-8?B?cEZUVTI1aWh0ZjJ2TU1uWU9COU1WMlMxVlFwb3p6N1p3N1ZzMmNMVGpHOHYz?=
 =?utf-8?B?TXFEYkttaTcwWmV6MWxnUEZDdnhPV245TE5ienUrMGtISzZmTEZRSDlhYlll?=
 =?utf-8?B?YmZ3R2xKSVRSM0JwMExFUWEwWXVTb0dtenZyTGI4bzRwL3R5KzVCcVZnZHBD?=
 =?utf-8?B?d2NUcUpwM3ZiZUpkY09hK0pnWkkzbjNrTlJsVTZibmhUMC9VVG80eHFkMG93?=
 =?utf-8?B?V092TWtkc0xIYnByQVl1cGVocWVKNkl5dnN6NXErUngwL2tGM1JlVlBoM0Rk?=
 =?utf-8?B?c0ZPZ29WUlIxcVc5ZnBSOGZLSkNlQlB4aGZiVW41Z1g1NzBRdTk5YS83ZXZm?=
 =?utf-8?B?QUt0Y3hyUHRQaXBsNEc1NXVQc1AveWpPN2hsTGxrSFZ4eW5YWUdjWHJiMzN4?=
 =?utf-8?B?ejBBQjZhTjdOSkIvNG1PRWhwR0MzaWhNQlU1dHRmK09pcHFmYlo1MUZHTkE2?=
 =?utf-8?B?RVJYVElZdmJaS3pjSWV5Sk5sNHBIcHllZk4wTy9KUUNrVnpkbHJ0bkxBemRk?=
 =?utf-8?B?Skh0elFFanNwbUtxY25zNSsvZ1RLVEJLRlZRa3FEWnJ5UzBIcFVMcXNITGRt?=
 =?utf-8?B?TVBwSXgraXpTa0hoZWVNaDhQNSttamJ2clNrV3d1dU5DNEwzMFJPQWNmODhn?=
 =?utf-8?B?VzZxN244OEJBOU9aejIvR0Y2d2kwM0JVbEppdCsyM3hqZUxPdTBPc2FPZXAv?=
 =?utf-8?B?ZlZUdjE4bVdOaXBaT2hSb2VHZmhLb1FYS2hYS0lSNWdWaFRVeHFxNitvak9N?=
 =?utf-8?B?cFY2U01CMk5OM0JSaG1zMk1sb2RaK1N3bUxXdDNiVEFCWUJIWjVUaTJiSWhv?=
 =?utf-8?B?bm5nYmhLck80bi9tNDhFeXM0WC9jQzBhR0ltcW05K2RoTzQvU2NjQUVZYzJ0?=
 =?utf-8?B?b0hvTVNVQ3hYanRRRTA3QTFKcGVJVXg4bkNuaXpMM2hPOVpLT3l1cnh3THB0?=
 =?utf-8?B?Sll2aHpZUWdCeHZxYVBtczUvWkRBcW1IV0FpQXAxS1dCNkhLNUZPK0JpMDVx?=
 =?utf-8?B?MncwVy9BNnN1T1ljQXlNZXFURG5HVjZGTVl0bWtJalBzb2NOZ2pWVFdWZllC?=
 =?utf-8?B?VUhOWmVlVmMvckYvbGdocVJCYm0xVmJPUEh1Vm5XT1hVWWY4QUdiZmZzeDB4?=
 =?utf-8?B?bitTSzNyS0kyQUFGZ094TUxWanNyMkd4emI3ck1RRWlLNTRTZWtxVXFtb0d2?=
 =?utf-8?B?WTF3emVXc2I5Z1RYdG9tVDVKQWVxcTdLYXMvMXhJdDczYUVTNHhUM0pwOEVy?=
 =?utf-8?Q?GKbr2RtPsyYp5Ex5zxMnuAqr0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f71a9d0-f7d9-4c94-390c-08dced9cbe88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:41:05.0451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK/mejn/jnR3eiEXX3u4E208DSGRSsDOzspVuLXRlJIUKxwKRKw7C47ZT0RG35t1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
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



On 10/16/2024 8:29 AM, Min, Frank wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> From: Frank Min <Frank.Min@amd.com>
> 
> There is random data corruption caused by const fill, this is caused by write compression mode not correclt configured.
> 
> So correct compression mode for const fill.
> 
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> index d8cf830916b9..18e73057e6ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> @@ -116,11 +116,14 @@
>  #define SDMA_PKT_COPY_LINEAR_HEADER_sub_op_shift  8  #define SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(x) (((x) & SDMA_PKT_COPY_LINEAR_HEADER_sub_op_mask) << SDMA_PKT_COPY_LINEAR_HEADER_sub_op_shift)
> 
> -/*define for encrypt field*/
> +/*define for encrypt/compress field*/
>  #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_offset 0
>  #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask   0x00000001
>  #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift  16
> +/*sdma6 use bit 16 for data encryption*/
>  #define SDMA_PKT_COPY_LINEAR_HEADER_ENCRYPT(x) (((x) & SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask) << SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift)
> +/*sdma7 use bit 16 for dcc compression*/ #define
> +SDMA_PKT_COPY_LINEAR_HEADER_COMPRESS(x) (((x) &
> +SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask) <<
> +SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift)
> 

This doesn't look like the right way. The confusion is there because it
uses SDMA_PKT_COPY_LINEAR_HEADER_OP instead of
SDMA_PKT_CONSTANT_FILL_HEADER_OP.

It's better to

1) Bring in sdma 7 packet header definition (Mixing with SDMA 6 is also
not good)

2) Use SDMA_PKT_CONSTANT_FILL_HEADER_OP instead of
SDMA_PKT_COPY_LINEAR_HEADER_OP

3) Use the correct bit mask/shift as defined in sdma 7 packet header
definition for const_fill.

Thanks,
Lijo

>  /*define for tmz field*/
>  #define SDMA_PKT_COPY_LINEAR_HEADER_tmz_offset 0 diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index a8763496aed3..9181579ae6a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1724,7 +1724,8 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count)
>  {
> -       ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_CONST_FILL);
> +       ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_CONST_FILL) |
> +               SDMA_PKT_COPY_LINEAR_HEADER_COMPRESS(1);
>         ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
>         ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
>         ib->ptr[ib->length_dw++] = src_data;
> --
> 2.43.0
> 
