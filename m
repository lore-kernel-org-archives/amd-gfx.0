Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A2EC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 04:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED1110E334;
	Mon, 24 Jun 2024 04:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkn5r7jy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91F210E334
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 04:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlHmB+k65GJqh+EHASVzyR8qSmyfd8h6flqp3olCNa4fZ2yDAKaU2u67jwNbLbMaPZDxmk3yo4fclvqrKF/gTbA4M5yKVVMeWHJaolry/sq5/dneFBI/PWtqCTWBczXFG2AqgmFpju5vvgmTnZqDdW/srAkwHMNCPgmZtNML08uDog+dK3TqV36ECNqnmw+8fSXwGlArEU0f6KDBfdcPm0pRsOC804JoyRFHqxuAl9er2bpbQceC3aHWhiX/mk00IM9uERaIm8j9G5CjzE2CFrSQGdfLT5y7Tx/i+wycx/+ZgGAcoQLsh+BFjlVSze6eR1vT4l/wXNqdMJsGKvr1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwNvH7ygpiNtwxH6uXYMBIlocSFVx9mJ11OS3akdTm0=;
 b=MwOevbHgHDc6DXK/RCJO8SM9pZLzwAaau8gayiPPD1YTojLqs2/V7esUWnSfHOQcj1XqhyTJaIXV7CdwPnJeEkdbf/G2GV8+1mwwxNSeCb4KEbeBSWd0CjPnrw+vBLVsDBXf3hqjcAXgh+NTdELnm03PrDuCGlFembc224hu+YrAJwZPBiUjb4HNUJ+b50BFaIx7tJSD7qVK9koeWs4Ynu+3lqTaLQCg94Wj6PjAqo8HG9a3qK2YO4Y/gzVG8Omr+Og2hXefDlPYKalTnt2Ne9y1x43A3jWD6ZznVejZC4wg/21eYdsKJVe2fImR5JMDJbvVqing/nrl5X0oqziD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwNvH7ygpiNtwxH6uXYMBIlocSFVx9mJ11OS3akdTm0=;
 b=bkn5r7jyZkUNMFiMinfHvPed6pdrvNc7dSL5SkveSCTq+uqwH3qaXi3WiMBEsufIG8BJd85WI4Ch+n8ZLuWgd1/sVlz9SafKxdHvVplTfqsJkIOQYhU62afyt1LKlRt00vkfQ8u8EweJVfP7oS9n6ONrkYkUJDoKgqaFOdofHG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.28; Mon, 24 Jun 2024 04:45:59 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 04:45:59 +0000
Message-ID: <417eed06-b284-45fd-a59b-18e38a0c8b5d@amd.com>
Date: Mon, 24 Jun 2024 10:15:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/2] drm/amdgpu: Don't warn for compute mode switch
 under SRIOV
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, alexander.deucher@amd.com
References: <20240622154751.632271-1-rajneesh.bhardwaj@amd.com>
 <20240622154751.632271-2-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240622154751.632271-2-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c9dcdf-7495-485a-1614-08dc94088ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmJXcWI4MExGTjZ2MGFYUW1lT1JDcVozNUJrN0UwQjgxSFI0U1FONEptaVpE?=
 =?utf-8?B?Q09FQ3c3blpGRU4zQU9sVGhLb3FPVFg1L3dyYnVna3RoM1BkN1FuSytBa1Yy?=
 =?utf-8?B?eUpiTzF6SEt2bU1XUHhWK2ZiRlJ2WmRYL0lvdis5MkJ2b2hQS0J6bHIrWmtO?=
 =?utf-8?B?NHBzaERWNi9IaHJFR0d6MlVWOS9XUzR5QVpocWdpZGxXM2psQ0NEUU9vMlI0?=
 =?utf-8?B?alMyUlRQTWIrbHdsS0wzcnhXeG1TZmJ1bEpYUjVLWjNXRmFjTUNvUXBIVlcr?=
 =?utf-8?B?MzNGa2FiTWNzWWJQVG0zRmplQVFXQmJWQ09NaGZUbnhxSzZzL0prNk8zalF2?=
 =?utf-8?B?dWxGNVQxdVFzVnhMQ1hMVmRER0FNZElRcTJmWlJRLzlkTGFDQ3l6THd0eTFx?=
 =?utf-8?B?eWZqR1lIQ1QrQW45RktNRWZUOWd4eUtQSk5TV2xaN3BwMG9TOE5meDIxUHdH?=
 =?utf-8?B?QzlFV0lBcHNrUHZYQ2txZFFiUWJVZHB0U2NWVUYyQThScmNXY2FaU2tNcE0y?=
 =?utf-8?B?VkdVcDBFL2s2UzdVYXd5TytyeCtrQ3g0MHlSUVdaNVBHRXI4cklXajFjd2h1?=
 =?utf-8?B?VG5CUEZVOWllOGVaU1dGZm5UUnJwL1BINU5HNmxaTzdRRkpmL2tUbENJS2Ju?=
 =?utf-8?B?bEx2RFJPNnVjQThFbUtRdmlIR3RDNm53WFRnbTh2WVRqOXNMZEoyWHozYmRh?=
 =?utf-8?B?Q0pGRnAxMDZ6emlqNGNHK0xSbm1ZSTMxS0dlTlZOeUEzWWUyUzRSV3dMUU13?=
 =?utf-8?B?Z1hTOEtGdFhrUndrY1lUVDBYOVNhbzB3SHQyVXJkR01zdWVhWGY1U1k3UDFM?=
 =?utf-8?B?dExNYmdjZTVRRVo3ZCtzMVByQXN2TldGN2lPVjNzaG9zQ0hTSlhnY3NDM1lC?=
 =?utf-8?B?RlJJUUlFZERTZ1JxZGU2ZGJwaDFjdGRXQlVLYzZ1OEZMOHJ2R1ZZaVBseDEy?=
 =?utf-8?B?VTA4b0Qza2R1TEZaSHp4T0lob09XTk5WZTdiOUlwTXhQMU5yYWlnUHk5a3Jk?=
 =?utf-8?B?U1Y0d0xTZFU2MGV3NEo0T05mS1FhUTJtd2pyemU2cWoxcUlvNW9zSk9tVG1M?=
 =?utf-8?B?cVRqclFiNHVZbmxFNVRKOTB4Ni9icHIwektXMUxHWStScnRjWjBKNEtqRmc4?=
 =?utf-8?B?U3dyUkpnZ2JqbUZJQ0M4RE54RC9BM0U1eTNGSnF2dTlBMS9say8yNXRrbnVt?=
 =?utf-8?B?V2JaV3NjMnhZdEVWNTkvWkpCcXhQK2FBVjI3U1BOeENRQWNQWkxBbDFVd2pS?=
 =?utf-8?B?VW5XN1FHNWlmcnJjUWhaNjNpMkZRRlBNOGNWVkgramREZ3lDSkNKazhMZVdq?=
 =?utf-8?B?RGJyd3hjNWtIVlk4Z2NsVmovMXZVeEZHT0FsZ25Vc2ljTWdrRlE1dVRDVlg0?=
 =?utf-8?B?bklMVlJrcG5EMzJUd0pJS0lRTjBzOTNBZm1QbTQwcS9BdHdNWU1sNUwyWjhn?=
 =?utf-8?B?T0NHVERUVVhLc0EwTnNFS1M4Z003ZlczTkVEd2ZLVUFlNms0R2NQSUJjbk1w?=
 =?utf-8?B?UUpNNzVLYWQrZ3V2eEU5NGM3dFVwNnpCOWUyT0JHMXFBcVhQVS9XRFN2QTBz?=
 =?utf-8?B?d3dOT2hBVFYzRnM1a2o4VVZNRlk5UHp6bFdyVFIwc1FlbGRnTTZheVc1YjhF?=
 =?utf-8?B?TnRGc2ZlR1U1UjF0T1ltUTJQazd4a0d5R080ckVxakt4L2s0MHBSU01OSDcy?=
 =?utf-8?B?Unk3OURmUDQ5RmhkRE5uQ0xlUnZyanlyR1NDWWFIZUh5OXo1QjlkVUVTNFE4?=
 =?utf-8?Q?m2rqzqAc8bh3hsfmOX48ujyqyD3GBNc2fK3w4Id?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFdCY2pKMElxU2tVOElRRCtHbzcxVjJtM2ZIWXcyUmpPQUhtak9kL3VqdnA3?=
 =?utf-8?B?WlNLcnphNTRlN21YVW90WFJqY0h6SG52UlBWaFYyby9hMDlyRGxZZkhRdlIw?=
 =?utf-8?B?dldtcWl2VnYxYUxiQWx0OTJtR1RDMThkU0pOcGNKNTZrTGNCeW1FcTF0RXZK?=
 =?utf-8?B?MHBKN2lmYXNsRmo1S2xpeSs5UHMyV1B3S1FUUld3VmRkMndLaUVJODFTWktG?=
 =?utf-8?B?QUV2Tmcrd2VTKzBXUlBYaU54R29uZG8rT0NIcVZpUmxYRG5NSGs4dGsxZHl1?=
 =?utf-8?B?QlZPV2V6dVhBMEhNT1ZLYnA5UHpybzRlOG5rRVhpWVY0Vk5sRzlJVkJGTTRK?=
 =?utf-8?B?cnNWQXBFeWFwVFNVcThKNUplY1p1MW9pRG05RGVqSTM1dStKc0Fmcm5OLzVE?=
 =?utf-8?B?UUFMaDFiaHFLT2E4U0w2Y0k4VzdXMUR6THhnd0JaTi9XeEFEaCt5cGdZS3o0?=
 =?utf-8?B?dWJuOXFZUFRRWU1oUFNsZWViazlIN29lcGhjNmhUWUZybjJkUVZNZmROOTg0?=
 =?utf-8?B?aUJYOEVhcXVBUWxSaUIzZUZvNVNPVXZhbXkvcXFzYWNGL2ZqUzBUT0NCUEYr?=
 =?utf-8?B?KzNNVEFnKzR5L1k2SlhsR1dIb0Z6SlZSRzdZWERFamxJQVlRZGxKYWNoMU16?=
 =?utf-8?B?ZjlEOEFZWFBGL3VWUUlyR0UrS0M0WDJORDZPbEx3RUs0OWlydDVRRzE3a2Zp?=
 =?utf-8?B?VElYUTRHQUo3Z1JHQm1tb2VmQW5MNVZINHRGV09oWWIza2l4N1R1VHlVRzhI?=
 =?utf-8?B?Qjl6dmJEaUhEVkFxV3FsbGJUTE5pbCtTbkFRSTZ5eEIyTHFMYzdCMXZJb2th?=
 =?utf-8?B?OGNDMi9IKzFCNzhvUjNpUHRGa2RNbVBSOGR1OFZwd0R4TERROHBjTDdqZHBQ?=
 =?utf-8?B?VUMwNUdXK1MzZGZlREJDMkdrRkpvVW9IRU1OR0I5U2xiUDhhczVMMmtWQ3E0?=
 =?utf-8?B?NkhsemNrNkNSbHVyYmcrRjQ1eDZGeS9xeER0b2Z1b0hjVEg1Y25raWxxNWlC?=
 =?utf-8?B?c2FEcWZNT0hYSTdUd1pFQy9CTHRsMk80NVdJSWI0RE44YUcyNW1sVjNVdUhC?=
 =?utf-8?B?ck9qbXBhV3VhMHVVWW1CbjBIeHNBTXJra0V3dEYyaXFuT3FNbUY0V2t2Wmx2?=
 =?utf-8?B?L3BYYWxLb1pSZEZWRmY2aytYc25QVit6eXNxaXJzdlBnbENNTU5JUE4xTklz?=
 =?utf-8?B?RjlGNmpIZll1N0NIUzVVTEsrbkxyMVZMT0tYeENZd24xUE4yd2RCMXJzaUs1?=
 =?utf-8?B?bm5COFhMM0NHZ2UrNUtMQzFXUDltRFBycmoveW5QV1JSbHF2OUZQbi8wY0Vo?=
 =?utf-8?B?SkhPUWM0cDhPNlo4WWl1aXd1c3RLUnhUYWFpQzJKYzQ2amp6Zm9hMldNRzhy?=
 =?utf-8?B?WWJuQ2IzVG9CdE9GYmdpckdKWmk2d2MzUko0dmlmRlF0MHBJdW9qM3dnd290?=
 =?utf-8?B?K2xWaUtOYVFiNGFBZTFpQnh3b1Y5VmdnaEU3dDNSS2tFWGlWNlA0bzVDdXlv?=
 =?utf-8?B?NlA1SzdrZDN6VGE3SzI1UGdKanR6T2Z4bHpIYmJPSFFSYjZkYm1DWUFYSmNE?=
 =?utf-8?B?cFFlcVZUT2lVUGc1RDJISjlLT0ZXdjFSVVI0clUrb0cwRHYwL0RYQmRJMXBD?=
 =?utf-8?B?TTFLdW53V0VDTUFQbzVlSHFWNzFrLzFiT0lEczd5NHJPY2VrUVI0N1BKRE5G?=
 =?utf-8?B?WlRTbWdPRk5qNlJ0QUhwa2NnUDhvbWdhalZBUCtCYVM3amx1WkNFRGJZZDQx?=
 =?utf-8?B?MVg0Ty83WWk5Z1JoeGw3VlZkVWZvUlhjc2VUZHFzUG11clZzbnpyZkdkZHhr?=
 =?utf-8?B?Vmc4bElzeGJNMFpKUjlIV3h5R1p3bXN1YzliOXF3SnBQaHFjb2FSSFUrWFhr?=
 =?utf-8?B?SmtvQi8vNWRubEpHeE5FcnArODYzUERodmZtQS95RkxrWU0xNUZCakU2UlFu?=
 =?utf-8?B?R1B2dlQyYmpNaTZ3QU41eVBrZ2JlK0RGc2czTXRieDZHSnFwN2dNT3JDenhV?=
 =?utf-8?B?L2EzbDNSQWVUNnBQQU44blBRUmNWQVhvTUp5SnBlbUxTc1VQNVdvT0JFWmp6?=
 =?utf-8?B?ckIxMHZmVEZZclh0dCtnZHdDeVU1bkdoejFmbzZsaEZsOE9CSXJHNElpcHUw?=
 =?utf-8?Q?wAnuCPiygSa+kz7j51hM/35zi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c9dcdf-7495-485a-1614-08dc94088ac5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 04:45:59.1779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssmxizT7PIttjdA1vdUFVfh/7z2nBM3jkQsxaRTuTWAN7bwRMk0AyIQOhhYtpQSJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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



On 6/22/2024 9:17 PM, Rajneesh Bhardwaj wrote:
> Under SRIOV environment, the compute partition mode is setup by the
> host driver so state machine cached copy might be different when doing
> the transition for the first time.
> 
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 2b99eed5ba19..c4a9669bceb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -228,7 +228,8 @@ int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
>  	if (!(flags & AMDGPU_XCP_FL_LOCKED))
>  		mutex_lock(&xcp_mgr->xcp_lock);
>  	mode = xcp_mgr->funcs->query_partition_mode(xcp_mgr);
> -	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode)
> +	if (xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS && mode != xcp_mgr->mode
> +	    && !amdgpu_sriov_vf(xcp_mgr->adev))

This indicates a fundamental problem in host-guest mode and host is
doing a switch without guest's knowledge. This needs to be fixed
differently.

Thanks,
Lijo

>  		dev_WARN(
>  			xcp_mgr->adev->dev,
>  			"Cached partition mode %d not matching with device mode %d",
