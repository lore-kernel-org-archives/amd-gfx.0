Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADE9D5AE60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 05:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F6610E072;
	Thu,  7 Nov 2024 05:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eA89xy6h";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDEF10E072
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 05:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cocI47oEBchDsqwvGlLR1o28toX8WTrJroWvQCvA7dOZpair2edu1SvSveAwszaBTim8tMdHL266Ghanx7AL8bKlsS/xfHoS/ipsiLEmaAHLIRZwzYJOcXsNYjLZA3EN8feVyW4SKZhYiU+3HVYLjssHPDaeB3afGs7BFMT1hFKNvujM1R4MB1OSDlGC4v+0Abn7W26XXw5zaJuookmzVdlRWDirCzFu/Z/rzX2DLQkDnWmMiQ/KM/rQeJ4iB2JUzaTIyZfop2Y1Wrsl5riiWPdZGYJ6+Hat4yv61GCQdn0p269GFbie4VqFOaXfj9TwNaU1avcfhz1A4hgjmY+maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scPsy76Nd619fDFpka7CCNJr2AfpgefJx9xtrHdiszw=;
 b=Ua/TehiXC+gywHgUyfSckVBprmVGfP6ANt6pN2HlKValqhCpGJ2QNaDqcta2f6mPrzUesX2hM0/JLD2+O45SRvYcJb1TwLTWSQu30kCcVxzSNMAB8XcbScwJ69SONKzJMr2u9UCJvxjsi4IWXcwldMBfRNKtLzYXXCHDl4HjcE7zyIiJQYSUe7u+k+tZU1VEK/MG8A5f17qEg2DSqj31pVe6U3WPbU+Vg7sA4RGMIsqdoxoS2xleLALC3qu5r+ssVikZZJR0ZCGTj/yxKn7ddip0rBKmuLDIAUidHG0o800q2NoBHfw6/JNIQqWRn25koDzb94MWPze/OAmqNickEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scPsy76Nd619fDFpka7CCNJr2AfpgefJx9xtrHdiszw=;
 b=eA89xy6hKT56oDlw3BmJ9cZ8XVu4KP4aveXSK3ydNzMBxeFG3GF4qTWdyxvt1dJZTHXrdj6U7Ac0avRIH++o6DF++jOSp9gGcZZDCxSmKvfwEbPdDmyKasVOW/4hOr6iv9mLSwXM1VyOhZJxGGfd8k+Kug1U/sBJ2SB+DhO2Eq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Thu, 7 Nov 2024 05:58:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 05:58:46 +0000
Message-ID: <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
Date: Thu, 7 Nov 2024 11:28:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: Alex Deucher <alexdeucher@gmail.com>, Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, monk.liu@amd.com,
 christian.koenig@amd.com, philip.yang@amd.com, felix.kuehling@amd.com
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PEPF000001AF.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::b) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d1a7eb-4caf-470b-3f52-08dcfef13dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFFhajZ6TWZzbUJIYkYvcjdlRmk0ZCsxT2x3TDV5Vk00dkFHRkszMkZRUjMr?=
 =?utf-8?B?eUFVOGRsYUtJTTBzNHg2SE5FRkl4VmpHMDllcTBCd3BwNnR4QkFCVzRsbE53?=
 =?utf-8?B?NmtVc2RQa1FFdUlNTER3aVd5ek1pWUdkREJTdjQ5ZGxBNE9SZzdtSTJHVWds?=
 =?utf-8?B?V1d2OENSZStRWWk3N3k3NHNZU2NqaHRRaGdwcGdRbFEzV2tBRGFCbDRkdVZh?=
 =?utf-8?B?bDVLcWtham5HMlhaWCtEVW1XdzJRaW5vMExYUHdVQUdYeHVvMU83OEQwNlV3?=
 =?utf-8?B?VUZ1ckVRRlJybHErNzFXVVVUWjBFLytGK2pRZUFVb2NsWWJrYmcyOFpuK3Za?=
 =?utf-8?B?cVBVUmUvclJLTWdLV0NjWUNrS2NBdE1QMjVCSTB2QWRvOGNRem1CME03bmNs?=
 =?utf-8?B?VlFTVXJ2V2xUcHB4YUZZeEhCU2xPWDYySFhMdkhaejladXE2L0F1VG94MmFs?=
 =?utf-8?B?WG1lR0EwT0ZjMEIzYmJpZURHK1JsNlRRS3pxelJJNmdNb0dJS3VldEVTZ1pS?=
 =?utf-8?B?YzVFSEkySURiRWUxRVdCaFBBbGxEQW4ybGpCQTRJWlRzTENrbE82b2JvUjFX?=
 =?utf-8?B?QWJjNlpFWXBFcXI3L1g1QU1KUFppdG5rSEFjamd3eXVoWHU4bGFjeHFVeUtW?=
 =?utf-8?B?VnBsMWtLNy9rd0dyalB1amdTZVoydjl0SjZtZW1sNEY1dEhjemdQL3JNSEtB?=
 =?utf-8?B?YVAyWnN3SDdpWDBBWmNMdjYwZFlPQU12RTZ6cUtrZVljSHRjTDloUFoweGpY?=
 =?utf-8?B?a0Fpc2ZxK3UxY2ZMaE5VRk9ZMGN1aTEwS0VVRDB5QzByRnJRSnhoT3oxZFFV?=
 =?utf-8?B?amcxM0pnZXFMRXdtN0tzbmdnWEdvRUZ3Q2NRaE1CQ1kvaFdmaFFoRWd6eGZV?=
 =?utf-8?B?cWJ0TFVITXJpc0toQlQxZWd2RlEwMTVhdkg4M282V3dsd25KZWxHVDZYNGU2?=
 =?utf-8?B?cHV0bjR0VUYrVGE2N1kzREQ4eU9xTWVCY0pWeUhYQllMZ0d2Y25MMEZHNDVS?=
 =?utf-8?B?cURsdDZiVllMZTIvSWtkaVhDdEhNMlhDQ09pak1RcTN0ZXc3Q1FLalE4OXM0?=
 =?utf-8?B?V2NIM2ZpeFc5cmpiUUVKdWUvM28wOSt0TkQ2MDdPT01oN1NzTjJUb1FsZ2FP?=
 =?utf-8?B?UEJ1NG5jSWxYN0V5UjJPOEVVMnkrRlZ5a2tUS2YxNmNwL2RZSXBqYWFQL1Yz?=
 =?utf-8?B?UWUwL2pxZm50NzMwUi81aWloVjNSZHFQSnltd0lyNTh6cEVkd1YyYk1uY1pt?=
 =?utf-8?B?NHdHNlVzN0d4dWUyY25RUEg0SFVwRmpncU03Q2trdW5KOERVVG9vaG5QdUky?=
 =?utf-8?B?dkZ3N3hCRUN0cWZtbytTQ2xZZHpRaVBCaUJWQ0c4REJaZlVTV1J1R283blFh?=
 =?utf-8?B?SGo2VlFPdFJyQmR0M0JoSkpvR1FEWGZ4NFdLbnpyYU9aMmdOUFgvU2ZpS3Qx?=
 =?utf-8?B?Q1RENGNkMzdOalVNbkdIM3BCRmdQVE9yUk94emdEMXBDRDlIMzUzYkpuL1pC?=
 =?utf-8?B?Z3Z3TjczU2hxMHNQR3czY2l2MnFrbVdhSDV4elVwY0xmY09aVEx1eWg2bEx2?=
 =?utf-8?B?c25XYzFrM3JQRUwvYmRKcEM3bGVEWUkwYnAzNC9TdlNDeHBXM0JJMDBUTlQw?=
 =?utf-8?B?UlNzUDBVdEtDQUoveElZR2lkZk1Ubm1UdFJHSDZzQVU2S3lGOVFPdEc0YmJ1?=
 =?utf-8?B?K0w5bUlVWkE0Q2hGRmdCNW56d0sxSHI2eFowUXpqdi9vMmVJdzc5R2g5b0Zp?=
 =?utf-8?Q?l31/zoRTfDqYR4bmF5LDRP83mqSRi9pM94HCCxF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRkbzdvOU1CMDVWSGhoTSs2QnlSYUFVQWd4VTdHRjB4MGpzRFl3Z3Uxc29z?=
 =?utf-8?B?YXpZS0Y3TkY2bzlJNjdPTUoxMWV6OVllUE0zbWVTcEVTejhkaWtXQUorQmNS?=
 =?utf-8?B?S0E1d2JzaVlMVlc1N2pTZmdwWElWQW5xNTBPZ01PUVZpaUg5bDJWL2crSDc1?=
 =?utf-8?B?TW80TDNEc0U2VXJOb2R6OTE5N0pZekFzN3hVM1NYUEZ4RnV6VGVLNGhjMUV4?=
 =?utf-8?B?S3ZMRWhIR0tua2xvR085SUdIb01yNDBySEVtd01kVWllSHY1RCswQnFoZFZ6?=
 =?utf-8?B?NDh2bzZEK2VjelhuaXJEOU9ZcHZkcllWNWJoTkd3aEh4eUJUc3NvYjFjd2tz?=
 =?utf-8?B?WWlIVXllQjYxU0JpZ3FBM0dUYllFRmNNb0V1SXM4UHpYaTRuV3BIYndhVVk4?=
 =?utf-8?B?blRjbzFpV0pmRWNPdjhGdTFFL1ZxU1FmbnZCcDluYkw0Ynl0bmlqS2s1ZzF0?=
 =?utf-8?B?Wm9WQldYdGs0elp3RjJ4YklCUkZSdFg4cFliaU9YVFY5eHgyMS9vRVpweER4?=
 =?utf-8?B?dG5tVmgrTEgwZHUyTVJYYWpPczZrZGg1WGNqSzZCR0dGSyttRzJXTE9ObmFm?=
 =?utf-8?B?OVF0K0hrOUJ0WWJCdUkyTUUvNm8yMFcwLys4NXRHRGQyYjRlcEpBS1VNNVJQ?=
 =?utf-8?B?NS9KWFFQV1kraitzaGNkMFdYeFBwNTBlWEFGWXNuMjFjNWpYR01xRmo1TWFW?=
 =?utf-8?B?NFhoTHRrSERCQmhXeFRBc01ZdzhsdkdMcmhEYWZ0c2c4SXRBRjNDREp2N0Yx?=
 =?utf-8?B?alRrbnExV25WU3BKVnZ6NEVRYlBPZ25LWVBCM2krakhxckFZRTUyaXdOY0JO?=
 =?utf-8?B?YXo2bUgvWTZ2MXNBN3FmVy9MeE5maitXdjFhOFV0ZWlnT1htQmtyM0M5azM5?=
 =?utf-8?B?YkdKTXhUUU0rbjBCdjd5ZEdCNG96STB1UTFjVTFYV2dwTHAxUXptczlwN1Iy?=
 =?utf-8?B?c2lXN3hpaEY0allDb21CMktLbU8raU80bWE4N3preEs3L2dHRjZsZXlidjI5?=
 =?utf-8?B?UGlsaWZmV25HYXBDK3B2ZFl4c00yd3pMSExTSWpZWEpGblZNMmJyQWh1UmhL?=
 =?utf-8?B?aHFYeGRKSnM1WUI3RjRpOFFqUHJsZTdRc2F1Q2lEcG5BdThxL3FhSnNrNjNR?=
 =?utf-8?B?UzUrazdESStzblVleUU4K2gyVWxZOTdmajE5VTNqY0I1eitHdksxS3R5Wjd2?=
 =?utf-8?B?Vy9FRVlnK0NuMWxxWmhlekliUVdNdHFPY1ZvZmVidys0Z3RGZTA0aXoreDFC?=
 =?utf-8?B?WEVvTmJNRFNVbmxoOHNIUXpSWHdqWTcrdDRjT2VCYTA0cHpqRkNPZW5BSWxT?=
 =?utf-8?B?YW5hcjdBWHdCcEtpNGtwUkk2WUJjZzlVRzg4Z3RCNUFDYnRMYzdhcHE1bWhr?=
 =?utf-8?B?c0E0Y2hXZEpjK0c3NjdYRVY4WFUrSmI4Rk1DWTN0a2NDNGVpZG5SVG96U0VJ?=
 =?utf-8?B?bGdNL3FCSHdZQnhmc01aSHFYelZoQkliVktncjcvcm9FVkQ3c2pCQkFHZkc5?=
 =?utf-8?B?akROc2J5TENJeFNoWlB3V3J5dE5OaDloVGlNUE41WEhnN2lFdVVEWHIvWnZ3?=
 =?utf-8?B?TnY0a2xtakE2Z2YreS94MEtaaDg5OFg1UkswRXh1cnBlenJjdyswblNROUxM?=
 =?utf-8?B?T013dnpXVzA3MktFTldPU0xyU1pwTmlKS1pNcGJjRVUwUkRNeEZiQmJvTjZY?=
 =?utf-8?B?UDQ4VHUwNGNQMmdpUDdtTWV4cDFJekY0U1U4MzJ0ejBydGFqRXVZV3FidFpW?=
 =?utf-8?B?bmM3T3lVamRxbEVYMkgyc0hrcHR6YnZuRVdnL1ZsVG9jdE1mVWV1ZklQNWlQ?=
 =?utf-8?B?bVRhMlIvRUJuLzNFd0tISFZNTkFiSEpYd2liNmIxTlpFL05SYU1wNkI2ek85?=
 =?utf-8?B?b29OVGViVm5iL2tVN3BmMU85MGZ6cUN1b3JxSU5kNDJ6dFBKazZDV0VJL1Fu?=
 =?utf-8?B?cEozWVZzVVBFVWllVUkydXRSYW9HeDViampUdTVxUVF6cWxmbzVGTy95ck00?=
 =?utf-8?B?T25jOW9xV0ozeTJNWXpLOUt1NFFNSGpwM0daVnRLczdtczdjeG9oa0Z4WUNh?=
 =?utf-8?B?aGhWZEZvNW9YWGZ4VENWdjl5Y0pSUTZhem5lT3RiQzZXa2RDZG41RmdwMHp1?=
 =?utf-8?Q?IXJgDUN4n6RQokEgIip9p+nl4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d1a7eb-4caf-470b-3f52-08dcfef13dfa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 05:58:46.4041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqD07H53mubVhuZGXbEmD/SxFENVqq5UBm3P4TRLTV87FtWL1PRe2VvTLHunAf13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
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



On 11/6/2024 8:42 PM, Alex Deucher wrote:
> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>
>> From: Monk Liu <Monk.Liu@amd.com>
>>
>> As cache GTT buffer is snooped, this way the coherence between CPU write
>> and GPU fetch is guaranteed, but original code uses WC + unsnooped for
>> HIQ PQ(ring buffer) which introduces coherency issues:
>> MEC fetches a stall data from PQ and leads to MEC hang.
> 
> Can you elaborate on this?  I can see CPU reads being slower because
> the memory is uncached, but the ring buffer is mostly writes anyway.
> IIRC, the driver uses USWC for most if not all of the other ring
> buffers managed by the kernel.  Why aren't those a problem?

We have this on other rings -
        mb();
        amdgpu_ring_set_wptr(ring);

I think the solution should be to use barrier before write pointer
updates rather than relying on PCIe snooping.

Thanks,
Lijo

> 
> Alex
> 
>>
>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>         if (amdgpu_amdkfd_alloc_gtt_mem(
>>                         kfd->adev, size, &kfd->gtt_mem,
>>                         &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>> -                       false, true)) {
>> +                       false, false)) {
>>                 dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>                 goto alloc_gtt_mem_failure;
>>         }
>> --
>> 2.34.1
>>
