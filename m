Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8524C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 13:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338A220678
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 13:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YCgu2aGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338A220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5D9B6E38A;
	Wed, 29 Jan 2020 13:53:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753EC6E38A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 13:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WltrCixVVroVGj1SuQsKzUKY/SsrtBAp5e63RNVgtl8hrh6NmgwLEKwetIBmPi/C7lAiWGa/tcy6G/75pPZAjF5loZFZnZScWU0hhM5EO74VScNvkzr5OZlEGBa19z1qKkLzN5XaFBTOqaGPmod0mQy6KNY5jUNrZTPLdtHRgW+m+BNd/PNmeok6GJ2BerSNRxdDtNfGUhZy/BYUBUDLxsbB1avqPPB3VKuldNVqx+S+xk2nNaeNtHYtmKgO2aPI3EDCHLp8eGVTOP3j3kIJTu4e5xg17H9Iji9KwqwxLMhVnVdodc0D56KcyJLlbSXl48/4QTD/J+tTsq7b8h7+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gWo9BWxPdILHHOSdsokK8LunAVBowm7/vz+7NKWoMg=;
 b=ob4L84buq6/OioMoGUhkeElKr0GAPFq2ky9dG4oQmqby+55WSL0aTg0j5zsUf74gVq5dySZ8JCOz+c+3oUfoBmKFVDz5EB2MvUKPEDgID3QnhAT+TlXJCf/8HkfyIc7Dq0zW10KBN5YJhpVN/KJCHjuxx+1sXWZvay0Zgz08qjwGZr0FoXVgDtj18K0697CLt5IC+L3tvQ1dVin3F+YBj1mryPgWHHNuEyeqdVNxNo3yIQPzs+UFsvGLwnhgQ6Oupg8nTrOmsCiGbS3x7KvX6jJauJFOmNToeEvAI+wzOYp8jhWS0aIQ3OorxO9GjcMVM6DeY+ojMaA1qozeU+RZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gWo9BWxPdILHHOSdsokK8LunAVBowm7/vz+7NKWoMg=;
 b=YCgu2aGaguNXmtiFzGpyHz/cs4i95ZxgmZY3azdA0KbuCIdVU7WXATU2Gopz1UmRulH2X1RkH1PqGRc/CaQQv34PsvQmvo5vQIoBG5J9H09KmdWJ5OXYQaGo6A0cNKdHbDz++GJNH0YGA3+bJ8Ydir8nLXxMWfK5oMfi6daRGXU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3094.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 13:53:32 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5f8:d155:b213:ef50]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5f8:d155:b213:ef50%3]) with mapi id 15.20.2644.031; Wed, 29 Jan 2020
 13:53:32 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/display: handle multiple numbers of fclks
 in dcn_calcs.c
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200128194707.87898-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <1f3b69d0-617b-38d5-18fc-0af081cf7856@amd.com>
Date: Wed, 29 Jan 2020 08:53:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200128194707.87898-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
Received: from [172.29.1.94] (165.204.55.250) by
 YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Wed, 29 Jan 2020 13:53:31 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f171a0e-9073-4837-a293-08d7a4c2a099
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:|BYAPR12MB3094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3094FBEB7A2B3A756768F7FBEC050@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02973C87BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(66946007)(6486002)(478600001)(31686004)(316002)(66476007)(16576012)(8676002)(2906002)(81166006)(81156014)(66556008)(53546011)(26005)(16526019)(186003)(4326008)(52116002)(86362001)(5660300002)(36756003)(956004)(31696002)(2616005)(966005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3094;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsOwwugmMEN+FQayRiQQMdWYgCpe/heFigGBWMQccr6QWH2i+CFmrewCBc02U5t5T6Pt3O4ioExEVWSUE+QWeEcrfmVElXBEQQ3tPq8bE1XZSD/mZf6RXiatJLZE8sPNfHJ2YPPdNya+NXPCMZvOi6PLm2ITPvCiJvCymL/j5jpnFIiItjo1897r38Q6yXFiQ19N3VDx8DpBbz7TlIX2KmvngNBViJ3P2qo1ZadWuOCaHVAwOlNnvpaOMM0Uf+xG0I3ioYGfY75yyHdsX3odtC27Wzu/g5+Qet4dGwPpIJDri0u+pkAhIay2RQYO8c/RKvZa9fAZ4FaS+rOcPmBLJH9b+jfDwxPAPLc6eeRr68dbMDmU93fPOFpi+v90Y226m572KYaO/JUZ7HFXrB7nIxcfW3as2h1nsCjyHzgpd/HjMoKzuzEMsFzEpEuI4SI0liySlGsMEOGyFkoLDchMHfU7UUiXkTA84ihpaQmKVASQKfjWDtfYK5RTnK+OuUsRp3idVltWZ66atBEfA6mW+A==
X-MS-Exchange-AntiSpam-MessageData: gQWIEi1qPMhYbtwtwVZ/gK9pKj8WiAt+ogCbH3W/t6tIcoKNDOmKMq+D2CzPVZWivuAauR7SqsBQu0VxhkR2wUagU+hihpWtYjc/KdF6NQUf7obUXPlxDJMx3siIE9NIP3hPD9EGGKsnFza7z/rNIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f171a0e-9073-4837-a293-08d7a4c2a099
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2020 13:53:32.4146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iD+pd5XYcI1bcU16/9BK4sXyLEFbYr2g4dpSlVU/au6EIIyL6j9jcHwBAMYM6vO5j9YVPgsLahB+ek25hxipQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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

On 2020-01-28 2:47 p.m., Alex Deucher wrote:
> We might get different numbers of clocks from powerplay depending
> on what the OEM has populated.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  | 31 ++++++++++++-------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> index a27d84ca15a5..8ad32a11d363 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> @@ -1446,17 +1446,26 @@ void dcn_bw_update_from_pplib(struct dc *dc)
>   		res = verify_clock_values(&fclks);
>   
>   	if (res) {
> -		ASSERT(fclks.num_levels >= 3);
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 32 * (fclks.data[0].clocks_in_khz / 1000.0) / 1000.0;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = dc->dcn_soc->number_of_channels *
> -				(fclks.data[fclks.num_levels - (fclks.num_levels > 2 ? 3 : 2)].clocks_in_khz / 1000.0)
> -				* ddr4_dram_factor_single_Channel / 1000.0;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = dc->dcn_soc->number_of_channels *
> -				(fclks.data[fclks.num_levels - 2].clocks_in_khz / 1000.0)
> -				* ddr4_dram_factor_single_Channel / 1000.0;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = dc->dcn_soc->number_of_channels *
> -				(fclks.data[fclks.num_levels - 1].clocks_in_khz / 1000.0)
> -				* ddr4_dram_factor_single_Channel / 1000.0;
> +		unsigned vmin0p65_idx = 0;
> +		unsigned vmid0p72_idx = fclks.num_levels -
> +			(fclks.num_levels > 2 ? 3 : (fclks.num_levels > 1 ? 2 : 1));
> +		unsigned vnom0p8_idx = fclks.num_levels - (fclks.num_levels > 1 ? 2 : 1);
> +		unsigned vmax0p9_idx = fclks.num_levels - 1;

Might want an assertion for fclks.num_levels > 0 still, since that's 
what the function is expecting now.

With that change, this is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

> +
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 =
> +			32 * (fclks.data[vmin0p65_idx].clocks_in_khz / 1000.0) / 1000.0;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 =
> +			dc->dcn_soc->number_of_channels *
> +			(fclks.data[vmid0p72_idx].clocks_in_khz / 1000.0)
> +			* ddr4_dram_factor_single_Channel / 1000.0;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 =
> +			dc->dcn_soc->number_of_channels *
> +			(fclks.data[vnom0p8_idx].clocks_in_khz / 1000.0)
> +			* ddr4_dram_factor_single_Channel / 1000.0;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 =
> +			dc->dcn_soc->number_of_channels *
> +			(fclks.data[vmax0p9_idx].clocks_in_khz / 1000.0)
> +			* ddr4_dram_factor_single_Channel / 1000.0;
>   	} else
>   		BREAK_TO_DEBUGGER();
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
