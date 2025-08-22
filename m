Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE40CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 12:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8DC10EAE2;
	Fri, 22 Aug 2025 12:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m1FyiZ+K";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4689E10EAE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 12:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dahtBbsYjqhqb5vR7RE8iSF9Echvrf2efIBKX2Fyya8kQYcC9ZEDmw+lWY8t+Q1scZyZmgVnvq08tGp83YkZn03UqMZPi0eLwkHlilmjyQqqVI173tHA1R8sv/t/fYv5gCQ6XiVfFzpk/OBvoKJvFCRFpnN4Fok/aToi/+5O/MRTy4qChim4Yb+m+JX+Kj+IvaN4oUc21hwufL3qFa/eSGcXhX/KD2TaCosiwiStFofJL4yJ3u23gmhKvvO6Ly6MaXjQ99+VNg0iQ4x2IkiqK2mzc+ugArBfb4pDGC6v7pTa+Vv0ej4AqRFqEnYZMHBY6wl5/AtefzwCB0w/TlvRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnJfhUIelHJECRMQbDD99Ueqk3JHDw3ZSTUJXttRvU4=;
 b=MFqRY2iijp0stKpUOZURPoxQh8WpSPB7I25w9qOH8bobt7PIjaeYRC28fGn/qBi7OpYwkEYPGG6PM8tXigAZuW76t6csBhnofMsq0+bB/MvqR8+sUhSfSf+8TuXTU2uWriZoN+RaU5Y4pBWEh66sX1DC4l15TWwN8FLvloyVcBsFsZkJC+KknGa9uX7hDrzjarCrP0sgybtKP2RTC6CJtiu2fpeGX2iNertRO7PARr8vshvopFhYRi2qCzLlq88ZgSoCWq/PvESJfbO9xgIcfBVwnSX3KCFJ03jaQi5MIhq2RN0H8ecnAuddFiZyjr4wsIRIxZAHmmoZ1HnrdUBgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnJfhUIelHJECRMQbDD99Ueqk3JHDw3ZSTUJXttRvU4=;
 b=m1FyiZ+KTqzD2QST9tnwLAXQ/uKxEMVXWdFISW18TMNGH/wEeSQ810NovpGpqBqkmvwUitCxcpAxAtfcBxpfA+8rdLpnISyKqBPhiHNWacJA9M5iEPX507PNmFflvOoH02p1ghbAGA/q+4EqTyIM1K7r4QEgmZU6Uxgs0/YIb7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 12:39:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:39:12 +0000
Message-ID: <0e0ac30c-3282-49b4-8f60-dfee2fbb2108@amd.com>
Date: Fri, 22 Aug 2025 14:39:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] drm/amdgpu: Add ioctl to get all gem handles for
 a process
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, dcostantino@meta.com, sruffell@meta.com,
 mripard@kernel.org, tzimmermann@suse.de, Alexander.Deucher@amd.com
References: <20250813184953.3666821-1-David.Francis@amd.com>
 <20250813184953.3666821-3-David.Francis@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250813184953.3666821-3-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:530::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 049f89d3-a5e9-460f-646d-08dde178e5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3RQWWJ1MDRKMlJISlI3KzZ2RXpoUlJza0htL2xXZWJiUEhraWhtZ0w2Q2dZ?=
 =?utf-8?B?WG9oQWFocW16MmtJcWJoK1VRUS92M1VBT042NTRtcTNpM0g3MkE4K1VvWFA2?=
 =?utf-8?B?R0RubGVubWhFbDVrdGtQQk5rd00vTG5pUTZkMTVIYjN4UGxTVUxjM1VvNlQx?=
 =?utf-8?B?SlZzUHdSWjUxbUFEams1UE1kTVc5ZUF2S3g5MUdIL1VJcU9CV2hmSjlHVmxD?=
 =?utf-8?B?SmN1bzVzYUxOVGpRQkx0M2xvZzYxSGpDd2NteW9aOEc3L2ZoTW1OZ0hQTmpM?=
 =?utf-8?B?TUZBdk1QUDJBWGpTUC8zVFV6N2RCd1BuaHA1TGFiWVgrTUN2TjlLNU5GaTdi?=
 =?utf-8?B?bzhkcjJMait6NWxaZnJqcW4vTTRMWmd2U200TU02M1pkaDczZ2NvSEpxTFBq?=
 =?utf-8?B?NXdHVmNIN3lTeWRPZmZjbG9LdlVmZEpNWUhkRFNpaXN1LzZ5STVOVC85S1ZC?=
 =?utf-8?B?aDMwZ1FPdThkRnpON0N6WjViUndjZkYxcVVDYkZMaEdoR01KOU5WTy9ldEJB?=
 =?utf-8?B?UEZDQzlNa0hxeHJXRnZNS0JIUHlpNVNkVzNPaDFrbkpDMkRrU0hCSWtQOGUv?=
 =?utf-8?B?bUttb0poZGtLS3NqYlU0Smh0MVB6NFFyQWtJODVzaUJGZ0FzeGhVL3BEZWxC?=
 =?utf-8?B?bURXY3N4SGdnMXFnNVd4Y2hqTGdCUlhnU2FlM0YyazhzUGp2bVBPRW1Lb1Iy?=
 =?utf-8?B?dHNMNklSWlNTUGNuUW9KRXhPQkdiYVpMUTZtOGhmaWgwZXdPZ3hrVVIwL3Js?=
 =?utf-8?B?dWw3NjJLcTBYYTBYRGpuT3NpU0R4T1gzNmNpdU4xMzVna3VGMFlwblBFbmNE?=
 =?utf-8?B?WUpDZTJacWFZaVFzaHdkYnhNQUVWVENvbnU2SGtkbWRUNjMvZjhiZWJFNkZS?=
 =?utf-8?B?akZ2ck5KckZOZzJmeDNLbXNKYWhnb0FhNmIxS0NrWUNabHdzbEJjZ3l3RFp4?=
 =?utf-8?B?Y2dXd29CTEtWMVpwcE9wR0JOeEhTNGRJOUFYb05QL3dkdXVkSkVnVCtoOGlH?=
 =?utf-8?B?ckJXVGFFV29pd09SaTgvSFNSUnBlVFlYYmJkWWNIUUJWOWVjYmV2eDRpYll2?=
 =?utf-8?B?aTF5OG4rSzZqRlFMK0p2Wk9jWlA0dVpRUFR4Z1lKZ2dNOG45dFd4L2d3UXF1?=
 =?utf-8?B?REIxZE16OFMzc0ZiMFBCcFNaMVR0S3BBZy9OUkgrUUFFQ3h0dm94dzlUUjVW?=
 =?utf-8?B?bHkwZlpSaTRYaTZmc1hHOEc3WUxNUWg4WDR3b3hhL21PMTZES255U0RQM3NO?=
 =?utf-8?B?ejI3Q1g3Vm5qaDdodmRacHBPKzBwUU03d1o2RUJkOFh6RS9sek5IN05ra0ZO?=
 =?utf-8?B?RitBdUtackVOcTdtNUxTeWpnQXR1MEZhSEJTV0dFZXNQakMxbmNtVisxdUNP?=
 =?utf-8?B?eWJJb3l2bCtEUXhFUDJMNHl6UHpIcTdLZEdMbVdmU2tXZk0xN3ZxMkdFUTNl?=
 =?utf-8?B?SkgreWZaZEo3ZDN5SXBNTGYvM3BwSElaWUtHL1ZjY1UyUys4cXpyMHVVR0Rk?=
 =?utf-8?B?WE54ZlFzUGxCRlFKMVpHTUFQNWFycEV1WmVERjBGdzd4WXRYSE5Zd2VsMzlv?=
 =?utf-8?B?Tm5BaTYyNFk2UTFqY3RnaXNMeWxseUtNQ0Q1MGQ1VFp0clUzTWRxK2Z4cmQ2?=
 =?utf-8?B?UXd1Z05mUjlTTjF0SkRDcG81dWk5b2Fyc3hRdDFsalJVQkFiSmVEVnJPMlBY?=
 =?utf-8?B?NEhlQU5Bb01rQUZjNk9mb1RvRk1UTk40SE5TeThLVTd3T3ZJbEtuQTkxMW5X?=
 =?utf-8?B?bVRoYWEzTlpUendHSS91dW55eCtPNXd5YUNOK29xVTg2QnRrZ2xZNGRmaERh?=
 =?utf-8?B?WFdHZ0doMWJ4UEpSTUdMZ2Y3Q09oVWh5eUFLNGVqQXowa0Y3NnVwQTF4aURU?=
 =?utf-8?B?cENQOGJhS3NtbjI2T0tpR0t3Q1Q0NHlDUUpzaGpNbTNGdGE0dVhSZHpqNGM5?=
 =?utf-8?Q?oI/EKOg7hyM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTdSRENJQmh1QnFvalNYMndzODRPcGxEQmtqMk5nem54TmRxTzRqZ2xFUzBN?=
 =?utf-8?B?TGVoaGdtTHczdzBnZXhTM1BYRU1UWERHaFUzcEZNL25UeGI5UUxpUWoyWkFr?=
 =?utf-8?B?QzJJL1VWcytmOWpJcUJOcCswall6ek5Pb2xJeU9pUHAxcStCdmV4S09ySWJx?=
 =?utf-8?B?ODhSWmwyV3l1cEJ6T0tZdkZ6S24zN2hIdDFxWHprVDVWUkJRRitOelQ2NURs?=
 =?utf-8?B?amowM0Q2dlhFVk5kMEFDRll6RCtlRnJabDlKaEF2VEh5eWdUVSs2SmF4Z0My?=
 =?utf-8?B?K2d6WGY2aUVIQjJxMFNSRFNVVXNqMzRTUWdzWHJ5VmdHd0RyN3U3STFjS0l2?=
 =?utf-8?B?djVjSE92anpCZGtmUDdGSTlKRmV5NGlRNHhLcm5FRjN1UUJYY3hPQzRHVjgv?=
 =?utf-8?B?eFZiZngybVFiY3RaeFRyRHdsc1JydjJiUlZCanlRMDU3c0MyYzBMWGI4V2l4?=
 =?utf-8?B?S2k3eW5Id0hGSUIySDFLU2p1UVYwNmxrOEFmR3hZTVRkSkVvWlRsRFl2QVd6?=
 =?utf-8?B?cUZJblNjeEpHd2dFRmRIekhqYkx3cVNSc2dGV3pJRVFkN0RDT2EyVVlLMnRY?=
 =?utf-8?B?UDZMS0RhRTVaNThOUnNUK1FNNy9RTnF5THRicVVENnQveWk0eFNrMTFiN2t2?=
 =?utf-8?B?NzkrQzROR3dhK0NTTnVxREdPV0FnWEFUZjYrU2xBVGQxVFhFR3VLM0NPZFpO?=
 =?utf-8?B?VENld0tzZWN2U2JFbDF3K1ZCVTdFTHlsSGF5UStRQTAzS290Vi9jSCtzejBy?=
 =?utf-8?B?SHZRRFM5djJNOHp4bE1KSVY1bFNVbDNwakJuN0h5ejQxcUk1YzlNV2hYZkVY?=
 =?utf-8?B?OU9OTWpZNU1EWG9EL0sybS9IZk9HVDB3Q3FiMy95OWc4enovRm9oQ0FWbEFa?=
 =?utf-8?B?VDFDNHJrd2VYUWczQXRJUlhDZVVjRkdCditjYXllelBMcFliU3pZS0VnOXJt?=
 =?utf-8?B?dGNCM3l2c2R3b2F4dkRJNm8vaHJSRDNvVGQ4MUttVCtUb3VISlJXQ2M3TENZ?=
 =?utf-8?B?K1pQNlV4b0NLWHJPb0FlQU1TTGRSMG9ZaEwwM2NRWWdjRFA4VjNyV1E4bWo0?=
 =?utf-8?B?YzR2TG90VG5KYXNIOGkyNGFTVWl2SUM1MGUxdW1wWUlKY1NUUFM4Y0hJUEQ2?=
 =?utf-8?B?UnlPa21ONFBXb094SUkxQmVjTXhBOG8xb3pRVXNucmZjWkpnS1lvMlR0Zm9z?=
 =?utf-8?B?eXo3bTJSdjNsVmZzeiszZkREYTAwbWxDb1JqUkt4U2JLTkVsYWhyTWl1enIv?=
 =?utf-8?B?eTNyTUNXNGI4ZXRyTktUQnRNQXZZN3FpcTRuM21PTHNMUHJQc0VWTVZWdzFW?=
 =?utf-8?B?Y1R6RjhRM3NQYzRsT1dZTGpuVnNmSjNnbldWSXdLQ3VKZUs3NVlnUnkxN01n?=
 =?utf-8?B?U0x5TTFrZDRDQUlTOEFTalJ6aHI2cTNxTWxTR3NNNlBXUERCUXJtRTB5alhS?=
 =?utf-8?B?SnYxY2s0a3R2Z0phYkhrR3BORDdXNk9WWDhsdGtNOHdLd0V3VVAvdUhyRWRD?=
 =?utf-8?B?NzdOcUQ5MDZVUEU2ZDNBTGlPa0hHTytsUnlLNjRqS2Exc2V5Z2VXQS9wcGRy?=
 =?utf-8?B?YlRPSVArcEVieWxZaUY4ditPMlRqRHZWZmdwNWprNmFIQkp1OGtEdVI1SGhx?=
 =?utf-8?B?eHpOL2tpUjZQaHZ6QzVqV3ZqNXRQSDR4ZXMxUjhUSXNYVGRMd01OYnk5OEJq?=
 =?utf-8?B?alJGQ3VVRmhHQURqOGM0c3BhZzlITUNDT3BEdjBqcHNkS3JDbGoxYUxOQ3pN?=
 =?utf-8?B?RHNQQ21vcThlQnFEYWlqdmRiQ0hWMk9qbTdtc3dTdHdrSnkyWGl4NE82UHpu?=
 =?utf-8?B?UG5LcnJtaDNJdkdaWTJaSU9mRmRUckZyc3FQNHFtQzFIdld4ckFFQ3B4T2Nl?=
 =?utf-8?B?clo5VFVLOWMvUzVjdjAwNW4yQ3paUTMweUEwUFhsRFl4ckV4d3Y3OUFYNkN3?=
 =?utf-8?B?UGhPb1RzN0dxejFPRVZRTWF5Z1JPOTdyQ1F6SHJCb0xTN0tHalBqeEM5RWR3?=
 =?utf-8?B?MjBuRm5FRmkwanJCTXdEWStTNitBcXRTUzQ4MUk5MFpnU2pyMjVFTCs1MzBn?=
 =?utf-8?B?ek95UGovNHNkb2paZG9pZldURmxXZzFDaFl0MzRXRjNDOUZQQWQxU3RGdUh0?=
 =?utf-8?Q?KauQpsRGPJru8UxTXcam0L1Xp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049f89d3-a5e9-460f-646d-08dde178e5f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:39:12.8939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVeg56raLsMdgfQCHUWP09TeqGDYl4GFxh9niqzG3Jlqc8YIexLsagdaiqv2WXzv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
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



On 13.08.25 20:49, David Francis wrote:
> Add new ioctl DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES.
> 
> This ioctl returns a list of bos with their handles, sizes,
> and flags and domains.
> 
> This ioctl is meant to be used during CRIU checkpoint and
> provide information needed to reconstruct the bos
> in CRIU restore.
> 
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 79 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  2 +
>  include/uapi/drm/amdgpu_drm.h           | 31 ++++++++++
>  4 files changed, 113 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4ff3a2eaaf55..f19795dddf9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3031,6 +3031,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index aefae3a9e6f4..d17cc7ba66d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1024,6 +1024,85 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> +/**
> + * drm_amdgpu_gem_list_handles_ioctl - get information about a process' buffer objects
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_gem_list_handles
> + * @filp: drm file pointer
> + *
> + * num_entries is set as an input to the size of the entries array.
> + * num_entries is sent back as output as the number of bos in the process.
> + * If that number is larger than the size of the array, the ioctl must
> + * be retried.
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_gem_list_handles *args = data;
> +	struct drm_amdgpu_gem_list_handles_entry *bo_entries;
> +	struct drm_gem_object *gobj;
> +	int id, ret = 0;
> +	int bo_index = 0;
> +	int num_bos = 0;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id)
> +		num_bos += 1;
> +	spin_unlock(&filp->table_lock);
> +
> +	if (args->num_entries < num_bos) {
> +		args->num_entries = num_bos;
> +		return 0;
> +	}
> +
> +	if (num_bos == 0) {
> +		args->num_entries = 0;
> +		return 0;
> +	}
> +
> +	bo_entries = kvcalloc(num_bos, sizeof(*bo_entries), GFP_KERNEL);
> +	if (!bo_entries)
> +		return -ENOMEM;
> +
> +	spin_lock(&filp->table_lock);
> +	idr_for_each_entry(&filp->object_idr, gobj, id) {
> +		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +		struct drm_amdgpu_gem_list_handles_entry *bo_entry;
> +
> +		if (bo_index >= num_bos) {
> +			ret = -EAGAIN;
> +			break;
> +		}
> +
> +		bo_entry = &bo_entries[bo_index];
> +
> +		bo_entry->size = amdgpu_bo_size(bo);
> +		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
> +		bo_entry->preferred_domains = bo->preferred_domains;
> +		bo_entry->gem_handle = id;
> +
> +		if (bo->tbo.base.import_attach)
> +			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
> +
> +		bo_index += 1;
> +	}
> +	spin_unlock(&filp->table_lock);
> +
> +	args->num_entries = bo_index;
> +
> +	if (!ret)
> +		ret = copy_to_user(u64_to_user_ptr(args->entries), bo_entries, num_bos * sizeof(*bo_entries));
> +
> +	kvfree(bo_entries);
> +
> +	return ret;
> +}
> +
> +
>  static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  				  int width,
>  				  int cpp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b3047d73fe07..338fd6d6423c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -67,6 +67,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			  struct drm_file *filp);
>  int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>  			struct drm_file *filp);
> +int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
>  
>  int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index bdedbaccf776..59b423883e91 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -57,6 +57,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ		0x16
>  #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>  #define DRM_AMDGPU_USERQ_WAIT		0x18
> +#define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -77,6 +78,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
> +#define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  
>  /**
>   * DOC: memory domains
> @@ -811,6 +813,35 @@ struct drm_amdgpu_gem_op {
>  	__u64	value;
>  };
>  
> +#define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
> +
> +struct drm_amdgpu_gem_list_handles {
> +	/* User pointer to array of drm_amdgpu_gem_bo_info_entry */
> +	__u64   entries;
> +
> +	/* IN: Size of entries buffer. OUT: Number of handles in process (if larger than size of buffer, must retry) */

That line looks to long, please make sure checkpatch.pl doesn't complain.

And drop the "IN", that's also an returned parameter.

Apart from those nit picks feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> +	__u32   num_entries;
> +
> +	__u32 padding;
> +};
> +
> +struct drm_amdgpu_gem_list_handles_entry {
> +	/* gem handle of buffer object */
> +	__u32 gem_handle;
> +
> +	/* Currently just one flag: IS_IMPORT */
> +	__u32 flags;
> +
> +	/* Size of bo */
> +	__u64 size;
> +
> +	/* Preferred domains for GEM_CREATE */
> +	__u64 preferred_domains;
> +
> +	/* GEM_CREATE flags for re-creation of buffer */
> +	__u64 alloc_flags;
> +};
> +
>  #define AMDGPU_VA_OP_MAP			1
>  #define AMDGPU_VA_OP_UNMAP			2
>  #define AMDGPU_VA_OP_CLEAR			3

