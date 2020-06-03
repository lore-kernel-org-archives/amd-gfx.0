Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A488C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 18:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77C32068D
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ocjeSH0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77C32068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975FF89D5C;
	Wed,  3 Jun 2020 18:03:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5117189D5C
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 18:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBloTszdKV5WKkoxYKjljYyMISiwWq4F6sO58pRHFzx6WSLJ2l2FJ/LSoeD/B0Tw42HPrTGuLXxMetypy+YtzeceglyqAIEOMai1JemrezsY3yYKc6tr4pss4+XCnolgB1rR4VRBPmeSjCWZoWJGAVjIcDJ3n7D6fZZR9/XIEW0ooCsjCy/gki5a2B2tQ4zNNgAacO8hwFxcqEN3VNY+fnX4pLCl5nUECj+F+ZMoXnn3I/S9yKwN54Zw+BMT2X+UNVqOHayXQImqGAilKYkkgOObgnXj3P3189+kkRVrw6kls8NA/Y5b1EuLh22hUtMy1S9iD0AVsIoVBkWlSZ72OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWBLoLITAFeHljR6UjmC4Uiz7zDmE5AjHHtCqlzjbns=;
 b=B2qw2W0kq6UwoggtNCup6YD9FFbs7BhgxOfnuda9duI89K7zhuYqH2rlYdsX0Gygr2y8ZIYID1pPZztZMV8iNYASkFqxEgh9ETHbKXcN9kkEgIZfee8GbPUIpnrJcYUW2O5JO2r+4XIGi/0RFb9mMarwGxRpKZxWKXwn5bMRcR7KNt1By5YYt9AF2ihyD9dYWTqrama5A72IiTwtjK3tggJF03wtv0TIqF85lvq4x4wxnCaVq+opGEDnGj8bcGeMaJidbbCSEBEVKUap17LUzKig39f/KCpyydyB52HS1ESEKx3sLPxHGVMAOuAjUrfXTBwT8iBDRaLYo4UxqvGLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWBLoLITAFeHljR6UjmC4Uiz7zDmE5AjHHtCqlzjbns=;
 b=ocjeSH0yiYVNeeReBxw85PdYnl2VTJguyeEzT+q2V6sIQ/REwWA4ncP4cD1eJWyzqNJ6TRmRAI+GKjV2IZV7SBCnxzBh8emd9OBGIgFD9wSmFcnnGLpgiXm65O/GsS/CgcMaxpw7J3nU7lkcZfOMaG1ENoeTcPAhTHhghngcRqo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3190.namprd12.prod.outlook.com (2603:10b6:a03:132::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 18:03:06 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 18:03:06 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix build without
 CONFIG_DRM_AMD_DC_DCN3_0
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200603180004.266897-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <30439f36-8079-2b2f-584e-a189d5df1bce@amd.com>
Date: Wed, 3 Jun 2020 14:03:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603180004.266897-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 18:03:05 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9441d57-be02-417d-1378-08d807e85da6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3190:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31909EAFD6AC4B99E65CC85CEC880@BYAPR12MB3190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: da7Zp/dkOPdMcJItRxm6VxTYMAsBLNTErRTio4zzs3DWWC3KEJT74nhjipKXOoKpytv7GuSKK8ZGsZ1eraVdAsyZATFS/UqhCwrO6k7BLYVL8Rvh/sWwu+GxEL/PnueHTYeKlYpZhHTghWEaJGitTgVtF28p6rWKWI/2F0KZBT5T5o9m7WEeWqOg6idm0xcdYUAS0GZxFcw1sx+kU3/R9kMe3p4H4p20SPxKs6r1qCVWDCWfXLGzMrS3HRPbXMBVN7b7wuu0Cw3yigqQnsdsILK6oMjRisflUtDeyOSQEjM/Fnm2bB6oNNkPUkmfmGIkNdyQF2C9KMBWHANtuXdn7uFF29dpMmhlbp5HC6u3H628lfX9z9Im3w4i5qBk2N1w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(66556008)(316002)(66946007)(36756003)(2616005)(478600001)(956004)(6666004)(16576012)(2906002)(6486002)(26005)(53546011)(31696002)(31686004)(66476007)(83380400001)(4326008)(5660300002)(16526019)(8676002)(186003)(86362001)(8936002)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6kFiVRBpoCrN0jOLllTDKMz4zBVEdHqtEa6CWIY5iP0cR9Ec4RGpxhOedE25UGKl3yQl3aSSrhp/E2ej+LVQ61iBRI1zhemcgGFaWkIeBxD+JGYDKO0Yg7d68SvHOh3CY+tZaNEYs1Ffob6lf39vz7hzmBlPgiuX1sgKUK1Go+KF0hehPAVS4HNTWRBTpbjCF2oC5JzEThJ4eCdKYnaNdnhbCXf5sCtMBiayRJyMmI+xKleK772dQ8RxmwMxPaho5aHGizTM1eQifKvSBzbzmU32/wbWtjJjmJpZzdHhIYKNY2WiFikdDNchl1dUVrhBg5RjOsUUvzzsQAzPKjUpBcR/UEMdF1UCUd8IusBqdxGLaAtGFDpddQiN5UAvP+AMLQubPXhDflVUji/H/qzyoFY54HGIY2qj98swkrLx3hnB0D4jVkStKLuIGpUsBh/6WlLDYdzzlK+Rop80iSbramfMuw++3C5CfDLdENXfoUE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9441d57-be02-417d-1378-08d807e85da6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 18:03:06.1205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFChDANnLaY1/DFGi6Mq1EzM18u+zGo+MJYDwuahCa+lZ+Lw2wgG2S6xmP43BjT5VAwEwVRoka+DBjz3UQ6c9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3190
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

On 2020-06-03 2:00 p.m., Alex Deucher wrote:
> Need to guard some new DCN3.0 stuff.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Thanks!

Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> index 43d0b4e53b5d..2972392f9788 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
> @@ -288,13 +288,16 @@ void optc1_program_timing(
>   	if (optc1_is_two_pixels_per_containter(&patched_crtc_timing) || optc1->opp_count == 2)
>   		h_div = H_TIMING_DIV_BY2;
>   
> +#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
>   	if (optc1->tg_mask->OTG_H_TIMING_DIV_MODE != 0) {
>   		if (optc1->opp_count == 4)
>   			h_div = H_TIMING_DIV_BY4;
>   
>   		REG_UPDATE(OTG_H_TIMING_CNTL,
>   		OTG_H_TIMING_DIV_MODE, h_div);
> -	} else {
> +	} else
> +#endif
> +	{
>   		REG_UPDATE(OTG_H_TIMING_CNTL,
>   		OTG_H_TIMING_DIV_BY2, h_div);
>   	}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
