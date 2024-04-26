Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9CAC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 21:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D642910F36F;
	Fri, 26 Apr 2024 21:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wlZMjo3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9351010F36F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 21:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA6HPFsXSHTXFMpYegyq19qmamMafWGXkfUtHxREpX0QG4QHtQDU6WvZVRKkhBuv9cX4tA9jaoDPGrOanxshtXbqSRDCazbbM+hYQNaZcoIUVKYCZ0QjtIc8ROvUXQ04NAzaXrsIA8rGpLPjERjm+xPAgtMcEkQCmvtxrDg/UK+l/4coDXYrLXRsB2xtCHUwE4YO73Bl1euuFAqIEBGpTPVbn3XjYSMNuBNycRYJC8Y8vIRpVHgvk2sZDLFmaCEC3bJ2iQfCN4QR/0iDF0tpBqLymE7z7rgSXD/y1toafcH3CD75yfhsKx5+v8XGXjghUg9kaD4WoJudAucBVCdl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PMxAzeTwSltFqBYRQxQUc1y9l9Ps5C/rfJoNqdqbOM=;
 b=PKPM/YKLTBEPehJx5jGUeU1GXtrlQPRChI0C8AumeMV1Y9perjKu0LOUKoqddOwUaiLFrJLPW2Dp+Qj1/DRpQ3VRfHO2gpHtnmPHfFpcYuayMzQ+FK0As6peibc/Vp5iH17wc0bjCGGzwc4ile9Awt1TY0lbgGAH97xOi2iImVT4n4PVsfQj00aoqnV00KTw7sEpKDBzLuMNaixiSkU1IoeK3uOtmV2HV+VTTa66QkdszGd59S6+cH4jQrc+Rag9yPCJ77XC0jEP4xBb5G7NbnzbQpxoPR4Lj8sgBtPjRYO4PueAJoIVCWvMcu8/9Mfc8710VFiNPxmRxKKzYLvz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PMxAzeTwSltFqBYRQxQUc1y9l9Ps5C/rfJoNqdqbOM=;
 b=1wlZMjo36z70heoYh3IwXeJTCpE6qFXinLrFD1AHU2kx4p5pnhlcfKeC5opHwXhQZ7/tBXp3mtGrB7iLpvmmG8yQLsemuidIRl3Xp1bDC/nUKhwm96wwQVgA/MRKxaouzaU42+TFdbNEVzWHf++RNCEJtT61vhkCHG8LEO8pcBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 21:58:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 21:58:34 +0000
Message-ID: <b5c9fc5f-a5f6-4b02-9690-c5cda91b1e79@amd.com>
Date: Fri, 26 Apr 2024 17:58:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Flush the process wq before creating a
 kfd_process
To: Lancelot SIX <lancelot.six@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240426185529.529811-1-lancelot.six@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240426185529.529811-1-lancelot.six@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e272aa1-ad6b-4921-35b0-08dc663c0476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elRQbkdGa1h3dXhZMnorQndVV2dSaXViWUZSeGgzMkxqRnMwUWwrQldqd0JE?=
 =?utf-8?B?Mm5QK0RVOWJVeDJZako5aWsvbWlIR3dpeTBwY1hpOXhqM3pvcHFEWVdjdFU2?=
 =?utf-8?B?Nlc1Y3c4dVI4bXU2VmhBVFNPVkhjWVo3dFlubXpPSTBRRS9zT1JQY3FCVmZQ?=
 =?utf-8?B?YlBnSFJka2s0WFhRMmlsRGhqa2w4emJLSWVWNmNLd0pDS05LUFY2ZWtkRk9R?=
 =?utf-8?B?RmZtVXZLNDlIUmtzTTZwQUVHdnpaMGsvK20zSXFjdTZUaGQ0dElqbkJ5R1E5?=
 =?utf-8?B?MTZqUS9YKzZSTWYvUy9SMUdtaHIzZ1FpTngvZ3VWdXZ6M0FRRjg2N2hhamw3?=
 =?utf-8?B?eGdLYUM1a2RicldvL09WcDBzMUpsaHVNNXpnbENwRkExUjZsZ3RzNlVEVS80?=
 =?utf-8?B?TldIOVFVY2N6SXFtalEzdUdTNUdVWjU3SWhJME54b01zQTJYR3NNYUMxMkl3?=
 =?utf-8?B?bnNVWk1RU2F2ZEloL1RiTWJFZ1k0RzBienBZcnhUcHk3ZGhiL3I4aU1ybzR4?=
 =?utf-8?B?RHVxMXRXa0R2Q3lERTlmRGZuYnZCS212ZlAxb0F2bzJKYzdLbkp5TVpKRzQ1?=
 =?utf-8?B?U1RCT29kZmNWZmxYOXZ3RTZJbTF6SkdtL1BhRDVSMHJnVzR1L1VBT0tia2Zo?=
 =?utf-8?B?NVQ5QnVFZ0Fxd2xuNjdLWG8xa0NLZjlHOWlzRno1RloxeW5VTmdxL2tDQlQw?=
 =?utf-8?B?eTV6MDJTTnF3dmFnLzlYaGJBTXNQeFIrcWhkTUJMQzRka2R3QkdIVW9jUitN?=
 =?utf-8?B?M0tZVjc4RzBrazVWWmtJOTBMdW15WERUckJ2Z3l3RW1LSnRxRW9KZjVUR04y?=
 =?utf-8?B?RmNEN0dmU29lODUra2U1ajNpaUVVT0hMZEZtaU9ieVhKb0J5TTJKRGxLREFl?=
 =?utf-8?B?cHA1TXVmTzFKdWEyZWxoMXdrTTRwRzVmdzdXOVBGRGlyZU9SLzdQN2tUenJh?=
 =?utf-8?B?WCtaUE13UHNrZ1plVmZyV0ZCc0tsR3RCZU9sRmU5KytUVTRTMnFIVERWNGEw?=
 =?utf-8?B?NXJERWNuckFzMlQvTUlBdWZWeXhXNWU1NVd0WGVTaFhsQnBjUXdUQm5ET0g2?=
 =?utf-8?B?OEFUSE12MFB4MmFiNnRNeXVhWVQ4UXNJeEdRbm1XNXpjSFQyS0lpUWpVOEow?=
 =?utf-8?B?NUVqYnVUS3RTUkorcUpqQzRhQlJMRk9GTnBUWnRiMUlDRUwxTU45bnVkbVEz?=
 =?utf-8?B?TUhycFprTjduNm9mM1hCemc2TkdNblRUQi9YdFJVbVZab2U5MlUrM3d3b3No?=
 =?utf-8?B?TzlLTlJkd2ZXQXBhVi9PUVRwL0laZ3gvWHJUQ1ZHdXpjeXFzZnZZbnFkRXh3?=
 =?utf-8?B?TDZoUFo0S3V6UlMxTDFURnhtdUhhWGNxSU5YcnIweGRFSEpRY2paY1J6MFF2?=
 =?utf-8?B?Uy81dlFScjgwSUlPZldkWVZDVW8yaVV6NmFsOHFhVzI0dUFBNFJpY2dBd3RB?=
 =?utf-8?B?eDJoUlR4Z0JHeE11RDRzV1pJTFU4bGFyQmE5ay9lYUVvNk52KzRBQlpvUnNI?=
 =?utf-8?B?TE5WNEw3bEhKVjZQdjRra0tsZVlEVEErWTNwRnpYS0FRVWxtWjB3MUFkaUJR?=
 =?utf-8?B?T0FZanZQN0VBdnFUMHVsWXJkNXVOS0NHV0NDV3JEblpHRk5GOTFaVEZqV1oz?=
 =?utf-8?B?OENFanl5alVZTUh3MkZta3JRUTlQa1JsVGtsaWFaOFhzYXFQOG51SVpjSHdi?=
 =?utf-8?B?Z0N2Y3RGczFPb2hjSElCMkwwdmVJY1dUVWpYQ0FIeGY2YUtjZzFtbWt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZYbVdiaDFobGpHN2oxUzIxUEdFLzNhYVM3dUllOGZ1b3dnRVB3amdORHRa?=
 =?utf-8?B?WlduSmtjUjZoUmUrYlo5VEpCYU85Y1h2enpUUUJuUEljdHZZZDNod1d3citP?=
 =?utf-8?B?SlQwbFg1cFAzSXQzS3dGOTQxbXB3OUNldWdkVHZwOXo0R3dnaXlwbitOZ2hr?=
 =?utf-8?B?aVpuTytLT1pVMFBJRDZ5UU1qMGU2OEFKNnhEblgwemR4NUdEeWNVenB3R0pk?=
 =?utf-8?B?enErMjBRK1dSM2kxTVBya2xqb1ozRFk0OS8wVkxUbmI4dnprb1kxOUwrTmcr?=
 =?utf-8?B?VTNIZVNpQmF2QnF4SEhSdXltQ0g4aFZCN05FUFFqSno1WkdhekhoOWFHTjR3?=
 =?utf-8?B?SnhNNm5iYXFWNy9VUWJJSEcxVS9DUWk3UjlwUnFMbDRvUk5JelZNd0RmT1lC?=
 =?utf-8?B?SDZMZkU3K1BVTFhBaFNteVFiMUtPbTZBaG5JQlVDMEVzeXhBcUJORVQzRSs0?=
 =?utf-8?B?RmEweVNHZFYrcmw1cVF5ZWJ1cG05YWdlWkE2dmc1bHFFM1BZemZTZThpcXJP?=
 =?utf-8?B?dHJ3dFc3VjV5R3RMVXErcFQ2NFVOcUVVVVFLYXIvVzk5QkhZa0hrSVIwK3dQ?=
 =?utf-8?B?RW15Ykd5Wm9qaHZVV2xWRVp1TlQvM0FDY0lBQ0V0RVNSbWVBZ3FtWE5mYUts?=
 =?utf-8?B?Y1BKdFZYMmZYSHpHNCtjSFY3UWVWY1dkaTc2M0V4Q0RSZVZXRnBHaVpZdnE4?=
 =?utf-8?B?aXRyOHlZWG5WMEoxZUUzTEM0TmM5MTd4YTJzUTAyVHFnN2ZmSHZscG9EUjJN?=
 =?utf-8?B?aTFBSExLVVFsU1NtR3FwMUQwckxJeXV6MUNsNk5senBjbUJzZE03cC92clhy?=
 =?utf-8?B?NUhDQWxXVjVOcGtHT3dKbFJwZE9aWDB5ZEtLMW0vZUxoT096VDJRWkV3b2di?=
 =?utf-8?B?dlB6RmNHNW5ZWnRoV3pCalVFTWlhSTliMENrdmRNb2FTcmxVaWNPNmYxS2wz?=
 =?utf-8?B?N2lVUFo3em80dVV4WUdwZUQ3S1ZOL0phM0hKYzcxMy9CWHFCS1ljWlU5WDhX?=
 =?utf-8?B?UlN2azBaL1RMRzFtSXJoZWFJbGY0RFFuLzJCOW5rVVNESE84SjFyVTAweEFK?=
 =?utf-8?B?T29DaGpKTXh5T1FlRytMZDVYS2x5elF5ZEFKYzFNQTJDaUtZdEx1SXpnUVJW?=
 =?utf-8?B?dWE2U1RzZ251M1Jud2pSUUtRaitwaGRPcTFZMGlhT3FaZGE5Y05teGdGWmo1?=
 =?utf-8?B?UVJZT0lnUEZjN2o5RWxXS25RSmxPbzRQbFJsWkJ1VUpWM24xRjNKV3lQaXRQ?=
 =?utf-8?B?ZEllR2xzMXI4YUEwUmlIZFJZRWFRRGhSZEVVOVdPV05wVGJaTEhRazNzcWt0?=
 =?utf-8?B?MmxvOHhNN1B1bDQwV3FMa2g0czlWRFJoTGxVQVY2b1ltMTlWNEtDeUtMQ1NI?=
 =?utf-8?B?bnE5M3RXM1RITkhNK29rTEsxVUZpWVZ4amRYT3YzWG1ONGZQRk8vNDFoM1JE?=
 =?utf-8?B?c1RKV2YzSmtMakVkRjI0d292bHlQdTJyZVRjVVdYTHpDUEplVDNZNWw3U0xW?=
 =?utf-8?B?aXFHcHJkNE9pWjJkekV2cFhuMWZtNXBhRC9GdDg2dzlyOWZXNzlXZ2VBVG16?=
 =?utf-8?B?Z3luQWsramt0TytwUlhiYk1vcmMvSXJTWDBkZEZaV3hNVXBLdGJUS2hTNlNn?=
 =?utf-8?B?N0FaNEtna1JzelkwUGhHQ3NwYlhNT1ZKdmtqcWFtdWtwVjVKczFFUUJwbit2?=
 =?utf-8?B?Wkc2aS82ZUJQMHkvQ2xOdmlsVW82NHl6RkM5cHN2LzM0d2grbG94MFRsR0hu?=
 =?utf-8?B?TU1hZ1lPUTRXYndqL0lSOU1yYnBVRUxiL0s4MTJvc3pKSDBCSFF2ekkvMUFt?=
 =?utf-8?B?U1F3RnQxdkFieE1PVnpreFBtK205c3l3emI5RVFTWTFGU2RFVmhuZ3IwZXRp?=
 =?utf-8?B?eTQva00xdmNmQVBJVkszT3dZaTFaQisrVElzUnF3U0hoTG05clBDaFd5ZXA3?=
 =?utf-8?B?a0JjQVoxZ0NYVUViWnozQWM3eS8yYStseHptNjZJcnZtV3A0bFZ2cDdJQzFx?=
 =?utf-8?B?L1pYS09tNHYxZHpWWjZGQkhyMldjK3Q4aVNpbVZjQVFHd2tTKzkzejlONGdB?=
 =?utf-8?B?WVZPUzh6emQxaFJvbnJhQVVzQTdLS0ZiY3hWT3k0dEcwbnNOZVo0ZVFGOEF3?=
 =?utf-8?Q?gWSI65Agb5hZaZNV/ByQxTa7h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e272aa1-ad6b-4921-35b0-08dc663c0476
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 21:58:33.9757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm1/bUnWFU629S3wSo8gF0XaKKU+F3h4giMfezB3OB97OXGhF7SnRQ9qmGF1o4V6V5/fTgVSRcbUR5KiqGIAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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


On 2024-04-26 14:55, Lancelot SIX wrote:
> There is a race condition when re-creating a kfd_process for a process.
> This has been observed when a process under the debugger executes
> exec(3).  In this scenario:
> - The process executes exec.
>   - This will eventually release the process's mm, which will cause the
>     kfd_process object associated with the process to be freed
>     (kfd_process_free_notifier decrements the reference count to the
>     kfd_process to 0).  This causes kfd_process_ref_release to enqueue
>     kfd_process_wq_release to the kfd_process_wq.
> - The debugger receives the PTRACE_EVENT_EXEC notification, and tries to
>    re-enable AMDGPU traps (KFD_IOC_DBG_TRAP_ENABLE).
>   - When handling this request, KFD tries to re-create a kfd_process.
>     This eventually calls kfd_create_process and kobject_init_and_add.
>
> At this point the call to kobject_init_and_add can fail because the
> old kfd_process.kobj has not been freed yet by kfd_process_wq_release.
>
> This patch proposes to avoid this race by making sure to drain
> kfd_process_wq before creating a new kfd_process object.  This way, we
> know that any cleanup task is done executing when we reach
> kobject_init_and_add.
>
> Signed-off-by: Lancelot SIX <lancelot.six@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 58c1fe542193..451bb058cc62 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -829,6 +829,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   	if (process) {
>   		pr_debug("Process already found\n");
>   	} else {
> +		/* If the process just called exec(3), it is possible that the
> +		 * cleanup of the kfd_process (following the release of the mm
> +		 * of the old process image) is still in the cleanup work queue.
> +		 * Make sure to drain any job before trying to recreate any
> +		 * resource for this process.
> +		 */
> +		flush_workqueue(kfd_process_wq);
> +
>   		process = create_process(thread);
>   		if (IS_ERR(process))
>   			goto out;
>
> base-commit: cf743996352e327f483dc7d66606c90276f57380
