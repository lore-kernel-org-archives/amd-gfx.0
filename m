Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4F7C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1907D10E063;
	Tue, 22 Apr 2025 13:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pWYT4xUv";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D15210E063
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1Ea9E67CdULeCdOxybwZy7SaqM6b5qGfGkSwYftx6f43z3dzLIDYIW4uECa6dj3DdzKzj/7Jwu5WPwoUik+AIpTQ2krH6ph1qaRFEW0RtQRv+UKy+R3H33p0RnhXvnW+NopI86w80hO05LXAOSnxWz9UhG/Ha6qk5SvTJWbxlCz1BpzH08uHDlnm0kypVkIFw2o2gWmb1qpZy4ViZgNLHKBS3SIuOwkLCg1Mmpszwcv91Mj+Ba5nzSSR8D1kzI6dfgQEcyU5KcmIhQu/lCWcGLssbQZwUp6NFp5yLXQ2K0kdnZ6JpTuClI4HIy6jr/TB9OCE31SE27TMvN9umRxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrM5lMqNhNhMMXQ5mw1Rh3SrTzc7LYaA3Lrefmd+vzk=;
 b=AXNauuSl1oMlwgiPUtRKO3bBd2NvKvqIN6uIcITItytoTadK6Ue9audS666zzW83uVzmb52/1TpLY8QN94t76lzS5xxPc350YSFG1olplGlpLktvs/bedONASCNWwzryjUcaHAJ35X7u4TGUuPJ/OEgAMN+xDKFttRr7M9D26KmmRCUYEF453cHE2UH7zp5GrkxmTaqpOfy+9OCK6OaVIqjnQRdiGkVWynu0AyaVCr3WYaGVqWm5IY1qIEOGEoe3544zAIcSikxy3+Z0iuzah0UVuS/ZcvEnYBN2fW9jOGwiENGsdML4l7Ww39GfX8Ck8PKvf/FBrqavIs8zrfka/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrM5lMqNhNhMMXQ5mw1Rh3SrTzc7LYaA3Lrefmd+vzk=;
 b=pWYT4xUvjDpci3CaXFr+YEdxm4SOhEvXegOHAMbHc+d1yvQVJ7Mw8VegGysgdkVMK6TTKEIYz+tZ7Afs6pEa4l3cDuzQcsjdr2/MXUB5khn8d2EQokby/kkBxdhZ4tXhbXFeXepAvjkPRHgc8GXiaToI4DQejsolcFYiAzHzIog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 22 Apr
 2025 13:35:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 13:35:02 +0000
Message-ID: <7c581b1b-5174-4238-8a4f-1724e8977b45@amd.com>
Date: Tue, 22 Apr 2025 15:34:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Add NULL check for 'bo_va' in
 update_bo_mapping v2
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
 <20250422131726.3873364-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250422131726.3873364-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: c003cbf1-5c07-4c2a-6482-08dd81a27c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmxSbEp5d3FsM2hOdGR2UDhxNTd3THptem1EZzNRYWFubHgzdnFIeXdIajNR?=
 =?utf-8?B?MEhYaEZHYVQyYVZLUnRIdW9XR1FnS1Z3blNiZzdCZ09YZVBqNHpERW4yVWhG?=
 =?utf-8?B?NUJrS1phblFEUUYxS3pHM1VwcFJ2V2ZEWUpENTIvVEZ6N01KVWI1REMyU0V5?=
 =?utf-8?B?UjE4cy92ZTBUdi9GemFWVU95bzYzRXlSMkx6cWIvSUI3VHZEVFA5VlpRZXVK?=
 =?utf-8?B?bWNHSGhIZkJSR2pGOGJoRjZFcWNrTStQSmZzbmRjTE5LWjU1cWJzTHF1NG9i?=
 =?utf-8?B?NHZ2OTNoY1lobkpoV3pvbzVzNlJsWWZnMUpYTUR1TEN0TFdDbmEvUnlQYitQ?=
 =?utf-8?B?TzI1MDQ5c0FIT1gwK2pKRXM1RXptOHQrTUlnY0NVWTdPWDgyMUFva0ZaaEU0?=
 =?utf-8?B?ajgwQTJaM3RtRS9kejZuYXI2SGxRV05uODgrUlJ1ZUpSemVwd216NCt4b2w3?=
 =?utf-8?B?S3dyZnR5TW96d3V0dXJVVCtWeldCNmt2M0NLWm5zSmRxY254REc3QW4zTFBB?=
 =?utf-8?B?Z1BrODdoUStDTE83VnRDZUZaSmc4bHBIN3RGL2VydjdGY09nK1d0T1JOeWJj?=
 =?utf-8?B?WmVoTGU0VGQrRjNXaVFoN284ckxTVllVL1NDVXhqQU9lV2NRVTZCdjlBMFd0?=
 =?utf-8?B?YWVwVUh3bTJCNGt6MzJuQTNha2R1VDJlKzJ5SHNsb3Z0ZXozZk11V3hGdWNM?=
 =?utf-8?B?aldnODlQL3lHQlhvcWh2bGFzTFBhc0dvTmxGOUNsazcxQlNvTHhVbnk1aTJh?=
 =?utf-8?B?S3BhbnZRdVNFMHFJRDBocXVWZU81TG14WFpOT0RlT2hwUlJ3TWdtR3dJbFhV?=
 =?utf-8?B?VFNpdmFzNXl5OXJxeE1POUJvU0NjTlN4a3pjU0o5SWdrYmtoeFBTa0FUUUxq?=
 =?utf-8?B?RFp4MWdORFMvdXM3VWxPdWpRc1ZyNGNXL3ZGZXhCMHhXK2FKeC9OemNaY2Nu?=
 =?utf-8?B?dFFXOGJMZnZlWDllWDFuaW5PRUl5Y2V2bVNyaUsvWW9YUnRCV1FaaC9ZTk1O?=
 =?utf-8?B?NnNSNEhaOTFFbC9kOW1iMGVYcnFicWx5T2pOa1hGMDJTNUoxaUxiM3BEMUFx?=
 =?utf-8?B?a1lXb1AxL3lVVEREekt5V1ptUFg5bXR6Sml3SVArczVWUVJ6cTVSYWh1ZkZT?=
 =?utf-8?B?ZDFIQjdpVCtGMS9qRXlOOXlBeTQvSlFhaWdvdEF4WmdhN282TXZKeHFYQjNt?=
 =?utf-8?B?UUVJcmlLNGtBSEhOSjRybUpxVk9abm5aU2duNXZ6Y2RDTndhbWN4NCsyc0I3?=
 =?utf-8?B?Zzlzd2pKdExZY002TUp4aktORVV4bVo5STkzcTU2ZzJsY3VzQU5PdmxreTB6?=
 =?utf-8?B?OXhPc0RNY2hRaW1UemtIK1B4a0dWakVXcWV4VjF5TmpOVWxXT2R0N1UzT0JX?=
 =?utf-8?B?TW80am1XT1d3QklJRldnK0poNHNlWmI3MCt0WVFPc3pDQmxreGVmbnN1N2pQ?=
 =?utf-8?B?VTNHZUVzYlFBb3lWOWhFSVFqSFVsTU1yL0E2KzIxbE9peDdXM3ZTMG8zWkxY?=
 =?utf-8?B?eDdXZVJDenJRYTZCUDBPV0oxWGUzeXAyWjJpYVJGakVENlJiSTdDV1pmaldZ?=
 =?utf-8?B?YXhuZS9CdkY1bERJRjJGeENQWTRiaUg0dE55ZlpxTjNldE9Ia1BYY09iQVpW?=
 =?utf-8?B?WjdvT09ydkNKYysyN2RxS2lTcFd0WWtUcXRjdzYveGNEMGZOVmxQbVJ3Rnl6?=
 =?utf-8?B?RVVudkp3RFBhLzhMM3VRUTZaZ1JMQnN4RVg1RThWY1RTVWd4V1NQdjI0OGRV?=
 =?utf-8?B?Q1JmTlNoS3F2Z21HL1BRTGcxNGJFaHFNZEpSMlRtOG9TNE9BUDRmNi9wN1dJ?=
 =?utf-8?B?ZjJObmZPZ1BhTU1VZGJ4TkhWZEFPOWp4Z2VsdGxUT2k3ZWlqRjN2Rkpqbk5n?=
 =?utf-8?B?c1luYWhTY0hwdHMvbFN2Um9lVndmb3ZVbytpcitYNjNlYWtVQVdRZVZMUzVP?=
 =?utf-8?Q?ZoDmT60hUQM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkdkZXNyejBWdVBsRDVmYlBwVGFmQ21ndExTZ083cWlLeWtkZnhUUlhpd21q?=
 =?utf-8?B?LzdUa2pXbkl3aURncmIzd0xoUFI3dm1hSVBCbHkvUkgvUzRmQ1NHaDJlQ0J2?=
 =?utf-8?B?NW9scmwzWUkvOVhEM2c3empvdFNJZWxPVXlUeHMxUExzMDBYMlFpbDRDemRZ?=
 =?utf-8?B?MkNEOFJDUUNqeTZoY0tUZ24wV0xlbW9VTnpyTC9pZXZOVU13czZtQmF6VTcy?=
 =?utf-8?B?dTJ3R1ZFOUVITzZSdWtTK1BOKzJ2cXErTkFhcWJLc0tJazJIZnEyR1pTMEl4?=
 =?utf-8?B?Zkd2ZW50ZE8vRkxFVktEcVczMzVGaS9nOGRBZXF4eEdJQ01UVWRzeVZnRVQy?=
 =?utf-8?B?eTR0MzNKL2FkcGgwb0RNWVJlODNHbi92Vzlpc2YwT1F1NCtTcndFejhxOHFi?=
 =?utf-8?B?M3M5b3JaR05reVM0bjROaWdZZDFrbHJTYlpRWlRyYmtrUWZoRS9QZmFabmJq?=
 =?utf-8?B?bFI1OE9uaWY2azJLeEZwMDBNTW1LZjN3Q0paVURiVEpXOVVndWw4SGpkUmQ2?=
 =?utf-8?B?RndPTkVRL3RoREZqajhDeFFYNVRUUWZ6L214SGpja0hPNzloK2RwdE44a3JF?=
 =?utf-8?B?MEFYV2c4b244SlNkQVA1ZlJ5eUpBeW02dU1QQzlrbHUzN3NYcmVnb3Bpd0Zv?=
 =?utf-8?B?eG92R0JRVVNsRU43ajU3dWxLeFllcVdBeGV1ZFIxcW5ra0xObDJKR3laSUcy?=
 =?utf-8?B?WUE0UE14ZjVWdWhMWjgzME16a0ZOZmVoV2puanU0L3oxVTlHZzNjRkxMelR4?=
 =?utf-8?B?UnJhL1FuNnhMdnh1aUJyaFVBM2JrQ0hpSGk1V3BYZEFMTlhadUtyU054T3hY?=
 =?utf-8?B?R05VKzRHbmZzRmYxSlBYMC9wckQ3R0NjTjJEUCthbnF3Qlp2bUZZQUI0cklD?=
 =?utf-8?B?TGgvQXJYWkNDdnVtNXY3RmlNNUdVelV1MDh5ZmVXdzd6Z0ROcUljL1FYMmVJ?=
 =?utf-8?B?SkxRbDY2a3dHSmVSelRKQ2E4dFFRamhlbHVTR0RHc0ZmTlJXUGpnNDFpZ1FX?=
 =?utf-8?B?bER6UktLMmhJMmJhcng5TEdDeS9lRWtTbE9MWTIyY24waFpjbEduWnFoSnY5?=
 =?utf-8?B?Nkg4ZzNYYkU5WVZKSGFMM3dPK3FyKzZzNmFKQTdWaFJVYU9lZk9mNk4rVzNS?=
 =?utf-8?B?eWVScjhNalh0U3FjTVBMblZUcGpVOVRDMEVyVDA2Uzd5dzBDOFNjV1V5OUMx?=
 =?utf-8?B?bUJDSmZKa3B0Sk5ldDZsTUl1eFR0L1VFa3pOVnVPSEx3cjd6aG1NKzlRY0Y1?=
 =?utf-8?B?aUk0SlRCMUNjRER2T3BoL0xtcUlDVGR4ZDlxVkxCakdwMnlQN2tuNE56bVlU?=
 =?utf-8?B?eTB5aTBBNElzcG1nMHJJblVPYmZ5dXFyV2pLOXpXTWhiU2ExQkZEbXFYWjBx?=
 =?utf-8?B?ODFtQWEvMXdseDBteWFjMXRud1dDTFdUd0dTaFR6UzhZeEZ0VWk3Q2tmeSsr?=
 =?utf-8?B?VU5tR3hZemg1QmEyVzk2YVFjdGdSbjUwNGwzWTZMMHJwNjNjQW14M3NxeS9K?=
 =?utf-8?B?SW11UTQrMFphQ3JNU2g2VytVN0krS0ZXZzUrQjd5a2tSRWFOUk0rc3FVWStS?=
 =?utf-8?B?bkkxTExZMlZBRHFQcFk2b1Mzb3AxNFFKMVE0WVpua0VHaXp6WnNYenJUbGZG?=
 =?utf-8?B?enlyM1RyOW5PelFxejYvRGNzZGV4ZVliUWJqZ3g1c2dvYUtWQ2txZTg4Zkxa?=
 =?utf-8?B?QWZnaXh3NGdocVhPa2J4ektMOWExVHV3U1B1K3lzcHlZd1kwTlBQZmNRZ1Zn?=
 =?utf-8?B?K09URzZXN3c3K2FvMG91V0J6a0NVQi9MTi81Z0V2dHhHVThEVDhBbzlubTZX?=
 =?utf-8?B?cVFMVGU1OXowSlE2R2M1YkViK2tHV09yVWNzeENTSGx3QXJUbEJpVG5TRkxi?=
 =?utf-8?B?MzhIa2JIN3NVSVhlMUM2SGlxcWQxVUN0YjN1bVV5ZjFFNjA3NUV2NEFzdlNH?=
 =?utf-8?B?aHdSNHNaQ092dGg2VkJORVNOVUM2clRuaXNSZG12emlabSt5b3dNYUI3UXlv?=
 =?utf-8?B?cGg0cHUwZmI3cjV4WklHbFNMdWhCQU5jMFVPNklHTjN2VVVkOCtSTVp3L1FU?=
 =?utf-8?B?dWZaTFdKVFRVQ2F6dUhTbUxXZ3ppRVlNZ2pPbVRLb3ZjZXBPcmRwOWtsejVN?=
 =?utf-8?Q?kXbLHV8zGjTG7bICEnuytJWW5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c003cbf1-5c07-4c2a-6482-08dd81a27c20
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:35:02.6329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ql9Gzdkv+ol3AoQBbq8+e++9OZCivnzk44KhBIuHPe26lvaEJJ+wr7N01T1DcM1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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

Am 22.04.25 um 15:17 schrieb Srinivasan Shanmugam:
> This change adds a check to ensure that 'bo_va' is not null before
> dereferencing it. If 'bo_va' is null, the function returns early,
> preventing any potential crashes or undefined behavior

That commit message doesn't reflect the changes any more.

>
> Fixes the below:
> 	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
> 	error: we previously assumed 'bo_va' could be null (see line 124)
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>     115 static void
>     116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>     117                              struct amdgpu_bo_va *bo_va,
>     118                              uint32_t operation,
>     119                              uint64_t point,
>     120                              struct dma_fence *fence,
>     121                              struct drm_syncobj *syncobj,
>     122                              struct dma_fence_chain *chain)
>     123 {
>     124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
>                                   ^^^^^^^^^^ If bo_va is NULL then bo is also NULL
>
> 	...
>     135         case AMDGPU_VA_OP_REPLACE:
>     136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
>                             ^^
>
>     137                         last_update = vm->last_update;
>     138                 else
> --> 139                         last_update = bo_va->last_pt_update;
>                                               ^^^^^ This pointer is dereferenced without being checked.
>
>     140                 break;

Please completely drop that. This conclusion is actually incorrect.

BO might be NULL here because bo_va->base.bo is NULL and *not* because bo_va is NULL.

@Dan your script seems to reports false positives here.


>
> v2: Refactor `amdgpu_gem_update_bo_mapping()` to move the last update
>     fence logic to `amdgpu_gem_va_update_vm()`. (Christian)
>
> Fixes: 16856d135622 ("drm/amdgpu: update userqueue BOs and PDs")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 128 ++++++++++++------------
>  1 file changed, 64 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f03fc3cf4d50..32d80acfe65a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -112,6 +112,63 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>  	return 0;
>  }
>  
> +/**
> + * amdgpu_gem_va_update_vm -update the bo_va in its VM
> + *
> + * @adev: amdgpu_device pointer
> + * @vm: vm to update
> + * @bo_va: bo_va to update
> + * @operation: map, unmap or clear
> + * @last_update: a pointer to a pointer where the last update fence will
> + * be stored, reflecting the most recent mapping or update operation.
> + *
> + * Update the bo_va directly after setting its address. Errors are not
> + * vital here, so they are not reported back to userspace.
> + *
> + * Returns resulting fence if freed BO(s) got cleared from the PT.
> + * otherwise stub fence in case of error.
> + */
> +static struct dma_fence *
> +amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
> +			struct amdgpu_vm *vm,
> +			struct amdgpu_bo_va *bo_va,
> +			u32 operation,
> +			struct dma_fence **last_update)
> +{
> +	struct dma_fence *fence = dma_fence_get_stub();
> +	int r;
> +
> +	if (!amdgpu_vm_ready(vm))
> +		return fence;
> +
> +	r = amdgpu_vm_clear_freed(adev, vm, &fence);
> +	if (r)
> +		goto error;
> +
> +	if (operation == AMDGPU_VA_OP_MAP || operation == AMDGPU_VA_OP_REPLACE) {
> +		r = amdgpu_vm_bo_update(adev, bo_va, false);
> +		if (r)
> +			goto error;
> +
> +		/* Set the last_update fence based on the operation */
> +		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
> +			last_update = &vm->last_update; /* Use VM's last update fence */
> +		else
> +			last_update = &bo_va->last_pt_update; /* Use buffer object's last update fence */
> +
> +	} else if (operation == AMDGPU_VA_OP_UNMAP || operation == AMDGPU_VA_OP_CLEAR) {
> +		*last_update = fence; /* Assigning the temporary fence for unmap/clear */
> +	}
> +
> +	r = amdgpu_vm_update_pdes(adev, vm, false);
> +
> +error:
> +	if (r && r != -ERESTARTSYS)
> +		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
> +
> +	return fence;
> +}
> +

Well that doesn't seem to make any sense at all.



>  static void
>  amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>  			     struct amdgpu_bo_va *bo_va,
> @@ -121,30 +178,17 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>  			     struct drm_syncobj *syncobj,
>  			     struct dma_fence_chain *chain)

As far as I can see this function here should be completely removed.

>  {
> -	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_vm *vm = &fpriv->vm;
> -	struct dma_fence *last_update;
> +	struct amdgpu_device *adev = drm_to_adev(filp->minor->dev);
> +	struct dma_fence *last_update = NULL;
>  
>  	if (!syncobj)
>  		return;
>  
>  	/* Find the last update fence */
> -	switch (operation) {
> -	case AMDGPU_VA_OP_MAP:
> -	case AMDGPU_VA_OP_REPLACE:
> -		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
> -			last_update = vm->last_update;
> -		else
> -			last_update = bo_va->last_pt_update;
> -		break;
> -	case AMDGPU_VA_OP_UNMAP:
> -	case AMDGPU_VA_OP_CLEAR:
> -		last_update = fence;
> -		break;
> -	default:
> -		return;
> -	}
> +	/* Call to update the BO VA and retrieve the resulting fence */
> +	(void)amdgpu_gem_va_update_vm(adev, vm, bo_va, operation, &last_update);
>  
>  	/* Add fence to timeline */
>  	if (!point)
> @@ -744,52 +788,6 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>  	return r;
>  }
>  
> -/**
> - * amdgpu_gem_va_update_vm -update the bo_va in its VM
> - *
> - * @adev: amdgpu_device pointer
> - * @vm: vm to update
> - * @bo_va: bo_va to update
> - * @operation: map, unmap or clear
> - *
> - * Update the bo_va directly after setting its address. Errors are not
> - * vital here, so they are not reported back to userspace.
> - *
> - * Returns resulting fence if freed BO(s) got cleared from the PT.
> - * otherwise stub fence in case of error.
> - */
> -static struct dma_fence *
> -amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
> -			struct amdgpu_vm *vm,
> -			struct amdgpu_bo_va *bo_va,
> -			uint32_t operation)
> -{
> -	struct dma_fence *fence = dma_fence_get_stub();
> -	int r;
> -
> -	if (!amdgpu_vm_ready(vm))
> -		return fence;
> -
> -	r = amdgpu_vm_clear_freed(adev, vm, &fence);
> -	if (r)
> -		goto error;
> -
> -	if (operation == AMDGPU_VA_OP_MAP ||
> -	    operation == AMDGPU_VA_OP_REPLACE) {
> -		r = amdgpu_vm_bo_update(adev, bo_va, false);
> -		if (r)
> -			goto error;
> -	}
> -
> -	r = amdgpu_vm_update_pdes(adev, vm, false);
> -
> -error:
> -	if (r && r != -ERESTARTSYS)
> -		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
> -
> -	return fence;
> -}
> -

And that function should absolutely stay where it is.

Regards,
Christian.

>  /**
>   * amdgpu_gem_va_map_flags - map GEM UAPI flags into hardware flags
>   *
> @@ -839,6 +837,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	struct drm_syncobj *timeline_syncobj = NULL;
>  	struct dma_fence_chain *timeline_chain = NULL;
>  	struct dma_fence *fence;
> +	struct dma_fence *last_update_fence = NULL;
>  	struct drm_exec exec;
>  	uint64_t va_flags;
>  	uint64_t vm_size;
> @@ -968,8 +967,9 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		break;
>  	}
>  	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
> +		/* Call to update VM and retrieve the resulting fence */
>  		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -						args->operation);
> +						args->operation, &last_update_fence);
>  
>  		if (timeline_syncobj)
>  			amdgpu_gem_update_bo_mapping(filp, bo_va,

