Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B689C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 03:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A4723A32
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 03:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AflbAmW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A4723A32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB516E5D5;
	Tue, 22 Sep 2020 03:39:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A426E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 03:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPK3dQ+9aO0Yb/fh1XKujL5ddVqDHnzISxUSRujLzFlYFl63dyqsV2LumVDYO8E7jzhE5XhjXAfYhfwiyMttViwhqCjdtvx7K/Egpx3r80G6DgxZnIDCLLo+p1E7QRPVC6DKIrAfQF7HfUpwutnSPdAri7pbt8muVXXOOBlvS+//aBQwhMolYwa8r+40F5io8YvVN8zPn25V72a3KIHvRTuXMpaJWUSnvfohdmI4i19iNA7OM6x9eGkA6wdIXz1bQolwNC0Xmp9xurhwY4ujzIvir+2tBiANL+uhy2XVQZ8TazKuQLfAvMCy2Lb98zug+KLqNsp6n4b2eGy0+5F1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgQCg+mbSyimxrnvhlgS4ldwYtkJRhoNvSMhAFXZ0gk=;
 b=nl/lN7sFNiyIbf3EGljJpm8JZi2TzwkH9/qj0AP+XcIjw2cDFV741dbmUZ34SHHog/571X7fW9QKmBXuB2tXpLeQAEG1Aojt5VHf+VPC264r91WKQc7IJ3QyxEMhu+p2uLxjAIAyxKRraGJZnar7mTw/z5JudQodhIHlL3bCnEPj5lQoc7F5VcjE/aMKGjMnHC/rQp0IvQtIChZYJ0dBGyVnruFGO8sJWoEkl1NGdVj6COUrPQlgudR914WNnwP10+dmyLFLlQRR+Enh04+yk5nuQS++NNxvPmNH9EdpaLxHR03lxp+pIzy3ZNH6F4n0vyjUNbCjTswQtoW89IPL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgQCg+mbSyimxrnvhlgS4ldwYtkJRhoNvSMhAFXZ0gk=;
 b=AflbAmW0g5OB5wgXwc6+kpdAX6TBd+vXd5NEJfmOXRytFKtd9g9WGBlnXtvsrE0SMMY0zcHriuRbuBl6UXNhXhv+mB0i4iM2TfU2KKrGv49sa4ChJL05G05vIjxnpJRsgYFOkMRBtNLt3qrj3x8Wwj9wlIXSqKnTCjJIAs0y3fA=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 03:39:44 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7%3]) with mapi id 15.20.3391.024; Tue, 22 Sep 2020
 03:39:44 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Topic: [PATCH] drm/amd/pm: update driver if file for sienna cichlid
Thread-Index: AQHWkI7m0DgW+B8xGUG+QwmmzZxePKl0Amjw
Date: Tue, 22 Sep 2020 03:39:44 +0000
Message-ID: <CH2PR12MB432690CE3546B625F807161AEA3B0@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200922031653.1332062-1-likun.gao@amd.com>
In-Reply-To: <20200922031653.1332062-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=55250a3b-7788-4237-b1b0-616290a08a97;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-22T03:37:58Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cff05c1-41da-467e-dfa3-08d85ea92590
x-ms-traffictypediagnostic: CH2PR12MB5004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB500451339D85AA42EF3EA764EA3B0@CH2PR12MB5004.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bj7yQo5D9tvLIp7ZxCuFpMM6L+ILg51PFeSag3qVAOEIjZ8oox9dCfMVgGeF+Q5u1uzFtm5woGVk8NkQCUFWXD/wK1JfCnpHYX3oVQsEBejEwosP13pL3VOsKb6qyjD4t3tKJNzYTnqPpJ2+ZrpLgXBDODG8BmEwN0rRiTuSEBstIQ0b1zqE2kWYF1pKhc0nmJwALlxAkgMQQ1rHbOKek8kwu3eqhKGj6FU4QH7xCt+z4wrgb3FGkkdDTfHZfOnyPQzf23mOySqbro4JSm9rMwGW9/mN75eVywSJAo08kfMzxjXhy65XQpWcJu32oOrZ9ui5mVnh4sZA8rh15zbsSInvmuW3fOZR86FyjgSnSWM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(6506007)(66446008)(53546011)(186003)(8936002)(33656002)(4326008)(26005)(7696005)(8676002)(5660300002)(76116006)(15650500001)(52536014)(55016002)(66946007)(54906003)(110136005)(86362001)(64756008)(316002)(66556008)(9686003)(71200400001)(83380400001)(45080400002)(2906002)(966005)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4dX4hbutH5MmNRZFB+xJKDbtmjPmT87ai9rygyY125jgK9+bB5b6OCKk1uZDmdJgWzm6HuBz5eAH+lIRTbUiY2jZwKyIDxHIdjegVSdWlUdT4MiLxhNovSEDZeIeKvI6L04fHB2sjgbAxHQjS6fGimfOshFeH/uiGunxkitJzDhGnIrWFs2phbz5h2BpmW6kC2irtTosXRPwgVDvw9bhDh/2+jMwtLaegMyb2pOWYsyc2DEhKLJtPheoagsGct/vdSiy4Yx+re+Q8s9hp4x/3PV02qRG9jdxwS95dcSruOzOoMpN63veai/uVkwPgd2OY30DWM/F0x16QEGmIOEYLbwqUSo1EI3JIFXgDrlqYR0OHROt2CFzSmz7AQRZylUZrYnS2+QUMGFhU3h85Nnungm3gtEOKPaU/v0JUtefDCFkM4tZIW7E243JFAjgi/+0C4GVOxPsmKlr9uwo/Rn4YvSW80qIqMm7VqdlERDh7i5oKjyulrFvQHrkO3kW9i5Ok6O1/vlpBI2PqoCnECF6yQXcihnsqAPiyUq143/slpSUENwCijALsf9zMrZuFFa5Sb73R4N3HyijWuR5+kwRzCLSLDWXQ1EavXnoyiaoS7xeh1qmx2cFHZyivmKCR4oiWxTJhhykExTzFgW4iZm4UQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cff05c1-41da-467e-dfa3-08d85ea92590
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 03:39:44.4625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1u6itEFdcT4QmxpuzJV1okkPA8pwXMk7De3xa+gxCZNAXNC0l36hT7OsmsbrX7Mau+rtA5J/fpotnBga4QSxtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun Gao
Sent: Tuesday, September 22, 2020 11:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: update driver if file for sienna cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update driver if file for sienna cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I295edda90d156c4cea742e62fab696afb6cd1366
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 4 ++--
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h                      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 11a6cf96fe0c..1275246769d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if  // any structure is changed in this file -#define SMU11_DRIVER_IF_VERSION 0x37
+#define SMU11_DRIVER_IF_VERSION 0x39

 #define PPTABLE_Sienna_Cichlid_SMU_VERSION 6

@@ -962,7 +962,7 @@ typedef struct {
   uint8_t                FanLinearPwmPoints[NUM_OD_FAN_MAX_POINTS];
   uint8_t                FanLinearTempPoints[NUM_OD_FAN_MAX_POINTS];
   uint16_t               MaxOpTemp;            // Degree Celcius
-  uint16_t               Padding_16[1];
+  int16_t                VddGfxOffset;         // in mV
   uint8_t                FanZeroRpmEnable;
   uint8_t                FanZeroRpmStopTemp;
   uint8_t                FanMode;
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 7ae83df83edb..03198d214bba 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -30,7 +30,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36  #define SMU11_DRIVER_IF_VERSION_NV12 0x36  #define SMU11_DRIVER_IF_VERSION_NV14 0x36 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x37
+#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5

 /* MP Apertures */
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CJiansong.Chen%40amd.com%7C4115b6f80f814f37ca2708d85ea606b2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637363414475722094&amp;sdata=uWsH44ChJqJxYOafJ2gMax81pjCm0hlQ1%2FKyWh4xvrE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
