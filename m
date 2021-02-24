Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3561CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 06:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10F0601FD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 06:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10F0601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE466E2C8;
	Wed, 24 Feb 2021 06:27:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEFF6E2C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 06:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXiqOWGbIsuHpW4zte6zD5yCzkpI9pVLTBeQTcEQ7CyH5XmbnhD9hJPnw58lERsKsRd7geFxfayEh8q0iGOeEvAjlr1yETYqKteJ9P4CguI4Q8UPpsQDTH5M+pUqXw8gqCgDiE2IX1Hb4QNVvwXnemhjnoD93/0nUaXG5L/39DY2A6uEWVupWEKFobeiE7iZjM9s+Jghmo2CkPuLEferkPOAbHEXMa9QUzDhijQar0POKSQpC6+Qp+xqCHRthH82EnP8UzH7GqFGJTyojOO8hgAls94OG0B1bUA6eiVdc0Q5SIC81OvNJSqlU7CpuITFF6eC/D245nWKFMYNcDH0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPhPSnrmVptI8A0oP+OmrcODrj2Pz2GZNaUKO60Kgcw=;
 b=cqPaKnkqxMoPZtgE7NzHQlnHt/1i2zPoYA532+b04j2IBYy0K8+pkHOWivKh6mWX/QLwgeEctnbJiVl64FKRXmnVz2jXr4vOgHWYLKNai6y3XjWdvaQyoVS9EdEbq6114Lxys9djbL//5ypHxXTNixJoSWzvc7uecb7I66UylchSrixRwe0P6oSi3SlPyZQEfD0SJj8JaDaYcdJh6KrcZ9GnxGMz1+72EYlHQ4VlroW/8patMA++iJVF7zYRlPeYVNlnLihyik8L7rLsWUDbUauHV5lZIIhO7LmMGnhgaNy7eSVSe6+35uUqTLW88VG2YtJnNBvb4VnITuMhah1x6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPhPSnrmVptI8A0oP+OmrcODrj2Pz2GZNaUKO60Kgcw=;
 b=4Q6Gui8yzumOBcXrWOsHl1yEz9CbcILT3fx2dwuPP2THhckJ8xsv0XSECS2Zo4oFwJyOn8/RnsdFKDi9+OYYjn7HOcrmjoilNpgDbmB0hVLF2Ru4WVgQ6rvaKo0DoSPs/1YT1ynhyy/BAe24+wy/7fGMYsYoOWVrrh8JeEXW9u0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0237.namprd12.prod.outlook.com (2603:10b6:301:56::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 06:27:34 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 06:27:34 +0000
Date: Wed, 24 Feb 2021 14:27:25 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh
Message-ID: <20210224062725.GA587137@hr-amd>
References: <20210224053319.29985-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210224053319.29985-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HKAPR04CA0004.apcprd04.prod.outlook.com (2603:1096:203:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 06:27:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2733c1a-723f-4972-023d-08d8d88d4573
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB023779C01E561275EB01DC6BEC9F9@MWHPR1201MB0237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zh1KDDg9/mjdSKPiqxSalAajs0OqIkO1dZ8Ptjlw6rVMqy9GiOnQDMw5N13MFCfRWWV2XUVI4PZUYJP7/UWmaLWUigv94E4D3AYmIKbj+a9lLMn1k2dUjTLxuEI68Ptc/hU7gjDoCExtA02osG59H1hE6Y/bRGZ2nBsX4BD69pG3Bwy5wE5bthNWXLpW/N/hm9spktMDF7/O9SsHRkbKm5Kadax2x129a6ibnbiwRNqfGhJXdF7OmLyE2PU3pAQm4Sk+wQKHbQvza1S5hVqK1plcYZmyASpZCk2e7Z8VNpKLdoJiRibTbVf7P/FkYJirVkbR2fvONdDM+1S9phU7U8ZZojYRVSCnO4dEKUCrzsrv2FT+9Mjpxk/8lWW4pZ3KQd4lbiKNhDQhjD87XaNxICJ3Ju/+aBLz2lSh0kUSG3OcEPqCWPWC9ws0Sp3f1cRSXN3APQF1KVoLOH0CX0XIRKW4KGji3ztKHJOx94BnLrSbfcjk3LE8dta6MVpsAxp3xnFKvBpdtdLLsWs++fr8WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(6666004)(66476007)(4744005)(6496006)(86362001)(5660300002)(478600001)(16526019)(26005)(9686003)(8936002)(52116002)(6862004)(6636002)(2906002)(1076003)(33716001)(956004)(186003)(66556008)(55016002)(66946007)(8676002)(4326008)(33656002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Cn0VAo7VruzqqpAKXyplDQCzIoEAm2E1q8UKvgHFvoTs58869p0gipgYEmt4?=
 =?us-ascii?Q?MLgiv4xhFVuSmpneop9vojFCrqYHkS4s7yXYZRvBd4fE45RkkGHN7MDEHSE2?=
 =?us-ascii?Q?DMhpnay0yjrGD8m+rvlq9ofA7e1G9h32vardmz7CeLlabh2YRTlkL5sdTx1+?=
 =?us-ascii?Q?Cw4fyyLKpFDYMzZ7AyLYAymeQKMsUymptS7QXDlJpF73Gei/0FJ8+eJRIhwp?=
 =?us-ascii?Q?aAnc+d6I5dzTEt4mOVi3zt84cdFx1uWErOEEZuVt7PPEv0AFR+HyWdBBl+RX?=
 =?us-ascii?Q?1FWRHbb0Z56kvZnFSB5YeHwm3fRVvyFX2Gi8j2SPPMB4UtD7iEr/hbhJ4jlB?=
 =?us-ascii?Q?jjnjYO4oJ7FZmyiv+E2zX+wZx6tyv1zZZcy+RMsVaFV2jV5En13tRoNICc4x?=
 =?us-ascii?Q?ZTgbjmIs/O9fbiK6i2sdMim0DfDq/2MQn+jltL6vzVqWmk0wNtkOW/le6V2p?=
 =?us-ascii?Q?vGhgmnXvPW7rIgeIesVapf2OXu6m0e/GuYRchpmOKlqCcJfZXe8uJdPett3C?=
 =?us-ascii?Q?ul6cG/20v7UE+6xkG91Ce0lee6e+InVEkqAWdsTM1rihn/T5LtX/UxS4XgpZ?=
 =?us-ascii?Q?Dt0K0IG6Kgshf+1zbj/q6HdHed5NiBkgNeWKOIJcNUc98dEbs7qFr9jb+uVe?=
 =?us-ascii?Q?PobNpzNpzp39Afrf0FjfbT3Er124TsTJXUjVYkrVWoHyDREbP7BXXsc8K1K6?=
 =?us-ascii?Q?i0u6KaA7sW6p1/CLA4zRsiMjStnzAK/GGcAEJOKK10S/4wOdLmwspsC7Zdb0?=
 =?us-ascii?Q?SaoFw8QAPbs/B5GOrjY03QuxOSONIdOPneORp0Q8hw6fqkbm8ptRz/U0HI5O?=
 =?us-ascii?Q?pbOsKi+C81ngRdDLw0jC99Oo0+MCMBNiLREwi06/jQ6CdHo6QkpSlN9Vd2+r?=
 =?us-ascii?Q?UXqpBJU9xgU+WpoWqbmzjFpM0OSKbjlikEkhfqQtYIPvpTLHc9ZQ5nQG8c84?=
 =?us-ascii?Q?GaEShZfY0xR0Aouxoll8iwtnCaYgefh/RvFJWJnYVzZw2+Yt4sVTSkWcs+4k?=
 =?us-ascii?Q?SONyBgcHdKbFPAIRQEgBLL3qi+WmFhExeozb52uN5vNx5c/ED2/NRaulNs2R?=
 =?us-ascii?Q?bnUwBYrrhkEfGe9TkqYqBUa71ST8yysJq/lWClVin8smuoooAjxGcTwh6LGj?=
 =?us-ascii?Q?1wCqD4HhnP0W8iOjakzQWCQO0VwA0V0zKeEqoDUwJ3qKILH8X5T2d+jl53uB?=
 =?us-ascii?Q?snrIOGme0nYoxoid4P8pUOpmuCom5I4rdM6EmZpwy/DS/lUoTQppW18P1Wn7?=
 =?us-ascii?Q?s1ji7iMQ9gg8aVnPKtXere7R6spgYURXa+kjGbW3OFey+Cacce0jBa+OMGIf?=
 =?us-ascii?Q?oYW3Vv6fblJxQZHWnbUwHdkH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2733c1a-723f-4972-023d-08d8d88d4573
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 06:27:34.4226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wo3NbicvVfcrJPsRwlr5K90qhy6zqdn23B1tEa4/MWb426WBDLfoRM+vXiAPevuctnx80Xzv3JlK6+YBeC43aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 24, 2021 at 01:33:19PM +0800, Su, Jinzhou (Joe) wrote:
> Add AMD_CG_SUPPORT_SDMA_MGCG for Vangogh
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 160fa5f59805..393a0d5905ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1003,6 +1003,7 @@ static int nv_common_early_init(void *handle)
>  			AMD_CG_SUPPORT_MC_LS |
>  			AMD_CG_SUPPORT_GFX_FGCG |
>  			AMD_CG_SUPPORT_VCN_MGCG |
> +			AMD_CG_SUPPORT_SDMA_MGCG |
>  			AMD_CG_SUPPORT_JPEG_MGCG;
>  		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
>  			AMD_PG_SUPPORT_VCN |
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
