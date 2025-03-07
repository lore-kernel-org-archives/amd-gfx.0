Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EB4C28B28
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 21:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26BF010EC36;
	Fri,  7 Mar 2025 21:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="amiNqJQb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121F710EC36
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 21:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiE5OzhVg4MNzRCZS0LTY4mjn5i5N6m6kx7m0uKoEZgEM2riSF5wRhQ7EsnWoylsM/dbPL5Vs/HYGIaZQ86Bc1AsgiQKStYtmhr01MIoAIj+sadqSGUe40u6lY8kolhXfIL+xRjp+yWKGgpInW026SvQRCUtef2Swf/GssqSh1g3D0iEGQBboJLoYU5tHFjdBY75akTRJgAZc6PBcWVfh1ehAx3Ni9YuOOcTRuDUiBwKY+r1cEUzVkr66WHfxwjaA3wl4+Bpt40X3mo2DRQAXk7cLbvlN6929t5U3SSuvuNdhPtiMMccawyYDhxqU/3LJK3unGgxQYaCjpkOjAJpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V9V0yvkOZkt5dXcPfOzFxFZ/Nb5ER5V2P+XGsJ1QzI=;
 b=munDPD9fvYWXqVzV6Gvf68eRGY0zTeDjInafpYxtCdWrdjB7NtKcq+PDGIsvLlhIrvRd0SArZ3CDvffg04wuU37i4k3oWIcmzmP5njf372Y0OYlOjC5KBy+yf5AGNtnr0J2OEVzJu752rtI7ZdR7d18iBeUE1aD1eJZGDGbKyrIZEGWoARpUkBkR+gxvPhVEMQZqxZ7NHD/TJZwBGKb2cNpEmAvMbgcqyuNTSChN15LZkF4+EJLhS4XfVNfBZLTg5o5L7TFwhpe6t2vXp5NyRkRmo4XxedE9V5i/7Bs1snB3d8AIiY3X3K8NTMFdbupziVkdcuON2EIxMpXR5cpCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V9V0yvkOZkt5dXcPfOzFxFZ/Nb5ER5V2P+XGsJ1QzI=;
 b=amiNqJQbDyql7zAHvdahVAn2F4SK4L/QZZynVzJquVAQRDpNqtq0rhBWI1p0+qdRtFenznOgMD67s7FvUYx1OPU6Pc/1cNC/PtKHRLGdws9TxecmSfhHJeWrhaTR0cG4H61ISQlXyB4zlgHQs+fhJ/STKZeppHtHf5FOxuaKpz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 21:00:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 21:00:26 +0000
Message-ID: <3f3b9720-5f48-4469-961c-a13772d4cf33@amd.com>
Date: Fri, 7 Mar 2025 16:00:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
To: Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Cc: haijun.chang@amd.com, Horace.Chen@amd.com, zhenguo.yin@amd.com
References: <20250307085321.677381-1-Yifan.Zha@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250307085321.677381-1-Yifan.Zha@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: b9df78c1-fcd8-4284-4482-08dd5dbb15f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjkvY2VtSEtmeDdLT1dlMys4RVN6WXFqU1daWlRFcWk5d2dBYXhkeGl4UEND?=
 =?utf-8?B?R1phOGEzWGpscEoycEtjNEcrUmdmY1NxZnRQakxhU0ZsMVVYaGRZenlvbFRI?=
 =?utf-8?B?bFl6QW9wbXUzVTM2Tys4d0huV2FoNjd1Z2NhNDRIUmx5T1hucE95U0FmTHRW?=
 =?utf-8?B?b3RYM1NMdEx6MWxyVmFnOG1Tem5EU0VKU1l6dGF0TVBHSHVCbmh4WGMyOHo1?=
 =?utf-8?B?bVFnaHpHbGVnWURsdDFuaW5oMXI1bzVraU8xVnFEQlovTFJjbU9UNzRaUkRK?=
 =?utf-8?B?TzdiVWxOREtUWkh3NGo3WlhndkVuSitBTi9URFNFa05BaVRzcXJkZXVNaHlB?=
 =?utf-8?B?Z0ZXQmgwd2VlbkRoZzFWNTJlYVVWSjdmVENLQ2pxMUxHbTlDZk0yVHQzbktS?=
 =?utf-8?B?YkltdStjU3FMSGFnMVkxVHI0VTNybjIrMkRRb2Z6QU90Z0RlZWNBNERUbGRI?=
 =?utf-8?B?Ny9JTC9UdXIxNzRNalZkT1VlU0kva3VJY01MK0lUUlRiVXAydVFucWpTYXdq?=
 =?utf-8?B?UnIzY05hVzdBdmRNbzkrWUFqaFBhY3duYnFwcmcya1pSaDVobVBsL3VLaGtQ?=
 =?utf-8?B?eTVNU0xqYUxZempHem1yN2hwTXBCdjdEMkNCMlJpRGZqWTdOenZYTlZjeTFm?=
 =?utf-8?B?RkxVdCtYVHZWcGZUMXhXRUNRVlJiVkFNMXp4VWdVVmFNRWtjQU5tZVoxQVVh?=
 =?utf-8?B?V0hGNG94aUttZklQV2hhZmxMRWlJRURlMEt6QXZ3cXdmaVFYRUFkNlFGZlFS?=
 =?utf-8?B?dEpLSVcxVms4L3RkZGNXZ1AxOXkvVkJmNUltMGdhV0FHNnc3UWtQM0tiaFUz?=
 =?utf-8?B?TG1TbFp4WFFaRzY1cCtsc0MyVXhwSTF0MHNMTUFkMEEvdVVWZjFIMG9wOXJ0?=
 =?utf-8?B?UHRoTVFTZDh0N0JZQ2R5WlNGdjYzK2doWm5uOW56N24zTmh2MW5acUtSTUtO?=
 =?utf-8?B?RUNZZ05GeUVFLzd6TjgwMnpXSzNCYlBCYXM2TDJWRDZkbFNBWG1EbUxzUG15?=
 =?utf-8?B?b01XUzJLQnJCRFFLOStKUDZ4TVFSMDg4SEsvYXNObDBZYTg5RktoMm1Mb1cr?=
 =?utf-8?B?aEpDUHZGMEwzNWpZRWV0TjhlUy9TZEgxU3M3dWVONUdNZFoyMyttckxIdzA0?=
 =?utf-8?B?Y2J1c0NKSkZGaTBXSUcwMnNndnVhOUxPN3NHaWJjTnQ5RlJZeFhEYnd6R3By?=
 =?utf-8?B?VXlyWkpaZWtvZGJLQ2dZYTdnWUVHVTZTbTRkdzdIVE9SSTFEWlFCc3oxbGs3?=
 =?utf-8?B?K3A4OGl1YTdVcFdPam9UTUdoM25GaFIwYmhJWkVkbmdwQnRXVldoZTNQUEcr?=
 =?utf-8?B?TzlYK2ZBUWpZbENScU5sZVZvUWo1MURSSG5rRGdWTTNxaVkyV3lrNGNaVWVt?=
 =?utf-8?B?RDhWL1dlMFJyNThRZCtTWkdUbm5pRDlQWGZOV3d2ZVdsdFZxVkRpZlVmbURO?=
 =?utf-8?B?NXlpaHo4aTF5RnIyQ3FoUmZBQnhKblRHeGVCQjRIYWVIV0NpbzBnZHdlZTdR?=
 =?utf-8?B?QWRjV1JWUktFczZMSnAyTXR0YWtGU0F4KysvKytXSW05emtMMElBeDZOY3VP?=
 =?utf-8?B?RHRwaHFUVTFXTXMvdHNndmM3M1F5bG8wVkptR2lBODEyaE1pUnZnVk9YTVU4?=
 =?utf-8?B?Vy83MFVmUm16VE5KdTY3QVYvaDVMV20wRDRNY3lIUkZaNXdIQmx4U2xKelkx?=
 =?utf-8?B?UWNPV0g3andVY2lacjhtcWYzcGFsbzcrSlhENGVLbkZmdWlCMDRYSGF2L3Qx?=
 =?utf-8?B?MzNCYlRuQjJtYXhyaGF4QlR0eGdZa0pNYlBlRlJyNEU3S0REWG1mTzlZRlJr?=
 =?utf-8?B?Qlk3ekpZZTcvTU4xd1ZIaHVuMG1OekVEM2V1WGkvQlRqMTg0UUFYZFd5NGJM?=
 =?utf-8?Q?yxUkAwsht0859?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVvMFlLR1VnNkxiQThhVmo2NlZqZ2pkc1BzOTg5bDZYS2twY0hjU3RWSTVT?=
 =?utf-8?B?eEJQTW1ZcUoxa1RZRXFBUkJ1OGExVlNURVpnSFhtRGhpRGVucThTdTZsVUtW?=
 =?utf-8?B?dWZjd3lTZUE5SkR3bWtvU1V4MThzUGJEaDhUaE5KYjlaQkF1MHFtaW16ZEpP?=
 =?utf-8?B?R3BlbGxtOFY5RnJiOEwwam1BbnRFZDViZXZ4NG5OazNob0NadWJMaGMvdlhn?=
 =?utf-8?B?cWVvNjBlK2EwdGh3bVFER21RMFVNRnVlRVd5cGhuUnlkTG1PQ3M2VXFsSFpZ?=
 =?utf-8?B?OXdZdnB2VXdJSWR2c3JwUE5LcGs4SVFQTmtvWmo4dWYvS3VaYW5GTnZsMGwr?=
 =?utf-8?B?aFduOXByWDJtZ2JtTlUwajFvSDFJbng2NFB6dDg0ZVdqbU9PRXhhbnM3am1o?=
 =?utf-8?B?Y2NXSzVsUVA0b3A5amJzWExlUTZOcExaRys3RS84RWRYeTFoS2htT2pMVERN?=
 =?utf-8?B?WHVTRGljai9pcXd3bHJWK0JBdzluWDhwazM3VXV0MmRUOG4rNy9SbWNyLzNQ?=
 =?utf-8?B?UFlsbFBkaGwwZFZicDlGV25hdmt3TlpUdklFVG9DbGxscnE5Wm15ZThyQ1Fr?=
 =?utf-8?B?UVRwcDZxMDRROXBia3VFc24wa1RXSlhKdW14K1M1MTJpUlBHNk1SZmxRZ210?=
 =?utf-8?B?Y0o4L0U0ZWs5M0poSXBVdWFWbkUwcC96cldhL2lzTUcycmhheHY0QXVNeFdB?=
 =?utf-8?B?K2pFYm53ZUx0RDZ5QW93dDRRMHFIYzdSbEVrK0pydFVYczYxeUZTR0puSnpU?=
 =?utf-8?B?SVRLWk9EWGhSWHZkdG5ta3l3a0hDUUtEMXduZ2tPcUY4RGJScUtZVkpWUEtS?=
 =?utf-8?B?UXovamRUQTB6QWp2YnhqWXRkTzhFNTJKbmRnSytDbHBUaFBHRFlrQzYyaEoz?=
 =?utf-8?B?YWhGZEFHaWNJY1ZIb2xqa0tNaW9YS2xiSjBXV2pudEFLQ0NXVHZmVDBmQmR6?=
 =?utf-8?B?ZXhtSnF6b29EYW9rcU83UHdGWnFvY1oyWTJCUFRZcWMyWnZBRHdZNzVqTno1?=
 =?utf-8?B?RFNPUC9hRXBuTG9oM01NZkp1TzRDTGxpS1ZYcitRUXNISHZZYXZCRllHKy84?=
 =?utf-8?B?cGJhcktrRmJNMlhSM3FoWm82MWFwaW9nZ2M5bUtlN0J0aFFKdEpSZFVoWHBK?=
 =?utf-8?B?ZElkOHc0WlMrQUFvSDdEbFM1dnVhMHVYMS9IcGw2Qmhld3QxTEl5SlBiYkt3?=
 =?utf-8?B?WkV3azJROS9DVEhHYlJHRXpTT3kzNGRkcXpLRmx5ZlNhU2NPaEFHand0c3Yx?=
 =?utf-8?B?eXlTTUl1WWZESTNRYW5QelU2b3FXTGlzU0oweXpNcnVWbXAvNVUwSldNb0xn?=
 =?utf-8?B?bnd1dFZhNERXNFZpWVc0alQzSWhtTXd5TmNXTEVvazJZYTVwMzN6RTRHYnFi?=
 =?utf-8?B?YlNUb2pheUJISlQ4M3VVN3BHN21XL1hXYmpRWktxOEw2NFF6TVplTXpyeGRX?=
 =?utf-8?B?OFdLTGFqUDFhZ2craEh1Z0hZeGhwZC9ydHozR0psZjhLRkJPekNaM1k4R0JP?=
 =?utf-8?B?TUxzTWYxeHk0MDNOTnJla1hVVXgxK0FYa3JZODU2VW9hdXNDbnh0MENrcmVi?=
 =?utf-8?B?WWNMYmJLdlI3MXkyRmNhS3pRMXN4aVprbDlOWGtDd0ZtRWVzS2kzNG1BOE5a?=
 =?utf-8?B?NW1rYWVzLzNNWjVxK1Z2ZEx6MkpjemZQVm80YlZhZjBNT050K1JsZGdMcFk4?=
 =?utf-8?B?VnQzaFd5VEcxdHpoRmlUNHhnVGJ6ZUFRWm5zTWNhd0FROGt3RFpMV2MwS0Vw?=
 =?utf-8?B?eXp1ZTBqNllwcmZxOVgxZTdwT3dQaCsyallINDA2MDIzMzhjWk5HY3BPT3B5?=
 =?utf-8?B?cmdQZXZOdW94amRUc1d2QWZkWU9iT1dMZkhjVEFTZmgwMnhqT0FkYXJLb29k?=
 =?utf-8?B?M2Q5QTQxUVFkVDNzb3p5MThNRExaNHpkWHpGT1J4QmluWjZFQ2FUVWFLclBL?=
 =?utf-8?B?d1IvRmIwTTdZOUVsQ3JLOGlpS2o0eDdxQ1R2R0IrNEZoaER4SFd3ZXlud0RK?=
 =?utf-8?B?QVFPQTV0bExlbzJWRE5aQ2c2WHJoSDdDSlZ3dlZHUVNaVmt2d21nQlpUeW9N?=
 =?utf-8?B?ZGNZSFZubFYvdzRkSXpkWmFxMmF2T2xmbEl1ejd0RDRyRG5wYnV2ZmVteTRS?=
 =?utf-8?Q?Bzdf97ycuLj46/uTM+5pdPz9e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9df78c1-fcd8-4284-4482-08dd5dbb15f1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:00:26.6725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmCxw92dVJG4dOjurL8G6mYkl8/NqgMf3myFCQJg4vojkK8KC5KmUlkf+bP9K1DkhDNXJ5VI3DKu0N7xxWioBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
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


On 2025-03-07 03:53, Yifan Zha wrote:
> [Why]
> If reset is detected and kfd need to evict working queues, HWS moving queue will be failed.
> Then remaining queues are not evicted and in active state.
>
> After reset done, kfd uses HWS to termination remaining activated queues but HWS is resetted.
> So remove queue will be failed again.
>
> [How]
> Keep removing all queues even if HWS returns failed.
> It will not affect cpsch as it checks reset_domain->sem.
>
> v2: If any queue failed, evict queue returns error.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f3f2fd6ee65c..b647745ee0a5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1189,7 +1189,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   	struct queue *q;
>   	struct device *dev = dqm->dev->adev->dev;
>   	struct kfd_process_device *pdd;
> -	int retval = 0;
> +	int retval, err = 0;

You should still initialize retval to 0, otherwise the function may 
return an uninitialized value if there are no MES queues. err does not 
need to be initialized because you're always assigning a value just 
before checking it below.

In fact, you could declare err inside the if-block below, since it is 
only needed in that scope. It is preferred to declare variables in a 
more limited scope if they are not needed outside.

Regards,
   Felix


>   
>   	dqm_lock(dqm);
>   	if (qpd->evicted++ > 0) /* already evicted, do nothing */
> @@ -1219,11 +1219,11 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   		decrement_queue_count(dqm, qpd, q);
>   
>   		if (dqm->dev->kfd->shared_resources.enable_mes) {
> -			retval = remove_queue_mes(dqm, q, qpd);
> -			if (retval) {
> +			err = remove_queue_mes(dqm, q, qpd);
> +			if (err) {
>   				dev_err(dev, "Failed to evict queue %d\n",
>   					q->properties.queue_id);
> -				goto out;
> +				retval = err;
>   			}
>   		}
>   	}
