Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A13C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB05C10E492;
	Thu,  7 Aug 2025 20:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9rHPUXc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFDC10E012
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0u3sjM3AlmytuYbsV1B+HAfRpxysFsEjQOEcu46VAVOAQzqmoXpOB06V49KeYUNFdTr3oqFMOqv/H/+c3/Pyh8LTOqAR6RuDomgz54vzrYwM7Z7NWm7TH26Hx/2DrQlN5KUICMqyLIY7nveGb5BFT930jWeNRf5ZwEdVFjO919Ewqu0b1/EAvGuxzYTHqRGn3xb1IeyDcDMyJyuOwDvd53CWDWcL7+uI4xZItQJgyFZMG+J0SGffIp16DVgs3k2ljwQN9KJTHQ0t8CL0p2E8fyVnTUUpJsMCGcuwFvucNCTXH4f6L0cU7abW88YDEQJitMBwIR8CJ03lBpkMQImnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw/x0vNr8Yg2LZNtNsEdftZZp6RsS86ukMEeMDDuhRk=;
 b=OC5H7AkQee0kybnn17iy2G2LSIEe/Tq8TuZqjygLG8o4pjPyn11NBxbQbe3mXDqbsfFkz4bDcJvxXIlgvdU/dnNkGH5MlcGSBjxFhcIaNKl4KmPZ5u+VDsZqd6hy+ZqUlWlso4VaFko3XUOMG91FeNZljav5Ufb+F2SXGerTCm5J7igTUYDUx5kWEQ0NoqBYUIQG50mCY67d4msPjS7ZIsztHJX/gCRoSfZfgAyIwmk7TBA6InO789IuHgkMY3FGlx/vxIldhuxyire4ywen6vFNcI9DzGz6RoHDyH+PPK3ZiiDoPXgvyxqXe6V1jo8RYtm+r2LWikO4tX7P4lVx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw/x0vNr8Yg2LZNtNsEdftZZp6RsS86ukMEeMDDuhRk=;
 b=G9rHPUXcCqHeNz47HEP6kSBOp/6hXkdytrYYilLxV/zRV3dhi2c6TFiWk67IacNUATxub5U+eutZqcQTATLLGYcdeybqPsWi1HGNmDJYieAAHDSAGyDiTsR6iq2p54Z5MIZhe8XlEMYDo3Pg3j8lQM1rB8ufzLkVYb43KEpPb04=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 20:49:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Thu, 7 Aug 2025
 20:49:18 +0000
Message-ID: <f5b91b64-b257-42e8-b741-7f99f641ba06@amd.com>
Date: Thu, 7 Aug 2025 16:49:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/13] amdkfd: identify a secondary kfd process by its
 id
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
 <20250804110550.261311-9-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250804110550.261311-9-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ef8ba8-5e4c-4f79-c149-08ddd5f3e0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUgxUFpKclJoKzBLT0JPc3BLblNXOGpwT1ZIM2ZrTHVFbHc3bnVWV0x5QWJX?=
 =?utf-8?B?Q0JiWmpvRlh4WDVGMGRwazliRmJDcDlTZHFCc1h0OXZnNTlvODZ5UVBGVVkr?=
 =?utf-8?B?OWhXQzJhM2dXbkRKaGlTNzV5MGV1RzVDZFIwbXJsQnF1V3VFMFJwTHZhdXNR?=
 =?utf-8?B?WXliVUNUUlkyS0xORkowRnE5dEF4ZTNwL1BCSzQ0OTEzMGlwckdYYkpnbStl?=
 =?utf-8?B?ZzVFbkxLTmZzQzV3bGZMRTBkeUtTYXJaQ3BLNVY3QmRJRW5PRFRBNHBHWkxp?=
 =?utf-8?B?eTdRL0pHR29lUW1naFNnKytlUHFwVmM3UjZtS2FYcnZwT3dCLys2WFJPSWlN?=
 =?utf-8?B?MGlhZnlGNGRNdldCS1dra3FVdHlmdVJyK0ZvYy9EK2NqR28xeGp6REtNMG53?=
 =?utf-8?B?TGhtanFMdys5d0o2VUV0c3RKTnh3YkNxYU4vQVErU01VTVZXaGZ2SkxldXhI?=
 =?utf-8?B?Y1ZEZjR1S2d3bTF1aGgvYW9HM0Y1Tk9iSTVQbE5EdkxHVHFjUWkydEpGUWNM?=
 =?utf-8?B?TUc2TEdHcXY0NGVON1NnRHh2L2lZSzlhS3Y3ZkFGYVNOT2ZaVkFWbzFTK0xW?=
 =?utf-8?B?a2xBWFM1bGRSUEFaeHIzRXhpMWFYbVdpWFhzUVlQR2dmd0UvRjVWWGM2bCs5?=
 =?utf-8?B?NWJzakxoRHpJUzdOYk5zUWFOT0JQV0srOWw5ZlRLY1ZMWlJDTDhkRDdaeWxx?=
 =?utf-8?B?V285SkhkYktreks0MFdSN0grSzBiVExqOE1sekxrUEh3Zm9mMjQ4NURYVzFh?=
 =?utf-8?B?TmU0TjRyWXdWcTk2UVhrUGFhSzR4K3I0L0Zld1JtRjFHaFRCcTV1OHJrcTdn?=
 =?utf-8?B?UjRUSWFpV3NzS1AzcVByZFpaWThvUFNGNUdEcVIwQ0FWVmxpZUhXK2FRc3V6?=
 =?utf-8?B?NGZOZUVCejBEd28zMGlLSi9Ud1ZWVDZyVEEzVDc4cmFSZXVjRWs2cXFGN3VH?=
 =?utf-8?B?anVGd0VseEVFK1ZoVWVDaDFINEhyT1RrS29hT2lFZzY1UHlLWmFnRmJmd00v?=
 =?utf-8?B?RUYybVR0NUJOMUNOTzJGbTBUdG9ZZ1U3RXNaVG9PN1gzV2ZlYlBzN05EdDdz?=
 =?utf-8?B?ZUlSMHh6UmZVbmJxWWhhYjhqVVo3clpLakNtUDd6aGgzS1JXRUE0bXZVeHJ1?=
 =?utf-8?B?ZE9VcnE2dVo1MWpBUEVXeUZLYTlZczM1K1FTbXdEd0ZNQnNvQXpwWm5YN0dQ?=
 =?utf-8?B?KzBMNnI0NU1URlNWc0lMTUk4a3V6OHg2NllvMUxzMUJTcDdCVmZ5OW1ZVnFP?=
 =?utf-8?B?ajc1TFZ3R0hDdTZsYU5aRWw3TVg1cTNrMXNmWHltT2hNc0FiaHlGSlpnVjhu?=
 =?utf-8?B?bWd5aGttL0FNNUZQeTBEOUQyQlE2eDNSRWtoMnp3TFI0UDlISDl6QTVrQmFv?=
 =?utf-8?B?MXB6V3AvTGREbUh1bTVSTnE2MWxsTlA1WXhBdHdTRTRkSkdlWVRQWlI5Wm1K?=
 =?utf-8?B?R2U5bjFEUG1HR1dpcnRZd01Gd0xYd05ZU01SM3hFSnFtNXRvZnQ3V3JLbEJo?=
 =?utf-8?B?YldMWHJ2SmZGbFRPN0RhVk9nekZaTXJSMEpzWmJUdGJJR08zZThyQnpwd0xo?=
 =?utf-8?B?aGczUVlpNklSa2s0WFZsVzhEdXdlUm5kbjZxZDlmUGZVZHhkazBGNXAxQnNE?=
 =?utf-8?B?a1RJYlM1TnNIa2dha05OcFFVUXV4ZXhCWkZ5cHM2SEpuNGF0SGtiMWZ5Wnd0?=
 =?utf-8?B?ZHBHWnZZTlRGamJRdTFaalNNS2xSbnJKRTVuYXBQUTJTaXhsUFpGa0NCaXlx?=
 =?utf-8?B?UU9oeEt5RERSeWlsQXE0aWk3b0FqTHZ5aTBjNFdEUmZoaDMyRy95T1hnNGJH?=
 =?utf-8?B?ajFRS2FBVTRoS3hpRGdkRHhOU0hKb1BXTjVkTUtJNGsxM0pFcHk0VzViZTBp?=
 =?utf-8?B?M2YzaHo0QmFOUnZ3YW5MdjFoUkd0cjhsTUg4cmlzZkF1STI3Mlk2YmtuN1dP?=
 =?utf-8?Q?+ZHEZHQdgnk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmMzY21QeHNXejVNK0svODJKYmtUYjJLamFBZDBPZmtnMzZ2aStUMVJnOHJk?=
 =?utf-8?B?dW0zZjQ4cFY5OVgwL2JKTzZsZlJ1UFM2bWtlcmdYWXRHalVIVjd4LzhpeVA2?=
 =?utf-8?B?Z0RQTlpnTk91bHpaOGtwTVRzdnYxbTJoUGJuS0V4NmdkYUdlRHd4T2ZnRHd0?=
 =?utf-8?B?RFZqVk5vTjFrL2NKemkrbzkvSmNDVGd0YlBTTjlLbHB4UDhvbHpzZTVwZ05j?=
 =?utf-8?B?d2h5MjB3SXlWNk1BLytTTElQSWtJMDYyNkg2RWZsY0YyVlQ3dmZ1eVhKRkZR?=
 =?utf-8?B?U3MyaHEvN04raEpHeDNNalh2ckc5blRsSkhQNEhuczZ6U3hJMUNnaTVPWi9C?=
 =?utf-8?B?YWx2R3VXS3V6blpoMUZsTTFPV0RWYXVOd2pJVjVwUTZnR3NkdE9pY1JJZGo1?=
 =?utf-8?B?UE5FYkM2bTZ0aXNwa2YrYlpCdW81Y29DL0Y4dTFzWXpHdEtYcU1JR2o3cWRz?=
 =?utf-8?B?MG5ZREFiS2JxNncwWXJkaVl1Rk4yRENvNis4TzAxdk5lZTdrK3BBamhVZTVC?=
 =?utf-8?B?V01VYUdoUzBXN3VzSnRIa2pSZ3VwcjZHWTNYZEhkTGh3djFLcE1uenJhLzVt?=
 =?utf-8?B?ZUgwVFdQUXhqWGFabDM5S0dnQkttbkZSVWlEMFBmWU5VcmtqMnp3YUxZRkZt?=
 =?utf-8?B?MDJjQXJ2NnBkb2xCQXBFbmtvU1NoaGhOZmg4VzYzZnlmemlBRFU3a3YvTnBH?=
 =?utf-8?B?UEVtcXhFdXFVdVdRampNanRtbS9Yc3ZzQVY1c0RuT1kwZm9OUzcwUXhJT2E2?=
 =?utf-8?B?c25YSGd1alNxVnZnRy90WmhZbHVIcUFpV29oUkNZZWdVZmRsMkR6RVdIMDMw?=
 =?utf-8?B?WEdqM3g0RStZcFcwc0k5dUtDQUpNK0hJUWN2Rko4dTV4WGwyK1hCN0pYQ0xs?=
 =?utf-8?B?UmxCR0huRVdBSzFNcnQ1NXpidUxRZDZOdnY4NFVQOTg5SW41azZuUzlmdVFu?=
 =?utf-8?B?OUpZaE9LRkRPLzFlQ085Rkl0U2w3aGhsaDNwM2RPMHdvWi9CeVpHakpMNVVo?=
 =?utf-8?B?aHBGQVNFQTltU1Z2THdTQWt6Y0p6L0xMQWFFQXpZQ2lpNHpuM3ZLcTUyYmJy?=
 =?utf-8?B?QjFwSTZQWi94ZzVsUVhUclJDWHlZcGIrYStseTkxZGxwMXl6bE1sQUpoYlNX?=
 =?utf-8?B?Y0tGMlVFNldpdlovWUN4MlVpSXhLdW5kLzhwKzN0RnpJc3cvWk01eHdLUlhZ?=
 =?utf-8?B?SFFPTHdJOHBOMFRqZjRXNDIxNDY2dU8yWHgvWDBpU1V5OXREU2JBOVBaV3g5?=
 =?utf-8?B?SCtPNS9rQk50b3ZIWnBIZGlGMi80OTd4SHh4TlFDaWM1YlMxZ21pdGFQTjBq?=
 =?utf-8?B?bWVVLzJ0OXUzbU5OY256Y280NkFBL3pzZzlDcTNrTFEyeXFmbVRXQWc0V3dR?=
 =?utf-8?B?aTlOTmVxaTlFM3IwNkNKa0g5aTdYYnEvMG1TSW9oUXdiaEVFclpJNlhYY1Fs?=
 =?utf-8?B?NHZUQnlaUFVMUjIzYjRNMnBCRmZKdDJUREt0MXZhM081QjhBb3N3SEhhN1BH?=
 =?utf-8?B?VU1xR1BuaS80S2NjU3oxamhSTFluRHVmcGxFNlQxaFZaL0VLSGJFZEhZVEl0?=
 =?utf-8?B?Vm15MkZTS0hVcUovNDNOS1dXZlZaR1VMekhwb2FEbEFmTWE5QUZKQmh1b2w3?=
 =?utf-8?B?a1VwYWxCbTM5dmY2dmVQQ0Qxb0xDZmd5TmdMbVVNd2cvUFZ6TTA5Nk5lVzVP?=
 =?utf-8?B?dW02RmZWR0pYeXQyR3g3VzZzR0xKZmFkUnhzNEttU25SRXg0TjVHZjgwVlFP?=
 =?utf-8?B?L3lIYTE3bkF6S0JDWUE2OGo1OXpSKzNmVHN1WGxaV0t1bFhlcVNpS29pdzRK?=
 =?utf-8?B?cDY2RThmZ1ByeERkSElZNksraFFIeW5DZ1pPRjV6ZU9iWk1MSit6WDloZWlR?=
 =?utf-8?B?Wk5RQXBLeVpQUXR0VmJNNUZyNWp3b1Q4QzVORzBYU05Nd2U4elcxeTEwanYr?=
 =?utf-8?B?WXJXenFsVVpLRmFWcHBHR0JkaTkxNW9YM25iMFFIMTF2SjhZWDlURnRtVnBm?=
 =?utf-8?B?dzB0eU16dXA4c3pMVTBlRWhTSkhvbExSc3hPdjBCVkg1Mlo1RmJyUnJ1SHJl?=
 =?utf-8?B?RzlsTWxhNGpOZkxXQkdjSkFHazlvOFhabzRDQk4zWE9iKzArSk1RSFhPajlo?=
 =?utf-8?Q?twE8RP8Qkr0z/y88ZEIL7Ide8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ef8ba8-5e4c-4f79-c149-08ddd5f3e0eb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:49:18.5696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1XfUYoPR1Vx8HI2V76REAMQL6mWiJzvEzRMk2hRhacrDbVO7SeH6BqpQC+v49k/4vAVP+MSGkhDNVN0sRE6Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550
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


On 2025-08-04 7:05, Zhu Lingshan wrote:
> This commit introduces a new id field for
> struct kfd process, which helps identify
> a kfd process among multiple contexts that
> all belong to a single user space program.
>
> The sysfs entry of a secondary kfd process
> is placed under the sysfs entry folder of
> its primary kfd process.
>
> The naming format of the sysfs entry of a secondary
> kfd process is "context_%u" where %u is the process id.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
>  2 files changed, 86 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d1436f1f527d..d140463e221b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -998,6 +998,9 @@ struct kfd_process {
>  	/* Tracks debug per-vmid request for debug flags */
>  	u32 dbg_flags;
>  
> +	/* kfd process id */
> +	u16 id;
> +
>  	atomic_t poison;
>  	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
>  	bool queues_paused;
> @@ -1012,6 +1015,9 @@ struct kfd_process {
>  
>  	/* indicating whether this is a primary kfd_process */
>  	bool primary;
> +
> +	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
> +	struct ida id_table;
>  };
>  
>  #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 5d59a4d994d5..8e498fd35b8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
>  
>  DEFINE_SRCU(kfd_processes_srcu);
>  
> +#define KFD_PROCESS_ID_MIN 1
> +#define KFD_PROCESS_ID_WIDTH 16
> +
>  /* For process termination handling */
>  static struct workqueue_struct *kfd_process_wq;
>  
> @@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>  
>  int kfd_create_process_sysfs(struct kfd_process *process)
>  {
> +	struct kfd_process *primary_process;
>  	int ret;
>  
>  	if (process->kobj) {
> @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>  		pr_warn("Creating procfs kobject failed");
>  		return -ENOMEM;
>  	}
> -	ret = kobject_init_and_add(process->kobj, &procfs_type,
> -				   procfs.kobj, "%d",
> -				   (int)process->lead_thread->pid);
> +
> +	if (process->primary)
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   procfs.kobj, "%d",
> +					   (int)process->lead_thread->pid);
> +	else {
> +		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +		if (!primary_process)
> +			return -ESRCH;
> +
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   primary_process->kobj, "context_%u",
> +					   process->id);
> +		kfd_unref_process(primary_process);
> +	}
> +
>  	if (ret) {
>  		pr_warn("Creating procfs pid directory failed");
>  		kobject_put(process->kobj);
> @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>  	return 0;
>  }
>  
> +static int kfd_process_alloc_id(struct kfd_process *process)
> +{
> +	int ret;
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary) {
> +		process->id = 0;
> +
> +		return 0;
> +	}
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return -ESRCH;
> +
> +	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
> +	     (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
> +	if (ret < 0)
> +		goto out;
> +
> +	process->id = ret;
> +	ret = 0;
> +
> +out:
> +	kfd_unref_process(primary_process);
> +
> +	return ret;
> +}
> +
> +static void kfd_process_free_id(struct kfd_process *process)
> +{
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary)
> +		return;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return;
> +
> +	ida_free(&primary_process->id_table, process->id);
> +
> +	kfd_unref_process(primary_process);
> +}
> +
>  struct kfd_process *kfd_create_process(struct task_struct *thread)
>  {
>  	struct kfd_process *process;
> @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>  	if (ef)
>  		dma_fence_signal(ef);
>  
> +	if (!p->primary)
> +		kfd_process_free_id(p);
> +	else
> +		ida_destroy(&p->id_table);
> +
>  	kfd_process_remove_sysfs(p);
>  	kfd_debugfs_remove_process(p);
>  
> @@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>  	process->queues_paused = false;
>  	process->primary = primary;
>  
> +	err = kfd_process_alloc_id(process);
> +	if (err) {
> +		pr_err("Creating kfd process: failed to alloc an id\n");
> +		goto err_alloc_id;
> +	}
> +
>  	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>  	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>  	process->last_restore_timestamp = get_jiffies_64();
> @@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>  			goto err_register_notifier;
>  		}
>  		BUG_ON(mn != &process->mmu_notifier);
> +
> +		ida_init(&process->id_table);
>  	}
>  
>  	kfd_unref_process(process);
> @@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>  err_process_pqm_init:
>  	kfd_event_free_process(process);
>  err_event_init:
> +	kfd_process_free_id(process);
> +err_alloc_id:
>  	mutex_destroy(&process->mutex);
>  	kfree(process);
>  err_alloc_process:
