Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28542C636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 08:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E5110EF15;
	Fri, 17 Feb 2023 08:38:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664E710EF15
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 08:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRj82AGKncc+UjKL7VDuvk1+jlSMjWQLr+3tjTqqygSTX0a7dz7QzRXJYrz5rdSzP+EOHhE84PTNjPgK9/Pm1LJ+u4XVl04hUECu6ymU9rFJGP9JJRjimVj1nwm/R9C4g4qeqplluj6U/8I/W7fWh8kkiJXaM/5l/MeB2bICmGITSmthT3X66QulzqE8nWQsRYXGrPCIX9TIa8A9sJfuTTTMZ6e0c/+2g9lDwjQWuifpp3R5IVTFktpIwU7c+AkBavpxZ+gLxANSL4cfp5t6JoST969KUyu5Vv6+FAouDykisptMhgYmv1NP7dOiowF5+uLg87QQCq3/mLASjO40QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeNnPPtWhQCDSi831Mm6/RpJQsztWN4Kg5Uc3bRQY84=;
 b=g6TAliTa7KfM/0DuUHs5ozcOL+TNAp+St51ptvplm0ZK+vXLCvaM9hxJBnapJobv+/uOO2S2dbwtEfZFrr3eWYHiqukE2SUqpnWuTKp0lFLu85kZZ4yX7P5A7/AK8dXaOfIom/WmJ+WgwRTCjAwcgUS8jK6YlXgwk097ZY02QlJPToaIsH/qHiHMPpXITHKrq5uq2pCsgNvKZRTHcbiMA77mSbTmca1H7jJoktI5GYfmgMajPX0aApVtRJRekU/0Yu9KY88sVlbGzEYWj1EIFfx9+v0UgknFHMdSJiJWZR8uhTBL5spdu7lNvo3RmfqL3RRcyK7DeXARPO7wI/4oaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeNnPPtWhQCDSi831Mm6/RpJQsztWN4Kg5Uc3bRQY84=;
 b=rDcZrnhwZ4SmWKlZEIgO1j+mp0lEYg5/haxlW0uELZUvlC9S1ZoihsSfV/1rkdxndet/fy9dFFiLqeaohv6hayHxEh5PRtI6uwZMt6TItU4rMOwNxGVtXZamqvzRtcgAcqpNPz3hiFIRZXYKLYBEcfDg9SXjePWMS9Z3Le/ZdRM=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 08:38:34 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca%5]) with mapi id 15.20.6086.024; Fri, 17 Feb 2023
 08:38:34 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, 
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Topic: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE
 count
Thread-Index: AQHZQoNkm7Ji3GwkaEy+GWYiKUzBUa7S0POg
Date: Fri, 17 Feb 2023 08:38:34 +0000
Message-ID: <BYAPR12MB461450A76B8CA550CA2E179F97A19@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230217035313.4616-1-tao.zhou1@amd.com>
 <20230217035313.4616-2-tao.zhou1@amd.com>
In-Reply-To: <20230217035313.4616-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-17T08:38:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8f4305cf-a67b-477b-9ec1-55cf62952bca;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-17T08:38:30Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1fb201a8-d73f-4cf6-a32e-3816e4dc3608
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|CH2PR12MB4182:EE_
x-ms-office365-filtering-correlation-id: a02f80a7-89de-4ee5-5edb-08db10c25b70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ct5UX90TsO/riFaQe55mhAOJixUNctIsimCGFwkO4j5s0clLEtSqXnW3AvkXkxGeJwOoXvXTlEO0s51G4tLqEBlF9OoIt2xrTZPfvyR/T42Sif8dkenPgy4IQTAlPK4NhB04lb7FHtpPsaNpUjmvX40SNHhBw63etWLlAM+D2EZ7McTNlSXKSt2wpVGPbfNhCwnaPTFnoBRoQYrfV1PocdcdPb5rVcd1NLFdW9zLoX7wfj0e/VSR51SILsAIlrmKdkoZx5iX1iOTHMzW2FTR9RzqV5Azuan9B2fXP/UePsIVHg43WKqvm1IOCRTSUIQM1J2l3maxiVut22c5u+0omaLuuz0xW7IxOh5A0YGW3TUsAKWBRM7GVriKo+IIEyalRr55uexJyxQDLjbLiop11Qf2QyQapLLjzvI8wbL2QG8GiRBKkqa88Gp8nE6liLa+d0LEogOfh+FMtO+h+lGsE6WA/zkmm2grpckEhzKKFd6GE+q2dmHrFelyU14Ke7oWFJjwGTEBpyraZb4ShWl75hidBOkNCiOew5lO57uKfL94pQlY9nnH5D0CcU9+xRVIc9hnTlqM7m9r+IjX+YM6hJDjwIEAyyt1jgJghvMXZ5lCQKDgqD0UMq4b/zSyLc49IXquED14uGmRJ+MR7bXxZOXFIVsIdT66I86sP09mxo6986j9+DEaJjo4k67gSxUzmW8Anyb4T46Cjivc/dR7FI9CBTjNaf6vOoeTBV/X1uA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199018)(86362001)(38070700005)(921005)(38100700002)(122000001)(33656002)(5660300002)(2906002)(8676002)(64756008)(66446008)(66476007)(55016003)(76116006)(66946007)(52536014)(66556008)(8936002)(186003)(26005)(53546011)(9686003)(83380400001)(41300700001)(110136005)(6636002)(316002)(71200400001)(6506007)(7696005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L6C4GMD2J5az9tN3reSME7rVGq6mWlKBuLKjfJkl2Fu7pWIBSH77SZoKI9v2?=
 =?us-ascii?Q?PRXjCx1LxqeKAsUIfa1hG567GKwZYq4Df+818GAnTdhsRQ5UT0oZcDh0yuxN?=
 =?us-ascii?Q?6sxiLaqIaRknkNyKM5hWsxGDVfCyjA5ETZIM9s+hgf5N8JuV8CVbdv4F2GVE?=
 =?us-ascii?Q?V/oUdMOQGKoHKabA1lHXy8UkFprmUHI2U6mwOb1DblQJYrnuxfeSFrYqEY5r?=
 =?us-ascii?Q?Gh/vSKy8GEosn61r7Utxevycx+8bL0wJLWL3nwxRklo40tpfBb9N9B7Hzh/c?=
 =?us-ascii?Q?jEbmPfpNPxdFHtOP9APSmHCw4JiYIJsLgikRV8mbBWNw41VLN/ibNSXnymwk?=
 =?us-ascii?Q?FjfQvWZ34hs5o+9s20RIRElLN46GaTXb1PuGHSvIFxm7I/9jL9i9SjKyRwqd?=
 =?us-ascii?Q?Goe2EtjGXzZR6TRPY7osr3gGXKk0JsuqfNmvRRVBVA802XHCjP+RD2cARvm1?=
 =?us-ascii?Q?GIfuEFTBVizDvO78kUjfUv8dxxzcmrfkylS+L7KJwf5GWZ/6S9W8BF4+5ICq?=
 =?us-ascii?Q?WlMv8eFTn1xcAh9DEVPz5yxJDNpmhW0bwe0ULnlghL3CDoLIsCotAjYjrAaZ?=
 =?us-ascii?Q?12axdxblA2L0n2RtGTRiO4UgArHhCE1Kqdk9wOwWPG9wkvxn+ZC9BQmOjIzt?=
 =?us-ascii?Q?qM69VBNfLULbmW7P4SfLiykR6SX4rzeI4O2/YKnYia7vxutsHm5ndH36Bspz?=
 =?us-ascii?Q?xGB6vvvDV9t8uIddC3Vjm0/WHPffsWhVBRepIM71aQiCXVDPSysvzs/VIVbj?=
 =?us-ascii?Q?Gvzr/bfnMed603OJpMFsOjdgBG8+xAYK+WFnN2lSSdZBbQrNTxR/IMcP5mK2?=
 =?us-ascii?Q?rF5HcEKJYIds1XMkOe8o0Uvq2LgDDvQnKBTm+I9cCqcu+EWsIvt8+SxlnRk3?=
 =?us-ascii?Q?YVA5nNwoIlOwxrrjZfHqVvt2kkrtCx2JtrYtnWMnJVXfd6XRQSSwIFgM1V8B?=
 =?us-ascii?Q?SDFhBZvs0hXx6YiT5TbmppRAZqqGW0+F/rOpzBJBoeotTru6v5IQ8+cLZdgH?=
 =?us-ascii?Q?a0nN6hTjixDP0IdC9hq9hqyKD8UjuecBC6/kaXQaOjfmKFpQeFgoTCne3c4y?=
 =?us-ascii?Q?Ei7zMIsdhr6Lht4DtdVFpk/YA3iIIV1ETB2yP+Gq18psTsj3RjCYQ+RXni71?=
 =?us-ascii?Q?bIpH4+vMhxwhItgh55nfrfOsudMG9dUWVcQ5zxDkRgmcHc9yiYbYLVqvswMx?=
 =?us-ascii?Q?D8aGiH0rEPbAN/Zj+gZJL98XSDiQdOM3wgNIpCo++aiKSAoQtPsQ9xaEG0/b?=
 =?us-ascii?Q?OtE+kLzHNZvjh4mGcLEfaGmt/UHJQ3LBY/C8/yGrk4t0v8b/IKXJSF/AZAdG?=
 =?us-ascii?Q?JBKBAY7/aaj/L+1UOBcNMLU2iDOMYqKa8Oz6aLyC8aGCasdpPEF3pQ0c6oT0?=
 =?us-ascii?Q?3dQ0o3aTNBGernNGKkucJIjzjAlZtQgD5Pm+bpJ1vAWeM5HSgsuQfv/p6Xo9?=
 =?us-ascii?Q?Syeiqq9t2ZHnYKwQ0HPU7Q1FGK3gS6mOD+kcUxQh1T4Jo+ROlDXmyKq8ovVp?=
 =?us-ascii?Q?4iOKJU65VuKrBuV17aCrP61RsbqJ02l/eZ4cFiBdosgVE1ZWhhfD9meR7sgL?=
 =?us-ascii?Q?n6/w4N4AMUmiP2qKyBk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02f80a7-89de-4ee5-5edb-08db10c25b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 08:38:34.6223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83Eqo4t5GMDq6wDcr5RhZPhPKAD5qZpl3KJW4zMcXvklmaY+kXFQUxsrtsnWQmP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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

[AMD Official Use Only - General]

Instead of adding another function, why not make pages param as in/out. =20

In =3D number of pages to be added
Out =3D number of pages actually added.

int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
                struct eeprom_table_record *bps, int *pages)


Thanks,
Lijo

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, February 17, 2023 9:23 AM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; L=
i, Candice <Candice.Li@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: exclude duplicate pages from UMC RAS UE co=
unt

If a UMC bad page is reserved but not freed by an application, the applicat=
ion may trigger uncorrectable error repeatly by accessing the page.

v2: add specific function to do the check.
v3: remove duplicate pages, calculate new added bad page number.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 23 +++++++++++++++++++++++  driv=
ers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 ++  drivers/gpu/drm/amd/amdgpu/amd=
gpu_umc.c |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 6e543558386d..777f85f3e5eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2115,6 +2115,29 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *=
adev)
 	return 0;
 }
=20
+/* Remove duplicate pages, calculate new added bad page number.
+ * Note: the function should be called between amdgpu_ras_add_bad_pages
+ * and amdgpu_ras_save_bad_pages.
+ */
+int amdgpu_ras_umc_new_ue_count(struct amdgpu_device *adev) {
+	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+	struct ras_err_handler_data *data;
+	struct amdgpu_ras_eeprom_control *control;
+	int save_count;
+
+	if (!con || !con->eh_data)
+		return 0;
+
+	mutex_lock(&con->recovery_lock);
+	control =3D &con->eeprom_control;
+	data =3D con->eh_data;
+	save_count =3D data->count - control->ras_num_recs;
+	mutex_unlock(&con->recovery_lock);
+
+	return (save_count / adev->umc.retire_unit); }
+
 /*
  * read error record array in eeprom and reserve enough space for
  * storing new bad pages
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index f2ad999993f6..e89c95438a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -549,6 +549,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev=
,
=20
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
=20
+int amdgpu_ras_umc_new_ue_count(struct amdgpu_device *adev);
+
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 	switch (block) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 1c7fcb4f2380..45b6be7277dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -147,6 +147,8 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,
 			err_data->err_addr_cnt) {
 			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt);
+			err_data->ue_count =3D amdgpu_ras_umc_new_ue_count(adev);
+
 			amdgpu_ras_save_bad_pages(adev);
=20
 			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_rec=
s);
--
2.35.1
