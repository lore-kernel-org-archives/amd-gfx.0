Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C7EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 06:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EDE10E841;
	Wed, 19 Jan 2022 06:24:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6654B10E841
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 06:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFKX4ZfP5g17T1Zd4VtZ1QwgDYwtWHf3dZD6/fJ4rZsydRszVnbNsJ0nuFugDsWyGoeB6QxPYAv0bxjD8pKFpyei9XMD7DrEEWXCS8d5cFFKEVh5+Gk02ENRP2ARR2ezAWh0uXU3uKIwP7sTihQAexZhD5NavE7NFl/Wt8jQa0d+QTUX/rkN4lVc5RhfXNgkWEvz4dYgb2Uqd0jeyzgPfbW56mm5wG0LC8Hd3RSwj4O7zOBy1AtKP/xz6o6Ry7UvNLrTSNIbM/2u04RWnOj0foLavWk0uDWm3jmA9KmemNsmjMjc0QZ2goKl/g+fwIg4YKMaGTbrFu6y8MJBKppxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igdp7DgjGynX0byHyraevCg0Uq3maD+70nN/+i1rZ40=;
 b=dQdhFNwi0j+Il268jfL2hdOmnqgq2CnIpTWyUBgNGXksq5PY0HMIETqz7W2MsbwgjKrr9Tz1Ja540EBBD4+Ye5mC0Y2vFPgYSYZ9Csl3z7wszmiP8FnFLydcH7wBlVono2z/vZES+GM2G/SyK6K4XcgjK2fROENwPZkeAaF9QVebi9F2/kUA5Eh+9oA6pxGa2YpQWO996xMyU6YbTJuS1KkqzaCQLluCjKk9+085/HLz4WwBHxaQ5P6obbzG1B33TuqD/7LRUl8TOBveACu7sCtumUqg6ATqV78FyAgp440QFgu7qFI+inFKc/AmFv3faFafGthZOSHAhSVCxrGNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igdp7DgjGynX0byHyraevCg0Uq3maD+70nN/+i1rZ40=;
 b=R4e9LyLghyeD07BDTxMKh6i5ogTQIxFijGl+6y5B3bbboASgdrQPe+UGwAvUXs4jVF7LLUZl/wuKg8wFVhdKyWG0xcdN9nlC0wGlnIazDfEK85Ge2PMt0tJb9CySpW/MwMATo9qBTHbQ8e2aYkbvdNYLyroEacRz8Wj6dmYCpEc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB3053.namprd12.prod.outlook.com (2603:10b6:208:c7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 06:24:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 06:24:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Topic: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from
 .late_init to .early_init
Thread-Index: AQHYDOA4k4UBr41nm0+5SXdw0msAH6xp2ocA
Date: Wed, 19 Jan 2022 06:24:55 +0000
Message-ID: <BN9PR12MB525708C0B8C569D03F288359FC599@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220119025555.197467-1-YiPeng.Chai@amd.com>
 <20220119025555.197467-2-YiPeng.Chai@amd.com>
In-Reply-To: <20220119025555.197467-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T06:24:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e21abca2-6df5-423b-9593-3377134595ce;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b8b70cb-ecdb-4138-3fbf-08d9db146903
x-ms-traffictypediagnostic: MN2PR12MB3053:EE_
x-microsoft-antispam-prvs: <MN2PR12MB30539702DC5FDCC009FB4D9DFC599@MN2PR12MB3053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUfZliaTbkvFk46EeiT0lU+DWqTEn6HBladkbT2npzecP3SrD41f6Cp10ijPJIvoKGPd6ajVgej1ByQ9YHazMiTMzvHiPEbargyoKKkeKURDTJjxk6XZ/yYXYyxPMizy0oC9O86DcnJrYej4+rYHCXIPeDTBxJ+LwAI95TAIXWS5BOmFnc6Qc29XjT5WceP2ZvcnDCMtDHOiQu2OimeQNFN0fBeAAr9PeneoR4DPDthyLhf7Boo1Nu9YpGL8MIPVJiKV8Y9/EIqtQZ5edGJ68mVLDn4NUX1KXs0GwkSPGZMnCoc1E+DDGBQO7DhMrL9wLk/j21Zpx76qpw9D8KBRyX1rgdLeCYgCpBlQHXcJSsPOWZOX+9S5GJh/WkP9v+UbOsuauS9Fjvkq61YgT44cAq5dCV8oqrn+Rpn3YRe8u6PyMyotNd3oNwKxDPfSgN3or2rf2nLJsRxDJvNS0sE17irLGTlI5PBBm1rz1lArIBVxjbXjhyf6a/WtI1qntJGZu94fw5SaRJNrg02aju+V01BUI5+kNdcCzllh1LOrbxbwJW6iUvm3hrQp7mmm3HngaIVIha/uxKkafyGVX/oIAg2kYC2jssy2pzp7mMYyv5eH0Wxwn0Iy0e5rR7jfNz++J5saJozBFZh0he6AmleX4BJlffTZJCpWcZy0/yEzOvFSYvaWD13Z/Sm+nZU3N9TGExVLMb/pCKv+107hHMoJYl5upvhUatqIfTuolQ8/qUX0++VvI7XA3hXHVdTaQR83vtmnOHCKWBPnjSoExlzesQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(186003)(83380400001)(110136005)(66476007)(38070700005)(2906002)(76116006)(53546011)(6506007)(4326008)(66446008)(64756008)(9686003)(66946007)(71200400001)(26005)(66556008)(55016003)(86362001)(52536014)(54906003)(33656002)(5660300002)(38100700002)(122000001)(7696005)(8676002)(8936002)(316002)(142923001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GaaUQ1euGAsQiYdWAP0Zvy9D7+9ThPW+JL30EVmMX1F/kJYPtdvlYAxwufvM?=
 =?us-ascii?Q?brQ/OqNJ6UuclRlLQRHchzdRfiVNAcQ+O0rStZF8vPJZVRKfOiwkmfdySSWK?=
 =?us-ascii?Q?EVdUKAb2B9I6Z/TU0ont4ow0ykL0nz0hL4dH2E03JtpjUzFF0bQNj5LKB74q?=
 =?us-ascii?Q?llfU71N20laW47GgiHySFM+6nyQFL4WsWs6fC835somEJ4XWWmRqy0qugQr6?=
 =?us-ascii?Q?vVd1H9f2JgXxKL2tuNn/tKYLThqoROBV7TGMhy0134BrwSwDG6EbMyRzHV0P?=
 =?us-ascii?Q?l5kS+2ng0TV3zTaVBK8iuAwYRP34vxSjSkNFlD3H7NiNJZWCmq5fggPz08Io?=
 =?us-ascii?Q?hrL8KHz/HLsSfzaLC+OyJneHioQ0R3LXGTMBW8urj8UKQtlTcYfN70mg5JAc?=
 =?us-ascii?Q?eFLkGIhgn7+p24dmf+AA4OxegU8bRM5Vn8ccmQIWlLPpSjhkYYByhpltdmTP?=
 =?us-ascii?Q?jYJgy/M6jJ1/AvFfb2rvNrulqhaFGRDJDvUo8ReR8kuAzbPR+fo2jHS693RO?=
 =?us-ascii?Q?g7mfKuEJr9Z9NRqzfuhD71VkEndyqFsAKZIOEF6PJfRnKLA6hdU7kCcQPY/J?=
 =?us-ascii?Q?qTodoZ2NMoQpsBilnNiokVvr4lvXr/mkNy9AG5fAn4PoXrHro7aIVMwbeGKW?=
 =?us-ascii?Q?gTc57dHnNnxW5ZnQhElnNFpJnRrqRxAR05q8bnagJaUWByBbzJJ3PX4BuPNH?=
 =?us-ascii?Q?GFBOiDyW52AhjHTwo1Qed59wv1ZPpg86nJ3JjWQZcNlrGW5Rwk0SZaQeb2C6?=
 =?us-ascii?Q?53y4Uod3ZXxSLTfp0D5JTfb+VPdNexXYSoydvzpD52xx3o2OML67l23TqiYP?=
 =?us-ascii?Q?0p3BqD8fp/Y/bnD0+HZOhEGMu6woM4xoW1LcWzVn1pLJIrg1HRrN3Y0s+A1V?=
 =?us-ascii?Q?oau7j8sbrw1ia9YQw7ACQ0ZD+xtYfV29FDZtPbm2PqgQSLCOdKR6upitN4aD?=
 =?us-ascii?Q?QYqzs9IfI3obAZ3ZYoyKmu9uX94NFld9DI8En4CmRWtIUrVT7RaBS6lUCYtO?=
 =?us-ascii?Q?qmjkZZneuD0NjiAh7vxJjAGt0JaMDhfXtY8IC+WB/mNaGtbWN9ZR102t13+A?=
 =?us-ascii?Q?6gLw4A6nWICxdKECDWnTA3eCFtYdkHdKtzBuXzoBTPtFbkrbSvJjY0SzK6na?=
 =?us-ascii?Q?QebAzLP19JkEs7IyzDTtm+oLmKGoPheFSL6X0DDoo4okRaDeU2v1Jqp5PZFp?=
 =?us-ascii?Q?tEWXhoQW1LRLLA3z5M8gR02yqDgZ4H6PKpNqXgAwj3dOAYi8aE/CcMcbRVoC?=
 =?us-ascii?Q?KNtcdb7YUDbvklHCOkWJ6O3e4kMp83PUn7QMcy6MWNBl7MVj1IJn3fA7zYl8?=
 =?us-ascii?Q?YMeGpJv7FpTOuAbeN2DXfSG53kLKGAjTpu/Wo8+pdwtbEDDiBX4+Mq5fOaei?=
 =?us-ascii?Q?OgGg9DiTJoPLOpv1rWKzv6NtIp35v0FVwJxLz2aLN1Lcu9kf5M2uPuKKBynl?=
 =?us-ascii?Q?hqVFAi6n7o+8qM+s6TdNvQQiW3VjDIpnfPy7VVigD5o3T+4SJh7hLtwLKKXY?=
 =?us-ascii?Q?kdMK3bv4h406zo5V4Inu1fziUatiEWGcFSfc1Y9fne0WR69PVIXEa1CTrZRi?=
 =?us-ascii?Q?ISwlq5UQ7o7p1P2y+04OKCdwuZqyOo3RNEtmUB+Qjbuh8nOfGC/dUknd9V3C?=
 =?us-ascii?Q?rzLk00junYkidpR2Hz2lUVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b70cb-ecdb-4138-3fbf-08d9db146903
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 06:24:55.5684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXk7IT269gUhraF6VtLw4aCQ10d/QvY8zjF39rwC34CwHElMMg1hA3ZoOpM064hnrVVP4Zd0+LlIs2FFVtW1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3053
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Patch is
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Wednesday, January 19, 2022 10:56
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from .late_in=
it to .early_init

Move xgmi ras initialization from .late_init to .early_init, which let xgmi=
 ras be initialized only once.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 -----  drivers/gpu/drm/amd/amd=
gpu/gmc_v10_0.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 9 +++++++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 3483a82f5734..d83eee1984c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,11 +452,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *ade=
v)
 			return r;
 	}
=20
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		adev->gmc.xgmi.ras =3D &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-	}
-
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
 		r =3D adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 4f8d356f8432..5f9f82091000 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -716,7 +716,6 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_de=
vice *adev)
 	}
 }
=20
-
 static int gmc_v10_0_early_init(void *handle)  {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; diff --git=
 a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v=
9_0.c
index c76ffd1a70cd..8d1b11368a7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1303,6 +1303,14 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu=
_device *adev)
 	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);  }
=20
+static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev) {
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.ras =3D &xgmi_ras;
+		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+	}
+}
+
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)  {
 	/* is UMC the right IP to check for MCA?  Maybe DF? */ @@ -1339,6 +1347,7=
 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_gfxhub_funcs(adev);
 	gmc_v9_0_set_hdp_ras_funcs(adev);
 	gmc_v9_0_set_mca_funcs(adev);
+	gmc_v9_0_set_xgmi_ras_funcs(adev);
=20
 	adev->gmc.shared_aperture_start =3D 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =3D
--
2.25.1
