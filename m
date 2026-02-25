Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775F1FD3760
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 14:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D08B10E77E;
	Wed, 25 Feb 2026 14:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwWgzPbB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847D210E77E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 14:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTURfUHCgBoRNuvdWsPbAK2gaXEqIFPfNOQS2wRmMLXvUPIf/04+wY32jrdMnP1Y3umct5EJEcgvDdHXwVeo4Y7cg+a97Un05wUsZEHrUhe3J7aFE31gNw1u0U6XvDH96T56c2tnEdJ93ZOOU045WLn5wJ+wH75dXpEmQwE+4On96tLI4sfXKEbQ6MgAybKSUvLjhB3Ye02I1nzHNNWtB8vSd4Z0CUfkoTkmkeisIoue9RV/2Gr8TNLvGAdM0bWWYo0beFaXY2/yBiVkBaPWIrglVQXRKHBWGyfUvZCbH7zEYAI/TDJs9FRnEQt3SBVQZzW5r63RLoJo1q97DMztaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jDNfAe60ZrZLlirLnS1kYGymgmtZM2a6BQ9HTWnzmo=;
 b=ArOIuPTgx8xU4gEnJ0aFIN2YR/950EP8BujZ8OpPUAS7DtCWs9rPkG0SjjOAdDm5iG6Zh2bLwBP8CfyV0le12dxdwWneFMEarTOoBRgI0ggbV7otAmlBNBrZdU0BHvuJJsgBauZ1Zw998SuZS4CwFtAnaSUf2CHnEAoTfTZksve2EgQvt3a7hlWDqpVfpt4oqI1GPbBjTEmFtWMW2tnYScYx/k8QvsdqldeZuSIcaBnkztKwHhXaKzL1RYIUPW0b+Ucq5/DzZYXG9U2T9kJ73uQmq8tQz4E0fJjBLSTxwtpjO293rPoO499ypVut7OL7WtXw53blOlswbf53O4vqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jDNfAe60ZrZLlirLnS1kYGymgmtZM2a6BQ9HTWnzmo=;
 b=uwWgzPbBJ4wjihdFBPtpm+8+1scRKJfhWOXo68nZuv4eHGefsi3FmyrLCy4rrqYGO4YRK3MnTgBX7e8IEUkrqqPbGNZC6/qFjxR5WmOpZrxSEr3uwf11bOkd6AQ/gC106ndHn1UNRNyVrmGMVAdDuz3HOJLnxMjfQq+S89hTFgI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 14:04:46 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 14:04:46 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "Wang, 
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Add pm firmware info to dmesg log
Thread-Topic: [PATCH] drm/amd/pm: Add pm firmware info to dmesg log
Thread-Index: AQHcplHaHztFViWivkmiAG53lvZ24bWTcrgA
Date: Wed, 25 Feb 2026 14:04:46 +0000
Message-ID: <DS7PR12MB607173F5FEA9AAE3BACB4FD28E75A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260225122507.1956784-1-lijo.lazar@amd.com>
In-Reply-To: <20260225122507.1956784-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-25T14:04:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BY5PR12MB4065:EE_
x-ms-office365-filtering-correlation-id: 9b5be23e-5ae6-4672-4cde-08de7476d502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: KjzuGc+/4oFmRCtnUhrYIS7P9Lkp29snc3q6C5QcvAMy9I541RdDp8qdXihtfA0ghgiWJQXsx4/FJcGbWmSd1E54ZBkjySU84A91mVCGo0voJpj3al/DndWu4oP882XXGIW+IYosZDesjiyHhAHvvoqtZAb7te+WZOL+kPt1j9eeKigwLXKFAxzCK5cm1SmAcLWRBnzATahGChBL2a8PhSBIC3NjfNhurIVd6oFmatOlGWouEBJGsvUaiDfsbye92zvJh9iKSu8ayXVsV5S/7smiJ2O8RgoMYRBEaAx8DXg0C3I/xNbmSpThp3XxagYd5n7kM+AXf8qL2WiVL+G6HjpMuUckfYlZEMNI+zqfMOQpEA2TC44Xgmi4A430eDD0vGWMnxJaYbz2YEnttltXPbAX+QYe0Xf89IszQLrGdiadrj8MWguKkw5P2LvnNY0Zm4BtfpfwYrNChqr8LBCmAMWyptso5k0PwsxNRZIxV16gbC3WnP+DEhoLNpEEkH1MIUwUVHm1s62Y3Gpq/9I/kr87NgbD1vSEQAhNCMvmHN/0khRq29SwY0QIxTrFuiYR1pJI5jvftEoYS0Fa7lMJ8cHzwwKNK3lTMdnc7+50bysTBZs9d2UmqcBshuJ3LBeOm5HSj8bmDZZDno31QdJ/2ggMtK75d4aXkV7dhJ5o+SdgomSZBEnofHclfrcdAItPNWn/HuPZH4pfotRRCUMYlJvWERikSNz/fN3WrOC72vHAM0VLVkKCbIuWRVuUMs0GTvmeOmPMqHnYuIw9gIUoHurdzdKa0BzCATaxmfe51mg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+oHRgllcsTBQ07RcmvQMJ//VGqJ0MO+AcXorp0uKGFrSW9QwJrePLoDAMbtd?=
 =?us-ascii?Q?NqgDE16CSu0wB9vq0w0BhQPGF9bih9Kh25DmoR+KQ0kXr56fF2RVsVxyJ2ZV?=
 =?us-ascii?Q?CQ8K8CwC7rhhnPIMl1RwFBTICFownZ/7tzs6MwQE3Tey74yAJ0h3GzJwixvC?=
 =?us-ascii?Q?Bzf/m//BHPtpGhAH4D7N4I2hJQVpY84BIDUWJy0BANaz5Wp0wq+q+K9u2gkK?=
 =?us-ascii?Q?41YKD6sO9LARPRGFmKIbNvMiO0Qio+EcZ33pc61nXdzLPGgiv9gUojB5pAlR?=
 =?us-ascii?Q?yypOCrvD17yuLFQ0tZE81fs44UN308wR9x3VWBbCpq0RJdI7piSZuARpQNP/?=
 =?us-ascii?Q?sjFn5IMeL5BfTPJPfmt/8auZFKdabA1Hq7Z2LachSd3OsjaAf0UIVlZX+3kr?=
 =?us-ascii?Q?XrO1Kq8t52z0vV1WKM9SAvOfyyZqKVmZ4M9Jo2zUgiUWgLRGGiX2mhxUYa70?=
 =?us-ascii?Q?XTGHaeL+WoyY6SF77fMAXe9dV0ACTi9mCyzVYju8H5izdkgXdHWYKbBAMD/+?=
 =?us-ascii?Q?jIooFKh33vKB9tTdlPy9+y/7+yEyvoP73D7sWo87WVQUjeeXTXevcO37Kd/I?=
 =?us-ascii?Q?CHlJqL2kaZsK8YI4lDhQBGs4CRiqSnJwf/XHHyzwCXc5dPvK7w3zobYhHCjk?=
 =?us-ascii?Q?iZAG6wC4wnhuktXXD+NO9y7OSxs4lUYJz+GLrGlyhdiHmSOU/186ctuJoHIx?=
 =?us-ascii?Q?iEPJ2dbPfy4vLQdIw9uaJdhyNIFRs2xuCsezghXFvpR0kumzy9z0MeDanDc5?=
 =?us-ascii?Q?lBXWO4sCNIZ0vPvnxCpiPLzDSECti4oRJxh4+ef4Cb5DJQE/xqzHBxXkStMQ?=
 =?us-ascii?Q?ObohFv/PKMZG+Wo9C9Yl56pz5ETLBu5zkRyWZQL48momc8Am5a3RD64AuFHj?=
 =?us-ascii?Q?FxmD1x0ATxcPfGHQsK6yCYzzeQjmSnRi+r34NMQkOzkUtaPxWtiJZmbYlRKf?=
 =?us-ascii?Q?k8sttdUMg/XTHpYVIKT3/quUOHg8C7mqGjIfNK14qVNPzhqUuYNzZ53NLZfi?=
 =?us-ascii?Q?IdgrIj2MsiqKV23MV0Z+MfbS4yTnsX7L7LS2Z56zkXMOaV5i0UZ314Fhf+Mc?=
 =?us-ascii?Q?absh59MoHEKONON5IOV1jJd5cj6ieybsqD6pRTbcfJssGlggmRpaiekqQrXd?=
 =?us-ascii?Q?RnrdfZ2PZjkxYtdnCWzsAtn4W2ccPQbUPuUsMlx8ilhyonrwodOXkXA3MSIQ?=
 =?us-ascii?Q?BjVgHyjl3GwPEXgBCe3bflOUa05bCyImqFSAkiv9b2OXKrBl6OHPBq8fLv4W?=
 =?us-ascii?Q?yEUPyfzFaA8UsYffBiGseG/3HPL807y6ZJDX6yejOudqel1wPTs351QtMLzx?=
 =?us-ascii?Q?9nV2ZiE43s3Dx1RL6KzmfudGL5BxW9roxb5GZn/Q9CnLB7l5MocCI1w7mGdf?=
 =?us-ascii?Q?/YO2+QM+vSi4sY3gTCtovUZdDR1CAqF6Gx9cfbo1m/0S2nEHHFkcwnoerZVy?=
 =?us-ascii?Q?9tLkftKPhFK/RsM8xmXKnGaR+HA+oX9EL+itnAPOqTeFE787wXLCZH6ucMjs?=
 =?us-ascii?Q?snluKbVvgEqJfVUBhyd7batFreqKVXaaz45UeUXNjUJ1WdKOBasKRqpWF0eb?=
 =?us-ascii?Q?7VRmvIO3Dsj65wUtqp+A/wZzUiUVw4s8v4fX3YTyQvylXRxurrg1JnTpo0Tk?=
 =?us-ascii?Q?rGEFxfjmFGZQYO11KKtv5Coa1MdZLqPrwPELpzkHSo9UUHRaQdpYPkAleh7I?=
 =?us-ascii?Q?BNS3nM/k2j3G/fMw2wTuZ51aEVPg/NmnkdnslJN2YEcz+4Sw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5be23e-5ae6-4672-4cde-08de7476d502
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 14:04:46.1712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUvfx1jewxY5yRIP5z1QehVUH742Hkx2HR7z5i9gtD5tkgoLzXa5HG/FJoDMqVF6bpSMUKhjtAM9Ky8MPb1JtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, February 25, 2026 5:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Gadre, Mangesh <Mangesh.=
Gadre@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Add pm firmware info to dmesg log

Add PMFW info to dmesg log for SMUv13 SOCs. It's helpful as diagnostic data=
 for some driver load issues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 63a65ea802fd..1cff37d7f60d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -288,12 +288,13 @@ int smu_v13_0_check_fw_version(struct smu_context *sm=
u)
         * Considering above, we just leave user a verbal message instead
         * of halt driver loading.
         */
-       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
-           if_version !=3D smu->smc_driver_if_version) {
-               dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu =
fw if version =3D 0x%08x, "
+       dev_info_once(adev->dev, "smu driver if version =3D 0x%08x, smu fw =
if version =3D 0x%08x, "
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version,
                         smu_program, smu_version, smu_major, smu_minor, sm=
u_debug);
+
+       if (smu->smc_driver_if_version !=3D SMU_IGNORE_IF_VERSION &&
+           if_version !=3D smu->smc_driver_if_version) {
                dev_info(adev->dev, "SMU driver if version not matched\n");
        }

--
2.49.0

