Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25540C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C767461159
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 10:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C767461159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 550506EA82;
	Thu,  8 Apr 2021 10:50:09 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31F06EA82
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 10:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLVD5oNnB5knHIYC8kYbXNw6wc9Db6Cf6b9Aw4KCSdp5IVqYKFYeWtbo1xjzA8nivDwvfZzBrj2GZU8EPu1xtb/YqSriOyMzOXyLErbXzA+bk6uTKpAqgh2FDJfPDZwitF36IxgO7MTUmXCtRQ/iHQe0ur3wNUrmTs92BA5I4V620TDFhqbgUJ5fxYS+YFHxOivtJYeL+ZCw31AdS5djSa8ActAY0xzgeBXWacorXDEOawdsdJGuwJ03+8mMMFZ1qIyFLezEHg4pG4LIHp+0YxRmzYpWVOb+UodkxAyB6aeZfBAK1PhOXIPmpE4XOajxxycoigkBEr9d+T8FRc3ddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta9gsgbDZlz2Ao+YfxXPVmo1MlQCqQ6tRumdKFZZ3pk=;
 b=ockocRG8rlAqa3lkVjISksthx2uGYhARpNm0xWgb044oL/KvlbiZyTVLkNk5xNbI41tNKuGHxhbZbeJVBIAua9TaLCguT87qpqrRwjRPHgyLUUqO1DIoeOYFBgOTdw5WUNqs9aQJobPCADo2IxguvQAtQ6xBkHTik1kGBd8ihwqS0Rg9UM0z/Gauj1H5pvUOgXO4IWE5xeOO+v/zgSwEDfVunNIRIAOytrlO9YKdDResCCq2e4H1tLO90W7GoOOAz/5dPhlFwfLQ/+10dielE2pXKsnK4wL1ehFreTlc6Zblp+5R2e94QNy3e/3g+JSZVXOWUJA90dWOkrtTKQO1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta9gsgbDZlz2Ao+YfxXPVmo1MlQCqQ6tRumdKFZZ3pk=;
 b=N7/uLCzKuogG4Jwiw0ZzBzEftY0W4ix+yuZSRxS7Arcq2OCsJ7uitx4+fOKnfAcCuSYVg6G7ib3XBMCohctoTGca54p2tr1nYDHNWB5W+r+JuW7y1mwptwM3j0uV7lliMEL+LCV66lhkMQSjmHIF0/RmZPrG33LmWKgH7Qz7MP0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1439.namprd12.prod.outlook.com (2603:10b6:300:12::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 10:50:05 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 10:50:05 +0000
Date: Thu, 8 Apr 2021 18:49:58 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amd/pm: add the callback to get vbios bootup values
 for vangogh
Message-ID: <20210408104958.GB3753086@hr-amd>
References: <20210407082551.3773040-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210407082551.3773040-1-Xiaojian.Du@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR04CA0070.apcprd04.prod.outlook.com (2603:1096:202:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:50:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6494b61c-8c4d-458e-aaca-08d8fa7c1180
X-MS-TrafficTypeDiagnostic: MWHPR12MB1439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1439ADC3416CB798882DDD6EEC749@MWHPR12MB1439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqY7OyFvMskzEA3AdZrpro6mw882IGm58TcI6ROIGwFmXHnvuXyTURqCvkHQRka31vdxJjZdrRT0swt/tmOF3/LrzrSX9dAbHgP8l/qozEus4Tg9a83fIMCjohIu+iG6V00cSg5t0ZmZ2oHDn7RG/uePopc7S8Cr7MZ1ZcIPKidBxPR+j75FRUIZn5T5/0HXD9kzJRIMVYqWOqdhKFKpmg9NbgdjpWD487b7CRw4flNRo+hh2Sb3nUgITOHlJyjdrn24lL1uTzinihAlxyAlDuobu0CdWSe9TJ1U/viAszwQU7MlFHApZS098jnaAQCgWtNA//VJ2MnYfSa/9tBKbc7Cq9DnayJizxWBnPWmcXVe7aFBGDlrgUEkiXBTsRS0L/QzREJIetLuFPhyM7ZXtx6G5DavfmIeIwsfxJ/YHmKl0HgILz7jQQggwpsVbpK7WjhE6lE0vHUTls3rne8ZsOPhnxt/tO1GUnSOOhaiOACuxDAOHWgm11TkpGcFEl54k9FTbrG+zeGDH2hHNpchDBlRua0Mlgl1fKz3w+iInS+78QrbhA8efhSmJuAdmKtZlATTlunb3QcQFeEBCd8BlPJF9VSquJs141pbl4chjxZBU8MeVwViJEnbHWvd7PdvyXUCrzVrNxJve0hCZ2QdGb2HibveJiin/BqtNVljoJ8uuZCMWha3qHQtfSGzpjUG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(6496006)(54906003)(38350700001)(2906002)(38100700001)(52116002)(4326008)(6862004)(83380400001)(66556008)(66476007)(956004)(1076003)(55016002)(66946007)(6666004)(316002)(478600001)(5660300002)(33656002)(186003)(16526019)(9686003)(6636002)(8676002)(26005)(86362001)(8936002)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?majTaHCTRjJ4GcaFsIURt4MQIjTiy0spIBbJTFzsURmnJqbhNBbEu3XIGjYU?=
 =?us-ascii?Q?RoFBLDolWD9Kcy4z1XUuBlpGMh8s/1VEjcsO2OJRrwaamzHzoDNQUg4wtgef?=
 =?us-ascii?Q?bNbaqajg3kOFTXPqK8Gm3ah7NLwEvERsX8ioL0OjnmU7zAuYo13WCMKrhgLV?=
 =?us-ascii?Q?v7Gx1+cn5zef7Y82SrW8rL0EI6wi7y6XRBg6Ne5SMk/H4pirzIjvYLdquxbn?=
 =?us-ascii?Q?dm+7KsGbdNdmsg+QRwSRbhJ1WgFnquvm8pTjJ3wqY1NBEcJbqONcpBNg6qqn?=
 =?us-ascii?Q?XFYJyQlJfJUfOymecYMyEGo3JmWmSRM9WShxe6TIZ24QgrzZW+8wAS3+It6z?=
 =?us-ascii?Q?qJ8St2eJLyrAmpyOALDFaKtBxEW4urLIFAbA6s5ND+oKokclTka7iXnvtXBZ?=
 =?us-ascii?Q?QhwsxTEKQJEfjqhHSnep7CyO0bC57wHG5Im/fUaUoL8ugtjqHTvBTSRl/WQ9?=
 =?us-ascii?Q?FuDk+uVpYyzAJIK1pwdNAdhq5vVgmIgq/rczIckD2JqzwB5/SXmURLhYIz8s?=
 =?us-ascii?Q?I/6x7T3pGYG87VoOu8uBZzLkpcp1hpdQSphIVGl2CLTP8jTykfyZ7hc4FDUq?=
 =?us-ascii?Q?xYKvZIdk8nwa6p5ITZ9qnt8kJdC728JA+8xMHRvzKk/y1YmcO9PxB5yIgYn7?=
 =?us-ascii?Q?E1KzYT+4mzMy76sles5RIA9uPxnVgossaUZB86lZzca/4Ee+adwu+Ex3lyxt?=
 =?us-ascii?Q?EJFZPbHQ04X2ugv15dO4AsuFs0CEhIx5jrihJpG2ShhApY4odv/I8fppfDji?=
 =?us-ascii?Q?tUbIvCqNOcFq0NAYaidJANow7nedZs/srMU4XMY0TRdTS2W+8xQlpX0bPtVU?=
 =?us-ascii?Q?9o2gmXfhE2SeSBgJrL2fOzjpueyZv3jYV5CagyizLhnJWh+9W+BXktgl2Exp?=
 =?us-ascii?Q?rCqPuIAMWaWHYQjSLq6w3vb4GvFKy8DudfklSHA72I2rGIF32vwh87ouMBWU?=
 =?us-ascii?Q?COIXAmWq4lQkCrpcx3DAIVg+mXCZdsooEYPpb5J0Xo8a+2rPKTPypt+mfVTU?=
 =?us-ascii?Q?0Ccjpp9DavcBnTK+Hp4PTDWCh7ZKtWNRV+/bWSTjxT6N6Ept6BvN3WIMYyIy?=
 =?us-ascii?Q?Dn6d1098imub5mM/Bp9SHjUeMu+AiAfi3xj0WuXbGUrdb6dhgBwUj0yOqKWj?=
 =?us-ascii?Q?kRcXvRbUATJFvIW/MpXTmoiUnmRcOE0YjhE6WplV4jdUX9DrjGFfC+JqPJuE?=
 =?us-ascii?Q?Be90Yiic24GixG7SEFi5Gy8OZQ6kEjAUY79k7MEyUOECdDw1/2z6QRSOPk3s?=
 =?us-ascii?Q?MsOp3W6nEO4ldqq/U0WPxCi7eW2wm58j0jI6y7p1dp5XVjghJwfcZT2UWonJ?=
 =?us-ascii?Q?KOjezts2J7iGm4P8AN+DoYBq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6494b61c-8c4d-458e-aaca-08d8fa7c1180
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:50:05.3966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzWT48SllLmgv/gOd6sXuk2cw4qJXnZX7t6qnAjx1JQenk4tzs6SPnvjoC69OEvmzUH6S1VW+sJFM9clPwGurQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1439
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 07, 2021 at 04:25:51PM +0800, Du, Xiaojian wrote:
> This patch is to add the callback to get vbios bootup values for
> vangogh, it will get the bootup values of gfxclk, mclk, socclk and so
> on.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c   | 1 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0d137af1a78a..6274cae4a065 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -561,6 +561,7 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
>  		smu->smu_table.boot_values.firmware_caps = v_3_1->firmware_capability;
>  		break;
>  	case 3:
> +	case 4:
>  	default:
>  		v_3_3 = (struct atom_firmware_info_v3_3 *)header;
>  		smu->smu_table.boot_values.revision = v_3_3->firmware_revision;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 5aea67637bd8..7bcd35840bf2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1894,6 +1894,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>  	.get_ppt_limit = vangogh_get_ppt_limit,
>  	.get_power_limit = vangogh_get_power_limit,
>  	.set_power_limit = vangogh_set_power_limit,
> +	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
>  };
>  
>  void vangogh_set_ppt_funcs(struct smu_context *smu)
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
