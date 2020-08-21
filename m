Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA8C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 08:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57EA207DA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 08:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qr7urODh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57EA207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F486E101;
	Fri, 21 Aug 2020 08:43:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690063.outbound.protection.outlook.com [40.107.69.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E406E101
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 08:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5v0d1wRx8/WrlSHmx8y4J2B4DRCtzoUKlUjcJNtuZVzbK53mk9/lVkXyuJzzO1soZ9Wc2/RhGdxH1oZUkVLJOJ8AnlUKbn1FYIxTslu6IcJuRrk09AcmWNAk+be98ZJUrxV3E0Cf618MhRxFVW2HS7QLLNhwFdzE7pl2ZDP1fsmNZYlgm6Y3gmd0sbsArRC+I2kkx1jXLiW9RholZoUpZ2MQAKn9aMQVVhByo7FWjTSTw5g0zrFLzhh+rKg1ZKiKye5703Xep7enJ2/H94fZU/9TjDD58xUYlRcdH/JgCKlXFx0oI8XNonDjVRzEaxX59JXMygY9mctTyf0QysDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGTth984yVF6uS3APeKd6zG5oPw0dPvoeUnhlsLv/JE=;
 b=eCISTrDFhN8eUKL/SRbrcJQywlXYs2BsYtSCFISBm4/vEmcretGS/MZVdvPPZYNUsutQ9Rjd0cuSiRq8BvDzTQTRVF3S+juAWw7NBkVo8MoB+/gr8RCE80ELBNda96pvhEranx3vqGwALBc96IWJzGsnxQXThXrcz8BvY3s0dUJKV6dRecKbtlRrZMVau+ptuaLEA2L3DQYDpai2PFZQh2VhuSUPUHXI7mIx9yCTIRsrl2lv4oUG4aVG8Y7eEB2tvceEO+pD0VWL9HEWN8rcD4GEgbDhNukrgbN+TayqDMspto7rTob0K5nKFFyV4GMYhF6hGe3EZUT2agc0/URxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGTth984yVF6uS3APeKd6zG5oPw0dPvoeUnhlsLv/JE=;
 b=qr7urODhpM3ScuzNZa0At1sQry9CW2DqHFUuNlZhRg8g3hJfE+hUEekL0f4PWb512cYdZ0gT/yDxawQsjSYp7vmQo4Nd5ebU/BjzigyuwaPRwn9OoCKrKyLcxuubSun/q4RxTpgg5sJnR7Yv+hyiqXgSMnqL36GgWgtwPwy3tno=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3078.namprd12.prod.outlook.com (2603:10b6:a03:a8::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 08:43:52 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 08:43:52 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: set VCN pg per instances
Thread-Topic: [PATCH] drm/amd/pm: set VCN pg per instances
Thread-Index: AQHWd5Yd36hfnpYCM0O5I0oP4i1j7qlCPsnQ
Date: Fri, 21 Aug 2020 08:43:52 +0000
Message-ID: <BYAPR12MB28888376750322521EACACAEB05B0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200821083539.9506-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200821083539.9506-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-21T08:42:51Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ce665e70-8a06-4e2d-8a12-0000945dccb8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-21T08:42:45Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d6a4086e-1016-4c9b-92ca-0000d53802ca
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-21T08:43:44Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ee1b75ef-0219-4aa5-9307-0000e3035a93
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 303d0cd2-96f8-4b8a-f9b5-08d845ae54f6
x-ms-traffictypediagnostic: BYAPR12MB3078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB307883D6B33242563958B76BB05B0@BYAPR12MB3078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OibawOr04+rVG0mX5dVVpCwh3Kq9gHXshl8bSq9CwEfebQ3oG+hM0ONVNasPJnVb3lOVLSa4mEJTY8mnrCbQA0sl0QvN70OBqjKF+yvnbeSeDxdnTxzTm2Rf0YgFQ8170UaPi522Mk9j7cUEG+DIIlQjWX72tYNI+ViTpQXKxSsc+F30aWY28g/nLePuz5ruwYf2azeSEmDOwZhqb7dQ2j3bDFYCbGNtGq+rB/QLD6ANZf2i8fAY7KtRPHrTmWTYKeD6oNsBK+1CLJUDpPn9VC/eI/SGrmT+6/M/71zL8mU90nxnY7K9dSPx2GJ8eSx+15jGOMPHDhsppkn0rXFoYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(71200400001)(66476007)(66446008)(64756008)(8676002)(52536014)(66556008)(4326008)(55016002)(53546011)(478600001)(66946007)(8936002)(76116006)(83380400001)(33656002)(186003)(7696005)(26005)(86362001)(2906002)(9686003)(110136005)(316002)(5660300002)(6506007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FvzMROjKAMPX1QS93TqfzwyHQlChKMwKksmAouerdvKnrRl6nmaPkgoEsSJ31BNylWUoCRpw9buMSH1izcXnfmQPZabvB1rYQMGwwBAxM3GdGbFWCpP7zENsLxPAregGYB9V4JNEV1tJjUnXQvTBjtA5bDxDzyItM2/uQQiwXgZS1sOwnH/YMo+NaDUl4S+ZeIFPAVGi5Ye/e2shWQO0rO0K0nRT9pJtuym+RfNa/X8ujTiizcrKK5Zuv5e8x/rtzyVfoP5Dw0wVt9tTzen2UQ+ztRM4lC6s7XB4Dle8swLpKyHTH5eJpFPc8kQtihAGDfICFrjdbmicT4JVIT/ESwoQ0oHftMkfaZbQ11YmvVTsj7yJDaZKP7oX83t8PyeJ5Yu9fKGLQUk5RZbF9eisAso6iWmw8ZHhVBp04wh+h/uAMvZjPQur2JRTw0ZvQll+HrXt8+p7oskgIp4ENBO5n65pd5JRzOjWvNicark+R8JjjwgiPzDnfaMU9fUwUCCvWkyw1y9HaY8KqyLYNbZfrYPBfZmNmqkgrYZrYn3Ftg+kQYgZ8a/LfDA5eabwauNkazy5s4MxTtifMiVbHfQUTIX4cQFMFmgvPX9oTZYVkwa8t2UoI++V1RfOXK7tfLREgQUqLxZVBIn07OSklg0fVQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303d0cd2-96f8-4b8a-f9b5-08d845ae54f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 08:43:52.2474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUZUjO5nG/EyRC4w/rMko1Hdx7KMQd5qYyebLSvxQhlZZ7OZ5n+JD77kyIGY57Mi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3078
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Chen,
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Friday, August 21, 2020 4:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
> Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: set VCN pg per instances
> 
> When deciding whether to set pg for vcn1, instances number is more generic
> than chip name.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I5bf3f024ac499c347e3ea72563ae75e4a540f321
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index d2320ce7ef0d..66d655958a78 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -783,7 +783,7 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct
> smu_context *smu, bool enabl
>  			ret = smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_PowerUpVcn, 0, NULL);
>  			if (ret)
>  				return ret;
> -			if (adev->asic_type == CHIP_SIENNA_CICHLID) {
> +			if (adev->vcn.num_vcn_inst > 1) {
>  				ret =
> smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
>  								  0x10000,
> NULL);
>  				if (ret)
> @@ -795,7 +795,7 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct
> smu_context *smu, bool enabl
>  			ret = smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_PowerDownVcn, 0, NULL);
>  			if (ret)
>  				return ret;
> -			if (adev->asic_type == CHIP_SIENNA_CICHLID) {
> +			if (adev->vcn.num_vcn_inst > 1) {
>  				ret =
> smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
>  								  0x10000,
> NULL);
>  				if (ret)
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
