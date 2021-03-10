Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD7C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6DF64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 08:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6DF64EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05896E9D7;
	Wed, 10 Mar 2021 08:28:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5396E9D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 08:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyFzfNw0zIJnAmvCUXqeCBwE0nXtlqe8dI9I6VQRsZq5rqJgOH+zuGlnSNpm05wA8zoBzjHBvLdpt+u33jhrmNLc8ESmJ7m8hmStwvh3Qx03H5xuKlw3Pgdti5tPFeBUQSLJzl8c90uqy9Kawunwch/sMkA+w4WMdC+z/3WwOtzk/imYy9uHyy4vxa0qnBWU3kKzAOIuF6uWDUnuQhZBHHzjm8svkL3AEETBf8EdAUG/pIA+HO1bnNaLp0pLfjVrUZ/S3d7x9Kf9FwvWuNx9XsXHfbwKjqolO73vyZvOqz0RFTJfZRK7EiM6dIugrBzncNa9XM2OB/mXfmURfOOyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6eaWFxCdwOl0oFhO94erv8q/yUlLFuDQtGTH/49D78=;
 b=LbQN87DLbvkq6tozWjcGpu5Vq+Xh/nQP1BhPgFB/kethpRFLUsydNHgDrmaKm6rlvZNYwQQ5oc66AbYlrxQYNRNwzaoQcOl/4zDbwzfRVSfE0yoOV8UHOoGC2Ig6y2pjJ9FAHiMPa/mOzSmYtkFnU2aNeSXoqrqbVx2I+uuHOJClMUxl7ha/ZPUakXqZZ2fDIp+XHdkHJSyYEJY8UIG7JhtSGNlhL9DltsImmY59WRU4G0CB1G5DGafZfO7E3suJ5Gyqbi/mHh6cwj+mmCvmDcj5btNfN50yxTUjp1nSoMlr/Qbl9uwYMQIb1xHW+Fn8V84iB8S49YFIVPgJQ4kHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6eaWFxCdwOl0oFhO94erv8q/yUlLFuDQtGTH/49D78=;
 b=If9D1IDe6WyCcMQv3HHhW9g0yG9QQdfQEz68mKdjYRFwLpwZiqr2bSYHhgWBBdQ0wIdkzIxu9dJ3v9eW/pWeKaItHfUNmsQqevi2MZy4BmTwYjbl4GQDWO6+5zDuyZ0BaBfqzUSVxdlfXKNdJgkoYhACGI/2b3hnlZHOa1cOiTg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.30; Wed, 10 Mar 2021 08:28:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 08:28:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/7] drm/amdgpu: add a dev_pm_ops prepare callback (v2)
Thread-Topic: [PATCH 1/7] drm/amdgpu: add a dev_pm_ops prepare callback (v2)
Thread-Index: AQHXFJop3OnRK41u9UKch1oAG+ZMfap8486Q
Date: Wed, 10 Mar 2021 08:28:14 +0000
Message-ID: <DM6PR12MB261994790980D477F1E8A70EE4919@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
In-Reply-To: <20210309041012.23367-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T08:28:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2f63e9fc-0fdf-4640-bcd0-1b8afb31b4d8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9e31ceb-726e-44ff-fc9b-08d8e39e72e7
x-ms-traffictypediagnostic: DM5PR1201MB0219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0219E580C561AE4E05FFB948E4919@DM5PR1201MB0219.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykxRpCxr3qMxINAU6AloGcjA+ZTh8PATzZ24EzT+Bh5i36ZoNefjGJ2f9AQ4tRych7/TeWjGvxXyYjCgCKVUTE6/Tpj0grOuo32fyOj8LJdE9eb24E7cw1IkIOXH1z0FcL+qP6v/LwkhrdtMddsmuArvXCgpq5KjSG3KIv2blVE71CiPQcfpSqpjdioxEAR0xyDFmG/ZOIFZ+gFEo/EjOnfHbca9mfaKgik0Y/Qo9OGjrII8lkzhrtreNOxMNcdJw5jDz5KuhT0tdV9mYVuZRSwsJtxtGHuxm83gCeZqOKzQcElfT7Yv3r3tIGQf+BrSFaMYFteJDhYdG+xOOcyc6xidHmNBSCC3SHDJ0t17GDARDYdEYpSL4AVppU1uF6JtlBQGRKXFRDGZ8HXFE2v//cRg5Yx+utWU1IbcuKDImYCFKcWWgAE/LfbclKNSeaJaynsJM844ct1ni4heughIf1HFPzqMXM2JasMqgyMUe/QwOGFdMJuq+vwuOeWizy8oiN1KvF5CS8tHu+MXd+5XUNu4p5ITHSDDdGDaEcmDsM6pqieuRxTbp87We/NoJalq21w1UNLo9uApRF9fljgZmnkNdxkebs4kRoB0gBUpf9Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(26005)(2906002)(33656002)(186003)(71200400001)(8676002)(478600001)(966005)(86362001)(52536014)(8936002)(66476007)(76116006)(64756008)(66946007)(66556008)(66446008)(45080400002)(6506007)(53546011)(4326008)(7696005)(5660300002)(316002)(110136005)(9686003)(55016002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ecn3LE30XRZysD6lAhkckaYbs5oD8XrDMQlZa9EVSSPYJdoDRRoGT95QaQq7?=
 =?us-ascii?Q?upI8ZFwBFun5yaxI1UEV/9F5RjKDi5zMS1S2zhJvOlWv7t5fkaQFkC6seEtn?=
 =?us-ascii?Q?zjPnIhcu4S0mq99vitdiFlB1KPKXnzwkQoRBILlQNx+bdWTbVHlzPDyqfMVk?=
 =?us-ascii?Q?qPt/rJJJDc4e4n0bITGLz5Q6tTSL+zHY+FLvKrkiFgAniMQUgYw16/8ERT2k?=
 =?us-ascii?Q?CSQr4o0laULdgMCv2KrCm2ZcobUW21xRVZhbnh1Epqfe57p3OroZb4gysbO7?=
 =?us-ascii?Q?yXN5Ac6Z1bHRhvLRVAxjI1ftR/9o3c7nGHSIT1s6Wuj0X/rTLHeOMFvWzmXA?=
 =?us-ascii?Q?dJz2opATSFshrq01cYYg9VVJj0jhg/Ytcq4//GID9UXdAbgKMndDsYCpbiCD?=
 =?us-ascii?Q?4q29Qwsuaa2b4OXq9LHFg0Nan63xa1yfntRm6y/5qNVwnT2OwHgIGm8LJMSz?=
 =?us-ascii?Q?HnxYfzGR5ds9GD+Aq0OlRJuQ86Bh7tlIvw2IVr1EVhAULbgSMZbcMDYgrFUO?=
 =?us-ascii?Q?kxNgGxtPUKOtcP6Nulc1kz6CHOPOo4POxOSW/CTgg0TZbACc2V/DNg2bkF25?=
 =?us-ascii?Q?KtkUEvftBpC5tKu7Li01ziAWrcqi72EqhT3keOOsyM5kwnojkDnE+fEeCoEd?=
 =?us-ascii?Q?jUCfv5DXDlESEVBhU9WNi4NMLQeuVTJmOdxW4TRBZ3BfN6vfBWZ9Ouvsw3y5?=
 =?us-ascii?Q?tsy2Zryokl0RsB6PIEYPP0dU4sPvboJEn2ISyKbtiQaUrZqMAOQKbOGF3KWl?=
 =?us-ascii?Q?x3ZA5htqVrpEc9DY1hHrCuWsV41fjGcjSL387XTQ2AktVLli3Dpb2v88+K8n?=
 =?us-ascii?Q?yew6NbR3qw678nUc4rZ7BcS18Cr4WimaFyB1DTO5wRXoEX+w4tTXxVegtT/u?=
 =?us-ascii?Q?Js6le/gay/bvFg+gEocs0IJTdQKXXrDYT5IVpme6K8rjr3ubvQm+go/RSuoI?=
 =?us-ascii?Q?K/gmob4H3JdnSPoxM/QbXwJHToz7NDrdEakdP1ZN3GYtmMVvqA2YQHgNKdnB?=
 =?us-ascii?Q?4JAxdVSE+CJhD54SgMvbiAxsvG8I7RkJbF1KBt8AJNzJWWxap8tWHOiyCjzQ?=
 =?us-ascii?Q?935d+RER4CAp9XmAjWE+pQjMn2hL1OlADvTtBoBtuANjs7ISOgrfTm5B5HpS?=
 =?us-ascii?Q?gLkifdXZqZbyK7WVe36IgYYedVhdEY1RmYJstWjXa2w5BakgcM3zAawq7f47?=
 =?us-ascii?Q?IN2AqiR4sWqFlh9UM+yFT9Z3fKjU+3xUnA2VeGiz8O2O+BqhZMk0EqTDdu+3?=
 =?us-ascii?Q?lKl//FnxJoFyWQsqs4DkNL66MZDxFS6utROYDMXWvcZQHPCx3+J4NSXjgpqA?=
 =?us-ascii?Q?F28qeQdh133D2TiOKyLctXEW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e31ceb-726e-44ff-fc9b-08d8e39e72e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:28:14.3719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9kE7sadLMASTFfSshFW5kg2LytAPGgHc4pSRxO9kIdlQFIs/BoZuKTXUlePAby0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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

[AMD Public Use]

Hi Alex,

By checking the document and source code of pci_pm_prepare(), it seems the prepare callback provided by device driver is optional, not must.
- even without the prepare callback provide by device driver, the ->prepare of subsystem/bus can still return positive number(1)
- the result of  the prepare callback provide by device driver may be not honored unless DPM_FLAG_SMART_PREPARE is set.

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, March 9, 2021 12:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add a dev_pm_ops prepare callback (v2)

as per:
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fdriver-api%2Fpm%2Fdevices.html&amp;data=04%7C01%7Cevan.quan%40amd.com%7C6e3b5c960f1145c79e1c08d8e2b14a95%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508598383549752%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=hLOdKKeO7JMk5kU5gmYSrBD53LhsT8vtEH3UivKjx48%3D&amp;reserved=0

The prepare callback is required to support the DPM_FLAG_SMART_SUSPEND driver flag.  This allows runtime pm to auto complete when the system goes into suspend avoiding a wake up on suspend and on resume.
Apply this for hybrid gfx and BOCO systems where d3cold is provided by the ACPI platform.

v2: check if device is runtime suspended in prepare.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index aecf7baf219a..8d4fbee01011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -36,6 +36,7 @@
 #include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
+#include <linux/suspend.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1293,6 +1294,27 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	adev->mp1_state = PP_MP1_STATE_NONE;
 }
 
+static int amdgpu_pmops_prepare(struct device *dev) {
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	/* Return a positive number here so
+	 * DPM_FLAG_SMART_SUSPEND works properly
+	 */
+	if ((amdgpu_device_supports_atpx(drm_dev) &&
+	    amdgpu_is_atpx_hybrid()) ||
+	    amdgpu_device_supports_boco(drm_dev))
+		return pm_runtime_suspended(dev) &&
+			pm_suspend_via_firmware();
+
+	return 0;
+}
+
+static void amdgpu_pmops_complete(struct device *dev) {
+	/* nothing to do */
+}
+
 static int amdgpu_pmops_suspend(struct device *dev)  {
 	struct drm_device *drm_dev = dev_get_drvdata(dev); @@ -1511,6 +1533,8 @@ long amdgpu_drm_ioctl(struct file *filp,  }
 
 static const struct dev_pm_ops amdgpu_pm_ops = {
+	.prepare = amdgpu_pmops_prepare,
+	.complete = amdgpu_pmops_complete,
 	.suspend = amdgpu_pmops_suspend,
 	.resume = amdgpu_pmops_resume,
 	.freeze = amdgpu_pmops_freeze,
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C6e3b5c960f1145c79e1c08d8e2b14a95%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508598383559745%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6PfggZhs61N3RO6DKAODOOfKappXUnswvHRXgSHJ%2FtA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
