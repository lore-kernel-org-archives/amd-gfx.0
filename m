Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33D7C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A498921841
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 02:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q7TlPBkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A498921841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3634C6E0EB;
	Fri, 17 Apr 2020 02:46:13 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC506E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 02:46:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz2dewzflqfZTTR82akL518Y77lUo2GrquvzokO2DHb+dQ8UIFYOK+j6GEpJ/JZhDv/zsaWCS0SzFZg5bR+h0oQ1+0zo6lFW1FsdfublSaHzdLHPGr2Cz/yj4vFgJ9zAjEZue8sRZb+0YSHkoxFWPvLsaQnYpEXeasKw+BhrplU2kuF7FzWrViJ+rPVyW2IcUC01Trd8WW56PLrToalHP4CPqVM9uzn4KzE7xqQDDv9NXyzna4F8BOQrUbPZtslHXlV59ofillR/GY1/+oLYmJRb2J49tEL57WeO5Dlk8CqVTGYwiirvnEeIL552LEgSER6DMFazBGxLhgb9yQKC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzWMhh4cwnyO+utCTF70YTr69/hkVIUfZO8zJdxcnik=;
 b=kaIJubbdwBt0OH29Y7O/+vuYsCMZ2vohNcoGOEj9u/ENA9hxPsGLdo82aqDw4pKGT27DsGraoO37L+Ur4gfLsCywYg9Bc5CIlG7tYASppZeYBlNniMx0PZ5vuiHjLg+TsHtpLbj7EYJY8J/2ijwqUZnenyvYjNvt31K7oygOqnmB2spttDjbnmZTqhFEJbuXp7s9eF4J8JVH0zXjy1XkalE/ktu6C1rHiRFp7HNBTF89JrfoVUGt95cHpU53Y1Pc7skYi3ErgQyW2zrx4eqV0wN3AvJfVCdiCKgZfhgHJsDGNDEKfC48fwEoNeiONTGa/my3CWhcu9QNKzc3uEYbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzWMhh4cwnyO+utCTF70YTr69/hkVIUfZO8zJdxcnik=;
 b=q7TlPBkzDkqWLlLrcy6h/hGVZVssKTq2/7MIxafpP7CYO1FOf3NAry9RnaHyk2CLXTcuNUJfW/QEk2MfyEbHCLwT11kiRbwhi1AlFnYM7Zb6RPkyeOYPQnH/yR2N7hgGP08zsSnb4odh07Gu08KCFWOUGi9Uc+u1wpWtwv9ltec=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Fri, 17 Apr
 2020 02:46:10 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 02:46:10 +0000
Date: Fri, 17 Apr 2020 10:46:02 +0800
From: Huang Rui <ray.huang@amd.com>
To: Yuxian Dai <Yuxian.Dai@amd.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Message-ID: <20200417024601.GB25917@jenkins-Celadon-RN>
References: <20200415112031.9950-1-Yuxian.Dai@amd.com>
Content-Disposition: inline
In-Reply-To: <20200415112031.9950-1-Yuxian.Dai@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK0PR03CA0109.apcprd03.prod.outlook.com (2603:1096:203:b0::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 02:46:08 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 620ec939-b113-4528-d361-08d7e2797c36
X-MS-TrafficTypeDiagnostic: MN2PR12MB4189:|MN2PR12MB4189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4189BE9620D019559BD18576ECD90@MN2PR12MB4189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(966005)(66946007)(6666004)(86362001)(52116002)(316002)(6636002)(6496006)(956004)(66556008)(66476007)(478600001)(45080400002)(5660300002)(16526019)(186003)(2906002)(1076003)(33716001)(8676002)(8936002)(6862004)(4326008)(9686003)(81156014)(33656002)(55016002)(26005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjT6OujxhE87c2CcjXZ8ozDWWpubRRk84YyIjKSP8TIVKiQD4gUk1kX92jaWT2o1xaWbL259UP1hk/uOR7JdRUgjNWnDdjcm6cfhvArHvNU4cPcZjnOFLIVgZdb++wjypJ9Sc1e8jo3x1AA6KxEcLOTbmdPJvD7ofBM4ZW/6yNC16f0vjggQ3GRtOFDhm/omEkVGcuCztcu1+48+HauizVAAJ6Lov/3QTKIUzuEqK2B+ZEg6ZhH0JUYVV0NCXpZ2qn4CGu4Le1u4HO/pv5jhXHkuGpJFYejLX3/ILyL4h/dM2sr81CufedYlGDhxKeWAsZEWRzvBwqamtg3JVlaUXA+s2M8ZC8B5YquDR8ZI58bSH9PMcSBD1tnaNd/Uuy8nSgHKqQqAMZngZM8Y4nqoYBHNYyiebxaUN7KtRqVDv5vkoC92SQ2DtSSuAv8BBHX9RBX9aOnw96CfYA7ajV85xF4j0hQWdwsit18LZMDYqoQ=
X-MS-Exchange-AntiSpam-MessageData: TB3FNPVCnOJldJ3l13Pz3YhUstoahzqI1eIiy8TWdHTMKgEizeY82dGyHK0C7Zp54gKLj0w6+A8tsBnIdmYRyWvJvDg8bgMiJCkMg/RdVvRVV5XnlB9m9LOIV5PnF55bK2IEThZqGKZwNmmMj3nOzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620ec939-b113-4528-d361-08d7e2797c36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 02:46:10.1621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: noY631tmMf7s/mYASwi0d5umF+TbsK9xo5Ax8F0Pd6yOs1BGFmc22sL2glxUpMdzLDF8BbHtrk6gRFQNL9p3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
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

On Wed, Apr 15, 2020 at 07:20:31PM +0800, Yuxian Dai wrote:
> we should avoid to show the invalid level value when the
> DPM_LEVELS supported number changed
> 
> Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> Change-Id: Ib66d0cf34a866fa6f0cedd1d5fc642f59236787d

Please add comment in the commit message to explain some asic only have 2
level, and cause the invalid level as 0.

With that fixed, patch is

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index 281b7b6cf1a4..e4e7a352d032 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -296,6 +296,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
>  
>  	for (i = 0; i < count; i++) {
>  		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
> +		if (!value)
> +			continue;
>  		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
>  				cur_value == value ? "*" : "");
>  		if (cur_value == value)
> -- 
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C4858c507c09943274af508d7e12f15a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637225464660212899&amp;sdata=eNcYS0dWUHPpQQXPHD6M5%2BqRI8dj1OC2auB0ZQB9Rgs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
