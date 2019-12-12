Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBBC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 11:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CA7214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 11:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Md612/Z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CA7214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1682B6E09F;
	Thu, 12 Dec 2019 11:07:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B932E6E09F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 11:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLRdisO8no1X8kzSp2WZHCZzSvLZ/MlwaeCCWi8WC4uIKOwHJIgknDBs0ITjV6y0X0j6+l8cGG2H9ewbcTDXqTtcz0w/K0cCBOtQV66nDXLC799Fn+K6xvEasF0Z/ENRO6Vwm/ulm5RE03GbVROujlsNDpsktSv5kRCfQS0+/RDz+ia7SLP52+g8YQ5vnahD73KBTsq8vLl8HFnO5zMTfGKblNOiY2XaSAxGaHtD5vp1+fsApvtpr1ovHCzasTl4pq99GPTAQOqXcQNL4JTWu3tVKOb3ZaWRugVN4AJ/9ikCaC0dEnvIPD2Vy/eCZi8RcFoXVxDqh7wTOUUuY+l/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI7quUNURk1xlfqz0Rd0MJmZvPqcelg1cNjFtqNaiaQ=;
 b=kkcgMrl8uxdESiAlcVeicq6X4C1o3Yqa5jNOAsttShYA1YXZgfVjNF/EiASVtYXHdD2JYVHEFRUbqAUGtS0o6DBbzuXmbjFMocro/JBaWS8Sg4HUz4ukAlHk7IXEgWQ9jCz4sgGgipS0ybZ3qRCdgLIt1s/75QVu8/BAsJYcD/Vbo9dKAN8dLZcz9zQ7N9Td/8bM9nLbJEYyFrRsaCOQjmfa7mjg51GC8/W5gX+NEmAJc68/E9ZYrRD+6FKzF/blmiFRCML8Cm61DXQm5vUzLIrONrJtyKn8dzPbP19YsaesuKLmiwsISfU3etVBIhcYZwSRjmGgYx4OzC6gHSLwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI7quUNURk1xlfqz0Rd0MJmZvPqcelg1cNjFtqNaiaQ=;
 b=Md612/Z3Cspyfwq5I98ooc+ipVmPcx4WsGTW7hLwylzAReq1Ibh2V8ZrXA5obn7iAc0Cx73C3+wkX4Xa+t0Wz4wZr0jCa+jkFadytLK3xOdYjWqD3oBiKa8+F2e9xAQ8IKgj0gMA/nMxnrg1PB7swV1YsZpjIZy8gP+RmsVd+pY=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3213.namprd12.prod.outlook.com (20.179.81.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 11:07:41 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2516.019; Thu, 12 Dec 2019
 11:07:39 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Thread-Topic: [PATCH] drm/amdgpu: enable gfxoff for raven1 refresh
Thread-Index: AQHVsNM/JPJV2oY7HESpP/iWmxnQDKe23QiA
Date: Thu, 12 Dec 2019 11:07:39 +0000
Message-ID: <MN2PR12MB3309355E1C1D86EA454FF6A1EC550@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20191212100155.8741-1-changfeng.zhu@amd.com>
In-Reply-To: <20191212100155.8741-1-changfeng.zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-12T11:07:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36f5d117-036e-4b9e-a116-0000daf5f7c4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
x-ms-exchange-imapappendstamp: MN2PR12MB3309.namprd12.prod.outlook.com
 (15.20.2516.000)
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-12T11:07:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b5253786-22c1-46b6-ba08-000022ace4da
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9199fd71-533b-4250-081a-08d77ef380b3
x-ms-traffictypediagnostic: MN2PR12MB3213:|MN2PR12MB3213:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3213AB35746167AD262701F1EC550@MN2PR12MB3213.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(55016002)(8936002)(52536014)(81156014)(9686003)(81166006)(8676002)(316002)(54906003)(26005)(4326008)(186003)(5660300002)(478600001)(2906002)(6862004)(76116006)(33656002)(71200400001)(6506007)(6636002)(66556008)(7696005)(66946007)(66476007)(66446008)(86362001)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3213;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wX0zjP/SmE1+msgMQo45uneTlJf7M3aUGPCl7LsaVt8a/XRkzrORBAqUO85vUQh97pW6LW9BWXCQVv1lxIua3BBqooIAFCC5MJ8RZdDPxtCgrVuvJ0RQ1f0kxnaHPktcnERnblgnW4IKfcO5sw6ErVqnFfcmcox1ePanhWE8+JptgwdfIaL4uYGirhSg1FH6poNRgQkqOrXh0mle0OC8z03viaFIcZhmmfjcj/aDTh2AGv16vDOveFX8AjszcKeeDEbhrIHgNsCyAI3fFiQpg4JcqQu5UlTyNGUXze0wGTDiClCd8wzR1sJaFtb99Ls8VDZlmhisndDw3Cs2v/1n7YMrp/Cuxp8+VZ0Z8ZFiYQL8W0x5BuV+UIj3r+p+9AcJF0Yy4ofa103wqMoBfZ7wkFD06IkQT5ivHmFCiKi+2507itRr/Dd3NQsRgGDRLZli
Content-ID: <896FBAB64527C24C930F747652E0EDCE@amdcloud.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9199fd71-533b-4250-081a-08d77ef380b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 11:07:39.5205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EUUk7KwkhQcBaLRl5//3XFz6tTdNCQT35M0Abf+NUMaSxaM1oTmcZ2BhzfZdbkHNmCDDzWqluTODS6ociqfU/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3213
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Huang,
 Shimmer" <Xinmei.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

On Thu, Dec 12, 2019 at 06:01:55PM +0800, Zhu, Changfeng wrote:
> From: changzhu <Changfeng.Zhu@amd.com>
> 
> When smu version is larger than 0x41e2b, it will load
> raven_kicker_rlc.bin.To enable gfxoff for raven_kicker_rlc.bin,it
> needs to avoid adev->pm.pp_feature &= ~PP_GFXOFF_MASK when it loads
> raven_kicker_rlc.bin.
> 
> Change-Id: I4dffa1783c9ceb5d40df9756d821e2cd7feff84d
> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ea58d0e5be4c..56a38d67a949 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1038,17 +1038,12 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  	case CHIP_VEGA20:
>  		break;
>  	case CHIP_RAVEN:
> -		/* Disable GFXOFF on original raven.  There are combinations
> -		 * of sbios and platforms that are not stable.
> -		 */

Please add comments that only enable gfxoff on raven kicker so far.


> -		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8))
> -			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -		else if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
> -			 &&((adev->gfx.rlc_fw_version != 106 &&
> -			     adev->gfx.rlc_fw_version < 531) ||
> +		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
> +			 &&((adev->gfx.rlc_fw_version < 531) ||
>  			    (adev->gfx.rlc_fw_version == 53815) ||
>  			    (adev->gfx.rlc_feature_version < 1) ||
> +			    !adev->gfx.rlc.is_rlc_v2_1)
> +			 &&(adev->pm.fw_version < 0x41e2b))

I think the if should be below:

		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
                        && adev->pm.fw_version < 0x41e2b /* not raven1 fresh */
                        || !adev->gfx.rlc.is_rlc_v2_1) /* without rlc save restore ucodes */

Thanks,
Ray

>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  
>  		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
