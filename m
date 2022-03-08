Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF00C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 07:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC6110EBD3;
	Tue,  8 Mar 2022 07:15:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF28010EBCD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 07:15:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNdoImx5+4RByauk0nKZrzRfQDSZ0LqtQUifwa9cdtzmeJNWka+VofsuruRZ/SJ9wuui7a5IKAfp44Clm6b05dOs0gXBz/qAyCu70eNNYr85+FUCKlOEJ5zFipvGVjdWTSVNIu0kyMBXEpEMaaLFsMb2TkJxLzlLDeYWEqNjEBrw1N70/Envq2m7Lb6bGX7RNktiEMbSSV0AfrQP6/0psBWmjn+Z+Ff6KOBmrU1M2KRgPjS0lagNVENf+hcP+BZJs4VqWfK/8VNqTkGVgLWVLzMBuHcjpUxPthiYb4iSOm6GJQ0feEnlEHcpLNDJk29607UEzDm+UZTIpsbx0VGhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8g+7vJbM0Ncwc7kQZsaR3hfmuMqx50vrK9miXni/PM=;
 b=mZC6ioxd26srmamvSex0FkFgRCRMf27O5Z/eH+1ZaRcD8f9zGEj4fEO+ggcgjZdueoVd5/PFyv9XxmZW2D1oo9VkGnZ0YXCxOc6vZ7L7YWdtCX14jx+ZxBr2AL4dCssYw0jmE+pjMU4/lpm54hl6KZsw7LUwT5zdZaSQ3f0naUuk52QVRj3WiZHIc2K/jndlMxW66zD2+xKyrqHjLM/U1jC8tgIjj7PbTfilGx/kqkYWzJcqk9l9fctNUvD2p/9maDN7UVt8Lx+r8TXJLHpr4EWMwyl6H+0nzJ8j8DQB52pP6r8NKkPHSuoeQ1iNrG3yJhX1fr8HoIzDXrY3ySZatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8g+7vJbM0Ncwc7kQZsaR3hfmuMqx50vrK9miXni/PM=;
 b=Qa1/ZTnq+wtbrTO3vNYaxs7kbO7c2LSvsOuHDIeTW5FAWqyve8z0c/v8UgeoNSIBcs8vvVXWOZ7F2DPKHY30NYoCOlzTDtGQhAm3BhjJMZW5JJlQX9CbL2k/LL6wL4WNkhXwaSzqKIPw+pqXRpNoeruk0G0SpqEo0nHCzQKf394=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW5PR12MB5624.namprd12.prod.outlook.com (2603:10b6:303:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 07:15:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 07:15:45 +0000
Message-ID: <8d35cf70-0dc3-6fd5-6768-9530d729ae63@amd.com>
Date: Tue, 8 Mar 2022 08:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220307162631.2496286-2-contactshashanksharma@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0228.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472aee29-0710-42a3-e78e-08da00d37642
X-MS-TrafficTypeDiagnostic: MW5PR12MB5624:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5624988B56036A58007FC44B83099@MW5PR12MB5624.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmXARQVr7JFhqKbHXlHKhO2tcqL3O8iwY0A8FO54UtGvp723NOiPstUu2cc5bwdUltFLF2HUkWiIsAzd90VrcpgDD2gy18RYoa/Pry34AHr3gA8gOMY17RcLgVKJCeJp/U2cFbnsCP052VpPrrXnELzqGU6E39hDKpHCCtloEa3Ai7pZReqTt/+8WDlX211mLQjl/3AhzCL565U5ToZEBTApLQBvAKk4x16EEZF7sYwOZxsPBg9wvyH/8YOnQKUKF9kz+Mh0iXm8fZ7OoMbZK1xAaPuS5fSyehMZe00ztEh2/r0eZcaufR9x7IdohyAkp5dqr5s1SBMASxegaDsXNcfYTyhyukYmFBjKg8EFiuDfM3sOpWY0YNVnfpfr8m0nhiKiJLZEriW8hmeUtuBi0H/r4XQJ0K53IPV7zXFOsi6JSCd8uXva4FwaNYKdHNuPnwI3+QNeJ0ilPWuKoBIlYoN6Dor1U1pXXngfI3b+P7g3jmeVU2c6tjgE2DA5bc1OrKCxJc/jzgkGmq+0z1fV/AKqsFki59wfpOrRMiZ3QNBflT7Hx4kG7dBDrPAk9tZaHK81ya5pawGupMv7705SFj3js08OtocLgcDH+Z3Ex+zRnqdjrvMd01+LjLaLrtspbQz7a4miMzJ2FIaXTKyNoTqL+PvpSrRZqYgCu9Yw4DaVvf0KbO+aUYf+WkP1uont7bnVIhps6KG0TnbZs3KEPKhwblyqjjcXFTa8OVAjd9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(86362001)(6666004)(6506007)(2906002)(31696002)(8936002)(31686004)(508600001)(186003)(26005)(6486002)(36756003)(316002)(6512007)(66556008)(66476007)(66946007)(4326008)(8676002)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJPdm13Sy9PQTVOUlQrVGtKR3FkakVlcE8zN1JwZFpyTDFhK2swZmJrQjFR?=
 =?utf-8?B?cTBUNVoyTGgzbHNrYkVrMG5RWVdoL012elpKMXVrQk9CRkhyOHMwMnhmUzZi?=
 =?utf-8?B?Y3o0V2thekdxcnJSL2V0cjF6OHU2QlZmTmExMUtZbFE4MmhFa2xIR0pRSjlz?=
 =?utf-8?B?bUNZQlRENlloWUpwZTRMVUMxVzNKSFQyQVdlU3JsL0lSSTAzb2t1b3A3bkRL?=
 =?utf-8?B?N0t1SlBnendvWi80QlpiR0pUK0Q1VjJMQUtqZGluUTlHdTd6VTR1anAySWNN?=
 =?utf-8?B?QUt4eXoyL1pBNmRLZzlicDFMbVhwZzRLTC9JUm9DWjVWZU1Xa2VTMUtNcWZO?=
 =?utf-8?B?cXoraWFrbFE4TWxCTXpqQU1PNGNxNGpWOThvTnVtaTZvMWhEUmJVdVJsa3B3?=
 =?utf-8?B?anpiVFlzbUEyRklyelVUMUpoRUdxd3NzWDNZckpqTmRHY3BWM0FsL216R0Ft?=
 =?utf-8?B?ZmladFBrSmwxQ3pRMThzdW1BZG5lZDYrK0s0M0tSU1YxaWFQVlJaQWVzWkRo?=
 =?utf-8?B?UXlmR0lxajJaa2ZjMHFCUFlMSklxUXZMU2FxYjNhZ2NpNXhoRk90RUt1Wkla?=
 =?utf-8?B?TXNpbG1RMDh3aGpTRkdxcXE1TElYeHJWZGRZKzVjVUpLaDBPb2lEc1laanEr?=
 =?utf-8?B?TmE3ak1TRVE4ODJncHdBZHdYdy9ZazU0RklOKzNWOEloWGNiUEFhUkxsNUE5?=
 =?utf-8?B?cW4wYVU2SWZON0VoN1NmaG41c1lZc2lCdnM3T2hGSmsxVkdEcWZnVGJTY1Bl?=
 =?utf-8?B?L09GaWROUW9CSHVHY3cyaHdCaVh0QXJYYURmNmQxaDk5M1YwdWpDbVNsMklz?=
 =?utf-8?B?SjBJdjQwOGZCbDZoSGRJK0xLSkNsVzlYdXNGTkszSEJldGlQWjRORnNITDY4?=
 =?utf-8?B?V2ErMUVYWHpUMDAxUWdZTHZVdzhPc2lKYXRJMFVRZnByUFNZRW8yZVI5MFZD?=
 =?utf-8?B?VERQdHFlNWlqeFhJQitXUFprSW9CYWJxd29sYW0xVTBqQmoxVEY3ZnMwZVFr?=
 =?utf-8?B?eHpMRkZ2WW8waThaMFg4aGNRU3VSMUIzK2wxRnZkOEtRNDdZVzFSQkd5MmJZ?=
 =?utf-8?B?emlsN2ZmUTk0WGd6cmFDU0l0dlpWUUx6RG1ELzc5SmJjRFBEQjdrVlZGaE1J?=
 =?utf-8?B?ay9udnk5a1lzZFVrakdraXZURUpiTGdSQVE3QUNrdFROcEdORGY3YXhoRGgv?=
 =?utf-8?B?SFMxSUd3d3pTN3o0WmZHejBhbFVqTlIvc0VPeUQ4dXV1VklBU09zMXc0L2lx?=
 =?utf-8?B?R2R6aElWU3EwcWM1RHdnNDBtUEZ1RVB1UlZMQ3pWblNGSy9HN1orV3dTRTQ5?=
 =?utf-8?B?bU4vYWRESWNuVXVZSEVsSGV2anFQK2crYWcrT0NXdzhWaFlZWEpYZGpRY25X?=
 =?utf-8?B?aDRyajZURHgzSzlEUi8rdGNTS1Q3QVlFbytPQWZNUVhPdjFydlpKUzZQeEJJ?=
 =?utf-8?B?SjFGUC81d1BLWTlZOC8wbTFFMFVyYTNkY2ZrVm1xcU51M3BzdnBrL2NVV0Nn?=
 =?utf-8?B?K0lBdzJxRFJIdkJKeFcwWS90TzI5THpGVERpcE92cVZxeXlLUWFNeVdzdW55?=
 =?utf-8?B?Z0tYRVNaZUpHUjhSL3VFUXRrT2hDVU5BYUJxLzY5UGdrUk85bkdsbCtjVVVR?=
 =?utf-8?B?ZjlEVTFXTVQrUmliVis2bFplYWFjb1N4ZW5oa0VZL3Z3SEQ3aEczdDdMTWVY?=
 =?utf-8?B?OVg0bXBvN3F1M3J2YmJGNE13cTY0MUVDNWlkb1llZlhwejRiSjlNMGdBMlMy?=
 =?utf-8?B?QndrYmIyMXZwbkdwNDRpa0JCZEI4dVQvNk5MUmNMZGUrTWxnTkhLa1krUUpv?=
 =?utf-8?B?UjRRU0lXa0xESlZxYyszdFl5cUlXM2cvZmljYmFFdnlrd3ZXMVg5MFZzTWtV?=
 =?utf-8?B?N0J5djNNSmFVRzJPdUNIVG5rMEdDbkE2RzBWL0lVeER4TmJmd3JOZ1QwUzVV?=
 =?utf-8?B?L2dwQUdBRUZJL0pkaTE5QUtYUGhvdHYzZGVoZVF4WnB5UldsakgwVmVJZDZt?=
 =?utf-8?B?bFcyNE56YVg4eEtCcDJnV0xmVHNrYmtVSmRtMHlWRlduc3IzTGRpd0E0ekNo?=
 =?utf-8?B?Tkk3QmlNaC9ET3RqdUZjc3FHNEJEZU0zVWVCaG9keExQZmVkYXFSUHRNenpk?=
 =?utf-8?Q?xfa0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472aee29-0710-42a3-e78e-08da00d37642
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 07:15:45.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1WJ5Z4mVUfcYryTbnAdYKI9Nd5FIwEC0jw8L3s6+0avRKlSdeUmq68COs4GGh/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5624
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.03.22 um 17:26 schrieb Shashank Sharma:
> From: Shashank Sharma <shashank.sharma@amd.com>
>
> This patch adds a work function, which will get scheduled
> in event of a GPU reset, and will send a uevent to user with
> some reset context infomration, like a PID and some flags.
>
> The userspace can do some recovery and post-processing work
> based on this event.
>
> V2:
> - Changed the name of the work to gpu_reset_event_work
>    (Christian)
> - Added a structure to accommodate some additional information
>    (like a PID and some flags)
>
> Cc: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d8b854fcbffa..7df219fe363f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -813,6 +813,11 @@ struct amd_powerplay {
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   #define AMDGPU_PRODUCT_NAME_LEN 64
> +struct amdgpu_reset_event_ctx {
> +	uint64_t pid;
> +	uint32_t flags;
> +};
> +

Please don't put any new structures into amdgpu.h. If I'm not completely 
mistaken Andrey has created a new header for all the reset related stuff.

I would also reconsider the name, at least drop the _ctx suffix.

Regards,
Christian.

>   struct amdgpu_device {
>   	struct device			*dev;
>   	struct pci_dev			*pdev;
> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>   
>   	int asic_reset_res;
>   	struct work_struct		xgmi_reset_work;
> +	struct work_struct		gpu_reset_event_work;
>   	struct list_head		reset_list;
>   
>   	long				gfx_timeout;
> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>   	pci_channel_state_t		pci_channel_state;
>   
>   	struct amdgpu_reset_control     *reset_cntl;
> +	struct amdgpu_reset_event_ctx   reset_event_ctx;
>   	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>   
>   	bool				ram_is_direct_mapped;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ed077de426d9..c43d099da06d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -73,6 +73,7 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <drm/drm_drv.h>
> +#include <drm/drm_sysfs.h>
>   
>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>   	return amdgpu_device_asic_has_dc_support(adev->asic_type);
>   }
>   
> +static void amdgpu_device_reset_event_func(struct work_struct *__work)
> +{
> +	struct amdgpu_device *adev = container_of(__work, struct amdgpu_device,
> +						  gpu_reset_event_work);
> +	struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
> +
> +	/*
> +	 * A GPU reset has happened, indicate the userspace and pass the
> +	 * following information:
> +	 *	- pid of the process involved,
> +	 *	- if the VRAM is valid or not,
> +	 *	- indicate that userspace may want to collect the ftrace event
> +	 * data from the trace event.
> +	 */
> +	drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, event_ctx->flags);
> +}
> +
>   static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>   {
>   	struct amdgpu_device *adev =
> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   			  amdgpu_device_delay_enable_gfx_off);
>   
>   	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +	INIT_WORK(&adev->gpu_reset_event_work, amdgpu_device_reset_event_func);
>   
>   	adev->gfx.gfx_off_req_count = 1;
>   	adev->pm.ac_power = power_supply_is_system_supplied() > 0;

