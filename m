Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04221CD5BAA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 11:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43D210E863;
	Thu,  5 Sep 2024 11:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UWGZhhCX";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CAA10E863
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 11:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ey6Avwj8jWViMs0Au+DIXUuWT+UWrwi56zfinLzt5Gk/jbkXspyvX8qrU1i5yc4qD4VPVrdHCYxSaU12ysOJJxIWLJ+mIo4dFyO2iegtBMh2g0RiqMde+al8QA/v6utzYvSJrurMWaICOTUDN4o5WtMGBPbrTTck6epbJqkZNeDXXsGclu27FeaWDXFvA1eleCorkq6ypjkUGKrXqpkY+Pb6vt9Xwv0Tcny5GmJwBB8b8y+mSy+dOCpI7ypwV1cmpZIhxX4/Jiyhqeja4SC/WGm1qN8Tgpe/p/0Ddbmy2QyYEcQaNlXN5TCF9jVDH0ReIN7VOLdaSDEFZIqZvj9Qng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqZh2vXNaPgBfxB0zPbue3h3/btobkxm8Y4njWQeCHg=;
 b=NxS8+OArEX/QDnW0yk8MsUg4mzawPQN02iqTbl6L1cOISGSUjX7BlFGHXiYOS1ZM7gl+HbUCBE0Yt6fnou0qaOULMlnlCSncF1QB+/RKFnCJOLd6eQkXrXeE5q751ukNtFFSZWtaNKsfLohO5NyIylNbH22LCtGa9a86Z5b1yU52CBUbPcHFFT7JpczftkxerJ7zHOt81JSrObtFN6ccOteBMsCli1Ku0j0TmCIB/Z6L67WA1AlOUEYF2Ph/Ldjkpi7Pw7rubdKDXoaNdTUkjTYmivpDaqpS/9mJ029gNE0VS9nNjpf8x6/WNYYptATJHLcg3RaFUHwSlfXGW0cptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqZh2vXNaPgBfxB0zPbue3h3/btobkxm8Y4njWQeCHg=;
 b=UWGZhhCX1erq7BgmvAgE5lfVTIB8hUoA4iWBBtji78VvoRDcPSnvZUFgNuKpBxAn7U5/8rnYl9Az1+85qWoGzoGp/lrzaUdfnqy0odxVbk6ERETdN6fRnPUiqqRLZ2GGBlYgy7VIuoRDI51QrkGBTx6zK7ygsaQG51GBxG9Nx0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 11:21:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:21:34 +0000
Message-ID: <21f5a136-45f8-495a-a47c-662da1e9a0c1@amd.com>
Date: Thu, 5 Sep 2024 13:21:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/amdgpu: Remove the MES self test
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
 <20240830184322.1238767-5-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240830184322.1238767-5-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0b13d2-2e41-4504-dd59-08dccd9ce620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXVEOTcxM0dMbXk3OVdkV1BwV1RTbHBiRmJGYjVYMERuOGdYZWhiZTFBUjl1?=
 =?utf-8?B?blRmS29lb0JCTkNPZVBuT3RxbnhQK0ZpeTJ1YUFXY2x2L3d5N2pZOFN2RCtH?=
 =?utf-8?B?cGx2T0ZmbkZCa29hSnBLdk5DL0dFeDZxMENGSW5Zc0Zab0lNcmwzWlZEd2gz?=
 =?utf-8?B?SWx1cUpVYXUydjdUS0ZsTEVvYTV4ZTFpMmk3NUkvNGZYT0FGajZXR21Oc2Zn?=
 =?utf-8?B?YktkNzJsUmlWT3NIYkZGbDh5SkpUVkRKbDc3Mks1d21lL0lrOVRVNXlRVTVM?=
 =?utf-8?B?QzEwU1pSdlVJRUJvdVkwc3V5aVF3bktVTlJRRDd5L1k1SEpuTzB2N2ZlNHIx?=
 =?utf-8?B?TWFxL3hxMjZyUHFPam9RdVJmT2RZKzFhcnRxdlJCY2ZheXRmN3dKcGhZVFJG?=
 =?utf-8?B?MDBRNGpHTmVMbVVzeHpKeG5xd3ZHaVV0VzB0SnFMa3NQNDVHdkxNU1N2Vnl0?=
 =?utf-8?B?eWdqTW5wN1kzSXRmODYzMnBOSnh6THZ5UWRnWWZzNTkvWndjTnY4Z3BTejEv?=
 =?utf-8?B?OWJuR3QwK3JHd1JNNnFpZ05EVlZwK3c0Ujh4Z3VTNC9URU9BTFA5VWlmVkpS?=
 =?utf-8?B?TmJFd09FMSs3akFoazNzeWtOaG02TjVQQ3lFUVZSSHZHa3EwSWJ4bFNrVlAw?=
 =?utf-8?B?UWY2b1RLaEZ0bi8xWjUycU4xa0s1L0ZBZjJZcTFrL3BCTEtCcmI0TzBxaTUr?=
 =?utf-8?B?U0tuS1pTZXM3TTYyTkQrMFNWQWs0aEhXZ3o2ckVTTWJKV3hRRDNUN3BsVnJy?=
 =?utf-8?B?cVdiMk55TkxIa01hckRxZU1XWFlUNVVzckU0enk3eHllVFhjSUJzZnQ1aTRp?=
 =?utf-8?B?RGtoK0pHSU5KK2xCSjltVTBXeUdKQzQ5bFg0UmpaMVZ3bXd1am1rMVdZTDdZ?=
 =?utf-8?B?VEhqUG5IdHVEbGtBcnMzWGRWK1hqektRelRCUEpBNXNhak9RY3V6QTZXZlNn?=
 =?utf-8?B?VlE5b1NFVlZDUlVaUEpCa0JqS0g4QTQ1Z2NaK2hZT0MzNzd4dTBmT0oyOHZp?=
 =?utf-8?B?bE9Fem4rRWE4My8rQTROSmhCWFJ2UGlTdEN1d3dNeFUxdmw1VFZnekkveFEx?=
 =?utf-8?B?QXNwQkV2S0FadmppTGtMZUgxTDlZUk4vZlo1R05QTS82ZVl1UUI5NXNJT3g1?=
 =?utf-8?B?cmFwQWZVQlJHUTB5cG1Ea05icUpBd1ljbU95Y3ZmODREVWhEY0ZtTERraExq?=
 =?utf-8?B?MUtiMlBEVnhZcG9XTzJYMi9iMWtwTjZOTW9VOFI2VTlHMUtYMGJOUWZ0T2M4?=
 =?utf-8?B?WlI3Q1l1R2kxNjhlTWwvRVByQ1JtOXU2ejFMMnV5ZGNibDFOdnhZU0hjZ2pq?=
 =?utf-8?B?TXpsWXNQblRQYVkrbmxxNlVTNkJqckV2UHhMd0sxYWJyZldHUmtXY1NTa25W?=
 =?utf-8?B?Z2UrYjRjaWdhZHhmYnNmTWI1akpIdWpYeTJtT0Z2U0pkQVVjS1pSNXJtL3Rn?=
 =?utf-8?B?bVU1L1VHWHh1eGdMcm0xRjhHRWdoR29BM1lYNnhoZ09QUDA4NEtrMytRa3Nh?=
 =?utf-8?B?M01DOXdPanUxVzlkUUR6eElnZHNERFRJYWZHUnpqcEhQdVIxVklYMkl1cUJr?=
 =?utf-8?B?dmVSb3ZrUW95NlEwWFZKMUtYQmpmL2FaMHExQ0lHcmNUUERDRmRmZnFNRlFx?=
 =?utf-8?B?M0tyMGtJdDlVb3h0NDgvQ0RRdndCRHc5b1NlRTZoVWtOSnk3UGlsRzl6V1ps?=
 =?utf-8?B?akFaVDZaakkrN1NHNXNpQURZOUdxZUpHSXBpNTYveGlDME95bzM0UVFLM3g0?=
 =?utf-8?B?M2FyREdsU1NGL1BkNlJqU2VXTTJEUDJxY2FFN1dqL2JZai9pRTRnTzFBWklj?=
 =?utf-8?B?TDNnUFZsK1QxdmFEZnNJZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJMSWJ2SUpnQ1oxQjIvejlkdnVrZHNPVXp4QjVPZ01nRVRob2JFTThJblFR?=
 =?utf-8?B?U3BUNGF0SHRWVjNYNW05d3RTNGhMYmVMSzIvRnB0T21YTWsrTWQySWNVVkpY?=
 =?utf-8?B?eDliNklMSXJvblVzSlNwT3JUU2F4VnBURy9nSkhzbGV3YXlCclo3SXZlWHhF?=
 =?utf-8?B?dVY4OTFLQ2lNN015MjlpRVlGcnpYWUhnSTk1VEV3bU13U0dNeXJpWE5YOUdk?=
 =?utf-8?B?My9LKytuRnlEc0xOYUYxeG9MUW9JcTVXSHpiSVFJYzhtNWNUK2E5RU55SlJl?=
 =?utf-8?B?RlRKanU5eTk4MkRYMC83T2thcW04Qng5M0NkOUk4ZzYzY3F6cEpSUm1hV2pJ?=
 =?utf-8?B?NHlPTjBRejB6ZEZVK0dmVVppR1V6SUdmaTRTNlQvbWVXVE5WWWVKRXROQVMv?=
 =?utf-8?B?cEdBNklrWUZTR3lsWEhjdjlQeUZkUWgrL2xzM1ZQejhsVm1vWXdpSkVjNDB2?=
 =?utf-8?B?YlpZWXl4KzZzVmZSQUpGeS9MenU2U3RaSzlaVEhJOCs0QmxsTElRSlc0UmpD?=
 =?utf-8?B?K1hvY2hXaXdDNTVyOUMrRUdWK2R0Uy9UMmdPY3dYTjVTR2h1MHkxYUI3NSti?=
 =?utf-8?B?cXkyajJ0OHY2Y2ZqMStJTjFkSStKYTk2dWlQRHpCU2pIbEFZaTVTaEZwbmNY?=
 =?utf-8?B?QjdPOVNQOWlLQTZBVHI0cWdGQWFhOVFseTFZZlliWndYeWdISzNzWVNnclJ6?=
 =?utf-8?B?MndYK1V5Y1ZzMTR6cDZWZkk0eVVYeStwZHNLVnFIOTZtR1ZWWFd3Z2FTM3dj?=
 =?utf-8?B?OTJUeWwvZnR1dmk0WlkrcVQ5YndiSzNaUWVqV2Vvdmo5OVNUcGR0a1lJbE01?=
 =?utf-8?B?Z3VHR3BkT0RpN0RWTi9BVUx6Q2o5eC9xS2xjV0d0cFJpR3poTGJ3dUZRUEdl?=
 =?utf-8?B?MlZOY0kyWkExM3p0azlabG5nNWlSTWp4NUQxa2hpWFMrS0JwZUVJQ3M0bUlY?=
 =?utf-8?B?VFFWN3B3LzRDbG1lQVFpeXVYZGw2TzEvYkhKaVc2MCtNQW5DcjZsV01oY1F3?=
 =?utf-8?B?cHV6MUU3QTRSZDYzT3dHUlBCVzRyalhBbS94ekJKNkI0a3NrM01iZXhPZk1B?=
 =?utf-8?B?RmtHeHF3Wkk4QlB5UlVyRVcvdXlxUTRNb2YwUDVQTUtWcDZPVjFXWG41OFE4?=
 =?utf-8?B?dUJjWmFYSmxDVWREK09zZWRUR2pmeEhSOUZscW9YRXZtdE5HQXU1aWFzY21m?=
 =?utf-8?B?REZRS1FrNzZJMThPczk0ajFjS1ZrL3RFL1RXRndMWUtlaGJDMkR4MW41VkpZ?=
 =?utf-8?B?bjI1QlRBTHQ3aTljRmg0UTFYb3d6SjgyZStkWVYyNDI3V0Z1ck5UWTNpM1lB?=
 =?utf-8?B?cXFvVVhNQ3MyUk9xUGkvSVQvVHRqcU1aSHdCeGhFOXU2MVdhRHBpUzBOUStY?=
 =?utf-8?B?QzJuTmR6LzJRWjA2QXRIaTF6SUhBd0l4SlM5VEwzWWlyWk4vVkZOc3J2T3Vq?=
 =?utf-8?B?YmNzZ2l2c2NoUzcyRHRjQjYvNEF2SEFWMG5QLzBmODh5enV6VlVqdDJhZ08r?=
 =?utf-8?B?RVo5L0ZZMmpYdUc2UTJzTlZKZGFZS2Q0YUJScWJ0czZrOFdFOThOSkF1S3dE?=
 =?utf-8?B?VkZMRlNGTnZ4V1lOQjNoUjBtY0h4TmRtV1J3WW9kRGxFeG9uVjY5c0ZWQnRr?=
 =?utf-8?B?STNreU9hQ2pLamdWaVZTV3FzMDI3WG1oWVQybjArNUNxUlgrVE1BcGtNQnJh?=
 =?utf-8?B?UGVaQWJ0QXV6VWRtRzVJWGhQQ2hJaUNvZG5Oam1XMXhLNTF3Zkt6Qk9PVFVY?=
 =?utf-8?B?bUplODladjMvemwrODRsVVplRy9oU24zNzZRYkVkYTVlaHk0UEo0eUdYWGZi?=
 =?utf-8?B?RlplTDVxcThyZlg5c05XcDZQWmE1OUoxWVE0OGwyOWNNbnRsS1MxZitrOTN1?=
 =?utf-8?B?TjlzL1BQQkZ3OXladURQVnFGWnhSRFBGUG9neEN5UnpLL1VkWmkyK1d0TFVV?=
 =?utf-8?B?SkNnUjYzcjV3Z0ZMOGsxM3I1QnFwblRsVFFNOWNkZ2RpK29jUWx0TFpBam0w?=
 =?utf-8?B?bDI0SXBOQVFaUFFlTW9GcUxzUHJQYUhtYm1oSWtmNXBFK2ZwSzhXTTQwVFUz?=
 =?utf-8?B?ZDltY0w2MGZFRDlaZ2F1RXRjSllWZnl2MDVibVQzZzBGbGRvVlROYlJkTytu?=
 =?utf-8?Q?lH3rhWMhFFRB4t3o1dEqSa+Lw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0b13d2-2e41-4504-dd59-08dccd9ce620
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:21:34.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baCGEfUpqv4jB3Cl4MrvvlelMZ15MLLUFvZ+1OhVNyypm8QoOykVyiyGokoy/RkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:
> Remove MES self test as this conflicts the userqueue fence
> interrupts.
>
> v2:(Christian)
>    - remove the amdgpu_mes_self_test() function and any now unused code.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    | 169 ---------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   2 -
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c     |  12 +-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     |  14 +-
>   5 files changed, 2 insertions(+), 198 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2da895f91e4d..5ec6cb237c81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4700,9 +4700,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	}
>   	adev->in_suspend = false;
>   
> -	if (adev->enable_mes)
> -		amdgpu_mes_self_test(adev);
> -
>   	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
>   		DRM_WARN("smart shift update failed\n");
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index da48b6da0107..dbe7cf4b322d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1297,175 +1297,6 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -static int amdgpu_mes_test_create_gang_and_queues(struct amdgpu_device *adev,
> -					  int pasid, int *gang_id,
> -					  int queue_type, int num_queue,
> -					  struct amdgpu_ring **added_rings,
> -					  struct amdgpu_mes_ctx_data *ctx_data)
> -{
> -	struct amdgpu_ring *ring;
> -	struct amdgpu_mes_gang_properties gprops = {0};
> -	int r, j;
> -
> -	/* create a gang for the process */
> -	gprops.priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> -	gprops.gang_quantum = adev->mes.default_gang_quantum;
> -	gprops.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> -	gprops.priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> -	gprops.global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> -
> -	r = amdgpu_mes_add_gang(adev, pasid, &gprops, gang_id);
> -	if (r) {
> -		DRM_ERROR("failed to add gang\n");
> -		return r;
> -	}
> -
> -	/* create queues for the gang */
> -	for (j = 0; j < num_queue; j++) {
> -		r = amdgpu_mes_add_ring(adev, *gang_id, queue_type, j,
> -					ctx_data, &ring);
> -		if (r) {
> -			DRM_ERROR("failed to add ring\n");
> -			break;
> -		}
> -
> -		DRM_INFO("ring %s was added\n", ring->name);
> -		added_rings[j] = ring;
> -	}
> -
> -	return 0;
> -}
> -
> -static int amdgpu_mes_test_queues(struct amdgpu_ring **added_rings)
> -{
> -	struct amdgpu_ring *ring;
> -	int i, r;
> -
> -	for (i = 0; i < AMDGPU_MES_CTX_MAX_RINGS; i++) {
> -		ring = added_rings[i];
> -		if (!ring)
> -			continue;
> -
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> -
> -		r = amdgpu_ring_test_ib(ring, 1000 * 10);
> -		if (r) {
> -			DRM_DEV_ERROR(ring->adev->dev,
> -				      "ring %s ib test failed (%d)\n",
> -				      ring->name, r);
> -			return r;
> -		} else
> -			DRM_INFO("ring %s ib test pass\n", ring->name);
> -	}
> -
> -	return 0;
> -}
> -
> -int amdgpu_mes_self_test(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_vm *vm = NULL;
> -	struct amdgpu_mes_ctx_data ctx_data = {0};
> -	struct amdgpu_ring *added_rings[AMDGPU_MES_CTX_MAX_RINGS] = { NULL };
> -	int gang_ids[3] = {0};
> -	int queue_types[][2] = { { AMDGPU_RING_TYPE_GFX, 1 },
> -				 { AMDGPU_RING_TYPE_COMPUTE, 1 },
> -				 { AMDGPU_RING_TYPE_SDMA, 1} };
> -	int i, r, pasid, k = 0;
> -
> -	pasid = amdgpu_pasid_alloc(16);
> -	if (pasid < 0) {
> -		dev_warn(adev->dev, "No more PASIDs available!");
> -		pasid = 0;
> -	}
> -
> -	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
> -	if (!vm) {
> -		r = -ENOMEM;
> -		goto error_pasid;
> -	}
> -
> -	r = amdgpu_vm_init(adev, vm, -1);
> -	if (r) {
> -		DRM_ERROR("failed to initialize vm\n");
> -		goto error_pasid;
> -	}
> -
> -	r = amdgpu_mes_ctx_alloc_meta_data(adev, &ctx_data);
> -	if (r) {
> -		DRM_ERROR("failed to alloc ctx meta data\n");
> -		goto error_fini;
> -	}
> -
> -	ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
> -	r = amdgpu_mes_ctx_map_meta_data(adev, vm, &ctx_data);
> -	if (r) {
> -		DRM_ERROR("failed to map ctx meta data\n");
> -		goto error_vm;
> -	}
> -
> -	r = amdgpu_mes_create_process(adev, pasid, vm);
> -	if (r) {
> -		DRM_ERROR("failed to create MES process\n");
> -		goto error_vm;
> -	}
> -
> -	for (i = 0; i < ARRAY_SIZE(queue_types); i++) {
> -		/* On GFX v10.3, fw hasn't supported to map sdma queue. */
> -		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
> -			    IP_VERSION(10, 3, 0) &&
> -		    amdgpu_ip_version(adev, GC_HWIP, 0) <
> -			    IP_VERSION(11, 0, 0) &&
> -		    queue_types[i][0] == AMDGPU_RING_TYPE_SDMA)
> -			continue;
> -
> -		r = amdgpu_mes_test_create_gang_and_queues(adev, pasid,
> -							   &gang_ids[i],
> -							   queue_types[i][0],
> -							   queue_types[i][1],
> -							   &added_rings[k],
> -							   &ctx_data);
> -		if (r)
> -			goto error_queues;
> -
> -		k += queue_types[i][1];
> -	}
> -
> -	/* start ring test and ib test for MES queues */
> -	amdgpu_mes_test_queues(added_rings);
> -
> -error_queues:
> -	/* remove all queues */
> -	for (i = 0; i < ARRAY_SIZE(added_rings); i++) {
> -		if (!added_rings[i])
> -			continue;
> -		amdgpu_mes_remove_ring(adev, added_rings[i]);
> -	}
> -
> -	for (i = 0; i < ARRAY_SIZE(gang_ids); i++) {
> -		if (!gang_ids[i])
> -			continue;
> -		amdgpu_mes_remove_gang(adev, gang_ids[i]);
> -	}
> -
> -	amdgpu_mes_destroy_process(adev, pasid);
> -
> -error_vm:
> -	amdgpu_mes_ctx_unmap_meta_data(adev, &ctx_data);
> -
> -error_fini:
> -	amdgpu_vm_fini(adev, vm);
> -
> -error_pasid:
> -	if (pasid)
> -		amdgpu_pasid_free(pasid);
> -
> -	amdgpu_mes_ctx_free_meta_data(&ctx_data);
> -	kfree(vm);
> -	return 0;
> -}
> -
>   int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>   {
>   	const struct mes_firmware_header_v1_0 *mes_hdr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 7d4f93fea937..e7af28834766 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -396,8 +396,6 @@ int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
>   int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
>   				   struct amdgpu_mes_ctx_data *ctx_data);
>   
> -int amdgpu_mes_self_test(struct amdgpu_device *adev);
> -
>   int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 1e5ad1e08d2a..1b2745670d4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -1156,20 +1156,10 @@ static int mes_v10_0_early_init(void *handle)
>   	return 0;
>   }
>   
> -static int mes_v10_0_late_init(void *handle)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	if (!amdgpu_in_reset(adev))
> -		amdgpu_mes_self_test(adev);
> -
> -	return 0;
> -}
> -
>   static const struct amd_ip_funcs mes_v10_1_ip_funcs = {
>   	.name = "mes_v10_1",
>   	.early_init = mes_v10_0_early_init,
> -	.late_init = mes_v10_0_late_init,
> +	.late_init = NULL,
>   	.sw_init = mes_v10_1_sw_init,
>   	.sw_fini = mes_v10_1_sw_fini,
>   	.hw_init = mes_v10_1_hw_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 26d71a22395d..38e35c0a2876 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1257,22 +1257,10 @@ static int mes_v11_0_early_init(void *handle)
>   	return 0;
>   }
>   
> -static int mes_v11_0_late_init(void *handle)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	/* it's only intended for use in mes_self_test case, not for s0ix and reset */
> -	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
> -	    (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(11, 0, 3)))
> -		amdgpu_mes_self_test(adev);
> -
> -	return 0;
> -}
> -
>   static const struct amd_ip_funcs mes_v11_0_ip_funcs = {
>   	.name = "mes_v11_0",
>   	.early_init = mes_v11_0_early_init,
> -	.late_init = mes_v11_0_late_init,
> +	.late_init = NULL,
>   	.sw_init = mes_v11_0_sw_init,
>   	.sw_fini = mes_v11_0_sw_fini,
>   	.hw_init = mes_v11_0_hw_init,

