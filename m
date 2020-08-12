Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26672C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C622076B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 08:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ODxo2+HK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C622076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703AA6E0EB;
	Wed, 12 Aug 2020 08:49:55 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700064.outbound.protection.outlook.com [40.107.70.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2FE6E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 08:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlQRXmlPuFtHHiPppj/G9z0KzeZwswBO5uwKoTTN+V99z23VEqVUm8DjaivvLjKk5xxS6tzbAOaSpbaVFkIR8xUNni8WzXQgZ3sXheCKf2CvElyybfo4Upfyo0Bk6tVzfiXj3gX/Cx+qf0k4DQ+U1OIiJ17uOmxoyzUoDqFNZqoo9kGq2Dp92L/bXpP7bQ56M4DKYIHaW2fUsrwoBZvK7DZ0dRBVRaKCNQSysjPBxkv52cSgu3ng6rVY8oVHAhUcjFLtQcS1703YCz3P2sv198NSwHr5EF7DA6IIqm+h2oiCHpn6nK+w4DIjw2OZhSZAetuiwSj6pPm/SzIsQx40Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL/ZM8Y3UimStXjRhp/F7DQDks9VKLM76Og7Sd5P0mI=;
 b=gR6/bQj48vZvvgi4L1+EMCISFDr80An+4wHp/fO9JU2intQq88fcwA/HIPkPH7La1kO8tKuWs1C08PgebIrlQWZsytmAsJkNaaX10+7bqYrecniWMm5CtQK/a9r6hIWA6pTg7Db6bksJNJON5OGPCi3moopEP08lLaxRvTd1Pj74S3kbUBJJtERkUBHlkzP5rm7FsVioZA05nRqmaOn3skIJYP+Js5ImjWyyaU3NYVYuc7paEvdmOQQ4aUW1QHiD23kiN5DPop9AF0uu9Jz0SGwj3balGd95n5h+24ey9a3FEqZRx7a9zT9jQ3iWYcKqkOUIxGxtFPjp8ro85Pc4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL/ZM8Y3UimStXjRhp/F7DQDks9VKLM76Og7Sd5P0mI=;
 b=ODxo2+HKAAlzHvnyQH0QRtBUnn8SbosKxRERmGJoX8bAmV6/V9D++/4tt5Q+sR90LZOxMlDuehp60ooXtxZkFr+tflLvKyPswZIslZRnSQps4/IsodGc/WOHAK5bFN6LesjlJnbGxQlHueizOPszmTLnLGDXWz/FkHRXN5cLWng=
Received: from MN2PR12MB2893.namprd12.prod.outlook.com (2603:10b6:208:107::21)
 by MN2PR12MB3152.namprd12.prod.outlook.com (2603:10b6:208:ca::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Wed, 12 Aug
 2020 08:49:48 +0000
Received: from MN2PR12MB2893.namprd12.prod.outlook.com
 ([fe80::cd87:fa80:5016:d0fd]) by MN2PR12MB2893.namprd12.prod.outlook.com
 ([fe80::cd87:fa80:5016:d0fd%7]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 08:49:48 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable gfxoff for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: disable gfxoff for navy_flounder
Thread-Index: AQHWcITO4hssoZRKI0i55KcV5D/YFak0KOWQ
Date: Wed, 12 Aug 2020 08:49:48 +0000
Message-ID: <MN2PR12MB28937AA7362E8E4455F61373B0420@MN2PR12MB2893.namprd12.prod.outlook.com>
References: <20200812084422.106781-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200812084422.106781-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-12T08:49:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=66660329-caab-453a-9059-000040fd5c11;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-12T08:49:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 131875e9-e2e8-4c22-9083-0000f04657ae
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-12T08:49:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6be12abd-a378-44ce-b58a-000084054310
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42a2e302-b7b2-405f-1073-08d83e9cab6d
x-ms-traffictypediagnostic: MN2PR12MB3152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31526BC1D3C3D47CDEAB42E0B0420@MN2PR12MB3152.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lohx0xcAs6YviYUEEYlwOvVCUNE2Za2rPqZTCJy0JUn20l+XZlUoebFVkwzJTXkCjt58oI3T1XkgW0YPulWQq6Krps3ZAFTwuxt+0VataDdOg876o8FD5TxdDQtXC06+SVvuM+H5GA8g3UfTnPB/Nf3F7X98li96Y1niwyxyh8GvDzJ2qVuP2Cr7xe3Y6HiIeTqCEnCQhpca+VpF/lI+A8bM8tROEwOkwoCJp5pVuBa7OjOgx31GUhYrW1H8ysbFuxvvu+gg41dIvruALHMyhjlNfP5eS797sU1MaWaFp8mw2Ll7++TBF7OQMcaxpe2+7y1sCPPl7DTg2GLNW9vtHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2893.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(316002)(55016002)(7696005)(6506007)(2906002)(110136005)(9686003)(478600001)(26005)(54906003)(186003)(53546011)(5660300002)(8936002)(52536014)(4326008)(64756008)(33656002)(66556008)(83380400001)(8676002)(66946007)(66476007)(76116006)(66446008)(71200400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RI0Gx67Ou4vg9CgQ9vHIV3twYoeRd4ZyPhpOuKCtG7eqTdQaF0ZhQlWTbj1nzL283sf2YVNEpc0RUN3ymmtgi4WMEvXC59tNHQPaYV/kJEe8lLcMNRQhTDHh0cIpbvFVyklYPwpAReZmUA3rgFaaoAdG7cwgqjEuCnOMrIrWKi5NTbN5VuPT2lgqz6X1t9y8TbgNCrTtc7IW4faG3RheYakkiE2JUQj2s13jbXSkZZcMFnYga6zfuv/BuxC+isn2FfjFT+en6B0tyAw8IFEr9wXcyW+r4Tg+xPLVN31Bsd/PKfM8cfWASS+LwHym4k8IfamBXZghoPkyModu2vPyKgZx3a5kqgEflb3gEp0UPAdUEzQK8WVzWC2Nn/N2N4OUe5hJif+Ir/sHH2CcrXEYwe4nT8W2XvGIkh6KLQqTyVd8TUvuxeFWb43Pqzo77syqTOsZ8ZiCyDLJQtpemS/BDEYrHFojd5IBYfbNI0d6SdnS6ZiEcGR+RNLZFg8OHY/k1CEXi+3Ike4V0FqZtrQsKXeogqnu7+tnjNhWyPSp/OWoQupdJr0XKMwgze3K07hesUV08rq0RHZaNPrsaiGGs1E7RM2SxWLnkx9LlktQ0d6B6H1HrrobUHSeE5Vfh4uw05ejz4kEc99hCsiUk5qXKA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2893.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a2e302-b7b2-405f-1073-08d83e9cab6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 08:49:48.2318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aurRo0TXdPWiIq2/Csu2VgEukY31xLtaHI58EqlsKYw37XPadqiQe/Lyp0TiwjnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3152
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Please remember to revert it when root cause is found out, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Wednesday, August 12, 2020 4:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: disable gfxoff for navy_flounder
> 
> gfxoff is temporarily disabled for navy_flounder, since at present the feature has
> broken some basic amdgpu test.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Icc030370997a66fb9f01cdd4b1c45816e3c88584
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index d851fe80eaf4..de6e6de41867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3610,6 +3610,9 @@ static void gfx_v10_0_check_gfxoff_flag(struct
> amdgpu_device *adev)
>  		if (!gfx_v10_0_navi10_gfxoff_should_enable(adev))
>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  		break;
> +	case CHIP_NAVY_FLOUNDER:
> +		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +		break;
>  	default:
>  		break;
>  	}
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
