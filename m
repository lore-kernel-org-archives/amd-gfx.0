Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41751C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 19:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECE6206F6
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 19:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZV7bt0rC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECE6206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A476D6E202;
	Wed,  1 Apr 2020 19:59:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF1D16E202
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 19:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB5Q2JKpPI6ijYJpiGCGVK9xBbXyj2o9r6c7B2EzdIHaHBwoT5NSa6paEkTCmyC2KfgA/eZSuEHn6+vmYCt4nU/DDVJHL9PnLWLOIfrgswpKX3iRPuARAqbaeg1Y5igG5Q1hKJbjGc/KINXE3tm65+JtPRRQqaxyBU3iYg7nt3Xk7FzHBKH38re4w0DuDvIchdI7SGTY8o9mdguhYV4Z49+CnTmuAfWQ8G2Bcqj3YbmnxNYSsowIlA+NldNK75puXodF73CI8ITk1BukimIBqS0DGfLpsBiMQHr9CJ/0P3HsJA68/OXYiDJkhg6G0dLs7M82SAyWv4XXBcWUtnf+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/Fj84hdZPsKGukg0TVeyePfh/fiGEPbVrtKcqwyI9w=;
 b=gPXMmOY4/cJ3ZT52eXH7t+HF38BaiFDhFTrXg5dtv7ja34EgXAJm90HkCmQBFy+83g4A+ofXxloNVGHvWLLL3tgsWfTyfr1ci0PgpB/NRHIBC02JsKpZnSyP+498TEgGO/IGcoKzaP+4ShDHHUpoQa3TXjQ3r6DtWiXcx3k6b7s6IARfqChr0+4f/m5o+u4HmbBYShDepnyKaMKzXfe9QDx1cFekdnxbJ7I5XIRsuGRV0P2UlQ1BVnsYPWWZrDmKPhFnjHgTwiuSAJBjZfVG1+9kWziUbqJ6qENdTuKcAJ/M41AD4yTjiKY7B30/4zfLWVjRutRUudcSLoV57zawyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/Fj84hdZPsKGukg0TVeyePfh/fiGEPbVrtKcqwyI9w=;
 b=ZV7bt0rCLYY6BY0+zcO40BjzF5MTeXM1owwWL2bKVng6oR4gnMg/AdSWSdO/QHzYwgJ/n7Y/Dc44CLTyFeiIi17uJfcXsqc2+gP7s6hafwRvIjsGnLPiBQxFqASlitK6e6L+MMkxw9cVsxMV3KllnfsR9WJ4smgKi54laqAT9s0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3015.namprd12.prod.outlook.com (2603:10b6:a03:df::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 1 Apr
 2020 19:59:06 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::e8:c007:9a5:da4d%5]) with mapi id 15.20.2835.023; Wed, 1 Apr 2020
 19:59:06 +0000
Subject: Re: [PATCH] drm/amd/display: remove
 mod_hdcp_hdcp2_get_link_encryption_status()
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200401195631.15067-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <bb0449f9-6f4b-8ed0-ca04-f4a0854b39a3@amd.com>
Date: Wed, 1 Apr 2020 15:59:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200401195631.15067-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::30) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 19:59:05 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bb04d02-08ea-4b0b-9e60-08d7d6772252
X-MS-TrafficTypeDiagnostic: BYAPR12MB3015:|BYAPR12MB3015:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30154E11BC8E20EDAAC4BA1BECC90@BYAPR12MB3015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(8936002)(316002)(81156014)(66476007)(53546011)(31686004)(66556008)(31696002)(8676002)(16576012)(81166006)(956004)(26005)(2906002)(36756003)(2616005)(86362001)(66946007)(16526019)(186003)(52116002)(6486002)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+TjPmpTlX9dP8LW46f2PzgPRsMoajrYGU8wJ04KgJeLbAsS6N1BcMc+8mX3cXNXMWPAkWsZZDjxPfUY4Fg75P3Z4NV/PNpbvKizwSDzKTad7ToAPvsNgkfd0cOFuuMAZQxb5myLT7MkhPRsDz85sbpCZE9x6jMzdbYF8SrTUp3M/TEePGDyEkGJYfqtKh8jygSpoqvXeCevDiZrDTRCXkANdvfor26mwkZ4jC88SFsPORO/Yrqky1Ge1ZlI8Eh+KQxIecl6cCKht7Gzy8mQpu6z4/6Cibz5RfU2ilSkdOd5yl/KuQm2abyk/UKOFVdLKLkGiKNuNf8YiCCvRRiblb5/H+KcbMEpkZMgqQO0W9I33LqS3Q2MK8AN68cVdfr8FBaQfEKC2RoXC96F9UXT/GxXjp5DxTdILrWpcLLGXvSrheIlfUS+A/2pqHJLIpog
X-MS-Exchange-AntiSpam-MessageData: xlQL+lMWzAlmJWUjsC/3VZvtMnHNEzQ3pIt9no2PFVrP2VpucKpMgBqdx1hRyGYZtJ6PmDMBZJ5rSDuyzGUqGR5TpsZJhrtxEPdMpbEYPm1IBhqIJyUwme3fDJaqPHXVA6p3EItk99X7prU7GNh+IQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb04d02-08ea-4b0b-9e60-08d7d6772252
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 19:59:06.3075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+yYMH8gA5FHV/BLO33B7tK4fPMF6HqoBgNibLlQ4UDHP42jb2TJcaQvQgu2YNqRsUcHQFt3TS1lvziZ/pqwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3015
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
Cc: harry.wentland@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-04-01 3:56 p.m., Bhawanpreet Lakha wrote:
> It is not being used, so remove it
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Thanks for the follow up!

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  2 --
>   .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 29 -------------------
>   2 files changed, 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> index 5cb4546be0ef..8e8a26dd46fc 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h
> @@ -357,8 +357,6 @@ enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(
>   		struct mod_hdcp *hdcp);
>   enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(
>   		struct mod_hdcp *hdcp);
> -enum mod_hdcp_status mod_hdcp_hdcp2_get_link_encryption_status(struct mod_hdcp *hdcp,
> -							       enum mod_hdcp_encryption_status *encryption_status);
>   
>   /* ddc functions */
>   enum mod_hdcp_status mod_hdcp_read_bksv(struct mod_hdcp *hdcp);
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> index aa147e171557..95a9c8bfbef6 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
> @@ -917,32 +917,3 @@ enum mod_hdcp_status mod_hdcp_hdcp2_validate_stream_ready(struct mod_hdcp *hdcp)
>   	return status;
>   }
>   
> -enum mod_hdcp_status mod_hdcp_hdcp2_get_link_encryption_status(struct mod_hdcp *hdcp,
> -							       enum mod_hdcp_encryption_status *encryption_status)
> -{
> -	struct psp_context *psp = hdcp->config.psp.handle;
> -	struct ta_hdcp_shared_memory *hdcp_cmd;
> -
> -	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.hdcp_shared_buf;
> -
> -	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
> -
> -	hdcp_cmd->in_msg.hdcp2_get_encryption_status.session_handle = hdcp->auth.id;
> -	hdcp_cmd->out_msg.hdcp2_get_encryption_status.protection_level = 0;
> -	hdcp_cmd->cmd_id = TA_HDCP_COMMAND__HDCP2_GET_ENCRYPTION_STATUS;
> -	*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
> -
> -	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
> -
> -	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
> -		return MOD_HDCP_STATUS_FAILURE;
> -
> -	if (hdcp_cmd->out_msg.hdcp2_get_encryption_status.protection_level == 1) {
> -		if (hdcp_cmd->out_msg.hdcp2_get_encryption_status.hdcp2_type == TA_HDCP2_CONTENT_TYPE__TYPE1)
> -			*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE1_ON;
> -		else
> -			*encryption_status = MOD_HDCP_ENCRYPTION_STATUS_HDCP2_TYPE0_ON;
> -	}
> -
> -	return MOD_HDCP_STATUS_SUCCESS;
> -}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
