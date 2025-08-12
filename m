Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B11C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 05:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE8510E587;
	Tue, 12 Aug 2025 05:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccl/1tCR";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3F810E587
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 05:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phViCXAk6Uu543rwjNSiBTBGr2Olm49X9CNjYZoeEbL0EfGXmf0SzTMVoMQuHsVA2TKBpn8Y9xgJfsVtRlJM19M6FYNePp+uX/UmISZocLcGxsPrxCqytCltFElwXvi08D8Fj8+8mi08oXcAprwmGBHjk/LkwhMF0lRa2vKLj1THdB99SjYRLv7tfF0lCMMpdNLNwIvDK7kpUGB662dbLD7AmF7C9lX+K8tidd3l2OExs1yRh5WwAZmr9aQ1jcb9lQ059cOnaxTYpbf8odZsgoTjVnUCwl12T0RoMrHC4L0ifeUQUBdN/VO8XSMZsuUdt9oPeQrggO7zzJOegEGqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U75tGOr5GmkeG5TQewKc6nBBdYuSi4+qCzfx1BqS/9Q=;
 b=b76e9S3NnYgpPvuKkecdn2Xix8HNalLc0PJLON/l08Nv1y0+qwNF7CVdYVh8mTkbE8IWxWI00HZRksDZhVPSmRzflewqYRaqO4MlnkO3LH0fIx88cbLejcrv2ki/ib70T46bthALtLMYJJ/Fr351+eX7L/qsynJYcETOi0zTXzg3ZFe00O+gL3t2AroDUAErfdNGiyfOZ1szQz5XGx9QwZew2yYuNwN4LFaoeXy0jMOnvMsyDLFfBGjaEGd33Bbbb5XfmUX0yzS0Q0KOy2GISGnpjcyloPp/XvcOcSKQWD9AWUndqx7/mNdrlV2M21CKYUNBPBlPXzbKR8jQ3Yhz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U75tGOr5GmkeG5TQewKc6nBBdYuSi4+qCzfx1BqS/9Q=;
 b=ccl/1tCR+tPmUlt125dNftQyjpNlEtb3scjKOByt5znjEDlrd2Y8O7ZRze9n0cjey7dHzJk00YCWUXeJ4BoPIr8MSIBQviKteqjXWEo13b0zOoAHfeyGxen9xedPIUZoys6KOKxksS3v9SIXukiWMPfq65Ss2Ws/NB/7nI0x9Fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 05:42:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9009.017; Tue, 12 Aug 2025
 05:42:04 +0000
Message-ID: <291fa167-3d40-4dda-b8a7-b7c9d35faff7@amd.com>
Date: Tue, 12 Aug 2025 11:11:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/2] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
References: <20250812010345.2261810-1-Jesse.Zhang@amd.com>
 <20250812010345.2261810-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250812010345.2261810-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d24ef8-a38f-47bc-ba04-08ddd962f7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjNOdmtyQnNVcG10Y3VyT3NwOERJM2N6QmF2WGZ2TU5RL1BCTDZoODY2Rk5Q?=
 =?utf-8?B?dGVSY3ErZXB3SmUvRHlzbHhydGVsbktIem9JUEpUZ3FhbEY0OVhYaVRxNmlH?=
 =?utf-8?B?ZzRKZFhweXcwU3g2U1NpUCthbmZPMmoxOWRSVGoyNmNtZ2JGNEtJV21ENzNh?=
 =?utf-8?B?RThwcmlXTnZscVhlaGZtTGIyZlVnU0doaStIVldTeE8vNXlQZm92cjFFVWM3?=
 =?utf-8?B?MmIzTWZwSytwUk9abS9KVDI1bkdzWU4rT2Z6cHJldTlBY0Z2S25JTFJVUWZG?=
 =?utf-8?B?RDZ2ZUdWWkVRZ1pCblpZQmliTktNU0d1WXVNOWtLNEZqVlZBaTdxVkNiOWNh?=
 =?utf-8?B?dnFCT0RnVDQ2VFlhUU1CRWMwa1JqdUpsSVBEVWNMUjZ5eUdoSzg5d0k5OTZs?=
 =?utf-8?B?d3lZSDF0SnBTU2N1aisycGhXQ1FEaEZFWjIwTi9GcE9pVDBwOTV0T1ZJY0pP?=
 =?utf-8?B?R1Fzdmp2M3RGVGd2M1hiSnRzSE5mZXNaQTNWdFY1UjF2WHliZGZNeHFPcUxj?=
 =?utf-8?B?N2NWTGtUZ3R0cG51NlNIdWsycG0vRjVoY1ZSOU10dWl1MDZ1QmlVV1cwRFBO?=
 =?utf-8?B?NkhTYWhJUXM3bFNNeHhBeDhUTXJBTkZsZUlqbTluN2s1ZnYzZWd5TlR4dEg4?=
 =?utf-8?B?T2FOOU5JUmJUOE5WNkdpbVprOE55OWFUa25KRmRZbmFYUjhWVTkxdmRKTVl3?=
 =?utf-8?B?OFhNbkJObmVYTmVHWmdjblRvZ2JKVG5pOUxnMzZ1ZktabmRQSGVQRXhiTkJI?=
 =?utf-8?B?YzZYdW01K0JwaFZ6bnhHMEgrb1FZSjlNUGlhVFRDcEFDejVGSTVqTi9IaGZN?=
 =?utf-8?B?TXBDNG5WR3NFWVhQQS9lRU1INlhqNzF0Wmw2WmFMcGtSR3dsZXJhUDlTRngr?=
 =?utf-8?B?TFl4WW9aaE9EUStBQlk2NzdweUdGNUpKWXFsTnU5dFdQaktMM1AySW1rZ3dG?=
 =?utf-8?B?UVZYc1FPYXpvL2VYQlkwSWFIYjVaTWpaSFA5YTZzaUkyS054K1ZnaCs2cXk4?=
 =?utf-8?B?NkcraGhwYVg4b0dMV1k5V3dPVm1hZTFWRk1YMmpsRTlrODQ3SjRhWUFnNXcv?=
 =?utf-8?B?b3VsTDgzcjhLdVRjU21WTndWTnpwdHQ5SjF3cGpPVksrZUFuK21lcU5nK3JK?=
 =?utf-8?B?eHhDaFJkUmlTbFhWaG1UWDVtRHJzT2RpVXhSall6cGQweC9wTk5sb1FYS3lM?=
 =?utf-8?B?WkYxV1RuNFg1YjlWaGdLa25SdXNhc3p4WjFUdEp3VFFRQWZpWWg1L1NOTVhq?=
 =?utf-8?B?RUI2U2s5QnM1Y0hUNmhuMTBURWxLa3crb3RIQWRCdlh3ajN1ZzZORmlGMkwy?=
 =?utf-8?B?eUtoR0pDLzVzQUxvdjVNYUF0dzBkZW9NYm41dWU3NnVER2lZZlJJRytHMkVF?=
 =?utf-8?B?VTR4N2FhNU5HdWV1RWdhY3lRMGZjNUtpSFA1ZXBrT2RqeGE3ZThxWlVnTEV3?=
 =?utf-8?B?LzVJYlRjOGxrZEFyeDRURkp6RDJ1N1pjMzFZYVNwL2JjaGZrSFEzMmVod0U2?=
 =?utf-8?B?TWprbDhBZ21ZblRLNnR3Z0JXcmJqYWxNYXRCcS9RSmR1L1hPLzdxcm53b3li?=
 =?utf-8?B?cTVyRm9ibS9pR0tqVksyaUVXRXJ6NFg3Nm0vTzhNZG5JVkhjZnMvWnk3SUhq?=
 =?utf-8?B?M2FabWxvN0RYa1dpdEc1WTVzVU0rWE4xMDB6Q2tnTlFKQ1VGb2tBdUhDSFFi?=
 =?utf-8?B?blBoVnJmeVZnaHhta2F2amc5cWloK284aUozYXBYcVY1YTZFQmRady90dkl4?=
 =?utf-8?B?ZDM5T1dZQlAzcjRnRzZKN0NlUDNOTWVMclZwdTdCdC9GdXkrWTRvMzV5bDZG?=
 =?utf-8?B?d3FvS1pBU0ZHYmMwN1VUeksxUDdnQmlaRDNnVllHYmJKaUxLa3VuVEIreEJl?=
 =?utf-8?B?Y2pWd3BOR0UwY2xQeExZVHdQY2ZYUmY0NHYzY0dhRHJDTDZGUkpCV3JoYzlT?=
 =?utf-8?Q?j7A8GUMkeB0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJQWTlqazBtOVAydjVrODlFTWhscGJ6Nk9zOVhEMFhuUFV0MEdVaEdoK0gr?=
 =?utf-8?B?UmEwRStYbWErMndPTlAxcXRMTWZ5YWhQTGQ5a1Mva0RDbElhdkg5aGJ0S1M2?=
 =?utf-8?B?S0ZubTN0bGx3NG5UL0dQUExicERnSUZvdXFwd3k0eHhNMk92TEJiWnJESnVL?=
 =?utf-8?B?V3JsMWpvY29vQVFWU1Rld1EyVWluVTZxcExlYVUvS2M3S3VVN1VmMExIdlJn?=
 =?utf-8?B?WnFqelRlYUZMT2FvSVdvRzlYZU5UUld2RUJQdTloYTRaMUdXOEhONDdTWGhn?=
 =?utf-8?B?WEQvKzVsVFhZeGNxVEtxMm54Vk5OamV4WFFFUVNtL3NTQUo2cWd3V1NBRnE2?=
 =?utf-8?B?V24xUmVWeDZpbVFJb3JXQ1UxQlVmcW1yQzd5bDd1SzlGSW5HcGo1SkFxUzFF?=
 =?utf-8?B?WXdHcVJyQTk3OHlndU5mbmJ6aDFBeFhhb2Zzc3RRY2tGY3VpdWJUVUJDOUM5?=
 =?utf-8?B?YlErb3RHd3doaHMvcXRacWE3UEZ4dytUN3A4RkhBVVJ2Z3FqL1Yya0EyRytk?=
 =?utf-8?B?Y0ovdVJTNDBRdmFKZzBDalI4NE9CM0NTVTh1cTNjc3dUcWM3ZUtRaE92M0ZX?=
 =?utf-8?B?bHNNNHhxamlrZytkeWJjSG1zYVh0b0szMUVYS09FTCs5cXpxYThxVWlMbXNI?=
 =?utf-8?B?N1lpYkhaL0ErZ3ptV25VNnZUZzViRi9LbzZFTFEyOHhvOWxhZkJtMXFLWkpl?=
 =?utf-8?B?WDd3blY2bnNzakpEN3NsWnRKY1haOUNRckNSVUxqbFdnaVhBdjlKUE9MRmdS?=
 =?utf-8?B?RUZyU3ljQ1gvVGh4VEtHSFpBRjl6NkN2c05RZyt4cXNVUXVod3dQUHVidlh5?=
 =?utf-8?B?Zk1YNU5rUHZNUWVRQW8xMXM1ZERCQkJ4eDJpYlFodDRxaVhnWmZVdkZaZjhz?=
 =?utf-8?B?SllTVm1QSTUzc29LRVV2NEdRWjVwN3V3MUh2QlJwUStxNmxxdTJTNDNYSGF3?=
 =?utf-8?B?blFVTks5YmFHOGpqbURKNTFJZEtOSmp5S3U2MGl0T0E2RHF2bXpzeHZyNzdv?=
 =?utf-8?B?K0ljYUV1MTdhN1d3V01GeDJITnA4bVdhZk1CaHJFKzhMdUZIczJiQWV0V3Rn?=
 =?utf-8?B?Vmo3eTF6aDdHclJtc1dFWHV3b1FMcVI0NVVKQ0RCNjV0SEcyNHJyTnlrekJ0?=
 =?utf-8?B?cnhZQVBpUlV0QmhoTVRnVXdzRi80TE5Pb0lOQ1RLMHI0L1VpYmZYOUN2WTYr?=
 =?utf-8?B?ak9LS3ZnTTZCUmszdFJEMUhpMFQzQk5ZN0hudkppSE5pS0Y3WE5vQWxEWDRZ?=
 =?utf-8?B?S0JFdUNLdlppRW1rZTZwbXBBQThLUk5ndjI0TFc1a3oxcmMrYm1rSzJTMFpq?=
 =?utf-8?B?UTQvWGlYNittVHd1b3orQWREUVIxeUNvellSWjZPa01zMGkzcy91a1VZREJh?=
 =?utf-8?B?cnloZElqc0l0RlZHK3BWdkxBQ2VpZjdYN1JBdDg5bkZYekR6NXVCT01teG1z?=
 =?utf-8?B?MUo5dllWcXpyanZEM29EdXhEcHVxb2E1VVRjRWJ6WnVmR01COG9Ea3FHUk1y?=
 =?utf-8?B?RVBZbGFVUDB5azc1MnJaMlI3U1lPV2RxbDhHZFZzMFBmM0duUy9nN1RKMVMw?=
 =?utf-8?B?K3gxaHRaYXdFRGovZjg0NTN6OFV4UG9RZ1QxMUhQQ3lCaHFaWS9McGtOSFBQ?=
 =?utf-8?B?b200UmtYakNuMkxQUjhVcytVTkJoNnJ0bm81b0p4R1Y0UnIxTXkrM1RnVXdK?=
 =?utf-8?B?OElyZ05vQmpodnJaTGtoRm9WbE12YjBKSEE2bEx3R1ZPMTVOYkhkVGRxWUc3?=
 =?utf-8?B?RWphNXZPYkhCMDR3ci9BUmJIRC9RbDI2dStTTTNYT0VLQlVvalZEYUcrcW5n?=
 =?utf-8?B?bnY5M1h5dlRXbDlacURXSG9NOUZvdjJmTTZ5QWZxL0lLTjlIRkp4TVlHVjE4?=
 =?utf-8?B?U2hyYSt0VWxsSkxlWnZReTQwWXAwanFKanRxUkdOL0dBdzFUOXNMbHhnRUdB?=
 =?utf-8?B?SzF6cU1JaWp4bTgvR2RoZTQwVklrY0JpcHhKV1V4WkhTZ3U0bWp3UGJ6NWh2?=
 =?utf-8?B?Yy9tT1N3dXdoanVsbFVMMHlSeWlkMENkZlV3ZmR1cWUrRTd4czgrc29iTU4r?=
 =?utf-8?B?ZnMzK1NQblkwMUlnVlN2dzhBVklQUG5qaUIxemt6VkpsSGpvR042U0s4TUZx?=
 =?utf-8?Q?mNrCI2+D/tjfrHw475jU58LEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d24ef8-a38f-47bc-ba04-08ddd962f7ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 05:42:04.6564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUaPyugao5IHooWNkPGtG5JPz/kZd2iwb+89apRs6kdknVvqL7hu7H6tBQopcum2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
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



On 8/12/2025 6:33 AM, Jesse.Zhang wrote:
> This change reorganizes VCN reset capability detection by:
> 
> 1. Moving reset mask configuration from sw_init to new late_init phase
> 2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset support
> 3. Only setting soft full reset mask as fallback when per-queue reset isn't supported
> 4. Removing TODO comment now that queue reset support is implemented
> 
> V2: Removed unrelated changes. Keep amdgpu_get_soft_full_reset_mask in place
>     and remove TODO comment. (Alex)
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 019bd362edb2..03fcd6833c26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -134,6 +134,16 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +

For better structuring, suggest to move below code also to the same
place so that the mask is set at one place.

 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);


Thanks,
Lijo

> +	if (amdgpu_dpm_reset_vcn_is_supported(adev))
> +		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +
> +	return 0;
> +}
> +
>  static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
>  {
>  	struct amdgpu_vcn4_fw_shared *fw_shared;
> @@ -211,7 +221,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>  			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
>  	}
>  
> -	/* TODO: Add queue reset mask when FW fully supports it */
>  	adev->vcn.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
>  
> @@ -1871,6 +1880,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>  static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>  	.name = "vcn_v4_0_3",
>  	.early_init = vcn_v4_0_3_early_init,
> +	.late_init = vcn_v4_0_3_late_init,
>  	.sw_init = vcn_v4_0_3_sw_init,
>  	.sw_fini = vcn_v4_0_3_sw_fini,
>  	.hw_init = vcn_v4_0_3_hw_init,

