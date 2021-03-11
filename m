Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28119C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 09:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B7464FB0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 09:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B7464FB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343F46E12E;
	Thu, 11 Mar 2021 09:19:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 141906E12E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 09:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABkbrr7jm9y4MRj/4shhyq/MdXYtWCJb90FcLLIRrs5LbAgnNT+2KHvK8AS340INQcSMcfdjycW470DDn15HzktaxqlVZDm+I1aTgJ6DqjdlQlVt+8s80FKaFnFGghflBzrDOfCKOaUrEBvbkOq8itV350JFPj79I4WgIrBGHcGwbJ0NiE3xrW9PHue9cH3GUid17AMNblGn70/Ptf9ecuxhQE8mRy6Mjb1siMErdQ980d6XyQCWhq9pC6vcHdPIWpPyNFoNpxj2fAtQBDzTGDaZXhmtImM3JybTQQYDT11ga1dubftcclQszajnNglda3zhG2iDyXnDwb697/StFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0Fkn1bt6A0ZqfdKz9bVG34Zqow+RXc9ssSDlxilAog=;
 b=kIcKqSKtNhOF7pkZcz5xB484odiKn9YrwYeq8PWjynHbGXuPp3D68MWJq0O8e9bKSXleY9CZ8F5uTlnjnrTHyzIpEHg+GJ7pGkrdbPcawPp5DNDcbdmqmGbnZzQ6FzdMDu/Mek4oBsuFomIs7Q5F2SYVATNNI5+OHP+gDo/SOXzRkUUCGqTVkYbuUvNISJeRRem+VmmcRe37AkD3gb4dGSuK3TX0qSUr6ctsdxkgjg8zmq8QEejF5477sGcdCo0rkY3pN5xqVvntlRHJJnWc+KzTeSyAs0NzL24oDizOp7OzQrlRfKJSNXeuKHozhFNsvyeCy2losOPAt7pemeQT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0Fkn1bt6A0ZqfdKz9bVG34Zqow+RXc9ssSDlxilAog=;
 b=HSfT+VWyh6YguWopN9/YdI6kjbttr9CN7SAaz7ffrBg7c5BhCgC/urPVSQmMrMCn6QuR7SjAn5RvRJtZVtZXQuKuDr5IZ5Y5LDHDuWxTW/j1VLXyo2dU/lJNkbTIQuDgOsmgCwTPLqy9ASCOpj5XiU1cD709Qw1q0ZlsHCYyBgs=
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1374.namprd12.prod.outlook.com (2603:10b6:300:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 09:19:14 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.3912.028; Thu, 11 Mar 2021
 09:19:14 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update secure display TA header
Thread-Topic: [PATCH] drm/amdgpu: update secure display TA header
Thread-Index: AQHXFJAd988bL5v8Ck+DK19X+jJEZ6p+hepw
Date: Thu, 11 Mar 2021 09:19:14 +0000
Message-ID: <MWHPR12MB1248FFC63E48097EDB579235EC909@MWHPR12MB1248.namprd12.prod.outlook.com>
References: <20210309025825.1267-1-Jinzhou.Su@amd.com>
In-Reply-To: <20210309025825.1267-1-Jinzhou.Su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-11T09:19:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0e3baf1c-bec5-4cf5-bf56-5fd79755207f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a309fdb9-59f0-4fa4-5bb3-08d8e46ebd58
x-ms-traffictypediagnostic: MWHPR12MB1374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1374B870CA724AD21F5932E9EC909@MWHPR12MB1374.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:24;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19eMENiMbAJmOSHOH/5Z4j9tjN79eTJv07rG9x44buzH48g9S/O3y29aKPVjQm1ZFXcz56n8LDuUCOMXBs7psSagClZula4up6Dub4UakqZE9S0wyfRRj1n/x2Lfy3Lz6qj1RrGBE2pwTCUWQ3MFFnUUq3i0d/IDbpOar4tzIZA+LuSJS2BX8Iwsg4oGg1Sf/gkH7ktMyi2QAIbgyjZR4vcRveLFv6gSk8/s3R164cQHzkcLvc3cEThP3sJbXPHHm74HXY7Haeorjpbw6/TctS8Byb0dPD9VrRR2PomgWXdM2DGY0cR4EthXtHwREiX9fArstEmEzcAb332pto86mBdLp+QVeUxW0Y2EjkEBuL8qWhqBtuzOld62ZHL6wedGlkRVz/+Qov+QtnqfdOq+2Y4TmWnGUxO+1JhcnWFvRJRfNd5EYF8AdBMUjwm1iZiucF7pxTC0hO3Jp78rkUslEjy2Ww7HlcRsMq2Uy6Jk3clyKtnVaV/cG2uzWDUjhZf/IBQd7LP0ZAOo/9bfOuh6R3nxPlC/fliOUS2lWZHaumq3KNcO4BEEAmxjuuBWQu5J
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(66556008)(64756008)(76116006)(66946007)(7696005)(66446008)(66476007)(186003)(83380400001)(6506007)(33656002)(53546011)(52536014)(110136005)(316002)(5660300002)(8676002)(478600001)(71200400001)(86362001)(8936002)(26005)(55016002)(9686003)(2906002)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4lgDKIfp7NiViYJBWl+t49I2exDqeNK3POio/CZmDac3kXoQma2vwCriIDaS?=
 =?us-ascii?Q?6XJyaYsiY+R1fd/nX8C6N6UOGLUg4LVukzlPsTAWO/ZsiwaSyJgIIMa1m3rY?=
 =?us-ascii?Q?7f1kFutjTd48EQL/kIOCNMqJD0Cn8r7oaPzfRL+8sv2etlN11fEQmLCbMx8N?=
 =?us-ascii?Q?oNBXfx1fJ8Nmorb7Y9LPh/WCZe0TfV0aTpUe0EEkLZ7fctp+N656NQeNgbPd?=
 =?us-ascii?Q?oiHEw2qsaXpdxU7lN64loDbrYQCBqxnqLwuoHgUGDU6AxES4DdWl3mULRDcR?=
 =?us-ascii?Q?MULFPhrilc+pkWFv8Hl88YWZ7cMtKXQM6yFwaLA/4xMVmhfDdpIgs/rHG/vo?=
 =?us-ascii?Q?lPenJd+Ee+P0l+WMjdC1n+Mj4kBos5RmgE3djoBscrk8nEl3J/Hzs+1o1hhW?=
 =?us-ascii?Q?rsAq+vUNh72j3YrqSdar5UoMn31jodnW1GM3X0Y9LPVsohih2f6jxS5eA7Os?=
 =?us-ascii?Q?A2owtnnp0AIsw1l307Y0/2SSSJaL7GKjUvRJe4fedObcAn1xOjQALUYnTljS?=
 =?us-ascii?Q?IP8AduURzKrQ34THLGtVc71iPfYk5s3ZNjKpvWtxsnmOIjC4g8uFnSJfQwqA?=
 =?us-ascii?Q?pvYS8rlvQ9KwzLOyItwT8+O9u/YWlHOLNJWGVajIO7qWHaS/z110S8Btiaeh?=
 =?us-ascii?Q?Kh76jNIp00gkrozwZ6Ifr56rb5K4vKrkbBlFpKcutYqRphqPMfPsHv/6MyW/?=
 =?us-ascii?Q?Sf9yjhFgOLIVae2E4cufwJN4E4PcOaj0PiX0dKtO+vVeqbn5WfeV5b9Yi/rO?=
 =?us-ascii?Q?62byjIrwzCZazQXyuhYriJV3EU+n0pHdHSbrHqkE/poanE2bxFdsedLtWEzi?=
 =?us-ascii?Q?z0yNXu/TRWb2Wv/ltP8SvRbOGZc18d5abWpSy3sR8TgLI7r261+4g4PQYCe5?=
 =?us-ascii?Q?Vzvjz7DvmYFl6SPFGkrgLdp5Xp0dCsS+UnR3VPQ27vG/CfjdrlKa7P+AW1Mr?=
 =?us-ascii?Q?9lF8KQTH4rqNQXRBcYvR7aeqAV/a+K/M6HUA5IdqDMs5W9GIvcJ2ufRTMq8P?=
 =?us-ascii?Q?03C1DXY/i4cbe38wfLBz84F9Qav22VNU89DsxDIECCIbsZampgKYFeQLLFpl?=
 =?us-ascii?Q?mkQweY/zT6GWDksSx48VT6KGQGdwL6yuB6Lb+Yy4cCaeS+2CEAr7ZI72cy75?=
 =?us-ascii?Q?aTPaOXXgV3xeQe1r36CvTB9OU8ZdjSlxLG4T3VjtJcOuEXfpRhfYnnLjsnBe?=
 =?us-ascii?Q?XLyRXJgN2Ea2Bg9x+2pRpXESseJUAAqWogs/42LmXyuHrlC7EW3Bha35eE1P?=
 =?us-ascii?Q?bhxeaIzGqeZ2IFTq+7v4twmyvobDRqVzFw+DsRt7zl+gP3u216zLa4Uowt0i?=
 =?us-ascii?Q?gIuUAUBKKv0YxHV3PHOwZmv9?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a309fdb9-59f0-4fa4-5bb3-08d8e46ebd58
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 09:19:14.6415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHot6BnRxm95jupaXHO8LAXxsG+ElBg2/2Sl+bMk3KGTWhaUK+LHVsjkRUcebcJG9NpE8LXM4qHguNe1wG/B4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1374
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

[AMD Public Use]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com> 
Sent: Tuesday, March 9, 2021 10:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
Subject: [PATCH] drm/amdgpu: update secure display TA header

update secure display TA header file.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 +++  drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 834440ab9ff7..9cf856c94f94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -69,6 +69,9 @@ void psp_securedisplay_parse_resp_status(struct psp_context *psp,
 	case TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR:
 		dev_err(psp->adev->dev, "Secure display: Failed to Read CRC");
 		break;
+	case TA_SECUREDISPLAY_STATUS__I2C_INIT_ERROR:
+		dev_err(psp->adev->dev, "Secure display: Failed to initialize I2C.");
+		break;
 	default:
 		dev_err(psp->adev->dev, "Secure display: Failed to parse status: %d\n", status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
index 5039375bb1d4..cf8ff064dc72 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
@@ -50,6 +50,7 @@ enum ta_securedisplay_status {
 	TA_SECUREDISPLAY_STATUS__I2C_WRITE_ERROR         = 0x04,         /* Fail to Write to I2C */
 	TA_SECUREDISPLAY_STATUS__READ_DIO_SCRATCH_ERROR  = 0x05, /*Fail Read DIO Scratch Register*/
 	TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR          = 0x06,         /* Fail to Read CRC*/
+	TA_SECUREDISPLAY_STATUS__I2C_INIT_ERROR          = 0x07,     /* Failed to initialize I2C */
 
 	TA_SECUREDISPLAY_STATUS__MAX                     = 0x7FFFFFFF,/* Maximum Value for status*/
 };
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
