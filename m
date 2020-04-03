Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD982C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 06:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEBC2073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 06:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cKvM+Ljf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEBC2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4985E6EAF2;
	Fri,  3 Apr 2020 06:29:53 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BBE6EAF2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 06:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlYPyiMM9jX7N1vJH+tMNprSvk4GuYXv/4xKZ7QBt0ZKQPQ0ckfFb5lqr+HYnJyG/lsbtFk3T3Y7t768l3h1O9WrKP7tFLJ+TyI/WwNoaHwBrX5snVZ3PUAPXVM9MDuG5H5fzf3+8pBkMUCbRD40VzJA2Wq5N41Z7f0Wi/Xp0Fq3lD7l4Mtn6z7v6wEp0s9k8h34QuTS/SouFUXaqWEbhQ/hPLnDQgTzCduc06ZjlBOiSqw++Jqm2vu0ZKVdL47jhpQVi2e4dpGzM5FRXNWRITx8zKuNbFOxMgij8nmDULpqs/ieWfOW01yVwTgVY5UR8vQ4EFQQHcflqs7IMmJjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wSxppPbjiqhv5zk8B36vuU3xCeSdXZwO18Ujp94eCE=;
 b=PzjkraMBWDW5tFbz2fJq/dwgl1vPSepIclGyZxNxbXlWY7Cc5DHuwR/ZsIlXrwR5wWCLEnV0VOlH7vab9cUcThkbWVDkVCfgLGMqSr2ANDj15Tj4zdDhRs9T95STGrNKltIBqy7nrjuboSuBC9uczi88wnBn9c28+wI8oSe78P20jbqRt7kgu5Qfw6ySfWqxc6nVL1sFIW2jIsXUhl9OS6CloRx4SZKnEXRSgXR/IiV3xBC7Nfhy7LhNOUuiLGNwGlL4MLmWki9t7ct/oh5A3NOof8Jl5zu1nIIXWfcBIBeGKYN8nWUrScyHOyMwPtXblUEqNIRYtutIV5Wt58ueIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wSxppPbjiqhv5zk8B36vuU3xCeSdXZwO18Ujp94eCE=;
 b=cKvM+LjfmyIHCmGFeE8uezfEUkzYCJBqlYWXHbb/LXAVDbDlBDNlCr92cms06faZyzus1YRFyCOkuBAEF1o79nDksRTVwpZmnvw1FW31xNoj401E9HvsTefsTIj8flbO51AyEN/0eqpBOtqlFepzcDPigaieoM70UPkZOnsYGhg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17; Fri, 3 Apr
 2020 06:29:50 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 06:29:50 +0000
Date: Fri, 3 Apr 2020 14:29:41 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay: implement the is_dpm_running()
Message-ID: <20200403062940.GB9191@jenkins-Celadon-RN>
References: <1585893812-25475-1-git-send-email-Prike.Liang@amd.com>
Content-Disposition: inline
In-Reply-To: <1585893812-25475-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0016.apcprd06.prod.outlook.com (2603:1096:202:2e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 06:29:48 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3578ae6-da06-4593-4903-08d7d798696b
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:|MN2PR12MB2974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2974E532D1F3C7ADC96742ABECC70@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(6636002)(81166006)(8676002)(316002)(66476007)(66946007)(81156014)(33716001)(16526019)(186003)(6666004)(5660300002)(4326008)(956004)(26005)(54906003)(9686003)(478600001)(55016002)(86362001)(1076003)(6862004)(2906002)(8936002)(6496006)(66556008)(33656002)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tf2wrb/pPgS4LLi/1nnefKORcbgjG48v9tvNS5kMWnCWD3T1xw5a2RbmgWB6ClcbtkF+sKYevHGKHcQphFKa5P+CquW94Dr6aKhU+V9nMQVC52uq1RpCDUpl0Andah5JV08Sjl3w6AR+pgUUVBIahjnVOMSp6rfFOsL8pQb5TRY+WmiPACIzJ0sA/Rfyb9AMryWH/l2kMnIyNav48KDYUHU50oAM8cn218xM3mMFXMNR/Avdv1+bw/2fRYegaE6p+l0UnkoGKv3PhorYWpcxPuJtBTwXsQWRU8IWcDhNXaz4hCALEz/fWOqfwe8Jj0Vq84P3g02M9U4unNg+XPmJQj/3S9GPeD7Zg806/S9byc5RlvF7qPWZsHef+lqrKIjKTlxyLzPsYB9p3W2N7noIzPa23mDWGgCx2XRmoSDlblXESvRucPeVLBYpZ7ooCMB
X-MS-Exchange-AntiSpam-MessageData: 0ayoI+1AdOJPbiU9P6xgAaWbIUQvzTQvFT82lju/HJU9MSSZev/h7HkgIzdh4YSk/FvMq084MWLjwxlOgOijOH8vkb8YfOY8JMELD72Y3ttsoZT+5rXbfV3jDN0yk5To4Io3ThxiIdzuu3Rnsm7TZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3578ae6-da06-4593-4903-08d7d798696b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 06:29:50.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiRJFcnHrbX2QdLzP/qJWmDkY3ar5x57r837Qqy+5Mk6gV1pk0D04WEMD73thy+5jE3opTtG59syDvKqdmKu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 03, 2020 at 02:03:32PM +0800, Liang, Prike wrote:
> As the pmfw hasn't exported the interface of SMU feature
> mask to APU SKU so just force on all the features to driver
> inquired interface at early initial stage.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index c6b39a7..ff73a73 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -893,6 +893,17 @@ static int renoir_read_sensor(struct smu_context *smu,
>  	return ret;
>  }
>  
> +static bool renoir_is_dpm_running(struct smu_context *smu)
> +{
> +	/*
> +	 * Util now, the pmfw hasn't exported the interface of SMU
> +	 * feature mask to APU SKU so just force on all the feature
> +	 * at early initial stage.
> +	 */
> +	return true;
> +
> +}
> +
>  static const struct pptable_funcs renoir_ppt_funcs = {
>  	.get_smu_msg_index = renoir_get_smu_msg_index,
>  	.get_smu_clk_index = renoir_get_smu_clk_index,
> @@ -933,6 +944,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>  	.mode2_reset = smu_v12_0_mode2_reset,
>  	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
>  	.set_driver_table_location = smu_v12_0_set_driver_table_location,
> +	.is_dpm_running = renoir_is_dpm_running,
>  };
>  
>  void renoir_set_ppt_funcs(struct smu_context *smu)
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
