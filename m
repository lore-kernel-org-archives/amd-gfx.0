Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFC8C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 21:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B698E10E3C7;
	Mon, 10 Feb 2025 21:18:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XwtoPr/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDBBF10E3C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 21:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWC8hbXra4bHO12X6ljgUkrulwq9SBaHch8HBZSrT/PTOzOeW4F73Iq/xl8mfQihxaaFvcmojo3dj1YSupcG9M/XxwCRiSiJQLAO6G16vMQu8L1RnEAKrQoiEa3kVNF0ojz9Wxg3Qgp1Aqd5vYLh5gdvliBdYnP0MncRC5udv1WgRLUdHUJJmxOgO5K0So63/J0ueG6Bd01WZ2BNYClU+P3XhqWn8H3EAz2UwQSJeKQ6kOF1qnK+mnN1S9R94G8wAxTg63YrRsi1MrR8OwgwItV5dnkqgiWRKZVMOnUhzFE7VPGEGLuzjcUrGCnTcmQjB7ghKwZrftSX9ZAlhmq6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOa31H72BBZUGGG+Gjr8yBAMjWUDLZazKNeTs+otywc=;
 b=H88gwlGoP9Nx94PTP9dmyOkgnMcuGfoMpVMWKkopKNiN+tyCKiB59/VDjAl6M3rsPEjfA+Pty0W79iG+ioxJNfOEAjIfCPsIrMr30z7RNZvM1hLbsN/PjJ0nexjDHZIdUAOeLhGiRmtC1VpERhM7R7rxaeOhvYQRiFFmZ9iriaXpedvOVg9W+W/F+tNPYGcKiNcG8lsWuM9K7YpXGrLpOSDeCf8IFwA+j43PiNClfhiay2bZs13EZgDX8+MoW68m/Rf9UNM5I89pK09cZ695t+Uj8sgzQHko5ae/2MPuh00D/eDIcmEKdruFGxN+NuzLjG6E4pzKBDwUJeS1x/8VDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOa31H72BBZUGGG+Gjr8yBAMjWUDLZazKNeTs+otywc=;
 b=2XwtoPr/EcDWzvq5f/R9VG1gsiEdKcDTp0i0vYbYEedCikwvyAf2o5H0r4ncXaFteAkUeKCLEvmLp98oyoJKxlIb+wVEkLrKmVJzGzbl0AYXvRbmaVXP2ubHEA8Eu5c/e+l8YUdIpTdAreqnyts5RvcUOlGCbiAeFENgkQzEW+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 21:18:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 21:18:19 +0000
Message-ID: <b71dc4e6-a3d0-4b6a-887a-b0e110f5b617@amd.com>
Date: Mon, 10 Feb 2025 15:18:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: add support for IP version 11.5.2
To: Ying Li <yingli12@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex <alexander.deucher@amd.com>, ray.huang@amd.com
Cc: Richard <Richardqi.Liang@amd.com>
References: <20250207212734.1986678-1-yingli12@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250207212734.1986678-1-yingli12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: d8012e44-86a5-45e1-6b1b-08dd4a1870be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alFIa1YyMkROSUZ6Vnk4MlU1REhuTnlWVDNXTzR3Q1E4V1RXQm1Ob3V4RlRY?=
 =?utf-8?B?ZGV6bndudlA4ZWpPanhmekZ1dEgzZmlYeEhBUjhEeC9IMUh1ZWNlMkRxRTBw?=
 =?utf-8?B?YUo4VTlXRjN5RndtdEUvQ040ZVZacUJ6dmpzNWRsd1g0c202Zm9zM0xHYzNi?=
 =?utf-8?B?R0dhL3FSTHRSUTR6MzVkR2FxME4ySzZLVGYrdWMvSTJSb203aUhSU1YwZWRi?=
 =?utf-8?B?NVNkLzNUb1FlTFVtU3J2dUFqZGxwYStRQW9BcDZHbTRabFJNOThTTDQxc0ZO?=
 =?utf-8?B?RVcxZnRHcS9XbGhRRDdLT1pCTEZCZm1WQ1poT1kvREJIRVFJV1Y0cHVyVHR6?=
 =?utf-8?B?cjZrS2VJeWNBVkZlNVE3OEdabkZ4YU9nalpzTC9VM2FZOEJpeEF4SzRGSGVR?=
 =?utf-8?B?OGtCbDQ2MXpPa2JMbk9NYXlxOGhqdFhvME40UjkxUWpjd3UxYWNMTUl2ZHVU?=
 =?utf-8?B?L2xPd3RRTDFab3N2QWNyVldmRVNUbE1PZVRXdm5OSzRQblBvTGxmOGVsVVJH?=
 =?utf-8?B?c1lJTldUbTRERzNRNkZjTHdWY3RzSDB1cHFvditzWkg5U2ZoRjhFMFdadDdD?=
 =?utf-8?B?bVZKV1Mrb1VjclR4blFjZVRBSUY1TmFqbjlQWURjTjlTTFdoK2N1cXJFZy95?=
 =?utf-8?B?bmVJWUhFTGFPdW5obWY0cEtaZ0hKRmJLZHhvTzVHV3JaTmNRY2lxbm5idVRj?=
 =?utf-8?B?aCtRQ1AvRUl0REJ1akY0cW9sVkxvTEQvYWhvNFdKUjNkb2FOckQ3YURpdU1p?=
 =?utf-8?B?S1ovejdPc0VqZlhDdDlZcTJ4cXRkMzBLYThoUmJzMzgzVmFOVk9TV0kycS9T?=
 =?utf-8?B?SWFYNzFvOWpSQnZFRmF5OWFWMFNBNURGSitVYzZWajZSMUR0Y01lcTBRWFdp?=
 =?utf-8?B?eDVKMWMwcmxIaHFLaXVlL3B6cVpBbENRcG1FMTM4NXFLZHI5RFhDbS9JRit1?=
 =?utf-8?B?ZUdlaEpXQStGaXdLWE4rWWNMZmoyZGxGbXVnd1UvMm1UNXFpajBveGZUa0lI?=
 =?utf-8?B?L2VodzhHWkxzbkNwdE5ncFFrbVpvSUc0QXJWSEVWd041VDUyUHN0RUQzTzBn?=
 =?utf-8?B?bzNGRk1nYzN6RUxMZVhoS0VJOHNoVERLOHpjVzBLbGdPYlBtdVdXeVk3d3Ba?=
 =?utf-8?B?Q3p0YXhCdFE2VXB4VnJCOEhlMU5Sdmc3YjJQeXI4Q1AxdTNDVTVDSzRsa01i?=
 =?utf-8?B?VUttaGhQcm5ZdXptaDBtVkVMSDlwNTBTVkxkWXN2QkNZc29HcGxtZDM4TDFq?=
 =?utf-8?B?NmRMNjY3aFplWnVaSy94RXRuV3grUTl5UmFBVkE4QXVrNndORnZVYUJlUFJ3?=
 =?utf-8?B?T3VYT0ZzUklBbTBSQ0thaUFQTmZmMkp0cEwvZmZzR0w5TnVYcnFPeDRDR2NM?=
 =?utf-8?B?WmpsNmJUcmY5djZ5S0RkOVJIb29sVnVuaWNCaUNHTEl3UXd5WEdrQ3p5ZWc3?=
 =?utf-8?B?Qnd2TGI2UHFHK1NhUEFwbkw2NkZTenB3dDY5dFdieDB5QXlyWWFuaUl2VzR1?=
 =?utf-8?B?TlFvczZpbHVsMTdBRTBoTkFORlBDQ3JjVlFuOENOSjMwT2E5VnlNd0tjNFZE?=
 =?utf-8?B?RWxVcTU4VnJsNExxRzR5UGxuTWt6MnRNbHZzaEZNMENCL1B3bGpucGtsODB3?=
 =?utf-8?B?Z2p5eE4vVC9IMlVDR1BmNHA3WktGTUIyd3N3M1dIcFFvUTVWNXNYaEF6T1BV?=
 =?utf-8?B?UHo1a1pMTWZlWVVPUm9jbFlCcnZid0crV2p5U2kxKzJpcGJkODJ2SHN3RmJ0?=
 =?utf-8?B?U0M1OVlrdjZDcWJubVB0dkFGQ1BCOHVXb2o4c3A3L3l1VkU3MDh4dDRnM3p6?=
 =?utf-8?B?OXZ0M2V5RFdsNC9zM2xhSVhnU3N4SUgxa2pwdXNkdWFGU2FHMUFscEwzUUNh?=
 =?utf-8?Q?4DG/ZziEPvO0x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlpScHZ0cmkxaU5BandiMDdVSmUzTDh2STh6T3plYUJjQWIxUDJBK3BnM0Nn?=
 =?utf-8?B?d2hROG1aeUhrMmdJTE9CT1pvcWIrczRrYllMcC8yT0drWi9ycERlSzZ3Z09k?=
 =?utf-8?B?bHI0VDF6MmQ5cDRTd0kzeWpJeWN5ZlQ4clZmNFgvZ29zT1g5NnFtelpnaVNv?=
 =?utf-8?B?OXpqcVo2Zm9JMHZybSt3bVdCcVNwdkIrQm93a2pRd2d0cFBIVUtBZll5YmJl?=
 =?utf-8?B?MERmNXJmbktIVUdMWXlBM3B4aEhuN2dPM1B2a2M4Y2FWUGRBenllam9vWllp?=
 =?utf-8?B?YW1RV1diQzU2QTFzbzJCQzFSMzFHSzF4Tmh0V0FKR2dIYlRIRlprakVkNC9O?=
 =?utf-8?B?a25Od295NVFYQmI0elo1Tys0dGxyTFY5RGtZL1hWQzFuQTY2ay9pVVlxaXE1?=
 =?utf-8?B?Zmx6UFYwckZCNzBQRzZnNGRrNlF5SlY4N3E4NjVDemx1TER2cEd3cC9lemxM?=
 =?utf-8?B?L2NtT21Yeis3RlhGRGtPclBDZnUyOU9kT0NVdGptVkNra1U0TE56aUNZbENs?=
 =?utf-8?B?V3c5ZUJYTGJwK05kYWFVSlExRko4ZFFabFpoUkJDcVVBZVpveFlWMzdMNWd4?=
 =?utf-8?B?N25HNWVHUmJPOXVZYXZRdTNWRmtGYWk2R0ZwYlFHWkNFTmZPVHV1MzRYMldj?=
 =?utf-8?B?emhLZHJYYmVMRU1uY1daQmZieVpCMG1TVzBaSlJSODhiOVMzTzJVMklMcmtW?=
 =?utf-8?B?UDNqWTdjbC9VWTRlRktMTC81OXd4dFYvam9zbW9NcHAydEhlWEsyZm1QNHoz?=
 =?utf-8?B?Sk9OWXBDQ0VLSlVQbVBEam9NdnJ4YlNHeGJyQVJGOUU5NVNOaUhPbGQvclo4?=
 =?utf-8?B?STh5aVVoUVFDazJuZ2RZdXhrQWhJcmNMRDFuN2VDcUhLUDJvWmVmNTdOSHAx?=
 =?utf-8?B?T2xRazFINC9xOVJMemlPUFBScVhSZkJhK0s0S00xRnMzdW5MdldaRmtGRUE3?=
 =?utf-8?B?bERnUVRRNUYzbWJKSFlzWUtGVnFXcXkvVWl3YTRIeHdraGZ1ZzN2UldOZDJo?=
 =?utf-8?B?UmcrdUVoN0RhTEwwa3RxblQwellTeVFJWWxzUlJlbWZycytDWmtGY2I5Y1VT?=
 =?utf-8?B?emxIcnJoK0R4azc5SGFOTURRT3dwR28vMS9xNU1hSlptNGYxbk9YQkVzRzRY?=
 =?utf-8?B?cmtwU2tUcmo3QnN6NEk4Z0ZzMnAzbCtkRVpHWFRBT0dSQlQreE5SZUdSZkRS?=
 =?utf-8?B?Z2lMbytma1lWMHBMMnJoT2xwNXlaQXpGTnpZbVhBVGRsTytPb1p0MzVDUkR5?=
 =?utf-8?B?VHA4VXh5RC95bFdVeUJ4SzhKemNtYmx1ek9ZUkZkV0ZYOEpYVnRBeWVWRElB?=
 =?utf-8?B?RUh4WGJNcjlsbWJvUVBCL0lYYTNIYVdZR2liZGhMQ3dJeDlVRjFsYy9HU1po?=
 =?utf-8?B?ZEdMSE9va3FBeGdVK0xEdFZFL250b3lpOHpBRkJpb05kUE5RM3BXOXN6eGJq?=
 =?utf-8?B?cE5NeXR1dmRQN2xrUmtsbjdRUkZ1VzRUT2RQZmhCRE1QVHBNRXRhOHgxNTh2?=
 =?utf-8?B?dkl5Wi9kMEF5cG9nYW94OTNEeUQrT0hHYkJ6MjlWQVlyVklSOFV3TnRqYWFL?=
 =?utf-8?B?L24yb1VDTE9WMlF1R2F4L0JrNmFBV2xPdmUzayttNlkyWENxR25zaGxIckxx?=
 =?utf-8?B?VFRqVStwWXFPTGlpaHBndERlYzlxcFpuNWRhMzhaM2paMktEUTNxeERIUEJT?=
 =?utf-8?B?UXlET28wUkdEMGExUS93Rm5lV01FQ2VjR3J4NnpERnJ5UXRWeHhwdkU0Z01U?=
 =?utf-8?B?U3luN0lSOFJReDhhWmI1ZjQ4cHpKeVdHUGhJNHFyMktaK0lTSkNMb1FxTmtX?=
 =?utf-8?B?Y3JnM3ZKVEhaQmNRY0JSZjlUMDQ3SDdBRzF0WFpsdXdabVFKWGd1alNsRUp6?=
 =?utf-8?B?bnBiLzFHRHZBK1RxRjFONG5VaEVQZ2ZLVkt5S29sSEZ1SXhxdWhTYUtqVi9x?=
 =?utf-8?B?eUNNaTBweFgzcVJzMU53dkkyNHl5WXhZTDV6UVY4bXBWdUh2enE2aFhyeUpw?=
 =?utf-8?B?THZ1VmM4b3dBM2JUb1cwUEo0eXVITFNTU3pPTmphc1A0b05TK2M2UXdYYnVY?=
 =?utf-8?B?Zno4alI3c2VBek5wbmRGL29yNVRZdUg1V3pnR3BDS3R5Zk9XcnNpQ25YTGlw?=
 =?utf-8?Q?JAU2XO4fQw610xrcEmx8jxJ9a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8012e44-86a5-45e1-6b1b-08dd4a1870be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 21:18:18.9160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WC8PjRI9kwYV7dzIpPpP9H9hSw+y4JMnlrLeQLHB2XEGxaXBrRmY3Hhr7uvszeyLVpZT54IkzMF9Ftp18ztG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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

On 2/7/2025 15:27, Ying Li wrote:
> This initializes drm/amd/pm version 11.5.2
> 
> Signed-off-by: YING LI <yingli12@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 ++++++++----
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 51c2a7f4aba2..dd4cffd94a90 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -693,6 +693,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>   		renoir_set_ppt_funcs(smu);
>   		break;
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		vangogh_set_ppt_funcs(smu);
>   		break;
>   	case IP_VERSION(13, 0, 1):
> @@ -1565,6 +1566,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   	case IP_VERSION(11, 0, 7):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 0, 12):
>   		if (adev->in_suspend && smu_is_dpm_running(smu)) {
>   			dev_info(adev->dev, "dpm has been enabled\n");
> @@ -1918,6 +1920,7 @@ static int smu_disable_dpms(struct smu_context *smu)
>   		case IP_VERSION(11, 0, 7):
>   		case IP_VERSION(11, 0, 11):
>   		case IP_VERSION(11, 5, 0):
> +		case IP_VERSION(11, 5, 2):
>   		case IP_VERSION(11, 0, 12):
>   		case IP_VERSION(11, 0, 13):
>   			return 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 189c6a32b6bd..8a9d5ec2fd43 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -227,6 +227,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>   		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
>   		break;
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
>   		break;
>   	case IP_VERSION(11, 0, 12):
> @@ -471,10 +472,11 @@ int smu_v11_0_init_power(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	struct smu_power_context *smu_power = &smu->smu_power;
> -	size_t size = amdgpu_ip_version(adev, MP1_HWIP, 0) ==
> -				      IP_VERSION(11, 5, 0) ?
> -			      sizeof(struct smu_11_5_power_context) :
> -			      sizeof(struct smu_11_0_power_context);
> +	u32 ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
> +	size_t size = (	(ip_version == IP_VERSION(11, 5, 0)) ||
> +			(ip_version == IP_VERSION(11, 5, 2)) ) ?
> +				sizeof(struct smu_11_5_power_context) :
> +				sizeof(struct smu_11_0_power_context);
>   
>   	smu_power->power_context = kzalloc(size, GFP_KERNEL);
>   	if (!smu_power->power_context)
> @@ -731,6 +733,7 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
>   	 */
>   	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 11) ||
>   	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> +	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2) ||
>   	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 12) ||
>   	    amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 13))
>   		return 0;
> @@ -1110,6 +1113,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>   			return 0;
>   		if (enable)

