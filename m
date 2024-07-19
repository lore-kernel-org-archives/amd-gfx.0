Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390E8C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 09:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD30110EB86;
	Fri, 19 Jul 2024 09:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cRFCxRum";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CDD10EB86
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 09:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIqB83IRwD8RYBRrfb092IIlo3k7lddmtkCybfoAfzsq5u9Ge4e0V+MQwtDxtVf3NESFoZocDWDIpJqKxzGy3djJqU4uqFcBzJ+PsyNf1oSulcxLVFnH3XqcBNSj7i0TVx0TziepvCQOoamx35kXtHdO9z6kZ1zlgsKCxu0bqtZ003bnb0iipslXkbZx7vamsmZEkXBatscCflUNamJlW++vgdMtb00pxrd+H6DFt7tzsE7DB+/uMSs8badCKume3cLBTLzywCh0gbtwbkx+XclseuCduSoFNIHgfZMrH+Hoiqi4+2zrSlpr4ueLu8Dyzx3R3tT6vqOvNl5y30gyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l3gbxLFKDy1Z71L7YbA+t/HcaYDZpzqPYWO+xRlts0=;
 b=MuKGLRITOqihdascnf29E+9ZMJ5If3NcqCLzWdlZyb9UJrkobn5/alBpMeeA43dPEID7i+cmTHuxp/Z+PXYq8GxlYveV3Wu2f9T3r/wIakxSgyopsdMQYT13l0n8JjoG9LPcpdY+iKdVLKF3+GdMwPXhbqPT5ayMQ2TtB2OSc8MaIDnJ+hCfnhGDn4OSNxjEE8uiFml8sedUCoTfIjP+pJHgYpe6z2oB3dNrE644cQG34SRHLTlbJv6/+l8OaMTgHjs/ZhiXWane2r4HCQEt9VBB2z1b0mCNv2RKok2QGPng10KYinVINgq6268JOXfR3x2ISfsp36uFR/0X9ImFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l3gbxLFKDy1Z71L7YbA+t/HcaYDZpzqPYWO+xRlts0=;
 b=cRFCxRum4t429Fu4K60267rkg1O3cH8GUTkAgP0M0B4w2D7lGlMQ6Jt0yF+V7INldzPnzKBNtlwSXYvAWadug15OSpnuXE4kaPCX0Zolcy/IwEhdG4LdL6kvHDCdVUM9obq0SPAzjC9CCS3XlAyIRbAAnvbjxy9nlUlWmSIrt+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 19 Jul
 2024 09:22:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 09:22:17 +0000
Message-ID: <e9f270ef-aacd-4874-b401-e4871c990692@amd.com>
Date: Fri, 19 Jul 2024 11:22:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reset vm state machine after gpu reset(vram
 lost)
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240719091921.1213270-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240719091921.1213270-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0331.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5549be-14ef-46fd-cb63-08dca7d448b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3lhcjdTaFZPNnBVbjVFSzNoTlVkNUdpWFNuK2hZcE0wNWN4amVXR2dzaGtN?=
 =?utf-8?B?VU5KRFVtZVRGSmszdzFMYTB2R0NVQUJZVWIyanhoMUswanpCYWdWdmVyUHVY?=
 =?utf-8?B?dElqdkFJaVRUUlJHYndtNWJtdlA5enNuNkRQYnI0NElMZGRNSlNHOEdCSFRk?=
 =?utf-8?B?OTJ1R1ByeXRSZ28wemllU0pwZDhRZmttS2ltRnZGQ3hiRGs3SnhnTVZ4bkwx?=
 =?utf-8?B?UmxhNUU0RnFMTWFvSEZEQjUxdjU0NEJOK2ZFTjlDTm9BQmt5Wjlxc1I4cVVk?=
 =?utf-8?B?M1ZWSWg0VXpaRFJIZ0pWRkpHWWw2V28rNzE2QXk1Q1ltS1kzekgvY2djK3lk?=
 =?utf-8?B?OXoxR1ViRGxaV1dHSDhNL2t1dXh5amJ1VzU2UExhb28wTlZCenFObWpvdU8z?=
 =?utf-8?B?VE51L1RIZnMzUkdaald1QXlZeHMzMXJ3enVNUU5FWk5ZMUY3U25OUFdDbXNL?=
 =?utf-8?B?WFcreDJiUkdCZVBnd1E3N3FtazhiSHQzZ1h2OVU2MnVGNHFDR1lWdWRNTHc5?=
 =?utf-8?B?K3UxaXJRN0hwTDVLaHFmYjlNQkpWcGpNUHNpM0lEZjloeDdjak04UDJJYTdR?=
 =?utf-8?B?eEJXQWR1YldNVVlTSGcxdWRYWkdMRjJ2ZGJpTnNKeFdxbHZYUkswZTd3NWtq?=
 =?utf-8?B?ck1nUHJNVE1UM3A3T0czTy93MlZBQzBLTkJ1NDFINUFiWkpPUkxyTldYOGhT?=
 =?utf-8?B?T2VJQXNQZHozZEEvVW5JaUpjN1FYQlB4SEpkdVVoUlJSVXhiWnFvREdFTWFp?=
 =?utf-8?B?Q2xTR2RXSmdSM2puVUpCSHJlOUhBWGxDcHdJQSsxc1h1OEFxQ1dEZkhSVEwr?=
 =?utf-8?B?cUp4VFlZbkhYWW1ZakFrSXNvMU1SdGlaZkNSQ0xXNDJRSzRmQkR2dDRmcmlo?=
 =?utf-8?B?N1IwYjdnY0J6aTlZVTVCM1FQbHpIaVEvdzduNWRTcEJTV05vRy9Ebk9DUW9T?=
 =?utf-8?B?cXpxMUpXTDIxNThWUlU0NFNoL0IvYTBqbjNsekpHbTVxeE9FUHcwaER2UlFu?=
 =?utf-8?B?QUloYWxHSmk3U3QvcEdnT1FKeTM0Zm5za09SdFRQN1JzTDZsZVFrMURaRG5Q?=
 =?utf-8?B?bVdtVnQzT3YwbVhXeGVzcTRHOWF4M2VsTUhrVFdzNy9ibkNLSTJhZFA1VEZx?=
 =?utf-8?B?TEltU0p5SUVRQ1A2Nys3R3E0d2FSQUVWbGtqbTZPbFVTb1ZGOC9UdjNTQ2pv?=
 =?utf-8?B?SlhJbHJYZE1Zc2xJbmpYSU5pQjI0Um4yUXRxM014dkNBRXMzaHRMT0JnclVa?=
 =?utf-8?B?REF6djFqOU1GSlZlVkJsWjJXN1lZaTRXNjRsTnd4VXJkYThQaHRTcDh3UWEx?=
 =?utf-8?B?eFJ5emRrTWZXWVowZ1VTMjc3U0FjR3JUTi84S3F2UzM5Um5ZTERKRHZPL2g0?=
 =?utf-8?B?c2dFdDdlM3hwSWFZelNrdTVqSXdiV1lKSWZoOXA1K1lsclpjYTVsbVhPUXkz?=
 =?utf-8?B?L24vQVErYXc5d2Zqc04zbThiMHhJZlpDK2dtUkdxYTFBeHNuZURsd2VlMWpl?=
 =?utf-8?B?WCtUZDBhWTZsSjdodEpQS0ZGdlNhOFhhOURnSWtMVEtXb0srdjc1TWxPanRu?=
 =?utf-8?B?Q1ZEVElTRTVJWWMzWGxDQ1A1NnlnVUZBb2tKMDBxNzYvSUo2L3FaeWw4dUNj?=
 =?utf-8?B?U1dVbG00NnZwYTdSTXJ0M2JHcjJqeEhYNWxFZ3JnRWpUR1hpSHdGN3poM2RS?=
 =?utf-8?B?eS9IUGQwdy9KeWdJNGZlck8ySkg2SmVkbnkyQzRxdjdDUllxSGVrQmF4Umh4?=
 =?utf-8?B?UEN3UFc3N0gwN3A1ZU4xV2ZxN3Vqd0pSdWpjbGdyZkczb3hPQWp6RkVmT3FR?=
 =?utf-8?B?dVJTcjBlbGhnd1FaZG40dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHlnODBReTA3WEdlb3dnbzU0K3ZKSWRjOS8xZHIvTHhNcEQ2dlljVnBpTXZT?=
 =?utf-8?B?QjRLYW9QTkhYK1hmbGZHU2lsNEtpbEh3bEh6T2lFYiszYnZhcnl1NmF3VVpR?=
 =?utf-8?B?RFk2TjVSRWljalZia2YzdkVCbWdyd2RoWDhPZVNHcU9yOUZEZTJhTENpb3RI?=
 =?utf-8?B?ZWtIY3REU2RQWm5ub0w4ZXYrTnBBdTJEcldCbjJmMU16bkF1czBrTS9Tb1h0?=
 =?utf-8?B?SXhkRkFrVEVGemtmTlpyM3NhMEhHenN1OVU2ZVU2SHBhRTdrQjhrSWwwSDlP?=
 =?utf-8?B?ODRhN1hDSEw4dUF3UEpNbmdiRjRoblVSb1VkY3pyZTJQT3BpTlVBUU9tY21o?=
 =?utf-8?B?UmpvZWd5ZnhtNHJPbGJwbUdYSkZCRGJ3VTJFTWNJUUtZVTdtSmhDVDg3dDNT?=
 =?utf-8?B?K2FZQmdJN0NWb0Y1WEJlN21YSVVQc1Z3WGVXTDhTMmdPcVlMQUY2MnByRHJX?=
 =?utf-8?B?Vkd4d2k3UHhacGZxckxLRlorbHJnTE9tVExPR3B5NGdDdlZqYlpYUDZLY09U?=
 =?utf-8?B?WkhTZFlvUjJFWjg0UHZSemJpT1Rtc2dMRGNsZjZkNFFPN2RVWUpRZlpjakhX?=
 =?utf-8?B?dXpCTnhzczNFL1VlK1hNMU8xK0VqVG9KbDFWN2dDU2ZFMWdFRXN0dWpsRmdF?=
 =?utf-8?B?YkVacUtmdFE1T0N1NlYvcElwUDdxKytFR1cxWnN6eUMzOHR5ejJRejU4RThu?=
 =?utf-8?B?RitSYzlIdVdYM1RkREMrVnpSYVhLN0FJT3lFbkpydXJ3T0kyNno1a0Iza2Zu?=
 =?utf-8?B?VHpnbC9qekZiVkZMaUJTc0MzL1lhd0NFNXhCTzFZT2FJa2V2VE5BeXdYUWcw?=
 =?utf-8?B?WmFmdzEzS0h6R25iVTZ2a2ZNa2VNa2tvUVo5bHhyVWF3Z3BSZnNUQnZNSGpj?=
 =?utf-8?B?eTFxZzZiVkRwTEw2RHdLRnJRMDczK2FtbFI3NDNibzhzSXlWa3BqUDluZXUv?=
 =?utf-8?B?MUgyOEc5UGozWFpJUFloelF6aytlUUgxUWJnaXpLVVVKOFFoZFZzVDRadFhC?=
 =?utf-8?B?dGd5TnE4SWZzSXNjb0Q3NCt3OHV0Q21wanRYdjJlQVVidjh5RjhKRnNMZ0Zl?=
 =?utf-8?B?cU9BMVQwWDBtQnhYQnBLZHZmSGU3MnZBYU9uZUpTYW1uSVVKUytHWWpwM20x?=
 =?utf-8?B?UDE0cHpUaElBMmdybzRxNk9meHhVbEpDMVBMeGJrSFBQSTdkWEh5S2dkSStT?=
 =?utf-8?B?dWxIZHRYMGtPVi9NbTAxVml1RXo3ZC9DKy9iTUNSU3dXYzFzY0JhMGZvZ2dP?=
 =?utf-8?B?ejZ3cXFVVVJMSUt3d0JrWUxob3JYVzd6cUxxZ052U3E2bTRrM3pnekllSXRa?=
 =?utf-8?B?dUR6eHRGa3E5Wm5SSWd3c2hDY0RqVVFSUlVFK05OYnpvRVJsMnAxVnJ2ZUxC?=
 =?utf-8?B?VVdLUnRMMHc2Z01sS2VkcXNEd3NNcjBqUGUyS0FFam1URnZKVStJdkNxbzRm?=
 =?utf-8?B?REZVNklYWHVtYmdNRmxYN0JiT1NHV3ZCUDN5NWdORDI3MURyRnJTd2V5R1hz?=
 =?utf-8?B?TlBKN3ptZzdFNUNEMTZaWENsMkJ6endITkZTWUs4eHJwelREdy8vcEZKQjdU?=
 =?utf-8?B?UGJVT2JMYUVabDdqRlE0YjBHY0YrL1FjeDZqUGhHMTVKVlV1OHpybkFuT2N0?=
 =?utf-8?B?SjcreExqeGNHb1FlNXlNdXZIRHlYWkdyQm9SK0ZZVnNJYTQ2VnJQcTFkZ0VM?=
 =?utf-8?B?ZFZVUDFGbFlzVG42ZDNhWUpVa3kyN2p6eGNWOFdEMU5HUy9qZ1ptbTZ1V3ZN?=
 =?utf-8?B?UlpwZ2pHeXVNZW0vZVJBRkl2dmd4aHI4SXRMcHlTTmtBbHp3bUR2RDRaQ2xx?=
 =?utf-8?B?WHFCcjJzdnhqZWhCM0Jxb1BZZzE1Y0FUSzJTOUpmOTg5Z1hxMEUxU293bEpK?=
 =?utf-8?B?T1FreUhsbHIxNVZzcWpYdnlYQzd4QnE1dU9sUTlDN1RidzlPUFMybVBvV085?=
 =?utf-8?B?RCthZ2t3U3c5TU5YNVhIeGlkbXlJZmt0UG53Z0NxYVE3SURsaFJDdTZUa2Vn?=
 =?utf-8?B?akxNNkpDNkVLRmJxOUpCZXZnbXIwaXRuSXh3TTRJNi96NE5TZVEwSlp2bzZk?=
 =?utf-8?B?VkxtbnEwd0hiTmRKNTRGK2Y4MXJlUHFVdTNqZ2tGMGlXMml1b1pmeTkyZkdX?=
 =?utf-8?Q?3tCNSzyf9uxPsQ6ViaePzYhW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5549be-14ef-46fd-cb63-08dca7d448b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:22:17.7405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71pn0crg2no+nEjALGZPZVwNyt9EISn22pPSHHGZI2khGRDhufJ90eKY6IVYkqtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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

Am 19.07.24 um 11:19 schrieb ZhenGuo Yin:
> [Why]
> Page table of compute VM in the VRAM will lost after gpu reset.
> VRAM won't be restored since compute VM has no shadows.
>
> [How]
> Use higher 32-bit of vm->generation to record a vram_lost_counter.
> Reset the VM state machine when the counter is not equal to current
> vram_lost_counter of the device.

Mhm, that was my original approach as well but we came to the conclusion 
that this shouldn't be necessary since loosing VRAM would result in the 
entity to become invalid as well.

Why is that necessary?

Regards,
Christian.

>
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..fd7f912816dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -434,7 +434,7 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	if (!vm)
>   		return result;
>   
> -	result += vm->generation;
> +	result += (vm->generation & 0xFFFFFFFF);
>   	/* Add one if the page tables will be re-generated on next CS */
>   	if (drm_sched_entity_error(&vm->delayed))
>   		++result;
> @@ -467,6 +467,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	struct amdgpu_bo *shadow;
>   	struct amdgpu_bo *bo;
>   	int r;
> +	uint32_t vram_lost_counter = atomic_read(&adev->vram_lost_counter);
> +
> +	if ((vm->generation >> 32) != vram_lost_counter) {
> +		amdgpu_vm_bo_reset_state_machine(vm);
> +		vm->generation = (u64)vram_lost_counter << 32 | (vm->generation & 0xFFFFFFFF);
> +	}
>   
>   	if (drm_sched_entity_error(&vm->delayed)) {
>   		++vm->generation;
> @@ -2439,7 +2445,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->last_update = dma_fence_get_stub();
>   	vm->last_unlocked = dma_fence_get_stub();
>   	vm->last_tlb_flush = dma_fence_get_stub();
> -	vm->generation = 0;
> +	vm->generation = (u64)atomic_read(&adev->vram_lost_counter) << 32;
>   
>   	mutex_init(&vm->eviction_lock);
>   	vm->evicting = false;

