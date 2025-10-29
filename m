Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B013CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71D410E171;
	Wed, 29 Oct 2025 10:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2dcNlFlV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB4910E171
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:05:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaPp4cyBHcPH1X4EemplGjnhyYktmY+yjyyxhEhJ5MeyyBg8a0bDfR6K+h2YaMwIuB8RQNSdI1ad8iM1LebkQVFLmDeFW4bc+XuK8BDUlG4d9RCNBcV9RBsD00NBptP7J3uu0SpCAMSW97m72BdUruPpY4LLjqF/8mFHsNvrVESFohn1wjgsGdlm5CYrykdttHUPLGoxdytAHIQBwNK17IYEzWDFj5Z+Bk+5EZOh7AtPjC8uEZ5QH7PowzYJ6ZVZnYU0WJbRrGUR5qUNx4FDPQ40nS29+6aTw+PoPnyUYn0UgLmIAkVQ5UnSvMXUptnGazow4UP/i8S0YWF/jODyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+G3iXFFTsA2QHAdjGdSqK+28y1hPrqyfs2woIw1xjM=;
 b=F4aweAegwIZ4syqGM+uILbaBZyeMSw8t6pZaEBqmrfMAqfNicVsECd+naFOA9aImzJSz7ujIulH4sx2ovOyyvEoIbKSWsym0LpVIvxsIeD4fp2XvOmeFcBZ7nOF0Y00vv4eb1me070g6HS48/krSuXPQLSncAAXT2aSUBuUmjoChY0FJTvo5WViGLptcjAMV9an0bRgMWUWrGl5she9Nzdg2CbrKXkV8MIkigBgSX3O1OjWXErexaiOypZ4aeubx3rPuuRIk8gj37/ybxyBql7e1lgrtFyJiy4v89Rnx6w+LMuKtr/SRScxAmZTWc15TJYsm5qb5kUrK11erWUuymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+G3iXFFTsA2QHAdjGdSqK+28y1hPrqyfs2woIw1xjM=;
 b=2dcNlFlVww1Z9biVxShTOsf2nfh1wsQOTRZkRZawxlF1Ghi1pCNKFmoI4QJ5xA/og01DLXoQWw2qQ24Jfqrr+uQYOXAAuDYcGvjbpDKBEOYncP1IPx+1azw8L26oTL8rzfTPOVIXQNLfynohvydsl9b5py/WiN5o8zA5gPvmfXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 10:05:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 10:05:08 +0000
Message-ID: <2ba47f43-36ed-4805-8d59-fdf37f38deac@amd.com>
Date: Wed, 29 Oct 2025 11:05:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] drm/amdgpu/gmc6: Add GART space for VCPU BO
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d33bff-997e-4f29-48a5-08de16d2a3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTVzM0tZalhGcmZ5WnNWSDVVRDBNNTMweFRpeFFJSFF5TnBWay9taDMyK2Rn?=
 =?utf-8?B?N3dWMFJsSTNsaFI4ZndDbU93ZDJ3NjdhWWQvdWRQUWhxTWhwYU8vMDRqZmts?=
 =?utf-8?B?S0xIY1lHT0M1OHVSbm01ekRyOFZHeDZWekp6MlZWV1JBTXNQVks1UkR6QlNV?=
 =?utf-8?B?ZklCWXpFb1JleXR2SGNyT1hxQnA3Tk9QeW9yOFVaRFpzYzlHbnVLc0FWYzNY?=
 =?utf-8?B?YWpUM0dSaWR4R0k3QTNHWmYwRzZ1b3c3TXFtMjJOYUQvK1dnNUM3dVRweVF3?=
 =?utf-8?B?VngyWlg1K0RaTlZudmgyaDhJd3NNeVhXRXVVVTNkREswNzF6MkwwT3IzZE54?=
 =?utf-8?B?RWlrcWJIUlpiREVQVkJCWnBLZFdJc0RTeHdPRXFDZjRZdldTTDdBSU1TQW1D?=
 =?utf-8?B?SFY1TERsdFI5ZnlHQlZhVXE3WDhPUjBRZFpOc2NDY3BySHdRTGlYbzVBRmo1?=
 =?utf-8?B?TU9CTXphek5NdXdYUFViYzR5bU5meUs4QjRNMWdXcHdkVjFwbklDU0Vsd2VL?=
 =?utf-8?B?Q3hlRzh5SUkrZS9GUmZhNllvTFAyOE8vaFZtRk5Tb0JhTld2TVBUZ3BJNWtz?=
 =?utf-8?B?T1podEs2Rmp3SjNVTHRleWFtVkYyWjFWVGJqRk5qSHBObUY5blg5QjJkdmRm?=
 =?utf-8?B?MUxvUEdmUVdva1IwMnozOUljT00zVEhFZFM0SStVT21TYTl2WU02QlA1RnZG?=
 =?utf-8?B?SHV2UXhWS3NwY0thN0JTN2xRU2h5ZVJHY3lUQlI0YnRwUC9FeXF3YUl4VnBD?=
 =?utf-8?B?S2JZTHZ0UE9mNlJiL2tuV0FOZ3NkODBGZk9oQkp4OWo5QlFnekl1dkh3SEcy?=
 =?utf-8?B?bTJveC9sUHc3aTdybFpCdGdvTDF6SGVRSkdXZGV3ZGd1b1dOWDMzOURlVUF3?=
 =?utf-8?B?dFZXaWtraWl5MFV0aTE0SEh3VGJDUVNTbGlWRXVsZXB4ZmdzNzN4R281eWR2?=
 =?utf-8?B?WlAvczJHSS9pQjIwZUNyWWJwRTR5cVdNM0hHRklpeGFkYytWNUlRUmRBWWlR?=
 =?utf-8?B?WENUUUNjR0d5Rm9GdGppREN5dkkySlVPSCtMTXRqYWpsbTlYUWhVS2NpZ2Jt?=
 =?utf-8?B?VUhNUWZXTURWR3pYSGpHampueTdwbTA3ZzBoakhtN2kwS3dic0IxQU5LUFMr?=
 =?utf-8?B?Wi8vWFRyeElMT2VwSmV4c1p1STM5dHFPQ0MyVXVOOUdQR2ViQXFXdXhBYm9v?=
 =?utf-8?B?ekU3ZkZKeFJ5NE9WWmFNQ2w5UkMxMDZQT2NrTFZ0ZjRhZXNlbGNFSVBsTWh4?=
 =?utf-8?B?TUN0VHFTdFZnenFIWEUvS3Y2UmFBbkZ6V3Q5Q0FEV010UWRtWnc2VVljMjNr?=
 =?utf-8?B?NmRyNU1xajBvTWNpZzFveHl2SzFqY21tRDJwRkZ4bGRHNkE3U3QrVmZseCtv?=
 =?utf-8?B?LzZZM3JaOHFxR3piSy9vdCtHZVgvWUwveTk3Tmo5ais3ZUdrNmJhdzIxNUtU?=
 =?utf-8?B?M0hlQ0lBMzNpekY2WGV2N1J2dWlQY3ZyUnEyZ01XRGhOenI3VlFQS3JPSVc3?=
 =?utf-8?B?ZTVxK0FnWTFsVmFUak4wMW5QL05VNzBtSVM2bHJUOTJiK3QwT05rdGNxSlll?=
 =?utf-8?B?cFlNZXMvR1RoR2ZIUit4eXk3YVZOZ2xNNVJkNldVaGVEcVkxY2ZCVUJoRnRQ?=
 =?utf-8?B?V3JrRnlSWGVRdjFQa3YzU2tHbnRUVndjdG8zRzMvck1hL2ZRcGN6VyszUWxP?=
 =?utf-8?B?akRMU0pRK21rQ1grNzZVb2NzK2hjQlNYMFpxM2ZLQjZRc2lRMGtEcGRhM3NY?=
 =?utf-8?B?ZG14NldSVC9IQkVvVWNEd1B3RWZzbWdGeXJ6UDluWndHZEF4Ni94M1JWaTNl?=
 =?utf-8?B?MG44NUtaeDRwZ01Fb2RMUnBkb2NrR3RHdEZUdlZHd1VFdXJnODJDMS94Wm41?=
 =?utf-8?B?WmNlVURLa3IwaStkajFtbkNLdkhHbkUwZ3hzd3Y4dVpGZGhrTTdJYXYvZklN?=
 =?utf-8?Q?jWDYLw75BsZUyFKeKxdtExFFkRUk4oo9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJPb2tCaUVzeFFmUWxINjNrNWdKb204RzJIWHVXdzVlVEpmc2hrbm1ydzRW?=
 =?utf-8?B?d1FpQVRZZ1orTzkwcUR0TXlpcENkcWxtQ3ZOVnpMMUIxTS9acnVMK3BGZWZo?=
 =?utf-8?B?TXNEWjIxTWlmS3BodlloNHUxVUU2U0kyR3BaUU9WbEp6aHJsaVcwRDN2SXJI?=
 =?utf-8?B?RE5LYllsZmQxNUhGeGhGRXdUUm50eUVFaHBCT0ZSa29rdFFlSXZCdkFoZG8r?=
 =?utf-8?B?UTdyZVJJKzlsR0VwakZNSjlST3FKZmdFMC9ucjBsT0FGd3djMVgwT01wVUt0?=
 =?utf-8?B?MDBEMkpwYmRXUHUveUhxZkoxNkN2MFJ1ZmZwd2ZIbzBtbEU1amJKU3hXMndM?=
 =?utf-8?B?T25Gc2dzSnhLMHUwTkgxUXBNNjhUVlVRbHA5Q0E0ZlhEcFlFei9Tcjc5WUdo?=
 =?utf-8?B?eDh4SXJ5MVBwR2NheUxUWWl6cHk2VzM1UkxNTGhmN2J0S2dETFNEWXVtYzg2?=
 =?utf-8?B?eFVnYmZCemd0WXhoWnhoMW40QWxNRDh3QklNTVFkYzVMNTdVejhCMisxOHpw?=
 =?utf-8?B?UDZJSDZkWkpZWG5EVXh4SlJBMXJ1dnZtSTNZeTVZdGxMM3AwYi9UU3ZPYkRH?=
 =?utf-8?B?c2EzR2lZN2hZSmViTk01M0xRM3k4UmdUVzJIeHdua1NxTXp1c3J2WEo2aXVY?=
 =?utf-8?B?eUMrN3ZabUdRaEtGS1pGYXB1aU9pV214MllxNi9OeHNhbGIzNXdJdHA2TUwz?=
 =?utf-8?B?STR3OE9mT2xtSHBmL2F0UGw5Tjk3OFJ4QjVEZFozZGQ1TGtRdE9NV1cveklo?=
 =?utf-8?B?QXcvR1FxWHZzRXkwU3pqb3hZNWNyNFVXaVZEcXMxZlB1Lytrc3djZmxFYW1y?=
 =?utf-8?B?MHBtNm41Q1BBWlBZTWZxZzIzTld0Sm5ldkZBK2ZLNUwyNWNjWGl5QTdpVkd4?=
 =?utf-8?B?Z3MxdEYxTjAzYU83cHRmQ0dPc2lWalhTTmNJb2hLOFYyQVBPZkppWGNYMXl3?=
 =?utf-8?B?R1M0ODU4MXd3SEtRcVREbGQyZG1nMmlwNVdVWlY2eC9aOWVOTDhudjB1RDYz?=
 =?utf-8?B?Q1o2TG9CemdYblFLUVNBSGhMNklmQ0l1bkkwcjkrV2RxcVU1UmpxczA4VTky?=
 =?utf-8?B?NUh2K3pyWkI0T1JwMVpmUTJMWnpIdnY5S2FiNDdrTnVDNDZIM1hiTTQ3eG43?=
 =?utf-8?B?SzV0Sk5VVFpXNjRVbjRiMXRlVjhHZUlJdW9HdEl2WC8rRE9ZOXVOelRuVERG?=
 =?utf-8?B?RzdQZWNmRFpDdDduR1ZwS2ZMSGlIWTFNTWxQUVhLWlo1V0RGRzRuN0gxcUR5?=
 =?utf-8?B?Y0l4ODNmelRiekJJWVJUTGF5RTM1eWNsQS9vUHBHMUhEZG53YWU1NnkycGxJ?=
 =?utf-8?B?M0VwZG9SZ2dwdWMvRTh3REQyNWsyMzFsVHVpdE5mTDZLbWhGcnFYRExIQlFD?=
 =?utf-8?B?cXhWenZadVJwa2psUnV2aEdiODNsd3hSNVlqODQxd2hxSlBTL1Jwa3RuaFo4?=
 =?utf-8?B?WnBTWC8yeG5iVFF4dHQ1VTRUSG9idllYV3ZEdDJGeUIydHZSclNqSmIwcUdx?=
 =?utf-8?B?eE11ekN2YW8ySG1Pcnl0KzZLdGxSZkZQTDN4ckh5ZmFSTEp6ZzNjUVBrdk5E?=
 =?utf-8?B?bmZHUXlNY2pONEVMK3VhQXFGR0FDdVNKOW90ZU9ueXR1UWEvczhrd3NwV3Bj?=
 =?utf-8?B?RHhVcG83bmJmTlo1ci85L1RPVjJFT1dTVnhJaUF2US9QRjlJUUpaSzByZ0Iw?=
 =?utf-8?B?MEtFT1hQM0RnUW5sVUVkRFd6bFViZGlJeW9ZNUxEa2NjWVVEV0ZFdFRYRlFi?=
 =?utf-8?B?S1FWa1dLZTFvY3BJcmNzbXBTSDdHQXhvMFg0Y3RsUGdUemdmaTZ1WTl1K3Nq?=
 =?utf-8?B?ZkRQRDdXZkdPZ0pBRjFnTEhBcXZIR3owU1JLZWlHcVg5bmkwWmgwaFdZU1RW?=
 =?utf-8?B?QW5Kc01jWFA5R1crbFdDZk5mOXlaMUdzUDMvTXJBcGk5cS9JaSthVGJiRGlO?=
 =?utf-8?B?Zm5MS1VoQkxzOGQ5N3luYWMzN0d4bHVaMVRlQ01PcmNPK0szdEsvVXNZUkxG?=
 =?utf-8?B?Y3EwRFREUEdTelBuTjVUeFpXeGhOM1Ewa1pkLzJGUUpZSitrdjFWYTNPRGpJ?=
 =?utf-8?B?YS9WaTZUYVh2TEQrWVFwRUprV2g0L0R1Q2M2Q2ZWeExkeFZSWDFSRXYyQW04?=
 =?utf-8?Q?/lyKCbcIPPWd2btPSehkHYdYl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d33bff-997e-4f29-48a5-08de16d2a3f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:05:08.6003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0l+lvAoJJ5JDJE5Ww7hl1nvwzjFf80nB/+zp1hofIRGGODrSErchh4JQDUmYhIEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
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

On 10/28/25 23:06, Timur Kristóf wrote:
> Add an extra 16M (4096 pages) to the GART before GTT.
> This space is going to be used for the VCE VCPU BO.
> 
> Split this into	a separate patch to make it easier to bisect,
> in case	there are any errors in	the future.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 499dfd78092d..bfeb60cfbf62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -214,6 +214,9 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
>  	amdgpu_gmc_set_agp_default(adev, mc);
>  	amdgpu_gmc_vram_location(adev, mc, base);
>  	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
> +
> +	/* Add space for VCE's VCPU BO so that VCE1 can access it. */
> +	mc->num_gart_pages_before_gtt += 4096;

4096*4KiB=16MiB. Do we really need so much?

>  }
>  
>  static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
> @@ -338,7 +341,7 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>  		case CHIP_TAHITI:   /* UVD, VCE do not support GPUVM */
>  		case CHIP_PITCAIRN: /* UVD, VCE do not support GPUVM */
>  		case CHIP_OLAND:    /* UVD, VCE do not support GPUVM */
> -			adev->gmc.gart_size = 1024ULL << 20;
> +			adev->gmc.gart_size = 1040ULL << 20;

Ideally that should be a power of two.

We can in theory increase it in units of 2MiB without wasting memory, but I'm not 100% sure if that is actually tested everywhere.

Regards,
Christian.

>  			break;
>  		}
>  	} else {

