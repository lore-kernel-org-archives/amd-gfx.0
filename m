Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E6CC3DA70
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 16:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2C710E541;
	Tue, 30 Jul 2024 16:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MR5kT0hb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06DB310E541
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 16:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8/b3fnOMufHbSLxcKrJ7pes5ZzmPZPi5Cp9UsFN1Boxc/PZrM/kvSZHIkN2SYEwqK4y6fKu+ZWH83ONJtvenW1QWof4iK2CZPx6T9mRk7h1zjTnpdSSK+rC+d6AjVJ7zedJFZWTXS+ia8UD3J6taa0KNd59tJDnwi/TdIqu7kMYAJ+mf9fSzQZiN3FUMHfGP7I73x02yGl+t7EAhkuf4qlrUqzjBuZvuw7QsKYbWzK8fK/WMgVGKtz6qco+OC9kZA/8ro6fb4bWR6Jj/SQAnaQUfLSbMP0oJHpJYEMSUbRFQTW/D/QIo2fRc6n+i12CQsK2QPIHOwgu9SxdXpjxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajWyxvbw4GfrUYXQuiTxwaICb/JQNF1i9OuCXPBqGSQ=;
 b=egpkLSgp8ToB/foTdbLk8NIaHmfRVFd1C4zVW5AL/PnzdgioviDCM0i/v1NhhTmlfjSjIUZQ8kYUqUdheCmnURc/AbYvMli0NoVmURuKN/c0xU0KCo7EuMv4fiFP2IYyXbT4kr5XsT/7flhDn1iCameCxgMp7+OEgmXbDjhrxkToW2O6ZRJJjxi+mNApd/5IDUZt9VS1HPx4dia7OpDXmXIdTwgOtJWm/WAIw1ZYoNFbUe7KTvdtOrtU8LKv9RilRPKFQ82iLyXlZu/YyGQ8OZlgyKf9M35vWZiiFTCjdbkoJs7uzuET6hy4kPpLCr0IloHDCOWfJL8A6WP2Gj5JJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajWyxvbw4GfrUYXQuiTxwaICb/JQNF1i9OuCXPBqGSQ=;
 b=MR5kT0hbThbjJuVU/SxeCxnVBzltbEh347A57GYlv9CTqHw5iS3Sj66NTgwRwC2aTH58hmJcxp6eMK5Etku63F5K2B9+llVvkJFyICEledaLQu5u0pxDPXPddpCL3dLUbgYo5h+W6848ocGZIzORGPqDsdy/uQuWIlTkG47Z1Tk=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 16:23:04 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.7784.017; Tue, 30 Jul 2024
 16:23:04 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
Thread-Topic: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices
Thread-Index: AQHa3GkB3lCZGLh63EuMgAg+3zjfXrIPf6eA
Date: Tue, 30 Jul 2024 16:23:04 +0000
Message-ID: <CY8PR12MB709977C1CC4F113D9D7FC7F78CB02@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240722185712.1046232-1-Jonathan.Kim@amd.com>
In-Reply-To: <20240722185712.1046232-1-Jonathan.Kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c69cead4-2889-4a50-bdac-dc6eaf179407;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-30T16:19:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CY5PR12MB6179:EE_
x-ms-office365-filtering-correlation-id: 33d84041-75fa-481f-76c5-08dcb0b3e38d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?k63M5+HuciFLCngDRAHgF7c8OP26M6zBOIXiWmx9TsoV0Jg8WrdJiIpRqcB5?=
 =?us-ascii?Q?3W6wSyL2lrdBvJweQ6XHLvpd9byJ5QNE8Vi9izjJnrfHQZbLdnGG6WdgWtfR?=
 =?us-ascii?Q?a6jLR+NiTfV/EROmJxb4vABJqaY/A8ODgCyGkQThSolb+zfkDetjTdoOD/te?=
 =?us-ascii?Q?OrKGdXQkqJM5bHieioe+5qIt1SB85PdcZBjkwPnGs1FLTeF+8FRDdN68vT1i?=
 =?us-ascii?Q?ScddGMsiZ8Zgt0YPJS3s3GBttBwvOyRfqVn+U30haI/c//8hnwdVoyLYVnhl?=
 =?us-ascii?Q?I27QreYgaKt7rxi8IS+PrO6EEjrUXhCIWhjABnOxnFjWa0hfmU98ProZVsHU?=
 =?us-ascii?Q?JC35BkYCoZuuAtqo4I2/3b8FzEzFNxGTCK46r7eQYhvJ4qQBysGq5YDEM5k3?=
 =?us-ascii?Q?lYeM3T7WhXtmbxgEPGFE2HBOsPK0JRITszmn7EntEVSvS38R0+FzJNgG58nW?=
 =?us-ascii?Q?d9063GrKa7ae161cPgLvqnu1skYcQWQkRVTZEu/m4P9wA5wQNQgd+9RzR955?=
 =?us-ascii?Q?48AJFtd2TyzWXsVIczDofcx1CY8BWd33oC+mcorqMEHc+HPaQ7iIfzQYkijn?=
 =?us-ascii?Q?xjnA8J/qgnpOdTrZpLGCZ0iZtJzJKarNuX7mdJfMQAV6Kr/DpwEeP0/Grc2e?=
 =?us-ascii?Q?2BHK0hjHxYqzSEM/77P5NKXZ7/DENYicXiYNK879Gl9oMA9SareG267UdKhb?=
 =?us-ascii?Q?n1pjTQyxxlA/Mw3xLx66425m5D1z0aWTw2IqC2fTw5lnNfa/uHpZj0Dfhr5I?=
 =?us-ascii?Q?EqRlcZmvdZz8kPbrG95eMvyu/5nToCaXZNJyjaL7Pz+YOe27OyalAwYKvyQ2?=
 =?us-ascii?Q?Kg+pR7UDdzoJbPV9fva3mDqA1BVogaOZGy4gN5z2K5sTy0wOVCbGf0S68BME?=
 =?us-ascii?Q?ZUFLxk9ZVIgGtCdDKyBm0cUYQRfsysqQ6NaNlC5QnCfJWyJKUWb+zOG7z56V?=
 =?us-ascii?Q?tX8bzqDnvgZGj36NFVL4U4390HHOFxoxWXaAb7wUtzFIwd0pQo+iSjjK/JNg?=
 =?us-ascii?Q?tmJodhFTDVbl8XkU6fQN2jYdj+4OPlGDz4YEHteJLkkD6j7di4zX1t00UQLq?=
 =?us-ascii?Q?vZ0ouTCDAxlnFjhGUEtq334bwu5vKCHQZzDBb5s2/eIORDapheiTL776G8O4?=
 =?us-ascii?Q?i/IwUdUzmGl+tjt1X6MeiSi4lrxW5eru/qLWuBoaMqtz/wn/QTeXUOY/jKWb?=
 =?us-ascii?Q?4XfO7dJ1FNpz4jnWeJIAWFJV44K6443YK2N52Kx8DHET64ZROV4m+ii3E0Bp?=
 =?us-ascii?Q?Q3sveV5JwBzPocChawtRoMXrNlLQmOqmmyaeIj+5P4TEdvELV1CAOns1C/TV?=
 =?us-ascii?Q?8qgHq3KvomqjiJT8EnzD8zDWAzxUiPXLV63cznc4dAh9UhI1SLu2PU1S7bKi?=
 =?us-ascii?Q?Zt89Y/1UUpRrXfsI4VySX5PpeXuH0G9qhTn63jXWs2shyhKpgw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EceOQF4SvvixSBYx60V1apz7t2xA9G/4NFcPXDFztAU//WAWGljJQb1vi61V?=
 =?us-ascii?Q?4EXYueP1tVdcHCutOFM79LuW7xoxcewOk77wKLLwbVJ5udRYbqwMGgN0nlBv?=
 =?us-ascii?Q?qEUKimS639A0/yZTVGQEBK1vQPq9YsJknjrPVsESPlhiJkNk6ASwWcrMug3q?=
 =?us-ascii?Q?4eD17rGJUvrIuh7XFUrM2DhMuOxBCE38zM48SFhjbp8u7o9BWqGfrt8mRclx?=
 =?us-ascii?Q?Q4tRsUgvXluRP2qm1ZOxXNCVaA7I6XdPnothmTpyO45Twr7XSoei1OD+OgGS?=
 =?us-ascii?Q?zn0K++aI5GW64qhBeJxCm6pHLQonK5PnI93zPaHApxksFxeDlTd80sxgJLzQ?=
 =?us-ascii?Q?LhYhLTjQlhxe/NaG/jF7FFRrUShFb4LwFV1TsEds7eMSZTSgEkvqyvan7vcg?=
 =?us-ascii?Q?tKfGepVdJhKBGyYPfR74HXptCNflYR0UA4IU51STySAPjFZcor90O+6D0fAI?=
 =?us-ascii?Q?3C6nb9T4S+cDyJXdhLin+95/yWYriVXQ725zuqLz4bE6vzvwr/as8eBAmIOf?=
 =?us-ascii?Q?S+JApvBHgc5TdCUAEHP2cBitUu0d992oTtXweiPeEnpcc+pLFB45gATwI4LY?=
 =?us-ascii?Q?MROMlFVOQq5su380BIcKy0tnX+tgg9/lkOfZoFDHl1iFG3OwP+Boaa970RJ2?=
 =?us-ascii?Q?u6Srr7X4OAL3Rs87zhCeapoPJW5ASwLzRAJ9i927n92NDODG6QzJgKwyJ7GJ?=
 =?us-ascii?Q?qyUGnbZpjWbwx4MZybV6tTVLae+MRwat/PM73TFi2Or5P0XAt4cvQvVlKdzD?=
 =?us-ascii?Q?ZZyJ8/ZeRQBrG1POI9yLEdXuOoh5zW8NgFkgCMX8xKhTGhZrYgUnCAEMCSnl?=
 =?us-ascii?Q?PGy5gQ5EjwIr25ECNva6Wk3OkBb07nEwNPXyJWpM9PIBJ2qSCbF1loVaoFgF?=
 =?us-ascii?Q?Ez2liny5VAAUY5pSTUDYObwSJoZcnrwvcdu+moP/iCS5FhkuOMbICsreHOjR?=
 =?us-ascii?Q?ZC5HYDBT4QTkWGDMM3VF928WWJAweuDRHQtra23Oc1KZ5wd8AsCHFOSJgpXU?=
 =?us-ascii?Q?OCnq6qi7fmgIlo4QRVfx3BPBeQbl8cKPIoYOZ7EWL/fRS50GV0kzT+Ue3s6F?=
 =?us-ascii?Q?9qUjnPjYpJVovuhNASzzHKkklPadd22ewfzsvvdimOLMrW5Xr5PVu9s6BgEV?=
 =?us-ascii?Q?48Ll78nLLw+iaHIg+p7kzHnXVp54jHtHe7Nz5QNgJpdHupDbJLjGBEFEOsvp?=
 =?us-ascii?Q?eUuNDEU9GOBrA9P0fdsfPB1CDqr2YCqQejlTOnZkt0IOdepeJxuGjhrZ1nj8?=
 =?us-ascii?Q?Y7kRfqjUu/domtLii/TI0KjL5FyX/YLFGF3zng85OhuU0HZF0M3WwZQJ8a5u?=
 =?us-ascii?Q?sj24TLmRqyrHUfL3APqWhS+mcG23p0Z0wAoqqYQGQJezODGiiwT+oETn5frM?=
 =?us-ascii?Q?fiKsipGgWt4rsMbgR1CGOVgHTUnaxvT+QBzvwVXkamdTXdpJ9ALj1MTccKYM?=
 =?us-ascii?Q?b3lW3EPJMfj5R0wfVZfgh7NPUI0L3lrxPq6lAI/s2PdkFpDpxT71euf/Xuei?=
 =?us-ascii?Q?ViK5h8VP8sMp3HEaGxC0XwDDq2t2iMe010cSfI+wdnwItH2jf6WJ8Q/e6J0H?=
 =?us-ascii?Q?p953NnY6M81xwrJBk+o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d84041-75fa-481f-76c5-08dcb0b3e38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 16:23:04.2991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDW75u4sc65JnKFWoZuT6HeaJZj3vBHNnRpqYX97ibNr/0g6wnR5bMIe6LEh8qEfB3p08dTrxXHKJsfOZ7zUNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
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

One minor comment b. Either way Reviewed-by: Harish Kasiviswanathan <Harish=
.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jonathan=
 Kim
Sent: Monday, July 22, 2024 2:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.c=
om>
Subject: [PATCH] drm/amdkfd: fix debug watchpoints for logical devices

The number of watchpoints should be set and constrained per logical
partition device, not by the socket device.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c  | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_debug.c
index 34a282540c7e..312dfa84f29f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -365,47 +365,47 @@ static int kfd_dbg_get_dev_watch_id(struct kfd_proces=
s_device *pdd, int *watch_i

        *watch_id =3D KFD_DEBUGGER_INVALID_WATCH_POINT_ID;

-       spin_lock(&pdd->dev->kfd->watch_points_lock);
+       spin_lock(&pdd->dev->watch_points_lock);

        for (i =3D 0; i < MAX_WATCH_ADDRESSES; i++) {
                /* device watchpoint in use so skip */
-               if ((pdd->dev->kfd->alloc_watch_ids >> i) & 0x1)
+               if ((pdd->dev->alloc_watch_ids >> i) & 0x1)
                        continue;

                pdd->alloc_watch_ids |=3D 0x1 << i;
-               pdd->dev->kfd->alloc_watch_ids |=3D 0x1 << i;
+               pdd->dev->alloc_watch_ids |=3D 0x1 << i;
                *watch_id =3D i;
-               spin_unlock(&pdd->dev->kfd->watch_points_lock);
+               spin_unlock(&pdd->dev->watch_points_lock);
                return 0;
        }

-       spin_unlock(&pdd->dev->kfd->watch_points_lock);
+       spin_unlock(&pdd->dev->watch_points_lock);

        return -ENOMEM;
 }

 static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, int=
 watch_id)
 {
-       spin_lock(&pdd->dev->kfd->watch_points_lock);
+       spin_lock(&pdd->dev->watch_points_lock);

        /* process owns device watch point so safe to clear */
        if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
                pdd->alloc_watch_ids &=3D ~(0x1 << watch_id);
-               pdd->dev->kfd->alloc_watch_ids &=3D ~(0x1 << watch_id);
+               pdd->dev->alloc_watch_ids &=3D ~(0x1 << watch_id);
        }

-       spin_unlock(&pdd->dev->kfd->watch_points_lock);
+       spin_unlock(&pdd->dev->watch_points_lock);
 }

 static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int =
watch_id)
 {
        bool owns_watch_id =3D false;

-       spin_lock(&pdd->dev->kfd->watch_points_lock);
+       spin_lock(&pdd->dev->watch_points_lock);
        owns_watch_id =3D watch_id < MAX_WATCH_ADDRESSES &&
                        ((pdd->alloc_watch_ids >> watch_id) & 0x1);

-       spin_unlock(&pdd->dev->kfd->watch_points_lock);
+       spin_unlock(&pdd->dev->watch_points_lock);

        return owns_watch_id;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index f4d20adaa068..f91a9b6ce3fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -885,12 +885,12 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
                        goto node_init_error;
                }

Wouldn't it better to initialize node->watch_points_lock here.
spin_lock_init(&node->watch_points_lock);

                kfd->nodes[i] =3D node;
+
+               spin_lock_init(&kfd->nodes[i]->watch_points_lock);
        }

        svm_range_set_max_pages(kfd->adev);

-       spin_lock_init(&kfd->watch_points_lock);
-
        kfd->init_complete =3D true;
        dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendo=
r,
                 kfd->adev->pdev->device);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 2b3ec92981e8..653e1f934107 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -310,6 +310,10 @@ struct kfd_node {
        struct kfd_local_mem_info local_mem_info;

        struct kfd_dev *kfd;
+
+       /* Track per device allocated watch points */
+       uint32_t alloc_watch_ids;
+       spinlock_t watch_points_lock;
 };

 struct kfd_dev {
@@ -362,10 +366,6 @@ struct kfd_dev {
        struct kfd_node *nodes[MAX_KFD_NODES];
        unsigned int num_nodes;

-       /* Track per device allocated watch points */
-       uint32_t alloc_watch_ids;
-       spinlock_t watch_points_lock;
-
        /* Kernel doorbells for KFD device */
        struct amdgpu_bo *doorbells;

--
2.34.1

