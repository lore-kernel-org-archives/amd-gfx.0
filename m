Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C8FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0FF64E36
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0FF64E36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFCD6E4B6;
	Mon,  1 Feb 2021 09:03:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3366E4B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 09:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leC0IztcXpKkTmxLyV5O6T7mxM7AFBxTKSZbTxcyM3gUEpVZ6v5LLahUs72HQBcB8+MBQxzsjb/qB0sggBsTRiBHEgfyaEtfRGNp0XcIEQTzZ14GgpNs3/zSQhvLxw+sghSk5ithox8KFApepIDVWRxp+0MGilYsB6ozCXz0bLsf/6aX9c2/XhXfz4BPXtRBVALc+Q/nmXSFVZGTRzWXKufTR9p7RFwqjnmFtdI/qSN4CSD1ctI5DMi1So79MSLMVdAIeiLZve+z3E2qLmT4Y1Cv3cjlPqB/MMF86swqgM1VvFCDZaXj2J3EWgJsJvN/O36O0NbLS/uVCbqEdSUthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqm4XFiobakccX8KhGjMjklcP90A6jZ7qJ43iZp02VY=;
 b=ls7vbofHr4PebwU7yJb0ZG8UZHMSRbsDyydRI5OkNxCSSMZCVMIx2pguwqYUXlKYsirEHOJvzc17DVijrh4lM8WkfH3gB8IqmFm0kd8HmBHXxH8jnSZdTB7b2am+ijAnJdK445H7vaWWWzbPinSTQat4PnUGl7+/GETTSfuctin1VyC6igXqMgaUv2StZMFlID/+hy2sqY2C4SNsBCqiBfj+A/LGeSgIZRkP15LuIh1guyfZ9H+UGLYuHKvZxFTZsjWnKdTUmVlNepdZtBPsLnHElfhqJy8PWaxEb1/BsnFm07NAglBt725IiQs4G0zOCoDHfVAebboWOg5Mu5qPCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqm4XFiobakccX8KhGjMjklcP90A6jZ7qJ43iZp02VY=;
 b=yzZK+g19dkNpE+fjuOWUBK88exA5IuqwuWQgc/nieY1TeYY1klT+QSefayyXniEQRsvBKkhCwU+eWGGQ/HPj5cR4kFlFQFfyfjlGUP+MmpyfedbJ1S9hleHnr4f0QkqQLFsTGkb5512GECSkRCQdf6GaTLVdG+gDcgFtQ2nu3aY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 09:03:56 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 09:03:56 +0000
Date: Mon, 1 Feb 2021 17:03:47 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amd/pm: remove some useless code for vangogh
Message-ID: <20210201090347.GC3140926@hr-amd>
References: <20210201084558.21708-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210201084558.21708-1-Xiaojian.Du@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HKAPR04CA0016.apcprd04.prod.outlook.com (2603:1096:203:d0::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 09:03:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6df603d9-2cc3-4f8d-95b1-08d8c6904def
X-MS-TrafficTypeDiagnostic: MW3PR12MB4377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4377101DE25F3F91000E4A0FECB69@MW3PR12MB4377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKX5WeW8w6QQ/ywP2y8qw4nMKXmCHu9YUnDrFfSYFzoyV4c2j9Kmb+ezpOG6cNA1kfoZlFwZHkJT18IZr+ZMyG4lLUyugf2Mi40/F3w+A4N7WbVUahx/hhF32jXB0rRY9Yez37977mUm/HMYUYJxpQ6+gtxn+OCYhq7coxvsVxHO/yHmFWCNrtdaFLll8SLOi9tHOb4odq3cvuECq8p8hGIxjqJaSR4afm6FBoX0LYHK4KuEIxv4AuIkrS2mxxTwuo7svkMHfrxV4MPLYdD+SdNZVLnjqWB6P3Zz7TLqEkNZ/jQF5yop9gBXcas5Z3wFQTF7v4ZJW55aV8ueryus/NZthU/kkMlgjL4/ifSiwBtJIk4Bd0HDSxBquvdDzk90N8KTV77o4kYN+fHQc3nUgQd91cRTPZgiAF2UH/KPmm29UXZEXSlq1/Z4lnFsMzMLpPy/kWs14nmphN/cbvkjIbcVoq/hZMH4iDuEc6wjq2bEQHqCu2loF8z8dH7r9ZztT+i/tS6UuC+EQ/7lt/v0LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(478600001)(6636002)(956004)(26005)(16526019)(186003)(33656002)(8936002)(4326008)(6862004)(9686003)(4744005)(33716001)(52116002)(6496006)(66556008)(66476007)(66946007)(8676002)(2906002)(55016002)(83380400001)(86362001)(1076003)(54906003)(5660300002)(6666004)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?buIdH120DVVTErsPRpLzfpDcQv84tmcsCA7cSetK+tHle1c4Mh24jbULzv5q?=
 =?us-ascii?Q?X3+e2jgTCrwKLlW1a0aH8XADhtWcfsVYY7+nDty/x+4nwmWvDwALNbTgzOXn?=
 =?us-ascii?Q?d43tRs1bKc3x67YaCM4K2+PYnxsMZOrA90lWJgcNBovK2ZFRhDsPfLSV30cN?=
 =?us-ascii?Q?dydNHOWyaKO9gpqYHGBYd8FWxIHh5haQC4cSByAlgWoZjpv3tLzlh5s70zFB?=
 =?us-ascii?Q?XvtH4epa6uRQrsW5O5SkM/omCujtK4EMHW6tY2wxVqP8NBuwCcwEBu1TmFH+?=
 =?us-ascii?Q?WMY97hyT+AVvi44uxT6Z7xgv7kLAdk9InC1ZyMODibPQjanluo0RxgyBe1Kd?=
 =?us-ascii?Q?673e7QIT9PQChhBe+uMqcHV2vMeuN0y+RH+5lcr7LfjYCOj9vnZcsb8dNRf6?=
 =?us-ascii?Q?3/HO71HjPkIvUcYNbX67HaXPLRqIOQGrcd7QAMSe8PVJHiX+mpBo7DU63xOC?=
 =?us-ascii?Q?fXpctZHOuNID4cypPXsZWYEfRrAH5l7FbC4CsGfhbq9hPDG1F75Q7bZ5RVaY?=
 =?us-ascii?Q?KajAu+WuEIN2wC5eh1Dm0qNRoXVCgflu9UVWBWHzpMATSfl4MtcAjkJte2HO?=
 =?us-ascii?Q?7iZkdvfQZPV0xxBYguJDiYLO/IbFBSZSUhY1ayMbp8MQvNaY4Oml/gQhfndY?=
 =?us-ascii?Q?zpg5EgalZx6Gq2px0Qb8Ile1QY+oF8uX1r+ZVH5oTZZJ9r6S2SBBrCCdMxgT?=
 =?us-ascii?Q?xNrMMnm9+4I90TI/RZCYb4j5hIJotQN0UpvekxaZbfG5s61MMhBjY34Uxx0L?=
 =?us-ascii?Q?DiLws6/tooZJ2wl2830PsOh/HwkvZngme6BBadRVYV7FoEtPuH+aVkSEYtMN?=
 =?us-ascii?Q?dvjlTyOnQx/kwbnFUt+qxDa2gJ9l9B9j/tlIoX8RBCtOuozSV3eO5NpltlZy?=
 =?us-ascii?Q?GUibsE8IwkNGBrPOCg4skBGtx/zuvjuIe7HATF+F0r36b0BPx6DgvFh7LdMI?=
 =?us-ascii?Q?SwT7uu+H6n3990wHDrV0dF7Z6c2nUCGpwDzD1/FY7Wjw7BDkW451dH3WHj3i?=
 =?us-ascii?Q?3Bn0QiQr3wanoyGRPQJwjD40PVZXEQzWqdConDPT9gePMGBIHZuz+vVoVrNS?=
 =?us-ascii?Q?WYbsXpAqJstXgxp/9Z+ROy+pximd9g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df603d9-2cc3-4f8d-95b1-08d8c6904def
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 09:03:56.0821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lju9r6dAdsmqSSD3RziDRR/ZDQ0I/WXGNXp7iL8R/tEKzrHGnYNxS2Ir374XG7cDBQAT1IGDCuiFQP67FR8jTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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

On Mon, Feb 01, 2021 at 04:45:58PM +0800, Du, Xiaojian wrote:
> This patch is to remove some useless code for vangogh.
> In the earlier code, vangogh can't finish all the sequence of
> smu late init. But now vangogh has one stable work state,so
> remove the useless code.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f958b02f9317..30e2a0ac3279 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -612,9 +612,6 @@ static int smu_late_init(void *handle)
>  		return ret;
>  	}
>  
> -	if (adev->asic_type == CHIP_VANGOGH)
> -		return 0;
> -
>  	ret = smu_set_default_od_settings(smu);
>  	if (ret) {
>  		dev_err(adev->dev, "Failed to setup default OD settings!\n");
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
