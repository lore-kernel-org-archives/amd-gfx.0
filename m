Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0603C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 00:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A133B61057
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 00:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A133B61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B3189B01;
	Mon, 19 Apr 2021 00:48:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B6589D89
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 00:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gku4JQr0xkyOrjhZ/BEnbZgJd5c+NGBbxZVuCp05mAHbuJUKJtXSkR9h8Y6c6zi2Cc1EVNLYUneXUJi3P8/zGOR1cdAWjTDw+1qldGgPZaL/44w51d7R/p2XxZrX0SugxO8f9bTRxEgtr0HY0Fw5oRArOJYNGjoK69yOTXkP0k0r6BHv6jlblFsBNwNCei+1y1JoDPF1tbv52Pv4cTNJ+Tzswm2BIWGNpGpeJO5aYr+GN2DwZTBfRRad6ybdGdB58tWZLBeuuXY4tqr2ah5LnHy6mZ4UZVQt+D5xx5iAS6QeUxOOPed54Z3u6JKXMBqonH/jbI2mSODqslmOjKSmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w9AArwFJ9Fqeep06c8VGrXAHgQbQmu6auBIx5eWDXM=;
 b=Isnrn2CKMxMUYxK0TvdLnAB3zdUxEjfIVabR7yvdRWHuFTeIapzHM3KFs83+PZp3Blx/CAmMg31vgqDnif76pqgNC4ip1YNDgWZeOWRvz2uMwMLYGkTj4Qmyw/8eWFZjuTaIP+4VbhKxOfZTPKwu+v4uz7h5jP4eW1SyarwHCBoFItw6tFDTHA+X4ZBXPTSSpdDWs4Up9DHHKl1hB2t+7ZvTAQR987QmODPEfjmuJ8U8L5kpaVhy5+AtQDMaKv187dddhu6StjCHa7PUQUZla4mQ6c/l4uPupL90Ve6NLDL4SoKSfbwrWFe6jh0gk3wY8OM8pZ+FPhOS2LaGWw49yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w9AArwFJ9Fqeep06c8VGrXAHgQbQmu6auBIx5eWDXM=;
 b=4+m9JbjDXqlxNxEY5EKo3ygVw7DkTAWLaVuMVZB7pLNi+RMQxoUansPbBx9y6ejEZK4clGyB3hSP+yc9Iz98Ayv8hAQZp5mbqkTOCoMXFgvZH7RSeDYX4vGuef2qwpxsuVp3Dm0O9XgnFI2kLlTI0Cd3tP7ODRKxPg7pK+de2pU=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB3591.namprd12.prod.outlook.com (2603:10b6:a03:dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 00:47:59 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::445a:a6bb:4c3f:b565]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::445a:a6bb:4c3f:b565%7]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 00:47:59 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11
 gpus
Thread-Topic: [PATCH 3/3] amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11
 gpus
Thread-Index: AQHXMxAyym6NXOCVf0S+DX83ej54Vaq7BDAg
Date: Mon, 19 Apr 2021 00:47:59 +0000
Message-ID: <BYAPR12MB36400ADB137C8BE4724E92898E499@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210416222956.4580-1-darren.powell@amd.com>
 <20210416222956.4580-4-darren.powell@amd.com>
In-Reply-To: <20210416222956.4580-4-darren.powell@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-19T00:47:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b7a46be6-ec10-4c46-b30b-e103cb51d890;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc19b947-07f8-42ea-0018-08d902ccc769
x-ms-traffictypediagnostic: BYAPR12MB3591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35919A33E3E0A0902B3603288E499@BYAPR12MB3591.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YTSGx6LSEWiiK4KRHlaOFa+CryV3kZeB2S/IRQY9yEWyI2TSw2SfNb6B+HXRkRlmhw/gUdOsoCQwxjURtAM7cXxU8NA9Ro1RYd0liFY4v3oP89+14BKljTIDcf9EkdakWLhSp/woMz/xkVu/rRfQwTWOMz3+BiB7CfF3+iASUmCXy2Y+vbOXDQFS4WI6EJ/7tTGlkStKlVy9L4Yn2rnVNItGlnT19qsMiJ8pB/wt0s4UNqtTcAq0GRr221dZ9DsqlDJLMvfe7Gs3c0A2T992HnfWWZEQmqpvTRGRss+1l1ts70jvImkdNxPblNi5urnyqE+lDYqlC0tiM7LJvhIGES9Ha5a74zDLscaBslI++Yi8MAkCCI8VmBIUi4/Doo5fa9KpGMoG16lCkALNCMIfTkZFiWEGnvgsS7eItWo47RcX9tw1hNMmE7Frl5MpujZ6OJ7TVk0daFzZZ3NP4jGhHzdx/BSbJSb7sUgc9HUjonZBGCKgb24gbShFc8Jt+lkaDwFQI6RTDW0yfrV01Aimqo9QGN2sZOCm0+9lwktbEjUrjEfSISBXiOg9fvcmRIIGVa2X5Ooio5PkGpDlTW4DAIAK/XOJZLGDScbG1fTo5s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(2906002)(52536014)(316002)(6506007)(9686003)(53546011)(110136005)(55016002)(7696005)(26005)(76116006)(8676002)(5660300002)(66946007)(66476007)(186003)(478600001)(38100700002)(83380400001)(33656002)(86362001)(64756008)(122000001)(8936002)(66446008)(66556008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CJZgTQ15T6/dZnfOsVjXzaOr45UOxWEQURy8qy4VeDalmoSF8paRR4NiQnb0?=
 =?us-ascii?Q?1/73XsbgrUziX0YNql2/HDo72lYRMU6NbTcKEMD7Iw9xY/d+SYqyr4CWr0Y/?=
 =?us-ascii?Q?rgzBC24jPVQYKmnbc3r3hK9kZTNrl3vc9Fl8Lwvke9MrbLfZNf5LfG3zbvLB?=
 =?us-ascii?Q?9k+lkQE/9iv+29x2NxrItFZrnitUAfqB55dZvjJ3GNKhb43LMZe9oDo33Zlp?=
 =?us-ascii?Q?jHfYOyI+wWvMvomDMHu9yIgHQsKli8JFmBvYHZNls1TRv4W44q3thEnTPPr7?=
 =?us-ascii?Q?zUA+b0ikxnOSeqaOXmhhqCf1KhRGhN9ylVOPLTpav43ErjIPcfTklX0KNolO?=
 =?us-ascii?Q?IRNKO19EJjQ7a4WQ/A3dJwJ67cxDpYegORg7D6Ojw4FnMDtLvuLfuY90gk30?=
 =?us-ascii?Q?7Ph6BP8cYdxu8kBn8W1ZXRUQlrVc3d5ZPlmO8j/mrYksPF1EFGSfbgMb8rT+?=
 =?us-ascii?Q?qTYMldYVD4ZQDcjPaI0lIAqRtDz7pciFyg0UUdXRqHWtEs0lym0j0p2crQnL?=
 =?us-ascii?Q?n/AjNSsci0SG9CquUIxcyUnSzEyy2MnMv48NSwQi4AMvzutpgbQsEiBxPtcC?=
 =?us-ascii?Q?mn62UfOtw9puJ4eSeb77chU1adqh2Dt+jQAK9jBm6z/1RMWInSKjnAhK5JoK?=
 =?us-ascii?Q?Fbzl8i+PbBdAgm0LfIF/CDUoU4uJoW4F5hYFYeXgd7ZsyDAxVmTedbz44Ge+?=
 =?us-ascii?Q?d0UjKpUXngSJz83xDix/5oWBcY7+Zjro6N0J4KpuG17kH2Y0TJVrWqeRX2zT?=
 =?us-ascii?Q?agC/KBfBM239JKzFRiu3Ak6MVFbxwJy7+aLormQ3tnVZoQpo+2Dm85JWeDxM?=
 =?us-ascii?Q?HbaOMfzgUFUVlBeuJaBEF3FAD/U26u7X0r/2k6h/4CmnRm18TbOLQZDv0UKx?=
 =?us-ascii?Q?sTBKBqBy7bV06uYQYO6hZUbS4PGld0/sReQr2WHpabp832GZclQi/UDE/VRa?=
 =?us-ascii?Q?VSAlIK7a7pWCku1uIhYcAhLK9DqG7S2+cy8+egZ2EVWDzRWTQ+Z/WkfCA2aL?=
 =?us-ascii?Q?osjQjG+kOaEnMdqE6Y51j3/LwApq/XyGmnBF69kpDhfU+cB+U3Xc80H+jjMq?=
 =?us-ascii?Q?qGyHcIzRQK2gta7XkVIGwy81uaL4p7tTIkWk09bB66It9VGUDoEg04MQz1uW?=
 =?us-ascii?Q?EZICnZUEAIpbJ5yHkJmRDk+OShg/Mmav18zI9gxPp/YdbevldfBFfMVGtG0z?=
 =?us-ascii?Q?NSeW1uXfUOXRzX5APXhGc0zSXhw9PHeE1nsnfZqpeoTJF36GTvWb4VNGRqgQ?=
 =?us-ascii?Q?8KCoXPf+UP3zbg2jKtKe+TGvNwSlcddhaXKINnVXBK+779tnC3pUfTdCa65r?=
 =?us-ascii?Q?R1xHQAtv+b6WPEEV21efZJJu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc19b947-07f8-42ea-0018-08d902ccc769
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 00:47:59.0667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/j66tWdpguvAjFAsle35IoA1bBTUZo9WCWoyB2pa5/2N4MPxd44YF263DR/pcj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3591
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

Hi Darren,
It would be better if the condition is " asic_type >=CHIP_NAVI10".
We assume that from navi10, this restriction is on all.
With this change, the patch is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Thanks.


-----Original Message-----
From: Powell, Darren <Darren.Powell@amd.com> 
Sent: Saturday, April 17, 2021 6:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 3/3] amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11 gpus

Writing to dcefclk causes the gpu to become unresponsive, and requires a reboot.
Patch prevents user from successfully writing to file pp_dpm_dcefclk on smu_vv11 parts and gives better user feedback that this operation is not allowed.

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 204e34549013..317e9b47db53 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1891,6 +1891,19 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		}
 	}
 
+	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
+		/* SMU MP1 does not support dcefclk level setting */
+		if (asic_type == CHIP_NAVI10          ||
+		    asic_type == CHIP_NAVI14          ||
+		    asic_type == CHIP_NAVI12          ||
+		    asic_type == CHIP_SIENNA_CICHLID  ||
+		    asic_type == CHIP_NAVY_FLOUNDER   ||
+		    asic_type == CHIP_DIMGREY_CAVEFISH  ) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+	}
+
 #undef DEVICE_ATTR_IS
 
 	return 0;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
