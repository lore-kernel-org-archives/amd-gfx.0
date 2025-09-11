Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC7ECAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C248210E383;
	Thu, 11 Sep 2025 14:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vi2BPRcn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D74910E36B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldcL2g/jSQH6uC+atob3Q4k52cWdCcybIyTOgP1fHn4munWrSkVT8h2s43QR2oyBUb/IvNqzW1oDHxY3N6G+ZP/JREq8xkk5VkjAamYNaYd470ykD0pNdt13d4ybpCS3dC9dfCbTv3jMTWqnwyHTLXTlGUNsLcqhKRiUkiyWss+oiVxhG3LDWdMc3HXc9q37q1vKlKpwawchU7wT5jQhXBnqtpDmlNOky8WAebgkVLMB/P9ixmWVI2BeteuViC2GpA+AhLVQYyYjd+0+77jfeM+wHxLLJEJ95lMrLqQO8gSs2WRgZZlVmPIfEwtGNUcQ47H/blHU5WR47w//jkLEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAuTqf00EVeXIBWzCI8/LA8lY5DfWQZB87pgjLT+Tz8=;
 b=E5bsdc/bZW8lrSKxMFMIte6YIeeErziZbGbn6FWDU+1k1JzdWgEgsXz6XuRge2YtaoVQcnJFYdmHEwPOLHcOQmCpm2CkruaN+6skk1rPiV+VcUHHf4OFmU+f3pF5XxedUI06Zb3dBGo7IF9WtJj3ehHS14ZC7GegtMBgFvrGoF76cXFD/DYLl5Z5RMSY342i+molee1Sq3N5JJA0JoPJWM7RuSYstSdh1KzDDWaCTiCKDTRDuU+vtdyHxOScsmSaGx/O74SFarpNWsHEvGdez5tZEGc9GenU9lc4sRkdiKRrYwTFR5NI48gmb9q9lZ2sSuH7G4svfWP8x/MifKPnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAuTqf00EVeXIBWzCI8/LA8lY5DfWQZB87pgjLT+Tz8=;
 b=Vi2BPRcnCa5Fu5wIkivBPFEFGVtmQK2C+RkAcCHiTFYoWk4kLCpsu2mrw1fFz150n21lpEbPU5e55UOt88jW1SWp1Q79Hr9oBRRsfCPkHlBgqYi6Dh7ZLiWCKOXqYfMfIo/JmAQ6q1eCSHX94VUyL4skIoHrh5FWsGSj17j5Vo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:45:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:45:24 +0000
Message-ID: <42ccee7f-606c-4ff2-a7f2-1a37a25b7733@amd.com>
Date: Thu, 11 Sep 2025 16:45:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] drm/amdgpu/dma-buf: Pin MMIO_REMAP at export;
 unpin on release
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250911143815.825607-1-srinivasan.shanmugam@amd.com>
 <20250911143815.825607-4-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250911143815.825607-4-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR01CA0001.prod.exchangelabs.com (2603:10b6:208:71::14)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 70586a73-5ac5-438e-a572-08ddf141d73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHoxd1ZjeG9pRlh4d0Q0enVuV1pjTGkreXRNVXFIeWwvMDl6UHV2bW5VT004?=
 =?utf-8?B?Z0szeUxTVmZhN0xnbVYwRjNFcGV6d1hJYnJhQXNHaHFoNTMvNk5IL25seWtH?=
 =?utf-8?B?S0Voa2FIMTdQOUptdVpUMnh6MFBmd0lTdUtaajBZcVkvSS9lSklFeUF5RDFV?=
 =?utf-8?B?N0tKVGFWTlUvZVg5N3U0Vks1WU4vek15SVVacmt2bmtSNnd2ZnFvenNmU0Jm?=
 =?utf-8?B?TTl0MVFvb0hUSVNlYUIyRU1VYUJXRS8rU3dhQ1UzMHd5aWRCa3kwVm1yQlVY?=
 =?utf-8?B?OGgzNTFPZWdwWUhHdGF1cHhFKytnNWlvMnB0NE1kcHV5c25vWmdsdUpIeDlL?=
 =?utf-8?B?dkQ2bElaK2xkWjQ3WElGSWxwN2JPS0libU9pSHFmRStISzF2MjcxT0cvVFNo?=
 =?utf-8?B?TFRScWNQMjB0b1pBeEFqNnZvR3ZsbnJ4TXZpTUM3Qy9uNlJBLzg4blBIS1kv?=
 =?utf-8?B?c0toNnpocnlramxsU256UTJIS2JJMzI3VEUxT1RHMnlaNVFPemw3d09nL2gz?=
 =?utf-8?B?c0l1MHlmWXFoeUhsM0JHVjFvdVJISDJTVjlMZFY3eWE2SmdWYmtWdVF1cEJ2?=
 =?utf-8?B?VFpURkMwbDNySkdJSFQxTXhPd1FIRnVWWFZEUHN4Z2dXclhGNlJ6ZG9jNWdy?=
 =?utf-8?B?ZVpib0JXU0FtZExKQnFmNVVLZTgxaytuNWZHc1czYXJSUUxldlRaeXRlM3Zo?=
 =?utf-8?B?TXdmblgwNFp3SVFKMFJBbHRhZFhnL2RGMFZrbzNTVS9OSVp0U0lpSFpWV2FR?=
 =?utf-8?B?MWMyYnZkYS9WRERZbEM1Z1phYnNHaWdkVjRkWFhvVmtUcTN0YWFrSTA5d3dx?=
 =?utf-8?B?MzRTT3Q4ZnVpK1VibmN5dElmYm5leVlVaWg3VGpWcFBZU3JLNHc5U1R0aWJJ?=
 =?utf-8?B?TkdoRWlaMVdsVTdtRnhMNFN5VUpkL3kvR0swcGxyMk4yaGpEZytacFRlK3FK?=
 =?utf-8?B?WUFFSEFySGRKY0g5MjJjY2tBMFZqanJ3RXpZempmRmtPUmtLTllxZlBoTlVt?=
 =?utf-8?B?WE02RnFzSTRRdFRMWnhMR3RZRmkrUnZoeE1Cd08rNzZFeGIyRi9ONnprVVdI?=
 =?utf-8?B?QnhJL1dzaExmb0lqdjVvOFJVZ3ZxeXJnc0N0U3hJVHF0QXJzYzhKK0x4ZUQw?=
 =?utf-8?B?a28zeXJHR2hyRHR6UjBoQTdjWFRkckRISHZqV1pORk1JTFFNd2hzNjlCVUh1?=
 =?utf-8?B?TDhTUnQ1ditVai9LSnJZL2ZNNitab2N4Slp0bXJUUHBqRGhGcFAvVVZUb3Vv?=
 =?utf-8?B?OFE4QjVpUVFTNDRBU1AwREE3UG0rdWF4YmREZG44d3ZOYmNGY1FaZU96c0V3?=
 =?utf-8?B?T2xsS0ZWZk55em5IYkRQMy9jQlBsN1FWRkVYNGliM2lnbFdxSVpFTDRYRzJB?=
 =?utf-8?B?a3JnSU16UWtkTUl2Z1FjNXpnNFdsOG1QWmh1UmFwZSszOW93dkdwK3BMYkpT?=
 =?utf-8?B?OW5BNjdSNnp3Ly81MDgxZUxOcm1ZTWJNbHlGaHMyMnlkOEpWMGRJay9mbUtD?=
 =?utf-8?B?WGUrUCtwL2c2YmNJd1oxSGUzUHRWLzM0SzZwTitiQ3JwVWFGS3NPSXBBT29D?=
 =?utf-8?B?Vk9WditEZ0dqNGo4UlRTODdrczBkTWx0OC9MMXhvZnVQYzVieGVpeTlOdGYv?=
 =?utf-8?B?WlU2Z1AzUzN4dG45dzFObW42cnVqL3d1N21hOGVLZTErajJEbGR5U2hVL3dF?=
 =?utf-8?B?UzFKYzlXSWJDcUdRbDVBKy9NOG1YMW9FdFhRa3I1c2xCck1oR2p1THpSWHFE?=
 =?utf-8?B?ek1zcXJreDFEWU5xM3A1NFdZQWNsUjRCS09JQlV5c09wYWJkTUo3dmo1bzdY?=
 =?utf-8?B?LzRXMUNkU0U5eDFXSjhESWJ0djRleHNVdkp6SmtPcnlDQVhKMDdKWHVIQWdy?=
 =?utf-8?B?MmJKU1RZVlM5QnU1S0hDZTJIZmJ6b1RlMTE2VU1Gakg2aDB1bExlM3RSS3Yw?=
 =?utf-8?Q?sMq3X29cMIw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WURTSlcvODR5WmV1bW1tc0FKWmphQmhHYnp1aHlrQ3dRNTJaZE9GVGZ2U0V2?=
 =?utf-8?B?QXc2SlVuWXZxSUVkSnJzaVZ6WmlBWGwvdmhieTE0ZWV2bTVlc0p2dFNsR2lp?=
 =?utf-8?B?aHRUMDFBQVBJdGlFZFVDdWVwc1ZqVnlVRlVGTHZrOWZ6aHEyUjBFM3VqUHFW?=
 =?utf-8?B?dmRSN3IyU29LaUZYRlVNQ3k5ZlFCYXY4LzF0RWdacUxiV0dXVGQ3bkNlcTNY?=
 =?utf-8?B?WUJPQ3Y2RzhRVHY5N0wyeFFGNmJKL1pROWJveGNVS0pCWVA5ZGM4WjBqS1Ev?=
 =?utf-8?B?SW56NXFmeUpwaWxTWE1ZUDhqYVNmcWFFQzZEQk0zTytZRjkrVFliNjFnUlFR?=
 =?utf-8?B?NlFUcmFheHUzQmM2OVFpVmYvQnRhblRqRFVhc2hLS1lkbUhPLzJsN2Qrczlh?=
 =?utf-8?B?V0xHeHFwR1NPQm5QMGRPZ2kzK21ocXZuU2dtcFN1a28rdXN1VU9FTFFIOVlv?=
 =?utf-8?B?TWJrWDBVVmxHcE9kRkZTcStNeDdhbXFZaTN0MVMxM0NhYTNZK1UvZUNLTlpZ?=
 =?utf-8?B?dnJCZEZHTENmQ2hUNnEwelhpS2FqZm1PWEZaeEk1QnhWQnFGNjU3MWpnNnp5?=
 =?utf-8?B?NDZLWjZPSVI0V0V1Y2pHNVovcVNNZzY2cGlIVXVWaGhmN3Y0cEF2MHlZOVRr?=
 =?utf-8?B?S2U3ay9FemVkNHFGYkVROFFNd3owQlA0RUU2YUxNaE9DU1BEeUJwbjBrZnJ5?=
 =?utf-8?B?bVBYNkh0UW1EYlp0VEJrQXppbDFrZWgxaDdBdXJ4L0hzako3NlJwYlUyb25w?=
 =?utf-8?B?endRdWp0dXdrL1VWV1VuREhLRUZ2aVoyeEozM2tqZXMwTUs4czhGS0lVTVZh?=
 =?utf-8?B?V2V6K0FVK2F0TDIramg5bk1wZFA4R2k5MkNQNVhqYndKN2ZnbVVqY3pEbnF5?=
 =?utf-8?B?Z2ZFUW40VXVuY3V1UUVPVzQvT05neHdlMGpTS2Q2bFd3UnNBaURPQU1TQVBU?=
 =?utf-8?B?UkNLTTlkMnNMMUdvem5aTGt0S1RBOXJNZzNYdmt1RXZUd21ZSnVjcnpKM3Fk?=
 =?utf-8?B?WTMyQTRlblRSQVd5TzhJcC9ZZklPb2VwV1FSaUxoM2drSG9QcTE0cnZVOEVW?=
 =?utf-8?B?WXBib2pHZVREd0NuKzdVc25iTm81NzVDZmVlbHNYUEE1eExxRFdJMFBoR2pT?=
 =?utf-8?B?MWQzU0xyenpuN2xFc2NQZ3pQRmJGUGNEQjdBaFQ0bWx3Nk0vUzJNcHlTVXpR?=
 =?utf-8?B?L0pUSjJnSVI0S2x3MmhaYWdEbm5aRlJUT3FyclJXNTlNcytoVjJ6L3ZpNzJk?=
 =?utf-8?B?NFkrYmNsc2xoZkZ2d3RHMFRxd0pDRDU4VWJQL3RIZGJQYUtITVFRTWhXS0ZV?=
 =?utf-8?B?Q09FcVVWS3JWZ28wVndwdUNGNDAyUHI5VnJLZXZqL1YxU2dzZDlhWWZYOVhG?=
 =?utf-8?B?R0U3ZnZCbWNJSEU3c015ZGhhMWZPblJ6VzNUSFF5ZkloZkhDUTU2dFRUTzgr?=
 =?utf-8?B?aEpCWmdES1BzOUJqOERWcStSQlZJUk1mMUdTbzdFVkZ5MDJzd3l2bmNlQy8z?=
 =?utf-8?B?WENxNlJHS3lveWdrRnJQMzNUTHlOcUhZb2FtaytUbWhUQWlKTHhndkZTamsx?=
 =?utf-8?B?TFJNZG9qYndGZTZmWWQxVVVpWEMxeUs2OVBpaVhSVTRLdmJ4ZldSQ20wM0Fr?=
 =?utf-8?B?andFazZzSjUzZURvcjlFakMxSlFJU0ZPSFNUZW42QnFZUU1zWEgwUHYyWTUz?=
 =?utf-8?B?YzBtWC81M2VUaE5VdUZnOEJjUUNkSXdHM1A2QkxqWXIvV3F4NCtkUnFMbXVT?=
 =?utf-8?B?RVptcXVidmQ1NExMVUNHZ01pMkx6VTlMMCtqWTJlbXdpR3dBQWwvMzE3eE9a?=
 =?utf-8?B?UkJBeVZVN04weUJxQWdDUnE3UlpHcnpFYjNIT3BzcGl0Y2lZYkw3cmRkZlVJ?=
 =?utf-8?B?MlRyeWlYcnhrYXpEZkY2UXM2R2twVzg1RFlXdUc4dC84UHRmS1A5bVUxWlp4?=
 =?utf-8?B?L2R0aWNPeC9wREpmd1dwUmJlbXBoczJ1SWZOa0FGNkh1QzVEcENhbExDS0oz?=
 =?utf-8?B?Sm9KcDFqbFRlQ2RPMHh3aWdZbURtNjgvMkF6MmplWkd5dW55SUw1S0ZzNUxq?=
 =?utf-8?B?cmROWjlkYUFlbjJkSXc4eUlWUXRYckt5cENHUEYwajNxR0lGL1RaV1NSVEZn?=
 =?utf-8?Q?R3nG3Z+MDUbAX+KPHfZ7xJQW3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70586a73-5ac5-438e-a572-08ddf141d73a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:45:24.3909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6h//zW6AO7V79wfB7RDL/nz1WSto2zcCKJm6lWfKPZtMhu41KzCNirQ/BUrQJO3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
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

On 11.09.25 16:38, Srinivasan Shanmugam wrote:
> This keeps MMIO_REMAP fixed for its whole lifetime.
> Other buffers (VRAM/GTT) are unchanged.
> 
> This change pins it when we export the dma-buf.
> If the export fails, we undo the pin.
> When the dma-buf is released, we unpin it.
> 
> MMIO_REMAP (HDP flush page) is a hardware I/O window, not normal RAM.
> It should never be moved

Please pin the MMIO_REMAP BO on creation instead.

It doesn't make any sense to evict that anyway.

Regards,
Christian.

> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 36 +++++++++++++++++++--
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index f85e16be438f..31d78561ab95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -47,6 +47,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  
> +static void amdgpu_dmabuf_release(struct dma_buf *dmabuf);
>  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
>  
>  /**
> @@ -377,13 +378,27 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
>  	.unpin = amdgpu_dma_buf_unpin,
>  	.map_dma_buf = amdgpu_dma_buf_map,
>  	.unmap_dma_buf = amdgpu_dma_buf_unmap,
> -	.release = drm_gem_dmabuf_release,
> +	.release = amdgpu_dmabuf_release,
>  	.begin_cpu_access = amdgpu_dma_buf_begin_cpu_access,
>  	.mmap = drm_gem_dmabuf_mmap,
>  	.vmap = drm_gem_dmabuf_vmap,
>  	.vunmap = drm_gem_dmabuf_vunmap,
>  };
>  
> +/* Drop the export-time pin for MMIO_REMAP when the dma-buf is finally released. */
> +static void amdgpu_dmabuf_release(struct dma_buf *dmabuf)
> +{
> +	struct drm_gem_object *gobj = dmabuf->priv;
> +	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +
> +	if (bo && bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
> +		amdgpu_bo_unpin(bo);
> +
> +	drm_gem_dmabuf_release(dmabuf);
> +}
> +
> +
>  /**
>   * amdgpu_gem_prime_export - &drm_driver.gem_prime_export implementation
>   * @gobj: GEM BO
> @@ -399,15 +414,30 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>  {
>  	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
>  	struct dma_buf *buf;
> +	int r;
>  
>  	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) ||
>  	    bo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
>  		return ERR_PTR(-EPERM);
>  
> +	/* MMIO_REMAP: opt-in + pin at export so later paths never migrate it */
> +	if (bo->tbo.resource &&
> +	    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
> +		r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +		if (r)
> +			return ERR_PTR(r);
> +	}
> +
>  	buf = drm_gem_prime_export(gobj, flags);
> -	if (!IS_ERR(buf))
> -		buf->ops = &amdgpu_dmabuf_ops;
> +	if (IS_ERR(buf)) {
> +		/* if export failed, drop the pin we took */
> +		if (bo->tbo.resource &&
> +		    bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP)
> +			amdgpu_bo_unpin(bo);
> +		return buf;
> +	}
>  
> +	buf->ops = &amdgpu_dmabuf_ops;
>  	return buf;
>  }
>  

