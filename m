Return-Path: <SRS0=m9pB=DM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F07C4363A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 18:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C9620853
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2020 18:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rzBOj/uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C9620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D169E8997C;
	Mon,  5 Oct 2020 18:12:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770047.outbound.protection.outlook.com [40.107.77.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCA38997C
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2020 18:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNRd3wG+mgdiTMyNPgCfb82U2YnJ4CvzjS0XNWn7TbXqTN8O5tda/czCCHIWm7WVrmrkzKuYtjs4fM1iCbjVrmgPG9Fz6tgGnQ5767Z7oaimnfLi1Ncotd+dYYQV4Lc6dX0FieaeorU/4epPV/6kYfjYTuDAtKIluNeCMhGam6/ymtqfalTcIs3UT+N3YSdVWu8jWEpcRnywxqyYgvDiG40HoqO4r8VPP1iBxgvsEDn8dtNzGednPXZFRdU/BLm0FEQfRuTvA8GtyTX+E9LgKcVe3ZIgl20dAryY1rEVt4mo6MT+dYJtQIFYqNl1cWnjX+30b7nXxeFKjcq7jZlB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv+PXh5Ose5izRSwiKyiRGWCr1T1ag3vguV39Zu/604=;
 b=JyWBLvql7yqZ1kcF4XwaFCcnmfSXd+eT52+3B68n0FG4UTuvEt1GFL8z2Av0SdUeD1Ktp61v/qWuK5RY5TXOPTw+qWNJYnAg8H4kXg5lWFTVmclYQqx1FQ2Qdnj/mBj3Rt4CTJmDP9VYsC4dD6i38wCYC8mxXPywTBHtHkE3TCji/8eo1GwliDIV3zNtFiQ4vHSgCBkPPsaLDVkvDan0oneFMh3NyZXzkhWKllFKAgD8E1NmaqP852V7wcdOy4eXJvQtKzpo+OJxbG7tnbUeGlprTiV9FFpOYzpzmlIHnVJw1BqNOiWyoI+FOMelheaWpBDr6Af8b6R49IQv2XBadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv+PXh5Ose5izRSwiKyiRGWCr1T1ag3vguV39Zu/604=;
 b=rzBOj/uT6tGHBASH9Yc3lX4Edy3ymloywKxjaEjIr7hPjObDpmpkwf5JZBRUKRZ8Kn+VH165uU7F1ePqoEziUtvhzkBZVrQTmze1Qcw5SdXNXQmSsYoN80KkR2u7f9ZPtLiN5ZkTlu2CZazVXTC+3pPNkhDINGMcMlsqwZKttXs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 18:12:55 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::1c93:f4cb:a03a:f568]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::1c93:f4cb:a03a:f568%3]) with mapi id 15.20.3433.039; Mon, 5 Oct 2020
 18:12:54 +0000
Subject: Re: [PATCH] drm/amd/display: Add missing function pointers for dcn3
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20201005181033.1267385-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <c47bbd8b-0c93-3ee9-ca3a-cb7f7fcfd2c2@amd.com>
Date: Mon, 5 Oct 2020 14:12:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201005181033.1267385-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::43) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36 via Frontend Transport; Mon, 5 Oct 2020 18:12:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e362df02-d579-44ce-13b1-08d8695a47c3
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB39714C201AD2639754A6911EEC0C0@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JNXz6TkYU5fZ1IixmVWtGADnSoaZwtOirE4vjXrEDIn7yB9G9Kg/Gb0rHPX76MnEv/f49cx6eHcRYvFwPdv+1t1K+0X01e3GDTAPm9LehfA4l5HIY+3aNhpGI9z2c5eQw64B1fu7YwUL6A/p8DlI/042sl5pz5owNQY9NmduDZE/3Y+UzalHeo6rvvoUtuCQQKiuH1kzYZAgtbKi8meJDYgCxsYqTLNTEq+ayCtqAZJYKR8on9qR7kEOk2x3HF5Mzu6nYLzMrULG0Cykf7hJ2vPrboUkwH+7TaD59nTQvitcrLUyoOykUrymyYadcBI2+Q0ALdiqtXFKT65Q8wzgF2g2vOLXMlBlqVxWb4FeyIXa06ctECNeuJPanINP4Ry
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(186003)(478600001)(31696002)(16526019)(26005)(53546011)(31686004)(66946007)(66556008)(2616005)(66476007)(6636002)(956004)(4326008)(16576012)(36756003)(316002)(5660300002)(6486002)(86362001)(2906002)(8676002)(52116002)(83380400001)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sbZZuCjBrl5L9JalPhg+jRbM0YD80GxymGzTRXGSmS0xV5YV+rYnW7tUIABOQxec9ovRZMMtRi/OoD/2GHfNnPEtbh++bQXdBveD00TmgvjuUwSXwUJ1OMmE1uoxUT5mzpVlyqiwi1qA5VntgPuQ/8/SlzlbIhdrHZqWz3My3ijA5ZJrY3Lo6nmovSYAdC3IoKzkePvy0SpsMfYRs7wvT5W6YUeFkats2iyQhtF8Flc7BQKWz8nfBbYeMHhD9MrrNYmHEjfDQRlsPCGImUEKQRhQgXO/NyZHLfI7eWNYofrnythL+yZCzNVWQAWYB7Uz2RBkXLDKPbntqYr/v1Pi5zSIYthKMV0IJtBGRsNbGYHtbEDS4EznQyH/K03Lt16UkKgPETDNqjnBoJDAJRux/Bygsrg8kESaWPmn0m6UsJIS4Nvs2nwaXoA2Qy55PyrGPqaIbw4v8zmL7nTvgQ01+IWu6JyNWIMpIqJZHNGdu/ofExpo8rWUq6XU25Pmhir04rzlSSE0eWv8dQgXJ37eXqPDfSOnTwyOhSjC0q4+vJy4RSb77cLNBQe4Zz4XBgbMTptDSnrW9/gv6L8qCBNjwb3dcgDPFn+nP9yXlJZniTEg/2tdLYboD4KAJZcDL2qAA4+0BiODbX1kqnSPfS2KxQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e362df02-d579-44ce-13b1-08d8695a47c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 18:12:54.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dhqWNsK/IMf6O4PaZ4fQjO39YKZtv4gimSB1U9fKJLuiTSs9nUhi02eJwPYE4DNdWO/4m5Q4ton3IJCfpDuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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
Cc: rodrigo.siqOFueira@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-05 2:10 p.m., Bhawanpreet Lakha wrote:
> These function pointers are missing from dcn30_init
> 
> .calc_vupdate_position
> .set_pipe
> 
> So add them
> 
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Would be good to mention what these are used for specifically though.

The calc_vupdate_position in particular is used to help avoid cursor 
stuttering.

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> index 7c90c2222506..dc312d4172af 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> @@ -90,9 +90,11 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>   	.init_vm_ctx = dcn20_init_vm_ctx,
>   	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
>   	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
> +	.calc_vupdate_position = dcn10_calc_vupdate_position,
>   	.apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
>   	.set_backlight_level = dcn21_set_backlight_level,
>   	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
> +	.set_pipe = dcn21_set_pipe,
>   };
>   
>   static const struct hwseq_private_funcs dcn30_private_funcs = {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
