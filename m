Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD09D41C17
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 10:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAB610E2BB;
	Thu, 11 Dec 2025 10:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mcm7DdNd";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D314B10E2BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 10:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUop5slLiRSGSJAEYmM/VA5DkppvNVNkfSxmojd2vhjaCSdQXF+aQxJaiBxL959rAF+xq9FrXAFpSRZkBO3TZLkc1ONWHQen59/sF6AadkfiW5roofWWcRYbc1/aE/5xgLmezsK0XHHjvhrJ1cUfE3R61W3ZHR5dKLQ3zhlJfqfy7q8EU++nmtZA/M85lhTgjACibe/XsAMkH4hYtZuEvZsRYD9XgR47nqMLMAwnbE9BXQfo1oZyrNR8oNf3zhm+Q19f3ffYW2DQMRI5WCSFPKqv9KIkD/H46COo+oRsb1O8akfa9iZqXpUMXpyfxDKGWnkxdNbp1WgABApxq32uBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3K6tvgw0YQYrsTouPkQ8MiW4fhhVqciDOuerawG4iI=;
 b=LUP1rLhtFyGiqZmKEQTiW6m4cIMXlIAkw/TEaXDAICmaiHGal153pK9SP5JIx5Ec0SIIM3niSpwGBH/55TH34JazcMOlQGrOFExAxEOIBtKNUz5w+b2zWn/3D0zzZlwqLo+UdwRREGZpWwUnxfQpCoyG9CrSJ1J6509HSEe+AFI9fuD7X4t4cgCqOXU6oXKzpiBT0u+gtT2d78SG9i2qcj1/Sb74+Rf/4FPXVcv4MF2FhdAfn+TE1dLNnn4GIat8+PNgPhG1Wp+QHalPFwk5CzzqnFb89t4uxx69h1pJrEWNi6MqeYmDRdv0hJDrCwrU6cT/ZrjelGt1eFmko06IiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3K6tvgw0YQYrsTouPkQ8MiW4fhhVqciDOuerawG4iI=;
 b=mcm7DdNdo3IxZrRdZr83JDnBtuawnCw0/OS1zNn+GrqgEQXRRf0O4NNJlsxCRSx2UHxWMiP46nMNoNUYr5/Iyw41ze95kLL2lvzT4X42QpXEAZAz7A7J/O3KZSD74o/ZxX8m++Tvy/m/bBCWnt24BoMJbIjl9XYriNPN6wux9DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 10:40:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 10:40:06 +0000
Message-ID: <9ddc4bc4-163b-4e3c-8827-08e830c515f0@amd.com>
Date: Thu, 11 Dec 2025 11:40:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
To: Saleemkhan Jamadar <saleemkhan083@gmail.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20251130090502.83707-1-saleemkhan083@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251130090502.83707-1-saleemkhan083@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: a338435f-a3ff-4cef-f555-08de38a1a642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2llOXU0d2t3NmxONHUzaFhndmtnWlM4eDRoQitTaVlWWThYdHh4clUwcy9v?=
 =?utf-8?B?R0YwejJaTnA0TkRobkNQUVBsSkI3TmwrMXYzV1F1QUY3dFZwVlppNyt4cTJ3?=
 =?utf-8?B?SllCcjRQRmcwUEY5ZmpnYnFIRVNmcDBWbmFVaW1mZnVzNzhyblk4KzZmWGd6?=
 =?utf-8?B?L2xhV3F6WFpQc2NkTmlkQVUzSDRidjBldFVaYmdBQWRKYkpOdmtqeWNvbzF1?=
 =?utf-8?B?eEx5cHc5NlVDYkoyeHRuQ1o0VUpyWWlBeHl6bWp4QWJmd3ZOckEzbklXUks3?=
 =?utf-8?B?WTRpamM1V0hmYVBBTXExMjYxdU1RMk9KOUJ0UWYwL2NGSXRzYS9KTjBINlNZ?=
 =?utf-8?B?VitvZTJSNk5vOGJsOGRyWVIxVjRtbExlbUdLQnNRU0lDZmg0eUx4QkUwMkZq?=
 =?utf-8?B?UkhmaHlMTEcxbXRFQ2x2UUZoSTZKdGRuazdBYW5UUE03ejFkKzN3R3NESUly?=
 =?utf-8?B?c2RVRk0xQlFtdDZxYndLU1E3ZmxkbUs0Wjh4VWI1Y3FqbG5JV21SUU1mb3hU?=
 =?utf-8?B?MlM5ZU5KYUphMy9wWE1rNnJINUpvVVVJa3FURUo0dG5ScUFXYndKbWVlYVlm?=
 =?utf-8?B?bHVnYWlmblFsTWo5VTduYjdEZzZjM0o5TlZCUWRsa2x6M01SRUJyM2wyK2xx?=
 =?utf-8?B?NDFXYnVqVitBZHo2cWFNUlNJd0NGYkdMQU5HRCtPbnlzeFBwWGxRNm9OVmVn?=
 =?utf-8?B?RXhoS1lVQlN2WGo2UEpzaGx4R25rZUxmNC9jMVpPUEJTNTBFMjFUYmF5Mkg0?=
 =?utf-8?B?OE04ZUlUb2E3OGhwZmdkcHdHUTB6N1FuOFovK3NEVmkvSGxpTjNFK3JMd1c2?=
 =?utf-8?B?QkhqbzI3LzlGU0JDNVNubUk0RDRBQUdMZW5ab0FZNDdkMkxRaGtYU0phWThF?=
 =?utf-8?B?UE13SC8vWHhXTXpqLzdPdVFUand4Y2ZlZXpwR2dLL1l0cld4Ykd5a01WTDMw?=
 =?utf-8?B?b0tpb2hMZHdiNVhKalF6UkZGVW9jM2Y1Y3dWYU9Vd1pUajNFemVGRERIaWZX?=
 =?utf-8?B?ckI3a3owcGlSd1h5V2N2RGJEaGg3Zit3KzVmdjdWVW9UWmd0bjk1SU5mcTV6?=
 =?utf-8?B?Yi9JTjNDakxwYU5hTHJwaVhTUmFqMXpuUDZGZUpqbEJLREQ5UHRpMHpGR0J4?=
 =?utf-8?B?dWsvdTFCc0lGcEtHcnNIUWJIb1h2emYxaXpyK2JaNzNOQzFnTW1YUUNLMDMv?=
 =?utf-8?B?MjJBUlhmQlJvVTQ1N3VwVTlpOVhoNWh0VHcvM3hEUFJnVUtUNVhzL0JqMjYx?=
 =?utf-8?B?NGRkNEpIVkFTMTVmUGcvakM4ZWMxSm1uN3VWbE4zS2VPREJxU2ZKSWJJMjgx?=
 =?utf-8?B?akNYcWN4VTZWL1ZjOTRvdUQrL0l0L2FESmVHbTlDemwraW1JQTNqMUxPeUFR?=
 =?utf-8?B?MDNOaFJSamlVUUpBVDVOenBpdURNcjFIZ2pkS0U5V1dTbS9Hajh4ZklsSHJr?=
 =?utf-8?B?enpySjdHdjN0R21TWE82TlVrYmFyNk9YTEIwZitMU3FtRXA2TGxzcHBibWJp?=
 =?utf-8?B?TGJxc3pPT0dKanZyd1lURmFTVWp1ZmlWUW5ab2oxdzJWajVFVFRHKzU2QTFz?=
 =?utf-8?B?Vk52N3luWE5YYTNSWXN4cUpxbFdpaDYvby9ORlczYW50TCtkNlh6ZXVLcUs1?=
 =?utf-8?B?S1FDY1VyWFh3YkxxSEE2a0N0bjdLdWpiYmoxck4yRjcxVUVlalJwUVB3OG9y?=
 =?utf-8?B?RXNKeXhkcVFWU3hPUHNGSWpnd2pmclBuOFU4TEVOWVlYUjV1bjVFUmhwbjRt?=
 =?utf-8?B?NjhrTmFndzMrNVBuK3psYkx3aGh2eU1IbXI0Tm5vRjZDMHBiQkIrYWJ2c2Jq?=
 =?utf-8?B?UXBURGpNcUJpSDFwNk04em9lbi9uVFdQZzlnQyt6UWdDemRRZ2FwRjRla0JV?=
 =?utf-8?B?a3JZTTF5Vk5KQ3FmcEoyRFhsRzNncFJtdkVJeGJac3BQRVRYNU9aMUJkTUw4?=
 =?utf-8?Q?KsQFrv+bq2NMTc+AatRm752tu4GZOnTi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjEzeDNYaWxZbDRZcnlsN3J1ang5Y0JCVWFwZTZhWitiRWdWbEhYTTVUcmRT?=
 =?utf-8?B?VExoY3kzYzlIOFNqTEtQUFprb3NLcjAwRU8xa1VjM0xOVTEyQnBsRDN3NVRv?=
 =?utf-8?B?Z05DdndQbHlJMEtYZ1k4V0ttZUswVFpWcU1kNGYrN1pRM3pLdmxGRjdwSFNm?=
 =?utf-8?B?N3BQM3RlenA3WmoxL2E0K1NlVWdYYVhkT3k4eDlzUWt0WGRWTURCRUVITVVH?=
 =?utf-8?B?Y3VuTGhKckF0ZVFRNDBVZ1U0Z29mR2prRFg0TEI5VW5CNXEwK281bjJ2VFJ3?=
 =?utf-8?B?c3EwTHNOOFBHaWxWNmJ3Y21qUTZ2cEFrZUpBT0ZFdWIvR2NNdThML0ZNdFZR?=
 =?utf-8?B?Q0F6UmRMQndOVG1zR005UjlCMHZsY2hUdlB6dmZFMFFPdk93enU5M0Z0SUV6?=
 =?utf-8?B?dW5BWWRad25ZSTVRWlRkbS9nUnJ3ajB1K2l2WEFsTW5NRGJiVEpKajJpZi9p?=
 =?utf-8?B?d0NFditMRHhwNVc4UHRGZ0lST0hlck81aGFhT3hlVFB2T01SRVdmaXU1SjA3?=
 =?utf-8?B?YUF1dHJWNVIrbjExM0ZZNkxXOVAyY2JUZUVrelp6L3ovNS9wN1JHd0s4Qkxy?=
 =?utf-8?B?OEdIS0lpdXQvSEs3UkFKMEcxRnUyOU4rMVM5b29YdTRnRkNDQlgxRjhCV1FP?=
 =?utf-8?B?ZWFjVWphZXRIeWQ0UGRmMHU1Z2FKNnlrM094c053cjVybXNSdnhEdTd4YTFp?=
 =?utf-8?B?cnAvOGtELzhHL2sxeE9tRldpK3JMcU1WenUyeTNRK3BIU2YvcWgwc3c3NVJR?=
 =?utf-8?B?WlpxWlQ4T3JnUFFNNE5RN1picWpwVTVlZHhEczFmbEF1ZjdQTVA4c2xaQjZE?=
 =?utf-8?B?MW1HODVDNlRjUGZ0VW9Vd3FpUmduOTE4NXk3aXl2eHNlWkQzNVBadW02OFdC?=
 =?utf-8?B?RnljbWxrdnFuRzdQR054aVVhK3ZZQ1Rjd0g5Ky9JUDVJaXR1WXZ1L2JwQVA1?=
 =?utf-8?B?NFVlVVpFbDFHa3d5a01VZ2VaTjhrY3BwdENLaXdNQkI0ZFk3bnZQWEZnUUNr?=
 =?utf-8?B?eTZ5eW4wUzM2Z3dySkVnRUh5Mk1DRnF5YW5zaWFWU3o5S1UxUStkaUdkSjU3?=
 =?utf-8?B?ZFg1THVXOHhZT2Z5WWNHb1NtSjJ6K1RnMnJ3QlBBeWl0eGZteUtKT0d5M3Vm?=
 =?utf-8?B?dk0yUEZpRUc5S3I2L05XY255dGNhbVFieG8zS0JsTVE1T09DMVpMbkkrNlFo?=
 =?utf-8?B?TUtDb0ppZkV1bXpCTkNzSTRyYWs5ZjJTSlBkREpxT3gvdkFmell1ZjFiZzRp?=
 =?utf-8?B?aHRCdFVKbnlxdHNsbVk0L2RiOTVxZ1Zydmx5QTlOaVJmeGhxcWJ5K3NJMnZF?=
 =?utf-8?B?R0IrSmM5d0VmaVV5N2xRUHV0VnF0YmcvWldqUFJFdXAwVHVsRllWalM3R2pR?=
 =?utf-8?B?RkJ0RkNYN0R1MUsvY2pVdUNGcklhelYrSGI0b3BKVE1uUE9UVE9yRjBrTjI5?=
 =?utf-8?B?OU1zSFVscVdCdm9kQmt1UnFEOXF5bnptN0RtR2huYzdHT3ZUWXdyc2ZDTmdU?=
 =?utf-8?B?UCtUYTNReE9qQWFrNXJRS2E0VkZjTHZpL0c2ZjdFWjA3WFl4SUVsckQ2QStU?=
 =?utf-8?B?ZEgvdTlGeVozYTgwVkZ4VFZheFI2ODA0eCs0TS8yR2EzT1ZGOFRmenhlaEFS?=
 =?utf-8?B?aC9FZTBPWXgvMEZIWTF6ZSt2cDNKaHd0Sis0T1drbS9hSVMzWXZ1K1Q4OGov?=
 =?utf-8?B?TTI4b0w0K3lublpsOGFFNmJFM2xFV2Y1UWVUcjMvVzMwK0o3NVhQT1A2c2Qy?=
 =?utf-8?B?eUVIcEdyZEdiR1JaUk1uME5CNi9qRVlNMkJSWk4wY1lHUWRuTHU2VFZCUEpM?=
 =?utf-8?B?TFJLQTBVYjFCV3E3a0N0c21CN0VWdnl2a1hPdTF6NGg4THZxYU5ieGg3N3lj?=
 =?utf-8?B?Vlg5MjZnWGVwOXY3Sm5sQjQyVEcrOXBSWHZVK0hnL2kyZHkvSi9uR1RpeFZG?=
 =?utf-8?B?SUZIbXFlY2w2Z3JYZVQzRXE0cE5aUWhiUTg3T29kU2tWQ0h3TlB1SHB1eU4x?=
 =?utf-8?B?Q0pCUFZYVVFsYzkzQ3M3SUJRQnhUZUc1UnN4aWs3a2dTM2xDVFE2WTdGbzVG?=
 =?utf-8?B?Z1ZYTVpFdWlkVDBtTFRZcFJYT21BeWVVbnZSLzNFUzAvQVlVYS9aYmpScVNu?=
 =?utf-8?Q?8mzHsT2r6SJdedUbDseN5+NYz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a338435f-a3ff-4cef-f555-08de38a1a642
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:40:06.6202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUhz0ZHk8QjLQI+93BdZkI6c47hu71XUqo+XlfWL0pCdDmC8q8W5LHh7e7QnjD7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

On 11/30/25 10:04, Saleemkhan Jamadar wrote:
> This should not be used indiviually, use amdgpu_bo_gpu_offset
> with bo reserved.
> 
> v3 - unpin bo in queue destroy (Christian)
> v2 - pin bo so that offset returned won't change after unlock (Christian)
> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  8 +++++++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 21 ++++++++++++++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 3040437d99c2..bc7858567321 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
>  {
>  	int db_bo_offset;
>  
> -	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
> +	db_bo_offset = amdgpu_bo_gpu_offset(db_bo);
>  
>  	/* doorbell index is 32 bit but doorbell's size can be 32 bit
>  	 * or 64 bit, so *db_size(in byte)/4 for alignment.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 2f97f35e0af5..98110f543307 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -586,6 +586,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		amdgpu_bo_unreserve(queue->db_obj.obj);
>  	}
>  	amdgpu_bo_unref(&queue->db_obj.obj);
> +
> +	r = amdgpu_bo_reserve(queue->wptr_obj.obj, true);
> +	if (!r) {
> +		amdgpu_bo_unpin(queue->wptr_obj.obj);
> +		amdgpu_bo_unreserve(queue->wptr_obj.obj);
> +	}
> +	amdgpu_bo_unref(&queue->wptr_obj.obj);
> +
>  	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  #if defined(CONFIG_DEBUG_FS)
>  	debugfs_remove_recursive(queue->debugfs_queue);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 8b0aeb89025a..23cf517bec39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -94,8 +94,27 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  		return ret;
>  	}
>  
> -	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
> +	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
> +	if (ret) {
> +		DRM_ERROR("Failed to reserve wptr bo\n");
> +		return ret;
> +	}
> +

Please add a comment here: /* TODO use eviction fence instead of pinning. */

With that done patch is Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> +	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
> +	if (ret) {
> +		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
> +		goto unresv_bo;
> +	}
> +
> +	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
> +	amdgpu_bo_unreserve(wptr_obj->obj);
> +
>  	return 0;
> +
> +unresv_bo:
> +	amdgpu_bo_unreserve(wptr_obj->obj);
> +	return ret;
> +
>  }
>  
>  static int convert_to_mes_priority(int priority)

