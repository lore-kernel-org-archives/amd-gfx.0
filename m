Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79295C25B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 06:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78AA01132DC;
	Wed, 29 May 2024 06:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2hKkm9tE";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A7201132DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRvnsprytYLzPFc+xMpcP21QsZo2EKYagB2CKf4+9UhgpekNyTmE0+W9hUb+/uG1Ox+q391LshymSl/+JdIr/X3iNaQ/mwc3RrDZ7/hpff/jVdhPR36S5bePE6N+cfvzcnMNUSEiykjLZlihC+1puSVsUO7WT/TY7T5aK2XDnpeyocXN6Pd+P+XMPjDoOgVWF01x19gzzZYLZXtzw+Ip+IXPBjFBhUlnEGGzUIVIC6wwAT1LHWl+ifCbrCwNycj+zB7O7drLA7U485nKCF6VLgg94lLllF+D6MxPjTPTE8+oXXo6hqq3MzSU3342VS9u74unWgKoiagfnzLY0xbOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BNeI888eF55M1Vqb8VAwalJ8Sc8MW4xrJKHgGzennE=;
 b=cn7dhpLAvE414Yz3ucQKYntI9RSrsRWX/MtqMG2Dau9PCSE3gHh/OzhZ6yBsBVEBaYa+kBpF5gnns1rSdWkITISlsPEsMppDeQlPp/KpZp/pJpd4vTbm3wz3m9Zrx2cLcdVdxGyvn8bLOJCdEnhbczgHSWRZXC/dFNijqQogwdVa/UAUMFo5h42yQfbXN8y6GsmbTWwsT+N3wJZR0aPvYK5Bqe6+bGEQ9VtHlX68dtUIJBgKbwpjWHwsYRASHBPjkW+QVckQg3zRVK38gyOKO3uT3EQVES1gGGeKCCvU35n+cJABHAEGlwUPjmfXIkAIsUSG6uo08qQTMnOS5K48nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BNeI888eF55M1Vqb8VAwalJ8Sc8MW4xrJKHgGzennE=;
 b=2hKkm9tEQOR04CzMAzTOr+J4i4ANBj3zSnJ0T3+NuThloGGWueYyGtaifQbzIrdFKjwBIz+eSBDZtDT5R9MeC0vRTfeP7UT8w8v4eN33ZJyF8vo2t2PXwN+OYjWr21q9txaue294qnRA9kyZZkfEGaqRc/djk87HjnD4OwVCifc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 06:45:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 06:45:29 +0000
Message-ID: <8ac34b35-1215-4fe6-a30c-1076a56fa1e9@amd.com>
Date: Wed, 29 May 2024 08:45:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] drm/amdgpu: remove tlb flush in
 amdgpu_gtt_mgr_recover
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-7-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240528172340.34517-7-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 9223e3ec-9dc7-45aa-8e54-08dc7faaee05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGw1UGlYRlhLRDVXb1dITnNiZjkrZ09lWVE1a1AxSFhGdW5xVmx5Mmd3Qlp3?=
 =?utf-8?B?WCtaMkxRT3ZRbjdvVHQ0dzVXMXZ2S0NhQjVnbXM0cjMxQm9wLzRRT3Z5TDI3?=
 =?utf-8?B?bE5HY1NRK0hNMS9pM3NOV1orV1p3NlQyK0xOUEhLcWttR3pybXhkK1MwMFpI?=
 =?utf-8?B?WXlIL0ZCQnF0dnQrVTM5VHh6WlNtdWVEYTR4Z3IyRWR3REpQVGw1NGsyTDhm?=
 =?utf-8?B?T1ZoNEpzeGNyem16Q21hNC9adUJzaUVySkh3cmVsUmU5UVVoQUxLT0czUzlt?=
 =?utf-8?B?VUI4K1dzK1RIVGFNYXZ0cSsxQS9qaDJqalM3Myt0b0Z4KzR3aXlEOTVRT29X?=
 =?utf-8?B?U3NiekdmdHBEL3orb1ovTXpuRjNoU0FTQ3FlVEgzc3J0ZGJpcHU0STN1R1lC?=
 =?utf-8?B?Y29jalFVTE1PZDM1NTc0WVhRS2hUdzFpOU9IakY0L01nd0JLMlRaZlhjNWts?=
 =?utf-8?B?ck52NU52NndHNmNkWkZtRVNuVmp1ZStobDc2ZldkcTJFU3grWHVONzBPdDho?=
 =?utf-8?B?OGJIZFc3QTJ6OUdsa2pIKzZkcGlpNENXWGNXQkVPRFlKS2x1RTI0NGpXZE1n?=
 =?utf-8?B?dDRZc0IzWitkTlRHT09vN1RLbmdTQ1pjempsSmtEY2NzU0RwV2d5OGYxWUJC?=
 =?utf-8?B?WEl5Q0RDNWphbHpDTWNqMlRWdmhGd0ZFeE9LeEJnNFRjb0loR08xQ2dJY09O?=
 =?utf-8?B?T3dlUlkrNDYwUG5qeDRxNFJHOTc3VHcycUlKWUM5d0ZsSlF6SWQ2VXJlcDcz?=
 =?utf-8?B?bTV5bWVKZXcvdWxrMHR5ZnFWazRkdDVHcnhTZHpRSWFQNUdMV250cmgrMHRP?=
 =?utf-8?B?VU9xV29VdWpwam1uTG5Fb25SQ2hQdFZTM2JOSUgvbkJQYTBmSlVsNFFKdE9h?=
 =?utf-8?B?UWF0M0VqZFZIaE1RVlUvbVMySlJSZDlUMjVsT3lZWjhhMmlLa3ZCWWt5M3RL?=
 =?utf-8?B?akNJaU90VlF1dFpNS2hKM052VUN6WVdQaE1KQXJvTVFkOVNzdi9aaGhkeEVk?=
 =?utf-8?B?cnd1Q3BkQVhRQWpJeDBxZ1VnMDBWVkVHcG43QW1EWHVBM3dDc3dxTlB1NDFq?=
 =?utf-8?B?STRlMVB3d3pFQU5PY3AwOG9FcFE4aTZoMzBsTWpMUXM1ZjhnRWM2QkwwanB0?=
 =?utf-8?B?dXArZzQ3WUFhYTlONDFucWFKYjFqckFHUngvcTBzR0JDQ1F4N1gwNzhZdGxt?=
 =?utf-8?B?dnZCYW41NnUzNWtSbEl2NndncG9JQ25TZitSTE1iMXFDSFVvNU5yQ21NdzlD?=
 =?utf-8?B?MEUrNHNnTHg4Y0dTWnR6d3REL3kwWUxIR2pvY2RrVjlvSkc0bXB1b2VUd0Rw?=
 =?utf-8?B?TThuY3B0RGxFN1hvL2xpL2R1SzR4clgrbEk3YnJKN0c5QitCMjZWeEV0TUtV?=
 =?utf-8?B?WEhvZnlSQU93TFo0TGJYQVFIQ1Qyb2ZkZjJESFFNYzRlOW1TaW0zbWlMTG9P?=
 =?utf-8?B?b1BtaHoyVTRDdlFxbkRNVm9aUkE0NmJXb0lPdnkzM21PVG1MR1V1aldHTEFJ?=
 =?utf-8?B?ME9iRHJKR29rWFpQM0RIalVpL2hNa3BLZTR2NHhhZnpnVE5KS2lxT09EVzgy?=
 =?utf-8?B?Wml5S3BrR2FTK00rRzgwTTNtUXVXejNuNFgxTkFBNklNcE9CTWZ0Wm5ZamlC?=
 =?utf-8?B?Kzc2Q3NNT0RZSEhlek8rWmNSMFZCL1BKMlMvMFkwaGpyWHJRdW04cm9PYmE3?=
 =?utf-8?B?Vy9aSXZzV3dITkM1d2N1S2VGYlhLakhqSWY4YjF6b0lFdWY3RFZXMUxRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by8rUHR0RFpXNFlObCtVTG1KbTVNYnhGbm1ZSHlTWWdLcnFpWXptNjlNTFRx?=
 =?utf-8?B?UXV0TEkrNWJPQmpNUURkeEM1RjNxMThmeDVlOWRSNXF1TVpCZDA1Njk2ZTd4?=
 =?utf-8?B?Um9DMEdJZW1QOUJvaVVkRUQwbUk0VkJGYzBaY3kzbE9iUVp6czJwVDlvd0JB?=
 =?utf-8?B?M2JuTWJ3NVZLL3N5YTZkSWxNMDFqRlNveng4RVFCNnVEWGhyQjZOcytmYjRZ?=
 =?utf-8?B?dEdVZlpUN1RRa3F6Uis4bmhtamRRRHM4VytUNzRoallrbEZ0LzcrT0pxWjJz?=
 =?utf-8?B?aU9aNHBwSEtnYWFVelFKMWhOYVVoeCtTbnZ3Y3JnVmsxa3l6NmJad3ZUMWVa?=
 =?utf-8?B?bk5ic0loa1B5WGdRT2ltS2JRVzEyN2tkaGR6V3FkdEFwNXE4SjNFWmNrMUpi?=
 =?utf-8?B?UWFURHA1K3k4Vk5EaVJXSGtXa2Y2RlBOazAwQWY4QUh6cUhuTk1DUkJsSE92?=
 =?utf-8?B?cWxnZVRzYUxycHpvWFVUa3V1eWVoUlViL2NQV3dzVDRwVTUwOGJqV1lEQXdq?=
 =?utf-8?B?Ulg2ekNGMTl5N0FaendyNkpLb1lJMVpkd20xVFltZEdSQ1Q1Y0p5b0VXZk5F?=
 =?utf-8?B?MythNDRCNlduN1BYTkpGY2t2ZlB4ZERxVThJNnd1V1pSNEdMUEQvdVJwSjBj?=
 =?utf-8?B?d1VtMjRXM2N1TkNFN1BSM2w3aUZSQWZPNkxpSDRlKzZGdHBxSE9YYjhLeml1?=
 =?utf-8?B?VTU1ckc4SXZWM21Rd2lQbk4zN2FEVDdtaEdiOXF4VkIvSFg5S095WnIxWHJZ?=
 =?utf-8?B?Z3J0MjNUWFkrNjhGblBFSnlqR1NMMFo0b0VUbDRDY3VDYXJvRUozc0NINlBu?=
 =?utf-8?B?UENGL3Q3VDNFK3FHRmgxTGl3aDVmbHJPSTBvSkVVN2paU2trV1ZSSmtaUEIw?=
 =?utf-8?B?MmFrQ0t2M0JnNXlqUEd4SGZFYWdTMHRjNzhIU20rMXhpMy9nNmZjbERXc0ZT?=
 =?utf-8?B?ZndNMms4YXFLMnNXM04rdTNuWWRUdkF3Q2xuZ1lqWWo5OVcya004ZDltaUJq?=
 =?utf-8?B?WUs2cjZNRHBINFZLcHc5S3F3WENEWUpuYVRlVVZ2Y2RtTjJJaHAzLzFqWG1T?=
 =?utf-8?B?N1VnNzhtbDdpNmhUZUtpRDcvSG9CelZRd2FMSFpGRVFtejJnRjdiYnJKVllB?=
 =?utf-8?B?eWEzQlFwOWJPalFlbzlUaEtyeEVnZTlJNDlyQ2taVmljY0VjWi95T2hpSnhV?=
 =?utf-8?B?MXUzYU1yVFBCM0x2aWsvSEszMVczT0FCeHgvemJlU2phZE5YUG93VHBUNlJr?=
 =?utf-8?B?MnBOMFllQ21yenc5U2s3VHpKYTZ3MVlWVmtNWUlIc3krZFBPSTRNN0dweCtu?=
 =?utf-8?B?OVNQdEVCSnVOQy8yNVQ4VVBBLzhDeXR2bE1yL2dyMjNGWisyTlRNZW41NFF5?=
 =?utf-8?B?ZVhyN08zcnU0M3A2cTVHQmNUd2FVaXF4djF5SjJ0N2pTQmlERERTZWFPTHJZ?=
 =?utf-8?B?aWl6VFVKVTBvTmVzQzVFVkUyTU56ellra2ZrVEtXdmkrUkR1TS8xUitiRFRy?=
 =?utf-8?B?cG1YWVVLOGE3ZXh1ajhVc0JBUlpmZThOcU5CcFR4RzhwdFBQN3BkSSszbVp6?=
 =?utf-8?B?cnFUN2dVRTZuTVQ3bWhKMHFRdXNEK21hZThsanE0SnA2ejd5eVVuVnRjdHdq?=
 =?utf-8?B?ci9aYm5hRGxuY0lhd1VuRGVKcUVpcVNjWnBvZWdRdFZEZnpUYU1nMnpoZGtq?=
 =?utf-8?B?M2NKaUhIOGlrVkFMRGFkMmViK25UZkxrQ2RZYndhTklDR3RmVDgrdHdIRXRv?=
 =?utf-8?B?S2FVcmZlYmxPZW9JSFNhVFBqQWQ2ZmllR3g5eGVwYysxeTNoODhtNmRNWUcz?=
 =?utf-8?B?WWQvK0dsdFJ0ZWEyd0VxNS9zOTh5elNrcWF5UHRUZXc0VnJua0hvOTFwd2Iz?=
 =?utf-8?B?SjBwc0JLTFVkc2NoSS8rUEQzS2tzVFVGNk9lM0pKNis5ZUVRTTVkWHRQYU1C?=
 =?utf-8?B?RjFBSndVSXJ3dlhZU0FCSVFxQVZkQldacXJ0RFpBQVlJdW5uVEdNcTJ2cEpq?=
 =?utf-8?B?VTZDTmFwWGpPakVoUVlhY2tScUszNnQ2dllENjVQaklpdklJMjlTRnB3M1Vl?=
 =?utf-8?B?dmVRTzhDdTVqR01QUjJEWWxISXphSThwajNDaldzUFJWMFhud0FxVHo0MFh0?=
 =?utf-8?Q?jFQPu65243m1Vi5rw4my2aka6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9223e3ec-9dc7-45aa-8e54-08dc7faaee05
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:45:29.6742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7Cfjhvr/DThI/O+0665gcehh4i0sUaKPHoxb7lGwCjaxbpmC2Hf9NFPH1eeCd5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

Am 28.05.24 um 19:23 schrieb Yunxiang Li:
> At this point the gart is not set up, there's no point to invalidate tlb
> here and it could even be harmful.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 44367f03316f..0760e70402ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -200,8 +200,6 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>   		amdgpu_ttm_recover_gart(node->base.bo);
>   	}
>   	spin_unlock(&mgr->lock);
> -
> -	amdgpu_gart_invalidate_tlb(adev);
>   }
>   
>   /**

