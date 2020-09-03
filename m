Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E51C433E7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 06:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B00206EB
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 06:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fkR+UgNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B00206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BF36E185;
	Thu,  3 Sep 2020 06:37:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69396E185
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 06:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxbzUnj4dkxgkO/lLwmS1ED/AZFH7/FCk2P8fCJP9yomaZ9dUqO8U0we7XRT1fUuc+mFCOWREspda0jIVXwi53fDjN5I0kPosNgRLy3t3kmYC/vFOmaHPNPFYGAskYmKHpyCD198ss4Vy1l0lXJrWujNU9xiekLrOp+s8i46CfvxyaM37Wo0iKerYjdt1TxZHdGNjbPqYEZ6ePH/JTlj4SMcvmZZMYNaaZqQp7DOBLRtfRA38gPRwmZ0VFPjkobspCADh5yxDO05MygD7ck7xmxzeaw4Towljuqov+ju3XtBWc75LWLnLcFZYS5l186fXTSgNGpKvvPLvpALjpHT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCvh8OhoGsM9g0rBJi3MA4b0Kh+Y/stIGdjr8M6Gmi8=;
 b=ljTvyrxgEGYJ/yEpf5Xf+j5mkXt2WcOpvPhkG+jzQc9TZL7uHd+zxGSdYXkvf5l3E/O3NVLMYuQM/74QbhTFQ84saJLYbR8EjeNLHM23nNfso7pGxth72c/R7XRGboWIta1z/s/HmSBGlykgjI4HZ6W2hqZQ25ALBb0yuIkG5fZPX2XIb3reCb9ad3PYavRyltX/SsCM3wb0GHTJ8PBhbh2B9GKmDRzCdfMkRFvVmFzTJsJL9tZki58bTsdUeM6kC3rLU6bB4RAYmw/o1dJloN5RW2pbDE6Ex9vRsCealdUHV9yzf5ZQCrjJKINpGeWb1Fn9dOGTA26ovztsKXV2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCvh8OhoGsM9g0rBJi3MA4b0Kh+Y/stIGdjr8M6Gmi8=;
 b=fkR+UgNRUIBMM21GzDZ/HRuUIFYkeLQLVCbanMEJ2KFMRz5O/D4Rf/63al9zNYFyjmN2PkqA58KUXASEuG+8hedkbZbSYnAC0ZbMUORyqsGZ3UsFTqrRaZKUKab4dfdLWMKiDq7EOMH7sW5BkqwiLzQ3owHuVFqY38zAM+ud5RM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1184.namprd12.prod.outlook.com (2603:10b6:300:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 06:37:38 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6%7]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 06:37:38 +0000
Date: Thu, 3 Sep 2020 14:36:32 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc9: print client id string for mmhub
Message-ID: <20200903063632.GB2470278@hr-amd>
References: <20200902181640.1559269-1-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20200902181640.1559269-1-alexander.deucher@amd.com>
X-ClientProxiedBy: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR02CA0191.apcprd02.prod.outlook.com (2603:1096:201:21::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 06:37:36 +0000
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a8a6910-e562-445e-8fc1-08d84fd3d96d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB118480B8DDBD14E682888DDCEC2C0@MWHPR12MB1184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sb/OpqP6k7jM0SFQOec6iY5fx5hU2r2cLPhYD1hE4Qa2Vbn+vbQHYtsbQK6Imoyi0u+e/Uo+plpj0pUPSwx+RSQK93fLlDBa2QTKbvCWEOPu1hBicMvvPszfbbXXaPJxB/gyNDsAkooy21niebifU2b5HnM7/a11Q17Xo+bA3yJDalCuBX+jlRPHcg4gwadDgXDlimpTQBmbjRITwjiEi1mBDF52XnvL8WoVnJPKP5Gx9R/HShW7jGOzW+5qVkBskpthdJuzcx5ZGSXDn1eBsew1YEZ0kDy0g6seamZUELpukyk6KudBcyAYY9B9WJRmFEpJDCh/xJTZF9Oe9IhU+FrjF/1ukGHBxrqNCT0I8w8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(478600001)(186003)(2906002)(5660300002)(86362001)(316002)(45080400002)(26005)(66946007)(66476007)(16576012)(83380400001)(33716001)(4326008)(6486002)(66556008)(52116002)(966005)(6916009)(9686003)(8676002)(1076003)(956004)(6666004)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dW88lMuiKuNf9oyHSKm4WjCZ8zGZNcaOAJWxPHoa8sZ2v6NTvStOmJx4/swQvoKc4T+1g6OLH0HDpe5cSE4zwozmkbUB2mKBbm4pkzjy+bwVKpVwg8r2oBXQHuurYrhQYfnYu3xQ/D7EYooo1lTUehVNOM8pS/Zdj/LwSMp5MAD3Etw0FqdKl8IDXphvZMyk6pD0GhcKaHDDWYF4w+T7mBI1IfdtbtR6GTSLb1th9ErioIZwK2gF+UGBkMJfgvIDcyENjIUG2EsbOqjRG7oASiVnn/N7HfDRnlnvL/wvu17eNvBDF4whIS7Y5VpmrURuQ9hsucii8EbORwEzez5KQVBSP7UgtfXJF4SDPSgzxiU97z5hx3npSP/6yy2pSb5gQ1oeOAg+aNZrLMVeg00WRFf2fi+76MNB4PZ2h6YrK/DJMMmF9ueforfaVnpSEA5Dl7yErGmZ5mV/MkYeQt8wMha1s84RVDCDv+HtLUIkLwz3n/jE79Xr7gt6xe+qhZFtkwpKo5wFb9jOd3Z9lqpDHef14ACfueqqtTGQBrFWS94OQJdlxXH5KQb+pqceal67Dr360MpNa9ts1ADdOXg+ZqkqPPR0pUA4ItZw6FR8aANJbJAj8m2XvapvV8OtR8HSmW9On/R8Gz0TwwFu1GT9dQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a6910-e562-445e-8fc1-08d84fd3d96d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 06:37:38.2312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g9vf4w6ikwQKvwn0a8Ku5BFExZVm0NuXV48xzWxQs0LnWCTUfIjsDShfgqrWDNFtLL66s74GgsBdXaGmME6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 02, 2020 at 02:16:39PM -0400, Alex Deucher wrote:
> Print the name of the client rather than the number.  This
> makes it easier to debug what block is causing the fault.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 239 +++++++++++++++++++++++++-
>  1 file changed, 230 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 7e86aee60c64..f9e810126124 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -87,6 +87,203 @@ static const char *gfxhub_client_ids[] = {
>  	"PA",
>  };
>  
> +static const char *mmhub_client_ids_raven[][2] = {
> +	[0][0] = "MP1",
> +	[1][0] = "MP0",
> +	[2][0] = "VCN",
> +	[3][0] = "VCNU",
> +	[4][0] = "HDP",
> +	[5][0] = "DCE",
> +	[13][0] = "UTCL2",
> +	[19][0] = "TLS",
> +	[26][0] = "OSS",
> +	[27][0] = "SDMA0",
> +	[0][1] = "MP1",
> +	[1][1] = "MP0",
> +	[2][1] = "VCN",
> +	[3][1] = "VCNU",
> +	[4][1] = "HDP",
> +	[5][1] = "XDP",
> +	[6][1] = "DBGU0",
> +	[7][1] = "DCE",
> +	[8][1] = "DCEDWB0",
> +	[9][1] = "DCEDWB1",
> +	[26][1] = "OSS",
> +	[27][1] = "SDMA0",
> +};
> +
> +static const char *mmhub_client_ids_renoir[][2] = {
> +	[0][0] = "MP1",
> +	[1][0] = "MP0",
> +	[2][0] = "HDP",
> +	[4][0] = "DCEDMC",
> +	[5][0] = "DCEVGA",
> +	[13][0] = "UTCL2",
> +	[19][0] = "TLS",
> +	[26][0] = "OSS",
> +	[27][0] = "SDMA0",
> +	[28][0] = "VCN",
> +	[29][0] = "VCNU",
> +	[30][0] = "JPEG",
> +	[0][1] = "MP1",
> +	[1][1] = "MP0",
> +	[2][1] = "HDP",
> +	[3][1] = "XDP",
> +	[6][1] = "DBGU0",
> +	[7][1] = "DCEDMC",
> +	[8][1] = "DCEVGA",
> +	[9][1] = "DCEDWB",
> +	[26][1] = "OSS",
> +	[27][1] = "SDMA0",
> +	[28][1] = "VCN",
> +	[29][1] = "VCNU",
> +	[30][1] = "JPEG",
> +};
> +
> +static const char *mmhub_client_ids_vega10[][2] = {
> +	[0][0] = "MP0",
> +	[1][0] = "UVD",
> +	[2][0] = "UVDU",
> +	[3][0] = "HDP",
> +	[13][0] = "UTCL2",
> +	[14][0] = "OSS",
> +	[15][0] = "SDMA1",
> +	[32+0][0] = "VCE0",
> +	[32+1][0] = "VCE0U",
> +	[32+2][0] = "XDMA",
> +	[32+3][0] = "DCE",
> +	[32+4][0] = "MP1",
> +	[32+14][0] = "SDMA0",
> +	[0][1] = "MP0",
> +	[1][1] = "UVD",
> +	[2][1] = "UVDU",
> +	[3][1] = "DBGU0",
> +	[4][1] = "HDP",
> +	[5][1] = "XDP",
> +	[14][1] = "OSS",
> +	[15][1] = "SDMA0",
> +	[32+0][1] = "VCE0",
> +	[32+1][1] = "VCE0U",
> +	[32+2][1] = "XDMA",
> +	[32+3][1] = "DCE",
> +	[32+4][1] = "DCEDWB",
> +	[32+5][1] = "MP1",
> +	[32+6][1] = "DBGU1",
> +	[32+14][1] = "SDMA1",
> +};
> +
> +static const char *mmhub_client_ids_vega12[][2] = {
> +	[0][0] = "MP0",
> +	[1][0] = "VCE0",
> +	[2][0] = "VCE0U",
> +	[3][0] = "HDP",
> +	[13][0] = "UTCL2",
> +	[14][0] = "OSS",
> +	[15][0] = "SDMA1",
> +	[32+0][0] = "DCE",
> +	[32+1][0] = "XDMA",
> +	[32+2][0] = "UVD",
> +	[32+3][0] = "UVDU",
> +	[32+4][0] = "MP1",
> +	[32+15][0] = "SDMA0",
> +	[0][1] = "MP0",
> +	[1][1] = "VCE0",
> +	[2][1] = "VCE0U",
> +	[3][1] = "DBGU0",
> +	[4][1] = "HDP",
> +	[5][1] = "XDP",
> +	[14][1] = "OSS",
> +	[15][1] = "SDMA0",
> +	[32+0][1] = "DCE",
> +	[32+1][1] = "DCEDWB",
> +	[32+2][1] = "XDMA",
> +	[32+3][1] = "UVD",
> +	[32+4][1] = "UVDU",
> +	[32+5][1] = "MP1",
> +	[32+6][1] = "DBGU1",
> +	[32+15][1] = "SDMA1",
> +};
> +
> +static const char *mmhub_client_ids_vega20[][2] = {
> +	[0][0] = "XDMA",
> +	[1][0] = "DCE",
> +	[2][0] = "VCE0",
> +	[3][0] = "VCE0U",
> +	[4][0] = "UVD",
> +	[5][0] = "UVD1U",
> +	[13][0] = "OSS",
> +	[14][0] = "HDP",
> +	[15][0] = "SDMA0",
> +	[32+0][0] = "UVD",
> +	[32+1][0] = "UVDU",
> +	[32+2][0] = "MP1",
> +	[32+3][0] = "MP0",
> +	[32+12][0] = "UTCL2",
> +	[32+14][0] = "SDMA1",
> +	[0][1] = "XDMA",
> +	[1][1] = "DCE",
> +	[2][1] = "DCEDWB",
> +	[3][1] = "VCE0",
> +	[4][1] = "VCE0U",
> +	[5][1] = "UVD1",
> +	[6][1] = "UVD1U",
> +	[7][1] = "DBGU0",
> +	[8][1] = "XDP",
> +	[13][1] = "OSS",
> +	[14][1] = "HDP",
> +	[15][1] = "SDMA0",
> +	[32+0][1] = "UVD",
> +	[32+1][1] = "UVDU",
> +	[32+2][1] = "DBGU1",
> +	[32+3][1] = "MP1",
> +	[32+4][1] = "MP0",
> +	[32+14][1] = "SDMA1",
> +};
> +
> +static const char *mmhub_client_ids_arcturus[][2] = {
> +	[2][0] = "MP1",
> +	[3][0] = "MP0",
> +	[10][0] = "UTCL2",
> +	[13][0] = "OSS",
> +	[14][0] = "HDP",
> +	[15][0] = "SDMA0",
> +	[32+15][0] = "SDMA1",
> +	[64+15][0] = "SDMA2",
> +	[96+15][0] = "SDMA3",
> +	[128+15][0] = "SDMA4",
> +	[160+11][0] = "JPEG",
> +	[160+12][0] = "VCN",
> +	[160+13][0] = "VCNU",
> +	[160+15][0] = "SDMA5",
> +	[192+10][0] = "UTCL2",
> +	[192+11][0] = "JPEG1",
> +	[192+12][0] = "VCN1",
> +	[192+13][0] = "VCN1U",
> +	[192+15][0] = "SDMA6",
> +	[224+15][0] = "SDMA7",
> +	[0][1] = "DBGU1",
> +	[1][1] = "XDP",
> +	[2][1] = "MP1",
> +	[3][1] = "MP0",
> +	[13][1] = "OSS",
> +	[14][1] = "HDP",
> +	[15][1] = "SDMA0",
> +	[32+15][1] = "SDMA1",
> +	[32+15][1] = "SDMA1",
> +	[64+15][1] = "SDMA2",
> +	[96+15][1] = "SDMA3",
> +	[128+15][1] = "SDMA4",
> +	[160+11][1] = "JPEG",
> +	[160+12][1] = "VCN",
> +	[160+13][1] = "VCNU",
> +	[160+15][1] = "SDMA5",
> +	[192+11][1] = "JPEG1",
> +	[192+12][1] = "VCN1",
> +	[192+13][1] = "VCN1U",
> +	[192+15][1] = "SDMA6",
> +	[224+15][1] = "SDMA7",
> +};
> +
>  static const u32 golden_settings_vega10_hdp[] =
>  {
>  	0xf64, 0x0fffffff, 0x00000000,
> @@ -319,9 +516,10 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_vmhub *hub;
>  	bool retry_fault = !!(entry->src_data[1] & 0x80);
> -	uint32_t status = 0, cid = 0;
> +	uint32_t status = 0, cid = 0, rw = 0;
>  	u64 addr;
>  	char hub_name[10];
> +	const char *mmhub_cid;
>  
>  	addr = (u64)entry->src_data[0] << 12;
>  	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
> @@ -358,6 +556,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  		status = RREG32(hub->vm_l2_pro_fault_status);
>  		cid = REG_GET_FIELD(status,
>  				    VM_L2_PROTECTION_FAULT_STATUS, CID);
> +		rw = REG_GET_FIELD(status,
> +				   VM_L2_PROTECTION_FAULT_STATUS, RW);
>  		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>  	}
>  
> @@ -380,13 +580,37 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  			dev_err(adev->dev,
>  				"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>  				status);
> -			if (hub == &adev->vmhub[AMDGPU_GFXHUB_0])
> +			if (hub == &adev->vmhub[AMDGPU_GFXHUB_0]) {
>  				dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
>  					cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
>  					cid);
> -			else
> -				dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%x\n",
> -					cid);
> +			} else {
> +				switch (adev->asic_type) {
> +				case CHIP_VEGA10:
> +					mmhub_cid = mmhub_client_ids_vega10[cid][rw];
> +					break;
> +				case CHIP_VEGA12:
> +					mmhub_cid = mmhub_client_ids_vega12[cid][rw];
> +					break;
> +				case CHIP_VEGA20:
> +					mmhub_cid = mmhub_client_ids_vega20[cid][rw];
> +					break;
> +				case CHIP_ARCTURUS:
> +					mmhub_cid = mmhub_client_ids_arcturus[cid][rw];
> +					break;
> +				case CHIP_RAVEN:
> +					mmhub_cid = mmhub_client_ids_raven[cid][rw];
> +					break;
> +				case CHIP_RENOIR:
> +					mmhub_cid = mmhub_client_ids_renoir[cid][rw];
> +					break;
> +				default:
> +					mmhub_cid = NULL;
> +					break;
> +				}
> +				dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +					mmhub_cid ? mmhub_cid : "unknown", cid);
> +			}
>  			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>  				REG_GET_FIELD(status,
>  				VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> @@ -399,10 +623,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  			dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
>  				REG_GET_FIELD(status,
>  				VM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
> -			dev_err(adev->dev, "\t RW: 0x%lx\n",
> -				REG_GET_FIELD(status,
> -				VM_L2_PROTECTION_FAULT_STATUS, RW));
> -
> +			dev_err(adev->dev, "\t RW: 0x%x\n", rw);
>  		}
>  	}
>  
> -- 
> 2.25.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7Cacb1cf0cc5064b3dfbd008d84f6c5fd0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637346674195023748&amp;sdata=zZRNUXfycewKxFwuVk1gBGc9CiPGIOhhm1Uv9KAeoec%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
