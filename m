Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E4AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318BA22201
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="adZ8xR0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318BA22201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D536EA9B;
	Wed, 14 Oct 2020 13:20:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A92D6EA98
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 13:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOgNeqtoaNl0CkuFgy+06Mt9qyK/6eUBmc+8Xh+Q3LTpocEkqha5Wk4HoBA2w5TveermWB1tNG5iikQ8qRike+Qrs1/5blds7rZzQ06UKqOlQbkil7J1BFGxWC8lAU7643qaQDvaM3W/Fwbmzfp2FytJ9xHKLGX0X9L9BGQ/Y0fsTGKJ2WOLt8hodSmkYEe+7v1EWNVeYGPGPwRugqO4iN4H2T1IgETEaw+ML2/eBKnA/KH3IYKHHa2yukJBMJwbJMbNYpHWchtm19rCespsRQyo3qPY7pb4Fvd1auzTvAQuQerdX8xurrTGGRgDfm+J2gqVtSxoTQC5X7GrOaYhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UpdwE10aKLbGoaWnuuVaKN2T7B6OLiHOsG94kN1I4w=;
 b=K3G3rRhDJ7P0v1Ko5mgbWzj7Z0OU8gmdo2zlnwE839oa2hVvihQU3NzaCkFcVzlps0MoD9SE8o4HUOyDEXlZtXESrtA7p3M4ER8DT8ImBeWmtK+3hCKJzMNIZcSu2cJWCcfh+jBdASc741ugAlteCJX8LWdzyv/Ha6Qe7lcQ6f6K6gFmmyRs+JACvo4OrzsT/v5HDXXM5DryKxwezPbaYht8ie4l6lTBmuhTk4rIU50t8Egop5jqsf+OfEsh4X1aT3TK8MrLC0RDNRuI3VjNndtZtgzrBvcomVttfZ2tEyFIHBSniX9sDp8aousNnplHdG7b7Fo+HrDyXoLWQGD5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UpdwE10aKLbGoaWnuuVaKN2T7B6OLiHOsG94kN1I4w=;
 b=adZ8xR0RUtzMsx0AirKYxvQArIh3s2Dopbwt0QmkF5LQQNvf2euzEwsryP9OLPEQc8DWfac7rg1bsT+FYUiK9GH7ehrCc3737mNAFMU6zxpgw9Nc3Dipyrls/8bdQWdLEuKDq87xBoSPfWIfZl/lm3pV1VomKEXm3jLwqDEEXBw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 13:20:25 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5eb:6935:456d:c18f]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5eb:6935:456d:c18f%5]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 13:20:25 +0000
Subject: Re: [PATCH 1/2] drm/amd/display: setup system context in dm_init
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201014070431.32207-1-yifan1.zhang@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <2ee6e905-ea6f-ded8-d72f-b14aac541b76@amd.com>
Date: Wed, 14 Oct 2020 09:20:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201014070431.32207-1-yifan1.zhang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::30) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 13:20:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39e6dc8f-3c76-4b05-398f-08d87043e945
X-MS-TrafficTypeDiagnostic: BYAPR12MB4597:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4597249E8B424FC9FD6566A2EC050@BYAPR12MB4597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KO8fevRTejCvQuqaAZ5Qbxh1czhrmNsLoCqeFP6L0atSKpoLH53QqOU6/8zcUJMYQVqU2eImr33KN9iJhZxFupQ1nmyWmaj0ieI/RI8h+dnryFd8tpFHVs3xN2CsO5ps9KIZkneUMXnwKOoaAS4LhJpYvY9PbwQsXGW0VeKBxOSzxU5Sn0UYSVgkIOcsh9f13FtGyUmrf340tR1P/wsnTHSH9uxTwBc5d2NOWHAvSsrgtN/xWug1tNNXKJrA1VILnyo/EKeGHQOogT4OllOVOw5/LX3ZGgdGyklCpR65rp0tF+a5PfTFqyx3PG4uIz79dZlAld48A3OiOUTe+pO7ClsEFoJx4BMa9GuoT/rbMWpGTdbPSGpQWLvyPqqbjyW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(31696002)(956004)(53546011)(5660300002)(31686004)(2616005)(16526019)(186003)(36756003)(66476007)(66556008)(66946007)(26005)(478600001)(8676002)(8936002)(86362001)(2906002)(316002)(6486002)(4001150100001)(4326008)(52116002)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TJlbTr93Wj4fqG8gDvrfFKATnHHiwE5zdx/BRamnE9jwGf97B4eDFKeNQvZ/rEeDZnORMS5EnxwAvgMkGLyEQwxPV6Zy4itET6SJdmyqSkoza9X80ejOBNIciXYrv45FoJIS5TjURwHAgx8ZFy5ndbsJVAugnCc9PZFlLGz5vF1eD6I1Rc9CJkqFDKXWtaDPv9vHHdbHLisV3lw4k83PITvO4ytnOYKjME122Op46ecxnpW195pMy8V+rkH4acSTpOGsPjWHN1Qy3q1SrXN1FNQP0ywAqXIMvuePgqpdbyHknnegNM9CDcqEaIug5IY2pTena3eyNSsnYFqMt8iUkZOSVpLq0JEtjeGEit6N4xX1YUUTbdxa+N6u9sR1ZYDl5M/O/UuqYSkpTNdxrleRlwgZVRNVkh3jgrkdW7znIpNbYylEUt/euOHZx72g7aE/3UZKsScwv9O5Hr+r4OKswt/2Z5IiviB/F8uIdtpELZyaZhfawsRZvHXWNu6mHxp2ym1a0txcfokLgFn2wlPjN4Ul1wU5KL/jrYsnLvDTZi9blwX9GZVneRcUcCBBp3HvYW+d+iCc1q4KlRlXQLeDMa0JB0A3xC5YspKLpOcKmJvZ5xb8BZCZYFYwFEmLXcf9sb2BLEQ5c85xOqEyYRfiAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6dc8f-3c76-4b05-398f-08d87043e945
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 13:20:25.4851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiBl7tWO490+5spuOjP+UzFhI6c85TuC09iRisM2e8E8vYPywSfitTDG7shKIcIBIskjzbYHccU6jvfsSsH9xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4597
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
Cc: sunpeng.li@amd.com, harry.wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-14 3:04 a.m., Yifan Zhang wrote:
> Change-Id: I831a5ade8b87c23d21a63d08cc4d338468769e2b
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 61 +++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3cf4e08931bb..aaff8800c7a0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -887,12 +887,67 @@ static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device
>   	}
>   }
>   
> +static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
> +{
> +	uint64_t pt_base;
> +	uint32_t logical_addr_low;
> +	uint32_t logical_addr_high;
> +	uint32_t agp_base, agp_bot, agp_top;
> +	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
> +
> +	logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
> +	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
> +
> +	if (adev->apu_flags & AMD_APU_IS_RAVEN2)
> +		/*
> +		 * Raven2 has a HW issue that it is unable to use the vram which
> +		 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is the
> +		 * workaround that increase system aperture high address (add 1)
> +		 * to get rid of the VM fault and hardware hang.
> +		 */
> +		logical_addr_high = max((adev->gmc.fb_end >> 18) + 0x1, adev->gmc.agp_end >> 18);
> +	else
> +		logical_addr_high = max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18;
> +
> +	agp_base = 0;
> +	agp_bot = adev->gmc.agp_start >> 24;
> +	agp_top = adev->gmc.agp_end >> 24;
> +
> +
> +	page_table_start.high_part = (u32)(adev->gmc.gart_start >> 44) & 0xF;
> +	page_table_start.low_part = (u32)(adev->gmc.gart_start >> 12);
> +	page_table_end.high_part = (u32)(adev->gmc.gart_end >> 44) & 0xF;
> +	page_table_end.low_part = (u32)(adev->gmc.gart_end >> 12);
> +	page_table_base.high_part = upper_32_bits(pt_base) & 0xF;
> +	page_table_base.low_part = lower_32_bits(pt_base);
> +
> +	pa_config->system_aperture.start_addr = (uint64_t)logical_addr_low << 18;
> +	pa_config->system_aperture.end_addr = (uint64_t)logical_addr_high << 18;
> +
> +	pa_config->system_aperture.agp_base = (uint64_t)agp_base << 24 ;
> +	pa_config->system_aperture.agp_bot = (uint64_t)agp_bot << 24;
> +	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
> +
> +	pa_config->system_aperture.fb_base = adev->gmc.fb_start;
> +	pa_config->system_aperture.fb_offset = adev->gmc.aper_base;
> +	pa_config->system_aperture.fb_top = adev->gmc.fb_end;
> +
> +	pa_config->gart_config.page_table_start_addr = page_table_start.quad_part << 12;
> +	pa_config->gart_config.page_table_end_addr = page_table_end.quad_part << 12;
> +	pa_config->gart_config.page_table_base_addr = page_table_base.quad_part;
> +
> +	pa_config->is_hvm_enabled = 0;
> +
> +}
> +
> +
>   static int amdgpu_dm_init(struct amdgpu_device *adev)
>   {
>   	struct dc_init_data init_data;
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>   	struct dc_callback_init init_params;
>   #endif
> +	struct dc_phy_addr_space_config pa_config;
>   	int r;
>   
>   	adev->dm.ddev = adev_to_drm(adev);
> @@ -1040,6 +1095,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		goto error;
>   	}
>   
> +	mmhub_read_system_context(adev, &pa_config);
> +
> +	// Call the DC init_memory func
> +	dc_setup_system_context(adev->dm.dc, &pa_config);
> +
> +

The dc_setup_system_context should come directly after dc_hardware_init().

With that fixed this series is

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

There's the vmid module as well that could be created after if needed 
but for s/g suport alone that's not necessary.

Regards,
Nicholas Kazlauskas

>   	DRM_DEBUG_DRIVER("KMS initialized.\n");
>   
>   	return 0;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
