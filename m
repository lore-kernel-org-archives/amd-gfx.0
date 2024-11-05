Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B5BD1CA11
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 07:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A36010E525;
	Tue,  5 Nov 2024 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HewC2DyB";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92BC10E525
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 07:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5TXuM6TIdEVZVevBLhG0BOJiI2svSf9tvYHj0QaHWwKeRWC5LWxdNYihpYStzwpexEpg1KFn6g3q6TomD+ee9HIcssltYWRBJIeM216K6K6A9BZv/MeBUrwwzuEdpulPRdkE5qakbkDvgZCf3f83Dx1+ODTPH/rIBOCZmZKomPiDwCHHgxDSLBWOW0rB8l5L03Qfa9hJiKpbE5ZoUIL+5isud4g2pUqQ5wzqnTx3lRMCiURyir6F2/CLt4CE3zR8VCrhDGj1jn/QAuMOabeYRN5BhGavgVY+3XF/MWuqZlwdaQRw3MyZ3Ynp+fyVpae857a/ukho90fFCvraQN9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNWdBkZDNhccc0TVqZFsNYO3uRrHck8QvWAHUjOICbw=;
 b=UBl2DWan214VHyBJjGX0/sdNlrq9zwcnYj4/d4OXn8LC/3TIz9/OQGMMwKmrN+Giix+2v0NegCaq29EdVpPkAdQokPspsBNiv5gFsO9eA2zZpirqDold/J19pdvYjTBlzWlAw/O2/vdL+++BZke4Bpa9eUl8VfzsSqHKauIskhQts+47hWFZTLamuxsyiGRblF+94vckxWeZyK6TFvYiFHcIP4gZcv9i9KgzOrkgm/9V4L74l5tbNCzzQO5exvi3FXZzAZYDH2jqOB7+tcOuziKxIsM59/ytMmr6dIBHKdwEFznuQA18N/719TbVFx1vetWVKjJh1wFlA3tE8rZPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNWdBkZDNhccc0TVqZFsNYO3uRrHck8QvWAHUjOICbw=;
 b=HewC2DyBLyvgh2gLQRu5z/o9d5vvmNnm3GcHTDxEMEUFtOr/m3aJ6iwprwO54W1FCctHYhaMB9o+jLrUFa1J0ifyNMoIDc/LjSMhTbFbL8wssv6JadWnvFtrO3oF3GeP2ocx/LHsYkskZxFEEbbdF/CvEyGic0+qhk9/e8G/26c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 07:11:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:11:28 +0000
Message-ID: <679bd578-8c16-4421-8e57-8069e346807c@amd.com>
Date: Tue, 5 Nov 2024 12:41:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Normalize reg offsets on VCN v4.0.3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>
References: <20241105064801.519923-1-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241105064801.519923-1-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0235.apcprd06.prod.outlook.com
 (2603:1096:4:ac::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: bc29ed2d-f71d-4962-0c8e-08dcfd69111d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXNLV3hRb2FDdW1DU0JIRWhWelBNRUt2N2crMEh0OVAxQ21aWW1jNG0xcHhH?=
 =?utf-8?B?aFlsOTVSdlgxMlZuWDdQVEcxZkhNcG1wTmtEZDZ2RWdHN2VLVFl4WkVSandl?=
 =?utf-8?B?QUtDTVpmd01RZXdWOTg0Y015UGJ6Z3l2cmFhb0xmdERiNHVwcEt1ZnFtMllU?=
 =?utf-8?B?VG9JeE00YXF1SGIzMUg3RG1WZmZNdVZXVEFtSkYzTFdEWmtlMEJHck92eTJK?=
 =?utf-8?B?RVJrTWRVcUgvVWpKQnhyL1RkQUd0THZkRGhEM1lPOEFpNlVIdEhybXVxeGlu?=
 =?utf-8?B?ZXRkQ0cxemtEM2xod0lOV3JwR3JwaksydU12RGc1NXhyMGJuUkoxbFdZd2Ey?=
 =?utf-8?B?enIwZ1pKM013TGd3T25yM25aY2VMTmw1R3lHU0FZKy9hQTRtZzhpZUtWdXpo?=
 =?utf-8?B?S1dpRG04YjYydmhFVkF4aWxyd0N3Y3ZrSEd4U3hLUFRFVzV4NDVQNW5iUVFl?=
 =?utf-8?B?RTFyZU8rK0prRWhuVExWbHFpRzJwdURlSU4rYmcvVGlMRVd5d2gyMHVEenVB?=
 =?utf-8?B?cTQ0L2x2aU93WDV2VytyYXpVZGJUeTl5UlBtQXBNWE4zRTlydjhwUEhyTDR5?=
 =?utf-8?B?THVETENyNWUxNzhMMCtTM0V0WkgzcURkVE51bk1VT3pPRjRzOVVESzloSTFk?=
 =?utf-8?B?cHpXZDVFSVZpcENFOTJURDNwcnhGeSs4T0QrVnUzU1RGK3lHYWQ0OFR2VzF2?=
 =?utf-8?B?aFU5eGozMC9kK2ErVGZ1bFR2TlNkV0J1MHI1RWhYdnRBQ0tqTVZUeEN4ZWtz?=
 =?utf-8?B?Z09TSmcrNHNzWFlkVDhwWUhUbUplWVpRWFhuQ05pOW92Uk44aHZjalEzMm02?=
 =?utf-8?B?bGdIbVFVSzNmL2FXYkNPaXR5dG9tR1g0ZEdkYy9YYXordEgwd0JpSVhkb1Nw?=
 =?utf-8?B?dzJUSklKZytHeDVuUUpQNzNwV2NBTjVjQXlJUEs3MWJvWW4wbFc2S3VBcHZs?=
 =?utf-8?B?VlAzancwSDVGMC85VHFGc2dWOEJZdXlrNTFDK0hjRG5xcW4xK3hwK2ZlQUFl?=
 =?utf-8?B?VTNhRTY4ZE44UUQxRENtalplSzFCK2dtUVR1cU52MzA5SzJZOHQvaWNCVkRo?=
 =?utf-8?B?NzVmVmF1dlBDVnZNNGg1Z3NqcjByYmVUaGJQc0JQT25zRHpyWVZEcHEreURr?=
 =?utf-8?B?WUxwVkZIc3NDWjZ6eGQ0TVo4RjJ6SmtXZnpMZkRsUStYdmZaWkJWUzZ3YXV0?=
 =?utf-8?B?OStJaGdnZW5YTTEycGVXdGw5Q2E0Y0tzaVdoWHZ3NWppRTJ1SVBkTmViZHpI?=
 =?utf-8?B?R0hxYVpwMzJuYk55OVdQNHRNZkd3dmovMStCZzhsTVZMVmFLZm0rZGlpQXpV?=
 =?utf-8?B?ckFObVg4aVlwbWVjZHgxRWpWR3gwWlowQ0JkSms1YnROcFBmNXo5encrdHJo?=
 =?utf-8?B?azM1WVFiaGtkb0NQaG8rZHg4a2ovbXVOVnR6SkNhdlFvMHIrVWtnaTJpK3FV?=
 =?utf-8?B?d3BZMlR3SUhnMHZJKzVJajcvRTJZU1hPeVlHNXNIb09CVzZMb3kzb0hKd0NL?=
 =?utf-8?B?Qk9FOGJQaFdKcFZMRHNoWlQzSE9YLzVPR2wxMFFkL2ZSazJmNzRBaS94YXY1?=
 =?utf-8?B?YVU1b2RxOUpZMVA2Y0JHVSs4MHdjOWdUWktiMkNGWGs3cGswVk95anhiTzRx?=
 =?utf-8?B?cWszL2ppN3RGZVZiRE03c2IzY1h3aUlpT1FoMW1iU2Qxam1FQnd2SHdER1I2?=
 =?utf-8?B?ZjhpQkpXWkQzZ1J6d0REZHRXS2MycXpMOXdmL0Vra3pEYWhGL1FHUHY5czJp?=
 =?utf-8?Q?9J1VJbpfvGrO4/b3xeETXDzwJkgZKl8HJVOVwlm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzloTjdHdzFHN0dNZGFMQmUwZVpMMXVpeWV1RFlVam9sbmVtclE3OHVETnJ2?=
 =?utf-8?B?V2ZqYmVsaEpFaWs5OVRVSTBuSXZtb25Kd2VCVUh6cFB6VExtemFTcGlFckg5?=
 =?utf-8?B?c0pJKytVQlI4ZzVNSm1zc3pTT0pZU01RaVhpdmFsZVpkMXREdjhVbTBDUFhi?=
 =?utf-8?B?TzJSa25hdHgxVGdJM0tDcGxMRlFBRTRiSk8yU3A4NDVZL3VRYW9IREVaK01D?=
 =?utf-8?B?TC9ic0w4Q21xZHlUemgxZWpSV0hOdDVvNWI1ZG1HSGFPeUk4aTVlZWIxMld2?=
 =?utf-8?B?cEsvOXNQYlowckRTdkR4N0t3UXNWemFaeXFOZ01pZGZGOThTZWY2NmpKSmdL?=
 =?utf-8?B?WTd5WjR4ZmRmcUpEWWdJRzVLd1VESHpDTGdSVm1MQ0RYS3RoTnlLL092ZXhl?=
 =?utf-8?B?RHhLbmZaTFFraHZYQy95dXlYdnpmeUxWNGFDbjhhZGRzeElrWER6U05jYlkw?=
 =?utf-8?B?aXJ1TGpGeTJxaS9YcTJqZkRjbW5va1lFOTB2R0YxdEpjVmc3ajlYbGNMdW45?=
 =?utf-8?B?MFZZczRmeko1T1dYeWZrOHdxN2RBb3FKNnY3TERRUXU4cjRJUTZDR3hVTC92?=
 =?utf-8?B?UEZvVE45SUp5a25DcjRFVy9HMXR6OWRFU3FkU2NvQk9jT1ZWa0tTc29qYjBJ?=
 =?utf-8?B?TmVLNjMwSVJCcVEyQ1JKNFNBMk9MTTBEZkt1bis4bmp4YWVoNm5sTE5IRk9E?=
 =?utf-8?B?aVNSdXoxTlBuUWVpalJuK3p4Z0N4SXBWbzRVWjJKRXpXeE1uRHZ6eFNyYUIv?=
 =?utf-8?B?NVVEb3N0alZUajlvaHE2QUJyZzh2SjkzMldoQVlPK21ycDF1U3VsVWFsY0Yw?=
 =?utf-8?B?QmgvVjFzZDROWHo1VzVEMHF2SW5jZmJmY1huNXF4L3JQK1JwbjhtelVWa213?=
 =?utf-8?B?U0xvSkg2dHI1dnhLa2ViTEhrZHh2K25TNmNYQ3cvdEFvN3ZLUW9qMTJBR2Q5?=
 =?utf-8?B?M0MvaHFSTHBQQVIvU0lBNjRQR3BnS0hNQjBMb1MrOFJ3SUNFeFdsczExdGFn?=
 =?utf-8?B?SGcreGZxMXpEMEQ4WmdXcE5MTk5CUUVpWU9OTkRpZ01hTVlWdDFiNmVFRGds?=
 =?utf-8?B?ZEVQTm5pVGx1Q004eWVqRC9FSGlSK2dHTFQzcVJOZVg5MFlGWkVKMkZPdmo4?=
 =?utf-8?B?QWNKeElndlVqbGRja1pVMnZCbFFRekZlSXByM1YyRDJkbWc4R2lYSlkra0Zn?=
 =?utf-8?B?VnNQU1F4dW9EN0NQMVhpR3NmS0dCSHVWcE1jTHBuN3k4WHRLeTFyTURvSzQv?=
 =?utf-8?B?QXk2OHVycjBQUkxjMzBtdnNDUVcwSzM4RFNWM2pwSG1oaFl2QmxiT2ZRdW52?=
 =?utf-8?B?dUNEZ095eEYybFNFNlRVYjdRTExHeStpcmE2aE1TU2MzdFBCeWtxVXRCdG15?=
 =?utf-8?B?bU02WE11Qzk2NHk3SnFPd3cwMkpzRUFqeHBBS000MVJJc1RQQmNIdUl0Y0VF?=
 =?utf-8?B?eHIxUmdPSXBBN3dEUklIbGE4blArS09uUWpzbEhsTDhHSzJQQnRlOFczRXdh?=
 =?utf-8?B?aXlpOFhydmVjOGFDcm1heGJ4MTVMbHo0WCszd2h1OU14cTRhOEIwZk5OL1lF?=
 =?utf-8?B?ek1TZXpSVGRQVlJvYWtiWkwrVEJybUdsNkZEbTVhWklmK1pRbXdGdUU0NWpy?=
 =?utf-8?B?RElzTDBXblo0YTkySzM2U2J0VDBDMXVOUFRiaHRKanpvbFFlZXRETW1hQ0lr?=
 =?utf-8?B?YWFHUk9zTk14amNvcTJTZkYvbHRmVlMwbWVlb2g3dW9JTjltUkY3QVRnZ0lF?=
 =?utf-8?B?SG9RQThnSG1zTWQ3V3J2aU84L0wzQ2N1OHB6a2JadjViUFg5NHFSRDlCV2RT?=
 =?utf-8?B?ajQrUkwrRGRYbWtNUEJmZkpHZVhwOFQzTGk1OEhhQ2VFbWxaT3BESG1qbXRm?=
 =?utf-8?B?TUJ1dUdrZ1o4YVlKOWs4cTRIV0hnMktFM0plZ0IrTjJpK1JvdDg1MDhaMDli?=
 =?utf-8?B?RWNkb0crVmlybHVuaUY2MDQxMG9oWE5wRDJLTWU2YnJtd01PS2xTcFNTcDRo?=
 =?utf-8?B?V2JXTWthQXFFdUlOeCtEN2JOSklmUTFXYnFpVlUrdWFUL1BWUzd3RUd2SzFt?=
 =?utf-8?B?WGxxSnVMdUt6WVB5ZzYrd2VobFRURlQxNVNsQ1ZFVDFkRWFvYmNCMnZuMTNS?=
 =?utf-8?Q?/gn7Uh8qwZHdf++bnTgS3DBga?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc29ed2d-f71d-4962-0c8e-08dcfd69111d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:11:28.3683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqRUzrbMvLGe1H1CpHVD4sI4uNtsAi2BgFwcsGfkM/XUz9Hw4pOGSVjav4IpbFxQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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



On 11/5/2024 12:18 PM, Sathishkumar S wrote:
> Remote access to external AIDs isn't possible with VCN RRMT disabled
> and it is disabled on SoCs with GC 9.4.4, so use only local offsets.
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 8a1db8b33ea0..cacb19c74aa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -95,6 +95,13 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
>  static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
>  				  int inst_idx, bool indirect);
> +
> +static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
> +{
> +	return (amdgpu_sriov_vf(adev) ||
> +		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)));
> +}
> +
>  /**
>   * vcn_v4_0_3_early_init - set function pointers
>   *
> @@ -1432,8 +1439,8 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>  static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>  				uint32_t val, uint32_t mask)
>  {
> -	/* For VF, only local offsets should be used */
> -	if (amdgpu_sriov_vf(ring->adev))
> +	/* Use normalized offsets when required */
> +	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
>  		reg = NORMALIZE_VCN_REG_OFFSET(reg);
>  
>  	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
> @@ -1444,8 +1451,8 @@ static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t
>  
>  static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
>  {
> -	/* For VF, only local offsets should be used */
> -	if (amdgpu_sriov_vf(ring->adev))
> +	/* Use normalized offsets when required */
> +	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
>  		reg = NORMALIZE_VCN_REG_OFFSET(reg);
>  
>  	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
