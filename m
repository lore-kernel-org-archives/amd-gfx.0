Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578A3C531F9
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 04:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2B5891D7;
	Fri, 24 Jul 2026 04:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRbb/Wnv";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B79891D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 04:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2ixd8XulwjtHa1xTzB24hcPNP2QQW3vMDtUcrbYzIFiAfKxNJNzlRsBH25/Xv//WgLOMX1A1Pde4Pyjz1Qg8qnTlPf5m1fz+B0gAnnyZb0EpTdH7q9l9orD9HDnG578ZgM/GwSaE5vA2o6unWB2wZzHZH2uUSr3RGHelppSFXJ/I3/QNbIMAWUS0FuO/itru/UDurhqZu4wK3ldtBZgHAC8Coci+JL8IaeINqtU4Iet1Vz/c2duEZyp6MJ6NqY8pJHS4UEk++ib2JLEsuwnLxh55VNLPkqmKq4ZjR+ocBTWZ486nedMUtzCeok/hAbAo/pXV7FFWM/Masjt0tUsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9F4B+gAUvjVBy+494NfacpSaxzttAqWqPvr22N6QfY=;
 b=tPHyLK4g8kqrEw7gAPIVIuWsSfZEspyV9K2Qh/whoqTCz8P21JE0PcgzqxFkWjfJj8bJZk/YOSU0JCXONVx4NQ83/Kf3ga7HpXlXkBkB8IPIro2n0CsHr6G71FwSM5cgC1xUMR1TQCNCBJRCX7vJS5J3JomaE50CMvEPO/SnYcq9qzl51SA45/KmRsyxmm0I2ArQ4k5zwCH+pFJh54JlxKYrogyWOjqas31/YA1WM+uUw+8cj4e63awJrCCOOKfLYhgt3+45QGlUI+SqYOgjYPMTTMakwLejXX2UYSlFKaBG376PZLr9MIEb7wlfr0SPdH3EdvPNcZp77tH7HE7cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9F4B+gAUvjVBy+494NfacpSaxzttAqWqPvr22N6QfY=;
 b=LRbb/WnvmXU5YV/VYzF2JbVnigaU3aoICgpCRL9RovU67QS7PBqY8zSTeMU4IokOzXlH+2BYJOb5fGytPXKdxNMGpD69oOxTZ2V4/QRNfkhwzx/fljioMEK/a8yLWpfqvS8TXbIJij7zX2TekZzXdmLekW+basYPJWTK36WjtRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA5PR12MB999323.namprd12.prod.outlook.com (2603:10b6:208:605::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:59:53 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 04:59:53 +0000
Message-ID: <ec842f51-8ab4-4908-93b7-052cd9f1751b@amd.com>
Date: Fri, 24 Jul 2026 10:29:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/ras: add device lost check to early exit psp cmd
 wait loop
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, YiPeng.Chai@amd.com, Tao.Zhou1@amd.com,
 Stanley.Yang@amd.com
References: <20260724044325.1092820-1-cesun102@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260724044325.1092820-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA5PR12MB999323:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d6d8af-c028-431d-9643-08dee94065fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: ac73tTlcRCpY2gvmclqa/vYnaK/Tl8pPcIEPxqYvX1kZALlNomsCUZKUzO8HEYtYy4Iz2W5jOaZVGvumIIE/ZkYgNCUwjVr4VJ7UQ722Pqk9o1pJ12h70OAUAkOQi9XmkoSom+K3lxoMzkHQ3/G8qUGJiCVWdMxgEtwlymHs7chPB3O5xRbpa42q8uOJP7oDG3cVNBZbCDIP+5G+7iuIfaxTcZovRCRdoGF+DqUifMiGT89kSOHJtors6I5dqW6UPNvNWuLrVQADl9gGNu0IrDS+ch9oI/I6IGNojeRtYW8e4PhksyaKza/rYOXMihc+9+kX3t3nL/FC7jPoO6HRMM/BMGRIdkW/WyM+dmq/Ti2NsDCR6TfyHYstT14PjHhhLCxU+X03xO/cxv7j5d4pvT3Amtj7oy82vllFExS6JPeOO0WuiMYGmH5hmwC7aOkjvehsBA0VsCdrrTYAT3n+nrHMzvkvdQ0I10Pm1zu94x/nQjqBVZHs/d2IDPwlUVoIBIoTZUE3DWkXCm5kusoLCl5EYHKHiFpSLVmy5z3HpsDjf6wGxTOqDCAWmE65OIgsc/mNEMhSoEK7pn/2mvJbxjGKLX3nwCgdrNlxMg//Q1r8KFGpJxiGAN+mHUaBf8HOnivPkxhvFn1uRyojKPCTISM9wZbv1LsEOLJwCWiiE3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVM4R1YwbXk5bG1WNW5Xc29qK1BOWDVuVStyZWJmRy9sNUVyVHRxbC9pMXRl?=
 =?utf-8?B?NWFoTk5DUnB3YTVLZFZvV2VDZnNQR05PRHB2QVZuZjh0SXBzcG1kV25lMEpW?=
 =?utf-8?B?MjM2Q1JiTUlNa2w3M0FYNVZmamo4YjZ6N2Y2blBhSDc2RXZ6c2lhbXBId0J5?=
 =?utf-8?B?TDkxQnZhK0Y3RnFUSll6ZE1KRGxqRUdXVnpoL1VHWjdRZnZ0YWlUUXVDUGJH?=
 =?utf-8?B?M3lBa1BQdWFjSXl4VitSUnE3eVBWeVkwckxsb0xIUVd4ekZuRnpOUVV6VWpa?=
 =?utf-8?B?RU9iQUFLSU1WTXNDZUR1TC9rNzdMbS9hSTVzSHNRVVlxZDVJMlR2TTUwZUUy?=
 =?utf-8?B?NDVsNHUyRUhMWnFMWjgzTnN6Rm1PME1rMW5pQU9oU3VqeTVBUjJBd3E4L3Rm?=
 =?utf-8?B?L2JhdmFZYzNrRzBEK09LZStzWS9NZHpzMjB5WnZ2bUU3eHZib2Q0c3F0RVJ0?=
 =?utf-8?B?ZTgxOVhGZ256dmhLeDQ4U0prWUlzS3BHMmhvYWQ1TkFvUkVhOE9mcyt5RTZP?=
 =?utf-8?B?VEdOTXNiNzVWVzFpa0VJOUJ6VGxVaFh2eTZEdFZKQkdkTCt2R3FmV2hKUm9o?=
 =?utf-8?B?VEZBUEN6aExacS9Jd3M5K2hDWlZOdG9SNE5hRUNvVVdvVFoyMXFYRzYzRXBC?=
 =?utf-8?B?YzdiUFB6NW52NllZZi9HbTJ1dU9pdDZ4blNIZ09mSXJsSkJ2SEV1MWtIcG1v?=
 =?utf-8?B?dHZEQytxQ2Nqa1h6SDFrMlV1eTZTNGVmbWkrVTIvbHBtQWdEZ1BvZWZuQUg0?=
 =?utf-8?B?ZlRVZVJUaHBsaWVQRmJLWG1KWG1MaThFVWFoWVAxb1JGNVpObzlaVlBzOXNu?=
 =?utf-8?B?dTY3SWxSYWhwVEVPM0J3K0kvcmZDdUhNUXhLSXBiakFNY2RyclAwMWRZQkxy?=
 =?utf-8?B?Ti9EWHV4anJYSHE4bmVJd0NhMUh1WlVPRDdsK2NMQzRra1JVN2ZDdDA2bmZx?=
 =?utf-8?B?MzJ0Yk9XdVNEZGRjazJYZTNjTEVuM3l6NlRUdUc1UlZ4QjYyb0RwVFN5ZWxL?=
 =?utf-8?B?SjNTRE1BWXA3VmZoa1hCMnppZXJXUUhCQ0Q0OUNtbUdPWVlBNllKb28yeWJz?=
 =?utf-8?B?MFJFZms5WnhXaGVQTlB5UjNHekVQNVNNZTQ1UDQxaExodGNINk1FNU5GRUFB?=
 =?utf-8?B?YzIrY2RaT3l3a2JQL2VJcnJpRHR3b3BoZDJnRDZPYXQ5YkJoKzRUbUpDd1Rk?=
 =?utf-8?B?YTdiV2poSSs1WTZ5bTM5TENKMGFKTW5EZmdHM1FaTDk1ekRLUUV3Q2dLak84?=
 =?utf-8?B?SW0xVHNkRUtYcWN2K2NCa3FxQ0t0VU00TVEwMFN3SW1qN3IvOTBKNWxCMkFC?=
 =?utf-8?B?Tk9JemNlV3U3eGdkWTBualZ6b2Q0WDNqd0tveXZnbFdnUmlZbkhQMG1LRkk2?=
 =?utf-8?B?WkwyT21hUEE3TSthbHlQNGFKazJCNHN4UktyajR4Q2hpODJlQnZ0LzQ0c1FX?=
 =?utf-8?B?L055elM3OWptaytGZmVuUEVLd2hJeE5yanlBUmNVR1ZrYWM1WW4yWEJyQVZs?=
 =?utf-8?B?RlJQM1UrNW0ycmYvYmFhZWxId2FYNlIwYmpKdDNsS0xUdm9rcDlzUitzeDVu?=
 =?utf-8?B?Y1F0Q2h2NzYxUENRRkN0Mlo0Q1VjM2Q2ZkE0MTZCR3hpREJ4MVNia1IrRDF4?=
 =?utf-8?B?d0NlLzl5dTBpME5EMHVIR1NMN0h2TEtEY3RCWm5FbEkySVBKZ3lFWnlVT1ZE?=
 =?utf-8?B?TnlVZWxzUmFKUHh1VTUxUWI1cnpONU5GYWtmWFBqQnBHRWQvMTliQkJnaTA3?=
 =?utf-8?B?cnVxRWlRNDRKcitiU0hSUW5laFFhcWxTVVVSWkNEWUdNS1BFSnFmNlhlTTlw?=
 =?utf-8?B?ZU9rTWllZ3NFRUp4MkdBWVVhWjYrZitKMThPUGdRQUZRbm5JSEZWb0wyZEJ0?=
 =?utf-8?B?R3Fnd284TjhJUnFFQldTSGtIa09NaytINUQ4OTNyckhDRWo1VXAyQnlxem05?=
 =?utf-8?B?eG95Tm1HMDYrakxTeHpTR2dweXJBUkZyNzJPbW1EbGtKSVZUNWZrTE5rQnE3?=
 =?utf-8?B?WDgyYXNISnQxdGJud1MzNjNlS1BNYjR6QVZ5MFhwN29HcTNsUWZLQmFoN2pC?=
 =?utf-8?B?a1V5R2VaaVN4ekxueENidythOVM0Nks1L09ic2w4aG0wWmhhcUxaNG5tSUpC?=
 =?utf-8?B?QUQreE93TC9JcHRSbTRZMjhmUFJudHMyMWE0Qzg5N3VRZzBEZmd3SWEwKytq?=
 =?utf-8?B?b3RYUDZabDROd2xaS29ybWlMUi9LTmd6cHp5VEMwY0JDckxlV1Z2eXlxTEc5?=
 =?utf-8?B?SFBmZUpLTlFFMk1kcjNyTXJvZEdSSzNhWi9jTW9lNXcrOUpDZ1dEMjJxbmpX?=
 =?utf-8?B?QTdES3pTMlRYZGVxWkg0NU02SCtCM0tuRUUvOFg3UjI4K0N4V3FnQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d6d8af-c028-431d-9643-08dee94065fb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:59:53.3203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kg8okiV0ZHTvAO5w0ytcEJkjLadubw7kEEJOU2Q2Xa8zeToTcQE/aYUv2uDeHGCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999323
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



On 24-Jul-26 10:13 AM, Ce Sun wrote:
> Add device lost status check in PSP fence wait loop to exit
> polling early when GPU device lost
> 

You may add a bit more context like -

'During some error injection scenarios through ras ta, device could be 
lost from bus due to DPC. Add device lost status check in PSP fence wait 
loop to exit polling early.'


> Signed-off-by: Ce Sun <cesun102@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c |  3 +++
>   drivers/gpu/drm/amd/ras/rascore/ras.h            |  2 ++
>   drivers/gpu/drm/amd/ras/rascore/ras_core.c       | 14 ++++++++++++++
>   drivers/gpu/drm/amd/ras/rascore/ras_psp.c        |  3 +++
>   4 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> index e4444798bc73..0b36b689fcfc 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_sys.c
> @@ -171,6 +171,9 @@ static int amdgpu_ras_sys_check_gpu_status(struct ras_core_context *ras_core,
>   	if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev))
>   		gpu_status |= RAS_GPU_STATUS__IN_RESET;
>   
> +	if (amdgpu_device_bus_status_check(adev))
> +		gpu_status |= RAS_GPU_STATUS__DEVICE_LOST;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		gpu_status |= RAS_GPU_STATUS__IS_VF;
>   
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ras/rascore/ras.h
> index 5869bad978b0..76a215ed0945 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
> @@ -137,6 +137,7 @@ enum ras_gpu_status {
>   	RAS_GPU_STATUS__IN_RESET = 0x2,
>   	RAS_GPU_STATUS__IS_RMA = 0x4,
>   	RAS_GPU_STATUS__IS_VF = 0x8,
> +	RAS_GPU_STATUS__DEVICE_LOST = 0x10,
>   };
>   
>   enum ras_fw_eeprom_cmd {
> @@ -371,6 +372,7 @@ int ras_core_query_block_ecc_data(struct ras_core_context *ras_core,
>   bool ras_core_gpu_in_reset(struct ras_core_context *ras_core);
>   bool ras_core_gpu_is_rma(struct ras_core_context *ras_core);
>   bool ras_core_gpu_is_vf(struct ras_core_context *ras_core);
> +bool ras_core_gpu_device_lost(struct ras_core_context *ras_core);
>   bool ras_core_handle_nbio_irq(struct ras_core_context *ras_core, void *data);
>   int ras_core_handle_fatal_error(struct ras_core_context *ras_core);
>   
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 61d100b074b9..56539e47d50f 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -143,6 +143,20 @@ bool ras_core_gpu_is_vf(struct ras_core_context *ras_core)
>   	return (status & RAS_GPU_STATUS__IS_VF) ? true : false;
>   }
>   
> +bool ras_core_gpu_device_lost(struct ras_core_context *ras_core)
> +{
> +	uint32_t status = 0;
> +
> +	if (!ras_core)
> +		return false;
> +
> +	if (ras_core->sys_fn &&
> +		ras_core->sys_fn->check_gpu_status)
> +		ras_core->sys_fn->check_gpu_status(ras_core, &status);
> +
> +	return (status & RAS_GPU_STATUS__DEVICE_LOST) ? true : false;
> +}
> +
>   bool ras_core_gpu_is_rma(struct ras_core_context *ras_core)
>   {
>   	if (!ras_core)
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> index 358f602b167d..35264c119bbb 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> @@ -294,6 +294,9 @@ static int send_psp_cmd(struct ras_core_context *ras_core,
>   		   psp_ctx->in_fence_value) {
>   		if (--timeout == 0)
>   			break;
> +
> +		if (ras_core_gpu_device_lost(ras_core))
> +			break;
>   		/*
>   		 * Shouldn't wait for timeout when err_event_athub occurs,
>   		 * because gpu reset thread triggered and lock resource should

