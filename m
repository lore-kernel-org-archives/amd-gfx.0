Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BAEC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 06:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAB910E07F;
	Tue, 25 Mar 2025 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUr0Ap/m";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD85A10E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 06:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmU+AhAZiHWTNH7Fd9gX6AE4Rpmio+4wFUdTEoqfbAsWcKw8s0+QyM4wl40N0Ap9frqy1aoa6AW6d96edk7X7ZE6eZcya3+LMqesJ9CiNHxM0hhhjtm0gH2XQidpnomezSjF3oAKW5T6LplvtPId37ZDDnQdxlInA5W94Vy1Q7NZiyj9GByGwgMut/IFVZbEJRMGoYUOS6App7gs6OGAGg2/auLLZ7EUufsEW+W74SMJjltuTckEMgGxzT8wocbqoHPUgIr0jw5N8TueEyhVxCDWOb7Ca2fpO6cHobubj5Ev0liCmlQIFmS3tKCO9MAZfFACAWj3WfVCMKmZ5Ppxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kXqdrVa0TvqgzQt/O8jYaHcSUnldSIRvarmlm1YHnY=;
 b=nzRDSwNCK6GKThr4Bj4NcqoIQmf7Y5s42kXd2LtaOEhxmojYg8da5hkTRcjcsiMJ07nHzarUcuxbACiQtpPXloT7d1GSGFSQFAGr+Rzur53vdCWQXFK2ol+evSrvpHMv04g1/C9fUJC2FTJs/Y3F4NZQWO0a/+fjoTWTBGQBG59YQ8ZYrJOmHdDYV7XI7kg75tXSylFiM2cXYdsbRHn+6I+j7Uze5l5leSuYW5Adop9S1QuqLRpt98MtMOnwXKIuuSwsneoAqbgDRYVSNr7rao8m3uLDCHOUqebGQZ0712PC1v8B9/4M0EEfV6S4N/gHQ8vlngKmxiTYec4YW/iBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kXqdrVa0TvqgzQt/O8jYaHcSUnldSIRvarmlm1YHnY=;
 b=yUr0Ap/mKiIEMHNBo6YZqW699q9ne0WqgAlNCsF+WK3DABnhKueqjoDE3xO0qpAvgoVrYApXUW1p72TdRmCXjbV8JuT5Or38YrrSOzOrkleWvUdGO8bNYY1dFool01igBK/q7sBZXQLfyZ5+H2ngk4iNrKRxAz4lEbfGFcAMPYU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 06:41:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 06:41:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Parse all deferred errors with UMC aca handle
Thread-Topic: [PATCH] drm/amdgpu: Parse all deferred errors with UMC aca handle
Thread-Index: AQHbnMcQXYOBcwrQfEyJah4RQk8PcrODaBlg
Date: Tue, 25 Mar 2025 06:41:56 +0000
Message-ID: <BN9PR12MB5257EF927A14583D85C1EBCBFCA72@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250324141415.36174-1-xiang.liu@amd.com>
In-Reply-To: <20250324141415.36174-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0ea70704-ff4f-493d-8ded-86d5ada3cffa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-25T06:40:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: 95dd7dec-6a64-4820-6639-08dd6b68230f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XHf/jEQsBSiyy+y/L75viktNq1tfb3M54aUISAmsyGvyzuH2KOJvj9Y8M15z?=
 =?us-ascii?Q?iUMgCnyoiFrnfRSPrv7pf5CvupAkZBahcrb4QO6Dx3tOvYQgVP/Z92PPGx/a?=
 =?us-ascii?Q?VIB3DnkTsyWVM0MiWrMK7l9gsf913BWeHwCYtVxdvvxnCie2+r5KeQxrv7ea?=
 =?us-ascii?Q?U7josoRkl95ZUqMKHQlwnuVDHnEaQ8vUPkyLNU9qBOYXvGyiIo6OUGhxyqkN?=
 =?us-ascii?Q?TRZ/Bj1Ebz+mPnDiOUq6azFOaxgUBgX1kqYlJefckFntZMnTKdn3RQiMS33g?=
 =?us-ascii?Q?XQnaj3IC2RRR0sP8lc+rOTHfaz/VVRlS3XuXEN8YQ/7s0k/ZPVaM0TP9EILQ?=
 =?us-ascii?Q?XlmXXb5T4UFvA8p8+0lkzRVBVoRVAJUZsusFZph/yotNWHjY5dUhU0aSzO6W?=
 =?us-ascii?Q?WCu2Ux6LvW3cCMWU17p5vN50f1BiS+WNIiwEEYlt1UXTAmUfWqjvh/qn0fUp?=
 =?us-ascii?Q?hk0HMqI5I5ZASIYGM7U+nP0oLw7oHB7A+NA4b7DfAHyzzP+gIriiyDo+ptKb?=
 =?us-ascii?Q?EXZtcq23mIS7w9P6GsY0I3tozFNH6fXzlCBC3d7ntZ7CBuf25hgMHjuJQu99?=
 =?us-ascii?Q?2VK6SiyDLeKmt6WzANc5pFTb1KxWYKX5EFTiMZywrwwK+VBZlHaSaYb14oqe?=
 =?us-ascii?Q?HRGDLA7cuBCnq14hNzeRwPQ9yucGciFv2iDZFClH8Q6CbmtLH+m9kui6hnHQ?=
 =?us-ascii?Q?V/R2y1rQDwgAoktNFELgMCJ6VEPQEc0p7B1IRg649VUZf9yGGQFLnBiwi97a?=
 =?us-ascii?Q?8I3DXioBuCdXqKLroyUHEUl19byeQzuaPmSnVf9FVKmqPJwveY0yoa76+yVT?=
 =?us-ascii?Q?rIXuTIwu/pvTx8TuAD5K91aO5AYwXavljB3i/lpPEG3TyYfQHONTlIs+a3Q5?=
 =?us-ascii?Q?LXf3TZ4QlT/c9XtGVj1hBLp5fhhXDVU7vso5yx6PMxMmpLeoqIwoQt6Gc+10?=
 =?us-ascii?Q?4VQHlZhJa/LR/iSrNWYNhysN/m2zn8jfoOo9newF8XzrEVu98/XoQkXegD62?=
 =?us-ascii?Q?mmaDyFs7fAT3ECDUOgXE2LNNtt/m/j1dDpEYwLSvuCBVSRraITcjcdOoGZed?=
 =?us-ascii?Q?rZks9X9enKD75TGIkYJ6EHlP/23wNEfv3+FoAtTSrnkM249d3UB7BS48H4FZ?=
 =?us-ascii?Q?+QYADSTpFQDGU5ilGbg98y6I4mnTTua6Ld6SIqnI4+DmMvIad3X9jkaPHaVR?=
 =?us-ascii?Q?9/GCcL9YqkV6bHldscRkkFIKNptHhiTEC+qIMm8xKc0B5E6k6t7DrXDETX0S?=
 =?us-ascii?Q?dp91zEZ04UeZ8zoBCoUf0upzi4Zt8hp9wFfLxGgE6k1KTKxRLdfgZWI+HXaO?=
 =?us-ascii?Q?7QmKorTQKMwqtg3Rw+gsBIvwVwyvBB7ggmHCVvf8VljG8IS/7lNCUOSqQ2K8?=
 =?us-ascii?Q?ZnmgR20dMd4QkEgRlzKSKX6qKC5SpOEKKhCxPYEJ03ys8TQHpdAQk6bwJ5lJ?=
 =?us-ascii?Q?2rbuHHagK7GEebRO/jNPIMoFH3P/5bh5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZucpM1+DryURJxg6YdGd5MPQ8esZXD/EJIe7s8bndAxfcf1uVsCDjGSEW+7H?=
 =?us-ascii?Q?jD4rJi5UFHlEEPS4wZAN5h7wUoU2qHHOzRFHX8XxeYdTyKFtvXnLOC02Qsfc?=
 =?us-ascii?Q?5lfeWGcKyMi62yk7yE9GHzd6xB959v3yxq66XKTXAuW0yqHRz3XR/j0EuGIZ?=
 =?us-ascii?Q?CFclzsI91Mfk8OHRVHDfxXRokpYiyOH5O8QIWTNic7OeSgZ08FYzMj1vhZPB?=
 =?us-ascii?Q?MCXJMpXNEzXMo/FfWUFjihfg0/dG1jk8V5ZPq1xNVuBsh5xLJcYRmRGlwGCd?=
 =?us-ascii?Q?/awQYQl7MAPtJUhShj7SfgLrsmpS0/b1zRns4QbkRobKgWkRqIWm6RrbEgMt?=
 =?us-ascii?Q?8axr2gbAY/6JnrlO0P5kHmOnu1M/B6DT2i6P3f4D+IYGxAunhXofjhBL3s5l?=
 =?us-ascii?Q?Om50sDuyGn7bQdPDYT5q9I5LK6RPMv2AoyWd5rrhSWlXfLCo9rrWoc6e0HQZ?=
 =?us-ascii?Q?nh5Hux36UC6rVAZmDSK+6hE1w1BEJa3ueiksK/UioJqudqkS+aUDh++TqMIB?=
 =?us-ascii?Q?7dqW2fAXB71Gx22Qb7OnsNcoNVt1sUvuZrTBMMgaNJ55/Q3FVgDQQ4pz27LJ?=
 =?us-ascii?Q?FaMYWbPiFfISyVTS8xrGtBSXEigy7YJs4iLjtWD++YpsQ8+A1vtckRGpR6uI?=
 =?us-ascii?Q?Gy9Y9xgNOk8W8ojs+/3jE6MDrucwCP9a1Tuwu1TUlval+t7O3vZkjDIFraJ6?=
 =?us-ascii?Q?477jMeGvXwuGl4E0VUd8pAe1a4YeuAjed8F2Ow43XUR7Xw+6g7xsoGXsroN4?=
 =?us-ascii?Q?26FQveqaKv8GMf1kTWee0NCyVHpQ6Y0alZanmk4GnQUpkANhyLAVyd/ojEh6?=
 =?us-ascii?Q?fBfpAhKy6T5c2wEG4rSYagduUASQxUPVI32iUUP5K9elsN9MYEbutBOgb0Sv?=
 =?us-ascii?Q?RSFM5/FULNPu5jklPvSqwBGHgy6JK+zwWGhN4sWvcrl8Bj1RtYlEOBhwvmpA?=
 =?us-ascii?Q?0a6ixiiBakMoH05zYkS6efdGtr2vU9e2X7fWKLyTYYtJVg8hugLpeIyP3CBp?=
 =?us-ascii?Q?H3K1I/X5IHlMEdn9cqQYaDYal6qCPswkxFKY+W3UptCA/KaEvsS2L1KFI09R?=
 =?us-ascii?Q?tkEvlOsqe37uj1eEDQg/rFP33ZRJVmCT3brGe2U/jbX/fusoPGgO4i9Wi7Sv?=
 =?us-ascii?Q?pV4zj9ni0WHeOuuUuBOx3KaBXn9n/XAkyMKsc1AXiLeJ8UuR8RvJN7LhXVaB?=
 =?us-ascii?Q?d23j6TkF0vh27s6TzipG1n0vceokdySKbeTjPBJzWmsRNvBiysa+veeGQDeR?=
 =?us-ascii?Q?kM5Wke9hUVCSXiyaL01CvlFTd3oZoltyDvzdDyY1QfECdwy699R1LbIFJYlV?=
 =?us-ascii?Q?RxTQd/ec7y9dSCA2uhm9YUt/b7FTaXbXuwlYjEKaUfiZViiQewl2xRbrj1z6?=
 =?us-ascii?Q?2G2TJCMX5cR2JoBiWr9IShU3JMdzbU+Js4PZRYSnAlHYTjxIopx0Yotljctb?=
 =?us-ascii?Q?2hcPj/IK7Pb+uLz7EV/OBot86evHSMoLTpTmXES1KDDlayn7EOa3A7A8SxE6?=
 =?us-ascii?Q?CJClP30MCwIpDivcOd87uVqNBvyL+pBb1R8y2oBJ4G6Vb/5mw95l+VACNKe6?=
 =?us-ascii?Q?Ecra5oBefXZLpMz/b+EwOxs5PA5CEauAcr/jaRDQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dd7dec-6a64-4820-6639-08dd6b68230f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 06:41:56.4833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2sAebkJKqKNQ9RK+3dpBS5RQ3jrTR86ixpLtOdHrvI9KZu6X9ziMc+6cHpGatR6HbINhrGjiFykL9HdGYXtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Monday, March 24, 2025 22:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.=
com>; Yang, Stanley <Stanley.Yang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Parse all deferred errors with UMC aca handle

We should only increase the deferred errors in UMC block.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c  | 4 ++++  drivers/gpu/drm/amd/amd=
gpu/amdgpu_aca.h  | 8 --------  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | =
2 +-  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 8 +++-----  drivers/gpu/dr=
m/amd/amdgpu/jpeg_v4_0_3.c | 2 +-  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c =
 | 2 +-  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 2 +-
 9 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index dc47f5fd4ea1..b4ad163f42a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -195,6 +195,10 @@ static bool aca_bank_is_valid(struct aca_handle *handl=
e, struct aca_bank *bank,  {
        const struct aca_bank_ops *bank_ops =3D handle->bank_ops;

+       /* Parse all deferred errors with UMC aca handle */
+       if (ACA_BANK_ERR_IS_DEFFERED(bank))
+               return handle->hwip =3D=3D ACA_HWIP_TYPE_UMC;
+
        if (!aca_bank_hwip_is_matched(bank, handle->hwip))
                return false;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.h
index 6b180f1b33fd..38c88897e1ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -80,14 +80,6 @@ struct ras_query_context;
        (ACA_REG__STATUS__POISON((bank)->regs[ACA_REG_IDX_STATUS]) || \
         ACA_REG__STATUS__DEFERRED((bank)->regs[ACA_REG_IDX_STATUS]))

-#define ACA_BANK_ERR_CE_DE_DECODE(bank)                             \
-       (ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
-                                         ACA_ERROR_TYPE_CE)
-
-#define ACA_BANK_ERR_UE_DE_DECODE(bank)                             \
-       (ACA_BANK_ERR_IS_DEFFERED(bank) ? ACA_ERROR_TYPE_DEFERRED : \
-                                         ACA_ERROR_TYPE_UE)
-
 enum aca_reg_idx {
        ACA_REG_IDX_CTL                 =3D 0,
        ACA_REG_IDX_STATUS              =3D 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index be426542c1ae..af62688d34bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1134,7 +1134,7 @@ static int xgmi_v6_4_0_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                break;
        case ACA_SMU_TYPE_CE:
                count =3D ext_error_code =3D=3D 6 ? count : 0ULL;
-               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
                ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type, count);
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index e84238336fb6..ff77f59a1499 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -893,15 +893,13 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,

        switch (type) {
        case ACA_SMU_TYPE_UE:
-               bank->aca_err_type =3D ACA_BANK_ERR_UE_DE_DECODE(bank);
+               bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
                ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type, 1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
                ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type,
-                       (bank->aca_err_type =3D=3D ACA_ERROR_TYPE_CE) ?
-                               ACA_REG__MISC0__ERRCNT(misc0) :
-                               1);
+                                                    ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
        default:
                return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index a758f0889d29..41afabd812d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1290,7 +1290,7 @@ static int jpeg_v4_0_3_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
                ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index a54e7b929295..84cde1239ee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -751,7 +751,7 @@ static int mmhub_v1_8_aca_bank_parser(struct aca_handle=
 *handle, struct aca_bank
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
                ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_4_2.c
index 2c659470946c..c1c59637bd51 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2397,7 +2397,7 @@ static int sdma_v4_4_2_aca_bank_parser(struct aca_han=
dle *handle, struct aca_ban
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
                ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 74f57b2d30a5..0e404c074975 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -85,7 +85,8 @@ bool umc_v12_0_is_deferred_error(struct amdgpu_device *ad=
ev, uint64_t mc_umc_sta

        return (amdgpu_ras_is_poison_mode_supported(adev) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
-               (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Deferred) =3D=3D 1));
+               ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0,=
 Deferred) =3D=3D 1) ||
+               (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Poison) =3D=3D
+1)));
 }

 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t=
 mc_umc_status) diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/driv=
ers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 20f47947e894..1e4ec8f07896 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1940,7 +1940,7 @@ static int vcn_v4_0_3_aca_bank_parser(struct aca_hand=
le *handle, struct aca_bank
                                                     1ULL);
                break;
        case ACA_SMU_TYPE_CE:
-               bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
+               bank->aca_err_type =3D ACA_ERROR_TYPE_CE;
                ret =3D aca_error_cache_log_bank_error(handle, &info, bank-=
>aca_err_type,
                                                     ACA_REG__MISC0__ERRCNT=
(misc0));
                break;
--
2.34.1

