Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF38C001DB
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 07:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B559510E6AF;
	Fri,  4 Aug 2023 07:36:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C6A10E6AF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 07:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsEC0wmLitIwG5h10vm4QnbTMdlDFRMqR/egrJhwVvhSlpBtueFtxHYr7UDM5oysAI3f1fOZn0N/UquJjOojgKbXQEFbSljBvOxKcEuJngm6Ztr0lyXr4IIqxUoUIR/rQ/qr5qe0JbFfHcAwINnp6oXJ2haXe7bWyxOnRZg0VnGWHiSExtSgQTHMAved7QP/tig4Ol4qTP+hHwf6lH5nlExWnllYSFKvETrMciIY9D+PLVCbFzcOvcC8sBUAAiyBiTGUpN256OToWRtwIZwgYgH2iiikVLcaxE42x1FwezWAn9N+Io6JTq4ePY4QOmLBHCASeJ3mxenjTGyIJq/k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk69Ck/dVlaNMvK2Tm41EtrtL7KUjcr24QUDVmLiabw=;
 b=HEhzMkpEUFyzeTucZ7Hm3p1QwX9WBHZagKZO6IUjGsyFUyG43GopUm4iVmlXVYTsOD5QU887wBBVWI3XhSeUjG9FxyGIQliASIUDONPz/ykdUnK0SqC8e/YMAwELffuym1FlCUXM6adj2bcjXhAo4XyNdUiA3tTuHDVQQc5YuNc9NPPeip66B6Pt3KDY6tddlpCNLEGAdpRoPPriIGT9JglMMsq9vChKCSfZAl+kdtUf0UOuLBIsoE62Jk2tO44F2aXJ82B05ZFGvR8OGEzIRJkGm6kDQxp47BJ2DGzfworczA5/ADfDQNWihdrwONmyIPJEzM7TyccQ2M3CkWVh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk69Ck/dVlaNMvK2Tm41EtrtL7KUjcr24QUDVmLiabw=;
 b=Oob+bnCnI0deAaIC1wXe2pMn7yq9aUbs/OtFj647H5DWCQeTsWoq2wdA8jdL564YtFIDMUmBOoP+1DKXgtfxvlzKo2SqHQzre7Ob+LC5rzm/WzDWSfILpqH5jOJAD4pY+p5wUVtS6CapPK2dNNyxIb4C9QfMQD927KtOgyx3F2o=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 07:36:51 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::feec:ad93:34ec:8ca7]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::feec:ad93:34ec:8ca7%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 07:36:50 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: don't modify num_doorbells for mes"
Thread-Topic: [PATCH] Revert "drm/amdgpu: don't modify num_doorbells for mes"
Thread-Index: AQHZxpCwHrnf7T+FkE+l7hg8H9t4r6/ZvrPQ
Date: Fri, 4 Aug 2023 07:36:50 +0000
Message-ID: <MW4PR12MB56678065135849AD085610EFF209A@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20230804050032.2110016-1-yifan1.zhang@amd.com>
In-Reply-To: <20230804050032.2110016-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b9659070-34b3-4001-905a-a6d1a714c851;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-04T07:33:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|PH0PR12MB7957:EE_
x-ms-office365-filtering-correlation-id: 6005a362-ecdb-48ef-29a8-08db94bd911a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v1f+pvI8X4dua2ONJ4LZWOF76L3ByMa5NsPZrQKiPpmqQhQoorSlZkUjOeU41zIREOSd7s4MJGK/hl4qolgTu5RwAXsiRidOb0I2A6uqvXwrUlJ8vfdCEuVTSXO6Q/sIzcZ81swHMzvXpndFTFCAHDAwxNATVhu0SjZe4w3QLMUTxl/uGMUWtlkGpDSVbld5y2/m0ElBfJx4Ra071iWxaD1Uc7hbbeQ4bwpde+Qvfp3hcGy+o+i8a2CG16GYrOkDd/0UYMQyW++zNbkrV0FATeXgFFBq2fWg13J4e2FesSZBvkUyB1T6Xpcme7BnlXda8yzWDtdIOrwiLjpA9Pv5aqTEg1YhvuBIANL1dAPgDtwsenjvsonJCMHoItd1qGJzaAd2bOiqUKBqFTIbzToSIFq7joric5l7qb49ADgbV0+XN1hPpFsSI96mmQWJGi6hPi22dxLftEylvhwe4FYXHpzUmMnLdj2KErbuCMNJGK8bV/Sm8Fnk2kKkFNjlcbAYCDcyLrn1n0pHaHxpNHDwrEdjVjKcm/HmXOjGfbVkIIosWpsh2oNxmnG00gj2ahPphHosbZqP9zeAEucRTtQMnyoMVZrBoDt1GTpSco9v52k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(186006)(1800799003)(83380400001)(122000001)(2906002)(33656002)(8936002)(26005)(6506007)(53546011)(38100700002)(71200400001)(52536014)(7696005)(8676002)(5660300002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(55016003)(316002)(41300700001)(4326008)(478600001)(86362001)(54906003)(110136005)(38070700005)(966005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6xAoJE5DLMvZ57chMtZ+n9MikBJBT4VEWcGo+sFFPacxjy6nTghN1+xZQzx1?=
 =?us-ascii?Q?1bXJqlbjney5i5o1N349l/o259md23bO7KINdmsNnn+HofKSN7nFs+ki9105?=
 =?us-ascii?Q?Dlj/wkmzIwjLryPgvwomrj560G0fr045WtbtSJrAaI/onauJMMpgZl3cW9gL?=
 =?us-ascii?Q?8z9APti3QxKGVw3BWGiwY6FSHoSYtmxGF+f8qtcaWvLDy64ftUFM56BxDz9V?=
 =?us-ascii?Q?MqegUHcaVcPGr6BhLSgqd1YPDFuxHxXfCtvTtyMJQ0d0AyXmW4Iqoc9toepW?=
 =?us-ascii?Q?9WLtMCWCjPzxQKeS9APd+bozHJt/B6qgVbl/vLJzi11/XhPH4jtiTMWxNUsl?=
 =?us-ascii?Q?gOfy0osnfgT+cqtBtyv+uh9sZ439t+S3LynnXIQ1fJzF+f4diaB0hgsRm+6y?=
 =?us-ascii?Q?0VafScFBB1L581Y+rVHf3CeyJRhRTK9Hn/IfB4iPTrpCmW8mDbgg7a4BscGQ?=
 =?us-ascii?Q?qUwZ4FyiUTA4ENtA2W6jLvPhS9EcK1vKMmXZWVJlyGNoPanEuQt8AAwppKtf?=
 =?us-ascii?Q?6eRlQk4SGFxFambNaerbq+VGm205ZCFQoGCbq0Vb8BSWuR7tb+scU+7c0MkG?=
 =?us-ascii?Q?1k8jK7h/zp9nMoFerPx1wJhJGrCE6/nT/tT4jhOlOIirMQgosiQd1OGm0P82?=
 =?us-ascii?Q?yoZ2TkmzUvwRcUMZj/1V6gtMn38aavxqJV4djmfNV1ryHd2Pd69rJHnJkZ7f?=
 =?us-ascii?Q?9q8Z3sBjwC16AzuYEVouwDkRJoZU5Uxlo+hxKT/QffPR+f54GDue5oiobev7?=
 =?us-ascii?Q?yFdzjThPdGMtPYtibTCH/O8+ADwIb/C7N3c2VWjr17ick8Zja5Noey9AfVAB?=
 =?us-ascii?Q?w4grF/8NdVDUYiGnlA9NOVPJJ+aLfAxsqdAhwmBN7ChPkDyiYEG3SliJUr6F?=
 =?us-ascii?Q?EZpdYP3oMdX8QWsT0BZsLBc4fcHmYSpTZWmHL/fLmGXhid/oMoezfNPHf0HD?=
 =?us-ascii?Q?OUkK9R0XYEJkKzV90GHfgr9xMl7iX/uW7wNzKiPNIPPU4y7BtXbu91H0dGdt?=
 =?us-ascii?Q?P5ML/kroAluGFjUiINarA0s4ztpIiOKBJnFgICgvcQc3pLb16i8laniqgHRE?=
 =?us-ascii?Q?d82RXt4BC3Vj9KQtOlwG0N2OVAymECGUsmNwTVOTM+Y/jbFFygZOlO10uZjh?=
 =?us-ascii?Q?GvL4m133rTB3wjJBPnvQuVID/9hB9xV5oxesYwnlXnDmqlBLPJ1jx+1UTHFJ?=
 =?us-ascii?Q?vvzTqsPRjxCQcO96qBd4uyyFIVgJWNewyUsle0uAwtZjFL9yJMDYbD9414Hr?=
 =?us-ascii?Q?/5YKEsyyMs3nJ7ypUT1ULMm9LL7WwLJcWbRZRcnYy14BJCUwXpESTrqn126L?=
 =?us-ascii?Q?kj3Y41VpudvtDahyBhsNRxYnsIhUCjUljN2wKxDglBpZeHKiltLj9I0tIYzW?=
 =?us-ascii?Q?CysCLq95Ix3PFmAy02tFK0TMKpHS+BmSKC+KF+VUVEg5mJXTdtM9f0NT0/Et?=
 =?us-ascii?Q?2Ou8JkQE1sVXfH2B1Jz8oHdgwYGNrv7HB6dBbaOaLE0Fc5o4MRpvwuxVzHSy?=
 =?us-ascii?Q?VPd7PEob7DLLTncj04zV+bsiWXDJuIbIjR5lS3CUUvcdNmn1w4XvyOWgojKp?=
 =?us-ascii?Q?qoRVtpLee9lx7SwnBe4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6005a362-ecdb-48ef-29a8-08db94bd911a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 07:36:50.7015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/f97SLVNeepHDMUNKGzepVdScKPQzNpA/Tnvy//4lSnSFfwMHqeXr2xu+cr/bvjx4W1JihaqVl7ZHSL6OhB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Nack to the revert.

This is a whole series of doorbell changes, which has replacement for the p=
atches too.
https://patchwork.freedesktop.org/series/115802/

The whole series was pushed to staging branch, but looks like some of the p=
atches did not merge.
When the whole series is merged, functionality will be restored.

I will check if there is any problem due to which other patches are blocked=
 merge.

Regards
Shashank
-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Friday, August 4, 2023 7:01 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>; Zhang, Y=
ifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: don't modify num_doorbells for mes"

This reverts commit f46644aa8de6d5efeff8d8c7fbf3ed58a89c765c.

THe doorbell index could go beyond the first page for mes queues, this patc=
h breaks the mes self test on gfx11.

[   23.212740] [drm] ring gfx_32768.1.1 was added
[   23.213147] [drm] ring compute_32768.2.2 was added
[   23.213540] [drm] ring sdma_32768.3.3 was added
[   23.213546] [drm:amdgpu_mm_wdoorbell64 [amdgpu]] *ERROR* writing beyond =
doorbell aperture: 0x00001000!
[   23.214148] amdgpu 0000:c2:00.0: amdgpu: gfx_v11_0_ring_set_wptr_gfx: 51=
68 0x402 0x1000 100
[   23.560357] amdgpu 0000:c2:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] =
*ERROR* ring gfx_32768.1.1 test failed (-110)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 5c0d3cea817d..31db526d4921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -140,21 +140,25 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
        adev->doorbell.base =3D pci_resource_start(adev->pdev, 2);
        adev->doorbell.size =3D pci_resource_len(adev->pdev, 2);

-       adev->doorbell.num_kernel_doorbells =3D
-               min_t(u32, adev->doorbell.size / sizeof(u32),
-                     adev->doorbell_index.max_assignment + 1);
-       if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
-               return -EINVAL;
-
-       /*
-        * For Vega, reserve and map two pages on doorbell BAR since SDMA
-        * paging queue doorbell use the second page. The
-        * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-        * doorbells are in the first page. So with paging queue enabled,
-        * the max num_kernel_doorbells should + 1 page (0x400 in dword)
-        */
-       if (adev->asic_type >=3D CHIP_VEGA10)
-               adev->doorbell.num_kernel_doorbells +=3D 0x400;
+       if (adev->enable_mes) {
+               adev->doorbell.num_kernel_doorbells =3D
+                       adev->doorbell.size / sizeof(u32);
+       } else {
+               adev->doorbell.num_kernel_doorbells =3D
+                       min_t(u32, adev->doorbell.size / sizeof(u32),
+                             adev->doorbell_index.max_assignment+1);
+               if (adev->doorbell.num_kernel_doorbells =3D=3D 0)
+                       return -EINVAL;
+
+               /* For Vega, reserve and map two pages on doorbell BAR sinc=
e SDMA
+                * paging queue doorbell use the second page. The
+                * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all =
the
+                * doorbells are in the first page. So with paging queue en=
abled,
+                * the max num_kernel_doorbells should + 1 page (0x400 in d=
word)
+                */
+               if (adev->asic_type >=3D CHIP_VEGA10)
+                       adev->doorbell.num_kernel_doorbells +=3D 0x400;
+       }

        adev->doorbell.ptr =3D ioremap(adev->doorbell.base,
                                     adev->doorbell.num_kernel_doorbells *
--
2.37.3

