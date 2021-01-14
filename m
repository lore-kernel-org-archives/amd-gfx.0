Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35701C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 13:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E972123A58
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 13:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E972123A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E136E328;
	Thu, 14 Jan 2021 13:00:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA476E321
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 13:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJx41wqKYL+4uAK1ViRLtH+o++3XhbDpW42yAuk9yGr0TIpfV03zOijMqRF2AQtOoUBwqw/qXcUQaFrfUNt2AwZAcT2tKlsUwIfQ81zQsPxLRyC2INUv36o+D/AIpHzUlU1Hbk588FD0fQn0xF7PI8QfK/rJR+7fkCTg8szGfG8RZ/ggFTtU4mBVeZZbIbclf6MBTyOdvASWe+n0O/8HwqTQSzi7DJ0P5zIcZWMuSypzzVvHCA10C3tuSHj0JWcluNePzkjq8J9ddXLkHz128f3TKkxM8/LxCggwCFMOWq/kXTXe/kIToYM3S7RXjpD1dKDhi7pXQMnGfxDmNmXL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjmcR2PTWjQ9QGzj29/fndAKbSRa/7WnVgHMQfz+U2w=;
 b=kZ23xvIqYNWaZ4GwFWPkmGSoB0+VVfQ5SX+ITvwF6qTVDPtq5E9YV0IFRMBxAZhJjpoLNDzoO2FhJ/lOdvipyP9r/FRBzf2pNxxbHfWCGSLFB/xq0Z6ng86XNxfnChYR4Wk3kVw4m7z6xySj3+lnCPjAWGtEN3EiHOSto/VOlx8UkvF0W/Cp5GpAFQiT6Zf6gjTeeGVkn+Z9GcfqSYbZJZZ9MqFSjf1mNdc8oraRQAeOM3efAuwN3xdQbOE19S9ySEaEiN+6Fk98J8zi7lF8Lwyq35zFWBqLmpYvnDC6HRDfZeYpwcjlguk3TCKFFLe/o3zksoFCSW1eN2b7wuFKow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjmcR2PTWjQ9QGzj29/fndAKbSRa/7WnVgHMQfz+U2w=;
 b=vrZJ/XbuTY7BS1hM+9mD4XdNB1fZhNhrPgyofUJnWgkIe6S71UcvzQVWwSHnEbFXib+yfAnlaLhz1xRGqgmWL0/FOOVIKtJs0oy6bV7FGHgB2ImIFrjiqClauj88TWnsjIKcxaPeuBoJCJwPm/7ca9HwfEj/97RyoE/SZ07inlk=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10; Thu, 14 Jan 2021 12:59:59 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::e008:e79e:33f0:bdf]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::e008:e79e:33f0:bdf%6]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 12:59:59 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: toggle on DF Cstate after finishing xgmi
 injection
Thread-Topic: [PATCH] drm/amdgpu: toggle on DF Cstate after finishing xgmi
 injection
Thread-Index: AQHW6kqQVCAnC0EVRUO4ggKeN7wbgKonFaeQ
Date: Thu, 14 Jan 2021 12:59:58 +0000
Message-ID: <DM6PR12MB4075534FBEA0A3FB4B8BA113FCA80@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210114075441.12726-1-guchun.chen@amd.com>
In-Reply-To: <20210114075441.12726-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-14T12:59:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=59df36ee-aaf6-44eb-88f6-addfb0a581bd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.6.0.76
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa70199c-8f53-4c99-92f2-08d8b88c4c6d
x-ms-traffictypediagnostic: DM6PR12MB4092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4092954FF07C9B5F3E8B6A61FCA80@DM6PR12MB4092.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LbJgTqC8YmH5MfXtOFpugeIZHqWnDLOVRPx/a3s/USA7T5d0M4MYa0hoqrhAAjXoDoBeqi/oIhf3PSwZ++eM6lWiM55mNO3p5X/zkNHszTebI+rKR+8UEqbKTEU7D25lW5XtzfDdmUIr9DUGPb04CvJxLcXPhIrZyme8OEWwlXws3eRQkrHK5PybQWIL03fsmYemaubaaM0mn9rJXjnp9ksSo5Vhgj2zgM0LqHtpW8xqiFI2je/SU54w1nt6UGteoWyyhpSbCtlbZF3wFYrtQUYxDmzsE8OWIdrDdSqWOuFNnhsIT2nudltHCdHbQZwv2hZZeMydUS2eJqC6exQh/J0tshemhW/8oqLxU44WiIcjocR+ZPUOq/ENvUHZZKf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(7696005)(186003)(66946007)(76116006)(9686003)(6506007)(66556008)(6636002)(71200400001)(66446008)(8936002)(5660300002)(110136005)(55016002)(53546011)(83380400001)(26005)(8676002)(478600001)(316002)(2906002)(66476007)(33656002)(64756008)(86362001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ABjtpVofxUiCXhUI2y7i8AhzHS2xMoZnYVOm2MCQ0x019LWhWXjDUwFnDG2a?=
 =?us-ascii?Q?Tfmgj2L2qbbUvWdA64zu7lhKxLfSuD631OwHkg6jbvKgcFyLJzoSrEGRT83Q?=
 =?us-ascii?Q?jlS5/lfO9rM9txXHNikFFO+ccRadOFaZF2mRknSnKxuQJqWyCeNmsl7QQ0A4?=
 =?us-ascii?Q?G2v/e/NU4TxxGJ3y32ARNqmuxcC1qFxQkQniG1OET7roexzhKNcbGJTX4A5L?=
 =?us-ascii?Q?7lwx2Ac2IQsH68IFdbxxSqicZgVGS5Cs8K/Ja958ySZRNrLCJsTlFuU8CJpM?=
 =?us-ascii?Q?a7AwSJnVS0wIKcNKtLhwYQEyP9ZBuGKjYQIv3Sdhzsc8EzJdcgWOw8OFnndH?=
 =?us-ascii?Q?7C3pYTP9Z+2UdFRo5wdIPJFhTMxYO4KBfAorq+/o+07DYmOkLmJmr/JHD8VX?=
 =?us-ascii?Q?1JJTfMSXWx1bDBFb/yUq0X6ViYus9uhHDlKDfIs2SDG5xdmPh3L3D8MWUCOP?=
 =?us-ascii?Q?i2JI+M/4Tq4k2dQqC3a9cE4JcyyJXKEXDH7tvWmPJyMYMT/ZQAS3DS8FtUA1?=
 =?us-ascii?Q?PNn/38cykj+U4U7AHIxzIB7q93M97r8FCHuA/Dr24WkkEIKwTN31On+SdORR?=
 =?us-ascii?Q?gx7eHHBE7WjpvphTgGHyzktlc8tYFr7Dvfuv10+I6SQYZiiZIT83WlltPtXN?=
 =?us-ascii?Q?ZcJcoF5jl8YfMtF67To0cHoPFp1OFmEo0rfYWNZ1DI/XNIK7tzIxI9bP0mt6?=
 =?us-ascii?Q?dVjk71IaZtfsO1kCynOdR89bIbC/6PAPmC2sXPZYiSSQcz0qk21czBwp12kz?=
 =?us-ascii?Q?cNhAaUz5/gcVHDH3HcjFzCh6/ZlVLM6yB4GgIa4VJoYh5g7ZlP6k21ZaOFK9?=
 =?us-ascii?Q?SYDTIQXcSoJaJUtsCOG+jMvEs4U+zGCxpETBSPQh7p2PpzpX00b13lbNcqaz?=
 =?us-ascii?Q?+i3RLKvrwN/2/+FJDPjN7qvpAOcIEEJ0rIagR19I0QCr3zpiaOBuX9NCCYU7?=
 =?us-ascii?Q?6qAr4DYH4EPJvEj9+QSeeAsKf6UdXosJUYjksH0Soql5RRGeCgK9Cn7ANiSM?=
 =?us-ascii?Q?RrVv?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa70199c-8f53-4c99-92f2-08d8b88c4c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 12:59:58.8474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdP0zxlv4YUZ9zoi/LPIzP6SNPQxOd3WmxswSoa0dG7w9I3PeOYXJ/LC/8v834xWJ78cbPK+ywx89wqlwgDiNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, January 14, 2021 15:55
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: toggle on DF Cstate after finishing xgmi injection

Fixes: 5c23e9e05e42 ("drm/amdgpu: Update RAS XGMI error inject sequence")

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..a6ec28fead07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -846,7 +846,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
 		dev_warn(adev->dev, "Failed to allow df cstate");
 
 	return ret;
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
