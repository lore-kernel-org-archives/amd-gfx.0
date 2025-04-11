Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C277AC369A9
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 13:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B5E10EBB0;
	Fri, 11 Apr 2025 13:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xd9CKKpj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9780810EBAF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 13:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnrONMUQ+ZOM0E2i1Y49ELDHfaFgl1QJWBCxEZHxfznhpebNpHByONG2ftlpnIWKcY8RgnvmoYtQjxXHp9z8RIi40mI7nAT0tKTTiq1IlJOUezC72oP+N0pUkwqoAj8zLbK7jz6OjnzSs+Sn8/I+bdq1yTuXY4ze0SlKlFDmGiBAZfrTmEuWwCYalyCRsQb6SaFbSgeWXiZoLKaDKMPM2pRd2O8yhBursk4+oLDJIslCbk6MOiGH3CEyyhKi38B/gust8BYJ6YIu/Miu0FROrEhP5W4znfz+44zcCod+Elo4DLZF/6E+m3q0fuqxp+bsb+8vvtrCvHmwQWypgDcQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srk9fe7VrusUBn4owvWvpPe8PesJHbujzAH7YxX32kY=;
 b=TrYAYUfPwaC8hd6dhiey9uqMzBU/5TJhF7ZUnrdcjtpnxz6thizXZXt6Fk2mzIrwU0beC/5S/OEgXjbB1E/XEzTFRisxRkiiiGrGJ+eW/UfkZdYDSyoEc/CtOjNSlxdlozI2xjWDYPXJCpZI3ckIy8Ti/2+F0s9RESqNyteqsgtjreNUNJ+/6xhmhvcwXbP/qH9q08EHgG0VXD36gZLD5+Ae32NZzRIjC4oPbofFm9iJYnOCoHjHfn2ze/HHsfKzncMW+eKWiWngx0Et2jM6GSJMdmkXKbTRc9ELvXEhUgRac3F9w0AlcvKNss7WV2Z6yUMmstgBiQdVajiGgOS2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srk9fe7VrusUBn4owvWvpPe8PesJHbujzAH7YxX32kY=;
 b=Xd9CKKpjGdKmpss7HXObttsjphfLHPriXw6ihuitvH18zoaC0sNR8bUzhHt3NDvLitMXUKtU5QFVh0R9EfH/3ir2CzhBbS1tGEdpiPxIIoF/u8MgrHT+Hio1C5w7YdQnkStumWQJTr8d0ld1sUn/eXikirYLTw4hed8VUtKnSEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 13:06:39 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 13:06:39 +0000
Message-ID: <2fae7a6c-f9f8-4a9a-bd3d-b1deb813ef12@amd.com>
Date: Fri, 11 Apr 2025 18:36:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu/userq: rename suspend/resume callbacks
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410181138.2287932-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410181138.2287932-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 581fbd33-0c80-4841-6fc7-08dd78f9b249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2owTUh6MTJKT0xvZDBUMzBOaWY5N056WlljQjNLN2Q4aldBZ0RkMVFiMmVk?=
 =?utf-8?B?SFhnaE14c2E5b0RSa0tXVDhwNkFveTJyUUlwWnhzU1hReWhZY1RwZE54aGVy?=
 =?utf-8?B?eWZvZ0tla0taVkpsU3VFYUFkK1dJb3MvMzlEYVIxdW4xMWRMN2lNcGJBNURQ?=
 =?utf-8?B?YTU0N25xbTVvMHpKWjdjeDZ5TU03SC8xcEhCQkxVK2lQT1F2dS9SQW05NSsx?=
 =?utf-8?B?MnNUdE1RWCt1UWNKWUR5RjZWVFZnZ096UHMvdGJiQmFYR2hmS0VTaUtLbFRu?=
 =?utf-8?B?cXBnN2RuSnVlOVlXS3l6cUpJK013aUNlWWpMWTRnaG9QNEJ6SVlOQ0ZKeFhk?=
 =?utf-8?B?b05hK1JHMi9YbURJQmRvTG5Zc1FnU09kcitHRzltYklZMnR6dnRFdDA2MkhZ?=
 =?utf-8?B?T1Qzb01QZGprSlFPYnZQTDVuVjkvYTIwcVNjZGlDUTJhT0JrayszVVF1b05V?=
 =?utf-8?B?c1pyYTUvVENQNVl4UUNJVjVlRGxGZTlWa2R3UzFvdTY0RXVNdHFIRlZML0ta?=
 =?utf-8?B?NnkvK1pTY1RqbDlPNUxEWms4NlFZc2c4ZzdtY1dZOENvK2NnS3NKMlA0Ykx3?=
 =?utf-8?B?M1JHLzl3NThabFBseFN2R01qTFdhNmF1b0tBdWhueGswd1YwbzZKdC9oQmNj?=
 =?utf-8?B?U3B4elZYRUJQeW1FK3hVNDRuUUFzZnY5VFlNRC80bndBVHh6RjVLUlBMTHJ1?=
 =?utf-8?B?SlVvckd2Z3Jsb0dBTWtNdHY4NUdHZHNjbG56d3ErRXExQk82dkdEb3N3KzJ2?=
 =?utf-8?B?MSszR2hFOGJDelJLTGZacUluWnc2aWNtYU8zNEJOOGxIUVk0enlPL3ZVcXVF?=
 =?utf-8?B?ZkRMbCttZlNNRG5IdVFPcC92bDBZS2pEam9RVlVZUEw2d2s2Skt6Ym9SckZi?=
 =?utf-8?B?NE0ycmd4NVFJZlpIVTVMOVRGaU9Wc0NmMjVGQjdUVUg0aTFNdG4yelR2d2JU?=
 =?utf-8?B?elhrRFRYSysyd1lXeXIrTFBPL1VVTWlPOVRTaVhSSmVWYmx1N0Urc0dDR2c5?=
 =?utf-8?B?UU1TNXBVM2NIVjNxS0taSnBuSEFSdisrb1FsRFNIUkp1QnVtQ1lKYWRnbmE4?=
 =?utf-8?B?azRWd2IwV21FeG9WcnFtbyt5aHRVVGNIS3BHTStXMVRTN0VJaWtHVHMvV0I5?=
 =?utf-8?B?Zk1EanpsNG9UWUlYWEpkaElDRnhKS2p4bGFGbnFPZjBnYThBNkc1MXJndG5a?=
 =?utf-8?B?d05BUDhuSkNUV0JDcENqV3ZmVTdoc0dVVmFWWkRJeXNZYkRydVF4U200YmVk?=
 =?utf-8?B?Nzc1azZRTUQ2dUl2SWx1U2VkbHA3VkRDVkt0dXM5eWV2Wm56eGI5VUVUT3Zw?=
 =?utf-8?B?K3Q0ektiQk5wZlVtS29NNlZVU1k4V0FwZWI3R2c1N1d6WElaa1A1UHJnSm1L?=
 =?utf-8?B?cWxqTitET1BSZzI0OThMRjBWeHM5OFpvYVk4TmswTkV5MUZPQkF5ZTlRZmVx?=
 =?utf-8?B?ejhPSWxOcmVqbmN2aHpEU01WZTBlMks4Y3FGSGhvb1JPV21uUFNwVXJUWUti?=
 =?utf-8?B?Z2ZJUVNHb1ZaQm1jOVZEa0FuRU8yd1ljbDIzY3p6dTFDd3B2RTl0QnZnUzBk?=
 =?utf-8?B?ckNMN0VtY3ZJZnFyTE1xRU83SXltOTVuRFo2K2pGRnNQWXpMTFhhbXpveXdH?=
 =?utf-8?B?MzBPTVgxRk1raHRSTlluUUVST1JIeVFHdXl0TUUzZEY3Ym1iaFc2cnA0bENS?=
 =?utf-8?B?dXcwTEdzRmw1eU9YQVhMc2FYY25vbTdTWVU1Z0c0U0s1Wlh2K004R3BaVjkw?=
 =?utf-8?B?dTEzZG1lSGVxZEVDN0szVG4zaENWRWZrYzB5aHdIbmtEeWk4Ni9mbERSSWda?=
 =?utf-8?B?TWFFM2NPLzNQWUwwbzVkL1dkUC9tdWtvc3Ywemx3MTZtbURidFZVVHBiTkp5?=
 =?utf-8?B?dlVkd1dZOTJ3T3c1YlcwenZ5dmlkOHIrTUM4UTRXWnVoclIzVE9KdFNVRkRZ?=
 =?utf-8?Q?6Bs4GXPnigU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akk4SzE1cXcxNUFFMmV3Rkp1R21GdVhUSVh3Y1NwR0lLYlZLb2RmNnVqTWI0?=
 =?utf-8?B?TTRQb0lIcGp3N0xSUXhsZVRoTDF5RmJLSXhlaW54dmNZVFliSVFSazFtajVl?=
 =?utf-8?B?MVBmdVF5YkpUZUY2aG5lNVZNY0w5cTRVQ0NvQ3dmMnYwWCsrcXVETmU1VzJu?=
 =?utf-8?B?eTZ2Yndsa09YclMrcFdFbVpmSWxoMVFGMzlwNnRiU0JaNWROMStETFVCcFdC?=
 =?utf-8?B?TDJEUzEvdGk2QUdZUTg1aTY0U3NTeE8rMFAzaUtSZVhSNnlTbmptT2oraitv?=
 =?utf-8?B?WHNCMjBDUm5iMHBhT3NaK2VyWW12RUllaGVXSUNzVzVNa0l4bjhpTWhZWWJs?=
 =?utf-8?B?R3B1VkpLVlN1ek5aY2piZHFwODFMVWdWeUtWdHM5Q1JGMHUzTUYzaTA5bmRn?=
 =?utf-8?B?S3QxZERpaGhaNU5VQjN3QkRvc09mOGVQQkU3R0xkcTM1N0JzNkxKMmtFSnln?=
 =?utf-8?B?R2FyMG1NRXRad1VERndmZkJpM2hJM1VrMk5tZFZVdG8veUN3NVZFYVhKcDRC?=
 =?utf-8?B?RWFxVnMvM0pNT01MdFRacWhXb3hGWjhKbGxtdW9CQitHc01wS1EvdHI0SGxk?=
 =?utf-8?B?RnI3Mldyc1JJM1NJZU14Z29wSEpXMU9FNk1wSDI1WVNET2FhOVVYZkRmM2Fa?=
 =?utf-8?B?RCtQWGxwQ0MzYituc2lqNUQ4bW04cDhmUTZrdVFKZ3prdUllN2lWT1k1MWg5?=
 =?utf-8?B?NWhMcS9SMXNML0hQT2JTNStDUE1zSkJWQ01aQ1UyVDVLYnpXckYxQ1BHYjRL?=
 =?utf-8?B?S0tKS1hDdWhWUUIyMWtHL3FodjZUYVBVRmdFNEIwc1VsMFBmd2RSVmxSeU9T?=
 =?utf-8?B?SXpFRzdOWThOZllGY3lZREZOejgxYW5jSkRYNURzQVFBL2lPUlZJcFRCT1Nz?=
 =?utf-8?B?NC9OL0RzNUlneU9rcVYyc0EyOVZxS2o0Q0lHc3BDZU9URjF5anlyTitOS2Vh?=
 =?utf-8?B?NWZVbDZXRzN2WVlQbDlOSUNLVlI1YmhwQ0U1N0hhWXYwWThDVStHOUN2VUxS?=
 =?utf-8?B?Tm4yQ3dmZmUzREMycXVpcGQ2Z1hOOVVkYUZXUGh2dEFiNThXM01tSjEyWCs4?=
 =?utf-8?B?YTYyUWtHQVhhUnlJNTNkekZWeEd1MGtQTjFvL2ZreW1leml3cVBWa01KN0V2?=
 =?utf-8?B?YUhVUXVoSlVWNGVFeXlYTUZnZ0w0TVBJN2lCRHpEakNLNXpic01rbXJCdHRt?=
 =?utf-8?B?U09KYjk2ZlN0QWozWUNIRjZUNjZYc0x1WW4wdzhzWXVyT3FjRHdCMHVTU09O?=
 =?utf-8?B?WXI1SHg3RklKcUdpOTZWTUJDZlVaSlk2ZlhpN2tvWEhiNlA3bDEwOFNGQkdr?=
 =?utf-8?B?QmtzMkc1amNxcXpJZFVxZDk3RFNrY2l6V2MzdmJqaHJSekxOZFJINDFmVGVs?=
 =?utf-8?B?bFJxUlYydE55YXVlQjNDODN5Qkt1SFltV0JBajlKeGd6dHJHb2sveW9JcVlz?=
 =?utf-8?B?U0ZTVytLc3FNK2Rid0srbUEyZ3hacE9sT3liY3RCbDRzMlBIN3hITUZvcitt?=
 =?utf-8?B?K3RiVW0yOGFsdG9xbjdHeTUxU0hLOXgxaW41YzBhQXBlOUd4TDdLbTF0Nmp6?=
 =?utf-8?B?enlUeWdPdS80RTArQ0dlMUNxdEQxSmVWRExVanpWTU1jRWFsNWpCaWRkYm1w?=
 =?utf-8?B?R2R6dE9qVHRrVVYxTGdPWmRpRVoyaEI2dndjTWlBS1VZbUxiMzI0bHFoell4?=
 =?utf-8?B?VXJFejIwUkV4YzRIQThIcHIrVkFITVdyQ2E1YmZXM1RGUDk3dG44aGhYNFVP?=
 =?utf-8?B?M3YwV0Vpb1lGWHp1UWV0K1BsZkxneVdVc0NWeTdnSjhzaWlkSDNKdEVyWEps?=
 =?utf-8?B?aUIwTFNKK3R0TWJDR0JJdGtrSXNXOVhpcEFzVHFNNzZlWUQzeTRha004Vmsx?=
 =?utf-8?B?YmNNVGFhWEtoYW9McHhYQS9pNks5anVxWDlpVzdDalh5S2pUSVgyb295KzRu?=
 =?utf-8?B?UEIveWFUSnU5OEpHNTdBNmNqNG8rcVZZSjlxb0F6dU54Mzh0UmF4cEhhRXY4?=
 =?utf-8?B?bG12SFQ2QkpMblI2NWoyUE1kU0pLZlFTMzZqVE1vd0lyME9PeVQxeVZGeFUx?=
 =?utf-8?B?ZHdvSjJ4a3hJN0ZURFZsRHgvYVllRWVRYW1sYUpFNGtaa0U3bnplQXJEZTJN?=
 =?utf-8?Q?9fLfabp2eNMxJto1y1fomr5kE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581fbd33-0c80-4841-6fc7-08dd78f9b249
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:06:39.4187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXxk3B6x4yNTPZ5FFrzLpeDef1xH+XLXTyZI2+iWiJcCFxL3BH51aaOdDcZqNXl8FviD28BdaVnwHzsbKIkQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/10/2025 11:41 PM, Alex Deucher wrote:
> Rename to map and umap to better align with what is happening
> at the firmware level and remove the extra level of indirection
> in the MES userq code.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 10 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  8 ++--
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 46 ++++++-------------
>   3 files changed, 23 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index ecd49cf15b2a9..2be1e54b78997 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -432,11 +432,11 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
>   	/* Resume all the queues for this process */
>   	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>   		userq_funcs = adev->userq_funcs[queue->queue_type];
> -		ret = userq_funcs->resume(uq_mgr, queue);
> +		ret = userq_funcs->map(uq_mgr, queue);
>   	}
>   
>   	if (ret)
> -		DRM_ERROR("Failed to resume all the queue\n");
> +		DRM_ERROR("Failed to map all the queues\n");
>   	return ret;
>   }
>   
> @@ -587,14 +587,14 @@ amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
>   	int queue_id;
>   	int ret = 0;
>   
> -	/* Try to suspend all the queues in this process ctx */
> +	/* Try to unmap all the queues in this process ctx */
>   	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>   		userq_funcs = adev->userq_funcs[queue->queue_type];
> -		ret += userq_funcs->suspend(uq_mgr, queue);
> +		ret += userq_funcs->unmap(uq_mgr, queue);
>   	}
>   
>   	if (ret)
> -		DRM_ERROR("Couldn't suspend all the queues\n");
> +		DRM_ERROR("Couldn't unmap all the queues\n");
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index ec1a4ca6f6321..a0cf6978f2ba8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -64,10 +64,10 @@ struct amdgpu_userq_funcs {
>   			  struct amdgpu_usermode_queue *queue);
>   	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
>   			    struct amdgpu_usermode_queue *uq);
> -	int (*suspend)(struct amdgpu_userq_mgr *uq_mgr,
> -		       struct amdgpu_usermode_queue *queue);
> -	int (*resume)(struct amdgpu_userq_mgr *uq_mgr,
> -		      struct amdgpu_usermode_queue *queue);
> +	int (*unmap)(struct amdgpu_userq_mgr *uq_mgr,
> +		     struct amdgpu_usermode_queue *queue);
> +	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
> +		   struct amdgpu_usermode_queue *queue);
>   };
>   
>   /* Usermode queues for gfx */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b9705cbec74d2..94fee99bd2a08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -99,14 +99,17 @@ mes_userq_create_wptr_mapping(struct amdgpu_userq_mgr *uq_mgr,
>   }
>   
>   static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
> -			 struct amdgpu_usermode_queue *queue,
> -			 struct amdgpu_mqd_prop *userq_props)
> +			 struct amdgpu_usermode_queue *queue)
>   {
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
> +	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
>   	struct mes_add_queue_input queue_input;
>   	int r;
>   
> +	if (queue->queue_active)
> +		return 0;
> +
>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>   
>   	queue_input.process_va_start = 0;
> @@ -144,14 +147,17 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	return 0;
>   }
>   
> -static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> -			    struct amdgpu_usermode_queue *queue)
> +static int mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +			   struct amdgpu_usermode_queue *queue)
>   {
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	struct mes_remove_queue_input queue_input;
>   	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
>   	int r;
>   
> +	if (!queue->queue_active)
> +		return 0;
> +
>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>   	queue_input.doorbell_offset = queue->doorbell_index;
>   	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
> @@ -162,6 +168,7 @@ static void mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>   	if (r)
>   		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
>   	queue->queue_active = false;
> +	return r;
>   }
>   
>   static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> @@ -315,7 +322,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   	}
>   
>   	/* Map userqueue into FW using MES */
> -	r = mes_userq_map(uq_mgr, queue, userq_props);
> +	r = mes_userq_map(uq_mgr, queue);
>   	if (r) {
>   		DRM_ERROR("Failed to init MQD\n");
>   		goto free_ctx;
> @@ -355,34 +362,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   }
>   
> -static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
> -				   struct amdgpu_usermode_queue *queue)
> -{
> -	if (queue->queue_active)
> -		mes_userq_unmap(uq_mgr, queue);
> -
> -	return 0;
> -}
> -
> -static int mes_userq_resume(struct amdgpu_userq_mgr *uq_mgr,
> -				  struct amdgpu_usermode_queue *queue)
> -{
> -	int ret;
> -
> -	if (queue->queue_active)
> -		return 0;
> -
> -	ret = mes_userq_map(uq_mgr, queue, queue->userq_prop);
> -	if (ret) {
> -		DRM_ERROR("Failed to resume queue\n");
> -		return ret;
> -	}
> -	return 0;
> -}
> -
>   const struct amdgpu_userq_funcs userq_mes_funcs = {
>   	.mqd_create = mes_userq_mqd_create,
>   	.mqd_destroy = mes_userq_mqd_destroy,
> -	.suspend = mes_userq_suspend,
> -	.resume = mes_userq_resume,
> +	.unmap = mes_userq_unmap,
> +	.map = mes_userq_map,
>   };
