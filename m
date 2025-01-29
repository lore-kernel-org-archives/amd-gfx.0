Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740DAC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 15:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B4E10E81C;
	Wed, 29 Jan 2025 15:22:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nklzFW9e";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8449710E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 15:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0322t9cWYC2FuEfTczhd/ad3lRvwzv4DxATUVk+T+dkjVcOdie+/HyjM4wbUsWinPKR0ymUUO/cjVnZFQUvzG2GdaxLOFj9+vyuMu7nDEfpZ4gqXzhF0jkeEG45TxKwJeGlS3ChS3kjBhdqQEQLrfAzHsTMvgvmdUrwGLM//+fTHwy0NZabcPABRFaXJPgohLZL3zIWY9x3VTf/74wiwR1s+Py/eVKLygaqtHR2kg+2NbAy9spPc4P/It40Xnd9TuZQ8k00Nln+AgrrSKNWkxClFNVYISIgaUKqUulJgzlwEyAfVV64i0DcC7keeXJKJCAQiL+nu8/6b5kXrsHrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3MHk5ZLCVRhEK2a3HvtjWnwVHlfrZ8fStNaE/MLiDE=;
 b=MBYTv+Sb6w5pHdRGDm8DxNvEdOK7oWvLAoJZ3idFJlknjuyGf20Su0juU4mKPmxRRTV8AeF0zd+Qv4Io5R0xvO7GLFu3Av2pfT2j7qpesDe3FGiH+SYgUFTr0IzPNkwcYZx+NyzbeytSgqhVnTx2dsJew+wxrHxEjZbxG9wo4jDCPJPWMrDNWLRpeSysGqTGtL3JLN23u8/7q2Lh2KDUT2KmN9PGlqntyXbR+Xrxb06/pGPnTf1dolG53Z5XJvfa4HXUCRhGEjpQ0Sw9LGXaneDHev1lrYdJxaupfYGCb0R/P5mIk7KCMzuCMGhDYxKSAaKEM2BZUD8Dm7a2CjH/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3MHk5ZLCVRhEK2a3HvtjWnwVHlfrZ8fStNaE/MLiDE=;
 b=nklzFW9eVU+ZrbH1sXXMrr2OIF3BiGxYR9r/nfY5ERvz4oW38xT7BXugBgYrQUb/D6P93IPBJNazrn7mQqIq85nuXfAdoZT+7tLydM57+4sKPEi5QYHa7GfIhxeGdEyyYBgvZ6GewrDmqU0ZAsee07qbS0SmoNQTQpoGAcEAViU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 29 Jan
 2025 15:22:15 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:22:14 +0000
Message-ID: <d32aef16-1f8b-4b46-8ca7-9ba801a96cac@amd.com>
Date: Wed, 29 Jan 2025 10:22:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] drm/amdgpu: Add a func for core specific reg offset
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Lazar Lijo <Lijo.Lazar@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
 <20250129084643.507727-2-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20250129084643.507727-2-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::6) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f71242-8678-4dc8-9f36-08dd4078b5cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjM0bVJrQWlIUlpGRy84MSt0eFBEeXl4QjAxcE9YNWNkbkJHY0hmT29POEtu?=
 =?utf-8?B?NUFHcVMwNmQzQm5pODVkYkk0bXdialNkRXNVOHhtdGYzOS9nL1YwT2JSZkFB?=
 =?utf-8?B?dW9uUEczZG5PV0NmczhHci93T0xBa0FXc0V0SDVyUmJNWit4dmJPa1B0eSts?=
 =?utf-8?B?c3FiVndwU2t5SW1EL3ZKaVA5eXdPSzZLaGhTczRsYTdmbHlFNTRMS3JkbGRL?=
 =?utf-8?B?MXUxdXM1dC9DbG1EdEt3ZEIzRFBDM3dSTk0vYjEvR0Q3c0xsSTNORmNibGRt?=
 =?utf-8?B?d25NVDAwZUhxenFhd05XMHluL1haOGRwYXRJNjh1Nm1SMzNXU3VIQzArUkY4?=
 =?utf-8?B?QlUxSGFQVWlhYzlBYjkrMmEvR210MzBlT2xFcHgwUXdmYWdIYlIxNEhxNXdj?=
 =?utf-8?B?ek1QZUgzTzJtbXBYR2IrVDRUS21rZmJvUCtTTXBqZG9wbXFTY28yakVwSnFk?=
 =?utf-8?B?Q1V6aHU4T1lBS2EvTXRoREZkSTFtNXJzTXBFYm82Vkd2WnVLNWpXSk1RNHZo?=
 =?utf-8?B?UGVUUUdseFJHTGVSeVRGcW01MjhpaldvTGsrbnJNRVVXQnFiMFNvZzlxbU1w?=
 =?utf-8?B?ak55aFFOODloNVM0YmV5WklkRHNYbjNOWndlVWw5cXhSOWtGWk8vQy9vSFZW?=
 =?utf-8?B?OFcwdU10ZDZobStxaEFOb2ZQYnI2dDEySjVwWDFiTlM2VUV1YVV1cStJRDlN?=
 =?utf-8?B?ckowSnpLdlAyK3FMOENGZFMwUDBvczdCcjhvcEF5UjcySUIzTXFWa3A3dHYx?=
 =?utf-8?B?aUdhc3NBYW1DVEMzS0lteElJNTRtZ2U4am1wZHRTREdQZUNucllldTNHRTg3?=
 =?utf-8?B?aWdTcnkyREVzWVdrQTFuS1FCTFRJalJJUm9tbGFyWkFaK0pQZW9zTWdsZ0dZ?=
 =?utf-8?B?OU5pZWN0c3EwQzdLYVJDdm1Ic3VmYXJEK0ZOL2ZHS2taZzY0bSs5UUpRZlpG?=
 =?utf-8?B?bDZ0cmw3amduTHkxSEFBUUIyZEt3WXJhTFIyYVdTekR2SEVPSEF3SlNUY21Z?=
 =?utf-8?B?MjUzdXhESmJ4RWFnOFVIZGYxQzYvblErVDVkN0hmdG5ISDJWRlYzdHVrTmZx?=
 =?utf-8?B?RWhLSDNrQmdMaXJTQ2tkTXBycGJObG5QY3hFRnNVTU9VQndhT3FmMDQ0NmtP?=
 =?utf-8?B?WXZGaDFrYXlDTEV4U3k0UE9Ec3Fabmk3T2xtTm9WK3ErdmpDdXFseCt3U0lw?=
 =?utf-8?B?U01MdHZrRkovUHR3b3N3VlpVcys0MnBqY1NJUHBuejFvbFVGeDBWUmROWnNL?=
 =?utf-8?B?am1NZFdCVUU4RFArcHNkVWpwTEgyNHVMVllZai9YQzZoK2lCdVl6KzJ4N2Y2?=
 =?utf-8?B?OHBMbEkvZFp1c1NIME5MSFUvb1lyNXVRZGtRek5ienF4VzJkL1JaYms0REtP?=
 =?utf-8?B?Rm5Id3V4ZVY4MHRhR3ZCSW5YRDNsTGdXMEFGaldqbzU3R2dLWmM4WFZjNWdV?=
 =?utf-8?B?dWNFYnpVbXJab29TaUpvbFZYU1pmMEVvcXpidDVKU0U0em1QRHExNXdOM0ho?=
 =?utf-8?B?dXNQWStvY3hrMnhPTEkxL1REMlRiN0lGc1pEVTB3M29RZ0ZENTNDd0c5SkJX?=
 =?utf-8?B?UGQ5a09UK2pBZTVJVUY3L0NXZUVPODEvYWxJR3Nrei94WEx0TnZ2N05aQUtG?=
 =?utf-8?B?VUhqS3BST1d6a3JtdXNjWXltdXpoMnF5dkhUb2Zsc3JVSk8yR3l1NG5ma1VU?=
 =?utf-8?B?R3llLy9sUVVPMnlNQ2hFenA4cFhvT244UjFrTUlwTWYyV1ozQ3ZOZ0dQRjZH?=
 =?utf-8?B?dWpORFhzNDhYQVBVMGZrV1QwY1hSb1Q0bUxaYlUzRi9sOUN5dXFnbWc4WHhz?=
 =?utf-8?B?UE1wUmFVVktXUjRqNTlSMDhkbjZISWdkbktFMlloVWdVZ0FhZ2VGaUZQR1k0?=
 =?utf-8?Q?lRS4BmGc4GiPc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y05KajM1R3FLL1l1aXlXakpGS3lUOUJxb1lTUE8wU3BwQ3JHRGVnZlB2bnZi?=
 =?utf-8?B?N2gybVpmZVJNV2NGb0FibG1xNTdVazRIeFUxQ3BuOHdLaktHVUdEUGY3YWpa?=
 =?utf-8?B?cnZwaU5nbVpaK05TeHg5ZWgzNXk1MjNWVkVyZzh0bVBFQ21MWktlbFlYTFpt?=
 =?utf-8?B?OHlXbGs2ekVhY29VK3ZPY2R4NnNOUEx6cjlTMjVEUW90WXJ3d0FURUFOTnA1?=
 =?utf-8?B?Yk1sc0ZhTnRrOFJZNGJWRzJEdkZyMkJzSW1vNnQrM0FQVFhyaVRKclAzc2dI?=
 =?utf-8?B?RTdhK0xlZVEwWUkxZW93Y3kwOFR5TFU0R3FjY1Rjd2p6VUNCdTJqdXY1dDJk?=
 =?utf-8?B?ZFZ0Q1FDUytPNmJoYm9wOHd5NGxhbCsxUjAvQWNnSzd6UDBXbWpaYnZMVzc1?=
 =?utf-8?B?UHVnamV3dEQ5RXhZOE5DTkZnVWVJUVp0cXRJTDUzWVRoVStrbU1zOFphNFVT?=
 =?utf-8?B?NGxCK2FXT3R5ZHkySXE2QUZCbHVlNGkveWtsc3FPQlJFdHBYUERGSytodmo2?=
 =?utf-8?B?a2I0NlJmQm5vMHVON1hMUEtHU2cyNzBqbC80VXp1Nkg0NVc2R0pXeStWaDhQ?=
 =?utf-8?B?REpINktza3BFcnFqRFc5azNZZ1VaMEZQNmhwZnMyRFM2RnljazlLYWI2ZW93?=
 =?utf-8?B?dEt6ZFA0NFl0M25JblZRTkoyT1JBTlg2SnVscjZHSWFlTFdsdnFoS3dzNTg2?=
 =?utf-8?B?a0cyMEdzMGFKczV6RFVZYTZmTkpzNXJUc293c3BqYWxTY0ZOS1pOOGVhQi9a?=
 =?utf-8?B?TzhqN2docG0xK1JpY25rWmYyY2k3RzhXZEUyQlRQdDVFditNV0xNYlJMSjRJ?=
 =?utf-8?B?K25UeHZwREh1cGdMaU5UOGN2MlI3M1c1eHNueGF2WlFqZlRVWUtZV0thRUJS?=
 =?utf-8?B?Q1d3N0RXWFdpazNZL0V5RStNK1pnRlYvRmFjdmt0a0dWalFjWlhYQ3ZUWUdF?=
 =?utf-8?B?cWpKWGJieTJad2tvNFliYXoyNjNobUVxeDdkcXlFTTkrc0k3aWtsQ0NuMzh3?=
 =?utf-8?B?SGF1Yk83UFB2SzB2MWcrMXduenZ0NmJCZ2hhak5zbE92Z3VJUUw5ZjFqTllw?=
 =?utf-8?B?NmZRZUxHODkxcmRoOWVMakJQQjFXZWpOZDNZazM2elEvbEUrZlpLRS9KL3M2?=
 =?utf-8?B?a3plYjk4N1BnUEhCMlprMTJCUmpNb2p4czNDZ1dVNEJnMkNhSE11cEtkZGxE?=
 =?utf-8?B?YVJJOVJMdmExNzUzNjAwN01PQmJvUzRMRTZFUEk1czcxVDdGTUxVZWVva2JS?=
 =?utf-8?B?RDBOUzhjcjNjV0V4T2VyWUN0MWdSUnlycEx5N2RqUzFOYmFReVE4Ry9kaks2?=
 =?utf-8?B?L29CS1BSdnZzcWptbHEwVDF1bXoyenNqQnlaSkZpdlJtcFpPTHZxZFhrekF4?=
 =?utf-8?B?WVZwdk1NWHVJUkQvTEd5dVhwdUMrdDFORTZlKy9YcDBDVWJuL0RUNzBnc090?=
 =?utf-8?B?cDJSaGs5Tzd2S1RnUlRWQVdLOEhMWWl2bzU3Yi9zRDFmVXZmL2pYZHhzUko2?=
 =?utf-8?B?bEY5N1ZOaXFyUngzSjZQVE1CQzZrd3JEWmM3SG9RbTQ1eXFjcE81eHRScFpX?=
 =?utf-8?B?cXcrZHUrbS80MzZOaEp1bmlKSEU1bldzL3pUWDZVRzV5TjBQRCsvbWI5WTNn?=
 =?utf-8?B?RDQzQjg1SmE0T1Jjd3Z5Rk5pbWpmV0FHcHQ0N2VYQ01BMmZkL2NIV0cySlhv?=
 =?utf-8?B?UitoU21PVnMxSm13WWJVNWRYczFpbnNRL1cwczlZdkFQMjBuVnRnMVFVd2I0?=
 =?utf-8?B?QWJlaUZjSHJVYmV2cTdYSk1EUmxPQUd0NjM0ZWp6UGErUFRaYzVpRjcrNUVZ?=
 =?utf-8?B?TnlCWndWNHg1K1YrdmJSekxDbzZDTG0rdThucFpWLzRmZndxa0lQZnpnZHBF?=
 =?utf-8?B?M29maHUya2N1eW5QWVZoSld6RnJtNk1uK2VFMUhUMFdRenRXNEtyWUs5aURZ?=
 =?utf-8?B?dnBnV3MwWmNscGpVbWx4QmJIdDhweE83S3d6dHF1WHdZaXpqeU9tU3g4d2d6?=
 =?utf-8?B?QUdxNUZiVGZUaWNVM0s4bm00YXo5cmllOGRMSHl6NXhqVFBVK2RlNVBsUGhW?=
 =?utf-8?B?VEJQREtJdVFTbUVjYlNOZjVJR053SzU0bjZBVkluQWpUdFE5SkJpNml2cWtB?=
 =?utf-8?Q?Kr/KnF6X+si1CY5Y093HH1SDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f71242-8678-4dc8-9f36-08dd4078b5cf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:22:14.9232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMBUWDLxZlOGuILpFwsreBvkS3GODLo7pDtZJ2DD62sQXuTbED9NSjcfd0DSQaWw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120
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

This patch is:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 1/29/25 03:46, Sathishkumar S wrote:
> Add an inline function to calculate core specific register offsets for
> JPEG v4.0.3 and reuse it, makes code more readable and easier to align.
>
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 54 +++++++++++-------------
>   1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 9459e8cc7413..bc21f12daea8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -64,6 +64,14 @@ static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
>   	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
>   }
>   
> +static inline int jpeg_v4_0_3_core_reg_offset(u32 pipe)
> +{
> +	if (pipe)
> +		return ((0x40 * pipe) - 0xc80);
> +	else
> +		return 0;
> +}
> +
>   /**
>    * jpeg_v4_0_3_early_init - set function pointers
>    *
> @@ -143,10 +151,8 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   			adev->jpeg.internal.jpeg_pitch[j] =
>   				regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
>   			adev->jpeg.inst[i].external.jpeg_pitch[j] =
> -				SOC15_REG_OFFSET1(
> -					JPEG, jpeg_inst,
> -					regUVD_JRBC0_UVD_JRBC_SCRATCH0,
> -					(j ? (0x40 * j - 0xc80) : 0));
> +				SOC15_REG_OFFSET1(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_SCRATCH0,
> +						  jpeg_v4_0_3_core_reg_offset(j));
>   		}
>   	}
>   
> @@ -521,7 +527,7 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>   			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>   
>   		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> -			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
> +			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
>   
>   			ring = &adev->jpeg.inst[i].ring_dec[j];
>   
> @@ -616,9 +622,8 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_rptr(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   
> -	return RREG32_SOC15_OFFSET(
> -		JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
> -		ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
> +	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
> +				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
>   }
>   
>   /**
> @@ -634,11 +639,9 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
>   
>   	if (ring->use_doorbell)
>   		return adev->wb.wb[ring->wptr_offs];
> -	else
> -		return RREG32_SOC15_OFFSET(
> -			JPEG, GET_INST(JPEG, ring->me),
> -			regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> -			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
> +
> +	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> +				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
>   }
>   
>   static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
> @@ -663,10 +666,8 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
>   		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
>   	} else {
> -		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
> -				    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> -				    (ring->pipe ? (0x40 * ring->pipe - 0xc80) :
> -						  0),
> +		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> +				    jpeg_v4_0_3_core_reg_offset(ring->pipe),
>   				    lower_32_bits(ring->wptr));
>   	}
>   }
> @@ -919,13 +920,9 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> -			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
> -
> -			ret &= ((RREG32_SOC15_OFFSET(
> -					 JPEG, GET_INST(JPEG, i),
> -					 regUVD_JRBC0_UVD_JRBC_STATUS,
> -					 reg_offset) &
> -				 UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
> +			ret &= ((RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, i),
> +				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j)) &
> +				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
>   				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>   		}
>   	}
> @@ -941,13 +938,10 @@ static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> -			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
> -
> -			ret &= SOC15_WAIT_ON_RREG_OFFSET(
> -				JPEG, GET_INST(JPEG, i),
> -				regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset,
> +			ret &= (SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, i),
> +				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j),
>   				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
> -				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
> +				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
>   		}
>   	}
>   	return ret;
