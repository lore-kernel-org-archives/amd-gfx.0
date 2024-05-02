Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2B7C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 09:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0714810F3A6;
	Thu,  2 May 2024 09:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PURrJno2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD0910F3A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 09:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3JFohh3FE9/t9ZOK0pkQ1927R9e6M0NMUs4zzE+nIwR3O8PD36SipWmwdoVyeGSBBJqnzOsLGDtopxEaGLhoi6R8uQGMvqqNQi3h0x6/DtuztRRrz8MC4x41i3LWCflgAvC/GU/YxVW7yGyZB2UYkCfJqxfsUoD+Ij8V2CgLVs8G4RHL2fiYbZAw0OFtWV374mJhnhvcyQq4PEVki9bmQaim7vMuBXwZ73I3EWmYWvZ4Nft/ysRPmpfP0YbCpU8qfGDN/FuyGQNpesJt1KdAj1lB8SgU7taNb5qWkvJf6dEKmOOcVUGxQR+pvvmnhkKhaMZ12Bk80VxOZN4eyvMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCQzDC/cyYT7UR8GbsAmteVIEqx5CSbermI/dj3G19I=;
 b=K+Ci9Rz0jApiRjoV0On62yzZRcY8K0rXzdcA0VHJDZk9xS/LUtv/yXLMNU/NFA3ZPNXmSNqpdMF77PeqyI8+tUNsxD8eIqo1C78+FQYBUCpG6OYTPxJMGWTdvpY9KftrTwVzGqgyeR11MMG2XYj3BQ2ZVStcWzB0UUw9oY/KU0XWUo9lbA59gjbEa3aJLYv5GbkriJ0EjYbTqeXwzCN1TB4QSXQRyKmrPwIghL29yDC0FnK5QprrYD8kgw9R2xqh7g8jetW5MlRtbMIynBzLTDeJYv3rnqV1SPGgu/jzZGFm7zVEJUNQwzSg6Guz3CKtCZMtMKN7Js7oOVhjekKPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCQzDC/cyYT7UR8GbsAmteVIEqx5CSbermI/dj3G19I=;
 b=PURrJno29HmK235nmtNJ0S4skE/Y3YYil4Y/3tUOmfxnYed8ogIJdraFpcd6Mc+dxRCR37jN0swqqQj1ZWO+6sXW7TD++lYieyFyu7M1XwHn0MiXV5KduaC41BO//8joOO9eFb+QWjEU/InYQwdIFbUg2tJGRl4auiqcJEMwQfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 09:41:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 09:41:20 +0000
Message-ID: <3abe36fc-4564-4f07-8389-6e583759c69c@amd.com>
Date: Thu, 2 May 2024 11:41:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove ip dump reg_count variable
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240502085636.1890568-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240502085636.1890568-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:118::40) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd636eb-7ef8-4733-b0e2-08dc6a8c0509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW01Sm1pR2o0RGJ4S09qZVdkaERWYjliUnAwdjBnR1BjM1VNTStzUlJ5ZjNz?=
 =?utf-8?B?ck5vOFR3cmpoMVhhdytBb1dFcWxFSFQwT3JncEkxOU9jaVJLWDdFOTJZak1k?=
 =?utf-8?B?MlZzWWo3VXdOU1cyOHhaWmJUVS82MDE3U3U5cmF1S0tSN3ZmS25Mc2ppa0hU?=
 =?utf-8?B?L2t6eUhiNi96NjR2QnlJayt0NVZDQWMrcys0a25FQ3I5WnFTdmxIT0hzR0x4?=
 =?utf-8?B?NTZhWlNWbnI4dDQ0NnFMS3R4bVBtVWs4aUJLaXJsd0cxR0pLWWxDWjB6cGdD?=
 =?utf-8?B?bUZiTFd5NndqL2hnWGN6RDV4RHJLWTI0UXlQTWx5aTM1em1zdmN1d2gvMHhI?=
 =?utf-8?B?MWkrN0FtMExVeS8zR0NDekFCQUlBQ0NtSWpSKzlTVndUS2drRmtrWjdGY2NB?=
 =?utf-8?B?MjltVDgwSzJMQWFsRno5RGNmQUVacy9iTlZoS2hXQS9jTCs0ZjJUMEU1YXpK?=
 =?utf-8?B?QVZiZFlWZzhYazFhTUxyM0dOWmZPbHhyYTcvSnNYT2N2cnZhR0tTTnh5NlBE?=
 =?utf-8?B?bm5TYUxYUkFaVWV3TXVBTk10Sko2Z1ZlRkVDK1VNYzVkVkI2TlhNZ3ZZaWdR?=
 =?utf-8?B?ZitWZ2R1Q1RKTHJ3NHh4dzhTSHVPSTd4UVRBUEdHR042N3J3MTFtcXpxbklC?=
 =?utf-8?B?cXYwbEl1R01DNklJNHpidEdpTkxZYURNbEdvQW1FSTZJNlcyRU50VG5YS21M?=
 =?utf-8?B?MnUxOVVud0xha1lXSUxqYmNTS1VIYzFOMENrbGFHL05RUHlCOVpVK21HYWp6?=
 =?utf-8?B?MzJkbzFvYzMvdnprSHkwQ2M3QUFzM1NBK2dhNmhibGV6b05IUHdvR3lhNUdp?=
 =?utf-8?B?eGZNNVhnQ3hDNWF4djJ0M09ZcUhoQnYydElpZ0RORWxiamRyN0VVRUlaMkpZ?=
 =?utf-8?B?clgzeHlJeTNTWHNXUGY5NldCWGkxcVR2b0dOYWFUOTFKODI4ZENYZmNkeHN4?=
 =?utf-8?B?QjdDQktWY0tycVprRTNzWk0xeVFLVkNHR1hEMkFhVmhlcXBBYWRHWGxSOG96?=
 =?utf-8?B?SjRIeGs5Ylhyc21UWHhXeVRvM1dIdUNLM2ljK2ZnbDN6Q21IeWN2WHp5VDNB?=
 =?utf-8?B?V3AyMlBESjZNZTdGdnJHSExPZm9KUG4xSlZhTUlZeWJicEtucjNJNkE0TDI2?=
 =?utf-8?B?ckZGU3dhUjJGTzk5cnZ5WkxRWkFBNHppa3lLanZ2aEJiY3J5dGxhbndwSFpM?=
 =?utf-8?B?ejVraGVTT0tmZE9QMGEwbVJRY3dTZTRhT0M0TzJzSkxBUUhpYXpjd3NySW9Z?=
 =?utf-8?B?eWQybmc2bEtLb09KTTJmc2lqYURpNFFLU0oxK3IwNFFFeXV1LzMzK0xrYzVP?=
 =?utf-8?B?WXlaUU9FYVRXSUdEL1FqR21XcmIzZlBkUjNVN29wUUZUelhPTXlWREJQcEZ4?=
 =?utf-8?B?Y0RweUkwYXFnU25CSVhDSndKSU9xcW9YT0NPTUs0QnRUUmR2TE1RNmloWkJH?=
 =?utf-8?B?Q2xSY2ttWkhMUzFCS051S3lWQzd5NkxEQnpqaThMK3JYYXIvSXNmQmlHbXB1?=
 =?utf-8?B?UUEwcitOdm5RWXRWbGo4aGNGMmxjSGw5SnJ2K2YweTU0aGFNdVB5WTVLc2p5?=
 =?utf-8?B?NGtIejcxNXhzdlNxS1NIbjhxd2RrOUoyYWlKemFTaVZpY1pCRkRwdDRGLzRw?=
 =?utf-8?B?bEJuaWZ4RlpJVkZBK0lxeFAxNm03c0NkSktYVVpRTjNuSFY0WlZoeVBENUFv?=
 =?utf-8?B?Z1JKVFQ1VUJYRnFFcEg1Qmc3TWw1OWpvdEwrdGo1Y21ITGFIVjNic3JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm02Wmp6MHE5R0FoZjRHbHBvVGkvQnpyWDUwZGhERFlBWSszZkZZOGQxazV3?=
 =?utf-8?B?Rmd2U25nZ1RiOXNWU0dkOVRTb3lINzlZTVlENll5TWhCVSsvMGgxdnl3TkVk?=
 =?utf-8?B?TzY2WjB0ZFFIQzhpQis3WWR6WUNabG45bjBMNGw2T2cvUk54Mkltd0R3Sm1R?=
 =?utf-8?B?RWNvaEtjSGNKbU9SbzVJMm5yd3Qrb0JCWWtHdFNKb1drcU1XUk5uNVFLMUVk?=
 =?utf-8?B?aVJrNExHejhYV3BWK1dIOVB0NDE5VkxwRnRpbnVnK2JveFdYU1piOFlITGoz?=
 =?utf-8?B?RnArSnFMZC85dlU3a3h6b2N5ekU2QWhPTUhRcGF3YU5EVS8yM09VV0o1SFEv?=
 =?utf-8?B?bEZtOXJxem5iYVQvWmJ0dGFEM2RzNE43RzcremJrL1ozRWFlZ2N3d1JSRExh?=
 =?utf-8?B?bCt4bnN4YVRNSUNQUHFUS0dBOTlrcnRPZStLVWIxNmw2L1Joa1BSb1JkT0s1?=
 =?utf-8?B?eEZOR0E3NU9DZTFHMllXTjlTYllzRG1wc0NDOThIMzZ3TUYvcW1HQUhlVWlZ?=
 =?utf-8?B?NjN4ZWJGdzVvN3V4YnRJdk1KcU9lbzJROGZsVGc5MHErOXBDTEVrL0VKa2Zy?=
 =?utf-8?B?aDhoTW5ZNk1BMktNMjNNeVBiYXRoa1UzTEc1elNqN1pxWTRQNDlTQlVlMzV4?=
 =?utf-8?B?Qis3VlFmOC9Ia0Z6ajU0S0pDdjZXMG9KM2VKUjJ3Y3VBMVU2ZGp2RmZCOEV4?=
 =?utf-8?B?c3lRRFNqbjBWMU4rYmUzMjZOQzdSYlVCRHNaNDR3LzZ1Y3IvNi92RE1idVNN?=
 =?utf-8?B?bTVQMEwyWkZwdlZsSDJVdUNrY3MvY0o1ZUdNcFFCM3ZGc3Vwd2U1SnBzRWRN?=
 =?utf-8?B?NThjMlQ3SmczTXU4RHlydVVaTEJpR1Z2QnJxN1k5WkV2WDd1TmpGbGJpb1M3?=
 =?utf-8?B?TnNZakdzcytQT21iMnpoS1k4NjlFUDBTTWt1cmh1dXdUN3BTOXl0R1BVM0k5?=
 =?utf-8?B?dXkybTh4QzZjcE1KSm9ma2lQQXBqTTJXS213eThKNFBhRmhLMm9vMklBM0lF?=
 =?utf-8?B?NFpGZ1ppbis3bXFIL0FSUW4zSUNDVlNYSjNIeXRKZ2lRSmxldldYTUNjRlc2?=
 =?utf-8?B?SVlFTm1JV2lDMXN5WkhSWFhiV3JXRjNsUWd3cHF5YnovWHNZMUYzL0tSUUJk?=
 =?utf-8?B?UTBNZ2tEaXo3TWwwb2VMTHZ6YjE1QkpvUFRROTZlc2JKZlQ4NzNjNVdXYXZM?=
 =?utf-8?B?Tkc2RVJIdUlhaHhLa25UeDhpZzVEMEwyUTJuWEhCNVBUa3dlZFBlUVBSYm1v?=
 =?utf-8?B?NEpPNXloODhpVDdEbElKRWszV3Q3U1JoeE9FakNHYXIreGJiWnQrTlVNaFQx?=
 =?utf-8?B?U09ST1F3bWc3cGdGdTllSzdsOCtrdDVsemxOR2l6cW13MFJiRHRIUHFNYm91?=
 =?utf-8?B?TkFacld5QTVyKzFqLzV6K3lQOEM1RnBjSVpXem5CcEp5a0ZvVGRKeStKSVNJ?=
 =?utf-8?B?QWRITE0wYnkweURhKzlSY0pCNWU2enNTekpXZ2JlNS9HSHkwTkMvdGMxRUJj?=
 =?utf-8?B?R2s1MlFpMFBkMmFtNnh2b2lLaDVKWUFxU0hqMGhWcktEUXUrZGo1VEQyY0c5?=
 =?utf-8?B?OE51ZTZjNGpwdGxoNDdpOUplZmpnZmtvbTUvNXZ2MllEUlgxQUxKRmRIaTQv?=
 =?utf-8?B?ZkNrQVptSmI1VkNUemVwakx0cGlyYnJnZ1daNFh3dzI1WUpLU1htaStpS01s?=
 =?utf-8?B?emxzd3Q1WmFWMnVMZ3o5NGMzRHJxYXpNV0VLR0NvS0RQei9ZUXpvRXUvQ0ox?=
 =?utf-8?B?YTBaamppZmphY281WndkeVFGdGZMNHN4WmhCcCs0dEp1ZkRKS1E5Wk1HbjVT?=
 =?utf-8?B?OE45WkxOVXQ1MVVLd3ZHSjdBd09LdkdDcU1HOVc0cVBrRi8xQStobVE2bjBw?=
 =?utf-8?B?STFzd3M4VkJyUzlLK1NEQUhaanVaR2dnVmxXZnErMmtmd0dmNXc3UksvTG9Y?=
 =?utf-8?B?U3NIblNWY1BPRXA0UWtyVGJsaTBZMUVvY0VxT3c1YWQwYVVmY3htOE5Sdk5t?=
 =?utf-8?B?SWlHaGx2UDBkcmNBKzY0MVB4Z0lJRnQ0K1M1TWRjOUJ0dGl2Rno0UDJ4dDdX?=
 =?utf-8?B?UWVSQ1RzeW94blBpMytQVWkzMWNFaVdmQkEwU1Z2amRCN2psdXFhSXhlU0JK?=
 =?utf-8?Q?Mcx4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd636eb-7ef8-4733-b0e2-08dc6a8c0509
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:41:19.9931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx4VSqbnDA89tXIAHzPtjbfYNKWeGVCpwc+4lpR6l2VXN4EWkUNB+Yl3eluLqXso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518
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

Am 02.05.24 um 10:56 schrieb Sunil Khatri:
> reg_count is not used and the register count is
> directly derived from the array size and hence
> removed.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 -
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 2 --
>   2 files changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 64f197bbc866..9a946f0e015c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -436,7 +436,6 @@ struct amdgpu_gfx {
>   
>   	/* IP reg dump */
>   	uint32_t			*ip_dump;
> -	uint32_t			reg_count;
>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 536287ddd2ec..3171ed5e5af3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4592,10 +4592,8 @@ static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
>   	if (ptr == NULL) {
>   		DRM_ERROR("Failed to allocate memory for IP Dump\n");
>   		adev->gfx.ip_dump = NULL;
> -		adev->gfx.reg_count = 0;
>   	} else {
>   		adev->gfx.ip_dump = ptr;
> -		adev->gfx.reg_count = reg_count;
>   	}
>   }
>   

