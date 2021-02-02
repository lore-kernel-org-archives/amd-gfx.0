Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07EBC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 12:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F1664E4D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 12:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F1664E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C6E6E108;
	Tue,  2 Feb 2021 12:15:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308E06E108
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 12:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i33fjiJrrWN0OEba+zE4wiEtjyVeH6ktPo2Utdhjv5ywzGvAKiLFcbStjGasLMLXLrGo+jcJJ+uZQvbimR43KEOQDeIyl7PW3q/egN5w0DNVrXrNFEJnQzs3Yv/oNcKtEdGVofTB8AE6zwWtFXdAinSrPoZWh3/6NBU4ufFO6l9eTUmCkjMZqzfD2Ny3J6C9wzmtFB0dYYzDma8E6qulArR9l5b4FrmyYivUaw/TuLW9bcD6X7ACO4FpcTvQgUoZxI2Z7Fr9PCY5TfFv2n7DxN+x2ODrmna9LnnlFc0VzEF36XUOGDT6c2saJkgi5Jz8fQ3d98Zv4VJiaROJX52PbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpTDEfvVu0Ctq5nnN3eFuNPVJ2drNX9gp6LvKn9xyhY=;
 b=GITx9Ihh3GGXFRWxADyHuvGUFCmL5v31GPVdSWgxlO1GwWez/hIIY3pSFBm+jZKQ2W60zW04UT59KR44k1NjGAYG30e9R+Sp/vgRKTjMcrLkMzgxywsG0rlSR5Rzez9N6Q1ROqwjgIRvJdpDgnD0mYvZ0ufRVcPGTonsTaqxSdP+L3MWfaLMjRLD06jfJOzXcHv18TdZpyBo3XimlOE8h0K3g+UOWxEqExT9wG7EJ5BSfWaP49YPC8VI8/b4BzkiyK1epiaVlrDvoqzmNf1tM6hy50e4U7/O3penGtIY+xkVX9vIVCfbMyed0lbKugj3JvP4X+S+b9OcIypxLnrvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpTDEfvVu0Ctq5nnN3eFuNPVJ2drNX9gp6LvKn9xyhY=;
 b=RXTxtNKLO4Gn1PlAG/qGm7RK33aROW28SGOVgmrhSlhYbku9jn+wWaXZSZDN7IKU5cUpQEO/wvA/T2I1T0e9jUAYVHUcmqdA9943/XcEOT1jkIWxQeFj4RaGw07O46uOCy68wXYn/J9Y4tTCU2vdn67z0lu0y3SFIfPB3UWlEWg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1247.namprd12.prod.outlook.com (2603:10b6:300:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 12:15:23 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 12:15:23 +0000
Date: Tue, 2 Feb 2021 20:15:14 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Disable GFXOFF when GFX DPM or PG disabled
Message-ID: <20210202121514.GA3225682@hr-amd>
References: <20210202120443.2685-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210202120443.2685-1-Jinzhou.Su@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17 via Frontend Transport; Tue, 2 Feb 2021 12:15:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee0f7669-b575-48ee-eefe-08d8c7743769
X-MS-TrafficTypeDiagnostic: MWHPR12MB1247:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12473A5ED63FCC0A56F8D6B9ECB59@MWHPR12MB1247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6T5DGl7uba0nGyzHwCfVGD/0alTBhx6BjrexxICVkLe1wV/Q8DyM+ZPpd9phfHyZbvnVQ+gofwzDOZJjw1FeyHksbRpsTDY9TbhkhW5kkRmA0Iwb1oTwVCq5rlPVZLwNHk2lUPEJHV54Hr7Ynz1aF5aDqiTylNPXSf7OeE3V9rvGp+URMtHDd8gkUSQDuVjiwP2wJQMsSjzufEBodPddcmxQOHaIZQrf5FTi4mz1LgnOcapt4Jcy5B6BqspoTwoLQECFpyzTLRTGfLiTONQVCVFodpNuGuKONNkSvZo/hJjx8RJaETk7W202nnv1DYUvRBaqda+Wr6wyjg+qxzZwvQSNhKGt6oAVe/EvGYvbkfNROlSrFFb2l+9uZHJbbda45n3qjsm4uPxdWUjNR7X0GdGUR2btJvibn9fQONSI7mnslMalMZ+DoTzPx/VeUIDDhc3ufJJbhxFWhNObnhNYdM2qzAyi8BmpUEWp8/aOGbwwNMpdD+1gp7VCOsaj9LnGugAZIdwnl0vb0E4TwJirLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(86362001)(33716001)(33656002)(478600001)(316002)(1076003)(4326008)(8936002)(83380400001)(5660300002)(6496006)(55016002)(6636002)(6666004)(52116002)(956004)(66476007)(66556008)(9686003)(66946007)(8676002)(2906002)(6862004)(26005)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LQzdq+KnYhxcQtePzUWH9BEE5X23eLepmhThZHwExXeBcS45/ueiqzoI5m5+?=
 =?us-ascii?Q?h2FuAkHi/xFi+OPV6wRc05mZrCxeghDpVcFM9seIx2qOuEDhZdEL++sneeTW?=
 =?us-ascii?Q?FiUYiI861Cx7CxGBIbmcEoDUPROGwc6+PKGtbXVKDE5ZpyIsWx1CRDUSOhKw?=
 =?us-ascii?Q?tNsjUuRIMWi8aOqWDfTfmuOQHfiJlBfgN6Tp3juiGGCpfpjF1hSbSX2D98KD?=
 =?us-ascii?Q?Wo86pvZ4lC/nn5Jj3OZ1lycwFYhtZfAXVSvL6nlGcvOwBkj3uQQrDJmqHVEi?=
 =?us-ascii?Q?IR82NLfUNCh6kLC9TPMjbfGsVVKZ1d4sow2r2LmprjYHFWKhjABlJBSOuaL2?=
 =?us-ascii?Q?Z5xY4vdg545EsJf805GaYjA1+odibgd/jMBnk1s/71medlr5k6q/vLkikRaK?=
 =?us-ascii?Q?ki4UroXacXBUeZLsPVEXzMYthvmAxS6s34zQfTUUZCsymCpzKlqvgrGaAtsN?=
 =?us-ascii?Q?hl8P99BbGNspnpMHIq742GWrjd2iBNZcL+K4QVMMDjXwznb9lsWotT58Q9cf?=
 =?us-ascii?Q?/Yv3MCr528qR1JrEULGp3E5OnhbdKdckpBajQz6JEplV4dZy2uKKuBlJQlYd?=
 =?us-ascii?Q?ru//qj3/sODPU5m342DZWwqtaUcaaJhL7JOIdFTbBLyBu+87bIMuzXxes8Rt?=
 =?us-ascii?Q?099CJUWv1r1rDvegDFMh8DmFhLtrUQaf7AtYtxPnD3/q0Ch6Qx2OuWy9xKjf?=
 =?us-ascii?Q?W2XQTmGivmreHnyushBiaDWWHUhRQKKPJx5m7eEMCzYGgfsAGUc+80H3X6MS?=
 =?us-ascii?Q?VxN+kfVTZ8leT8G/dP70X/l9Z60xvWiONXgzzn9yesY7jy+DiSzQbHGuQNrh?=
 =?us-ascii?Q?fiGfH0er2wNm6twqMAXUDBJ7TAol+10U63SK/ChuK4xPJXzM029GOa2w1oGR?=
 =?us-ascii?Q?1Yvhjovjt0PWrpPjzZl6LN4c/0H4V/gqB5PoIEeqhVpt8M41wZ00wMski5P1?=
 =?us-ascii?Q?rJ0zho2eUK8AG6YV1HPW2ZycQB816QjkmVUd82dCEkV9aWfCFvMOZm2osknn?=
 =?us-ascii?Q?ke0INv3Z2I8rkOroZu/uPNakiM7jfxD8tpm1aoK8n5dYBhLZl3oLMwKZzpOr?=
 =?us-ascii?Q?RBHE/kLAiX1idDqeNqVE0pqdvzX+TQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0f7669-b575-48ee-eefe-08d8c7743769
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 12:15:23.6426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhREQzF9mFiuTwSWulTgQxFdZZbEpp8KOFdvIFnMUZOgCGYAdE0pZjXdgNJz/Mc2jGZgRzAs+IeekoqzdL9GAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1247
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

On Tue, Feb 02, 2021 at 08:04:43PM +0800, Su, Jinzhou (Joe) wrote:
> Check GFX DPM and PG bit before enable GFXOFF on Vangogh
> smu post init.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 4726cac8d824..f0f06ef47b9e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1712,10 +1712,16 @@ static int vangogh_post_smu_init(struct smu_context *smu)
>  		adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>  
>  	/* allow message will be sent after enable message on Vangogh*/
> -	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
> -	if (ret) {
> -		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
> -		return ret;
> +	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
> +			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> +		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
> +		if (ret) {
> +			dev_err(adev->dev, "Failed to Enable GfxOff!\n");
> +			return ret;
> +		}
> +	} else {
> +		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +		dev_info(adev->dev, "If GFX DPM or power gate disabled, disable GFXOFF\n");
>  	}
>  
>  	/* if all CUs are active, no need to power off any WGPs */
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
