Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C8AC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 06:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3527310E74A;
	Thu, 22 Aug 2024 06:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fg6p+ym3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBEB10E74A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 06:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLCXiLtO/drdAepFuJpg+waOdGFsuEuTur+nZvS9OZeH72kVQxoLbUE78yXaPhuL/VScbrVVBgSpZBxA0UwFCnkjn/6+vl9aopakzSHM8jq7+jEvJbw/BX4+QRvpnPH78UCsBdrORNkXxQE9E6HlR2nWs1jodpjQKrfo3/TI5QRxu8kFmqR4Aq1AOBCqa/RXz5wGq4z+FP7NO9L7/W0aVLQJZXdjZSaGAe6cpnlhWkLf1f78cvIngMvfwvUdfpWvqGE0nvEUrXkd84dyKGcPGjKn/gsnKjkilp5CyxYyjzehUTV+BZbnIeiiMVj/WOg3tR6+tfHhRx7FHrkncoRwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNeiagt8YCDY0ejNodfSOkNsr8A8p23L5bJU1Arsi+A=;
 b=k+T3ZnGPasVtqjSCXUEStMqubXHcKoXwKnd0rj3EFKdnIkyEBo+ATmxD3vDJ2lh60LL5qrkmCUSbV8Dai/Y1GzMetaz+HLG2yRmNZCujqY62CvZ0NRIY4/NUbbd81oJxSWzHYis8VzUafkVQS29r3TzpkcASDPuay6O5WwTNq6bKlnnv/r5ATxr7bxm8zfdY7LXwcjvqBrur71u6qc1bon9kN/kvDUdaAEBeF/xCKnkf8CdEQWY41J4XdyqSljmBhzzPVjo8fGtxHkL6VHuC/2vkLnaskRQF14eWBzmc2BdwrV1Hdbt9bgvDRS2qE1WmAiiEU82bPL+loltJQzE9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNeiagt8YCDY0ejNodfSOkNsr8A8p23L5bJU1Arsi+A=;
 b=fg6p+ym3iWj+00pEvD3a+3/+r21QfHNh65xjmbIjRdP+js7cJ/mQEmH17YHIiidAGQqiamZv2I++kS+YdeDm+42CLCOxKTUIwxFopkGIPV0yTrwGKE7EAaqZuTqcSYHupLueyoO7hRJFUzEMj9ROC9yd1Cr0+MFrODZSUpas3yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 06:37:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 06:37:04 +0000
Message-ID: <158bce30-7866-4654-b359-91b3e9a7a5d3@amd.com>
Date: Thu, 22 Aug 2024 08:36:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] Process Isolation Support
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efc506d-fbd6-4f71-d9e1-08dcc274d609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUEvdFNHbmdiNUFkMmFIakFXWDBWRUhwYUcyOG5FNncrWHBzQnA1M0lCdk14?=
 =?utf-8?B?ajZUN2Q4OEpKMEYzcW1WLzNtMHNzRW5kZ3JJVnQ1T3JlMTNOZGlyaXZUTElp?=
 =?utf-8?B?Ty9TMFE3QWUyanp2MHVyWHF5eGh3NGRFekg5K1dIcUdmK2VZeEhtVEJjYzYr?=
 =?utf-8?B?ektiLzcyZnZuMTcreGxmOStURDNUZVFkM3RaSDZ3bk82cThFMmRXWjJuU0pm?=
 =?utf-8?B?b0Jqb0R1M3lZQ0g0RStReEx5TWtIbzlCVHZjTHM5enU4L2lYV3o2QS9hVDN1?=
 =?utf-8?B?MmxnT05PempRRnM0bDc4WXkxNStZVUtFcWdkaGFlenc2YkZlR1Bad3h5Ryt0?=
 =?utf-8?B?TzdXUGNhdUl6QWgwZU1PcE1SdWNKeXN1L2VOR3NLVFlOVmpTZFNsanU4eXBY?=
 =?utf-8?B?K2U3NnNhM00rdmJ6SzA5eGNQRElhc3ZGT1AxMVNCMmxhUDVrMXdoQURuWE44?=
 =?utf-8?B?K3ByWWovT0QwY3JSNEF0ZVdETW01dDZoWFdwYm5xNmFtb1pKSGhibkdocHdr?=
 =?utf-8?B?OXpaSmNnbzJidzhIYjVvcVV5VkVjYWVQWjFTMlE4c3JHS296N1FycGFENUhy?=
 =?utf-8?B?d2t2dnowTnhHTytIWWtHWW9MdzliNmlrSXU1c2NlYVA3SXN1NDZUWUZxNEEr?=
 =?utf-8?B?bk8rN0RxLzFHTytSb2poampyZnNNbzBXYU5qTmlxaHpON0JYalhkMkR0UXly?=
 =?utf-8?B?ald5MUFTYmRReGVUOXdBUU5PczMraE84dmgzVkk3bmR4MmlLL3lnS1BSUWhT?=
 =?utf-8?B?RzhNRU56OE1xcDZPOW5hZTFLUzBhcDRvZy9nNWZtS3JpNGNVZHptWjRGNUw4?=
 =?utf-8?B?RlJqRHk5YjZVNE1jUmdLcUYzdE1aMWVxemJpaVU3K3hBNVdFMEQ3cVFhUTFw?=
 =?utf-8?B?UlQyZmw2NVZiR1FvVFZhNUk5aUFUSWNUUnFhamZhVGR4cDdpL0pZNGlXWXZw?=
 =?utf-8?B?aWdOYlgyZkxXQ0RZd0ZucXFYNFJaWHJYQW41NG9jdkpOTGNwVWhkVXFtUmUy?=
 =?utf-8?B?dWlEVFc1Rm0wcFVNZFQzNUEvVzR5YUYzRmUreHdDYnY0U2VydDFMeGpTS0pU?=
 =?utf-8?B?L3pVeTVTWDY1MGxMWjdDQ2p5ejhOaXVUK0xGSVpRNHpvbUNWb1k2amhLUTNU?=
 =?utf-8?B?dFhHK2hBNEV1ZDVrbnlpQngxYmJPeHJoL2I5eGhKUGo4aFFpMEQ5SUVUYXlS?=
 =?utf-8?B?YVByUmg0elhOQW9uYndmbTZ3TEpsL29WdmNTS1lOVk9aalMzL0FhRTVxR3RP?=
 =?utf-8?B?MW1XUk50YWI0QTZMYmRnTG1rZWFjYjZjQmRoYVo5TkhmUlZTQnlFWGMxa2Qw?=
 =?utf-8?B?cHBzaWpvbDIvK0doVjRZNXV4TjliT1BVaFpETGpia1RkYnd4SkRIK3FnbE13?=
 =?utf-8?B?Zmg5bFJ6c0FIQW5yTU1hYkQ2b2FsRmJ6aUhBbmdEb3lsNGpobHVvTkFERENa?=
 =?utf-8?B?R1hGd3BLZXVkMnZOR1lHL2FsVENWdW9Rc1hmNHV1ZlNCY0JPeHp4dkNWWWM1?=
 =?utf-8?B?UnYrakw1djc0SlY3Yk4vd1FpQnR6TnUxQktSNmVJTTlwYUxZSUdGOEt2R0lY?=
 =?utf-8?B?b3h4WXdnWlIwY085RzNmcTk5OVJqdUsxTFRMOFdjRWhGa2JPQUFodzQwbmtT?=
 =?utf-8?B?Sk9UUFZDSmhwS2JMT3JZNEMwWVY0MmVINXo5ejRrVjVRenRFN1JLL1cyS3ls?=
 =?utf-8?B?VitPc3FZNDFxdTlhQUhGcHE3UTZTTUZNZ3pvaHFmSUV2Sk9TUFdNSDVoN1BU?=
 =?utf-8?B?bVZUaWp6VEVmbkFjOXlKMExsNGo4TWhwcXlSNHhkMzFLbldmNEV0Z1lRQzBW?=
 =?utf-8?B?UCt1Ty9qZWVORVRkWmZWdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qko4L0JRRkhtV1EvYWVWZzVHb0ZIY25hekY5SEJMZk1XMXVUbXZLUGM2aGJl?=
 =?utf-8?B?cjFtSzByV1ZHNTU0YnZlTmtFbTdNTVJjeTYxWmUzRGMwU1g1WTNEV2hwRklR?=
 =?utf-8?B?MjdEcHZTek4rcEE5eC9KTG5hR2ttMnByQUltU3krekVHbGluMVlyK1l4Z0NG?=
 =?utf-8?B?ODVJdmpBV2x1YjZ5cEJ0N0hpaEZnTjNTRFRZeEhYbXZlZU9VMjNiaDBGOU1o?=
 =?utf-8?B?T2YvRUwrc1ZqR2FCa08vYjJlaENuV215Um10ZHJMWU9Nd0ROWm9WTS8wdjFI?=
 =?utf-8?B?Si8yZTg5cW00V1cxb3BYOHNkY1NnU0QxU0xQSXBSSzBTT1RUZnpUK2s4TDRa?=
 =?utf-8?B?S0M3aFZMSzN5Vi90THRkODhvTUlnMHB2N0dnQ3hDL3ZyUWZ5VDA4TTVaenA4?=
 =?utf-8?B?dWszU0kwWXI1SW92TzE1VFZmUjhmV3B3T3l4MFRXaGIyenovOUQyNkpDRHBE?=
 =?utf-8?B?Rm0wWm5tQUdiejNmZ0NNQUdYK1lxeVVlSFpQMk93SElPMk1TOStzYTc3VVQw?=
 =?utf-8?B?ZllDQStPbmlMcm1mdGdncEVqQklNcUlSb2trTllHOWVqTm1uQWs1S3ZyOWpn?=
 =?utf-8?B?Q2NHdC9xdGhGSUxyelBCdTk4Rzd0SGhTSk9YWDFpTDFRUDFsZXNCREZoSGxZ?=
 =?utf-8?B?VDQwYzhWWVZHMGV5WjcvdEJ6anJCZmp3MW8xbHJjb09Kb1grbWl2cCt1VnJE?=
 =?utf-8?B?czZ5N2pOS0wyOW1FcDFINE9SWGtxdnhISzZGRlVOWGkweVpNaDM3UHBFK0dB?=
 =?utf-8?B?UXIrbEFTY3V3T0RKcEVFR3V6NVpUVm4xMjRCcG4zTi9WWDFQc2dOWDE3RmNm?=
 =?utf-8?B?S2JZVTR6cEdqanUrQmVlU0VaNHVPa2VkTVVxWFM0emtBb3dxd1BQUEpqNXow?=
 =?utf-8?B?UllEbElxenlJalQrVGdPOHRqNGh2ajZLek15T2tqelVqNFlvT3oxOVNPSVNK?=
 =?utf-8?B?MkVIWWNsQVJPaG5IejF3ejlCMC8xczdxc3Y5dlUzZUpPYUtIczF4cUJKcnFl?=
 =?utf-8?B?SnVYZTJ2LzN1T3JheENyY2F3NlorVVQrSUt6ZEdYaFZrRm5sNCtmK1BDUEk0?=
 =?utf-8?B?U3RlMCtrd3djcFJSaDdLbjI2eEl3aytEQXZUdGx2aTRScGk4VlY2dTAxU2Rx?=
 =?utf-8?B?L0N0K0ZBV3lkYThPUk1BcVBiSEcxS3FzMHBTOE5DRGtJeXFRTTZoTUg5d0F3?=
 =?utf-8?B?emlqeWUzeHllUVRFOWZGTncxMlVhbkJIbE5hdXBJSEEwZkRCT0UxVmlURFR3?=
 =?utf-8?B?RU4rcCtZY2E5b0RJZWlmZU80dER6MnR0TC9oTXRpSXhHU2NpcjlScHBLRHd4?=
 =?utf-8?B?V3lOaFcxdzhYdE04NWQxU3RDS2d5OWNGQ0VPUy84ZVljRjZqRCtMeHlvMlZB?=
 =?utf-8?B?b2hjMUs2eWtTdDNGL24rYUY0eEloS0dTalpoSCtHdTR3S2N4TXIrZ3ZqM20v?=
 =?utf-8?B?WGx5Sy9ZWUhRLzZVV1B4cWUrWkxCVjU4aW1IaUx2dVdMS1BMbVJPYWhCM0tx?=
 =?utf-8?B?YmhteTBRQkQ0NTBWOC9uei9ZRUFyK09oWmNlazE5ZEg5Y3ljNVhIVm1Sancr?=
 =?utf-8?B?aUZrRGlycHlLT040UEpabGZVY1NhajYwY25GVU9EZ2Rqd1FURFpVdjdFdXRa?=
 =?utf-8?B?aklqZ0pIOWc3c0lCTytPQW5WT2lhSGgrMWhpY1lLVEhzMllhZGxGQkVzV2N1?=
 =?utf-8?B?MEk4RkIwWGM5UWRPdWd6dUQ2UElNVWxYQVZLd3lIeHFWY2k1eGFUaXJCWFJa?=
 =?utf-8?B?by9keUFmcWt6YXBUS2FhSkpYajE4QTFZTVBjZFUwSjIzYmlTaGNFRVZCNkJz?=
 =?utf-8?B?dXQ5aW9LaU8yUklYdlAvTGJKS1dHR3pUT3liKy8xZy9uUHFJeGVYcDF4Ny9P?=
 =?utf-8?B?M01aMFFVL0Z1VEtMTy9IQVhxd2t6RUtQYnRrRENUS1JnQnBQbEZuaFhMS21E?=
 =?utf-8?B?UHBLcHFLRURiUUoyQ0syOUYyVGxLd0hCdyt5M0h5dUhHdFlrWTc5ZEhZOHds?=
 =?utf-8?B?STBCRVg1ZGdTbi9Qa0JNRXIvVWk1ekl1TWdHTXJUaUllZnFuSnk2TnF5SEx6?=
 =?utf-8?B?Mnc1M0lEVkxsU241MlZRdnU3VUZBNll5d3UrMmRvOE92RWFCeEhtdTRsNjRv?=
 =?utf-8?Q?qQiw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efc506d-fbd6-4f71-d9e1-08dcc274d609
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:37:04.6211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JftlF2Ap7blF4Fl2UChc/zyqnOiD5EZHu7gQ9Y4RHquugTm0Nkp2XISuaPO0kFb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

Reviewed-by: Christian König <christian.koenig@amd.com> for patches #1, 
#3-#5,

Acked-by: Christian König <christian.koenig@amd.com> for patches #6, 
#8-#10, #12, #13, #14, #17.

Some nit picks in patches #2, use of // for comments in patch #11 and 
question on patch #15/#16

Really big bug in patch #7, that needs to be addressed.

Regards,
Christian.

Am 15.08.24 um 02:04 schrieb Alex Deucher:
> This patch set enables process isolation mode which
> serializes access to the graphics block between processes.
> When this mode is active, a cleaner shader is run between
> processes to clear shader LDS (Local Data Store) and GPRs
> (General Purpose Registers).  A sysfs interface is
> also available to manually clear LDS and GPRs if you
> for example want to clear LDS and GPRs when a user logs out.
>
> This includes support for GFX 9.4.3 and 9.4.4.  Support for
> other GPUs is in progress and will be available when ready.
>
> Alex Deucher (2):
>    drm/amdgpu: handle enforce isolation on non-0 gfxhub
>    drm/amdgpu: Emit cleaner shader at end of IB submission
>
> Amber Lin (2):
>    drm/amdkfd: APIs to stop/start KFD scheduling
>    drm/amdkfd: Enable processes isolation on gfx9
>
> Srinivasan Shanmugam (13):
>    drm/amdgpu: Add infrastructure for Cleaner Shader feature
>    drm/amdgpu: Make enforce_isolation setting per GPU
>    drm/amdgpu: Enforce isolation as part of the job
>    drm/amdgpu: Add enforce_isolation sysfs attribute
>    drm/amdgpu: Add sysfs interface for running cleaner shader
>    drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER for cleaner shader
>      execution
>    drm/amdgpu/gfx9: Implement cleaner shader support for GFX9 hardware
>    drm/amdgpu/gfx9: Implement cleaner shader support for GFX9.4.3
>      hardware
>    drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3
>    drm/amdgpu/gfx9: Add cleaner shader support for GFX9.4.4 hardware
>    drm/amdgpu: Implement Enforce Isolation Handler for KGD/KFD
>      serialization
>    drm/amdgpu/gfx9: Apply Isolation Enforcement to GFX & Compute rings
>    drm/amdgpu/gfx_v9_4_3: Apply Isolation Enforcement to GFX & Compute
>      rings
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  18 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  14 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  23 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 437 ++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  31 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  17 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   6 +
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   4 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  51 +-
>   .../drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h  |  26 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  60 ++-
>   .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 153 ++++++
>   .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.h    |  64 +++
>   drivers/gpu/drm/amd/amdgpu/soc15d.h           |   4 +
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  39 ++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  58 ++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |   9 +
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  14 +-
>   .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   |   5 +-
>   .../amd/amdkfd/kfd_pm4_headers_aldebaran.h    |   2 +-
>   25 files changed, 1028 insertions(+), 23 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h
>

