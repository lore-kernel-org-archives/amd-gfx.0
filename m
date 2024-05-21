Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD2CC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 08:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E574810E04E;
	Tue, 21 May 2024 08:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8TV5A4O";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893DB10E220
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 08:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1Qto3ybk5gLIpxdSlUO7YlK9Y5kzok1hWPiwIf1dnbbcv1vh6ng01lYsBUQaS+4vRsvJHfWpiagAWNDQK8sDPrMEQOfhjPrMZEHCnW3yMR/ozUpvd3WZHeM9riYaNvS0GU0dDe4vEJsEdoxtZkyPm5nUNB0GFQuJ1LWesq64pb/6VUHho/EpGXBkmbgxCJsWV+EODmMIhDTm2wEsyp3PpR+dhXnD29CbWr1c9JwOKRzySyYYe2EaoSD19lXx2NrgOm+aIYYfxx0KjNJmz9PUEjAyrzjuN9XSMdQ8BVX6sav/LV+DzsswyHqQxaCxHsplbh2iPJBlcy3UNfuBDt5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8GuYjD68aZDQLFWcl4+pokW6af/LQNr5sIvwS/rWYw=;
 b=XgNk/SES8EX4UJL81gCIxz0wr5hbOYXl4dWUUNqotNLjoMsZHkUpuCeU2dU81ZOuXdpBzv6xeBqH4yHboae063gP5XCqZAAvYEdSBF5nEgV/O9YiS4pSdpDr3wZh2abJICxR2iGiH4F0nCrL9ZgFSV0IwxRVlQXzMWxl3OIS2kWa8m+4AeyaTyW58AIygRU2Luauq1WqEl8zJNPi+p737B00E1rb2n54IvP+voLwqMX/R6fZ6uujtZPb8qA27z/HPqYuFbXaiofSj3r7ij2G/IZZcFZaxxERvrWUCUGJVXAMGhBMSth0IrZngosfVSK9tb6dOhCHQMupw7GsgSN4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8GuYjD68aZDQLFWcl4+pokW6af/LQNr5sIvwS/rWYw=;
 b=s8TV5A4OmcvpnS3dQ6jNa23k4QhGDHMDGFicj2xnGhyHBNY5zKWmPQqyBT30HEGymYLZHiJXJ0zv15fyPKTZ9rfBwZ8IHAsDIS7n+cxDFXdYoX+vtzXmVGyvC4P3vBb4exGy9l/3dFSFzqu5Olu8qT7y0hxb6goBwqS+GMqsdIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:20:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 08:20:24 +0000
Message-ID: <1d4223d3-b4e5-4c02-8da7-ab87406d5cc3@amd.com>
Date: Tue, 21 May 2024 13:50:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com, Lang.Yu@amd.com
References: <20240521071615.371277-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240521071615.371277-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: a7073a8d-a104-495e-a2ce-08dc796edd01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDlXbTcvM3pyUFZlem9KYWFyQkV5V0REZnFjSE4xcWRCbDF6aXROMzIrQ2pp?=
 =?utf-8?B?VlNtbnJFaXBUckZyOHhpQzFsZ3pGNDVudXJxZ1k1Tlo5TlZ2S3JrZnJnL2Uy?=
 =?utf-8?B?QStyMXByQ1A1ZkZmWnpjWFg2MlhMQUdkQXBVZU1HY1l0Y3hRbHh3Rk1JbEZX?=
 =?utf-8?B?MUVQRjlGNFFLUGI3OHBNdnA5SVVSaVRtT2pSWHBLWE1hUUxyQVphN0ZoUFZs?=
 =?utf-8?B?a3N6ZXFYVEYvSjdwVzRzWUdDcVhZVFRSZzBaamR3dEhZeXFEQVBJbGhLSlht?=
 =?utf-8?B?WWk3V01pbUNpNUdIOElOb1AxZGs1bjduMWJOUTV6Nm9YMm41ODVIekZSaDNF?=
 =?utf-8?B?S25QYTkvR2xvbjZYeDZidmVBanA2MHFxNStYbXptM3BQSXNpbXlZaHhHSURu?=
 =?utf-8?B?RENUdDJvbUdVMXVwVVY3QlhzSDJmSzdyclc3aG5DZkhaRHJ2MGtTRU5IZmR1?=
 =?utf-8?B?WnZYRnRld0VOSkd0WkIyU0I3VU5KUE5qR2hFZjNDU3FXcTZwQ1ZvSVBvM25q?=
 =?utf-8?B?aFpBd0VtK01yc2xtcVdyQ2tteFo0UVNFZlQreXJxOG12RnBCN0FkdWtxTEVT?=
 =?utf-8?B?NTkzZnpwY0lubEgwMVV1b1Y1MmFuNm5UazgwNzBmb2RRNk42ZWxIS3U2Zzc0?=
 =?utf-8?B?MCtPZDRvZXh4QTF6SFNlVUxMV2FieXpoWFRTdWdVVk9KQW9wM3BoeXZRUEtO?=
 =?utf-8?B?VGE3WkpNVTVSbFEvSHQ4dFdZYTY1M3kzaWJWajNwdStDUnFKVnVlRHRkWWxO?=
 =?utf-8?B?WEZEaWpyelRFeWs1TnhOYnArRFNCRTlOa3AzTytTR1lBOEJaTnl1ZmdCUW5s?=
 =?utf-8?B?ZFNmMCt2cWNnMVpiWVhYbEEzZXFYRjZXT2RhSkdPa20ySEV3dklMRDJsTTR2?=
 =?utf-8?B?V0c3K1dTT2FGcEJsdWYzbVJOMmEvR2ZJTE9haVl6SXdjdVhnM3BiZlppS3F3?=
 =?utf-8?B?aEhoSkZtKzFkVUlmL1VodmVBZFFrb2NYTDluVHI5ODFtdVE2TW5PdCtEejNh?=
 =?utf-8?B?bi9leEQvZ1ovUW5KVzYrd1JTZGsvcnFKRUZoVWRud3dRZE5ERlNRSmF0ZEtR?=
 =?utf-8?B?UEFxMzFvNm1NdEk5Y3U2cC9hd0pCWlM2L29UT3graXJJdmFIS2NscWxYYVls?=
 =?utf-8?B?TVR3blUvc2N0R1Ewa0tsRWRBNW55R3RPdkhDUFN1K3ZUKzYwOWlDQWl0ZzB4?=
 =?utf-8?B?UHVrYnFqV2RIOFhpcWQ5dEZieThuNjlUU3FWWW1GVEorL2JTbk04eHcvR2hQ?=
 =?utf-8?B?Q0VvS0FEQ0pxUTRaRzNFNlVmOWlXZUdMWkNTL3ZHL0VNNmtyMUVZSnJoZ2Vh?=
 =?utf-8?B?U2I4TmFKOVpIY3VVU3U2dllVN1Z0b0NJcDRWVVcyc3NhQ2RWeEhHaWt2QUI1?=
 =?utf-8?B?Z1Jsc3Z6dy9SdGFEM0J3Szl5dlZDeHQwTzhNSTlOdWFiOXQvd2JZRlpwWVBy?=
 =?utf-8?B?OFdRaGYxUFM0cUJVZ3FjNWVzK05yTDFkWE1xRVBDZnNhd3hnM1ZxTGNZaXB2?=
 =?utf-8?B?b1Z1VVBmYlhZK0ZaeWgyTzY5RzNRbDJhdEtad1N2TExjT29EaFNjOFByVDla?=
 =?utf-8?B?SW1GZ0NGeTJLUnZOcnoxQVJXZi9pOXdqZHlCRjVORGlaWUY5YUh4bnZuaWlx?=
 =?utf-8?B?aGNNRUR2UU9yV280dEJzeDlScDhGaGM4VExtSWdjM2pYSFlnWDBQOUpUTWN6?=
 =?utf-8?B?bFIzUWVqRGgyTitSSUsxK2xVc3QvNVRqV2xyRTc5MUQ0TTNiejROMjdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVE2S3QrN3hMbUREWkxuMW00K0k5UTQ5eHJKb0VoTVpGQUpEMUFBVm9ON2Jw?=
 =?utf-8?B?eHo2OE5zVjlHcjNxVk9xSDYyNkx2VVZ1WEd0OThBZWE4RDNQTExyUE02dWFF?=
 =?utf-8?B?ZjBBWFB3VWFBbkJLcjVZcXU2Y3dicjU5VkF1cTZWdWZiMEsrSlMxMWQ4c3Q5?=
 =?utf-8?B?YWx0a2tubFN6ZGdJOG9rMmJaakhna2JNN2tWSzVTS1YrTlRvVTBmMmU3WURL?=
 =?utf-8?B?VDFmR0prTEwzKzZidDgvK3JOREM5WUJ0Z2dqeHh0aHduRExjaTdYM0g4TkZR?=
 =?utf-8?B?cHl0WjNObFYxT2NSemFvZGNETUg0VHV2UlJ3MGRCWVZ4c00vVmcvTEhCTjl5?=
 =?utf-8?B?OWNDU1RLa0tFZ3ROV0YvUTAvdVl3Qk42Y3VOdkgvSkhJNk5xOXh6c1FnVkg0?=
 =?utf-8?B?bzVVREt4Ykx5eEphay9CYzdFdnJYYUhLSW5iWjFBOE0ySEsyOFQra2VvN0tO?=
 =?utf-8?B?MlhGc0YvVkI5aTNML2Z0ZFo4MFArQWVGR1ROdXBscGdldmVHcndGbFBpTVBn?=
 =?utf-8?B?TE9FaUVSWmpaZG5FbFVUOXlVTVJhdkhYMjl4NlphWlZnaUNFT2JlYlJrLzN6?=
 =?utf-8?B?bFpBMFJWblJWTjQyV29KbDY0UFNnNmZnU1Q2aW45elF0ZU5iakFYekl0NXA4?=
 =?utf-8?B?NU0xa3oxeVFKdFZqeFZxVWo2QW9NYU9XajFGd1VyeEdOKzROWjA1RzJxU01Z?=
 =?utf-8?B?TlJnZW5YblY5UmV5ZjRlV1pyczh3SDBnWDV0RHZVVW1CVHFuQmJXVE83bVdh?=
 =?utf-8?B?Zk1pZXlkdWNFN2k4ZEZHbmt6SGM2eWdyT09ta1oyY2luN0FLc0JCVWNDa0M0?=
 =?utf-8?B?NTFGL2lFSWU0K2hGdEptbkwyQTgweU9FSlVIZHhjblgwTTBabU1IVklsek5V?=
 =?utf-8?B?M2J6OEt6KzJEMGRIQ0sxbDB3S2xLZkNkcWxaLzJTL2lKTnZCb2tSU3Z5eTUx?=
 =?utf-8?B?MHovL2pvQndWTWlyTjN1U1kvVG92U1BxZXdLZlAwR3BZczAxc29RR0l4cDZF?=
 =?utf-8?B?d3UrZ0EwMEhnM1YydW5GaWwzT0FSUWVRUGhYYVV5Qkk4eUxtblhIRTBSSmxm?=
 =?utf-8?B?Wkszb0p4OUdJQjRXTDFQWkZnMEpGa1VTRGE1U01JbjBkS0Y4YnpPci9XQ2ls?=
 =?utf-8?B?dE9WRWlpZmp0Q3JOeDJoOHEydHBHYW9HT0QzUjhoaG5kSUJuaDU2NDJ2dzJz?=
 =?utf-8?B?Z2pnM0g0OXlMSFpPb29wZWdjaENOUFJCanBnZk1NTnpheVF0aU1ONmVnTE53?=
 =?utf-8?B?VjVlc3J0eTU1b1dwd1dDSXJLRit5WEV4TWM5ZVpTWkNUTmZpRy9uc3F0aUw2?=
 =?utf-8?B?YXdXMS9VWjhXK1BxMTh2QzNsQ0drcGxxOGhYcU9HN2ZjUFp6di9Rcjc4VnJw?=
 =?utf-8?B?MEdidHRCeWNhSGdSSlNOUXl6T0g2NzNqTC9yRTNXb1VFUTg0ZWxqQ2Y0ZTVa?=
 =?utf-8?B?M2dieHVKdTRseXh6b3creDltTHdmcUFrWFUwYkpKaWpXRUlPR2lqWi8zZVhj?=
 =?utf-8?B?cVEwR2h6Y3d1WkIzTHl1ZVArK0p5OVlrTG1ObG1mZmhqL2l4UThrbGlyWmZ2?=
 =?utf-8?B?enVuWU1SZTBjMzJZbkZYL1JnWFB0aUxDSzZCWXBIbnhQQkkwMHNobVVMb0N3?=
 =?utf-8?B?NDdsQ3g1bDJQV2hwcTA2bXliVUFDQ1NDVWdsWmVhcVFDcS9veERFdG56Tm1r?=
 =?utf-8?B?UUlCWUU0aFNUMHRwU3pTK3RPNTlKbFpONnI3eThETS9YdllRM2FkVlVVbENE?=
 =?utf-8?B?aG8vTGpnQ3pPQjQ0ZjF3T0t6TytMOXlVZzRrN0l0SVJnQXVmNWM5WUdKODFa?=
 =?utf-8?B?TllKNjA3bUNBaHBSVUF2U1ZzemZ6WFByWFk3YVhyZHhWclBxNVJWSzdkcjdi?=
 =?utf-8?B?bkVXNFQyMjFxMGZZNHAxbzVDanJFY2psVE83K0p5TUpCVXZhSEtuVHNGZ0t3?=
 =?utf-8?B?Y0V6Q21URXpmOVEvTmo4UVlmamhMcG1jcisyK0NkNnJQTC9iRFEvdVFiYmdt?=
 =?utf-8?B?YndRNllBeWs2ekdKVjR4YlFqKzJOWHBFYy82em0zSGt1Z2Uxb2c4TGhpZloz?=
 =?utf-8?B?L2Y0STB5ZWdQVHVvZVBrcGZvN2JQZFp6WnhQektHcTJkUmJmelUrNDI4dDhh?=
 =?utf-8?Q?Bev4JbmS5bvfiRUyA4wvKXkMB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7073a8d-a104-495e-a2ce-08dc796edd01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:20:24.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7buB0AuCUs0xqhsMSmdLF9NDie39/wzTsS1sqHbpPQ3Zok92XIaD3L6UUDW6Nrs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834
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



On 5/21/2024 12:46 PM, Jesse Zhang wrote:
> Since the type of data_size is uint32_t, adev->umsch_mm.data_size - 1 >> 16 >> 16 is 0
> regardless of the values of its operands
> 
> So removing the operations upper_32_bits and lower_32_bits.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> index 2c5e7b0a73f9..ce3bb12e3572 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
> @@ -116,9 +116,8 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
>  		upper_32_bits(adev->umsch_mm.data_start_addr));
>  
>  	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_LO,
> -		lower_32_bits(adev->umsch_mm.data_size - 1));
> -	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI,
> -		upper_32_bits(adev->umsch_mm.data_size - 1));
> +		adev->umsch_mm.data_size - 1);
> +	WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI, 0);

cc: Lang

The original programming and the new one doesn't look correct.

I see the below field definitions as per the header. As per this, both
LO/HI are 16-bit fields.

vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_HI__MASK0_HI__SHIFT
                                                             0x0
vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_HI__MASK0_HI_MASK
                                                             0x0000FFFFL

vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_LO__MASK0_LO__SHIFT
                                                             0x10
vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_LO__MASK0_LO_MASK
                                                             0xFFFF0000L

Thanks,
Lijo

>  
>  	data = adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ?
>  	       0 : adev->umsch_mm.data_fw_gpu_addr;
