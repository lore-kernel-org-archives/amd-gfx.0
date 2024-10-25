Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D781D0C5FC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 10:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D529910EA77;
	Fri, 25 Oct 2024 10:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UVMdt6RJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2489E10EA77
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 10:39:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Enica7dRCHY4C3BSAykdswvdM35v7HjwuxZVS69DFIeDDJuKhvfBQGhUyuPw67rq5eYC/maiB3E0KSHKYo6pjat7/+4LjSlTY/KkwZazL9fvLr8B2IZKbfAWbJieoUkosAHx/QxK/gNFxrweLtPD6MXkjd32QCgXXDYUoTkXu9IMjeXnlgrU47pD+gBaQrHqWGqHWOnPnmY2IuCWoVOlLsoyWVbB7yNTt46D1zF6F2vBBHDFs/YEAQpsbGRDKWvs+Wi3MZsgMcLYBGLXQpsYfKupLrYRIpKx4oBMiOclQa02qECjWglcc9d8cLmxf6jb33mbJ+W1rxGeVc5+28eekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xONV4MTN71ZxpNz4nBbiuHzv3CcSMRKTwV/tNtlquQM=;
 b=xejZ/0dFKX/41wLfkkgr02tx4xrec4JiuPQiDMV8gPXp0zEmDAUnLTBCETT+l0WYT04Sa83Hmq7l+6wCWwLjJYhJ1IbUet5BLJEQqsm1pLEgD4F1Tu+b2M3gYzeSFhQb6GnPQG6ZDT0Xh6wgpRPIVrZ+sa7ikpxLj7YNY926KGIPV39Yih/6p2aXA+NzgMdjp4UQeNpqe4+0HHk631IbbipT7Wm/BeHoWY2kAcBCNAMS2B1ntdd31YmX8+iFx317GFmkWOJ+r5deppc1wr85IurMOGYCPhoz8CGeW+BXB/Xr9xiP2tlBvSZ3Sv3GX2M+HWJo9W+vRGsSIqL5bP8qkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xONV4MTN71ZxpNz4nBbiuHzv3CcSMRKTwV/tNtlquQM=;
 b=UVMdt6RJNFqVgbPmtVdaih+/hj++fXHhhVWBoP+/pfGDYm5SuTntsg5iZaeWMqoHiclN/6YpsNNz4jnR3G7cEDSmnCUuH8nuEE18zmMq0mt01ZfUvk9sg9V7cDLsXvqmx5bKlXZN5PaafT77QUTzQQNf0Xrup9zgRXDPQYejV5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 10:39:15 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 10:39:15 +0000
Subject: Re: [PATCH 08/29] drm/amdgpu: pass ip_block in set_clockgating_state
To: boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-9-boyuan.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <b679973e-0081-8f03-ef91-d2918a961700@amd.com>
Date: Fri, 25 Oct 2024 16:09:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241025023545.465886-9-boyuan.zhang@amd.com>
Content-Type: multipart/alternative;
 boundary="------------6E327141A382F00F871FFDE2"
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acfd46c-327d-43f6-8682-08dcf4e1450e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHp6S1BSTS90YTBUcy9YZXc1QTRyTjhVY2pqc2hUOGhrUFM2N2tEcER0dlFZ?=
 =?utf-8?B?cXRnTW5WTzJGcVUzWFVkWnN4RERVdEdtbW51bGJqU0x5Z2pOOUNDa1FJcXM2?=
 =?utf-8?B?clNCbHZManZzUDV0N0NHWTIrdEFuWVZlN1JBMzJoS25ic3BROHRmbjZMMGxp?=
 =?utf-8?B?MnZoSVorcXd4aGRtWENVTG8zcE1tdHcrMjZLNGhRWjB2UVVCMjNBcThMdHF5?=
 =?utf-8?B?ZDc3cnQ5SHUzMWJDTUlWN2haaTd5Vnp6bGZ4NlBCNDd0ZmkrckIrSWFFTFpV?=
 =?utf-8?B?M2hVQm9KRUZHeDAwYnN5QTJNaHBkT0JYckV4dFh4eFlEdXpwb2U3ZHR2ajN6?=
 =?utf-8?B?c2FWMmRJQ0FUMnBhc2VqZ1R0djgwamdPMHAwbVVUdW11N3Y4MDZCZTlzMmFC?=
 =?utf-8?B?VEtOcDV0OFJDSGx4Q1ZuSWJKSi9CaE9OTHVpcGJWNlVvUU91eER4cHJ1T1lR?=
 =?utf-8?B?Lyt5Ni91RTRjWCtDcHFHQ1RMRFhLNkQwYUd6Z0FPeFRIS2NpTEx6b2tHRzJJ?=
 =?utf-8?B?UFd5UUNUV0lmNEhSZTN1anlmbkl6M0l2WExNQXhPQk1aMm5FZFNTWHVvV2Jv?=
 =?utf-8?B?R3pHUCtNVFFtbXJJcUFhc01ub2JmdXV1ZENOanRGMXp6MGZpNGo4Vkc3b2ds?=
 =?utf-8?B?M05WZGhFQyttYm43OWpFMFZnZ01JZWxXY2NHRWgyTVB5NmMvOXZSMUp2bi9t?=
 =?utf-8?B?OUtsOFpraDE0dWhXU1VEdHBoZUxYb05iUU1YdWV2dFhJZWsvUGRtMDFLWXhy?=
 =?utf-8?B?NVp3cmQ5STRhckhUdHNCbnR3aDBSV04yYVFYenhpblhkdDg2ckEwVXFmTUQ1?=
 =?utf-8?B?ZW5iY1o4WDJveWNpeFpaUE44NGR4VXVXWk0vMTNXYk41NVIvVklsT1plUDha?=
 =?utf-8?B?OHpvRVh3L05DL0xBdk1tekF5T1JOdU1wVjJLbS9sYzh2SFRkMjdlVHdWSW9Y?=
 =?utf-8?B?ZkdMeXI2OEorb2lweVAyQTN3aGZDYTBKYU4yNGZlSm9uOElLTzAyT0Y0K25h?=
 =?utf-8?B?cGxOeTA2NGFmL2V1RDZVQ2J2QUI1VGJTT0grTVlkbGt3N045cGVmTERHOTVP?=
 =?utf-8?B?MkljRW5vMXVXNWg5RklOb0M3TzFoY3FPYXd4ZlUrRG1QaVFQaU9nSXVZdDZs?=
 =?utf-8?B?Sm1EY2tpdEdJcnkrenpjVnBiNkNCWVh1YkVFaDZ1Tno0ZU1mb0FSY01qODcr?=
 =?utf-8?B?U2MzYzgzM21lYWFLQUU5bjgyT1I1NU5xL05mZEl0YXRtK2JxV1JZdjM0WCtr?=
 =?utf-8?B?M05nWHZYYlVIeXNaMmhOaDNOSVZnbUF5YndSNlJFMmNUUXpaSTllcDI0YThJ?=
 =?utf-8?B?d3pmYmFYNXpmNlF2bHovVVFyZnR6d3ZEOGtLL2pTZGhXRnRFMWI0VTNOV2Zw?=
 =?utf-8?B?WkR3b1BoWk5ScURNemFxMTlyTlMvU2Z4bEpQdWY0NHdsSGJoa0ZHeEVuYmRZ?=
 =?utf-8?B?Umt1RTJwU3BxaWw0WlVCTmFOT0RwODlNNUs5ZXZpSHRGUXprTGtZbmZmbGlW?=
 =?utf-8?B?NGgxMmhkbnlsT29TdnlQdmVHVldlczU0S01MbUlzS1FEQXdhL1pTcW4zZFRC?=
 =?utf-8?B?a0NQRGJmN3JvTWFVN09maHlXT0tPRVViNVdNeG1GK0dDRlQxQlVOK0xLQlVL?=
 =?utf-8?B?SXVvVlFzUGNHaHFFOW0vb0dYV2JEV2svNEF5TG5Jd3RXSll6bmVSeVZVQjE1?=
 =?utf-8?B?b2NBdVZiRHRBSnJDUk4yTU5sMnNTdVpjWDNYYkhzcFNXZkhqd2E3M1FYMUpP?=
 =?utf-8?Q?qvm+VHnZZOfJ4BQgVNSgIoxhqOJ88J02jloaljK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1qKzBGbHZHanRqZS9wNUJrTXh6QzlERVhtM0RkOStPNjBQV1lLZmMvN2hB?=
 =?utf-8?B?K1ZoYzZJY2Q2OHNHVXpKWU5NNk5iYkdWb1cvWnBZeGJqUXAvM2ttaWxrNnJI?=
 =?utf-8?B?emZoQWF6ODYxbW9DZWV2Y2JsbkxFeFFoSTd2emVuNTdkczJDbjRpQitWWDhn?=
 =?utf-8?B?OU15UmE1UlhVRWEzd2J4eWl2OVAzWEwyeWIzdGpSbkJtbUk0VEF3Z3NNbUh3?=
 =?utf-8?B?aWgrVmdlTUJpSDhzRjlBcTZsUlpmSjd2T2hERDlIcGFkU1Ryb0kvTnl4YmNz?=
 =?utf-8?B?K3BXTzllNi94dytnTFFnY21JbWtOVlJ4ZUJZd0FsMVV4aTVEcXN5R1F4Q0R2?=
 =?utf-8?B?dEt5QTVxWktXN0luVXYxWk8zazRCT2l1TzZJR2MwaWd4L0RMQklzZDI3NkNB?=
 =?utf-8?B?cUR4bVNpV3NXblkwVHRBMGl0S0t2aWJJNW00SmdVQ0ZVUEhiZVRKU1pobVp0?=
 =?utf-8?B?ZCtsNllDT1R0NTJnZmEvVWZDM2tIV1ZYK0JaSStGNkRpeUNNeEtzZ2ZtOVd5?=
 =?utf-8?B?K0EwR1FVNll2aWdOMGxZVHVYWjIydGJBVWNoZTJ6NVhrKytQeVhVZG9EV01x?=
 =?utf-8?B?VFVhMGRuMlEwaTNaSnliM2h0ZjE5V0xLZjBZbU1nYno2YUdoVTNMem16Q2d1?=
 =?utf-8?B?TXBQVHhpWUZjQUJHdGlCUWVOQjhndmZVSTB3bmdBaTRWV1FnUVVnU0hHc1Fp?=
 =?utf-8?B?V3VzR25nR3pyUVFtajdiRXlIL2ozR1Z4MS9Nekl5Y1hvNkpSSDZ4WHJ5L3JU?=
 =?utf-8?B?M09WU3JQVnV3N2dNL2l1NHhocGQ3WFo1VWIyeTJXaTZqSDhHWGh0bk5tVUh0?=
 =?utf-8?B?OTltQmxVSWpieGFDZEh4ZGlObnEyMTBpSy9JdXJpbXV6d05Ja0hvSGpqcHYy?=
 =?utf-8?B?Z0d5cWpndjRXY085cUFvSlR6dVAzUU9iazltU3Q0aW9KVmxrYk1QZkxFSng0?=
 =?utf-8?B?cXVvejFlSytUUUthOGt6c2J3M1Z3Mkh5SnQ2K09IM0hvZWx0WkhMbldnTDVR?=
 =?utf-8?B?M0tYTWpCNTZvTEdOb2NFZjZqV05FRUR1YS9zMHpweHpRaEFPTVhuMmhFUDlG?=
 =?utf-8?B?RFNuVisvelV5dzlyODJtRnVna05oOTFUWWw2WFNTK1ZhU2cwdnRSYTVHUjdO?=
 =?utf-8?B?cndBYWM2NGtWYVFZTEdDNWVpbFV5SitQQ2tzRXlvdFRrZTBHN1JMYUluOEtn?=
 =?utf-8?B?RG10Z29kU1hpWjlWbGowQWpUNHI2dXBOdXJGTHRtZStDNjRNZ3Z1ZDNqSnhj?=
 =?utf-8?B?cC84ZUNTUW9hYW9DTExqZno3TTN1OFVaTUEzTy9IVEpuZjhjdTNJcmVhS21o?=
 =?utf-8?B?ZEdnUDErc1g0cFE3Rm5NVlRJYXEzYmRLV2J6YUFkYm4rY1pxMmhWdGFmM0dS?=
 =?utf-8?B?QTI1TktDUHBHYklxdnJxYndkWk9oQ29Wa0NLNmpJT21qK3dyUHE0MktnMFJV?=
 =?utf-8?B?c3dmSW9IS3liVW5zNllJSW5wNitRaitPSXNxWUU3QmJ2cWtNUVlQSkhkTXNN?=
 =?utf-8?B?MFRiRktWL2VwMlhiTkVxYXl6Ni9ZZjNpKzdIVlErK0dxUFNENUgrNzIxL3RF?=
 =?utf-8?B?N0RndU0yYW53NjR6TFg3M041OW5nSy8ySjZLVW5ldWhxaDkvQTRaVjVlTHNU?=
 =?utf-8?B?NEhNdXJYUE9zdmx2TmVJc0ZvOVZjWTdWS296WnBYVjhNU09SWjFtSzFQSGI0?=
 =?utf-8?B?Vk10YmxDNkdiUUthdHJGMmpYQnRZOUhvaHJ0WHMwanBwWnZCcW1yL21nRHI4?=
 =?utf-8?B?Y3hYQm42dmdOYzY2SVB3aGJGcnU0Vk5OTjBSYnpCTC9NL0ordTl4cTlIUHBG?=
 =?utf-8?B?M2ladGQ0eHZqQTlsRmdDd0NSRG11OW8rTlcyZ0hGUnEzbWNOU3E3RXhDVEtt?=
 =?utf-8?B?YVBWb1VTWGQ5ejRmWFp6L1l5SlEybGtQRjVoRFdpS09wZEhJcmk0YTVzTzV5?=
 =?utf-8?B?RHl4RjhEOFMvall1ZHZkMGt6cVB1bENCZ3FsN1NEUjJEUDYrOWZLeDRaTGtW?=
 =?utf-8?B?KzlhUlUwZjdTa2ZpaTdYSzQrbW8rRm4xNW5QbXdqbkhMaXRIRmlmMDRDazFQ?=
 =?utf-8?B?aTZsSCsrZVpsODM5dnRUb3NuQ1cxUTlNNCs4ZDZEQmgzcjlSWmZ2Tzh3SmI0?=
 =?utf-8?Q?tY6fHXE0LN5E+I+WDwGVn0eTn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acfd46c-327d-43f6-8682-08dcf4e1450e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:39:14.9702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcekjukvHNLUK8bZBw+zRgbrHWQ2VvzdUHbc2hYa1NBLRdvglz1rUFodHjZyF5V8mijQW6u5REcVnD/XBE2K5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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

--------------6E327141A382F00F871FFDE2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com 
<mailto:christian.koenig@amd.com>>

On 10/25/2024 8:05 AM, boyuan.zhang@amd.com wrote:
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass ip_block instead of adev in set_clockgating_state() callback
> functions. Modify set_clockgating_state()for all correspoding ip blocks.
>
> v2: remove all changes for is_idle(), remove type casting
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cik.c                  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c               |  2 +-
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c                |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c           |  2 +-
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/nv.c                   |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/si.c                   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/si_dma.c               |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/si_ih.c                |  2 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/soc21.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/soc24.c                |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 13 ++++---------
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 13 ++++---------
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             |  7 ++++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/vi.c                   |  4 ++--
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>   drivers/gpu/drm/amd/include/amd_shared.h          |  2 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        |  2 +-
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        |  2 +-
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  2 +-
>   82 files changed, 158 insertions(+), 164 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index cdea150c801e..deb0785350e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -584,7 +584,7 @@ static bool acp_is_idle(void *handle)
>   	return true;
>   }
>   
> -static int acp_set_clockgating_state(void *handle,
> +static int acp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f31a6bf9ec2..7c06e3a9146c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2156,7 +2156,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
>   		if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
>   			continue;
>   		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
> -			(void *)adev, state);
> +			&adev->ip_blocks[i], state);
>   		if (r)
>   			DRM_ERROR("set_clockgating_state of IP block <%s> failed %d\n",
>   				  adev->ip_blocks[i].version->funcs->name, r);
> @@ -3128,7 +3128,7 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>   		    adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_JPEG &&
>   		    adev->ip_blocks[i].version->funcs->set_clockgating_state) {
>   			/* enable clockgating to save power */
> -			r = adev->ip_blocks[i].version->funcs->set_clockgating_state((void *)adev,
> +			r = adev->ip_blocks[i].version->funcs->set_clockgating_state(&adev->ip_blocks[i],
>   										     state);
>   			if (r) {
>   				DRM_ERROR("set_clockgating_state(gate) of IP block <%s> failed %d\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> index bc3b5bfc3423..d52f18393970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -128,7 +128,7 @@ static bool isp_is_idle(void *handle)
>   	return true;
>   }
>   
> -static int isp_set_clockgating_state(void *handle,
> +static int isp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 14ff69ea2d88..9da9529980b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3812,7 +3812,7 @@ int psp_config_sq_perfmon(struct psp_context *psp,
>   	return ret;
>   }
>   
> -static int psp_set_clockgating_state(void *handle,
> +static int psp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 1bd804a8fdb5..03308261f894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -632,7 +632,7 @@ static bool amdgpu_vkms_is_idle(void *handle)
>   	return true;
>   }
>   
> -static int amdgpu_vkms_set_clockgating_state(void *handle,
> +static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 17cd1d66a056..0a884215f59b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -638,7 +638,7 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
>   	return r;
>   }
>   
> -static int vpe_set_clockgating_state(void *handle,
> +static int vpe_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
> index b5055181b050..08d6787893b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -2161,7 +2161,7 @@ static int cik_common_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int cik_common_set_clockgating_state(void *handle,
> +static int cik_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> index c49482793c12..444563486769 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> @@ -402,7 +402,7 @@ static int cik_ih_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int cik_ih_set_clockgating_state(void *handle,
> +static int cik_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 8da334c71419..1563e35da0fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -1189,11 +1189,11 @@ static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int cik_sdma_set_clockgating_state(void *handle,
> +static int cik_sdma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	bool gate = false;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_CG_STATE_GATE)
>   		gate = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index 67554e322386..82586b76aeda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -398,7 +398,7 @@ static int cz_ih_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int cz_ih_set_clockgating_state(void *handle,
> +static int cz_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	// TODO
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index cd874f9e9a70..8bc997b66424 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -3302,7 +3302,7 @@ static int dce_v10_0_hpd_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int dce_v10_0_set_clockgating_state(void *handle,
> +static int dce_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index ec908b524f61..504939e3c0c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -3434,7 +3434,7 @@ static int dce_v11_0_hpd_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int dce_v11_0_set_clockgating_state(void *handle,
> +static int dce_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index ee7b69a63f17..a33e33743a93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -3124,7 +3124,7 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device *adev,
>   
>   }
>   
> -static int dce_v6_0_set_clockgating_state(void *handle,
> +static int dce_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index cc4f986bd533..aff58d56864a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -3212,7 +3212,7 @@ static int dce_v8_0_hpd_irq(struct amdgpu_device *adev,
>   
>   }
>   
> -static int dce_v8_0_set_clockgating_state(void *handle,
> +static int dce_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 2a7a77317d90..a2ae696e552f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8377,10 +8377,10 @@ static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -static int gfx_v10_0_set_clockgating_state(void *handle,
> +static int gfx_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 3e9b6b88b6a7..875900f5a9e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5466,10 +5466,10 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -static int gfx_v11_0_set_clockgating_state(void *handle,
> +static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   	        return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 94459162803c..99bdc4ef51df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -4109,10 +4109,10 @@ static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int gfx_v12_0_set_clockgating_state(void *handle,
> +static int gfx_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> index 2e1e8a49c66e..81c185a8b3a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -3373,11 +3373,11 @@ static int gfx_v6_0_priv_inst_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int gfx_v6_0_set_clockgating_state(void *handle,
> +static int gfx_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	bool gate = false;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_CG_STATE_GATE)
>   		gate = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 0124f86f8e63..60931396f76b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4846,11 +4846,11 @@ static int gfx_v7_0_priv_inst_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int gfx_v7_0_set_clockgating_state(void *handle,
> +static int gfx_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	bool gate = false;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_CG_STATE_GATE)
>   		gate = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index f85e545653c7..955359fffb64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5975,10 +5975,10 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int gfx_v8_0_set_clockgating_state(void *handle,
> +static int gfx_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index c6f6907eb363..4e4f182b8b82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5271,10 +5271,10 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -static int gfx_v9_0_set_clockgating_state(void *handle,
> +static int gfx_v9_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index d61f53921723..4184521b2642 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2762,10 +2762,10 @@ static int gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -static int gfx_v9_4_3_set_clockgating_state(void *handle,
> +static int gfx_v9_4_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	int i, num_xcc;
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 738226310690..9bedca9a79c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1088,11 +1088,11 @@ static int gmc_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v10_0_set_clockgating_state(void *handle,
> +static int gmc_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
>   	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	/*
>   	 * The issue mmhub can't disconnect from DF with MMHUB clock gating being disabled
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index b73cd4f9df48..72751ab4c766 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -996,11 +996,11 @@ static int gmc_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v11_0_set_clockgating_state(void *handle,
> +static int gmc_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
>   	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	r = adev->mmhub.funcs->set_clockgating(adev, state);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 0ed26d24fc9b..621769255ffa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -980,11 +980,11 @@ static int gmc_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v12_0_set_clockgating_state(void *handle,
> +static int gmc_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
>   	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	r = adev->mmhub.funcs->set_clockgating(adev, state);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index 8575b0219e8d..8e878ab44e76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -1094,7 +1094,7 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int gmc_v6_0_set_clockgating_state(void *handle,
> +static int gmc_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 3025ac476b52..8f6f2f067641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -1307,11 +1307,11 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int gmc_v7_0_set_clockgating_state(void *handle,
> +static int gmc_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	bool gate = false;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_CG_STATE_GATE)
>   		gate = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 20a6d6e192eb..29ce36038b3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1658,10 +1658,10 @@ static void fiji_update_mc_light_sleep(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int gmc_v8_0_set_clockgating_state(void *handle,
> +static int gmc_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c4918154580a..31cdc624f096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2541,10 +2541,10 @@ static int gmc_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int gmc_v9_0_set_clockgating_state(void *handle,
> +static int gmc_v9_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	adev->mmhub.funcs->set_clockgating(adev, state);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index be3a578596ae..8ac3d3282268 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -392,7 +392,7 @@ static int iceland_ih_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int iceland_ih_set_clockgating_state(void *handle,
> +static int iceland_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index b004dc88cbb0..f8a485164437 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -693,10 +693,10 @@ static void ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int ih_v6_0_set_clockgating_state(void *handle,
> +static int ih_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	ih_v6_0_update_clockgating_state(adev,
>   				state == AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> index 27d9d4965757..dd0042efceec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -674,10 +674,10 @@ static void ih_v6_1_update_clockgating_state(struct amdgpu_device *adev,
>   	return;
>   }
>   
> -static int ih_v6_1_set_clockgating_state(void *handle,
> +static int ih_v6_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	ih_v6_1_update_clockgating_state(adev,
>   				state == AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index d37f5a813007..8f9b15c171f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -664,10 +664,10 @@ static void ih_v7_0_update_clockgating_state(struct amdgpu_device *adev,
>   	return;
>   }
>   
> -static int ih_v7_0_set_clockgating_state(void *handle,
> +static int ih_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	ih_v7_0_update_clockgating_state(adev,
>   				state == AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 38938a624658..1100d832abfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -675,14 +675,14 @@ static int jpeg_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return ret;
>   }
>   
> -static int jpeg_v2_0_set_clockgating_state(void *handle,
> +static int jpeg_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   
>   	if (enable) {
> -		if (!jpeg_v2_0_is_idle(handle))
> +		if (!jpeg_v2_0_is_idle(adev))
>   			return -EBUSY;
>   		jpeg_v2_0_enable_clock_gating(adev);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index a0c0e8bd5978..3d72e383b7df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -518,10 +518,10 @@ static int jpeg_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int jpeg_v2_5_set_clockgating_state(void *handle,
> +static int jpeg_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   	int i;
>   
> @@ -530,7 +530,7 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
>   			continue;
>   
>   		if (enable) {
> -			if (!jpeg_v2_5_is_idle(handle))
> +			if (!jpeg_v2_5_is_idle(adev))
>   				return -EBUSY;
>   			jpeg_v2_5_enable_clock_gating(adev, i);
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 057e0c043de5..200403a07d34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -466,14 +466,14 @@ static int jpeg_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>   }
>   
> -static int jpeg_v3_0_set_clockgating_state(void *handle,
> +static int jpeg_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
>   
>   	if (enable) {
> -		if (!jpeg_v3_0_is_idle(handle))
> +		if (!jpeg_v3_0_is_idle(adev))
>   			return -EBUSY;
>   		jpeg_v3_0_enable_clock_gating(adev);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index 7a79fac9962c..0a4939895b6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -628,14 +628,14 @@ static int jpeg_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>   }
>   
> -static int jpeg_v4_0_set_clockgating_state(void *handle,
> +static int jpeg_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
>   
>   	if (enable) {
> -		if (!jpeg_v4_0_is_idle(handle))
> +		if (!jpeg_v4_0_is_idle(adev))
>   			return -EBUSY;
>   		jpeg_v4_0_enable_clock_gating(adev);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 30ab807be2bc..7dfbaaf260a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -941,16 +941,16 @@ static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return ret;
>   }
>   
> -static int jpeg_v4_0_3_set_clockgating_state(void *handle,
> +static int jpeg_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
>   	int i;
>   
>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>   		if (enable) {
> -			if (!jpeg_v4_0_3_is_idle(handle))
> +			if (!jpeg_v4_0_3_is_idle(adev))
>   				return -EBUSY;
>   			jpeg_v4_0_3_enable_clock_gating(adev, i);
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 2b25e8f71f4e..d89863213ae7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -652,10 +652,10 @@ static int jpeg_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int jpeg_v4_0_5_set_clockgating_state(void *handle,
> +static int jpeg_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>   	int i;
>   
> @@ -664,7 +664,7 @@ static int jpeg_v4_0_5_set_clockgating_state(void *handle,
>   			continue;
>   
>   		if (enable) {
> -			if (!jpeg_v4_0_5_is_idle(handle))
> +			if (!jpeg_v4_0_5_is_idle(adev))
>   				return -EBUSY;
>   
>   			jpeg_v4_0_5_enable_clock_gating(adev, i);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index c870f1a361ef..09eaf7f07710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -553,14 +553,14 @@ static int jpeg_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
>   }
>   
> -static int jpeg_v5_0_0_set_clockgating_state(void *handle,
> +static int jpeg_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>   
>   	if (enable) {
> -		if (!jpeg_v5_0_0_is_idle(handle))
> +		if (!jpeg_v5_0_0_is_idle(adev))
>   			return -EBUSY;
>   		jpeg_v5_0_0_enable_clock_gating(adev);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index f51b5dae3701..ebc2ab9c3c5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -667,10 +667,10 @@ static void navi10_ih_update_clockgating_state(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int navi10_ih_set_clockgating_state(void *handle,
> +static int navi10_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	navi10_ih_update_clockgating_state(adev,
>   				state == AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 5332e510bced..ffc5b55ec841 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1039,10 +1039,10 @@ static bool nv_common_is_idle(void *handle)
>   	return true;
>   }
>   
> -static int nv_common_set_clockgating_state(void *handle,
> +static int nv_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index 0c32e614d8e0..c6af318908e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -1080,7 +1080,7 @@ static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int sdma_v2_4_set_clockgating_state(void *handle,
> +static int sdma_v2_4_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	/* XXX handled via the smc on VI */
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 18f29e2be828..d438f2f7a408 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1483,10 +1483,10 @@ static void sdma_v3_0_update_sdma_medium_grain_light_sleep(
>   	}
>   }
>   
> -static int sdma_v3_0_set_clockgating_state(void *handle,
> +static int sdma_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index a2f5f2be699b..defabd163d17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2297,10 +2297,10 @@ static void sdma_v4_0_update_medium_grain_light_sleep(
>   	}
>   }
>   
> -static int sdma_v4_0_set_clockgating_state(void *handle,
> +static int sdma_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 95d5de2bd186..7e23caca8813 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1505,7 +1505,7 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int sdma_v4_4_2_set_clockgating_state(void *handle,
> +static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					     enum amd_clockgating_state state);
>   
>   static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
> @@ -1513,7 +1513,7 @@ static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_in_reset(adev))
> -		sdma_v4_4_2_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
> +		sdma_v4_4_2_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
>   
>   	return sdma_v4_4_2_hw_fini(ip_block);
>   }
> @@ -1812,10 +1812,10 @@ static void sdma_v4_4_2_inst_update_medium_grain_clock_gating(
>   	}
>   }
>   
> -static int sdma_v4_4_2_set_clockgating_state(void *handle,
> +static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	uint32_t inst_mask;
>   
>   	if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 9ee5318be89e..afff8a6e8eb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1835,10 +1835,10 @@ static void sdma_v5_0_update_medium_grain_light_sleep(struct amdgpu_device *adev
>   	}
>   }
>   
> -static int sdma_v5_0_set_clockgating_state(void *handle,
> +static int sdma_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index bd883a35c7eb..e282fd8de9a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1789,10 +1789,10 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>   	}
>   }
>   
> -static int sdma_v5_2_set_clockgating_state(void *handle,
> +static int sdma_v5_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 34106702e0ca..8fc70b9d8f81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1588,7 +1588,7 @@ static int sdma_v6_0_process_illegal_inst_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int sdma_v6_0_set_clockgating_state(void *handle,
> +static int sdma_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 1a5fc7bc7289..eb35ec9f3da2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1524,7 +1524,7 @@ static int sdma_v7_0_process_illegal_inst_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int sdma_v7_0_set_clockgating_state(void *handle,
> +static int sdma_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index e32615630cca..77ef7da2e4fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -2649,7 +2649,7 @@ static bool si_common_is_idle(void *handle)
>   	return true;
>   }
>   
> -static int si_common_set_clockgating_state(void *handle,
> +static int si_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 4b278904cfd9..9f62b2b7fe0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -629,13 +629,13 @@ static int si_dma_process_trap_irq(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int si_dma_set_clockgating_state(void *handle,
> +static int si_dma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	u32 orig, data, offset;
>   	int i;
>   	bool enable;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	enable = (state == AMD_CG_STATE_GATE);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> index ec756d24aaa7..a32b6243c1f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> @@ -263,7 +263,7 @@ static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int si_ih_set_clockgating_state(void *handle,
> +static int si_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8c100db42d4e..029d4173a16c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1385,10 +1385,10 @@ static void soc15_update_drm_light_sleep(struct amdgpu_device *adev, bool enable
>   		WREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_LIGHT_SLEEP_CTRL), data);
>   }
>   
> -static int soc15_common_set_clockgating_state(void *handle,
> +static int soc15_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 7556055b8387..eea3df5ad1e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -927,10 +927,10 @@ static bool soc21_common_is_idle(void *handle)
>   	return true;
>   }
>   
> -static int soc21_common_set_clockgating_state(void *handle,
> +static int soc21_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>   	case IP_VERSION(4, 3, 0):
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index 2a408bc65f73..59d5e2f31c39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -522,10 +522,10 @@ static bool soc24_common_is_idle(void *handle)
>   	return true;
>   }
>   
> -static int soc24_common_set_clockgating_state(void *handle,
> +static int soc24_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					      enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>   	case IP_VERSION(6, 3, 1):
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index 7c02eb0e1540..0968e551f7b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -448,7 +448,7 @@ static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int tonga_ih_set_clockgating_state(void *handle,
> +static int tonga_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index c66fe0c8d5e9..5830e799c0a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -790,7 +790,7 @@ static int uvd_v3_1_soft_reset(struct amdgpu_ip_block *ip_block)
>   	return uvd_v3_1_start(adev);
>   }
>   
> -static int uvd_v3_1_set_clockgating_state(void *handle,
> +static int uvd_v3_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 1f3da607c0d6..f93079e09215 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -44,7 +44,7 @@ static void uvd_v4_2_set_ring_funcs(struct amdgpu_device *adev);
>   static void uvd_v4_2_set_irq_funcs(struct amdgpu_device *adev);
>   static int uvd_v4_2_start(struct amdgpu_device *adev);
>   static void uvd_v4_2_stop(struct amdgpu_device *adev);
> -static int uvd_v4_2_set_clockgating_state(void *handle,
> +static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_clockgating_state state);
>   static void uvd_v4_2_set_dcm(struct amdgpu_device *adev,
>   			     bool sw_mode);
> @@ -708,7 +708,7 @@ static int uvd_v4_2_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int uvd_v4_2_set_clockgating_state(void *handle,
> +static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index 50577cc79dcb..050a0f309390 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -42,7 +42,7 @@ static void uvd_v5_0_set_ring_funcs(struct amdgpu_device *adev);
>   static void uvd_v5_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int uvd_v5_0_start(struct amdgpu_device *adev);
>   static void uvd_v5_0_stop(struct amdgpu_device *adev);
> -static int uvd_v5_0_set_clockgating_state(void *handle,
> +static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state);
>   static void uvd_v5_0_enable_mgcg(struct amdgpu_device *adev,
>   				 bool enable);
> @@ -155,7 +155,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	int r;
>   
>   	amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
> -	uvd_v5_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
> +	uvd_v5_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
>   	uvd_v5_0_enable_mgcg(adev, true);
>   
>   	r = amdgpu_ring_test_helper(ring);
> @@ -790,16 +790,11 @@ static void uvd_v5_0_enable_mgcg(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int uvd_v5_0_set_clockgating_state(void *handle,
> +static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
> -	struct amdgpu_ip_block *ip_block;
> -
> -	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD);
> -	if (!ip_block)
> -		return -EINVAL;
>   
>   	if (enable) {
>   		/* wait for STATUS to clear */
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 4f5dc46802e2..d9d036ee51fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -48,7 +48,7 @@ static void uvd_v6_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int uvd_v6_0_start(struct amdgpu_device *adev);
>   static void uvd_v6_0_stop(struct amdgpu_device *adev);
>   static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *adev);
> -static int uvd_v6_0_set_clockgating_state(void *handle,
> +static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state);
>   static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
>   				 bool enable);
> @@ -467,7 +467,7 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
>   	int i, r;
>   
>   	amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
> -	uvd_v6_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
> +	uvd_v6_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
>   	uvd_v6_0_enable_mgcg(adev, true);
>   
>   	r = amdgpu_ring_test_helper(ring);
> @@ -1450,17 +1450,12 @@ static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int uvd_v6_0_set_clockgating_state(void *handle,
> +static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	struct amdgpu_ip_block *ip_block;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   
> -	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD);
> -	if (!ip_block)
> -		return -EINVAL;
> -
>   	if (enable) {
>   		/* wait for STATUS to clear */
>   		if (uvd_v6_0_wait_for_idle(ip_block))
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 079131aeb2f7..53249d4ff8ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -1511,7 +1511,7 @@ static int uvd_v7_0_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int uvd_v7_0_set_clockgating_state(void *handle,
> +static int uvd_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	/* needed for driver unload*/
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 552866990db2..c633b7ff2943 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -578,13 +578,13 @@ static int vce_v2_0_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int vce_v2_0_set_clockgating_state(void *handle,
> +static int vce_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	bool gate = false;
>   	bool sw_cg = false;
>   
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (state == AMD_CG_STATE_GATE) {
>   		gate = true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 6f4a2476b9fd..f8bddcd19b68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -65,7 +65,7 @@ static void vce_v3_0_mc_resume(struct amdgpu_device *adev, int idx);
>   static void vce_v3_0_set_ring_funcs(struct amdgpu_device *adev);
>   static void vce_v3_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
> -static int vce_v3_0_set_clockgating_state(void *handle,
> +static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state);
>   /**
>    * vce_v3_0_ring_get_rptr - get read pointer
> @@ -497,7 +497,7 @@ static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	vce_v3_0_stop(adev);
> -	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
> +	return vce_v3_0_set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
>   }
>   
>   static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
> @@ -760,10 +760,10 @@ static int vce_v3_0_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int vce_v3_0_set_clockgating_state(void *handle,
> +static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   	int i;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 04bfa3b59f75..335bda64ff5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -684,7 +684,7 @@ static void vce_v4_0_mc_resume(struct amdgpu_device *adev)
>   			~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
>   }
>   
> -static int vce_v4_0_set_clockgating_state(void *handle,
> +static int vce_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	/* needed for driver unload*/
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 32b0159953f3..00d9fdd2869e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1395,15 +1395,15 @@ static int vcn_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return ret;
>   }
>   
> -static int vcn_v1_0_set_clockgating_state(void *handle,
> +static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   
>   	if (enable) {
>   		/* wait for STATUS to clear */
> -		if (!vcn_v1_0_is_idle(handle))
> +		if (!vcn_v1_0_is_idle(adev))
>   			return -EBUSY;
>   		vcn_v1_0_enable_clock_gating(adev);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 798d06563c65..de4067713d7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1335,10 +1335,10 @@ static int vcn_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return ret;
>   }
>   
> -static int vcn_v2_0_set_clockgating_state(void *handle,
> +static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -1346,7 +1346,7 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
>   
>   	if (enable) {
>   		/* wait for STATUS to clear */
> -		if (!vcn_v2_0_is_idle(handle))
> +		if (!vcn_v2_0_is_idle(adev))
>   			return -EBUSY;
>   		vcn_v2_0_enable_clock_gating(adev);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index d00406e057d7..08f43a281a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1782,6 +1782,7 @@ static bool vcn_v2_5_is_idle(void *handle)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> +
>   		ret &= (RREG32_SOC15(VCN, i, mmUVD_STATUS) == UVD_STATUS__IDLE);
>   	}
>   
> @@ -1805,17 +1806,17 @@ static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return ret;
>   }
>   
> -static int vcn_v2_5_set_clockgating_state(void *handle,
> +static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE);
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
>   	if (enable) {
> -		if (!vcn_v2_5_is_idle(handle))
> +		if (!vcn_v2_5_is_idle(adev))
>   			return -EBUSY;
>   		vcn_v2_5_enable_clock_gating(adev);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index d761bc7c31bc..6002990d917b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -2136,10 +2136,10 @@ static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return ret;
>   }
>   
> -static int vcn_v3_0_set_clockgating_state(void *handle,
> +static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 8c1d9afa81ff..2c36f748176f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -2007,9 +2007,10 @@ static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>    *
>    * Set VCN block clockgating state
>    */
> -static int vcn_v4_0_set_clockgating_state(void *handle, enum amd_clockgating_state state)
> +static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 4ac6ee75b27d..eda67585768f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1560,7 +1560,7 @@ static bool vcn_v4_0_3_is_idle(void *handle)
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) ==
> -			UVD_STATUS__IDLE);
> +                       UVD_STATUS__IDLE);
>   	}
>   
>   	return ret;
> @@ -1595,10 +1595,10 @@ static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
>    *
>    * Set VCN block clockgating state
>    */
> -static int vcn_v4_0_3_set_clockgating_state(void *handle,
> +static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = state == AMD_CG_STATE_GATE;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 13c0fc9f9894..f24e1eef6606 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1501,9 +1501,10 @@ static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
>    *
>    * Set VCN block clockgating state
>    */
> -static int vcn_v4_0_5_set_clockgating_state(void *handle, enum amd_clockgating_state state)
> +static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 9d16747484c8..8ccd054975a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1228,9 +1228,10 @@ static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
>    *
>    * Set VCN block clockgating state
>    */
> -static int vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_state state)
> +static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 039f1ae2df02..378da889e075 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -605,10 +605,10 @@ static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int vega10_ih_set_clockgating_state(void *handle,
> +static int vega10_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	vega10_ih_update_clockgating_state(adev,
>   				state == AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index a8e88c9f6ae5..87a530bbc092 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -697,10 +697,10 @@ static void vega20_ih_update_clockgating_state(struct amdgpu_device *adev,
>   	}
>   }
>   
> -static int vega20_ih_set_clockgating_state(void *handle,
> +static int vega20_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	vega20_ih_update_clockgating_state(adev,
>   				state == AMD_CG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
> index 471a66dad9b9..4180e5e671cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1945,10 +1945,10 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
>   	return 0;
>   }
>   
> -static int vi_common_set_clockgating_state(void *handle,
> +static int vi_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					   enum amd_clockgating_state state)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fbdfe37cb93e..7790d2cdd71c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -955,7 +955,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>   	}
>   }
>   
> -static int dm_set_clockgating_state(void *handle,
> +static int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   		  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 0f20abbfd381..98d9e840b0e2 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -401,7 +401,7 @@ struct amd_ip_funcs {
>   	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
>   	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
>   	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
> -	int (*set_clockgating_state)(void *handle,
> +	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
>   				     enum amd_clockgating_state state);
>   	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
>   				     enum amd_powergating_state state);
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> index bb8b0799ab7c..67a8e22b1126 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -3177,7 +3177,7 @@ static int kv_dpm_process_interrupt(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -static int kv_dpm_set_clockgating_state(void *handle,
> +static int kv_dpm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index ed8f755e9ff6..2bed85ba835e 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7849,7 +7849,7 @@ static int si_dpm_wait_for_idle(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> -static int si_dpm_set_clockgating_state(void *handle,
> +static int si_dpm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index a3d1c5aa3b3e..686345f75f26 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -267,7 +267,7 @@ static int pp_resume(struct amdgpu_ip_block *ip_block)
>   	return hwmgr_resume(hwmgr);
>   }
>   
> -static int pp_set_clockgating_state(void *handle,
> +static int pp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_clockgating_state state)
>   {
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8d07757adf04..6f2b8ef07a41 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2192,7 +2192,7 @@ static int smu_display_configuration_change(void *handle,
>   	return 0;
>   }
>   
> -static int smu_set_clockgating_state(void *handle,
> +static int smu_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   				     enum amd_clockgating_state state)
>   {
>   	return 0;

--------------6E327141A382F00F871FFDE2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <p>
    </p>
    <p>Reviewed-by: Sunil Khatri &lt;<a href="mailto:christian.koenig@amd.com">sunil.khatri@amd.com</a>&gt;</p>
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;}
</style>
<![endif]--></p>
    <div class="moz-cite-prefix">On 10/25/2024 8:05 AM,
      <a class="moz-txt-link-abbreviated" href="mailto:boyuan.zhang@amd.com">boyuan.zhang@amd.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241025023545.465886-9-boyuan.zhang@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>

Pass ip_block instead of adev in set_clockgating_state() callback
functions. Modify set_clockgating_state()for all correspoding ip blocks.

v2: remove all changes for is_idle(), remove type casting

Signed-off-by: Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:boyuan.zhang@amd.com">&lt;boyuan.zhang@amd.com&gt;</a>
Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                  |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c           |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c          |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c          |  6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c          |  6 +++---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/nv.c                   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c               |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si_ih.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc24.c                |  4 ++--
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             | 13 ++++---------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c             |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c             |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c             |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c             |  5 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c           |  5 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c           |  5 +++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vi.c                   |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h          |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c        |  2 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c         |  2 +-
 82 files changed, 158 insertions(+), 164 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index cdea150c801e..deb0785350e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -584,7 +584,7 @@ static bool acp_is_idle(void *handle)
 	return true;
 }
 
-static int acp_set_clockgating_state(void *handle,
+static int acp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f31a6bf9ec2..7c06e3a9146c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2156,7 +2156,7 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 		if (!adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_clockgating_state)
 			continue;
 		r = adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_clockgating_state(
-			(void *)adev, state);
+			&amp;adev-&gt;ip_blocks[i], state);
 		if (r)
 			DRM_ERROR(&quot;set_clockgating_state of IP block &lt;%s&gt; failed %d\n&quot;,
 				  adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);
@@ -3128,7 +3128,7 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
 		    adev-&gt;ip_blocks[i].version-&gt;type != AMD_IP_BLOCK_TYPE_JPEG &amp;&amp;
 		    adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_clockgating_state) {
 			/* enable clockgating to save power */
-			r = adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_clockgating_state((void *)adev,
+			r = adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;set_clockgating_state(&amp;adev-&gt;ip_blocks[i],
 										     state);
 			if (r) {
 				DRM_ERROR(&quot;set_clockgating_state(gate) of IP block &lt;%s&gt; failed %d\n&quot;,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index bc3b5bfc3423..d52f18393970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -128,7 +128,7 @@ static bool isp_is_idle(void *handle)
 	return true;
 }
 
-static int isp_set_clockgating_state(void *handle,
+static int isp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 14ff69ea2d88..9da9529980b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3812,7 +3812,7 @@ int psp_config_sq_perfmon(struct psp_context *psp,
 	return ret;
 }
 
-static int psp_set_clockgating_state(void *handle,
+static int psp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 1bd804a8fdb5..03308261f894 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -632,7 +632,7 @@ static bool amdgpu_vkms_is_idle(void *handle)
 	return true;
 }
 
-static int amdgpu_vkms_set_clockgating_state(void *handle,
+static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 17cd1d66a056..0a884215f59b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -638,7 +638,7 @@ static int vpe_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int vpe_set_clockgating_state(void *handle,
+static int vpe_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index b5055181b050..08d6787893b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -2161,7 +2161,7 @@ static int cik_common_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_common_set_clockgating_state(void *handle,
+static int cik_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index c49482793c12..444563486769 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -402,7 +402,7 @@ static int cik_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cik_ih_set_clockgating_state(void *handle,
+static int cik_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 8da334c71419..1563e35da0fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1189,11 +1189,11 @@ static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int cik_sdma_set_clockgating_state(void *handle,
+static int cik_sdma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 67554e322386..82586b76aeda 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -398,7 +398,7 @@ static int cz_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int cz_ih_set_clockgating_state(void *handle,
+static int cz_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	// TODO
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index cd874f9e9a70..8bc997b66424 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -3302,7 +3302,7 @@ static int dce_v10_0_hpd_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v10_0_set_clockgating_state(void *handle,
+static int dce_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index ec908b524f61..504939e3c0c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3434,7 +3434,7 @@ static int dce_v11_0_hpd_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int dce_v11_0_set_clockgating_state(void *handle,
+static int dce_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index ee7b69a63f17..a33e33743a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -3124,7 +3124,7 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device *adev,
 
 }
 
-static int dce_v6_0_set_clockgating_state(void *handle,
+static int dce_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index cc4f986bd533..aff58d56864a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -3212,7 +3212,7 @@ static int dce_v8_0_hpd_irq(struct amdgpu_device *adev,
 
 }
 
-static int dce_v8_0_set_clockgating_state(void *handle,
+static int dce_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2a7a77317d90..a2ae696e552f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8377,10 +8377,10 @@ static int gfx_v10_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v10_0_set_clockgating_state(void *handle,
+static int gfx_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3e9b6b88b6a7..875900f5a9e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5466,10 +5466,10 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v11_0_set_clockgating_state(void *handle,
+static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 	        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 94459162803c..99bdc4ef51df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4109,10 +4109,10 @@ static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v12_0_set_clockgating_state(void *handle,
+static int gfx_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 2e1e8a49c66e..81c185a8b3a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3373,11 +3373,11 @@ static int gfx_v6_0_priv_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v6_0_set_clockgating_state(void *handle,
+static int gfx_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0124f86f8e63..60931396f76b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4846,11 +4846,11 @@ static int gfx_v7_0_priv_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v7_0_set_clockgating_state(void *handle,
+static int gfx_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index f85e545653c7..955359fffb64 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5975,10 +5975,10 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gfx_v8_0_set_clockgating_state(void *handle,
+static int gfx_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c6f6907eb363..4e4f182b8b82 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5271,10 +5271,10 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v9_0_set_clockgating_state(void *handle,
+static int gfx_v9_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d61f53921723..4184521b2642 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2762,10 +2762,10 @@ static int gfx_v9_4_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int gfx_v9_4_3_set_clockgating_state(void *handle,
+static int gfx_v9_4_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i, num_xcc;
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 738226310690..9bedca9a79c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1088,11 +1088,11 @@ static int gmc_v10_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v10_0_set_clockgating_state(void *handle,
+static int gmc_v10_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	/*
 	 * The issue mmhub can't disconnect from DF with MMHUB clock gating being disabled
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index b73cd4f9df48..72751ab4c766 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -996,11 +996,11 @@ static int gmc_v11_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v11_0_set_clockgating_state(void *handle,
+static int gmc_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	r = adev-&gt;mmhub.funcs-&gt;set_clockgating(adev, state);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 0ed26d24fc9b..621769255ffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -980,11 +980,11 @@ static int gmc_v12_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v12_0_set_clockgating_state(void *handle,
+static int gmc_v12_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	r = adev-&gt;mmhub.funcs-&gt;set_clockgating(adev, state);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 8575b0219e8d..8e878ab44e76 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1094,7 +1094,7 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gmc_v6_0_set_clockgating_state(void *handle,
+static int gmc_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 3025ac476b52..8f6f2f067641 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1307,11 +1307,11 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gmc_v7_0_set_clockgating_state(void *handle,
+static int gmc_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_CG_STATE_GATE)
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 20a6d6e192eb..29ce36038b3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1658,10 +1658,10 @@ static void fiji_update_mc_light_sleep(struct amdgpu_device *adev,
 	}
 }
 
-static int gmc_v8_0_set_clockgating_state(void *handle,
+static int gmc_v8_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c4918154580a..31cdc624f096 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2541,10 +2541,10 @@ static int gmc_v9_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int gmc_v9_0_set_clockgating_state(void *handle,
+static int gmc_v9_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	adev-&gt;mmhub.funcs-&gt;set_clockgating(adev, state);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index be3a578596ae..8ac3d3282268 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -392,7 +392,7 @@ static int iceland_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int iceland_ih_set_clockgating_state(void *handle,
+static int iceland_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index b004dc88cbb0..f8a485164437 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -693,10 +693,10 @@ static void ih_v6_0_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int ih_v6_0_set_clockgating_state(void *handle,
+static int ih_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	ih_v6_0_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
index 27d9d4965757..dd0042efceec 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
@@ -674,10 +674,10 @@ static void ih_v6_1_update_clockgating_state(struct amdgpu_device *adev,
 	return;
 }
 
-static int ih_v6_1_set_clockgating_state(void *handle,
+static int ih_v6_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	ih_v6_1_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index d37f5a813007..8f9b15c171f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -664,10 +664,10 @@ static void ih_v7_0_update_clockgating_state(struct amdgpu_device *adev,
 	return;
 }
 
-static int ih_v7_0_set_clockgating_state(void *handle,
+static int ih_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	ih_v7_0_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 38938a624658..1100d832abfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -675,14 +675,14 @@ static int jpeg_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int jpeg_v2_0_set_clockgating_state(void *handle,
+static int jpeg_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
-		if (!jpeg_v2_0_is_idle(handle))
+		if (!jpeg_v2_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v2_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index a0c0e8bd5978..3d72e383b7df 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -518,10 +518,10 @@ static int jpeg_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int jpeg_v2_5_set_clockgating_state(void *handle,
+static int jpeg_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 	int i;
 
@@ -530,7 +530,7 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
 			continue;
 
 		if (enable) {
-			if (!jpeg_v2_5_is_idle(handle))
+			if (!jpeg_v2_5_is_idle(adev))
 				return -EBUSY;
 			jpeg_v2_5_enable_clock_gating(adev, i);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 057e0c043de5..200403a07d34 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -466,14 +466,14 @@ static int jpeg_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 }
 
-static int jpeg_v3_0_set_clockgating_state(void *handle,
+static int jpeg_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 
 	if (enable) {
-		if (!jpeg_v3_0_is_idle(handle))
+		if (!jpeg_v3_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v3_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 7a79fac9962c..0a4939895b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -628,14 +628,14 @@ static int jpeg_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 }
 
-static int jpeg_v4_0_set_clockgating_state(void *handle,
+static int jpeg_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 
 	if (enable) {
-		if (!jpeg_v4_0_is_idle(handle))
+		if (!jpeg_v4_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v4_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 30ab807be2bc..7dfbaaf260a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -941,16 +941,16 @@ static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int jpeg_v4_0_3_set_clockgating_state(void *handle,
+static int jpeg_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
 	for (i = 0; i &lt; adev-&gt;jpeg.num_jpeg_inst; ++i) {
 		if (enable) {
-			if (!jpeg_v4_0_3_is_idle(handle))
+			if (!jpeg_v4_0_3_is_idle(adev))
 				return -EBUSY;
 			jpeg_v4_0_3_enable_clock_gating(adev, i);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 2b25e8f71f4e..d89863213ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -652,10 +652,10 @@ static int jpeg_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int jpeg_v4_0_5_set_clockgating_state(void *handle,
+static int jpeg_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 	int i;
 
@@ -664,7 +664,7 @@ static int jpeg_v4_0_5_set_clockgating_state(void *handle,
 			continue;
 
 		if (enable) {
-			if (!jpeg_v4_0_5_is_idle(handle))
+			if (!jpeg_v4_0_5_is_idle(adev))
 				return -EBUSY;
 
 			jpeg_v4_0_5_enable_clock_gating(adev, i);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index c870f1a361ef..09eaf7f07710 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -553,14 +553,14 @@ static int jpeg_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 		UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 }
 
-static int jpeg_v5_0_0_set_clockgating_state(void *handle,
+static int jpeg_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 
 	if (enable) {
-		if (!jpeg_v5_0_0_is_idle(handle))
+		if (!jpeg_v5_0_0_is_idle(adev))
 			return -EBUSY;
 		jpeg_v5_0_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f51b5dae3701..ebc2ab9c3c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -667,10 +667,10 @@ static void navi10_ih_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int navi10_ih_set_clockgating_state(void *handle,
+static int navi10_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	navi10_ih_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5332e510bced..ffc5b55ec841 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1039,10 +1039,10 @@ static bool nv_common_is_idle(void *handle)
 	return true;
 }
 
-static int nv_common_set_clockgating_state(void *handle,
+static int nv_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 0c32e614d8e0..c6af318908e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -1080,7 +1080,7 @@ static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v2_4_set_clockgating_state(void *handle,
+static int sdma_v2_4_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	/* XXX handled via the smc on VI */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 18f29e2be828..d438f2f7a408 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1483,10 +1483,10 @@ static void sdma_v3_0_update_sdma_medium_grain_light_sleep(
 	}
 }
 
-static int sdma_v3_0_set_clockgating_state(void *handle,
+static int sdma_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index a2f5f2be699b..defabd163d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2297,10 +2297,10 @@ static void sdma_v4_0_update_medium_grain_light_sleep(
 	}
 }
 
-static int sdma_v4_0_set_clockgating_state(void *handle,
+static int sdma_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 95d5de2bd186..7e23caca8813 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1505,7 +1505,7 @@ static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v4_4_2_set_clockgating_state(void *handle,
+static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					     enum amd_clockgating_state state);
 
 static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
@@ -1513,7 +1513,7 @@ static int sdma_v4_4_2_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_in_reset(adev))
-		sdma_v4_4_2_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
+		sdma_v4_4_2_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
 
 	return sdma_v4_4_2_hw_fini(ip_block);
 }
@@ -1812,10 +1812,10 @@ static void sdma_v4_4_2_inst_update_medium_grain_clock_gating(
 	}
 }
 
-static int sdma_v4_4_2_set_clockgating_state(void *handle,
+static int sdma_v4_4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	uint32_t inst_mask;
 
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9ee5318be89e..afff8a6e8eb5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1835,10 +1835,10 @@ static void sdma_v5_0_update_medium_grain_light_sleep(struct amdgpu_device *adev
 	}
 }
 
-static int sdma_v5_0_set_clockgating_state(void *handle,
+static int sdma_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bd883a35c7eb..e282fd8de9a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1789,10 +1789,10 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 	}
 }
 
-static int sdma_v5_2_set_clockgating_state(void *handle,
+static int sdma_v5_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 34106702e0ca..8fc70b9d8f81 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1588,7 +1588,7 @@ static int sdma_v6_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v6_0_set_clockgating_state(void *handle,
+static int sdma_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 1a5fc7bc7289..eb35ec9f3da2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1524,7 +1524,7 @@ static int sdma_v7_0_process_illegal_inst_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int sdma_v7_0_set_clockgating_state(void *handle,
+static int sdma_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e32615630cca..77ef7da2e4fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2649,7 +2649,7 @@ static bool si_common_is_idle(void *handle)
 	return true;
 }
 
-static int si_common_set_clockgating_state(void *handle,
+static int si_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 4b278904cfd9..9f62b2b7fe0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -629,13 +629,13 @@ static int si_dma_process_trap_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int si_dma_set_clockgating_state(void *handle,
+static int si_dma_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	u32 orig, data, offset;
 	int i;
 	bool enable;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	enable = (state == AMD_CG_STATE_GATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index ec756d24aaa7..a32b6243c1f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -263,7 +263,7 @@ static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_ih_set_clockgating_state(void *handle,
+static int si_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c100db42d4e..029d4173a16c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1385,10 +1385,10 @@ static void soc15_update_drm_light_sleep(struct amdgpu_device *adev, bool enable
 		WREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_LIGHT_SLEEP_CTRL), data);
 }
 
-static int soc15_common_set_clockgating_state(void *handle,
+static int soc15_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 7556055b8387..eea3df5ad1e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -927,10 +927,10 @@ static bool soc21_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc21_common_set_clockgating_state(void *handle,
+static int soc21_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(4, 3, 0):
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 2a408bc65f73..59d5e2f31c39 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -522,10 +522,10 @@ static bool soc24_common_is_idle(void *handle)
 	return true;
 }
 
-static int soc24_common_set_clockgating_state(void *handle,
+static int soc24_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(6, 3, 1):
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 7c02eb0e1540..0968e551f7b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -448,7 +448,7 @@ static int tonga_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int tonga_ih_set_clockgating_state(void *handle,
+static int tonga_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index c66fe0c8d5e9..5830e799c0a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -790,7 +790,7 @@ static int uvd_v3_1_soft_reset(struct amdgpu_ip_block *ip_block)
 	return uvd_v3_1_start(adev);
 }
 
-static int uvd_v3_1_set_clockgating_state(void *handle,
+static int uvd_v3_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 1f3da607c0d6..f93079e09215 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -44,7 +44,7 @@ static void uvd_v4_2_set_ring_funcs(struct amdgpu_device *adev);
 static void uvd_v4_2_set_irq_funcs(struct amdgpu_device *adev);
 static int uvd_v4_2_start(struct amdgpu_device *adev);
 static void uvd_v4_2_stop(struct amdgpu_device *adev);
-static int uvd_v4_2_set_clockgating_state(void *handle,
+static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_clockgating_state state);
 static void uvd_v4_2_set_dcm(struct amdgpu_device *adev,
 			     bool sw_mode);
@@ -708,7 +708,7 @@ static int uvd_v4_2_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int uvd_v4_2_set_clockgating_state(void *handle,
+static int uvd_v4_2_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 50577cc79dcb..050a0f309390 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -42,7 +42,7 @@ static void uvd_v5_0_set_ring_funcs(struct amdgpu_device *adev);
 static void uvd_v5_0_set_irq_funcs(struct amdgpu_device *adev);
 static int uvd_v5_0_start(struct amdgpu_device *adev);
 static void uvd_v5_0_stop(struct amdgpu_device *adev);
-static int uvd_v5_0_set_clockgating_state(void *handle,
+static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state);
 static void uvd_v5_0_enable_mgcg(struct amdgpu_device *adev,
 				 bool enable);
@@ -155,7 +155,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
-	uvd_v5_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
+	uvd_v5_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
 	uvd_v5_0_enable_mgcg(adev, true);
 
 	r = amdgpu_ring_test_helper(ring);
@@ -790,16 +790,11 @@ static void uvd_v5_0_enable_mgcg(struct amdgpu_device *adev,
 	}
 }
 
-static int uvd_v5_0_set_clockgating_state(void *handle,
+static int uvd_v5_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
-	struct amdgpu_ip_block *ip_block;
-
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD);
-	if (!ip_block)
-		return -EINVAL;
 
 	if (enable) {
 		/* wait for STATUS to clear */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 4f5dc46802e2..d9d036ee51fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -48,7 +48,7 @@ static void uvd_v6_0_set_irq_funcs(struct amdgpu_device *adev);
 static int uvd_v6_0_start(struct amdgpu_device *adev);
 static void uvd_v6_0_stop(struct amdgpu_device *adev);
 static void uvd_v6_0_set_sw_clock_gating(struct amdgpu_device *adev);
-static int uvd_v6_0_set_clockgating_state(void *handle,
+static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state);
 static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
 				 bool enable);
@@ -467,7 +467,7 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int i, r;
 
 	amdgpu_asic_set_uvd_clocks(adev, 10000, 10000);
-	uvd_v6_0_set_clockgating_state(adev, AMD_CG_STATE_UNGATE);
+	uvd_v6_0_set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
 	uvd_v6_0_enable_mgcg(adev, true);
 
 	r = amdgpu_ring_test_helper(ring);
@@ -1450,17 +1450,12 @@ static void uvd_v6_0_enable_mgcg(struct amdgpu_device *adev,
 	}
 }
 
-static int uvd_v6_0_set_clockgating_state(void *handle,
+static int uvd_v6_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ip_block *ip_block;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD);
-	if (!ip_block)
-		return -EINVAL;
-
 	if (enable) {
 		/* wait for STATUS to clear */
 		if (uvd_v6_0_wait_for_idle(ip_block))
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 079131aeb2f7..53249d4ff8ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1511,7 +1511,7 @@ static int uvd_v7_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int uvd_v7_0_set_clockgating_state(void *handle,
+static int uvd_v7_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	/* needed for driver unload*/
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 552866990db2..c633b7ff2943 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -578,13 +578,13 @@ static int vce_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int vce_v2_0_set_clockgating_state(void *handle,
+static int vce_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	bool gate = false;
 	bool sw_cg = false;
 
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (state == AMD_CG_STATE_GATE) {
 		gate = true;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6f4a2476b9fd..f8bddcd19b68 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -65,7 +65,7 @@ static void vce_v3_0_mc_resume(struct amdgpu_device *adev, int idx);
 static void vce_v3_0_set_ring_funcs(struct amdgpu_device *adev);
 static void vce_v3_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vce_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block);
-static int vce_v3_0_set_clockgating_state(void *handle,
+static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state);
 /**
  * vce_v3_0_ring_get_rptr - get read pointer
@@ -497,7 +497,7 @@ static int vce_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	vce_v3_0_stop(adev);
-	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
+	return vce_v3_0_set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
 }
 
 static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
@@ -760,10 +760,10 @@ static int vce_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int vce_v3_0_set_clockgating_state(void *handle,
+static int vce_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 04bfa3b59f75..335bda64ff5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -684,7 +684,7 @@ static void vce_v4_0_mc_resume(struct amdgpu_device *adev)
 			~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
 }
 
-static int vce_v4_0_set_clockgating_state(void *handle,
+static int vce_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	/* needed for driver unload*/
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 32b0159953f3..00d9fdd2869e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1395,15 +1395,15 @@ static int vcn_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v1_0_set_clockgating_state(void *handle,
+static int vcn_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (!vcn_v1_0_is_idle(handle))
+		if (!vcn_v1_0_is_idle(adev))
 			return -EBUSY;
 		vcn_v1_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 798d06563c65..de4067713d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1335,10 +1335,10 @@ static int vcn_v2_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v2_0_set_clockgating_state(void *handle,
+static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
@@ -1346,7 +1346,7 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (!vcn_v2_0_is_idle(handle))
+		if (!vcn_v2_0_is_idle(adev))
 			return -EBUSY;
 		vcn_v2_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d00406e057d7..08f43a281a7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1782,6 +1782,7 @@ static bool vcn_v2_5_is_idle(void *handle)
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
+
 		ret &amp;= (RREG32_SOC15(VCN, i, mmUVD_STATUS) == UVD_STATUS__IDLE);
 	}
 
@@ -1805,17 +1806,17 @@ static int vcn_v2_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v2_5_set_clockgating_state(void *handle,
+static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
 	if (enable) {
-		if (!vcn_v2_5_is_idle(handle))
+		if (!vcn_v2_5_is_idle(adev))
 			return -EBUSY;
 		vcn_v2_5_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index d761bc7c31bc..6002990d917b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -2136,10 +2136,10 @@ static int vcn_v3_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return ret;
 }
 
-static int vcn_v3_0_set_clockgating_state(void *handle,
+static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8c1d9afa81ff..2c36f748176f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2007,9 +2007,10 @@ static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v4_0_set_clockgating_state(void *handle, enum amd_clockgating_state state)
+static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 4ac6ee75b27d..eda67585768f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1560,7 +1560,7 @@ static bool vcn_v4_0_3_is_idle(void *handle)
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		ret &amp;= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) ==
-			UVD_STATUS__IDLE);
+                       UVD_STATUS__IDLE);
 	}
 
 	return ret;
@@ -1595,10 +1595,10 @@ static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v4_0_3_set_clockgating_state(void *handle,
+static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = state == AMD_CG_STATE_GATE;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 13c0fc9f9894..f24e1eef6606 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1501,9 +1501,10 @@ static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v4_0_5_set_clockgating_state(void *handle, enum amd_clockgating_state state)
+static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9d16747484c8..8ccd054975a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1228,9 +1228,10 @@ static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
  *
  * Set VCN block clockgating state
  */
-static int vcn_v5_0_0_set_clockgating_state(void *handle, enum amd_clockgating_state state)
+static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
 	int i;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 039f1ae2df02..378da889e075 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -605,10 +605,10 @@ static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int vega10_ih_set_clockgating_state(void *handle,
+static int vega10_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	vega10_ih_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index a8e88c9f6ae5..87a530bbc092 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -697,10 +697,10 @@ static void vega20_ih_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int vega20_ih_set_clockgating_state(void *handle,
+static int vega20_ih_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	vega20_ih_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 471a66dad9b9..4180e5e671cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1945,10 +1945,10 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 	return 0;
 }
 
-static int vi_common_set_clockgating_state(void *handle,
+static int vi_common_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_clockgating_state state)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fbdfe37cb93e..7790d2cdd71c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -955,7 +955,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	}
 }
 
-static int dm_set_clockgating_state(void *handle,
+static int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 0f20abbfd381..98d9e840b0e2 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -401,7 +401,7 @@ struct amd_ip_funcs {
 	int (*pre_soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
 	int (*post_soft_reset)(struct amdgpu_ip_block *ip_block);
-	int (*set_clockgating_state)(void *handle,
+	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_powergating_state state);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index bb8b0799ab7c..67a8e22b1126 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3177,7 +3177,7 @@ static int kv_dpm_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int kv_dpm_set_clockgating_state(void *handle,
+static int kv_dpm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index ed8f755e9ff6..2bed85ba835e 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7849,7 +7849,7 @@ static int si_dpm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int si_dpm_set_clockgating_state(void *handle,
+static int si_dpm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index a3d1c5aa3b3e..686345f75f26 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -267,7 +267,7 @@ static int pp_resume(struct amdgpu_ip_block *ip_block)
 	return hwmgr_resume(hwmgr);
 }
 
-static int pp_set_clockgating_state(void *handle,
+static int pp_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_clockgating_state state)
 {
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8d07757adf04..6f2b8ef07a41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2192,7 +2192,7 @@ static int smu_display_configuration_change(void *handle,
 	return 0;
 }
 
-static int smu_set_clockgating_state(void *handle,
+static int smu_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state)
 {
 	return 0;
</pre>
    </blockquote>
  </body>
</html>

--------------6E327141A382F00F871FFDE2--
