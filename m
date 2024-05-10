Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5C3C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 01:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F9D10E06A;
	Fri, 10 May 2024 01:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bfTtZTDf";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C479610E06A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 01:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBpdQMz6OermxGzI+buWP94aEqvPowKv7WbEbADGNFQ9Vr+5J+9uMhIdiqzzZbHLk/SnFoZqe2BFFIPmjl/M7NzbL8szW5zGN5IvD5l6sFb3VRElFHfIhvmdknIqTsLcMvhm64Q/j8dVJpCIExcNdHOFuMXOUPtz924Zlch95KgDVELiT0/mDU2Wqn/VlRgSzCHxt4yB+hzzk310PR6f7AcpIHt/Ravz5WTyNDa5FnqsLJgvlR1sC3Xwig24WXze+h9bbg9Ll72cfxyxTeRl/i5P60Yjvvyw1LWt0bLPukcWekhpkpnF/xb1VhGLe57/aKrYYiBRBB8dg8bHZsezUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEDW9QOZUBgALMVI77HuWoMaGTx69kqiB2hbMaIlleg=;
 b=cpIVy0i0EDMVVlxwe4WwhwHrGYcRdRSd0n8vmvhg1aUk9Rkym/uVBfCwwM6mHU4rRQnnPJQUQabBC3J3Z4uxWmWrIDoEGYN6rExhhT1qVJXjto2S3/fOlBhePzh23Cd+GA9kn4xrs+wIi68mSlxdEThcE/cEXDKwynBhONw1yME5viJXyCUFxnp/J9iITap1JR9+aS0K8CAv7JvQvVHazyhrAxUSsog7Z3BMQX4+9bPen5Mvh5SdXCl4vQHpOd2BRO9dlY1jdiR5Y3Cx8YBNjIqBiXC2qfpB2Hwv1A7nIvhzxpVOIYpZamlD6EUKXEA1lX3hSMY9sBfwzSxLRKgHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEDW9QOZUBgALMVI77HuWoMaGTx69kqiB2hbMaIlleg=;
 b=bfTtZTDfV1bwLduJQxNFTzUpf20o3xsqNf7jCaMmM0tgW21a3MJBp/rHT23zOtFzz6j+x3OZ/k5zqDyQ3QkDlnKfg5YWwmSimesE0yN+6k0OQyLNDBH8Xkv0i1GP+Wu4iutYJQEcbpidEKNcxcM9JUUUHS3M9m2fSMI+/iNjjC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Fri, 10 May 2024 01:00:23 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5f41:ecf0:e301:fc2e%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 01:00:22 +0000
Message-ID: <37128b62-3b01-435a-8607-28c67c119927@amd.com>
Date: Fri, 10 May 2024 09:00:14 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile
 setting on smu13 and smu14
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240509093705.414124-1-Jun.Ma2@amd.com>
 <PH7PR12MB5997A8C067197492C30A64AC82E62@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <PH7PR12MB5997A8C067197492C30A64AC82E62@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e511c80-aa64-482a-8994-08dc708c9155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y01LcFFqV0lpYXJGb0pzcVUvNjZSVEgrSFdSc1JZRTVGNVZIZGxZZmJCWHZM?=
 =?utf-8?B?Y1AyRXpGeVFhRGlXZnlhZHByZHFJQzJ1R2lBQXlkVDh1VDM3MFNqQ2tGT2tG?=
 =?utf-8?B?enRTUm1JSjR1TUVmMHI0SnZ1U0R4cllrVUJmQXU1VEtoejBwU2ZabmtpdnEx?=
 =?utf-8?B?bWkzS1lZcm9hQlhwVm5kVkpWK2NGUXVYNlE0YTQ3NHFzb0lLb2pzNlZlRnJK?=
 =?utf-8?B?SUN2SjlaMVFnWnJHQnZSWmdFUlZyVzk4YU5FTDdaMU1KN2pqZHRHVWhrZjVE?=
 =?utf-8?B?ZThOQmhONGg3OFpBS3F3eHhKcnhLZzNvdDFNclFTaXBnaDNzRlZMczdqSHp4?=
 =?utf-8?B?TFozNlgxVmxIVmE1dHN6N1RwcW4rblNGcHh3aSt2SUtNcXZNNXVzbS9oZlYw?=
 =?utf-8?B?RmRISTgxUWtWR3hjZDdPbmFEc2dkRlQyck5xSFIrMHlUK2Y1KzBzeGh2TkFP?=
 =?utf-8?B?NXNkc2w0OWh0Ujg1aTJndlJHcjBvWGRYT21CeDlORTREUlRzUTZUaHZUWWl4?=
 =?utf-8?B?UFNRYStaN1VRU1pIVzlucFJSUktlZDlldWY0d3hPL2h3RkRlZlU2QUxhdCsx?=
 =?utf-8?B?SFV3ZFdpeWpmdTYzN3NvNU5GRTBjRS9IUFV2em5YWG85c1E1bXZoTFlKcU94?=
 =?utf-8?B?aVd5TVM3WHBmdzFXRXNKeTB3QWhPNjlCcXJ0aWRCZVlrZjRhd3VDQXFPL0xQ?=
 =?utf-8?B?WmNQNzhNcTI2SENIMER1eHdyS2RZU3F5S2JXcUZlUDFPLzdjaldlT3VWWUk2?=
 =?utf-8?B?RlA2TUVCZndpVjNrd1Y0QlF6Ni8yUWRRR3daS09HUFVHTDY0SVF0b1BpRi9n?=
 =?utf-8?B?eDFSS2lOMHVlb1IyZzJ6bjBCMCtBS29ScDJYRFlQS3NHT1VSUVhLTDB2aFN4?=
 =?utf-8?B?ZTFUM3dac3JldzlteUNBUE1hMDc2N0VMekxGRW9adnFMc3NsOC9rMUt6bU0z?=
 =?utf-8?B?WllKWlJPdUd0RmpYaTdsZjNjcTQxRTJRS1hJcit0cVRPajNXenNpZGZwRnZl?=
 =?utf-8?B?cVRybU5zVGxSaVVmYnl4eXBXV05tVFREbnRSblIyNWQ5N2IrY0s0Qk1zZFgx?=
 =?utf-8?B?VGpCcHJOczJEaVY5NGx3cFFkSzN0dTNxNU43cnNSQkk4dDNOL2RWRnJoeW5r?=
 =?utf-8?B?Y0h6VVkzbVJ3d1FHUVBQRHNTb0VINDlHcUhGT3BGVThUcDhJNWtzU2dwVzFp?=
 =?utf-8?B?bVZsVlgxOHpOMWEyc1ltQmJ5MHJ5WE14TStNMDcramNNTmY1eDhpeXdMWGVI?=
 =?utf-8?B?VVdWWlJ3SVMybjd5V1BNQmxjQnAzeTUxRUVRM0lPSDRmdThaWXZjTDc2Y0dy?=
 =?utf-8?B?c1BvMEE3S3NTQmJPRWpRbjVLcDRabmpDL2hnQXdDUy93SVQ0NVdUVitLa3hi?=
 =?utf-8?B?N211NDh5MWMzNldkUW1YdkxRa1lPWXluMGpacVNYVENhUjdnREtKMENyV1Jn?=
 =?utf-8?B?UnNlRHZiYkQ0WGV0ZFVJeTBwODJGNUdDdnV0NHoxakZZaWI4d3Nyc29YWjFu?=
 =?utf-8?B?NlVLdm5JSG1hVVBQbXY2NmFMT29jZ1doOWx3TlBGVUU3YUR6aU1tMG1hMHZa?=
 =?utf-8?B?RnRrVXhYR29adWRmdkpKM2gvdU4wZElnZ2o1V0w3NzI5ODdMTU91RG9kVVBF?=
 =?utf-8?B?TmNiVVY1YndlUmJNeUJIZG0rQWRVQWxlWGtyeGVwTFFPcGY3c1JLQ2pnNjlx?=
 =?utf-8?B?TG9ZYWhLTG9rVEN3R29zUkVqdjFrQng5MHloWFZCN1JxSW8xUGtpaVl3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THlrRWNwN00xRkdVOGlGNm1JQ2owU3BKSU1JNHBvN2U2WnEvWkE0aHdUK0lC?=
 =?utf-8?B?ZWhmNzFOeW1WSytGODA1cHVMNWx5MUEzSzlZOEh1UEJQQ3BMVng3eldRa0Jk?=
 =?utf-8?B?K1Rxak83UnFTRkgwVGQvZktvSWJsU1l1NUd2VUNNRG5HSm9BWDRKNEt4Q0VH?=
 =?utf-8?B?TlNJbnNac3BDN3RjM2luN1ljdkFxbWloQm5ncjFac3gwMUErMTVHY2xyL0tL?=
 =?utf-8?B?Rm5KdXRBRkxVMmlEZmdETlZIdWxreVhZVXFqa215Z3JyNUx2UjRId1MveWVo?=
 =?utf-8?B?Y3hES1BVQmx5WHV0NTF5TEk2ZTkrZkVsVXFrOXhsdGJ4R2MvNEdTY3NNRFAx?=
 =?utf-8?B?MWpBMUNuRFZ0eDgxTWZDRUgxcTcreVQ0V1l2TXE0M3BRMmdpSGNvYVVtdld0?=
 =?utf-8?B?NVYxa25vOHNWUlBMaWd5OWNnOFlFUkROZDMzL3pSajVlRjZ4VFEyVzVXOTNO?=
 =?utf-8?B?bE01UEFwMzdLaE9hNHllUmZKYndvS2xBeGJVRitnem1WKzZ5N3RPVzdtOGE5?=
 =?utf-8?B?VkVwVHFNc3p6Q0FSNlh3MVluNFE1WnB2QnZadVVrRmwybHhMTXlYNldmaU1x?=
 =?utf-8?B?WXJuNE1PMktEdU1OL01kczNndUZvMGNiSHdTZEZqZU11UVNwN1JYcEYyQ3FK?=
 =?utf-8?B?NHZvd0ZwSHFTVWZIREpBWEdSYzFzNjkvRTBuRWREYTZOQ24vMGdLWmp6bXlh?=
 =?utf-8?B?UUJIMFdySlNTeVQ5WDlndDZqNmVHK05pcWZTMm1rZDN1V1ptZGpaVndGSmRk?=
 =?utf-8?B?WW5PSTlYa1FjWU55ZUFVZ0sxYUVDcUcxUEg1ODVJWjNRaXIySG16N0tNYlc1?=
 =?utf-8?B?K0RLV3hhUXhRcEs5ZHptSmYwbUhURmh4TjBjTERyVGxyK1VsU2JFVk93SXRu?=
 =?utf-8?B?OHNxN3h0VDRnRElDWHR2Z2szVFdvOVg5TmIxSXBsejdRS2VLdmRmdStWUXVL?=
 =?utf-8?B?REF5UHV1cStkYmZ3N3UwSG9RNksxWW54b0RiNS9zMjc5ZFVkUXZCVFVHZzBa?=
 =?utf-8?B?Q2d0dHBPSGg3WTdaWnNMWElaa2pyYU5aSGVsNGhJcXB6SVlxN0JLd0FnZjFF?=
 =?utf-8?B?ZVJST29DdlZpWVVvTS9aRGZBVlRPUERyYW5JdldiY3BWSTZna0E1K3V2TE5q?=
 =?utf-8?B?YTFsQ0YweHVnK1lxVFJJQ0Y5YkR2N0FHRUVWN0wzVDRHMmVXdGRZZTRveVM1?=
 =?utf-8?B?QzNEZDZ1RDFiY3czd0pYTnArcC9kd2dwb3dCc0w1Y1M4OVNId3BCNDNKK2xK?=
 =?utf-8?B?WG1EVkJCeU9jYTcyYVNuNEs3bzZkeTJPTlMxY2tZYlhZL3AyTkcyZ01hQ2pV?=
 =?utf-8?B?R01nK1l3UUUveVdGZ3VpWjVWYUhjOUI4bDF4RzU4T1ZDUWVrM2RCM29BNXdz?=
 =?utf-8?B?c2w3TVRVZVpNTUlXTThvcGt5L2tEU2ZzemRVWU04OWxEbjJXNUNRS21mNWhp?=
 =?utf-8?B?VExHYTE0UlFndzhmSHg2NEVRWU1UaHZjYTdETmJIdTBsRUlnWDdlYS9iaU5U?=
 =?utf-8?B?UG5aK2Z4NUtjUGhBYnVXb1N5ZkJtYUVZemc2TU1hSDBZNGJMZ3pHRElmMzdG?=
 =?utf-8?B?VC9QT2NFZTlnSzIrN3M4Y243ditLWlk0SVZPdVM4WlN4Skh5OTBnR2dUNnBM?=
 =?utf-8?B?MmsxUjMxWDZzUU1heDU4a25TWVhZck00UGMxUzh4S1ZDL1RjVWkxQlc4MW1R?=
 =?utf-8?B?YVk2bGFtcWFkNXRwK0lzUDlRRitReGg0Sjk4dXN3a2FNdGlBYlZoc1liZVJ2?=
 =?utf-8?B?OUxHaytwVUZDV3E1Q3lZTGxSSWxQV3hnY0tvS25VM25HRFJsN0o3a3h0bzM3?=
 =?utf-8?B?bk8zZWw0RE81Z29ramFNUEU3QkFQQ2dINWlVcUVDRlVpOHdndXUxcCtMT1Rj?=
 =?utf-8?B?Z2k0ZU13UnRXR0JMTUNubUw1RlFGbVF0Q2ZpQVhSVzhTS282QTFzclZaSkUy?=
 =?utf-8?B?SC90elltdUxERk1hcW10azdzMXYxdzgzK2NnK2kzelJ2cDVqSDdxR1dEZDZs?=
 =?utf-8?B?MzJadHRGT0FsaVFoZEoyTFc3U3lHVTB2RnlhbHllaXpJMkRlOFVWK1Vwditl?=
 =?utf-8?B?YmlVQVpxRlIrTkxCMU5vS3Q3REhRM3VqUWZHK2o1RXZoMDlZQ21VNUVJWUFx?=
 =?utf-8?Q?rgNB0PIqB28wtWvZN6E07Kdu+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e511c80-aa64-482a-8994-08dc708c9155
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 01:00:21.9615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epn3onTJUTK64GmSxcdW6dEAHyJZFzJRY8FLuDdiPqCT6NtRD6y0ajBHeZSpdlXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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



On 5/9/2024 9:01 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
> 
> please fix similar issues in other xxx_ppt.c file together? e. g: navi10_ppt.c, etc
> 

Fix codes for navi10,vega20, etc. are in the patch 2 of this serial.

Regards,
Ma Jun

> Best Regards,
> Kevin
> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com>
> Sent: Thursday, May 9, 2024 5:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile setting on smu13 and smu14
> 
> Check the input value for CUSTOM profile mode setting on smu13 and smu14. Otherwise it may cause out-of-bouds read error.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 5 +++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index e8b01662e164..6c24e2306383 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2495,6 +2495,9 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>         }
> 
>         if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +               if (size != 9)
> +                       return -EINVAL;
> +
>                 ret = smu_cmn_update_table(smu,
>                                            SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>                                            WORKLOAD_PPLIB_CUSTOM_BIT,
> @@ -2526,6 +2529,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
>                         activity_monitor->Fclk_PD_Data_error_coeff = input[7];
>                         activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
>                         break;
> +               default:
> +                       return -EINVAL;
>                 }
> 
>                 ret = smu_cmn_update_table(smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index e996a0a4d33e..4f98869e0284 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2450,6 +2450,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>         }
> 
>         if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +               if (size != 8)
> +                       return -EINVAL;
> 
>                 ret = smu_cmn_update_table(smu,
>                                        SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT, @@ -2478,6 +2480,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
>                         activity_monitor->Fclk_MinActiveFreq = input[6];
>                         activity_monitor->Fclk_BoosterFreq = input[7];
>                         break;
> +               default:
> +                       return -EINVAL;
>                 }
> 
>                 ret = smu_cmn_update_table(smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 0d5ad531c764..3f040a4d374e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1418,6 +1418,9 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>         }
> 
>         if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
> +               if (size != 9)
> +                       return -EINVAL;
> +
>                 ret = smu_cmn_update_table(smu,
>                                            SMU_TABLE_ACTIVITY_MONITOR_COEFF,
>                                            WORKLOAD_PPLIB_CUSTOM_BIT,
> @@ -1449,6 +1452,8 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
>                         activity_monitor->Fclk_PD_Data_error_coeff = input[7];
>                         activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
>                         break;
> +               default:
> +                       return -EINVAL;
>                 }
> 
>                 ret = smu_cmn_update_table(smu,
> --
> 2.34.1
> 
