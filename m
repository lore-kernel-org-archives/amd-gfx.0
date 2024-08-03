Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794DEC3DA4A
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Aug 2024 15:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0864C10E032;
	Sat,  3 Aug 2024 15:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2vFqDP3s";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3B610E032
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Aug 2024 15:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MW2nUTQ3kXhmvF/Ldo2m0PmilXirA9F4hrcjbVaDhdudTuem6nRq57m52J/oxlp5KOH9tseAxV900Q44uf50Lz3ArGixFu5AWzPfzngZs5DNKJMR2B7Nu9dwCBWUho6Ea4VzNJ+heD8FFasMByx8YeKtWHKOrk5teLFeiAqWMCDTsztHG0CWPOc4xu8w279ceurZFjqDEcTG0HtLBKk4DyzI69I5dy5mzGoOkFhd4m1Uybw+Q+lLZB50OMXNCkS+rPZ2qQi2XNj/FYihaC/hN7hqLButGzLasCkLv6oyLO/tnt9e0sGqon3L7Bd2YBsTT9TQTTiF9cTsqhe3m1oZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhX1rQjttQy2FMVOh1O+qpBaF8nKyxJVi34v37zFMFo=;
 b=NVvmvmn/hjioxzd09WEcgEtiW1pRPRxApRt0xx/6qR/O953UnRy1DAlbm1y5S0dctdAxprbiVUaVdjF1PvGBf6YgACo6IkdMNwC9lQX3yvPRJSvHszLO1kHBite0CTpBVff2Fzc1Er7xCczBiYZY4hgjQtcHSaH7eX43qG8+mOrFj9OJwwfKpR5bt4KOunvhaM2V271xoxUsKRqF/1yNzl+GJMI2/A/4FO9nUsEDIEqYok3MW63C2+Vfiuae/bWm4ayseKH4/j+vX2SX3s0sFRfpkrui78MtZgxd5ujkwZ/27wrgCUqHHdwWwQNgZ0cIt2u0M6blbxG+Nz8fNag6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhX1rQjttQy2FMVOh1O+qpBaF8nKyxJVi34v37zFMFo=;
 b=2vFqDP3sh1LkMXhR4TwjGVkcsCyJBIBI92TDWWwTmntydnv2KBVvN+mhys5y3XiVwlpY2KZd7cNog2F0WeRdgQaO1T6cuTkNux6q+Ej1uW0l6iv2Hy5jYnXDdg8GCq7f/VT3d7j+lZO/57L/+nOJUfJrLtPgdWpjihqdp9UMQJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Sat, 3 Aug
 2024 15:12:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7828.024; Sat, 3 Aug 2024
 15:12:34 +0000
Message-ID: <df43ccef-651e-46c2-8d33-8867dc75a02e@amd.com>
Date: Sat, 3 Aug 2024 20:42:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: abort KIQ waits when there is a pending
 reset
To: Victor Skvortsov <victor.skvortsov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240802183911.322102-1-victor.skvortsov@amd.com>
Content-Language: en-US
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Vignesh Chander <vignesh.chander@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240802183911.322102-1-victor.skvortsov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 45528ab0-b3aa-4eec-4108-08dcb3ceb3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0hSblVmemZwUG9RbkZ1T1NlVmR1ajNrTXkrU2VuNUZzK0RxMEZkSW9JekZp?=
 =?utf-8?B?NEd4QmJLUjZVd0FEVmwxUnBlczN2Sk5sMnVpWTJSRFY5RG1vb1ZxVGVFMnZ6?=
 =?utf-8?B?WlFjdjJRd1Jmczc5VFo0UEFIaWtGMVpreVFjU3Q1N0lUSzZaTFJDWW5iTkVQ?=
 =?utf-8?B?ekFJTXNlRzFyMnZsUEVDNkxQRFVJSVEwcnNTaEQ5cFl1RlBCSjI2aDdSQ1U0?=
 =?utf-8?B?Q1U3K3EveW54RzNZNkhBaDlkWTVud2swR3kvaFE0S0dlUWQ1VHRGMlMxZExj?=
 =?utf-8?B?TUNNVzExcTAyL1NEa25VOGltWkZZc3JGR0xmRklBckh3Z3pzY1pWTk04SDVG?=
 =?utf-8?B?eW9kNHd4Z0lmZVo5M1Y1WTdzeVF6SmtaR1ZiYUlSNnZQMWJySFVZQjhQY21l?=
 =?utf-8?B?NG84dDVVS3lHWjVHcTBCdnZWUjdiNmxVTjFIYlp0cC9jS1Y5Rmh6VDNwckw1?=
 =?utf-8?B?cWhUeW80K1lEZlRMNmpjZTdKeVFXWkhVZ0xlWlNkNWFUdjhEZkxjYVNtamtB?=
 =?utf-8?B?enJzcWxYNUx2dUVSakI4Ym9RRWt0cDV4aWRlTFhkbitjYk15a1FUWHhOWnRN?=
 =?utf-8?B?SDdQSVJtZlBMSWkvenZESzFGWldISVhzUldsQXZWT293M0d3VHhsREdFL3NF?=
 =?utf-8?B?MzdQRW5JRDFhV3VxdWdzMFZBazRlaVhpQ3dRb2ZDaHp4TjRiVUZtV0phV3BO?=
 =?utf-8?B?M3NmWlVVczErSlFEaGZndlpCcExBaHFIVzV4NFJjZjZDbkZiOTduSDcxSDlO?=
 =?utf-8?B?NUU5Mmd3SFFCK1NTRFpFb0tONy94bnRoa2tWUWpiWEozM21zMlpFaUJpRUNO?=
 =?utf-8?B?NnhFR1NwdE9TcGkxdTFqQk4weFIrMXhVRjdFNDdvckVKOVVYUkVFbXpKTzU2?=
 =?utf-8?B?QU14cGQ0Uk5lby9zQWVpSFhoWDl0dFZucVo3WHZSUU13UEkwT2kzTlZoVS9m?=
 =?utf-8?B?Y3hMdExtVzYrT2diZEplUCs1M0dXRlQ4S1NFSnRvSjdBT3pVbmd5dVhSaHcy?=
 =?utf-8?B?TE1zWHgxWC9lRURxKzJmdEF2Rm1VWmRXVkc3YUYxR3NPdkJTR283NzFsaE83?=
 =?utf-8?B?T0hrc2d2V2ZPRE0rYWZpQ0F2VFh0VDI0S2JuMElXVVRGM3RSVXJTZW85b3NL?=
 =?utf-8?B?SmlNZkIxT2NiLzc5U2VDN21rRmhZdDRObTFNNHlUbUMvc3hKQytnMEovNVls?=
 =?utf-8?B?KzY4UXRXa001QlpYOVBlNEVNSy9pVU93Q3Z1akpkS29QNTJFM1k4azFzZnll?=
 =?utf-8?B?Y0s1ZVVSY2NtOTZOKzFBVk9qRktkQ1hHT1RYK01hRGRzS0JUSjMxeWM4Y3Bu?=
 =?utf-8?B?aFhoaVQwWng0REtmTmpuOFVVU3lYMmNMSysycWVFQjBaaHhZTkMvWVFXREY2?=
 =?utf-8?B?OWU0NjhqUjU4RnVvTHFBMnFQN3FRQW45bUlLMTdJekdhbFFyS1AyRE90ZGJB?=
 =?utf-8?B?Z3Y1ZUVpaW41WjRQdWYxQmhTT2JEa0xGRGduWlUyR0ZUMCs3cGx0UmdSUXJE?=
 =?utf-8?B?a0pCaXFCTGhOb0Z3VDFENDlJbWZxd0NISFZNYmNoSmgrakdyV1UwT2dxdkI2?=
 =?utf-8?B?VlduWGVGNHhMQ3ZRMFJrclYyVzZtVDlyWkVTREdVMjFyTVYzSmFra1A1Vkxx?=
 =?utf-8?B?OStGZHNsY3p4VThzak96WCtUb3E2NmxId0puNWV0dVVUcnFpK2p3Q1NIUHIz?=
 =?utf-8?B?aHAyRHI4WmpDSnhWYnN6WkZCVGRjMG1pN0dnbDNxa0M5VVJGSDFNVktZT1lJ?=
 =?utf-8?B?MU5DK256MWM1dzFCUFdjZTJVbVUrMFVtUzNSdUx0eVNkUCtGejd6WUcvL1BB?=
 =?utf-8?B?OEs3RzMya0ZmRXBnVXpTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1VTaHNqM2NzdEVSVWpuSm9WWDVGb2U5bTR0UUlaNFZtSi8rbG1UR2dVOWFN?=
 =?utf-8?B?NThNM0hxTXFjdUZHRldZek90d2ozZWcxNUNMZHo5OXRNQnZ6RlRTRkVxWGNj?=
 =?utf-8?B?NE4rKzVYdVd3UGRjQkFReWVDMnlKYU4yd25weUw1T2pkdHU4bHh0WmJidXFC?=
 =?utf-8?B?UEgwTWc2anZtSm16UTlxbmM2Y0d4MGpkT29Kc2w1MnI0Q2xudUQ5N1pkdHd0?=
 =?utf-8?B?cUw2ako3UWVaUThmYzlJMVFYMkhlN1AzTDJuY3NwLzA3YnhxeTkyS2pDUmlD?=
 =?utf-8?B?NHRKR1VEOEo4QUhoTXNZQ3VZQTIxSFQ3dGZ5MldyT2syMkNnYUZIcGdmcTdy?=
 =?utf-8?B?V2FRaWNoOWRMMXVuTW1oYnRobWVrNkZPY2h4TmFjdmxUS2pnZ0VpNjJUTWla?=
 =?utf-8?B?V1g3cHJFeldyZXRoc0d0U3o1VXppbkI1enJzSjJUMG1sdlpYUmVpeS9Na2Nq?=
 =?utf-8?B?bjZydXYrQjBRQjhsckZIdDRuaHMvdWVjM1NXZENJUEZpS0swN2hpdU4rUTRG?=
 =?utf-8?B?a3VreThDd1ZUR0FzdVJHejh5OVpTdDd3bjEyT0VQL2szY0IxbGd3WHNrZ0Fq?=
 =?utf-8?B?bktDVFJ4OUhleHNYb1RXU0ZXM0VtTWxxdmY3Yjh0WjFlQWYyaXZoeExxYmNJ?=
 =?utf-8?B?WVVCV1FQcFhWUTJFdkllb0p3VG9FZVlDaE5pemlpVVplSEVGQnBYQ0gwdFBu?=
 =?utf-8?B?YVRqQXBvSDhBeXZJOGw5OVl3VG5wVXY0RTNwaHYvOFBWOUhSakJlTDlJMHVv?=
 =?utf-8?B?aFBGTFc1Nmh5dHRkQ0JTaDFpWEwvSERFUFBYYXQ0ZW4rd2Zkc0RmWm5GN2li?=
 =?utf-8?B?MHNJNXlSVjU5M3QzcnNGVUpCLzA1TFFsdGRPbHlZbzgvOGRmREk1cC9IU0pE?=
 =?utf-8?B?M3lVQlpUZDdDaUt2WGRnYTRlWVdxS0FRYWhaNi9LbHZSTTlKQnhzSGJoUE92?=
 =?utf-8?B?cDdsU0dEbmlzeFhNREpSRnNkRTVLdjNUbFR1b0luRVVZZlRGaGE5ekVYYjA0?=
 =?utf-8?B?QVFhdWFBdmNZWi9ITGRtZXFNT0h2ZXQ5RTE0NHhVcysweXNjNjIwa3doQlU3?=
 =?utf-8?B?STQ4YlNtMW8wTmVnNVFYTG8rQVptd1lSVzkrbDFraUJWYzZ4UFZlOGsxcitn?=
 =?utf-8?B?aHB4UnZUTkdZdG9aRnFkRFZBcXFWMXViVjRENCtFT044RmF5SGw0S1ZRUGtS?=
 =?utf-8?B?ZFduaEMxS3JFdjBIWjJLTnFFaEFSUnlRTGlVT2ZDbzRRcUtVUkhvQm5LdmFX?=
 =?utf-8?B?ZzlZRmRyLzZCeVR0Tkp3SU1BZ1RFTlFRdWJMWHN3Um5IRVNPSllJemdiQlFp?=
 =?utf-8?B?blNFcFNCT2hFNGtEYlJBd3JZWG9lTnUrV0QyNnhHcCtvR1BWOTdtdUoyWHZ0?=
 =?utf-8?B?WnhYandsNXZxUGpXdGQ2WmxvQUpJaDVLK0IzM0tRRUJYZ3gyWDJrbHg0aG9x?=
 =?utf-8?B?bU9vL2dOQitITHN4bGovVjVkMXlZbzZwV0hpcFpBYi9FOXN2YkY2QVgvUitr?=
 =?utf-8?B?NTNydmcvOXREQWxtL1dXK1JrUkhRMTNLSHF1RzFrZWovMDYzQ09IMXFGelFR?=
 =?utf-8?B?d3U0bEZVOTlmMThYWkpXR3pJM0xBcVF4SXFwT3hoUTBtRlR1TVBBL2ljQ0FJ?=
 =?utf-8?B?VEgrZ1pRUC81bURsUGpnd00xeXNqeGFIbyszL0l6MjBqOGhrR2dmTXYrNys4?=
 =?utf-8?B?M05iQXcyTW9rQWd2TE5sQjYzVUVsWitKWm5XUGYrUFZGUTdkMmJMOEg4V3Qz?=
 =?utf-8?B?SVd2NmJ3cW9va0pVRFgyVm1SZVNJdWNrQjJSeFdxRWh5dVVsbTMvbmxnWGJ3?=
 =?utf-8?B?SUc2d0NlbFdJM2JGR29SQ2U3NUQybEM2TGRKcHlYMENUUEVDTnE3T0ZpMU1O?=
 =?utf-8?B?UGpqRm9hS0VhbStEZC8wV0dCaXNYTVFFdSsyaVN5VHhENzlXQWEwUnY2L2Q3?=
 =?utf-8?B?dTdMbnM3Q2pBRWxrbDVpUHEydnBSMVZSTGlYNDBtcGFTMTNFeTQzNEs2MnF3?=
 =?utf-8?B?M0lXQmVLYzlHSUZWNDljeHVNNXRSLzNBc3FKdkdZb01tTVhScW9UckFyRk5D?=
 =?utf-8?B?TXBpb0NhQktweU9mQ1RVVXhvbk8veHAreTBzUkpFNUlLSVdUWVZxZGdCTFlm?=
 =?utf-8?Q?u56DcWR0VnayVVgnuwGO2YvV+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45528ab0-b3aa-4eec-4108-08dcb3ceb3eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 15:12:34.4475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GURB8c6Trqslqf883mGtR+7TZflQK1tKGVBCuiCjUrUcR1QE4Q7/MOPQpENj4vr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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



On 8/3/2024 12:09 AM, Victor Skvortsov wrote:
> Stop waiting for the KIQ to return back when there is a reset pending.
> It's quite likely that the KIQ will never response.
> 
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>

Copying Christian/Vignesh

The patch is originally from Christian. Please keep the author as
Christian and you may add Tested-By.

Thanks,
Lijo

> Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c02659025656..8962be257942 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -785,7 +785,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>  		goto failed_kiq;
>  
>  	might_sleep();
> -	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY&&
> +		!amdgpu_reset_pending(adev->reset_domain)) {
>  
>  		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>  		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 4ae581f3fcb5..f33a4e0ffba1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -136,6 +136,11 @@ static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
>  	return queue_work(domain->wq, work);
>  }
>  
> +static inline bool amdgpu_reset_pending(struct amdgpu_reset_domain *domain) {
> +	lockdep_assert_held(&domain->sem);
> +	return rwsem_is_contended(&domain->sem);
> +}
> +
>  void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>  
>  void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
