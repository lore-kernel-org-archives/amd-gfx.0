Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C0EC5320E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 11:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A586D10E229;
	Mon, 19 Aug 2024 11:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmbktMm7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AFA10E240
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 11:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auNJykKc56EvYz0ES+3QvmWQEZK/hYBK7Ms7vNCuWb0MQP3NGj2/Kx+LHwQ6H1DTA1T/5wZlOusQ9d5v42k0aVnSGWNRIG3T6sYptNVKKItF/ycyt50IswkNHVJ7Bh0714JWKd1S1Z816DjeDWVUSCnB1ijB0vVXJhNsZ3YZqq8aF8e1JsbFQRz1+S7/VBP7HyXEyYINMzAW88VrzVdmPe+53bfGixI72T9Cq1tl/S1OPvkHRmNi2JrMr1XD1pQmAjaBD0qxRRX1qRCcSvl06aEp69k9VM0gWRQcwZNYOU090ylE1MsV7knKR47YndVZvYEFgnSxJ5CWI2mpijFWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6FK80qbAvmRu40H2xy10CMqnq8EOsdZ70TSMtxkXHI=;
 b=mNAf65tQwegou8a5SSly3c06XA5mc+NQ86bYVm6F03NQSJWKYQk1/gnTBN6Xf0lwG9D4Au1jIWHg9o6Ifhn7rtH890FDpeD6WJMo53K5Yew1eDrM0avTjY/6KeRjIisqa0SI/Emg59cIcVZaq+yG5QNJX0bq1k30XO049hnRZSw9W0at1cACGc46FjLP1OdspBfBkIKHcxi3J3E3PmeWMS+PVe7FgXJ1dmW6eJedVhuUMLaik4trMh0qL/mCN4mGMwS/t4KCDoV4u0rZQ8gK6DDiRjF3WEFI7/1cJabMNQclfbAkgEA1KJyTiZtwLK9/uQiK3dQt0/yBokM2uRZFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6FK80qbAvmRu40H2xy10CMqnq8EOsdZ70TSMtxkXHI=;
 b=QmbktMm70VOcq8b7Ca9S8+PzATWEmHmICoukkjf2vqexkPxd2si0+xT5QyouWL95Qm5shsn727krSTyjbAbgI5x3qE0iJjW044c4p/fUL6DO0gcNVJkavt28ZiC6UWaP/xnKjsXw+nTNaSnOnxlL7NgvngaaUGCWtY2iVLaIHVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 11:14:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:14:27 +0000
Message-ID: <e78b05f6-bc6b-47c5-8cb3-9bb6cc6f3017@amd.com>
Date: Mon, 19 Aug 2024 13:14:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: command submission parser for JPEG
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com
References: <20240806160012.234633-1-David.Wu3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240806160012.234633-1-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fabea03-9c22-4df9-fe26-08dcc040169d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmc0ZmpYZ1hvKzlaWVAwWHJzZ3EzTXJoODlIT3BDOHAyQzZLODFiRVJmM2k0?=
 =?utf-8?B?bWJ5amhjb2g5eW1rYlZ6bmdDWkJ3MWc2d0k4UThRSDZCUXBiaDNRR09McjdZ?=
 =?utf-8?B?c0NZcVpzTnNDQkVtK1BJL1VwT2ZBek92bWQxZlpON083TzlzOTVBT3JHNE5T?=
 =?utf-8?B?alJkYmNxUG11WnZGYTNSRUgyNklEYXA0ZHZpYTZDSnJ0UGVQY1o4TFhWYldP?=
 =?utf-8?B?SG90cEphK0dobkcrbDlpTFNnd3llOFo4ajVKc1VFWlZaTThreUJGaHI2dHdX?=
 =?utf-8?B?UFFESy80bkpiWDlUOUtYTVlxS09MUU5DZk9zUkVvQUk2YWJmR3c5UjJ5M0Qx?=
 =?utf-8?B?VllkdGRUVjYveFlEV0VZQ1lXZElRL2p5WFJCT0NKb0F6Yjl5NmpJVUVzdXFL?=
 =?utf-8?B?dWxRaTVzTXdKOFZZdUYzOVJrZ2NOVEpDazg0MjFqQ3NlZVRBOTJCUERUdE00?=
 =?utf-8?B?NTBOTENIeGlyeXJma3pHQzJFd0swUTV4d0FWYy9BYUdxWEhVSHRmdlJhQ2pI?=
 =?utf-8?B?UVpaZ29jQjRUMTlUb2JZOWtJK1VqVmpCZ1FTYmFSZjJCbHY3Y3VLOTFmbWlQ?=
 =?utf-8?B?Q3lNZ0ZUeDVCL2ppNjI3dFJOdUUvc29sS1dXMjRhRlZwRXBYV2JlY0dZZkYw?=
 =?utf-8?B?T0JSaDZqdWwvNlRCNWYwT3lHemJJVytNczZpZWFTTnNxekwrMXI4WTdDRjh1?=
 =?utf-8?B?QUlNbFBnUlEvUkRkc1hYMjNWNXFuZ0xReFV0aFdSRkx0SlVaUE1teStEMEpE?=
 =?utf-8?B?NXFraVI5M1I4M2h6VUVsSlg5OXZHbitSdUYrcXRRRCt3Z283cUdxcWNYNG53?=
 =?utf-8?B?K3M4aUk2N2tmNnBNQ3IzZE5JbVVvaXpRN0VkWHBaY0JzT09LdmsyV3laNzRj?=
 =?utf-8?B?L3VWbWhtTHUwR0oydm1xWUtnV21GTi81OEJucytaZUN6VFh5MVNZVGZSK01u?=
 =?utf-8?B?NGs0ejVYLzhOZlg2UG95WEdCR2dkRS9rSjhBMGhzSmliQU5sUndjbjJSbHJ3?=
 =?utf-8?B?K3l3TnhqMGhvdkF0c3cxQThRY3NVRXdOYlhYSlBoZXd2Y0FoSy9DV1A0Q3h3?=
 =?utf-8?B?L2pTd2VVVjFjMG80QS9CbkxHeWU2YmVGUm9KV0RZM3prL3pXUFdrQ2ZDMktl?=
 =?utf-8?B?eGFYdkwvaENQb3AvRERlbGpXTTVkc2ZHYndWRWFEMDZLRWc0L0JvQVpicTJJ?=
 =?utf-8?B?K3BaVjhnRkNBNFhEcXoyMGs2R1F4aFRHR0Q1L3k2a0tsRzFhQzBSMVBocG85?=
 =?utf-8?B?TGhPZndKZkxVU0c5cWFKRUh4Tk5qakF1U2phTXp1cXFtN1RtQWhjYTRMVjRO?=
 =?utf-8?B?Q3czQUprT3ZSUkNNcTBDL3F3OVFGQldKdWJ2NGZpRDdCcERIMHV4SUNhcWVV?=
 =?utf-8?B?L1JrVnlBUHE2enpzdGc0SEY5M2NVeUFBellYVFFvdmpCRldubWdBeXUxYnFV?=
 =?utf-8?B?MlJiTS8yY2pqNmltTUFMRVEwZFgxNjFqMmFBS3ZtbU13TkJSNjhDMmozR29W?=
 =?utf-8?B?RDlxeVpsOWQ5OVBQY3lNMFEyd3VheDQwblJ6SkRFQlJscXk4QUxyU1N5S1NU?=
 =?utf-8?B?aEpUSFVScHBtTDk2RHFMUE9HTHNYaTY3YTJFV3dja2NGL3pxUHdvUGNQOHRG?=
 =?utf-8?B?VGhLdUF0eGtKMC9INzRsYytlbXowZXEram5tYStCc1VwbGRFOXhIaWQ2VVh1?=
 =?utf-8?B?cFR2S0ExSDFXTnNsQUlnZFUwdzNTVEl3UzByeWdJT2c2Z3c4cWFxb01rRGZi?=
 =?utf-8?B?YVcyWVRzUlpEUU01VHlJdnZHYWVUTXR3OU9ITVRWVG1ZY2JWcVE4bDJFSlpn?=
 =?utf-8?B?UzFXbTZVeFh2VjY5TXR6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?empSYXZaT3lQZ0hWWlJYMVJkT2lvNUdSMWNuaCsrRDJ4ak1BL1Z4WEExOU5P?=
 =?utf-8?B?SkpmZ09tV0VOQUx2Z2lvK2ZGb01sM2hJMFZPYWVtbnhrakhnbnVaN1F3RSsw?=
 =?utf-8?B?UjA1Y2VBRTJsWnVBcTdqT1RGNi9PVlM3dlYzOXpZa2l6c1VEcVc3bFlpeEdV?=
 =?utf-8?B?RHFLVVdnMVJVQnFxMTFnYnVUSzdJbDlWc08rMjdPM3pJN09Dc2lpQTZEU1lx?=
 =?utf-8?B?ODVUUWU3djN0b3hFVkduNmloYnZoV21MWjhBWGcwRktWc1B2SVhHQWVESmhq?=
 =?utf-8?B?djBoZ2JBNWVLdGVFdG52NFpLbVFVWmFtdjNNbUwvb0pGNnR2TTZtOGlHbE5F?=
 =?utf-8?B?Q3ZMVDU1WHgxQlRsR0ZzZUtjelpZUEFIbkpGL3JOTjlLK2Y0V3FIMlFrclhM?=
 =?utf-8?B?QVNnYlppNlpGOU1IQzJCd0NzcWtJSmhFVi9CMGVCRUZZQkpWdjd2YndqMHQy?=
 =?utf-8?B?Wmw0V3I4cllDY3N3V3EwWDVaaDJqRUh0RFhYTFY5MXNRd0w1UU9wUGZTMDBF?=
 =?utf-8?B?TlJ2MDFwakpEYi9ocXB3TmRLZEpZbW5YbFFvVmtMQUpUakVEL0RGN015dFNS?=
 =?utf-8?B?T3Z3clRSMXF6ZE1vb21HTHBiSmNSM3hJWVRFTEZ1cUFIaU9GbENhanlUd2U3?=
 =?utf-8?B?a1R3MDVkRmZEeGZGV0RqNUZ6dng3Smo1Nm9kamg3SHRTaGliQkJ0K3V3YUlx?=
 =?utf-8?B?K1I3WjV2amdYVXR5WXd5OGk2Rk5YOTJyNFVBend0M1JpRkcxRWRWaUJzOVAy?=
 =?utf-8?B?ekl4K3RCdnFlYkpMOHArK2lnb0xvVVZtNUl5eVVBRDEzNkp6U3p3em10QVF2?=
 =?utf-8?B?SEdrYU5aMTU1ZHpGcHBSUFk2U1JmMGViUFlCUHZpRFNkdlIrR0hNeHNycmVU?=
 =?utf-8?B?OG80WEhRZm4zNzFKN25UaXFqTVJYMUpZUzVuQm9Za1VqWm5jRG85V1NUK0xt?=
 =?utf-8?B?aXN1T1Y3RjByUi8rR1ZDV0Z6ci9qZ0xOSlEwOHc0dWwxS2U5M2hFdjRFa2d0?=
 =?utf-8?B?WSs0T1VzMm9KbDBBUHQ4TlVVeGJpZDNianZmOCt3OGJLandSMmk4Q2VocUpO?=
 =?utf-8?B?cjc5QVJlbFhNd2FXOTVGQUlyT1lENUpROFBMZ3lBaG5iZkhka1pwUXNmbFFi?=
 =?utf-8?B?eXcraGNVWHlzSGRmaDlqaDRmcWZsWUZnR1U3VXlxMlRjVzlKS2JLQWpFT2hW?=
 =?utf-8?B?bXBON0VWOEc2NHZIZHIzK3MydmNlSDc0SXIwNk5pUCs5YXNVWlN0SzgrL3Bi?=
 =?utf-8?B?SU52OEVUSCtYOGZINmdmMGFldURUWEdtNzh6a0NBUm9LSVR5MzZhcFFTY1ZE?=
 =?utf-8?B?SDF3WEhDUlJneS8zZ3NadndyRm41RVV1L0hEa282QmdEbnZlSW1ybDVGa0Er?=
 =?utf-8?B?T1lYdnJ6QkdudU9OalFERDR3aHF0SVVweERkT3crYkxscG1PanZTcDFKS2U4?=
 =?utf-8?B?M1dCaWFxNG9oK0kwc1F2WFF5b21QNTVza2tPQlc1NzlSMzRkSFNJU3VROG9I?=
 =?utf-8?B?a2VrWHBkS1pOZ1VBK3pZYXRPaU5MWG40NS9oRGVRYnBIa0h1VWpKbldJYmdh?=
 =?utf-8?B?eitGUzdJbzdFdW9UUWxqenUyUERQNWt5cFhobzAvT1NVQ3RVb0RPQnptcUtP?=
 =?utf-8?B?dGozMkF5RkZMQWlsK0tDMWZIUDE0TDdOaUpYTGRDUWVjWjlVVld3elZFb1Yr?=
 =?utf-8?B?M29POTFndkdsenFsWUdQWFc1L05pRHBEMStjUHh4Lys2VlF0VHRBcjQ4WCtW?=
 =?utf-8?B?UVBTOTRod2p6ZUF2L3d1Z3NDam5zd0FMdi82azI4L09IdWlHMXpzQ1crbzVh?=
 =?utf-8?B?L2tjRXJndC8zdzJ5YlRHbmt5YXhEVW9lWlYxTVN0YVNLcm40YktFSkowR21E?=
 =?utf-8?B?aXRJTkZhc1VCbmV0bHRqWVFOQVg4WVh1ZVJOTDZsbCtyOTJ3bk1mdUJXTTBv?=
 =?utf-8?B?ZE5TNWpLeWw1YVRIbFpqQU5NeUMxc2wxTEswN2VXTVc5UjJhekJlZlpEbXVJ?=
 =?utf-8?B?cEZlM2FIUUtJMHU2TEM1M2dTNlVLdkI4cEN6S2h2NHA0S255V1IyRkp1L3Uz?=
 =?utf-8?B?bFlSdStQaUVlRlUxaG8zWFZJYUZUcWZSeWxLdmcxR3IyOUdmaXVIK0VQRk5q?=
 =?utf-8?Q?um/g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fabea03-9c22-4df9-fe26-08dcc040169d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 11:14:27.0726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYaILUdXPs/Tyk7uSLdr0gML57fOtG2L0YbL7+JmpWpKrb5j7feqrsXlHB7Fsr4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

Am 06.08.24 um 18:00 schrieb David (Ming Qiang) Wu:
> Add JPEG IB command parser to ensure registers
> in the command are within the JPEG IP block.

You should probably re-order the patches so that the cleanup comes first 
and then the new functionality.

Apart from that looks good to me.

Regards,
Christian.

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 ++
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 58 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h |  7 ++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/soc15d.h      |  6 +++
>   5 files changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 1e167d925b64..78b3c067fea7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1061,6 +1061,9 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>   			r = amdgpu_ring_parse_cs(ring, p, job, ib);
>   			if (r)
>   				return r;
> +
> +			if (ib->sa_bo)
> +				ib->gpu_addr =  amdgpu_sa_bo_gpu_addr(ib->sa_bo);
>   		} else {
>   			ib->ptr = (uint32_t *)kptr;
>   			r = amdgpu_ring_patch_cs_in_place(ring, p, job, ib);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index ad524ddc9760..6ccf61d7c13d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -782,7 +782,11 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
>   
>   	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET,
>   		0, 0, PACKETJ_TYPE0));
> -	amdgpu_ring_write(ring, (vmid | (vmid << 4)));
> +
> +	if (ring->funcs->parse_cs)
> +		amdgpu_ring_write(ring, 0);
> +	else
> +		amdgpu_ring_write(ring, (vmid | (vmid << 4)));
>   
>   	amdgpu_ring_write(ring, PACKETJ(regUVD_LMI_JPEG_VMID_INTERNAL_OFFSET,
>   		0, 0, PACKETJ_TYPE0));
> @@ -1084,6 +1088,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
>   	.get_rptr = jpeg_v4_0_3_dec_ring_get_rptr,
>   	.get_wptr = jpeg_v4_0_3_dec_ring_get_wptr,
>   	.set_wptr = jpeg_v4_0_3_dec_ring_set_wptr,
> +	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
>   	.emit_frame_size =
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
> @@ -1248,3 +1253,54 @@ static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
>   {
>   	adev->jpeg.ras = &jpeg_v4_0_3_ras;
>   }
> +
> +/**
> + * jpeg_v4_0_3_dec_ring_parse_cs - command submission parser
> + *
> + * @parser: Command submission parser context
> + * @job: the job to parse
> + * @ib: the IB to parse
> + *
> + * Parse the command stream, return -EINVAL for invalid packet
> + * 0 otherwise
> + */
> +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> +			     struct amdgpu_job *job,
> +			     struct amdgpu_ib *ib)
> +{
> +	uint32_t i, reg, res, cond, type;
> +
> +	for (i = 0; i < ib->length_dw ; i += 2) {
> +		reg  = CP_PACKETJ_GET_REG(ib->ptr[i]);
> +		res  = CP_PACKETJ_GET_RES(ib->ptr[i]);
> +		cond = CP_PACKETJ_GET_COND(ib->ptr[i]);
> +		type = CP_PACKETJ_GET_TYPE(ib->ptr[i]);
> +
> +		if(res) /* only support 0 at the moment */
> +			return -EINVAL;
> +
> +		switch (type) {
> +		case PACKETJ_TYPE0:
> +			if (cond != PACKETJ_CONDITION_CHECK0 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> +				DRM_ERROR("Invalid packet [0x%08x]!\n", ib->ptr[i]);
> +				return -EINVAL;
> +			}
> +			break;
> +		case PACKETJ_TYPE3:
> +			if (cond != PACKETJ_CONDITION_CHECK3 || reg < JPEG_REG_RANGE_START || reg > JPEG_REG_RANGE_END) {
> +				DRM_ERROR("Invalid packet [0x%08x]!\n", ib->ptr[i]);
> +				return -EINVAL;
> +			}
> +			break;
> +		case PACKETJ_TYPE6:
> +			if (ib->ptr[i] == CP_PACKETJ_NOP)
> +				continue;
> +			return -EINVAL;
> +		default:
> +			DRM_ERROR("Unknown packet type %d !\n", type);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> index 747a3e5f6856..71c54b294e15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.h
> @@ -46,6 +46,9 @@
>   
>   #define JRBC_DEC_EXTERNAL_REG_WRITE_ADDR				0x18000
>   
> +#define JPEG_REG_RANGE_START						0x4000
> +#define JPEG_REG_RANGE_END						0x41c2
> +
>   extern const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block;
>   
>   void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
> @@ -62,5 +65,7 @@ void jpeg_v4_0_3_dec_ring_insert_end(struct amdgpu_ring *ring);
>   void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
>   void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>   					uint32_t val, uint32_t mask);
> -
> +int jpeg_v4_0_3_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
> +				  struct amdgpu_job *job,
> +				  struct amdgpu_ib *ib);
>   #endif /* __JPEG_V4_0_3_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index d694a276498a..f4daff90c770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -646,6 +646,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
>   	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
>   	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
>   	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
> +	.parse_cs = jpeg_v4_0_3_dec_ring_parse_cs,
>   	.emit_frame_size =
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 2357ff39323f..e74e1983da53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -76,6 +76,12 @@
>   			 ((cond & 0xF) << 24) |				\
>   			 ((type & 0xF) << 28))
>   
> +#define CP_PACKETJ_NOP		0x60000000
> +#define CP_PACKETJ_GET_REG(x)  ((x) & 0x3FFFF)
> +#define CP_PACKETJ_GET_RES(x)  (((x) >> 18) & 0x3F)
> +#define CP_PACKETJ_GET_COND(x) (((x) >> 24) & 0xF)
> +#define CP_PACKETJ_GET_TYPE(x) (((x) >> 28) & 0xF)
> +
>   /* Packet 3 types */
>   #define	PACKET3_NOP					0x10
>   #define	PACKET3_SET_BASE				0x11

