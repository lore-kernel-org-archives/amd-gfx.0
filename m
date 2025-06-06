Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08B9C5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 05:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6D710E042;
	Fri,  6 Jun 2025 05:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t9XbcDu8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A0E10E042
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 05:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go8fVhWaa0hl8ZVtqdTkNQF9GWwN0lF1NY1q2GZumClb7g1BVizJy8iYBOljB2Pg7k8aHkc9CzM131seJlwbbIqUe86eRd9w0vlhVje/GizG5WUE5TzVJ5ocQsbQ1/KYiAkXO9GIfVZ8x2Up45U9GhYTODO+Z8GBITcbiMaMpD1KvKaDn5UGrstvYWe95TNHunRm5ypRmpQgOFFH1HvifzvgUxPi5w6hQLtXSSUYweksNkfnoAOtfSkaxP07eslAUg2hSAH9HzgCIV00mgEOjp2XuCWP5mDM+lLDK8rfEKRU6+eCgLo1hX4fQAErirh4lBqVQryp4i2Il8EQwj0Tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg7Bdrsh9m3uewyWsiZ49AgaW9igZJPYp/UTjcSrWpk=;
 b=V4X6YHEhtRPxZxJE0CKCt5T7bfsguGVWXI55fRVNWdqTgZCTNLu+zaQjZPnqVFb0guYE8wsvylP0AAykAsXmMn8YwO1o2Hq9nVl1pggsglU/TuBSk6by8e+s7TItRFamgKxarWIJX88lbdktEj1517+NFjTas2nfNzbVBhsqAQ1iBv4yRHSCrGrwAtOC9LocqLvx0W+oQ1RVnRFUzxPUqo789iwhoVa15A5Tu00ZcTTAmylebvp8+iaTF6jGhpewEhn8LDu+k2wjVWmYAZC3vB4zG8UsImqE2vmpGfXtYVuALjo+gwBB1MB8cNGlahXtrI/AOD2BG1cHD1xIygNwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg7Bdrsh9m3uewyWsiZ49AgaW9igZJPYp/UTjcSrWpk=;
 b=t9XbcDu80GfK+XX7RwAEHfycqI90we1m6WVKgB0NsnbsA68FadeE6CkPefPomQY0qhPFMk6kpC0HTqh3TPDZwyv5X1WaHlZcCG7qdNbUnJyxOMkhbWLQBIf+L924RbyGoq6wIuUe2GguyZSULbbEhpINko6OrNPjD9BxbIjfk1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.35; Fri, 6 Jun 2025 05:39:18 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8792.033; Fri, 6 Jun 2025
 05:39:18 +0000
Message-ID: <a6753644-2ddd-46a0-8046-6fc3dee426ac@amd.com>
Date: Fri, 6 Jun 2025 11:09:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Move the process suspend and resume out of
 full access
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250604074817.1444723-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250604074817.1444723-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH2PR12MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: ef434079-317e-4cd4-842c-08dda4bc7b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFdHOXRaUkxocGxzZ1o2ekRQRithRjVBemZIZk9HTVhRaC9XbGRoTTBCWnRj?=
 =?utf-8?B?endXTjViR0g4WG5qL0RqUTdhczRSVnQ3ZTNCd3RONWYyeTFoWkQ4VVFsczJY?=
 =?utf-8?B?cDFlSWY3UHFtaXdzaHhVZmJMWXpvR2czUzVoaE5yM29kcDBPeVRWQ0JJb3Nx?=
 =?utf-8?B?WnVuYnA3cFlBLzNnS1ltTTdlT2g4Mm41a1BRUE5WdHhGT01BWXJPSS9rWkZa?=
 =?utf-8?B?K0JZd0l4MUZtWTRmUFZvdksraGdVZTR6VHdpTjNRUE5LZmtmUXVEbzZCd0s3?=
 =?utf-8?B?TVFHVThybFZyb3plTjJBUEVzUDVrc3ZBNkxFTEhZMkljblJvQmVVeUtWbzdQ?=
 =?utf-8?B?TGhGTzFGSnFlQVVZTkozWG5YTEN6dUFkaUpFSUN5bWNOU01GdGRaNXZxOUJF?=
 =?utf-8?B?R0Fma2RWaVZIQS9zVEpEbGcyVlpJeVdLSmxBdkcyNTZBd3NjZGk3SzMxWUFx?=
 =?utf-8?B?cFZYeTVLcVJ2MGVqYVN5bUxreHZBckppRk5ReTJoT25CMmFpVjd0ZEpYamkv?=
 =?utf-8?B?amtGUnV0eXlsdm5tSkhFQjVJeVhFZjlWNkRyZE90bDZKdStsL0luSzNnNHBC?=
 =?utf-8?B?S2p5aVBITmQwbVk3UDVTcUJ2dXRuVlo1WHE1bVdKMDcwSi9GYWxhazZ0cU1B?=
 =?utf-8?B?ZGxvM3NlY0pRU0ZkSGJ6U0NzenFaS0JaQWw1QklKSGhhYXE1QjFaanJMZTJ5?=
 =?utf-8?B?OGhuYTFXTHl2RzZUeTk0TjdVOFdNVFRleU81RHMwUHI2QTRhU2toSi91TnMw?=
 =?utf-8?B?UUdHMWo1OGpXYmZjV0RxUUk4OW1OdTI5eXQ2WTVuQ3NvSTRqQ3pXZXpTVk9P?=
 =?utf-8?B?TlNocmo2aWFlbDN1ZDlka0lYbVYyNmRDVGR6S24ySjRha3hqYTlybDRrYUQ1?=
 =?utf-8?B?TFdybFNDSVp5dmtWOHExVy9iNmd2dGZoZTByQzZRTUVyTFgvN3daUTlUdjlo?=
 =?utf-8?B?eXN0ZzcycVQ5cE5xR1hVU2VTS21YblpPMmlTU1pZUGE1Sk50WUdaWjF1ZktK?=
 =?utf-8?B?dWdIMlRqbnZrdVVaOUpVOXBueHlIUDhxSzY0VlRSYzU0ZG9kVjBqZGxpTzJo?=
 =?utf-8?B?Vm9ndGZIdGNJcC9USXR5aWV3Wjg5Q1VQUi9OWWw3RFo0L2RRdWRLdllhMmlU?=
 =?utf-8?B?UXJkcXZHekYyWHNFMUtFaVdsQmxsVEdiVGNSV0VEdVVvZ3FNWXdjeTdHUHVC?=
 =?utf-8?B?VjR0c1cyQmpwQ0ZEN2NmazAyNU0rdnkxWkoxb2FqYlEzc2w3cDJrYW1sTmd3?=
 =?utf-8?B?enhWaHVoaFp2ZTY1L3dnTU50bTBDNkI0Q0tkcTNQcW0vSFpoVGl6b3BaeUJK?=
 =?utf-8?B?dW96ek1OSFRKc0lHVDNzVHVzMjllVDlITXcrQWNQOHQ0YVdhU3NMcXhpZU1D?=
 =?utf-8?B?azUxZWFnZjdTb1diRW90Q29iYU1zUWZKQksyZ2ppc0xBV3JpdVlmSERKZkVs?=
 =?utf-8?B?WkRoekkzTlI3OWpYaEhSeVlya0ZqSWdrakVNYmJpVW5qWXVTVHh4MHhwd3Fi?=
 =?utf-8?B?T01ZQmZmdWhvaWNhSEpwVzBXc1pmRUhPMHdybXRKMm9UZUpTVkZxMUErTjEv?=
 =?utf-8?B?OFVRM1lsL3pVNGk2Z1dLOGV0THZFRTBHYkhmd1krcjN0Mmhhb25rY1A2UDZy?=
 =?utf-8?B?bFhOY2MxM09lMlI3Y0dMckh3T1l0Z1U4SFdOdHQ0SWxBbUNnRjRtWWI1bXJt?=
 =?utf-8?B?VTJHYjRtZ1NhNlR0cWd2NUQxODhtZlpBcng1K01URHNTS3M2RzhaT3FHbzd4?=
 =?utf-8?B?VXdSK1F3RWFmY0hlWnMvdWRObFA0bHRZUjdLaG9pN2k4SWJ1SFpqQ3RPbFhZ?=
 =?utf-8?B?MVBwK3Vud2NiK0VOTmg2RDlUMnRiczhTWUxWTjlNZk00a3JGTXFFTkJialJX?=
 =?utf-8?B?SmhHbGZIUmtLZm1aZGFyNEpoNE5PYk8zcHJnSkpmSk5FbFlERnptb1dyVHVu?=
 =?utf-8?Q?XpX1qRuXu1k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdzVUhoWGkxTUI4cWxRRW1iaHM1a2FVSGJUdkltNFpzUWxxZUN5Nlh4M1M1?=
 =?utf-8?B?cG5uZU9JTXZCSUpDYU9CNWQzWGczWFBYTXZpcVFmYmt3SzlNVTc4VGVTdlh1?=
 =?utf-8?B?bkNRRmpKNzlBK1BYMUllZkZqdTl1Ky9zWFVXQmE4WEJxM0F2Ny9JRFlZSVNs?=
 =?utf-8?B?Wnl3NDJIRFp5ajk5aHBZa3FRVWV1b1RmRUpFVm5HcDI3VDVuVWd3QkNGUVp5?=
 =?utf-8?B?dkxXTmpNeDgyQmE1ZkhmMWxqbzI2REpvK3VqK1BVVlAvdjBoa2tvTllERnla?=
 =?utf-8?B?MTRLS2s2Ym54UkJvRjBpeC9TWFJSR2ZvUlBPTWt3MStVbnhManl1WFNRTkZk?=
 =?utf-8?B?TDFWZ3B0b2FuRmNTRUJPUjRITEdUdktEdk02N3owQUVMNUhpcXZONlhYVDdQ?=
 =?utf-8?B?N3c4QVNUeTJXS1VSK3dYUnBNR1NjVURnbU8xeXpoVjNaZFlZZ3FSMElQc1JE?=
 =?utf-8?B?alU0V0lUSGRjMTdwUGVBN1YydFdmUWMwZ0Q2dUxwSW11YTlha0JIdGtpNzdL?=
 =?utf-8?B?RTlFR2Fqbys4dUp1SlU1RnhydXlYeDZqUDhyVjkyZE1ndUp2WjJBMHBMeEI5?=
 =?utf-8?B?c2FIeVRFUTlncVVZWE5Mb1FmYzJqTURBdmxlQWNPNHpaU2x3U2M1UUxYYS9r?=
 =?utf-8?B?TDljU0FZVzRqaDVMMXMycUNHaWlsODR3N01uRlVEWVBRcExtRGFGbUt6SzZQ?=
 =?utf-8?B?eG1HM0RuejY4Z1VQQmZ1T3RqYWZkOFEyMUhnd1o4SStFT1NHWk5maUxnalA5?=
 =?utf-8?B?ZmNtOWQ3a2NiSFRSdndrU25pS1NIYlZ1cGZyK2w3Sk9LQ1huWUVYQnkrQnE4?=
 =?utf-8?B?QkQwMS9hdkhuTTdmUEFTb25aanJnSUFDUnV5blF5YkFqTFNYZDArUkczWHV3?=
 =?utf-8?B?MFBrbjNsNjArUE95QW9QTWlIbXNERXJpeVF5c0RjZENDVWlmRjBiTy9QU2Vu?=
 =?utf-8?B?RUMwY3JDMHJPNk1SMGIzYnIzRk9DY2h6d0htTy9ZbFNPZTVBSFAyWDNSZ3hs?=
 =?utf-8?B?ekdlM3FEZXlvZk9kdnlmeUN6K1l5S0d1aytXSXVsWGdpbFVPMllRZ042bEhu?=
 =?utf-8?B?ZFZ1RFBXMi9JZnAxVGhVZ1J5Qm1pWkRyY0JlSEJFR0Jkc1loZG5HRHVkN3RL?=
 =?utf-8?B?MWVMSjMydmJXSTJ4T3VhbzArTXVXU2ZMeHBraStrZDhnN1dlUHduTDVKcGRu?=
 =?utf-8?B?VmRwYXFuWXJQL1JFT3lqWGZUZTF0WlFaV0Ftd0pXWmdXbTJJakc3T0Y1WjZZ?=
 =?utf-8?B?TjBPY2ZKTEhLeEc0NnRkeDN1UjRTM1luN2Y5TklRbFhKd0xxOEI2YzE2KzBu?=
 =?utf-8?B?d3ExWmRtbXRjK0wxYVZQcXZjY2h4WjRuNnpBYk9nRENjZUptVjNjNExwQnlw?=
 =?utf-8?B?RzE5aUFZb0VIM05xOHBPUlliWTR4VFcrcFdBZ0ZhVWhSbXBSUmU0ZTROUVBi?=
 =?utf-8?B?M2FFcElaQlk1Q2ZyM0xvckViK2xmT21EVnJRTlliRXVzbk1TZ3FiVGZldXc2?=
 =?utf-8?B?dTZXUnQzWnJKZ0ZTbE0xbVN6RW5Mc0JpY2J6N1pUQzczOG1XSWNUSHArYjlE?=
 =?utf-8?B?OGdGT1lzM1cvOW9icXBmeDBaakdRcE5iZ3oxbXdWdTlRSlp5TWg3MnZDOXpz?=
 =?utf-8?B?eUw1UFlCeHYreElBejlCaWIyT09BcTRqaGZSNVB1Y3h0R3dvS3h2SlE4VXUz?=
 =?utf-8?B?M2NocnZBcFhiUlM1SjVDUlZnZDBHOG1CYXptemhubkwvRWZVTEJXRHRBM3kx?=
 =?utf-8?B?bXd4ZnQrRmxKcUk2NUk0K2pmdHAxdWZRTzBDb3FJbUpLcG45ekxCYzJBVTls?=
 =?utf-8?B?VHRXbnlnZkZrUXJhRU01S0ZLci82VU03Q24zeE5remNYUzRWUld6czJkcDcz?=
 =?utf-8?B?WXpyc3RYajBhcHdNRXFzK0NLQ29IYmFXM2Nvby9YQmsxNm5tWWVPSHBRZ1gw?=
 =?utf-8?B?OGQ1ZXRCQWd0WVd5eE5qMFFlZjMxR0ZSYndzS2JYMDQ2QUE4ZmNQUEhNeUlT?=
 =?utf-8?B?cmU4Q1JGZk9Bd2ltSnhoR0dQRnoraGhyZWFYVU8vbXB5VjJiSGo5SDBGTXhi?=
 =?utf-8?B?bktGSm03MjZEVTlSVmFCdHFJWnBDek5VOFdzOU1wYzZBRkVqb3VZbVk5NEx4?=
 =?utf-8?Q?ixDp9hzGMfcbDxUFn6squWqSG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef434079-317e-4cd4-842c-08dda4bc7b15
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 05:39:18.5365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLt3AswZRXUixmwFmemrZ0R0/9Q7kmSAdVQX6iv8IRqZYbZQK31kouCd7Aou9Zdt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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



On 6/4/2025 1:18 PM, Emily Deng wrote:
> For the suspend and resume process, exclusive access is not required.
> Therefore, it can be moved out of the full access section to reduce the
> duration of exclusive access.
> 
> v3:
> Move suspend processes before hardware fini.
> Remove twice call for bare metal.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 16 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 13 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++--
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 40 +++++++++++++++++-----
>  4 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d8ac4b1051a8..0a8e7835d0fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -264,6 +264,22 @@ int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
>  	return r;
>  }
>  
> +void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm)

run_pm flag is not required in *_suspend/resume_process calls. It may be
checked at the caller site. Call the functions as required based on the
flags.

> +{
> +	if (adev->kfd.dev)
> +		kgd2kfd_suspend_process(adev->kfd.dev, run_pm);
> +}
> +
> +int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool run_pm)
> +{
> +	int r = 0;
> +
> +	if (adev->kfd.dev)
> +		r = kgd2kfd_resume_process(adev->kfd.dev, run_pm);
> +
> +	return r;
> +}
> +
>  int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>  			    struct amdgpu_reset_context *reset_context)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index b6ca41859b53..841ae8b75ab1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -156,6 +156,8 @@ void amdgpu_amdkfd_fini(void);
>  
>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
> +void amdgpu_amdkfd_suspend_process(struct amdgpu_device *adev, bool run_pm);
> +int amdgpu_amdkfd_resume_process(struct amdgpu_device *adev, bool run_pm);
>  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>  			const void *ih_ring_entry);
>  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
> @@ -413,6 +415,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);

run_pm in the above two calls may be renamed to
suspend_process/resume_process flags. Aligns more with the generic logic
of - based on suspend/resume flags, process suspend/resume is taken care.

> +void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm);
> +int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm);
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>  		      struct amdgpu_reset_context *reset_context);
>  int kgd2kfd_post_reset(struct kfd_dev *kfd);
> @@ -463,6 +467,15 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  	return 0;
>  }
>  
> +static inline void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +}
> +
> +static inline int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +	return 0;
> +}
> +
>  static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>  				    struct amdgpu_reset_context *reset_context)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5289400879ec..08ff9917c62f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5061,6 +5061,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	adev->in_suspend = true;
>  
>  	if (amdgpu_sriov_vf(adev)) {
> +		if (!adev->in_s0ix)
> +			amdgpu_amdkfd_suspend_process(adev, adev->in_runpm);
>  		amdgpu_virt_fini_data_exchange(adev);
>  		r = amdgpu_virt_request_full_gpu(adev, false);
>  		if (r)
> @@ -5080,7 +5082,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	amdgpu_device_ip_suspend_phase1(adev);
>  
>  	if (!adev->in_s0ix) {
> -		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> +		amdgpu_amdkfd_suspend(adev, amdgpu_sriov_vf(adev) || adev->in_runpm);
>  		amdgpu_userq_suspend(adev);
>  	}
>  
> @@ -5178,7 +5180,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  	}
>  
>  	if (!adev->in_s0ix) {
> -		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
> +		r = amdgpu_amdkfd_resume(adev, amdgpu_sriov_vf(adev) || adev->in_runpm);
>  		if (r)
>  			goto exit;
>  
> @@ -5197,6 +5199,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
>  	if (amdgpu_sriov_vf(adev)) {
>  		amdgpu_virt_init_data_exchange(adev);
>  		amdgpu_virt_release_full_gpu(adev, true);
> +
> +		if (!adev->in_s0ix && !r)
> +			r = amdgpu_amdkfd_resume_process(adev, adev->in_runpm);
>  	}
>  
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index bf0854bd5555..22c6ef7c42b6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1027,15 +1027,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>  	if (!kfd->init_complete)
>  		return;
>  
> -	/* for runtime suspend, skip locking kfd */
> -	if (!run_pm) {
> -		mutex_lock(&kfd_processes_mutex);
> -		/* For first KFD device suspend all the KFD processes */
> -		if (++kfd_locked == 1)
> -			kfd_suspend_all_processes();
> -		mutex_unlock(&kfd_processes_mutex);
> -	}
> -
> +	kgd2kfd_suspend_process(kfd, run_pm);

To clarify further about the earlier comments, this will be

if (suspend_process)
	kgd2kfd_suspend_process(kfd);

Same for resume below.

Thanks,
Lijo

>  	for (i = 0; i < kfd->num_nodes; i++) {
>  		node = kfd->nodes[i];
>  		node->dqm->ops.stop(node->dqm);
> @@ -1055,6 +1047,36 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>  			return ret;
>  	}
>  
> +	ret = kgd2kfd_resume_process(kfd, run_pm);
> +
> +	return ret;
> +}
> +
> +void kgd2kfd_suspend_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +	struct kfd_node *node;
> +	int i;
> +
> +	if (!kfd->init_complete)
> +		return;
> +
> +	/* for runtime suspend, skip locking kfd */
> +	if (!run_pm) {
> +		mutex_lock(&kfd_processes_mutex);
> +		/* For first KFD device suspend all the KFD processes */
> +		if (++kfd_locked == 1)
> +			kfd_suspend_all_processes();
> +		mutex_unlock(&kfd_processes_mutex);
> +	}
> +}
> +
> +int kgd2kfd_resume_process(struct kfd_dev *kfd, bool run_pm)
> +{
> +	int ret, i;
> +
> +	if (!kfd->init_complete)
> +		return 0;
> +
>  	/* for runtime resume, skip unlocking kfd */
>  	if (!run_pm) {
>  		mutex_lock(&kfd_processes_mutex);

