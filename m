Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EFCC4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 03:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90F960EE8
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 03:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A90F960EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C016E3BB;
	Mon,  2 Aug 2021 03:50:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B9A6E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 03:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6i+9LUOaDzQkl7xOgY/1C6lf4bsucQLRGCrrp2CILJzAuchklYxPtCDMWubpHvVosxKZCgzr0d8b05mj0GH/sXbVRPxenXzOgb/9tzSSFNv4FoQerD0ramneTqmb2lt0kURuXELG/IbbhOrAcfKZ6E61Wx5iy2Yp55awvzUzkQa8JRiHQPyRsI+H4JpdyKX0Ub4iYpCAslhWe7H3NcS6Phz0kvumyOgCI68lZgnUfbfO74ngIkTziZVqGYOLexTFPHDnM71N4KwpWP2i700bbz7858w7Nwn4AwLb0m0aqEFxefWZO/cMi5fqbNnt/9DtqKqnHPr7g8PcJtOtJLGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+xYMi/8b5zUN1bTiosqa6CLc+UOv6Qf3jamHV6w3Ys=;
 b=L9OLb44chIcsDSByHIkfWa9LRSB5pZ9b+nO5uCgSZ7QxftcqSkwRbajUHyS288ciwc7p9aqQIT8uKBI59oR+hgIVQl4yX9azQH+xPlIUsyKC9UIQQ2h9DAs23nBLeOtrCGb+4JdMwGQdu4uiMypJCUCkGGePcgkhdLDJguNzjwYsONHFCx61EqAa9S+Z48nQffdoe1fyYdlinZQ06OzTwC8E9PmyUnYhof5pdiTTOFXYorlbfg02YHbWAm0per/49w9uSnnLZLGOBYnhaH/NjiH6FpuBPa8bfAsDmD7z+9qpp1ryJ1n/MVeVgoqtzmqW7G9HzKYG2MdVihYxAYbelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+xYMi/8b5zUN1bTiosqa6CLc+UOv6Qf3jamHV6w3Ys=;
 b=RpDvvb9u/h1pEUDO3FUNATIPvrBA77QiP/jqInwK3t4Fj/zJ4MAwVhi1C+3xrzVi7j9A+ngaHwEG8PCs+wzPggw1oB9mgCzri2aSGWbl3cUMasMJND/dWzRtgYZha8stlrZqZlcCnGtLJnRfUotNuzPuAak+rL3MNvpAlKYH/xg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.25; Mon, 2 Aug 2021 03:50:36 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 03:50:36 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix channel_index table layout for Aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Fix channel_index table layout for Aldebaran
Thread-Index: AQHXhI/HvK1zp5UsHk2Aus3Lk064Uqtfmakg
Date: Mon, 2 Aug 2021 03:50:36 +0000
Message-ID: <DM5PR12MB2469D6A27C6622E125989456F1EF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210729153758.13662-1-mukul.joshi@amd.com>
In-Reply-To: <20210729153758.13662-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-02T03:50:33Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c625ce3d-3efc-4c08-9153-1bb2e8f6b198;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c7f05c2-d6ab-4bfa-8f42-08d95568afbb
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28928DF25CFF67729C1C7779F1EF9@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7XBBLTKks0h9xeZPE7+3rIQrC2/CdjYaTu+1rjPYkIPMNOoxQ7w68utQag9LIQ26wcMSqoS3G+7pvK1rj5s28NngPnfrLNfCT01BRlGELriVmmIwbAal9SDCdxfRcOKXkuFTQYcBiZLZ2lI87TqYx4XnyTMYi7h+H/S7elEwa7LZVw4RPQnpI9y6kXTF4me/z2+/jzK/PchqaY4AzuWNK3lBLt1L8Ai8AuTKzkWa1Ui9Hd4pEcAigXu4fuuhQlFGs0Lg0dVWjv29+R5afrV3TFDW78TjxfPY5Uv8OJ3imO4Mn3mCEMv3X3wLsBeMjtNYLsBJWbDr/cc/Mi0GaOstXXYoMOoe3hkoEnudqcDqxq0CkpF/MmYQNFWH/1Je07Iboua3cix6orK2lmc+Ei0bVxZV/q1Gomdgl7pqOMPSuiFP9+4y8Anx5kJ4qtEHwL+fqMAeA2xancSn3f6z3CYDWFTl+aqEcE4bKzhhYHGkw3eGlFxZHSVgLcKPBVSO9lCAyUK5T0H92swPCY0Vn6a6ts84xdVNiv0lp/YSOO56UuRpQJrIBcTrD1CKKKoN4e8Nq6HDVOiPQdFmqx9ZzysYB0D7YL/Shaxv36LGsZU5y6Pqgg6elKCUFG75rJxoIRjmHz4po/2KUWJ//mRy+QZofQcu5GG/4F+6+LX4pPZ2qMVYQpUvPdidU2TrKARwpEXw7vFs3DCqPjVikhHPTZ21w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(33656002)(122000001)(2906002)(38100700002)(55016002)(6506007)(9686003)(8936002)(54906003)(316002)(186003)(110136005)(26005)(66446008)(38070700005)(66556008)(66476007)(86362001)(966005)(66946007)(71200400001)(76116006)(508600001)(64756008)(8676002)(5660300002)(83380400001)(4326008)(52536014)(7696005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NzwL0A+hvfpWAA/vqvQwDln/p9fLb1UxEXBNWqVwhDvUwOiT8vUdVZqtelLL?=
 =?us-ascii?Q?/memxw9I5AOBQGvmPUkZ/v1KCAqoMdapIC3Dua3IJi6W0wx1nWMw2+wnxh0I?=
 =?us-ascii?Q?RN7c8MKPXdGp51Sk/Xh4S3wwsKRt2cOljE8L5uwJhrk0DlDfV+4hjX86T8on?=
 =?us-ascii?Q?W0hV1G4ea09CdKTHzypZeCHG8yP5dMBQixqCNXkT7zsUzO+88QU9BnN+UsTF?=
 =?us-ascii?Q?UAyrLzal2Fec4j6zNzBxSQh1K9baOcStsk4f8NvaOTcBETKu5guACTd+iXLd?=
 =?us-ascii?Q?aJeT9ztsJxoWDGh+wdJc89doA0na2XkR4HPp3rYXycxOvnJkrS2/6/Jy7frL?=
 =?us-ascii?Q?sVu97E2ol/WR1dyXS3HXQ5esVO9XstK/zyKMpow160NfFGdKRnh/T/ZXVW1j?=
 =?us-ascii?Q?4DTlldSf55TQetGuqlXlU0oUuCb6oEAJBsUXKhjO2lsKe7WphWLcM/eaX8Z1?=
 =?us-ascii?Q?sSz1XrCOYpou2a8Y0sKt6r7G7soAt13h2OExykOUWMZKLtIKXnDj4UAke2+x?=
 =?us-ascii?Q?6DoJ7gOP3gEkaeHuCcaEp+XDK+fsZ2PZYQpN01uivAuYR+CiSrLNqqGiTjUz?=
 =?us-ascii?Q?meTns2H88GyzHos5WaSd9FGuyS40j9BfuEnz7QLK/JMVHLHP+1INo70hrCoO?=
 =?us-ascii?Q?fZ4oIQxS2xdd6Q5YMIg4hdBZix2kNDOWRTgkQnLlWTpFG4OYN4UCOXJ26SPM?=
 =?us-ascii?Q?j83eMWVeUVqRIgRbgtfw491PbvzMztNv3cw3QGq/VhjN3KZKTL9cynQJ1qaO?=
 =?us-ascii?Q?c5x2oEsGIdGHdzwEftS/QU7N21VUJ5maxqvynqsEH7gXFcREiEUIzqZxU0Qi?=
 =?us-ascii?Q?wDEaOSkvJDMDnjUmOBlKvvz//fktNn+ZukV7WerLqYJ1SqScHjUAhJpjPk3N?=
 =?us-ascii?Q?RbeaPM+1kXCOir/Vs0/2IS13JvhKFsMYtaFHEeuRE0U7haZbPfrR0vvxXe3w?=
 =?us-ascii?Q?+v9rWGOlPvZA3Jfl6lQGwnl0lx+3FxICxfSEIKNAWnKovNEHx5kvhbApMxut?=
 =?us-ascii?Q?ase2iaXEJsMlVIFc9td8gVPnMBS8ohWTap8DSVWWa9qMAbPs8lc0akkzYdn6?=
 =?us-ascii?Q?feHJKkRtP+weIRZIhl8YIh4rYW3+y2QogTxjj/kQSj3GVRV16mSvJJdNISFp?=
 =?us-ascii?Q?9bYBGR7fvOO27jorrJMfsOBMVv17MBKdMZw8cq0oJ38gVxIgQSSTUi0fYjU7?=
 =?us-ascii?Q?jsxM0JGlv90+Pyua4S8NhA5qQpQjWfCwKplhyBBRNtBo0QVf1FJVNxydMs8J?=
 =?us-ascii?Q?jBYl42cQnv5k/a/e/1egjoF5B0n9h0ylJF4x6bgZLtG7NwaqZjbAWnKncemy?=
 =?us-ascii?Q?Ytdqi8/h9tULFeaBBmT+EddV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7f05c2-d6ab-4bfa-8f42-08d95568afbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 03:50:36.2570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8R1TSV7MHQehQoVoOl5lodsH8CV2rYTS1Nq40w3ttSv96PCkCgsvK3tHJgN+eA7Z15nJhInPufRjNHeUKOQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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

/* number of umc channel instance with memory map register access */
-#define UMC_V6_7_CHANNEL_INSTANCE_NUM		4
+#define UMC_V6_7_UMC_INSTANCE_NUM		4
 /* number of umc instance with memory map register access */
-#define UMC_V6_7_UMC_INSTANCE_NUM		8
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM		8

Please update the comments accordingly as well.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Thursday, July 29, 2021 11:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Clements, John <John.Clements@amd.c=
om>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix channel_index table layout for Aldebaran

Fix the channel_index table layout to fetch the correct channel_index when =
calculating physical address from normalized address during page retirement=
.
Also, fix the number of UMC instances and number of channels within each UM=
C instance for Aldebaran.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |  4 ++--  drivers/gpu/drm/amd/amdgp=
u/umc_v6_7.c | 16 ++++++++--------  drivers/gpu/drm/amd/amdgpu/umc_v6_7.h |=
  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 7cf653f9e9a7..097230b5e946 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1171,8 +1171,8 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)
 		break;
 	case CHIP_ALDEBARAN:
 		adev->umc.max_ras_err_cnt_per_query =3D UMC_V6_7_TOTAL_CHANNEL_NUM;
-		adev->umc.channel_inst_num =3D UMC_V6_7_UMC_INSTANCE_NUM;
-		adev->umc.umc_inst_num =3D UMC_V6_7_CHANNEL_INSTANCE_NUM;
+		adev->umc.channel_inst_num =3D UMC_V6_7_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num =3D UMC_V6_7_UMC_INSTANCE_NUM;
 		adev->umc.channel_offs =3D UMC_V6_7_PER_CHANNEL_OFFSET;
 		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->umc.ras_funcs =3D &umc_v6_7_ras_funcs; diff --git a/drivers/gpu/d=
rm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 7da12110425c..bb30336b1e8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -30,17 +30,17 @@
=20
 const uint32_t
 	umc_v6_7_channel_idx_tbl_second[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANN=
EL_INSTANCE_NUM] =3D {
-		{28, 12, 6, 22},	{19, 3, 9, 25},
-		{20, 4, 30, 14},	{11, 27, 1, 17},
-		{24, 8, 2, 18},		{15, 31, 5, 21},
-		{16, 0, 26, 10},	{7, 23, 29, 13}
+		{28, 20, 24, 16, 12, 4, 8, 0},
+		{6, 30, 2, 26, 22, 14, 18, 10},
+		{19, 11, 15, 7, 3, 27, 31, 23},
+		{9, 1, 5, 29, 25, 17, 21, 13}
 };
 const uint32_t
 	umc_v6_7_channel_idx_tbl_first[UMC_V6_7_UMC_INSTANCE_NUM][UMC_V6_7_CHANNE=
L_INSTANCE_NUM] =3D {
-		{19, 3, 9, 25},		{28, 12, 6, 22},
-		{11, 27, 1, 17},	{20, 4, 30, 14},
-		{15, 31, 5, 21},	{24, 8, 2, 18},
-		{7, 23, 29, 13},	{16, 0, 26, 10}
+		{19, 11, 15, 7,	3, 27, 31, 23},
+		{9, 1, 5, 29, 25, 17, 21, 13},
+		{28, 20, 24, 16, 12, 4, 8, 0},
+		{6, 30, 2, 26, 22, 14, 18, 10},
 };
=20
 static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,=
 diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v6_7.h
index 81b8f1844091..57f2557e7aca 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
@@ -36,9 +36,9 @@
 #define UMC_V6_7_INST_DIST	0x40000
=20
 /* number of umc channel instance with memory map register access */
-#define UMC_V6_7_CHANNEL_INSTANCE_NUM		4
+#define UMC_V6_7_UMC_INSTANCE_NUM		4
 /* number of umc instance with memory map register access */
-#define UMC_V6_7_UMC_INSTANCE_NUM		8
+#define UMC_V6_7_CHANNEL_INSTANCE_NUM		8
 /* total channel instances in one umc block */
 #define UMC_V6_7_TOTAL_CHANNEL_NUM	(UMC_V6_7_CHANNEL_INSTANCE_NUM * UMC_V6=
_7_UMC_INSTANCE_NUM)
 /* UMC regiser per channel offset */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7C3e76860245e3435cc73608d952a6e901%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637631699096172598%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DID=
lUT%2B%2BIBKOPgWPQQ%2Fxrxh8ZQD7SpVn%2B4uiEvT3KPw4%3D&amp;reserved=3D0
