Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7E4E7AD77
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 16:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6A410E2F9;
	Tue,  3 Oct 2023 16:56:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB81110E308
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 16:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVkQxtgczzZO085seFWKJMB69/8K1GsP3EVDDjqdd16U8/JJK9cU81Pr7t+rhexHJqy0ydxD7lGgObl9ckuTO1Yf+7mhLG17a3ilS6ftj/JF5+Aj8EV2MgSxk68uJe54oN1VA450AYOYueLTN0ifaUr+LiT3WGmvqTz8k4Sr8/eW4Dn/sHODzaOmmuNs/q1nUy+1YfRt/d1y2LuDciViDib/ieTtjVN7mt1qxlSU5oqnGtg5kd8b0fLlFzzdm1PGEDIoFozV8uQEWxjL/GF5w7XaMCZmEiaNqh4ggtVBF5zKE7HieIdFUOx1QS/hpFwP62GZ+cYLyK+BWZqqOy/hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEbSUINAIBnvltH+UtRKg07GQ4kfQuxH7EE/NXJ/FmM=;
 b=TZd6ruUGN4FdmeuIT1LKlp+Z2IZNvz9GaY7CghZhOhW17lxLsMg3OUUH7bS4GIiB6W1A2OQhv1ZuwmeMKrRVAhg7Qj0BmuVc4Fo4ILNxrsiqb6oIDjoUhpeZH4abiViCMd2KiGZopGxvhVXQ3DK4t2PiqPwk9dBJMRewT5dBR0d+B01+J2TRQYJtJjP6W9bWWVj5lfl90WrAO1q4Nr27nSwYnetlkDGbcxcEm8AX0K5Fq2vGKAGp2Uowr3s/b9MPd6LzhDKrCTbN9776SDsHpvFwp6BIsK8u0I/vcKggTixGuLHQwrJTMnkXa7z6YYteeKX3Q4OxyLxLThANpNNfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEbSUINAIBnvltH+UtRKg07GQ4kfQuxH7EE/NXJ/FmM=;
 b=DrMGMAKd8HUJ/cwQNXOxB8LigrwfXA0jLqqJRT+2wycJSbnDlZ+EtnqqobeYm3T0tbogz6gJK26xVKHTgoBrXCMpH6YzWDDG/XJ05zGGMSizfNFRxLCo/M/jptyypLnPaHmO0k8NDwo0hzfQRfdUNg4MXR7c8F1cslA1U2ZmKBQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 16:56:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 16:56:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Thread-Topic: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h
Thread-Index: AQHZ8rirX2ubxQn1WU6MMVs9gTL9N7A4TiCAgAABHzA=
Date: Tue, 3 Oct 2023 16:56:21 +0000
Message-ID: <BN9PR12MB52574E3E72360B80498400D5FCC4A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230929093747.1456991-1-lijo.lazar@amd.com>
 <BYAPR12MB46140B2BC136AD86842813D697C4A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB46140B2BC136AD86842813D697C4A@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=17c31194-aa49-4f65-a967-ab4ef9282718;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-03T16:47:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4105:EE_
x-ms-office365-filtering-correlation-id: 6f2c770e-8853-44cb-c38c-08dbc431ab94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OS5fxls+eCowN42CRcvHb59IGWN50NAOKwL1SKaRM1HqZZy3JcyrsltwHCSW7j+ZtZXPu3I7C9KbzYXEd7KXba+o9I2xzilTu3KwegLBfWh54nkHCvvbzl0Lrq70LleoZJeblQ9GnB9SuRmDV9Jp8279+neEufr8dQALwCbcTL5aC7QIlU+bM2+lsWZShe+eOeC9hHg98ZKB38n9s+2nRD9VkT6sEQdoAHQjjJI/ZlSzPT6G2KmR2P6xWwNbMpcM/Q4KMbpmnjklfNTEW2K2aDh8JRXEKs3aT3lA2mKeed7ylqE6QdO7kE/0gyUIo3VviG75NPIxBnRBV0KU+qOUUwXrMsNU9MHBTxpUvU8McLamh1ansA88gCVnB84YgPn2ZioOUxoLWFwDNwlfw/7BkWHV1GqhncV4lW9Qj8MTHDM4fg/tKmkSiSK+lcMS+KM1Ec5VyZTIjSSR/8+eXkEFDyFa5Zi7w0zRU6NdYeagp47QAQivnqQeomV3WXp19XRFcA4b5jUeoPla/UBy3zDh6GetXU2z7b4oB9xaWRbbbjHNVfs0Q+UU/ua81y2U/ZEWMqn1Pg7IRo0RUcK7kgNGvi7oq1yojWpP5Uz8dIiiyovZN/qTyBeBVXdXy7tYTfU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(55016003)(86362001)(33656002)(110136005)(76116006)(66946007)(66556008)(5660300002)(9686003)(26005)(122000001)(2906002)(6506007)(53546011)(7696005)(71200400001)(38100700002)(38070700005)(478600001)(66476007)(4326008)(8936002)(52536014)(64756008)(66446008)(316002)(41300700001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RfhU8nKm8lllJNJZBHViCWDpLiPDH6GOVmB3db0WpS6ZYZr5DSmk79juUh0M?=
 =?us-ascii?Q?C0NSxkiycZ66oH3d1PhGCQEQR8iYhKauAqN/GG18fq9uOfx2bKVTgBPYCat4?=
 =?us-ascii?Q?ei42kfp+pUNlKJDUyk+ETbxSKnCsHXFfvojsDixO48GxPOe41RU1zoRStW9y?=
 =?us-ascii?Q?UQC6vzOgepVE1FuogcskoGlEg5Is92RO7WI+QzLjAKdCc58a35Km9KeP6FDP?=
 =?us-ascii?Q?c1bzh4fNAkZDGCAXIbpZl5zYdH9/yvk4+uH5fz8XjKurJQ0Ppvj6p7i7oK04?=
 =?us-ascii?Q?98ZWvioq3DmxD1/AOx+ZaWAAdx+L45r9RzEN1yZo3kMr2VrEIQzwCWQOTRLu?=
 =?us-ascii?Q?OYcm8tB9OhmAzD6+xr80RHKdDDo03Q+uj2ucXBUq8Dj8SMD0pdDTN9urTom5?=
 =?us-ascii?Q?AvSYieF+upcMfAm93iZeupL+p07+s3aOIWZJAPmo0eQ/rywGPHLKqPLg1PUw?=
 =?us-ascii?Q?a+UDV369EbuP0sIECnCqJTEazgMfzaLIK7TC0KYrrqM2N0z5vggqBNYC8iI3?=
 =?us-ascii?Q?tZe5jNKl5WWZ5FlKdY+vTQwo1ok4IWoGGfIl0wdJeYxQEEc+9Msk6irDUVig?=
 =?us-ascii?Q?zk+kgizz2XYUhime+rJqKa4wwfExABb2j6TXdjsQlPTkKXuNS4xe0A5SOQgh?=
 =?us-ascii?Q?tYC2BMONCF6Rl20fGEb6G35f+IW2XRgXuSLhBvT1Jd2tOjvp4keZoaWiuRpO?=
 =?us-ascii?Q?SSwgqoW5Lv4hbLQlSQR0n0POzRsF9CVFp55+LVxzqIOSedDS57XjHwm0Jvct?=
 =?us-ascii?Q?n50b2HVBFgZ2ZnWNvxL4HMGXiKdHZROj5OOGsryKMelTESZZKFV7QIRnEHr9?=
 =?us-ascii?Q?JSc5xI9tbQFqSMZMtAvUjAGCj/NquL5FaX4kEOgNaZSY5imap7fT9X30JTDJ?=
 =?us-ascii?Q?1D2uL3gYRzxRUTae5NXh/h8JxA6U1G9RVnqGovc04TcbJoZYDvYNGtx3bP7P?=
 =?us-ascii?Q?x0fdr+1yAhkBp82e0sQoMLy8ekAPgmG2vhg41e7teslBYdeymDvVDqFb5OWV?=
 =?us-ascii?Q?qK/CwmCxI1zJ0CKc/mVvTX2XmMo7v+XU9yi2lwW7+F/+rID/QcrG4f8PbW9Z?=
 =?us-ascii?Q?MYRC7C1dBTivTbs/uQn3U/WtnoxZxJawQBJ5MEg2qOZyYtgLGsQBRVArN6/W?=
 =?us-ascii?Q?7QZhR8tkloXjduHX8fjUH2LkB35xEP0Di4jHwcqczfaPy9WiSe6oYZTCEOyw?=
 =?us-ascii?Q?QSnH0cp5H4wes8Ym1W/hcLxf7Ze4/6DZInFchMXmKHYeWxOw7qhfLELrfq3P?=
 =?us-ascii?Q?LtDtyW7AUivcsGdNdnHcSfDt2BZCmG5jjnes68uozBAQoPoeTud8Pg3KqOII?=
 =?us-ascii?Q?6Y/Htyc1yfiB78Bp6W//0yWavhwL3rpXLEt4Vfum0outIZqyHSZum0MclSCd?=
 =?us-ascii?Q?FxoQLqd3Tue7SqAJ/oxknUxi/v4AJfiY3gQ1EV8cAscGlHxvfWYOib7CWqUs?=
 =?us-ascii?Q?7MnAfWja917xUuTBxSGmCyMNEEoWfG0TDhV9OmBOwfa6B2BIhFb5OhtFaupS?=
 =?us-ascii?Q?VFjyd3hFNyEScW8NL/xPbWqCbcqVJnjp+rFSPKzXxRegkcEsdF2TpT4ISJRs?=
 =?us-ascii?Q?WBGtJw1xqWK3t7GdwEI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2c770e-8853-44cb-c38c-08dbc431ab94
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 16:56:21.3732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tW3rG+9trAT35TSpZ2dB9KokSZNyKJZlhwGrmaNSvedUsK4zypyuF2woRAacsopdbRUtC6aFeBpKCzWUjjUgKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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

[AMD Official Use Only - General]

Alternatively, might just keep the PKG_TYPE definition in amdgpu_smuio.h

Regards,
Hawking

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, October 4, 2023 00:51
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h

[AMD Official Use Only - General]

Ping on this series.

Since there is no alternate header to put device property other than amdgpu=
.h, this can be moved also when appropriate split of header files are decid=
ed. Other than that any comments on this?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, September 29, 2023 3:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Move package type enum to amdgpu.h

Move definition of package type to amdgpu header and add new package types =
for CEM and OAM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 73e825d20259..ac048a77e97c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -302,6 +302,13 @@ struct amdgpu_hive_info;  struct amdgpu_reset_context;=
  struct amdgpu_reset_control;

+enum amdgpu_pkg_type {
+       AMDGPU_PKG_TYPE_APU =3D 2,
+       AMDGPU_PKG_TYPE_CEM =3D 3,
+       AMDGPU_PKG_TYPE_OAM =3D 4,
+       AMDGPU_PKG_TYPE_UNKNOWN,
+};
+
 enum amdgpu_cp_irq {
        AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
        AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP, diff --git a/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 42ac6d1bf9ca..7088c5015675 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -69,11 +69,6 @@ enum amdgpu_gfx_partition {

 #define NUM_XCC(x) hweight16(x)

-enum amdgpu_pkg_type {
-       AMDGPU_PKG_TYPE_APU =3D 2,
-       AMDGPU_PKG_TYPE_UNKNOWN,
-};
-
 enum amdgpu_gfx_ras_mem_id_type {
        AMDGPU_GFX_CP_MEM =3D 0,
        AMDGPU_GFX_GCEA_MEM,
--
2.25.1


