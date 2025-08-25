Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B85FCA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0843210E4E1;
	Mon, 25 Aug 2025 14:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ile3A6HR";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A590A10E4E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7H5rgSny17Q7vW6fs+2Lh9CHsUpXUSU5bFXzh3Hotd9qqfPiCfAq/Wa3CtNLe4qN/HP3YT+vwqCCf2LT1kgLcgnPa8E2a+pUGeImGVuLfLCTyOrPtPzTP+fVTOWhmYkGezEk+aSP3rBVKaAI9YfjoWktNC6jrU1mmt849DXVnSvxy9jzjNmaQtlhJ/+/MvztjacSyDUVam4meMhcEh0wa2qIZwfYDbge/SnCljRZj1PCRaGrd0NC0q46kvbAK5zHI6LuTx6urgFivFLSoTtMrV24bY+S3qd3vnMbfN+Vtf2f7oJopOBjePegtI7RFLZ962wTynx6OfeYH0zRiP4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enAkh0l1iiCKhJjmi9eBpcqTtjvstAnMnFQEm4c2bIQ=;
 b=C27PeopNlDiMImzO/8EKrmvvUlXoXwxVbISIYmIqYav3OG5XFP9d/0J23miVErMKdYPsefLRz8KqCBQ8v0V07fa+2AG2xbKh12CVR2PfTsNwiXkgI9vkX6uzI/BGEc0+UfuHyJLjFE8p1g3Q/f0j3Og+ahKSeY+RkZiKahzjIgr2ql7LSO3KnHeHFuX3dZismPYEcCMpYrq78V65xXU0sxRai2Nv56TcADnlosPAMqwklbTIC9oLmdtA7g53AT7vc/3YethvW1UrF5oXXVCYDS06HkhaAq5SwcBTw+x5zhee7v+D25PEyA+/G8hs74A0GCZkxvF7obZwmMRu75DAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enAkh0l1iiCKhJjmi9eBpcqTtjvstAnMnFQEm4c2bIQ=;
 b=Ile3A6HRGwVK/JmPSSOmSrQpBO5tKBCKOibV7qEfbgXRsd3uKnHohbYABnjvqg/kUESF5hRr2+hW1Np3NYWcVTM9f1Tdwf6ij4OyYDsURX6VnWINnu2tzTZIw325/CB/soFi1ZmO+ufcaJKs53Er1MTjBQf/gjxyO6Fzr/IDMJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 25 Aug
 2025 14:57:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:57:35 +0000
Message-ID: <416efc37-9c2b-4b2d-a58a-136536dd1f9f@amd.com>
Date: Mon, 25 Aug 2025 16:57:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] drm/amdgpu: Return Handle to MMIO_REMAP Singleton
 for GEM Create
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-8-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250820113254.3864753-8-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:208:e8::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6f34a5-f760-45b5-cd64-08dde3e7ba06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3dEd2JMNWdPN24rMzh4VFBSR3dPdmZ3alA2TkFpcnZhbm9SL2pId0lhcjJN?=
 =?utf-8?B?cFB3dTZacG5QUkFXNW1FNnVEWUszcDk1TS9rNnkwa05tVXJWdy9nbjBJVUxQ?=
 =?utf-8?B?UTFucVN0ZkF5MkMyVXhub21mci92WXhMc0pFc0pSMnJjSjNHUUxEcEQ4MERn?=
 =?utf-8?B?R2Ntb2lyN01CNk5CVDMwNWYwU3czOFNZdFBCZ29qcWRkZC9va2drTmpWOTZW?=
 =?utf-8?B?cFVzMnRMNWNYYStGd1M0UzNMOWVHaGFCdmx4MU05Yzkzd2Y5WXlOWVliQVRQ?=
 =?utf-8?B?bTJza290UlVPc2F0SWFvWVdzUXhSeFdQTjNXWDltOEJ0QWhxVjVpZnJvaVN1?=
 =?utf-8?B?WGRCejg1TWtLTTlIMFdvNlNkS0RheDZJREU3SlUrWkxVeWFpOFNzSFQ1cm9a?=
 =?utf-8?B?YzU1WGZKV1pvQnF2Y1dzazBFTkd0bzU3RGdiUHZOVjRmaVZidFNXbHE0bmpH?=
 =?utf-8?B?eXhqeWFneHBiRGY2TzRFU2hLdEE0STNXSWowWk1aWisxcXJsS2tQZ0plOFRp?=
 =?utf-8?B?MElzcC9xWjg2L3k4RGNPWUt1SncxTXpYb0w5SU92eDM1VkhpbXB5TVorbC9i?=
 =?utf-8?B?ejE2Z1M5VTJlbHV5VUhBTjdab25NZzhGR0VFaEdJVEpNSS9aRGVZWHZibDdX?=
 =?utf-8?B?clRCWnJZY2VRakhzRlhhMlFWektsMURNY3pJdGxUNVJ5VlRZc3luY3lIRmZN?=
 =?utf-8?B?Qk5LZitXL3lJc1g0LzlEVi92YUt1R3FHSGQyQkpMSGlGOUNwbE9NcVNPZGNB?=
 =?utf-8?B?Z3VqREZMai9ZazR4YVB6SkNWWUZHdytBdTZRSGRjVkxzR0diQjFHTVp1UjZM?=
 =?utf-8?B?QzZxODcybytpYnhvNjFhSnYwQTBOU1BhSFlNd0NTWXdHbmhiQUloWkk1UEpw?=
 =?utf-8?B?dDY5ME9sREw5WFl5NjR0KzFLb1BXTGRyTnFreFJlYzdhMVpKcTF2Q3ZTUEdn?=
 =?utf-8?B?VG1OUVhKVm5KWlJ1dmFTVSswc1JDV0c1R3k4bk1sVkxFak1Tc3dJcW44K0JO?=
 =?utf-8?B?OXp6WFV1ZFV6bTkrbUN2M2FxR1g3QWlsUWNpZy9oSlFtMEsvTkFNRFFWTjBT?=
 =?utf-8?B?MXBralBGVW9WMkFFVGhxWld4SGdIbFFIQ2Y2WmVvNXQ4bGh3RkdjV2w4a0xt?=
 =?utf-8?B?a3JSVzM1UVVhbVFYcjZkc2hTaVc3WldrNEg1WXVzMTV5V1dsdW5vN1phSWov?=
 =?utf-8?B?blZKYmJPVmVSRlk0bGg1L01wOGVDdjIvR1ovaXlIZXZpQWhyMDBVUXZySktv?=
 =?utf-8?B?Q2xVZlR3NngzeEl3WDFMblM1RkZlMEY4YnNkTko1L2N0elFpakpONFNDUXRh?=
 =?utf-8?B?ZitsT2NydDhvS0wxdm9YZTFBbDBiRkdmdlFKbUpERDkxMVpUWkRWZTR1cGlu?=
 =?utf-8?B?OW5lUlhJSG1uV3gzYWVjbVRvS3pVU0JFOEF2Q2RxQXZoTkhUYmxZRWFOYXZK?=
 =?utf-8?B?MzVYdnJsZlkrWjJUcC9sdjFOTWFQWkViRVBrNW1oblpVOExNTDVUdTF3aUgr?=
 =?utf-8?B?cDg5MEo3MGpzWEl4S1V2c3I2RlZ6bjNoNytzWkdMTzBYZFlxQ0VuVUEyWWNI?=
 =?utf-8?B?M0dUUFVPcUJPQ3ZaWktNK0JLaEYxQm0wZldteVdHYkdCTzVhQ0hQMTFJUnFQ?=
 =?utf-8?B?UTdCbmZkK0tpV0IrNHhwN1hlQUExQ2R0K0paelVsTFBNang3VTB5cGliYkp5?=
 =?utf-8?B?NGJmbnhld3c0ZytLNnVvdUJnRU1INkxrVUlCV3JWb2pHSDl2aUNmZ0Y0T0sw?=
 =?utf-8?B?VDlRbENuZXhvZkdLcGlWZ0U0amFGbkN5OGJZNW1XSmRubzU2aGNVYk5ZUC9H?=
 =?utf-8?B?YVpHU2Z0RW9IYitUM21iNlVYRU40L0IzaVh2SzNCL2swTkpkMTAyZE83bzRz?=
 =?utf-8?B?RlV3T015SWtxM0lzUjkrL1JTbnFKK2xlLzVFb0JtSFgvSXY0N3dOd1BaSnhC?=
 =?utf-8?Q?3lVpLIMbb7M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJWYkx6ZklnSXNOdk15UDFpZ0tibVczdVVWU05IUm9jVnVCbVp6aDZEZWx1?=
 =?utf-8?B?RWlZU3cyUWcvd2c4UU0xVm5pR21BbTlBb09aV0lkZ0FjY285aEtpa1dHanVY?=
 =?utf-8?B?NXFRdnE2OXR1MCtXM0hCL1ZhL1NzeFRqa3JxN01sZFVtYVNYRGtab1laemgy?=
 =?utf-8?B?OFRTRjh2Z21zNlNXZkx3OGplN3dhZXVNYnFYVGp4aHUzaDI1c3pvUURVaDJ0?=
 =?utf-8?B?WVZCdWFPODFJQlJWK0JNanhJSVdBN1QwbUtJU21MZ0ZEdWhCbFIzM1ZIaXBo?=
 =?utf-8?B?N2p3ZWl1Q1diLzEwTVBtbnNFZGJ4MEthSldlVU9aWHZQS3haRnRKUW5ldGg1?=
 =?utf-8?B?d3oxR3JwVUc0d2c2RitiUjNkMnBjYVJhbmFnUnIyMXBEUGVqUnJ5cytjYlRC?=
 =?utf-8?B?ekRwMEZ1Z09FRG9RZklpZmRyVlN0OWlRYTMyK1F5ZndtalJ6MUtneDFNZXlq?=
 =?utf-8?B?cXV2Qllzdy9zWDJsaXJERjBJVHZ5cUViZUhkbEY3akZJN090bnI5cUd5SVBT?=
 =?utf-8?B?UFBLOXd6a2p3ZFZGcmdoMm9zL2JYRkJQTnZ4ZG1LWEZIU3Vzc290SERndE9B?=
 =?utf-8?B?ZmI2WDZ1STM1YXd4WkQ4WEE3YzVBdnRWM2Y4bWZUVnNERVQyNWpiTDg1UXZw?=
 =?utf-8?B?SjgvQW5Vd0FNS09QU1NoR0IvMnZ4L3ZNYlA1YjlLZXZSaFQwM0xxamtrQW1o?=
 =?utf-8?B?b2lUbmN6UnZzRm15N2w1eWpDZjh3eUlzRHZBMXhma2k5alg1eS84M0czMmMr?=
 =?utf-8?B?Q3Y3TC9SWUR2KzIrUjRPN05MWWkrSmliUkVRSE5NTHh0NUtWT2h6V2djMzBz?=
 =?utf-8?B?dG5udms4YmNnVFBNdVJnV2VnOWNzT3ZTbnY1SGcvcTFiV3AxYkx3K1ppZkxX?=
 =?utf-8?B?SzZqYW1oQ1k5NzNha2J5ZVp4a2dHclJyNmVaRGVMSStjdEJ3dml0MkFsQndT?=
 =?utf-8?B?Tld6Q21wSnpDR0NGSW12SE14UGNZV1REcElHc3dMUFphQTZVMGkxaE5mSUNX?=
 =?utf-8?B?VlB5ZUw5Z0NEZ05BU0ZYQWJtVkNYMUk1VVdBR3JjK0JsKytSek1ZME45bUtT?=
 =?utf-8?B?dW0rUCtqTDJHVWtZbS9aRWl2d0VmWnA5NExMekVEd2xMZWxtVjljdXVkR3M5?=
 =?utf-8?B?WnFBRjhjazduT0hmSlV6Y1ZiOTh3NUlRNW9xVXU1Q2N3M1lYQlpaZldkQW9r?=
 =?utf-8?B?aTU4a01Edm83VTBtb0g3MFg0emhQK0lubG5HMVpwTkorV1BlMGg1SW1Gd2pS?=
 =?utf-8?B?Nk1INmVaNW9ib3RKMDhKRHYyZ2VVdlNpUU5LOUFvS3BZcUZqaThVVTF2cHF3?=
 =?utf-8?B?UTVjT2FsMlNXaHM4NlNkcDF1a2NXcnVtcGp1WmhQNHFUZ0NLeElvT2REbGpG?=
 =?utf-8?B?UmNBMmlxYUlxVGwvMUcvc3cybHpVUWFDTTUyRVo0OEU2NzM0L212NTBWSTZz?=
 =?utf-8?B?YWpCRzZXSkVoVFVBQnA3RGhCMjYvQk5UaGpMYzIxdGVyWXdwUitXSjIrYnRL?=
 =?utf-8?B?MFB5ZWVDODNZNDExODQ5a2w0TE4wZExsSWV5T2hIREtmNjB6ZERHV01QZkw2?=
 =?utf-8?B?dy96NWZPMEZOQ0Raa1lyL0pJM2pTMEovRDM2MGZqUDlxQnhMVTdVOW1Cc3Fs?=
 =?utf-8?B?N3c0Rm0zSXFwd2JKV2c1ek9KcEZNdFRrTUFMOWxLc3p1TGV0d0NwZkJ2b3lx?=
 =?utf-8?B?enRUZ1paRGw2R3pyQ3NXeVU4clp4RnkwZXg1OUExTWJ1MHR4UTRTSlNUaGVX?=
 =?utf-8?B?L3V6UUtwd2ZoZmxPV3VQMjV1VkZJMVJsMnFwNC8rYkd6T2JRdWF5bUcxcGZZ?=
 =?utf-8?B?ZHpBOHQ4OE9YbDdRalpFQnNLdFl2UXZoUlVtL0U4dkNIQjlaMko0eVFHSW1O?=
 =?utf-8?B?L0w1dkFJWGxvUmZrUkxNa2w2S3BkNC90RlhYZGU3MVUyM0VpRi9ZTlQwenNn?=
 =?utf-8?B?aFlXUTVweS91eTdTRzlPUzl6REs5QVJ3eDVBWEs5cWN4UWFpYmU5aEQzbmdQ?=
 =?utf-8?B?SFdUWGhjZjlJNWZEdjgxVDh5cjMxY0xQV2dReURBeTJxOG5SVThjVkQwSWNo?=
 =?utf-8?B?SjdBN2FienVBMmIxMTZJbFYza3FKQWJBWkQwak9KVHVPYzBnVFJHMEFSL0ti?=
 =?utf-8?Q?wD7QQCid8cbv9GT+H9VuLZY5c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6f34a5-f760-45b5-cd64-08dde3e7ba06
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:57:35.6926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqGZAlUMWt0FAuBKNmk3y4RGLJe/gnY5S9ZbQL0/lWRa17f5UyTYBtB2wi6CswlA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
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

On 20.08.25 13:32, Srinivasan Shanmugam wrote:
> When userspace requests a GEM in AMDGPU_GEM_DOMAIN_MMIO_REMAP, return a
> handle to the kernel-owned singleton BO instead of allocating a new one.
> 
> Validate inputs (exact PAGE_SIZE, alignment PAGE_SIZE, no extra flags)
> and zero the ioctl out-struct on success for a clean echo.
> 
> This puts the userspace-visible behavior last, after all internal kernel
> plumbing and initialization are in place.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 56 +++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index e3f65977eeee..1345e81214e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -424,6 +424,26 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.vm_ops = &amdgpu_gem_vm_ops,
>  };
>  
> +/* ========= MMIO remap (HDP flush) GEM handle helper ========= */
> +static int amdgpu_gem_get_mmio_remap_handle(struct drm_file *file_priv,
> +					    struct amdgpu_device *adev,
> +					    u32 *handle)
> +{
> +	struct amdgpu_bo *bo = adev->mmio_remap_bo;
> +	struct drm_gem_object *gobj;
> +	int r;
> +
> +	if (!bo)
> +		return -ENODEV;
> +
> +	/* Take a temporary ref; the handle creation will hold its own ref. */
> +	bo = amdgpu_bo_ref(bo);

That is superflous, you can just call drm_gem_handle_create().

> +	gobj = &bo->tbo.base;
> +	r = drm_gem_handle_create(file_priv, gobj, handle);
> +	amdgpu_bo_unref(&bo);  /* drops our temporary ref */
> +	return r;
> +}
> +
>  /*
>   * GEM ioctls.
>   */
> @@ -465,6 +485,42 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	/* always clear VRAM */
>  	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
>  
> +	/*
> +	 * === MMIO remap (HDP flush) fast-path ===
> +	 * If userspace asks for the MMIO_REMAP domain, don't allocate a new BO.
> +	 * Return a handle to the singleton BO created at device init.
> +	 */
> +	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP) {
> +		u32 mmio_handle;
> +		/* Enforce fixed size & alignment (exactly one page). */
> +		if (size && size != PAGE_SIZE)
> +			return -EINVAL;
> +		if (args->in.alignment && args->in.alignment != PAGE_SIZE)
> +			return -EINVAL;
> +		/* No extra domain flags for this special object. */
> +		if (args->in.domain_flags)
> +			return -EINVAL;
> +		/* Disallow flags that don't make sense for a fixed I/O page. */
> +		if (flags & (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> +			     AMDGPU_GEM_CREATE_ENCRYPTED |
> +			     AMDGPU_GEM_CREATE_DISCARDABLE))
> +			return -EINVAL;
> +
> +		/* Normalize inputs (optional, for user-visible echo/debug). */

> +		args->in.bo_size     = PAGE_SIZE;
> +		args->in.alignment   = PAGE_SIZE;
> +		args->in.domains     = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> +		args->in.domain_flags = 0;
> +

That makes not much sense, the in parameters are meaningless at this point.

Regards,
Christian.

> +		r = amdgpu_gem_get_mmio_remap_handle(filp, adev, &mmio_handle);
> +		if (r)
> +			return r;
> +
> +		memset(args, 0, sizeof(*args));
> +		args->out.handle = mmio_handle;
> +		return 0;
> +	}
> +
>  	/* create a gem object to contain this object in */
>  	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>  	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {

