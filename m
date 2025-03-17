Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0B3C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 15:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47B510E425;
	Mon, 17 Mar 2025 15:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NYNKWReB";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D738110E425
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 15:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fydw0xFs2qsxMDKLEmzwT8MSHYmpGapH10DwjcqObxad9fQxx+fk/EvWu4RnoD4KFRmSfYX9/wQA9Qo7dskxP5+k+kXL6Yl+uE7dkNKJCxQ0Yqj9oZFltJwtu+xo2omnHnYdn58y40Ig6Okb8M4LXY2GADH8AsbM1vs4OqgdNG5ftINxFqs0dL4RGRrIOOy1gIw9f3jHTPJToRqUtDMtQSckSS06eaNY5Ucw9hdkAyN5C02Kc+1v/WTVNdO2venlwCIfqe8M1mOu061x7QblqbJK85Z4CnG2AXSbuteRQKRO19J28zwDO3rBPr3RvG5nebTSr2TU8fz21GK6Abhwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgZYRcU+mt3wu7XbU5oBM0FIQSSNXQoivRbj+PM6ufg=;
 b=ogf+I9pyvqUP7bNrZTHMHUfYWCt1eUWT6ur4im+xZ5bskuZ6FLYExvAkGJjoemkKoDlSJvzPYLepwLCNS8hqwdm0Gls30OSgUiy2hco7YvLF6ycJurFi1uwTew5zHGqdpFUn91ZS/jr3n2EzDS/rFmpewd4pqTLhBRrFyyTD3NbFo/B+moOE95TveL/as1HWY2sU/h1dpRKn0ulVAXp6GmayD4oiAWZBBUxtxu8Hol5POeVTjBEXMIezNDqkaS2En39tdttmCya7ztCUcVLFNakgoABkO89Bj+FKLLMPpZEsXAzaepGhmws7xHqXVdi6DNI/rP/EA/ICUXLxklYqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgZYRcU+mt3wu7XbU5oBM0FIQSSNXQoivRbj+PM6ufg=;
 b=NYNKWReB6GfanEkF+3fUjc+hwtEPsJyQINqLdAGmUPx5pI+Vkxp+681XnubL8Bc8/1sGtTB31cehQ36B2Toc5a15+PCdjM9BSJJ+n3dRz6rsR4WXMHYdvdnuuZcQ9QluPrmw5Yaf3+dAuLbFUUBj+DRALC2jxsN5dDu9ZprKqJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7802.namprd12.prod.outlook.com (2603:10b6:8:145::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 15:04:53 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:04:53 +0000
Message-ID: <3f8b3199-d781-4d1c-9e0e-bd378a547f62@amd.com>
Date: Mon, 17 Mar 2025 20:34:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/sdma: guilty tracking is per instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250317144603.809849-1-alexander.deucher@amd.com>
 <20250317144603.809849-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250317144603.809849-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a79fd4-be66-4d27-2019-08dd6565123f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1FCY2ZjWndYR0NvZVlpSkVMeTBmTjliSnlZNUk5ZitMTGgvQks3bFVTY1BE?=
 =?utf-8?B?Uy9oWURnZ3ExcndnN2Y0NWo1cU5kb3RaYVJWc2pzMk52SjBGeWV5MlFaQllV?=
 =?utf-8?B?V2puNWl2cnNKWE42bjQ3TW5YRzk2R3RrckFUYW9hLzIyRm5aMWt1TEJmb0lv?=
 =?utf-8?B?ZzJkT2N0UGRsb0NMWkF3UERCOFpsQUE4QTZXNmFZL0NlQnp1bmVuaWQrTFdV?=
 =?utf-8?B?S0dlY2VpUzZZOWViNHFPM1FSUkdsRVRMRklKanU0VzV0SUlJM2FhVHluZnNI?=
 =?utf-8?B?bUNIZ1V6aGMvUFpKRG1ybHR4N2s3Z29FTTJSUFM0c1h2VUg0Um9odlk4UTQ0?=
 =?utf-8?B?VzhUNnEyRWZxeGhkcTBCQ2lpTEIxS2w1dVdLd2VXa1hNU3cwMEhVWlVKU0Fy?=
 =?utf-8?B?K2lSaVFUT1dZZUp3M2FFU2gvM1p1QXZqbk9wYm1YZENPNW9pWVhENkpxMUND?=
 =?utf-8?B?UUUyekZjMTkvTkVTR0VPYmtReVNMZ0NpQldpV3lFT3IxS0pvK25ZQlNaZG9v?=
 =?utf-8?B?Smh5a3JkL2hYWVM3Mkl4TVdsQWR3NlNkRXlZTVFXQzdYM2VRZ1VWa1RHY09y?=
 =?utf-8?B?RmsvOG9ZTnlpdHZJZHVxVXN1Wm9FeGtWM0hWSUt3UHZQL3JEVStDekErL1l6?=
 =?utf-8?B?bk5JS0Nxc0JRWUtqS3NFL3czd0RMdXExN0ZyOTVBNkpEME13K3JtVW9oQTJJ?=
 =?utf-8?B?cWJPZE9JYTRzUExUbDdGalFrZnFBazlEc1lnclE5bkl2ZXlBbGIyT3dzU2pm?=
 =?utf-8?B?R29jR2lNNndrYkZ0M29McmVaRmNva1Z6YzI5Wmh0Z1hTUXhEOWlESGs0a2dB?=
 =?utf-8?B?bm5xbHdNZGJHMEJYa0Rzd3BudU40V3B6UGE0d2pQWm1OQ1oxVEF2SU9ZQ1hP?=
 =?utf-8?B?K3AzcUVyVUhQSVRkcFNWanJ6WGtCeVpOejlMNEloR0RZbDkwcFVrUTQyblZH?=
 =?utf-8?B?bk80SWtsZEVQUjhVMkh1ODhaNUlLdVhNbnlIcGdmV21uVTVqVndlc1VjTExP?=
 =?utf-8?B?bVNpM01qbCsxRU5nM0w2S1BmY1hxbExhMWpmMllnREluN2t3cjJ1ZHBhamVG?=
 =?utf-8?B?RnFEQmlhZ1JLN0Rpc3UyUUFlR2M3SUt2U21iTnhCWk1KWXpST2VaUXNJMEhu?=
 =?utf-8?B?SEdrbkRKdVVjWWlOTHp3OXBZYk1DSWJpRG9zeXMvc2ZjeEN4R1JsaDRUaFp4?=
 =?utf-8?B?WFc3RDFROElVM1JUb1pvRUFRdUJVMjA0SGNvRWVqR2VVMktpUWhjOUNYQzBL?=
 =?utf-8?B?SXZPOFNNR2prMWZEclBiVWc2L0RULzRVOUR5Yk5hbml4Vk5QUVBPM3ZHamZ2?=
 =?utf-8?B?VU9SdG5zU3JRN1lhWFQxdEJibXA5azN2MU1XQUlzMUYzbWJuVHNIaFowalBw?=
 =?utf-8?B?ZlVoL09mR0d1ZlJhN1I4d3VlT2RIeWdKRVRLNVRvUlZJWFZGbnZRNEplU20r?=
 =?utf-8?B?T1l0cnhZVlBubTB4d0VoVklYZTRXREJKdytlOTJpZU9kVWdqcGxBOEJ3dWZk?=
 =?utf-8?B?S2kyOVJtajNJbGFrcDQ0NlFjN2x3ZkQxbUhneHJ5YWNLa2dWR2dSa2FoaVd5?=
 =?utf-8?B?Y2JkOXRkNkk0NFJ6M0xzM1BzUWxJc1pLWDdHZjhRZWg1eVU4L0FvS3JxMUVx?=
 =?utf-8?B?WC9qNXFrK3pKeStEYzlHcTBnLzNXOWorRXRQajQzSmNwcFoxOXpRN3htSU95?=
 =?utf-8?B?ci9KNVppN2lIUDdXeEY3L1I2bUt1dW1Eejd2MzRuSEJTWEpIa29HY2ZIZmJq?=
 =?utf-8?B?WGdkQTlqTmFxRW9xZUZuN3IvUjBJUjFIeGpJR0pkbUNzR1J1NXFGOGIzdTM5?=
 =?utf-8?B?T3cxZVN5TzAwOERPZXU0NE51SVFGdk8xZU5PM0RKV1lkVWhpNm9OT1NXNHBZ?=
 =?utf-8?Q?2YQ1REY9PPJH4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDY5dHl2aWt2cTJTSm5JbThORXB1MTNIazVQeWlzblluQVpQQmFjZUx3TVk5?=
 =?utf-8?B?UXl2eWxub2lBQnJKd3MvUS80ekl5aXpnT2hrYVVhUElXT2pzUlVzMTFUUEhw?=
 =?utf-8?B?TG80QjQ2OHdpbFFlWDhCNGxCa1NkRmFTQTdvZHpsS0JTcVFNYU1pOXZmZVdZ?=
 =?utf-8?B?VlhjN0JGT3pWWVpXTUNudnlVb0p3WGxPTjl5OE1aMzl1ZUQwbmgyRW9yM2FN?=
 =?utf-8?B?eU85ZlRQVlJhNExndzhSYXk0WmJhanFROXYzT3VQRmhDK1pjRTlzU2FDYnR0?=
 =?utf-8?B?OW4rLzgySjRvSWNVNTU2MTR4cGFwRlBtTXM3b2FqdTIrSThpZlg1WkQzL1Vs?=
 =?utf-8?B?SDhweHlreWtETEIrUkdoSzFlb2JFOFB2YnliMGgyQVl4bDIrc2tqdWtyVXdZ?=
 =?utf-8?B?dk55ZmR6QWRTNDA1em1ldnpqSUxNYUUzT3VIUnRtT2dQcmZXOGUycy85LzFY?=
 =?utf-8?B?ZzJxWGhZRVJzUks4VUx4TG9LU0JFSzFTTDFTV0kzbklkdEVDeDdnVFU3c053?=
 =?utf-8?B?cEN4WWhIYU1rM3FJWEZScE05THpTcWRzYnpBODV2d0k4RVNPWjhoZGRvblhW?=
 =?utf-8?B?SjRBdXhrNEQ1TisydkpGMnowdVBFa3o3RStrVjc1N1gzUFBQbDdmbUE3YVFK?=
 =?utf-8?B?Z2Q2SDd3QXRXY1VGeDlYbTFQdFRwR0hvU2NOTTd6dmxQamYwZzBTZnpSYWgy?=
 =?utf-8?B?TG44UVlTMjl2ekVJbzNpNG10SXBpUUJCM0huSUtKN3cvQVdqQnhoVE5Haksy?=
 =?utf-8?B?L2NqN3RqWHJpeEVnQzk3WEFqMUw5NWZRSU1DMDZiQjkrVXhGUmhRM1NPR3Jj?=
 =?utf-8?B?bVE1UmJLbVRWd3R5N2JuM2p4OGpURks1ZVdTU1ZRbEx5ZG5WUDcycGdLbkEy?=
 =?utf-8?B?WFllUDN1aitwa2V0NU05ZGltSVdiZERMbi9hR0xIYzVTTkNZRnJVZ3IvbjNX?=
 =?utf-8?B?VG0raFZOYlNRSmdsWkE2SVNDdXFNMkZzNU1hRXpKRVVLV2o0MFc0V0lNMk1F?=
 =?utf-8?B?TnFEcHRZSTFEQzNiWW84b1ZFTExoVFB6ajdZaDZ5L05tYnJWTXpHQSs2L0lt?=
 =?utf-8?B?V1ZyaTV0SjZjVU45RmNub3ZCTVNLSHNXbEJ3MmRLMmNrR2VUTVQ4b1ZMalIy?=
 =?utf-8?B?LzRPUnFTTlFpaFZxaFl0ZGRTMlBtaXFJMFh6ZHd5Q3lnelBsZGtKN05GUjZv?=
 =?utf-8?B?YmMrYzJSNG1ORTRMdWpHSUE4a2xYWnRRMWZGSWZjZStKN1hBYmRXQU1UWURq?=
 =?utf-8?B?NVlBSGxDaHRnLzZZaWxPTC82amlXOHNXQ3NIK29CUHVWdUJyczh5OU1PQUhM?=
 =?utf-8?B?SklvNG1FM3A3MXoxNmd4c01CaGZ0K0s1NHBzSVI4aVJUMzNtWjJBVUlueEpL?=
 =?utf-8?B?cXZaT0N1bmZ5L1oyQmtGVWhOU001YUw5S1Zlb0s5cGx6RFBTR2oyUk1wV1FN?=
 =?utf-8?B?cHYvU000U1BXOVd2MnNiaXNJZktsQzBnSFdpS0liVlppOTUwSFRTdTh4NDlC?=
 =?utf-8?B?TVBxTHRjcEpheSt1N01mYkV1dTRxbFEvVUdtSitVdS9INERxUU5oalZuVGkv?=
 =?utf-8?B?RnBBRWZ1Si93US9UYmVSY2JVY01RdUhxT1BRUjJKZVp3UUxjUHo3bUhOVGNu?=
 =?utf-8?B?Ym1UV1Q1ck5kdkE5NTZZeStWSmFxTVBkam1mdHQ5Z0hKQkZydkVsNzFWQkFB?=
 =?utf-8?B?L2t1eHgyeDNUVWc5RmUwVGlqNTM4N1MzN05yUmVseXZ1L3RBaGJLajNmVnlW?=
 =?utf-8?B?Y0RQaFJjQzhOYVZsL29xL252WnZVaElwaHhCdGxHaXVWeVlKRlQ2ZzhqNlJB?=
 =?utf-8?B?Sjk1emtUWmY1TW43dmZqbHdsdGNpRnJxTml4cjRjSTNHQUNPdHBXQXZsMVl6?=
 =?utf-8?B?aFZmYjlTbmZPdXZZdVVtNDIreVluRWI1Q3pCelM1bGlzenZoUDdFMExMK2Ny?=
 =?utf-8?B?bU05TU5DN3NSTklDdjRUUHVVQXJ4NUpQd3JvK2YwN2NMNk9oTUJtU0dJUm9h?=
 =?utf-8?B?ZHd1Z1dVWHBKNVptRmFDNWc5ZkU4dUwrMWRwZlROampPaDlMSTRmMWZvcXRJ?=
 =?utf-8?B?V2xHbVAzK2dIbmdEZDF0dzRIZkxXUG5NS2lHa1RaRXRKUmcvOTZEWXdzb2pK?=
 =?utf-8?Q?g4X+pTMcMT/7Wjqr0mmp3S/Wk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a79fd4-be66-4d27-2019-08dd6565123f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:04:53.2337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wioU/obOFTzEhwz5rquY0ImdrnKbQwk4HHWdmdii6m8abBOyvmTmNv+K9NlGKIGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7802
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



On 3/17/2025 8:16 PM, Alex Deucher wrote:
> The gfx and page queues are per instance, so track them
> per instance.
> 
> v2: drop extra paramter (Lijo)
> 
> Fixes: fdbfaaaae06b ("drm/amdgpu: Improve SDMA reset logic with guilty queue tracking")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 27 ++++++++++++------------
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 8e7e794ff136f..dc1a81c2f9af7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -65,6 +65,10 @@ struct amdgpu_sdma_instance {
>  	uint64_t		sdma_fw_gpu_addr;
>  	uint32_t		*sdma_fw_ptr;
>  	struct mutex		engine_reset_mutex;
> +	/* track guilty state of GFX and PAGE queues */
> +	bool			gfx_guilty;
> +	bool			page_guilty;
> +
>  };
>  
>  enum amdgpu_sdma_ras_memory_id {
> @@ -127,9 +131,6 @@ struct amdgpu_sdma {
>  	uint32_t		*ip_dump;
>  	uint32_t 		supported_reset;
>  	struct list_head	reset_callback_list;
> -	/* track guilty state of GFX and PAGE queues */
> -	bool gfx_guilty;
> -	bool page_guilty;
>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 927db7a080f0a..def68f4802089 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -672,12 +672,11 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
>   * @restore: used to restore wptr when restart
> - * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -714,7 +713,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
>  	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
>  	 * It is not a guilty queue, restore cache_rptr and continue execution.
>  	 */
> -	if (guilty)
> +	if (adev->sdma.instance[i].gfx_guilty)
>  		rwptr = ring->wptr;
>  	else
>  		rwptr = ring->cached_rptr;
> @@ -779,12 +778,11 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, b
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
>   * @restore: boolean to say restore needed or not
> - * @guilty: boolean indicating whether this queue is the guilty one (caused the timeout/error)
>   *
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore, bool guilty)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -803,7 +801,7 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i,
>  	/* For the guilty queue, set RPTR to the current wptr to skip bad commands,
>  	 * It is not a guilty queue, restore cache_rptr and continue execution.
>  	 */
> -	if (guilty)
> +	if (adev->sdma.instance[i].page_guilty)
>  		rwptr = ring->wptr;
>  	else
>  		rwptr = ring->cached_rptr;
> @@ -989,9 +987,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		uint32_t temp;
>  
>  		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -		sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_guilty);
> +		sdma_v4_4_2_gfx_resume(adev, i, restore);
>  		if (adev->sdma.has_page_queue)
> -			sdma_v4_4_2_page_resume(adev, i, restore, adev->sdma.page_guilty);
> +			sdma_v4_4_2_page_resume(adev, i, restore);
>  
>  		/* set utc l1 enable flag always to 1 */
>  		temp = RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1446,6 +1444,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
>  		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
> +		/* Initialize guilty flags for GFX and PAGE queues */
> +		adev->sdma.instance[i].gfx_guilty = false;
> +		adev->sdma.instance[i].page_guilty = false;
> +
>  		ring = &adev->sdma.instance[i].ring;
>  		ring->ring_obj = NULL;
>  		ring->use_doorbell = true;
> @@ -1507,9 +1509,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
> -	/* Initialize guilty flags for GFX and PAGE queues */
> -	adev->sdma.gfx_guilty = false;
> -	adev->sdma.page_guilty = false;
>  
>  	return r;
>  }
> @@ -1686,9 +1685,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
>  		return -EINVAL;
>  
>  	/* Check if this queue is the guilty one */
> -	adev->sdma.gfx_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> +	adev->sdma.instance[instance_id].gfx_guilty =
> +		sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
>  	if (adev->sdma.has_page_queue)
> -		adev->sdma.page_guilty = sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> +		adev->sdma.instance[instance_id].page_guilty =
> +			sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>  
>  	/* Cache the rptr before reset, after the reset,
>  	* all of the registers will be reset to 0

