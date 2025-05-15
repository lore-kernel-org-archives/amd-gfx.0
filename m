Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A319DC3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 12:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A0F10E0EA;
	Thu, 15 May 2025 12:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="urYWr21u";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A2210E0EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 12:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZM1zZajkkH0KK4UggGyr+HqO0pj/sBJ710SRuDDXKwI4aciLGJNqMN55TeaaI1icvKSMfHmgDU1SNyGZkpejQrLLcwBqu6r+Y1PQOkXLSzFxgLigeXW4kq2bwT3IyMQTI/atSVjapqUfqjQQPnrQVoza7M45nnL8x1cPr1U4pPkmPMGiw0eGO29OMnVLUUkSP+Bd8YWv5a7IjhH9A9MwMn9i+aewYPWPY7s5uF3BHmvKDFyQ/wlYH0OQaYlvBnhVTvczA3bJBDyjDxr3y08jbdPYIz01dqz63TS+S1Qa6resvB8L3rrkWtTVuiRKJBFr8pm0lYhpQHDQiOKCTZi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKoXsGzKIO07sswmfqtdMXqNJE0TnhC2Bl/0vGm/Q6c=;
 b=MYeuH9phEgL8E6ItB2iiroEsBPF9AbU70QRB4krR5tww1SNi9JEk1K8y6XM6QvjzouxkyBh4E75BYyk1Px6tC5qZR7yO0M2S7eakNiCASvwnqw3MjOrMISPwcmW27UwTnK5Cm8fi4EpCwyIM7GfD1aP55aImlqDg5OyedPoqW826NRUUWBapVmjXtlPibeafyYVp8O/bDqhojaZTXfmG7Dcy69l3stwmsuX1vwP36GsDMehlIJ38lqTUMSEpkyFkkyEBhCxj2+X+YDAIzWKTyix1loQY5O+iAgwccwGbXKimyFS1HUubybfWbwnF566uEznAStpbFVpf3cRTn1h49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKoXsGzKIO07sswmfqtdMXqNJE0TnhC2Bl/0vGm/Q6c=;
 b=urYWr21u/9a4gP92o1Sy4acKu5wVI+duzhFHi4PHAP3/2ywnAf3peDEbM9+dA3Irg6MWj6ETw/Obq5AqwoAq9Whg05mgy1vayHBiTjCDT8uPkNbiWAxDZtvpc+sQ5wslurR01rY7yO1U/fPCCB2u8mJQX/9OaJ6CsarXl+YTog0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Thu, 15 May
 2025 12:18:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 12:18:54 +0000
Message-ID: <f59f0e01-eeed-43bc-83dd-c0b269b45965@amd.com>
Date: Thu, 15 May 2025 14:18:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: amdgpu_vm_fini hold vm lock to access
 vm->va
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-3-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250514171004.4259-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 6149a9c6-1e4c-4693-7eb6-08dd93aaa8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVhOZUJxZlptYVExeFJLQ1NwNFhIbWhiQzhjTzdqeVRhM1hKM3BmakIyajNT?=
 =?utf-8?B?V01pN0pxVThWUU9GejU1SVVTMXJhKzRGQUplQnZTSkNWZVA1SVlwdGhvNnBL?=
 =?utf-8?B?TXQxQXBxczZMYlFiM0oyOGhBWStMRXVUdjZibmQwTDdMSWgxNTlTNGhWdTQ5?=
 =?utf-8?B?anlmL0tOQXJ2Ynloc0Jrd3hIWm8zb3psdDczT0RJWnAvb2V4bUh6Ty8yM2ZQ?=
 =?utf-8?B?YmxqWkFrU0VCY3NLL1I5LzBSeUVLanhBaWQwc2VkcENIdzhGZXZ5Rzc3akR4?=
 =?utf-8?B?Z1VWSlRPM2FYUTFSd0RyK2JaaGU3N2hjR044bUkyejhmanRkN0VSazhRTGt5?=
 =?utf-8?B?b3psQjVnb014cmVrTVNUOGh6VkFLaVNVYXNpVjVhSFowU095OVRHV3RHY0J5?=
 =?utf-8?B?dEt3OVZ3NTVzaCtGMy9TVHFWcDVYYXpEU3paV0xkRlJZSGkxck95SEpYS3lV?=
 =?utf-8?B?VmI2QWNnOEhPd2EzR2o1cHRrRW5hN2VKajdnWW5PWDZoZDloZFk5SWwwMWZh?=
 =?utf-8?B?OFZrTXhKT1pnalBtOFpQVkpNb3dxZVNXMUdIeXNJZE9WM1J5R0NMclVPbTg4?=
 =?utf-8?B?cmk3S3N5Q0FhaXY3NXhsNzQ3OVlSWkZKNnQzbXYzMDIycjRXSUY3MTZLVTdq?=
 =?utf-8?B?YUFBTWN2TTk3NUFzR1A0ZUxiTElBZjQ2bm1VT3dpVTl5dWNMYlkzOGp2MVhr?=
 =?utf-8?B?VU9rUis4NWVCQjArNis4citNR2R5ZERxNTVCUWNzOTlPdnM2WGtsQkV4NFNk?=
 =?utf-8?B?dS9iVkRHUjRLd2svYmlGM1EwRm9mcldiV1R6MEhneEl5RCtkYzdxRlRYb3Aw?=
 =?utf-8?B?RnJiTFdDSmxWSmxQdG4rTzllSGt0K1NXb0Z0YldJeTMwK3NTM0t0d1JEVytj?=
 =?utf-8?B?VEdzVGt3eGRCMHJBck9aRXBBblhJSkxGclVQdXk4S1dVSG9KUTJiUy9Gd3Vq?=
 =?utf-8?B?RzBzaE9ZZDZxYWo5ejRhTldrMTFQUVA0K0svbUEwaVBDdVR0TzZxVHNrMkNz?=
 =?utf-8?B?Qi9IMkJXV2Y5OHgyMWc0cUFrL2N5OGdCMWNXek9Fdi9kN3ozak5keXJUY2pN?=
 =?utf-8?B?V0h6MzZrMUlGWmNqQll4M1JEazJNSXVyRnBUSW5DODkwNHpVNi8xR3BsZVRD?=
 =?utf-8?B?ZlFYZVNybUJVU2t0N1hTbzB3WFl6cTNHQ3QrRVN5amY5U2NzM0VTTHR2NStZ?=
 =?utf-8?B?aTQxajc0eUZvSS9RbWZlVXBsVkdycHVVaHRlN21OMHJNcEZlcjZYU1FST1M0?=
 =?utf-8?B?RDV6TFNZZHJSTDFRbE85WmRuL0lwNVpQckM4OVhPS3ZpWEptdjM3b0xaRkRO?=
 =?utf-8?B?RTdzU2xSOXVzdGNqNUZWcEtMSUpheTg4VUI0Q0xCMXhxYWRHakVBcnkwQmNt?=
 =?utf-8?B?eU12bG5zMTBUOGNjbFU2eHdETEh5L1BjbUNZTU51TnRoU0luendIMnQwUWNR?=
 =?utf-8?B?dlJsdkFIQW1mU3VQV0xNMUtnT1A2YUg2S2dhVTNiQWdFMDFJVnZOYUd0ZDlm?=
 =?utf-8?B?V0tDM2I5ODFCMTltYk45TUtFOER6d3YxeGFrbldOTy96VTF5SXRnMmE4QW5E?=
 =?utf-8?B?NlJkNVBRb0Fia1plWTYxd0lxcWVhNHFEMHNEZ29FTjRPMCswRkwzWU1pOUhT?=
 =?utf-8?B?c3FrUVZKNU1wcFozMXRFZzhvZXRpSmtVemIrU0ZJMnJTY3VWWU9Ja0szZE1n?=
 =?utf-8?B?UXpXYndwcisrMVk1KzcxUTBFdzZ3WG9QNmZRc0l0bE5tbzV5RlBXVnlTcjRr?=
 =?utf-8?B?T1pCMFhuT2Y4K3RUTTFjSzhkTWJlM0ZnN04yZi9ZSTVkMHZCUXhTbXJ6M1l1?=
 =?utf-8?B?cEpMMkJNaFpsNmVMa0Nkdm5oMStHOGdHeHNwdi9jdWhleGJqbjBFWGltZlo1?=
 =?utf-8?B?bFAvZkJCQmN0dlFtSGM4bVk2amlWeFkvZlRsVjA2azhINTBySDE3UE5RcHl5?=
 =?utf-8?Q?VNy9l9sRqV8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNBb0l0YlB0K2k2clMzMFJWRTlXaEpSNFBYRHY1SUJPOEQrVnh2Vnh1ZVBF?=
 =?utf-8?B?bi9jWGRFQ09vd0s5TDNJVGxiUG83amM4U2tNQXFMckxkWFlNdmQza1g3c3hu?=
 =?utf-8?B?eFZMYStNNWJUcnhla25hVnpuZUNrQlB6MGZsTFo0aGFHK2RXd0pTc2pwcjBM?=
 =?utf-8?B?VUVSZWdBeGNyTHJPcHNsMkxzRkUvNEVsY0xaZnphQXdic3BISFFZMkRxb1Bn?=
 =?utf-8?B?RjFWeGVmMG5NczVWOHhGODZZMW5xNFA5TTRIVHNheXg3MFUwNzJodnV2bm0x?=
 =?utf-8?B?a25IREhqd0JuU01NS0M5Y1pnZXpjU0NvSzJjNXk3T0xZVWdnWDdRbm83Vmxt?=
 =?utf-8?B?SFhtbTJ2dG5aTWYrTHU5dWVCbGJycXVBN053QjJSS256eTRIeFAxaWZ2N3g3?=
 =?utf-8?B?OXMrdlVUT2pFd21hNkg3Tk1WSlc4amRoczRuOThyT3k5ZmdUVWI1V2NLaUlV?=
 =?utf-8?B?U1NhY0I0Wkxndk9KS2JoUGc0czdMK084OEl0WW1PaDRTeWU4QVdDTDQxZUxH?=
 =?utf-8?B?TUNTOHlqeE9PdmdNWGxPdEpLTHJmYk43MTRmdng0RG9ySkZvUXJLVFBBNU02?=
 =?utf-8?B?eHFUcVJXVkpFWlErQWFPREh4cmUreVlvTGMwZkQrLzhqSlo5Q0dQcTVrbmo5?=
 =?utf-8?B?S3REbmlERmtYVHR3cWNjZWtpbWVtdDYzTjhYY1lzWEtxZUc4ZnBNQjNSdHli?=
 =?utf-8?B?YnVYanNDL3gzQ2NtRkFqWUNOMUF4NTc5Rk0zeGdjSzJXOHBoYlI5RmhWK0lJ?=
 =?utf-8?B?aXV1M2NaUGdmckdqQjNjOWUxWVM3R3JOREE2ZmVpOHdWMGRyN1c0aXpBWERt?=
 =?utf-8?B?aU9XdEpObkVwUUNBU0JwUFpvMXovU1pOcEhVMGFwVmYzZkE2VkswWXA2TC9m?=
 =?utf-8?B?ZzRQeW1XY1hvejJxLzRncXV6VjRaZ0RyaHFaRnRKU3FpR0VSK2NCdVJEL3Uv?=
 =?utf-8?B?WlNHanpYTkc5M3poNXlla0d2YzNvRjhHMjZYSUVyNTF4OGFRYU1PN3UzeXdL?=
 =?utf-8?B?NTF4MmZxdW54TU5WUXo0STBTMmdub0xTR2tKOXkxWkV0K2ZFZjVVQTliaHp1?=
 =?utf-8?B?QkFYVGV2VWJ4d2R1UGZwYnh4UlFHVGRJTmtldGZMTTFjNm9ZcTJ0U2tEVFox?=
 =?utf-8?B?OThPNTFuU3IzQnp4US9PTjYzbURGNmZRUHcvMDgyVHZSNTJqS0lYNVpKd0sz?=
 =?utf-8?B?Z1VJZFZKL2ZrZFZWOXdyY1JoZWRMaWtoZldaSzJscEhpT2pEL2xtZ0FmL3JD?=
 =?utf-8?B?V2dsaHVnVVF5OGdFR3BUZWYvTm1vbnl6Q29UQ0RVOUNJUWlsLzdpMS9INzJU?=
 =?utf-8?B?MUR1aHdnUzlGOCs4dTBWV0c1Uk02WTU3b29peWJJT2hUbDVERWxaL0pJSURa?=
 =?utf-8?B?U2FZQ3N5dXoxVGNOeHdKNGUzWFJIOWxua1IzNThrWFd1YmNOcGUzMVBMTmV6?=
 =?utf-8?B?b05zcW5NL3E1UVVUaTZ4WlY2TThmSXpmUDY5V0dRTncrcFdpak9aVFdXMHlD?=
 =?utf-8?B?Z0pIUnJ3bDhFQnhNWkh0MGdnMldMeENlMmRXNUZNOUlENnhycmdOeS9ad01M?=
 =?utf-8?B?NEluSDg0d0RKSTlNelBGQTdHUDkwR1Y3c1A1VGR6dzJ5d1M2dmpjMEFqRVhH?=
 =?utf-8?B?UWc1d2ZYZUZZVFdZdXgya05WbndTV0J3TjVtSXVWeGJBZmtCMEpMRUVwQzFM?=
 =?utf-8?B?L1ozVmZmalA1Z2wwMVB2SlFpWEVJK015YVBJTGxuRllKSkpJdXRqZThvSXRV?=
 =?utf-8?B?MzNFTFFXNTY2NUFKOUtUQ2dXbVd3YkUyd1A4ZitGYUZLT3JLdk8vc1lZQmc1?=
 =?utf-8?B?MnRWREVIaXZxRkEvMzhBQlRsVnJveHROckZESms5NTAvMmZPUkRYL0hzOEd4?=
 =?utf-8?B?bFBreDJhREhPUEpNUkpWd3d4ZHlmb1Arak4yai9DcHMrZUk0MjlTZ2lkYmtL?=
 =?utf-8?B?b3UxWElWRDhWZWhrQnZiYlZMWDF1U25LSXBVejdncWVqdmltZE5YNUZMeUV2?=
 =?utf-8?B?blpsZVRERUdUdlBUWUFDRjI4UURaNXo5MmRFUjYrYm90azZHZ2JXS2ZMNzNJ?=
 =?utf-8?B?MmlTN1IwTmhwS3NydWt2TkM4WHM0bjE0eUJkZ1RlS2lzVStvVVZUdzN0bkR4?=
 =?utf-8?Q?hf/t8/4lLqObrMmIma/25IFYz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6149a9c6-1e4c-4693-7eb6-08dd93aaa8be
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 12:18:54.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xJ7i8EbPREwyJH/jYqITkxZhemLF5lutZTDvR9ADiDJJb3Oo56McaaLIxzBUSQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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

On 5/14/25 19:10, Philip Yang wrote:
> Move vm root bo unreserve after vm->va mapping free because we should
> hold vm lock to access vm->va.

That should be unnecessary since we are about to destroy the VM.

If anybody is concurrently using it at that point we are completely busted anyway.

Regards,
Christian.

> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3911c78f8282..fb5baa6ec32d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2740,10 +2740,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	}
>  
>  	amdgpu_vm_pt_free_root(adev, vm);
> -	amdgpu_bo_unreserve(root);
> -	amdgpu_bo_unref(&root);
> -	WARN_ON(vm->root.bo);
> -
>  	amdgpu_vm_fini_entities(vm);
>  
>  	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
> @@ -2758,6 +2754,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  		kfree(mapping);
>  	}
>  
> +	amdgpu_bo_unreserve(root);
> +	amdgpu_bo_unref(&root);
> +	WARN_ON(vm->root.bo);
> +
>  	dma_fence_put(vm->last_update);
>  
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {

