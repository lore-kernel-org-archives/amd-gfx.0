Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05BBC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 15:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8305622516
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 15:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8305622516
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E026E029;
	Mon,  4 Jan 2021 15:58:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD0A6E029
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 15:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqQ2MTZ9rpwATOe3vVzA9Ujevt7Y72aOrUkkxahAtfRBt6kNIfzqQKnOlFRr9UufdV4SjFNtSHsbkfmosx7/IfRGiG7Ncabd/dz7vWqk1JxbiK1JmNc/cc0Gsy1b+qAQpMcZARcCLU1jN8B9b4xohgQj5qBKohATESlTFHzzk570616MuHswgxbqg3Ql6Ly6FPABGPNMqzXo3Z7ZbIqsZ7EJh7C8GI8LHcQADv1DQKxdbrCPqywC8zLmT2ryhhNL0ngczWo1WVYAyioII3gByxw4+EapQ6PCrJ06GffHZztFuwxCCNAO6ReIP6S3f8SO33ubp1gmgm6Pm6nnQKKc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAtFLgYwmMfYEgNv59NeMi5zO5t3+S/4Pk7ApdksB2I=;
 b=DNIBiyq+TjMHMhGrvG0APafgZMLxI4s/QIJhcOAni89JlZaJDkzIRLEWwrXvQnwIhrDIbSSO2btcwrGA04I2qiNCC+jf0XiTIQto+7AyDmEMIwSXpt6MMRjx6EhnImm2WEAbbMivm0MHPNg2LOhWJjzfY3ArR+axgHhqXwpifF576CLyndQiwNDQebbt2RlwFoCFNZt6mCZ+rg8/3tT3n4xxjb0m5BkkMNgO4qJBAKFyxR7lJqKPyVyjyCiee1iSk4XmSq5QZXN5slkP0izJtEcrBr3FgcQ4vsuf2QpDVGeN6vgsyKyk50XdnIg32xNze7+8bujrTJR43KItMxDgSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAtFLgYwmMfYEgNv59NeMi5zO5t3+S/4Pk7ApdksB2I=;
 b=b3dQYrF7yLeim+eFN2paQTx34yTg/DwX2ry8q3PYAValhWSgWYBBEME8BTuqohS7pCGKM79YtnAIU0MNitU4hPEDZSk/rlPQx9BI/SSt5R9EK7OuJsHr4IaurAR0zC44V7DAZOXJBPoNsCoTa1yllnUtLOe1AQfnJPZD54gzAHo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3382.namprd12.prod.outlook.com (2603:10b6:a03:a9::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Mon, 4 Jan
 2021 15:58:35 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::c415:a6:f78f:82f5]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::c415:a6:f78f:82f5%6]) with mapi id 15.20.3676.035; Mon, 4 Jan 2021
 15:58:35 +0000
Subject: Re: [PATCH 1/3] drm/amd/display: Add module parameter for freesync
 video mode
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201210024526.1151447-1-aurabindo.pillai@amd.com>
 <20201210024526.1151447-2-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <eeb2a4ee-57fe-3df6-b731-ccbf57a470e7@amd.com>
Date: Mon, 4 Jan 2021 10:58:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201210024526.1151447-2-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.19 via Frontend Transport; Mon, 4 Jan 2021 15:58:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 933ad9ef-a91e-455f-8bbc-08d8b0c997d4
X-MS-TrafficTypeDiagnostic: BYAPR12MB3382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3382DF0462F8AA944E38D853ECD20@BYAPR12MB3382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVUS03kG78YX/WLoBmd4EEyBITmxGtoAfbv9sqdc7LuLO5AdsuWHGtvDUs287d1Z+PF/RxA8YWxcWzPL4xEJCUmvEe/+nXIRn7qW5RRW0845c1uXnb5i9p0ZBjyF5mL4Y514mKtgEjWn/F5BWDszc7ZYM6bp8SvdyxkfGE81W/UQdBQ8hIJpDUJMi5IxMfF+kRB8n3v6XBj69aflAr3Y6HbXmadGujhC6cCEsiTwAD3brxv22TIoS1LzXwsfVmhNhurUevU728chgf27aJFgZzjx+2KHhGNBW2KHYQui6WgwA3tDGXojSWhqp5ZDhQ1AMkZkG1Grh1i9IVw6nMO+9V0zCHz7WJ07Vz8dm73I1jzx/SnfWqLTQSBCnWDTPxuOMwsVZsSpTl1D+gEXOBmgTE0v5rNVGqFzHmtj/4ipq71IjfbzYstvjxkIwL9FuquY5Ju6IZbSmgvbYX0s/GOnzg1xcNh/y3T0cvlPlyuK8hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(16576012)(66556008)(16526019)(26005)(186003)(66946007)(8936002)(53546011)(2906002)(52116002)(31686004)(316002)(86362001)(66476007)(5660300002)(36756003)(8676002)(31696002)(6486002)(4326008)(478600001)(83380400001)(956004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dzNiS0RDUVZTcU5RN1F4ZEcyUDU0STZrL2lhWlhPOHcvQ3QxemhFTEZBQjRl?=
 =?utf-8?B?TW9EVUtKSVFSKzVKQ3VLaXVEeWhJMm5SQnhTZUUyMGRONXJpK1BtVi8rc1VD?=
 =?utf-8?B?YVlVSnUvblhIbG9zNlRvamdCWkJVdkdUM3lnaWlIamE5ODAwaDQ1SlJBeWdW?=
 =?utf-8?B?aDg2NHc4UVpseFNVeEtoSGN6ZVYrR25RcXdPSzdyVXhobXRXWHY5RkdxQVRr?=
 =?utf-8?B?b3JSdFVXNy9qdTNuTlF1ano1SUl5ZkNUVkxOQ2dTYWtvbDJDTjJIZHRMZ3N1?=
 =?utf-8?B?Z1hGOThTNjhUR2xKUldJeWpIbk5OR3lpNk0za3g5Z1phTzAyT3N4QjF0WEV2?=
 =?utf-8?B?b3ZuNE5TcFB1akZNZVZaVk1VbXo3a1c5Y0JkNjhjSEx6dGpWczlrVGlpWXFs?=
 =?utf-8?B?Z1p5Zzg5Y0J1SVBSc0NsMVN4WGtuTnYycHlnWUttdXA4Mjkyc2pWemNFakUv?=
 =?utf-8?B?cU1lcnB6UUVoZDI2SkFIS28yamI4bXRUbHhpQWp3WVF2UW1pMW9oSnh1RXc2?=
 =?utf-8?B?NVB3WUNVeTJlRkE4bTlzdHVZdmhWTTNFR0Jkek9Vd1FyRWViVTVDY1F2c1dT?=
 =?utf-8?B?TlFGUEYyUUtQRm9qY3NzZmdtTm8xODErZzc3aHMwVkIzT2szZ0d5bkV6SEtO?=
 =?utf-8?B?ekRTRDd3dXgvaTQwUTJYOFBKeHJ1ci8rcnNIWExTbDJnYWJKUzYrMHo0RG53?=
 =?utf-8?B?cXFqR1J2R3V6dmZ3cVI5T1dqREt1RzNqQUhlTlhHbkJRUVcvMFU1RXpwWXRw?=
 =?utf-8?B?UW9HTVg3elJEdGVHaXZJQURkWVgwZkZTbW1tNXJycllhWUxhdFRCZU9idG15?=
 =?utf-8?B?MEVuUkhGMmFlckt3SHdKQ0tFdlVEa3RDU3lETDROcmdoVXRuTHVrY201c3B3?=
 =?utf-8?B?djh6bEowV1BCcnFtVVhTVVJ6NHltc3YySHlkRnZFUzRYU1U4enRzYzExeVd4?=
 =?utf-8?B?Mm1yS1FPMFl0UlhObkxtNFU4TnVFd2JvcmtBTlFNclg1WGp4K0ozSzdLL0Mz?=
 =?utf-8?B?ODloNlJYTmRvVmIxNmNlanUwckN3WklkUEtFWnlERzRWelFSNTBzaGllekR0?=
 =?utf-8?B?WmRIeCt0MnVCZDJFZFpFbjFnV3YzNVgvSlpLckpHTjV2VVNSQ2UrNm41dlBk?=
 =?utf-8?B?Y01DVjRzaW45b1Z0aWdMalJ6dFBKdHZPV1FZZHJ4dUsycEZNSWcvU0JXaUNS?=
 =?utf-8?B?ajZURml3azNadHJKUVA4Rnh3RWUyVHY3OXJLb0hMT1J4d242RGdPck9KU3BH?=
 =?utf-8?B?a2xON0hjN3ZoQit1THE5UDRZR3gwdVYrK21pVStmd2F4VU9YT2thMXo5dGlI?=
 =?utf-8?Q?WuVSTWbrZrAqxhcvpSyZ996Dx8dZBRaQOt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 15:58:35.3790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 933ad9ef-a91e-455f-8bbc-08d8b0c997d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcBvpf1AUyyqVLWSVeQABAqmlLbOoxidoJooU3N9K+0sCc4VWc0LUGKX/G41MdA2QeSHhVDwQ4dvfCef7q2Mhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3382
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, shashank.sharma@amd.com,
 wayne.lin@amd.com, alexander.deucher@amd.com, Harry.Wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-12-09 9:45 p.m., Aurabindo Pillai wrote:
> [Why&How]
> Adds a module parameter to enable experimental freesync video mode modeset
> optimization. Enabling this mode allows the driver to skip a full modeset when
> freesync compatible modes are requested by the userspace. This paramters also
> adds some standard modes based on the connected monitor's VRR range.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 ++++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 83ac06a3ec05..efbfee93c359 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -177,6 +177,7 @@ extern int amdgpu_gpu_recovery;
>   extern int amdgpu_emu_mode;
>   extern uint amdgpu_smu_memory_pool_size;
>   extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_exp_freesync_vid_mode;
>   extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dm_abm_level;
>   extern struct amdgpu_mgpu_info mgpu_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b2a1dd7581bf..ece51ecd53d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -158,6 +158,7 @@ int amdgpu_mes;
>   int amdgpu_noretry = -1;
>   int amdgpu_force_asic_type = -1;
>   int amdgpu_tmz;
> +uint amdgpu_exp_freesync_vid_mode;
>   int amdgpu_reset_method = -1; /* auto */
>   int amdgpu_num_kcq = -1;
>   
> @@ -786,6 +787,17 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
>   MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
>   module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
> +/**
> + * DOC: experimental_freesync_video (uint)
> + * Enabled the optimization to adjust front porch timing to achieve seamless mode change experience
> + * when setting a freesync supported mode for which full modeset is not needed.
> + * The default value: 0 (off).
> + */
> +MODULE_PARM_DESC(
> +	experimental_freesync_video,
> +	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
> +module_param_named(experimental_freesync_video, amdgpu_exp_freesync_vid_mode, uint, 0444);
> +
>   /**
>    * DOC: reset_method (int)
>    * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
