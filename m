Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D89C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 10:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD3C20872
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 10:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qOGGXa8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD3C20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73A96E907;
	Thu, 10 Sep 2020 10:57:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCA96E907
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 10:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnkMSHgjhTrj1giSY5rUSB6A1DiW9LWVfs0ZDiGihSEuZvKHKI8Zm5OAnkyq3O1zAxYp9bKSQV59Dssnf06oc1v2MJoeIGH0E5BZpTvPXmPeIWhPghp73yq+f1rndWXU6wPb9DBYvxA7dDJ3kZPFajhoY+pZmDDbTovI4KKMpGwX40gy7pVXS6Kws7bh16Q0dvym2XFtECehlHR+WzV117Rslb8YYOug2J9iHmOZDu6DcTMDF+oCJJtuiomVAh8ZiNftMhnl06c7L5uinEojlbnSOHjEnlQNEZZpSwpfJihlTqjigK/HtAoYOImHG1UGDNwCTEpnXVote6JYGuPDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcdCfntpDApAcuq5bN6Tw9kk+b2eDtUgCilYZ1O93WI=;
 b=ZinXWzJl5iB0PPYraTveONvmGt2zMGP3u/VwHIy5A/+DefewkirsD7K7aftuDyEkiPlMjG/A2U6QAScThXhb/eYPGneMHCvbWA5lbuWvdzEMfYvvY58GzntqPxaLWh+F6+J24LhRTwNXG9Um36d6QF6TzRalzKmgBrT1yS0f2sdm3LDb/3pqBEObH1pHlkarzadlvabAnQ7TuO4kAFlvMDYWykJCZj+PUL8Ge0e68Orz/BdxwMOAi1X38KaWuiOwKNpZ2N2YUom+6jm4i1dHTTuIkdi3GYMkadYOnpi/byOFO/My3E69LFqsyZR9F0iv1GSNTTg8CZSnNjcSU25Dkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcdCfntpDApAcuq5bN6Tw9kk+b2eDtUgCilYZ1O93WI=;
 b=qOGGXa8IzgH7Jdp/kjYQZhYq0NBWFycaNxfKYLJZb1K3QzPLR1kps61C6M6d5entimV4P5b8/IuNQ1z0q3JviHdAHltm5QBQ0vuhEBsDkS+QCV/36NXI1WJaNzEeVT5wNVAkTZKDVNq1CRGlpRArPgpOYYOq/0+kWLKPaguRI+w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 10:57:13 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6%7]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 10:57:12 +0000
Date: Thu, 10 Sep 2020 18:57:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add ta DTM/HDCP print in
 amdgpu_firmware_info for apu
Message-ID: <20200910105704.GA2594057@hr-amd>
References: <20200909055027.25467-1-changfeng.zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20200909055027.25467-1-changfeng.zhu@amd.com>
X-ClientProxiedBy: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR04CA0085.apcprd04.prod.outlook.com (2603:1096:202:15::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 10:57:11 +0000
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db001ea2-812d-478a-bc7d-08d85578458b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4508641144874419616424B2EC270@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOHQldF6xcyeIOqQ3VPSz/Viewr/PazhFKpIML1lkolFdi1+8GYldz6bYGq7l4gmwmxkATcPMq/gSlhu5s1wOKOgD9cIPSj/Lk2hel0G9iSCsWIun7iFKMq/Tsh46YBFAuWn/EsY4Z/d25OwlDD00YNzHCD5ss5XzSJ4lcmNP6iS7Kl48AjPaWNr324aKDhMoMxQJlKt4WmmLTxJx0wA9NgB0OqrcRQUAxOaaYh9ycmFCJmq/hoM/IvqWg+fgxAGwt9ix9UoMXeDSlFg3Zue7MyExeB79ZLFgbUCIKPYFf4gDpLvZkp8osYfHT9msXkvQK/fcEhg+S5zRd6ZNC8GCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(478600001)(6496006)(52116002)(5660300002)(6666004)(86362001)(8676002)(66556008)(66946007)(66476007)(33656002)(55016002)(9686003)(2906002)(6862004)(4326008)(6636002)(16526019)(54906003)(186003)(8936002)(956004)(1076003)(33716001)(316002)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sttE7nDbOlEVhx23gbVqqAxuLmQ/wqlTK+sVWWO7UxgtHgLe3T390KGAkFu3wEMJjmhwhQeb0gJxe2Vy34h/kCJPZU3Kxmhm1cqJOibySfOiyCsRAiGwTOfP4EWDdVG80PFIcIU9janDSjZl0CjR0PJ/9HpZqeViW6PR1zx0J1NqTW4PTks/dnXap/VbcsyjuJKRoNrnVHCh2PpnezdVe3nhBj13BQKF4PAVGo5Py+B4HqMzxSdO8w2+EuG3xWCkK+qdFSDDRjbcZ1OgSFxx3tYE+0NsUJ+zGkVLwGVScE5o5oz4YxIsI6nennRLKhc8Apg+lKqorjlVrLFQkceSgvVMI6brqISBi3onuJwXLkiiJIYpuZlMbqjWMEm3ezym59BGb5jvQ/akNBf7Q3El8Dm9mKd8RSdVqyKgwQmZve+ojmcW1qTH/kASaOLLwuNWFIoK39mkMIZoHFKDucKFXVXjoSVFbqdjxMqe7X94UGZLSyiKJw3Bz8XQ56k8uRMJHx9kGmhlZD0VUAvguvf+KFX3XYuLRh+2lVyUQ3ybmXSAxAf9ukLyFolEslt+EJbQ68VzQAxsNLRDhtMR41VsIiLbmxc/4MttIVbqxMQYAqpaBIKHan6vFBehFHkM59QCQKN/8DZzKLZutsYBdE18Ig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db001ea2-812d-478a-bc7d-08d85578458b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 10:57:12.8335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGMjsitz3ItS9bEjxhoMCXcZhRuZjgYOhTbznGna8/ZkAjvmahvp0RP5m9R96BPXkk9Pn2lLs4qTVMDAgt3gqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 09, 2020 at 01:50:27PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> It needs to add ta DTM/HDCP print to get HDCP/DTM version info when cat
> amdgpu_firmware_info
> 
> Change-Id: I05f20d6868ce2cac06a8496890b766dbb61de671
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 43 +++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4f6b167fef26..d7f37cb92a97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -282,14 +282,25 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>  		fw_info->feature = 0;
>  		break;
>  	case AMDGPU_INFO_FW_TA:
> -		if (query_fw->index > 1)
> -			return -EINVAL;
> -		if (query_fw->index == 0) {
> +		switch (query_fw->index) {
> +		case 0:
>  			fw_info->ver = adev->psp.ta_fw_version;
>  			fw_info->feature = adev->psp.ta_xgmi_ucode_version;
> -		} else {
> +			break;
> +		case 1:
>  			fw_info->ver = adev->psp.ta_fw_version;
>  			fw_info->feature = adev->psp.ta_ras_ucode_version;
> +			break;
> +		case 2:
> +			fw_info->ver = adev->psp.ta_fw_version;
> +			fw_info->feature = adev->psp.ta_hdcp_ucode_version;
> +			break;
> +		case 3:
> +			fw_info->ver = adev->psp.ta_fw_version;
> +			fw_info->feature = adev->psp.ta_dtm_ucode_version;
> +			break;
> +		default:
> +			return -EINVAL;
>  		}
>  		break;
>  	case AMDGPU_INFO_FW_SDMA:
> @@ -1383,13 +1394,31 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
>  		   fw_info.feature, fw_info.ver);
>  
>  	query_fw.fw_type = AMDGPU_INFO_FW_TA;
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < 4; i++) {
>  		query_fw.index = i;
>  		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
>  		if (ret)
>  			continue;
> -		seq_printf(m, "TA %s feature version: %u, firmware version: 0x%08x\n",
> -				i ? "RAS" : "XGMI", fw_info.feature, fw_info.ver);
> +		switch (query_fw.index) {
> +		case 0:
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"RAS", fw_info.feature, fw_info.ver);
> +			break;
> +		case 1:
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"XGMI", fw_info.feature, fw_info.ver);
> +			break;
> +		case 2:
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"HDCP", fw_info.feature, fw_info.ver);
> +			break;
> +		case 3:
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"DTM", fw_info.feature, fw_info.ver);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  
>  	/* SMC */
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
