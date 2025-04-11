Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99361C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412BB10EC10;
	Fri, 11 Apr 2025 16:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OHhJ862U";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9D610EC10
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2mi7BDAEECij+JvaZQQspGWLYXb11Vq8dWQ+u/HHWKSfpK4x3DKMIwJciXpPIuY1+pDvLvOLkQ2DH/Z/c9w0ktc7qjD5pQtAA+d3lmjbUuMIPEPu+9LW8M31lYmrBRTRorrcDAT0jaPWVe8PEDX/zuQb+N8NhXqHp08sKgB4IgcDnNnwyOcQ4i6UEyGD8uZZHm7eHELoJpJ3/DTS2WNNHZLJmQBXuCukPVRLJPwaARY4d6L7ezHzTheGdThrmeNVHAl1ReDeKogvlOGyIxU9I3qzWYEfRjSlO598Rc9lnJkkif6chKsJ3YqdXIxW6u54AMF8fpHdQnguOwD1RbfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG6rPairFfphjGRHavJn8YyQ3baoiNgME8kZK1OATQ0=;
 b=fP6s18dY6+ASuKr6rakqWTyB6frBnfB34IY2I8nyKJjBh8xXVhbfx9F7emFCTOhn3pry6PCNjf3R5H6GHTcVJ72bV/PZkFoy++Nt4bUHRlsNxyCdQtARh3/aeGuTlToJQqtyVarkZ+lawbIaFF+O7QBq8G7IBbetZdw1OwvFKTUsJuZZznkP8pWwtaO7JcVh5Ie5zY2My0QvHuuJyIazXL5R1jqWyobSySYhUR7qg2PO05PyOeTDAOYILBGn9u2IwqX83uEB7wcYaBy5Sw/hqK0WQKUek2C6ykaTrKs7lUPWvpIDARZ7L6qfyA/MDcbp5IxyWyHkSx4hvXWspQr1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG6rPairFfphjGRHavJn8YyQ3baoiNgME8kZK1OATQ0=;
 b=OHhJ862UngymSsIZObv1eyJEcUPe/XUh/97ZOLugxgbJ1RQ75IvNdcFEgTcRp4Cl040P8DhdcoRa2rVzsOQECztq7kkbzzRgf/Gxz4+EJX8HvonYwSouHfqG0Rrl8fwZSggyW7U1fRO8zW0+mlfgcAFLNQTROfHdKXRr+NWPYrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 16:03:41 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:03:41 +0000
Message-ID: <f7691d7f-d038-45bb-befe-636beb9c93ea@amd.com>
Date: Fri, 11 Apr 2025 21:33:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu/userq: add suspend and resume helpers
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-5-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411141228.2722962-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8d7282-041f-4ed1-d4f0-08dd79126d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2Y3UHJBS2VlSHJSaGVFcWJ2dzljWlh4bnZIT2pNMjZleWJQRjVlYTFDRWl6?=
 =?utf-8?B?dWNLb2RtMTJweEhUNkNyWkNNNXFZRHA5UnlIU2hPdGRDR1Mza2RMR0RpV0xM?=
 =?utf-8?B?R3NHak41T08zc1hPUkRCWFZXM1F5SDVnNi9CVkRweDRsRkNoZzlTdEN0Vmdr?=
 =?utf-8?B?eWNXT3VacVhJUTMxVURJeDNkNGV2cmhjNEVmWVl1UUhSNVd5ZHEyVGpCKzNR?=
 =?utf-8?B?STdIeW5UZW16UHpoUmNzdFVDOFVxT2dtRDNPWW1OZUV2a1lYZTBlNjBZWjBv?=
 =?utf-8?B?UEdNUEFFaGJiODI5eFpoYi9TRkNSbFVlRjB4MEN3VFhJeFN5c0dqd2FyRVB1?=
 =?utf-8?B?aW1MTHBnTHorUTk0SFpqVTVPK2wvd09OQWdBOGlLTld5TWJDL3B1eG8zcFVH?=
 =?utf-8?B?d29TLzFNRUVsQ09YOGo0dDdSR1FDVHZrQ3Nqd0RBQzRhNHVwT0VENTczek1N?=
 =?utf-8?B?MTBEdlRrR2VVVFhkd0dqcmRGLytBNE50Rk1RRkpsK2hwTmh0VGtTeFFtbXh5?=
 =?utf-8?B?VGlkS3lRMTJPeHB5Tld6U1ZJYTBZQTU1c3ZCeGo2Vy9wcDE2UVZvcWhWWk1u?=
 =?utf-8?B?T2IvTzJhNkc0V1IxZThMai9pVFJqRjc3MHcyK05DL0tkVU5INTJNc3JkMGk5?=
 =?utf-8?B?VGRjNmJRZXUzTXY2ZlBhZzVGNGdvY092M0g5Vk5Bb1IrZTNacmFHQXZoemFW?=
 =?utf-8?B?NXRjUWQ0blp2bEdLWm9NZ0hkYTZQTkVwMVNHSGNRZlRrVE1COVdST2kwMUN2?=
 =?utf-8?B?aG5PdXgzbVU1SHRoOEpyZE9XUkVPZHVEWTJKQXFxU1RrUDNKU251N21aTTZh?=
 =?utf-8?B?WHdoVHkyeEowaGdzcG5EOW5RSUpJbVhzVUxaTWovOVBrWW95OEV5K05UTmZC?=
 =?utf-8?B?SVFGck5rWDYvUjVnL3pycEk5L0ZRbWRmRXFSQ01MWUwzd2c4eG1BaEZpTjRq?=
 =?utf-8?B?TCs3ZDM1aEJoRS83NXFPUXg5Q1Y5cVNVeEZ2ZHBYYWFWVFhuS0FnQnUyRGZM?=
 =?utf-8?B?ZVFZTk9Ea1Ayam5jT1p5VEFzTmZNRWp6QUdEVVE5M3pPU2JjbExCakdJdlRx?=
 =?utf-8?B?Z0orQ1ZMekd1czVza1Nhd2xzOWtpNmltQllTK0dHdTAzSlVtRnplNXdRWE1t?=
 =?utf-8?B?VzVtQ2FsM0VKZEh5N0VLS3g2S3VJenk4YjJNR2dOZ2JmNUU3UzhLUUkyOHg4?=
 =?utf-8?B?S253SHF5c09vdjM0SUZQYjlTZTJlR1NGeVFPSHY4RnBtbVhBdmNIYi9JeSts?=
 =?utf-8?B?cndoS3IzYXU5NlEvdGFsMktEL0dUYzUvMXpCa1ljN1Q5MnB4VTFNREQ3V2ky?=
 =?utf-8?B?UnZaZkttbzRocFBKUkNlclNlaDNpY3I1WC9jOEtnQm4wcHlSYm5wUG81UFZn?=
 =?utf-8?B?VUlMM1ovUnhBRGdnQkZLczl6SFpqOHZPZk4zbjVzVTVObGxXU1NaZEY0U1U5?=
 =?utf-8?B?cmR5SW8wdE1RT05XdXRYY1J3NTJTZmdoYmw2YThsVUNjTm1FWTYzdlFHNVlW?=
 =?utf-8?B?eit1SHFGU2tDVzhtL1poNFBEcE1yTkhGNm4rR0F1aWh4UzFtNmN4bENYZFdK?=
 =?utf-8?B?MG5mRnNnbGs4eW5iZE96U2J3REl0OElaNXN1bVFQditiU3dIZUNGLzhyckZ3?=
 =?utf-8?B?SGtsZDNaVjdKcWRrTUxpdDlXc0xFbEk0US84Nk11d3k4Vis4RWVLNWpHdVRq?=
 =?utf-8?B?QzBsc292UTIxSUpKSjNvZDB0TUZ3VzVJNitFYkhzMDdjRy9UdGw0SE9xRTVG?=
 =?utf-8?B?b2dvY3BkbDNPNE1iL3NKWkRPRVh6S0RhclhsclUyckdUdVo0Nm4zaFM3cjRy?=
 =?utf-8?B?U0JhWU0xR3Z0YUNnWFRJT0RtZjRJajZ2akJWTHZJeSttWUZWSXp4aVpFR0xw?=
 =?utf-8?B?dGQ1SDk5OXJhSlphUzNoTXFyWXBIWHpzY1JsRFlvc0ZzTkY0UnBINVYwR25Z?=
 =?utf-8?Q?I4fCJC5e+NM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFNFbnA3TVRXNnI1NmxSUjlwcFdMQ3RBTFc0OXJ1YnpCY3VreDYwVmJ1a0pu?=
 =?utf-8?B?cVB3MmVIdTFHaTNjcEI1UGhodWdZQlRpK1VMNHk1NThNeEFGYnRPbUR4aFp2?=
 =?utf-8?B?Sk82M0tQS2xna1ZSdnNsWDhBVndKTTRIMWdBT1JDYXhTdjRhemVSTDdscVNY?=
 =?utf-8?B?ais5endwczJteGNMZ0NGZW9YZldDd1VMNng4TFgrZ2NTZ0dqdlZBQ1FIQWU1?=
 =?utf-8?B?ZHAyM0VFTlhoZXBKM2UyYnBlWUlWb2lUN0xSRzNDQUJWQ1B1ZDg1NGFzRXpV?=
 =?utf-8?B?eUh6dkhFUjR3M0xUZnd0Y0dTQkRRNTRZTThzZHRPVXkzdmQyUWNKMFJ1S1Rk?=
 =?utf-8?B?VEp6Q2Mzb0o4OXZFQTZUSHhIajZiYW5lK3NGVG9hZEk3bmZMYXBvUkFPN1dG?=
 =?utf-8?B?WTFERzd5eDJiWXdscWlkT1VHV0l3K3grbFRqVUZoMVU2cTNHQmNveFVoV0N6?=
 =?utf-8?B?U0twRlo2dGcrTTd3aEJCWVFlRGZTTURhbHJBejlNdzRzNlNKbS9pZUN5ZVFp?=
 =?utf-8?B?Zm9zZ1QzeHpQeG9mS2NFMWhKTU9mMm1wYUF4bGgrdmg1UE01WHF0SEE3dW9W?=
 =?utf-8?B?SlBTRmg0RWhHNnhRWmQ1TUQxRDAwNWFzK21mTjN4bHBLZkVUUnlGZ0Nranhn?=
 =?utf-8?B?MHpaTHVycy9KMkNZOEJVMERKM050QndmSEtiOGdjMWNHWGFkQTY2Zjg5bkVG?=
 =?utf-8?B?Ri9XQVdIbU5neWhzOTdSNHplTlRTSHRaTTA1dHJNbXlkdlVQOTdRVmFKUHI2?=
 =?utf-8?B?UEw0SHhINzlHWk9UenA1WG95RXl4YjJkQyt2eTgzeUw4QkcvcWRJL3lTT0dt?=
 =?utf-8?B?RUdwRjloYTcxRkphemsrdTBuS1BiaGs1eUxwcHYvclhsTjMwMmE1dDdUaEFY?=
 =?utf-8?B?ZE1Lb2ZiUFBBRmpHb2thdnFTM1dNWGJtK3BmOWFKYzRmZ0ZFNzQrbkljQ0M5?=
 =?utf-8?B?S2IxWWcyaHNtREFLQWkzVlgrajNlYVFSbXRGcFcycFg0ekpCMUtsbXBWaFpG?=
 =?utf-8?B?ZXJXTFNaZStFdlRJRk8xYm9YeU0rYWEyMVEvZ05zL2lMWkFjeHhKcW12VUxN?=
 =?utf-8?B?ZytEeE9GN1Z1WnZ0VlhLM21URmlPT0JVK0laa1RXZEdxYlowdE9oTVJ0UWZF?=
 =?utf-8?B?djl2SlA4QVE3ajAxTk9jN05KK29pUFZvYVhTenBidVVMR0FGR3BZQmZpdmR0?=
 =?utf-8?B?ak1TL3JSRVlxb2g3cnZDckhSS3VLVzFMNEFrcUxySGVSdGVrSVVQV1hITldF?=
 =?utf-8?B?dkhGa2R2VUxCVnN0WHVzRHJMQm1iZ1hFb3pOMi9hb0xrVXh0OFhmS3phbHlY?=
 =?utf-8?B?bktOZUZMYTQzeEoyVkpyRkdGZGpucW5PS0JxS3NmQmlqMnU1bVUrOVJkTWpX?=
 =?utf-8?B?SStvUnlTbm02UG00UDFWTVo4OTdXeGU2V0FwWEFrVzEzanVIVEgwb3BBb1Za?=
 =?utf-8?B?c0plYWt2dUp5OEVvK1VwUy9VdE0xaklNWE9mbEpuYk5neEtYckVvdE91bnFF?=
 =?utf-8?B?aUNiZzBNYUVqRmVxK25yTStkOFR6eG1xOUZTbUNyK2szQ3Fjb05qNVNRQUhK?=
 =?utf-8?B?NWNrUGJCVlNDamduN2V5MlFLWFF2amxua3VDRlk3ZTMwZ3BzbkpIdFhaYzZo?=
 =?utf-8?B?Z1N6NXd3enp2NmNYNWFmNGQzeUJHaWdwOGVpVmZxNzg5UXVOREJHMTFXNC8y?=
 =?utf-8?B?SmE1YzN1S2J5MElBS3FlejlLcG91aStDY0FVbEhHak9OcWpiMXhxOHhBd0Q1?=
 =?utf-8?B?bGR4Um50dSs5OUM3RUQ1aHFyOXF3dkZ3TVRSUXBuVG1ldktFcTF1NUFEL285?=
 =?utf-8?B?enZlYWdEeGp6K1RjMWJhVjVKUktOcFM0cWp6eU1UaHM1RWs4d2oreXJyUTRR?=
 =?utf-8?B?RGlHNlRMSll6a05QNm02cHRoZnhKYmg0aFZXZ1VWVmR5MlU3dGxKZXNiWjd4?=
 =?utf-8?B?Q2FKYTZzOXNVV3o3U01NTDNNNmF6R0xWcnZyQ01ZVnFCc2FjR3pxdW5tYXZ4?=
 =?utf-8?B?ekM3MlBySEkvcXdoSGlIL1ptNzlieVI3Ym5ZV0JDRnZveGxCY1lpalpDNUhV?=
 =?utf-8?B?Qmk5UnJDbkFCR1ZPdUVUdmh1WG94RlJZZHBRWGpycVk4am9SeUg4aGZudEE5?=
 =?utf-8?Q?WLXMFgS/sEDOYd1A/3QIFTjFU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8d7282-041f-4ed1-d4f0-08dd79126d94
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:03:41.4200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60xNu01X0zd9SbYbvsSFL8+XmtICwyx6z2bQ2quAvgTR8MeGnuZqMHVvu8rLXoxWx0LNKFj5jmjsmOS6x0zZ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 7:42 PM, Alex Deucher wrote:
> Add helpers to unmap and map user queues on suspend and
> resume.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 ++
>   2 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 41a095c12f956..f5c2489baae43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -681,3 +681,42 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>   	mutex_unlock(&userq_mgr->userq_mutex);
>   	mutex_destroy(&userq_mgr->userq_mutex);
>   }
> +
> +int amdgpu_userq_suspend(struct amdgpu_device *adev)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +	int ret = 0;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		cancel_delayed_work_sync(&uqm->resume_work);
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			userq_funcs = adev->userq_funcs[queue->queue_type];
> +			ret |= userq_funcs->unmap(uqm, queue);
> +		}
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +	return ret;
> +}
> +
> +int amdgpu_userq_resume(struct amdgpu_device *adev)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +	int ret = 0;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			userq_funcs = adev->userq_funcs[queue->queue_type];
> +			ret |= userq_funcs->map(uqm, queue);
> +		}
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index a0cf6978f2ba8..381b9c6f0573d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -111,4 +111,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   					     struct amdgpu_db_info *db_info,
>   					     struct drm_file *filp);
>   
> +int amdgpu_userq_suspend(struct amdgpu_device *adev);
> +int amdgpu_userq_resume(struct amdgpu_device *adev);
> +
>   #endif
