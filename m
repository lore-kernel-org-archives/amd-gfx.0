Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268D4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 06:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ADF910E25A;
	Tue,  8 Feb 2022 06:54:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B2B10E25A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 06:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzC+u6J8qQch5tqP1ZFtXI2sQ/a0a3188CNPTrr5EvP4z5sqaavzys5ApSe2dTcATGT5i/z49Z3X3pBMqWqrzWr+EM62ybqe81TPl/qDaai++Wvi23uMXsKIuWw96BaVVd7Dy6yKBVLkCgw6U01bfrmQHe+v1YgqoIAcTYBhfStPQ0Ahw4oVL7LlSxn7iw/2ERDfN6vak2nqoTYADtEy4D6mWbesuUMHZrOEodr5F8swuxHRCW3I3SlGCZ6BtuqU/OFvix/TslSI0ojJe/oS/lG1hVTnMwj7JxvYcHkXW+ff/iGEt6y4eW+n1fVwaV/qc9/mVXaDbkrWPmil/Tpmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdX2j5TIAD8FBkTC4EBvCVyukJ1JPSQ/0IkEGKKcpsw=;
 b=Q+wdgPefPBXR1K4940bpmUEKVmHkZZweQHVEtaFMgbFqp/Mdo44sc7uvLHhQr3oPssPWsSPBqFsPLYZa6bpodgz/0mzRdDnPUABKSl1EfcsOTpkWnNXbWrCSk7BZWhYlKByLGpSuxWX7S+JniSuWvgsoYXWZK3dwcgTrSB4W360kkUC/0RAqlwzxvZUDdbOnUIAaL64l5YdD9XEw5HU5v7M0SwhluQqSjIAmBe52W9ibOBVPa1qSNh/yc2BDQg0/r4OWunaKnh8oN49C4cXQQJzh3Odhrml/RCM5XlAFv5P92k2Yow5nHMhAwOhgzZNneB4fuE3AES4RxIIwCoz7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdX2j5TIAD8FBkTC4EBvCVyukJ1JPSQ/0IkEGKKcpsw=;
 b=kUSvrU9btZ9OzIki+NwID8YPLWpbTc8zQmHMOfrMhbprrl2c5ng+51g3/t0OdFkGP2Lm8m5SxXv6F7li+KDHSvss5BvWil1IVzov0Jv//WoCzSVrr+FonosISD/gvfPS5m6r3XPR91qzWkpX79/rKviIq0eNu0Ieas7CEelBq2Q=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MN2PR12MB3150.namprd12.prod.outlook.com (2603:10b6:208:c7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Tue, 8 Feb 2022 06:54:50 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::68d5:cffb:98f4:c945]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::68d5:cffb:98f4:c945%6]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:54:50 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix hwmon node of power1_label create issue
Thread-Topic: [PATCH] drm/amd/pm: fix hwmon node of power1_label create issue
Thread-Index: AQHYHLYcRk3O9i3Giki9AgigOg493qyJN2nQ
Date: Tue, 8 Feb 2022 06:54:50 +0000
Message-ID: <DM4PR12MB51650A0F73F8A31140EEEF3A8E2D9@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20220208063517.330344-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220208063517.330344-1-KevinYang.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55ecc388-f2fa-446d-a029-08d9eacfe6f8
x-ms-traffictypediagnostic: MN2PR12MB3150:EE_
x-microsoft-antispam-prvs: <MN2PR12MB31503F822989AA5ECBC724348E2D9@MN2PR12MB3150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itrmEa78BJ43x8Y0KGSshr602mhelPbZMXNCkZlSZfaDJDEez95z/3BRaU2nteG8cIgFIRQ8x4VHiXVewCvb9LpNefYON9tzktemWf+7A/mlWyAsj3qmY1SpnCzgC3PvzQ+gQXFbEDAj2dM3Xy/zoX0B5/jVuDvXgq8AzVyK36E10Wbg7MazzQGcMFaNs3EwBv+oULUjudTkVYv3DuFN4Fhd+ZRtAKEYMbEyIowDV+ytMyNcT8uG0pScbLrDgmJ4YQubCPsRDt0vtsc6j+6YmAxNM2QC8qbELdaVdn508oHndgyotf3MIlfajnae9omWwePRUorXuAsssCotxKsvN/aqDWj963DsGJp8BnLmWf3FnkCVylVU3I5xkx4cgvlJbClqKQK0W9cJicp+79/e/fyP5nMm9bWZbP0ROvd0RCbFBjTVzIhzu0LO3l8VjolYkvtWl51xf1dhXgowkFAb6Ywc6RqkOQSWJYVRurbbEs6kxSmtV7XbHKCbZeoWLJGpOP3pIoPwvr2uvuj1V23Dd5d43ndEHvkz3L2XWsMVo+cvYp/iRgWiCTvij/lli+x0IlGo7Hd1GVLGZn1FPOAJtuXrnpioPZiQQTQe7AZuvql6hoAimr0aSv58l4DDKB+7NKqFgTDdOSnIHIebbgHPmNnmB+WC8EFpjE3xmdLO4Gx9rA/aI1LrTGvD/pNB5R3RFJMjU6Z/8wM/glNl2FiD6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(316002)(54906003)(52536014)(110136005)(86362001)(7696005)(6506007)(66946007)(33656002)(53546011)(76116006)(8676002)(66476007)(55016003)(4326008)(8936002)(64756008)(66446008)(83380400001)(66556008)(9686003)(2906002)(186003)(5660300002)(26005)(38070700005)(38100700002)(122000001)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jn52QmSzKXkRrpsloKBOVgqSKjy9U/c4KNR6uBEkkn97Ei9FZOygR2xQj/6M?=
 =?us-ascii?Q?vhRLUcpSjWag/zxCntuP5dr1z0MDedHxk5JJAeSUA8tG2JYyJvYVRJLcYTYZ?=
 =?us-ascii?Q?pMA61h3RplI/B5c4sSmRxSoQWnp4VWIQhKU22DubwR2M6Fu8JkaVUWZRie3d?=
 =?us-ascii?Q?d9mMmOrKckZl4dukiBBsG3CcHRoJ5pVebZpfkGi/wy6uJkq5YoOtN5kZH8yq?=
 =?us-ascii?Q?WWFvrnqR8fEdjyk6JaOXVTiGUtVQo/0ZU48EKVfYPp1CGmwgB46X4JLKgdZF?=
 =?us-ascii?Q?K068o1tHjh+1U4j+HbxXUD7sGKLJDLLmLDUOkrE8Hm6088fKMdceIXZWVSp2?=
 =?us-ascii?Q?jdO77Z7Ec1upwXkcq56nF6Y5Ryv48GbqpeSNQxtJVcc5AUBlQVDfDVb3zUw2?=
 =?us-ascii?Q?VU6PU0cUs6MqPX0DbnGj+ABUWLMSU9RozYy7lm7pgu3wVhs+yPCbovNfCosQ?=
 =?us-ascii?Q?4DgWTswq45JmoWEwhPz2jv5G/ajhjTTb13KmYJgxR4OLozebU0wia+CK15+d?=
 =?us-ascii?Q?aYvVyaeyCnaGEHJME8UnQhfDs0yWX+IbrjlVMhU/YN4GaIblVaCQgI8msvFX?=
 =?us-ascii?Q?qYjcB/foBcb4hwOMeyNo9UraHxqutGehGmP1qWFvz0iS0QcDf8ovslCHMRRZ?=
 =?us-ascii?Q?Wp8tA3g5xBH7u3wP+xTGPK9gK/yi5UUJP3P9n3Yrb0FtVRWSsqm60nStdvB8?=
 =?us-ascii?Q?TEZx5Lm61QKuSY/EENpVqjef09hbn0hiDsT4Z3WJD+yXAU9brn+tZRNdOvrH?=
 =?us-ascii?Q?3Q1k9TD9fbavdwmvxG7l9dXbVkpULx0C5FvyfJeBiSmDxpBF+vUi3yKu+F5E?=
 =?us-ascii?Q?sLKQ7sDvafDEuc04NvwlAV/GrckpYBdHe/UfLTi6Yvr0tT1qEaZa2RpBj6TL?=
 =?us-ascii?Q?UKhO0lrHVS9NJl8wuBu7ow8tMiDu0Bd3cQwcSPnr+cfYkHRyNJhJbveIbxDN?=
 =?us-ascii?Q?PNSy4kx7MqhZOKHc+h97nD1KGyp7cVGJIdDQCeOoHwQHIIWcvSzWtNPmi3wk?=
 =?us-ascii?Q?G1Qr98T4OoxmKqNRbTBfV03suPIrDmYcYcm98O0DF0uRF3FG4JgRjXc2ANZp?=
 =?us-ascii?Q?E77B2TTP+Gb+R8fnAY93IahVgXCcRl97zSDhUOMUNLFiEDkh0nvFW7U2Vm7R?=
 =?us-ascii?Q?89i87AhRSChB2l2AZlK4uJlb5K9mez0/fh0pG24/dhz8BDfGnWh+fwjgHWGX?=
 =?us-ascii?Q?479UlGZGhTbm9Y22WaMHH0fwqHNXkPDVnKyPg1Q8TOTMZOzcVM3vkAZk/UVR?=
 =?us-ascii?Q?oKORFHTz28RanJfDy25RaisifAtYqtyGjWAFlpz+zQxUxHYiPqf/iVk65Bak?=
 =?us-ascii?Q?UD9SdnelEqnWrWiHc5euXAiQciDKZXuchOVM+AxMcGcvc/5jySvCqK8Cz1Gq?=
 =?us-ascii?Q?Y9DlYViZHuX3J9UlbgbX+uu8vy1H1EvJLDMzRZq8yjnu1tJfa/1q6V2OYf2y?=
 =?us-ascii?Q?x9DdbaKf9PcJarfRPWXPI8VAfDU1Beiro0Fo+ko0sh+zKCOfMNTLnVJad30p?=
 =?us-ascii?Q?/esyz6AZd8cJTTjAUkb/OvxDSb4KUCDiEOryHuTYZW1lPa+cBfDueBB4hkWW?=
 =?us-ascii?Q?m8NqSDwIjBWqVPnSDvo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ecc388-f2fa-446d-a029-08d9eacfe6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 06:54:50.2725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afI/7pt8pii8vpsYEqyQOMV5nx3GbA4psWe3aItCQ9qOFDZSvVIL7JxxrwIJkYrf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3150
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>=20
Sent: Tuesday, February 8, 2022 2:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;=
 Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Wang, Yang(Kevin) <KevinYa=
ng.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: fix hwmon node of power1_label create issue

fix typo issue about "power1_label",
it will cause hwmon node of power1_label is not created.

Fixes: ae07970a06 ("drm/amd/pm: add support for hwmon control of slow and f=
ast PPT limit on vangogh")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index d68e7132da2c..d6c01c59f32e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3288,7 +3288,7 @@ static umode_t hwmon_attributes_visible(struct kobjec=
t *kobj,
 		 attr =3D=3D &sensor_dev_attr_power2_cap.dev_attr.attr ||
 		 attr =3D=3D &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
 		 attr =3D=3D &sensor_dev_attr_power2_label.dev_attr.attr ||
-		 attr =3D=3D &sensor_dev_attr_power1_label.dev_attr.attr))
+		 attr =3D=3D &sensor_dev_attr_power2_label.dev_attr.attr))
 		return 0;
=20
 	return effective_mode;
--=20
2.25.1

