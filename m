Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8CFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 12:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F6010E411;
	Wed, 27 Apr 2022 12:14:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7B310E411
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 12:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaXKLnf8O2KjAIos9hIttTOwnbcFqYYxHsnr9bdGWBpfq5bNBDkfD1VDctBzlAGHeTwyy+/KKBlX8b38+7QFZuZLZY/5cLwvm7wrE5mCS0E8XBQ/aBI+nXo7jMk6ATCNO4QbfMHUBRUWuci9gpWFvQBVa6fqCWWIQiG+J0FNRFEMCMCOskddlc7oUfpMWfe0VXrwCZlfMkiGhtzBrb4eMLGJ/KCUk3EBzpGw8C1ZoOnoncWMwdmIaLArGy2tbfR99IaA93n97elf0EygRDRghoQPEbgL0BAjvdEE7fLqX3vzHqJd9zbGFtB5TJfGy7i1SnvEfHZH4O/5X4gFFzJU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/ob3RkK9I1jA6P536T0tDuXsD/gwsH9Zvi74tf4DlI=;
 b=MWKzsPI4Tt893sFvd1vCkfQ5GiZU39RlQMae+h4qhFgrFi33yrEknvClS3NUI8yDa7s6dIKLURFh+JUf6/Fay+hZhu8FkDBGLnOG+BAYUyhBL2OxcElwp5TnQ+JrIfoCXK/SoJOtjQj3KZCQEyePaRkQH5iFrynTn33BnfrjJPwKUndPJbymYqc4ZhaQ7QgVdys4jrN9lX3dus1G07EQ9jbh8HAuxsG9rp/oFH74UjnMDsiyK2lylqJzcv4Zg6aXOKD1xVE+XB7FvXVc3YFBzaLeISLHbxv8RZAbCQI4chj6xToqQ0n5HScXCg0gCfmlJ0SXs3wN/yieSN1rlO9ISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/ob3RkK9I1jA6P536T0tDuXsD/gwsH9Zvi74tf4DlI=;
 b=NYCCZ/2oYK3rLMoDcS3e3bkAylEzHsqsP1KOYKP1auMfME0B3iLIy9Q9CMFUUkmh7U367jtjY12oun8V62lpCqMyldHPjc6QwV9t8CgBwd4XQKHrGleSZ60rQMaj+G/IT9cQGVk4ptUjEq/ChS7wT4a8vCUymOVDfy9sUCmdOrQ=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by MWHPR12MB1712.namprd12.prod.outlook.com (2603:10b6:300:112::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 12:13:55 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c02f:cbc1:308b:b4b9]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::c02f:cbc1:308b:b4b9%4]) with mapi id 15.20.5206.012; Wed, 27 Apr 2022
 12:13:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: Fix build warning for TA debugfs interface
Thread-Topic: [PATCH v2] drm/amdgpu: Fix build warning for TA debugfs interface
Thread-Index: AQHYWikXopaPsl/g302w+Hilu5nQtK0DqwJ9
Date: Wed, 27 Apr 2022 12:13:55 +0000
Message-ID: <CO6PR12MB54734ED2AB0BF202FF40D42382FA9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220427112213.5176-1-candice.li@amd.com>
In-Reply-To: <20220427112213.5176-1-candice.li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-27T12:13:52.871Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7718c9eb-64fc-4493-d714-08da28476680
x-ms-traffictypediagnostic: MWHPR12MB1712:EE_
x-microsoft-antispam-prvs: <MWHPR12MB171291301F06952BFED9202882FA9@MWHPR12MB1712.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGwMWFTc/47P3+/bpXQ4PB+d5+zuqHP5mjFiUUSnFL1WmgqHupGaHShM5suHYHshwFg6g2v1MeH9bRhI5OYinjxBEjS8mfhuerjkYfNdaiJHF123+54gwMXm7cj5/wuvp3n/zXyULsVeI1keyScfFqmMTPhu1RHVZnYD22or9DhMcqAzhOIJScFGkpz3F5CS4FiwsjwCBBfHmx6pRe+8iKX7UPpnwMtbKHp2b0aRCUitNio428FUWjKJyyTLThSKOly66XuSDvRrsD7HqbW1YSA/s6+MPxAZdHMHQJjlkfY9U34uwGJSZ2SE8SNL6apLyoJlXEAYRzbLXvyrBOcj/fTfK9RXn9g66788DR0bA4OzNbxLaqnckcgMqYL2L/p1NX61a+tHm9p/4zQKV4nTqrP5PuZyyV99BzuWwP8OJA2RdphRor3j/sgl9Hcm6I1zOTZLiZq9pbidp004KdTNQ85GuDjUUVMUwkvYTvZhy0de9hIiKnBFEtufquQPFVmsuazRZ0ZAt4kd1yP2bxOoMJohC5ptTNdcDkdFbfJBUfAgjlfV5oXjLz1c4pNEXPcyjB3OIusM/sLULzjBdmRsYNle9Wgp2H3A0nG4SFxO2sg0ZrLguB9eUPKWbPK20OZRlRvMjxBPkJmk/kZIFa0vSzJlnMAuoJKW7CgJgtjLICRRQgAAIUOXUww1caPxaWZxSu9b/gP11118Oc06CVQbu3W1noPgtX7p3sCPEW1zZEpNOx2cRyEBxEYdPX/D9x1NbUZC5dKGLydfTHjD+14cIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66946007)(66446008)(66556008)(66476007)(71200400001)(8936002)(52536014)(508600001)(8676002)(19627405001)(26005)(86362001)(91956017)(110136005)(76116006)(5660300002)(316002)(9686003)(53546011)(122000001)(6506007)(2906002)(7696005)(186003)(38070700005)(83380400001)(38100700002)(33656002)(55016003)(461764006)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xfPQWqG9qQx5ucQ6JUBxPSau8VSyM5LQg3EK8hKLqLED9Um0v2+J3majm+?=
 =?iso-8859-1?Q?uz6DPU3CiZu+rvM0swezYB/0YWePHst6zHDo8RP/TcsNOubR/WneMZyLC8?=
 =?iso-8859-1?Q?09tK+aXfzyUalc5vAykDvu9c3bi8q7wLQwhh2I9SqalfhL+NUXXtL0ujRF?=
 =?iso-8859-1?Q?SkdwUITrpgLmeMMJXJ+j4+KT/R8YYEYDJ1B9kDDbvnm7rh+cppaGWSnJ+q?=
 =?iso-8859-1?Q?IhHm+ri/lTeuSmKUKl7RIneKZNHEBVl96chYz83NqNTPnPCXZFXxNjRc7a?=
 =?iso-8859-1?Q?6iW56YgNM2kqA5BHnYcMTMN7odG4AbPEWa6werxcVxAUm3VGC4l0CjLWmQ?=
 =?iso-8859-1?Q?onvAlpDg6yCfdbiEFuZT0qCu2Y+6JvIpUxPUpkI4PEt6Bm7FyfhQqG2k2A?=
 =?iso-8859-1?Q?YpgkT2jjvQCoQFMgy5nut7MECBY4F6JiAp9mJIMbA6V0vR0c4a9x5wRLnj?=
 =?iso-8859-1?Q?e5bSLFgoc63aCH8WS5h2QTwMiewIedI8hy+Pa5bAnkCq2yrXv0UM8UCQwW?=
 =?iso-8859-1?Q?YwXEvfmwv3tbqqrAH5uUSRGJOKKMuPt20zy23gpYXdSTGR+2Ziz/Bdv0UR?=
 =?iso-8859-1?Q?ljGgEYeuZR7csDOdQwwZouMdtAvqiCU83ji87in5V4G9aG6zvMtXfBlrEk?=
 =?iso-8859-1?Q?aZWyXsnxT5n9/sh27NgeuCrLJTj1l5V0bh6C4v4kJClHPtCqXElTineEEN?=
 =?iso-8859-1?Q?gULv7L+JwZul/yZ91sXjC+6uh8AOOfvScNZgVcrhAaPJbE1fpNYoph4Ou0?=
 =?iso-8859-1?Q?Jt6MRiaIFK+o841cRvp4eWfzhJqjC/XRruX5A43rtTqR3Sbdh1lHdOfABW?=
 =?iso-8859-1?Q?EXa0tJx6cKnbBwxj4qAZL7oHlBToQ6f+MASgmbDH/eWS4EiUigrhIl/pP/?=
 =?iso-8859-1?Q?Y6vMjLgcwiJEzRPkTmNDhHDZrwbP5cvb7Hn6cvWTEzO5RorogYb5bI0CDj?=
 =?iso-8859-1?Q?zZke/6Kl/LP5qkSK9Vy3eaXz7KBDd8N4kGEH3cadK2SL3nZriDm84eIfeo?=
 =?iso-8859-1?Q?ylBk7SUFFkgZvWW9AYqUGfYk1uKeoKhvfzRlXg5PlHB8S6ugcufzd3QPu5?=
 =?iso-8859-1?Q?agP83m3TTBYuDxgrbL9IwqwJeS/fSLkd2ZoYCD0uwvuqDiih4npPf3M0E1?=
 =?iso-8859-1?Q?nxQal3ET2lTLO2/AsaExiMWXBiFtWICcTs44rvnSIWBTbvVZbWEJwd1HcS?=
 =?iso-8859-1?Q?7dcdCxTwjKHdrLLdmerFrIxe2jcqB0RwJyVCU2x7MgV8RHOk26N5tRxaN+?=
 =?iso-8859-1?Q?TutPLFGx71t7maRt6jMdjaoQJrL+25r3cqtN8BjldVtxvVVMykH4+Nd9Lx?=
 =?iso-8859-1?Q?tQgonVaX14AmFb+tLEmH0agxagvHJ/k61PyiXLYcBMlPTipXpqjtiaInfV?=
 =?iso-8859-1?Q?gG3lQHaxOrdBqwek8Jfp/3Ig3sMJnePOg6sgW7GaJsi6/fsOkydNJRe5Vj?=
 =?iso-8859-1?Q?CYkZzodaaNlfQYMB3LnoSuSbKX8H8uWQiTPGu+XO1qFuLAOlGTvC9+HpTg?=
 =?iso-8859-1?Q?ErAs79yuMohCdIg4mpl+uyKMdSbLdSeBk4VvolslM0sLg/tTUue8/zB4m2?=
 =?iso-8859-1?Q?6r4Y6WWfoLqNmz48XMhZQx1tSHDmAbf78Mh61tLc3Ehu5mJ7hDWWirwXKh?=
 =?iso-8859-1?Q?0vgyKrzTvnLKTllyx/orl3Y+uk5KrDi1lraSUg/YCa3MQeDu9hs88T+PB/?=
 =?iso-8859-1?Q?Pp41A89pLOJ2byqvlkXskJMNm6DiLGRCmCduGcePKgX5VOdJ6hJ5vSm2iE?=
 =?iso-8859-1?Q?PYEp43rixpvCpbp1SYk+hyu3LKZKTuZcRr3bw8yI82PjHu?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54734ED2AB0BF202FF40D42382FA9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7718c9eb-64fc-4493-d714-08da28476680
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 12:13:55.3699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1jRtMK0xv4hVVMN/BF5rPZtyoQF+QFp+FXC8gX674fFQiJu36y2aLk5v5P1RRX5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1712
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

--_000_CO6PR12MB54734ED2AB0BF202FF40D42382FA9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Candice =
Li <candice.li@amd.com>
Sent: Wednesday, April 27, 2022 7:22 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix build warning for TA debugfs interface

Remove the redundant codes to fix build warning
when CONFIG_DEBUG_FS is disabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 43 ++++++----------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
index 6806deb098d3f7..97ea2246bc1ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -24,13 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_psp_ta.h"

-static const char *TA_IF_FS_NAME =3D "ta_if";
-
-struct dentry *dir;
-static struct dentry *ta_load_debugfs_dentry;
-static struct dentry *ta_unload_debugfs_dentry;
-static struct dentry *ta_invoke_debugfs_dentry;
-
 static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
                                             size_t len, loff_t *off);
 static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf=
,
@@ -38,7 +31,6 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp=
, const char *buf,
 static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf=
,
                                             size_t len, loff_t *off);

-
 static uint32_t get_bin_version(const uint8_t *bin)
 {
         const struct common_firmware_header *hdr =3D
@@ -74,19 +66,19 @@ static bool is_ta_type_valid(enum ta_type_id ta_type)
 }

 static const struct file_operations ta_load_debugfs_fops =3D {
-       .write   =3D ta_if_load_debugfs_write,
+       .write  =3D ta_if_load_debugfs_write,
         .llseek =3D default_llseek,
         .owner  =3D THIS_MODULE
 };

 static const struct file_operations ta_unload_debugfs_fops =3D {
-       .write   =3D ta_if_unload_debugfs_write,
+       .write  =3D ta_if_unload_debugfs_write,
         .llseek =3D default_llseek,
         .owner  =3D THIS_MODULE
 };

 static const struct file_operations ta_invoke_debugfs_fops =3D {
-       .write   =3D ta_if_invoke_debugfs_write,
+       .write  =3D ta_if_invoke_debugfs_write,
         .llseek =3D default_llseek,
         .owner  =3D THIS_MODULE
 };
@@ -286,31 +278,20 @@ static ssize_t ta_if_invoke_debugfs_write(struct file=
 *fp, const char *buf, size
         return ret;
 }

-static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
 {
+#if defined(CONFIG_DEBUG_FS)


         struct drm_minor *minor =3D adev_to_drm(adev)->primary;

-       dir =3D debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
-
-       ta_load_debugfs_dentry =3D debugfs_create_file("ta_load", 0200, dir=
, adev,
-                                                    &ta_load_debugfs_fops)=
;
+       struct dentry *dir =3D debugfs_create_dir("ta_if", minor->debugfs_r=
oot);

-       ta_unload_debugfs_dentry =3D debugfs_create_file("ta_unload", 0200,=
 dir,
-                                                    adev, &ta_unload_debug=
fs_fops);
+       debugfs_create_file("ta_load", 0200, dir, adev,
+                                    &ta_load_debugfs_fops);

-       ta_invoke_debugfs_dentry =3D debugfs_create_file("ta_invoke", 0200,=
 dir,
-                                                    adev, &ta_invoke_debug=
fs_fops);
-       return dir;
-}
+       debugfs_create_file("ta_unload", 0200, dir,
+                                    adev, &ta_unload_debugfs_fops);

[kevin]:

I think your patch is still have "defined but not used" warning,
because the ta_xxx_debugfs_fops are not used when the macro of CONFIG_DEBUG=
_FS is undefined.

It's better to add this macro check outside all functions.

Best Regards,
Kevin

-void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)
-{
-#if defined(CONFIG_DEBUG_FS)
-       dir =3D amdgpu_ta_if_debugfs_create(adev);
+       debugfs_create_file("ta_invoke", 0200, dir,
+                                    adev, &ta_invoke_debugfs_fops);
 #endif
 }
-
-void amdgpu_ta_if_debugfs_remove(void)
-{
-       debugfs_remove_recursive(dir);
-}
--
2.17.1


--_000_CO6PR12MB54734ED2AB0BF202FF40D42382FA9CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Candice Li &lt;candice.li@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, April 27, 2022 7:22 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: Fix build warning for TA debugfs int=
erface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
 class=3D"elementToProof">
<div class=3D"PlainText elementToProof">Remove the redundant codes to fix b=
uild warning<br>
when CONFIG_DEBUG_FS is disabled.<br>
<br>
Reported-by: Randy Dunlap &lt;rdunlap@infradead.org&gt;<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 43 ++++++---------------=
-<br>
&nbsp;1 file changed, 12 insertions(+), 31 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c<br>
index 6806deb098d3f7..97ea2246bc1ddb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c<br>
@@ -24,13 +24,6 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp_ta.h&quot;<br>
&nbsp;<br>
-static const char *TA_IF_FS_NAME =3D &quot;ta_if&quot;;<br>
-<br>
-struct dentry *dir;<br>
-static struct dentry *ta_load_debugfs_dentry;<br>
-static struct dentry *ta_unload_debugfs_dentry;<br>
-static struct dentry *ta_invoke_debugfs_dentry;<br>
-<br>
&nbsp;static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *=
buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *off);<br>
&nbsp;static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char=
 *buf,<br>
@@ -38,7 +31,6 @@ static ssize_t ta_if_unload_debugfs_write(struct file *fp=
, const char *buf,<br>
&nbsp;static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char=
 *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len, loff_t *off);<br>
&nbsp;<br>
-<br>
&nbsp;static uint32_t get_bin_version(const uint8_t *bin)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *hdr =3D<br>
@@ -74,19 +66,19 @@ static bool is_ta_type_valid(enum ta_type_id ta_type)<b=
r>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const struct file_operations ta_load_debugfs_fops =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp; =3D ta_if_load_deb=
ugfs_write,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp; =3D ta_if_load_debugfs_w=
rite,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODU=
LE<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct file_operations ta_unload_debugfs_fops =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp; =3D ta_if_unload_d=
ebugfs_write,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp; =3D ta_if_unload_debugfs=
_write,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODU=
LE<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct file_operations ta_invoke_debugfs_fops =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp;&nbsp; =3D ta_if_invoke_d=
ebugfs_write,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write&nbsp; =3D ta_if_invoke_debugfs=
_write,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner&nbsp; =3D THIS_MODU=
LE<br>
&nbsp;};<br>
@@ -286,31 +278,20 @@ static ssize_t ta_if_invoke_debugfs_write(struct file=
 *fp, const char *buf, size<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device *ad=
ev)<br>
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
+#if defined(CONFIG_DEBUG_FS)</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_minor *minor =
=3D adev_to_drm(adev)-&gt;primary;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D debugfs_create_dir(TA_IF_FS_N=
AME, minor-&gt;debugfs_root);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_load_debugfs_dentry =3D debugfs_cr=
eate_file(&quot;ta_load&quot;, 0200, dir, adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &amp;ta_load_debugfs_fops);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *dir =3D debugfs_create=
_dir(&quot;ta_if&quot;, minor-&gt;debugfs_root);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_unload_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_unload&quot;, 0200, dir,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_unload_debugfs_fops);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;ta_load&quo=
t;, 0200, dir, adev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ta_load_=
debugfs_fops);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_invoke_debugfs_dentry =3D debugfs_=
create_file(&quot;ta_invoke&quot;, 0200, dir,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev, &amp;ta_invoke_debugfs_fops);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dir;<br>
-}<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;ta_unload&q=
uot;, 0200, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;ta=
_unload_debugfs_fops);</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof"><span class=3D"PlainText" style=3D"=
margin: 0px; background-color: rgb(255, 255, 255); font-family: &quot;Segoe=
 UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, =
-apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans=
-serif; font-size: 11pt; color: rgb(0, 0, 0);">[kevin]:</span>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"><br>
</div>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web=
 (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11pt; colo=
r: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">I
 think your patch is still have &quot;defined but not used&quot; warning,</=
span></div>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web=
 (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11pt; colo=
r: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">because
 the ta_xxx_debugfs_fops are not used when the macro of CONFIG_DEBUG_FS is =
undefined.</span></div>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"><br>
</div>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"></div>
</div>
<div class=3D"PlainText elementToProof"><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0); background-color: rgb(255=
, 255, 255);">It's
 better to add this macro check outside all functions.</span></div>
<div class=3D"PlainText elementToProof">
<div><br>
</div>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web=
 (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11pt; colo=
r: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">Best
 Regards,</span></div>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web=
 (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystem=
Font, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 11pt; colo=
r: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">Kevin</span></div>
<div class=3D"PlainText" style=3D"margin:0px;background-color:rgb(255, 255,=
 255)"><br>
</div>
-void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev)<br>
-{<br>
-#if defined(CONFIG_DEBUG_FS)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir =3D amdgpu_ta_if_debugfs_create(a=
dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;ta_invoke&q=
uot;, 0200, dir,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;ta=
_invoke_debugfs_fops);<br>
&nbsp;#endif<br>
&nbsp;}<br>
-<br>
-void amdgpu_ta_if_debugfs_remove(void)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_remove_recursive(dir);<br>
-}<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB54734ED2AB0BF202FF40D42382FA9CO6PR12MB5473namp_--
