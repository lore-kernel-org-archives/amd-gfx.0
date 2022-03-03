Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE46C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 03:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9030810F062;
	Thu,  3 Mar 2022 03:33:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D7B10F05F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 03:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iApkAqQE+dvlU4yOTeIzGSEQOFga7JUCKyyl925PbLIs4j7nM0K6k2JQS1+t31jzr3Aop4RDLIaw3TKa6iCB5f2aKvbPJecoO9B5B4qt0wTgOhUBqo+I7WOfdjLT+9cmqnMIFMbHQqATsES5Epp7jPp8kC5eF0mat9W/UmtxZPn1WQpHyXK92+xFpm7z8eloRvEZRxBp0QkpxX67hcJdPjQifaWO/OcdaR5zbYqi+WNHi3ijJaSNJJB9sizIkxZPR+4wFcnK504l89Rk0cCd7d6Cw8QlAwV821w8EHLVS5O5YNSqSpYsLdSX7W7JCwe05yq5BGKaDfP1a28gX+QOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4REAXQ6CeMIco4ojh+tyUMLbO9LZVm9arXThIELY9w=;
 b=PQUlukRmJ8ib/TawJjww2f+3AALPAwOy1DXOxja41UQOdMeJtx2XWdXXr4whHkyK2SE2kg/TjXv08PVECIQhspPHI67SFoHtT2/m0PEgTqbERBhGKuHh9xWih8BMN6PWpM05jPbp+6gjSebnitqueKJYQIB0Nb60lgD7OisL1m6L9py9I53oCaDS+5U48JsJU3KjWZes44WX9ecnl9Ng2yfvKoJ/ppw+bCpJqB07bL8hxMzolXW0ROzBALWTRwvO+ZhKmnynWr5X8ewrjhc9p982bcnTachyXq45sBO3uONHWeTD0LCXRNLBBwXKKybFqVFFktob2mEj+3ucPOSIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4REAXQ6CeMIco4ojh+tyUMLbO9LZVm9arXThIELY9w=;
 b=p7S6vL0tXVCcPy8slO27exE1bURTcuFBIn0Y4LJdxSnov8nE7oOQFajg1wvdx1wKD1wtsD+O+ze26+fZ0uB0V3qKxvAEf9z8Id0/5b0tyYH7Uyx8C7XWu6kotjVrKZKhPdm0J+un74I1dJZgBlmXx4INXaIjL/bSrAFSelaLsXE=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR1201MB0004.namprd12.prod.outlook.com (2603:10b6:404:ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 03:33:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 03:33:12 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
Thread-Topic: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2
Thread-Index: AQHYLImpI07vw9G4JUyBUf+6rkJvGKytBaeA
Date: Thu, 3 Mar 2022 03:33:11 +0000
Message-ID: <BYAPR12MB4614485194DEB2361556B60C97049@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220228095723.721786-1-lijo.lazar@amd.com>
In-Reply-To: <20220228095723.721786-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-03T03:33:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d1fe6b42-0ecc-46d0-aecd-3d383d99d3ef;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-03T03:33:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e4572635-af23-4711-a58f-61dbe175d2d5
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 459c060e-0b8c-4c79-8a28-08d9fcc68b48
x-ms-traffictypediagnostic: BN6PR1201MB0004:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0004FC8D13B0B52A1A4C70AF97049@BN6PR1201MB0004.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQQca9lKVOOR5rpD0wbas8DLzxPjWh6WKAmwtv+Cub2O4tQ3BZJAgLIsGNSnfDuJJm4wR24MTpthoNR1llEbHPhQuHcj4iahLvugHBCzFGgyPQtpyEXn9eYFr5PBrDFiF6Ne4fliZIyQrsT4cosF7ykdwFGn0zEf4tO/+DsxsSEhPxJZwCMhjHK85NdwGZ/cIgEipbrteq4D7a8KJtz5n7jWKyYXRVVtpt86E5ZCIaYA1a3ouGGCqNaZyFHaGQX54bSkUgRK/Iz7pdoanZ8oeMXP1QODoGXJ/+QyrmD3CUS8+W5ZpL/abjWDsiLqsvSMTMHhGIhYBDpDRKIhoVZBABn4YD+B6l/aQ69cwI/cI8KbE/n7mxTC0YEuXtl0BjDSgwenxqYE7qaNe4Ln2o8NI3D2Ru0kJyRSiigN9aHKKK7k9Nr52j1b4C6BGKBZIpFSrm/D82Fy9zLEJZREqXK5BXvvvoGCb2zMLMVcDaDv5c/XV6jHau/2KnX7lxuZIvZ1dMKN4/XXucmI7rmileAg5zV6U5FmbTUGVlKgUt9pSqMvKnBhOrYn3uyurl9nIADAB4cGhjTULc90hYYSiIT+5OZVyz926AjqnFspELj+drliTliFgFyf7TxQKXJPHmoYmxyC1rG3mtgbP9m/kfDhoNNQR8/YzP83zRH/okGJP9eU5L2tz3StREralrzrgmCvyL3wq03b1q/GoCQ4MVFNmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(71200400001)(2906002)(122000001)(5660300002)(52536014)(8936002)(33656002)(83380400001)(508600001)(8676002)(66556008)(54906003)(66946007)(4326008)(66446008)(64756008)(66476007)(110136005)(26005)(186003)(76116006)(9686003)(38100700002)(316002)(55016003)(53546011)(6506007)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FBuQ9yUCh4WYXvbEqIy0I8n9BXHNapr6eL15a4K6zAt3+YOtQaVai9wWj8A5?=
 =?us-ascii?Q?emGw3zbV4nVqmnrJGDkXDJcu6O8K3R+spymPokCT9cT1hvtiDf91J1+BbJjl?=
 =?us-ascii?Q?VTdhNCmW5A24mLYxmE09t/PR7UDPvvGDX92OhxFYc7lwOmEGTnGzvKa+vhLm?=
 =?us-ascii?Q?9Y+LfPgooK5UjO7raHkzJZX6MWH1sY8iLoTqEj4NxxuAX3s4us9y43F/tfVS?=
 =?us-ascii?Q?6TUE6kNrDmPtuGAaOBmL+sCvJZ97yUcmjPZNqCqXJYBLgY4QWlHskW5iewx+?=
 =?us-ascii?Q?LZNnEBQQ7JlyQ1LI9CLp+4ohkTrxBPcHUcAidUGFZVHdgZ5Ug9kayJcvsHMz?=
 =?us-ascii?Q?osD0cVqDAlL1e4BoW9cXNTVUpPHHPg2eyzOhSM2JBkkmUXXdE27OmHrsBA3k?=
 =?us-ascii?Q?aSx+RWZsOBOu8VUvhU0KoHVVNhT54Q5uIz6HFB2Mi0bhlE3X9dkAQ9CAzQiB?=
 =?us-ascii?Q?F57s7kJW2tgkaqU3q9juqO6nRZrUIv/WJyvI+Yh9Va4CZZcURsvulosOCS5c?=
 =?us-ascii?Q?rHbGWpnQglFeADGDUGc04SJ0F7e5KJ8YVd9qVBSY+pKSzblXLQkuU5lsU7Go?=
 =?us-ascii?Q?hB+AlOGhiGvUoZV5KfFbNwUCd7pRAHntUxCWo7nUXaJ6yFiJW/Cu1RT4b+qK?=
 =?us-ascii?Q?fSoohfCMouSPIk4Bt+5B1a8N8S2ItFlH7AW7/TMBVa7qM8KCW8Ye1j1i5loO?=
 =?us-ascii?Q?Ul+9EbUCCi7PPdCpmk9Xaz3a6ia4s/qR6yhIQzXnPYGpoHnKL1V4FRKLtv+s?=
 =?us-ascii?Q?zyoM89wkMKPTnBfmzeAZQgpP0d4no3bDULxhrISkOgOdEZYtoieW2ZFw1Q1p?=
 =?us-ascii?Q?NKndRIZER0VQ/na37k3agonFVbUtjZzFRqNLJChfRgUmpfbrHDNYV6l1sgrO?=
 =?us-ascii?Q?mGt75/Gm5oQmkey9f36llf/hnQxp0dmo1CEdnV8g7StWVPsJ2+n45aTLSieI?=
 =?us-ascii?Q?4jNf+3jJ7Pk345ZcLW7cnMQgd7qcxTuMmpFCpT14zxeiVKgG9Iwgu7AkWuH9?=
 =?us-ascii?Q?URXD5Qv3YWq9o3arwnOB4aLb+svAQ4FBAEwNQ1Op3zUhoXTmHLJUkr+30v/B?=
 =?us-ascii?Q?4m924NMzDgVkKyQh2twqm3v3tNj6W/D19yWf4MTL8/ORPdsncgN8+kxYgcSG?=
 =?us-ascii?Q?DO20iK2n5sI9k3cfccwgWuurS1Ce0iaG5y+pJiKSJlpBEucnKUMv9cHmX/fi?=
 =?us-ascii?Q?LnYgdT0lgYZSAjNJxLAgWgg84VLYa8rmbx638qSanvYzTo3d4R0yqE6o5LPs?=
 =?us-ascii?Q?IeRmMDaDl3MHxwQUNrwI8Sgzed1JqlpvdSSp1SC2emcyGROlKJrggtO7L114?=
 =?us-ascii?Q?7qXiJBbyFWlFcrp7opFhRFUim8bZXHPa59VgRq78Ecp2SaIOkgXg9P1MQ6WM?=
 =?us-ascii?Q?0nZhZoyZUfL04yw/y+wLsowYmz5+5KVkmKfbGO/EGxHCwMhDF7epO1K1Zh4C?=
 =?us-ascii?Q?mzZA/DzOQZqEaykrBZpD5vSFilFJLJx7/fF/X7vd/rQM4HQFUz5gBKP5UuJc?=
 =?us-ascii?Q?Z/RJ5My4QLTNl3Lg7sS04RCbqXfrulfgA7Uvi40XVbolJLsK81qgRikOynbh?=
 =?us-ascii?Q?X/z2tekq85tzj5ith6Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459c060e-0b8c-4c79-8a28-08d9fcc68b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 03:33:11.8740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBY0wEO05Rn3bRk/vtjzVQ8DVL7NTd/NhEmOQZAD4gf/zazktEjzGLtDuLfZoUqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0004
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

<Ping>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, February 28, 2022 3:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Refactor mode2 reset logic for v13.0.2

Use IP version and refactor reset logic to apply to a list of devices.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c    | 66 +++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  8 +--
 2 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
index a545df4efce1..c6cc493a5486 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -31,6 +31,17 @@
 #include "amdgpu_psp.h"
 #include "amdgpu_xgmi.h"
=20
+static bool aldebaran_is_mode2_default(struct amdgpu_reset_control=20
+*reset_ctl) {
+	struct amdgpu_device *adev =3D (struct amdgpu_device=20
+*)reset_ctl->handle;
+
+	if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+	     adev->gmc.xgmi.connected_to_cpu))
+		return true;
+
+	return false;
+}
+
 static struct amdgpu_reset_handler *
 aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 			    struct amdgpu_reset_context *reset_context) @@ -48,7 +59,7 @@ aldeb=
aran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
 		}
 	}
=20
-	if (adev->gmc.xgmi.connected_to_cpu) {
+	if (aldebaran_is_mode2_default(reset_ctl)) {
 		list_for_each_entry(handler, &reset_ctl->reset_handlers,
 				     handler_list) {
 			if (handler->reset_method =3D=3D AMD_RESET_METHOD_MODE2) { @@ -136,18 +=
147,31 @@ static int  aldebaran_mode2_perform_reset(struct amdgpu_reset_con=
trol *reset_ctl,
 			      struct amdgpu_reset_context *reset_context)  {
-	struct amdgpu_device *tmp_adev =3D NULL;
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->handle;
+	struct amdgpu_device *tmp_adev =3D NULL;
+	struct list_head reset_device_list;
 	int r =3D 0;
=20
 	dev_dbg(adev->dev, "aldebaran perform hw reset\n");
-	if (reset_context->hive =3D=3D NULL) {
+	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2) &&
+	    reset_context->hive =3D=3D NULL) {
 		/* Wrong context, return error */
 		return -EINVAL;
 	}
=20
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	INIT_LIST_HEAD(&reset_device_list);
+	if (reset_context->hive) {
+		list_for_each_entry (tmp_adev,
+				     &reset_context->hive->device_list,
+				     gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list,
+				      &reset_device_list);
+	} else {
+		list_add_tail(&reset_context->reset_req_dev->reset_list,
+			      &reset_device_list);
+	}
+
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		mutex_lock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset =3D AMD_RESET_METHOD_MODE2;
 	}
@@ -155,8 +179,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
 	 * Mode2 reset doesn't need any sync between nodes in XGMI hive, instead =
launch
 	 * them together so that they can be completed asynchronously on multiple=
 nodes
 	 */
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		/* For XGMI run all resets in parallel to speed up the process */
 		if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 			if (!queue_work(system_unbound_wq,
@@ -174,9 +197,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
=20
 	/* For XGMI wait for all resets to complete before proceed */
 	if (!r) {
-		list_for_each_entry(tmp_adev,
-				     &reset_context->hive->device_list,
-				     gmc.xgmi.head) {
+		list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
 				flush_work(&tmp_adev->reset_cntl->reset_work);
 				r =3D tmp_adev->asic_reset_res;
@@ -186,8 +207,7 @@ aldebaran_mode2_perform_reset(struct amdgpu_reset_contr=
ol *reset_ctl,
 		}
 	}
=20
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		mutex_unlock(&tmp_adev->reset_cntl->reset_lock);
 		tmp_adev->reset_cntl->active_reset =3D AMD_RESET_METHOD_NONE;
 	}
@@ -319,16 +339,30 @@ static int
 aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 				  struct amdgpu_reset_context *reset_context)  {
-	int r;
 	struct amdgpu_device *tmp_adev =3D NULL;
+	struct list_head reset_device_list;
+	int r;
=20
-	if (reset_context->hive =3D=3D NULL) {
+	if (reset_context->reset_req_dev->ip_versions[MP1_HWIP][0] =3D=3D
+		    IP_VERSION(13, 0, 2) &&
+	    reset_context->hive =3D=3D NULL) {
 		/* Wrong context, return error */
 		return -EINVAL;
 	}
=20
-	list_for_each_entry(tmp_adev, &reset_context->hive->device_list,
-			     gmc.xgmi.head) {
+	INIT_LIST_HEAD(&reset_device_list);
+	if (reset_context->hive) {
+		list_for_each_entry (tmp_adev,
+				     &reset_context->hive->device_list,
+				     gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list,
+				      &reset_device_list);
+	} else {
+		list_add_tail(&reset_context->reset_req_dev->reset_list,
+			      &reset_device_list);
+	}
+
+	list_for_each_entry (tmp_adev, &reset_device_list, reset_list) {
 		dev_info(tmp_adev->dev,
 			 "GPU reset succeeded, trying to resume\n");
 		r =3D aldebaran_mode2_restore_ip(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
index 02afd4115675..e9b9ce80f7d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -36,8 +36,8 @@ int amdgpu_reset_init(struct amdgpu_device *adev)  {
 	int ret =3D 0;
=20
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 2):
 		ret =3D aldebaran_reset_init(adev);
 		break;
 	default:
@@ -51,8 +51,8 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)  {
 	int ret =3D 0;
=20
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 2):
 		ret =3D aldebaran_reset_fini(adev);
 		break;
 	default:
--
2.25.1
