Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67C3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 04:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FB810E9D1;
	Tue, 14 Dec 2021 04:56:52 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB5710E9CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 04:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAJhxgxKZ5QnMeIn49ZHFZJ8zbF0UtAw1EulugFfuwE0utmrITqrxsJIDOzB80PE7CNM1P7eDmaN+aNpgEnCaWbNO5+2YlFGkNHQSIV/M6NzY//qnAy+M2muDmlG6jdTz/NX/QNi6FCelCgl3EK4s+NeHvpeqpTF13jfoNnIJks1U+4vFV+3O/BMulldVdgTDe/ei8fYpwM3A+F2VLGuXj+Q52K1pPRKxcV4C5PXVdeFvWxOWAC/anjACPWgUgE+eZX0gRa6cFrCIozyZvPAlBPC67xoFdjhBdC2y7vY26GUlCHrnrizb9HhTH8jFQh09R4pX42mFYPsM51Kjra4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH1MbaBFaNH37+MwGtS9a+kYvWWLsAYJfp3BZyz+jDA=;
 b=CZHa/FACvjLf4UD5teDyKGAkLCB7TBzeMwuBLi0uOh6uCKBjClWwGOXaH2G+o2nuxcycYsq7qgPLYBxsCVdzPGJaiCrHdLrn4c24k3TiEEpGLU3LTnm0txhOMIR1ivTzht2tcm99Pk7g4CLVgNPo0nnS3pTDNhfKa2TXLAS1znB9rC2XeGJSnMSu/givA97J+pOXLCdybKdI/7K17x7YWVGs1qyPasdSfa+Lr4kUge/QVYL0zw1wAY4wr463Tr5XIdP+K+bqeH6CUKCRNoedsl6oFTlEr8kTBgD94AyuoIXy9wI6/V+hPnK8RLvkYUdw9E3NG7VjrklUGLSRo8RoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH1MbaBFaNH37+MwGtS9a+kYvWWLsAYJfp3BZyz+jDA=;
 b=TgBBh++C6C5QjADpJNY8CvKA3T7lm9vRAVGF8e4v+VxAxnsAkd0pUL8oSApEfR3pPjVpnZ7Hxd8IRzP7O9dh1vu5wqAhohsT+Qo8I0okqTDwlACfW175z5V2gvqzqtFP3foGAzzyAYoXkkHpNTlwrVlmdTGf23gN3qcmCxwq9Eg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3577.namprd12.prod.outlook.com (2603:10b6:5:3a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Tue, 14 Dec 2021 04:56:48 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 04:56:48 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drivers/amd/pm: smu13: use local variable adev
Thread-Topic: [PATCH] drivers/amd/pm: smu13: use local variable adev
Thread-Index: AQHX8J7iGqCPNURaLEOf/OHXa6LTlKwxbJ1w
Date: Tue, 14 Dec 2021 04:56:47 +0000
Message-ID: <DM5PR12MB2469259253EBD37C8F7FA814F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211214035826.14930-1-mario.limonciello@amd.com>
In-Reply-To: <20211214035826.14930-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T04:56:21Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fac5d92d-4ea7-4b25-acc3-9090267fdcd4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-14T04:56:45Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: ee8cd8c3-c651-4297-8679-64150ef0e9c0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbab309f-14de-439a-5264-08d9bebe226e
x-ms-traffictypediagnostic: DM6PR12MB3577:EE_
x-microsoft-antispam-prvs: <DM6PR12MB35771C511C4425403851E656F1759@DM6PR12MB3577.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:138;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QfYhmlXGpAntfo8hUnzjrDjX7KDK6Gg/fGf+czS2i09/wF2gzblIPOoLHh5tHw1jy5ySYV7BgeA+35/KZVDcwA6PeBWbQexy8y9145UIOF/TZbY2C0pyvhqERuFV5Q4WHl9JzGKjAx1+v2NLaXRgSrhqVKWBZPtRTqoKNDZ8doyA2SPDmRzoZws67xlRZ7KI53mDjq0F4rU4Cp0uOiJmHnBNQuv+NTI5+f+BsXoaFVA/ezQvw6Rxklwll44IeUjxJdmj9GjK7PWaesw/klnQLyz3y9K+kOYPDwOBcRghYRGK+XjDaLC6hmIq6zt+nCMYa7lcEz/+9WovU9s+12fERwcHpGEpMdp0y19M067j9OdGPt+9ySRzTeQGc3vwjqVfnDn4k4b6ZbS6SF4gp/qwvgKU+4NNhQht55VNFVJsi34PPnYgdMkyPv879asXVWW1dYXHbCMBySyrCTCvBn0Pvh7vwhODfl+5grRcOedaHDtHcLegIwWobr0zXW4dK/vNgEbHb5itNIPEWtkc4geZOl0Dly2GkLo1TUa7gjJApDzzETjoYou/++jxC6v7c1FWkQQbLJcLXZjVkvkREIOcD0ta6AahxbWSzS77JKTmdj95yglwtvfoHze2V+9iPIs1i9B1bpzEuaw5oWmCHGKjsa7PanXDjauzO6JVVSW9f3StUUSvYOzive1XY/hTpKFnblGLvIGE//BAX/7P0aMe1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(9686003)(66556008)(122000001)(26005)(52536014)(33656002)(66446008)(76116006)(2906002)(7696005)(66946007)(508600001)(66476007)(38070700005)(86362001)(64756008)(71200400001)(6506007)(8936002)(53546011)(8676002)(316002)(110136005)(55016003)(186003)(38100700002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vb+CAEtXwAN9llJFjGgRR3rIlbEnpLwGLLsDSraBdbvd3r1OV4Cyr+XuuvEg?=
 =?us-ascii?Q?NiOQwC/3koLGHvt6tvbiT7laP4MBb4uIKY5dEI/lTelZuBU4gro8/KCdAYeH?=
 =?us-ascii?Q?sX5mqe6bsXFRw4NisLrii3ecuMO7364fXrw3QT4quVLscg/41wDSSH/Dd1K+?=
 =?us-ascii?Q?27Q6OKlsoxsuPBVSDt2AWSI5Yn5FpBXIJlNKVjtEuFeWLL9AF0JTSt6bp6m3?=
 =?us-ascii?Q?baK2BNFJXv3WkbfsRLy/m0v0d8x+IRCKQj107cNpT6k80B4YHbCQBDm0Xfsi?=
 =?us-ascii?Q?C97ci7qf0t3T14mrf/e+7+C/8n4K5c8QTrzGOWh/SSK5d3GutPdGUkHaVsqg?=
 =?us-ascii?Q?EsaMjAPH0Fv2acnBpvbxHblpTuZ02ocMTKZBr5/EWjB4Gz1NFUN1tqg0XpBP?=
 =?us-ascii?Q?mCJVKwGH+NLxmUG+FOPyNPg1yc9v7olpwVwuBX99rWcJmzkedzvUouR5FVt6?=
 =?us-ascii?Q?MbrU0VExziFSrrtfQXdI7tG/5vrnnUttZgNlKS286BJ4T6/fIfIZbcCx4N0o?=
 =?us-ascii?Q?WqMSVNT6Njur5NteHN9rcwLxi65HvRyQBaNtapZzCuj/83dtEhLUruy2Q+bi?=
 =?us-ascii?Q?8chgFsgRksDTCISy7YZo7Pr0l7SY9LeRyyFqC42gAbvSSoMwx5se/5G/CzJg?=
 =?us-ascii?Q?biXyoXz1tjTOBQzSE4qQJ9wodWyMQCrUmTt0q7dNfi302O8L3FzDleVefPHR?=
 =?us-ascii?Q?hqfVl7X1sQRw0xZkZC+tqHwcXBfmxS+JoaZ4OD+jZlnY0mbykv4IEJEmcQkz?=
 =?us-ascii?Q?2LTCHBaWaftu1FWrzpzjEiC4uWNHVgLGDxvhrbJGummZRZGEKfvUqkS/O9Ce?=
 =?us-ascii?Q?GoralWrW35Sm2i4DZiXnwFUmdd3bjlUAIeZhbjTOR9my6tuJ1w8lUIiats5U?=
 =?us-ascii?Q?wBkVE6EtYwc/DzuSNaxwTaefMaeueL4nlHRBE6lpD31E8hojZy/FD1RwRhvt?=
 =?us-ascii?Q?bZLWs6pwTj4mHoh0yPxd4hCwowYLKvQxKLLUBhnDfut3C8BylHoAX9YyEKoV?=
 =?us-ascii?Q?br21QXi5mOCJL2S1vpiSdKnMN3V7yfpGEj6qCVK/lfV9rdHayci+6Mv+5reB?=
 =?us-ascii?Q?8XccgGR5FIFqdhSssRmuO7o2NBWBD7YQXjSyhvb6zoi8JfK94ui3hCZBZvP1?=
 =?us-ascii?Q?TNzsROMQg21pMiZtvjDeFfLsZ5BEP+dwD2c2NidN7J5iw1Fw4ugvU+RIYe1r?=
 =?us-ascii?Q?miSoYzWtLQQvUWIKEfWUwdDqMXguqpKKAeDy8BiiLHB1tI+5nT6aJw9TxJFt?=
 =?us-ascii?Q?imawmnPZ5VyXdFpiwj158AApz1Ol/g+6UWJ2RAt0GpHXpWHVilsTdSBab9s3?=
 =?us-ascii?Q?g+FfDTC1iX+szaLNfC5V/NKhKX7Z/d2aeO87pr4TQXXlrnroCkyFcvw6/86F?=
 =?us-ascii?Q?9OWRhafQfXnNVp/tq75HFbOGtSStDcbosH0yb45bumIgfwQ8zKuqplPBirPD?=
 =?us-ascii?Q?vWBdF9lcsuZYMYrZ86Z1bJFevjiVs1Go/KsiXXGphfLb76d9oIctAAQMd+Wg?=
 =?us-ascii?Q?llhhrZSRF8rfxrvc4DERK40KeGCOuhm2RIgYn4iwDFVZHNnbCaDdWfqV5Kkk?=
 =?us-ascii?Q?vker4QQtetyVdJR3vOQfnAy6azw8gpaLFVEKbJyqalsCocd6vJDXzS/i0i0R?=
 =?us-ascii?Q?O11WHaafNpUEY9+P3k4E4A0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbab309f-14de-439a-5264-08d9bebe226e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 04:56:47.9573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16luNyVPXs2CTNRM9qaMBfhB4S1CvKT+zStjM/jV3ksMtJUezGt/+omJUXOUsPPJ8U7W6UCoH2wWRdE/+Rysdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3577
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

[Public]

Thank you, Mario.

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>=20
Sent: Tuesday, December 14, 2021 11:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>
Subject: [PATCH] drivers/amd/pm: smu13: use local variable adev

Since this variable was made available by the previous commit, use it to ma=
ke function access cleaner.

Suggested-by: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 677a246212f9..bb3f6072ed30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -212,7 +212,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	if (smu->is_apu)
 		adev->pm.fw_version =3D smu_version;
=20
-	switch (smu->adev->ip_versions[MP1_HWIP][0]) {
+	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 2):
 		smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_ALDE;
 		break;
@@ -221,8 +221,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
 		break;
 	default:
-		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
-			smu->adev->ip_versions[MP1_HWIP][0]);
+		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
+			adev->ip_versions[MP1_HWIP][0]);
 		smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_INV;
 		break;
 	}
@@ -236,11 +236,11 @@ int smu_v13_0_check_fw_version(struct smu_context *sm=
u)
 	 * of halt driver loading.
 	 */
 	if (if_version !=3D smu->smc_driver_if_version) {
-		dev_info(smu->adev->dev, "smu driver if version =3D 0x%08x, smu fw if ve=
rsion =3D 0x%08x, "
+		dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu fw if version=
 =3D 0x%08x, "
 			 "smu fw version =3D 0x%08x (%d.%d.%d)\n",
 			 smu->smc_driver_if_version, if_version,
 			 smu_version, smu_major, smu_minor, smu_debug);
-		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
+		dev_warn(adev->dev, "SMU driver if version not matched\n");
 	}
=20
 	return ret;
--
2.25.1
