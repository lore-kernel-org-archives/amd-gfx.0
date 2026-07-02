Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE2FC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DCD10F281;
	Thu,  2 Jul 2026 10:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mqg++hlw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4697910E492
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTZiNGi7YEEqnxnXGza+boNA1Nj51ogVDVywCdhLWH5lMIyyGQ/RAA2YmIhmx6bDKAtX483INPUV388xFJTC0WPwUZ0t8zzlYVlZK1lE5c6UYLfbmQzxmhGtvDh5JIftc3gbalSxwlSBeZ4Hok6o+Os7C5qvOctiibimDmW+qRKhUaATntFKCGxHQpeArfx2RBuxuVT5Yy55F7LWvHANPjYxGWIpD9uLFkaDEHLJhj687VR7GwrxayGBIGDsKB9XN9ijOW86XWAuEyPMIBvgsY7NBxVudPGVJyGtuNYOu/sSlTfS0BqX779g2hwsXQdsEB1rU1mRR17moith2XRIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6CHe+V+XHyOwFfzSlVuLHPGScDPD1vcaBoWEfgJXac=;
 b=CEoX8hAZWhTNTHpaxTcBNgAD3wmWx1h+cP9Xj+py2YN5zvBbzvTB4NtdJUNYJsFLCgW3fcZg7KazlKaavc6HpxkPLo68jJ12m8ndXuQ1etAQj9XrYZhyuWu/VbVvkDYrnJAW6Bv5FH8XrI5yTwgf8tmzB2CjTr4QCw2py7/relS89cu3crr8eTG1Zte7H7ujjJbmDBdb6Bg9/6FBuwLCB8NIEO0bAFAWPdgZCkjBAtQ8al63x9K5GDlulkn0kmcLpLDke111fbNISAIUN1fl/HLv81dEEoN/7wkhmB2XjimW4d11Nw03vRAo49W7wBom3LxfIkviQTAHVUVv/Okg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6CHe+V+XHyOwFfzSlVuLHPGScDPD1vcaBoWEfgJXac=;
 b=Mqg++hlwCxCK4Gw+ZcFGhQ3MUo/azBTOxlfOlCfAFzdrds35H4wSS2yAHr9ozPlTyFh2T7OmTyJ7I+vqM5iLwp7hzTipNxKqJAZ0gTYISY2D6ER4UQ0ec3io1Bn3kBbHxFJnEkl6xvfCCZLK9V9WpD5ONPLg1vtlwkeKcmHwR+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:17:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:17:10 +0000
Message-ID: <7ebef720-4d59-4cb9-a0d8-a376113c199e@amd.com>
Date: Thu, 2 Jul 2026 12:17:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] drm/amdgpu/gmc11: Pass cam_index to retry fault
 handler
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-8-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-8-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: ec25cc93-aa50-4e49-b299-08ded823140a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: bNc9jULn4X0sG7WyKhVkAHZ3OIqlnsSy2+g/VIZLw9WUCpi27ffSRJd0YSspgCjrRLrMUOYSQRWBJ90N4z2Akl1ZGiIVkLnQ8LwsNSOE6IMFJN/uhtZUWrSgfkAs08dl/gQ0nyjx1cCcu6FUzxdtWS/bmxBCuJD/yYyPwAGxWZ6VbytnIK5D/3o12x+Il3UV6N+48JYrxxvFxe1MDZ9+StgKTWIW+wCcectn3ZQjqmAj/9M/CmxYw0yw7MgVBh9woufI2XTKvt6mk3hKUtZIF0YrS2kdj1LiidT+p/ICuU+4v2oQFXE+71HaXRRPplCC6eukH+Ehzvk4qEPcqsXuJMbELkYgtwykSROlN1FeiQOOb0Raz8UxWGLB4s1r4qIAFbs63AewDeMNyksufD7k5fO8+36CtzJTUpCyt5mEsJ4XUbePRa4uqpXnml24yFd955Bu3I3bW1gTb0q5PuLEbJO7c68yZ+gEpdnNfptXEA5qOF702m8VN4rwdoM3iJU/1mK+euHM9JhLJOkjG2UcU050bfCICqW3nmNqHmxnBq38nRgVuTgPxPULPmEmYQ9gwIx3RHhG4lj8u48mwhsF9cGrTcQgrZiiNDxE8MKLC5Lw8bDotlXoqIz/WeZwl9/1sOL+U39/o6E6EICAfFw+1x4pyck+Zmw+ZV0z/8V0DgIHXctGBzpIvcGnRvpyw+VY2kKjNNaV1cbvpkDTWzyIAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy9od3BSbHFnRlFZaVZJbFlCTDNsSzlzS1ptSkxQYTdKNWFqZXlnTzFzYmRP?=
 =?utf-8?B?TWMrSlhEZEwxYk1wcmh2ZEhrR1hRNU56VXJZcW02M0FNWjc1anpHOUttTE5O?=
 =?utf-8?B?TXdPYkN3eUdyTmhJN1hRS1VVQ1JJWFpQWDBUcmxBMWJWOVdhZlhLWG5HbGZi?=
 =?utf-8?B?b0dwS0NEZGordXY4OFJZcFpUeUVWTVVnelNkVE1hREkwYlI0d0EyZk1tSGU2?=
 =?utf-8?B?dUJCR3I2VThiTzlvUUpqMmJrL0dLOXRSd3o0SkhHVHFSQlFMKzNNR2xGY3o0?=
 =?utf-8?B?ampzMktncUE2R0s1RGd4Q1ZvZXlmeGlNYTE1ZnBFcXl6MTl1SUo3QXBHRUxl?=
 =?utf-8?B?bUd0Vzg5TGdpNUR0NStDSjBiN1dGelMzV2tabnMzMGk5Smp6aTVvb2tFaUxn?=
 =?utf-8?B?TkxKVnEyakR5QjZveUtEZmluQk4yTEpaMHV4d1FLUzhMaDBEbVFVNysyQzZw?=
 =?utf-8?B?SkRxd3NHcTd5S015L21Bd1FBMFVMTE4xcG1uT2tuUFZDdUpQVmZOV1VtVzUv?=
 =?utf-8?B?R2U4QjZJa1l4MUcxMTAwd25OU2FsSjZiZHpueTZYRCtzRitmQnp2UWU4NmRo?=
 =?utf-8?B?dW40dGYxSENKcVBGV1ZaUXpvckplL2hHNjBQV01RK05ob3d2ZnJZZkxySU53?=
 =?utf-8?B?S3BSTk9seW9USmNTeTVoeUVrY3p6WmZjVGFnclZVaVFiMHlFdFp4aStqVUFt?=
 =?utf-8?B?VUx0TnJzZmNCaXdxaGtEUFhVTHZPRHppamY0ekt5bFU4Mm9vNGlodExCOFVV?=
 =?utf-8?B?cjhaVGdKbjd2MzBQRVNMTnpvWEh0UUlzUExaajMrSDFneElpVW5UVXMvUVVB?=
 =?utf-8?B?RS9aU1YxN1JpQWFqUXJ1RWZHRkczMXBSakk0RnpmNHJxMWxrUWswTzRpMTJW?=
 =?utf-8?B?ckM1bE51eDJldUlSUVFqMXczcjlVYTRxY2IxMGd2ZjhDZmErOGRuVEVRM01N?=
 =?utf-8?B?d3dNWmxhMldnenp2S21oN1VwT2ErSGJvY2h0bHFQNExVenV4ZnpmVmpBaEh3?=
 =?utf-8?B?aEVmbnh3d2twOFRCRGl0ZVFieE0zSi81V0MrdkVUd0Y3bUJLbW5NRitDbGYv?=
 =?utf-8?B?TjFxUTBDVGl0UmVsNmhvL0V1M3U0c1BOT1R4UHZkOFZDVWc0OURJYURaUlNj?=
 =?utf-8?B?MlVNU0IzczA1YnZuSHlkK1VzRTRNbzNGQWRkYUtSZTlMTTdhQjZLaXViYkp0?=
 =?utf-8?B?a1RERnVabUZjQUQ2a1gwTlA2aSs0TDNzbGlkckU4KzBya0xZUnlkYTcwZDQ0?=
 =?utf-8?B?UUgvVGRlbXBGOTJPUDZITHlDaVlGTDZPT0N0TmFZUkx4VFNvbnZGSTdpOVV1?=
 =?utf-8?B?d2Zzc3RYUjM4WGloVktuUUREdmFrbko1dDlMMlkzVzNjSnZvMXRieTN2amRr?=
 =?utf-8?B?Z3dGOGZrWXYvVlNjcVV5YmttUjhzMnAzUEd2MStkM0Z5bXhuQUhSYy9yUU94?=
 =?utf-8?B?bnBYU29XR0VCWC94VUhDc2szSjJnSFdtVC8vNzVvMDUybE1EQ0RRUG1mc3NY?=
 =?utf-8?B?bnpEK2JJTjdyRnFrM0RiQ1V5MVNhUys3ektKSUVoTDdsVXJuTW1ySWxBTnl2?=
 =?utf-8?B?TTdvempVSGVUMmNveTVJa3FsaFhKZEo3OEN4US85SWtCVEJpZ3dyNFBjcDgv?=
 =?utf-8?B?ck9NTU5yR1d3WUxGMExjR1luZFMxazhyOTJuMGc3dlpXVlpHS1cyQytMZ2dH?=
 =?utf-8?B?UjRWRzNOZExSUitQMk53K0tZejFJdU00K3BKNVVuWDBvaGVkalFudmtTSy9y?=
 =?utf-8?B?UE5EcnF6UWwyR25YU0dCeWh5ck4vL3JscjRRbXdxY3Bld1NObEJIR1dyVFZO?=
 =?utf-8?B?QnJmV25mN25HUFhDUy9wbjZVYWcxeWQyUGxYK3Q3QTUrbm9GMWVyUlNIVDhq?=
 =?utf-8?B?andZM2sxZDdJZzdEZXJSbGRzZitKbEQvcDQwMU9YLzFvRXh1TXd5cGdlSEFh?=
 =?utf-8?B?MmxFakowZGVlQlFrakpVVFIxOTR5KzVvbnNnd1BSQXlGQm9WUi9tNDVyRjBv?=
 =?utf-8?B?K2pLV3YrT3RCSVM4R3FsQWtIdllZWlp6VU9yK2hleXR3VU01VGFUZTE4UjBV?=
 =?utf-8?B?Y1ErVWVNb1RZU1JUME5CVktFK3dKTWRKTnZLTkp2blRXQXRQQitMN2tHS2pO?=
 =?utf-8?B?dGJZY082a2haVWl4WmVVcys5czlyL1Y3aXNhOGxPbnQ2Y2NXRmI3eG11cGJU?=
 =?utf-8?B?YTlwRGd2MUhkenIvQkdmdC93aDZBYXdBQit3UkdrR09ETVBsTVBzOXErUXQz?=
 =?utf-8?B?cmE3UTI2ZC9PbnZLb29reGdYVTNQdzBINjFPamFwRlNpVTFpRCs4SGljNXh0?=
 =?utf-8?Q?5Cr05oyq+pv+OE1a/u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec25cc93-aa50-4e49-b299-08ded823140a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:17:10.6416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0LFXYQBwFdPoj9NubRKVSKS0oPqCsxmvXPBvEypzi730GwpBsNS430DGk0AbT0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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



On 7/1/26 18:17, Timur Kristóf wrote:
> This is necessary if we want to make use of the filter CAM.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index c40d9c467204..18a53b9df77f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -108,13 +108,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>  	bool write_fault = !!(entry->src_data[1] &
>  			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
>  	uint32_t status = 0;
> +	uint32_t cam_index;
>  	u64 addr;

Please declare "int ret;" here instead.

Apart from that looks good to me,
Christian.

>  
>  	addr = (u64)entry->src_data[0] << 12;
>  	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>  
>  	if (retry_fault) {
> -		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
> +		cam_index = entry->src_data[2] & 0x3ff;
> +
> +		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, 0,
>  							write_fault);
>  		/* Returning 1 here also prevents sending the IV to the KFD */
>  		if (ret == 1)

