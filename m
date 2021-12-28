Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9B7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Dec 2021 05:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A5110E16C;
	Tue, 28 Dec 2021 05:15:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AA310E16C
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Dec 2021 05:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol2kr2hXyF1dPcNwkYGK/CXXc5aqGN2Pa8ma3PvrMR1SImxot2ZXf7CuHuPo3SX1IQ8x9C5bRAy5Z8p5rBPM8RHJIW3UnnxRtqTZ4xk/prcmgE/qEh9jiulyJvzVCOac5oad3Eopc9qMS57aL5gZL4hAJYQ4xYfFjU25PvlpWqRmvqQ4eU2LXTQipCIpcsQwoHOpLe/5BjNeGu3x782t93XxgEnytjBcZy/hRYQC433OdClYe49tFIG1nQ3E4izxPd4ScsEbpgqB7SMFnRfm+BsggK8ecMn5+4stuUj3XJl0CqGt6nd15C7jeLvqeTHp8JF+YG/rhX4bZbueroMQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z36ziir49pKDMPGFOk6Ia89FBqOD6Pm4IgtoDgCuP3A=;
 b=PBqRO+qN16DRSv/HzuPC4k2QqROoUzb1z/BuIad3oTHupeCeOsQiuT4Do8+wD+cbtVhBft5rc26ak7LGolMUXAyVxIqVpbreWByGgiVq6ClFXryRqsAJrl0pgJP8ZxijQcT+yDZlTaCyjYjb88OWxZ/OuMOgQrxoAC0W0ruhKFXYE7nzn9VOxlp7AG5R1zR+6W5IeFYZ8Zi4lY68hLN1gS+gkgMejLAEHo/JNzKEfrei72XP+Mpjew8SNfI/wYXIMum6l8imyoj/i6VWvnqnHb/qaU2BrmzhjSC9b6o+mG98E85tdaKQqVwQp66mE/lj7xZ2QCy5iURnOUHj84WKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z36ziir49pKDMPGFOk6Ia89FBqOD6Pm4IgtoDgCuP3A=;
 b=3i55DzWYBIUpbZUu50e0AXMiCY/O4SUmIkVoR9XuUctDlDzGqiPzYkMM9QdiywrHd3WSup8KaB5QZtMz5Do4QFuXssilwqvFcEsZxDoA/o8Dsl9/++7/AFT1KdS8bzs7Pn3Uo04TvUP7mQHJIhECaxWK2/A1AnmMdMHZG0gzAIY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.21; Tue, 28 Dec 2021 05:15:47 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4823.023; Tue, 28 Dec 2021
 05:15:47 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: avoid NULL pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: avoid NULL pointer dereference
Thread-Index: AQHX9z8NOLgWtGdb0kGyScPfi6OLs6xHZT3g
Date: Tue, 28 Dec 2021 05:15:46 +0000
Message-ID: <DM5PR12MB2469B69233149EFC4A2A8DBBF1439@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211222141956.13239-1-guchun.chen@amd.com>
In-Reply-To: <20211222141956.13239-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-28T05:15:06Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=59c3cb10-de2a-45d1-85c7-19c1dab53535;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-28T05:15:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0d764bf4-8d1b-4eb3-9071-2a10d231291a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dd775df-320d-4445-5ca1-08d9c9c11b18
x-ms-traffictypediagnostic: DM5PR12MB1866:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1866E53D41E0B10F7C605F1AF1439@DM5PR12MB1866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjPmWQaFQc+X6Huu1M70s3e70OybAb57VOegha9Z2Kb4fNo2NxDlOph7rgZZo3trXM7YcSNwBhkbjU5IYtkPQVzXNDEM8G1shVnDZ/WxYVLNtkHCvE3EYE+LHWqQFm2GUEQLm8BHbY2b268mvSIUBZUWNfqjK5qFDABxNJkjtfNomNXP6zscbEv+OX7uvelYDBPLsq7QW7wa2lHa/FWBAD8o9/S2paSCCG4e6fBQ9H6AcroX1DaHPJeEVntmeyZMjxvj/S97d0V1jpixb2x5DuH4Zm6myyAtVxVS8EZwgvv7pj6mriCJGcwtD2j9OV47Y+wHVFXmQL8bzOrvevyLZA3Q5daC/VSaCrTWEwFvc1YtjuU3ulBnhO/1LVm5e3HCrvcc+A9BanESv7eC3CRAeBj4B6duYjkrKfGVeZqUMec/x3+U5eZNunlWRonOrHaecXV2oGLfKyKWARC1+uei6t6Ka50rYQ2F+7Uy+uyldG6Ld0fu+M96NN3mc6U/WQgy9wC0YVrc7CtlVkcZVxe6UjItFgvOd0kQZH4cdwzq3+t++SzMPqPiiwvk6YTcos0j1QBe3ei4OL2ehvESZJrSorqAYpemxdZv3me6wtZNExA0HgGJa0pLixEtvwi1484NIDw2pXJqGb0OlDP80UpZ9Xt0WHyPBaVcJiT/U+re4/huujeR4p0H6A0stvbTLNvPkFwoDwCAm+VPWw2qmfjA9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(64756008)(66556008)(66476007)(66446008)(6506007)(66946007)(83380400001)(53546011)(52536014)(110136005)(71200400001)(7696005)(38070700005)(316002)(6636002)(8676002)(2906002)(33656002)(38100700002)(55016003)(8936002)(122000001)(26005)(5660300002)(86362001)(508600001)(9686003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MpaEkhM53IVVE2FYx1LD20/XA2nx1sNdsRYyZOeBE5seN6wKQ7HUD+13Vtep?=
 =?us-ascii?Q?4+GAFYP++2se3cdqwElmnUXiFe9+2QMahQI2B46p5ClGUQEtAybMVfzQvCnK?=
 =?us-ascii?Q?0b8RyEAsFRhrT4VIikt1EyBx37pciiRdhEYTs1DfHEfPdbU8MUNhlodnnW+J?=
 =?us-ascii?Q?YSCB8H518fPgaxvLiyi6AkC/R8AzQfiUETqgnV5dYAjiOnp+8TyHBl1HljNy?=
 =?us-ascii?Q?mPayQF6LH2TZXHt6LIV8FjIvU30wpzD0Uex5mr+ZoZ/CI/XOPbrHO+swJ2jU?=
 =?us-ascii?Q?hDwXBpwVmNlOQc6empyKpWy+VhOXtyyWzvh3ZtF45K4Jn8XL1jHjVOtdT0pf?=
 =?us-ascii?Q?9tlGbFVqbNkOeTGWra3xkBjzDxH0PWtS4ii36kSTU7DPpf1qJC0BjBB7WGFx?=
 =?us-ascii?Q?pV70ch6NHhLE5CSAuNkTc104nHgdWCojMzyU1uVNX8M+ISJsb/USpEhnZDQJ?=
 =?us-ascii?Q?qknai3BfuymWk9MQmZM+6FqSjw5o77TgrgkBLs9M9LCR5CiMkHAftDHr9Yd2?=
 =?us-ascii?Q?ca6KSddgbFtY/KIBO4v6BtD0mReGk1sVadPafBl3GkKGOWkz929XxuIyrdhd?=
 =?us-ascii?Q?2qvuLqQWo4jWRmAOIxxN4w59K8f74MHkKgO/kuNMLOpr7Yk73AQv1kI3DZ7O?=
 =?us-ascii?Q?fZpOpX98ALCIb8AqP/BsFquawIx8g53dDysApoIafenMge0DW2y/gz2hE1Fq?=
 =?us-ascii?Q?bCtv/fWRISO4n/BTYH8+VbQ05oS8IfA0bgOviUdKkdy+iT7B/qIG+hB10HTb?=
 =?us-ascii?Q?acHniAVLyRofQalvxcIhzkEuc4/APgLXeFO19vQS2MpS3BSuwfZf3AM8FJX7?=
 =?us-ascii?Q?bl8OeMbkLnJFZlYBvsKQeoxagxFc5HRoEq6YH8uE+AjUY9Zd6frRJsgEPAlb?=
 =?us-ascii?Q?lz0arqRiNVrN9t0oH57ecYqAXnERINO9fSN4ZDhwcO35s3YwaGf9Gxld0UV1?=
 =?us-ascii?Q?mFngKz0Tukf4F1RZGn6xbiZ0fx5EXdqZT6cUNXlKZnl1VzuUDpr+tFWm0lMK?=
 =?us-ascii?Q?unkRIZBVK0bImb1Thdwmuo78BFYZNPFIlCrmIY+dON+eYp5tR1Oq5u+Z6IT3?=
 =?us-ascii?Q?GsAhDJilB1zUmj9LJhn586cnF5H8EejpIWBYhGUEA6EVfYqg62w9GpAf038x?=
 =?us-ascii?Q?PVP/mnKN6Eu3++VRKR/HdpAub+xdtEynTkHaXrxhVV5eOGanfuoDtP7B33UQ?=
 =?us-ascii?Q?xW0mDlLVZAANVP6QSXElGwNMNnvOar/yk0uktSSqB7cmTEWamHB1fLAH31Sx?=
 =?us-ascii?Q?xTWhnUM/27CIWl+LtwucmWvSvxk3B5WSn8AB3NzexRXwuIQqVdMvGWjTHxGy?=
 =?us-ascii?Q?c+sLSKp8Q/+l3U0Saa/iPIG4Zt3gOrUIvhdQH5xoqTvHkRfqBZpOm++fjb2y?=
 =?us-ascii?Q?rC/fG7beDJ65bHKLpCIyBi8L/XFnVByZxXo8tShbA0ju2DJuyZGEpPvghYyh?=
 =?us-ascii?Q?5qsmsG1bTGq/0pGMkOU/MX6Aq6jC6l6f0myqLwct0b0aILchMvE0qZVaHU6C?=
 =?us-ascii?Q?augHE5gQhLK1lNNcL1nIDjMlfiMDMeyDlkVVwCzEhj67eP34LiCStAa3h6dy?=
 =?us-ascii?Q?AXKoJWukr8AOt3bAszY7le2gDGZDfKSbSmGqrGQm7/NGHkRyfDunjrgsw8TG?=
 =?us-ascii?Q?AXUGFT9H3OXS3+gi8gkD++s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd775df-320d-4445-5ca1-08d9c9c11b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2021 05:15:46.8369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18SWwMMExY89E+Q9zNrUMAZiyHly0w2z+xU4ANaqfhojGq2vyQY3kFcKe8klT+Viy4FFKbz/u+6OL6E6Wm1Ylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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

Hello Hawking,

Any comment to this patch?

Regards,
Guchun

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Wednesday, December 22, 2021 10:20 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Laz=
ar, Lijo <Lijo.Lazar@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: avoid NULL pointer dereference

amdgpu_umc_poison_handler for UMC RAS consumption gets called in KFD queue =
reset, but it needs to return early when RAS context is NULL. This can guar=
antee lower access to RAS context like in amdgpu_umc_do_page_retirement. Al=
so improve coding style in amdgpu_umc_poison_handler.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 46264a4002f7..b455fc7d1546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -112,16 +112,20 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *a=
dev,
 		void *ras_error_status,
 		bool reset)
 {
-	int ret;
 	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_status=
;
 	struct ras_common_if head =3D {
 		.block =3D AMDGPU_RAS_BLOCK__UMC,
 	};
-	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head);
+	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+	struct ras_manager *obj;
+	int ret;
+
+	if (!con)
+		return 0;
=20
-	ret =3D
-		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+	ret =3D amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL,=20
+reset);
=20
+	obj =3D amdgpu_ras_find_obj(adev, &head);
 	if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
 		obj->err_data.ue_count +=3D err_data->ue_count;
 		obj->err_data.ce_count +=3D err_data->ce_count;
--
2.17.1
