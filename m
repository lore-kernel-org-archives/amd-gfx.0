Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F96EC54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 05:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8095310E569;
	Tue, 19 Mar 2024 05:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BWoY9elk";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52ED910E569
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 05:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+HI2m8evbsc4D63Jeq5Jc7c9HbEpYEzQ6s9zqjU4zABwtUdO0wFpOzxdqPhk49AWSmTG8GZ/E1PRCiVvjT5UdrL5wRpkSmlhFJlFvQE6h4weSHg7OhoLqptd+oXnUlwS4eTphUW7KxpjaATOfpdRWqOAdt+9hdVrgn+82RbQaeHBico/EAHVIfP7URDVlaGoICtYl26sd0LFobZy4WUkcqz3WeVAD0D2VVlJCT2P9enELdECpHfR4s8j8DzVD4qInIlhE6qVdKjxLJRJMGptlekt2Xuk1X1z8P6bhI+NbQNNJ+CDudz6K4qfJfEyjx19XddUt6RU4OoJUxB8QONdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBqmkFNw1Q+aXvZ+w0LeRHlt0Mh3g7fGejSLP+QydDA=;
 b=SeK5ncAGoXBvtlotzkvMiTkLm/LMqdprfYXS38TmbHnQsAU3BhEEhCxkUFMJGigOULz4ZuGH9w4Y2FxTXb1AX6tIVxqBhppoA0FpN/RT5slC/pdMYk8nFD+hEYEL6IbOuxKiT6ZSmwEmUo+oyinDVIi3pMLlGsuVpkYgT79cRhQneJy4wipv82jiK9GLnlBpVoyziIk5D0BPBmcIxdk+i6W/2gpbpSpHmX8byByPNZ5/pU/Bk5ZDjDoG37BXmRP6UzuZTImoSVCGTZsLttO3QFNNFGvSHfXeVF/VdqWrvPNZ8R8xldTYjZAKodhacJBcs2BK0bYMuYUwnUWUmdvEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBqmkFNw1Q+aXvZ+w0LeRHlt0Mh3g7fGejSLP+QydDA=;
 b=BWoY9elk2puexxkB9ifO2lI9eez5gKNwdEbQPgNGVDPaRtxp28iXWNgBdZKbIPgKU0w/K8TteNlPiTYp4s+kHVDn/pDxcuxsjcyhVnFpXDU0t0svIbSjKizlhHuistR2iplDbCPkS37JIQozcJ3xPtcYjkta0K8IJwBH9iAg0Ds=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 05:33:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 05:33:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update setting EEPROM table version
Thread-Topic: [PATCH] drm/amdgpu: Update setting EEPROM table version
Thread-Index: AQHaea0sRb6y7SwZ8kabEJQQmacP6bE+ipJQ
Date: Tue, 19 Mar 2024 05:33:48 +0000
Message-ID: <BN9PR12MB525726FB11CC19D0A081BF9BFC2C2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240319032537.652617-1-candice.li@amd.com>
In-Reply-To: <20240319032537.652617-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e080f7cd-5b6d-454b-8a79-28bdabd49e9e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-19T05:33:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7017:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEv9XwkhuJqGqV3k6Nor5BYkMnuYXiL/Y7SG0D5p8pFg75/79hRhv61EuUgg/rWOMbu7CIIXpdK3cVKmUC725UwtI9rBnYXaBGZvOhorfXjq/PJxQPY0N+nMgPXDWcc3NNia9MfUGLbqAe4ZJX1wAohVZf9hf8sVgWEAHJEJIqZnYgm4qi2TJdkm8nqLaY/PTGt21z2vFwO2DlBVos/+nP0lIKURmMEuBsPcKuJ2oNy/REec/LmrTm/gSOsPn6nNPM87fZm0ODCFV1NnuTQDkKnclWsMx2oOTLvofh+dj+GK7yLndSryCxDfS1zjjF3B/Y2LD1QjF47x9BcxeSFCzPlIvR1mUe837hwKWFhIEs2eHgM8IOPFyd2HzeDCDkfj96IR8tpyB3WgAaI4ep0zdN1KxU9u6Mi+JlAosJeJ6aJm9BC7TC5Yz3t0ZVl/HFmEUuql0DukWfQk1tCocbLMhMQAlt4Ax96ss5gLi6WCiHQotAAEhfI8d9pyh31/yrAFw2i/KYmO5ZCEQQbO6pxZXNwQ2qPnVJ2wUulR+AN0rwbpfT21tP3cEvuXgmqdyagt4pWN6k/xB7ObSRlopRndY2MY6NlAMYh6GOSFqdAbAcmdeQxAifOqowTpXwVGae9RKrITwJXfTYvSLwsLsY/kfvONTjAOf89v9jZgZZW6Cyg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3H7rOw6zLlP1LDfSWbln5pgvkZKizS5IkCs7KCFBtqWg8+LYhzTdPaZAfz4a?=
 =?us-ascii?Q?Qy9gsSfgGirWvN4butVfdv/glrPAdaE7RdOi+CMVhZFxfdAYPlpyrvuSfe4T?=
 =?us-ascii?Q?QnEFtniU8/Wlyvwbu3qoYVuXxkdKc1IKTs0UyDs1EfIajyINpuKCYL7RWflC?=
 =?us-ascii?Q?H0a1cNvo1HCXxjb8fPjppAHUYgw7t22j2Rt2I0nVlMqy1YU83HpS0G9iYNqe?=
 =?us-ascii?Q?twdeMN0Qm9BrBQzjGcqGSesAR2g6L3Cdtm8KQqOmIl2FFp11cE/5vqQPsgiX?=
 =?us-ascii?Q?AS7I6PKPzjszOWnNVAhsjuL8NpH4QGtX8+QKFakP74BTSx4cOldhZ4M4JWw+?=
 =?us-ascii?Q?R38raFS8xEt2QGoo6V8rVn78NN5mykYmbbfTGWRSQj1lXz2BixXC8lvfHT2n?=
 =?us-ascii?Q?qf8RDsDp+R3J5DyXe5m2HdHBGAHMs4FpOUo5U+rxrEZW/yfZZ+S8HM3QKgnz?=
 =?us-ascii?Q?mNztNWm1FV0J4eaSng5o13uBpjQ5Rw2PWSQkq+aaXeFWT4ILqIElDzc/jNtp?=
 =?us-ascii?Q?b0DkH0lkDRFZSbNwz1OQKhOG+dXvDqfCb8mIevt6d0LlcDR+0yZbL7rXkrep?=
 =?us-ascii?Q?oAjaKovHCNZ86jzoDi7L67AXO2EYflTPm6hwFA8DLBeelYrvg2mmSHV5G64U?=
 =?us-ascii?Q?aArBkSJ0COtYvk33/z0TiLt1zF1WEwVGh1Ja13+bTg8XKcXJ8/LXSljyrCwB?=
 =?us-ascii?Q?75gV9aopibmI4Gj4R4yFDOWKGeg33/ObQVk4BZVwmTSSvj5KmmnE/XB0H5ZU?=
 =?us-ascii?Q?k9+vRdduJj+0IZK5mcvwrNuqP+vL6VWdVk8voMc8h8YqKhb2j8lf+IAe3Kn+?=
 =?us-ascii?Q?LHAcxPxC7JFkla3mEJ3JeQHwrLbpXYE1v1MWr39uFW56Y3SNCpACYvu0j5dx?=
 =?us-ascii?Q?r1REOMT2zcOTvBEzPykM3038k9yhibxDHe0ADOMSzaB9bKgFYDiAWw7TlmWI?=
 =?us-ascii?Q?UUdmjX4MbcO5ne2GiynhwA3bmfsLjlSZQTJjny0/GDVPPV9X8vzu79AHNWEH?=
 =?us-ascii?Q?9++2DNDIyxyvCcqW69sEzGQkc6EZIYqU/9QJqqwTB/eskPjYgVemX+GEK8/b?=
 =?us-ascii?Q?SMDWlhW0paYTgJSnu5J8sDNmYX/WiXp/N0cv3w7e8+2imGCrcCczyUkZAsrt?=
 =?us-ascii?Q?tm+MN93SUjhGnANri5KEQa3EsapD+i9FLZD1cWB37oeqHBDIgkWb9tJozNDo?=
 =?us-ascii?Q?G4xi/i2OpYqJKJ8ec+wahIaJSJHaAzar/xoU1Q6LTFRyO0Ngnrlt8ypKYVVm?=
 =?us-ascii?Q?CQFpCYpedTLkWTJpn75EP3KPjnrV7hd5RpYfDrnw2fT0nvheK6PzjPNKlzf5?=
 =?us-ascii?Q?quDkAbkLRoXqfj4cmuEr6wKApa62IjMz9O3SFwitWbxIMbSE9f+Ypdu/IoWG?=
 =?us-ascii?Q?80exaBrgb5Haa7NbAO7kCRwrZQiI1Rzh2s/GrN8Ikw2514XzR14kITJryUBk?=
 =?us-ascii?Q?jOA3l7heO+NkyAATV2GxTRwcxL5E7qcnO5nGZEvMQZXXwIcERFj1FBSTCsYl?=
 =?us-ascii?Q?81x5XHVg1oAR8SinMSoh+RsSTFESDQFMuJG6dhS2AWNgIzk68MzfYfmpYVb6?=
 =?us-ascii?Q?60kTX5lnCuvE8q2hcJORxl2Mi7vCOSNj0aRtk5BC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b7a062-f90f-4f5f-9dc1-08dc47d6271f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 05:33:48.4515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOqtcLsMGPWn70kBjPn6mYngqOy3Rru1aZUZKRzJF/mbjhNoTDFWkVuuXXJfORe5CIymrgPB+1f9iddTcRjX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Tuesday, March 19, 2024 11:26
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Update setting EEPROM table version

Use helper function instead of umc callback to set EEPROM table version.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 22 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  2 --
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c        |  6 -----
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index b12808c0c331f2..06a62a8a992e9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -404,6 +404,22 @@ static int amdgpu_ras_eeprom_correct_header_tag(
        return res;
 }

+static void amdgpu_ras_set_eeprom_table_version(struct
+amdgpu_ras_eeprom_control *control) {
+       struct amdgpu_device *adev =3D to_amdgpu_device(control);
+       struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
+
+       switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
+       case IP_VERSION(8, 10, 0):
+       case IP_VERSION(12, 0, 0):
+               hdr->version =3D RAS_TABLE_VER_V2_1;
+               return;
+       default:
+               hdr->version =3D RAS_TABLE_VER_V1;
+               return;
+       }
+}
+
 /**
  * amdgpu_ras_eeprom_reset_table -- Reset the RAS EEPROM table
  * @control: pointer to control structure @@ -423,11 +439,7 @@ int amdgpu_=
ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
        mutex_lock(&control->ras_tbl_mutex);

        hdr->header =3D RAS_TABLE_HDR_VAL;
-       if (adev->umc.ras &&
-           adev->umc.ras->set_eeprom_table_version)
-               adev->umc.ras->set_eeprom_table_version(hdr);
-       else
-               hdr->version =3D RAS_TABLE_VER_V1;
+       amdgpu_ras_set_eeprom_table_version(control);

        if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
                hdr->first_rec_offset =3D RAS_RECORD_START_V2_1; diff --git=
 a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amd=
gpu_umc.h
index 26d2ae498daf22..5954e839d5808d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -66,8 +66,6 @@ struct amdgpu_umc_ras {
                                        void *ras_error_status);
        bool (*check_ecc_err_status)(struct amdgpu_device *adev,
                        enum amdgpu_mca_error_type type, void *ras_error_st=
atus);
-       /* support different eeprom table version for different asic */
-       void (*set_eeprom_table_version)(struct amdgpu_ras_eeprom_table_hea=
der *hdr);
 };

 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v8_10.c
index c4c77257710c97..a32f87992f2058 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -442,11 +442,6 @@ static void umc_v8_10_ecc_info_query_ras_error_address=
(struct amdgpu_device *ade
                umc_v8_10_ecc_info_query_error_address, ras_error_status); =
 }

-static void umc_v8_10_set_eeprom_table_version(struct amdgpu_ras_eeprom_ta=
ble_header *hdr) -{
-       hdr->version =3D RAS_TABLE_VER_V2_1;
-}
-
 const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops =3D {
        .query_ras_error_count =3D umc_v8_10_query_ras_error_count,
        .query_ras_error_address =3D umc_v8_10_query_ras_error_address,
@@ -460,5 +455,4 @@ struct amdgpu_umc_ras umc_v8_10_ras =3D {
        .query_ras_poison_mode =3D umc_v8_10_query_ras_poison_mode,
        .ecc_info_query_ras_error_count =3D umc_v8_10_ecc_info_query_ras_er=
ror_count,
        .ecc_info_query_ras_error_address =3D umc_v8_10_ecc_info_query_ras_=
error_address,
-       .set_eeprom_table_version =3D umc_v8_10_set_eeprom_table_version,
 };
--
2.25.1

