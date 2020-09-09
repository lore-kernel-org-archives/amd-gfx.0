Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200CCC43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 05:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C9521D40
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 05:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D7Ln8UN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C9521D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57BD6E95E;
	Wed,  9 Sep 2020 05:05:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7D76E95E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 05:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz9j0bS8qI2BaZH41h8ZFy3r0jUt3nYjmDPpvDkreL7B8IUbB3yQz6+nvMcIdTGk7GK4WNiStzRp0O0Pc9iOG7vffKMskCbCPXP7wie8AKFlpr0aa3flkqjY0ZHd3iRd6mh4tAaKTHL1u1vJFh3gnW8/2bWuxHr5m0M9HayEdORhNTCplNndXDcH5RWaLVjtMO/SHXtqcJYY6uc9BEXRHXEVeCzz56KyxIjSM/woArNyaO8aEC/rac1VK3ZURFgsLsNpfL7WqkRWwwN3EQYaDAPiAbIZYbvI5WxPsiOJkqQAsHPbFvIBw69qSGl0mgeEA84GvX7HCW3OiUkxUDViYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVZh73Juh5I+o9PoZPN1mtevgp4jqn/TBB/GwiEebTI=;
 b=T0CJoEJJgg3Z3QD2zV+xg8+NErMvN8CMwa5zprL6/RjAmA/omDQkMgwZjWYweNuRUVKkUuWnHXkr/cwg/4qqVqleo6W7ylEZtIY+PbII2rf9eMRHXwwF6DkVh2S1LBxFttTie+KkYF0jlsAxaBEWk+spY2WKD6QVIVVXajj5/u15C8k6feOS2ADgkigBAXemq6CyAhv2/KGr/I+oT1TCq0Ji4tzozDZU7zLpvGBmjZbHnY7sa9jK56P1iBwO0He1z0rBL53ro05MsYCz5ztlHyYo5ZM1zHty8X0FIrj2F5DBqGeLNQPxLhEDnm4FnKCsdcnBIkSZpGM61xFyds2Xcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVZh73Juh5I+o9PoZPN1mtevgp4jqn/TBB/GwiEebTI=;
 b=D7Ln8UN4s9+DOIc2nJ/sY31dNWVvFOhbraeV4wqrnlf6tnN1Q7gqx+Y/TrL3zC+bLJiv799AH38TuQGFsh6gWcyp1qbig38FmUmq+kdB5i/k/vpUmP2kd5YeOY20/edyhHVg35FOqcQWFSsBAfs5+EalXkj5+uX7hMC4AcP0lWE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 05:05:14 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 05:05:14 +0000
Date: Wed, 9 Sep 2020 13:05:07 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add ta DTM/HDCP print in
 amdgpu_firmware_info for apu
Message-ID: <20200909050507.GC2509333@hr-amd>
References: <20200908083111.13901-1-changfeng.zhu@amd.com>
Content-Disposition: inline
In-Reply-To: <20200908083111.13901-1-changfeng.zhu@amd.com>
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0156.apcprd02.prod.outlook.com (2603:1096:201:1f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 05:05:12 +0000
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1daaf41f-b667-46d8-1c08-08d8547def87
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1661A51B0472D5C3C71A25B2EC260@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgATj49bWScGgSMMFmhkoFv5Kt8eiLCxHBPgK10xSWJmh+8JQTzafSNy/DVpIppDOmJRT0CvKVA8MeKjaC73AVz/h2D9m3XXI4i4J0WBNP57ABpHOQtOs3ktnZGgJTydNGLF3JjI5+IeJmGhE7kfwy6fEweHfdJmlGMqAFN/INTwLB78LnMS9/3iVQhsKv7Ae3bfQa7QX7hp0rECf0wINzL7GOi4NWw7J6wAWWhVv/YOPcZSkxqCkEANtDMLYJvrS99joUzqxI6LZpQ4YVtnsPKG81egWcM98vxzXvZOKcDkHLRDlSRXauDoZvyQoKtC67DPOxQIgH4POjtGwTEpxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(8936002)(52116002)(33716001)(6636002)(6496006)(83380400001)(33656002)(4326008)(9686003)(2906002)(54906003)(86362001)(478600001)(55016002)(6862004)(956004)(16526019)(316002)(66476007)(66946007)(186003)(66556008)(8676002)(5660300002)(26005)(1076003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: p5gdWmfikVuRF7Cj+aEZ9ewkXnlOuQoRJCza1HSoBLWxAlSbLjSym2tjRnCSZmroR0cyxzCt0uOsRP1jFlYRMJGVDFwo7tw77TwdIf2mOAi9YQ3w9IrcdYGdFgqAof4+QdiT7Je2Vi2gVUWnPfxt9ys5k+X0YxDGl1VMkhogvsjUZ95ps+Wu/EI1p/cZJ7W+wl/2CG+3ucgn4LzL9+gV8fAffHt6+m+9UU1TJweVxLo5Xtpz/NpVIy4M8u+HAJ6qD4CfsxkV9Zhs6Xi1ytdVUO0h9KiOqzAi0XYhgRIz8HRmlonqYILuErPQ5QYZLecHiYv1PIGruD+lT5Pt+gle4tNfCDbjvWl+C8CyEYP/RYW9CMZu77dJFPS+Oc2VL2050gJaVDlmEQEmyh4eTHAM4n5HMyt/fmi2lqx+nS5GiqdAgNGm8lVxSdE3ImDGrAjni355N9Kx077MIjdhPGHRRGsmLiRSGoj52JUU9gVL0Kft2C+FqZ+Kqul4fTFTElQLX/YvcwluLKjGutmlekFxzmEX7vH6twjEfccPkOmOQRjP4Sgn4nFnb83FKI76K+sr+oW/9z6Ddib/UHfF5PzdbXf4KI8Hj/KoHH/pc2+mplPPHEAEGOpMxS5vIikSVmKVtGuB7aIGspZsqVScjPHozA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daaf41f-b667-46d8-1c08-08d8547def87
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 05:05:14.3907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as+tnfA7uOd+km5O2oy/sZwL1Sf7LHNTn1PIavsPTPyPQGfjPm3DFrZ1OVddC6sCT2VwfV/7h816ShPBf4+XFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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

On Tue, Sep 08, 2020 at 04:31:11PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> From: Changfeng <Changfeng.Zhu@amd.com>
> 
> It needs to add ta DTM/HDCP print to get HDCP/DTM version info when cat
> amdgpu_firmware_info
> 
> Change-Id: I05f20d6868ce2cac06a8496890b766dbb61de671
> Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 ++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4f6b167fef26..3a6a881a4105 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -282,14 +282,20 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>  		fw_info->feature = 0;
>  		break;
>  	case AMDGPU_INFO_FW_TA:
> -		if (query_fw->index > 1)
> +		if (query_fw->index > 3)
>  			return -EINVAL;
>  		if (query_fw->index == 0) {
>  			fw_info->ver = adev->psp.ta_fw_version;
>  			fw_info->feature = adev->psp.ta_xgmi_ucode_version;
> -		} else {
> +		} else if (query_fw->index == 1) {
>  			fw_info->ver = adev->psp.ta_fw_version;
>  			fw_info->feature = adev->psp.ta_ras_ucode_version;
> +		} else if (query_fw->index == 2) {
> +			fw_info->ver = adev->psp.ta_fw_version;
> +			fw_info->feature = adev->psp.ta_hdcp_ucode_version;
> +		} else {
> +			fw_info->ver = adev->psp.ta_fw_version;
> +			fw_info->feature = adev->psp.ta_dtm_ucode_version;

Can we use switch-case here?

>  		}
>  		break;
>  	case AMDGPU_INFO_FW_SDMA:
> @@ -1383,13 +1389,24 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
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
> +		if (query_fw.index == 0) {
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"RAS", fw_info.feature, fw_info.ver);
> +		} else if (query_fw.index == 1) {
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"XGMI", fw_info.feature, fw_info.ver);
> +		} else if (query_fw.index == 2) {
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"HDCP", fw_info.feature, fw_info.ver);
> +		} else {
> +			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
> +					"DTM", fw_info.feature, fw_info.ver);
> +		}

The same comment above. Switch-case is more straightforward.

Thanks,
Ray

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
