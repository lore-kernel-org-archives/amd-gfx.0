Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B3EC369B4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 14:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A829610E158;
	Mon, 14 Apr 2025 14:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="111+4qqD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2168410E5F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 14:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWyVFd1xGQZV77WxpkkssEJ4zL7JVsRxE35ndX78ACuLIxjIe+DMx/Pi8rb+nw7EaKfZkQj4o4vqJSlc782VZ7sNY7EgxPcdbOs5HD/axc/bfM9ESVtDlXUUJEHf5BCBBm5yTyPm8WHyP7YyhNk6xtJswl+AgYWHWKTPPZk16t0hqoX/rwtopyCBizwWZ4OHa1vbEdPb0oHdySCIfcjaUBeHPVl3HLQvZ6PkMy8dutLNJUlHenkxZTcipmC5GGBB01F9C+ZaXiFGSyw9nXclpFFFV3Zj3yBNOAj2r7WcjTIca2+Dt5XmP7TM0FBko+LLA79GHCW1v0YwOWM28YzIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL8P74jt7hTV85cvxtH/U4h/9oygBd0uG6JOq7FHW2Y=;
 b=Ate2ZfZpbbG8j7ywr37uACFf/aPuXGnWjd5he63Y8jTwCYzCaq0N96M5CSvtm782OI8/8Itfve0lfgqvCoX0O0LHpkPRanFqAfBFuouJ7r+xHQyBU3sH0hOxEBmLRIbtb/ujpAQ2ghSnftmefRMGpzTy1PXZU9oKZOuoy4YjUiQpLfRhN46lp5y30rirzdPm1uYCNylJ/5eR0NcTETivf3s/+qXmkEhS16NPFtGvEG8n4bImFW93NI1SrnizkEHr35S1i5iqDPiisOsFeTgRgmzKY9dtkSofiom7T7YSGAQ4oHF3LWveL6EfKZTmgk+oRw4P0k+/Qx3Ms1Ge7r9sCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL8P74jt7hTV85cvxtH/U4h/9oygBd0uG6JOq7FHW2Y=;
 b=111+4qqDP4EHTdWAfAdsg824EIMfkm7ZWg8lgEvf3Lnz0KQoG/zEOPPJkn5+iZrNBtujNtUV9ojdpo9+2WXPirq1B8Ls4xBpMrdHtCa6cL9hYnpRRrfJVl296yGK97Ho8C8WoxtCjNOZGzJdVBQ3139vdcMFxpksG2uLpqpdKE0=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 14:36:17 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 14:36:16 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: move runpm handling into core userq code
Thread-Topic: [PATCH] drm/amdgpu/userq: move runpm handling into core userq
 code
Thread-Index: AQHbrKFX9394zJ2q10CqSdlg7y0UxrOjO1jw
Date: Mon, 14 Apr 2025 14:36:16 +0000
Message-ID: <CH0PR12MB5372E19E0FEE0BF389CE843FF4B32@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250413182415.2712146-1-alexander.deucher@amd.com>
In-Reply-To: <20250413182415.2712146-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=74479cb6-3e07-4c19-b11d-b277a73626cb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-14T14:34:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS7PR12MB8203:EE_
x-ms-office365-filtering-correlation-id: cd6daab0-1c98-4d22-def6-08dd7b61b6cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7Hd+f9DVoOzoT0MTBA/UE+f6+6lL9hoUL58u6N9Y66lMb3b7mVvXmwqKjh3y?=
 =?us-ascii?Q?VVeBx2H1yHoOk//l02oTK8h7g2CcjmQp4T9/1E4ksaWGmL5qjxnyKrc1TApw?=
 =?us-ascii?Q?CTfiN3h0LhcYplAH9Ib2tju0IBFeDVdc3oJzDwwS7SF6dJdEwlJZikTPE/PU?=
 =?us-ascii?Q?I6Yr06Kf81N2bPPss1l2rz0HCeNNMU+5qsYYtANG4cDz1NPCrSVoZ2qDtKf5?=
 =?us-ascii?Q?8SIs3rhLPY4lvGYLysRlVqmJYd6VVqXFhpHY87d//gtx7m2zahbBM9GYvQhX?=
 =?us-ascii?Q?yyFgrfaWJlYKI8w3j0+KHbHfUcbM+HTdQHG2/cfyVIgq2pRqUUQS2PPeagzh?=
 =?us-ascii?Q?ikayLXj1wLivpHc2ooWbbzARuB86zKXvj8mBS0IECHvF77l27Msq+fLYZXld?=
 =?us-ascii?Q?14gJeULW41KlQeeoEeCjmudvOuzm0DqUhDuH9aDdx3wTIfFvT9k40S6iKrPy?=
 =?us-ascii?Q?nfpdgioS4Rm6m6gVyvQaK+T/LIQdrO4I+YifGUzF5X8PIg+DYzluQzsnWo0w?=
 =?us-ascii?Q?YQteV835Yf8J1uraucKHEQVWKUH/qmBf9Zym5ZFN7WnK1qUGU2l8R78GRU/W?=
 =?us-ascii?Q?vAJvNjcaWrCwguRUycdu+s7rfWPmYzS8/xOOPg/gfmmql5tn0WJzflze46A6?=
 =?us-ascii?Q?wZQg+44N4i1tZuyaQnx5Zw2HAOEW+5plRo8gbHZSMHuPdIiYFNNWSJl+lsUA?=
 =?us-ascii?Q?eela3wsFXemnkEhvZLixF4Jbh5kQHA7un0mPeEpmWKFzGCaMkNnhkj1omc4o?=
 =?us-ascii?Q?+SKxnX1ZtwbItTDJeVOhqLn+4voNsM6Z89pTu8f9btHNIFxd/SCP5OAcG/jY?=
 =?us-ascii?Q?U/RF2S0SwDyEDnuWJ8uIBjpurHvh41m7cpCKGMhRUfNTbeCShdvOxwl5RDhq?=
 =?us-ascii?Q?DErQrvTfc3quyN/rJbqPl7n+i/c+HF9wLDM1QEoHshsKmytNVbXTQTJoyFKt?=
 =?us-ascii?Q?IkeamMOu8Mzep5PYAVerXpfZgVBsD2Bo2T5IUQ7ywbKbHPRrWvEM7/+MnwC9?=
 =?us-ascii?Q?bVvR7usmv9RLHVLFCA87F+g/eWWHJrodQJajSJXeWfMHbKgkgSK6WEeHHi/I?=
 =?us-ascii?Q?QHi4LzJqrMOPmO9ouZ7DdVrRxdmbzBUTK0ibP/DFoAaY5g9X4ghJVBmOw6IB?=
 =?us-ascii?Q?mL5COEWHsb56Qw8/AWXDKHKNxeA6NuLHjivLbf+IgrPzwLiBnCDEdnS/o/qs?=
 =?us-ascii?Q?K0R5uTlRyUW405nqvONPkx2umbwwWM2j9USasRSPAPAEGZh8UBmW0VoY4ZLv?=
 =?us-ascii?Q?daZ09poohd6sYW190bl2d9Mt3LWh1TJaQ7K63w1BL9+WWsPTePwFIJRNeAii?=
 =?us-ascii?Q?KYTiw+EPnUOlvhXmNCm8jN24MJyg1/ZuS1clWc76Gbh6PmwcxDKgVzdkYEMe?=
 =?us-ascii?Q?scQkpnyv8xTdwTxssKrNI4S1U1jgm3ejClNxps36nf2Mpg37rayPbfojYQ3M?=
 =?us-ascii?Q?Vm0EVPHy9i6sYVsTrpZ0NHDxgAG8CaMLQK8eo88X6Y/XpB0uFu3RpyiUZsdO?=
 =?us-ascii?Q?Dl6fZ4Hz+v057nc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RVEdltvMhgxyrIAuqQHK9PaGO4rl4lObhPKDlLa/uKm024Z++NLGQYiQD05p?=
 =?us-ascii?Q?2pVoz4l+MwgVCpWSl++MmvIYLdkJ5cRd8SDH1ct9NQwn2pj3yC0ywgdj06op?=
 =?us-ascii?Q?8dzkep0NDn7hBxtSWDHHNaUL0b9g3qKc8JmEPzFbE1M8WssO5ZBYk2203m1a?=
 =?us-ascii?Q?7Vv9RnAauBq0XxeF7pQPLSf+DBr9gbEzI40Uo4z/PnmeAgT/5gTgzqz3Z7Dp?=
 =?us-ascii?Q?89NkgBhiSZaQ6YPuycdji6OkmETdqniOZx0uSoR0DYw2OdE4G96A1GAzXTsL?=
 =?us-ascii?Q?o/f/xw/1OxmQ7v1fKWSPA2H/1sQ/t8n94hfKkE4b3cJUpCt3ZbkIaXCmcpxU?=
 =?us-ascii?Q?KGgT8LFqdja1v5EhMhO5bMM1S0sb95QC83BI0WJFWzUQNrP0u1IgkI/IEeGQ?=
 =?us-ascii?Q?Lpf06U34o/3I6U3vYOah940nNpfr6sLbCvqknAndpW0FUQQuhJswCIi7a45s?=
 =?us-ascii?Q?yo5yDJyMabhsekmbBIK/MfcD0r7ItKSKuW/TIZFEkqQr8q7XCLXe8WNUasrI?=
 =?us-ascii?Q?k6iWpKuORQ28wE8dHKMJEQ7jQyYhncmoCsqQ4HNPTTJ46ldVaeA8+LHn1XUE?=
 =?us-ascii?Q?+0wX2sazt302Yt7KAISEojNWuE4hNQ7+k3f/2+0hLs2zZ6VvBvKbcO5A/3V/?=
 =?us-ascii?Q?VtffOXDZvTUoTQ6ADT4d+8hbLKlK/XXxAuOAH1ApAlIxsfea3yfCvI/7vbxi?=
 =?us-ascii?Q?sue0IHSNJCgM5aMpaSpPbhUTwFCZHZrxsBEw8Ap+zlXKWvfsjoSQJ4L8yUSE?=
 =?us-ascii?Q?CNq0a3tQccyKl589ctYsDNA3HNGf7hOEBE4OaliNOQRyGfkX5/PFT1YYDndA?=
 =?us-ascii?Q?CxT/sKPxs3cNyh1TuiKMFzhBcL/LLjL+S0lWCHzyqVqgZk4a76KWmMGbrutw?=
 =?us-ascii?Q?/ySTShuo7PYbN3E1OT/x4HTPayYImZ45aOCci+OB1zn96HVVE+OoXUt3Fv9j?=
 =?us-ascii?Q?Ha+a0TFSRT9nD2jaAYS7YRFXTkC/rZitCnVU1wz1UqpSPheJFqb35b5r3Cix?=
 =?us-ascii?Q?Q9tbYviVOxRog+iSP2gX/AVjj6Osvqc4CaA/kAh1evIjDiom7lYJLkQb064C?=
 =?us-ascii?Q?lwrlV9OioWHnLoMrQzKAOqWJJUSFrprhrIoLf49VAUhMOqSXYrYEaOz8DaJj?=
 =?us-ascii?Q?WjD03k0l/vPavJIT6Bn3N4HkmxcZI5JukvHrUES+eERXbJBipUmol9gDS6YK?=
 =?us-ascii?Q?7MaHG8ikM9aksnrOWdw/pRsxPN+099TvpO7BxLzNcw1tJulYWnUnnIhErZN2?=
 =?us-ascii?Q?EGuUoorS1fBpeWX8gw5HNyTWCRuauM7PV+L1kmJNc2JaGveTX3xjQlNPpJIE?=
 =?us-ascii?Q?TPuYhUZUy/X4SMZOe/C/lj7MNz2erD8EnrDDBKUDNhKklyjPE6OTJ+nrc/5B?=
 =?us-ascii?Q?o9pNjZ9U5oAif0zb+zj823q5ZLySbucgX72AKo83H4SJ5OZXkufPvDcZTb6j?=
 =?us-ascii?Q?ejQ7ci00alMkG289UDdMsT2t1cg7v0ghMYMOEmbZrTQauaiJIgDuQi7CjlIk?=
 =?us-ascii?Q?f2CqWwH4VfQGa7q4uQmvT/9PfSxNNozUVyVdlpeCaah1CMUsAOEVjkIoO8tY?=
 =?us-ascii?Q?2PBR/aFf01N9j/U1RH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6daab0-1c98-4d22-def6-08dd7b61b6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 14:36:16.5034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLrpfrOVwD6oMoEsLWFYB17r81uqpGHEmN9SY6j+mzmjsuI+D+dIznDmze5grXEblpqM6xzpgBMpq+fu5+Dmkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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

Looks good to me .
Reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Sunday, April 13, 2025 2:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq: move runpm handling into core userq code

Pull it out of the MES code and into the generic code.
It's not MES specific and needs to be applied to all user queues regardless=
 of the backend.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 15 ---------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userqueue.c
index 98e1ed794c346..08a94822eb17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -24,6 +24,8 @@

 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
+#include <linux/pm_runtime.h>
+
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
@@ -258,6 +260,10 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int qu=
eue_id)
        amdgpu_bo_unref(&queue->db_obj.obj);
        amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
        mutex_unlock(&uq_mgr->userq_mutex);
+
+       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
        return r;
 }

@@ -311,6 +317,13 @@ amdgpu_userqueue_create(struct drm_file *filp, union d=
rm_amdgpu_userq *args)
                return -EINVAL;
        }

+       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
+       if (r < 0) {
+               dev_err(adev->dev, "pm_runtime_get_sync() failed for userqu=
eue mqd create\n");
+               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+               return r;
+       }
+
        /*
         * There could be a situation that we are creating a new queue whil=
e
         * the other queues under this UQ_mgr are suspended. So if there is=
 any diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/mes_userqueue.c
index e175f05bba6a9..b3157df8ae107 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -25,7 +25,6 @@
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
-#include <linux/pm_runtime.h>

 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE  #define AMDGPU_USERQ_GANG_CTX_=
SZ PAGE_SIZE @@ -313,12 +312,6 @@ static int mes_userq_mqd_create(struct am=
dgpu_userq_mgr *uq_mgr,

        queue->userq_prop =3D userq_props;

-       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
-       if (r < 0) {
-               dev_err(adev->dev, "pm_runtime_get_sync() failed for userqu=
eue mqd create\n");
-               goto deference_pm;
-       }
-
        r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, us=
erq_props);
        if (r) {
                DRM_ERROR("Failed to initialize MQD for userqueue\n"); @@ -=
346,9 +339,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq=
_mgr,

 free_mqd:
        amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-deference_pm:
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

 free_props:
        kfree(userq_props);
@@ -360,14 +350,9 @@ static void
 mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
                      struct amdgpu_usermode_queue *queue)  {
-       struct amdgpu_device *adev =3D uq_mgr->adev;
-
        amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
        kfree(queue->userq_prop);
        amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
-
-       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }

 const struct amdgpu_userq_funcs userq_mes_funcs =3D {
--
2.49.0

