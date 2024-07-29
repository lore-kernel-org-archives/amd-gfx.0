Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C27C3DA64
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 01:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5741910E0F0;
	Mon, 29 Jul 2024 01:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MgC/Kg2Q";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3ED10E0F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 01:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlMaUbLatlqgKR8XVUfuIqWleZhEpjjaphfO39AU0ApkXY4w9MNEdQSqU+4Je4cCFKKzHFMpfXocGz7j7IBgB1Q/u3/bBHk6Ai4utYZjrzsjDk7XnL8nQpBHYZ/8p6H9temsL51NV80/cSQSiniQLWOLJ7TaMbnC518J5V3kS69atO/SVIbjfn5SLLwb6jBHuDqqkulg8ZsaVKmuFG6Lrt3UpCOa2AzmVsdUUpl4V1s9E2AnjqrudLR+YWbj2RjqRulEo2VhuAfi8YboTP6yS3KHP9WC927tX9nLS2Cx719aviI0X6dhVM8mq1EN/XW6mzEkTKm20CUvXpxkyppVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXSOSziSbu8uMkZ44inaoL/AMik7AAyQRKRgyBqb6vg=;
 b=VcYMr7xQKbG8hik9gEcQ23lV66Wal2bWm894rxh/4h/37MMZVmisddXZyp6xGrtLJqdhQcFtxQSetYQLXaizS9QSGyRhbI9HAViIP/7OGqRfp3MAGI7DoTR2JJUwqKqbBy3xCT7yJNtpo1vn5B2vNgb1t1Ljj8G9QccDB7XHA6m5LtZFuGqd/cf0FtnjIv/5RZ1z8r8wJrWwVTRJDYslTBau6UH7tXS7pSuFPu6lggIO8AilGSf5muaB5J5lXMmmMhl56/pW/9vRIMk6gUKo7ceFHJDW9cYVCkGdscpuw96v7TEViPMrNIwW8Y0KM3IJukP5LaGG0WZnqSQEY29Vzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXSOSziSbu8uMkZ44inaoL/AMik7AAyQRKRgyBqb6vg=;
 b=MgC/Kg2QFW7VA86AAgz/2bfeH6I9qB5lH9leXhAPHABOdBcHdFrl4n566q0r/SHMV+D+cN/BHVgRke72A8kXuEpMlITugRImUjQDgX0LgtN5OUf/BNZEcgdX1munbGMy6hjeVSUJvRdaBYAClYByGx8QEl+ewSWScL0N9c0Ad5c=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Mon, 29 Jul
 2024 01:38:09 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.7807.025; Mon, 29 Jul 2024
 01:38:08 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update powerplay structure on smu v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: update powerplay structure on smu v14.0.2/3
Thread-Index: AQHa4VZDBFWPdAD4wEmVZbXIQwNjaLIM7Ssw
Date: Mon, 29 Jul 2024 01:38:08 +0000
Message-ID: <PH7PR12MB599715E4DA9A8E9137A23D1C82B72@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240729012550.186285-1-kenneth.feng@amd.com>
In-Reply-To: <20240729012550.186285-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=81c1b946-5485-46da-b9c4-0b6594d283ab;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-29T01:37:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB8449:EE_
x-ms-office365-filtering-correlation-id: b1b071cb-411c-467c-a1db-08dcaf6f19b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3lW0u4ZaXcfqlJWZ3+fBayaIVuYO7lTQhkV3+pFKR5UV7KaJf+v9K+bsrTLY?=
 =?us-ascii?Q?qxcOK/lKI2wIkbCnVKonOtw1pE71w5KrhsgjHPN5uxSbyOvJ7iU5l+wzKsjD?=
 =?us-ascii?Q?avxM/XKWfHy8Rbr1t+zO1fqTW1XFIMK/3tHSSbMvxVzvCtV0G945yh9ex8Fq?=
 =?us-ascii?Q?QQvxuwh5Zhfe2LRDp9/i7Riex5OQP43OC18tkupPm0pSFtmUB0WtJrwW3ikQ?=
 =?us-ascii?Q?hZIoe/hlPlVw2if7UbHPRda4dtuSfNG7nFsiFzLmkfBMmbRWwXh1ZWE8AxAA?=
 =?us-ascii?Q?QRT8UTYaliDFBJIRMeIwyLacRZEO+JFNPs0PCWpsrri9lGQdQpcvCUosUgsB?=
 =?us-ascii?Q?SlEfFBf5CYh+Ecokhjuqt59pT/hDKXX3HLjUeorW901RfLDLwG5RiT18PlCx?=
 =?us-ascii?Q?k+0WcVgO5ecL1BPOCvSfEBtk29pCw2VLoEkjNbqFI/E7M+FXex8nYbv2RApS?=
 =?us-ascii?Q?ZbWPdtktXU1lMD9JkjOludksbSynfD3yRulb9SP/ecYu2idHy2CTVDc0rWZU?=
 =?us-ascii?Q?DAN/roLAXsmCwnlDCtVQ8WT0SeFDF1e3/3rDJQ8PS8bA3SotftOcTaxQ56qQ?=
 =?us-ascii?Q?pWV3WUlyqNnay8qHjfNf7kLR3+vHGL3963TNGB1KZQpJO2+Gorn4HjRuNRaM?=
 =?us-ascii?Q?8+uw8fvoiG/kk3exbyVZaDZhBMQHEfu0Fo+S+EmHcfdoJfyv+SWX1Wq5OZ5W?=
 =?us-ascii?Q?aod+8SzMZ8CQPzyEeuuWnqx22FdgNlvuiVx7Gj+ipPrl6eMMw++O3PYvbqU+?=
 =?us-ascii?Q?ndXn5TSDNI2JGYKaK5AxgSZtyzbyepdOOPlmy3fnz02vtDvJ2yicdPMhR6p0?=
 =?us-ascii?Q?d8N8KMrOfVexd9QEdhi8geDPaBSSxxaqponm+SI7mL6uuqUjqYCfY1BWliNq?=
 =?us-ascii?Q?EH7KY+nJSlcFA6/ZLJM0INU+8HomP9txSfA63+f6LnFbZ+eprL5CRwD6jz3r?=
 =?us-ascii?Q?eBOv17X1K7XMFKJ4B7y4/ALRHwXr/4B4j1Mg28L2CTV58QR+C6VmemLqDBAL?=
 =?us-ascii?Q?MZhbdvaZdZJ17GdvREGm9Hweg70qXnYBkw/z7LCjS+DxR5PntlVYWcAhm3QN?=
 =?us-ascii?Q?YRY3aEfhmPTl4ueyZaqTDzXOjpNvkGfI9cLTQzNAaX5U4bbtZ4GWtnZ9S+u/?=
 =?us-ascii?Q?+fIHa2quUc5AaWEz/d07KaST1ZjtpRth4w59jlNJ3W1bvKorTsfu1yNYxYhY?=
 =?us-ascii?Q?ncfPXXja3tYb0pvQCSxMgviy2AftQPudc1ymH1sQWGxt1ZSYwzTH2t2oAn/0?=
 =?us-ascii?Q?g8xT900m54VCNHU6ABaBR0ppbnlto96rk33X9usMC6lIxoBQCya9qK9DLXEJ?=
 =?us-ascii?Q?/tjOystoi3zXT7FYxPj2UTe7LpRPII+eNzprsEwpkdXLE4whZDYieeEZX+7N?=
 =?us-ascii?Q?yASIAdQY5M6np1tS8CevuwBMQo1p1Niys0rCIduAg9MmcmHgWw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C0Gn3lw6/+EPvuXN6FW9DP28Tr4RuZK7HpqjquoqG6K19AhU6JaA8VohY3xK?=
 =?us-ascii?Q?jGe2LdHe7O3oMvr4N12BjEi6tzI6G1Nbk5bmFZWM10vQimw7Jp1WJciVc7ce?=
 =?us-ascii?Q?9/dt2QlWaljfjnXr/Jyd4btZjp/mFLrsQV3VqzbyXM1SAd5X0CqG+chHUAb7?=
 =?us-ascii?Q?dYn5SzNjA+I5/MN9E4QlDEPuXMFKVUwSx3pDX+BUzhOGhBKJP0oMY2CnJJw1?=
 =?us-ascii?Q?l6oEHfUOt0dlF4l57zjH2Zk3IeOkOutfUAvtEzaYeiKad3odhjeOw8GEx5ax?=
 =?us-ascii?Q?o8ikYEcEP2OkcSKFnlymTRVnAm6X+tMohGjuN6udV4K0eeyr1FTmtScjdEac?=
 =?us-ascii?Q?huDsZzhM4RCL95nUJwJxOK+dDAelw6t4mcGeaAgirEwgyc7HSvBdkAWjO+sA?=
 =?us-ascii?Q?lXi9uPP6Ik1MoKfjJjyG8GVIuj7NyfR2JlIf6/pQHPPx22NmVRofCeizZPXP?=
 =?us-ascii?Q?8b6PBG0OWMZG1ZH4mfe3utNsDolew6CxtY/evxjHPg+keSmxX7sXjWgvGhHe?=
 =?us-ascii?Q?HNIAS0gI0CroOstCYRdR+LBeEpss1F7glWEDB0J8dx6yZm8fjIPPKhjwNYuI?=
 =?us-ascii?Q?hDfIG7HovATUNJLcJEnYXVsxE9sWl7vNPRGSgUKbFm6mMDvoiUkrQxvmnlE9?=
 =?us-ascii?Q?acX2P00RVciUFKR0qvKAM5ny8uhUMOmz15euRC6a5YIqyZ6hJVdKKDWz/OHz?=
 =?us-ascii?Q?F64v7wL4WdeQPVVPIxo976P8SD5wGtGMFoaFWCf2prjIXVI1wb8YFlR6WWpl?=
 =?us-ascii?Q?Owr8FxUE7WM/rGMJAqeKHP1tOBMeazkpnEx7vUMxm/HbszVMVOamEAjzv/M4?=
 =?us-ascii?Q?IfhAMoUAQopCQ0/aEd8jt9L9WbMm5MGC6jhuSP5lye6+7+60uq2hxuCfVyyu?=
 =?us-ascii?Q?p1dgHJ9f8YunubOgoqi3ny/V7Fm7w0UW94qWbtIkT5vt8g9KH9JSc0KfxbCz?=
 =?us-ascii?Q?scMKno6GelrgVLhJ5FclL2FSxePNxBL66reRBhFuGOd9VZkaqI8ikbckfrFw?=
 =?us-ascii?Q?6LOIQr/bLRNIO584GlqXgUz5r1tbFDnNlWKAdIzF5zUjV7Exx8kJRwrZklQo?=
 =?us-ascii?Q?9OuSzCRZbYa34rUczIwxhvxZtdZK1+by9ZwCHQ0RcpIpIaVWLPynPEkxn+OW?=
 =?us-ascii?Q?V+pOnmeFBIquD4rF6Rbt96xqJT/ZvV6GpXnwXSQIRRextbwv+OADFCNcCrr9?=
 =?us-ascii?Q?6wJpGM3Tzs8hwfdE979e2rJY+iX3UURiEHJKHN2Rda9+xoy/SI+LMUJFMLW0?=
 =?us-ascii?Q?OZ4M05rEmBQDVPxoKvF5nHyjZ1ofomqhSjxDomuQYDU/VEikVNHI7VypMo5v?=
 =?us-ascii?Q?fn0i6Joyb6Q2iUpxj0U4Cvck6HK/y6y/vBI/mBuJSNqr94JWrODKUGPXrNiT?=
 =?us-ascii?Q?tSA51gyNycwss2l4jijDosZDHp19d/b1aKk4ZBizB/5Taz5nCU0d9+LSiHsm?=
 =?us-ascii?Q?m1lzd5I6hddHxx8mXutmwIPuP09gQos4EeW2kMrS/DZAEP8Q8CCeR6NdmSC3?=
 =?us-ascii?Q?TdPQOYXMXfs3KYUW5h74IZo0zB2cw9Rf/TgoZ3dQHZBBuE9s1IMFRDm4TTHL?=
 =?us-ascii?Q?p6G2iMWD6E59DtN45U8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b071cb-411c-467c-a1db-08dcaf6f19b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 01:38:08.6897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8Q18Xr60tyv1B27pCI3YIMfWg/rkozd0oEfwufMtIt3823FXki96zSenvMYICmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Monday, July 29, 2024 9:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: update powerplay structure on smu v14.0.2/3

update powerplay structure on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../amd/pm/swsmu/inc/smu_v14_0_2_pptable.h    | 53 +++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h b/drive=
rs/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
index 4a3fde89aed7..523de8a24ec9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
@@ -27,7 +27,8 @@

 #pragma pack(push, 1)

-#define SMU_14_0_2_TABLE_FORMAT_REVISION 3
+#define SMU_14_0_2_TABLE_FORMAT_REVISION 23 #define
+SMU_14_0_2_CUSTOM_TABLE_FORMAT_REVISION 1

 // POWERPLAYTABLE::ulPlatformCaps
 #define SMU_14_0_2_PP_PLATFORM_CAP_POWERPLAY        0x1     // This cap in=
dicates whether CCC need to show Powerplay page.
@@ -43,6 +44,7 @@
 #define SMU_14_0_2_PP_THERMALCONTROLLER_NONE        0

 #define SMU_14_0_2_PP_OVERDRIVE_VERSION             0x1     // TODO: FIX O=
verDrive Version TBD
+#define SMU_14_0_2_PP_CUSTOM_OVERDRIVE_VERSION 0x1
 #define SMU_14_0_2_PP_POWERSAVINGCLOCK_VERSION      0x01    // Power Savin=
g Clock Table Version 1.00

 enum SMU_14_0_2_OD_SW_FEATURE_CAP
@@ -107,6 +109,7 @@ enum SMU_14_0_2_PWRMODE_SETTING
     SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_BALANCE,
     SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_TURBO,
     SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_RAGE,
+    SMU_14_0_2_PMSETTING_COUNT
 };
 #define SMU_14_0_2_MAX_PMSETTING 32 // Maximum Number of PowerMode Setting=
s

@@ -127,15 +130,23 @@ struct smu_14_0_2_overdrive_table
     int16_t pm_setting[SMU_14_0_2_MAX_PMSETTING];                         =
      // Optimized power mode feature settings
 };

+enum smu_14_0_3_pptable_source
+{
+    PPTABLE_SOURCE_IFWI             =3D 0,
+    PPTABLE_SOURCE_DRIVER_HARDCODED =3D 1,
+    PPTABLE_SOURCE_PPGEN_REGISTRY   =3D 2,
+    PPTABLE_SOURCE_MAX              =3D PPTABLE_SOURCE_PPGEN_REGISTRY,
+};
+
 struct smu_14_0_2_powerplay_table
 {
     struct atom_common_table_header header;                 // header.form=
at_revision =3D 3 (HAS TO MATCH SMU_14_0_2_TABLE_FORMAT_REVISION), header.c=
ontent_revision =3D ? structuresize is calculated by PPGen.
     uint8_t table_revision;                                 // PPGen use o=
nly: table_revision =3D 3
-    uint8_t padding;                                        // Padding 1 b=
yte to align table_size offset to 6 bytes (pmfw_start_offset, for PMFW to k=
now the starting offset of PPTable_t).
+    uint8_t pptable_source;                                            // =
PPGen UI dropdown box based on smu_14_0_3_pptable_source enum.
     uint16_t pmfw_pptable_start_offset;                     // The start o=
ffset of the pmfw portion. i.e. start of PPTable_t (start of SkuTable_t)
     uint16_t pmfw_pptable_size;                             // The total s=
ize of pmfw_pptable, i.e PPTable_t.
-    uint16_t pmfw_pfe_table_start_offset;                   // The start o=
ffset of the PFE_Settings_t within pmfw_pptable.
-    uint16_t pmfw_pfe_table_size;                           // The size of=
 PFE_Settings_t.
+    uint16_t pmfw_sku_table_start_offset;                              // =
DO NOT CHANGE ORDER; The absolute start offset of the SkuTable_t (within sm=
u_14_0_3_powerplay_table).
+    uint16_t pmfw_sku_table_size;                                      // =
DO NOT CHANGE ORDER; The size of SkuTable_t.
     uint16_t pmfw_board_table_start_offset;                 // The start o=
ffset of the BoardTable_t within pmfw_pptable.
     uint16_t pmfw_board_table_size;                         // The size of=
 BoardTable_t.
     uint16_t pmfw_custom_sku_table_start_offset;            // The start o=
ffset of the CustomSkuTable_t within pmfw_pptable.
@@ -159,6 +170,40 @@ struct smu_14_0_2_powerplay_table
     PPTable_t smc_pptable;                          // PPTable_t in driver=
_if.h -- as requested by PMFW, this offset should start at a 32-byte bounda=
ry, and the table_size above should remain at offset=3D6 bytes
 };

+enum SMU_14_0_2_CUSTOM_OD_SW_FEATURE_CAP
+{
+    SMU_14_0_2_CUSTOM_ODCAP_POWER_MODE =3D 0,
+    SMU_14_0_2_CUSTOM_ODCAP_COUNT
+};
+
+enum SMU_14_0_2_CUSTOM_OD_FEATURE_SETTING_ID
+{
+    SMU_14_0_2_CUSTOM_ODSETTING_POWER_MODE =3D 0,
+    SMU_14_0_2_CUSTOM_ODSETTING_COUNT,
+};
+
+struct smu_14_0_2_custom_overdrive_table {
+    uint8_t revision;
+    uint8_t reserve[3];
+    uint8_t cap[SMU_14_0_2_CUSTOM_ODCAP_COUNT];
+    int32_t max[SMU_14_0_2_CUSTOM_ODSETTING_COUNT];
+    int32_t min[SMU_14_0_2_CUSTOM_ODSETTING_COUNT];
+    int16_t pm_setting[SMU_14_0_2_PMSETTING_COUNT];
+};
+
+struct smu_14_0_3_custom_powerplay_table {
+    uint8_t custom_table_revision;
+    uint16_t custom_table_size;
+    uint16_t custom_sku_table_offset;
+    uint32_t custom_platform_caps;
+    uint16_t software_shutdown_temp;
+    struct smu_14_0_2_custom_overdrive_table custom_overdrive_table;
+    uint32_t reserve[8];
+    CustomSkuTable_t custom_sku_table_pmfw; };
+
 #pragma pack(pop)

 #endif
--
2.34.1

