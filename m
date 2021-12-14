Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605BFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 07:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3EFF10E815;
	Tue, 14 Dec 2021 07:39:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E482C10E815
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 07:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3cx+NrMAZGbjR5I78BimUDf4zjpkSeAvUVA1+NiSQlErduW6PkUN6WCor0nftSJ0Kqqqi2McICzvkqbdBnMuhrdyNzRzFLvdbiIy7PzGrBG9PnIez8E7TVl7h0fU+Ml6rxjUvv8FFuis1pBiOYkLH2lSfzT1tcSvuHAzCdHQKE/ws6pV28dLOdPxoI3RTbs5BtavsRXdUefJAoFPadwW3kdIzN5hl43oETKzSSmPcd1VzHyhFlYoyDpM6Mg+sXl8sceRhWsccQXDi5Fy2eZPyr4S5EIocLDn0wV6DcJnHJTsc8vvfMW04qthBvNwcbh/gY/7PLw886OFfiok1Pyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ipgUbBrKitDX7IY3u4IDu2iJzdCzwoPTXGvD0EGEOo=;
 b=QzjswaQuDiRX64Faf/0QkUCIL20UWZbu6zSqdWZGhhaenwk0zxjGZVd2w3yonV/UXTFGaN3gQcD5ceMzGYLj2ZaDQ32m8NOSWNNiYlQHCC/+PXzwIhJ1Z6Ur7o5d9IMGoxMBn9pxDGit22U6iK9yS2B68vGRsO8ONq6X6h9zjFrCZ2QVHNkrlwGTKudcbbQeLQUIqKnABONKRRis6NT/gugs6NrxX4gTxCYsnC16oDLmZnpK3TNkBljoFsMPEqHrguIXhET//m90bJTJDYQxFt20qWqCR62CNyuakOoZZxpHrFkIRXoMVGlF/t/Ps2dAPk7kqaGfOUXsvGf6gs8b8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ipgUbBrKitDX7IY3u4IDu2iJzdCzwoPTXGvD0EGEOo=;
 b=FC1o0ugsZF4wR0MiSgp0k0z+L3jr4zhaGaNsOeX8mvHENfsDsno+C5pDM2mke9GEeM+fqt+bge3y3ZKQvDKpoGPYIzi3R5yltU4w7nn/v4A9Zn/y3SmnSI9h36nP/IiRmzazPuMUkFHesw5MsqbK0buGK3547UG8MkcCqinubT4=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 14 Dec
 2021 07:39:33 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::c457:ec1b:7d79:632b]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::c457:ec1b:7d79:632b%6]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 07:39:33 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV
Thread-Topic: [PATCH v2 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV
Thread-Index: AQHX8KG0x54es2EpJkmq9nRKyJe6cawxmi5w
Date: Tue, 14 Dec 2021 07:39:33 +0000
Message-ID: <DM4PR12MB50721BBE98EAED2AF53C88F9E1759@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20211214041751.23647-1-Jingwen.Chen2@amd.com>
 <20211214041751.23647-2-Jingwen.Chen2@amd.com>
In-Reply-To: <20211214041751.23647-2-Jingwen.Chen2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=be7bcf65-ee31-49fa-b19f-fbec3cefadb7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T07:39:26Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 563b57d6-7679-42a1-dcd4-08d9bed4df5e
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_
x-microsoft-antispam-prvs: <DM8PR12MB54803CF72B9189FEB2F85F1BE1759@DM8PR12MB5480.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTVquQHMhgPvDYlZqN3CwQBKMuMb3tZ01YCpIncBd0EX9nv9g/TpCkUqlThBdIGOuMz1riZqQIv4tJ8BSAu0bFCcIwlAQxWFT7/vzw8OMoAw4J4KAyuMYUvte2H9HHRdIT4eOWjbQCEuuP+gjd49zgK5fCiJAGveOWhy5EEc3fSYMCMFp+ZfEVV8IOr32hDd/5j9LFS2yE1vpIpYlM1wW5jx7P2UWn7W/IQmEsFpkIR6aiCINsn9C8tFf8xZ6kdHWg7GZGgMIsx/c8U9p1jZm9ig9Tgnp+T5M/RN0kAse8FpR5hk3PkF5QrewuGGpjp+1zu42atledBI7oCOzH5FDeJSIvGSgPrtAbg6+f54vet8nFKULPU3P0qOV+9b4Vh6alnn7xre1Kq9J+6Zyu1+ORjSdzwRVBXGAKvzHB4t+wyoQMpIZitqHgvBz4+TkwumlZTrjjm6i/wG4Fxx5zfF6Zi8rt42McFymZqOm7jBbKvHPjfs9mKVDB6pTqWdGGkyA+pe3IrMeMiJu3abMGS60D5gzEdwoqYTD9haOouCX4zirk4uTR/V0NrLj1cfrC15s4o7VFfMzTkD72lk1RrwDYVMUQnrOsli2vr0i5CsA8bam1l7gcfGiaUCTkEJyku53mLMUnT/al4Cw31N/2aZ7YOE8ZMQwpVWXpQZT+m3GfhGwsdrOyVi9V3F70Egk1hAJ9ef2OrZT9TjJEJR6P8LVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(8936002)(76116006)(5660300002)(66946007)(38100700002)(2906002)(6506007)(7696005)(33656002)(66476007)(110136005)(66556008)(64756008)(66446008)(53546011)(4326008)(316002)(26005)(83380400001)(55016003)(122000001)(71200400001)(186003)(9686003)(52536014)(38070700005)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aT1PrMf9PFWX4qVTOtW2WHeWXf1dgk763m7xgv+gsY2xF6mho+7tyEQXJGES?=
 =?us-ascii?Q?/SKqU4HNiOVLtg1YXecS2zMHEYbwk0V8Mls6aMWwTp6YcV2hSFUoLXF5c/jL?=
 =?us-ascii?Q?Fd7Szdfp/WPiE3j42ZQaAYti7m+05I7zFYPSXblTw/+1NsRhDP61wRMRTvDn?=
 =?us-ascii?Q?gYsdC3fmY7KaO+JeK9HRPB3m3xJ0AgQ2budIf79HeWXN/wP8Bejd89GikMHZ?=
 =?us-ascii?Q?vpfMlV4H5xOAfCNFJlYF36Ohtz94/KlmXsLVXmJfz/XQ7hlx8D/2nJh4SOH+?=
 =?us-ascii?Q?8ajEeLRV6ED3vz9wMscd2COoIo8MlUpAf4fkS+SDAQ8DqQxMnMX2ab/5DPjj?=
 =?us-ascii?Q?V6lonye3X7nNGwdC2cSnfbZUCu4M0y6ibRdSAOs3pRkjbwL8pw60VszOkZ8T?=
 =?us-ascii?Q?/VMYGIsJoWqHfk3ui8/AJABdh3uK5F2XjRPV2yGcRwys1QoZdnY0eE7fa2/2?=
 =?us-ascii?Q?0LPe/WjxLFyNQsyYKuMIk8rAy/0dBkQOAL72/mxAOzvZTcRMb7MP/cBJTymz?=
 =?us-ascii?Q?+y7c12jaetiXe1Tz11xNsg/5DiWV3uzXXQRfgwG+cUxLcncy9KXooWHEUbcR?=
 =?us-ascii?Q?JwVROGf11nfo3/beIW/JMVMoZUeDE9FJ/XyUG1SFMc3x5NTfFeaO8yIAjx84?=
 =?us-ascii?Q?7O/eGLLPMjRm9iu55xfcoujgjcs+yWbdAx1Uf38TMkRGgSqYaU6rOgtvwa/5?=
 =?us-ascii?Q?Wibp6z5nmmTMY4i2pKCROFeT2C7mmmlzrUIsiS1HSqn0GzETIXxzfrf/rGxS?=
 =?us-ascii?Q?DLS74r5/UKnrpXRPxly5XJGRoghJdmwdOHi1S1jH8V3RXUJR+9yI/hfICjZl?=
 =?us-ascii?Q?FPGnianWdVUtw/eyPjAqsivKHp4Pnod0JsLMwOln/2UJSqLxGpruTqP5beCE?=
 =?us-ascii?Q?dpyHlPV7PQTgyzeEHdIZM7DsaJyQOs13RrjxAx653ZpcXKUx0ZrRAel/p9ZL?=
 =?us-ascii?Q?OIti9hLJpEtiC2dW842uqmq47iu5m802mB9NrCbzfWDZY+N0kD9XdM7hX0X+?=
 =?us-ascii?Q?59XWhdWUBu7/E+RyVI0TBJWS77E9bTH1nVkrDJO8lc15hQm5Is5wfxpeHbHS?=
 =?us-ascii?Q?5qmxIOoI3TaxcoWR4rpxrThgJihzVMNLi+2bjq2vviBpTsCzDDtTWAYL334o?=
 =?us-ascii?Q?YhhaocNmPX94pExUypxylOGUbbGvRevH2KxkidlaRslpTp3O/q2Ld4S8vKrl?=
 =?us-ascii?Q?u2L5tCSIg82snY+ydXdt5YJ+oaGjzRl+uL3uTEAANEMmHT3/4Fz/o53llcro?=
 =?us-ascii?Q?9ROt3xbN8Ug27R4qkF8WoI3t+wihhDS2AXg7ABTiXdWWyLoxzOuC0y24zMaX?=
 =?us-ascii?Q?gxCEA8AGBwrEJ8z7bJHGqsbuEZaq+h07iaYM+JYIEyrZmbl/6E2b+W/8oLX8?=
 =?us-ascii?Q?rCu5KK8dL9Kp8iLkzmL+W/xYF1I/z2ivqb4iUKAuahbE5d5j9C4u6ZEea15q?=
 =?us-ascii?Q?BJz4ufuq11KfzMF7qJIe/vQT19cmAm0FVufld+0Ic19956Y5uNg+3sOSwroo?=
 =?us-ascii?Q?iN7nLsfhGKf5lUTuGZfH6ggTEFrF5ywowSLgup+PJSsOjQ2IuO8Pw+qA9yem?=
 =?us-ascii?Q?YDa2OFKdpOtNZdVw0ck=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563b57d6-7679-42a1-dcd4-08d9bed4df5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:39:33.7913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrQADbPY0531LzQo6khbyGORd3xwcPzNkwulwlieHemMGvKF1phhbtNrZs/FbYf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: Chen, JingWen <JingWen.Chen2@amd.com>
Sent: Tuesday, December 14, 2021 12:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Chen,=
 JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH v2 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV

[Why]
gmc bo will be pinned during loading amdgpu and reset in SRIOV while only u=
npinned in unload amdgpu

[How]
add amdgpu_in_reset and sriov judgement to skip pin bo

v2: fix wrong judgement

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 4 ++++  drivers/gpu/drm/amd/amdgp=
u/gmc_v9_0.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index d696c4754bea..ae46eb35b3d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -992,10 +992,14 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device=
 *adev)
                return -EINVAL;
        }

+       if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
+               goto skip_pin_bo;
+
        r =3D amdgpu_gart_table_vram_pin(adev);
        if (r)
                return r;

+skip_pin_bo:
        r =3D adev->gfxhub.funcs->gart_enable(adev);
        if (r)
                return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index db2ec84f7237..d91eb7eb0ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1717,10 +1717,14 @@ static int gmc_v9_0_gart_enable(struct amdgpu_devic=
e *adev)
                return -EINVAL;
        }

+       if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
+               goto skip_pin_bo;
+
        r =3D amdgpu_gart_table_vram_pin(adev);
        if (r)
                return r;

+skip_pin_bo:
        r =3D adev->gfxhub.funcs->gart_enable(adev);
        if (r)
                return r;
--
2.30.2

