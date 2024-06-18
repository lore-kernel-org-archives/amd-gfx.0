Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49885C27C4F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 17:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D282F10E084;
	Tue, 18 Jun 2024 17:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wEB0dp5l";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10DF610E1C1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 17:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPOTU/OrdyGxnp0J/mYxDPMomx28TVquR1o2LnTv53WkTigZCQ16eGztSM9Lwh4zfBq9bfytSjvxr5+1Yo6vZDbdiYz1Y/YHfBXgacJrB3kxWYUV+NYU05TKMOIbeoIlYVUPTpmKj9RhHRh3A/cu7m391FmLyAG2gzoYzWovmvFW8tNKE5VARDJyos2+57wjQadEuEfHRDaaxElxj2/wiXEQjI2UEUyvqmaYzTaoxQ14m/oPzFuOUJ1L2xFroC4rEcFfeaUHIbbixejUl8EOjdwYPthYdf+KlpR1KtF08rzFAeimlkKRYf93hk6P/vJKyyHPNipZPgn4TncoHYRdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To3TDml00wzRQGZLkTzxQPVdel5/MYa4VpRQYcNMh2g=;
 b=Ye9ndz4OiAmE2TfRaaZlKSTykoKzOgp4jSgL+y4ToH49bdEzxVsVuM6RqbZldG1RgyPv+PxY/NOP3/zLXSRNPvt4ix+2jLIxioS4Qzu/2FkT37a4FMuEy4wndQ6jxPmwWsSFoQhqxkWYHmTqB6D6f0HfS+uhW/7QQ2BXIyHKU4fVqoUnLQJDEWnAFoYYei7Mui6gghZS2Tx///g1iT8wuIo/tNLLL5Hnz3CJaYz8ET/qrdDR8ACQOzLzX9YEsUgVuE3baqCiyZUa7mSVXbPk6jVuf6pw6ywhC7H2aXgIlWX7IZVtpRfnuFWvMvwfvExocWEhoQu00G1XBs+NXBD56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To3TDml00wzRQGZLkTzxQPVdel5/MYa4VpRQYcNMh2g=;
 b=wEB0dp5luyo3144kU6DtK6NXdRnjl/HMQzdJNJSFGGLgBnCcYccZseWKlMUATvhVgIE4jGi2jVDyIZSNbT2kuUQcmM1CwsycNmwdv1wvSzAVxitwtNQAJI4DJIMlmmkgOJYZfP1Z8Q2+/9DQk9bCz0QQFBGr5RU9ucKxWn6V6bQ=
Received: from CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 17:55:54 +0000
Received: from CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0]) by CY5PR12MB6429.namprd12.prod.outlook.com
 ([fe80::1b40:2f7f:a826:3fa0%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:55:51 +0000
From: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Don't initialize ISP hardware without FW
Thread-Topic: [PATCH] drm/amd: Don't initialize ISP hardware without FW
Thread-Index: AQHawZ6/prV8gclzUkiMIkfBTgbdF7HNzXLA
Date: Tue, 18 Jun 2024 17:55:51 +0000
Message-ID: <CY5PR12MB642948F84E07531E584FC00AFECE2@CY5PR12MB6429.namprd12.prod.outlook.com>
References: <20240618164305.24221-1-mario.limonciello@amd.com>
In-Reply-To: <20240618164305.24221-1-mario.limonciello@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2d17c8b0-853e-492d-aa13-65d49e1f7197;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-18T17:52:53Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6429:EE_|DM4PR12MB5843:EE_
x-ms-office365-filtering-correlation-id: 3b57c9eb-b812-4112-5791-08dc8fbfe4b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?kradXA/RTNNlwtUjVUUWErzxn8v9xYU/QNGfwrBz/TyXG5JsQPbg6+238RMR?=
 =?us-ascii?Q?KqDb3bO6Y42/cTzSr0fAWPCWZIsZZAyJDtBu7PuW7yAFzdubmJW5J4ri8eiH?=
 =?us-ascii?Q?j/2uBmHZGp4t5AcUBJK06UNhtLUUHOF1+INOrdhmsU53uVwC3YtfErEVy5IB?=
 =?us-ascii?Q?j93/Q3c1/AdeQzdLl/by2ywfIukPRcUYKxgoMnq7qkMZzGKcTkvvtiOH5DCf?=
 =?us-ascii?Q?xw6BJv3L8XoKUc0MLGYhK3UkHG2cXRI1BDtU/DTYuABMRRFoN8O0neoE3DI0?=
 =?us-ascii?Q?4DIbjS4slWaEBzMxHfq3a3Or1/WIHct82Y6CCrrsewCTO7W809WSnLqfiZ5J?=
 =?us-ascii?Q?TFoLL7rP28t2ujg7gn9rVdlT83qqoInIhlwVD5uqKUVWN+DD/0FmRD1f61+o?=
 =?us-ascii?Q?bsVU5ByIvt6kG469lWjaB1Iwk1Pp0GhrbcQTMmmNrNty3l/rI11n9xE2kUhR?=
 =?us-ascii?Q?+vNMIpGQFG0Owz6+LvQzKUJV+ebvHJMNm3+6Y1BLIbpwgxwxX6hq8eeOMlvJ?=
 =?us-ascii?Q?zTAzqNmAkqDJN9EFYf6OHWCXZ+/ueSMXiXFLSlH7s/CI2QPtZ8pUUlwaY0yO?=
 =?us-ascii?Q?5wz/QTmbaycgcPFIhqhkr5vJC/tz4ztJjw4SxSHSVNsqRXAMFU/jJDpGMaPl?=
 =?us-ascii?Q?ijTN8fMhn9G1FxwN2pZm2j+Z9SdWZyrOmOPPooOuMCwIBSLQEWLDaU86XvWT?=
 =?us-ascii?Q?DvU69/1wbHTqOOyD6mP/+LcO6f7a73OK06DXQurV/GA2vW0Thcs0PBrFsBem?=
 =?us-ascii?Q?Ct+EZZgftX2P9ZDA6UsYr6WojOUT4hjdhIa5jxMs3c1mjDjcPlyD71JKKilc?=
 =?us-ascii?Q?OqT02nwKdnpT2DDRLSSiegXCXfWqfR3okdJmdyqs0VqfDpVeG4pc7SmrMHAe?=
 =?us-ascii?Q?ufWiHgYbfU30ZOr/eBDnJRMgWVw5tSrwrbjNr5c+xRW13C0B1fhVW9VybUlO?=
 =?us-ascii?Q?ZhPf7GXjbwiS6/NiGZW9nEWjejosAtCnU29UbpI9bWYsYIRZUvClWw+7EHlF?=
 =?us-ascii?Q?NQm3a6xxDOeB6O8retWsm769xvYjAkatgu8Yx9uKdzkM2ATtIEjT+xFhZ6yh?=
 =?us-ascii?Q?PjjHwleh0UWV25TDKcVfibyN5QASmfZGJowyPqht9hs9i0FMVNEpwN5/VCyd?=
 =?us-ascii?Q?Nn5sHb3w10EjbIBiIeftDrxk6s7tXLIdXZ20mcflQkBveLgA8IHMsjRWr9K2?=
 =?us-ascii?Q?gKaAWQDqx9qs1E1odpHnBMzwciblx67tyeRc1nsfmc3WL1rPbuTViROf6jt0?=
 =?us-ascii?Q?1XfozRqW0BqJh0sgJ09VMvtTZh2jAZkcmURG45yQld9uHBdfIs5xMy/eWsqX?=
 =?us-ascii?Q?bTzE84aY+2dpqgDYoErsn8MB3B68J/4czTwlFGFIT4Q2SVWNwbb+reeYmb+t?=
 =?us-ascii?Q?qR8pTkA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6429.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GxGsFeRYqZ/7skBtOVuU6fI5IEBuw2+TzM+Io9dzH2ELtVPVbDAX02x3QJz2?=
 =?us-ascii?Q?qDFQ3hhYD/i8sfkXyVtiSYm0hKTRhIZ3F1JpsJhgxxXaKh04EPHMzS1Kj5dA?=
 =?us-ascii?Q?LAxlQqhjBPGZQqyLdvMozI1BSnxPKffKuEJrYfpljdD6WAxvmWt0yr8Zn+lC?=
 =?us-ascii?Q?JQLt0fx4c1tArfIpceZEeAGgQI98shfb4Kygbis8kfXki9PYTJX0Pl7bFv6/?=
 =?us-ascii?Q?oUFN764n44C8BjI+/tUqoHgeGJEeDhlbhGfEkXzTZ/OexMj5I0pVx6bEZniS?=
 =?us-ascii?Q?GM5WLN/0BCLLXpCq+feD47oMtHyw45h+SSospzijW8/W9Sc1Y2chzUlPllx4?=
 =?us-ascii?Q?G1+Ap+Y4nwAEdlLig8pAxC4Pls5WF5yHPSVJvjo4XUXmow6L77GLGDr3IUk/?=
 =?us-ascii?Q?ROmd491M4UeZpMvt1hGvaqFc3D/nYZMPL82m79lxFUooObxmAfLJovF43fkO?=
 =?us-ascii?Q?KQrNLKzRkHPO7A+XXC3jdDxyrFn8KGaVGIsOVrzhikTdJ9e/HeuzpouVUzvc?=
 =?us-ascii?Q?3XeG1QA36ffdX4GuiTrgB9H31DnJ8MKfMhFuwB9UxTpFmqYalx3BO8Z5lIWX?=
 =?us-ascii?Q?JJBWguiXaddFs0RUdehKkglfNsdUsKH+QWTFr9sA/QAi28nggmZali9G/EFO?=
 =?us-ascii?Q?IDhLPtA0+P1A/YCIttEIeTDzTfk7fUuEShxvwq4X3QhcUcddnTD76L0YihNx?=
 =?us-ascii?Q?VQjVoWXOmWhMqK/BBlTv2btGuEwVeeI0TkZRs63oFh7g0Nss0EwoSPXK75yD?=
 =?us-ascii?Q?eDx5mx+CRsoC2e3jThkmQVYnoRpmP/LexSuBEMa9aOi21a4bZzrZOpEHbb1t?=
 =?us-ascii?Q?5z64HmbnThHDMsp264sf2RAHUH7RvZSVZR8iR2BzHi1x5S7JzKbMJ3ZulwL8?=
 =?us-ascii?Q?9gejyrWGj4RdgSs+GNCd5bnr97LFKXIP7AlJw8rAmtzAgm9oU+aorqm0UgdZ?=
 =?us-ascii?Q?uyJ81JY+bgO1nkx3Jq81QYzxZ/kZdJ3ZeQl8MM1j5/UE6jj0tq9uKUJUm1BJ?=
 =?us-ascii?Q?4FgAEbdLpwAaJ12TV51Ox92DjL6n1i3wNGT2yfGfpuJ6vopP7VB+if1ybpaA?=
 =?us-ascii?Q?D+oKEzcyEVzkwyj2toK9+CthSlVxLk+6nNvUF+wtIAux7WTmto4F/pMO6iRh?=
 =?us-ascii?Q?xyL1yRLADU3vrdTZbh423KPAAWdh6FYJ8gyJMy9cX5QczhKxMDVkOXaIYeC+?=
 =?us-ascii?Q?V+QfwU00I6tLmAYW1uzPvkzmeWw7yA6w8FD8/ye4eColHGFz3mKco7lOgJ40?=
 =?us-ascii?Q?gQeADaXw5YI0SqV18gcLD+YGLzCcuHgulQhrwOLm62YHg3MbO05FrrbDHpzL?=
 =?us-ascii?Q?0qZlHVQ1pywx6/giXi4fBdSBrn9M1M+B2yYqdhdA+k6dcZgnVKA53vKJOkCa?=
 =?us-ascii?Q?FtermDru/TmFbIzoB3+/9Ju4ep29BgsW7cXCdIZtYy12RQSgjlArqgrvDHJH?=
 =?us-ascii?Q?o0t0G9M3bZ8iv6nN2UvfPmdSdL7XC9b4414zO+FiWWIpMTKt7Lb5WWD0ikZI?=
 =?us-ascii?Q?jyV/Mg8wvpCu7VQp/eZCL9O5BkPhZK8z9IbAZs3oKZ1ynLxjkmOzaZBQ69Vd?=
 =?us-ascii?Q?aW57iyiaus3sLPxtc6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6429.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b57c9eb-b812-4112-5791-08dc8fbfe4b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 17:55:51.7698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8mZtvVinCwo6w4YNeVoS5ugsJxxqIhnoFV+gPM8qQ2aCpRAmeGXTCZ2NV4lIlSkRUe/UXI/fnCepXe0K/rvVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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

LGTM, thank you.

-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Tuesday, June 18, 2024 12:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Nirujogi, Pratap <Pratap.Nirujogi@amd.com>; Limonciello, Mario <Mario.L=
imonciello@amd.com>
Subject: [PATCH] drm/amd: Don't initialize ISP hardware without FW

Although designs may contain an ISP IP block, the camera might be a USB cam=
era. Because of this the ISP firmware is considered optional from amdgpu.  =
However if the firmware doesn't get loaded the hardware should not be initi=
alized.

Adjust the return code for early init to ensure the IP block doesn't go thr=
ough the other init and fini sequences. Also decrease the message about fir=
mware load failure to debug so it's not as alarming to users.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_isp.c
index 215bae809153..4766e99dd98f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -142,8 +142,8 @@ static int isp_early_init(void *handle)
        isp->parent =3D adev->dev;

        if (isp_load_fw_by_psp(adev)) {
-               DRM_WARN("%s: isp fw load failed\n", __func__);
-               return 0;
+               DRM_DEBUG_DRIVER("%s: isp fw load failed\n", __func__);
+               return -ENOENT;
        }

        return 0;
--
2.34.1

