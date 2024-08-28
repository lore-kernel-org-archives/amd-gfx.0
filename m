Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5BAC7114C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 22:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C3710E601;
	Wed, 28 Aug 2024 22:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UoAXXKVM";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D133B10E601
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 22:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTwrJhLmH9yf9UisXiNCj9C0baJacfT7SSEZ8rVPibJ5Zw6cQ89wDMO3BmUQhPez0VI2VEardZrm55feDtO/cWxffk3d5uS/FmxQLtUn7/dKNG/b7MA4Pt7MMI8b0JKsW96mXJTa+zTqMQwkGUP78hkj5RbTUHiYM60Ntgtfmm4ZaFqgZjkrkaepSo5tFqrnBPRbFeB1FrfUAFmH4Gmn/BXykVsp3XiECe3GRXc8xMki6xxwZcP/ok44L2BWjdv9VCwLLI6m542F/mw7APdz18aM60FgzQcBQxVu48fltI1mQdpZdTAQNKG0vRpZCNsZZ4IGrGsx92FUDvZ+YUcAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIcWMSsblSxTXLiMG0lXOWBNemPwm+5VCi+qPk5/kp4=;
 b=ZSTfa112VBMBqepLw4RagmI77+rvEYmXVk27iEQmaW4aRmcrXZxn8L7YwcsAJCF0MVkWFr5jL0KFSg3xl/sjJ/Gkg0wO63OzYAhHPIimcJ90XeIQGdfG3EumSv/fJhxMiOXJZlw2spFYUgvtlEef8QakzRvu+XQzn1hFEBVBAbHpGNY8FnE/pSFfH+EThLobXXhjWhiNIO4gmUPKMR1WOLVZhnhBKFYb0uCum3EjE+yjtRbGNCf43jnTuZYs1B2e7BEe+pgFcwUyhoTw7FZ2uv9uliXQpc8KDUAUJpSrMAV/9AIrAUFirs7GpsHGABX6yOyVk4rV5Ewdh6bvbqY/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIcWMSsblSxTXLiMG0lXOWBNemPwm+5VCi+qPk5/kp4=;
 b=UoAXXKVMSnTITArRovujM9rkdPvRCQ5xuMrBGWTlV+IIdxv9DEuQRJymBkLl21WSCpI9oQMrhbb63P/plpXbbay9N2JNNmkssP8B30W7NXrsGH1EHoPu3iXln+hqmXVOfkB+e3IbvxJR34LwVRk7A7N1W7zOF+TRK+QryX5YWCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:01:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 22:01:53 +0000
Message-ID: <4d14806d-c6c1-4846-8ac3-459140d7625f@amd.com>
Date: Wed, 28 Aug 2024 18:01:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: restore_process_worker race with GPU reset
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com
References: <20240823194901.25068-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240823194901.25068-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 56289dca-b328-4849-026c-08dcc7ad0671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHRjcC9MTDhSc24wdkNmamplU1c5d01QRDV4Sm9GKzhUQVFTUlF5UWVyZzkr?=
 =?utf-8?B?cXJtNVFaYWRWcDdCMVBjVGo3Z3NuQ0VQSXBXTWFWa0M0ZW42aVQ2VWlFdzJR?=
 =?utf-8?B?RnBxYkptUy8vK01ibnV0WmlQVzRzNklzWCtBeSt5Zm03K0FZLzI0RlZ3b3Z2?=
 =?utf-8?B?cmJnRnNhMWhMZk9nN1JWekxIWTJnZm9haUI1OUE0TFFRTEQvNGxxbDZyVkFx?=
 =?utf-8?B?UE9MbGJ0U2QzUmlyd011R09WRXFOd1BwVklpR3F1NXB6Zk42VlVkU1VXS3Bw?=
 =?utf-8?B?UDdWM3JOSVppT2VnUGFyM2ZTNWszcTVDVldOOUlENWxDWXMwbnBVWlREZ1Z6?=
 =?utf-8?B?VlZNaGpka2oxT3o4L25lU1oxS0pDZmlCOWJhZDFlMjdCVDhsandVRVc3U2tk?=
 =?utf-8?B?TUx4TlA5cWFrMUIvNG5oOGVLbCs0SFFEa0swVWhuM04zV294ZE5UYjhYZlJs?=
 =?utf-8?B?ZzUwVWlhWEFGRG1lbDZTREk5U2QwZFR2SFhROXBoS2wyZ3V4RW9oeEI1dlU0?=
 =?utf-8?B?N0xPREdpRzdRaXNPZWsyZUdabXRabCsvRDNza3gxNk02cDZleTZHUmJzZWt6?=
 =?utf-8?B?MkVQSTNXN2VoQkhFcGZqZFljNVB3b0tFZHFVeHRXSVlnOVgvN1l3djB0QUFw?=
 =?utf-8?B?MGw4c08vb2toMzRTWFVKc2Q3c0E4REo2SlhYeVlESS9PcmlXd3dIMENWblE1?=
 =?utf-8?B?NEUwV0w4YUJnVjdtS245dVhxeGtlQjVpTjQycDArcWV5OHpsakVOUmFab2F5?=
 =?utf-8?B?bGZaZUhuOHJlMTFqQ0Y5dklkMmtpMnJ0dUxDbXhmaDE4c3kxeHUzRzQvRjcr?=
 =?utf-8?B?d0d4azU3bWtsblFGeFp0OXYrZ2tTMm9SRk1rcUZRME8zWDNvQmdxQklwL3ZM?=
 =?utf-8?B?SmcrVStWRUtZN3J4VnlGSXZMT3dJdCtzWDBHTFJ6K3ZpMDZkR2loVUpnQkZo?=
 =?utf-8?B?eHpROFFOYnNnUU03MFhQamF1R2JjL2loWERzQjZsSEdJSjZxNVF3WlVFYUNx?=
 =?utf-8?B?cnJlOGFWeGUzWGQzOTR3SDJHZnFHZkRjdmtqeVd0RGp2dFFvUXdtMjFSTUJY?=
 =?utf-8?B?WmNLQmRnODhPV3VNVzBNdDBaV2ZaTm1YbVFibnlZcE10dWhwNEZnZVYyc0ND?=
 =?utf-8?B?am9tbHEwejdLSEVkSHVGZ0pHQkFRcmo4cnQ2bjdKM3ZHTDZIZitPa1M3RmYw?=
 =?utf-8?B?ODVxQVUySGsvNk82Zm9SbVlRdENZMlBNK3l0SytoMlA2a1E0OWhTRERBTXlk?=
 =?utf-8?B?Rk9DQjU0SXJkbVp3cUMwRWtvbGExdG1XKzJtUGtZSnNFd0R2bFR3Qjg0K3Fr?=
 =?utf-8?B?QXViVjdqaXdIK1FRTTRMSzFOOCtQanR0dWNRbTFUYTYxNWVoYzVKeXVHTHh6?=
 =?utf-8?B?TzBtZnE1eXBHZm1ERHlqMEdRQXRaM2VoV25NenFZUXU3RUh4djFDSkgzT1cw?=
 =?utf-8?B?bmpudmtib3FwYnE1VS9ZYXNCQTZrMzR0dXBCK3pySlhFcmJ4NXVDTTJIcEht?=
 =?utf-8?B?MGdDS3Q0b25JY3ZEVnh2a0tlUmhwUlN4aWIxTTgvSTdRV0o5NWVpVmwxRXRY?=
 =?utf-8?B?REErU1pIcXcwanZLQ3I3VVpMQThPRDZjbmxQWHhXRHc2SDF2bVk0QTllbUZB?=
 =?utf-8?B?bTJlNThJZzJveGtoMnFFWFFoT05uUUoycWN1WnhrbkgwVk5tNXc4S1N1T2kr?=
 =?utf-8?B?S3c2Y1psc3pORGw2aTY4MG1ETTlobTlNcHVmV1Z5eEdNVy95L3pVTUhNT3VJ?=
 =?utf-8?B?Yzl0RWkyMjVyTC9wZzFEY1lHZjE1V3BabFZ4UUxjaXVaUks5SjJwaDF0czFv?=
 =?utf-8?B?N2k3cmFrRy9DdWFEamxGdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxxM0FXdm55YlhVQXpsOVcvK1FQVGJ6TUxucmgvMDVtWTJac1JKejJaeWxh?=
 =?utf-8?B?OFplbHB5WDJWbWZueDRmTWVhd0VnSFI1dThPNnVDQnJ4blJVc1lhY2Z0RWNl?=
 =?utf-8?B?aCtuYk45cUtlTjJtMWE1YWNJa3gwWlI5TGh1SXVhU2s1ZlpMV2hiVUJ4ZG5U?=
 =?utf-8?B?cnArNkZBY0VqMzQ5bWV5OExRWTFCc3RuQXI2NjJMcnB6WUhsaGJTTXE5R2Fl?=
 =?utf-8?B?TUtmQ050Zk1KZE4vU3BWYVFqcEZWK3o2WWF3dlllOW55TFBqamMyZ1VpbE5k?=
 =?utf-8?B?cnF2dVNrNU16NjA4ckQydDB6SFZFS3MyUVlCelVGUWVDSkN3Q1UvSCtwZVpw?=
 =?utf-8?B?bXZuZUJFN3VoN0lTTllpLzQ1WTFENEptdnRZMzNqWlB4RGhwb0lYN2dTK1RE?=
 =?utf-8?B?dHRkWS82K0pZekYvQUdCNW92Snp2elVPY0FvWjZQS1J4WGc4ejlSeEJBdHpj?=
 =?utf-8?B?MkdTczFXU0dDT3dKN3puTXQ1bGhhR2NUbXAxeGU1ZitPM3RyVlRkVUpKNzk1?=
 =?utf-8?B?R2xSTGFZOS9zS1ZpY09pRW81Vmh2Q09DeTFTTmF3RDNQc25sOStZV2hLL3Z6?=
 =?utf-8?B?VkZFd1YyUkxYWWVScnREd1M0NEs3bXNnNFVsdUxGWURjTlc1Q0JRTU84YXk2?=
 =?utf-8?B?V1g0Z0ZSWkdRdlZnMm1yQjkxZENndFNnNDBNaDVpQlpzcm8xQWVYT05RTzF3?=
 =?utf-8?B?QVJEdnVDYXROK1daRmREY0hndDEyK3kzNXdaMVhyMTdFOGpNS3FGK0xycmlt?=
 =?utf-8?B?d3B5Y3BkZnNjdHowemcrMnhUejJCNGtmVExaQ05ITERSeFRHT2NQMi9aWmFq?=
 =?utf-8?B?VklJTnBJSDNrVExucmtPOG5FcWhFTGRmQ2x2YTY2V2VwQTlQbGlzRDNCRXoy?=
 =?utf-8?B?cmdtR0R0c3RXbHY2N0Fza3FNRHl5Y2l1OWhORzBCMEF6L2svaHROZDlueVJu?=
 =?utf-8?B?YWtuNmZ5dHpPd1UxZzBNT2toWkVlL2VpNzF0Y0M1L0FYaGs1N0NUYVR4R1U5?=
 =?utf-8?B?YUU1UEJ2WVE1SWNueDhoSUgrckZ4cEF0NHAyNG1kL09VRy9PMk1OZy82NXdT?=
 =?utf-8?B?RUU2RWUrb3VnZzA2MHpZK3dKaWFUMnBCdExzQ2J5a25tcklwUG15Sk81YjB1?=
 =?utf-8?B?OGxId1pUNnJDVmI3ZUZBK2MxcW13TlpBQkMvVGx5Nk9VQlZobU81UEJoQzhH?=
 =?utf-8?B?K2tDNmgzSENJSFRqMVYyZmFKWXEwemQ2M0dvWjNMOWVPNitPZ3BPeU1XWVJO?=
 =?utf-8?B?R3ZsaTQxNE1QZmluYmlpZHd6NWdZU25zanVhbHlmWmdKbk5OSmY1UW04YU0v?=
 =?utf-8?B?aHNjRmEweHRGOEQvcnRuNUx5L2xtU0NpczNESERCUi9OdEI0YVZlaUI1SXZi?=
 =?utf-8?B?eDVqYXVxNlhzVHQ1dkZ2WXh4OE9uSnFkbmw1bGhCR3ZiQW03WjlrR0pZb1Iy?=
 =?utf-8?B?REdmeDNkWnhkRTFyWWc1MzdWMSsrWWhCU0NJQk83NXR3Wk1YMmV2WjJ3bHVX?=
 =?utf-8?B?Z2x4eFlkY2k1U3hIWDlmUWhPODJLenNHV285UXZHdk53Q2pVZjlZcHRGZ25w?=
 =?utf-8?B?V0VnMmpRS1YrdkZPNkg1RnRySGhOa0dxSFY1SHJnbU1HeFltUGc5RkdhNkhQ?=
 =?utf-8?B?TGpwZllHVzFJR1ViSUlIL3B0aHplQ2loeXlKeTVrcnA1c2lIalNmSEFpdFBN?=
 =?utf-8?B?UGVPWm9vcWZlRjJqMDB0UjdmQmZCbjVWQ2tUWXg2MXJhT3k0cDF5OTJGbnp4?=
 =?utf-8?B?eml1N0lSOGVNc01hRnZMa3pHZU11YkJQUmV4ZGoyWHVlL2ppZkpnYjNiR2oy?=
 =?utf-8?B?SENnQXl2WkpJMG5vK0lsYUN0aHM3bHZOS3RpbEZyMzJPcFdJYnIvUkdMRGJt?=
 =?utf-8?B?SzNWUExMdEFQQ2JtMHBTYXQ1SU1wM3lZR2ZHOFlvdzlnU2V6NXdkN2d3cU5q?=
 =?utf-8?B?NXN0dkptL1VtcVZxRHhEeUIrbWlUUitvWThHb3BJN1RmN09senBzNzZzdlpP?=
 =?utf-8?B?VkEyM3hLOWJicnVMVlAwWCtNVk1nOEM1U3JUMmhCVm1MVnRlQ295MHVXWjBU?=
 =?utf-8?B?a25iU01TSjFRRFA0bExxUzFzL3N4SFZDK3dpZmQ5d09UMjl2eFdhNTNjTXdY?=
 =?utf-8?Q?PFsY3ZsyUCvNXzniWHVBy09ZZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56289dca-b328-4849-026c-08dcc7ad0671
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:01:53.2540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiC98EAQjOYedibzRNjddSzE7dYc1f2fTDwHCsnPt3aUBK5f71enFcG+U287ZMjpoqnC59ZlBGXHCpkI1lbSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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


On 2024-08-23 15:49, Philip Yang wrote:
> If GPU reset kick in while KFD restore_process_worker running, this may
> causes different issues, for example below rcu stall warning, because
> restore work may move BOs and evict queues under VRAM pressure.
>
> Fix this race by taking adev reset_domain read semaphore to prevent GPU
> reset in restore_process_worker, the reset read semaphore can be taken
> recursively if adev have multiple partitions.

Are you sure that an rw_sem can be read-locked recursively in the same 
thread. I can't find any evidence that this is true.

Regards,
   Felix


>
> Then there is live locking issue if CP hangs while
> restore_process_worker runs, then GPU reset wait for semaphore to start
> and restore_process_worker cannot finish to release semaphore. We need
> signal eviction fence to solve the live locking if evict queue return
> -ETIMEOUT (for MES path) or -ETIME (for HWS path) because CP hangs,
>
>   amdgpu 0000:af:00.0: amdgpu: GPU reset(21) succeeded!
>   rcu: INFO: rcu_sched self-detected stall on CPU
>
>   Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
>   Call Trace:
>    update_process_times+0x94/0xd0
>   RIP: 0010:amdgpu_vm_handle_moved+0x9a/0x210 [amdgpu]
>    amdgpu_amdkfd_gpuvm_restore_process_bos+0x3d6/0x7d0 [amdgpu]
>    restore_process_helper+0x27/0x80 [amdgpu]
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 56 +++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index a902950cc060..53a814347522 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -35,6 +35,7 @@
>   #include <linux/pm_runtime.h>
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   
>   struct mm_struct;
>   
> @@ -1972,8 +1973,14 @@ static void evict_process_worker(struct work_struct *work)
>   			kfd_process_restore_queues(p);
>   
>   		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
> -	} else
> +	} else if (ret == -ETIMEDOUT || ret == -ETIME) {
> +		/* If CP hangs, signal the eviction fence, then restore_bo_worker
> +		 * can finish to up_read GPU reset semaphore to start GPU reset.
> +		 */
> +		signal_eviction_fence(p);
> +	} else {
>   		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
> +	}
>   }
>   
>   static int restore_process_helper(struct kfd_process *p)
> @@ -1997,6 +2004,45 @@ static int restore_process_helper(struct kfd_process *p)
>   	return ret;
>   }
>   
> +/*
> + * kfd_hold_devices_reset_semaphore
> + *
> + * return:
> + *   true : hold reset domain semaphore to prevent device reset
> + *   false: one of the device is resetting or already reset
> + *
> + */
> +static bool kfd_hold_devices_reset_semaphore(struct kfd_process *p)
> +{
> +	struct amdgpu_device *adev;
> +	int i;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		adev = p->pdds[i]->dev->adev;
> +		if (!down_read_trylock(&adev->reset_domain->sem))
> +			goto out_upread;
> +	}
> +	return true;
> +
> +out_upread:
> +	while (i--) {
> +		adev = p->pdds[i]->dev->adev;
> +		up_read(&adev->reset_domain->sem);
> +	}
> +	return false;
> +}
> +
> +static void kfd_unhold_devices_reset_semaphore(struct kfd_process *p)
> +{
> +	struct amdgpu_device *adev;
> +	int i;
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		adev = p->pdds[i]->dev->adev;
> +		up_read(&adev->reset_domain->sem);
> +	}
> +}
> +
>   static void restore_process_worker(struct work_struct *work)
>   {
>   	struct delayed_work *dwork;
> @@ -2009,6 +2055,12 @@ static void restore_process_worker(struct work_struct *work)
>   	 * lifetime of this thread, kfd_process p will be valid
>   	 */
>   	p = container_of(dwork, struct kfd_process, restore_work);
> +
> +	if (!kfd_hold_devices_reset_semaphore(p)) {
> +		pr_debug("GPU resetting, restore bo and queue skipped\n");
> +		return;
> +	}
> +
>   	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
>   
>   	/* Setting last_restore_timestamp before successful restoration.
> @@ -2031,6 +2083,8 @@ static void restore_process_worker(struct work_struct *work)
>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>   			kfd_process_restore_queues(p);
>   	}
> +
> +	kfd_unhold_devices_reset_semaphore(p);
>   }
>   
>   void kfd_suspend_all_processes(void)
