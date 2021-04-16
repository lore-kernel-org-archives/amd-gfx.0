Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AAFC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 10:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C4C61107
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 10:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C4C61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6F86EB61;
	Fri, 16 Apr 2021 10:08:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808C16EB61
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 10:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X44+NFGs4yGwGIHuts2JTStfRdLXTI494Q06RlKbPU0OS814xBCA+M0Vn0ldf3DUoUarw+o1tPHD7/FKXuL3UTi4Ysx7vNohAs60syS0n/1O33Nqx+F0BZHjCHrNJfsA7hiGDZtg1Rm88J214qLnKJ0kB2ARNLFS9sEpBGVwnVrj1fKfNLQktu7saCIoXWr4STBwVOGnEToXkN28HYCp4jb8FTSFZn0+eqY9I8EWSJSlpx46923vH6FOQjama3G11KmDKGVzFvef5rcKwOOdd/UAZVQfwMydJu6YsVoTgrLPWpCC7HPN8KGBwdDO1j0Slxwt2ECHh2BdOnC/2pIXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmv//1y72MzDbgab0ok6ad/P6xjeE2yxCiurlEcMcsM=;
 b=O9cqg3U/EDSSAExC9HrFpCSFx3wM8FwOhXyvf2C18A2oeWXx51uMjiH68CWYP/LHfJmRbNkdAGFpzFNIhfWFpsXZ2b3aiAefdT6zD1HMX93+wF6pWs1BoY4rhdBYuK6jVLHzhiW9HCXiIZYskI71dGhJGvm3ZBTqc/cc7NnKANf3ESka4RIsLx8L42iEIbOogwrvp62WepIlPYrXS7eXi6fUCoXJQYam+psWLVUWDAwA1IKZG5DtmEgmoj6ky9yBa6yZ2pE1cTvyEIEsm2qP9P3ZDplqmpeslrQVwwWyopIM0fQsH8TOgK4B+CJKWsueYLmFDEnwiwPuzpKSqusqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmv//1y72MzDbgab0ok6ad/P6xjeE2yxCiurlEcMcsM=;
 b=dtwH6IvV3OEjDMjpbVWLTgVdtpkeO2RjOvFW+J4dIngkwy9klsHxKSH8DzRivh48wCuBOTZdknqMifmftsgd/rCMuc65wDGnAKIIbw6BmGc3NvHVo3ig2VY/m4xGqXj/ET2mrL1dd3PO8gdqXCO22mq9qht9FTBpqT0DsZuOpJQ=
Received: from MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11)
 by MWHPR1201MB2540.namprd12.prod.outlook.com (2603:10b6:300:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 10:08:50 +0000
Received: from MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd]) by MW2PR12MB2460.namprd12.prod.outlook.com
 ([fe80::6930:cfb8:c85b:1fd%7]) with mapi id 15.20.4020.022; Fri, 16 Apr 2021
 10:08:50 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, John Clements <John.Clemenets@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: only harvest gcea/mmea error status in
 aldebaran
Thread-Topic: [PATCH 2/2] drm/amdgpu: only harvest gcea/mmea error status in
 aldebaran
Thread-Index: AQHXMqU6jJkFG3PryUSwlWFjoWrC1aq26ssw
Date: Fri, 16 Apr 2021 10:08:50 +0000
Message-ID: <MW2PR12MB246004A1AA024B57F9D2951F9A4C9@MW2PR12MB2460.namprd12.prod.outlook.com>
References: <20210416094424.18955-1-Hawking.Zhang@amd.com>
 <20210416094424.18955-2-Hawking.Zhang@amd.com>
In-Reply-To: <20210416094424.18955-2-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-16T10:08:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=620ddbd2-f2ce-4df5-80e1-3abf05c1974d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a18c23-8684-426f-fa4a-08d900bfa1d6
x-ms-traffictypediagnostic: MWHPR1201MB2540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB2540F5A3B392758A9EDA1CEA9A4C9@MWHPR1201MB2540.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2QSHoZSqhg/IQZ3f8QM+bIgrddEeC9BFtJ1uIwpOeId9NsXDKueHiO7fjwAdDofyO7MZdUGN1urXo6yDyFJAiZvtNtYCVXO3cp53eZ5XgVH+CoeM8fRIfW3fSrmh253gqQU/wQvKwI+88bVpHDY0Lc/EF6qL8PUkp51s8zChcF2xLbVqteymDDZFGJz1vXCy0EVoiM6ms/+SXSC2u3T3mUjiPmgNs+0SQDEjH7541er8Rnep/L/W2RNdgcBiZF9272Inzdm/ruG3Wl9VteWEqzFDPcCqKLrs2R6yiQ7gkiZhkWdpnWyxZ1vnMIhdaW4G71AaZdicc6/SkZpsNiUwttYhRZGBQ5eAVT9zFCQUeMRY+789Cf5u/cEQwgcW/kkU7vq/rGhxt5w4ZlDeKDGzwdUdpdRTH+RH8QZBBf9Pdi57TrbaQLih9awIKa5hHK3xgHKC7Z4ou8Ehir1YPar8pmBtYJiGycCCq4ojEg+GbpfrPNmog5D6HtOLoj/a9lHPmaqr0yuGOigkozYfciNtOJl3tkqTMON5qwtQYwQ1d0E8jG/1VrhucFTVoFMXTJhdeURlLbDH+SvWILrRJCKUABRYrYZXOoLm14v++dd88s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(71200400001)(53546011)(52536014)(9686003)(2906002)(38100700002)(5660300002)(186003)(64756008)(55016002)(66446008)(122000001)(86362001)(66476007)(7696005)(76116006)(66556008)(66946007)(6506007)(26005)(8936002)(316002)(478600001)(8676002)(6636002)(83380400001)(33656002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iEaTyqsCRziu140lvDgDwpax+3/0Ra04XJfx8rcIUPyu1QRVDODrqzWa9/bo?=
 =?us-ascii?Q?iNx3BlKwyFHrzEXmxKok33COqiqZvqTmKN10I3Zpa9V2pEutrmMzEj9mCdT0?=
 =?us-ascii?Q?qgCWcfBNhFp0yU8pVw1wRDcPTcj6ttFS1vuRF/rqqAMPtcrvFkhNyeuI9y3P?=
 =?us-ascii?Q?6+ts+xwZjrdIloHLCL+53VLNqXY2TNSuTInzErhDb232rlaoxhtfcOmkTowM?=
 =?us-ascii?Q?QZJK5tNlYcExswXkQOlQLAT40lYnsCZM2IaTSGao0TnLoSz9tjaFzA6/yUV+?=
 =?us-ascii?Q?mCBMOWnnKo8w0Ac1RPL3LkucxXWX43rEIhKyf++hnfQ14h9ilb4uunfL8sM8?=
 =?us-ascii?Q?l1+uCpQquXwl+UN5kktp6uEWMkFH3C+eGpH0JNHhtde7ZsMp2A/h2MR8Y5Zh?=
 =?us-ascii?Q?CZ9kIlv/q/OV991UaFUFUXdPHYVn0SVGebt+hwYMC7NtkwC/R4JsHyML0ptR?=
 =?us-ascii?Q?7rLQCUQay/0yc7sBQCu5k/ngB9PgY5fzbLG9xHnMN2s7ktAB2sPHRirWBRyQ?=
 =?us-ascii?Q?R0OQSv0UZ0iiEh4wzjX0qpWHb8VYjQXS1eACJg6TmHCctvzX/ldMMM3qjLRq?=
 =?us-ascii?Q?OQ3yybGuQ0n3n5Ez0+tDd9FEkwLk4oE1I4f1B2JMfSbjrRxxv+uaBsiWCmBe?=
 =?us-ascii?Q?49MZd4zxtfjyrMvk+0fj/6hMUZuy1132jX3bzHQ2dCWKC50tq3t2UrQMMQM3?=
 =?us-ascii?Q?K/X+gURFnhnCq1vMINAZ670HipU4m7azghv55QzkmeCWdiqlkziq5xyqHz00?=
 =?us-ascii?Q?vJbGdGB71oTYmog4h89EjgIauNO5dU2f5cwyDht4iQ0Rc1Mq4+AZi+2cq7q4?=
 =?us-ascii?Q?cRhd2DHrvbA4q81plBw3Wb1jGnLL5h12gmZSgousmVMJJrkNWX6e4xqobSj6?=
 =?us-ascii?Q?/sGFCoGuHVhCnFzi7uTjmVrvwx6GPdRYBQ0Ys5S5puWozTiTJ/CTjppe2+pK?=
 =?us-ascii?Q?bjbMRi1wSD3G7dNFZZm0j9ujBnofDXvOgdnrew3FC7kdrwrrMbR6BlTEV4yn?=
 =?us-ascii?Q?mI3iAfmYUEYstspqEt9wXnf8XtxBE3T/lSjn8AbYeXb7HqvCFNZOmLYtkh5e?=
 =?us-ascii?Q?gmMjqRz5SuV7qhmTdY/tBa6xmztPwTrrwPMjoVj0Pn6T528FkU0Rvswv/tIi?=
 =?us-ascii?Q?Dk4DeQciIWeUX0a8HinVXlcC1x27INbH9ja1BKhMsa1Mo3rSTJNZcHkfjm/6?=
 =?us-ascii?Q?RHlsYxit4kHkECrViwCruCW5rVjSKiC1FAHEZRS9AmuGfyqnVRPe7oqT69XQ?=
 =?us-ascii?Q?hT6Tn8gsNBFPonblnKfnRU5+6EmSkvGYr9zsInafJBYYCFEvB2XdLVZhidWs?=
 =?us-ascii?Q?7pYO3qcw3D917YIqOJsLy/9p?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a18c23-8684-426f-fa4a-08d900bfa1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 10:08:50.1351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqB87FAQzXMinOuWZRLv2P5d3VLsprf3rgz1HpXAuw56UdOWLn2qJ+a+25XHXaRDkIMiBFu/KEZKVdqd3UOisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2540
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Seriers is Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, April 16, 2021 5:44 PM
> To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>;
> John Clements <John.Clemenets@amd.com>; Li, Dennis
> <Dennis.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: only harvest gcea/mmea error status in
> aldebaran
> 
> In aldebaran, driver only needs to harvest SDP RdRspStatus, WrRspStatus
> and first parity error on RdRsp data. Check error type before harvest error
> information.
> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 21 ++++++++++++---------
> drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 11 +++++++----
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 9ca76a3ac38c..91427543aabe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -808,7 +808,7 @@ static struct gfx_v9_4_2_utc_block
> gfx_v9_4_2_utc_blocks[] = {
>  	  REG_SET_FIELD(0, ATC_L2_CACHE_4K_DSM_CNTL,
> WRITE_COUNTERS, 1) },  };
> 
> -static const struct soc15_reg_entry gfx_v9_4_2_rdrsp_status_regs =
> +static const struct soc15_reg_entry gfx_v9_4_2_ea_err_status_regs =
>  	{ SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16 };
> 
>  static int gfx_v9_4_2_get_reg_error_count(struct amdgpu_device *adev,
> @@ -1040,11 +1040,11 @@ static void
> gfx_v9_4_2_reset_ea_err_status(struct amdgpu_device *adev)
>  	uint32_t i, j;
> 
>  	mutex_lock(&adev->grbm_idx_mutex);
> -	for (i = 0; i < gfx_v9_4_2_rdrsp_status_regs.se_num; i++) {
> -		for (j = 0; j < gfx_v9_4_2_rdrsp_status_regs.instance;
> +	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
> +		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
>  		     j++) {
>  			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
> -
> 	WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_rdrsp_status_reg
> s), 0x10);
> +
> 	WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_re
> gs), 0x10);
>  		}
>  	}
>  	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff); @@
> -1089,17 +1089,20 @@ static void gfx_v9_4_2_query_ea_err_status(struct
> amdgpu_device *adev)
> 
>  	mutex_lock(&adev->grbm_idx_mutex);
> 
> -	for (i = 0; i < gfx_v9_4_2_rdrsp_status_regs.se_num; i++) {
> -		for (j = 0; j < gfx_v9_4_2_rdrsp_status_regs.instance;
> +	for (i = 0; i < gfx_v9_4_2_ea_err_status_regs.se_num; i++) {
> +		for (j = 0; j < gfx_v9_4_2_ea_err_status_regs.instance;
>  		     j++) {
>  			gfx_v9_4_2_select_se_sh(adev, i, 0, j);
>  			reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
> -				gfx_v9_4_2_rdrsp_status_regs));
> -			if (reg_value)
> +				gfx_v9_4_2_ea_err_status_regs));
> +			if (REG_GET_FIELD(reg_value, GCEA_ERR_STATUS,
> SDP_RDRSP_STATUS) ||
> +			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS,
> SDP_WRRSP_STATUS) ||
> +			    REG_GET_FIELD(reg_value, GCEA_ERR_STATUS,
> +SDP_RDRSP_DATAPARITY_ERROR)) {
>  				dev_warn(adev->dev, "GCEA err detected at
> instance: %d, status: 0x%x!\n",
>  						j, reg_value);
> +			}
>  			/* clear after read */
> -
> 	WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_rdrsp_status_reg
> s), 0x10);
> +
> 	WREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_4_2_ea_err_status_re
> gs), 0x10);
>  		}
>  	}
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> index d0f41346ea0c..cc69c434d0de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
> @@ -1286,7 +1286,7 @@ static void
> mmhub_v1_7_reset_ras_error_count(struct amdgpu_device *adev)
>  	}
>  }
> 
> -static const struct soc15_reg_entry mmhub_v1_7_err_status_regs[] = {
> +static const struct soc15_reg_entry mmhub_v1_7_ea_err_status_regs[] = {
>  	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA0_ERR_STATUS), 0, 0, 0 },
>  	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA1_ERR_STATUS), 0, 0, 0 },
>  	{ SOC15_REG_ENTRY(MMHUB, 0, regMMEA2_ERR_STATUS), 0, 0, 0 },
> @@ -1303,12 +1303,15 @@ static void
> mmhub_v1_7_query_ras_error_status(struct amdgpu_device *adev)
>  	if (!amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__MMHUB))
>  		return;
> 
> -	for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_err_status_regs); i++) {
> +	for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_ea_err_status_regs); i++) {
>  		reg_value =
> -
> 	RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_err_status_regs
> [i]));
> -		if (reg_value)
> +
> 	RREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_ea_err_status_r
> egs[i]));
> +		if (REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS,
> SDP_RDRSP_STATUS) ||
> +		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS,
> SDP_WRRSP_STATUS) ||
> +		    REG_GET_FIELD(reg_value, MMEA0_ERR_STATUS,
> +SDP_RDRSP_DATAPARITY_ERROR)) {
>  			dev_warn(adev->dev, "MMHUB EA err detected at
> instance: %d, status: 0x%x!\n",
>  					i, reg_value);
> +		}
>  	}
>  }
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
