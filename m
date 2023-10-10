Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2463ECD68F1
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 06:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE8E10E15A;
	Tue, 10 Oct 2023 06:37:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD06210E15A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 06:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8mfPP3T8M5orF3cL9EdUId2B2gm0njOREZ+w1vAR9PDORbqTZaWPpWxnyyE0n5JtLYY8siv6KUR3E2Kt+IOI40bS8+E4tB+Ag3AgRkia6ACXRKhb4+TlSfxoo8Z/SDMQLxxkbZf1bdOYIjiFC5GVGWr15i9Gc4Hoh8O4sRB2uUJggB32afdcrSEzdk/N671mQIz09IcXflYVjDeufMR/AMsB2D502muJC1N2gqWxM0eenrRQQgzJbjbkhrDr6cyczb80eu0/Tvun6JiFijm0CPZz4SnvwkyhAGngfaqeeOBNkVysGjt/GUAXdDqu2Tlz9U2PwlwFYAENKB4ABeOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjQsu4LRIiPddrPzNM//CrWzLYx1fwoK997xxuCmuCI=;
 b=AY9gEg5i5qyHatHzPKQkMThSAyMo1Egq7kLds9l3DmDUX/oIGcQrOBbTvjyx9vEYtdcW/KmtvV+2Bb+laE3Ugm7FZtM+UDEFiaYKgHm3cWHJfF4Aq3JDFwEw4YzUvpy8k5l4IG9TIU3432ZKXpKpmhi5zN2i7Z0Ta6fGozp+g3eY0n6yn5vv+mnZ24byhGELtPOOmPdZGWcOqZKDS1k8rjjUSV7tVknt8N/sQyuWwW8xdpvxS0dZ6IGlww11EXvXtrjStoJYSpSyMGz7XSNaG/IWtxqjIoos5xx9BKwsnoERDghtW3Kng4SOIIzY9tYzCrj05Px7aXEpYYv0s6pfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjQsu4LRIiPddrPzNM//CrWzLYx1fwoK997xxuCmuCI=;
 b=jwPUfVRq3VSaO/N8k18ayVXYegAdunj69pePV+N4yu+JrzntfGMHL0EzFoGzDse6vJMCAEPPCBryscWM12CfgADHConoTekvkUrcCuPMNIMOQXRzTIpfc5NzVhtxyomyaxgNhROg4ZEVVW8O/Lk6nzIuwe5PbNdnNwD7lpLTt0c=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 06:37:48 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::8a99:3210:8bbb:a65d]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::8a99:3210:8bbb:a65d%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 06:37:47 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu
 command
Thread-Topic: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu
 command
Thread-Index: AQHZ+zUQAfq2n6XNZEu5CoLGV+DkjbBCf3CAgAACYlA=
Date: Tue, 10 Oct 2023 06:37:47 +0000
Message-ID: <BY5PR12MB3873406458CB02C0F2BE9A8CF6CDA@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20231010044637.3211216-1-Tim.Huang@amd.com>
 <CY5PR12MB6369E34EA2E32E802309309DC1CDA@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369E34EA2E32E802309309DC1CDA@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8874864c-7f89-4b5b-968b-2c50900cb0b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-10T05:16:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|DM4PR12MB6160:EE_
x-ms-office365-filtering-correlation-id: ee5b0643-9ec8-4c4c-22f4-08dbc95b6aa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJcjzrqfyQ9xOeswWov3aaSZwkze26lMHB2qREOo7tk/lf93cn1qFyqQO5F2fOE4sJ/wW/EWohSQF7VYRyuFHGAisD6xMpNsYMSgHa84vHuNvLwclmpoHxwwdVHzzRJct0wKxH/kfSYdROV01cu2J4QxkyIaO8tN349xaMuYR2IFTSvxKhVrQNgEQRjz8puQ0LmKPAZ+RVUhMni78TOvghT77PzGpeBrYaKeipEW6T7RqvJfVwi8YIvSW6B07+wjPrKxfWi3DGx1fLY228ztJFLEhPDfC2AE6F8Yi3zCwGZfUzZuw5gRU65GAbBdKCGjREJA6WalLHPAjFzJgHcUc56L4tLs/ee8ya0R1Vjx2fERIyeBAOVVYd9GV+F/Ga8gxdpN1hsZSjLzkTCN9eE6SzbNbuJYKuf5vwUhEnGkcdHYMsDxGWcRg2Lln6nE2LDtCxTasm77VfwjoxZvsB6pNcm4FAiU6fhyES2sJoaZSWjytKuSU/EcpvxpzXTIkzupyUeTtD8bhwHoWmHdqOXuyRKeVIOI9VgX83R4HeYNAhe0Kom4UHq+cb0Q3LCPyrcZRN+w99FL/fGQfo7CuJN5l7iRQnNMA1fZEi7X73PuokIOaRCoR4XDuto73r3g/PuK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(2906002)(66946007)(83380400001)(26005)(64756008)(66556008)(66476007)(316002)(76116006)(110136005)(66446008)(8676002)(4326008)(8936002)(52536014)(41300700001)(71200400001)(5660300002)(9686003)(53546011)(478600001)(7696005)(6506007)(33656002)(122000001)(86362001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ipu/fyz1egNY3MyGl/RxhuYfS78aBZxdpwtvgmyNB4sZdFQ91uGGj3rEyt4q?=
 =?us-ascii?Q?w2mdIrSCVQ1M3g1WWv61PaUoHcizj1eHVopcPujRTZV9lLCaGSNFrJxtJoGj?=
 =?us-ascii?Q?VQ6QH32IqUMLMjoybLpTzPXoOdgXxH/LaEOHxHm3hK506cxLijCNDAt+FpHD?=
 =?us-ascii?Q?OZ0fDdequlXSBE3FPHwBxhAd/cFUSLTw2A5hy4WJZz2fwOTlQwZFvMS48SQ/?=
 =?us-ascii?Q?KmQzYWGH7OrpR5tckh24qghRQQYaOQCXi7CmibKUKBKpBTQlBzso6P5cnsu7?=
 =?us-ascii?Q?j8wbvuTjwKdMzXQX1HCm/Zaz3Gonz06Umx22Z0Pt3O1PIUDRquEJ7p2YeTiu?=
 =?us-ascii?Q?HuWWRsE97H5AP7ERqfVdOdi27W6nZucmlZ5OxpUzqbkapE3tleLjQNL8Yn1P?=
 =?us-ascii?Q?j9r24A29OcNXIuUo6++VdhXt2U5O5eStHi2UJIB+/uvZMvl2yr1Vjm4WI43D?=
 =?us-ascii?Q?GjkI/6H7mNpIz2H9QAxznL8p4d1aTM/x2JVaaGObYhz6nvHW+boFmSTkiFTr?=
 =?us-ascii?Q?zUH4W8XwXaMBtAg1+vx5boqD0znf/e7x3WVQW5F+hbZYj+02Lpch2fvlc57I?=
 =?us-ascii?Q?mYom52JcZA47EKxofHoSClayoyBGZ07paaY6rVZmazLh2ZnlyKXo9SrJT/th?=
 =?us-ascii?Q?JfFagRQm2pQ3zGq50M1eZTtulpw/WpPZvK/4uElJwrTPSiMAcJy4bpdR9LLA?=
 =?us-ascii?Q?970TR873mmHczF+h24CFYFSDlcavVs+6smEzv1jboffdpEuIYy2klBhpeRv0?=
 =?us-ascii?Q?OH/bxa+0r+mb06AuHn/xuReikS1ZEXvFJ/NTNNWhyJCIU5QCMBfw8kpkpT/Q?=
 =?us-ascii?Q?UEvujPZ6+g/NodBXftFgMP1zbgnET53WdYH1/fHbPBzJeQG/ivyNvJbXKaot?=
 =?us-ascii?Q?666CFoXptTnw723Z85cC3Vx9f+yDdh/YpsLkDQ7iwtn/3qNsEwPqOPHSxokt?=
 =?us-ascii?Q?sph7xIi5/avk//kr4JmzNgtzrUDBfgB3Y15EAfxYlWuwG1icdFAliTzBt/rG?=
 =?us-ascii?Q?q692ChtjMCBZrNho6DILOEHdsPS6/o5rYZjG4C8bl5HmzxNZMtuDepyjVWqp?=
 =?us-ascii?Q?yeyXsU/i0/viiY+ykQd03dDK6tk5G2GFwrYA/umrzUGE8DVSGHsy0Vej957X?=
 =?us-ascii?Q?6waRgeMFIEcq4xdnHWNjmloTBaLe+A4KQF7iJbh4jySCdeDl5+5fxgZjaYF/?=
 =?us-ascii?Q?Qzx0Lq2xzPL7DX7RLZvlBfvm/S4EOywRA6M9cvuBFkLMyd9lxImVBzUzclrM?=
 =?us-ascii?Q?xMdI3/ISVkmnBi1GLcdY74onStCSHByqu60o2j70jR3yg2OllaPd235nbiIf?=
 =?us-ascii?Q?yfrM7MejCd6didjTYZVQc9aPmYM6tb/Rd7zoVRGF6A3HTru5jVgo8WKQxaOq?=
 =?us-ascii?Q?LmSgBBCaov3gpJe0kijZSod9BtYYiq/d99kg4BQXelVY88GXMe5Xy9MLtFCb?=
 =?us-ascii?Q?ud6YV/crxOJ4y2jbvv3Se4iUBW62KaKM8rYt/yjcYvkpkVuE/4Z+U5ARBUPu?=
 =?us-ascii?Q?LLwvAwgPjyvRX0U+/1M9QOGl0PO8BxcpwZpVEe4xOzVBJzRP6nquXY6aW0we?=
 =?us-ascii?Q?vnTJKXSoBD9iI+Bb1L4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5b0643-9ec8-4c4c-22f4-08dbc95b6aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 06:37:47.1394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uzJWWLUlmpE60Feewrx+fNMC9OfYkmPGTFa3HIFXF8moHHflUcYT0H1Wo70YTJ96Auba0oZPqjdKtZ57uY0DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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

Hi Yifan,


-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, October 10, 2023 1:31 PM
To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu co=
mmand

[AMD Official Use Only - General]

> I'm wondering why it is "without waiting" in the first place ? It doesn't=
 make sense to continue driver loading if power up GFX fails. Can we apply =
the change regardless of load types ?

The "without waiting" is only for ASIC bringing up. Because of some reason,=
 the SMU can't response to driver in the GFX powerup stage if use FW backdo=
or loading,
It may hang the system if driver try to read the status of the SMU. So, dri=
ve will wait a regular time to let SMU powerup the GFX but not by polling t=
he response of the command.

Keep this "without waiting" for FW backdoor loading, maybe new ASICs bringi=
ng up need it as well. It will never be used for the normal case (AMDGPU_FW=
_LOAD_PSP).


Best Regards,
Tim Huang



-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, October 10, 2023 12:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: wait for completion of the EnableGfxImu comman=
d

Wait for completion of sending the EnableGfxImu message when using the PSP =
FW loading.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8dc683c02a7d..bcb7ab9d2221 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -82,6 +82,8 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000  #define PCIE=
_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE

+#define ENABLE_IMU_ARG_GFXOFF_ENABLE           1
+
 static const int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};

 const int pmfw_decoded_link_speed[5] =3D {1, 2, 3, 4, 5}; @@ -2301,11 +230=
3,17 @@ int smu_v13_0_baco_exit(struct smu_context *smu)  int smu_v13_0_set=
_gfx_power_up_by_imu(struct smu_context *smu)  {
        uint16_t index;
+       struct amdgpu_device *adev =3D smu->adev;
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableG=
fxImu,
+                                                      ENABLE_IMU_ARG_GFXOF=
F_ENABLE, NULL);
+       }

        index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
                                               SMU_MSG_EnableGfxImu);
-       /* Param 1 to tell PMFW to enable GFXOFF feature */
-       return smu_cmn_send_msg_without_waiting(smu, index, 1);
+       return smu_cmn_send_msg_without_waiting(smu, index,
+                                               ENABLE_IMU_ARG_GFXOFF_ENABL=
E);
 }

 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
--
2.39.2


