Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A64C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 04:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BFF10E0F7;
	Fri, 18 Jul 2025 04:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IP8AaH05";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0846210E0F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 04:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0TR+DqiKzRz9yBA43nqE+LHGZ5os07odQb9VpOarmTizE2QFfgD9OGbq+Bog8a8r7s8nWc34Jl4AOsVlViAvsZMoEPkjxM57rHoqCrZlR09JiMFNaBHIoRh/FMDfTHVg7fmw8kfgquxjNbz9WZE8Tn45FEBYGpy2NMGls/OvrHYCnxojFmTo4CnOSBONMDM+7ak05COLDBqv8WBLvoF+ac4yf5X71GRgEoDwtcLCqrUfUIgGNuyfnaEU1cns51fdR/8lxNRSmGHHxnMnjhnPMhpFEYYMapvuv5kc1TI/IaK1bqrpJuHjies7f9uQ+ztm5L3K6SkuxvF74QUeJEA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0fTKhGmqQv2fDGg+GRSimuhSkHP7vK3yXEwnfO5bDA=;
 b=J9nG407/PMfjvcAPF0mxwy4kuIPdM+6wyl9MRdikr1T13M1pGckkBelPTxdGVJUHFIMTEVuvpK5lLFwae10sbAGceRT/+WRjB1o8i4+wfEdNBkYTcMclM57VKMBlNqCKJw+kB/xvcqenqavmNe7n1bkAETn/EoA8hleSEthjlqTuYyXIqKkhPNqYnHzxYyPhRs1CRqpdV4o7HjTkEHsR0WuzrlvHX5HRtGSsQu7Y2P5axQVKuJg9S7bCN7XVN9563phydMNGsVLjBum9iWd4AvXy7fy1ppnv1uQxP2OoIHKQfqHn7iJa4EDZAdnjlbQge2ZJsUeSXg2PYv11hxIyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0fTKhGmqQv2fDGg+GRSimuhSkHP7vK3yXEwnfO5bDA=;
 b=IP8AaH05LQDM7JvJp3+jvoED3dEhsrm45jOJ/QWN6jHy19wNMU+mYuVTQClDQ2StQ3M4nuYS9vKsMZpL1ECgdKfKJ4XBTGE68aqFuc5PCixce2Pr6k6R4efeYrWYHOIZW7NlDpDyFvOseeh6+oGHtaTdjdC+WNLEsWG8lJoPs/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 04:12:41 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 04:12:41 +0000
Message-ID: <c78b9083-cdf2-43fb-ae29-dab1544b03de@amd.com>
Date: Fri, 18 Jul 2025 09:42:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/gfx12: set MQD as appriopriate for queue
 types
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
 <20250716220115.3872837-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250716220115.3872837-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::10) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 096039f5-028f-4942-2a19-08ddc5b156f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmxOc1J2S1U0RExPdGhGeVVTRFlUazFxVjFMNmFkaDFEMFQzdDQ1WTU3MEI4?=
 =?utf-8?B?cEduVklROXBpTGxpenhseFlBTEVod1I1MmZwb0tCVU9GcGN2c2tGZkQ4dVhn?=
 =?utf-8?B?VitLb2lrTEwzVWpLbnRiSzY4dWxUZm0rTWUrbjViTW5QS3YwdVd4a1BET2FP?=
 =?utf-8?B?MllTODhkcWQ5bWdZUDExMXY2WDVLemZVSTVmYlQyTEx1MXBzbXdOTk9odWRs?=
 =?utf-8?B?VnlUeGNHYktYT0dEdzlZYnduR3FRYnZIRnBSZTZBeU9RS28wcDI1ZnN1NUR1?=
 =?utf-8?B?VS9ULy8xQTJsL1ljQU9IVTZ4YnlFNHdVMTN3UHFRVXpkTDQ5ZGdTODl0RlZh?=
 =?utf-8?B?SmIvM1lrb3NHeXkvN3BaaEZqYmM1SXVGbG5JdTJ3UWU2dHhhbjNWMTNvL0NU?=
 =?utf-8?B?RHBIdHZ6OTZwWUJjVG1xei9MQWlEWjJLZklJVFowejRZczVhYUNmeTVYTStj?=
 =?utf-8?B?ZCtNQkZxY2gySk1uRXZOc1BZTUF3cUY5c0dvbE0zOVc3OURvZlU1MGRDSXpr?=
 =?utf-8?B?L0haMVlHNkZOOS92bzFKZWtrZVBqMk93QXMveWlXWVhVNVBhaG1GeGJ2Rkxu?=
 =?utf-8?B?MU45UTYvcVhsNHRwZU1PMW5ScTVwcExic1ZpaHNGcnF4SGFxdmc0UDNURWZE?=
 =?utf-8?B?OURHTGF6MDVzYU9VNkg2WjJpMEEyOHlhbVpWYlk1enFlVlBldUo0MDJOaWRz?=
 =?utf-8?B?S2JMZTlGYlplMFFxK0k0aUp3UzVydnZ2TlAyZ1RSVXZMWlJVMmMvcWlkdWc4?=
 =?utf-8?B?U1lMSEk1Yk9RbGVVYW5MK0ZUSFUxZ0tLOGpYOG95cUlzdmFaOTUvTzJkTU1j?=
 =?utf-8?B?Z1ZtNUxBK0V4WlMxZWdKK1VGeXByK0k5MUxGb0hBakxDakxhUHc5a1RQakdP?=
 =?utf-8?B?NVc1Z2Jsa0w3cDBLTXlSVlJCelNhQUNEOGFWU2Y3djZjVS9xUWpSTTl3c3E5?=
 =?utf-8?B?K0ZDY2NEUll3YSsrWWFNRG1jeDlwcWJXMmdOczE2S1Y5dmkrOVowTmtzbGNu?=
 =?utf-8?B?V2dLTG9QL3VRay9jeEtKS2N1NWY0d0t1QVhwK3M1T3lMMUhUdkEvVnVsVXRn?=
 =?utf-8?B?NW5GUDJMWW1iZ0dZY21lNlJWZEU2ZEg5cE9sSEhuQko0TksxVUIrb2hTSkNz?=
 =?utf-8?B?aFVLazJNR2FzZy9JMDJpZnIxRlZjTkQ1aGF5WHgrS0lRRUJNRWR4eDZ4aW8w?=
 =?utf-8?B?OVBsbFNFdEdiZllSeXRkU3Z6WFV0RkIxVTA0ajV5UjFmWkpaSHJxWkVNZEpN?=
 =?utf-8?B?Uk80U2F6Y2RlU25FYTV0eVhKQ2JzakRrNW1sNmRVL29FaGJWOEZ3SGQ0Nkd0?=
 =?utf-8?B?Nmx1Q0huZk9jMWtoSlVrb1hoLzh5Q2phYUQzQ1kvOHVUYkNBdlRsS3p3UnRO?=
 =?utf-8?B?bkM1V3JXeHE1VWNESWYyNDkzSjNIVU1LNXRIc3RnZnZwdGZXME5aSURBZ2NB?=
 =?utf-8?B?OXlnMk0zUmZnOTdCYytCczhUcWprUXNSTGhUNmRPYjNoVzJwQVJmWVB2MGt5?=
 =?utf-8?B?TklmblBIZzlJd2l0aFNnWWd3ZWxiNjJtNlZOQ1hCdXBtdUZoTmpURC9nS2JB?=
 =?utf-8?B?RTJLNitmZ2RtT096NjJQVFRKQVpzVVBoR2pJY1UydDNhaE5MaEpHUisvNENG?=
 =?utf-8?B?elpCT1gxVzgya1hYc29JVFVheWU1ZHpteG5EejNPWTFVTllSWVE5eEE4Qnp3?=
 =?utf-8?B?cEl2cXBleGpnUHNBRWJZU0hJNFZKaXBBL3FJSVZFZkFEcEErQUZwMXAwaWJC?=
 =?utf-8?B?ZGovajRZR2ZQc2wxdk9RZG1hYjlydU9HTm9FMTlDa1VvTnBSbmwyNXFqeEFp?=
 =?utf-8?B?UVJSa0R5a1pHNmVpSTJQd2ZzZG9SQjdlQ2d3T25oc1MzODRlWDFKWTA4YkNP?=
 =?utf-8?B?cVlKdHZkbHVQdGpldUVaQ1ZNODl4VHNsQzJ5REwxdVVZSTAwRVBqMVQ3U2dC?=
 =?utf-8?Q?NWaDuiQk1ms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smp4VEJyUVp2ZlQ2aE9CMGpiM1VSQkVXK09SQlZmUUZEOHFRSXpWY08vY2o0?=
 =?utf-8?B?bkVBQUNQbzE4dXNEM2ZrZ2xqU056QVVMUStMRVVHQnVuQUNRRHhQNDQ5VWJI?=
 =?utf-8?B?VStjYm5KNDJrZWFFK3FxdVdlTFd5Z1NaZmcvTVF4ZXVjY0d5THJNdlhLNVow?=
 =?utf-8?B?WURIWStCZzRvU2YrY3JFenR2WHFJTThGeG5zTEcwQXIwR0VhRmhFb09TQjEv?=
 =?utf-8?B?QzhQd2FBZThxZHFnZ1BkbEtDTERQNlFZdTM0aHlZcVh2eTJNRnZsNi9yUFha?=
 =?utf-8?B?MG1EQ2JrdzlSSXlsRUtLY0JYTG1WU0gwdEJPOG13WGR3ejY2N0E4NHZYSHZE?=
 =?utf-8?B?UnFmeWJVZnVWclpUSFFoVlZRSkZJcy82bllEeGtIY3BYU20xV0xSS1lOck5E?=
 =?utf-8?B?WlVncWRlS3d0VHFaMGpwMW1XSE1Ndit5dE4yS3d4MFVCM2JwRExHVjJ2Znhv?=
 =?utf-8?B?dGROaE5URy94RGdGNmU4VVhaTloybFNXamVOWU1qRTZVYkNsYTJvWU15ZzVm?=
 =?utf-8?B?WHZnUk5pVEQ0aUw3ZVVMbmovTmdCNGdGOGVwQjlsd0JEM1lhbTM3YVAzazEr?=
 =?utf-8?B?TGE2dEN3M3Z6N3h5SjRsYXk3QytuNFNjQXZoVzNBc1I0N0Y3RFdpdDVHTFRm?=
 =?utf-8?B?bjRMZGdLNUN1SitkbUQ3aDVQNUtwTkw3SUZ5SFBhd05ZckkyWVZLRU42Y3Ex?=
 =?utf-8?B?ellOMG9EczIwaCswaHVBQnNXMUZJMG44NWJsT01uZm5hb0NZQXpXdmFaUGVw?=
 =?utf-8?B?aDYya3N4ZFZHZlVmRklQSlpPMC9yVTZwWUdtTlJhMlNIYUg4Vld5S010NnNB?=
 =?utf-8?B?eDdzTk8xK0padE56cmpYYy91Skkrd3NjTEFDWWpaMjVVbDRiSnZocmVndTZC?=
 =?utf-8?B?TXRqMW9VNlFyd3JyeGtuR0dlK3VmSFBsc2ZlcVJ5aGZOZnRnS1Bxa0JaR3VC?=
 =?utf-8?B?YnF1c1g5OHFJWW9VTTkxZm5kVlFndVJGVk5lVndtNGFHSUxHYmtmb2wrNVhh?=
 =?utf-8?B?dHArOFVaMFUwY3pOTTlhTkRNNnUwbVpaSVg5aWhydUViK092QlNNOW1CNmlY?=
 =?utf-8?B?VkpUVFRyd2hUSmR6Q2RHR2ZRYVBSWm13UFN6RjJ2WmFKZ0t3RUc2b2NxdnEw?=
 =?utf-8?B?Y3IxNlkvakh1a0pUckhtdStZQm8yL3RaU1VkUHlvVjJuUDZ4UW1kZTROZVQ1?=
 =?utf-8?B?Qnc5cEtpVnBXSWxxTlFhd3ptRlBtMWgycUNRZHlOMi8rSUNYNVRianhVcjZm?=
 =?utf-8?B?UzZhL2RmK0hJOU5XajNLaDJUK3R4SnpBQlZwS3BKWldwQWlZWTEwNElPbUhx?=
 =?utf-8?B?MWx2UXJyYm1Hak5yMVpWcGIrVGJTMFBicFVNa1l3TUJTcjJ2Z29sdmZCV1Fr?=
 =?utf-8?B?U3NUVGZFb1hDSUk2YzZQd1B5YW5uZFQyUVhOYlg3Y1ZBcUlNemhDVitGNFZS?=
 =?utf-8?B?MWtyVVJKM1RLVjhXQ1FrRit0UEQxcnFORlN2RitLaVI1c05QUC9xSXlSSU5u?=
 =?utf-8?B?N0ZxdHV2RkxmL1dsYzI1c2VRdEtTcno4TllOa0FHTFNRSFE3QU54UGQxeVBO?=
 =?utf-8?B?b3pPeW1jQzA1a1d2dUpKYWl2cTBlVlJ6Y2xDNXlkNmhBb1NIZ005OFhra2Ju?=
 =?utf-8?B?RVI5VXRBUGRPK2JJZ25mVGRmbDQxbis0RDRzUGZTZmNsNkNkT2dVQUhFSzFx?=
 =?utf-8?B?T2ExOS9wM3BwUE9JTElQcXhjVjhaTUhHVkJKT0x4ejgxTmM2b1ZnSXpWRGdK?=
 =?utf-8?B?UUJQQnUramcyR3VXQTlzLytrUmhJeVF1RFV3bU5ZTXQ4KzVHMTZQS1RoMXBW?=
 =?utf-8?B?bG5nVnYyN3F6WERPQjRKQUxuWHFhbGdSdVNRTGYyZzdJaHZyVE94K3I2a0VV?=
 =?utf-8?B?Q1lvWXFkUzh6N2g1NkYweEdjQy80SFdKL2NSWWxHRVZlc3BNdEdDVnVjdVJD?=
 =?utf-8?B?akFrRkppM0h3czM2cmNKQmlXK3RWa1VMY1lnR2E3QzJlTkg3Tm5sNFJYcGk0?=
 =?utf-8?B?a1Y2cVoxYXJEazkwYU1MbUd4NjU0dENyNXNpQm9zSmpzdmlWRTNHdVhDRHZ6?=
 =?utf-8?B?K2dJWmh3TzlZMVV1WER5dS92YUFGN29hVnE3dHRzTjBIR1dxSG1BRU5pNlVk?=
 =?utf-8?Q?A0bWQQMBWC8m+D26S4UaNYhVr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096039f5-028f-4942-2a19-08ddc5b156f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:12:41.6184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pui690z78I9n5tQlT949FvGoiWXi1kcGxHxdM0eiUuPcbjaViSJvLpStXyuax5+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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



On 7/17/2025 3:31 AM, Alex Deucher wrote:
> Set the MQD as appropriate for the kernel vs user queues.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

A couple of nit-picks for patch 1.

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 7220ed2fa2a33..73a04d07bb494 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3020,6 +3020,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
>  #endif
>  	if (prop->tmz_queue)
>  		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
> +	if (!prop->kernel_queue)
> +		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, 1);
>  	mqd->cp_gfx_hqd_cntl = tmp;
>  
>  	/* set up cp_doorbell_control */
> @@ -3169,8 +3171,10 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>  			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
>  	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> -	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +	if (prop->kernel_queue) {
> +		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> +		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +	}
>  	if (prop->tmz_queue)
>  		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
>  	mqd->cp_hqd_pq_control = tmp;

