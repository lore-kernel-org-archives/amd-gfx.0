Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4B8D60D18
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 03:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97AF10E5A7;
	Tue, 19 Nov 2024 03:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a1/Psliq";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C079110E5A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 03:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7f2H1E6qSm30EF+LGnnoMvg+ixpHpIB6Z2aW74XZ70n/0igB4mEDNIYy/qyrafK2U7y3+z5Q1W0AkB+kCqPhAIcR/jjcuZOKqkp3RTDSoWP4SmfvrJ/O2rusj58n6csQT5kg7kziajyCSskvZleY6ieID7WXslmwgr5Oymbpm3h81nuQiKmKIh8AkUgx2ifLaZpu1apPs6I5wub/6JOH7RQ8HtQEttC8etJ7b63pauSnvFO62YzkT7/O9pu9OEa1iODJ/kCmS8meIiXrV+EQ5gz91I6f0TyEYOZX+LaCeciIHfdrWnSe6R4+V/A09QsS5h6S3/P3yTVexIC9xQolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1YIN/3fs5gBVOgJPgATogeFAUp4BzDldQzCS4Aybww=;
 b=i0PMmltlUcuTm85gjCSSE+YTwMl3Ebn4EkZQJN/no341GeVy4qXtTJiz6NvR/1/n+97jPolGuCk2bZmVVrx3AtFfoFhAG1xEk0QFyA+n108dNl9lGzZLA7ufJqIPyMZyl68j9a6HyL3wcZBATyppN4EwCGam3ns8VOak/prM9jEDu3OKjQTvDw+UE6tDh8jIM0en6tvyo0ogd0UJ2UbbuLmbCF1LYpMvmmAEtOUtp0n/qFafZiDLqAbRVocSSRBrRGliDT2Rze/ofjp8NXKICUUB14HHx0h3RxQ3tlu47e7IiIzP3YkPxkXNtQGfDhCA3vbMGumO+fSCgcKyeJiy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1YIN/3fs5gBVOgJPgATogeFAUp4BzDldQzCS4Aybww=;
 b=a1/PsliqvmWpA0T8OTSlJJsQp2Akv0aIE7pXM1mlBi7W1ot3eczXko6QQwhRajQi7xnCL8j1/mihNo0w08/decOyT0bVPkO//M41cKoTkGxH+i+5vMzMCSs5P+lRH68hJY8TZdt1kb/5uHO3zrO+AWLUBMeGgyNnrXCOv13lrZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 03:26:10 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 03:26:09 +0000
Message-ID: <06ba2ef9-92ea-4df1-bd8c-c5fd47b29676@amd.com>
Date: Tue, 19 Nov 2024 08:56:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: disable pcie speed switching on Intel
 platform for smu v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kevinyang.wang@amd.com
References: <20241118080114.428845-1-kenneth.feng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241118080114.428845-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::12) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d5e88d-bbc3-4f71-93b2-08dd0849e8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmtZVzA2R2RSOWFJN29nUGU4MjJXejgvM21oT1BpTjJOVTNmUzJrWkdjM001?=
 =?utf-8?B?VVJKb0trRkZvWWRhTWlEbmY1SFk4SHlsRUkrNzVUR2dZYmJlcCsyUHk1c2ts?=
 =?utf-8?B?elB4MThPSnZjMFVPUlB6eExhdFozMXVpK1BHYk5Vc1dsdUYzWDZ3MXU1NmNM?=
 =?utf-8?B?cmkxQkpEKzJXZHZnTUNRdGVHYXN4RkRjVXl0SElVL0VRZERlMU1lMW45N1pK?=
 =?utf-8?B?Nnh2NVNtYWNsamJjSG9DaUJVdXdnMm1jSHN1VlhDd2E4djhKUlQrWXcrUDFx?=
 =?utf-8?B?UU1FRmlmeVBrd2tYQlNETVI5blgycXUxRnVoNElJT0dXNVRYWk56TGRzaG1Y?=
 =?utf-8?B?MEtZekhOc0dkaVFJWWtXcEFscVBYaVhaRUtqMFFhTy9mbG8wZlBCczJFZE9j?=
 =?utf-8?B?dkNicnl4Vkpla2l6K3FwMGNwS2U3VG50M0xXSVI1by8zZVJSZFhicm45RzRV?=
 =?utf-8?B?TSsxQlh3cktiZ0ExbTdnNlBzMjU0NzZFUkJBc2V4eGdvNXRvclRzT2M3aUhj?=
 =?utf-8?B?SUJqU3NyMkhvSHhQUzd6d29UNDNTclVncTBnM2xOZjZJSGdhZkNiUldDR1gv?=
 =?utf-8?B?VjJtM0R4REdtLzUzTDhHN2VENmxyZFl6ZFpNbDdwOUVkWTNKYW5laiszekE1?=
 =?utf-8?B?ME1HdmFySjcxNHE1RzZJTE1acjJlTXpGa2MvbENBUG12c3RyUW9NdC9TclZK?=
 =?utf-8?B?V2tzbXY4dFFxVUVtYnh0bkZBRmswWGZ5RnVmdEY5MjhkaG9OQUlYT1Z3MWhi?=
 =?utf-8?B?cVBOaStRSTNaU3BZUk0xVzgvQkxBaWxxMGtJWXVHYndEbmhRSmpoeXU1ZFl6?=
 =?utf-8?B?TWQyZDduQkNUREVpMEJQeTd0V1czT0Z3blc3bFBuM3RpSGNHQUdLRGYxT2NQ?=
 =?utf-8?B?V2JpbGk3amRnUjN2YWtNYVZSRHpicllDbmhQY1oyZE5EbmFrNzBuOWpLajJE?=
 =?utf-8?B?N3k0bFBteElQZUFQTlk4TUlqRVJIaWxoUGpQWnFUSU5rOXZ6N08ydWRKeHdH?=
 =?utf-8?B?dU0vV2lRdTRJdkRWbjlYSVE4RGFQRWpEcjYranR5VFZISmRYTE1LOGNJdXo1?=
 =?utf-8?B?ZTRydFJKa0RkQWFIVWdaSEFqOEp0b1psTXdJNmNyeGFmMm5RQldiakFvMnpI?=
 =?utf-8?B?QnZBV1p2ck1hZnZoNlZ5Zmd1S0Y4dVlEMGRPT3VVS255am1XUXlVYWFUcDJq?=
 =?utf-8?B?SWZJUm94SXZRZzBYM1AyODRYd0swOHRUQjZJQlFuT3cvYmh0V3hDVkZrNlhG?=
 =?utf-8?B?UlVaSXI2SjZZd3E5QktQVW5ITTdLWFZUQ2pMTENwN3ZiSFFRdnY1Z2xtd0x1?=
 =?utf-8?B?TEVvTDVlUURsZ3pnM25DYlkxL0ZEZ3c1YXJ5clBYemF2ZW50WnlJeGF5UGR0?=
 =?utf-8?B?Y214OUwwM2lhaUlSZXpPdjlha1NqYWFPOHI4elJ0eFQ0akZKSzE2c1c4OVVP?=
 =?utf-8?B?QlJJUGNLVTFYMkIxSmszSFZzdVE3RmtmRDhzVmwvVGtSQUZLOVNoWWdjMWNL?=
 =?utf-8?B?eFhDVldkTkg5dGI0YmtESTdwY0JEZlF4UWtyOENlSkQ2UFc5bHprZHQ4Ymh4?=
 =?utf-8?B?b3N6eWU3Wnp3VG1nT0JuVGN6QkFoWnhGM0dCaDIzSDhBR0svT0F1QTN3OWkr?=
 =?utf-8?B?bmVORXB3elk2L1VhaVNKMll4dWtzZWtVZHVtVWpXeDFRT3hoWTUvU0hPazFJ?=
 =?utf-8?B?NmFjSTJOUURpZUh4T3B6d2pjWXl2Z1A2Vk02WWdneVh4ZmE1WjZEQTIvMHFW?=
 =?utf-8?Q?shannIio1672JgN3HQJSSvwLsSlJGGKzXw3Cx+D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFUUVpGaXE0MDZ4VDVaM1BrU1JpcHR5TDllN1ZFVXhyOUJIVk1RTmJMZEoz?=
 =?utf-8?B?b0VmTjJ0aG85S3VzTFZhY0o1SGJ0K1hGbTRyUWRxNW1qQ0dTK3orcEJJdktE?=
 =?utf-8?B?U2lWUkd5L3h1dXVFank4TTFzYzR6OU9FckhZa1lqZEdZUGM1ZGllVE5Gdnoy?=
 =?utf-8?B?dk9URFBUWmloN3ZpazJJZWYvU1FNS1RwOHQ1WlFCRFFVd3VnbkhDVlA4MUtO?=
 =?utf-8?B?NkVwK2ptSjEvbU51OFkyekI1ODZjdDRDWkovMGJoUTIxLzlsOWtwNCsrMjVi?=
 =?utf-8?B?a0dGM1k5RGFpTmdGSldmeVhnS3FxbTArdTBOOUlqQTVESkk5NVdGMUxGb3Fw?=
 =?utf-8?B?cW8wZ0FZWVl5TVlOMkVjVkYxbkh3TTlaM09MdHkrUnVTeTNDNnpRS0tPKzJm?=
 =?utf-8?B?NS9RdnJGVGZaK3N6eHlxMFpvMXExM1EyRkVZTEN2c1QwSy9rejNDNGFPYktP?=
 =?utf-8?B?dy93ZXhiVWkxa0dXVlJZMUdoNFZoQ1Z1Yk5yaFdWVUN1VlN5dGViTXpSMi9o?=
 =?utf-8?B?V2JKSmVuTzcrOTRnTWpETjFnQ2d2dXJ4SVVweTNvNkUvSTBhem9maEtlVUR0?=
 =?utf-8?B?STFjeEFTa0Z1eEFTWWN1RGxJNkwyZGh0SVNjd3Juc2M2L1lTSGlBUTNEZFFO?=
 =?utf-8?B?cWxpUjhhUG9RT2d1ZUNmbk1sTWlJcytiYXRqYXNwNlVzUHQ2NUN2Y2NjUnQ3?=
 =?utf-8?B?K1VHa00zc0tnaERlQ01XL0VBbERQSVhYWGNVNDJtSDk5L283Vm5iRFJHcW4w?=
 =?utf-8?B?dHQwM2JkcGJDQlFYY1VyU0VQTk5JdWVWNGJwQ2YwcjE0NnByNlBCdFlwUis0?=
 =?utf-8?B?djNyR1VVa0tOYlZqRXN5NXpwMnFLZ2lZSjF4eEYwVjl5MFZ2VlNFeENrbHlq?=
 =?utf-8?B?SjJRajR3YjlxZjdBdzVzODNNRndLKzdqVjdGMU9OT1ZOMVN3RTM0NDhEME5U?=
 =?utf-8?B?cVdUSFJOR2htVzdRWkVNM3hLR1RLMDNUa1pIQ2hsZXppeEtpYkptUVQ4NmFx?=
 =?utf-8?B?aDluSVJzYWlJRlVUZEpINmVYNmpNdk9QTytSelg2bC9lQjY3bXR0RFl6VEN6?=
 =?utf-8?B?NmFtZXE3RW1RUnpCOGVGNWIxQWJHOXBiUTdVTlQzcDZZMUxhelIyTjQ0MDAr?=
 =?utf-8?B?WEszNmhtNDJuZmYyU2xWVjQwemE4d05BdHoxOVM5UTZzOTN0L2JNRWdIVW9T?=
 =?utf-8?B?NlVXMElqMzYyRGdzN1RoekFNM1pjb20vZ0k3ODBtbHRCbEdndklVcno1azU3?=
 =?utf-8?B?Ni8wZVRYTGI1V0ptb0hKWVNUZi9TMVNyVVFydTh2eENPR2VWTHlhc0pwUGda?=
 =?utf-8?B?NXdHZUEwNUpZSnhJUGwwcDJMMDVVa0N3UTcydHZGZEVQYkpLMnVJeW4xNlJB?=
 =?utf-8?B?Wk52VVpIRUF6YnBBdU9vamxIRzRvaWdVQjVUR2tKajhiTVF5U1N5c2dmTWZT?=
 =?utf-8?B?ZlRMN3orUzVuQjR2a29QOUJxS3h3WW4waWFsSXBCQk1PUmZlb2dZeXVyTkJh?=
 =?utf-8?B?SEVQOC9TMk1LVEoveVdHbjZJZzlMeldkSXRaYzcrUkt6czFjRG03NnYyVmdZ?=
 =?utf-8?B?czhscmtOOTMzTnNBMWJheHVDa2hEVGhXM3pRWE1ubnVGVmdWeGcxVjZyYnY5?=
 =?utf-8?B?Z1VnQ2hRMjFkTDh6emVlbm5zaUdxZkF3MERIclZXL1A5YkkwL05zcEtGbHZV?=
 =?utf-8?B?ejY4d0k3bldWdmFzdFBIc09wdG5UcXM4NUxySmRiN0ZjZW5GQmpuOEo1YjRa?=
 =?utf-8?B?bkdnd2w0MXRPL0lTWlVHUkFiM295bExVK2Vyc1VhK2VUSWxuMVluaEdpN005?=
 =?utf-8?B?eEN5cStJZ3RocUM3NkJHcXYrY3RUM2ptMndBeEs4Z0RJSUdOU2poNEZ4bWRC?=
 =?utf-8?B?OSs5bUFNRDVWMncyVFNSQUZQVmtLZzlRWXBDUHVQWThVRGtCMXRsenN2d2dY?=
 =?utf-8?B?V1pxb0tQWVAyc01hdmJnL0Z2d2JzRTRLbjN1aXl4dTBjZ2VLL1hIREU0dndj?=
 =?utf-8?B?dDNIWWdZTktmK2xOcDBtVjFsL1N3eWY2LzRUWTh5bG5VUGdHZ3VWd1hYelFv?=
 =?utf-8?B?UnpUdk44MFFJSWtxWjN2SFpIQ0VGa1hMOHNVd1I1eTZLdHRia0Q0MXo3L2Rn?=
 =?utf-8?Q?iVOEz3fOYedB8C8B3GIsRSCQ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d5e88d-bbc3-4f71-93b2-08dd0849e8f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 03:26:09.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbkbGgMrGWsWxz42ojKQa6u8s20nVlvFT3LUXE08MhvZwRZguMHaJe1vEzQUos60
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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



On 11/18/2024 1:31 PM, Kenneth Feng wrote:
> disable pcie speed switching on Intel platform for smu v14.0.2/3
> based on Intel's requirement.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..337d3312ef30 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1472,6 +1472,14 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
>  		if (pcie_table->pcie_lane[i] > pcie_width_cap)
>  			pcie_table->pcie_lane[i] = pcie_width_cap;
>  
> +		if (i < pcie_table->num_of_link_levels - 1 &&
> +			!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
> +			if (pcie_table->pcie_gen[i] < pcie_gen_cap)
> +				pcie_table->pcie_gen[i] = pcie_gen_cap;
> +			if (pcie_table->pcie_lane[i] < pcie_width_cap)
> +				pcie_table->pcie_lane[i] = pcie_width_cap;
> +		}

Looking at smu_v13 code, we choose the minimum of platform supported vs
device supported and assign that to all levels.

if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
                        pcie_gen_cap =
pcie_table->pcie_gen[num_of_levels - 1];

Here it's selecting platform supported for all lower levels.

Thanks,
Lijo

> +
>  		smu_pcie_arg = i << 16;
>  		smu_pcie_arg |= pcie_table->pcie_gen[i] << 8;
>  		smu_pcie_arg |= pcie_table->pcie_lane[i];
