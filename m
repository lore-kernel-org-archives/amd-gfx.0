Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D398EC83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 06:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4027810E6B6;
	Thu, 17 Jul 2025 06:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vPHxIYgt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE5810E6B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 06:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0Y9yhkrhVUbvUOLuco+FNeZiq4X4ms2bgat5ZGKLr+r8xHe4qM1qFJngkZFjk/C4JR5xdoRF9JAkSrqIohe0NeTrK25xR2aHVaKhRdirhcK4jW5jgch9ORyaocGcNbeJ9mwM+PnXbHdhcaRn1RAxWr2MFG4fxJRB0IniXhClOA8yCHBL+7jnEUkI3eEgjAdm3l3X65Lcof4Yv1LXlWWuQDkVJ5fQ7bWRL9gM8XH8gTooQ85OZlN/y259Yi4tMfFcixmgWJr1TWYeNZoe+KFj4+8gKk2BIUUVSq6aH5wpj/kXV1XYStOVJCoy7aM4PN1pkoJr1TL5SoYbNskSuGkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxsH+qo5P78NY7Deos9lEkO8AQkP9NTXEBNQOeyCdEQ=;
 b=Q6eYVc+sZKLKKFH2M36/PElGj6aqVHbx7vDbHrdh3+jCNxqXjYZpyaZikbVN5aMKJ1SOasMgmViVCkkqdJYFRrFqei1J6ZggWXO0EWnvFzuYHwzArxVJGQ7TFOQ4v8HX+s/+TpFOPxDddrdERxjeNcIpVBh0yEojZacQhYMDgMS2kNsVgCQTZqYyKy1rrSo3ExhzoIOk9VD7FmwbCBcNOGfed4rAgwpDK2a5PZUxNXZRnaMYyQrF+7WpwlQi/Wl6Yt4qp7LEdr0b+76PeGS6LuqCnLLhbZ/NTM/RyhUlRrR73obA5rNfgGOz4qn+v99w3BbxMacrgMh8A25A//SeRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxsH+qo5P78NY7Deos9lEkO8AQkP9NTXEBNQOeyCdEQ=;
 b=vPHxIYgtBTgvpwg5lCy2gKd3CXtsUAkfeO0kXJpqezk2zznJtCITJnU6QqmekZvdcapbvKfDceOins7/VgDSGJDWwpo5KuRiRKNNDEf8Gfgg/ikc4ISdxth9ZPSihwLXm64Rd6NjS5Wrmqg3kpGtGN1GC0ZJhVjhypBJA6siMJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 17 Jul
 2025 06:42:43 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8880.021; Thu, 17 Jul 2025
 06:42:43 +0000
Message-ID: <c3943b8c-c194-4fb4-a5fd-0730e111c15a@amd.com>
Date: Thu, 17 Jul 2025 12:12:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: move reset support type checks into the
 caller
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250715160051.533747-1-alexander.deucher@amd.com>
 <20250715160051.533747-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250715160051.533747-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::6) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 914ee654-e843-41b1-094c-08ddc4fd21f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1pncTZpenlTSkF1V0NhZVN1WlZhbU9ZZ09UVkNhNHZ6K1JleG91NjR1RzU3?=
 =?utf-8?B?MWxKZkU5OVBBWHNQVW55OXlCUzFvRzhsbmQ2NUVMNEtJK3B6RnR3T1VCQXo3?=
 =?utf-8?B?OHMrV2QvN2EwNUlha1MxaXROcmFWOU0vM0E3enAzOWdrUHNMb21xTE9Mcmox?=
 =?utf-8?B?bkd0aEFUdUZiR0VUTGp3cEUybmk4NmtJZHlLUjFnRElyZUc4U3A1WE1kRFZL?=
 =?utf-8?B?aGxpTUdCcTVkM3pJUkZxQm5BSTFqYzU0UUpXVW1KNnRrYkNMNGkxbkdmdk1I?=
 =?utf-8?B?ekJBOUZ5ZXZScTA4WEhVQ1VFcU1HYzlHclVhRG4zTHYyY3pmSUZPQVF5YUxj?=
 =?utf-8?B?NUJsdmJVS1FCRmNGUEM4dXNydnY2TU9VVnUyRVhpWHFtVkQ5THgyNXRiQnFx?=
 =?utf-8?B?NElzaERyQVljN2h5V25seXhNMWk0cWFMVHJaNHJubTR0YmtvQ01udmhuZTd6?=
 =?utf-8?B?NzJ2RnNLWUdENktxazdBeCtqam5ndGpVdWVsL3p2MDBHRk9pbm0vcnduTzRV?=
 =?utf-8?B?SlNBTTlTdW9IaGU4Vkg1TVZLMFlibWU5cms0T2ppZURaNzl4M3FDOWhNZE1i?=
 =?utf-8?B?bkhkWlZlU251Z2xDSmQ2bzFJWFB1V2FVamZTRkhSUGQzNlhKNEpMQ0tFN2I0?=
 =?utf-8?B?L1crem9UN3BnY2J3YkFreHY1cUFEY0hDMUMzeHNzeVkxK1p0OXJHZ09rWCt6?=
 =?utf-8?B?czk2bkcxeTczaVorTVJFc2lNdnUvNFlkNDhhNHhyTHd3THcvLzB1QzU5dlkw?=
 =?utf-8?B?bmhKanQzMjc4UnJ6cDA4c0k0dWJpajdLZnc3M0dnK3NqVVBpU3c5a2lxLzFJ?=
 =?utf-8?B?cmtldHRkcEdndTFrNmxaS2ZEVlZIa0NLekpNRlhuUnNhRkFXYkl3UnB2ajFF?=
 =?utf-8?B?MmxpTWcxT3JKb0ZFeFlQL1RIaVlmZmlXeVNTZzRrVjhpMGhKWC9LQmU1ZWFo?=
 =?utf-8?B?VVhqanNIbFpPdldQYWM0VjhuaUdmTG91dlVRM255MFZsQjFGZTBUTmdFSy9u?=
 =?utf-8?B?OGlrQXBXUWcwbXF0M1Rwd2pRR01oQnZIQytPcldaRTVOcm9kdVhDbnA2VVhz?=
 =?utf-8?B?V3ZodXF6S09uRERlYktKRDRYd2VxMVRPOFI0RzUrYVlXL2lDZlZaSDdqeENq?=
 =?utf-8?B?clBsbk00SnIzVW0xZStBaTJFUjdSMGdzNys3S08vTitGT2hMYUkrdVVDM2Y2?=
 =?utf-8?B?bVhudWMxSktLRUZYenEwVDR1OHRYYzVTcFd1TlhqQ3k5b0FLRVR2K1B5R1VQ?=
 =?utf-8?B?UVkyNUNHSFo4NHZyeFpvRllrTnpkbkU5QmR6TVFhTnk3ZnBNVE4wb3V1NG9z?=
 =?utf-8?B?NllvM0lXZXFXVnBad0xVSXV4RkQvNEpOK2lCbStKQUVab0F6WE5FTWEwSjN2?=
 =?utf-8?B?cERpd01IOC9jOTVTNWtTelF5K2I3ZnhqRTlWcHRaaU1pSEZQRXlmcDkvVHhx?=
 =?utf-8?B?dHNnV2dTcHZ6aHo3WWNuemJsYzcrMWRWTzdMeFpFaTdDSGF6QjZHa0p0a0Yv?=
 =?utf-8?B?NEg0YVpOVWsrbHFxK3lpcXdodVliODhEdXZhMjNnS1FzNTUvMWZSTFdyWnp0?=
 =?utf-8?B?M2VOV2lRdFUzQzdsc25Nbm9XYko3YWZNUXZJaEFyclJLd3Bzc29OVFgzSUUr?=
 =?utf-8?B?NnlqSzZpU2pOSWJ5aGtHRkIyM3lrRjNSQ2Y0bXpmL0paRSswV1Q2ZHBObXFt?=
 =?utf-8?B?YTdqdThjcTBZcHAwMFRXMzFJdlpReFVwMERxdnoycnQyNnZPV2RLcFV1T2FH?=
 =?utf-8?B?aUZibVZmamtlOGVPbHBJd3g2eTMxdXdhemJhQWN3T2poZUh1Q214VUQ5aEtM?=
 =?utf-8?B?Z1VjeklsTE5zUzdEcExmam9CTVVUakljQUlPZEJkakN6VUQzK2Rrd3dhZ25S?=
 =?utf-8?B?dXdJb0ZvWnVWbGVsWE55OGZveGNudHdIc0ttM1FQUm1wNWFEdVRIS09jN244?=
 =?utf-8?Q?B02BxX+uwjk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0N1dnRQelR5ZGMvYTUrQmFSbW42VnlyZHNUT0dERTJqSVNYcXRhOTRwMVR2?=
 =?utf-8?B?VlhSUHFoSUREellWSHN2SVg4M1NlOWhjbUhDOGhGKzZHQTYyN2NVU1dMVWlD?=
 =?utf-8?B?NitiRDFIMFNoREE0RWt3QUJtOVB3RkZ2bGFBbDFuZTJtdVE2OGRKeFBmWnU4?=
 =?utf-8?B?R1RSbTg3V3B5QThNSktYaFJoVitSdXF1RGlVU05FQmZ4S25JNktNL1JuR3lR?=
 =?utf-8?B?NTVpYkV5dFl6NjNDSE1sTTBzWmd4L2ZsZEZpZTRNMlc5TXRGSENuNFZObkF3?=
 =?utf-8?B?enF1QnFOTlFqeXJXMWhaeVU3dlpSSnZpR1NUK3pzNVgySVdyc0NvR2N0OThs?=
 =?utf-8?B?Y2J0RXFqMEZsRzBLaHUwWjRFZXpXRFF6VUNjVTNFdFJwbkd1WXd3VnVzc3Rs?=
 =?utf-8?B?VEdST0tyd3h5Mi9FMkUwc2FXRG9XLzZNVDY0UkgwZ05iaW1kbUlqRjFneDhN?=
 =?utf-8?B?ZDJHYkJ6T1pubXNWcWpGQm1ReEtpTHBGTUFDanpzKy9vK0M3bXhzUnp5RDMv?=
 =?utf-8?B?d01qdk1BS2hsZ1A4Uk5IRW8wTzJnTDBpbGFUWVVoMGw1ZnoyTjIydElTVEly?=
 =?utf-8?B?Q25qL1FnTHJGM1dNZWdRNWNjR0ZqLzUvSWlMcVF4WFpnaW5JZXhmaDlFTWFZ?=
 =?utf-8?B?K1ZEclcxa0JQOVFvVk1GMUxNSUg5djV0bWVkU2hwRkV2RTQxUDJIUzRKbjA4?=
 =?utf-8?B?ZGdINTNGVktFZDY2bW1TZllQd0M4VzIwNmEya3RWVW85Wjlpb1ZMaHFHV2dt?=
 =?utf-8?B?V1BtenJMN0FxQTF3STVyNkhiK2JHRWlJNG82ZXVueThHMFRxbWMvaHVJUzlV?=
 =?utf-8?B?SVR1dUU4Yms2NWFML3VndVN5d25HQk0wUDRnazA4d0hZckVBN0FML2dhbUlk?=
 =?utf-8?B?RCtaN3R4Y3c4WUhhVGxRK21sL09lQzZGV0VoaisxM01OWDg3ODVpaGdIdSt2?=
 =?utf-8?B?UzkxTHhhZnRtN1dnMk1GdXFldDVxQXVYS1ZmNnZQczhkRkV1bkkvdmF4dk5C?=
 =?utf-8?B?MzZGMEhSb1FLVGk2NjdUS3FZN2dWSzBYNnpnallkSXhYTTg1dVlkNWFOOHlD?=
 =?utf-8?B?TTdyblpmL25KYmF3alo5ZDJ5MUV1SUtpa2YwL3FIRlNUOWoxS2c4SWY1Tm55?=
 =?utf-8?B?RUd3NGMvSEtvc2loVS8yWVZlSFlEV0x1UzJwWnhuaW5HWU9OblZHajUzb1U4?=
 =?utf-8?B?dkU0aG5GUG5qYmQ3Q203dExJSmJQZ2grK050YkNvWGdOWDc2UHNKOTc2SmE1?=
 =?utf-8?B?SHRpV0RkcmdxOW1pK3pqRGRyRGxaQmhxdVBYZ050M204dnc4b294M3NLZzNW?=
 =?utf-8?B?VERxbkhsSm0wWEFQOENKcm5EUS9Ecm5ZV0Y3MEtBdloxd3NTSjdWeEI4TG5D?=
 =?utf-8?B?Szh4TmY5T2hPeUxQUzNISnhKMnZtYVlLazE0UFdGalRFOWcrdm0wV2tXbzZt?=
 =?utf-8?B?QVpTNHovNW1jQXVveURYSWtaNWl3LzlLZ0wrYTE3WnhVUVhGcHBWZWdKZk5k?=
 =?utf-8?B?dUVtNE53dHBienpmbTF5a00va1V6UnN2T25WeVM3dThoTS9Kb2paNlRvS0I0?=
 =?utf-8?B?Um1vM3FlMytsQnljTTgzMkN3TVhFWmZiOHBqK1pHc1RDMEx3RlhCUlJsZTl5?=
 =?utf-8?B?ZEh6a3ZMbHd2eEJoUFNuMHJGemhXR3F3c3JjeXAwY3laaFhuL1JDUGpxdjBW?=
 =?utf-8?B?eUxqODlHVjc4NElIRnRJbHVHdDM4U0d6aXBXRFh4YTZHenl0WUNiU1pNZ1hM?=
 =?utf-8?B?ck1sNklMdmlhdkE4TVptLzFnMEJOdjlBSUtKWVowZWlGd3dtSlFMd1pxSmZW?=
 =?utf-8?B?NXZrQzlja0p1OENMZ1lyZGU3YlNBM1FaSjcrL3R0VnlkWmFHcURGVklKR0dX?=
 =?utf-8?B?WjZTSkc1WGhiSW13d0ZtQ3hqeEJ1TlFjYTRIQkc3cnhrQk9HL1UwZjE5RTM4?=
 =?utf-8?B?SUU4RE84SWNBUjh4OEJYcFFYVlRLdlZEdmFMQ0ZJaXM4NWNvK1NXUjlad3Jt?=
 =?utf-8?B?L3VOaWhSNWxnRmwxSWZURUI1TXZ4YytmMHZYOUhDaDdwSTlKeDNvK1FBRDRI?=
 =?utf-8?B?anhEVzBYNTkvMGNhVnlmbFFDMjFjZW0vUmtud0t1QVhHREtmc2xKZWUwUkVs?=
 =?utf-8?Q?J+sDIcB3eMem9yd9SbvpS9bIz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914ee654-e843-41b1-094c-08ddc4fd21f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:42:43.3439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYGMZzYydLkB2D8Jd//sx4Q2uUzytokDv0qSkpYBKb6RB5CZ9uhja86Z315729ZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889
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



On 7/15/2025 9:30 PM, Alex Deucher wrote:
> Rather than checking in the callbacks, check if the reset
> type is supported in the caller.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  5 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 31 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  3 ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  6 -----
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  6 -----
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  6 -----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  3 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  3 ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  6 -----
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ---
>  25 files changed, 37 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 45febdc2f3493..8635f66921335 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -111,6 +111,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		amdgpu_job_core_dump(adev, job);
>  
>  	if (amdgpu_gpu_recovery &&
> +	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RESET) &&
>  	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
>  		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
>  			s_job->sched->name);
> @@ -132,7 +133,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	/* attempt a per ring reset */
>  	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
>  		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
> -	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> +	} else if (amdgpu_gpu_recovery &&
> +		   amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
> +		   ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
>  		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 09d7681b7a754..4f69aa60478a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -820,3 +820,34 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  	drm_sched_wqueue_start(&ring->sched);
>  	return 0;
>  }
> +
> +bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
> +					 u32 reset_type)
> +{
> +	switch (ring->funcs->type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +		if (ring->adev->gfx.gfx_supported_reset & reset_type)
> +			return true;
> +		break;
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		if (ring->adev->gfx.compute_supported_reset & reset_type)
> +			return true;
> +		break;
> +	case AMDGPU_RING_TYPE_SDMA:
> +		if (ring->adev->sdma.supported_reset & reset_type)
> +			return true;
> +		break;
> +	case AMDGPU_RING_TYPE_VCN_DEC:
> +	case AMDGPU_RING_TYPE_VCN_ENC:
> +		if (ring->adev->vcn.supported_reset & reset_type)
> +			return true;
> +		break;
> +	case AMDGPU_RING_TYPE_VCN_JPEG:
> +		if (ring->adev->jpeg.supported_reset & reset_type)
> +			return true;
> +		break;
> +	default:
> +		break;
> +	}
> +	return false;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 309e7bb6001bd..7670f5d82b9e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -568,4 +568,6 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
>  				    struct amdgpu_fence *guilty_fence);
>  int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *guilty_fence);
> +bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
> +					 u32 reset_type);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index d799bc74936c0..f1f67521c29ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1522,9 +1522,6 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  
> -	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (adev->vcn.inst[ring->me].using_unified_queue)
>  		return -EINVAL;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 744f51a6f522d..7bd506f06eb15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9523,9 +9523,6 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>  	u64 addr;
>  	int r;
>  
> -	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> @@ -9591,9 +9588,6 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>  	unsigned long flags;
>  	int i, r;
>  
> -	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 465fcd6503735..c01c241a1b063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6808,9 +6808,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
>  
> -	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
> @@ -6974,9 +6971,6 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r = 0;
>  
> -	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 5d32ae4b1a4c9..09bf72237d1d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5303,9 +5303,6 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
>  
> -	if (!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
> @@ -5421,9 +5418,6 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
>  
> -	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 9c0cdf4dde714..20b30f4b3c7d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7183,9 +7183,6 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	unsigned long flags;
>  	int i, r;
>  
> -	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index d80f1fb261d1e..e2a726669f7e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3563,9 +3563,6 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>  	unsigned long flags;
>  	int r;
>  
> -	if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>  		return -EINVAL;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index b93d6af8f6e54..58239c405fda5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -773,9 +773,6 @@ static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> -	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = jpeg_v2_0_stop(ring->adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index b6d5ba0bdc143..3e2c389242dbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -650,9 +650,6 @@ static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>  				unsigned int vmid,
>  				struct amdgpu_fence *timedout_fence)
>  {
> -	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	jpeg_v2_5_stop_inst(ring->adev, ring->me);
>  	jpeg_v2_5_start_inst(ring->adev, ring->me);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index a229d7eb900c9..a44eb2667664b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -564,9 +564,6 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> -	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = jpeg_v3_0_stop(ring->adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index f3a9073b8b243..da3ee69f1a3ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -729,9 +729,6 @@ static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> -	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = jpeg_v4_0_stop(ring->adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 1892c278ea3c4..481d1a2dbe5aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -774,9 +774,6 @@ static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> -	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = jpeg_v4_0_5_stop(ring->adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 0b4de0c6476ae..e0a71909252be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -650,9 +650,6 @@ static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>  {
>  	int r;
>  
> -	if (!(ring->adev->jpeg.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = jpeg_v5_0_0_stop(ring->adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index e622db1f818bf..54523dc1f7026 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -836,9 +836,6 @@ static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
>  				  unsigned int vmid,
>  				  struct amdgpu_fence *timedout_fence)
>  {
> -	if (amdgpu_sriov_vf(ring->adev))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	jpeg_v5_0_1_core_stall_reset(ring);
>  	jpeg_v5_0_1_init_jrbc(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c0c418aa2c299..0fe0f371f6fd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1664,9 +1664,6 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>  	u32 id = ring->me;
>  	int r;
>  
> -	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_amdkfd_suspend(adev, true);
>  	r = amdgpu_sdma_reset_engine(adev, id, false);
>  	amdgpu_amdkfd_resume(adev, true);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index d8c19601dd2e6..7dc67a22a7a01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1547,9 +1547,6 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
>  
> -	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (ring->me >= adev->sdma.num_instances) {
>  		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 5d56029e88a62..3bd44c24f692d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1461,9 +1461,6 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
>  
> -	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (ring->me >= adev->sdma.num_instances) {
>  		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 5d31f318cb3c7..e6d8eddda2bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1578,9 +1578,6 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
>  
> -	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (ring->me >= adev->sdma.num_instances) {
>  		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 13abc0c46eab0..b8b06d4c5882c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -809,9 +809,6 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
>  
> -	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	if (ring->me >= adev->sdma.num_instances) {
>  		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index f642a06a77b56..1924e075b66f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1976,9 +1976,6 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>  	int r;
>  
> -	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = vcn_v4_0_stop(vinst);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3bda19b92cde7..2a3663b551af9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1603,12 +1603,6 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>  
> -	if (amdgpu_sriov_vf(ring->adev))
> -		return -EOPNOTSUPP;
> -
> -	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  
>  	vcn_inst = GET_INST(VCN, ring->me);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 039989ab452ad..caf2d95a85d43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1474,9 +1474,6 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>  	int r;
>  
> -	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = vcn_v4_0_5_stop(vinst);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index ec0268b5666cc..07a6e95828808 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1201,9 +1201,6 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>  	int r;
>  
> -	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> -		return -EOPNOTSUPP;
> -
>  	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>  	r = vcn_v5_0_0_stop(vinst);
>  	if (r)

