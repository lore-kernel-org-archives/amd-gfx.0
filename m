Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418F7CF34AB
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 13:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5D310E5FA;
	Wed, 19 Nov 2025 13:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5+Fr2cH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7F110E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 13:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrWojfBlXdeWL9fsSBrhY6C5BVbsQboylNq/e12suiouVR8+v9bYdIQJbc1llQJmzD9HwSmUFhLkktBGCDXya3E/Yd+RFTwQrBApxA1bkhhUVnWhSyy+GSSXx1oq7ZnlwYM/WJ2NdXIgPbhkYblg2P/Z8HcOZj5tmKB4fcJNglHggX7Ak9xmmuRBPJpXVJnB4BeOe52bJOra4CK6bhoH64haNxpnjmCwKoLFbDRbWvARLdVwK9KIR7vdjsSGO4Nh8QfnE52iZuYlHb++w6hH8P7+9+DvdSaGRy4G/F1D1wu2IyD5IWLtBooxm/33BQ2Zd9h/9oKnEhVCsIP6ISsV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuJDaTlsHwgB74gqEdYXItyaPN4+armeaQ6Jpjfx0tw=;
 b=qWWERso7aQhdi1t2OUuKXWlhqWyxatBAoR/p3RqFlIWU9DX+9cgTVW905M6wOCN/Z7CpdpUEew6XXM0kSPmImuV5BPWkHkoyBKicXAaZFs+izlQkJfrq+jBCTgg6q42D8AYyC+4yuvQf1tmoO/r9u09aElsEK99e/13nJzrsGRmjzlMTGsE4Drhdyc2BS9aADtMt4fcL/YUy9YWCN1+vkEZI9iGqDGZkbsu1EGYhpCNOhRfXjuUAUMhIbSBfuzMGFC9e5cAzp/Meh+Va7JP8WuK8xWCBzaHEJ/thShG1fEPNr3riZbn0dHzbToijBTGzYaDfVtStN1oXgM1FDe0LYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuJDaTlsHwgB74gqEdYXItyaPN4+armeaQ6Jpjfx0tw=;
 b=r5+Fr2cHWmPIRXZIhnULU6nf9//Z0id1yoIpEWzuDNk7/NfKcRppY3BbTJ//ZfPHOUmJsXFEvBeyJIvT5bnriUUoV7KcQ/MWQStsXAr+YR9ji/mYOD9lkEaU1qbgnZo7a/a1d5/v3ukb6nYQJYlbA7MVEeIMHcJKwCXu2tEQo2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:20:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 13:20:10 +0000
Message-ID: <642212b7-9e13-44db-99aa-21d503dfd825@amd.com>
Date: Wed, 19 Nov 2025 14:20:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20251119004818.4126460-1-siqueira@igalia.com>
 <20251119004818.4126460-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251119004818.4126460-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: d05112a2-72c7-4d03-7624-08de276e5dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3NYQVFJaG9zOHpVQklzT3FuQVRIclhqSlEzaE56TWVyKzhmVHkrM0gwTUgv?=
 =?utf-8?B?ckE0a29NcmliQkFGR0hrVTZmb0MxWW5vOWh3c2VVN3RZUmM0Ni9DanB2RUFL?=
 =?utf-8?B?dzFLd3FOak04bHJpRWptTy9BTzZKR2lFc0NzZ2Q2QWV1b1lUdWtyQUprMlhS?=
 =?utf-8?B?SHpJWTNhdlg3djNHTGJ5cmlEZit5Szl2dEQzN0FDeXRrY2VXU2VqTFhpSGQr?=
 =?utf-8?B?ZmVtRnhtY0tRdXNYdHVLWE5uQ1crT2pSUkhRckV0SU9ndHlUWUNOdnBGQmtU?=
 =?utf-8?B?THJsczdnM2VMbFozRkhIdDgvRUhJQ1FYQkxnVWI2RjVTczhYZ2hrNzU2dDRy?=
 =?utf-8?B?MXhTVy91ZGNHTm5sVzdBNlhudTYxbU5XUEF2d1dGbFpjY3Z5R3FXK09mVXM2?=
 =?utf-8?B?bnF3cUw5QmpjRGZvU1ZZb2p4U0Y1aFRlVUU4WVpKYmJhZmNlRFZKRTlGZWdi?=
 =?utf-8?B?akZ4dUl1Vm1FYVZBUTI0aEZ6QmZ2MWFMb0NrWVVHQ0Rqc3VRVUUzK3AyUHN3?=
 =?utf-8?B?Smd0aXBjNnlQSHJxNVl6VzZ2QktvTzRQTmZrRGlXeGpReE03QjRxbTBGZjJE?=
 =?utf-8?B?aE9LbjExdEJUMGdLaVlacjEwQ1JLSUpiS2ZiTCtNWWpRaTJKVzh4RGlSUFV0?=
 =?utf-8?B?SGZjeHFwa1VSR0V0MmdDczhSTWNxUS9ZcytCdkRqSXk2Y1ZTRlJENHRLSzFy?=
 =?utf-8?B?aW10M3IzSWtyTmtGV2czZEJPbko1Q2ZTS1pYVklHd3VTS0ViTG5RYzFQQWg4?=
 =?utf-8?B?RXp0SlFEckJVS2xXUmh2MXRqbytjWmphamRWVFczcDJCSkZjNytRbU9GVWhZ?=
 =?utf-8?B?elZQUEMydmtqUlVWQ0NhcmZjR21QVmkzWS9HQ2hWWU5HbjkralhQekNZQzky?=
 =?utf-8?B?blpBcHdWY0gvY3ZhOURIRjlLUE1qZ09OMEJ1bG4zV1JOY2ZyNU5udG5uczls?=
 =?utf-8?B?a05ESks1VFF5amRRcVFkdVFMWHBZNkVjMmJVcHlzMW1KRExVbDVjeE56cjZS?=
 =?utf-8?B?QTFCVHZtM2pJYnJhUnZYTlFTa0tsb3FuN2tnVEVxMzV2ckVNV2hHbnAvdllU?=
 =?utf-8?B?VWhZRDFaZlRyemdQbVRaWG1XQngyb1BFTHFmNE5rTmlFQWpqSmswNGFWVnhE?=
 =?utf-8?B?YTBIOENtWVpFVGtYQ285WDlOdjBySmRRd1Y2SEZiZTh2NW5HVXcxc3FqMW1y?=
 =?utf-8?B?NEl4dDhVeCt5K285QXIwTTZ2QmkyY0xNRWJpNllvWFlyTi9ycGRHb1dmcENs?=
 =?utf-8?B?Zlc2WFRnVTRvNFRPM1lZUW9iNitoekJuOFBwMmpRMUdzL0hVeTV2TkdzYUdu?=
 =?utf-8?B?VXUzY21TaFBtZEFLUkdjZjU3SVFRNEdPeDltc2NpeUhyZW9pS3Y1RVRGdHgr?=
 =?utf-8?B?dGk0YWYwcnQ4UVB3bEtEbDVvZVN6RGFNVTVoSVdJaVRlSEtLcGliMlYxZGdS?=
 =?utf-8?B?N285emJoTW5wdmhhQ2NqUDlXbDBJemRUYlhIY0RYYUlpT3dsd1VUS1J2cWEw?=
 =?utf-8?B?SDdzcHNYVE1DeGJyME9nemM5cG1FRWx3N041TXVzdFZLODFzcFppaFAxM1E5?=
 =?utf-8?B?THUwRVJ6dzduNThsQkFrZy9UOUNobFhjWlhzMGRHZ2pTdmo3bmV4bHVYMVF3?=
 =?utf-8?B?Mnh5UmQ1NWVvUXFaa3ZGZEN1WFMwNWtPdy96S3UzeWxPNi9rYno3aER3T3RN?=
 =?utf-8?B?dm0rbnk3T0JaZDZuL1AvZkZOY0dtMUgvZ1VHY21NeUtFb3dURmdDZzRsajE5?=
 =?utf-8?B?VVZKeHl2Z0VIbVM4aWhINGJ2S2JNaXlvUGRnYkdYN0JGTEVEVXd5b2laczUx?=
 =?utf-8?B?WFlvUnVYS3NWM0F6eU95QlRRdzlTdW9tby9YQWRnSVlqSGhkL2FFS21INGNx?=
 =?utf-8?B?bys3NkgyQzVML2xyN3FOSzIwcVlvNUg5ZU5NRGZCWTNPc0hkMkx0bzBzUkpL?=
 =?utf-8?Q?5OdzWjJrsGinVV/I16bYBSLSKE4sO2S3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnU3OW9vbytuV0pDbFJKemZoTjd5VmwrOW53Q3FxcjlVVm9PVFM3REhVMFRx?=
 =?utf-8?B?S1BEY3FDU1A3UGx6UEpPYWdYYndIK3ZUK0ZWelNmYlA3aUxPcGRsWXJkZmda?=
 =?utf-8?B?WUxnM1lSK3pqSHR0VjFZT21SaXA3NVlNaW8rNlFUWkVlM0FCbVlDdmx3ZDlN?=
 =?utf-8?B?ZWNtMFFHQUxhQVhXTk5xTE1Dck5XU0tlZU4reWJaTDFEa2hHdXJwZUszenJF?=
 =?utf-8?B?dTRkZUtLaGFHUUowdVczMFBSQ005TWVvRzZucmVpUE1Ha0pQSVU4Y0NWQW90?=
 =?utf-8?B?N3IwMDJHa0hxb3ZWb0orejgxRFBmRDhOTnUralMwZUd5Um9pR2hrNm1FN3l6?=
 =?utf-8?B?SHRjSE8ycXhvMTkvaytrNmJuMTV1RUVudEtHdklDNURRd01EbmJlNnprb0pW?=
 =?utf-8?B?QXBDdmNwTDVIaHBCZDRWcm5oWk1XYUY0VHoxMXVRd0JSeEVZWEJLU280VGly?=
 =?utf-8?B?UUhJTGttUmJ4TFpnU2ZGKzk4c3VtaldMYzlzZUIrTnlRL2xtbWg3eFVkRHl6?=
 =?utf-8?B?cENlYTJHekFyR0pUYjZFTEsrTE9BWjdKOGtUaWtWNnErZmlKeDI5MjBDeFhq?=
 =?utf-8?B?OE5CZlY3UVBiMlF3ZEtlS0hDV2tTbzgxVkFjMXdYZnRpZGVpb0hlUUpzUjFC?=
 =?utf-8?B?Sm9LZzdFMmIxODFkM1pSNlg5dXp0c2dxUzZNdTRzYW1qbFNOV1o0dUF4d0Yy?=
 =?utf-8?B?THZCcldOSHNlQ0J2SFMrOURYV2FwcTRCZmllc0xweGdpKzFSZ3lJOTFwSElS?=
 =?utf-8?B?cmlPZFdSR21LaVpPeTM2MHBFSHloLzBTWUtBRWdwL09xQjVKaWgvQUlGd1VT?=
 =?utf-8?B?M2hjNE42dVdHV00yMkhtdWhTbGNiQ1pOYzNRVXNxTmNtelRFY2xWcUNvMjJY?=
 =?utf-8?B?d29tVGdBZXdNZDZZVjROeHNFRFR2dU5kQ1d0ZEprV3YrSnVhVWZYcWlqbmVr?=
 =?utf-8?B?MDBqSUs2ZjlidzdjRWRnOXlGbExzVVhvTGtzamdMbUhwVnFqTFVxdUxuanp1?=
 =?utf-8?B?enRrakwzREs2YlNBS2M4NURaNUJCVm0ycjViVDVQSm9NZ0pKSS9EVmxYTjNx?=
 =?utf-8?B?UXRlcVQ4RzQ2SVNlN202andnQS9FN211R05CYlRxQ2p2SFU4SGtSNHV1SDNR?=
 =?utf-8?B?OFlLRk1hdjRwK0FoVW1QYnpsUW9lQXZSYlFsZmR3aDVLa1lCNWQyTmpZc3BD?=
 =?utf-8?B?T1MwdFduSG5zS3pGVWtiVmsxQVRwanhaemIxeThSa2MzbGdHdE1lU2VQN053?=
 =?utf-8?B?ZlRjaFg3cGk2azVJbVY5eHdZTFVUanp4ZExsR0dQcWhqRFZyTDdFWjJoaFBn?=
 =?utf-8?B?ZFhhV1p5dEk4Y1QrVVNZMnZIanhRVGM0dno4WTFuQ1YyWWZ2cWM3VmIzSFlW?=
 =?utf-8?B?d0wzS2cralZwSHZLUWR0MmJmeHJZMmM1NkFSK1lYYXdzcmNkRDg5TktyelA5?=
 =?utf-8?B?RE5GOFl0U0FxdTU1S3ZjNnhrQzc0cDBxSDFXYWNnWjgraDd4Y3FvSGRRREpy?=
 =?utf-8?B?MlZZRFk4cGc2SjZrTEt0VXBCL3UrZ3d3eTQ2amtVUEQ1U0pVaUZ0a21lVEFh?=
 =?utf-8?B?OHNKeW1BNTNtTWRiblpIdHlSTnRydGtYcTE3Zlo4VUMreHpBK00vZ1lkRlBO?=
 =?utf-8?B?bHNPQ3kySjJWMWU3bWNWaFJtSUlOdFlLUGtpNE1WMHBEYWNQOGhLenVxMDN5?=
 =?utf-8?B?YlYzRG5Ra3ZRamV2MnlHS3FzV3BPQTA4NWQ3WC80MHphZmhIRUJoNitNREJu?=
 =?utf-8?B?d25RK0l3UmVUSERCeVcyeTFxT2NRK3R1K0djVXB4U05WSGZVaVVYbHhpRUYy?=
 =?utf-8?B?dXZ2Yi9EWTZQSTZPVENJVjVUY0hOK25KMVVIMldwV05BU2pqQlVhVlFVMis1?=
 =?utf-8?B?QVlwR3FSOUt4My8reWZ0aElSYlJiUy9CVFJhS2VLVDJzRDZreUgwWXc0QnZI?=
 =?utf-8?B?b3JKTjZscThoeFB4Z2sxVEM4TGNRbUgzaWtUMThsb0wvaTFseDJ0UWYrRnd0?=
 =?utf-8?B?WUdrOC9RM1hDWkQxMVNsaXBXalU3Tms4UlM5OEE1eW1OQmhiem43VGtubDc1?=
 =?utf-8?B?b2JPbk5KNVFtZ05XdGw1ZVY2VlNXUDVqUFM0UTVjTHJWRlQ1bVFUTlcxaXRV?=
 =?utf-8?Q?lKbQn8x3WZvSfV94bVWKCyVmv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05112a2-72c7-4d03-7624-08de276e5dae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:20:10.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQDAXgeTC4bZ5VNjPgyJcfp4f7LJf+BrC+HCb6fAa6I5zrko1OnNr2BnBEa8o25k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
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

On 11/19/25 01:45, Rodrigo Siqueira wrote:
> Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index cd8873c6931a..4336862c9d71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -76,8 +76,12 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
>   * @ring: amdgpu_ring structure holding ring information
>   * @ndw: number of dwords to allocate in the ring buffer
>   *
> - * Allocate @ndw dwords in the ring buffer (all asics).
> - * Returns 0 on success, error on failure.
> + * Allocate @ndw dwords in the ring buffer. The number of dwords should be the
> + * sum of all commands written to the ring.
> + *
> + * Returns:
> + * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
> + * maximum dword allowed for one submission.
>   */
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
>  {
> @@ -123,7 +127,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
>  		ring->funcs->begin_use(ring);
>  }
>  
> -/** amdgpu_ring_insert_nop - insert NOP packets
> +/**
> + * amdgpu_ring_insert_nop - insert NOP packets
>   *
>   * @ring: amdgpu_ring structure holding ring information
>   * @count: the number of NOP packets to insert
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7a27c6c4bb44..a1fb0fadb6ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
>  #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>  #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>  #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +
> +/* Ensure the execution in case of preemption or reset */
>  #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>  
>  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)

