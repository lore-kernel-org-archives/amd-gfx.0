Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3A5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 15:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF1810E491;
	Wed, 16 Feb 2022 15:25:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC2410E491
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 15:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVEuPlKGfmaR3LTbE+Z92eB7gvq4jjCYNFs60p6h1jVy214RVyLQ8Hyu7W17053a3KWatrs2jktHzUrLIYbqrF8V3zhrplu84qiSJGt2da0wACCEcZFhI6u1SyYnGIijdap/Ws+kzZuhyskEzOvSzGJpi0buuzrdnom9ynTPeGGY0HGU67Qu3aGqLDzpN+0tQrXPnsBoVb9SIEAj1/rbpgKLys9QzYcGwHAEMpoV/WR270Kjo1MEwCjNLH6D/AKwPvn9iC6NVY/FT15/R1gnJFIbE7FN7WWS2v1rOiJCmEl3Q4hKESC0tygkptTj9+jdkxWwKHOlMqCGSGxSBfFBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/H5VyGyDu2SEUvEbG+X3jdd5VPTidnt6n8snvEnv8s=;
 b=LpOz6WeHJ8wZKaM7n+GbFFIhYF+Ywi96U6fRiBvTsWC4UZR846KuUZdmt5hKL1mGz+ctyiwCxyqxgW8621BsS9boiyF0XD+D+TbzsToUc9k+nCg5r6XnBbsy3TfAqsNPrMAlUHJyMy1P9xQBMtked7ar6SjBp7oUYalkexIOf3/jCpOhrC5CqJXU4UpOwERzMu+Dx2+HsTg5DF4KKmkHXKu5xQOxzba8z09vyJgN/Ux1zaDV4xjrV5nZnBE34iFokFxyOt88ErKlAgJIge9e5xNcNDYDSEuc+kDBD+DM9EqmV+4f1iRmH7sI9eVjtoU2S7qC+bgm2jzwpvpvKiOagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/H5VyGyDu2SEUvEbG+X3jdd5VPTidnt6n8snvEnv8s=;
 b=SZo5UMq1oOTjepR7/r9/HAqj5o6jVmVdJlvvolsykBHP8MK6cV79nBxgnymh4rLWCiRW72f9s6y5MNgzmKo9jvpkvW9hhvVtR8nvlJRyE4X7RBxAXGZZmS8Tbndt2azVH8vmQq45kEXplewDMD//ELeOlKupda/n+6IQg/zRygA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 MN2PR12MB3246.namprd12.prod.outlook.com (2603:10b6:208:af::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Wed, 16 Feb 2022 15:25:56 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::7535:f1b6:a4ea:1527]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::7535:f1b6:a4ea:1527%7]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 15:25:56 +0000
Message-ID: <3f96f767-00d6-01ee-05b4-0da9c4a35716@amd.com>
Date: Wed, 16 Feb 2022 10:25:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 3/6] drm/amd/display: configure dc hw resource for DCN
 3.1.6
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220215214447.2234978-1-alexander.deucher@amd.com>
 <20220215214447.2234978-2-alexander.deucher@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20220215214447.2234978-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0e11d5-71d9-401f-e641-08d9f160a06f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3246:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3246BAC189F1E3A4613CA15A82359@MN2PR12MB3246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:55;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UO9Up0szSYBHPcJqpPx2fMHTI1VCixN7KDh78wTDlI5Q14ODmZ/c+VVItguqpuNAcMtI/kjZaBnyCiVPKS4kgFE6Jb07uGDXdIhsnywCRD9UsIPpE0kZmtR0hYXrV7PfyH54hWlQAErSL7LnrUaGr5NwTsx5xPQkyz97NYI0KVL5UoPGUB6RJOmrtWBHzF495xuhvHXynB8YAZUY7txcrGCl3Wjm93Wji83bZZjUR+HMBI/2fCkoGW99fKS3iq0riTINX6emjTuThul0Ps/5zMXaJ4oIzmWs1UUgSdh13WSBDmGz9VVUeXv1R3694CiKvIhxDy4bGe/NPby3VKgOA5aJNXn+kxvop0Z2VvNo+w9m1EQseBfv7HDhONiSbe/DRtDNcoEoJVF2S3ztGaF3F3hj5RF9OsOE8aQRZ/9rrrLij5OILEGNWmM8fshZ+ki+fMh27WITsp/LKWBjYBJM3aii/PmqFhHD/SNrgGFLMwDCxVctW/GViDfXeJrpwlRKdrkfxOG1CW4D1UjASlUZMokmRShk3BxmfS1E2i/BEiHZ32IBGXCxGMnZAxUv3iSM2oCPiF1c+a3hGIZmcvV9SGXYjDx72v55+avEAUJtvvy1KxNJ9MF209QUiKA03YBZpDNsGGZlCMthGA1V4ovsdTbWEvxYcQ4fVBwblCzYUZPxQfnxaVRjT1ktFiXFid1GVlhODIRlYLVEROVqph37qGnnXDBNcxHKcnVNYbUF+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(31686004)(8936002)(86362001)(6506007)(8676002)(31696002)(66556008)(36756003)(66476007)(66946007)(5660300002)(38100700002)(316002)(2906002)(6486002)(83380400001)(6512007)(2616005)(53546011)(508600001)(186003)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZieGw3ZXJMYW1GeEpaSEpkR2l1ZXJvY2x1NXQ1L2kxR1hlemRuL1JSL1J0?=
 =?utf-8?B?Tk9NUVVpdVpOWEFSaVltQzJRa2E1RUZQeFJJc2hKd3pJMC81S2FjS1picWZR?=
 =?utf-8?B?cXd5bjl0dkluU0hOQTJ0ZWk3WFoxK21zam43eDRBeCthVUdtUDBQTXRETmdG?=
 =?utf-8?B?OU9WZmlMM1lMbm5NUGNTaitubmVrNGpJYjhDZm51d25XdVdJVXpndndCczY0?=
 =?utf-8?B?RExuSktOQzZuM3RrVWEzazhUdXlEZVNzT1h5dWdHVDEySUVpRTBvNkJROTh1?=
 =?utf-8?B?bE1aSG1mZ0I4OTZvYU1tY1cxU2t0UGRKKzBFUGszbFVpdlhhOVQ0QXJlUXJs?=
 =?utf-8?B?ckJmdVFpVSthN1dQS1cwRHp0NGRwUzdYNklXRjJKa0Q3SmwyeUNQaTJNMjlH?=
 =?utf-8?B?VzA4ZklFVmlsdm9wU1NXTDJ1LytpdG5GU2JYWmNoL0RJc1duOFJzSVJrdnJV?=
 =?utf-8?B?dFBhL2R5UTg0S1htcWRsalFENTMyWDV2cGZUeVJVSlMvaGRUSmRueEpkM2tv?=
 =?utf-8?B?ckpCSCs3OEVtSk4vSENhU1liQUZJYXhaQS9pTGtLZ3dVNTFNaGtnSWlaOTV0?=
 =?utf-8?B?Ykp2bWxZem8yNFdCSUxjKzQ1eC8xajNwWHNoUG9KN09WUUN1cTNWNG5scURq?=
 =?utf-8?B?Z3VWVnB5WURQby84czF3bEM1YlRuT1BNSHJST1BRYkNNSjFPSUxSekdkVWN5?=
 =?utf-8?B?NERHWExtU2lMNTZGcTI0L0VPYUpEN21ZaUsvaVJjSklCaFZVQkw4eFBHMU5s?=
 =?utf-8?B?T2kvYW54eFl2N2VtT2R4VW9naWx4Nkt2RHpGbVN2aXBBUjNPTkV0SGtLQVRv?=
 =?utf-8?B?UXErb1FPVWREd1didXVxaEdnK1VFMHFzWEltTDZRTHlCSldBMHB0TTVnT3R3?=
 =?utf-8?B?NncxTDZFRDU2NjdOd0pIV3lNVjNROURhS0M4N2IxS2V3Sk5jOUxQOVlqUDIy?=
 =?utf-8?B?azVwU01kZVo1OW9RSVYrc0ZCaldFMGl2dFBoeHUwQzY4QVVObk9aeDh2TGVW?=
 =?utf-8?B?MFNwOVVpM1Jja2MxNHZ1ais0dTIwOWZ6Zk5MMnlWaGVlbWszMVFGcmowZ0sy?=
 =?utf-8?B?YlJZdmtYbWJTMktKdzR6UGVTWXkxLzF1NXA3RzFUa1dTcG1Od0pFZzhNNEJE?=
 =?utf-8?B?TkUvcXV1dUxJa3lCTWo2L2RLa25QQTZSMDNTaEpEMXBvZmoyK0JzajV6MldO?=
 =?utf-8?B?UVVlZjB3SC9PY2VSMlVLbmdyYWZ5OEFxSkZKQUd3OGprYm1lMzZOSmlDdS96?=
 =?utf-8?B?OEVkS0w0Q29FMHBXOWM0eUN0REFxSWxqRzZJcmpOQ3dwTDNLNVFUL3ZkazlI?=
 =?utf-8?B?RkJQb1JUYThGMFhXYVNzb0dZaTdTcnBvUXFzS2ZRd1FXNDRuYkpsU1NyaDRB?=
 =?utf-8?B?SFRpS3Z3YThHcEN5TGRXR0NKdlY2RlhpUk9kbElNeThXcE5jZy9zNXBLRXFG?=
 =?utf-8?B?VWRoRzF1bUx1c1VyUHdCY1ZwcE1nUzlROGcvbW1KQVIvYU4vYkRFRENueEtF?=
 =?utf-8?B?MTUyd1YvZU5kbFdEdDJUSG1FY0lsWDVKWFVzTEV1VHlkRVI5VFhsTzdPL1BC?=
 =?utf-8?B?dSs4SDhSb0FxMEl3Z3J6azM3RERJZ3F2cDROemZjWmRTMElSTC83dGtwYko0?=
 =?utf-8?B?RzJObHZxWWlHV2xwYmRNblMrLzNUdVZGalFlSVF6UzlNY2p5SGF4TlJaZjBR?=
 =?utf-8?B?S0VaMUd0eVo0bWZQYTR4OG5ZcWZPdkM4eXVtZURXVjNSNVNGYnZFOHZGQk93?=
 =?utf-8?B?ZkI4a1gvVldjQmd3V0tyUkkzUWV3OHEyck5JbXpoVlpXaUVpU3ZwVUZ3WFN3?=
 =?utf-8?B?UXh0TkJocFhMZ01lQnF4Y0RLdlFyYTFJak9yR0pqaFFZQjI5bVNBYlppb3FV?=
 =?utf-8?B?WDhPMHloZWd4R1owTnBsaTVKTVRjMExIMWlGc1lzamQrcHAvQUxLTE10RmVy?=
 =?utf-8?B?SW1QS0ZuZ2laeTgwNVFVWHlkalM1UXNIUjBQZUY2cXZMY1JoenFMVFkxdVhD?=
 =?utf-8?B?QThyMTIrbW1lQjZ5L2RhQ3JNSmdZdU9ickZnaDRQOGxVQUVCZXVyUXZUSFA0?=
 =?utf-8?B?NWFSNW0xa0V0T1VUTmVHWDgzQlZoMXptNEJQTHJZNnE3N2lnVXRzYldWVjZZ?=
 =?utf-8?Q?yy8Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0e11d5-71d9-401f-e641-08d9f160a06f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:25:56.3134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXymhApZEj7E5IQS1AauS99SzCMKMSbmhbCgoHxNDN2ZX3XCBJI+tyRHNXg3S1gj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3246
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
Cc: Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-02-15 16:44, Alex Deucher wrote:
> From: Prike Liang <Prike.Liang@amd.com>
> 
> - set DC version
> - add construct/destroy dc clock management function
> - register dcn interrupt handler
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Acked-by: Leo Li <sunpeng.li@amd.com
Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks.

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++++++++++++-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  3 ++-
>   .../amd/display/dc/bios/command_table_helper2.c    |  1 +
>   drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |  4 +++-
>   drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  4 ++++
>   drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |  1 +
>   drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c |  1 +
>   drivers/gpu/drm/amd/display/include/dal_asic_id.h  |  6 +++++-
>   drivers/gpu/drm/amd/display/include/dal_types.h    |  1 +
>   9 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 10ca3fc6d91e..a4254357bf5f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -114,6 +114,8 @@ MODULE_FIRMWARE(FIRMWARE_DIMGREY_CAVEFISH_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_BEIGE_GOBY_DMUB);
>   #define FIRMWARE_YELLOW_CARP_DMUB "amdgpu/yellow_carp_dmcub.bin"
>   MODULE_FIRMWARE(FIRMWARE_YELLOW_CARP_DMUB);
> +#define FIRMWARE_DCN316_DMUB "amdgpu/dcn_3_1_6_dmcub.bin"
> +MODULE_FIRMWARE(FIRMWARE_DCN316_DMUB);
>   
>   #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
>   MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
> @@ -1801,6 +1803,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 0, 1):
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 1, 3):
> +		case IP_VERSION(3, 1, 6):
>   			return 0;
>   		default:
>   			break;
> @@ -1916,6 +1919,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>   		dmub_asic = (adev->external_rev_id == YELLOW_CARP_B0) ? DMUB_ASIC_DCN31B : DMUB_ASIC_DCN31;
>   		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
>   		break;
> +	case IP_VERSION(3, 1, 6):
> +		dmub_asic = DMUB_ASIC_DCN31B;
> +		fw_name_dmub = FIRMWARE_DCN316_DMUB;
> +		break;
>   
>   	default:
>   		/* ASIC doesn't support DMUB. */
> @@ -4224,6 +4231,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	case IP_VERSION(3, 0, 0):
>   	case IP_VERSION(3, 1, 2):
>   	case IP_VERSION(3, 1, 3):
> +	case IP_VERSION(3, 1, 6):
>   	case IP_VERSION(2, 1, 0):
>   		if (register_outbox_irq_handlers(dm->adev)) {
>   			DRM_ERROR("DM: Failed to initialize IRQ\n");
> @@ -4240,6 +4248,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		switch (adev->ip_versions[DCE_HWIP][0]) {
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 1, 3):
> +		case IP_VERSION(3, 1, 6):
>   			psr_feature_enabled = true;
>   			break;
>   		default:
> @@ -4356,6 +4365,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		case IP_VERSION(3, 0, 1):
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 1, 3):
> +		case IP_VERSION(3, 1, 6):
>   			if (dcn10_register_irq_handlers(dm->adev)) {
>   				DRM_ERROR("DM: Failed to initialize IRQ\n");
>   				goto fail;
> @@ -4541,6 +4551,7 @@ static int dm_early_init(void *handle)
>   		case IP_VERSION(2, 1, 0):
>   		case IP_VERSION(3, 1, 2):
>   		case IP_VERSION(3, 1, 3):
> +		case IP_VERSION(3, 1, 6):
>   			adev->mode_info.num_crtc = 4;
>   			adev->mode_info.num_hpd = 4;
>   			adev->mode_info.num_dig = 4;
> @@ -5213,6 +5224,7 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
>   	case AMDGPU_FAMILY_NV:
>   	case AMDGPU_FAMILY_VGH:
>   	case AMDGPU_FAMILY_YC:
> +	case AMDGPU_FAMILY_GC_10_3_7:
>   		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
>   			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
>   		else
> @@ -6179,7 +6191,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>   	if (stream->link && stream->link->local_sink)
>   		max_dsc_target_bpp_limit_override =
>   			stream->link->local_sink->edid_caps.panel_patch.max_dsc_target_bpp_limit;
> -	
> +
>   	/* Set DSC policy according to dsc_clock_en */
>   	dc_dsc_policy_set_enable_dsc_when_not_needed(
>   		aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 5bfdc66b5867..8709827b69ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -663,7 +663,8 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>   		INIT_DELAYED_WORK(&hdcp_work[i].property_validate_dwork, event_property_validate);
>   
>   		hdcp_work[i].hdcp.config.psp.handle = &adev->psp;
> -		if (dc->ctx->dce_version == DCN_VERSION_3_1)
> +		if (dc->ctx->dce_version == DCN_VERSION_3_1 ||
> +		    dc->ctx->dce_version == DCN_VERSION_3_16)
>   			hdcp_work[i].hdcp.config.psp.caps.dtm_v3_supported = 1;
>   		hdcp_work[i].hdcp.config.ddc.handle = dc_get_link_at_index(dc, i);
>   		hdcp_work[i].hdcp.config.ddc.funcs.write_i2c = lp_write_i2c;
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> index eedc553f340e..d0fcfb158436 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
> @@ -76,6 +76,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
>   	case DCN_VERSION_3_02:
>   	case DCN_VERSION_3_03:
>   	case DCN_VERSION_3_1:
> +	case DCN_VERSION_3_16:
>   		*h = dal_cmd_tbl_helper_dce112_get_table2();
>   		return true;
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 9200c8ce02ba..a707d07d5197 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -278,7 +278,8 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>   			return &clk_mgr->base.base;
>   		}
>   		break;
> -	case FAMILY_YELLOW_CARP: {
> +	case FAMILY_YELLOW_CARP:
> +	case AMDGPU_FAMILY_GC_10_3_7:{
>   		struct clk_mgr_dcn31 *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
>   
>   		if (clk_mgr == NULL) {
> @@ -322,6 +323,7 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
>   		break;
>   
>   	case FAMILY_YELLOW_CARP:
> +	case AMDGPU_FAMILY_GC_10_3_7:
>   			dcn31_clk_mgr_destroy(clk_mgr);
>   		break;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 71b393194c55..ed6b0eec1b68 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -155,6 +155,10 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>   		if (ASICREV_IS_YELLOW_CARP(asic_id.hw_internal_rev))
>   			dc_version = DCN_VERSION_3_1;
>   		break;
> +	case AMDGPU_FAMILY_GC_10_3_7:
> +		if (ASICREV_IS_GC_10_3_7(asic_id.hw_internal_rev))
> +			dc_version = DCN_VERSION_3_16;
> +		break;
>   #endif
>   
>   	default:
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> index 5029d4e42dbf..c9ee212b2e80 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
> @@ -114,6 +114,7 @@ bool dal_hw_factory_init(
>   	case DCN_VERSION_3_02:
>   	case DCN_VERSION_3_03:
>   	case DCN_VERSION_3_1:
> +	case DCN_VERSION_3_16:
>   		dal_hw_factory_dcn30_init(factory);
>   		return true;
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> index 904bd30bed68..42adba630125 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
> @@ -109,6 +109,7 @@ bool dal_hw_translate_init(
>   	case DCN_VERSION_3_02:
>   	case DCN_VERSION_3_03:
>   	case DCN_VERSION_3_1:
> +	case DCN_VERSION_3_16:
>   		dal_hw_translate_dcn30_init(translate);
>   		return true;
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index e672be6327cb..79f6a9ddb4bd 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -227,7 +227,6 @@ enum {
>   #endif
>   
>   #define FAMILY_YELLOW_CARP                     146
> -
>   #define YELLOW_CARP_A0 0x01
>   #define YELLOW_CARP_B0 0x20
>   #define YELLOW_CARP_UNKNOWN 0xFF
> @@ -236,6 +235,11 @@ enum {
>   #define ASICREV_IS_YELLOW_CARP(eChipRev) ((eChipRev >= YELLOW_CARP_A0) && (eChipRev < YELLOW_CARP_UNKNOWN))
>   #endif
>   
> +#define AMDGPU_FAMILY_GC_10_3_7                151
> +#define GC_10_3_7_A0 0x01
> +#define GC_10_3_7_UNKNOWN 0xFF
> +
> +#define ASICREV_IS_GC_10_3_7(eChipRev) ((eChipRev >= GC_10_3_7_A0) && (eChipRev < GC_10_3_7_UNKNOWN))
>   
>   /*
>    * ASIC chip ID
> diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
> index 012b7c61798c..8ddb25519880 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_types.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_types.h
> @@ -57,6 +57,7 @@ enum dce_version {
>   	DCN_VERSION_3_02,
>   	DCN_VERSION_3_03,
>   	DCN_VERSION_3_1,
> +	DCN_VERSION_3_16,
>   	DCN_VERSION_MAX
>   };
>   
