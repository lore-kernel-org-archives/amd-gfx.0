Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8324C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 14:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858F122B3B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 14:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858F122B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351C66E17F;
	Fri,  4 Dec 2020 14:51:41 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690088.outbound.protection.outlook.com [40.107.69.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA6E6E17F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 14:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVXhuRmoPiqymZDwi6BF7+m79039wkXFbCoG4vriu9qGFmw4WCiMLJbYgEMIGvKkRJSENQhu4h7dw9uNOCs1MFKAqL7/q42QmPYsV/fpnjjiAvxiHIwZKsUVX55a7MudiY4YsbGEHfTdZAVEtq2upqImcXc+RLK+xqRPYMZ3XQlVD+Sqcj+O0f0Wor4QygRAJXFOTcLV3qkYt+X7WAPpuR5roBdOyc1Jlq+LuhS+0wCelhRb4JfOLQzGB5dK0u/7Se66mr/8bGxM1C/zNImxwzosDkGV3QW8N1KmQqpAwrnoMVzZjZLpixo93G4E0RZ2OAJnHLsZMtCBrOhzaMdg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13l/g584XOUqcAYWkTGmp3msyQZ1NZd4PTFf7YkJTFo=;
 b=BvcILsVMW81+/7Soe1I2iwKiVHMyRO5tEKV1DYXgZrQxW0UiJm6EGmNnij2ohpnFhFIZJ68EFbnJGXis2pEd1+gq/Uir3KhGkTCYcYTdkT3mNp0w09BN7m7E+mh9tuT0j/cI1m5CYWw7ZxCSmx5zVc7j+lzDbOjrXNi0dFDZhJ/916pjt3sxotMxNU1BwpvORTfEvquoKXyZGVYPuVxmS0eqS7C3qc3LQgo169CW3hapStWVh4NU/tpePKaqUocGqIG+Oa3w0diRxN9psJuVY6RWym07VcHsUxxyCd4pSXSBOIVptFf7/YRD4PR3pGXCkSg4qLFbvg37nx94COQYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13l/g584XOUqcAYWkTGmp3msyQZ1NZd4PTFf7YkJTFo=;
 b=x8V/edHwRjVpjZ+JoRx8HbTwJFbQIYKESi+OaIFaPMaeAtXcxtXcGZw9OJ1dxz9ItP01QjBZ+i7il3P4Rq9QJfq2c0nZO+Nm1VAhECdASX95X7sEmdDNjRTpQ5L7cboDzVIwi+SfTqT/yKTtn7xWmf7aGe+ZxmbNNFBe7GFX6X4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 14:51:38 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.032; Fri, 4 Dec 2020
 14:51:38 +0000
Subject: Re: [PATCH] drm/amdgpu/disply: set num_crtc earlier
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201204143024.16465-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <9e8292c2-5449-1632-fc88-c69b7cf27887@amd.com>
Date: Fri, 4 Dec 2020 09:51:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201204143024.16465-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH0PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:610:76::25) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:76::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 14:51:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 078fe520-e2f7-405a-7ab2-08d898641a8a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3463C333BB54C515B9E8FAE3ECF10@BYAPR12MB3463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A67GmVl+HGj9/PSRb0KunLigQvehg6QIKKtwOEMUTZaR5gnJFQI1/qb8V9FNI73XzGL9V4eaFSGuXWv71EvmmKFawXopk2xd+pUl2p3qSZVRZjQ6KoFe1LArJYphPcjxBKF5fTMUrURmftnYO3MvQRn6bpOsbWphDr8AY8TNH50AxCn6ZBmB9M2edOSzKXJRBUeVDDmf897bkcSw8CQ76G5VLOUh4M+zYt169dzdIP1b7yQGfSBam0JvMYUzguY/J3IMaxJYnFSGo4wUCDvD65ekBKfOGkhMPgKFvCWZ3Ruv1zP0cbsUAghMDbyw3E1SjRP5lCCMSU5U2vioS35oFewojLhPiwdaT+fwBtI1sKaCoKljMzcwNU+wWdwHOkQ2EAib4tgwv7z5uIbyY24ToxcY6odB3evaxpv0MNsaWmWK96M5Z40qKEKUJsmLxwz/K0ahBd10ZBPtThigGk7hDDnAGVBvXC0R1BheCM4aLpo584e6tfuU4sNGpwz4MDO6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(83380400001)(478600001)(66556008)(53546011)(4326008)(966005)(66946007)(52116002)(2906002)(66476007)(31686004)(186003)(8936002)(31696002)(6486002)(956004)(16526019)(86362001)(2616005)(8676002)(5660300002)(36756003)(26005)(16576012)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bkQxMUNqdzNwTm0zWEpseXR6T0NNSVJLbXB1NmZzQ1ZqdjBSTGRHaEpHbW1I?=
 =?utf-8?B?c0d6aVNBdHJldXlnUWU4T0lBd0hOcTVadERnT2ZleVh4d0xrQ2dIUDl5cGhH?=
 =?utf-8?B?YmFWdGZRWVQ4bjZlYTlILzc0VVN0QWVualVVYWl4dTFzb3hzZlJTSWM3a09m?=
 =?utf-8?B?d2F0bjl6VWFSSkhBdi9qY1BBY0ZyWElLcVg2WUxaWGtmQlh3SjhqeFkyV0I4?=
 =?utf-8?B?NlJvbitNb0l4UWdxN3dXaFZoc0dlN25aNE1STUJ3azJJRTR2N2l0eGpsOEg3?=
 =?utf-8?B?eEtycWU3dnhlN2VMTmIxcURaWVk1Y3RPbW95T0NuRXJiTitRaXZRN3Y0QWJh?=
 =?utf-8?B?MVZUVGIyWDlyRFJqR29BZE1BOGVYUU9lR09TMURWd0VLY1JTV3NxRTBBWjVl?=
 =?utf-8?B?UUUvWEdSMG12NXlWbHlNRlU4YjVvVXNFSDVWeFg4UHF1QktoMEo5NzM1MkNI?=
 =?utf-8?B?TFdud1Y0M01zdTBxYVViT1NBUHdSTEQ5cGdZdCtzWXhVRDlLcklMamdObmNl?=
 =?utf-8?B?ZnlnOEM1WHh0SG01OG9Ha2hsOGZJUmFDWFZmVSthZWE0V09BWmVraC9QYUY2?=
 =?utf-8?B?eXg0Y0JoRndBb2VHak8waFJqM3hHY2lCaHFXbzY3NTYvK0gvRWQ5bm1zRlNK?=
 =?utf-8?B?bjI0WVpGUks1cHdJVjJmTkNBNXJhMEtIblJjc2EzVWhXUHVFcTgyUUh0TUlX?=
 =?utf-8?B?d0xkNDNnUXRYNEo2MWVVSTRwa25SVHNlMGRDNmdUaE9NUThFSlVsSVpObXJM?=
 =?utf-8?B?UzJ4Z0Uwek5tdkhCZ1lIanpTbThvWmViMHJrL2tnUGxlb3A0aFE5WVR0bjhU?=
 =?utf-8?B?bHdRMjE2cnRQdlJ0amNtWjdXL2VkM3pKU2NXRmRVMU5PaElrRm1rUTg1Y1pC?=
 =?utf-8?B?eWp2ZnZBclNIZFUrYUlEcWRzVnZxQWN3OGp5Y1dUZmFueUI0bktXSk9DU1Jh?=
 =?utf-8?B?dnBXcGVEUTBmQUt5bDZnclNYYW1OTWxhbWplK2xQYjArL2RBOS8vS1lWRG55?=
 =?utf-8?B?Q1RVTmdqS2l5WnVBb21qcFFMOG1aWnQxYjhuS3JZZHN5aVk3ZzVyd0VPVy8y?=
 =?utf-8?B?K2ducHBoaS95ZE50ZHlaOC9qaGloeEhtRVAzVmtHcUJiK1R5STRyQXRQcGJ1?=
 =?utf-8?B?cWY2MFFLTy9DSWhxaFYySW54MmJEZE9NdEdFdWFOaHJ0L2tTTUJNcGVKeUNB?=
 =?utf-8?B?WHowRDl2ZXFHaVMyWG56bmtCTlVKQk9razlxYlhjZ3BpWGNDQnJsRldUZTZM?=
 =?utf-8?B?dGRLdDZQaUJDRUJJZ21Bb0JIQmhrWjN2b093QlhlcDVaelZnby9zd2ZUeXV4?=
 =?utf-8?Q?7WqD66lN3RrnkrOMpdIV+ckCP3EGr1wgHj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078fe520-e2f7-405a-7ab2-08d898641a8a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 14:51:38.5387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7lkaPH9MlDiXI2SES0C5fB/y02jhppGXDhUHGFyVJj5x4kymxIBQYCQh3bcUFUqgIn9QPCHpmkn5AHaAgg19g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-12-04 9:30 a.m., Alex Deucher wrote:
> To avoid a recently added warning:
>   Bogus possible_crtcs: [ENCODER:65:TMDS-65] possible_crtcs=0xf (full crtc mask=0x7)
>   WARNING: CPU: 3 PID: 439 at drivers/gpu/drm/drm_mode_config.c:617 drm_mode_config_validate+0x178/0x200 [drm]
> In this case the warning is harmless, but confusing to users.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=209123
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 313501cc39fc..1ec57bc798e2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1130,9 +1130,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		goto error;
>   	}
>   
> -	/* Update the actual used number of crtc */
> -	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
> -
>   	/* create fake encoders for MST */
>   	dm_dp_create_fake_mst_encoders(adev);
>   
> @@ -3364,6 +3361,10 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	enum dc_connection_type new_connection_type = dc_connection_none;
>   	const struct dc_plane_cap *plane;
>   
> +	dm->display_indexes_num = dm->dc->caps.max_streams;
> +	/* Update the actual used number of crtc */
> +	adev->mode_info.num_crtc = adev->dm.display_indexes_num;
> +
>   	link_cnt = dm->dc->caps.max_links;
>   	if (amdgpu_dm_mode_config_init(dm->adev)) {
>   		DRM_ERROR("DM: Failed to initialize mode config\n");
> @@ -3425,8 +3426,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   			goto fail;
>   		}
>   
> -	dm->display_indexes_num = dm->dc->caps.max_streams;
> -
>   	/* loops over all connectors on the board */
>   	for (i = 0; i < link_cnt; i++) {
>   		struct dc_link *link = NULL;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
