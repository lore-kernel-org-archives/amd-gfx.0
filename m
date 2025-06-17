Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90DCC71157
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 10:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528A810E1ED;
	Tue, 17 Jun 2025 10:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5gDTgr53";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2860110E1ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 10:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS8LW7nHkbK0qGlnBrEk58DkRBWsRtFIsKWgNPQ1ZgJl27ZblIupkh8aXl/3XeyEW9XZxOy3T0Js5Vizjj/SXAiONx+ZK57grORZCPBBLGG878pcdXYi+AF5bf7QVTBj7ro9fAE8BEXyX6MgjjxApVpGy+CZDjRIAaKa5U9J3/rAn+KtMBFV2nxarcyEq2vSsvYu6/5trK5wG6jZ0QsNY/QquVuguJqO3zurq20fxJMO/zv5DqIzEdRYUzD46JX3jIweaRv+oN4jbwUwt2b7zI4YIRtjoHqy/IgzTQcWV6mLlasL72Bjls8SW9W5+tXY4vX0ZH57/RxIK9bw5i7xiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zevBRwUROEQAsDgbJiQhzXEyqnolQTIDXk9bZxT4oho=;
 b=OFfxIbATD/0EjbO08zvEG9i48DQmpM2kX0fBFkg4GjG0WY+SgydSo/8kPb/RyWruQSe3HuF2UyqDgRNLA/Y6VJXItgD9r4+lAlff78VdsUR2m3hFLiBA/9MDfYcsaZxr1QfnCyTZR+LRht7s0mUYzKKVEmV0T31EDL7idC9rrkd8f6G0T8hCDEpSAmg5bp4qeIevXJMhON2mHzp14KriCeC3I5nPPogvkjuVn/+ca2dXzgbT5arA1HgMYr4+A+bwX0kEDLHWPilb2Z2V5+mBHbe3cfBvj30t7cxaKoJUiGWjIwtL/X5zKN/hxssOF2sG2Fp8XhdiBaI//5l37wiazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zevBRwUROEQAsDgbJiQhzXEyqnolQTIDXk9bZxT4oho=;
 b=5gDTgr53PpVUx9O+nr8jJpGD03axEPVR8SzuHaDfKm/Qfn/wezT2ld6t3QJ+wiZGOZykQobIxWLM/2DV/vBwOxmYGNWFHbmjGAZPYPjtYCJZXrgYpmuH1ktPAfcKo4WIVC/S5DuWzxG1quCgTjmn/iE//zpF2HG1Qdqp5K4Kt68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 10:12:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 10:12:16 +0000
Message-ID: <36bca859-fd6c-4f8e-9558-39216c963e3f@amd.com>
Date: Tue, 17 Jun 2025 15:42:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 9/9] drm/amdgpu: implements detect and reset
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
 <20250617092243.2769580-9-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250617092243.2769580-9-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 5990b7a2-3c59-4dfb-ea89-08ddad876f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ampRUTY0dEMyd2R0dUZnR2VzaFJDZFJVOG83NmdSQWpyajUvbWdUdU51Q3BO?=
 =?utf-8?B?bGhWVGFrZWdVejZwQkl4QmlGNHJqelpxYWIwWDNjRXRLbkFqU1ZlYzUweitt?=
 =?utf-8?B?SngrV0lGckp5VC9wYlpWeHp4ZHRBRmtDMldXOFB3bTBGZXF2RFZvZmVoTitw?=
 =?utf-8?B?QStjTjRldWJRdm82VUNQMG11UkNTa3J4bWVlbzlzbG5mUVpuckRBRlB1UG9i?=
 =?utf-8?B?azJrb3VUZEdRcVF2ZXhWUzJGRWVBZmQzZDNpaWxRWmRad0lLNTVvZWVxdDBa?=
 =?utf-8?B?OWFpNmkyTE45YmNCWXJQOE1aY3JEQ1VuWUpGNjh0MWNMNUtvVDFZcFN2VlJU?=
 =?utf-8?B?TzVGUnRGbHJ0TGRqM1pHdFo4bk5GanNWN3J6WFUxTzM1c29TRkRHZ2plRnVV?=
 =?utf-8?B?dTBMaE1YYW1XQ2NkUHlwNmpjNzZCRUx5ZFhSWWc0MWJNdEhYMVhiMGJMR1lp?=
 =?utf-8?B?WVFEQWljcUx2OFdtaE1NRlFxaUZBL0xab2xWcENYVkM4WnRIb3A2YS9rZ2Jh?=
 =?utf-8?B?YmxLSStSV0FWK3ZLSG9kVVlFN0QySEdnMXplckE2OFYydWdrYWJGUlZKbzlM?=
 =?utf-8?B?RWJkSEpGMlUrWkM4RUdxVDRPM0pDcVVpK1JoYTRhZ1FmZVdNWVo2SGhKQzJL?=
 =?utf-8?B?WUovZWdIVTJhbG5FbUdyNGNuL01OWTN5K2M0MUtEUlNFWUxPYk8ySHdTcFNN?=
 =?utf-8?B?WEkvYXR1Q0RUcFFmanRiQkVMd0JxTDF5dVR2LzAyWlpQaGJldldRYS9kWlho?=
 =?utf-8?B?SUplNEVUNzZGc0cxMUs4am5TQjRiTXJ2ZGdDYXU5TmphNDdPeEJ6UHl4dWs4?=
 =?utf-8?B?S0tnUy9ORUdFM2FuOGVqeEpkU0cvd2wvQ3lHUjBkU2dLU2hreHA3Zk1mN2R4?=
 =?utf-8?B?SDlEUXpWTWZwNmVFT3RnWHFNMXNBN3IyemxPQ2tDcS9CVFgwbEkwUTN5ZkRQ?=
 =?utf-8?B?anhBcVRtbEwxcWQyZDhCZlVqWkE2RE9yRUd6NHB6dFBmY1o4SGYvM1Z1cXAv?=
 =?utf-8?B?dlJCajcrbTZnTFBSNURYVDRBeW00MXFpcjFtZlJiM1NVbU9WNXdUaHFBYzJR?=
 =?utf-8?B?eVRkSmFuQUZOL3UxM3dpQWZlSVd5bFlDVHBmS3RiUkFrSHZZVTNkNFpiVzE0?=
 =?utf-8?B?bjNmcnBrWldzR1IxWXNKOCtPWWJGZHYvT1dpZG5Ybmd4Q2ordzc2RlJnRVkx?=
 =?utf-8?B?Rk5HdzNkQVpnTWFqRXR5SmliQTdiWk5NNW1lSzVOY1ZyekZ5WmlycWhwZksw?=
 =?utf-8?B?ZWQvZkhEZ01pQzJreUMxTzNvYXdsSUg5QzZTMXN1akcrUFNjaEhNcXJ1aldQ?=
 =?utf-8?B?VzI5MFhiYnlWWjlicVViU2xBZTJ3bDdLMno3M2czL2VieEdETmZzZFR3bGg4?=
 =?utf-8?B?Wjc5VGpRQlVCVm9uQm5OSkNVWHhnT2ZjMUxsRWpEYU10MENxUXVqNFh5YVR5?=
 =?utf-8?B?WlpoOXoxR3pEWHNSbHNTa0syTEFUZktpVTJ0dENCWlpHbWVTdWl6cCtFZ0Qw?=
 =?utf-8?B?aDhjK0NmdWFBRThRMmJEcWozR28rcElTcDBnUGV5bDEzMU85dG9iN0J4V2o2?=
 =?utf-8?B?QzlDMG9rQ0dqZzJnQjY5c2pYS0dabUNQREJZZWpNK0VJMW13a1diQmlJd1hV?=
 =?utf-8?B?MnlPNDQ0V3h1K3lrdUZVWUtIVjFSc1ZVdXdVWXhNVThyQ2p3WTNBUGNOOEtp?=
 =?utf-8?B?RmlOSU1iOHB4MlZsS0pzOEQ5Q2xlNWl6VVBFNVRkWDIrcEsxbkpVVjNKN051?=
 =?utf-8?B?NEp5NjhsOXEweE1vYnFsYnZvQUg4amp0aVJDWEVPL0ZXd2R1WGFSVUsvQUdO?=
 =?utf-8?B?Zmg3T09IS0pYRnBXVUhRS3I4MncrN3ZvblVqeEpzVkhEVUo1SHhaVjFGYUxC?=
 =?utf-8?B?Q05tUW9oZ1ZXVUhuajdYMnZuY0ZwaEZXSGdvTHZwOWJyQVBMb0wwMnV5bEpR?=
 =?utf-8?Q?ZHpSASLyn4s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNDbnR3dGFVWEZGdko4aGNHQmN0QjlBRzUxcU5INmdBRDN0RkoydEdlcWNZ?=
 =?utf-8?B?SnE0UjRpK2hvZjlESlNxVGVBSGo5OFhXYUt6Y0RuS2lacGNLSytiUXJtK2Va?=
 =?utf-8?B?czZQSzhTWUhXb3FKMGJ1UzJBV3dJWFdoM3Q2MllpYWJnKzQxLzNnZ3FYWHRX?=
 =?utf-8?B?TjVLa0pTSWdTQTMrUlpOam9vak9jN2cwK01nRXBPajVyK2tBVVpSUWNWWXZE?=
 =?utf-8?B?SmEwVk4zSmlhU3M4eDhjTUU1QlU0UEU0VnNDcGdNUHJTSE1VM3JkNkZvRXYv?=
 =?utf-8?B?bGIydlFoVkF0aHNON00rUWR6Z2lwL01uOGM3LytOZExidFlkU1JVdnFMdVhZ?=
 =?utf-8?B?dFQ3UGQ5SDk4MjRwV1dPakIzYXl5QXFITEtrekR1RlRWQnFOV3dSdDdOV1Q0?=
 =?utf-8?B?VDhSbkFCNVpFSXNsbGd6eStuajY5V2JKWDVkN1RiUllBUVBsYUlaclRldURF?=
 =?utf-8?B?dGU4TzVqWHpGMWZHV1JuTTFLY0hMVGs2NXQxOHpVZnhGU3hxR3dTM0ozRFp3?=
 =?utf-8?B?S2MzcDBhUFBLaGVJQTdURlZsQ3NVSGN2dWJUQlZYM2dWamZLcjMzMWloNE5x?=
 =?utf-8?B?aDlmdmdxQVo4Y3o2RGgvWEhHdmNqdVcyZ3BNM2dEUWZUang3MlJOUGJLSzB5?=
 =?utf-8?B?Z0Z0QzZ4SSs3S2ZDdkpQOG9hQlYxMDBIOERDWVZ0bjg5ZFgrYk9aWmdocnFy?=
 =?utf-8?B?QnliYVUweUVIWlJzaENJTDErVjdYVUd6MlRwYVJSd3NDUTFBdGZQSnMyMTBR?=
 =?utf-8?B?WnltVml0N3hrdlAzQzJJNmNzWExNVFFjaHBMTytOVVRSQlJWMkNndWxJV1Fh?=
 =?utf-8?B?a2k4MjR2amtDbC9hR2J0c2lyOEV3TWZOUmJwYzh3eHNpY1VNVUQyTThpZjlF?=
 =?utf-8?B?OW1zTlNvU2Qxa1kwL1RYU2dmTW1QbnlQVFJBNU1vUHhCZGV2Skw2d2xMZUh6?=
 =?utf-8?B?ZjdqL2EzVkprQ00za3RoUEM0OFpETURuaXhSaGdKczR5ZHZUZGhsVjNtdmhI?=
 =?utf-8?B?VS9ROWZGT3ppUWdDWXdIcGNxcnpuOGZyTlM0elErY2x6RUdNT0o4cEdFUG8y?=
 =?utf-8?B?TUtTdGlncU9UdXNkVHR2VHRlcWlCNzZnZTNSeklDWTRCcGdsU2JLeFZOcTFE?=
 =?utf-8?B?Uzl1eFVXemlxenZKU3FZcERWaHJRMXJOaXBudU1halVGVDl0NkpzSUp2UG1m?=
 =?utf-8?B?ZGhKd1BNNURPeXcwYWFXTXlvSk9nMWppb1RjM0p6SFJMa0lKKzArb3VGeTVO?=
 =?utf-8?B?WldUbTZjLy9WUjhGZ0hKa2VneS9OYUc3MmR0R0pneUNLc1lvRmgzRTFqYjVP?=
 =?utf-8?B?c2dlUnNBRW9Dc0ViYTNQdXdDUTF2eDZQbGlwSFc2bnEwdlNmOUlyc3cyZkly?=
 =?utf-8?B?KzZLUmRVcjJydnBqdGlCWHFSNVI2aFdUcURUWnZYTlhXYzBlcFd0d2wvQ1dW?=
 =?utf-8?B?OWd4S2h6QnRzVDRPR2krb0tpMHo3Z1lKcWE1M2MvdzhNWGQ1RmV0S1k4NU5U?=
 =?utf-8?B?Q2ZodU84MStSamQvSHIxZnR2YmhlN0s3Ylg0dXJNaHkyMno2dW9tUjBJSmtL?=
 =?utf-8?B?RFRKSEN2ZHVZekVyTVZJWCtaL1BmZWlEaGpGSXhQazlXdnBKL0tIdWhGWGlw?=
 =?utf-8?B?UWcwampWU29pMjBCQ214YUVnVXFoa1Jyc2dpQ0Rqd2pNWkkzVEdITjQ0cWNR?=
 =?utf-8?B?a2VpaEhRWVZFWWF0bVRwQ3pmYTB2ckF4d0pTTjc5dzZSKzF4OHJzTDlmbWhH?=
 =?utf-8?B?TVRYN2daeGpwVEk3TXpZRy82aVlLWkIyUURvVnREV3dpWTI3N0NhMFV4aXVz?=
 =?utf-8?B?SzVGQXRHYWcybTROaTJkallRcnZUWU50Y1NXM082cFp1bHh3SlowaVM0bENP?=
 =?utf-8?B?b2xidk1MTWJLWVNLTkIwYk40c1VDZ0dsY0FqREptMHF6V1NHaVJBWUpjNzFX?=
 =?utf-8?B?T2I0eC84WDZXYTZHaUlVczVDSXJCL0haNUo2WDhmZG9LcWNlZkM3V0lXSThW?=
 =?utf-8?B?cjJER3d4SzFMdkpSNUlRaGdNRVlkRm0rcFBvdnZLY0h0VlBMaHJ2WmlCZmJW?=
 =?utf-8?B?Y3N4ejBldUpVaUNyYmFxYzFvVUJSTnhGQlpVUlRVU2dmRnhDMzJnczFUQy9M?=
 =?utf-8?Q?W0MtElgbDe4N+CbjmByJv7rbu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5990b7a2-3c59-4dfb-ea89-08ddad876f6e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 10:12:16.2472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zFfRsBkmiXYUwjMgI2hMO3Bb5XYtzxGakKZ7BeM+2mnWE2NfthRMzTDb1bhywLS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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



On 6/17/2025 2:50 PM, Jesse.Zhang wrote:
> From: Alex Deucher <alexander.deucher@amd.com>
> 
> If map or unmap fails, or a user fence times out schedule a GPU reset directly.
> 
> v2: drop detect and reset, call GPU reset directly (Alex)
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 128 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 131 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5e2f086d2c99..f1e520b81eae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1304,6 +1304,7 @@ struct amdgpu_device {
>  	struct list_head		userq_mgr_list;
>  	struct mutex                    userq_mutex;
>  	bool                            userq_halt_for_enforce_isolation;
> +	struct work_struct		userq_reset_work;
>  };
>  
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 00174437b01e..6eae2dc2080b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4432,6 +4432,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	}
>  
>  	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>  
>  	adev->gfx.gfx_off_req_count = 1;
>  	adev->gfx.gfx_off_residency = 0;
> @@ -5828,6 +5829,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  				if (r)
>  					goto out;
>  
> +				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
> +				if (r)
> +					goto out;
> +
>  				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
>  
>  				/*
> @@ -6050,6 +6055,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>  	if (!amdgpu_sriov_vf(adev))
>  		cancel_work(&adev->reset_work);
>  #endif
> +	cancel_work(&adev->userq_reset_work);
>  
>  	if (adev->kfd.dev)
>  		cancel_work(&adev->kfd.reset_work);
> @@ -6160,6 +6166,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  		      amdgpu_device_ip_need_full_reset(tmp_adev))
>  			amdgpu_ras_suspend(tmp_adev);
>  
> +		amdgpu_userq_pre_reset(tmp_adev);
> +
>  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>  			struct amdgpu_ring *ring = tmp_adev->rings[i];
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 295e7186e156..5a7c933adae7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -26,7 +26,10 @@
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
>  
> +#include <drm/drm_drv.h>
> +
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
> @@ -44,6 +47,39 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  	return userq_ip_mask;
>  }
>  
> +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
> +{
> +
> +       if (amdgpu_device_should_recover_gpu(adev))
> +               amdgpu_reset_domain_schedule(adev->reset_domain,
> +                                            &adev->userq_reset_work);
> +}
> +
> +static bool
> +amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const struct amdgpu_userq_funcs *userq_gfx_funcs =
> +			adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
> +
> +	if (!!idr_is_empty(&uq_mgr->userq_idr))
> +		return false;
> +
> +	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +		dev_err(adev->dev, "userq reset disabled by debug mask\n");
> +	} else if (amdgpu_gpu_recovery) {
> +		if (userq_gfx_funcs->detect_and_reset) {
> +			if (userq_gfx_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_GFX)) {
> +				amdgpu_userq_gpu_reset(adev);
> +				return true;
> +			}
> +		}
> +		//TODO: support compute user queue detect and reset.
> +	}
> +
> +	return false;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  			  struct amdgpu_usermode_queue *queue)
> @@ -51,15 +87,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *userq_funcs =
>  		adev->userq_funcs[queue->queue_type];
> +	bool gpu_reset = false;
>  	int r = 0;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>  		r = userq_funcs->unmap(uq_mgr, queue);
> -		if (r)
> +		if (r) {
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -		else
> +			gpu_reset = true;
> +		} else {
>  			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
> +		}
>  	}
> +
> +	if (gpu_reset)
> +		amdgpu_userq_gpu_reset(adev);
> +
>  	return r;
>  }
>  
> @@ -70,16 +113,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *userq_funcs =
>  		adev->userq_funcs[queue->queue_type];
> +	bool gpu_reset = false;
>  	int r = 0;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>  		r = userq_funcs->map(uq_mgr, queue);
>  		if (r) {
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
> +			gpu_reset = true;
>  		} else {
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> +
> +	if (gpu_reset)
> +		amdgpu_userq_gpu_reset(adev);
> +
>  	return r;
>  }
>  
> @@ -318,6 +367,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		amdgpu_bo_unreserve(queue->db_obj.obj);
>  	}
>  	amdgpu_bo_unref(&queue->db_obj.obj);
> +	amdgpu_userq_detect_and_reset_queues(uq_mgr);

Is this the intended place to call this? Or, try unmap and if it fails
try user queue reset/ or fall back to device reset.

Also, amdgpu_userq_gpu_reset() could be scheduling a device reset. From
what I see, here and at all other places caller proceeds without
checking the return/waiting for the device reset to be complete. Is that
also intentional?

Thanks,
Lijo

>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>  	mutex_unlock(&uq_mgr->userq_mutex);
> @@ -691,6 +741,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	int queue_id;
>  	int ret = 0, r;
>  
> +	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	/* Try to unmap all the queues in this process ctx */
>  	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>  		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
> @@ -703,6 +754,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	return ret;
>  }
>  
> +void amdgpu_userq_reset_work(struct work_struct *work)
> +{
> +	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
> +						  userq_reset_work);
> +	struct amdgpu_reset_context reset_context;
> +
> +	memset(&reset_context, 0, sizeof(reset_context));
> +
> +	reset_context.method = AMD_RESET_METHOD_NONE;
> +	reset_context.reset_req_dev = adev;
> +	reset_context.src = AMDGPU_RESET_SRC_USERQ;
> +	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
> +
> +	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +}
> +
>  static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
> @@ -729,22 +797,19 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>  		   struct amdgpu_eviction_fence *ev_fence)
>  {
> -	int ret;
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>  	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	int ret;
>  
>  	/* Wait for any pending userqueue fence work to finish */
>  	ret = amdgpu_userq_wait_for_signal(uq_mgr);
> -	if (ret) {
> -		drm_file_err(uq_mgr->file, "Not evicting userqueue, timeout waiting for work\n");
> -		return;
> -	}
> +	if (ret)
> +		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
>  
>  	ret = amdgpu_userq_evict_all(uq_mgr);
> -	if (ret) {
> -		drm_file_err(uq_mgr->file, "Failed to evict userqueue\n");
> -		return;
> -	}
> +	if (ret)
> +		dev_err(adev->dev, "Failed to evict userqueue\n");
>  
>  	/* Signal current eviction fence */
>  	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
> @@ -785,6 +850,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  
>  	mutex_lock(&adev->userq_mutex);
>  	mutex_lock(&userq_mgr->userq_mutex);
> +	amdgpu_userq_detect_and_reset_queues(userq_mgr);
>  	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>  		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>  		amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -818,6 +884,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>  		cancel_delayed_work_sync(&uqm->resume_work);
>  		mutex_lock(&uqm->userq_mutex);
> +		amdgpu_userq_detect_and_reset_queues(uqm);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			r = amdgpu_userq_unmap_helper(uqm, queue);
>  			if (r)
> @@ -874,6 +941,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>  		cancel_delayed_work_sync(&uqm->resume_work);
>  		mutex_lock(&uqm->userq_mutex);
> +		amdgpu_userq_detect_and_reset_queues(uqm);
>  		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>  			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>  			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> @@ -922,3 +990,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  	mutex_unlock(&adev->userq_mutex);
>  	return ret;
>  }
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		cancel_delayed_work_sync(&uqm->resume_work);
> +		mutex_lock(&uqm->userq_mutex);
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
> +				amdgpu_userq_wait_for_last_fence(uqm, queue);
> +				userq_funcs = adev->userq_funcs[queue->queue_type];
> +				userq_funcs->unmap(uqm, queue);
> +				/* just mark all queues as hung at this point.
> +				 * if unmap succeeds, we could map again
> +				 * in amdgpu_userq_post_reset() if vram is not lost
> +				 */
> +				queue->state = AMDGPU_USERQ_STATE_HUNG;
> +				amdgpu_userq_fence_driver_force_completion(queue);
> +			}
> +		}
> +		mutex_unlock(&uqm->userq_mutex);
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +}
> +
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
> +{
> +	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
> +	 * at this point, we should be able to map it again
> +	 * and continue if vram is not lost.
> +	 */
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 0335ff03f65f..649ec25f4deb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -135,4 +135,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  						   u32 idx);
>  
> +void amdgpu_userq_reset_work(struct work_struct *work);
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +
>  #endif

