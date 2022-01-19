Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEBAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 17:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D4A10E62D;
	Wed, 19 Jan 2022 17:25:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D311A10E62D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 17:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwW7BDiECa6J9ZmuHPXGyhvpZU+ErWGLGsYS6Kg4pk9BqJprA3leTib+z2roxJ0JYOATzyeUV/nJ62bSaqO+8mDBEdFUnUxQpq+m0H8BKQU54yZWEuI96FmkzHqYoe+2YfNnI3PYNhM73ClA+nA+RYb12VwkFNJ588Ng5EdczBQYpkGk6O0QHiPF0DN98eS6YdXzu/XGqLy4TVgwHg0+no4p9dANSmwbPnCywuyiwavsXsnEc7WfcUUOWe9Kcl75jhTpyC6OKA2TRy2QcihRI1A7bXHx/7M4JLrzJnhrEUpLQDVlw0Jh8ulLeTjGGlVp9/xA8jH5lNKNyd1fBqYypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bma7vTYxPZOz+CHvnQ9Y9VkvUYaUnOFmdK+FFmAKJwY=;
 b=FdVf8dXBQqVbevfHC1XjSpFA0PiX/tiqOB37JlJj+Heu6OKPl7hQjVMW5VTJtMO/z6mdUD5srM+DO6c3n0yQI50GnKrBHgkSzViAcxrXzFQ5jdzmB7oUrzCEZPhdKEFhxbknIxcpDd5eL8AVwWVd8aw9hodJZvpH4WDj5AlvaJrPoxq8yMaj0/gxw2hAy8KfxHgnEBHufzSnLrnsMbkxhHd1gSukukq+ntG5myLCUKO/9ZV5gjcmAwbPyYhTf8wszj1w6Rm1KXG1WLVvh+UR595xV6H6/xQ9+llM0TnnLgxdo7AXCX8MPyDEmzCxRp+xzrwPW+LhSVN4wiL9rdnRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bma7vTYxPZOz+CHvnQ9Y9VkvUYaUnOFmdK+FFmAKJwY=;
 b=WXLrGjK0oBtb1tpr1G8MFrRD5C5gc+H/nSKAj8ZMOrlhJBGmvrneLouA0xDh+yQLNoIxyJaiiSv7Z9AzCcsvTyLy7gOwTkcAkn0KL7+/g0zL8JrMnMdCrGC6QaP33XcUxGnKBR7eTFTemCyj2xTzUi4s69uiPxnnawby5ttcwt8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 17:25:08 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 17:25:08 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH Review 1/1] drm/amdgpu: remove unused variable warning
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: remove unused variable warning
Thread-Index: AQHYDSg4aaP4S5GcXUqcb9S8G4W1BaxqmJIH
Date: Wed, 19 Jan 2022 17:25:08 +0000
Message-ID: <BL1PR12MB51441A4EFDF323DED12B0A87F7599@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220119113048.3432-1-Stanley.Yang@amd.com>
In-Reply-To: <20220119113048.3432-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T17:25:07.855Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: ad026020-ce57-2ffe-72a6-bcf0809a9a6b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aca73f4c-0f89-493e-295c-08d9db70a427
x-ms-traffictypediagnostic: BL1PR12MB5205:EE_
x-microsoft-antispam-prvs: <BL1PR12MB52058B6F31515FC336A03812F7599@BL1PR12MB5205.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +klROqCN3IcT5U/jrVIV2p5vWcfkfMHA1Qq/v2JQGEsuvved+x2borF2873NTSAEF51kK7KN7zS4WbBRU61ESFOMblGrlH51LUt+ANt4jfJ8ecTO1URpNBvGMO2TE0fqY/tuaytBfgM5RJbGAoWz4+5Z/MEMC0TU2S7vOZrk+f0ziRzYkQ9S1fDQiHo9MX1ef+hlCFo2/8yudgQUj0PAwjvRmvl1S+DIHHuyBuNy8cMxAX1i5AJZcPndR0sZ3M+wwetmsk26PNfuQsEbzddoW67LFsHHNkAK/W76EbWKiA0zDz7ZTsYU1QFGXbWjjNljXoflP1RjTalgtPwhN/ngm5kg0P/Ky2ns1NnurrX04WggO7ou73BIoBlf2kNPFpMgH/Ug56O8nIrnrQym07zwe7hG8ngj0okoeJsqzalcEvXbm15iAHv3+88Giienz+dPcYN+kakm94PZM53prrjfmiMeXBM69hwSAZwckIU7H3w1sWCizXIDRVhmR5zuOeRlBYokdTAJ1SVVeDeM6fAKMWT9rdJGDFbyjtyftprnPIenFxWavhC4AIBxHmwnMkQi6GyK9YIQaj/TVvNF9uT/JLvVoCtiuJR4bB1eeqMR9cKd0r1joegIp36r7NthXJeQ2Pe0QGJ4xT1NZyG7qGO2er2ovCOoOki3bj4iNTOxIMbts/WyVHMORDRJi7IAZpNZBKgTIgmk4xqXMvdzGNMJynLuF+QoUjD3+i/on3KfQ5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(83380400001)(9686003)(6636002)(26005)(316002)(186003)(110136005)(7696005)(53546011)(6506007)(86362001)(2906002)(19627405001)(5660300002)(8936002)(52536014)(33656002)(76116006)(66946007)(122000001)(921005)(38100700002)(66446008)(64756008)(66556008)(66476007)(71200400001)(508600001)(55016003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Zfw9aqfrIFsRCprE1ZpIYgh582ezSTZ3iSOwY7WxKw9HPFpKhHcfERzsN0u?=
 =?us-ascii?Q?EsERx26eC2/wG7VK3FFwvl/jKVwPjEQMN0MPf9p7PgUttD1n9/2rWPd5/qbH?=
 =?us-ascii?Q?U8CHZQ1KgIav5SC5JHWRkAOB+Js1JUINO3UJ0ArqErqxFwziwHOul+id/mBW?=
 =?us-ascii?Q?CFVPi9VIfSOFF5Vb3PzZ+nMrx1fWk1NpwWbHHUJeJ5EMz2xrlRGUjXbrfF/P?=
 =?us-ascii?Q?G/UnxVcPAQu0YUsWk+3yMnnB7ObE0291JRrOlj7OnFZNQbylKNZq2gidZhTq?=
 =?us-ascii?Q?pEtiS+4+v9cWS4+Qt9ZgoYwddxRBsqt3LqjB87DfYeCptqDbrbArJA1G7r/O?=
 =?us-ascii?Q?JVDDQmVrVd7F7QlQko4mEW7wP0qvximtnpoeyVVoTMcJZP1+9uGJHhTwgWc0?=
 =?us-ascii?Q?WnzSITYIq3KQS6J+uIxtKzorD2i6CRhcry+NzN/XciXvxJuPxTeueHLOmDpL?=
 =?us-ascii?Q?k3ZAGfLr9B8dbmsTUXmUUKbIUy+PCrX4dzU+BM3gtLIH7tlhf5r3CbsEjT2m?=
 =?us-ascii?Q?jOn2LAxFTpc4SvrOygXmfHohprpbdQ67IrA4fEHQ150+HQi/rkEVyFtLvQ1i?=
 =?us-ascii?Q?L72dYF6k/Kfy4BXlWKETEfm4GOCsS8vitBDH7yUQIteWy0sRzqw/mCSPPa7I?=
 =?us-ascii?Q?lR/3UcqrQXV74Ad6RaET86s4CTZEzeAJMEpqGKoOhJun0b/TDkM1ePfmBrvO?=
 =?us-ascii?Q?U8M7pKnxwahC6to9r37z4wmgAiyRKQUcXxU8GSY7tIjOzjL8khGo11bxtOSM?=
 =?us-ascii?Q?jyluASwxf9rjNDlu9nE7BBjoAa6BTLkysbsEifh8c5zN7dEB3mqPQko6OLFL?=
 =?us-ascii?Q?Fnm6fdmqXN5C/OowDk5v9tsOZ5KQsTT6Of7PmTMcbGVtFlSGu+/D1MdOLvJ8?=
 =?us-ascii?Q?3WBRoSiZRJrjx5x+k1u+Q60QHBbhPF0A6oRY7ryRw5qx9gzKjd66e9PfqsdV?=
 =?us-ascii?Q?2ubUjVNfbIpjE+BBSgTRdZ/1qUXe70NxDt/herjP1lctIjKJpZTkoSmcWW0F?=
 =?us-ascii?Q?6YTVmntxUpS0Xg6I6VtdKfhofKR0D60XAL5gY5TipiJQsnlbcJdmv/+P71ma?=
 =?us-ascii?Q?nYmVXU12mo0Wo7LGACVil5CTp0Tni6qdeooUIbEAKwEyB4GVy6UsIejSkAci?=
 =?us-ascii?Q?ymRfeletJy0oJTFmocS/V976h83lNpQoOHGxbrtgg30XB3a6VEdTaOlsNAEq?=
 =?us-ascii?Q?vlt8ucQUEQKRUlcSFR7Mo/lRGugGPt4nsN5+vlqoacZNqYzcwB586Jx4VpHE?=
 =?us-ascii?Q?J0JRJvvB409umXHhXdgx5nfQ08z6xLU9gevqwFtQ8N8Ux/UrExKnmAW0jam2?=
 =?us-ascii?Q?VLxtbs0aRM/YhWms7+gieM1aN5fRAZXU7YnigTI1rDMq/a71LAYAjKyvr96E?=
 =?us-ascii?Q?tEUSq+Qw/Ord31R+qLXvpGT3QbsxgXY41KQcgdvI43mbPDXStMSE0GxtyOBv?=
 =?us-ascii?Q?VGina3vdZml0qoIyaxYZMn30p8VAFaXRjRbtRxD6RTmyj3xtWp82+L+uzcHn?=
 =?us-ascii?Q?ei9X7X71mdi4ESai5aWlgOauYA4ceuGKV553lehxi2XRnQB63CSJrEauTATv?=
 =?us-ascii?Q?Q81PcbWsfiod5SjtFreNuhdtuKopWrlcpYprnUvGTCbt1IfQNeGb0Aqs0XZy?=
 =?us-ascii?Q?m69ELSJSeM1hYjKp2ZNAHYc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441A4EFDF323DED12B0A87F7599BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca73f4c-0f89-493e-295c-08d9db70a427
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 17:25:08.4923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PghYaVda8x36QP1R/1ibSnc043i+ReZLpTvJ9gyDdZw5qTP+7iGHllnCEp3SgWRLc5oyFX1zRJhoFTWlcREECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
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

--_000_BL1PR12MB51441A4EFDF323DED12B0A87F7599BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Please include a patch description even if it's similar to the subject.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Stanley.=
Yang <Stanley.Yang@amd.com>
Sent: Wednesday, January 19, 2022 6:30 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, H=
awking <Hawking.Zhang@amd.com>; Ziya, Mohammad zafar <Mohammadzafar.Ziya@am=
d.com>; Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.c=
om>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: remove unused variable warning

Change-Id: Ic2a488ee253a913d806bd33ee9c90e31a71af320
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 23 -----------------------
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c |  6 ------
 2 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 6953426f0bed..526de1ca9b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -61,22 +61,9 @@ static void umc_v6_7_ecc_info_query_correctable_error_co=
unt(struct amdgpu_device
                                                    uint32_t channel_index,
                                                    unsigned long *error_co=
unt)
 {
-       uint32_t ecc_err_cnt;
         uint64_t mc_umc_status;
         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

-       /*
-        * select the lower chip and check the error count
-        * skip add error count, calc error counter only from mca_umc_statu=
s
-        */
-       ecc_err_cnt =3D ras->umc_ecc.ecc[channel_index].ce_count_lo_chip;
-
-       /*
-        * select the higher chip and check the err counter
-        * skip add error count, calc error counter only from mca_umc_statu=
s
-        */
-       ecc_err_cnt =3D ras->umc_ecc.ecc[channel_index].ce_count_hi_chip;
-
         /* check for SRAM correctable error
           MCUMC_STATUS is a 64 bit register */
         mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
@@ -110,15 +97,11 @@ static void umc_v6_7_ecc_info_query_ras_error_count(st=
ruct amdgpu_device *adev,

         uint32_t umc_inst        =3D 0;
         uint32_t ch_inst         =3D 0;
-       uint32_t umc_reg_offset  =3D 0;
         uint32_t channel_index   =3D 0;

         /*TODO: driver needs to toggle DF Cstate to ensure
          * safe access of UMC registers. Will add the protection */
         LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-               umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
-                                                        umc_inst,
-                                                        ch_inst);
                 channel_index =3D get_umc_v6_7_channel_index(adev,
                                                          umc_inst,
                                                          ch_inst);
@@ -133,7 +116,6 @@ static void umc_v6_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,

 static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *ad=
ev,
                                          struct ras_err_data *err_data,
-                                        uint32_t umc_reg_offset,
                                          uint32_t ch_inst,
                                          uint32_t umc_inst)
 {
@@ -192,18 +174,13 @@ static void umc_v6_7_ecc_info_query_ras_error_address=
(struct amdgpu_device *adev

         uint32_t umc_inst        =3D 0;
         uint32_t ch_inst         =3D 0;
-       uint32_t umc_reg_offset  =3D 0;

         /*TODO: driver needs to toggle DF Cstate to ensure
          * safe access of UMC resgisters. Will add the protection
          * when firmware interface is ready */
         LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-               umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
-                                                        umc_inst,
-                                                        ch_inst);
                 umc_v6_7_ecc_info_query_error_address(adev,
                                              err_data,
-                                            umc_reg_offset,
                                              ch_inst,
                                              umc_inst);
         }
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v8_7.c
index 05f79eea307c..cd57f39df7d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -114,7 +114,6 @@ static void umc_v8_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,

 static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *ad=
ev,
                                         struct ras_err_data *err_data,
-                                       uint32_t umc_reg_offset,
                                         uint32_t ch_inst,
                                         uint32_t umc_inst)
 {
@@ -173,19 +172,14 @@ static void umc_v8_7_ecc_info_query_ras_error_address=
(struct amdgpu_device *adev

         uint32_t umc_inst        =3D 0;
         uint32_t ch_inst         =3D 0;
-       uint32_t umc_reg_offset  =3D 0;

         /* TODO: driver needs to toggle DF Cstate to ensure
          * safe access of UMC resgisters. Will add the protection
          * when firmware interface is ready
          */
         LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-               umc_reg_offset =3D get_umc_v8_7_reg_offset(adev,
-                                                       umc_inst,
-                                                       ch_inst);
                 umc_v8_7_ecc_info_query_error_address(adev,
                                                 err_data,
-                                               umc_reg_offset,
                                                 ch_inst,
                                                 umc_inst);
         }
--
2.17.1


--_000_BL1PR12MB51441A4EFDF323DED12B0A87F7599BL1PR12MB5144namp_
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please include a patch description even if it's similar to the subject.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Stanley.Yang &lt;Stanley.Yang=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 19, 2022 6:30 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Ziya, Mohammad zafar &lt=
;Mohammadzafar.Ziya@amd.com&gt;; Clements, John &lt;John.Clements@amd.com&g=
t;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
<b>Cc:</b> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH Review 1/1] drm/amdgpu: remove unused variable warni=
ng</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Change-Id: Ic2a488ee253a913d806bd33ee9c90e31a71af3=
20<br>
Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 23 -----------------------<br=
>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v8_7.c |&nbsp; 6 ------<br>
&nbsp;2 files changed, 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c<br>
index 6953426f0bed..526de1ca9b8d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c<br>
@@ -61,22 +61,9 @@ static void umc_v6_7_ecc_info_query_correctable_error_co=
unt(struct amdgpu_device<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t channel_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; unsigned long *error_count)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ecc_err_cnt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mc_umc_status;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D=
 amdgpu_ras_get_context(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * select the lower chip and che=
ck the error count<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skip add error count, calc er=
ror counter only from mca_umc_status<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_err_cnt =3D ras-&gt;umc_ecc.ecc[c=
hannel_index].ce_count_lo_chip;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * select the higher chip and ch=
eck the err counter<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * skip add error count, calc er=
ror counter only from mca_umc_status<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_err_cnt =3D ras-&gt;umc_ecc.ecc[c=
hannel_index].ce_count_hi_chip;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check for SRAM correcta=
ble error<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MCUMC_STATUS i=
s a 64 bit register */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc_umc_status =3D ras-&gt;=
umc_ecc.ecc[channel_index].mca_umc_status;<br>
@@ -110,15 +97,11 @@ static void umc_v6_7_ecc_info_query_ras_error_count(st=
ruct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ch_inst&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_reg_offset&nbsp; =3D 0;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_index&nbs=
p;&nbsp; =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*TODO: driver needs to to=
ggle DF Cstate to ensure<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * safe access of UMC=
 registers. Will add the protection */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOOP_UMC_INST_AND_CH(umc_i=
nst, ch_inst) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; channel_index =3D get_umc_v6_7_channel_index(adev,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst);<br>
@@ -133,7 +116,6 @@ static void umc_v6_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t umc_reg_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t ch_inst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst)<br>
&nbsp;{<br>
@@ -192,18 +174,13 @@ static void umc_v6_7_ecc_info_query_ras_error_address=
(struct amdgpu_device *adev<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ch_inst&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_reg_offset&nbsp; =3D 0;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*TODO: driver needs to to=
ggle DF Cstate to ensure<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * safe access of UMC=
 resgisters. Will add the protection<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * when firmware inte=
rface is ready */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOOP_UMC_INST_AND_CH(umc_i=
nst, ch_inst) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; umc_v6_7_ecc_info_query_error_address(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v8_7.c<br>
index 05f79eea307c..cd57f39df7d1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c<br>
@@ -114,7 +114,6 @@ static void umc_v8_7_ecc_info_query_ras_error_count(str=
uct amdgpu_device *adev,<br>
&nbsp;<br>
&nbsp;static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct ras_err_data *err_data,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t umc_reg_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t ch_inst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t umc_inst)<br>
&nbsp;{<br>
@@ -173,19 +172,14 @@ static void umc_v8_7_ecc_info_query_ras_error_address=
(struct amdgpu_device *adev<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ch_inst&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_reg_offset&nbsp; =3D 0;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: driver needs to t=
oggle DF Cstate to ensure<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * safe access of UMC=
 resgisters. Will add the protection<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * when firmware inte=
rface is ready<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOOP_UMC_INST_AND_CH(umc_i=
nst, ch_inst) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; umc_reg_offset =3D get_umc_v8_7_reg_offset(adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; umc_v8_7_ecc_info_query_error_address(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_data,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ch_inst,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51441A4EFDF323DED12B0A87F7599BL1PR12MB5144namp_--
