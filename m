Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A81C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E55207EA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 09:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AfjvSSB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E55207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3382A6E8D8;
	Thu, 10 Sep 2020 09:38:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7ADE6E8D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 09:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT8h6LviDs7dAzt75JltZuiw+x3fW2qZTLaRpdIXypqM9frlAjTPBRfyx2f16V40qg2blct7yP5DB614bsqgs77d/ohOaXqQkqSCd30IYJQp8j5D2h6OejMzwXD8ZX1YgqmGF9DQ4cg/03zL8WYOZR1YHHTaMAlRtW48X4r+oBx9UJFGKcJVJzzyOBzq5mytWAleuS1YgwvVtceLGW0z0CyykXSB4xzWXXxe2fE2Au7lxEqXvNrCfXnuRXBIGHQhSkR69wGR+TbG4KDTy8KRgNHFf8W9hMV/ItSqRwJ/j60iZKHn5sTBbWpqP79160GbXdO3AolSoeAA3pRmRwrWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylMA6U6+y9oWnkXbXHV4JFhepQbEq6iSkAA5OBNxcGg=;
 b=Ys43wNynQiAj81hocSFw1XXkg8p8V/hOJo0yq7tioyetZFuXGa6G/AUpM1g3gvxfwM8U2TF07+aiGaE95faj0HDmIYO7DG3aRhMifOUVTQo89mReNNxuoOYpKKr6UW0Y4FKrmA/qzaumxn3Dey3kpqHWi68f8RXD3So3pVLRhdE0xuJX/EqnRd1Mi0jmIRYCrpqPIHratOSr83r/UUViaUSPi36dx/YLqEO35QCIA/+Rq3feHcl3RC0dgoOEi+0mSkztpDreBXzlKN8pAuYA7m4U8DrLFYaGBojpGVoHMcPms/i5wdhQ03stcDBh0uh65aX51CcHGWU9mC717JmQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylMA6U6+y9oWnkXbXHV4JFhepQbEq6iSkAA5OBNxcGg=;
 b=AfjvSSB/WnNqecDA85QxbWEmqPvhg5gxbqu68wlyGDQahlqdY6ULspTAkG/VsyDFKjhXO9tO46uUDz+Jk4BXp2AQA9zNHUH5KaY7Iw+pb2dlhWFmnKXvv02xXafXdxkbU5OoYZJmr1Ap3B/H4R6EHhFCZwOYDltpfLwFeiAQ0/8=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB2870.namprd12.prod.outlook.com (2603:10b6:a03:12d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 09:38:53 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 09:38:53 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Topic: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Thread-Index: AQHWh1RfMQHD9sQB2Ui07HzonZIBmqlhnYlw
Date: Thu, 10 Sep 2020 09:38:53 +0000
Message-ID: <BYAPR12MB288875C22047BDC98844499FB0270@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200910092535.4326-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200910092535.4326-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-10T09:38:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=20a82f56-f18b-4cdb-a67e-00001cb46701;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-10T09:38:29Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 62b0de33-def0-4b22-bb53-0000ccccf25e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-10T09:38:45Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1640c9fc-7ec0-40ce-a6dd-0000803ac308
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 32725fa3-82d7-4cd0-22e4-08d8556d54f9
x-ms-traffictypediagnostic: BYAPR12MB2870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2870EB1D7E1FDF3E99553FE0B0270@BYAPR12MB2870.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DodbDuOw0Vh4qJm+kU/W2TmRhTx7Bl+ewdCv4N5cH7sRxUBQhMVYFf+wGCBHn+bmZqnoE8+PUIDh7tniiaPeJAZMYjLc1Rgf6/TxogLRsvu3uJN+ujAXvyDlwpcSH62cTNwdludnmQspHL5AdOUCv+ehgNAUX8vX5CWzzKXQjQeWVgA/yzOleVo+/qq97CJhcE5fXTei6316Qd/MNpZZObu4flx58E/ZtL/Tzgj+Di97dmpAQBfuMGHj82vohZb1ZP5cp420BaN/OpbBnkgOry1fbLHX0YiPaHR+ZKMVlKM4kwLgZN2bRx6gv7g4hSVdWyyU6R+DzPjT6UNBu3a6sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(8936002)(5660300002)(7696005)(66556008)(66476007)(64756008)(76116006)(66446008)(2906002)(55016002)(71200400001)(53546011)(52536014)(9686003)(6506007)(4326008)(86362001)(26005)(186003)(33656002)(66946007)(110136005)(83380400001)(316002)(15650500001)(8676002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tKMXH+XvagBS298hn+o50coRQ9qD3boK9OOcIr2w5EHe139ymaarLkTAaIo06KgwO9sWRRA8dMtioBtg67eJwt9yrdo9dmI9cgXFEIR9HUXISn/4SV0AIO6I6RH/4sc5gqP8HIKZRpkORTpzW0m3mUBGOc+AzdZYL90MoeD8mP6t1O9LNuOLFk4Df10PPdZhACVbFip+6vflX2gnZwGSzzpvU6S4iZ9D58YeBLYFQYqjecXxhCuS4uvySFujIuxAaOHMInk75aa7q5tL1KO0Vyxfh5Dq0MBOnupfS4pklOyAjOeOho213BdPGNjlAe5pw/6d4LIoxGu0YHMPpOtowQK+1+9gV00cb04Kj1JyZbPLhhX988f1fmz72zX/pHPBwi37uRcxIoPv4FuU+TjswIiEGg+TfR2cVZp21qTxNlA1fx1Ht2V9FpHvmkvKITnuKRtGrZfS3pEba8abiE/8dqvRAU6reieDNYDInQegHK9tmTEaTGA+30JRaiepTFXG3cJk5fPtNTFWafg/7wk8//zeL0UuBdg5FnadABOQm2JSVQs/pP0SKq9yx4fxL9M13TkZNjbEVTFxpxqInF50fXfrNJuZZ2c7CRjW/I0xwn6MeCgY13gzLasmlsd5Px2NJz7gV2N02yBPa68CqD7K9w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32725fa3-82d7-4cd0-22e4-08d8556d54f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 09:38:53.7775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymcGFGXy32G8vJzsM2DScalF66fCg1S2+Pz4WPTfjXwt1cZby4yfDDjo5dl62Py7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2870
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Thursday, September 10, 2020 5:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
> 
> It's in accordance with pmfw 65.8.0 for navy_flounder.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Iddb07c2123c0fd5dedff68f9a3a2f43685600117
> ---
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 1f9575a4dfe7..21d65d20e569 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -31,7 +31,7 @@
>  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define
> SMU11_DRIVER_IF_VERSION_NV14 0x36  #define
> SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35 -#define
> SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4
> +#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
> 
>  /* MP Apertures */
>  #define MP0_Public			0x03800000
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
