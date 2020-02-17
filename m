Return-Path: <SRS0=Eo1a=4F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E12C7619B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 02:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CBB2072C
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2020 02:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u7LiLKd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CBB2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422876E427;
	Mon, 17 Feb 2020 02:02:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F7E6E427
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2020 02:02:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4ov6FGvw2DkEsAkI80sP4PleBzFYa/Eux4nT31XS6Ji2I4GrVcNVborZNkjLM792BHopJ4hMCRT9l/9Pl3Drx896wvNKlVRQANos+2R6uh7Og1jCOhptjs4L3b0JoPQ/W/PvrjGeJOabnwuUqA7i8NTNKuxnD0I8HUcZwXs1g2lEdOqUNOBNe1aEZ7HRAhQiyqGtg7gmJ1G7mLpMOwxvwJ0XIX9ryBwOQLMahPKmylk2nmzJhQZRzLbm4+B27NnSAea0g3Wf64rny2j8Rk6fMqHlMswRPK7rP9EFUNL4/Qr9qci6YqxJFlhMhbf3XyT3rhB6R3ArWFUonL6zUGjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z346is3GZUX+NKve4GM4klqmayCnQJxvnObJn0LtWk=;
 b=BAv1Anesni9fyJtN3YKdnME1f+3etl77zNF0DcAHtlLTjn7D9VVF5JlHbIcmn9wq9RDCd+YkU77/K94ZZsgmi2l8ytd6tiuFL5B/ecOaCcgq5IID5S4VQiYJeTZBvX7Tg7G56Q8frUteGTDJl1dj1L/YqCQ9pUo8Acgc5XDmDRLjgmhVlBxjdtUl+hyMuz+r/j7+5X8TNs1txRLs4lNSs6FIIW3W0ISjt6bSgLJNinIRhtvgcFzvZjUBUkCxKR3f3OatO3r65cFhDkf4idRGSDgMyd/1S6L3TR3HQX5y/2xhfk+zQzHCbTjUqASIXg5uNVK5gi5d5I1vzsXGefEXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z346is3GZUX+NKve4GM4klqmayCnQJxvnObJn0LtWk=;
 b=u7LiLKd8X08rGrHya8GeSfteLerSAtqBnnAO9aDfoewzX+85PpxNS4F5kIvnzaxIlV4I55sSiC0hEYCBGmkUWxwXZCnCMGExmnaZx6CbQ1C6ZaIw5pnZWeAiKF0H0o+Fr7i4GQNrw7ds0RbRl4upQaWwcBBMIq/6vlkPq9IZlhQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3440.namprd12.prod.outlook.com (20.178.244.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 02:02:38 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.025; Mon, 17 Feb 2020
 02:02:38 +0000
Date: Mon, 17 Feb 2020 10:02:28 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add is_raven_kicker judgement for raven1
Message-ID: <20200217020227.GA2687@jenkins-Celadon-RN>
References: <20200214040358.27771-1-changfeng.zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20200214040358.27771-1-changfeng.zhu@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HKAPR04CA0002.apcprd04.prod.outlook.com (2603:1096:203:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Mon, 17 Feb 2020 02:02:36 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef2ce58a-5b7b-40d8-8c52-08d7b34d7669
X-MS-TrafficTypeDiagnostic: MN2PR12MB3440:|MN2PR12MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB344070E470F2617681D69720EC160@MN2PR12MB3440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(6636002)(26005)(55016002)(2906002)(1076003)(6666004)(9686003)(52116002)(33656002)(66476007)(4326008)(186003)(66946007)(478600001)(16526019)(86362001)(81156014)(81166006)(6496006)(8936002)(8676002)(33716001)(5660300002)(6862004)(316002)(66556008)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3440;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ju9fbs2BYhHFMdGUzjJIfHYiC++xMorNPIjoR9jbfKihSy4zsWyMSxwWf25tKAriesyq18f1/RYzDEGKdhZY3rAhfTcIJonTgcTqCeuPes5hoqGtzoHR7R+c4kmuqhJo1uhC3A84LtK+Rd7/bIAOSpb0CMSNMeGBq/hHG69+VuCiu6urGO6qgqn9VARLeC5kjJMfe3v7zS63ds+X66n9vp9Ak2LPweCiQxrLm1G4BTwyEDSCICn9XBaLkC8fXbxRj8INPjyk5q7wYysS3et4+szBOO6MUtwLvDa7wdu2KWvX5nnes4GJK0dVIxkPRFRmE2GTlE8+z7E83NEb9WdWMHOskRfCUWnPu8EVB5vTOCwESay2TLgAQcQTaul6rXwTBSGyYmA3oDoDclBmg69VfEKcJkzUiwT1Dzcj8fATxfs+SVuk8OlKgao1538f6lms
X-MS-Exchange-AntiSpam-MessageData: wIAdotx3uy41sEczv73JEU9yfOMwczpGv5bok5Bot9uCOylgjdE3gn4/RNrOO72gGTqPkt4PhdNqklPFrk3rVYBERN0mYnUsxDghcYzcMawmtGq6m7kV2jTnQ8M7E4tJY26uBmNjwKu2brC+09UPaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2ce58a-5b7b-40d8-8c52-08d7b34d7669
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 02:02:37.9435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PBLcXzTIcb7GXrIG7QNszTILjuMLALjI1Nw3lZjdcgj0iU4tUtgmdQauwvjK5yin/ByZE6MbvnqAHF5mdOmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3440
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

On Fri, Feb 14, 2020 at 12:03:58PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> The rlc version of raven_kicer_rlc is different from the legacy rlc
> version of raven_rlc. So it needs to add a judgement function for
> raven_kicer_rlc and avoid disable GFXOFF when loading raven_kicer_rlc.
> 
> Change-Id: I00d726cc39eae4ea788c1d5faeb8ce75ec0b884d
> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 4d8b58e9d0ae..9b7ff783e9a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1193,6 +1193,14 @@ static bool gfx_v9_0_should_disable_gfxoff(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +static bool is_raven_kicker(struct amdgpu_device *adev)
> +{
> +	if (adev->pm.fw_version >= 0x41e2b)
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  {
>  	if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
> @@ -1205,9 +1213,8 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  		break;
>  	case CHIP_RAVEN:
>  		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
> -		    ((adev->gfx.rlc_fw_version != 106 &&
> +		    ((!is_raven_kicker(adev) &&
>  		      adev->gfx.rlc_fw_version < 531) ||
> -		     (adev->gfx.rlc_fw_version == 53815) ||
>  		     (adev->gfx.rlc_feature_version < 1) ||
>  		     !adev->gfx.rlc.is_rlc_v2_1))
>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
