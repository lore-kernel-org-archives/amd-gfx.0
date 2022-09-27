Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2C9C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 03:07:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF22B10E89E;
	Tue, 27 Sep 2022 03:07:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27CA10E898
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 03:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrVPlt99Xwx0jlFYcBTHG0ik8yPbNGOvphbuVVO8YDQEA5hywRmvCjnWiCW6QXBbn25dfc1dTzjhweTKseS7N5oEocLbVvdSYbYR1Y5dYr/92QXpzEP+wwOxYVhdMqYi0beHnEpYqwo6Ii2UCwQTzAoZfmo71ZNLcwl7HXd1SySI2DhVxt0OE5tZ2EgIoRteX0sqk3VMiVbUJzghGNnomj4LCpCSwV8V/zvwd9mJtzDEFJ/Na0VCXCSYjmejEyl81Zx9ljtmoV/bA+2jqlwS/0zrAOmUx2EVdtTMbdL5grqQOEVZZoaRFRsAk0mWSlJE1HZxHXwFle1koNxWjQnAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=secAIZDV6rl32plNb9N4VCVQY3Yjb/zTheOYLFcgkno=;
 b=CyMzKwkSCsmpDt0Hlb+GDmmaz8uGBguAUrd/kQqmyTSsX6q0/n5C7IWyTqpyXHLZFxTE1Dsmxk8Kdi472KfMf3MhuDJLkSfp7EL70hT0zsqdoQmGd6CM0VBTl3JM83MFnrbSjoQeOLtmBjLj+8Ct5wqplRsJqg2RjEUTa18fSNSXZVd5d0XrI3DfmyFn453W/TsuRW+HdiD4FPkHPgTQNVRjnv4SQS+Ty68pX+QxK1knxnrA+qG6tLORGbp+5JncDUtstbjIFbvYyT2GF5UdRaaic6RjzSrQzgcB0fJleQMkUbq5UqOXcmOg652VJFwvV7MoA9VnbHR6sdSToB4Zyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=secAIZDV6rl32plNb9N4VCVQY3Yjb/zTheOYLFcgkno=;
 b=kyNbT86sDoILps7wrq56d3EzpoO01WvCoM/qv+skOM79EvX8nwjmdAX6tfzx6Nw497AQusiC7kewGLcDFU/ZkyZwfvVEqmP6bTxau/Atrf9JF/JlKKsPn56xl+WEffGTB0UBLGT7GUnXmBa4OBAmtwZTHnsQOqAbQzWppw8Zy+4=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 03:07:48 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af%4]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 03:07:48 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: make rlc fw loading backward compatible with
 fw
Thread-Topic: [PATCH] drm/amdgpu: make rlc fw loading backward compatible with
 fw
Thread-Index: AQHY0hkUf8XNyJxwvkijJeKBNHks7q3ymGQw
Date: Tue, 27 Sep 2022 03:07:48 +0000
Message-ID: <DM4PR12MB5181812B9C89C0046B925F24EF559@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20220927022959.12999-1-Hawking.Zhang@amd.com>
In-Reply-To: <20220927022959.12999-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-27T03:07:42Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f0f6a2c3-5997-49c7-9045-8567c893a6c0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-27T03:07:42Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 875bb868-d30b-47a7-97dc-35a7924f89f9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|LV2PR12MB5872:EE_
x-ms-office365-filtering-correlation-id: 95a57418-7321-4ad8-d56a-08daa0357516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iq/SEv8t3u4MhkIXGe2sRKO7+d+XK/rl7L4euLOrR+/FX+FSEySq3KzlHkN92BwbMTi+0JMSIcTsHPnY47mUOU9Wn3Ypv5pKfAYLM+MW/NqJDaVIumbrJlvf2SUFl65/8m+K8KaoIBTolBpBiQVG29typ7PUh3fDq0vCwN4v2nyadJbpnzhrG1Gx/wE94wc6fnvif3/YknowOWIZ5vlhErWlqYP19V5yD+SxhwMBJCNbtjqqQKWdnfMSEkE66+nxJhE+giOKeeGlx3AAqOYPzZkHreCj57wiNQQvSONsSLiZP5hVHzuRONw2IO5sFpC/ZiVhrlODQu3Nl/9APGxmMfJi5Miorhn94Ooz6i3aerRDkpbMPtRiH0kz90shioRmgW5V82Tw2OzJZnoDW6A6ep7wd6Ti0kekZjsa1rtvrWupjmY/4NXQzZnOh5EYS0eg7fbEtJMU4B7DUDhglx5tjHq+gL7vMLItXZy1dYT/xAjFKJXl8a+dbCDzRlrajG6tO1QNI0dVbw0jwu2RIWEPdLBUPzTD2PGgxnWPtybBWr28oSZsxS7QRFq+EFMPzY4BrwyD8XQ/h6RIKkThlJ2//Wk73AMZ5t/jSGF4gnWg/8vhmFid0d/FhmLgeebhuk+uazZ/TTRO3MbfBxHd77UTlIwz4DuDkiATeqFxgZRN59EywuhUHtRNKgUaLw/N7JRfydvY9Hg9fTBpl6x9UE61Ma6P3yxCfQGKireBH/H0AvSQrpMhiVyKzPjWD6DGxwhodmN56aZTCSbX3riUcCJLBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(53546011)(7696005)(6506007)(71200400001)(41300700001)(9686003)(83380400001)(186003)(2906002)(26005)(55016003)(5660300002)(110136005)(6636002)(64756008)(66556008)(8936002)(76116006)(66476007)(52536014)(478600001)(8676002)(66946007)(66446008)(316002)(33656002)(38100700002)(86362001)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?do9HkEU5g0DhF7mMFXsqn+OE5lZT0HFJuLoDMoeFy5/dSy1XoNXB2MmS4hFH?=
 =?us-ascii?Q?FiXINC/Nahz0xqJrk1PR56N8D3hZ0SXhxnPiepLM+NcuKQDYnMBbQMhjb8xj?=
 =?us-ascii?Q?SsFuW/CYkWAhzixEYpbOltf+mCMz/w3thTkjLtrgOwMIxs0ckJ8g2D1muT4h?=
 =?us-ascii?Q?hTT999VwFwpztwNvLdN7oS5ZZszIkI8SdBVYkmEY++X7x0ih+YLPyCkI7Guo?=
 =?us-ascii?Q?FBPhvs8xNpEfoLDnLQfhAa6rXKMVfXZm2bx+nQajs2WzbvK1nXD1HxXWYsFv?=
 =?us-ascii?Q?dHZnLeJIgIaSZXb0qcJmgxFe1bWAPBPU8HBneu4aV03xPuB9jnH4t2SQ+YVO?=
 =?us-ascii?Q?ut3j3wfv4VVbEl9At0QP3vrplDj+Jn7O7HaFtCOmOSns1oBrtxLPSa882kHy?=
 =?us-ascii?Q?/X05ksDVuyIr9FHmldfn3UX9kfiMLC3ptdV3L6W6tdGMzeSG/MrwsvAMTiyh?=
 =?us-ascii?Q?LHvWHEPJgYBiPNde6GZLb1BAfwaJ0lhyXlwq7kN3y7FGyUJhqJOoqv2cK3E5?=
 =?us-ascii?Q?H5wfpHtv+LNQwpHh/2xwJUKXxMGnT34Gv7UqfSFQFpJ91NT44PvyMij3hZLs?=
 =?us-ascii?Q?yl1YIYin9jmqEdz/Fq99uWoalBgGsMBIisixzHhGZOU3O4EcTkN7v9iYzI2b?=
 =?us-ascii?Q?zKDkrcfjv2TULinl+TiQ6FS11I66dJAoiQBeAtOBRbB0aJKoyvdLOYguBlPn?=
 =?us-ascii?Q?gbKv8JHI7xwo+xjhb4RCSJgpFVC74CqhpPAA0pzs7d8jvw+92kwY3uKdnA0g?=
 =?us-ascii?Q?FchpwjNA0V+8Jna2Zdwnxv10F1s1O1k7CvQSrRgI90Tqjq+nW51gfiv5DxS3?=
 =?us-ascii?Q?hJ17xl5gfbQBWl7No3YlXo27iX31FmSOpBC2elLjFJBXH0u0b4bh7dRVcdHL?=
 =?us-ascii?Q?//nGOdhXVrFTnimpjv7aLu66D6SgJzpMQsZGGmD2wheoTcIFihe23kI28A3I?=
 =?us-ascii?Q?SuCcdG4RceP23pXVroA555l14EDmx6mPN2hZCwkifgJD8Uc2um0E/IwVoWcr?=
 =?us-ascii?Q?4qQVwdysCUdBV+fGkvFweW8UVHE1whXf5aaY33ylgAWwWoVZmji/KBQg9TKl?=
 =?us-ascii?Q?5gLtoHCd41ThjTjWTCU3BlVJeOsbcuekRSt9j1U3Pa+/rjVFsF3/imQdo2PK?=
 =?us-ascii?Q?dyEqSEGw5qneuxZYBRGmS4e9oHCnpfkTQE42GD3cPEi15Rj59GQSjqhS3N+S?=
 =?us-ascii?Q?7KJkaIgiBR69iOoifykqH14fiQCA63e3U1lKiAvo0NWodwJOrS0+5USb16gv?=
 =?us-ascii?Q?4wvL6mlaqrH5keNw3FvDww3iNJvg8K1XAVVkMtk5Q76tonq7pEBtyicPHycK?=
 =?us-ascii?Q?Qzvno2ZTPkMj7Iy7++0VzTdl8Fqs0X+QgH5Kf8sBmH6FQGyB+bpYdod+fedA?=
 =?us-ascii?Q?Ae/QdAZXB00S3pFdtBnCsFQ73KVi2lRVAy7ZzMSOzwW29/o1J1C1K4jHwb7t?=
 =?us-ascii?Q?xk1gcgtcYpcI8Hm683gThe7YCCwdGg44a4xIrUCS1ekzqqQr0kTkai2L+muA?=
 =?us-ascii?Q?U+jw0azYWBHBg+OB3j9MN0KC8wKfZOAxRBPv6ynbKOAng3VCvuMjzu/gYxlU?=
 =?us-ascii?Q?axnn3MowJwQL4oIIiP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a57418-7321-4ad8-d56a-08daa0357516
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 03:07:48.4175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zar1C1FROVr5DGgToIKiVBi6AvlSFadTX/otLHvKiH7wP/bBmsO63CKq4wYMkd3D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Tuesday, September 27, 2022 10:30 AM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: make rlc fw loading backward compatible with f=
w

To allow kernel change
drm/amdgpu/gfx10: switch to amdgpu_gfx_rlc_init_microcode backward compatib=
le with old rlc firmware

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.c
index 792333206362..012b72d00e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -537,9 +537,9 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device =
*adev,
 		amdgpu_gfx_rlc_init_microcode_v2_1(adev);
 	if (version_minor >=3D 2)
 		amdgpu_gfx_rlc_init_microcode_v2_2(adev);
-	if (version_minor >=3D 3)
+	if (version_minor =3D=3D 3)
 		amdgpu_gfx_rlc_init_microcode_v2_3(adev);
-	if (version_minor >=3D 4)
+	if (version_minor =3D=3D 4)
 		amdgpu_gfx_rlc_init_microcode_v2_4(adev);
=20
 	return 0;
--
2.17.1
