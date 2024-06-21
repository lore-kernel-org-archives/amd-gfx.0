Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D119C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 09:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0357C10E1BA;
	Fri, 21 Jun 2024 09:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tx41vl9+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF6710E1BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 09:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJvjWrwlPtuIBBmJI4NtqZkqSXrHYggdgUjRCPNCG9cA34wryAPNdEDxuFV9iEQ/JtLgbjpeUGfKZCBWMw1jhQq+MbqlPv/SGdUsJkS0j2Xvo4TPjWbFzjBFjrH1drBWzOioXgShDEUddD+42uAL3m8eHHRO9C0ZDeh7lUEiHq/ITNlavMLSxJuNEbJYV2ZAhLOKXlAPo9++cD0MiY7m6WgXe5dqJwnfaMwI1HWr6xA1zx0bdcj6Ie8IqwfZ6ibECew56FJ0sVcqUnz9sOwczmAhF/d0ah7ncokut/jVGJa9b2io4/3VhHWI+K9pYuoPPsslVDnJXK3hXCsLlDESEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xULh1UtuejiFZiQxClfJctx4Zh/cYQCTzpfQgR7PNrg=;
 b=DsgfTmmhQMtN14a/jWg6YMBCqcQX7R2zeLswSrrNh6POj7AC5juIaaFb8Z/rjtc8Iwt6qrTAvDaAkGy6wVIr+HO+WipoG8znzDawBnODbwGGpii/TyyaoI8NQj52+pUD4HG8gPXnECXMDTk4dSKmDPAqpL47HIJIafjeclUpopm1Qmjdb3Uu5pSzHYz746IxKYCqju64YL1bSrXeUXQHu7bbTVKBPCzFctXvT9P/2W2C12cfBI+NgCgJHBGq4brDea3D7oqzkcZWpnEFeYOK/w6D5cje5/+GZ/8SUXgx05VYNTRmDI2Qz4Oo9qXcvZtaoTTY6fEukRFoS2p5KP+1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xULh1UtuejiFZiQxClfJctx4Zh/cYQCTzpfQgR7PNrg=;
 b=tx41vl9+rAWIp5VlRLcG0X1d9aYMxseSyXZgDWR6qybPRy1KjsJerr8P3kfarcCD4QV/3Kyc6Ltw1fKzSwNHDxWcr7B0d+Vct0JbvpSIapfPiT+tWxdIV7LywGYahkYJ1UK2LGh60KhYRmDvIftcVj3Bp41hLNuG5BYeLLezepo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 09:28:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.023; Fri, 21 Jun 2024
 09:28:13 +0000
Message-ID: <f59fe9bd-b9d6-44cc-980e-59d111933217@amd.com>
Date: Fri, 21 Jun 2024 11:28:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add missing error handling for
 amdgpu_ring_alloc()
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Tim.Huang@amd.com, alexander.deucher@amd.com
References: <20240621092454.42879-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240621092454.42879-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b744996-e634-4194-8a36-08dc91d47905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDFQek9yUVlBam81WGFGSlhDaDk5RWRpQWxXQ0NJRWJjWGtLZEE4ZG44eWZo?=
 =?utf-8?B?VmpBdDhjd0VvOU02Umc2T0M1UDY1b3ZQdXY0TVAxUXNmQXJFVElKYkhxbU1F?=
 =?utf-8?B?NS9GTWM1M2pyVUdVdDA3YlZnRG5JMHU0K0dSV1MyYnp3Ym1EUXBvdTF0NG9D?=
 =?utf-8?B?VmxoQUZqcGpod3duQVUxMW9SR2krMStJaDlxcUVtWTVaVUZSaVBxR0RHTC9o?=
 =?utf-8?B?UHdsR3FMaDVhOVQ3ZHlFQ3ZjRVV3NTlVbmoyYW0yWWYwUFFQVlBNNDdrK3Zh?=
 =?utf-8?B?ME1yVjI1NEhkaS8zcmxqQnpDcGxuS3M0bmRTQTNiRkdSTmVNV0x1MVBTSWor?=
 =?utf-8?B?cUNuTUpiR2Rhc3NhTDRqSlpqeVJNSmNzd2hVSGswRDFPQ09hMVpHdVdiQkhY?=
 =?utf-8?B?NUVZckRtc3ExS0J3bUk3Q0R5U3U5a1BDR210V1E4OHBKdW1wUXBxc3hvVjQ5?=
 =?utf-8?B?d3NKRFIxUG1PYWZ6N1V5MXkvRVVHNGcwbGFMcEZpL2hyOEo5T1RNZlZxK1Zk?=
 =?utf-8?B?a1kzU0lNdzlkcEVjVExMQTltRDVkZGdQVi9Sd0o0eEw0c3JLaUkwalQzdHJX?=
 =?utf-8?B?S1V5RTVEOVIyVTdlNmVoZ0NzYVJRVkhHQ0MrZHlOMERTS0tCcUtzS0pmcFcr?=
 =?utf-8?B?QmluUzNoZDVSZ0xTZXdvRkFmdVBBUUtrYWRNSGR3Q1NsOE1MUHZoRStJaUk4?=
 =?utf-8?B?WWk2cmw2MlNMd2dWbFl2TklNN2xRcUYzRFNza0NZM2R5TmNuTlRsbVBTVktI?=
 =?utf-8?B?dTB0WlBUL1FFTVlQZy9DQUV1YnhITWd5UG9JdjR1Ni85eGVpVEtlT2dGeW15?=
 =?utf-8?B?a1plc2JzWlAzbnNaMGt5bUVSWlRwT1hoL0wwNTJNaDRxR21zOG44a0xObFNs?=
 =?utf-8?B?SEZ4cm9RK1d2Z3h1WDFxWXFiSjQ3NHZIRnU0RWNFTWNhQ1NITzZUbE52VFh1?=
 =?utf-8?B?b0QzRUlmcWgzZGVVTXVEdUJ0aWV1emM5TDFLdThyY09qV0E5Q0dyRVBHK0cy?=
 =?utf-8?B?THFJTGtKdjRuT01TUWtGbkwrUUVFOXJyN2hRZXZsSEs3RmQraVFoNFJQWkh0?=
 =?utf-8?B?TlU4OGdhL0JsaTNFcERGV003cHJ4WDdYZCtoMXR0L2tPM2VyV3h0eFMvbmpW?=
 =?utf-8?B?dndCOFBKeE1GK3BUTmVjL2xjUkdHREc3WnNrQXBDa1VJUGkrNkFQdk5KTi9a?=
 =?utf-8?B?UklNK0Q2aUhkQldVYXE2c2FpRitPbkZuanAzWjA4TVRjdUpmYTdPNWNtYWEw?=
 =?utf-8?B?N1YxTnJCWjFDSTBTR1FQYUNRbFcvR3RGTXB6MXVWc21IaS9pWmNlaU5reE9K?=
 =?utf-8?B?eW9mUkNnTkdNQUtLVHJmaytNUFVqeHVYNWpHcWMvNFdCV3hMb2hNUXhYZzBE?=
 =?utf-8?B?WWp1c2tWRS9qcWRjRmZ3MVY0ZWNpZExUdkl4WmlTbU9sNmczUzdWRFhTVEQy?=
 =?utf-8?B?aTN0L2QwaEdGOFpNSjBoRVhPRUsyS1d6aEpBeHE2UkFhOFRwMXhoczQyd2py?=
 =?utf-8?B?TUgyZUxHVDFTRkg5L1R6U0I0SEFmakkzQ2xXNnZOSWlxRS84cFlaeGxNYzhz?=
 =?utf-8?B?ZGJFVk9iV3puVmNscGRLN0c3UVpldFBxVWtnQUhPNnhJcngyTDVXYnVwQ3RV?=
 =?utf-8?B?d0F3NlZwaFN0TW9CY0pHRkt0M3RsRXp6dHZxcSt2NEdvY09ITDR2VFhWaEF1?=
 =?utf-8?B?V2czUFlmYU51cjQxamxDeFBWNHlLYkIxWjhzaUpQRVAxbm1veDZCRFJiVENj?=
 =?utf-8?Q?58j7tEVQgMZ+CSvFFk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG9rN2pMYmJ5MDNTM0owdzQyUjAyQ1I0OGFSVW1Vd0hOWUE5NDRKZXl5Y0FZ?=
 =?utf-8?B?ZDNDNElNV09qMkRTK0pNK2UzY2dHSE55ZERUZ2RTVjNNbFN0cm1mSml4ZVJ2?=
 =?utf-8?B?WDFWc2xLMEl5MG9FendoN2M5emNDWjdzV0lHQVJEMEJQVXg0TjdUTXk5cmNH?=
 =?utf-8?B?SUxLUzBKY29NSUlwQVZURy9UUmxnVzAyWjVjS0xMaGVuOC9WbG9KYVh3aGJJ?=
 =?utf-8?B?aGpWUEQwYm5mcHE2S2pDN20zL0FLczFMckpaS0RVenkzY0xiWnFzcEFnUXlu?=
 =?utf-8?B?WWVtQUpQMVNCMjVrRlI5RzV3LzdjaWFuOWZRbmFqK2JjRGRyODI1M2VudHhv?=
 =?utf-8?B?dDJXdzR6dmNaT3dRV3k1bzIxN0pFVFVBZTBSOHh6RmtOVWRheWROOGY0bmFW?=
 =?utf-8?B?eWFrUmtHTytsdGYvd3RQOWZ5ZTByMjR4WGNjSFlZOUZLSFk3aGdCaE1ZWDY2?=
 =?utf-8?B?ZVJBdU4vU1lDZ2lFQTl0UzNIeXhaanJVZTZvdVBuaXpmOExmOFdaZW5rQUhV?=
 =?utf-8?B?eloxc0taa1dsdC9CeU9PYTNLcTg1YUw4T2RYMlFKa2VORlpjaE9pdlduOWhG?=
 =?utf-8?B?UURpR3NTYllGSktCWEF5eFA0cGdzUGVubk5TdUNTeW5wdElueUJlMnBycjBi?=
 =?utf-8?B?S0lHZW9ZRSsvNmhuV1lOOS82bG95VEdRWXNVNlpMdGROOVRicXZqSGR6dXJS?=
 =?utf-8?B?NzJmL01IZHVFd2xEbDVkQVZRTUVaWDk4VjF3dEtHY09zOWRSNjhLeWJJMW9R?=
 =?utf-8?B?S1V6ZWVQTUREeTlhNUNJaFlYVGRrZS9BTVptMjNXaHNmNGpWUlp4bVphV3BN?=
 =?utf-8?B?aEZOd0QzOERyOXY0bjVObE43SXFYOWVUWnp1MmpNa1Jyc1lhcWZja29qdTNT?=
 =?utf-8?B?aVY5MGs2Slc4SEUvb1RVZzFOSlhldWdzeFVmaExXSDVMM0cxYlowQlRZS1Az?=
 =?utf-8?B?aU1KdFlVTGdqUkVJQ2FoZ1FJaE1aS1daS0owb2pVaXJTMnBGZEpVaGpmMWQ1?=
 =?utf-8?B?NVFpZ09hTXkxUzJKeXVTUmJSSU1UTUlvOVVFMnYwVjg1VEI1MnNlbjlUMDdC?=
 =?utf-8?B?dk1hOWxaOE9jeVhxM3Z5cmxyc1RNRm5BcjB6OUtRd09mSFhtMnFVdkhhNXd4?=
 =?utf-8?B?WmEwVjhWY0RkdWxHcDE0dUx4N0lzaytPSVV3N0ZuYWtDYVVRd3ZjejdiemVN?=
 =?utf-8?B?SmFPeFJpV0FVZDFxRDFXd1pobjkyRTRXV25NK0VaYjRFcDZLWmhIWVQyanRX?=
 =?utf-8?B?M2g0cGpkR243NGVTTFFDTUFhVCt0amN1Q2pYZzNQT1ZIa09OQ2ZEbnovMW1w?=
 =?utf-8?B?aE9TQnhUMnpzWGVLTWVHbVJ2bFBsRWFlWk8zSDdWNVpDa1V5RnBKdk1qUzZa?=
 =?utf-8?B?WmpnRHhXb3dJbjlVcExPU0NNT25VYzY2ZUtSd21Pc0FoTXh0S1AxaGVYWVFY?=
 =?utf-8?B?V2FvZ0RVbDJSNngxNlovQS9lMUZDZUw3aUcyS2pkQUkwZU9ENUVNMkJveE5N?=
 =?utf-8?B?QWVpaUdKUDE0eXgrbzFwMVpOU1l5dzJ5VHg2a3RHblpXc2pyZzRRcnp1OXM3?=
 =?utf-8?B?c0J5aFIvcXRhTE5lalMzK2d1bWJYTTNJclBYdHhyODB0ditmSFBzOGpDbFRK?=
 =?utf-8?B?SGxnd2drckZ1Y0pUY1NNaTNzZEgvVmNWMjkvaTU0cGJsVWdKMy9VSGpPdXJq?=
 =?utf-8?B?cEo3K2w1cTh4RzJ1L1VpbTV3eThFQWdCSENQN1E1ZG13bnBIT1RIMFlmeUJv?=
 =?utf-8?B?dFBlRlFtTzh4cnlHanM1YmxGeW12TzhRdStjZUREYjhJRkR2bU1IMkRpbktG?=
 =?utf-8?B?RHl4TGVwOXNJTmlRSUxEaHJYZmovdTRqaWhyR2sxL1Z0WUI1NTRxWDNJQjVV?=
 =?utf-8?B?OEtvcDdGNW1rV2xGb2JNalRoQjQ5clhSdWo1U0VsM0VESWhaS29OcjRKaXkz?=
 =?utf-8?B?QkFZUGUwSS9RbGM0VTU2Q0ZaU2Jick5aNUZiUVBhNVhyOHdJN0lDOVlteldu?=
 =?utf-8?B?YnoyQ1l6TTc1ejRxRGxHZVloVEZoKzhtUmFNLzk3N0xLS01oQ2tBdkkyYUt1?=
 =?utf-8?B?emhRbm9VM3dnT3FuUEFyNW5BbFF5YjNnNXovYVVEd09sQ1R1K2xkVzg4UGxo?=
 =?utf-8?Q?yv4CuqMQfTM0MzdQYbiax+5ik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b744996-e634-4194-8a36-08dc91d47905
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:28:13.0287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMGH4xD2swV02lWeeMSskPG6+Ib7z63kMqOYsa9WVShkYbNL9VTWdLI1Xh5H4uBy
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

Am 21.06.24 um 11:24 schrieb Bob Zhou:
> Fix the unchecked return value warning reported by Coverity,
> so add error handling.

That seems to be completely superfluous. The only case when 
amdgpu_ring_alloc() returns an error is when we try to allocate more 
than the maximum submission size.

And in that case we will get quite a warning already.

I strongly suggest to instead drop the return value from 
amdgpu_ring_alloc().

Regards,
Christian.

>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c      | 7 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c      | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c      | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c       | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c       | 6 +++++-
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c       | 6 +++++-
>   8 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 82452606ae6c..25cab6a8d478 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1005,7 +1005,8 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
>   		pr_err("critical bug! too many kiq readers\n");
>   		goto failed_unlock;
>   	}
> -	amdgpu_ring_alloc(ring, 32);
> +	if (amdgpu_ring_alloc(ring, 32))
> +		goto failed_unlock;
>   	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
>   	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>   	if (r)
> @@ -1071,7 +1072,8 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>   	}
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> -	amdgpu_ring_alloc(ring, 32);
> +	if (amdgpu_ring_alloc(ring, 32))
> +		goto failed_unlock;
>   	amdgpu_ring_emit_wreg(ring, reg, v);
>   	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>   	if (r)
> @@ -1107,6 +1109,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
>   
>   failed_undo:
>   	amdgpu_ring_undo(ring);
> +failed_unlock:
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   failed_kiq_write:
>   	dev_err(adev->dev, "failed to write reg:%x\n", reg);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 3a7622611916..778941f47c96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -768,7 +768,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>   	}
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> -	amdgpu_ring_alloc(ring, 32);
> +	if (amdgpu_ring_alloc(ring, 32))
> +		goto failed_unlock;
>   	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
>   					    ref, mask);
>   	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> @@ -798,6 +799,7 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
>   
>   failed_undo:
>   	amdgpu_ring_undo(ring);
> +failed_unlock:
>   	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>   failed_kiq:
>   	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> index d234b7ccfaaf..01864990a192 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -63,12 +63,14 @@ static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>   		return;
>   	}
>   	if (start > end) {
> -		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
> +		if (amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start))
> +			return;
>   		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
>   					   (ring->ring_size >> 2) - start);
>   		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
>   	} else {
> -		amdgpu_ring_alloc(real_ring, end - start);
> +		if (amdgpu_ring_alloc(real_ring, end - start))
> +			return;
>   		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
>   	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index bad232859972..d7d68e61506d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -610,7 +610,8 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
>   
>   	/* emit the trailing fence */
>   	ring->trail_seq += 1;
> -	amdgpu_ring_alloc(ring, 10);
> +	if (amdgpu_ring_alloc(ring, 10))
> +		return -ENOMEM;
>   	vpe_ring_emit_fence(ring, ring->trail_fence_gpu_addr, ring->trail_seq, 0);
>   	amdgpu_ring_commit(ring);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 2929c8972ea7..810f7f7e279d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4093,7 +4093,8 @@ static uint64_t gfx_v9_0_kiq_read_clock(struct amdgpu_device *adev)
>   		pr_err("critical bug! too many kiq readers\n");
>   		goto failed_unlock;
>   	}
> -	amdgpu_ring_alloc(ring, 32);
> +	if (amdgpu_ring_alloc(ring, 32))
> +		goto failed_unlock;
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
>   	amdgpu_ring_write(ring, 9 |	/* src: register*/
>   				(5 << 8) |	/* dst: memory */
> @@ -5639,7 +5640,10 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
>   	amdgpu_ring_set_preempt_cond_exec(ring, false);
>   
>   	ring->trail_seq += 1;
> -	amdgpu_ring_alloc(ring, 13);
> +	if (amdgpu_ring_alloc(ring, 13)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
>   	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>   				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index b7d33d78bce0..07ca9264085b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1490,7 +1490,11 @@ static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
>   
>   	/* emit the trailing fence */
>   	ring->trail_seq += 1;
> -	amdgpu_ring_alloc(ring, 10);
> +	r = amdgpu_ring_alloc(ring, 10);
> +	if (r) {
> +		DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
> +		return r;
> +	}
>   	sdma_v5_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>   				  ring->trail_seq, 0);
>   	amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index cc9e961f0078..d51d5bd7de30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1345,7 +1345,11 @@ static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
>   
>   	/* emit the trailing fence */
>   	ring->trail_seq += 1;
> -	amdgpu_ring_alloc(ring, 10);
> +	r = amdgpu_ring_alloc(ring, 10);
> +	if (r) {
> +		DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
> +		return r;
> +	}
>   	sdma_v5_2_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>   				  ring->trail_seq, 0);
>   	amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index c833b6b8373b..e82426459cc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1371,7 +1371,11 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
>   
>   	/* emit the trailing fence */
>   	ring->trail_seq += 1;
> -	amdgpu_ring_alloc(ring, 10);
> +	r = amdgpu_ring_alloc(ring, 10);
> +	if (r) {
> +		DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
> +		return r;
> +	}
>   	sdma_v6_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>   				  ring->trail_seq, 0);
>   	amdgpu_ring_commit(ring);

