Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4115C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 15:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E2010E1DA;
	Fri, 14 Jan 2022 15:06:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8D310E1DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 15:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO2rVwC3zXNfYWga+QhDUpAMbvdv3nZQ/89XKoWJrKwnjRdjESynUpf7Ue4T4xpmNf47+BAHInCLeD2FTSan6NVWoz5XH6gRgbLgZ2jNpaOsssfc5uMGybpzJvUTcxz3n+QuecII3ouF8c+RcWYsyXCCCiFinHxP25abIMRsGwEDc3DvpKr62j73ncSAT3E8zykBmmLJC1aO655d9Z4cmnqKjTI9MAoBK8FUx3TNF/jb94SoivvS+oQqDEuluxf/QVRRc2PnSjUCOdVVQH/RZjf3+WJ3TRHlQ/94oQAnJFTbkjCtLa4deIrGrcuXWdstHoEwZ7F8JdgjIRNvexzrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTKpT5gqy6KGiDPUpTG7lK8P51mdbhWzN+qLjf3QJHs=;
 b=ZWUkXwoKbF2iTcS4e2MyXoYLjG7zOvipgHnG9Z6+vHMNBC6TyMpGh4L7IA3VR7tKwtx4Erz4utFK024uaijZsHJsJLv2WrNOT8GJ+wMj2jPIjSw9Aq9F2nfrdsLsV3r2kY6hyCqSvefWAwKV89xgG1xOPtb5lcvtvtpRnN9vg2OEXhh2WKuhT3/fVomeYrFoNd/bnLEbSYhqP4ueuVNN1S8MEzB5rCjPO9fvovcZTQBy+Y9tPvR0AKBNkD33SWqaQfTueSaNAU09c3t+RmtVpgVEFy5f2Un5ofzlDKVaddQM5ZX1C1CjljQYmxF0Ww6S/pV4U580JjXfvbqsUcj7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTKpT5gqy6KGiDPUpTG7lK8P51mdbhWzN+qLjf3QJHs=;
 b=fcnW/ld1yGu/JWQT2M8spsRO+vF2c9ueiz1Cc3ixr/TOGSE6qIWRnZ2zYIKjKDc3ij7ynMHJWr61DFsxwfHhdzoiVEwTCXAuRWp7WJhpBPFtgR8IPsYhaCFmmbtsMiG2TMtwBZ4UIwGOBEoNW/l5tZ9h0U11ZKNWbkK0oLdidl8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL0PR12MB4739.namprd12.prod.outlook.com (2603:10b6:208:81::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 14 Jan
 2022 15:06:06 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%6]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:06:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY
Thread-Topic: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY
Thread-Index: AQHYCVfbA4omqrPE2kOymTIKMNyRKKxinboA
Date: Fri, 14 Jan 2022 15:06:06 +0000
Message-ID: <BN9PR12MB52578D6871DECACFDF2026EBFC549@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220114150240.1008818-1-alexander.deucher@amd.com>
In-Reply-To: <20220114150240.1008818-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T15:06:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f9d04d6f-dae5-41ea-afcd-4d551ed84920;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee7ca702-175c-415b-11db-08d9d76f639f
x-ms-traffictypediagnostic: BL0PR12MB4739:EE_
x-microsoft-antispam-prvs: <BL0PR12MB473998C386CD2CD43A16E828FC549@BL0PR12MB4739.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0hSNbS1ij48MxlL2srzcs44AtMrjJ0dJrWbyrv5OgOYiKWqXW08kV92k2FtCq6hMUF9epQAeBMRVCw+PoueW44+GS8ljXOZADo2Hr9kXRGQMuOjwQLfsuY7X95XcOBUIbxIhqlLP2Cxs8wVxxcNOoP3lYu0f8SJm48t8piDvuRNGHZVw6/036/DRSDpYJdUsifzYeCEGB1xcK0tXVGaqc/AtaqW2DSpxoLivHqWoZbM5RA0AW2iQfz/SaWsp3hnwP0yvC3/6q+n3ZqSHUEhCad1P5TDyz70DDTkMWJUQmdV8h5D1j0zfPhBSZSPM90mtYWE5M286IJ7ZGaNYBGnHUkaTjp78UF6SH48Bzss4vy4ABmejHSyhDCWFHSg02iyPI9spj4I1uFJn/OKX4ptiJblXBwHvh/S3G+scw7tHUHrfQXnac9PewEglEWkbdh3F0QMG6Gi1aTPyfH8egAjTBy9tje3bFMOAqz6RIlrKDieDgE1MLSAFQcZU1whFF0hiMmgp2sKITBTM0obTkBdax9GlVecb96r+EaozOda3ylHZ4g7v/Zo5FIPvAvSYsu1Ku+tcBct/0z5enbFoP8bFK4cUxT7r2t+6cfwkPwtuj3wdLpdn1g1RKvXLw3IDpzB+4U8kJHyWUnTCPqtsiy8+GP4vP9MtRihr/tGWJCb5AoLcHhs5sPIY2lbdE6o6G0dMeh+bfpMfsE2orTBnJ0AyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(186003)(83380400001)(110136005)(4326008)(66946007)(26005)(64756008)(66476007)(66446008)(66556008)(38070700005)(53546011)(6506007)(76116006)(316002)(122000001)(38100700002)(55016003)(71200400001)(8676002)(8936002)(2906002)(33656002)(86362001)(5660300002)(7696005)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GO9HfhiNb1mNjLd7EyYFDqW/a7ZyWYf/XZ8jl/qItSQnjxqfXhe/4A2/R5Y3?=
 =?us-ascii?Q?o6n16VUwuYxdKWCbH+GYm146Fcf3TjOawDsEwvAR0rLVS3NOwn8944bDwQde?=
 =?us-ascii?Q?eJZeVlfeox6P8a8+iARDkwoKCtJSl1iRhWsoSGA6DY56auKtaez2XOyV8T3g?=
 =?us-ascii?Q?zpvig4io9kaN54TWibW8YfXllx5ct84XQ0RBGvjw24ueMI+6a7nwxjf3r5r6?=
 =?us-ascii?Q?OvwoOO13jXL57KKzaZH2lywFGPpyl29uG0fq/BQyAgBvQAu0SiM9S2/YU2fr?=
 =?us-ascii?Q?3T8MyXGEge7uj6pX0jaAitSBVP9iCtZzUze9uuDUGXCTzWVbXPrXLlvDczSq?=
 =?us-ascii?Q?88X1Kehg+sfkBJJLe8ENE1bHFStZHTA3us8LbgXL/cXA8X9c+ITUrYH2kxnM?=
 =?us-ascii?Q?t/+6IDKCjFZ/nk5qNSD0UMJDMpXoXZ+5Ovrh/FcUuA9MQcz2AfTucpbmz3BJ?=
 =?us-ascii?Q?HWYP9BUVtlWtGhLv2uMHEaa6DF7m8pSPUmqUcWnjNsrgL8+CciY3EJqg848T?=
 =?us-ascii?Q?YCJHKzmALHjb07zH64iUkL7SQ8Hg8UvY69Zu9QrWOeBcujaKHPyRavZe5H7A?=
 =?us-ascii?Q?yp+k4kxAseLGcP8WfCu3kbiei3F+j1+KF2OUWY3p9sNluUKtQDUbF+BbdiKY?=
 =?us-ascii?Q?pK2EI6RNRE23u/rQcJ9Jd1x8aqHi/BaIns6nu9gvVSVKEcY3HWI4vU/tMDup?=
 =?us-ascii?Q?1YaR+eZaedmAcTmLKDT4nn4IF414oGtNITi0R0zkxYEbfwvddTSSCeNErGai?=
 =?us-ascii?Q?Xu65nPQNxnJ5A2rYSWlOr9Ena8oV5xP0W9v9Z3Y4MSMbxAzPn0bMDEqsffkH?=
 =?us-ascii?Q?/L0Hmb6t96xoxr6VfLiqKsHt7y4viugZGvxw+/m1RkaPK8u1wxQhGqrfeJ/T?=
 =?us-ascii?Q?HwcoiDtKhx6mRCwRXVtSda9dkdOModrxNaysMqzG5v2BaHBSrokgvtornmWN?=
 =?us-ascii?Q?1iUodJSPkUTNHPiviaAmR/R8w4i1NRhlWZfuFJA/nfhghcsjbzt0Ayj6KdqX?=
 =?us-ascii?Q?/Smi3J2eZWXoeAyosqswX7fZ1O9xgz4yF8PgunP4rAu44wK4DnGL80HJW2j7?=
 =?us-ascii?Q?vUtEji9zgtPMFoBgiJ9mkxAp1r8QvG0A/PdvUh5a2YCx0u3hB5Bref6G84me?=
 =?us-ascii?Q?LtQCHqD/vO4cTX40l7720InOZFWW5K1ahekltqGMXqyKMh6fdF2knDaNhENu?=
 =?us-ascii?Q?/GRXy3S549d+Wru6xM55F5I1BgLncDtFftl3Na+lrSvZPkALXscrWLtntHhr?=
 =?us-ascii?Q?tr6sBW7HCapZBx249Y9A+rePHX40BDRazAKmIfY/jUO/ApHgiZLd4hHtR3Ui?=
 =?us-ascii?Q?DE+UaR8VvLvMnxbbzVt1jQ/YTQ2KV660TSAYM9cjjZtJ+Ui7/TUK6yvCjVTG?=
 =?us-ascii?Q?Cgu0tGZpl4SPMFDHl3c3Rt3dU47eWI5o8hLd27e9RvS9tlIOeGpVYvYhuNaE?=
 =?us-ascii?Q?nAmBqVHug8ed/kXd0jbMaLSwcTMjsFQoux0ITauKInNCw0KJVsMAsbqmA2tp?=
 =?us-ascii?Q?LLLJU5zLYLsKGdLv53KRI4bLnQbXc3OOWe7LC0kZafi9xi27sqKXF36tCCyr?=
 =?us-ascii?Q?vFVKOnyqFsERmT14RUXb2NrOsn1Tl8iM1fr1aV9vhvT5PK3E2ycts07k4iJg?=
 =?us-ascii?Q?6ko/kPoWrby4dGHn6Kbbn64=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7ca702-175c-415b-11db-08d9d76f639f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 15:06:06.1096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOrj7oZT14q8XZvudkQ1fVv7HmMt+Z2c4DZG2l8r/VlucHTVTW9KAah9x5fXY/0jWBycfzqJwdvtnU2lXUdU8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4739
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, January 14, 2022 23:03
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop flags check for CHIP_IP_DISCOVERY

Support for IP based discovery is in place now so this check is no longer r=
equired.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 224d073022ac..25e3ed351fd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1903,11 +1903,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
=20
-	if (flags =3D=3D CHIP_IP_DISCOVERY) {
-		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in plac=
e.\n");
-		return -ENODEV;
-	}
-
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic =3D true;
--
2.34.1
