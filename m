Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41382C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 11:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51E910E34D;
	Fri, 14 Mar 2025 11:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AH+GsBoY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE05B10E34D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 11:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyhemvLQ17jrpjeFmW+Rxmq/oRAei437Fhvt7XiYLZrygjqbLnA4AQiLsWp+oykdVFkEMksFmHFPD3BroEWWvMWFa3uHnMlsZhAtHGVCo6lIlz+yXrswUamFZG7LunEa/mLiYpdKeOCNzq88v2HXTtbK0CojXf1aonJk8aF9rqFkU3bO6TpTMZxy7hQ5Sn3KZcMx5hAlY19+6p+uSU/IPORDhY6aAJimupv1aIBA3mvQop+uH8EHSeOSpUd1aiCc/gtniA6KHjmQ0gLxRNcGapR5BDq8uUMsLSct7yWPZpwi1UVtmwUCTETHX7sNS4HsKCRnbkdjCJABDAuTizxBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmLj69sr38n2Y9ZfGDHh5RuPkWZ2b2CY+oJQwBUCBE4=;
 b=u3JizgisI6E8J8m2rIEgypvVr+Rx7L5jo9UlMPvNFM/1TPYPkuaE3zhcG2Eah+k01tjMxTm+TG3/DU5RsqTCr2UHkj5XxP1StoTRETi9nRBPb2BC7ey5IttpLZF4NVX6v+py2TxEI1cxXaM2dRS1rXlOPszoRiEKkxPp9ggWgkF0UAyoaEMmz0lxar2p88m6T4xNPIW/mWZ3e3wFJhpUG8ybCrO1NlQx8GyNWEVicHowrwbtkKanRoOLZyqd6Zsj1ynpUL/+E1Gy1JBwo1AyWMNamxal3bEVRyKtxDnqxJ2x9SFP6VR89uSGq2PFGQKi6lhsrGRfKOPeGsCFV/16vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmLj69sr38n2Y9ZfGDHh5RuPkWZ2b2CY+oJQwBUCBE4=;
 b=AH+GsBoYiTgF6ox1pYfL1ZvAbRCbRVUmymmFhljkMeJj7ny+RCFK3KyiABI42dJHSlbUhBysOCSP/1Uf8nsKu8NjAlg2H9zaX5kIFkyc+1b35jFG9LJjQz+oFiHP0hOJhHqhFjBZg0WqnrgNWFvVJ6N9dGm1Ezsc2zxXleSWWX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 11:39:49 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 11:39:49 +0000
Message-ID: <b0fb8f2f-8f56-4a13-852b-e4ca60a4c650@amd.com>
Date: Fri, 14 Mar 2025 17:09:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-8-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250313144136.1117072-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0251.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf2b8f3-893e-4c4f-76f7-08dd62eced4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekdtQzROK3U4WEVWNXZ6ZklMb2IrRGU3Z3NvbkVwRERhSVJrN29iVnRRVHA0?=
 =?utf-8?B?QldIN2dIcit3dU1DZVhMNWJXNnFxV0Ezbk5hN1FDdk5JSnhNbnNPNkFQNWlj?=
 =?utf-8?B?RUY1UEpKVVZaT3UwREtnaEJGWmFkZ0I4aFAxSytXZ1J1REozMCtJSzBKd25p?=
 =?utf-8?B?cmdkb3pyVlVVRU04Y2pFRmczRW93ck9FTWlsVzJjb3F3UUpTN1V4VEtIZ0la?=
 =?utf-8?B?TXBkUGpRRmR6bmZ0dU81VkRDVDMwSGpvVVVYeHhHWWk2R0hqZ1pEL1UrVUFS?=
 =?utf-8?B?YXNvRlZGRXh4ejBSdlhSZ0N0SmhaVXhLNTExeW9wNnpLTCtRNWFOSGVXa3JE?=
 =?utf-8?B?eEpBRmhLUTBDSnU5Z1JXbWpwVHFaZWV3WWlZNmpNbUtJSHFKSzEydE5saGJy?=
 =?utf-8?B?T2JGZ1htZ2w0OUNmcFYyQXVGNDNwcmpFalE3QW1YeldWVENPVVJLeE4rK3VQ?=
 =?utf-8?B?N0lwa0lrbzdEU2VVdHE0NUV2eWpmY3lNaXhiN21yMEJpQjJTUnN2cWF4dyt5?=
 =?utf-8?B?cUtGMmgzeXdremVnSExlREE2cG1TSnVtaWwrRnpsUmIrM0l6ZWNEM1RsSDVk?=
 =?utf-8?B?eXRKS3JIYUlBb1J3WjN5UW5JYWlYQmxWOXd2cWhGQTBQK1luQnF0ZEVyQ3Nm?=
 =?utf-8?B?OEVUVGlTNnIwSy9hbk5PUEZGZlFWMWs2d1FxelltbXJuK0ltQUJRTHl1eDVU?=
 =?utf-8?B?aHpSejk5RXpHWEJiVmY2MUVCMmJhcitrRm5NdmpyUDlCOEZzakFjWWhFZGlh?=
 =?utf-8?B?WVBFRjlZb1lkb3V6ZFBpVzMvV0I3VjVKbFlZMGZveTkrZnRnL2k1RE5TbEww?=
 =?utf-8?B?RWlKbTBUUXJUbHpwMnVrMXhtWXA3MHV6SElOQTFvdDBPVlRMQlNqRFBtSlp4?=
 =?utf-8?B?TmVZZml2aXF4QzFqSTlKTGtCUWtoYzhodmhSdnJIcXBHZFJIbXZ4eWhpSHJy?=
 =?utf-8?B?SXNVcHhNcWhZOE5Tb1EvdjVJMlg1RkpzOWJLZUlzZVozVjNjQUtWcExYb2ky?=
 =?utf-8?B?d3Z6dUdwVGFnZEFyT014WFFXOEZMVkJ2MHJKajFUeHVrTW5wSlpoaUdUbjgx?=
 =?utf-8?B?R3lCK3I0V0o2R1ZheWZJNFVic3pYdHVWWjkvVHk4Ums5eHRrc1c2TmRtOVVq?=
 =?utf-8?B?a2hPOEdVNm1mQ3lZR3VoRnYxd0lLd0k3RW5LYldxWXNNUTUrZ3FUZi9WMUJ2?=
 =?utf-8?B?eEIvK0tNaUdEQnhlMkFOQzNHSnE2b3Z6SjdEbmp0TVNQMTRBWEt5UERVbVBJ?=
 =?utf-8?B?cys0S2tvVnR0eWdXKzQ1TCtoY0o4b1hXUGdnMXZscng0NjlaVFlkV1Z6YlU5?=
 =?utf-8?B?RVJHd2VPSXJNRm5rclJDQWN3eHBqcVdINnhCbU1yMzRUd3BPMTVNK2tiaisr?=
 =?utf-8?B?aE1IVzlkMm9KOVlJR0pKZzBkNkE4M0NmY3dhZmJyWjdFL3BlTUhsSFFyR0N6?=
 =?utf-8?B?aDlJUmNvSC95dHgvL3NOSW1IbDJHNVdwNXRTUHJYTTVKV0ZTeHA4Ylk5c0xS?=
 =?utf-8?B?ZVhZL1UyQWNjMGpaT0x2enNZcjQvYUJxQldYRStaS3MvaTBCcWVuM21POEdz?=
 =?utf-8?B?dzN4aFZHVFRUazhVdUhyeTJDTXc2TS85OU1vYkhWaHBsUGVLRkIrS3ZkYnll?=
 =?utf-8?B?WVRsbnBwaW10NmpMUE0yYlNvTU9KSkZqcjNlVW0vUGtHd05KUno5OFR2WVpi?=
 =?utf-8?B?UzFHMTRZbjFyOWNXa3FUS1A1QlJVL0Vob3JadnA1T0pMdmVTWUZ3UTJwUnhD?=
 =?utf-8?B?QWEvSEphQ0RYL1E1WUpvbnVCYVRacndYeVRpUGUxK3Uvc1V1M1YyVnQ1UTc5?=
 =?utf-8?B?QVp1YUs5ck92aXBSMitVSlcyU0d2dlFpYzVFMnZBSmlBSE45WlhES1VVMThR?=
 =?utf-8?Q?VXb2Y1aL5fiOJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNkR1htK3dzUmZxeDZhaW9mTmFLdmVVaENRbHBXYkhJbVNpakk5bjlBd1Vm?=
 =?utf-8?B?d3RzQlpXOFJFZW51QnJyQWxCR0FrY2VMcElTYTR3TGFGajU4elhXSmkrK0xQ?=
 =?utf-8?B?d3dWdkMxTjRzYzJoNHhTWEc5Tm9RelBjTWluZ0FVNFVxdmNzOFdYWWxVZDUv?=
 =?utf-8?B?Y1V6M0pRTDVGK0pydFJpTEwzSGptdWFsN3F4Syt5ZEZRWTdCN2dUeWY1aUgr?=
 =?utf-8?B?cFlZYWhWZW9BVGtXZHVTaExFTjU3Vnc4OGU4ZmNOSC91RWVpZE1uZ05PNjI4?=
 =?utf-8?B?VlFTTVdmbW5TdWdaVzZPb0ZON3BTNHFKcGtJZkdqYVg3c2lJU3NCV0ErZjkw?=
 =?utf-8?B?VE4zdktRTGN1bnAvdjlpdU54SnlWV1FzcG9YY1JRbjhRUDlIZU9iUFVRYThv?=
 =?utf-8?B?QlBIMXdJbnNPT0JoaVJYbHNDd0RKVkw4S1NqZDdEMDlYcWNtb3o5RzB1YkVp?=
 =?utf-8?B?R0UweUswazZIUzNsd0VTWWdQbE50R3pZemFaeXJjRVBxNE14M0pQMHh6UFIw?=
 =?utf-8?B?aThHTmh1TGh3dW1HVGh1U1NOSVdncHQzeEFHcGtkUEhNM1dPTHRreE5VOEVQ?=
 =?utf-8?B?ZjNxTjUyK1p3TnUwb3JQSWhvbkxIbnlROW5Ba1B4YTU3cHFSN0Jiby9ZRDlW?=
 =?utf-8?B?azREbDA1QnZrZUgzRDlkbC9LakFMM3M0Y3NMbi9lcXZjSkV1a3dIM2N2Q3Rk?=
 =?utf-8?B?eFJwc204NzlLYVhnNnRHODlvUTlPRTNtNGIzM2xHVGdXeDBqVnA2OXkyeWpL?=
 =?utf-8?B?UFowM3M2YnFPeDFtMEdsMjMxd1dYWlJiMHVSNXIwdnA4SDhrSWhXZVA0R0JE?=
 =?utf-8?B?cllkaVIyakFtUXozdXg0eHh0cVhyQVhsZ0RDbUMrMENBY2tubUxmT1R0UmVI?=
 =?utf-8?B?c0hNNEVMYkVKTCtVZkc5dkRjNnZMSXRmOXg0cTNHMmQ0bE41YlUvd1h2ejhL?=
 =?utf-8?B?NnZFK3Y1QldjQ3dKYzc2MkZmMkpEMnBZYVQvQzgzb3RJU3dvbUcvcTlQaDNp?=
 =?utf-8?B?SHRmNjE5ODM1VXk5U2dNellKeTF4U1JFZEtXUlg3QWNnN3pKaldNSE5IMkJP?=
 =?utf-8?B?dXNGc2lWNnBsak5yeDRsaGQxWFF3SWdXVzFBc2RrWUQzRmthUGN5N29CaHk3?=
 =?utf-8?B?SUM3OUUrZ2ZCdVJsNnFxTTh0L3BEd0NzRXlVdm5HbXFzNThKbFFtZE5xVHZv?=
 =?utf-8?B?SU1LUE9UZlI3NFBYYVZrT3R3Z1AwSnAxNjh6eS9ZYm93V1Y2SXV3TDBkZ24x?=
 =?utf-8?B?dGVkOWQ3bnlIM2o3NTNieWE5N3VsQmI1VGxobW1oOVlwWXRIb0F5NXdxTDFu?=
 =?utf-8?B?STlCc0pPbUNZeUxieWNsT2xNMGtsYXV0cm9PS1hVSzllU3JmMGcxTVJsa1Nm?=
 =?utf-8?B?a3kxL0FzV3FOSGdvTk80YlpsN2tjL0YvUVVkQWh6aENJRzdDRzh1UmtjcERS?=
 =?utf-8?B?aHFOWkVFUHlOMThUU2F1eG1wT1dsaC9FVFh3eFRvck9sRFNHa2EvdFh4U1hj?=
 =?utf-8?B?dzE3dlBjYUp4STNDdE00cVJNMEpNdVRsKzQ3VGt1Q2RaRXUrQSt0T0pERmdo?=
 =?utf-8?B?L0wvZmpyRmRlZHhFTnpnWUZrU0lpMSs1ZVpuMXhoam5xTXA1U1VCWlhmN2Rp?=
 =?utf-8?B?T1dXNnVzeG4rRjJGRWw0dW1DWXJqMktlc3I5OGpwcnRuT3MvcEF3S25TdFcy?=
 =?utf-8?B?VGoxU3hOaFVIandvdWtrRzNYVkZsSzNiWXRwNEpJZlI4WFhaYWtWaDBFS3Br?=
 =?utf-8?B?WmNQblV2bE5YM21TaE9RRmFINm42MURzeHRLQ09hSnUxd0x4RmV1a0JSTHVX?=
 =?utf-8?B?KzZhTGRLNGhlc3VIZzV1Z1kzckVEYmh5RU04czRaVVJZNmlWUVExdGw0S3Zw?=
 =?utf-8?B?UTFZby9tdzFEdGxISFAwcHdFRzM3YzNOWjduT0dnOHhZRGxOREJvRGFPbkdM?=
 =?utf-8?B?TlgvOWthbnZIakI2TjNZclQ1bDAxelJCODlHTXgvSHBxUUFyOWZFaDdqRFFI?=
 =?utf-8?B?bGpwSjZ2UnpIMUJHVG9SaitqODM0d0RaRVpCM1dqbTd4dXpiblpNNjVkN2hn?=
 =?utf-8?B?VS92SVlVMlhZb2pGSlIrY25hVk5VR1Bwais4SjJwbUdPTm15dTVOQUx0T2dU?=
 =?utf-8?Q?/u8t1HONAU21CoCuQ5l4IowMk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf2b8f3-893e-4c4f-76f7-08dd62eced4c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:39:49.2170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k/IkU1cp2dQyew+p/f3/Lw6HXy41Qq4mDsuF+uCgJpiM/FaNdF0mXGMEJL+H1uCBPF8el2EmLjlokbU2QPcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/13/2025 8:11 PM, Alex Deucher wrote:
> Plumb in support for disabling kernel queues in
> GFX11.  We have to bring up a GFX queue briefly in
> order to initialize the clear state.  After that
> we can disable it.
>
> v2: use ring counts per Felix' suggestion
> v3: fix stream fault handler, enable EOP interrupts
> v4: fix MEC interrupt offset (Sunil)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 191 ++++++++++++++++++-------
>   1 file changed, 136 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 95eefd9a40d28..fde8464cbd3b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1145,6 +1145,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
>   
>   	ring->ring_obj = NULL;
>   	ring->use_doorbell = true;
> +	if (adev->gfx.disable_kq) {
> +		ring->no_scheduler = true;
> +		ring->no_user_submission = true;
> +	}
>   
>   	if (!ring_id)
>   		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> @@ -1577,7 +1581,7 @@ static void gfx_v11_0_alloc_ip_dump(struct amdgpu_device *adev)
>   
>   static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   {
> -	int i, j, k, r, ring_id = 0;
> +	int i, j, k, r, ring_id;
>   	int xcc_id = 0;
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> @@ -1710,37 +1714,42 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   	}
>   
> -	/* set up the gfx ring */
> -	for (i = 0; i < adev->gfx.me.num_me; i++) {
> -		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> -				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> -					continue;
> -
> -				r = gfx_v11_0_gfx_ring_init(adev, ring_id,
> -							    i, k, j);
> -				if (r)
> -					return r;
> -				ring_id++;
> +	if (adev->gfx.num_gfx_rings) {
> +		ring_id = 0;
> +		/* set up the gfx ring */
> +		for (i = 0; i < adev->gfx.me.num_me; i++) {
> +			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
> +					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
> +						continue;
> +
> +					r = gfx_v11_0_gfx_ring_init(adev, ring_id,
> +								    i, k, j);
> +					if (r)
> +						return r;
> +					ring_id++;
> +				}
>   			}
>   		}
>   	}
>   
> -	ring_id = 0;
> -	/* set up the compute queues - allocate horizontally across pipes */
> -	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> -		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
> -								     k, j))
> -					continue;
> +	if (adev->gfx.num_compute_rings) {
> +		ring_id = 0;
> +		/* set up the compute queues - allocate horizontally across pipes */
> +		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> +			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> +					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
> +									     k, j))
> +						continue;
>   
> -				r = gfx_v11_0_compute_ring_init(adev, ring_id,
> -								i, k, j);
> -				if (r)
> -					return r;
> +					r = gfx_v11_0_compute_ring_init(adev, ring_id,
> +									i, k, j);
> +					if (r)
> +						return r;
>   
> -				ring_id++;
> +					ring_id++;
> +				}
>   			}
>   		}
>   	}
> @@ -4578,11 +4587,23 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -		ring = &adev->gfx.gfx_ring[i];
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> +	if (adev->gfx.disable_kq) {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			/* we don't want to set ring->ready */
> +			r = amdgpu_ring_test_ring(ring);
> +			if (r)
> +				return r;
> +		}
> +		if (amdgpu_async_gfx_ring)
> +			amdgpu_gfx_disable_kgq(adev, 0);
> +	} else {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
> +		}
>   	}
>   
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> @@ -4791,6 +4812,46 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	return r;
>   }
>   
> +static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
> +					      bool enable)
> +{
> +	if (adev->gfx.disable_kq) {
> +		unsigned int irq_type;
> +		int m, p, r;
> +
> +		for (m = 0; m < adev->gfx.me.num_me; m++) {
> +			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
> +				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> +				if (enable)
> +					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				else
> +					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				if (r)
> +					return r;
> +			}
> +		}
> +
> +		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
> +			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
> +				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +					+ (m * adev->gfx.mec.num_pipe_per_mec)
> +					+ p;
> +				if (enable)
> +					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				else
> +					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				if (r)
> +					return r;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
>   static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -4800,9 +4861,11 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +	gfx_v11_0_set_userq_eop_interrupts(adev, false);
>   
>   	if (!adev->no_hw_access) {
> -		if (amdgpu_async_gfx_ring) {
> +		if (amdgpu_async_gfx_ring &&
> +		    !adev->gfx.disable_kq) {
>   			if (amdgpu_gfx_disable_kgq(adev, 0))
>   				DRM_ERROR("KGQ disable failed\n");
>   		}
> @@ -5128,11 +5191,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +	if (amdgpu_disable_kq == 1)
> +		adev->gfx.disable_kq = true;
> +
>   	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
>   
> -	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
> -	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> -					  AMDGPU_MAX_COMPUTE_RINGS);
> +	if (adev->gfx.disable_kq) {
> +		/* We need one GFX ring temporarily to set up
> +		 * the clear state.
> +		 */
> +		adev->gfx.num_gfx_rings = 1;
> +		adev->gfx.num_compute_rings = 0;
> +	} else {
> +		adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
> +		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +						  AMDGPU_MAX_COMPUTE_RINGS);
> +	}
>   
>   	gfx_v11_0_set_kiq_pm4_funcs(adev);
>   	gfx_v11_0_set_ring_funcs(adev);
> @@ -5163,6 +5237,11 @@ static int gfx_v11_0_late_init(struct amdgpu_ip_block *ip_block)
>   	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
>   	if (r)
>   		return r;
> +
> +	r = gfx_v11_0_set_userq_eop_interrupts(adev, true);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -6548,27 +6627,29 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>   	pipe_id = (entry->ring_id & 0x03) >> 0;
>   	queue_id = (entry->ring_id & 0x70) >> 4;
>   
> -	switch (me_id) {
> -	case 0:
> -		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -			ring = &adev->gfx.gfx_ring[i];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> -		}
> -		break;
> -	case 1:
> -	case 2:
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -			ring = &adev->gfx.compute_ring[i];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> +	if (!adev->gfx.disable_kq) {
> +		switch (me_id) {
> +		case 0:
> +			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +				ring = &adev->gfx.gfx_ring[i];
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		case 1:
> +		case 2:
> +			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +				ring = &adev->gfx.compute_ring[i];
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		default:
> +			BUG();
> +			break;
>   		}
> -		break;
> -	default:
> -		BUG();
> -		break;
>   	}
>   }
>   
