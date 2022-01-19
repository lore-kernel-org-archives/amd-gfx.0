Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD33FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338DD10EE89;
	Wed, 19 Jan 2022 22:17:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3206410EE89
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsvTdXkphHqavhDkF3BZcbq5QrsOk5toornU6my9pbOhK2uUTKd+H3hauQYFzMEdhBFKNyaFEaiINFn0v4zA68pL5gj7N9XhO0QPxykxEzQZGGs6aMx+7O/aLq2UhQ4+Mc9Zf6mLsp38dsqXM+9MdKfL4He2uOLO19e7xaItoumLZkeAi8sfIx2318u9ww4KEqpq21cA8ih+aItFAO3iieQGcKgEnUqXGrBByEgpbhf4HCATGIM/dHbewn2M5v3D17hCPginsfl7ZqxiLS+a4gYcfGkKIWugb5/kGzXyMZaX0tf2w/MVAAA+dNa1X3DnwJh24urMpwQj9VClmtBiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5s/1wsUTQkYc02c5vKE2KUL7PeTdrZQi1ymXKhDolI=;
 b=dqIGYO/UTzm70PCoUTsACL8r44wnBpYxKB+jm/1gW/ZsuES+HoAPlF7n5IhNxOD3alnyeFXbqnzS/iXffWsbG6Gplb7Pje9ZS/ai/bS3tsbTapL80Xe9ZOULPMkxwDj5vew2pLQCarxENWHWC8CRT3IP3akoQReEi7/0/7a1KaCP+PKYZmnJ2BVXeSo5VQATvp+LVf4z/y5MTyC57iqWV+bFytDFw5kMT/WVW2bta1U9Eu4kzsgdtEjSfRo1MCnEwsiLGVYWT6FLEBLaBTA9zhcRWaYONZ1oW8Hoy2RdvPnTtTaPu6T8zU1d91aQNiRRcPLSTnsYEm5Jz1J/yHHZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5s/1wsUTQkYc02c5vKE2KUL7PeTdrZQi1ymXKhDolI=;
 b=dCe0FuiDZbIsrn+Sx7YQ0M6MAJKVY5rRytw4y/kyWlpHBo0+uTo7ZXUSP/R0tiTIadKeKd5P216kDfsZO1Kfym+BXFZbprWISUpLuS5rjcXqlVQ5GFz4AkjuAkZ4YP8j6So2BoBoMx3PXa1mFOMqys0I/Y8bYMLZmoCDcX3RmwY=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 22:17:26 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 22:17:25 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
Thread-Topic: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
Thread-Index: AdgNgiSfZQ68VWNLSvOdzBGmHSFrhQ==
Date: Wed, 19 Jan 2022 22:17:25 +0000
Message-ID: <DM4PR12MB52141E8C6959D2BE69FAB8479E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3936dae4-e1c4-4711-a446-ac8ced9f44cd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T22:14:13Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c0692a2-288e-445f-7349-08d9db997930
x-ms-traffictypediagnostic: BL1PR12MB5378:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5378E2D7D6A724E6D127B6289E599@BL1PR12MB5378.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EvFtJZn7ipapVDlJph98iuu5dxcI9aCdihdeQ2KF+umY+uppvkwKdzuLeX/GNDkJmeDdzhFTXihobeJ4d3+3jXZO2Oc5IZup5XT2LcBzwdu+7B///TngWvm6f4IZS690hypXko7AWK4TAyOodDk6USMeACUBZtiF1oeYqvFe9PF1cxCUSIP2yosjAsY8GqWkLsJV6Xo978CopvapZoxKI53JuAVC/QqqSd5m2madqqPPiGLcHcdISmgg1O3zco9L8L7j8GnSrNBi2zisYqQ6JcXoJGCOaKPp0BEmt3O398g7q4N6h9lIhCRAeHTgneD1A2OtgUBDjaQU9tQDdjn/uG9ak20BuUBXJCzVca8hrJfKboJRwiP7uiQ64dTTDHKvHGc64dTd0a8IBlke8TTee1lAvh2GNda40J3j+FmLDnK+BaqqYClaakOlrHbvB3LsqlpLbIBVU5HcQPZqt/TQwf3dDyufdR5B9j3QRYiX4ClpW2DIlW2xbNRYrItylR4PvWt3qQCrrCzEslNFai21YmUjV7NernWJF/NKGNzzWBRFg3mqfcHTs/FYCOruqHNIYH60Gee2XUtPqWUxgjm1e9Xq3RopyrLSt3tDws2UmzciVDEJVMSdSli6RM42lg+RgG9svsz6wDbDrG4N6+Gh7lI1loeExeavA2UMszCQCZyJsE750K8dHOWcybO2gSLECg4ze0neAh48+nQuW4Iyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(33656002)(83380400001)(66446008)(76116006)(8936002)(66946007)(316002)(64756008)(66476007)(66556008)(9686003)(26005)(6916009)(5660300002)(52536014)(86362001)(6506007)(8676002)(508600001)(38100700002)(122000001)(7696005)(54906003)(71200400001)(55016003)(4326008)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l0U3fOxQRSmXmHo8x3yLoHfBm7G0RBV2SC402U7Wcoc91ggyKQzTI16773RC?=
 =?us-ascii?Q?abRqljUtinBgzAK+G4ggyedKrjt8bf0KZlKxuR1EDJN4eUOqBaT3PKNBMWoF?=
 =?us-ascii?Q?tOrN5EDvrT8COBOjcdrDkKUKawhsvHeira1tNP6ihMbFN23Vft/qumoSWy3P?=
 =?us-ascii?Q?dK2HmUboemfIMz+bx3AVuUOenwaCfE0odIe58V4R40qyJRgS7TWP0qdxqHrl?=
 =?us-ascii?Q?ZL7mNTA6RMR8/oUGe28ddwlkdIfFSe38fTm1WCmk/cP90TS1N37uDIC+R67n?=
 =?us-ascii?Q?xpvguFdAHfhI7LTdnTS6KF1GR4i12WYY/ZSo4ArgshJ7dl8S3v77o/z1BjVI?=
 =?us-ascii?Q?DYCR4CmGw35cY7MB4ZQauQPAbQZRcAoOZBRapxo0AS8wOb83knyR+RvMofUl?=
 =?us-ascii?Q?ZWh4FgMOa3PSuBuDxbprwrCM6a26OMHI0FubY58OGOgJFp2NLPKzizPmCwWl?=
 =?us-ascii?Q?rEypT773C5HVLOfMVereAuWLpVcPD8o42Jopna6n33RUJVcUcdOxJrxjTcvG?=
 =?us-ascii?Q?nJ140p8arAvMH24fOk0bHagA9MO75uAHA5EUix3i0wM6PoUd/Ef2k3vXHvsw?=
 =?us-ascii?Q?QuY40o4evG1lhsJXUOupHAwpLws3uni2P7BkYQZom0GlxHUNajHhMxpZZad9?=
 =?us-ascii?Q?rnxvdD4tnVrpC1UpdXN25vxAhYTqt8kuOcyUWqHUfJ6t9zgBBAtXtWmPFcyk?=
 =?us-ascii?Q?P9WzYgCFqQTYlxZGJYC6QbT0vWWgoIc9gsBReQoklXdhOiI2rhUgHVf2IYXq?=
 =?us-ascii?Q?QCvi84t+vyzB6cldfRw8s21SKS+d2XU19/WfluWjd/2DHUPA3tHrI7LbjsFz?=
 =?us-ascii?Q?t+JGCJ+P4KnBHBnSi4ysdKiOWZJnEdyJV8ayUDXYQsJupU9APwa9jWmmuXBO?=
 =?us-ascii?Q?yU6sygof/QcWml2mSOHBbIOcEJJX6hevr+aWnIWXBa/OKCwzZwtVYSjHXFk3?=
 =?us-ascii?Q?pmfbMad/0uOvcqZkdXy5BSKLLphS840OocjSkxwvC2eeIzGfQ6mjggj3+t9t?=
 =?us-ascii?Q?T/X/BLC+QKpuE5TMbU8w1ORvIGtfJBfOdBvVf8FUZEVU4cHuvNmbMetnOPFo?=
 =?us-ascii?Q?eGEYQsRdz8rbpo1jWawlHN5tNFq7+4/BcfhV0TZvLkLw0rK9ofQkxZXhRpJ4?=
 =?us-ascii?Q?5lMATY0Q5tt0fdXXgXg60tJInXcq7iXw6jFenmA6gZ2URMihoCXV2dwVlnxz?=
 =?us-ascii?Q?WRL9WbNMCwTozuprAfWDRvTAQ+mgipwlB6K0bXFtNxphkc2DtOzj7SBIQdmE?=
 =?us-ascii?Q?jzOjejFp6Ujb6QEMGUTLzQCdwTnE4Ll3xS03OKVipBJExHd6uyjrFHFn+lhj?=
 =?us-ascii?Q?khjG/0bmUN7Xjc5M//X1PB9LTXdD/TqAGbzQ7ha+eiFxsAez92U7IXns389q?=
 =?us-ascii?Q?jSBYd+oDXFeg+Ibs9FGZj7qnAp4tS0DAaMbiMq+HFt05UYmOW4xz8i8jtByi?=
 =?us-ascii?Q?bFi456wQ06pNxKq37Tg6Uo/4LqySefauYJaGoc3M2Yr7K46uGEiNFe11qo7j?=
 =?us-ascii?Q?bQM7Vx5oJgJ9PEHtNlfmBFADht/wT6LMlxNu+td8b7AnP/qjjiEek+N40kl7?=
 =?us-ascii?Q?AKHAZ78yPjLk4lh13Uk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0692a2-288e-445f-7349-08d9db997930
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 22:17:25.7470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFfkHb4PUshVt2EhDt6yDbs7Ufj1seIyiglzEt4ZQehQdjA7ozStpWYKbbc47pUJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Cornij, Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

[Why]
DCN301 has seamless boot enabled. With MPC split enabled
at the same time, system will hang.

[How]
Revert MPC split policy back to "MPC_SPLIT_AVOID". Since we have
ODM combine enabled on DCN301, pipe split is not necessary here.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index c1c6e602b06c..b4001233867c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
        .disable_clock_gate =3D true,
        .disable_pplib_clock_request =3D true,
        .disable_pplib_wm_range =3D true,
-       .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
+       .pipe_split_policy =3D MPC_SPLIT_AVOID,
        .force_single_disp_pipe_split =3D false,
        .disable_dcc =3D DCC_ENABLE,
        .vsr_support =3D true,
--
2.25.1
