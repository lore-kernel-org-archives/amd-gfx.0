Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE93C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 13:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD9F884B0;
	Tue,  8 Feb 2022 13:28:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A6810E208
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 13:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyfEa25UmcBMyqBDG6K1B2vD8mSrObdvNN58uNaBUfXOyUIbpvaBdZKS0gxcYX+pzrrhSo8cWapNwnckeIvJONs4xwdlDSpGwwvC1Gn9E6CMcMiRYYsYsHBNd1R1OFoe8+mnWo0nW7EKi2dnU8zbKyJvhybH3onyVzyt6nZacgZMnE7+PMjEPuX+PUNGQVKhaxbRgWcV4LsFN6UhNs1eZTsiYMUCg74x6aEGRj3gzccaPQv3WEtvpQd1mxxBrjJiyiXdtJZiLQJyMxr6xskwOMBe/fgx+mzCOuOOrphv6l0i5GkQ3C9S/zx0EUV1Mv8VLIPnfXiQQWg+Vv+mLD+mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv9C9lbCoONJWRVEjQGQLC59oDG9AdSI+y5hwx1ey18=;
 b=EEOu7sqyJUrGVBH+iRYdl6J2vzWMaD5Y3Dni3kTG8UNyKH5R28KXc4qUhmgupZ+4SNQlxmEHh/crWtpyMztH9dMhXT42C8nioEAp5boCwMOzdcprQITTDGC6LyDAXx49Z8WAvwO0Tu9TNs7c/gvfYZO7sORRtkTw0u4WPcIaEJY/LvhH8XRhJuEuldZO+CTOPwLg6J/2UcmCC/AXqeqeDNT3YGTcWPwJmh/2tB4mcbl+oV1PKjxvHIXOqzU7SbmDzu2QC0TAl4TimQUVckkrgf7DjAA6E9GKSiI0+LNHuOEX8+80sOfb+JpJyEzPHJXqJRRNSgJ5YpE6zAq5okAUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv9C9lbCoONJWRVEjQGQLC59oDG9AdSI+y5hwx1ey18=;
 b=Ku92qC0h5e7lggTCRNbH8kC4fjnPtkUMe4SB1fKp+5HTrwCE4o/s8tLU2C+N7dqHUVLAKTmigf5fE3hLOMPl19rMgOG7l29qJ0Ow0Vc2VJavI0fwDXvDDlGCOW0bYrAdAxCyG9ZdY5pt5n3KIkNKCHSrfPHvfRUAO/+pf1v16bE=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 8 Feb
 2022 13:28:51 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::fc44:f9f3:62e7:af2d]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::fc44:f9f3:62e7:af2d%5]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 13:28:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct hwmon power lable name
Thread-Topic: [PATCH] drm/amd/pm: correct hwmon power lable name
Thread-Index: AQHYHL+ww71PnuL7ekOK46HhXwlyIKyJpXiQ
Date: Tue, 8 Feb 2022 13:28:50 +0000
Message-ID: <BL0PR12MB2465149AF1ED9E6874D91E8EF12D9@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20220208074354.379024-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220208074354.379024-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-08T13:26:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6598e455-9e94-4be3-8766-e44d07c2ddc6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-08T13:28:47Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c659640e-2eaa-43d6-8caa-49470e06984a
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c664fe45-3f2f-49dd-f820-08d9eb06f1e9
x-ms-traffictypediagnostic: BY5PR12MB4084:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4084E3C2ECC598F17B169135F12D9@BY5PR12MB4084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBpV5AigJOReyepqKUKj/d7AbxFLXeFQIySq9Ff5O5ZktvzYIl+4MTfh04sderq42RchOpC3tRe1U0yLa1O2DcOcd7OQU4w55aBMgU9xuM9YGQ47EwIyGu3zHVF9KA+dotqZHlqRDa2cqPN5PhkiVLZ7lQdhE98ww0meeqkC6tKw8xm/uw4qT5fYpmdhbiPJevyadxuK07UoiAczQopn2CN6XxXyqftP4ZZ45h4yi/HYge7asu/GPJWdzj88JelzAip8GwaA6HO3p1j5Tyh+P58L4AOJ+N8yAW7APPdgc+7HKEMvakDyJAdFKPHE3Peo9l03Wb5l9tQy1pXKVb+v3O1O8QjzcmXAQoYjHRUttPI4N0o9u4k8+V1PdbTvUPG8zAOuZ8uRj1DsiaqcbkRFULrpAexm1XieQefZE6dBZDWkryCLZxTMuoDEc4jPOhcYFUr6WqZfZmWbrK6ZwBflfIMauDSLwSHWspapjJX/ETSKppOdUOwgRQAu9fmtt0A8AubapExku/bW6zplJU5pO/+PxSnb2VKFCIsK2fUO7QEfBp5LXLicaS9iJydpVF2z1W8CgL7i8hUFORrUfnWiJQnIKcKJ41zcR1oMoNx1Fj5gzjkVwsMUTWg5ikZB31PXZ1f3aKwWuYFkwmVmOtCWw1+9tDg2PxiXhNzHNIgt5pYBuiSRqs3lXgfDd06S6CyLsx9j70Pnyoy4BQA16vcGbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(38100700002)(53546011)(7696005)(2906002)(76116006)(8676002)(9686003)(8936002)(66946007)(66476007)(64756008)(66556008)(66446008)(316002)(54906003)(110136005)(508600001)(52536014)(122000001)(38070700005)(5660300002)(55016003)(33656002)(4326008)(186003)(26005)(86362001)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lvBfU5tgqbpYJW14pNj04OQJdOWepB+LPMeDA8eKuQHhGoes9/zaWoseUfZv?=
 =?us-ascii?Q?jBUXkn8icglwaBCdZRZ1tXH3rQn2B0uyTUmEtOUKDMBSlDNO9YcnZ8XB9SzI?=
 =?us-ascii?Q?0xXPr9SSy9+4xCXlzr5/gfl1dZ6nYEsC9aGALPYfplYFAuHNepvA/mG+n9+u?=
 =?us-ascii?Q?k1EyAWVNK1SH3fJxEix8u46IoXoKvE0d8btPhVET75p4/CUOtRNr1HtPe5S6?=
 =?us-ascii?Q?SHrRMF7vP7XtZ1dsAgIpSmPMeosPO3iSLpZ/RYVSlcqxwnsIk3QBNMGLHUWh?=
 =?us-ascii?Q?0aDQUTvL+n+B8ETNIeVDmspgE+zRe4a3EBX+zbbsEcB+0xvmspSKPF/Wb8sS?=
 =?us-ascii?Q?tTqSDXpZuGETFXA7tZzGov+VUmEhwrtb1WwEBPwz/xycUlwSmEjbqR65hm4I?=
 =?us-ascii?Q?HcQI6DB3x4mJPNZoXdMPPljt9oA/dfsR1XgRvLRgwOpy2mvpAAXNFhni21Vp?=
 =?us-ascii?Q?1p5ujXDmwtsz82Fl6VKjS+J5tlRnW8QHpBiihSQaodB0jo5cqRrJTX/YJoRa?=
 =?us-ascii?Q?PTwCWihrrMKNOxBnQE7uz+3S6x5rlKK21pwUhr31SM7mSENrvDRA9aCx1W9R?=
 =?us-ascii?Q?WJYtt2mppgaHwuuUNAhG34J5tktFREZdK7Pd+RcIbmBnaprvJg1p2BaEubmC?=
 =?us-ascii?Q?EosQR8AUDRrCbrQAN4sGLrTrW+FI4VDUVeR/DYzZcGDISMfietlmDF/ALPlX?=
 =?us-ascii?Q?foZzIlK0ZQSQdvCn9bMgxQevFYgaQCrygtogdgBXT9U1o7TqxjNJerOnKAb8?=
 =?us-ascii?Q?BETuSPTVE3Cwga0F2qPz2fFCpQWDgB9GWhwylFY2DMpiAxKxnJoi+olXIloA?=
 =?us-ascii?Q?Ilby7d9TDPzcckHOM3En/kGD2J+3sCX79dTKT9kOJSD5yY1Fs4YLS4a4jf1O?=
 =?us-ascii?Q?BxOMsx5gOLpmFbNg2qSlgmIUtCz4Ioz9PP251ADmTYmaYXGyxrbzQKUNbVxK?=
 =?us-ascii?Q?X6JU9a+yD+/5Hme34fEdAlVRnZOcckrYNGv8AYm2V4d7wV8+EAQCfEI5vX/6?=
 =?us-ascii?Q?xp9SiqYFDFNS64zcFzTEE/4TnlUBWQFrLSAl2ajQ5R8TnjiJgPNJ3JaLQR+j?=
 =?us-ascii?Q?gO7bx+SxBWgnwLk1m009pug3qyQlIUzi6MDx4EhIUrZaS30sSzX6vs2VQQQS?=
 =?us-ascii?Q?WTXe1PKOdxX7Zl1JcgWbc7Od4/PceXO1z+7HZW2B+ydHyPvBhxjf+7sDslYx?=
 =?us-ascii?Q?FkTzTtscAFJ0Fvs5haiWarDso9G4GEA5hWy8WREv3qQ2IIcoFXFa8/rwerAP?=
 =?us-ascii?Q?Rd/qqmaSYN2Rn+RhIsxbftadExfXJLOUcE03Lb5tRxdc0ustgC2568g+EJE1?=
 =?us-ascii?Q?Q0gCGtGW5QgZZAHqgVYkNRQN+oVtVtz+6+YHGKhaQE8kBVkN036EoFetiny8?=
 =?us-ascii?Q?pg1TCQmlxrO5ks7/GaHJJTQ4gTRU8ug+K3Xfw+bCh3XPO8hNgHqYzqg8gFL8?=
 =?us-ascii?Q?rN/lnDfppV2M3Eh1o2YoPwVyUSP9eK4ZemhElA0ZXOLI2L56EL8j95fja37r?=
 =?us-ascii?Q?wQTu40fKdprGuWuGkrGKk0JvD38cPxPnuhs2tw8StKmveVsrixlKSqampCM/?=
 =?us-ascii?Q?LVjLpCuRRW/uhLxYAaBqcsP9BQI+Eu8R/dG/qrw1k0AoIrEnDXXQrzrYmlh/?=
 =?us-ascii?Q?jgpBk3KYlittGf0xnQZd7Zg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c664fe45-3f2f-49dd-f820-08d9eb06f1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 13:28:50.7797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6HB6ZmslalTfmLw4J3kJQAlpkxDdpe5r746On3jw7uZKVggjWKdg4FnhGKAeiLlAGVeZcv0etziIYdW9IT1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Hou,
 Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Wang, 
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

A typo in subject, s/lable/label.

With that addressed, the patch is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Tuesday, February 8, 2022 3:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Yang(Kevin) <KevinYa=
ng.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: correct hwmon power lable name

only vangogh has 2 types of hwmon power node: "fastPPT" and "slowPPT", the =
other asic only has 1 type of hwmon power node: "PPT".

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 426e00112c91..ad5da252228b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2842,10 +2842,14 @@ static ssize_t amdgpu_hwmon_show_power_label(struct=
 device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	int limit_type =3D to_sensor_dev_attr(attr)->index;
+	struct amdgpu_device *adev =3D dev_get_drvdata(dev);
=20
-	return sysfs_emit(buf, "%s\n",
-		limit_type =3D=3D PP_PWR_TYPE_FAST ? "fastPPT" : "slowPPT");
+	if (adev->asic_type =3D=3D CHIP_VANGOGH)
+		return sysfs_emit(buf, "%s\n",
+				  to_sensor_dev_attr(attr)->index =3D=3D PP_PWR_TYPE_FAST ?
+				  "fastPPT" : "slowPPT");
+	else
+		return sysfs_emit(buf, "PPT\n");
 }
=20
 static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
--
2.25.1
