Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23603D0C600
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 11:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14A210EA7C;
	Fri, 25 Oct 2024 11:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbYSdJvp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A93D10E039
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 11:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTfh/1PU3SqmeafIJIGHRTAwJ1IAUj0Cad8Zin/ii/VWZjgIcBXUnTMPeh/5PsbUIsQOwFdTSqYkyZC9IGTq5cT5PM19Hv/+TGOPG4+wtdksF6cRwi267yN/BGRi4AYe+JqgZNpkSNzd5ghnYtBfpdDtjLAD4RS5YEvcYEO01JHZ4wCeK5HJUC1wZvCW9bD2twFKM16/Z1a7tN0agARdUzs2X+2yPce4TgzFwXI2rQnNFgdrDmo7ruxxKOos1LGITzmEgS8ctcRcfOfnjLvg1jQH7r9i4Z9JlPUkI287PeAuoglqN61vhF2SrYbHTZlEr7zKwEyCBFtLAs+JTBEL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGv2T0nxAuS3qW6KOKze6skGpmoUmEOqbXQtJuVf25M=;
 b=ocmJ7hpqkZYXB8UUT8C0VZzcGtNE0rBeggrjIQS3ETzoYSTiUivJYrR/rFQC8JpJWMx5okZPyee7FqTPaMmTSYuo1JGAyj8hBXgY4MVtn82h7dHil99H/srfoaVT2kDgc7wBpk7QgN65D0TpISsnsqKqHCL+DDeXKNLhqbHp8gEXU5pJ5ZJ+W6uE1KZoWjlXyFrBaPkfSr//6v60io2OT6Y+kZRjAvyzML5U8FHMOIQml+b1UizqQYNNgNC0nIJwqdcqSTNdxhnDZBVdAPL1XiShRb/rM57URzOkE877G0Hp3bLwgVwfP6EIyMEDlQP6I5MD0uc3lxy46gyAU5Lnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGv2T0nxAuS3qW6KOKze6skGpmoUmEOqbXQtJuVf25M=;
 b=xbYSdJvpGOds+M4RTZHh23u58YTd3wYoN+wi5UapXj4kACWbWYxgEYmB4Dj8aD0l0rFRMdYy1JRLA7IXIriUFiMi/WVpiFeaOGbCLmODQrxJPm0wi1L9HpuMLrBqmHWWtoxl0jDbmWw2nYLVW8TMahvopPu5t+ToR3RqMDkqAL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 11:12:08 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 11:12:08 +0000
Subject: Re: [PATCH 20/29] drm/amdgpu: early_init for each vcn instance
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-21-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <77fc83c0-ac8e-a30d-88c2-3e36ecb16da1@amd.com>
Date: Fri, 25 Oct 2024 16:42:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241025023545.465886-21-boyuan.zhang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------3CB39892803030356CC6F80C"
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 62594b2f-76c5-4bc2-bb87-08dcf4e5dd3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2VFbkU4NnNoNlU0cGZTYjhOZTdSVW1hVGlZWkhNUE5hUlRHME5WMmlqVkhO?=
 =?utf-8?B?NnFIT3R6YUJQMFlKR2hMd1JkT0pJdnZxM1k3S2tuQlZZeWRyTUNzYjN0WU9u?=
 =?utf-8?B?L09paXF2cFp2TWlpUlZKTk85d1BsRDdLWGM1b0NvSklmT2ErMTdnbmFWSTZi?=
 =?utf-8?B?RjN2dkVXZ0UycHR0dzRENngrREpBaVd0ZnVpV3VjZXVjZ3RjU1p0cDA3YTNZ?=
 =?utf-8?B?cXRNd0k2eDVmc3NqeUppOXhxekxrN3pVVGN6OTEvN3hOZTRZdEM1dXNCYnh6?=
 =?utf-8?B?SEp4VmRxV2YyZHJLNGFpaFdaSm5FVDRnanpOZDRXU1dLL2FBTTJWdVlSRUpv?=
 =?utf-8?B?cDN5NldnOTREcFNYS1dTbG1HeDV3VDNRT21DTzBVV3p3UUxiVVNTRjEvUXNq?=
 =?utf-8?B?Nk4yV2kzbENNZlZQczkwbnBXVFBRd1p3M3VYOVk2V3ZVd2loQmJkWEVSVWUr?=
 =?utf-8?B?eENHKzEvbTZKOXBuNmVtbERvalRJaG4vZ2VNOFNWQ0hmejJMSDZkUi9PUGhH?=
 =?utf-8?B?TDlGditwdkh4M2RJRDA1NkZ1RHdkeGZnc3Y3YnVGdnA4UHRiOTJTemxKRm1E?=
 =?utf-8?B?RldtWHJUTXI1TGZvU1E3MnJQcXlSRWpyei82UDRWajRRMVV6L0xPbE5UQlo0?=
 =?utf-8?B?RWloei81V1YvTjRjMGhoa2ZSOVFmeHQwczl3bGdIRWYrWVhIQ2pxalQwZTV1?=
 =?utf-8?B?TVZNcWNnVUxsVDlGNnRWY0thUk41b2xBTkIybzB2ckhmVUhZOW5zbkFRZ1Fp?=
 =?utf-8?B?VFIrckNmVWxtV0ZMSTVNK1EyWTNLcnMzZHZYVVdpZjNEYXpnRFcxQm96aUlr?=
 =?utf-8?B?VE9WNmJ3d0d3WEhCckp1bThmZzF4blkvS3lvSk9ILytUeUZlaDNINXVVUXkz?=
 =?utf-8?B?OFpIL1pRYytuTmVjL2MwL0ZnejlCeUltUEdHVmtWb3Z5VldmMzhRdlZYNzFT?=
 =?utf-8?B?RzlIY04vU3I3cHdxcno3czloUVdPNkRpQUo4eWRVSlNDTVlKNmhvQ2FtaUhE?=
 =?utf-8?B?U2hOZnduM3FuMDRBL0QvcElhbEI3dk02KzhWa3hJMmp3K2JrZTNDb0FoQkNS?=
 =?utf-8?B?bHBTL0lPT3p1QlZ6ck92Wnl3K1JYenB5VUdxeGxQZmIwZ3o3WGtheXdGeEJs?=
 =?utf-8?B?L1UxT3ZLck5NYmtqTStPa1J6aDhTd1FoV1pkaFFNWmhTZjVESy83RUhReHhW?=
 =?utf-8?B?RU9oaVlMdU5POUdJU2JFOHd5SEFzSEd5WmlKQ29WT2piQ2RoUUVvVDVOZHoy?=
 =?utf-8?B?blRKOWlJcExiSzV3YTY4YWNMa3phSVlIdGJNN2ZtaC9tZTlyYjZ6VDJENVlS?=
 =?utf-8?B?RzVsZXJZbDFUTVV4K1A4UkdCU0V1YjE5czI4L1lvZW1PS0M2MGU1V0F1T2Iw?=
 =?utf-8?B?YWFaSTg4akJIVm0yZDhxeTBqTzBaQ2NENFpTbE9pdUZ6dVFWZkpzSXRHTGhv?=
 =?utf-8?B?QktNOGFlYlU1WDJ5WGgvVE9ZVElsOUdPNW5maXl6dFNKV3hFSU0xV0ZvRkxt?=
 =?utf-8?B?UjhlR3IwdjJaalk2Rm1HUkE4d25kVEdRTFlZNUdGN0ZxVHIwWUJkZ0F3cUJ6?=
 =?utf-8?B?TGNVT281bnZIZ3VBRzZ1L3ROYWptejdqemhFY1RUcHFMNHdTQk5Ebm1aYlN6?=
 =?utf-8?B?Z3l3VVROMTFtK0lGNmxSSGs3cGJGTHNzbjdJZkh1M0ZhS1BtTkdGNjQ1OEdD?=
 =?utf-8?B?ZGFpMFhvc2N4WlpKYS83K0FVbExBUFRxY0svUytkaGFEOFRodzJZcWZiNi9a?=
 =?utf-8?Q?EthPGi5tYvOm8FkpJY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZFQTdEYzdWOUhkVjBNVk9RL044VjJwd0VQWGZVb1NtcnJ4S0M4YlB5M1Jr?=
 =?utf-8?B?ODNQSk1VZ1dCaysyRVIwb2NJTXZHdWtWMDJVZyt2cytPKzZLNThQZSt6MEJJ?=
 =?utf-8?B?TysxcFRJYWVSejltUm5ZeDVHajN6dVMzak8xcVNCSlRaa2dxZ2x2eFBiRXMz?=
 =?utf-8?B?bU14NlJrMllkeGtqaFpiT1cweGRCMSt3cXRxaU9wUlFWRFVZR3VZK0c2dlR1?=
 =?utf-8?B?T0J0cVQzVGljSzZjT1cxaTRSTEF2U3VBWkYrNlVTVGtDRXYvZmxkdlRvTTk3?=
 =?utf-8?B?aFVjeUdwdTJjUXlZUlIwWGlBRFp5VnVOdkFYUmtZMmhBdGlZdTNQS1JIZTk2?=
 =?utf-8?B?alkrSXdPVUVvV1AweEVidTlLWFgyVStlMTZuVmsyQjVMQWhiYlo5bjNSN1JM?=
 =?utf-8?B?SUNQTXhDa2gxY2JGYlExdkpSSVZBS0JVeS85RmUxMGpsV21zbWJSdG1ick90?=
 =?utf-8?B?Z3dEMlhKRXlqYUpDYVR4WUtGdHNJWGs4bTVXWTM5OTlmeE5xRjQ4ZDRnc0hk?=
 =?utf-8?B?SnNlSmNmQkFWRUxNU080azBybW1aaVlKdU1RTmtreDZRL3FQWHJxSEhkb3NV?=
 =?utf-8?B?bFdpZmRQWlFyNHhOcjBRR3A1WndPd3lPT25YVDl1R2VrcXdGRlBFVlBLRUxC?=
 =?utf-8?B?OWdUUzJ1UkFYSEczOEcrRk9ORGpBODExbUhEY01GdnRWcXpiL1h3dGhKTVZz?=
 =?utf-8?B?Y3I2ZHc1amVER0xNdXlOcW42UHIwdm5PMWM2ZGFWSTVkM2JnbE8wRWM2Z0N2?=
 =?utf-8?B?aGo0VVNuUDlTVnF1VWc1UkxCdUR2YUdxTnVSWStYWDJmeW9xWUh0K3hjNjdS?=
 =?utf-8?B?d3VqWjc4b3Ixamk2TmNNMkR0eHhnTVVqT3d4eHA4dFRoSDhZcW1MVWI1NFJ4?=
 =?utf-8?B?RG1JVXNjOEtCclRscEd0L21DVlVXVjJVQ09aSldPOVR1eUdLZGY0QlJKQ0w5?=
 =?utf-8?B?ZUpCeHhUVWJLOHN5cUtESU1NQU9VeWFjYlVJYzhHeTUwNklDRE56eXArd0t0?=
 =?utf-8?B?eWhDbXNmVjFxSzEwWVZvYWJNRkdOWUppUTNZb3loem5BVkoydHZUUUcxTjUz?=
 =?utf-8?B?SXJQbHpEb0ZCVnZuN3BJc0JCMFkvaHpSK0g5TkY4dmlsV3dvTGZ3djZxVUd5?=
 =?utf-8?B?Q0xqdGpsT0ljR3VZNGw3Q1N5QVlRMWwyNE9FaUM0eFVqc0k3NnFSUEN0bUgy?=
 =?utf-8?B?ZUh4aGkzS2pFK0RDYmN4WjdzSkZnR2pmdDFpZXF5ZXEwRGRuUjliYXJzWTNm?=
 =?utf-8?B?aEFVM1QzSUYyb1dQTDBDYk9QZnlxcVU2bEEzQk9jUUg2RHNtYkRkbjJTbXRN?=
 =?utf-8?B?dVZJK09NSXM5OU05NXpNbUwvajgvRDRKcDM5MHp5allPRnlzaVlKSVoxM3I1?=
 =?utf-8?B?SGQvbTJiQ3lhSWw3SW1UaEU2YUdPZzh6SE52eU0yTExvcVlTbWpFZHpxbUVK?=
 =?utf-8?B?aFpUS3BwKytUUEg3M2RpUHhlZmpISlk3UGRzTSsyeE9sdUsydzhiSk95MFM5?=
 =?utf-8?B?NXF1WWtrNDZESG0rTUpERzg3Mmt3RmlwT0FBYVF6dTVUd1JjcnhlK29rVkRo?=
 =?utf-8?B?MFg4WGdjbWhuMmhyb24raVFIZnNybFZKa2YzNDZEK3RMMWxzbHF3bWd6aCtY?=
 =?utf-8?B?VjMrNnh1M3JGYjJrNDVKdUN4bDhYVG9EcEhBVDdibjhvYzVvL2hKRGdMTFJI?=
 =?utf-8?B?N093T3F2OG5SNDRFTTZrK2NZVkI2aTZmem05SUNRc05qR1FidGZHYnoxVDRL?=
 =?utf-8?B?aHdCZjhDdUJsUDVuWUtMeGFndSttK29xSW56YlVHTXIvbFlxVTlGRlpSMlZ3?=
 =?utf-8?B?Q1lRMTRMYk1Od2RpaE1laFRKWnNrNnQ4eDI4L1hlaHV1djBLa2pCYmZSY085?=
 =?utf-8?B?NU1aWWpzYUkzTnpMMHJLR2YrVWJ2RnpsZWVRcU5CWGRJSEJVSjlqbW4xRnFq?=
 =?utf-8?B?ZnV3N2ZzUzZYaGd5OHlGbGFDWkdhc0dTS1BjQ3ZaVTUyY1ljaVBKalFsdzhk?=
 =?utf-8?B?UkNhS2k1SzlmU3FaWVF3YmI5eHFVUDZ2S1VKeS9vMDh6VUV3L0txZ1YrLytz?=
 =?utf-8?B?RzNPWVkyL0ZvS1h6YWk0WmxKSDMyTDU4UnlJQUNPOXVZa2RCYUQxaEl0RXFI?=
 =?utf-8?Q?hNSsbjRlHVOcyHRdix75nr/Tl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62594b2f-76c5-4bc2-bb87-08dcf4e5dd3a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:12:07.9463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5blhjzlsu9B88qw7qx+D2UMMYvthqfAZS5inn5gXwJFhrSmEbIBR98/kY0QqqBIqPTvDZch9GgptkbHDOs0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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

--------------3CB39892803030356CC6F80C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sunil Khatri <sunil.khatri@amd.com 
<mailto:christian.koenig@amd.com>>

On 10/25/2024 8:05 AM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_early_init(), and perform
> early init ONLY for the given vcn instance, instead of for all
> vcn instances. Modify each vcn generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 ++++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 13 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 +++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  3 ++-
>   10 files changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index efd6c9eb3502..21701738030f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -91,22 +91,23 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
>   {
>   	char ucode_prefix[25];
> -	int r, i;
> +	int r;
>   
>   	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> -			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
> -		else
> -			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
> -		if (r) {
> -			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> -			return r;
> -		}
> +
> +	if (inst == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
> +		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s_%d.bin", ucode_prefix, inst);
> +	else
> +		r = amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw, "amdgpu/%s.bin", ucode_prefix);
> +
> +	if (r) {
> +		amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
> +		return r;
>   	}
> +
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 2282c4d14ae7..58fbb87e5ec4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -483,7 +483,7 @@ enum vcn_ring_type {
>   	VCN_UNIFIED_RING,
>   };
>   
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev);
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 8b860db34584..6fd509e6744d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -104,6 +104,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
>   static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   
>   	adev->vcn.num_enc_rings = 2;
>   
> @@ -113,7 +114,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>   
>   	jpeg_v1_0_early_init(ip_block);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 419ecba12c9b..8f7038190a43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -108,6 +108,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
>   static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		adev->vcn.num_enc_rings = 1;
> @@ -118,7 +119,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v2_0_set_enc_ring_funcs(adev);
>   	vcn_v2_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 7e7ce00806cc..74814370ddc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -118,6 +118,7 @@ static int amdgpu_ih_clientid_vcns[] = {
>   static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = 2;
> @@ -125,13 +126,11 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   		adev->vcn.num_enc_rings = 1;
>   	} else {
>   		u32 harvest;
> -		int i;
>   
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
> -			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> -				adev->vcn.harvest_config |= 1 << i;
> -		}
> +		harvest = RREG32_SOC15(VCN, inst, mmCC_UVD_HARVESTING);
> +		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> +			adev->vcn.harvest_config |= 1 << inst;
> +
>   		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
>   					AMDGPU_VCN_HARVEST_VCN1))
>   			/* both instances are harvested, disable the block */
> @@ -145,7 +144,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v2_5_set_irq_funcs(adev);
>   	vcn_v2_5_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index ca4ee368db02..a7fb5dda51dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -124,6 +124,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
> @@ -147,7 +148,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v3_0_set_enc_ring_funcs(adev);
>   	vcn_v3_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index ee6c08707312..c0c2a071ea15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -114,15 +114,13 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>   static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int i;
> +	int inst = ip_block->instance;
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		adev->vcn.harvest_config = VCN_HARVEST_MMSCH;
> -		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
> -				adev->vcn.harvest_config |= 1 << i;
> -				dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", i);
> -			}
> +		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
> +			adev->vcn.harvest_config |= 1 << inst;
> +			dev_info(adev->dev, "VCN%d is disabled by hypervisor\n", inst);
>   		}
>   	}
>   
> @@ -133,7 +131,7 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v4_0_set_irq_funcs(adev);
>   	vcn_v4_0_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 2c66a7a4ff25..1d1ee6da7647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -105,6 +105,7 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
>   static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   
>   	/* re-use enc ring as unified ring */
>   	adev->vcn.num_enc_rings = 1;
> @@ -113,7 +114,7 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v4_0_3_set_irq_funcs(adev);
>   	vcn_v4_0_3_set_ras_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index d725c12ffdaf..81efc53e7cd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -112,13 +112,14 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   
>   	/* re-use enc ring as unified ring */
>   	adev->vcn.num_enc_rings = 1;
>   	vcn_v4_0_5_set_unified_ring_funcs(adev);
>   	vcn_v4_0_5_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 3856388179b8..7873ca91da4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -95,6 +95,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int inst = ip_block->instance;
>   
>   	/* re-use enc ring as unified ring */
>   	adev->vcn.num_enc_rings = 1;
> @@ -102,7 +103,7 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
>   	vcn_v5_0_0_set_unified_ring_funcs(adev);
>   	vcn_v5_0_0_set_irq_funcs(adev);
>   
> -	return amdgpu_vcn_early_init(adev);
> +	return amdgpu_vcn_early_init(adev, inst);
>   }
>   
>   /**

--------------3CB39892803030356CC6F80C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p>
    </p>
    <p>Acked-by: Sunil Khatri &lt;<a href="mailto:christian.koenig@amd.com">sunil.khatri@amd.com</a>&gt;</p>
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;}
</style>
<![endif]--></p>
    <div class="moz-cite-prefix">On 10/25/2024 8:05 AM,
      <a class="moz-txt-link-abbreviated" href="mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241025023545.465886-21-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>

Pass instance parameter to amdgpu_vcn_early_init(), and perform
early init ONLY for the given vcn instance, instead of for all
vcn instances. Modify each vcn generation accordingly.

Signed-off-by: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 13 ++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  3 ++-
 10 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index efd6c9eb3502..21701738030f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -91,22 +91,23 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev)
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
 {
 	char ucode_prefix[25];
-	int r, i;
+	int r;
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-		if (i == 1 &amp;&amp; amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
-			r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw, &quot;amdgpu/%s_%d.bin&quot;, ucode_prefix, i);
-		else
-			r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw, &quot;amdgpu/%s.bin&quot;, ucode_prefix);
-		if (r) {
-			amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[i].fw);
-			return r;
-		}
+
+	if (inst == 1 &amp;&amp; amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
+		r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[inst].fw, &quot;amdgpu/%s_%d.bin&quot;, ucode_prefix, inst);
+	else
+		r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[inst].fw, &quot;amdgpu/%s.bin&quot;, ucode_prefix);
+
+	if (r) {
+		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[inst].fw);
+		return r;
 	}
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2282c4d14ae7..58fbb87e5ec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -483,7 +483,7 @@ enum vcn_ring_type {
 	VCN_UNIFIED_RING,
 };
 
-int amdgpu_vcn_early_init(struct amdgpu_device *adev);
+int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 8b860db34584..6fd509e6744d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -104,6 +104,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
 static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 
 	adev-&gt;vcn.num_enc_rings = 2;
 
@@ -113,7 +114,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 
 	jpeg_v1_0_early_init(ip_block);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 419ecba12c9b..8f7038190a43 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -108,6 +108,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
 static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 
 	if (amdgpu_sriov_vf(adev))
 		adev-&gt;vcn.num_enc_rings = 1;
@@ -118,7 +119,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_0_set_enc_ring_funcs(adev);
 	vcn_v2_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 7e7ce00806cc..74814370ddc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -118,6 +118,7 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev-&gt;vcn.num_vcn_inst = 2;
@@ -125,13 +126,11 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 		adev-&gt;vcn.num_enc_rings = 1;
 	} else {
 		u32 harvest;
-		int i;
 
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
-			if (harvest &amp; CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-				adev-&gt;vcn.harvest_config |= 1 &lt;&lt; i;
-		}
+		harvest = RREG32_SOC15(VCN, inst, mmCC_UVD_HARVESTING);
+		if (harvest &amp; CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+			adev-&gt;vcn.harvest_config |= 1 &lt;&lt; inst;
+
 		if (adev-&gt;vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
 					AMDGPU_VCN_HARVEST_VCN1))
 			/* both instances are harvested, disable the block */
@@ -145,7 +144,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v2_5_set_irq_funcs(adev);
 	vcn_v2_5_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index ca4ee368db02..a7fb5dda51dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -124,6 +124,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev-&gt;vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
@@ -147,7 +148,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v3_0_set_enc_ring_funcs(adev);
 	vcn_v3_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ee6c08707312..c0c2a071ea15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -114,15 +114,13 @@ static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int i;
+	int inst = ip_block-&gt;instance;
 
 	if (amdgpu_sriov_vf(adev)) {
 		adev-&gt;vcn.harvest_config = VCN_HARVEST_MMSCH;
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-			if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, i)) {
-				adev-&gt;vcn.harvest_config |= 1 &lt;&lt; i;
-				dev_info(adev-&gt;dev, &quot;VCN%d is disabled by hypervisor\n&quot;, i);
-			}
+		if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING, inst)) {
+			adev-&gt;vcn.harvest_config |= 1 &lt;&lt; inst;
+			dev_info(adev-&gt;dev, &quot;VCN%d is disabled by hypervisor\n&quot;, inst);
 		}
 	}
 
@@ -133,7 +131,7 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_set_irq_funcs(adev);
 	vcn_v4_0_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 2c66a7a4ff25..1d1ee6da7647 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -105,6 +105,7 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
 static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 
 	/* re-use enc ring as unified ring */
 	adev-&gt;vcn.num_enc_rings = 1;
@@ -113,7 +114,7 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v4_0_3_set_irq_funcs(adev);
 	vcn_v4_0_3_set_ras_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index d725c12ffdaf..81efc53e7cd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -112,13 +112,14 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 
 	/* re-use enc ring as unified ring */
 	adev-&gt;vcn.num_enc_rings = 1;
 	vcn_v4_0_5_set_unified_ring_funcs(adev);
 	vcn_v4_0_5_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 3856388179b8..7873ca91da4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -95,6 +95,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int inst = ip_block-&gt;instance;
 
 	/* re-use enc ring as unified ring */
 	adev-&gt;vcn.num_enc_rings = 1;
@@ -102,7 +103,7 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
 	vcn_v5_0_0_set_unified_ring_funcs(adev);
 	vcn_v5_0_0_set_irq_funcs(adev);
 
-	return amdgpu_vcn_early_init(adev);
+	return amdgpu_vcn_early_init(adev, inst);
 }
 
 /**
</pre>
    </blockquote>
  </body>
</html>

--------------3CB39892803030356CC6F80C--
