Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C2C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 05:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA0922202
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 05:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3a8ml3Ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA0922202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA946E312;
	Fri, 17 Apr 2020 05:48:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B156E312
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 05:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib1D1Di+R67fZiUFEnAL9qfnjWSopvOya51/tYMs3JLYHFjSwGG9eks4o29RbNCOybuzq1KZ1yfnGNBUdoin2uQ6wnb+pdamjJ5GxzihGYMHSFX6UwTMye8ElCRHgaBOJovsYKmUFFQoB6+KYubduQSzvF/W+31DqmUcNweTyRu/5Lb1SHpqzxDOtiep7nFmx2bm0gOP0NKPDuba2nbCAqMcQpRXvSe9bPuW+DWmOHhltL5VSIweKjQ0pHyUGtQJpJjp9fCONMiUioP+Hgt8VuIGUr5vNL6uZzmF8Rm+5Fa+Jj785amkMQqr0wfdLl4i+KLIoBedMP9x9+0Ew9OTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aei1v8CCkPplvcWG+GdG0JwztcoVdx6GLwgum1DQlws=;
 b=WoeaVwIg/Fzrci77TaUfNfSM69MV1L0Cr2m1REyQZa0FR0FxSaE21UEJNfaeL4ac6+T47nxfnld6ewgVVs4VaNBM818Ze9kabxIS2StUploi5cfBcDrBe2AwjdM6SFaOzUTWktg2bPervZ0rAdHVUZ3DkqSRwFhi5BQvihmg7DEtAqGFwnGrCB1igtc1dVA8V8O5FCSDwEBRxFDA+71cT+Jj9n8l9bv4/mOgrVYUnt+aL09uy9JdWyZajgunn+AcIMDO3ugTgnslrLXwG0ZyyiivTh1WqzX2dvrr+zzGNJIg/wHLUk1agdkGzCboIeilhGgyesn+mmmfK1ew1S17/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aei1v8CCkPplvcWG+GdG0JwztcoVdx6GLwgum1DQlws=;
 b=3a8ml3OkB0e5qgUqYmMFeP9C5x6Is7gfBveMDC2KFO+fny8B50NliNHlif1Cy1ZJq0rYQ/kom6eat6ktp2VKNZPgyJu33D0Kqw9CugxP/oH7Vqqz8rZXgoUpKv9r4bvtEBuDGZaEDHRw+9petrfqLbOyjsXKiSaVkkZznUnV2Gw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3007.namprd12.prod.outlook.com (2603:10b6:208:d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.23; Fri, 17 Apr
 2020 05:48:07 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 05:48:07 +0000
Date: Fri, 17 Apr 2020 13:47:59 +0800
From: Huang Rui <ray.huang@amd.com>
To: Yuxian Dai <Yuxian.Dai@amd.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Message-ID: <20200417054757.GC25917@jenkins-Celadon-RN>
References: <20200417025859.17577-1-Yuxian.Dai@amd.com>
Content-Disposition: inline
In-Reply-To: <20200417025859.17577-1-Yuxian.Dai@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 05:48:06 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5574a05-8e9e-430c-2809-08d7e292e78c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3007:|MN2PR12MB3007:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3007B3233618AA35D41F9C98ECD90@MN2PR12MB3007.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(478600001)(6636002)(2906002)(45080400002)(6666004)(4326008)(26005)(956004)(966005)(6496006)(55016002)(86362001)(66946007)(81156014)(1076003)(5660300002)(9686003)(316002)(33656002)(52116002)(8936002)(186003)(16526019)(33716001)(66556008)(66476007)(8676002)(6862004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZUQQuWASj9LbmuhriHQPk57/Bl2VQYE+/fyyETfpAIg+U7C6TlsDJ28NZLHzWDgmlB431k6aSaksQkoYMn5AH3qOnEjMVzOdF8Zr88DsYGtG05qbz6IHxdwQfVwJVSrOvl1bpqW981oAcNuJK5q2CSbdHN2lnEB70B7iIHp3Lt6xUp6+zP+gk2bjVjRJEsDH9yl/iVbLtKnxSWxlXUQSaHngY51ycx5UAhfh2kGudtFyE6FXCul9SBkry0wwi+N9gL47gEaLRDxxqKT38QgUXZKS6F5TFunkjQ5q8qyOKz0mX9OXVejdEqhLkgrgnw0ihspPq3dpVxWlg6Ot6qxbtJn/kxPU4iFHqOUMtGAXLsBbzICZnbilw5WIQ3HPvfb10N5DEIXHVnfPl+iUHa6SgMZZ4ujxYiZnUmE7u/G+bt4BHyBB9xF7T2kQIccK+NCsi9SXI2Rl77vnWhAa4XeNlg2dJCKai7AHACphBblhBs=
X-MS-Exchange-AntiSpam-MessageData: 9Pq+tEOUZITgAdkEpJLsgFqcgtXZVT9GH9bkw9OsuSImHYfR2WT7gNM8QfN3W2bhqtQe5S1Fqi/GzRJQTI1tMXcfdwgsuA5MT/hQ5G+FAetXyZITMMZ81tGQ2FjCalY23Y18Q8wfHQIwwxNugC8rvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5574a05-8e9e-430c-2809-08d7e292e78c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 05:48:07.5918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uY6RGSh27qgGu5p9jXgupPPkVnmc75po6zQ+MyEvTTj8rX/d2vFTxeUDoGInUuH0ssB42dgBk9qFptU0J4UvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3007
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

On Fri, Apr 17, 2020 at 10:58:59AM +0800, Yuxian Dai wrote:
> for different ASIC support different the number of DPM levels,
> we should avoid to show the invalid level value.
> v1 -> v2:
> 	follow the suggestion,clarifiy the description for this
> change
> Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
> Change-Id: I579ef417ddc8acb4a6cf15c60094743a72d9b050

Reviewed-by: Huang Rui <ray.huang@amd.com>

git format-patch --subject-prefix="PATCH v2" HEAD~

It's to indicate v2 patch in the subject.

Thanks,
Ray

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
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C1b5650c171874272ba8208d7e27b538d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637226891622403483&amp;sdata=kUI7EzW5SgOyfDN57C1tZtFngwmXWTK5sNCAwJqmC3k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
