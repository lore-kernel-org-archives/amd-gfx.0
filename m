Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D8EC352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 12:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98BA2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 12:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oWKRIyFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98BA2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A4989AEB;
	Mon, 10 Feb 2020 12:19:17 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680053.outbound.protection.outlook.com [40.107.68.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CFD989AEB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 12:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg8koM8stvX6yxpyPafvZTJW4OyKGSIs0R87tP//jw/o+eXFhtoGBZxLwkxCk6Sb0U7EmYL+kAL8wbrPbBPEy0afMPiNzYSWVek3dAzgvuLp03LPThSNcHAfVNG3EK9Rg8+/Jzdl7HP3Epm51q6TyEDhvWD/Lg0aCsyOH8yoVJnonQ2+rGH/2Qgis/yio2cVstplhyvvSwdDs5b5jkPCcDd0dlpc2Bu6wuD+6tZgMPZkJceg4DcKHj+bYNtlATxR2ZtoN03EEoSJQnEUdIxx+K1FwFYsbqT2Lf0LlUxfbKcp4ohgrF27so9pXv7nXJF1mZGkOtBXkwYOzGhJ8huoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK0uy+NskiuCZvfPV4uB87cB6tqAolmdXfphtXtgYos=;
 b=DfcGVODm8Px2wS0Z+3MKEksbOrEOk5mgaVatPmO/VKXujAuO9Csmqf5TjLFsrioEYmzpQwJ9HNw05hfz7m7mOZfzTpuUMd/eKEUFoywWXtIIVUOFgIgZZNMNjL62sOrxJXl8xCboz3bE+/nWdmPlzLwoVoHgFaFRUb63QUt7V4wQr9eP6TdqzrjnDfSVZB2dKvS6bs9vnjF70Cf0sGu9HWFMvq8wyanZUKOnrUqD0qd9qlhv+dg5YSIy+2zEg5Amf/KXfNAhH+umw/Q9wAhCzkeGJIve5QmxIxuq3OBqKeFp/I1kiBqkqLfVS2jVAVUkNWFyjquCoXq5VOBhc3LKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK0uy+NskiuCZvfPV4uB87cB6tqAolmdXfphtXtgYos=;
 b=oWKRIyFepk5ewcW4XOwS6VfjAxw+JaBxYtWY1BMCh0PA5oQRtY7l13xY55iObi/2IZv/SzmBNhS2WO6fOF/62CsSM9FzRhnMmVAjdi/xMVMaMwLVAj4S5F7ixPnGFlnI1cAUjn/J9C7u2IGCqqSuO7DtyRL/WuPOUAFl7dogaP8=
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB2959.namprd12.prod.outlook.com (20.179.81.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 12:19:12 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::f047:8e55:3d00:780a%7]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 12:19:12 +0000
From: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h
Thread-Topic: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h
Thread-Index: AQHV3+GLegjEmJOMWU6WOQt8UOPpEKgUWMvC
Date: Mon, 10 Feb 2020 12:19:12 +0000
Message-ID: <MN2PR12MB3087906523A848F8D425865C89190@MN2PR12MB3087.namprd12.prod.outlook.com>
References: <20200210071144.1038-1-evan.quan@amd.com>
In-Reply-To: <20200210071144.1038-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-10T12:19:19.813Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00730c9e-6b7a-4497-3147-08d7ae237031
x-ms-traffictypediagnostic: MN2PR12MB2959:|MN2PR12MB2959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29592395E8B24CDC0ED4A07C89190@MN2PR12MB2959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(316002)(64756008)(66946007)(76116006)(91956017)(66556008)(66476007)(66446008)(9686003)(52536014)(5660300002)(45080400002)(55016002)(478600001)(110136005)(15650500001)(966005)(8936002)(7696005)(53546011)(6506007)(33656002)(2906002)(186003)(81156014)(81166006)(8676002)(26005)(86362001)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2959;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ml5FCsReVxp7aAQ7e5qrcZXeYLDmIEidFu53mV53v+134V9lZZBZGWucZY6iwIM8EiwUtHq4awLpDE2ndZKqWLQCffQGXYVOFsF3M0/pTqJOH+ejSq2S3aA07ilUXsTSDMb0/W7v/Tjp96BRsQSpi9w+NYmIp8XNmbZ9l0EblPIPkDwj2HGSNVIkK0kfppfxQgioFjNZBxTEMYeFFYgeatm3pUjF4sD2IxyiNxEK4NEeWJ9gOwbKph9MhORBWOCIRRsW6R42D05LoFlpAjh/KBtMtbdcR8WPjlPTQNsF0UOjaJZKO3FdNdgrcFzWs8AF3JT4h7+fT6yT/FnEunzowTIMDaECuD6ILoTBr4Djo6j2sdSGZ3gI/5jVysj0J0pSk6Gxq1yluTUXjMb/O4A8nTk/DaQB9zhTmB9AgrWpkGnKxRLqw2Vb+9P+s2KlnL+nTU20iFCZMXen2X68jObAy1vE6WUeC3uZnsyB1lU0vnYVx6evZo6djap+OGe6ohK
x-ms-exchange-antispam-messagedata: VuqzHd9wE/e4rnGf+OZDxq1aVQkYc4moRwx8Z3oxsqFhKKyN5KvRAYDDQETGJFWfaM/raO7BKM84ZnBxhDjv8tmUxEKhj/bJoCUR0fyJmgYqhUSrRyB5YBlxA+Q2qBnE3pZu6V4No3pk0/Lo2wN5zA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00730c9e-6b7a-4497-3147-08d7ae237031
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 12:19:12.4475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fg5XJo0DgLQ1QJxIglKRoI6Oxe5dXm+DZ6/VNoa+DBKzZpktPkYensrPLSd9yQGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2959
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

Reviewed-by: Xiaojie Yuan <xiaojie.yuan@amd.com>

BR,
Xiaojie

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Quan <evan.quan@amd.com>
Sent: Monday, February 10, 2020 3:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan
Subject: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h

To pair the latest SMU firmwares.

Change-Id: I5262c750fa08bc6268b43e3420e110e9ee71ccf6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h | 3 ++-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h              | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
index ac0120e384be..4b2da98afcd2 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
@@ -701,7 +701,8 @@ typedef struct {
   // APCC Settings
   uint16_t     PccThresholdLow;
   uint16_t     PccThresholdHigh;
-  uint32_t     PaddingAPCC[6];  //FIXME pending SPEC
+  uint32_t     MGpuFanBoostLimitRpm;
+  uint32_t     PaddingAPCC[5];

   // Temperature Dependent Vmin
   uint16_t     VDDGFX_TVmin;       //Celcius
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index d5314d12628a..acccdf621b4e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -28,8 +28,8 @@
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
 #define SMU11_DRIVER_IF_VERSION_ARCT 0x12
-#define SMU11_DRIVER_IF_VERSION_NV10 0x33
-#define SMU11_DRIVER_IF_VERSION_NV14 0x34
+#define SMU11_DRIVER_IF_VERSION_NV10 0x35
+#define SMU11_DRIVER_IF_VERSION_NV14 0x36

 /* MP Apertures */
 #define MP0_Public                     0x03800000
--
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CXiaojie.Yuan%40amd.com%7Cbddea44f9539481f605d08d7adf8923a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637169155877244377&amp;sdata=PEuyKWEjqdg%2BKs7YyZxYD4cZH0%2Bunve1359y%2BcGPHdc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
