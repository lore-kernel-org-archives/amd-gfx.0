Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C426AC83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 13:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F1610E4B4;
	Mon, 14 Jul 2025 13:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rZIKsARq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA3C10E49A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 13:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUosqFlkOQTB4UEETwd0y+sKojFqQjXp8CIPDLiv8A5vPr43k2ZB/Pw2NGeMU1O14VqXaCFiqQiFF8AvniTmP8HQspaJoYJUSXzc2tTAmIvPHTpXbGFiqlJ672SO0PaKnqmwhexuMdhJZidqKEmGIZALDedItwEONIEAdCmrhdJRgTtUt98nbZiMSvmpSc28lCsRfMjQh6TLp1A+nCRfBndv5zU46CmbA9UgeYN+1kRzjHsc0PJPUOGvHN7zD/0cxEjVuA+jAo5hKYSrIkX9kK/Yrzuo1VKURiAIAc7zr3iuDYmA51nO440gRIhYzgE2QM6+H0kCl3sdWY8z8AwRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu6rHtBCdnqkoDeMXVbCXNtEgGzS/hVpEjio4PdCuGg=;
 b=okzVLkHIrG3kS30AtTUXfEtCJIU+cZUAyKAX0m7qiH1avJemccJmCZvfNHWUawbEjXpZklzizPDQu7ZPaMr1Ej6bbWjgJ4HmrvTV8mE19Ul6enkZkHwnk7aGQaniTA5a99cD2mEJMutS55nzjkiiPxuvEY7zObmbT7KdnyLcoXrRyRajqDvEG4xibzkfCxkpOgdSOm03sdiROlZ0Lzh5eTDS/2D4/KFMTrKZdlXeHliY/96sS5IT4388+j1zQRoQgSawy4BqkFhMaio5iQan1Si1mCs3yBf903bik0UcCs+8/c1h3DriWSjBQqSPDY4hwg3ZnYHC2bQ3FTc8DvRI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu6rHtBCdnqkoDeMXVbCXNtEgGzS/hVpEjio4PdCuGg=;
 b=rZIKsARqPaka7z1IPHgwidwTOQ9Pei6VEdwhW3klWbjMY80Qrf80kvKJqfpuz0wghEmkexSBnM4tCzxF7smB+uuVQOoCkIPXM2EBuOMeTTwVZozFa/G+ECotqayXHUaeKZFClMjuT532K2j4X2ey55b5M/7sW6lX6qvCuqJBArk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:30:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 13:30:28 +0000
Message-ID: <159ecff4-c825-461d-bd7c-27cac4e6750a@amd.com>
Date: Mon, 14 Jul 2025 15:30:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] drm/amdgpu/vcn: don't enable per queue resets on
 SR-IOV
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-6-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250711224024.410506-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: d9010b3d-4e9f-4b0e-57ed-08ddc2da9935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTlTWEp1SVJoUEc2Zi9zRVhCSC80eTlWYkFjYmJkMVJGdGd6K0FGK1JxTUVt?=
 =?utf-8?B?VzlsZGxzd0MwOFV2ZWNTOGxxVEVkb21uUXNkQXZJNVduSnJ1WW13UFdzR2Fr?=
 =?utf-8?B?bEhsM2FCaEZ2MXJ6Rjc0TWpLWWxBMTRjR0krYXJLUlhrTUZlOGdYVzZNUTFh?=
 =?utf-8?B?Ym9QQVIwNjhPL2FWbUhVdm0xWGZOWWlldjRGVnB3MEhOMzhVSml5eDhZMlgy?=
 =?utf-8?B?NDNYTG4rVlVnZURrbkdzcG1TY3R6cGpVZnBPeHBWWk5mRVhjVHo5b3piOGFn?=
 =?utf-8?B?bnJ1dm1qL3FuODRLNXduZjFzWmhxL3pHYTlRTlFmdWc3TllBMnY1R2g4UUJj?=
 =?utf-8?B?VmdjM01CN01pUmE4YkxYRGdoK0xRU0I3a0owaG9FRGx4eXAxVmVVamVzSDdY?=
 =?utf-8?B?TmNsNXRaQjBaQUQ3WHphd1U5VDVZeCt2NWRuVGtKZkwwU2xnRHFRb2c4UHFa?=
 =?utf-8?B?UTNtemxadHRjZCtheGorWHNrV3NrQkJ5ZEFIZmFQZm9hVDhSR0MvMGlXZG1O?=
 =?utf-8?B?bUVkaXlZNXZHT29kV0t6c1RVSnA2aG5BME9Dc2RtZlpkV0k5UnMvNjZldm0y?=
 =?utf-8?B?aXdta0dFc1JmSGEzWnlNWlR0SUJvcDd6SWY2SjFUM01HTWpqTGhmQ0tuU3Mv?=
 =?utf-8?B?SytlUmUrRVQyL0psbFZFbVJaWVQxWDBvTm84ZGcyMUs0cUJuQkJPN3R3SWM3?=
 =?utf-8?B?RFp3Tis2dUp0TDByYWxSUVROQ3J3L0E3ajB0U0Y3bE9kSm5HUklCbTVNYWxU?=
 =?utf-8?B?cHBCVjFvWVZLWmpKc3FYelpaN0RHQzlsWk5HYzR1bGh5RWM2QUFBbWlrNjQw?=
 =?utf-8?B?VEFyd0FRNWJEZExzWUg1TWk4Kzh3L21IMTlWQUtGTkhVcUhLdVVNT0RPZVlj?=
 =?utf-8?B?c2xtekR6VDhPK1VCeHhjOTcwYzlFQU1KMWlzZ3dySmp4ZlhCZkNEZmVaQXRj?=
 =?utf-8?B?M3lEZUdIbkt4MkEzSkt3TS9ickloV041cW5yUGR4K01wSW11MUIzNlVwQ2x4?=
 =?utf-8?B?eFVoNk5USHIyc1duQ3o0T2FtbjNiYXVoUUFUVTRlOWtZaWYrdjRQK3RLRWwr?=
 =?utf-8?B?QkRzZ1hka0FzMlpvcVFXUCtHazVVSzdhSzBrc2dBZTZNcG1PM2x4dk1RL0lB?=
 =?utf-8?B?TzNQWEc3ZmtTQklzZW1PWTFGNCsvMzVSalVGUnN2bnk5YmF4U0pBckZqU3dr?=
 =?utf-8?B?NFhXYjhBcmRDeUdhcFFVZ0xkeGFpTjRBV2VXaEtmQXJKQnVMWGpwSmp3TWRw?=
 =?utf-8?B?UkI1ZnovWCtPMi9uamhhbE1lV0tWdSt1dXo3M1daUXFOQ3lwUkkyeDJ0Qnpy?=
 =?utf-8?B?UGpaNGFwK3JCNG5mQmxsZ3dud09BaVpNTG5pNE9ObmE4R3FZY1VKNnArQWdF?=
 =?utf-8?B?MDNXQm9zZ0lOUkFIazhxYXYrTWJKc0tISVB5TlBCQm1QUVZMb1o5L3d1aWpi?=
 =?utf-8?B?bU8rZ2ZmMURTeE1MYXVPbXpBaCtDZWI3cGR5Mjl2UkJTamY1TDZlR2d1WkIv?=
 =?utf-8?B?RFd2NGdoNVNUcm9SdnJiekovSGFuK0pmZ0dhZE5WcGp3b3BWNmFpSU5QWDAx?=
 =?utf-8?B?enQwVUMyelBEQVcxZmFneDBDR1hSVzhqMG5pTjJmenQ0U2gyYTJXaWFTdHFt?=
 =?utf-8?B?Z2lqTnZMYVdnUlFUQkhrQnBWL1h1Qmo3NnVzeXV5R01OMTNkbFBhRGpUb2VD?=
 =?utf-8?B?YTNsekdqcDBZTXpkaVBxa0s0QjhCeUlUaDJ3bHN3MmRXNWtSazY5N0w3MjFL?=
 =?utf-8?B?cEhxYzFacllaM1NsSHVJUDRKUDZ4bFFtNW05M0xWZ0VOT2lKbmZOU1VWL09B?=
 =?utf-8?B?M1ZTYUZuZTlSeVZla1FrTlc2a3pKRlBoeTV3VmRYZjZqNURqUVpIYkVTN2Jk?=
 =?utf-8?B?YUtTWVNiYmZaMWZxcGhqVUVnbCtjajRDUWRYUHBMeWQ1WXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFUwcHFmNU1uemRabVpNWStoQk53aW5ibUNIQkIvZmlSbHpiN2lScllhMlYw?=
 =?utf-8?B?cEJKVTd2czBNSkhpUUk2UW9vNDFDUGJub3U1UkFtamNNdG56cG80VGhsRGdp?=
 =?utf-8?B?bkw0K1JsK0lFNnpiYWlRRTZLejlMR3NFc0doc2dGN3FvTkZHMU9MMS91Y2V1?=
 =?utf-8?B?WW5pdUVWbmlzZ0Qrc1FSb3lLV2tKeEZLbTB4NmVrdHJuNzl2OXNwUk9CbEVZ?=
 =?utf-8?B?MnppMnJrVFF5NVdqcE4veXRPOXp3dXpwenJPZGlCTnh4eXdFNFF6YXJZREt0?=
 =?utf-8?B?QnloVGg4Y1V0S3ZpWElIeUpEV25VT1BxMk1FMjNKemZudS9YeVlhTU1FdTZG?=
 =?utf-8?B?RU4vZVdxY0d0ZGQ4eFpLTys0dDVCWWI4UE1WeUpYNUJTVDFBSk1uZlRuMWo0?=
 =?utf-8?B?ZWRuYm5NdkJiNVRvVkxyZU4rUmJvM3BtN0RBRnZhL2VvQVhFMjAxc2h0Z1pW?=
 =?utf-8?B?L21mNGRjSWYyc3pPYldsTWZsT2pOZGQzeVZ0ZGludDJnRy9Seitad0VtWkJ4?=
 =?utf-8?B?WDVuODF1MWhPTnlnTm9xaDZKaktFYnRGa2hHbGVPN2hqUnAzbE5uM0R6aVgv?=
 =?utf-8?B?M2JZbkdoODQrcUJOTk5YbVRsTFBycmFNdDk2TlAvMm43cC9nKzBtMXBPcE1n?=
 =?utf-8?B?NW1jOEJidEtwRHJHL2FDOHJJcWY2clZJQU5YcmVWR1E3TEtMeGoyeG9SbzRx?=
 =?utf-8?B?V1dMUnFRVXBUeC9URnl2M0FIT2kxeGh0bWlxc0dQQVJLeWF0dkliNGtwbnhK?=
 =?utf-8?B?Q0tQWnFKV3pMQ3VObGpPUjBMNFE5NVVnZTdLd2RibGNMajJkTDkxaUQvajJI?=
 =?utf-8?B?T1h6LzQ1TzV5VWVQQm1tYXNsSWR0eGxpaGtlMDRCamxtUVhrYmRVYVVPMS9T?=
 =?utf-8?B?Z1d4R3lXZTZoV0FqSVY4cGNrSVYwZWZsVW84NG01dWxaU3Y3ajNjQkVoQnBl?=
 =?utf-8?B?eit4NnBhOWRueGhZcDgxSUNKWlViK2NVdFllQ2oyTUdlWkVxWTlCOG1Sd3h3?=
 =?utf-8?B?dS9ZSzB4ZXVjeE9rWm1SbWhndnIwejdEY2dyM3IvTTJ0a21KQ3hQNTk4eGZP?=
 =?utf-8?B?d0d4bGJCczhjNURqbnNocFNxZ3h6TDIxU0hVeVc3V1JyZXNCMHN0NjB5TUgz?=
 =?utf-8?B?Mkp0VWl5RDNEWWI0VFhxZEsyaG9lblZXNVkrNXdZYUZBbW84S2VWa2FxN1J2?=
 =?utf-8?B?YWE4Vktic2NaeUdubW9QL05vK1Nqd3VhQTJ5cjkvZmJuamtOTFJNT2E1OElS?=
 =?utf-8?B?a3V0bzRPaE16SDhVOGtJanJrMGxrZEpPY1ZsU2VTSjY0T0RIM3RjZmJjSlBv?=
 =?utf-8?B?aXZFLzFCWVBJTXQ0TGV1ZGhFWC8rNjZGcThTQndEeStuT2RKZ0NQRGY1TjQ0?=
 =?utf-8?B?aSticG1rdU8vUC93T0pKMTJIWVh6UWJLRUovZ29vRDFObGJYN1RsY1NWU01S?=
 =?utf-8?B?ZVpIRHZEY01raTRNa0NZd1lHeW8xMEUzcjN1RTcwcnB3ZmRNbmRTdkFieWFp?=
 =?utf-8?B?V3FFY1ZyVXU1NkNhQXE4MEl6SVNaYWdVRmR5UUZXQXovcEdmUWhHVGF5M0Mr?=
 =?utf-8?B?eXlqM2VVeDRlZEo1c0FRRnVNMHBqL3hjcllIbGVUQSs0OUtSSXBkTmJBY2M5?=
 =?utf-8?B?cWprSm1xVDlZZDBGVXBzL2t4aUROSTlPYWsxbWRpc3MwSlVPN010Y2NVQUJn?=
 =?utf-8?B?cFNXWDBGd3R5eFJYTWJYc3ZrbFQ2TzU4RTBCbXpNNmFMZGwwWHZSVUVYdWxn?=
 =?utf-8?B?RG83QjQ4dHo4RGsvOFVwdUQrWlJTczNNOFZyaGxKVDhLeWVJeVZrS2E2RThk?=
 =?utf-8?B?NEk1WHRXUFhjT0FqMlhuMjJ2MGtUVEg1R3pNWnZsRmZFazljNXFDNENBZ1ZQ?=
 =?utf-8?B?My9hbGppeXFxdm5WNjJ4VlA4MlBjUFF1YkNjbGpwcXVsTElXb0JUU0xvZVNQ?=
 =?utf-8?B?S213UDJ0RzZJM3JSYXJkbUpsS3dqYkZScGpFZkRmWDdIOHpmT0VxVWJKZUVK?=
 =?utf-8?B?OXJPTC92Rk5SV3NyQkhjdDl5N0M5ZWVFcGFGVnkzQVZkaU5GVkZ5ekJYRFpW?=
 =?utf-8?B?SE9ORHppd0VFazhsSE9yZjBBaUdYaDlOeDhSZHFkb0wzcmt2a3hVRThNSXly?=
 =?utf-8?Q?9cgusACCF2+GtJGPcfDaM7VEq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9010b3d-4e9f-4b0e-57ed-08ddc2da9935
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:30:28.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H+ch+QmQ11E3OVIipL57URCmag5z4NN5Dj8y8XPqAnBEpltmiKDZvhV7mRRQTC2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

On 12.07.25 00:39, Alex Deucher wrote:
> Power control is only available in bare metal.  SR-IOV
> will need a different method.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 5bbce8544fef0..e6613246d8b8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -241,7 +241,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	adev->vcn.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> -	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  
>  	if (amdgpu_sriov_vf(adev)) {
>  		r = amdgpu_virt_alloc_mm_table(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 6000c528ad6ae..732e9a9293d26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -220,7 +220,8 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>  	}
>  
>  	adev->vcn.supported_reset = amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> -	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  
>  	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 3d3b4254bd729..a137bef918ed5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -198,7 +198,8 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	adev->vcn.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> -	adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  
>  	vcn_v5_0_0_alloc_ip_dump(adev);
>  

