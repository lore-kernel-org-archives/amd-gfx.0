Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C83CAC5B0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 09:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C4D10E5D4;
	Tue, 23 Sep 2025 09:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDynitBS";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDBA10E5D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 09:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I97rMPHtzWLQpWqFWaCQHYp/AU8NMvoHxRfL7VAf+qkFLrIsBi5aMVHh7Dzq6QWxVAij9xBKVmkY1O0CMA1M2fErp9Edm/fNHxhvDFX8cYLtOhUIt3/cpkvbgmNQKznkLwkYQb/k5cCqEXzQUCt/zXzXVo6XZPxwLPJpKOoglUUlCMr1fhDESH0GkcloICIBAP+rY3b7wQseRJ1xP0DKcW70UdPfBk/JQCMyKw47Wob5uRIpFgn6kuU3YprSwQQfEeuYCmEnksBK2hPcutJ4XxH5ugcFdF6NXIbTFsSRiygtwAMc1lydKIRAHetpjRqTy8eSGTTNhhkkTYOOH/9MyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzbQFd9xh8ug1g2/USo3+ZLeunmYiOTonIuDoe53OHE=;
 b=j93IrGj/us9kToH4110ksQv6IUomFDTOnBULv/jTzlQQwcUSS0Sg1dy4gVYs4hSJ2J1yelNvhgR8w1H7ExmRfocrE3MyY+iuhziUF+tLCRHoL+B23fk0N+dHs40Ys8+kY1KjiBUq7oexUmoqELIqCdV8N2FN9VObRXbADW+7AqAq2Me/u/WPP5CXG4z5c87QPWdMm7KIg0a+x7uDAowqtOfh4Xm8OLNyEZDeLNv3nYOL2AfZrXRtUGDxPXIL5fjtPA/YQmsqjO73gPuKUtHY2AoiuKXaYdxglhl1+bZ9zACeiMBff/hNVoZMQZld8252Xn5h1IZHZk2ft8RjoQD4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzbQFd9xh8ug1g2/USo3+ZLeunmYiOTonIuDoe53OHE=;
 b=lDynitBSi10M1h0UiCIDb6YLhvQgyqj/obXh/w4VVKlqcHidVqR8GHG/SBtny9sdyHQyft8A06ZtFdKWom2kRcTveiOtlskWIqOoMjPpzGSYe6Ue7i0th1L0/jRtF9OLdhNNyHQqjgDDF8jJA/WmaK2Uc8gJQTgPYm1VjHbZF+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 09:54:25 +0000
Received: from PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c]) by PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 09:54:25 +0000
Message-ID: <d3fea12b-a705-4bf7-ba5e-bc06aea96c89@amd.com>
Date: Tue, 23 Sep 2025 11:54:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/userq: Add syncobj_points to signal ioctl
To: amd-gfx@lists.freedesktop.org
References: <20250915104146.11185-2-david.rosca@amd.com>
Content-Language: en-US
Cc: Christian.Koenig@amd.com
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <20250915104146.11185-2-david.rosca@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::31) To PH8PR12MB6770.namprd12.prod.outlook.com
 (2603:10b6:510:1c5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6770:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: 39de8f7c-1213-491b-eb75-08ddfa872da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFBBYks5eWZmNmd3cmZudUFyVnNmODUzcVU5Y2tlcUVSZGpLOHBvS01Qd0pU?=
 =?utf-8?B?Z3R4cS9oWktLM0UvNGpxR1RqNW92dVUwcjhFQTdNbVp4MTUvZ3ZJazBCZE43?=
 =?utf-8?B?blYwNFpCbDZMM3lZaVJrNzVHazMyWXl3RXRTYy9adGNDYWFhWjFtY3pWdVJ3?=
 =?utf-8?B?djdhY1NRL3FqOTFDbVRtc0VpZk1HZEw2UGVDUkFmcFBwSlRTU2dMdkJxRXJZ?=
 =?utf-8?B?VkpxL3NjNTQ1RCtua3JuakRyMU9kYitoRE93TFJJcEEwajNCNlk0cFhSZm40?=
 =?utf-8?B?b0pLdnh1cHZFNXVPdk9HeEE3UXdvK3FERG5odXZuRlE1RlpkVXFWalBmc2RK?=
 =?utf-8?B?L1BiTEhlbXE0MWpQQWorWlZlSzRpTTdzdDJCRzRVN1AraER3bUlaQ00zeFQx?=
 =?utf-8?B?bm9xQzZYRElUWU1SWE1hYnpkYjcycVI0QUhUYURXZFdHK2JPczlNeHVNVm5K?=
 =?utf-8?B?cWtGNFVkcjJGazMxQWFiM2NKQ0pCVU54Q21MQzhKWG1DbHRsQ1Z2N2dJS2d5?=
 =?utf-8?B?LzBFemMxeTBPWDdqWkU3RUpQSFNmRmtzTkNsbGRYenVJWVRaamRhekN3RUNy?=
 =?utf-8?B?RXlOeUhVRFhwSXlhNktzYWZZZU9Ic0FqVVVBNzVnNUd1bnh6cUxwRGwzOHdW?=
 =?utf-8?B?WXRGalNRYkFrSXg1V0ZwSzFDWWdTN2IzQWtVYTdFaFRtZzZWN2xWSWpUb1Y3?=
 =?utf-8?B?aGxQdUk3UnBpQStraVVjU2N5ZFVTd3ZlSjBoZzN2U2ZnTGlRT2V5bkNoaWFE?=
 =?utf-8?B?N2E3aTk2YWdabjhUNDl2N2NOVlhnSUJ2bC9MRkgxMFcycGpYL05Od2ExTW1s?=
 =?utf-8?B?Uk4zOCtnKzJkbDY4ZVVrOCtMM0pKM2Y5dW81dWxMU3dRc2pPUHhESlg5ZUFi?=
 =?utf-8?B?bjdFN2tVK1ZBWHMycHRZVGdPODBxQUVPSDBMSmNZbnNuNWZSRWdGc2xlYkQ0?=
 =?utf-8?B?UmVRQjlPWXNMd1YyQnRxa0tTM1NiNFA5RlRKZm1jb0ZIQnBRTFIydUFrWEdx?=
 =?utf-8?B?UVMzeEIyWXJxWENua3QwUGY1V2lkRXlUTUMxQ0k3S29lL0hqcGs2TDhEQWFu?=
 =?utf-8?B?bnF1SU5wRWRxZXl4SWt4QXI0cFVHOWNyV0pTV1M5YWplNU0wRVlFV0lGWXlT?=
 =?utf-8?B?VkpsTjZJODhPMkptZXR2TEQ5dVVRUlNuOU9tc1RpVDNsUEYwSjUxWUx6a2l4?=
 =?utf-8?B?eDBaR2JLTDBmT3hjTTVMbWFoaThJaHkveFJPNWxpL09KWVFKT2dKaVBrc0lM?=
 =?utf-8?B?YlVYNytPWkE5SlA2OG5VdThGMEd1am8xQk42ZE5NZG1QMXVURFFsdjZlR1V4?=
 =?utf-8?B?S1NneVgzRGg1c0szcTUzTHRsRHFCV2s1Umc2NzBoU08vRy9xSGFDZnhiK2Ey?=
 =?utf-8?B?dW1kRlFOUW9aVUtIK1RqZXZTTTJhRmREK1ltY2tXOEhDTWZIenZmcnJWYUxQ?=
 =?utf-8?B?WkhINVJRd3UrR2RaM0VtZVArVjc1OVVuREFwSDkwZWFWb3IzNHkwSWJUM0M3?=
 =?utf-8?B?ajh5MHlWaWpGYTIzbDQvNmc5WFdRL0trR0o4VFBBRVQ2emdoRHd2cUxsZEMy?=
 =?utf-8?B?enVveWxhZXZ1YndzYWNmUldZNEJOSUFlbkR2NXYzRkpYOXhiekQ4NGVieEN5?=
 =?utf-8?B?emJIanlyS0pYcTByQXpsdWNEdHNlTlhsbmoxWW5LTmozL0VWR2FzUEV5TFZv?=
 =?utf-8?B?eG1QVlNPMGhWak9FRkdVcnAzc1IwQ3ZlVmptcUYxaThBdnR4K3FMZXFlQ3dq?=
 =?utf-8?B?TW1tcUFjR2VkenZxNzRoRG56VHBBOFJtakdjV1I0Z29ybTRUV1VObEZGN1lK?=
 =?utf-8?B?S0ZLYmdtT01zdE12ejVHNFpYalhLeUV5dUU1UGprQUtocGY0UWo1TWtObEVR?=
 =?utf-8?B?T3ozRUNFbmhZTU93QVR0YVZWcUhTNy93RjM1Y29RZS9DUTdDc0RKcG9Oc01O?=
 =?utf-8?Q?/7fK4ftE5gc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWpPVURMM09xLzRKU3VNWGZMVDhJalVtTnhPSHNRQ2R0VWordTcyZk0yQjgy?=
 =?utf-8?B?OTZIZWlLc0FzTmVUUnM5TGUreEhsb1o5U2pUYlQ0WnVwRDFXbUx1dzNsRUhq?=
 =?utf-8?B?RitXODBENzM4NVY3NGlHTEg3QUZBWFc5TUUrelBoTld3aytBaDY0ZGFCQ1Vu?=
 =?utf-8?B?aUduSlFnNTV1WHdrZlZCRDAvekVlamV6MndXazRzSld3WUFSVzRMN0RlQ3RU?=
 =?utf-8?B?QkhFdjRibWp4STNRdTZobmpmblFvMlpJbHBaY2lFcmlOSVA1K0VRVHNaWVl0?=
 =?utf-8?B?bkhtNy9TMDIzcURoZ0VhdnlkZDcyQWxiSW56R1owVGFoRUQ3dy9qOURQU2Jt?=
 =?utf-8?B?eTRDR2xGVUtOdHM5R09JTFZmcmZWaUNGdzdCMkVoV1d4QnhRV1FVOG1pbUw4?=
 =?utf-8?B?SURiYVNwY21WQ0NjTktoL29EbUtyMUhWbkZDRnhUbXBIOVR2eWd0U2N6TVE2?=
 =?utf-8?B?TzRMMDY5NWZvUWZGNEFtallOK3BMYXBHckQ4UEZ0TVJzMWE1MTVsN05qU3I1?=
 =?utf-8?B?OFdlUjlPMFpJd0ViMkRwL1o5NUxKdnZQcXEwM1JHWkRqMUFYbnNnT29tZmRo?=
 =?utf-8?B?Vk11dHVrS1VTeDVvYWZ0d3lKTVJnZUlkVE1zcktOVkwrRDU3ZG5mQnBzVjRq?=
 =?utf-8?B?azdIUDArTXBDQ1dFclBLY3hGL0Z2eUkyejBaM3FjYjVSNi9FQjJIVTBlLzlM?=
 =?utf-8?B?L2dReFJuUXYzZzZOcWlUUVVDYkpRb2hTV1JxclhtSnFISENRZy9iMkR3N1lw?=
 =?utf-8?B?K0xRRmZ3d1RiZGZyQWJlUXIzay84UHFtNmZlVjRDOTlJMDRxelhZS3NEYnpH?=
 =?utf-8?B?K2R4TmJoMGtYTVFxNzJVbzFCYndoTjZWWDEvUDk3WWxwdFZ6VDZpNVFoR2dt?=
 =?utf-8?B?TjlmanB6dzVyS2JjTzkvcE5FeTZiMHhrRklSSXpMeDFzMS83emkyUmVhR0Ry?=
 =?utf-8?B?Y2xzTXIrNngvNzJjbXhTaVozU0RJYU1nTXNnTXU3MmpOWGNSWVVJc1F5RUpr?=
 =?utf-8?B?S09LUlhXMjJYOHgzQ01Ic2twaWxkd2dxamFyWm5tdEh0WkdmNWtYNENmUFJW?=
 =?utf-8?B?T0dTcU12UEt1QTlqcXBnUkxQWS9Eajc3MGUzSyticHZ4dWlPcVhveVRZTURC?=
 =?utf-8?B?V0VWdkVnVExicHFPcytrRWRuRVNkQ3VlWU5VSmtJTWpPTGFRL0tudUl0Mzcr?=
 =?utf-8?B?MjdsMXNhOFh0WjNrbWlJOWhGeEN1ZmlIcVZaWE1mTWtpSmcybXpTT2FDanJM?=
 =?utf-8?B?YkZZWDdTMTNUc0d3NUFUNWtYdFBUb2Q2OGFVWDhkbms0dCtXcVppbHJpUGZ4?=
 =?utf-8?B?K3k4Y3VGUVFoZDJkMFlCWGpRbFNMdk85cTV3SU9zL3JPWTZnWGxpajhMaWQ3?=
 =?utf-8?B?NlRRMXl3VEVvaVVzSUNHL3NuQ0g0R3FTb2ZmcnpFbTRWSFhGZ2hPV2JyVXRX?=
 =?utf-8?B?UUJQRDc3T3ZJbExJdkROOFYrejV1S09KeW11TndneTBSWWpJRStHQ2ViUS9G?=
 =?utf-8?B?UXpMVGJJdGNvUDJlVHgyL1VLN1VHdlViUEl3RzlIc3o1QXAwbGg4MGpnN1dO?=
 =?utf-8?B?dnpuWGNkbGFBUlhXUndlbVNUN1psdTlib2xpYU91UlN6d253b0taOHdySjc4?=
 =?utf-8?B?OXRWbGpMcFVtYUMyd1RmTTEwT3V0dm8xV2NIWUppS1V1eFptUWptUGpPeVVx?=
 =?utf-8?B?RUR2ZmhYNFRFVnBJNmNKNDNFMVlkZ3NudTBSdXF4a0tGUVY1R1Q3eXFUUVhN?=
 =?utf-8?B?ZUlTcXRsbkVLSE5teTQ0VzVlQWhneDEwZk00QmVpT2xMU2R5Tm9STjl6K2E0?=
 =?utf-8?B?UVZKZzM4b2J1NmFvYlU1TlhxSE5xeXcwdlhHNVNydVgxWE5TMXJhbXJzMzZH?=
 =?utf-8?B?Z1V2RHJHZHZvdFdyUzVha0VJbFd5S1pBaEtoMjBwdmQ5aW9yUGswQm1TVFBM?=
 =?utf-8?B?dXNVdDh5cTNLNUxWd2hBQWRVVHJZc3VqVmhUT2dTUnVVaDBpbFlRT3lhMWtK?=
 =?utf-8?B?eFBlb1UyWk1ROGdtWUJjdy8wVjJOeHhOTHJudHkyWjZaMDA2WHpFelpudGtI?=
 =?utf-8?B?SDZXZi9uL1kwb2MwVFlaR0cyZFVDL1B3Umx1T2t1SUVrczhLZFhIMXJLU2o1?=
 =?utf-8?Q?B5e3JEajRiJLNrIro9CkiyQmW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39de8f7c-1213-491b-eb75-08ddfa872da2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 09:54:25.2761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsnP49wKEGulPLiOdMNHW+d3GBJGkUCJL0C9H0Hbrkypp4JMqEHGEPi7mhPB5Ptg8imm9f/fb5XsRI0d5yLdFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
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

Cc Christian

Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37335

On 15. 09. 25 12:41, David Rosca wrote:
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 49 +++++++++++++++----
>   include/uapi/drm/amdgpu_drm.h                 |  5 ++
>   2 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 95e91d1dc58a..5b2cdc49a28c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -460,10 +460,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	struct drm_gem_object **gobj_read = NULL;
>   	struct amdgpu_usermode_queue *queue;
>   	struct amdgpu_userq_fence *userq_fence;
> -	struct drm_syncobj **syncobj = NULL;
> +	struct amdgpu_cs_post_dep *syncobj = NULL;
>   	u32 *bo_handles_write, num_write_bo_handles;
>   	u32 *syncobj_handles, num_syncobj_handles;
>   	u32 *bo_handles_read, num_read_bo_handles;
> +	u64 *syncobj_points = NULL;
>   	int r, i, entry, rentry, wentry;
>   	struct dma_fence *fence;
>   	struct drm_exec exec;
> @@ -475,19 +476,37 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	if (IS_ERR(syncobj_handles))
>   		return PTR_ERR(syncobj_handles);
>   
> +	if (args->syncobj_points) {
> +		syncobj_points = memdup_user(u64_to_user_ptr(args->syncobj_points),
> +					     sizeof(u64) * num_syncobj_handles);
> +		if (IS_ERR(syncobj_points)) {
> +			r = PTR_ERR(syncobj_points);
> +			goto free_syncobj_handles;
> +		}
> +	}
> +
>   	/* Array of pointers to the looked up syncobjs */
>   	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
>   	if (!syncobj) {
>   		r = -ENOMEM;
> -		goto free_syncobj_handles;
> +		goto free_syncobj_points;
>   	}
>   
>   	for (entry = 0; entry < num_syncobj_handles; entry++) {
> -		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
> -		if (!syncobj[entry]) {
> +		syncobj[entry].chain = NULL;
> +		syncobj[entry].syncobj = drm_syncobj_find(filp, syncobj_handles[entry]);
> +		if (!syncobj[entry].syncobj) {
>   			r = -ENOENT;
>   			goto free_syncobj;
>   		}
> +		if (syncobj_points && syncobj_points[entry]) {
> +			syncobj[entry].point = syncobj_points[entry];
> +			syncobj[entry].chain = dma_fence_chain_alloc();
> +			if (!syncobj[entry].chain) {
> +				r = -ENOMEM;
> +				goto free_syncobj;
> +			}
> +		}
>   	}
>   
>   	num_read_bo_handles = args->num_bo_read_handles;
> @@ -603,8 +622,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	/* Add the created fence to syncobj/BO's */
> -	for (i = 0; i < num_syncobj_handles; i++)
> -		drm_syncobj_replace_fence(syncobj[i], fence);
> +	for (i = 0; i < num_syncobj_handles; i++) {
> +		if (syncobj[i].chain) {
> +			drm_syncobj_add_point(syncobj[i].syncobj, syncobj[i].chain,
> +							      fence, syncobj[i].point);
> +			syncobj[i].chain = NULL;
> +		} else {
> +			drm_syncobj_replace_fence(syncobj[i].syncobj, fence);
> +		}
> +	}
>   
>   	/* drop the reference acquired in fence creation function */
>   	dma_fence_put(fence);
> @@ -624,10 +650,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   free_bo_handles_read:
>   	kfree(bo_handles_read);
>   free_syncobj:
> -	while (entry-- > 0)
> -		if (syncobj[entry])
> -			drm_syncobj_put(syncobj[entry]);
> +	while (entry-- > 0) {
> +		if (syncobj[entry].syncobj)
> +			drm_syncobj_put(syncobj[entry].syncobj);
> +		if (syncobj[entry].chain)
> +			dma_fence_chain_free(syncobj[entry].chain);
> +	}
>   	kfree(syncobj);
> +free_syncobj_points:
> +	kfree(syncobj_points);
>   free_syncobj_handles:
>   	kfree(syncobj_handles);
>   
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 85b3ca14f81e..197ea3bfb559 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -504,6 +504,11 @@ struct drm_amdgpu_userq_signal {
>   	 * @bo_write_handles.
>   	 */
>   	__u32	num_bo_write_handles;
> +	/**
> +	 * @syncobj_points: The list of syncobj points submitted by the user queue job
> +	 * for the corresponding @syncobj_handles.
> +	 */
> +	__u64	syncobj_points;
>   };
>   
>   struct drm_amdgpu_userq_fence_info {
