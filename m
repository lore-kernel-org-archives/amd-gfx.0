Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B9DC021B1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 19:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A170210E05D;
	Thu, 20 Feb 2025 19:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbNCg+B9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8724310E05D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 19:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Auqor2Aqfm2vxeWrr1Rl2fhd9ZZz26VWRpoGGN6FS+ICc1psOF5gHCUk4WDELgkdw+r1/oUT/nVa48a7xmHlb6jHVToJfdP7VdChomrGDakuU2HVXfJVKSwMPivuSEayJ0DhWjXjVaUdK8FAZDOHEAyNNz1/4T7gKrODsYWHprCktYKrnMMBaQRXN12LOyk5YwWqm7KfjeDSUHyDtTxWsy/A0XHMAOXG+QdYk0cZJmL7GGoXxT0FhDtMwnEEl6zwjbGjHehUMY2fWIAVrD3YsSnc7TPjvmfRNzVkFi+BWOKpZD5w4CFoUI4MAuuSshzmSDq6Dz1mGqpw/cTqGV7ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBI+X5m88/o5pMjV/AMEj2JOeqr1ccM5Q1vxSKR2LC0=;
 b=sqisyZg6+LOhvRLHfLV7m+XbuXTpGOVDywM2RQBnMg4uRAHk7OI4B4yO8gyJv6ErtkQ1Ceo0b9u9fXu2e8j6nnLEgOGfNzHjqPU5liaFGARTLYmB4t8xnuCU7Y6a1WSRkLHcoHCHwGEvS2uIfmZkWaaujsjK+Ejvq7oZFWkljiCUeL5OG4nyrJPXTYBTMcGMyBFfC/CWjuYIJVT7sNMA7VJLNHWzIXeGPajhC0dIpOuIuiDzF3tnRwx99I2XFT9seNZ7SgizXAVU/OUy70d9fZuO3jE44k6UQCAy65g/b4hwh268WcYHP2irAKbMNZr4mM7ODztW8mlARj3EB5UHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBI+X5m88/o5pMjV/AMEj2JOeqr1ccM5Q1vxSKR2LC0=;
 b=YbNCg+B9H4lGuKaEyHYsgxQC841wr83wHHEMLGbGGqYnvCjfRi2LE+8BnxQ8rD6No+LqdcePh6gCmSbSWS68H+hKnS3GIUwKOJR94hx3uCR/aX3WeKjcb93o1cRBuQyw6uqnAHgXYXKe21wX3UbOAzmCGOoipgif1wGbppDJJdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 19:52:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 19:52:55 +0000
Message-ID: <74d34740-83d1-459e-8b9c-3e98d12dd06c@amd.com>
Date: Thu, 20 Feb 2025 13:52:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add amdisp pinctrl MFD resource
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, mlimonci@amd.com,
 benjamin.chan@amd.com, king.li@amd.com, bin.du@amd.com
References: <20250220183326.2957649-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250220183326.2957649-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e1fd23-4da6-474f-f102-08dd51e82b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnFTam5rTFhSZ0UrK1NSd1FCL3M5OUI0aG1hVjZPVy96dGhQbDJ2UG82THQ1?=
 =?utf-8?B?TXdXUit3djlFYTJwZmhIeGZrQWw4YzRPYWpLWFFXQWRSM1JhUkxBeDJla0Nm?=
 =?utf-8?B?OGhmOTBwMTZrdjBlbzlndUROQmtwTVA2RnFRVmxiUDhDZEdpZUZaVTFZVkNG?=
 =?utf-8?B?VU1adytyRXlkSEs2SndIcXdjbURHYTlKanEydzVYQWk4cStFa0V5RmNKTFNp?=
 =?utf-8?B?Y0pSUUNQZDg5QXZFSjkyallaYXNUU0pleVNNUUoxeXN1c2pmOGtDTlM4cHQy?=
 =?utf-8?B?ZDZMaWNCaUNtdVdzcldORjl3ejJJN0taY0FpMkM0cjVrcHRXRHRCeUZjUnlP?=
 =?utf-8?B?bmxKeHpWMjZWMlgvWVowUnVPR2t0VEZZZmxCUG1oVXVQM0toeE9JUUdtTXRy?=
 =?utf-8?B?alFDTmRwbXhTb0o5bzFva0xrZDNDYjF2SllaQnA1b2ZKTlJjZG9ZSng4QVZ0?=
 =?utf-8?B?TTVTaC91b2pZQ0NqaDltNlV0S0VGcFpqblA1elhjaTZxMVR0V284YXk3Tk5k?=
 =?utf-8?B?a2MvaC9NazQ3cnlCVHIyME1yK2g4Y25RblZwUEF3NHJycjNFV3BrTy9lblZy?=
 =?utf-8?B?OFVDcEw2TzhKRWtmUWFyV3k2V3I0TUVEWWJ1SVo2U1czb0EyQzNEc2QreEt5?=
 =?utf-8?B?OGhmajA1WXA5QkJVN0tXTFRiMzQrZWNzMzNxbDdNcTUva3B4MkRyUlhIZDN1?=
 =?utf-8?B?S3B2UUU2YWI3TkMzMXh0REI3ZGRXcXpJdFVBbW9aUms4WUVjZFVCdHdjb2Zo?=
 =?utf-8?B?bFpVRWIrVGlHREkwOXFjNyt4UWdESFZzakUwancyd1V1cVdvK3BqTmx3Y1hZ?=
 =?utf-8?B?VGJxOWtaK3hmU2hoY2VsalBQNHZ3YjMzUG9nZTFieDZTbGpRZ3NlMjZtcnZE?=
 =?utf-8?B?UHNBMGEwQzVHbHl3MTRHUkFuYUFwNGhyMjIzb1cxSGYwZ0drTnpER0RPQUxq?=
 =?utf-8?B?T2laY2tyYlN0blpBWFk3SjErcDZURE5tVy82c1dnT2pMWm8ydzF2QW5UN2dr?=
 =?utf-8?B?TTJQN0dZQ1kxM0krSXFSVnhtRUk0akZ2U2RpOHlKSVhkRndCQ3FYeFErRFJ5?=
 =?utf-8?B?OXVHbGFXT2o4MTM4eUtaM1JTT0FGM1d1YzhMK3NZblZOOVoyR0JSdk9lM1N2?=
 =?utf-8?B?NXpkSUpQTmVtSWR4dzdkM3NuR3h4SFJWNUphSkhNcmtITm05QXJ5MzdMY3lL?=
 =?utf-8?B?djgrbkpsYlZNYk1HNVFOa2JZbThBbmhwbENWc1diRU5ZZ1Q1bjFNalRublNX?=
 =?utf-8?B?UUJGYUo1cEphSVhhZklrTTM0Q0w5QWdxSUVTUmgzVjlnKytoL2U1dlNiUmFz?=
 =?utf-8?B?ZU80Wm8zQjl3SmtjamQ2Z3pBZmJ0NXR2RlJpaEFXb0tUaXVldlh6Uk1tdG9T?=
 =?utf-8?B?NUdKTkFobDgxUjBEdlFqT20zSE5ZTTBEUTBCejlWK3pHaHk0cVBIYmNzekw0?=
 =?utf-8?B?cjBVSG11ZFhua2IvYWwvdmNVLzNveU5OTU53VEVOa2I5c1ZyR2RPUjFOYW9u?=
 =?utf-8?B?NWdmUTVuR1AyallGcnNTTzBTd1JHaS9TNytNNEVqK3J0cFd2Y3djZXFuU0R1?=
 =?utf-8?B?djJuODM2NEFqN3gzKytYRy9hTi8vWnJqN1J3MC90dlUwd0xtR1ZCSFN1WGVF?=
 =?utf-8?B?TWZyRjFWcnN0UjR0aWZxM1NnZ0FMVjJqcW4xODJ6VHl4YzlPa0xzZGN1eVZ1?=
 =?utf-8?B?ekdXeXRGVXZscWRqMFpGeU9HT1oyK0lYYUdIeFlWT3R6SnFlczhhTjBEbEtW?=
 =?utf-8?B?dk5rcDZkV3VlMDBIeVRLRTRZTmlmUHBUZnZHUU1OWkl2RjNBMWIzaG9Haito?=
 =?utf-8?B?TXM5TVBuOU9KUG5GOXR6czZtUVdjZXNZY0FhSmorcGlVWitSUjV5aUVmUVZ1?=
 =?utf-8?Q?6KlCymIlpn4tg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGt5R0F2M3NWbHExMzVZWmVkeGx0Wlh2eXJFaFQ2cUVOcllSSGtCSVV2QkFH?=
 =?utf-8?B?MjJnZlZqZGZVVTk3Y1FEbFVVK0NMcFl6V0ZqQmVUb0lnTUMreTdDdGdmNEJx?=
 =?utf-8?B?bjhWN01WVlUwMGNjZWNmb1R4OExYYi9wZ1Jvb2plQTh1S29SQ0YzR0Y0c0E3?=
 =?utf-8?B?UUdzYlFKUHljVnlsZnM3QW9qM0hUa0NDL3h0WWs0QkFQczkzVXN5N0dHeHFC?=
 =?utf-8?B?cENhWG1JUHNKM0dxYUV1Q0pjV3NRS0VmUFI3VW1tUHBWYVg5VVhOUnlpS2tD?=
 =?utf-8?B?NGVlYXA5NDRzSCtzQjZyTlpQbVdDVDdnVmRUd2szbWVocnBmNE5taXFUNExX?=
 =?utf-8?B?SjUwUGlGODZxMUp6TzJpMTBRYjl2cXdlUnE2NzdVYmhmWEZuRkd1aWtKclhI?=
 =?utf-8?B?eTRzUzA4ZE4yS0ZXUjRHTWRpaktMWVh4WEZLSGMwMHpDTTNrcElad3dqc01x?=
 =?utf-8?B?UTk0bEIwK2ozUkNQa3J3QWVoWTRBVDFab2VKT1dnc0NyT1hLdUNTbS9udzY1?=
 =?utf-8?B?VGJ5NmdnMkpyWUV6THJVU1BwNU1aQ1M1RWwraVpZTFpIUzBsTHI4allrOXlj?=
 =?utf-8?B?bS9oc3ZhYXV0cWQ5T25VYjFhaTlrcXpXMndVek9qV1VUUERKRG1MeEJ5VnlF?=
 =?utf-8?B?YUxpVnd6OUJ3MHU3aTdCSFpQRW40T2FTWUg5bkkydWFCaTdDdmNyOWxuQTYz?=
 =?utf-8?B?SDJaOW00eTFWZ1JvTTZIcE5xMENHR0JPc2l0YkhxV1Fzc0xwNGY0WHFuc0xF?=
 =?utf-8?B?QW56NE1vQk1WbUtzNXZDd0pvU25acUx2Yzl1WCtMMnU5UDRhK0sxNytkbG53?=
 =?utf-8?B?dGlLK21vRTFHT1FyazdMbUFHZWlHczNmczVOVk5UUjh6Y216blFITDczcE5Z?=
 =?utf-8?B?RkNwNGJVYlh6WWowdmhhOW44MDNhRGJpS2tyRnY0cVdkZTM2OXNmYVovYXZB?=
 =?utf-8?B?MkZDRUt4TS9paXpBdWpLVnY4dVM1M3gvQnM1VzhjemxwV2ZkZlAzekppV3hj?=
 =?utf-8?B?OFdCRE9jUjMxSmxCL2FoVk1PK2FoYlU1ckRlaUd5cXpMSjUxMWVHVWQ4VFVy?=
 =?utf-8?B?MnZMUURFWXFEN0N4N0tRUVUrdlpONzVaUjZnNzhuWHlkS3RUWUlBUE5UanRG?=
 =?utf-8?B?bElzN1FYVHdHdVRXS2toSXhMSFdIRHV4eG9Bb2dmdkROOUhUS0tpbzFJWS9q?=
 =?utf-8?B?QVJsdENBa3U5amUrOUpGOTZGcStTbVpZbmpPc2FYYVBtY3lucnBFTFl4WVJC?=
 =?utf-8?B?eE0xQmp2UGRIa1I5NjhFa1hsRmJVTGZrWVBVckgxQVR4czI0SFRLZm01WGdz?=
 =?utf-8?B?b3ZOSGRObStoM2VVZDdlcDZOV0NXT1JpMXl3bElJcU1XNTc1ZGpmMEl6MUw0?=
 =?utf-8?B?amxmVWVyZ2ZJa2R2VVE3OVVqYjUrL3FiWVkzTFdWZW04UEhJRWhnMlZZWEJF?=
 =?utf-8?B?NjlxQTNpOThVTkpLN2VmVmt5NENLVWN5c3cxTVZCeGZ0bDhoc2NBb3ZaVmFY?=
 =?utf-8?B?anR2TUcwTWtCK0pIdWw2UkpsOHhrTDBzQzVyWVBJcUxKL2k1UHBVS1JPQ0Ru?=
 =?utf-8?B?Q29ldSsra1FHUnJOWVQ2b0p3WW1Ham1MdzNaNmtHUElkLytuU3hHZFN5eTNR?=
 =?utf-8?B?TktvcC8veWpwVXRicXJzRndEVXkyRmRybVdwbEVsRlRSN3JORXFVTC9TdVIx?=
 =?utf-8?B?UWNQL2tNRUJMSi9wS3Q5dVlFMFRBayttWkJQVXJzMDFzc2tpbSt0cGl1SGhH?=
 =?utf-8?B?dU9zMVFhSXdUUllHaUs3OVlHK3M2RStjTnpXSXFXa0dBMmxDcUtHUUlmRjk5?=
 =?utf-8?B?S1l1RThxNkhvb1pNS0ZqZTVEMjRSWjhPN3dwbDFCNDFtS2JCblI1VW4xMHQr?=
 =?utf-8?B?Vm1rbWJBRkRlNFJkMDJEemI4RmJHaEdUb3hqU2huTVZhdGZUOVY0MlF1V3Vo?=
 =?utf-8?B?L3NEdEdOTjRVd2p5dnk1OHpHR3BMYTNIYk5rRjRKMWNuU0Uxa0hoUmN3Nk5P?=
 =?utf-8?B?WEdhemRIdGRGM1hsRDNBZlFNbnpuTVFUWWJKVnJYTGU4VW92L1dBeUp5MzZ6?=
 =?utf-8?B?aVlSNTJtN3I2VXNmRVJKdDJXUGpOQU9wV0pmVG44ZnFySVNBSUVFVEk1Rm1N?=
 =?utf-8?Q?cTvcVZcVHooCe+N3oJQ8dEaSE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e1fd23-4da6-474f-f102-08dd51e82b37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 19:52:55.7553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMv6dBaxoQtefjDsptcm8D5Aq9TBkRECLkSd3eHifzQVdEuvoSep/vsLblx7O74QWPlouFZ4RFb23cqkuFamDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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

On 2/20/2025 12:31, Pratap Nirujogi wrote:
> This patch series includes two patches:
> 
> patch-1: drm/amdgpu: Replace DRM_ERROR() with drm_err()
> patch-2: drm/amdgpu: Add amdisp pinctrl MFD resource
> 
> About Patch-1: DRM_ERROR() is no longer preferred. Replace
> DRM_ERROR() usage with drm_err() in isp driver.
> 
> About Patch-2: Sensor module power is controlled using a GPIO.
> Instead of accessing the GPIO MMIO resource directly in isp driver,
> a new AMDISP PINCTRL device is added, which acts as an interface for
> the sensor driver to enable / disable the GPIO to start / stop
> sensor streaming.
> 
> The GPIO resources required for AMDISP PINCTRL device are passed using
> the MFD interface from amdgpu.
> 
> Benjamin Chan (1):
>    drm/amdgpu: Add amdisp pinctrl MFD resource
> 
> Pratap Nirujogi (1):
>    drm/amdgpu: Replace DRM_ERROR() with drm_err()
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.c | 57 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_0.h |  4 +-
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 54 ++++++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.h |  5 +--
>   5 files changed, 82 insertions(+), 39 deletions(-)
> 

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
