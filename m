Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEF5D75BC8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 07:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23EED10E18C;
	Thu, 21 Nov 2024 07:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0r5MY81m";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BBC10E18C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 07:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSFwkKZwjmPtVQR66eXysCrXdO26wM4Nt0MWWUPlCXTl8Ajuyu+lx6pfG/s3PfXO7HLGyLzEb0ahcfltkrE/5GKR0JlpA0SxxahcOyPjGbHaPqwoktSOC539U7qEUIVvUHW2RvmgzQth7qBRfLPqfAzvemXpVQ/ACMsx6I/JwOxpqPs1Ik/MnpKHw+M5z7ReFk+l0dhg7WWXGLdMeho/2EuUveh924woDBH33bCnkcSqQlxJk3QHrQYvbxG2B8knw6KCnD8VsVHQDgkijh4nErha5duMmdJN0XDpE5LTaKkQkdZU2ZWqeSSlpYd42kE7IkWDnRlrgURU1nNa8v2/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7vy1kHKtOvMPgZ3uiYV7dMdwIvvI5d2a0yejB0j7ME=;
 b=nzXXaSBvo1zGSlP3OmMIM5q5CDM0W2qms1GxbHme9Yt2WI98vtG0p5XJpCJkH3MpJg+n3eoO6Srx02dNNJZL7814AOmjP3FgC7xKuC5gaEKU6E33kZJ9GZ+ena06Mfftbi/01Gx4FkePDQRNi6MrAD4S2AtyyPk+WXCRegNnsd7G/rSKQGg3w0X064L64y+9WkpeF4mxeo9X14j8WC6YppVAN62KtKUpFQQX5bi4jqCHMnNDZdDCBLJknz/GZtiRWcIGzMdex8JSyguyt26T7h5tdjzhn5Jts8hpG3VnFMuyZCFjUFXNCk7ID9EgAo1yrVtmKl3WPhaL1YyEO/6WeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7vy1kHKtOvMPgZ3uiYV7dMdwIvvI5d2a0yejB0j7ME=;
 b=0r5MY81m/Ybug5qs248h9/Fz6eBB2bUg8ZwzgHymSmC7mi5H31CNajw8c1/Ng1/e8isRvWCOoRupdz+IrXVtgZjzqTG7KKBun58WV3CmP6Qtf/21dqv+bG/pC5vXU99HC8oO1xAFj8276M7xbc1bIC11pLzJtPOfGrjbntNjQrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Thu, 21 Nov 2024 07:40:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 07:40:15 +0000
Message-ID: <2311066d-7aef-4f1c-88e5-7fe888ebe15c@amd.com>
Date: Thu, 21 Nov 2024 13:10:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] drm/amdgpu/vcn: switch work handler to be per
 instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241113214453.17081-1-alexander.deucher@amd.com>
 <20241113214453.17081-12-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241113214453.17081-12-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 98556e97-44c6-4dc0-57f6-08dd09ffbcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFJvNGpUTTEwREY0UWJqQm85bGQxbzlyYUFPZzg1ZCs1UEMyUnRLZlQ3RUxH?=
 =?utf-8?B?MjlWK3BuOWtKTjlCdkZOU3prcnJnMnR5TGYrRldhQU9VNmtiUFJYT2NEeWtX?=
 =?utf-8?B?YVpqdEFjbHdnUWtBWkZ2MktjVzNXYk9MeVQwZW5uNHlNVkdVem4zSEU2QUtr?=
 =?utf-8?B?RXBwR0lGTHp0VFhrSXBVVDF5Ti9zNFVLTkVQdndqSGZqdWZydTU0TnI1VWs4?=
 =?utf-8?B?WnZNKy9BUXI2SVJ2TG16UEJ2RWtyOGM1OXNmT2FDQTNFbUtvZER3VUN4RVJQ?=
 =?utf-8?B?UDdMeHB4MTR1WEwxUUF5SHFyaTB5TEtER0trZ3NWYnhuMzNxZXBibFlCK1lJ?=
 =?utf-8?B?OHY1M1ZvQzY1TGxlZjN1Ynd4Wml1UjZNWjYvUlpXOUZ6YVNQUjNzbERlVmRS?=
 =?utf-8?B?WjZTb2hpWFhyVDVIeVZHVWF1THpoTG1aMTIvQmw2RXYzMktkSEVtaUhIM2N1?=
 =?utf-8?B?djFDeWdDMDFDdTFnSlRRMmJObzR2OHplTnVyWjZlTk4rZndRWCtxSWVUN3dq?=
 =?utf-8?B?Tlc1NjJQcVAxcTNjVSt2WW56N3BjRU1jd0FuT3EyeWdMODQzZkYrM0FmRWlu?=
 =?utf-8?B?UXplU001amxDV1JIeGVpb3UrUU5FdDNoUWZwUUM1ak80OTViZ1llNzdQSm5x?=
 =?utf-8?B?OW00NUpHZWp3Z0RHaTZVUnFSdHlxZ0xBenVMZHY0Y2krN3JOR2lxYlpOcHhs?=
 =?utf-8?B?Y2wxTVJVYURRWEp2TTRWejNiWjlvS250UTVuSnp6L3FINHhRd2NRY21wOXdk?=
 =?utf-8?B?SzhxeGVlRCtBdkpKaGswYnpFQ25BMk9jVmQvM3grdG1IOVNod0pOaG9YTG5J?=
 =?utf-8?B?Z2hzcnp5SHBXUTVCZFpYV1A3ak5jem12Nk5RamxIbGFnOWMyQWc5M2N6OXc4?=
 =?utf-8?B?YkNSMGQ1NU9ycm1IM082a0R6RnpOd2h2WTRibE9HUWpkRFI4RjBLeWlQNVVl?=
 =?utf-8?B?RWpDaHduSE8wVXU5U3FTM0NEMnlqQzdJbzdaY1RDUDZVTkxkdURmbVkwNzlG?=
 =?utf-8?B?aFRZNkJYcXdpbFJFdU5oNm5HYXRQZVZhVTFNUXhrK2xJQmREMUZ3UkdNN0d4?=
 =?utf-8?B?L0tMa2ZGNnljeEQ3MjVnbzNIZkJpTmt5UU9tVTV4WnFqTkhYVTNEc2NFVU5Y?=
 =?utf-8?B?WExqcDVIckNTeU1WTkNrN1R2Nzg4K2F5YmdCaWoxWTBGOFlJY1c4bEhaT1I5?=
 =?utf-8?B?Y1RqWm94cFBRVjNEZ282b010STNGWkJHWWIzZXErSUpTQ0Rnd1pvQUVuMDhD?=
 =?utf-8?B?M3BWT3J1bmtFdkREUDhLV2RBWFNYSmQwbVFvVE12L0pIU0c5bHcrc1cyeVZS?=
 =?utf-8?B?NjBQNVEyRGJldVhuOXNpYnZxcnFFb0ZxdUxTeGV0WXQzZ3VVa1pqN2d0Yy9T?=
 =?utf-8?B?TENaamtsM2VOTjkwSGs3ckNNUVY3OHhnd3pmdVlXRSt0SDJrRHhoL3pxdE5i?=
 =?utf-8?B?YUJtRW5MQkxHSU9OOTR2Q3BmZVRoRnlGalEwVTRHK3BvdHJGeXZvOVpabW9x?=
 =?utf-8?B?QUxuRnY3WU9sU2tpSVdYSERPQnlaRjI4V1FwVGV0dllibCtJd1N5OHhab1RB?=
 =?utf-8?B?MkwyMzgxQ1BFb3Axa0MxU2RxVnRBeHJlUkFlT2lvSjc2ekdtczN1Nk14azBh?=
 =?utf-8?B?c1EwRFRMcUxBS2JFcU9JNmpTa240V1c3dkp3Qnd2YjBXSzRwVTFzN2JFYmY1?=
 =?utf-8?B?eDd3Mm5FODJiU1VpNzZ2YzhJMkUyOEN0dW5WSnBrb3IrLzNwS2lkREVEM2c2?=
 =?utf-8?Q?dBHH1Rfw0RyjnbOk2E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFhtT1AyNWVaOGt3MzBITHJjd3ZHWEc1L3JEQ3BOVllGY1N1aHhOaFQvdzQ2?=
 =?utf-8?B?RVNPUXFTU0VQcEFudDg1OHVNSWlDYzVaU3V6S2tRVmZoMm1xZFNCblQxaExK?=
 =?utf-8?B?UTUzSEN2bGNGV0RDT2w5bVZ2djlJY05DcTJGbnFmYVJYRjRjc2RKNjN4OS9H?=
 =?utf-8?B?blNCTGw0U1pBRGtRYUNKbUEvN29PNG8weVVIMVFLSDh5MEtmZUFxRnZ0V1A5?=
 =?utf-8?B?S1UyZ0FxZUpaRG1LWlNENklyY2U0TU5SZnVVUmpFc3VXNVRPTkFHb2o1TWZO?=
 =?utf-8?B?Sk1QY1B0NzhWMllwcHpOS0ZUK0ltUWVYeUdyckYrYmFDa0wyYXI3S20wOXdz?=
 =?utf-8?B?dzZvRVZ6K2pieER4UTFQZzNQbi9ucGZZYWFHaGJYQ3hpczZIZEZaT000cHl3?=
 =?utf-8?B?Z1ZJSXY0cDI2b3JUTnhZVkp3aWRCakdIR0RHTTB0OUhPM3B3dXFRWVlRM0NM?=
 =?utf-8?B?cWVJYnd1ZHptcnZHTFNWZU1HQUJOQ2ljaVhDd3pEWExaeFdBWWdxQ1dqSGhY?=
 =?utf-8?B?OVhCaFNpVFBidllXdlBRRW80b3lQMjRacUZ0Z2x4ZTBWZVJtZnVMS3loMnE5?=
 =?utf-8?B?QStaR0wzK3l0QnpOWkJIWlZUckk2WXRUZXdzQjF0TmVGOXlOUHhNdEs1OS8x?=
 =?utf-8?B?QWUzY0NLVFAzZHdmWVNRdXFUNmVrWDRvUnI1RUxidmhaQ1RocS9vL2tOakYz?=
 =?utf-8?B?c1lwc05rMStOVUJ1V0xIVnpjclNtYzB0bEt6VGhZb2k3eVpnUWRXL3B6QUFj?=
 =?utf-8?B?RFFCd3JRWW5iakJpZ1A5cjFTcW1QeE9XUmwzZG1XVCtwY05FeWp1YWFuR0Fl?=
 =?utf-8?B?QlBrMHd3c1FyTVRRTUYxOWhIcGx0enJhd2U4MTF2eGpHZmhrYkE1RHJ1eEkv?=
 =?utf-8?B?akNUZWRYeHJ4SnlrVDZuWWFaeDhrY25VQmlTenZuNnM1eVdYa1lLWmJMcU11?=
 =?utf-8?B?RTF4VEVoZDRXbUg2ODEwRm9VMVBpbXZkbzNhd3ErSDdSNWs3RnFLdnBqSTRX?=
 =?utf-8?B?QlBnM1kraysxcTA1VEpTeDhXdVA0amxEU1hVcS9HQnpwbCt6WTZzZTN6Q0sx?=
 =?utf-8?B?ekRBY3VXNmJ5dEdCRlJab2Z5QVBEMlhjU0ZXZW9mOVZjaVVQZkg5Zk5NdXBp?=
 =?utf-8?B?ME1EQ09ldHJpaFMzYU13MS9SUEN6d09RbGJKRElQU1BuNXh6aUZGUThlb0ly?=
 =?utf-8?B?RWNmcVFhdnZ0NURONnNTQzlWbVVpTTFpdzNCdklKRkQ3anRyajN1Z2dqblhF?=
 =?utf-8?B?QzZoNFdHVnFkWWJjdjRtTE82VGdWS2QzQ2U2djQvNElOOGVsNXp3SVZsZHlV?=
 =?utf-8?B?MFVySW44SG0xcU12SGtqR1U2NUR3aHBKNWcvVE5Ianh5S3ZUazFwMjlvall0?=
 =?utf-8?B?b2ZQTHZWVHJackliWTBNREsrMjIyRHZyL2xwZ3hNS0dlUGRqOWp5akFWOStJ?=
 =?utf-8?B?c3VXcmFsRFZMSmhkQ2ZsVHRsL0NWamJ3cEJTb1h1M05tT3JPUHNmZTl5MUM4?=
 =?utf-8?B?eFY4ajdENEwyMGdwNlRDSTRqaGNIRUxjLzBUck55dm14cStQTFJnN0dYaFZi?=
 =?utf-8?B?SjcrWVhtVU9DV0owN2RPTmdGdWRwVHZOcGNvLysxR0plYUw4NTdTdUF5bnF1?=
 =?utf-8?B?am80VmMxTXEybHBrRm1kSXFET3dUQmtYeTlyREY2RFpjdmJGZTVJakhoWkdB?=
 =?utf-8?B?emtkc2VyMGw1ay82WlA2L25wU3krczl4Y2Q4Nyt0dGwzNzM2VUtuQlJYVFI5?=
 =?utf-8?B?UXkxZmxHc2o5am9EQ3VTeUJQY0NMVmk5cE5YYzAxRjhXNGRmem1uNGQrL0R0?=
 =?utf-8?B?VmpIaStmbUgxZkxwUzZOaCtLK2NvL2ExSlpPQ3p6Y21QR0hteXI1VTdZcHV0?=
 =?utf-8?B?S29ROXB2VGlqTlJVMjZzUURUY0FhSU1ZYWMxWnJBWGlRdnhWK0FHTU1YN0Er?=
 =?utf-8?B?bDkvOVRVS3lVd0NkRFdVMU9sOG0xNXFFYThJM3VIeVVZTktUZDUyYlAvRGY4?=
 =?utf-8?B?OXZXK2FxeFV5UWxGRU11QjNhWnYzRG8rWmhwVlJzQjdxR1g1Qyt4Z090U28x?=
 =?utf-8?B?YjVwam5UbUluZDAvUEZONVp4RFVWNWlBTVJVRU1VRU9qMHQrblR5YlJFR3lR?=
 =?utf-8?Q?EZ9CPh/HNnXJHzPMv0tnXkqIM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98556e97-44c6-4dc0-57f6-08dd09ffbcf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 07:40:14.9740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg7u+Bh6NZtb98r8QQ60SnKgQX72QZ7a0t9aLnInoTvrW2E/bpyQwIUMGDZXX7f4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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



On 11/14/2024 3:14 AM, Alex Deucher wrote:
> Have a separate work handler for each VCN instance. This
> paves the way for per instance VCN power gating at runtime.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 83 +++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 17 ++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  5 +-
>  10 files changed, 75 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index b4a550795470..3383e4146c6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -118,12 +118,15 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>  	unsigned int fw_shared_size, log_offset;
>  	int i, r;
>  
> -	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> -	mutex_init(&adev->vcn.vcn_pg_lock);
>  	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
> -	atomic_set(&adev->vcn.total_submission_cnt, 0);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> +		adev->vcn.inst[i].adev = adev;
> +		adev->vcn.inst[i].inst = i;
> +		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
> +		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
>  		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> +	}
>  
>  	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>  	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> @@ -271,10 +274,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>  			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
>  
>  		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> +		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
>  	}
>  
>  	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
> -	mutex_destroy(&adev->vcn.vcn_pg_lock);
>  
>  	return 0;
>  }
> @@ -325,8 +328,10 @@ int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
>  int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>  {
>  	bool in_ras_intr = amdgpu_ras_intr_triggered();
> +	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
>  	/* err_event_athub will corrupt VCPU buffer, so we need to
>  	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
> @@ -382,46 +387,45 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>  
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  {
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	struct amdgpu_vcn_inst *vcn_inst =
> +		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> +	struct amdgpu_device *adev = vcn_inst->adev;
>  	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> -	unsigned int i, j;
> +	unsigned int i = vcn_inst->inst, j;
>  	int r = 0;
>  
> -	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> -
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> -			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;

This check is no longer required. Also, fence[AMDGPU_MAX_VCN_INSTANCES]
may be avoided. fences is good enough to count the total outstanding
fences for enc/dec rings.

Apart from that looks fine.

Thanks,
Lijo

>  
> -		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -		    !adev->vcn.using_unified_queue) {
> -			struct dpg_pause_state new_state;
> +	for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> +		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>  
> -			if (fence[j] ||
> -				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
> -				new_state.fw_based = VCN_DPG_STATE__PAUSE;
> -			else
> -				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +	    !adev->vcn.using_unified_queue) {
> +		struct dpg_pause_state new_state;
>  
> -			adev->vcn.pause_dpg_mode(adev, j, &new_state);
> -		}
> +		if (fence[i] ||
> +		    unlikely(atomic_read(&vcn_inst->dpg_enc_submission_cnt)))
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>  
> -		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
> -		fences += fence[j];
> +		adev->vcn.pause_dpg_mode(adev, i, &new_state);
>  	}
>  
> -	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> +	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> +	fences += fence[i];
> +
> +	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>  		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -		       AMD_PG_STATE_GATE);
> +						       AMD_PG_STATE_GATE);
>  		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -				false);
> +						    false);
>  		if (r)
>  			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
>  	} else {
> -		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>  	}
>  }
>  
> @@ -430,18 +434,18 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  	struct amdgpu_device *adev = ring->adev;
>  	int r = 0;
>  
> -	atomic_inc(&adev->vcn.total_submission_cnt);
> +	atomic_inc(&adev->vcn.inst[ring->me].total_submission_cnt);
>  
> -	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> +	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
>  		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>  				true);
>  		if (r)
>  			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>  	}
>  
> -	mutex_lock(&adev->vcn.vcn_pg_lock);
> +	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>  	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -	       AMD_PG_STATE_UNGATE);
> +					       AMD_PG_STATE_UNGATE);
>  
>  	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> @@ -466,7 +470,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  
>  		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>  	}
> -	mutex_unlock(&adev->vcn.vcn_pg_lock);
> +	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>  }
>  
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> @@ -479,9 +483,10 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>  	    !adev->vcn.using_unified_queue)
>  		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>  
> -	atomic_dec(&ring->adev->vcn.total_submission_cnt);
> +	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>  
> -	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
> +			      VCN_IDLE_TIMEOUT);
>  }
>  
>  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 7b528123b36e..0d9a4d946eac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -279,6 +279,8 @@ struct amdgpu_vcn_fw_shared {
>  };
>  
>  struct amdgpu_vcn_inst {
> +	struct amdgpu_device	*adev;
> +	int			inst;
>  	struct amdgpu_bo	*vcpu_bo;
>  	void			*cpu_addr;
>  	uint64_t		gpu_addr;
> @@ -300,6 +302,9 @@ struct amdgpu_vcn_inst {
>  	const struct firmware	*fw; /* VCN firmware */
>  	uint8_t			vcn_config;
>  	uint32_t		vcn_codec_disable_mask;
> +	atomic_t		total_submission_cnt;
> +	struct mutex		vcn_pg_lock;
> +	struct delayed_work	idle_work;
>  };
>  
>  struct amdgpu_vcn_ras {
> @@ -308,7 +313,6 @@ struct amdgpu_vcn_ras {
>  
>  struct amdgpu_vcn {
>  	unsigned		fw_version;
> -	struct delayed_work	idle_work;
>  	unsigned		num_enc_rings;
>  	enum amd_powergating_state cur_state;
>  	bool			indirect_sram;
> @@ -316,9 +320,7 @@ struct amdgpu_vcn {
>  	uint8_t	num_vcn_inst;
>  	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
>  	struct amdgpu_vcn_reg	 internal;
> -	struct mutex		 vcn_pg_lock;
>  	struct mutex		vcn1_jpeg1_workaround;
> -	atomic_t		 total_submission_cnt;
>  
>  	unsigned	harvest_config;
>  	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 5ea96c983517..9ca964e11540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	/* Override the work func */
> -	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
> +	adev->vcn.inst->idle_work.work.func = vcn_v1_0_idle_work_handler;
>  
>  	amdgpu_vcn_setup_ucode(adev);
>  
> @@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> @@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	bool idle_work_unexecuted;
>  
> -	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  	if (idle_work_unexecuted) {
>  		if (adev->pm.dpm_enabled)
>  			amdgpu_dpm_enable_vcn(adev, false, 0);
> @@ -1828,8 +1828,9 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  
>  static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>  {
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	struct amdgpu_vcn_inst *vcn_inst =
> +		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> +	struct amdgpu_device *adev = vcn_inst->adev;
>  	unsigned int fences = 0, i;
>  
>  	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> @@ -1862,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>  			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>  			       AMD_PG_STATE_GATE);
>  	} else {
> -		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&adev->vcn.inst->idle_work, VCN_IDLE_TIMEOUT);
>  	}
>  }
>  
>  static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>  {
>  	struct	amdgpu_device *adev = ring->adev;
> -	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
>  
> @@ -1921,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>  
>  void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>  {
> -	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.inst->idle_work, VCN_IDLE_TIMEOUT);
>  	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e42cfc731ad8..115f33c3ab68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index b9be304aa294..6fb08ed09310 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -390,12 +390,12 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>  		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index a3627700ed48..70a1b85a4efa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -422,12 +422,12 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index e11bd6cae8fc..656c2a1c4bf9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -359,11 +359,12 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index d4d92d4e2cab..8eea78c498da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -331,8 +331,10 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>  static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>  
>  	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
>  		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 26bd1954b5e3..7086f98c2ddc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -300,11 +300,12 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 95b31167f552..4c641813aeff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -274,11 +274,12 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
