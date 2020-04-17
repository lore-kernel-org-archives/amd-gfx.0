Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616D5C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9CC21D93
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PKkrE4xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9CC21D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC2A6E0EB;
	Fri, 17 Apr 2020 02:29:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770084.outbound.protection.outlook.com [40.107.77.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686766E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 02:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4TTLq1+N6hT8KZbulAplC5sYwjkELavtPuXhTOwZJKzIftU1Tq5wg/SNZwBgxD+1+y5jZjaiJNkpsYb13+MG7eXNGSgk2tPPhelnNs051pn63I1ZGYSjrSOW/RmburzeR+84AvIHX1KtUxLAETdHCuI0hfR/kwlOgTrhIfyhlFras9Um0VWeOCp3EiL8GfdR8USvuh/T+O6LYWUC6Mm/A4GxjDJnO/nWD1I+i5DyTo9Q15eJyA4KX+6QDNNM1yo8uUGunzOHksUIdU7kD/BjkTa1LMk/kGEKR5kcreuYqY9q87VyqfDLaqm2MT2yDTGhClF6CNaG331uD87VV8BAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjqB1H7XJG0CWZjvyTauxsBStuRFP36V8o64zjKfOlQ=;
 b=dnm56tMYsbAQqmwpz/+IryW3NKuEzHxHKVsDHmrP+rbd2eO9rX7osEcmTtVey+Tq4d+D2zEOOsTq2c7kVML9kd+bwVOnIDnb47ly0xDEsIeLeJQXXQ2yJ+iLjUAEwALggjGge/Kqc6LxCL0QuGZJhnxGT3Q3ddgJUJ5rHk7sPcd7LlYRLdV45o1nQ47OHd5m2JXnF2h+XfyYYekulCswj5sLaTFOCoQyx3hHUFJ+fttD0UQ/03mgWUPpxcMqUSpk1y4vHJXQwtukftRkY6q8ap7bhKbf2x9NnLrPUkOdOs/CRWmDQzds0ur4MR0zuPi3TB/DPT6LEaqLk0xjcgzhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjqB1H7XJG0CWZjvyTauxsBStuRFP36V8o64zjKfOlQ=;
 b=PKkrE4xAIlbPjl0vTEVE5HEMoGCto42uP7gIoBIv98v3Mbpm0rVnW2CS/eAaz1NcDQ3CMLjg+DXpoVBI4sQzlgryrPe0fQGdBTZqgJv80mARZasN4esbUOmby02udwGMO0uRonERAQ0hP+o7a55y+Vlbbq05X/qD0lxaS0rjRbQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3838.namprd12.prod.outlook.com (2603:10b6:208:16c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 02:29:50 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 02:29:50 +0000
Date: Fri, 17 Apr 2020 10:29:42 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix resume failed as smu table
 initialize early exit
Message-ID: <20200417022940.GA25917@jenkins-Celadon-RN>
References: <1586965404-31922-1-git-send-email-Prike.Liang@amd.com>
Content-Disposition: inline
In-Reply-To: <1586965404-31922-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR04CA0087.apcprd04.prod.outlook.com (2603:1096:202:15::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 02:29:48 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 202eafe5-cfe9-4928-4e6f-08d7e2773400
X-MS-TrafficTypeDiagnostic: MN2PR12MB3838:|MN2PR12MB3838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3838560506E5D04D35FC74F8ECD90@MN2PR12MB3838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(5660300002)(478600001)(956004)(316002)(2906002)(26005)(6862004)(81156014)(6496006)(8676002)(6636002)(55016002)(8936002)(6666004)(52116002)(54906003)(4326008)(16526019)(186003)(9686003)(1076003)(33716001)(66556008)(66476007)(66946007)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi7t6Gzf9yq+yepL+dawArdyYXEfI/WfW0/iHhjSpFwAqbzHT6uV0l8KnEyynel9uMipQsMxW91iRjscWOwCwHZi0fG40udO25KDbv5jTiDid38wzLFBEGGVWXssB9GETzP9NroHA97AvzrG6fZlPoJuNd9xhpVCGsPLgpqoHEOwhRJYsbOVrWbqJYg3KDAC9dph7f2aHR+by1uluZXcvvWynp6zo9WxPiLWC6cG0dEcjFtxwX/C1PaBPjwVWMqMYTzI8NII6kfJ+xwQPbr03CM7j4xcnf3nLVxw+24pEadYGxHwMTmXsQkgf09GPLK7+QijhXjI462yEpaA4ce4dWzhq2LTCUDfREtNO+YPIV8l4Pvxs12cwdIFJQsew8m0uNRfctWFWBponTDpw57hE1x1E6qTT2fKuhgT7OSWB8TU2QyQSU9PQo/vjc703jN+
X-MS-Exchange-AntiSpam-MessageData: CxatFNxgfZOG8SZEAuTEVc7RmpXZfeqXleJ51ttpZGURlK+oJSd9Aiw/KdnLjnThtam/3ubnYso2++s057SddoThgWLkEj3Ok2qJZOvEXuJDqfsG2TpkKgaFlPtdgzCbwXKmUWTpK1O6+uv9L0oYeQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202eafe5-cfe9-4928-4e6f-08d7e2773400
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 02:29:50.0164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvNDmSjdIOxmwYCdFWc2TcUKArbXYkOnx1VJb/hSDUGycU35VQLI9wuyRluyUezd6X4c5CRaIDgfOH2jAjwKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 15, 2020 at 11:43:24PM +0800, Liang, Prike wrote:
> When the amdgpu in the suspend/resume loop need notify the dpm disabled,
> otherwise the smu table will be uninitialize and result in resume failed.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 95eb445..7ddaea8 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -895,12 +895,17 @@ static int renoir_read_sensor(struct smu_context *smu,
>  
>  static bool renoir_is_dpm_running(struct smu_context *smu)
>  {
> +	struct amdgpu_device *adev = smu->adev;
> +
>  	/*
>  	 * Until now, the pmfw hasn't exported the interface of SMU
>  	 * feature mask to APU SKU so just force on all the feature
>  	 * at early initial stage.
>  	 */
> -	return true;
> +	if (adev->in_suspend)
> +		return false;
> +	else
> +		return true;
>  
>  }
>  
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
