Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79909C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 17:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F81A10E43B;
	Mon, 24 Mar 2025 17:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b1SWp77d";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAE210E43B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 17:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4CxU6JHMd4fCRmq39OCDUiy+nLNEPvYYSaqoKpdYE2k1bfT6zkFOfjXYOc0gfWLwgY0bcUU+ALiZ0oq8ebCAmWArL9oLhUI3CbfvYMWkSg7vpQLQW0pue0ZIvtTHlP7+4jM5D1RF/9fT2l3HRDB4Im/i+LkP085Ox3PgmeiG5eqNUgU2Pjv+vek5SyuBzg6KyA9F6AY5pyvJw+YW4Ay5RayyapMOQq9rRf6NsnmeGdd2Wk7ZzJcWDjAngrZA7UhkGGdW81ZY0Fxkf+q0/kgiW4bICmC1gR+NIi4y1LMiCKypZ0i2cTwzEBQA+SPjrjy9HFKKO+zrNR8O3OUQpJTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1WkMiQyHAe7TEXFZw19rPR7ipgYFUehIFNVmEJYgTw=;
 b=CpXu1J7tJ/nWM2P0IhIQ/EpxM4KJuI2tH4cxQ252g+C5B3mLsIHdGbVdMVcdGLfdg/Q/q457+eIAP8oHapaGoJnu2WlDDyf/BoAwJA3YtkNPX1yySOENl2qswJU9REOY2yAyuOq22ciCRPvwnx5C6VmsXZ3G/mYxrdW6L/AOWaSx+ShXzJ0iIPFLDnCqFF6iFVRx2+7ByEcbvDjBCIFPNdicQzOEesqAfhS4o7Fh69XGn+cIarvWfHf0bHdCoXT9y3ehMa1/J6Mt/MfKm/3ricVoLuX9dkKrDo87nTSd9vRWVsnLfcvBOKqPHmhl5s1ksYL2PgCTWCsxcjyt/LO1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1WkMiQyHAe7TEXFZw19rPR7ipgYFUehIFNVmEJYgTw=;
 b=b1SWp77dCnp9qFAm54EYBgiHlaLelHiFz0S4IwN3m9mZU/YdNnDCt/fFm9Pol+qsXGhUmDe16XbwV3AZr5+HzpcFesi96bJBlsQ3wbSql7BDUTgA5RmsWBjAQDoLgEARFYCt7C+NJAgy+3sm4J3p+jNGDM4mrB3NGA/GONNgSm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:24:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:24:37 +0000
Message-ID: <7ef13bdd-1063-4b60-ab03-38cd08460325@amd.com>
Date: Mon, 24 Mar 2025 12:24:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: add proper error message for vblank
 init
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 alexander.deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org, siqueira@igalia.com
Cc: aurabindo.pillai@amd.com, alex.hung@amd.com
References: <20250321191359.423187-1-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250321191359.423187-1-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:806:f3::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9a819d-ca4e-4d21-9141-08dd6af8c0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDZWeGQ4a0xWSjZ3UDNXMHFVMW51SytZNFFqZERPaFlPSE9xWlYxaCtUSHV0?=
 =?utf-8?B?d0NScmw3SitSTTdra3V5SmhMWTB1N2UxeFVFbnAwNUZSWkJhdFdTZ2pZMjh6?=
 =?utf-8?B?UWJ0MnFmTXlvSzZ5L3NhUEduRThhRFBjVlRBc29Mbmtaa2tIeVUwWEpWNlJT?=
 =?utf-8?B?c1dlWE9wd3o1SjBmNFg4Sk1nU1A5ZlNmVUNReWxQOEZOYlJUeldOZGJHL3dP?=
 =?utf-8?B?NHhQbmRsRjJUbVU1cnBGN0dkSEt4WVFBVVhzRDRMOWQ1SFUwVXB6STZjbDFF?=
 =?utf-8?B?ck5yejI2VHlaNzVGS1ZEMk43a1d4MEY1MGpmSjNXWHowZHkrZ1U1QmRIN0hK?=
 =?utf-8?B?cVc4UlRnbDVzS29tR085cFdaT3BVWEhLQkViTUZrVVFTMHRHR2M4bXRMbTRD?=
 =?utf-8?B?cTdzMGtqSlllOGdWRFZZWjFrWGhpNkJtNnY0UDBublUyb1NDOWtjVm5zZmpO?=
 =?utf-8?B?T1hOdWREaW1Qd2ErYi9qZTJxZEtvWi9lVENBM0NkRSt0SFp6ZlhDbGk4R3RQ?=
 =?utf-8?B?UFRPMXRWcXd3K3ZxM2llZDRadVkvVVhva3lPemM3ZGhPMGVBaSsxNmNKeDFN?=
 =?utf-8?B?aFV3Qm1JYnd5V0dMR0lnaXR6RlZOZVYwRnFGcTdKM0tpdUNHOVp6UGI1a2Q2?=
 =?utf-8?B?aU5XeS85cDIrWWdrMWJlNk8vZUFuZGh6T0Fpc3l0emhKem50cVdTQStvZ3Jx?=
 =?utf-8?B?ZTBXajBsNTVLZkpWVFZrdlYvVWg4V2g0d2JTWmlNa3NlU2QrQ3lrdzlQUnN6?=
 =?utf-8?B?Z0wzd1Zta1NCM3VxeW5scit3OXZXdmJnTXRSenNNL0FjMVAyMVpiNmhsQUNP?=
 =?utf-8?B?VEdVa3FERHpINHBGZHRzNG1FWitTak95UzVDczUyNzBJcUJGcll3enJFUklL?=
 =?utf-8?B?NUR0dm5ndjIxMGFlT25ZeExNazZYek0zaXRBanphZGY3anhmektHbmwzL2d2?=
 =?utf-8?B?TzJRWFhiS2poR0NrYXA4emM3VU10Mm5peW5yZXVQeFRPQnlLQ1M3dHZGRGF0?=
 =?utf-8?B?alduNUQ2VU4zTndqY2lCdE9OVHVaRTVGbHl4RE1LZ1ZmVmJRaFd3QW9TQzJq?=
 =?utf-8?B?K04yMzJyeGVPODNHOU9oT0VWb0p4Tm0wUEUyU2szVG1xYTNybzJCS0YzOGhQ?=
 =?utf-8?B?amNlNVF1MXlHeUtJclBBNlY1Z2tMZG1Md1pKSUMrMzBoQXVrU29yMzJzR3ZN?=
 =?utf-8?B?MVUzVS9SR3A1TDU2QVlWL3dpcnl5ajl0SS8rdkVZMmRQSnpscG9HVHRPSSt2?=
 =?utf-8?B?UFRDV0JFT3B2bUZnQTN4ekxnQ05hSWhBSzkxYmlVMnIrQW8zRlhnTkN1UTNO?=
 =?utf-8?B?THNvd0NQWFV2WnpLNk81UEtOMzNGTTBhd0FrdFlsSysvOEFRL2ZEanBiWld0?=
 =?utf-8?B?ZmRqbXBWdEt3aDJPd21EaUVqaUtHaHdVbnpRTkJLMy9Jak5CNHFoTGN5RE9r?=
 =?utf-8?B?WmlaWG0xSjAyY1FqV2Z6bi8rcGcvWXoyazQxRFZ3bXQxNEx0U3hYQWlXRUgw?=
 =?utf-8?B?NTZzcnJNMkRWV2tIY1F1bVg0dS9lQllab3FtS291blhadStGMWFFYW1kazhu?=
 =?utf-8?B?dUluTTZaendjSGVHWXBXRjEvQ1k0MnhGa1pWSUs1dHVseENsci82MnowaWF0?=
 =?utf-8?B?dzM4ZkwxQkdYdmsxSmhacWVXN2pTbC9nd2k1cDROdnAvdGJlMXlDWFNpdU53?=
 =?utf-8?B?VFAzdVBsY3hDb3RuQlZHNm4xTEhGMEpZcXQ1VFZlK0xjS1ZYVWY5OFVRMlIw?=
 =?utf-8?B?S2M2V3J2b1p6cjdiNyt2QUkxMmdiMlk0ZmpBS0toemdQSkMxWXg0QkFqV1Y3?=
 =?utf-8?B?cDU0cjhoVTdZVVk0SWJvaEJtRktJQldMNHhkc08yNVl0Nk9JTHJoTU1UTXZJ?=
 =?utf-8?Q?lIa5SeMEOOF0p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFdleDNTS05ZNkRoRmczRHhVR2ZZVXp3QWJFSDV3VUMzckpaUWJIS2pKcmo4?=
 =?utf-8?B?bTlleUNNc1VmR2pxYUpqTTNWWDVhbzRvRklwalRvSm1lTXl4Z3g5VmpmVVJl?=
 =?utf-8?B?ZVBHdndsd01BVS8rZGhEKzFFSmhvRGZ6UEJtbGlsUU5NK3lOL0lnRmNYYXRk?=
 =?utf-8?B?NTI4QjZYb3VlOHBidDdLNks4KzBYUVdKV2dIUkpXQ2d3aWc4ZGtHblllaC85?=
 =?utf-8?B?SzJMem1mdDZVZkZ3Q1F0L0pLQi9EaEdIK0FmS1JBSVBzMm0xdC9OY0pCSGYz?=
 =?utf-8?B?dC9JNHlVSS9wRzdYVFlEUWQ4RjNrdXc4NjZ5QWJ3R3FXSXRzMzgvTlhNR25G?=
 =?utf-8?B?Z2hqU25mOVF2bXJ3M3VBVHl3TzhkbTVGQVNvc0NnQjI5Szltam9FUkFzd0Fa?=
 =?utf-8?B?UG8wNmludEtUUlJZWXdjQU5tc1JGRlB6ejlFMFF6aVhvY21oWVRnL2dwaXVJ?=
 =?utf-8?B?U2pWcEloMDhkOGVpd0g1ei9tZ1orQkNFdm54U1E0OE1qdXZWa2xoL0JiL1Jr?=
 =?utf-8?B?ajN5cmlYa0dZcmU0ZThKamk3YVRwNXpkOEdaeHdlZjFaelZxMkFxMEt6NmQ2?=
 =?utf-8?B?Z2Z4WXg2UFpSR3JFMGRnVUt3NTFHeTBzaE1qZDVpL21yeXltMFM1ajBGc1ZM?=
 =?utf-8?B?bWZOZUpjd0VUbE1jM0ozOTJwNThXUGovdFE2eElGOG9IckY1bERoaWE5WVFr?=
 =?utf-8?B?YUh2WEFma3gyTlVRbm5tbVJUUnBEbjJHSFUvSGRTU3pzNGZURVV2cDEwRnlr?=
 =?utf-8?B?YnNoZG45UmF0NzVZVmNZWXFuOXJvcG9uaVFGUmsvR1VzMk0wYXFCVDdzRGtZ?=
 =?utf-8?B?eW5kY0Nsd0ZnWjltNldFejd0WUhRaG5Ta1dPZnB0bUNnSlhPSy8rSjVjcEsx?=
 =?utf-8?B?SG5TQndqVnFjSlVRa2hUeUxRdytiV2llZG1MV1J2NkNwc05idnlNWUtUOU1l?=
 =?utf-8?B?VC8vN3J0anRyWUR2ME9Bc045cW5pdmR3ZjVCV0hlRlVMbk85VS9SYXA5MFJI?=
 =?utf-8?B?a2hoWFo5bGU0R09jTDcvbU56L1lqYTJQQmN3ektwTXIrSjZZQWFsU0ZnbTJU?=
 =?utf-8?B?Sm5vMkFGM2hjWDFCVXh0OXhQeDJ3SURjdEs2R2FoeEhoU2EzbWJwUGJMUGlq?=
 =?utf-8?B?dmVMeFRxMFFZQTVjWnJxa256eTRuek9taTdEZE92Tk5EbzNHbjBhT2RoWTU2?=
 =?utf-8?B?eFFnRWRxMzl1WXhHVVJ6RW96cFNTYkRrbndhUTc3NzljaDhiVENneVJzUDhO?=
 =?utf-8?B?VlBiand2cldDK090UzJVdzZXL2pyc3RML3JIVzhBc2RwcmZhUjdjQ25NWHBp?=
 =?utf-8?B?cHVLeHd3V2dwdmpQQ0xoak8vaDUrNGNMWUd2Y0VsRjUydGtwaXA2UHN6Tjg5?=
 =?utf-8?B?Tkl2ZFVjYWZHRUhiNnZuRE1abEhmWlhFcG5mY3NkUzR6UFdaN3ZHNEZSVHor?=
 =?utf-8?B?STVTMGlDRjBCaGhoNkxVR254Q3R0cS9rWVcrMnlJcFNWTC9namhuUHB3LzVm?=
 =?utf-8?B?WU1VU3QxL2hURWhsQWhBaGZYRVRQY2tWbnJiVGVJamhUS0tONmxBaU9tTnA0?=
 =?utf-8?B?eC9QWHprMDN6a2R1bnRremZaNjluUVZDUWtkcnB3ZGhzQ04yRTRDK3UyQ0pW?=
 =?utf-8?B?cE5ZYStYVGJaWWtHY1o3Vzdid1BFbHE4NG5MQ2MzaG5Qbm9qVzZCNmNYK2Ro?=
 =?utf-8?B?Yno1TlpCSDU5enJKQjVhZmwyem95ZmQzWWJQeXlvazg4REc3dnlzdmJrbklv?=
 =?utf-8?B?NHZ0UTRKb0I4UkZueHNGWHgvNDZ2aExBT0c0WU00SzZ3YmZkUkNEbHV0OUtD?=
 =?utf-8?B?dVJySXhETFgrRU01b0NwUnZHMjR0dDE0SjZjQ3lEK3lKM2diZWRqSWF5R2ZQ?=
 =?utf-8?B?VTNLTWRaNFIwMGFmcWlPZytENnVBWFNkbFBieEFqOWw0T2daazhWQ3VLaFpq?=
 =?utf-8?B?bHE3ZWJYUXNWZmRCTDJUTnJYUExYb0RxTGhiUVB4TXYzWjNhdUtselBNdWdi?=
 =?utf-8?B?M2k2Sk5VaUNBM2NTNmFUV09Nb1NhNkIrOTZyZWNyT0UzV25ZdldBcnJwRkl2?=
 =?utf-8?B?OW5MOWk1N2JmQmxhaHBvZEVEZ2NVMlY2bEE1RHp4R1MvVmV1L2xhKzVTd2NL?=
 =?utf-8?Q?VnMenrV+VhPl1h82pptHH86gH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9a819d-ca4e-4d21-9141-08dd6af8c0bd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:24:37.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6XUY079gqbNtIjJsnP1Eq/jOgsUAmmQhPvD1A46bV+Gc6pIphG6MFFUFu+M/Cl0e8B4fbPx2wOCgRicdX2REA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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

On 3/21/2025 14:13, Saleemkhan Jamadar wrote:
> v1 - DRM_ERROR to dev_err (Mario)
> 
> Update message to identifiy the vblank initialization fail case
> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8dd9bf58eac5..ecc6d48a2585 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2217,8 +2217,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
>   
>   	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
> -		DRM_ERROR(
> -		"amdgpu: failed to initialize sw for display support.\n");
> +		dev_err(adev->dev,
> +		"amdgpu: failed to initialize vblank sw for display support.\n");
>   		goto error;
>   	}
>   

FYI - I had suggested drm_err() not dev_err().


