Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52476C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 03:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04078221F8
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 03:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04078221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEF589D5E;
	Mon,  7 Dec 2020 03:51:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E9D89D5E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 03:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBwm+ZnnyMB4W2kWvXXfrpqphRc0AWoSgOViRU4c0UQ2f1Le3H3H779+SIwGzxYKpb2KXXL/fZXksC4xyHCawbtGpyX+G8BTBYYAuJhXy9rFGlUKWghgJS5cscWYFwzoCcvOlzMg01lDybq1hA0tcUpw5GbC5tMxa/7QzfQWWix2AEd3HA2CpiqDjJ4EynPn6QN1AmxmnSK8VLUL6lXLUaIn2T38VTW7OmYOhMkQByJDTcRv8hN/8Gq2q7KTUa1F7x0NwVvf4WXCp7X0TiNssAGEAJF1MRpR/uqvI8nPGP7izi3RRMhVFnzOqPINoaDJC0beZ8+9MXyqIoiZ3JV3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss6fOJy1ZbrArxDCNjxaja56Sfzu/A1a3PlljeM4whY=;
 b=I51wAZWcBQEXPN3bYjWJLOsF/13/fK+MgR01Wp4GUghLmkRkLm2eRzLYv+ujj+QUguDE2ZiJQ8U9YtB6oQ0gB5N7VRJpOc5EOc4jgfkp8xye+4phM6Z/ngpWsx8aiR7rMTWXYqcJte/YUFaEw4UPF0BgJJJc7xdTpTteiMHZZf5SmnbbKg0zQbsjTV691AxTzPtJLd+Yq8fmIY4jsfohejc8mOdz5EGrJF4DMPEafZaVRHHT/81YHtdO6AROzbRCvChDFcyT09m0/5/Yhw3iGQOQApHnQz/zFZX0jWncLW/UHSXXK6opgQaa+nQMjBepGGZUTRxAXLPeVlSWZQoOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss6fOJy1ZbrArxDCNjxaja56Sfzu/A1a3PlljeM4whY=;
 b=ZI1cLkYdDDHY320H8Ivf9Zc4jwfaRnUXHFmo9OCELuKOR7F+HRwMflSvmo9utd7orD2/ib619Pe2a4/r8EITAADiBezl5IJci4bMFo7XaLGbj7CItU5Af+xlTlmMJeFILhd46EXMm3sKrB7vziAWq2kEXdm3/j0pGcyWfNJrbAk=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Mon, 7 Dec
 2020 03:51:22 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::301c:10ea:a714:b9d3]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::301c:10ea:a714:b9d3%6]) with mapi id 15.20.3632.019; Mon, 7 Dec 2020
 03:51:22 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add judgement for suspend/resume sequence
Thread-Topic: [PATCH] drm/amdgpu: add judgement for suspend/resume sequence
Thread-Index: AQHWzEt0tl2WmsCOwEeCPEFB5zCRranq/7GQ
Date: Mon, 7 Dec 2020 03:51:22 +0000
Message-ID: <BYAPR12MB36408BB4A35054D80C3F8F738ECE0@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20201207034517.2074717-1-likun.gao@amd.com>
In-Reply-To: <20201207034517.2074717-1-likun.gao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-07T03:51:17Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1768ce09-f628-4483-9cc7-0000064f620e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-07T03:51:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3e4ba73d-7ea1-4d24-b51e-0000f2c867a4
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba8a18af-b70c-4844-b189-08d89a635d26
x-ms-traffictypediagnostic: BYAPR12MB3639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB363999FB3627B90B388638B48ECE0@BYAPR12MB3639.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sqIs6ykTwApoe3hsWbyCppAzZEbQC8gpyIZnaC6VMrr9Q6Nkq7xn8QWcQ7PjPFpg3YWxggiTYf6VL8JW4ckzMa7e7YHb1aaSWjxhbsS65grLojfPr213UsRUiz6mifWrvqC5stJJQrrM42eHilH6IFQodk23NwHhgFd5Y0wpA9mlwPf7909nEHVyRmA/cJsC/dOLa0bkIkW1pz5rMYHxMLJtxRvdckkB3N6H7ylnBKfj+N6HqYnfMbSkTgkPHtYzyTosaKuAAJxzLrOHvX5udfe3crFSXAWBAji6CTAhwibgJ0u0njL9Yiock7qo2TG8r5QEqnQjtbnjM1K64hMtHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(83380400001)(478600001)(2906002)(6506007)(53546011)(110136005)(9686003)(66946007)(76116006)(86362001)(4326008)(66446008)(55016002)(64756008)(7696005)(33656002)(66556008)(66476007)(8676002)(5660300002)(52536014)(8936002)(316002)(186003)(26005)(15650500001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FH3q10zy2Fpe6R2FOAjxU2ywqJ1ckwmXIcDXARaUsgadt+yVUC5XYgeOnIX8?=
 =?us-ascii?Q?Afplbxk3yxKPhT76Qx2aOHQyjDprYumq6z95os5hOewTH0+uiJZPRj7ouyWs?=
 =?us-ascii?Q?f9Da+GCLOSeuLh8i9gdM928GofAIvOAmO8I+qZjLj6uQ/O/Vh7fnGmZvHoiU?=
 =?us-ascii?Q?IpHl/CA3pYZACtesKARethampXBqVEwl0FrkeDVYFbp37TXnJTDZUfBy+8B1?=
 =?us-ascii?Q?U41B+WITHC6JGJjcwKwyktr9/TxQjKu1/tlyNcLbjD+IDRnwL3OfTY9pTnk5?=
 =?us-ascii?Q?bXBnPDxFaHA+WCQNqZK56fENwl6WRlY4M2DH6BtV6h+h92Xg6rMfka26sCxv?=
 =?us-ascii?Q?ngoiuhamN3Q4ivOjuyikHgBmoeztpKCULXA1L+soUPT9qUsJPh+ZlWGBuYVa?=
 =?us-ascii?Q?mzCDV6TGPf/YR+hEr9h2F9voB6qurDN0fOY4tp3wxrTx3XgCx/5TFjN8jJxS?=
 =?us-ascii?Q?TkLQicVOP/DJb/qTpObLjj2MYCqxG/3qn45dRh2X2JbzTPmKOsRxSlaRYYFv?=
 =?us-ascii?Q?27J9yj6BjZ09J89WnpFm+GX08p/BuazUpzGcwKWdEb+vKmdQrpGCy5q38rVN?=
 =?us-ascii?Q?wdFQveRcZd3JSjm/hfXFnegILxzmmzCHB6G980F2EzlSHZDQZA+d2eGUfqrk?=
 =?us-ascii?Q?EoUiezyU+zeU1BT3ewrtkVJcGvPyQR0mamz9dOu6aIh09HIDhnd6R4YBvvu3?=
 =?us-ascii?Q?I9RXGgbLJixLZKzwM+d7c8eL7zNd5htm7pbKR/Jz1tchRgXw0m1BuHckQ0L1?=
 =?us-ascii?Q?uN0QRRiP5EV2juwf3Lb+o1703Qo3N9GUaAxNWE7zMwdzRgnv2H//3f8qjmd8?=
 =?us-ascii?Q?Hj8xNUhCyOQqjZ4FrvuyISr/VOPynuUXtSF7bgP3lGQk6WGG6XWN4Aid13fZ?=
 =?us-ascii?Q?9y8ZmMFwIDVMzmvH4kPdxmI5GfR4e9ZYfOEN1u98GD2kLZYYEY74rWfhFtJ6?=
 =?us-ascii?Q?hjWMsxyXyrCvCPIXuD/pOLeJVFkkAQnSqiC3KoGQVy0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8a18af-b70c-4844-b189-08d89a635d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 03:51:22.6862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXgWM4SfzRFLPeFe3Uh2JyvHveqYAVWJsgR18/8jA2xFrxM7YULdjz2RbGphTjjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Monday, December 7, 2020 11:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: add judgement for suspend/resume sequence

From: Likun Gao <Likun.Gao@amd.com>

Only APU should deal with the situation that amdgpu suspend/resume with
s0i3 support to skip RLC/CP/GFX disable during suspend.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Icca91b3497f12a6d78f005ee63461cf0e8f24958
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 79dd85f71fab..75f40a8c59f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2650,7 +2650,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
 	int i, r;
 
-	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev) ||
+	    !(adev->flags & AMD_IS_APU)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3710,7 +3711,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
+	if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev) ||
+	    !(adev->flags & AMD_IS_APU))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry); @@ -3744,7 +3746,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	if (amdgpu_acpi_is_s0ix_supported())
+	if (amdgpu_acpi_is_s0ix_supported() && (adev->flags & AMD_IS_APU))
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
 
 	/* post card */
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
