Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F18C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 02:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8739923E51
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 02:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8739923E51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128CB6EC1A;
	Fri, 11 Dec 2020 02:21:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3926C6E838
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 02:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdmVuHzFfDMfbOM1AIStIJ61f3pw9miV/1JeEwHAOEIM8lFCoG7XAQXtpLnK5rdJ0QIKREL7mc4FSzsEO2gFGhNP+RwcsW1N89w8/rBJdLTc/qWyAvHHMi7wm9c0hWDCCD3OlWR4sepsfgOldtjR/gna8pS6+ulB7MWDV5fqbl51JtmlmvbEWYA/AL30PqyJFp9hEq/VhH1LXT4VKrAWLd70sN+5dqOpDcVBEJBRufxVpktPCmdh0L/vcnfuN5fRMNOCISezCeday0kGfhgJ4yqvefba0bDz84qFK/FsKcjJkWX0xpLka8CGaYgJWkWju9ZjrmUC3iC0+7WFCXCy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd4Pxy8yaKiM2E4f3DcXG1y4K4WcgjTkTUFGkSF1ujs=;
 b=T3FSJ1sZn4u3VVkNPEjkMrQqByLF6+DipGS3YSu9A8OWWj6NdmsFj+0fWcOtOK20pGLmGxjUOTuuU7iw0LVMr5iYsjB42m06q/BS4kay2y5pKJSDrrd9mXMv+eO9HR/4B9JrSX7FQjAu8wR5yBjWWekye2cZErdY2e9jWgxKXsmqlvLZZqBIH/dIuBzpTwdaOsYpw0T6K3V2cNd5NUFIuq4pfkpdiulktQ9zy9LBOX3EAorTwncju2QiI20umRlCt58d2l6+sbNE1cIWqEZdd6FqpZYD7V6EGsZ4MsEKuZCfzsgnXU3ShlTf5WYbJLQSCbMPQvHMcr5RGzs2EiJaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd4Pxy8yaKiM2E4f3DcXG1y4K4WcgjTkTUFGkSF1ujs=;
 b=ECc6EEWIaVgogHxt5z6U65aA9/gnZy4zgA1exUFhGEPf7z7Ub8ZlK5/8bEbge7Yx2+XuOezuFN5uZBRWoSff6QUvov3XOjFqANtBH1fQv7siajSWdLiSEexU2QWwh+qgkt2i553GtEIKSQkrxGyJRdcHYOPEy4xx+FRLZL0kjIo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21; Fri, 11 Dec 2020 02:21:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Fri, 11 Dec 2020
 02:21:09 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: print what method we are using for
 runtime pm
Thread-Topic: [PATCH 7/7] drm/amdgpu: print what method we are using for
 runtime pm
Thread-Index: AQHWzz3RG2HE0AVM80K06EIPEvztA6nxKf5Q
Date: Fri, 11 Dec 2020 02:21:09 +0000
Message-ID: <DM6PR12MB261994C56895FB5CFA166683E4CA0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201210214518.704305-1-alexander.deucher@amd.com>
 <20201210214518.704305-7-alexander.deucher@amd.com>
In-Reply-To: <20201210214518.704305-7-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d37b7ced-5c48-476d-b982-5cb3849cacf2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-11T02:20:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53e6217f-a3af-444d-f94b-08d89d7b6c63
x-ms-traffictypediagnostic: DM5PR1201MB0025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB002501D9ABDB2ECE323042A9E4CA0@DM5PR1201MB0025.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:356;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cn3HTYCFXUDAQlZFEo+FAgkWjwMULgwI2O//MbcOVx1Qbm7hKGDhTklCT+79OoEDsMPYO6zaDTHilVOF9shXJ2dm5v/GfqV9CCaIQ8vTyudd2T+n3wVMGSiJnn8sWaxGElCHiFvVWxBLHKnXOuAQD8H5Kf4hRA1M6MW7weh9k8FZ4pVb7F77LbYaCNjhIpDOKMt5AKo4j6STvIiumz2b73Q5GYCVGFZEbafKPsGo7IMRwM4Q0agCBDxeM8woBw/UogpDlEFtYzTfgzwCI9fypUENmfj0TR3m7P1bUd1NLHqdihz3BQOrbGqkskiPYJT6NPWDXVBD5EJUQGng20U74RMxmiGIyRDS33ax1Bu6tDQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(55016002)(110136005)(66556008)(66446008)(66476007)(64756008)(33656002)(76116006)(66946007)(26005)(6506007)(53546011)(2906002)(7696005)(186003)(83380400001)(52536014)(4326008)(508600001)(8936002)(8676002)(86362001)(9686003)(71200400001)(45080400002)(966005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JboZgpLmNXjEY3cduN8UsbvTNG0JsQxFr7KXrUGVvb9C9xwBM5QUJxiYmpA5?=
 =?us-ascii?Q?k6XQ4vijSVyG/aDjBn6dH+Izq0410hL+yPRoS1HZAaMH+HQrCOleVj7JpTKJ?=
 =?us-ascii?Q?pJTJJNdc8IKwtBiDOJuJg/Gnv/7mdrfKYREkDQjLM9MJWxgyru4jVGWdLXla?=
 =?us-ascii?Q?9Qmne6jGjKsrh5cphq50hJe6k1fRgXQ9Co1akfjM8xJWJnvB74LC0TCW/Yi2?=
 =?us-ascii?Q?EK2ks+jaqZ1YH03LasV9NjU9crUUegfmEKOIUg0eT7deh0CQH3QAVwhN7+/6?=
 =?us-ascii?Q?Xc1XtKzD8SbMHVwK7xBjYNha267pu35wchjDPgMThyaOXykZyD5ZJE6x+ecC?=
 =?us-ascii?Q?9NYn6Oj85ArnpLlxYh9CwBMxgBCnHQEANJoiY3BitqG+3aPWUUe6yk1y/Cm/?=
 =?us-ascii?Q?SbDe9w4USxud/AF7BNL2K0KlnN/S1dEr9hPGFxysvV+IfmewdZ0h/U+TzD+W?=
 =?us-ascii?Q?IBGx383VqxFkbmNTjhxRzDnvMY3prhtGOvhOqlhIsSaBJz/43SgjjeW+qon0?=
 =?us-ascii?Q?FKOJcoLEG7Yz5rzwRJsjB9o2a9V6cLSuoyBXWhHDBsv5eoJQ9UwnKsdHKou3?=
 =?us-ascii?Q?uLT27CbHRc3WH92ZTGwTlmkYAXFez+1BnOiY2/xzPrrph435QXwiZop8u6Ud?=
 =?us-ascii?Q?iQkXS8TU41K2RyyizPefo8ToUbpvDULSjKNZn8Ystugp0X0reZqS2DFkd7aj?=
 =?us-ascii?Q?x296YyDcgusSuFLj2nXOmCvhnbc7IOYS6qLxm/lOTCsxPM/GPJ07FXUNc1sg?=
 =?us-ascii?Q?dCwVfNL8sz2aOkP3vxIx/B6u0nXqn1K+7IT0pdVceYkrsOVTpsq8gxEzAMnq?=
 =?us-ascii?Q?urWtgNPI3xLJkLq6VzhEB+StsD2b10d2By60RUeesZ5XKNblkIM1vGpLE+kF?=
 =?us-ascii?Q?5OOMc8ocmBytZ7rGXS7/wonNgw+MSdy5D8Ndu7Cr8/d5mBXtEZ1NWEcX82Ru?=
 =?us-ascii?Q?1UBPL52mINPD+WZMrg0CxojSMk7bS5BHkgiEMyRvrgU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e6217f-a3af-444d-f94b-08d89d7b6c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 02:21:09.6905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYvrNdqGr/bgOl7L6+3CtX3NAeHl/66asmP1GxHsgOmXYXST7zRfeR9iLefkHdj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, December 11, 2020 5:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: print what method we are using for runtime pm

So we know when it's enabled and what method we are using.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index af049041ea3f..b16b32797624 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -163,9 +163,11 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 if (amdgpu_device_supports_atpx(dev) &&
     (amdgpu_runtime_pm != 0)) { /* enable runpm by default for atpx */
 adev->runpm = true;
+dev_info(adev->dev, "Using ATPX for runtime pm\n");
 } else if (amdgpu_device_supports_boco(dev) &&
    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 adev->runpm = true;
+dev_info(adev->dev, "Using BOCO for runtime pm\n");
 } else if (amdgpu_device_supports_baco(dev) &&
    (amdgpu_runtime_pm != 0)) {
 switch (adev->asic_type) {
@@ -187,6 +189,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 adev->runpm = true;
 break;
 }
+if (adev->runpm)
+dev_info(adev->dev, "Using BACO for runtime pm\n");
 }

 /* Call ACPI methods: require modeset init
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cefb94cd5b4444ecee0d208d89d54f281%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432335462088875%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qXcWeg5ccsPXl6lZrL9YYaQF2GyvrzjyWuvDGBbX%2BMs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
