Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC73D41C02
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 04:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42CBB10E265;
	Wed, 13 Nov 2024 04:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XzPIplQC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7E610E265
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 04:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grdtpe3JAVQOQjGwFvjp+xXHP67MiQ9x++dEqVbnvErm8DXiwE63ke4I0GHmILvftBWclpx5v04imN9yfZYLXOYp4YXEcBxVt0ZtG71Ej+RUBcgO3OvtGAwHPwo5PIW3DKArLC/XjnbHN2072OZ516fYVbsTMB9n8DdMris+ypJk9MFcfuDb1SOecqE4Iti2/iTRzN2rrOQ2x3YuFjce1IS124qcbxVdjt6db2tCnW6Q5Xe7rmRpy1wSneuRIFNPxSdVjxHpCHnmVhP5O9jcW6C8hwCGOwTa6i3X6oihFsAMuf2XqFGvwuhv5zgwO2ab9gYsqA4ZDgOLKNJUu2PDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGoOn//fJGuG/WMReLeId65kBcAvclpgEfFMUQIMVJA=;
 b=TIGO/OCO+il5jDsGn7jXVBbTxIhil93P3uYKaIpCA0QqqOyKnQj4EBX6cmaFEngesx8qYLhIClAgetcn2mjft51B5fNoud22GZ9E+PUCUBdWJEorrRwkNoR6/VlYGBg83CMSzyp9ijvI6jsmgz4W5P8a9s+zoaQSE969i8gO93WlWJQlbiAz6Z77F5hZPPST974hNPRhmQDxvj84p/2INsY5EB87EdTyR7kX3H9WPclUaqC0NBPiwX0h0OQ7t4NWrXUMZUpygfkiWZsNckSxvNOu75sgvYwYytClEYTsMxxw5rFncgqcJdAEXpCy8NlmvPGFbXl47I0ao56ozTE8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGoOn//fJGuG/WMReLeId65kBcAvclpgEfFMUQIMVJA=;
 b=XzPIplQCPq+DLG3NnxIBN0PXf2F8hLZ5cAyBOFVnsjIE0foAzFbohrRGFTiNKPfhpP6T93akbiPuESXnxswpKy9yxV2nAxtwhnDlJy9BXWEDYhMYFjQAfyj8O1Ngjo5VQX/xR088XOdoq+48nTG2BvMtCe1wouysNBsy1pkpJEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 04:59:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 04:59:16 +0000
Message-ID: <657e02e0-3dde-4ca3-bc4c-9e3b9ace3f8f@amd.com>
Date: Wed, 13 Nov 2024 10:29:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: fix and simplify workload handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth Feng <kenneth.feng@amd.com>
References: <20241112202847.8509-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241112202847.8509-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7b3049-c77e-4c1d-1974-08dd039fecd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFd4RkEzOWFvQms5RVpyZnF1U1RYdVdLcWRiNHBvZmFWbE00UkxTdzBmWHR6?=
 =?utf-8?B?YmZXUG1HMTlnTE9tdjcvYTU3b1g3NEVwS3NIMlo0WjFvM3A5YjJ4ajdneSs1?=
 =?utf-8?B?QmtWZXpJMDJYMWZabHh4RTRVOTNSWU5sSmg5Z25KaHk5RFdxSGc3bktvMzNI?=
 =?utf-8?B?U00xVzZZc3dhbVlxbjNzYWQwRWtSZVJjNElSN1N2TEwyb3NZUkxXaUcwUmRI?=
 =?utf-8?B?MzVqTUpmZkJ5aFhHQThzR1p1THk4c0N4eWpFU0VhRnM2SWNzaGQ1M1Q5cFdy?=
 =?utf-8?B?WXRYRll5VXhXb0hvVHRobVF4R2tCcElnZ2cvS2pONWFxYzVoV0pLcDBodThw?=
 =?utf-8?B?MXlNUUM4NnNyV1RoZGFVb3F6RnlrelhtN2dTZHF3N044TWg0UVQ5VXB0bllT?=
 =?utf-8?B?SFlsY0FWKzNVSXU3aTV4eVEzSVdaT3BmclNkRGxMNzM4SWxhL2l6UmJLbzcz?=
 =?utf-8?B?bXA4czdJMTdDQk9nbUd0WUc4d1dsRzgzeWRDSzQ3YjNXZE42RXNVdHA5Uzdx?=
 =?utf-8?B?VXNONTF5M1gwakNNSzlIWUM3NHRUdHo4bnFRZmNTL1U2YTFZdXc4elFDM3hD?=
 =?utf-8?B?MHFBVElLSnVoRURGSHNPSXRsb1U0OXpUSFNwMmY0Tjd3QWsvS3RtOGVpOU1k?=
 =?utf-8?B?SUxpNHFETEt4Y3h1Y2g1NlA2WExJdlJQOFF6b01Oek9nRjN6dXNWYms5Nk1N?=
 =?utf-8?B?d3hIdTVJalA1UTFZU1Fvd1UzaEdEeXNtMW9FdWpKdUNhQ1FrK2R4bWJ3eGxE?=
 =?utf-8?B?NXdmRWN0MDJLZXZuWkxzZTN2NW9aN0tJTVM3R05FcU82K1dLb0JOQjcxTmJ3?=
 =?utf-8?B?dGNZTUJsT3ZMdFVQTitoUDAzY1RZU2hQS3NROHFoYlFuYWhPMHF5alBZVkVC?=
 =?utf-8?B?OGlEVmV5M0JuMS9xQjYzUXllZFJvQ2JzVW5vUzJDOFM2ODdDT0VVOEZhZnFp?=
 =?utf-8?B?S2tNUzJ0eUwrZXNXdlpSSnlEdnh2VS9JTlBFY0FGUG5sK2swZXVieVliWGRt?=
 =?utf-8?B?UmxhY0ZwaHMybEtzbVpPbUtxMkFXQ0FDd0ltQ2xERGVyVlFkaUltMWRWcnBC?=
 =?utf-8?B?d0xwcVZGR2tmeWRreHFaNnJLcXJ6QWJZZ3BLUVRQQVlpWVZ0THp1enBEODJi?=
 =?utf-8?B?eXZkb1hDTEs4Vk82NnZUMkhFSk1hT0ZrZnN2NFk1T1BnSG53RGFDY0xFam5K?=
 =?utf-8?B?aUxrRlFhSHZQcHYyVjhiWTlLSGRyelRoYyt0UTI5aGZpVVZRTzhCSFFJSFJs?=
 =?utf-8?B?RGlLTXVoMVo0OGROZGlFai9uNENGYS9iSm5PbGtCWndpWU5vejZpZWJuUzdW?=
 =?utf-8?B?R0RHZ2FDTVh5Njh0OXY3dUUxUk80YUx5bENLM0twdVF3ODZLd25ZNFEvUTVI?=
 =?utf-8?B?LytIQm5WbDJpRnY1VXJKbU9wU0w4SWJYYUM5TE1ncHRQKzBHRjNDSFNzUTEy?=
 =?utf-8?B?eE1xWlp4VWlkcE12VmtXLzVQby9iYUVMU1plVXRDZXlSMkhpNmZRWGcrd2tr?=
 =?utf-8?B?cnJDcERPNlR3SUtPSzFqNjJhZGkzUGg1cmMzR3pKMWpsbkN6bjg5MFllSFAr?=
 =?utf-8?B?cWg2YXphNUxJbU9BdTJMTGhkWTlpUXBRTHRLVmlKUE1oZW1keDFpcjVmTlVB?=
 =?utf-8?B?VDRQSHhxcWR1dHFncUtLeGZjL3Zlck5qNTg3cEdYdEhHNjQ2SS9CZHkxY0Nl?=
 =?utf-8?B?ZXMwYmNDam9MVVZZZFg4eW01TFl2M0tERTV0Zmd1c01nVUswbmdLcy83emdD?=
 =?utf-8?Q?tjY3NjUPkWVXhKJbz4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlMNkVqRWh4QjZFOTZVdmwvK0hkK1NUdXJ2eTE3UzJFRmh0SkRaZVh3TEQ0?=
 =?utf-8?B?Z0JUOHI5WG5XZk9xREUxRDlBdGtpL282cHRCYjJUSFhiYlg3QVdycmZiemQv?=
 =?utf-8?B?R283aGsvRFRLb0V1alVLZjQrY2ZBTEl5RGhqQ2htT1VMcXdraHFocjhsZmZl?=
 =?utf-8?B?eXpXL2Viby9zSHJrc2d5UTVkWHFBM2YrVFlidFUvVHMzSWZsY3JjOVZ1T1BN?=
 =?utf-8?B?ZGgxZzFTVjE2Z2hPdUI0NG9OVk50bXQ1YVJ1N2lMY3hLYy9rWllJcDZ2Y1pi?=
 =?utf-8?B?M0UxZlp2dDZwZitDeFltRHpKcytBWEp3OG9JRXR2eTA2bklDSmJsZXBmRjU1?=
 =?utf-8?B?ZzkzVmt5WFJIZFlBRkJha3BZZHBkY2h0UHBWZEhnN21zaGZTNWl4ZDhrSnF3?=
 =?utf-8?B?NWFsSzN1OS9Eb3A2dG5jbkVSblk3Q2VVTmIycVJhZVVVZnNzTzB2RDBYUklC?=
 =?utf-8?B?STlCTUQ0U1l4WitLUXQxYkxTbWJzWUI3SUhUSDV5enlpeE82VnBjaWRieEFE?=
 =?utf-8?B?dFZsdEFRa3dTWm1zbUN4bW9jMFZSbkxzU1kzWG55VjhqaUFGblBGYm1Eakp6?=
 =?utf-8?B?b1hGbEN0cEFUMDlvVm4yN1p0bVFjMDY1eE9BOXJkK3hZM1FkdVpLTjIydTVC?=
 =?utf-8?B?RmZhQWNrWlp0TVF4cDExTnBsdFRROXBPZXBXalkzRUQ3UnQ0SzhjUE5HK0VV?=
 =?utf-8?B?b0hhZDNyMHRJZjQ4ZHRZS1p5aVNxWC9jcWNZOUcwL0UxeWY1RDBhUGxlTkx4?=
 =?utf-8?B?UUU3WHcrS0ZpWlQxK2txc2xMckpjR1MrTHMzS2NLdXErU2c0d3V2dkxQM09q?=
 =?utf-8?B?dlh6WUFtKzIxWlNLVTNmOEhRcUUrVXlnblU4WnVTa2lGN1drd0Iya1lJN2pC?=
 =?utf-8?B?MllaUjAybGhnZktKT1BwaUFSNm5zN3czT3FFck5aT3lZUFBMTWduRGlzYU9l?=
 =?utf-8?B?a3NzYnlpRUQ2TTdxRXEvcG9QTXl4Tk93Vms0MVVSeFU1dVM2b093YVVJelNp?=
 =?utf-8?B?V2pXMnBkOUlVOGZmYUNYeDNpbEN0YVBHWHR5eGtGM3NMckUzTEQ1ZXJZUHly?=
 =?utf-8?B?SVVwcGJBQUVjUkQ4RENNSkYvYURKSk0zejRHaXJaaFlSKzBvN284b0ZnbEJi?=
 =?utf-8?B?YmZXTGI5eUk5VEpKWENJWnlOeElhY3pSemMwK1J5aUJvVStld1VkaDdzZkth?=
 =?utf-8?B?MWErTk53OUVUYWtuSDM1VTI1NmdxN0wySC81dlE1Ty9jNmdFQWNMdUtha1BK?=
 =?utf-8?B?dFRmZElMWWcwMm4xdmNGWFlYUTJ5WjBXRjRwdHNVeCtZSThCNW9pMVdxdy8z?=
 =?utf-8?B?T0pHUitMcFZoUitMeUhzdFhkWWphRm9rNVYzb3VEb1JndXE4eDFzdGpXNVZs?=
 =?utf-8?B?cUNjRElDUTNJbjUxZzZESklJbWdvUDF6QTVETlZxVGZGTjVINEFwUGtyekY3?=
 =?utf-8?B?STJnZzRqQ3JWcU0rK1M0SHFPWXJpK3N3S0lObTVzc01IakVITDk1d3RJQnla?=
 =?utf-8?B?eGludnZBcHdFbUFxUVNySEppNnk1aFpyMmszVmU4c2lYTkRmT09WYi95VWI4?=
 =?utf-8?B?Y29Sd2FWeWJjWitnclJqTytRSGlybzlYdkVWT05EUHlLazdDcnFOckdaOVFC?=
 =?utf-8?B?ekgwcHBzYVphYmlzTzBPTGZpMGRVblg5cmt5R2lnVlFBcVRzdlB5NCtudU1q?=
 =?utf-8?B?aHpIQVRsdzB4Zk56TVBlaUxHRkt0Y01xUHJJQWNLdnNhcHZMNHBGUHBTVDlL?=
 =?utf-8?B?M3ZFU0hZekp2bmNsOWtCOHE2QzRLRWlZTklxcGtZc1JVc2NkQ2Rxa0lSaXNw?=
 =?utf-8?B?WEVRYVRMVWFyU1A4UHl5cmZLWG43dU1tSzJpNlVvZFRGSEN5SUJaRVU5MlBL?=
 =?utf-8?B?eDdCdENVZjNxWklmQThUakx6dmMzWkU4K3hFODdXYkM5T0RMckdXUFJRTkFo?=
 =?utf-8?B?WEdrTEpGOWE4N3RJSTdZZC9qTTVuMmtjZTlkVTdSbE9yTG0yWjAvQ3lHbHRQ?=
 =?utf-8?B?T0RBUjBmeEMwWXp3RUo1WXFQK3ZQU1V2dENyeGtUTk9tbjBwV0s4Q3RpV2pW?=
 =?utf-8?B?SCtKdlZxMkVIWEdQUjJaTVFKcGp6WGVaVHZMTjlJR1h0OGlxYU5XTU9PdWtC?=
 =?utf-8?Q?+XW3HBpshqGnLz+H25QjvI45z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7b3049-c77e-4c1d-1974-08dd039fecd5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 04:59:16.8361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwnXTNzjdceLDERLgj/1nZneQpaH2faQnLs29N7hUnYtRtsOETSCAnnWy9UjotwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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



On 11/13/2024 1:58 AM, Alex Deucher wrote:
> smu->workload_mask is IP specific and should not be messed with in
> the common code. The mask bits vary across SMU versions.
> 
> Move all handling of smu->workload_mask in to the backends and
> simplify the code.  Store the user's preference in smu->power_profile_mode
> which will be reflected in sysfs.  For internal driver profile
> switches for KFD or VCN, just update the workload mask so that the
> user's preference is retained.  Remove all of the extra now unused
> workload related elements in the smu structure.
> 
> v2: use refcounts for workload profiles
> 
> Fixes: 8cc438be5d49 ("drm/amd/pm: correct the workload setting")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 128 +++++++++---------
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  13 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  20 +--
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  20 +--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  21 +--
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  17 +--
>  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  17 +--
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  33 ++---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 +--
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  33 ++---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   8 --
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 -
>  12 files changed, 162 insertions(+), 171 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c3a6b6f20455..41b591ecfb64 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -72,6 +72,10 @@ static int smu_set_power_limit(void *handle, uint32_t limit);
>  static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>  static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>  static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
> +static void smu_power_profile_mode_get(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode);
> +static void smu_power_profile_mode_put(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode);
>  
>  static int smu_sys_get_pp_feature_mask(void *handle,
>  				       char *buf)
> @@ -765,6 +769,7 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
>  	smu->user_dpm_profile.fan_mode = -1;
>  
>  	mutex_init(&smu->message_lock);
> +	mutex_init(&smu->workload_lock);
>  
>  	adev->powerplay.pp_handle = smu;
>  	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
> @@ -1268,9 +1273,6 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
>  	atomic64_set(&smu->throttle_int_counter, 0);
>  	smu->watermarks_bitmap = 0;
> -	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->user_dpm_profile.user_workload_mask = 0;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
>  		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
> @@ -1278,33 +1280,13 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
>  	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
>  	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
>  
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D] = 1;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_POWERSAVING] = 2;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_VIDEO] = 3;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_VR] = 4;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_COMPUTE] = 5;
> -	smu->workload_priority[PP_SMC_POWER_PROFILE_CUSTOM] = 6;
> -
>  	if (smu->is_apu ||
> -	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D)) {
> -		smu->driver_workload_mask =
> -			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
> -	} else {
> -		smu->driver_workload_mask =
> -			1 << smu->workload_priority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
> -		smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -	}
> -
> -	smu->workload_mask = smu->driver_workload_mask |
> -							smu->user_dpm_profile.user_workload_mask;
> -	smu->workload_setting[0] = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -	smu->workload_setting[1] = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> -	smu->workload_setting[2] = PP_SMC_POWER_PROFILE_POWERSAVING;
> -	smu->workload_setting[3] = PP_SMC_POWER_PROFILE_VIDEO;
> -	smu->workload_setting[4] = PP_SMC_POWER_PROFILE_VR;
> -	smu->workload_setting[5] = PP_SMC_POWER_PROFILE_COMPUTE;
> -	smu->workload_setting[6] = PP_SMC_POWER_PROFILE_CUSTOM;
> +	    !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FULLSCREEN3D))
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> +	else
> +		smu->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +	smu_power_profile_mode_get(smu, smu->power_profile_mode);
> +
>  	smu->display_config = &adev->pm.pm_display_cfg;
>  
>  	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
> @@ -2252,24 +2234,41 @@ static int smu_enable_umd_pstate(void *handle,
>  }
>  
>  static int smu_bump_power_profile_mode(struct smu_context *smu,
> -					   long *param,
> -					   uint32_t param_size)
> +				       long *param,
> +				       uint32_t param_size,
> +				       bool enable)
>  {
>  	int ret = 0;
>  
>  	if (smu->ppt_funcs->set_power_profile_mode)
> -		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size);
> +		ret = smu->ppt_funcs->set_power_profile_mode(smu, param, param_size, enable);

Have a different expectation with refcount; not expecting to see
enable/disable. I think only switch power_profile_mode is required.

Workload mask is then created based on non-zero refcounts in this array
- smu->workload_refcount[]. If it is different from the current mask,
then it's applied.

>  
>  	return ret;
>  }
>  
> +static void smu_power_profile_mode_get(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode)
> +{
> +	mutex_lock(&smu->workload_lock);

I think this is not needed. DPM calls are already under lock, not seeing
a case where it could do toggle get/put at the sametime.

> +	smu->workload_refcount[profile_mode]++;
> +	mutex_unlock(&smu->workload_lock);
> +}
> +
> +static void smu_power_profile_mode_put(struct smu_context *smu,
> +				       enum PP_SMC_POWER_PROFILE profile_mode)
> +{
> +	mutex_lock(&smu->workload_lock);
> +	if (smu->workload_refcount[profile_mode])
> +		smu->workload_refcount[profile_mode]--;
> +	mutex_unlock(&smu->workload_lock);
> +}
> +
>  static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  					  enum amd_dpm_forced_level level,
>  					  bool skip_display_settings,
>  					  bool init)
>  {
>  	int ret = 0;
> -	int index = 0;
>  	long workload[1];
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  
> @@ -2307,13 +2306,11 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
>  	}
>  
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> +		workload[0] = smu->power_profile_mode;
>  
> -		if (init || smu->power_profile_mode != workload[0])
> -			smu_bump_power_profile_mode(smu, workload, 0);
> +		if (init)
> +			smu_bump_power_profile_mode(smu, workload, 0, true);

Same here - not expecting to have init check here. Since workload_mask
is 0 during init and workload_refcount is changed, it will set the right
mask on smu_bump_power_profile_mode().

>  	}
>  
>  	return ret;
> @@ -2361,12 +2358,11 @@ static int smu_handle_dpm_task(void *handle,
>  
>  static int smu_switch_power_profile(void *handle,
>  				    enum PP_SMC_POWER_PROFILE type,
> -				    bool en)
> +				    bool enable)
>  {
>  	struct smu_context *smu = handle;
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
>  	long workload[1];
> -	uint32_t index;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
> @@ -2374,24 +2370,16 @@ static int smu_switch_power_profile(void *handle,
>  	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
>  		return -EINVAL;
>  
> -	if (!en) {
> -		smu->driver_workload_mask &= ~(1 << smu->workload_priority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	} else {
> -		smu->driver_workload_mask |= (1 << smu->workload_priority[type]);
> -		index = fls(smu->workload_mask);
> -		index = index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -		workload[0] = smu->workload_setting[index];
> -	}
> -
> -	smu->workload_mask = smu->driver_workload_mask |
> -						 smu->user_dpm_profile.user_workload_mask;
> +	workload[0] = type;
>  
>  	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> -		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
> -		smu_bump_power_profile_mode(smu, workload, 0);
> +	    smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
> +		if (enable)
> +			smu_power_profile_mode_get(smu, type);
> +		else
> +			smu_power_profile_mode_put(smu, type);
> +		smu_bump_power_profile_mode(smu, workload, 0, enable);
> +	}
>  
>  	return 0;
>  }
> @@ -3090,21 +3078,27 @@ static int smu_set_power_profile_mode(void *handle,
>  				      uint32_t param_size)
>  {
>  	struct smu_context *smu = handle;
> -	int ret;
> +	long workload[1];
> +	int ret = 0;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
>  	    !smu->ppt_funcs->set_power_profile_mode)
>  		return -EOPNOTSUPP;
>  
> -	if (smu->user_dpm_profile.user_workload_mask &
> -	   (1 << smu->workload_priority[param[param_size]]))
> -	   return 0;
> -
> -	smu->user_dpm_profile.user_workload_mask =
> -		(1 << smu->workload_priority[param[param_size]]);
> -	smu->workload_mask = smu->user_dpm_profile.user_workload_mask |
> -		smu->driver_workload_mask;
> -	ret = smu_bump_power_profile_mode(smu, param, param_size);
> +	if (param[param_size] != smu->power_profile_mode) {
> +		/* clear the old user preference */
> +		workload[0] = smu->power_profile_mode;
> +		smu_power_profile_mode_put(smu, smu->power_profile_mode);
> +		ret = smu_bump_power_profile_mode(smu, workload, 0, false);
> +		if (ret)
> +			return ret;

Here as well - no need to call twice with false/true. Put the existing
one and get the new one. If smu_bump_power_profile_mode call fails, then
we have to reverse the operation though - this is true for other cases also.

Thanks,
Lijo

> +		/* set the new user preference */
> +		smu_power_profile_mode_get(smu, param[param_size]);
> +		ret = smu_bump_power_profile_mode(smu, param, param_size, true);
> +		if (!ret)
> +			/* store the user's preference */
> +			smu->power_profile_mode = param[param_size];
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index fa93a8879113..da7558a65c09 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -240,7 +240,6 @@ struct smu_user_dpm_profile {
>  	/* user clock state information */
>  	uint32_t clk_mask[SMU_CLK_COUNT];
>  	uint32_t clk_dependency;
> -	uint32_t user_workload_mask;
>  };
>  
>  #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
> @@ -557,12 +556,12 @@ struct smu_context {
>  	uint32_t hard_min_uclk_req_from_dal;
>  	bool disable_uclk_switch;
>  
> +	/* backend specific workload mask */
>  	uint32_t workload_mask;
> -	uint32_t driver_workload_mask;
> -	uint32_t workload_priority[WORKLOAD_POLICY_MAX];
> -	uint32_t workload_setting[WORKLOAD_POLICY_MAX];
> +	/* default/user workload preference */
>  	uint32_t power_profile_mode;
> -	uint32_t default_power_profile_mode;
> +	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
> +	struct mutex workload_lock;
>  	bool pm_enabled;
>  	bool is_apu;
>  
> @@ -734,8 +733,10 @@ struct pptable_funcs {
>  	 *                          create/set custom power profile modes.
>  	 * &input: Power profile mode parameters.
>  	 * &size: Size of &input.
> +	 * &enable: enable/disable the profile
>  	 */
> -	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
> +	int (*set_power_profile_mode)(struct smu_context *smu, long *input,
> +				      uint32_t size, bool enable);
>  
>  	/**
>  	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4b36c230e43a..1e44cf6fec4b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1443,7 +1443,8 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
>  
>  static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  					   long *input,
> -					   uint32_t size)
> +					   uint32_t size,
> +					   bool enable)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
>  	int workload_type = 0;
> @@ -1455,8 +1456,9 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  		return -EINVAL;
>  	}
>  
> -	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> -	     (smu->smc_fw_version >= 0x360d00)) {
> +	if (enable &&
> +	    (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
> +	    (smu->smc_fw_version >= 0x360d00)) {
>  		if (size != 10)
>  			return -EINVAL;
>  
> @@ -1520,18 +1522,18 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
>  		return -EINVAL;
>  	}
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					  SMU_MSG_SetWorkloadMask,
>  					  smu->workload_mask,
>  					  NULL);
> -	if (ret) {
> +	if (ret)
>  		dev_err(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> -		return ret;
> -	}
> -
> -	smu_cmn_assign_power_profile(smu);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int arcturus_set_performance_level(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 211635dabed8..d944a9f954d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2006,19 +2006,19 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
>  	return size;
>  }
>  
> -static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int navi10_set_power_profile_mode(struct smu_context *smu, long *input,
> +					 uint32_t size, bool enable)
>  {
>  	DpmActivityMonitorCoeffInt_t activity_monitor;
>  	int workload_type, ret = 0;
> +	uint32_t profile_mode = input[size];
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 10)
>  			return -EINVAL;
>  
> @@ -2080,16 +2080,18 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 844532a9b641..4967e087088b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1704,22 +1704,23 @@ static int sienna_cichlid_get_power_profile_mode(struct smu_context *smu, char *
>  	return size;
>  }
>  
> -static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu,
> +						 long *input, uint32_t size,
> +						 bool enable)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 10)
>  			return -EINVAL;
>  
> @@ -1781,16 +1782,18 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    smu->workload_mask, NULL);
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index f89c487dce72..b5dba4826f81 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1056,7 +1056,8 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>  	return size;
>  }
>  
> -static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
> +					  uint32_t size, bool enable)
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> @@ -1067,7 +1068,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  	}
>  
>  	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> +	    profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>  		return 0;
>  
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> @@ -1080,18 +1081,18 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
>  		return -EINVAL;
>  	}
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>  				    smu->workload_mask,
>  				    NULL);
> -	if (ret) {
> +	if (ret)
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n",
>  					workload_type);
> -		return ret;
> -	}
> -
> -	smu_cmn_assign_power_profile(smu);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 75a9ea87f419..2d1eae79ab9d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -864,7 +864,8 @@ static int renoir_force_clk_levels(struct smu_context *smu,
>  	return ret;
>  }
>  
> -static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int renoir_set_power_profile_mode(struct smu_context *smu, long *input,
> +					 uint32_t size, bool enable)
>  {
>  	int workload_type, ret;
>  	uint32_t profile_mode = input[size];
> @@ -875,7 +876,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  	}
>  
>  	if (profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> -			profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
> +	    profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING)
>  		return 0;
>  
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> @@ -891,17 +892,17 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
>  		return -EINVAL;
>  	}
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
>  				    smu->workload_mask,
>  				    NULL);
> -	if (ret) {
> +	if (ret)
>  		dev_err_once(smu->adev->dev, "Fail to set workload type %d\n", workload_type);
> -		return ret;
> -	}
>  
> -	smu_cmn_assign_power_profile(smu);
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int renoir_set_peak_clock_by_device(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 80c6b1e523aa..3cc734331891 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2573,22 +2573,22 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>  
>  static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  					      long *input,
> -					      uint32_t size)
> +					      uint32_t size,
> +					      bool enable)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
>  	u32 workload_mask;
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 9)
>  			return -EINVAL;
>  
> @@ -2641,13 +2641,18 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
>  	workload_mask = 1 << workload_type;
>  
> +	if (enable)
> +		smu->workload_mask |= workload_mask;
> +	else
> +		smu->workload_mask &= ~workload_mask;
> +
>  	/* Add optimizations for SMU13.0.0/10.  Reuse the power saving profile */
>  	if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0) &&
>  	     ((smu->adev->pm.fw_version == 0x004e6601) ||
> @@ -2658,25 +2663,13 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>  							       CMN2ASIC_MAPPING_WORKLOAD,
>  							       PP_SMC_POWER_PROFILE_POWERSAVING);
>  		if (workload_type >= 0)
> -			workload_mask |= 1 << workload_type;
> +			smu->workload_mask |= 1 << workload_type;
>  	}
>  
> -	smu->workload_mask |= workload_mask;
>  	ret = smu_cmn_send_smc_msg_with_param(smu,
>  					       SMU_MSG_SetWorkloadMask,
>  					       smu->workload_mask,
>  					       NULL);
> -	if (!ret) {
> -		smu_cmn_assign_power_profile(smu);
> -		if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_POWERSAVING) {
> -			workload_type = smu_cmn_to_asic_specific_index(smu,
> -							       CMN2ASIC_MAPPING_WORKLOAD,
> -							       PP_SMC_POWER_PROFILE_FULLSCREEN3D);
> -			smu->power_profile_mode = smu->workload_mask & (1 << workload_type)
> -										? PP_SMC_POWER_PROFILE_FULLSCREEN3D
> -										: PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> -		}
> -	}
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index c5d3e25cc967..1aafd23857f0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2528,22 +2528,23 @@ do {													\
>  	return result;
>  }
>  
> -static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *input, uint32_t size)
> +static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu,
> +					      long *input, uint32_t size,
> +					      bool enable)
>  {
>  
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
>  
> -	smu->power_profile_mode = input[size];
> -
> -	if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode > PP_SMC_POWER_PROFILE_WINDOW3D) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 8)
>  			return -EINVAL;
>  
> @@ -2590,17 +2591,19 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>  				    smu->workload_mask, NULL);
>  
>  	if (ret)
>  		dev_err(smu->adev->dev, "[%s] Failed to set work load mask!", __func__);
> -	else
> -		smu_cmn_assign_power_profile(smu);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..b64490bcfd62 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1719,21 +1719,21 @@ static int smu_v14_0_2_get_power_profile_mode(struct smu_context *smu,
>  
>  static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  					      long *input,
> -					      uint32_t size)
> +					      uint32_t size,
> +					      bool enable)
>  {
>  	DpmActivityMonitorCoeffIntExternal_t activity_monitor_external;
>  	DpmActivityMonitorCoeffInt_t *activity_monitor =
>  		&(activity_monitor_external.DpmActivityMonitorCoeffInt);
> +	uint32_t profile_mode = input[size];
>  	int workload_type, ret = 0;
> -	uint32_t current_profile_mode = smu->power_profile_mode;
> -	smu->power_profile_mode = input[size];
>  
> -	if (smu->power_profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", smu->power_profile_mode);
> +	if (profile_mode >= PP_SMC_POWER_PROFILE_COUNT) {
> +		dev_err(smu->adev->dev, "Invalid power profile mode %d\n", profile_mode);
>  		return -EINVAL;
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +	if (enable && profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
>  		if (size != 9)
>  			return -EINVAL;
>  
> @@ -1783,23 +1783,24 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>  		}
>  	}
>  
> -	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> -		smu_v14_0_deep_sleep_control(smu, false);
> -	else if (current_profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> -		smu_v14_0_deep_sleep_control(smu, true);
> -
>  	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
>  	workload_type = smu_cmn_to_asic_specific_index(smu,
>  						       CMN2ASIC_MAPPING_WORKLOAD,
> -						       smu->power_profile_mode);
> +						       profile_mode);
>  	if (workload_type < 0)
>  		return -EINVAL;
>  
> -	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> -										  smu->workload_mask, NULL);
> +	if (enable)
> +		smu->workload_mask |= (1 << workload_type);
> +	else
> +		smu->workload_mask &= ~(1 << workload_type);
>  
> -	if (!ret)
> -		smu_cmn_assign_power_profile(smu);
> +	/* disable deep sleep if compute is enabled */
> +	if (profile_mode == PP_SMC_POWER_PROFILE_COMPUTE)
> +		smu_v14_0_deep_sleep_control(smu, !enable);
> +
> +	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
> +					      smu->workload_mask, NULL);
>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index fd2aa949538e..63c4f75fa118 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1141,14 +1141,6 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>  	return ret;
>  }
>  
> -void smu_cmn_assign_power_profile(struct smu_context *smu)
> -{
> -	uint32_t index;
> -	index = fls(smu->workload_mask);
> -	index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
> -	smu->power_profile_mode = smu->workload_setting[index];
> -}
> -
>  bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
>  {
>  	struct pci_dev *p = NULL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 8a801e389659..1de685defe85 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -130,8 +130,6 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
>  int smu_cmn_set_mp1_state(struct smu_context *smu,
>  			  enum pp_mp1_state mp1_state);
>  
> -void smu_cmn_assign_power_profile(struct smu_context *smu);
> -
>  /*
>   * Helper function to make sysfs_emit_at() happy. Align buf to
>   * the current page boundary and record the offset.
