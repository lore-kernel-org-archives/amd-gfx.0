Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A4FC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 18:48:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452C720732
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 18:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NiwKSJBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452C720732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD996EABE;
	Wed, 16 Sep 2020 18:48:16 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B656EABE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 18:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2kvrKF615iKEZHfes5VzYnGkIM8sWOotkf4787uYMI2Bc308OdN5MfRyace9ry7Z7IE0gIu0xuIy7KKoAnEQ7v+n85O31Zlv/6/0YqO11PPubZgkyKGw0YbIBq7+PTUP4Oh1VhnutoVvrW8cvg16ArBnFJY03/ShASMtwWLiD4JH3fmQ0QpMJ5vETaiwwQLZw/WZhyAymGoJb5tvlnHk2pNwP9ePvEPsuNqkK27Co1EdmJpg0MDvmzrs4WL31CiK2hEmmk/bcnqycwlGl3k5yBurF/znE4H3xdyltvfiU5E8PlMARq6xl4HTs9z6rH7hoSL1GQYgZ551JiwLW1tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvGAgb99lX39+W0VM6DwjYSj6dCz5Gr44abbmPDGjqY=;
 b=FKEacdXoZvZAo3UAyhvBsFo9M2o5Go727DJMxQ1NX7bkCJqVX/yhFYcIKIUIDFWbFBfDEPzHcqY62ibW1AH+WdpZY99URQ68fBndzeea53Sb1UTqWGB3e5zqHMgunH0P9PKazKMPtgUNRTchOE5VgtccXLcfV7N1qvEAOZVAwvrfz2KV+GrVO9aJd9jfWIhGJcnyeST08Q6lKCrtKAU/oLoYzWXl0brWC7Dxo1lEVKxs0Zj54OU3sBo/lODZM3nJm460sINiLw1BoW9cXTZ5JuLRVZv12Ns/6HtG0hm45lqEc3J3SvNi32HSg1pF+hlSl2VBHyFG8/FQMg7a9pWv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvGAgb99lX39+W0VM6DwjYSj6dCz5Gr44abbmPDGjqY=;
 b=NiwKSJBaoKM/aYC57B4BMJ0VMcATFCPfu5PjdJf7Z1sUMw8xgHwWV1MxBUHYXz+koFf/4K9gcgmrxDtqbDr/Xjnqbm5hOamOPpfntoJNw1JmSj0Axhx1yEfHKuxNp0eNDXl2Ss2uDzDpc1I0l7UDBSEbq0sn65+TM1AH1a5kQRk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) by
 DM6PR12MB4713.namprd12.prod.outlook.com (2603:10b6:5:7d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.18; Wed, 16 Sep 2020 18:48:12 +0000
Received: from DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::1557:8815:3eaf:267b]) by DM6PR12MB3561.namprd12.prod.outlook.com
 ([fe80::1557:8815:3eaf:267b%2]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 18:48:12 +0000
Subject: Re: [PATCH] drm/amd/display: Add missing "Copy GSL groups when
 committing a new context"
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
References: <20200916170851.2509294-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <8ef98a87-14f8-9d7f-a82e-4d65dea029dc@amd.com>
Date: Wed, 16 Sep 2020 14:48:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200916170851.2509294-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To DM6PR12MB3561.namprd12.prod.outlook.com
 (2603:10b6:5:3e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:48:11 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c810da0-09ba-4de5-9cc5-08d85a710ff6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4713D5406CE3AD759CC04344EC210@DM6PR12MB4713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsqPZKSzAB95VygdlNgXYC2nErdJBOQLvaKJ2FQ8tjfPtM9WKBAXbaqwZ6JJcmDorIf+sZCZk6qraLxfbO6a1AtZ6PMNZck6eeDjN6mWRIX57mPx8iD9gRucd30yDjslT4POIgjf9Vn3rB0ko6UwzgOlvDRE4zre3YxIYhd8LWxys8UHoBG1auauq9sIKbOEJw8SU47EmAdyznyGv8o5nQ2SjuOvK7YGr+nM4SMWUpxmtagP9CWu0F5DX/BuP8xz1kud8llUQe8szStkNY3uX6N/nA5Ys6XU/WCnWCV1BM2qSkGkZiAZ4YLEhbyPYPRoQO3aWrP1ULS8xFwJYzZ0BeiyAfHKTzWZENiJYC1RDeLqd2Kfzshtz1k/+icwGzt2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39850400004)(396003)(186003)(53546011)(8936002)(4326008)(6486002)(52116002)(478600001)(6636002)(31686004)(5660300002)(2906002)(36756003)(26005)(16576012)(6862004)(16526019)(8676002)(66946007)(66556008)(956004)(31696002)(83380400001)(37006003)(316002)(66476007)(86362001)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Di1uQzJq3vsawiJ4br2pS6EURKkciTYyJD9eMvW6N8toe7QnHsxr+raR76yu1JPnOrwvYSIXFhQoahpvzUbDu1ZVWE3tMlsOic7/9NRs6YfJQorsK8+xTqoahcs08W9iCS2MRrZ6W+6wec41TbVU49X7Vt+FYhIW4P1d4KCHU3rwMGCDKHZ2TNjgkvyzuz3eG1ik5A5FpWFDk8rA72DaoOZFtwo+LusKPnIQTZsOabqoaoxPaJigLareuOjINNhTguuNWgpStwToyrTzoQIaeak30cN8t4wUUWMYbJMcrCci9PjlcmbM+W4FPArwsfm+h6vwlDzzIswKgjEx/BiawNPDicb3kg1ZfCPZOgxTTpzibQqPeo31Cv5SciX0QMwIcg28tsuuhoWgqVj0dLX/DyJs5AXMSiTt4pPk2bffpSthrzqj0CsyXCcqcaaThaJEifa/ckVwASVXbDVopRy0ajDvsobIw7Q0h3n25yy+AvCHDHGQk7R0PJ8UubdDgprWFa1SXiAF9m47Gw9/KYPPx0zFvCfy7ySu1K84kSyLp2yPBU2799c+4RN8UATkdGScuohuF2cski6Pp7QJcEjsZcZUo8pwWpEJpfkL+UaBNGREFm5xjxeVzbI5tQR6tjElmtiYnJuO63AyinBQxDBS6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c810da0-09ba-4de5-9cc5-08d85a710ff6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:48:12.5555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEVdKvBftxTyE2TB//OrdeZ87E//4zTLXGd+6FJBIdMqehVIOfA57N5DlAt0WkoFxbhpwxdsgGsRPrPnC5iIAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4713
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
Cc: alexander.deucher@amd.com, Aurabindo.Pillai@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-16 1:08 p.m., Bhawanpreet Lakha wrote:
> [Why]
> "Copy GSL groups when committing a new context" patch was accidentally
> removed during a refactor
> 
> Patch: 21ffcc94d5b ("drm/amd/display: Copy GSL groups when committing a new context")
> 
> [How]
> Re add it
> 
> Fixes: b6e881c9474 ("drm/amd/display: update navi to use new surface programming behaviour")
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 5720b6e5d321..01530e686f43 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -1642,6 +1642,17 @@ void dcn20_program_front_end_for_ctx(
>   	struct dce_hwseq *hws = dc->hwseq;
>   	DC_LOGGER_INIT(dc->ctx->logger);
>   
> +	/* Carry over GSL groups in case the context is changing. */
> +       for (i = 0; i < dc->res_pool->pipe_count; i++) {
> +               struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
> +               struct pipe_ctx *old_pipe_ctx =
> +                       &dc->current_state->res_ctx.pipe_ctx[i];
> +
> +               if (pipe_ctx->stream == old_pipe_ctx->stream)
> +                       pipe_ctx->stream_res.gsl_group =
> +                               old_pipe_ctx->stream_res.gsl_group;
> +       }
> +
>   	if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
>   		for (i = 0; i < dc->res_pool->pipe_count; i++) {
>   			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
