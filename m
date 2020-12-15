Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF71C4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 09:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0EB22225
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 09:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0EB22225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7247E6E165;
	Tue, 15 Dec 2020 09:01:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03ED36E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 09:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA3mXakKQSCpA6XKqzo7+Dr4Q5ByAvzagBb3CfYt90J7+iE9ibskzMqeWue+UPj6limX+Sf6aDtT1o/X2UQbKXFLr1mGS+c1ODDaTl4ebXH2Dxc66mAn3OZlCdgNTrbQgoq303RHWRiWVRnDTy/XMYhRSYb43rZ/giYz9DDZ+D4VOYIpVa5C9BN07hidDfMAz9woo18M/caES1ETDLFi4GxdL3I+ilji5IKiV6zbBQZ/4om3VolDuIKfH56qgyMVI8Af9z4aYRdWKKv4aeGDY7hE1NsQcoaFDKHtcnR7fZC9ttSucL51GRbluZOIa8Wq5jXZIk0VsBjEbLZ7/7BrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY6ChNLKw+CBLoef6Bpj6eHHnVVlzMWII51WXYj3Frg=;
 b=RDiLfkH6zdzzo7MiHeJSkBeFQXlIp89W0/ZmWOICn+09khZr3uAEHlaZ7Er+J8VJWdZI8eQj6EHXFrH3J9H8F6dG2eUpPBv5d/0bd/RZdZPmJV7upVOjkeKyql63Uo3OGxZvZmENEoWeT5wWLLT7zcAKgYeDiRhjJFvNjKL/peoG6BsTTpFKq0+GXvy9U+LdoT3U4ZS3j3cpVzOYu180jZPaFYmNk5vxTcXuu8VPsIUxh3XFSURa4iIrz0SEMkAg/piS6RA/FXa3o1OOYmES6AnOMJrT6SSNZstHQapTgVpWnv+2u4DSywGZjY5ZyFRjXMdgL+H7VVp2UZeqydKIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY6ChNLKw+CBLoef6Bpj6eHHnVVlzMWII51WXYj3Frg=;
 b=Gu4yBXTcE8zi07ThH9KM96PzNAQcdEiG28IymPIC9UtmpZBnFktbGnjGaxaXUGgAwXgoyZsAazhS97N+F7P8QPnCsUavcQbbiL/0mOuq1F/nQAan5o9qv9irStb8NeWOX75IKobpA2rv6b9z2ihgZt/+eho2J+nxJL3xvZomJUo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Tue, 15 Dec 2020 09:01:47 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Tue, 15 Dec 2020
 09:01:47 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the sensor value of power for vangogh
Thread-Topic: [PATCH] drm/amd/pm: correct the sensor value of power for vangogh
Thread-Index: AQHW0rWZjd+GD20n60ip/1KewtGy1Kn33Dlw
Date: Tue, 15 Dec 2020 09:01:47 +0000
Message-ID: <DM6PR12MB2619AC066D4DBF6BF299D34DE4C60@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201215074019.9317-1-Xiaojian.Du@amd.com>
In-Reply-To: <20201215074019.9317-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fd9be79a-4b4c-4be4-9e75-7e60e0c406d9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-15T09:01:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70312fc6-0570-405b-daed-08d8a0d80db2
x-ms-traffictypediagnostic: DM6PR12MB4043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4043A334818AB334BD3FD700E4C60@DM6PR12MB4043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UEPUaBhoEg0tlROqxlE499hg3/j6s9aKU4FelUpQYScpJ4GN/lW+OtAiT17jrrWnei6aAWT6WZzDoCJhE4zJvn3KrlR/tdAR79Q3oyHCKAOhtmgBUxyFtXHtlZfaBup15+qPV+0Vp7Y+dyi3INaaYBunUHkD2kLyRAlH/6/cIi8tbE/IB2y1UtWa226NZ+fGjWeTkDY+qflUEOmg/ravi8e80c2CRQlz1GEjcXdJ4uIuYj7Olg8VoFopPUbFzQ9tN7wEGI/aArLpv+KzWXasFyYgVfWxH77znfbR0ehLp1PwBRSAOalSBfiE/a1d027AqV1mqogwdHMB0P6iIAaGfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(86362001)(52536014)(110136005)(66476007)(5660300002)(66556008)(66946007)(8936002)(508600001)(9686003)(66446008)(64756008)(76116006)(2906002)(33656002)(8676002)(55016002)(83380400001)(186003)(71200400001)(4326008)(53546011)(6506007)(54906003)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QIRTzYthgDpY+jxDtRPkIe9F7Vqc/axU2DHwy8WbOj0Cikcu8KpZSNc5rjcp?=
 =?us-ascii?Q?nZk0oFpLj5mtu+MGrQHFMiXa0fDCz56ZRIdz/4cj9Vji+pNnxrTwhgr5Fahf?=
 =?us-ascii?Q?hWfa0Fif1+TLpo0SdAFKyeeEZl/rZ0McIOrUwkla+1yO9tE9J/0h8h2SBznd?=
 =?us-ascii?Q?2sRE2+eO6LtErT06fsTnXu6XOpccWE95DY9oPNa3quBBTy0yghSN95X2TOOK?=
 =?us-ascii?Q?dQOrIZMkgVTqKwzBI2sJ8NT+Z2/uGNlHeJJzzDlChuJ34Wd+ojvb5EZ2Vg3U?=
 =?us-ascii?Q?QdKda29fxb20BrWk0wKw6RboJYlC8Ub6S8CYcmTyE3aYbTKOsR1uimoysvwy?=
 =?us-ascii?Q?MajGdDbj2vd6/shVnwD3SLIpFhllGAU49M7mRgZlNtJeXsJPYsBMEIIgGNpa?=
 =?us-ascii?Q?FSyW/4/nkf9UnIUP0EJW44jI8zVGtFHwggVLMfeNCmryi/CiWkkiS9QDdd0X?=
 =?us-ascii?Q?qDKlugP3BBvcoR+id1Arcq5LE5Z6ajmeJmJTqtXWD4hhIfEcWTsFnph5NbFt?=
 =?us-ascii?Q?0xy2umHNFjWazKPkwYBkhvRNX5UQOEp3ESw8d2t9HwwLXIav08gCcyFSJy3w?=
 =?us-ascii?Q?buKC1VsUWMBX9T40KJF00Z7XhegCUTYrFTXtpQFllpTJHgktDignizFGxha5?=
 =?us-ascii?Q?vI3mKjqaU5ndbBr1SoRxbvHyJF3e02Ct+6c4G0ZprNy0xyjWm8VB97NpWMhH?=
 =?us-ascii?Q?HwR60vM5agElBHo9HOQZdyFJ6tHTcEIdBn3du2/W7SWAY37nVO3V4KPe6Km5?=
 =?us-ascii?Q?F5LVRU7cNMQlOMWviD2qJTZ2roTgNfJNeIQki7XBewxTdvEnMVw3G+X0n1xh?=
 =?us-ascii?Q?oRBoE0Oo/bvTi6xAajcBaEqQHoUgjrWd6WguvN6zAfs9cBQJ7QFJ9TygptRE?=
 =?us-ascii?Q?OBnuq3/0VpTPI4JTkccMKAr6rIs6pBHUd6AV4qvTdSSxqepebFVRJApf/xDQ?=
 =?us-ascii?Q?T2Emx0b3FnDVxQIEMjaGIjYKNW/4ayKlGOeYb+VUAcE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70312fc6-0570-405b-daed-08d8a0d80db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 09:01:47.4141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDO5rPJb+8vL3Kxl9PLiB+jmkMEm2CstclaySes+jGxMhnkC3tWU9c1nnOHLwjHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Shimmer" <Xinmei.Huang@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Tuesday, December 15, 2020 3:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Huang, Shimmer <Xinmei.Huang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/pm: correct the sensor value of power for vangogh

This patch is to correct the sensor value of power for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 9bccf2ad038c..a33c1e07c5df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -252,7 +252,8 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 *value = metrics->UvdActivity;
 break;
 case METRICS_AVERAGE_SOCKETPOWER:
-*value = metrics->CurrentSocketPower;
+*value = (metrics->CurrentSocketPower << 8) /
+1000 ;
 break;
 case METRICS_TEMPERATURE_EDGE:
 *value = metrics->GfxTemperature / 100 *
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
