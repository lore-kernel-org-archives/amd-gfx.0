Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E518606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sNyg72xJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B970510E5B0;
	Fri, 23 Oct 2026 09:22:20 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CE610E5B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGk5LYIhtbD0RCAX0dd3vkhgx28fM3EtPovbT4587RmFsuL2+utVP7ihXNaAaMDzNhEWPH1xkXBcp/WfyKf4qUHZnmz+fkbi81mx4gZOMjhyNyn1B/8WlivCef+zjtYZe7pwDjDqRirJrFsqguxuO0h45UG/77xULyugjCQdpCt6VeOeJ40v9DBOy2T7hMRUTBiuz7uIJI66WCBz/AvHvab5PkwJIA54886zMRAyMwXhVOupTuiVTozTefblHlVa7uj6+DplgblLvOtJiQBSOlH96B5JISrRYfkOG6pMM637Oy6uIPUhaimXQRa2oFiJgb6hFnZ3b8CzJr+3ia0KYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YRP3Hl47DLhPNHfabqjbT+uurz1FmOqCJPx/zLp2kI=;
 b=sWr28gM5MJzhqcnAZ+VSiFcY2ZNbUpfIp+xxpDq/wbPvGw4zaqME4i//xyqQZezFokWkzhd+5FOLI5m1vsZmiAcknbVhnZ2I5WgyZftRY40mwSN5GpWmUaV478388+ejWWxeVNXBUNviIxWNCNk6RcEFSfvjXyf6UrlxDRp2o6fCDGKPjTjJtVY3AN+hqH37r+VTC1Oe889qSTcDqbVHjX/Ep2rokgsJ1u4txD8Z3AquH62j2D+iZRvY28NXslaErt2BpG5kiF2Jg7DGdb1pyW8EGuqvg1IUE+MMdFMNt12OJ+Y5NjtPzeDa3qPY1kmixU3sTsWvVECreOU1ztPa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YRP3Hl47DLhPNHfabqjbT+uurz1FmOqCJPx/zLp2kI=;
 b=sNyg72xJD03HzHhpVRpG+m/lSu7EFhPw4LxIxR+zzSAVLQd0VBJ77Dj1ytTH7QZSvxWllN9pFCL+H+F7MTGTHgQXEdsWUInSn9knLYKlVSSkkLsdI2FpVdt2Y3y9Y4yrV5k4ns14q8hI+Un/vQTGq0ltuEgDzpHOPgZy5x8BFkQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:22:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 09:22:10 +0000
Message-ID: <03452daa-204a-40a0-98a8-0a34861dac2f@amd.com>
Date: Fri, 23 Oct 2026 14:52:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Vitaly.Prosyak@amd.com
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-5-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261023083422.3049246-5-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdf19a4-5402-4cf1-3f47-08df30e71db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|261022105027099003|3023799007|261022075727099003|11063799006|4143699003|5023799004|261009221227099003|261009223027099003|261009220027099003|261009221727099003|261021123027099003|10067099003|261021121427099003|261009223327099003|260925021911599003|260925022911599003|260925021311599003|56012099006;
X-Microsoft-Antispam-Message-Info: OukrhRXGbyFAM7H74BIbo0yqQH2qwHyoUk8jpRgJKmL5F5KFAhHMWgZMhzhDFfU1CVGQbLTZm1qojR076cK/0cpwTGBn+RouUEq/hefIl1xTzRdLLvODLDw/JM728RpQNOYUtcDO7YxrLN/QWw0m8W9uEMbebCBxp7gbWhmRCwSBlC26R6INOx1mWVLSF1nnviYwERbt1CVwWRiwfPpUoyPFn6ukAMUzqAQnSbwzfTCW0DwYvyFFYbZKqPDuHy/G2lJbiMHCrYhg1eCYn179tw/fLYFPArLONCQo42MvFX4rPmPjlIzEXCAVhCEazUSlri/RdnMiBFPgDVO0m7kSyjSKapl+eFRyeNbxtpo28fCSz16rVM5sPzpGsCi1EP8KWcLBNWRaA3EA2SSrYk4iKDhV62HI24L4qfglL3oxIsfiq73gHEap9oYbB0TdSDflEE79pzzljg42TCTsLgaZDvaZA8FRe27MbSNoaHzGgQC0sH23FRyqOhhn2Le/saOil266pBgMPQ5+k5N273KIKBgdPBe6XEOESEQkuswvtwZCnscVtm4oHlNVmtR2cjSbw74Yc7kfu7AV6O0227UofbonNTk1Iyelg5TlUvrOFIA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(261022105027099003)(3023799007)(261022075727099003)(11063799006)(4143699003)(5023799004)(261009221227099003)(261009223027099003)(261009220027099003)(261009221727099003)(261021123027099003)(10067099003)(261021121427099003)(261009223327099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmdFWUNFVldMOXBOYXZKWjQ4MkRlaWdFSS82MnZRalpVVUtNVUxaMW43cHVp?=
 =?utf-8?B?WEJqczZtajlYa09CSW1DcWE2STZoa1E2b3o1NjBaVU81QThlQVFuMjdvdW9z?=
 =?utf-8?B?cTk2Sm02QVI1UXBVQ2xsY0NaUTE1eU82YWM5RTNCeDhqZjd3STNTYlhDRFM3?=
 =?utf-8?B?RmJvK2c2YlZyNk95YzBLeHgvQnJvY1ZqSisxZ1dBNHIvdjgzaGN2TW1nZzlz?=
 =?utf-8?B?d2RtYncxa1VyQ2hNT25ndWI4czNCZkRQNzgyWTZ3azVxemhBNG45bGd2Y1g0?=
 =?utf-8?B?aC91Y2syMTgwZGQyamNTV1BtbVhsSlB3SmZTbHZhTi9ENHpxNjZraGxQZFNx?=
 =?utf-8?B?STRtT2xjd3RIMFdJZ1FmRS9HZm12TjR4VUZwY0N6OGw5K2dnOEdSVndXb1dX?=
 =?utf-8?B?NkNkM3BBdnlsZnlYd3dSRkkvZU1MdFJsT2hWajZ4YlpYVmg1UUpPaDdLekZ5?=
 =?utf-8?B?bXhVSXU4R0RhMG9LbW9CTlQ0Nng5Rm5sYXEwOVRQWE80ajJjVnZBREN4eXlv?=
 =?utf-8?B?b2t6NTk3UHdjdnNFMHJmSTZaTFZUUU1Yd2FQTUh6c05mVVJZdUpFRjFJem5T?=
 =?utf-8?B?NGpjMkRMS00yMndFOWZ1OC9hdUp6cGdyVW9oWEUvL2dCU0IrdFM2aU5KQ0lF?=
 =?utf-8?B?cnFFd1VrWUhVUzQwQzVld0lEZG5tTGZuNVdUSmVXYjI2Ni9ReTZwMWY1RzBw?=
 =?utf-8?B?MjZKczMzaWZoOFYvR29qSWlVVGZZMDNKeFVEb09BVmxjclROMmhEVi9RaGFM?=
 =?utf-8?B?c2RHdzFCQzh6NmxRd2wwaVFYcWYzbVM2TkIrcHJXd0Z6NHJkSVdtdjR4TFQ5?=
 =?utf-8?B?QTBzOXJrSmdLa1pDTmVHUHl2YUwxQm1MaTdrRVFhUWtTcFhGWjdtS2JBeDQ1?=
 =?utf-8?B?bkV3MHc1TnhFa3lHWktrQkpaalZXTktJaERIbFlYeDZrU2tyVFA1aHh0dUFp?=
 =?utf-8?B?ZUJyMUFkbFBtbUkxMnFyTkFtTXpMcTMxMTZ3UnRjR0F4c3JNTWxQRDNDUm9R?=
 =?utf-8?B?NHI1NXM2TFZ2SDNGZDl6cjF2TTMrbUpBUHYvQTd5SU9PSmRPaHl5UERTOGZF?=
 =?utf-8?B?ZG5PYTRpWTEzZ1lTcUtTeWV4WnZqQjVMbjIxdmtQazJYWlh5b2VUNDVySTIx?=
 =?utf-8?B?UFdRTjlnU21aMnBEcEYrR2tQR1ZSKzRkcmw2RmJMdUxOdFFhUVpZbEUrSHZM?=
 =?utf-8?B?NDMyZWVwSnVzSmFhRzFobWd2YlFoQ1R3WEt2QmJpR1BxRWQrVEJhVGIyK2cz?=
 =?utf-8?B?ZDJ4SEFZaVB0Mi9uanhHS2Z2ZWgvOE1PbzVuZDNIUGZxbU1jYW5hb3BNMGdM?=
 =?utf-8?B?bU4zWmh6TVZDREFDKzBtVTFPQlNjd01rcE9LT2VZNXNJM2F2MXd5azJDOEtK?=
 =?utf-8?B?ZFVscFhpWWxmU2dmckV1Z3B1MThHTzMrazNROURLdzhVSUFxOFQrV1lHMzV2?=
 =?utf-8?B?UnArQUxkRXZ4NStSSTNQMklmbVgzWFh0clNKVzQ3NGZPM0s0UjRPRXAvejdu?=
 =?utf-8?B?MEVhTE8rbndraTVTMDBkMG44VUJOdm5xTi9KOEFwV2M4OXRkbFlKZVNFTTBJ?=
 =?utf-8?B?QWhMYlMxeXZDVFJVQ21nOVZteWlPNzlHYVo2aEVlR2FKdW9aZFpxT2NPYW10?=
 =?utf-8?B?NkgveDVRbXlyK0lacG9GTDhpNHdueDY1ckZmbldTbzRRNjFnTTlvaklNOVRw?=
 =?utf-8?B?VmlkWXdFc0VKWXBHQ3JCREpCZmFmbFF3eGo3SGNZNlpNcU1zOTdqVmtlcWVx?=
 =?utf-8?B?RGs5TkQ2emNQazdNclJxOVV4K0RYblUxWFNKTHNXWEN0dW9RcGtqdlBxREJa?=
 =?utf-8?B?V09tMTdFbHdreGpzVG5ZZ2Z1clZ2NXMzdzc3Z1UzS3pCaTBzTW1ZeisrTVJx?=
 =?utf-8?B?VHJ2Y00wS2MvL3l2ZkE5V0REc1d1UnNuOFArcGx1bVczNGRRcnhLdU5zUlRF?=
 =?utf-8?B?T1NQWi90eWNCZStlaUtxaWJidTNuK0FUM1hHZnVTbnVnTUg4UWFHV2QrdmND?=
 =?utf-8?B?dkVNdnBOeUM3TWVZL0RsMlZpU0JRNmdmaE9yYk5TMDJ1NmJJSXY2Uys1Wkh3?=
 =?utf-8?B?K1QvOVd0WHI4NjFpRjJ1bjhHZ2xKZklITTVJMU9xV2FvUFNFaUNVdGRBek15?=
 =?utf-8?B?MkRaa0kyemV5UUQ3U1FJNkZ3Q0Y2Zkt5TkNKWXU1U1EzeHpVUW13Q1JPTVVU?=
 =?utf-8?B?R1JhWi9lV2UzbjBhZTZ1cHhzYlpCazlhT3FkdU4zb2xsRmNUSG1VR1pXOTFQ?=
 =?utf-8?B?VTBIMU1hVWsyMG1HVHJCbXpuOFdDakI4TDJPUE50YTVrN3VJQkJSV2wwc2lH?=
 =?utf-8?Q?KGonSWwN3QilrqqMzs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdf19a4-5402-4cf1-3f47-08df30e71db7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:22:10.5298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtjW0ZZoAst8ntUE2HC+s38F4tQfGr6zdtebMmWx5iwgQ5byeNKQ7OCTLHw692CG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 23-Oct-26 2:04 PM, Prike Liang wrote:
> The common JPEG and VCN idle workers program power gating and DPG pause,
> so they must not run while a GPU reset is in progress. Recovery must not
> wait for them either, since everything the workers depend on then
> becomes a dependency of GPU recovery.
> 
> Make the workers take reset_domain->sem for read, so they wait for a
> running reset instead of touching the hardware. hw_fini/suspend and
> begin_use, the latter for the IB tests, run from GPU recovery as well,
> so only skip waiting for the idle work when the reset itself calls them.
> The reset holds the semaphore for write and would otherwise deadlock on
> a worker blocked on it. Outside a reset the cancel stays synchronous as
> before. sw_fini always cancels synchronously, it never runs with the
> reset semaphore held.
> 
> Update versions: https://lore.kernel.org/amd-gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
> PH7PR12MB6000.namprd12.prod.outlook.com/
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 20 ++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 18 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
>   23 files changed, 58 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 87f879a2e4f4..2bddef322870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>   {
>   	int i, j;
>   
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1U << i))
>   			continue;
> @@ -95,9 +97,18 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev)
> +{
> +	/* The reset mustn't wait for the idle work, which waits for the reset */
> +	if (amdgpu_in_reset(adev))
> +		cancel_delayed_work(&adev->jpeg.idle_work);
> +	else
> +		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +}
> +
>   int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
>   {
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_cancel_idle_work(adev);
>   
>   	return 0;
>   }
> @@ -114,6 +125,9 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   	unsigned int fences = 0;
>   	unsigned int i, j;
>   
> +	/* Nothing holding the reset semaphore waits for this work */
> +	down_read(&adev->reset_domain->sem);
> +
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1U << i))
>   			continue;
> @@ -129,6 +143,8 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>   		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>   	} else
>   		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> @@ -136,7 +152,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   
>   	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> -		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +		amdgpu_jpeg_cancel_idle_work(adev);
>   
>   	mutex_lock(&adev->jpeg.jpeg_pg_lock);
>   	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea..631f9471be1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return;
>   
> +	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>   	amdgpu_bo_free_kernel(
>   		&adev->vcn.inst[i].dpg_sram_bo,
>   		&adev->vcn.inst[i].dpg_sram_gpu_addr,
> @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
>   	mutex_unlock(&adev->vcn.workload_profile_mutex);
>   }
>   
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
> +{
> +	/* The reset mustn't wait for the idle work, which waits for the reset */
> +	if (amdgpu_in_reset(vcn_inst->adev))
> +		cancel_delayed_work(&vcn_inst->idle_work);
> +	else
> +		cancel_delayed_work_sync(&vcn_inst->idle_work);
> +}
> +
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   {
>   	struct amdgpu_vcn_inst *vcn_inst =
> @@ -470,6 +481,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	if (adev->vcn.harvest_config & (1 << i))
>   		return;
>   
> +	/* Nothing holding the reset semaphore waits for this work */
> +	down_read(&adev->reset_domain->sem);
> +
>   	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>   		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>   
> @@ -499,6 +513,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   	} else {
>   		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>   	}
> +
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> @@ -507,7 +523,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
>   
>   	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> -		cancel_delayed_work_sync(&vcn_inst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vcn_inst);
>   
>   	mutex_lock(&vcn_inst->vcn_pg_lock);
>   	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bea95307fd42..a6438950854e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
>   int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
>   void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
>   
>   bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
>   				enum vcn_ring_type type, uint32_t vcn_instance);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..b048fd4b8b59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..f6a9258ae3ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..922711aa06a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..fe7ab9cb35bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..f4896ad9d1de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..87efc3c2b9e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..91968ad26f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..27116d1e9e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..7e068c2d4d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (!amdgpu_sriov_vf(adev)) {
>   		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..16daeb61114c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>   
>   	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>   	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 76793a5caa70..470d8f110799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	/* Override the work func */
> -	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
> +	/* Own lockdep class, this work is still cancelled synchronously */
> +	INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work, vcn_v1_0_idle_work_handler);
>   
>   	amdgpu_vcn_setup_ucode(adev, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..ba451f2a2534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>   
> -	cancel_delayed_work_sync(&vinst->idle_work);
> +	amdgpu_vcn_cancel_idle_work(vinst);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   	    (vinst->cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..9dd4c313cbe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   
> -		/* Override the work func */
> -		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
> +		/* Own lockdep class, this work is still cancelled synchronously */
> +		INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work, vcn_v2_5_idle_work_handler);
>   
>   		amdgpu_vcn_setup_ucode(adev, j);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..3e85abd1e82c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..5b47a643d725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..5aa09c3bd79b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (vinst->cur_state != AMD_PG_STATE_GATE)
>   			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..9693950cd16d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..0c189063a6ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_cancel_idle_work(vinst);
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..3fa553fb41d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>   		if (vinst->cur_state != AMD_PG_STATE_GATE)
>   			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..eb13f792e25d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>   		if (vinst->cur_state != AMD_PG_STATE_GATE)
>   			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>   	}

