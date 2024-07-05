Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB412C3271E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jul 2024 15:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AA8B10E1B2;
	Fri,  5 Jul 2024 15:15:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wM2fUFZY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93CB10E1B2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jul 2024 15:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km01jDLfYB2K5iDIBq5xzJFyK0BaKAwHm6riipZ8U1b8y5x19CbFubjmvb4PXPWCLcQoACTMfz9FF3Gi7d9SUaL73cOIvDEvj13d8QndMUqd7Q0vtZ5g0zQC+MtlhyQzSBQfMGhUj/LyVUwh3+nkG2+sum6qulKj3gDsK6SZXnF4bVaqt/7IM/FixIwZwBnxrDxO4KWCGeLTmZVjUte2pRFt6zwoWbav5tt11QR7PCMXsliayRuDSW4mlTH+7ZyQ8M9P7ydsd/3C0wLBE9PTttXs4FUrtkJf/yqwaUek0jT6WlqxHafSE09zXrz17s6wQof1u3UAm0KfWHYwhsCs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiPvI+N/Z3Zz7KSIY9xGmkMAcKPrzCZ1cJds+bUi/u8=;
 b=NDhPp68L1b7TDNwTmTaEahpyH+O7KkWyd1HsqpyUQEv55kTBYGg5aWDrpwuUhEi1GHR6fGpkQI9OhRpSMwRhHRxj0F+cmtms0ukfjz8ytCfyIPwaHDaJ7NABNp0ALpOCkEVJyi7jphKAclUu35Vr2zi02XryMda28aDTYEzay49yKBObnAQx2Zxb6OyXDYXVIaXJ4hBwsH6NpIXXm7KZPP3v7HllE8dXkydoKbZyRp58ahfED5SsC9oAd6S2a/K172RrduByQFP2+JY/KdjEyI5RYhSmswG69bCxyPk22eBNXQaBSerWPio8zYIG/uJKc6VhBIxbblTKiRh2X3jf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiPvI+N/Z3Zz7KSIY9xGmkMAcKPrzCZ1cJds+bUi/u8=;
 b=wM2fUFZYTQXZstctyWkSRswj4ke3PguA+KN4uBLZj/T3isJtSWMdogyyNnmYRAZeycHONDehHmP6v/duBOD3wZsZHfO3wudTrxKhGofUxPgltgj4pi2Cw30r+l0AMMpTsXB5AcqQ+TSWlYVJ5JTwlmN6yq9L6oCbsSqJabA5bfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Fri, 5 Jul 2024 15:15:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 15:15:16 +0000
Message-ID: <86ef87a1-b476-4d7c-a4d1-85e33691720f@amd.com>
Date: Fri, 5 Jul 2024 20:45:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE
 to 1
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240704154038.4599-1-Zhigang.Luo@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240704154038.4599-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: caf38d44-74cd-4f33-0ea2-08dc9d054617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGxWVkxRbEJHQndScFV0aGVPbmFtL3hzYTFDbmRiZXF2U1BvWG9IUUwvZ0tu?=
 =?utf-8?B?S0YvRUk1ZVI1TlJaTlJ5VGZ6M3VHNlU0Q3l3YklMRjZIaW9zcU9ETTBydTRC?=
 =?utf-8?B?bVpsUXF2Rkk2dTAvL3c5Q2NCVXJkSjNHMmtQYThMbHROUDVqcGlPdUlEV0Zt?=
 =?utf-8?B?QmxIa1hZTlNJeW1UdFAyeE5kRHR6cFA1MlZQM0x1MTNBK1lxTnI4V1JYSnhU?=
 =?utf-8?B?OWk4SmxOeDRiRXIwbDFzQTZPdFFMSzJMdC9oeFV0b1RqRFdVQ1Z2VENYZFRD?=
 =?utf-8?B?cHhsT3pSbUlOT1YvSDd6ZUVLKy90MGVDSm8rbndQS1AvL3UvYy80Z3RGS1VW?=
 =?utf-8?B?TmpMc01QdWgyU1loTTZVQW1qZkhkRFVuYXl4dlVFS3pvS25xNUZYR3B5eGhU?=
 =?utf-8?B?dzlOUS9qdUYxS3NVT3lZS2V0UlowaW5QWklOM0pQOE95aVpnUzlFTXVIOERO?=
 =?utf-8?B?QWxpVFVvS0RQMjNmUGw3MmJFUkFPWDRQajY0Zlo2b2J5MUJNcEljUXdkSGVJ?=
 =?utf-8?B?TG1jQXZJNlQ0NEpIQ3cyWndWUnBtT0tDVm1GaENuUFhHc2t2UFhjTTZXcExM?=
 =?utf-8?B?aEJUbHpDTFZROXljSUtET2NZZnJNeDRXTXZKT1BRMGRKOTBQZFdweUpyM3c5?=
 =?utf-8?B?TTE5dXlPNklOWTNyOWVPU3Q0ckxvUmpyMTRNY1l3SFJKVHhTSmhLbmVHdWs4?=
 =?utf-8?B?dGNnTzloeExUMmcrTFhQZnZWRXhiTmRpTDFiUWc0Y3hVc2pDQW0xUktjSFZ4?=
 =?utf-8?B?dGpoSXE5RllIcHoxa3Vnc0xTUWlBd2lKRnJpcVhaL055SmZ2Nm5DU3ZWR0ZW?=
 =?utf-8?B?QkRZSUJkcVZPcGU1OHBSbDQzcHo4VkIzdE53NktxeXR2SUYyekVwbnhVUm10?=
 =?utf-8?B?L21SeFZIYnF3bUN1QXVnMi94TDlrbnA5YWd5eXlBd1laVm9yT2FyV0xnb3lM?=
 =?utf-8?B?bzB6d2dWTzFaOHY5amIzV0gxRHFzNnpoNU5ObElSK1VkV0N5cUF0OXYvNE4r?=
 =?utf-8?B?d0h4SDRoRmhEblA1eXRqQlR5M3ZELzkvZDM2aEdXMUdQOElUOXlkLzJ6aDR5?=
 =?utf-8?B?bk42Q21xRmFaVjJGcGx3ajc3WnJVZUxRNUZIRkp3ank2bHpBMkZGTEJkckEz?=
 =?utf-8?B?aVNBa0ppdjlDZ3VsWXpNN2JJbThqbUNHWDdvSHI0SFdoMEg2dkFMWWNBUC9R?=
 =?utf-8?B?UjZ4VkVURlJSbUJBVFZ0LzJZZFZsUzVTRWJnZVNuVktzeUhPMjBCSDk1elZB?=
 =?utf-8?B?SE43RU54dHBkQXRncW1MUjQ1L2prRlNiOTNKMWxuQkhVOTBncEpFTEZLWm9r?=
 =?utf-8?B?T0FaUy94NjB2WTErVW45Y0J0dWc3S2xJcW1MYk1wNGJReWhtSXRQcjdjY2FB?=
 =?utf-8?B?VUtwZitKWG0yMVhreWFYRk1MaVRnM2d1aW5oc2hDblgvWktYM2trdHpyaTBC?=
 =?utf-8?B?TEV1ZnZnd1NjRC9jV0tKSHdZWUJCR3owRGRJUmE2R1JpRklQRmRJd2tWVVdU?=
 =?utf-8?B?aCs1WE5DMFlyUTVsWUNLS2F2WEk2MnlFc2E2TjEwOUZvMVNyc0UwV21tTERo?=
 =?utf-8?B?c29qTlVhV3NLb1F1UEpYalB2U0JKUE1KSDdqbEFDcWo3dG9pNlluSUsrZllM?=
 =?utf-8?B?NXB6K3I5Z25OMUdVVVU1SW1Ca3RkaVpyeG1mYTBoRG5vajAxblRNMnQ4U2Fi?=
 =?utf-8?B?c2NIRGpCN2RpTGRSMlB1c2VwYnd3ZlY1TUVKSVdTWnNMenFqRFA5UnptVStw?=
 =?utf-8?B?RHZxaHlvanh3a1F0eEdVdTZKTEltVUJvY2J5a1RuNXA4NEprMUdlaVhrcXht?=
 =?utf-8?B?eFQzNlEvU1NjZXAzRVljUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktnMXJzT2tyQVZOSXN2OGp6NEhRZXZwOEVmaDFKRmcxQlFRT1pjdWVnK0JM?=
 =?utf-8?B?anlBWTErQlFoMkVwcGNrTXh0enErVUZMdzNBSHFHak1GaDA1WmswSkNoOFBW?=
 =?utf-8?B?ZHptMDlUbFlyV1o1RjJ4RzNiNkZSWDdNM2o4cG5PYmk3cU1ubnhkK0NMSjVo?=
 =?utf-8?B?VUVCdzlWYkFUZjZLZE9pL0MzSitQeUQzWk5TYitJRVB2QWhiTEU2dHROSnpI?=
 =?utf-8?B?VkVSSnJOVTd3S3NsTVRQZjdOemxRRWYrMjhwSFJGTDdOckNkc1pqTEh6N2Uw?=
 =?utf-8?B?K1oreGxuVTc1a0NkeDVMby9kTlh5WDFpTlQvcllla0lCcmVPMklzcHNaRVNt?=
 =?utf-8?B?V3NhM0pZdHJ6cHlpSWIvV05XdnBiaFJpNUlMOFZWV3VjbHh6aUdsU3pLdlZ1?=
 =?utf-8?B?UXlzSGhjQ2IwdE8vNnlHMTNUTXhzditnVHYzNkRHYzRERzIxeS9hSEFUNTZY?=
 =?utf-8?B?RmhXYU5mc0NiMmh6cHNweWczL2dIUTNrQ2R4UjZuY3I1aWRzNnl6bVpZTDhu?=
 =?utf-8?B?WTlrSWM2UUVYQ3hDSnc4VjVTZ3VwZ0FuZjZzSndBUGFPbFkza0FjWnZDQXZw?=
 =?utf-8?B?bXJ5WGN1ZFVrcEg1dGs3TEp3c2NKTTFlTE9SRHM5N1dFY01hN2xYejZBTDVU?=
 =?utf-8?B?dUVFV1NxZnFWdE84TW8yUXVvWjJXMTZWcGp6cDNBT0FrdXkrOE9ld1JiVDRU?=
 =?utf-8?B?ckFFczN1RjdCaC90b3J6RDVNR1RXZjN6RkZzOHRZbTNrR0dzRjh3RkIvZDd3?=
 =?utf-8?B?ckNDQ1pMMTBSajVXRXNIVlA3U05FSFpldkZHZHRaa2FwNVRTSW1TODYwcEp2?=
 =?utf-8?B?UUpSMkphSGRKcGd1aGMvSjZMcnJxMExCZ3NyZmE2ZFl4WUIzZHRRei9qMUhr?=
 =?utf-8?B?M3BBOEM5TGdPcWx1L0hIT1FGODlSNThRZ1k3Vk1LWEUxbjZtZVFnVDJ0aThI?=
 =?utf-8?B?RnVUQWRyRUxiN0ZUWmFZN3poWHdjdWxNalVRa2JzVzJzUm9EbVc0SnIzbDV2?=
 =?utf-8?B?YWZ6SjZUK2o0MStsZFJjRWFyMkRQd00xMTJhUmlzSTZFZlptK3ZxSVhJNkpl?=
 =?utf-8?B?L0llU3gxZnJNcWl4OEJocFBlTGtuRnpxVXFyTVlBMDMzaDRSVEZDNjJPdnVp?=
 =?utf-8?B?YldOTE9sUlA0SGRrUHVoVW9meURDeXA5ejhRYVQxUlNZWDhFN21CSWhOK3Fz?=
 =?utf-8?B?Wk9YbFhjNTVQeERodkRrajZoalRDQ0tPOTVoeHFkYlhJdGc4VzVFWDE3MnYx?=
 =?utf-8?B?WnBQaWd2Yng2SzhSUHlGTDhjcEVCSm1zNnJzZlVjdGxHSGhpYUswSjVkc25x?=
 =?utf-8?B?SzdOb2t6OG9JT05kQW1BR2NlYnR5RUI5V3pQcTI2a2dmUVlXRFcycDJDOElt?=
 =?utf-8?B?bC81OG9UY3VhdmhYUUFJeEl4dnRGeWJ0YVMyeEd6em10TUtUaW5oK2UxU3J0?=
 =?utf-8?B?UWxQVExsZTg2OTViRzNrOElYVXpNNDBNandrdHRXWDNQck9UR3FlMnVacEdK?=
 =?utf-8?B?TklPS2FpMm5GS3B6SGxwWm85aisyYkJlaU1EbXdXWSt0NWl5d0NlYVNYWjhz?=
 =?utf-8?B?WkNNWG1HMHQxdWV5L3Z0eUJDVlY0T3pVZWM4VzVYWXVocHVBV2xaWXFQN1ZP?=
 =?utf-8?B?cEI3SHlYeStCbzZCUjg0YkFlUEtnUnRQMi9rZTNVUnFWOHVMMXVQaTdsblJZ?=
 =?utf-8?B?Q2diRlBtMWNoclZsOWV3ZXIzc0Y0cWdyQzExV1NVNCswMFpMaXAzNTFsWUtT?=
 =?utf-8?B?NW1sV09NNWRQaUxyck1XU0VrMnhaMlNOWkVFRlg1am15dW5idE42c2p4TU0v?=
 =?utf-8?B?SWNmZkdUUmVRbnRRZTlBa1d5N2dBN0pzdmdBNVp3aGovdnpoZTZQdGNGbzBN?=
 =?utf-8?B?S2F2TTRJbXZQQ21DemFIRDgvMnFkYmFtcVloRXhpVkdUMUpiN3FHd0szalBH?=
 =?utf-8?B?VWdBbVdzUXlnOWxtRzhtY05FWEdldWhvSlBKQng3R2J2VFJuanNWbEdXSWdl?=
 =?utf-8?B?Z3ljSE9EN29zVWxrYzVCS1puZzQvN2lTM1g0dEZ3OVNmTzFXREpIME5aa0V2?=
 =?utf-8?B?ejI2OWFXcjFHRjNUS083YkMyWGZrWlNOdmc3Y1FYS24zWWZQcEdiczVmNytL?=
 =?utf-8?Q?k3HCtnUnGxuS+UJiwQ1bnu2tS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf38d44-74cd-4f33-0ea2-08dc9d054617
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:15:15.9571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vX7VGWzBrJvgKi9vVVEkQRUrjGyyyDAZAxVMx5yZdRfcTFg1YgssniaHdYq8jCBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736
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



On 7/4/2024 9:10 PM, Zhigang Luo wrote:
> to avoid reading wrong WPTR from doorbell in sriov vf, set
> CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.
> 
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c         | 3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 8d8763ebe027..4556a1be5f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1584,6 +1584,9 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
>  				    DOORBELL_SOURCE, 0);
>  		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  				    DOORBELL_HIT, 0);
> +		if (amdgpu_sriov_vf(adev))
> +			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
> +					    DOORBELL_MODE, 1);
>  	} else {
>  		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  					 DOORBELL_EN, 0);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 399fa2106631..66c73825c0a0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -546,6 +546,9 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
>  		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>  					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
>  					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
> +		if (amdgpu_sriov_vf(mm->dev->adev))
> +			m->cp_hqd_pq_doorbell_control |= 1 <<
> +				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
>  		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
>  		if (xcc == 0) {
>  			/* Set no_update_rptr = 0 in Master XCC */
