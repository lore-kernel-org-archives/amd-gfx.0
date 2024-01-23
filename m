Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C213C47DDB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jan 2024 08:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173D210E6B0;
	Tue, 23 Jan 2024 08:22:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1054F10E6E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jan 2024 08:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2n099jGKsKjr2WRDHPFp4khw4p7gigOgOc2Dd6E9PtBysA/zYsqQiuWvu0C1zhgAxUroz4zxgR3Xco3jMdoYFtfocXG+TBiTERSSo25Y0fPgJJ9zYn9AtVZgQUDcPIEvx1ULm5ir9rtjq/LI5Wf3Lj497h9u8a5ZmDilUDFwOf3b6rQYHcmTcfaNUjrguQbnkgCQvA9rO/Dn9aHItmXnI9/LZc8zHAi+Uw0767zHhkeczSoYRjPK97UoQvRMPGhE9ioCUvW2WM5cA2dHL6VjEPJ0bVyjOpVkT1aySKE2t6rWvK+RGkhqDqeNP6euW9VcbHWG2D/Md0LUB9uPCEj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btBlOCSgU2HlClNQFv6v2jmeDMpuoHeIM/RBsbMEZOQ=;
 b=nHHJSy5gabVM8+k3E5Fd3pQBhBU/JlTE961IZEKpjRhJPvgOCHIKRA2OdanhgwFe6Z2rJykqGoCCB/VO9uCKgLKFt4RAbvcGFzvriMRjcxD3dHEAlG1yIKEzq6HUVmzZljmEFtmi12ckr4U57doEsrvTX0HKIsuxOYCk8sJDtaqpdBM7dwECmHaIAXHzV3jC9She2WTuhfmpIp+iGOlIwCRRq6WE2CuVqvuTkTk6eyy1/OOaXUVdfXWT5Ddtl9RzQSyEeJcekgSapBH+apkIv1I9eqFDg1e0ACxMKfewlGx25i1givbtsKoIi0tcsQmBWnsqbGofQVEogdBpN5HDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btBlOCSgU2HlClNQFv6v2jmeDMpuoHeIM/RBsbMEZOQ=;
 b=b1u4VePgPXtwaWpIjB1kZEBldvodVQTzWj5Sz45MjPkyEmf6GiB2H/0Qz2c/yl3qQKQl2yWkzoTUl9BS/ZbKUStFusyu+isTnnv+4jHT4G7bXQgLSm8UwC3thro6lvfvvLDHovqyDoMtmiu4/gA9m9eyjgwWYQgWOf4U9wlrpxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 08:22:00 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 08:21:59 +0000
Message-ID: <bd5b4387-e2ee-4104-995d-6ddcbf60a73a@amd.com>
Date: Tue, 23 Jan 2024 13:51:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix 'adev->gfx.rlc_fw' from
 request_firmware() not released in 'gfx_v10_0_init_microcode()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240123080841.387004-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240123080841.387004-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a57536-c8a7-4142-2dd2-08dc1bec5e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stfn+GezOZ4vyiSv2gZ3ea4+2WfR4N6A5MS6GgiZzbyO9aRdn+ru/J9RlqWMf0KJGZwETIvzpyrkulUiIynpP6znIWUHG7wH68qB1aV9wMz8cxwKibLVzmiggOZ2HwN6VlkghLUap7NBaD35v7YxGzrqYvD9XmK4Afr3K5MwbtW1tx0zOx2x89nvydD4gVHokN9DF/Y2Og33/Zny/yBg6zegC5CjbGyyyRrSgAni0RF44UyJf7jGgYQucW556iSIaujzUJmxWNKtlduqaMaXI6KxYhMQRmsaNJwSce2XqljAY6NDYo2o42pQFpKlGOcCJW1mVWmoOcya2G3jISDPwWWUjzmSht0GYI6ZM1BUcrFOxz/vIGMm/mclu2qvMcKJhjpQZcE+62cfy7g91t5nxJb7AxJa0VEsxmpaYaYTUAXdrFZTpnzvc5Z1ABaR0dHr/W0F2xSoZa+iTI2WbCwmDdA3ecMn0beOEKVizQve4HRFf4bx39ytLSgYO5LGLjcuSzMz8AidAoUdkKinoD73h7fOVCr7Ki4zazf+HRHz8zgDvM1E2upahvo6hbMvdPQrypToKxW5iAqG0kxnkrSiGZXQYP6qUngNWQ7uykXIv5ZKQ4OC2SPQKXcA6+q41UXzN4wP4+vX5nOnzXyNOSY5fAQq6huxlmlQJTS5Cl0Zze/NfdVkDLba/END5loHdLbN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(66574015)(26005)(6506007)(2616005)(6666004)(6512007)(53546011)(38100700002)(83380400001)(2906002)(5660300002)(41300700001)(478600001)(4326008)(66476007)(54906003)(6486002)(66946007)(8936002)(8676002)(316002)(110136005)(6636002)(66556008)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWs4SjUvbkFjKzk1RHUvdUhoQnZFUlh1Z3MvZHpNclU2cnd6TVEyclJsQnVJ?=
 =?utf-8?B?c2FsVjZjeDdPai9LVG9kZDl5UXpyZUx0c284NStaMjcvZUwyWHRpQ0o1QlVY?=
 =?utf-8?B?bWF2UXQ4QUJwSE1xWENUOFBzbGxmcmF0bEozbGVBQWRmU1dkYWNrLzYxc3Fi?=
 =?utf-8?B?K2hWaHRSa1lEM0YvZ2VKa0xBZWhsZ0lsRENFV2VYQldwNUJFN0E5blMvdkt3?=
 =?utf-8?B?R0tJeUg2THZuM0xnSEExd2RvUmpNRDRHQTdtUWRGWGxwUVZ6Sm5HMmo0emVX?=
 =?utf-8?B?aVByS3BsbFZEL3IzVzRIRWlUSTQ3RzhRVlcrSGNJeUNud0FxamRrVlMxN2R0?=
 =?utf-8?B?TnBuU1piemdiKzB0Tmpxb0d6c0RGbWtzMUFrVC9telZBbU1ZSVF5ejAwZk5l?=
 =?utf-8?B?aXduU2ovK09mQTlNaHFNRHhselZCQms3U2JvN3BFSytTUnEzbkRXTmFMYWxX?=
 =?utf-8?B?YVVVUlBTUGtmWTJ0dHltU2FjcnNrZXg4WXhKZEFuSk5FSEM4anhiMkVrdHNh?=
 =?utf-8?B?QXpYVUVhRG1XV0NsR1JIT1paaDBBMkxPcmtON0Q1TE5qcDV4WVlYS204TmlB?=
 =?utf-8?B?MjhjSjYrRi9qYllIZTJ6ZHlnTnpPUmhxQWg4TFJYVUI5a0pkdmZ1VXJYNkpQ?=
 =?utf-8?B?WHlwOFBwOG1YdlI0bE9zKzhBN3lXOUlWS1BqV0I3UFpDR0JNUjJUZWU3SmJu?=
 =?utf-8?B?eDg0RzEvMnFSN2IvRlZEdEhNUTZSamxmSlorUXI0bURxYXYzVlRlVXVLQTVD?=
 =?utf-8?B?WURyMDEzWXJpSHZPN2Z2OGtQNTQ0Mlg0YXdnYm8raE04U1pCY1RvOWxrVERZ?=
 =?utf-8?B?VjUvaUtPcHNLcUJoeU51ckN1RUF4RTVRVU5QamtDbG0veWtLNzlPMUdheWw0?=
 =?utf-8?B?a0dwWEQyOGVxNG5DVUhkb3Q0a2wrTHBuYlMxMkZsV3FTa3F3b2lQeTlmamxD?=
 =?utf-8?B?Z3VRZmpRem9FNU5xQjhjY21FVmt2dEJldkltV0pWRGU2dXNqMmxlWGthd2VW?=
 =?utf-8?B?Z1BaeitYZW1PN3Z4U2lUVU5tOTZRVzlYVXZjc1JOM3RXN2diSnhoc1UxZVlK?=
 =?utf-8?B?NXg1TEdUQjU0VjRqUS94QTQ5dGVIVXBWb2xCWDVXazNvd3NoT0M2RzdKdU5k?=
 =?utf-8?B?ZEh0dkNxWlhzdHFzQkxoTjg3RDNmYnNXeE51V2E4MFM1dVY0aXR3aDBwRDNF?=
 =?utf-8?B?T2RZR0RYNVcrVHBLbzRnY2t3a3hVcGkwYy83UUJ5K3BETkd6Ti9mckNaQXlq?=
 =?utf-8?B?R3dMQndJdmlISStBQmtuelNYSklIUGJXSDIvSHM0TkZTRlFFaTZudzZRRVFU?=
 =?utf-8?B?Zy85YWwwRTZnTlE0S2N2ajZ3dit0bVd0T0JJRGcvem5yQThxQmptSHVReHo3?=
 =?utf-8?B?dGJNWVJsSUVoYlFEcEFVZlVkZ0tnQ1NLTGtTbDdOZTMyRGFGOWMvTittNkNl?=
 =?utf-8?B?WFlYQzVTbFdVSFJpdEtjRDl5amxqZFpjSDBsZnVvVkVoL0paM25oWFNaakFR?=
 =?utf-8?B?bzJnbHAzNmFrbllLSTRMblZjendOMGIwaVNUQ3lZVWdWMnFlM3Ewc3MwcUVX?=
 =?utf-8?B?YU5WQko4M0xmbXhyU2RlZzliQlgrSEVRd05rcloxTTdQdU1jaEw4aEorL01r?=
 =?utf-8?B?VHVpVnpvUEhKdUhXS3lCYUZ2S3NaS3BqSCtaUTgvWUVVMGRoQ0xxR2lxVDBr?=
 =?utf-8?B?N2taejFDNFpmaCtoNXhUOHladlArMTgvUUE4QU1iSjRkcXhTaTJrVEgxMjZ0?=
 =?utf-8?B?ZmFGYnZLZEg3WlZ4ZVppSWx1SS9ZS09seVI0QkNhZktmc0FOK0dKV0tWZUYz?=
 =?utf-8?B?SVBJM0xHQmhZYVpzaWkybFQzNXg5eXB1c014Z2E1aUpkVzJaSVk2NU9jMlFh?=
 =?utf-8?B?c0tEdi8wN2hVQW9kWWVjd05OZHZmY1VmNUNPQU5tUjV6UUdaWFJnRXA4Z1c1?=
 =?utf-8?B?YUdiZEF6U0dENmllMC9xdlRZR0FTaE5na3BKbllKNmxWc3Rjc2tWdlBrYVZW?=
 =?utf-8?B?OE5sZEV4ekRSUWxnY2VHK1k4QlJuMU9zc1ZFdkYvQ0VCL3krNmhCNlZrNXdW?=
 =?utf-8?B?T0JyYXdDSHg1UnZCYWhkUGFyZzI1Yk5DeWJWR1B2YzNJblhBM3hSYnNvYjJ2?=
 =?utf-8?Q?6YrbURnrPEY7iteq4HeRKHxAw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a57536-c8a7-4142-2dd2-08dc1bec5e9f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:21:59.7179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v17KCP8l1Ul24VR4KhihkG7gifagUdvNpVYtqZnLVi4A6Fbbu5CsVA03uDjwG1A7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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
Cc: amd-gfx@lists.freedesktop.org, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/23/2024 1:38 PM, Srinivasan Shanmugam wrote:
> 'adev->gfx.rlc_fw' may not be released before end of
> gfx_v10_0_init_microcode() function.
> 
> Using the function release_firmware() to release adev->gfx.rlc_fw.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:4046 gfx_v10_0_init_microcode() warn: 'adev->gfx.rlc_fw' from request_firmware() not released on lines: 4046.
> 

The release is done through this call -
amdgpu_ucode_release(&adev->gfx.rlc_fw);

Needs some other way to suppress the warning.

Thanks,
Lijo

> Fixes: 1797ec7ffd1b ("drm/amdgpu: skip rlc ucode loading for SRIOV gfx10")
> Cc: Monk Liu <Monk.Liu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 420c82b54650..ce76fbcc2602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4006,6 +4006,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>  		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
>  		version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
>  		version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
> +		release_firmware(adev->gfx.rlc_fw);
>  		err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
>  		if (err)
>  			goto out;
