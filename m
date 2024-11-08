Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD36D5C0CC
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 13:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9065310E9BC;
	Fri,  8 Nov 2024 13:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pI5CagAy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B3210E9BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 13:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cxb930yv7Bt9RkJJr/pBiO4sRk7vKmJy8w7szs6tYVleSn+vnxuCmGbIGUI/B62DtKgi801dUHS24ZXPDOkS8hp97twzMw0ZwLF1gDzHttg6njCCsBPSzrpE7jMjqGFDqKXpxHYXY6o626VicU938HLEPZZVNFzTN2IIJkktCk3yN7p4jUu5vXaQ9DObPUY7Os+6uCD39he3KB1L5CahmyVxtyWwtgZY/x79ZFkZz5BT2gSwZlzejPuvQMnsZZk7F5NWLbF7YlSvMgx+iUfV7Fw1AArsvIMUguZfmfO9rMyqibgPUVvC2Pntu7jvajIKQD2ivPWjr6WDBoA/2Xkg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARXguZBl+zNeHdXxJZ0E89tItyjautUvFJB4m2UwgTU=;
 b=XnpvzjkjPCx1HT4MmkYnrkAUo4ZaKxWIqRFXj2kE0NClshgfXVOxn1e+dl2hsxBxmXtS+UIeopAqUmWrzg+4+i7gG4t51fgeFT0fNHMCXMz5VTyEfCENyJQ+NMw22xupSjLR3EZqyWz9Cp6B6KuX6WBS1X2hmOandeg4xo9aDAw02FOiYCmUTUrlKjUHLjHvPKJ8bbSh2t8HNCMEKRen9Oaq2bekfVNihQqzNPPhrj8itZFHlD4ESkokxud5Rh/FEXQvT1NmES/+KIg4yIJ/0FEl2Y241Vt8cwZYkGYcKkoWVR8C8Ri/4tB/obq6xFQrAKjW9tMIoZPmDvTozxBc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARXguZBl+zNeHdXxJZ0E89tItyjautUvFJB4m2UwgTU=;
 b=pI5CagAyHORls+3ybvgXKv4tRwNlQlUUALJBH5x4yQYGXXpCY5RJHD2uzO19+L09VlU0/uEl/RRvRO0D+1nEYgvM2wB0Fb0JCLE/IUbtIM42ElNAz+VyEnUr8DpzZ0fpHvbRe7ljT6sLFP4WpfMTkiZpbrsMWQkRtkSq1KB53GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 13:59:19 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 13:59:18 +0000
Message-ID: <cb727a0d-eced-4bfa-ac56-16a972db2d60@amd.com>
Date: Fri, 8 Nov 2024 08:59:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amd/display: add DC drm_panic support
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: yaolu@kylinos.cn, jfalempe@redhat.com
References: <20241105140624.2897662-1-alexander.deucher@amd.com>
 <20241105140624.2897662-5-alexander.deucher@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241105140624.2897662-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: 625557bd-0abb-4983-3e70-08dcfffd89f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEZJOUptWVE4SFVwUXF4SFpzK3VSMEF4Y29WQ0Q2aTF3bHF3MHV3bXl6Z3hN?=
 =?utf-8?B?d0xLWk8xTjRWSGo5Tmp0U3VHNElQSGhqS3dPeDBiWExDcENsWm1OMnkvMWFt?=
 =?utf-8?B?a0swQWVhVURsTFBJYSs3N1pvczcwK0wvSHA2VGh2ekxxaUZ3ZnA3cm9rUlRr?=
 =?utf-8?B?VDQvMDFpRlNFbEZYTjZVWWdvWXhkbkptcTZsOGZQK0kxZ014dE1ITlM4NTFR?=
 =?utf-8?B?Tm8vODRzTGZZY05WTUxQMVlVdVIyYXlYNWQzZmtjdmF1L3RnS1FpRkZaZDFM?=
 =?utf-8?B?NWtuRXFhOFBhZ05obXJDbC9IV2c0eU9EVC8yZVhkbkozdGFLVEtML1VGazRF?=
 =?utf-8?B?Yk1PaFROYlZnS2xuZGc4cTkwOXdQUlVhMWF1QXFFWTRaNS9qSVpEcHZTOHdD?=
 =?utf-8?B?RitwdXErbDJuQUdaZnVpdVVSTTd3TUtUUDhuWDlabzlueVREQnBiczhTK21C?=
 =?utf-8?B?aCtCU2U3VXQ4SnFqMVltZjJJRFgxbEk3N2R0YWpUdzJ4azQwNnp0SEFJUDFS?=
 =?utf-8?B?MEZyeTFURFE1M2tRRi83RzRDaDEvNUJidnM3ZlRrSXNrYlJVQkZra3R0N3Mz?=
 =?utf-8?B?VzlvWElDc20rc2NCK281TDlJQmkxKzRScDliWDVCQXpueGJhVlZ0V1h1cDNj?=
 =?utf-8?B?dGZKZ2dueVhMQjlYLzNtOFo0WUdMMDAyZ29lQkQ3WXM5WFgyakF4WDBhTUxS?=
 =?utf-8?B?UmVuTjVHaVU4bCtVTW9ZSkdqUU5pbXJUOENjbC9seDBKU0oyVjk5OUU5V2Qx?=
 =?utf-8?B?N05iK1pqVTBpRzEwNzVSRU44OStteGNaZEhFekhzdktualBEQlk3ZWlRSWF3?=
 =?utf-8?B?MC9PLzhpQm43RnJzN2I1VlBOdDhvd09EbHpoTjFyTkg5d0o0UWhlQUFWQXc5?=
 =?utf-8?B?SlUzRVF2RGRlSGtmc2JGanV6QnhCblBua1I2VlFUclBhaHJPS0pobGVML0JT?=
 =?utf-8?B?THAzMGNjOTJiQ3l0cHBVdjFzZ0xYV2pZNEkydWwwRGhydjRHeDBMcmNQOXpi?=
 =?utf-8?B?TWx2aWlLTUtWL3EzblQyOFJZWWtjNWlyWC8wYUQ5cTBuVmtZUjA3R3dPTzMy?=
 =?utf-8?B?S1FRWGJtdmFxYUJYUVdqQnVlZ3YvQ040YnZ3QTc0ZXdnSTRqbS9nSTY5TUFV?=
 =?utf-8?B?R1llUVJwRkFLUzZvSzdLQ0UwdC9NMjNiVDdYQ3dxcldHTUU4c05iR1Zxa2Nt?=
 =?utf-8?B?cmlHcGxZeGJ4RWhpeGs3UVRhUnZqVCtqQ0FYOFZtcnZMVTZaUU8xS0k2Q0xu?=
 =?utf-8?B?a3VFQStjUjMxaTJxYkdGZ0M2RFNRSlQ3VVl2dWlWdmE4UHEyRGl6RUM4bXVh?=
 =?utf-8?B?MVZwVm8wbmNPMWgrL3pwVE9MOVJ4N2FXcmpiZlJzSmowSjlwUG91eUY0aEli?=
 =?utf-8?B?dGdLS0JEdlZlbGdyRThSU1ZVUzJQeVJGd1liZ2IrM1FENDVxZWIzb1RUUkl4?=
 =?utf-8?B?bitWa0dORzJtSmlwd1hJVjZrZWlNZFQ3ejRPVGdiMXhaRzVkMXNyQmY3dmc3?=
 =?utf-8?B?em9CWmZPeUM4clg3dERWelZCWlBSREtmV2U1UUkvTnZjUWdlaDBLeXNJUUFy?=
 =?utf-8?B?N3N4eUxxTGJJaGRTY01nQXp6d2F0QTk2U1NzU201WCs0K0hhTTBaM1M4cnVP?=
 =?utf-8?B?cTRFaFZnUkVHQmVPS1lxQmVoZ0d3c2VEQURZN0Z3MFBjdWs1RThBdUYwbTA1?=
 =?utf-8?B?TXorQm93UUJRR0wvbnVYYmhoQlpXUE9tVVVQVFJqdGpUTjdQL05xa1YxWlRB?=
 =?utf-8?Q?zuZKkt8AXOkDciEhF3QoeY70mVfdsqnedgCS0ts?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZjZkdIS2duQklaTWFOSk9Ra2lleWYzN2lLMnFwalhacmlyWWVyZS9jazdp?=
 =?utf-8?B?RmVXanJ1Q1JIMnFJakhqZXE4T1cwUk10b0Jia2dXeFA1WlNTOU8wREtuclIw?=
 =?utf-8?B?RkpGQ2ZGNmFBa3VSalVpN056emUxMjRyOVpEdkRhL3NtUnFVeW9ncGFaelNz?=
 =?utf-8?B?VVlGcEhucERRWG1aOGZINHEyVUVlTFBDTzlLTUxBNzlMdzZwV3R0eHpnUHhu?=
 =?utf-8?B?a2N4K0Q1cUtOS3p3dDYvNVB3VnVHaTZqKzB5UlN4clUvYVpubEFOQVhYNjNn?=
 =?utf-8?B?Q3h6UnBQbFJIYVY3UndBUStndWhxMW10a3hPSnFYVmVrRjRJYzFjSEZsNlJ0?=
 =?utf-8?B?em9UYXJFZHVKdlRrb0FmUHRFUFZiZlE5ZmlYR0tBRUU4RGhHbUdHZGtMNENx?=
 =?utf-8?B?RTVrL0VLWEEyejQyZnd1ZnJjN1ovaUlpdUVTWEdHN1hGd0FEd3g2OE9DKzRK?=
 =?utf-8?B?L0VjeG1Gb2lSbm1yT3ZPcjNqbTdGNXFWWmxFNlV6T1M2bVhTN2VFbS9oaGZJ?=
 =?utf-8?B?dVZWWnU5RnFkTXpNLzlYQnF5LzdHeitEYzBTK3JmNnRNWjUyanlKK040dXlr?=
 =?utf-8?B?U2hvbmF1dm9rc0pmdW56Tnd1MWZNZExjdDhWaGZyMmRxaWtzcENjVVlrQlRB?=
 =?utf-8?B?bkVhT1NPMW54azVUN0NkcVZNQmYxSnB2RisrZi81N0pYT3ZRMUNxd1VuejJN?=
 =?utf-8?B?bzRlNWxnNTJ3b3dTeURZMXJ3N2xTcnJwVWNOdnJMS1NDTnRMK1JvazNxTVk1?=
 =?utf-8?B?ZSsyU2ZmV281MUhnRWxiWSsyMkNxZDg5M041RkU0bEFMNkRCSDRrc1YvQjlS?=
 =?utf-8?B?cGtEellwZEtVZzhzWS94N0RTbTlNa05pSDNwMVQ5SHQ3enNPdUliT01IcGxT?=
 =?utf-8?B?QXdsek1jdWJLNkZYYm5FY21peTIyaElDTXJBUVhwYjUvd0NSdTQrUVNNVXJO?=
 =?utf-8?B?bjdONzN3L1JUU1kvbFcyQ3pES0RMRVFMamUvY3U2c09QUVlhUU1BZmtjdlA5?=
 =?utf-8?B?OVRNd0VJRU9oS2V2USt6aE54VzVPSXpvY0U5dzZJSkpnMGQwMXQ3ZEozbHkx?=
 =?utf-8?B?MXQzcitPYmoyTU96UThPQjZHcnk2aWVhSlFaMU81QTE0U05NeEFmTUVPTDRs?=
 =?utf-8?B?b2JwTVYwSURqbU1zcTVyeEE0UVFHUEs1c2pRTnZiWFNMaytYK2NnRTVRZnY3?=
 =?utf-8?B?RXY5NlZ0SVhDdC9hNERLUVVhNnN3MGM0RWlqckt3NmYrZ1VKZlhlQXRPY3Y0?=
 =?utf-8?B?akIwVEJFTHk1dWhmQlREVTQvNXJCbEF1K3pFU3lXVVpVcnJQU1Vxb2tHbHJ0?=
 =?utf-8?B?UVoyU2FEaE9takxyQmw5Ry90NTRHYVVWQUdJWE91M0ljdEdLY1NJSmxmVlRW?=
 =?utf-8?B?dGZMZ1VlS01xWTJTUHZVK3BPN1RqSTVmc3RDZlZpT0VwbkNqcjd2eHZNM1dG?=
 =?utf-8?B?RTdXdHloUW9CVC9MdkwxSHdGcXl6RlhpWjZmNWFta1lvWWVhc0dIRVQzTjZW?=
 =?utf-8?B?ZzJkOUxMb09sNFNsWkxURFZIZjlJZ0t6L25Ec2Q0dUV5WDdjRmVhNHFnTFor?=
 =?utf-8?B?S1VzQ2JZTGY4UDg0QURyS0VVZ3JPTXZlcWRBWUJGWGZQMys5R1lORGpjT1k5?=
 =?utf-8?B?YlpSaFNsaUJ3VDl2THlKREEwM2NRYVM4NHJTZHhGRExtZjJDQ0JzTnMvSHd6?=
 =?utf-8?B?dzBURE5DWGlSbXhCWHh1V04zSW1VcHJYcHk1bHBGeG1ZRU1kWFV0emN6UVFE?=
 =?utf-8?B?clNqR1NsWjRTdFlWbTdBaEVKS2JkcHN0NXZxcVBnbTFuSjZjQyt0WFdJb3Iz?=
 =?utf-8?B?T0V0alZZbDNJc01mWDJEd3BtWHpmdWJaUElBSlB2cksvSWpyYXhIeHVsclo5?=
 =?utf-8?B?Y2xXVFVnaXpUN21MdGZuVlZhSENGWTk3Y3hTeWREdTJIaWtYZXVZRTN4dGlK?=
 =?utf-8?B?VVRndTNJTnE1Q2F4QktUUkY4dVdVRUxlR1lHUmdGTlliNDJIZXJqWUJXYzlw?=
 =?utf-8?B?RnovK2pvdkRaYm56MHN1VVZ3UXVRVEZObWpkTllqZkFmV3IzVjRFUHJLK2Uy?=
 =?utf-8?B?VHBvbW1NNUtpNnd2V0gzYlRQb2YxL1RvSzhQdWVGUEIzem52d056SXdlREs2?=
 =?utf-8?Q?d3edWGjcRyHZFi0LvEE87pam0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625557bd-0abb-4983-3e70-08dcfffd89f1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 13:59:18.8038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaYvSEr3kAs8+KBuStVoXMwbXYRJg7rNCmEZU7XcdPiyd+5I4hKWNtGYe9E9X83xZomUacZpH43CIDb0vNoS8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
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



On 2024-11-05 09:06, Alex Deucher wrote:
> From: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.
> 
> It doesn't work yet on laptop panels, maybe due to PSR.
> 
> Adapted from Jocelyn's original patch to add DC drm_panic
> support.
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lu Yao <yaolu@kylinos.cn>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 103 +++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 495e3cd70426..5ba64e7ad3f3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -26,6 +26,7 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_blend.h>
> +#include "drm/drm_framebuffer.h"
>  #include <drm/drm_gem_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> @@ -1421,6 +1422,93 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
>  	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
>  }
>  
> +static void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
> +{
> +	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane->state);
> +	struct drm_framebuffer *fb = plane->state->fb;
> +	struct dc_plane_state *dc_plane_state;
> +	struct dc *dc;
> +	int i;
> +
> +	if (!dm_plane_state || !dm_plane_state->dc_state)
> +		return;
> +
> +	dc_plane_state = dm_plane_state->dc_state;
> +	dc = dc_plane_state->ctx->dc;
> +	if (!dc || !dc->current_state)
> +		return;
> +
> +	for (i = 0; i < dc->res_pool->pipe_count; i++) {
> +		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
> +		struct hubp *hubp;
> +		struct mem_input *mi;
> +
> +		if (!pipe_ctx)
> +			continue;
> +
> +		switch (dc->ctx->dce_version) {

The HW-specific code should live in DC. Can we add a new
DC interface function (in dc.h, or dc_plane.h) to disable
tiling and call that from here? That function should then
do the switch.

Instead of a case statement it's probably easier to check
against > / < DCE_VERSION_MAX.

Harry

> +#if defined(CONFIG_DRM_AMD_DC_SI)
> +		case DCE_VERSION_6_0:
> +		case DCE_VERSION_6_1:
> +		case DCE_VERSION_6_4:
> +#endif
> +		case DCE_VERSION_8_0:
> +		case DCE_VERSION_8_1:
> +		case DCE_VERSION_8_3:
> +		case DCE_VERSION_10_0:
> +		case DCE_VERSION_11_0:
> +		case DCE_VERSION_11_2:
> +		case DCE_VERSION_11_22:
> +		case DCE_VERSION_12_0:
> +		case DCE_VERSION_12_1:
> +			mi = pipe_ctx->plane_res.mi;
> +			if (!mi)
> +				continue;
> +			/* if framebuffer is tiled, disable tiling */
> +			if (fb->modifier && mi->funcs->mem_input_clear_tiling)
> +				mi->funcs->mem_input_clear_tiling(mi);
> +
> +			/* force page flip to see the new content of the framebuffer */
> +			mi->funcs->mem_input_program_surface_flip_and_addr(mi,
> +									   &dc_plane_state->address,
> +									   true);
> +			break;
> +		case DCN_VERSION_1_0:
> +		case DCN_VERSION_1_01:
> +		case DCN_VERSION_2_0:
> +		case DCN_VERSION_2_01:
> +		case DCN_VERSION_2_1:
> +		case DCN_VERSION_3_0:
> +		case DCN_VERSION_3_01:
> +		case DCN_VERSION_3_02:
> +		case DCN_VERSION_3_03:
> +		case DCN_VERSION_3_1:
> +		case DCN_VERSION_3_14:
> +		case DCN_VERSION_3_16:
> +		case DCN_VERSION_3_15:
> +		case DCN_VERSION_3_2:
> +		case DCN_VERSION_3_21:
> +		case DCN_VERSION_3_5:
> +		case DCN_VERSION_3_51:
> +		case DCN_VERSION_4_01:
> +			hubp = pipe_ctx->plane_res.hubp;
> +			if (!hubp)
> +				continue;
> +			/* if framebuffer is tiled, disable tiling */
> +			if (fb->modifier && hubp->funcs->hubp_clear_tiling)
> +				hubp->funcs->hubp_clear_tiling(hubp);
> +
> +			/* force page flip to see the new content of the framebuffer */
> +			hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
> +									&dc_plane_state->address,
> +									true);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
>  static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
>  	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
>  	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
> @@ -1429,6 +1517,16 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
>  	.atomic_async_update = amdgpu_dm_plane_atomic_async_update
>  };
>  
> +static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
> +	.prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
> +	.cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
> +	.atomic_check = amdgpu_dm_plane_atomic_check,
> +	.atomic_async_check = amdgpu_dm_plane_atomic_async_check,
> +	.atomic_async_update = amdgpu_dm_plane_atomic_async_update,
> +	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
> +	.panic_flush = amdgpu_dm_plane_panic_flush,
> +};
> +
>  static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
>  {
>  	struct dm_plane_state *amdgpu_state = NULL;
> @@ -1855,7 +1953,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>  	    plane->type != DRM_PLANE_TYPE_CURSOR)
>  		drm_plane_enable_fb_damage_clips(plane);
>  
> -	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
> +	if (plane->type == DRM_PLANE_TYPE_PRIMARY)
> +		drm_plane_helper_add(plane, &dm_primary_plane_helper_funcs);
> +	else
> +		drm_plane_helper_add(plane, &dm_plane_helper_funcs);
>  
>  #ifdef AMD_PRIVATE_COLOR
>  	dm_atomic_plane_attach_color_mgmt_properties(dm, plane);

