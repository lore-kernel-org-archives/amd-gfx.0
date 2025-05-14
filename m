Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17733C3ABD9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 07:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB3810E1B6;
	Wed, 14 May 2025 07:02:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47IpoQR/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183D110E1B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 07:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCDUmdBrroEsZm23UWJxS6UpHSv71wHH7IdCeZjqxcN9o4Y7tfTrlL3GeUZ7TWddobQ5tdjpG5cFdsPFlsRcEUeFKgIjQK2ixaVeMieTeWDVXagjVK4v0XMGX6zW94P4CQGTS1aI103JA3B3wVTR/ngse9ISs/S5DFssLwZT/7HBi0j5Rwa0ca4ktk1PvMJZcFk4nDlC5w19hySIsekX9+ImDJY0pb4cq1f2bIwFFvq7j9sE3kOXYyLZDD+5I9yVmHttCw7x4yoXvs+hmRWsCci2Y4CQTik+p0ee2XfVMbbYwS4V08dsvKBzx8iuwih9zBSU7BXs6dt++WOJdahD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ex623dSZZ0Pe22xbjf+pBY95y5rFiors0JgXOhk4OrA=;
 b=fvivLKCObawTFozv/7OU1LQfiC05zAZWxqBs4FG7/JHOluFpMp7sel0CwDwYMfKeQR1XJLRkGG7IDIP65eXW/Uk06ZXtBexljiNx1Z3jCS631kjDW04MuhmRgrE1xhhkMDcwjo2yx4qM0gewZjZfaMHl68+wD8eh7WFUPAwW6INc1MiISp+SHJd4RUM1BezaLToVg5c73iRW/o92EM1vU+tpU6lMZwc7XqYVyhK26F6o/cHhSV38nrWs7y8lKWXbaFf1ja1hV8NYJQ+rR57sju5+xfgqt3iFSr2iq0U2deyricndH87b+LqqjkD2B27Tkna8F7htrjJSC9OZgBlJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ex623dSZZ0Pe22xbjf+pBY95y5rFiors0JgXOhk4OrA=;
 b=47IpoQR/oahewr8r2KyC8M0JC1CyTcoao/oBDQTER8Z2TbXLjpPvPK+gOMSiOY4FrtYEepELe4r1M98S8cOaf4EeoLDNFCPyJnvTb30wB0mRKsxToETHWIJ18DlmOxMuTBep8hBdzLDT8CMQstPOzIexFgvncEXJ9PxS+1IAdls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 14 May
 2025 07:02:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:02:18 +0000
Message-ID: <afa44c90-2e7b-4fef-9a64-b869980d39b7@amd.com>
Date: Wed, 14 May 2025 09:02:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix userq resource double freed
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250512073002.401719-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250512073002.401719-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c0ccdc-3ac4-4dc7-e833-08dd92b5438d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjMrN3Izclpwa29reFNsaVRoWUNoMWpVbkhpTzRsMXZVSnVpdmw3S2FLQUZL?=
 =?utf-8?B?SklUL3V0bmo4bHVTcGN1NXoxUjQva21WMTVCeVVGa0c1bzhsRVNhb0JIT1dk?=
 =?utf-8?B?bERSaGRCNDA1QW1SMTd4cTBwUTlmK0RkY3AzeHQvTDJBTHplYXRoMmFDR3pQ?=
 =?utf-8?B?NTZ4dndjYldJcjhzbnN0S0VSc0Y2cmJzbkE2SXBEMFo4NVBiQXZEcHBwbkZ0?=
 =?utf-8?B?YlZUTmJJdStITmxOK2xub05uY1M3V2RTTmc5Qm9SemFXMWFhRjBjbDdWeGs3?=
 =?utf-8?B?cFo4Q0tzbFM3OE5nLzVLQ0FaVVQ2VGJWbTJRYzk3VG9ia1RSTVF0QnJ4WEEv?=
 =?utf-8?B?eDdyQkhMOGpvUXNkSjJwRnh0VmhnYU5XTUU5a01oVWZwNkJGTFREM3VMdDAz?=
 =?utf-8?B?bDdVNnNYWWVNWXFVWDdhSWVzKzhEMnZKdnF1dTRDSjdBcEdIeVdvbyt1WVlF?=
 =?utf-8?B?KzFRK2lMYUUwaStiUGo1N3h5OXd3U3NBNExlTWhuVCtEQ1ZBR2E2dlhuZmJx?=
 =?utf-8?B?WVd4cXh3L28wT29COUg0N2ZUWkJYWWJJUFFneWNzbDNpdnNraFZlNTB3VG1l?=
 =?utf-8?B?NGVBZUhDTXpyR3BvNHFqLzV4S2hnMU16enM3UlhJWFRKSTZ0QWh5WnBNUEZw?=
 =?utf-8?B?aE5pRDhTb0dya3RVbTNFR1B3R1BSUkNmeUo1UWpyNVZqOTFFNWVWTG9XSGhJ?=
 =?utf-8?B?aUprSi9peElPNFBqb1Yzekp2K2pNU3dNS3RJN1BMclhuU3N2SFBJWDcxYVNu?=
 =?utf-8?B?eGVxSWVYTStEQ0hQVkh4MWRNR21La0tsR2d6VU9tbU1pRTB5SDBaSnB2QjJ4?=
 =?utf-8?B?N29qSU5lUjNFbjVwSTc1Z3R0VEk1L3B1QzdVYkNWcVhPbGVCMkRRRDd5QjNM?=
 =?utf-8?B?K1lOeVQ4V2NKemVubEN6UzlTZnFNQ1cxcFlSeWp0S1JDekdpZXZva1RaUHFV?=
 =?utf-8?B?OUNvdmExRlkwWmRQV0NHNmtnREh0bHc2NlJBVXRIMUdhN21wSnBYWUxWQ2VR?=
 =?utf-8?B?MkRXRXF3NFd5R0E5VC96Y2VkNnNwcEVTQ0tlZmVzWGZUZlpRWng0Y3g0Mk90?=
 =?utf-8?B?NzUxUnFGQzJ0SDVjazRLLzJJa2srRDg3UjdvNTZKSEgrSEdrVjZLemlZWnhk?=
 =?utf-8?B?YWx1Yll6ekJmYkwrRWpWcC9Oa0dzQUpuQ2l6QWpVZkJYek45ZjR6YVVwckdT?=
 =?utf-8?B?a25LSHVkbUNTRlZTckhUaEQ4Ti9idWFtU0ZUUFk4ZFhidk5JY0t3UER3bkoy?=
 =?utf-8?B?UWxvZ0RxbGp2cnZnTCsvRkllZ0pmVlJuc0o3cnhZNFhVemZMV2ZuWE90ajhQ?=
 =?utf-8?B?TEpqYjh5RERFbGJoQUhkUW5BYklYMFZnbXZIYVczZUlZd2IraUxtN0EzdzF6?=
 =?utf-8?B?UThHWVFJbUZXd3ZPT2QyVmlSYmRjUU1kUFlKMXZCMk90UFBXa0FYcEc5UHRL?=
 =?utf-8?B?R29nNmU0Y1VwUXRBYWdsa3VlUFh2OExhaUFmTy9jWXpDT21qbDJGR0hNTG0y?=
 =?utf-8?B?N1hpSUlXay81Y3ZMb1Z0M25RVXgxQTgrbkpaMURHNWN6blhXSGJKQzZpenBH?=
 =?utf-8?B?WXo5K0Y0bmJhbnI2ejU2T2hWRXBHRllTWGZwL3NPbXdtT25FM0Z3VFBRTDZ6?=
 =?utf-8?B?UWhqSy9pcmFOVER4dTVaN1V0eVRsTVRZVFJGaFptczBhblpIZ3REWXV4Mjda?=
 =?utf-8?B?QUZNVlVta0RNd0ErZFBlUmkxZGhUOEV0Rm1rQjV3bkpnbXRmMXJJb1VOSURB?=
 =?utf-8?B?OTBZYWR2a21uU1JkZGptWXRHTkhHWm5LSzNqOUlodmgvTzc2b1hXMUJtSHd4?=
 =?utf-8?B?OW1qTmtqUUVLeStsU3I4RlcvSVhkQlR0K1NHNXQ2MkVoUy9HKzlpT2h2N21o?=
 =?utf-8?B?NW9zRG9vc2NDRDlneURYdWR5blg5M1dnQ0hydXlDbmF1dGlDdWdMTzM2Tm5L?=
 =?utf-8?Q?mrpoB3CpPiY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW40eDdtVE9uRDNESjJSUXZGMEd3bGx3cVJHWE1iYzFKMVJkMUF0a01OVVdS?=
 =?utf-8?B?SWUxN1A2SlduenNMTmlOS3grd1hvemZKYTQ5eTc0VXBxN1cvNXYzMjBLQ2pX?=
 =?utf-8?B?UkxndlcrRml2VW8xa2JKRzFsUDM3ZDBYLzBrMzVhZXAvWTlPcC81aEV6V1VV?=
 =?utf-8?B?NDhhRTBPRm12NzlNcmluTFJTTG5OSlVjTEZFS1FHTElnaVlXb1lHTDF5L1JY?=
 =?utf-8?B?eEg5ZlJHOWVLejFKR0lhSGRWV0srTVVmaGV3dndTelJFMEFHaFd4YWZ2cWJh?=
 =?utf-8?B?ZUpPMjlGb2FTTnlld2lSQ3R2RUM3SzFYRVhKWmxkNmdldHh3bTRjRDl6TGRP?=
 =?utf-8?B?L25lUHJRTHZxc0d4OCs3N1RtMHZORnpEZlRhRzZmNUZ2T21KZi9FZzhxSm9U?=
 =?utf-8?B?ZnhXdlhFUURpWjI1aHNpcVdwOXdVQktPS3c3ZkpuaTBXMDdVR0VCckwrVDJN?=
 =?utf-8?B?b3VVZStQaFp0WHVFVFlkNk5sUG5Lc1hxQnBUckRkQjczSWxRa3FCeEYwV05Z?=
 =?utf-8?B?djZnMEFjRGFBWmFxSWwzcEFUVVZmSE9uTEo0WDgzem5IQ1dlKzBscEpDYTFq?=
 =?utf-8?B?bUs0Mk05MkhFYzFtaTR4Qk5zMUUyRVh6RTRjRCtIbmxZV1VPRmJaSDI4OWVI?=
 =?utf-8?B?UVZaT3FaN0VFYzZkUlE5NXZackVrZUF1VElMS2EyczdwYW83dHJXYkZjZ2NF?=
 =?utf-8?B?Yy9TMG1yRmE4bjFjdHlldjFwQ3BIMjhDN1pyZEhqUHhFNkNPMSt4YzdXMEZ6?=
 =?utf-8?B?c2FZcVlhSXJVZTlWOTEwR1JadU1PendrTmI0MWc3a1dydVhrZGhxL1VVTXE2?=
 =?utf-8?B?dm5yRkVsMkVESW83Z3o0UmZvOTBvRFllM3pjbFluTElvQ1NLdGcwTDFwWk1m?=
 =?utf-8?B?M2Y3SE15WWhzVDU3QUFNM3lDRit3UXJOQVFiNytNMy9aK3libFJuWVNRMlhY?=
 =?utf-8?B?VHhMOGtWUnpCdVR5QkZZV1RDN3ZNSCtQakU0SEpBYVY0VWZQa2E2eUNLd0li?=
 =?utf-8?B?WVZVdDdVZnN2amtqa1V3aGJ3OGkzMVBCVDVkbGdOUmh3SVU1SSt3ZzA4Vk12?=
 =?utf-8?B?bFZETDA5Ulk5QWtQdk54RzZHaW5VMEdKVmNpTU10QmdWN3BGclF5a0MxbzE0?=
 =?utf-8?B?dUxzM2VpWkpmelVQVlBzeHdaR1VZamlwajhqRDY5VWFQOWFDamMwbngxdS9O?=
 =?utf-8?B?dFFybjVaUnRoSUhVbThhWE0xYVp5VTZ0RlpFTHQwK1hIWjhpSkxic05WQytX?=
 =?utf-8?B?UEF5TlZCTTFQckpERFExK1Z1OVJmUXJnQWNJSGtaZU5JUGwxWGRjaW16dGRR?=
 =?utf-8?B?ZnJveWhFUERiUmNhV2VGSU9sL1RCeGt5a2p6OU5oT1I4Sjd6RUZZTHBPem14?=
 =?utf-8?B?NTl1TndFeE80cTVJb0VwYzRYNGtIV25pYWhsSm02VWtiMzhTRlF5SThPMitp?=
 =?utf-8?B?SGNTSzNFN1puOVorbUNtVkxKSjRKRWtaKzVlTi9sWlFodjJsWStOVHVZWUxW?=
 =?utf-8?B?Sm5qRFRpQjhLQ0lGUzI1Qng0a3ptalFrMlJTcVZMazQ0cDlmTTd1dUh2c0dG?=
 =?utf-8?B?aEhUV0JCcEZLODFZdm0waXJ4d1JDZUkxU1RFYnpnNDYzQjBMeHNYbm5qZnZi?=
 =?utf-8?B?UlpCOTNsYk9oRkhHWWxjT1BYeTYyS3dvaFl2ZlYvdnRSNEtsNFJ1MnhzY1F1?=
 =?utf-8?B?MitjTjV6cFRicVc0LzRyZjlwR3NZb09rdnRTQmdrOGN1WU9MZXBYWkhPODMv?=
 =?utf-8?B?alpSakl5aVVkUENIeklrQzkzS0RIZHlMU1BaZG9BeUFWbGpVazhBaXJEREdp?=
 =?utf-8?B?ZzJjSTd6aENaK3U4aE1QSW9LL3QwV2Mxc09CS1lKME40NFc0eGFCdlc5MC83?=
 =?utf-8?B?cHgzMFY1OXA4L0JsNWJEVVpQeXVhUjJERURBZHA0S2JOaVFsanE4ZzhtZUc2?=
 =?utf-8?B?L2hvZ3duYURWMTdqdzl0czdFWGF6VlI5eUJrcGtPVGtpUVhxSjlzSG1hU0hV?=
 =?utf-8?B?Z0lqQ09JMzArMU05Q3p2RE1EMXB0aDBqWEYrTVo4RC85WHJkK0U0NE5yRjhz?=
 =?utf-8?B?MXQ0dmcxRnpaTExUemgwWnZzN0loVDVkaHl2Y0psVjJIWG95S2NXQVd6TXA0?=
 =?utf-8?Q?LkVw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c0ccdc-3ac4-4dc7-e833-08dd92b5438d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:02:17.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsXsYAGC4MIL2ubz6BhRGjLO3g7FgOi0or0qgLG5osTf4VY3JAp+KFdxKVZTschP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
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

On 5/12/25 09:30, Prike Liang wrote:
> As the userq resource was already freed at the drm_release
> early phase, it should avoid freeing userq resource again
> at the later kms postclose callback.

Clear NAK. You are just hiding a bug.

The userq resources should always be only cleaned up here and that function can't be called twice.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8d4a2aed7231..cf0f35a7daee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1502,10 +1502,11 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  		amdgpu_bo_unreserve(pd);
>  	}
>  
> -	fpriv->evf_mgr.fd_closing = true;
> -	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> -	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> -
> +	if (!fpriv->evf_mgr.fd_closing) {
> +		fpriv->evf_mgr.fd_closing = true;
> +		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
> +		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
> +	}
>  	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>  	amdgpu_vm_fini(adev, &fpriv->vm);
>  

