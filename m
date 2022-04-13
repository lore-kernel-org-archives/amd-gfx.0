Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1238CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 06:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDBF112274;
	Wed, 13 Apr 2022 06:22:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D07112274
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 06:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSspD41gfVf4sjGRhILPfYHtyiZWBv1pKYgctRtahALqrMaxggbeyxR1Mw1Xh5vB1At6xdKkZzrpu7QWD8aLnqa9nJDMGACYrnBD7LMErIun8kU4UsP2ANlRRzcnrYuAnMCpwx5oVC73ISIZrjmhaYrhq60pr8xEzj+FIUftFQ7WcFQV1gclK7/PsiveswQF2migfhnQwTspCCKW5o5tHLxYTbAwVq8fK7ZgNKSa5QvIKZ07io2RvJVwbXNnJKY5Jt5W+/MBz7AKNmRxa+0uO6kFJxqkGBMQVrp7uyTTaf9sp4DX509wWnMQfvbPNCj2uQglpbjBYw6wSKL0fv+mnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF8DgyM+KOiKoVY2TlsEEvfSPj3M9a4VN+q1ilFe2iQ=;
 b=VFQ7MGRw4PWPIHdouqYJvsHjYxz/e9wReRmXoOTqiPdEV8yildGXZUOBp5and5cnHWrF4bquVZAtkOQ7Zw0G+yON6O0JYmrvg0MP81VoPSPwEhuKOzNueRxM2yisAPEB19n6I4PAhfOq4T0CT4Ypuw6HW6tb6doUqikpRA85seoq2bF/2GDKssxZHyrLHJrxWOtWigk0ZOY+fknWJ/j/L8UeMX+7s+GglFh3PGWGy0HBlG0TbvMt17lJhsKHrL91zbelNdGK69Pm1KdknYY/RQLMtsCBWSuK/NaJ56LtfV78xLb4fUYsLYSTJF2wlCNrqbZFehXH8Mr6izMb3pqaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF8DgyM+KOiKoVY2TlsEEvfSPj3M9a4VN+q1ilFe2iQ=;
 b=opthZijX27W0s9Etig3yJ+dY/16PZ8DRdbwQTrlJhFFoKXRVufACTcbrrImqfST+NbeJ5yTdITuMkLa2nnndubSlP8EEZCA3v3/EwoYKbON2G7fUEV+cyqC9dZgfVYa5HVuVypZRLmASTgMFvF/xMa5LFyHJNtiUYeRV/euuc6s=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Wed, 13 Apr 2022 06:22:20 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3dd1:2c28:cce6:da08]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3dd1:2c28:cce6:da08%5]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 06:22:20 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
Thread-Topic: [PATCH] drm/amdgpu: Make sure ttm delayed work finished
Thread-Index: AQHYTuPbKbdvJmtloEyPwaz15WT/n6ztXyHA
Date: Wed, 13 Apr 2022 06:22:20 +0000
Message-ID: <DM5PR12MB2469F24559D151CE79CDAE48F1EC9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220413030854.31724-1-xinhui.pan@amd.com>
In-Reply-To: <20220413030854.31724-1-xinhui.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c894f7df-bf31-42be-dd58-08da1d15f71a
x-ms-traffictypediagnostic: DM6PR12MB2796:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2796F722875B9DD5D9069E8AF1EC9@DM6PR12MB2796.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7touAokk7CPodMR2hDpj1j+lJcDl2yphyAe65Tiv/C1XooMtGE7xXyA0bLkA7j8UYaZTXEFSXNn+8ZITEEjcmLoKrw4rQjZnmidlFrREkrSB/69StEGnqX9Iqyt4MLR4dUb3CzttdTGAbq3MgNAAcCamREP79czGL4g3FOhx5zpXG7+F+ad+4JjhNdNs/gl3A8za9RacLckkXXLpmAoU8yOqtsE7Wk1kUcD6Vczkup1Bxu6KbcqUuXwX5QF8hdOoVdcMu5PiJQIXigKqPCatIFpXQ1tHrUy3yu/k62f9FDx6m8G5VOu7JGYjgdFM2xWlGO9/z2vVDYduZikXYB6VOrJxqcYXhX50637xtSXPjDcBza6xmTjhF44j/qvaR5YlzDV0s/nalEAkMuCPQtGKFfnd0T8KV3gUcA2WEGzH/cJhr+FBLc/e/QPyd2fYBvWrMt7/it6ZMzzHCKkA9G6FveCEV+yEFLvReXt0iVhgQ7LmIFaPSmRnQg2ipjGL1Dy6vMFNfz5hVCY+PUEzqCfkckcV3zKqigFxJIrLO7n+TN28IO/sXI6gZIcdWi7ldhADiXtN1EBsd2smdNCd8GFPyFozjKh+iW1g3XyN9GnnF6GfufLnfwuGHrINj2JPDzwI/IxT8tSjzkmaCWcgMua29tJYfBcVCjCbgwSfACXDf3jQ4sNx85jOw7XIboCd8aXtps7n2eRQOqVhWQGMKFPxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(7696005)(83380400001)(54906003)(71200400001)(76116006)(186003)(33656002)(52536014)(508600001)(86362001)(55016003)(38100700002)(2906002)(26005)(122000001)(8936002)(9686003)(316002)(53546011)(5660300002)(38070700005)(6506007)(4326008)(66946007)(8676002)(66556008)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uQg45+LKuUCxBqm88b4NaWGE5VUSED82tE3iz+QZy80fgoopMEq9LsA+q5I0?=
 =?us-ascii?Q?JhCVan9sEI93MqoLqxixAtuzc8qChM8WqOTMhAjYBwxAewI4g/wGN2NhZw28?=
 =?us-ascii?Q?wK2B3XQYHl/fHqG94/idcEXQPkofZCUOkrvUy6qY3govKOXGvd0ttGvtUA55?=
 =?us-ascii?Q?4gRmDwdiTZviqJUFl3rAbBpCxvi/kSMsFLIH/A7M+PVLEvuGaFRospdve5/I?=
 =?us-ascii?Q?Hiyvl/eH/Iy3WbzARNRM89jcNWK63s6sOOTHI4KkLDgOsfy0p4TXS0zdHQ/4?=
 =?us-ascii?Q?ssM5NseJ2VyuuBLCJz3PkypIaoO04aPRX8wJ/rsj9GEzRovY37uEnq7O0YEp?=
 =?us-ascii?Q?Vc+UGZYY4uyZkUPHa/f3jsw7PHqR05fwMTAy8xzPtbFXjIy/64KGMdYogVQk?=
 =?us-ascii?Q?4ZM/3RGO5VRgCMuQj/kBYgRRFLVk6USjpukZdP9FIaBXa0xaUCc5JVzoRNy+?=
 =?us-ascii?Q?+/Xs41Cl9HUXuPJk7WsgWIXwaTBBS8b7I9f5oHjaiL5BSUMCFTVOWBDJr+6Q?=
 =?us-ascii?Q?3Tl0CLQ7gSuN1eMxJ0MQBnUsbztVRdITI2RRtuNrvWY4dXqlgB5fXhuMREhd?=
 =?us-ascii?Q?qYfmHbimJA6W9nYzaPY14RqkZZ+GIkzuY9zI8FYAkOPn3p2TXjhb7kbxZOEy?=
 =?us-ascii?Q?PQvIwrSa97TqP42OQ2NWyy6fvPK56xJ7ralRMDpG8sudGhUHIQx5zT3LOt8U?=
 =?us-ascii?Q?TqIcMXyGxlhO6nGbXUc2/WOPZuA2XX62DTDerk4g+QUDiu3qaF2ExxHGbpst?=
 =?us-ascii?Q?+o5yCddKLRZoB11Vgy/5rAgqopI2ZxwewcAE271Egi6BSsAOC8X86SIiuXRJ?=
 =?us-ascii?Q?UCLhIZSGIYGt5psK8uPyHzh4hLZtUPSn079kDdlBqmzRqBopG7bMWaN4gI29?=
 =?us-ascii?Q?p87hI1XAjW9mo/CwiTt+gPx4eE7th4HTXIyD2KQPQH73briYf3gkjsHAgBBk?=
 =?us-ascii?Q?Wy+AJe8gCD/IiMPedvaxbr6T1OGbf3gpnG9aUqCDmW8ISPh4K4JNXINTRlxP?=
 =?us-ascii?Q?1dg8VBQuHej7+EicGAMuIc1UDbap6vkoeKC81mwzISp+3iyxUQqIE4F+SnUg?=
 =?us-ascii?Q?EYPcb28w0T8u5BYQlD3NdAb/FWzk6hGWd05Dcw8+MN/Mmt+3UzLeAZtmNi1H?=
 =?us-ascii?Q?GexuMr8o7hluIemcrW5nvesRT+lmGQygXn+2MB9vgdqQfbomx5BQAhFhKVHv?=
 =?us-ascii?Q?+ovE2zpLJlzjU5WHxhAPOZZnPExbaeLvqCqnRGzPAi6y9Ihl8eKqbaIQXvOc?=
 =?us-ascii?Q?WF5w2RfXnAt712QFxOgYziHgQ/T14Fm3unxJNkzeOUKGSsrCBgx5ZqOX5shR?=
 =?us-ascii?Q?uC2nIe/wSNfUutfcPOb/zKAu5wwtabgvKcAWVHutDr7ZRUyS5wAFrQe6C1OL?=
 =?us-ascii?Q?ycR/mI5ik8JnCTz4rVumzt96kQMmNwyYVNQ7pzizk5X13MG0nImDbyH8/Yop?=
 =?us-ascii?Q?LcqomQA377TwTXaDEbKvw+pk0vYDUuAQqg0UlOGNH+TzCR7iztvaKLJp1aDZ?=
 =?us-ascii?Q?wRHxQDcNA8lyP1flfdX08aAe/MsrbKzjh8jvEJf711/P7DyOcFZZEpqEY1j7?=
 =?us-ascii?Q?/KtxHQ0olzxHY8kFWByGo6kyz0Zho6o3o6vNoyPDgS7GlBUiGQNlTvJKOAOH?=
 =?us-ascii?Q?/aCbv8nwRpvyX7Ydm87ENT8C7evk12LvKAQ3ZyuKnlxEQfFyjNAiN7UzB1H5?=
 =?us-ascii?Q?O9+x1NPw5lZNn+GO43aFfvEtvhH5qBisT1DYCF2Ek0zgh301V9ypohrKhJOc?=
 =?us-ascii?Q?kzFVu0/feA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c894f7df-bf31-42be-dd58-08da1d15f71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 06:22:20.2192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxW0Oks54CDtnlrTuvf8LCXeWUadnEKLGefnWsNG85o+oveFUr859K0TX/YXvovnqUqlsjkZG+FVWseJ/wOg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Shi,
 Leslie" <Yuliang.Shi@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+			msleep((HZ / 100) < 1) ? 1 : HZ / 100);

a "(" is missed. With it fixed, this patch is:
Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of xinhui p=
an
Sent: Wednesday, April 13, 2022 11:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui <Xinhui.Pan=
@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Make sure ttm delayed work finished

ttm_device_delayed_workqueue would reschedule itself if there is pending BO=
 to be destroyed. So just one flush + cancel_sync is not enough. We still s=
ee lru_list not empty warnging.

Fix it by waiting all BO to be destroyed.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6f47726f1765..e249923eb9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3957,11 +3957,17 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_=
device *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)  {
+	int pending =3D 1;
+
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
-	if (adev->mman.initialized) {
+	while (adev->mman.initialized && pending) {
 		flush_delayed_work(&adev->mman.bdev.wq);
-		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+		pending =3D ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+		if (pending) {
+			ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, true);
+			msleep((HZ / 100) < 1) ? 1 : HZ / 100);
+		}
 	}
 	adev->shutdown =3D true;
=20
--
2.25.1

