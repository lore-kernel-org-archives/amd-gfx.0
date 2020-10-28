Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB21C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 17:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E18247F5
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 17:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="me/rnYlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E18247F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E50F26E123;
	Wed, 28 Oct 2020 17:13:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89606E123
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 17:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrEFHkHEIx/c5JjhUKOp7QICE5KThKZ+DHkJvfJtcjrVAeMc2yZ64d/YFh16QQAJ9x76vdEyf4loJLb1GLBB+oIBUooL3euekW/9mj8TbkZi6AwErIAZPBJf/oZkJdzFsRTB9aH/fXLAoRpwTN1RnEaiH6hI2s4RDRdmvSZJupdOoCfnFCXqAMDYL0AkkgN7vPRQwM2x4hJfttLlAzpIsrgEAmQf0yOM2/FgUWF4xwS2+334yISIYdIAEmH7/veowtYWXQZxGipyvdwLqXgppNgwUuqOcm2qwdoAM/ykzJuOFjBbk1+LEkR96fq+YCdD9wu9aoznwfd5oy/xvoAOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaJHFFVp1oBf6KW2+FVli0SVcSP85WF4x6zskw4NyPg=;
 b=cWZxiZMu2UFZ4aSiOEpVgbpARmd2E/jeUjpojOF9F9gVQ0yDqwfnq046NhsPYyHn+Wu7o1gvQcp1nhkZkY800OhCty38T3mRJxLJ+VbPHQf6G5dhnrLQPDVwLpGBKxPKA8kOMDRYAXJbwqJh/Piw2QaEFHoLj1hudUjRngL6PUiLWxV0an+aiIl9iNVmiuwOaoSFddVBOd2E1UTX+o8ea41EjdExZegXrISBQBdxiXPI6tE+MeH+NxN3wRksUu6cer+v6r7YIZjiOM/ecPXfjJcksVcdu4+sXsz/9rHNw+5tcwmKXMw7U7nDydkAkgttXuCdbhtjL9BMVFiBwv3KvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaJHFFVp1oBf6KW2+FVli0SVcSP85WF4x6zskw4NyPg=;
 b=me/rnYlWSuuPxc2pLkfxHIR346BbHDTudE45DoE2grhn2IQ/eZkkOQY3I1bXamrpDhckev+MQLjYitbZB3svZtgpQUd4l38fsQYozazgBAo4JvyF1iKZfM5rsCKdaJEdkRG6RuXprwdFymhjbbWooI5STBMjG7k65o9tjAbeSYQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4812.namprd12.prod.outlook.com (2603:10b6:5:1ff::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 28 Oct
 2020 17:13:29 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::935:a67:59f8:7067%7]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 17:13:29 +0000
Subject: Re: [PATCH] drm/amdgpu/powerplay: Only apply optimized mclk dpm
 policy on polaris
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201028150805.2400403-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <ad4aefe8-bf7f-73b2-3bc7-65c1a167b32e@amd.com>
Date: Wed, 28 Oct 2020 13:13:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201028150805.2400403-1-alexander.deucher@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 17:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2adababa-80d1-42f0-048b-08d87b64ca4b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4812:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB48126D11F428859BDEE863B999170@DM6PR12MB4812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2B7knU5P7QvJu5Zb1eH0m1722mmYYR86besOt/6bOiX6EKMfKFCfOPOPf4HGf4y3FAffgR4sIGenyy3/+hRwVADQlxor3DjHc3zqSlJGjGT3R1l3Z9VOIFmHRMb0G8ZeMIyNmCy/L/tcus37UngE9TLOkrg4Yy5Q3zeK3wrv9ITfVKm+QuiEE6n82GnTjjtHJjGe1msjLc2YGtNs9lvO+BxucbbMe3NiBPptt8bI71a46+i+exjVFZxpjhfNnZn9HMhOHeZnfCzQO7BKmcL5NC+0x5sTsfkSx4wpEQDKvlCcSHTATPgdY7Vb+OeHe6WDSj6WsfoOglX1kN8k6CpMFTR5NFGx2+CI5cmg8ijmmp0h2HvKkjlL3DTxsDQNZY30V1V3g8BdYtHP2eRcUQ8GXHefVM/Z0UHfetNcNPkwag0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(16526019)(26005)(4001150100001)(31696002)(86362001)(8676002)(316002)(36756003)(186003)(16576012)(4326008)(5660300002)(53546011)(966005)(8936002)(2906002)(6486002)(52116002)(83380400001)(31686004)(478600001)(956004)(2616005)(44832011)(45080400002)(66556008)(66476007)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O+I8bZW8OcfnWb8+xzfskzXvSp+tAVsq7gLjadWs+jZt/8Ffm6KOLlC+XznHypz9vEDD2GfAcB5C9iUCnC8bykVcqnQxJB2xxXHyzVoMHxKpKKkfsqTCtwaYVZlIU40Pw/yVM43LqWp5eoK4E6avVIROP7/UZgovZ15XVzH5Ip539OWrhEck4cO/Lq8q90dDyniatjTMK5rirjzh6/D4kWYvFTVqwjeHkgSVnp6qE9RsowxEAHFBfVj/34G+g1zmLHm3bVgwDvJbfVbCUhTMqwpS5PTVqplMPwxtAx+G4pOfFQRxFliXUWNY/obcWKXHv94MPpKMJ5G85hLHa475E8mtyVU5PN40nq+xAcf3TlITTpDeDs5dhrGPTImZ+iA3NHUs3rChhg2tu5Em3phSdWbXflITWJdIsEFnGBJ87x7j49PvTnEKhaVjQU+sNQslwCzOTRWDA3jaiOjHVqbzw8UmNU4a+YSQDmXx54rjua7EvX6er2NhF2qCFkPQXlFDB9MrcOvmIKytq3Mo1Ra7Md3ZsPgC4UpSrbcqRAbEBT6y9mlI9rfF3zFBZObVp9d40/PT0icvHOid4HW/1wjMrKTt2cEdAJtT2+YRLAhb2fOI1qNFzt/62EO1IuWdQcLboYOk0B5bp58pvWjaTgg7AA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adababa-80d1-42f0-048b-08d87b64ca4b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 17:13:29.7123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89bjAEWdeMyKrtmCA/Ivll1oQVL+L5l4naXhdlKIVM/nn+eUr14RV01TnF8w0BRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4812
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

I assume that the default ("else") case is what is wanted
by this patch and has been vetted-i.e. it what fixes it.

Regards,
Luben

On 2020-10-28 11:08, Alex Deucher wrote:
> Leads to improper dpm on older parts.
> 
> Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1353&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7C154766ca87eb40cce45508d87b534dba%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637394945025356066%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RB%2FDlyoqyasJWWkmB6dL0jxzVM9Auc223YNkEmpIj54%3D&amp;reserved=0
> Fixes: 8d89b96fe797 ("drm/amd/powerplay: optimize the mclk dpm policy settings")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 49db61a89505..d642dc95e9ea 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1713,18 +1713,24 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
>  	data->current_profile_setting.sclk_down_hyst = 100;
>  	data->current_profile_setting.sclk_activity = SMU7_SCLK_TARGETACTIVITY_DFLT;
>  	data->current_profile_setting.bupdate_mclk = 1;
> -	if (adev->gmc.vram_width == 256) {
> -		data->current_profile_setting.mclk_up_hyst = 10;
> -		data->current_profile_setting.mclk_down_hyst = 60;
> -		data->current_profile_setting.mclk_activity = 25;
> -	} else if (adev->gmc.vram_width == 128) {
> -		data->current_profile_setting.mclk_up_hyst = 5;
> -		data->current_profile_setting.mclk_down_hyst = 16;
> -		data->current_profile_setting.mclk_activity = 20;
> -	} else if (adev->gmc.vram_width == 64) {
> -		data->current_profile_setting.mclk_up_hyst = 3;
> -		data->current_profile_setting.mclk_down_hyst = 16;
> -		data->current_profile_setting.mclk_activity = 20;
> +	if (hwmgr->chip_id >= CHIP_POLARIS10) {
> +		if (adev->gmc.vram_width == 256) {
> +			data->current_profile_setting.mclk_up_hyst = 10;
> +			data->current_profile_setting.mclk_down_hyst = 60;
> +			data->current_profile_setting.mclk_activity = 25;
> +		} else if (adev->gmc.vram_width == 128) {
> +			data->current_profile_setting.mclk_up_hyst = 5;
> +			data->current_profile_setting.mclk_down_hyst = 16;
> +			data->current_profile_setting.mclk_activity = 20;
> +		} else if (adev->gmc.vram_width == 64) {
> +			data->current_profile_setting.mclk_up_hyst = 3;
> +			data->current_profile_setting.mclk_down_hyst = 16;
> +			data->current_profile_setting.mclk_activity = 20;
> +		}
> +	} else {
> +		data->current_profile_setting.mclk_up_hyst = 0;
> +		data->current_profile_setting.mclk_down_hyst = 100;
> +		data->current_profile_setting.mclk_activity = SMU7_MCLK_TARGETACTIVITY_DFLT;
>  	}
>  	hwmgr->workload_mask = 1 << hwmgr->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
>  	hwmgr->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
