Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32753C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC0510E2C7;
	Tue, 21 Feb 2023 14:41:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C79910E2C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 14:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7L+/r8dwlul+mPvsS7RvGEnkVrQfb7MQPyab6X7LsDe21mB9I7/shX0UrhlvBCAl6VUU4Kcm1egqfvMoVH/4sJpqZuUKM2h8OXmTMYo5NNDcd5+48yI82kWzJkvssoKSC09t+ZOOftinpNkpuQwCSPs28Mv9c3+IoC9pTE43AXVf+ZvpxvX/mZspFPdcWX/5tAI67QOCBFHglw336HeN6/PGQCk1vmJL/P9uSDmrtLDNLN1+fkc42kMmfn0VXJBVANQZDTIgbYowqiyu7Oy83rL+i1FA+BCNodQX5fUKxdE6oqUeG/Vrh/tRmeAzjDBkdwjcZe1hXoaogfPM9sLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tivnInh5goLz5S3HKG0wWHH+ECuEmQerww+jAkw3K6E=;
 b=IZsvNpLj+YqrXITElJ8gtzVyUcN06TR8VyWcmxElRBU/5c3cvA+nBvrhXHWtgWrry7ZbPWBJHv+NDUM/ns1u+AEI5QfNtdfZsWa2e4wXOxNVhzKgpcSPXhrLAW4u04wVBShbOCCvkXfzibRPL8HJXMPn9ECEPIYsL7FixCZAzBldaVdjOER0krOH9rggSsXx2iUsEw+6nDWg8D1UkDkHQIGCL5goZigHgqNX+qnpJAUxQrpHGj0DLU7rPu2Q0I5QwTqpew919Sx9HGVzDiWMEoHvw8e87DUp8Dc2mOQZgIOehHrfCs5MCZ8JJF0EQpakO/3YdnVnydRVRL0leuCF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tivnInh5goLz5S3HKG0wWHH+ECuEmQerww+jAkw3K6E=;
 b=iTuLwf3nkQj4i7dRWj/0IApxt7UIoG5x2v7wpFANi69BEUm2x+7+FTbyA00XTVw4BsBhgdCuOAa6TZ5lbYg19UEz1UW8WxnnL0uaKrhQEjJ2MVpUTklK17xeQzA51LRhPRtxj5ZoAgbZG0fPNGN4p8hE5Ro5e5obfXTzb3fIXxw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 14:41:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 14:41:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amd/pm: downgrade log level upon SMU IF version
 mismatch
Thread-Topic: [PATCH] drm/amd/pm: downgrade log level upon SMU IF version
 mismatch
Thread-Index: AQHZRa7/sg1TYNrqukO3kl9pu8g8HK7ZeZ5p
Date: Tue, 21 Feb 2023 14:41:05 +0000
Message-ID: <BL1PR12MB5144D92A91D4B673EB145191F7A59@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230221044241.4167588-1-guchun.chen@amd.com>
In-Reply-To: <20230221044241.4167588-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-21T14:41:04.844Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5946:EE_
x-ms-office365-filtering-correlation-id: 24882068-b0d9-4a9b-871d-08db1419a99d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpNbw1so+VujtfZTe6M/RtFp6fkV/0ulgFM3y69ChloTLsXRJrGtHvwJpQZE8cuwH/VtCF+PLGBCFJklIYYBtn32CRWNmGUlCNRAqSLPTs9yFq6gBDpTCVf8+6Z190MtDBH2i0yh97AJUfNERZl4xDzp0ZPVC2nNcEeXTLO4okgReOLszXcl8YPB3LH9yZEa0Xt6EXsemLvNNo6nF3g+7WQs0Zctc6H1oebDTSa8F0jsuSCSSDGxqpmZdTnHEvJuiZII9//k/MRmbqVaGbmY5xHPEfDQXh8vXNDlcJWgrraGlNt+TciIkYj0b8PsX/v4BhhutP6fM3qiWHRTlIAW39AEnXd2ZzChdd7f1sU87t6zmO+DMJdlHUeVndzzlWBldjAa+J84SGI/V8lMBLH3cuISAhp9HD64hJrLY9iSa5zxAASk3j9/AGuzRUjo/nXBbGc2Mbw9D4I92X58o98N6Ma7PGjAV5U/vH0OLa/h0XKbdtdbCUeHuK2M18XRxm9R7XeX/va1uMhnlJMlEwYl7FCQZMneDG0UaR11A4L31xjjOoo8R8WptTwPjzkQwxJnmXLzUGmQPIbxQOMVaq09Vn4VM6+z3JxW1MtVcadAsdms2zPCamMmkI9/oj+NS7kcLbhK+U3Iq/SuWK/jlnjFlhpfJmFPLKPjcZTsSGnTZGViIkG/oFTnPJB9EtR8Tu/RsKzQdJW+BSRb655+tMinO55+3KqiFoLR0idw4zBgF6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(38100700002)(2906002)(186003)(26005)(41300700001)(9686003)(38070700005)(6506007)(122000001)(921005)(19627405001)(53546011)(5660300002)(8936002)(52536014)(33656002)(316002)(66556008)(66476007)(71200400001)(86362001)(66946007)(76116006)(64756008)(8676002)(55016003)(478600001)(7696005)(66446008)(83380400001)(6636002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v0vg8UIySvACj1InKhZbo3olUISUm22cVJUwSwFYNIbfgkkxjBIbMZkCCPyY?=
 =?us-ascii?Q?FbRaDLATloyoaVlwMHdfmlEYs2xIJLQ+F///Kbda+7B6zC8lut6mrmisxh6P?=
 =?us-ascii?Q?CeGKOQfFuRcjbuaI0hbx9t/tZ5HeorYzGZbCoGmBKYGJgKNJh3ppCgjnUfaU?=
 =?us-ascii?Q?OSVQtyzx6Zxge4hkB3Iu+LpCQoje/XNOJnDpsWZgHcJb8dNGaJwlayYo8o2I?=
 =?us-ascii?Q?K+n+qrywJbgVnKczzzfNQVaP0mho+RSjK0QC7JFLvD6mkhkyX0OaV7JQ+HMV?=
 =?us-ascii?Q?iQ1yj3wVIJEwwnL+Ro02hUPi/PAHlxM6uxxctsAyjLmetu+d21MsYUrqvzeT?=
 =?us-ascii?Q?a6ObQ5BdR+wnetYf4WSnFDt8IxXzl/DM1akYoYnnLhy+BxcdQNWahvSHiKYG?=
 =?us-ascii?Q?4w628dxu5xOEwoctbfj288KxqgX4spgWHkhWUFsyQxugTZ6Juxepjcq4mGYb?=
 =?us-ascii?Q?8r76h8695r+dspKPevQH8/DwxP8jYyDpdO70eUFsadnn3808bDaSelZt//SV?=
 =?us-ascii?Q?58bccSabz9C7q2gbWwiLefDKViNVGA/Ht1ee7TtN+7HL7nm7M9wtqS3gfE9I?=
 =?us-ascii?Q?NdcNbhnCeVWAnZOGPN36/WHnAklM1Oratgnp+X8oBog9+unOyEA+SoGcNOe7?=
 =?us-ascii?Q?SFi4OAAbRGVGa7KMbc2Lc3p3NgUa9k3M+UF/IxlWf+1GHHSTX43itYesiLuG?=
 =?us-ascii?Q?MPxKPQPr19flWE5+foE5M5Bh5Y8UAbJ68zrdo/7apQjsAJmXtmOeR2VyVBkQ?=
 =?us-ascii?Q?jAyzjvEJLnKNUd2RN915jRatutJYw+C2E2eqS4c6w7i6q40fbyzFP6Eahete?=
 =?us-ascii?Q?8muX1lSbYtBHBp3h+b08olE6PJR7JRxoCEIBmYRl7kAnV/fOIk9rGXOIt9Cs?=
 =?us-ascii?Q?g8d/cw6zbEvKRMUr4tqRAOftsG9ydx66oZeUwNXcfOdD2NB+7FNblKriEgFy?=
 =?us-ascii?Q?HyXbLeOMHvizaEgbacJLcmCsHCXdFvNSZ4bNZ6zaJ6woYlgMeyjXJUmETN8H?=
 =?us-ascii?Q?oqIHIw0eSTiuwc3/FLbXwAuWfzsQky12m5LEEeXoj6/PFpt8YzKXuN6nxFyd?=
 =?us-ascii?Q?V1PMPa7clHFv1peExu5SDv/yspdGMPDOFZ4RsS9dNm70TXrjBDhLX+KoQgSb?=
 =?us-ascii?Q?5lkjz31TPhMkO7fO4036dKWAthFT1CpQB4UEm4ya5NA83hCMTF0cgS2DyHDH?=
 =?us-ascii?Q?C/k9KlKNHB0rMSkfO7ujuuD77igzgwNsAEn3nuPJCPU9sLjmw8wffS0spXq9?=
 =?us-ascii?Q?FGRYef5SPYEqM9Wz1YQ5NIFOyRspPvXSon3FsD19OTQTBH8t4ORYlKD5gngK?=
 =?us-ascii?Q?Yo9ufQbaNkUUM/METRyUH705gqOaT1E/Ijxe1DS3aI03HLdw+XbrisJsCzAa?=
 =?us-ascii?Q?qeXkYt7w3/r9/5XBjzzfAHwr9ly7RwFSdeGZedVhEElBUGS6IUttreFRQROC?=
 =?us-ascii?Q?O+wV7JKHrxBhr9SVlRVoZadRufOoJPRUHjwgjp13LBw1s5N7yJMK5bnLlo5b?=
 =?us-ascii?Q?NDje2lLPj3jKmOUdrPLN4cUYjeeH1T52FSfIC9uMvcFFABfpSZFfr4YtVunw?=
 =?us-ascii?Q?D+jjUo4TjAesRbMmJ8o=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D92A91D4B673EB145191F7A59BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24882068-b0d9-4a9b-871d-08db1419a99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 14:41:05.4999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgpo5d5dC1czszlGqA5W74T7Lzqu3s88dIO6C/9/WwAm6dxdKsCTmE9LlNZ7FHvZwIS3Y1GVzyB/Am/96U5QUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
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

--_000_BL1PR12MB5144D92A91D4B673EB145191F7A59BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Guchun C=
hen <guchun.chen@amd.com>
Sent: Monday, February 20, 2023 11:42 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Feng=
, Kenneth <Kenneth.Feng@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: downgrade log level upon SMU IF version mismat=
ch

SMU IF version mismatch as a warning message exists widely
after asic production, however, due to this log level setting,
such mismatch warning will be caught by automation test like
IGT and reported as a fake error after checking. As such mismatch
does not break anything, to reduce confusion, downgrade it from
dev_warn to dev_info.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 6492d69e2e60..e1ef88ee1ed3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -256,7 +256,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
          * to be backward compatible.
          * 2. New fw usually brings some optimizations. But that's visible
          * only on the paired driver.
-        * Considering above, we just leave user a warning message instead
+        * Considering above, we just leave user a verbal message instead
          * of halt driver loading.
          */
         if (if_version !=3D smu->smc_driver_if_version) {
@@ -264,7 +264,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
                         "smu fw program =3D %d, version =3D 0x%08x (%d.%d.=
%d)\n",
                         smu->smc_driver_if_version, if_version,
                         smu_program, smu_version, smu_major, smu_minor, sm=
u_debug);
-               dev_warn(smu->adev->dev, "SMU driver if version not matched=
\n");
+               dev_info(smu->adev->dev, "SMU driver if version not matched=
\n");
         }

         return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu12/smu_v12_0.c
index 56a02bc60cee..c788aa7a99a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -93,7 +93,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
          * to be backward compatible.
          * 2. New fw usually brings some optimizations. But that's visible
          * only on the paired driver.
-        * Considering above, we just leave user a warning message instead
+        * Considering above, we just leave user a verbal message instead
          * of halt driver loading.
          */
         if (if_version !=3D smu->smc_driver_if_version) {
@@ -101,7 +101,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
                         "smu fw program =3D %d, smu fw version =3D 0x%08x =
(%d.%d.%d)\n",
                         smu->smc_driver_if_version, if_version,
                         smu_program, smu_version, smu_major, smu_minor, sm=
u_debug);
-               dev_warn(smu->adev->dev, "SMU driver if version not matched=
\n");
+               dev_info(smu->adev->dev, "SMU driver if version not matched=
\n");
         }

         return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 78945e79dbee..25f336829840 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -311,7 +311,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
          * to be backward compatible.
          * 2. New fw usually brings some optimizations. But that's visible
          * only on the paired driver.
-        * Considering above, we just leave user a warning message instead
+        * Considering above, we just leave user a verbal message instead
          * of halt driver loading.
          */
         if (if_version !=3D smu->smc_driver_if_version) {
@@ -319,7 +319,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
                          "smu fw program =3D %d, smu fw version =3D 0x%08x=
 (%d.%d.%d)\n",
                          smu->smc_driver_if_version, if_version,
                          smu_program, smu_version, smu_major, smu_minor, s=
mu_debug);
-               dev_warn(adev->dev, "SMU driver if version not matched\n");
+               dev_info(adev->dev, "SMU driver if version not matched\n");
         }

         return ret;
--
2.25.1


--_000_BL1PR12MB5144D92A91D4B673EB145191F7A59BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Guchun Chen &lt;guchun.chen@a=
md.com&gt;<br>
<b>Sent:</b> Monday, February 20, 2023 11:42 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Quan,=
 Evan &lt;Evan.Quan@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;=
<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: downgrade log level upon SMU IF version=
 mismatch</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">SMU IF version mismatch as a warning message exist=
s widely<br>
after asic production, however, due to this log level setting,<br>
such mismatch warning will be caught by automation test like<br>
IGT and reported as a fake error after checking. As such mismatch<br>
does not break anything, to reduce confusion, downgrade it from<br>
dev_warn to dev_info.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--<br>
&nbsp;3 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 6492d69e2e60..e1ef88ee1ed3 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -256,7 +256,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to be backward com=
patible.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2. New fw usually =
brings some optimizations. But that's visible<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only on the paired=
 driver.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Considering above, we just le=
ave user a warning message instead<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Considering above, we just le=
ave user a verbal message instead<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of halt driver loa=
ding.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (if_version !=3D smu-&g=
t;smc_driver_if_version) {<br>
@@ -264,7 +264,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;smu fw program =3D %d, version =3D 0x%08x (%d.%d.%d)\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&=
gt;smc_driver_if_version, if_version,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_p=
rogram, smu_version, smu_major, smu_minor, smu_debug);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;SMU driver if version not m=
atched\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(smu-&gt;adev-&gt;dev, &quot;SMU driver if version not m=
atched\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu12/smu_v12_0.c<br>
index 56a02bc60cee..c788aa7a99a9 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c<br>
@@ -93,7 +93,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to be backward com=
patible.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2. New fw usually =
brings some optimizations. But that's visible<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only on the paired=
 driver.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Considering above, we just le=
ave user a warning message instead<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Considering above, we just le=
ave user a verbal message instead<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of halt driver loa=
ding.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (if_version !=3D smu-&g=
t;smc_driver_if_version) {<br>
@@ -101,7 +101,7 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;smu fw program =3D %d, smu fw version =3D 0x%08x (%d.%d.%d)\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&=
gt;smc_driver_if_version, if_version,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_p=
rogram, smu_version, smu_major, smu_minor, smu_debug);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;SMU driver if version not m=
atched\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(smu-&gt;adev-&gt;dev, &quot;SMU driver if version not m=
atched\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index 78945e79dbee..25f336829840 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -311,7 +311,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to be backward com=
patible.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2. New fw usually =
brings some optimizations. But that's visible<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only on the paired=
 driver.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Considering above, we just le=
ave user a warning message instead<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Considering above, we just le=
ave user a verbal message instead<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of halt driver loa=
ding.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (if_version !=3D smu-&g=
t;smc_driver_if_version) {<br>
@@ -319,7 +319,7 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 &quot;smu fw program =3D %d, smu fw version =3D 0x%08x (%d.%d.%d)\n&quot;,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu-&gt;smc_driver_if_version, if_version,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 smu_program, smu_version, smu_major, smu_minor, smu_debug);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;SMU driver if version not matched\n=
&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;SMU driver if version not matched\n=
&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D92A91D4B673EB145191F7A59BL1PR12MB5144namp_--
