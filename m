Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A761C5474A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 04:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF08910E145;
	Wed, 28 Aug 2024 04:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YD3AEf8i";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57A010E497
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 04:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wzp6NsPCnuJItkPqMREimNwOpjU4aHtKAraqcdCkw0T4eQ/pY7KupMJZyu4WE3wHgANbp8EfRmNZGKHcE/g5rTdYvCdyUije9400G4znoZ/bg1Qvk5EJTtu6ux1s4ubJA8X3zcHcdDZIhh7SMXlMdJXgwkys1jwYSJfqRni1rNayYh50XEDTvpNTK6TnWyBwZFSYR8A2N7nF+RTacwRhD4WdXFwjoqacG5QnyKyPH8oAeas1ilC9wUAJIYbUv14dtG0kPx8a8lWeMmRX547iQhRGu7YtVN0EtYLPbACR6LaSBF/IEtTfS0iPGNMdvfZ+FNxL3J2i2zf9tYZCuRiXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncaC8XwvEoKQe/7/CKJ2pEm2OYUgDdZB9oTmGcJheRM=;
 b=IH9GJyuwODlTiTy81F8+MCFRUVEQ2E0D7pbyzXCruqo8p60+wfxozz/zfTFQiu2gXS2DgDl5X1ILQyu0orh998phENeyGpVMqAByW64vTG0Z7pTtEQEOERXUVT9d/IqckdpLS2SXkJjTTns0HWycomRpLrnFGMSA2SZRGBN4Gts0ji2BYqlRqcL2Qh5AWMI7HTluvqiIUvE5/R4wStCof8mmwjFvIbn2/jefQ2s6oTlRBDk6m3VxSh0qpW5doo24MelN5ihBLNtdBG+jie8f1MPjl/3k+5VokgVLefFqsAvmb+2H2YF5IqXFJeaJxf6T2wZvtsXcI4WkO397gpQf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncaC8XwvEoKQe/7/CKJ2pEm2OYUgDdZB9oTmGcJheRM=;
 b=YD3AEf8ij73HkGy9Rso4dIGJpMGHgLKtqOMGDlSjCAbGkkiivapqNsU24jRt+LJOZRX6YqrKNmXkNyrgTSYwiZ7WcsLK0W/YjnxEuXezAtFv00vmSDK3TR0odsRcjY7A4Zq6FtU8O5WoyhKJv9f+Ytb+XVAKSLZZDd9VQBIC1YA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 04:49:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 04:49:00 +0000
Message-ID: <07702509-fc33-4079-bd7a-e241ba78dcc6@amd.com>
Date: Wed, 28 Aug 2024 10:18:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: nuke the VM PD/PT shadow handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240827141211.2411-1-christian.koenig@amd.com>
 <20240827141211.2411-3-christian.koenig@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240827141211.2411-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f66683e-1f3a-4830-ffec-08dcc71cbbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1JoSTlmTjZkMDBRbEtQUUF3RHAyYzJWSm5VNE13OFIwcVJ1Y05iTXFzU2hw?=
 =?utf-8?B?Uk1RWkdnNnNDSDhEcnZ2K3k3eVY4eEJDS0hIYWdrZkxpaFEycG5iZjVaTVFL?=
 =?utf-8?B?V2lEVmZYNjJTZ1V6WHBjdFhoTXVXU2FWRWFJM0MxcGozN3NlbGdibldKMUZF?=
 =?utf-8?B?M295MjhRZmFwSHRvNXZmaDFpbU1mVnJtUlpiVnNZcXErK0x0Z2pvbkExNjRh?=
 =?utf-8?B?YzNxRTNEbkxic0NwVDJHT1BTbFhLd3hmRG54TW5QZnNsS1l2Q0N6aTNuekEy?=
 =?utf-8?B?UHUxSXUxUHR6bFRpZ1Arb3d0aVdrVFNra00vSmdLZ1JjNFI4elNUVHJBK0VF?=
 =?utf-8?B?SkprVk5NNStPTlc4Tmw4clhQanpUY2k4N04xckJ1cVhMV0lzUVlBU0dIUjRr?=
 =?utf-8?B?ODBBL3V2Szlua1U2WlptMHVZUWlkUHl5OENUaGZUZ0swSENieEFuQlFadkJj?=
 =?utf-8?B?U25RbmdXc1ptWFVDTDVyd2N6Ykxma1J4UDZyZi9DU2FwdjlBaEtNTUxnTXBx?=
 =?utf-8?B?NXJNTGkzaXE3SnlaVmg5aGtCdmkyemUrMWxEa3U4WlA1ZWo2VHU1Qy91SnRF?=
 =?utf-8?B?YlJucjF2OS9vQzY5YldsMURGams3Y2tsN3JFNU5TbHBYTTFmcjBKY2o2RmxI?=
 =?utf-8?B?cFVzME9qRUVSSHg2dEFLTTJiR3F6MFpKcTY0WEtiRlFUcUNhZVZnbzdjTTVR?=
 =?utf-8?B?MnlmcUQyOTJLaHFlQVNTejNFNzZZVkR0NmhwNzJXYStzQnkwVmlQR3lVT0Mw?=
 =?utf-8?B?TEVQQklLdkUzVWlNSW1mR1c0UXlzTWFCSmd0SUkxRkRpYkdYb0VrRmJJRW5u?=
 =?utf-8?B?S2t0dDNGeUl6Vldubk5OODBnTHVPZW11cWFSblJWZGo0M3VvYnN6Z2xEa1hG?=
 =?utf-8?B?cWNWd0NWMHlyeVNsY3g2NHcvSkJQcEphTmNKWFE0c1hsOUd1MnUvZjZ2ZFRJ?=
 =?utf-8?B?aTJmQnVOWGxSRmtNVkdTLzQzVjZZTG9DZUo1ZmVTUFpMbitTdFhvSno1aFJu?=
 =?utf-8?B?T0FTUGR1NnVjRnI2T1BiK05LK0JvT3FaSlF4M25SR0ExMHFTc3p4M3NMdHYr?=
 =?utf-8?B?NDk1V2kwVUtaNzFwWHpJUFJ5S0labjZKaXRwc1FRcFBPK3JxcSt2eklsb0tJ?=
 =?utf-8?B?K0hTZTdQVXA4c3VUQS8xK21heW5PSUU0eTEzdUF3dzN4emJHVG55TWpROXly?=
 =?utf-8?B?dUt3VlhKT3VHL2ppL2FTT09ZYVdLUU5CUEIydWtCWmZ1ajJKb0FTYmwzcGhw?=
 =?utf-8?B?VnlrTzNyZkJpVHFmYVp0dVBQYm13MzJCUkJsbFRMYU9WYXh0NGNyK3RRWHlv?=
 =?utf-8?B?aStwQ3hmOStFS0toYitocWdIeGxLN3htdm9KeTdnOENXN0Z6bVErRGRaaVds?=
 =?utf-8?B?QzRMSFJKYTdET1Y1RWdTL1FBZW81MmlkYTNlMzlxUkpFY3JlVWh3bVk1aUtN?=
 =?utf-8?B?ZFd5aVZ2bjR2cGZaSG0vYWd3U20rRzZhVHBkcjRucjBzVVBtV1hqNStFMnk2?=
 =?utf-8?B?WmVnQjl4NUIrRlNHRlZBN3MvUzQvZWR2UkVlWFZFcHB5alFnQmZCY0VtLytS?=
 =?utf-8?B?cDBVKzlUSmhTQzZlMldPQmRkbnF2QlVNcmZ6Yzd6UW90b0E2WjFwTEdmQ0lL?=
 =?utf-8?B?Y2lHR0hKYVVxR3pzN0lLNzNtYVVCeUxxRlVOSnIvRmlnclBUVitjT2VuMkl5?=
 =?utf-8?B?Rzhac2YxUXNOeTA5VUIxY0xQSWJSamppbEl4TWJFZU9XUVBWVlQxQ2lIejg0?=
 =?utf-8?B?L20yZzd3WmpjSUNnanVrOTgvU2Z5Ym1yZklYcWFsUVhINkhiTDR6dFZCdW5k?=
 =?utf-8?B?aTluY2Ywa2ZoeXpkOEVZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MExtU3ZqUXZvdE1wQkdmQWszZWVmWkZzeGtoS09WWG1KZWNJL1VLVVdhSHM1?=
 =?utf-8?B?NElxT29VS3FhS2pyL3krR1ZMRUtnUTE1M2R4RlBWRUNpelEvVlQ0dEZHaDF0?=
 =?utf-8?B?TEQ0eUVuZ0dtTnlmVzBRU2ZqRWpTNUwrd2ZPcUNHRENDajM4WkZ2eUI5Y0V0?=
 =?utf-8?B?VjV6VmpVSkVpL09rc1hXNUpKdmplQ3A0ZGlJc3p4c0ltWVY1dTZmSGJweFlj?=
 =?utf-8?B?VEt6OXRsMXFxQURNcXpiSExVNGVjanhBNzAwem13MjhLQ0NoeHhLY2c1MTRM?=
 =?utf-8?B?WXUvNHA2VG53eEN4MjhkQTU2M3VUbjQzSFJMYmJSdTNoNVNPbHhNM0JuZ1RS?=
 =?utf-8?B?NnZmM0hLUmpZaC9QVDV5RlBtUnFINDlGM1BzY0sweHFDbEloeXJpbGNvWWov?=
 =?utf-8?B?bmhKN1V4U1BzY2liSkxpTFFPb1pkRmhvVUpBMHdKTXZVQUNIMFZ6MnZ3ejVt?=
 =?utf-8?B?cFdsRWtudW9YMHBHdTZqK3IwcTVkZTdxZlVMK2haMTdjZkI2Tk9XVUJLaXp0?=
 =?utf-8?B?ckdjQmpUaTJVQU11WmkyZURaY3ZyOGlpM0s4YmkzMEpvei9FSlc1WmhOUnBh?=
 =?utf-8?B?UmtzdFBYSHpRRTNja0M1ek5XQmdGQUdOOFRlMHFKcWsvakN2MDZ6bTl4T1Zl?=
 =?utf-8?B?UXNZUnVNU0RqQTFkSXI5QU5TbXRLSkpRZkpYa2tqcFlkdE1EWUJ2V2hiam9B?=
 =?utf-8?B?U055NnFkMlVXa0tDMHNFeG0rTFdtTFk2aExibm1GUEZEdzFTNVgySGllQUdE?=
 =?utf-8?B?cGkwM2FEckM4bDVXaE5hb2ltSDZlZGdrL2pXM2pCb0R6NFltSWhUS2ZjdXVS?=
 =?utf-8?B?OG5kMGdveWtJRVlQTkcwZEVBSkcySGw4dG1vc2ZZRndWZEJuZTZrZWQrMEhI?=
 =?utf-8?B?OWVndUFxckw0OXA3ZmZJbk4xeTM3WDRaU1NFeHM2NUoxY2pFTDM1d1pEQ3NG?=
 =?utf-8?B?dFlMMURDYVg2TWFLSHhIcWJlb25KbFpoK29mVk1jTlRJUks5RkVqeit3OWtU?=
 =?utf-8?B?WXBMaWs5MEtUUEtWVGQwSG5kYmhFdC9tNUxYY3FWZmNvRkozdm1KdC90QW5w?=
 =?utf-8?B?S25oNUpyZTZSNlhScUdaQU5DeFZFZXI5ZjFwQ1VKajZIQysvc3lIZUpPUXQ2?=
 =?utf-8?B?VzMrMERJY2ViQytCeXRySThHVEIwNlI0T1ltYSt0aVZFdmxNaC9jMEVBbGxE?=
 =?utf-8?B?RUVLbVVkMEFKaWhROFNPU1hHWktSeTZTaExUQ041SllZWENzTTBZMWhkL1Jw?=
 =?utf-8?B?NTlLTllaejU4aDFmZW5DSm4xcDI0aTE5S0o4SGRXV3dTMUJmZ1RZdUxIMmpz?=
 =?utf-8?B?cmp2bFYvYnRyaWd5S3BxWTBYWWliczFWZmtORkhNeVZqTTN3dmlHaE1CWFBz?=
 =?utf-8?B?RmtiajlwTzdPYVliSjhHRFc0WnNleG5UdVJoWm1kZDkzY2gvQm4yYk5JSlR2?=
 =?utf-8?B?VWYydjUyaW1kSy9HdnRwcjUzOFRpRW9ncCtJcXFYRUZqN2hycmt2QUt2eU55?=
 =?utf-8?B?WXJiZTZUOHdpVVpKQWJreCtzd2pqcDZVaEJHNmp5QXlGQ3BJc05RWnI2UjA0?=
 =?utf-8?B?NjJJVVBpUmhyS1BEMTVPRWdjQVUzc3hULzdIeHpEUjgzdGpndUJVQVBYMHRv?=
 =?utf-8?B?dkVXTm1weUJPNjNSOXE0eDAxRUxaY0NQMlROOWx2SUxLMmxmamtlUkN5ZUpW?=
 =?utf-8?B?S2xBYm1SOWZxRVJZam9vUDF4Z2NuV3Y5QVJvelNxb0N3TU5sSFp4MTc1aFdW?=
 =?utf-8?B?WGJjZ0JRZCsycmZNVndyZVM2QUZTSDdPcXBleDdjUm9ibFRzQkphc2dCMDNw?=
 =?utf-8?B?UjlQaW92QVhHanVEeGJxb1NzQ0Vib1NXZGpHUW9hV0p1ZERnU0ZKOXZzTTQw?=
 =?utf-8?B?R3BaV1ZmbmlnN2RmYkExTGtaWVJzaG5qVFVvRlovLzhvNHh0WHNiUDgzK0cr?=
 =?utf-8?B?TDJ4VS9qaldwdDUyVHlhanBoN0ZLMmQ3ZEhLZ3RKNU94akRmZXJTVStURjBl?=
 =?utf-8?B?ZWhKSFNiZU9jWEVOUDUzWnFzMThWM1R6eU5rSTd1emtSbk5EMEUvcmZyLzlK?=
 =?utf-8?B?eWFjMzE1ODBGUHFZVHg0R1pERDkrME1VM3p4REtpVld5cTdHcW90SkxMWTBX?=
 =?utf-8?Q?wM6eRW/5DrxSAMGMSdo/yX/2P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f66683e-1f3a-4830-ffec-08dcc71cbbaa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 04:49:00.4539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONqsHD1RZNkhQ2zxNo5F9Sy0jB0WCtbKQp0gWXLGESTErzRygcuq0/KKNf7681Iy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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



On 8/27/2024 7:42 PM, Christian König wrote:
> This was only used as workaround for recovering the page tables after
> VRAM was lost and is no longer necessary after the function
> amdgpu_vm_bo_reset_state_machine() started to do the same.
> 
> Compute never used shadows either, so the only proplematic case left is
> SVM and that is most likely not recoverable in any way when VRAM is
> lost.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

This patch works fine on GC 9.4.3 SOCs.

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Alex or someone else may take a closer look.

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 87 +--------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 67 +---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  | 21 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 17 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   | 56 +------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 19 +----
>  7 files changed, 6 insertions(+), 265 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e8c284aea1f2..e2cf77a93a0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1082,10 +1082,6 @@ struct amdgpu_device {
>  
>  	struct amdgpu_virt	virt;
>  
> -	/* link all shadow bo */
> -	struct list_head                shadow_list;
> -	struct mutex                    shadow_list_lock;
> -
>  	/* record hw reset is performed */
>  	bool has_hw_reset;
>  	u8				reset_magic[AMDGPU_RESET_MAGIC_NUM];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index da06705f0026..33a939571f89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4107,9 +4107,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	spin_lock_init(&adev->mm_stats.lock);
>  	spin_lock_init(&adev->wb.lock);
>  
> -	INIT_LIST_HEAD(&adev->shadow_list);
> -	mutex_init(&adev->shadow_list_lock);
> -
>  	INIT_LIST_HEAD(&adev->reset_list);
>  
>  	INIT_LIST_HEAD(&adev->ras_list);
> @@ -5029,80 +5026,6 @@ static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> -/**
> - * amdgpu_device_recover_vram - Recover some VRAM contents
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Restores the contents of VRAM buffers from the shadows in GTT.  Used to
> - * restore things like GPUVM page tables after a GPU reset where
> - * the contents of VRAM might be lost.
> - *
> - * Returns:
> - * 0 on success, negative error code on failure.
> - */
> -static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
> -{
> -	struct dma_fence *fence = NULL, *next = NULL;
> -	struct amdgpu_bo *shadow;
> -	struct amdgpu_bo_vm *vmbo;
> -	long r = 1, tmo;
> -
> -	if (amdgpu_sriov_runtime(adev))
> -		tmo = msecs_to_jiffies(8000);
> -	else
> -		tmo = msecs_to_jiffies(100);
> -
> -	dev_info(adev->dev, "recover vram bo from shadow start\n");
> -	mutex_lock(&adev->shadow_list_lock);
> -	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
> -		/* If vm is compute context or adev is APU, shadow will be NULL */
> -		if (!vmbo->shadow)
> -			continue;
> -		shadow = vmbo->shadow;
> -
> -		/* No need to recover an evicted BO */
> -		if (!shadow->tbo.resource ||
> -		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
> -		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
> -		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
> -			continue;
> -
> -		r = amdgpu_bo_restore_shadow(shadow, &next);
> -		if (r)
> -			break;
> -
> -		if (fence) {
> -			tmo = dma_fence_wait_timeout(fence, false, tmo);
> -			dma_fence_put(fence);
> -			fence = next;
> -			if (tmo == 0) {
> -				r = -ETIMEDOUT;
> -				break;
> -			} else if (tmo < 0) {
> -				r = tmo;
> -				break;
> -			}
> -		} else {
> -			fence = next;
> -		}
> -	}
> -	mutex_unlock(&adev->shadow_list_lock);
> -
> -	if (fence)
> -		tmo = dma_fence_wait_timeout(fence, false, tmo);
> -	dma_fence_put(fence);
> -
> -	if (r < 0 || tmo <= 0) {
> -		dev_err(adev->dev, "recover vram bo from shadow failed, r is %ld, tmo is %ld\n", r, tmo);
> -		return -EIO;
> -	}
> -
> -	dev_info(adev->dev, "recover vram bo from shadow done\n");
> -	return 0;
> -}
> -
> -
>  /**
>   * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
>   *
> @@ -5165,12 +5088,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  	if (r)
>  		return r;
>  
> -	if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
> +	if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST)
>  		amdgpu_inc_vram_lost(adev);
> -		r = amdgpu_device_recover_vram(adev);
> -	}
> -	if (r)
> -		return r;
>  
>  	/* need to be called during full access so we can't do it later like
>  	 * bare-metal does.
> @@ -5569,9 +5488,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>  			}
>  		}
>  
> -		if (!r)
> -			r = amdgpu_device_recover_vram(tmp_adev);
> -		else
> +		if (r)
>  			tmp_adev->asic_reset_res = r;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ff1a69243699..cc9506fb0cc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -76,24 +76,6 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
>  	amdgpu_bo_destroy(tbo);
>  }
>  
> -static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> -	struct amdgpu_bo *shadow_bo = ttm_to_amdgpu_bo(tbo), *bo;
> -	struct amdgpu_bo_vm *vmbo;
> -
> -	bo = shadow_bo->parent;
> -	vmbo = to_amdgpu_bo_vm(bo);
> -	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
> -	if (!list_empty(&vmbo->shadow_list)) {
> -		mutex_lock(&adev->shadow_list_lock);
> -		list_del_init(&vmbo->shadow_list);
> -		mutex_unlock(&adev->shadow_list_lock);
> -	}
> -
> -	amdgpu_bo_destroy(tbo);
> -}
> -
>  /**
>   * amdgpu_bo_is_amdgpu_bo - check if the buffer object is an &amdgpu_bo
>   * @bo: buffer object to be checked
> @@ -107,8 +89,7 @@ static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
>  bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>  {
>  	if (bo->destroy == &amdgpu_bo_destroy ||
> -	    bo->destroy == &amdgpu_bo_user_destroy ||
> -	    bo->destroy == &amdgpu_bo_vm_destroy)
> +	    bo->destroy == &amdgpu_bo_user_destroy)
>  		return true;
>  
>  	return false;
> @@ -718,52 +699,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> -/**
> - * amdgpu_bo_add_to_shadow_list - add a BO to the shadow list
> - *
> - * @vmbo: BO that will be inserted into the shadow list
> - *
> - * Insert a BO to the shadow list.
> - */
> -void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(vmbo->bo.tbo.bdev);
> -
> -	mutex_lock(&adev->shadow_list_lock);
> -	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
> -	vmbo->shadow->parent = amdgpu_bo_ref(&vmbo->bo);
> -	vmbo->shadow->tbo.destroy = &amdgpu_bo_vm_destroy;
> -	mutex_unlock(&adev->shadow_list_lock);
> -}
> -
> -/**
> - * amdgpu_bo_restore_shadow - restore an &amdgpu_bo shadow
> - *
> - * @shadow: &amdgpu_bo shadow to be restored
> - * @fence: dma_fence associated with the operation
> - *
> - * Copies a buffer object's shadow content back to the object.
> - * This is used for recovering a buffer from its shadow in case of a gpu
> - * reset where vram context may be lost.
> - *
> - * Returns:
> - * 0 for success or a negative error code on failure.
> - */
> -int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow, struct dma_fence **fence)
> -
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(shadow->tbo.bdev);
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> -	uint64_t shadow_addr, parent_addr;
> -
> -	shadow_addr = amdgpu_bo_gpu_offset(shadow);
> -	parent_addr = amdgpu_bo_gpu_offset(shadow->parent);
> -
> -	return amdgpu_copy_buffer(ring, shadow_addr, parent_addr,
> -				  amdgpu_bo_size(shadow), NULL, fence,
> -				  true, false, 0);
> -}
> -
>  /**
>   * amdgpu_bo_kmap - map an &amdgpu_bo buffer object
>   * @bo: &amdgpu_bo buffer object to be mapped
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 44ffd9a03dce..717e47b46167 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -136,8 +136,6 @@ struct amdgpu_bo_user {
>  
>  struct amdgpu_bo_vm {
>  	struct amdgpu_bo		bo;
> -	struct amdgpu_bo		*shadow;
> -	struct list_head		shadow_list;
>  	struct amdgpu_vm_bo_base        entries[];
>  };
>  
> @@ -275,22 +273,6 @@ static inline bool amdgpu_bo_encrypted(struct amdgpu_bo *bo)
>  	return bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED;
>  }
>  
> -/**
> - * amdgpu_bo_shadowed - check if the BO is shadowed
> - *
> - * @bo: BO to be tested.
> - *
> - * Returns:
> - * NULL if not shadowed or else return a BO pointer.
> - */
> -static inline struct amdgpu_bo *amdgpu_bo_shadowed(struct amdgpu_bo *bo)
> -{
> -	if (bo->tbo.type == ttm_bo_type_kernel)
> -		return to_amdgpu_bo_vm(bo)->shadow;
> -
> -	return NULL;
> -}
> -
>  bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
>  void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
>  
> @@ -347,9 +329,6 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
>  u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
>  void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>  			  struct amdgpu_mem_stats *stats);
> -void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
> -int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
> -			     struct dma_fence **fence);
>  uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>  					    uint32_t domain);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ad2e469548c9..3464a7a880f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -465,7 +465,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  {
>  	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>  	struct amdgpu_vm_bo_base *bo_base;
> -	struct amdgpu_bo *shadow;
>  	struct amdgpu_bo *bo;
>  	int r;
>  
> @@ -486,16 +485,10 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		spin_unlock(&vm->status_lock);
>  
>  		bo = bo_base->bo;
> -		shadow = amdgpu_bo_shadowed(bo);
>  
>  		r = validate(param, bo);
>  		if (r)
>  			return r;
> -		if (shadow) {
> -			r = validate(param, shadow);
> -			if (r)
> -				return r;
> -		}
>  
>  		if (bo->tbo.type != ttm_bo_type_kernel) {
>  			amdgpu_vm_bo_moved(bo_base);
> @@ -2129,10 +2122,6 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_vm_bo_base *bo_base;
>  
> -	/* shadow bo doesn't have bo base, its validation needs its parent */
> -	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
> -		bo = bo->parent;
> -
>  	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
>  		struct amdgpu_vm *vm = bo_base->vm;
>  
> @@ -2466,7 +2455,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	root_bo = amdgpu_bo_ref(&root->bo);
>  	r = amdgpu_bo_reserve(root_bo, true);
>  	if (r) {
> -		amdgpu_bo_unref(&root->shadow);
>  		amdgpu_bo_unref(&root_bo);
>  		goto error_free_delayed;
>  	}
> @@ -2558,11 +2546,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	vm->last_update = dma_fence_get_stub();
>  	vm->is_compute_context = true;
>  
> -	/* Free the shadow bo for compute VM */
> -	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
> -
> -	goto unreserve_bo;
> -
>  unreserve_bo:
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index e39d6e7643bf..c8e0b8cfd336 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -383,14 +383,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		return r;
>  
> -	if (vmbo->shadow) {
> -		struct amdgpu_bo *shadow = vmbo->shadow;
> -
> -		r = ttm_bo_validate(&shadow->tbo, &shadow->placement, &ctx);
> -		if (r)
> -			return r;
> -	}
> -
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>  		return -ENODEV;
>  
> @@ -448,10 +440,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			int32_t xcp_id)
>  {
>  	struct amdgpu_bo_param bp;
> -	struct amdgpu_bo *bo;
> -	struct dma_resv *resv;
>  	unsigned int num_entries;
> -	int r;
>  
>  	memset(&bp, 0, sizeof(bp));
>  
> @@ -484,42 +473,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (vm->root.bo)
>  		bp.resv = vm->root.bo->tbo.base.resv;
>  
> -	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
> -	if (r)
> -		return r;
> -
> -	bo = &(*vmbo)->bo;
> -	if (vm->is_compute_context || (adev->flags & AMD_IS_APU)) {
> -		(*vmbo)->shadow = NULL;
> -		return 0;
> -	}
> -
> -	if (!bp.resv)
> -		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
> -				      NULL));
> -	resv = bp.resv;
> -	memset(&bp, 0, sizeof(bp));
> -	bp.size = amdgpu_vm_pt_size(adev, level);
> -	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
> -	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -	bp.type = ttm_bo_type_kernel;
> -	bp.resv = bo->tbo.base.resv;
> -	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -	bp.xcp_id_plus1 = xcp_id + 1;
> -
> -	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
> -
> -	if (!resv)
> -		dma_resv_unlock(bo->tbo.base.resv);
> -
> -	if (r) {
> -		amdgpu_bo_unref(&bo);
> -		return r;
> -	}
> -
> -	amdgpu_bo_add_to_shadow_list(*vmbo);
> -
> -	return 0;
> +	return amdgpu_bo_create_vm(adev, &bp, vmbo);
>  }
>  
>  /**
> @@ -569,7 +523,6 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>  	return 0;
>  
>  error_free_pt:
> -	amdgpu_bo_unref(&pt->shadow);
>  	amdgpu_bo_unref(&pt_bo);
>  	return r;
>  }
> @@ -581,17 +534,10 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
>   */
>  static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>  {
> -	struct amdgpu_bo *shadow;
> -
>  	if (!entry->bo)
>  		return;
>  
>  	entry->bo->vm_bo = NULL;
> -	shadow = amdgpu_bo_shadowed(entry->bo);
> -	if (shadow) {
> -		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
> -		amdgpu_bo_unref(&shadow);
> -	}
>  	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>  
>  	spin_lock(&entry->vm->status_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 9b748d7058b5..390432a22ddd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -35,16 +35,7 @@
>   */
>  static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *table)
>  {
> -	int r;
> -
> -	r = amdgpu_ttm_alloc_gart(&table->bo.tbo);
> -	if (r)
> -		return r;
> -
> -	if (table->shadow)
> -		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
> -
> -	return r;
> +	return amdgpu_ttm_alloc_gart(&table->bo.tbo);
>  }
>  
>  /* Allocate a new job for @count PTE updates */
> @@ -273,17 +264,13 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  
>  		if (!p->pages_addr) {
>  			/* set page commands needed */
> -			if (vmbo->shadow)
> -				amdgpu_vm_sdma_set_ptes(p, vmbo->shadow, pe, addr,
> -							count, incr, flags);
>  			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
>  						incr, flags);
>  			return 0;
>  		}
>  
>  		/* copy commands needed */
> -		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
> -			(vmbo->shadow ? 2 : 1);
> +		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw;
>  
>  		/* for padding */
>  		ndw -= 7;
> @@ -298,8 +285,6 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
>  			pte[i] |= flags;
>  		}
>  
> -		if (vmbo->shadow)
> -			amdgpu_vm_sdma_copy_ptes(p, vmbo->shadow, pe, nptes);
>  		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
>  
>  		pe += nptes * 8;
