Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4753C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D35E20661
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 02:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WQqHoGhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D35E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BAE089DD5;
	Mon, 13 Jan 2020 02:57:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DA589DD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 02:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHB2D835ObNA5Badh6m2XlhsDp5D1vsYwz2jHJM0Zu+ki0kD1L0KH73Zy6BDl7pFREK9V288t8tpknB70do1ewENpAouYR0CJV0XbFSnbKnWR9gsho+vccY9Wi2+ZqfyuHpbhBlOO7mjGnVXr9JQ5Ky+LN6TP3PQfEnE0KW+gydNX0VrD6Dz2fuNEL5RVzgaCQP4mNGrOpjrh7KMzEUV3L+SFshkcUGgqt2qD0KLXZ5hhV+jQzWSiDGu8Q6M6slBw1BzMcir3lQbo8oay9FA5KTFUU8YA/OZvIzga53m1VSmKV/vDnHryNMuNY1/uPs6zosrVRss0lB3p2r60cXNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTNKSc1IQL6NYILdtNbyvpdlzvUfSMpAnCEhJJniUHE=;
 b=HJNP7tbJQI5irNeie7n5Yq9GDk6rUHvJQEheyW9lHGL/QNFxGwTChnRNDxMNVEMJSPICImo22Jp4aaGt9vPM2ZlNCpqgfWiPGFPnXTMlfyt3JQpLDzUliNVKN9kdy7i7LdE8LnPH19smi+ME0x23hNpqiK703nhBjMJWeHhZI+Tv318KNU6xLQ47rRh/NBzgOHCyz4VggfoHoa/3GVQhLA3G3APG3VlRPE9t0bY3jG3IuHi3FIcLixvzGrNXiy1ZzJCN/1qwggJPXbBYJ0xvmx4yKzWqRaJlMN/aDmCkRzAiqcY74i1i5Zr8dd2PGqxVbs2A3s7PyFL4uyJXCMq6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTNKSc1IQL6NYILdtNbyvpdlzvUfSMpAnCEhJJniUHE=;
 b=WQqHoGhR4BMVjNNFW2zTOuF33yhrxrVuGV0P3/vXFiCinp/H/U98r2VM+lE+Tgq5BB9DdwSw2kMO3mT+HzOws77BFG0FRbSMteKCuYDBmDuNm1huehYVkJ46CZmhidKLq+SvuEvi29BkFI8dD59vFd+G8Czo8ijb1vRtnwZswhY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4109.namprd12.prod.outlook.com (52.135.50.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Mon, 13 Jan 2020 02:57:41 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 02:57:41 +0000
Date: Mon, 13 Jan 2020 10:57:32 +0800
From: Huang Rui <ray.huang@amd.com>
To: Yong Zhao <Yong.Zhao@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Add a message when SW scheduler is used
Message-ID: <20200113025731.GB14889@jenkins-Celadon-RN>
References: <20200110192429.5146-1-Yong.Zhao@amd.com>
Content-Disposition: inline
In-Reply-To: <20200110192429.5146-1-Yong.Zhao@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SG3P274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::13)
 To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 SG3P274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Mon, 13 Jan 2020 02:57:40 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8529e41-8472-47cf-cee7-08d797d45b03
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:|MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB410998E2A895FC9E15E9FF91EC350@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6862004)(1076003)(66476007)(5660300002)(66556008)(6666004)(316002)(55016002)(8936002)(66946007)(2906002)(9686003)(6636002)(956004)(26005)(33656002)(52116002)(6496006)(45080400002)(33716001)(186003)(4326008)(16526019)(81156014)(8676002)(81166006)(86362001)(15650500001)(478600001)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4109;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhdibpCqnNcGHplVI9STXuVgsB7Jba00enhRFmkd/g+pKiri1rsmBXWO9P6VYYgx1MvWPqkKQTlvGEGwAhgfya5tpKX9CWpLiEdawNeeMjZG3HgPG1bjJLl4FwwhrYYKHzfRR877scr6hg6A4okC8hVsnejMU1YFzW9+3sN3O3VdkJlqR5Unw+bHnk95DPb2GedTM0w3DwsbWYI9qiW7AQEK/h+rSv3Z3zwKWRNJJCM/4SKmz3A+Sb4cz+gPnUMcZvS1lSdUS8E443dPeQhKEg+QEbb9sBOIsnwuhEOY9hMFSruEMGQfkY1PRE0ZBeJ4ns094Lphj2GQNuLXDTUGN3I/eGfMJPI2dKLeVqinrOc9vhGAArfTlMfrlFpDQ77M0wxVHGTpD+oNuV8Z6PeR+GBSx8Hq6D0S8PIzxyyaSYXNuTsMWgIsMyulO326v+MVj3qLHVaHfPJyy6uIvUJkltuFLc7Kq+tpI5BUJ8FFRkg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8529e41-8472-47cf-cee7-08d797d45b03
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 02:57:41.3610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4kw8rqolfzXStx/H1KxW9PPxmboANd55nTv+WYbunL7L5V3N+YBEj4oo0C/qmyfKaA7fyOOVg8EUQvjk1b+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 10, 2020 at 02:24:29PM -0500, Yong Zhao wrote:
> SW scheduler is previously called non HW scheduler, or non HWS. This
> message is useful when triaging issues from dmesg.
> 
> Change-Id: I625518c88c043df5f60409d1ca520e7fc032251f
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index d7eb6ac37f62..2870553a2ce0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -934,6 +934,7 @@ static void uninitialize(struct device_queue_manager *dqm)
>  
>  static int start_nocpsch(struct device_queue_manager *dqm)
>  {
> +	pr_info("SW scheduler is used");
>  	init_interrupts(dqm);
>  	
>  	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
> -- 
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C6b815ca66a604cf8bdc808d79602bf9c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637142810865612294&amp;sdata=smKBx880vj61EOJ3iHXQdSCb3upww6EyHKjD3xfWdX4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
