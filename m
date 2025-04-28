Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45809C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 17:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0ACD10E227;
	Mon, 28 Apr 2025 17:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZXedKT7f";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353D910E64B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 17:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOE/nn6qB35xapHIXhITTnVBtwZviAwLQplI+YB5dgyNkuBvHxFpZ55dQrmCUUAj3vLoQa9svtRi4EqQP13RYjZjkqe5DU9xQOttHcc+dErqPu7lTCSlSfAJyqiYjU7ck7kDhKlvX7lbQvRiLJSN9bhwGWVM9AtzQ9Tb8pv4dNzsfZ9doKJdbBt9lwUJiygMit6sSDZqunAdcHT3j+4HqXlCqsL7Dm4rVGGZ9DTX2zHJYtPUFiMO3kdqeQWeThw3faQAwPqemAsn80zwpAcnLXmTOqJ7aPeSujJK9rIDwWo5+GfzWu30qcrSC99EHFklz7M3QevhTBSMZuO0OOgTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXn1LYRsjVw47dIDHA7FW1N3GsWtL5K3L8X5KsYVzbs=;
 b=eVDZ3QuYgIPdnB74Cb652KMf5NiaSKDMpmZv6rQ+hiL4on5cG0Svf4WFiVfTE6ClU9S77DQhIa4Ijo3H6SGoN7z1DOGWhUTUpaJgwGLCMZJQw34kqJeHfdNQX853Vm41KskTizcP7JSvBsR/pXaCMwqZkRcQEQ4aPjc8ZMzVNCo/ecVQSiONAvUePhnq4s37FAy+q0fJFEXJXesgyPrOhPFNKF5lk7s+3nmnGggYLItoDOmKmb+1Uh3MiktKF22z7FVKbIlv7EeEOaoTMUJ1OThTNl7JPIfoE3xCsZ+4YndM8ZMCM/KPs4htYHscKUPVCxrFgS1OOw5PjV95mSEJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXn1LYRsjVw47dIDHA7FW1N3GsWtL5K3L8X5KsYVzbs=;
 b=ZXedKT7fwe/S3+4kpIIJwmwRkcpxLl420YjVy/uLodq0VEYuVqgzxUxYNq6oEk1QrKibqsvQqkfzU6hISMaa/Lojepo3t3g4fcd/U4ULhVuVFKbadGEhPXFCGoVdp8kTVWKBpHMAMKfS41WT8GbG25m/4HKBjLDU2joOyFz/t6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 17:54:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:54:00 +0000
Message-ID: <074a4769-e9e0-4416-9e24-2373c6b7905b@amd.com>
Date: Mon, 28 Apr 2025 19:53:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: only sync on the dependent read fences
 for user submission
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250425072039.4034161-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250425072039.4034161-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 48332884-9087-4fa8-fee7-08dd867da7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVlKdzFOQ2k5a3VVK1ZjNXNOZlFaY2N2Vm1wSlRPQkFuNkc5aTZpVEY2b0c1?=
 =?utf-8?B?ZDNNMEtZZFJIZFV3dVVCM2Q2NkZCQWdTQXdXTC9pWG5ReGdEM0pjeUtHcVdC?=
 =?utf-8?B?R2R3UVN0TXFjMlJTaGJQajFzOVYwT0p1QUY0Zzg0b0U4NWF2bkxVaTUzd2xQ?=
 =?utf-8?B?eTFpeTRENHJ5SmpMenpyMXFOclQ0RUZGcjRUK2w2SkZzMUVrYjNpbStlUjFY?=
 =?utf-8?B?Umt6Wkk1MmoyMy9RaXJ1OVk0NENWclpHYlBuTzIvVlNLSVA1SkxGN3pNSkpw?=
 =?utf-8?B?d3hpQ2xZVldaanBoQS9qRDBld1RTREMrdzNVbFdJUjRhay9CM0lzd0RxMk5B?=
 =?utf-8?B?bUxEem5VcElHVG5DQnkvcmY4bDNneWxPMXVrZFRZUGpDZjBaU0c4YVYzSU02?=
 =?utf-8?B?Y010M0hrbkErMUh1NjRQakxvbTh2UXk5Y2hLVUlnNFdiMVZTM3FtS20zZGp6?=
 =?utf-8?B?VUNLYUZ0aGdnZGVJUjFKVHNaTENiNFB2VzlqaHdrS1VmWDA4OWFybjJPVTF3?=
 =?utf-8?B?MTh1RlNzdUhRVkZhcjY1dG4zNkVOeURWbHp2WmcrdDIyUU90WnNhYnZKZlBx?=
 =?utf-8?B?YnVBeXp3QzZBYlBUcFVDQ3BrN3lPZFhOSVhJSXFhUHR4dE5hZXV1TDIwRE9X?=
 =?utf-8?B?c2NHd3h6R1l5cE1EMkRkMXFBUWE4ZDMrUC9zMlQzL0Vmc2JDRHhYN1c4VlB3?=
 =?utf-8?B?eE9XRGpyVGpxc0ZRS0NLK2htSXBHMzFYVlBGN3N5M2RNZVE4Q0U5c0cyTnRl?=
 =?utf-8?B?TzV0blJ5WGQydW1EOWpsNWdLZGo0UDkzM1FtOEFWRkh6Ryt2RE5ad3ZCcWVV?=
 =?utf-8?B?ZkRPdWo0TGZFVjNSOUtES2RsQUdzRFNkTWVLdGVweWV5Z0lBNExTc0VpVmlJ?=
 =?utf-8?B?NTBlSjg2Skp0UVpsSXFhdHlURVJGM2p1RDRrYktLaU4xRlRTMFIwekN4L2E1?=
 =?utf-8?B?R0l5OWV3b3dXM1M5TDJlMFA3aG85Q1Y4enBwekFuTSttK0ZrSXMvNVdlRVIr?=
 =?utf-8?B?RzMxM2ZHWFRhbzFOY1BiSG1LWldLeVk1dTErb0treEorc0dWeEthUktqSndz?=
 =?utf-8?B?Y3MwQ1Fva09XQitHZ3Zqb0dEKzNlVTFNcCtrVk1FWjNVd3Mya3BtZXJZVnJD?=
 =?utf-8?B?QmlYTE9Ca1BEUnQxNjlXUk43d2huUTM5b3RuZW1INGlpSVZGT0NYbFhaWkRV?=
 =?utf-8?B?OStOWTN0STlOYnhTUjZiZGVNQjlaajFiVTY4eEovL2xQUEJQbHRLZnFKUHpW?=
 =?utf-8?B?OWx2NDFXWHNTQUJ0M2JPbVB3NDg0QWo5b2JtQ0lRYWJ4V2FKL2tocy9zWm5V?=
 =?utf-8?B?UXVDRnFma3ZmRmlEOWw3ZWh1dUFSa0xNWlZBZWdYSlFiNzdubm5XTU1maDk4?=
 =?utf-8?B?eU9oQXFjb2ZCcWJkZmhSSjk5T2dIazdxQ0RMY3lPRjZla1BiUkxGS2htbktR?=
 =?utf-8?B?OU1NSzAzTE1MRGdjcWg5T2pHby85RlEyK3IwMmFVdlc2M0RBQm5ZTHl3QVhz?=
 =?utf-8?B?RkowVklQOGxIQk94aFZIdVZycjZJM1dPS29XVEF3RDB6TUNtakwydDZBbjFt?=
 =?utf-8?B?Nm5uM0NHZmIvOFN5ZUxPUFJCSjI5MlZJeVVMYkxXb3ZleEJPVTBOMGpsYnlC?=
 =?utf-8?B?N3hEQW1VZjN3cDlXcXA0L2RHMmVGVlpQekkyQ3JhTVArNXM3S1hDQ0h4MEtm?=
 =?utf-8?B?MVVtSmlBUWR1eFFGcmxKVmI5VGhnVFFiK09VWlZvTWQrM0VXcGFJTm9xSWVO?=
 =?utf-8?B?cVJzZGZSWUo5akJJUjZzdjhjdHpzQlN3aXlRMEtIWmRRbS9uUGhjZFBjb0dn?=
 =?utf-8?B?aktnclA5dUNjRDNMd0xvY2tHdkpWZjBLaEpqRDg2cXdBeGFUTDk1eTNIRkp0?=
 =?utf-8?B?d0YvS056QVFNblBzOXZwY21RNmZYN21Sc28vdmJWZ2dMRlFNdnE0N1N4a013?=
 =?utf-8?Q?qRGrtqSLxNY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEVWZkllSTVyQVpnN1BncE4xbTJGT3dmTVpDSUVaOThOcTdnT215VkpmTWp6?=
 =?utf-8?B?NDZHbkRHK1VGbThEQjR2cmtsK1V5eEZnSmVsNnRuby94RjV2L3J1cUQ1Sm4r?=
 =?utf-8?B?ZHM4WlJUUkQwbkNvNGRxTzYzR2xjK2FLMDJXNk0vZW0xV0E1LzRsM1BOdkRn?=
 =?utf-8?B?a3krOThabGgyQW8yVElFUmZyeFcvd0lka2pzczRVU2Vwc1VjUU5kaXhwRnI0?=
 =?utf-8?B?d0VPS1J6dXJFUit1MGwxTVk4MWNISzR0NjdEbjVMRGlyY3ZsVElrVFpzRGZi?=
 =?utf-8?B?ODV0NU54SlFVRUdqZUkyamU2WnIyYWo0RFZWREFWS2JzUkt1REtZSVYxclNJ?=
 =?utf-8?B?aUhRTmw0ZVd0NzB0NWJRMk01ZGw0Mm85OWhSQStYRWNkN3A4VE54VVZYeXo3?=
 =?utf-8?B?M3pPdnNjQnhaOGFaamZqZlA4K3phZmhQeGpranY3Q3VGOGJCTDJqME1CZDFE?=
 =?utf-8?B?UHdWek45aUl5RTRuVmJERmlkeHk5bytJaG5DMlZ1elQ0c0RrREQrbTZoZDZL?=
 =?utf-8?B?VHF2Ukg0YUs1Q1RDOHVpNXRkOGR0RG5VN0k0MEZwcEUzZlpmUEZuekg1NmlO?=
 =?utf-8?B?dG5UQ2FiWkFtQXA2ZytWSWI4Smh5UUwrUGtzeVpyMzF0Y1hJR2xBNXdXblUx?=
 =?utf-8?B?eWFWUkpuQkhGS2dyZjhvU0EzU20zRGx5bmxVK3NMaDREZ2hnRTdVVlhiOFlo?=
 =?utf-8?B?M09OZkl6TEQrQ09IMUZJblpKa1gxZVhzM0VTeFFQemRXd2VBU0tIQ2VFajk4?=
 =?utf-8?B?dWduZXNESDJVSUxtaUF2TFB4SFJrb0llUlJRbUtKV0NOZG8zSzFSWE9GT1Er?=
 =?utf-8?B?dStLc3FFQU5Yb1doZEE2N2d4TmZLcjJSbzlEZURRWW1paUFLaWNSNHRyYk9k?=
 =?utf-8?B?Ukp0RlRDT1JXSFdzdzBDQUo2STMweXdCYkNodklJOEVONVRzVnFHL2FZVzQz?=
 =?utf-8?B?ejFpS1pmRFJ3R1JMTUZLQU5vTE43YkhiUXBYVEFRWWNPTm9kQkI3aG13eGpa?=
 =?utf-8?B?STVUTmFNNVVCVmZxTHlLT1FYazJZNjFrODdvYWRiRjJ3ZndPSUNQZGpsSTFa?=
 =?utf-8?B?K0p5N0MrZUxLLzcwaktvV2lhU25sek9JemxmZzRJRUNDK2NVNWVXdGVwRzdI?=
 =?utf-8?B?b2ZidWJ6T2NSV0ZNZFhxWmxsL2psV01JSW56TGRsNVRYcGNSSC9Ea3VFKzd5?=
 =?utf-8?B?K2VKelJscmswWG5KeEppT2M3RnJES2hRMDRmcnh3VmJYRHQwTFd0ZWdjblJ3?=
 =?utf-8?B?d1VRUXBiOXBmNExyejRaczNGbGNvWnoyTExxUXJoblNUaVFKTlBCbndSV2xj?=
 =?utf-8?B?K25YR3VBOXJ0THlBWWRVcUJrckc4TXNET2c0M2VHWlU3WGdVRG1hV24xTnNM?=
 =?utf-8?B?S1FXWnZqaWdnRXgrSTRJa2pod3lZMnpldzR4UmZIUTlXTWY3Wm01cEx4cFBy?=
 =?utf-8?B?NC8yWlloZFU0TGlkYng2d0JoUCtBb2dqM1U2UUEwVHNjZWtZckdLeE1weGJF?=
 =?utf-8?B?NjVXUFdRbFFwZVo5eXVGNy8vQ1dGV0hpOUlQd2UyOTRFZHNIYW93MHlDbmVm?=
 =?utf-8?B?VGdzbFpUb0Jld2hINEZweEJ5YzFjM0QxWFdEeGFueFlWQ0s5aGNMTVg3M3Rk?=
 =?utf-8?B?UThGb2E0SjErdUlmSE5ueFJscURYNThIWmpPU0gwZHp6RHh4RmdOS1dQU1Bt?=
 =?utf-8?B?OXlJalJ1c2N0YXdTZEZ1UG5YVWxsOHhQemtqeVBZZ0JsSU45WnhrUzFMOHpZ?=
 =?utf-8?B?VXR3enlNbEFNOXRPRVlJTFZqdzJKVk52aXZKVnRQaEZyY1VHSnhwYUIvdE5u?=
 =?utf-8?B?YWowVU5Fb3BCTWZ0bkFyOHY5clVxNTEvaGttcWR2cmxQMXpnb2llOWUzWW11?=
 =?utf-8?B?Q0JEVWdNNkM5QjJMWTE5N0srUFUvd2s3ZzNSM0cyQndsZnI3Y1BRNW1pUWRU?=
 =?utf-8?B?Q1BxcnZRT1V4MzA1ZisxUW83MjloRlNQZEUxRFoxWjUvQ28vZHhsK1dUemU0?=
 =?utf-8?B?MGFFWGZoeTNEc2tyZHpYSXlDeGduOEd3MFFsVHpxT0NudktBeU9NQ3VRWXR5?=
 =?utf-8?B?dlBIbGNTQ0dXUSs3Ny91NzhxTWpGR3k0REFQQ0hEUStmbzJwYkR5UWdsOFFM?=
 =?utf-8?Q?WOLiwgxQphxPH4FPUNNY/lvba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48332884-9087-4fa8-fee7-08dd867da7c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:54:00.2634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfjEVwsADxO12jv1RkwonUEtWV0pR/SNaEtOouiHudIX9uwiIjGXDLcovGPm4I65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914
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



On 4/25/25 09:20, Prike Liang wrote:
> The driver doesn't want to sync on the DMA_RESV_USAGE_BOOKKEEP

The driver doesn't want to *implicitely* sync on the...

> usage fences, so here only return and sync the dependent read
> fences.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> index 5576ed0b508f..4e1d30ecb6cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> @@ -249,9 +249,8 @@ int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
>  
>  	if (resv == NULL)
>  		return -EINVAL;
> -
> -	/* TODO: Use DMA_RESV_USAGE_READ here */
> -	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
> +	/*Only return and sync the fences of usage <= DMA_RESV_USAGE_READ.*/

That comment just repeats the obvious. We need to comment why the code does something and not what it does.

Write something like /* Implicitly sync only to KERNEL, WRITE and READ fences */

Regards,
Christian.

> +	dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
>  		dma_fence_chain_for_each(f, f) {
>  			struct dma_fence *tmp = dma_fence_chain_contained(f);
>  

