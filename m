Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E5AC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B24F20665
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gg4rFzn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B24F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE7B96E37F;
	Tue, 25 Aug 2020 14:24:37 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700041.outbound.protection.outlook.com [40.107.70.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57936E37F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 14:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k95kzpUk3mOpWwUOsiyv/EQK4UM64Ur/jQ7rStMkLcNuWF7U+EywYKVBqO+avBvpdY7yPHb2myFtbaaY/oHGMM78pBHwMx/MC21MfPA2zdsbaxIy9mg76jwcbbPZksTMkcACFTWeufv5yWb04AF1AcM8MdSyvBbDB8A9BpYIA9AoUjgvnYaFOtKK4gtjgy9EMtliA0ePx5q7BIfuT58xjxhmzdPqZlZkSXTewKnARGwNbPynVykCKBJPUMV3gzRkwg6F1qL6GmloD/04mNxqejmY7/zchaivTKyPly8MzvpgOeiI3VQWk22NWM4BPFK3xfPWwgP1OsaK9GonZbPbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLxAzXNMTPDt8i8lTsfXOwZU4FmYx0DrkatiLSCQh1I=;
 b=l9gby1mYLCzN/Y6tMxI7/wwG1K6GDvCBfmMaUatfMg4vsWWxV5aM2XsWBL4ynBGArsY9v0H4wty4JM1s8+9EnBCqfZPVh+H900lG6V/uRUK/NXdH2UhF+Ldb1g9CPMhIwPqTK5GI4Ocel0OhiVW8P9legMNvxxPO0kK21u3hcgeePCmIyEg0AXz6gj9AAzvm94HdZe6reKWZGbFdmsOaQ9xhxnQygxZLCy93Jn2tGJWsdR6qJUJZaaXAHVruSpchuWHRbOtUErKm7Uo9p2SPJ0FgjzrZ9TjzBuRhb9DP6yLSaYdzQ0csVj30ctK070h5nTGm0MP0i6dLSAa/N8rb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLxAzXNMTPDt8i8lTsfXOwZU4FmYx0DrkatiLSCQh1I=;
 b=gg4rFzn3Rt/eYQk7b0a4GQMhWrbmEW97fgVjh5ba/wRbfzcEV/wFfTqi+LnTB9SZYW/hoZsYJ0olaGjwJ0ttFVEsNwC/dZjPNpEDXjxfx9Z7RUmnXZ9o9PHyoYhPTC83FlMDnY2fr6+YD/slpuSSLrAtjEgS6aJLWwdLpzwswHs=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 25 Aug
 2020 14:24:34 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 14:24:33 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report DC not supported if virtual display is
 enabled (v2)
Thread-Topic: [PATCH] drm/amdgpu: report DC not supported if virtual display
 is enabled (v2)
Thread-Index: AQHWeuqY25oyqCOWaEeoTUdQxYcavalI4J+g
Date: Tue, 25 Aug 2020 14:24:33 +0000
Message-ID: <CY4PR12MB12872A43F638E6E751E0A368F1570@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200825141808.300152-1-alexander.deucher@amd.com>
In-Reply-To: <20200825141808.300152-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-25T14:23:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b37db382-b37c-4271-9f50-000093ed1bae;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-25T14:24:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4d07b56f-1fa2-4e95-b5b3-0000ad793e2a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [116.227.81.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06c66e9d-1b52-4697-759c-08d8490296a8
x-ms-traffictypediagnostic: CY4PR12MB1750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB175020DEB4292FF7EE13B04BF1570@CY4PR12MB1750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lesSH6Clqo18gly/dvf1ceCWGr8PPGa/AjovEQh4V2CXYzxRN80VF2kfw/+HvKWMYryVHib7rT/1UlcQv3AehHxE7uQWCy4Q5skfmztBKwhpojeyAfR+r/xIR9G+kaQqTzCr4Q9S1O/9OSUYtl7nk9COsTmfVcFVNmk1rigsb3TLvrmn/luv3ebr85jQ/Py0IARQymhu/liifgbQ7Ax/bAyK68x50ePUok3HsVwpqQt9iARVon5Ptp/AJhcsjmqeLjTZhrN3dpNsBwwaYzxfk0QuhmS1oHKiD70zByAFEZSSF9552Ivlp2yW0aji1nPkVO6T0GNPNDd1fquOHuQMs+ucZGCaa63SrKZonICSnb4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(83380400001)(52536014)(2906002)(5660300002)(478600001)(966005)(71200400001)(4326008)(55016002)(9686003)(66476007)(76116006)(64756008)(66556008)(66446008)(66946007)(86362001)(45080400002)(186003)(8676002)(53546011)(33656002)(8936002)(110136005)(26005)(6506007)(7696005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PbN4mgl9dSvGU6ArpeJkpxFjPf9g+80Ydo7iDpi0DcjbB/iBkgJ9V6GxQZsGEH5an1N4cGVkgI8DhD6GtDtDEb8wPmogfHzyCKTAJBAgHJjziRJNPqVQr9K9TS2Sy1MMfK6SghWwQcC9EtDq+PY3/VXW8YZU5eUiUgjpf8EpSy92P5Cvp9sVFJkDzSDJV/ZvA83aQF34xEhp9iKJMsJFhP7YmNOXU8+QBgHGwUGOnjOxzSMmcv12+xYHtZ4RFPpTxVvgmNlvxrVCsfCvLIhz4p2IY8C7ICL9gzJlhb2WESvoZFaVKHCVsrwlHZfjhcoqixygnNfo6pl4cC86e7P2SAFiys9uYkm/rNWU+wH1yM1aVq2E7avrf0vfF1TYphkLhYbMN1JFJmsMbVIWnUsxXadWnZxq1MF1AOtkPCFdqo4PFP7OLRe77ZKX7O9Ni+7Vd99edLNOHtV8XgnkCKUq3X1X2NF74WjbS4mynxsjjLbZUb42Uqabin2xyZVqIoFCx0PueOQEZuY/xhREKUFjvA6B25KWHtW/vVA+sk5Snb5LSp2pxnTw7D183LzYN9humNhxjKgFNkNPJbBUaLb7/RYXGtkDeTbRw4lqVtSlAPZh+Brkj4s52Y3W9vU9oC+6VIl0xxeYgugEwLE1D2aSxA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c66e9d-1b52-4697-759c-08d8490296a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 14:24:33.7710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSCSjLpSACRPa1FoCYA/zxvhcNqQ1p2B7gzLqGREBgf/NJ3KdCnKe7hCzpcoEaWXiF9amBiz5MoUHr5MGkg6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1750
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

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, August 25, 2020 10:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: report DC not supported if virtual display is enabled (v2)

virtual display is non-atomic so report false to avoid checking atomic state and other atomic things at runtime.

v2: squash into the sr-iov check

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a948edcc93c..8f37f9f99105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2861,7 +2861,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
  */
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
 		return false;
 
 	return amdgpu_device_asic_has_dc_support(adev->asic_type);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C5dd32cf703464c63e3ba08d84901b99a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637339619046540701&amp;sdata=vnfKXyNtJVE10V6qFwzHQQ7rmVAV9Le6g31nkmaPnLA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
