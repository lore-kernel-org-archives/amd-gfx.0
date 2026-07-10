Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC24C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 16:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A4C10E1FD;
	Fri, 10 Jul 2026 16:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B1m8RJFW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AC610E1FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 16:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjdBceOpSlKwqL1m0IX6TPCgyZIZsnYjPEjyM+4ENqaDuicDsL1qhbHWLjZWM1FUiFP/gow2UZ7/uSWAhfsmIAmOPI7+Y2D/ZJ7S+wIvjDO1LPPKk+IKa0rV2Rfb/c2EYGf11AZjvDzN7RjSRE57c/1xfbE7Qxx0EBrPAIF5WvyeZ+aiD6k7QLPyf8rT4DxeHz8MPnWyzuZEFInR6gCcJWHFBYxKVXmdLlrEOYtgzn++yewv/cnLxNByKVdP2lDKZCClnJKzSBiW0QYMNySt+6v2mxgloIqsOjeXtY96b4h/zYIZ1CskxEENnNWcyLYV9s2TI1TqbNIx+FPlnRosbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a85cXa0GzM3UoK+5vHSkmL69ALO/3QuQImJO/SP3PD4=;
 b=Cao/Nt1RaL68cUPbjj0ergLwzeOnbOjrTLqOyJGd3KCMTVbKnjPKMsMbW+r5897vRCGnoYMZnzMP0FY3XWkmItPRJ4BwChCXxT33G+sL3sRh5Bkg8oelEOVl2MP1PpMGuh5ctfeRuzI+SRktX5CkinrpTs19ont3YLWj5nUdZETu3+AhHsLP9Omcr5g9Kx7tJPAOfE+8LsI/vSXxMIlKoa5OcJLrq4BbBWmmNHM0MvvLe5bnNMToARO+VaJLWg9LGY3KzoK8edeyg3XAt9OigJqxFdcliTZp3yFnvZTH+6bCk80w0EPgAm56WyvMbEGYXVlLgbIPWN0AQ26j3IJAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a85cXa0GzM3UoK+5vHSkmL69ALO/3QuQImJO/SP3PD4=;
 b=B1m8RJFW4FMuMiPHc+ICAvfZTTiFhhuSzUQy0Mmh8TJ/5rnqrrVNIHcEYWXHt3QYrRHFMkBTJbpbxuoRJNowZxoPl4pFNrtNNEndV2vXfk2iDUbSQS1Nf4bsJtTjMcLrGxtynx/rLYeHGFL22ueFXsOheDgXc6nV2k5pP91NY+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 16:38:03 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 16:38:03 +0000
Message-ID: <19ea22f8-06e8-4f46-959b-b3636fd8b07a@amd.com>
Date: Fri, 10 Jul 2026 10:38:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Run FP-disabled MST stub test only
 without DC FP
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 George Zhang <george.zhang@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
References: <20260710143633.3227281-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260710143633.3227281-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:8:56::19) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: f882c815-fe4a-4321-127d-08dedea19c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MxJabTawff8cUmB60ekzPYiHtwaQfzlp7Y7mKqw3OV7QWk8+WrJfDgDALHpt1Z41FtidXiL5NWUQyTfE5J+M0it3nLQpFO7Rez3Z/jtibKKVt6MUZvt+DA18E13sEHuQfYcPJH1DbHfhR6a0UKoWSvtblIg2Saa+oPLw1tFl7/BmYrcR7Yi8kfEE83n1r3OOdkITm/Mlh8IM8H2kQ3Rvt46R5RDsIa6XVlz04PW3cu1yQA1pcqQbQXoD3tOCbwc1iGdSDKA0QqR09Zk5V1ynZGNHwP9ZF80AO93FnSbeczRIE0roMC6wa05iE9eiVwpj857VJHwKHchCD/VKLfutjhPT3XDT6j910matbmh/nG/u4ScbOvDG6kppatdHhfSA1EFkyu6GM/XgnaQ5ORSIaUA0IS+Bb2AF7Qr+ECjuqZJy8eUX1un+QGDZQNeou8ILPTyjkm7/3Nnwxloms2ogCuebiTf/YVuZOLJXjbUpksasF8MeoWRJEk0YssvKH4He7rlgZzTu6NrhfV1sXSEPy/GBGRZIc6dOZt/QE92oxkNudn2SdRnFC9UKmobpw/BcF5FTZuQbLQX7K2l1xIVrZgQpqRSpOHkCKEmYHjNfqHOXn05CB7Ozi3d15sNUguSUONR5PbB5F2yD9gjDNi/+nmh7ruwoVkXKxWK0G1CU64M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGEwTytzcVVLYWZ3aUtIMkhLUWdPd0VDbHJGeVBnNDkxSjlQZDN1TWJIb2VY?=
 =?utf-8?B?VkVzbFN1SkZUM3J0ZFM4WVNnMkVHK3pKYlFmTHQ2d0RxbjJMcW9Mdk9KR2Ny?=
 =?utf-8?B?S1MrYzl4djV3UVZSby9lWjZuZmMzZzFUUzQrclNzMk5sYXdkVUlBZDBxS3dU?=
 =?utf-8?B?WGt4MHdNaXUvWkorbW9VTjBFS0w4ZzZBY0lmcEUxUjg3Q2pFRUdkNSs0TGk3?=
 =?utf-8?B?OXZGcFpadjVBNHcxZ2ZmdFFHMWg2eDhEbkc1Rkk1WlppVWtWc0FNeHRHRVYv?=
 =?utf-8?B?RWU2Mmdzd09zQXJqeHI2aTdIK1N3KzBGNG0xclZ0TjVkYWJOUXcra2ZEN0Vm?=
 =?utf-8?B?bTJ4Zjd4VEpPeWpGRE5PV0FDa3hFTm52TkpLVGFKL3Y1VkJmVHU4NzBub2V1?=
 =?utf-8?B?aE50VHFkSUNkVlFMcmtMRzJFN0REbGF1TzE5SnpiYWZxUms2UHdWK0V5eEVF?=
 =?utf-8?B?UFh6VTRGZlpUdTNNOGRJRnJIZWNkbmRhRE40dmxUenpMQnArK0Y2S2V5U0xv?=
 =?utf-8?B?Y2RhQ2t4UkE0WjFIenA0bEtRVFFKRzdUc3BCLzUvR1RQbjVsS3NzRkFpUXNZ?=
 =?utf-8?B?WXpieFV2WkVkMzhHNlFKZWpkd3RwemdFdEdIQlpMTnZaK3VGSUhvbTBpYkRp?=
 =?utf-8?B?SWpBcGRpWmR3Q3NWZnMyTmlNV3A2T0tXc1RFTWhGRHBhWHdjNnBuN24xTVUv?=
 =?utf-8?B?ai8wd2RYY3U4L3kyRXd6UWpEV1RHUkNIenVZcHZwZHdtMGdvVFNQK2hSZldX?=
 =?utf-8?B?MUJrdnVIYkEyY2E3M0ptQkdORFZ4TFFQS0NOREU2RWpRVXhuaGFsN3BnZ0Jz?=
 =?utf-8?B?eVBMK2NUNndKR29JeS9DRmVDU1JUSmFVVlZDeUw4TnRLS0pUZTZZckdaSEJJ?=
 =?utf-8?B?VVl5bXdSdjc0M0FMQThpYWxJNzdFVjdqMExJNGZxak9qWGhGbTN5eUFua0ti?=
 =?utf-8?B?U28wWHhmMmN3ZENZMTZoRGRyTU9FYVUxVG1sMVEySm9KeGMxb09LMkZUMVBK?=
 =?utf-8?B?b2FlUHJJVjZRVEY1UU9Hc2JjT1FhRVdObGFVdm1XSWRzeFA3aXBFSDJQVUpN?=
 =?utf-8?B?S2dWSVk5SldWbDhnMXRjdWVzTXlhZ2drbklRTmVVM2k1VCtONzhBUXBWcWJN?=
 =?utf-8?B?K1RmSGgrRWJxbndpNlJzVDlaZGRLaXJwZWxGZDBMQUl6NDI2SDU5S01FWDBG?=
 =?utf-8?B?NjVSTWpiSFVsSm1ZTFI2azkvamdqTk1Yc0xmL1FsSm5SczlncmZFeUdsSmRh?=
 =?utf-8?B?QzBpYUhOWUc2SkV0UVk1QkNrZ2FqbzlKWWV6TnZiSEZDbGs0KzlxSWJuUFhn?=
 =?utf-8?B?ajh1d2R2bEhGakhxc0d1SHNZdGszS0FUY24vVHpXVXRUOHg4R3ViaFlFbHF2?=
 =?utf-8?B?bnN3NVRFcTBMSjc1RFA3Sm9FOHd4M1pkdDFKMTN6Y0Myd0tnam5YR2JJN09v?=
 =?utf-8?B?NU94UmhGMEIxbHd6Y1RxK0UwTzBmRkRxQU44TFQ5ZlRNVUtmVFZPR21OQmtF?=
 =?utf-8?B?bHBQUndtTU5GVGZMN3h1QkU4SktNanJhcHpyWG9pSUlJVHdhSG5Cckd2WkdT?=
 =?utf-8?B?SEY3R0ZNRlg1T2ZwRjVuODJHcVFUNHRXbjU3bGhKam5DRzNIMUwzZi9LNWxh?=
 =?utf-8?B?RXNuU0VGSjczL0VUZTNSZ1oveXhYSDRGa1hCeDh5eitwRmNqai9aWkEwNzBi?=
 =?utf-8?B?MVBXeDdCYTlVcjg4WnRkbDFWcUFRdFVHbG9zeFQ0WlZiTm1RWUJKN1FmVlpy?=
 =?utf-8?B?NnYyU1ZlK2pRWnREcmlMblN5Qll5ZEJmUjJYaTFmbDA0djNIdDIrMWRuU2s4?=
 =?utf-8?B?ZU1DS2hhUDVpVEJIZjRndXFuSHJRS1hJZkpwYy91RUZ3TGRTY2hLQ2xQeU10?=
 =?utf-8?B?RVh3bWJPQ0pVaWpZODQwY0o3VTQyWTlWWkFCTnFKeXd6WEgrSTFaaVBlcHRp?=
 =?utf-8?B?NFZVdmR5Tm0rTkhIWXZtWmV2c3ROaVF2M2k3NTVxaGM0UndhSzVHZnJzR2pl?=
 =?utf-8?B?MWJLUERsekpTNXAxNTVFcTl0Q0FHdWNyU1h2RUgrSWtXN2dzMURXcXQzSGFC?=
 =?utf-8?B?NGFBRUsvYmxnN2JnSWJmcHBzcHVQbEUrZFRnSG5PNzdEalNMWWx2WVFSTVB4?=
 =?utf-8?B?dXV4K2RHYm14ZU9OcXZLbm4zZ3VEUVFLQW4zWFZhWVlTZEdrVWdCck5GK2dr?=
 =?utf-8?B?VVBIbGZLSWRMTXJGMDAxSzV3c2QvdnNBb0pzc09mV3hYMHo0eHpvcVQzd0pz?=
 =?utf-8?B?c2hRcFVwVEJTUEJKK2QycHNpcVVmZ1ExS2ZVWmhwQTBBMWU1aHZBQTJkWEFi?=
 =?utf-8?Q?e5M5YyZ40h0jKwpRVL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f882c815-fe4a-4321-127d-08dedea19c93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:38:03.2772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1kDoIno3FQrkn0SMaqeHQ/dX5suB6lvAhyL3pzcg3LpjahrmWkZtgnJpoLPPWUFiUZ6oqKuulM736RmD1lm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 7/10/26 08:36, Srinivasan Shanmugam wrote:
> dm_mst_test_fp_guarded_public_stubs() passes NULL arguments to
> dm_dp_mst_is_port_support_mode() to test the stub implementation when
> CONFIG_DRM_AMD_DC_FP is disabled.
> 
> However, this test is always registered. When CONFIG_DRM_AMD_DC_FP is
> enabled, the real implementation is used instead of the stub. The real
> implementation expects valid pointers, so passing NULL can lead to a
> NULL pointer dereference.
> 
> Register this test only when CONFIG_DRM_AMD_DC_FP is disabled.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c    | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
> index 3f591e3914d9..666fd2ad903e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
> @@ -1015,6 +1015,7 @@ static void dm_mst_test_detect_unregistered(struct kunit *test)
>   			(int)connector_status_disconnected);
>   }
>   
> +#if !defined(CONFIG_DRM_AMD_DC_FP)
>   /**
>    * dm_mst_test_fp_guarded_public_stubs - Test FP-off public fallbacks
>    * @test: KUnit test context
> @@ -1027,6 +1028,7 @@ static void dm_mst_test_fp_guarded_public_stubs(struct kunit *test)
>   	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(NULL, NULL),
>   			(enum dc_status)DC_OK);
>   }
> +#endif
>   
>   static struct kunit_case dm_mst_types_test_cases[] = {
>   	/* needs_dsc_aux_workaround tests */
> @@ -1077,7 +1079,9 @@ static struct kunit_case dm_mst_types_test_cases[] = {
>   	/* dm_dp_mst_detect tests */
>   	KUNIT_CASE(dm_mst_test_detect_unregistered),
>   	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
> +#if !defined(CONFIG_DRM_AMD_DC_FP)
>   	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
> +#endif
>   	{}
>   };
>   

